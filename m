Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4D7C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 22:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D34C87AAB;
	Mon, 30 Oct 2023 23:23:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b4nJEl1k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B00558751B; Mon, 30 Oct 2023 23:23:38 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AA7687A3C
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 23:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40837ebba42so33418425e9.0
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 15:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698704615; x=1699309415; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jQTWfWQmfbn5y5C+RV517XLbwbTDBQrinL3vUDrd+jI=;
 b=b4nJEl1krrpT9/OekWxWHlSnN/GwQFtR/vglp9jTu8IU0rPCh5eZ+HZp2ICoVPIxUy
 4XksEbAWizfEa5x4Z5HqFVEmnZnczATGp5Z+hTZoaP14d/MpAm9eAE/mmdbTP+oV4uy+
 Ti4tCj6iBZ5bmnjxkcjDa2YszLuX5TTcIk/LmHhNawb9k8Vc6MpFQXmKzs+jeCpoZz9X
 K+2/9NEFgsYow3iTTnpXxDu3acMd1yO9URJK99x9zsQ2KLlf8FVZNLtasuaGnxb6DiGQ
 p7+HGsaORxby8aPW1Hogt7aOHY6HLch067X0Gx5NLSaHCqobi5/iOhQUTypl1fhG1Qpy
 H/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698704615; x=1699309415;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jQTWfWQmfbn5y5C+RV517XLbwbTDBQrinL3vUDrd+jI=;
 b=YJ3U/bsuAg4ohbq8fRfnyovwLivKHUTvSJm0r0P25Vu13m/G33ODAHY0oR67JDRnYq
 Dt0/Y60EAEFV+I3zBKKRrmYJCBPSBJP7zV8tsYFXv77aCuAPKRHCBjs+hhLZfGJBY77D
 siPFubpNr+7wbrEJoPzQ5Q36sQEyHqOP1ikfGY4dg3iuQp4uGIhg4lP9ctvR+ond51Zb
 7BXN8NdHWai3j4UbiyE0u749wfqOw9ziCrPMRgNA9esb1TMqmYISlql8VrgizuvKQJv9
 ta+GVPd2iKT7J1qxbn13sZcYCnWQ3Q3pbaTLbLwps7K0cNxCLwjiGe+tONSYBDOYmjmw
 6wdg==
X-Gm-Message-State: AOJu0YyELfWSH+0/yUoJ2l2RCqs8ayTJoRyINxhytb6CWmXUWIwjNUfX
 LWOC1D7DkJ4UeoRQFgKr6KI6tw==
X-Google-Smtp-Source: AGHT+IFssf9XHWB98ZG98Vejiufr/8tHnKSDTjNbALxgqZUgaQQMjCKCrCDn58Aq4Tk6M90TIYb7mQ==
X-Received: by 2002:a05:600c:198a:b0:408:40e2:773b with SMTP id
 t10-20020a05600c198a00b0040840e2773bmr9277210wmq.34.1698704614867; 
 Mon, 30 Oct 2023 15:23:34 -0700 (PDT)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 n20-20020a05600c465400b0040588d85b3asm6651wmo.15.2023.10.30.15.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 15:23:34 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 30 Oct 2023 22:23:29 +0000
Subject: [PATCH v2 7/7] clk/qcom: fix rcg divider value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-b4-qcom-clk-v2-7-6572bc2be690@linaro.org>
References: <20231024-b4-qcom-clk-v2-0-6572bc2be690@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v2-0-6572bc2be690@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=11065;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=SO5hC3N3HsKC/1M5lobGoZzSKjptCSpEhTtJw8HB3Ug=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlQHnfu8Ymp+v+6zBCzWabXR7QhWmM3zSmA2i8q1733Sr
 pUMSxZ3lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgIkUvWBkWPZ0prnEiYI7B00e
 3P8tMaFoHoPHBxs7k5+5ki9nfTv92oDhn6bc5sVb7smoXH7sqpV5z/Z3+s2D65exmR/ROXDfLZ+
 jYQ8A
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The RCG divider field takes a value of (2*h - 1) where h is the divisor.
This allows fractional dividers to be supported by calculating them at
compile time using a macro.

