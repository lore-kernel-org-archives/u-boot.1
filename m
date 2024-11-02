Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E794BE67805
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 238C289118;
	Sat,  2 Nov 2024 20:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KeaAOaZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A1298860B; Sat,  2 Nov 2024 20:37:56 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAC0E892CF
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cbe9e8bbb1so21728066d6.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576272; x=1731181072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/XGpASrZTE3TKI298Ztoxlkabo4q3UyskuD86ulKG8=;
 b=KeaAOaZUtFj0tLte9ycU2T09HRFl8G7FNTTTbYFEPGDELdEpo4QzGM3Kz5mh/oKhI2
 x1BrBuzqWKDG3ucc3x3Hz/qdf+wvsIuFR8HpLZEpqE4/056DGBCmwnk8V4O9+JEiNeQf
 aEtdKqtUGutxh802DucYvNcXz+q42AY/1dgpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576272; x=1731181072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/XGpASrZTE3TKI298Ztoxlkabo4q3UyskuD86ulKG8=;
 b=p6WoyLCRvTb3o6kuP/tYnUPpQxytaSVQjuPPDrOSDSquj6RyyDkVta9nGcAHRK1t5Q
 1AYdmNYaHX/0MHbuZKj07mr36jg1pUBSYjqYB6Dvyv1H4jUxAHsj/x9Oq9o8RpCYZF71
 CVlplTaR+LVU7NQ+l9PNw7u35KpLaFKRX2K0f8O6X8F5WVHeJtWJOiA7KLnciEts27yH
 xR8PgftGZQEABnEpCFSq5SY9pe1mvYqBx06hkEHpu7S97uLHk8CASYBB/dI5zVYABraB
 Z3AYWHFfuPZTbnCdOhEhiyV6kMn1qHRrPQiUByVNzLlyquq4geOCX86dzprA+a1so6gc
 Cy7g==
X-Gm-Message-State: AOJu0YxeGgGT2uF4zCHR+MmgYsKpuFS942iHiGy+fi23sCDsF2pdY5cW
 fh/5tIrnLJxeyWQgU6tLbUFfTRNCTS906IK3fejkTYBs7ubEJ02mBrFz86ehuD62Yusc/rFcddj
 /Rb38
X-Google-Smtp-Source: AGHT+IEMAn6FlEBfCxNCcQR0qIqFVOdj6DRRLVLYmAwLT2RxovhFERigbi5y35LzuTz/3QPfYNwpFg==
X-Received: by 2002:a05:6214:3a8b:b0:6cb:c199:462a with SMTP id
 6a1803df08f44-6d35c137657mr125001536d6.27.1730576271861; 
 Sat, 02 Nov 2024 12:37:51 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9dfeasm32324976d6.14.2024.11.02.12.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:37:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 13/20] str: test: Move into the lib suite
Date: Sat,  2 Nov 2024 13:36:58 -0600
Message-ID: <20241102193715.432529-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102193715.432529-1-sjg@chromium.org>
References: <20241102193715.432529-1-sjg@chromium.org>
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

There is no particular need for the str tests to have their own test
suite. Move them into the lib suite instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd_ut.c  |  4 ----
 test/lib/str.c | 31 ++++++++++---------------------
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 9b47a2c1a93..96bea4747fd 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -114,7 +114,6 @@ static struct cmd_tbl cmd_ut_sub[] = {
 			 "", ""),
 	U_BOOT_CMD_MKENT(bootm, CONFIG_SYS_MAXARGS, 1, do_ut_bootm, "", ""),
 #endif
-	U_BOOT_CMD_MKENT(str, CONFIG_SYS_MAXARGS, 1, do_ut_str, "", ""),
 #ifdef CONFIG_CMD_ADDRMAP
 	U_BOOT_CMD_MKENT(addrmap, CONFIG_SYS_MAXARGS, 1, do_ut_addrmap, "", ""),
 #endif
