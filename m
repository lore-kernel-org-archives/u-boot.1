Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E76FC44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0705E84CA0;
	Wed, 15 Jul 2026 16:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="oZgwk9Os";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19DE184CA0; Wed, 15 Jul 2026 16:29:08 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B99E84CC7
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493f0ae9572so22965875e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125745; x=1784730545; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=14oEt287wHhv6KLsZfFu+R9nUUsRF11Te7LuTSuwzFM=;
 b=oZgwk9OsFk32qZwvRZI/5POe9mWTgh83kmvuIKVtUT8RkZvO0LuNM7pun2tGGtCslk
 0aMfVsDoJU8sp1WuktxkHj1f+nPE6kng5AiYtbXxGr00wMQnWXPFTCLxi1D0kT5bnp4d
 KfgFpV4wWboN2ANa0ySobFTmDyYBOOiO2mstmrhM5cIoexRdsfWBG6P5CPsZ6Y3X/xCK
 wMGSpESzhdf2BOO2Mjf2PI8rfSOqoNvAzYKazeIjTfwFrb54Y+dT9sDatJ9pmfW1GKvj
 4en3EqIZjt15FC9SBnFIlOrGSgLaKSchhdfLebae8rlh6dzQrYXunPWPQuWHw/h2ARK2
 FALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125745; x=1784730545;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=14oEt287wHhv6KLsZfFu+R9nUUsRF11Te7LuTSuwzFM=;
 b=RAYZlRA+lj3E023OOpu3aLf81gZhnKOqCLImYYubLw21MrCWb/1QtMXTSGdf6R/rvs
 ngt5vNbR229WqYtbwxgqVa80EvyVtvkPn/IG+xxQoIjwRcYGOlKLhE0/rKL9VU5MKtdI
 caCln0KStu0dw0+3qscy/hFIlIgWJUs9mUKoh9Xm/D6bWNON/g2rNiWFA8qjaI1nEvai
 PhHK1NWstK6gTQbWzNgQqWLrLrrO0fseTwae3HzKnBiV22t5weJssWZCv2bwQmb54g4r
 WPXvvk53Nj0Efrr9T4nn2LLHPVjDKqru2w5uEHMjuiuBNEUXz7FnQwN7JnfgHdoyaNcD
 6upQ==
X-Gm-Message-State: AOJu0YzdCRFI/IK0fiKn3GQZg3GsRpitkxF+/1OLBtJbeUIeOjq66s0U
 35zmfvBBbhzwpLSn8HYMZtbXAtBlrVtsETrz1UXsfO8FagdqyBbB2zO4RNQUwy/Zo7Kze70ndOK
 1/AJxMbQ=
X-Gm-Gg: AfdE7cmRwnupzNV588j9fL3FwgemPx96HULtVPg+KfJZFwOB4LhUVNwn/s5T1F8xoMT
 iyoWk/S6HPfkliZQK576xq1TgEtY5OfizBlrvEuI+149py0/qzhAtUxDRcVC4GJ3AQQISRZOD6j
 SWpC/Gh/EQ3WxtfKI2DkapthndjvQ2f27eLU6qQuq5mNStpn547RtKEodElCym4PvFbVPFG1I2E
 9MuVCj6Bgbmd6OrQy7o2KabYLyHAtNI0lBjNRXI7vt4iUxYI91T+FBkk9t1u/rIZUQaq6FgRC29
 pw0F1OU7mC4ibqLi5zIpj4ZF0NYZHKiobdY/KFWilUmNsWMIhns72FoIjduRepl3w2wULNaelpI
 qGop6WTUXzA5OLMN1lxZWNzWQrlIhLqd701dGaDqyX/pNalkq1c65KzdycQQ/kjXlC6lPKFQAfT
 8YYW7Wdja/l4NJ+oicyfn0RVUTOXSUBKaFvKnVnn00Z95unYRyMC7zLDZNI6TDVR79EGv0eubsj
 6fJW942jlC4xz3upnFH3CmpjZY4zjUqzlLTUyDUizItUvSvLM3i3c3f4oohChf8zJlFnyxKFJt5
 r+tHM9k=
X-Received: by 2002:a05:600c:6989:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-4953c1555a0mr34564755e9.11.1784125744637; 
 Wed, 15 Jul 2026 07:29:04 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:29:03 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:29:00 +0200
Subject: [PATCH v2 32/32] clk: mediatek: get the clock tree from the driver
 data in mtk_common_clk_init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-32-23e907516010@baylibre.com>
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

Every clock driver now stores its struct mtk_clk_tree in the compatible
data. Make mtk_common_clk_init() fetch it from dev_get_driver_data() instead
of taking it as an argument, so it matches the driver .probe prototype and
can be used directly as the probe callback.

Drop all the per-SoC probe wrappers that only forwarded the driver data to
mtk_common_clk_init(), and point the corresponding drivers at
mtk_common_clk_init() directly. The few controllers that still need a
dedicated probe for SoC specific register tweaks (some apmixedsys and
topckgen instances) keep it, but now call the single-argument
mtk_common_clk_init().

This touches every MediaTek clock driver at once to keep the tree building
across the whole series.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 18 +++++-------------
 drivers/clk/mediatek/clk-mt7623.c | 18 +++++-------------
 drivers/clk/mediatek/clk-mt7629.c | 18 +++++-------------
 drivers/clk/mediatek/clk-mt7981.c | 18 +++++-------------
 drivers/clk/mediatek/clk-mt7986.c | 16 ++++------------
 drivers/clk/mediatek/clk-mt7987.c | 16 ++++------------
 drivers/clk/mediatek/clk-mt7988.c | 20 ++++++--------------
 drivers/clk/mediatek/clk-mt8183.c | 13 +++----------
 drivers/clk/mediatek/clk-mt8188.c | 13 +++----------
 drivers/clk/mediatek/clk-mt8189.c | 15 ++++-----------
 drivers/clk/mediatek/clk-mt8195.c | 13 +++----------
 drivers/clk/mediatek/clk-mt8365.c | 13 +++----------
 drivers/clk/mediatek/clk-mt8512.c | 13 +++----------
 drivers/clk/mediatek/clk-mt8516.c | 13 +++----------
 drivers/clk/mediatek/clk-mt8518.c | 13 +++----------
 drivers/clk/mediatek/clk-mtk.c    |  3 ++-
 drivers/clk/mediatek/clk-mtk.h    |  3 +--
 17 files changed, 62 insertions(+), 174 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 67c4c7d7618..21587b2a4be 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -699,10 +699,9 @@ static int mt7622_mcucfg_probe(struct udevice *dev)
 static int mt7622_apmixedsys_probe(struct udevice *dev)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 	int ret;
 
-	ret = mtk_common_clk_init(dev, tree);
+	ret = mtk_common_clk_init(dev);
 	if (ret)
 		return ret;
 
@@ -716,13 +715,6 @@ static int mt7622_apmixedsys_probe(struct udevice *dev)
 	return 0;
 }
 
-static int mt7622_clk_probe(struct udevice *dev)
-{
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
-
-	return mtk_common_clk_init(dev, tree);
-}
-
 static int mt7622_reset_bind(struct udevice *dev)
 {
 	int ret = 0;
@@ -817,7 +809,7 @@ U_BOOT_DRIVER(mt7622_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7622_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7622_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -827,7 +819,7 @@ U_BOOT_DRIVER(mt7622_clk_infracfg) = {
 	.name = "mt7622-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = of_match_mt7622_infracfg,
-	.probe = mt7622_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -837,7 +829,7 @@ U_BOOT_DRIVER(mt7622_clk_eth) = {
 	.name = "mt7622-clk-eth",
 	.id = UCLASS_CLK,
 	.of_match = of_match_mt7622_clk_eth,
-	.probe = mt7622_clk_probe,
+	.probe = mtk_common_clk_init,
 	.bind = mt7622_reset_bind,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -847,7 +839,7 @@ U_BOOT_DRIVER(mt7622_clk) = {
 	.name = "mt7622-clk",
 	.id = UCLASS_CLK,
 	.of_match = of_match_mt7622_clk,
-	.probe = mt7622_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 };
diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 80bb4d8f16c..7a91ef9761c 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -1045,10 +1045,9 @@ static int mt7623_mcucfg_probe(struct udevice *dev)
 static int mt7623_apmixedsys_probe(struct udevice *dev)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 	int ret;
 
-	ret = mtk_common_clk_init(dev, tree);
+	ret = mtk_common_clk_init(dev);
 	if (ret)
 		return ret;
 
@@ -1084,13 +1083,6 @@ static const struct mtk_clk_tree mt7623_ethsys_tree = {
 	.num_gates = ARRAY_SIZE(eth_cgs),
 };
 
-static int mt7623_clk_probe(struct udevice *dev)
-{
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
-
-	return mtk_common_clk_init(dev, tree);
-}
-
 static const struct mtk_clk_tree mt7623_clk_peri_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
@@ -1190,7 +1182,7 @@ U_BOOT_DRIVER(mt7623_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7623_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7623_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -1200,7 +1192,7 @@ U_BOOT_DRIVER(mt7623_clk_infracfg) = {
 	.name = "mt7623-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7623_infracfg_compat,
-	.probe = mt7623_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -1210,7 +1202,7 @@ U_BOOT_DRIVER(mt7623_clk_pericfg) = {
 	.name = "mt7623-pericfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7623_pericfg_compat,
-	.probe = mt7623_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -1220,7 +1212,7 @@ U_BOOT_DRIVER(mt7623_clk_eth) = {
 	.name = "mt7623-clk-eth",
 	.id = UCLASS_CLK,
 	.of_match = of_match_mt7623_clk_eth,
-	.probe = mt7623_clk_probe,
+	.probe = mtk_common_clk_init,
 	.bind = mt7623_ethsys_hifsys_bind,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 4bacabc8556..433036980c0 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -654,10 +654,9 @@ static int mt7629_mcucfg_probe(struct udevice *dev)
 static int mt7629_apmixedsys_probe(struct udevice *dev)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 	int ret;
 
-	ret = mtk_common_clk_init(dev, tree);
+	ret = mtk_common_clk_init(dev);
 	if (ret)
 		return ret;
 
@@ -669,13 +668,6 @@ static int mt7629_apmixedsys_probe(struct udevice *dev)
 	return 0;
 }
 
-static int mt7629_clk_probe(struct udevice *dev)
-{
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
-
-	return mtk_common_clk_init(dev, tree);
-}
-
 static int mt7629_ethsys_bind(struct udevice *dev)
 {
 	int ret = 0;
@@ -766,7 +758,7 @@ U_BOOT_DRIVER(mt7629_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7629_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7629_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -776,7 +768,7 @@ U_BOOT_DRIVER(mt7629_clk_infracfg) = {
 	.name = "mt7629-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = of_match_mt7629_infracfg,
-	.probe = mt7629_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -786,7 +778,7 @@ U_BOOT_DRIVER(mt7629_clk_ethsys) = {
 	.name = "mt7629-clock-ethsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7629_ethsys_compat,
-	.probe = mt7629_clk_probe,
+	.probe = mtk_common_clk_init,
 	.bind = mt7629_ethsys_bind,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -796,7 +788,7 @@ U_BOOT_DRIVER(mt7629_clk) = {
 	.name = "mt7629-clk",
 	.id = UCLASS_CLK,
 	.of_match = of_match_mt7629_clk,
-	.probe = mt7629_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 };
diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index b1e08cd2dd0..b3bc95d01cb 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -656,13 +656,6 @@ static const struct mtk_clk_tree mt7981_infracfg_clk_tree = {
 	.type = MTK_CLK_TREE_INFRASYS,
 };
 
-static int mt7981_clk_probe(struct udevice *dev)
-{
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
-
-	return mtk_common_clk_init(dev, tree);
-}
-
 static const struct udevice_id mt7981_fixed_pll_compat[] = {
 	{
 		.compatible = "mediatek,mt7981-fixed-plls",
@@ -686,12 +679,11 @@ static const struct udevice_id mt7981_topckgen_compat[] = {
 static int mt7981_topckgen_probe(struct udevice *dev)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 
 	priv->base = dev_read_addr_ptr(dev);
 	writel(MT7981_CLK_PDN_EN_WRITE, priv->base + MT7981_CLK_PDN);
 
-	return mtk_common_clk_init(dev, tree);
+	return mtk_common_clk_init(dev);
 }
 
 U_BOOT_DRIVER(mt7981_clk_apmixedsys) = {
@@ -699,7 +691,7 @@ U_BOOT_DRIVER(mt7981_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7981_fixed_pll_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7981_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -729,7 +721,7 @@ U_BOOT_DRIVER(mt7981_clk_infracfg) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7981_infracfg_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7981_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -793,7 +785,7 @@ U_BOOT_DRIVER(mt7981_clk_sgmiisys) = {
 	.name = "mt7981-clock-sgmiisys",
 	.id = UCLASS_CLK,
 	.of_match = of_match_mt7981_sgmiisys,
-	.probe = mt7981_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 };
@@ -851,7 +843,7 @@ U_BOOT_DRIVER(mt7981_clk_ethsys) = {
 	.name = "mt7981-clock-ethsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7981_ethsys_compat,
-	.probe = mt7981_clk_probe,
+	.probe = mtk_common_clk_init,
 	.bind = mt7981_ethsys_bind,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 23642eba40a..c29cddf954a 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -564,13 +564,6 @@ static const struct mtk_clk_tree mt7986_infracfg_clk_tree = {
 	.type = MTK_CLK_TREE_INFRASYS,
 };
 
-static int mt7986_clk_probe(struct udevice *dev)
-{
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
-
-	return mtk_common_clk_init(dev, tree);
-}
-
 static const struct udevice_id mt7986_fixed_pll_compat[] = {
 	{
 		.compatible = "mediatek,mt7986-fixed-plls",
@@ -594,12 +587,11 @@ static const struct udevice_id mt7986_topckgen_compat[] = {
 static int mt7986_topckgen_probe(struct udevice *dev)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 
 	priv->base = dev_read_addr_ptr(dev);
 	writel(MT7986_CLK_PDN_EN_WRITE, priv->base + MT7986_CLK_PDN);
 
-	return mtk_common_clk_init(dev, tree);
+	return mtk_common_clk_init(dev);
 }
 
 U_BOOT_DRIVER(mt7986_clk_apmixedsys) = {
@@ -607,7 +599,7 @@ U_BOOT_DRIVER(mt7986_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7986_fixed_pll_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7986_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -637,7 +629,7 @@ U_BOOT_DRIVER(mt7986_clk_infracfg) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7986_infracfg_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7986_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -695,7 +687,7 @@ U_BOOT_DRIVER(mt7986_clk_ethsys) = {
 	.name = "mt7986-clock-ethsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7986_ethsys_compat,
-	.probe = mt7986_clk_probe,
+	.probe = mtk_common_clk_init,
 	.bind = mt7986_ethsys_bind,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index 3f5709fbe22..43d880f47d8 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -53,13 +53,6 @@ static const struct mtk_fixed_clk apmixedsys_mtk_plls[] = {
 	FIXED_CLK0(CLK_APMIXED_MSDCPLL, 384000000),
 };
 
-static int mt7987_clk_probe(struct udevice *dev)
-{
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
-
-	return mtk_common_clk_init(dev, tree);
-}
-
 static const struct mtk_clk_tree mt7987_fixed_pll_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
@@ -87,7 +80,7 @@ U_BOOT_DRIVER(mt7987_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7987_fixed_pll_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7987_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -481,14 +474,13 @@ static const struct udevice_id mt7987_topckgen_compat[] = {
 static int mt7987_topckgen_probe(struct udevice *dev)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 
 	priv->base = dev_read_addr_ptr(dev);
 	if (!priv->base)
 		return -ENOENT;
 
 	writel(MT7987_CLK_PDN_EN_WRITE, priv->base + MT7987_CLK_PDN);
-	return mtk_common_clk_init(dev, tree);
+	return mtk_common_clk_init(dev);
 }
 
 U_BOOT_DRIVER(mt7987_clk_topckgen) = {
@@ -819,7 +811,7 @@ U_BOOT_DRIVER(mt7987_clk_infracfg) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7987_infracfg_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7987_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -878,7 +870,7 @@ U_BOOT_DRIVER(mt7987_clk_ethsys) = {
 	.name = "mt7987-clock-ethsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7987_ethsys_compat,
-	.probe = mt7987_clk_probe,
+	.probe = mtk_common_clk_init,
 	.bind = mt7987_ethsys_bind,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 31aa47e8bb8..02ccf111192 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -838,13 +838,6 @@ static const struct mtk_clk_tree mt7988_infracfg_clk_tree = {
 	.type = MTK_CLK_TREE_INFRASYS,
 };
 
-static int mt7988_clk_probe(struct udevice *dev)
-{
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
-
-	return mtk_common_clk_init(dev, tree);
-}
-
 static const struct udevice_id mt7988_fixed_pll_compat[] = {
 	{
 		.compatible = "mediatek,mt7988-fixed-plls",
@@ -868,14 +861,13 @@ static const struct udevice_id mt7988_topckgen_compat[] = {
 static int mt7988_topckgen_probe(struct udevice *dev)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 
 	priv->base = dev_read_addr_ptr(dev);
 	if (!priv->base)
 		return -ENOENT;
 
 	writel(MT7988_CLK_PDN_EN_WRITE, priv->base + MT7988_CLK_PDN);
-	return mtk_common_clk_init(dev, tree);
+	return mtk_common_clk_init(dev);
 }
 
 U_BOOT_DRIVER(mt7988_clk_apmixedsys) = {
@@ -883,7 +875,7 @@ U_BOOT_DRIVER(mt7988_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7988_fixed_pll_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7988_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -913,7 +905,7 @@ U_BOOT_DRIVER(mt7988_clk_infracfg) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7988_infracfg_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7988_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -970,7 +962,7 @@ U_BOOT_DRIVER(mt7988_clk_ethdma) = {
 	.name = "mt7988-clock-ethdma",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_ethdma_compat,
-	.probe = mt7988_clk_probe,
+	.probe = mtk_common_clk_init,
 	.bind = mt7988_ethdma_bind,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -1050,7 +1042,7 @@ U_BOOT_DRIVER(mt7988_clk_sgmiisys) = {
 	.name = "mt7988-clock-sgmiisys",
 	.id = UCLASS_CLK,
 	.of_match = of_match_mt7988_sgmiisys,
-	.probe = mt7988_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 };
@@ -1111,7 +1103,7 @@ U_BOOT_DRIVER(mt7988_clk_ethwarp) = {
 	.name = "mt7988-clock-ethwarp",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_ethwarp_compat,
-	.probe = mt7988_clk_probe,
+	.probe = mtk_common_clk_init,
 	.bind = mt7988_ethwarp_bind,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 5a7817ba77c..94f2fe38ed9 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -627,13 +627,6 @@ static const struct mtk_clk_tree mt8183_topckgen_clk_tree = {
 	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
-static int mt8183_clk_probe(struct udevice *dev)
-{
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
-
-	return mtk_common_clk_init(dev, tree);
-}
-
 static const struct mtk_gate_regs infra0_cg_regs = {
 	.set_ofs = 0x80,
 	.clr_ofs = 0x84,
@@ -830,7 +823,7 @@ U_BOOT_DRIVER(mt8183_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8183_apmixed_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8183_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -841,7 +834,7 @@ U_BOOT_DRIVER(mt8183_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8183_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8183_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -851,7 +844,7 @@ U_BOOT_DRIVER(mt8183_clk_infracfg) = {
 	.name = "mt8183-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt8183_infracfg_compat,
-	.probe = mt8183_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 3b4952db204..5e395eeec5e 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -1722,13 +1722,6 @@ const struct mtk_clk_tree mt8188_imp_iic_wrap_en_clk_tree = {
 	.num_gates = ARRAY_SIZE(imp_iic_wrap_en_clks),
 };
 
-static int mt8188_clk_probe(struct udevice *dev)
-{
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
-
-	return mtk_common_clk_init(dev, tree);
-}
-
 static const struct udevice_id mt8188_apmixed_compat[] = {
 	{
 		.compatible = "mediatek,mt8188-apmixedsys",
@@ -1775,7 +1768,7 @@ U_BOOT_DRIVER(mt8188_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8188_apmixed_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8188_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -1786,7 +1779,7 @@ U_BOOT_DRIVER(mt8188_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8188_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8188_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -1796,7 +1789,7 @@ U_BOOT_DRIVER(mt8188_clk) = {
 	.name = "mt8188-clk",
 	.id = UCLASS_CLK,
 	.of_match = of_match_mt8188_clk,
-	.probe = mt8188_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index 5600f9aae8d..024144b8edf 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -2022,19 +2022,12 @@ static const struct udevice_id of_match_mt8189_clk_gate[] = {
 	{ }
 };
 
-static int mt8189_clk_probe(struct udevice *dev)
-{
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
-
-	return mtk_common_clk_init(dev, tree);
-}
-
 U_BOOT_DRIVER(mt8189_clk_apmixedsys) = {
 	.name = "mt8189-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8189_apmixed,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8189_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -2045,7 +2038,7 @@ U_BOOT_DRIVER(mt8189_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8189_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8189_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -2056,7 +2049,7 @@ U_BOOT_DRIVER(mt8189_clk_vlpckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8189_vlpckgen,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8189_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -2066,7 +2059,7 @@ U_BOOT_DRIVER(mt8189_clk_gate) = {
 	.name = "mt8189-gate-clk",
 	.id = UCLASS_CLK,
 	.of_match = of_match_mt8189_clk_gate,
-	.probe = mt8189_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index 4a74c0d0b5b..080eded38d0 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -1603,13 +1603,6 @@ static const struct mtk_clk_tree mt8195_infracfg_ao_clk_tree = {
 	.num_gates = ARRAY_SIZE(infra_ao_clks),
 };
 
-static int mt8195_clk_probe(struct udevice *dev)
-{
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
-
-	return mtk_common_clk_init(dev, tree);
-}
-
 static const struct udevice_id mt8195_apmixed[] = {
 	{
 		.compatible = "mediatek,mt8195-apmixedsys",
@@ -1639,7 +1632,7 @@ U_BOOT_DRIVER(mt8195_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8195_apmixed,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8195_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -1650,7 +1643,7 @@ U_BOOT_DRIVER(mt8195_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8195_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8195_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -1660,7 +1653,7 @@ U_BOOT_DRIVER(mt8195_clk_infra_ao) = {
 	.name = "mt8195-infra_ao",
 	.id = UCLASS_CLK,
 	.of_match = of_match_clk_mt8195_infra_ao,
-	.probe = mt8195_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 2603aa46b20..70d29e6970b 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -761,13 +761,6 @@ static const struct mtk_clk_tree mt8365_infracfg_tree = {
 	.num_gates = ARRAY_SIZE(ifr_clks),
 };
 
-static int mt8365_clk_probe(struct udevice *dev)
-{
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
-
-	return mtk_common_clk_init(dev, tree);
-}
-
 static const struct udevice_id mt8365_apmixed_compat[] = {
 	{
 		.compatible = "mediatek,mt8365-apmixedsys",
@@ -797,7 +790,7 @@ U_BOOT_DRIVER(mt8365_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8365_apmixed_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8365_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -808,7 +801,7 @@ U_BOOT_DRIVER(mt8365_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8365_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8365_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -818,7 +811,7 @@ U_BOOT_DRIVER(mt8365_clk_infracfg) = {
 	.name = "mt8365-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt8365_infracfg_compat,
-	.probe = mt8365_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index 7895448f4e5..dc567402544 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -829,13 +829,6 @@ static const struct mtk_clk_tree mt8512_infracfg_tree = {
 	.num_gates = ARRAY_SIZE(infra_clks),
 };
 
-static int mt8512_clk_probe(struct udevice *dev)
-{
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
-
-	return mtk_common_clk_init(dev, tree);
-}
-
 static const struct udevice_id mt8512_apmixed_compat[] = {
 	{
 		.compatible = "mediatek,mt8512-apmixedsys",
@@ -869,7 +862,7 @@ U_BOOT_DRIVER(mt8512_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8512_apmixed_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8512_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -880,7 +873,7 @@ U_BOOT_DRIVER(mt8512_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8512_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8512_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -890,7 +883,7 @@ U_BOOT_DRIVER(mt8512_clk_gate) = {
 	.name = "mt8512-clk-gate",
 	.id = UCLASS_CLK,
 	.of_match = of_match_mt8512_clk_gate,
-	.probe = mt8512_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 35b04ed5429..2043009d9fe 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -774,13 +774,6 @@ static const struct mtk_clk_tree mt8516_clk_tree = {
 	.num_gates = ARRAY_SIZE(top_clks),
 };
 
-static int mt8516_clk_probe(struct udevice *dev)
-{
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
-
-	return mtk_common_clk_init(dev, tree);
-}
-
 static const struct udevice_id mt8516_apmixed_compat[] = {
 	{
 		.compatible = "mediatek,mt8516-apmixedsys",
@@ -810,7 +803,7 @@ U_BOOT_DRIVER(mt8516_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8516_apmixed_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8516_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -821,7 +814,7 @@ U_BOOT_DRIVER(mt8516_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8516_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8516_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -831,7 +824,7 @@ U_BOOT_DRIVER(mt8516_clk_topckgen_cg) = {
 	.name = "mt8516-topckgen-cg",
 	.id = UCLASS_CLK,
 	.of_match = mt8516_topckgen_cg_compat,
-	.probe = mt8516_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index f599a1869e6..81d0b701803 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -1530,13 +1530,6 @@ static const struct mtk_clk_tree mt8518_clk_tree = {
 	.num_gates = ARRAY_SIZE(top_clks),
 };
 
-static int mt8518_clk_probe(struct udevice *dev)
-{
-	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
-
-	return mtk_common_clk_init(dev, tree);
-}
-
 static const struct udevice_id mt8518_apmixed_compat[] = {
 	{
 		.compatible = "mediatek,mt8518-apmixedsys",
@@ -1566,7 +1559,7 @@ U_BOOT_DRIVER(mt8518_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8518_apmixed_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8518_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -1577,7 +1570,7 @@ U_BOOT_DRIVER(mt8518_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8518_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8518_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -1587,7 +1580,7 @@ U_BOOT_DRIVER(mt8518_clk_topckgen_cg) = {
 	.name = "mt8518-topckgen-cg",
 	.id = UCLASS_CLK,
 	.of_match = mt8518_topckgen_cg_compat,
-	.probe = mt8518_clk_probe,
+	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index a5e983c44ac..1da89b3cc48 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -1093,9 +1093,10 @@ int mtk_common_clk_parent_bind(struct udevice *dev)
 	return 0;
 }
 
-int mtk_common_clk_init(struct udevice *dev, const struct mtk_clk_tree *tree)
+int mtk_common_clk_init(struct udevice *dev)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 
 	priv->base = dev_read_addr_ptr(dev);
 	if (!priv->base)
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index a6251547ecc..d08ff24075d 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -290,7 +290,6 @@ extern const struct clk_ops mtk_clk_topckgen_ops;
 extern const struct clk_ops mtk_clk_infrasys_ops;
 
 int mtk_common_clk_parent_bind(struct udevice *dev);
-int mtk_common_clk_init(struct udevice *dev,
-			const struct mtk_clk_tree *tree);
+int mtk_common_clk_init(struct udevice *dev);
 
 #endif /* __DRV_CLK_MTK_H */

-- 
2.54.0

