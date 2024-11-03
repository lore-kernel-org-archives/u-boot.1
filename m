Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEFDE67816
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:36:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FBF4892EA;
	Sun,  3 Nov 2024 01:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hOJg9PRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B370892ED; Sun,  3 Nov 2024 01:36:37 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9285389300
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20c8c50fdd9so27404595ad.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594192; x=1731198992; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UoKVjYTaokoC06XTEbnI0rWMNIaMByupWKue3WgPWqg=;
 b=hOJg9PREZgOW1LGAzTHK4wd2dPxZgZP2nWloZ/+qsITG+nDwzpVQqk5dt+KeSEz6+2
 NMEROPNbgAVeQ8Krcbf7PtnyQIYI8RYrTdbSaKZpZs30MlYExNgHx056qPsX3Rlmg1u9
 nE3eSlo0yl4PCVzKv6IQkZtLoPZzTU6AGZR1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594192; x=1731198992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UoKVjYTaokoC06XTEbnI0rWMNIaMByupWKue3WgPWqg=;
 b=rLmhgYF6OWNShkZf0NsvQ6ZDZxwHMkh/jLGFsSFUoADXf86R75FglERpNJo1mfhYcK
 aK0Ie5YkTYLcNiZo3r4y1qO5yNxHyzlHPDpjC4SH4TicFwvaGm6K5W5iQjz85yY4l5pK
 2F/bgEUEerYBRhgJ+4U7T1exguCWlWnGQacw89+1tnzOiEj3bBMZ4LJfs5a9F98/HqYu
 BXoTeYKNG8LbAnub++++9XOgdK5hP3Rkv/xvMLxIkvpdHlCa7ZX/EhHharUaHwJDcFJg
 hOHhA+6ImH6PmN4LDILCyHXZsK9nzvN2nOtR3JHfpg1Qivd3EgY3XAIIvF4R7g4Db+DV
 CQeA==
X-Gm-Message-State: AOJu0YyhOHZ+knxjNngC43if4zvUfqwOd80p6CiTh/5JNNGCQVyBrwsL
 ayn3f1yLsYNqGwijhGG7cL3BcFhxxaZlSYSPOKu0Qfh3hIaR8XeVarZh3xkUN+DV9+WdlZxsEqe
 fFQ==
X-Google-Smtp-Source: AGHT+IEhOAD/N3panq5ZqRiFN7yGv2/CeaAmLmIpex/HZTeMZJIkIu8MBV+RGSIol7j+r+P6sDgT4A==
X-Received: by 2002:a17:902:ec8e:b0:211:2fb2:6a6 with SMTP id
 d9443c01a7336-2112fb206e3mr65595945ad.24.1730594192382; 
 Sat, 02 Nov 2024 17:36:32 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:36:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Wan Yee Lau <wan.yee.lau@intel.com>
Subject: [PATCH v3 13/25] pca9551_led: Delete driver
Date: Sat,  2 Nov 2024 18:33:05 -0600
Message-ID: <20241103003322.626036-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103003322.626036-1-sjg@chromium.org>
References: <20241103003322.626036-1-sjg@chromium.org>
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

This driver is not used anymore. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/misc/Kconfig       |  13 ---
 drivers/misc/Makefile      |   1 -
 drivers/misc/pca9551_led.c | 170 -------------------------------------
 3 files changed, 184 deletions(-)
 delete mode 100644 drivers/misc/pca9551_led.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6009d55f400..23eb509d974 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -446,19 +446,6 @@ config SPL_PWRSEQ
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
index b7332587faa..e8f48228084 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,7 +57,6 @@ obj-$(CONFIG_NPCM_OTP) += npcm_otp.o
 obj-$(CONFIG_NPCM_HOST) += npcm_host_intf.o
 obj-$(CONFIG_NUVOTON_NCT6102D) += nuvoton_nct6102d.o
 obj-$(CONFIG_P2SB) += p2sb-uclass.o
-obj-$(CONFIG_PCA9551_LED) += pca9551_led.o
 obj-$(CONFIG_$(XPL_)PWRSEQ) += pwrseq-uclass.o
 ifdef CONFIG_QFW
 obj-y += qfw.o
diff --git a/drivers/misc/pca9551_led.c b/drivers/misc/pca9551_led.c
deleted file mode 100644
index 040d0d5cf48..00000000000
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

