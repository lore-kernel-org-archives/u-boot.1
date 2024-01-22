Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97440C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 11:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9A0487BE1;
	Mon, 22 Jan 2024 12:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FC4987B1D; Mon, 22 Jan 2024 12:55:42 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BCF318797C
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 12:55:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 378CE1FB;
 Mon, 22 Jan 2024 03:56:23 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 847B63F73F;
 Mon, 22 Jan 2024 03:55:34 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 08/18] fwu: Add a function to put a bank in Trial State
Date: Mon, 22 Jan 2024 17:24:29 +0530
Message-Id: <20240122115439.653871-9-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122115439.653871-1-sughosh.ganu@linaro.org>
References: <20240122115439.653871-1-sughosh.ganu@linaro.org>
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

The version 2 of the FWU metadata has a field in the top level
structure, called bank_state. This is used to keep the state a given
bank is in, either of valid(for trial state), invalid, or accepted.

Update this field when putting the platform in Trial State, in
addition to starting the TrialStateCtr variable by calling the
fwu_trial_state_start() function.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 include/fwu.h                | 12 +++++---
 lib/efi_loader/efi_capsule.c |  2 +-
 lib/fwu_updates/fwu.c        | 54 ++++++++++++++++++++++++++++++------
 3 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/include/fwu.h b/include/fwu.h
index 3764336952..d0b4e12190 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -297,15 +297,19 @@ u8 fwu_update_checks_pass(void);
 u8 fwu_empty_capsule_checks_pass(void);
 
 /**
- * fwu_trial_state_ctr_start() - Start the Trial State counter
+ * fwu_trial_state_start() - Put the platform in Trial State
+ * @update_index: Bank number to which images have been updated
  *
- * Start the counter to identify the platform booting in the
- * Trial State. The counter is implemented as an EFI variable.
+ * Put the platform in Trial State by starting the counter to
+ * identify the platform booting in the Trial State. The
+ * counter is implemented as an EFI variable. Secondly, set
+ * the bank_state in the metadata for the updated bank to Valid
+ * state.
  *
  * Return: 0 if OK, -ve on error
  *
  */
-int fwu_trial_state_ctr_start(void);
+int fwu_trial_state_start(uint update_index);
 
 /**
  * fwu_gen_alt_info_from_mtd() - Parse dfu_alt_info from metadata in mtd
diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index de0d49ebeb..0e6a38b441 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -522,7 +522,7 @@ static __maybe_unused efi_status_t fwu_post_update_process(bool fw_accept_os)
 	} else {
 		log_debug("Successfully updated the active_index\n");
 		if (fw_accept_os) {
-			status = fwu_trial_state_ctr_start();
+			status = fwu_trial_state_start(update_index);
 			if (status < 0)
 				ret = EFI_DEVICE_ERROR;
 		}
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 831ff6aa91..0f43cf63b2 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -590,6 +590,36 @@ out:
 	return ret;
 }
 
+static int fwu_trial_state_ctr_start(void)
+{
+	int ret;
+	u16 trial_state_ctr;
+
+	printf("%s: starting the TrialStateCtr\n", __func__);
+	trial_state_ctr = 0;
+	ret = trial_counter_update(&trial_state_ctr);
+	if (ret)
+		log_err("Unable to initialise TrialStateCtr\n");
+
+	return ret;
+}
+
+static int fwu_set_bank_state_trial(uint update_index)
+{
+	int ret;
+	struct fwu_mdata *mdata = g_mdata;
+
+	mdata->bank_state[update_index] = FWU_BANK_VALID;
+
+	ret = fwu_sync_mdata(mdata, BOTH_PARTS);
+	if (ret) {
+		log_err("Unable to set bank_state for %d bank\n", update_index);
+		return ret;
+	}
+
+	return 0;
+}
+
 /**
  * fwu_bank_state_update() - Check and update the bank_state of the metadata
  * @update_index: Bank for which the bank_state needs to be updated
@@ -743,25 +773,31 @@ u8 fwu_empty_capsule_checks_pass(void)
 }
 
 /**
- * fwu_trial_state_ctr_start() - Start the Trial State counter
+ * fwu_trial_state_start() - Put the platform in Trial State
+ * @update_index: Bank number to which images have been updated
  *
- * Start the counter to identify the platform booting in the
- * Trial State. The counter is implemented as an EFI variable.
+ * Put the platform in Trial State by starting the counter to
+ * identify the platform booting in the Trial State. The
+ * counter is implemented as an EFI variable. Secondly, set
+ * the bank_state in the metadata for the updated bank to Valid
+ * state.
  *
  * Return: 0 if OK, -ve on error
  *
  */
-int fwu_trial_state_ctr_start(void)
+int fwu_trial_state_start(uint update_index)
 {
 	int ret;
-	u16 trial_state_ctr;
 
-	trial_state_ctr = 0;
-	ret = trial_counter_update(&trial_state_ctr);
+	ret = fwu_trial_state_ctr_start();
 	if (ret)
-		log_err("Unable to initialise TrialStateCtr\n");
+		return ret;
 
-	return ret;
+	ret = fwu_set_bank_state_trial(update_index);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static int fwu_boottime_checks(void)
-- 
2.34.1

