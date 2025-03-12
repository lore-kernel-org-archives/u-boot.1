Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D414AC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6313819AA;
	Wed, 12 Mar 2025 19:23:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hJvtxRNP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB0B281D25; Wed, 12 Mar 2025 19:23:24 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A65CC819AA
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5dc89df7eccso106348a12.3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741803801; x=1742408601; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ikSecYdRMIi88QkvinMOo7L18IbSQWpRtAdg0JNEXM=;
 b=hJvtxRNPk78jGiD7pN859MVwIdy5FkyuP7Bgre6vCKAJM9+AlX+8ggJtOG0lGFX1/q
 R3k3R8x7nojyn248Mp7rYcr0A5D2VBur58h6ye+N1RcLyrkcMpGcNztx5Q2yxJ+2sksm
 yaysoFBOmGJ571/Vn/LtiTmBlBS41VY/eUvJh7fb5D13EZjToOAjV4oMB16OEL/pic71
 iY/LCv4XbE+54MJjc8Wr2L6RrZhT0vaB2pzchQNLX19TZ7/en2sSMi5BFSmcSckTs2ir
 JEO2wf9rjYTFWqaNyX+272mO/0Qz5jzneelkcXTrfkn4yeD4QwOVYe59s18QaW5Dxsj3
 qs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741803801; x=1742408601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ikSecYdRMIi88QkvinMOo7L18IbSQWpRtAdg0JNEXM=;
 b=tsUsUqDlrzq4cI1diDtfLIg1aEO8g+mPFk2G8WKNlK4FjPHxlRcNdOkXiYmLfpOiz0
 8/I4Irs3C0/8sEBzHVDOp2W+GSfcai+kbEj75RndO+wDzJxD3cEe8OyZdZpmO/4+rVCL
 7+rnXjctKF3tmxmjxw4Wb+LR97iAf2yv8meSUeX6+NmMRhhzjtmQep+mVTqKLBpNXgah
 zmvtAMsOZIDgrO7eFyC12emShkvokgZ+nk8/isuaTzZ6wACvb61+9CuQ9TDr2Lmedg3+
 +iD8QMQSZg8VxGfulUmztkaIKjSYS+6K9zrryp68i8uwGt5HibZ5EEq6rV3FhiylU4kG
 fIBA==
X-Gm-Message-State: AOJu0YwGnJ6vwgwGiKe8IT6uxgc94Y2H4cjfag39Spk+4ZQtLSGZXT+w
 BGLR1ZgHtwO7Pyr94ALD9w3VSmzwm9Yq1GfamHUr9HKEkVXVqfu8/drpDw==
X-Gm-Gg: ASbGnctDFwmMyfI2NMsE7qKOZQf3PLnR0zdBzoEvgxsipucuNb+joegTHeDCL197ISz
 HllfSyljTBN2gGHR4Z8yYbbfZs6GaC2LNNDZy9ADxS6xLB3jclL76SaeVvZtuIVU7SFvynPN64J
 FJgG2kDAbjK1Cir0HNcvfuLTc9I7siykVoQzu+G0WRPubZLc5QWm9pFauNbuRtla7F2PPQPsflh
 nTTw0PcfuqUgAw86JDuJB3Y9WHLsrcBbbzMxMZr+5drpLPc/6MhoKRwqmUaxqS05P5mBzi7jGNZ
 FPGsW0ph4D9h3rKp4a/zu2rwAX4WbgN+5efy
X-Google-Smtp-Source: AGHT+IHBrk0MbHAUg7m7iYlQAGbtbvVnUXEJoyPNVmJZtfVRjKU/tDhhY7zcKdzyAby6hv3DA1eW8g==
X-Received: by 2002:a05:6402:5113:b0:5e7:b011:6c09 with SMTP id
 4fb4d7f45d1cf-5e7b0116d2amr5797740a12.18.1741803800899; 
 Wed, 12 Mar 2025 11:23:20 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c7669ff1sm9851674a12.53.2025.03.12.11.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:23:20 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/3] video: backlight: lm3533: add more flexibility with
 device tree
Date: Wed, 12 Mar 2025 20:20:12 +0200
Message-ID: <20250312182014.121568-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312182014.121568-1-clamor95@gmail.com>
References: <20250312182014.121568-1-clamor95@gmail.com>
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

Configure LM3533 based on preliminary device tree configuration.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/lm3533_backlight.c | 65 +++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/drivers/video/lm3533_backlight.c b/drivers/video/lm3533_backlight.c
index 6b51fa0628e..a1a7397cbdc 100644
--- a/drivers/video/lm3533_backlight.c
+++ b/drivers/video/lm3533_backlight.c
@@ -7,6 +7,7 @@
 
 #include <backlight.h>
 #include <dm.h>
