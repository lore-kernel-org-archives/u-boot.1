Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3270C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 15:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65B8D87063;
	Mon,  6 Nov 2023 16:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I+jploHT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8783586F42; Mon,  6 Nov 2023 16:29:32 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7D3586F8D
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 16:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40836ea8cbaso32622465e9.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 07:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284548; x=1699889348; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UtIt9RHM7jSGdXgOG4034U97MhrFmyCZJewGF1z1I/g=;
 b=I+jploHTWlDTh6upvGYY7ff+pwrDMf7L2fwHu/34YVgUzC2A6/p7YTc4PPZ31YSQPg
 HY+E5SqW3SKl9S/Z8GUpPJsGi+oBsT0WM1kIyQ3Z/HfwHK8vNHX+v3qf+uZVOm4ynfKX
 M5CYqIXca/cPyLCn+0zzorU3AoTlfyzSiwFQoYAr4bhaxrF4EIoCwVgPxElCA7fc1JRs
 vwJMbEZfmrG+PICGRQqbMAkZImYWcgdWb4DMmqXcXtJBvQZBhxmgMPy2nMVgnamMQRo/
 Hm+wX8u94S3hLta2Awo6wzoy5D3a1D+0c52OTmJ5xwGqrntf/14id91/UHqrahDQWLBx
 TZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284548; x=1699889348;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UtIt9RHM7jSGdXgOG4034U97MhrFmyCZJewGF1z1I/g=;
 b=obAFYHIJXxIrJ3+OXNMSIsAGjKWe4p4xLQJbyBofl3R8iZQ+PBM++/jCKtF9BW48Xn
 EGjw3yrdx+q/+CER0bCnQs2x6Gj7GElzHQhhG8yiBUk9cz9LPkwLe5MVHy6SuKJLOoeS
 2Sp6i6pu9S5rccoNyhXqBow5rFNoIUP3OL7r4hIZZ4VlGVEMCBVkwZ6IChHWcjAt218I
 szl6B/2XdX3fCwBL8Y4jDsRkiXsth7SFSKPATDpahAhg0T5ejYc57R5T4345li2O+DeR
 ghJ/ZRPWqLk7/XXv/W35OT2USsGDASZaymDD7Q51Lr2apfIPJ4/nNRVDCvQ5QmGpSNY/
 gmtQ==
X-Gm-Message-State: AOJu0YztU0LrGssWEaoqlsmeR35pLCTZtuK00wMSh/kyvgICH1en06Ty
 SNN5n5NE5zuQVx388B7118agyw==
X-Google-Smtp-Source: AGHT+IHEPhNTd4bvweFtvJg0BTMAcrBBGDGYgCS6MLFp1+OcvtyBW5+cIdrg75Yj5KIA5Yl6ezzlHQ==
X-Received: by 2002:a05:600c:1c08:b0:40a:28b1:70fc with SMTP id
 j8-20020a05600c1c0800b0040a28b170fcmr21196wms.8.1699284548183; 
 Mon, 06 Nov 2023 07:29:08 -0800 (PST)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 bx30-20020a5d5b1e000000b0032f7d1e2c7csm8116094wrb.95.2023.11.06.07.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:29:07 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 06 Nov 2023 15:29:03 +0000
Subject: [PATCH v2 4/5] msm_gpio: use unsigned int
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-b4-qcom-pinctrl-v2-4-406e8d8689ca@linaro.org>
References: <20231106-b4-qcom-pinctrl-v2-0-406e8d8689ca@linaro.org>
In-Reply-To: <20231106-b4-qcom-pinctrl-v2-0-406e8d8689ca@linaro.org>
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
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=LwYk6/r+mWoVE7/aOiPWrqkTuHS6dGyX68p0AcAA5Ak=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlRPNrvLds9FPt34MEXnW/alJXMmpXYZHbiR/a3UP3qXm
 57X5Y2zOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBE9uxiZOiZm8WxUeArP1Nc
 TKlRlaPbL4WyDWZTbF7H57eEVXTp8zAy9P5XbdggVfb7WFnFr+/GKgIfrr4y3NpgYGZ4xtnl7aH
 VegA=
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

Replaces the uses of "unsigned" with "unsigned int".

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/msm_gpio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
index 7d77776a25fd..3e4a0194b10a 100644
--- a/drivers/gpio/msm_gpio.c
+++ b/drivers/gpio/msm_gpio.c
@@ -46,7 +46,7 @@ static int msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
 	return 0;
 }
 
-static int msm_gpio_set_value(struct udevice *dev, unsigned gpio, int value)
+static int msm_gpio_set_value(struct udevice *dev, unsigned int gpio, int value)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
@@ -57,7 +57,7 @@ static int msm_gpio_set_value(struct udevice *dev, unsigned gpio, int value)
 	return 0;
 }
 
-static int msm_gpio_direction_output(struct udevice *dev, unsigned gpio,
+static int msm_gpio_direction_output(struct udevice *dev, unsigned int gpio,
 				     int value)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
@@ -72,14 +72,14 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned gpio,
 	return 0;
 }
 
-static int msm_gpio_get_value(struct udevice *dev, unsigned gpio)
+static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
 	return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) >> GPIO_IN);
 }
 
-static int msm_gpio_get_function(struct udevice *dev, unsigned gpio)
+static int msm_gpio_get_function(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 

-- 
2.42.0

