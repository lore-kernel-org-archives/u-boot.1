Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145EEC54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 10:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B44E881E4;
	Fri, 22 Mar 2024 11:58:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E6BC881C2; Fri, 22 Mar 2024 11:58:35 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DFDC2881CC
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:58:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F4421007;
 Fri, 22 Mar 2024 03:59:06 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27F1D3F64C;
 Fri, 22 Mar 2024 03:58:28 -0700 (PDT)
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
Subject: [PATCH v3 07/20] fwu: metadata: add functions for handling version
 specific metadata fields
Date: Fri, 22 Mar 2024 16:27:20 +0530
Message-Id: <20240322105733.203888-8-sughosh.ganu@linaro.org>
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

Support is being added in U-Boot for version 2 of the FWU
metadata. Support for this version is to co-exist with version 1
support. To achieve this, a common, version agnostic structure has
been added to keep information provided by the FWU metadata
structure.

Add API's to handle the version specific FWU metadata fields. The
version agnostic structure gets initialized at boot by reading the FWU
metadata. Updates to the FWU metadata result in the API's getting
called to populate the version specific fields of the strucure, before
the metadata gets written to the storage media.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2:
* New patch

 include/fwu.h            |  57 +++++++++
 lib/fwu_updates/fwu_v1.c | 167 +++++++++++++++++++++++++
 lib/fwu_updates/fwu_v2.c | 260 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 484 insertions(+)
 create mode 100644 lib/fwu_updates/fwu_v1.c
 create mode 100644 lib/fwu_updates/fwu_v2.c

diff --git a/include/fwu.h b/include/fwu.h
index e681e91027..082b5481d1 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -313,4 +313,61 @@ int fwu_gen_alt_info_from_mtd(char *buf, size_t len, struct mtd_info *mtd);
  */
 int fwu_mtd_get_alt_num(efi_guid_t *image_guid, u8 *alt_num, const char *mtd_dev);
 
+/**
+ * fwu_populate_mdata_image_info() - Populate the image information
+ * of the metadata
+ * @data: Version agnostic FWU metadata information
+ *
+ * Populate the image information in the FWU metadata by copying it
+ * from the version agnostic structure. This is done before the
+ * metadata gets written to the storage media.
+ *
+ * Return: None
+ */
+void fwu_populate_mdata_image_info(struct fwu_data *data);
+
+/**
+ * fwu_get_mdata_size() - Get the FWU metadata size
+ * @mdata_size: Size of the metadata structure
+ *
+ * Get the size of the FWU metadata from the structure. This is later used
+ * to allocate memory for the structure.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_get_mdata_size(uint32_t *mdata_size);
+
+/**
+ * fwu_state_machine_updates() - Update FWU state of the platform
+ * @trial_state: Is platform transitioning into Trial State
+ * @update_index: Bank number to which images have been updated
+ *
+ * On successful completion of updates, transition the platform to
+ * either Trial State or Regular State.
+ *
+ * To transition the platform to Trial State, start the
+ * TrialStateCtr counter, followed by setting the value of bank_state
+ * field of the metadata to Valid state(applicable only in version 2
+ * of metadata).
+ *
+ * In case, the platform is to transition directly to Regular State,
+ * update the bank_state field of the metadata to Accepted
+ * state(applicable only in version 2 of metadata).
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_state_machine_updates(bool trial_state, uint32_t update_index);
+
+/**
+ * fwu_init() - FWU specific initialisations
+ *
+ * Carry out some FWU specific initialisations including allocation
+ * of memory for the metadata copies, and reading the FWU metadata
+ * copies into the allocated memory. The metadata fields are then
+ * copied into a version agnostic structure.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_init(void);
+
 #endif /* _FWU_H_ */
