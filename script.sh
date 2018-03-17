#!/bin/bash 

echo "Checking for preexisting services"

sep="-----------------------------";


cd /etc/init.d;

#	for i in $(ls -1); do if [[ "$i" = "apache2" ]]; then echo "Detected $i "; fi; done     method1
#method2 with case

for i in $(ls -1);
do

case "$i" in

apache2) echo $sep;
echo "Service identified :Apache2";
#echo "Hello";
#echo $sep;
a=`stat /etc/init.d/apache2  | grep -oP "(?<=File:\s\').*(?=\')"`;
echo "Service  : $a" ; 
b=`stat /run/apache2/apache2.pid | grep -oP "(?<=File:\s\').*(?=\')"`;
echo "Current status  :  $b"; c=`cat /run/apache2/apache2.pid`; echo  -e "Pid details : $c";
echo " ";
echo "Version details";
sudo apache2 -v;
echo $sep;
;;


nginx) echo "Service identified :Nginx"
a=`stat /etc/init.d/nginx  | grep -oP "(?<=File:\s\').*(?=\')"`;
echo "Service  : $a" ; 
b=`stat /run/nginx/nginx.pid | grep -oP "(?<=File:\s\').*(?=\')"`;
echo "Current status  :  $b"; c=`cat /run/nginx/nginx.pid`; echo  -e "Pid details : $c";
echo " ";
echo "Version details";
sudo nginx -v;
echo $sep;
;;



mysql) echo "Service identified :Mysql"
a=`stat /etc/init.d/mysql  | grep -oP "(?<=File:\s\').*(?=\')"`;
echo "Service  : $a" ; 
b=`stat /run/mysqld/mysqld.pid | grep -oP "(?<=File:\s\').*(?=\')"`;
echo "Current status  :  $b"; c=`cat /run/mysqld/mysqld.pid`; echo  -e "Pid details : $c";
d=`stat /run/mysqld/mysqld.sock.lock | grep -oP "(?<=File:\s\').*(?=\')"`; if [[ "$d" = "mysqld.sock.lock" ]]; then  echo "Mysql Lock file exists"; else  echo "No lock file check if mysql service is actually running"; fi;
echo " ";
echo "Version details";
mysql -V;
echo $sep;


;;
esac;

done

echo "Manual Intervention required, if services are not present, we may need to install them manually";
echo "For LAMP stack following services need to be installed : "
echo "01. Apache2 [>=2.4.x]"
echo "02. Mysql [=5.7.x]"
echo "03. Php [=7.0.25]"
echo "Do you want to proceed with the installation?"; echo -n "yes or y | no or n";

echo "To install the the servers  type 01/02/03 as needed"

PS3='Which server do you want to install ? '
options=("01" "02" "03")

select op in "${options[@]}"
do

case $op in 

01) echo "Starting apache2 installation:"
echo "updating ....."
sudo  apt-get update
clear;
sudo apt-get install apache2 -y
#sudo df -lh ;
echo "installation complete";

interface=`route  | grep ^default | grep -o '[^ ]*.$'`;
ip=`ifconfig $interface | grep -oP "(?<=inet\saddr:).*(?=Bcast)"`; echo $ip;


esac

done
#ip=`ifconfig `route  | grep ^default | grep -o '[^ ]*.$'`  |  grep -oP "(?<=inet\saddr:).*(?=Bcast)"`






#echo "Service identified :Apache2 ";  stat /etc/init.d/apache2  | grep -oP "(?<=File:\s\').*(?=\')" 


#cd /run/apache2/; stat apache2.pid | grep File;  

#sudo apache2 -v


