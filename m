Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0233AF3ED67
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 01:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77EDA84222;
	Sun, 12 Apr 2026 03:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I9Hybibj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7485841FF; Sun, 12 Apr 2026 03:35:30 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C023841DF
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 03:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dbb89ab229so2957886a34.1
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 18:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775957724; x=1776562524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNVGj+n3xDtvOKlfaLTb/Z3z55ErZhoMc1TFcWSnQYM=;
 b=I9HybibjdF/9bHx/QN+wxKfRupf+8UtWW0jrzo2zTkTXev6I1ZpKLphjHQWL6+cofv
 FArt6XjODl8W+rogog4rVQkDZvkSN5PE5Kq4HELD0+KPYSCbZphWwEFPrKB8at6P9ERF
 cjA9KBetdNsOrHSQr89nVJlc/V7hW7wstrekY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775957724; x=1776562524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BNVGj+n3xDtvOKlfaLTb/Z3z55ErZhoMc1TFcWSnQYM=;
 b=CNb4COsXeyikVSikXg0WXdrjZxdn4jk3VkYTqpLbHbAH/ryADdcvGS+Mi/xzeqSk9v
 hzheNF2bXrUjRNXGbH9H1NYk4A/U+BIcNblKHXogmQl63uj6q+Gm56aUajd/8869ntuC
 kdSXMkFBaQPYbaU1hAUXzpTTIUkdJl75QWlWY2I7+iI9T+TjS6hiIYHI2svw8lFDKHMU
 zy/y61Bh5tVP/1piKbB2VJnBgiuDxv6KJ0enXL8qOggpGA6eaM3H/uPPAc71x4LYIsJx
 cKim5M+ge8CAmpZMBkCRKCnkM6wzeM4OKeZk15jxQNgm35ENeYgMoebMAEeyrB2dEpCg
 PKBQ==
X-Gm-Message-State: AOJu0YwX0ebQmsFEkH5BC2qlItu6Fvfhz3y8O7qSmCVI3bYxz1QC4tN5
 7MVX4mFdbSmmQKvCcUfTgEdwgndAnPJsawRQhQ/RYErVQdub7JfKd/pW8mDQe93BqKFLdft5Jxn
 049oikA==
X-Gm-Gg: AeBDiesYodUR3wdWCYe0V++X618hs0gD4hI9SZMXoJleaO0c/1/rug2QHo0VnSqtBPz
 jueNk7s3u9fcV8aDr+QV0YeE2AFUwU7i9LYP4UIUd7hffavE8u18Fq5JLJKk9hswbHNEE3u/ZB9
 w8Dj1lod6kPb7YQBQ/W0e/fPIAPi+eDHTqE97KGlpVyB7m6gNa7Eq8DGRnwppwJlhyfgu5ygCbw
 Nk5WHBWweow+a5rCpM5wDCnyRu2qOBYs0n0pX6oqqvGOoySHwR6PUMjM4qDmmz+gxVCnfxWmO2t
 UO+FDIfh354I1gvgN3pWfs1XT9oLkaQE0aizwd6hFAmuWgFa2uDm3HC0N/7HT5YEEbpfixqminM
 /LZeogIpLuDffBa37eRpihbd8IkapGkwq2L1k19L8styfqRpa9Wi/OkeFrijBKWB2m7Wnhp0V34
 nEe33vCqCTDvvX2qLKkLj2rhJc/HPL
X-Received: by 2002:a05:6830:668a:b0:7d7:455d:1003 with SMTP id
 46e09a7af769-7dc27dca0b9mr5941500a34.4.1775957723853; 
 Sat, 11 Apr 2026 18:35:23 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2d1aca3asm4242826a34.6.2026.04.11.18.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 18:35:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <simon.glass@canonical.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 06/12] test: Add support for passing arguments to C tests
Date: Sat, 11 Apr 2026 19:34:34 -0600
Message-ID: <20260412013451.2929001-7-sjg@chromium.org>
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

Add support for passing key=value arguments to unit tests. The test
framework parses arguments based on definitions provided by each test
and makes them available via uts->args[]

For now the 'ut' command does not support this new feature.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/cpu/spl.c |   3 +-
 include/test/test.h    |   5 ++
 include/test/ut.h      |   4 +-
 test/cmd_ut.c          |   3 +-
 test/test-main.c       | 169 ++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 177 insertions(+), 7 deletions(-)

diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index 7ee4975523e..162b678314e 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -152,7 +152,8 @@ void spl_board_init(void)
 
 		ut_init_state(&uts);
 		ret = ut_run_list(&uts, "spl", NULL, tests, count,
-				  state->select_unittests, 1, false, NULL);
+				  state->select_unittests, 1, false, NULL,
+				  0, NULL);
 		ut_report(&uts.cur, 1);
 		ut_uninit_state(&uts);
 		/* continue execution into U-Boot */
