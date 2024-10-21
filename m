Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446B9D0E6F4
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:40:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E00B188F47;
	Mon, 21 Oct 2024 13:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DomvRO3A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FF3E88F28; Mon, 21 Oct 2024 13:39:00 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DBB288EBB
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a99c0beaaa2so721802266b.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510737; x=1730115537; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JLYWrElfmbWIs3bTP8zvbtHrdKrO2wHcFKXGWJ/sL+g=;
 b=DomvRO3ABCE26U136vUpo9JS9wqwf1SI0HW+SHkymjo8xPzUSkN2bQ9CUQzfXYu3kf
 Z0KPD0DtYBVAZE4tmIbIu+E/SxuEHExe6SMyZRcJuBuF9GxXcGa0jmh/ZINRJcTnXWsQ
 LuA81KGTaQoMil0G7CzfaDaZ6o2QLcwvVZhTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510737; x=1730115537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JLYWrElfmbWIs3bTP8zvbtHrdKrO2wHcFKXGWJ/sL+g=;
 b=Al77Q09aC0/75UiMcN9Q0dsD3DB+czrdLPM5HQjfui2sxqMFOmowY+kxpdAMxzEbQR
 W6IEYUbBsfXinDHav1q8kAsNxEbPoK+gJlPtQkLqdJDBsZ0uZ+hTf2O+fLCVJjdb/sAC
 aHUQTM9tW2W58dkNCXPYs16Igza9SmW9qWMYrSPM1L36ZfPAGqUduk2S480HbK5FiCOq
 /5jWj2aTe/6NT3FuP2jGhPwDcdCRf1Gbi1o8ne3mBNsA5u5IEpi2GouYQgOJ3lzuCdjo
 HCrbvZLYKtp0kSlGkTJGIwNEPEPXiIakwZbzxndFbZ6SsspcHasFAnX4bgt+RGjvINKp
 R9Ig==
X-Gm-Message-State: AOJu0YzLabsok+afSosiUuJw39v8XEWKAQic2yU8ELNafK4vZ0+KcPma
 /TbPGC+kq7M0/k2w7zBSJBFA0MPrbOEAEYZ+edjUP1xFTfT4IbgdHnuIr1likvWQdy/T+n3vLAa
 AtYIa
X-Google-Smtp-Source: AGHT+IEGeUwOTOnmzTk8m8wKYmQvUNftKzYa0fyZvnOTVnp+VeHkmnzaY9dcIbEreqNtWGX/tds8IA==
X-Received: by 2002:a17:906:6a29:b0:a99:e504:40c5 with SMTP id
 a640c23a62f3a-a9a69bb4776mr1180204566b.39.1729510737315; 
 Mon, 21 Oct 2024 04:38:57 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:38:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Jonas Karlman <jonas@kwiboo.se>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH v2 08/25] common: doc: Drop old LED support
Date: Mon, 21 Oct 2024 13:38:16 +0200
Message-ID: <20241021113839.318572-9-sjg@chromium.org>
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

This has been replaced with a new LED framework, so drop this old code
and documentation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/board_f.c | 22 --------------
 doc/README.LED   | 77 ------------------------------------------------
 2 files changed, 99 deletions(-)
 delete mode 100644 doc/README.LED

diff --git a/common/board_f.c b/common/board_f.c
index f1bd70fdd6c..ad77d8db2d5 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -36,7 +36,6 @@
 #include <relocate.h>
 #include <serial.h>
 #include <spl.h>
-#include <status_led.h>
 #include <sysreset.h>
 #include <timer.h>
 #include <trace.h>
@@ -53,27 +52,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-/*
- * TODO(sjg@chromium.org): IMO this code should be
- * refactored to a single function, something like:
- *
- * void led_set_state(enum led_colour_t colour, int on);
- */
-/************************************************************************
- * Coloured LED functionality
- ************************************************************************
- * May be supplied by boards if desired
- */
-__weak void coloured_LED_init(void) {}
-__weak void red_led_on(void) {}
-__weak void red_led_off(void) {}
-__weak void green_led_on(void) {}
-__weak void green_led_off(void) {}
-__weak void yellow_led_on(void) {}
-__weak void yellow_led_off(void) {}
-__weak void blue_led_on(void) {}
-__weak void blue_led_off(void) {}
-
 /*
  * Why is gd allocated a register? Prior to reloc it might be better to
  * just pass it around to each function in this file?
diff --git a/doc/README.LED b/doc/README.LED
deleted file mode 100644
index c21c9d53ec3..00000000000
--- a/doc/README.LED
+++ /dev/null
@@ -1,77 +0,0 @@
-Status LED
-========================================
-
-This README describes the status LED API.
-
-The API is defined by the include file include/status_led.h
-
-The first step is to enable CONFIG_LED_STATUS in menuconfig:
-> Device Drivers > LED Support.
-
-If the LED support is only for specific board, enable
-CONFIG_LED_STATUS_BOARD_SPECIFIC in the menuconfig.
-
-Status LEDS 0 to 5 are enabled by the following configurations at menuconfig:
-CONFIG_STATUS_LED0, CONFIG_STATUS_LED1, ... CONFIG_STATUS_LED5
-
-The following should be configured for each of the enabled LEDs:
-CONFIG_STATUS_LED_BIT<n>
-CONFIG_STATUS_LED_STATE<n>
-CONFIG_STATUS_LED_FREQ<n>
-Where <n> is an integer 1 through 5 (empty for 0).
-
-CONFIG_STATUS_LED_BIT is passed into the __led_* functions to identify which LED
-is being acted on. As such, the value choose must be unique with with respect to
-the other CONFIG_STATUS_LED_BIT's. Mapping the value to a physical LED is the
-reponsiblity of the __led_* function.
-
-CONFIG_STATUS_LED_STATE is the initial state of the LED. It should be set to one
-of these values: CONFIG_LED_STATUS_OFF or CONFIG_LED_STATUS_ON.
-
-CONFIG_STATUS_LED_FREQ determines the LED blink frequency.
-Values range from 2 to 10.
-
-Some other LED macros
----------------------
-
-CONFIG_STATUS_LED_BOOT is the LED to light when the board is booting.
-This must be a valid LED number (0-5).
-
-CONFIG_STATUS_LED_RED is the red LED. It is used to signal errors. This must be
-a valid LED number (0-5). Other similar color LED's macros are
-CONFIG_STATUS_LED_GREEN, CONFIG_STATUS_LED_YELLOW and CONFIG_STATUS_LED_BLUE.
-
-General LED functions
----------------------
-The following functions should be defined:
-
-__led_init is called once to initialize the LED to CONFIG_STATUS_LED_STATE.
-One time start up code should be placed here.
-
-__led_set is called to change the state of the LED.
-
-__led_toggle is called to toggle the current state of the LED.
-
-Colour LED
-========================================
-
-Colour LED's are at present only used by ARM.
-
-The functions names explain their purpose.
-
-coloured_LED_init
-red_LED_on
-red_LED_off
-green_LED_on
-green_LED_off
-yellow_LED_on
-yellow_LED_off
-blue_LED_on
-blue_LED_off
-
-These are weakly defined in arch/arm/lib/board.c to noops. Where applicable, define
-these functions in the board specific source.
-
-TBD : Describe older board dependent macros similar to what is done for
-
-TBD : Describe general support via asm/status_led.h
-- 
2.43.0

