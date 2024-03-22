Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A6FC47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 10:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9C75881C3;
	Fri, 22 Mar 2024 11:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2F6788113; Fri, 22 Mar 2024 11:58:21 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 643BF881D1
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F2AC1007;
 Fri, 22 Mar 2024 03:58:52 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24BC73F64C;
 Fri, 22 Mar 2024 03:58:14 -0700 (PDT)
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
Subject: [PATCH v3 03/20] drivers: fwu: add the size parameter to the metadata
 access API's
Date: Fri, 22 Mar 2024 16:27:16 +0530
Message-Id: <20240322105733.203888-4-sughosh.ganu@linaro.org>
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

In version 2 of the metadata structure, the size of the structure
cannot be determined statically at build time. The structure is now
broken into the top level structure which contains a field indicating
the total size of the structure.

Add a size parameter to the metadata access API functions to indicate
the number of bytes to be accessed. This is then used to either read
the entire structure, or only the top level structure.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2: None

 drivers/fwu-mdata/fwu-mdata-uclass.c | 10 ++++++----
 drivers/fwu-mdata/gpt_blk.c          | 23 +++++++++++++----------
 drivers/fwu-mdata/raw_mtd.c          | 10 ++++++----
 include/fwu.h                        | 14 ++++++++++----
 4 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/fwu-mdata/fwu-mdata-uclass.c b/drivers/fwu-mdata/fwu-mdata-uclass.c
index 0a8edaaa41..145479bab0 100644
--- a/drivers/fwu-mdata/fwu-mdata-uclass.c
+++ b/drivers/fwu-mdata/fwu-mdata-uclass.c
@@ -20,7 +20,8 @@
  *
  * Return: 0 if OK, -ve on error
  */
-int fwu_read_mdata(struct udevice *dev, struct fwu_mdata *mdata, bool primary)
+int fwu_read_mdata(struct udevice *dev, struct fwu_mdata *mdata, bool primary,
+		   uint32_t size)
 {
 	const struct fwu_mdata_ops *ops = device_get_ops(dev);
 
@@ -29,7 +30,7 @@ int fwu_read_mdata(struct udevice *dev, struct fwu_mdata *mdata, bool primary)
 		return -ENOSYS;
 	}
 
-	return ops->read_mdata(dev, mdata, primary);
+	return ops->read_mdata(dev, mdata, primary, size);
 }
 
 /**
@@ -37,7 +38,8 @@ int fwu_read_mdata(struct udevice *dev, struct fwu_mdata *mdata, bool primary)
  *
  * Return: 0 if OK, -ve on error
  */
-int fwu_write_mdata(struct udevice *dev, struct fwu_mdata *mdata, bool primary)
+int fwu_write_mdata(struct udevice *dev, struct fwu_mdata *mdata, bool primary,
+		    uint32_t size)
 {
 	const struct fwu_mdata_ops *ops = device_get_ops(dev);
 
@@ -46,7 +48,7 @@ int fwu_write_mdata(struct udevice *dev, struct fwu_mdata *mdata, bool primary)
 		return -ENOSYS;
 	}
 
-	return ops->write_mdata(dev, mdata, primary);
+	return ops->write_mdata(dev, mdata, primary, size);
 }
 
 UCLASS_DRIVER(fwu_mdata) = {
diff --git a/drivers/fwu-mdata/gpt_blk.c b/drivers/fwu-mdata/gpt_blk.c
index c7284916c4..97eac3611f 100644
--- a/drivers/fwu-mdata/gpt_blk.c
+++ b/drivers/fwu-mdata/gpt_blk.c
@@ -81,15 +81,14 @@ static int gpt_get_mdata_disk_part(struct blk_desc *desc,
 	return -ENOENT;
 }
 
-static int gpt_read_write_mdata(struct blk_desc *desc,
-				struct fwu_mdata *mdata,
-				u8 access, u32 part_num)
+static int gpt_read_write_mdata(struct blk_desc *desc, struct fwu_mdata *mdata,
+				u8 access, u32 part_num, u32 size)
 {
 	int ret;
 	u32 len, blk_start, blkcnt;
 	struct disk_partition info;
 
-	ALLOC_CACHE_ALIGN_BUFFER_PAD(struct fwu_mdata, mdata_aligned, 1,
+	ALLOC_CACHE_ALIGN_BUFFER_PAD(u8, mdata_aligned, size,
 				     desc->blksz);
 
 	if (!mdata)
@@ -101,7 +100,7 @@ static int gpt_read_write_mdata(struct blk_desc *desc,
 		return -ENOENT;
 	}
 
-	len = sizeof(*mdata);
+	len = size;
 	blkcnt = BLOCK_CNT(len, desc);
 	if (blkcnt > info.size) {
 		log_debug("Block count exceeds FWU metadata partition size\n");
@@ -114,7 +113,7 @@ static int gpt_read_write_mdata(struct blk_desc *desc,
 			log_debug("Error reading FWU metadata from the device\n");
 			return -EIO;
 		}
-		memcpy(mdata, mdata_aligned, sizeof(struct fwu_mdata));
+		memcpy(mdata, mdata_aligned, size);
 	} else {
 		if (blk_dwrite(desc, blk_start, blkcnt, mdata) != blkcnt) {
 			log_debug("Error writing FWU metadata to the device\n");
@@ -164,7 +163,7 @@ static int fwu_mdata_gpt_blk_probe(struct udevice *dev)
 }
 
 static int fwu_gpt_read_mdata(struct udevice *dev, struct fwu_mdata *mdata,
-			      bool primary)
+			      bool primary, u32 size)
 {
 	struct fwu_mdata_gpt_blk_priv *priv = dev_get_priv(dev);
 	struct blk_desc *desc = dev_get_uclass_plat(priv->blk_dev);
@@ -177,11 +176,13 @@ static int fwu_gpt_read_mdata(struct udevice *dev, struct fwu_mdata *mdata,
 	}
 
 	return gpt_read_write_mdata(desc, mdata, MDATA_READ,
-				    primary ? g_mdata_part[0] : g_mdata_part[1]);
+				    primary ?
+				    g_mdata_part[0] : g_mdata_part[1],
+				    size);
 }
 
 static int fwu_gpt_write_mdata(struct udevice *dev, struct fwu_mdata *mdata,
-			       bool primary)
+			       bool primary, u32 size)
 {
 	struct fwu_mdata_gpt_blk_priv *priv = dev_get_priv(dev);
 	struct blk_desc *desc = dev_get_uclass_plat(priv->blk_dev);
@@ -194,7 +195,9 @@ static int fwu_gpt_write_mdata(struct udevice *dev, struct fwu_mdata *mdata,
 	}
 
 	return gpt_read_write_mdata(desc, mdata, MDATA_WRITE,
-				    primary ? g_mdata_part[0] : g_mdata_part[1]);
+				    primary ?
+				    g_mdata_part[0] : g_mdata_part[1],
+				    size);
 }
 
 static const struct fwu_mdata_ops fwu_gpt_blk_ops = {
diff --git a/drivers/fwu-mdata/raw_mtd.c b/drivers/fwu-mdata/raw_mtd.c
index 17e4517973..9f3f1dc213 100644
--- a/drivers/fwu-mdata/raw_mtd.c
+++ b/drivers/fwu-mdata/raw_mtd.c
@@ -97,22 +97,24 @@ lock:
 	return ret;
 }
 
