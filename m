Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885D9F36B97
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 02:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1898B8412A;
	Fri, 10 Apr 2026 04:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="QJJHBxUT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E723184181; Fri, 10 Apr 2026 04:13:46 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35DC784154
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 04:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mtk15814@mediatek.com
X-UUID: e2cf950e348211f19a16598d5ca7f8ec-20260410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=o9HNCRBRTU0RJBY9leCTlRpgPpb094sWNZS1u+2qORM=; 
 b=QJJHBxUTpVmCpQmeOZW0M33m6NOyGrkqyBSHZcPMrPxsqXyDGlBkN1nMOt09iHqFOf/9KtAx/ZDmJd2CkiwuABJid0zNfzaoo96n4W0D9apkATilvX3jeHe7PGYYJkycnCMLAcfpDaKoDjq8OIJ+n3JO0mkvaGiTnCyWiKQG6ts=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:7424b1e3-c719-4f7e-aa67-b23265e37e89, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:0473b0d5-060f-4ecc-9ee0-121eeeb4a682,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e2cf950e348211f19a16598d5ca7f8ec-20260410
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <mtk15814@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1555690972; Fri, 10 Apr 2026 10:13:38 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 10 Apr 2026 10:13:36 +0800
Received: from mediatek.com (10.233.130.16) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Fri, 10 Apr 2026 10:13:36 +0800
Received: by mediatek.com (Postfix, from userid 10015814)
 id B734D200C6; Fri, 10 Apr 2026 10:13:36 +0800 (CST)
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>, David Lechner
 <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, Sam Shih
 <sam.shih@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 2/2] clk: mediatek: fix parent rate lookup for fixed PLL clocks
Date: Fri, 10 Apr 2026 10:13:34 +0800
Message-ID: <91c2295c6677a94ea34089a52a93487d8ff7caca.1775786729.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <fc7c50ebff2932b5f0a237c3fc492aefba3a0292.1775786729.git.weijie.gao@mediatek.com>
References: <fc7c50ebff2932b5f0a237c3fc492aefba3a0292.1775786729.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/clk/mediatek/clk-mtk.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 4adec4457b4..26db60dea7f 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -207,20 +207,26 @@ static ulong mtk_clk_find_parent_rate(struct clk *clk, int id,
 static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
 				  const int parent, u16 flags)
 {
+	struct udevice *grandparent_dev;
 	struct udevice *parent_dev;
 
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
-		else if (dev_get_driver_ops(dev_get_parent(priv->parent)) == &mtk_clk_apmixedsys_ops)
-			parent_dev = dev_get_parent(priv->parent);
-		else
-			return -EINVAL;
-
+		} else {
+			grandparent_dev = dev_get_parent(priv->parent);
+			if (dev_get_driver_ops(grandparent_dev) == &mtk_clk_apmixedsys_ops ||
+			    dev_get_driver_ops(grandparent_dev) == &mtk_clk_fixed_pll_ops)
+				parent_dev = grandparent_dev;
+			else
+				return -EINVAL;
+		}
 		break;
 	case CLK_PARENT_TOPCKGEN:
 		if (dev_get_driver_ops(clk->dev) == &mtk_clk_topckgen_ops)
-- 
2.45.2

