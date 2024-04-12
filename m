Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390E1C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 09:55:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A58B9881CD;
	Fri, 12 Apr 2024 11:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cDjxNxuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E87CC881CA; Fri, 12 Apr 2024 11:55:13 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 743BC881D7
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6ed2170d89fso1135127b3a.1
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 02:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712915709; x=1713520509; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQQFm53Y6noFLmaH27wGfZfjy164/8YCVf5iflGTt5w=;
 b=cDjxNxuXnlL67GGUoepR4ljQtz8Y7N73ys/iPsZF0hl/NR+kQm1JkLiU62fiYP8CHY
 8QjG8psg23eZ5lhyvVKLy4UZJELhrAdGFw7S8Vg38BU1pg8xHMWng4mcw2g1nf7BWsXP
 3uX6U4XtA7JeExFJE5ZkyFLiIXPennATyWJmQ8VqsDkLdR9mKW86rWd9foi1nAZ4UxnL
 bAJZn3z02vhC4wjQlHvxv9TRLCG55DZ0izmMEkaXcvOvxZy3Jkjs8HvurOL6GpCzDmyo
 Hfp/V7QOc7m9GIkjjpt1r+4835x2wrWynEVgvWDFTKRPWq73jUiQ1vJ9v8AKjLbur9LY
 n/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712915709; x=1713520509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQQFm53Y6noFLmaH27wGfZfjy164/8YCVf5iflGTt5w=;
 b=VT+sW4spcw2wGAJRGrQKx50VVAw0Nt8HhQfiyWh7jdzNgNzRYGexHNsbBBsG/46kID
 Ah6ZsaSjh3Y4cg7I7AcbH6AM2tvmXZuSg3M1TKr0cXGw2BG7hvydx9+3lDHq8EXyXneS
 Ifrj5y5/AtpyVyRp1kHyPcmUx34/6ApFLw93HxlP5vJQ/SLPW5OKVIeVq7HNfAaZfSOQ
 XAbibltuudfGyw0vAjon9AAreuNpEMTAYfNjT+RVv5FyUOE7qNGpJtSyMxayH0DK5O4Y
 Tr2qkOzike7JZMSB7rpOwmBsrhCnoNxSI1AmScnsIStQoISi0d7chY9o0yOIJqoqFPed
 FUuQ==
X-Gm-Message-State: AOJu0Yzyl66AzNwpdbU+AqsODpIncPSWwlzvHduv2pE7Hrn+4ot8BNht
 BucO4s7u733zt3EwcFYSuyOnWvQTOc91HVUl7ik+ZWVpL909x/bzG1KAy+m08MtxTD/53ZijcWT
 9
X-Google-Smtp-Source: AGHT+IFRy+5tUSiMSTJukyM3p9cJk4pDEaFFA8uYmi3El2vbtDvkgcWhnKUnzTET87lbO3bWGeHIeg==
X-Received: by 2002:a05:6a21:3e07:b0:1a7:a422:7394 with SMTP id
 bk7-20020a056a213e0700b001a7a4227394mr2727697pzc.17.1712915708383; 
 Fri, 12 Apr 2024 02:55:08 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.92]) by smtp.gmail.com with ESMTPSA id
 bn19-20020a056a00325300b006ed0b798f1fsm2534839pfb.119.2024.04.12.02.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 02:55:08 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 4/7] pinctrl: qcom: Add support for driving GPIO pins output
Date: Fri, 12 Apr 2024 15:24:35 +0530
Message-Id: <20240412095438.410570-5-sumit.garg@linaro.org>
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

Add support for driving the GPIO pins as output low or high.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-qcom.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
index 909e566acf5..e68971b37ff 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcom.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
@@ -29,15 +29,24 @@ struct msm_pinctrl_priv {
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
+/* GPIO register shifts. */
+#define GPIO_OUT_SHIFT		1
 
 static const struct pinconf_param msm_conf_params[] = {
 	{ "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 2 },
 	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
 	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 3 },
+	{ "output-high", PIN_CONFIG_OUTPUT, 1, },
+	{ "output-low", PIN_CONFIG_OUTPUT, 0, },
 };
 
 static int msm_get_functions_count(struct udevice *dev)
@@ -90,7 +99,7 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
 		return 0;
 
 	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
-			TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE, func << 2);
+			TLMM_FUNC_SEL_MASK | TLMM_GPIO_OE_MASK, func << 2);
 	return 0;
 }
 
@@ -117,6 +126,12 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 		clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
 				TLMM_GPIO_PULL_MASK, argument);
 		break;
+	case PIN_CONFIG_OUTPUT:
+		writel(argument << GPIO_OUT_SHIFT,
+		       priv->base + GPIO_IN_OUT_REG(priv, pin_selector));
+		setbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
+			     TLMM_GPIO_OE_MASK);
+		break;
 	default:
 		return 0;
 	}
-- 
2.34.1

