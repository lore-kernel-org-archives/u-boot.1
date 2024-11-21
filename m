Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80342D6ED11
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 12:03:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D87789769;
	Thu, 21 Nov 2024 13:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fCaL1GJx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66BB98975F; Thu, 21 Nov 2024 13:03:11 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AA968976A
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 13:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ALC34Xn128792;
 Thu, 21 Nov 2024 06:03:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732190584;
 bh=yEYrQ/7pCYbhunqlYMq92iiJ+U2SmHYzoivOGttqoVQ=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=fCaL1GJxinITKPNlduYYuP+y5rogqCStZlsFAkMlsr95EVFZfU4MJGKkMfeLav0JT
 PCi+FM0P76Mrw0K4O3J08oLnW4G5zGPHugllosqfPMNCD7tyyRM9kVQ/6opqKGMQ/X
 BXiNhIbjWF3fDKaezEAStGhkR8uQJCKKg0mtw8qo=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ALC34cw023586;
 Thu, 21 Nov 2024 06:03:04 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Nov 2024 06:03:04 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Nov 2024 06:03:04 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [172.24.227.240])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ALC2sLd007780;
 Thu, 21 Nov 2024 06:03:01 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 21 Nov 2024 17:32:52 +0530
Subject: [PATCH 2/3] clk: ti: clk-k3-pll: Change variable name reg to base
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241121-b4-upstream-pll-fix-v1-2-904f618897a7@ti.com>
References: <20241121-b4-upstream-pll-fix-v1-0-904f618897a7@ti.com>
In-Reply-To: <20241121-b4-upstream-pll-fix-v1-0-904f618897a7@ti.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Vishal Mahaveer <vishalm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Chandru Dhavamani <chandru@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732190574; l=6401;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=CQmS2hZzyY4BOlwUNevFyZSj7IePJQvcbcHYJlmXjBo=;
 b=F/4Tpx6IWglsHzu1l5DxiDVkZDDep3KzazRcS4CuMjDhLXL21GJGr8szXxsyFEy+N3ciJfjx6
 7N695X3Wpx9Ax/k4EEFConcKlxc/B7bfIyllsHYS6QEFWin2TgJwfNm
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

base is more appropriate for the usage as the variable stores the base
address and seems more accurate w.r.t reg. Change reg to base.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 drivers/clk/ti/clk-k3-pll.c | 56 ++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/ti/clk-k3-pll.c b/drivers/clk/ti/clk-k3-pll.c
index b3a1b4cedb78f34af4ab9bf2b45639042a5d65ea..7c18767236c1e6967a436ec163bd3b8d15833bc0 100644
--- a/drivers/clk/ti/clk-k3-pll.c
+++ b/drivers/clk/ti/clk-k3-pll.c
@@ -75,7 +75,7 @@
  */
 struct ti_pll_clk {
 	struct clk	clk;
-	void __iomem	*reg;
+	void __iomem	*base;
 };
 
 #define to_clk_pll(_clk) container_of(_clk, struct ti_pll_clk, clk)
