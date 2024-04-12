Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FA4C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 09:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0814880A8;
	Fri, 12 Apr 2024 11:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IafP0z1M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7158587E01; Fri, 12 Apr 2024 11:55:03 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBAFE881A8
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-23333dddd8aso490478fac.1
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 02:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712915698; x=1713520498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3AUYOq/ItyiLEj7tgmFcxT0Ld2W+iat/2830EavHflU=;
 b=IafP0z1Me3DHMn69NYv8O7rQ4SpnvzGA+zU1jF8oTDIEjjfuGLlVgKCaA3Kx2Iig5J
 1YEjFN4cO5EOk7njXKh3LLn68HZj8UFnYSxKFB/db4H+UP/Q7A4OfBmIxoBJ7uoOoWlJ
 QRGjsw1k34FKtnrsQOxst6/RdT++YoSlV51UJu7oXkYqKAfTIJg1VW2zqDMN9CRW9K/a
 kBe6LQbt8RFpWL0vy0tkotQobjDCzy/RUEr/eb3NMnW7Kze1OgFN5vvGv1ZBBU7qEm1e
 um54fM9ptsv2283FkMdiKZWuJJ6+QrkDgPxpxILy8RTjuEZjZVLk5l0Bi/M9DegTp9wq
 p3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712915698; x=1713520498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3AUYOq/ItyiLEj7tgmFcxT0Ld2W+iat/2830EavHflU=;
 b=hnLdQg2vmUk1dwQxcA8s/wHYrZhYmexs5ZU4LLkcizKgWJTHx4GINWm7ZBQqYWEwQK
 oZOheUnF50CfVNgmHf7s5eLsAEO+S5GHc7WQ2X71xAVmm2BlqxsOeYELhNVwjKYwVjhk
 4gnOyZJF3aucdfx9dsdBuvj+NCzbrm0d9l6RoFGuFVv8cRrwyWHOhKU6xDPNhoYXEVul
 LgxAU3Q6m9GRTJpBruKU3CUN50JS/qdwNX0ClgfWn0tEfbxjFoELZi0ljL/J7FYLlivW
 g7fSA1yhiWKjjyL5iExagF9A5tUbRHdlv7pkJX1uThao26q/WtB9M5EEimYTevyYSJoI
 UvnQ==
X-Gm-Message-State: AOJu0YyBLZaDXKFW2XpN23vV5o9vNyOGln7vuVtV+Wl7fLMMxhyN+cgf
 9muRg/mLHTay8yoQHANEYJHkiNk+UDV93e0Tq6NDlFtFOGS+WJ+W1gYtQNRUUM7evWHkUPn7eMV
 y
X-Google-Smtp-Source: AGHT+IG6WjXbaiQqjQPoyyShmXalRysiuyx3chNQueIASp3IPYNOLI4TSs3CyFc31365PLTbPXjyWg==
X-Received: by 2002:a05:6870:1656:b0:22e:8406:5bc4 with SMTP id
 c22-20020a056870165600b0022e84065bc4mr2209238oae.32.1712915698355; 
 Fri, 12 Apr 2024 02:54:58 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.92]) by smtp.gmail.com with ESMTPSA id
 bn19-20020a056a00325300b006ed0b798f1fsm2534839pfb.119.2024.04.12.02.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 02:54:58 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 2/7] apq8016: Add support for UART1 clocks and pinmux
Date: Fri, 12 Apr 2024 15:24:33 +0530
Message-Id: <20240412095438.410570-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412095438.410570-1-sumit.garg@linaro.org>
References: <20240412095438.410570-1-sumit.garg@linaro.org>
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

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/clk/qcom/clock-apq8016.c       | 38 ++++++++++++++++++--------
 drivers/pinctrl/qcom/pinctrl-apq8016.c |  1 +
 drivers/serial/serial_msm.c            | 11 ++++++--
 3 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index 5a5868169c8..9556b94774a 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -31,7 +31,8 @@
 #define BLSP1_AHB_CBCR			0x1008
 
 /* Uart clock control registers */
-#define BLSP1_UART2_BCR			(0x3028)
+#define BLSP1_UART1_APPS_CBCR		(0x203C)
+#define BLSP1_UART1_APPS_CMD_RCGR	(0x2044)
 #define BLSP1_UART2_APPS_CBCR		(0x302C)
 #define BLSP1_UART2_APPS_CMD_RCGR	(0x3034)
 
