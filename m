Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3E6C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A80798083E;
	Mon, 20 Jan 2025 22:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sfsd0F4q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D0C980A38; Mon, 20 Jan 2025 22:54:43 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A4B680A29
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3ce88909991so17148075ab.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410078; x=1738014878; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUG0ylnzGwcK6zirkwA9nphcdJ5Pb6ESHj88tavjvkk=;
 b=Sfsd0F4qGypAlKpw+IE2Hi6ERA7QZUNQRHrFqgg9g02m5MdgV98VFmKtWP77Kz8J1q
 7g2RQ4ZoSFRVqgwHFRs8D9AfyWamC9kXpxL7SgrruUwzdAG1IYTC00ukxalQqGu/3SJi
 6ufgXx9F//wEE6tzMirwHDXKhP6VFskULZ/P4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410078; x=1738014878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RUG0ylnzGwcK6zirkwA9nphcdJ5Pb6ESHj88tavjvkk=;
 b=bN/fBKdO4goVDkVinzAhTggk2g3imPRnhpj5RzG+V0c5hX8ATQekjT4R+mjGEaq3xb
 3c7MT4JehL+j00RTTX6C3++P8vrMNSlNPQirniSmOENMFq+qFVtHlbHXmHzqRdNt5CJt
 YX2V9RwGv1j5zpNa28ufDbrAT7hVphpae+VMkljO/oPUjXGlGeG9HwYvliA6K0wInFIT
 bEPSiRZlorQx4OghYrcU5Pu0sVzKPWxdVBbHimxi3GYJyhc06PRdOHK1Ds+7Qa6rkW/s
 7ucArzSM+jbq4uGbSeIyw7mL0bofaDvTmn+nYQaRiAZQt+dwx7PdgKt1pB2PYDJ9EWb6
 djIg==
X-Gm-Message-State: AOJu0YzwEpug4g5ev8TTTXVf5NDcBIr6lFfcsKx8FacC27yhgbn6LLEm
 XDeVV4Fb7IoHvEfN4NwEj74sRbpflNCG9o7H7f5IsjuN8s+A3RdVgiBR+ZxCY4Du3TSruk9WkHM
 =
X-Gm-Gg: ASbGnctn3agwHXdZIPrBWK3bwP+srDr7Wj/koDCWza7btK6tnyDETwA4YcaKqqxxbMo
 rSrlcqfviGpI9rJi74ayhoYiaYmbfQQmv0vYXCdDVbgdh0DRf40hcd4X/snFNASloqa4OMEqBjV
 ObOO+Xm/fBt9OdSTVRfSe57+HfkK86zM0t7ofH5Mi9pw4UZExIXC0WGnv0PKTafEnNlbJdRJ69j
 f7ky49vc08tyup/t59SueWHoIbvhWp8GDe7xr0QG9ulhm5BK4yoIOnNudEd7yvSzs6O9olCT/z3
 1dXJUC6PpBECjegUyzoAXtjAlmRyuyI=
X-Google-Smtp-Source: AGHT+IFPfoYxqB61Kn7WouupJRjYV865aiKQeFbSbhuGkBiOuJUI8MDMLY7jwtMLJoTOtc2GjYip+g==
X-Received: by 2002:a92:d785:0:b0:3cf:6ea9:9c0f with SMTP id
 e9e14a558f8ab-3cf6ea99ce7mr119427345ab.8.1737410078504; 
 Mon, 20 Jan 2025 13:54:38 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 27/28] test: Do flag-processing in the correct place
Date: Mon, 20 Jan 2025 14:53:27 -0700
Message-ID: <20250120215340.617194-28-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120215340.617194-1-sjg@chromium.org>
References: <20250120215340.617194-1-sjg@chromium.org>
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

At present the 'ut' command handles its flags in a strange way, in that
they must come after the subcommand.

So, we must use 'ut bloblist -r2' to run the bloblist tests twice. This
is an artefact of the way tests were run, through subcommands.

It is now possible to correct this, by doing flag-processing before
running the suite.

