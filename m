Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53795C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 14:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6808B88C55;
	Thu, 22 Aug 2024 15:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VidggAXc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0667288916; Thu, 22 Aug 2024 15:58:32 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4368288651
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-81f921c40f2so32717339f.0
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724335107; x=1724939907; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KvpL4dVVzQRGIKo2c4NlerOyQxYJ5OPZnpI9cq1im+k=;
 b=VidggAXctFhDDTpryiIJOZiflKuLfC/NfPxhwauTzUml9SJoMlxc4bZ8ktpxuPuOXb
 raSMpxkliaWBIxdLGKF/YGvhtEcMl88jdYwrlx8F2vyqxuKZjvBNyJAQvKN7o3Ww52m5
 6xqRxSNeSJWi+asGLkU2XLacilVyODpDDPIn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724335107; x=1724939907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KvpL4dVVzQRGIKo2c4NlerOyQxYJ5OPZnpI9cq1im+k=;
 b=ZUM/Gram5sScPCcPUqs6D7rrIFOhjLcTnC/MxJgWZ4vsZdpoGdVCgKoB1eoC+MC9mo
 3D5H9h8dwQXjetH/mcWPjh4n1N6p5WhlncJg7+5BxO+uPD7khL+TVdVo475d2+D9cxt/
 XGSbWIHsJfl8B4qtqUwKm4NxijBrBVP0fHrGH6w9WLsAH5HoteW6i62V9sBreGtv7kfl
 kkkvJlB73L7PlSC0vLd7gbeuUfK0UsYgqSIMHD5TlxTUavIOZ9IHOvVs8kAZXnCsmg45
 dHThSDWIXyMEXO0oWbTJ30GSgoZcFl9fIJxWqSD5vWbUwe2+LBcKkWrrCEiF4JQaIrw1
 6IRg==
X-Gm-Message-State: AOJu0YyZhH1CN2FUrBM09dQHLLKsd/CnH8NsR/cy4861fVn2rRtCwg8/
 YSrZGHsoGYZR6kXZpXO84BahWTzPKLg1yVImfybuDxyLYsVgonM7iU9GH0Ccat7WNfwo9zJXnFI
 =
X-Google-Smtp-Source: AGHT+IE95U6eY45HhtQXbBLSlfd2e+N1R3uUBuhaoBO+KqfWPl6uO7YvvztP8GP/xi7K6DupGl37wg==
X-Received: by 2002:a05:6e02:20e7:b0:39d:37de:4196 with SMTP id
 e9e14a558f8ab-39d6c3bc2d0mr61411545ab.18.1724335106346; 
 Thu, 22 Aug 2024 06:58:26 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e747eesm6793275ab.29.2024.08.22.06.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:58:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 13/19] test: cmd: Drop unnecessary
 console_record_reset_enable()
Date: Thu, 22 Aug 2024 07:57:58 -0600
Message-Id: <20240822135804.2375959-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135804.2375959-1-sjg@chromium.org>
References: <20240822135804.2375959-1-sjg@chromium.org>
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

It is seldom necessary to call this function. Drop its use in the
command tests.

Add a few extra checks to the wget test so that resetting is not
needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd/addrmap.c     |  1 -
 test/cmd/bdinfo.c      |  4 --
 test/cmd/exit.c        | 12 ------
 test/cmd/fdt.c         | 83 +-----------------------------------------
 test/cmd/font.c        |  1 -
 test/cmd/loadm.c       |  2 -
 test/cmd/mbr.c         |  7 +---
 test/cmd/mem_search.c  | 13 -------
 test/cmd/pinmux.c      |  3 --
 test/cmd/pwm.c         |  4 --
 test/cmd/rw.c          |  2 -
 test/cmd/seama.c       |  3 --
 test/cmd/setexpr.c     |  1 -
 test/cmd/temperature.c |  2 -
 test/cmd/test_echo.c   |  5 +--
 test/cmd/test_pause.c  |  5 +--
 test/cmd/wget.c        |  4 +-
 17 files changed, 8 insertions(+), 144 deletions(-)

diff --git a/test/cmd/addrmap.c b/test/cmd/addrmap.c
index abeb467aede..b34be895f5d 100644
--- a/test/cmd/addrmap.c
+++ b/test/cmd/addrmap.c
@@ -15,7 +15,6 @@
 /* Test 'addrmap' command output */
 static int addrmap_test_basic(struct unit_test_state *uts)
 {
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_command("addrmap", 0));
 	ut_assert_nextline("           vaddr            paddr             size");
 	ut_assert_nextline("================ ================ ================");
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 1d038bec29c..810174fe8d1 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -235,7 +235,6 @@ static int bdinfo_test_all(struct unit_test_state *uts)
 static int bdinfo_test_full(struct unit_test_state *uts)
 {
 	/* Test BDINFO full print */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("bdinfo"));
 	ut_assertok(bdinfo_test_all(uts));
 	ut_assertok(run_commandf("bdinfo -a"));
