Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B47CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72C0F88E66;
	Thu, 26 Sep 2024 22:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g057LfzP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 833EC88E70; Thu, 26 Sep 2024 22:54:26 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0093088E58
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-458362e898aso8963791cf.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727384062; x=1727988862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OiGuOtz+2Qb7TAfX4QqF1seWifOLAN0h7K6MhW9cXY=;
 b=g057LfzP3XZE4TSOoui4qW0Hki6IhMZTU0e9amYzIgpTLyVLVgMzUDc2IXdVMxxGPh
 EfZvIszx/Vs5z3p/iG2FmYheo7utmLs0ibL9llVOxCCTAHmKS342BBrb3eJKMcE10V6v
 wP5ASaz4JoYap+xwzpUhmZEHNoHAvj186sRE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727384062; x=1727988862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9OiGuOtz+2Qb7TAfX4QqF1seWifOLAN0h7K6MhW9cXY=;
 b=YYHbSSqR5u99GGHULiQst5hXlTK/getC/sbwzXAG836JhGNmUImMuoaQ0odGrJuyus
 TV6do5ZEy3LgR9YOmLLk4662ai4TGz/+/LO4bo4dr17flc7pJC3MSh330M5V2fjv0e5W
 mR7GykBdRKNJQ5IvOyna3YkzWkfjpElIh0Fdmbr0n7FYIhzbzqC8Va5HkAj3A/OD0pDD
 dEIoVI7yqDZRiwVj9ZG12JL4bOvpYw3zgcw06qXeXdvCzMKdabtYP3WrsN5rIB45Lnnw
 1S+Jbt7KIMjn2cKu9jFlvZ4ALDVQihoKFUEi+D56fzh8VZf7Tc+9er46PGh86vqswcBG
 8wOw==
X-Gm-Message-State: AOJu0Yz+3SqaTReazZPdfJr4pzht190uiiXoDgWY5N4dmKOigX/9gRzK
 NCOesBCeWLiUzgzrXPK2XkeHZN2Y0anwUy1WBr2bvdd3Mnjf7HObWHQK1U1Bsu2qRM5MQhS1p4D
 W7IukdwQ=
X-Google-Smtp-Source: AGHT+IEYjjMu0BDw6+CpfGNBv3o3TkpeHHlpLQOXwJ5tAh0rTPaV+O6cqIw7qi5+aTjtCUEdKXZDsQ==
X-Received: by 2002:a05:6214:438a:b0:6c5:7fa3:c40c with SMTP id
 6a1803df08f44-6cb3b62cb24mr10905056d6.33.1727384061690; 
 Thu, 26 Sep 2024 13:54:21 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:54:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 27/27] led: Drop status_led header file
Date: Thu, 26 Sep 2024 22:44:47 +0200
Message-ID: <20240926204455.963584-28-sjg@chromium.org>
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

This is not needed anymore. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/status_led.h | 91 --------------------------------------------
 1 file changed, 91 deletions(-)
 delete mode 100644 include/status_led.h

diff --git a/include/status_led.h b/include/status_led.h
deleted file mode 100644
index 3d118af0d8b..00000000000
--- a/include/status_led.h
+++ /dev/null
@@ -1,91 +0,0 @@
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

