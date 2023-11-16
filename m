Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5284C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 09:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 142CD87495;
	Thu, 16 Nov 2023 10:00:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lhR5xk6x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CF8F87490; Thu, 16 Nov 2023 10:00:01 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95BA887465
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 09:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9c3aec5f326so347225866b.1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 00:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700125190; x=1700729990; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jtv3SgvGRynGh7XD5GlCL/vSnLQmLYqUr+h60onF4I=;
 b=lhR5xk6xaljpQ5fbsDdBxdYe6XsU1yqLGMQuztQdegO58BqLHoz8ZCki5rN7yjxsnq
 4e8z5aZpTVvCJLg/SKEAL14rQag8d6pxTCfezF2YvHHQe6SMDvvHDEuFbIczaCsYH2zy
 DNO2c/YngJYTcoM8VpBu05lfu+Hh7xwUvgZLaCO6mqYH4EkyCiRiMGV9HJyLPQ03gOs2
 1AijQO/lZ6EOeecHnrh8kWlGJJHLmfUPEJco4D0Q1QXjSppBhiZf3WlpDvSmnLzMO1cj
 Xa9wWCr3CrDdk0pcKnMCucBZ8/M728C7KzwuhGazN0+hKjjbITYgz7Lyt6aXRlr3RZWY
 Igzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700125190; x=1700729990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jtv3SgvGRynGh7XD5GlCL/vSnLQmLYqUr+h60onF4I=;
 b=ddePGLii6C2GjAFk7VDKfIoYzQd0mt1UFnta2rufhMwdJOwkoo2whTzfuPgtf1NVpV
 quMrX7lFGIG2uS/NPqOEBoVfLYHDdiSYS0QYv8j0TTgLs4ro6bw4pbbaoZW9gfDSUpHT
 PlGDcLax1Rm3Xh4ikye7+2Msvi/I2Ge49IRaEuC6ae5HVoKJWp3bjFnKVOHa535UGPY/
 ViqpJg26ZNS9EiG4xDfNB0+HXEN46A7Q4Fd1cFeAn9GHEdB09cAK7THOusFyRHaGu9qJ
 Uxx5pFnVL1mTWYtsynBCuHoiGSoWCs3phb33VuYm/jriWrZvJov9nCPttzg/rZYjTOPB
 qcgQ==
X-Gm-Message-State: AOJu0Yy22G7UH4jnzExy5OV2wsA/Oi2Fkn8ZjBAlj3fhAKsqrXpSf1D9
 hQ1nvN9car2I9R1MCG+GBNw=
X-Google-Smtp-Source: AGHT+IGP0yQeTkkrqSjwSjbswUAKWrywtwWrjnR20YJwGKrmM9DE5i7ZgyTButeEX2/I/DNbBnTk+w==
X-Received: by 2002:a17:906:7157:b0:9e3:b158:6fb8 with SMTP id
 z23-20020a170906715700b009e3b1586fb8mr965422ejj.32.1700125190109; 
 Thu, 16 Nov 2023 00:59:50 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 o21-20020a170906601500b009e655c77a53sm8093259ejj.132.2023.11.16.00.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 00:59:49 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/3] ARM: tegra: clock: support get and set rate for simple
 PLL
Date: Thu, 16 Nov 2023 10:59:29 +0200
Message-Id: <20231116085931.411707-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231116085931.411707-1-clamor95@gmail.com>
References: <20231116085931.411707-1-clamor95@gmail.com>
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

Simple PLL clocks like PLLD2 were omitted since they do not share common
4 register structure with main clocks. Such clocks are contained in simple
PLL group. Only clock_start_pll function supported them. This patch expands
this support on clock_set_rate and clock_get_rate which should make
simple PLL clocks equal to main PLL clocks.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/clock.c          | 75 +++++++++++++++++++++-------
 arch/arm/mach-tegra/tegra114/clock.c | 15 ++++++
 arch/arm/mach-tegra/tegra124/clock.c | 12 +++--
 arch/arm/mach-tegra/tegra20/clock.c  | 15 ++++++
 arch/arm/mach-tegra/tegra210/clock.c | 15 ++++++
 arch/arm/mach-tegra/tegra30/clock.c  | 15 ++++++
 6 files changed, 126 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-tegra/clock.c b/arch/arm/mach-tegra/clock.c
