Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F813C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 281F784C18;
	Wed,  1 Jul 2026 13:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BRX54W73";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14C5984BBD; Wed,  1 Jul 2026 13:47:28 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCAC984BAA
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-448b89ad70fso90963fac.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782906444; x=1783511244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qaXDyRruOr+TDRr9P2ojTh8gDUoHfDhv0sjRZ7w0Pfs=;
 b=BRX54W73isSLPCToWUq7V01Hw2wdQmBibt2yOlSLoAHCItq7lUEvCrgNxk9oi3T1Ax
 6odI4QmBh/1zKKTPGatxUHbxa9ez6s28niEiL4ZCzlkCohnrcGwC+O3oKqf1KqMnYMD+
 WR66nPR/WSxkQWg2L9TsFG7OQsKC4mbXHtS9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782906444; x=1783511244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qaXDyRruOr+TDRr9P2ojTh8gDUoHfDhv0sjRZ7w0Pfs=;
 b=fas2qCvd8zLWjONIXZWdpL+T3UjFpEpHDVHb0pAmgpQoBHp5hTj/8YnelUjzikmtQ/
 Lp2MSMgBDOTjRgeqlmKNP2R2TOnmDJdZCgqqNOyFkiE3vIqtpL4+MpxD82j19sL7npFj
 7vc5O92TzI7tSskT1IyfegDLgd+K7RgBAEkHq54PnP+EwTbzL+uf5mXx57QmXg42KNGb
 2Y+9NccqK3n8aljXFAY+SZVQSXhoG9wzdHJwYLPjHk95DABeUndES0xtrn0evRlLxdSV
 j6c27nELnKY1EObwZgdhemd4eqlcpQs0ZmZdEqQnsB7ffpfzCB3OTT6CEHyhGs1qZhnt
 tR1w==
X-Gm-Message-State: AOJu0YwXtsbfSFfIfwHQ7ZVI7pnSUNr+h/kS84GqQ7EAU9kgdrxUmkiV
 2Rq3AhiugnOsXMU6kIIqL/CJbL9Smjlu1x6nTFqtenwgpaTsER5e4tBeq+YMBcGeFSCajbG1fwC
 GdDQ=
X-Gm-Gg: AfdE7cmzpXqMBHQL84hwb0SgZWxHDblgebk4uBVPxGSBeANoWT5yfau11H6TbV3SkDP
 RV5dEqprd5kXP8hEXF8Tt6NwOgiWgZQwyhkklYVGqOPbpHVyAOOuQ3oRK+/Rozlnz8VZ3qE49xr
 /BrMKXuBHKgsCbpPxWyCMJhF/zhcs3gzCDU1ZgwbZXGSWGcBpIhAbu/UJOa41WIBg4Scm9cVHgn
 oPi2Qe5aXSyvzYj50Rq/HyJjCz3NMo5TtnOkMr0+g+dlknGuwBMEPRXZSpaAaTb+MXbhyJN1w2S
 ygA9zuVzi1r1EzuBmsqFn5iJg93FQf5/DkNo/qqnR5GObul0SSOKeGJshrcD3NnouCFx91hqHYF
 6jEarBaSRG4pY65KvlptdotUc3w+Vqlz6L5YZCIBGu2+fIAqSQFmLFUqzACYp77b6JhjHz5sLgU
 mFtzxwXHo=
X-Received: by 2002:a05:6808:1b0e:b0:496:2b3:4a85 with SMTP id
 5614622812f47-4960efeaba3mr585495b6e.22.1782906444379; 
 Wed, 01 Jul 2026 04:47:24 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4960655e3e2sm1199823b6e.0.2026.07.01.04.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 04:47:22 -0700 (PDT)
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
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 10/14] cmd: nvedit: Use getopt() in env export
Date: Wed,  1 Jul 2026 05:42:30 -0600
Message-ID: <20260701114248.1396125-11-sjg@chromium.org>
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

do_env_export() is one of the gnarliest hand-rolled parsers in the env
code. It walks each - argument by hand, opens an inner while (*++arg)
to split grouped flags, tracks an fmt counter to reject a second
-b/-c/-t and uses a goto NXTARG to skip the rest of the current element
after -s has eaten the following argument for its size.

Replace all of that with getopt(). Move do_env_export() to the
getopt-state command signature, declared with U_BOOT_CMD_MKENT_GETOPT().
The -s argument arrives in gs->arg. Move the format-flag
mutual-exclusion check after the option loop (it is a per-command rule,
not an option-parsing rule) and read the trailing positional list from
gs->argv[gs->index]. Keep the + prefix on the optstring so getopt()
stops at the first non-option, exactly as the hand-rolled loop did.

While here, write the text-format filesize with env_set_hex() rather
than an open-coded sprintf() into a stack buffer. This drops the buffer
and matches the binary path, which already uses env_set_hex(); the only
visible change is that the value is now lower-case hex (its consumers
read it with hextoul(), which is case-insensitive). Check the return
value of both env_set_hex() calls and return 1 on failure, rather than
ignoring it.

Route the env subcommand dispatch in do_env() through cmd_invoke() so
subcommands using either signature are called correctly.

CMD_EXPORTENV selects GETOPT so the parser is linked in on boards that
do not already enable it.

