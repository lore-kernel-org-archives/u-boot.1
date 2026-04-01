Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876A3D3517E
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 12:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07B8E84101;
	Wed,  1 Apr 2026 14:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="fCSLdYhP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dIj3FTjP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F4883F5B; Wed,  1 Apr 2026 14:42:27 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20E7283CE3
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 14:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gregor.herburger@linutronix.de
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1775047344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SEv/bT844UAZ9PNQZJ6/YMZKcrMDuqLppaal6aglFJE=;
 b=fCSLdYhPd/52eUU0KtSRQvoAjpva8S9q46I1ZiW/wTiul+gBIkD0Hg5NuaTR9vB9BuzBI5
 x0/7SFyJLKh63InyJ3RPxT3nBGl6CxRvdL1JpOSEH52zanX4n5JCCqwev4kUXGy4YG5kUl
 Pu1ek87U8werUE5S7NiV/RstByh/aNH7/aPFgIvOS33Fagqed23eZz64RCh6t+gKamxjuK
 oOd5IFRrsXSMbNMk3ape0+Xxs2z1+JBIBMi4eWBMsUWsKKfmFrhn1unJh2pye89eayhLKx
 YgLn6WCWNYsrXeekI1rHXCY7H7rS55JtX6J9LFqmhn10hT2gLQmXATDlKtorWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1775047344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SEv/bT844UAZ9PNQZJ6/YMZKcrMDuqLppaal6aglFJE=;
 b=dIj3FTjPJF/0H0/tiKK5uT+juFZSQGz71ryRvH2ETRaJyW9RLziez1C6cArO4tlxl2RgCE
 yxr7bBpgqz/9xKDw==
To: u-boot@lists.denx.de,
	Quentin Schulz <quentin.schulz@cherry.de>
Cc: Gregor Herburger <gregor.herburger@linutronix.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 David Zang <davidzangcs@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] console: add console_flush_stdin()
Date: Wed,  1 Apr 2026 14:40:44 +0200
Message-ID: <20260401124128.178799-2-gregor.herburger@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Apr 2026 14:56:19 +0200
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

Add a common helper console_flush_stdin() to drain all pending
characters from stdin. This consolidates the open-coded
while (tstc()) getchar() pattern that appeared in multiple places
across the tree.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---

(no changes since v1)

 cmd/conitrace.c              |  4 ++--
 cmd/eficonfig.c              |  6 +++---
 cmd/eficonfig_sbkey.c        |  4 ++--
 common/autoboot.c            | 11 +----------
 common/console.c             | 12 ++++++++++--
 include/console.h            |  5 +++++
 lib/efi_loader/efi_console.c |  7 +++----
 7 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/cmd/conitrace.c b/cmd/conitrace.c
