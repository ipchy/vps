#!/bin/bash
# Athor ipchy@live.it
# Tested on BandwagonHost & VirMach openvz vps server
# VirMach aff https://virmach.com/manage/aff.php?aff=121
# BandwagonHost aff https://bandwagonhost.com/aff.php?aff=3974

# color
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

set -e
# Update source list and system
echo -e ${green}Update source list and system${plain}
sleep 1
apt update && apt upgrade -y && apt-get clean all && history -c
# Set the time zone to Asia / Shanghai
echo -e ${green}set timezome to Asia/Shanghai${plain} 
mv /etc/localtime{,.bak} && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# Modify the SSH port and Set up SSH-key
echo -e ${green}change ssh port and set ssh-key${plain}
read -p "Please input ssh port:" ssh_port
read -p "Please input ssh-key:"  ssh_key
sed -i "s/Port \(.*\)/Port $ssh_port/" /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
mkdir ~/.ssh && chmod 700 ~/.ssh 
echo "$ssh_key" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
echo -e ${green}Please relogin you system by ssh${plain}
service ssh reload