Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB02FC02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4943280771;
	Mon, 20 Jan 2025 22:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fUj89SFy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5C9280A4E; Mon, 20 Jan 2025 22:27:35 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48BC5807B6
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3ce7a33ea70so18173925ab.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408451; x=1738013251; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Um04ziKz7LKI0WbyW+HZA2f0/agqCSmvNQPY+JeYN1s=;
 b=fUj89SFyeph0ocHK38ELJVPJTOkvRiNNoiils4GTE8v/K29GD6stIUCjUTFFauAuSZ
 ukMFzA8jVNrntetWJhp6c8BFOpk5eBdvf3zYuq0y8MXqtaPX8VfgD6TfUdgwqKyuGzmh
 MPq/uDE9tOTSq3g9HW5yvV1DbzSnC2+IqpnRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408451; x=1738013251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Um04ziKz7LKI0WbyW+HZA2f0/agqCSmvNQPY+JeYN1s=;
 b=XtSq6OvWYKSxeCmguaMwh1cqOrUX7atPoXcw3Ni0c+fnswwsq9sjSKu20ZJ9FPUx4T
 5dTYoYeDuzMAWmsFE7U4nTUMnWjFuQLKE22IFZ67SYnBDPLp5laZfn6s2gVMY5B1mPNd
 dSfhTu0BkLp2m/mx0Y/D2wXFmfiMkHCAlCKKt25XX8MdvCdr1XcmH20+bK9GL7adtMRo
 LbGoNX/vKG1VRde5nDdI/gIHmk/ENgoRsWG0XIeYXwyotTB+jnjyfG17nK0QnLuTB2k1
 MXxIt+xofkj6IG379COwW3n7N28za8tDhLfjss4cRiTUYsjUfbmcZ4WdDfmjlD7F5I/6
 LQVA==
X-Gm-Message-State: AOJu0YxYMzFsiZwI+itIrTI+B98Te3JCFRrHn8bIigXnesyfnqpiGPPJ
 DTu4kcO620c6B+CxGmAf/irE0bD6ueRm7cL0PhU70WSznICdsxw6iyuD4z9p249CssgM1ZxmoAA
 =
X-Gm-Gg: ASbGncuMrixTlPWv81zj7sQ6T2cvb/IwIvxbzfvcrXfasUA809NmYu6vJvDByQv/KLO
 uwh92fmp9MIsJlARis/wABZp3r/vGxRD/BkTuzfMJGKineG3E1DRs2holhuHJmwmTIFEo6PmzeT
 0OLvLSYwNPqk7/JUBhv0JXkrswAfIB33zegVPOKB94VE9iw9SwuN+jZRohjJlX2c4vSvh5JsHJT
 8b4KhEwsRHSew5fAgtoFX0x2kCic4xU2izWDuQVlYUMR2CnL/g739m0R0NNUYBS5Hgut9WqYagH
 RLWTsKL1SkjIkqkHFQfeQ/1bmvsJxLI=
X-Google-Smtp-Source: AGHT+IF927aQS9bBwy7t8KCDXPCYFT9VNNuhKu14rcnaZc7nhNCRUyTXLxxO3lE4U2Jdh1c5l2HnBQ==
X-Received: by 2002:a05:6e02:1947:b0:3a7:e701:bd1b with SMTP id
 e9e14a558f8ab-3cf744bf421mr101731975ab.20.1737408451450; 
 Mon, 20 Jan 2025 13:27:31 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 35/44] test: Drop conditional compilation for suites
Date: Mon, 20 Jan 2025 14:25:57 -0700
Message-ID: <20250120212613.516664-36-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
References: <20250120212613.516664-1-sjg@chromium.org>
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

This is not needed anymore. If a test suite is not built, then it will
have no linker-list entries. So we can just check for that and know that
the suite is not present.

This allows removal of the #ifdefs and the need to keep them in sync
with the associated Makefile rules, which has actually failed, since the
help does not match what commands are actually present.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Show a message when a suite is not compiled in

 test/cmd_ut.c               | 81 +++++++++++++++++--------------------
 test/py/tests/test_suite.py | 11 ++++-
 2 files changed, 45 insertions(+), 47 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 181cdb43152..16490e00ab3 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -120,78 +120,55 @@ SUITE_DECL(seama);
 SUITE_DECL(upl);
 
 static struct suite suites[] = {
-#ifdef CONFIG_CMD_BDI
 	SUITE(bdinfo),
-#endif
 #ifdef CONFIG_UT_BOOTSTD
 	SUITE_CMD(bootstd, do_ut_bootstd),
 #endif
-#ifdef CONFIG_CMDLINE
 	SUITE(cmd),
-#endif
 	SUITE(common),
-#if defined(CONFIG_UT_DM)
 	SUITE(dm),
-#endif
-#if defined(CONFIG_UT_ENV)
 	SUITE(env),
-#endif
 	SUITE(exit),
-#ifdef CONFIG_CMD_FDT
 	SUITE(fdt),
-#endif
-#ifdef CONFIG_CONSOLE_TRUETYPE
 	SUITE(font),
-#endif
 #ifdef CONFIG_UT_OPTEE
 	SUITE_CMD(optee, do_ut_optee),
 #endif
 #ifdef CONFIG_UT_OVERLAY
 	SUITE_CMD(overlay, do_ut_overlay),
 #endif
-#ifdef CONFIG_UT_LIB
 	SUITE(lib),
-#endif
-#ifdef CONFIG_UT_LOG
 	SUITE(log),
-#endif
-#if defined(CONFIG_SANDBOX) && defined(CONFIG_CMD_MBR) && defined(CONFIG_CMD_MMC) \
-        && defined(CONFIG_MMC_SANDBOX) && defined(CONFIG_MMC_WRITE)
 	SUITE(mbr),
-#endif
 	SUITE(mem),
-#if defined(CONFIG_SANDBOX) && defined(CONFIG_CMD_SETEXPR)
 	SUITE(setexpr),
-#endif
-#ifdef CONFIG_MEASURED_BOOT
 	SUITE(measurement),
-#endif
-#ifdef CONFIG_SANDBOX
-#if CONFIG_IS_ENABLED(BLOBLIST)
 	SUITE(bloblist),
 	SUITE(bootm),
-#endif
-#endif
-#ifdef CONFIG_CMD_ADDRMAP
 	SUITE(addrmap),
-#endif
-#if CONFIG_IS_ENABLED(HUSH_PARSER)
 	SUITE(hush),
-#endif
-#ifdef CONFIG_CMD_LOADM
 	SUITE(loadm),
-#endif
-#ifdef CONFIG_CMD_PCI_MPS
 	SUITE(pci_mps),
-#endif
-#ifdef CONFIG_CMD_SEAMA
 	SUITE(seama),
-#endif
-#ifdef CONFIG_CMD_UPL
 	SUITE(upl),
-#endif
 };
 