diff --git a/include/test/test.h b/include/test/test.h
index cdd19392844..bd47025ce50 100644
--- a/include/test/test.h
+++ b/include/test/test.h
@@ -9,6 +9,7 @@
 #include <malloc.h>
 #include <linux/bitops.h>
 
+#define UT_MAX_ARGS	8
 #define UT_PRIV_SIZE	256
 
 /**
@@ -92,6 +93,8 @@ struct ut_arg {
  * @expect_str: Temporary string used to hold expected string value
  * @actual_str: Temporary string used to hold actual string value
  * @priv: Private data for tests to use as needed
+ * @args: Parsed argument values for current test
+ * @arg_count: Number of parsed arguments
  */
 struct unit_test_state {
 	struct ut_stats cur;
@@ -118,6 +121,8 @@ struct unit_test_state {
 	char expect_str[512];
 	char actual_str[512];
 	char priv[UT_PRIV_SIZE];
+	struct ut_arg args[UT_MAX_ARGS];
+	int arg_count;
 };
 
 /* Test flags for each test */
diff --git a/include/test/ut.h b/include/test/ut.h
index 8f0e69a7734..1c4ee390fd8 100644
--- a/include/test/ut.h
+++ b/include/test/ut.h
@@ -675,12 +675,14 @@ void ut_uninit_state(struct unit_test_state *uts);
  * name is the name of the test to run. This is used to find which test causes
  * another test to fail. If the one test fails, testing stops immediately.
  * Pass NULL to disable this
+ * @argc: Number of test arguments (key=value pairs), 0 if none
+ * @argv: Test argument array, NULL if none
  * Return: 0 if all tests passed, -1 if any failed
  */
 int ut_run_list(struct unit_test_state *uts, const char *category,
 		const char *prefix, struct unit_test *tests, int count,
 		const char *select_name, int runs_per_test, bool force_run,
-		const char *test_insert);
+		const char *test_insert, int argc, char *const argv[]);
 
 /**
  * ut_report() - Report stats on a test run
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 44e5fdfdaa6..7304c32bec5 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -130,7 +130,8 @@ static int run_suite(struct unit_test_state *uts, struct suite *ste,
 	snprintf(prefix, sizeof(prefix), "%s_test_", ste->name);
 
 	ret = ut_run_list(uts, ste->name, prefix, ste->start, n_ents,
-			  select_name, runs_per_test, force_run, test_insert);
+			  select_name, runs_per_test, force_run, test_insert,
+			  0, NULL);
 
 	return ret;
 }
diff --git a/test/test-main.c b/test/test-main.c
index 3254325e8b1..9d8ab794db8 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -87,6 +87,154 @@ void ut_uninit_state(struct unit_test_state *uts)
 	}
 }
 
+/**
+ * ut_count_args() - Count the number of arguments in a NULL-terminated array
+ *
+ * @defs: Argument definitions array (NULL-terminated)
+ * Return: Number of arguments
+ */
+static int ut_count_args(const struct ut_arg_def *defs)
+{
+	int count = 0;
+
+	if (defs) {
+		while (defs[count].name)
+			count++;
+	}
+
+	return count;
+}
+
+/**
+ * ut_set_arg() - Find and set an argument value
+ *
+ * Search through argument definitions to find a matching key and set its value.
+ *
+ * @defs: Argument definitions array
+ * @args: Argument values array to update
+ * @count: Number of argument definitions
+ * @key: Key name to search for
+ * @key_len: Length of key name
+ * @val: Value string to parse
+ * Return: true if argument was found and set, false otherwise
+ */
+static bool ut_set_arg(const struct ut_arg_def *defs, struct ut_arg *args,
+		       int count, const char *key, int key_len, const char *val)
+{
+	int j;
+
+	for (j = 0; j < count; j++) {
+		if (strlen(defs[j].name) == key_len &&
+		    !strncmp(defs[j].name, key, key_len)) {
+			switch (defs[j].type) {
+			case UT_ARG_INT:
+				args[j].vint = simple_strtol(val, NULL, 0);
+				break;
+			case UT_ARG_BOOL:
+				args[j].vbool = *val == '1';
+				break;
+			case UT_ARG_STR:
+				args[j].vstr = val;
+				break;
+			}
+			args[j].provided = true;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/**
+ * ut_parse_args() - Parse command-line arguments for a test
+ *
+ * Parse key=value arguments from the command line and set up uts->args based on
+ * the test's argument definitions.
+ *
+ * @uts: Unit test state (args and arg_count will be set)
+ * @test: Test being run (provides arg_defs)
+ * @argc: Number of arguments
+ * @argv: Argument array (key=value strings)
+ * Return: 0 on success, -EINVAL on parse error
+ */
+static int ut_parse_args(struct unit_test_state *uts, struct unit_test *test,
+			 int argc, char *const argv[])
+{
+	const struct ut_arg_def *defs = test->arg_defs;
+	struct ut_arg *args = uts->args;
+	int count = ut_count_args(defs);
+	int i;
+
+	uts->arg_count = 0;
+
+	/* No arguments expected */
+	if (!count) {
+		if (argc > 0) {
+			printf("Test '%s' does not accept arguments\n",
+			       test->name);
+			return -EINVAL;
+		}
+		return 0;
+	}
+
+	if (count > UT_MAX_ARGS) {
+		printf("Test '%s' has too many arguments (%d > %d)\n",
+		       test->name, count, UT_MAX_ARGS);
+		return -EINVAL;
+	}
+
+	/* Initialise from defaults */
+	for (i = 0; i < count; i++) {
+		args[i].name = defs[i].name;
+		args[i].type = defs[i].type;
+		args[i].provided = false;
+		switch (defs[i].type) {
+		case UT_ARG_INT:
+			args[i].vint = defs[i].def.vint;
+			break;
+		case UT_ARG_BOOL:
+			args[i].vbool = defs[i].def.vbool;
+			break;
+		case UT_ARG_STR:
+			args[i].vstr = defs[i].def.vstr;
+			break;
+		}
+	}
+
+	/* Parse command-line key=value pairs */
+	for (i = 0; i < argc; i++) {
+		const char *arg = argv[i];
+		const char *eq = strchr(arg, '=');
+		int key_len;
+
+		if (!eq) {
+			printf("Invalid argument '%s' (expected key=value)\n",
+			       arg);
+			return -EINVAL;
+		}
+		key_len = eq - arg;
+
+		if (!ut_set_arg(defs, args, count, arg, key_len, eq + 1)) {
+			printf("Unknown argument '%.*s' for test '%s'\n",
+			       key_len, arg, test->name);
+			return -EINVAL;
+		}
+	}
+
+	/* Check required arguments are provided */
+	for (i = 0; i < count; i++) {
+		if (!args[i].provided && !(defs[i].flags & UT_ARGF_OPTIONAL)) {
+			printf("Missing required argument '%s' for test '%s'\n",
+			       defs[i].name, test->name);
+			return -EINVAL;
+		}
+	}
+
+	uts->arg_count = count;
+
+	return 0;
+}
+
 /**
  * dm_test_pre_run() - Get ready to run a driver model test
  *
@@ -588,12 +736,15 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
  * @test_insert: String describing a test to run after n other tests run, in the
  * format n:name where n is the number of tests to run before this one and
  * name is the name of the test to run
+ * @argc: Number of test arguments (key=value pairs)
+ * @argv: Test argument array
  * Return: 0 if all tests passed, -ENOENT if test @select_name was not found,
  *	-EBADF if any failed
  */
 static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 			struct unit_test *tests, int count,
-			const char *select_name, const char *test_insert)
+			const char *select_name, const char *test_insert,
+			int argc, char *const argv[])
 {
 	int prefix_len = prefix ? strlen(prefix) : 0;
 	struct unit_test *test, *one;
@@ -649,6 +800,11 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 
 		uts->cur.test_count++;
 		if (one && upto == pos) {
+			ret = ut_parse_args(uts, one, argc, argv);
+			if (ret) {
+				uts->cur.fail_count++;
+				return ret;
+			}
 			ret = ut_run_test_live_flat(uts, one, NULL);
 			if (uts->cur.fail_count != old_fail_count) {
 				printf("Test '%s' failed %d times (position %d)\n",
@@ -662,6 +818,12 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 		if (prefix_len && !strncmp(test_name, prefix, prefix_len))
 			test_name = test_name + prefix_len;
 
+		ret = ut_parse_args(uts, test, argc, argv);
+		if (ret) {
+			found++;
+			uts->cur.fail_count++;
+			continue;
+		}
 		for (i = 0; i < uts->runs_per_test; i++)
 			ret = ut_run_test_live_flat(uts, test, test_name);
 		if (uts->cur.fail_count != old_fail_count) {
@@ -701,9 +863,8 @@ void ut_report(struct ut_stats *stats, int run_count)
 int ut_run_list(struct unit_test_state *uts, const char *category,
 		const char *prefix, struct unit_test *tests, int count,
 		const char *select_name, int runs_per_test, bool force_run,
-		const char *test_insert)
+		const char *test_insert, int argc, char *const argv[])
 {
-	;
 	bool has_dm_tests = false;
 	ulong start_offset = 0;
 	ulong test_offset = 0;
@@ -745,7 +906,7 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
 	}
 	uts->force_run = force_run;
 	ret = ut_run_tests(uts, prefix, tests, count, select_name,
-			   test_insert);
+			   test_insert, argc, argv);
 
 	/* Best efforts only...ignore errors */
 	if (has_dm_tests)
-- 
2.43.0

