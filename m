Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301E2E937E1
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 11:25:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E07B8420C;
	Sun, 12 Apr 2026 13:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h5DmWY8m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AFB584242; Sun, 12 Apr 2026 13:24:33 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7264839D5
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 13:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-67e0d3f288aso2342707eaf.0
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 04:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775993069; x=1776597869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HtC3HYFPdl/00ksMSAHwr/U9a9/nYBnm16wH2uxUpHk=;
 b=h5DmWY8ml9YGwD1E7qJNqV3yOdbX8R4NBnYxrjRzjxLG4AGS1Lnr2x3rw+CDoMhoiK
 o+RgC8FQI7VaLK0gC9gh4gz2BXCCuhbTOa0WEh4QkP0m22LQe81NUoIHhpIXvmzd3i4U
 MEQWwg6Wv96b2DfqCXHAIzxyulUdMBRDPMg14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775993069; x=1776597869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HtC3HYFPdl/00ksMSAHwr/U9a9/nYBnm16wH2uxUpHk=;
 b=Vw4qp4Zf4aGo79FyQc0hQnOz4u0nrIkWInYl42jPwEM9MRfchO+dFoEwt6TUj84Z74
 GTtZwAVibanLoD0htvZgYn96Vx4d/O3X1vzoftqMN+e4tTmC6FKnXa3RJtcWafOgyK2M
 oC+ewnkqLUB+MUDxswUo64FHpRNgTa0WO7tRoSNj+O7E1+S6TbI0Iv6u4mwiz9puIUzN
 yZS5QvA5/hA98VLMKQsKwFyMF7fzaivP66fO+VER9c74K9al9rVKw0Hn8ufB94lf/pzY
 efw3+nmyJF37ArpAo5F+rBKqzr3+0JZbQqpas97JjEF/Q3p9eGtnYvSirBHNxQMPxrEj
 a5MQ==
X-Gm-Message-State: AOJu0YyJ6PiAUtXuP72H7g9vuWnBhgD5W/cVvD/i/E7/NRRoX9IZVisA
 q7swiaZAY/2p1x5dmMdSSlXai97draSdwBwimi7d2JPw/W5ssaYFRTML5MaeBbl1lCHk0tUpynK
 0FBKaNA==
X-Gm-Gg: AeBDietwyXIzT5ZvB6eC2Qdc1/KTp4vw1+2vaZikp/rUxQIA5kTWQeQZxc+pgKj197q
 u0Yim0A9jQ9BFANmR8m4eOESCii0lEw5ZSimpxaZn8P0zCU7ukWC2UmSev/h+1BKxk8IBh5Vpc4
 NI/2anhZRUpkiMX/57NMqY6vqDnGzBHfuTJIyI6NewQVCGuEgMCDYMOd8J+WX6H5+litRzDnMat
 dd2YxgcGdUMG94BD8FazbPWM6fV1eR9OxEjAgOevhFfgniEQSaKqyb4lxgFOm9m2OXH2ZIC1Rhm
 I8lgd27SDnNcrWPTOMGlY6jArSXdAr//b5t0PEhABq34qOBwAET+01Upi5HaqrS0P63OUYtx1hm
 gKUAEXljcwvD5ObtwHR3a8OVfDgK5LHgN7GTbg8N/5gzZpPAperTt9A3/AhvQDKUlZhSFcepc1u
 v9DeGB5pIJMm1/dHxeXw==
X-Received: by 2002:a05:6820:5183:b0:682:ecb8:c3c with SMTP id
 006d021491bc7-68be88efeadmr3016282eaf.49.1775993068733; 
 Sun, 12 Apr 2026 04:24:28 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd395606sm6622071fac.1.2026.04.12.04.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 04:24:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 10/12] test: Add documentation for the test framework
Date: Sun, 12 Apr 2026 05:19:47 -0600
Message-ID: <20260412111958.943933-11-sjg@chromium.org>
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

Add documentation for test assertions, the private buffer, and test
parameters. This covers the available ut_assert*() macros, console
output checks, memory helpers, and how to pass typed arguments from
Python to C tests.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/develop/tests_writing.rst | 169 ++++++++++++++++++++++++++++++++++
 doc/usage/cmd/ut.rst          |  11 ++-
 2 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.rst
index 1a020caa411..40192f9db30 100644
--- a/doc/develop/tests_writing.rst
+++ b/doc/develop/tests_writing.rst
@@ -101,6 +101,47 @@ constructs, in this case to check that the expected things happened in the
 Python test.
 
 
+Passing arguments to C tests
+----------------------------
+
+Sometimes a C test needs parameters from Python, such as filenames or expected
+values that are generated at runtime. The test-argument feature allows this.
+
+Use the `UNIT_TEST_ARGS` macro to declare a test with arguments::
+
+   static int my_test_norun(struct unit_test_state *uts)
+   {
+      const char *filename = ut_str(0);
+      int count = ut_int(1);
+
+      /* test code using filename and count */
+
+      return 0;
+   }
+   UNIT_TEST_ARGS(my_test_norun, UTF_CONSOLE | UTF_MANUAL, my_suite,
+                  { "filename", UT_ARG_STR },
+                  { "count", UT_ARG_INT });
+
+Each argument definition specifies a name and type:
+
+- `UT_ARG_STR` - string argument, accessed via `ut_str(n)`
+- `UT_ARG_INT` - integer argument, accessed via `ut_int(n)`
+- `UT_ARG_BOOL` - boolean argument, accessed via `ut_bool(n)`
+  (use `1` for true, any other value for false)
+
+Arguments are passed on the command line in `name=value` format::
+
+   ut -f my_suite my_test_norun filename=/path/to/file count=42
+
+From Python, you can call the test like this::
+
+   cmd = f'ut -f my_suite my_test_norun filename={filepath} count={count}'
+   ubman.run_command(cmd)
+
+This approach combines Python's flexibility for setup (creating files,
+generating values) with C's speed and debuggability for the actual test logic.
+
+
 How slow are Python tests?
 --------------------------
 
