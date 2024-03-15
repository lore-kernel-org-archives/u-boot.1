Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E2FC54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B807C88050;
	Fri, 15 Mar 2024 16:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k62hcNu5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D47FB8804C; Fri, 15 Mar 2024 16:10:39 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B32D687FC9
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33e99b62e01so1773431f8f.0
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515434; x=1711120234; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2tIybXB4/i8K8imQRbJFN4tQmiI9WOy924+pDsC6PPI=;
 b=k62hcNu53ylwUencKJViyvZAXcefxe4HkICisKkCH0tutO4NplXnRX/WxJtVU5j0l5
 UXoZPaCNz+4vA0MsFIUNbv52hWqJpsK7eQrW0VoKx+8l6RIVkxOR3zeNNTD3zk6uTWka
 HvbnVUwcmX2VZmUtqsyt86GsiflMkMRp7ygOCPVmLJgOvQkexPmi6eF7lRfBg+zKbFqG
 Rn4vvZ0bGcbCR12M+DSyczovuECBjGPV5P3daPMrEFYtJ+4+wxTuexwGTtFF0hcQdHRF
 jD8iUwy+dOrU8tI1kszd1I6ApDMfMiZ9zvWlgUuGUFOZJdiUJfK/HqoFR2DYVmSvAuDr
 fEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515434; x=1711120234;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2tIybXB4/i8K8imQRbJFN4tQmiI9WOy924+pDsC6PPI=;
 b=dODRIX8HR/dKJb0RUIyzhI4G/f+EuGT5VkSZ38J0tF2l51jqlZfV2i/+zmPbB0MX53
 S+PryloKHWj76/OaFyV1Tu1Yil3rvXpaZkJXhf8NA8cpFaNUir6gLcYnPEHqsuz8KHiM
 cxpILvuDU2O3D7am3YY8Ztg3jVRmb8yVCOwCKMXCf/Iz6L0Ag42E33LmUKQOFxh8u4K4
 kxW9q5Uw6VJaNddRTxOKhxW76Ta9zVDiVDUj3wgN9kUgCSpVZPbpl542FyOyuSVoOs15
 5qhZWC6Q6kvp8uSdijWWn50qjVddPHik3YjHQuI033zx1Yrvlib6OKDoWvOm62s1ihAM
 LPFA==
X-Gm-Message-State: AOJu0Yyt2yFjybpyFAttsBy12xD2vR2K9kRRsAIkLkafYogOZuGnEjRI
 8jIJk59yM8SwRIgZXgqq6G76V5KIgAcnoAeVjLEzSKaX1YLAMGd2L+e1UTWNGy2tY9hxngiHHJk
 L
X-Google-Smtp-Source: AGHT+IHv4iT93Fa3P29bVxxeKQoJ/wjDjGgKklg95yDLyNJgqcCQY6FAhBHwMU4OivuDDBmMsXHK6g==
X-Received: by 2002:a5d:5005:0:b0:33e:7831:8f69 with SMTP id
 e5-20020a5d5005000000b0033e78318f69mr4775208wrt.32.1710515433587; 
 Fri, 15 Mar 2024 08:10:33 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a5d4006000000b0033e699fc6b4sm3398141wrp.69.2024.03.15.08.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:10:33 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 15 Mar 2024 15:10:14 +0000
Subject: [PATCH v2 05/14] clk/qcom: use offsets for RCG registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-qcom-livetree-v2-5-ab635774b2dc@linaro.org>
References: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
In-Reply-To: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=21410;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=+L98HdRBA9FLvBdzgwBiyByDFkebZAkL+nfO+eax76o=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQvKY9/n3YQ9NW85DWjof+lU+0WER5P/cqDRbO3Wa2+r
 n5YbF1DRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjI9+sMf2XCnlzmP5VQeVtz
 S7j/ac3Cqil11375PDH3CWPnyYu5bcfIsFWMb+P/vIYue5mH+3inv70QJKgYf+fETbPlIcK7OHd
 K/wIA
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

