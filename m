Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80173CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 08:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F6FA83192;
	Wed, 27 Aug 2025 10:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="pXVm61Lo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06F90831B4; Wed, 27 Aug 2025 10:56:01 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5180483189
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 10:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: a1068dfa832311f0bd5779446731db89-20250827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=ftvKDmFF0YzmuXYEQBAnRPE2Fb32txB14CjaE7mlmoU=; 
 b=pXVm61LojWrRQeEdRsNDVLs9NFciJToy85HnjVIEr125rcRHApTKH4onEA6T0uNI7EvWCi2viLJSWhNR0Wy4ug8t79Pre6ZTf7JOuHlMf8JsM5IY+YZLl8lCUzQTSD9LeqpwKuDo+Phc2zOQpwX0R3zonTJ4FOM111F8aUbLdYw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3, REQID:95fe79bc-0fd3-4d95-8250-9f17b03efef9, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-30
X-CID-META: VersionHash:f1326cf, CLOUDID:9671eb44-18c5-4075-a135-4c0afe29f9d6,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
 2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
 V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a1068dfa832311f0bd5779446731db89-20250827
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1801669138; Wed, 27 Aug 2025 16:55:49 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 27 Aug 2025 16:55:48 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 27 Aug 2025 16:55:47 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v2 1/4] net: mediatek: associate PHY device with dts node
 specified by phy-handle
Date: Wed, 27 Aug 2025 16:55:44 +0800
Message-ID: <9d25236d6a63023ba3e0592ab3fac79f54563592.1756283872.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1756283872.git.weijie.gao@mediatek.com>
References: <cover.1756283872.git.weijie.gao@mediatek.com>
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