index 966009f375..7f31630a23 100644
--- a/arch/arm/mach-tegra/clock.c
+++ b/arch/arm/mach-tegra/clock.c
@@ -128,14 +128,14 @@ unsigned long clock_start_pll(enum clock_id clkid, u32 divm, u32 divn,
 	struct clk_pll_simple *simple_pll = NULL;
 	u32 misc_data, data;
 
-	if (clkid < (enum clock_id)TEGRA_CLK_PLLS) {
+	if (clkid < (enum clock_id)TEGRA_CLK_PLLS)
 		pll = get_pll(clkid);
-	} else {
+	else
 		simple_pll = clock_get_simple_pll(clkid);
-		if (!simple_pll) {
-			debug("%s: Uknown simple PLL %d\n", __func__, clkid);
-			return 0;
-		}
+
+	if (!simple_pll && !pll) {
+		log_err("Unknown PLL id %d\n", clkid);
+		return 0;
 	}
 
 	/*
@@ -542,7 +542,8 @@ unsigned int __weak clk_m_get_rate(unsigned int parent_rate)
 
 unsigned clock_get_rate(enum clock_id clkid)
 {
-	struct clk_pll *pll;
+	struct clk_pll *pll = NULL;
+	struct clk_pll_simple *simple_pll = NULL;
 	u32 base, divm;
 	u64 parent_rate, rate;
 	struct clk_pll_info *pllinfo = &tegra_pll_info_table[clkid];
@@ -554,10 +555,20 @@ unsigned clock_get_rate(enum clock_id clkid)
 	if (clkid == CLOCK_ID_CLK_M)
 		return clk_m_get_rate(parent_rate);
 
-	pll = get_pll(clkid);
-	if (!pll)
+	if (clkid < (enum clock_id)TEGRA_CLK_PLLS)
+		pll = get_pll(clkid);
+	else
+		simple_pll = clock_get_simple_pll(clkid);
+
+	if (!simple_pll && !pll) {
+		log_err("Unknown PLL id %d\n", clkid);
 		return 0;
-	base = readl(&pll->pll_base);
+	}
+
+	if (pll)
+		base = readl(&pll->pll_base);
+	else
+		base = readl(&simple_pll->pll_base);
 
 	rate = parent_rate * ((base >> pllinfo->n_shift) & pllinfo->n_mask);
 	divm = (base >> pllinfo->m_shift) & pllinfo->m_mask;
@@ -599,12 +610,24 @@ unsigned clock_get_rate(enum clock_id clkid)
 int clock_set_rate(enum clock_id clkid, u32 n, u32 m, u32 p, u32 cpcon)
 {
 	u32 base_reg, misc_reg;
-	struct clk_pll *pll;
+	struct clk_pll *pll = NULL;
+	struct clk_pll_simple *simple_pll = NULL;
 	struct clk_pll_info *pllinfo = &tegra_pll_info_table[clkid];
 
-	pll = get_pll(clkid);
+	if (clkid < (enum clock_id)TEGRA_CLK_PLLS)
+		pll = get_pll(clkid);
+	else
+		simple_pll = clock_get_simple_pll(clkid);
+
+	if (!simple_pll && !pll) {
+		log_err("Unknown PLL id %d\n", clkid);
+		return 0;
+	}
 
-	base_reg = readl(&pll->pll_base);
+	if (pll)
+		base_reg = readl(&pll->pll_base);
+	else
+		base_reg = readl(&simple_pll->pll_base);
 
 	/* Set BYPASS, m, n and p to PLL_BASE */
 	base_reg &= ~(pllinfo->m_mask << pllinfo->m_shift);
@@ -631,21 +654,37 @@ int clock_set_rate(enum clock_id clkid, u32 n, u32 m, u32 p, u32 cpcon)
 	}
 
 	base_reg |= PLL_BYPASS_MASK;
-	writel(base_reg, &pll->pll_base);
+	if (pll)
+		writel(base_reg, &pll->pll_base);
+	else
+		writel(base_reg, &simple_pll->pll_base);
 
 	/* Set cpcon (KCP) to PLL_MISC */
-	misc_reg = readl(&pll->pll_misc);
+	if (pll)
+		misc_reg = readl(&pll->pll_misc);
+	else
+		misc_reg = readl(&simple_pll->pll_misc);
+
 	misc_reg &= ~(pllinfo->kcp_mask << pllinfo->kcp_shift);
 	misc_reg |= cpcon << pllinfo->kcp_shift;
-	writel(misc_reg, &pll->pll_misc);
+	if (pll)
+		writel(misc_reg, &pll->pll_misc);
+	else
+		writel(misc_reg, &simple_pll->pll_misc);
 
 	/* Enable PLL */
 	base_reg |= PLL_ENABLE_MASK;
-	writel(base_reg, &pll->pll_base);
+	if (pll)
+		writel(base_reg, &pll->pll_base);
+	else
+		writel(base_reg, &simple_pll->pll_base);
 
 	/* Disable BYPASS */
 	base_reg &= ~PLL_BYPASS_MASK;
-	writel(base_reg, &pll->pll_base);
+	if (pll)
+		writel(base_reg, &pll->pll_base);
+	else
+		writel(base_reg, &simple_pll->pll_base);
 
 	return 0;
 }
