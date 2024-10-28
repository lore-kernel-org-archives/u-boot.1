Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3F4D1039A
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4AD8890BC;
	Mon, 28 Oct 2024 13:41:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KWNzDcTA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8728E890C5; Mon, 28 Oct 2024 13:41:43 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 716E989098
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9a68480164so589501266b.3
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119300; x=1730724100; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JBWjqBPZHoZqvtNJA/bmUBP7FiCC670ZkW4Qf3Euu08=;
 b=KWNzDcTAIOq9npMXwQpLOFbJaKiRIUCrOC6ayIe+jYMhj+Cy2vQpB8icdgYuTeQV8g
 mxmE5m9JHMSXaLLbEkVzJweDBQEiFWMO8PmHLb5vKGuawBBxXQhlqbIcaIiAnOv4L6li
 /tb7NUcbt1KXnN+2u/J8zVvseNE36nskMnlwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119300; x=1730724100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JBWjqBPZHoZqvtNJA/bmUBP7FiCC670ZkW4Qf3Euu08=;
 b=jYhjxHiiSCdMOFrC18aJK9/DI5KB9DPb7sP6vogO1/NU/Z71EbhQIOzrYhSugBAuR8
 4luD9qj3MzMLNdObVDByQ22sAwYrazToWjW/1YTQq/ffUE2u2LA2NhD2aUjukkQR9aIq
 zyIMOh7Pz4Sqq8fhbRjKXFOLPhudOXU12lFifbqW+GtHQyX7eCo7dm29ItL9dK0+7fu3
 CqnPeO9DK4X+o2A0JM6Kahl9XPSIElh9eR4RDbkk51RIL/Eg1uwowEEQpjKlneFzk+CL
 b3UoGKFeulSJ393CGb4nqHAAjQfoWaty35/pt0YJaor2aq58hHZSV9scQQPKN/NveXoL
 AxAQ==
X-Gm-Message-State: AOJu0YxLk46EYtSJSDwDVMrYf0FTBv7plT9MLWR6vxx8+wWFLAYzt82X
 eMcCpaOGxwOhCjT6+CQl69TuFcm5PT3reLo7/YkYx/lpzXZKRhutyWoIfp5AykYiTlj6ZEV22Lj
 jCA==
X-Google-Smtp-Source: AGHT+IE6tqDVYmLicj1dz8GYUblZveeJUszarSElM5XcBt2ebhqAUV8UNxd2LLJmiH+GFS0hBPkMJA==
X-Received: by 2002:a17:907:6d15:b0:a99:ecaf:4543 with SMTP id
 a640c23a62f3a-a9de5d8272dmr859936966b.25.1730119300304; 
 Mon, 28 Oct 2024 05:41:40 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:41:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/21] bloblist: test: doc: Move into the common suite
Date: Mon, 28 Oct 2024 13:41:08 +0100
Message-ID: <20241028124130.32072-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124130.32072-1-sjg@chromium.org>
References: <20241028124130.32072-1-sjg@chromium.org>
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

There is no particular need for bloblist to have its own test suite.
Move it into the common suite instead.

Add the missing help for 'common' and update the docs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/usage/cmd/ut.rst   | 29 +++++++++++++++++++++-------
 test/cmd_ut.c          |  6 +-----
 test/common/bloblist.c | 44 ++++++++++++++----------------------------
 3 files changed, 38 insertions(+), 41 deletions(-)

diff --git a/doc/usage/cmd/ut.rst b/doc/usage/cmd/ut.rst
index afeafa824d6..cadabb964e7 100644
--- a/doc/usage/cmd/ut.rst
+++ b/doc/usage/cmd/ut.rst
@@ -70,7 +70,6 @@ List available unit-test suites::
     Suites:
     all - execute all enabled tests
     addrmap - very basic test of addrmap command
-    bloblist - bloblist implementation
     bootstd - standard boot implementation
     compression - compressors and bootm decompression
     dm - driver model
@@ -89,8 +88,8 @@ List available unit-test suites::
 
 Run one of the suites::
 
-    => ut bloblist
-    Running 14 bloblist tests
+    => ut common
+    Running 21 common tests
     Test: bloblist_test_align: bloblist.c
     Test: bloblist_test_bad_blob: bloblist.c
     Test: bloblist_test_blob: bloblist.c
