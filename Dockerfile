FROM osrf/ros:noetic-desktop-full

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y git \
 && rm -rf /var/lib/apt/lists/*

# Code repository

RUN mkdir -p /catkin_ws/src/

RUN git clone --recurse-submodules \
      https://github.com/RobotResearchRepos/HKUST-Aerial-Robotics_MonoLaneMapping \
      /catkin_ws/src/MonoLaneMapping

RUN git clone --recurse-submodules \
      https://github.com/qiaozhijian/openlane_bag \
      /catkin_ws/src/openlane_bag

RUN . /opt/ros/$ROS_DISTRO/setup.sh \
 && apt-get update \
 && rosdep install -r -y \
     --from-paths /catkin_ws/src \
     --ignore-src \
 && rm -rf /var/lib/apt/lists/*

RUN . /opt/ros/$ROS_DISTRO/setup.sh \
 && cd /catkin_ws \
 && catkin_make
 
 
