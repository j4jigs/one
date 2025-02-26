terraform {
  # Run init/plan/apply with "backend" commented-out (ueses local backend) to provision Resources (Bucket, Table)
  # Then uncomment "backend" and run init, apply after Resources have been created (uses AWS)
  backend "s3" {
    bucket         = "cc-tf-state-backend-ci-cd26feb2607"
    key            = "tf-infra/terraform.tfstate"
    region         = "us-east-1"
 #   dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }

  required_version = ">=0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

#module "tf-state" {
#  source      = "./modules/tf-state"
#  bucket_name = "cc-tf-state-backend-ci-cd26feb25"
#}

resource "aws_instance" "my_ec2_instance" {
  ami                    = "ami-05b10e08d247fb927"  # Amazon Linux 2 AMI (Update as needed)
  instance_type          = "t2.micro"
 # key_name               = "my-key-pair"  # Replace with your key pair name
 # subnet_id              = "subnet-xxxxxxxx"  # Replace with a valid subnet ID
 # security_groups        = ["default"]  # Replace with your security group

  tags = {
    Name = "My-T2Micro-Instance"
  }
}