@@ -249,7 +248,6 @@ BDINFO_TEST(bdinfo_test_full, UTF_CONSOLE);
 static int bdinfo_test_help(struct unit_test_state *uts)
 {
 	/* Test BDINFO unknown option help text print */
-	ut_assertok(console_record_reset_enable());
 	if (!CONFIG_IS_ENABLED(GETOPT)) {
 		ut_asserteq(0, run_commandf("bdinfo -h"));
 		ut_assertok(bdinfo_test_all(uts));
@@ -270,7 +268,6 @@ BDINFO_TEST(bdinfo_test_help, UTF_CONSOLE);
 static int bdinfo_test_memory(struct unit_test_state *uts)
 {
 	/* Test BDINFO memory layout only print */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("bdinfo -m"));
 	if (!CONFIG_IS_ENABLED(GETOPT))
 		ut_assertok(bdinfo_test_all(uts));
@@ -285,7 +282,6 @@ BDINFO_TEST(bdinfo_test_memory, UTF_CONSOLE);
 static int bdinfo_test_eth(struct unit_test_state *uts)
 {
 	/* Test BDINFO ethernet settings only print */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("bdinfo -e"));
 	if (!CONFIG_IS_ENABLED(GETOPT))
 		ut_assertok(bdinfo_test_all(uts));
diff --git a/test/cmd/exit.c b/test/cmd/exit.c
index d416607d610..093f51b4dfc 100644
--- a/test/cmd/exit.c
+++ b/test/cmd/exit.c
@@ -33,13 +33,11 @@ static int cmd_exit_test(struct unit_test_state *uts)
 	 * - return value can be printed outside of 'run' command
 	 */
 	for (i = -3; i <= 3; i++) {
-		ut_assertok(console_record_reset_enable());
 		ut_assertok(run_commandf("setenv foo 'echo bar ; exit %d ; echo baz' ; run foo ; echo $?", i));
 		ut_assert_nextline("bar");
 		ut_assert_nextline("%d", i > 0 ? i : 0);
 		ut_assertok(ut_check_console_end(uts));
 
-		ut_assertok(console_record_reset_enable());
 		ut_assertok(run_commandf("setenv foo 'echo bar ; exit %d ; echo baz' ; run foo && echo quux ; echo $?", i));
 		ut_assert_nextline("bar");
 		if (i <= 0)
@@ -47,7 +45,6 @@ static int cmd_exit_test(struct unit_test_state *uts)
 		ut_assert_nextline("%d", i > 0 ? i : 0);
 		ut_assertok(ut_check_console_end(uts));
 
-		ut_assertok(console_record_reset_enable());
 		ut_assertok(run_commandf("setenv foo 'echo bar ; exit %d ; echo baz' ; run foo || echo quux ; echo $?", i));
 		ut_assert_nextline("bar");
 		if (i > 0)
@@ -58,20 +55,17 @@ static int cmd_exit_test(struct unit_test_state *uts)
 	}
 
 	/* Validate that 'exit' behaves the same way as 'exit 0' */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("setenv foo 'echo bar ; exit ; echo baz' ; run foo ; echo $?"));
 	ut_assert_nextline("bar");
 	ut_assert_nextline("0");
 	ut_assertok(ut_check_console_end(uts));
 
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("setenv foo 'echo bar ; exit ; echo baz' ; run foo && echo quux ; echo $?"));
 	ut_assert_nextline("bar");
 	ut_assert_nextline("quux");
 	ut_assert_nextline("0");
 	ut_assertok(ut_check_console_end(uts));
 
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("setenv foo 'echo bar ; exit ; echo baz' ; run foo || echo quux ; echo $?"));
 	ut_assert_nextline("bar");
 	/* Either 'exit' returns 0, or 'echo quux' returns 0 */
@@ -79,39 +73,33 @@ static int cmd_exit_test(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Validate that return value still propagates from 'run' command */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("setenv foo 'echo bar ; true' ; run foo ; echo $?"));
 	ut_assert_nextline("bar");
 	ut_assert_nextline("0");
 	ut_assertok(ut_check_console_end(uts));
 
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("setenv foo 'echo bar ; true' ; run foo && echo quux ; echo $?"));
 	ut_assert_nextline("bar");
 	ut_assert_nextline("quux");
 	ut_assert_nextline("0");
 	ut_assertok(ut_check_console_end(uts));
 
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("setenv foo 'echo bar ; true' ; run foo || echo quux ; echo $?"));
 	ut_assert_nextline("bar");
 	/* The 'true' returns 0 */
 	ut_assert_nextline("0");
 	ut_assertok(ut_check_console_end(uts));
 
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("setenv foo 'echo bar ; false' ; run foo ; echo $?"));
 	ut_assert_nextline("bar");
 	ut_assert_nextline("1");
 	ut_assertok(ut_check_console_end(uts));
 
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("setenv foo 'echo bar ; false' ; run foo && echo quux ; echo $?"));
 	ut_assert_nextline("bar");
 	ut_assert_nextline("1");
 	ut_assertok(ut_check_console_end(uts));
 
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("setenv foo 'echo bar ; false' ; run foo || echo quux ; echo $?"));
 	ut_assert_nextline("bar");
 	ut_assert_nextline("quux");
diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index d7b96bc5725..ac0d6f06150 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -168,7 +168,6 @@ static int fdt_test_addr(struct unit_test_state *uts)
 	ulong addr;
 	int ret;
 
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_command("fdt addr -c", 0));
 	ut_assert_nextline("Control fdt: %08lx",
 			   (ulong)map_to_sysmem(gd->fdt_blob));
@@ -241,7 +240,6 @@ static int fdt_test_addr_resize(struct unit_test_state *uts)
 	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt), &addr));
 
 	/* Test setting and resizing the working FDT to a larger size */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt addr %08lx %x", addr, newsize));
 	ut_assert_nextline("Working FDT set to %lx", addr);
 	ut_assertok(ut_check_console_end(uts));
@@ -280,13 +278,11 @@ static int fdt_test_move(struct unit_test_state *uts)
 	memset(buf, 0, size);
 
 	/* Test moving the working FDT to a new location */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt move %08lx %08lx %x", addr, newaddr, ts));
 	ut_assert_nextline("Working FDT set to %lx", newaddr);
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Compare the source and destination DTs */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("cmp.b %08lx %08lx %x", addr, newaddr, ts));
 	ut_assert_nextline("Total of %d byte(s) were the same", ts);
 	ut_assertok(ut_check_console_end(uts));
@@ -308,7 +304,6 @@ static int fdt_test_resize(struct unit_test_state *uts)
 	ts = fdt_totalsize(fdt);
 
 	/* Test resizing the working FDT and verify the new space was added */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt resize %x", newsize));
 	ut_asserteq(ts + newsize, fdt_totalsize(fdt));
 	ut_assertok(ut_check_console_end(uts));
