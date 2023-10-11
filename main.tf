provider "google" {
  project = "rvm-devops-iac"
  region = "us-central1"
  zone = "us-central1-c"
  credentials = "${file("serviceaccount.yaml")}"
}

resource "google_folder" "Financeiro" {
  display_name = "Financeiro"
  parent = "organizations/751207485742"
}

resource "google_folder" "Salesforce" {
  display_name = "Salesforce"
  parent = google_folder.Financeiro.name
}

resource "google_folder" "Desenvolvimento" {
  display_name = "Desenvolvimento"
  parent = google_folder.Salesforce.name
}

resource "google_folder" "Producao" {
  display_name = "Producao"
  parent = google_folder.Salesforce.name
}

resource "google_project" "rvm-salesforce-dev" {
  name = "Salesforce-Dev"
  project_id = "rvm-salesforce-dev"
  folder_id = google_folder.Desenvolvimento.name
  auto_create_network = false
  billing_account = "01C2E1-3F5033-7A50EC"
}