diff --git a/arch/arm/mach-tegra/tegra114/clock.c b/arch/arm/mach-tegra/tegra114/clock.c
index 8ad71f590f..9a8c10e3d6 100644
--- a/arch/arm/mach-tegra/tegra114/clock.c
+++ b/arch/arm/mach-tegra/tegra114/clock.c
@@ -768,6 +768,21 @@ void arch_timer_init(void)
 	debug("%s: TSC CNTCR = 0x%08X\n", __func__, val);
 }
 
+struct clk_pll_simple *clock_get_simple_pll(enum clock_id clkid)
+{
+	struct clk_rst_ctlr *clkrst =
+			(struct clk_rst_ctlr *)NV_PA_CLK_RST_BASE;
+
+	switch (clkid) {
+	case CLOCK_ID_XCPU:
+	case CLOCK_ID_EPCI:
+	case CLOCK_ID_SFROM32KHZ:
+		return &clkrst->crc_pll_simple[clkid - CLOCK_ID_FIRST_SIMPLE];
+	default:
+		return NULL;
+	}
+}
+
 struct periph_clk_init periph_clk_init_table[] = {
 	{ PERIPH_ID_SBC1, CLOCK_ID_PERIPH },
 	{ PERIPH_ID_SBC2, CLOCK_ID_PERIPH },
diff --git a/arch/arm/mach-tegra/tegra124/clock.c b/arch/arm/mach-tegra/tegra124/clock.c
index ca9549a318..ed8b6d9638 100644
--- a/arch/arm/mach-tegra/tegra124/clock.c
+++ b/arch/arm/mach-tegra/tegra124/clock.c
@@ -1189,10 +1189,16 @@ struct clk_pll_simple *clock_get_simple_pll(enum clock_id clkid)
 	struct clk_rst_ctlr *clkrst =
 			(struct clk_rst_ctlr *)NV_PA_CLK_RST_BASE;
 
-	if (clkid == CLOCK_ID_DP)
+	switch (clkid) {
+	case CLOCK_ID_XCPU:
+	case CLOCK_ID_EPCI:
+	case CLOCK_ID_SFROM32KHZ:
+		return &clkrst->crc_pll_simple[clkid - CLOCK_ID_FIRST_SIMPLE];
+	case CLOCK_ID_DP:
 		return &clkrst->plldp;
-
-	return NULL;
+	default:
+		return NULL;
+	}
 }
 
 struct periph_clk_init periph_clk_init_table[] = {
diff --git a/arch/arm/mach-tegra/tegra20/clock.c b/arch/arm/mach-tegra/tegra20/clock.c
index abd6e3917a..109b73bfbe 100644
--- a/arch/arm/mach-tegra/tegra20/clock.c
+++ b/arch/arm/mach-tegra/tegra20/clock.c
@@ -792,6 +792,21 @@ int tegra_plle_enable(void)
 	return 0;
 }
 
