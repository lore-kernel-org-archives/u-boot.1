Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D4AC44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B57384CB5;
	Wed, 15 Jul 2026 16:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="dnMXeLtj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27BDA84C23; Wed, 15 Jul 2026 16:29:07 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB85984C90
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so9209835e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125738; x=1784730538; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C03pCvNP3NtfR6bHtab906TyNrFOQs3u4pESvMIXiUI=;
 b=dnMXeLtjaDui2+d2zwF/7go80TK7wSmQpwaAJePHjbQhIVcKijBK/sOkeWER2fGizW
 vq/TAznTggDt0+/+vyfjCUr3WFTLhIUbNsOHSeVqw3j0KMW70BDLw1KlMyF6f5dHNzvI
 e1NN6XX6HN1Z4EZMG76ecSxMjL9yvJJc/XqoOPLmAOih8p5SPE927pVIetWznp8y2drt
 0cqOXaduKFoqQv0I3CeAWD04GwNq4XfGQ3aF4+iZQaC1vW+YRtm6j2M4shkejWw3mCOI
 DACjv8dAney0JkZ/FfGUI49GjFAQV72n+cJcaHcXqL7DnrgGau09ZsVK4xlPuU6fYfAh
 vgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125738; x=1784730538;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C03pCvNP3NtfR6bHtab906TyNrFOQs3u4pESvMIXiUI=;
 b=bCp54lMgborhsy2QD8rP647CJ5+eDiWUbvJQuIT78wb4409Fp7iCUZfANHRD9erxiF
 2Q91s3gOYfx4tS+koj2KevcADdAhQ+zVahhjaJ5yN/Tklsh81GeSUQzKcDY1J0EvV3zf
 uzvkqeOH2aU84y2JqqpVg5vsV1kxcPnmbIeZPSwtFA9oiz2i/qUbQNBFLuzrVUda73Th
 eQA5Z0Lyqdq1Fnnr9BVHcApxVBGvDm++Os+17yAUH6SUlIDpBvG+ZeWtAYOl6OYnYC2V
 FgeQd/HTMGTSg4FYCpwfpJ/tTbUEFJ8IvGB+f/454ptvYQP54pz7NNshIQt5hzugxy2j
 yznQ==
X-Gm-Message-State: AOJu0YwcxQvne8CU35wBIjCuGCp9mAwyU68xBHxc7efIjdDbNUKghLmo
 4km8bdiD3uSFG6t6zltgDhUo6iK3B5pVjOc/m5/bgvMGjhRUdNQeBqb9AAjpc5DPJyU=
X-Gm-Gg: AfdE7cn4EFsU8awE6EH+tM8cuaoG2mfcz4SIHaVOJVSARx13TrarprFe6bwWAc0KUok
 XCvCkZGTOTPeYlpKrM8uMEFgQd/DSu+qYHagRvz20XDUOiUwRrGzZx/WFWZecr6EouNBxyejTIa
 uJ56Wcmu2xeawCK+ipWULGS6ViPGCvrmxyOutmAFFzj6Vvomij6ZCivzScQoWlwskVTR8LFGSkN
 GWPR5HAzlgpxnK3kfN+JHw/OCSrcf9kH4zzWwpoR62PB2ARXCXwQwyww/isxKx/4ReLzIq+z+ZX
 ipEiBRBjjDbOK5QGBhWdlogdAQG5kI9Wrrm8sJd0WYrzoMY53ZXVAiH/SvOPtOoy0CXyhbbr7Gj
 zE8S/azlSio2rbCmS9wcA4573UPiELsA6aQFg5a4JuAUz/p/xrfHwTMM8l47xe9SfgdYcUI8QlI
 TkRxE/ljyFmE44INQn+aPqq6Fnk/zoaVFhJ00vJLGf5RBQO+bnvffsqo+jq9Uugivz6CiboD3xk
 t08SbwxayJF3LLiVgkX6tBMkVd0dT9MccTp4gNAqWSQvQ6DmhCJE3kcMGDLHg2rASD/M/ikCOmX
 93wwpIs=
