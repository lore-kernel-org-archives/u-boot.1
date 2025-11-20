Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E285CF885A
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 13:59:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D498405B;
	Thu, 20 Nov 2025 14:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25F3384068; Thu, 20 Nov 2025 13:48:31 +0100 (CET)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc09])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9F8184082
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 13:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dBynl3RPGzYVc;
 Thu, 20 Nov 2025 13:48:27 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dBynk0p87zvpR; Thu, 20 Nov 2025 13:48:26 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 20 Nov 2025 13:48:06 +0100
Subject: [PATCH 2/2] led: remove legacy API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-legacy-led-removal-v1-2-369d44338358@cherry.de>
References: <20251120-legacy-led-removal-v1-0-369d44338358@cherry.de>
In-Reply-To: <20251120-legacy-led-removal-v1-0-369d44338358@cherry.de>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sean Edmond <seanedmond@microsoft.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Huan Wang <alison.wang@nxp.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Philip Molloy <philip.molloy@analog.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Harsha Vardhan V M <h-vm@ti.com>, briansune <briansune@gmail.com>, 
 Yao Zi <ziyao@disroot.org>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Thu, 20 Nov 2025 14:58:48 +0100
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

No user of the legacy LED API anymore (except Sunxi with the PinePhone
but that is now a Sunxi-specific implementation), so let's remove
anything related.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 README                         |  26 ----
 arch/m68k/lib/bootm.c          |   3 -
 board/isee/igep00x0/igep00x0.c |   1 -
 boot/image.c                   |   4 -
 cmd/Makefile                   |   1 -
 cmd/ide.c                      |   4 -
 cmd/legacy_led.c               | 161 -------------------------
 common/board_f.c               |   1 -
 common/board_r.c               |  11 --
 doc/api/led.rst                |  63 ----------
 drivers/led/Kconfig            | 267 -----------------------------------------
 drivers/misc/Makefile          |   2 -
 drivers/misc/gpio_led.c        |  52 --------
 drivers/misc/status_led.c      | 124 -------------------
 include/status_led.h           |  68 -----------
 15 files changed, 788 deletions(-)

diff --git a/README b/README
index 20a73bab802..38fcb23531c 100644
--- a/README
+++ b/README
@@ -597,32 +597,6 @@ The following options need to be configured:
 
 		A byte containing the id of the VLAN.
 
-- Status LED:	CONFIG_LED_STATUS
-
-		Several configurations allow to display the current
-		status using a LED. For instance, the LED will blink
-		fast while running U-Boot code, stop blinking as
-		soon as a reply to a BOOTP request was received, and
-		start blinking slow once the Linux kernel is running
-		(supported by a status LED driver in the Linux
-		kernel). Defining CONFIG_LED_STATUS enables this
-		feature in U-Boot.
-
-		Additional options:
-
-		CONFIG_LED_STATUS_GPIO
-		The status LED can be connected to a GPIO pin.
-		In such cases, the gpio_led driver can be used as a
-		status LED backend implementation. Define CONFIG_LED_STATUS_GPIO
-		to include the gpio_led driver in the U-Boot binary.
-
-		CFG_GPIO_LED_INVERTED_TABLE
-		Some GPIO connected LEDs may have inverted polarity in which
-		case the GPIO high value corresponds to LED off state and
-		GPIO low value corresponds to LED on state.
-		In such cases CFG_GPIO_LED_INVERTED_TABLE may be defined
-		with a list of GPIO LEDs that have inverted polarity.
-
 - I2C Support:
 		CFG_SYS_NUM_I2C_BUSES
 		Hold the number of i2c buses you want to use.
diff --git a/arch/m68k/lib/bootm.c b/arch/m68k/lib/bootm.c
index 3dcff8076e3..1fa112f8dbf 100644
--- a/arch/m68k/lib/bootm.c
+++ b/arch/m68k/lib/bootm.c
@@ -15,9 +15,6 @@
 #include <bzlib.h>
 #include <watchdog.h>
 #include <asm/byteorder.h>