+struct clk_pll_simple *clock_get_simple_pll(enum clock_id clkid)
+{
+	struct clk_rst_ctlr *clkrst =
+			(struct clk_rst_ctlr *)NV_PA_CLK_RST_BASE;
+
+	switch (clkid) {
+	case CLOCK_ID_XCPU:
+	case CLOCK_ID_EPCI:
+	case CLOCK_ID_SFROM32KHZ:
+		return &clkrst->crc_pll_simple[clkid - CLOCK_ID_FIRST_SIMPLE];
+	default:
+		return NULL;
+	}
+}
+
 struct periph_clk_init periph_clk_init_table[] = {
 	{ PERIPH_ID_SPI1, CLOCK_ID_PERIPH },
 	{ PERIPH_ID_SBC1, CLOCK_ID_PERIPH },
diff --git a/arch/arm/mach-tegra/tegra210/clock.c b/arch/arm/mach-tegra/tegra210/clock.c
index 900537afbe..74817e0440 100644
--- a/arch/arm/mach-tegra/tegra210/clock.c
+++ b/arch/arm/mach-tegra/tegra210/clock.c
@@ -1266,6 +1266,21 @@ int tegra_plle_enable(void)
 	return 0;
 }
 
+struct clk_pll_simple *clock_get_simple_pll(enum clock_id clkid)
+{
+	struct clk_rst_ctlr *clkrst =
+			(struct clk_rst_ctlr *)NV_PA_CLK_RST_BASE;
+
+	switch (clkid) {
+	case CLOCK_ID_XCPU:
+	case CLOCK_ID_EPCI:
+	case CLOCK_ID_SFROM32KHZ:
+		return &clkrst->crc_pll_simple[clkid - CLOCK_ID_FIRST_SIMPLE];
+	default:
+		return NULL;
+	}
+}
+
 struct periph_clk_init periph_clk_init_table[] = {
 	{ PERIPH_ID_SBC1, CLOCK_ID_PERIPH },
 	{ PERIPH_ID_SBC2, CLOCK_ID_PERIPH },
diff --git a/arch/arm/mach-tegra/tegra30/clock.c b/arch/arm/mach-tegra/tegra30/clock.c
index 698c7ab956..7bbe70921f 100644
--- a/arch/arm/mach-tegra/tegra30/clock.c
+++ b/arch/arm/mach-tegra/tegra30/clock.c
@@ -871,6 +871,21 @@ int tegra_plle_enable(void)
 	return 0;
 }
 
+struct clk_pll_simple *clock_get_simple_pll(enum clock_id clkid)
+{
+	struct clk_rst_ctlr *clkrst =
+			(struct clk_rst_ctlr *)NV_PA_CLK_RST_BASE;
+
+	switch (clkid) {
+	case CLOCK_ID_XCPU:
+	case CLOCK_ID_EPCI:
+	case CLOCK_ID_SFROM32KHZ:
+		return &clkrst->crc_pll_simple[clkid - CLOCK_ID_FIRST_SIMPLE];
+	default:
+		return NULL;
+	}
+}
+
 struct periph_clk_init periph_clk_init_table[] = {
 	{ PERIPH_ID_SBC1, CLOCK_ID_PERIPH },
 	{ PERIPH_ID_SBC2, CLOCK_ID_PERIPH },
-- 
2.40.1