@@ -324,7 +319,6 @@ static int fdt_test_print_list_common(struct unit_test_state *uts,
 	 * Test printing/listing the working FDT
 	 * subnode $node/subnode
 	 */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt %s %s/subnode", opc, node));
 	ut_assert_nextline("subnode {");
 	ut_assert_nextline("\t#address-cells = <0x00000000>;");
@@ -337,7 +331,6 @@ static int fdt_test_print_list_common(struct unit_test_state *uts,
 	 * Test printing/listing the working FDT
 	 * path / string property model
 	 */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt %s / model", opc));
 	ut_assert_nextline("model = \"U-Boot FDT test\"");
 	ut_assertok(ut_check_console_end(uts));
@@ -346,7 +339,6 @@ static int fdt_test_print_list_common(struct unit_test_state *uts,
 	 * Test printing/listing the working FDT
 	 * path $node string property compatible
 	 */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt %s %s compatible", opc, node));
 	ut_assert_nextline("compatible = \"u-boot,fdt-test-device1\"");
 	ut_assertok(ut_check_console_end(uts));
@@ -355,7 +347,6 @@ static int fdt_test_print_list_common(struct unit_test_state *uts,
 	 * Test printing/listing the working FDT
 	 * path $node stringlist property clock-names
 	 */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt %s %s clock-names", opc, node));
 	ut_assert_nextline("clock-names = \"fixed\", \"i2c\", \"spi\", \"uart2\", \"uart1\"");
 	ut_assertok(ut_check_console_end(uts));
@@ -364,7 +355,6 @@ static int fdt_test_print_list_common(struct unit_test_state *uts,
 	 * Test printing/listing the working FDT
 	 * path $node u32 property clock-frequency
 	 */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt %s %s clock-frequency", opc, node));
 	ut_assert_nextline("clock-frequency = <0x00fde800>");
 	ut_assertok(ut_check_console_end(uts));
@@ -373,7 +363,6 @@ static int fdt_test_print_list_common(struct unit_test_state *uts,
 	 * Test printing/listing the working FDT
 	 * path $node empty property u-boot,empty-property
 	 */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt %s %s u-boot,empty-property", opc, node));
 	/*
 	 * This is the only 'fdt print' / 'fdt list' incantation which
@@ -387,7 +376,6 @@ static int fdt_test_print_list_common(struct unit_test_state *uts,
 	 * Test printing/listing the working FDT
 	 * path $node prop-encoded array property regs
 	 */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt %s %s regs", opc, node));
 	ut_assert_nextline("regs = <0x00001234 0x00001000>");
 	ut_assertok(ut_check_console_end(uts));
@@ -406,7 +394,6 @@ static int fdt_test_print_list(struct unit_test_state *uts, bool print)
 	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt), &addr));
 
 	/* Test printing/listing the working FDT -- node / */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt %s", opc));
 	ut_assert_nextline("/ {");
 	ut_assert_nextline("\t#address-cells = <0x00000001>;");
@@ -464,7 +451,6 @@ static int fdt_test_get_value_string(struct unit_test_state *uts,
 				     const char *idx,  const char *strres,
 				     const int intres)
 {
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt get value var %s %s %s",
 				 node, prop, idx ? : ""));
 	if (strres)
@@ -514,17 +500,14 @@ static int fdt_test_get_value_common(struct unit_test_state *uts,
 					      0x1000));
 
 	/* Test missing 10th element of $node node clock-names property */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_commandf("fdt get value ften %s clock-names 10", node));
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test missing 10th element of $node node regs property */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_commandf("fdt get value ften %s regs 10", node));
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test getting default element of $node node nonexistent property */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_commandf("fdt get value fnone %s nonexistent", node));
 	ut_assert_nextline("libfdt fdt_getprop(): FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
@@ -543,19 +526,16 @@ static int fdt_test_get_value(struct unit_test_state *uts)
 	ut_assertok(fdt_test_get_value_common(uts, "testnodealias"));
 
 	/* Test getting default element of /nonexistent node */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_command("fdt get value fnode /nonexistent nonexistent", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test getting default element of bad alias */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_command("fdt get value vbadalias badalias nonexistent", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test getting default element of nonexistent alias */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_command("fdt get value vnoalias noalias nonexistent", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_BADPATH");
 	ut_assertok(ut_check_console_end(uts));
@@ -572,31 +552,26 @@ static int fdt_test_get_name(struct unit_test_state *uts)
 	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt), &addr));
 
 	/* Test getting name of node 0 in /, which is /aliases node */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_command("fdt get name nzero / 0", 0));
 	ut_asserteq_str("aliases", env_get("nzero"));
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test getting name of node 1 in /, which is /test-node@1234 node */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_command("fdt get name none / 1", 0));
 	ut_asserteq_str("test-node@1234", env_get("none"));
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test getting name of node -1 in /, which is /aliases node, same as 0 */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_command("fdt get name nmone / -1", 0));
 	ut_asserteq_str("aliases", env_get("nmone"));
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test getting name of node 2 in /, which does not exist */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_command("fdt get name ntwo / 2", 1));
 	ut_assert_nextline("libfdt node not found");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test getting name of node 0 in /test-node@1234, which is /subnode node */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_command("fdt get name snzero /test-node@1234 0", 0));
 	ut_asserteq_str("subnode", env_get("snzero"));
 	ut_assertok(run_command("fdt get name asnzero testnodealias 0", 0));
@@ -604,7 +579,6 @@ static int fdt_test_get_name(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test getting name of node 1 in /test-node@1234, which does not exist */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_command("fdt get name snone /test-node@1234 1", 1));
 	ut_assert_nextline("libfdt node not found");
 	ut_asserteq(1, run_command("fdt get name asnone testnodealias 1", 1));
@@ -612,7 +586,6 @@ static int fdt_test_get_name(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test getting name of node -1 in /test-node@1234, which is /subnode node, same as 0 */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_command("fdt get name snmone /test-node@1234 -1", 0));
 	ut_asserteq_str("subnode", env_get("snmone"));
 	ut_assertok(run_command("fdt get name asnmone testnodealias -1", 0));
