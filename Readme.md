# 쿠버네티스 환경 실습 레포지토리


### 1. AWS Cloud9 리소스 생성 후 접속
- t3.small & Amazon Linux 2

### 2. Github 연결 및 유저 전환
- Source Control -> clone repository -> github 주소 입력
- Root 전환 -> 자격 증명 입력 (eksadmin 유저 access-key, secret-access-key)
```
sudo su -
aws configure
```
> EKSADMIN USER 정책
> - AdministratorAccess
>```
>{
>    "Version": "2012-10-17",
>    "Statement": [
>        {
>            "Effect": "Allow",
>            "Action": "*",
>            "Resource": "*"
>        }
>    ]
>}
>```
> - inline-assumerole-temp-cloud9
>```
>{
>    "Version": "2012-10-17",
>    "Statement": [
>        {
>            "Effect": "Allow",
>            "Action": "sts:AssumeRole",
>            "Resource": "arn:aws:iam::<계정ID>:role/makingeks"
>        }
>    ]
>}
>```

### 3.Terraform 설치
[Terraform 공식 사이트](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
)
```
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
```

### 4. Terraform 코드 적용
```
cd /home/ec2-user/environment/eks-argocd-terraform/terraform
terraform init
terraform apply
```
argocd_initial_admin_secret, argocd_server_load_balancer, eks_connect 값 확인


### 5. kubectl 설치
[Kubernetes 공식 사이트](https://kubernetes.io/ko/docs/tasks/tools/install-kubectl-linux/)
```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
```
> error: You must be logged in to the server (the server has asked for the client to provide credentials) 오류 발생 시 
>
> .aws/credentials 파일에서 aws_session_token = 제거
>
> ``` cd ~/.aws ```


### 6. ArgoCD Application 생성

```
cd argocd
kubectl apply -f argo-app.yaml
```

### 7. ArgoCD UI 접속
```
aws eks --region ap-northeast-2 update-kubeconfig --name intern-eks-cluster
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath=\"{.data.password}\" | base64 -d
```
argocd_server_load_balancer으로 접속 후 admin 아이디와 초기 비밀번호로 접속



