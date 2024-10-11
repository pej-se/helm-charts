{{- define "app.name" -}}
{{- default .Release.Name .Values.global.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "app.fullname" -}}
{{- if .Values.global.fullnameOverride }}
{{- .Values.global.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Release.Name .Values.global.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "app.labels" -}}
helm.sh/chart: {{ include "app.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "app.selectorLabels" . }}
{{- end }}

{{- define "app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "app.pejAnnotations" -}}
pej.se/environment: {{ .Values.global.app.environment | quote }}
pej.se/project: {{ .Values.global.app.project | quote }}
pej.se/customer: {{ .Values.global.app.customer | quote }}
pej.se/release: {{ .Values.global.app.release | quote }}
pej.se/version: {{ .Values.global.app.version | quote }}
{{- end }}

{{- define "app.serviceAccountName" -}}
{{- default "default" .Values.global.serviceAccount.name }}
{{- end }}
