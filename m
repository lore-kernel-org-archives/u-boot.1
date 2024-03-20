Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D86C6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D716880AA;
	Wed, 20 Mar 2024 15:57:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yW11O5H6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C36708809F; Wed, 20 Mar 2024 15:57:21 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E9228809C
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d48d75ab70so76093161fa.0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710946638; x=1711551438; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R7r7yaX5GC6A7b+YWiB29a1fIsl80G8kHqu1xhDh7Zc=;
 b=yW11O5H6OY+8RaqxoCw2WNk5xgC2MW1a3H2CzXX50dDDIuWKIDz57GbzdL2l0EJ32h
 YCWFUbZfu/FAA5GCQKg7gY5nJWMk5xJMZWrlyMIhWfW85cNnjhg8taJgr4waF8ncuNWU
 Ft76BTkfiV/w8blvCyZf9iDiB/lNdc+HWuVITEChdcybAz8j5B5resMJuyludPB57aMl
 Ok0WXJikI5KNWydBuLZF1o3jfuO/fQmPfwRMbit5/xp3alb6rv+D/nMq4yPBKW3hx2KD
 5YoJUjuoCJK8g5LcKyH7xAh605ewNPNqXbU3CWEFq09hXB92G+vfkj+kRo9bn5DE47bS
 loFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710946638; x=1711551438;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R7r7yaX5GC6A7b+YWiB29a1fIsl80G8kHqu1xhDh7Zc=;
 b=H1ZbFtV8U9JAANRLs637b3o2upH36s3U2hwK4BVfTGSriaEu6LUeKbIfYs8K99bRfu
 S/zW4lSlNuPnAC7+Z5pPJbyR+nCxUL6zmkYCvx1xImH0EIwMb5JFjuvgKBkcARtMRnxE
 e+2aQrrOybFuUEtcpW6VHlgE2OEJLPONOuWcirkorSbafuMCH4Hb7A5mI+NaaKkSKjGL
 p9xLPUliHEQcFCKOSKc4M37LNtv3zkzt7MB31Jl3VJWVZenwQJEdNI3VOtJenUy17Q0K
 OmsYypNIXwQNJdcCFwik3Z93gjM4dZqIfvpiE8yBYEX2la5vco9uFi9B9h2Z6mOE8Ds9
 n6mw==
X-Gm-Message-State: AOJu0Yxxwbpznls1QWPM8AikFeX6S4GQcVVVUOBMQX0DUZ4WUrWfNaai
 MZpC1j3h7Na+4iCwQjgyiGs96UiWWBc0zpEqFUoLWHhzMvUscISADR65aS3xldyeEAP9rYmQqFE
 /
X-Google-Smtp-Source: AGHT+IGyuXgbEUSFkguWvQ/TRrSHcBiRaCpWxvBerjpYcIQNN+wdnfJ6XzllodecTJMKKj8utU9tUQ==
X-Received: by 2002:a2e:aa98:0:b0:2d4:5788:a2ee with SMTP id
 bj24-20020a2eaa98000000b002d45788a2eemr10063394ljb.45.1710946638570; 
 Wed, 20 Mar 2024 07:57:18 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bi16-20020a05600c3d9000b0041468f79fd5sm2461268wmb.16.2024.03.20.07.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:57:18 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 20 Mar 2024 14:57:11 +0000
Subject: [PATCH v4 08/14] gpio: msm_gpio: add .set_flags op
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-b4-qcom-livetree-v4-8-d867ab1f06c2@linaro.org>
References: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
In-Reply-To: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2578;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=O61GGp35CPRo6Gs3ecjo0wdiQX5EtInYxOC3wND9vEE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRfPx3b/y+b7Kywa/p6yd6pkYuE6yTOzVOb2RyQdHNh2
 rcel6sBHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiHb4M/xN5S90UNuS/P9Ac
 s/5LMufMmPn/mpO2T7R7kVTam//DfxLDP7Wmb/ZZQVe3v2W1YP4UWMjo8yP2nEe0geDt1Rd1L/3
 5MhUA
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

The .direction_input and .direction_output ops are deprecated, and don't
seem to behave properly for us. Implement our own .set_flags op to
handle this correctly.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/msm_gpio.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
index 5e57b0cbde75..f5d9ab54e817 100644
--- a/drivers/gpio/msm_gpio.c
+++ b/drivers/gpio/msm_gpio.c
@@ -34,21 +34,21 @@ struct msm_gpio_bank {
 
 #define GPIO_IN_OUT_REG(dev, x) \
 	(GPIO_CONFIG_REG(dev, x) + 0x4)
 
-static int msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
+static void msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
 	/* Always NOP for special pins, assume they're in the correct state */
 	if (qcom_is_special_pin(priv->pin_data, gpio))
-		return 0;
+		return;
 
 	/* Disable OE bit */
 	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(dev, gpio),
 			GPIO_OE_MASK, GPIO_OE_DISABLE);
 
-	return 0;
+	return;
 }
 
 static int msm_gpio_set_value(struct udevice *dev, unsigned int gpio, int value)
 {
@@ -83,8 +83,25 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned int gpio,
 
 	return 0;
 }
 
+static int msm_gpio_set_flags(struct udevice *dev, unsigned int gpio, ulong flags)
+{
+	if (flags & GPIOD_IS_OUT_ACTIVE) {
+		return msm_gpio_direction_output(dev, gpio, 1);
+	} else if (flags & GPIOD_IS_OUT) {
+		return msm_gpio_direction_output(dev, gpio, 0);
+	} else if (flags & GPIOD_IS_IN) {
+		msm_gpio_direction_input(dev, gpio);
+		if (flags & GPIOD_PULL_UP)
+			return msm_gpio_set_value(dev, gpio, 1);
+		else if (flags & GPIOD_PULL_DOWN)
+			return msm_gpio_set_value(dev, gpio, 0);
+	}
+
+	return 0;
+}
+
 static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
@@ -109,12 +126,10 @@ static int msm_gpio_get_function(struct udevice *dev, unsigned int gpio)
 	return GPIOF_INPUT;
 }
 
 static const struct dm_gpio_ops gpio_msm_ops = {
-	.direction_input	= msm_gpio_direction_input,
-	.direction_output	= msm_gpio_direction_output,
+	.set_flags		= msm_gpio_set_flags,
 	.get_value		= msm_gpio_get_value,
-	.set_value		= msm_gpio_set_value,
 	.get_function		= msm_gpio_get_function,
 };
 
 static int msm_gpio_probe(struct udevice *dev)

-- 
2.44.0

