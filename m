Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF5CC36008
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 07:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8006C81ECD;
	Tue,  1 Apr 2025 09:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KjQlRwL+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2371B81F32; Tue,  1 Apr 2025 09:46:30 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4190801BE
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 09:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so103151f8f.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 00:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743493587; x=1744098387; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KZtX+8a23zOLAnyEsx4vNjoZ2vUwlSrCnnolO7bm1Us=;
 b=KjQlRwL+bNsW5RqtTjTzEuaf4z3v9w0x6eRGol9gLhaBa1IxE9rn4mMtewsRmAH54x
 okQsP358DD+bXw6Msjh/g0yw1yC6B/Zx/WvP74gwo8hAqh20sz12oW3pyGqvsw5mglVh
 eq/7M/l7Z7x3zUZOmA0i5dg+2olZ2uVP21fVsZ0vBOm7CRABrzO+kr4+Qg8lQoFKlyQd
 qnbV6r7GrN2DW2/coL5DucPHiYkjebWmZ1hyP3Kjs/foc60mLwycZ300zOj06P+rsuN0
 ugTHXzi8Xph7Ps4MdsYpi8jTtnQ7fLPd3Y1SY75DQbuPLwoFy/S+C4f/xALJtzlZhwog
 /FcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743493587; x=1744098387;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KZtX+8a23zOLAnyEsx4vNjoZ2vUwlSrCnnolO7bm1Us=;
 b=Nv4oLlhzz5jV1BubCXDZNfPqaJ/87EWHJdnrLFAPFscne0Kmtby7RDMXVnJcf9qnSD
 qGJc1A7wJ6tYleyptdopzvkxYLp2eLEdY46sKhJmfA/vlXnHN6v7LnBJf+//BrYPV/1a
 PlIzhiu8ZCQDU0AEYnFpkZTWxLXg4RXLdwJ6Rw9Y9eejR8CeSvczRPdK40XYaVuwVft5
 7TxX9fj3VoACV/YmJPn9aDpy2iGB6e9dZebja9W/gLIObEmUdojGq+4Hk0YShw3aX6GG
 eoEh9H1Pn+kG8AaO4rpyyK6HAyUEo3MCjMQDUZCxYtfrn/6koXoCGIP2whGEDbzE1tTZ
 lwBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTgdj9R6uFTHyJaFBaoIrS7KmfUGv0RjKgInpELhII9FNZQIj3tlLXTuX6Yj6Wj66oKYbEVFI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy91hj01rCjJnQCYqZstEoipkjijZU34UlXviM/4FVPzRovgyR8
 Y35SvdsMZJAoQj55kNofPnSYXT0LRg+MSFEyZZOqEORinJh0URLG+lohFobfVVY=
X-Gm-Gg: ASbGncvljxlzCheVZipb/rjaneMckFp5zvOcLJgikvvMKeAAL+zWzXHOqHNffDirySt
 lo7dyS3OqdlmYTfd1h5E1WUyoIg+ATGVZ+P4f/07DQmmZia+KPj7uhHqMYs1QbLJR/24vJ6A6ai
 p1M4Gn2WrCWgGQnPLAfTU5ujt18oMiBDosBzsPYOaAruWlgyA+T9kdPgGocdO/mAJUl3Xle8Va7
 fyxuAAz4vBEN4nFyAjNSaq+K7Hn2DQhAgQTDBbu5PDShuLOeIadI4hKSY0pggDEkgDLUEXilb4t
 dSPotbvD2hM/5euM3PMJrA1NB/GUfvAtfpecom5I++5xH3DCZ73PvIxbSEXW37dA4sqZRluOljK
 D
X-Google-Smtp-Source: AGHT+IGdH3ydnpt+5rnHlGh4nh2MNQGtNx1RJxOgFJL/gdLdZ99uO034prk44lz9GYyR79+wdNDzeA==
X-Received: by 2002:a5d:59a9:0:b0:397:8f09:600 with SMTP id
 ffacd0b85a97d-39c120dc885mr9778620f8f.13.1743493587302; 
 Tue, 01 Apr 2025 00:46:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b663617sm13498226f8f.34.2025.04.01.00.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 00:46:27 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Tue, 01 Apr 2025 09:46:26 +0200
Subject: [PATCH] pinctrl: qcom: handle reserved ranges
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-topic-sm8x50-pinctrl-reserved-ranges-v1-1-0fe88b491707@linaro.org>
X-B4-Tracking: v=1; b=H4sIANGZ62cC/x2NywqDQAwAf0VybmB9YvsrxcOajRpo1yUREcR/d
 9vjHGbmBGMVNngVJyjvYrLGDOWjAFp8nBklZIbKVa1rXInbmoTQvv3ROkwSadMPKufMzgH1pxi
 Oz5p86MhPYw05lZQnOf6b93BdN0SNHBN2AAAA