@@ -105,16 +104,32 @@ Run one of the suites::
     Test: bloblist_test_resize_fail: bloblist.c
     Test: bloblist_test_resize_last: bloblist.c
     Test: bloblist_test_shrink: bloblist.c
-    Failures: 0
+    Test: cli_ch_test: cread.c
+    Test: cread_test: cread.c
+    Test: dm_test_cyclic_running: cyclic.c
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
+    Skipped: 2, Failures: 0
+    =>
 
 Run just a single test in a suite::
 
-    => ut bloblist bloblist_test_grow
+    => ut common bloblist_test_grow
     Test: bloblist_test_grow: bloblist.c
     Failures: 0
 
 Show information about tests::
 
     => ut info
-    Test suites: 21
-    Total tests: 642
+    Test suites: 29
+    Total tests: 806
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 53fddebd49d..cba97725f76 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -113,8 +113,6 @@ static struct cmd_tbl cmd_ut_sub[] = {
 #ifdef CONFIG_SANDBOX
 	U_BOOT_CMD_MKENT(compression, CONFIG_SYS_MAXARGS, 1, do_ut_compression,
 			 "", ""),
-	U_BOOT_CMD_MKENT(bloblist, CONFIG_SYS_MAXARGS, 1, do_ut_bloblist,
-			 "", ""),
 	U_BOOT_CMD_MKENT(bootm, CONFIG_SYS_MAXARGS, 1, do_ut_bootm, "", ""),
 #endif
 	U_BOOT_CMD_MKENT(str, CONFIG_SYS_MAXARGS, 1, do_ut_str, "", ""),
@@ -198,15 +196,13 @@ U_BOOT_LONGHELP(ut,
 #ifdef CONFIG_CMD_BDI
 	"\nbdinfo - bdinfo command"
 #endif
-#ifdef CONFIG_SANDBOX
-	"\nbloblist - bloblist implementation"
-#endif
 #ifdef CONFIG_BOOTSTD
 	"\nbootstd - standard boot implementation"
 #endif
 #ifdef CONFIG_CMDLINE
 	"\ncmd - test various commands"
 #endif
+	"\ncommon   - tests for common/ directory"
 #ifdef CONFIG_SANDBOX
 	"\ncompression - compressors and bootm decompression"
 #endif
diff --git a/test/common/bloblist.c b/test/common/bloblist.c
index 7b90fa7f352..dbd174299fd 100644
--- a/test/common/bloblist.c
+++ b/test/common/bloblist.c
@@ -6,14 +6,10 @@
 #include <bloblist.h>
 #include <log.h>
 #include <mapmem.h>
-#include <test/suites.h>
+#include <test/common.h>
 #include <test/test.h>
 #include <test/ut.h>
 
-/* Declare a new bloblist test */
-#define BLOBLIST_TEST(_name, _flags) \
-		UNIT_TEST(_name, _flags, bloblist_test)
-
 enum {
 	TEST_TAG		= BLOBLISTT_U_BOOT_SPL_HANDOFF,
 	TEST_TAG2		= BLOBLISTT_VBOOT_CTX,
@@ -91,7 +87,7 @@ static int bloblist_test_init(struct unit_test_state *uts)
 
 	return 1;
 }
-BLOBLIST_TEST(bloblist_test_init, 0);
+COMMON_TEST(bloblist_test_init, 0);
 
 static int bloblist_test_blob(struct unit_test_state *uts)
 {
@@ -131,7 +127,7 @@ static int bloblist_test_blob(struct unit_test_state *uts)
 
 	return 0;
 }
-BLOBLIST_TEST(bloblist_test_blob, 0);
+COMMON_TEST(bloblist_test_blob, 0);
 
 /* Check bloblist_ensure_size_ret() */
 static int bloblist_test_blob_ensure(struct unit_test_state *uts)
@@ -165,7 +161,7 @@ static int bloblist_test_blob_ensure(struct unit_test_state *uts)
 
 	return 0;
 }
-BLOBLIST_TEST(bloblist_test_blob_ensure, 0);
+COMMON_TEST(bloblist_test_blob_ensure, 0);
 
 static int bloblist_test_bad_blob(struct unit_test_state *uts)
 {
@@ -181,7 +177,7 @@ static int bloblist_test_bad_blob(struct unit_test_state *uts)
 
 	return 0;
 }
-BLOBLIST_TEST(bloblist_test_bad_blob, 0);
+COMMON_TEST(bloblist_test_bad_blob, 0);
 
 static int bloblist_test_checksum(struct unit_test_state *uts)
 {
@@ -254,7 +250,7 @@ static int bloblist_test_checksum(struct unit_test_state *uts)
 
 	return 0;
 }
-BLOBLIST_TEST(bloblist_test_checksum, 0);
+COMMON_TEST(bloblist_test_checksum, 0);
 
 /* Test the 'bloblist info' command */
 static int bloblist_test_cmd_info(struct unit_test_state *uts)
@@ -275,7 +271,7 @@ static int bloblist_test_cmd_info(struct unit_test_state *uts)
 
 	return 0;
 }
