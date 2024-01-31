resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    Name = "My lovely website"
    Terraform = "True"
  }
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id
  block_public_acls = false
  block_public_policy = false

  ignore_public_acls = false
  restrict_public_buckets = false
}

module "s3-website" {
  source = "./modules/s3-website"
  bucket_name = "my-website-bucket-234808sfd"
}