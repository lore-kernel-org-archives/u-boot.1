Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDC2C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 12:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31DC787257;
	Tue,  7 Nov 2023 13:41:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IcIm0KS7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67499871F5; Tue,  7 Nov 2023 13:41:22 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0642687225
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 13:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40853c639abso41054135e9.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 04:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699360878; x=1699965678; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oo8UikiH9q0eslaq3C7VR9Af0s/PeuXQUpgy/i4r+iA=;
 b=IcIm0KS7NzdHYDETieNSnVPS9DQzBZJibIfIPKxqsCui0W8wO0Ndx9tC8tDvaBX9ao
 BLxXH7MMpO0Vm9K2LLW5k1Rlo3HO9H9qOisNXGEBrFgOUApqKKdm7Q+ep7gCgpgAhvMO
 J/ekTGl/H+DPeZdDpRXwwZHPkNz4gij87dZeZK0I+/lE2r9TrxQpaSOmLSOAV08mf+YP
 zCWoOYMQwPjZNVPptLRsAsfbKpqCfGxvd8FxSRGIrFIdqQW1ikcXdlIgH+66WL9lmE44
 8mjXf5gGp4zgw47Vr5O0X+R/56qdXZo11M5ydAw+xCOw0/r7NfmFLQzmJes6x3yUlrbg
 THvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699360878; x=1699965678;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oo8UikiH9q0eslaq3C7VR9Af0s/PeuXQUpgy/i4r+iA=;
 b=CbS64yDY4ONY6InmTgNUmNy4QJIm7APzoUpEt/44AcTbkXy+/E/InhlTIs35EQxJxG
 LdzKMnnBVMthgFusMEyd3IXkOor04+Y/abBFrxHqnUpx2FEQnZnWB0pGqYeXaBuWuWgX
 ULzf8q+LGlR2KPRjIhT7iEL8sHtOrFsHzW0+83NnlCWXMu86eZaToMIfEk5HbsFYv8AH
 1ZlWMsx+PefLLbatnPpSJYhWAkQtuPZqpQWrpbByzKwu8j1DNatic5LUkHR0LvhNXhxP
 q5fP05LyhEVJcD+uME15bGxRw/rgB2TVn2vxmZcMuLyT8Igh0tRXMnH7r19MmFpLavrz
 dGrw==
X-Gm-Message-State: AOJu0Yw6Hy3iEZZQXQX1fQ3qowdJ6ppjn+CBxlJZueIMYyA+2/yxzR/k
 P25NkCYeMVWq2Bf6YoDpAh7zcw==
X-Google-Smtp-Source: AGHT+IGYLK2oOLPI13R5kvMGKBTDenLcmZF7+TcZnzq8KYlnTijeEPA2AzPlGi+7uhNwQfgTezXh+w==
X-Received: by 2002:a5d:6549:0:b0:32c:d0e0:3e70 with SMTP id
 z9-20020a5d6549000000b0032cd0e03e70mr22427876wrv.56.1699360878526; 
 Tue, 07 Nov 2023 04:41:18 -0800 (PST)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 v11-20020a5d610b000000b0032d09f7a713sm2285333wrt.18.2023.11.07.04.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 04:41:18 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 07 Nov 2023 12:41:04 +0000
Subject: [PATCH v4 6/7] clk/qcom: add mnd_width to clk_rcg_set_rate_mnd()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-b4-qcom-clk-v4-6-82bbaf1a796d@linaro.org>
References: <20231107-b4-qcom-clk-v4-0-82bbaf1a796d@linaro.org>
In-Reply-To: <20231107-b4-qcom-clk-v4-0-82bbaf1a796d@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=7632;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=oF90ZrZ1gbV0ByQxve/1UPJyYN6fBUmCdriWJHCOzAg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlQvg/QjK84osPUnu6YZuDUwMJz9u+9BpBLj18NSL9iyR
 b/m54R2lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgIncZGFk2JZr88/pAkvspbyd
 yV6yL6UWH2yedtpUQDCvc9PEav3X1Qz/s5Qfr2C+u/dsb7hY8HSdiv+LZ2dKNIap1D+p3FkWwBb
 2DgA=
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

