Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405CDE937E3
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 11:25:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 252B184223;
	Sun, 12 Apr 2026 13:24:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WvhRuyFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A841839D5; Sun, 12 Apr 2026 13:24:30 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 114B78421E
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 13:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-464bc03efd8so2010777b6e.2
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 04:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775993066; x=1776597866; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TAhZxhLEz0oy/K9BIxXMcNU3xWcbigcWRSL6sK4+4ZY=;
 b=WvhRuyFTARxArHFXznPVjCLEwqStAgpBFAJA3SBmikX/ip6ZA9pKPvDI65lF5J4T3K
 gi/MmuKU2uTfc9tRsjoR6T221G1bgkN1+M2Hl8xPnoEbccOdj9Ldlfai+IfnBOo94CKk
 nRi35mWxDN3yxMpZ0yd1cxY7F8hiVpmU/OIyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775993066; x=1776597866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TAhZxhLEz0oy/K9BIxXMcNU3xWcbigcWRSL6sK4+4ZY=;
 b=URabrGr6f9a9oocqkgIqC/F0jGfC3+ygKCGnBshxRirWnKR8FlmyInOQBO5XSoEyb+
 gRiWrZAvpjuETuXZRvo5w6AKEi2L0+8fXDt021aSMSO48/fPu4gYFHiD2m+UpF9gOJ+7
 YXKXEdz9vR8ROTHLUkqYHaI/CPNxkDT7IgcW7NpPcDLBLTteyM8khbM1SuH0ZDYiR24G
 2JWObBIAMc3uzi5DgWXe6dj5py5JBBPUZMKvvZdCxtpS+ksjhuaqZ8D7M205Tn0sMdSq
 MBjd2CgJDNunE71yyIk8n51rNM/pbvwgu5fU3lLC9EDe5a/3OCsRuNC68yUDHyDbNVCq
 UqPA==
X-Gm-Message-State: AOJu0YzNxH/JNspnPHH5USEiRD3Uan9YeWFUhDdeAZnEvW17uNp0mWuC
 4zKB38q6YaTtCyr6ovVHNiTgbag28laaH6hPUAqK1w64Ql30z0dzsdhui3ivHPbKy/7vnNAEWf5
 uo4TNPQ==
X-Gm-Gg: AeBDietIur/NtKccgzz4OUAPLmZOPjZh89T5QokKmRB7lqp6KyDqrrRv125yRUsTpGv
 SMH+B1nVfU0DblpDbKxu1fs7vkRpdNsUMouqcS72EfKOAPKHU2VcaP1CgE3dRHzL6+wJKt+/wiK
 /2bhyo9Ixvt1U7VdQFZX9OOB4EpL9p8mxF2re39s9Vn4yqV/ph8fkJ1kfkmjvyyoFVXsyYDEC63
 XeZP/iaq1bvjCKeo3jJC9jpMlZoyWwpNB/GRjk5cnimPsrW5xivuQ79Mcikon+R+DPXYrEwXmyA
 eTnsqE0JIWFNLmuahchmuXHEDyaryGEnGLm3rUr0+e2KByrG1wo2wCYl2Ofesc9D+ZaclU0zrc0
 swBD1dCOklUBr8JtsjvS8oZIXTInP0v9R64C216EF6isypR6PEqQnj/ymCdW6IJRnNVvKt30SCw
 I0RTVBCG/rKYW8Fie31w==
X-Received: by 2002:a05:6808:c168:b0:467:1f38:bc1a with SMTP id
 5614622812f47-4789d95209bmr4735582b6e.7.1775993066154; 
 Sun, 12 Apr 2026 04:24:26 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd395606sm6622071fac.1.2026.04.12.04.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 04:24:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 09/12] test: Add tests for unit-test arguments
Date: Sun, 12 Apr 2026 05:19:46 -0600
Message-ID: <20260412111958.943933-10-sjg@chromium.org>
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

Add a set of tests to check the behaviour of test arguments and the ut
command. This includes failure cases, where the wrong type or a
non-existent argument is requested.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/common/Makefile    |   1 +
 test/common/test_args.c | 176 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 177 insertions(+)
 create mode 100644 test/common/test_args.c

