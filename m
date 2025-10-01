Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95688CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 20:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5EF08344E;
	Wed,  1 Oct 2025 22:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c3/E6PeC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B74D3834D4; Wed,  1 Oct 2025 22:30:35 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 569C381D6A
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 22:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-36f51ac0595so157303fac.2
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 13:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759350632; x=1759955432; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a2yFNQ7r4AmGqab/FrCgTw8vJumTQmC3gD+3twOBvik=;
 b=c3/E6PeCx7DuhIyNc6dysPIjKYao4v0VZTvZHrCFtZXayjCF8Xm12/TqIZ1eE6UwiU
 b/2wkhB0V2bqYBqSYpmFKN6NKuUIPng1V7t427o+laemule63cHfkcwDMBYdLUGJsMeb
 YUcxJlDGvvxcD4X/lfpoRpXS9R72+I2DZANUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350632; x=1759955432;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a2yFNQ7r4AmGqab/FrCgTw8vJumTQmC3gD+3twOBvik=;
 b=eAm8F07QIh3uB2qf4aSot2uDoHcaIQC4GfqLAUX/4AmNeGDwfkfBodWis0L3YdaTUE
 sohUWLNrmCW519UN4DT5UCFhdsMtGjwPX/1h2F/0qmH5ijVmkt6bmBSqR5YVMo0K5PAa
 QjAs/BSsrnFACOHRvLMmfvY8KFnVMANlasyL9lsAKpDxEANd+IJMD0ZrVcj8wTyrVS8/
 fHqwEEEzlwElRBluK2dD/uTb2o5mSGWPKkKsWELod724RfeMk0DlZrfBWA0tOdnK26is
 iwKUn9ZTGf+/bjmHROsxI/B3URF4w4EBiVy0aWJdyCS82fLQrmjrw4L+2HxPNUs6nyCk
 XxPQ==
X-Gm-Message-State: AOJu0YyK7ycQokmdSJ9IQk9W8TW2M7zmNvQ4U9uDwCvNb+oD9of/8u5r
 /8GlgnDb2VU9zn7CaZUtno2iq2lEuQ2Y9SFQolSgnpVOR0AWkRpVSsTOeOsafIEKf9VUGqAXC+0
 0xLXAnio=
X-Gm-Gg: ASbGncursVKSrsntajv+D0lgi7jRBphotTNzq0OuFL855jcnke1gf1Kslxzp7S5r8Ks
 M7R0+CqKyRWA7g7p53SJ8Wr/+H2wXDZIXqk4pINIzv/ejfwpRk9pOTI0i/JFNOAd/0DYBKeZala
 G1W1fK/eFdUpwGmnjl0gbyIeP7vyLztLSVJLV78Tk6L6CvKLtNDL9hbLGOFESpP0N4RN2lYd9kB
 YdVJIokhUbDb+oeUgTsxQlydyutdYoRHZb0AT/1GdtoC7YSZ7sdrmNhBBzvs81ZfWQWjeYQnWnP
 AfBBbq2sa4ub6NTc2Eh1Z+AfZjiHWe4A8CW9HuweeeK1QwOBjxY3j/qLqJ6FRKrb/OJZsf7y+U2
 wK/LXTVa8QMwWBiv+rYhUdTK4JCYrGBYRdWEpGCGkfOID3lSAfpKQlk50eEaIwmgoS251BRxoGC
 3QMAvJrhY=
X-Google-Smtp-Source: AGHT+IFBysa6M/ptD4y0DQ0v3hSzzWDgymcL7GxS29ZNwdSDjCbBGN/iR6jwznND09X6Dr/a5Dcksg==
X-Received: by 2002:a05:6870:a3c9:b0:375:8591:7701 with SMTP id
 586e51a60fabf-39b8d44892amr2610557fac.9.1759350631874; 
 Wed, 01 Oct 2025 13:30:31 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ab7ce5655dsm219888fac.13.2025.10.01.13.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:30:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Sergei Antonov <saproj@gmail.com>
Subject: [PATCH] gpio: Remove FTGPIO0010 driver
Date: Wed,  1 Oct 2025 14:30:29 -0600
Message-ID: <20251001203029.2828194-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

This driver has never been enabled and currently has build problems
related in part to incorrect out_le32 calls. Remove it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Sergei Antonov <saproj@gmail.com>
---
 drivers/gpio/Kconfig     |   6 ---
 drivers/gpio/Makefile    |   1 -
 drivers/gpio/ftgpio010.c | 110 ---------------------------------------
 3 files changed, 117 deletions(-)
 delete mode 100644 drivers/gpio/ftgpio010.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 58e464106a30..db077e472a81 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -695,12 +695,6 @@ config SLG7XL45106_I2C_GPO
 	   8-bit gpo expander, all gpo lines are controlled by writing
 	   value into data register.
 