-BLOBLIST_TEST(bloblist_test_cmd_info, UTF_CONSOLE);
+COMMON_TEST(bloblist_test_cmd_info, UTF_CONSOLE);
 
 /* Test the 'bloblist list' command */
 static int bloblist_test_cmd_list(struct unit_test_state *uts)
@@ -297,7 +293,7 @@ static int bloblist_test_cmd_list(struct unit_test_state *uts)
 
 	return 0;
 }
-BLOBLIST_TEST(bloblist_test_cmd_list, UTF_CONSOLE);
+COMMON_TEST(bloblist_test_cmd_list, UTF_CONSOLE);
 
 /* Test alignment of bloblist blobs */
 static int bloblist_test_align(struct unit_test_state *uts)
@@ -355,7 +351,7 @@ static int bloblist_test_align(struct unit_test_state *uts)
 
 	return 0;
 }
-BLOBLIST_TEST(bloblist_test_align, 0);
+COMMON_TEST(bloblist_test_align, 0);
 
 /* Test relocation of a bloblist */
 static int bloblist_test_reloc(struct unit_test_state *uts)
@@ -389,7 +385,7 @@ static int bloblist_test_reloc(struct unit_test_state *uts)
 
 	return 0;
 }
-BLOBLIST_TEST(bloblist_test_reloc, 0);
+COMMON_TEST(bloblist_test_reloc, 0);
 
 /* Test expansion of a blob */
 static int bloblist_test_grow(struct unit_test_state *uts)
@@ -442,7 +438,7 @@ static int bloblist_test_grow(struct unit_test_state *uts)
 
 	return 0;
 }
-BLOBLIST_TEST(bloblist_test_grow, 0);
+COMMON_TEST(bloblist_test_grow, 0);
 
 /* Test shrinking of a blob */
 static int bloblist_test_shrink(struct unit_test_state *uts)
@@ -492,7 +488,7 @@ static int bloblist_test_shrink(struct unit_test_state *uts)
 
 	return 0;
 }
-BLOBLIST_TEST(bloblist_test_shrink, 0);
+COMMON_TEST(bloblist_test_shrink, 0);
 
 /* Test failing to adjust a blob size */
 static int bloblist_test_resize_fail(struct unit_test_state *uts)
@@ -527,7 +523,7 @@ static int bloblist_test_resize_fail(struct unit_test_state *uts)
 
 	return 0;
 }
-BLOBLIST_TEST(bloblist_test_resize_fail, 0);
+COMMON_TEST(bloblist_test_resize_fail, 0);
 
 /* Test expanding the last blob in a bloblist */
 static int bloblist_test_resize_last(struct unit_test_state *uts)
@@ -578,7 +574,7 @@ static int bloblist_test_resize_last(struct unit_test_state *uts)
 
 	return 0;
 }
-BLOBLIST_TEST(bloblist_test_resize_last, 0);
+COMMON_TEST(bloblist_test_resize_last, 0);
 
 /* Check a completely full bloblist */
 static int bloblist_test_blob_maxsize(struct unit_test_state *uts)
@@ -601,14 +597,4 @@ static int bloblist_test_blob_maxsize(struct unit_test_state *uts)
 
 	return 0;
 }
-BLOBLIST_TEST(bloblist_test_blob_maxsize, 0);
-
-int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
-		   char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(bloblist_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(bloblist_test);
-
-	return cmd_ut_category("bloblist", "bloblist_test_",
-			       tests, n_ents, argc, argv);
-}
+COMMON_TEST(bloblist_test_blob_maxsize, 0);
-- 
2.43.0