However, the clk_rcg_set_rate_mnd() function was also performing the
calculation. Clean this all up and consistently use the F() macro to
calculate these at compile time and properly support fractional divisors.

Additionally, improve clk_bcr_update() to timeout with a warning rather
than hanging the board, and make the freq_tbl struct and helpers common
so that they can be reused by future platforms.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-apq8016.c |  2 +-
 drivers/clk/qcom/clock-apq8096.c |  2 +-
 drivers/clk/qcom/clock-qcom.c    | 66 +++++++++++++++++++++++++++++-----------
 drivers/clk/qcom/clock-qcom.h    | 11 +++++++
 drivers/clk/qcom/clock-qcs404.c  | 16 +++++-----
 drivers/clk/qcom/clock-sdm845.c  | 26 ----------------
 6 files changed, 69 insertions(+), 54 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index 630619c83454..eb812934cbae 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -78,7 +78,7 @@ static struct vote_clk gcc_blsp1_ahb_clk = {
 /* SDHCI */
 static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
 {
-	int div = 8; /* 100MHz default */
+	int div = 15; /* 100MHz default */
 
 	if (rate == 200000000)
 		div = 4;
diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index 095c1b431245..55f16c14e046 100644
--- a/drivers/clk/qcom/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -65,7 +65,7 @@ static struct vote_clk gcc_blsp2_ahb_clk = {
 
 static int clk_init_sdc(struct msm_clk_priv *priv, uint rate)
 {
-	int div = 3;
+	int div = 5;
 
 	clk_enable_cbc(priv->base + SDCC2_AHB_CBCR);
 	clk_rcg_set_rate_mnd(priv->base, &sdc_regs, div, 0, 0,
diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index fc478554f982..58374d356942 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -12,6 +12,8 @@
  * Based on Little Kernel driver, simplified
  */
 
+#define LOG_DEBUG
+
 #include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
@@ -19,6 +21,8 @@
 #include <dm/lists.h>
 #include <errno.h>
 #include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/delay.h>
 #include <linux/bitops.h>
 #include <reset-uclass.h>
 
@@ -68,30 +72,42 @@ void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk)
 /* Update clock command via CMD_RCGR */
 void clk_bcr_update(phys_addr_t apps_cmd_rcgr)
 {
+	u32 count;
 	setbits_le32(apps_cmd_rcgr, APPS_CMD_RCGR_UPDATE);
 
 	/* Wait for frequency to be updated. */
-	while (readl(apps_cmd_rcgr) & APPS_CMD_RCGR_UPDATE)
-		;
+	for (count = 0; count < 50000; count++) {
+		if (!(readl(apps_cmd_rcgr) & APPS_CMD_RCGR_UPDATE))
+			break;
+		udelay(1);
+	}
+	WARN(count == 50000, "WARNING: RCG @ %#llx [%#010x] stuck at off\n",
+	     apps_cmd_rcgr, readl(apps_cmd_rcgr));
 }
 
-#define CFG_MODE_DUAL_EDGE (0x2 << 12) /* Counter mode */
+#define CFG_SRC_DIV_MASK	0b11111
+#define CFG_SRC_SEL_SHIFT	8
+#define CFG_SRC_SEL_MASK	(0x7 << CFG_SRC_SEL_SHIFT)
+#define CFG_MODE_SHIFT		12
+#define CFG_MODE_MASK		(0x3 << CFG_MODE_SHIFT)
+#define CFG_MODE_DUAL_EDGE	(0x2 << CFG_MODE_SHIFT)
+#define CFG_HW_CLK_CTRL_MASK	BIT(20)
 
-#define CFG_MASK 0x3FFF
-
-#define CFG_DIVIDER_MASK 0x1F
-
-/* root set rate for clocks with half integer and MND divider */
+/*
+ * root set rate for clocks with half integer and MND divider
+ * div should be pre-calculated ((div * 2) - 1)
+ */
 void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
 			  int div, int m, int n, int source, u8 mnd_width)
 {
 	u32 cfg;
 	/* M value for MND divider. */
 	u32 m_val = m;
+	u32 n_minus_m = n - m;
 	/* NOT(N-M) value for MND divider. */
-	u32 n_val = ~((n) - (m)) * !!(n);
+	u32 n_val = ~n_minus_m * !!(n);
 	/* NOT 2D value for MND divider. */
-	u32 d_val = ~(n);
+	u32 d_val = ~(clamp_t(u32, n, m, n_minus_m));
 	u32 mask = BIT(mnd_width) - 1;
 
 	debug("m %#x n %#x d %#x div %#x mask %#x\n", m_val, n_val, d_val, div, mask);
@@ -103,15 +119,13 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
 
 	/* setup src select and divider */
 	cfg  = readl(base + regs->cfg_rcgr);
-	cfg &= ~CFG_MASK;
-	cfg |= source & CFG_CLK_SRC_MASK; /* Select clock source */
+	cfg &= ~(CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK);
+	cfg |= source & CFG_SRC_SEL_MASK; /* Select clock source */
 
-	/* Set the divider; HW permits fraction dividers (+0.5), but
-	   for simplicity, we will support integers only */
 	if (div)
-		cfg |= (2 * div - 1) & CFG_DIVIDER_MASK;
+		cfg |= div & CFG_SRC_DIV_MASK;
 
-	if (n_val)
+	if (n && (n != m))
 		cfg |= CFG_MODE_DUAL_EDGE;
 
 	writel(cfg, base + regs->cfg_rcgr); /* Write new clock configuration */
@@ -128,7 +142,7 @@ void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
 
 	/* setup src select and divider */
 	cfg  = readl(base + regs->cfg_rcgr);
-	cfg &= ~CFG_MASK;
+	cfg &= ~(CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK);
 	cfg |= source & CFG_CLK_SRC_MASK; /* Select clock source */
 
 	/*
@@ -136,7 +150,7 @@ void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
 	 * for simplicity, we will support integers only
 	 */
 	if (div)
-		cfg |= (2 * div - 1) & CFG_DIVIDER_MASK;
+		cfg |= (2 * div - 1) & CFG_SRC_DIV_MASK;
 
 	writel(cfg, base + regs->cfg_rcgr); /* Write new clock configuration */
 
@@ -144,6 +158,22 @@ void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
 	clk_bcr_update(base + regs->cmd_rcgr);
 }
 
+const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate)
+{
+	if (!f)
+		return NULL;
+
+	if (!f->freq)
+		return f;
+
+	for (; f->freq; f++)
+		if (rate <= f->freq)
+			return f;
+
+	/* Default to our fastest rate */
+	return f - 1;
+}
+
 static int msm_clk_probe(struct udevice *dev)
 {
 	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(dev);
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 24a32cb9666d..01088c19015a 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -32,6 +32,16 @@ struct bcr_regs {
 	uintptr_t D;
 };
 
+struct freq_tbl {
+	uint freq;
+	uint src;
+	u8 pre_div;
+	u16 m;
+	u16 n;
+};
+
+#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
+
 struct gate_clk {
 	uintptr_t reg;
 	u32 en_val;
@@ -71,6 +81,7 @@ void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0);
 void clk_bcr_update(phys_addr_t apps_cmd_rgcr);
 void clk_enable_cbc(phys_addr_t cbcr);
 void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk);
+const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate);
 void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
 			  int div, int m, int n, int source, u8 mnd_width);
 void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
