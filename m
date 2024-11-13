Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC00D41C00
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 04:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6D1B8952B;
	Wed, 13 Nov 2024 05:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zsRVERXT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12EDC89534; Wed, 13 Nov 2024 05:59:55 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27480894FE
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 05:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a99f646ff1bso957216166b.2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 20:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731473992; x=1732078792; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+ypEa5U+5RCjZYPbaoRbZNMrPahk0zrlcGdy+nFMPOQ=;
 b=zsRVERXT6irvr3113CpgJebhRyanGgYbF1zgStCB2XsVP6KsXmtDl9xEvEdW8He6Gg
 vr6Vi5d5LQTt7lZ1nx2cGlLf8jXN+TZdM+9jPaOUhMnCNuXG4ZLrFARKf/NVm+oXsPT/
 CGKSzMZF1JDeCL4SKwGiXBbP57elhTYFARElWoEubS7ZHfVq+Eyn+ApJftbsyniaVnrW
 wLBI0+2HEgp8vMVzCf2DBGGOiabvWGVWTnaZLhrzbexoYvaCqnmpmza5BV+wQIKwZNOm
 YknkEffcg52xz3tusfubIWx0r7ol2NVF3qfQ6oPsSLToaOac07BS0iV9oqjX1lKxBynG
 CQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731473992; x=1732078792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ypEa5U+5RCjZYPbaoRbZNMrPahk0zrlcGdy+nFMPOQ=;
 b=no7J/9wVeS0GhE/za0v5+yHOXI9fR5E/60o2eHhuQHhHRJfLQ8Pe2Yrb7Py6UO3INH
 U8CY2R9PrZjs4vlV9a33h75KRrQxlP/UM90H7x05E4o4sqhbEw9/HjJGxvYm4WuwzIas
 N1gCWipw0EYz4EdEpStjJCgeg8f33uXsv2ILb8keIcvjuGOi0FQLIbLuCx50Sim9z/NS
 NzECyZr3w3gDAfjxOBJYgCKXfIVzUUP51rrxj3npU9ajLFKy3pUOgC6JewajH9vF9lep
 O5zZtfPWuA0Xm3Wd80u63T2dR7h+l4E19Mv+mJTg8chIKvVMfmMjvgZtWwnEV+3sxEDr
 AemA==
X-Gm-Message-State: AOJu0YzP0UMR5Q4IaIYCW0kmbzw+tiQ3Al4JAoTD6eDFkSBSjBbZQm0f
 TKNRFMA39WjA99Kry+KF3/E2ND8FbAMLttQ1FMjAyzMtVV9rhHPgEqVw8XIblfipap2r4uQqWZ5
 n
X-Google-Smtp-Source: AGHT+IE5C9EMLGSempZdoKrZ09KRPCDQ0h0SX3O1qoJVTtp5bGXkU+FFNicnMtrGzvvzRg4njmqwIA==
X-Received: by 2002:a17:906:2446:b0:aa1:e181:f211 with SMTP id
 a640c23a62f3a-aa1e181fbedmr363944266b.18.1731473992594; 
 Tue, 12 Nov 2024 20:59:52 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0dc4c97sm807522366b.131.2024.11.12.20.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 20:59:51 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] button: gpio: handle broken controller
Date: Wed, 13 Nov 2024 05:59:24 +0100
Message-ID: <20241113045936.1844271-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.47.0
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

Avoid crashing U-Boot when the GPIO controller for a button is disabled
or failed to probe. We also need to check the priv data for each button
since even if a button fails to probe it will still be polled by the
core code.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/button/button-gpio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/button/button-gpio.c b/drivers/button/button-gpio.c
index 43b82d98aeb7..31b85c8150e8 100644
--- a/drivers/button/button-gpio.c
+++ b/drivers/button/button-gpio.c
@@ -19,8 +19,11 @@ static enum button_state_t button_gpio_get_state(struct udevice *dev)
 {
 	struct button_gpio_priv *priv = dev_get_priv(dev);
 	int ret;
 
+	if (!priv)
+		return -ENODATA;
+
 	if (!dm_gpio_is_valid(&priv->gpio))
 		return -EREMOTEIO;
 	ret = dm_gpio_get_value(&priv->gpio);
 	if (ret < 0)
@@ -31,8 +34,10 @@ static enum button_state_t button_gpio_get_state(struct udevice *dev)
 
 static int button_gpio_get_code(struct udevice *dev)
 {
 	struct button_gpio_priv *priv = dev_get_priv(dev);
+	if (!priv)
+		return -ENODATA;
 	int code = priv->linux_code;
 
 	if (!code)
 		return -ENODATA;
@@ -50,9 +55,9 @@ static int button_gpio_probe(struct udevice *dev)
 	if (!uc_plat->label)
 		return 0;
 
 	ret = gpio_request_by_name(dev, "gpios", 0, &priv->gpio, GPIOD_IS_IN);
-	if (ret)
+	if (ret || !dm_gpio_is_valid(&priv->gpio))
 		return ret;
 
 	ret = dev_read_u32(dev, "linux,code", &priv->linux_code);
 
@@ -97,8 +102,10 @@ static int button_gpio_bind(struct udevice *parent)
 		if (ret)
 			return ret;
 		uc_plat = dev_get_uclass_plat(dev);
 		uc_plat->label = label;
+		debug("Button '%s' bound to driver '%s'\n", label,
+		      dev->driver->name);
 	}
 
 	return 0;
 }
-- 
2.47.0

