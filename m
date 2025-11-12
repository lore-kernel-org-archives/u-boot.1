Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F446CD3435
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 17:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45AC883D3C;
	Wed, 12 Nov 2025 18:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 286A883D03; Wed, 12 Nov 2025 18:48:46 +0100 (CET)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc09])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 999A483D03
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 18:48:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d69qv2hntz9L4;
 Wed, 12 Nov 2025 18:48:43 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d69qt334HzqZc; Wed, 12 Nov 2025 18:48:42 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 12 Nov 2025 18:48:07 +0100
Subject: [PATCH 02/11] doc: move legacy API documented in README.LED to
 doc/api/led.rst
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-led-old-dt-v1-2-2892d49517db@cherry.de>
References: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
In-Reply-To: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
To: Ziping Chen <techping.chan@gmail.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Klaus Goger <klaus.goger@cherry.de>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Durai Manickam KR <durai.manickamkr@microchip.com>, 
 Stefan Roese <sr@denx.de>, Zixun LI <admin@hifiphile.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

This moves the content of the legacy LED API from doc/READ.LED to
doc/api/led.rst, applying minimal cosmetic changes to "nicely" integrate
it with the current docs and adding a small introduction to the legacy
API section.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/README.LED  | 77 -------------------------------------------------
 doc/api/led.rst | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 78 deletions(-)

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
diff --git a/doc/api/led.rst b/doc/api/led.rst
index e52e350d1bb..661d1379620 100644
--- a/doc/api/led.rst
+++ b/doc/api/led.rst
@@ -7,4 +7,91 @@ LED
    :doc: Overview
 
 .. kernel-doc:: include/led.h
-   :internal:
\ No newline at end of file
+   :internal:
+
+Legacy LED
+==========
+
+Please use the new LED API as defined above. This section is only for reference
+for currently supported devices and to aid for migration to the new API.
+
+Status LED
+----------
+
+This README describes the status LED API.
+
+The API is defined by the include file include/status_led.h
+
+The first step is to enable CONFIG_LED_STATUS in menuconfig::
+
+   > Device Drivers > LED Support.
+
+If the LED support is only for specific board, enable
+CONFIG_LED_STATUS_BOARD_SPECIFIC in the menuconfig.
+
+Status LEDS 0 to 5 are enabled by the following configurations at menuconfig:
+CONFIG_STATUS_LED0, CONFIG_STATUS_LED1, ... CONFIG_STATUS_LED5
+
+The following should be configured for each of the enabled LEDs:
+
+- CONFIG_STATUS_LED_BIT<n>
+- CONFIG_STATUS_LED_STATE<n>
+- CONFIG_STATUS_LED_FREQ<n>
+
+Where <n> is an integer 1 through 5 (empty for 0).
+
+CONFIG_STATUS_LED_BIT is passed into the __led_* functions to identify which LED
+is being acted on. As such, the value choose must be unique with with respect to
+the other CONFIG_STATUS_LED_BIT's. Mapping the value to a physical LED is the
+reponsiblity of the __led_* function.
+
+CONFIG_STATUS_LED_STATE is the initial state of the LED. It should be set to one
+of these values: CONFIG_LED_STATUS_OFF or CONFIG_LED_STATUS_ON.
+
+CONFIG_STATUS_LED_FREQ determines the LED blink frequency.
+Values range from 2 to 10.
+
+Some other LED macros
+~~~~~~~~~~~~~~~~~~~~~
+
+CONFIG_STATUS_LED_BOOT is the LED to light when the board is booting.
+This must be a valid LED number (0-5).
+
+CONFIG_STATUS_LED_RED is the red LED. It is used to signal errors. This must be
+a valid LED number (0-5). Other similar color LED's macros are
+CONFIG_STATUS_LED_GREEN, CONFIG_STATUS_LED_YELLOW and CONFIG_STATUS_LED_BLUE.
+
+General LED functions
+~~~~~~~~~~~~~~~~~~~~~
+The following functions should be defined:
+
+__led_init is called once to initialize the LED to CONFIG_STATUS_LED_STATE.
+One time start up code should be placed here.
+
+__led_set is called to change the state of the LED.
+
+__led_toggle is called to toggle the current state of the LED.
+
+Colour LED
+----------
+
+Colour LED's are at present only used by ARM.
+
+The functions names explain their purpose.
+
+- coloured_LED_init
+- red_LED_on
+- red_LED_off
+- green_LED_on
+- green_LED_off
+- yellow_LED_on
+- yellow_LED_off
+- blue_LED_on
+- blue_LED_off
+
+These are weakly defined in arch/arm/lib/board.c to noops. Where applicable, define
+these functions in the board specific source.
+
+TBD : Describe older board dependent macros similar to what is done for
+
+TBD : Describe general support via asm/status_led.h

-- 
2.51.1

