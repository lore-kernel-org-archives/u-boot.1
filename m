Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75572CF3959
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 16:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6108D83F20;
	Wed, 19 Nov 2025 17:44:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DB5A83F42; Wed, 19 Nov 2025 17:44:22 +0100 (CET)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [84.16.66.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 864B7835C6
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 17:44:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dBS4L1slBzl2G;
 Wed, 19 Nov 2025 17:44:18 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dBS4K19D2zByR; Wed, 19 Nov 2025 17:44:17 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 19 Nov 2025 17:43:46 +0100
Subject: [PATCH 2/5] led: remove coloured_LED_init, yellow and blue status
 LEDs in legacy API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-legacy-led-unused-code-v1-2-bc0ae1235baa@cherry.de>
References: <20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de>
In-Reply-To: <20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de>
To: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Alexander Graf <agraf@csgraf.de>, Peter Robinson <pbrobinson@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Weijie Gao <hackpascal@gmail.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, Mario Six <mario.six@gdsys.cc>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>, 
 Sinan Akman <sinan@writeme.com>, Jesse Taube <mr.bossman075@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
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

The last user of coloured_LED_init has been recently removed, so we can
remove all places it's called and defined as it does nothing now.

Nobody makes use of the yellow and blue status LEDs from the legacy API,
so let's remove all references to it.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/lib/crt0.S     |  1 -
 cmd/legacy_led.c        | 13 -------------
 common/board_f.c        |  5 -----
 doc/api/led.rst         |  7 +------
 drivers/led/Kconfig     | 28 ----------------------------
 drivers/misc/gpio_led.c | 24 ------------------------
 include/status_led.h    | 10 ----------
 7 files changed, 1 insertion(+), 87 deletions(-)

diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
index 3e11fadafc6..9acaf2cddef 100644
--- a/arch/arm/lib/crt0.S
+++ b/arch/arm/lib/crt0.S
@@ -184,7 +184,6 @@ here:
 # endif
 
 #if ! defined(CONFIG_XPL_BUILD)
-	bl coloured_LED_init
 	bl red_led_on
 #endif
 	/* call board_init_r(gd_t *id, ulong dest_addr) */
diff --git a/cmd/legacy_led.c b/cmd/legacy_led.c
index db312ae6e2d..609a4b08e0a 100644
--- a/cmd/legacy_led.c
+++ b/cmd/legacy_led.c
@@ -48,15 +48,8 @@ static const led_tbl_t led_commands[] = {
 #ifdef CONFIG_LED_STATUS_GREEN
 	{ "green", CONFIG_LED_STATUS_GREEN, green_led_off, green_led_on, NULL },
 #endif
-#ifdef CONFIG_LED_STATUS_YELLOW
-	{ "yellow", CONFIG_LED_STATUS_YELLOW, yellow_led_off, yellow_led_on,
-	  NULL },
-#endif
 #ifdef CONFIG_LED_STATUS_RED
 	{ "red", CONFIG_LED_STATUS_RED, red_led_off, red_led_on, NULL },
-#endif
-#ifdef CONFIG_LED_STATUS_BLUE
-	{ "blue", CONFIG_LED_STATUS_BLUE, blue_led_off, blue_led_on, NULL },
 #endif
 	{ NULL, 0, NULL, NULL, NULL }
 };
@@ -172,14 +165,8 @@ U_BOOT_CMD(
 #ifdef CONFIG_LED_STATUS_GREEN
 	"green|"
 #endif
-#ifdef CONFIG_LED_STATUS_YELLOW
-	"yellow|"
-#endif
 #ifdef CONFIG_LED_STATUS_RED
 	"red|"
-#endif
-#ifdef CONFIG_LED_STATUS_BLUE
-	"blue|"
 #endif
 	"all] [on|off|toggle|blink] [blink-freq in ms]",
 	"[led_name] [on|off|toggle|blink] sets or clears led(s)"
diff --git a/common/board_f.c b/common/board_f.c
index c8a612d6070..224cc0ac561 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -65,15 +65,10 @@ DECLARE_GLOBAL_DATA_PTR;
  ************************************************************************
  * May be supplied by boards if desired
  */
-__weak void coloured_LED_init(void) {}
 __weak void red_led_on(void) {}
 __weak void red_led_off(void) {}
 __weak void green_led_on(void) {}
 __weak void green_led_off(void) {}
-__weak void yellow_led_on(void) {}
-__weak void yellow_led_off(void) {}
-__weak void blue_led_on(void) {}
-__weak void blue_led_off(void) {}
 
 /*
  * Why is gd allocated a register? Prior to reloc it might be better to
diff --git a/doc/api/led.rst b/doc/api/led.rst
index 661d1379620..c7fe56f3d89 100644
--- a/doc/api/led.rst
+++ b/doc/api/led.rst
@@ -59,7 +59,7 @@ This must be a valid LED number (0-5).
 
 CONFIG_STATUS_LED_RED is the red LED. It is used to signal errors. This must be
 a valid LED number (0-5). Other similar color LED's macros are
-CONFIG_STATUS_LED_GREEN, CONFIG_STATUS_LED_YELLOW and CONFIG_STATUS_LED_BLUE.
+CONFIG_STATUS_LED_GREEN.
 
 General LED functions
 ~~~~~~~~~~~~~~~~~~~~~
@@ -79,15 +79,10 @@ Colour LED's are at present only used by ARM.
 
 The functions names explain their purpose.
 
-- coloured_LED_init
 - red_LED_on
 - red_LED_off
 - green_LED_on
 - green_LED_off
-- yellow_LED_on
-- yellow_LED_off
-- blue_LED_on
-- blue_LED_off
 
 These are weakly defined in arch/arm/lib/board.c to noops. Where applicable, define
 these functions in the board specific source.
diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 1cd3638cb16..1077792efb0 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -414,34 +414,6 @@ config LED_STATUS_RED
 
 endif # LED_STATUS_RED_ENABLE
 
-config LED_STATUS_YELLOW_ENABLE
-	bool "Enable yellow LED"
-	help
-	  Enable yellow status LED.
-
-if LED_STATUS_YELLOW_ENABLE
-
-config LED_STATUS_YELLOW
-	int "Yellow LED identification"
-	help
-	  Valid enabled LED device number.
-
-endif # LED_STATUS_YELLOW_ENABLE
-
-config LED_STATUS_BLUE_ENABLE
-	bool "Enable blue LED"
-	help
-	  Enable blue status LED.
-
-if LED_STATUS_BLUE_ENABLE
-
-config LED_STATUS_BLUE
-	int "Blue LED identification"
-	help
-	  Valid enabled LED device number.
-
-endif # LED_STATUS_BLUE_ENABLE
-
 config LED_STATUS_GREEN_ENABLE
 	bool "Enable green LED"
 	help
diff --git a/drivers/misc/gpio_led.c b/drivers/misc/gpio_led.c
index e63689967a7..e806b1f241f 100644
--- a/drivers/misc/gpio_led.c
+++ b/drivers/misc/gpio_led.c
@@ -79,28 +79,4 @@ void green_led_off(void)
 }
 #endif
 
-#ifdef CONFIG_LED_STATUS_YELLOW
-void yellow_led_on(void)
-{
-	__led_set(CONFIG_LED_STATUS_YELLOW, CONFIG_LED_STATUS_ON);
-}
-
-void yellow_led_off(void)
-{
-	__led_set(CONFIG_LED_STATUS_YELLOW, CONFIG_LED_STATUS_OFF);
-}
-#endif
-
-#ifdef CONFIG_LED_STATUS_BLUE
-void blue_led_on(void)
-{
-	__led_set(CONFIG_LED_STATUS_BLUE, CONFIG_LED_STATUS_ON);
-}
-
-void blue_led_off(void)
-{
-	__led_set(CONFIG_LED_STATUS_BLUE, CONFIG_LED_STATUS_OFF);
-}
-#endif
-
 #endif /* CONFIG_GPIO_LED_STUBS */
diff --git a/include/status_led.h b/include/status_led.h
index 56d519f6d53..85e583f18c8 100644
--- a/include/status_led.h
+++ b/include/status_led.h
@@ -70,25 +70,15 @@ static inline void status_led_boot_blink(void) { }
  * Coloured LEDs API
  */
 #ifndef	__ASSEMBLY__
-void coloured_LED_init(void);
 void red_led_on(void);
 void red_led_off(void);
 void green_led_on(void);
 void green_led_off(void);
-void yellow_led_on(void);
-void yellow_led_off(void);
-void blue_led_on(void);
-void blue_led_off(void);
 #else
-	.extern LED_init
 	.extern red_led_on
 	.extern red_led_off
-	.extern yellow_led_on
-	.extern yellow_led_off
 	.extern green_led_on
 	.extern green_led_off
-	.extern blue_led_on
-	.extern blue_led_off
 #endif
 
 #endif	/* _STATUS_LED_H_	*/

-- 
2.51.1

