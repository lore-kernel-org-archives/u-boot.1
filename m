Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB67D3C931
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 11:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CF1C8910A;
	Sun, 10 Nov 2024 12:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OMa5UAkW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 954AE89170; Sun, 10 Nov 2024 12:51:41 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8CA589110
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 12:51:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso45698075e9.0
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 03:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731239499; x=1731844299; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pRU2vygyWXfpZrJcW3c8ojIH7/oPWUzHhkPQ3zdbEh8=;
 b=OMa5UAkWNYtTpsiZKsZsXOxePOgBivIJYmOKFEK33OrS7ObFYskhhfkjfQ+jtqmtlt
 zHSnAUBSFxQM0h6Eg0xfuzW3b5TwHEXkH2CfuydKJAqhDs0FDO8WLNOIgYBA2p+VVTNo
 i7u4B/hQX2LD7YDRwu/oiB7owamzfbg72zGxoBffTrY1MYhe4OYr6aR8QdV+d6i898Lv
 TJMDnC9XDR8Doe0G6XjstN0SezqsdF8NQp1R7DSJMO9GQLLplp88fBg78Js1FQHnGVmy
 ntbwElMHWf0x0x3OnB+6lQPpxxe+KbXPcUQMO/bGx5t20O9pno0ROfMfr7CLz760gpJT
 AE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731239499; x=1731844299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRU2vygyWXfpZrJcW3c8ojIH7/oPWUzHhkPQ3zdbEh8=;
 b=ezQeskOStJJLnKIjM4XGUyf6+mcLlQ1+vtJLvWhkYMZyhOSz9bXsUh4y2FB38vs+z9
 WOI/fcYpevMaTtxnx/NLUzcSuAhmR7QsKUPhXC3fMXuDhjX2mwdKVIxPXW2LsqCpGcgl
 /zKrKEiqE0LAHhYl22bSwFTrAOsTo/wCd3LHhzHCoV/ZkV4D9jCeEqMIfl5UzvQBA5eV
 ForhdPbEcYWS1qtju/Xv6cQQRt+Y2xu1jBVzJxKV9W/+sleZg5aEh71mN0lR3LuoLkzN
 Ckk1mFHQL8e2GTY5vJN/ihwFQkHXo85uFjRQ31t63CSxOncN7r8k4bYR211ltfy65Ugm
 OxGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYM6j9R2hP/lh/bAqNTMSaUnKP/sqGnrG8Xkp4otFWe0bHxZbyiUd8vr8YY1QJF/RKRY7i4N4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6vUHrbHNQ6JHw4p6cNn2DR2x5Y4f5HMFOa+wrzPbg3OZ3UNNA
 oabxHDNolbaTS9xBcHZh3vxWSgGS5zPhfEMEEOnZjL8asVUENQBZ
X-Google-Smtp-Source: AGHT+IESxCEgplpjCVx6t4nD5VDHWCy3sodD4VLxvukjND3QA/LmM2uaOT89WrEggfChiRcPpnu/qw==
X-Received: by 2002:a05:600c:4f4a:b0:431:9a26:3cf6 with SMTP id
 5b1f17b1804b1-432b74fed4amr101817685e9.4.1731239498929; 
 Sun, 10 Nov 2024 03:51:38 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5fb1sm181423745e9.8.2024.11.10.03.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Nov 2024 03:51:38 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH v2 8/8] test: dm: Update test for LED activity and boot
Date: Sun, 10 Nov 2024 12:50:27 +0100
Message-ID: <20241110115054.2555-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110115054.2555-1-ansuelsmth@gmail.com>
References: <20241110115054.2555-1-ansuelsmth@gmail.com>
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

Update test for LED activity and boot to follow new implementation with
property set to the LED node phandle.

Also update a copy-paste error in the function name for the activity
tests and actually enable the test with the DM_TEST macro.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/sandbox/dts/test.dts |  8 ++++----
 test/dm/led.c             | 18 +++++++++++-------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 1ffa64a43e2..e9b3b151e10 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -101,8 +101,8 @@
 			bootscr-ram-offset = /bits/ 64 <0x12345678>;
 			bootscr-flash-offset = /bits/ 64 <0>;
 			bootscr-flash-size = /bits/ 64 <0x2000>;
