Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEBFD29C40
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 16:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5167983981;
	Mon, 19 Jan 2026 17:08:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ICvw4Zj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81FF88397D; Mon, 19 Jan 2026 17:08:00 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75D3E8003E
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 17:07:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id DE8E81A296F;
 Mon, 19 Jan 2026 16:07:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B306A60731;
 Mon, 19 Jan 2026 16:07:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1BC1910B6B18B; Mon, 19 Jan 2026 17:07:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1768838877; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=YOVBl0pvYwc4JSy2DQPa3o8smEfzuObxI34kE7ey2ow=;
 b=ICvw4Zj7gdHfB3M4wFkDaTQ+HDcWNqWp8C1fep/3PnowG0qgppWOADzdLrjF9Vc2LFT/5E
 4MbCQHm9yt13v2Cb3Xm+ViaqlSEwZ5JwdG3sDDc4vytHFnCP58eN9rB+0cqUaMQ4nck21O
 yqfjlf2gJ4L82JnUAChcn3uEohsj0XM6/9SBptkuCZ/x0i37UWSFgw3rzfJaqSwP74TWfo
 gHdf+n1M7TrzcOe7DHrxHVg0GOTD5v5kHBvNb1QV/MKARcBBJJBD/mKJBwvxQgiX2yM8Ed
 xV3QIxZDAKhouYMbBPjWwns/EpN2Ka6VS4XF3UdTcr8wg5IOUsUBHVrzGkkGKA==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/2] fwu: Pass bank state enum to
 fwu_state_machine_updates()
Date: Mon, 19 Jan 2026 17:07:41 +0100
Message-ID: <20260119160746.1330877-2-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119160746.1330877-1-kory.maincent@bootlin.com>
References: <20260119160746.1330877-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Change fwu_state_machine_updates() to accept an enum fwu_bank_states
parameter instead of a boolean. This makes the function interface more
explicit and prepares for adding FWU_BANK_INVALID support to handle
boot failures on the active bank.

Convert the FWU_BANK_* defines to an enum and update all call sites
accordingly.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- Refactors fwu_state_machine_updates() to use enum as parameter instead
  of adding a new fwu_invalid_bank() helper.
---
 include/fwu.h                | 22 ++++++++--------
 lib/efi_loader/efi_capsule.c |  5 ++--
 lib/fwu_updates/fwu_v1.c     | 16 ++++++------
 lib/fwu_updates/fwu_v2.c     | 50 +++++++++++++++---------------------
 4 files changed, 44 insertions(+), 49 deletions(-)

