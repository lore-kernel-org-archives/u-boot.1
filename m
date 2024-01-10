Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069D3C4707C
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 16:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D9AD87AFC;
	Wed, 10 Jan 2024 17:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V7mzEZc9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD0D87AFB; Wed, 10 Jan 2024 17:10:19 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 921518777D
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 17:10:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-557e76e1bd6so3134548a12.1
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 08:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704903016; x=1705507816; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XYlDkChLhdbSc7lmJQW/jJyKL9+Mv3GAxR1Z/lOhR3U=;
 b=V7mzEZc9aFQcxFvCAO9DMcbgZ4qYtRkiTcBHricmip9gB5SE5IJVYaBOJn/RoPDSNQ
 F3qKO6x/2FRlnCKjdz8Vd3wqaaGkMZfwJABLVJjcs7LdNmC8nVz4xKqkf2c8BZagk0OG
 PyXjL4SiWSLj5T3uEZoHiHEqeEJS+sNF6DdcmxjlTMfXgB74BJiskvyDTL5GIurmK6Yc
 wVVTWTijWleS6KScP+h2RpF02iUnytSpPWemFfihr8dVp+5+EI7DHR0zoyjEzjNRdGMC
 pFQxJYVF3Y/6ZASr3sqn8gE8HsG2uFlyHD0e0nAes9ACwUkZlBIdMrk/0rmy8lPGa6UG
 xrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704903016; x=1705507816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XYlDkChLhdbSc7lmJQW/jJyKL9+Mv3GAxR1Z/lOhR3U=;
 b=fCcq1mLq7vn17Q31lm2Loq9pyCbXUS/C9+qUkd4LHUrNZ2d0GHwfDoEJPJ5UG+F+CE
 UjacuXaFye7tzaiRKWs5TvLPuxulGa8znupuwSiRoBi2ucKBW9WGBYmMANs92nXfWyDq
 o50mBBk3N2uwubu6E9YEdjOU83Asxb9dDSoZ87mefLfuCh4+qbVC2lPk7bhWb/IImLDh
 x7pMFQZNh9tJfBiCm0m0xiGZQIM1mTwkascXURaQFQJwOQkCq6o5E7qeQwjC+bGPkpA0
 E7lHBPnQtQFo+F+N6CusjkD9AN4nm50V4Owj4tXhPS2ORQ4p9aIpcvC0ov6lU0Y6ybGI
 WoLg==
X-Gm-Message-State: AOJu0Yy00+mhBLCKjnWIV9yCMwtjfBSVvimWyBa/6/Mo6x5v6h9BMApi
 6pVdS2EtYzFwUFfaiiBG7hNklGlv8WCPLi8j
X-Google-Smtp-Source: AGHT+IFDLgxsTh62mg6m9c1zbj6XQO7V6bd6bCExaOtN81Yy8vWWg4eBobDL9m4OGOZZ5MB0hCqyLA==
X-Received: by 2002:a50:9356:0:b0:558:2872:e3de with SMTP id
 n22-20020a509356000000b005582872e3demr640274eda.83.1704903015982; 
 Wed, 10 Jan 2024 08:10:15 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 a23-20020aa7d757000000b00557075b4499sm2138662eds.58.2024.01.10.08.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 08:10:15 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 1/1] clk: clk-gpio: add actual gated clock
Date: Wed, 10 Jan 2024 18:09:56 +0200
Message-Id: <20240110160956.4476-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240110160956.4476-1-clamor95@gmail.com>
References: <20240110160956.4476-1-clamor95@gmail.com>
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

Existing gpio-gate-clock driver acts like a simple GPIO switch without any
effect on gated clock. Add actual clock actions into enable/disable ops and
implement get_rate op by passing gated clock if it is enabled.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/clk/clk-gpio.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 26d795b978..d2dd8070fa 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -3,19 +3,23 @@
  * Copyright (C) 2023 Marek Vasut <marek.vasut+renesas@mailbox.org>
  */
 
-#include <asm/gpio.h>
-#include <common.h>
-#include <clk-uclass.h>
+#include <clk.h>
 #include <dm.h>
+#include <clk-uclass.h>
+#include <linux/clk-provider.h>
+
+#include <asm/gpio.h>
 
 struct clk_gpio_priv {
-	struct gpio_desc	enable;
+	struct gpio_desc	enable;	/* GPIO, controlling the gate */
+	struct clk		*clk;	/* Gated clock */
 };
 
 static int clk_gpio_enable(struct clk *clk)
 {
 	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
 
+	clk_enable(priv->clk);
 	dm_gpio_set_value(&priv->enable, 1);
 
 	return 0;
@@ -26,21 +30,45 @@ static int clk_gpio_disable(struct clk *clk)
 	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
 
 	dm_gpio_set_value(&priv->enable, 0);
+	clk_disable(priv->clk);
 
 	return 0;
 }
 
+static ulong clk_gpio_get_rate(struct clk *clk)
+{
+	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
+
+	return clk_get_rate(priv->clk);
+}
+
 const struct clk_ops clk_gpio_ops = {
 	.enable		= clk_gpio_enable,
 	.disable	= clk_gpio_disable,
+	.get_rate	= clk_gpio_get_rate,
 };
 
 static int clk_gpio_probe(struct udevice *dev)
 {
 	struct clk_gpio_priv *priv = dev_get_priv(dev);
+	int ret;
 
-	return gpio_request_by_name(dev, "enable-gpios", 0,
-				    &priv->enable, GPIOD_IS_OUT);
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		log_debug("%s: Could not get gated clock: %ld\n",
+			  __func__, PTR_ERR(priv->clk));
+		return PTR_ERR(priv->clk);
+	}
+
+	ret = gpio_request_by_name(dev, "enable-gpios", 0,
+				   &priv->enable, GPIOD_IS_OUT);
+	if (ret) {
+		log_debug("%s: Could not decode enable-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	return 0;
 }
 
 /*
-- 
2.40.1

