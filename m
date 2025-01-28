Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D496FC0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 13:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A0E081E92;
	Tue, 28 Jan 2025 14:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738072384;
	bh=Mj0vcpwn5slbDPEbtvIYzsj+BknJHl2uD7/vxXzCM8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DC+DHIvgJiaZyRjn+vOSYHGP7HYdvpFh7pT18PLMgFtTmEoLAmaSjeMQcC3udV1M8
	 A2WP4jUD4w+qrTpTsYho9IjGqCWFkQHjdEL0XFDmWdc1P0CM0cL5PTM7xWkw8h65TX
	 B8QkCmCx1JR3whQ3y+QZSOmEw8G5Xoma3dVYJm1GxNrj6KA5XQpktGFdsSNGueWWMW
	 S9h5nuDYuxYDbJfPWUZg1wA2e98mqg4dLc+KYlRtIqW7nqwq7RghOPgxCAlb+b9RAe
	 KCy2/jOo0psdX/PkVZpCrg+PWqxrmY5dbXCk8pWqCAwcyyk2+RJ4AR4QrlzYVGhK53
	 tjra7lM0cHZsA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FB3281E8C; Tue, 28 Jan 2025 14:53:03 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F1DE81E1F
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 14:52:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="S9B+Ofx1"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 956FC10382D0E; Tue, 28 Jan 2025 14:52:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738072376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mj0vcpwn5slbDPEbtvIYzsj+BknJHl2uD7/vxXzCM8g=;
 b=S9B+Ofx1nB5gUAXM8ivC2G3D9O+xfmPk4kiHYD1wcr961GU/e3vgo3FcR6jOA04lb5iK1Q
 ca2o75Z9LrQca7ndNkdHM+xzGABCBtDSWiEwMRHToFlBvlnbRRbdezR4RPhx/KkuV+rRdp
 VPUG1nYdHmOfH3AvyKtaDyjMRA9/ExgTBMAo3qgenuamJZDQg/WgAiffrA/LDBlg37Z4tK
 9mi9Uj0v5XQR3Jz/igloZBxndjkLZssI0B4SYyo0AlgvlLYd/SN4SUNdBBaWQwjQtzJdJu
 ntjvC3APgSNeS4tg5ZFRcDkWdSAmp7yMfyL9yn7WocrB1SuKc7fRIekUiAmHYQ==
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
Subject: [PATCH v4 2/2] led: add function naming option from linux
Date: Tue, 28 Jan 2025 14:52:46 +0100
Message-Id: <20250128135246.74838-3-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250128135246.74838-1-hs@denx.de>
References: <20250128135246.74838-1-hs@denx.de>
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

The led name is created in led_post_bind() and we need some
storage place for it. Currently this patch prevents to use
malloc() instead it stores the name in new member :

        char name[LED_MAX_NAME_SIZE];

of struct led_uc_plat. While at it append led tests for the
new feature.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

Changes in v4:
- remove ./doc/device-tree-bindings/leds/common.txt in
  seperate patch as this is now already in
  ./dts/upstream/Bindings/leds/common.txt
  as Tom commented.
  measured size impact of patch "led: add function naming option from linux":
        $ ./u-boot-size-test.sh capricorn_cxg3 --branch led-mainline
        [...]
           aarch64: (for 1/1 boards) all +886.0 rodata +230.0 text +656.0
                    capricorn_cxg3 : all +886 rodata +230 text +656
                       u-boot: add: 1/0, grow: 1/0 bytes: 416/0 (416)
                         function                                   old     new   delta
                         led_post_bind                              220     516    +296
                         led_colors                                   -     120    +120
        $ ./u-boot-size-test.sh aristainetos2c --branch led-mainline
        [...]
        01: Merge patch series "add the support of sha256_hmac and sha256_hkdf"
        40: led: add function naming option from linux
               arm: (for 2/2 boards) all +557.0 bss +20.0 rodata +161.0 text +376.0
                    aristainetos2c : all +557 bss +20 rodata +161 text +376
                       u-boot: add: 1/0, grow: 1/0 bytes: 264/0 (264)
                         function                                   old     new   delta
                         led_post_bind                              128     332    +204
                         led_colors                                   -      60     +60
                    aristainetos2ccslb: all +557 bss +20 rodata +161 text +376
                       u-boot: add: 1/0, grow: 1/0 bytes: 264/0 (264)
                         function                                   old     new   delta
                         led_post_bind                              128     332    +204
                         led_colors                                   -      60     +60
- rebase to current HEAD
  d8a7100d658. ("Subtree merge tag 'v6.13-dts' of dts repo [1] into dts/upstream")

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

 arch/sandbox/dts/test.dts | 37 ++++++++++++++++++++-
 drivers/led/led-uclass.c  | 70 ++++++++++++++++++++++++++++++++++++---
 include/led.h             |  6 ++++
 test/dm/led.c             | 22 +++++++++++-
 test/dm/ofnode.c          |  2 +-
 5 files changed, 130 insertions(+), 7 deletions(-)

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
index 4a23a3ca38c..cc8b444ff9a 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -1599,7 +1599,7 @@ static int dm_test_ofnode_delete(struct unit_test_state *uts)
 	ut_assert(!ofnode_valid(node));
 	ut_assert(!ofnode_valid(ofnode_path("/leds/default_on")));
 
-	ut_asserteq(2, ofnode_get_child_count(ofnode_path("/leds")));
+	ut_asserteq(7, ofnode_get_child_count(ofnode_path("/leds")));
 
 	return 0;
 }
-- 
2.20.1