X-Received: by 2002:a05:600d:6452:20b0:493:b4a3:5ab0 with SMTP id
 5b1f17b1804b1-493f88c7074mr142426675e9.13.1784125737623; 
 Wed, 15 Jul 2026 07:28:57 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:57 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:55 +0200
Subject: [PATCH v2 27/32] clk: mediatek: mt8512: deduplicate clock gate drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-27-23e907516010@baylibre.com>
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

MT8512 declares a separate U_BOOT_DRIVER, probe() function and compatible
table for the topckgen and infracfg clock gate controllers, despite both
sharing the same implementation.

Describe the gates directly in each controller's struct mtk_clk_tree,
reference the trees from the driver data and use the generic
mtk_clk_topckgen_ops. Both controllers share the same DM flags and (absent)
bind() callback and are merged into a single U_BOOT_DRIVER.

This also stops using mtk_common_clk_gate_init() and struct mtk_cg_priv,
which are scheduled for removal.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8512.c | 60 ++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index 88c55e5ac6c..5e61f80d37e 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -815,9 +815,18 @@ static const struct mtk_clk_tree mt8512_topckgen_clk_tree = {
 	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
-static const struct mtk_clk_tree mt8512_clk_tree = {
+static const struct mtk_clk_tree mt8512_topckgen_cg_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = top_clks,
+	.num_gates = ARRAY_SIZE(top_clks),
+};
+
+static const struct mtk_clk_tree mt8512_infracfg_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = infra_clks,
+	.num_gates = ARRAY_SIZE(infra_clks),
 };
 
 static int mt8512_apmixedsys_probe(struct udevice *dev)
@@ -830,16 +839,11 @@ static int mt8512_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt8512_topckgen_clk_tree);
 }
 
-static int mt8512_topckgen_cg_probe(struct udevice *dev)
+static int mt8512_clk_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8512_clk_tree, top_clks,
-					ARRAY_SIZE(top_clks), 0);
-}
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 
-static int mt8512_infracfg_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt8512_clk_tree, infra_clks,
-					ARRAY_SIZE(infra_clks), 0);
+	return mtk_common_clk_init(dev, tree);
 }
 
 static const struct udevice_id mt8512_apmixed_compat[] = {
@@ -852,13 +856,15 @@ static const struct udevice_id mt8512_topckgen_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt8512_topckgen_cg_compat[] = {
-	{ .compatible = "mediatek,mt8512-topckgen-cg", },
-	{ }
-};
-
-static const struct udevice_id mt8512_infracfg_compat[] = {
-	{ .compatible = "mediatek,mt8512-infracfg", },
+static const struct udevice_id of_match_mt8512_clk_gate[] = {
+	{
+		.compatible = "mediatek,mt8512-topckgen-cg",
+		.data = (ulong)&mt8512_topckgen_cg_tree
+	},
+	{
+		.compatible = "mediatek,mt8512-infracfg",
+		.data = (ulong)&mt8512_infracfg_tree
+	},
 	{ }
 };
 
@@ -884,22 +890,12 @@ U_BOOT_DRIVER(mt8512_clk_topckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt8512_clk_topckgen_cg) = {
-	.name = "mt8512-topckgen-cg",
+U_BOOT_DRIVER(mt8512_clk_gate) = {
+	.name = "mt8512-clk-gate",
 	.id = UCLASS_CLK,
-	.of_match = mt8512_topckgen_cg_compat,
-	.probe = mt8512_topckgen_cg_probe,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
-U_BOOT_DRIVER(mt8512_clk_infracfg) = {
-	.name = "mt8512-infracfg",
-	.id = UCLASS_CLK,
-	.of_match = mt8512_infracfg_compat,
-	.probe = mt8512_infracfg_probe,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.of_match = of_match_mt8512_clk_gate,
+	.probe = mt8512_clk_probe,
+	.priv_auto	= sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };

-- 
2.54.0

