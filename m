Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178F9C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 12:59:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 099DA88A38;
	Tue,  6 Aug 2024 14:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MrU+1N6v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2000088A1E; Tue,  6 Aug 2024 14:59:26 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EE3088A2D
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-39b06af1974so1734245ab.2
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949161; x=1723553961; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RP3sjiPcGcA/mi36Kt00Rs5CQbTgbt7wjtg5MSV5d9s=;
 b=MrU+1N6v9N5L0DZPiuxobEWpMLlea5mzGL8J2DLk1bcPfoQWRnzpOgOFFphHziGHbM
 YA0NboxqKjAgI3fZ2B0vKVv9yBdUwSesJ2z0pu983OkncSF8lGjH7xDQ2YTvlgc35pv3
 6ytRd7BIsAavOrZHAKcqlKj5HizmvJpHTMpHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949161; x=1723553961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RP3sjiPcGcA/mi36Kt00Rs5CQbTgbt7wjtg5MSV5d9s=;
 b=KXH2TdCt4kM4R+9fb6yOTwOqHx1re3oKqTFJhxBJE3x98agDqSvu9kA+51Tszt9pdy
 eZzt4Kjrto3u2gYQtffUZY5juvwpPp/i2dsMepUZETP8ow9wLZERdnmE0UoiSFP9FFAG
 CCe66Oa+voSzn2XzQg4TUpFre7eNb5a3MPcgSVrY6k6iaNdGXXChDEybsPQPFKqowbBn
 2S7n1xMZypLuJY3GdWqiZIXN0WMMdw1goN6qFhBjHBT9ck6qBXVZ1dDhU0Vn71koQyQx
 nluvCSDYxNFZPwapBr+dfszj9bYxId32uNrlL2QtcrQp69W3k6Ws0AKiO063JKrmXSfQ
 JaAA==
X-Gm-Message-State: AOJu0YyACOYBXagjet+OQpHqdJ/aszX93nRm/husTfcBc83Xyw2crzPw
 wxgSDE3D05AyEciLleJyuJlEnLPnf2NuWmEC7qw9Eeu91LEGAWnAwHUCpGw7Vc/i/PYDtItXsV0
 =
X-Google-Smtp-Source: AGHT+IGSR6xeljDlMZGE0aIz1ooU5XjvVKNvs88Vy/seCC+4dTE6P8LwFVKgkM/836WKTOnqrxkqPg==
X-Received: by 2002:a05:6e02:1389:b0:39b:3387:515b with SMTP id
 e9e14a558f8ab-39b338753ebmr137299885ab.1.1722949161281; 
 Tue, 06 Aug 2024 05:59:21 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 03/39] bootstd: Add UT_TESTF_CONSOLE_REC to bootflow tests
Date: Tue,  6 Aug 2024 06:58:14 -0600
Message-Id: <20240806125850.2316956-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

