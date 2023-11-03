Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FB0C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 15:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FF56870F9;
	Fri,  3 Nov 2023 16:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eHEV030h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACE47871BC; Fri,  3 Nov 2023 16:39:43 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C72D787442
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 16:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40839652b97so17187915e9.3
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699025977; x=1699630777; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fMbXIXnECZxGhPjwKiSfziTy4guaY4PcbkbwqEfcYLk=;
 b=eHEV030hc3+p3WjGYbySqtTykApSLqOeHZQhATkegnYTu64K/BCuzY+hgcdqs7SW0h
 iNzjxQLiQ8Mj6xhIDgZuuKgbvP6RtJWWiZJwaBa9hZI8i/7Cl9DDlk96POZoQq7XvvAQ
 PjGmrY1vwML0l0HSixoxVlRZlvRDO/bnYVbtufm6xMbDxLi30Z5YV+B7ky8bt1rHL/ay
 XrV/jEYgwxOEP56gma0SI9mxP4S6YVvzS9eP6wWqy8naAHudhWLudiHxhhmAL5tYHvEl
 Lpwxeo6wdYEnxtTD+qtmLTucFbH9YfsEYHj52kf74wf4AFmUx/Am0qG1HJQEppwcSrir
 sikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699025977; x=1699630777;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fMbXIXnECZxGhPjwKiSfziTy4guaY4PcbkbwqEfcYLk=;
 b=h2vCxFAWxo63pnG4vcq1OV5ZSDKY9sUF9XVqcwaPgsgco6AvI9dXb/Dm7MQ++TNaB9
 wqPOZ7spOHkvT1/ZozDYd/dfau/KxGiL+O0K/CpfTX3UvfaZclfq4qtyyf7lSAWuG5GR
 gKfOr36a+fpGjCe49Hc2kMfUF1HKb+YKi6axbAH8tRg+hDE3hlVJHEG7Utk2Gs65MkSl
 tv2eHQE6NXhwIEgow+b3nClmrVN258HaA+XzlzFeLq6vY3O5bb1JGAnzqSA5QOLIaDaQ
 5Jdi/GDpm78N8wShh625WqfvPmrJE8v7IpAJXcBdI1+BOKFd8tVmLgzMMZeH1NWV1qk1
 7LLg==
X-Gm-Message-State: AOJu0YziKktcbnui4U2joJPoe3n4KOaTwOtzLMH8n8CwU7w1KswBvmcF
 B9hpwZPAiFf14Led7kXdswwwdg==
X-Google-Smtp-Source: AGHT+IGco2FWbPRiZLcnC25eu9Y8QaAZhgKN6m6WRKiyqcquBEKM9SMpFOT+Ewe4W5qO3hduoogazg==
X-Received: by 2002:a05:600c:4751:b0:401:bdf9:c336 with SMTP id
 w17-20020a05600c475100b00401bdf9c336mr19871341wmo.27.1699025977335; 
 Fri, 03 Nov 2023 08:39:37 -0700 (PDT)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 fm15-20020a05600c0c0f00b00405391f485fsm2928334wmb.41.2023.11.03.08.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 08:39:36 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 03 Nov 2023 15:39:30 +0000
Subject: [PATCH v3 6/7] clk/qcom: add mnd_width to clk_rcg_set_rate_mnd()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231103-b4-qcom-clk-v3-6-8d2d460ece84@linaro.org>
References: <20231103-b4-qcom-clk-v3-0-8d2d460ece84@linaro.org>
In-Reply-To: <20231103-b4-qcom-clk-v3-0-8d2d460ece84@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7629;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=4mR5gEGefr7wi8ZSKCFtu2J5qMX8Gb5zFKaxzx94xDg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlRXEUOv4MdhM6qcZSurViQmdrBqMs1ua+1uDv5r9tXg0
 uLDc8M6SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwESEGBj+uyR1hh3wYZprff/e
 78pI42lFKvc5wrJFC5fo190VX5PawciwneuduIVLSvMZxpULVyR7B+iZr3MrkyrgfWdaFDV9hpM
 RAA==
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
index 3f44252c453e..630619c83454 100644
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
+			     CFG_CLK_SRC_GPLL0, 8);
 
 	/* Vote for gpll0 clock */
 	clk_enable_gpll0(priv->base, &gpll0_vote_clk);
diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index 75633a7c2af8..095c1b431245 100644
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
+			     CFG_CLK_SRC_GPLL0, 8);
 
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
index 9ad580b50fc8..921abf1f699b 100644
--- a/drivers/clk/qcom/clock-qcs404.c
+++ b/drivers/clk/qcom/clock-qcs404.c
@@ -195,7 +195,7 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
 	case GCC_BLSP1_UART2_APPS_CLK:
 		/* UART: 115200 */
 		clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 0, 12, 125,
-				     CFG_CLK_SRC_CXO);
+				     CFG_CLK_SRC_CXO, 8);
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

