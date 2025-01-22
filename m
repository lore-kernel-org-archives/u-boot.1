Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5156C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 12:12:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FAF7803B5;
	Wed, 22 Jan 2025 13:12:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737547932;
	bh=AugM6kqyG2L15PPxC3jpwD38AlOs5SYuIBI2pkI+EzY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yAzqsjHKmkRsVDrfI7LwEnX0kUNEcONKyQcZbLvIgHNLj5oSWX75r0uEHZ5tHEjzw
	 Jer8O5qBMpPdh464OzB3ag3kTzhOubkvH2WdrdKmDLE7tCU1NbAJraXgnJyMkiZ2Es
	 QrY6Iiex+1lL2eR7b+ZPRNa32RKHOtv+XHPjJLysTVW3qqgY53mXYndmhJi0T6grsg
	 HcMSMRQ6tyvUJwTUyNehpzfbzqlTtuhTf1vL+U3U79dpUVP7ZWA+1niuwJGCuQhOdx
	 zKREqc2TEz7+ja4pGs1tg9Nc2K18dH0LwRxWgS6JKPbXRYn7F1BrbrNfzI03zq8rKA
	 2/MuTtxwoF9QQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88DE780586; Wed, 22 Jan 2025 13:12:11 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B52F4801FB
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 13:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="KyxtNdhF"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5B846100ECBC3; Wed, 22 Jan 2025 13:12:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737547927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AugM6kqyG2L15PPxC3jpwD38AlOs5SYuIBI2pkI+EzY=;
 b=KyxtNdhF5szmAqty5oqpeygZyRxGn0vBrpC6P/lCMRzd08bOgEYRxdTm0Q+9fHNiXvWtgT
 /TVIVDfmC+jAHdwPRFPYvx4zwXz3I1KDJWKuXSy6RgOr8/QQwTrAEBxEVgtieCFVYDJifI
 0pLjCpNFIeS2eXFepocIbHu93Qpqze7IfcMJjjPzj7LyT2QeV1h453vfBXd1++u4xZBHV6
 echpTmZIfXiFpJ8LEuw1P+sspASJSefxVnyo5gBP4G/I4UXHn5Bx1suLY5xfGUeIsf8xzI
 AMzpqJI+OPrzIqiEOxSXpTR9Gu+t1RGxGUVfOC+yorvcbfJrQ0x54WnXttbqmg==
From: Heiko Schocher <hs@denx.de>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>, Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] led: add function naming option from linux
Date: Wed, 22 Jan 2025 13:12:01 +0100
Message-Id: <20250122121201.55597-1-hs@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

in linux we have the option to create the name of a led
optionally through the following properties:

- function
- color
- function-enumerator

This patch adds support for parsing this properties if there
is no label property.

To be as close as possible to linux import the following files
from it:

include/dt-bindings/leds/common.h
include/linux/uapi/linux/uleds.h

base commit was:
commit: b8f52214c61a ("Merge tag 'audit-pr-20241205' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit")

The led name is created in led_post_bind() and we need some
storage place for it. Currently this patch prevents to use
malloc() instead it stores the name in new member :

        char name[LED_MAX_NAME_SIZE];

of struct led_uc_plat. While at it append led tests for the
new feature.

Signed-off-by: Heiko Schocher <hs@denx.de>
---
as we introduce a new element in struct led_uc_priv, may we should add
this functionality through a new Kconfig option? (Which also would make
this optional and save some bytes for boards who do not need this...)

Ignored a lot of checkpatch warnigs for file include/dt-bindings/leds/common.h

WARNING: Block comments use * on subsequent lines
+/*   Obsolete equivalents: "tpacpi::thinklight" (IBM/Lenovo Thinkpads),
+     "lp5523:kb{1,2,3,4,5,6}" (Nokia N900) */
WARNING: Block comments use a trailing */ on a separate line
+     "lp5523:kb{1,2,3,4,5,6}" (Nokia N900) */
WARNING: Block comments use * on subsequent lines
+/* System LEDs, usually found on system body.
+   platform::mute (etc) is sometimes seen, :mute would be better */
WARNING: Block comments use a trailing */ on a separate line
+   platform::mute (etc) is sometimes seen, :mute would be better */
WARNING: Block comments use * on subsequent lines
+/*   Used RGB notification LEDs common on phones.
+     Obsolete equivalents: "status-led:{red,green,blue}" (Motorola Droid 4),
WARNING: Block comments use a trailing */ on a separate line
+     "lp5523:{r,g,b}" (Nokia N900) */

as it is copied from linux

commit: b8f52214c61a ("Merge tag 'audit-pr-20241205' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit")

Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=164&view=results


