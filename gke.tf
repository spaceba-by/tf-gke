
variable "worker_count" {
    default = 1
}

resource "google_container_cluster" "dev" {
    name = "${var.project_id}-gke"
    location = "us-east4-c"

    remove_default_node_pool = true
    initial_node_count = 1
  
    network = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.subnet.name
}

resource "google_container_node_pool" "nodes" {
    name = "${google_container_cluster.dev.name}-node-pool"
    location = "us-east4-c"
    cluster = google_container_cluster.dev.name
    node_count = var.worker_count

    node_config {
        oauth_scopes = [
            "https://www.googleapis.com/auth/logging.write",
            "https://www.googleapis.com/auth/monitoring",
        ]

        labels = {
            env = var.project_id
        }

        preemptible = true
        machine_type = "n1-standard-1"
        tags = ["gke-node", "${var.project_id}-gke"]
        metadata = {
          disable-legacy-endpoints = "true"
        }
    }
}