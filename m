Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B49C5320E
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 14:01:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 089F088BF2;
	Thu, 22 Aug 2024 15:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aqzptpnJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A081C88916; Thu, 22 Aug 2024 15:58:31 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA61E887BB
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-39d30f0f831so2872345ab.0
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724335107; x=1724939907; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEaLPd/Gp7a3NzzEuzRJ3GyTgsO5nKaBrYSn0WIFCbM=;
 b=aqzptpnJKNM2HpgxeUppMOpmx3IAlZ4VX2beabcbDyFhC3EeRfTGYvo5+v+l67JRXk
 KrA7yHzwfZnIb9OwXeec3s4nfQ+oHFeUQDWBAfex6e7/+RhB7GOX9tA2ZGyaJltuXVz4
 WV1sG6zem9eE5vtVosN5euHjyiXqxlXmttX1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724335107; x=1724939907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mEaLPd/Gp7a3NzzEuzRJ3GyTgsO5nKaBrYSn0WIFCbM=;
 b=eECNB8EILydbqfAwfeNCaEhiDwLNyLWIzD6tCAlsibNagwDsASjaHw2llr1lJ5Scun
 pSWb5kGbmLE08TrVnXOJvYwjmRerlfhp99L3lOEQjeravXOF1uxXWL+v23pceskZXK2b
 J4e6atO7AYU87XgQIjn7no+2O4Ro1c88qgIAK/9WY7f8+nTICOwkttEkoq1hU58y79bn
 nDqbZeF0OgwFokxtIbLjbSKOQtG5OWJ8iZ3ffuiU3NFP+hJrnBPPeClcJQi/cP6q5I1j
 wWDwoXPgTl+Ko6j8wEcpZLpLgGWDFjnwrm8sFrgg7arCzvO0DWHFrgkZfArOdLVp2MvK
 bqkA==
X-Gm-Message-State: AOJu0Yx6EqDYBg1iILzChutCkaYEPdGbUNKvkXZoOVHXlOFDkl2LLw5l
 Pe0DdXYpF/+DV3jQKyI5wlW3tTEGHo+gt5+//yIjACn1JNF48mk8vUGJ1eNdy3/iaUf79R18egU
 =
X-Google-Smtp-Source: AGHT+IGUol8p8FoPnonFttQ0xpAuUOhviTGnSELPxNdHPWodVK7XvXAtnPVJ3hEq8L/ACm5r6uITRw==
X-Received: by 2002:a05:6e02:12ef:b0:399:ed4:6e9e with SMTP id
 e9e14a558f8ab-39d74eba111mr28203105ab.17.1724335107290; 
 Thu, 22 Aug 2024 06:58:27 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e747eesm6793275ab.29.2024.08.22.06.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:58:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v2 14/19] test: dm: Use UTF_CONSOLE in tests
Date: Thu, 22 Aug 2024 07:57:59 -0600
Message-Id: <20240822135804.2375959-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135804.2375959-1-sjg@chromium.org>
References: <20240822135804.2375959-1-sjg@chromium.org>
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

Set this flag rather than doing things manually in the test.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/dm/acpi.c    | 15 ++++-----------
 test/dm/blkmap.c  |  4 +---
 test/dm/cros_ec.c | 14 ++++----------
 test/dm/host.c    |  4 +---
 test/dm/mux-cmd.c |  2 +-
 test/dm/rng.c     |  2 --
 test/dm/rtc.c     |  8 ++------
 test/dm/scmi.c    |  2 +-
 8 files changed, 14 insertions(+), 37 deletions(-)

diff --git a/test/dm/acpi.c b/test/dm/acpi.c
index 4c5f8b593c7..7ccd7f8d20a 100644
--- a/test/dm/acpi.c
+++ b/test/dm/acpi.c
@@ -389,7 +389,6 @@ static int dm_test_acpi_cmd_list(struct unit_test_state *uts)
 
 	ut_assertok(acpi_write_dev_tables(&ctx));
 
