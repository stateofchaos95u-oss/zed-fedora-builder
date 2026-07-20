use client::Client;
use gpui::App;
use std::sync::Arc;

mod hang_detection;

pub fn init(client: Arc<Client>, cx: &mut App) {
    hang_detection::start(client.clone(), cx);
}

