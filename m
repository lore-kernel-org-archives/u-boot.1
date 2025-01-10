Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C56FE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 08:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C869F8069D;
	Fri, 10 Jan 2025 09:41:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="bJ93g/TY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45B26800C2; Fri, 10 Jan 2025 09:41:32 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E972E80619
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 09:41:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: acaa9254cf2e11efbd192953cf12861f-20250110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=/vNqVhhqb9t4RGKGLiHYkJiZj6zTqdu8LwXtZaEAT+c=; 
 b=bJ93g/TYE06BhD+2Fch+cnLy6y+mLvW+yYzWd8nD75XaY/b9SrLLNlOuLVx7Xb6paZXEYW2oM/YQ1j/jJOOCHqKJkQbvgQXn/AqdPnqi8Ee+J/UzlsoSMoY1BPzrI04a/VbYkHdHpRqtpWRWujY4pJ3q6MU0BEoXpkH83n3woSA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:b4ccbfe0-5384-490e-901e-b8c198906a5f, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:60aa074, CLOUDID:48c74b13-8831-4185-8e40-f83b1917e828,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: acaa9254cf2e11efbd192953cf12861f-20250110
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1689686548; Fri, 10 Jan 2025 16:41:24 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 10 Jan 2025 16:41:23 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 10 Jan 2025 16:41:22 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Tom
 Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 2/3] net: mediatek: add support for MediaTek MT7987 SoC
Date: Fri, 10 Jan 2025 16:41:20 +0800
Message-ID: <f733ae6b33546c7c0386e81befa04fe3a976e1ea.1736498083.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1736498083.git.weijie.gao@mediatek.com>
References: <cover.1736498083.git.weijie.gao@mediatek.com>
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

This patch adds support for MediaTek MT7987.

MT7987 features MediaTek NETSYS v3, similar to MT7988, features three GMACs
which support 2.5Gb HSGMII. One 2.5Gb PHY is also embedded an can be
connected to a dedicated GMAC.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/net/mtk_eth/Kconfig   |  4 ++--
 drivers/net/mtk_eth/mtk_eth.c | 10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mtk_eth/Kconfig b/drivers/net/mtk_eth/Kconfig
index 8d012fb1374..467684749f1 100644
--- a/drivers/net/mtk_eth/Kconfig
+++ b/drivers/net/mtk_eth/Kconfig
@@ -16,7 +16,7 @@ config MTK_ETH_SGMII
 
 config MTK_ETH_XGMII
 	bool
-	default y if TARGET_MT7988
+	default y if TARGET_MT7987 || TARGET_MT7988
 
 config MTK_ETH_SWITCH_MT7530
 	bool "Support for MediaTek MT7530 ethernet switch"
@@ -25,7 +25,7 @@ config MTK_ETH_SWITCH_MT7530
 config MTK_ETH_SWITCH_MT7531
 	bool "Support for MediaTek MT7531 ethernet switch"
 	default y if TARGET_MT7622 || TARGET_MT7629 || TARGET_MT7981 || \
-		     TARGET_MT7986
+		     TARGET_MT7986 || TARGET_MT7987
 
 config MTK_ETH_SWITCH_MT7988
 	bool "Support for MediaTek MT7988 built-in ethernet switch"
diff --git a/drivers/net/mtk_eth/mtk_eth.c b/drivers/net/mtk_eth/mtk_eth.c
index 1e6b30769d1..5d6a42bceb4 100644
--- a/drivers/net/mtk_eth/mtk_eth.c
+++ b/drivers/net/mtk_eth/mtk_eth.c
@@ -1477,6 +1477,15 @@ static const struct mtk_soc_data mt7988_data = {
 	.rxd_size = sizeof(struct mtk_rx_dma_v2),
 };
 
+static const struct mtk_soc_data mt7987_data = {
+	.caps = MT7987_CAPS,
+	.ana_rgc3 = 0x128,
+	.gdma_count = 3,
+	.pdma_base = PDMA_V3_BASE,
+	.txd_size = sizeof(struct mtk_tx_dma_v2),
+	.rxd_size = sizeof(struct mtk_rx_dma_v2),
+};
+
 static const struct mtk_soc_data mt7986_data = {
 	.caps = MT7986_CAPS,
 	.ana_rgc3 = 0x128,
@@ -1531,6 +1540,7 @@ static const struct mtk_soc_data mt7621_data = {
 
 static const struct udevice_id mtk_eth_ids[] = {
 	{ .compatible = "mediatek,mt7988-eth", .data = (ulong)&mt7988_data },
+	{ .compatible = "mediatek,mt7987-eth", .data = (ulong)&mt7987_data },
 	{ .compatible = "mediatek,mt7986-eth", .data = (ulong)&mt7986_data },
 	{ .compatible = "mediatek,mt7981-eth", .data = (ulong)&mt7981_data },
 	{ .compatible = "mediatek,mt7629-eth", .data = (ulong)&mt7629_data },
-- 
2.34.1

