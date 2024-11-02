Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91614E67805
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56594892E1;
	Sat,  2 Nov 2024 20:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kdh4lXym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB6FE89300; Sat,  2 Nov 2024 20:37:50 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEDB3892CF
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:37:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cd7a2ed34bso20015146d6.2
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576267; x=1731181067; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kg00wEXAn5/4PVo3gxKSJTQCizA9zpOEtxU5bShftZ4=;
 b=kdh4lXymSTPcEzkVDGpnReac/CRiuvJphq0EvvUyEckAKIWL5qtqByO+h9uuO3f3VX
 y840ln/pzrmYCFPbnvHYWrAR0rpA9291DepSTGBPOJtyRShNFovIk7WoF1a8n3NTKuDu
 WtSKCKTQJ1nOi0anwisPDaHLEtaIWWNahLlRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576267; x=1731181067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kg00wEXAn5/4PVo3gxKSJTQCizA9zpOEtxU5bShftZ4=;
 b=nDRP1jqSEx+KAGFeU19ggEelY7utRuRWAJ5tgeMoCcq3tZV/CliW4Nm6tHBZVCqOsP
 l2GA3bZIZpVs68zRaCL/2KzvkwWoVn4GWOeVuuhJZaNrzh/ax4KWWwINcWjBo7vEqcGI
 5nY2ZYcI79FRPx+QwGpS4IzerIVdy+P5rbFXJElaT7CKcAXfdeXGbnLV65kDCxcECroO
 j59DwFtxDlq17WPe6dGkrLPLjbv1l0GxGSO+rHSWsuDOREtY5guZFDMLDHOgul70eTmc
 5hsgll6O4iXDyO/OV/nDwjqEfb2Bbr+Fc0tteOr0qolxqJ2BHwrwgmAL/U4/lCtgHLXL
 GAmw==
X-Gm-Message-State: AOJu0Yzpm2NsFvBhnSz6d9iMXU/smHHzwExYy4mt559ixsdGGQlqCDoF
 0QybWbNsvU9w9J9jBbzclRLDok2ocCBrVA9wtdSRHdeaaAgnRkXAEA1RmEdQoYglqCXVORhY5iT
 ia0we
X-Google-Smtp-Source: AGHT+IHbXO90OPw2VgYjnjQRwbImSycy96uupbOxiWnZ20BMxhH4lwb8Ex6KFmA5F05fmw36aixjyQ==
X-Received: by 2002:a05:6214:5d0d:b0:6cb:b7ea:2072 with SMTP id
 6a1803df08f44-6d35c0a2b38mr122500766d6.1.1730576267066; 
 Sat, 02 Nov 2024 12:37:47 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9dfeasm32324976d6.14.2024.11.02.12.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:37:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/20] test: Move print_ut into the common suite
Date: Sat,  2 Nov 2024 13:36:56 -0600
Message-ID: <20241102193715.432529-12-sjg@chromium.org>
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

There is no particular need for bloblist to have its own test suite.
Move it into the common suite instead.

Add the missing help for 'common'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add missing 'common' help in this patch instead of bloblist

 test/cmd_ut.c       |  3 +--
 test/common/print.c | 27 ++++++++-------------------
 2 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 32403b48ca4..9b47a2c1a93 100644
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
@@ -205,6 +204,7 @@ U_BOOT_LONGHELP(ut,
 #ifdef CONFIG_CMDLINE
 	"\ncmd - test various commands"
 #endif
+	"\ncommon   - tests for common/ directory"
 #ifdef CONFIG_UT_DM
 	"\ndm - driver model"
 #endif
@@ -239,7 +239,6 @@ U_BOOT_LONGHELP(ut,
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

