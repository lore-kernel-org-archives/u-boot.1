Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C5EC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:52:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A18B683AB0;
	Thu, 10 Apr 2025 10:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s7V1gD05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ADE183AC6; Thu, 10 Apr 2025 10:52:43 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEA1C83A8E
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c14016868so403839f8f.1
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 01:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744275160; x=1744879960; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4pSY7OTXYWA3g9Rl519Wa/I4rXH68hLb3xe5WsVoLQs=;
 b=s7V1gD05+CGssRIr2CRubWUeP1oHZt2/UbuHg/EIMXGWP81la1QTMMEMkmyIaaK/H9
 toAhbRWSp8xS5dcMCSs0glreEz4gavtKxabeCwzytyaJ8y+iAkrasPVOBxJscMbN4lsz
 RWWTv1FBRhMxNUtoAAivV9MB8Y30xvGwbLDkC/QfpndDJxLju3UFgZJtqOZhVBvHHrl1
 TcqsGVIFNF7N1ab3j34Hxb+VxNm+pC4/RYh8FnTM/Q45zidtUVdh7NoX9+qAkKb/0iTp
 T7DdHRaEP10AN/G9YBHwIkgIU8+gmbWMJs/Iaqh6XoibuCBmokfzBDKPH4IkhhpHWmdu
 RuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744275160; x=1744879960;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4pSY7OTXYWA3g9Rl519Wa/I4rXH68hLb3xe5WsVoLQs=;
 b=kpBMTRX+7QlfL3QLRy7MKaXfv2R6eqhDJr515Vj30tNKgiZua6MXJYFTAvX4LtwYUq
 Ky9MRQiuZtf5U//KaIafnAOCQI0tQDQMMJjdgJ6DV62CuDPP6PwLeHahvo5GaETGrLb9
 eq+JifcqLzbBuEw2MRHNMIvFFSf17+ZvzcCqhz41mXzpf71IVMyAw6o2t0T27h/k0qVj
 95D+LGm55nj5awX4LufQFA4ONGYmuK9HMOcoJBAt8wd2TAYN9LCZu8k9h70hPi2sVxfG
 jW2hPrXwqZ2Sbvprsb4WgQLzrUvEVBr91832N+AYDaTEkr1VisqJxVVcKdRrJJh/mUHG
 eIXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzSev4zh/YMzFTZuug14FUamnVA+4RH8VEchnoX+wf/godFfCh4MJGButREAQgiNVnT0O9QnM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9wXNDwbxgMFdpldcmIjtd2YjsqU4bnUoUjH8+vJXepsF3T/jq
 iJsUmCWdNdpL2YJzsYauiffZiWpH1XAIfmQS86UgkiO2AKZyZy7qgDUh7LhnZFM=
X-Gm-Gg: ASbGncstnlim3UZXegRfsrLYAMv68JCx5bzgNcELoRe+eh3/m1J0H98xA5h5kVCYg6H
 UTEtXhDWi0y1Wgmiww48spiKkqz/Y4KcJjZ3Uit10SgFHx9a+J36wQoAHA0gP0TehMI6tBqPJ22
 dCqErOMrFJTNui04vbMj5wowutE4rv9vuKd2SpuEXOYPyYCQ7fSi6VU/QX/AexCI2wAomUR7Mii
 w+wsHqVhOXVtxyg0wmplJV8X/FkHBOUfizquFn6eucm2oyU7WjhPBDfstbp6p4QvqCtX1E83MAy
 8DS1kEW1JMr/Jn0uTYbBoOGK+8JlNL21QiIZuSNhJ6foqVD8CXuRhBvlnPkzibhnO6uk5ejZ
X-Google-Smtp-Source: AGHT+IHemCAk69tF60oNfv6AZNyekeLywa8INhoI9nVGxnbrTgbX6BI3KAIUk7G2DD76zB7rcKLUYQ==
X-Received: by 2002:a5d:64e8:0:b0:391:4914:3c6a with SMTP id
 ffacd0b85a97d-39d8fd50d90mr1198266f8f.29.1744275160261; 
 Thu, 10 Apr 2025 01:52:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893f0a80sm4196974f8f.68.2025.04.10.01.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 01:52:39 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Thu, 10 Apr 2025 10:52:38 +0200
Subject: [PATCH v2] pinctrl: qcom: handle reserved ranges
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-topic-sm8x50-pinctrl-reserved-ranges-v2-1-654488392b9a@linaro.org>
X-B4-Tracking: v=1; b=H4sIANWG92cC/5WNTQqDMBBGryJZd0riT9Wueo/iIsZRB2wSJhIs4
 t0bvUGX74PvvV0EZMIgntkuGCMFcjZBfsuEmbWdEGhILHKZV7KUClbnyUD4NFslwZM1Ky/AmDQ
 RB+DzEqBvC6OHh9FjX4ik8owjbVfm3SWeKayOv1c1qnP9MxAVKJAjNk1ftqqW9Wshq9ndHU+iO
 47jB+2BTO/ZAAAA
