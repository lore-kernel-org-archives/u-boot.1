Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF20C2BA1A
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 01:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D136288543;
	Thu, 20 Jun 2024 03:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kFXucMnk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7FF8884B8; Thu, 20 Jun 2024 01:04:21 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 700988840C
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 01:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4217136a74dso2982015e9.2
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 16:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718838259; x=1719443059; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1SnK722UF5gQtV5gKPMHvDpazj/jDZqxf6MafxYMW7M=;
 b=kFXucMnkXn9Mma40aKl5h1zArfJWR1luuusimuxtY1vlwqFrf1sKwPjpkkibJsafSn
 Dk3r6BtQYWph87Vf7lJ9ZWS+YkIwQHxT3VqL05vjn/gqV96+AmbyfWZdApD/LmC0i1Mx
 jvWQcdDy2g018nDM6IrmxgQ3QlxAQkK1FaqpNtC4tqNkHh0as5D1sma1W9+qWp2EdPt9
 Qt88E6mAMneOrqg6o99pNjKSe2evsSskBf51uqywvDNCJqJWh03VdEWHN/5hEZJt3dCR
 nhKqGph7FwQk1p0yhSWWjUK5qqwUH+YueQancNgPVxbjp3ZgQAZVYElvGqZqz2JoOFtn
 enOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718838259; x=1719443059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1SnK722UF5gQtV5gKPMHvDpazj/jDZqxf6MafxYMW7M=;
 b=HH6R97QgVGLa+E1FOuANZf8Ngutms+YkOiM9C6jtKY8n9oBqNslVv3Pbu4Rq9Q2o82
 MnZAVQqGFNkBouAf0WT4Xaqt4wX1U6UsjpzZxXpYc0nb4+xFU2ail5fg61ODbaBXdhrk
 +THNFZzfrhV5ivvt8eSLi68bXuz8ikceY12CLWLWdJfvW1vWFB2Rg2vwBtnUfjkvfMCs
 /kPNBMKE3A6pKNOAGnYexe1s5sClIu3gnQk/aapTZtPg63vmRu1LjfujYXXGQMpu1dwg
 6qRz+Jric5Zmbzkds9MbnZ99qyWVnNxuvJ3lv0YmyNMZSKdURCM6y9wN8fDEm2wLtCKX
 AcxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSZBjxOWlhZHFdm3ZgGuabXVz3OHD4dv2LfDO89B8qARuqb0eAiuEBv/pegs6DVwjLjslaAMHx1ZSf9zX2YOMbyE05sQ==
X-Gm-Message-State: AOJu0YypnQ0WSnBwq+XYyWW/gHz86LKJoaTHNpLi5MKnYTg90J9Mf6Ne
 fEEu090uWGuBGiYxgOYCVCEf9Xvg3E2dTNl7sR72HNAq//otKbU8
X-Google-Smtp-Source: AGHT+IFHoAfWKpRkUaw0gxQz3xJwuskMepzryQ6szBNNq4YeWEuS/okSiAI1EECO/O9TxrkS+yTGNg==
X-Received: by 2002:a05:600c:1c29:b0:421:8429:79ba with SMTP id
 5b1f17b1804b1-42475016aedmr26716925e9.0.1718838258595; 
 Wed, 19 Jun 2024 16:04:18 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4247d0c54c9sm5410465e9.27.2024.06.19.16.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 16:04:18 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Dmitry Dunaev <dunaev@tecon.ru>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v4 9/9] doc: convert README.LED to .rst documentation
Date: Thu, 20 Jun 2024 01:03:27 +0200
Message-ID: <20240619230400.8459-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619230400.8459-1-ansuelsmth@gmail.com>
References: <20240619230400.8459-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Jun 2024 03:31:55 +0200
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

Convert README.LED to .rst documentation and include all the relevant
documentation in the status_led.h.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 doc/README.LED         |  77 --------------
 doc/api/index.rst      |   1 +
 doc/api/status_led.rst |  35 +++++++
 include/status_led.h   | 224 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 256 insertions(+), 81 deletions(-)
 delete mode 100644 doc/README.LED
 create mode 100644 doc/api/status_led.rst

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
diff --git a/doc/api/index.rst b/doc/api/index.rst
index 51b2013af36..d40e90801d1 100644
--- a/doc/api/index.rst
+++ b/doc/api/index.rst
@@ -22,6 +22,7 @@ U-Boot API documentation
    rng
    sandbox
    serial
