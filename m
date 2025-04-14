Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF704C3601E
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 06:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1152E8209F;
	Mon, 14 Apr 2025 08:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z00Yg35f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CAB882047; Mon, 14 Apr 2025 08:01:16 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BC8D81F7E
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 08:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e61375c108so4906247a12.1
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 23:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744610473; x=1745215273; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xoFX1iIJL4777Hn257+fn5zrGyHpvMN5/MwiaxcVecE=;
 b=Z00Yg35fg8j0U+v/hEECJM26kAA6hjKXaS7s/Q8F+Ohoz6s+niuRQvaYCNzX9uQhYO
 iOIJHwTcfi/5SClkK6KfBEqoIjXE358wztvGG3fk60SbWXZqHqK4najHecr4yq27d6Cd
 wd77upY9PSX21cvUdhsDZS1brVfn2FC4jxClun8ST4KtOA/Gq+045M/2OkCFGS7M3qpO
 sbHUPIttPKw3ksijXE/FvqaPKNpKWrsGSx1dqq07pR86C1D4r7zoSOG44j8q5YcYkMoA
 okAGrDMVg468vGMqWLqgG+c+7WZHU03M225PG24LhHIsNBN8Yf3Bnd5rqM4ZcmBy+Bwy
 hDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744610473; x=1745215273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xoFX1iIJL4777Hn257+fn5zrGyHpvMN5/MwiaxcVecE=;
 b=Ylqaq8n6X3wlE/HDYIIpfo4LYcuooiJPthp/jDgyP52BbESDpR2aekSHSezFk0fnH+
 stKXpPxsMIxeNP4lza0iId5qaWhe7sPa6+mUARbAY+lOHpmbORWApm0HkUQUp6/B4E4w
 vJeS5uCUIkDI7aV+49GqGJj65u+YofDRvdiL2EjexUIid6cmU1e8GKf2fQOAO2caruzj
 AAcXjdm6RqvF49Pewb4R9v/8jU5mND9Z+XgprOJn2+0oTr9nrcjFalibuirCFpMZ8pBr
 2BKtgsXJHOTy1DxJJ8SKFPE31TXqAWjOtv4quu4fhAC/9XyhWuvI6HR06N61Nv3hsMhC
 yQZw==
X-Gm-Message-State: AOJu0YwmYss5oqvG4PrYe3cn1omf9HIF6aBURsOuVLOk/mDqDJZ4NG03
 l7EGBCdpoAtsW868DrWu1gfvd4/sCS1on24InP5/Y7G1mNTMGECQ
X-Gm-Gg: ASbGnctyQ2Mo4TIJxnzYTeICO+bbg7UGB20idDKInn9rjWdaAmvv3BW3d/EKmDCqqoK
 W4aTmovvjb8tY2MmsAGKDrcS42Zyn/TaZSrpcSPWgDRzNm7P4OTxgXFmZzZw0wDrWWXDFdxfw8k
 mo8qeoBT+jCAGW1Yps4KWBRucXklqbYoeLohsKlCSScu4L7otSSVeQVWWOPLZNpdcPDZKpjRhat
 z3FBxmpI2Ue9fggeFDYY3DJQQ4E5JE1DzUtJtr2odjaQOJMTQ7yv7uuPbs/j4B2VArgGKJqdWyi
 hVzm/2eG8IvKTeHhHItNTRZG8mYg/hvo
X-Google-Smtp-Source: AGHT+IEUIgly6TjVbNoL6F0FIbn0xAJabhfZUABkRSRzv/OhIgMxLXjFxeh/Y6fUXKV6RkbQ6DV/DA==
X-Received: by 2002:a17:907:3d12:b0:aca:cda9:3170 with SMTP id
 a640c23a62f3a-acad36a0781mr1002291766b.46.1744610472555; 
 Sun, 13 Apr 2025 23:01:12 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1ce7fd1sm838050466b.168.2025.04.13.23.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 23:01:12 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>, Artur Kowalski <arturkow2000@gmail.com>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 8/9] video: backlight: add Skyworks/Analogictech AAT2870
 led controller driver
Date: Mon, 14 Apr 2025 09:00:18 +0300
Message-ID: <20250414060021.14545-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414060021.14545-1-clamor95@gmail.com>
References: <20250414060021.14545-1-clamor95@gmail.com>
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

Add support for Skyworks AAT2870 LED Backlight Driver and Multiple LDO
Lighting Management Unit. Only backlight is supported as for now. Supported
backlight level range is from 2 to 255 with step of 1.

Tested-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/Kconfig             |  10 +++
 drivers/video/Makefile            |   1 +
 drivers/video/aat2870_backlight.c | 132 ++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 drivers/video/aat2870_backlight.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3551aefae89..d855883fad9 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -754,6 +754,16 @@ config ATMEL_HLCD
 	help
 	   HLCDC supports video output to an attached LCD panel.
 
+config BACKLIGHT_AAT2870
+	bool "Backlight Driver for AAT2870"
+	depends on BACKLIGHT
+	select DM_I2C
+	help
+	  Say Y to enable the backlight driver for Skyworks AAT2870 LED
+	  Backlight Driver and Multiple LDO Lighting Management Unit.
+	  Only backlight is supported as for now. Supported backlight
+	  level range is from 2 to 255 with step of 1.
+
 config BACKLIGHT_LM3532
 	bool "Backlight Driver for LM3532"
 	depends on BACKLIGHT
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index ccd791cac59..a1bf92d9099 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_$(PHASE_)BMP) += bmp.o
 
 endif
 