Changes in v2:
- remove unused name variable in function led_get_label()
- rebased patch to current HEAD
  82d262ae162 ("Merge patch series "MediaTek MT7629 OF_UPSTREAM migration (v2)"")

 arch/sandbox/dts/test.dts                |  37 +++++++-
 doc/device-tree-bindings/leds/common.txt |  28 ++++++
 drivers/led/led-uclass.c                 |  70 +++++++++++++-
 include/dt-bindings/leds/common.h        | 114 +++++++++++++++++++++++
 include/led.h                            |   2 +
 include/linux/uapi/linux/uleds.h         |  25 +++++
 test/dm/led.c                            |  22 ++++-
 test/dm/ofnode.c                         |   2 +-
 8 files changed, 293 insertions(+), 7 deletions(-)
 create mode 100644 include/dt-bindings/leds/common.h
 create mode 100644 include/linux/uapi/linux/uleds.h

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index ae52b375ccb..b8f3012873e 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -13,6 +13,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/gpio/sandbox-gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/sandbox-pinmux.h>
 #include <dt-bindings/mux/mux.h>
 
@@ -820,7 +821,7 @@
 			gpio-controller;
 			#gpio-cells = <1>;
 			gpio-bank-name = "a";
-			sandbox,gpio-count = <20>;
+			sandbox,gpio-count = <25>;
 			hog_input_active_low {
 				gpio-hog;
 				input;
@@ -1010,6 +1011,40 @@
 			/* label intentionally omitted */
 			default-state = "off";
 		};
