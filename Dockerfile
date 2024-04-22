# Use an official Ubuntu as a base image
FROM ubuntu:20.04

# Set non-interactive installation mode
ENV DEBIAN_FRONTEND=noninteractive

# Install Python and pip
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y python3.7 \
    python3.7-distutils \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Update python and pip to specific versions
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1 \
    && update-alternatives --set python /usr/bin/python3.7 \
    && python3.7 -m pip install --upgrade pip

# Install necessary packages for scipy and general development
RUN apt-get update && apt-get install -y \
    build-essential \
    libatlas-base-dev \
    gfortran \
    libgmp-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --no-cache-dir \
    numpy==1.19.5 \
    scipy==1.4.1 \
    scikit-learn==0.23.2 \
    osqp==0.6.1 \
    tensorflow==2.6.0

# Set the working directory in the container
WORKDIR /workspace

# Set up a volume for persisting data
VOLUME /workspace

# Set the default command for the container, e.g., launching a bash shell
CMD ["bash"]
