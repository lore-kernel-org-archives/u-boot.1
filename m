Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B180C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 07:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B656887ECC;
	Mon, 12 Feb 2024 08:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDB1987ED1; Mon, 12 Feb 2024 08:47:51 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4D96787C80
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:47:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58CCEDA7;
 Sun, 11 Feb 2024 23:48:30 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C9643F7BD;
 Sun, 11 Feb 2024 23:47:45 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 04/21] fwu: add helper functions for getting image
 description offsets
Date: Mon, 12 Feb 2024 13:16:55 +0530
Message-Id: <20240212074712.3657076-5-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
References: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
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

With migration of the FWU metadata structure to version 2, the size of
the structure is not determined at build time, but at run time.

This means, that the offsets for the structures describing firmware
images which are part of the FWU metadata(struct fwu_fw_store_desc,
struct fwu_image_entry and struct fwu_image_bank_info) need to be
computed at runtime. Add helper functions to get addresses of these
structures.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Changes since V1:
* New patch needed based on comments from Ilias on the earlier
  version.


 include/fwu.h         | 45 +++++++++++++++++++++++++++++++++
 lib/fwu_updates/fwu.c | 58 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/include/fwu.h b/include/fwu.h
index 1815bd0064..7de462548c 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -8,6 +8,7 @@
 
 #include <blk.h>
 #include <efi.h>
+#include <fwu_mdata.h>
 #include <mtd.h>
 #include <uuid.h>
 
@@ -81,6 +82,50 @@ struct fwu_mdata_ops {
 	EFI_GUID(0x0c996046, 0xbcc0, 0x4d04, 0x85, 0xec, \
 		 0xe1, 0xfc, 0xed, 0xf1, 0xc6, 0xf8)
 
+
+/**
+ * fwu_get_fw_desc() - Return pointer to firmware descriptor store struct
+ * @mdata: Pointer to the FWU metadata
+ *
+ * Returns pointer to the firmware store descriptor of the FWU metadata
+ * containing information on updatable images.
+ *
+ * Return: Pointer to the struct fwu_fw_store_desc
+ */
+static inline struct fwu_fw_store_desc *fwu_get_fw_desc(struct fwu_mdata *mdata)
+{
+	return (struct fwu_fw_store_desc *)((u8 *)mdata + sizeof(*mdata));
+}
+
+/**
+ * fwu_img_entry_offset() - Get pointer to struct fwu_image_entry
+ * @mdata: Pointer to the FWU metadata
+ * @idx: Image index for which pointer is to be returned
+ *
+ * Fetches pointer to am array element of type struct fwu_image_entry.
+ * This returns back a pointer to a structure which is providing
+ * information on a updatable image.
+ *
+ * Return: Pointer to an array element of type struct fwu_image_entry
+ *
+ */
+struct fwu_image_entry *fwu_img_entry_offset(struct fwu_mdata *mdata, u16 idx);
+
+/**
+ * fwu_img_bank_info_offset() - Get pointer to struct fwu_image_bank_info
+ * @mdata: Pointer to the FWU metadata
+ * @idx: Image index for which information is needed
+ * @bank: Bank for which pointer is to be returned
+ *
+ * Fetches pointer to an array element of type struct fwu_image_bank_info
+ * for a given image. This returns back a pointer to a structure which
+ * is providing information for a given bank for a particular image.
+ *
+ * Return: Pointer to an array element of type fwu_image_bank_info
+ *
+ */
+struct fwu_image_bank_info *fwu_img_bank_info_offset(struct fwu_mdata *mdata,
+						     u16 idx, u8 bank);
 /**
  * fwu_read_mdata() - Wrapper around fwu_mdata_ops.read_mdata()
  */
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 86518108c2..5f1182a764 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -141,6 +141,64 @@ static int fwu_get_image_type_id(u8 image_index, efi_guid_t *image_type_id)
 	return -ENOENT;
 }
 
+/**
+ * fwu_img_entry_offset() - Get pointer to struct fwu_image_entry
+ * @mdata: Pointer to the FWU metadata
+ * @idx: Image index for which pointer is to be returned
+ *
+ * Fetches pointer to am array element of type struct fwu_image_entry.
+ * This returns back a pointer to a structure which is providing
+ * information on a updatable image.
+ *
+ * Return: Pointer to an array element of type struct fwu_image_entry
+ *
+ */
+struct fwu_image_entry *fwu_img_entry_offset(struct fwu_mdata *mdata, u16 idx)
+{
+	u8 num_banks;
+	size_t offset;
+
+	num_banks = fwu_get_fw_desc(mdata)->num_banks;
+
+	offset = sizeof(struct fwu_mdata) +
+		sizeof(struct fwu_fw_store_desc) +
+		(sizeof(struct fwu_image_entry) +
+		 sizeof(struct fwu_image_bank_info) * num_banks) * idx;
+
+	return (struct fwu_image_entry *)((char *)mdata + offset);
+}
+
+/**
+ * fwu_img_bank_info_offset() - Get pointer to struct fwu_image_bank_info
+ * @mdata: Pointer to the FWU metadata
+ * @idx: Image index for which information is needed
+ * @bank: Bank for which pointer is to be returned
+ *
+ * Fetches pointer to an array element of type struct fwu_image_bank_info
+ * for a given image. This returns back a pointer to a structure which
+ * is providing information for a given bank for a particular image.
+ *
+ * Return: Pointer to an array element of type fwu_image_bank_info
+ *
+ */
+struct fwu_image_bank_info *fwu_img_bank_info_offset(struct fwu_mdata *mdata,
+						     u16 idx, u8 bank)
+{
+	u8 num_banks;
+	size_t offset;
+
+	num_banks = fwu_get_fw_desc(mdata)->num_banks;
+
+	offset = sizeof(struct fwu_mdata) +
+		sizeof(struct fwu_fw_store_desc) +
+		(sizeof(struct fwu_image_entry) +
+		 sizeof(struct fwu_image_bank_info) * num_banks) * idx +
+		sizeof(struct fwu_image_entry) +
+		sizeof(struct fwu_image_bank_info) * bank;
+
+	return (struct fwu_image_bank_info *)((char *)mdata + offset);
+}
+
 /**
  * fwu_sync_mdata() - Update given meta-data partition(s) with the copy provided
  * @mdata: FWU metadata structure
-- 
2.34.1

