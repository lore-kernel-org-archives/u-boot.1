Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89449E7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0867F80224;
	Tue, 17 Dec 2024 09:40:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="CBUrWoYD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FE7180282; Tue, 17 Dec 2024 09:40:15 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F402F801CF
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:40:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 83c87d36bc5211efbd192953cf12861f-20241217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=3PJ2qjSgUWrk5Rm9azfN9sal1cDW2uERdtWmoiuh+Y4=; 
 b=CBUrWoYDkAVqPkTSG4HCPO8DGIdrm61DTHc7w7JROjMbPRbTzVLfu3e5R90Vl76kpUZmTzSkTKg8lz6qFJTEN6omQMiLZXdhXBZjo1YpWkVKD56HCHqNXOZq13zj8zcpfCp8eQGPNF9Kom0cGIKXM73N+dULWq4ibLinM8B6wV0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45, REQID:d5bc64a1-2f58-4dd6-9a4c-c341098c57aa, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:6493067, CLOUDID:eee3a628-d2eb-4de2-b5c9-495d1bc17256,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
 :nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
 LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 83c87d36bc5211efbd192953cf12861f-20241217
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 501278132; Tue, 17 Dec 2024 16:40:05 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Dec 2024 16:40:04 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Dec 2024 16:40:04 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Tom
 Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, Weijie
 Gao <weijie.gao@mediatek.com>
Subject: [PATCH 10/10] net: mediatek: fix usability with wget command
Date: Tue, 17 Dec 2024 16:40:03 +0800
Message-ID: <29575b5c213b966235ba1a21da9cf40cd6d6de2d.1734406968.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1734406967.git.weijie.gao@mediatek.com>
References: <cover.1734406967.git.weijie.gao@mediatek.com>
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

The wget command currently cannot work correctly with mtk_eth driver.
This patch fixed this by increase DMA ring size and invalidate ring data
after use.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/net/mtk_eth.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mtk_eth.c b/drivers/net/mtk_eth.c
index 888e8c1e855..454caa3cd3a 100644
--- a/drivers/net/mtk_eth.c
+++ b/drivers/net/mtk_eth.c
@@ -29,8 +29,8 @@
 
 #include "mtk_eth.h"
 
-#define NUM_TX_DESC		24
-#define NUM_RX_DESC		24
+#define NUM_TX_DESC		32
+#define NUM_RX_DESC		32
 #define TX_TOTAL_BUF_SIZE	(NUM_TX_DESC * PKTSIZE_ALIGN)
 #define RX_TOTAL_BUF_SIZE	(NUM_RX_DESC * PKTSIZE_ALIGN)
 #define TOTAL_PKT_BUF_SIZE	(TX_TOTAL_BUF_SIZE + RX_TOTAL_BUF_SIZE)
@@ -1897,6 +1897,9 @@ static int mtk_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
 
 	rxd = priv->rx_ring_noc + idx * priv->soc->rxd_size;
 
+	invalidate_dcache_range((ulong)rxd->rxd1,
+				(ulong)rxd->rxd1 + PKTSIZE_ALIGN);
+
 	if (MTK_HAS_CAPS(priv->soc->caps, MTK_NETSYS_V2) ||
 	    MTK_HAS_CAPS(priv->soc->caps, MTK_NETSYS_V3))
 		rxd->rxd2 = PDMA_V2_RXD2_PLEN0_SET(PKTSIZE_ALIGN);
-- 
2.34.1

