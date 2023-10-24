Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21386C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 20:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72835879D4;
	Tue, 24 Oct 2023 22:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QIK6gYRV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 874C38716E; Tue, 24 Oct 2023 22:24:12 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81F39878A3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 22:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32dbbf3c782so80431f8f.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 13:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698179047; x=1698783847; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8dKWEVYUMajghYsygszrtlLsGARd/wSj0xzya2LHQuE=;
 b=QIK6gYRVvSZ04EULO/02CkrG5Aj+0blVae5kuoWljFFhP1TfEBpGg/T2bbj0gpES43
 71JiI7j5gckR9pckD0ttC1KKyrF2LAG+bSVHqJLFRITawYnaHY9Fi5Bd0D/w6Z0t0f9U
 qN1VhMMZT5fSGub15GPRcbwEo1n93foy2Ji4Lya1tf0+MH6JEiFRgevfRaRoVS0+HU6n
 IF2TWRWlNTcA7rpmcq7/XjHuT7UhgFocHzR9B5ltD2gQw+wNYm44HmUdjbz+84Y99rc0
 ZHRBUet1Ji0/2n7tX4yRTqztp1+GJ2j0ThYZ0kwnaXZ18nGDfZFfc2vqnvh3Ich9nDKd
 3mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698179047; x=1698783847;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8dKWEVYUMajghYsygszrtlLsGARd/wSj0xzya2LHQuE=;
 b=WN7r+vAGhdmduYfZ/xILAHb8LG8L8n60H+wRDm2a9NsPUz3PrPvvB2lH42VC74AGNI
 RlRDGDGnRjVqc9o0Gqbh3RhkFn/jeHL7XlZ+3dz8uiDgJ/VNpgv+iZITbUCVP0903IsX
 dSf5UkYG1tospjTxDeY/jMbMxEGpoWCSO3/tbLwINfCsXlkK1hBfbH+b+imPxcc1WyZG
 3HL5gS0mbeS2DBL+BLLTrCxm5c5AibTHuiVGmYwiZmrdmYnDsxeWexC3As1r8HLyrh1z
 9hyAa5Rbk/s7q5l7y2UilzhuC8K55bH8e8PNv053SzZmpsr0nm8h/nNa02SwLCbTfFZS
 G/WA==
X-Gm-Message-State: AOJu0YzXLlAsKLDF+Pzwr4w4TJccZOT3RsuNrMGwzNhadAzsZSNyKnZc
 88X2v7BDSU47E4swpJrT/OWUrQ==
X-Google-Smtp-Source: AGHT+IHGt8COeNVPAPYtodPtKfLSIioklnzVoAmUNrSxAk2GaeWsW9WqfiJatJ06tRpFYAfCpa5weg==
X-Received: by 2002:adf:ff85:0:b0:32d:87c9:1430 with SMTP id
 j5-20020adfff85000000b0032d87c91430mr12325420wrr.31.1698179046994; 
 Tue, 24 Oct 2023 13:24:06 -0700 (PDT)
Received: from lion.localdomain (host-2-99-112-229.as13285.net. [2.99.112.229])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a056000023500b003198a9d758dsm10682342wrz.78.2023.10.24.13.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 13:24:06 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 24 Oct 2023 21:23:58 +0100
Subject: [PATCH 7/8] clk/qcom: add mnd_width to clk_rcg_set_rate_mnd()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-b4-qcom-clk-v1-7-9d96359b9a82@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7826;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=uNCn1bNbsqTqPfS8eAHpli3siS/rP/haoM/M7GZxVoo=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlQL9VtW+tlPDz5bPqXs2rKpa2av1OtptWub+fvMfOXjV
 pOvmd+91VHKwiDIwSArpsgifmKZZdPay/Ya2xdcgJnDygQyhIGLUwAmoriE4b9bpX1Hve21lCqe
 rbPv/rJYtHX6lpTuAwpBhdanDZVUtjxnZOjPndi3e8vMB84v2SsVBbZtF82cLvQo03mnn8vL5Rs
 /ehwFAA==
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
---
 drivers/clk/qcom/clock-apq8016.c |  4 ++--
 drivers/clk/qcom/clock-apq8096.c |  4 ++--
 drivers/clk/qcom/clock-qcom.c    | 11 +++++++----
 drivers/clk/qcom/clock-qcom.h    |  2 +-
 drivers/clk/qcom/clock-qcs404.c  | 20 ++++++++++----------
 drivers/clk/qcom/clock-sdm845.c  |  3 +--
 6 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index f74f7a0f5ad9..5eba18739cfb 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -61,7 +61,7 @@ static int clk_init_sdc(struct qcom_cc_priv *priv, int slot, uint rate)
 	clk_enable_cbc(priv->base + SDCC_AHB_CBCR(slot));
 	/* 800Mhz/div, gpll0 */
 	clk_rcg_set_rate_mnd(priv->base, &sdc_regs[slot], div, 0, 0,
-			     CFG_CLK_SRC_GPLL0);
+			     CFG_CLK_SRC_GPLL0, 8);
 	clk_enable_gpll0(priv->base, &gpll0_vote_clk);
 	clk_enable_cbc(priv->base + SDCC_APPS_CBCR(slot));
 
