Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D412DC4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF4F787F46;
	Thu, 15 Feb 2024 21:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DdUHhffP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FA7687F3D; Thu, 15 Feb 2024 21:53:07 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7897887EA8
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4123a978c5bso1177785e9.0
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030358; x=1708635158; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3GVKB9TZxGQCtHffbEC5D+XYWKSvOMTt9VrOAssBWTI=;
 b=DdUHhffPhyv2gaCR+5o6HLao5SryK9d/jatHKTRA/CMgB6QQijEb8fAwBWtXrBYorU
 u9iLRwzl3gtbkEvJ/Z4vYIEKN1j5bwqOPIfdxAiyWxv93UR68/R329UL7oFD/D98BSNw
 puAPDSSyT2nsLEk9WjlPi4aXJBUhCOBP9nyosgrRooLsXOYgqpuDJMCffH84r6hc5xfX
 Qm4b898+MexX4nM/wHOvCJ08gQw0wnFt3pW8ohLC0fu6XMA3VxYZRxAAOx5btcxdcDVA
 lXBfEFFUsJQtoV6yA8LjcAIyhns5VppbDDIJFz8n142WI4fDa9VWqyLrkvCZ63cCPREH
 LtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030358; x=1708635158;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3GVKB9TZxGQCtHffbEC5D+XYWKSvOMTt9VrOAssBWTI=;
 b=WczEBxtz8WesVPuOg0HlKVMAWgfkhPpWzJjhjs0fPkb0Uye3N5yce4BBxyJskt0qsT
 mlVfhNlOpBpuoMfvk7sp6ujyKeTzEo1+c9g9v7Q2v1nuK/nM0q+2tul96WogCGB+VPAa
 2U7v05WBcebKj4BOi+GR7GqJJdw0hs7D4AZh4rUa7LYNR7uOJzcf0TIaTLRCGR7U6put
 fzSH4Vv9LTYvPJt0b87oLB46MRR4RMx4VeDxzb+PkdQ4BskLpzN1SsM+8OK7bA9rLd74
 TL5Gl64bLBYp5CcwnSQHtjJKfPsBwdY4GKoNVLxaWTXE5Wg8zZhOAbepvQt5fOJ7DPc5
 DOkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU02ca5XTV+ryydEUXExoB53/Iqj7C+0weH5STsguwJ8JFEwU9zuCPOdgc0jenKTw6MY37zg4EsIJDSOm4QAe6OJKKQyQ==
X-Gm-Message-State: AOJu0YwgBSgXC5uvEmoc0cik1tZh1hzog4gGKDRrk8NPArbxQuNCsVUs
 nA2EnbpTDZ+P8zR4PYc2bcABND2a1WS8aZB/gC28nbcxmGCGFCkvQqBIAVFcKQcFf2mPqacCkWO
 i
X-Google-Smtp-Source: AGHT+IFd+YL4sF8DY34aS2f4tlHlY2ydSJHynA0lx2Iso2ljIl1LzmsjgUy9Idin1HeWfhJOAYB+JQ==
X-Received: by 2002:a05:600c:22c3:b0:411:e634:8376 with SMTP id
 3-20020a05600c22c300b00411e6348376mr2077350wmg.40.1708030357873; 
 Thu, 15 Feb 2024 12:52:37 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:37 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:31 +0000
Subject: [PATCH v4 13/39] pinctrl: qcom: stub support for special GPIOs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-13-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=4868;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=hyRICjcWmmCFzNiar5uKZ8GGRgwI9Iveld+459uWwUU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzla2zdjfHbyj7NsX5rXHCv4g/H7O2xp7cVul++YnT9
 PeFxpJhHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAi/l6MDG3Cn/a3xk55PotD
 T/NMTHvWMt6j1w2OWml6bpPN8ja5+JmRYfkh44zFZuoXRXO5FRdIHP3X/b43dEOn+XnHE34dz1f
 PqwYA
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

Most platforms have a handful of "special" GPIOs, like the MMC
clock/data lanes, UFS reset, etc. These don't follow the usually naming
scheme of "gpioX" and also have unique capabilities and registers. We
can get away without supporting them all for now, but DT compatibility
is still an issue.

