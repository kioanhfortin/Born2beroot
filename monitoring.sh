#!/bin/bash

printf "#Architecture: %s " $(uname) && printf "%s " $(uname -mr)
printf "\n"
printf "#CPU physical : %d " $(lscpu | grep "CPU(s):" | head -n 1 | cut -d: -f2)
printf "\n"
printf "#vCPU : %d " $(cat /proc/cpuinfo | grep "cpu cores" | cut -d: -f2)
printf "\n"
printf "#Memory Usage : %d/" $(free -m | grep Mem | awk '{print $3}') && printf "%.0fMB " $(free -m | grep Mem | awk '{printf $2}') && printf "(%.2f%%)" $(free -m | grep Mem | awk '{print $3/$2}')
printf "\n"
printf "#Disk Usage : " && printf "%s/" $(df -h | sed -sn '4p' | awk '{print $4}' | cut -d'G' -f1) && printf "%s " $(df -h | sed -sn '4p' | awk '{print $2}') && printf "(%.2f%%)" $(df -h | sed -sn '4p' | awk '{print $4/$2 * 100.0}')
printf "\n"
printf "#CPU Load : " && printf "%.2f%%" $(top -bn1 | grep 'load' | awk '{print $12}' | cut -d',' -f1)
printf "\n"
printf "#Last boot :" && printf " %s" $(last shutdown | head -2 | awk '{print $4, $5, $7, $6}')
printf "\n"
printf "#LVM use : %s " $(lsblk | grep lvm | awk '{if ($1) {print "yes";exit;} else{printf "no"} }')
printf "\n"
printf "#Connexions TCP : " && printf "%s " $(netstat -s -t | sed -sn '6p')
printf "\n"
printf "#User log : %d" $(who | cut -d' ' -f1 | sort -u | wc -l)
printf "\n"
printf "#Network : IP %s " $(ip a | sed -sn '9p' | cut -d'/' -f1 | cut -d' ' -f6) && printf "(%s)" $(ip a | sed -sn '8p' | cut -d ' ' -f6)
printf "\n"
printf "#Sudo : %d cmd" $(grep -a COMMAND /var/log/auth.log | wc -l)
printf "\n"