+
+		led-20 {
+			gpios = <&gpio_a 20 0>;
+			/* label intentionally omitted */
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_RED>;
+			function-enumerator = <20>;
+		};
+
+		led-21 {
+			gpios = <&gpio_a 21 0>;
+			/* label intentionally omitted */
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led-22 {
+			gpios = <&gpio_a 22 0>;
+			/* label intentionally omitted */
+			function = LED_FUNCTION_STATUS;
+		};
+
+		led-23 {
+			gpios = <&gpio_a 23 0>;
+			/* label intentionally omitted */
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led-24 {
+			gpios = <&gpio_a 24 0>;
+			label = "sandbox:function";
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_GREEN>;
+		};
 	};
 
 	wdt-gpio-toggle {
diff --git a/doc/device-tree-bindings/leds/common.txt b/doc/device-tree-bindings/leds/common.txt
index 2d88816dd55..10b2cd84113 100644
--- a/doc/device-tree-bindings/leds/common.txt
+++ b/doc/device-tree-bindings/leds/common.txt
@@ -4,6 +4,21 @@ Optional properties for child nodes:
 - label : The label for this LED.  If omitted, the label is
   taken from the node name (excluding the unit address).
 
+- function:
+  LED function. Use one of the LED_FUNCTION_* prefixed definitions
+  from the header include/dt-bindings/leds/common.h. If there is no
+  matching LED_FUNCTION available, add a new one.
+
+- color:
+  Color of the LED. Use one of the LED_COLOR_ID_* prefixed definitions from
+  the header include/dt-bindings/leds/common.h. If there is no matching
+  LED_COLOR_ID available, add a new one.
+
+- function-enumerator:
+  optional
+    Integer to be used when more than one instance of the same function is
+    needed, differing only with an ordinal number.
+
 - linux,default-trigger :  This parameter, if present, is a
     string defining the trigger assigned to the LED.  Current triggers are:
      "backlight" - LED will act as a back-light, controlled by the framebuffer
@@ -21,3 +36,16 @@ system-status {
 	linux,default-trigger = "heartbeat";
 	...
 };
+
+led-0 {
+	function = LED_FUNCTION_STATUS;
+	color = <LED_COLOR_ID_RED>;
+	function-enumerator = <20>;
+	...
+};
+
+led-1 {
+	function = LED_FUNCTION_STATUS;
+	color = <LED_COLOR_ID_YELLOW>;
+	...
+};
diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 760750568c0..27ef890ed0a 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -13,6 +13,25 @@
 #include <dm/lists.h>
 #include <dm/root.h>
 #include <dm/uclass-internal.h>
+#include <dt-bindings/leds/common.h>
+
+static const char * const led_colors[LED_COLOR_ID_MAX] = {
+	[LED_COLOR_ID_WHITE] = "white",
+	[LED_COLOR_ID_RED] = "red",
+	[LED_COLOR_ID_GREEN] = "green",
+	[LED_COLOR_ID_BLUE] = "blue",
+	[LED_COLOR_ID_AMBER] = "amber",
+	[LED_COLOR_ID_VIOLET] = "violet",
+	[LED_COLOR_ID_YELLOW] = "yellow",
+	[LED_COLOR_ID_IR] = "ir",
+	[LED_COLOR_ID_MULTI] = "multicolor",
+	[LED_COLOR_ID_RGB] = "rgb",
+	[LED_COLOR_ID_PURPLE] = "purple",
+	[LED_COLOR_ID_ORANGE] = "orange",
+	[LED_COLOR_ID_PINK] = "pink",
+	[LED_COLOR_ID_CYAN] = "cyan",
+	[LED_COLOR_ID_LIME] = "lime",
+};
 
 int led_bind_generic(struct udevice *parent, const char *driver_name)
 {
@@ -232,11 +251,54 @@ int led_activity_blink(void)
 #endif
 #endif
 
-static const char *led_get_label(ofnode node)
+static const char *led_get_function_name(struct udevice *dev)
+{
+	struct led_uc_plat *uc_plat;
+	const char *func;
+	u32 color;
+	u32 enumerator;
+	int ret;
+	int cp;
+
+	if (!dev)
+		return NULL;
+
+	uc_plat = dev_get_uclass_plat(dev);
+	if (!uc_plat)
+		return NULL;
+
+	if (uc_plat->label)
+		return uc_plat->label;
+
+	/* Now try to detect function label name */
+	func = dev_read_string(dev, "function");
+	cp = dev_read_u32(dev, "color", &color);
+	if (cp == 0 || func) {
+		ret = dev_read_u32(dev, "function-enumerator", &enumerator);
+		if (!ret) {
+			snprintf(uc_plat->name, LED_MAX_NAME_SIZE,
+				 "%s:%s-%d",
+				 cp ? "" : led_colors[color],
+				 func ? func : "", enumerator);
+		} else {
+			snprintf(uc_plat->name, LED_MAX_NAME_SIZE,
+				 "%s:%s",
+				 cp ? "" : led_colors[color],
+				 func ? func : "");
+		}
+		uc_plat->label = uc_plat->name;
+	}
+
+	return uc_plat->label;
+}
+
+static const char *led_get_label(struct udevice *dev, ofnode node)
 {
 	const char *label;
 
 	label = ofnode_read_string(node, "label");
+	if (!label)
+		label = led_get_function_name(dev);
 	if (!label && !ofnode_read_string(node, "compatible"))
 		label = ofnode_get_name(node);
 
@@ -249,7 +311,7 @@ static int led_post_bind(struct udevice *dev)
 	const char *default_state;
 
 	if (!uc_plat->label)
-		uc_plat->label = led_get_label(dev_ofnode(dev));
+		uc_plat->label = led_get_label(dev, dev_ofnode(dev));
 
 	uc_plat->default_state = LEDST_COUNT;
 
@@ -314,14 +376,14 @@ static int led_init(struct uclass *uc)
 #ifdef CONFIG_LED_BOOT
 	ret = ofnode_options_get_by_phandle("boot-led", &led_node);
 	if (!ret)
-		priv->boot_led_label = led_get_label(led_node);
+		priv->boot_led_label = led_get_label(NULL, led_node);
 	priv->boot_led_period = ofnode_options_read_int("boot-led-period-ms", 250);
 #endif
 
 #ifdef CONFIG_LED_ACTIVITY
 	ret = ofnode_options_get_by_phandle("activity-led", &led_node);
 	if (!ret)
-		priv->activity_led_label = led_get_label(led_node);
+		priv->activity_led_label = led_get_label(NULL, led_node);
 	priv->activity_led_period = ofnode_options_read_int("activity-led-period-ms",
 							    250);
 #endif
diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
new file mode 100644
index 00000000000..4f017bea012
--- /dev/null
+++ b/include/dt-bindings/leds/common.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides macros for the common LEDs device tree bindings.
+ *
+ * Copyright (C) 2015, Samsung Electronics Co., Ltd.
+ * Author: Jacek Anaszewski <j.anaszewski@samsung.com>
+ *
+ * Copyright (C) 2019 Jacek Anaszewski <jacek.anaszewski@gmail.com>
+ * Copyright (C) 2020 Pavel Machek <pavel@ucw.cz>
+ */
+
+#ifndef __DT_BINDINGS_LEDS_H
+#define __DT_BINDINGS_LEDS_H
+
+/* External trigger type */
+#define LEDS_TRIG_TYPE_EDGE	0
+#define LEDS_TRIG_TYPE_LEVEL	1
+
+/* Boost modes */
+#define LEDS_BOOST_OFF		0
+#define LEDS_BOOST_ADAPTIVE	1
+#define LEDS_BOOST_FIXED	2
+
+/* Standard LED colors */
+#define LED_COLOR_ID_WHITE	0
+#define LED_COLOR_ID_RED	1
+#define LED_COLOR_ID_GREEN	2
+#define LED_COLOR_ID_BLUE	3
+#define LED_COLOR_ID_AMBER	4
+#define LED_COLOR_ID_VIOLET	5
+#define LED_COLOR_ID_YELLOW	6
+#define LED_COLOR_ID_IR		7
+#define LED_COLOR_ID_MULTI	8	/* For multicolor LEDs */
+#define LED_COLOR_ID_RGB	9	/* For multicolor LEDs that can do arbitrary color,
+					   so this would include RGBW and similar */
+#define LED_COLOR_ID_PURPLE	10
+#define LED_COLOR_ID_ORANGE	11
+#define LED_COLOR_ID_PINK	12
+#define LED_COLOR_ID_CYAN	13
+#define LED_COLOR_ID_LIME	14
+#define LED_COLOR_ID_MAX	15
+
+/* Standard LED functions */
+/* Keyboard LEDs, usually it would be input4::capslock etc. */
+/*   Obsolete equivalent: "shift-key-light" */
+#define LED_FUNCTION_CAPSLOCK "capslock"
+#define LED_FUNCTION_SCROLLLOCK "scrolllock"
+#define LED_FUNCTION_NUMLOCK "numlock"
+#define LED_FUNCTION_FNLOCK "fnlock"
+/*   Obsolete equivalents: "tpacpi::thinklight" (IBM/Lenovo Thinkpads),
+     "lp5523:kb{1,2,3,4,5,6}" (Nokia N900) */
+#define LED_FUNCTION_KBD_BACKLIGHT "kbd_backlight"
+
+/* System LEDs, usually found on system body.
+   platform::mute (etc) is sometimes seen, :mute would be better */
+#define LED_FUNCTION_POWER "power"
+#define LED_FUNCTION_DISK "disk"
+
+/*   Obsolete: "platform:*:charging" (allwinner sun50i) */
+#define LED_FUNCTION_CHARGING "charging"
+/*   Used RGB notification LEDs common on phones.
+     Obsolete equivalents: "status-led:{red,green,blue}" (Motorola Droid 4),
+     "lp5523:{r,g,b}" (Nokia N900) */
+#define LED_FUNCTION_STATUS "status"
+
+#define LED_FUNCTION_MICMUTE "micmute"
+#define LED_FUNCTION_MUTE "mute"
+
+/* Used for player LEDs as found on game controllers from e.g. Nintendo, Sony. */
+#define LED_FUNCTION_PLAYER1 "player-1"
+#define LED_FUNCTION_PLAYER2 "player-2"
+#define LED_FUNCTION_PLAYER3 "player-3"
+#define LED_FUNCTION_PLAYER4 "player-4"
+#define LED_FUNCTION_PLAYER5 "player-5"
+
+/* Miscelleaus functions. Use functions above if you can. */
+#define LED_FUNCTION_ACTIVITY "activity"
+#define LED_FUNCTION_ALARM "alarm"
+#define LED_FUNCTION_BACKLIGHT "backlight"
+#define LED_FUNCTION_BLUETOOTH "bluetooth"
+#define LED_FUNCTION_BOOT "boot"
+#define LED_FUNCTION_CPU "cpu"
+#define LED_FUNCTION_DEBUG "debug"
+#define LED_FUNCTION_DISK_ACTIVITY "disk-activity"
+#define LED_FUNCTION_DISK_ERR "disk-err"
+#define LED_FUNCTION_DISK_READ "disk-read"
+#define LED_FUNCTION_DISK_WRITE "disk-write"
+#define LED_FUNCTION_FAULT "fault"
+#define LED_FUNCTION_FLASH "flash"
+#define LED_FUNCTION_HEARTBEAT "heartbeat"
+#define LED_FUNCTION_INDICATOR "indicator"
+#define LED_FUNCTION_LAN "lan"
+#define LED_FUNCTION_MAIL "mail"
+#define LED_FUNCTION_MOBILE "mobile"
+#define LED_FUNCTION_MTD "mtd"
+#define LED_FUNCTION_PANIC "panic"
+#define LED_FUNCTION_PROGRAMMING "programming"
+#define LED_FUNCTION_RX "rx"
+#define LED_FUNCTION_SD "sd"
+#define LED_FUNCTION_SPEED_LAN "speed-lan"
+#define LED_FUNCTION_SPEED_WAN "speed-wan"
+#define LED_FUNCTION_STANDBY "standby"
+#define LED_FUNCTION_TORCH "torch"
+#define LED_FUNCTION_TX "tx"
+#define LED_FUNCTION_USB "usb"
+#define LED_FUNCTION_WAN "wan"
+#define LED_FUNCTION_WAN_ONLINE "wan-online"
+#define LED_FUNCTION_WLAN "wlan"
+#define LED_FUNCTION_WLAN_2GHZ "wlan-2ghz"
+#define LED_FUNCTION_WLAN_5GHZ "wlan-5ghz"
+#define LED_FUNCTION_WLAN_6GHZ "wlan-6ghz"
+#define LED_FUNCTION_WPS "wps"
+
+#endif /* __DT_BINDINGS_LEDS_H */
diff --git a/include/led.h b/include/led.h
index 64247cd3a70..ba42a5f69d2 100644
--- a/include/led.h
+++ b/include/led.h
@@ -10,6 +10,7 @@
 #include <stdbool.h>
 #include <cyclic.h>
 #include <dm/ofnode.h>
+#include <linux/uapi/linux/uleds.h>
 
 /**
  * DOC: Overview
@@ -86,6 +87,7 @@ struct led_sw_blink {
 struct led_uc_plat {
 	const char *label;
 	enum led_state_t default_state;
+	char name[LED_MAX_NAME_SIZE];
 #ifdef CONFIG_LED_SW_BLINK
 	struct led_sw_blink *sw_blink;
 #endif
diff --git a/include/linux/uapi/linux/uleds.h b/include/linux/uapi/linux/uleds.h
new file mode 100644
index 00000000000..4d32a39965f
--- /dev/null
+++ b/include/linux/uapi/linux/uleds.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Userspace driver support for the LED subsystem
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef _UAPI__ULEDS_H_
+#define _UAPI__ULEDS_H_
+
+#define LED_MAX_NAME_SIZE	64
+
+struct uleds_user_dev {
+	char name[LED_MAX_NAME_SIZE];
+	int max_brightness;
+};
+
+#endif /* _UAPI__ULEDS_H_ */
diff --git a/test/dm/led.c b/test/dm/led.c
index e5b86326c3a..36652c2833a 100644
--- a/test/dm/led.c
+++ b/test/dm/led.c
@@ -20,7 +20,12 @@ static int dm_test_led_base(struct unit_test_state *uts)
 	ut_assertok(uclass_get_device(UCLASS_LED, 1, &dev));
 	ut_assertok(uclass_get_device(UCLASS_LED, 2, &dev));
 	ut_assertok(uclass_get_device(UCLASS_LED, 3, &dev));
-	ut_asserteq(-ENODEV, uclass_get_device(UCLASS_LED, 4, &dev));
+	ut_assertok(uclass_get_device(UCLASS_LED, 4, &dev));
+	ut_assertok(uclass_get_device(UCLASS_LED, 5, &dev));
+	ut_assertok(uclass_get_device(UCLASS_LED, 6, &dev));
+	ut_assertok(uclass_get_device(UCLASS_LED, 7, &dev));
+	ut_assertok(uclass_get_device(UCLASS_LED, 8, &dev));
+	ut_asserteq(-ENODEV, uclass_get_device(UCLASS_LED, 9, &dev));
 
 	return 0;
 }
@@ -110,6 +115,21 @@ static int dm_test_led_label(struct unit_test_state *uts)
 
 	ut_asserteq(-ENODEV, led_get_by_label("sandbox:blue", &dev));
 
+	/* Test if function, color and function-enumerator naming works */
+	ut_assertok(led_get_by_label("red:status-20", &dev));
+
+	/* Test if function, color naming works */
+	ut_assertok(led_get_by_label("green:status", &dev));
+
+	/* Test if function, without color naming works */
+	ut_assertok(led_get_by_label(":status", &dev));
+
+	/* Test if color without function naming works */
+	ut_assertok(led_get_by_label("green:", &dev));
+
+	/* Test if function, color naming is ignored if label is found */
+	ut_assertok(led_get_by_label("sandbox:function", &dev));
+
 	return 0;
 }
 DM_TEST(dm_test_led_label, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index f16b643fa3f..72f4e80f637 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -1580,7 +1580,7 @@ static int dm_test_ofnode_delete(struct unit_test_state *uts)
 	ut_assert(!ofnode_valid(node));
 	ut_assert(!ofnode_valid(ofnode_path("/leds/default_on")));
 
-	ut_asserteq(2, ofnode_get_child_count(ofnode_path("/leds")));
+	ut_asserteq(7, ofnode_get_child_count(ofnode_path("/leds")));
 
 	return 0;
 }
-- 
2.20.1

