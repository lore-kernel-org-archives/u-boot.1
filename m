Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4A9E67816
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 714EA89145;
	Sun,  3 Nov 2024 01:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZbgYpOe+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF3C28911A; Sun,  3 Nov 2024 01:36:48 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30CB0892FD
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7d4fa972cbeso2347262a12.2
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594203; x=1731199003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d0RWAbjFH6JwbiIniusRi0ZpMAwp3s8KBSo0/2SQ2qw=;
 b=ZbgYpOe+hOwRTGUHcpesXz/7Hxdy4KNmA1+WEOF8HEGkNzlXu4w1SD80jkYJhnYjqm
 Ts1mehstRgZCLag0tQbjatLgcwX+3BgRY7xiRwtYYeQWrROwj53S27wF76Tm8EnRvx0+
 bP+MS+zvvn6+0UkvF801Di2LRa+iAEW71issY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594203; x=1731199003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d0RWAbjFH6JwbiIniusRi0ZpMAwp3s8KBSo0/2SQ2qw=;
 b=njkltlRyVTnIxYYeN4ngch40p0URAmEHol1dRId/sDH1Mz9VWIvRszP+O6oHiFYTFB
 I7YoxU4caBCTZBhzQB0MwZDdg6RVe4jGpBqIIFkyMKcxqzND5mOIH5xeK+TxVOXg5LyN
 h308hxEYyR6nnFbKKEr+2ttZ0n23o7gtlRVekw7WOxFY+YQ2UwkwCHH1QjiO9U+RZea/
 MgXB9Gx4T2/Ofpi5MWJWW3MwU1yVihFRPgEWvOCl4i3c7Vzj2F6kXkE4y+XDBRYLdsbV
 uQfFlcfIJwgAkzHu/c+//EUbfFmHUwUlpQpmw2Wp524LRqis6DRDr7sDMsgONH/vJtj+
 zB7w==
X-Gm-Message-State: AOJu0YwOV5HzFWqs53mMTL+nPAEZ9Ed2hWb80qiQlpBne0HgGWCNmsuQ
 alBcU6I+TrE54ZDxEWRNvL8MB1G9GBMSXUXraEVW44dV2BvekjITKhP1cdUWQUJUxTkaP0/xLJ+
 ULg==
X-Google-Smtp-Source: AGHT+IGRrCKI+6J9mTeibn2LE02WJQuFZs/DVmwef+DRlvbOvRabeOemBlqGyF08L76kObudbnfz5Q==
X-Received: by 2002:a17:902:d543:b0:20c:7661:dcbf with SMTP id
 d9443c01a7336-210c6c95170mr317293115ad.55.1730594203602; 
 Sat, 02 Nov 2024 17:36:43 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:36:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Wan Yee Lau <wan.yee.lau@intel.com>
Subject: [PATCH v3 14/25] misc: status_led: Delete driver
Date: Sat,  2 Nov 2024 18:33:06 -0600
Message-ID: <20241103003322.626036-15-sjg@chromium.org>
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

 drivers/misc/Makefile     |   1 -
 drivers/misc/status_led.c | 124 --------------------------------------
 2 files changed, 125 deletions(-)
 delete mode 100644 drivers/misc/status_led.c

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e8f48228084..e975559fd75 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -48,7 +48,6 @@ obj-$(CONFIG_$(XPL_)I2C_EEPROM) += i2c_eeprom.o
 obj-$(CONFIG_IHS_FPGA) += ihs_fpga.o
 obj-$(CONFIG_IMX8) += imx8/
 obj-$(CONFIG_IMX_ELE) += imx_ele/
-obj-$(CONFIG_LED_STATUS) += status_led.o
 obj-$(CONFIG_MPC83XX_SERDES) += mpc83xx_serdes.o
 obj-$(CONFIG_$(PHASE_)LS2_SFP) += ls2_sfp.o
 obj-$(CONFIG_$(XPL_)MXC_OCOTP) += mxc_ocotp.o
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

