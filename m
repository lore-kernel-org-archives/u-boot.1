Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE086C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 11:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C0E68796E;
	Mon, 22 Jan 2024 12:55:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8A6A879E6; Mon, 22 Jan 2024 12:55:27 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D293C87950
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 12:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F97F1FB;
 Mon, 22 Jan 2024 03:56:10 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADED13F73F;
 Mon, 22 Jan 2024 03:55:21 -0800 (PST)
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
Subject: [PATCH 04/18] fwu: Add some API's for metadata version 2 access
Date: Mon, 22 Jan 2024 17:24:25 +0530
Message-Id: <20240122115439.653871-5-sughosh.ganu@linaro.org>
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

There are certain fields added in version 2 of the FWU metadata
structure. Also, information like number of banks and number of images
per bank are also part of the metadata structure. Add functions to
access fields of the version 2 of the metadata structure.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 include/fwu.h         |  53 ++++++++++++++++
 lib/fwu_updates/fwu.c | 142 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+)

diff --git a/include/fwu.h b/include/fwu.h
index 1815bd0064..d3e97a5360 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -104,6 +104,26 @@ int fwu_write_mdata(struct udevice *dev, struct fwu_mdata *mdata,
  */
 int fwu_get_mdata(struct fwu_mdata *mdata);
 
+/**
+ * fwu_mdata_copies_allocate() - Allocate memory for metadata
+ *
+ * Allocate memory for storing both the copies of the FWU metadata. The
+ * copies are then used as a cache for storing FWU metadata contents.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_mdata_copies_allocate(void);
+
+/**
+ * fwu_get_mdata_size() - Get the FWU metadata size
+ *
+ * Get the size of the FWU metadata from the structure. This is later used
+ * to allocate memory for the structure.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_get_mdata_size(uint32_t *mdata_size);
+
 /**
  * fwu_get_active_index() - Get active_index from the FWU metadata
  * @active_idxp: active_index value to be read
@@ -153,6 +173,18 @@ int fwu_get_dfu_alt_num(u8 image_index, u8 *alt_num);
  */
 int fwu_revert_boot_index(void);
 
+/**
+ * fwu_bank_state_update() - Check and update the bank_state of the metadata
+ * @update_index: Bank for which the bank_state needs to be updated
+ *
+ * Check that all the images for the given bank have been accepted, and if
+ * they are, set the status of the bank to Accepted in the bank_state field
+ * of the metadata.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_bank_state_update(uint update_index);
+
 /**
  * fwu_accept_image() - Set the Acceptance bit for the image
  * @img_type_id: GUID of the image type for which the accepted bit is to be
@@ -286,4 +318,25 @@ int fwu_gen_alt_info_from_mtd(char *buf, size_t len, struct mtd_info *mtd);
  */
 int fwu_mtd_get_alt_num(efi_guid_t *image_guid, u8 *alt_num, const char *mtd_dev);
 
+/**
+ * fwu_get_banks_images() - Get the number of banks and images from the metadata
+ * @nbanks: Number of banks
+ * @nimages: Number of images per bank
+ *
+ * Get the values of number of banks and number of images per bank from the
+ * metadata.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+__maybe_unused int fwu_get_banks_images(u8 *nbanks, u16 *nimages);
+
+/**
+ * fwu_get_dev() - Return the FWU metadata device
+ *
+ * Return the pointer to the FWU metadata device.
+ *
+ * Return: Pointer to the FWU metadata dev
+ */
+__maybe_unused struct udevice *fwu_get_dev(void);
+
 #endif /* _FWU_H_ */
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 86518108c2..5bfa24067b 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -188,6 +188,114 @@ static inline int mdata_crc_check(struct fwu_mdata *mdata)
 	return calc_crc32 == mdata->crc32 ? 0 : -EINVAL;
 }
 
