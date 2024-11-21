Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8B5D6ED11
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 12:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 933CE89776;
	Thu, 21 Nov 2024 13:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sDYBMVmn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD03A89775; Thu, 21 Nov 2024 13:03:13 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 437678975E
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 13:03:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ALC38eI128803;
 Thu, 21 Nov 2024 06:03:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732190588;
 bh=bQaMnmJI9vnFqLhHHWhv0FD7lj5Mzh9dutuH1FLKTeA=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=sDYBMVmnZvYQcGJxMRsFVwHEgfxg3O2ySzFA5jpWv/1434JiRTY6PdtyXSchIhHIf
 JbWu5hJw+mj4y2ct5S3n02pvZLgmD21J7EYkefgALcNvdCbUubSS7NX2zIFbe9M53G
 0VlFakotNk1k8HBjbHDFfN3LayMRHwRy6zypQoz0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ALC38Kj060969
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Nov 2024 06:03:08 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Nov 2024 06:03:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Nov 2024 06:03:07 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [172.24.227.240])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ALC2sLe007780;
 Thu, 21 Nov 2024 06:03:04 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 21 Nov 2024 17:32:53 +0530
Subject: [PATCH 3/3] clk: ti: clk-k3-pll: Add additional robustness steps
 to the PLL sequence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241121-b4-upstream-pll-fix-v1-3-904f618897a7@ti.com>
References: <20241121-b4-upstream-pll-fix-v1-0-904f618897a7@ti.com>
In-Reply-To: <20241121-b4-upstream-pll-fix-v1-0-904f618897a7@ti.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Vishal Mahaveer <vishalm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Chandru Dhavamani <chandru@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732190574; l=14538;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=iwpduXrZavJQ6Ve7iyoC8dRj7Ftlx6hRLplyqKvd7r0=;
 b=gMdaFj9FfEaE1bblMiuJyL9GNrCFNf9UZVZ5ozMScgPsb+IIsDc/9nQfE4zj7z+SojvhJNlc7
 8wnfck9VwjnCyUjjAyLbzppse5k0r2UjgUazRqQ5N0AtQBrjY7VXIOU
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

Based on the recommendation from HW team make modifications to
the sequence for more robustness.

- Unlock the PLL registers
- Enable external bypass
- Disable the PLL
- Program pllm and pllf
- Program Ref divider
- Enable other PLL controls like DSM_EN, DAC_EN,etc
- Enable calibration if available
- Enable PLL
- Wait for PLL lock and Calibration lock
- Remove external bypass

Re-write the full sequence from scratch as the previous sequence was way
off and keep it in a single commit for bisectability.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 drivers/clk/ti/clk-k3-pll.c | 327 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 261 insertions(+), 66 deletions(-)

diff --git a/drivers/clk/ti/clk-k3-pll.c b/drivers/clk/ti/clk-k3-pll.c
index 7c18767236c1e6967a436ec163bd3b8d15833bc0..b775bd55faab98db3c1a7b6093b5e9ff402a5050 100644
--- a/drivers/clk/ti/clk-k3-pll.c
+++ b/drivers/clk/ti/clk-k3-pll.c
@@ -14,6 +14,7 @@
 #include <linux/clk-provider.h>
 #include "k3-clk.h"
 #include <linux/rational.h>
+#include <linux/delay.h>
 
 /* 16FFT register offsets */
 #define PLL_16FFT_CFG			0x08
@@ -29,10 +30,12 @@
 
 /* CAL STAT register bits */
 #define PLL_16FFT_CAL_STAT_CAL_LOCK	BIT(31)
+#define PLL_16FFT_CAL_STAT_CAL_LOCK_TIMEOUT (4350U * 100U)
 
 /* CFG register bits */
 #define PLL_16FFT_CFG_PLL_TYPE_SHIFT	(0)
 #define PLL_16FFT_CFG_PLL_TYPE_MASK	(0x3 << 0)
+#define PLL_16FFT_CFG_PLL_TYPE_FRAC2	0
 #define PLL_16FFT_CFG_PLL_TYPE_FRACF	1
 
 /* CAL CTRL register bits */
