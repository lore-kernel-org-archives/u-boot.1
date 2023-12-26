Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FE0C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 07:58:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEF4E87480;
	Tue, 26 Dec 2023 08:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="ES9UchBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4D9A87561; Tue, 26 Dec 2023 08:58:38 +0100 (CET)
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
 by phobos.denx.de (Postfix) with ESMTP id 9E1C68744F
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 08:58:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bruce_suen@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mnhD5
 4i6exgX5sXYDntDldP1rq0CyGtCgE7V17USBW0=; b=ES9UchBn3uqDV67yzI49i
 9YitCnp2WsEl+mc8fCoFhpPRES6BpUuySNGU8dauCZz0CvU5IZ9soC89Mtg9OJEE
 PEUUNCbqKpdxasZU5OJzo6blvOnNyxe0n2vuaJr8pcw/xYFNBeFM065GU4b0ejcG
 KIVt21tj1aYQ1kdXeZq+Uo=
Received: from localhost.localdomain (unknown [113.110.214.156])
 by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wC3XxCXh4plOHDGEg--.61781S4;
 Tue, 26 Dec 2023 15:58:17 +0800 (CST)
From: Bruce Suen <bruce_suen@163.com>
To: u-boot@lists.denx.de
Cc: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 frieder.schrempf@kontron.de, jagan@amarulasolutions.com,
 bruce.sun@xtxtech.com, Bruce Suen <bruce_suen@163.com>
Subject: [PATCH] mtd: spinand: Add support for XTX XT26xxxDxxxxx
Date: Tue, 26 Dec 2023 02:58:12 -0500
Message-Id: <20231226075812.3803-1-bruce_suen@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3XxCXh4plOHDGEg--.61781S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3JFyrGw1xJr4ftF1rZw48Crg_yoW3tw17pa
 s0qFyrGr48Ga17Was2qayDZr98Xw4xKrW7u3429a4jvFyrK34rZFZrAry3CrnrG3yxJay3
 uw4jgr9rW3WYyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRVT5LUUUUU=
X-Originating-IP: [113.110.214.156]
X-CM-SenderInfo: 5euxuvpbvxv0i6rwjhhfrp/1tbitxtSKGV4HBLO6QAAsi
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

Add Support XTX Technology XT26G01DXXXXX, XT26G11DXXXXX, XT26Q01DXXXXX,
XT26G02DXXXXX, XT26G12DXXXXX, XT26Q02DXXXXX, XT26G04DXXXXX, and
XT26Q04DXXXXX SPI NAND.

These are 3V/1.8V 1G/2G/4Gbit serial SLC NAND flash device with on-die
ECC(8bit strength per 512bytes).

Datasheet Links:
- http://www.xtxtech.com/download/?AId=458
- http://www.xtxtech.com/download/?AId=495

Signed-off-by: Bruce Suen <bruce_suen@163.com>
---
 drivers/mtd/nand/spi/Makefile |   1 +
 drivers/mtd/nand/spi/core.c   |   1 +
 drivers/mtd/nand/spi/xtx.c    | 180 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   |   1 +
 4 files changed, 183 insertions(+)
 create mode 100644 drivers/mtd/nand/spi/xtx.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 3051de4f7e..e46cfed446 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 spinand-objs := core.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o
+spinand-objs += xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 597b088ca7..0b4c067425 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -828,6 +828,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&paragon_spinand_manufacturer,
 	&toshiba_spinand_manufacturer,
 	&winbond_spinand_manufacturer,
+	&xtx_spinand_manufacturer,
 };
 
 static int spinand_manufacturer_match(struct spinand_device *spinand,
diff --git a/drivers/mtd/nand/spi/xtx.c b/drivers/mtd/nand/spi/xtx.c
new file mode 100644
index 0000000000..602861c77b
--- /dev/null
+++ b/drivers/mtd/nand/spi/xtx.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Stefan Roese <sr@denx.de>
+ *
+ * Derived from drivers/mtd/nand/spi/micron.c
+ *   Copyright (c) 2016-2017 Micron Technology, Inc.
+ */
+
+#ifndef __UBOOT__
+#include <linux/device.h>
+#include <linux/kernel.h>
+#endif
+#include <linux/bitfield.h>
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_XTX	0x0B
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
index e8d6feb970..bf7696a981 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -251,6 +251,7 @@ extern const struct spinand_manufacturer micron_spinand_manufacturer;
 extern const struct spinand_manufacturer paragon_spinand_manufacturer;
 extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
 extern const struct spinand_manufacturer winbond_spinand_manufacturer;
+extern const struct spinand_manufacturer xtx_spinand_manufacturer;
 
 /**
  * struct spinand_op_variants - SPI NAND operation variants
-- 
2.34.1