This property is needed on some platforms to ensure that only the
relevant bits are set in the M/N/D registers.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/clk/qcom/clock-apq8016.c |  4 ++--
 drivers/clk/qcom/clock-apq8096.c |  4 ++--
 drivers/clk/qcom/clock-qcom.c    | 11 +++++++----
 drivers/clk/qcom/clock-qcom.h    |  2 +-
 drivers/clk/qcom/clock-qcs404.c  | 18 +++++++++---------
 drivers/clk/qcom/clock-sdm845.c  |  3 +--
 6 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index 3f44252c453e..498e8ef6780d 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -86,7 +86,7 @@ static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
 	clk_enable_cbc(priv->base + SDCC_AHB_CBCR(slot));
 	/* 800Mhz/div, gpll0 */
 	clk_rcg_set_rate_mnd(priv->base, &sdc_regs[slot], div, 0, 0,
-			     CFG_CLK_SRC_GPLL0);
+			     CFG_CLK_SRC_GPLL0, 8);
 	clk_enable_gpll0(priv->base, &gpll0_vote_clk);
 	clk_enable_cbc(priv->base + SDCC_APPS_CBCR(slot));
 
@@ -109,7 +109,7 @@ static int clk_init_uart(struct msm_clk_priv *priv)
 
 	/* 7372800 uart block clock @ GPLL0 */
 	clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 1, 144, 15625,
-			     CFG_CLK_SRC_GPLL0);
+			     CFG_CLK_SRC_GPLL0, 16);
 
 	/* Vote for gpll0 clock */
 	clk_enable_gpll0(priv->base, &gpll0_vote_clk);
diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index 75633a7c2af8..367c0f06ae20 100644
--- a/drivers/clk/qcom/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -69,7 +69,7 @@ static int clk_init_sdc(struct msm_clk_priv *priv, uint rate)
 
 	clk_enable_cbc(priv->base + SDCC2_AHB_CBCR);
 	clk_rcg_set_rate_mnd(priv->base, &sdc_regs, div, 0, 0,
-			     CFG_CLK_SRC_GPLL0);
+			     CFG_CLK_SRC_GPLL0, 8);
 	clk_enable_gpll0(priv->base, &gpll0_vote_clk);
 	clk_enable_cbc(priv->base + SDCC2_APPS_CBCR);
 
@@ -91,7 +91,7 @@ static int clk_init_uart(struct msm_clk_priv *priv)
 
 	/* 7372800 uart block clock @ GPLL0 */
 	clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 1, 192, 15625,
-			     CFG_CLK_SRC_GPLL0);
+			     CFG_CLK_SRC_GPLL0, 16);
 
 	/* Vote for gpll0 clock */
 	clk_enable_gpll0(priv->base, &gpll0_vote_clk);
diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 77bcaacd1583..fc478554f982 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -83,7 +83,7 @@ void clk_bcr_update(phys_addr_t apps_cmd_rcgr)
 
 /* root set rate for clocks with half integer and MND divider */
 void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
-			  int div, int m, int n, int source)
+			  int div, int m, int n, int source, u8 mnd_width)
 {
 	u32 cfg;
 	/* M value for MND divider. */
@@ -92,11 +92,14 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
 	u32 n_val = ~((n) - (m)) * !!(n);
 	/* NOT 2D value for MND divider. */
 	u32 d_val = ~(n);
+	u32 mask = BIT(mnd_width) - 1;
+
+	debug("m %#x n %#x d %#x div %#x mask %#x\n", m_val, n_val, d_val, div, mask);
 
 	/* Program MND values */
-	writel(m_val, base + regs->M);
-	writel(n_val, base + regs->N);
-	writel(d_val, base + regs->D);
+	writel(m_val & mask, base + regs->M);
+	writel(n_val & mask, base + regs->N);
+	writel(d_val & mask, base + regs->D);
 
 	/* setup src select and divider */
 	cfg  = readl(base + regs->cfg_rcgr);
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 86f9ff6eb2f6..24a32cb9666d 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -72,7 +72,7 @@ void clk_bcr_update(phys_addr_t apps_cmd_rgcr);
 void clk_enable_cbc(phys_addr_t cbcr);
 void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk);
 void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
-			  int div, int m, int n, int source);
+			  int div, int m, int n, int source, u8 mnd_width);
 void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
 		      int source);
 
diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
index 9ad580b50fc8..f234ab5d6541 100644
--- a/drivers/clk/qcom/clock-qcs404.c
+++ b/drivers/clk/qcom/clock-qcs404.c
@@ -195,7 +195,7 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
 	case GCC_BLSP1_UART2_APPS_CLK:
 		/* UART: 115200 */
 		clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 0, 12, 125,
-				     CFG_CLK_SRC_CXO);
+				     CFG_CLK_SRC_CXO, 16);
 		clk_enable_cbc(priv->base + BLSP1_UART2_APPS_CBCR);
 		break;
 	case GCC_BLSP1_AHB_CLK:
@@ -204,7 +204,7 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
 	case GCC_SDCC1_APPS_CLK:
 		/* SDCC1: 200MHz */
 		clk_rcg_set_rate_mnd(priv->base, &sdc_regs, 4, 0, 0,
-				     CFG_CLK_SRC_GPLL0);
+				     CFG_CLK_SRC_GPLL0, 8);
 		clk_enable_gpll0(priv->base, &gpll0_vote_clk);
 		clk_enable_cbc(priv->base + SDCC_APPS_CBCR(1));
 		break;
@@ -214,16 +214,16 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
 	case GCC_ETH_RGMII_CLK:
 		if (rate == 250000000)
 			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 2, 0, 0,
-					     CFG_CLK_SRC_GPLL1);
+					     CFG_CLK_SRC_GPLL1, 8);
 		else if (rate == 125000000)
 			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 4, 0, 0,
-					     CFG_CLK_SRC_GPLL1);
+					     CFG_CLK_SRC_GPLL1, 8);
 		else if (rate == 50000000)
 			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 10, 0, 0,
-					     CFG_CLK_SRC_GPLL1);
+					     CFG_CLK_SRC_GPLL1, 8);
 		else if (rate == 5000000)
 			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 2, 1, 50,
-					     CFG_CLK_SRC_GPLL1);
+					     CFG_CLK_SRC_GPLL1, 8);
 		break;
 	default:
 		return 0;
@@ -240,7 +240,7 @@ static int qcs404_clk_enable(struct clk *clk)
 	case GCC_USB30_MASTER_CLK:
 		clk_enable_cbc(priv->base + USB30_MASTER_CBCR);
 		clk_rcg_set_rate_mnd(priv->base, &usb30_master_regs, 4, 0, 0,
-				     CFG_CLK_SRC_GPLL0);
+				     CFG_CLK_SRC_GPLL0, 8);
 		break;
 	case GCC_SYS_NOC_USB3_CLK:
 		clk_enable_cbc(priv->base + SYS_NOC_USB3_CBCR);
@@ -262,14 +262,14 @@ static int qcs404_clk_enable(struct clk *clk)
 		clk_enable_cbc(priv->base + ETH_PTP_CBCR);
 		clk_enable_gpll0(priv->base, &gpll1_vote_clk);
 		clk_rcg_set_rate_mnd(priv->base, &emac_ptp_regs, 2, 0, 0,
-				     CFG_CLK_SRC_GPLL1);
+				     CFG_CLK_SRC_GPLL1, 8);
 		break;
 	case GCC_ETH_RGMII_CLK:
 		/* SPEED_1000: freq -> 250MHz */
 		clk_enable_cbc(priv->base + ETH_RGMII_CBCR);
 		clk_enable_gpll0(priv->base, &gpll1_vote_clk);
 		clk_rcg_set_rate_mnd(priv->base, &emac_regs, 2, 0, 0,
-				     CFG_CLK_SRC_GPLL1);
+				     CFG_CLK_SRC_GPLL1, 8);
 		break;
 	case GCC_ETH_SLAVE_AHB_CLK:
 		clk_enable_cbc(priv->base + ETH_SLAVE_AHB_CBCR);
diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index fc9a783f7354..6af1f38302d2 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -89,8 +89,7 @@ static ulong sdm845_clk_set_rate(struct clk *clk, ulong rate)
 	case GCC_QUPV3_WRAP1_S1_CLK: /* UART9 */
 		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, &uart2_regs,
-				     freq->pre_div, freq->m, freq->n, freq->src);
-
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
 		return freq->freq;
 	default:
 		return 0;

-- 
2.42.0