The RCG registers always have the same offsets, so only store the base
CMD register address and calculate the others relative to that.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-apq8016.c |  39 +------------
 drivers/clk/qcom/clock-apq8096.c |  28 +--------
 drivers/clk/qcom/clock-qcom.c    |  22 +++----
 drivers/clk/qcom/clock-qcom.h    |  16 +++---
 drivers/clk/qcom/clock-qcs404.c  | 121 +++++----------------------------------
 drivers/clk/qcom/clock-sdm845.c  |  16 +-----
 6 files changed, 39 insertions(+), 203 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index e6647f7c41dd..5a5868169c89 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -22,13 +22,9 @@
 #define APCS_GPLL_ENA_VOTE		(0x45000)
 #define APCS_CLOCK_BRANCH_ENA_VOTE (0x45004)
 
 #define SDCC_BCR(n)			((n * 0x1000) + 0x41000)
-#define SDCC_CMD_RCGR(n)		((n * 0x1000) + 0x41004)
-#define SDCC_CFG_RCGR(n)		((n * 0x1000) + 0x41008)
-#define SDCC_M(n)			((n * 0x1000) + 0x4100C)
-#define SDCC_N(n)			((n * 0x1000) + 0x41010)
-#define SDCC_D(n)			((n * 0x1000) + 0x41014)
+#define SDCC_CMD_RCGR(n)		(((n + 1) * 0x1000) + 0x41004)
 #define SDCC_APPS_CBCR(n)		((n * 0x1000) + 0x41018)
 #define SDCC_AHB_CBCR(n)		((n * 0x1000) + 0x4101C)
 
 /* BLSP1 AHB clock (root clock for BLSP) */
@@ -37,33 +33,12 @@
 /* Uart clock control registers */
 #define BLSP1_UART2_BCR			(0x3028)
 #define BLSP1_UART2_APPS_CBCR		(0x302C)
 #define BLSP1_UART2_APPS_CMD_RCGR	(0x3034)
-#define BLSP1_UART2_APPS_CFG_RCGR	(0x3038)
-#define BLSP1_UART2_APPS_M		(0x303C)
-#define BLSP1_UART2_APPS_N		(0x3040)
-#define BLSP1_UART2_APPS_D		(0x3044)
 
 /* GPLL0 clock control registers */
 #define GPLL0_STATUS_ACTIVE BIT(17)
 
