Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6C5C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F293A84BF6;
	Wed, 15 Jul 2026 16:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="DSIoB/ba";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F1CF84B43; Wed, 15 Jul 2026 16:28:40 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A55B84BF6
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so38136025e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125718; x=1784730518; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VgimT/a1j6cgatTWcMtVzcvFAOiv5Xa7rKrbI40eqnw=;
 b=DSIoB/bau0/0beNT9vtLuf4pFkFakSOdIDFDOM4FlgG0rQnz7FZcwTsJSJVBs+U9fv
 QVvYsWFMtNQfABwDbCpAaC14KeaeJHPRROW9mN0ltvJfuHAWFVC8UKRjJvRt+b20vDW9
 Qyag12XK6qHB8y2/WwMdMu3tOpXAQ+k4OkddCdf464Lm7VGcnbjMYZ+POT5df09ETCRF
 uot6QSgumuESFy+YR2GKvHcl50CDW3tJJmq9Q8ckRsa9ADJQzmBd0dUhDkqTCrOI96zI
 hftLq0w8C4qJ1TGmTXxRcthTfYjXEss+xJ56yRKctllJhLV55ZVWU2xt8K1LpupAFMVJ
 YUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125718; x=1784730518;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VgimT/a1j6cgatTWcMtVzcvFAOiv5Xa7rKrbI40eqnw=;
 b=fVfgVzEW6WJ32TffskbvUUwUPJMoE/RaMTTRcbCz/YpnvrTZA0kN2Xu1GmYOszYNNe
 JbJ2nauLlh2g+GWJZNZxsb7zt4Exmd+blu9nZHq9BfGCgg80FBrvT+uMEDDyVNvE/lf9
 7YSDzIeQ2Uy7xsyNwEojqBXoXcPCbjfJeVmO4XmJBlLbcP81EAZBHnaWOkhkYAo4vjPO
 cE+7vgWAfcnqH2jsWTfHL5g7zPpNkhhuNMcX0EQePRoapJ67pyHBK07eTqd9u6hXzrOd
 o9Ez8Sq5/yK+EPOCGKAtIUYIotTtWaPlHsP7tzFmAR8SEMMp3zn71GJqQboI9giEaDA8
 D86A==
X-Gm-Message-State: AOJu0Yw7Z6aC8yjZiwxEvP2XfHAw2AZx0XAcm/oNi1Msq2Xjr+HNg2Vs
 R6krmXIpv6+x+3jVvyWxEKHWuqGH85ph0UqGaAlhw2qoC/O+cPLiY15KTj2h6Oc6UgE=
X-Gm-Gg: AfdE7cntmjaiqvP0FS2D8daeLPOcW5zJ1pazZChON4ksnVkXWY8XhZ44gPEclm3BLxZ
 myZ64avAW8kUV7PGXGH0K96sH6BmHbltWWHQByosBJ4bDSsvjzCyiIsgZbjwiN+FGuvJmKUI3RF
 e0EaDHgGKJHVpuWroOb+043OhjCyrcNlwiul5PkH2GWOKKaZ+67YoD6LTBC7YkosfxN/TW8NrrN
 UjIrHgKYMW5/ieue4ThwcABzRDtRq5K5+tom8gYO//z6v7S9pjQP7YjVG358oXTtAwJKvVmG1NE
 TOpJKxCUHMJXcvWma9NXrARu4/8X0NUZ4kBLx4YHN3ffTimVYQpXvgCliwjm9900nx1OP+anmlD
 4sybpXaAWnz0CCsxeLvd/si6idIdPqN0hLh0ESGnSOfxpt0+LRd7c76e3R8dUV1nrrMLxXebPLO
 jpGgdavN5PX3AbsuUsRU3AslPnIF7JjuS65eeN+MR5+VRorTBFez1q8qNyHLWSpqWdPILM/wuRB
 HdG49HfHcDoMICnvoLqC3qxhLChqm+V+xLS3iYqE478A2FiZW+UNVBG+/mSDCNLyrCsWaiY
X-Received: by 2002:a05:600c:46c7:b0:495:4044:11ff with SMTP id
 5b1f17b1804b1-49540441383mr5729055e9.33.1784125717544; 
 Wed, 15 Jul 2026 07:28:37 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:37 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:41 +0200
Subject: [PATCH v2 13/32] clk: mediatek: mt7987: deduplicate clock gate drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-13-23e907516010@baylibre.com>
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

Describe the ethsys gates directly in a struct mtk_clk_tree, reference the
tree from the driver data and use the generic mtk_clk_topckgen_ops instead
of the dedicated clock gate ops.

This stops using mtk_common_clk_gate_init() and struct mtk_cg_priv, which
are scheduled for removal.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7987.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index 4ac0c6faa94..1a2fd3453a9 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -53,6 +53,13 @@ static const struct mtk_fixed_clk apmixedsys_mtk_plls[] = {
 	FIXED_CLK0(CLK_APMIXED_MSDCPLL, 384000000),
 };
 
+static int mt7987_clk_probe(struct udevice *dev)
+{
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
+
+	return mtk_common_clk_init(dev, tree);
+}
+
 static const struct mtk_clk_tree mt7987_fixed_pll_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
@@ -462,11 +469,6 @@ static const struct mtk_clk_tree mt7987_topckgen_clk_tree = {
 	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
-static const struct mtk_clk_tree mt7987_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-};
-
 static const struct udevice_id mt7987_topckgen_compat[] = {
 	{ .compatible = "mediatek,mt7987-topckgen" },
 	{}
@@ -838,11 +840,12 @@ static const struct mtk_gate eth_cgs[] = {
 	GATE_ETH_TOP(CLK_ETHDMA_GP3_EN, "ethdma_gp3_en", CLK_TOP_NETSYS_500M_SEL, 10),
 };
 
-static int mt7987_ethsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7987_clk_tree, eth_cgs,
-					ARRAY_SIZE(eth_cgs), 0);
-}
+static const struct mtk_clk_tree mt7987_eth_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = eth_cgs,
+	.num_gates = ARRAY_SIZE(eth_cgs),
+};
 
 static int mt7987_ethsys_bind(struct udevice *dev)
 {
@@ -860,6 +863,7 @@ static int mt7987_ethsys_bind(struct udevice *dev)
 static const struct udevice_id mt7987_ethsys_compat[] = {
 	{
 		.compatible = "mediatek,mt7987-ethsys",
+		.data = (ulong)&mt7987_eth_clk_tree
 	},
 	{}
 };
@@ -868,8 +872,8 @@ U_BOOT_DRIVER(mt7987_clk_ethsys) = {
 	.name = "mt7987-clock-ethsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7987_ethsys_compat,
-	.probe = mt7987_ethsys_probe,
+	.probe = mt7987_clk_probe,
 	.bind = mt7987_ethsys_bind,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.priv_auto = sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 };

-- 
2.54.0

