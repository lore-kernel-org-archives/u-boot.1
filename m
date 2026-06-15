Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C681DCD98D6
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 07:34:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57A78848A2;
	Mon, 15 Jun 2026 09:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="LEft+2uf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A99384874; Mon, 15 Jun 2026 09:33:59 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D759084878
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 8b915fb4688c11f18dc8c9802ae25ab1-20260615
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=0LDy07ZtPj35lMjAxDUx+kMfLJYMdeYt1hsNQJHLUm4=; 
 b=LEft+2ufVJ6r0a3Gc3Ebtwbda8burNJwqzoFUkaRhQJuZ1ZFqtK1uML75iBtZkGbgSpGC8YHeDWPMExWr13Xyg3efKNqMsDujQpmdSuPiZF7/qsTXhN13J/g+7y84/kUyF9sds8pg/HnBz2iF1hO4p6S5FbbZmj6ec/3OGZfV28=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15, REQID:39dc9945-1c82-464b-b1ee-f231010a38d3, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:e276073, CLOUDID:ab599254-902f-47df-afe3-f34f8d753c22,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|836|865|888|898,TC:-5,
 Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8b915fb4688c11f18dc8c9802ae25ab1-20260615
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1260449067; Mon, 15 Jun 2026 15:33:47 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Jun 2026 15:33:45 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 15 Jun 2026 15:33:44 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, Takahiro Kuwano
 <takahiro.kuwano@infineon.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Jeffrey Yu <jeyu@issi.com>, Christoph Reiter <christoph.reiter@evk.biz>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Shiji Yang
 <yangshiji66@outlook.com>, Bernhard Messerklinger
 <bernhard.messerklinger@at.abb.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v6 2/7] mtd: spi-nor-ids: Add support for ESMT/EON
 EN25QX128A/EN25QH256/EN25QX256A
Date: Mon, 15 Jun 2026 15:33:43 +0800
Message-ID: <a6718c9f3a587f36302114ccc6251b486b97960b.1781508530.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1781508530.git.weijie.gao@mediatek.com>
References: <cover.1781508530.git.weijie.gao@mediatek.com>
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
index 0dacb4abdbc..08f7535adf2 100644
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

