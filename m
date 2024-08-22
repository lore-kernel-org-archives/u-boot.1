Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CFDC3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 14:00:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F394788BCE;
	Thu, 22 Aug 2024 15:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fAU8oq9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE18388BB6; Thu, 22 Aug 2024 15:58:26 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 158A688113
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-39d2f638050so2954985ab.3
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724335103; x=1724939903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yQSUyCkBfHZyORlwvBBxGiB1jWfkqCkxZ6jYDozf/Rg=;
 b=fAU8oq9TfJKeG3a07uirimB/ve1Wo5MbUrGVIvokyk71wl16UyqieZAxKgh81lecqD
 QcytySbqF5VnaKVOt8qR2QdDF17QJ7f7t/tCMMdfBLlOKQr51MjVU2Vy3Aen3O8Z0aZK
 lc5o9gqiQo2p8zOpW3EQy0fdl9GvKwS1hlUDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724335103; x=1724939903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yQSUyCkBfHZyORlwvBBxGiB1jWfkqCkxZ6jYDozf/Rg=;
 b=Y512uju/oTgrRR7czqDrc5KcYQeINCzr6hgk8yJDwRtdnULOvFZTFM8go0Igq6tOqS
 kW2RVMDBk/BO+kMkbXbAb5UjCNGyyihuoASD8GK1SOMMZRF1XCJh8nwMd1m43mTSrfQE
 RkbhsGQlwrznH4z3XfjjTP2pYdbD7wn4EpPqs6Xl4219ekkaM5h6S5OrVtfCPn8LLc+v
 xDVEOB8wkrubqTFePbZvEM1/9GY1sLwWH+5ibGC22ICSl9e6JAgUItnUYAE2fvxULS5N
 vzlE71ow5jCmBss/H1CDSM/Vhk0ARleA69SZ+YpyYGJp2M7G8ONRidT8kH3zGfN8/KiR
 lfWg==
X-Gm-Message-State: AOJu0YxHjE0P9nig9jw/9X8loSgAuDMdJTmgPLRSMKHRfjzLfK6sQ5aG
 F+SWHyD/B1fhhXxHAfhS8NZ7L8ffh5xZ9ilkOE+uQw+lvNI0y+Y0Sy9e5wbVMsjMIWqX+XxsnqY
 =
X-Google-Smtp-Source: AGHT+IHhb6j259cmp3kDPzjz2jBZxNu581bV38gB8XyJ1xV5EcyYg1UkOWW4oRoEUavTgbUD2sVKtw==
X-Received: by 2002:a05:6e02:1887:b0:375:9e3f:5f6 with SMTP id
 e9e14a558f8ab-39d74b5582amr27479885ab.6.1724335102486; 
 Thu, 22 Aug 2024 06:58:22 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e747eesm6793275ab.29.2024.08.22.06.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:58:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 09/19] test: boot: Use UTF_CONSOLE in tests
Date: Thu, 22 Aug 2024 07:57:54 -0600
Message-Id: <20240822135804.2375959-10-sjg@chromium.org>
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

Drop unnecessary calls to console_record_reset_enable()

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

(no changes since v1)

 test/boot/bootdev.c  | 31 ++++++++++----------------
 test/boot/bootflow.c | 53 ++++++++++++++++++--------------------------
 test/boot/bootmeth.c | 12 ++++------
 test/boot/cedit.c    | 13 ++++-------
 test/boot/expo.c     |  3 +--
 5 files changed, 42 insertions(+), 70 deletions(-)

diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 9a364d0f267..23ebc61ff52 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -28,7 +28,6 @@ static int bootdev_test_cmd_list(struct unit_test_state *uts)
 {
 	int probed;
 
-	console_record_reset_enable();
 	for (probed = 0; probed < 2; probed++) {
 		int probe_ch = probed ? '+' : ' ';
 
@@ -49,7 +48,7 @@ static int bootdev_test_cmd_list(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_cmd_list, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootdev_test_cmd_list, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Check 'bootdev select' and 'info' commands */
 static int bootdev_test_cmd_select(struct unit_test_state *uts)
@@ -59,7 +58,6 @@ static int bootdev_test_cmd_select(struct unit_test_state *uts)
 	/* get access to the CLI's cur_bootdev */
 	ut_assertok(bootstd_get_priv(&std));
 
-	console_record_reset_enable();
 	ut_asserteq(1, run_command("bootdev info", 0));
 	ut_assert_nextlinen("Please use");
 	ut_assert_console_end();
@@ -99,7 +97,7 @@ static int bootdev_test_cmd_select(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_cmd_select, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootdev_test_cmd_select, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Check bootdev labels */
 static int bootdev_test_labels(struct unit_test_state *uts)
@@ -157,7 +155,6 @@ static int bootdev_test_any(struct unit_test_state *uts)
 	 * 9   [ + ]      OK  mmc       mmc1.bootdev
 	 * a   [   ]      OK  mmc       mmc0.bootdev
 	 */
-	console_record_reset_enable();
 	ut_assertok(bootdev_find_by_any("8", &dev, &mflags));
 	ut_asserteq(UCLASS_BOOTDEV, device_get_uclass_id(dev));
 	ut_asserteq(BOOTFLOW_METHF_SINGLE_DEV, mflags);
@@ -185,7 +182,8 @@ static int bootdev_test_any(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_any, UTF_DM | UTF_SCAN_FDT | UTF_ETH_BOOTDEV);
+BOOTSTD_TEST(bootdev_test_any, UTF_DM | UTF_SCAN_FDT | UTF_ETH_BOOTDEV |
+	     UTF_CONSOLE);
 
 /*
  * Check bootdev ordering with the bootdev-order property and boot_targets
@@ -321,7 +319,6 @@ static int bootdev_test_prio(struct unit_test_state *uts)
 	ut_assertok(bootstd_test_drop_bootdev_order(uts));
 
 	/* 3 MMC and 3 USB bootdevs: MMC should come before USB */
-	console_record_reset_enable();
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
 	ut_asserteq(6, iter.num_devs);
@@ -361,7 +358,6 @@ static int bootdev_test_hunter(struct unit_test_state *uts)
 	/* get access to the used hunters */
 	ut_assertok(bootstd_get_priv(&std));
 
-	console_record_reset_enable();
 	bootdev_list_hunters(std);
 	ut_assert_nextline("Prio  Used  Uclass           Hunter");
 	ut_assert_nextlinen("----");
@@ -388,7 +384,7 @@ static int bootdev_test_hunter(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_hunter, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootdev_test_hunter, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Check 'bootdev hunt' command */
 static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
@@ -401,7 +397,6 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 	/* get access to the used hunters */
 	ut_assertok(bootstd_get_priv(&std));
 
-	console_record_reset_enable();
 	ut_assertok(run_command("bootdev hunt -l", 0));
 	ut_assert_nextline("Prio  Used  Uclass           Hunter");
 	ut_assert_nextlinen("----");
@@ -462,7 +457,8 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_cmd_hunt, UTF_DM | UTF_SCAN_FDT | UTF_ETH_BOOTDEV);
+BOOTSTD_TEST(bootdev_test_cmd_hunt, UTF_DM | UTF_SCAN_FDT | UTF_ETH_BOOTDEV |
+	     UTF_CONSOLE);
 
 /* Check searching for bootdevs using the hunters */
 static int bootdev_test_hunt_scan(struct unit_test_state *uts)
@@ -527,7 +523,6 @@ static int bootdev_test_hunt_prio(struct unit_test_state *uts)
 	usb_started = false;
 	test_set_skip_delays(true);
 
-	console_record_reset_enable();
 	ut_assertok(bootdev_hunt_prio(BOOTDEVP_4_SCAN_FAST, false));
 	ut_assert_nextline("scanning bus for devices...");
 	ut_assert_skip_to_line("            Type: Hard Disk");
@@ -544,7 +539,7 @@ static int bootdev_test_hunt_prio(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_hunt_prio, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootdev_test_hunt_prio, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Check hunting for bootdevs with a particular label */
 static int bootdev_test_hunt_label(struct unit_test_state *uts)
@@ -559,7 +554,6 @@ static int bootdev_test_hunt_label(struct unit_test_state *uts)
 	ut_assertok(bootstd_get_priv(&std));
 
 	/* scan an unknown uclass */
-	console_record_reset_enable();
 	old = (void *)&mflags;   /* arbitrary pointer to check against dev */
 	dev = old;
 	mflags = 123;
@@ -597,7 +591,7 @@ static int bootdev_test_hunt_label(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_hunt_label, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootdev_test_hunt_label, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Check iterating to the next label in a list */
 static int bootdev_test_next_label(struct unit_test_state *uts)
@@ -624,7 +618,6 @@ static int bootdev_test_next_label(struct unit_test_state *uts)
 	dev = NULL;
 	mflags = 123;
 	ut_assertok(bootdev_next_label(&iter, &dev, &mflags));
-	console_record_reset_enable();
 	ut_assert_console_end();
 	ut_assertnonnull(dev);
 	ut_asserteq_str("mmc0.bootdev", dev->name);
@@ -675,7 +668,7 @@ static int bootdev_test_next_label(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(bootdev_test_next_label, UTF_DM | UTF_SCAN_FDT | UTF_ETH_BOOTDEV |
-	     UTF_SF_BOOTDEV);
+	     UTF_SF_BOOTDEV | UTF_CONSOLE);
 
 /* Check iterating to the next prioirty in a list */
 static int bootdev_test_next_prio(struct unit_test_state *uts)
@@ -700,7 +693,6 @@ static int bootdev_test_next_prio(struct unit_test_state *uts)
 	iter.flags = BOOTFLOWIF_SHOW;
 
 	dev = NULL;
-	console_record_reset_enable();
 	ut_assertok(bootdev_next_prio(&iter, &dev));
 	ut_assertnonnull(dev);
 	ut_asserteq_str("mmc2.bootdev", dev->name);
@@ -759,4 +751,5 @@ static int bootdev_test_next_prio(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_next_prio, UTF_DM | UTF_SCAN_FDT | UTF_SF_BOOTDEV);
+BOOTSTD_TEST(bootdev_test_next_prio, UTF_DM | UTF_SCAN_FDT | UTF_SF_BOOTDEV |
+	     UTF_CONSOLE);
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index f53e20e4c86..6ad63afe90a 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -50,7 +50,6 @@ static int inject_response(struct unit_test_state *uts)
 /* Check 'bootflow scan/list' commands */
 static int bootflow_cmd(struct unit_test_state *uts)
 {
-	console_record_reset_enable();
 	ut_assertok(run_command("bootdev select 1", 0));
 	ut_assert_console_end();
 	ut_assertok(run_command("bootflow scan -lH", 0));
@@ -76,14 +75,13 @@ static int bootflow_cmd(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Check 'bootflow scan' with a label / seq */
 static int bootflow_cmd_label(struct unit_test_state *uts)
 {
 	test_set_eth_enable(false);
 
-	console_record_reset_enable();
 	ut_assertok(run_command("bootflow scan -lH mmc1", 0));
 	ut_assert_nextline("Scanning for bootflows with label 'mmc1'");
 	ut_assert_skip_to_line("(1 bootflow, 1 valid)");
@@ -123,14 +121,14 @@ static int bootflow_cmd_label(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_label, UTF_DM | UTF_SCAN_FDT | UTF_ETH_BOOTDEV);
+BOOTSTD_TEST(bootflow_cmd_label, UTF_DM | UTF_SCAN_FDT | UTF_ETH_BOOTDEV |
+	     UTF_CONSOLE);
 
 /* Check 'bootflow scan/list' commands using all bootdevs */
 static int bootflow_cmd_glob(struct unit_test_state *uts)
 {
 	ut_assertok(bootstd_test_drop_bootdev_order(uts));
 
-	console_record_reset_enable();
 	ut_assertok(run_command("bootflow scan -lGH", 0));
 	ut_assert_nextline("Scanning for bootflows in all bootdevs");
 	ut_assert_nextline("Seq  Method       State   Uclass    Part  Name                      Filename");
@@ -155,14 +153,13 @@ static int bootflow_cmd_glob(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_glob, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_glob, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Check 'bootflow scan -e' */
 static int bootflow_cmd_scan_e(struct unit_test_state *uts)
 {
 	ut_assertok(bootstd_test_drop_bootdev_order(uts));
 
-	console_record_reset_enable();
 	ut_assertok(run_command("bootflow scan -aleGH", 0));
 	ut_assert_nextline("Scanning for bootflows in all bootdevs");
 	ut_assert_nextline("Seq  Method       State   Uclass    Part  Name                      Filename");
@@ -206,12 +203,11 @@ static int bootflow_cmd_scan_e(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_scan_e, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_scan_e, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Check 'bootflow info' */
 static int bootflow_cmd_info(struct unit_test_state *uts)
 {
-	console_record_reset_enable();
 	ut_assertok(run_command("bootdev select 1", 0));
 	ut_assert_console_end();
 	ut_assertok(run_command("bootflow scan", 0));
@@ -247,12 +243,11 @@ static int bootflow_cmd_info(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_info, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_info, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Check 'bootflow scan -b' to boot the first available bootdev */
 static int bootflow_scan_boot(struct unit_test_state *uts)
 {
-	console_record_reset_enable();
 	ut_assertok(inject_response(uts));
 	ut_assertok(run_command("bootflow scan -b", 0));
 	ut_assert_nextline(
@@ -269,7 +264,7 @@ static int bootflow_scan_boot(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_scan_boot, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_scan_boot, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Check iterating through available bootflows */
 static int bootflow_iter(struct unit_test_state *uts)
@@ -385,7 +380,6 @@ static int bootflow_system(struct unit_test_state *uts)
 
 	/* We should get a single 'bootmgr' method right at the end */
 	bootstd_clear_glob();
-	console_record_reset_enable();
 	ut_assertok(run_command("bootflow scan -lH", 0));
 	ut_assert_skip_to_line(
 		"  0  efi_mgr      ready   (none)       0  <NULL>                    ");
@@ -395,7 +389,8 @@ static int bootflow_system(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_system, UTF_DM | UTF_SCAN_PDATA | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_system, UTF_DM | UTF_SCAN_PDATA | UTF_SCAN_FDT |
+	     UTF_CONSOLE);
 #endif
 
 /* Check disabling a bootmethod if it requests it */
@@ -414,7 +409,6 @@ static int bootflow_iter_disable(struct unit_test_state *uts)
 	ut_assertok(bootstd_test_drop_bootdev_order(uts));
 
 	bootstd_clear_glob();
-	console_record_reset_enable();
 	ut_assertok(inject_response(uts));
 	ut_assertok(run_command("bootflow scan -lbH", 0));
 
@@ -436,7 +430,7 @@ static int bootflow_iter_disable(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_iter_disable, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_iter_disable, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Check 'bootflow scan' with a bootmeth ordering including a global bootmeth */
 static int bootflow_scan_glob_bootmeth(struct unit_test_state *uts)
@@ -450,7 +444,6 @@ static int bootflow_scan_glob_bootmeth(struct unit_test_state *uts)
 	 * Make sure that the -G flag makes the scan fail, since this is not
 	 * supported when an ordering is provided
 	 */
-	console_record_reset_enable();
 	ut_assertok(bootmeth_set_order("efi firmware0"));
 	ut_assertok(run_command("bootflow scan -lGH", 0));
 	ut_assert_nextline("Scanning for bootflows in all bootdevs");
@@ -477,12 +470,12 @@ static int bootflow_scan_glob_bootmeth(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_scan_glob_bootmeth, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_scan_glob_bootmeth, UTF_DM | UTF_SCAN_FDT |
+	     UTF_CONSOLE);
 
 /* Check 'bootflow boot' to boot a selected bootflow */
 static int bootflow_cmd_boot(struct unit_test_state *uts)
 {
-	console_record_reset_enable();
 	ut_assertok(run_command("bootdev select 1", 0));
 	ut_assert_console_end();
 	ut_assertok(run_command("bootflow scan", 0));
@@ -506,7 +499,7 @@ static int bootflow_cmd_boot(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_boot, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_boot, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /**
  * prep_mmc_bootdev() - Set up an mmc bootdev so we can access other distros
@@ -583,7 +576,6 @@ static int scan_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
 
 	ut_assertok(prep_mmc_bootdev(uts, mmc_dev, bind_cros, &old_order));
 
-	console_record_reset_enable();
 	ut_assertok(run_command("bootflow scan", 0));
 	ut_assert_console_end();
 
@@ -611,7 +603,6 @@ static int scan_mmc_android_bootdev(struct unit_test_state *uts, const char *mmc
 
 	ut_assertok(prep_mmc_bootdev(uts, mmc_dev, true, &old_order));
 
-	console_record_reset_enable();
 	ut_assertok(run_command("bootflow scan", 0));
 	/* Android bootflow might print one or two 'ANDROID:*' logs */
 	ut_check_skipline(uts);
@@ -673,7 +664,7 @@ static int bootflow_cmd_menu(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_menu, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_menu, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Check 'bootflow scan -m' to select a bootflow using a menu */
 static int bootflow_scan_menu(struct unit_test_state *uts)
@@ -779,7 +770,6 @@ static int bootflow_cmd_hunt_single(struct unit_test_state *uts)
 
 	ut_assertok(bootstd_test_drop_bootdev_order(uts));
 
-	console_record_reset_enable();
 	ut_assertok(run_command("bootflow scan -l mmc1", 0));
 	ut_assert_nextline("Scanning for bootflows with label 'mmc1'");
 	ut_assert_skip_to_line("(1 bootflow, 1 valid)");
@@ -790,7 +780,8 @@ static int bootflow_cmd_hunt_single(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_hunt_single, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_hunt_single, UTF_DM | UTF_SCAN_FDT |
+	     UTF_CONSOLE);
 
 /* Check searching for a uclass label using the hunters */
 static int bootflow_cmd_hunt_label(struct unit_test_state *uts)
@@ -804,7 +795,6 @@ static int bootflow_cmd_hunt_label(struct unit_test_state *uts)
 	test_set_eth_enable(false);
 	ut_assertok(bootstd_test_drop_bootdev_order(uts));
 
-	console_record_reset_enable();
 	ut_assertok(run_command("bootflow scan -l mmc", 0));
 
 	/* check that the hunter was used */
@@ -827,7 +817,7 @@ static int bootflow_cmd_hunt_label(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_hunt_label, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_hunt_label, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /**
  * check_font() - Check that the font size for an item matches expectations
@@ -887,7 +877,7 @@ static int bootflow_menu_theme(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_menu_theme, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_menu_theme, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /**
  * check_arg() - Check both the normal case and the buffer-overflow case
@@ -1123,7 +1113,6 @@ static int bootflow_cmdline(struct unit_test_state *uts)
 {
 	ut_assertok(run_command("bootflow scan mmc", 0));
 	ut_assertok(run_command("bootflow sel 0", 0));
-	console_record_reset_enable();
 
 	ut_asserteq(1, run_command("bootflow cmdline get fred", 0));
 	ut_assert_nextline("Argument not found");
@@ -1151,7 +1140,7 @@ static int bootflow_cmdline(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmdline, 0);
+BOOTSTD_TEST(bootflow_cmdline, UTF_CONSOLE);
 
 /* test a few special changes to a long command line */
 static int bootflow_cmdline_special(struct unit_test_state *uts)
@@ -1192,7 +1181,7 @@ static int bootflow_cros(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cros, 0);
+BOOTSTD_TEST(bootflow_cros, UTF_CONSOLE);
 
 /* Test Android bootmeth  */
 static int bootflow_android(struct unit_test_state *uts)
@@ -1215,4 +1204,4 @@ static int bootflow_android(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_android, 0);
+BOOTSTD_TEST(bootflow_android, UTF_CONSOLE);
diff --git a/test/boot/bootmeth.c b/test/boot/bootmeth.c
index ae133cdb423..518d99c4a27 100644
--- a/test/boot/bootmeth.c
+++ b/test/boot/bootmeth.c
@@ -16,7 +16,6 @@
 /* Check 'bootmeth list' command */
 static int bootmeth_cmd_list(struct unit_test_state *uts)
 {
-	console_record_reset_enable();
 	ut_assertok(run_command("bootmeth list", 0));
 	ut_assert_nextline("Order  Seq  Name                Description");
 	ut_assert_nextlinen("---");
@@ -31,13 +30,12 @@ static int bootmeth_cmd_list(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootmeth_cmd_list, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootmeth_cmd_list, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Check 'bootmeth order' command */
 static int bootmeth_cmd_order(struct unit_test_state *uts)
 {
 	/* Select just one bootmethod */
-	console_record_reset_enable();
 	ut_assertok(run_command("bootmeth order extlinux", 0));
 	ut_assert_console_end();
 	ut_assertnonnull(env_get("bootmeths"));
@@ -104,7 +102,7 @@ static int bootmeth_cmd_order(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootmeth_cmd_order, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootmeth_cmd_order, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Check 'bootmeth order' command with global bootmeths */
 static int bootmeth_cmd_order_glob(struct unit_test_state *uts)
@@ -112,7 +110,6 @@ static int bootmeth_cmd_order_glob(struct unit_test_state *uts)
 	if (!IS_ENABLED(CONFIG_BOOTMETH_GLOBAL))
 		return -EAGAIN;
 
-	console_record_reset_enable();
 	ut_assertok(run_command("bootmeth order \"efi firmware0\"", 0));
 	ut_assert_console_end();
 	ut_assertok(run_command("bootmeth list", 0));
@@ -128,7 +125,7 @@ static int bootmeth_cmd_order_glob(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootmeth_cmd_order_glob, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootmeth_cmd_order_glob, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Check 'bootmeths' env var */
 static int bootmeth_env(struct unit_test_state *uts)
@@ -138,7 +135,6 @@ static int bootmeth_env(struct unit_test_state *uts)
 	ut_assertok(bootstd_get_priv(&std));
 
 	/* Select just one bootmethod */
-	console_record_reset_enable();
 	ut_assertok(env_set("bootmeths", "extlinux"));
 	ut_asserteq(1, std->bootmeth_count);
 
@@ -154,7 +150,7 @@ static int bootmeth_env(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootmeth_env, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootmeth_env, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Check the get_state_desc() method */
 static int bootmeth_state(struct unit_test_state *uts)
diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index fd19da0a0c0..1f7af8e5d79 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -25,8 +25,6 @@ static int cedit_base(struct unit_test_state *uts)
 
 	ut_assertok(run_command("cedit load hostfs - cedit.dtb", 0));
 
-	console_record_reset_enable();
-
 	/*
 	 * ^N  Move down to second menu
 	 * ^M  Open menu
@@ -52,7 +50,7 @@ static int cedit_base(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(cedit_base, 0);
+BOOTSTD_TEST(cedit_base, UTF_CONSOLE);
 
 /* Check the cedit write_fdt and read_fdt commands */
 static int cedit_fdt(struct unit_test_state *uts)
@@ -70,7 +68,6 @@ static int cedit_fdt(struct unit_test_state *uts)
 	void *fdt;
 	int i;
 
-	console_record_reset_enable();
 	ut_assertok(run_command("cedit load hostfs - cedit.dtb", 0));
 
 	ut_asserteq(ID_SCENE1, cedit_prepare(cur_exp, &vid_priv, &scn));
@@ -122,7 +119,7 @@ static int cedit_fdt(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(cedit_fdt, 0);
+BOOTSTD_TEST(cedit_fdt, UTF_CONSOLE);
 
 /* Check the cedit write_env and read_env commands */
 static int cedit_env(struct unit_test_state *uts)
@@ -134,7 +131,6 @@ static int cedit_env(struct unit_test_state *uts)
 	struct scene *scn;
 	char *str;
 
-	console_record_reset_enable();
 	ut_assertok(run_command("cedit load hostfs - cedit.dtb", 0));
 
 	ut_asserteq(ID_SCENE1, cedit_prepare(cur_exp, &vid_priv, &scn));
@@ -177,7 +173,7 @@ static int cedit_env(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(cedit_env, 0);
+BOOTSTD_TEST(cedit_env, UTF_CONSOLE);
 
 /* Check the cedit write_cmos and read_cmos commands */
 static int cedit_cmos(struct unit_test_state *uts)
@@ -187,7 +183,6 @@ static int cedit_cmos(struct unit_test_state *uts)
 	extern struct expo *cur_exp;
 	struct scene *scn;
 
-	console_record_reset_enable();
 	ut_assertok(run_command("cedit load hostfs - cedit.dtb", 0));
 
 	ut_asserteq(ID_SCENE1, cedit_prepare(cur_exp, &vid_priv, &scn));
@@ -218,4 +213,4 @@ static int cedit_cmos(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(cedit_cmos, 0);
+BOOTSTD_TEST(cedit_cmos, UTF_CONSOLE);
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 3fe06a4436e..4b24f504e21 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -445,7 +445,6 @@ static int expo_render_image(struct unit_test_state *uts)
 	struct expo *exp;
 	int id;
 
-	console_record_reset_enable();
 	ut_assertok(uclass_first_device_err(UCLASS_VIDEO, &dev));
 
 	ut_assertok(expo_new(EXPO_NAME, NULL, &exp));
@@ -633,7 +632,7 @@ static int expo_render_image(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(expo_render_image, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(expo_render_image, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 /* Check building an expo from a devicetree description */
 static int expo_test_build(struct unit_test_state *uts)
-- 
2.34.1

