Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3713C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CBBC83152;
	Fri, 11 Jul 2025 17:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TK/r+qhC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2FAD83018; Fri, 11 Jul 2025 17:20:27 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FB0B82F14
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-73cdce0eaffso1168507a34.2
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752247224; x=1752852024; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2IhTQcILjn36J+B3+51JmSKmsDO6zRQequQ3HBhhElw=;
 b=TK/r+qhCZifHpQJZOswrLYlQI3dzRI1Q30ekzhHmk/IbR/7QnTnEitdco8TmeMAcFC
 JxKQVPHy0CAYgOxx+tjHOEoT3ku9GeNnKrZsrP6Z7xGg0kfL0Yx0L9hcLiED567zvhYq
 HRRjmMzLX0HMLq8aN1UDyIqU7O+egxajVUHxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752247224; x=1752852024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2IhTQcILjn36J+B3+51JmSKmsDO6zRQequQ3HBhhElw=;
 b=h30VpYAzrxAy7dTU94N9A5xumBjAbCLpj8FB4S+lwBOJl/enCG+zxOzYmtnuu81O2Y
 3535+oy6pOIto7bHnSaksyukZ5ERtTl7/JlAHtyTGJUJgMMr83VIsujzO9jtoaqFpbRE
 zziI4KJrmZOFxXRrdeqg5+U6neZN+xtWHIsKPiAgTojSMageaynG1X+/OKYV5ifTflZN
 dNr7G3ER4kuBp78kafftYlX22/CCQ3PrTSONURhSbIY2MT9Jxxfhg876HysTE9/ok5AT
 JuYyl+Leb6FPNKDfObxNNH95Rly+Is2wmTtur45G01m9qxYQyn+U57yzIamPE8aHCQ/3
 xmnw==
X-Gm-Message-State: AOJu0YwW+sq64H3AGY3HthbqApZuhoSqia6j0aRKvrszxf+hKwmI3jGl
 JLPrhR4aMRI+dXIyOLCb8I8kjOExwNKcJGDZqgyB63/oqY/7eD2LMu8vmxw/chgYGNb+xmjQstZ
 hgH7Th3w=
X-Gm-Gg: ASbGnct/gFtEl9nQtys4OKS52gnoiDBiD65N7GDBbk19/89KHx4pXpDncsOlhSq+cht
 guM8OEqTg5lRhUXB0pFIHu7l1YGmQMu14pMcdBlCsdzbJcJjKE68ClFjxZexlN5z8wBPcrs+xif
 KYzH9VdRZEbj9sVaP7sdrQfEEUXyAJXHeCKzIR6CIE/BuSxZjLCBb4gev4szHdRq4OaLFl/l9+e
 1zBLKuz/dczntOt8jYJRDHYF7BFspx3yvrAr1n70dLUK8KD6IvFr0KE/docBC+DOax33blMFV8+
 Pa0kOhcdvVIyrL2uEOnS4uIcKlBcAwpyLe+a4NZrtG2a5ZP0l4yQh7lhjWYqAUe9TpvIfNPCkcj
 IVQ/CIWXbIy1BNsoyvpAHsE1nz/zBOTK1DVnq9kGbDucola++7wllgSckdjI=
X-Google-Smtp-Source: AGHT+IGMDtMnFwI9pc0qbHVCH+X1p2Tns/Th/YCFfwSTtRr2b6ZGu0tWR5glfSzA99e1iz7qniX3Og==
X-Received: by 2002:a05:6830:6c08:b0:731:cac7:3636 with SMTP id
 46e09a7af769-73cf9e7d91cmr2320295a34.6.1752247224120; 
 Fri, 11 Jul 2025 08:20:24 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf1275280sm588150a34.31.2025.07.11.08.20.23
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:20:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] drivers: misc: Remove pca9551_led driver
Date: Fri, 11 Jul 2025 09:20:22 -0600
Message-ID: <20250711152022.2225526-1-trini@konsulko.com>
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

This driver has not been converted to DM_I2C and the last platform that
used it was removed as well. Remove the driver.

Fixes: 4bbcec08ebec ("arm: Remove mx6dlarm2 board")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/misc/Kconfig       |  13 ---
 drivers/misc/Makefile      |   1 -
 drivers/misc/pca9551_led.c | 170 -------------------------------------
 3 files changed, 184 deletions(-)
 delete mode 100644 drivers/misc/pca9551_led.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index d7433120b75a..e9866fbcdd7a 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -428,19 +428,6 @@ config SPL_PWRSEQ
 	  device. When the device is started up, its power sequence can be
 	  initiated.
 
-config PCA9551_LED
-	bool "Enable PCA9551 LED driver"
-	help
-	  Enable driver for PCA9551 LED controller. This controller
-	  is connected via I2C. So I2C needs to be enabled.
-
-config PCA9551_I2C_ADDR
-	hex "I2C address of PCA9551 LED controller"
-	depends on PCA9551_LED
-	default 0x60
-	help
-	  The I2C address of the PCA9551 LED controller.
-
 config STM32MP_FUSE
 	bool "Enable STM32MP fuse wrapper providing the fuse API"
 	depends on ARCH_STM32MP && MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 83a95f683aca..09dfd8072dbf 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -58,7 +58,6 @@ obj-$(CONFIG_NPCM_OTP) += npcm_otp.o
 obj-$(CONFIG_NPCM_HOST) += npcm_host_intf.o
 obj-$(CONFIG_NUVOTON_NCT6102D) += nuvoton_nct6102d.o
 obj-$(CONFIG_P2SB) += p2sb-uclass.o
