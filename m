Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15FAC47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 15:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71F1487D03;
	Wed, 31 Jan 2024 16:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IEGIS7n6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D837C87D47; Wed, 31 Jan 2024 16:17:11 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B7C287D47
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 16:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33ae3cc8a70so3096609f8f.0
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706714228; x=1707319028; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GFzzPtezzlz3qBSalQkCEEJ+9ZjAlCvWbTGr49LOGOY=;
 b=IEGIS7n6X/71XZ3VA++2ZUX7iqFIlLxobdU1NY5FNyfODIQ6BSSXIG0XSlBjE75++C
 zPC72+yLJuSWAKxKcVzWVVXLqmcrqY7o0ayQJn0a/VxkQkBUDNz2tKnOlD8QJGj2cWAs
 jNNxyw+2HhCLOcnfPGKqekVP2TMagVtnLlZRvLufz7X2sMtyUaDrNHsSgILN46IrSIF2
 8Zf+jpvi+GST045dTJj/rmBuLabrqVvkNaMBpGVCPSp5Jo7mMmls031xh1K4eJTSlfEK
 fACBKi5LJ7hzja8KJLYUJkP2SaVq+5PjWx8cWanzuWrLwQCVilhWDbkUYvhwkGhied+w
 SdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706714228; x=1707319028;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFzzPtezzlz3qBSalQkCEEJ+9ZjAlCvWbTGr49LOGOY=;
 b=HO+l9IXkDjG3wGNPqv3llPAwDjRcF6XmovNTgO8DbqbgxjGimRzryczFk/vAsGjr9B
 tWXtKDGYGG3ZtdSSbIgut6jmGC4R2pr29siutLNeuwxdPvwhgsvr+zysMrHTCIDm361+
 TENCilZvOO9uq/n+oYE/qWhLAmrm3D5tfrLhEEbNPSJDykCqvSeIoFNjL0XYjV1NfdH5
 2pxcZPca9w2sFBXTW8OULKmbOGvABSY7wav5oxczYtQQeCaK3WUY8BgkmQ6FtULyCbUv
 fckLFUO/a1tx43txhSbZS7usPfw4/gjPUXacrNOEE0xvq1ZpqO/4A4vWwXg/Tm20uF+S
 ym5g==
X-Gm-Message-State: AOJu0YwW/merw3ARPZKV8AiTBTlOqCl5CMCgHmzHOCqIRUakxpVvTVU1
 FkLOTdeGmAXPQwNZDbxjrstz3qLOHcE4myPxUy6zi0pS2hklm1NVsc6HsHpyIaFD+DS8xE4R6jU
 7
X-Google-Smtp-Source: AGHT+IEfaMLAvD00LpkSjXDboTsTlCWh4xUcSKnB7/NXIoPi0n3sDK5yApTD07pitPA0yJH7vOrGiw==
X-Received: by 2002:a05:6000:cf:b0:33a:d1b5:8164 with SMTP id
 q15-20020a05600000cf00b0033ad1b58164mr1277963wrx.70.1706714227920; 
 Wed, 31 Jan 2024 07:17:07 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 en6-20020a056000420600b0033ae5b637d4sm11109031wrb.35.2024.01.31.07.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 07:17:07 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 31 Jan 2024 15:16:59 +0000
Subject: [PATCH 07/13] gpio: msm_gpio: add .set_flags op
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-b4-qcom-livetree-v1-7-4071c0787db0@linaro.org>
References: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
In-Reply-To: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=KaoiPri56jQkPcn0dAO4J1jrhRFbc4C0gCpe+xSpZOI=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRdKTmT5+geFuJ2+zhVKV+nkslROVEr1qJ75aqJbVfm6
 MzkW2rZUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACbyX5vhf+lUkcyf57c8CIs8
 MrOwRn4li1/n1nd/w5ZLvJAvfW4cFsnIMOeb01K7/OvvNhpYqF/93mDvwJDncnT9XXc9E6k5Vrz
 5HAA=
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/msm_gpio.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
index 80cd28bb231f..0230305af299 100644
--- a/drivers/gpio/msm_gpio.c
+++ b/drivers/gpio/msm_gpio.c
@@ -72,6 +72,23 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned int gpio,
 	return 0;
 }
 
+static int msm_gpio_set_flags(struct udevice *dev, unsigned int gpio, ulong flags)
+{
+	if (flags & GPIOD_IS_OUT_ACTIVE) {
+		return msm_gpio_direction_output(dev, gpio, 1);
+	} else if (flags & GPIOD_IS_OUT) {
+		return msm_gpio_direction_output(dev, gpio, 0);
+	} else if (flags & GPIOD_IS_IN) {
+		return msm_gpio_direction_input(dev, gpio);
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
@@ -90,10 +107,8 @@ static int msm_gpio_get_function(struct udevice *dev, unsigned int gpio)
 }
 
 static const struct dm_gpio_ops gpio_msm_ops = {
-	.direction_input	= msm_gpio_direction_input,
-	.direction_output	= msm_gpio_direction_output,
+	.set_flags		= msm_gpio_set_flags,
 	.get_value		= msm_gpio_get_value,
-	.set_value		= msm_gpio_set_value,
 	.get_function		= msm_gpio_get_function,
 };
 

-- 
2.43.0

