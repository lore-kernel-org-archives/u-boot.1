Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB44C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C88EF84C11;
	Wed,  1 Jul 2026 13:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y1oGLV54";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8C0284BAA; Wed,  1 Jul 2026 13:47:33 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63C0B84C11
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-495b250b01cso432170b6e.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782906450; x=1783511250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YF6EuMeEWc70BY3fwEYAqzBp7NP5Rydb6vEooct1iRM=;
 b=Y1oGLV54DScM6IyGApHqWCPqX1mxzK75aId52iKyGTBxZHw2onrAnRQxbhG0YjJXJG
 PCRvCzZMhkU9RgzcGIMmUV3P69whc9m/dtreNqGIfRAl8hd3S8REv16tmU8ZGkBfYZz9
 PNdomaJV1RqEIeEZj8wkptI6FLAiqIG+wpHZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782906450; x=1783511250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YF6EuMeEWc70BY3fwEYAqzBp7NP5Rydb6vEooct1iRM=;
 b=XCxZ+js/XLf891//ZDsp4mA/2UHZ80RUL3k7lllsOSxU2jvTnt+6hmjKxufzevru94
 QINpcw47EER36n1bGPA4cKd9CS/RCWhVJUhiM00WuOoi2WEuDm+VvLokdzNgwzWFgcE3
 yWWi+o4B/PGltUyB+sy6G6FVhDpxdwhlvjDUu3NNK0MZewdvB4OYZ3YhG2Iwg3p/B9bK
 ObZDRbKQRWnVPjB+3Lluxe3xkuaUa4uIfrSsIC10/lZ23pbgeJEFNua6U+j1imJ2IHIg
 Dv5XUsgow+b5BeE2SWkQlpMQLdZpuOj0KCR/cYB+x9mCP2cazGy+44sJVderxLkydQ72
 YcqA==
X-Gm-Message-State: AOJu0YwGLZjiy/Yn7G2hlNDgvLeHRlH7wR745xVbhcYY8d+R4DIzxyxt
 RwFhANkeOERsRIhKZ4WB2LXZYVJXlnOC637C2C3BvI4zjXHdP/Mz9874JVkafO89WN5srsK/M9J
 3xfI=
X-Gm-Gg: AfdE7ckHJFFcw9AWM2YH3r5w7zWMVZIEOIeMiB+Ey3Ea/6KmewXO6+p2almkIZ+hYVP
 QWfC2dq5KjWlPGYg/gYNkr2bgZnrkjkqcWbzcaDd2EOuyF7DXc9SrAa0IfF3G/moB8NK0dAEZAm
 CPxnQCKE8YzMTjHA4legqaO5HHXB+/RuaYjZ1+rs0Ncfm8K0nsoS9VDF5ztA45RM46QptGfV1vj
 xkxDDCvIFK20+36y5JYJES26WFuQAgrtfSZNCzc9fbiEgWJioAvhn33N2qeMxCDSfUQeTYdRMd5
 ns5fQcdJuHuP/a6Sp7auYynYA/Dy+GO6DkdTKF2caQr3nBSuPqF/ROiEjtTmjUMsf6jc+KeSEo3
 I88oQg6NkFHo353TMyk33lyXJ4u2z06IC8owIq17QRrsf5i3YcvlUnPavhkJZIrTCEsePKEkUA5
 /8lgH3kWs=
X-Received: by 2002:a05:6808:3448:b0:496:e0:a47b with SMTP id
 5614622812f47-4962d972e44mr163099b6e.20.1782906450142; 
 Wed, 01 Jul 2026 04:47:30 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4960655e3e2sm1199823b6e.0.2026.07.01.04.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 04:47:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 12/14] cmd: nvedit: Use getopt() in env grep
Date: Wed,  1 Jul 2026 05:42:32 -0600
Message-ID: <20260701114248.1396125-13-sjg@chromium.org>
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

do_env_grep() hand-rolls the same grouped-flag parser as the other env
subcommands: an outer loop over - arguments and an inner while (*++arg)
over the characters, with an explicit case to spot the -- terminator.

Parse the options with getopt() instead. getopt() handles the grouped
form and the -- terminator natively, and the optstring keeps the +
prefix so it stops at the first non-option as the hand-rolled loop did.
Read the search patterns from gs.argv[gs.index] onward.

Move do_env_grep() to the getopt-state command signature, like env
export and env import. The standalone grepenv command uses tab
completion, so declare it with the new U_BOOT_CMD_GETOPT_COMPLETE()
which keeps the auto-complete function.

