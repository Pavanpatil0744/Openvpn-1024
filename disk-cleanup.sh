#!/bin/bash

echo "Starting Ubuntu Disk Cleanup..."

# Update package lists
echo "Updating package lists..."
sudo apt update -y

# Clean up APT cache
echo "Cleaning APT cache..."
sudo apt autoclean -y
sudo apt clean -y

# Remove unused packages and dependencies
echo "Removing unnecessary packages..."
sudo apt autoremove -y

# Clear systemd journal logs (modify the size as needed)
echo "Cleaning system logs..."
sudo journalctl --vacuum-size=100M

# Clear user and system cache
echo "Cleaning user cache..."
rm -rf ~/.cache/*

# Clear old system logs
echo "Removing old log files..."
sudo find /var/log -type f -name "*.log" -delete

# Clear temporary files
echo "Cleaning temporary files..."
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# Free up space used by Snap packages (optional)
echo "Removing old Snap revisions..."
sudo snap list --all | awk '/disabled/{print $1, $3}' | while read snapname revision; do sudo snap remove "$snapname" --revision="$revision"; done

# Display disk usage before and after cleanup
echo "Disk usage before cleanup:"
df -h
echo "Cleanup completed!"
echo "Disk usage after cleanup:"
df -h
