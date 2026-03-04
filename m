Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55926EDEC08
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 03:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 342C183F0A;
	Wed,  4 Mar 2026 04:54:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B109083F75; Wed,  4 Mar 2026 04:54:01 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A779D83E7F
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 04:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vxdIx-000000000hp-1A3P; Wed, 04 Mar 2026 03:53:47 +0000
Date: Wed, 4 Mar 2026 03:53:38 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>,
 Daniel Golle <daniel@makrotopia.org>, u-boot@lists.denx.de
Subject: [PATCH] clk: mediatek: mt7622: fix infracfg and pericfg clock
 operations
Message-ID: <a54fd4a7284da506020cb614919096067b195277.1772596281.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The MT7622 infracfg and pericfg drivers both use
mtk_common_clk_infrasys_init() for probe, which populates struct
mtk_clk_priv and stores gate definitions in the clk_tree. However,
both drivers were incorrectly wired to mtk_clk_gate_ops which expects
struct mtk_cg_priv with separately populated gates/num_gates/gates_offs
fields from mtk_common_clk_gate_init().

Since those fields were never set, any attempt to enable an infracfg or
pericfg gate clock (e.g. CLK_INFRA_TRNG) would fail with -EINVAL.

Switch both to mtk_clk_infrasys_ops and struct mtk_clk_priv to match
the init function.

Fixes: 72ab603b201 ("clk: mediatek: add driver for MT7622")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/clk/mediatek/clk-mt7622.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 782eb14e9c5..c1cc57f2e8c 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -821,8 +821,8 @@ U_BOOT_DRIVER(mtk_clk_infracfg) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7622_infracfg_compat,
 	.probe = mt7622_infracfg_probe,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.priv_auto	= sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -831,8 +831,8 @@ U_BOOT_DRIVER(mtk_clk_pericfg) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7622_pericfg_compat,
 	.probe = mt7622_pericfg_probe,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.priv_auto	= sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-- 
2.53.0