+   status_led
    sysreset
    timer
    unicode
diff --git a/doc/api/status_led.rst b/doc/api/status_led.rst
new file mode 100644
index 00000000000..44bbea47157
--- /dev/null
+++ b/doc/api/status_led.rst
@@ -0,0 +1,35 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Status LED
+==========
+
+.. kernel-doc:: include/status_led.h
+   :doc: Overview
+
+CONFIG_STATUS_LED Description
+-----------------------------
+
+.. kernel-doc:: include/status_led.h
+   :doc: CONFIG Description
+
+Special Status LED Configs
+--------------------------
+.. kernel-doc:: include/status_led.h
+   :doc: LED Status Config
+
+Colour Status LED Configs
+-------------------------
+.. kernel-doc:: include/status_led.h
+   :doc: LED Colour Config
+
+Required API
+------------
+
+.. kernel-doc:: include/status_led.h
+   :doc: Required API
+
+Status LED API
+--------------
+
+.. kernel-doc:: include/status_led.h
+   :internal:
diff --git a/include/status_led.h b/include/status_led.h
index 7de40551621..6893d1d68e0 100644
--- a/include/status_led.h
+++ b/include/status_led.h
@@ -4,18 +4,102 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-/*
- * The purpose of this code is to signal the operational status of a
+/**
+ * DOC: Overview
+ *
+ * Status LED is a Low-Level way to handle LEDs to signal state of the
+ * bootloader, for example boot progress, file transfer fail, activity
+ * of some sort like tftp transfer, mtd write/erase.
+ *
+ * The original usage these API were to signal the operational status of a
  * target which usually boots over the network; while running in
  * PCBoot, a status LED is blinking. As soon as a valid BOOTP reply
  * message has been received, the LED is turned off. The Linux
  * kernel, once it is running, will start blinking the LED again,
  * with another frequency.
+ *
+ * Status LED require support Low Level and the board to implement
+ * the specific functions to correctly works.
  */
 
 #ifndef _STATUS_LED_H_
 #define	_STATUS_LED_H_
 
