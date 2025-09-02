{{/*
Expand the config.json object for the ConfigMap
*/}}
{{- define "mi-scale-chart.configJson" -}}
{{- toJson .Values.configJson | nindent 2 }}
{{- end -}}

{{/*
Get the mount path for the dbus-socket
*/}}
{{- define "mi-scale-chart.dbusSocketMountPath" -}}
{{ .Values.dbusSocket.mountPath }}
{{- end -}}

{{/*
Get the volume name for the dbus-socket
*/}}
{{- define "mi-scale-chart.dbusSocketVolume" -}}
{{ .Values.dbusSocket.volumeName }}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "mi-scale.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "mi-scale.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mi-scale.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mi-scale.labels" -}}
helm.sh/chart: {{ include "mi-scale.chart" . }}
{{ include "mi-scale.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mi-scale.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mi-scale.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mi-scale.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mi-scale.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}