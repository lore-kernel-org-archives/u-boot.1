Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75192CDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15D2988E0D;
	Thu, 26 Sep 2024 22:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hLyiLIyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD10588E0E; Thu, 26 Sep 2024 22:50:02 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4341888DF9
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-6cb2aaf4a73so10590726d6.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383799; x=1727988599; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KecH9mV+QNGXAL/aktsMvbE9TQWIGHx/UctZiGMOgUc=;
 b=hLyiLIyWKh2YFAcH2ICL8TylTCS5Vhjr26q1agXwCXLIvvKa3fMEAx+ot0ZHOrTARQ
 AsaY+mAKXM+kzVprOdqNdzDvlELa2N36svLZF1UIVvp2tMS49RzYVXhWCqWn85PA4iJt
 w+48WVwPCm4Zi9LY8kzRft1zdtTEFnIvLqsEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383799; x=1727988599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KecH9mV+QNGXAL/aktsMvbE9TQWIGHx/UctZiGMOgUc=;
 b=gGDZ08ADhmPrbJSX9qUrWZ7sSY//nv36bnVSGpw+54jwIv8ITjqWc7u2cm78i69Ug0
 oaWqxQg9nmLiqdVDvXbDkjykNBy1/IEDEGuwUOIaNd0D2em2XxMNs7iYl/6OlkFMYc8h
 ow95lyT6X2x3ZdoEIi4B+B323DsJg2WRJvWk3wKrvKgwBwjSsD/8Tty5MFNonMvH1WJ+
 BzVRILhN0uJH19M4+55NVcgK+faki8yrgblMHb7S0wy01SuiaccUDKCiUfwgNim7GE9E
 mttvPyQabLq8lWy+3msfamUZGi5B4lba2rZgODIuCt03Lo2YRrhfYUxybyW0MNZXqQe0
 R5yA==
X-Gm-Message-State: AOJu0YwNwdHvCia+LDDOWRsckcJAe9iZhpMXNerJHzFpFFr5JoeBPR5E
 rCpyGMSIpEy0KbKWbqNkf5Uid9UUbUqdUZQ1imLi/tK2JO0tntR8wJsA6pgVqii3tjoutDV/Vi+
 vhRTSeQZWlQ==
X-Google-Smtp-Source: AGHT+IFWUmTKh3bvenGBQcQZUA9nEuA8gjwu0X3zYdpr1yC+A+FcC/c/XjrzlHuqy0GRlZbswdEoFQ==
X-Received: by 2002:a05:6214:459c:b0:6c3:508a:fec4 with SMTP id
 6a1803df08f44-6cb3b670cacmr15560806d6.46.1727383798943; 
 Thu, 26 Sep 2024 13:49:58 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:49:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH 11/27] led: Drop the legacy LED command
Date: Thu, 26 Sep 2024 22:44:31 +0200
Message-ID: <20240926204455.963584-12-sjg@chromium.org>
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

This is not used by any board. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/Makefile     |   1 -
 cmd/legacy_led.c | 145 -----------------------------------------------
 2 files changed, 146 deletions(-)
 delete mode 100644 cmd/legacy_led.c

diff --git a/cmd/Makefile b/cmd/Makefile
index 91227f1249c..ca57ac86b79 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -102,7 +102,6 @@ obj-$(CONFIG_CMD_IRQ) += irq.o
 obj-$(CONFIG_CMD_ITEST) += itest.o
 obj-$(CONFIG_CMD_JFFS2) += jffs2.o
 obj-$(CONFIG_CMD_CRAMFS) += cramfs.o
-obj-$(CONFIG_LED_STATUS_CMD) += legacy_led.o
 obj-$(CONFIG_CMD_LED) += led.o
 obj-$(CONFIG_CMD_LICENSE) += license.o
 obj-y += load.o
