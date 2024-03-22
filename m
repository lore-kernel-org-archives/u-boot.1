Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F07C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 10:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBAA8881E2;
	Fri, 22 Mar 2024 11:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2B23881EA; Fri, 22 Mar 2024 11:58:38 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 66CC8881DD
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:58:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05CC91007;
 Fri, 22 Mar 2024 03:59:10 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF7723F64C;
 Fri, 22 Mar 2024 03:58:32 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Yann GAUTIER <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Patrick DELAUNAY - foss <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <monstr@monstr.eu>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 08/20] fwu: make changes to access version agnostic
 structure fields
Date: Fri, 22 Mar 2024 16:27:21 +0530
Message-Id: <20240322105733.203888-9-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322105733.203888-1-sughosh.ganu@linaro.org>
References: <20240322105733.203888-1-sughosh.ganu@linaro.org>
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

With addition of support for version 2 of the FWU metadata structure,
the metadata information is collected into a version agnostic
structure. Make changes to the FWU functions so that the information
that was earlier obtained by reading the metadata structure is now
obtained through this version agnostic structure.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2:
* New patch

 include/fwu.h         |  49 +++++++++-
 lib/fwu_updates/fwu.c | 204 ++++++++++++++++++++++++++++--------------
 2 files changed, 186 insertions(+), 67 deletions(-)

diff --git a/include/fwu.h b/include/fwu.h
index 082b5481d1..77ec65e618 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -79,9 +79,18 @@ struct fwu_mdata_ops {
 			   bool primary, uint32_t size);
 };
 
-#define FWU_MDATA_VERSION	0x1
 #define FWU_IMAGE_ACCEPTED	0x1
 
+#define FWU_BANK_INVALID	(uint8_t)0xFF
+#define FWU_BANK_VALID		(uint8_t)0xFE
+#define FWU_BANK_ACCEPTED	(uint8_t)0xFC
+
+enum {
+	PRIMARY_PART = 1,
+	SECONDARY_PART,
+	BOTH_PARTS,
+};
+
 /*
 * GUID value defined in the FWU specification for identification
 * of the FWU metadata partition.
@@ -313,6 +322,44 @@ int fwu_gen_alt_info_from_mtd(char *buf, size_t len, struct mtd_info *mtd);
  */
 int fwu_mtd_get_alt_num(efi_guid_t *image_guid, u8 *alt_num, const char *mtd_dev);
 
+/**
+ * fwu_mdata_copies_allocate() - Allocate memory for metadata
+ * @mdata_size: Size of the metadata structure
+ *
+ * Allocate memory for storing both the copies of the FWU metadata. The
+ * copies are then used as a cache for storing FWU metadata contents.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_mdata_copies_allocate(u32 mdata_size);
+
+/**
+ * fwu_get_dev() - Return the FWU metadata device
+ *
+ * Return the pointer to the FWU metadata device.
+ *
+ * Return: Pointer to the FWU metadata dev
+ */
+struct udevice *fwu_get_dev(void);
+
+/**
+ * fwu_get_data() - Return the version agnostic FWU structure
+ *
+ * Return the pointer to the version agnostic FWU structure.
+ *
+ * Return: Pointer to the FWU data structure
+ */
+struct fwu_data *fwu_get_data(void);
+
+/**
+ * fwu_sync_mdata() - Update given meta-data partition(s) with the copy provided
+ * @data: FWU Data structure
+ * @part: Bitmask of FWU metadata partitions to be written to
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_sync_mdata(struct fwu_mdata *mdata, int part);
+
 /**
  * fwu_populate_mdata_image_info() - Populate the image information
  * of the metadata
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 86518108c2..5dfea2a4d8 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -10,6 +10,7 @@
 #include <event.h>
 #include <fwu.h>
 #include <fwu_mdata.h>
+#include <log.h>
 #include <malloc.h>
 
 #include <linux/errno.h>
@@ -17,7 +18,7 @@
 
 #include <u-boot/crc.h>
 
-static struct fwu_mdata g_mdata; /* = {0} makes uninit crc32 always invalid */
+struct fwu_data g_fwu_data;
 static struct udevice *g_dev;
 static u8 in_trial;
 static u8 boottime_check;
@@ -27,12 +28,6 @@ enum {
 	IMAGE_ACCEPT_CLEAR,
 };
 
-enum {
-	PRIMARY_PART = 1,
-	SECONDARY_PART,
-	BOTH_PARTS,
-};
-
 static int trial_counter_update(u16 *trial_state_ctr)
 {
 	bool delete;
@@ -106,23 +101,9 @@ out:
 	return ret;
 }
 
-static int in_trial_state(struct fwu_mdata *mdata)
+static u32 in_trial_state(void)
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
-
-	return 0;
+	return g_fwu_data.trial_state;
 }
 
 static int fwu_get_image_type_id(u8 image_index, efi_guid_t *image_type_id)