diff --git a/test/common/Makefile b/test/common/Makefile
index baefc7b3622..bfeb29346f5 100644
--- a/test/common/Makefile
+++ b/test/common/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_CYCLIC) += cyclic.o
 obj-$(CONFIG_EVENT_DYNAMIC) += event.o
 obj-y += cread.o
 obj-$(CONFIG_$(PHASE_)CMDLINE) += print.o
+obj-$(CONFIG_$(PHASE_)CMDLINE) += test_args.o
diff --git a/test/common/test_args.c b/test/common/test_args.c
new file mode 100644
index 00000000000..d81039e75ac
--- /dev/null
+++ b/test/common/test_args.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test for unit test arguments
+ *
+ * Copyright 2026 Canonical Ltd
+ * Written by Simon Glass <simon.glass@canonical.com>
+ */
+
+#include <string.h>
+#include <test/common.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/* Test that string arguments work correctly */
+static int test_args_str_norun(struct unit_test_state *uts)
+{
+	ut_asserteq_str("hello", ut_str(0));
+
+	return 0;
+}
+UNIT_TEST_ARGS(test_args_str_norun, UTF_CONSOLE | UTF_MANUAL, common,
+	       { "strval", UT_ARG_STR });
+
+/* Test that integer arguments work correctly */
+static int test_args_int_norun(struct unit_test_state *uts)
+{
+	ut_asserteq(1234, ut_int(0));
+
+	return 0;
+}
+UNIT_TEST_ARGS(test_args_int_norun, UTF_CONSOLE | UTF_MANUAL, common,
+	       { "intval", UT_ARG_INT });
+
+/* Test that boolean arguments work correctly */
+static int test_args_bool_norun(struct unit_test_state *uts)
+{
+	ut_asserteq(true, ut_bool(0));
+
+	return 0;
+}
+UNIT_TEST_ARGS(test_args_bool_norun, UTF_CONSOLE | UTF_MANUAL, common,
+	       { "boolval", UT_ARG_BOOL });
+
+/* Test multiple arguments of different types */
+static int test_args_multi_norun(struct unit_test_state *uts)
+{
+	ut_asserteq_str("test", ut_str(0));
+	ut_asserteq(42, ut_int(1));
+	ut_asserteq(true, ut_bool(2));
+
+	return 0;
+}
+UNIT_TEST_ARGS(test_args_multi_norun, UTF_CONSOLE | UTF_MANUAL, common,
+	       { "str", UT_ARG_STR },
+	       { "num", UT_ARG_INT },
+	       { "flag", UT_ARG_BOOL });
+
+/* Test optional arguments with defaults */
+static int test_args_optional_norun(struct unit_test_state *uts)
+{
+	/* Required arg should match what was passed */
+	ut_asserteq_str("required", ut_str(0));
+
+	/* Optional args should have default values if not provided */
+	ut_asserteq(99, ut_int(1));
+	ut_asserteq(false, ut_bool(2));
+
+	return 0;
+}
+UNIT_TEST_ARGS(test_args_optional_norun, UTF_CONSOLE | UTF_MANUAL, common,
+	       { "req", UT_ARG_STR },
+	       { "opt_int", UT_ARG_INT, UT_ARGF_OPTIONAL, { .vint = 99 } },
+	       { "opt_bool", UT_ARG_BOOL, UT_ARGF_OPTIONAL, { .vbool = false } });
+
+/* Test requesting wrong type - ut_int() on a string arg should fail */
+static int test_args_wrongtype_norun(struct unit_test_state *uts)
+{
+	/* This should fail - asking for int but arg is string */
+	ut_asserteq(0, ut_int(0));
+	ut_asserteq(true, uts->arg_error);
+
+	return 0;
+}
+UNIT_TEST_ARGS(test_args_wrongtype_norun, UTF_MANUAL, common,
+	       { "strval", UT_ARG_STR });
+
+/* Test requesting invalid arg number - ut_str(1) when only arg 0 exists */
+static int test_args_badnum_norun(struct unit_test_state *uts)
+{
+	/* This should fail - asking for arg 1 but only arg 0 exists */
+	ut_asserteq_ptr(NULL, ut_str(1));
+	ut_asserteq(true, uts->arg_error);
+
+	return 0;
+}
+UNIT_TEST_ARGS(test_args_badnum_norun, UTF_MANUAL, common,
+	       { "strval", UT_ARG_STR });
+
+/* Wrapper test that runs the manual tests with proper arguments */
+static int test_args(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("ut -f common test_args_str_norun strval=hello",
+				0));
+	ut_assertok(run_command("ut -f common test_args_int_norun intval=1234",
+				0));
+	ut_assertok(run_command("ut -f common test_args_bool_norun boolval=1",
+				0));
+	ut_assertok(run_command("ut -f common test_args_multi_norun str=test num=42 flag=1",
+				0));
+	ut_assertok(run_command("ut -f common test_args_optional_norun req=required",
+				0));
+
+	return 0;
+}
+COMMON_TEST(test_args, UTF_CONSOLE);
+
+/* Test argument-parsing failure cases - these should all fail */
+static int test_args_fail(struct unit_test_state *uts)
+{
+	/* Missing required argument - should fail */
+	ut_asserteq(1, run_command("ut -f common test_args_str_norun", 0));
+	ut_assert_nextline("Missing required argument 'strval' for test 'test_args_str_norun'");
+	ut_assert_nextline_regex("Tests run: 1,.*failures: 1");
+	ut_assert_console_end();
+
+	/* Unknown argument name - should fail */
+	ut_asserteq(1, run_command("ut -f common test_args_str_norun badarg=x",
+				   0));
+	ut_assert_nextline("Unknown argument 'badarg' for test 'test_args_str_norun'");
+	ut_assert_nextline_regex("Tests run: 1,.*failures: 1");
+	ut_assert_console_end();
+
+	/* Invalid format (no = sign) - should fail */
+	ut_asserteq(1, run_command("ut -f common test_args_str_norun strval",
+				   0));
+	ut_assert_nextline("Invalid argument 'strval' (expected key=value)");
+	ut_assert_nextline_regex("Tests run: 1,.*failures: 1");
+	ut_assert_console_end();
+
+	return 0;
+}
+COMMON_TEST(test_args_fail, UTF_CONSOLE);
+
+/* Test that requesting wrong type fails - ut_int() on string arg */
+static int test_args_wrongtype(struct unit_test_state *uts)
+{
+	ut_asserteq(1,
+		    run_command("ut -R -f common test_args_wrongtype_norun strval=hello",
+				0));
+	ut_assert_nextline("Test: test_args_wrongtype_norun: test_args.c");
+	ut_assert_nextline_regex(
+		"test/common/test_args.c:.*, test_args_wrongtype_norun\\(\\): ut_int\\(\\) type check: arg 0 is not an int");
+	ut_assert_nextline("Test 'test_args_wrongtype_norun' failed 1 times");
+	ut_assert_nextline_regex("Tests run: 1,.*failures: 1");
+	ut_assert_console_end();
+
+	return 0;
+}
+COMMON_TEST(test_args_wrongtype, UTF_CONSOLE);
+
+/* Test that requesting invalid arg number fails */
+static int test_args_badnum(struct unit_test_state *uts)
+{
+	ut_asserteq(1,
+		    run_command("ut -R -f common test_args_badnum_norun strval=hello",
+				0));
+	ut_assert_nextline("Test: test_args_badnum_norun: test_args.c");
+	ut_assert_nextline_regex(
+		"test/common/test_args.c:.*, test_args_badnum_norun\\(\\): ut_str\\(\\) arg check: arg 1 is invalid \\(arg_count=1\\)");
+	ut_assert_nextline("Test 'test_args_badnum_norun' failed 1 times");
+	ut_assert_nextline_regex("Tests run: 1,.*failures: 1");
+	ut_assert_console_end();
+
+	return 0;
+}
+COMMON_TEST(test_args_badnum, UTF_CONSOLE);
-- 
2.43.0

