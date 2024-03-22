Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04584C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 10:58:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3084487F6A;
	Fri, 22 Mar 2024 11:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53ADD86BDB; Fri, 22 Mar 2024 11:58:24 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 26CE988113
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA5641007;
 Fri, 22 Mar 2024 03:58:55 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F8873F64C;
 Fri, 22 Mar 2024 03:58:18 -0700 (PDT)
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
Subject: [PATCH v3 04/20] drivers: fwu: mtd: allocate buffer for image info
 dynamically
Date: Fri, 22 Mar 2024 16:27:17 +0530
Message-Id: <20240322105733.203888-5-sughosh.ganu@linaro.org>
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

The FWU metadata access driver for MTD partitioned devices currently
uses a statically allocated array for storing the updatable image
information. This array depends on the number of banks and images per
bank. With migration of the FWU metadata to version 2, these
parameters are now obtained at runtime from the metadata.

Make changes to the FWU metadata access driver for MTD devices to
allocate memory for the image information dynamically in the driver's
probe function, after having obtained the number of banks and images
per bank by reading the metadata. Move the image information as part
of the driver's private structure, instead of using a global variable.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2: None

 drivers/fwu-mdata/raw_mtd.c | 68 +++++++++++++++++++++++--------------
 include/fwu.h               |  9 +++++
 2 files changed, 52 insertions(+), 25 deletions(-)

diff --git a/drivers/fwu-mdata/raw_mtd.c b/drivers/fwu-mdata/raw_mtd.c
index 9f3f1dc213..78a709f766 100644
--- a/drivers/fwu-mdata/raw_mtd.c
+++ b/drivers/fwu-mdata/raw_mtd.c
@@ -12,22 +12,11 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 
-/* Internal helper structure to move data around */
-struct fwu_mdata_mtd_priv {
-	struct mtd_info *mtd;
-	char pri_label[50];
-	char sec_label[50];
-	u32 pri_offset;
-	u32 sec_offset;
-};
-
 enum fwu_mtd_op {
 	FWU_MTD_READ,
 	FWU_MTD_WRITE,
 };
 
-extern struct fwu_mtd_image_info fwu_mtd_images[];
-
 static bool mtd_is_aligned_with_block_size(struct mtd_info *mtd, u64 size)
 {
 	return !do_div(size, mtd->erasesize);
@@ -134,7 +123,7 @@ static int flash_partition_offset(struct udevice *dev, const char *part_name, fd
 	return (int)size;
 }
 
-static int fwu_mdata_mtd_of_to_plat(struct udevice *dev)
+static int get_fwu_mdata_dev(struct udevice *dev)
 {
 	struct fwu_mdata_mtd_priv *mtd_priv = dev_get_priv(dev);
 	const fdt32_t *phandle_p = NULL;
@@ -144,8 +133,6 @@ static int fwu_mdata_mtd_of_to_plat(struct udevice *dev)
 	fdt_addr_t offset;
 	int ret, size;
 	u32 phandle;
-	ofnode bank;
-	int off_img;
 
 	/* Find the FWU mdata storage device */
 	phandle_p = ofnode_get_property(dev_ofnode(dev),
@@ -199,8 +186,28 @@ static int fwu_mdata_mtd_of_to_plat(struct udevice *dev)
 		return ret;
 	mtd_priv->sec_offset = offset;
 
-	off_img = 0;
+	return 0;
+}
+
+static int fwu_mtd_image_info_populate(struct udevice *dev, u8 nbanks,
+				       u16 nimages)
+{
+	struct fwu_mtd_image_info *mtd_images;
+	struct fwu_mdata_mtd_priv *mtd_priv = dev_get_priv(dev);
+	struct udevice *mtd_dev = mtd_priv->mtd->dev;
+	fdt_addr_t offset;
+	ofnode bank;
+	int off_img;
+	u32 total_images;
 
+	total_images = nbanks * nimages;
+	mtd_priv->fwu_mtd_images = malloc(sizeof(struct fwu_mtd_image_info) *
+					  total_images);
+	if (!mtd_priv->fwu_mtd_images)
+		return -ENOMEM;
+
+	off_img = 0;
+	mtd_images = mtd_priv->fwu_mtd_images;
 	ofnode_for_each_subnode(bank, dev_ofnode(dev)) {
 		int bank_num, bank_offset, bank_size;
 		const char *bank_name;
@@ -219,8 +226,7 @@ static int fwu_mdata_mtd_of_to_plat(struct udevice *dev)
 			int image_num, image_offset, image_size;
 			const char *uuid;
 
-			if (off_img == CONFIG_FWU_NUM_BANKS *
-						CONFIG_FWU_NUM_IMAGES_PER_BANK) {
+			if (off_img == total_images) {
 				log_err("DT provides more images than configured!\n");
 				break;
 			}
@@ -230,11 +236,11 @@ static int fwu_mdata_mtd_of_to_plat(struct udevice *dev)
 			ofnode_read_u32(image, "offset", &image_offset);
 			ofnode_read_u32(image, "size", &image_size);
 
-			fwu_mtd_images[off_img].start = bank_offset + image_offset;
-			fwu_mtd_images[off_img].size = image_size;
-			fwu_mtd_images[off_img].bank_num = bank_num;
-			fwu_mtd_images[off_img].image_num = image_num;
-			strcpy(fwu_mtd_images[off_img].uuidbuf, uuid);
+			mtd_images[off_img].start = bank_offset + image_offset;
+			mtd_images[off_img].size = image_size;
+			mtd_images[off_img].bank_num = bank_num;
+			mtd_images[off_img].image_num = image_num;
+			strcpy(mtd_images[off_img].uuidbuf, uuid);
 			log_debug("\tImage%d: %s @0x%x\n\n",
 				  image_num, uuid, bank_offset + image_offset);
 			off_img++;
@@ -246,8 +252,21 @@ static int fwu_mdata_mtd_of_to_plat(struct udevice *dev)
 
 static int fwu_mdata_mtd_probe(struct udevice *dev)
 {
-	/* Ensure the metadata can be read. */
-	return fwu_get_mdata(NULL);
+	u8 nbanks;
+	u16 nimages;
+	int ret;
+
+	ret = get_fwu_mdata_dev(dev);
+	if (ret)
+		return ret;
+
+	nbanks = CONFIG_FWU_NUM_BANKS;
+	nimages = CONFIG_FWU_NUM_IMAGES_PER_BANK;
+	ret = fwu_mtd_image_info_populate(dev, nbanks, nimages);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static struct fwu_mdata_ops fwu_mtd_ops = {
@@ -266,6 +285,5 @@ U_BOOT_DRIVER(fwu_mdata_mtd) = {
 	.of_match	= fwu_mdata_ids,
 	.ops		= &fwu_mtd_ops,
 	.probe		= fwu_mdata_mtd_probe,
-	.of_to_plat	= fwu_mdata_mtd_of_to_plat,
 	.priv_auto	= sizeof(struct fwu_mdata_mtd_priv),
 };
diff --git a/include/fwu.h b/include/fwu.h
index 1815bd0064..6c4d218e13 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -26,6 +26,15 @@ struct fwu_mtd_image_info {
 	char uuidbuf[UUID_STR_LEN + 1];
 };
 
+struct fwu_mdata_mtd_priv {
+	struct mtd_info *mtd;
+	char pri_label[50];
+	char sec_label[50];
+	u32 pri_offset;
+	u32 sec_offset;
+	struct fwu_mtd_image_info *fwu_mtd_images;
+};
+
 struct fwu_mdata_ops {
 	/**
 	 * read_mdata() - Populate the asked FWU metadata copy
-- 
2.34.1