@@ -620,19 +593,16 @@ static int fdt_test_get_name(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test getting name of nonexistent node */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_command("fdt get name nonode /nonexistent 0", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test getting name of bad alias */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_command("fdt get name vbadalias badalias 0", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test getting name of nonexistent alias */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_command("fdt get name vnoalias noalias 0", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_BADPATH");
 	ut_assertok(ut_check_console_end(uts));
@@ -655,7 +625,6 @@ static int fdt_test_get_addr_common(struct unit_test_state *uts, char *fdt,
 	ut_assertnonnull(prop_ptr);
 	offset = (char *)prop_ptr - fdt;
 
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt get addr pstr %s %s", path, prop));
 	ut_asserteq((ulong)map_sysmem(env_get_hex("fdtaddr", 0x1234), 0),
 		    (ulong)(map_sysmem(env_get_hex("pstr", 0x1234), 0) - offset));
@@ -699,13 +668,11 @@ static int fdt_test_get_addr(struct unit_test_state *uts)
 					     "regs"));
 
 	/* Test getting address of node /test-node@1234/subnode non-existent property "noprop" */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_command("fdt get addr pnoprop /test-node@1234/subnode noprop", 1));
 	ut_assert_nextline("libfdt fdt_getprop(): FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test getting address of non-existent node /test-node@1234/nonode@1 property "noprop" */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_command("fdt get addr pnonode /test-node@1234/nonode@1 noprop", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
@@ -718,7 +685,6 @@ static int fdt_test_get_size_common(struct unit_test_state *uts,
 				     const char *path, const char *prop,
 				     const unsigned int val)
 {
-	ut_assertok(console_record_reset_enable());
 	if (prop) {
 		ut_assertok(run_commandf("fdt get size sstr %s %s", path, prop));
 	} else {
@@ -772,7 +738,6 @@ static int fdt_test_get_size(struct unit_test_state *uts)
 	ut_assertok(fdt_test_get_size_common(uts, "subnodealias", NULL, 0));
 
 	/* Test getting size of node /test-node@1234/subnode non-existent property "noprop" */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_command("fdt get size pnoprop /test-node@1234/subnode noprop", 1));
 	ut_assert_nextline("libfdt fdt_getprop(): FDT_ERR_NOTFOUND");
 	ut_asserteq(1, run_command("fdt get size pnoprop subnodealias noprop", 1));
@@ -780,25 +745,21 @@ static int fdt_test_get_size(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test getting size of non-existent node /test-node@1234/nonode@1 property "noprop" */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_command("fdt get size pnonode /test-node@1234/nonode@1 noprop", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test getting node count of non-existent node /test-node@1234/nonode@1 */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_command("fdt get size pnonode /test-node@1234/nonode@1", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test getting node count of bad alias badalias */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_command("fdt get size pnonode badalias noprop", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test getting node count of non-existent alias noalias */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_command("fdt get size pnonode noalias", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_BADPATH");
 	ut_assertok(ut_check_console_end(uts));
@@ -817,7 +778,6 @@ static int fdt_test_set_single(struct unit_test_state *uts,
 	 * => fdt set /path property integer
 	 * => fdt set /path property
 	 */
-	ut_assertok(console_record_reset_enable());
 	if (sval)
 		ut_assertok(run_commandf("fdt set %s %s %s", path, prop, sval));
 	else if (integer)
@@ -855,7 +815,6 @@ static int fdt_test_set_multi(struct unit_test_state *uts,
 	 * new array is correctly sized and read past the new array length
 	 * triggers failure.
 	 */
-	ut_assertok(console_record_reset_enable());
 	if (sval1 && sval2) {
 		ut_assertok(run_commandf("fdt set %s %s %s %s end", path, prop, sval1, sval2));
 		ut_assertok(run_commandf("fdt set %s %s %s %s", path, prop, sval1, sval2));
@@ -928,19 +887,16 @@ static int fdt_test_set(struct unit_test_state *uts)
 	ut_assertok(fdt_test_set_node(uts, "subnodealias", "newproperty"));
 
 	/* Test setting property of non-existent node */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_command("fdt set /no-node noprop", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test setting property of non-existent alias */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_command("fdt set noalias noprop", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_BADPATH");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test setting property of bad alias */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_command("fdt set badalias noprop", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
@@ -958,7 +914,6 @@ static int fdt_test_mknode(struct unit_test_state *uts)
 	fdt_shrink_to_minimum(fdt, 4096);	/* Resize with 4096 extra bytes */
 
 	/* Test creation of new node in / */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt mknode / newnode"));
 	ut_assertok(run_commandf("fdt list /newnode"));
 	ut_assert_nextline("newnode {");
@@ -966,7 +921,6 @@ static int fdt_test_mknode(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test creation of new node in /test-node@1234 */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt mknode /test-node@1234 newsubnode"));
 	ut_assertok(run_commandf("fdt list /test-node@1234/newsubnode"));
 	ut_assert_nextline("newsubnode {");
@@ -974,7 +928,6 @@ static int fdt_test_mknode(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test creation of new node in /test-node@1234 by alias */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt mknode testnodealias newersubnode"));
 	ut_assertok(run_commandf("fdt list testnodealias/newersubnode"));
 	ut_assert_nextline("newersubnode {");
@@ -982,31 +935,26 @@ static int fdt_test_mknode(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test creation of new node in /test-node@1234 over existing node */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_commandf("fdt mknode testnodealias newsubnode"));
 	ut_assert_nextline("libfdt fdt_add_subnode(): FDT_ERR_EXISTS");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test creation of new node in /test-node@1234 by alias over existing node */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_commandf("fdt mknode testnodealias newersubnode"));
 	ut_assert_nextline("libfdt fdt_add_subnode(): FDT_ERR_EXISTS");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test creation of new node in non-existent node */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_commandf("fdt mknode /no-node newnosubnode"));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test creation of new node in non-existent alias */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_commandf("fdt mknode noalias newfailsubnode"));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_BADPATH");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test creation of new node in bad alias */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_commandf("fdt mknode badalias newbadsubnode"));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
@@ -1023,7 +971,6 @@ static int fdt_test_rm(struct unit_test_state *uts)
 	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt), &addr));
 
 	/* Test removal of property in root node / */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt print / compatible"));
 	ut_assert_nextline("compatible = \"u-boot,fdt-test\"");
 	ut_assertok(run_commandf("fdt rm / compatible"));
@@ -1032,7 +979,6 @@ static int fdt_test_rm(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test removal of property clock-names in subnode /test-node@1234 */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt print /test-node@1234 clock-names"));
 	ut_assert_nextline("clock-names = \"fixed\", \"i2c\", \"spi\", \"uart2\", \"uart1\"");
 	ut_assertok(run_commandf("fdt rm /test-node@1234 clock-names"));
@@ -1041,7 +987,6 @@ static int fdt_test_rm(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test removal of property u-boot,empty-property in subnode /test-node@1234 by alias */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt print testnodealias u-boot,empty-property"));
 	ut_assert_nextline("testnodealias u-boot,empty-property");
 	ut_assertok(run_commandf("fdt rm testnodealias u-boot,empty-property"));
@@ -1050,45 +995,38 @@ static int fdt_test_rm(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test removal of non-existent property noprop in subnode /test-node@1234 */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_commandf("fdt rm /test-node@1234 noprop"));
 	ut_assert_nextline("libfdt fdt_delprop(): FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test removal of non-existent node /no-node@5678 */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_commandf("fdt rm /no-node@5678"));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test removal of subnode /test-node@1234/subnode by alias */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt rm subnodealias"));
 	ut_asserteq(1, run_commandf("fdt print /test-node@1234/subnode"));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test removal of node by non-existent alias */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_commandf("fdt rm noalias"));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_BADPATH");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test removal of node by bad alias */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_commandf("fdt rm noalias"));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_BADPATH");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test removal of node /test-node@1234 */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt rm /test-node@1234"));
 	ut_asserteq(1, run_commandf("fdt print /test-node@1234"));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test removal of node / */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt rm /"));
 	ut_asserteq(1, run_commandf("fdt print /"));
 	ut_assertok(ut_check_console_end(uts));
@@ -1106,19 +1044,16 @@ static int fdt_test_bootcpu(struct unit_test_state *uts)
 	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt), &addr));
 
 	/* Test getting default bootcpu entry */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt header get bootcpu boot_cpuid_phys"));
 	ut_asserteq(0, env_get_ulong("bootcpu", 10, 0x1234));
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test setting and getting new bootcpu entry, twice, to test overwrite */
 	for (i = 42; i <= 43; i++) {
-		ut_assertok(console_record_reset_enable());
 		ut_assertok(run_commandf("fdt bootcpu %d", i));
 		ut_assertok(ut_check_console_end(uts));
 
 		/* Test getting new bootcpu entry */
-		ut_assertok(console_record_reset_enable());
 		ut_assertok(run_commandf("fdt header get bootcpu boot_cpuid_phys"));
 		ut_asserteq(i, env_get_ulong("bootcpu", 10, 0x1234));
 		ut_assertok(ut_check_console_end(uts));
@@ -1132,13 +1067,11 @@ static int fdt_test_header_get(struct unit_test_state *uts,
 			       const char *field, const unsigned long val)
 {
 	/* Test getting valid header entry */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt header get fvar %s", field));
 	ut_asserteq(val, env_get_hex("fvar", 0x1234));
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test getting malformed header entry */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_commandf("fdt header get fvar typo%stypo", field));
 	ut_assertok(ut_check_console_end(uts));
 
@@ -1153,7 +1086,6 @@ static int fdt_test_header(struct unit_test_state *uts)
 	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt), &addr));
 
 	/* Test header print */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt header"));
 	ut_assert_nextline("magic:\t\t\t0x%x", fdt_magic(fdt));
 	ut_assert_nextline("totalsize:\t\t0x%x (%d)", fdt_totalsize(fdt), fdt_totalsize(fdt));
@@ -1234,9 +1166,9 @@ static int fdt_test_memory_cells(struct unit_test_state *uts,
 	fdt_shrink_to_minimum(fdt, 4096);	/* Resize with 4096 extra bytes */
 	addr = map_to_sysmem(fdt);
 	set_working_fdt_addr(addr);
+	ut_assert_nextline("Working FDT set to %lx", addr);
 
 	/* Test updating the memory node */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt memory 0x%s 0x%s", seta, sets));
 	ut_assertok(run_commandf("fdt print /memory"));
 	ut_assert_nextline("memory {");
@@ -1286,7 +1218,6 @@ static int fdt_test_rsvmem(struct unit_test_state *uts)
 	fdt_add_mem_rsv(fdt, 0x74656, 0x9);
 
 	/* Test default reserved memory node presence */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt rsvmem print"));
 	ut_assert_nextline("index\t\t   start\t\t    size");
 	ut_assert_nextline("------------------------------------------------");
@@ -1295,7 +1226,6 @@ static int fdt_test_rsvmem(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test add new reserved memory node */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt rsvmem add 0x1234 0x5678"));
 	ut_assertok(run_commandf("fdt rsvmem print"));
 	ut_assert_nextline("index\t\t   start\t\t    size");
@@ -1306,7 +1236,6 @@ static int fdt_test_rsvmem(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test delete reserved memory node */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt rsvmem delete 0"));
 	ut_assertok(run_commandf("fdt rsvmem print"));
 	ut_assert_nextline("index\t\t   start\t\t    size");
@@ -1316,7 +1245,6 @@ static int fdt_test_rsvmem(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test re-add new reserved memory node */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt rsvmem add 0x42 0x1701"));
 	ut_assertok(run_commandf("fdt rsvmem print"));
 	ut_assert_nextline("index\t\t   start\t\t    size");
@@ -1327,7 +1255,6 @@ static int fdt_test_rsvmem(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test delete nonexistent reserved memory node */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_commandf("fdt rsvmem delete 10"));
 	ut_assert_nextline("libfdt fdt_del_mem_rsv(): FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
@@ -1346,13 +1273,11 @@ static int fdt_test_chosen(struct unit_test_state *uts)
 	fdt_shrink_to_minimum(fdt, 4096);	/* Resize with 4096 extra bytes */
 
 	/* Test default chosen node presence, fail as there is no /chosen node */
-	ut_assertok(console_record_reset_enable());
 	ut_asserteq(1, run_commandf("fdt print /chosen"));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test add new chosen node without initrd */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt chosen"));
 	ut_assertok(run_commandf("fdt print /chosen"));
 	ut_assert_nextline("chosen {");
@@ -1367,7 +1292,6 @@ static int fdt_test_chosen(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test add new chosen node with initrd */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt chosen 0x1234 0x5678"));
 	ut_assertok(run_commandf("fdt print /chosen"));
 	ut_assert_nextline("chosen {");
@@ -1406,6 +1330,7 @@ static int fdt_test_apply(struct unit_test_state *uts)
 	fdt_shrink_to_minimum(fdt, 4096);	/* Resize with 4096 extra bytes */
 	addr = map_to_sysmem(fdt);
 	set_working_fdt_addr(addr);
+	ut_assert_nextline("Working FDT set to %lx", addr);
 
 	/* Create DTO which adds single property to root node / */
 	ut_assertok(fdt_create(fdto, sizeof(fdto)));
@@ -1421,7 +1346,6 @@ static int fdt_test_apply(struct unit_test_state *uts)
 	addro = map_to_sysmem(fdto);
 
 	/* Test default DT print */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt print /"));
 	ut_assert_nextline("/ {");
 	ut_assert_nextline("\t__symbols__ {");
@@ -1430,7 +1354,6 @@ static int fdt_test_apply(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test simple DTO application */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt apply 0x%08lx", addro));
 	ut_assertok(run_commandf("fdt print /"));
 	ut_assert_nextline("/ {");
@@ -1475,7 +1398,6 @@ static int fdt_test_apply(struct unit_test_state *uts)
 	addro = map_to_sysmem(fdto);
 
 	/* Test complex DTO application */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt apply 0x%08lx", addro));
 	ut_assertok(run_commandf("fdt print /"));
 	ut_assert_nextline("/ {");
@@ -1519,7 +1441,6 @@ static int fdt_test_apply(struct unit_test_state *uts)
 	addro = map_to_sysmem(fdto);
 
 	/* Test complex DTO application */
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt apply 0x%08lx", addro));
 	ut_assertok(run_commandf("fdt print /"));
 	ut_assert_nextline("/ {");
diff --git a/test/cmd/font.c b/test/cmd/font.c
index 08600dfe2eb..6f4e54e7f3f 100644
--- a/test/cmd/font.c
+++ b/test/cmd/font.c
@@ -26,7 +26,6 @@ static int font_test_base(struct unit_test_state *uts)
 	ut_assertok(uclass_first_device_err(UCLASS_VIDEO, &dev));
 	ut_assertok(uclass_first_device_err(UCLASS_VIDEO_CONSOLE, &dev));
 
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_command("font list", 0));
 	ut_assert_nextline("nimbus_sans_l_regular");
 	if (IS_ENABLED(CONFIG_CONSOLE_TRUETYPE_CANTORAONE))
diff --git a/test/cmd/loadm.c b/test/cmd/loadm.c
index 29ae8339183..dedb4f7683e 100644
--- a/test/cmd/loadm.c
+++ b/test/cmd/loadm.c
@@ -23,7 +23,6 @@
 
 static int loadm_test_params(struct unit_test_state *uts)
 {
-	ut_assertok(console_record_reset_enable());
 	run_command("loadm", 0);
 	ut_assert_nextline("loadm - load binary blob from source address to destination address");
 
@@ -51,7 +50,6 @@ static int loadm_test_load (struct unit_test_state *uts)
 	memset(buf, '\0', BUF_SIZE);
 	memset(buf, 0xaa, BUF_SIZE / 2);
 
-	ut_assertok(console_record_reset_enable());
 	run_command("loadm 0x0 0x80 0x80", 0);
 	ut_assert_nextline("loaded bin to memory: size: 128");
 
diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index 0c3698afb0b..8c9d01130a3 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -261,7 +261,6 @@ static int mbr_test_run(struct unit_test_state *uts)
 
 	/* Make sure mmc6 exists */
 	ut_asserteq(6, blk_get_device_by_str("mmc", "6", &mmc_dev_desc));
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("mmc dev 6"));
 	ut_assert_nextline("switch to partitions #0, OK");
 	ut_assert_nextline("mmc6 is current device");
@@ -281,9 +280,9 @@ static int mbr_test_run(struct unit_test_state *uts)
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
-	ut_assertok(console_record_reset_enable());
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertok(run_commandf("mbr write mmc 6"));
+	ut_assert_nextlinen("MMC read: dev # 6");
 	ut_assert_nextline("MBR: write success!");
 	ut_assertok(run_commandf("mbr verify mmc 6"));
 	ut_assert_nextline("MBR: verify success!");
@@ -317,7 +316,6 @@ static int mbr_test_run(struct unit_test_state *uts)
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
-	ut_assertok(console_record_reset_enable());
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertok(run_commandf("mbr write mmc 6"));
 	ut_assert_nextline("MBR: write success!");
@@ -353,7 +351,6 @@ static int mbr_test_run(struct unit_test_state *uts)
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
-	ut_assertok(console_record_reset_enable());
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertok(run_commandf("mbr write mmc 6"));
 	ut_assert_nextline("MBR: write success!");
@@ -389,7 +386,6 @@ static int mbr_test_run(struct unit_test_state *uts)
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
-	ut_assertok(console_record_reset_enable());
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertok(run_commandf("mbr write mmc 6"));
 	ut_assert_nextline("MBR: write success!");
@@ -425,7 +421,6 @@ static int mbr_test_run(struct unit_test_state *uts)
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
-	ut_assertok(console_record_reset_enable());
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertf(0 == run_commandf("mbr write mmc 6"), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assert_nextline("MBR: write success!");
diff --git a/test/cmd/mem_search.c b/test/cmd/mem_search.c
index 1387baea032..3a031eed7ed 100644
--- a/test/cmd/mem_search.c
+++ b/test/cmd/mem_search.c
@@ -27,7 +27,6 @@ static int mem_test_ms_b(struct unit_test_state *uts)
 	buf[0x31] = 0x12;
 	buf[0xff] = 0x12;
 	buf[0x100] = 0x12;
-	ut_assertok(console_record_reset_enable());
 	run_command("ms.b 1 ff 12", 0);
 	ut_assert_nextline("00000030: 00 12 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................");
 	ut_assert_nextline("--");
@@ -54,7 +53,6 @@ static int mem_test_ms_w(struct unit_test_state *uts)
 	memset(buf, '\0', BUF_SIZE);
 	buf[0x34 / 2] = 0x1234;
 	buf[BUF_SIZE / 2] = 0x1234;
-	ut_assertok(console_record_reset_enable());
 	run_command("ms.w 0 80 1234", 0);
 	ut_assert_nextline("00000030: 0000 0000 1234 0000 0000 0000 0000 0000  ....4...........");
 	ut_assert_nextline("1 match");
@@ -79,7 +77,6 @@ static int mem_test_ms_l(struct unit_test_state *uts)
 	memset(buf, '\0', BUF_SIZE);
 	buf[0x38 / 4] = 0x12345678;
 	buf[BUF_SIZE / 4] = 0x12345678;
-	ut_assertok(console_record_reset_enable());
 	run_command("ms 0 40 12345678", 0);
 	ut_assert_nextline("00000030: 00000000 00000000 12345678 00000000  ........xV4.....");
 	ut_assert_nextline("1 match");
@@ -89,7 +86,6 @@ static int mem_test_ms_l(struct unit_test_state *uts)
 	ut_asserteq(0x38, env_get_hex("memaddr", 0));
 	ut_asserteq(0x38 / 4, env_get_hex("mempos", 0));
 
-	ut_assertok(console_record_reset_enable());
 	run_command("ms 0 80 12345679", 0);
 	ut_assert_nextline("0 matches");
 	ut_assert_console_end();
@@ -116,7 +112,6 @@ static int mem_test_ms_cont(struct unit_test_state *uts)
 	memset(buf, '\0', BUF_SIZE);
 	for (i = 5; i < 0x33; i += 3)
 		buf[i] = 0x34;
-	ut_assertok(console_record_reset_enable());
 	run_command("ms.b 0 100 34", 0);
 	ut_assert_nextlinen("00000000: 00 00 00 00 00 34 00 00 34 00 00 34 00 00 34 00");
 	ut_assert_nextline("--");
@@ -134,7 +129,6 @@ static int mem_test_ms_cont(struct unit_test_state *uts)
 	 * run_command() ignoes the repeatable flag when using hush, so call
 	 * cmd_process() directly
 	 */
-	ut_assertok(console_record_reset_enable());
 	cmd_process(CMD_FLAG_REPEAT, 4, args, &repeatable, NULL);
 	ut_assert_nextlinen("00000020: 34 00 00 34 00 00 34 00 00 34 00 00 34 00 00 34");
 	ut_assert_nextline("--");
@@ -167,7 +161,6 @@ static int mem_test_ms_cont_end(struct unit_test_state *uts)
 	buf[0x31] = 0x12;
 	buf[0xff] = 0x12;
 	buf[0x100] = 0x12;
-	ut_assertok(console_record_reset_enable());
 	run_command("ms.b 1 ff 12", 0);
 	ut_assert_nextlinen("00000030");
 	ut_assert_nextlinen("--");
@@ -181,13 +174,11 @@ static int mem_test_ms_cont_end(struct unit_test_state *uts)
 	 *
 	 * This should produce no matches.
 	 */
-	ut_assertok(console_record_reset_enable());
 	cmd_process(CMD_FLAG_REPEAT, 4, args, &repeatable, NULL);
 	ut_assert_nextlinen("0 matches");
 	ut_assert_console_end();
 
 	/* One more time */
-	ut_assertok(console_record_reset_enable());
 	cmd_process(CMD_FLAG_REPEAT, 4, args, &repeatable, NULL);
 	ut_assert_nextlinen("0 matches");
 	ut_assert_console_end();
@@ -239,7 +230,6 @@ static int mem_test_ms_s(struct unit_test_state *uts)
 	strcpy(buf + 0x1e, str);
 	strcpy(buf + 0x63, str);
 	strcpy(buf + 0xa1, str2);
-	ut_assertok(console_record_reset_enable());
 	run_command("ms.s 0 100 hello", 0);
 	ut_assert_nextline("00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 68 65  ..............he");
 	ut_assert_nextline("00000020: 6c 6c 6f 00 00 00 00 00 00 00 00 00 00 00 00 00  llo.............");
@@ -254,7 +244,6 @@ static int mem_test_ms_s(struct unit_test_state *uts)
 	ut_asserteq(0xa1, env_get_hex("memaddr", 0));
 	ut_asserteq(0xa1, env_get_hex("mempos", 0));
 
-	ut_assertok(console_record_reset_enable());
 	run_command("ms.s 0 100 hello there", 0);
 	ut_assert_nextline("000000a0: 00 68 65 6c 6c 6f 74 68 65 72 65 00 00 00 00 00  .hellothere.....");
 	ut_assert_nextline("1 match");
@@ -281,7 +270,6 @@ static int mem_test_ms_limit(struct unit_test_state *uts)
 	buf[0x31] = 0x12;
 	buf[0x62] = 0x12;
 	buf[0x76] = 0x12;
-	ut_assertok(console_record_reset_enable());
 	run_command("ms.b -l2 1 ff 12", 0);
 	ut_assert_nextline("00000030: 00 12 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................");
 	ut_assert_nextline("--");
@@ -310,7 +298,6 @@ static int mem_test_ms_quiet(struct unit_test_state *uts)
 	buf[0x31] = 0x12;
 	buf[0x62] = 0x12;
 	buf[0x76] = 0x12;
-	ut_assertok(console_record_reset_enable());
 	run_command("ms.b -q -l2 1 ff 12", 0);
 	ut_assert_console_end();
 	unmap_sysmem(buf);
diff --git a/test/cmd/pinmux.c b/test/cmd/pinmux.c
index 7ee92690756..be39dbc61bd 100644
--- a/test/cmd/pinmux.c
+++ b/test/cmd/pinmux.c
@@ -18,17 +18,14 @@ static int dm_test_cmd_pinmux_status_pinname(struct unit_test_state *uts)
 	ut_assertok(uclass_get_device(UCLASS_LED, 2, &dev));
 
 	/* Test that 'pinmux status <pinname>' displays the selected pin. */
-	console_record_reset();
 	run_command("pinmux status a5", 0);
 	ut_assert_nextlinen("a5        : gpio output .");
 	ut_assert_console_end();
 
-	console_record_reset();
 	run_command("pinmux status P7", 0);
 	ut_assert_nextlinen("P7        : GPIO2 bias-pull-down input-enable.");
 	ut_assert_console_end();
 
-	console_record_reset();
 	run_command("pinmux status P9", 0);
 	ut_assert_nextlinen("single-pinctrl pinctrl-single-no-width: missing register width");
 	ut_assert_nextlinen("P9 not found");
diff --git a/test/cmd/pwm.c b/test/cmd/pwm.c
index f8de03fd6d1..0d47e2d8abb 100644
--- a/test/cmd/pwm.c
+++ b/test/cmd/pwm.c
@@ -22,8 +22,6 @@ static int dm_test_pwm_cmd(struct unit_test_state *uts)
 	ut_assertok(uclass_get_device(UCLASS_PWM, 0, &dev));
 	ut_assertnonnull(dev);
 
-	ut_assertok(console_record_reset_enable());
-
 	/* pwm <invert> <pwm_dev_num> <channel> <polarity> */
 	/* cros-ec-pwm doesn't support invert */
 	ut_asserteq(1, run_command("pwm invert 0 0 1", 0));
@@ -49,8 +47,6 @@ static int dm_test_pwm_cmd(struct unit_test_state *uts)
 	ut_assertok(uclass_get_device(UCLASS_PWM, 1, &dev));
 	ut_assertnonnull(dev);
 
-	ut_assertok(console_record_reset_enable());
-
 	/* pwm <invert> <pwm_dev_num> <channel> <polarity> */
 	ut_assertok(run_command("pwm invert 1 0 1", 0));
 	ut_assert_console_end();
diff --git a/test/cmd/rw.c b/test/cmd/rw.c
index 1086dcd2914..0a856c44ede 100644
--- a/test/cmd/rw.c
+++ b/test/cmd/rw.c
@@ -87,12 +87,10 @@ static int dm_test_read_write(struct unit_test_state *uts)
 	ut_assertok(memcmp(wbuf, rbuf, sizeof(wbuf)));
 
 	/* Read/write outside partition bounds should be rejected upfront. */
-	console_record_reset_enable();
 	ut_asserteq(1, run_commandf("read mmc 2#data 0x%lx 3 2", ra));
 	ut_assert_nextlinen("read out of range");
 	ut_assert_console_end();
 
-	console_record_reset_enable();
 	ut_asserteq(1, run_commandf("write mmc 2#log 0x%lx 9 2", wa));
 	ut_assert_nextlinen("write out of range");
 	ut_assert_console_end();
diff --git a/test/cmd/seama.c b/test/cmd/seama.c
index 802563e4f71..28d6b9ab517 100644
--- a/test/cmd/seama.c
+++ b/test/cmd/seama.c
@@ -16,7 +16,6 @@
 static int seama_test_noargs(struct unit_test_state *uts)
 {
 	/* Test that 'seama' with no arguments fails gracefully */
-	console_record_reset();
 	run_command("seama", 0);
 	ut_assert_nextlinen("seama - Load the SEAMA image and sets envs");
 	ut_assert_skipline();
@@ -31,7 +30,6 @@ SEAMA_TEST(seama_test_noargs, UTF_CONSOLE);
 static int seama_test_addr(struct unit_test_state *uts)
 {
 	/* Test that loads SEAMA image 0 to address 0x01000000 */
-	console_record_reset();
 	run_command("seama 0x01000000", 0);
 	ut_assert_nextlinen("Loading SEAMA image 0 from nand0");
 	ut_assert_nextlinen("SEMA IMAGE:");
@@ -47,7 +45,6 @@ SEAMA_TEST(seama_test_addr, UTF_CONSOLE);
 static int seama_test_index(struct unit_test_state *uts)
 {
 	/* Test that loads SEAMA image 0 exlicitly specified */
-	console_record_reset();
 	run_command("seama 0x01000000 0", 0);
 	ut_assert_nextlinen("Loading SEAMA image 0 from nand0");
 	ut_assert_nextlinen("SEMA IMAGE:");
diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index dcd0e3726e4..21a3268bd81 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -340,7 +340,6 @@ static int setexpr_test_str_oper(struct unit_test_state *uts)
 	strcpy(buf, "hello");
 	strcpy(buf + 0x10, " there");
 
-	ut_assertok(console_record_reset_enable());
 	start_mem = ut_check_free();
 	ut_asserteq(1, run_command("setexpr.s fred *0 * *10", 0));
 	ut_assertok(ut_check_delta(start_mem));
diff --git a/test/cmd/temperature.c b/test/cmd/temperature.c
index 193fa6324ea..309693aa1e8 100644
--- a/test/cmd/temperature.c
+++ b/test/cmd/temperature.c
@@ -18,8 +18,6 @@ static int dm_test_cmd_temperature(struct unit_test_state *uts)
 	ut_assertok(uclass_get_device(UCLASS_THERMAL, 0, &dev));
 	ut_assertnonnull(dev);
 
-	ut_assertok(console_record_reset_enable());
-
 	/* Test that "temperature list" shows the sandbox device */
 	ut_assertok(run_command("temperature list", 0));
 	ut_assert_nextline("| Device                        | Driver                        | Parent");
diff --git a/test/cmd/test_echo.c b/test/cmd/test_echo.c
index ee07ab22933..b829f71c591 100644
--- a/test/cmd/test_echo.c
+++ b/test/cmd/test_echo.c
@@ -45,10 +45,7 @@ static int lib_test_hush_echo(struct unit_test_state *uts)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(echo_data); ++i) {
-		ut_silence_console(uts);
-		console_record_reset_enable();
 		ut_assertok(run_command(echo_data[i].cmd, 0));
-		ut_unsilence_console(uts);
 		console_record_readline(uts->actual_str,
 					sizeof(uts->actual_str));
 		ut_asserteq_str(echo_data[i].expected, uts->actual_str);
@@ -56,4 +53,4 @@ static int lib_test_hush_echo(struct unit_test_state *uts)
 	}
 	return 0;
 }
-LIB_TEST(lib_test_hush_echo, 0);
+LIB_TEST(lib_test_hush_echo, UTF_CONSOLE);
diff --git a/test/cmd/test_pause.c b/test/cmd/test_pause.c
index 3703290350b..927fe174d74 100644
--- a/test/cmd/test_pause.c
+++ b/test/cmd/test_pause.c
@@ -14,7 +14,6 @@ DECLARE_GLOBAL_DATA_PTR;
 static int lib_test_hush_pause(struct unit_test_state *uts)
 {
 	/* Test default message */
-	console_record_reset_enable();
 	/* Cook a newline when the command is expected to pause */
 	console_in_puts("\n");
 	ut_assertok(run_command("pause", 0));
@@ -23,7 +22,6 @@ static int lib_test_hush_pause(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test provided message */
-	console_record_reset_enable();
 	/* Cook a newline when the command is expected to pause */
 	console_in_puts("\n");
 	ut_assertok(run_command("pause 'Prompt for pause...'", 0));
@@ -32,7 +30,6 @@ static int lib_test_hush_pause(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test providing more than one params */
-	console_record_reset_enable();
 	/* No newline cooked here since the command is expected to fail */
 	ut_asserteq(1, run_command("pause a b", 0));
 	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
@@ -41,4 +38,4 @@ static int lib_test_hush_pause(struct unit_test_state *uts)
 
 	return 0;
 }
-LIB_TEST(lib_test_hush_pause, 0);
+LIB_TEST(lib_test_hush_pause, UTF_CONSOLE);
diff --git a/test/cmd/wget.c b/test/cmd/wget.c
index a91aa24722c..1660d2bdcb0 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -213,10 +213,12 @@ static int net_test_wget(struct unit_test_state *uts)
 	env_set("ethrotate", "no");
 	env_set("loadaddr", "0x20000");
 	ut_assertok(run_command("wget ${loadaddr} 1.1.2.2:/index.html", 0));
+	ut_assert_nextline("HTTP/1.1 200 OK");
+	ut_assert_nextline("Packets received 5, Transfer Successful");
+	ut_assert_nextline("Bytes transferred = 32 (20 hex)");
 
 	sandbox_eth_set_tx_handler(0, NULL);
 
-	ut_assertok(console_record_reset_enable());
 	run_command("md5sum ${loadaddr} ${filesize}", 0);
 	ut_assert_nextline("md5 for 00020000 ... 0002001f ==> 234af48e94b0085060249ecb5942ab57");
 	ut_assertok(ut_check_console_end(uts));
-- 
2.34.1

