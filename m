Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80135C47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 11:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7889B87B0D;
	Mon, 22 Jan 2024 12:55:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E02C387B26; Mon, 22 Jan 2024 12:55:30 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 402D787950
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 12:55:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE7B41FB;
 Mon, 22 Jan 2024 03:56:13 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D20663F73F;
 Mon, 22 Jan 2024 03:55:24 -0800 (PST)
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
Subject: [PATCH 05/18] lib: fwu: Make changes to support version 2 of FWU
 metadata
Date: Mon, 22 Jan 2024 17:24:26 +0530
Message-Id: <20240122115439.653871-6-sughosh.ganu@linaro.org>
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

Make changes to the FWU library functions which are used to access the
metadata structure to support version 2 of the metadata.

At a broad level, the following are the changes made
 - Use a pointer g_mdata instead of a variable, and allocate space for
   it at runtime.
 - Obtain the number of banks and number of images per bank from the
   metadata at runtime, instead of using config values.
 - Get the size of the metadata from the metadata structure, instead
   of using build-time value.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 include/fwu.h         |   6 ++-
 lib/fwu_updates/fwu.c | 112 ++++++++++++++++++++++++------------------
 2 files changed, 68 insertions(+), 50 deletions(-)

diff --git a/include/fwu.h b/include/fwu.h
index d3e97a5360..d21c8c6f93 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -52,9 +52,13 @@ struct fwu_mdata_ops {
 			   bool primary, uint32_t size);
 };
 
-#define FWU_MDATA_VERSION	0x1
+#define FWU_MDATA_VERSION	0x2
 #define FWU_IMAGE_ACCEPTED	0x1
 
+#define FWU_BANK_INVALID	0xFF
+#define FWU_BANK_VALID		0xFE
+#define FWU_BANK_ACCEPTED	0xFC
+
 /*
 * GUID value defined in the FWU specification for identification
 * of the FWU metadata partition.
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 5bfa24067b..831ff6aa91 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -17,7 +17,7 @@
 
 #include <u-boot/crc.h>
 
-static struct fwu_mdata g_mdata; /* = {0} makes uninit crc32 always invalid */
+static struct fwu_mdata *g_mdata;
 static struct udevice *g_dev;
 static u8 in_trial;
 static u8 boottime_check;
@@ -108,21 +108,9 @@ out:
 
 static int in_trial_state(struct fwu_mdata *mdata)
 {
-	u32 i, active_bank;
-	struct fwu_image_entry *img_entry;
-	struct fwu_image_bank_info *img_bank_info;
-
-	active_bank = mdata->active_index;
-	img_entry = &mdata->img_entry[0];
-	for (i = 0; i < CONFIG_FWU_NUM_IMAGES_PER_BANK; i++) {
-		img_bank_info = &img_entry[i].img_bank_info[active_bank];
-		if (!img_bank_info->accepted) {
-			log_info("System booting in Trial State\n");
-			return 1;
-		}
-	}
+	u32 active_bank = mdata->active_index;
 
-	return 0;
+	return mdata->bank_state[active_bank] == FWU_BANK_VALID ? 1 : 0;
 }
 
 static int fwu_get_image_type_id(u8 image_index, efi_guid_t *image_type_id)
