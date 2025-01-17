Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6147C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 16:36:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13C6A80737;
	Fri, 17 Jan 2025 17:36:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OG+fUmck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22AD6806D8; Fri, 17 Jan 2025 17:36:09 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DC4F8073F
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 17:36:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d8fd060e27so19494206d6.1
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 08:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737131763; x=1737736563; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6irmJtLO9H3Q2jk78FMEZJrQPDbF9Jat9MxnWs8j/ag=;
 b=OG+fUmckEalad1r5YRJFrfyYYCqcOjjpozQk55q6mL1GRdJsYb5y6ZNq9I3N2wd386
 bKqk7qsQCi3QeQkXxpUUWHTlNke+hO6YfhSvZ2rbQj4Sx3sHA+CDsZY3ohXv4O3DJVfG
 fVZp7OevUtqOdx2NuDqM9qkzbtOAg3xT5uuEnUvA3OJ3zy8A06CkczkDrTtK4XzvPijw
 z0d2rbV/mf0rO0MV0bKjZ9Yhb7BfV4QL1yGtG9/Q6SWoyFhCuGonpuQn74akTg/GzxTb
 /cGMhjsDmmqnZ5gAfIDbNExUYokkuQHAHb9ApTSSPDloc7sMARcFwQlD+XqYqPTcRFsS
 9hug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737131763; x=1737736563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6irmJtLO9H3Q2jk78FMEZJrQPDbF9Jat9MxnWs8j/ag=;
 b=a7xmUwN6RIbjwPwbm+tNfWRdhVdfTFxNzwBBq3qvCeC/fxauXgTFHHUpHCmGNApG6t
 blKjswpxaJ9Xwy3WunDuinNJ+CeZTjuUIIv7W/+OsFqKm1OT7UwETXNpEG5ZRIVXutOx
 plDIXp1PNFptE9OahFav7Bx9QpjuotN+0rX8U7oLqwpRg2gLe95QRbX5EM53cUtjGw1I
 r4yHG6LRiMbwDcfffSTt4lcclWwMVJmGBlsF8F7olApbYxt51HgLPZd0whF7bJbWTCse
 MWJVvQkkdHgI+0R8B3ZaabHM0vSvyzFni+ed/XKsc9NfNl9I8uWZqJ8rLG6CIfuLatU/
 00Xw==
X-Gm-Message-State: AOJu0YxrU5hYHG+uZe2rCUmT+JNAKhB0Bt7DU1FP9xZFtAfcu03zBZf6
 LSC4bwXX5mo2FzgRpFgSPHRhFBkUEIQsMN1SG7V/3VAsqzFtIEtnFqKttTTNGmgEOYWC/v+Yw5o
 vS+A=
X-Gm-Gg: ASbGncsLPvidX0OPE42HC1QK/T0UtsIY6K/msvKb4MBX9VQjcR18A22Vilc0dhEUnTN
 CQroBa2NuANFWCIVCrrukl9OiFnRDrFMSQtqt23FZDqvZe6ed6CRVHJVmKew+Tdl3Jy5vmJ+mDC
 hiMUFDWsZzhi9D1OuGl73jABxz5yGdXuQZEYQbETG0mHiCRIf6Ry8g5TGiuNGMypEwGBsQK3VSc
 EomKFVeO0ruyRPcs3qkZ6Wo6BcwWxYnSGkRQA/kIdBxiy8BH6CdVmac0NrNfd6uzx0tQ7eKSR/1
 CcFhcGmua5wo9IzFvJKmZUJ5YNYAQcPNji0xP8OfNqwA4Jyr6AMX3FY=
X-Google-Smtp-Source: AGHT+IFdVu1DaKE6vAcWJxbGlPjdaHI50rnjWMB//hTfO03vzMED79j29KJISowiC7UF3bLCqwTabQ==
X-Received: by 2002:ad4:5ec6:0:b0:6df:9740:68a3 with SMTP id
 6a1803df08f44-6e1b224c029mr58883556d6.38.1737131762872; 
 Fri, 17 Jan 2025 08:36:02 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afce45c0sm12733946d6.103.2025.01.17.08.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 08:36:02 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v6 2/3] tcg2: decouple eventlog size from efi
Date: Fri, 17 Jan 2025 08:35:40 -0800
Message-Id: <20250117163545.88627-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250117163545.88627-1-raymond.mao@linaro.org>
References: <20250117163545.88627-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Move default eventlog size from efi to tpm for using in both
efi and measured boot.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v5
- Move eventlog size kconfig from EFI to TPM2, so that it can be used by
  both EFI and MEASURED_BOOT.
Changes in v6
- None.

 doc/usage/measured_boot.rst |  1 -
 drivers/tpm/Kconfig         |  9 +++++++++
 include/efi_tcg2.h          |  2 --
 lib/efi_loader/Kconfig      |  9 ---------
 lib/efi_loader/efi_tcg2.c   | 15 ++++++++-------
 5 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
index 05c439e9ac..488dd546f1 100644
--- a/doc/usage/measured_boot.rst
+++ b/doc/usage/measured_boot.rst
@@ -24,7 +24,6 @@ Requirements
 
 * A hardware TPM 2.0 supported by an enabled U-Boot driver
 * CONFIG_EFI_TCG2_PROTOCOL=y
-* CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE=y
 * optional CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB=y will measure the loaded DTB
   in PCR 1
 
diff --git a/drivers/tpm/Kconfig b/drivers/tpm/Kconfig
index d59102d9a6..01bc686d36 100644
--- a/drivers/tpm/Kconfig
+++ b/drivers/tpm/Kconfig
@@ -209,6 +209,15 @@ config TPM2_MMIO
 	  to the device using the standard TPM Interface Specification (TIS)
 	  protocol.
 
