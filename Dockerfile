FROM ubuntu:bionic
MAINTAINER ANTONIO antonioluis1231@hotmail.com
RUN apt update -y
RUN apt upgrade -y
RUN apt install vim wget curl net-tools unzip xvfb x11vnc -y
RUN apt install openjdk-8-jdk -y

EXPOSE 5900
EXPOSE 4001
EXPOSE 4002


RUN Xvfb :1 -ac -screen 0 1024x768x24 &
RUN export DISPLAY=:1
RUN x11vnc -ncache 10 -ncache_cr -display :1 -forever -shared -logappend /var/log/x11vnc.log -bg -noipv6

RUN cd /root

RUN wget https://download2.interactivebrokers.com/installers/ibgateway/latest-standalone/ibgateway-latest-standalone-linux-x64.sh 
RUN chmod u+x ibgateway-latest-standalone-linux-x64.sh
RUN sh ibgateway-latest-standalone-linux-x64.sh -c

RUN wget https://github.com/ib-controller/ib-controller/releases/download/3.4.0/IBController-3.4.0.zip
RUN unzip ./IBController-3.4.0.zip -d ./ibcontroller.paper
RUN chmod u+x ./ibcontroller.paper/*.sh ./ibcontroller.paper/*/*.sh
