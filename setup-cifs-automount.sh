#!/bin/bash

sudo tee /etc/systemd/system/mnt-downloads.mount > /dev/null <<EOT
[Unit]
Description=Freebox download folder
After=network-online.target
Wants=network-online.target

[Mount]
What=//192.168.1.254/disk/Téléchargements
Where=/mnt/downloads
Type=cifs
Options=username=freebox,password=mypassword,uid=1000,gid=997,iocharset=utf8,file_mode=0777,dir_mode=0777,vers=1.0

[Install]
WantedBy=multi-user.target
EOT


sudo tee /etc/systemd/system/mnt-downloads.automount > /dev/null <<EOT
[Unit]
Description=Auto mount Freebox download folder
After=network-online.target
Wants=network-online.target

[Automount]
Where=/mnt/downloads

[Install]
WantedBy=multi-user.target
EOT


sudo systemctl daemon-reload
sudo systemctl enable mnt-downloads.automount
sudo systemctl start mnt-downloads.automount
ls /mnt/downloads