+config TPM2_EVENT_LOG_SIZE
+	int "EventLog size"
+	depends on TPM_V2
+	default 65536
+	help
+	  Define the size of the EventLog. Note that this is going to be
+	  allocated twice. One for the eventlog it self and one for the
+	  configuration table that is required from the TCG2 spec
+
 endif # TPM_V2
 
 endmenu
diff --git a/include/efi_tcg2.h b/include/efi_tcg2.h
index 8dfb1bc952..7ed8880991 100644
--- a/include/efi_tcg2.h
+++ b/include/efi_tcg2.h
@@ -28,8 +28,6 @@
 #define EFI_TCG2_MAX_PCR_INDEX 23
 #define EFI_TCG2_FINAL_EVENTS_TABLE_VERSION 1
 
-#define TPM2_EVENT_LOG_SIZE CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE
-
 typedef u32 efi_tcg_event_log_bitmap;
 typedef u32 efi_tcg_event_log_format;
 typedef u32 efi_tcg_event_algorithm_bitmap;
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index c46ffe3a9d..d703e901ed 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -437,15 +437,6 @@ config EFI_TCG2_PROTOCOL
 	  Provide a EFI_TCG2_PROTOCOL implementation using the TPM hardware
 	  of the platform.
 
-config EFI_TCG2_PROTOCOL_EVENTLOG_SIZE
-	int "EFI_TCG2_PROTOCOL EventLog size"
-	depends on EFI_TCG2_PROTOCOL
-	default 65536
-	help
-		Define the size of the EventLog for EFI_TCG2_PROTOCOL. Note that
-		this is going to be allocated twice. One for the eventlog it self
-		and one for the configuration table that is required from the spec
-
 config EFI_TCG2_PROTOCOL_MEASURE_DTB
 	bool "Measure DTB with EFI_TCG2_PROTOCOL"
 	depends on EFI_TCG2_PROTOCOL
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index a15c73162e..6dba8b1406 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -111,7 +111,7 @@ static efi_status_t tcg2_agile_log_append(u32 pcr_index, u32 event_type,
 	/* if ExitBootServices hasn't been called update the normal log */
 	if (!event_log.ebs_called) {
 		if (event_log.truncated ||
-		    event_log.pos + event_size > TPM2_EVENT_LOG_SIZE) {
+		    event_log.pos + event_size > CONFIG_TPM2_EVENT_LOG_SIZE) {
 			event_log.truncated = true;
 			return EFI_VOLUME_FULL;
 		}
@@ -124,7 +124,7 @@ static efi_status_t tcg2_agile_log_append(u32 pcr_index, u32 event_type,
 		return ret;
 
 	/* if GetEventLog has been called update FinalEventLog as well */
-	if (event_log.final_pos + event_size > TPM2_EVENT_LOG_SIZE)
+	if (event_log.final_pos + event_size > CONFIG_TPM2_EVENT_LOG_SIZE)
 		return EFI_VOLUME_FULL;
 
 	log = (void *)((uintptr_t)event_log.final_buffer + event_log.final_pos);
@@ -822,12 +822,12 @@ static efi_status_t create_final_event(void)
 	 * EFI_TCG2_GET_EVENT_LOGS need to be stored in an instance of an
 	 * EFI_CONFIGURATION_TABLE
 	 */
-	ret = efi_allocate_pool(EFI_ACPI_MEMORY_NVS, TPM2_EVENT_LOG_SIZE,
+	ret = efi_allocate_pool(EFI_ACPI_MEMORY_NVS, CONFIG_TPM2_EVENT_LOG_SIZE,
 				&event_log.final_buffer);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
-	memset(event_log.final_buffer, 0xff, TPM2_EVENT_LOG_SIZE);
+	memset(event_log.final_buffer, 0xff, CONFIG_TPM2_EVENT_LOG_SIZE);
 	final_event = event_log.final_buffer;
 	final_event->number_of_events = 0;
 	final_event->version = EFI_TCG2_FINAL_EVENTS_TABLE_VERSION;
@@ -913,7 +913,8 @@ static efi_status_t efi_init_event_log(void)
 	if (tcg2_platform_get_tpm2(&dev))
 		return EFI_DEVICE_ERROR;
 
-	ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA, TPM2_EVENT_LOG_SIZE,
+	ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA,
+				CONFIG_TPM2_EVENT_LOG_SIZE,
 				(void **)&event_log.buffer);
 	if (ret != EFI_SUCCESS)
 		return ret;
@@ -922,7 +923,7 @@ static efi_status_t efi_init_event_log(void)
 	 * initialize log area as 0xff so the OS can easily figure out the
 	 * last log entry
 	 */
-	memset(event_log.buffer, 0xff, TPM2_EVENT_LOG_SIZE);
+	memset(event_log.buffer, 0xff, CONFIG_TPM2_EVENT_LOG_SIZE);
 
 	/*
 	 * The log header is defined to be in SHA1 event log entry format.
@@ -939,7 +940,7 @@ static efi_status_t efi_init_event_log(void)
 	 * platforms can use different ways to do so.
 	 */
 	elog.log = event_log.buffer;
-	elog.log_size = TPM2_EVENT_LOG_SIZE;
+	elog.log_size = CONFIG_TPM2_EVENT_LOG_SIZE;
 	rc = tcg2_log_prepare_buffer(dev, &elog, false);
 	if (rc) {
 		ret = (rc == -ENOBUFS) ? EFI_BUFFER_TOO_SMALL : EFI_DEVICE_ERROR;
-- 
2.25.1

