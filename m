Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EFBE67816
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D3B989145;
	Sun,  3 Nov 2024 01:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Co3urrx1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A26589145; Sun,  3 Nov 2024 01:35:34 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5109D8924F
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20c7edf2872so31895615ad.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594129; x=1731198929; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hojl3y2jvSmNhP3fWupBFOmaeCkHm++KHdwhJaoLDps=;
 b=Co3urrx1M5EtZyAeijEXvuEaHA3FiXtHZOb5FMFh3yPH7r0b+K3h4syLcN6QWJJ2qn
 Ja72YNS+FNVSPi3o4+cVYdGUu4DEHV0y3qdCCiH+JaBcBqdVEukoAxUPClLdQx3w91O7
 /XJO62Cy9Mf/LlFJky4rNNLD3MjbxHnW89nYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594129; x=1731198929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hojl3y2jvSmNhP3fWupBFOmaeCkHm++KHdwhJaoLDps=;
 b=FOXEU+BnJD6Rex1k8LtgXFXVfXflyedB0WqRQ0qC4sEGeYwcpbXqAqFr0Z1qONdZiO
 TRDY01/OAx6w1LoLktQcooRz48sAAYSddTdMjN/z5V+GUwtRajbPty2l32dXacq1Bm+m
 kIhx5g2ffJhVONxdAU4/CU82qLIO5xKJytLueSD2U+n14NT7NJZQiYjQXIRSbVPoFQDE
 17pmMyyST7iu0gUWwJK7TaPJ/GIw2FB9YQiVZ2xnqZEE1AvUcqMDZ0vDRtiXta2Ndew+
 MjzTXdKz2aHM35TEaMvaiAb56jaWXEnaZc+mLVo8lXg44oQSV/wMwFBC8oY1RLpfLDMo
 rE2g==
X-Gm-Message-State: AOJu0YzMF1RfLaxFBnXf7nm3WNYtJtz9ZZ6PLhdDcKSQVX53FVegI8qp
 gmbR9iLthpewfQLVJAHX0Ioa6i61suGY7dyB4XCCzfsnmjupj3ksbQ/kiToPHIO7GYtRiLzuTnb
 g0g==
X-Google-Smtp-Source: AGHT+IHfae2azD6RPC3PhJBIU9S1WfTSTP6ZiKnQyDWSPwqNGbca3irWXukqEsxXFapHrIrwP+tOGA==
X-Received: by 2002:a17:902:fc85:b0:211:3363:8c8d with SMTP id
 d9443c01a7336-21133638d85mr59609875ad.20.1730594129222; 
 Sat, 02 Nov 2024 17:35:29 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:35:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH v3 07/25] common: doc: Drop old LED support
Date: Sat,  2 Nov 2024 18:32:59 -0600
Message-ID: <20241103003322.626036-8-sjg@chromium.org>
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
index 98dc2591e1d..b110a15278b 100644
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