@@ -150,8 +138,9 @@ static int fwu_get_image_type_id(u8 image_index, efi_guid_t *image_type_id)
  */
 static int fwu_sync_mdata(struct fwu_mdata *mdata, int part)
 {
-	void *buf = &mdata->version;
 	int err;
+	uint32_t mdata_size;
+	void *buf = &mdata->version;
 
 	if (part == BOTH_PARTS) {
 		err = fwu_sync_mdata(mdata, SECONDARY_PART);
@@ -165,9 +154,10 @@ static int fwu_sync_mdata(struct fwu_mdata *mdata, int part)
 	 * and put the updated value in the FWU metadata crc32
 	 * field
 	 */
-	mdata->crc32 = crc32(0, buf, sizeof(*mdata) - sizeof(u32));
+	mdata_size = mdata->metadata_size;
+	mdata->crc32 = crc32(0, buf, mdata_size - sizeof(u32));
 
-	err = fwu_write_mdata(g_dev, mdata, part == PRIMARY_PART);
+	err = fwu_write_mdata(g_dev, mdata, part == PRIMARY_PART, mdata_size);
 	if (err) {
 		log_err("Unable to write %s mdata\n",
 			part == PRIMARY_PART ?  "primary" : "secondary");
@@ -175,7 +165,7 @@ static int fwu_sync_mdata(struct fwu_mdata *mdata, int part)
 	}
 
 	/* update the cached copy of meta-data */
-	memcpy(&g_mdata, mdata, sizeof(struct fwu_mdata));
+	memcpy(g_mdata, mdata, mdata_size);
 
 	return 0;
 }
@@ -183,8 +173,12 @@ static int fwu_sync_mdata(struct fwu_mdata *mdata, int part)
 static inline int mdata_crc_check(struct fwu_mdata *mdata)
 {
 	void *buf = &mdata->version;
-	u32 calc_crc32 = crc32(0, buf, sizeof(*mdata) - sizeof(u32));
+	u32 calc_crc32;
+
+	if (!mdata->metadata_size)
+		return -EINVAL;
 
+	calc_crc32 = crc32(0, buf, mdata->metadata_size - sizeof(u32));
 	return calc_crc32 == mdata->crc32 ? 0 : -EINVAL;
 }
 
@@ -309,27 +303,32 @@ __maybe_unused int fwu_get_banks_images(u8 *nbanks, u16 *nimages)
 int fwu_get_mdata(struct fwu_mdata *mdata)
 {
 	int err;
+	uint32_t mdata_size;
 	bool parts_ok[2] = { false };
-	struct fwu_mdata s, *parts_mdata[2];
+	struct fwu_mdata *parts_mdata[2];
+
+	err = fwu_get_mdata_size(&mdata_size);
+	if (err)
+		return err;
 
-	parts_mdata[0] = &g_mdata;
-	parts_mdata[1] = &s;
+	parts_mdata[0] = g_mdata;
+	parts_mdata[1] = (struct fwu_mdata *)((char *)g_mdata + mdata_size);
 
 	/* if mdata already read and ready */
-	err = mdata_crc_check(parts_mdata[0]);
-	if (!err)
+	if (!mdata_crc_check(parts_mdata[0]))
 		goto ret_mdata;
-	/* else read, verify and, if needed, fix mdata */
 
+	/* else read, verify and, if needed, fix mdata */
 	for (int i = 0; i < 2; i++) {
 		parts_ok[i] = false;
-		err = fwu_read_mdata(g_dev, parts_mdata[i], !i);
+		err = fwu_read_mdata(g_dev, parts_mdata[i], !i, mdata_size);
 		if (!err) {
 			err = mdata_crc_check(parts_mdata[i]);
 			if (!err)
 				parts_ok[i] = true;
 			else
-				log_debug("mdata : %s crc32 failed\n", i ? "secondary" : "primary");
+				log_debug("mdata : %s crc32 failed\n",
+					  i ? "secondary" : "primary");
 		}
 	}
 
@@ -338,7 +337,8 @@ int fwu_get_mdata(struct fwu_mdata *mdata)
 		 * Before returning, check that both the
 		 * FWU metadata copies are the same.
 		 */
-		err = memcmp(parts_mdata[0], parts_mdata[1], sizeof(struct fwu_mdata));
+		err = memcmp(parts_mdata[0], parts_mdata[1],
+			     mdata_size);
 		if (!err)
 			goto ret_mdata;
 
@@ -355,7 +355,8 @@ int fwu_get_mdata(struct fwu_mdata *mdata)
 		if (parts_ok[i])
 			continue;
 
-		memcpy(parts_mdata[i], parts_mdata[1 - i], sizeof(struct fwu_mdata));
+		memcpy(parts_mdata[i], parts_mdata[1 - i],
+		       mdata_size);
 		err = fwu_sync_mdata(parts_mdata[i], i ? SECONDARY_PART : PRIMARY_PART);
 		if (err) {
 			log_debug("mdata : %s write failed\n", i ? "secondary" : "primary");
@@ -365,7 +366,7 @@ int fwu_get_mdata(struct fwu_mdata *mdata)
 
 ret_mdata:
 	if (!err && mdata)
-		memcpy(mdata, parts_mdata[0], sizeof(struct fwu_mdata));
+		memcpy(mdata, parts_mdata[0], mdata_size);
 
 	return err;
 }
@@ -383,14 +384,16 @@ ret_mdata:
 int fwu_get_active_index(uint *active_idx)
 {
 	int ret = 0;
-	struct fwu_mdata *mdata = &g_mdata;
+	u8 num_banks;
+	struct fwu_mdata *mdata = g_mdata;
 
 	/*
 	 * Found the FWU metadata partition, now read the active_index
 	 * value
 	 */
 	*active_idx = mdata->active_index;
-	if (*active_idx >= CONFIG_FWU_NUM_BANKS) {
+	num_banks = mdata->fw_desc[0].num_banks;
+	if (*active_idx >= num_banks) {
 		log_debug("Active index value read is incorrect\n");
 		ret = -EINVAL;
 	}
@@ -410,9 +413,11 @@ int fwu_get_active_index(uint *active_idx)
 int fwu_set_active_index(uint active_idx)
 {
 	int ret;
-	struct fwu_mdata *mdata = &g_mdata;
+	u8 num_banks;
+	struct fwu_mdata *mdata = g_mdata;
 
-	if (active_idx >= CONFIG_FWU_NUM_BANKS) {
+	num_banks = mdata->fw_desc[0].num_banks;
+	if (active_idx >= num_banks) {
 		log_debug("Invalid active index value\n");
 		return -EINVAL;
 	}
@@ -452,9 +457,10 @@ int fwu_set_active_index(uint active_idx)
 int fwu_get_dfu_alt_num(u8 image_index, u8 *alt_num)
 {
 	int ret, i;
+	u16 num_images;
 	uint update_bank;
 	efi_guid_t *image_guid, image_type_id;
-	struct fwu_mdata *mdata = &g_mdata;
+	struct fwu_mdata *mdata = g_mdata;
 	struct fwu_image_entry *img_entry;
 	struct fwu_image_bank_info *img_bank_info;
 
@@ -473,15 +479,16 @@ int fwu_get_dfu_alt_num(u8 image_index, u8 *alt_num)
 
 	ret = -EINVAL;
 	/*
-	 * The FWU metadata has been read. Now get the image_uuid for the
+	 * The FWU metadata has been read. Now get the image_guid for the
 	 * image with the update_bank.
 	 */
-	for (i = 0; i < CONFIG_FWU_NUM_IMAGES_PER_BANK; i++) {
+	num_images = mdata->fw_desc[0].num_images;
+	for (i = 0; i < num_images; i++) {
 		if (!guidcmp(&image_type_id,
-			     &mdata->img_entry[i].image_type_uuid)) {
-			img_entry = &mdata->img_entry[i];
+			     &mdata->fw_desc[0].img_entry[i].image_type_guid)) {
+			img_entry = &mdata->fw_desc[0].img_entry[i];
 			img_bank_info = &img_entry->img_bank_info[update_bank];
-			image_guid = &img_bank_info->image_uuid;
+			image_guid = &img_bank_info->image_guid;
 			ret = fwu_plat_get_alt_num(g_dev, image_guid, alt_num);
 			if (ret)
 				log_debug("alt_num not found for partition with GUID %pUs\n",
@@ -515,7 +522,7 @@ int fwu_revert_boot_index(void)
 {
 	int ret;
 	u32 cur_active_index;
-	struct fwu_mdata *mdata = &g_mdata;
+	struct fwu_mdata *mdata = g_mdata;
 
 	/*
 	 * Swap the active index and previous_active_index fields
@@ -556,13 +563,15 @@ int fwu_revert_boot_index(void)
 static int fwu_clrset_image_accept(efi_guid_t *img_type_id, u32 bank, u8 action)
 {
 	int ret, i;
-	struct fwu_mdata *mdata = &g_mdata;
+	u16 num_images;
+	struct fwu_mdata *mdata = g_mdata;
 	struct fwu_image_entry *img_entry;
 	struct fwu_image_bank_info *img_bank_info;
 
-	img_entry = &mdata->img_entry[0];
-	for (i = 0; i < CONFIG_FWU_NUM_IMAGES_PER_BANK; i++) {
-		if (!guidcmp(&img_entry[i].image_type_uuid, img_type_id)) {
+	img_entry = &mdata->fw_desc[0].img_entry[0];
+	num_images = mdata->fw_desc[0].num_images;
+	for (i = 0; i < num_images; i++) {
+		if (!guidcmp(&img_entry[i].image_type_guid, img_type_id)) {
 			img_bank_info = &img_entry[i].img_bank_info[bank];
 			if (action == IMAGE_ACCEPT_SET)
 				img_bank_info->accepted |= FWU_IMAGE_ACCEPTED;
@@ -671,12 +680,15 @@ __weak int fwu_plat_get_update_index(uint *update_idx)
 {
 	int ret;
 	u32 active_idx;
+	u8 num_banks;
+	struct fwu_mdata *mdata = g_mdata;
 
 	ret = fwu_get_active_index(&active_idx);
 	if (ret < 0)
 		return -1;
 
-	*update_idx = (active_idx + 1) % CONFIG_FWU_NUM_BANKS;
+	num_banks = mdata->fw_desc[0].num_banks;
+	*update_idx = (active_idx + 1) % num_banks;
 
 	return ret;
 }
@@ -755,6 +767,7 @@ int fwu_trial_state_ctr_start(void)
 static int fwu_boottime_checks(void)
 {
 	int ret;
+	u8 num_banks;
 	u32 boot_idx, active_idx;
 
 	ret = uclass_first_device_err(UCLASS_FWU_MDATA, &g_dev);
@@ -785,7 +798,8 @@ static int fwu_boottime_checks(void)
 	 * update the active_index.
 	 */
 	fwu_plat_get_bootidx(&boot_idx);
-	if (boot_idx >= CONFIG_FWU_NUM_BANKS) {
+	num_banks = g_mdata->fw_desc[0].num_banks;
+	if (boot_idx >= num_banks) {
 		log_err("Received incorrect value of boot_index\n");
 		return 0;
 	}
@@ -807,7 +821,7 @@ static int fwu_boottime_checks(void)
 	if (efi_init_obj_list() != EFI_SUCCESS)
 		return 0;
 
-	in_trial = in_trial_state(&g_mdata);
+	in_trial = in_trial_state(g_mdata);
 	if (!in_trial || (ret = fwu_trial_count_update()) > 0)
 		ret = trial_counter_update(NULL);
 
-- 
2.34.1

