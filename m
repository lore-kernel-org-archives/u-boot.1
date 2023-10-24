Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45263C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 20:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55634879D9;
	Tue, 24 Oct 2023 22:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xV6kXvpO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E592E8798C; Tue, 24 Oct 2023 22:24:13 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 838D8879D6
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 22:24:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32dc9ff4a8fso3301844f8f.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698179048; x=1698783848; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kG+4ByBqBsMx55i2Iu6G2jFR+PLeJvnXUSMRrSaHyb4=;
 b=xV6kXvpOmXDYT2sMjE2odc3iHknNDP0HKH+j+8gD89KYFOJRWMRH7/u1wPYL4YUGGd
 c9J/IxGzKRF0hZTtfRpSN0apylCcY4f6MkNc/+GHmio8UEcUQ0PHT1tYtW6JqX9N+ThB
 KgKznYfD1bP0S5EegpPc3IZCZlzYMjHAWCtp97vTiklexTJn/lqpPQE/NzegrvV90U8m
 ppByh7GcQkdDhYLva/BnnEvRmK0POEU0hHAmPsSN519GUrc8+BBeQseT0Qgdv2rV+ffa
 v8XWW1iwg7WrVOP6B6i4JPClQvPMIPw9qLdgJeFn0RrtUhIrYR5oUBWCZe5GYyxvPwnB
 /WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698179048; x=1698783848;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kG+4ByBqBsMx55i2Iu6G2jFR+PLeJvnXUSMRrSaHyb4=;
 b=BH1YYyZxYLbxZXbsjFBvHYxUVl73NtsQ/qLGla8hJ/hCpONzWWKzSZJOR7e4kA9TZI
 bJQTusLNuBIdjQPiWcBfwumjrfcD303YkJNakfMFw4Xn0r83lMymOBTKigNepSimWSNU
 hV5HX/V9IIH2IssLw10g/zpFPIsOo+msSINbYiNMiPQdZN8WCOrhvAWC3p0oZavPYspt
 ZfTpG4u8FDo7IR8FsvHWe3popjYh+trerzbMfq0fe0ID3WnavXBEEo9BkmGmfgXx92YD
 tguMrpEXiPL6biPzsx92Ybca6uHFu5VbDmn8BnD3g9H5gB18dPuqBT9tzGEOCToTI8tn
 IrKw==
X-Gm-Message-State: AOJu0YwSB3PHzzJVhYcBsu0uCvA6e2joSmcmSv72xR103jxQdCeZqu4H
 P4GaHSnBKYIJyTzy6D7FpkrLJQ==
X-Google-Smtp-Source: AGHT+IGfLhDzN3xYxZTwFfPq8pYmEIN9cR4mt/jgiPyf7ezAx992KYwMNBTg8PTvoc5J/dZxAFUbZA==
X-Received: by 2002:a5d:5341:0:b0:320:1c7:fd30 with SMTP id
 t1-20020a5d5341000000b0032001c7fd30mr8567474wrv.17.1698179048055; 
 Tue, 24 Oct 2023 13:24:08 -0700 (PDT)
