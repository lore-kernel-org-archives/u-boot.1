Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A63C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 22:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD3384AB5;
	Thu,  9 Jul 2026 00:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LlEB771Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3694B84ADB; Thu,  9 Jul 2026 00:06:14 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D84B184A1F
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 00:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=747f=FD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783548370; bh=oN26vI11E06lopVZGsSF6eJ/xwYW93laOdh2znXTIlk=;
 b=LlEB771QCrvQW8ptusw7xs8YZucsgaJ6FApveZfp3zp67u+ndQEXnKefLS9rWsr2NImBnUrBi
 zX56zFX+dN8sEaOMhG8LfWvhumJR+oMujHPudf9+x/BBQQ7C3lJ9Dp64QWqOiVdAKmKKBNZSTRR
 20osxQkscArfFdmm7gGNcIWaXuxa2uwvPrdenMnzlLSWkg7mmFJPNIT38qKsku0tZKU2F0t5Uz5
 slWrkePlifsowdFDtFsgPRHzSz/g3IBI2DQWA63aIXws8YRrOjUCmnU40qpYru5KSY/H5KAR39+
 AIV8p5Wninc5gQ4pCoNKc1ZpdgjvH9vbA09pdyLbtSBg==
X-Forward-Email-ID: 6a4ec9d12402b3ca75f904f5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>,
	Stefan Bosch <stefan_b@posteo.net>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 10/11] console: Use CONFIG_IS_ENABLED() for SILENT_CONSOLE
 checks
Date: Wed,  8 Jul 2026 22:05:36 +0000
Message-ID: <20260708220540.3368825-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708220540.3368825-1-jonas@kwiboo.se>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
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

The xPL_SILENT_CONSOLE Kconfig symbols are not fully respected for xPL
builds, instead common code is guarded by a mix of SILENT_CONSOLE and
xPL_SILENT_CONSOLE symbols.

Change to consistently use CONFIG_IS_ENABLED(SILENT_CONSOLE) to make the
common code properly guarded by the intended Kconfig symbol.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 board/friendlyarm/nanopi2/board.c |  4 ++--
 boot/bootm.c                      |  4 ++--
 common/autoboot.c                 |  2 +-
 common/console.c                  | 12 ++++++------
 include/env_callback.h            |  2 +-
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/board/friendlyarm/nanopi2/board.c b/board/friendlyarm/nanopi2/board.c
index 5e560a7f9275..be092f3d5a27 100644
--- a/board/friendlyarm/nanopi2/board.c
+++ b/board/friendlyarm/nanopi2/board.c
@@ -441,7 +441,7 @@ int board_init(void)
 	bd_lcd_config_gpio();
 	bd_lcd_init();
 
-	if (IS_ENABLED(CONFIG_SILENT_CONSOLE))
+	if (CONFIG_IS_ENABLED(SILENT_CONSOLE))
 		gd->flags |= GD_FLG_SILENT;
 
 	return 0;
@@ -459,7 +459,7 @@ int board_late_init(void)
 
 	set_ether_addr();
 
-	if (IS_ENABLED(CONFIG_SILENT_CONSOLE))
+	if (CONFIG_IS_ENABLED(SILENT_CONSOLE))
 		gd->flags &= ~GD_FLG_SILENT;
 
 	bd_backlight_on();
diff --git a/boot/bootm.c b/boot/bootm.c
index 803d6406be40..3cbd824f0df5 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -873,7 +873,7 @@ int bootm_process_cmdline(char *buf, int maxlen, int flags)
 	int ret;
 
 	/* Check config first to enable compiler to eliminate code */