@@ -141,17 +122,70 @@ static int fwu_get_image_type_id(u8 image_index, efi_guid_t *image_type_id)
 	return -ENOENT;
 }
 
+static int mdata_crc_check(struct fwu_mdata *mdata)
+{
+	int ret;
+	u32 calc_crc32;
+	uint32_t mdata_size;
+	void *buf = &mdata->version;
+
+	ret = fwu_get_mdata_size(&mdata_size);
+	if (ret)
+		return ret;
+
+	calc_crc32 = crc32(0, buf, mdata_size - sizeof(u32));
+	return calc_crc32 == mdata->crc32 ? 0 : -EINVAL;
+}
+
+static void fwu_data_crc_update(uint32_t crc32)
+{
+	g_fwu_data.crc32 = crc32;
+}
+
+/**
+ * fwu_get_data() - Return the version agnostic FWU structure
+ *
+ * Return the pointer to the version agnostic FWU structure.
+ *
+ * Return: Pointer to the FWU data structure
+ */
+struct fwu_data *fwu_get_data(void)
+{
+	return &g_fwu_data;
+}
+
+static void fwu_populate_mdata_bank_index(struct fwu_data *fwu_data)
+{
+	struct fwu_mdata *mdata = fwu_data->fwu_mdata;
+
+	mdata->active_index = fwu_data->active_index;
+	mdata->previous_active_index = fwu_data->previous_active_index;
+}
+
+/**
+ * fwu_get_dev() - Return the FWU metadata device
+ *
+ * Return the pointer to the FWU metadata device.
+ *
+ * Return: Pointer to the FWU metadata dev
+ */
+struct udevice *fwu_get_dev(void)
+{
+	return g_dev;
+}
+
 /**
  * fwu_sync_mdata() - Update given meta-data partition(s) with the copy provided
- * @mdata: FWU metadata structure
+ * @data: FWU Data structure
  * @part: Bitmask of FWU metadata partitions to be written to
  *
  * Return: 0 if OK, -ve on error
  */
-static int fwu_sync_mdata(struct fwu_mdata *mdata, int part)
+int fwu_sync_mdata(struct fwu_mdata *mdata, int part)
 {
-	void *buf = &mdata->version;
 	int err;
+	uint mdata_size;
+	void *buf = &mdata->version;
 
 	if (part == BOTH_PARTS) {
 		err = fwu_sync_mdata(mdata, SECONDARY_PART);
@@ -160,32 +194,53 @@ static int fwu_sync_mdata(struct fwu_mdata *mdata, int part)
 		part = PRIMARY_PART;
 	}
 
+	err = fwu_get_mdata_size(&mdata_size);
+	if (err)
+		return err;
+
 	/*
 	 * Calculate the crc32 for the updated FWU metadata
 	 * and put the updated value in the FWU metadata crc32
 	 * field
 	 */
-	mdata->crc32 = crc32(0, buf, sizeof(*mdata) - sizeof(u32));
+	mdata->crc32 = crc32(0, buf, mdata_size - sizeof(u32));
+	fwu_data_crc_update(mdata->crc32);
 
-	err = fwu_write_mdata(g_dev, mdata, part == PRIMARY_PART);
+	err = fwu_write_mdata(g_dev, mdata, part == PRIMARY_PART, mdata_size);
 	if (err) {
 		log_err("Unable to write %s mdata\n",
 			part == PRIMARY_PART ?  "primary" : "secondary");
 		return err;
 	}
 
-	/* update the cached copy of meta-data */
-	memcpy(&g_mdata, mdata, sizeof(struct fwu_mdata));
-
 	return 0;
 }
 