+/**
+ * DOC: CONFIG Description
+ *
+ * Enable `CONFIG_LED_STATUS` to support the Status LED under
+ * > Device Drivers > LED Support.
+ *
+ * The Status LED can be defined in various ways, but most of the time,
+ * specific functions will need to be defined in the board file.
+ * If this is the case, enable `CONFIG_LED_STATUS_BOARD_SPECIFIC`.
+ *
+ * If the LEDs are GPIO-driven, you can use the GPIO wrapper driver
+ * instead of defining specific board functions.
+ * If this is the case, enable `CONFIG_LED_STATUS_GPIO`.
+ * (Note that `CONFIG_LED_STATUS_BOARD_SPECIFIC` is also required.)
+ *
+ * The Status LED allows defining up to six different LEDs, from 0 to 5,
+ * with the following configurations:
+ * `CONFIG_STATUS_LED`, `CONFIG_STATUS_LED1`, ..., `CONFIG_STATUS_LED5`.
+ *
+ * For each LED, the following options are required:
+ *  * `CONFIG_STATUS_LED_BIT<n>`
+ *  * `CONFIG_STATUS_LED_STATE<n>`
+ *  * `CONFIG_STATUS_LED_FREQ<n>`
+ *
+ * Where `<n>` is an integer from 1 through 5. (Note that LED 0 doesn't have the
+ * integer suffix.)
+ *
+ * `CONFIG_STATUS_LED_BIT` is passed into the `__led_*` functions to identify
+ * which LED is being acted on. The value is opaque, meaning it depends on how
+ * the low-level API handles this value. It can be an ID to reference the LED
+ * internally, or in the case of the GPIO wrapper, it's the GPIO number of the LED.
+ * Mapping the value to a physical LED is the responsibility of the `__led_*` function.
+ *
+ * `CONFIG_STATUS_LED_STATE` sets the initial state of the LED. It should be set
+ * to one of these values: `CONFIG_LED_STATUS_OFF` or `CONFIG_LED_STATUS_ON`.
+ *
+ * `CONFIG_STATUS_LED_FREQ` determines the LED blink frequency.
+ * Values range from 2 to 10.
+ */
+/**
+ * DOC: LED Status Config
+ *
+ * The Status LED uses two special configurations for common operations:
+ *
+ *   * CONFIG_STATUS_LED_BOOT is the LED that lights up when the board is booting.
+ *   * CONFIG_STATUS_LED_ACTIVITY is the LED that lights and blinks during activity
+ *     (e.g., file transfer, flash write).
+ *
+ * The values set in these configurations refer to the LED ID previously set.
+ *
+ * - ``CONFIG_STATUS_LED_RED=0`` will refer to the option ``CONFIG_STATUS_LED_BIT``.
+ * - ``CONFIG_STATUS_LED_RED=1`` will refer to the option ``CONFIG_STATUS_LED_BIT1``.
+ * - ``CONFIG_STATUS_LED_RED=2`` will refer to the option ``CONFIG_STATUS_LED_BIT2``.
+ * - ...
+ */
+/**
+ * DOC: LED Colour Config
+ *
+ * The Status LED exposes specific configurations for LEDs of different colors.
+ *
+ * The values set in these configurations refer to the LED ID previously set.
+ *
+ * - ``CONFIG_STATUS_LED_RED=0`` will refer to the option ``CONFIG_STATUS_LED_BIT``.
+ * - ``CONFIG_STATUS_LED_RED=1`` will refer to the option ``CONFIG_STATUS_LED_BIT1``.
+ * - ``CONFIG_STATUS_LED_RED=2`` will refer to the option ``CONFIG_STATUS_LED_BIT2``.
+ * - ...
+ *
+ * Supported colors are:
+ *   * red
+ *   * green
+ *   * yellow
+ *   * blue
+ *   * white
+ */
+
 #ifdef CONFIG_LED_STATUS
 
 #define LED_STATUS_PERIOD	(CONFIG_SYS_HZ / CONFIG_LED_STATUS_FREQ)
@@ -35,11 +119,49 @@
 #define LED_STATUS_PERIOD5	(CONFIG_SYS_HZ / CONFIG_LED_STATUS_FREQ5)
 #endif /* CONFIG_LED_STATUS5 */
 
+/**
+ * void status_led_init - Init the Status LED with all the required structs.
+ */
 void status_led_init(void);
+/**
+ * void status_led_tick - Blink each LED that is currently set in blinking
+ *   mode
+ * @timestamp: currently unused
+ */
 void status_led_tick(unsigned long timestamp);
+/**
+ * void status_led_set - Set the LED ID passed as first arg to the mode set
+ * @led: reference to the Status LED ID
+ * @state: state to set the LED to
+ *
+ * Modes for state arE:
+ *   * CONFIG_LED_STATUS_OFF (LED off)
+ *   * CONFIG_LED_STATUS_ON (LED on)
+ *   * CONFIG_LED_STATUS_BLINK (LED initially on, expected to blink)
+ */
 void status_led_set(int led, int state);
+/**
+ * void status_led_toggle - toggle the LED ID
+ * @led: reference to the Status LED ID
+ *
+ * Toggle the LED ID passed as first arg. If it's ON became OFF, if it's
+ * OFF became ON.
+ */
 void status_led_toggle(int led);
+/**
+ * void status_led_activity_start - start a LED activity
+ * @led: reference to the Status LED ID
+ *
+ * Set the Status LED ON and start the Cyclic to make the LED blink at
+ * the configured freq.
+ */
 void status_led_activity_start(int led);
+/**
+ * void status_led_activity_stop - stop a LED activity
+ * @led: reference to the Status LED ID
+ *
+ * Stop and free the Cyclic and turn the LED OFF.
+ */
 void status_led_activity_stop(int led);
 
 /*****  MVS v1  **********************************************************/