@@ -93,7 +93,7 @@ static int ti_pll_wait_for_lock(struct clk *clk)
 	int success;
 
 	for (i = 0; i < 100000; i++) {
-		stat = readl(pll->reg + PLL_16FFT_STAT);
+		stat = readl(pll->base + PLL_16FFT_STAT);
 		if (stat & PLL_16FFT_STAT_LOCK) {
 			success = 1;
 			break;
@@ -101,14 +101,14 @@ static int ti_pll_wait_for_lock(struct clk *clk)
 	}
 
 	/* Enable calibration if not in fractional mode of the FRACF PLL */
-	freq_ctrl1 = readl(pll->reg + PLL_16FFT_FREQ_CTRL1);
+	freq_ctrl1 = readl(pll->base + PLL_16FFT_FREQ_CTRL1);
 	pllfm = freq_ctrl1 & PLL_16FFT_FREQ_CTRL1_FB_DIV_FRAC_MASK;
 	pllfm >>= PLL_16FFT_FREQ_CTRL1_FB_DIV_FRAC_SHIFT;
-	cfg = readl(pll->reg + PLL_16FFT_CFG);
+	cfg = readl(pll->base + PLL_16FFT_CFG);
 	pll_type = (cfg & PLL_16FFT_CFG_PLL_TYPE_MASK) >> PLL_16FFT_CFG_PLL_TYPE_SHIFT;
 
 	if (success && pll_type == PLL_16FFT_CFG_PLL_TYPE_FRACF && pllfm == 0) {
-		cal = readl(pll->reg + PLL_16FFT_CAL_CTRL);
+		cal = readl(pll->base + PLL_16FFT_CAL_CTRL);
 
 		/* Enable calibration for FRACF */
 		cal |= PLL_16FFT_CAL_CTRL_CAL_EN;
@@ -124,11 +124,11 @@ static int ti_pll_wait_for_lock(struct clk *clk)
 		cal |= 2 << PLL_16FFT_CAL_CTRL_CAL_CNT_SHIFT;
 
 		/* Note this register does not readback the written value. */
-		writel(cal, pll->reg + PLL_16FFT_CAL_CTRL);
+		writel(cal, pll->base + PLL_16FFT_CAL_CTRL);
 
 		success = 0;
 		for (i = 0; i < 100000; i++) {
-			stat = readl(pll->reg + PLL_16FFT_CAL_STAT);
+			stat = readl(pll->base + PLL_16FFT_CAL_STAT);
 			if (stat & PLL_16FFT_CAL_STAT_CAL_LOCK) {
 				success = 1;
 				break;
@@ -156,14 +156,14 @@ static ulong ti_pll_clk_get_rate(struct clk *clk)
 	u32 ctrl;
 
 	/* Check if we are in bypass */
-	ctrl = readl(pll->reg + PLL_16FFT_CTRL);
+	ctrl = readl(pll->base + PLL_16FFT_CTRL);
 	if (ctrl & PLL_16FFT_CTRL_BYPASS_EN)
 		return parent_freq;
 
-	pllm = readl(pll->reg + PLL_16FFT_FREQ_CTRL0);
-	pllfm = readl(pll->reg + PLL_16FFT_FREQ_CTRL1);
+	pllm = readl(pll->base + PLL_16FFT_FREQ_CTRL0);
+	pllfm = readl(pll->base + PLL_16FFT_FREQ_CTRL1);
 
-	plld = readl(pll->reg + PLL_16FFT_DIV_CTRL) &
+	plld = readl(pll->base + PLL_16FFT_DIV_CTRL) &
 		PLL_16FFT_DIV_CTRL_REF_DIV_MASK;
 
 	current_freq = parent_freq * pllm / plld;
@@ -213,9 +213,9 @@ static ulong ti_pll_clk_set_rate(struct clk *clk, ulong rate)
 		}
 
 	/* Put PLL to bypass mode */
-	ctrl = readl(pll->reg + PLL_16FFT_CTRL);
+	ctrl = readl(pll->base + PLL_16FFT_CTRL);
 	ctrl |= PLL_16FFT_CTRL_BYPASS_EN;
-	writel(ctrl, pll->reg + PLL_16FFT_CTRL);
+	writel(ctrl, pll->base + PLL_16FFT_CTRL);
 
 	if (rate == parent_freq) {
 		debug("%s: put %s to bypass\n", __func__, clk->dev->name);
@@ -242,21 +242,21 @@ static ulong ti_pll_clk_set_rate(struct clk *clk, ulong rate)
 	else
 		ctrl &= ~PLL_16FFT_CTRL_DSM_EN;
 
-	writel(pllm, pll->reg + PLL_16FFT_FREQ_CTRL0);
-	writel(pllfm, pll->reg + PLL_16FFT_FREQ_CTRL1);
+	writel(pllm, pll->base + PLL_16FFT_FREQ_CTRL0);
+	writel(pllfm, pll->base + PLL_16FFT_FREQ_CTRL1);
 
 	/*
 	 * div_ctrl register contains other divider values, so rmw
 	 * only plld and leave existing values alone
 	 */
-	div_ctrl = readl(pll->reg + PLL_16FFT_DIV_CTRL);
+	div_ctrl = readl(pll->base + PLL_16FFT_DIV_CTRL);
 	div_ctrl &= ~PLL_16FFT_DIV_CTRL_REF_DIV_MASK;
 	div_ctrl |= plld;
-	writel(div_ctrl, pll->reg + PLL_16FFT_DIV_CTRL);
+	writel(div_ctrl, pll->base + PLL_16FFT_DIV_CTRL);
 
 	ctrl &= ~PLL_16FFT_CTRL_BYPASS_EN;
 	ctrl |= PLL_16FFT_CTRL_PLL_EN;
-	writel(ctrl, pll->reg + PLL_16FFT_CTRL);
+	writel(ctrl, pll->base + PLL_16FFT_CTRL);
 
 	ret = ti_pll_wait_for_lock(clk);
 	if (ret)
@@ -284,10 +284,10 @@ static int ti_pll_clk_enable(struct clk *clk)
 	struct ti_pll_clk *pll = to_clk_pll(clk);
 	u32 ctrl;
 
-	ctrl = readl(pll->reg + PLL_16FFT_CTRL);
+	ctrl = readl(pll->base + PLL_16FFT_CTRL);
 	ctrl &= ~PLL_16FFT_CTRL_BYPASS_EN;
 	ctrl |= PLL_16FFT_CTRL_PLL_EN;
-	writel(ctrl, pll->reg + PLL_16FFT_CTRL);
+	writel(ctrl, pll->base + PLL_16FFT_CTRL);
 
 	return ti_pll_wait_for_lock(clk);
 }
@@ -297,9 +297,9 @@ static int ti_pll_clk_disable(struct clk *clk)
 	struct ti_pll_clk *pll = to_clk_pll(clk);
 	u32 ctrl;
 
-	ctrl = readl(pll->reg + PLL_16FFT_CTRL);
+	ctrl = readl(pll->base + PLL_16FFT_CTRL);
 	ctrl |= PLL_16FFT_CTRL_BYPASS_EN;
-	writel(ctrl, pll->reg + PLL_16FFT_CTRL);
+	writel(ctrl, pll->base + PLL_16FFT_CTRL);
 
 	return 0;
 }
@@ -323,7 +323,7 @@ struct clk *clk_register_ti_pll(const char *name, const char *parent_name,
 	if (!pll)
 		return ERR_PTR(-ENOMEM);
 
-	pll->reg = reg;
+	pll->base = reg;
 
 	ret = clk_register(&pll->clk, "ti-pll-clk", name, parent_name);
 	if (ret) {
@@ -333,19 +333,19 @@ struct clk *clk_register_ti_pll(const char *name, const char *parent_name,
 	}
 
 	/* Unlock the PLL registers */
-	writel(PLL_KICK0_VALUE, pll->reg + PLL_KICK0);
-	writel(PLL_KICK1_VALUE, pll->reg + PLL_KICK1);
+	writel(PLL_KICK0_VALUE, pll->base + PLL_KICK0);
+	writel(PLL_KICK1_VALUE, pll->base + PLL_KICK1);
 
 	/* Enable all HSDIV outputs */
-	cfg = readl(pll->reg + PLL_16FFT_CFG);
+	cfg = readl(pll->base + PLL_16FFT_CFG);
 	for (i = 0; i < 16; i++) {
 		hsdiv_presence_bit = BIT(16 + i);
 		hsdiv_ctrl_offs = 0x80 + (i * 4);
 		/* Enable HSDIV output if present */
 		if ((hsdiv_presence_bit & cfg) != 0UL) {
-			ctrl = readl(pll->reg + hsdiv_ctrl_offs);
+			ctrl = readl(pll->base + hsdiv_ctrl_offs);
 			ctrl |= PLL_16FFT_HSDIV_CTRL_CLKOUT_EN;
-			writel(ctrl, pll->reg + hsdiv_ctrl_offs);
+			writel(ctrl, pll->base + hsdiv_ctrl_offs);
 		}
 	}
 

-- 
2.46.0

