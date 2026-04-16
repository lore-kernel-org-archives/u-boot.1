Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42ADCF8A140
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 08:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5069E84207;
	Thu, 16 Apr 2026 10:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="LNbPBOzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AEB183FC0; Thu, 16 Apr 2026 10:23:16 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D7D084201
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 10:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 80c78b92396d11f19a16598d5ca7f8ec-20260416
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=EYDqoEqN/Ye1QHUztS1BfiblXBdEEf9ZRWDeR7R+K34=; 
 b=LNbPBOzcLqvlai/8XJgAk4j0+rlEcrk6P4q+I4ZlAN+1IYnGO8VF+N/9tDav2tqozkGulpw7ZBmgazxxwMoW4+4kDQEx0b1+rwLCYC2l01vXHIbeC59BzHigTWDWOxPtMt0VA+3UIogn6zmPrr3D+YThgtWVfnFJR0BfERnlUF4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:0dffbdcc-5ce3-4b14-9baa-b61afbe8bee3, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:ca227e8f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 80c78b92396d11f19a16598d5ca7f8ec-20260416
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1918007631; Thu, 16 Apr 2026 16:23:09 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 16 Apr 2026 16:23:08 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 16 Apr 2026 16:23:07 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Macpaul Lin <macpaul.lin@mediatek.com>, Sam Shih
 <sam.shih@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v2 2/3] clk: mediatek: add grandparent variable in
 mtk_find_parent_rate()
Date: Thu, 16 Apr 2026 16:23:05 +0800
Message-ID: <726ccc71593f6c224c13142a0bd4a9f6f0f81445.1776326933.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1776326933.git.weijie.gao@mediatek.com>
References: <cover.1776326933.git.weijie.gao@mediatek.com>
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

From: Sam Shih <sam.shih@mediatek.com>

Add grandparent device variable in mtk_find_parent_rate() to allow
the grandparent device being reused instead of calling
dev_get_parent(priv->parent) multiple times.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 4adec4457b4..f974f0f2432 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -216,11 +216,14 @@ static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
 			parent_dev = clk->dev;
 		else if (dev_get_driver_ops(priv->parent) == &mtk_clk_apmixedsys_ops)
 			parent_dev = priv->parent;
-		else if (dev_get_driver_ops(dev_get_parent(priv->parent)) == &mtk_clk_apmixedsys_ops)
-			parent_dev = dev_get_parent(priv->parent);
-		else
-			return -EINVAL;
+		else {
+			struct udevice *grandparent_dev = dev_get_parent(priv->parent);
 
+			if (dev_get_driver_ops(grandparent_dev) == &mtk_clk_apmixedsys_ops)
+				parent_dev = grandparent_dev;
+			else
+				return -EINVAL;
+		}
 		break;
 	case CLK_PARENT_TOPCKGEN:
 		if (dev_get_driver_ops(clk->dev) == &mtk_clk_topckgen_ops)
-- 
2.45.2