The existing code ORs the command flag into the hexport_r() flags. That
is inherited from the original parser but is wrong: flag holds
CMD_FLAG_* bits which alias the H_NOCLEAR/H_FORCE/H_INTERACTIVE bits
hexport_r() uses (they happen to be ignored on the export path). Drop it
and pass only grep_what | grep_how. The behaviour is otherwise
unchanged.

CMD_GREPENV selects GETOPT so the parser is linked in on boards that do
not already enable it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/Kconfig  |  1 +
 cmd/nvedit.c | 63 +++++++++++++++++++++++++---------------------------
 2 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 842afa2f390..9cafeb5d07c 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -723,6 +723,7 @@ config CMD_EDITENV
 
 config CMD_GREPENV
 	bool "search env"
+	select GETOPT
 	help
 	  Allow for searching environment variables
 
diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 95d53ba5c32..2af6e9dc03e 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -129,49 +129,46 @@ static int do_env_print(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 
 #ifdef CONFIG_CMD_GREPENV
-static int do_env_grep(struct cmd_tbl *cmdtp, int flag,
-		       int argc, char *const argv[])
+static int do_env_grep(struct getopt_state *gs)
 {
+	const char *optstring = IS_ENABLED(CONFIG_REGEX) ? "+envb" : "+nvb";
 	char *res = NULL;
 	int len, grep_how, grep_what;
-
-	if (argc < 2)
-		return CMD_RET_USAGE;
+	int argc;
+	char *const *argv;
+	int opt;
 
 	grep_how  = H_MATCH_SUBSTR;	/* default: substring search	*/
 	grep_what = H_MATCH_BOTH;	/* default: grep names and values */
 
-	while (--argc > 0 && **++argv == '-') {
-		char *arg = *argv;
-		while (*++arg) {
-			switch (*arg) {
-#ifdef CONFIG_REGEX
-			case 'e':		/* use regex matching */
+	while ((opt = getopt(gs, optstring)) > 0) {
+		switch (opt) {
+		case 'e':		/* use regex matching */
+			if (IS_ENABLED(CONFIG_REGEX))
 				grep_how  = H_MATCH_REGEX;
-				break;
-#endif
-			case 'n':		/* grep for name */
-				grep_what = H_MATCH_KEY;
-				break;
-			case 'v':		/* grep for value */
-				grep_what = H_MATCH_DATA;
-				break;
-			case 'b':		/* grep for both */
-				grep_what = H_MATCH_BOTH;
-				break;
-			case '-':
-				goto DONE;
-			default:
-				return CMD_RET_USAGE;
-			}
+			break;
+		case 'n':		/* grep for name */
+			grep_what = H_MATCH_KEY;
+			break;
+		case 'v':		/* grep for value */
+			grep_what = H_MATCH_DATA;
+			break;
+		case 'b':		/* grep for both */
+			grep_what = H_MATCH_BOTH;
+			break;
+		default:
+			return CMD_RET_USAGE;
 		}
 	}
 
-DONE:
-	len = hexport_r(&env_htab, '\n',
-			flag | grep_what | grep_how,
-			&res, 0, argc, argv);
+	argc = gs->argc - gs->index;
+	argv = &gs->argv[gs->index];
 
+	if (argc < 1)
+		return CMD_RET_USAGE;
+
+	len = hexport_r(&env_htab, '\n', grep_what | grep_how, &res, 0,
+			argc, argv);
 	if (len > 0) {
 		puts(res);
 		free(res);
@@ -1077,7 +1074,7 @@ static struct cmd_tbl cmd_env_sub[] = {
 	U_BOOT_CMD_MKENT_GETOPT(export, 4, 0, do_env_export, "", ""),
 #endif
 #if defined(CONFIG_CMD_GREPENV)
-	U_BOOT_CMD_MKENT(grep, CONFIG_SYS_MAXARGS, 1, do_env_grep, "", ""),
+	U_BOOT_CMD_MKENT_GETOPT(grep, CONFIG_SYS_MAXARGS, 0, do_env_grep, "", ""),
 #endif
 #if defined(CONFIG_CMD_IMPORTENV)
 	U_BOOT_CMD_MKENT_GETOPT(import, 5, 0, do_env_import, "", ""),
@@ -1232,7 +1229,7 @@ U_BOOT_CMD_COMPLETE(
 );
 
 #ifdef CONFIG_CMD_GREPENV
-U_BOOT_CMD_COMPLETE(
+U_BOOT_CMD_GETOPT_COMPLETE(
 	grepenv, CONFIG_SYS_MAXARGS, 0,  do_env_grep,
 	"search environment variables",
 #ifdef CONFIG_REGEX
-- 
2.43.0

