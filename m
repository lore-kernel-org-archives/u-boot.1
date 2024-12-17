Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F56AE7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0CA280219;
	Tue, 17 Dec 2024 09:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="jWEuSQ8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA8EA801CF; Tue, 17 Dec 2024 09:40:09 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57D0B80291
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 818be0b2bc5211efbd192953cf12861f-20241217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=R7hCnC2GCqY/75WMXVIorHo8jikfq68aV7mhu9xDP5A=; 
 b=jWEuSQ8Lt14lEWI6k5AjhGGYYsrY/acUK8JpbGv/SgVvXhBztzYru1xKpsmetbMFEJBzpQAZ434VMNx2S8KXwgt0mCheH9Pstkhs3ZcXWBYDq2ln/Sk+bxTYW+//IFJtnGiwXMi2lGWH9QxGa1b+OEata97uSj0ZRh8bMSbuv0Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45, REQID:44b04f2e-565b-4a24-b4c7-e27601e94e76, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:6493067, CLOUDID:63e3a628-d2eb-4de2-b5c9-495d1bc17256,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
 :nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
 LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 818be0b2bc5211efbd192953cf12861f-20241217
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1728943134; Tue, 17 Dec 2024 16:40:01 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Dec 2024 16:40:00 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Dec 2024 16:39:59 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Tom
 Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, Weijie
 Gao <weijie.gao@mediatek.com>
Subject: [PATCH 09/10] net: mediatek: don't enable GDMA cpu bridge
 unconditionally for NETSYSv3
Date: Tue, 17 Dec 2024 16:39:59 +0800
Message-ID: <fe5b8a88ccb54434e056de09616a34a4a4e671e4.1734406968.git.weijie.gao@mediatek.com>
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

Enable GDMA cpu bridge only when 10Gb interface is enabled for GMAC other
than GMAC0, or when MT7988 internal switch is used.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/net/mtk_eth.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mtk_eth.c b/drivers/net/mtk_eth.c
index d3f29e4a0d0..888e8c1e855 100644
--- a/drivers/net/mtk_eth.c
+++ b/drivers/net/mtk_eth.c
@@ -1762,10 +1762,16 @@ static int mtk_eth_start(struct udevice *dev)
 		if (priv->sw == SW_MT7988 && priv->gmac_id == 0) {
 			mtk_gdma_write(priv, priv->gmac_id, GDMA_IG_CTRL_REG,
 				       GDMA_BRIDGE_TO_CPU);
-		}
 
-		mtk_gdma_write(priv, priv->gmac_id, GDMA_EG_CTRL_REG,
-			       GDMA_CPU_BRIDGE_EN);
+			mtk_gdma_write(priv, priv->gmac_id, GDMA_EG_CTRL_REG,
+				       GDMA_CPU_BRIDGE_EN);
+		} else if ((priv->phy_interface == PHY_INTERFACE_MODE_USXGMII ||
+			    priv->phy_interface == PHY_INTERFACE_MODE_10GBASER ||
+			    priv->phy_interface == PHY_INTERFACE_MODE_XGMII) &&
+			   priv->gmac_id != 0) {
+			mtk_gdma_write(priv, priv->gmac_id, GDMA_EG_CTRL_REG,
+				       GDMA_CPU_BRIDGE_EN);
+		}
 	}
 
 	udelay(500);
-- 
2.34.1