-			boot-led = "sandbox:green";
-			activity-led = "sandbox:red";
+			boot-led = <&sandbox_led_green>;
+			activity-led = <&sandbox_led_red>;
 			testing-bool;
 			testing-int = <123>;
 			testing-str = "testing";
@@ -988,12 +988,12 @@
 	leds {
 		compatible = "gpio-leds";
 
-		iracibble {
+		sandbox_led_red: iracibble {
 			gpios = <&gpio_a 1 0>;
 			label = "sandbox:red";
 		};
 
-		martinet {
+		sandbox_led_green: martinet {
 			gpios = <&gpio_a 2 0>;
 			label = "sandbox:green";
 		};
diff --git a/test/dm/led.c b/test/dm/led.c
index 884f6410b70..e5b86326c3a 100644
--- a/test/dm/led.c
+++ b/test/dm/led.c
@@ -144,7 +144,7 @@ static int dm_test_led_boot(struct unit_test_state *uts)
 {
 	struct udevice *dev
 
-	/* options/u-boot/boot-led is set to "sandbox:green" */
+	/* options/u-boot/boot-led is set to phandle to "sandbox:green" */
 	ut_assertok(led_get_by_label("sandbox:green", &dev));
 	ut_asserteq(LEDST_OFF, led_get_state(dev));
 	ut_assertok(led_boot_on());
@@ -154,14 +154,15 @@ static int dm_test_led_boot(struct unit_test_state *uts)
 
 	return 0;
 }
+DM_TEST(dm_test_led_boot, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test LED boot blink fallback */
 #ifndef CONFIG_LED_BLINK
-static int dm_test_led_boot(struct unit_test_state *uts)
+static int dm_test_led_boot_blink(struct unit_test_state *uts)
 {
 	struct udevice *dev
 
-	/* options/u-boot/boot-led is set to "sandbox:green" */
+	/* options/u-boot/boot-led is set to phandle to "sandbox:green" */
 	ut_assertok(led_get_by_label("sandbox:green", &dev));
 	ut_asserteq(LEDST_OFF, led_get_state(dev));
 	ut_assertok(led_boot_blink());
@@ -171,16 +172,17 @@ static int dm_test_led_boot(struct unit_test_state *uts)
 
 	return 0;
 }
+DM_TEST(dm_test_led_boot_blink, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 #endif
 #endif
 
 /* Test LED activity */
 #ifdef CONFIG_LED_ACTIVITY
-static int dm_test_led_boot(struct unit_test_state *uts)
+static int dm_test_led_activity(struct unit_test_state *uts)
 {
 	struct udevice *dev
 
-	/* options/u-boot/activity-led is set to "sandbox:red" */
+	/* options/u-boot/activity-led is set to phandle to "sandbox:red" */
 	ut_assertok(led_get_by_label("sandbox:red", &dev));
 	ut_asserteq(LEDST_OFF, led_get_state(dev));
 	ut_assertok(led_activity_on());
@@ -190,14 +192,15 @@ static int dm_test_led_boot(struct unit_test_state *uts)
 
 	return 0;
 }
+DM_TEST(dm_test_led_activity, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test LED activity blink fallback */
 #ifndef CONFIG_LED_BLINK
-static int dm_test_led_boot(struct unit_test_state *uts)
+static int dm_test_led_activityt_blink(struct unit_test_state *uts)
 {
 	struct udevice *dev
 
-	/* options/u-boot/activity-led is set to "sandbox:red" */
+	/* options/u-boot/activity-led is set to phandle to "sandbox:red" */
 	ut_assertok(led_get_by_label("sandbox:red", &dev));
 	ut_asserteq(LEDST_OFF, led_get_state(dev));
 	ut_assertok(led_activity_blink());
@@ -207,5 +210,6 @@ static int dm_test_led_boot(struct unit_test_state *uts)
 
 	return 0;
 }
+DM_TEST(dm_test_led_activityt_blink, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 #endif
 #endif
-- 
2.45.2

