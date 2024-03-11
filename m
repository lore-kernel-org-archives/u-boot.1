Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42347C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 11:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A572A87EFF;
	Mon, 11 Mar 2024 12:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tus1yyjJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BA1487DD3; Mon, 11 Mar 2024 12:11:05 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B334C87F3D
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 12:11:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dd81aee2b4so16015965ad.0
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 04:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710155460; x=1710760260; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwXGse+l23PHgPgrHvODcCdkPJjhR7UyLi5HUZ/u6KQ=;
 b=Tus1yyjJMXb4n2RYBHQK6zG12Gni//IvtsE117N0aTkJl94Xp+P+Ads5eXt/15h2WJ
 8aIpJZA4DoT8WP3/QeKFcrupdo7n9JfPR2UW3oJ3Gfm5y48R3UUJHcehZ+XO3mnuNJ0t
 mkFIS8PY8bOHCpHu1f3lFnf4NvFQHmSwwR3EgTpTyr+2SDlwO52oEpJGNE//kmzgN2HX
 pBqgMic+BPKsGbnp+eRw2k4vk2vGJw263d2wVmA9Ud7TO5c0K729dJ+x0qszX3c3ApP4
 dYj8Kqx4MsP7UkohE2v8aI/9h9pWB0u/4Vtt7xlQomJV1PP1Ul3XhHPdarsfNqsU6U45
 TEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710155460; x=1710760260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fwXGse+l23PHgPgrHvODcCdkPJjhR7UyLi5HUZ/u6KQ=;
 b=X/X91xOijPxNvHCXQ1aj8DnjNQpt+SvNH/HVoGa56vyLQgq5TXHmDG7gP8uNFMOTCb
 d60/oh5SJXlbPDjgRVwi7PPCwfz9xa4G4jH1MN+rEDUymrRdcrwlqfOZocXTxybMxrbA
 SoTwOQ8ObW97o3ioInCNGwvGXukCumLitTCU/LeuJ6qmiXfsz9LT9FVDa2lr5E/iIteY
 d9AE1ElwjFvQXBMmvQ0dOnBBzogjvgBKpS4k4ubnzwi2gOy9prc9VHeZ2Yo9HuWXasIL
 lWHlaJCzfNhh3q99gpoy7GHOXKRp4xKbNJrjwceLcQoZghxbKRwiziT5KnYSrGswmqWh
 ZxOg==
X-Gm-Message-State: AOJu0YzCQ8MvUaDbQ+3nLCkcVWNPe++bVlwjRu6kbeTUts/vH0r1GbTb
 Kf52BzL+9R4a0WkGsEE3yBWD4Kt8IKWBYuvDP6rwqukAsmkXYw5JPRvVJkK/1IIO1sz1lUkc+qS
 c
X-Google-Smtp-Source: AGHT+IHKESa5noW1gBbM/tkAqbuvcPHPJgaadqrNaGYOWRdl/0gvYWe+TxAPSTVfnYciiOVTRxxmWw==
X-Received: by 2002:a17:902:dac5:b0:1dd:9090:a36c with SMTP id
 q5-20020a170902dac500b001dd9090a36cmr5129102plx.45.1710155459950; 
 Mon, 11 Mar 2024 04:10:59 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.249]) by smtp.gmail.com with ESMTPSA id
 o13-20020a170902d4cd00b001dd8ce888aasm2877895plg.74.2024.03.11.04.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 04:10:59 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 2/5] apq8016: Add support for UART1 clocks and pinmux
Date: Mon, 11 Mar 2024 16:40:23 +0530
Message-Id: <20240311111027.44577-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311111027.44577-1-sumit.garg@linaro.org>
References: <20240311111027.44577-1-sumit.garg@linaro.org>
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

SE HMIBSC board uses UART1 as the main debug console, so add
corresponding clocks and pinmux support. Along with that update
instructions to enable clocks for debug UART support.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/clk/qcom/clock-apq8016.c       | 50 +++++++++++++++++++++-----
 drivers/pinctrl/qcom/pinctrl-apq8016.c |  1 +
 drivers/serial/serial_msm.c            |  6 ++--
 3 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index e6647f7c41d..a620a10a520 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -43,6 +43,14 @@
 #define BLSP1_UART2_APPS_N		(0x3040)
 #define BLSP1_UART2_APPS_D		(0x3044)
 
