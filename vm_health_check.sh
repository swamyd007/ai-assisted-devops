#!/bin/bash

# Function to get CPU utilization
get_cpu_utilization() {
  mpstat | awk '$12 ~ /[0-9.]+/ { print 100 - $12 }'
}

# Function to get memory utilization
get_memory_utilization() {
  free | grep Mem | awk '{print $3/$2 * 100.0}'
}

# Function to get disk utilization
get_disk_utilization() {
  df / | grep / | awk '{ print $5 }' | sed 's/%//g'
}

# Get the utilization values
cpu_utilization=$(get_cpu_utilization)
memory_utilization=$(get_memory_utilization)
disk_utilization=$(get_disk_utilization)

# Print the utilization values
echo "CPU Utilization: $cpu_utilization%"
echo "Memory Utilization: $memory_utilization%"
echo "Disk Utilization: $disk_utilization%"

# Check if any of the utilization values are greater than 60%
if (( $(echo "$cpu_utilization > 60" | bc -l) )) || (( $(echo "$memory_utilization > 60" | bc -l) )) || (( $(echo "$disk_utilization > 60" | bc -l) )); then
  echo "The health of the VM is Not healthy."
else
  echo "The health of the VM is healthy."
fi
EOF
