#!/bin/bash
# CRONet Emergency Deployment Script for Raspberry Pi

sudo apt update
sudo apt install -y python3-pip gnupg dnsmasq

pip3 install flask python-gnupg

mkdir -p ~/cronet_dropbox
cp whistleblower_dropbox.py dod_public_key.asc ~/cronet_dropbox/
cd ~/cronet_dropbox

# Set up DNS override for .carrot
echo "address=/relay1.carrot/127.0.0.1" | sudo tee /etc/dnsmasq.d/carrot.conf
sudo systemctl restart dnsmasq

# Auto-start dropbox app on boot
(crontab -l ; echo "@reboot cd ~/cronet_dropbox && python3 whistleblower_dropbox.py") | crontab -
