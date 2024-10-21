Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC29D0E6F7
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9A76892E0;
	Mon, 21 Oct 2024 13:39:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cahS9kMt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C194388FD6; Mon, 21 Oct 2024 13:39:07 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD65488F49
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso527320666b.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510744; x=1730115544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d0RWAbjFH6JwbiIniusRi0ZpMAwp3s8KBSo0/2SQ2qw=;
 b=cahS9kMtn5oEteEYHpGJG5OMXXVWP/i8oPGJVWyrBw11WILzOgulUYuYkzNNI7ftJ5
 GZaByrG10ysArf1R2f+RpYybtDo1WRvyv0zv1EUU3wF6oJ2XB6pK945fYhM4jXL8t3UO
 6Nhn4YyXnq9Cx2SAd+TT52jSLNcCja417nq7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510744; x=1730115544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d0RWAbjFH6JwbiIniusRi0ZpMAwp3s8KBSo0/2SQ2qw=;
 b=knJNws+pBJqgmRuPhL7GGw9bda5D6qsBpgpcpku1SYhXFOI3jUhyPj7ElhcEP+zp7O
 JGaVH0bf+doeT4F4JxFwscfAc99I2IX5rWhBtzFy0+Ij5zdhAx3p6Atdf5GZthItlh2h
 KBwNSpKCsugufQX2WYPG41aOTW/I52CpERSIvh75t+YVCnyqiMDI+rxsr2g9Tyn9BCNW
 Sc6I2sygz/kxegUKGdWwLJEJlNIaeOGYF8M6vucV4mwrERteLsnmYJXH9LIgOM3RLccE
 cjF4Tv29+dnR5sQj11WduHfWuhjbB320Wsr0p6WFWLb+Sg5BW9zAFbHXWVtAcwOoWYSq
 6G7w==
X-Gm-Message-State: AOJu0Yy43/F5k13JAU44zmbiV/VYvtqtvHQq0qBsIdZomOUseJmA48SA
 3Z8YmpySuQEwC5DdTSDPlWOre8NynXXQ5WxmkV6cscOPEy3cNi9mLgVoP1S/mrDbMdNTcHGVys3
 5jwzF
X-Google-Smtp-Source: AGHT+IH4lR5yVdB3P1USGUPUdk3xmGbZiCMDa4t3/9r5ydMN+pdqmdaZwzy6P+u97HxDSjvVzETyvA==
X-Received: by 2002:a17:906:c116:b0:a99:5d03:4687 with SMTP id
 a640c23a62f3a-a9a69a766bamr1163790366b.21.1729510744096; 
 Mon, 21 Oct 2024 04:39:04 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:39:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>
Subject: [PATCH v2 15/25] misc: status_led: Delete driver
Date: Mon, 21 Oct 2024 13:38:23 +0200
Message-ID: <20241021113839.318572-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021113839.318572-1-sjg@chromium.org>
References: <20241021113839.318572-1-sjg@chromium.org>
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

