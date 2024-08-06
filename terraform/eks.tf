resource "aws_eks_cluster" "main" {
 name     = "intern-eks-cluster"
 role_arn = aws_iam_role.eks_cluster_role.arn

 vpc_config {
   subnet_ids = aws_subnet.public_subnet.*.id
 }

 tags = {
   Name = "intern-eks-cluster"
 }
}


resource "aws_eks_node_group" "main" {
 cluster_name    = aws_eks_cluster.main.name
 node_group_name = "intern-eks-node-group"
 node_role_arn   = aws_iam_role.eks_node_role.arn
 subnet_ids      = aws_subnet.public_subnet.*.id

 scaling_config {
   desired_size = 2
   max_size     = 3
   min_size     = 1
 }

 tags = {
   Name = "intern-eks-node-group"
 }
}


# resource "kubernetes_namespace" "example" {
#   metadata {
#     name = "example-namespace"
#   }
# }

# resource "kubernetes_service_account" "example" {
#   metadata {
#     name = "example-service-account"
#     namespace = kubernetes_namespace.example.metadata[0].name
#   }
# }