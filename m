Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B663C3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 20:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1D6C88C4A;
	Sat, 10 Aug 2024 22:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YiSdqzM8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DCA888C25; Sat, 10 Aug 2024 22:52:44 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F800888C2
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 22:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-81f94ce2272so121552439f.2
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 13:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723323157; x=1723927957; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JtOBeMZgxOvwE1hCxzTnU3fRljxAmnaZYwb4swAbgDs=;
 b=YiSdqzM8AeGVcrQ4mz5UxuL/tp5Vra7lC52tqFYcwsv4FFUuS66paJBOwy4HKinqC5
 9Sqg+UuCMweb8dmX5qv4dqx7qScYy31lGmw1cL2UBVA3IZG9+WYv3i5qmlb4F7wFOtOH
 1M1UNzTKypZsGuM9zwqlriYbcWFbwvMMUwXzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723323157; x=1723927957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JtOBeMZgxOvwE1hCxzTnU3fRljxAmnaZYwb4swAbgDs=;
 b=Q0FYkLvrtTmQN1lX96VJ8jZ1Dc5BmHpMrEKBa+UNiRUnKKNPrCGiaaGwQTRX4aUS3V
 hROTsi4RrsbadRNC/tO61lruOhX1r8ENbJaJLtuoibNrhiMTGPQj0YRryLtFsSbsLCXg
 gRYC9lf8NC2C7tTzdJw3JTBcmiZTFQCued7mZ4EUedQSfVmdxBUZuOS48H1hx7Xf0+6K
 9qF7XPxuBpnTMBViVAbjSbb63PCwoNvCcJiiAx4EU0G3B69b4k6Q+sezQN02w/WCeeRJ
 1XZ29r69lHlQ6U8sUd/VU+jZl4cLFl9eQSUqhqzhTlnNildjP3HcXIeC7zxZSor+3o+n
 yrLg==
X-Gm-Message-State: AOJu0YxoSqx/pp4UNGF33tkY2hmCNU/Da4HK2sj7M3eNZJwD/BuE84Yd
 DWLe/7YVz9glYfRRlywKKo9BOyjOf0yEe6bbTDZK7pjwT8oCXVca+lpvx9Bk7ueYNfYeaOh3sXM
 =
X-Google-Smtp-Source: AGHT+IEgaD5kQRSMsEaWSinkkPncrafAIRs0rlBSDWEq/oe4A0AIFgd36GKRd6qVyQihXuX+9PIQWg==
X-Received: by 2002:a05:6602:13d2:b0:81f:94cd:7600 with SMTP id
 ca18e2360f4ac-8225eec5836mr801993939f.13.1723323156895; 
 Sat, 10 Aug 2024 13:52:36 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82266f56333sm82893139f.0.2024.08.10.13.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 13:52:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>, Yurii Monakov <monakov.y@gmail.com>
Subject: [PATCH 19/21] test: Use UTF_CONSOLE in remaining tests
Date: Sat, 10 Aug 2024 14:52:03 -0600
Message-Id: <20240810205205.3403177-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810205205.3403177-1-sjg@chromium.org>
References: <20240810205205.3403177-1-sjg@chromium.org>
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

Set this flag rather than doing things manually in the test.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/common/cread.c         |  4 +---
 test/common/test_autoboot.c |  3 +--
 test/lib/test_print.c       | 10 ++--------
 test/print_ut.c             | 15 ---------------
 4 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/test/common/cread.c b/test/common/cread.c
index e159caed041..4926c216803 100644
--- a/test/common/cread.c
+++ b/test/common/cread.c
@@ -66,8 +66,6 @@ static int cread_test(struct unit_test_state *uts)
 	 * print_buffer(0, buf, 1, 7, 0);
 	 */
 
-	console_record_reset_enable();
-
 	/* simple input */
 	*buf = '\0';
 	ut_asserteq(4, console_in_puts("abc\n"));
@@ -102,4 +100,4 @@ static int cread_test(struct unit_test_state *uts)
 
 	return 0;
 }