Quite a few tests use console recording without indicating this, using
the UT_TESTF_CONSOLE_REC flag. Fix this to avoid strange failures.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/boot/bootflow.c | 59 +++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 8b46256fa48..8ea091a36af 100644
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
@@ -76,14 +75,14 @@ static int bootflow_cmd(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
+	     UT_TESTF_CONSOLE_REC);
 
 /* Check 'bootflow scan' with a label / seq */
 static int bootflow_cmd_label(struct unit_test_state *uts)
 {
 	test_set_eth_enable(false);
 
-	console_record_reset_enable();
 	ut_assertok(run_command("bootflow scan -lH mmc1", 0));
 	ut_assert_nextline("Scanning for bootflows with label 'mmc1'");
 	ut_assert_skip_to_line("(1 bootflow, 1 valid)");
@@ -124,7 +123,7 @@ static int bootflow_cmd_label(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(bootflow_cmd_label, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
-	     UT_TESTF_ETH_BOOTDEV);
+	     UT_TESTF_ETH_BOOTDEV | UT_TESTF_CONSOLE_REC);
 
 /* Check 'bootflow scan/list' commands using all bootdevs */
 static int bootflow_cmd_glob(struct unit_test_state *uts)
@@ -156,14 +155,14 @@ static int bootflow_cmd_glob(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_glob, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_glob, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
+	     UT_TESTF_CONSOLE_REC);
 
 /* Check 'bootflow scan -e' */
 static int bootflow_cmd_scan_e(struct unit_test_state *uts)
 {
 	ut_assertok(bootstd_test_drop_bootdev_order(uts));
 
-	console_record_reset_enable();
 	ut_assertok(run_command("bootflow scan -aleGH", 0));
 	ut_assert_nextline("Scanning for bootflows in all bootdevs");
 	ut_assert_nextline("Seq  Method       State   Uclass    Part  Name                      Filename");
@@ -207,12 +206,12 @@ static int bootflow_cmd_scan_e(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_scan_e, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_scan_e, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
+	     UT_TESTF_CONSOLE_REC);
 
 /* Check 'bootflow info' */
 static int bootflow_cmd_info(struct unit_test_state *uts)
 {
-	console_record_reset_enable();
 	ut_assertok(run_command("bootdev select 1", 0));
 	ut_assert_console_end();
 	ut_assertok(run_command("bootflow scan", 0));
@@ -248,12 +247,12 @@ static int bootflow_cmd_info(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_info, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_info, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
+	     UT_TESTF_CONSOLE_REC);
 
 /* Check 'bootflow scan -b' to boot the first available bootdev */
 static int bootflow_scan_boot(struct unit_test_state *uts)
 {
-	console_record_reset_enable();
 	ut_assertok(inject_response(uts));
 	ut_assertok(run_command("bootflow scan -b", 0));
 	ut_assert_nextline(
@@ -270,7 +269,8 @@ static int bootflow_scan_boot(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_scan_boot, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_scan_boot, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
+	     UT_TESTF_CONSOLE_REC);
 
 /* Check iterating through available bootflows */
 static int bootflow_iter(struct unit_test_state *uts)
@@ -368,7 +368,8 @@ static int bootflow_iter(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_iter, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_iter, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
+	     UT_TESTF_CONSOLE_REC);
 
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_BOOTMETH_GLOBAL)
 /* Check using the system bootdev */
@@ -386,7 +387,6 @@ static int bootflow_system(struct unit_test_state *uts)
 
 	/* We should get a single 'bootmgr' method right at the end */
 	bootstd_clear_glob();
-	console_record_reset_enable();
 	ut_assertok(run_command("bootflow scan -lH", 0));
 	ut_assert_skip_to_line(
 		"  0  efi_mgr      ready   (none)       0  <NULL>                    ");
@@ -397,7 +397,7 @@ static int bootflow_system(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(bootflow_system, UT_TESTF_DM | UT_TESTF_SCAN_PDATA |
-	     UT_TESTF_SCAN_FDT);
+	     UT_TESTF_SCAN_FDT | UT_TESTF_CONSOLE_REC);
 #endif
 
 /* Check disabling a bootmethod if it requests it */
@@ -438,7 +438,9 @@ static int bootflow_iter_disable(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_iter_disable, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_iter_disable, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
+	     UT_TESTF_CONSOLE_REC
+);
 
 /* Check 'bootflow scan' with a bootmeth ordering including a global bootmeth */
 static int bootflow_scan_glob_bootmeth(struct unit_test_state *uts)
@@ -452,7 +454,6 @@ static int bootflow_scan_glob_bootmeth(struct unit_test_state *uts)
 	 * Make sure that the -G flag makes the scan fail, since this is not
 	 * supported when an ordering is provided
 	 */
-	console_record_reset_enable();
 	ut_assertok(bootmeth_set_order("efi firmware0"));
 	ut_assertok(run_command("bootflow scan -lGH", 0));
 	ut_assert_nextline("Scanning for bootflows in all bootdevs");
@@ -479,12 +480,13 @@ static int bootflow_scan_glob_bootmeth(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_scan_glob_bootmeth, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_scan_glob_bootmeth, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
+	     UT_TESTF_CONSOLE_REC
+);
 
 /* Check 'bootflow boot' to boot a selected bootflow */
 static int bootflow_cmd_boot(struct unit_test_state *uts)
 {
-	console_record_reset_enable();
 	ut_assertok(run_command("bootdev select 1", 0));
 	ut_assert_console_end();
 	ut_assertok(run_command("bootflow scan", 0));
@@ -508,7 +510,8 @@ static int bootflow_cmd_boot(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_boot, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_boot, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
+	     UT_TESTF_CONSOLE_REC);
 
 /**
  * prep_mmc_bootdev() - Set up an mmc bootdev so we can access other distros
@@ -675,7 +678,8 @@ static int bootflow_cmd_menu(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_menu, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_menu, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
+	     UT_TESTF_CONSOLE_REC);
 
 /* Check 'bootflow scan -m' to select a bootflow using a menu */
 static int bootflow_scan_menu(struct unit_test_state *uts)
@@ -783,7 +787,6 @@ static int bootflow_cmd_hunt_single(struct unit_test_state *uts)
 
 	ut_assertok(bootstd_test_drop_bootdev_order(uts));
 
-	console_record_reset_enable();
 	ut_assertok(run_command("bootflow scan -l mmc1", 0));
 	ut_assert_nextline("Scanning for bootflows with label 'mmc1'");
 	ut_assert_skip_to_line("(1 bootflow, 1 valid)");
@@ -794,7 +797,8 @@ static int bootflow_cmd_hunt_single(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_hunt_single, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_hunt_single, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
+	     UT_TESTF_CONSOLE_REC);
 
 /* Check searching for a uclass label using the hunters */
 static int bootflow_cmd_hunt_label(struct unit_test_state *uts)
@@ -808,7 +812,6 @@ static int bootflow_cmd_hunt_label(struct unit_test_state *uts)
 	test_set_eth_enable(false);
 	ut_assertok(bootstd_test_drop_bootdev_order(uts));
 
-	console_record_reset_enable();
 	ut_assertok(run_command("bootflow scan -l mmc", 0));
 
 	/* check that the hunter was used */
@@ -831,7 +834,8 @@ static int bootflow_cmd_hunt_label(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_hunt_label, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_hunt_label, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
+	     UT_TESTF_CONSOLE_REC);
 
 /**
  * check_font() - Check that the font size for an item matches expectations
@@ -1127,7 +1131,6 @@ static int bootflow_cmdline(struct unit_test_state *uts)
 {
 	ut_assertok(run_command("bootflow scan mmc", 0));
 	ut_assertok(run_command("bootflow sel 0", 0));
-	console_record_reset_enable();
 
 	ut_asserteq(1, run_command("bootflow cmdline get fred", 0));
 	ut_assert_nextline("Argument not found");
@@ -1157,7 +1160,7 @@ static int bootflow_cmdline(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmdline, 0);
+BOOTSTD_TEST(bootflow_cmdline, UT_TESTF_CONSOLE_REC);
 
 /* test a few special changes to a long command line */
 static int bootflow_cmdline_special(struct unit_test_state *uts)
@@ -1198,7 +1201,7 @@ static int bootflow_cros(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cros, 0);
+BOOTSTD_TEST(bootflow_cros, UT_TESTF_CONSOLE_REC);
 
 /* Test Android bootmeth  */
 static int bootflow_android(struct unit_test_state *uts)
@@ -1221,4 +1224,4 @@ static int bootflow_android(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_android, 0);
+BOOTSTD_TEST(bootflow_android, UT_TESTF_CONSOLE_REC);
-- 
2.34.1

