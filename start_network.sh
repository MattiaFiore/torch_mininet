#!/bin/bash

#VERIFY IF THE TORCH AND TORCH VISION LIBRARIES ARE INSTALLED 
sudo bash bash_scripts/install_torch_folder.sh

#START THE NETWORK 
sudo python3 network.py

#INSTALL ON EACH WORKER TORCH AND TORCHVISION
HOSTS=('h0', 'h1')
for HOST in "${HOSTS[@]}"; do

  echo "INSTALLING TORCH AND TORCH VISION FOR WORKER $HOST"
  #Finding the PID of heach host 
  PID=$(ps aux | grep $HOST | grep 'bash' | awk '{print $2}')
  echo "$PID"
  #Execute the worker code 
  sudo mnexec -a $PID bash bash_scripts/install_torch_worker.sh

done
