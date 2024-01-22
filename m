Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40801C47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 11:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A64C879FC;
	Mon, 22 Jan 2024 12:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1F85879FC; Mon, 22 Jan 2024 12:55:20 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8B89587950
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 12:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16C141FB;
 Mon, 22 Jan 2024 03:56:04 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65D923F73F;
 Mon, 22 Jan 2024 03:55:15 -0800 (PST)
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
Subject: [PATCH 02/18] fwu: metadata: Migrate to version 2 of the structure
Date: Mon, 22 Jan 2024 17:24:23 +0530
Message-Id: <20240122115439.653871-3-sughosh.ganu@linaro.org>
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

The latest version of the FWU specification [1] has changes to the
metadata structure. This is version 2 of the structure.

Primary changes include
 - bank_state field in the top level structure
 - Total metadata size in the top level structure
 - Image description structures now optional
 - Number of banks and images per bank values part of the structure

Migrate to the version 2 of the metadata structure.

[1] - https://developer.arm.com/documentation/den0118/latest/

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 include/fwu_mdata.h | 56 +++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/include/fwu_mdata.h b/include/fwu_mdata.h
index 56189e2f40..050ee969e3 100644
--- a/include/fwu_mdata.h
+++ b/include/fwu_mdata.h
@@ -11,7 +11,7 @@
 
 /**
  * struct fwu_image_bank_info - firmware image information
- * @image_uuid: Guid value of the image in this bank
+ * @image_guid: Guid value of the image in this bank
  * @accepted: Acceptance status of the image
  * @reserved: Reserved
  *
@@ -20,15 +20,15 @@
  * acceptance status
  */
 struct fwu_image_bank_info {
-	efi_guid_t  image_uuid;
+	efi_guid_t  image_guid;
 	uint32_t accepted;
 	uint32_t reserved;
 } __packed;
 
 /**
  * struct fwu_image_entry - information for a particular type of image
- * @image_type_uuid: Guid value for identifying the image type
- * @location_uuid: Guid of the storage volume where the image is located
+ * @image_type_guid: Guid value for identifying the image type
+ * @location_guid: Guid of the storage volume where the image is located
  * @img_bank_info: Array containing properties of images
  *
  * This structure contains information on various types of updatable
@@ -36,9 +36,30 @@ struct fwu_image_bank_info {
  * information per bank.
  */
 struct fwu_image_entry {
-	efi_guid_t image_type_uuid;
-	efi_guid_t location_uuid;
-	struct fwu_image_bank_info img_bank_info[CONFIG_FWU_NUM_BANKS];
+	efi_guid_t image_type_guid;
+	efi_guid_t location_guid;
+	struct fwu_image_bank_info img_bank_info[];
+} __packed;
+
+/**
+ * struct fwu_fw_desc_store - FWU updatable image information
+ * @num_banks: Number of firmware banks
+ * num_images: Number of images per bank
+ * @img_entry_size: The size of the img_entry array
+ * @bank_info_entry_size: The size of the img_bank_info array
+ * @img_entry: Array of image entries each giving information on a image
+ *
+ * This image descriptor structure contains information on the number of
+ * updatable banks and images per bank. It also gives the total sizes of
+ * the fwu_image_entry and fwu_image_bank_info arrays.
+ */
+struct fwu_fw_store_desc {
+	uint8_t  num_banks;
+	uint8_t  reserved;
+	uint16_t num_images;
+	uint16_t img_entry_size;
+	uint16_t bank_info_entry_size;
+	struct fwu_image_entry img_entry[];
 } __packed;
 
 /**
@@ -48,21 +69,28 @@ struct fwu_image_entry {
  * @active_index: Index of the bank currently used for booting images
  * @previous_active_inde: Index of the bank used before the current bank
  *                        being used for booting
- * @img_entry: Array of information on various firmware images that can
- *             be updated
+ * @metadata_size: Size of the entire metadata structure, including the
+ *                 image descriptors
+ * @desc_offset: The offset from the start of this structure where the
+ *               image descriptor structure starts. 0 if absent
+ * @bank_state: State of each bank, valid, invalid or accepted
+ * @fw_desc: The structure describing the FWU updatable images
  *
- * This structure is used to store all the needed information for performing
+ * This is the top level structure used to store all information for performing
  * multi bank updates on the platform. This contains info on the bank being
- * used to boot along with the information needed for identification of
- * individual images
+ * used to boot along with the information on state of individual banks.
  */
 struct fwu_mdata {
 	uint32_t crc32;
 	uint32_t version;
 	uint32_t active_index;
 	uint32_t previous_active_index;
-
-	struct fwu_image_entry img_entry[CONFIG_FWU_NUM_IMAGES_PER_BANK];
+	uint32_t metadata_size;
+	uint16_t desc_offset;
+	uint16_t reserved1;
+	uint8_t  bank_state[4];
+	uint32_t reserved2;
+	struct fwu_fw_store_desc fw_desc[];
 } __packed;
 
 #endif /* _FWU_MDATA_H_ */
-- 
2.34.1

