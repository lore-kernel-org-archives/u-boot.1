Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B47C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 08:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0496981F66;
	Tue,  6 May 2025 10:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="muLklpBW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1690982076; Tue,  6 May 2025 10:13:19 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C11C880F03
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 10:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: f21105ac2a5111f0813e4fe1310efc19-20250506
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=oE07k5pNGPtWiDi601noYZ76aK3ywjkEo8UivPIb5z8=; 
 b=muLklpBWocyNQ/rfaZYASz5gbMxRRKZxI3CVZV0GhJNnyIWcUaBsbWM14Bvf63OInYpuSjmyb6hIL3rYlinC1uAOgyH1v0U7s24ZHHWugCvkC/N0MNMWR6eG3vhx4lBua5qtpjkyB7Rw8Vms4f7sZVJ0KoLrm0ZbmyNchQpQI3Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1, REQID:8281787e-e1c4-4146-9d88-52eaf193a094, IP:0,
 UR
 L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:-5
X-CID-META: VersionHash:0ef645f, CLOUDID:d1affa95-efc9-47bf-92a2-b4a9ca59362d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f21105ac2a5111f0813e4fe1310efc19-20250506
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 661937418; Tue, 06 May 2025 16:13:09 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 6 May 2025 16:13:07 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 6 May 2025 16:13:07 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom Rini
 <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, Weijie Gao
 <weijie.gao@mediatek.com>, Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH] clk: mediatek: add dummy clk enable/disable ops for
 apmixedsys clocks
Date: Tue, 6 May 2025 16:12:20 +0800
Message-ID: <20250506081220.29918-1-weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
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

Starting from commit ac30d90f336 (clk: Ensure the parent clocks are enabled
while reparenting), MediaTek filogic platforms will crash on booting when
initializing mmc devices.

The root cause is that to simplify the code, we reused the topckgen ops for
apmixedsys clocks as they share the get_rate with topckgen clocks while the
clk enable/disable ops are not available for apmixedsys clocks.

Now that a clock will be enabled first before reparenting, we have to add
dummy enable/disable ops for apmixedsys to avoid unexpected behavior when
apmixedsys clocks are the parent clock of the to-be-reparenting clocks.

Fixes: 40746bf429d (clk: mediatek: add clock driver support for MediaTek MT7981 SoC)
Fixes: 37d5a9a29dc (clk: mediatek: add clock driver support for MediaTek MT7986 SoC)
Fixes: ece4e5804f5 (clk: mediatek: add clock driver support for MediaTek MT7987 SoC)
Fixes: 421436981a2 (clk: mediatek: add clock driver support for MediaTek MT7988 SoC)
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/clk/mediatek/clk-mt7981.c |  2 +-
 drivers/clk/mediatek/clk-mt7986.c |  2 +-
 drivers/clk/mediatek/clk-mt7987.c |  2 +-
 drivers/clk/mediatek/clk-mt7988.c |  2 +-
 drivers/clk/mediatek/clk-mtk.c    | 11 +++++++++++
 drivers/clk/mediatek/clk-mtk.h    |  1 +
 6 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 60814652322..6130c93d5e6 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -566,7 +566,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.of_match = mt7981_fixed_pll_compat,
 	.probe = mt7981_fixed_pll_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_fixed_pll_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index f9d6f9c1749..cf298af644c 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -573,7 +573,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.of_match = mt7986_fixed_pll_compat,
 	.probe = mt7986_fixed_pll_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_fixed_pll_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index 173686a38e8..b662d680b15 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -67,7 +67,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.of_match = mt7987_fixed_pll_compat,
 	.probe = mt7987_fixed_pll_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_fixed_pll_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 73fd9c6bea6..c6da42f970b 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -830,7 +830,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.of_match = mt7988_fixed_pll_compat,
 	.probe = mt7988_fixed_pll_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_fixed_pll_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 66683aeb2d7..f91777e968a 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -47,6 +47,11 @@ static int mtk_clk_get_id(struct clk *clk)
 	return id;
 }
 
+static int mtk_dummy_enable(struct clk *clk)
+{
+	return 0;
+}
+
 static int mtk_gate_enable(void __iomem *base, const struct mtk_gate *gate)
 {
 	u32 bit = BIT(gate->shift);
@@ -752,6 +757,12 @@ const struct clk_ops mtk_clk_apmixedsys_ops = {
 	.get_rate = mtk_apmixedsys_get_rate,
 };
 
+const struct clk_ops mtk_clk_fixed_pll_ops = {
+	.enable = mtk_dummy_enable,
+	.disable = mtk_dummy_enable,
+	.get_rate = mtk_topckgen_get_rate,
+};
+
 const struct clk_ops mtk_clk_topckgen_ops = {
 	.enable = mtk_clk_mux_enable,
 	.disable = mtk_clk_mux_disable,
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index c1d9901c10b..4ef1341aea6 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -283,6 +283,7 @@ struct mtk_cg_priv {
 };
 
 extern const struct clk_ops mtk_clk_apmixedsys_ops;
+extern const struct clk_ops mtk_clk_fixed_pll_ops;
 extern const struct clk_ops mtk_clk_topckgen_ops;
 extern const struct clk_ops mtk_clk_infrasys_ops;
 extern const struct clk_ops mtk_clk_gate_ops;
-- 
2.34.1

