Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C119C02188
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 09:18:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0ED080756;
	Fri, 17 Jan 2025 10:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="nhlfG/4w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4F8C806FB; Fri, 17 Jan 2025 10:18:04 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A55980717
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: ef78cc2ed4b311ef99858b75a2457dd9-20250117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=y3XyXy3dvYx30jW5Ob2ZbsRBNueHDgkAr8teWhGRaYA=; 
 b=nhlfG/4wFZve7+EQkK2TN87beSE4pA5MKBfSiheEitBzQQP2rbpNBCMgR3+u0+xTM+7dnu7WDnULtQd4FLcPBzfege7oajXEjVlTREBRGKGvigSP8LEPJFnzEd2fd8GISXY6QFXDQ/vchTvqLV1TjmXUtYojQOdzjwDBtbgmJsI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:092c06a0-8140-44d6-a9b7-8d0d3f6c238c, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:60aa074, CLOUDID:e8073285-0f10-4f52-bb41-91703793d3e4,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ef78cc2ed4b311ef99858b75a2457dd9-20250117
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1231105868; Fri, 17 Jan 2025 17:17:55 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 Jan 2025 17:17:53 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 17 Jan 2025 17:17:53 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, Weijie Gao
 <weijie.gao@mediatek.com>
Subject: [PATCH 05/15] spi: mtk_spim: add support to use DT live tree
Date: Fri, 17 Jan 2025 17:17:51 +0800
Message-ID: <9abc5daadfa91f8265949eeb71c650c10390169a.1737104723.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1737104723.git.weijie.gao@mediatek.com>
References: <cover.1737104723.git.weijie.gao@mediatek.com>
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

Change devfdt_get_addr_ptr to dev_read_addr_ptr to support DT live tree.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/spi/mtk_spim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/mtk_spim.c b/drivers/spi/mtk_spim.c
index b66bcfc4233..cd9b9d305ef 100644
--- a/drivers/spi/mtk_spim.c
+++ b/drivers/spi/mtk_spim.c
@@ -648,7 +648,7 @@ static int mtk_spim_probe(struct udevice *dev)
 	struct mtk_spim_priv *priv = dev_get_priv(dev);
 	int ret;
 
-	priv->base = devfdt_get_addr_ptr(dev);
+	priv->base = dev_read_addr_ptr(dev);
 	if (!priv->base)
 		return -EINVAL;
 
-- 
2.34.1

