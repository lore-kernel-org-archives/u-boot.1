Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE745CD5BB8
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 03:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 311D7846C0;
	Mon, 25 May 2026 05:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="JKKvDFE4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF9A6846A7; Mon, 25 May 2026 05:18:46 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 530B8846AA
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 05:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 6b3ce46857e811f1b1788b6acf885367-20260525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=R43pDfLnpNKykHKZhjh/0Yrfj0ZPi/J9uoMUHJPnLao=; 
 b=JKKvDFE4fCBdYTZoml6sJs/d8gT5Km7/gFOaU7cgGtD2SyPyq/X+VfW+94eMsZS63S/Y26Q+SC/XtHIbx2BdYL8qNOc2WqO95o5oBLbZP3NS//G5ZnvMPt9pKSc/ytrkUVaLm9UOC1vFhsRqVaeEb57nXQTFsDPVfed96F55jp4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15, REQID:7d1d39a7-65ba-44ad-977c-6177409380ab, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e276073, CLOUDID:780d5b22-bef7-463f-902c-5f40f7404c33,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,CO
 L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6b3ce46857e811f1b1788b6acf885367-20260525
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 308800508; Mon, 25 May 2026 11:18:36 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 25 May 2026 11:18:35 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 25 May 2026 11:18:34 +0800
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
Subject: [PATCH v4 1/7] mtd: spi-nor-ids: Correct flash flags for ESMT/EON
 flashes
Date: Mon, 25 May 2026 11:18:34 +0800
Message-ID: <01d87f686b4e3592814ea624a1f70ec89ccfdede.1779678003.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1779678003.git.weijie.gao@mediatek.com>
References: <cover.1779678003.git.weijie.gao@mediatek.com>
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

All currently supported ESMT/EON flashes supports 4KB sector and dual/quad
read.

Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25Q80B.pdf
Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25QH128A%20(2TC).pdf
Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25S64A(2SC).pdf
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v3-v4: updated commit message
v2: not changed
---
 drivers/mtd/spi/spi-nor-ids.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index c0fa98424aa..7d96adab4fd 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -90,12 +90,12 @@ const struct flash_info spi_nor_ids[] = {
 #endif
 #ifdef CONFIG_SPI_FLASH_EON		/* EON */
 	/* EON -- en25xxx */
-	{ INFO("en25q80b",   0x1c3014, 0, 64 * 1024,   16, SECT_4K) },
-	{ INFO("en25q32b",   0x1c3016, 0, 64 * 1024,   64, 0) },
-	{ INFO("en25q64",    0x1c3017, 0, 64 * 1024,  128, SECT_4K) },
-	{ INFO("en25q128b",  0x1c3018, 0, 64 * 1024,  256, 0) },
-	{ INFO("en25qh128",  0x1c7018, 0, 64 * 1024,  256, 0) },
-	{ INFO("en25s64",    0x1c3817, 0, 64 * 1024,  128, SECT_4K) },
+	{ INFO("en25q80b",   0x1c3014, 0, 64 * 1024,   16, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("en25q32b",   0x1c3016, 0, 64 * 1024,   64, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("en25q64",    0x1c3017, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("en25q128b",  0x1c3018, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("en25qh128",  0x1c7018, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("en25s64",    0x1c3817, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 #endif
 #ifdef CONFIG_SPI_FRAM_FUJITSU
 	/* Fujitsu MB85RS256TY */
-- 
2.45.2