-#ifdef CONFIG_SHOW_BOOT_PROGRESS
-# include <status_led.h>
-#endif
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/isee/igep00x0/igep00x0.c b/board/isee/igep00x0/igep00x0.c
index c21b083b62a..4dc7b608f0f 100644
--- a/board/isee/igep00x0/igep00x0.c
+++ b/board/isee/igep00x0/igep00x0.c
@@ -9,7 +9,6 @@
 #include <malloc.h>
 #include <mtd.h>
 #include <net.h>
-#include <status_led.h>
 #include <dm.h>
 #include <ns16550.h>
 #include <twl4030.h>
diff --git a/boot/image.c b/boot/image.c
index abac2c7034b..28b367c6b54 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -15,10 +15,6 @@
 #include <malloc.h>
 #include <u-boot/crc.h>
 
-#ifdef CONFIG_SHOW_BOOT_PROGRESS
-#include <status_led.h>
-#endif
-
 #if CONFIG_IS_ENABLED(FIT) || CONFIG_IS_ENABLED(OF_LIBFDT)
 #include <linux/libfdt.h>
 #include <fdt_support.h>
diff --git a/cmd/Makefile b/cmd/Makefile
index 25479907797..969f3b6386d 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -105,7 +105,6 @@ obj-$(CONFIG_CMD_IRQ) += irq.o
 obj-$(CONFIG_CMD_ITEST) += itest.o
 obj-$(CONFIG_CMD_JFFS2) += jffs2.o
 obj-$(CONFIG_CMD_CRAMFS) += cramfs.o
-obj-$(CONFIG_LED_STATUS_CMD) += legacy_led.o
 obj-$(CONFIG_CMD_LED) += led.o
 obj-$(CONFIG_CMD_LICENSE) += license.o
 obj-y += load.o
diff --git a/cmd/ide.c b/cmd/ide.c
index ed30f946866..f99fb6f5824 100644
--- a/cmd/ide.c
+++ b/cmd/ide.c
@@ -21,10 +21,6 @@
 
 #include <ata.h>
 
-#ifdef CONFIG_LED_STATUS
-# include <status_led.h>
-#endif
-
 /* Current I/O Device	*/
 static int curr_device;
 
diff --git a/cmd/legacy_led.c b/cmd/legacy_led.c
deleted file mode 100644
index 4e0d09522ad..00000000000
--- a/cmd/legacy_led.c
+++ /dev/null
@@ -1,161 +0,0 @@
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
-#include <linux/string.h>
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
-#ifdef CONFIG_LED_STATUS_BOARD_SPECIFIC
-#ifdef CONFIG_LED_STATUS0
-	{ "0", CONFIG_LED_STATUS_BIT, NULL, NULL, NULL },
-#endif
-#ifdef CONFIG_LED_STATUS1
-	{ "1", CONFIG_LED_STATUS_BIT1, NULL, NULL, NULL },
-#endif
-#ifdef CONFIG_LED_STATUS2
-	{ "2", CONFIG_LED_STATUS_BIT2, NULL, NULL, NULL },
-#endif
-#ifdef CONFIG_LED_STATUS3
-	{ "3", CONFIG_LED_STATUS_BIT3, NULL, NULL, NULL },
-#endif
-#ifdef CONFIG_LED_STATUS4
-	{ "4", CONFIG_LED_STATUS_BIT4, NULL, NULL, NULL },
-#endif
-#ifdef CONFIG_LED_STATUS5
-	{ "5", CONFIG_LED_STATUS_BIT5, NULL, NULL, NULL },
-#endif
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
-#ifdef CONFIG_LED_STATUS_BOARD_SPECIFIC
-#ifdef CONFIG_LED_STATUS0
-	"0|"
-#endif
-#ifdef CONFIG_LED_STATUS1
-	"1|"
-#endif
-#ifdef CONFIG_LED_STATUS2
-	"2|"
-#endif
-#ifdef CONFIG_LED_STATUS3
-	"3|"
-#endif
-#ifdef CONFIG_LED_STATUS4
-	"4|"
-#endif
-#ifdef CONFIG_LED_STATUS5
-	"5|"
-#endif
-#endif
-	"all] [on|off|toggle|blink] [blink-freq in ms]",
-	"[led_name] [on|off|toggle|blink] sets or clears led(s)"
-);
diff --git a/common/board_f.c b/common/board_f.c
index df2b0dc899b..a90dcf3013c 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -36,7 +36,6 @@
 #include <relocate.h>
 #include <serial.h>
 #include <spl.h>