index 921abf1f699b..429ff35e1d1a 100644
--- a/drivers/clk/qcom/clock-qcs404.c
+++ b/drivers/clk/qcom/clock-qcs404.c
@@ -203,7 +203,7 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
 		break;
 	case GCC_SDCC1_APPS_CLK:
 		/* SDCC1: 200MHz */
-		clk_rcg_set_rate_mnd(priv->base, &sdc_regs, 4, 0, 0,
+		clk_rcg_set_rate_mnd(priv->base, &sdc_regs, 7, 0, 0,
 				     CFG_CLK_SRC_GPLL0, 8);
 		clk_enable_gpll0(priv->base, &gpll0_vote_clk);
 		clk_enable_cbc(priv->base + SDCC_APPS_CBCR(1));
@@ -213,16 +213,16 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
 		break;
 	case GCC_ETH_RGMII_CLK:
 		if (rate == 250000000)
-			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 2, 0, 0,
+			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 0, 0,
 					     CFG_CLK_SRC_GPLL1, 8);
 		else if (rate == 125000000)
-			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 4, 0, 0,
+			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 7, 0, 0,
 					     CFG_CLK_SRC_GPLL1, 8);
 		else if (rate == 50000000)
-			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 10, 0, 0,
+			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 19, 0, 0,
 					     CFG_CLK_SRC_GPLL1, 8);
 		else if (rate == 5000000)
