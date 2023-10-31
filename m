Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EC3C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 14:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6B3787CD5;
	Tue, 31 Oct 2023 15:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="exmKQ1BJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7C1187CE3; Tue, 31 Oct 2023 15:22:30 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E72887CCE
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 15:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c503da4fd6so83871861fa.1
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698762147; x=1699366947; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NhJkvsqeH26xhzz3On9J8EE5x3d4Voihs5NEbH/jPBA=;
 b=exmKQ1BJZP+h48HCM8LyqbAAY6g9eyhSvJVu5wyouSzzAfSThqMCm4FcHjX9VGaIOr
 6e7pzEddBnnXG1zxBViy3cgm4b7Cils7SmtOjw69ZW75+86zbSlH8wcnUv1sxgJiyrmM
 TtAQyZTQmlTvPHvL5gbVCqFpdHjLSwlg67h+St3OgPGIvvZZqS5wEWnYQCPsowYD0Aq6
 M/mq8obCaJ/6sU0aQBSaEdcGOmBkx85BqjJIdEYsZri9aLLECC58mBUsT39XKsyYwHrx
 Bx6Yb77H3gZmjsUQZ7pAq7oM6zGDNX+QTKCfk9dn1rY7mcJaCDWEst+TzaHeRU6ilz2D
 X1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698762147; x=1699366947;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NhJkvsqeH26xhzz3On9J8EE5x3d4Voihs5NEbH/jPBA=;
 b=Lhd/i5mvrgU0AjlVBtoGylf5xPeA6WMebmo6XDZ/MzVZx+ifLny89mehFxuRczfta/
 lrdtrRMgyLrdK271fnQfncZvczEd8BvpNVvkWufu7CrnRwznRCQm+LRqwf5pvuAZhmFx
 WPHCti5cOgLPaYQA52+nXaS8e121f0POTykmrwz3/jaeHy90kkphghu7zp7UIMqK19lY
 e0rOIasHL1RagicfgF9sVt5tfNoOv/pUM3DUdAAEIcLRT/M+EMcdkt/e2XoXlJlZTfEX
 tZTR5UtDw0Pum2hmpQJ1MPPtHZ+NdWlJFyTmCdmw/wbaTNqoGP/7irAvkSktKd8ip8z/
 hExA==
X-Gm-Message-State: AOJu0YwAT+JV3er/5gAc/UA0txK/h+Tp6vtKyW/5Mfeq1zZNYJhCQWC4
 MCrVXSZyg9HxbJHV2BC88NwAKQ==
X-Google-Smtp-Source: AGHT+IEvyKlqeFp7RVpSV5QqAdfVbDRCJHSriyveS7W1Cp2sAjVeIpEy4oLK/N2ssOClQTHvbNxIcw==
X-Received: by 2002:a2e:7214:0:b0:2c5:16c0:6239 with SMTP id
 n20-20020a2e7214000000b002c516c06239mr9418790ljc.51.1698762147388; 
 Tue, 31 Oct 2023 07:22:27 -0700 (PDT)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 i8-20020a05600011c800b0032179c4a46dsm1606372wrx.100.2023.10.31.07.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:22:26 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 31 Oct 2023 14:22:22 +0000
Subject: [PATCH 3/6] pinctrl: qcom: handle reserved ranges
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-b4-qcom-pinctrl-v1-3-9123d6a217eb@linaro.org>
References: <20231025-b4-qcom-pinctrl-v1-0-9123d6a217eb@linaro.org>
In-Reply-To: <20231025-b4-qcom-pinctrl-v1-0-9123d6a217eb@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=6450;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=0UA8x4Su+Co9GLP/yQeQXq0nmQNoFwaS3kSMCHitRRc=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlRH3nl75pg8O70wVW3+4i+Pz3ds/Kse4l1yoEaOqfB16
 xz1vccOd5SyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJbHzF8E8vdYdn2Ka0lQ9k
 Tz1nLe2zCr8Wbn3Y5uKFsjVXUlqPe4QzMrRGPsoJvVpx54j4MyPB3cdnlequ/Fy3+odYqbbtq1k
 beacCAA==
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

Some Qualcomm boards feature reserved ranges of pins which are protected
by firmware. Attempting to read or write any registers associated with
these pins results the board resetting.

Add support for parsing these ranges from devicetree and ensure that the
pinctrl and GPIO drivers don't try to interact with these pins.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/msm_gpio.c             | 15 +++++++++
 drivers/pinctrl/qcom/pinctrl-qcom.c | 64 +++++++++++++++++++++++++++++++++++++
 include/qcom-gpio.h                 | 15 +++++++++
 3 files changed, 94 insertions(+)

diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
index 7d77776a25fd..7a09abdafb2e 100644
--- a/drivers/gpio/msm_gpio.c
+++ b/drivers/gpio/msm_gpio.c
@@ -39,6 +39,9 @@ static int msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
+	if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
+		return 0;
+
 	/* Disable OE bit */
 	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(dev, gpio),
 			GPIO_OE_MASK, GPIO_OE_DISABLE);
@@ -50,6 +53,9 @@ static int msm_gpio_set_value(struct udevice *dev, unsigned gpio, int value)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
+	if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
+		return 0;
+
 	value = !!value;
 	/* set value */
 	writel(value << GPIO_OUT, priv->base + GPIO_IN_OUT_REG(dev, gpio));
