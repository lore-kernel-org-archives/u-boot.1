Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A035EC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:49:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F1B84BC8;
	Wed,  1 Jul 2026 13:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dVGR843X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B063F84BC8; Wed,  1 Jul 2026 13:47:38 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8383F84C22
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4876d5335b2so352261b6e.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782906455; x=1783511255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pym2dvVjL54bEo7t7jf67oi3tjcnCyaO8m0P5mtbPhU=;
 b=dVGR843XnvsYnDJWl7jHI5DtclyFAFQIUHgfZvD7/fDr394p3dQTEnV+q66iropOLc
 3gtrfVKcz+rU3oHoZXgcnXE/HjeEaXQCBhB5iPq+mWMFmhiFWjShdycfhM8Ho1hUFlrp
 bEnVkdYr/ZwBCoRz3rVV2iI8FkZGmmuXw7Mh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782906455; x=1783511255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pym2dvVjL54bEo7t7jf67oi3tjcnCyaO8m0P5mtbPhU=;
 b=q7qbLcH26pGnmth/T/ADX8StOBrm5nJ3Vo1bp2T0ZWQm2g1rC2GGxWj3bcBP2J9wZq
 Z6nQuSXEh4ESVcgm2iJ9Vs1IAVzfV6mi4EgebhnotfX1/VPoaPVI1QruLyz/5Aqt8Lp7
 z7rQ5131KvM6wzd/Tj0BFbuE1u4PKdb03vE+g3xcJu5yO4+yvQG+iSGgf0L3gpDWrm17
 bmKFxKu7uPjjyT1aeqJTcIxqvMkl8052FxEanzWEa36d6w/frg44n424jX6t1Zo5MIdM
 LRg8RW9jHCuVBfrp5G0GuWQH8iLSAIM9zQZXJ0mimzr03tnH4MMDKivs3eXqfxBipm43
 UcBg==
X-Gm-Message-State: AOJu0YwXokWDECzUvAv7c2bKlIvIWt130j0hgMTJuwe2b9OaBFxs4Xrn
 Z+CN7cNyD0aTqhUj1bfPDSai+NJxvK1+JSWyAteTOsVQFiBQQzFKhtmk73vgJO5A9exd9yNLpzM
 zGas=
X-Gm-Gg: AfdE7ck1etNYqgHZpUCVTr38pXlOE32jLF1erg0ZRDbUPLeC224zfa8/98SiUTqTQDi
 8XFYq/3kQ0Sq5G2sXuGO7oRoHFR6SlY6Rl7i2NcnoTs9EXGVndTIRq86DsS6ZkoqcLZ/GKy0a8d
 /W8K/ZRqbLlUnbxL5b6oHkSZI7q0pS6X0qvtHFreXQZ7P+2SfuXYf595dog231ty2ZuNTEhIxl/
 5ILAFSDGTR3gFUu3T7ljrjSjDgGLLX/UY3bWXvz6A6eX7Y5lT4TotC2F4EAkmlaZ4063vMjiMS6
 Yx+0uyqCKndOTd8bxLW7k160c8Wz442upRt54cdoNAKjhla7IxEYk/oADIKnCiYwvxi2vVxTebg
 ezZvqjfM3rRF/giJ1Ma8QS+X0xUcoiu4OnNAOF36+uvKv2WbzNdeB3tADcRVphuBg9uxwmPuhbS
 GDkNnAS2E=
X-Received: by 2002:a05:6808:244f:b0:489:6bf3:2d54 with SMTP id
 5614622812f47-496369fd3bdmr148404b6e.37.1782906455240; 
 Wed, 01 Jul 2026 04:47:35 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4960655e3e2sm1199823b6e.0.2026.07.01.04.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 04:47:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 14/14] cmd: echo: Use getopt() for option parsing
Date: Wed,  1 Jul 2026 05:42:34 -0600
Message-ID: <20260701114248.1396125-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701114248.1396125-1-sjg@chromium.org>
References: <20260701114248.1396125-1-sjg@chromium.org>
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

The open-coded check for -n only matches it as the first argument, so
'echo foo -n' treats -n as a literal argument while still relying on a
hand-rolled scan that exists in every option-parsing command. Convert
do_echo() to the getopt-state command signature and parse -n with
getopt().

Use a '+' prefix on the optstring so getopt() works in POSIX mode and
stops at the first non-option, matching the documented behaviour that
-n is only an option when it precedes the arguments. The positional
arguments are then printed from gs->argv[gs->index] onwards, so no
manual argc/argv juggling is needed. CMD_ECHO selects GETOPT.

This drops the cmd/echo.o text size from 334 to 320 bytes on sandbox.

Add a test case covering -n after an argument, which is now printed
literally with the trailing newline preserved.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/Kconfig          |  1 +
 cmd/echo.c           | 26 ++++++++++++++------------
 test/cmd/test_echo.c |  7 +++++++
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index e100a08d271..8c73b136fa8 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1927,6 +1927,7 @@ config CMD_CAT
 config CMD_ECHO
 	bool "echo"
 	default y
+	select GETOPT
 	help
 	  Echo args to console
 
diff --git a/cmd/echo.c b/cmd/echo.c
index d1346504cfb..ace6b71233b 100644
--- a/cmd/echo.c
+++ b/cmd/echo.c
@@ -5,27 +5,29 @@
  */
 
 #include <command.h>
-#include <linux/string.h>
+#include <getopt.h>
 
-static int do_echo(struct cmd_tbl *cmdtp, int flag, int argc,
-		   char *const argv[])
+static int do_echo(struct getopt_state *gs)
 {
-	int i = 1;
 	bool space = false;
 	bool newline = true;
+	const char *arg;
+	int opt;
 
-	if (argc > 1) {
-		if (!strcmp(argv[1], "-n")) {
+	while ((opt = getopt(gs, "+n")) > 0) {
+		switch (opt) {
+		case 'n':
 			newline = false;
-			++i;
+			break;
+		default:
+			return CMD_RET_USAGE;
 		}
 	}
 
-	for (; i < argc; ++i) {
-		if (space) {
+	while ((arg = getopt_pop(gs))) {
+		if (space)
 			putc(' ');
-		}
-		puts(argv[i]);
+		puts(arg);
 		space = true;
 	}
 
@@ -35,7 +37,7 @@ static int do_echo(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-U_BOOT_CMD(
+U_BOOT_CMD_GETOPT(
 	echo, CONFIG_SYS_MAXARGS, 1, do_echo,
 	"echo args to console",
 	"[-n] [args..]\n"
diff --git a/test/cmd/test_echo.c b/test/cmd/test_echo.c
index 7ed534742f7..64589e3656f 100644
--- a/test/cmd/test_echo.c
+++ b/test/cmd/test_echo.c
@@ -22,6 +22,13 @@ static struct test_data echo_data[] = {
 	/* Test new line handling */
 	{"echo -n 1 2 3; echo a b c",
 	 "1 2 3a b c"},
+	/*
+	 * Option parsing stops at the first non-option, so a -n which
+	 * follows an argument is printed literally and the trailing
+	 * newline is still emitted.
+	 */
+	{"echo 1 -n 2",
+	 "1 -n 2"},
 	/*
 	 * Test handling of environment variables.
 	 *
-- 
2.43.0