Also redo the sep_err logic, use env_set_hex() and shorten error
messages to reduce code size.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Redo the sep_err logic to reduce code size

 cmd/Kconfig  |  1 +
 cmd/nvedit.c | 80 +++++++++++++++++++++++++---------------------------
 2 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 3c5abddd31f..e3d92055f17 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -704,6 +704,7 @@ config CMD_ASKENV
 config CMD_EXPORTENV
 	bool "env export"
 	default y
+	select GETOPT
 	help
 	  Export environments.
 
diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 636bddee1be..c74898a05fb 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -29,6 +29,7 @@
 #include <console.h>
 #include <env.h>
 #include <env_internal.h>
+#include <getopt.h>
 #include <log.h>
 #include <search.h>
 #include <errno.h>
@@ -631,10 +632,8 @@ static int do_env_delete(struct cmd_tbl *cmdtp, int flag,
  *
  *	=> env import -d -t ${backup_addr}
  */
-static int do_env_export(struct cmd_tbl *cmdtp, int flag,
-			 int argc, char *const argv[])
+static int do_env_export(struct getopt_state *gs)
 {
-	char	buf[32];
 	ulong	addr;
 	char	*ptr, *cmd, *res;
 	size_t	size = 0;
@@ -643,52 +642,48 @@ static int do_env_export(struct cmd_tbl *cmdtp, int flag,
 	char	sep = '\n';
 	int	chk = 0;
 	int	fmt = 0;
+	int	argc;
+	char	*const *argv;
+	int	opt;
 
-	cmd = *argv;
+	cmd = gs->argv[0];
 
-	while (--argc > 0 && **++argv == '-') {
-		char *arg = *argv;
-		while (*++arg) {
-			switch (*arg) {
-			case 'b':		/* raw binary format */
-				if (fmt++)
-					goto sep_err;
-				sep = '\0';
-				break;
-			case 'c':		/* external checksum format */
-				if (fmt++)
-					goto sep_err;
-				sep = '\0';
-				chk = 1;
-				break;
-			case 's':		/* size given */
-				if (--argc <= 0)
-					return cmd_usage(cmdtp);
-				size = hextoul(*++argv, NULL);
-				goto NXTARG;
-			case 't':		/* text format */
-				if (fmt++)
-					goto sep_err;
-				sep = '\n';
-				break;
-			default:
-				return CMD_RET_USAGE;
-			}
+	while ((opt = getopt(gs, "+bcs:t")) > 0) {
+		switch (opt) {
+		case 'b':		/* raw binary format */
+			sep = '\0';
+			fmt++;
+			break;
+		case 'c':		/* external checksum format */
+			sep = '\0';
+			chk = 1;
+			fmt++;
+			break;
+		case 's':		/* size given */
+			size = hextoul(gs->arg, NULL);
+			break;
+		case 't':		/* text format */
+			sep = '\n';
+			fmt++;
+			break;
+		default:
+			return CMD_RET_USAGE;
 		}
-NXTARG:		;
 	}
+	if (fmt > 1)
+		goto sep_err;
 
-	if (argc < 1)
+	if (gs->index >= gs->argc)
 		return CMD_RET_USAGE;
 
-	addr = hextoul(argv[0], NULL);
+	addr = hextoul(getopt_pop(gs), NULL);
 	ptr = map_sysmem(addr, size);
 
 	if (size)
 		memset(ptr, '\0', size);
 
-	argc--;
-	argv++;
+	argc = gs->argc - gs->index;
+	argv = &gs->argv[gs->index];
 
 	if (sep) {		/* export as text file */
 		len = hexport_r(&env_htab, sep,
@@ -699,8 +694,8 @@ NXTARG:		;
 			       errno);
 			return 1;
 		}
-		sprintf(buf, "%zX", (size_t)len);
-		env_set("filesize", buf);
+		if (env_set_hex("filesize", len))
+			return 1;
 
 		return 0;
 	}
@@ -728,7 +723,8 @@ NXTARG:		;
 		envp->flags = ENV_REDUND_ACTIVE;
 #endif
 	}
-	env_set_hex("filesize", len + offsetof(env_t, data));
+	if (env_set_hex("filesize", len + offsetof(env_t, data)))
+		return 1;
 
 	return 0;
 
@@ -1077,7 +1073,7 @@ static struct cmd_tbl cmd_env_sub[] = {
 	U_BOOT_CMD_MKENT(flags, 1, 0, do_env_flags, "", ""),
 #endif
 #if defined(CONFIG_CMD_EXPORTENV)
-	U_BOOT_CMD_MKENT(export, 4, 0, do_env_export, "", ""),
+	U_BOOT_CMD_MKENT_GETOPT(export, 4, 0, do_env_export, "", ""),
 #endif
 #if defined(CONFIG_CMD_GREPENV)
 	U_BOOT_CMD_MKENT(grep, CONFIG_SYS_MAXARGS, 1, do_env_grep, "", ""),
@@ -1127,7 +1123,7 @@ static int do_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	cp = find_cmd_tbl(argv[0], cmd_env_sub, ARRAY_SIZE(cmd_env_sub));
 
 	if (cp)
-		return cp->cmd(cmdtp, flag, argc, argv);
+		return cmd_invoke(cp, flag, argc, argv);
 
 	return CMD_RET_USAGE;
 }
-- 
2.43.0

