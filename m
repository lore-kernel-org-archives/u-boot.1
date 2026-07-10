Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA08DC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 14:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0403584B59;
	Fri, 10 Jul 2026 16:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="SZ3B3u03";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DD7884B65; Fri, 10 Jul 2026 16:13:06 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63B2A84B51
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so8857855e9.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 07:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783692784; x=1784297584; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vw8UR5EKyXJSDoGAXGBRYLa7t8LGQqqQeIelTSfgEZ0=;
 b=SZ3B3u03e9OwL4GpyLVTn55yr+Mc6xUZm3Rrf/QxPMW/7UvHedEKDOqymLRjQoI0ux
 hQUkuMZPS0zbFkYdrkQoO/6XYwjZf14Yhnu7h17ZO7jH76SxlOw3BeogDc3qD7xhwBE7
 evx0qzVHmqcp5+xY54Sdv3IMZD3BPMbllnR8Z8QzKYctApXQ8hotf8VO2y7uCUA6/6lZ
 lhrTfEgV6O46m7zJuhvnlc4rdeN89xPC9HbHoGtcBp94Bsagi5P8B5ke+DUisRs0dQKo
 M4HFan/dwhzG8wbnxvJW2dOE/O1HBWlJ2iyKGxzSYGLOtxkqLp4rNuxPd+30bJQymcvF
 84+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783692784; x=1784297584;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vw8UR5EKyXJSDoGAXGBRYLa7t8LGQqqQeIelTSfgEZ0=;
 b=JEzteJpOh/89QTSLdHeNVdcShsYcnKfNEGgDXXgKph6xRPi+/Z4A5OQS5qWVGQ58kG
 thNRRJdRMVJZmlHwP7Y6wH2f164hZ8ta0s6/IzeY+/w0H1ytZVBW6LIhvXC+J564yFyQ
 PvlzedLKy2gMPVIllK1fcT+dGSzk1/92Y5ieTtZkPObb2ewpd+Kf/feQoErRgwsw4bjJ
 PaevkJR0PM8Tt/TBREDB3H+7SSo8hBr9d5WVsDR/5qzyu0AUN8QRKOTviD9hwPUOQ/R6
 B4UWxc8sxqdH02+S3fA4EFMeTmM93P+uNH/Tw4UP7oovBkALNL5nEn512lXgSVTe9Go0
 AZTA==
X-Gm-Message-State: AOJu0YyC0S2+l38ESDFAwjPbAKy4/wsdjiyF25TlH2+SO52+0l7HWJjp
 zQDf76Zgu0FdYLYfJrTC7Be+2WUYmuj6DUXvYfBZjMojrnJ1/x2mqF8dmevpFZ5mKHs=
X-Gm-Gg: AfdE7ck1Tc9h+/yFS4upEtAVP6+c2kUsCarx7X6kyJvd8cXRg9aJIiZibbfufBn4uR6
 Fvj9PMiQqpzDdaKxK32YzGDMjggWJcKjVU+XA9bqTsJCsjSomOhj+XNbdWArBDxc+9TV1uHd0fn
 dlQfmky1PKHVX2DyPaSiCnAqv/UJAFcfWRLskJmDwLBMByV7R/+p2hpmdX75RyPybGpNAcLAOJD
 U6SJx9GV/e2rsCKK4Xh03D2PA11at9zrh5KPlWQ0l6uRbuBUPS80giXp3Ps6KQ9uJLdKtT/39Qf
 LbCQBdLxlHbEtTAV/L8BGPfDco2QW1fk//YXUeRu/wb6hyj6Y9b9zgRHseKV3/KcY7+Z1tf9UDX
 ye2+Da14gLw+z+KUfOf0PVsN9IYE0MZh2qYSPc3xnMzTIIx/kfIQfPDBApJDnqujyiRLhKv7yLk
 l57qeoWSR4mWa+idmtu4oQ0uNzLoQDjcJ4oOnO08uqeb9yI3C+hQ95+tadQ3pYuNhgtsamWE9dq
 erp4SAUKUnTyiFEu0olCi3AGPtNSsUszTFRxwPY4hh7lmyZTeJspM1NKyxcs13fJIR+AiE=