-			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 2, 1, 50,
+			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 1, 50,
 					     CFG_CLK_SRC_GPLL1, 8);
 		break;
 	default:
@@ -239,7 +239,7 @@ static int qcs404_clk_enable(struct clk *clk)
 	switch (clk->id) {
 	case GCC_USB30_MASTER_CLK:
 		clk_enable_cbc(priv->base + USB30_MASTER_CBCR);
-		clk_rcg_set_rate_mnd(priv->base, &usb30_master_regs, 4, 0, 0,
+		clk_rcg_set_rate_mnd(priv->base, &usb30_master_regs, 7, 0, 0,
 				     CFG_CLK_SRC_GPLL0, 8);
 		break;
 	case GCC_SYS_NOC_USB3_CLK:
@@ -261,14 +261,14 @@ static int qcs404_clk_enable(struct clk *clk)
 		/* SPEED_1000: freq -> 250MHz */
 		clk_enable_cbc(priv->base + ETH_PTP_CBCR);
 		clk_enable_gpll0(priv->base, &gpll1_vote_clk);
-		clk_rcg_set_rate_mnd(priv->base, &emac_ptp_regs, 2, 0, 0,
+		clk_rcg_set_rate_mnd(priv->base, &emac_ptp_regs, 3, 0, 0,
 				     CFG_CLK_SRC_GPLL1, 8);
 		break;
 	case GCC_ETH_RGMII_CLK:
 		/* SPEED_1000: freq -> 250MHz */
 		clk_enable_cbc(priv->base + ETH_RGMII_CBCR);
 		clk_enable_gpll0(priv->base, &gpll1_vote_clk);
-		clk_rcg_set_rate_mnd(priv->base, &emac_regs, 2, 0, 0,
+		clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 0, 0,
 				     CFG_CLK_SRC_GPLL1, 8);
 		break;
 	case GCC_ETH_SLAVE_AHB_CLK:
diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index 9e78da482c65..07e3605cdbaf 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -30,16 +30,6 @@
 #define USB30_SEC_GDSCR		0x10004
 #define USB30_PRIM_GDSCR	0xf004
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
-
-struct freq_tbl {
-	uint freq;
-	uint src;
-	u8 pre_div;
-	u16 m;
-	u16 n;
-};
-
 static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
 	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
 	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
@@ -67,22 +57,6 @@ static const struct bcr_regs uart2_regs = {
 	.D = SE9_UART_APPS_D,
 };
 
-const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate)
-{
-	if (!f)
-		return NULL;
-
-	if (!f->freq)
-		return f;
-
-	for (; f->freq; f++)
-		if (rate <= f->freq)
-			return f;
-
-	/* Default to our fastest rate */
-	return f - 1;
-}
-
 static ulong sdm845_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);

-- 
2.42.0

