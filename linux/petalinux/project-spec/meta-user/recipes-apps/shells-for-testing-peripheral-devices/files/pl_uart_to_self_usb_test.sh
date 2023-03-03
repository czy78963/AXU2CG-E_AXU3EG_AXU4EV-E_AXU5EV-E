#!/bin/sh

#set speed
SPEED=9600
stty -F /dev/ttyPS3 ispeed $SPEED ospeed $SPEED cs8
sleep 1
stty -F /dev/ttyUSB0 ispeed $SPEED ospeed $SPEED cs8
sleep 1

cat /dev/ttyPS3 >> /home/root/.ttyPS3_tmp &
echo -e "pl uart to self usb test 1" >> /dev/ttyUSB0
killall cat
TTYPS3_DATA=`cat /home/root/.ttyPS3_tmp`

cat /dev/ttyUSB0 >> /home/root/.ttyUSB0_tmp &
echo -e "pl uart to self usb test 2" >> /dev/ttyPS3
killall cat
TTYUSB0_DATA=`cat /home/root/.ttyUSB0_tmp`

if [ "$TTYUSB0_DATA" == "pl uart to self usb test 2" ] && [ "$TTYPS3_DATA" == "pl uart to self usb test 1" ];then
        echo -e "\e[1;32mpl uart to self usb test OK\e[0m"
else
        echo -e "\e[1;31mpl uart to self usb test NG\e[0m"
fi
rm /home/root/.ttyPS3_tmp
rm /home/root/.ttyUSB0_tmp