index 6cc113328eb..aef094e03df 100644
--- a/cmd/conitrace.c
+++ b/cmd/conitrace.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2018, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 #include <command.h>
+#include <console.h>
 #include <linux/delay.h>
 
 static int do_conitrace(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -17,8 +18,7 @@ static int do_conitrace(struct cmd_tbl *cmdtp, int flag, int argc,
 	printf("To terminate type 'x'\n");
 
 	/* Empty input buffer */
-	while (tstc())
-		getchar();
+	console_flush_stdin();
 
 	for (;;) {
 		int c = getchar();
diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index d8d946c87ac..60c39bc3a99 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -6,8 +6,9 @@
  */
 
 #include <ansi.h>
-#include <cli.h>
 #include <charset.h>
+#include <cli.h>
+#include <console.h>
 #include <efi_device_path.h>
 #include <efi_loader.h>
 #include <efi_load_initrd.h>
@@ -167,8 +168,7 @@ static void eficonfig_menu_adjust(struct efimenu *efi_menu, bool add)
 void eficonfig_print_msg(char *msg)
 {
 	/* Flush input */
-	while (tstc())
-		getchar();
+	console_flush_stdin();
 
 	printf(ANSI_CURSOR_HIDE
 	       ANSI_CLEAR_CONSOLE
diff --git a/cmd/eficonfig_sbkey.c b/cmd/eficonfig_sbkey.c
index b3325a540f9..a6c5416d3a5 100644
--- a/cmd/eficonfig_sbkey.c
+++ b/cmd/eficonfig_sbkey.c
@@ -7,6 +7,7 @@
 
 #include <ansi.h>
 #include <charset.h>
+#include <console.h>
 #include <hexdump.h>
 #include <log.h>
 #include <malloc.h>
@@ -288,8 +289,7 @@ static efi_status_t eficonfig_process_show_siglist(void *data)
 		}
 	}
 
-	while (tstc())
-		getchar();
+	console_flush_stdin();
 
 	printf("\n\n  Press any key to continue");
 	getchar();
diff --git a/common/autoboot.c b/common/autoboot.c
index 1783ef92c94..4b80ddb5b28 100644
--- a/common/autoboot.c
+++ b/common/autoboot.c
@@ -315,15 +315,6 @@ static int passwd_abort_key(uint64_t etime)
 	return abort;
 }
 
-/**
- * flush_stdin() - drops all pending characters from stdin
- */
-static void flush_stdin(void)
-{
-	while (tstc())
-		(void)getchar();
-}
-
 /**
  * fallback_to_sha256() - check whether we should fall back to sha256
  *                        password checking
@@ -354,7 +345,7 @@ static int abortboot_key_sequence(int bootdelay)
 	uint64_t etime = endtick(bootdelay);
 
 	if (IS_ENABLED(CONFIG_AUTOBOOT_FLUSH_STDIN))
-		flush_stdin();
+		console_flush_stdin();
 #  ifdef CONFIG_AUTOBOOT_PROMPT
 	/*
 	 * CONFIG_AUTOBOOT_PROMPT includes the %d for all boards.
diff --git a/common/console.c b/common/console.c
index 48586fd2166..90b437fd1fc 100644
--- a/common/console.c
+++ b/common/console.c
@@ -643,6 +643,15 @@ int tstc(void)
 	return serial_tstc();
 }
 
+/**
+ * console_flush_stdin() - drops all pending characters from stdin
+ */
+void console_flush_stdin(void)
+{
+	while (tstc())
+		(void)getchar();
+}
+
 #define PRE_CONSOLE_FLUSHPOINT1_SERIAL			0
 #define PRE_CONSOLE_FLUSHPOINT2_EVERYTHING_BUT_SERIAL	1
 
@@ -914,8 +923,7 @@ int confirm_yesno(void)
 	char str_input[5];
 
 	/* Flush input */
-	while (tstc())
-		getchar();
+	console_flush_stdin();
 	i = 0;
 	while (i < sizeof(str_input)) {
 		str_input[i] = getchar();
diff --git a/include/console.h b/include/console.h
index 8d0d7bb8a4c..01a04f28f31 100644
--- a/include/console.h
+++ b/include/console.h
@@ -202,6 +202,11 @@ int console_clear(void);
  */
 int console_remove_by_name(const char *name);
 
+/**
+ * console_flush_stdin() - drops all pending characters from stdin
+ */
+void console_flush_stdin(void);
+
 /*
  * CONSOLE multiplexing.
  */
diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
index 068d1a0a7b7..f83415f2ed3 100644
--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -9,6 +9,7 @@
 
 #include <ansi.h>
 #include <charset.h>
+#include <console.h>
 #include <efi_device_path.h>
 #include <malloc.h>
 #include <time.h>
@@ -299,8 +300,7 @@ static int query_console_serial(int *rows, int *cols)
 	int n[2];
 
 	/* Empty input buffer */
-	while (tstc())
-		getchar();
+	console_flush_stdin();
 
 	/*
 	 * Not all terminals understand CSI [18t for querying the console size.
@@ -957,8 +957,7 @@ static void efi_cin_check(void)
  */
 static void efi_cin_empty_buffer(void)
 {
-	while (tstc())
-		getchar();
+	console_flush_stdin();
 	key_available = false;
 }
 
-- 
2.47.3

base-commit: c704af3c8b0f37929bce8c2a4bba27d6e89919c7
branch: cmd-flush-stdin