+/**
+ * fwu_mdata_copies_allocate() - Allocate memory for metadata
+ *
+ * Allocate memory for storing both the copies of the FWU metadata. The
+ * copies are then used as a cache for storing FWU metadata contents.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_mdata_copies_allocate(void)
+{
+	int err;
+	uint32_t mdata_size;
+
+	if (g_mdata)
+		return 0;
+
+	err = fwu_get_mdata_size(&mdata_size);
+	if (err)
+		return err;
+
+	/*
+	 * Now allocate the total memory that would be needed for both
+	 * the copies.
+	 */
+	g_mdata = calloc(2, mdata_size);
+	if (!g_mdata) {
+		log_err("Unable to allocate space for FWU metadata\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/**
+ * fwu_get_mdata_size() - Get the FWU metadata size
+ *
+ * Get the size of the FWU metadata from the structure. This is later used
+ * to allocate memory for the structure.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_get_mdata_size(uint32_t *mdata_size)
+{
+	int err = 0;
+	struct fwu_mdata mdata = { 0 };
+
+	if (g_mdata && !mdata_crc_check(g_mdata)) {
+		*mdata_size = g_mdata->metadata_size;
+		return 0;
+	}
+
+	err = fwu_read_mdata(g_dev, &mdata, 1, sizeof(struct fwu_mdata));
+	if (err) {
+		log_err("FWU metadata read failed\n");
+		return err;
+	}
+
+	if (mdata.version != 0x2) {
+		log_err("FWU metadata version %u. Expected value of 2\n",
+			mdata.version);
+		return -EINVAL;
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
+ * fwu_get_dev() - Return the FWU metadata device
+ *
+ * Return the pointer to the FWU metadata device.
+ *
+ * Return: Pointer to the FWU metadata dev
+ */
+__maybe_unused struct udevice *fwu_get_dev(void)
+{
+	return g_dev;
+}
+
+/**
+ * fwu_get_banks_images() - Get the number of banks and images from the metadata
+ * @nbanks: Number of banks
+ * @nimages: Number of images per bank
+ *
+ * Get the values of number of banks and number of images per bank from the
+ * metadata.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+__maybe_unused int fwu_get_banks_images(u8 *nbanks, u16 *nimages)
+{
+	int ret;
+
+	if (mdata_crc_check(g_mdata)) {
+		ret = fwu_get_mdata(NULL);
+		if (ret)
+			return ret;
+	}
+
+	*nbanks = g_mdata->fw_desc[0].num_banks;
+	*nimages = g_mdata->fw_desc[0].num_images;
+
+	return 0;
+}
+
 /**
  * fwu_get_mdata() - Read, verify and return the FWU metadata
  * @mdata: Output FWU metadata read or NULL
@@ -473,6 +581,40 @@ out:
 	return ret;
 }
 
+/**
+ * fwu_bank_state_update() - Check and update the bank_state of the metadata
+ * @update_index: Bank for which the bank_state needs to be updated
+ *
+ * Check that all the images for the given bank have been accepted, and if
+ * they are, set the status of the bank to Accepted in the bank_state field
+ * of the metadata.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_bank_state_update(uint update_index)
+{
+	int ret = 0, i;
+	u16 num_images;
+	struct fwu_mdata *mdata = g_mdata;
+	struct fwu_image_entry *img_entry;
+	struct fwu_image_bank_info *img_bank_info;
+
+	img_entry = &mdata->fw_desc[0].img_entry[0];
+	num_images = mdata->fw_desc[0].num_images;
+	for (i = 0; i < num_images; i++) {
+		img_bank_info = &img_entry[i].img_bank_info[update_index];
+		if (!(img_bank_info->accepted & FWU_IMAGE_ACCEPTED))
+			return 0;
+	}
+
+	mdata->bank_state[update_index] = FWU_BANK_ACCEPTED;
+	ret = fwu_sync_mdata(mdata, BOTH_PARTS);
+	if (ret)
+		log_err("Unable to set bank_state for bank %u\n", update_index);
+
+	return ret;
+}
+
 /**
  * fwu_accept_image() - Set the Acceptance bit for the image
  * @img_type_id: GUID of the image type for which the accepted bit is to be
-- 
2.34.1

