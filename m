Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B468AC53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:18:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 791F060632;
	Mon, 27 Jul 2026 08:18:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2XmGTTeJlFj6; Mon, 27 Jul 2026 08:18:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 994D360671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785140299;
	bh=i2VvPL6tutTe8CzDPBPPDXTvoLmtEuyHP6qjQlwXZ3I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jyvFZsHu5t6t+0hBEFmOfz08rgvHmAokm+LBNZqJq+733DLhAKVq8vYfPziLCCZyz
	 SEl4N3uX2+AVOnC1Vq7dChvm3OPjS+DkPUcs9tAkfDIw+G+UeRYRDpEcEpXc4+TISj
	 i04JfvFwTUkxssSIKZw3/jgoh+yIxC5EQdIudDiFe9eOXOWKT7ifMpaJlwFz6wQVlY
	 ZCDAQyNd1aY/o6ox7Eq2n06MhznYRq2y+9z1igXE+fh5ludAOWW1JS4xMeZ6MNXU7q
	 EkWYlioPEWjAi4Z98/j/p321cTNQqJ+4gOSDZoiTWzst7OUqHRb/GXIG+CnYb1mlBn
	 OssSPdmyhmdYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 994D360671;
	Mon, 27 Jul 2026 08:18:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AE1C490
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:18:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8CF4E60639
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:18:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Krg5-bQVuPO6 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:18:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=210.61.82.184;
 helo=mailgw02.mediatek.com; envelope-from=weijie.gao@mediatek.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4BB81605D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BB81605D8
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4BB81605D8
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:18:13 +0000 (UTC)
X-UUID: 9290aae2899111f18dc8c9802ae25ab1-20260727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18, REQID:a5d2a463-0133-4b5c-b9ce-e9e489b72f88, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:8a735a6, CLOUDID:0ab1c5a8-c4f2-4725-a8c8-10915fbf3703,
 B
 ulkID:nil,BulkQuantity:0,SF:81|82|102|136|836|865|888|898,TC:-5,Content:0|
 15|50|99,EDM:-3|-100,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,
 COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9290aae2899111f18dc8c9802ae25ab1-20260727
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1428350219; Mon, 27 Jul 2026 16:02:54 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 27 Jul 2026 16:02:53 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 27 Jul 2026 16:02:52 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.u-boot-project.org>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, Takahiro Kuwano
 <takahiro.kuwano@infineon.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Jeffrey Yu <jeyu@issi.com>, Christoph Reiter <christoph.reiter@evk.biz>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Shiji Yang
 <yangshiji66@outlook.com>, Bernhard Messerklinger
 <bernhard.messerklinger@at.abb.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v8 2/7] mtd: spi-nor-ids: Add support for ESMT/EON
 EN25QX128A/EN25QH256/EN25QX256A
Date: Mon, 27 Jul 2026 16:02:26 +0800
Message-ID: <2e202a6d4ec8462538a57fce4fc6634fc3b230a5.1785138294.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1785138294.git.weijie.gao@mediatek.com>
References: <cover.1785138294.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=mediatek.com; s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=i2VvPL6tutTe8CzDPBPPDXTvoLmtEuyHP6qjQlwXZ3I=; 
 b=RMjneKycaBaXK7zvCujgutq43qeOgW/C+gy6dhL6ms52zCfELwO8AT05W3f8mhrVZoCn6CfGuuN8RDdT7EB/f6CLdlyHBalZfFo65J0ToZJTMdVCs0a5deszD4WY2C9MbUUu5bz0bFdP0H89h0gGgtXlLT5PLlY7nN3sGcU/n6k=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.a=rsa-sha256 header.s=dk header.b=RMjneKyc
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

EN25QX128A/EN25QX256A are 128Mb/256Mb flash devices with Quad interface at
max 104MHz clock rate.
EN25QH256 is 256Mb flash device with Quad interface at max 50MHz clock rate.
Both flashes supports 2.7-3.6V voltage range. However it only supports 1-4-4
quad read which is not supported by U-Boot now.

These flashes are tested on MediaTek's filogic platform.

Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25QX128A(2V).pdf
Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25QH256A(2R).pdf
Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v7-v8: not changed
v6: removed SPI_NOR_QUAD_READ from en25qh256
v5: removed locking related flags
v2-v4: updated commit message
---
 drivers/mtd/spi/spi-nor-core.c | 1 +
 drivers/mtd/spi/spi-nor-ids.c  | 3 +++
 include/linux/mtd/spi-nor.h    | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 937d79af64e..e4f78e740ba 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -758,6 +758,7 @@ static int set_4byte(struct spi_nor *nor, const struct flash_info *info,
 	case SNOR_MFR_ISSI:
 	case SNOR_MFR_MACRONIX:
 	case SNOR_MFR_WINBOND:
+	case SNOR_MFR_EON:
 		if (need_wren)
 			write_enable(nor);
 
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index cf51f0ffa0b..2e4f63c0c7a 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -95,6 +95,9 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("en25q64",    0x1c3017, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_DUAL_READ) },
 	{ INFO("en25q128b",  0x1c3018, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_DUAL_READ) },
 	{ INFO("en25qh128",  0x1c7018, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_DUAL_READ) },
+	{ INFO("en25qx128a", 0x1c7118, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("en25qh256",  0x1c7019, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ) },
+	{ INFO("en25qx256a", 0x1c7119, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("en25s64",    0x1c3817, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_DUAL_READ) },
 #endif
 #ifdef CONFIG_SPI_FRAM_FUJITSU
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 4eef4ab0488..02fa72fb401 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -33,6 +33,7 @@
 #define SNOR_MFR_SST		CFI_MFR_SST
 #define SNOR_MFR_WINBOND	0xef /* Also used by some Spansion */
 #define SNOR_MFR_CYPRESS	0x34
+#define SNOR_MFR_EON		CFI_MFR_EON
 
 /*
  * Note on opcode nomenclature: some opcodes have a format like
-- 
2.45.2