@@ -384,6 +425,134 @@ existing suite or creating a new one.
 An example SPL test is spl_test_load().
 
 
+.. _tests_writing_assertions:
+
+Assertions
+----------
+
+The test framework provides various assertion macros, defined in
+``include/test/ut.h``. All of these return from the test function on failure,
+unless ``uts->soft_fail`` is set.
+
+Basic assertions
+~~~~~~~~~~~~~~~~
+
+ut_assert(cond)
+    Assert that a condition is non-zero (true)
+
+ut_assertf(cond, fmt, args...)
+    Assert that a condition is non-zero, with a printf() message on failure
+
+ut_assertok(cond)
+    Assert that an operation succeeds (returns 0)
+
+ut_reportf(fmt, args...)
+    Report a failure with a printf() message (always fails)
+
+Value comparisons
+~~~~~~~~~~~~~~~~~
+
+ut_asserteq(expr1, expr2)
+    Assert that two int expressions are equal
+
+ut_asserteq_64(expr1, expr2)
+    Assert that two 64-bit expressions are equal
+
+ut_asserteq_str(expr1, expr2)
+    Assert that two strings are equal
+
+ut_asserteq_strn(expr1, expr2)
+    Assert that two strings are equal, up to the length of the first
+
+ut_asserteq_mem(expr1, expr2, len)
+    Assert that two memory areas are equal
+
+ut_asserteq_ptr(expr1, expr2)
+    Assert that two pointers are equal
+
+ut_asserteq_addr(expr1, expr2)
+    Assert that two addresses (converted from pointers via map_to_sysmem())
+    are equal
+
+ut_asserteq_regex(pattern, str)
+    Assert that a string matches a regular expression pattern. Uses the SLRE
+    library for regex matching. Useful when exact matching is fragile, e.g.
+    when output contains line numbers or variable content.
+
+Pointer assertions
+~~~~~~~~~~~~~~~~~~
+
+ut_assertnull(expr)
+    Assert that a pointer is NULL
+
+ut_assertnonnull(expr)
+    Assert that a pointer is not NULL
+
+ut_assertok_ptr(expr)
+    Assert that a pointer is not an error pointer (checked with IS_ERR())
+
+Console output assertions
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+These are used to check console output when ``UTF_CONSOLE`` flag is set.
+
+ut_assert_nextline(fmt, args...)
+    Assert that the next console output line matches the format string
+
+ut_assert_nextlinen(fmt, args...)
+    Assert that the next console output line matches up to the format
+    string length
+
+ut_assert_nextline_regex(pattern)
+    Assert that the next console output line matches a regex pattern
+
+ut_assert_nextline_empty()
+    Assert that the next console output line is empty
+
+ut_assert_skipline()
+    Assert that there is a next console output line, and skip it
+
+ut_assert_skip_to_line(fmt, args...)
+    Skip console output until a matching line is found
+
+ut_assert_skip_to_linen(fmt, args...)
+    Skip console output until a partial match is found (compares up to the
+    format-string length)
+
+ut_assert_console_end()
+    Assert that there is no more console output
+
+ut_assert_nextlines_are_dump(total_bytes)
+    Assert that the next lines are a print_buffer() hex dump of the specified
+    size
+
+Memory helpers
+~~~~~~~~~~~~~~
+
+These help check for memory leaks:
+
+ut_check_free()
+    Return the number of bytes free in the malloc() pool
+
+ut_check_delta(last)
+    Return the change in free memory since ``last`` was obtained from
+    ``ut_check_free()``. A positive value means more memory has been allocated.
+
+Private buffer
+~~~~~~~~~~~~~~
+
+Each test has access to a private buffer ``uts->priv`` (256 bytes) for temporary
+data. This avoids the need to allocate memory or use global variables::
+
+   static int my_test(struct unit_test_state *uts)
+   {
+      snprintf(uts->priv, sizeof(uts->priv), "/%s", filename);
+      /* use uts->priv as a path string */
+
+      return 0;
+   }
+
+
 Writing Python tests
 --------------------
 
diff --git a/doc/usage/cmd/ut.rst b/doc/usage/cmd/ut.rst
index d8c3cbf496c..a26ee6ad7de 100644
--- a/doc/usage/cmd/ut.rst
+++ b/doc/usage/cmd/ut.rst
@@ -11,7 +11,7 @@ Synopsis
 
 ::
 
-    ut [-r<runs>] [-f] [-I<n>:<one_test>] [<suite> | all [<test>]] [<args>...]
+    ut [-r<runs>] [-f] [-R] [-I<n>:<one_test>] [<suite> | all [<test>]] [<args>...]
     ut [-s] info
 
 Description
@@ -37,10 +37,17 @@ test
     causes another test to fail. If the one test fails, testing stops
     immediately.
 
+-R
+    Preserve console recording on test failure. Normally when a test fails,
+    console recording is disabled so error messages go directly to output.
+    This flag keeps recording enabled, which is useful when testing the test
+    framework itself.
+
 args
     Optional arguments to pass to the test, in `name=value` format. These are
     used by tests declared with `UNIT_TEST_ARGS()` which define expected
-    argument names and types.
+    argument names and types. See :ref:`develop/tests_writing:passing arguments
+    to c tests` for details.
 
 Typically the command is run on :ref:`arch/sandbox/sandbox:sandbox` since it
 includes a near-complete set of emulators, no code-size limits, many CONFIG
-- 
2.43.0

