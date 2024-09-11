Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571B8EE499C
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 18:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27B4889304;
	Wed, 11 Sep 2024 20:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YuJioySZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AD4888E83; Wed, 11 Sep 2024 20:07:21 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7183C892FF
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 20:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cacabd2e0so243655e9.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726078039; x=1726682839; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wiAtme929kZSm5f6Dxzpw/4FODGxe7FfO8rO9BH0BXE=;
 b=YuJioySZrs0FBEi1JTv8C/cHZBgVXUfsIiJbJ09dCcpLxmy82m2jdgdXUt6OsKHMTU
 w6uSIg7osT3enS/FrwYPLhMgT3NZP3Aubxzl44Z4RLdbXBTz1MZuOf9lNY1cD0eciPPj
 FiD1RsaXcnsGTeJBPu2waEpv316aRuRMSRLCyN8hY+P8r/LgUODPAprpZiKHDAv5Xods
 k8U3jw44POEL0G5RG2qHcql4te9CuMzkSwztSeGuszTDV6fuQTXMnD1OXhy4OjG4cXjI
 Z3iD28MbfDfbITev4WBHsc7O60G1OdatBojU3agehemOGndE/WbxVez1F7Z3cvsnidif
 kz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726078039; x=1726682839;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wiAtme929kZSm5f6Dxzpw/4FODGxe7FfO8rO9BH0BXE=;
 b=ma5g9B5rkbbtSVfkAX19Jw8zxiyBDxuGayio05bdm2rjqXRsBa9jaree/CYT/P5t5r
 4nAQvF7N8POugqA6X1bkMDn39imOgyEzGWYvu9a3U9rqYdTnRrnRUpi+67mfQrlZJyJB
 cU6f/Ygh1ilQDthFl238zIT+SyacuG9tR6tIO58ohTDwr84/40hxGx2CC24E4vfBAdEh
 vo+Tw6NucnwGUOM5L2ZZVCNCMdvz0MOeeGVU1Lv0NqrjzkwBypCztpfbMMm3fDfdwO6J
 4V1KyuAVtc07QjNFJ5b5Q+nWlVQO/rRfklk9bMq5XDgfSTWmS8hjqe2XG80gkoXcMEBZ
 QhPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9RghF9bw25UBTVwCPFhHHiU4VL0uazTSEGxycWndfduD1QmuqBPCl8vIVjERD6Ml37aC9NR0=@lists.denx.de
X-Gm-Message-State: AOJu0YzqcN36G6LVAseG1IpZtg/Jh+N/RH5w66oWsFagtYhsLnJSq3M6
 jEyUEhvE/EQeNMggWrwlwAYBnN8r32I1Ta1XkZ8kYI+hPnLBDP0cW2iQIWmZUrxFth0N+46tWzN
 H
X-Google-Smtp-Source: AGHT+IGG3YbY2O6r2vCvw+yzCpuePuKm50i43uqo1iLCL6v5eeHqE2wfUCn4OB13DkzULjDlKrViuw==
X-Received: by 2002:a05:600c:1e0f:b0:42c:bc03:e765 with SMTP id
 5b1f17b1804b1-42cdb53bbddmr3160535e9.16.1726078038680; 
 Wed, 11 Sep 2024 11:07:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895675b8bsm12192404f8f.54.2024.09.11.11.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 11:07:18 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 11 Sep 2024 20:07:14 +0200
Subject: [PATCH v2 1/2] gpio: msm: add support for special pins
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-topic-sm8x50-msm-gpio-special-pins-sm8250-v2-1-c49834055128@linaro.org>
References: <20240911-topic-sm8x50-msm-gpio-special-pins-sm8250-v2-0-c49834055128@linaro.org>
In-Reply-To: <20240911-topic-sm8x50-msm-gpio-special-pins-sm8250-v2-0-c49834055128@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4823;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=hpzDe3p6sPzJQLFujHI5KRQb2puJ+WsxzjYzQ7F0P44=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4dxU8IkZwwWmw30vKQAEet9zgPU3Scv1VyYmq1L/
 tjSRSaeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuHcVAAKCRB33NvayMhJ0euhD/
 9hlnf7iAXkIde2kIvuqVgEJNDhGeMs8yQFRl8g0Ce0YUHxdAG7TsUb/jSzakZ3FM+TIASvnqAb5md2
 b/5RGZM5VktnJeRFmx0EbPHnuytmJYihUbUUvbc1b+PMdCplmvKiTVY9HArZKzOq+8nUNgVlNxwzoX
 +1DlwA0PabI8B8xlWjInvLUCXAOpWoXWRVXr7C71CJtZyS8pC6HGBin/Fs3sMQJufy8x+NZTLx3eVB
 r3GNvJH6wKjZUooWdiy/hF6hyMQSouSloDE/2oQnJ5JieFdaYo62bf5BJUw8W/bGYOxtNOGgBHskv8
 oEpwmj4Sn1C8ksU9lCAquhdBBGWH1dJnrYOJefTENqwcEDVIjuy9wj5ObA1qqhkRiZKUIyfhc2juYU
 oPq6RJ527QqmLomgtyqEHj7jjiHiWciNqsbxIYYL3xH4WdTSfI0+wG7F4lGCxwK7n5sBDspjom1+Me
 WI/gMrqAmfvTW/g1N9wvGz2ifPPOKf8OOmKob6MlamYcWJJr7w2OsJXJ3YolaOxKT4mc/B9/79frRz
 Zeg4Ro2gUpsdAyOm7xC/m/cYDtWrXLMUVhwGRgNeBNk7gtPlcTm4zG8A6jivRQiK/J4mWoALCtHsVB
 W3KUIesk2qTzcGSVnkTBLOAYgoewKnp9+hZ0+D6tBLFbn3G760rlFxvQ7/sA==
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

