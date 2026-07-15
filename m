Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CBBC44513
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D01884C5E;
	Wed, 15 Jul 2026 16:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ki5G4YKD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5D3884C26; Wed, 15 Jul 2026 16:28:48 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6A2384B43
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493c52cde9eso47459905e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125726; x=1784730526; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I+UqeXGiyue/dsbeZE5HE5ARjIkc+EIZ9F8s6oE+T0Y=;
 b=ki5G4YKDEkqNLaHcUOF7X+tXTTKLkWg/0WzO1uZ7lmcM8Q4xSvkIEpfu3Im/w9IkKj
 jkRbBQiWxhX0qOqmRIGglY3MCAAKlDmg5ll9XV0QDZhzxR7pIYYhTtKt1kPglvXQMiEg
 2Os5beBteIvtlWsBTOFKmbesRWjE1eTlYG//NTZyDWoUWiCCwPxl/dLV/5I/lh6bwJTt
 7gDRsN4/ltIA9w5x+2bBjv/p4ROru5FWorF8NMF2EduCXrgrrTePe09BDzzAL5EfBeLm
 QEM7tYita6ZQ9MmKl0fPNA+VhYZHS0WxYIM6szlqrcpXSL+afljQwEKqa0acj4eY4rUi
 +ArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125726; x=1784730526;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I+UqeXGiyue/dsbeZE5HE5ARjIkc+EIZ9F8s6oE+T0Y=;
 b=O3ifgT1lp2nZRDvPsd+A4+Rxc4IesEiDuKTxEEGBYRIJ+RZQaAQ8wQa8COztMKhMGA
 6V8Mxx8J50K18LKK6WGNlIS6rTpr5voiFzrAdu+bOcm3DW2DgaakFPNfkevGIeLQ32ex
 5BCaAJib5fPu5OG7AHJOLiHihvK9sAXDsndUyUDNf+Du192i49KfGiFQQFak2Vi/wIya
 9NhyLi14++QBrvetlGZOshOrEHK9bvHHIFbIndZSCrWpseo29r1J9dWChPJlaw2Bs1RP
 HZt8pM6Q7VkZzmsRcEYWSCPwIRs9c0XIy0zWbZqgpdjEog9ovUeLWpK00ENuVAm2EXd3
 HnWQ==
X-Gm-Message-State: AOJu0YyCv6dSReSqF++1UE7SiFUnRzClzC5eIh6wpvpzh2n0ca84/mPP
 oXrE8JeZSTQoH0Tez5V2vjfu1adUHMkn3rusucQmdjSYxeNTeCw242az5yz+m5CDX1o=
X-Gm-Gg: AfdE7cmVqNaQqkjrNNVwiLH2uqb4aYop8sR12qumsv5HYhk/x78KYL7sVMKJjBKqFD6
 hrRyS28mhKdvmvEDTVmNNBJE5dQn3t2FS/ali+yq1KPZNQwSMRy2clNHaPoQqDzF+1ZeTP1VOcs
 Xn/vp0G6po/R92Kc7ad4V0CQgTqUd6RhYQD2M1Tnvj92dRxlvkLJoe4B4F2zFYlCangt9xNdZgG
 AyFxk577N0N0cyCEgVaaqnVHNC1zE2LsZcXRjsQ4idksQ0DRIC65/JannIjmw3dgXw2MB43Amn5
 EeZXbTXIcEAkqkCwur5fozJH5GSj2dBkO/drbtCkov+WhyXfYkt/vWh6NOOvaZTwjD+cIaVCIBy
 RBDVgoMK2smhM63rOJEnSocy4MjJqomkT+ktVDebp0z343ypZqW+JE4Yjin1swBKQXUZT4922xy
 45k4X/82ll9eadC94HhpAb3ZzuEQMdA7sRF0KqGkttegbs/6Okp0pMlNz9Tsoh/FX93FsC9a7uH
 dWkc+c6Q5z3lomTh3upy0t6O0ITzTdJHwC5qzx7n1pfArWxTbkNHJBKE7wmViBkAKpxunVZ
X-Received: by 2002:a05:600d:8443:10b0:493:e79e:da9e with SMTP id
 5b1f17b1804b1-49538a0f458mr57860775e9.29.1784125726054; 
 Wed, 15 Jul 2026 07:28:46 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:45 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:47 +0200
Subject: [PATCH v2 19/32] clk: mediatek: mt8516: deduplicate clock gate drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-19-23e907516010@baylibre.com>
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

Describe the topckgen clock gates directly in a struct mtk_clk_tree,
reference the tree from the driver data and use the generic
mtk_clk_topckgen_ops instead of the dedicated clock gate ops.

This stops using mtk_common_clk_gate_init() and struct mtk_cg_priv, which
are scheduled for removal.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8516.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 9c510005b42..53e32d12445 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -770,6 +770,8 @@ static const struct mtk_clk_tree mt8516_topckgen_clk_tree = {
 static const struct mtk_clk_tree mt8516_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = top_clks,
+	.num_gates = ARRAY_SIZE(top_clks),
 };
 
 static int mt8516_apmixedsys_probe(struct udevice *dev)
@@ -782,10 +784,11 @@ static int mt8516_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt8516_topckgen_clk_tree);
 }
 
-static int mt8516_topckgen_cg_probe(struct udevice *dev)
+static int mt8516_clk_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8516_clk_tree, top_clks,
-					ARRAY_SIZE(top_clks), 0);
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
+
+	return mtk_common_clk_init(dev, tree);
 }
 
 static const struct udevice_id mt8516_apmixed_compat[] = {
@@ -799,7 +802,10 @@ static const struct udevice_id mt8516_topckgen_compat[] = {
 };
 
 static const struct udevice_id mt8516_topckgen_cg_compat[] = {
-	{ .compatible = "mediatek,mt8516-topckgen-cg", },
+	{
+		.compatible = "mediatek,mt8516-topckgen-cg",
+		.data = (ulong)&mt8516_clk_tree
+	},
 	{ }
 };
 
@@ -829,8 +835,8 @@ U_BOOT_DRIVER(mt8516_clk_topckgen_cg) = {
 	.name = "mt8516-topckgen-cg",
 	.id = UCLASS_CLK,
 	.of_match = mt8516_topckgen_cg_compat,
-	.probe = mt8516_topckgen_cg_probe,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.probe = mt8516_clk_probe,
+	.priv_auto	= sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };

-- 
2.54.0