@@ -84,7 +84,7 @@ static int clk_init_uart(struct qcom_cc_priv *priv)
 
 	/* 7372800 uart block clock @ GPLL0 */
 	clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 1, 144, 15625,
-			     CFG_CLK_SRC_GPLL0);
+			     CFG_CLK_SRC_GPLL0, 8);
 
 	/* Vote for gpll0 clock */
 	clk_enable_gpll0(priv->base, &gpll0_vote_clk);
diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index 1efb6e2313a5..48cac08eed67 100644
--- a/drivers/clk/qcom/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -48,7 +48,7 @@ static int clk_init_sdc(struct qcom_cc_priv *priv, uint rate)
 
 	clk_enable_cbc(priv->base + SDCC2_AHB_CBCR);
 	clk_rcg_set_rate_mnd(priv->base, &sdc_regs, div, 0, 0,
-			     CFG_CLK_SRC_GPLL0);
+			     CFG_CLK_SRC_GPLL0, 8);
 	clk_enable_gpll0(priv->base, &gpll0_vote_clk);
 	clk_enable_cbc(priv->base + SDCC2_APPS_CBCR);
 
@@ -70,7 +70,7 @@ static int clk_init_uart(struct qcom_cc_priv *priv)
 
 	/* 7372800 uart block clock @ GPLL0 */
 	clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 1, 192, 15625,
-			     CFG_CLK_SRC_GPLL0);
+			     CFG_CLK_SRC_GPLL0, 8);
 
 	/* Vote for gpll0 clock */
 	clk_enable_gpll0(priv->base, &gpll0_vote_clk);
diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index a9602d0c9ca6..7a6157bf123f 100644
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
+	setbits_le32(base + regs->M, m_val & mask);
+	setbits_le32(base + regs->N, n_val & mask);
+	setbits_le32(base + regs->D, d_val & mask);
 
 	/* setup src select and divider */
 	cfg  = readl(base + regs->cfg_rcgr);
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 4c5959b60038..6fa88fb40af8 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -70,7 +70,7 @@ void clk_bcr_update(phys_addr_t apps_cmd_rgcr);
 void clk_enable_cbc(phys_addr_t cbcr);
 void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk);
 void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
-			  int div, int m, int n, int source);
+			  int div, int m, int n, int source, u8 mnd_width);
 void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
 		      int source);
 
diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
index ce83ec741278..d10992ee58bf 100644
--- a/drivers/clk/qcom/clock-qcs404.c
+++ b/drivers/clk/qcom/clock-qcs404.c
@@ -113,7 +113,7 @@ static const struct bcr_regs blsp1_qup4_i2c_apps_regs = {
 	/* mnd_width = 0 */
 };
 
-ulong msm_set_rate(struct clk *clk, ulong rate)
+static ulong qcs404_set_rate(struct clk *clk, ulong rate)
 {
 	struct qcom_cc_priv *priv = dev_get_priv(clk->dev);
 
@@ -121,7 +121,7 @@ ulong msm_set_rate(struct clk *clk, ulong rate)
 	case GCC_BLSP1_UART2_APPS_CLK:
 		/* UART: 115200 */
 		clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 0, 12, 125,
-				     CFG_CLK_SRC_CXO);
+				     CFG_CLK_SRC_CXO, 8);
 		clk_enable_cbc(priv->base + BLSP1_UART2_APPS_CBCR);
 		break;
 	case GCC_BLSP1_AHB_CLK:
@@ -130,7 +130,7 @@ ulong msm_set_rate(struct clk *clk, ulong rate)
 	case GCC_SDCC1_APPS_CLK:
 		/* SDCC1: 200MHz */
 		clk_rcg_set_rate_mnd(priv->base, &sdc_regs, 4, 0, 0,
-				     CFG_CLK_SRC_GPLL0);
+				     CFG_CLK_SRC_GPLL0, 8);
 		clk_enable_gpll0(priv->base, &gpll0_vote_clk);
 		clk_enable_cbc(priv->base + SDCC_APPS_CBCR(1));
 		break;
@@ -140,16 +140,16 @@ ulong msm_set_rate(struct clk *clk, ulong rate)
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
@@ -166,7 +166,7 @@ static int qcs404_enable(struct clk *clk)
 	case GCC_USB30_MASTER_CLK:
 		clk_enable_cbc(priv->base + USB30_MASTER_CBCR);
 		clk_rcg_set_rate_mnd(priv->base, &usb30_master_regs, 4, 0, 0,
-				     CFG_CLK_SRC_GPLL0);
+				     CFG_CLK_SRC_GPLL0, 8);
 		break;
 	case GCC_SYS_NOC_USB3_CLK:
 		clk_enable_cbc(priv->base + SYS_NOC_USB3_CBCR);
@@ -188,14 +188,14 @@ static int qcs404_enable(struct clk *clk)
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
index 7b614f9661f0..9345d5293f1e 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -82,8 +82,7 @@ static ulong sdm845_set_rate(struct clk *clk, ulong rate)
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

