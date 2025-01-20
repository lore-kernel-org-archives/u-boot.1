Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5597C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1308A807C4;
	Mon, 20 Jan 2025 22:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HTea+2Jn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A82D80A38; Mon, 20 Jan 2025 22:54:45 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8239280B9B
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3ce87d31480so19102885ab.2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410080; x=1738014880; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWriQagD4My1vLW67CCy6Vdqq5Zs2JJpPaAfEldsKsQ=;
 b=HTea+2JnwMYHfxibbRtSFhMNMyviKxBrCNmk6RatkHpc4YMtKwCoFXtmq6OBXquNA9
 PZ8dbajY1hXm96mMKZW3zx2aKK77Y+Oz16MkmgA5VdBIv4pessLxcIwzFVtVIt5OvPUZ
 sxDhmJP7W2yF/CsUYzlcZwys/5FKzXNddG1nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410080; x=1738014880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWriQagD4My1vLW67CCy6Vdqq5Zs2JJpPaAfEldsKsQ=;
 b=ZPJu0iZLjty2T5mYYeLhJ42D6NOS1ebPUnmvc+ESnIYbmqlJfRGS4UB7/zjU6vcUXE
 rCuNkejSwoo5yhBq6+mgqqwc8+y/HYciXyR5SLFev00PMJVEGbYsy1ZZ+CK04X4irRuL
 n1F5xueUNpl1rcwT8u7T7IjEqSQinmeA/XPWT1rUSTulMGm16MHaLmCI+/xJDp5QBu0P
 zl/ZGbxS4CLGdCjxCGNScRMgDu4N+DTN9EI7QKNh1Bqn1nKf/+5XkLa95bHXAAjxOLvf
 0vK1tqcfdeJfvkRzYcPp2On8f/QUhMfukNw62RFGOPdNxpwn59MrGcbg3RrJ0QvJpAKO
 iGOQ==
X-Gm-Message-State: AOJu0YxWo2qNFmL+34O3fFtKKVnTONm04uUwo5A/elTVk6NtUuCA4iRa
 Uq0/X5tC53z6noe5Znyfjc/AzdP+qS4qV1Q3oqvYnExmDX8bnUT4DaX6VYzlDutJyPWu76HFtCM
 =
X-Gm-Gg: ASbGncsQYV2v8Ar4VOIfakjyM3WZBaOQmc/jVizpchQ3/vBQJ/py8R29/lRcgNl7QSf
 6qkEO/1ZPvfyt6ywFqk7qnQOaKAp8tqNLYlcFSXJOej4MaWgPsch/sjnJS4bpK95IFfLR7btxt6
 fLrFm5Wl5GTl1BnkSgvoc7khM6hSBQVNQWh6aBD9qYz/uzQ1K2pw/a5B6EgXFzc57mAwOgfOr4G
 fsJ15uLGaV7VPV30Q3IURqqRARKgeJa+swJNEa5LC4sHwe9a1dvzJ6mVeJvkEfzpyDF0lOEMMIb
 PYeOLs1LxeylGh5vSDhLqpP6sqyOwEM=
X-Google-Smtp-Source: AGHT+IHGPK8NMqr9uIhl+8Qt7uBJmw2hEulk37KdeLntsnZYgIh9kfgDlgDuUdhQ22gcuq1rR6kzig==
X-Received: by 2002:a05:6e02:1a67:b0:3ce:80b8:7328 with SMTP id
 e9e14a558f8ab-3cf743a9a61mr103738955ab.3.1737410080494; 
 Mon, 20 Jan 2025 13:54:40 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 28/28] test: Update documentation
Date: Mon, 20 Jan 2025 14:53:28 -0700
Message-ID: <20250120215340.617194-29-sjg@chromium.org>
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

Update documentation for how to write tests and the 'ut' command.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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
index 07d0a91f697..d00f5bff242 100644
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

