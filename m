Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66500D0E6F4
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:42:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E096289330;
	Mon, 21 Oct 2024 13:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bQ6p3Z12";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 418C2892F0; Mon, 21 Oct 2024 13:39:19 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D95E3892F4
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:39:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c9428152c0so5903410a12.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510754; x=1730115554; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/WV6CutUSqozIMr8BS1YJ4/FhiZl4qibYcqTPOhEmrs=;
 b=bQ6p3Z12goiJeXR5kBLlupsxOsH44cmEbGpXrLSa95Itqbv81HpHpQd89lsiP1W4g4
 1yieAoYpUi5Q3beB5Wr7OxIt7oLERjSJslVOE/xhXyyJYgF/iq0i0HXXF2dwhL5xY8X9
 0YX+WSo8aa/6F1qkRnZMAmNtAUj8QnOrPdM/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510754; x=1730115554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/WV6CutUSqozIMr8BS1YJ4/FhiZl4qibYcqTPOhEmrs=;
 b=YmHILJvkSaS1l/iRke2EwNI1APLOwyggY8Ag0AmcyiJARw6NIJ5e6kUzJbNFrE/nTh
 EwZn9ZdryChttj+/kI0EM4cNHWSG+uyrsKCT1EQpN+HcZ01mfVve/wliofVre55EGxZu
 OZFdtFiju0k/VqbOYmLBJze07EFb4gR4ff1LsaNRoq0SoDcoI8pxIYb+8T1062kcuri4
 qfzjE4TbWwqBgt1i5ljCFGupQ85Skk9Li4VoSulT2INsw8rWZH0LKnSca9NYHLbgzL9A
 8CLBtbo8XHZHf+Ax17jFDUNJJkZgeBfe3g3vn45BIfiKtUWZnse7FYHYYhJcmBblW903
 wWrg==
X-Gm-Message-State: AOJu0YxKfKbBc/en1O1P/JS+acTyN8jB5KFuYrTPYoJ/ffI9f48PKKLv
 AtNuhYcAHRBmAk0sI/5gNDjQutxyOOAg8c38ChnAIPxLUTd969VML18fusBOXJb5m3qVi0Paz+Z
 ced1O
X-Google-Smtp-Source: AGHT+IGw4pYFF2Gg/dFudE4wbb0/h2SKIcvQyYvoIQLpKsObf1EMTwEL9e2NMQhx7TqtTk8r/Sz1rA==
X-Received: by 2002:a17:907:cc87:b0:a9a:7f37:2b62 with SMTP id
 a640c23a62f3a-a9a7f372b7cmr544160366b.49.1729510753719; 
 Mon, 21 Oct 2024 04:39:13 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:39:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 25/25] led: Drop status_led header file
Date: Mon, 21 Oct 2024 13:38:33 +0200
Message-ID: <20241021113839.318572-26-sjg@chromium.org>
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

This is not needed anymore. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Enable LED on the 5 affected platforms
- Reorder patches for bisectability

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