-config FTGPIO010
-	bool "Faraday Technology FTGPIO010 driver"
-	depends on DM_GPIO
-	help
-	   Support for GPIOs on Faraday Technology's FTGPIO010 controller.
-
 config ADP5585_GPIO
 	bool "ADP5585 GPIO driver"
 	depends on DM_GPIO && DM_I2C
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 83e10c79b918..73c94329e36c 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -77,7 +77,6 @@ obj-$(CONFIG_SL28CPLD_GPIO)	+= sl28cpld-gpio.o
 obj-$(CONFIG_ADP5588_GPIO)	+= adp5588_gpio.o
 obj-$(CONFIG_ZYNQMP_GPIO_MODEPIN)	+= zynqmp_gpio_modepin.o
 obj-$(CONFIG_SLG7XL45106_I2C_GPO)	+= gpio_slg7xl45106.o
-obj-$(CONFIG_FTGPIO010)		+= ftgpio010.o
 obj-$(CONFIG_$(PHASE_)ADP5585_GPIO)	+= adp5585_gpio.o
 obj-$(CONFIG_RZG2L_GPIO)	+= rzg2l-gpio.o
 obj-$(CONFIG_MPFS_GPIO)	+= mpfs_gpio.o
diff --git a/drivers/gpio/ftgpio010.c b/drivers/gpio/ftgpio010.c
deleted file mode 100644
index 4cb550a540c6..000000000000
--- a/drivers/gpio/ftgpio010.c
+++ /dev/null
@@ -1,110 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Faraday Technology's FTGPIO010 controller.
- */
-
-#include <dm.h>
-#include <asm/io.h>
-#include <asm/gpio.h>
-
-struct ftgpio010_regs {
-	u32 out;
-	u32 in;
-	u32 direction;	// 1 - output
-	u32 reserved;
-	u32 set;
-	u32 clear;
-};
-
-struct ftgpio010_plat {
-	struct ftgpio010_regs __iomem *regs;
-};
-
-static int ftgpio010_direction_input(struct udevice *dev, unsigned int pin)
-{
-	struct ftgpio010_plat *plat = dev_get_plat(dev);
-	struct ftgpio010_regs *const regs = plat->regs;
-
-	clrbits_le32(&regs->direction, 1 << pin);
-	return 0;
-}
-
-static int ftgpio010_direction_output(struct udevice *dev, unsigned int pin,
-				      int val)
-{
-	struct ftgpio010_plat *plat = dev_get_plat(dev);
-	struct ftgpio010_regs *const regs = plat->regs;
-
-	/* change the data first, then the direction. to avoid glitch */
-	out_le32(val ? &regs->set : &regs->clear, 1 << pin);
-	setbits_le32(&regs->direction, 1 << pin);
-
-	return 0;
-}
-
-static int ftgpio010_get_value(struct udevice *dev, unsigned int pin)
-{
-	struct ftgpio010_plat *plat = dev_get_plat(dev);
-	struct ftgpio010_regs *const regs = plat->regs;
-
-	return in_le32(&regs->in) >> pin & 1;
-}
-
-static int ftgpio010_set_value(struct udevice *dev, unsigned int pin, int val)
-{
-	struct ftgpio010_plat *plat = dev_get_plat(dev);
-	struct ftgpio010_regs *const regs = plat->regs;
-
-	out_le32(val ? &regs->set : &regs->clear, 1 << pin);
-	return 0;
-}
-
-static int ftgpio010_get_function(struct udevice *dev, unsigned int pin)
-{
-	struct ftgpio010_plat *plat = dev_get_plat(dev);
-	struct ftgpio010_regs *const regs = plat->regs;
-
-	if (in_le32(&regs->direction) >> pin & 1)
-		return GPIOF_OUTPUT;
-	return GPIOF_INPUT;
-}
-
-static int ftgpio010_probe(struct udevice *dev)
-{
-	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
-
-	uc_priv->gpio_count = ofnode_read_u32_default(dev_ofnode(dev),
-						      "nr-gpios", 32);
-	return 0;
-}
-
-static int ftgpio010_of_to_plat(struct udevice *dev)
-{
-	struct ftgpio010_plat *plat = dev_get_plat(dev);
-
-	plat->regs = dev_read_addr_ptr(dev);
-	return 0;
-}
-
-static const struct dm_gpio_ops ftgpio010_ops = {
-	.direction_input	= ftgpio010_direction_input,
-	.direction_output	= ftgpio010_direction_output,
-	.get_value		= ftgpio010_get_value,
-	.set_value		= ftgpio010_set_value,
-	.get_function		= ftgpio010_get_function,
-};
-
-static const struct udevice_id ftgpio010_ids[] = {
-	{ .compatible = "faraday,ftgpio010" },
-	{ }
-};
-
-U_BOOT_DRIVER(ftgpio010) = {
-	.name		= "ftgpio010",
-	.id		= UCLASS_GPIO,
-	.of_match	= ftgpio010_ids,
-	.ops		= &ftgpio010_ops,
-	.of_to_plat	= ftgpio010_of_to_plat,
-	.plat_auto	= sizeof(struct ftgpio010_plat),
-	.probe		= ftgpio010_probe,
-};
-- 
2.43.0

