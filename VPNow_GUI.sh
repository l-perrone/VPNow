#!/bin/bash
#export DISPLAY=:0.0
#To run as sudo on wayland run "xhost +" first
#xhost +
options=($(find -maxdepth 1 -iname "*.ovpn"| xargs -0))
i=0
declare -A arr
for opt in  ${options[@]}; do
	key=($(printf $opt | sed s/.ovpn//g |cut -c 3-))
	arr[$key]=$opt
done

ans=$(zenity  --list  --ok-label="Select" --cancel-label="Exit" --text " " --title "___________________VPNow___________________"  --width=400 --height=400 --column "VPN" $(printf '%s\n' ${!arr[@]})  2> /dev/null);
case $? in
	0)	ENTRY=`zenity --ok-label="Connect" --title "Authentication" --password --username  2> /dev/null`
		touch .tmp
		username=`echo $ENTRY | cut -d'|' -f1`
		password=`echo $ENTRY | cut -d'|' -f2`
		openvpn --config ${arr[$ans]} --auth-user-pass <(echo "$username"$'\n'"$password")
    ;;
	1)	echo " "
    ;;
esac 
