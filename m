Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B09C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 11:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59866801B0;
	Thu, 23 Jan 2025 12:49:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737632956;
	bh=YAr+jIGdlFlqdgrLOTMQye09Nb/6qMBKs+xRTQC6Kx8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Qfc7vrRF/muL10SJpIYey1hHj1gptLw7+7oMahMfRIzhe5Z3tgGdkTC8FssIoG3l8
	 Wkz8X/fMWN4gGhw/8BQcyOAio90YNnva4/krDCiusXgKDskO/u8hGo7QutilsUUtk4
	 yIcCqCq7AdBNHYWQEMHYIQQ+F6/5sa6ihff7Lt5kYxQ73PqzvO41gngBJVStOXwH9d
	 Kn7SgrLVygTVJxWNUuPJwB28Viqam/wI7SV9K4qR44LM2SjgYKg9NV42wPQjLYVY08
	 qR0/4WnU9kNdMfw57txDiGBDcURsnm5kz8L12J5g7xWrE9kDoDot0PtQIam1jFFMu0
	 y//tx5w/R07gg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C55BB80214; Thu, 23 Jan 2025 12:49:15 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36F7880137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 12:49:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="KmHMP6O2"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AD41710408F83; Thu, 23 Jan 2025 12:49:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737632951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YAr+jIGdlFlqdgrLOTMQye09Nb/6qMBKs+xRTQC6Kx8=;
 b=KmHMP6O2ZhHLAPhsxI3dTlhApt3fzbMY0I6Dx9dcrIK/H6hNV/isJyZk8V7uuyc1Uv+UNi
 nL9r7OErEQ/XWdeNJymVriQd/tO1rAXINzoogLgFVVZLoEoUwuD7ACBoLxQofNEekdajVt
 Sgu8+oyCLgNk/Q31EHQ2NmzjLOrJ4NtLXI60mELCB4bRojyh6dys1Hn4eTXxLA4yfeWqH8
 1NKjDbzX6AAsrfrQ0STsN4Al6rkLyaVb13Dt6M3YTyHoDuJin7stnODcK/wyHdtnlkvc4r
 c4Md7NGB185YML26t+lNLd/HviqcQ7hCMz50POPoM+c4V1tG8TPoaifMmjPjVQ==
From: Heiko Schocher <hs@denx.de>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>, Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3] led: add function naming option from linux
Date: Thu, 23 Jan 2025 12:49:06 +0100
Message-Id: <20250123114906.80724-1-hs@denx.de>
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

Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=165&view=results


Changes in v3:
- work in comment from Tom:
  remove new file include/dt-bindings/leds/common.h in this patch
  as it is already in dts/upstream/include/dt-bindings/leds/common.h
  and so the checkpatch warnings from this file are gone!
  Thanks! Good catch!
  remove file include/linux/uapi/linux/uleds.h and
  as we only need one define from it, add this define
  in include/led.h

Changes in v2:
- remove unused name variable in function led_get_label()
- rebased patch to current HEAD
  82d262ae162 ("Merge patch series "MediaTek MT7629 OF_UPSTREAM migration (v2)"")

 arch/sandbox/dts/test.dts                | 37 ++++++++++++-
 doc/device-tree-bindings/leds/common.txt | 28 ++++++++++
 drivers/led/led-uclass.c                 | 70 ++++++++++++++++++++++--
 include/led.h                            |  6 ++
 test/dm/led.c                            | 22 +++++++-
 test/dm/ofnode.c                         |  2 +-
 6 files changed, 158 insertions(+), 7 deletions(-)

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
diff --git a/include/led.h b/include/led.h
index 64247cd3a70..a67db7af38d 100644
--- a/include/led.h
+++ b/include/led.h
@@ -53,6 +53,11 @@
 
 struct udevice;
 
+/*
+ * value imported from linux:include/linux/uapi/linux/uleds.h
+ */
+#define LED_MAX_NAME_SIZE      64
+
 enum led_state_t {
 	LEDST_OFF = 0,
 	LEDST_ON = 1,
@@ -86,6 +91,7 @@ struct led_sw_blink {
 struct led_uc_plat {
 	const char *label;
 	enum led_state_t default_state;
+	char name[LED_MAX_NAME_SIZE];
 #ifdef CONFIG_LED_SW_BLINK
 	struct led_sw_blink *sw_blink;
 #endif
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