X-Change-ID: 20250401-topic-sm8x50-pinctrl-reserved-ranges-b93cad6cafb3
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6699;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ghjAMBvSyG+3NoLzn5VBG+1qWjFBFEr5GFQYTmRZK64=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn94bX+WBL5iYVp3wP1HKYeiE0puFZRL0CcBxHXE1H
 Q4AsqB6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ/eG1wAKCRB33NvayMhJ0XoND/
 4slnVwTyGmOthMqfPhr0YfCKY8ssl4F8vty7S6Q8BaLbCeFXCXGbTbA3rnAYbBtlb0GXF4eiZjhkA0
 zOMP7WWh5RgLowi6kyqfFm+/My3TrAUgsS6CmXR1dTCaZdyaMq6voXgQ2xurlecn6cYhKAtGZce4Kt
 ONkmP7ULJj+KiS8uaw516EINUQl1x0usyfqcTpgZ3LjcBKvmlsvm7ulyty49em+cyidYMIwMGThE2E
 U7aNIJUa0XR3p4iTD1bzVJ8EGyiKZO/odXSP7Uk2iLKyFkDzMn2q6eTby6jMtYuIoheZIKy7qQBxZI
 1oBorGjtI5RYo9hI8CdQF/A6V2JXMdVKNEXAbpckiRHa/EDTO7qODIw18PTcs95PtWHmvORBTgaQbg
 IuuOuBvRS95QtRuckZl8WH/4NhLmknpzaJp75t2/uxYbmb87bySpEXWXn1gkkk+E8vGUJaz8e88l/R
 zvH+RCeT1W5fLazzN3uw3MJfAmtiKL1SFSTWdtLN5X9C9QrIG2IgG+JoqKhfIVt0jWBm/psrlfLl1V
 qeY/k4HO9YSJqpDW50Qo61n5YiwLSFahK7XUUdcbToTLhaz3AzFaTfdk6lYshDBaTd7BYeLo45nd+g
 YXaw9B7uGJ2dn53eqRhI3HQcutLEY2fK0/Gl1GZOYe4MGQhtjNa6EBSwjocQ==
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
Changes in v2:
- Switch to bitmap
- Link to v1: https://lore.kernel.org/r/20250401-topic-sm8x50-pinctrl-reserved-ranges-v1-1-0fe88b491707@linaro.org
---
 arch/arm/mach-snapdragon/include/mach/gpio.h | 15 +++++++
 drivers/gpio/msm_gpio.c                      |  9 ++++
 drivers/pinctrl/qcom/pinctrl-qcom.c          | 67 ++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)

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
index 24d031947a3c00da352fee8b50d5ad38e2d93dfa..c95db56bc47ed3183822fcef2721fc00262b6182 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcom.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
@@ -15,14 +15,18 @@
 #include <asm/gpio.h>
 #include <dm/pinctrl.h>
 #include <linux/bitops.h>
+#include <linux/bitmap.h>
 #include <linux/bug.h>
 #include <mach/gpio.h>
 
 #include "pinctrl-qcom.h"
 
+#define MSM_PINCTRL_MAX_PINS 256
+
 struct msm_pinctrl_priv {
 	phys_addr_t base;
 	struct msm_pinctrl_data *data;
+	DECLARE_BITMAP(reserved_map, MSM_PINCTRL_MAX_PINS);
 };
 
 #define GPIO_CONFIG_REG(priv, x) \
@@ -71,13 +75,60 @@ static const char *msm_get_function_name(struct udevice *dev,
 	return priv->data->get_function_name(dev, selector);
 }
 
+static int msm_pinctrl_parse_ranges(struct udevice *dev)
+{
+	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
+	ofnode node = dev_ofnode(dev);
+	int ret, count, i;
+	u32 *ranges;
+
+	if (ofnode_read_prop(node, "gpio-reserved-ranges", &count)) {
+		if (count % 2 == 1) {
+			dev_err(dev, "gpio-reserved-ranges must be a multiple of 2\n");
+			return -EINVAL;
+		}
+
+		ranges = malloc(count);
+		if (!ranges)
+			return -ENOMEM;
+
+		ret = ofnode_read_u32_array(node, "gpio-reserved-ranges", ranges, count / 4);
+		if (ret) {
+			dev_err(dev, "failed to read gpio-reserved-ranges array (%d)\n", ret);
+			return ret;
+		}
+
+		for (i = 0; i < count / 4; i += 2) {
+			if (ranges[i] >= MSM_PINCTRL_MAX_PINS ||
+			    (ranges[i] + ranges[i + 1]) >= MSM_PINCTRL_MAX_PINS) {
+				dev_err(dev, "invalid reserved-range (%d;%d)\n",
+					ranges[i], ranges[i + 1]);
+				return -EINVAL;
+			}
+
+			bitmap_set(priv->reserved_map, ranges[i], ranges[i + 1]);
+		}
+
+		free(ranges);
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
 
@@ -97,6 +148,9 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
 	if (func < 0)
 		return func;
 
+	if (msm_pinctrl_is_reserved(dev, pin_selector))
+		return -EPERM;
+
 	/* Always NOP for special pins, assume they're in the correct state */
 	if (qcom_is_special_pin(&priv->data->pin_data, pin_selector))
 		return 0;
@@ -145,6 +199,9 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 {
 	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
 
+	if (msm_pinctrl_is_reserved(dev, pin_selector))
+		return -EPERM;
+
 	if (qcom_is_special_pin(&priv->data->pin_data, pin_selector))
 		return msm_pinconf_set_special(priv, pin_selector, param, argument);
 
@@ -241,3 +298,13 @@ U_BOOT_DRIVER(pinctrl_qcom) = {
 	.ops		= &msm_pinctrl_ops,
 	.probe		= msm_pinctrl_probe,
 };
+
+bool msm_pinctrl_is_reserved(struct udevice *dev, unsigned int pin)
+{
+	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
+
+	if (pin >= MSM_PINCTRL_MAX_PINS)
+		return false;
+
+	return test_bit(pin, priv->reserved_map);
+}

---
base-commit: 5ca70325b64f760bf4190f206a0e88dda495e3d2
change-id: 20250401-topic-sm8x50-pinctrl-reserved-ranges-b93cad6cafb3

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

