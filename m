Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A80EE67819
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1B9E89157;
	Sun,  3 Nov 2024 01:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PjHOjMbl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A19889145; Sun,  3 Nov 2024 01:36:17 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7378D892ED
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7ee020ec76dso2665121a12.3
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594171; x=1731198971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=thpjTUOyhnWd/nVJlybJ+mXy6F74da8sVLfOMNC+AKc=;
 b=PjHOjMblPkHDiY8IkBaTiHeZbokZwixPrut+w8P0ajLUHHVDWf4YhzU/18pFc5QGBb
 HE9HonPMK8DHugSu1RM2ALvRj58brUINVyPMTTXKkjYMuJIJRu1C9wJfId70e9XfIU80
 HhJma8soweZ/oQbJnQpVIfuwJQXhNUhFWOeGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594171; x=1731198971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=thpjTUOyhnWd/nVJlybJ+mXy6F74da8sVLfOMNC+AKc=;
 b=vkai3zgp27ggHX1uVwJhmzeU+YcPIORYxUs418Ub+zoMt8dSvCgrvW7yLZaMN62Z75
 jFlEyFMg3MVYoBIitC4EZNqZfiMWloP4oJWGQD72tIYQT1jt3hvjyXHcOPzdkF7kB4Li
 UGJVAABUlaBxRmyOf/I94+oDSdaPXTRLfXbqMcH9eL4mqcrWeivY8J/lw5W/XWUBKTUy
 ceTlXvEvgdxz/joYUhiF8XQa95FEgNie+u92/4GXuDkYwMuW6v6Eh/fbTnvZjqa8rpZ0
 iEftu4w/2gPj6UGv2oANQudt0sLpblfXeKOuNeGDlE+pjVDd/37r/lPQJCCdD5Ivczb2
 OJog==
X-Gm-Message-State: AOJu0YxSTXqXZ+gYv9jz1Bd+cRTL3NrYf/0426lfTHWCw6zrcUKfFogp
 4b7lsa4i0mtuMI2UU8x8KQ7am6Zs0aFnsJMCc+AFe5Ske2nw9eC1+wkbd3Su6sFbPV+uLRec47O
 /JQ==
X-Google-Smtp-Source: AGHT+IGrdfag2sHXPfrK635W8WkXKHHCd9qdsZkifzJUNvtqUJsV8OwDvrGv0FUtY5JY3tIthAMMDA==
X-Received: by 2002:a17:902:e890:b0:20c:8abc:733a with SMTP id
 d9443c01a7336-210c6ca8b77mr384551575ad.53.1730594171201; 
 Sat, 02 Nov 2024 17:36:11 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:36:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v3 11/25] led: Drop the legacy LED command
Date: Sat,  2 Nov 2024 18:33:03 -0600
Message-ID: <20241103003322.626036-12-sjg@chromium.org>
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

This is not used by any board. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/Makefile     |   1 -
 cmd/legacy_led.c | 145 -----------------------------------------------
 2 files changed, 146 deletions(-)
 delete mode 100644 cmd/legacy_led.c

diff --git a/cmd/Makefile b/cmd/Makefile
index d1f369deec0..6052c1dd096 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -101,7 +101,6 @@ obj-$(CONFIG_CMD_IRQ) += irq.o
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

