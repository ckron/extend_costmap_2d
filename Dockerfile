FROM osrf/ros:noetic-desktop-full

MAINTAINER ckron

# refer: https://qiita.com/Riliumph/items/3b09e0804d7a04dff85b
ENV USER admin
ENV HOME /home/${USER}
ENV SHELL /bin/bash

RUN useradd -m ${USER}
RUN gpasswd -a ${USER} sudo
RUN echo "${USER}:admin" | chpasswd

## 

RUN apt-get update && apt-get install -y --no-install-recommends \
  git \
  vim \
  screen \
  ngetty \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ~/catkin_ws/src && \
    cd ~/catkin_ws/src && \
    /bin/bash -c "source /opt/ros/noetic/setup.bash; catkin_init_workspace" && \
    cd ~/catkin_ws && \
    /bin/bash -c "source /opt/ros/noetic/setup.bash; catkin_make" && \
    echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc