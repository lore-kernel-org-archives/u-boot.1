Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638C9CDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FD8488FCB;
	Fri, 27 Sep 2024 00:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PxuUB75I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0180288FCA; Fri, 27 Sep 2024 00:42:03 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6131788F75
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-458366791aaso8329861cf.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390518; x=1727995318; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9akIqIJ2QY3zbd3ieLrogNS5ycQGIfe/Xfum9QndAJ8=;
 b=PxuUB75IcZ5kaI4bFFbKQTzqiTtx9/vKncDROlBFGo1Vl90MY4T5D0aZC2pusG6Ube
 BQDkfm6dt9J+ET17mo2j+L/ZlZxJaQLIG5KV9J7cGMWQlMULQfBlpJHzlDjjQ3ziW6Jd
 H2zIe1klP22l7g4M0WZuypjwDF8okLwqfxTaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390518; x=1727995318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9akIqIJ2QY3zbd3ieLrogNS5ycQGIfe/Xfum9QndAJ8=;
 b=OhRZJg763xzzHM4LJZyHIOA2J+OShkywcFrqbinr0zCxnkP/WcsIorFRvAAgUfXAe0
 liGYVxBU+ban0ffJMGDeEl2HU3hKaiYul60UHHfLPLBHhWG8Eq2/300srwxLAefiv+P+
 GAel0yDW/y4dwtr0/AHoSsoAKa2azPD9iNSE50Xz1lF5923aiu6no3q9Ng+084eBQVqb
 Uf04JWFQTuOc+6uOH6RKT+LaG+HpIQ/AL2EYckd04lLBGJkLhzx7kwXmAGf71MufzNVa
 b+NPKf8EgDImD28bfA3q940RN1QhgMB2iNCvajYPXivwQaUlWei6OnRhHlrZHAWattiL
 RbjQ==
X-Gm-Message-State: AOJu0YwSElRyv9docbL8OcqG6qY0ps0d15bZTW+1MPB+Grt6Cls5//rv
 G0jyHk7BxzNuv1oCYPB5V7rlJ285O1RYlnEfXa6K2zdphumumhd9nIhrIDlCLPXb3EYb5+3BJw3
 iVO4iv5g=
X-Google-Smtp-Source: AGHT+IHd3Ud1W2Mv4mTs+r5AsWVvXpthm4hk2UHySQ3RXegpv+me/ieESPb5hV4Kd0nUpyNynRQKjw==
X-Received: by 2002:ac8:5756:0:b0:458:1749:e195 with SMTP id
 d75a77b69052e-45c9f1b1fe4mr16299541cf.10.1727390518156; 
 Thu, 26 Sep 2024 15:41:58 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:41:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Tim Lunn <tim@feathertop.org>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 14/42] rockchip: Simplify check for SPL
Date: Fri, 27 Sep 2024 00:35:39 +0200
Message-ID: <20240926223814.1276764-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Now that SPL means SPL (only) and is not defined for TPL, simplify some
checks for SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/include/asm/arch-rockchip/boot0.h |  3 +--
 arch/arm/mach-rockchip/rk3399/rk3399.c     |  2 +-
 drivers/clk/rockchip/clk_rk3368.c          |  8 ++++----
 drivers/ram/rockchip/sdram_rk3288.c        | 10 +++++-----
 drivers/ram/rockchip/sdram_rk3399.c        |  2 +-
 drivers/ram/rockchip/sdram_rv1126.c        |  9 +++------
 6 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/boot0.h b/arch/arm/include/asm/arch-rockchip/boot0.h
index edb2a31c348..918f0495fa0 100644
--- a/arch/arm/include/asm/arch-rockchip/boot0.h
+++ b/arch/arm/include/asm/arch-rockchip/boot0.h
@@ -54,7 +54,6 @@ _start:
 	ARM_VECTORS
 #endif
 
-#if !defined(CONFIG_TPL_BUILD) && defined(CONFIG_XPL_BUILD) && \
-	(CONFIG_ROCKCHIP_SPL_RESERVE_IRAM > 0)
+#if defined(CONFIG_SPL_BUILD) && (CONFIG_ROCKCHIP_SPL_RESERVE_IRAM > 0)
 	.space CONFIG_ROCKCHIP_SPL_RESERVE_IRAM	/* space for the ATF data */
 #endif
diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index edccb2a3980..47bcc71038b 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -169,7 +169,7 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
+#if defined(CONFIG_SPL_BUILD)
 static void rk3399_force_power_on_reset(void)
 {
 	ofnode node;
diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
index 630253fbb1d..5ba19bce7b2 100644
--- a/drivers/clk/rockchip/clk_rk3368.c
+++ b/drivers/clk/rockchip/clk_rk3368.c
@@ -50,7 +50,7 @@ struct pll_div {
 		       (_nr * _no) == hz, #hz "Hz cannot be hit with PLL " \
 		       "divisors on line " __stringify(__LINE__));
 
-#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD)
 static const struct pll_div apll_l_init_cfg = PLL_DIVISORS(APLL_L_HZ, 12, 2);
 static const struct pll_div apll_b_init_cfg = PLL_DIVISORS(APLL_B_HZ, 1, 2);
 #if !defined(CONFIG_TPL_BUILD)
@@ -88,7 +88,7 @@ static uint32_t rkclk_pll_get_rate(struct rk3368_cru *cru,
 	}
 }
 
-#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD)
 static int rkclk_set_pll(struct rk3368_cru *cru, enum rk3368_pll_id pll_id,
 			 const struct pll_div *div)
 {
@@ -130,7 +130,7 @@ static int rkclk_set_pll(struct rk3368_cru *cru, enum rk3368_pll_id pll_id,
 }
 #endif
 
-#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD)
 static void rkclk_init(struct rk3368_cru *cru)
 {
 	u32 apllb, aplll, dpll, cpll, gpll;
@@ -586,7 +586,7 @@ static int rk3368_clk_probe(struct udevice *dev)
 
 	priv->cru = map_sysmem(plat->dtd.reg[0], plat->dtd.reg[1]);
 #endif
-#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD)
 	rkclk_init(priv->cru);
 #endif
 
diff --git a/drivers/ram/rockchip/sdram_rk3288.c b/drivers/ram/rockchip/sdram_rk3288.c
index 25ceab98ee9..b6d51068baa 100644
--- a/drivers/ram/rockchip/sdram_rk3288.c
+++ b/drivers/ram/rockchip/sdram_rk3288.c
@@ -84,7 +84,7 @@ const int ddrconf_table[] = {
 #define DQS_GATE_TRAINING_ERROR_RANK1	(2 << 4)
 
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
 static void copy_to_reg(u32 *dest, const u32 *src, u32 n)
 {
 	int i;
@@ -1041,7 +1041,7 @@ static int conv_of_plat(struct udevice *dev)
 static int rk3288_dmc_probe(struct udevice *dev)
 {
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
 	struct rk3288_sdram_params *plat = dev_get_plat(dev);
 	struct udevice *dev_clk;
 	struct regmap *map;
@@ -1051,7 +1051,7 @@ static int rk3288_dmc_probe(struct udevice *dev)
 
 	priv->pmu = syscon_get_first_range(ROCKCHIP_SYSCON_PMU);
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
 	ret = conv_of_plat(dev);
 	if (ret)
@@ -1119,13 +1119,13 @@ U_BOOT_DRIVER(rockchip_rk3288_dmc) = {
 	.of_match = rk3288_dmc_ids,
 	.ops = &rk3288_dmc_ops,
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
 	.of_to_plat = rk3288_dmc_of_to_plat,
 #endif
 	.probe = rk3288_dmc_probe,
 	.priv_auto	= sizeof(struct dram_info),
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
 	.plat_auto	= sizeof(struct rk3288_sdram_params),
 #endif
 };
diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index c3745f9445b..45270e27184 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -3196,7 +3196,7 @@ U_BOOT_DRIVER(dmc_rk3399) = {
 	.probe = rk3399_dmc_probe,
 	.priv_auto	= sizeof(struct dram_info),
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
 	.plat_auto	= sizeof(struct rockchip_dmc_plat),
 #endif
 };
diff --git a/drivers/ram/rockchip/sdram_rv1126.c b/drivers/ram/rockchip/sdram_rv1126.c
index b371f597d23..58fd589f68e 100644
--- a/drivers/ram/rockchip/sdram_rv1126.c
+++ b/drivers/ram/rockchip/sdram_rv1126.c
@@ -33,8 +33,7 @@
 #define DESKEW_MDF_DIFF_VAL		(1)
 
 struct dram_info {
-#if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
+#if defined(CONFIG_TPL_BUILD) || defined(CONFIG_SPL_BUILD)
 	void __iomem *pctl;
 	void __iomem *phy;
 	struct rv1126_cru *cru;
@@ -48,8 +47,7 @@ struct dram_info {
 	struct rv1126_pmugrf *pmugrf;
 };
 
-#if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
+#if defined(CONFIG_TPL_BUILD) || defined(CONFIG_SPL_BUILD)
 
 #define GRF_BASE_ADDR			0xfe000000
 #define PMU_GRF_BASE_ADDR		0xfe020000
@@ -3506,8 +3504,7 @@ error:
 
 static int rv1126_dmc_probe(struct udevice *dev)
 {
-#if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
+#if defined(CONFIG_TPL_BUILD) || defined(CONFIG_SPL_BUILD)
 	if (rv1126_dmc_init(dev))
 		return 0;
 #else
-- 
2.43.0