@@ -41,14 +44,21 @@
 #define PLL_16FFT_CAL_CTRL_CAL_BYP              BIT(15)
 #define PLL_16FFT_CAL_CTRL_CAL_CNT_SHIFT        16
 #define PLL_16FFT_CAL_CTRL_CAL_CNT_MASK         (0x7 << 16)
+#define PLL_16FFT_CAL_CTRL_CAL_IN_MASK          (0xFFFU)
 
 /* CTRL register bits */
 #define PLL_16FFT_CTRL_BYPASS_EN	BIT(31)
+#define PLL_16FFT_CTRL_BYP_ON_LOCKLOSS	BIT(16)
 #define PLL_16FFT_CTRL_PLL_EN		BIT(15)
+#define PLL_16FFT_CTRL_INTL_BYP_EN	BIT(8)
+#define PLL_16FFT_CTRL_CLK_4PH_EN	BIT(5)
+#define PLL_16FFT_CTRL_CLK_POSTDIV_EN	BIT(4)
 #define PLL_16FFT_CTRL_DSM_EN		BIT(1)
+#define PLL_16FFT_CTRL_DAC_EN		BIT(0)
 
 /* STAT register bits */
 #define PLL_16FFT_STAT_LOCK		BIT(0)
+#define PLL_16FFT_STAT_LOCK_TIMEOUT	(150U * 100U)
 
 /* FREQ_CTRL0 bits */
 #define PLL_16FFT_FREQ_CTRL0_FB_DIV_INT_MASK	0xfff
@@ -62,7 +72,6 @@
 /* FREQ_CTRL1 bits */
 #define PLL_16FFT_FREQ_CTRL1_FB_DIV_FRAC_BITS	24
 #define PLL_16FFT_FREQ_CTRL1_FB_DIV_FRAC_MASK	0xffffff
-#define PLL_16FFT_FREQ_CTRL1_FB_DIV_FRAC_SHIFT	0
 
 /* KICK register magic values */
 #define PLL_KICK0_VALUE				0x68ef3490
