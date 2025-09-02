# Mi Scale Helm Chart

This chart deploys the Xiaomi Mi Scale integration that publishes weight measurements to MQTT.

## Installation

```bash
# Add the repository
helm repo add mi-scale https://github.com/lolouk44/xiaomi_mi_scale/.chart

# Install the chart
helm install mi-scale mi-scale --namespace mi-scale --create-namespace

# Upgrade existing installation
helm upgrade mi-scale mi-scale --namespace mi-scale
```

## Prerequisites

* Kubernetes cluster
* Helm 3.0+
* MQTT broker (like Mosquitto)
* Xiaomi Mi Body Composition Scale (also known as MIBCS) version 1 or 2

## Configuration

The following table lists the configurable parameters for the mi-scale chart.

| Parameter | Description | Default |
|-----------|-------------|---------|
| `image.repository` | Image repository | `lolouk44/xiaomi-mi-scale` |
| `image.tag` | Image tag | `latest` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `options.optionsJson` | Configuration for the scale (see below) | `{}` |

### Required Configuration

Example config.json:

```json
{
    "MISCALE_MAC": "00:00:00:00:00:00",
    "MQTT_USERNAME": "username",
    "MQTT_PASSWORD": "password",
    "MQTT_HOST": "mqtt.host.com",
    "MQTT_PREFIX": "miscale",
    "MQTT_PORT": 1883,
    "MQTT_TIMEOUT": 60,
    "TIME_INTERVAL": 30,
    "USERS": [
        {
            "username": "User1",
            "weight_template": "weight/user1",
            "impedance_template": "impedance/user1",
            "sex": "male",
            "height": 175,
            "dob": "1990-01-01"
        }
    ]
}
```


### Notes

* The pod requires NET_ADMIN and SYS_ADMIN capabilities for Bluetooth functionality
* hostNetwork: true is required for Bluetooth access
* dbus socket from host is required for Bluetooth communication