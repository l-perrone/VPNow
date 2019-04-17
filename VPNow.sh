#!/bin/bash
printf " _    ______  _   _					\n"       
printf "| |  / / __ \/ | / /__	_      _	\n"
printf "| | / / /_/ /  |/ / __ \ | /| / /	\n"
printf "| |/ / ____/ /|  / /_/ / |/ |/ /	\n"
printf "|___/_/   /_/ |_/\____/|__/|__/		\n"
printf "_______________________________________\n\n"

prompt=$'\nSelect:'
options=( $(find -maxdepth 1 -iname "*.ovpn"| xargs -0) )
PS3="$prompt"

select opt in "${options[@]}" "Quit"; do 
    if (( REPLY == 1 + ${#options[@]} )) ; then
        exit
    elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo  "You picked $opt which is file $REPLY"
        break
    else
        echo "Invalid option. Try another one."
    fi
done    

ls -ld $opt
openvpn --config $opt 2> /dev/null
