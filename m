Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2598BC67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 09:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20174884F0;
	Fri,  5 Apr 2024 11:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Sffkqgmh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DB85884CA; Fri,  5 Apr 2024 11:08:50 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63CE5884E6
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 11:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e0ae065d24so16348015ad.1
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 02:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712308124; x=1712912924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQQFm53Y6noFLmaH27wGfZfjy164/8YCVf5iflGTt5w=;
 b=Sffkqgmh/ElZMZhK+Xn6AOTO5IfwQlM0i/YActamxPMwtHQFOxV5Xa3+BZUGU/n1Xe
 9F6pU9mFSQguyGtDi1awwZF4pu3Yyyd89XvkJF2BUf1o7ZhUn25yTtMGKK2Yrr5m9vXA
 jKojawwh8lyIZBAgkKOxNDQmsMYK1186MP8qYTj6r36atOF8g0vHb+PRJRWawae7erCU
 WytPUzTwGksnN546k2+ozEJb0Ccchu5i9oWm/UL4TJBU/AFEoH2BbCH9uSQGFj3Pg9Ui
 OyvCFZ1+wnjr233DlPDBNshDp5SYLUHjLI4V1nDPPlYg6tt38icrPOUrSm13k3s1eR7p
 qoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712308124; x=1712912924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQQFm53Y6noFLmaH27wGfZfjy164/8YCVf5iflGTt5w=;
 b=X5T9CYDTSPkd0iWJGFheW3+wONEwI6wZtmAW0TEW4vCFxkpLHoQ/ySBD0MyVJ6EjVq
 Rd8gWrmZFdkTkSTskL7avJIqWRif7T6yqNbGTZvN6qYaybahTslp2FVyH8VgDzYzJ/kr
 jtH/ZSLLXrBI8mAIz5hoXntAwFdhoKiJXBA05YoMtphkZUekzLvelDAG7LhPOjZFjtWy
 vk0jBtp1F3U4t57YGEExzOHqgMuzzYkiISRm1cFqAOj3BvlQrT/40bAfGP4q1cMg5ue1
 h1FvPt6lCv6h4Sm3oiMejVCr2ydFaM2dwtBZKNMcy1MtdrnjZ7IdXBdUy5J1k6o1LYF4
 Rtgg==
X-Gm-Message-State: AOJu0Yzn2US6bHyf2RHg6X6HMUs2r8Sya0v4uAVMWp6xIvvJt7VM9hGx
 xIk861Yx2y+DQiCwwCz4XdJoU0eQK5BClq9okRb2JTnrpD97MJYKH8MQmmo9fX1boPIZ5NN2n2n
 U
X-Google-Smtp-Source: AGHT+IGaZmkZ6JkEcqbmXV+GhBYvuI5TlZfr3QRHfLIpeWtBcPtkZ72w3KKkr6QNl7vu+uv2XMpR2w==
X-Received: by 2002:a17:902:7449:b0:1e0:7f78:624d with SMTP id
 e9-20020a170902744900b001e07f78624dmr732533plt.57.1712308124663; 
 Fri, 05 Apr 2024 02:08:44 -0700 (PDT)
Received: from sumit-X1.. ([223.178.208.62]) by smtp.gmail.com with ESMTPSA id
 k9-20020a170902c40900b001e2c0b77b53sm1055959plk.255.2024.04.05.02.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 02:08:44 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 4/6] pinctrl: qcom: Add support for driving GPIO pins output
Date: Fri,  5 Apr 2024 14:37:40 +0530
Message-Id: <20240405090742.4148304-5-sumit.garg@linaro.org>
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

