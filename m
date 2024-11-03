Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2BCE67819
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:39:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68E6B89321;
	Sun,  3 Nov 2024 01:39:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CSSCohUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD2A18931D; Sun,  3 Nov 2024 01:39:08 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77DC4890F8
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20ca1b6a80aso31742095ad.2
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594338; x=1731199138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y5QzRroI1fxjLrWf6GjSGLuOW6AEQb7cP0NT8mrh40o=;
 b=CSSCohUG02PP+XGI3qoAjMldK0KWXNo/Y3JnpDtoI9f173iYz8qz4ehcdGlTSr7uYw
 opOKHJ+oNDPzrc4SgfYDMJJAGrB1jQpqbt8gzXdKUL+fapb0repaF1aP8V3mdoUf+42O
 VdVNfV+dgBzfElNL+ptbvEYK2SpR7YO2sju4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594338; x=1731199138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y5QzRroI1fxjLrWf6GjSGLuOW6AEQb7cP0NT8mrh40o=;
 b=MNomm0Ew77dJD1R7WX9wUF1Sgpn50eWlWen5EiQrlq3Ve4LyJAXJSYGKbGpXnnVE6l
 3K53PiO77RVXZFa2mpXMZpppdjEbfFUkOwdZxG2Pt7DknZF3WdoXf9rad5g5971xBy2B
 nkR33/lR/XGJ+XWHx339Jq6JVCfKz2uwwZEV+22aCr004jFBw4t8IVm2l7XlRecQiweK
 /x39O1cx5j6M78kVyRY/Vrdei7jAYV5XdZAhaoj+cMtPCfBPnBf+vvf8Wl/8oEhR14MF
 Ak+zoGYbW4S98kklEI6LOeXYTYbwH5Z71mYtcAkrI92QeQCOg3bi1q39VJqQFwOD0hvG
 KwNQ==
X-Gm-Message-State: AOJu0Yx9vxRVffZ3ssOddNK7vB14SI6rAgR1UNXQhH3febK95RvTdmZ8
 jZ7ak6tGMWGySfJJoQo3vTOtjM25/clpmLb3bvH+PirNOLF5OkMiGMmEgzKX5vn8XO4PVG2OX6L
 PXg==
X-Google-Smtp-Source: AGHT+IESmWOc/AEjLThSfhiy81Q4t/tFzT7zJmER8JItM3zrp4pw0G71uh+ytK+yCz4xr6z3wQLwmQ==
X-Received: by 2002:a17:902:d2d0:b0:20c:ca83:31c7 with SMTP id
 d9443c01a7336-2111b00fe2emr121284215ad.54.1730594338430; 
 Sat, 02 Nov 2024 17:38:58 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:38:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 24/25] led: Drop status_led header file
Date: Sat,  2 Nov 2024 18:33:16 -0600
Message-ID: <20241103003322.626036-25-sjg@chromium.org>
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

This is not needed anymore. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/status_led.h | 104 -------------------------------------------
 1 file changed, 104 deletions(-)
 delete mode 100644 include/status_led.h

diff --git a/include/status_led.h b/include/status_led.h
deleted file mode 100644
index 59cf9f89956..00000000000
--- a/include/status_led.h
+++ /dev/null
@@ -1,104 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2000-2004
- * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
- */
-
-/*
- * The purpose of this code is to signal the operational status of a
- * target which usually boots over the network; while running in
- * PCBoot, a status LED is blinking. As soon as a valid BOOTP reply
- * message has been received, the LED is turned off. The Linux
- * kernel, once it is running, will start blinking the LED again,
- * with another frequency.
- */
-
-#ifndef _STATUS_LED_H_
-#define	_STATUS_LED_H_
-
-#ifdef CONFIG_LED_STATUS
-
-#define LED_STATUS_PERIOD	(CONFIG_SYS_HZ / CONFIG_LED_STATUS_FREQ)
-#ifdef CONFIG_LED_STATUS1
-#define LED_STATUS_PERIOD1	(CONFIG_SYS_HZ / CONFIG_LED_STATUS_FREQ1)
-#endif /* CONFIG_LED_STATUS1 */
-#ifdef CONFIG_LED_STATUS2
-#define LED_STATUS_PERIOD2	(CONFIG_SYS_HZ / CONFIG_LED_STATUS_FREQ2)
-#endif /* CONFIG_LED_STATUS2 */
-#ifdef CONFIG_LED_STATUS3
-#define LED_STATUS_PERIOD3	(CONFIG_SYS_HZ / CONFIG_LED_STATUS_FREQ3)
-#endif /* CONFIG_LED_STATUS3 */
-#ifdef CONFIG_LED_STATUS4
-#define LED_STATUS_PERIOD4	(CONFIG_SYS_HZ / CONFIG_LED_STATUS_FREQ4)
-#endif /* CONFIG_LED_STATUS4 */
-#ifdef CONFIG_LED_STATUS5
-#define LED_STATUS_PERIOD5	(CONFIG_SYS_HZ / CONFIG_LED_STATUS_FREQ5)
-#endif /* CONFIG_LED_STATUS5 */
-
-void status_led_init(void);
-void status_led_tick(unsigned long timestamp);
-void status_led_set(int led, int state);
-
-static inline void status_led_boot_blink(void)
-{
-#ifdef CONFIG_LED_STATUS_BOOT_ENABLE
-	status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_BLINKING);
-#endif
-}
-
-/*****  MVS v1  **********************************************************/
-#if (defined(CONFIG_MVS) && CONFIG_MVS < 2)
-# define STATUS_LED_PAR		im_ioport.iop_pdpar
-# define STATUS_LED_DIR		im_ioport.iop_pddir
-# undef  STATUS_LED_ODR
-# define STATUS_LED_DAT		im_ioport.iop_pddat
-
-# define STATUS_LED_ACTIVE	1		/* LED on for bit == 1	*/
-
-/*****  Someone else defines these  *************************************/
-#elif defined(STATUS_LED_PAR)
-  /*
-   * ADVICE: Define in your board configuration file rather than
-   * filling this file up with lots of custom board stuff.
-   */
-#else
-# error Status LED configuration missing
-#endif
-/************************************************************************/
-
-#include <asm/status_led.h>
-
-#else
-
-static inline void status_led_init(void) { }
-static inline void status_led_set(int led, int state) { }
-static inline void status_led_boot_blink(void) { }
-
-#endif	/* CONFIG_LED_STATUS	*/
-
-/*
- * Coloured LEDs API
- */
-#ifndef	__ASSEMBLY__
-void coloured_LED_init(void);
-void red_led_on(void);
-void red_led_off(void);
-void green_led_on(void);
-void green_led_off(void);
-void yellow_led_on(void);
-void yellow_led_off(void);
-void blue_led_on(void);
-void blue_led_off(void);
-#else
-	.extern LED_init
-	.extern red_led_on
-	.extern red_led_off
-	.extern yellow_led_on
-	.extern yellow_led_off
-	.extern green_led_on
-	.extern green_led_off
-	.extern blue_led_on
-	.extern blue_led_off
-#endif
-
-#endif	/* _STATUS_LED_H_	*/
-- 
2.43.0

