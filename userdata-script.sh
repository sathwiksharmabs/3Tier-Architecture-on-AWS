#!/bin/bash
# -----------------------------
# Update and install packages
# -----------------------------
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# -----------------------------
# Project1 Main Page
# -----------------------------
mkdir -p /var/www/html/project1

cat <<EOF > /var/www/html/project1/index.html
<html>
<body style="font-family: Arial; text-align: center; margin-top: 100px; font-size:18px;">
<p>🚀 Sathwik's Cloud Project</p>
<p>Highly Available 3-Tier Architecture on AWS</p>
<p>Instance Hostname: $(hostname)</p>
<p>Private IP: $(hostname -I)</p>
<p>Auto Scaling Active | Path-based routing via ALB</p>
</body>
</html>
EOF

# -----------------------------
# Project1 Diagram Page
# -----------------------------
mkdir -p /var/www/html/project1/diagram

# Download diagram from S3 locally (requires IAM role with s3:GetObject)
aws s3 cp s3://project1-3tier-storage/3TierArchitecture.jpg /var/www/html/project1/diagram/3TierArchitecture.jpg

cat <<EOF > /var/www/html/project1/diagram/index.html
<html>
<body style="font-family: Arial; text-align: center; margin-top: 80px; font-size:18px;">
<p>Diagram of Highly Available 3-Tier Architecture on AWS</p>
<img src="3TierArchitecture.jpg" style="width:auto; height:auto; margin-top:20px;">
</body>
</html>
EOF

# -----------------------------
# Logs upload
# -----------------------------
mkdir -p /tmp/logs
echo "Instance $(hostname) started at $(date)" > /tmp/logs/startup-log.txt
aws s3 cp /tmp/logs/startup-log.txt s3://project1-3tier-storage/logs/

# -----------------------------
# Set permissions
# -----------------------------
chmod -R 755 /var/www/html
