gcloud auth login
gcloud projects create $PROJECT_ID
gcloud config set project $PROJECT_ID
gcloud config set compute/region $DEFAULT_REGION
gcloud billing projects link $PROJECT_ID --billing-account=$BILLING_ACCOUNT_ID 

gcloud services enable --project $PROJECT_ID dataflow.googleapis.com
gcloud services enable --project $PROJECT_ID storage.googleapis.com
gcloud services enable --project $PROJECT_ID bigquery.googleapis.com

gcloud storage buckets create gs://$BUCKET_NAME
gcloud storage ls

gsutil cp /usercode/airbnb_data.csv gs://your-bucket-name/
gsutil ls gs://your-bucket-name/airbnb_data.csv

gcloud iam service-accounts create SERVICE_ACCOUNT_NAME --description "Service account for running pipeline" --display-name "Pipeline Service Account"

gcloud projects add-iam-policy-binding PROJECT_ID --member="serviceAccount:SERVICE_ACCOUNT_NAME@PROJECT_ID.iam.gserviceaccount.com" --role="roles/storage.admin"

gcloud projects add-iam-policy-binding PROJECT_ID --member="serviceAccount:SERVICE_ACCOUNT_NAME@PROJECT_ID.iam.gserviceaccount.com" --role="roles/bigquery.admin"

gcloud projects add-iam-policy-binding PROJECT_ID --member="serviceAccount:SERVICE_ACCOUNT_NAME@PROJECT_ID.iam.gserviceaccount.com" --role="roles/dataflow.admin"

gcloud projects add-iam-policy-binding PROJECT_ID --member="serviceAccount:SERVICE_ACCOUNT_NAME@PROJECT_ID.iam.gserviceaccount.com" --role="roles/editor"

# create the service account key
gcloud iam service-accounts keys create etl-pipeline-key.json --iam-account=SERVICE_ACCOUNT_NAME@PROJECT_ID.iam.gserviceaccount.com


# List your jobs
gcloud dataflow jobs list --region=us-central1

# Get job details
gcloud dataflow jobs describe $(your-job-id) --region=us-central1

# Query the table
bq query --use_legacy_sql=false "SELECT count(*) FROM airbnb_ds_new.airbnb_tb_new"

bq query --use_legacy_sql=false "SELECT * FROM airbnb_ds_new.airbnb_analysis_vw_new LIMIT 10"

# Clean up
gcloud projects delete your-project-id

