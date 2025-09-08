Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C6CCA1013
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 08:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFBC8809A5;
	Mon,  8 Sep 2025 10:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="oPNT/mV0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FE39800B6; Mon,  8 Sep 2025 10:34:24 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D985F83106
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 10:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 9c1db2408c8e11f0bd5779446731db89-20250908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=l0ZBuJ6GTP6i/hclKDVysvtXnLzFIb5MQhwgJo2yCFg=; 
 b=oPNT/mV0hL5sIreNzDmNmaR2tzdmhTul4RSyuPN4JrFMUbAHmk5b+eFdY1Hbb0xEQwkXat8dMzxdP4o27oLsXn+Xfwl+knZ3Gf/h7shaDg2wLUPzLyYjxIA2b7XgGiOm4hpkd4zziVBPApib4zNVSvcBDy0Y4ORgw6BVjCoBsf8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3, REQID:bc80b11b-f099-45b2-9a15-fd8a4693ef19, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:f1326cf, CLOUDID:bfdc8c84-5317-4626-9d82-238d715c253f,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
 -3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
 AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9c1db2408c8e11f0bd5779446731db89-20250908
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 773542202; Mon, 08 Sep 2025 16:34:18 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 8 Sep 2025 16:34:15 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 8 Sep 2025 16:34:15 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v4 3/5] net: mediatek: associate PHY device with dts node
 specified by phy-handle
Date: Mon, 8 Sep 2025 16:34:13 +0800
Message-ID: <628bc8a74542324e678119174295cf9e2efa8d5a.1757315849.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1757315849.git.weijie.gao@mediatek.com>
References: <cover.1757315849.git.weijie.gao@mediatek.com>
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

Associate PHY device with its device node specified by phy-handle
property. This makes it possible for PHY drivers to read dedicated
information to configure the PHY device.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
Changes in v4: none
Changes in v3: none
Changes in v2: none
---
 drivers/net/mtk_eth/mtk_eth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/mtk_eth/mtk_eth.c b/drivers/net/mtk_eth/mtk_eth.c
index b172838ba3a..a35754ccd1f 100644
--- a/drivers/net/mtk_eth/mtk_eth.c
+++ b/drivers/net/mtk_eth/mtk_eth.c
@@ -100,6 +100,7 @@ struct mtk_eth_priv {
 	bool pn_swap;
 
 	struct phy_device *phydev;
+	ofnode phy_node;
 	int phy_interface;
 	int phy_addr;
 
@@ -572,6 +573,7 @@ static int mtk_phy_probe(struct udevice *dev)
 	if (!phydev)
 		return -ENODEV;
 
+	phydev->node = priv->phy_node;
 	phydev->supported &= PHY_GBIT_FEATURES;
 	phydev->advertising = phydev->supported;
 
@@ -1458,6 +1460,8 @@ static int mtk_eth_of_to_plat(struct udevice *dev)
 			return ret;
 		}
 
+		priv->phy_node = args.node;
+
 		priv->phy_addr = ofnode_read_s32_default(args.node, "reg", -1);
 		if (priv->phy_addr < 0) {
 			printf("error: phy address is not specified\n");
-- 
2.34.1