diff --git a/include/fwu.h b/include/fwu.h
index e7bd1d492af..9cee8fb085c 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -80,9 +80,11 @@ struct fwu_mdata_ops {
 
 #define FWU_IMAGE_ACCEPTED	0x1
 
-#define FWU_BANK_INVALID	(uint8_t)0xFF
-#define FWU_BANK_VALID		(uint8_t)0xFE
-#define FWU_BANK_ACCEPTED	(uint8_t)0xFC
+enum fwu_bank_states {
+	FWU_BANK_INVALID = 0xFF,
+	FWU_BANK_VALID = 0xFE,
+	FWU_BANK_ACCEPTED = 0xFC,
+};
 
 enum {
 	PRIMARY_PART = 1,
@@ -396,24 +398,24 @@ int fwu_get_mdata_size(uint32_t *mdata_size);
 
 /**
  * fwu_state_machine_updates() - Update FWU state of the platform
- * @trial_state: Is platform transitioning into Trial State
+ * @state: FWU bank state
  * @update_index: Bank number to which images have been updated
  *
- * On successful completion of updates, transition the platform to
- * either Trial State or Regular State.
+ * FWU_BANK_VALID transition the platform to Trial state
+ * FWU_BANK_ACCEPTED accept the FWU bank state
+ * FWU_BANK_INVALID invalid the FWU bank state
  *
  * To transition the platform to Trial State, start the
  * TrialStateCtr counter, followed by setting the value of bank_state
  * field of the metadata to Valid state(applicable only in version 2
  * of metadata).
  *
- * In case, the platform is to transition directly to Regular State,
- * update the bank_state field of the metadata to Accepted
- * state(applicable only in version 2 of metadata).
+ * Saving the bank_state field of the metadata is only applicable in
+ * version 2 of metadata.
  *
  * Return: 0 if OK, -ve on error
  */
-int fwu_state_machine_updates(bool trial_state, uint32_t update_index);
+int fwu_state_machine_updates(enum fwu_bank_states state, uint32_t update_index);
 
 /**
  * fwu_init() - FWU specific initialisations
diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 89e63ed8dd5..e0f9a6efa25 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -465,7 +465,7 @@ static __maybe_unused efi_status_t fwu_empty_capsule_process(
 			log_err("Unable to set the Accept bit for the image %pUs\n",
 				image_guid);
 
-		status = fwu_state_machine_updates(0, active_idx);
+		status = fwu_state_machine_updates(FWU_BANK_ACCEPTED, active_idx);
 		if (status < 0)
 			ret = EFI_DEVICE_ERROR;
 
@@ -510,7 +510,8 @@ static __maybe_unused efi_status_t fwu_post_update_process(bool fw_accept_os)
 		log_err("Failed to update FWU metadata index values\n");
 	} else {
 		log_debug("Successfully updated the active_index\n");
-		status = fwu_state_machine_updates(fw_accept_os ? 1 : 0,
+		status = fwu_state_machine_updates(fw_accept_os ?
+						   FWU_BANK_VALID : FWU_BANK_ACCEPTED,
 						   update_index);
 		if (status < 0)
 			ret = EFI_DEVICE_ERROR;
diff --git a/lib/fwu_updates/fwu_v1.c b/lib/fwu_updates/fwu_v1.c
index 974abf216f6..5824cca98cf 100644
--- a/lib/fwu_updates/fwu_v1.c
+++ b/lib/fwu_updates/fwu_v1.c
@@ -98,27 +98,27 @@ void fwu_populate_mdata_image_info(struct fwu_data *data)
 
 /**
  * fwu_state_machine_updates() - Update FWU state of the platform
- * @trial_state: Is platform transitioning into Trial State
+ * @state: FWU bank state
  * @update_index: Bank number to which images have been updated
  *
- * On successful completion of updates, transition the platform to
- * either Trial State or Regular State.
+ * FWU_BANK_VALID transition the platform to Trial state
+ * FWU_BANK_ACCEPTED accept the FWU bank state
+ * FWU_BANK_INVALID invalid the FWU bank state
  *
  * To transition the platform to Trial State, start the
  * TrialStateCtr counter, followed by setting the value of bank_state
  * field of the metadata to Valid state(applicable only in version 2
  * of metadata).
  *
- * In case, the platform is to transition directly to Regular State,
- * update the bank_state field of the metadata to Accepted
- * state(applicable only in version 2 of metadata).
+ * Saving the bank_state field of the metadata is only applicable in
+ * version 2 of metadata.
  *
  * Return: 0 if OK, -ve on error
  */
-int fwu_state_machine_updates(bool trial_state,
+int fwu_state_machine_updates(enum fwu_bank_states state,
 			      uint32_t update_index)
 {
-	return fwu_trial_state_update(trial_state, update_index);
+	return fwu_trial_state_update(state == FWU_BANK_VALID, update_index);
 }
 
 /**
diff --git a/lib/fwu_updates/fwu_v2.c b/lib/fwu_updates/fwu_v2.c
index 159315b45b9..f48b6d1264b 100644
--- a/lib/fwu_updates/fwu_v2.c
+++ b/lib/fwu_updates/fwu_v2.c
@@ -80,42 +80,27 @@ static int fwu_mdata_sanity_checks(void)
 	return 0;
 }
 
-static int fwu_bank_state_update(bool trial_state, uint32_t bank)
+static int fwu_bank_state_update(enum fwu_bank_states state, uint32_t bank)
 {
 	int ret;
 	struct fwu_data *data = fwu_get_data();
 	struct fwu_mdata *mdata = data->fwu_mdata;
 
-	if (!trial_state && !fwu_bank_accepted(data, bank))
+	if (state == FWU_BANK_ACCEPTED && !fwu_bank_accepted(data, bank))
 		return 0;
 
-	mdata->bank_state[bank] = data->bank_state[bank] = trial_state ?
-		FWU_BANK_VALID : FWU_BANK_ACCEPTED;
+	mdata->bank_state[bank] = (uint8_t)state;
+	data->bank_state[bank] = (uint8_t)state;
 
 	ret = fwu_sync_mdata(mdata, BOTH_PARTS);
 	if (ret)
 		log_err("Unable to set bank_state for bank %u\n", bank);
 	else
-		data->trial_state = trial_state;
+		data->trial_state = state == FWU_BANK_VALID ? 1 : 0;
 
 	return ret;
 }
 
-static int fwu_trial_state_start(uint update_index)
-{
-	int ret;
-
-	ret = fwu_trial_state_ctr_start();
-	if (ret)
-		return ret;
-
-	ret = fwu_bank_state_update(1, update_index);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static bool fwu_get_mdata_mandatory(uint part)
 {
 	int ret = 0;
@@ -171,27 +156,34 @@ void fwu_populate_mdata_image_info(struct fwu_data *data)
 
 /**
  * fwu_state_machine_updates() - Update FWU state of the platform
- * @trial_state: Is platform transitioning into Trial State
+ * @state: FWU bank state
  * @update_index: Bank number to which images have been updated
  *
- * On successful completion of updates, transition the platform to
- * either Trial State or Regular State.
+ * FWU_BANK_VALID transition the platform to Trial state
+ * FWU_BANK_ACCEPTED accept the FWU bank state
+ * FWU_BANK_INVALID invalid the FWU bank state
  *
  * To transition the platform to Trial State, start the
  * TrialStateCtr counter, followed by setting the value of bank_state
  * field of the metadata to Valid state(applicable only in version 2
  * of metadata).
  *
- * In case, the platform is to transition directly to Regular State,
- * update the bank_state field of the metadata to Accepted
- * state(applicable only in version 2 of metadata).
+ * Saving the bank_state field of the metadata is only applicable in
+ * version 2 of metadata.
  *
  * Return: 0 if OK, -ve on error
  */
-int fwu_state_machine_updates(bool trial_state, uint32_t update_index)
+int fwu_state_machine_updates(enum fwu_bank_states state, uint32_t update_index)
 {
-	return trial_state ? fwu_trial_state_start(update_index) :
-		fwu_bank_state_update(0, update_index);
+	int ret;
+
+	if (state == FWU_BANK_VALID) {
+		ret = fwu_trial_state_ctr_start();
+		if (ret)
+			return ret;
+	}
+
+	return fwu_bank_state_update(state, update_index);
 }
 
 /**
-- 
2.43.0