-	if (IS_ENABLED(CONFIG_SILENT_CONSOLE) &&
+	if (CONFIG_IS_ENABLED(SILENT_CONSOLE) &&
 	    !IS_ENABLED(CONFIG_SILENT_U_BOOT_ONLY) &&
 	    (flags & BOOTM_CL_SILENT)) {
 		ret = fixup_silent_linux(buf, maxlen);
@@ -899,7 +899,7 @@ int bootm_process_cmdline_env(int flags)
 	int ret;
 
 	/* First check if any action is needed */
-	do_silent = IS_ENABLED(CONFIG_SILENT_CONSOLE) &&
+	do_silent = CONFIG_IS_ENABLED(SILENT_CONSOLE) &&
 	    !IS_ENABLED(CONFIG_SILENT_U_BOOT_ONLY) && (flags & BOOTM_CL_SILENT);
 	if (!do_silent && !IS_ENABLED(CONFIG_BOOTARGS_SUBST))
 		return 0;
diff --git a/common/autoboot.c b/common/autoboot.c
index 4b80ddb5b28f..a3d932f290f4 100644
--- a/common/autoboot.c
+++ b/common/autoboot.c
@@ -426,7 +426,7 @@ static int abortboot(int bootdelay)
 			abort = abortboot_single_key(bootdelay);
 	}
 
-	if (IS_ENABLED(CONFIG_SILENT_CONSOLE) && abort)
+	if (CONFIG_IS_ENABLED(SILENT_CONSOLE) && abort)
 		gd->flags &= ~GD_FLG_SILENT;
 
 	return abort;
diff --git a/common/console.c b/common/console.c
index 54d1249422d4..eb84d1732939 100644
--- a/common/console.c
+++ b/common/console.c
@@ -72,7 +72,7 @@ static int on_console(const char *name, const char *value, enum env_op op,
 }
 U_BOOT_ENV_CALLBACK(console, on_console);
 
-#ifdef CONFIG_SILENT_CONSOLE
+#if CONFIG_IS_ENABLED(SILENT_CONSOLE)
 static int on_silent(const char *name, const char *value, enum env_op op,
 	int flags)
 {
@@ -687,7 +687,7 @@ static void print_pre_console_buffer(int flushpoint)
 	char buf_out[CONFIG_VAL(PRE_CON_BUF_SZ) + 1];
 	char *buf_in;
 
-	if (IS_ENABLED(CONFIG_SILENT_CONSOLE) && (gd->flags & GD_FLG_SILENT))
+	if (CONFIG_IS_ENABLED(SILENT_CONSOLE) && (gd->flags & GD_FLG_SILENT))
 		return;
 
 	buf_in = map_sysmem(CONFIG_VAL(PRE_CON_BUF_ADDR), CONFIG_VAL(PRE_CON_BUF_SZ));
@@ -736,7 +736,7 @@ void putc(const char c)
 		return;
 	}
 
-	if (IS_ENABLED(CONFIG_SILENT_CONSOLE) && (gd->flags & GD_FLG_SILENT)) {
+	if (CONFIG_IS_ENABLED(SILENT_CONSOLE) && (gd->flags & GD_FLG_SILENT)) {
 		if (!(gd->flags & GD_FLG_DEVINIT))
 			pre_console_putc(c);
 		return;
@@ -776,7 +776,7 @@ void puts(const char *s)
 		return;
 	}
 
-	if (IS_ENABLED(CONFIG_SILENT_CONSOLE) && (gd->flags & GD_FLG_SILENT)) {
+	if (CONFIG_IS_ENABLED(SILENT_CONSOLE) && (gd->flags & GD_FLG_SILENT)) {
 		if (!(gd->flags & GD_FLG_DEVINIT))
 			pre_console_puts(s);
 		return;
@@ -813,7 +813,7 @@ void flush(void)
 	if (IS_ENABLED(CONFIG_DEBUG_UART) && !(gd->flags & GD_FLG_SERIAL_READY))
 		return;
 
-	if (IS_ENABLED(CONFIG_SILENT_CONSOLE) && (gd->flags & GD_FLG_SILENT))
+	if (CONFIG_IS_ENABLED(SILENT_CONSOLE) && (gd->flags & GD_FLG_SILENT))
 		return;
 
 	if (IS_ENABLED(CONFIG_DISABLE_CONSOLE) && (gd->flags & GD_FLG_DISABLE_CONSOLE))
@@ -999,7 +999,7 @@ static bool console_update_silent(void)
 {
 	unsigned long flags = gd->flags;
 
-	if (!IS_ENABLED(CONFIG_SILENT_CONSOLE))
+	if (!CONFIG_IS_ENABLED(SILENT_CONSOLE))
 		return false;
 
 	if (IS_ENABLED(CONFIG_SILENT_CONSOLE_UNTIL_ENV) && !(gd->flags & GD_FLG_ENV_READY)) {
diff --git a/include/env_callback.h b/include/env_callback.h
index 1181ab4a1579..131bf76206e5 100644
--- a/include/env_callback.h
+++ b/include/env_callback.h
@@ -14,7 +14,7 @@
 
 #define ENV_CALLBACK_VAR ".callbacks"
 
-#ifdef CONFIG_SILENT_CONSOLE
+#if CONFIG_IS_ENABLED(SILENT_CONSOLE)
 #define SILENT_CALLBACK "silent:silent,"
 #else
 #define SILENT_CALLBACK
-- 
2.54.0

