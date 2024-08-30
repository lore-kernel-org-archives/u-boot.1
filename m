Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1185CA0FE4
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 11:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CAF488B27;
	Fri, 30 Aug 2024 13:41:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 279AC88A5B; Fri, 30 Aug 2024 13:41:22 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E3DEF88B40
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 13:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 789ED339;
 Fri, 30 Aug 2024 04:41:45 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 689063F66E;
 Fri, 30 Aug 2024 04:41:17 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 4/6] fwu: check all images for transitioning out of Trial State
Date: Fri, 30 Aug 2024 17:10:55 +0530
Message-Id: <20240830114057.891069-5-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830114057.891069-1-sughosh.ganu@linaro.org>
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
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

The platform transitions out of Trial State into the Regular State
only when all the images in the update bank have been accepted. Check
for this condition before transitioning out of Trial State.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 include/fwu.h            | 11 +++++++++++
 lib/fwu_updates/fwu.c    | 25 +++++++++++++++++++++++++
 lib/fwu_updates/fwu_v1.c |  9 ++++++---
 lib/fwu_updates/fwu_v2.c |  3 +++
 4 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/include/fwu.h b/include/fwu.h
index 77ec65e618..70a5166f5e 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -417,4 +417,15 @@ int fwu_state_machine_updates(bool trial_state, uint32_t update_index);
  */
 int fwu_init(void);
 
+/**
+ * fwu_bank_accepted() - Has the bank been accepted
+ * @data: Version agnostic FWU metadata information
+ * @bank: Update bank to check
+ *
+ * Check in the given bank if all the images have been accepted.
+ *
+ * Return: true if all images accepted, false otherwise
+ */
+bool fwu_bank_accepted(struct fwu_data *data, uint32_t bank);
+
 #endif /* _FWU_H_ */
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index c7fc8987be..a94a769a2b 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -28,6 +28,31 @@ enum {
 	IMAGE_ACCEPT_CLEAR,
 };
 
+/**
+ * fwu_bank_accepted() - Has the bank been accepted
+ * @data: Version agnostic FWU metadata information
+ * @bank: Update bank to check
+ *
+ * Check in the given bank if all the images have been accepted.
+ *
+ * Return: true if all images accepted, false otherwise
+ */
+bool fwu_bank_accepted(struct fwu_data *data, uint32_t bank)
+{
+	u32 i;
+	struct fwu_image_entry *img_entry;
+	struct fwu_image_bank_info *img_bank_info;
+
+	img_entry = &data->fwu_images[0];
+	for (i = 0; i < CONFIG_FWU_NUM_IMAGES_PER_BANK; i++) {
+		img_bank_info = &img_entry[i].img_bank_info[bank];
+		if (!img_bank_info->accepted)
+			return false;
+	}
+
+	return true;
+}
+
 static int trial_counter_update(u16 *trial_state_ctr)
 {
 	bool delete;
diff --git a/lib/fwu_updates/fwu_v1.c b/lib/fwu_updates/fwu_v1.c
index 023e43728d..c311a8857a 100644
--- a/lib/fwu_updates/fwu_v1.c
+++ b/lib/fwu_updates/fwu_v1.c
@@ -52,11 +52,14 @@ static void fwu_data_init(void)
 	memcpy(dst_img_info, src_img_info, image_info_size);
 }
 
-static int fwu_trial_state_update(bool trial_state)
+static int fwu_trial_state_update(bool trial_state, uint32_t bank)
 {
 	int ret;
 	struct fwu_data *data = fwu_get_data();
 
+	if (!trial_state && !fwu_bank_accepted(data, bank))
+		return 0;
+
 	if (trial_state) {
 		ret = fwu_trial_state_ctr_start();
 		if (ret)
@@ -112,9 +115,9 @@ void fwu_populate_mdata_image_info(struct fwu_data *data)
  * Return: 0 if OK, -ve on error
  */
 int fwu_state_machine_updates(bool trial_state,
-			      __maybe_unused uint32_t update_index)
+			      uint32_t update_index)
 {
-	return fwu_trial_state_update(trial_state);
+	return fwu_trial_state_update(trial_state, update_index);
 }
 
 /**
diff --git a/lib/fwu_updates/fwu_v2.c b/lib/fwu_updates/fwu_v2.c
index 69306282aa..9c696952ed 100644
--- a/lib/fwu_updates/fwu_v2.c
+++ b/lib/fwu_updates/fwu_v2.c
@@ -88,6 +88,9 @@ static int fwu_bank_state_update(bool trial_state, uint32_t bank)
 	struct fwu_data *data = fwu_get_data();
 	struct fwu_mdata *mdata = data->fwu_mdata;
 
+	if (!trial_state && !fwu_bank_accepted(data, bank))
+		return 0;
+
 	mdata->bank_state[bank] = data->bank_state[bank] = trial_state ?
 		FWU_BANK_VALID : FWU_BANK_ACCEPTED;
 
-- 
2.34.1

