#!/bin/bash
chemin1=dossier du ftp
chemin2=/etc/vsftpd/vsftpd_user_conf/
read -p "New user: " user
echo "Le nouveau user sera:$user "
sed -i "1i$user" /etc/vsftpd/login.txt
read -p "Password for $user: " password
echo "Le password pour $user sera:$password"
sed -i "2i$password" /etc/vsftpd/login.txt
read -p "Chemin apres ftp pour $user: " dossier
echo "$user sera chroote dans: $chemin1$dossier"
exec >>"${chemin2}${user}"
echo "local_root=$chemin1$dossier
anon_world_readable_only=NO
write_enable=YES
anon_upload_enable=YES
anon_mkdir_write_enable=YES
anon_other_write_enable=YES
virtual_use_local_privs=YES
local_umask=022
anon_umask=022"
mkdir "${chemin1}${dossier}"
chmod 777 "${chemin1}${dossier}"
sudo db4.7_load -T -t hash -f /etc/vsftpd/login.txt /etc/vsftpd/login.db
sudo chmod 600 /etc/vsftpd/login.*
exit 0;

