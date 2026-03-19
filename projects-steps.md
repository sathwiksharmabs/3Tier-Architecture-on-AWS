# Step-by-Step Implementation

## VPC and Networking
- Created VPC with CIDR block
- 2 public subnets (for ALB), 2 private subnets for EC2, 2 private subnets for RDS
- Internet Gateway attached to VPC
- NAT Gateway in public subnet
- Route tables:
  - Public → Internet Gateway
  - Private → NAT Gateway

## EC2 and Auto Scaling
- Launch Template with user-data script (Apache + web pages)
- IAM role attached (S3 + SSM access)
- Auto Scaling Group in private EC2 subnets
- Desired, min, max capacity set
- Target tracking policy (CPU utilization)

## Target Groups and ALB
- Target groups: project1, diagram
- Health check paths set
- ALB created in public subnets
- Listener rules for path-based routing
- Target groups attached to ASG

## RDS Setup
- RDS instance in private RDS subnets
- Multi-AZ deployment enabled
- Security group allows access only from EC2
- Automated backups enabled

## S3 Setup
- S3 bucket created
- Diagram uploaded
- Simple EC2 logging done

## Route 53 + CloudFront + ACM
- Domain configured in Route 53
- SSL certificate requested in ACM
- CloudFront distribution created
- ALB attached as origin
- HTTPS enabled

## Security
- Security Groups:
  - ALB: HTTP/HTTPS from internet
  - EC2: traffic only from ALB
  - RDS: access only from EC2
- IAM role for EC2
- WAF attached to CloudFront

## Monitoring
- CloudWatch alarms created
- SNS topic with email subscription linked to alarms

## Backup
- RDS automated backups
- AWS Backup plan created
- Cross-region backup copy enabled

## Outcome
- CloudFront → ALB → EC2 (Auto Scaling) → RDS
- High availability across AZs
- Auto scaling works
- Secure HTTPS access
- Monitoring and alerts active
- Backup and disaster recovery enabled