+#define BLSP1_UART1_BCR			(0x2038)
+#define BLSP1_UART1_APPS_CBCR		(0x203C)
+#define BLSP1_UART1_APPS_CMD_RCGR	(0x2044)
+#define BLSP1_UART1_APPS_CFG_RCGR	(0x2048)
+#define BLSP1_UART1_APPS_M		(0x204C)
+#define BLSP1_UART1_APPS_N		(0x2050)
+#define BLSP1_UART1_APPS_D		(0x2054)
+
 /* GPLL0 clock control registers */
 #define GPLL0_STATUS_ACTIVE BIT(17)
 
@@ -77,7 +85,7 @@ static struct vote_clk gcc_blsp1_ahb_clk = {
 };
 
 /* SDHCI */
-static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
+static int apq8016_clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
 {
 	int div = 15; /* 100MHz default */
 
@@ -94,6 +102,33 @@ static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
 	return rate;
 }
 
+static const struct bcr_regs uart1_regs = {
+	.cfg_rcgr = BLSP1_UART1_APPS_CFG_RCGR,
+	.cmd_rcgr = BLSP1_UART1_APPS_CMD_RCGR,
+	.M = BLSP1_UART1_APPS_M,
+	.N = BLSP1_UART1_APPS_N,
+	.D = BLSP1_UART1_APPS_D,
+};
+
+/* UART: 115200 */
+static int apq8016_clk_init_uart1(phys_addr_t base)
+{
+	/* Enable AHB clock */
+	clk_enable_vote_clk(base, &gcc_blsp1_ahb_clk);
+
+	/* 7372800 uart block clock @ GPLL0 */
+	clk_rcg_set_rate_mnd(base, &uart1_regs, 1, 144, 15625,
+			     CFG_CLK_SRC_GPLL0, 16);
+
+	/* Vote for gpll0 clock */
+	clk_enable_gpll0(base, &gpll0_vote_clk);
+
+	/* Enable core clk */
+	clk_enable_cbc(base + BLSP1_UART1_APPS_CBCR);
+
+	return 0;
+}
+
 static const struct bcr_regs uart2_regs = {
 	.cfg_rcgr = BLSP1_UART2_APPS_CFG_RCGR,
 	.cmd_rcgr = BLSP1_UART2_APPS_CMD_RCGR,
@@ -103,7 +138,7 @@ static const struct bcr_regs uart2_regs = {
 };
 
 /* UART: 115200 */
-int apq8016_clk_init_uart(phys_addr_t base)
+int apq8016_clk_init_uart2(phys_addr_t base)
 {
 	/* Enable AHB clock */
 	clk_enable_vote_clk(base, &gcc_blsp1_ahb_clk);
@@ -127,14 +162,13 @@ static ulong apq8016_clk_set_rate(struct clk *clk, ulong rate)
 
 	switch (clk->id) {
 	case GCC_SDCC1_APPS_CLK: /* SDC1 */
-		return clk_init_sdc(priv, 0, rate);
-		break;
+		return apq8016_clk_init_sdc(priv, 0, rate);
 	case GCC_SDCC2_APPS_CLK: /* SDC2 */
-		return clk_init_sdc(priv, 1, rate);
-		break;
+		return apq8016_clk_init_sdc(priv, 1, rate);
 	case GCC_BLSP1_UART2_APPS_CLK: /* UART2 */
-		return apq8016_clk_init_uart(priv->base);
-		break;
+		return apq8016_clk_init_uart2(priv->base);
+	case GCC_BLSP1_UART1_APPS_CLK: /* UART1 */
+		return apq8016_clk_init_uart1(priv->base);
 	default:
 		return 0;
 	}
diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
index db0e2124684..cb0e2227079 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
@@ -29,6 +29,7 @@ static const char * const msm_pinctrl_pins[] = {
 };
 
 static const struct pinctrl_function msm_pinctrl_functions[] = {
+	{"blsp_uart1", 2},
 	{"blsp_uart2", 2},
 };
 
diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index ac4280c6c4c..eaf024a55b0 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -248,12 +248,14 @@ static struct msm_serial_data init_serial_data = {
 #include <debug_uart.h>
 
 /* Uncomment to turn on UART clocks when debugging U-Boot as aboot on MSM8916 */
-//int apq8016_clk_init_uart(phys_addr_t gcc_base);
+//int apq8016_clk_init_uart1(phys_addr_t gcc_base);
+//int apq8016_clk_init_uart2(phys_addr_t gcc_base);
 
 static inline void _debug_uart_init(void)
 {
 	/* Uncomment to turn on UART clocks when debugging U-Boot as aboot on MSM8916 */
-	//apq8016_clk_init_uart(0x1800000);
+	//apq8016_clk_init_uart1(0x1800000);
+	//apq8016_clk_init_uart2(0x1800000);
 	uart_dm_init(&init_serial_data);
 }
 
-- 
2.34.1

