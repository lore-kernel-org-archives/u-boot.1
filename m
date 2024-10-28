Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A28D10C0B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4DD88911D;
	Mon, 28 Oct 2024 13:42:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T7l9y+t+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB6A889110; Mon, 28 Oct 2024 13:41:58 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0F36890CA
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:41:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c94c4ad9d8so5358088a12.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119315; x=1730724115; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EbVdP8po3ZG2ff33Ho0ywEHcmN7yGDlaoq9tP3eUW5o=;
 b=T7l9y+t+PQQqQyGOAyeTyLU3DCoKaZ817acCXkWfHamtALo+bUV087hQaf5XkYBU7V
 3jB4RERM7TJmgAj+EYXyw29kvrHMCtMdh31I419gq+Xh1/FDVjDXIeUCnHmVdS551eKr
 2tJwTe7Xcf0J17f2VJQBH5crET5Boqts7IdM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119315; x=1730724115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EbVdP8po3ZG2ff33Ho0ywEHcmN7yGDlaoq9tP3eUW5o=;
 b=VXvPICIZUjmyO3p7pEQ43ncopJ5X5Yd+szCwz1R9GMnKbx//+mAkxE7SEj/x9pZMhP
 9iMMT+49JFZNL+lhWXpzjWT1aIS7/NWpybvWAyxcKVK8ZWq+iFpovaT22HUES08StQji
 vcYsdFe2N7L6JeQFtT+0SD6EQKkXqeIeWEeUVGpiPH1v1E2gm2NtHJncuanrTOKowYi9
 NwZmfjsdntA8NKxbXHwGKbX1RGJMttxcWXtlwpfL25775nb7VsyeRFXO60W1O4vA6aY/
 7K0DsDgG97rbmMuZ+O1h8ZG5WYq6r+RyTRg9596dZHfmeNyS2tEGA4pDC5XzHEDhgf+W
 lAtw==
X-Gm-Message-State: AOJu0YwRf9vMFvXMwFqB8XMsx42lFH+ootSplW+1RowysktJgGww4UEN
 5UMh4NtOMemOc7tH35bWFwP1fWirPf422uBZ8Yd5BtcjVqOG/D49FCt6kfh5ULCKC6PJ5v77J/Y
 oaQ==
X-Google-Smtp-Source: AGHT+IHzM225EerPtikMGfDgPpHLgbmtgPV7Nll1fJGy15Eu40W5/aEFmIIudl1b4HDVlzoMiGpwKA==
X-Received: by 2002:a17:907:9495:b0:a9a:5d15:26c2 with SMTP id
 a640c23a62f3a-a9de619c888mr770511366b.45.1730119315095; 
 Mon, 28 Oct 2024 05:41:55 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:41:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/21] test: Move print_ut into the common suite
Date: Mon, 28 Oct 2024 13:41:17 +0100
Message-ID: <20241028124130.32072-13-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd_ut.c       |  2 --
 test/common/print.c | 27 ++++++++-------------------
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 0d7d5009fef..f4129dcf6cc 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -99,7 +99,6 @@ static struct cmd_tbl cmd_ut_sub[] = {
 	U_BOOT_CMD_MKENT(setexpr, CONFIG_SYS_MAXARGS, 1, do_ut_setexpr, "",
 			 ""),
 #endif
-	U_BOOT_CMD_MKENT(print, CONFIG_SYS_MAXARGS, 1, do_ut_print, "", ""),
 #ifdef CONFIG_UT_TIME
 	U_BOOT_CMD_MKENT(time, CONFIG_SYS_MAXARGS, 1, do_ut_time, "", ""),
 #endif
@@ -235,7 +234,6 @@ U_BOOT_LONGHELP(ut,
 #ifdef CONFIG_CMD_PCI_MPS
 	"\npci_mps - PCI Express Maximum Payload Size"
 #endif
-	"\nprint  - printing things to the console"
 	"\nsetexpr - setexpr command"
 #ifdef CONFIG_SANDBOX
 	"\nstr - basic test of string functions"
diff --git a/test/common/print.c b/test/common/print.c
index f5e607b21a3..f1eb9072d97 100644
--- a/test/common/print.c
+++ b/test/common/print.c
@@ -11,7 +11,7 @@
 #include <version_string.h>
 #include <stdio.h>
 #include <vsprintf.h>
-#include <test/suites.h>
+#include <test/common.h>
 #include <test/test.h>
 #include <test/ut.h>
 
@@ -20,9 +20,6 @@
 #define FAKE_BUILD_TAG	"jenkins-u-boot-denx_uboot_dm-master-build-aarch64" \
 			"and a lot more text to come"
 
-/* Declare a new print test */
-#define PRINT_TEST(_name, _flags)	UNIT_TEST(_name, _flags, print_test)
-
 #if CONFIG_IS_ENABLED(LIB_UUID)
 /* Test printing GUIDs */
 static int print_guid(struct unit_test_state *uts)
@@ -59,7 +56,7 @@ static int print_guid(struct unit_test_state *uts)
 
 	return 0;
 }
-PRINT_TEST(print_guid, 0);
+COMMON_TEST(print_guid, 0);
 #endif
 
 #if CONFIG_IS_ENABLED(EFI_LOADER) && !defined(API_BUILD)
@@ -95,7 +92,7 @@ static int print_efi_ut(struct unit_test_state *uts)
 
 	return 0;
 }
-PRINT_TEST(print_efi_ut, 0);
+COMMON_TEST(print_efi_ut, 0);
 #endif
 
 static int print_printf(struct unit_test_state *uts)
@@ -163,7 +160,7 @@ static int print_printf(struct unit_test_state *uts)
 
 	return 0;
 }
-PRINT_TEST(print_printf, 0);
+COMMON_TEST(print_printf, 0);
 
 static int print_display_buffer(struct unit_test_state *uts)
 {
@@ -238,7 +235,7 @@ static int print_display_buffer(struct unit_test_state *uts)
 
 	return 0;
 }
-PRINT_TEST(print_display_buffer, UTF_CONSOLE);
+COMMON_TEST(print_display_buffer, UTF_CONSOLE);
 
 static int print_hexdump_line(struct unit_test_state *uts)
 {
@@ -264,7 +261,7 @@ static int print_hexdump_line(struct unit_test_state *uts)
 
 	return 0;
 }
-PRINT_TEST(print_hexdump_line, UTF_CONSOLE);
+COMMON_TEST(print_hexdump_line, UTF_CONSOLE);
 
 static int print_do_hex_dump(struct unit_test_state *uts)
 {
@@ -350,7 +347,7 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 
 	return 0;
 }
-PRINT_TEST(print_do_hex_dump, UTF_CONSOLE);
+COMMON_TEST(print_do_hex_dump, UTF_CONSOLE);
 
 static int snprint(struct unit_test_state *uts)
 {
@@ -376,12 +373,4 @@ static int snprint(struct unit_test_state *uts)
 	ut_asserteq(8, ret);
 	return 0;
 }
-PRINT_TEST(snprint, 0);
-
-int do_ut_print(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(print_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(print_test);
-
-	return cmd_ut_category("print", "print_", tests, n_ents, argc, argv);
-}
+COMMON_TEST(snprint, 0);
-- 
2.43.0

