Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5081BD10C0B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:44:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9549C89128;
	Mon, 28 Oct 2024 13:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iN0Yr49i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 836A889099; Mon, 28 Oct 2024 13:42:05 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F0FE89102
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:42:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-539f2b95775so4872770e87.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119322; x=1730724122; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cpud9DO/KG31jL11uUWSFx0qOrJAbLUsN3/VDiDGCCY=;
 b=iN0Yr49iPgqZCrGq+K8udnWCY306CpI4Hrpy+Cd7lHn8JluouhpiAdhY2lNTk9xIbG
 Xxs7L+rAGov8LAQJlLwj1hs0BMap6WPoLO8oADYVSS9IqAPcQSSfRuH2L9OR/++Vy6uw
 sCdb2dtqrF9VpvsLuvU1GXXGCZf1+NQ2zzIrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119322; x=1730724122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cpud9DO/KG31jL11uUWSFx0qOrJAbLUsN3/VDiDGCCY=;
 b=cZxUmJl4EZTlaXWnw3ieGI7YDv3cIzajtQd/Fhlla3ziTXNgYysi1JLsyqbkQ71IaH
 5xzqodPePLPExirc/75JubRqeaewrhkzX1dY881bSJBlQXfdbDkjYo8hruDv9s8VhdcO
 N49u4y4JNHi+3D1K8iMDDvJClQUlIcLoMg7Iwin7ud+ItYvTVIsFvfP/CI3Dbs8X7cM2
 V4rCvp4iIH8FsB2Iq+YtUaypeTfG37n25U0weKNrXUl22NJDm8FjIQVeRs+UG6gwukUu
 lKoz55//ws83KslY1RbKJXvItHaFwkCVeadzA5y9hFUHtSf2VDUxOwU1y0OQOp4PiM7+
 G6pQ==
X-Gm-Message-State: AOJu0Ywep6NFkpLJqtLx7KjNavrb3929wa0vYAkgclZmY55lgGN4xW/U
 oKl/HJSyfvKACXgVqWNROK/y+9WXz0i/dIqBXhXUsyW9IRA0X1NHBLVHu9o02lBKFHNixT3X49k
 FNQ==
X-Google-Smtp-Source: AGHT+IHMZup/p5YUyzgB2nhq9VY0/gIqrhuNrDOrm5oLb8UgsLtdJhh6CZbjLVIeO5qSBLLqSO9Fgg==
X-Received: by 2002:a05:6512:3ba3:b0:533:483f:9562 with SMTP id
 2adb3069b0e04-53b3491e07amr4929106e87.42.1730119321948; 
 Mon, 28 Oct 2024 05:42:01 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:42:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/21] test: Move unicode tests into the lib suite
Date: Mon, 28 Oct 2024 13:41:21 +0100
Message-ID: <20241028124130.32072-17-sjg@chromium.org>
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

There is no particular need for the unicode tests to have their own test
suite. Move them into the lib suite instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd_ut.c      |  7 -----
 test/lib/unicode.c | 70 +++++++++++++++++++---------------------------
 2 files changed, 29 insertions(+), 48 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index f064dd72461..ef4f0ac607e 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -102,9 +102,6 @@ static struct cmd_tbl cmd_ut_sub[] = {
 #ifdef CONFIG_UT_TIME
 	U_BOOT_CMD_MKENT(time, CONFIG_SYS_MAXARGS, 1, do_ut_time, "", ""),
 #endif
-#if CONFIG_IS_ENABLED(UT_UNICODE) && !defined(API_BUILD)
-	U_BOOT_CMD_MKENT(unicode, CONFIG_SYS_MAXARGS, 1, do_ut_unicode, "", ""),
-#endif
 #ifdef CONFIG_MEASURED_BOOT
 	U_BOOT_CMD_MKENT(measurement, CONFIG_SYS_MAXARGS, 1, do_ut_measurement,
 			 "", ""),
@@ -239,10 +236,6 @@ U_BOOT_LONGHELP(ut,
 #endif
 #ifdef CONFIG_UT_TIME
 	"\ntime - very basic test of time functions"
-#endif
-#if defined(CONFIG_UT_UNICODE) && \
-	!defined(CONFIG_XPL_BUILD) && !defined(API_BUILD)
-	"\nunicode - Unicode functions"
 #endif
 	);
 
diff --git a/test/lib/unicode.c b/test/lib/unicode.c
index 13e29c9b9e3..673470c8d2c 100644
--- a/test/lib/unicode.c
+++ b/test/lib/unicode.c
@@ -11,13 +11,10 @@
 #include <errno.h>
 #include <log.h>
 #include <malloc.h>
+#include <test/lib.h>
 #include <test/test.h>
-#include <test/suites.h>
 #include <test/ut.h>
 
-/* Linker list entry for a Unicode test */
-#define UNICODE_TEST(_name) UNIT_TEST(_name, 0, unicode_test)
-
 /* Constants c1-c4 and d1-d4 encode the same letters */
 
 /* Six characters translating to one utf-8 byte each. */
@@ -64,7 +61,7 @@ static int unicode_test_u16_strlen(struct unit_test_state *uts)
 	ut_asserteq(6, u16_strlen(c4));
 	return 0;
 }
