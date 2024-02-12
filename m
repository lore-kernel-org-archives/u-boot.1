Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5553EC4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 07:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EA9487EF2;
	Mon, 12 Feb 2024 08:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0059487808; Mon, 12 Feb 2024 08:48:17 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C4C9587EC9
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:48:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0579DA7;
 Sun, 11 Feb 2024 23:48:56 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F7AB3F762;
 Sun, 11 Feb 2024 23:48:11 -0800 (PST)
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
Subject: [PATCH v2 11/21] fwu: mtd: modify the DFU API's to align with
 metadata version 2
Date: Mon, 12 Feb 2024 13:17:02 +0530
Message-Id: <20240212074712.3657076-12-sughosh.ganu@linaro.org>
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

Make changes to the functions used for generating the DFU's alt
variable so that they are aligned with changes to the metadata version
2.

These changes include getting the number of banks and images per bank
at runtime from the metadata, as well as accessing the updatable image
information from the FWU MTD driver's private structure.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Changes since V1:
* Use the helper functions from the previous patch to access the
  image information in the metadata.

 lib/fwu_updates/fwu_mtd.c | 81 +++++++++++++++++++++++++++++----------
 1 file changed, 61 insertions(+), 20 deletions(-)

diff --git a/lib/fwu_updates/fwu_mtd.c b/lib/fwu_updates/fwu_mtd.c
index 69cd3d7001..50ff0d692d 100644
--- a/lib/fwu_updates/fwu_mtd.c
+++ b/lib/fwu_updates/fwu_mtd.c
@@ -15,16 +15,51 @@
 
 #include <dm/ofnode.h>
 
-struct fwu_mtd_image_info
-fwu_mtd_images[CONFIG_FWU_NUM_BANKS * CONFIG_FWU_NUM_IMAGES_PER_BANK];
+static struct fwu_mdata *mdata;
+
+static int read_mdata(void)
+{
+	int ret = 0;
+	u32 mdata_size;
+
+	ret = fwu_get_mdata_size(&mdata_size);
+	if (ret)
+		return ret;
+
+	mdata = malloc(mdata_size);
+	if (!mdata)
+		return -ENOMEM;
+
+	ret = fwu_get_mdata(mdata);
+	if (ret < 0) {
+		log_err("Failed to get the FWU mdata\n");
+		free(mdata);
+		mdata = NULL;
+	}
+
+	return ret;
+}
 
 static struct fwu_mtd_image_info *mtd_img_by_uuid(const char *uuidbuf)
 {
-	int num_images = ARRAY_SIZE(fwu_mtd_images);
+	u8 nbanks;
+	u16 nimages;
+	int num_images, ret;
+	struct fwu_mdata_mtd_priv *mtd_priv = dev_get_priv(fwu_get_dev());
+	struct fwu_mtd_image_info *image_info = mtd_priv->fwu_mtd_images;
+
+	if (!image_info)
+		return NULL;
+
+	ret = fwu_get_banks_images(&nbanks, &nimages);
+	if (ret)
+		return NULL;
+
+	num_images = nbanks * nimages;
 
 	for (int i = 0; i < num_images; i++)
-		if (!strcmp(uuidbuf, fwu_mtd_images[i].uuidbuf))
-			return &fwu_mtd_images[i];
+		if (!strcmp(uuidbuf, image_info[i].uuidbuf))
+			return &image_info[i];
 
 	return NULL;
 }
@@ -107,8 +142,9 @@ __weak int fwu_plat_get_alt_num(struct udevice *dev, efi_guid_t *image_id,
 	return fwu_mtd_get_alt_num(image_id, alt_num, "nor1");
 }
 
-static int gen_image_alt_info(char *buf, size_t len, int sidx,
-			      struct fwu_image_entry *img, struct mtd_info *mtd)
+static int gen_image_alt_info(char *buf, size_t len, int idx,
+			      struct fwu_image_entry *img,
+			      struct mtd_info *mtd, uint8_t num_banks)
 {
 	char *p = buf, *end = buf + len;
 	int i;
@@ -123,15 +159,15 @@ static int gen_image_alt_info(char *buf, size_t len, int sidx,
 	 * List the image banks in the FWU mdata and search the corresponding
 	 * partition based on partition's uuid.
 	 */
-	for (i = 0; i < CONFIG_FWU_NUM_BANKS; i++) {
+	for (i = 0; i < num_banks; i++) {
 		struct fwu_mtd_image_info *mtd_img_info;
 		struct fwu_image_bank_info *bank;
 		char uuidbuf[UUID_STR_LEN + 1];
 		u32 offset, size;
 
 		/* Query a partition by image UUID */
-		bank = &img->img_bank_info[i];
-		uuid_bin_to_str(bank->image_uuid.b, uuidbuf, UUID_STR_FORMAT_STD);
+		bank = fwu_img_bank_info_offset(mdata, idx, i);
+		uuid_bin_to_str(bank->image_guid.b, uuidbuf, UUID_STR_FORMAT_STD);
 
 		mtd_img_info = mtd_img_by_uuid(uuidbuf);
 		if (!mtd_img_info) {
@@ -150,7 +186,7 @@ static int gen_image_alt_info(char *buf, size_t len, int sidx,
 		}
 	}
 
-	if (i == CONFIG_FWU_NUM_BANKS)
+	if (i == num_banks)
 		return 0;
 
 	return -ENOENT;
@@ -158,24 +194,29 @@ static int gen_image_alt_info(char *buf, size_t len, int sidx,
 
 int fwu_gen_alt_info_from_mtd(char *buf, size_t len, struct mtd_info *mtd)
 {
-	struct fwu_mdata mdata;
+	u8 num_banks;
+	u16 num_images;
 	int i, l, ret;
+	struct fwu_image_entry *img_entry;
 
-	ret = fwu_get_mdata(&mdata);
-	if (ret < 0) {
-		log_err("Failed to get the FWU mdata.\n");
-		return ret;
+	if (!mdata) {
+		ret = read_mdata();
+		if (ret)
+			return ret;
 	}
 
-	for (i = 0; i < CONFIG_FWU_NUM_IMAGES_PER_BANK; i++) {
-		ret = gen_image_alt_info(buf, len, i * CONFIG_FWU_NUM_BANKS,
-					 &mdata.img_entry[i], mtd);
+	num_banks = fwu_get_fw_desc(mdata)->num_banks;
+	num_images = fwu_get_fw_desc(mdata)->num_images;
+	for (i = 0; i < num_images; i++) {
+		img_entry = fwu_img_entry_offset(mdata, i);
+		ret = gen_image_alt_info(buf, len, i,
+					 img_entry, mtd, num_banks);
 		if (ret)
 			break;
 
 		l = strlen(buf);
 		/* Replace the last ';' with '&' if there is another image. */
-		if (i != CONFIG_FWU_NUM_IMAGES_PER_BANK - 1 && l) {
+		if (i != num_images - 1 && l) {
 			buf[l] = '&';
 			buf++;
 		}
-- 
2.34.1

