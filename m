Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485A0C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABB9684975;
	Mon, 29 Jun 2026 10:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="Ql2Z+ar0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66B8E84866; Mon, 29 Jun 2026 10:02:48 +0200 (CEST)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B66B84832
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20260629080244e2c3822d9800020739 for <u-boot@lists.denx.de>;
 Mon, 29 Jun 2026 10:02:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=YZpZgYhOLIRDCIVIX7kft926eOOPP2rVkymBNOIa1co=;
 b=Ql2Z+ar0QyhmD4mV1MkQtnM3aTP3WZzTdCWYkiPbniyRtAOWF306c3n5ikxNRqN3WQlYoH
 b6TuhdIUQ8hmSmbqutKcE+06gHqh+5AUm88AZim+vR/dSkYvktVzNCkXrKHkt7fAgnWIwgH2
 YgTv+m20JiAKc24dy2zdoUoz5zhF5DdrMGkqLeFbks5RaAfjjtaxDEmWF7AWJz3Hb+pmGXjt
 bxKgVcCDoBHVODrbWbViENRWpPdjgCMaX5WHWCl6Ffe9hE7eHrRf24shSpBdjUOat55wxQb+
 iTHtl65Of4JJDLBoUiSZgZtC5dm+GS8GR62cdnyRCeIJ5zDlS3eymusA==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 4/6] tpm: unify the tcg2 eventlog structures
Date: Mon, 29 Jun 2026 10:01:03 +0200
Message-ID: <20260629080241.36311-2-ludwig.nussel@siemens.com>
In-Reply-To: <20260629080241.36311-1-ludwig.nussel@siemens.com>
References: <20260629080241.36311-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

We currently have two structures describing the internal TCG EventLog
buffers we keep in memory.
The first one is 'struct event_log_buffer' and it carries all the
necessary members to keep track of the information needed to implement
the EFI TCG protocol.

The second one is 'struct tcg2_event_log' which was introduced later,
when some functions from the TCG protocol moved to U-Boots core, and is
is used to measure binaries when booting with bootm, booti etc.

The split led to some duplication -- e.g tcg2_measure_data() and
measure_event() functions are very similar with the exception of
extending the EventLog.

Since the latter is a subset of the former, let's move all the members
to a single struct and use that instead.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
---

(no changes since v1)

 include/tpm_tcg2.h        | 15 ++++++++++
 lib/efi_loader/efi_tcg2.c | 60 +++++++++++++--------------------------
 2 files changed, 34 insertions(+), 41 deletions(-)

diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
index db3f6f486e9..e954a276ecd 100644
--- a/include/tpm_tcg2.h
+++ b/include/tpm_tcg2.h
@@ -163,6 +163,15 @@ struct tcg_efi_spec_id_event {
  * @log_size:		Log space available
  * @found:		Boolean indicating if an existing log was discovered
  * @allocated:		Boolean indicating that the log was allocated by u-boot
+ * @final_buffer:	finalevent config table buffer. Only used for EFI
+ * @final_position:	current position of 'final_buffer'. Only used for EFI
+ * @last_event_size: 	Size of the last event. Only used for EFI
+ * @get_event_called:	true if GetEventLog has been invoked at least once.
+ * 			Only used for EFI
+ * @ebs_called:		true if ExitBootServices has been invoked.
+ * 			Only used for EFI
+ * @truncated:		true if the 'buffer' is truncated.
+ * 			Only used for EFI
  */
 struct tcg2_event_log {
 	u8 *log;
@@ -170,6 +179,12 @@ struct tcg2_event_log {
 	u32 log_size;
 	bool found;
 	bool allocated;
+	void *final_buffer;
+	u32 final_position;
+	u32 last_event_size;
+	bool get_event_called;
+	bool ebs_called;
+	bool truncated;
 };
 
 /**
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 1860dc50238..85e7ecd0583 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -25,29 +25,7 @@
 #include <linux/unaligned/generic.h>
 #include <hexdump.h>
 
-/**
- * struct event_log_buffer - internal eventlog management structure
- *
- * @buffer:		eventlog buffer
- * @final_buffer:	finalevent config table buffer
- * @pos:		current position of 'buffer'
- * @final_pos:		current position of 'final_buffer'
- * @get_event_called:	true if GetEventLog has been invoked at least once
- * @ebs_called:		true if ExitBootServices has been invoked
- * @truncated:		true if the 'buffer' is truncated
- */
-struct event_log_buffer {
-	void *buffer;
-	void *final_buffer;
-	size_t pos; /* eventlog position */
-	size_t final_pos; /* final events config table position */
-	size_t last_event_size;
-	bool get_event_called;
-	bool ebs_called;
-	bool truncated;
-};
-
-static struct event_log_buffer event_log;
+static struct tcg2_event_log event_log;
 static bool tcg2_efi_app_invoked;
 /*
  * When requesting TPM2_CAP_TPM_PROPERTIES the value is on a standard offset.
@@ -105,7 +83,7 @@ static efi_status_t tcg2_agile_log_append(u32 pcr_index, u32 event_type,
 					  struct tpml_digest_values *digest_list,
 					  u32 size, u8 event[])
 {
-	void *log = (void *)((uintptr_t)event_log.buffer + event_log.pos);
+	void *log = (void *)((uintptr_t)event_log.log + event_log.log_position);
 	u32 event_size = size + tcg2_event_get_size(digest_list);
 	struct efi_tcg2_final_events_table *final_event;
 	efi_status_t ret = EFI_SUCCESS;
@@ -113,12 +91,12 @@ static efi_status_t tcg2_agile_log_append(u32 pcr_index, u32 event_type,
 	/* if ExitBootServices hasn't been called update the normal log */
 	if (!event_log.ebs_called) {
 		if (event_log.truncated ||
-		    event_log.pos + event_size > CONFIG_TPM2_EVENT_LOG_SIZE) {
+		    event_log.log_position + event_size > CONFIG_TPM2_EVENT_LOG_SIZE) {
 			event_log.truncated = true;
 			return EFI_VOLUME_FULL;
 		}
 		tcg2_log_append(pcr_index, event_type, digest_list, size, event, log);
-		event_log.pos += event_size;
+		event_log.log_position += event_size;
 		event_log.last_event_size = event_size;
 	}
 
@@ -126,15 +104,15 @@ static efi_status_t tcg2_agile_log_append(u32 pcr_index, u32 event_type,
 		return ret;
 
 	/* if GetEventLog has been called update FinalEventLog as well */
-	if (event_log.final_pos + event_size > CONFIG_TPM2_EVENT_LOG_SIZE)
+	if (event_log.final_position + event_size > CONFIG_TPM2_EVENT_LOG_SIZE)
 		return EFI_VOLUME_FULL;
 
-	log = (void *)((uintptr_t)event_log.final_buffer + event_log.final_pos);
+	log = (void *)((uintptr_t)event_log.final_buffer + event_log.final_position);
 	tcg2_log_append(pcr_index, event_type, digest_list, size, event, log);
 
 	final_event = event_log.final_buffer;
 	final_event->number_of_events++;
-	event_log.final_pos += event_size;
+	event_log.final_position += event_size;
 
 	return ret;
 }
@@ -358,8 +336,8 @@ efi_tcg2_get_eventlog(struct efi_tcg2_protocol *this,
 		ret = EFI_SUCCESS;
 		goto out;
 	}
-	*event_log_location = (uintptr_t)event_log.buffer;
-	*event_log_last_entry = (uintptr_t)(event_log.buffer + event_log.pos -
+	*event_log_location = (uintptr_t)event_log.log;
+	*event_log_last_entry = (uintptr_t)(event_log.log + event_log.log_position -
 					    event_log.last_event_size);
 	*event_log_truncated = event_log.truncated;
 	event_log.get_event_called = true;
@@ -799,8 +777,8 @@ static void tcg2_uninit(void)
 	if (ret != EFI_SUCCESS && ret != EFI_NOT_FOUND)
 		log_err("Failed to delete final events config table\n");
 
-	efi_free_pool(event_log.buffer);
-	event_log.buffer = NULL;
+	efi_free_pool(event_log.log);
+	event_log.log = NULL;
 	efi_free_pool(event_log.final_buffer);
 	event_log.final_buffer = NULL;
 
@@ -836,7 +814,7 @@ static efi_status_t create_final_event(void)
 	final_event = event_log.final_buffer;
 	final_event->number_of_events = 0;
 	final_event->version = EFI_TCG2_FINAL_EVENTS_TABLE_VERSION;
-	event_log.final_pos = sizeof(*final_event);
+	event_log.final_position = sizeof(*final_event);
 	ret = efi_install_configuration_table(&efi_guid_final_events,
 					      final_event);
 	if (ret != EFI_SUCCESS) {
@@ -920,7 +898,7 @@ static efi_status_t efi_init_event_log(void)
 
 	ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA,
 				CONFIG_TPM2_EVENT_LOG_SIZE,
-				(void **)&event_log.buffer);
+				(void **)&event_log.log);
 	if (ret != EFI_SUCCESS)
 		return ret;
 
@@ -928,13 +906,13 @@ static efi_status_t efi_init_event_log(void)
 	 * initialize log area as 0xff so the OS can easily figure out the
 	 * last log entry
 	 */
-	memset(event_log.buffer, 0xff, CONFIG_TPM2_EVENT_LOG_SIZE);
+	memset(event_log.log, 0xff, CONFIG_TPM2_EVENT_LOG_SIZE);
 
 	/*
 	 * The log header is defined to be in SHA1 event log entry format.
 	 * Setup event header
 	 */
-	event_log.pos = 0;
+	event_log.log_position = 0;
 	event_log.last_event_size = 0;
 	event_log.get_event_called = false;
 	event_log.ebs_called = false;
@@ -944,7 +922,7 @@ static efi_status_t efi_init_event_log(void)
 	 * Check if earlier firmware have passed any eventlog. Different
 	 * platforms can use different ways to do so.
 	 */
-	elog.log = event_log.buffer;
+	elog.log = event_log.log;
 	elog.log_size = CONFIG_TPM2_EVENT_LOG_SIZE;
 	rc = tcg2_log_prepare_buffer(dev, &elog, false);
 	if (rc) {
@@ -952,7 +930,7 @@ static efi_status_t efi_init_event_log(void)
 		goto free_pool;
 	}
 
-	event_log.pos = elog.log_position;
+	event_log.log_position = elog.log_position;
 
 	/*
 	 * Add SCRTM version to the log if previous firmmware
@@ -971,8 +949,8 @@ static efi_status_t efi_init_event_log(void)
 	return ret;
 
 free_pool:
-	efi_free_pool(event_log.buffer);
-	event_log.buffer = NULL;
+	efi_free_pool(event_log.log);
+	event_log.log = NULL;
 	return ret;
 }
 
-- 
2.43.0