@@ -80,63 +89,194 @@ struct ti_pll_clk {
 
 #define to_clk_pll(_clk) container_of(_clk, struct ti_pll_clk, clk)
 
-static int ti_pll_wait_for_lock(struct clk *clk)
+static int ti_pll_clk_disable(struct clk *clk)
 {
 	struct ti_pll_clk *pll = to_clk_pll(clk);
+	u32 ctrl;
+
+	ctrl = readl(pll->base + PLL_16FFT_CTRL);
+
+	if ((ctrl & PLL_16FFT_CTRL_PLL_EN)) {
+		ctrl &= ~PLL_16FFT_CTRL_PLL_EN;
+		writel(ctrl, pll->base + PLL_16FFT_CTRL);
+
+		/* wait 1us */
+		udelay(1);
+	}
+
+	return 0;
+}
+
+static int ti_pll_clk_enable(struct clk *clk)
+{
+	struct ti_pll_clk *pll = to_clk_pll(clk);
+	u32 ctrl;
+
+	ctrl = readl(pll->base + PLL_16FFT_CTRL);
+	ctrl |= PLL_16FFT_CTRL_PLL_EN;
+	writel(ctrl, pll->base + PLL_16FFT_CTRL);
+
+	/* Wait 1us */
+	udelay(1);
+
+	return 0;
+}
+
+static bool clk_pll_16fft_check_lock(const struct ti_pll_clk *pll)
+{
 	u32 stat;
+
+	stat = readl(pll->base + PLL_16FFT_STAT);
+	return (stat & PLL_16FFT_STAT_LOCK);
+}
+
+static bool clk_pll_16fft_check_cal_lock(const struct ti_pll_clk *pll)
+{
+	u32 stat;
+
+	stat = readl(pll->base + PLL_16FFT_CAL_STAT);
+	return (stat & PLL_16FFT_CAL_STAT_CAL_LOCK);
+}
+
+static void clk_pll_16fft_cal_int(const struct ti_pll_clk *pll)
+{
+	u32 cal;
+
+	cal = readl(pll->base + PLL_16FFT_CAL_CTRL);
+
+	/* Enable fast cal mode */
+	cal |= PLL_16FFT_CAL_CTRL_FAST_CAL;
+
+	/* Disable calibration bypass */
+	cal &= ~PLL_16FFT_CAL_CTRL_CAL_BYP;
+
+	/* Set CALCNT to 2 */
+	cal &= ~PLL_16FFT_CAL_CTRL_CAL_CNT_MASK;
+	cal |= 2 << PLL_16FFT_CAL_CTRL_CAL_CNT_SHIFT;
+
+	/* Set CAL_IN to 0 */
+	cal &= ~PLL_16FFT_CAL_CTRL_CAL_IN_MASK;
+
+	/* Note this register does not readback the written value. */
+	writel(cal, pll->base + PLL_16FFT_CAL_CTRL);
+
+	/* Wait 1us before enabling the CAL_EN field */
+	udelay(1);
+
+	cal = readl(pll->base + PLL_16FFT_CAL_CTRL);
+
+	/* Enable calibration for FRACF */
+	cal |= PLL_16FFT_CAL_CTRL_CAL_EN;
+
+	/* Note this register does not readback the written value. */
+	writel(cal, pll->base + PLL_16FFT_CAL_CTRL);
+}
+
+static void clk_pll_16fft_disable_cal(const struct ti_pll_clk *pll)
+{
+	u32 cal, stat;
+
+	cal = readl(pll->base + PLL_16FFT_CAL_CTRL);
+	cal &= ~PLL_16FFT_CAL_CTRL_CAL_EN;
+	/* Note this register does not readback the written value. */
+	writel(cal, pll->base + PLL_16FFT_CAL_CTRL);
+	do {
+		stat = readl(pll->base + PLL_16FFT_CAL_STAT);
+	} while (stat & PLL_16FFT_CAL_STAT_CAL_LOCK);
+}
+
+static int ti_pll_wait_for_lock(struct clk *clk)
+{
+	struct ti_pll_clk *pll = to_clk_pll(clk);
 	u32 cfg;
 	u32 cal;
 	u32 freq_ctrl1;
-	int i;
+	unsigned int i;
 	u32 pllfm;
 	u32 pll_type;
-	int success;
+	u32 cal_en = 0;
+	bool success;
 
-	for (i = 0; i < 100000; i++) {
-		stat = readl(pll->base + PLL_16FFT_STAT);
-		if (stat & PLL_16FFT_STAT_LOCK) {
-			success = 1;
+	/*
+	 * Minimum VCO input freq is 5MHz, and the longest a lock should
+	 * be consider to be timed out after 750 cycles. Be conservative
+	 * and assume each loop takes 10 cycles and we run at a
+	 * max of 1GHz. That gives 15000 loop cycles. We may end up waiting
+	 * longer than necessary for timeout, but that should be ok.
+	 */
+	success = false;
+	for (i = 0; i < PLL_16FFT_STAT_LOCK_TIMEOUT; i++) {
+		if (clk_pll_16fft_check_lock(pll)) {
+			success = true;
 			break;
 		}
 	}
 
-	/* Enable calibration if not in fractional mode of the FRACF PLL */
+	/* Disable calibration in the fractional mode of the FRACF PLL based on data
+	 * from silicon and simulation data.
+	 */
 	freq_ctrl1 = readl(pll->base + PLL_16FFT_FREQ_CTRL1);
 	pllfm = freq_ctrl1 & PLL_16FFT_FREQ_CTRL1_FB_DIV_FRAC_MASK;
-	pllfm >>= PLL_16FFT_FREQ_CTRL1_FB_DIV_FRAC_SHIFT;
+
 	cfg = readl(pll->base + PLL_16FFT_CFG);
 	pll_type = (cfg & PLL_16FFT_CFG_PLL_TYPE_MASK) >> PLL_16FFT_CFG_PLL_TYPE_SHIFT;
 
-	if (success && pll_type == PLL_16FFT_CFG_PLL_TYPE_FRACF && pllfm == 0) {
+	if (success && pll_type == PLL_16FFT_CFG_PLL_TYPE_FRACF) {
 		cal = readl(pll->base + PLL_16FFT_CAL_CTRL);
+		cal_en = (cal & PLL_16FFT_CAL_CTRL_CAL_EN);
+	}
 
-		/* Enable calibration for FRACF */
-		cal |= PLL_16FFT_CAL_CTRL_CAL_EN;
+	if (success && pll_type == PLL_16FFT_CFG_PLL_TYPE_FRACF &&
+	    pllfm == 0 && cal_en == 1) {
+		/*
+		 * Wait for calibration lock.
+		 *
+		 * Lock should occur within:
+		 *
+		 *	170 * 2^(5+CALCNT) / PFD
+		 *      21760 / PFD
+		 *
+		 * CALCNT = 2, PFD = 5-50MHz. This gives a range of 0.435mS to
+		 * 4.35mS depending on PFD frequency.
+		 *
+		 * Be conservative and assume each loop takes 10 cycles and we run at a
+		 * max of 1GHz. That gives 435000 loop cycles. We may end up waiting
+		 * longer than necessary for timeout, but that should be ok.
+		 *
+		 * The recommend timeout for CALLOCK to go high is 4.35 ms
+		 */
+		success = false;
+		for (i = 0; i < PLL_16FFT_CAL_STAT_CAL_LOCK_TIMEOUT; i++) {
+			if (clk_pll_16fft_check_cal_lock(pll)) {
+				success = true;
+				break;
+			}
+		}
 
-		/* Enable fast cal mode */
-		cal |= PLL_16FFT_CAL_CTRL_FAST_CAL;
+		/* In case of cal lock failure, operate without calibration */
+		if (!success) {
+			debug("Failure for calibration, falling back without calibration\n");
 
-		/* Disable calibration bypass */
-		cal &= ~PLL_16FFT_CAL_CTRL_CAL_BYP;
+			/* Disable PLL */
+			ti_pll_clk_disable(clk);
 
-		/* Set CALCNT to 2 */
-		cal &= ~PLL_16FFT_CAL_CTRL_CAL_CNT_MASK;
-		cal |= 2 << PLL_16FFT_CAL_CTRL_CAL_CNT_SHIFT;
+			/* Disable Calibration */
+			clk_pll_16fft_disable_cal(pll);
 
-		/* Note this register does not readback the written value. */
-		writel(cal, pll->base + PLL_16FFT_CAL_CTRL);
+			/* Enable PLL */
+			ti_pll_clk_enable(clk);
 
-		success = 0;
-		for (i = 0; i < 100000; i++) {
-			stat = readl(pll->base + PLL_16FFT_CAL_STAT);
-			if (stat & PLL_16FFT_CAL_STAT_CAL_LOCK) {
-				success = 1;
-				break;
+			/* Wait for PLL Lock */
+			for (i = 0; i < PLL_16FFT_STAT_LOCK_TIMEOUT; i++) {
+				if (clk_pll_16fft_check_lock(pll)) {
+					success = true;
+					break;
+				}
 			}
 		}
 	}
 
-	if (success == 0) {
+	if (!success) {
 		printf("%s: pll (%s) failed to lock\n", __func__,
 		       clk->dev->name);
 		return -EBUSY;
@@ -180,6 +320,30 @@ static ulong ti_pll_clk_get_rate(struct clk *clk)
 	return current_freq;
 }
 
+static bool ti_pll_clk_is_bypass(struct ti_pll_clk *pll)
+{
+	u32 ctrl;
+	bool ret;
+
+	ctrl = readl(pll->base + PLL_16FFT_CTRL);
+	ret = (ctrl & PLL_16FFT_CTRL_BYPASS_EN) != 0;
+
+	return ret;
+}
+
+static void ti_pll_clk_bypass(struct ti_pll_clk *pll, bool bypass)
+{
+	u32 ctrl;
+
+	ctrl = readl(pll->base + PLL_16FFT_CTRL);
+	if (bypass)
+		ctrl |= PLL_16FFT_CTRL_BYPASS_EN;
+	else
+		ctrl &= ~PLL_16FFT_CTRL_BYPASS_EN;
+
+	writel(ctrl, pll->base + PLL_16FFT_CTRL);
+}
+
 static ulong ti_pll_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct ti_pll_clk *pll = to_clk_pll(clk);
@@ -187,9 +351,13 @@ static ulong ti_pll_clk_set_rate(struct clk *clk, ulong rate)
 	u64 parent_freq = clk_get_parent_rate(clk);
 	int ret;
 	u32 ctrl;
+	u32 cfg;
+	u32 pll_type;
 	unsigned long pllm;
 	u32 pllfm = 0;
 	unsigned long plld;
+	u32 freq_ctrl0;
+	u32 freq_ctrl1;
 	u32 div_ctrl;
 	u32 rem;
 	int shift;
@@ -212,16 +380,22 @@ static ulong ti_pll_clk_set_rate(struct clk *clk, ulong rate)
 				break;
 		}
 
-	/* Put PLL to bypass mode */
-	ctrl = readl(pll->base + PLL_16FFT_CTRL);
-	ctrl |= PLL_16FFT_CTRL_BYPASS_EN;
-	writel(ctrl, pll->base + PLL_16FFT_CTRL);
+	if (!ti_pll_clk_is_bypass(pll)) {
+		/* Put the PLL into bypass */
+		ti_pll_clk_bypass(pll, true);
+	}
+
+	/* Disable the PLL */
+	ti_pll_clk_disable(clk);
 
 	if (rate == parent_freq) {
 		debug("%s: put %s to bypass\n", __func__, clk->dev->name);
 		return rate;
 	}
 
+	cfg = readl(pll->base + PLL_16FFT_CFG);
+	pll_type = (cfg & PLL_16FFT_CFG_PLL_TYPE_MASK) >> PLL_16FFT_CFG_PLL_TYPE_SHIFT;
+
 	debug("%s: pre-frac-calc: rate=%u, parent_freq=%u, plld=%u, pllm=%u\n",
 	      __func__, (u32)rate, (u32)parent_freq, (u32)plld, (u32)pllm);
 
@@ -237,31 +411,75 @@ static ulong ti_pll_clk_set_rate(struct clk *clk, ulong rate)
 		plld = 1;
 	}
 
-	if (pllfm)
-		ctrl |= PLL_16FFT_CTRL_DSM_EN;
-	else
-		ctrl &= ~PLL_16FFT_CTRL_DSM_EN;
+	/* Program the new rate */
+	freq_ctrl0 = readl(pll->base + PLL_16FFT_FREQ_CTRL0);
+	freq_ctrl1 = readl(pll->base + PLL_16FFT_FREQ_CTRL1);
+	div_ctrl = readl(pll->base + PLL_16FFT_DIV_CTRL);
 
-	writel(pllm, pll->base + PLL_16FFT_FREQ_CTRL0);
-	writel(pllfm, pll->base + PLL_16FFT_FREQ_CTRL1);
+	freq_ctrl0 &= ~PLL_16FFT_FREQ_CTRL0_FB_DIV_INT_MASK;
+	freq_ctrl0 |= pllm;
+
+	freq_ctrl1 &= ~PLL_16FFT_FREQ_CTRL1_FB_DIV_FRAC_MASK;
+	freq_ctrl1 |= pllfm;
 
 	/*
 	 * div_ctrl register contains other divider values, so rmw
 	 * only plld and leave existing values alone
 	 */
-	div_ctrl = readl(pll->base + PLL_16FFT_DIV_CTRL);
 	div_ctrl &= ~PLL_16FFT_DIV_CTRL_REF_DIV_MASK;
 	div_ctrl |= plld;
-	writel(div_ctrl, pll->base + PLL_16FFT_DIV_CTRL);
 
-	ctrl &= ~PLL_16FFT_CTRL_BYPASS_EN;
-	ctrl |= PLL_16FFT_CTRL_PLL_EN;
+	/* Make sure we have fractional support if required */
+	ctrl = readl(pll->base + PLL_16FFT_CTRL);
+
+	/* Don't use internal bypass,it is not glitch free. Always prefer glitchless bypass */
+	ctrl &= ~(PLL_16FFT_CTRL_INTL_BYP_EN | PLL_16FFT_CTRL_CLK_4PH_EN);
+
+	/* Always enable output if PLL,  Always bypass if we lose lock */
+	ctrl |= (PLL_16FFT_CTRL_CLK_POSTDIV_EN | PLL_16FFT_CTRL_BYP_ON_LOCKLOSS);
+
+	/* Enable fractional support if required */
+	if (pll_type == PLL_16FFT_CFG_PLL_TYPE_FRACF) {
+		if (pllfm != 0)
+			ctrl |= (PLL_16FFT_CTRL_DSM_EN | PLL_16FFT_CTRL_DAC_EN);
+		else
+			ctrl &= ~(PLL_16FFT_CTRL_DSM_EN | PLL_16FFT_CTRL_DAC_EN);
+	}
+
+	/* Enable Fractional by default for PLL_16FFT_CFG_PLL_TYPE_FRAC2 */
+	if (pll_type == PLL_16FFT_CFG_PLL_TYPE_FRAC2)
+		ctrl |= (PLL_16FFT_CTRL_DSM_EN | PLL_16FFT_CTRL_DAC_EN);
+
+	writel(freq_ctrl0, pll->base + PLL_16FFT_FREQ_CTRL0);
+	writel(freq_ctrl1, pll->base + PLL_16FFT_FREQ_CTRL1);
+	writel(div_ctrl, pll->base + PLL_16FFT_DIV_CTRL);
 	writel(ctrl, pll->base + PLL_16FFT_CTRL);
 
+	/* Configure PLL calibration*/
+	if (pll_type == PLL_16FFT_CFG_PLL_TYPE_FRACF) {
+		if (pllfm != 0) {
+			/* Disable Calibration in Fractional mode */
+			clk_pll_16fft_disable_cal(pll);
+		} else {
+			/* Enable Calibration in Integer mode */
+			clk_pll_16fft_cal_int(pll);
+		}
+	}
+
+	/*
+	 * Wait at least 1 ref cycle before enabling PLL.
+	 * Minimum VCO input frequency is 5MHz, therefore maximum
+	 * wait time for 1 ref clock is 0.2us.
+	 */
+	udelay(1);
+	ti_pll_clk_enable(clk);
+
 	ret = ti_pll_wait_for_lock(clk);
 	if (ret)
 		return ret;
 
+	ti_pll_clk_bypass(pll, false);
+
 	debug("%s: pllm=%u, plld=%u, pllfm=%u, parent_freq=%u\n",
 	      __func__, (u32)pllm, (u32)plld, (u32)pllfm, (u32)parent_freq);
 
@@ -279,30 +497,7 @@ static ulong ti_pll_clk_set_rate(struct clk *clk, ulong rate)
 	return current_freq;
 }
 
-static int ti_pll_clk_enable(struct clk *clk)
-{
-	struct ti_pll_clk *pll = to_clk_pll(clk);
-	u32 ctrl;
 
-	ctrl = readl(pll->base + PLL_16FFT_CTRL);
-	ctrl &= ~PLL_16FFT_CTRL_BYPASS_EN;
-	ctrl |= PLL_16FFT_CTRL_PLL_EN;
-	writel(ctrl, pll->base + PLL_16FFT_CTRL);
-
-	return ti_pll_wait_for_lock(clk);
-}
-
-static int ti_pll_clk_disable(struct clk *clk)
-{
-	struct ti_pll_clk *pll = to_clk_pll(clk);
-	u32 ctrl;
-
-	ctrl = readl(pll->base + PLL_16FFT_CTRL);
-	ctrl |= PLL_16FFT_CTRL_BYPASS_EN;
-	writel(ctrl, pll->base + PLL_16FFT_CTRL);
-
-	return 0;
-}
 
 static const struct clk_ops ti_pll_clk_ops = {
 	.get_rate = ti_pll_clk_get_rate,

-- 
2.46.0