+/**
+ * has_tests() - Check if a suite has tests, i.e. is supported in this build
+ *
+ * If the suite is run using a command, we have to assume that tests may be
+ * present, since we have no visibility
+ *
+ * @ste: Suite to check
+ * Return: true if supported, false if not
+ */
+static bool has_tests(struct suite *ste)
+{
+	int n_ents = ste->end - ste->start;
+
+	return n_ents || ste->cmd;
+}
+
 /** run_suite() - Run a suite of tests */
 static int run_suite(struct suite *ste, struct cmd_tbl *cmdtp, int flag,
 		     int argc, char *const argv[])
@@ -224,10 +201,12 @@ static int do_ut_all(struct cmd_tbl *cmdtp, int flag, int argc,
 		struct suite *ste = &suites[i];
 		char *const argv[] = {(char *)ste->name, NULL};
 
-		printf("----Running %s tests----\n", ste->name);
-		retval = run_suite(ste, cmdtp, flag, 1, argv);
-		if (!any_fail)
-			any_fail = retval;
+		if (has_tests(ste)) {
+			printf("----Running %s tests----\n", ste->name);
+			retval = run_suite(ste, cmdtp, flag, 1, argv);
+			if (!any_fail)
+				any_fail = retval;
+		}
 	}
 
 	return any_fail;
@@ -236,9 +215,17 @@ static int do_ut_all(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
+	int suite_count, i;
 	const char *flags;
 
-	printf("Test suites: %d\n", (int)ARRAY_SIZE(suites));
+	for (suite_count = 0, i = 0; i < ARRAY_SIZE(suites); i++) {
+		struct suite *ste = &suites[i];
+
+		if (has_tests(ste))
+			suite_count++;
+	}
+
+	printf("Test suites: %d\n", suite_count);
 	printf("Total tests: %d\n", (int)UNIT_TEST_ALL_COUNT());
 
 	flags = cmd_arg1(argc, argv);
@@ -253,7 +240,7 @@ static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 
 			if (n_ent)
 				printf("%5ld  %s\n", n_ent, ste->name);
-			else
+			else if (ste->cmd)
 				printf("%5s  %s\n", "?", ste->name);
 		}
 	}
@@ -297,6 +284,10 @@ static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		if (!ste) {
 			printf("Suite '%s' not found\n", argv[0]);
 			return CMD_RET_FAILURE;
+		} else if (!has_tests(ste)) {
+			/* perhaps a Kconfig option needs to be set? */
+			printf("Suite '%s' is not enabled\n", argv[0]);
+			return CMD_RET_FAILURE;
 		}
 
 		ret = run_suite(ste, cmdtp, flag, argc, argv);
diff --git a/test/py/tests/test_suite.py b/test/py/tests/test_suite.py
index 20cdf022536..a4d7391ce5f 100644
--- a/test/py/tests/test_suite.py
+++ b/test/py/tests/test_suite.py
@@ -128,7 +128,7 @@ def process_ut_info(cons, output):
 @pytest.mark.buildconfigspec('sandbox')
 @pytest.mark.notbuildconfigspec('sandbox_spl')
 @pytest.mark.notbuildconfigspec('sandbox64')
-def test_suite(u_boot_console):
+def test_suite(u_boot_console, u_boot_config):
     """Perform various checks on the unit tests, including:
 
        - The number of suites matches that reported by the 'ut info'
@@ -141,6 +141,7 @@ def test_suite(u_boot_console):
 
     """
     cons = u_boot_console
+    buildconfig = u_boot_config.buildconfig
     with cons.log.section('Run all unit tests'):
         # ut hush hush_test_simple_dollar prints "Unknown command" on purpose.
         with u_boot_console.disable_check('unknown_command'):
@@ -154,7 +155,13 @@ def test_suite(u_boot_console):
     cons.log.info(f'extra {extra}')
 
     # Make sure we got a test count for each suite
-    assert suites - exp_test_count.keys() == set()
+    assert not (suites - exp_test_count.keys())
+
+    # Deal with missing suites
+    with cons.log.section('Check missing suites'):
+        if 'config_cmd_seama' not in buildconfig:
+            cons.log.info("CMD_SEAMA not enabled: Ignoring suite 'seama'")
+            missing.discard('seama')
 
     # Run 'ut info' and compare with the log results
     with cons.log.section('Check suite test-counts'):
-- 
2.43.0