-COMMON_TEST(cread_test, 0);
+COMMON_TEST(cread_test, UTF_CONSOLE);
diff --git a/test/common/test_autoboot.c b/test/common/test_autoboot.c
index a556cbf8e33..e3050d02c60 100644
--- a/test/common/test_autoboot.c
+++ b/test/common/test_autoboot.c
@@ -20,7 +20,6 @@ static int check_for_input(struct unit_test_state *uts, const char *in,
 	const char *autoboot_prompt =
 		"Enter password \"a\" in 1 seconds to stop autoboot";
 
-	console_record_reset_enable();
 	console_in_puts(in);
 
 	/* turn on keyed autoboot for the test, if possible */
@@ -91,4 +90,4 @@ static int test_autoboot(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-COMMON_TEST(test_autoboot, 0);
+COMMON_TEST(test_autoboot, UTF_CONSOLE);
diff --git a/test/lib/test_print.c b/test/lib/test_print.c
index e356afc22ba..55e3ea1ed59 100644
--- a/test/lib/test_print.c
+++ b/test/lib/test_print.c
@@ -17,10 +17,7 @@ DECLARE_GLOBAL_DATA_PTR;
 static int test_print_freq(struct unit_test_state *uts,
 			   uint64_t freq, char *expected)
 {
-	ut_silence_console(uts);
-	console_record_reset_enable();
 	print_freq(freq, ";\n");
-	ut_unsilence_console(uts);
 	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
 	ut_asserteq_str(expected, uts->actual_str);
 	ut_assertok(ut_check_console_end(uts));
@@ -41,15 +38,12 @@ static int lib_test_print_freq(struct unit_test_state *uts)
 	ut_assertok(test_print_freq(uts, 54321987654321, "54321.99 GHz;"));
 	return 0;
 }
-LIB_TEST(lib_test_print_freq, 0);
+LIB_TEST(lib_test_print_freq, UTF_CONSOLE);
 
 static int test_print_size(struct unit_test_state *uts,
 			   uint64_t freq, char *expected)
 {
-	ut_silence_console(uts);
-	console_record_reset_enable();
 	print_size(freq, ";\n");
-	ut_unsilence_console(uts);
 	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
 	ut_asserteq_str(expected, uts->actual_str);
 	ut_assertok(ut_check_console_end(uts));
@@ -73,4 +67,4 @@ static int lib_test_print_size(struct unit_test_state *uts)
 	ut_assertok(test_print_size(uts, 54321987654321, "49.4 TiB;"));
 	return 0;
 }
-LIB_TEST(lib_test_print_size, 0);
+LIB_TEST(lib_test_print_size, UTF_CONSOLE);
diff --git a/test/print_ut.c b/test/print_ut.c
index cf0d5929508..f5e607b21a3 100644
--- a/test/print_ut.c
+++ b/test/print_ut.c
@@ -180,14 +180,12 @@ static int print_display_buffer(struct unit_test_state *uts)
 		buf[i] = i * 0x11;
 
 	/* bytes */
-	console_record_reset();
 	print_buffer(0, buf, 1, 0x12, 0);
 	ut_assert_nextline("00000000: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff  ..\"3DUfw........");
 	ut_assert_nextline("00000010: 10 00                                            ..");
 	ut_assert_console_end();
 
 	/* line length */
-	console_record_reset();
 	print_buffer(0, buf, 1, 0x12, 8);
 	ut_assert_nextline("00000000: 00 11 22 33 44 55 66 77  ..\"3DUfw");
 	ut_assert_nextline("00000008: 88 99 aa bb cc dd ee ff  ........");
@@ -195,7 +193,6 @@ static int print_display_buffer(struct unit_test_state *uts)
 	ut_assert_console_end();
 
 	/* long line */
-	console_record_reset();
 	buf[0x41] = 0x41;
 	print_buffer(0, buf, 1, 0x42, 0x40);
 	ut_assert_nextline("00000000: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..\"3DUfw........................................................");
@@ -203,35 +200,30 @@ static int print_display_buffer(struct unit_test_state *uts)
 	ut_assert_console_end();
 
 	/* address */
-	console_record_reset();
 	print_buffer(0x12345678, buf, 1, 0x12, 0);
 	ut_assert_nextline("12345678: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff  ..\"3DUfw........");
 	ut_assert_nextline("12345688: 10 00                                            ..");
 	ut_assert_console_end();
 
 	/* 16-bit */
-	console_record_reset();
 	print_buffer(0, buf, 2, 9, 0);
 	ut_assert_nextline("00000000: 1100 3322 5544 7766 9988 bbaa ddcc ffee  ..\"3DUfw........");
 	ut_assert_nextline("00000010: 0010                                     ..");
 	ut_assert_console_end();
 
 	/* 32-bit */
-	console_record_reset();
 	print_buffer(0, buf, 4, 5, 0);
 	ut_assert_nextline("00000000: 33221100 77665544 bbaa9988 ffeeddcc  ..\"3DUfw........");
 	ut_assert_nextline("00000010: 00000010                             ....");
 	ut_assert_console_end();
 
 	/* 64-bit */
-	console_record_reset();
 	print_buffer(0, buf, 8, 3, 0);
 	ut_assert_nextline("00000000: 7766554433221100 ffeeddccbbaa9988  ..\"3DUfw........");
 	ut_assert_nextline("00000010: 0000000000000010                   ........");
 	ut_assert_console_end();
 
 	/* ASCII */
-	console_record_reset();
 	buf[1] = 31;
 	buf[2] = 32;
 	buf[3] = 33;
@@ -289,7 +281,6 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 		buf[i] = i * 0x11;
 
 	/* bytes */
-	console_record_reset();
 	print_hex_dump_bytes("", DUMP_PREFIX_ADDRESS, buf, 0x12);
 	ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff  ..\"3DUfw........",
 			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
@@ -298,7 +289,6 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 	ut_assert_console_end();
 
 	/* line length */
-	console_record_reset();
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 8, 1, buf, 0x12, true);
 	ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77  ..\"3DUfw",
 			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
@@ -310,7 +300,6 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 	unmap_sysmem(buf);
 
 	/* long line */
-	console_record_reset();
 	buf[0x41] = 0x41;
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0x40, 1, buf, 0x42, true);
 	ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..\"3DUfw........................................................",
@@ -320,7 +309,6 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 	ut_assert_console_end();
 
 	/* 16-bit */
-	console_record_reset();
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 2, buf, 0x12, true);
 	ut_assert_nextline("%0*lx: 1100 3322 5544 7766 9988 bbaa ddcc ffee  ..\"3DUfw........",
 			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
@@ -330,7 +318,6 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 	unmap_sysmem(buf);
 
 	/* 32-bit */
-	console_record_reset();
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 4, buf, 0x14, true);
 	ut_assert_nextline("%0*lx: 33221100 77665544 bbaa9988 ffeeddcc  ..\"3DUfw........",
 			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
@@ -340,7 +327,6 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 	unmap_sysmem(buf);
 
 	/* 64-bit */
-	console_record_reset();
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 16, 8, buf, 0x18, true);
 	ut_assert_nextline("%0*lx: 7766554433221100 ffeeddccbbaa9988  ..\"3DUfw........",
 			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
@@ -350,7 +336,6 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 	unmap_sysmem(buf);
 
 	/* ASCII */
-	console_record_reset();
 	buf[1] = 31;
 	buf[2] = 32;
 	buf[3] = 33;
-- 
2.34.1

