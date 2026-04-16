Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F43F8A140
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 08:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D3BC84206;
	Thu, 16 Apr 2026 10:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="sWZFILyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1C1183FC0; Thu, 16 Apr 2026 10:23:22 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50D1D8421E
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 10:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 83e8d3bc396d11f19a16598d5ca7f8ec-20260416
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=q3JJQRyjGZXZhUrERJx6skvKzdEfjFY8yoxQF35nMzw=; 
 b=sWZFILyuq/x5tUPfhZ1DY/S2zQzHBOMx9NNnnkVGWDOvnrqmFlBL3WMWZl0EJGxV1q7Jfl/IDKfIUkB12joXSEIWy4NeWMWvUqQdTpU0HmdWxJJjliiKwrdYRsY+oS8BV5lCod8ntdjekcoFtnOMyUpLQAmxo0kiabueqHyk/ks=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:23301851-7d77-4c45-97ae-c6aca34e4443, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:1f0aef24-cb5c-4236-a89a-9a7fb20c9bc4,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 83e8d3bc396d11f19a16598d5ca7f8ec-20260416
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1881001460; Thu, 16 Apr 2026 16:23:15 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 16 Apr 2026 16:23:13 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 16 Apr 2026 16:23:13 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Macpaul Lin <macpaul.lin@mediatek.com>, Sam Shih
 <sam.shih@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v2 3/3] clk: mediatek: fix parent rate lookup for fixed PLL
 clocks
Date: Thu, 16 Apr 2026 16:23:10 +0800
Message-ID: <923e50db696d910803828cd26b0ca0fbbfe11570.1776326933.git.weijie.gao@mediatek.com>
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

The refactoring in commit 00d0ff7f81bf ("clk: mediatek: refactor parent
rate lookup functions") introduced a regression where fixed PLL clocks
using mtk_clk_fixed_pll_ops are not properly recognized as valid parents
in the CLK_PARENT_APMIXED case.

Fixed PLL clocks are implemented using mtk_clk_fixed_pll_ops instead of
mtk_clk_apmixedsys_ops, but they can also serve as parent clocks in the
APMIXED domain. The parent lookup function needs to check for both
driver ops to properly resolve the parent clock device.

Add mtk_clk_fixed_pll_ops checks alongside mtk_clk_apmixedsys_ops checks
in mtk_find_parent_rate() to restore support for fixed PLL parent clocks.

Also refactor the grandparent lookup code to extract the repeated
dev_get_parent(priv->parent) call into a local variable to keep lines
under 100 characters and pass checkpatch validation.

Fixes: 00d0ff7f81bf ("clk: mediatek: refactor parent rate lookup functions")
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index f974f0f2432..d209bc5eb47 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -212,14 +212,17 @@ static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
 	switch (flags & CLK_PARENT_MASK) {
 	case CLK_PARENT_APMIXED:
 		/* APMIXEDSYS can be parent or grandparent. */
-		if (dev_get_driver_ops(clk->dev) == &mtk_clk_apmixedsys_ops)
+		if (dev_get_driver_ops(clk->dev) == &mtk_clk_apmixedsys_ops ||
+		    dev_get_driver_ops(clk->dev) == &mtk_clk_fixed_pll_ops) {
 			parent_dev = clk->dev;
-		else if (dev_get_driver_ops(priv->parent) == &mtk_clk_apmixedsys_ops)
+		} else if (dev_get_driver_ops(priv->parent) == &mtk_clk_apmixedsys_ops ||
+			dev_get_driver_ops(priv->parent) == &mtk_clk_fixed_pll_ops) {
 			parent_dev = priv->parent;
-		else {
+		} else {
 			struct udevice *grandparent_dev = dev_get_parent(priv->parent);
 
-			if (dev_get_driver_ops(grandparent_dev) == &mtk_clk_apmixedsys_ops)
+			if (dev_get_driver_ops(grandparent_dev) == &mtk_clk_apmixedsys_ops ||
+			    dev_get_driver_ops(grandparent_dev) == &mtk_clk_fixed_pll_ops)
 				parent_dev = grandparent_dev;
 			else
 				return -EINVAL;
-- 
2.45.2

