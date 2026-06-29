Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328BDC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:03:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A5D284866;
	Mon, 29 Jun 2026 10:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="j/86OehC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 605F58496E; Mon, 29 Jun 2026 10:02:48 +0200 (CEST)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76EB684866
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 2026062908024510fd5ccab9000207f9 for <u-boot@lists.denx.de>;
 Mon, 29 Jun 2026 10:02:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=IfbuuzHgYRhOA7tlC8d0i1M70zp5lXCQ4sdR9ng5eXc=;
 b=j/86OehCh2+B77a2y+rALLOcpgFfPBQDBectAYB9V6dAsYUFOEzuN8TTPVGHojxda/ACPq
 87h/t+EGJ4WKZaPVcxrZf1WbjK2Qrg3VFXDNCzyeSH/0Or2XgeWzFC4pe1qSY0jtRSf/T5zv
 N5Z0n+TGwVlevOm4TnquuMwnmgdgHxpllz+yAkKjSkV9zC4ONoTvJEciUdPAOLY7xInFzlvT
 2szmA9n0yARuvk1kQASG3ZVvZpbMaDlgMap9YJoX9CG8lL9WyQQ0V+r+JA7UwgtzDC8jZq3p
 89vUfPXFgWdAaiu+C32+R5R9pIrdwSCRdzFCrupqh0fzeXDCsc801dWA==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 5/6] tpm: unify the eventlog initialization
Date: Mon, 29 Jun 2026 10:01:04 +0200
Message-ID: <20260629080241.36311-3-ludwig.nussel@siemens.com>
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

When measured boot is enabled the EFI code is trying to initialize the
eventlog using tcg2_log_prepare_buffer() and then adds an EV_S_CRTM_VERSION
by calling efi_append_scrtm_version().

Part of the EFI code was moved to the TPM core so bootm, booti etc can use
it. A similar function called tcg2_measurement_init() function was added
which is doing the same thing.

A previous patch is unifying the internal eventlog structure we use
whether the measurements are done via EFI TCG spec, or the bootX commands.

There's a minor difference between the EFI code and the TPM one.
The EFI part is appending events to the log using tcg2_agile_log_append(),
while the TPM core calls tcg2_log_append_check(). The reason for that is
that the EFI spec expects certain error codes and actions when
GetEventLog has been called or the log buffer is full. Since this is the
first event we add, the functions above will behave identically. On top
of that I plan to unify those as well.

So for now get rid of the efi_append_scrtm_version() and call
tcg2_measurement_init() from EFI as well.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
---

(no changes since v1)

 include/tpm_tcg2.h        | 20 --------------------
 lib/efi_loader/efi_tcg2.c | 36 ++----------------------------------
 lib/tpm_tcg2.c            | 21 +++++++++++++++++++--
 3 files changed, 21 insertions(+), 56 deletions(-)

diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
index e954a276ecd..387073fd8a2 100644
--- a/include/tpm_tcg2.h
+++ b/include/tpm_tcg2.h
@@ -279,26 +279,6 @@ int tcg2_measure_data(struct udevice *dev, struct tcg2_event_log *elog,
 	tcg2_measure_data(dev, elog, pcr_index, 0, NULL, event_type, size, \
 			  event)
 
-/**
- * Prepare the event log buffer. This function tries to discover an existing
- * event log in memory from a previous bootloader stage. If such a log exists
- * and the PCRs are not extended, the log is "replayed" to extend the PCRs.
- * If no log is discovered, create the log header.
- *
- * @dev			TPM device
- * @elog		Platform event log. The log pointer and log_size
- *			members must be initialized to either 0 or to a valid
- *			memory region, in which case any existing log
- *			discovered will be copied to the specified memory
- *			region.
- * @ignore_existing_log	Boolean to indicate whether or not to ignore an
- *			existing platform log in memory
- *
- * Return: zero on success, negative errno otherwise
- */
-int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
-			    bool ignore_existing_log);
-
 /**
  * Begin measurements.
  *
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 85e7ecd0583..1da0bc37fa1 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -859,24 +859,6 @@ out:
 	return ret;
 }
 
-/**
- * efi_append_scrtm_version - Append an S-CRTM EV_S_CRTM_VERSION event on the
- *			      eventlog and extend the PCRs
- *
- * @dev:	TPM device
- *
- * @Return:	status code
- */
-static efi_status_t efi_append_scrtm_version(struct udevice *dev)
-{
-	efi_status_t ret;
-
-	ret = measure_event(dev, 0, EV_S_CRTM_VERSION,
-			    strlen(version_string) + 1, (u8 *)version_string);
-
-	return ret;
-}
-
 /**
  * efi_init_event_log() - initialize an eventlog
  *
@@ -888,7 +870,6 @@ static efi_status_t efi_init_event_log(void)
 	 * vendor_info_size is currently set to 0, we need to change the length
 	 * and allocate the flexible array member if this changes
 	 */
-	struct tcg2_event_log elog;
 	struct udevice *dev;
 	efi_status_t ret;
 	int rc;
@@ -922,26 +903,13 @@ static efi_status_t efi_init_event_log(void)
 	 * Check if earlier firmware have passed any eventlog. Different
 	 * platforms can use different ways to do so.
 	 */
-	elog.log = event_log.log;
-	elog.log_size = CONFIG_TPM2_EVENT_LOG_SIZE;
-	rc = tcg2_log_prepare_buffer(dev, &elog, false);
+	event_log.log_size = CONFIG_TPM2_EVENT_LOG_SIZE;
+	rc = tcg2_measurement_init(dev, &event_log, false);
 	if (rc) {
 		ret = (rc == -ENOBUFS) ? EFI_BUFFER_TOO_SMALL : EFI_DEVICE_ERROR;
 		goto free_pool;
 	}
 
-	event_log.log_position = elog.log_position;
-
-	/*
-	 * Add SCRTM version to the log if previous firmmware
-	 * doesn't pass an eventlog.
-	 */
-	if (!elog.found) {
-		ret = efi_append_scrtm_version(dev);
-		if (ret != EFI_SUCCESS)
-			goto free_pool;
-	}
-
 	ret = create_final_event();
 	if (ret != EFI_SUCCESS)
 		goto free_pool;
diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 2270b038cf5..e8fa7db5b06 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -564,8 +564,25 @@ int tcg2_measure_data(struct udevice *dev, struct tcg2_event_log *elog,
 				     event_size, event);
 }
 
-int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
-			    bool ignore_existing_log)
+/**
+ * Prepare the event log buffer. This function tries to discover an existing
+ * event log in memory from a previous bootloader stage. If such a log exists
+ * and the PCRs are not extended, the log is "replayed" to extend the PCRs.
+ * If no log is discovered, create the log header.
+ *
+ * @dev			TPM device
+ * @elog		Platform event log. The log pointer and log_size
+ *			members must be initialized to either 0 or to a valid
+ *			memory region, in which case any existing log
+ *			discovered will be copied to the specified memory
+ *			region.
+ * @ignore_existing_log	Boolean to indicate whether or not to ignore an
+ *			existing platform log in memory
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+static int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
+				   bool ignore_existing_log)
 {
 	struct tcg2_event_log log = {};
 	int rc;
-- 
2.43.0

