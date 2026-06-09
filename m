Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8910CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 08:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A4DE83FF5;
	Tue,  9 Jun 2026 10:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="YbU+pspg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5C838405A; Tue,  9 Jun 2026 10:44:52 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D76E83FEC
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 10:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 76dc0c2463df11f1b1788b6acf885367-20260609
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=O9srg1g8VuVJHqHFz8wP0qiUCmmosM4b0/LrS3uMatw=; 
 b=YbU+pspgJtmHGRDh7qLkURV0d+SxjFZo9j12EEitfSVrfc1V9P5olQ1K9X3I5A41Qg6AJ2uV13iTYNNHU1u+9TzcMCxMGaJXufa9FWTXNMkxnjMvTdjytgbHiQ7sdTyKlIIRmCm/t+HbDp8fSyKh7gK4BeCrlljUs2NFzDEUzLE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15, REQID:c3c8324f-aff1-47c1-b26a-af542ed75e54, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:e276073, CLOUDID:8e8d2bfa-81ed-44fb-bfa5-a14262ddda97,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|136|836|865|888|898,TC:-5,Conten
 t:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:
 0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 76dc0c2463df11f1b1788b6acf885367-20260609
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1701349364; Tue, 09 Jun 2026 16:44:44 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Jun 2026 16:44:43 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 9 Jun 2026 16:44:42 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Tianling Shen <cnsztl@gmail.com>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Cheng Ming Lin
 <chengminglin@mxic.com.tw>, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v2] mtd: spinand: add support for Etron SPI-NAND flashes
Date: Tue, 9 Jun 2026 16:44:35 +0800
Message-ID: <20260609084435.56297-1-weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
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

This patch adds some Etron SPI-NAND flashes from 1Gb to 8Gb with
4-bits/8-bits On-die ECC support.

EM73C044VCF/EM73D044VCO/EM73E044VCE/EM73F044VCA are tested on MediaTek
filogic MT7988 reference board.

Link: https://etron.com/wp-content/uploads/2024/08/EM73C044VCF-SPI-NAND-Flash_Rev-1.03.pdf
Link: https://etron.com/wp-content/uploads/2022/04/EM73D044VCOR-SPI-NAND-Flash_Rev-1.00.pdf
Link: https://etron.com/wp-content/uploads/2022/04/EM78DE044VC-SPI-NAND-Flash_Rev-1.01.pdf
Link: https://etron.com/wp-content/uploads/2024/08/EM73E044VCEG-SPI-NAND-Flash_Rev-1.00.pdf
Link: https://etron.com/wp-content/uploads/2022/04/EM738F044VCA-SPI-NAND-Flash_Rev-1.02.pdf
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
Changes in v2:
Group oob/ecc layouts
Follow ecc handling from linux kernel
---
 drivers/mtd/nand/spi/Makefile |   5 +-
 drivers/mtd/nand/spi/core.c   |   1 +
 drivers/mtd/nand/spi/etron.c  | 226 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   |   1 +
 4 files changed, 231 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/etron.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index a7a0b2cb4b9..4664280c8d6 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 spinand-objs := core.o otp.o
-spinand-objs += alliancememory.o ato.o esmt.o fmsh.o foresee.o gigadevice.o macronix.o
-spinand-objs += micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
+spinand-objs += alliancememory.o ato.o esmt.o etron.o fmsh.o foresee.o
+spinand-objs += gigadevice.o macronix.o micron.o paragon.o skyhigh.o toshiba.o
+spinand-objs += winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 14af4264612..b032b0fec24 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1227,6 +1227,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&alliancememory_spinand_manufacturer,
 	&ato_spinand_manufacturer,
 	&esmt_c8_spinand_manufacturer,
+	&etron_spinand_manufacturer,
 	&fmsh_spinand_manufacturer,
 	&foresee_spinand_manufacturer,
 	&gigadevice_spinand_manufacturer,