X-Change-ID: 20250401-topic-sm8x50-pinctrl-reserved-ranges-b93cad6cafb3
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6507;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=vxWAcu0EO/HUdv3yinK3ljbeHNvEKApUsNjhcIU5pV4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn65nS9SbsO4ZQNB8vH19aIsJt7bBZmSCltqg6K5hy
 y9oxG+2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ+uZ0gAKCRB33NvayMhJ0WUPD/
 4pFuvMKWTlhup6ixLZM/JrWqLsA7xX2A9DaNBOsUsGuVwdOuaxzfWe3932O2+UInJeOwSFCNoZsuqz
 RoWNlBFdMho/5Y/4lIZ1+irEWQ7wTh08LUrjzQ8WxJQ2YldnBvrpAXh3mi+VjZ5whNw7WthHVxEVGk
 AqxHIvQ6FPxji9Q8r012avC5oTCrVpYcO++u9gY9xyrkg2sbUzUXhMVCEaukBQdMBokIED+wIrTKQy
 lHLmi13MQ4TYT5lNFY2/0GDjLK9Epec5jz69A9CUP51hERDF0mPh//rA4iYWx6ELgDEJ5612TvFbj3
 MeoUD2973fXhUL/XA4mlTl2jpndFcZIboUm6AD5HrCEAwamjd4WRAATZ/kg/5KLIqMbc3fr5AFeKB+
 qKjkrj/gHBcYfrEuh49I2jkv2jszQJuMtMH/IuY3xg9FQzy6OQzlK/X/tJrb37BxGfAApvNoxfR13b
 Poqpp/Ex1ytUNdAMvHXpkewRopaGJWrZL6Lqo1UlZ+F74lm3MTc3eTDhn8D9me9fH6XDuxEm0kC6m+
 P2ihVmvYNY4fGTNJ7NDQQJsR4ejruHjSrYJlkNtz/w9f14jHh5yUmHJeYSDenp18NTzY+JyvGmDSrv
 pWSrfXWHXKhvI8W9A0QJM/PSOfBSh+zzwcZqJjaehvXh2DQkqYyO8syDwC4A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

From: Caleb Connolly <caleb.connolly@linaro.org>

Some Qualcomm boards feature reserved ranges of pins which are protected
by firmware. Attempting to read or write any registers associated with
these pins results the board resetting.

Add support for parsing these ranges from devicetree and ensure that the
pinctrl and GPIO drivers don't try to interact with these pins.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/mach-snapdragon/include/mach/gpio.h | 15 +++++++
 drivers/gpio/msm_gpio.c                      |  9 ++++
 drivers/pinctrl/qcom/pinctrl-qcom.c          | 64 ++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/arch/arm/mach-snapdragon/include/mach/gpio.h b/arch/arm/mach-snapdragon/include/mach/gpio.h
index cc8f405e20b4392cf9226b805bc85b73aedd9134..11e8104baf2328f5bf82cb318459a237168f6978 100644
--- a/arch/arm/mach-snapdragon/include/mach/gpio.h
+++ b/arch/arm/mach-snapdragon/include/mach/gpio.h
@@ -46,4 +46,19 @@ static inline bool qcom_is_special_pin(const struct msm_pin_data *pindata, unsig
 	return pindata->special_pins_start && pin >= pindata->special_pins_start;
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
diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
index cea073b329777d4e03fbfa86415041a825f65aad..647a616a29374fcf12099509c51fb6e96b19f9f5 100644
--- a/drivers/gpio/msm_gpio.c
+++ b/drivers/gpio/msm_gpio.c
@@ -151,6 +151,9 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned int gpio,
 
 static int msm_gpio_set_flags(struct udevice *dev, unsigned int gpio, ulong flags)
 {
+	if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
+		return -EPERM;
+
 	if (flags & GPIOD_IS_OUT_ACTIVE) {
 		return msm_gpio_direction_output(dev, gpio, 1);
 	} else if (flags & GPIOD_IS_OUT) {
@@ -186,6 +189,9 @@ static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
+	if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
+		return -EPERM;
+
 	if (qcom_is_special_pin(priv->pin_data, gpio))
 		return msm_gpio_get_value_special(priv, gpio);
 
@@ -196,6 +202,9 @@ static int msm_gpio_get_function(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
+	if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
+		return GPIOF_UNKNOWN;
+
 	/* Always NOP for special pins, assume they're in the correct state */
 	if (qcom_is_special_pin(priv->pin_data, gpio))
 		return 0;
diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
index 24d031947a3c00da352fee8b50d5ad38e2d93dfa..3ef773d61a99e5d1a64078b9767febbfa9954ec2 100644
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
@@ -71,13 +75,53 @@ static const char *msm_get_function_name(struct udevice *dev,
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
 
@@ -97,6 +141,9 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
 	if (func < 0)
 		return func;
 
+	if (msm_pinctrl_is_reserved(dev, pin_selector))
+		return -EPERM;
+
 	/* Always NOP for special pins, assume they're in the correct state */
 	if (qcom_is_special_pin(&priv->data->pin_data, pin_selector))
 		return 0;
@@ -145,6 +192,9 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 {
 	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
 
+	if (msm_pinctrl_is_reserved(dev, pin_selector))
+		return -EPERM;
+
 	if (qcom_is_special_pin(&priv->data->pin_data, pin_selector))
 		return msm_pinconf_set_special(priv, pin_selector, param, argument);
 
@@ -241,3 +291,17 @@ U_BOOT_DRIVER(pinctrl_qcom) = {
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

---
base-commit: 5ca70325b64f760bf4190f206a0e88dda495e3d2
change-id: 20250401-topic-sm8x50-pinctrl-reserved-ranges-b93cad6cafb3

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

