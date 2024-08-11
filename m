Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7BDC3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B313889E0;
	Sun, 11 Aug 2024 16:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HNVgjDAe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1666E88875; Sun, 11 Aug 2024 16:52:38 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D8C2889DA
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-39728bbf949so13945175ab.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387954; x=1723992754; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RP3sjiPcGcA/mi36Kt00Rs5CQbTgbt7wjtg5MSV5d9s=;
 b=HNVgjDAe+6XV/lc9hPiGtl4yqKVBVrtv67cqepYi09u/EqdoVixp5gTQTa9WRaUDIu
 VeOUfndLjlhGIpEwFpXX00Lef43Hb1ug18bIlMbZ5PqAqzJ9Mzg6NMT7jPZo3zBpzZBI
 laHLiHfacndjK2GJn0QcGvyhUH7PcBgNjiV70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387954; x=1723992754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RP3sjiPcGcA/mi36Kt00Rs5CQbTgbt7wjtg5MSV5d9s=;
 b=HAponJE9i4KTeq04vRT+aXjFh4qUdWMBBn0DbLZyPzfiNyGwpNo5fUvenITpoWhwEO
 prsbPAyNBdFK4aO8Yki93oITUfxp/XAKJk6a8/GMPck4jnDXZz+FZlZBjnKEXo1zdw0U
 xk9/iTNOQgZYar6/I9NFDxteNCOfAdjuF/hrQC3SYvMQuB1KfTqTnO8/ymh7WHve+y8X
 ztC/cJ1OFQdEGgY0nhgF9bYlmDPvCLns6H7tRO1jrsBrwpAlFbLoo/086qoEVWErN/kL
 Tj5CmIXgXpcCHYNAVBepfF5lOkoo6qmOwPYHvHeUbMu28vrXFFYgJNT2Au9LGm/K4Qhz
 NcFA==
X-Gm-Message-State: AOJu0YyndgTyQu5BGsqk0oS/MKwhKgsCp7vauOlcDe+n8D2zrU9xEIW5
 C5XufN31Dek5bqwDVGlNrqNQLUw5iqA4vj4nvN/CqTZz/H2HlYcTqXj+mDe49aVYeuiBu0wcYe0
 =
X-Google-Smtp-Source: AGHT+IF/YD8IQ+++vKiCCjjsPqKKg7eGBPcND1o1hqaUTPV9Xb53qKJ4hOHWSlQuGW7p4yZQ6R3Tlg==
X-Received: by 2002:a92:c564:0:b0:39b:32f2:c34c with SMTP id
 e9e14a558f8ab-39b813316a7mr85153995ab.8.1723387953961; 
 Sun, 11 Aug 2024 07:52:33 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 03/40] bootstd: Add UT_TESTF_CONSOLE_REC to bootflow tests
Date: Sun, 11 Aug 2024 08:51:32 -0600
Message-Id: <20240811145209.4191404-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