Update the code to handle this, so that 'ut -r2 bloblist' works. Update
the 'test_suite' test to check the new arguments.

Add a sanity-check for -I while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd_ut.c               | 93 +++++++++++++++++++------------------
 test/py/tests/test_suite.py | 20 ++++++--
 2 files changed, 66 insertions(+), 47 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 2e62081a3dc..07d0a91f697 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -28,11 +28,11 @@ struct suite {
 	const char *help;
 };
 
-static int do_ut_all(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
-		     int flag, int argc, char *const argv[]);
+static int do_ut_all(struct unit_test_state *uts, const char *select_name,
+		     int runs_per_test, bool force_run,
+		     const char *test_insert);
 
-static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
-		      char *const argv[]);
+static int do_ut_info(bool show_suites);
 
 /* declare linker-list symbols for the start and end of a suite */
 #define SUITE_DECL(_name) \
@@ -119,40 +119,18 @@ static bool has_tests(struct suite *ste)
 
 /** run_suite() - Run a suite of tests */
 static int run_suite(struct unit_test_state *uts, struct suite *ste,
-		     struct cmd_tbl *cmdtp, int flag, int argc,
-		     char *const argv[])
+		     const char *select_name, int runs_per_test, bool force_run,
+		     const char *test_insert)
 {
 	int n_ents = ste->end - ste->start;
-	const char *test_insert = NULL;
-	int runs_per_text = 1;
-	bool force_run = false;
 	char prefix[30];
 	int ret;
 
 	/* use a standard prefix */
 	snprintf(prefix, sizeof(prefix), "%s_test_", ste->name);
 
-	while (argc > 1 && *argv[1] == '-') {
-		const char *str = argv[1];
-
-		switch (str[1]) {
-		case 'r':
-			runs_per_text = dectoul(str + 2, NULL);
-			break;
-		case 'f':
-			force_run = true;
-			break;
-		case 'I':
-			test_insert = str + 2;
-			break;
-		}
-		argv++;
-		argc--;
-	}
-
 	ret = ut_run_list(uts, ste->name, prefix, ste->start, n_ents,
-			  cmd_arg1(argc, argv), runs_per_text, force_run,
-			  test_insert);
+			  select_name, runs_per_test, force_run, test_insert);
 
 	return ret;
 }
@@ -187,8 +165,8 @@ static void update_stats(struct unit_test_state *uts, const struct suite *ste)
 	}
 }
 
