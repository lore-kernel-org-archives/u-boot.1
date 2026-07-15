Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161B6C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8F5784BA0;
	Wed, 15 Jul 2026 16:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="mkAKAU4R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E6F584B88; Wed, 15 Jul 2026 16:28:29 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EB9E84ACE
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so49326515e9.2
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125707; x=1784730507; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5ACfoKdulNno9DSNvdb+YHmEoVDwCjLMmS13vSNxbTM=;
 b=mkAKAU4RkRF/vmHiUFzXtFh9cq7M0KdfuIhLa4VPmG+EcAHPHU6WfttzdsCk6pG7+z
 q3fcdwJvUBa8opdpleqBnR+fnpHWKQibuW/U9oYSuCyWl8TYQeBukY+i13Btwx0Ypxka
 8xKH1KJ7m/ho/RgwtCkvJaIA4dhHvGJkbiY3uGoCsI4dTkWaBfASSOtIza1vf5xTsnAW
 ovBmI+TRqkwVib8S5rRC2UY2Ch86N1Op2jhLOYXXuz1JNqlHEtnk3fl31eAqnjFdXUyY
 R5rOIztgFuoXTzbmn80CMReY8y90rIuiJ13ifuTEhrHYjnzKsKpZY4WBFj9GtGqW/Mgk
 ss/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125707; x=1784730507;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5ACfoKdulNno9DSNvdb+YHmEoVDwCjLMmS13vSNxbTM=;
 b=S321OcCOIPLltVHT7uwgLpc3F8u3Htjw5cueuPs1y/KRyIp8dV3cEaKLYJtjGXMSMt
 dVAo7lLYhDyxymOEbH//y64bY1S16G/KmL2ZcwcJ673gF44U4o+kszGAkXOZObweuJCG
 ZorMuu//qiW/yulLH69bcObzkiEPKIKpkww+v0d6xscGLVGK9zl91sLEKbtsyBryMT7k
 7rS8RtkoVAJy0NytjiBZle5OfRuB+WOqKHHTSTO3wGIL4GEqHX2PW0W5vL/6MOhWtu6h
 +LKq8F8Tx+4EZMiFQvEMS6SvZaKpHxInO09Nl6sMpBkdldMgpXGGRW56iI6LdsLjJfK1
 zoXg==
X-Gm-Message-State: AOJu0YzwlblNpnAcAmcvGDZKXLI+Sf5iUkwSbeftWkFi1KLKl4K+n0x+
 +Pi2zBKAjRSll9eCUrcArZ2TTBmgoXyGFXN9SOsgM/sOvXQ+swSFoKF8J8I3HM6yuuc=
X-Gm-Gg: AfdE7cnCFgN+EzG6es5Hbol9bT4oWG0XMgtFmBHrocSnL+KaIfdb32IEXVtisyssBs6
 KU2rC9+kvYbAvzz6XEmtuar4fiPkYShcBrulKmE4h7eBWH7M3fDoHEJbvR76uWWYp/9mG5KSxFw
 eHl7P3Xf6pBkdHbjIW2w1ET9Z9TaRKFK6T/Qi61Im0qmJuRFb0aIohpiHr8fpjMfGSMxdaxOJ5d
 dj4TBeSfK9FfFdetS5ms5J26siEj1wzRarl0VHo96Ik+6aI/bcPywao7P0uTecoSEoYFFmZKBkR
 OGiMqnxBSbVi6xBE7s2clttedS2VtkXAXZUx9aoDyzK34POYjYpXYVj2RdbZAY7FDDWMAXTcfbg
 YR2QR8xWA3g2h5ege58EIi48wcNDFvmy1mqjerMI7N7pLhhp+bm8UHgaxj5z1FdeEwGD2t0DnEp
 CtcGKE3Ehq8rnKsvd8lx3xvF2F6MzT0UpuigOseJaTVgfrRLKtbYX2kroQIX1+ZyAPJB4TDOlrV
 n0G0JIrhPpW5sXEHGOQ+pHS4CklWgb3yH9IKONdIJmWj2miEMTREJ03ypMN+ZdMzrw74foG
X-Received: by 2002:a05:600c:8289:b0:495:3b18:1b5f with SMTP id
 5b1f17b1804b1-4953c38f6f9mr33044985e9.37.1784125706839; 
 Wed, 15 Jul 2026 07:28:26 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:26 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:33 +0200
Subject: [PATCH v2 05/32] clk: mediatek: mt7623: deduplicate clock gate drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-5-23e907516010@baylibre.com>
References: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-0-23e907516010@baylibre.com>
In-Reply-To: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-0-23e907516010@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Julien Stephan <jstephan@baylibre.com>, Sam Shih <sam.shih@mediatek.com>
X-Mailer: b4 0.15.2
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

