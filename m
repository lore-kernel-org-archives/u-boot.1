Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99187C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EADC284B77;
	Wed, 15 Jul 2026 16:28:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ZWXXk5tk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A45884BDC; Wed, 15 Jul 2026 16:28:34 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7536E84BBD
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493c2c0b9a8so14715965e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125712; x=1784730512; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LFHieM1w3LSo/VlwdKzbmzIDRE3pz0oS5wfiIM9zxtg=;
 b=ZWXXk5tkc2dUjpJUk/Xm9kId+P2fntf1y3GpJxGS6U6KdvqbcqO3dx8HfsvbCNYd0e
 Y6xqpPlJr+IfhSEcWodDkWdeY7wDHaoL0qLMCqsYw5qO//Bn1ZnTwvRF3feX90JlAi4+
 jXx+jJvhvVg0qffllbyf+rYxtu5xCPpMLCFlrbRfTsyVnyI5OfnMjTYAQiff0RDi7cPG
 nYLgXAgcSsgHsZycW9vntuuaevo9BdoLqO8MWgtSmq6uuAHQ74C4SKE3gky+6BLkJ/at
 UmCA/HBwvvzusapmSbKMbHDdGIKYVa5jb5KkmDDADHuNrrBaYa7I+6SkE/puF6NgL4zC
 G8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125712; x=1784730512;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LFHieM1w3LSo/VlwdKzbmzIDRE3pz0oS5wfiIM9zxtg=;
 b=Up5j46u6rxTJH+dnN84IlXNuZzZxFbhpGwtbd13wnyMgKwnVcret8g4iyQr3Gdw8D1
 rb6qxxTy3lnUGWMYE0HNPD6T0yyQCTdPKUjJOGod+vJhat2acYT1GXIm665CwHSpM6Km
 XJ4dDXsqlOyqhuHhBwwhhSNd9qfAp8K9ixHdVYTrUmG4ODNJrtxkxgGRjKQemrO+kFPe
 zYsBlXhBcFOLt2xij/E7WpadIsPie4tZimcIt3J6Tp4QwqyZYyvtUq7NzVOOKnofJJsx
 2w+i8DAsoTNqB0zG3jfjs2MlRz/btkGziWMKWiQfjGf+ev3ZR4Kq62XLFp7DwvKLPChs
 +QFw==
X-Gm-Message-State: AOJu0Yzg/tMOS7lRaMqKvj5EaOzaIXHEc1sIVKEq+/czoDAJseKLeiPZ
 e6R/Mq0zpYwzLhe11sOmaB5h6n3+kCHQ1pfZ/6DWgbNC48fjMtPC6an6kCuiuY4z0qQ=
X-Gm-Gg: AfdE7cnJL12aYC+K4Gh8IHqtCRAo2fUfNbFQJcWvoeKxNIXfr0qZjtjkaJNL4EzoYDZ
 JGJ/k/N3VNSAkK2iWN7I/cvuk2XRbtTHv0Gqb/01/OxH3SQLqsK9R2xabP+A/ycLBuo8slthso7
 +8Ppl88d48PtNxErBpy7t1vVIa5o4UCG2aSobEyEuWstlEVKT6VG0aS04+WwcgFzPrh01kvsNKK
 TFu6H55uH8TrZGB2NGJzIeE1tWKZlEpwPmoSZLeoOX8DrTehO60WYiZ+Q5bBxaTqdBeiFts6UC0
 BdqEDbjJ6VBePEFqAwPPGRYxdEshyj2OoQGY/nTNSklxcLPI0/T8d44yRQaZfuEUuc3eCcNfsKN
 SY0KHfv4o4f8eaiddl2bXCzXyfxb3otln1di5MHBd3wKiWkmchpfY9A0einCFmSRWre1k6VRWBA
 z+4Ad0D3rpTPZmTHiSfz6zNhfPNWWSBvtLj9w0B0tzfXdkOW60v7HSQSaYt10xv6jZH5O01Y6ys
 2fP1bdCgU5YaFLUJqpSrqnftMKR5fNrg0/YShziJtkLzwmBTuR4pTRyrkraao0znpkrM0yn
X-Received: by 2002:a05:600c:c051:b0:492:3773:a230 with SMTP id
 5b1f17b1804b1-493f88268f9mr128709935e9.27.1784125711735; 
 Wed, 15 Jul 2026 07:28:31 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:31 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:37 +0200
Subject: [PATCH v2 09/32] clk: mediatek: mt7981: deduplicate clock gate drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-9-23e907516010@baylibre.com>
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

MT7981 declares a separate U_BOOT_DRIVER, probe() function and compatible
table for each clock gate controller, despite all of them sharing the same
implementation.

Describe the gates directly in each controller's struct mtk_clk_tree,
reference the trees from the driver data and use the generic
mtk_clk_topckgen_ops. The two sgmiisys controllers, which share the same DM
flags and (absent) bind() callback, are merged into a single U_BOOT_DRIVER;
ethsys keeps its own driver as it binds a reset controller.

