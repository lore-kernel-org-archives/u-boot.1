Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D3FD10C0B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:43:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBDDD890CA;
	Mon, 28 Oct 2024 13:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k3m5aBwG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A28B789137; Mon, 28 Oct 2024 13:42:02 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A651E89099
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:42:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a99f3a5a44cso510453166b.3
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119319; x=1730724119; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0en73ZIPFJ2iCu/LTnBBLNWqWvLWN4JRku2DLwViD00=;
 b=k3m5aBwGxCtK2StDGX5JB/cHC9T+2It8MRombmZKqcijQyz1j4FM9bi5aJulGg+5yW
 xNA5PlKNg8JecSsJB127Poa1mNcav9ilU+0C03P2zQQZuj3226ayyHoxkbeE1pvlv7S9
 s/VkN8YoAS3y6qKZ0WMbbfcigTL8Rg7rNDNqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119319; x=1730724119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0en73ZIPFJ2iCu/LTnBBLNWqWvLWN4JRku2DLwViD00=;
 b=Toy8LSPvFeagDw3EAVp9M4bJ7me9gfipZbqvi0yeaXqyLWOGeKHJL+mmp6swMrNSU9
 RwQtOg3LcRkYl5f9dZ1Bwt7+FGKawu4S/Q7cIH7CU5rvCPPRZDtu/LdBh76TL3Yl2EJ4
 UnzBLcX2Rfn/ZXJhuPoqI3Yme0nLWq1u5sHEHGwUJJlzUPV0jgBf7LR2pBfpH0FHYERu
 NXUZFNDi6XhrxdTo0yJoEh5vFczSXa6PjbbxCDlDyAB3hzAF5LgppopV3YsPgQD02TBW
 u4T0ATfBAU/l0QXUSXxxs/DODlqxM17t3NtC5Jq4cHJeR/fLPkx6uhShUsskfTYN7UiX
 +UCg==
X-Gm-Message-State: AOJu0Yxkne/PgeX/BWFGQMXnvSamcQdMCGpCmtYJTL/OFeq1nII02gK2
 wk5MwnrsrJiOnB+sH2VZ8mMY0TnJqNrlNH+0NIi4cqzz9jWtFtrOOstGU8Pcr0GVbk+NFckAIAJ
 fKQ==
X-Google-Smtp-Source: AGHT+IGqC+dWQ980Ov2XGMZwtkqMQbU8GtfuQoOfnfYgZuo44EaQfp9RXyGXdpVRqmK/LSPeyn6D4w==
X-Received: by 2002:a17:907:9405:b0:a9a:a3a:6c58 with SMTP id
 a640c23a62f3a-a9de5ed3e2emr730793066b.22.1730119319011; 
 Mon, 28 Oct 2024 05:41:59 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:41:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/21] str: test: Move into the lib suite
Date: Mon, 28 Oct 2024 13:41:19 +0100
Message-ID: <20241028124130.32072-15-sjg@chromium.org>
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

There is no particular need for the str tests to have their own test
suite. Move them into the lib suite instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd_ut.c  |  4 ----
 test/lib/str.c | 31 ++++++++++---------------------
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index f4129dcf6cc..f064dd72461 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -112,7 +112,6 @@ static struct cmd_tbl cmd_ut_sub[] = {
 #ifdef CONFIG_SANDBOX
 	U_BOOT_CMD_MKENT(bootm, CONFIG_SYS_MAXARGS, 1, do_ut_bootm, "", ""),
 #endif
-	U_BOOT_CMD_MKENT(str, CONFIG_SYS_MAXARGS, 1, do_ut_str, "", ""),
 #ifdef CONFIG_CMD_ADDRMAP
 	U_BOOT_CMD_MKENT(addrmap, CONFIG_SYS_MAXARGS, 1, do_ut_addrmap, "", ""),
 #endif
@@ -235,9 +234,6 @@ U_BOOT_LONGHELP(ut,
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