+#include <dm/ofnode.h>
 #include <i2c.h>
 #include <log.h>
 #include <linux/delay.h>
@@ -24,9 +25,23 @@
 #define LM3533_OVP_FREQUENCY_PWM_POLARITY		0x2C
 #define LM3533_BRIGHTNESS_REGISTER_A			0x40
 
+#define LM3533_BOOST_OVP_16V				16000000UL
+#define LM3533_BOOST_FREQ_500KHZ			500000UL
+
 struct lm3533_backlight_priv {
 	struct gpio_desc enable_gpio;
 	u32 def_bl_lvl;
+
+	/* Core */
+	u32 boost_ovp;
+	u32 boost_freq;
+
+	/* Backlight */
+	u32 reg;
+	u16 max_current;		/* 5000 - 29800 uA (800 uA step) */
+	u8 pwm;				/* 0 - 0x3f */
+	bool linear;
+	bool hvled;
 };
 
 static int lm3533_backlight_enable(struct udevice *dev)
@@ -92,14 +107,12 @@ static int lm3533_backlight_set_brightness(struct udevice *dev, int percent)
 	return 0;
 }
 
-static int lm3533_backlight_probe(struct udevice *dev)
+static int lm3533_backlight_of_to_plat(struct udevice *dev)
 {
 	struct lm3533_backlight_priv *priv = dev_get_priv(dev);
+	ofnode child;
 	int ret;
 
-	if (device_get_uclass_id(dev->parent) != UCLASS_I2C)
-		return -EPROTONOSUPPORT;
-
 	ret = gpio_request_by_name(dev, "enable-gpios", 0,
 				   &priv->enable_gpio, GPIOD_IS_OUT);
 	if (ret) {
@@ -107,8 +120,47 @@ static int lm3533_backlight_probe(struct udevice *dev)
 		return ret;
 	}
 
-	priv->def_bl_lvl = dev_read_u32_default(dev, "default-brightness-level",
-						LM3533_BL_MAX_BRIGHTNESS);
+	priv->boost_ovp = dev_read_u32_default(dev, "ti,boost-ovp-microvolt",
+					       LM3533_BOOST_OVP_16V);
+
+	/* boost_ovp is defined in microvolts, convert to enum value */
+	priv->boost_ovp = priv->boost_ovp / (8 * 1000 * 1000) - 2;
+
+	priv->boost_freq = dev_read_u32_default(dev, "ti,boost-freq-hz",
+						LM3533_BOOST_FREQ_500KHZ);
+
+	/* boost_freq is defined in Hz, convert to enum value */
+	priv->boost_freq = priv->boost_freq / (500 * 1000) - 1;
+
+	/* Backlight is one of children but has no dedicated driver */
+	ofnode_for_each_subnode(child, dev_ofnode(dev)) {
+		if (ofnode_device_is_compatible(child, "ti,lm3533-backlight")) {
+			const char *node_name = ofnode_get_name(child);
+
+			if (!strcmp(&node_name[10], "1"))
+				priv->reg = 1;
+			else
+				priv->reg = 0;
+
+			priv->max_current = ofnode_read_u32_default(child, "ti,max-current-microamp",
+								    5000);
+			priv->pwm = ofnode_read_u32_default(child, "ti,pwm-config-mask", 0);
+
+			priv->def_bl_lvl = ofnode_read_u32_default(child, "default-brightness",
+								   LM3533_BL_MAX_BRIGHTNESS);
+
+			priv->linear = ofnode_read_bool(child, "ti,linear-mapping-mode");
+			priv->hvled = ofnode_read_bool(child, "ti,hardware-controlled");
+		}
+	}
+
+	return 0;
+}
+
+static int lm3533_backlight_probe(struct udevice *dev)
+{
+	if (device_get_uclass_id(dev->parent) != UCLASS_I2C)
+		return -EPROTONOSUPPORT;
 
 	return 0;
 }
@@ -127,6 +179,7 @@ U_BOOT_DRIVER(lm3533_backlight) = {
 	.name		= "lm3533_backlight",
 	.id		= UCLASS_PANEL_BACKLIGHT,
 	.of_match	= lm3533_backlight_ids,
+	.of_to_plat	= lm3533_backlight_of_to_plat,
 	.probe		= lm3533_backlight_probe,
 	.ops		= &lm3533_backlight_ops,
 	.priv_auto	= sizeof(struct lm3533_backlight_priv),
-- 
2.43.0