-static const struct bcr_regs sdc_regs[] = {
-	{
-	.cfg_rcgr = SDCC_CFG_RCGR(1),
-	.cmd_rcgr = SDCC_CMD_RCGR(1),
-	.M = SDCC_M(1),
-	.N = SDCC_N(1),
-	.D = SDCC_D(1),
-	},
-	{
-	.cfg_rcgr = SDCC_CFG_RCGR(2),
-	.cmd_rcgr = SDCC_CMD_RCGR(2),
-	.M = SDCC_M(2),
-	.N = SDCC_N(2),
-	.D = SDCC_D(2),
-	}
-};
-
 static struct pll_vote_clk gpll0_vote_clk = {
 	.status = GPLL0_STATUS,
 	.status_bit = GPLL0_STATUS_ACTIVE,
 	.ena_vote = APCS_GPLL_ENA_VOTE,
@@ -85,32 +60,24 @@ static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
 		div = 4;
 
 	clk_enable_cbc(priv->base + SDCC_AHB_CBCR(slot));
 	/* 800Mhz/div, gpll0 */
-	clk_rcg_set_rate_mnd(priv->base, &sdc_regs[slot], div, 0, 0,
+	clk_rcg_set_rate_mnd(priv->base, SDCC_CMD_RCGR(slot), div, 0, 0,
 			     CFG_CLK_SRC_GPLL0, 8);
 	clk_enable_gpll0(priv->base, &gpll0_vote_clk);
 	clk_enable_cbc(priv->base + SDCC_APPS_CBCR(slot));
 
 	return rate;
 }
 
-static const struct bcr_regs uart2_regs = {
-	.cfg_rcgr = BLSP1_UART2_APPS_CFG_RCGR,
-	.cmd_rcgr = BLSP1_UART2_APPS_CMD_RCGR,
-	.M = BLSP1_UART2_APPS_M,
-	.N = BLSP1_UART2_APPS_N,
-	.D = BLSP1_UART2_APPS_D,
-};
-
 /* UART: 115200 */
 int apq8016_clk_init_uart(phys_addr_t base)
 {
 	/* Enable AHB clock */
 	clk_enable_vote_clk(base, &gcc_blsp1_ahb_clk);
 
 	/* 7372800 uart block clock @ GPLL0 */
-	clk_rcg_set_rate_mnd(base, &uart2_regs, 1, 144, 15625,
+	clk_rcg_set_rate_mnd(base, BLSP1_UART2_APPS_CMD_RCGR, 1, 144, 15625,
 			     CFG_CLK_SRC_GPLL0, 16);
 
 	/* Vote for gpll0 clock */
 	clk_enable_gpll0(base, &gpll0_vote_clk);
diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index a4731613c5e0..479f9771a464 100644
--- a/drivers/clk/qcom/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -25,33 +25,17 @@
 #define SDCC2_BCR			(0x14000) /* block reset */
 #define SDCC2_APPS_CBCR			(0x14004) /* branch control */
 #define SDCC2_AHB_CBCR			(0x14008)
 #define SDCC2_CMD_RCGR			(0x14010)
-#define SDCC2_CFG_RCGR			(0x14014)
-#define SDCC2_M				(0x14018)
-#define SDCC2_N				(0x1401C)
-#define SDCC2_D				(0x14020)
 
 #define BLSP2_AHB_CBCR			(0x25004)
 #define BLSP2_UART2_APPS_CBCR		(0x29004)
 #define BLSP2_UART2_APPS_CMD_RCGR	(0x2900C)
-#define BLSP2_UART2_APPS_CFG_RCGR	(0x29010)
-#define BLSP2_UART2_APPS_M		(0x29014)
-#define BLSP2_UART2_APPS_N		(0x29018)
-#define BLSP2_UART2_APPS_D		(0x2901C)
 
 /* GPLL0 clock control registers */
 #define GPLL0_STATUS_ACTIVE		BIT(30)
 #define APCS_GPLL_ENA_VOTE_GPLL0	BIT(0)
 
-static const struct bcr_regs sdc_regs = {
-	.cfg_rcgr = SDCC2_CFG_RCGR,
-	.cmd_rcgr = SDCC2_CMD_RCGR,
-	.M = SDCC2_M,
-	.N = SDCC2_N,
-	.D = SDCC2_D,
-};
-
 static const struct pll_vote_clk gpll0_vote_clk = {
 	.status = GPLL0_STATUS,
 	.status_bit = GPLL0_STATUS_ACTIVE,
 	.ena_vote = APCS_GPLL_ENA_VOTE,
@@ -68,31 +52,23 @@ static int clk_init_sdc(struct msm_clk_priv *priv, uint rate)
 {
 	int div = 5;
 
 	clk_enable_cbc(priv->base + SDCC2_AHB_CBCR);
-	clk_rcg_set_rate_mnd(priv->base, &sdc_regs, div, 0, 0,
+	clk_rcg_set_rate_mnd(priv->base, SDCC2_CMD_RCGR, div, 0, 0,
 			     CFG_CLK_SRC_GPLL0, 8);
 	clk_enable_gpll0(priv->base, &gpll0_vote_clk);
 	clk_enable_cbc(priv->base + SDCC2_APPS_CBCR);
 
 	return rate;
 }
 
-static const struct bcr_regs uart2_regs = {
-	.cfg_rcgr = BLSP2_UART2_APPS_CFG_RCGR,
-	.cmd_rcgr = BLSP2_UART2_APPS_CMD_RCGR,
-	.M = BLSP2_UART2_APPS_M,
-	.N = BLSP2_UART2_APPS_N,
-	.D = BLSP2_UART2_APPS_D,
-};
-
 static int clk_init_uart(struct msm_clk_priv *priv)
 {
 	/* Enable AHB clock */
 	clk_enable_vote_clk(priv->base, &gcc_blsp2_ahb_clk);
 
 	/* 7372800 uart block clock @ GPLL0 */
-	clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 1, 192, 15625,
+	clk_rcg_set_rate_mnd(priv->base, BLSP2_UART2_APPS_CMD_RCGR, 1, 192, 15625,
 			     CFG_CLK_SRC_GPLL0, 16);
 
 	/* Vote for gpll0 clock */
 	clk_enable_gpll0(priv->base, &gpll0_vote_clk);
diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 6303dcbf8461..05e5ab7d094b 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -103,9 +103,9 @@ void clk_bcr_update(phys_addr_t apps_cmd_rcgr)
 /*
  * root set rate for clocks with half integer and MND divider
  * div should be pre-calculated ((div * 2) - 1)
  */
-void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
+void clk_rcg_set_rate_mnd(phys_addr_t base, uint32_t cmd_rcgr,
 			  int div, int m, int n, int source, u8 mnd_width)
 {
 	u32 cfg;
 	/* M value for MND divider. */
@@ -119,14 +119,14 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
 
 	debug("m %#x n %#x d %#x div %#x mask %#x\n", m_val, n_val, d_val, div, mask);
 
 	/* Program MND values */
-	writel(m_val & mask, base + regs->M);
-	writel(n_val & mask, base + regs->N);
-	writel(d_val & mask, base + regs->D);
+	writel(m_val & mask, base + cmd_rcgr + RCG_M_REG);
+	writel(n_val & mask, base + cmd_rcgr + RCG_N_REG);
+	writel(d_val & mask, base + cmd_rcgr + RCG_D_REG);
 
 	/* setup src select and divider */
-	cfg  = readl(base + regs->cfg_rcgr);
+	cfg  = readl(base + cmd_rcgr + RCG_CFG_REG);
 	cfg &= ~(CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK |
 		 CFG_SRC_DIV_MASK);
 	cfg |= source & CFG_SRC_SEL_MASK; /* Select clock source */
 
@@ -135,22 +135,22 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
 
 	if (n && n != m)
 		cfg |= CFG_MODE_DUAL_EDGE;
 
-	writel(cfg, base + regs->cfg_rcgr); /* Write new clock configuration */
+	writel(cfg, base + cmd_rcgr + RCG_CFG_REG); /* Write new clock configuration */
 
 	/* Inform h/w to start using the new config. */
-	clk_bcr_update(base + regs->cmd_rcgr);
+	clk_bcr_update(base + cmd_rcgr);
 }
 
 /* root set rate for clocks with half integer and mnd_width=0 */
-void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
+void clk_rcg_set_rate(phys_addr_t base, uint32_t cmd_rcgr, int div,
 		      int source)
 {
 	u32 cfg;
 
 	/* setup src select and divider */
-	cfg  = readl(base + regs->cfg_rcgr);
+	cfg  = readl(base + cmd_rcgr + RCG_CFG_REG);
 	cfg &= ~(CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK);
 	cfg |= source & CFG_CLK_SRC_MASK; /* Select clock source */
 
 	/*
@@ -159,12 +159,12 @@ void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
 	 */
 	if (div)
 		cfg |= (2 * div - 1) & CFG_SRC_DIV_MASK;
 
-	writel(cfg, base + regs->cfg_rcgr); /* Write new clock configuration */
+	writel(cfg, base + cmd_rcgr + RCG_CFG_REG); /* Write new clock configuration */
 
 	/* Inform h/w to start using the new config. */
-	clk_bcr_update(base + regs->cmd_rcgr);
+	clk_bcr_update(base + cmd_rcgr);
 }
 
 const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate)
 {
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 12a1eaec2b2e..a7f833a4b6dd 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -11,8 +11,13 @@
 #define CFG_CLK_SRC_GPLL0 (1 << 8)
 #define CFG_CLK_SRC_GPLL0_EVEN (6 << 8)
 #define CFG_CLK_SRC_MASK  (7 << 8)
 
+#define RCG_CFG_REG		0x4
+#define RCG_M_REG		0x8
+#define RCG_N_REG		0xc
+#define RCG_D_REG		0x10
+
 struct pll_vote_clk {
 	uintptr_t status;
 	int status_bit;
 	uintptr_t ena_vote;
@@ -23,15 +28,8 @@ struct vote_clk {
 	uintptr_t cbcr_reg;
 	uintptr_t ena_vote;
 	int vote_bit;
 };
-struct bcr_regs {
-	uintptr_t cfg_rcgr;
-	uintptr_t cmd_rcgr;
-	uintptr_t M;
-	uintptr_t N;
-	uintptr_t D;
-};
 
 struct freq_tbl {
 	uint freq;
 	uint src;
@@ -87,11 +85,11 @@ void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0);
 void clk_bcr_update(phys_addr_t apps_cmd_rgcr);
 void clk_enable_cbc(phys_addr_t cbcr);
 void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk);
 const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate);
-void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
+void clk_rcg_set_rate_mnd(phys_addr_t base, uint32_t cmd_rcgr,
 			  int div, int m, int n, int source, u8 mnd_width);
-void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
+void clk_rcg_set_rate(phys_addr_t base, uint32_t cmd_rcgr, int div,
 		      int source);
 
 static inline void qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id)
 {
diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
index 958312b88842..64a0a2d36754 100644
--- a/drivers/clk/qcom/clock-qcs404.c
+++ b/drivers/clk/qcom/clock-qcs404.c
@@ -27,37 +27,24 @@
 /* Uart clock control registers */
 #define BLSP1_UART2_BCR			(0x3028)
 #define BLSP1_UART2_APPS_CBCR		(0x302C)
 #define BLSP1_UART2_APPS_CMD_RCGR	(0x3034)
-#define BLSP1_UART2_APPS_CFG_RCGR	(0x3038)
-#define BLSP1_UART2_APPS_M		(0x303C)
-#define BLSP1_UART2_APPS_N		(0x3040)
-#define BLSP1_UART2_APPS_D		(0x3044)
 
 /* I2C controller clock control registerss */
 #define BLSP1_QUP0_I2C_APPS_CBCR	(0x6028)
 #define BLSP1_QUP0_I2C_APPS_CMD_RCGR	(0x602C)
-#define BLSP1_QUP0_I2C_APPS_CFG_RCGR	(0x6030)
 #define BLSP1_QUP1_I2C_APPS_CBCR	(0x2008)
 #define BLSP1_QUP1_I2C_APPS_CMD_RCGR	(0x200C)
-#define BLSP1_QUP1_I2C_APPS_CFG_RCGR	(0x2010)
 #define BLSP1_QUP2_I2C_APPS_CBCR	(0x3010)
 #define BLSP1_QUP2_I2C_APPS_CMD_RCGR	(0x3000)
-#define BLSP1_QUP2_I2C_APPS_CFG_RCGR	(0x3004)
 #define BLSP1_QUP3_I2C_APPS_CBCR	(0x4020)
 #define BLSP1_QUP3_I2C_APPS_CMD_RCGR	(0x4000)
-#define BLSP1_QUP3_I2C_APPS_CFG_RCGR	(0x4004)
 #define BLSP1_QUP4_I2C_APPS_CBCR	(0x5020)
 #define BLSP1_QUP4_I2C_APPS_CMD_RCGR	(0x5000)
-#define BLSP1_QUP4_I2C_APPS_CFG_RCGR	(0x5004)
 
 /* SD controller clock control registers */
 #define SDCC_BCR(n)			(((n) * 0x1000) + 0x41000)
-#define SDCC_CMD_RCGR(n)		(((n) * 0x1000) + 0x41004)
-#define SDCC_CFG_RCGR(n)		(((n) * 0x1000) + 0x41008)
-#define SDCC_M(n)			(((n) * 0x1000) + 0x4100C)
-#define SDCC_N(n)			(((n) * 0x1000) + 0x41010)
-#define SDCC_D(n)			(((n) * 0x1000) + 0x41014)
+#define SDCC_CMD_RCGR(n)		(((n + 1) * 0x1000) + 0x41004)
 #define SDCC_APPS_CBCR(n)		(((n) * 0x1000) + 0x41018)
 #define SDCC_AHB_CBCR(n)		(((n) * 0x1000) + 0x4101C)
 
 /* USB-3.0 controller clock control registers */
@@ -69,12 +56,8 @@
 #define USB30_MOCK_UTMI_CBCR		(0x39014)
 #define USB30_MOCK_UTMI_CMD_RCGR	(0x3901C)
 #define USB30_MOCK_UTMI_CFG_RCGR	(0x39020)
 #define USB30_MASTER_CMD_RCGR		(0x39028)
-#define USB30_MASTER_CFG_RCGR		(0x3902C)
-#define USB30_MASTER_M			(0x39030)
-#define USB30_MASTER_N			(0x39034)
-#define USB30_MASTER_D			(0x39038)
 #define USB2A_PHY_SLEEP_CBCR		(0x4102C)
 #define USB_HS_PHY_CFG_AHB_CBCR		(0x41030)
 
 /* ETH controller clock control registers */
@@ -84,12 +67,8 @@
 #define ETH_AXI_CBCR			(0x4e010)
 #define EMAC_PTP_CMD_RCGR		(0x4e014)
 #define EMAC_PTP_CFG_RCGR		(0x4e018)
 #define EMAC_CMD_RCGR			(0x4e01c)
-#define EMAC_CFG_RCGR			(0x4e020)
-#define EMAC_M				(0x4e024)
-#define EMAC_N				(0x4e028)
-#define EMAC_D				(0x4e02c)
 
 
 /* GPLL0 clock control registers */
 #define GPLL0_STATUS_ACTIVE BIT(31)
@@ -102,24 +81,8 @@ static struct vote_clk gcc_blsp1_ahb_clk = {
 	.ena_vote = APCS_CLOCK_BRANCH_ENA_VOTE,
 	.vote_bit = BIT(10) | BIT(5) | BIT(4),
 };
 
-static const struct bcr_regs uart2_regs = {
-	.cfg_rcgr = BLSP1_UART2_APPS_CFG_RCGR,
-	.cmd_rcgr = BLSP1_UART2_APPS_CMD_RCGR,
-	.M = BLSP1_UART2_APPS_M,
-	.N = BLSP1_UART2_APPS_N,
-	.D = BLSP1_UART2_APPS_D,
-};
-
-static const struct bcr_regs sdc_regs = {
-	.cfg_rcgr = SDCC_CFG_RCGR(1),
-	.cmd_rcgr = SDCC_CMD_RCGR(1),
-	.M = SDCC_M(1),
-	.N = SDCC_N(1),
-	.D = SDCC_D(1),
-};
-
 static struct pll_vote_clk gpll0_vote_clk = {
 	.status = GPLL0_STATUS,
 	.status_bit = GPLL0_STATUS_ACTIVE,
 	.ena_vote = APCS_GPLL_ENA_VOTE,
@@ -132,92 +95,38 @@ static struct pll_vote_clk gpll1_vote_clk = {
 	.ena_vote = APCS_GPLL_ENA_VOTE,
 	.vote_bit = BIT(1),
 };
 
-static const struct bcr_regs usb30_master_regs = {
-	.cfg_rcgr = USB30_MASTER_CFG_RCGR,
-	.cmd_rcgr = USB30_MASTER_CMD_RCGR,
-	.M = USB30_MASTER_M,
-	.N = USB30_MASTER_N,
-	.D = USB30_MASTER_D,
-};
-
-static const struct bcr_regs emac_regs = {
-	.cfg_rcgr = EMAC_CFG_RCGR,
-	.cmd_rcgr = EMAC_CMD_RCGR,
-	.M = EMAC_M,
-	.N = EMAC_N,
-	.D = EMAC_D,
-};
-
-static const struct bcr_regs emac_ptp_regs = {
-	.cfg_rcgr = EMAC_PTP_CFG_RCGR,
-	.cmd_rcgr = EMAC_PTP_CMD_RCGR,
-	.M = EMAC_M,
-	.N = EMAC_N,
-	.D = EMAC_D,
-};
-
-static const struct bcr_regs blsp1_qup0_i2c_apps_regs = {
-	.cmd_rcgr = BLSP1_QUP0_I2C_APPS_CMD_RCGR,
-	.cfg_rcgr = BLSP1_QUP0_I2C_APPS_CFG_RCGR,
-	/* mnd_width = 0 */
-};
-
-static const struct bcr_regs blsp1_qup1_i2c_apps_regs = {
-	.cmd_rcgr = BLSP1_QUP1_I2C_APPS_CMD_RCGR,
-	.cfg_rcgr = BLSP1_QUP1_I2C_APPS_CFG_RCGR,
-	/* mnd_width = 0 */
-};
-
-static const struct bcr_regs blsp1_qup2_i2c_apps_regs = {
-	.cmd_rcgr = BLSP1_QUP2_I2C_APPS_CMD_RCGR,
-	.cfg_rcgr = BLSP1_QUP2_I2C_APPS_CFG_RCGR,
-	/* mnd_width = 0 */
-};
-
-static const struct bcr_regs blsp1_qup3_i2c_apps_regs = {
-	.cmd_rcgr = BLSP1_QUP3_I2C_APPS_CMD_RCGR,
-	.cfg_rcgr = BLSP1_QUP3_I2C_APPS_CFG_RCGR,
-	/* mnd_width = 0 */
-};
-
-static const struct bcr_regs blsp1_qup4_i2c_apps_regs = {
-	.cmd_rcgr = BLSP1_QUP4_I2C_APPS_CMD_RCGR,
-	.cfg_rcgr = BLSP1_QUP4_I2C_APPS_CFG_RCGR,
-	/* mnd_width = 0 */
-};
-
 static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 
 	switch (clk->id) {
 	case GCC_BLSP1_UART2_APPS_CLK:
 		/* UART: 1843200Hz for a fixed 115200 baudrate (19200000 * (12/125)) */
-		clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 0, 12, 125,
+		clk_rcg_set_rate_mnd(priv->base, BLSP1_UART2_APPS_CMD_RCGR, 0, 12, 125,
 				     CFG_CLK_SRC_CXO, 16);
 		clk_enable_cbc(priv->base + BLSP1_UART2_APPS_CBCR);
 		return 1843200;
 	case GCC_SDCC1_APPS_CLK:
 		/* SDCC1: 200MHz */
-		clk_rcg_set_rate_mnd(priv->base, &sdc_regs, 7, 0, 0,
+		clk_rcg_set_rate_mnd(priv->base, SDCC_CMD_RCGR(0), 7, 0, 0,
 				     CFG_CLK_SRC_GPLL0, 8);
 		clk_enable_gpll0(priv->base, &gpll0_vote_clk);
 		clk_enable_cbc(priv->base + SDCC_APPS_CBCR(1));
 		return rate;
 	case GCC_ETH_RGMII_CLK:
 		if (rate == 250000000)
-			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 0, 0,
+			clk_rcg_set_rate_mnd(priv->base, EMAC_CMD_RCGR, 3, 0, 0,
 					     CFG_CLK_SRC_GPLL1, 8);
 		else if (rate == 125000000)
-			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 7, 0, 0,
+			clk_rcg_set_rate_mnd(priv->base, EMAC_CMD_RCGR, 7, 0, 0,
 					     CFG_CLK_SRC_GPLL1, 8);
 		else if (rate == 50000000)
-			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 19, 0, 0,
+			clk_rcg_set_rate_mnd(priv->base, EMAC_CMD_RCGR, 19, 0, 0,
 					     CFG_CLK_SRC_GPLL1, 8);
 		else if (rate == 5000000)
-			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 1, 50,
+			clk_rcg_set_rate_mnd(priv->base, EMAC_CMD_RCGR, 3, 1, 50,
 					     CFG_CLK_SRC_GPLL1, 8);
 		return rate;
 	}
 
@@ -236,9 +145,9 @@ static int qcs404_clk_enable(struct clk *clk)
 
 	switch (clk->id) {
 	case GCC_USB30_MASTER_CLK:
 		clk_enable_cbc(priv->base + USB30_MASTER_CBCR);
-		clk_rcg_set_rate_mnd(priv->base, &usb30_master_regs, 7, 0, 0,
+		clk_rcg_set_rate_mnd(priv->base, USB30_MASTER_CMD_RCGR, 7, 0, 0,
 				     CFG_CLK_SRC_GPLL0, 8);
 		break;
 	case GCC_SYS_NOC_USB3_CLK:
 		clk_enable_cbc(priv->base + SYS_NOC_USB3_CBCR);
@@ -258,16 +167,16 @@ static int qcs404_clk_enable(struct clk *clk)
 	case GCC_ETH_PTP_CLK:
 		/* SPEED_1000: freq -> 250MHz */
 		clk_enable_cbc(priv->base + ETH_PTP_CBCR);
 		clk_enable_gpll0(priv->base, &gpll1_vote_clk);
-		clk_rcg_set_rate_mnd(priv->base, &emac_ptp_regs, 3, 0, 0,
+		clk_rcg_set_rate_mnd(priv->base, EMAC_PTP_CMD_RCGR, 3, 0, 0,
 				     CFG_CLK_SRC_GPLL1, 8);
 		break;
 	case GCC_ETH_RGMII_CLK:
 		/* SPEED_1000: freq -> 250MHz */
 		clk_enable_cbc(priv->base + ETH_RGMII_CBCR);
 		clk_enable_gpll0(priv->base, &gpll1_vote_clk);
-		clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 0, 0,
+		clk_rcg_set_rate_mnd(priv->base, EMAC_CMD_RCGR, 3, 0, 0,
 				     CFG_CLK_SRC_GPLL1, 8);
 		break;
 	case GCC_ETH_SLAVE_AHB_CLK:
 		clk_enable_cbc(priv->base + ETH_SLAVE_AHB_CBCR);
@@ -279,29 +188,29 @@ static int qcs404_clk_enable(struct clk *clk)
 		clk_enable_vote_clk(priv->base, &gcc_blsp1_ahb_clk);
 		break;
 	case GCC_BLSP1_QUP0_I2C_APPS_CLK:
 		clk_enable_cbc(priv->base + BLSP1_QUP0_I2C_APPS_CBCR);
-		clk_rcg_set_rate(priv->base, &blsp1_qup0_i2c_apps_regs, 0,
+		clk_rcg_set_rate(priv->base, BLSP1_QUP0_I2C_APPS_CMD_RCGR, 0,
 				 CFG_CLK_SRC_CXO);
 		break;
 	case GCC_BLSP1_QUP1_I2C_APPS_CLK:
 		clk_enable_cbc(priv->base + BLSP1_QUP1_I2C_APPS_CBCR);
-		clk_rcg_set_rate(priv->base, &blsp1_qup1_i2c_apps_regs, 0,
+		clk_rcg_set_rate(priv->base, BLSP1_QUP1_I2C_APPS_CMD_RCGR, 0,
 				 CFG_CLK_SRC_CXO);
 		break;
 	case GCC_BLSP1_QUP2_I2C_APPS_CLK:
 		clk_enable_cbc(priv->base + BLSP1_QUP2_I2C_APPS_CBCR);
-		clk_rcg_set_rate(priv->base, &blsp1_qup2_i2c_apps_regs, 0,
+		clk_rcg_set_rate(priv->base, BLSP1_QUP2_I2C_APPS_CMD_RCGR, 0,
 				 CFG_CLK_SRC_CXO);
 		break;
 	case GCC_BLSP1_QUP3_I2C_APPS_CLK:
 		clk_enable_cbc(priv->base + BLSP1_QUP3_I2C_APPS_CBCR);
-		clk_rcg_set_rate(priv->base, &blsp1_qup3_i2c_apps_regs, 0,
+		clk_rcg_set_rate(priv->base, BLSP1_QUP3_I2C_APPS_CMD_RCGR, 0,
 				 CFG_CLK_SRC_CXO);
 		break;
 	case GCC_BLSP1_QUP4_I2C_APPS_CLK:
 		clk_enable_cbc(priv->base + BLSP1_QUP4_I2C_APPS_CBCR);
-		clk_rcg_set_rate(priv->base, &blsp1_qup4_i2c_apps_regs, 0,
+		clk_rcg_set_rate(priv->base, BLSP1_QUP4_I2C_APPS_CMD_RCGR, 0,
 				 CFG_CLK_SRC_CXO);
 		break;
 	case GCC_SDCC1_AHB_CLK:
 		clk_enable_cbc(priv->base + SDCC_AHB_CBCR(1));
diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index babd83119e2c..ccb0cf245d33 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -18,15 +18,9 @@
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
 
 #include "clock-qcom.h"
 
-#define SE9_AHB_CBCR		0x25004
-#define SE9_UART_APPS_CBCR	0x29004
 #define SE9_UART_APPS_CMD_RCGR	0x18148
-#define SE9_UART_APPS_CFG_RCGR	0x1814C
-#define SE9_UART_APPS_M		0x18150
-#define SE9_UART_APPS_N		0x18154
-#define SE9_UART_APPS_D		0x18158
 
 static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
 	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
 	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
@@ -45,25 +39,17 @@ static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
 	F(128000000, CFG_CLK_SRC_GPLL0, 1, 16, 75),
 	{ }
 };
 
-static const struct bcr_regs uart2_regs = {
-	.cfg_rcgr = SE9_UART_APPS_CFG_RCGR,
-	.cmd_rcgr = SE9_UART_APPS_CMD_RCGR,
-	.M = SE9_UART_APPS_M,
-	.N = SE9_UART_APPS_N,
-	.D = SE9_UART_APPS_D,
-};
-
 static ulong sdm845_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
 
 	switch (clk->id) {
 	case GCC_QUPV3_WRAP1_S1_CLK: /* UART9 */
 		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
-		clk_rcg_set_rate_mnd(priv->base, &uart2_regs,
+		clk_rcg_set_rate_mnd(priv->base, SE9_UART_APPS_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 16);
 		return freq->freq;
 	default:
 		return 0;

-- 
2.44.0

