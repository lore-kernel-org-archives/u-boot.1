Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C5CF3ED4A
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 01:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FF48841DF;
	Sun, 12 Apr 2026 03:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W9fyOSNQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FF9C841DF; Sun, 12 Apr 2026 03:35:36 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C22F48421E
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 03:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d7fdb922a5so2721610a34.3
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 18:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775957729; x=1776562529; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=slbemFJ7O+Voa8j6kAVyUnqzR7AbnVylkHFvQnaQjlM=;
 b=W9fyOSNQ5kL6WA4ZHubw4XzPySpUbR6XQsCzHE+UT14fBJxWdBursWGtNnDxAQwQOU
 POXlaOh+J2+7/2IwzG9Z19Zq8aw5la6YMLUzAqC9qlZVvaZMC4+A54LfM3AM+Shj5JFS
 dhPZDykATAVPOGz5r2vJ77ZtDBfyKDgxaRYvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775957729; x=1776562529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=slbemFJ7O+Voa8j6kAVyUnqzR7AbnVylkHFvQnaQjlM=;
 b=AqzRqnEYaHL/taNQICkt9gphbCsW8OfXnZPmFjzqkRhSGmVG6+XzcF0no4XsnLDNWa
 6mHmUJRw7e/LnA4sPvPsd/6hO883wgPZM26JhQnZKDkbtvuvXkxjQ45juOzF4rjAdAa4
 XBzU5vDzbsielx5iGnWp8o/cTGIH/YX4AOE1aAWk8kkR8ksUitokMUQ4EuB/8CEXAyWK
 8gwGVQrZdjfu/2gv4WA27WcRmFGWk962JjI6CRb1+aUjNtfP2PPDwJLceeNm0vjlpmlU
 p4ogUzoGD6kCKSubyVG3m4A6K88zBMW0Z4Y0ktYHM0j10jK+SQMXjcjfVvdonNrJeGeZ
 F9QQ==
X-Gm-Message-State: AOJu0YxNGDrO7r4VYlJx4IuI2PZxkzGeOZkXO0KudYug+CsPN1p5NWXy
 ZPHglFW6vkQ6G7p1ZDH1tgpEJvg7XZtuiGVe4AnntG/jYKjn9WBY4rgCpXEUY+gmhqxMH2yvxFv
 dfv5gKg==
X-Gm-Gg: AeBDievkOEihknF0/CFlmljGBQecBQszSOQ/mLOAq83zXEDLbEldiV1XwgchFPuSIvb
 wB4m1dxq7BxWVa4egwFDcD7WC0nja7t77v5BDPij3jYj2q8QziO9DvmY6H7iAsrAzkarj0vQXbt
 ZRcfANjl4bGenCyb9dA5i5vl7a9iUZZmFwCLW9YvbZHl+RL1VXCooMS537fbAZlTC7ajVjYx6/L
 m8kZtUaR3srH0oKfLuRHMSJIXQo9SQVWlPiiefCqAcw6SO8g2/xxsWtLUbSfEF0u3HOaqcT88O0
 D9mKHCTwLNcbz1p2kNM0TTdiqtcUJLYIPONa7rLLn9SNdjkA33OaNpoQWOrv/yvWeXq3T2lmGkG
 aajmQ1ZBTBkbsaXLUpSZuaQUucyiXRbisusGlioc9TCIicjLNJNTVBcV8T1jL/MEt6gDoG9OfKi
 t2tGD1TnphmVqpPFFT0A==
X-Received: by 2002:a05:6830:b83:b0:7d7:ccd6:3cd4 with SMTP id
 46e09a7af769-7dc27e2d3f6mr5371678a34.23.1775957729472; 
 Sat, 11 Apr 2026 18:35:29 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2d1aca3asm4242826a34.6.2026.04.11.18.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 18:35:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <simon.glass@canonical.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 07/12] test: Enhance the ut command to pass test arguments
Date: Sat, 11 Apr 2026 19:34:35 -0600
Message-ID: <20260412013451.2929001-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412013451.2929001-1-sjg@chromium.org>
References: <20260412013451.2929001-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Update the ut command to permit passing arguments to tests.

Usage: ut -f fs test_name key1=value1 key2=value2

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