-static int do_ut_all(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
-		     int flag, int argc, char *const argv[])
+static int do_ut_all(struct unit_test_state *uts, const char *select_name,
+		     int runs_per_test, bool force_run, const char *test_insert)
 {
 	int i;
 	int retval;
@@ -196,11 +174,11 @@ static int do_ut_all(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
 
 	for (i = 0; i < ARRAY_SIZE(suites); i++) {
 		struct suite *ste = &suites[i];
-		char *const argv[] = {(char *)ste->name, NULL};
 
 		if (has_tests(ste)) {
 			printf("----Running %s tests----\n", ste->name);
-			retval = run_suite(uts, ste, cmdtp, flag, 1, argv);
+			retval = run_suite(uts, ste, select_name, runs_per_test,
+					   force_run, test_insert);
 			if (!any_fail)
 				any_fail = retval;
 			update_stats(uts, ste);
@@ -210,11 +188,9 @@ static int do_ut_all(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
 	return any_fail;
 }
 
-static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
-		      char *const argv[])
+static int do_ut_info(bool show_suites)
 {
 	int suite_count, i;
-	const char *flags;
 
 	for (suite_count = 0, i = 0; i < ARRAY_SIZE(suites); i++) {
 		struct suite *ste = &suites[i];
@@ -226,8 +202,7 @@ static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 	printf("Test suites: %d\n", suite_count);
 	printf("Total tests: %d\n", (int)UNIT_TEST_ALL_COUNT());
 
-	flags = cmd_arg1(argc, argv);
-	if (flags && !strcmp("-s", flags)) {
+	if (show_suites) {
 		int i, total;
 
 		puts("\nTests  Suite         Purpose");
@@ -267,24 +242,53 @@ static struct suite *find_suite(const char *name)
 
 static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	const char *test_insert = NULL, *select_name;
 	struct unit_test_state uts;
+	bool show_suites = false;
+	bool force_run = false;
+	int runs_per_text = 1;
 	struct suite *ste;
 	char *name;
 	int ret;
 
-	if (argc < 2)
-		return CMD_RET_USAGE;
-
 	/* drop initial "ut" arg */
 	argc--;
 	argv++;
 
+	while (argc > 0 && *argv[0] == '-') {
+		const char *str = argv[0];
+
+		switch (str[1]) {
+		case 'r':
+			runs_per_text = dectoul(str + 2, NULL);
+			break;
+		case 'f':
+			force_run = true;
+			break;
+		case 'I':
+			test_insert = str + 2;
+			if (!strchr(test_insert, ':'))
+				return CMD_RET_USAGE;
+			break;
+		case 's':
+			show_suites = true;
+			break;
+		}
+		argv++;
+		argc--;
+	}
+
+	if (argc < 1)
+		return CMD_RET_USAGE;
+
 	ut_init_state(&uts);
 	name = argv[0];
+	select_name = cmd_arg1(argc, argv);
 	if (!strcmp(name, "all")) {
-		ret = do_ut_all(&uts, cmdtp, flag, argc, argv);
+		ret = do_ut_all(&uts, select_name, runs_per_text, force_run,
+				test_insert);
 	} else if (!strcmp(name, "info")) {
-		ret = do_ut_info(cmdtp, flag, argc, argv);
+		ret = do_ut_info(show_suites);
 	} else {
 		int any_fail = 0;
 		const char *p;
@@ -300,7 +304,8 @@ static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 				return CMD_RET_FAILURE;
 			}
 
-			ret = run_suite(&uts, ste, cmdtp, flag, argc, argv);
+			ret = run_suite(&uts, ste, select_name, runs_per_text,
+					force_run, test_insert);
 			if (!any_fail)
 				any_fail = ret;
 			update_stats(&uts, ste);
diff --git a/test/py/tests/test_suite.py b/test/py/tests/test_suite.py
index d0025a7ba30..9ddc883394b 100644
--- a/test/py/tests/test_suite.py
+++ b/test/py/tests/test_suite.py
@@ -135,7 +135,7 @@ def xtest_suite(u_boot_console, u_boot_config):
 
        - The number of suites matches that reported by the 'ut info'
        - Where available, the number of tests is each suite matches that
-         reported by 'ut info -s'
+         reported by 'ut -s info'
        - The total number of tests adds up to the total that are actually run
          with 'ut all'
        - All suites are run with 'ut all'
@@ -167,7 +167,7 @@ def xtest_suite(u_boot_console, u_boot_config):
 
     # Run 'ut info' and compare with the log results
     with cons.log.section('Check suite test-counts'):
-        output = cons.run_command('ut info -s')
+        output = cons.run_command('ut -s info')
 
         suite_count, total_test_count, test_count = process_ut_info(cons,
                                                                     output)
@@ -191,4 +191,18 @@ def xtest_suite(u_boot_console, u_boot_config):
     # Run three suites
     with cons.log.section('Check multiple suites'):
         output = cons.run_command('ut bloblist,setexpr,mem')
-    assert 'Suites run: 3' in output
+        assert 'Suites run: 3' in output
+
+    # Run a particular test
+    with cons.log.section('Check single test'):
+        output = cons.run_command('ut bloblist reloc')
+        assert 'Test: reloc: bloblist.c' in output
+
+    # Run tests multiple times
+    with cons.log.section('Check multiple runs'):
+        output = cons.run_command('ut -r2 bloblist')
+        lines = output.splitlines()
+        run = len([line for line in lines if 'Test:' in line])
+        count = re.search(r'Tests run: (\d*)', lines[-1]).group(1)
+
+        assert run == 2 * int(count)
-- 
2.43.0

