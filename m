Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC6AC67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 09:08:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7E0E884F2;
	Fri,  5 Apr 2024 11:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CrJEkROb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B02ED884CA; Fri,  5 Apr 2024 11:08:38 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83EF0884E6
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 11:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dff837d674so16835035ad.3
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 02:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712308115; x=1712912915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5mdOOExPAXMAEe+Bx+qErpp9/cMTqsnWS0nVCzdeW8=;
 b=CrJEkRObKUcMZh0zkJTMHukH6TIhLIgObPwvbdOGUZRB9VGBsG6gHERW474SzcNVQX
 ECJSaV+VGtdP+skDOSEkuI0x6r6EIHHIKF88C3JnYXk7EADpZVm+zVsb9bh/t2j554Fz
 x2N7L+pPtBLconGyw4sSc2PdwBwVpadfCmKssbNU86eRz6YWHU7wdo960wQM0ceK8yqy
 fR4+NhxoDY55zaZyMa4QtPOCJZVuMv34hxrkvoIfYxgT+yXg70IvmhiHFtT9mQDyoVlq
 Ej+IDpgkHY90yDB0smx+EB7BdmiMHpE0T8DjOzh5DBIUT2mIz9iHD78VaG+6//SUcfr+
 yJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712308115; x=1712912915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W5mdOOExPAXMAEe+Bx+qErpp9/cMTqsnWS0nVCzdeW8=;
 b=qsXnZC2YOKKk9emofbdmGln3uvW43P6OOrtBStAxi9bTtmWn7toOPCgmxfIH91Q7UW
 XOfpBkSxBXPEZoL1UpPxhGziIbswAM0kTXQOTJmED1cuHc1Q5hjKvCSVdFfXTnencb6o
 8UzldWU58KTWdqhsyKu3TZjhx/92SqTAnp9AGu9+z0BjZDBQ63A02w1g9GdYYejn4Jbv
 W0XyByPnjz/SLvAV+mbZCliO83GDJWrUavGdHWBQ8+dOIU2nyZt0t1VkFLR/u52BN1Qt
 FcM8eLBIVHH47UhJZNu48s0wRn5Ql68ppVUN1F9w63NwhF8dciBYfFXH1dN/3D7cqQiw
 8Zuw==
X-Gm-Message-State: AOJu0Yx5mddO+1xptZIQrWpIfk2TFFtuEcda2CIw+Xd4lYCOE2fXZNYB
 I3MJNGjN/f2dnIgFOZ240r5HhupvEOlq37FmtsN+X6ph9BUN4q/Ul3geWyPPlufpEDTnJ74Lw8n
 U
X-Google-Smtp-Source: AGHT+IG6TGE3q4kjRJFdVUFBpCYHEkOJ84JwPBcPeSVqkpQUL+eOy+hsHdL3akYpbnAHhu1e+tT6cA==
X-Received: by 2002:a17:903:1252:b0:1e2:8d7f:10ad with SMTP id
 u18-20020a170903125200b001e28d7f10admr967879plh.1.1712308114786; 
 Fri, 05 Apr 2024 02:08:34 -0700 (PDT)
Received: from sumit-X1.. ([223.178.208.62]) by smtp.gmail.com with ESMTPSA id
 k9-20020a170902c40900b001e2c0b77b53sm1055959plk.255.2024.04.05.02.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 02:08:34 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 2/6] apq8016: Add support for UART1 clocks and pinmux
Date: Fri,  5 Apr 2024 14:37:38 +0530
Message-Id: <20240405090742.4148304-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405090742.4148304-1-sumit.garg@linaro.org>
References: <20240405090742.4148304-1-sumit.garg@linaro.org>
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

