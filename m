Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9999ECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 08:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A314F88F48;
	Tue, 10 Sep 2024 10:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DqdqKZst";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D98AF88861; Tue, 10 Sep 2024 10:58:22 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E072788F42
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 10:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cb7a2e4d6so17037755e9.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 01:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725958693; x=1726563493; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wiAtme929kZSm5f6Dxzpw/4FODGxe7FfO8rO9BH0BXE=;
 b=DqdqKZst8ukTtRhY4kLIqpZBBBDAAYJpWPBfXe1fr25UdZZlmWBGSQYaQFgV46UXz8
 0BMArSpxMmVgkwuAbEtBbwnazYEMzBh1Y0Yjjv9tvkOQLnJC9LFUZyOnrvig5UIjbShN
 +im8IwFHLt+YfJ2MSKCdYKpGcen9p/8GXovE3sM+MQd8+plznEZrc9Q3azzZ2ROggZQT
 bmsxvjb5V1BARxcNEtHErLjVP6daQ5c50wfm/5eqzOYlnCBMW3bVugWBkriuFfFvUSix
 2tR0RciLAyWpodLRN2fl3r98mUXP3HrPWyGDyOIWY1u5brJpsVG2IJ7Ox+xbyOKPjChH
 4HeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725958693; x=1726563493;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wiAtme929kZSm5f6Dxzpw/4FODGxe7FfO8rO9BH0BXE=;
 b=qL4/ytFyK+B4hhAeI7yaxmd9hzxMJ9ryAcT0NKRkVLhZyfSRU5fME52mvASuDrey6f
 qqaE7dBbwwlxHE933PBKWIkhadSodW7SRZVAFk9oVLFvTQ0BjDLX8vd0c0HYoz50dFrP
 nMuuuM0rpDEV/JlThvYv0a9uj43Y8lTwlYo+qPKmRP4OEQN8UWhCmTy1TMoP8TVLWgyc
 GSgfCecgvHmo0y0YR+TrWEJOCaLcZzUele/waY/WncgVnC1FU9MbNBZHtnk+eOYNJBSA
 5v7uOViV+VXTD+VZYMrBkHPVIPkq1UfF5QMMPlER/Gk5R0tIQs55DNVgpvRBg4xxpE8p
 FU8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9gyGc1DC5CBc0if6V/3FgDGBjTSU+kWBNra9JMwmU5ccnCA59vn1DGG8xmuzm2VRSBvbBWUw=@lists.denx.de
X-Gm-Message-State: AOJu0YzmzPRu5XJXaDfIzp69oftPpiYLTk+s/1R19jXaXq67fuN46IE7
 qeMEkiSyKug34opYoccZK7xGpJ9OHdgrn57/JMt+n+hhSNdNQqeDANMukhmmik4=
X-Google-Smtp-Source: AGHT+IEEzZKwINIU9yrOhzetphYZg4CH1SIqJqMMdB9TE1Ok0izrtYkX5mVvZvHVyjLabJfYcqbBXg==
X-Received: by 2002:a05:600c:5025:b0:42c:bc04:58a5 with SMTP id
 5b1f17b1804b1-42cbc0458c9mr24588025e9.33.1725958693364; 
 Tue, 10 Sep 2024 01:58:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cc01d4617sm12905325e9.0.2024.09.10.01.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 01:58:13 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 10 Sep 2024 10:58:06 +0200
Subject: [PATCH 1/2] gpio: msm: add support for special pins
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-sm8x50-msm-gpio-special-pins-sm8250-v1-1-50623a7e4931@linaro.org>
References: <20240910-topic-sm8x50-msm-gpio-special-pins-sm8250-v1-0-50623a7e4931@linaro.org>
In-Reply-To: <20240910-topic-sm8x50-msm-gpio-special-pins-sm8250-v1-0-50623a7e4931@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4823;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=hpzDe3p6sPzJQLFujHI5KRQb2puJ+WsxzjYzQ7F0P44=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4Aoj1m9xL+ZuhUjpjd4AP8VkihP+Y7h9y44sh8RD
 piNjGyGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAKIwAKCRB33NvayMhJ0SzeD/
 4weO9fPX1dVlqKIf5UduEteIOwyBcCRJs22qf/Flf8j9a1wsti5flm8bhPyTciZntofm6Fjsne7PTG
 CcFkjO6GCZHzLTN9kupsWKb7ROU0UQaKSx3U8bSrd1H9KEaZBEqRMr2jkUP1/FLoIC1iZPMA+0bBPg
 eDNEe/loT+kX0dwZ7tj2vxBeWYXSG41HeWsRhtP0n/5vrybZgCjhycyqnhjIlMOTGF/NBAF1Dbfzvk
 qJJP3rhwjBnMgB9/suWx7POrElcAhzui2atE1jxmJLAJGCLRC7tEwwCA6yyzW0oXau1nKqapJPKczl
 mTWZ7TTqn1W/qF5TUDnqv1+DcFFVLx7vY/K6Yow9XfKGKgco7ydK733MClZWAJIFhoFJnB9plPRPuU
 wWFfPWlWhaZoDv/yfxImhCuL98ZxecHiftMF/i5HNWnmi+RuB7h+RFpURHHN66xB3Zpg7bvSdTs0dv
 NfzAJmbqtgNmWiURIcIBfUR0BV4vgUqvfwn2w9qp2h7Y7p/JTc/aX+jA8Dsikyn9I2OechnTAKcxVu
 iZ6TTNgONtrvkGX4cAxy7pCcobzj2OEilt/KieBYGse/jLuZlNOZx1tL0q20AJf5GcJK7+lmo0xphh
 C2FFx+LS3yyFW5PgDy30kiJVVoKK6N4L/+zXctVydKQ9mY8hFBLlfh76h4CQ==
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

