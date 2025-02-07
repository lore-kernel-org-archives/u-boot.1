Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E27C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D671D80D1C;
	Fri,  7 Feb 2025 19:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Or7nJwfy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F0D080ECC; Fri,  7 Feb 2025 19:32:42 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE98080CF4
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-84ceaf2667aso158900139f.3
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953158; x=1739557958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGn0v9fwEhWslTw/2De/MaZNRy3kiG+vCirMIkN3njM=;
 b=Or7nJwfy8bnfWZ0q31tbVQB03Y/ie0t5YhEjYaCemNYPeDe2DKGSGWFMjlCPXiUAOT
 Zqh8BoWHm3ovDcIwZX93c/gGzKh/i5XKAAL4VSnYOxtOBxS6IOuTU5SR3pVzGJp9Ok7Y
 YiQW/aWQaP1zmktuy6/1vzfU/W3IgWYtCSzVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953158; x=1739557958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGn0v9fwEhWslTw/2De/MaZNRy3kiG+vCirMIkN3njM=;
 b=Ef22YjLTpvyKMhFFjy9Sx6oDh2lHSSG1mDYwtuZpxYh2usMpIKHv9WRygYbfmcFS4m
 aQhCo+fNa1LN20hLkzPTkyeNADekNSCBdFzxCHmVAjWgjbyGISnsEApTk5BPeHh8rBVq
 oC9eYQULmcnHv8aWe8b8cfXNJ5QvK91G+KFnV7PJLliXcemps/6dtE2z1ZEZTukepQ2I
 9teO8M5uZXn4K95nzaGpq3eiGCkVzh7K2oWPcPlzbpKHhTTy+8ctdAALKsFVeIm1f8+G
 yad4zy2wrmfgaC3CSai3xqpRGIJ7nz3l9LI3eW3E0L7+YjhNe5TAUipOVQzN0uDgBtC6
 fe+w==
X-Gm-Message-State: AOJu0YwMMX3KxoHQ2Fdd431ghLq8yDQ1IclWKOj2i9xlHQTW/drJRq8O
 0QyucPjlmmjMOiO9JrPxqpC1KgbL+u+z8xBfQ9XsKFpdt8gyv/1rLje3vYRpfDi9JA8scBfTYnk
 =
X-Gm-Gg: ASbGncu7qtmVbG5nkD8/a4N5j8JMc8fG+Zoyip6HrPZDDIHac+arQiiCD0f8LCgHq/t
 FgkptI6nVFQo8/b4Ps6dz7NOliwZLQbyxZgs5BsSEJquS5K7THxC05DxfR895EviwkbxhhFcgPe
 iDlk4LQe7qmNu7EDXbnrWo7NxqRC6X3Cq1Mk+j2OZ4WXw19RjSWH6WZyy2bS2HwT4pmbjPXKpAC
 INV+fkKB9kLS0EtjL70pq6cz1QzqoNQZQEG2sjDMnIKRRZ0ioFCk06QAfxggdujbmadmnrAaSAN
 3GW/ZRKHH/6W0uUGeTRf6kkmILEOo/pTRJ5oNxS99MbbU86UaZp8
X-Google-Smtp-Source: AGHT+IFq+oIBXNEmAXG+1MOQ4ZOZIbg7ur+zQftAMlhn7e4lHF/sfZ2GVffenQ6waTFRp0mdr80i2g==
X-Received: by 2002:a05:6602:6a46:b0:843:e8d0:a728 with SMTP id
 ca18e2360f4ac-854fd89a7cemr492712139f.4.1738953157870; 
 Fri, 07 Feb 2025 10:32:37 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:32:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 29/29] test: Update documentation
Date: Fri,  7 Feb 2025 11:31:00 -0700
Message-ID: <20250207183121.117663-30-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

Update documentation for how to write tests and the 'ut' command.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/develop/tests_writing.rst |  52 ++++++------
 doc/usage/cmd/ut.rst          | 145 ++++++++++++++++++++++++++--------
 test/cmd_ut.c                 |  12 +--
 3 files changed, 149 insertions(+), 60 deletions(-)

diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.rst
index 54efb7e1b04..5f3c43d5da2 100644
--- a/doc/develop/tests_writing.rst
+++ b/doc/develop/tests_writing.rst
@@ -261,7 +261,7 @@ with the suite. For example, to add a new mem_search test::
    /* Test 'ms' command with 32-bit values */
    static int mem_test_ms_new_thing(struct unit_test_state *uts)
    {
-         /* test code here*/
+         /* test code here */
 
          return 0;
    }
@@ -291,32 +291,20 @@ suite. For example::
    /* Declare a new wibble test */
    #define WIBBLE_TEST(_name, _flags)   UNIT_TEST(_name, _flags, wibble_test)
 
-   /* Tetss go here */
-
-   /* At the bottom of the file: */
-
-   int do_ut_wibble(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-   {
-     struct unit_test *tests = UNIT_TEST_SUITE_START(wibble_test);
-     const int n_ents = UNIT_TEST_SUITE_COUNT(wibble_test);
-
-     return cmd_ut_category("cmd_wibble", "wibble_test_", tests, n_ents, argc, argv);
-   }
+   /* Tests go here */
 
 Then add new tests to it as above.
 
 Register this new suite in test/cmd_ut.c by adding to cmd_ut_sub[]::
 
-  /* Within cmd_ut_sub[]... */
-
-  U_BOOT_CMD_MKENT(wibble, CONFIG_SYS_MAXARGS, 1, do_ut_wibble, "", ""),
+  /* with the other SUITE_DECL() declarations */
+  SUITE_DECL(wibble);
 
-and adding new help to ut_help_text[]::
+  /* Within suites[]... */
+  SUITE(wibble, "my test of wibbles");
 
-  "ut wibble - Test the wibble feature\n"
-
-If your feature is conditional on a particular Kconfig, then you can use #ifdef
-to control that.
+If your feature is conditional on a particular Kconfig, you do not need to add
+an #ifdef since the suite will automatically be compiled out in that case.
 
 Finally, add the test to the build by adding to the Makefile in the same
 directory::
@@ -326,17 +314,35 @@ directory::
 Note that CMDLINE is never enabled in SPL, so this test will only be present in
 U-Boot proper. See below for how to do SPL tests.
 
-As before, you can add an extra Kconfig check if needed::
+You can add an extra Kconfig check if needed::
 
   ifneq ($(CONFIG_$(XPL_)WIBBLE),)
   obj-$(CONFIG_$(XPL_)CMDLINE) += wibble.o
   endif
 
+Each suite can have an optional init and uninit function. These are run before
+and after any suite tests, respectively::
+
+   #define WIBBLE_TEST_INIT(_name, _flags)  UNIT_TEST_INIT(_name, _flags, wibble_test)
+   #define WIBBLE_TEST_UNINIT(_name, _flags)  UNIT_TEST_UNINIT(_name, _flags, wibble_test)
 
-Example commit: 919e7a8fb64 ("test: Add a simple test for bloblist") [1]
+   static int wibble_test_init(struct unit_test_state *uts)
+   {
+         /* init code here */
+
+         return 0;
+   }
+   WIBBLE_TEST_INIT(wibble_test_init, 0);
 
-[1] https://gitlab.denx.de/u-boot/u-boot/-/commit/919e7a8fb64
+   static int wibble_test_uninit(struct unit_test_state *uts)
+   {
+         /* uninit code here */
+
+         return 0;
+   }
+   WIBBLE_TEST_INIT(wibble_test_uninit, 0);
 
+Both functions are included in the totals for each suite.
 
 Making the test run from pytest
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/usage/cmd/ut.rst b/doc/usage/cmd/ut.rst
index e794922c806..1acf3126680 100644
--- a/doc/usage/cmd/ut.rst
+++ b/doc/usage/cmd/ut.rst
@@ -11,34 +11,44 @@ Synopsis
 
 ::
 
-    ut [-r<runs>] [-fs] [-I<n>:<one_test>] [<suite> [<test>]]
-
-       <runs>      Number of times to run each test
-       -f          Force 'manual' tests to run as well
-       <n>         Run <one test> after <n> other tests have run
-       <one_test>  Name of the 'one' test to run
-       <suite>     Test suite to run, or `all`
-       <test>      Name of single test to run
+    ut [-r<runs>] [-f] [-I<n>:<one_test>] [-r<n>] [<suite> | 'all' [<test>]]
+    ut [-s] info
 
 Description
 -----------
 
 The ut command runs unit tests written in C.
 
+suite
+    Specifies the suite to run, This can be a single suite, or a comma-separated
+    list
+
+test
+    Speciifes a particular test to run, within a suite, or all suites
+
+-f
+    Forces running of a manual test.
+
+-r <n>
+    Specifies the number of types to run each test
+
+-I <n>:<one_test>
+    Test to run after <n> other tests have run.  This is used to find which test
+    causes another test to fail. If the one test fails, testing stops
+    immediately.
+
 Typically the command is run on :ref:`arch/sandbox/sandbox:sandbox` since it
 includes a near-complete set of emulators, no code-size limits, many CONFIG
 options enabled and runs easily in CI without needing QEMU. It is also possible
 to run some tests on real boards.
 
-For a list of available test suites, type `ut info -s`.
-
 Each test is normally run once, although those marked with `UTF_DM` are
 run with livetree and flattree where possible. To run a test more than once,
 use the `-r` flag.
 
 Manual tests are normally skipped by this command. Use `-f` to run them. See
-See :ref:`develop/tests_writing:mixing python and c` for more information on
-manual test.
+:ref:`develop/tests_writing:mixing python and c` for more information on manual
+tests.
 
 When running unit tests, some may have side effects which cause a subsequent
 test to break. This can sometimes be seen when using 'ut dm' or similar. To
@@ -50,9 +60,22 @@ the problem.
 Generally all tests in the suite are run. To run just a single test from the
 suite, provide the <test> argument.
 
+To specify a list of suites to run, <suites> can also be a comma-separated list.
+
 See :ref:`develop/tests_writing:writing c tests` for more information on how to
 write unit tests.
 
+ut all
+~~~~~~
+
+Instead of a suite name 'all' may be used to run all tests.
+
+ut info
+~~~~~~~
+
+This provides information about the total number of suites and tests. Use the
+`-s` flag to show a detailed list of suites.
+
 Example
 -------
 
@@ -97,26 +120,84 @@ List available unit-test suites::
 
 Run one of the suites::
 
-    => ut bloblist
-    Running 14 bloblist tests
-    Test: bloblist_test_align: bloblist.c
-    Test: bloblist_test_bad_blob: bloblist.c
-    Test: bloblist_test_blob: bloblist.c
-    Test: bloblist_test_blob_ensure: bloblist.c
-    Test: bloblist_test_blob_maxsize: bloblist.c
-    Test: bloblist_test_checksum: bloblist.c
-    Test: bloblist_test_cmd_info: bloblist.c
-    Test: bloblist_test_cmd_list: bloblist.c
-    Test: bloblist_test_grow: bloblist.c
-    Test: bloblist_test_init: bloblist.c
-    Test: bloblist_test_reloc: bloblist.c
-    Test: bloblist_test_resize_fail: bloblist.c
-    Test: bloblist_test_resize_last: bloblist.c
-    Test: bloblist_test_shrink: bloblist.c
-    Failures: 0
+    => ut common
+    Running 14 common tests
+    Test: cli_ch_test: cread.c
+    Test: cread_test: cread.c
+    Test: dm_test_cyclic_running: cyclic.c
+    Test: print_display_buffer: print.c
+    Test: print_do_hex_dump: print.c
+    Test: print_efi_ut: print.c
+    Test: print_guid: print.c
+    Test: print_hexdump_line: print.c
+    Test: print_printf: print.c
+    Test: snprint: print.c
+    Test: test_autoboot: test_autoboot.c
+    Enter password "a" in 1 seconds to stop autoboot
+    Enter password "a" in 1 seconds to stop autoboot
+    Enter password "a" in 1 seconds to stop autoboot
+    Enter password "a" in 1 seconds to stop autoboot
+    Enter password "a" in 1 seconds to stop autoboot
+    Enter password "a" in 1 seconds to stop autoboot
+    Autoboot password unlock not successful
+    Test: test_event_base: event.c
+    Test: test_event_probe: event.c
+    Test: test_event_probe: event.c (flat tree)
+    Test: test_event_simple: event.c
+    Tests run: 14, 2611 ms, average 186 ms, skipped: 2, failures: 0
 
 Run just a single test in a suite::
 
-    => ut bloblist bloblist_test_grow
-    Test: bloblist_test_grow: bloblist.c
-    Failures: 0
+    => ut fdt_overlay change_int_property
+    Test: fdt_overlay_init: cmd_ut_fdt_overlay.c
+    Test: change_int_property: cmd_ut_fdt_overlay.c
+    Tests run: 2, 0 ms, average 0 ms, failures: 0
+
+Run a selection of three suites::
+
+    => ut bloblist,mem,fdt_overlay
+    Running 14 bloblist tests
+    Test: align: bloblist.c
+    Test: bad_blob: bloblist.c
+    Test: blob: bloblist.c
+    Test: blob_ensure: bloblist.c
+    Test: blob_maxsize: bloblist.c
+    Test: checksum: bloblist.c
+    Test: cmd_info: bloblist.c
+    Test: cmd_list: bloblist.c
+    Test: grow: bloblist.c
+    Test: init: bloblist.c
+    Test: reloc: bloblist.c
+    Test: resize_fail: bloblist.c
+    Test: resize_last: bloblist.c
+    Test: shrink: bloblist.c
+    Tests run: 14, 1 ms, average: 0 ms, failures: 0
+    Running 13 mem tests
+    Test: cp_b: mem_copy.c
+    Test: cp_l: mem_copy.c
+    Test: cp_q: mem_copy.c
+    Test: cp_w: mem_copy.c
+    Test: ms_b: mem_search.c
+    Test: ms_cont: mem_search.c
+    Test: ms_cont_end: mem_search.c
+    Test: ms_l: mem_search.c
+    Test: ms_limit: mem_search.c
+    Test: ms_mult: mem_search.c
+    Test: ms_quiet: mem_search.c
+    Test: ms_s: mem_search.c
+    Test: ms_w: mem_search.c
+    Tests run: 13, 13 ms, average: 1 ms, failures: 0
+    Running 10 fdt_overlay tests
+    Test: fdt_overlay_init: cmd_ut_fdt_overlay.c
+    Test: add_node_by_path: cmd_ut_fdt_overlay.c
+    Test: add_node_by_phandle: cmd_ut_fdt_overlay.c
+    Test: add_str_property: cmd_ut_fdt_overlay.c
+    Test: add_subnode_property: cmd_ut_fdt_overlay.c
+    Test: change_int_property: cmd_ut_fdt_overlay.c
+    Test: change_str_property: cmd_ut_fdt_overlay.c
+    Test: local_phandle: cmd_ut_fdt_overlay.c
+    Test: local_phandles: cmd_ut_fdt_overlay.c
+    Test: stacked: cmd_ut_fdt_overlay.c
+    Tests run: 10, 12 ms, average: 1 ms, failures: 0
+    Suites run: 3, total tests run: 37, 26 ms, average: 0 ms, failures: 0
+    Average test time: 0 ms, worst case 'mem' took 1 ms
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 6c0b39ff60c..44e5fdfdaa6 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -321,14 +321,16 @@ static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 }
 
 U_BOOT_LONGHELP(ut,
-	"[-r] [-f] [<suite>] - run unit tests\n"
+	"[-rs] [-f] [-I<n>:<one_test>][<suites>] - run unit tests\n"
 	"   -r<runs>   Number of times to run each test\n"
 	"   -f         Force 'manual' tests to run as well\n"
-	"   <suite>    Test suite to run, or all\n"
+	"   -I         Test to run after <n> other tests have run\n"
+	"   -s         Show all suites with ut info\n"
+	"   <suites>   Comma-separated list of suites to run\n"
 	"\n"
-	"\nOptions for <suite>:"
-	"\nall - execute all enabled tests"
-	"\ninfo [-s] - show info about tests [and suites]"
+	"Options for <suite>:\n"
+	"all       - execute all enabled tests\n"
+	"info      - show info about tests [and suites]"
 	);
 
 U_BOOT_CMD(
-- 
2.43.0

