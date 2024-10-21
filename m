Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D79BD0E6F7
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C1F88FBB;
	Mon, 21 Oct 2024 13:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PXGaJB6q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0B7188F50; Mon, 21 Oct 2024 13:39:04 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F2BF88F66
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-539ebb5a20aso4409380e87.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510741; x=1730115541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=12K/HX9vAo/xCmT5NgdHo9rJm1fwdOXidvltIFCLCqM=;
 b=PXGaJB6qlxSdwI3+72WQ3EZU0uYPjP0u+UpxMHz5BcYwUq9dd37tgNpg2gONwkm11q
 fxwd/XRHKWtj9J35WU3zql08thPmEqBqK/gKAt8zAyP9NsmO2H2DCCD6N8dVzjw9Aa0N
 I9Zd45Z/bH8xZ/OAPpESXhDaGj6xEc2zadklQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510741; x=1730115541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=12K/HX9vAo/xCmT5NgdHo9rJm1fwdOXidvltIFCLCqM=;
 b=aPaONbvU49rYCoMjHYc+5JteVjD6Vv3M7PEVhmbwP5O3mIqOeyhtHGMB8o6BaJGtJ7
 kEKfuap/DuJA9b/3IJSCTG3QD6JdknFoaU3NtZ2z+SQ0oUF6g1i7ZaN54ary6KxlUtFj
 RiMz91xFNaCvk/J6YJApRSXSQbNjbiNRK+4CrJoUDsDikBFh8mu1EXmls0D5UzeZk8+t
 9IMqM27BhMLK8HHHxDf7BzGStsz+8ZJwkVWGNGXIL+mZhTHYmhECwkDvjUm9TQvZCVX7
 MfscvqcNnA7WNVvtiHUg7U86g38nGe9JwZn4KmMH9Mi7WDNU11cVmRpAGMqPazOKWiYG
 q6mQ==
X-Gm-Message-State: AOJu0YykX4vG6pyaj2WlRYt1LltqIw12hwXh3YvOAH/RKw7E1l252UIz
 YZm+Co7QHj0iQwcON8ZIRbvVkRdQMEiQjVXrICe3JhUK/7uHJqmH4rKxsXxfglmPnv135BMxVbB
 ckBBc
X-Google-Smtp-Source: AGHT+IG/SpoHNoX3yu+9zWpIhnx7Jf4oQyrapIt1lgzfYRO/dPcvLwyMmpXyGdAs3IDbfAshnBJfJA==
X-Received: by 2002:a05:6512:318e:b0:533:d3e:16fe with SMTP id
 2adb3069b0e04-53a154f9025mr4839160e87.38.1729510740987; 
 Mon, 21 Oct 2024 04:39:00 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:39:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 12/25] led: Drop the legacy LED command
Date: Mon, 21 Oct 2024 13:38:20 +0200
Message-ID: <20241021113839.318572-13-sjg@chromium.org>
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

This is not used by any board. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/Makefile     |   1 -
 cmd/legacy_led.c | 145 -----------------------------------------------
 2 files changed, 146 deletions(-)
 delete mode 100644 cmd/legacy_led.c

diff --git a/cmd/Makefile b/cmd/Makefile
index 3c5bd56e912..b7574356b6e 100644
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