Add support for allowing these to be specified after the other pins, and
make all pinmux/pinconf calls for them nop.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/include/mach/gpio.h |  2 ++
 drivers/gpio/msm_gpio.c                      | 20 ++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-qcom.c          | 12 ++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/arm/mach-snapdragon/include/mach/gpio.h b/arch/arm/mach-snapdragon/include/mach/gpio.h
index 8dac62f870b9..c373f5a4cf3d 100644
--- a/arch/arm/mach-snapdragon/include/mach/gpio.h
+++ b/arch/arm/mach-snapdragon/include/mach/gpio.h
@@ -13,6 +13,8 @@
 struct msm_pin_data {
 	int pin_count;
 	const unsigned int *pin_offsets;
+	/* Index of first special pin, these are ignored for now */
+	unsigned int special_pins_start;
 };
 
 static inline u32 qcom_pin_offset(const unsigned int *offs, unsigned int selector)
diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
index 80cd28bb231f..8a5e8730e911 100644
--- a/drivers/gpio/msm_gpio.c
+++ b/drivers/gpio/msm_gpio.c
@@ -39,6 +39,10 @@ static int msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
+	/* Always NOP for special pins, assume they're in the correct state */
+	if (gpio >= priv->pin_data->special_pins_start)
+		return 0;
+
 	/* Disable OE bit */
 	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(dev, gpio),
 			GPIO_OE_MASK, GPIO_OE_DISABLE);
@@ -50,6 +54,10 @@ static int msm_gpio_set_value(struct udevice *dev, unsigned int gpio, int value)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
+	/* Always NOP for special pins, assume they're in the correct state */
+	if (gpio >= priv->pin_data->special_pins_start)
+		return 0;
+
 	value = !!value;
 	/* set value */
 	writel(value << GPIO_OUT, priv->base + GPIO_IN_OUT_REG(dev, gpio));
@@ -62,6 +70,10 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned int gpio,
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
+	/* Always NOP for special pins, assume they're in the correct state */
+	if (gpio >= priv->pin_data->special_pins_start)
+		return 0;
+
 	value = !!value;
 	/* set value */
 	writel(value << GPIO_OUT, priv->base + GPIO_IN_OUT_REG(dev, gpio));
@@ -76,6 +88,10 @@ static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
+	/* Always NOP for special pins, assume they're in the correct state */
+	if (gpio >= priv->pin_data->special_pins_start)
+		return 0;
+
 	return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) >> GPIO_IN);
 }
 
@@ -83,6 +99,10 @@ static int msm_gpio_get_function(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
+	/* Always NOP for special pins, assume they're in the correct state */
+	if (gpio >= priv->pin_data->special_pins_start)
+		return 0;
+
 	if (readl(priv->base + GPIO_CONFIG_REG(dev, gpio)) & GPIO_OE_ENABLE)
 		return GPIOF_OUTPUT;
 
diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
index dc3d8c4d9034..1ea4d21c41fc 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcom.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
@@ -83,6 +83,10 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
 {
 	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
 
+	/* Always NOP for special pins, assume they're in the correct state */
+	if (pin_selector >= priv->data->pin_data.special_pins_start)
+		return 0;
+
 	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
 			TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE,
 			priv->data->get_function_mux(func_selector) << 2);
@@ -94,6 +98,10 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 {
 	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
 
+	/* Always NOP for special pins */
+	if (pin_selector >= priv->data->pin_data.special_pins_start)
+		return 0;
+
 	switch (param) {
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		argument = (argument / 2) - 1;
@@ -136,6 +144,10 @@ int msm_pinctrl_bind(struct udevice *dev)
 	const char *name;
 	int ret;
 
+	/* Make sure we don't indadvertently treat all pins as special pins. */
+	if (!data->pin_data.special_pins_start)
+		data->pin_data.special_pins_start = data->pin_data.pin_count;
+
 	drv = lists_driver_lookup_name("pinctrl_qcom");
 	if (!drv)
 		return -ENOENT;

-- 
2.43.1

