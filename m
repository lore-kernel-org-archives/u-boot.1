Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75307C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 01:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 901A187ECC;
	Tue, 12 Mar 2024 02:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="XMQhjf93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 389CC87F00; Tue, 12 Mar 2024 02:43:58 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by phobos.denx.de (Postfix) with ESMTP id A9C448780E
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 02:43:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bruce_suen@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HPFE1
 /gjQ9z0+znAKN6J9WsfEEV9HIRC9DHxPvsoboU=; b=XMQhjf93Xiv/O64sLkHUF
 w1TI2xUKp0DjQv3C/XBh3LVdUw6T9TirnG3PrbG8MWuoygIrRqsGX83is0xkx48p
 rsmW2/fs2UfG1rtj0ym8ohJqay1jASEWVZhT+T+pIi9uItf+NHoWCrjuFe2f22Xi
 efL/lT2eVVE66l2ddr1DK8=
Received: from localhost.localdomain (unknown [113.110.214.249])
 by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wAX7c81s+9lKRZjBg--.15601S4;
 Tue, 12 Mar 2024 09:43:18 +0800 (CST)
From: Bruce Suen <bruce_suen@163.com>
To: u-boot@lists.denx.de
Cc: frieder.schrempf@kontron.de, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, jagan@amarulasolutions.com,
 bruce.sun@xtxtech.com, Bruce Suen <bruce_suen@163.com>
Subject: [PATCH V4] mtd: spinand: Add support for XTX SPINAND
Date: Mon, 11 Mar 2024 21:43:14 -0400
Message-Id: <20240312014314.15454-1-bruce_suen@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAX7c81s+9lKRZjBg--.15601S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3ZFy3Ww4fKryfuw17uryfJFb_yoWDtr47p3
 s8tFyrGr48GF4xW3WxXa1DZr98Zw1xCrW7uw129a4YvFyfKw1rZFy7Ary3Cr1DG3yxJay3
 Cw4UKryDWa1YyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piQtxfUUUUU=
X-Originating-IP: [113.110.214.249]
X-CM-SenderInfo: 5euxuvpbvxv0i6rwjhhfrp/1tbiLhqfKGV4H5rJLQAAs-
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

Add support for XTX XT26G0xA and XT26xxxD. The driver is ported from
linux-6.7.1. This driver is tested on Banana BPI-R3 with XT26G01A and
XT26G12D.

Signed-off-by: Bruce Suen <bruce_suen@163.com>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
V3->V4:
- modify commit message minor flaws
---
 drivers/mtd/nand/spi/Makefile |   2 +-
 drivers/mtd/nand/spi/core.c   |   1 +
 drivers/mtd/nand/spi/xtx.c    | 266 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   |   1 +
 4 files changed, 269 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/spi/xtx.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index f172f4787f..65b836b34c 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 spinand-objs := core.o esmt.o gigadevice.o macronix.o micron.o paragon.o
-spinand-objs += toshiba.o winbond.o
+spinand-objs += toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 8ca33459f9..62c28aa422 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -829,6 +829,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&toshiba_spinand_manufacturer,
 	&winbond_spinand_manufacturer,
 	&esmt_c8_spinand_manufacturer,
