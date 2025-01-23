Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE47C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 08:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EE1D80586;
	Thu, 23 Jan 2025 09:55:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="oApYSTAK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB2908076E; Thu, 23 Jan 2025 09:55:11 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 934DF80586
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 09:55:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: bafb3cbcd96711ef99858b75a2457dd9-20250123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=TEgQcPM5PJ2qF/MFpMhZnICXYbZcoBiFWnJWnVrGPmk=; 
 b=oApYSTAKlti+q0mBLwqYge1n5BBQdV9Qn4IfGt6N/9hkCXcP4iWO/bcETfoSzL71iomessOhL5yHbCShJHLtAPy501qd3NIKwcSAgBqYzcvH01n4V3VJ+DbM8jO4B4fpUPRdH2DSooPoYFunkrzFbzHp7dt5hRcaE+0jWBesGMA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:1f555c8e-6dd0-4836-b4f4-d51f4da5239b, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:60aa074, CLOUDID:2609affe-c190-4cfe-938d-595d7f10e0dc,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bafb3cbcd96711ef99858b75a2457dd9-20250123
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1485735817; Thu, 23 Jan 2025 16:55:01 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 23 Jan 2025 16:55:00 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 23 Jan 2025 16:54:59 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 3/5] mmc: mediatek: add support for MediaTek MT7987 SoCs
Date: Thu, 23 Jan 2025 16:54:56 +0800
Message-ID: <42359808da899dcd3ac34daa7fa5a5bad4fca467.1737621362.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1737621362.git.weijie.gao@mediatek.com>
References: <cover.1737621362.git.weijie.gao@mediatek.com>
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

This patch adds eMMC/SD support for MT7987 SoC

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/mmc/mtk-sd.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
index d676cf9e314..2bc700b0d05 100644
--- a/drivers/mmc/mtk-sd.c
+++ b/drivers/mmc/mtk-sd.c
@@ -329,6 +329,7 @@ struct msdc_compatible {
 	u8 clk_div_bits;
 	bool pad_tune0;
 	bool async_fifo;
+	bool async_fifo_crcsts;
 	bool data_tune;
 	bool busy_check;
 	bool stop_clk_fix;
@@ -1553,8 +1554,12 @@ static void msdc_init_hw(struct msdc_host *host)
 		/* use async fifo to avoid tune internal delay */
 		clrbits_le32(&host->base->patch_bit2,
 			     MSDC_PB2_CFGRESP);
-		clrbits_le32(&host->base->patch_bit2,
-			     MSDC_PB2_CFGCRCSTS);
+		if (host->dev_comp->async_fifo_crcsts)
+			setbits_le32(&host->base->patch_bit2,
+				     MSDC_PB2_CFGCRCSTS);
+		else
+			clrbits_le32(&host->base->patch_bit2,
+				     MSDC_PB2_CFGCRCSTS);
 	}
 
 	if (host->dev_comp->data_tune) {
@@ -1844,6 +1849,17 @@ static const struct msdc_compatible mt7986_compat = {
 	.enhance_rx = true,
 };
 
+static const struct msdc_compatible mt7987_compat = {
+	.clk_div_bits = 12,
+	.pad_tune0 = true,
+	.async_fifo = true,
+	.async_fifo_crcsts = true,
+	.data_tune = true,
+	.busy_check = true,
+	.stop_clk_fix = true,
+	.enhance_rx = true,
+};
+
 static const struct msdc_compatible mt7981_compat = {
 	.clk_div_bits = 12,
 	.pad_tune0 = true,
@@ -1886,6 +1902,7 @@ static const struct udevice_id msdc_ids[] = {
 	{ .compatible = "mediatek,mt7622-mmc", .data = (ulong)&mt7622_compat },
 	{ .compatible = "mediatek,mt7623-mmc", .data = (ulong)&mt7623_compat },
 	{ .compatible = "mediatek,mt7986-mmc", .data = (ulong)&mt7986_compat },
+	{ .compatible = "mediatek,mt7987-mmc", .data = (ulong)&mt7987_compat },
 	{ .compatible = "mediatek,mt7981-mmc", .data = (ulong)&mt7981_compat },
 	{ .compatible = "mediatek,mt8512-mmc", .data = (ulong)&mt8512_compat },
 	{ .compatible = "mediatek,mt8516-mmc", .data = (ulong)&mt8516_compat },
-- 
2.34.1