-static inline int mdata_crc_check(struct fwu_mdata *mdata)
+/**
+ * fwu_mdata_copies_allocate() - Allocate memory for metadata
+ * @mdata_size: Size of the metadata structure
+ *
+ * Allocate memory for storing both the copies of the FWU metadata. The
+ * copies are then used as a cache for storing FWU metadata contents.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_mdata_copies_allocate(u32 mdata_size)
 {
-	void *buf = &mdata->version;
-	u32 calc_crc32 = crc32(0, buf, sizeof(*mdata) - sizeof(u32));
+	if (g_fwu_data.fwu_mdata)
+		return 0;
 
-	return calc_crc32 == mdata->crc32 ? 0 : -EINVAL;
+	/*
+	 * Allocate the total memory that would be needed for both
+	 * the copies.
+	 */
+	g_fwu_data.fwu_mdata = calloc(2, mdata_size);
+	if (!g_fwu_data.fwu_mdata) {
+		log_err("Unable to allocate space for FWU metadata\n");
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
 /**
@@ -201,21 +256,33 @@ static inline int mdata_crc_check(struct fwu_mdata *mdata)
 int fwu_get_mdata(struct fwu_mdata *mdata)
 {
 	int err;
+	uint32_t mdata_size;
 	bool parts_ok[2] = { false };
-	struct fwu_mdata s, *parts_mdata[2];
+	struct fwu_mdata *parts_mdata[2];
 
-	parts_mdata[0] = &g_mdata;
-	parts_mdata[1] = &s;
+	err = fwu_get_mdata_size(&mdata_size);
+	if (err)
+		return err;
+
+	parts_mdata[0] = g_fwu_data.fwu_mdata;
+	if (!parts_mdata[0]) {
+		log_err("Memory not allocated for the FWU Metadata copies\n");
+		return -ENOMEM;
+	}
+
+	parts_mdata[1] = (struct fwu_mdata *)((char *)parts_mdata[0] +
+					      mdata_size);
 
 	/* if mdata already read and ready */
 	err = mdata_crc_check(parts_mdata[0]);
 	if (!err)
 		goto ret_mdata;
-	/* else read, verify and, if needed, fix mdata */
 
+
+	/* else read, verify and, if needed, fix mdata */
 	for (int i = 0; i < 2; i++) {
 		parts_ok[i] = false;
-		err = fwu_read_mdata(g_dev, parts_mdata[i], !i);
+		err = fwu_read_mdata(g_dev, parts_mdata[i], !i, mdata_size);
 		if (!err) {
 			err = mdata_crc_check(parts_mdata[i]);
 			if (!err)
@@ -230,7 +297,7 @@ int fwu_get_mdata(struct fwu_mdata *mdata)
 		 * Before returning, check that both the
 		 * FWU metadata copies are the same.
 		 */
-		err = memcmp(parts_mdata[0], parts_mdata[1], sizeof(struct fwu_mdata));
+		err = memcmp(parts_mdata[0], parts_mdata[1], mdata_size);
 		if (!err)
 			goto ret_mdata;
 
@@ -247,7 +314,7 @@ int fwu_get_mdata(struct fwu_mdata *mdata)
 		if (parts_ok[i])
 			continue;
 
-		memcpy(parts_mdata[i], parts_mdata[1 - i], sizeof(struct fwu_mdata));
+		memcpy(parts_mdata[i], parts_mdata[1 - i], mdata_size);
 		err = fwu_sync_mdata(parts_mdata[i], i ? SECONDARY_PART : PRIMARY_PART);
 		if (err) {
 			log_debug("mdata : %s write failed\n", i ? "secondary" : "primary");
@@ -257,7 +324,7 @@ int fwu_get_mdata(struct fwu_mdata *mdata)
 
 ret_mdata:
 	if (!err && mdata)
-		memcpy(mdata, parts_mdata[0], sizeof(struct fwu_mdata));
+		memcpy(mdata, parts_mdata[0], mdata_size);
 
 	return err;
 }
@@ -275,13 +342,13 @@ ret_mdata:
 int fwu_get_active_index(uint *active_idx)
 {
 	int ret = 0;
-	struct fwu_mdata *mdata = &g_mdata;
+	struct fwu_data *data = &g_fwu_data;
 
 	/*
 	 * Found the FWU metadata partition, now read the active_index
 	 * value
 	 */
-	*active_idx = mdata->active_index;
+	*active_idx = data->active_index;
 	if (*active_idx >= CONFIG_FWU_NUM_BANKS) {
 		log_debug("Active index value read is incorrect\n");
 		ret = -EINVAL;
@@ -302,7 +369,7 @@ int fwu_get_active_index(uint *active_idx)
 int fwu_set_active_index(uint active_idx)
 {
 	int ret;
-	struct fwu_mdata *mdata = &g_mdata;
+	struct fwu_data *data =  &g_fwu_data;
 
 	if (active_idx >= CONFIG_FWU_NUM_BANKS) {
 		log_debug("Invalid active index value\n");
@@ -313,14 +380,16 @@ int fwu_set_active_index(uint active_idx)
 	 * Update the active index and previous_active_index fields
 	 * in the FWU metadata
 	 */
-	mdata->previous_active_index = mdata->active_index;
-	mdata->active_index = active_idx;
+	data->previous_active_index = data->active_index;
+	data->active_index = active_idx;
+
+	fwu_populate_mdata_bank_index(data);
 
 	/*
 	 * Now write this updated FWU metadata to both the
 	 * FWU metadata partitions
 	 */
-	ret = fwu_sync_mdata(mdata, BOTH_PARTS);
+	ret = fwu_sync_mdata(data->fwu_mdata, BOTH_PARTS);
 	if (ret) {
 		log_debug("Failed to update FWU metadata partitions\n");
 		ret = -EIO;
@@ -346,7 +415,7 @@ int fwu_get_dfu_alt_num(u8 image_index, u8 *alt_num)
 	int ret, i;
 	uint update_bank;
 	efi_guid_t *image_guid, image_type_id;
-	struct fwu_mdata *mdata = &g_mdata;
+	struct fwu_data *data = &g_fwu_data;
 	struct fwu_image_entry *img_entry;
 	struct fwu_image_bank_info *img_bank_info;
 
@@ -365,15 +434,15 @@ int fwu_get_dfu_alt_num(u8 image_index, u8 *alt_num)
 
 	ret = -EINVAL;
 	/*
-	 * The FWU metadata has been read. Now get the image_uuid for the
+	 * The FWU metadata has been read. Now get the image_guid for the
 	 * image with the update_bank.
 	 */
 	for (i = 0; i < CONFIG_FWU_NUM_IMAGES_PER_BANK; i++) {
 		if (!guidcmp(&image_type_id,
-			     &mdata->img_entry[i].image_type_uuid)) {
-			img_entry = &mdata->img_entry[i];
+			     &data->fwu_images[i].image_type_guid)) {
+			img_entry = &data->fwu_images[i];
 			img_bank_info = &img_entry->img_bank_info[update_bank];
-			image_guid = &img_bank_info->image_uuid;
+			image_guid = &img_bank_info->image_guid;
 			ret = fwu_plat_get_alt_num(g_dev, image_guid, alt_num);
 			if (ret)
 				log_debug("alt_num not found for partition with GUID %pUs\n",
@@ -407,21 +476,23 @@ int fwu_revert_boot_index(void)
 {
 	int ret;
 	u32 cur_active_index;
-	struct fwu_mdata *mdata = &g_mdata;
+	struct fwu_data *data =  &g_fwu_data;
 
 	/*
 	 * Swap the active index and previous_active_index fields
 	 * in the FWU metadata
 	 */
-	cur_active_index = mdata->active_index;
-	mdata->active_index = mdata->previous_active_index;
-	mdata->previous_active_index = cur_active_index;
+	cur_active_index = data->active_index;
+	data->active_index = data->previous_active_index;
+	data->previous_active_index = cur_active_index;
+
+	fwu_populate_mdata_bank_index(data);
 
 	/*
 	 * Now write this updated FWU metadata to both the
 	 * FWU metadata partitions
 	 */
-	ret = fwu_sync_mdata(mdata, BOTH_PARTS);
+	ret = fwu_sync_mdata(data->fwu_mdata, BOTH_PARTS);
 	if (ret) {
 		log_debug("Failed to update FWU metadata partitions\n");
 		ret = -EIO;
@@ -448,20 +519,21 @@ int fwu_revert_boot_index(void)
 static int fwu_clrset_image_accept(efi_guid_t *img_type_id, u32 bank, u8 action)
 {
 	int ret, i;
-	struct fwu_mdata *mdata = &g_mdata;
+	struct fwu_data *data = &g_fwu_data;
 	struct fwu_image_entry *img_entry;
 	struct fwu_image_bank_info *img_bank_info;
 
-	img_entry = &mdata->img_entry[0];
+	img_entry = &data->fwu_images[0];
 	for (i = 0; i < CONFIG_FWU_NUM_IMAGES_PER_BANK; i++) {
-		if (!guidcmp(&img_entry[i].image_type_uuid, img_type_id)) {
+		if (!guidcmp(&img_entry[i].image_type_guid, img_type_id)) {
 			img_bank_info = &img_entry[i].img_bank_info[bank];
 			if (action == IMAGE_ACCEPT_SET)
 				img_bank_info->accepted |= FWU_IMAGE_ACCEPTED;
 			else
 				img_bank_info->accepted = 0;
 
-			ret = fwu_sync_mdata(mdata, BOTH_PARTS);
+			fwu_populate_mdata_image_info(data);
+			ret = fwu_sync_mdata(data->fwu_mdata, BOTH_PARTS);
 			goto out;
 		}
 	}
@@ -627,9 +699,9 @@ static int fwu_boottime_checks(void)
 		return 0;
 	}
 
-	ret = fwu_get_mdata(NULL);
+	ret = fwu_init();
 	if (ret) {
-		log_debug("Unable to read meta-data\n");
+		log_debug("fwu_init() failed\n");
 		return ret;
 	}
 
@@ -665,7 +737,7 @@ static int fwu_boottime_checks(void)
 	if (efi_init_obj_list() != EFI_SUCCESS)
 		return 0;
 
-	in_trial = in_trial_state(&g_mdata);
+	in_trial = in_trial_state();
 	if (!in_trial || (ret = fwu_trial_count_update()) > 0)
 		ret = trial_counter_update(NULL);
 
-- 
2.34.1

