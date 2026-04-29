Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F4FFF8864
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 08:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42DC2846F5;
	Wed, 29 Apr 2026 10:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="RYGjWCc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2248A846FA; Wed, 29 Apr 2026 10:13:35 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A850846F4
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 10:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 4b58a4c443a311f19a16598d5ca7f8ec-20260429
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=Kv8+xQbk9ysEOiGJFXTH5uHatPQaodnv7t9asiw1L8g=; 
 b=RYGjWCc1HfsEsSv3HObUUB8GoG+CJE96+4GhaYc+NXyiLaurP/gwU/6XC4knXg4vD9vWguIoEqtC6OVnxCJ+1VBCqEdOrJxLdkJGUDIwzziAGkvQakG9Et6BA2l74eG7PATmEwhiKFa2m75z0oXTQYfcIXDW5ayElVPcpyVpWiA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:0f26c0e5-5dc8-4d9c-b147-2990dfd25333, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:e7bac3a, CLOUDID:c63cda44-8360-4d24-8500-9b9380fa4b0d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
 15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OS
 I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4b58a4c443a311f19a16598d5ca7f8ec-20260429
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1186633032; Wed, 29 Apr 2026 16:13:24 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 29 Apr 2026 16:13:23 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 29 Apr 2026 16:13:22 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Tianling Shen <cnsztl@gmail.com>, Weijie Gao
 <weijie.gao@mediatek.com>
Subject: [PATCH] mtd: spinand: add support for FudanMicro FM25S01BI3
Date: Wed, 29 Apr 2026 16:13:19 +0800
Message-ID: <20260429081319.151702-1-weijie.gao@mediatek.com>
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

Add support for FudanMicro FM25S01BI3 SPI-NAND.

This driver is ported from linux kernel with fix:
This SPI-NAND does not support 1S-4S-4S and 1S-2S-2S modes.
https://lore.kernel.org/linux-mtd/20251127195900.2562-1-csharper2005@gmail.com/

Datasheet link:
https://www.fmsh.com/nvm/FM25S01BI3_ds_eng.pdf

Tested on MediaTek's filogic platform reference board.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/mtd/nand/spi/fmsh.c | 77 +++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/mtd/nand/spi/fmsh.c b/drivers/mtd/nand/spi/fmsh.c
index 80837b7dd42..6740f30689f 100644
--- a/drivers/mtd/nand/spi/fmsh.c
+++ b/drivers/mtd/nand/spi/fmsh.c
@@ -11,6 +11,13 @@
 #endif
 #include <linux/mtd/spinand.h>
 
+#define FM25S01BI3_STATUS_ECC_MASK		(7 << 4)
+	#define FM25S01BI3_STATUS_ECC_NO_BITFLIPS	(0 << 4)
+	#define FM25S01BI3_STATUS_ECC_1_3_BITFLIPS	(1 << 4)
+	#define FM25S01BI3_STATUS_ECC_UNCOR_ERROR	(2 << 4)
+	#define FM25S01BI3_STATUS_ECC_4_6_BITFLIPS	(3 << 4)
+	#define FM25S01BI3_STATUS_ECC_7_8_BITFLIPS	(5 << 4)
+
 #define SPINAND_MFR_FMSH		0xA1
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
@@ -21,6 +28,12 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
+static SPINAND_OP_VARIANTS(fm25s01bi3_read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
+
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
@@ -47,11 +60,65 @@ static int fm25s01a_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
+static int fm25s01bi3_ecc_get_status(struct spinand_device *spinand, u8 status)
+{
+	switch (status & FM25S01BI3_STATUS_ECC_MASK) {
+	case FM25S01BI3_STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case FM25S01BI3_STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	case FM25S01BI3_STATUS_ECC_1_3_BITFLIPS:
+		return 3;
+
+	case FM25S01BI3_STATUS_ECC_4_6_BITFLIPS:
+		return 6;
+
+	case FM25S01BI3_STATUS_ECC_7_8_BITFLIPS:
+		return 8;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int fm25s01bi3_ooblayout_ecc(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	region->offset = 64;
+	region->length = 64;
+
+	return 0;
+}
+
+static int fm25s01bi3_ooblayout_free(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = (16 * section) + 4;
+	region->length = 12;
+
+	return 0;
+}
+
 static const struct mtd_ooblayout_ops fm25s01a_ooblayout = {
 	.ecc = fm25s01a_ooblayout_ecc,
 	.rfree = fm25s01a_ooblayout_free,
 };
 
+static const struct mtd_ooblayout_ops fm25s01bi3_ooblayout = {
+	.ecc = fm25s01bi3_ooblayout_ecc,
+	.rfree = fm25s01bi3_ooblayout_free,
+};
+
 static const struct spinand_info fmsh_spinand_table[] = {
 	SPINAND_INFO("FM25S01A",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xE4),
@@ -62,6 +129,16 @@ static const struct spinand_info fmsh_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&fm25s01a_ooblayout, NULL)),
+	SPINAND_INFO("FM25S01BI3",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xD4),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&fm25s01bi3_read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&fm25s01bi3_ooblayout,
+				     fm25s01bi3_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops fmsh_spinand_manuf_ops = {
-- 
2.45.2

