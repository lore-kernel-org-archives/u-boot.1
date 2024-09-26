Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA94ACDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 524F188E2C;
	Thu, 26 Sep 2024 22:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eqryFZIQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7686888E2C; Thu, 26 Sep 2024 22:51:01 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56F2288E25
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-84eaa79a00fso204600241.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383858; x=1727988658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8+9Zr2wevhtE5YFd3lEn4disC5Yg2fd861yhGNjBoWs=;
 b=eqryFZIQ6yRQJoqiTp4LZ3c8mdjsRTF9Emg1l97GGblxGJXVJFhPOF8TJ4uQsUDsV9
 xcG/X+sR0PDMp/N08TNGhU7HVAIpNWXnHBkmaidfEGCUFR+dtYWifWdq15pQZcp7MGgJ
 B5fqNEhs8ukD1IGAtk27C/Wjv+tMjy17MSFVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383858; x=1727988658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8+9Zr2wevhtE5YFd3lEn4disC5Yg2fd861yhGNjBoWs=;
 b=lR4gyD4r0lFZ7r4npGBC1u/k1aNby2HwL5uZvtOX7jam/F22q13W3heJgL9+z1KV9p
 pYg0j66G91oeFaD0vUhYjvgb6sgtCEtyPLAQQC7yxzhNkbRPJaJqSBx+oeODiVCu6KYa
 IkRC96gYNhTmqxSLgjYrsGGyQWBmTXerKIQdOMyGtSBU0rg15oC+hf9XOgL9yjP3Zp4l
 4kC2Ome0go9fNJ//qUBVLZqIsSUPzIQu/54wU+VAEO4iwz+pdy7Lxxpe9P7B+ut8ugMQ
 6bZy1FJlY3ImvbyKe4J/TeOxGGT2Er+1v+ioB7GoUh74faPTUK46rQg0iVLm+uqWupe9
 se7A==
X-Gm-Message-State: AOJu0YybQMAOi5Iv3F+lkp3Nk0M5VXbrijjKczXwXXWWiozjxpumrPFS
 IB35Kb/mxvwBNVXsWcupvfYqamJ359ODNQYXS+J37IntNGp6Kd4Mjs+8+pOdazXOjNbev++2jXy
 mC9zlBnc=
X-Google-Smtp-Source: AGHT+IH9DBfxUnFUmJ4rLQHm5w9WBBUQAZxDIjDGmRyYlDJnkBQoqsHwQX/ucxpuDJxHIgO4ouuPgg==
X-Received: by 2002:a05:6102:a49:b0:49c:103:62f1 with SMTP id
 ada2fe7eead31-4a2d7f5b34amr965984137.16.1727383858098; 
 Thu, 26 Sep 2024 13:50:58 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:50:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>
Subject: [PATCH 14/27] misc: status_led: Delete driver
Date: Thu, 26 Sep 2024 22:44:34 +0200
Message-ID: <20240926204455.963584-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926204455.963584-1-sjg@chromium.org>
References: <20240926204455.963584-1-sjg@chromium.org>
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

 drivers/misc/Makefile     |   1 -
 drivers/misc/status_led.c | 124 --------------------------------------
 2 files changed, 125 deletions(-)
 delete mode 100644 drivers/misc/status_led.c

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 03d87ef8a0e..cf6ece919bc 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -48,7 +48,6 @@ obj-$(CONFIG_$(SPL_)I2C_EEPROM) += i2c_eeprom.o
 obj-$(CONFIG_IHS_FPGA) += ihs_fpga.o
 obj-$(CONFIG_IMX8) += imx8/
 obj-$(CONFIG_IMX_ELE) += imx_ele/
-obj-$(CONFIG_LED_STATUS) += status_led.o
 obj-$(CONFIG_MPC83XX_SERDES) += mpc83xx_serdes.o
 obj-$(CONFIG_$(SPL_TPL_)LS2_SFP) += ls2_sfp.o
 obj-$(CONFIG_$(SPL_)MXC_OCOTP) += mxc_ocotp.o