This also stops using mtk_common_clk_gate_init() and struct mtk_cg_priv,
which are scheduled for removal.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7981.c | 91 ++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 45 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 4e3a1c9d835..7efe0dcdf53 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -656,10 +656,12 @@ static const struct mtk_clk_tree mt7981_infracfg_clk_tree = {
 	.type = MTK_CLK_TREE_INFRASYS,
 };
 
-static const struct mtk_clk_tree mt7981_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-};
+static int mt7981_clk_probe(struct udevice *dev)
+{
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
+
+	return mtk_common_clk_init(dev, tree);
+}
 
 static const struct udevice_id mt7981_fixed_pll_compat[] = {
 	{ .compatible = "mediatek,mt7981-fixed-plls" },
@@ -751,24 +753,11 @@ static const struct mtk_gate sgmii0_cgs[] = {
 	GATE_SGMII(CLK_SGM0_CDR_CK0_EN, "sgm0_cdr_ck0_en", CLK_TOP_USB_CDR_CK, 5),
 };
 
-static int mt7981_sgmii0sys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7981_clk_tree,
-					sgmii0_cgs, ARRAY_SIZE(sgmii0_cgs), 0);
-}
-
-static const struct udevice_id mt7981_sgmii0sys_compat[] = {
-	{ .compatible = "mediatek,mt7981-sgmiisys_0", },
-	{}
-};
-
-U_BOOT_DRIVER(mt7981_clk_sgmii0sys) = {
-	.name = "mt7981-clock-sgmii0sys",
-	.id = UCLASS_CLK,
-	.of_match = mt7981_sgmii0sys_compat,
-	.probe = mt7981_sgmii0sys_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+static const struct mtk_clk_tree mt7981_sgmii0_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = sgmii0_cgs,
+	.num_gates = ARRAY_SIZE(sgmii0_cgs),
 };
 
 static const struct mtk_gate sgmii1_cgs[] = {
@@ -778,24 +767,32 @@ static const struct mtk_gate sgmii1_cgs[] = {
 	GATE_SGMII(CLK_SGM1_CDR_CK1_EN, "sgm1_cdr_ck1_en", CLK_TOP_USB_CDR_CK, 5),
 };
 
-static int mt7981_sgmii1sys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7981_clk_tree,
-					sgmii1_cgs, ARRAY_SIZE(sgmii1_cgs), 0);
-}
-
-static const struct udevice_id mt7981_sgmii1sys_compat[] = {
-	{ .compatible = "mediatek,mt7981-sgmiisys_1", },
+static const struct mtk_clk_tree mt7981_sgmii1_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = sgmii1_cgs,
+	.num_gates = ARRAY_SIZE(sgmii1_cgs),
+};
+
+static const struct udevice_id of_match_mt7981_sgmiisys[] = {
+	{
+		.compatible = "mediatek,mt7981-sgmiisys_0",
+		.data = (ulong)&mt7981_sgmii0_clk_tree
+	},
+	{
+		.compatible = "mediatek,mt7981-sgmiisys_1",
+		.data = (ulong)&mt7981_sgmii1_clk_tree
+	},
 	{}
 };
 
-U_BOOT_DRIVER(mt7981_clk_sgmii1sys) = {
-	.name = "mt7981-clock-sgmii1sys",
+U_BOOT_DRIVER(mt7981_clk_sgmiisys) = {
+	.name = "mt7981-clock-sgmiisys",
 	.id = UCLASS_CLK,
-	.of_match = mt7981_sgmii1sys_compat,
-	.probe = mt7981_sgmii1sys_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.of_match = of_match_mt7981_sgmiisys,
+	.probe = mt7981_clk_probe,
+	.priv_auto = sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 };
 
 /* ethsys */
@@ -819,11 +816,12 @@ static const struct mtk_gate eth_cgs[] = {
 	GATE_ETH(CLK_ETH_WOCPU0_EN, "eth_wocpu0_en", CLK_TOP_NETSYS_WED_MCU, 15),
 };
 
-static int mt7981_ethsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7981_clk_tree,
-					eth_cgs, ARRAY_SIZE(eth_cgs), 0);
-}
+static const struct mtk_clk_tree mt7981_eth_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = eth_cgs,
+	.num_gates = ARRAY_SIZE(eth_cgs),
+};
 
 static int mt7981_ethsys_bind(struct udevice *dev)
 {
@@ -839,7 +837,10 @@ static int mt7981_ethsys_bind(struct udevice *dev)
 }
 
 static const struct udevice_id mt7981_ethsys_compat[] = {
-	{ .compatible = "mediatek,mt7981-ethsys", },
+	{
+		.compatible = "mediatek,mt7981-ethsys",
+		.data = (ulong)&mt7981_eth_clk_tree
+	},
 	{}
 };
 
@@ -847,8 +848,8 @@ U_BOOT_DRIVER(mt7981_clk_ethsys) = {
 	.name = "mt7981-clock-ethsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7981_ethsys_compat,
-	.probe = mt7981_ethsys_probe,
+	.probe = mt7981_clk_probe,
 	.bind = mt7981_ethsys_bind,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.priv_auto = sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 };

-- 
2.54.0

