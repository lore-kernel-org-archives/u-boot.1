Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F2EE937E1
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 11:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CB118422D;
	Sun, 12 Apr 2026 13:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NQvaymgT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B09E984228; Sun, 12 Apr 2026 13:24:24 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B0D784214
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 13:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-464bba3a9easo1805698b6e.0
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 04:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775993060; x=1776597860; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Z63gjZp9n81K5hzsJNahmRxfr5j060cy+fJAISrWL8=;
 b=NQvaymgT3oBJ7RYzM90tkX5/B7x7nwLhhCIN5GS5LULvtvSX/iNHCkG1D3RcaqO/h2
 lRNfsxWaKQxSHlhmtKyRWAXQ0cRxolas8Sxq6+5ROGDyJzDtXFyetIxwVy9Kp6bGjw5v
 ai0OeO6LqIxsrujbONrNFm5gTVEOLIyb6pu30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775993060; x=1776597860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Z63gjZp9n81K5hzsJNahmRxfr5j060cy+fJAISrWL8=;
 b=EXtVjJnGgbqXofQH0bJaPoMin1U2XoF0jLg/8H9BszLgt+ZglYJJyzYMBCECxoZVDL
 oq123cX331g7H0FYZTHsmYaW3s1urMxSbqH+FcB5MODQShOghFNfeizVCWgHJpS+mE1s
 wdyuC+oXWbWkU8CIM2gxu2KL/NZt9URediOsq13C2H7iJPGEuLjSBriM0taaF15nYYQ0
 jlPmbMUrQhotDxaa0llIuDeOXLPM/snNG3xSgNunbmlu2jK3plWvdv6PhKLO1BwwOMlK
 xpzRNIOpq8g69kkfTiCHC66XlHLJ+R/ATEEAo7IqOS3R5vQcjlHTOs2nnJdb+JrBsrf4
 r1oQ==
X-Gm-Message-State: AOJu0YxZDalVojasrVBFCqvbPRbcE9CSdM1VLpnQZd9Ghw7f8BLEWZVY
 OniT3vz3OErHY1baU/hJaAb9LexbgI07dm+RnMy+Hf6vY/oh90RNRxqxSWNkJYO6P/YgMa7c+hy
 BWibdhQ==
X-Gm-Gg: AeBDieveafdvnUocmX6ku5t+yxBkycPWAWRzdOW9aly1DD+Axo7x9b842cRQWHWgwTc
 XaPs+M3h/wIeRAbIrctkd5gSVkYLWtscAzi1aAajnmNzgAkmI19xvFFTQXznod/3WiC2cMOTMGT
 mojBQ/M27afp/7NseK3BDvBTYpQSq5F1LEu0YHjs62JlzjcaolF5VRlYPCfL6xuoHgba8TFW8Bw
 JxZTr+rZ+Pu4HDoHqCJh/8na85O2bUIXLBrlN+aKh5laBCjXLGfnMjooavyK3gOqU63kT8o+dw9
 uKJT4+SJQNH+DBwKLSVXlUTmR5UcazmL/Uv5qI7hJJrZmiOD08gPlCVGOfINCZ/uEeD9UZhAR9k
 1jEmfFbplZP/Vg9IuTMdzjiUqOAWweBumB1JLGTjk9sshFd5vx+MJnn+gOkXOhR0GVWCTfLCyvI
 qgvSkHsCUh0cRig4FQbw==
X-Received: by 2002:a05:6808:180a:b0:467:e4b3:3bef with SMTP id
 5614622812f47-478a080e17cmr4770501b6e.48.1775993060246; 
 Sun, 12 Apr 2026 04:24:20 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd395606sm6622071fac.1.2026.04.12.04.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 04:24:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 07/12] test: Enhance the ut command to pass test arguments
Date: Sun, 12 Apr 2026 05:19:44 -0600
Message-ID: <20260412111958.943933-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412111958.943933-1-sjg@chromium.org>
References: <20260412111958.943933-1-sjg@chromium.org>
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

Update the ut command to permit passing arguments to tests.

Usage: ut -f fs test_name key1=value1 key2=value2

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/usage/cmd/ut.rst | 11 ++++++++++-
 test/cmd_ut.c        | 29 ++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/doc/usage/cmd/ut.rst b/doc/usage/cmd/ut.rst
index 1acf3126680..d8c3cbf496c 100644
--- a/doc/usage/cmd/ut.rst
+++ b/doc/usage/cmd/ut.rst
@@ -11,7 +11,7 @@ Synopsis
 
 ::
 
-    ut [-r<runs>] [-f] [-I<n>:<one_test>] [-r<n>] [<suite> | 'all' [<test>]]
+    ut [-r<runs>] [-f] [-I<n>:<one_test>] [<suite> | all [<test>]] [<args>...]
     ut [-s] info
 
 Description
@@ -37,6 +37,11 @@ test
     causes another test to fail. If the one test fails, testing stops
     immediately.
 