MT7623 declares a separate U_BOOT_DRIVER, probe() function and compatible
table for each clock gate controller, despite all of them sharing the same
implementation.

Describe the gates directly in each controller's struct mtk_clk_tree,
reference the trees from the driver data and use the generic
mtk_clk_topckgen_ops. The ethsys and hifsys controllers, which share the
same reset-binding bind() callback, are merged into a single U_BOOT_DRIVER;
infracfg keeps its own driver since it is pre-relocation and does not bind a
reset controller.

This also stops using mtk_common_clk_gate_init() and struct mtk_cg_priv,
which are scheduled for removal.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7623.c | 89 ++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 43 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 56912ebdb53..0a648bb4a06 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -1064,15 +1064,35 @@ static int mt7623_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt7623_topckgen_clk_tree);
 }
 
-static const struct mtk_clk_tree mt7623_clk_gate_tree = {
+static const struct mtk_clk_tree mt7623_infracfg_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates_offs = 1,
+	.gates = infra_cgs,
+	.num_gates = ARRAY_SIZE(infra_cgs),
 };
 
-static int mt7623_infracfg_probe(struct udevice *dev)
+static const struct mtk_clk_tree mt7623_hifsys_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates_offs = 1,
+	.gates = hif_cgs,
+	.num_gates = ARRAY_SIZE(hif_cgs),
+};
+
+static const struct mtk_clk_tree mt7623_ethsys_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates_offs = 1,
+	.gates = eth_cgs,
+	.num_gates = ARRAY_SIZE(eth_cgs),
+};
+
+static int mt7623_clk_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7623_clk_gate_tree, infra_cgs,
-					ARRAY_SIZE(infra_cgs), 1);
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
+
+	return mtk_common_clk_init(dev, tree);
 }
 
 static const struct mtk_clk_tree mt7623_clk_peri_tree = {
@@ -1093,18 +1113,6 @@ static int mt7623_pericfg_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt7623_clk_peri_tree);
 }
 
-static int mt7623_hifsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7623_clk_gate_tree, hif_cgs,
-					ARRAY_SIZE(hif_cgs), 1);
-}
-
-static int mt7623_ethsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7623_clk_gate_tree, eth_cgs,
-					ARRAY_SIZE(eth_cgs), 1);
-}
-
 static int mt7623_ethsys_hifsys_bind(struct udevice *dev)
 {
 	int ret = 0;
@@ -1129,7 +1137,10 @@ static const struct udevice_id mt7623_topckgen_compat[] = {
 };
 
 static const struct udevice_id mt7623_infracfg_compat[] = {
-	{ .compatible = "mediatek,mt7623-infracfg", },
+	{
+		.compatible = "mediatek,mt7623-infracfg",
+		.data = (ulong)&mt7623_infracfg_tree
+	},
 	{ }
 };
 
@@ -1138,13 +1149,15 @@ static const struct udevice_id mt7623_pericfg_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt7623_ethsys_compat[] = {
-	{ .compatible = "mediatek,mt7623-ethsys" },
-	{ }
-};
-
-static const struct udevice_id mt7623_hifsys_compat[] = {
-	{ .compatible = "mediatek,mt7623-hifsys" },
+static const struct udevice_id of_match_mt7623_clk_eth[] = {
+	{
+		.compatible = "mediatek,mt7623-ethsys",
+		.data = (ulong)&mt7623_ethsys_tree
+	},
+	{
+		.compatible = "mediatek,mt7623-hifsys",
+		.data = (ulong)&mt7623_hifsys_tree
+	},
 	{ }
 };
 
@@ -1187,9 +1200,9 @@ U_BOOT_DRIVER(mt7623_clk_infracfg) = {
 	.name = "mt7623-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7623_infracfg_compat,
-	.probe = mt7623_infracfg_probe,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.probe = mt7623_clk_probe,
+	.priv_auto	= sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -1203,22 +1216,12 @@ U_BOOT_DRIVER(mt7623_clk_pericfg) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt7623_clk_hifsys) = {
-	.name = "mt7623-clock-hifsys",
+U_BOOT_DRIVER(mt7623_clk_eth) = {
+	.name = "mt7623-clk-eth",
 	.id = UCLASS_CLK,
-	.of_match = mt7623_hifsys_compat,
-	.probe = mt7623_hifsys_probe,
+	.of_match = of_match_mt7623_clk_eth,
+	.probe = mt7623_clk_probe,
 	.bind = mt7623_ethsys_hifsys_bind,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-};
-
-U_BOOT_DRIVER(mt7623_clk_ethsys) = {
-	.name = "mt7623-clock-ethsys",
-	.id = UCLASS_CLK,
-	.of_match = mt7623_ethsys_compat,
-	.probe = mt7623_ethsys_probe,
-	.bind = mt7623_ethsys_hifsys_bind,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.priv_auto	= sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 };

-- 
2.54.0