X-Received: by 2002:a05:600c:628e:b0:492:6113:d4fc with SMTP id
 5b1f17b1804b1-493e68cfbbcmr117591145e9.17.1783692783790; 
 Fri, 10 Jul 2026 07:13:03 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d88698sm64073205e9.1.2026.07.10.07.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:13:03 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 10 Jul 2026 16:13:00 +0200
Subject: [PATCH 9/9] clk: mediatek: mt8512: convert to mtk_gate_clk_data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-9-a4b5c491d9bf@baylibre.com>
References: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-0-a4b5c491d9bf@baylibre.com>
In-Reply-To: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-0-a4b5c491d9bf@baylibre.com>
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
 Julien Stephan <jstephan@baylibre.com>
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

MT8512 currently declares a separate U_BOOT_DRIVER, mtk_clk_tree,
probe() function and compatible table for each clock gate controller,
despite all of them sharing the same implementation.

Convert MT8512 to use the generic mtk_gate_clk_data infrastructure.
This allows the topckgen-cg and infracfg clock gate controllers to
share a single generic driver.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8512.c | 52 +++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index 88c55e5ac6c..031c3f87d72 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -830,16 +830,18 @@ static int mt8512_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt8512_topckgen_clk_tree);
 }
 
-static int mt8512_topckgen_cg_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt8512_clk_tree, top_clks,
-					ARRAY_SIZE(top_clks), 0);
-}
+MTK_GATE_CLK_DATA(top_clks);
+MTK_GATE_CLK_DATA(infra_clks);
 
-static int mt8512_infracfg_probe(struct udevice *dev)
+static int mt8512_clk_gate_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8512_clk_tree, infra_clks,
-					ARRAY_SIZE(infra_clks), 0);
+	struct mtk_gate_clk_data *data;
+
+	data = (void *)dev_get_driver_data(dev);
+
+	return mtk_common_clk_gate_init(dev, &mt8512_clk_tree,
+					data->gates, data->num_gates,
+					data->gates[0].id);
 }
 
 static const struct udevice_id mt8512_apmixed_compat[] = {
@@ -852,13 +854,15 @@ static const struct udevice_id mt8512_topckgen_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt8512_topckgen_cg_compat[] = {
-	{ .compatible = "mediatek,mt8512-topckgen-cg", },
-	{ }
-};
-
-static const struct udevice_id mt8512_infracfg_compat[] = {
-	{ .compatible = "mediatek,mt8512-infracfg", },
+static const struct udevice_id mt8512_clk_gate_compat[] = {
+	{
+		.compatible = "mediatek,mt8512-topckgen-cg",
+		.data = (ulong)&top_clks_data
+	},
+	{
+		.compatible = "mediatek,mt8512-infracfg",
+		.data = (ulong)&infra_clks_data
+	},
 	{ }
 };
 
@@ -884,21 +888,11 @@ U_BOOT_DRIVER(mt8512_clk_topckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt8512_clk_topckgen_cg) = {
-	.name = "mt8512-topckgen-cg",
-	.id = UCLASS_CLK,
-	.of_match = mt8512_topckgen_cg_compat,
-	.probe = mt8512_topckgen_cg_probe,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
-U_BOOT_DRIVER(mt8512_clk_infracfg) = {
-	.name = "mt8512-infracfg",
+U_BOOT_DRIVER(mt8512_clk_gate) = {
+	.name = "mt8512-gate-clk",
 	.id = UCLASS_CLK,
-	.of_match = mt8512_infracfg_compat,
-	.probe = mt8512_infracfg_probe,
+	.of_match = mt8512_clk_gate_compat,
+	.probe = mt8512_clk_gate_probe,
 	.priv_auto	= sizeof(struct mtk_cg_priv),
 	.ops = &mtk_clk_gate_ops,
 	.flags = DM_FLAG_PRE_RELOC,

-- 
2.54.0

