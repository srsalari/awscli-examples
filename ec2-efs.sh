aws ec2 create-security-group \
--region ca-central-1 \
--group-name efs-walkthrough1-ec2-sg \
--description "Amazon EFS walkthrough 1, SG for EC2 instance" \
--vpc-id vpc-0481a6fc3f330f41b



SG-1: {
    "GroupId": "sg-073f14100b6deb530"
}

$ aws ec2 authorize-security-group-ingress \
--group-id sg-073f14100b6deb530 \
--protocol tcp \
--port 22 \
--cidr 0.0.0.0/0 \
--region ca-central-1

You can find the VPC ID using the following command.


$ aws  ec2 describe-vpcs 

aws ec2 create-security-group \
--region ca-central-1 \
--group-name efs-walkthrough1-mt-sg \
--description "Amazon EFS walkthrough 1, SG for mount target" \
--vpc-id vpc-0481a6fc3f330f41b

{
    "GroupId": "sg-07916edc08942b09b"
}

$ aws ec2 authorize-security-group-ingress \
--group-id sg-07916edc08942b09b \
--protocol tcp \
--port 2049 \
--source-group sg-073f14100b6deb530 \
--region ca-central-1 

output:
{
    "Return": true,
    "SecurityGroupRules": [
        {
            "SecurityGroupRuleId": "sgr-0aa18272b77005e1e",
            "GroupId": "sg-07916edc08942b09b",
            "GroupOwnerId": "600627332251",
            "IsEgress": false,
            "IpProtocol": "tcp",
            "FromPort": 2049,
            "ToPort": 2049,
            "ReferencedGroupInfo": {
                "GroupId": "sg-073f14100b6deb530",
                "UserId": "600627332251"
            }

Delete the security groups later
{
    "GroupId": "sg-00dc45d5f43ff025b"
}

$ aws ec2 run-instances \
--image-id ami-0956b8dc6ddc445ec \
--count 1 \
--instance-type t2.micro \
--associate-public-ip-address \
--key-name MyKeyPair \
--security-group-ids sg-073f14100b6deb530 \
--subnet-id subnet-0e1b999d8178296a9 \
--region ca-central-1 

InstanceId": "i-0c45d22cc53d81a5c

output:
{
    "Groups": [],
    "Instances": [
        {
            "AmiLaunchIndex": 0,
            "ImageId": "ami-0956b8dc6ddc445ec",
            "InstanceId": "i-0c45d22cc53d81a5c",
            "InstanceType": "t2.micro",
            "KeyName": "MyKeyPair",
            "LaunchTime": "2025-01-23T00:08:52+00:00",
            "Monitoring": {
                "State": "disabled"
            },
            "Placement": {
                "AvailabilityZone": "ca-central-1b",
                "GroupName": "",
                "Tenancy": "default"
            },
            "PrivateDnsName": "ip-172-31-14-241.ca-central-1.compute.internal",
            "PrivateIpAddress": "172.31.14.241",
            "ProductCodes": [],
            "PublicDnsName": "",
            "State": {
                "Code": 0,
                "Name": "pending"
            },


aws efs create-file-system \
--encrypted \
--creation-token FileSystemForWalkthrough1 \
--tags Key=Name,Value=SomeExampleNameValue \
--region ca-central-1        

FileSystemId": "fs-089dca7e5070d759f"

output:
{
    "OwnerId": "600627332251",
    "CreationToken": "FileSystemForWalkthrough1",
    "FileSystemId": "fs-089dca7e5070d759f",
    "FileSystemArn": "arn:aws:elasticfilesystem:ca-central-1:600627332251:file-system/fs-089dca7e5070d759f",
    "CreationTime": "2025-01-22T19:11:15-05:00",
    "LifeCycleState": "creating",
    "Name": "SomeExampleNameValue",
    "NumberOfMountTargets": 0,
    "SizeInBytes": {
        "Value": 0,
        "ValueInIA": 0,
        "ValueInStandard": 0,
        "ValueInArchive": 0
    },
    "PerformanceMode": "generalPurpose",
    "Encrypted": true,
    "KmsKeyId": "arn:aws:kms:ca-central-1:600627332251:key/da81ed85-bfe9-4b5b-af72-c0cf4f7de330",
    "ThroughputMode": "bursting",
    "Tags": [
        {
            "Key": "Name",
            "Value": "SomeExampleNameValue"
        }
    ],
    "FileSystemProtection": {


aws efs put-lifecycle-configuration \
--file-system-id fs-089dca7e5070d759f \
--lifecycle-policies TransitionToIA=AFTER_30_DAYS \
--region ca-central-1
          

$ aws efs create-mount-target \
--file-system-id fs-089dca7e5070d759f \
--subnet-id  subnet-0e1b999d8178296a9 \
--security-group sg-07916edc08942b09b \
--region ca-central-1

{
    "OwnerId": "600627332251",
    "MountTargetId": "fsmt-024d7f0624785be53",
    "FileSystemId": "fs-089dca7e5070d759f",
    "SubnetId": "subnet-0e1b999d8178296a9",
    "LifeCycleState": "creating",
    "IpAddress": "172.31.14.62",
    "NetworkInterfaceId": "eni-04d37b49ffd6c72e2",
    "AvailabilityZoneId": "cac1-az2",
    "AvailabilityZoneName": "ca-central-1b",
    "VpcId": "vpc-0481a6fc3f330f41b"
}


EC2-DNS: ec2-3-98-136-236.ca-central-1.compute.amazonaws.com

EFS-DNS: fs-089dca7e5070d759f.efs.ca-central-1.amazonaws.com

sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-089dca7e5070d759f.efs.ca-central-1.amazonaws.com:/   ~/efs-mount-point  

sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 172.31.14.62:/  ~/efs-mount-point

cd ~/efs-mount-point  

ls -al

sudo chmod go+rw .

touch test-file.txt 

ls -al

$ aws ec2 terminate-instances \
--instance-ids i-0c45d22cc53d81a5c 

$  aws efs describe-mount-targets \
--file-system-id fs-089dca7e5070d759f \
--region ca-central-1

$ aws efs delete-file-system \
--file-system-id fs-089dca7e5070d759f \
--region ca-central-1