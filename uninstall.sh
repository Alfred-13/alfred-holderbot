#!/bin/bash

clear && echo -e "\n\n\n      Start uninstalling the Holderbot!     \n\n\n\n\n\n" && sleep 3

clear && echo -e "\n      Stopping running processes...\n\n" && yes '-' | head -n 50 | tr -d '\n\n' && echo

processes=("python3 holder.py" "python3 holderbeta.py" "python3 node_status_checker.py" "python3 monitoringbeta.py" "python3 monitoring.py" "python3 expired.py" "python3 limiteder.py")
for proc in "${processes[@]}"; do
    if pgrep -f "$proc" &> /dev/null; then
        proc_name=$(echo "$proc" | cut -d ' ' -f 2)
        echo -e "Stopping existing $proc_name process...\n"
        pkill -fx "$proc"
    fi
done

clear && echo -e "\n      Removing directories...      \n\n" && yes '-' | head -n 50 | tr -d '\n\n' && echo

directories=("/holderbot" "/holderbeta" "/holder" "~/holderbot")
for dir in "${directories[@]}"; do
    if [ -d "$dir" ]; then
        echo -e "Removing $dir directory...\n"
        rm -rf "$dir"
    fi
done

clear && echo -e "\n      Removing crontab entries...      \n\n" && yes '-' | head -n 50 | tr -d '\n\n' && echo

cronjob="@reboot sleep 20 && /bin/bash ~/holderbot/restart.sh"
crontab -l | grep -vF "$cronjob" | crontab -

clear && echo -e "\n      Holderbot has been uninstalled. \n        You can find us in telegram with @ErfJabs" && yes '-' | head -n 50 | tr -d '\n\n' && echo && sleep 2
