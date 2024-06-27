#!/bin/bash
clear
trap 'echo "  nice try  "' SIGINT   
trap 'echo "  nice try  "' SIGTSTP
trap 'echo " nice try "' SIGQUIT
set +m

random_number=$(shuf -i 100000-999999 -n 1)

echo "$random_number" >> /home/eshaan-deshmukh/private/list
cd ~/private
git add --all
git commit -m "message"
git push

center_text() {
    local text="$1"
    local termwidth=$(tput cols)
    local termheight=$(tput lines)
    local textwidth=${#text}
    local x=$(( (termwidth - textwidth) / 2 ))
    local y=$(( termheight / 2 ))
    tput cup $y $x
    echo -n "$text"
}

center_cursor() {
    local termwidth=$(tput cols)
    local termheight=$(tput lines)
    local x=$(( termwidth / 2 ))
    local y=$(( termheight / 2 + 1 ))  

    tput cup $y $x
}

while true; do
    clear
    center_text "locked down, password:"
    center_cursor
    read input
    
    if [[ "$input" == "$random_number" ]]; then
        echo "Confirmation received. Exiting..."
        exit 0
    fi
    if [[ "$input" == "hint" ]]; then
        center_text "check private github repo: codes"
    fi
done