+	&xtx_spinand_manufacturer,
 };
 
 static int spinand_manufacturer_match(struct spinand_device *spinand,
diff --git a/drivers/mtd/nand/spi/xtx.c b/drivers/mtd/nand/spi/xtx.c
new file mode 100644
index 0000000000..aee1849a71
--- /dev/null
+++ b/drivers/mtd/nand/spi/xtx.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author:
+ * Felix Matouschek <felix@matouschek.org>
+ */
+
+#include <linux/bitfield.h>
+#ifndef __UBOOT__
+#include <linux/device.h>
+#include <linux/kernel.h>
+#endif
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_XTX	0x0B
+
+#define XT26G0XA_STATUS_ECC_MASK	GENMASK(5, 2)
+#define XT26G0XA_STATUS_ECC_NO_DETECTED	(0 << 2)
+#define XT26G0XA_STATUS_ECC_8_CORRECTED	(3 << 4)
+#define XT26G0XA_STATUS_ECC_UNCOR_ERROR	(2 << 4)
+
+#define XT26XXXD_STATUS_ECC3_ECC2_MASK	    GENMASK(7, 6)
+#define XT26XXXD_STATUS_ECC_NO_DETECTED     (0)
+#define XT26XXXD_STATUS_ECC_1_7_CORRECTED   (1)
+#define XT26XXXD_STATUS_ECC_8_CORRECTED     (3)
+#define XT26XXXD_STATUS_ECC_UNCOR_ERROR     (2)
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int xt26g0xa_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	region->offset = 48;
+	region->length = 16;
+
+	return 0;
+}
+
+static int xt26g0xa_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	region->offset = 1;
+	region->length = 47;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops xt26g0xa_ooblayout = {
+	.ecc = xt26g0xa_ooblayout_ecc,
+	.rfree = xt26g0xa_ooblayout_free,
+};
+
+static int xt26g0xa_ecc_get_status(struct spinand_device *spinand,
+				   u8 status)
+{
+	status = status & XT26G0XA_STATUS_ECC_MASK;
+
+	switch (status) {
+	case XT26G0XA_STATUS_ECC_NO_DETECTED:
+		return 0;
+	case XT26G0XA_STATUS_ECC_8_CORRECTED:
+		return 8;
+	case XT26G0XA_STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+	default:
+		break;
+	}
+
+	/* At this point values greater than (2 << 4) are invalid  */
+	if (status > XT26G0XA_STATUS_ECC_UNCOR_ERROR)
+		return -EINVAL;
+
+	/* (1 << 2) through (7 << 2) are 1-7 corrected errors */
+	return status >> 2;
+}
+
+static int xt26xxxd_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	region->offset = mtd->oobsize / 2;
+	region->length = mtd->oobsize / 2;
+
+	return 0;
+}
+
+static int xt26xxxd_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	region->offset = 2;
+	region->length = mtd->oobsize / 2 - 2;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops xt26xxxd_ooblayout = {
+	.ecc = xt26xxxd_ooblayout_ecc,
+	.rfree = xt26xxxd_ooblayout_free,
+};
+
+static int xt26xxxd_ecc_get_status(struct spinand_device *spinand,
+				   u8 status)
+{
+	switch (FIELD_GET(STATUS_ECC_MASK, status)) {
+	case XT26XXXD_STATUS_ECC_NO_DETECTED:
+		return 0;
+	case XT26XXXD_STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+	case XT26XXXD_STATUS_ECC_1_7_CORRECTED:
+		return 4 + FIELD_GET(XT26XXXD_STATUS_ECC3_ECC2_MASK, status);
+	case XT26XXXD_STATUS_ECC_8_CORRECTED:
+		return 8;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static const struct spinand_info xtx_spinand_table[] = {
+	SPINAND_INFO("XT26G01A",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xE1),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&xt26g0xa_ooblayout,
+				     xt26g0xa_ecc_get_status)),
+	SPINAND_INFO("XT26G02A",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xE2),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&xt26g0xa_ooblayout,
+				     xt26g0xa_ecc_get_status)),
+	SPINAND_INFO("XT26G04A",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xE3),
+		     NAND_MEMORG(1, 2048, 64, 128, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&xt26g0xa_ooblayout,
+				     xt26g0xa_ecc_get_status)),
+	SPINAND_INFO("XT26G01D",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x31),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&xt26xxxd_ooblayout,
+				     xt26xxxd_ecc_get_status)),
+	SPINAND_INFO("XT26G11D",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x34),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&xt26xxxd_ooblayout,
+				     xt26xxxd_ecc_get_status)),
+	SPINAND_INFO("XT26Q01D",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&xt26xxxd_ooblayout,
+				     xt26xxxd_ecc_get_status)),
+	SPINAND_INFO("XT26G02D",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x32),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&xt26xxxd_ooblayout,
+				     xt26xxxd_ecc_get_status)),
+	SPINAND_INFO("XT26G12D",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x35),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&xt26xxxd_ooblayout,
+				     xt26xxxd_ecc_get_status)),
+	SPINAND_INFO("XT26Q02D",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x52),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&xt26xxxd_ooblayout,
+				     xt26xxxd_ecc_get_status)),
+	SPINAND_INFO("XT26G04D",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x33),
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&xt26xxxd_ooblayout,
+				     xt26xxxd_ecc_get_status)),
+	SPINAND_INFO("XT26Q04D",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x53),
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&xt26xxxd_ooblayout,
+				     xt26xxxd_ecc_get_status)),
+};
+
+static const struct spinand_manufacturer_ops xtx_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer xtx_spinand_manufacturer = {
+	.id = SPINAND_MFR_XTX,
+	.name = "XTX",
+	.chips = xtx_spinand_table,
+	.nchips = ARRAY_SIZE(xtx_spinand_table),
+	.ops = &xtx_spinand_manuf_ops,
+};
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 6f479fa5ad..13b5a52f8b 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -251,6 +251,7 @@ extern const struct spinand_manufacturer paragon_spinand_manufacturer;
 extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
 extern const struct spinand_manufacturer winbond_spinand_manufacturer;
 extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
+extern const struct spinand_manufacturer xtx_spinand_manufacturer;
 
 /**
  * struct spinand_op_variants - SPI NAND operation variants
-- 
2.34.1