@@ -52,7 +53,7 @@ static struct vote_clk gcc_blsp1_ahb_clk = {
 };
 
 /* SDHCI */
-static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
+static int apq8016_clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
 {
 	int div = 15; /* 100MHz default */
 
@@ -70,20 +71,35 @@ static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
 }
 
 /* UART: 115200 */
-int apq8016_clk_init_uart(phys_addr_t base)
+int apq8016_clk_init_uart(phys_addr_t base, unsigned long id)
 {
+	u32 cmd_rcgr, apps_cbcr;
+
+	switch (id) {
+	case GCC_BLSP1_UART1_APPS_CLK:
+		cmd_rcgr = BLSP1_UART1_APPS_CMD_RCGR;
+		apps_cbcr = BLSP1_UART1_APPS_CBCR;
+		break;
+	case GCC_BLSP1_UART2_APPS_CLK:
+		cmd_rcgr = BLSP1_UART2_APPS_CMD_RCGR;
+		apps_cbcr = BLSP1_UART2_APPS_CBCR;
+		break;
+	default:
+		return 0;
+	}
+
 	/* Enable AHB clock */
 	clk_enable_vote_clk(base, &gcc_blsp1_ahb_clk);
 
 	/* 7372800 uart block clock @ GPLL0 */
-	clk_rcg_set_rate_mnd(base, BLSP1_UART2_APPS_CMD_RCGR, 1, 144, 15625,
-			     CFG_CLK_SRC_GPLL0, 16);
+	clk_rcg_set_rate_mnd(base, cmd_rcgr, 1, 144, 15625, CFG_CLK_SRC_GPLL0,
+			     16);
 
 	/* Vote for gpll0 clock */
 	clk_enable_gpll0(base, &gpll0_vote_clk);
 
 	/* Enable core clk */
-	clk_enable_cbc(base + BLSP1_UART2_APPS_CBCR);
+	clk_enable_cbc(base + apps_cbcr);
 
 	return 0;
 }
@@ -94,14 +110,12 @@ static ulong apq8016_clk_set_rate(struct clk *clk, ulong rate)
 
 	switch (clk->id) {
 	case GCC_SDCC1_APPS_CLK: /* SDC1 */
-		return clk_init_sdc(priv, 0, rate);
-		break;
+		return apq8016_clk_init_sdc(priv, 0, rate);
 	case GCC_SDCC2_APPS_CLK: /* SDC2 */
-		return clk_init_sdc(priv, 1, rate);
-		break;
+		return apq8016_clk_init_sdc(priv, 1, rate);
+	case GCC_BLSP1_UART1_APPS_CLK: /* UART1 */
 	case GCC_BLSP1_UART2_APPS_CLK: /* UART2 */
-		return apq8016_clk_init_uart(priv->base);
-		break;
+		return apq8016_clk_init_uart(priv->base, clk->id);
 	default:
 		return 0;
 	}
diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
index a9a00f4b081..1ee8b7db1a2 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
@@ -29,6 +29,7 @@ static const char * const msm_pinctrl_pins[] = {
 };
 
 static const struct pinctrl_function msm_pinctrl_functions[] = {
+	{"blsp_uart1", 2},
 	{"blsp_uart2", 2},
 };
 
diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index ac4280c6c4c..4de10e75191 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -248,12 +248,17 @@ static struct msm_serial_data init_serial_data = {
 #include <debug_uart.h>
 
 /* Uncomment to turn on UART clocks when debugging U-Boot as aboot on MSM8916 */
-//int apq8016_clk_init_uart(phys_addr_t gcc_base);
+//int apq8016_clk_init_uart(phys_addr_t gcc_base, unsigned long id);
 
 static inline void _debug_uart_init(void)
 {
-	/* Uncomment to turn on UART clocks when debugging U-Boot as aboot on MSM8916 */
-	//apq8016_clk_init_uart(0x1800000);
+	/*
+	 * Uncomment to turn on UART clocks when debugging U-Boot as aboot
+	 * on MSM8916. Supported debug UART clock IDs:
+	 *   - db410c: GCC_BLSP1_UART2_APPS_CLK
+	 *   - HMIBSC: GCC_BLSP1_UART1_APPS_CLK
+	 */
+	//apq8016_clk_init_uart(0x1800000, <uart_clk_id>);
 	uart_dm_init(&init_serial_data);
 }
 
-- 
2.34.1

