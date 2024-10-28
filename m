Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910CED10C0B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7017D88C53;
	Mon, 28 Oct 2024 13:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UhJri7TF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47B9C89124; Mon, 28 Oct 2024 13:42:08 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5141589138
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:42:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a998a5ca499so575706566b.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119325; x=1730724125; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jy0oA8eH1uP5JMKHEqb8QO6/dDxfOYU45o5CmJSn0LA=;
 b=UhJri7TFLOLUrVuqrFgWpppYuhbOyTjl1OBcIW/cnctjY1vPXP2ukGu6erzlCOfu+W
 vUbAy+3ATFywYF2JHrO3+DKF06olZTGcyIOI1gcyual/O/81NOKraotjXT34rgv3Kz2a
 RGMjlC4h1WlmuR1KB+NkrlvC05UQqyjv2XaRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119325; x=1730724125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jy0oA8eH1uP5JMKHEqb8QO6/dDxfOYU45o5CmJSn0LA=;
 b=TtQUtHB4nYoNNgI8LIIafg1NpxGol9f0d/qknYv0GymiKabdkGaprFBDKjdywbgkX9
 XPuAw6rShiP42NP5M7P0GHtSy/YXHGIXa6a5SWHBBwAsszlVc3g5y9J2prmXLDMZ7XEN
 aWataCrbEkcoTgDB8uEZuL42XHQH9prC5xhrtaHa3xNUgtOGSs9DJLOdp5ZJUfd4yHYy
 t4iWCr9Mm6JuKoQvoFl5ZyJ+jI2AUNz/scMjshPiMBVDfAkkBsbl1yxqRM92OHoLQuAV
 8CUmDiN1TCTi9zTgmJdyXS0ZvO0JjAYLV+bHXx5Ol7KBjUZLnc/z8k9z4s2QZrN4qUgP
 A8Fg==
X-Gm-Message-State: AOJu0YwzUDlPQX7kuhfMonYgBN8DYn8Sww/FXSSL6XksKR5C3f5+0AJk
 inHm8iIS5Arc1iBzUzMQoa2qtQ53jmxjjULwGiLU5NuqA7E+XF3qz+QeOKn8IQlkNSRdRwzr58a
 3Og==
X-Google-Smtp-Source: AGHT+IEklSOvnNOlVqBoxCzMnVa1JSBLb1eBhqZJOvdFspTzn+sNcJCBSGWvIi79srSa0ngEAqHnTQ==
X-Received: by 2002:a17:907:3daa:b0:a9a:861:5d9f with SMTP id
 a640c23a62f3a-a9de619f9cdmr743146666b.40.1730119325239; 
 Mon, 28 Oct 2024 05:42:05 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:42:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 18/21] test: Move time tests into the lib suite
Date: Mon, 28 Oct 2024 13:41:23 +0100
Message-ID: <20241028124130.32072-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124130.32072-1-sjg@chromium.org>
References: <20241028124130.32072-1-sjg@chromium.org>
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

There is no particular need for the time tests to have their own test
command. Move them into the lib suite instead.

Update the test functions to match the normal unit-test signature.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd_ut.c   |  6 ------
 test/lib/time.c | 29 ++++++++++-------------------
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index ef4f0ac607e..5d440a964e1 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -99,9 +99,6 @@ static struct cmd_tbl cmd_ut_sub[] = {
 	U_BOOT_CMD_MKENT(setexpr, CONFIG_SYS_MAXARGS, 1, do_ut_setexpr, "",
 			 ""),
 #endif
-#ifdef CONFIG_UT_TIME
-	U_BOOT_CMD_MKENT(time, CONFIG_SYS_MAXARGS, 1, do_ut_time, "", ""),
-#endif
 #ifdef CONFIG_MEASURED_BOOT
 	U_BOOT_CMD_MKENT(measurement, CONFIG_SYS_MAXARGS, 1, do_ut_measurement,
 			 "", ""),
@@ -233,9 +230,6 @@ U_BOOT_LONGHELP(ut,
 	"\nsetexpr - setexpr command"
 #ifdef CONFIG_CMD_SEAMA
 	"\nseama - seama command parameters loading and decoding"
-#endif
-#ifdef CONFIG_UT_TIME
-	"\ntime - very basic test of time functions"
 #endif
 	);
 
diff --git a/test/lib/time.c b/test/lib/time.c
index 149c4b58f4a..2095bef7589 100644
--- a/test/lib/time.c
+++ b/test/lib/time.c
@@ -4,12 +4,13 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <command.h>
 #include <errno.h>
 #include <time.h>
 #include <linux/delay.h>
+#include <test/lib.h>
+#include <test/ut.h>
 
-static int test_get_timer(void)
+static int test_get_timer(struct unit_test_state *uts)
 {
 	ulong base, start, next, diff;
 	int iter;
@@ -42,8 +43,9 @@ static int test_get_timer(void)
 
 	return 0;
 }
+LIB_TEST(test_get_timer, 0);
 
-static int test_timer_get_us(void)
+static int test_timer_get_us(struct unit_test_state *uts)
 {
 	ulong prev, next, min = 1000000;
 	long delta;
@@ -76,8 +78,9 @@ static int test_timer_get_us(void)
 
 	return 0;
 }
+LIB_TEST(test_timer_get_us, 0);
 
-static int test_time_comparison(void)
+static int test_time_comparison(struct unit_test_state *uts)
 {
 	ulong start_us, end_us, delta_us;
 	long error;
@@ -97,8 +100,9 @@ static int test_time_comparison(void)
 
 	return 0;
 }
+LIB_TEST(test_time_comparison, 0);
 
-static int test_udelay(void)
+static int test_udelay(struct unit_test_state *uts)
 {
 	long error;
 	ulong start, delta;
@@ -116,17 +120,4 @@ static int test_udelay(void)
 
 	return 0;
 }
-
-int do_ut_time(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	int ret = 0;
-
-	ret |= test_get_timer();
-	ret |= test_timer_get_us();
-	ret |= test_time_comparison();
-	ret |= test_udelay();
-
-	printf("Test %s\n", ret ? "failed" : "passed");
-
-	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
-}
+LIB_TEST(test_udelay, 0);
-- 
2.43.0