-	console_record_reset();
 	run_command("acpi list", 0);
 	ut_assert_nextline("Name              Base   Size  Detail");
 	ut_assert_nextline("----  ----------------  -----  ----------------------------");
@@ -416,7 +415,7 @@ static int dm_test_acpi_cmd_list(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_cmd_list, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_cmd_list, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Test 'acpi dump' command */
 static int dm_test_acpi_cmd_dump(struct unit_test_state *uts)
@@ -433,13 +432,11 @@ static int dm_test_acpi_cmd_dump(struct unit_test_state *uts)
 	ut_assertok(acpi_write_dev_tables(&ctx));
 
 	/* First search for a non-existent table */
-	console_record_reset();
 	run_command("acpi dump rdst", 0);
 	ut_assert_nextline("Table 'RDST' not found");
 	ut_assert_console_end();
 
 	/* Now a real table */
-	console_record_reset();
 	run_command("acpi dump dmar", 0);
 	addr = ALIGN(nomap_to_sysmem(ctx.xsdt) + sizeof(struct acpi_xsdt), 64);
 	ut_assert_nextline("DMAR @ %16lx", addr);
@@ -448,7 +445,7 @@ static int dm_test_acpi_cmd_dump(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_cmd_dump, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_cmd_dump, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Test acpi_device_path() */
 static int dm_test_acpi_device_path(struct unit_test_state *uts)
@@ -575,7 +572,6 @@ static int dm_test_acpi_cmd_items(struct unit_test_state *uts)
 	acpi_reset_items();
 	ctx.current = buf;
 	ut_assertok(acpi_fill_ssdt(&ctx));
-	console_record_reset();
 	run_command("acpi items", 0);
 	ut_assert_nextline("Seq  Type       Base   Size  Device/Writer");
 	ut_assert_nextline("---  -----  --------   ----  -------------");
@@ -586,7 +582,6 @@ static int dm_test_acpi_cmd_items(struct unit_test_state *uts)
 	acpi_reset_items();
 	ctx.current = buf;
 	ut_assertok(acpi_inject_dsdt(&ctx));
-	console_record_reset();
 	run_command("acpi items", 0);
 	ut_assert_nextlinen("Seq");
 	ut_assert_nextlinen("---");
@@ -594,7 +589,6 @@ static int dm_test_acpi_cmd_items(struct unit_test_state *uts)
 	ut_assert_nextline("  1  dsdt   %8lx      2  acpi-test2", addr + 2);
 	ut_assert_console_end();
 
-	console_record_reset();
 	run_command("acpi items -d", 0);
 	ut_assert_nextlinen("Seq");
 	ut_assert_nextlinen("---");
@@ -608,7 +602,7 @@ static int dm_test_acpi_cmd_items(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_cmd_items, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_cmd_items, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Test 'acpi set' command */
 static int dm_test_acpi_cmd_set(struct unit_test_state *uts)
@@ -619,7 +613,6 @@ static int dm_test_acpi_cmd_set(struct unit_test_state *uts)
 
 	gd_set_acpi_start(0);
 
-	console_record_reset();
 	ut_asserteq(0, gd_acpi_start());
 	ut_assertok(run_command("acpi set", 0));
 	ut_assert_nextline("ACPI pointer: 0");
@@ -646,7 +639,7 @@ static int dm_test_acpi_cmd_set(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_cmd_set, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_cmd_set, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /**
  * dm_test_write_test_table() - create test ACPI table
diff --git a/test/dm/blkmap.c b/test/dm/blkmap.c
index 7581e62df3b..a6a0b4d4e20 100644
--- a/test/dm/blkmap.c
+++ b/test/dm/blkmap.c
@@ -165,8 +165,6 @@ static int dm_test_cmd_blkmap(struct unit_test_state *uts)
 	ulong loadaddr = env_get_hex("loadaddr", 0);
 	struct udevice *dev;
 
-	console_record_reset();
-
 	ut_assertok(run_command("blkmap info", 0));
 	ut_assert_console_end();
 
@@ -197,4 +195,4 @@ static int dm_test_cmd_blkmap(struct unit_test_state *uts)
 	ut_assert_console_end();
 	return 0;
 }
-DM_TEST(dm_test_cmd_blkmap, 0);
+DM_TEST(dm_test_cmd_blkmap, UTF_CONSOLE);
diff --git a/test/dm/cros_ec.c b/test/dm/cros_ec.c
index 1108af4396c..089f6670a3f 100644
--- a/test/dm/cros_ec.c
+++ b/test/dm/cros_ec.c
@@ -38,14 +38,13 @@ static int dm_test_cros_ec_sku_id(struct unit_test_state *uts)
 	ut_asserteq(1234, cros_ec_get_sku_id(dev));
 
 	/* try the command */
-	console_record_reset();
 	ut_assertok(run_command("crosec sku", 0));
 	ut_assert_nextline("1234");
 	ut_assert_console_end();
 
 	return 0;
 }
-DM_TEST(dm_test_cros_ec_sku_id, UTF_SCAN_FDT);
+DM_TEST(dm_test_cros_ec_sku_id, UTF_SCAN_FDT | UTF_CONSOLE);
 
 static int dm_test_cros_ec_features(struct unit_test_state *uts)
 {
@@ -64,7 +63,6 @@ static int dm_test_cros_ec_features(struct unit_test_state *uts)
 	ut_asserteq(true, cros_ec_check_feature(dev, EC_FEATURE_ISH));
 
 	/* try the command */
-	console_record_reset();
 	ut_assertok(run_command("crosec features", 0));
 	ut_assert_nextline("flash");
 	ut_assert_nextline("i2c");
@@ -75,7 +73,7 @@ static int dm_test_cros_ec_features(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_cros_ec_features, UTF_SCAN_FDT);
+DM_TEST(dm_test_cros_ec_features, UTF_SCAN_FDT | UTF_CONSOLE);
 
 static int dm_test_cros_ec_switches(struct unit_test_state *uts)
 {
@@ -85,7 +83,6 @@ static int dm_test_cros_ec_switches(struct unit_test_state *uts)
 	ut_asserteq(0, cros_ec_get_switches(dev));
 
 	/* try the command */
-	console_record_reset();
 	ut_assertok(run_command("crosec switches", 0));
 	ut_assert_console_end();
 
@@ -94,14 +91,13 @@ static int dm_test_cros_ec_switches(struct unit_test_state *uts)
 	ut_asserteq(EC_SWITCH_LID_OPEN, cros_ec_get_switches(dev));
 
 	/* try the command */
-	console_record_reset();
 	ut_assertok(run_command("crosec switches", 0));
 	ut_assert_nextline("lid open");
 	ut_assert_console_end();
 
 	return 0;
 }
-DM_TEST(dm_test_cros_ec_switches, UTF_SCAN_FDT);
+DM_TEST(dm_test_cros_ec_switches, UTF_SCAN_FDT | UTF_CONSOLE);
 
 static int dm_test_cros_ec_events(struct unit_test_state *uts)
 {
@@ -113,7 +109,6 @@ static int dm_test_cros_ec_events(struct unit_test_state *uts)
 	ut_asserteq(0, events);
 
 	/* try the command */
-	console_record_reset();
 	ut_assertok(run_command("crosec events", 0));
 	ut_assert_nextline("00000000");
 	ut_assert_console_end();
@@ -124,7 +119,6 @@ static int dm_test_cros_ec_events(struct unit_test_state *uts)
 	ut_asserteq(EC_HOST_EVENT_MASK(EC_HOST_EVENT_LID_OPEN), events);
 
 	/* try the command */
-	console_record_reset();
 	ut_assertok(run_command("crosec events", 0));
 	ut_assert_nextline("00000002");
 	ut_assert_nextline("lid_open");
@@ -138,7 +132,7 @@ static int dm_test_cros_ec_events(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_cros_ec_events, UTF_SCAN_FDT);
+DM_TEST(dm_test_cros_ec_events, UTF_SCAN_FDT | UTF_CONSOLE);
 
 static int dm_test_cros_ec_vstore(struct unit_test_state *uts)
 {
diff --git a/test/dm/host.c b/test/dm/host.c
index ff6f43b3e31..f577377da6a 100644
--- a/test/dm/host.c
+++ b/test/dm/host.c
@@ -115,8 +115,6 @@ static int dm_test_cmd_host(struct unit_test_state *uts)
 	struct blk_desc *desc;
 	char fname[256];
 
-	console_record_reset();
-
 	/* first check 'host info' with binding */
 	ut_assertok(run_command("host info", 0));
 	ut_assert_nextline("dev       blocks  blksz label           path");
@@ -199,4 +197,4 @@ static int dm_test_cmd_host(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_cmd_host, UTF_SCAN_FDT);
+DM_TEST(dm_test_cmd_host, UTF_SCAN_FDT | UTF_CONSOLE);
diff --git a/test/dm/mux-cmd.c b/test/dm/mux-cmd.c
index 3aadc159ae8..6eb3b283161 100644
--- a/test/dm/mux-cmd.c
+++ b/test/dm/mux-cmd.c
@@ -109,7 +109,7 @@ static int dm_test_cmd_mux_list(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_cmd_mux_list, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+DM_TEST(dm_test_cmd_mux_list, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
 
 static int dm_test_cmd_mux_select(struct unit_test_state *uts)
 {
diff --git a/test/dm/rng.c b/test/dm/rng.c
index 8ed4e1373ea..d7ef0722ff5 100644
--- a/test/dm/rng.c
+++ b/test/dm/rng.c
@@ -33,8 +33,6 @@ static int dm_test_rng_cmd(struct unit_test_state *uts)
 	ut_assertok(uclass_get_device(UCLASS_RNG, 0, &dev));
 	ut_assertnonnull(dev);
 
-	ut_assertok(console_record_reset_enable());
-
 	run_command("rng", 0);
 	ut_assert_nextlinen("00000000:");
 	ut_assert_nextlinen("00000010:");
diff --git a/test/dm/rtc.c b/test/dm/rtc.c
index e52abbc49da..88f080b64a8 100644
--- a/test/dm/rtc.c
+++ b/test/dm/rtc.c
@@ -191,8 +191,6 @@ DM_TEST(dm_test_rtc_read_write, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 /* Test 'rtc list' command */
 static int dm_test_rtc_cmd_list(struct unit_test_state *uts)
 {
-	console_record_reset();
-
 	run_command("rtc list", 0);
 	ut_assert_nextline("RTC #0 - rtc@43");
 	ut_assert_nextline("RTC #1 - rtc@61");
@@ -200,13 +198,11 @@ static int dm_test_rtc_cmd_list(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_rtc_cmd_list, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+DM_TEST(dm_test_rtc_cmd_list, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Test 'rtc read' and 'rtc write' commands */
 static int dm_test_rtc_cmd_rw(struct unit_test_state *uts)
 {
-	console_record_reset();
-
 	run_command("rtc dev 0", 0);
 	ut_assert_nextline("RTC #0 - rtc@43");
 	ut_assert_console_end();
@@ -243,7 +239,7 @@ static int dm_test_rtc_cmd_rw(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_rtc_cmd_rw, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+DM_TEST(dm_test_rtc_cmd_rw, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Reset the time */
 static int dm_test_rtc_reset(struct unit_test_state *uts)
diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index 5c540fc0583..3655594c26d 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -281,7 +281,7 @@ static int dm_test_scmi_cmd(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_scmi_cmd, UTF_SCAN_FDT);
+DM_TEST(dm_test_scmi_cmd, UTF_SCAN_FDT | UTF_CONSOLE);
 
 static int dm_test_scmi_power_domains(struct unit_test_state *uts)
 {
-- 
2.34.1