diff --git a/drivers/misc/status_led.c b/drivers/misc/status_led.c
deleted file mode 100644
index 3b1baa4f840..00000000000
--- a/drivers/misc/status_led.c
+++ /dev/null
@@ -1,124 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2000-2003
- * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
- */
-
-#include <status_led.h>
-#include <linux/types.h>
-
-/*
- * The purpose of this code is to signal the operational status of a
- * target which usually boots over the network; while running in
- * U-Boot, a status LED is blinking. As soon as a valid BOOTP reply
- * message has been received, the LED is turned off. The Linux
- * kernel, once it is running, will start blinking the LED again,
- * with another frequency.
- */
-
-/* ------------------------------------------------------------------------- */
-
-typedef struct {
-	led_id_t mask;
-	int state;
-	int period;
-	int cnt;
-} led_dev_t;
-
-led_dev_t led_dev[] = {
-	{	CONFIG_LED_STATUS_BIT,
-		CONFIG_LED_STATUS_STATE,
-		LED_STATUS_PERIOD,
-		0,
-	},
-#if defined(CONFIG_LED_STATUS1)
-	{	CONFIG_LED_STATUS_BIT1,
-		CONFIG_LED_STATUS_STATE1,
-		LED_STATUS_PERIOD1,
-		0,
-	},
-#endif
-#if defined(CONFIG_LED_STATUS2)
-	{	CONFIG_LED_STATUS_BIT2,
-		CONFIG_LED_STATUS_STATE2,
-		LED_STATUS_PERIOD2,
-		0,
-	},
-#endif
-#if defined(CONFIG_LED_STATUS3)
-	{	CONFIG_LED_STATUS_BIT3,
-		CONFIG_LED_STATUS_STATE3,
-		LED_STATUS_PERIOD3,
-		0,
-	},
-#endif
-#if defined(CONFIG_LED_STATUS4)
-	{	CONFIG_LED_STATUS_BIT4,
-		CONFIG_LED_STATUS_STATE4,
-		LED_STATUS_PERIOD4,
-		0,
-	},
-#endif
-#if defined(CONFIG_LED_STATUS5)
-	{	CONFIG_LED_STATUS_BIT5,
-		CONFIG_LED_STATUS_STATE5,
-		LED_STATUS_PERIOD5,
-		0,
-	},
-#endif
-};
-
-#define MAX_LED_DEV	(sizeof(led_dev)/sizeof(led_dev_t))
-
-static int status_led_init_done = 0;
-
-void status_led_init(void)
-{
-	led_dev_t *ld;
-	int i;
-
-	for (i = 0, ld = led_dev; i < MAX_LED_DEV; i++, ld++)
-		__led_init (ld->mask, ld->state);
-	status_led_init_done = 1;
-}
-
-void status_led_tick(ulong timestamp)
-{
-	led_dev_t *ld;
-	int i;
-
-	if (!status_led_init_done)
-		status_led_init();
-
-	for (i = 0, ld = led_dev; i < MAX_LED_DEV; i++, ld++) {
-
-		if (ld->state != CONFIG_LED_STATUS_BLINKING)
-			continue;
-
-		if (++ld->cnt >= ld->period) {
-			__led_toggle (ld->mask);
-			ld->cnt -= ld->period;
-		}
-
-	}
-}
-
-void status_led_set(int led, int state)
-{
-	led_dev_t *ld;
-
-	if (led < 0 || led >= MAX_LED_DEV)
-		return;
-
-	if (!status_led_init_done)
-		status_led_init();
-
-	ld = &led_dev[led];
-
-	ld->state = state;
-	if (state == CONFIG_LED_STATUS_BLINKING) {
-		ld->cnt = 0;		/* always start with full period    */
-		state = CONFIG_LED_STATUS_ON;	/* always start with LED _ON_ */
-	}
-	__led_set (ld->mask, state);
-}
-- 
2.43.0