+obj-$(CONFIG_BACKLIGHT_AAT2870) += aat2870_backlight.o
 obj-$(CONFIG_BACKLIGHT_LM3532) += lm3532_backlight.o
 obj-$(CONFIG_BACKLIGHT_LM3533) += lm3533_backlight.o
 obj-$(CONFIG_BACKLIGHT_LP855x) += lp855x_backlight.o
diff --git a/drivers/video/aat2870_backlight.c b/drivers/video/aat2870_backlight.c
new file mode 100644
index 00000000000..209d15b3639
--- /dev/null
+++ b/drivers/video/aat2870_backlight.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#define LOG_CATEGORY UCLASS_PANEL_BACKLIGHT
+
+#include <backlight.h>
+#include <dm.h>
+#include <i2c.h>
+#include <log.h>
+#include <linux/err.h>
+#include <asm/gpio.h>
+#include <power/regulator.h>
+
+#define AAT2870_BL_MIN_BRIGHTNESS	0x01
+#define AAT2870_BL_DEF_BRIGHTNESS	0x64
+#define AAT2870_BL_MAX_BRIGHTNESS	0xff
+
+#define AAT2870_BL_CH_EN		0x00
+#define AAT2870_BLM			0x01
+
+#define AAT2870_BL_CH_ALL		0xff
+
+#define AAT2870_CURRENT_MAX		27900000
+#define AAT2870_CURRENT_STEP		900000
+
+struct aat2870_backlight_priv {
+	struct gpio_desc enable_gpio;
+
+	int channels;
+	int max_current;
+};
+
+static int aat2870_backlight_enable(struct udevice *dev)
+{
+	struct aat2870_backlight_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	dm_gpio_set_value(&priv->enable_gpio, 1);
+
+	/* Enable backlight for defined set of channels */
+	ret = dm_i2c_reg_write(dev, AAT2870_BL_CH_EN, priv->channels);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int aat2870_backlight_set_brightness(struct udevice *dev, int percent)
+{
+	struct aat2870_backlight_priv *priv = dev_get_priv(dev);
+	int brightness, ret;
+
+	if (percent == BACKLIGHT_DEFAULT)
+		percent = AAT2870_BL_DEF_BRIGHTNESS;
+
+	if (percent < AAT2870_BL_MIN_BRIGHTNESS)
+		percent = AAT2870_BL_MIN_BRIGHTNESS;
+
+	if (percent > AAT2870_BL_MAX_BRIGHTNESS)
+		percent = AAT2870_BL_MAX_BRIGHTNESS;
+
+	brightness = percent * priv->max_current;
+	brightness /= AAT2870_BL_MAX_BRIGHTNESS;
+
+	/* Set brightness level */
+	ret = dm_i2c_reg_write(dev, AAT2870_BLM, brightness);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int aat2870_backlight_of_to_plat(struct udevice *dev)
+{
+	struct aat2870_backlight_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = gpio_request_by_name(dev, "enable-gpios", 0,
+				   &priv->enable_gpio, GPIOD_IS_OUT);
+	if (ret) {
+		log_err("%s: cannot get enable-gpios (%d)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	/* Backlight is one of children but has no dedicated driver */
+	ofnode backlight = ofnode_find_subnode(dev_ofnode(dev), "backlight");
+	if (ofnode_valid(backlight) && ofnode_is_enabled(backlight)) {
+		/* Number of channel is equal to bit number */
+		priv->channels = dev_read_u32_default(dev, "channels", AAT2870_BL_CH_ALL);
+		if (priv->channels != AAT2870_BL_CH_ALL)
+			priv->channels = BIT(priv->channels);
+
+		/* 450mA - 27900mA range with a 900mA step */
+		priv->max_current = dev_read_u32_default(dev, "current-max-microamp",
+							 AAT2870_CURRENT_MAX);
+		priv->max_current /= AAT2870_CURRENT_STEP;
+	}
+
+	return 0;
+}
+
+static int aat2870_backlight_probe(struct udevice *dev)
+{
+	if (device_get_uclass_id(dev->parent) != UCLASS_I2C)
+		return -EPROTONOSUPPORT;
+
+	return 0;
+}
+
+static const struct backlight_ops aat2870_backlight_ops = {
+	.enable = aat2870_backlight_enable,
+	.set_brightness = aat2870_backlight_set_brightness,
+};
+
+static const struct udevice_id aat2870_backlight_ids[] = {
+	{ .compatible = "analogictech,aat2870" },
+	{ .compatible = "skyworks,aat2870" },
+	{ }
+};
+
+U_BOOT_DRIVER(aat2870_backlight) = {
+	.name		= "aat2870_backlight",
+	.id		= UCLASS_PANEL_BACKLIGHT,
+	.of_match	= aat2870_backlight_ids,
+	.of_to_plat	= aat2870_backlight_of_to_plat,
+	.probe		= aat2870_backlight_probe,
+	.ops		= &aat2870_backlight_ops,
+	.priv_auto	= sizeof(struct aat2870_backlight_priv),
+};
-- 
2.43.0

