Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59468C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8099E84C1D;
	Wed, 15 Jul 2026 16:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Gb1Ij4EV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8946684C88; Wed, 15 Jul 2026 16:28:55 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C817284B43
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4703bc0a99aso3425113f8f.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125732; x=1784730532; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0jsfChy612ekEvbbiRCfF9ywhTJs4wHT2OHIaxDfsY4=;
 b=Gb1Ij4EVMhl6Gjl2ZEU87jL4XADJbw6Z8dEYoMr73Zr4unCauiVANQGFNRQY7y/16g
 6y5apXVDMf0M//eGEz+nynv6LjcwT4QFDdTBxDJXMcpbQlHBopXvnHoO1kJ+vVWZMx+p
 MHpV/4Gn8AcuDURWPfiaY7KEDelWS2mofhceclOUW8vFQrDXn+y6mScEg5CEekNw9erY
 CfNkXEX5vErQhOFhJfHP7qYIMxmSVo6xNoyHBJCa6Bfw1UEyU6WAt/mCmSLAWMG7x18G
 M9buucsG2kDiGU4vVVDisdOk8Mr7ejazfPyMkWeSihRTyuKTv5neoRIPZUK9eRLW7cjM
 MgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125732; x=1784730532;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0jsfChy612ekEvbbiRCfF9ywhTJs4wHT2OHIaxDfsY4=;
 b=pMAlNxgcsjQO7ZVKbC1CUyTaTxecHrPw8j0yGryKsztTfCS97PLyWCrmGwvaPEvSDG
 HZXHsgF6SeCLdIBzx10k8KxlJyxnz5CQ6yNfJ2lfzSTMjS5x1EYjDGDc1qtwPaLwTg+0
 k/kG6a20xkKxjCvj1jlMB9Uznc4L9X/Btyc1PrHAaz91xMnO2UFUY4qpj4cZIjoLxjtE
 MzXm2rUm5fMojvhENxkAH212O2OqylHm2e7BJE+QGB6nPCyNWCLXWycqlsrQbv/SLGGd
 K4DPsc09jNCtDJw+o4K6vp4B133D97FKE+r43HbrnDf5mqnva1hTOzRhIU0nOSIKz3i7
 BsXg==
X-Gm-Message-State: AOJu0Ywfmr4WyFfdYGbi/eB0gNICovb0oIOsrr8p+oBtqIpXCXgMy2rX
 zmOVoXpQ32HJf6I2kE7cRADGWEkbo5o29QBLzCfbBEQxvpy9OIHcchdEpm7M9P7X5Oc=
X-Gm-Gg: AfdE7cmq1MTHw9T2sL/uLxJhatK1NgHuKbf9C99NcTNyznFzGW2PGLmg8u64iUmA/kC
 rFKxs3O0SiXY09Bl/7QtXmeivzEL1LIWDzzNYyWXqJczvU9FTsIhTHhU8fEGt/nUR3xMCDTlwOl
 mzvshLmyXawkaDMoL9jx0v/yFtcuPinkBNXZT6yu9D4bWndbBB4mpxbMI8sa/EvhCYxXsj1FI9+
 tMXi68Fltl0fyzN87ORVBzvEgVbU391mkSU/EoyPCrGF046Tjv0D8VA1CAms07KGqeYehoL/5qC
 apiPNip5zCD3mxFwuoZRE2ReT4kxo6ukwNACDzw6VuU5yt1nn8o8w6h3HQwr7fQfmxqgFFQLxt/
 663mm0Y08zoAStkhumWT/bIjZdX2QHJRh9M4d2CT24hRaEdD+YI+4LXkexl5Lt092d3EygPHblO
 bk+tVq8BI1UJ2qUHz/RYMcNogWSdiUcsIbrD6AV+po9VvGfUBiZjavoTUVTW5SyXrQlbZ5dp8RF
 /FygQd4roUWkrY5jgllwaFBWpA3Lnsuc1mgrbSfRD5OlfseegSFBrh9ZsjHT8rGaDP+I+MF
X-Received: by 2002:a05:600c:3e88:b0:493:e460:1f6 with SMTP id
 5b1f17b1804b1-4953c004f3bmr36356735e9.0.1784125731972; 
 Wed, 15 Jul 2026 07:28:51 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:51 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:51 +0200
Subject: [PATCH v2 23/32] clk: mediatek: mt8195: deduplicate clock gate drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-23-23e907516010@baylibre.com>
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

Describe the infracfg_ao gates directly in a struct mtk_clk_tree, reference
the tree from the driver data and use the generic mtk_clk_topckgen_ops
instead of the dedicated clock gate ops.

This stops using mtk_common_clk_gate_init() and struct mtk_cg_priv, which
are scheduled for removal.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8195.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index c12463cc616..1431fe0c768 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -1599,6 +1599,8 @@ static const struct mtk_gate infra_ao_clks[] = {
 static const struct mtk_clk_tree mt8195_infracfg_ao_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = infra_ao_clks,
+	.num_gates = ARRAY_SIZE(infra_ao_clks),
 };
 
 static int mt8195_apmixedsys_probe(struct udevice *dev)
@@ -1611,11 +1613,11 @@ static int mt8195_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt8195_topckgen_clk_tree);
 }
 
-static int mt8195_infra_ao_probe(struct udevice *dev)
+static int mt8195_clk_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8195_infracfg_ao_clk_tree,
-					infra_ao_clks,
-					ARRAY_SIZE(infra_ao_clks), 0);
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
+
+	return mtk_common_clk_init(dev, tree);
 }
 
 static const struct udevice_id mt8195_apmixed[] = {
@@ -1629,7 +1631,10 @@ static const struct udevice_id mt8195_topckgen_compat[] = {
 };
 
 static const struct udevice_id of_match_clk_mt8195_infra_ao[] = {
-	{ .compatible = "mediatek,mt8195-infracfg_ao", },
+	{
+		.compatible = "mediatek,mt8195-infracfg_ao",
+		.data = (ulong)&mt8195_infracfg_ao_clk_tree
+	},
 	{ }
 };
 
@@ -1659,8 +1664,8 @@ U_BOOT_DRIVER(mt8195_clk_infra_ao) = {
 	.name = "mt8195-infra_ao",
 	.id = UCLASS_CLK,
 	.of_match = of_match_clk_mt8195_infra_ao,
-	.probe = mt8195_infra_ao_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.probe = mt8195_clk_probe,
+	.priv_auto = sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };

-- 
2.54.0

