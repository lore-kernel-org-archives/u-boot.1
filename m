Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6332CF396B
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 17:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C38E983FF4;
	Wed, 19 Nov 2025 18:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7A684013; Wed, 19 Nov 2025 18:01:29 +0100 (CET)
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::190e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3164C83FF4
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 18:01:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dBSS05tFFzsyl;
 Wed, 19 Nov 2025 18:01:20 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dBSS00rHYzFt3; Wed, 19 Nov 2025 18:01:20 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 19 Nov 2025 18:01:13 +0100
Subject: [PATCH 2/4] led: remove support for green status led in legacy API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-corvus-led-red-green-v1-2-ce86b8d59dfc@cherry.de>
References: <20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de>
In-Reply-To: <20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jesse Taube <mr.bossman075@gmail.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, Fabio Estevam <festevam@gmail.com>, 
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

The last user of it was removed in a previous commit so let's remove its
support entirely.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 cmd/legacy_led.c        |  6 ------
 common/board_f.c        |  2 --
 doc/api/led.rst         |  5 +----
 drivers/led/Kconfig     | 14 --------------
 drivers/misc/gpio_led.c | 12 ------------
 include/status_led.h    |  4 ----
 6 files changed, 1 insertion(+), 42 deletions(-)

diff --git a/cmd/legacy_led.c b/cmd/legacy_led.c
index 609a4b08e0a..2c6d606f48b 100644
--- a/cmd/legacy_led.c
+++ b/cmd/legacy_led.c
@@ -45,9 +45,6 @@ static const led_tbl_t led_commands[] = {
 	{ "5", CONFIG_LED_STATUS_BIT5, NULL, NULL, NULL },
 #endif
 #endif
-#ifdef CONFIG_LED_STATUS_GREEN
-	{ "green", CONFIG_LED_STATUS_GREEN, green_led_off, green_led_on, NULL },
-#endif
 #ifdef CONFIG_LED_STATUS_RED
 	{ "red", CONFIG_LED_STATUS_RED, red_led_off, red_led_on, NULL },
 #endif
@@ -162,9 +159,6 @@ U_BOOT_CMD(
 	"5|"
 #endif
 #endif
-#ifdef CONFIG_LED_STATUS_GREEN
-	"green|"
-#endif
 #ifdef CONFIG_LED_STATUS_RED
 	"red|"
 #endif
diff --git a/common/board_f.c b/common/board_f.c
index 224cc0ac561..74571cb6d91 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -67,8 +67,6 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 __weak void red_led_on(void) {}
 __weak void red_led_off(void) {}
-__weak void green_led_on(void) {}
-__weak void green_led_off(void) {}
 
 /*
  * Why is gd allocated a register? Prior to reloc it might be better to
diff --git a/doc/api/led.rst b/doc/api/led.rst
index c7fe56f3d89..e9705eb69a5 100644
--- a/doc/api/led.rst
+++ b/doc/api/led.rst
@@ -58,8 +58,7 @@ CONFIG_STATUS_LED_BOOT is the LED to light when the board is booting.
 This must be a valid LED number (0-5).
 
 CONFIG_STATUS_LED_RED is the red LED. It is used to signal errors. This must be
-a valid LED number (0-5). Other similar color LED's macros are
-CONFIG_STATUS_LED_GREEN.
+a valid LED number (0-5).
 
 General LED functions
 ~~~~~~~~~~~~~~~~~~~~~
@@ -81,8 +80,6 @@ The functions names explain their purpose.
 
 - red_LED_on
 - red_LED_off
-- green_LED_on
-- green_LED_off
 
 These are weakly defined in arch/arm/lib/board.c to noops. Where applicable, define
 these functions in the board specific source.
diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 1077792efb0..6b043f9a522 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -414,20 +414,6 @@ config LED_STATUS_RED
 
 endif # LED_STATUS_RED_ENABLE
 
-config LED_STATUS_GREEN_ENABLE
-	bool "Enable green LED"
-	help
-	  Enable green status LED.
-
-if LED_STATUS_GREEN_ENABLE
-
-config LED_STATUS_GREEN
-	int "Green LED identification"
-	help
-	  Valid enabled LED device number (0-5).
-
-endif # LED_STATUS_GREEN_ENABLE
-
 config LED_STATUS_CMD
 	bool "Enable status LED commands"
 
diff --git a/drivers/misc/gpio_led.c b/drivers/misc/gpio_led.c
index e806b1f241f..a1432a53440 100644
--- a/drivers/misc/gpio_led.c
+++ b/drivers/misc/gpio_led.c
@@ -67,16 +67,4 @@ void red_led_off(void)
 }
 #endif
 
-#ifdef CONFIG_LED_STATUS_GREEN
-void green_led_on(void)
-{
-	__led_set(CONFIG_LED_STATUS_GREEN, CONFIG_LED_STATUS_ON);
-}
-
-void green_led_off(void)
-{
-	__led_set(CONFIG_LED_STATUS_GREEN, CONFIG_LED_STATUS_OFF);
-}
-#endif
-
 #endif /* CONFIG_GPIO_LED_STUBS */
diff --git a/include/status_led.h b/include/status_led.h
index 85e583f18c8..8e8b19f8c19 100644
--- a/include/status_led.h
+++ b/include/status_led.h
@@ -72,13 +72,9 @@ static inline void status_led_boot_blink(void) { }
 #ifndef	__ASSEMBLY__
 void red_led_on(void);
 void red_led_off(void);
-void green_led_on(void);
-void green_led_off(void);
 #else
 	.extern red_led_on
 	.extern red_led_off
-	.extern green_led_on
-	.extern green_led_off
 #endif
 
 #endif	/* _STATUS_LED_H_	*/

-- 
2.51.1

