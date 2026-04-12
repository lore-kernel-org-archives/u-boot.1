Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6B9F3ED67
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 01:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9698984119;
	Sun, 12 Apr 2026 03:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GS1usiIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91C1384227; Sun, 12 Apr 2026 03:35:47 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A22883B99
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 03:35:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dbcf927395so1933656a34.0
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 18:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775957741; x=1776562541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHDFXpsecY+51G+59y+hrjJVT8+G9UPWq6cZ1wiGz5M=;
 b=GS1usiIK8Vvj7WPsa/WHjHoQpEWtcF9Y4n6w7MQ1XciGUfCVjj7U5oiO/3yiqC3q7R
 acYjHj1iHVt8TASd8lZ0suArlroDZUHCazvcM0Idf4NE7NSd12NW2cJHYcndDQf4hXEu
 o1i3DOkkDbXXdn0Tq9BZxlCRA/VLbJIC4VvkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775957741; x=1776562541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qHDFXpsecY+51G+59y+hrjJVT8+G9UPWq6cZ1wiGz5M=;
 b=gM49Ss6NsiJ3JnIBg4QrOyJzAar1Mr2GhvdEnHgdD1R+8UBk/8/0xUXNfyWtpFage4
 vrMs40RPF5s1HuSmnpanszEgKuFVCux+8EqUrFJfZHYmI5AbZm7qwtjqVl0lDoke74yF
 MVlj4l8hAiNriO3boxRqWx6qskFXu80hLyTjhpkISDCF0DIEKJeENw7ZHLXYy4Rfwuz6
 1sJJ+mRDllhHBa3t+baB+Dvhxf67KTN6kD/aJE+149AbHCsKnX3RUb2LJSQPEFrt1EDY
 9vhDAxLJDaT01uLCps0iV3eOoFdo5j4yqWKEBl6Ym9azjLbHPPXHWJCHwJpTYKg9cmMg
 oo/w==
X-Gm-Message-State: AOJu0YwS/C3iSW4Ph1xeKBRALsvMTkK6bpqiK0lav0xuSUv14maMS/It
 b6SeNsqEZOmk0m/tA4HsRMJbtoZEqj4OMsNjgHIszaR4rT7A/1OIMOotU9gonImpg89NcDObzGo
 b6P1u4Q==
X-Gm-Gg: AeBDies2AxWOsWRw8l1KUdcXyrsjoiMuFNDfuZVR3y/WzdJfFfOL02AyMlhuJm6ASwA
 lgz2hNsf/59w3HNS65LnWxPHN97FaC4LaBvyB1VFRnSaGf5UfOgaO97icWDNSnAEQOv3KMIz5oN
 ezuOBV62gxlg34mlefWLmmQi3YXxoHW59anhr4J0AByj9EMLBNHyEgwyjORZR0GGScx7naXTArw
 ZRQoz3gcZUZbQcuyztB3RGc+gnZLe6nRjKiCguawbB1ioxo7Cd9ePTnOwYpDuQewa9jkiq7x+6y
 cXHh/8r+BsqH4bO23/2IRvzun/+oycdSpQVD0O2LlD+dRcsZNDLqTWe064Jail9beaidXTCMMiu
 msHxPfJ4y1j9qmnUlDL3lQgJwFWODk4onwSzkFbgiXUYTUODT3O10RiSHt4fKTk3rhbj2OSoOcq
 6CuA5PnYt8rHucwS+PUg==
X-Received: by 2002:a05:6830:b83:b0:7d7:faad:e35d with SMTP id
 46e09a7af769-7dc27db33acmr5813645a34.14.1775957740700; 
 Sat, 11 Apr 2026 18:35:40 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2d1aca3asm4242826a34.6.2026.04.11.18.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 18:35:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <simon.glass@canonical.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 09/12] test: Add tests for unit-test arguments
Date: Sat, 11 Apr 2026 19:34:37 -0600
Message-ID: <20260412013451.2929001-10-sjg@chromium.org>
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

Add a set of tests to check the behaviour of test arguments and the ut
command. This includes failure cases, where the wrong type or a
non-existent argument is requested.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