diff --git a/cmd/legacy_led.c b/cmd/legacy_led.c
deleted file mode 100644
index ef2135e0dba..00000000000
--- a/cmd/legacy_led.c
+++ /dev/null
@@ -1,145 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2010
- * Jason Kridner <jkridner@beagleboard.org>
- *
- * Based on cmd_led.c patch from:
- * http://www.mail-archive.com/u-boot@lists.denx.de/msg06873.html
- * (C) Copyright 2008
- * Ulf Samuelsson <ulf.samuelsson@atmel.com>
- */
-
-#include <command.h>
-#include <status_led.h>
-#include <vsprintf.h>
-
-struct led_tbl_s {
-	char		*string;	/* String for use in the command */
-	led_id_t	mask;		/* Mask used for calling __led_set() */
-	void		(*off)(void);	/* Optional function for turning LED off */
-	void		(*on)(void);	/* Optional function for turning LED on */
-	void		(*toggle)(void);/* Optional function for toggling LED */
-};
-
-typedef struct led_tbl_s led_tbl_t;
-
-static const led_tbl_t led_commands[] = {
-#ifdef CONFIG_LED_STATUS_GREEN
-	{ "green", CONFIG_LED_STATUS_GREEN, green_led_off, green_led_on, NULL },
-#endif
-#ifdef CONFIG_LED_STATUS_YELLOW
-	{ "yellow", CONFIG_LED_STATUS_YELLOW, yellow_led_off, yellow_led_on,
-	  NULL },
-#endif
-#ifdef CONFIG_LED_STATUS_RED
-	{ "red", CONFIG_LED_STATUS_RED, red_led_off, red_led_on, NULL },
-#endif
-#ifdef CONFIG_LED_STATUS_BLUE
-	{ "blue", CONFIG_LED_STATUS_BLUE, blue_led_off, blue_led_on, NULL },
-#endif
-	{ NULL, 0, NULL, NULL, NULL }
-};
-
-enum led_cmd { LED_ON, LED_OFF, LED_TOGGLE, LED_BLINK };
-
-enum led_cmd get_led_cmd(char *var)
-{
-	if (strcmp(var, "off") == 0)
-		return LED_OFF;
-	if (strcmp(var, "on") == 0)
-		return LED_ON;
-	if (strcmp(var, "toggle") == 0)
-		return LED_TOGGLE;
-	if (strcmp(var, "blink") == 0)
-		return LED_BLINK;
-
-	return -1;
-}
-
-/*
- * LED drivers providing a blinking LED functionality, like the
- * PCA9551, can override this empty weak function
- */
-void __weak __led_blink(led_id_t mask, int freq)
-{
-}
-
-int do_legacy_led(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	int i, match = 0;
-	enum led_cmd cmd;
-	int freq;
-
-	/* Validate arguments */
-	if ((argc < 3) || (argc > 4))
-		return CMD_RET_USAGE;
-
-	cmd = get_led_cmd(argv[2]);
-	if (cmd < 0) {
-		return CMD_RET_USAGE;
-	}
-
-	for (i = 0; led_commands[i].string; i++) {
-		if ((strcmp("all", argv[1]) == 0) ||
-		    (strcmp(led_commands[i].string, argv[1]) == 0)) {
-			match = 1;
-			switch (cmd) {
-			case LED_ON:
-				if (led_commands[i].on)
-					led_commands[i].on();
-				else
-					__led_set(led_commands[i].mask,
-							  CONFIG_LED_STATUS_ON);
-				break;
-			case LED_OFF:
-				if (led_commands[i].off)
-					led_commands[i].off();
-				else
-					__led_set(led_commands[i].mask,
-						  CONFIG_LED_STATUS_OFF);
-				break;
-			case LED_TOGGLE:
-				if (led_commands[i].toggle)
-					led_commands[i].toggle();
-				else
-					__led_toggle(led_commands[i].mask);
-				break;
-			case LED_BLINK:
-				if (argc != 4)
-					return CMD_RET_USAGE;
-
-				freq = dectoul(argv[3], NULL);
-				__led_blink(led_commands[i].mask, freq);
-			}
-			/* Need to set only 1 led if led_name wasn't 'all' */
-			if (strcmp("all", argv[1]) != 0)
-				break;
-		}
-	}
-
-	/* If we ran out of matches, print Usage */
-	if (!match) {
-		return CMD_RET_USAGE;
-	}
-
-	return 0;
-}
-
-U_BOOT_CMD(
-	led, 4, 1, do_legacy_led,
-	"["
-#ifdef CONFIG_LED_STATUS_GREEN
-	"green|"
-#endif
-#ifdef CONFIG_LED_STATUS_YELLOW
-	"yellow|"
-#endif
-#ifdef CONFIG_LED_STATUS_RED
-	"red|"
-#endif
-#ifdef CONFIG_LED_STATUS_BLUE
-	"blue|"
-#endif
-	"all] [on|off|toggle|blink] [blink-freq in ms]",
-	"[led_name] [on|off|toggle|blink] sets or clears led(s)"
-);
-- 
2.43.0