Leverage the data introduced in the struct msm_special_pin_data to allow
setting the gpio direction and value if supported by the pin data.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpio/msm_gpio.c | 97 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 89 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
index 2fb266f1285..cea073b3297 100644
--- a/drivers/gpio/msm_gpio.c
+++ b/drivers/gpio/msm_gpio.c
@@ -34,13 +34,31 @@ struct msm_gpio_bank {
 #define GPIO_IN_OUT_REG(dev, x) \
 	(GPIO_CONFIG_REG(dev, x) + 0x4)
 
+static void msm_gpio_direction_input_special(struct msm_gpio_bank *priv,
+					     unsigned int gpio)
+{
+	unsigned int offset = gpio - priv->pin_data->special_pins_start;
+	const struct msm_special_pin_data *data;
+
+	if (!priv->pin_data->special_pins_data)
+		return;
+
+	data = &priv->pin_data->special_pins_data[offset];
+
+	if (!data->ctl_reg || data->oe_bit >= 31)
+		return;
+
+	/* switch direction */
+	clrsetbits_le32(priv->base + data->ctl_reg,
+			BIT(data->oe_bit), 0);
+}
+
 static void msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
-	/* Always NOP for special pins, assume they're in the correct state */
 	if (qcom_is_special_pin(priv->pin_data, gpio))
-		return;
+		msm_gpio_direction_input_special(priv, gpio);
 
 	/* Disable OE bit */
 	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(dev, gpio),
@@ -49,13 +67,33 @@ static void msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
 	return;
 }
 
+static int msm_gpio_set_value_special(struct msm_gpio_bank *priv,
+				      unsigned int gpio, int value)
+{
+	unsigned int offset = gpio - priv->pin_data->special_pins_start;
+	const struct msm_special_pin_data *data;
+
+	if (!priv->pin_data->special_pins_data)
+		return 0;
+
+	data = &priv->pin_data->special_pins_data[offset];
+
+	if (!data->io_reg || data->out_bit >= 31)
+		return 0;
+
+	value = !!value;
+	/* set value */
+	writel(value << data->out_bit, priv->base + data->io_reg);
+
+	return 0;
+}
+
 static int msm_gpio_set_value(struct udevice *dev, unsigned int gpio, int value)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
-	/* Always NOP for special pins, assume they're in the correct state */
 	if (qcom_is_special_pin(priv->pin_data, gpio))
-		return 0;
+		return msm_gpio_set_value_special(priv, gpio, value);
 
 	value = !!value;
 	/* set value */
@@ -64,14 +102,42 @@ static int msm_gpio_set_value(struct udevice *dev, unsigned int gpio, int value)
 	return 0;
 }
 
+static int msm_gpio_direction_output_special(struct msm_gpio_bank *priv,
+					     unsigned int gpio,
+					     int value)
+{
+	unsigned int offset = gpio - priv->pin_data->special_pins_start;
+	const struct msm_special_pin_data *data;
+
+	if (!priv->pin_data->special_pins_data)
+		return 0;
+
+	data = &priv->pin_data->special_pins_data[offset];
+
+	if (!data->io_reg || data->out_bit >= 31)
+		return 0;
+
+	value = !!value;
+	/* set value */
+	writel(value << data->out_bit, priv->base + data->io_reg);
+
+	if (!data->ctl_reg || data->oe_bit >= 31)
+		return 0;
+
+	/* switch direction */
+	clrsetbits_le32(priv->base + data->ctl_reg,
+			BIT(data->oe_bit), BIT(data->oe_bit));
+
+	return 0;
+}
+
 static int msm_gpio_direction_output(struct udevice *dev, unsigned int gpio,
 				     int value)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
-	/* Always NOP for special pins, assume they're in the correct state */
 	if (qcom_is_special_pin(priv->pin_data, gpio))
-		return 0;
+		return msm_gpio_direction_output_special(priv, gpio, value);
 
 	value = !!value;
 	/* set value */
@@ -100,13 +166,28 @@ static int msm_gpio_set_flags(struct udevice *dev, unsigned int gpio, ulong flag
 	return 0;
 }
 
+static int msm_gpio_get_value_special(struct msm_gpio_bank *priv, unsigned int gpio)
+{
+	unsigned int offset = gpio - priv->pin_data->special_pins_start;
+	const struct msm_special_pin_data *data;
+
+	if (!priv->pin_data->special_pins_data)
+		return 0;
+
+	data = &priv->pin_data->special_pins_data[offset];
+
+	if (!data->io_reg || data->in_bit >= 31)
+		return 0;
+
+	return !!(readl(priv->base + data->io_reg) >> data->in_bit);
+}
+
 static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
-	/* Always NOP for special pins, assume they're in the correct state */
 	if (qcom_is_special_pin(priv->pin_data, gpio))
-		return 0;
+		return msm_gpio_get_value_special(priv, gpio);
 
 	return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) >> GPIO_IN);
 }

-- 
2.34.1

