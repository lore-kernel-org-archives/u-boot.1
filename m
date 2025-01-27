Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE85EC02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 14:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A87581292;
	Mon, 27 Jan 2025 15:50:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ReL5gn6i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D112B8141A; Mon, 27 Jan 2025 15:50:05 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86F0E81292
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 15:49:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b6fc3e9e4aso393595485a.2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 06:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737989397; x=1738594197; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/+/hiPNESX5pbr6Q0lwfjHVeUAXAR3pfjnhLAJhtIA=;
 b=ReL5gn6i3/mzCPUF2P2Xg4Q8iEQ1a9fjFPYgwiOGvsvIDbKzg85al7h9C9hmM4PClS
 oLd8eTHkAWt86D++mTbqynUgxdijGglxdMqwFDn7Dr/iNiF33cArwpXnY3FrFQsyNHvb
 GpLXjwRWzrAcKTkGINEssmT8LjgMx8dW1qRBynHxUxVk5dGV1e8pbumWj7eNFGygC1IP
 z8gQ2+QOzq7xjHEc/YYD3jsUxklOVyuTfnvY+8n5lTaYmj6/lOaCcKXedgO83UiflgAK
 FryGdT8kR88m06q1f6+ljzSIJBV7F91S4iKLfZtKLmvWgsjVqNV2FUA6tmUagB1Ny+/0
 FVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737989397; x=1738594197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/+/hiPNESX5pbr6Q0lwfjHVeUAXAR3pfjnhLAJhtIA=;
 b=N32P3k6NMeJ39sj/1voDEfRWnn9p7k9DAzj9AyEV4EmyBWy3X3hicw0YB2WL6aXYJO
 BgSVUjmv9W0+pxDEnk5Hh4eMLCuV5rt48o0Sbkw5cTuqdCFHAehqO9Yw46dbQJl+cJuN
 l0nm/6we0B0+NIlvRuZ4f3a+T+2Zbxp7ixWyYYvUKDJtuXJL0vQgxpiv2i5qF4an01qw
 TCHS0odJps+tTGG2XuDnzUYyBC/9FdvznD+5aEWN9U5+cAHJYdnLUhC/UrfELrf5NGAB
 Ow2/H2oGr3Rru793desEtAue7k4ED9MsYo09Q28fZ/NNkJXoFCMu8lY9xn3Tonl98o/L
 80Yw==
X-Gm-Message-State: AOJu0YzOQSid6+V9icci1lK3H/ZfyNYXljaax0uYdL7V6hhcOQy0EYRe
 pc9FqgGF5IRm0xBikJRenvGyZ0nPyHl3KZi3tR8Ul+zClGrWaYKKTJ8RWVyitG/btIa9SzJJfQi
 uMUc=
X-Gm-Gg: ASbGnctZDcJluhqXsPqBf4yHixe5uT7jq3XXfTy9w2ciCKFzgZcybx7YbweDZO9Rg88
 HzFFplUxuFNbGggyE6H3EPo0qnNiHhebxxnCd/eZSbOCcSoI/TOCmyHi23dEazDalZxisUSLZjW
 23pe45KioT8WOAmnfpLqwoYEsjn1y1CepK80ZGLFqGjZcZMcHqb3bNZQ2/EOww2xNfXfM5EB7fD
 vQdrpqjwT2NYyVurJfVKdOD2o30aoV5glFvCQOr9RyrR6gHtMLZz3AaxaF4dckCcYUlcLq+8vpT
 beULB2nvlipFRxjyuAx4hBVXP45IylZaT8IFkdosSxTexvisS+YbaD1j8LHUPGoA6p9Q/J9hbZY
 WjUA=
X-Google-Smtp-Source: AGHT+IE3x6wdwzccAaMSP7cXN+/NQchlbjl1BKfFkb0+q4LlGjjOz9EA153WaNywt/+g+kJM5HmmTA==
X-Received: by 2002:a05:620a:2627:b0:7b6:d1e1:a22e with SMTP id
 af79cd13be357-7be63248078mr5831158385a.29.1737989396801; 
 Mon, 27 Jan 2025 06:49:56 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9aeedc7esm397345985a.70.2025.01.27.06.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 06:49:56 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v7 2/3] tcg2: decouple eventlog size from efi
Date: Mon, 27 Jan 2025 06:49:35 -0800
Message-Id: <20250127144941.645544-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250127144941.645544-1-raymond.mao@linaro.org>
References: <20250127144941.645544-1-raymond.mao@linaro.org>
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
Changes in v7
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

