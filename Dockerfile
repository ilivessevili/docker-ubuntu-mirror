FROM ubuntu:14.04
MAINTAINER victor zhang <ilivessevili@gmail.com>

#configure host volume to hold the mirror
RUN sudo mkdir -p /var/spool/apt-mirror

VOLUME /var/spool/apt-mirror

#using aliyun ubuntu mirror
RUN sudo sed -i.bak s/archive.ubuntu.com/mirrors.aliyun.com/g /etc/sources.list
RUN sudo apt-get -qqy update

#install apt-mirror
RUN apt-get -qqy install apt-mirror apache2 curl

#using aliyun ubuntu mirror
RUN sudo sed -i.bak s/archive.ubuntu.com/mirrors.aliyun.com/g /etc/apt/mirror.list

#run apt-mirror
#RUN nohup sudo apt-mirror &

#create a link to the ubuntu mirror
RUN sudo ln -s /var/spool/apt-mirror /var/www/ubuntu
RUN sudo service apache2 restart

EXPOSE 80
ENTRYPOINT ["apt-mirror","&"]
CMD ["echo","done:-)"]
#ENTRYPOINT [curl -v  http://127.0.0.1/ubuntu]