diff --git a/lib/fwu_updates/fwu_v1.c b/lib/fwu_updates/fwu_v1.c
new file mode 100644
index 0000000000..efb8d51500
--- /dev/null
+++ b/lib/fwu_updates/fwu_v1.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024, Linaro Limited
+ */
+
+#include <fwu.h>
+#include <fwu_mdata.h>
+
+#include <linux/types.h>
+
+#define FWU_MDATA_VERSION	0x1U
+
+static uint32_t fwu_check_trial_state(struct fwu_mdata *mdata, uint32_t bank)
+{
+	u32 i;
+	struct fwu_image_entry *img_entry;
+	struct fwu_image_bank_info *img_bank_info;
+
+	img_entry = &mdata->img_entry[0];
+	for (i = 0; i < CONFIG_FWU_NUM_IMAGES_PER_BANK; i++) {
+		img_bank_info = &img_entry[i].img_bank_info[bank];
+		if (!img_bank_info->accepted) {
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static void fwu_data_init(void)
+{
+	size_t image_info_size;
+	void *dst_img_info, *src_img_info;
+	struct fwu_data *data = fwu_get_data();
+	struct fwu_mdata *mdata = data->fwu_mdata;
+
+	data->crc32 = mdata->crc32;
+	data->version = mdata->version;
+	data->active_index = mdata->active_index;
+	data->previous_active_index = mdata->previous_active_index;
+
+	data->metadata_size = sizeof(struct fwu_mdata);
+	data->num_banks = CONFIG_FWU_NUM_BANKS;
+	data->num_images = CONFIG_FWU_NUM_IMAGES_PER_BANK;
+	fwu_plat_get_bootidx(&data->boot_index);
+	data->trial_state = fwu_check_trial_state(mdata, data->boot_index);
+
+	src_img_info = &mdata->img_entry[0];
+	dst_img_info = &data->fwu_images[0];
+	image_info_size = sizeof(data->fwu_images);
+
+	memcpy(dst_img_info, src_img_info, image_info_size);
+}
+
+static int fwu_trial_state_update(bool trial_state)
+{
+	int ret;
+	struct fwu_data *data = fwu_get_data();
+
+	if (trial_state) {
+		ret = fwu_trial_state_ctr_start();
+		if (ret)
+			return ret;
+	}
+
+	data->trial_state = trial_state;
+
+	return 0;
+}
+
+/**
+ * fwu_populate_mdata_image_info() - Populate the image information
+ * of the metadata
+ * @data: Version agnostic FWU metadata information
+ *
+ * Populate the image information in the FWU metadata by copying it
+ * from the version agnostic structure. This is done before the
+ * metadata gets written to the storage media.
+ *
+ * Return: None
+ */
+void fwu_populate_mdata_image_info(struct fwu_data *data)
+{
+	size_t image_info_size;
+	void *dst_img_info, *src_img_info;
+	struct fwu_mdata *mdata = data->fwu_mdata;
+
+	image_info_size = sizeof(data->fwu_images);
+	dst_img_info = &mdata->img_entry[0];
+	src_img_info = &data->fwu_images[0];
+
+	memcpy(dst_img_info, src_img_info, image_info_size);
+}
+
+/**
+ * fwu_state_machine_updates() - Update FWU state of the platform
+ * @trial_state: Is platform transitioning into Trial State
+ * @update_index: Bank number to which images have been updated
+ *
+ * On successful completion of updates, transition the platform to
+ * either Trial State or Regular State.
+ *
+ * To transition the platform to Trial State, start the
+ * TrialStateCtr counter, followed by setting the value of bank_state
+ * field of the metadata to Valid state(applicable only in version 2
+ * of metadata).
+ *
+ * In case, the platform is to transition directly to Regular State,
+ * update the bank_state field of the metadata to Accepted
+ * state(applicable only in version 2 of metadata).
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_state_machine_updates(bool trial_state,
+			      __maybe_unused uint32_t update_index)
+{
+	return fwu_trial_state_update(trial_state);
+}
+
+/**
+ * fwu_get_mdata_size() - Get the FWU metadata size
+ * @mdata_size: Size of the metadata structure
+ *
+ * Get the size of the FWU metadata.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_get_mdata_size(uint32_t *mdata_size)
+{
+	*mdata_size = sizeof(struct fwu_mdata);
+
+	return 0;
+}
+
+/**
+ * fwu_init() - FWU specific initialisations
+ *
+ * Carry out some FWU specific initialisations including allocation
+ * of memory for the metadata copies, and reading the FWU metadata
+ * copies into the allocated memory. The metadata fields are then
+ * copied into a version agnostic structure.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_init(void)
+{
+	int ret;
+	uint32_t mdata_size;
+
+	fwu_get_mdata_size(&mdata_size);
+
+	ret = fwu_mdata_copies_allocate(mdata_size);
+	if (ret)
+		return ret;
+
+	/*
+	 * Now read the entire structure, both copies, and
+	 * validate that the copies.
+	 */
+	ret = fwu_get_mdata(NULL);
+	if (ret)
+		return ret;
+
+	fwu_data_init();
+
+	return 0;
+}
diff --git a/lib/fwu_updates/fwu_v2.c b/lib/fwu_updates/fwu_v2.c
new file mode 100644
index 0000000000..108bc9bb4a
--- /dev/null
+++ b/lib/fwu_updates/fwu_v2.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024, Linaro Limited
+ */
+
+#include <fwu.h>
+#include <fwu_mdata.h>
+#include <log.h>
+
+#include <linux/types.h>
+
+#define FWU_MDATA_VERSION	0x2U
+
+static inline struct fwu_fw_store_desc *fwu_get_fw_desc(struct fwu_mdata *mdata)
+{
+	return (struct fwu_fw_store_desc *)((u8 *)mdata + sizeof(*mdata));
+}
+
+static uint32_t fwu_check_trial_state(struct fwu_mdata *mdata, uint32_t bank)
+{
+	return mdata->bank_state[bank] == FWU_BANK_VALID ? 1 : 0;
+}
+
+static void fwu_data_init(void)
+{
+	int i;
+	size_t image_info_size;
+	void *dst_img_info, *src_img_info;
+	struct fwu_data *data = fwu_get_data();
+	struct fwu_mdata *mdata = data->fwu_mdata;
+
+	data->crc32 = mdata->crc32;
+	data->version = mdata->version;
+	data->active_index = mdata->active_index;
+	data->previous_active_index = mdata->previous_active_index;
+	data->metadata_size = mdata->metadata_size;
+	fwu_plat_get_bootidx(&data->boot_index);
+	data->trial_state = fwu_check_trial_state(mdata, data->boot_index);
+
+	data->num_banks = fwu_get_fw_desc(mdata)->num_banks;
+	data->num_images = fwu_get_fw_desc(mdata)->num_images;
+
+	for (i = 0; i < 4; i++) {
+		data->bank_state[i] = mdata->bank_state[i];
+	}
+
+	image_info_size = sizeof(data->fwu_images);
+	src_img_info = &fwu_get_fw_desc(mdata)->img_entry[0];
+	dst_img_info = &data->fwu_images[0];
+
+	memcpy(dst_img_info, src_img_info, image_info_size);
+}
+
+static int fwu_mdata_sanity_checks(void)
+{
+	uint8_t num_banks;
+	uint16_t num_images;
+	struct fwu_data *data = fwu_get_data();
+	struct fwu_mdata *mdata = data->fwu_mdata;
+
+	if (mdata->version != FWU_MDATA_VERSION) {
+		log_err("FWU metadata version %u. Expected value of %u\n",
+			mdata->version, FWU_MDATA_VERSION);
+		return -EINVAL;
+	}
+
+	if (!mdata->desc_offset) {
+		log_err("No image information provided with the Metadata. ");
+		log_err("Image information expected in the metadata\n");
+		return -EINVAL;
+	}
+
+	if (mdata->desc_offset != 0x20) {
+		log_err("Descriptor Offset(0x%x) in the FWU Metadata not equal to 0x20\n",
+			mdata->desc_offset);
+		return -EINVAL;
+	}
+
+	num_banks = fwu_get_fw_desc(mdata)->num_banks;
+	num_images = fwu_get_fw_desc(mdata)->num_images;
+
+	if (num_banks != CONFIG_FWU_NUM_BANKS) {
+		log_err("Number of Banks(%u) in FWU Metadata different from the configured value(%d)",
+			num_banks, CONFIG_FWU_NUM_BANKS);
+		return -EINVAL;
+	}
+
+	if (num_images != CONFIG_FWU_NUM_IMAGES_PER_BANK) {
+		log_err("Number of Images(%u) in FWU Metadata different from the configured value(%d)",
+			num_images, CONFIG_FWU_NUM_IMAGES_PER_BANK);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int fwu_bank_state_update(bool trial_state, uint32_t bank)
+{
+	int ret;
+	struct fwu_data *data = fwu_get_data();
+	struct fwu_mdata *mdata = data->fwu_mdata;
+
+	mdata->bank_state[bank] = data->bank_state[bank] = trial_state ?
+		FWU_BANK_VALID : FWU_BANK_ACCEPTED;
+
+	ret = fwu_sync_mdata(mdata, BOTH_PARTS);
+	if (ret)
+		log_err("Unable to set bank_state for bank %u\n", bank);
+	else
+		data->trial_state = trial_state;
+
+	return ret;
+}
+
+static int fwu_trial_state_start(uint update_index)
+{
+	int ret;
+
+	ret = fwu_trial_state_ctr_start();
+	if (ret)
+		return ret;
+
+	ret = fwu_bank_state_update(1, update_index);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * fwu_populate_mdata_image_info() - Populate the image information
+ * of the metadata
+ * @data: Version agnostic FWU metadata information
+ *
+ * Populate the image information in the FWU metadata by copying it
+ * from the version agnostic structure. This is done before the
+ * metadata gets written to the storage media.
+ *
+ * Return: None
+ */
+void fwu_populate_mdata_image_info(struct fwu_data *data)
+{
+	size_t image_info_size;
+	struct fwu_mdata *mdata = data->fwu_mdata;
+	void *dst_img_info, *src_img_info;
+
+	image_info_size = sizeof(data->fwu_images);
+	dst_img_info = &fwu_get_fw_desc(mdata)->img_entry[0];
+	src_img_info = &data->fwu_images[0];
+
+	memcpy(dst_img_info, src_img_info, image_info_size);
+}
+
+/**
+ * fwu_state_machine_updates() - Update FWU state of the platform
+ * @trial_state: Is platform transitioning into Trial State
+ * @update_index: Bank number to which images have been updated
+ *
+ * On successful completion of updates, transition the platform to
+ * either Trial State or Regular State.
+ *
+ * To transition the platform to Trial State, start the
+ * TrialStateCtr counter, followed by setting the value of bank_state
+ * field of the metadata to Valid state(applicable only in version 2
+ * of metadata).
+ *
+ * In case, the platform is to transition directly to Regular State,
+ * update the bank_state field of the metadata to Accepted
+ * state(applicable only in version 2 of metadata).
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_state_machine_updates(bool trial_state, uint32_t update_index)
+{
+	return trial_state ? fwu_trial_state_start(update_index) :
+		fwu_bank_state_update(0, update_index);
+}
+
+/**
+ * fwu_get_mdata_size() - Get the FWU metadata size
+ * @mdata_size: Size of the metadata structure
+ *
+ * Get the size of the FWU metadata from the structure. This is later used
+ * to allocate memory for the structure.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_get_mdata_size(uint32_t *mdata_size)
+{
+	int ret = 0;
+	struct fwu_mdata mdata = { 0 };
+	struct fwu_data *data = fwu_get_data();
+	struct udevice *fwu_dev = fwu_get_dev();
+
+	if (data->metadata_size) {
+		*mdata_size = data->metadata_size;
+		return 0;
+	}
+
+	ret = fwu_read_mdata(fwu_dev, &mdata, 1,
+			     sizeof(struct fwu_mdata));
+	if (ret) {
+		log_err("FWU metadata read failed\n");
+		return ret;
+	}
+
+	*mdata_size = mdata.metadata_size;
+	if (!*mdata_size)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * fwu_init() - FWU specific initialisations
+ *
+ * Carry out some FWU specific initialisations including allocation
+ * of memory for the metadata copies, and reading the FWU metadata
+ * copies into the allocated memory. The metadata fields are then
+ * copied into a version agnostic structure.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_init(void)
+{
+	int ret;
+	struct fwu_mdata mdata = { 0 };
+	struct udevice *fwu_dev = fwu_get_dev();
+
+	/*
+	 * First we read only the top level structure
+	 * and get the size of the complete structure.
+	 */
+	ret = fwu_read_mdata(fwu_dev, &mdata, 1,
+			     sizeof(struct fwu_mdata));
+	if (ret) {
+		log_err("FWU metadata read failed\n");
+		return ret;
+	}
+
+	ret = fwu_mdata_copies_allocate(mdata.metadata_size);
+	if (ret)
+		return ret;
+
+	/*
+	 * Now read the entire structure, both copies, and
+	 * validate that the copies.
+	 */
+	ret = fwu_get_mdata(NULL);
+	if (ret)
+		return ret;
+
+	ret = fwu_mdata_sanity_checks();
+	if (ret)
+		return ret;
+
+	fwu_data_init();
+
+	return 0;
+}
-- 
2.34.1