@@ -62,6 +68,9 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned gpio,
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
+	if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
+		return 0;
+
 	value = !!value;
 	/* set value */
 	writel(value << GPIO_OUT, priv->base + GPIO_IN_OUT_REG(dev, gpio));
@@ -76,6 +85,9 @@ static int msm_gpio_get_value(struct udevice *dev, unsigned gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
+	if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
+		return 0;
+
 	return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) >> GPIO_IN);
 }
 
@@ -83,6 +95,9 @@ static int msm_gpio_get_function(struct udevice *dev, unsigned gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
+	if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
+		return GPIOF_UNKNOWN;
+
 	if (readl(priv->base + GPIO_CONFIG_REG(dev, gpio)) & GPIO_OE_ENABLE)
 		return GPIOF_OUTPUT;
 
diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
index fb255f9572f4..92b35c198788 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcom.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
@@ -20,9 +20,13 @@
 
 #include "pinctrl-qcom.h"
 
+#define MSM_PINCTRL_MAX_RESERVED_RANGES 32
+
 struct msm_pinctrl_priv {
 	phys_addr_t base;
 	struct msm_pinctrl_data *data;
+	u32 reserved_ranges[MSM_PINCTRL_MAX_RESERVED_RANGES * 2];
+	int reserved_ranges_count;
 };
 
 #define GPIO_CONFIG_REG(priv, x) \
@@ -61,13 +65,53 @@ static const char *msm_get_function_name(struct udevice *dev,
 	return priv->data->get_function_name(dev, selector);
 }
 
+static int msm_pinctrl_parse_ranges(struct udevice *dev)
+{
+	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
+	int count;
+
+	if (ofnode_read_prop(dev_ofnode(dev), "gpio-reserved-ranges",
+			     &count)) {
+		if (count % 2 == 1) {
+			dev_err(dev, "gpio-reserved-ranges must be a multiple of 2\n");
+			return -EINVAL;
+		}
+		/* Size is in bytes, but we're indexing by ints */
+		count /= 4;
+
+		if (count > MSM_PINCTRL_MAX_RESERVED_RANGES) {
+			dev_err(dev, "gpio-reserved-ranges must be less than %d (got %d)\n",
+				MSM_PINCTRL_MAX_RESERVED_RANGES, count);
+			return -EINVAL;
+		}
+
+		priv->reserved_ranges_count = count;
+		for (count = 0; count < priv->reserved_ranges_count; count++) {
+			if (ofnode_read_u32_index(dev_ofnode(dev), "gpio-reserved-ranges",
+						  count, &priv->reserved_ranges[count])) {
+				dev_err(dev, "failed to read gpio-reserved-ranges[%d]\n", count);
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int msm_pinctrl_probe(struct udevice *dev)
 {
 	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
+	int ret;
 
 	priv->base = dev_read_addr(dev);
 	priv->data = (struct msm_pinctrl_data *)dev_get_driver_data(dev);
 
+	ret = msm_pinctrl_parse_ranges(dev);
+	if (ret) {
+		printf("Couldn't parse reserved GPIO ranges!\n");
+		return ret;
+	}
+
 	return priv->base == FDT_ADDR_T_NONE ? -EINVAL : 0;
 }
 
@@ -83,6 +127,9 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
 {
 	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
 
+	if (msm_pinctrl_is_reserved(dev, pin_selector))
+		return 0;
+
 	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
 			TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE,
 			priv->data->get_function_mux(func_selector) << 2);
@@ -94,6 +141,9 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 {
 	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
 
+	if (msm_pinctrl_is_reserved(dev, pin_selector))
+		return 0;
+
 	switch (param) {
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		argument = (argument / 2) - 1;
@@ -178,3 +228,17 @@ U_BOOT_DRIVER(qcom_pinctrl) = {
 	.ops		= &msm_pinctrl_ops,
 	.probe		= msm_pinctrl_probe,
 };
+
+bool msm_pinctrl_is_reserved(struct udevice *dev, unsigned int pin)
+{
+	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
+	unsigned int i, start;
+
+	for (i = 0; i < priv->reserved_ranges_count; i += 2) {
+		start = priv->reserved_ranges[i];
+		if (pin >= start && pin < start + priv->reserved_ranges[i + 1])
+			return true;
+	}
+
+	return false;
+}
diff --git a/include/qcom-gpio.h b/include/qcom-gpio.h
index 8dac62f870b9..490a1de55f89 100644
--- a/include/qcom-gpio.h
+++ b/include/qcom-gpio.h
@@ -25,4 +25,19 @@ static inline u32 qcom_pin_offset(const unsigned int *offs, unsigned int selecto
 	return out;
 }
 
+struct udevice;
+
+/**
+ * msm_pinctrl_is_reserved() - Check if a pin lies in a reserved range
+ *
+ * @dev: pinctrl device
+ * @pin: Pin number
+ *
+ * Returns: true if pin is reserved, otherwise false
+ *
+ * Call using dev_get_parent() from the GPIO device, it is a child of
+ * the pinctrl device.
+ */
+bool msm_pinctrl_is_reserved(struct udevice *dev, unsigned int pin);
+
 #endif /* _QCOM_GPIO_H_ */

-- 
2.42.0