@@ -240,9 +239,6 @@ U_BOOT_LONGHELP(ut,
 	"\npci_mps - PCI Express Maximum Payload Size"
 #endif
 	"\nsetexpr - setexpr command"
-#ifdef CONFIG_SANDBOX
-	"\nstr - basic test of string functions"
-#endif
 #ifdef CONFIG_CMD_SEAMA
 	"\nseama - seama command parameters loading and decoding"
 #endif
diff --git a/test/lib/str.c b/test/lib/str.c
index 96e048975d8..3cc9dfea6aa 100644
--- a/test/lib/str.c
+++ b/test/lib/str.c
@@ -4,7 +4,7 @@
  */
 
 #include <vsprintf.h>
-#include <test/suites.h>
+#include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
 
@@ -19,9 +19,6 @@ static const char str5[] = "0x9876543210the last time I was deloused";
 static const char str6[] = "0778octal is seldom used";
 static const char str7[] = "707it is a piece of computing history";
 
-/* Declare a new str test */
-#define STR_TEST(_name, _flags)		UNIT_TEST(_name, _flags, str_test)
-
 static int str_upper(struct unit_test_state *uts)
 {
 	char out[TEST_STR_SIZE];
@@ -58,7 +55,7 @@ static int str_upper(struct unit_test_state *uts)
 
 	return 0;
 }
-STR_TEST(str_upper, 0);
+LIB_TEST(str_upper, 0);
 
 static int run_strtoul(struct unit_test_state *uts, const char *str, int base,
 		       ulong expect_val, int expect_endp_offset, bool upper)
@@ -112,7 +109,7 @@ static int str_simple_strtoul(struct unit_test_state *uts)
 
 	return 0;
 }
-STR_TEST(str_simple_strtoul, 0);
+LIB_TEST(str_simple_strtoul, 0);
 
 static int run_strtoull(struct unit_test_state *uts, const char *str, int base,
 			unsigned long long expect_val, int expect_endp_offset,
@@ -175,7 +172,7 @@ static int str_simple_strtoull(struct unit_test_state *uts)
 
 	return 0;
 }
-STR_TEST(str_simple_strtoull, 0);
+LIB_TEST(str_simple_strtoull, 0);
 
 static int str_hextoul(struct unit_test_state *uts)
 {
@@ -187,7 +184,7 @@ static int str_hextoul(struct unit_test_state *uts)
 
 	return 0;
 }
-STR_TEST(str_hextoul, 0);
+LIB_TEST(str_hextoul, 0);
 
 static int str_dectoul(struct unit_test_state *uts)
 {
@@ -199,7 +196,7 @@ static int str_dectoul(struct unit_test_state *uts)
 
 	return 0;
 }
-STR_TEST(str_dectoul, 0);
+LIB_TEST(str_dectoul, 0);
 
 static int str_itoa(struct unit_test_state *uts)
 {
@@ -219,7 +216,7 @@ static int str_itoa(struct unit_test_state *uts)
 
 	return 0;
 }
-STR_TEST(str_itoa, 0);
+LIB_TEST(str_itoa, 0);
 
 static int str_xtoa(struct unit_test_state *uts)
 {
@@ -239,7 +236,7 @@ static int str_xtoa(struct unit_test_state *uts)
 
 	return 0;
 }
-STR_TEST(str_xtoa, 0);
+LIB_TEST(str_xtoa, 0);
 
 static int str_trailing(struct unit_test_state *uts)
 {
@@ -271,7 +268,7 @@ static int str_trailing(struct unit_test_state *uts)
 
 	return 0;
 }
-STR_TEST(str_trailing, 0);
+LIB_TEST(str_trailing, 0);
 
 static int test_str_to_list(struct unit_test_state *uts)
 {
@@ -351,12 +348,4 @@ static int test_str_to_list(struct unit_test_state *uts)
 
 	return 0;
 }
-STR_TEST(test_str_to_list, 0);
-
-int do_ut_str(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(str_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(str_test);
-
-	return cmd_ut_category("str", "str_", tests, n_ents, argc, argv);
-}
+LIB_TEST(test_str_to_list, 0);
-- 
2.43.0