Received: from lion.localdomain (host-2-99-112-229.as13285.net. [2.99.112.229])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a056000023500b003198a9d758dsm10682342wrz.78.2023.10.24.13.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 13:24:07 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 24 Oct 2023 21:23:59 +0100
Subject: [PATCH 8/8] clk/qcom: fix rcg divider value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-b4-qcom-clk-v1-8-9d96359b9a82@linaro.org>
References: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Bharat Gooty <bharat.gooty@broadcom.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Kovacic <luka.kovacic@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=9068;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=TPZH4lJhGb271M+1JvodKLzrt0rI/VXiFgKJQ1EDK+Y=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlQL9Vs97Rd1X2t07FuUX5Agf/Xr7z9lvIFe8+8JXgjzb
 og3sNneUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACbyrJDhf1R/8p4GLS6uLc+O
 qa8PlnPmnPNC1pH1wJrdPbe3Nh/Z/ZaRYb7/ZZ+aOdIWLhdFVN8cXXU+lctLs/6vcInB525V9k/
 2cgA=
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
 drivers/clk/qcom/clock-qcom.c    | 40 ++++++++++++++++++++++++++++++++--------
 drivers/clk/qcom/clock-qcom.h    | 11 +++++++++++
 drivers/clk/qcom/clock-qcs404.c  | 16 ++++++++--------
 drivers/clk/qcom/clock-sdm845.c  | 26 --------------------------
 6 files changed, 53 insertions(+), 44 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index 5eba18739cfb..a1481cd5177b 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -53,7 +53,7 @@ static struct vote_clk gcc_blsp1_ahb_clk = {
 /* SDHCI */
 static int clk_init_sdc(struct qcom_cc_priv *priv, int slot, uint rate)
 {
-	int div = 8; /* 100MHz default */
+	int div = 15; /* 100MHz default */
 
 	if (rate == 200000000)
 		div = 4;
diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index 48cac08eed67..ef81cd16223c 100644
--- a/drivers/clk/qcom/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -44,7 +44,7 @@ static struct vote_clk gcc_blsp2_ahb_clk = {
 
 static int clk_init_sdc(struct qcom_cc_priv *priv, uint rate)
 {
-	int div = 3;
+	int div = 5;
 
 	clk_enable_cbc(priv->base + SDCC2_AHB_CBCR);
 	clk_rcg_set_rate_mnd(priv->base, &sdc_regs, div, 0, 0,
diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 7a6157bf123f..a83c74cd20ba 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -68,20 +68,46 @@ void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk)
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
+}
+
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
 }
 
 #define CFG_MODE_DUAL_EDGE (0x2 << 12) /* Counter mode */
 
-#define CFG_MASK 0x3FFF
+// Disable the HW_CLK_CONTROL bit
+#define CFG_MASK (0x3FFF | (1 << 20))
 
 #define CFG_DIVIDER_MASK 0x1F
 
-/* root set rate for clocks with half integer and MND divider */
+/*
+ * root set rate for clocks with half integer and MND divider
+ * div should be pre-calculated ((div * 2) - 1)
+ */
 void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
 			  int div, int m, int n, int source, u8 mnd_width)
 {
@@ -99,17 +125,15 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
 	/* Program MND values */
 	setbits_le32(base + regs->M, m_val & mask);
 	setbits_le32(base + regs->N, n_val & mask);
-	setbits_le32(base + regs->D, d_val & mask);
+	setbits_le32(base + regs->D, (d_val & mask) == mask ? 0 : (d_val & mask));
 
 	/* setup src select and divider */
 	cfg  = readl(base + regs->cfg_rcgr);
 	cfg &= ~CFG_MASK;
 	cfg |= source & CFG_CLK_SRC_MASK; /* Select clock source */
 
-	/* Set the divider; HW permits fraction dividers (+0.5), but
-	   for simplicity, we will support integers only */
 	if (div)
-		cfg |= (2 * div - 1) & CFG_DIVIDER_MASK;
+		cfg |= div & CFG_DIVIDER_MASK;
 
 	if (n_val)
 		cfg |= CFG_MODE_DUAL_EDGE;
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 6fa88fb40af8..f91e9d47dd22 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -30,6 +30,16 @@ struct bcr_regs {
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
@@ -69,6 +79,7 @@ void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0);
 void clk_bcr_update(phys_addr_t apps_cmd_rgcr);
 void clk_enable_cbc(phys_addr_t cbcr);
 void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk);
+const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate);
 void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
 			  int div, int m, int n, int source, u8 mnd_width);
 void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
index d10992ee58bf..b30d5c388d81 100644
--- a/drivers/clk/qcom/clock-qcs404.c
+++ b/drivers/clk/qcom/clock-qcs404.c
@@ -129,7 +129,7 @@ static ulong qcs404_set_rate(struct clk *clk, ulong rate)
 		break;
 	case GCC_SDCC1_APPS_CLK:
 		/* SDCC1: 200MHz */
-		clk_rcg_set_rate_mnd(priv->base, &sdc_regs, 4, 0, 0,
+		clk_rcg_set_rate_mnd(priv->base, &sdc_regs, 7, 0, 0,
 				     CFG_CLK_SRC_GPLL0, 8);
 		clk_enable_gpll0(priv->base, &gpll0_vote_clk);
 		clk_enable_cbc(priv->base + SDCC_APPS_CBCR(1));
@@ -139,16 +139,16 @@ static ulong qcs404_set_rate(struct clk *clk, ulong rate)
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
@@ -165,7 +165,7 @@ static int qcs404_enable(struct clk *clk)
 	switch (clk->id) {
 	case GCC_USB30_MASTER_CLK:
 		clk_enable_cbc(priv->base + USB30_MASTER_CBCR);
-		clk_rcg_set_rate_mnd(priv->base, &usb30_master_regs, 4, 0, 0,
+		clk_rcg_set_rate_mnd(priv->base, &usb30_master_regs, 7, 0, 0,
 				     CFG_CLK_SRC_GPLL0, 8);
 		break;
 	case GCC_SYS_NOC_USB3_CLK:
@@ -187,14 +187,14 @@ static int qcs404_enable(struct clk *clk)
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
index 9345d5293f1e..efe8495b7fb0 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -20,16 +20,6 @@
 
 #include "clock-qcom.h"
 
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
@@ -57,22 +47,6 @@ static const struct bcr_regs uart2_regs = {
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
 static ulong sdm845_set_rate(struct clk *clk, ulong rate)
 {
 	struct qcom_cc_priv *priv = dev_get_priv(clk->dev);

-- 
2.42.0