-#include <status_led.h>
 #include <sysreset.h>
 #include <time.h>
 #include <timer.h>
diff --git a/common/board_r.c b/common/board_r.c
index 76f9fc090fb..8cf0e14679c 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -52,7 +52,6 @@
 #include <pvblock.h>
 #include <scsi.h>
 #include <serial.h>
-#include <status_led.h>
 #include <stdio_dev.h>
 #include <timer.h>
 #include <trace.h>
@@ -482,17 +481,8 @@ static int initr_malloc_bootparams(void)
 }
 #endif
 
-static int initr_status_led(void)
-{
-	status_led_init();
-
-	return 0;
-}
-
 static int initr_boot_led_blink(void)
 {
-	status_led_boot_blink();
-
 	led_boot_blink();
 
 	return 0;
@@ -758,7 +748,6 @@ static void initcall_run_r(void)
 #if defined(CONFIG_MICROBLAZE) || defined(CONFIG_M68K)
 	INITCALL(timer_init);		/* initialize timer */
 #endif
-	INITCALL(initr_status_led);
 	INITCALL(initr_boot_led_blink);
 	/* PPC has a udelay(20) here dating from 2002. Why? */
 #if CONFIG_IS_ENABLED(BOARD_LATE_INIT)
diff --git a/doc/api/led.rst b/doc/api/led.rst
index 1a61f2ad916..fe1904aea0d 100644
--- a/doc/api/led.rst
+++ b/doc/api/led.rst
@@ -8,66 +8,3 @@ LED
 
 .. kernel-doc:: include/led.h
    :internal:
-
-Legacy LED
-==========
-
-Please use the new LED API as defined above. This section is only for reference
-for currently supported devices and to aid for migration to the new API.
-
-Status LED
-----------
-
-This README describes the status LED API.
-
-The API is defined by the include file include/status_led.h
-
-The first step is to enable CONFIG_LED_STATUS in menuconfig::
-
-   > Device Drivers > LED Support.
-
-If the LED support is only for specific board, enable
-CONFIG_LED_STATUS_BOARD_SPECIFIC in the menuconfig.
-
-Status LEDS 0 to 5 are enabled by the following configurations at menuconfig:
-CONFIG_STATUS_LED0, CONFIG_STATUS_LED1, ... CONFIG_STATUS_LED5
-
-The following should be configured for each of the enabled LEDs:
-
-- CONFIG_STATUS_LED_BIT<n>
-- CONFIG_STATUS_LED_STATE<n>
-- CONFIG_STATUS_LED_FREQ<n>
-
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
-~~~~~~~~~~~~~~~~~~~~~
-
-CONFIG_STATUS_LED_BOOT is the LED to light when the board is booting.
-This must be a valid LED number (0-5).
-
-General LED functions
-~~~~~~~~~~~~~~~~~~~~~
-The following functions should be defined:
-
-__led_init is called once to initialize the LED to CONFIG_STATUS_LED_STATE.
-One time start up code should be placed here.
-
-__led_set is called to change the state of the LED.
-
-__led_toggle is called to toggle the current state of the LED.
-
-TBD : Describe older board dependent macros similar to what is done for
-
-TBD : Describe general support via asm/status_led.h
diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index cc715ceb286..de95a1debdc 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -138,271 +138,4 @@ config SPL_LED_GPIO
 	  This option is an SPL-variant of the LED_GPIO option.
 	  See the help of LED_GPIO for details.
 
-config LED_STATUS
-	bool "Enable legacy status LED API"
-	depends on !LED
-	help
-	  Allows common u-boot commands to use a board's leds to
-	  provide status for activities like booting and downloading files.
-
-if LED_STATUS
-
-# Hidden constants
-
-config LED_STATUS_OFF
-	int
-	default 0
-
-config LED_STATUS_BLINKING
-	int
-	default 1
-
-config LED_STATUS_ON
-	int
-	default 2
-
-# Hidden constants end
-
-config LED_STATUS_GPIO
-	bool "GPIO status LED implementation"
-	help
-	  The status LED can be connected to a GPIO pin. In such cases, the
-	  gpio_led driver can be used as a status LED backend implementation.
-
-config LED_STATUS_BOARD_SPECIFIC
-	bool "Specific board"
-	default y
-	help
-	  LED support is only for a specific board.
-
-comment "LEDs parameters"
-
-config LED_STATUS0
-	bool "Enable status LED 0"
-
-if LED_STATUS0
-
-config LED_STATUS_BIT
-	int "identification"
-	help
-	  CONFIG_LED_STATUS_BIT is passed into the __led_* functions to identify
-	  which LED is being acted on.  As such, the chosen value must be unique
-	  with respect to the other CONFIG_LED_STATUS_BIT's. Mapping the value
-	  to a physical LED is the responsibility of the __led_* function.
-
-config LED_STATUS_STATE
-	int "initial state"
-	range LED_STATUS_OFF LED_STATUS_ON
-	default LED_STATUS_OFF
-	help
-	  Should be set one of the following:
-	  0 - off
-	  1 - blinking
-	  2 - on
-
-config LED_STATUS_FREQ
-	int "blink frequency"
-	range 2 10
-	default 2
-	help
-	  The LED blink period calculated from LED_STATUS_FREQ:
-	  LED_STATUS_PERIOD = CONFIG_SYS_HZ/LED_STATUS_FREQ
-	  Values range: 2 - 10
-
-endif # LED_STATUS0
-
-config LED_STATUS1
-	bool "Enable status LED 1"
-
-if LED_STATUS1
-
-config LED_STATUS_BIT1
-	int "identification"
-	help
-	  CONFIG_LED_STATUS_BIT1 is passed into the __led_* functions to
-	  identify which LED is being acted on.  As such, the chosen value must
-	  be unique with respect to the other CONFIG_LED_STATUS_BIT's. Mapping
-	  the value to a physical LED is the responsibility of the __led_*
-	  function.
-
-config LED_STATUS_STATE1
-	int "initial state"
-	range LED_STATUS_OFF LED_STATUS_ON
-	default LED_STATUS_OFF
-	help
-	  Should be set one of the following:
-	  0 - off
-	  1 - blinking
-	  2 - on
-
-config LED_STATUS_FREQ1
-	int "blink frequency"
-	range 2 10
-	default 2
-	help
-	  The LED blink period calculated from LED_STATUS_FREQ1:
-	  LED_STATUS_PERIOD1 = CONFIG_SYS_HZ/LED_STATUS_FREQ1
-	  Values range: 2 - 10
-
-endif # LED_STATUS1
-
-config LED_STATUS2
-	bool "Enable status LED 2"
-
-if LED_STATUS2
-
-config LED_STATUS_BIT2
-	int "identification"
-	help
-	  CONFIG_LED_STATUS_BIT2 is passed into the __led_* functions to
-	  identify which LED is being acted on.  As such, the chosen value must
-	  be unique with respect to the other CONFIG_LED_STATUS_BIT's. Mapping
-	  the value to a physical LED is the responsibility of the __led_*
-	  function.
-
-config LED_STATUS_STATE2
-	int "initial state"
-	range LED_STATUS_OFF LED_STATUS_ON
-	default LED_STATUS_OFF
-	help
-	  Should be set one of the following:
-	  0 - off
-	  1 - blinking
-	  2 - on
-
-config LED_STATUS_FREQ2
-	int "blink frequency"
-	range 2 10
-	default 2
-	help
-	  The LED blink period calculated from LED_STATUS_FREQ2:
-	  LED_STATUS_PERIOD2 = CONFIG_SYS_HZ/LED_STATUS_FREQ2
-	  Values range: 2 - 10
-
-endif # LED_STATUS2
-
-config LED_STATUS3
-	bool "Enable status LED 3"
-
-if LED_STATUS3
-
-config LED_STATUS_BIT3
-	int "identification"
-	help
-	  CONFIG_LED_STATUS_BIT3 is passed into the __led_* functions to
-	  identify which LED is being acted on.  As such, the chosen value must
-	  be unique with respect to the other CONFIG_LED_STATUS_BIT's. Mapping
-	  the value to a physical LED is the responsibility of the __led_*
-	  function.
-
-config LED_STATUS_STATE3
-	int "initial state"
-	range LED_STATUS_OFF LED_STATUS_ON
-	default LED_STATUS_OFF
-	help
-	  Should be set one of the following:
-	  0 - off
-	  1 - blinking
-	  2 - on
-
-config LED_STATUS_FREQ3
-	int "blink frequency"
-	range 2 10
-	default 2
-	help
-	  The LED blink period calculated from LED_STATUS_FREQ3:
-	  LED_STATUS_PERIOD3 = CONFIG_SYS_HZ/LED_STATUS_FREQ3
-	  Values range: 2 - 10
-
-endif # LED_STATUS3
-
-config LED_STATUS4
-	bool "Enable status LED 4"
-
-if LED_STATUS4
-
-config LED_STATUS_BIT4
-	int "identification"
-	help
-	  CONFIG_LED_STATUS_BIT4 is passed into the __led_* functions to
-	  identify which LED is being acted on.  As such, the chosen value must
-	  be unique with respect to the other CONFIG_LED_STATUS_BIT's. Mapping
-	  the value to a physical LED is the responsibility of the __led_*
-	  function.
-
-config LED_STATUS_STATE4
-	int "initial state"
-	range LED_STATUS_OFF LED_STATUS_ON
-	default LED_STATUS_OFF
-	help
-	  Should be set one of the following:
-	  0 - off
-	  1 - blinking
-	  2 - on
-
-config LED_STATUS_FREQ4
-	int "blink frequency"
-	range 2 10
-	default 2
-	help
-	  The LED blink period calculated from LED_STATUS_FREQ4:
-	  LED_STATUS_PERIOD4 = CONFIG_SYS_HZ/LED_STATUS_FREQ4
-	  Values range: 2 - 10
-
-endif # LED_STATUS4
-
-config LED_STATUS5
-	bool "Enable status LED 5"
-
-if LED_STATUS5
-
-config LED_STATUS_BIT5
-	int "identification"
-	help
-	  CONFIG_LED_STATUS_BIT5 is passed into the __led_* functions to
-	  identify which LED is being acted on.  As such, the chosen value must
-	  be unique with respect to the other CONFIG_LED_STATUS_BIT's. Mapping
-	  the value to a physical LED is the responsibility of the __led_*
-	  function.
-
-config LED_STATUS_STATE5
-	int "initial state"
-	range LED_STATUS_OFF LED_STATUS_ON
-	default LED_STATUS_OFF
-	help
-	  Should be set one of the following:
-	  0 - off
-	  1 - blinking
-	  2 - on
-
-config LED_STATUS_FREQ5
-	int "blink frequency"
-	range 2 10
-	default 2
-	help
-	  The LED blink period calculated from LED_STATUS_FREQ5:
-	  LED_STATUS_PERIOD5 = CONFIG_SYS_HZ/LED_STATUS_FREQ5
-	  Values range: 2 - 10
-
-endif # LED_STATUS5
-
-config LED_STATUS_BOOT_ENABLE
-	bool "Enable BOOT LED"
-	help
-	  Enable to turn an LED on when the board is booting.
-
-if LED_STATUS_BOOT_ENABLE
-
-config LED_STATUS_BOOT
-	int "LED to light when the board is booting"
-	help
-	  Valid enabled LED device number.
-
-endif # LED_STATUS_BOOT_ENABLE
-
-config LED_STATUS_CMD
-	bool "Enable status LED commands"
-
-endif # LED_STATUS
-
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 1d950f7a0ab..e2170212e5a 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -48,8 +48,6 @@ obj-$(CONFIG_IHS_FPGA) += ihs_fpga.o
 obj-$(CONFIG_IMX8) += imx8/
 obj-$(CONFIG_IMX_ELE) += imx_ele/
 obj-$(CONFIG_K3_FUSE) += k3_fuse.o
-obj-$(CONFIG_LED_STATUS) += status_led.o
-obj-$(CONFIG_LED_STATUS_GPIO) += gpio_led.o
 obj-$(CONFIG_MPC83XX_SERDES) += mpc83xx_serdes.o
 obj-$(CONFIG_$(PHASE_)LS2_SFP) += ls2_sfp.o
 obj-$(CONFIG_$(PHASE_)MXC_OCOTP) += mxc_ocotp.o
diff --git a/drivers/misc/gpio_led.c b/drivers/misc/gpio_led.c
deleted file mode 100644
index 1e2f83cca93..00000000000
--- a/drivers/misc/gpio_led.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * Status LED driver based on GPIO access conventions of Linux
- *
- * Copyright (C) 2010 Thomas Chou <thomas@wytron.com.tw>
- * Licensed under the GPL-2 or later.
- */
-
-#include <status_led.h>
-#include <asm/gpio.h>
-
-#ifndef CFG_GPIO_LED_INVERTED_TABLE
-#define CFG_GPIO_LED_INVERTED_TABLE {}
-#endif
-
-static led_id_t gpio_led_inv[] = CFG_GPIO_LED_INVERTED_TABLE;
-
-static int gpio_led_gpio_value(led_id_t mask, int state)
-{
-	int i, gpio_value = (state == CONFIG_LED_STATUS_ON);
-
-	for (i = 0; i < ARRAY_SIZE(gpio_led_inv); i++) {
-		if (gpio_led_inv[i] == mask)
-			gpio_value = !gpio_value;
-	}
-
-	return gpio_value;
-}
-
-void __led_init(led_id_t mask, int state)
-{
-	int gpio_value;
-
-	if (gpio_request(mask, "gpio_led") != 0) {
-		printf("%s: failed requesting GPIO%lu!\n", __func__, mask);
-		return;
-	}
-
-	gpio_value = gpio_led_gpio_value(mask, state);
-	gpio_direction_output(mask, gpio_value);
-}
-
-void __led_set(led_id_t mask, int state)
-{
-	int gpio_value = gpio_led_gpio_value(mask, state);
-
-	gpio_set_value(mask, gpio_value);
-}
-
-void __led_toggle(led_id_t mask)
-{
-	gpio_set_value(mask, !gpio_get_value(mask));
-}
diff --git a/drivers/misc/status_led.c b/drivers/misc/status_led.c
deleted file mode 100644
index 3b1baa4f840..00000000000
--- a/drivers/misc/status_led.c
+++ /dev/null
@@ -1,124 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2000-2003
- * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
- */
-
-#include <status_led.h>
-#include <linux/types.h>
-
-/*
- * The purpose of this code is to signal the operational status of a
- * target which usually boots over the network; while running in
- * U-Boot, a status LED is blinking. As soon as a valid BOOTP reply
- * message has been received, the LED is turned off. The Linux
- * kernel, once it is running, will start blinking the LED again,
- * with another frequency.
- */
-
-/* ------------------------------------------------------------------------- */
-
-typedef struct {
-	led_id_t mask;
-	int state;
-	int period;
-	int cnt;
-} led_dev_t;
-
-led_dev_t led_dev[] = {
-	{	CONFIG_LED_STATUS_BIT,
-		CONFIG_LED_STATUS_STATE,
-		LED_STATUS_PERIOD,
-		0,
-	},
-#if defined(CONFIG_LED_STATUS1)
-	{	CONFIG_LED_STATUS_BIT1,
-		CONFIG_LED_STATUS_STATE1,
-		LED_STATUS_PERIOD1,
-		0,
-	},
-#endif
-#if defined(CONFIG_LED_STATUS2)
-	{	CONFIG_LED_STATUS_BIT2,
-		CONFIG_LED_STATUS_STATE2,
-		LED_STATUS_PERIOD2,
-		0,
-	},
-#endif
-#if defined(CONFIG_LED_STATUS3)
-	{	CONFIG_LED_STATUS_BIT3,
-		CONFIG_LED_STATUS_STATE3,
-		LED_STATUS_PERIOD3,
-		0,
-	},
-#endif
-#if defined(CONFIG_LED_STATUS4)
-	{	CONFIG_LED_STATUS_BIT4,
-		CONFIG_LED_STATUS_STATE4,
-		LED_STATUS_PERIOD4,
-		0,
-	},
-#endif
-#if defined(CONFIG_LED_STATUS5)
-	{	CONFIG_LED_STATUS_BIT5,
-		CONFIG_LED_STATUS_STATE5,
-		LED_STATUS_PERIOD5,
-		0,
-	},
-#endif
-};
-
-#define MAX_LED_DEV	(sizeof(led_dev)/sizeof(led_dev_t))
-
-static int status_led_init_done = 0;
-
-void status_led_init(void)
-{
-	led_dev_t *ld;
-	int i;
-
-	for (i = 0, ld = led_dev; i < MAX_LED_DEV; i++, ld++)
-		__led_init (ld->mask, ld->state);
-	status_led_init_done = 1;
-}
-
-void status_led_tick(ulong timestamp)
-{
-	led_dev_t *ld;
-	int i;
-
-	if (!status_led_init_done)
-		status_led_init();
-
-	for (i = 0, ld = led_dev; i < MAX_LED_DEV; i++, ld++) {
-
-		if (ld->state != CONFIG_LED_STATUS_BLINKING)
-			continue;
-
-		if (++ld->cnt >= ld->period) {
-			__led_toggle (ld->mask);
-			ld->cnt -= ld->period;
-		}
-
-	}
-}
-
-void status_led_set(int led, int state)
-{
-	led_dev_t *ld;
-
-	if (led < 0 || led >= MAX_LED_DEV)
-		return;
-
-	if (!status_led_init_done)
-		status_led_init();
-
-	ld = &led_dev[led];
-
-	ld->state = state;
-	if (state == CONFIG_LED_STATUS_BLINKING) {
-		ld->cnt = 0;		/* always start with full period    */
-		state = CONFIG_LED_STATUS_ON;	/* always start with LED _ON_ */
-	}
-	__led_set (ld->mask, state);
-}
diff --git a/include/status_led.h b/include/status_led.h
deleted file mode 100644
index c3ff399b1ae..00000000000
--- a/include/status_led.h
+++ /dev/null
@@ -1,68 +0,0 @@
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
-#if defined(CONFIG_LED_STATUS_BOARD_SPECIFIC)
-/* led_id_t is unsigned long mask */
-typedef unsigned long led_id_t;
-
-extern void __led_toggle (led_id_t mask);
-extern void __led_init (led_id_t mask, int state);
-extern void __led_set (led_id_t mask, int state);
-void __led_blink(led_id_t mask, int freq);
-#else
-# error Status LED configuration missing
-#endif
-
-#else
-
-static inline void status_led_init(void) { }
-static inline void status_led_set(int led, int state) { }
-static inline void status_led_boot_blink(void) { }
-
-#endif	/* CONFIG_LED_STATUS	*/
-#endif	/* _STATUS_LED_H_	*/

-- 
2.51.1