-UNICODE_TEST(unicode_test_u16_strlen);
+LIB_TEST(unicode_test_u16_strlen, 0);
 
 static int unicode_test_u16_strnlen(struct unit_test_state *uts)
 {
@@ -75,7 +72,7 @@ static int unicode_test_u16_strnlen(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_u16_strnlen);
+LIB_TEST(unicode_test_u16_strnlen, 0);
 
 static int unicode_test_u16_strdup(struct unit_test_state *uts)
 {
@@ -87,7 +84,7 @@ static int unicode_test_u16_strdup(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_u16_strdup);
+LIB_TEST(unicode_test_u16_strdup, 0);
 
 static int unicode_test_u16_strcpy(struct unit_test_state *uts)
 {
@@ -100,7 +97,7 @@ static int unicode_test_u16_strcpy(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_u16_strcpy);
+LIB_TEST(unicode_test_u16_strcpy, 0);
 
 /* U-Boot uses UTF-16 strings in the EFI context only. */
 #if CONFIG_IS_ENABLED(EFI_LOADER) && !defined(API_BUILD)
@@ -173,7 +170,7 @@ static int unicode_test_string16(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_string16);
+LIB_TEST(unicode_test_string16, 0);
 #endif
 
 static int unicode_test_utf8_get(struct unit_test_state *uts)
@@ -218,7 +215,7 @@ static int unicode_test_utf8_get(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_utf8_get);
+LIB_TEST(unicode_test_utf8_get, 0);
 
 static int unicode_test_utf8_put(struct unit_test_state *uts)
 {
@@ -256,7 +253,7 @@ static int unicode_test_utf8_put(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_utf8_put);
+LIB_TEST(unicode_test_utf8_put, 0);
 
 static int unicode_test_utf8_utf16_strlen(struct unit_test_state *uts)
 {
@@ -272,7 +269,7 @@ static int unicode_test_utf8_utf16_strlen(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_utf8_utf16_strlen);
+LIB_TEST(unicode_test_utf8_utf16_strlen, 0);
 
 static int unicode_test_utf8_utf16_strnlen(struct unit_test_state *uts)
 {
@@ -290,7 +287,7 @@ static int unicode_test_utf8_utf16_strnlen(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_utf8_utf16_strnlen);
+LIB_TEST(unicode_test_utf8_utf16_strnlen, 0);
 
 /**
  * ut_u16_strcmp() - Compare to u16 strings.
@@ -354,7 +351,7 @@ static int unicode_test_utf8_utf16_strcpy(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_utf8_utf16_strcpy);
+LIB_TEST(unicode_test_utf8_utf16_strcpy, 0);
 
 static int unicode_test_utf8_utf16_strncpy(struct unit_test_state *uts)
 {
@@ -398,7 +395,7 @@ static int unicode_test_utf8_utf16_strncpy(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_utf8_utf16_strncpy);
+LIB_TEST(unicode_test_utf8_utf16_strncpy, 0);
 
 static int unicode_test_utf16_get(struct unit_test_state *uts)
 {
@@ -424,7 +421,7 @@ static int unicode_test_utf16_get(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_utf16_get);
+LIB_TEST(unicode_test_utf16_get, 0);
 
 static int unicode_test_utf16_put(struct unit_test_state *uts)
 {
@@ -452,7 +449,7 @@ static int unicode_test_utf16_put(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_utf16_put);
+LIB_TEST(unicode_test_utf16_put, 0);
 
 static int unicode_test_utf16_strnlen(struct unit_test_state *uts)
 {
@@ -470,7 +467,7 @@ static int unicode_test_utf16_strnlen(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_utf16_strnlen);
+LIB_TEST(unicode_test_utf16_strnlen, 0);
 
 static int unicode_test_utf16_utf8_strlen(struct unit_test_state *uts)
 {
@@ -486,7 +483,7 @@ static int unicode_test_utf16_utf8_strlen(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_utf16_utf8_strlen);
+LIB_TEST(unicode_test_utf16_utf8_strlen, 0);
 
 static int unicode_test_utf16_utf8_strnlen(struct unit_test_state *uts)
 {
@@ -498,7 +495,7 @@ static int unicode_test_utf16_utf8_strnlen(struct unit_test_state *uts)
 	ut_asserteq(12, utf16_utf8_strnlen(c4, 3));
 	return 0;
 }
-UNICODE_TEST(unicode_test_utf16_utf8_strnlen);
+LIB_TEST(unicode_test_utf16_utf8_strnlen, 0);
 
 static int unicode_test_utf16_utf8_strcpy(struct unit_test_state *uts)
 {
@@ -543,7 +540,7 @@ static int unicode_test_utf16_utf8_strcpy(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_utf16_utf8_strcpy);
+LIB_TEST(unicode_test_utf16_utf8_strcpy, 0);
 
 static int unicode_test_utf16_utf8_strncpy(struct unit_test_state *uts)
 {
@@ -587,7 +584,7 @@ static int unicode_test_utf16_utf8_strncpy(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_utf16_utf8_strncpy);
+LIB_TEST(unicode_test_utf16_utf8_strncpy, 0);
 
 static int unicode_test_utf_to_lower(struct unit_test_state *uts)
 {
@@ -604,7 +601,7 @@ static int unicode_test_utf_to_lower(struct unit_test_state *uts)
 #endif
 	return 0;
 }
-UNICODE_TEST(unicode_test_utf_to_lower);
+LIB_TEST(unicode_test_utf_to_lower, 0);
 
 static int unicode_test_utf_to_upper(struct unit_test_state *uts)
 {
@@ -621,7 +618,7 @@ static int unicode_test_utf_to_upper(struct unit_test_state *uts)
 #endif
 	return 0;
 }
-UNICODE_TEST(unicode_test_utf_to_upper);
+LIB_TEST(unicode_test_utf_to_upper, 0);
 
 static int unicode_test_u16_strcasecmp(struct unit_test_state *uts)
 {
@@ -646,7 +643,7 @@ static int unicode_test_u16_strcasecmp(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_u16_strcasecmp);
+LIB_TEST(unicode_test_u16_strcasecmp, 0);
 
 static int unicode_test_u16_strncmp(struct unit_test_state *uts)
 {
@@ -659,7 +656,7 @@ static int unicode_test_u16_strncmp(struct unit_test_state *uts)
 	ut_assert(u16_strcmp(u"deghi", u"abcdef") > 0);
 	return 0;
 }
-UNICODE_TEST(unicode_test_u16_strncmp);
+LIB_TEST(unicode_test_u16_strncmp, 0);
 
 static int unicode_test_u16_strsize(struct unit_test_state *uts)
 {
@@ -669,7 +666,7 @@ static int unicode_test_u16_strsize(struct unit_test_state *uts)
 	ut_asserteq_64(u16_strsize(c4), 14);
 	return 0;
 }
-UNICODE_TEST(unicode_test_u16_strsize);
+LIB_TEST(unicode_test_u16_strsize, 0);
 
 static int unicode_test_utf_to_cp(struct unit_test_state *uts)
 {
@@ -698,7 +695,7 @@ static int unicode_test_utf_to_cp(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_utf_to_cp);
+LIB_TEST(unicode_test_utf_to_cp, 0);
 
 static void utf8_to_cp437_stream_helper(const char *in, char *out)
 {
@@ -729,7 +726,7 @@ static int unicode_test_utf8_to_cp437_stream(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_utf8_to_cp437_stream);
+LIB_TEST(unicode_test_utf8_to_cp437_stream, 0);
 
 static void utf8_to_utf32_stream_helper(const char *in, s32 *out)
 {
@@ -778,7 +775,7 @@ static int unicode_test_utf8_to_utf32_stream(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_utf8_to_utf32_stream);
+LIB_TEST(unicode_test_utf8_to_utf32_stream, 0);
 
 #ifdef CONFIG_EFI_LOADER
 static int unicode_test_efi_create_indexed_name(struct unit_test_state *uts)
@@ -795,7 +792,7 @@ static int unicode_test_efi_create_indexed_name(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_efi_create_indexed_name);
+LIB_TEST(unicode_test_efi_create_indexed_name, 0);
 #endif
 
 static int unicode_test_u16_strlcat(struct unit_test_state *uts)
@@ -846,13 +843,4 @@ static int unicode_test_u16_strlcat(struct unit_test_state *uts)
 
 	return 0;
 }
-UNICODE_TEST(unicode_test_u16_strlcat);
-
-int do_ut_unicode(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(unicode_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(unicode_test);
-
-	return cmd_ut_category("Unicode", "unicode_test_",
-			       tests, n_ents, argc, argv);
-}
+LIB_TEST(unicode_test_u16_strlcat, 0);
-- 
2.43.0