diff --git a/drivers/mtd/nand/spi/etron.c b/drivers/mtd/nand/spi/etron.c
new file mode 100644
index 00000000000..80065665a41
--- /dev/null
+++ b/drivers/mtd/nand/spi/etron.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Etron Technology, Inc.
+ *
+ */
+#ifndef __UBOOT__
+#include <linux/device.h>
+#include <linux/kernel.h>
+#endif
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_ETRON		0xD5
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
+
+static int etron_ecc4_ooblayout_ecc(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	region->offset = 32;
+	region->length = 32;
+
+	return 0;
+}
+
+static int etron_ecc4_ooblayout_free(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	/* section 0 has two bytes reserved for bad block mark */
+	region->offset = 2;
+	region->length = 30;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops etron_ecc4_ooblayout = {
+	.ecc = etron_ecc4_ooblayout_ecc,
+	.rfree = etron_ecc4_ooblayout_free,
+};
+
+static int etron_ecc8_ooblayout_ecc(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *region)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	u32 steps = spinand->base.memorg.pagesize / mtd->ecc_step_size;
+
+	if (section)
+		return -ERANGE;
+
+	region->offset = 18 * steps;
+	region->length = 14 * steps;
+
+	return 0;
+}
+
+static int etron_ecc8_ooblayout_free(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *region)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	u32 steps = spinand->base.memorg.pagesize / mtd->ecc_step_size;
+
+	if (section)
+		return -ERANGE;
+
+	/* section 0 has two bytes reserved for bad block mark */
+	region->offset = 2;
+	region->length = 18 * steps - 2;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops etron_ecc8_ooblayout = {
+	.ecc = etron_ecc8_ooblayout_ecc,
+	.rfree = etron_ecc8_ooblayout_free,
+};
+
+static int etron_ecc_get_status(struct spinand_device *spinand, u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		return nand->eccreq.strength - 1;
+
+	case STATUS_ECC_MASK:
+		return nand->eccreq.strength;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static const struct spinand_info etron_spinand_table[] = {
+	/* EM73C 1Gb 3.3V */
+	SPINAND_INFO("EM73C044VCF",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x25),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&etron_ecc4_ooblayout,
+				     etron_ecc_get_status)),
+	/* EM7xD 2Gb */
+	SPINAND_INFO("EM73D044VCR",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x41),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&etron_ecc4_ooblayout,
+				     etron_ecc_get_status)),
+	SPINAND_INFO("EM73D044VCO",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x3A),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&etron_ecc8_ooblayout,
+				     etron_ecc_get_status)),
+	SPINAND_INFO("EM78D044VCM",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x8E),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&etron_ecc8_ooblayout,
+				     etron_ecc_get_status)),
+	/* EM7xE 4Gb */
+	SPINAND_INFO("EM73E044VCG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x42),
+		     NAND_MEMORG(1, 2048, 64, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&etron_ecc4_ooblayout,
+				     etron_ecc_get_status)),
+	SPINAND_INFO("EM73E044VCE",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x3B),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&etron_ecc8_ooblayout,
+				     etron_ecc_get_status)),
+	SPINAND_INFO("EM78E044VCD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x8F),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&etron_ecc8_ooblayout,
+				     etron_ecc_get_status)),
+	/* EM7xF 8Gb */
+	SPINAND_INFO("EM73F044VCA",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x2D),
+		     NAND_MEMORG(1, 4096, 256, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&etron_ecc8_ooblayout,
+				     etron_ecc_get_status)),
+	SPINAND_INFO("EM78F044VCA",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x8D),
+		     NAND_MEMORG(1, 4096, 256, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&etron_ecc8_ooblayout,
+				     etron_ecc_get_status)),
+};
+
+static const struct spinand_manufacturer_ops etron_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer etron_spinand_manufacturer = {
+	.id = SPINAND_MFR_ETRON,
+	.name = "Etron",
+	.chips = etron_spinand_table,
+	.nchips = ARRAY_SIZE(etron_spinand_table),
+	.ops = &etron_spinand_manuf_ops,
+};
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index e9561c0a395..8f46c31a427 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -361,6 +361,7 @@ struct spinand_manufacturer {
 extern const struct spinand_manufacturer alliancememory_spinand_manufacturer;
 extern const struct spinand_manufacturer ato_spinand_manufacturer;
 extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
+extern const struct spinand_manufacturer etron_spinand_manufacturer;
 extern const struct spinand_manufacturer fmsh_spinand_manufacturer;
 extern const struct spinand_manufacturer foresee_spinand_manufacturer;
 extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
-- 
2.45.2