-static int fwu_mtd_read_mdata(struct udevice *dev, struct fwu_mdata *mdata, bool primary)
+static int fwu_mtd_read_mdata(struct udevice *dev, struct fwu_mdata *mdata,
+			      bool primary, u32 size)
 {
 	struct fwu_mdata_mtd_priv *mtd_priv = dev_get_priv(dev);
 	struct mtd_info *mtd = mtd_priv->mtd;
 	u32 offs = primary ? mtd_priv->pri_offset : mtd_priv->sec_offset;
 
-	return mtd_io_data(mtd, offs, sizeof(struct fwu_mdata), mdata, FWU_MTD_READ);
+	return mtd_io_data(mtd, offs, size, mdata, FWU_MTD_READ);
 }
 
-static int fwu_mtd_write_mdata(struct udevice *dev, struct fwu_mdata *mdata, bool primary)
+static int fwu_mtd_write_mdata(struct udevice *dev, struct fwu_mdata *mdata,
+			       bool primary, u32 size)
 {
 	struct fwu_mdata_mtd_priv *mtd_priv = dev_get_priv(dev);
 	struct mtd_info *mtd = mtd_priv->mtd;
 	u32 offs = primary ? mtd_priv->pri_offset : mtd_priv->sec_offset;
 
-	return mtd_io_data(mtd, offs, sizeof(struct fwu_mdata), mdata, FWU_MTD_WRITE);
+	return mtd_io_data(mtd, offs, size, mdata, FWU_MTD_WRITE);
 }
 
 static int flash_partition_offset(struct udevice *dev, const char *part_name, fdt_addr_t *offset)
diff --git a/include/fwu.h b/include/fwu.h
index eb5638f4f3..1815bd0064 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -32,20 +32,24 @@ struct fwu_mdata_ops {
 	 * @dev: FWU metadata device
 	 * @mdata: Output FWU mdata read
 	 * @primary: If primary or secondary copy of metadata is to be read
+	 * @size: Size in bytes of the metadata to be read
 	 *
 	 * Return: 0 if OK, -ve on error
 	 */
-	int (*read_mdata)(struct udevice *dev, struct fwu_mdata *mdata, bool primary);
+	int (*read_mdata)(struct udevice *dev, struct fwu_mdata *mdata,
+			  bool primary, uint32_t size);
 
 	/**
 	 * write_mdata() - Write the given FWU metadata copy
 	 * @dev: FWU metadata device
 	 * @mdata: Copy of the FWU metadata to write
 	 * @primary: If primary or secondary copy of metadata is to be written
+	 * @size: Size in bytes of the metadata to be written
 	 *
 	 * Return: 0 if OK, -ve on error
 	 */
-	int (*write_mdata)(struct udevice *dev, struct fwu_mdata *mdata, bool primary);
+	int (*write_mdata)(struct udevice *dev, struct fwu_mdata *mdata,
+			   bool primary, uint32_t size);
 };
 
 #define FWU_MDATA_VERSION	0x1
@@ -80,12 +84,14 @@ struct fwu_mdata_ops {
 /**
  * fwu_read_mdata() - Wrapper around fwu_mdata_ops.read_mdata()
  */
-int fwu_read_mdata(struct udevice *dev, struct fwu_mdata *mdata, bool primary);
+int fwu_read_mdata(struct udevice *dev, struct fwu_mdata *mdata,
+		   bool primary, uint32_t size);
 
 /**
  * fwu_write_mdata() - Wrapper around fwu_mdata_ops.write_mdata()
  */
-int fwu_write_mdata(struct udevice *dev, struct fwu_mdata *mdata, bool primary);
+int fwu_write_mdata(struct udevice *dev, struct fwu_mdata *mdata,
+		    bool primary, uint32_t size);
 
 /**
  * fwu_get_mdata() - Read, verify and return the FWU metadata
-- 
2.34.1