@@ -62,9 +184,61 @@ void status_led_activity_stop(int led);
 /* led_id_t is unsigned long mask */
 typedef unsigned long led_id_t;
 
+/**
+ * DOC: Required API
+ *
+ * The Status LED requires the following API functions to operate correctly
+ * and compile:
+ *
+ * - ``__led_toggle``: Low-level function to toggle the LED at the specified
+ *   mask.
+ * - ``__led_init``: Initializes the Status LED, sets up required tables, and
+ *   configures registers.
+ * - ``__led_set``: Low-level function to set the state of the LED at the
+ *   specified mask.
+ * - ``__led_blink``: Low-level function to set the LED to blink at the
+ *   specified frequency.
+ *
+ * The Status LED also provides optional functions to control colored LEDs.
+ * Each supported LED color has corresponding ``_on`` and ``_off`` functions.
+ *
+ * There is also support for ``coloured_LED_init`` for LEDs that provide
+ * multiple colors. (Currently, this is only used by ARM.)
+ *
+ * Each function is weakly defined and should be implemented in the
+ * board-specific source file. (This does not apply to the GPIO LED wrapper.)
+ */
+/**
+ * void __led_toggle - toggle LED at @mask
+ * @mask: opaque value to reference the LED
+ *
+ * Low-Level function to toggle the LED at mask.
+ */
 extern void __led_toggle (led_id_t mask);
+/**
+ * void __led_init - Init the LED at @mask
+ * @mask: opaque value to reference the LED
+ * @state: starting state of the LED
+ *
+ * Init the Status LED, init required tables, setup regs...
+ */
 extern void __led_init (led_id_t mask, int state);
+/**
+ * void __led_set - Set the LED at @mask
+ * @mask: opaque value to reference the LED
+ * @state: state to set the LED to
+ *
+ * Init the Status LED, init required tables, setup regs...
+ */
 extern void __led_set (led_id_t mask, int state);
+/**
+ * void __led_blink - Set the LED at @mask to HW blink
+ * @mask: opaque value to reference the LED
+ * @freq: freq to make the LED blink at
+ *
+ * Low-Level function to set the LED at HW blink by the
+ * passed freq.
+ */
 void __led_blink(led_id_t mask, int freq);
 #else
 # error Status LED configuration missing
@@ -77,20 +251,62 @@ void __led_blink(led_id_t mask, int freq);
 
 #endif	/* CONFIG_LED_STATUS	*/
 
-/*
- * Coloured LEDs API
+/**
+ * DOC: Coloured LED API
+ *
+ * Status LED expose optional functions to control coloured LED.
+ * Each LED color supported expose _on and _off function.
+ *
+ * There is also support for coloured_LED_init for LED that provide
+ * multiple colours. (currently only used by ARM)
+ *
+ * Each function is weakly defined and should be defined in the board
+ * specific source. (doesn't apply for GPIO LED wrapper)
  */
 #ifndef	__ASSEMBLY__
+/**
+ * void coloured_LED_init - Init multi colour LED
+ */
 void coloured_LED_init(void);
+/**
+ * void red_led_on - Turn LED Red on
+ */
 void red_led_on(void);
+/**
+ * void red_led_off - Turn LED Red off
+ */
 void red_led_off(void);
+/**
+ * void green_led_on - Turn LED Green on
+ */
 void green_led_on(void);
+/**
+ * void green_led_off - Turn LED Green off
+ */
 void green_led_off(void);
+/**
+ * void yellow_led_on - Turn LED Yellow on
+ */
 void yellow_led_on(void);
+/**
+ * void yellow_led_off - Turn LED Yellow off
+ */
 void yellow_led_off(void);
+/**
+ * void blue_led_on - Turn LED Blue on
+ */
 void blue_led_on(void);
+/**
+ * void blue_led_off - Turn LED Blue off
+ */
 void blue_led_off(void);
+/**
+ * void white_led_on - Turn LED White on
+ */
 void white_led_on(void);
+/**
+ * void white_led_off - Turn LED White off
+ */
 void white_led_off(void);
 #else
 	.extern LED_init
-- 
2.43.0

