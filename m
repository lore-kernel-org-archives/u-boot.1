Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA75BC54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 11:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A954087F58;
	Mon, 11 Mar 2024 12:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vAzKQQt3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01CBC87F63; Mon, 11 Mar 2024 12:11:14 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91C1D87E1E
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 12:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dd81aee2b4so16016935ad.0
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 04:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710155469; x=1710760269; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=seKN50Etda75U/FJdHIIcqKTArRh0uu3C+V9JBF2uLU=;
 b=vAzKQQt3HIT+CgURI2Hq+zwCfrg8NcCyvR0cxYfDFVsY7ZC+jA4NMH0c1PTJZD0qWi
 dfaGFLHUb02VR/YRveZ/sdKpULKHUcNsOhEXsVCCkJGrsT78pvwLiYVoQxMPj7hvLPfO
 8oxj4q3IQrnHGpV7ICSJr/6xK2a9JURhtmxrwPibuuS/YwynN4uPLhyAwcxsk1tIHULT
 GkZQ9iWdN02VZqLIMq2YNfwi7nOmbTlaTsOyW12NcvQjFPkz0dfK60SlYP4lhuzsB1HM
 BN4SBqq1fjkqW/eYjTf+FK4+fpqEFzpMtDzyP1yPSLwy5lM17JPPqSZLoKPUpCWcD0J+
 1xcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710155469; x=1710760269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=seKN50Etda75U/FJdHIIcqKTArRh0uu3C+V9JBF2uLU=;
 b=l5P756Gp0pBx0vfcCuM/316PvgOPD2z1LdW5pBVRmoEDsL7ao6ezVb202pwPHcrUVd
 oi2iq5BMcCS9Bj3RNrJxrsvqIAZAt9TnrQKBLMVAgBpwu/eub6oCHwaH6NV4uzMppVV0
 1OOwZekdJedEVM7FBa3yMaAIqGHwXJ0QYP6M2qs4BPyqDELalf7PGLwk19IbQoZocJt8
 F6ZoYTylERrswuwn/ho5hxx05jbSnhqS8oypMvBFzVY/rXxYlvMTl07G9y+UZUUVMbfT
 gfs9nOJnLlYwFPuorOSC7DaqmmARXjlrQbBfgV2haQvVmnptjNYqaBMR1B7YyXVhNC35
 FNwA==
X-Gm-Message-State: AOJu0Yx8HA0QbKghsoWeBkP4t+L7HA2Wk7jy35hdJmM30hdkfRYrHi2u
 ph4WH/ciQ8drsVcfhvh3tpyBjl9mBUJjGtz3vYM2KRduSBw3JOd8x/kmQiAnRwe1vNPtFpESSjw
 r
X-Google-Smtp-Source: AGHT+IEzr85IY0PgzjsbXcYA2MrAnZfZ29mfBccHg3kDpwBzmk+SpsCJris0FqWYYkDpEUi2kYYWIA==
X-Received: by 2002:a17:903:2448:b0:1dd:68be:5d0a with SMTP id
 l8-20020a170903244800b001dd68be5d0amr8383018pls.18.1710155469701; 
 Mon, 11 Mar 2024 04:11:09 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.249]) by smtp.gmail.com with ESMTPSA id
 o13-20020a170902d4cd00b001dd8ce888aasm2877895plg.74.2024.03.11.04.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 04:11:09 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 4/5] pinctrl: qcom: Add support for driving GPIO pins output
Date: Mon, 11 Mar 2024 16:40:25 +0530
Message-Id: <20240311111027.44577-5-sumit.garg@linaro.org>
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

Add support for driving the GPIO pins as output low or high.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-apq8016.c |  1 +
 drivers/pinctrl/qcom/pinctrl-qcom.c    | 26 +++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
index cb0e2227079..04b501c563d 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
@@ -29,6 +29,7 @@ static const char * const msm_pinctrl_pins[] = {
 };
 
 static const struct pinctrl_function msm_pinctrl_functions[] = {
+	{"gpio", 0},
 	{"blsp_uart1", 2},
 	{"blsp_uart2", 2},
 };
diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
index ee0624df296..932be7c4840 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcom.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
@@ -29,15 +29,25 @@ struct msm_pinctrl_priv {
 #define GPIO_CONFIG_REG(priv, x) \
 	(qcom_pin_offset((priv)->data->pin_data.pin_offsets, x))
 
-#define TLMM_GPIO_PULL_MASK GENMASK(1, 0)
-#define TLMM_FUNC_SEL_MASK GENMASK(5, 2)
-#define TLMM_DRV_STRENGTH_MASK GENMASK(8, 6)
-#define TLMM_GPIO_DISABLE BIT(9)
+#define GPIO_IN_OUT_REG(priv, x) \
+	(GPIO_CONFIG_REG(priv, x) + 0x4)
+
+#define TLMM_GPIO_PULL_MASK	GENMASK(1, 0)
+#define TLMM_FUNC_SEL_MASK	GENMASK(5, 2)
+#define TLMM_DRV_STRENGTH_MASK	GENMASK(8, 6)
+#define TLMM_GPIO_OUTPUT_MASK	BIT(1)
+#define TLMM_GPIO_OE_MASK	BIT(9)
+
+/* GPIO_IN_OUT register shifts. */
+#define GPIO_IN          0
+#define GPIO_OUT         1
 
 static const struct pinconf_param msm_conf_params[] = {
 	{ "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 2 },
 	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
 	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 3 },
+	{ "output-high", PIN_CONFIG_OUTPUT, 1, },
+	{ "output-low", PIN_CONFIG_OUTPUT, 0, },
 };
 
 static int msm_get_functions_count(struct udevice *dev)
@@ -89,7 +99,7 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
 		return 0;
 
 	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
-			TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE,
+			TLMM_FUNC_SEL_MASK | TLMM_GPIO_OE_MASK,
 			priv->data->get_function_mux(func_selector) << 2);
 	return 0;
 }
@@ -117,6 +127,12 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 		clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
 				TLMM_GPIO_PULL_MASK, argument);
 		break;
+	case PIN_CONFIG_OUTPUT:
+		writel(argument << GPIO_OUT,
+		       priv->base + GPIO_IN_OUT_REG(priv, pin_selector));
+		setbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
+			     TLMM_GPIO_OE_MASK);
+		break;
 	default:
 		return 0;
 	}
-- 
2.34.1