+args
+    Optional arguments to pass to the test, in `name=value` format. These are
+    used by tests declared with `UNIT_TEST_ARGS()` which define expected
+    argument names and types.
+
 Typically the command is run on :ref:`arch/sandbox/sandbox:sandbox` since it
 includes a near-complete set of emulators, no code-size limits, many CONFIG
 options enabled and runs easily in CI without needing QEMU. It is also possible
@@ -201,3 +206,7 @@ Run a selection of three suites::
     Tests run: 10, 12 ms, average: 1 ms, failures: 0
     Suites run: 3, total tests run: 37, 26 ms, average: 0 ms, failures: 0
     Average test time: 0 ms, worst case 'mem' took 1 ms
+
+Run a test with arguments (used by tests declared with UNIT_TEST_ARGS)::
+
+    => ut -f fs fs_test_ls_norun fs_type=ext4 fs_image=/tmp/img small=1MB.file
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 7304c32bec5..9d36bd5dc87 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -30,7 +30,7 @@ struct suite {
 
 static int do_ut_all(struct unit_test_state *uts, const char *select_name,
 		     int runs_per_test, bool force_run,
-		     const char *test_insert);
+		     const char *test_insert, int argc, char *const argv[]);
 
 static int do_ut_info(bool show_suites);
 
@@ -120,7 +120,7 @@ static bool has_tests(struct suite *ste)
 /** run_suite() - Run a suite of tests */
 static int run_suite(struct unit_test_state *uts, struct suite *ste,
 		     const char *select_name, int runs_per_test, bool force_run,
-		     const char *test_insert)
+		     const char *test_insert, int argc, char *const argv[])
 {
 	int n_ents = ste->end - ste->start;
 	char prefix[30];
@@ -131,7 +131,7 @@ static int run_suite(struct unit_test_state *uts, struct suite *ste,
 
 	ret = ut_run_list(uts, ste->name, prefix, ste->start, n_ents,
 			  select_name, runs_per_test, force_run, test_insert,
-			  0, NULL);
+			  argc, argv);
 
 	return ret;
 }
@@ -167,7 +167,8 @@ static void update_stats(struct unit_test_state *uts, const struct suite *ste)
 }
 
 static int do_ut_all(struct unit_test_state *uts, const char *select_name,
-		     int runs_per_test, bool force_run, const char *test_insert)
+		     int runs_per_test, bool force_run, const char *test_insert,
+		     int argc, char *const argv[])
 {
 	int i;
 	int retval;
@@ -179,7 +180,7 @@ static int do_ut_all(struct unit_test_state *uts, const char *select_name,
 		if (has_tests(ste)) {
 			printf("----Running %s tests----\n", ste->name);
 			retval = run_suite(uts, ste, select_name, runs_per_test,
-					   force_run, test_insert);
+					   force_run, test_insert, argc, argv);
 			if (!any_fail)
 				any_fail = retval;
 			update_stats(uts, ste);
@@ -244,6 +245,8 @@ static struct suite *find_suite(const char *name)
 static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	const char *test_insert = NULL, *select_name;
+	int test_argc;
+	char *const *test_argv;
 	struct unit_test_state uts;
 	bool show_suites = false;
 	bool force_run = false;
@@ -285,9 +288,14 @@ static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	ut_init_state(&uts);
 	name = argv[0];
 	select_name = cmd_arg1(argc, argv);
+
+	/* Test arguments are after suite name and test name */
+	test_argc = argc > 2 ? argc - 2 : 0;
+	test_argv = argc > 2 ? argv + 2 : NULL;
+
 	if (!strcmp(name, "all")) {
 		ret = do_ut_all(&uts, select_name, runs_per_text, force_run,
-				test_insert);
+				test_insert, test_argc, test_argv);
 	} else if (!strcmp(name, "info")) {
 		ret = do_ut_info(show_suites);
 	} else {
@@ -306,7 +314,8 @@ static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			}
 
 			ret = run_suite(&uts, ste, select_name, runs_per_text,
-					force_run, test_insert);
+					force_run, test_insert, test_argc,
+					test_argv);
 			if (!any_fail)
 				any_fail = ret;
 			update_stats(&uts, ste);
@@ -322,12 +331,14 @@ static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 }
 
 U_BOOT_LONGHELP(ut,
-	"[-rs] [-f] [-I<n>:<one_test>][<suites>] - run unit tests\n"
+	"[-rs] [-f] [-I<n>:<one_test>] <suite> [<test> [<args>...]] - run unit tests\n"
 	"   -r<runs>   Number of times to run each test\n"
 	"   -f         Force 'manual' tests to run as well\n"
 	"   -I         Test to run after <n> other tests have run\n"
 	"   -s         Show all suites with ut info\n"
-	"   <suites>   Comma-separated list of suites to run\n"
+	"   <suite>    Test suite to run (or comma-separated list)\n"
+	"   <test>     Specific test to run (optional)\n"
+	"   <args>     Test arguments as key=value pairs (optional)\n"
 	"\n"
 	"Options for <suite>:\n"
 	"all       - execute all enabled tests\n"
-- 
2.43.0