-obj-$(CONFIG_PCA9551_LED) += pca9551_led.o
 obj-$(CONFIG_$(PHASE_)PWRSEQ) += pwrseq-uclass.o
 ifdef CONFIG_QFW
 obj-y += qfw.o
diff --git a/drivers/misc/pca9551_led.c b/drivers/misc/pca9551_led.c
deleted file mode 100644
index 040d0d5cf48c..000000000000
--- a/drivers/misc/pca9551_led.c
+++ /dev/null
@@ -1,170 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2015 Stefan Roese <sr@denx.de>
- */
-
-#include <errno.h>
-#include <i2c.h>
-#include <status_led.h>
-
-#ifndef CONFIG_PCA9551_I2C_ADDR
-#error "CONFIG_PCA9551_I2C_ADDR not defined!"
-#endif
-
-#define PCA9551_REG_INPUT	0x00	/* Input register (read only) */
-#define PCA9551_REG_PSC0	0x01	/* Frequency prescaler 0 */
-#define PCA9551_REG_PWM0	0x02	/* PWM0 */
-#define PCA9551_REG_PSC1	0x03	/* Frequency prescaler 1 */
-#define PCA9551_REG_PWM1	0x04	/* PWM1 */
-#define PCA9551_REG_LS0		0x05	/* LED0 to LED3 selector */
-#define PCA9551_REG_LS1		0x06	/* LED4 to LED7 selector */
-
-#define PCA9551_CTRL_AI		(1 << 4)	/* Auto-increment flag */
-
-#define PCA9551_LED_STATE_ON		0x00
-#define PCA9551_LED_STATE_OFF		0x01
-#define PCA9551_LED_STATE_BLINK0	0x02
-#define PCA9551_LED_STATE_BLINK1	0x03
-
-struct pca9551_blink_rate {
-	u8 psc;	/* Frequency preescaler, see PCA9551_7.pdf p. 6 */
-	u8 pwm;	/* Pulse width modulation, see PCA9551_7.pdf p. 6 */
-};
-
-static int freq_last = -1;
-static int mask_last = -1;
-static int idx_last = -1;
-static int mode_last;
-
-static int pca9551_led_get_state(int led, int *state)
-{
-	unsigned int reg;
-	u8 shift, buf;
-	int ret;
-
-	if (led < 0 || led > 7) {
-		return -EINVAL;
-	} else if (led < 4) {
-		reg = PCA9551_REG_LS0;
-		shift = led << 1;
-	} else {
-		reg = PCA9551_REG_LS1;
-		shift = (led - 4) << 1;
-	}
-
-	ret = i2c_read(CONFIG_PCA9551_I2C_ADDR, reg, 1, &buf, 1);
-	if (ret)
-		return ret;
-
-	*state = (buf >> shift) & 0x03;
-	return 0;
-}
-
-static int pca9551_led_set_state(int led, int state)
-{
-	unsigned int reg;
-	u8 shift, buf, mask;
-	int ret;
-
-	if (led < 0 || led > 7) {
-		return -EINVAL;
-	} else if (led < 4) {
-		reg = PCA9551_REG_LS0;
-		shift = led << 1;
-	} else {
-		reg = PCA9551_REG_LS1;
-		shift = (led - 4) << 1;
-	}
-	mask = 0x03 << shift;
-
-	ret = i2c_read(CONFIG_PCA9551_I2C_ADDR, reg, 1, &buf, 1);
-	if (ret)
-		return ret;
-
-	buf = (buf & ~mask) | ((state & 0x03) << shift);
-
-	ret = i2c_write(CONFIG_PCA9551_I2C_ADDR, reg, 1, &buf, 1);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static int pca9551_led_set_blink_rate(int idx, struct pca9551_blink_rate rate)
-{
-	unsigned int reg;
-	int ret;
-
-	switch (idx) {
-	case 0:
-		reg = PCA9551_REG_PSC0;
-		break;
-	case 1:
-		reg = PCA9551_REG_PSC1;
-		break;
-	default:
-		return -EINVAL;
-	}
-	reg |= PCA9551_CTRL_AI;
-
-	ret = i2c_write(CONFIG_PCA9551_I2C_ADDR, reg, 1, (u8 *)&rate, 2);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-/*
- * Functions referenced by cmd_led.c or status_led.c
- */
-void __led_init(led_id_t id, int state)
-{
-}
-
-void __led_set(led_id_t mask, int state)
-{
-	if (state == CONFIG_LED_STATUS_OFF)
-		pca9551_led_set_state(mask, PCA9551_LED_STATE_OFF);
-	else
-		pca9551_led_set_state(mask, PCA9551_LED_STATE_ON);
-}
-
-void __led_toggle(led_id_t mask)
-{
-	int state = 0;
-
-	pca9551_led_get_state(mask, &state);
-	pca9551_led_set_state(mask, !state);
-}
-
-void __led_blink(led_id_t mask, int freq)
-{
-	struct pca9551_blink_rate rate;
-	int mode;
-	int idx;
-
-	if ((freq == freq_last) || (mask == mask_last)) {
-		idx = idx_last;
-		mode = mode_last;
-	} else {
-		/* Toggle blink index */
-		if (idx_last == 0) {
-			idx = 1;
-			mode = PCA9551_LED_STATE_BLINK1;
-		} else {
-			idx = 0;
-			mode = PCA9551_LED_STATE_BLINK0;
-		}
-
-		idx_last = idx;
-		mode_last = mode;
-	}
-	freq_last = freq;
-	mask_last = mask;
-
-	rate.psc = ((freq * 38) / 1000) - 1;
-	rate.pwm = 128;		/* 50% duty cycle */
-
-	pca9551_led_set_blink_rate(idx, rate);
-	pca9551_led_set_state(mask, mode);
-}
-- 
2.43.0

