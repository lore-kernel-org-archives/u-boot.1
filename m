Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFCBCD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 20:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1625B847C6;
	Wed, 20 May 2026 22:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hZvIcfyP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F2F48470E; Wed, 20 May 2026 22:13:14 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5F5C843B6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 22:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-69498319ee7so2728110eaf.1
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 13:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779307990; x=1779912790; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qCYGX+rU5wJDBdWIJv4xaL6ZYNRPwkzMC4npDTSP38Y=;
 b=hZvIcfyPiicCQtXqYxDxc9qa0+/78msAD2vjD5fV1iDETQKP3zaEMflaR2wy57g7jf
 TT63nQTaIsH9iI7MgZz2h1Rqfb8J/xLMM49GcuICxTxCXVOFgZDAdyJfE0gqXPnmNtv3
 qgOigdmzNgAWLgxNRPcjD/BSVrE26kmzveJTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779307990; x=1779912790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qCYGX+rU5wJDBdWIJv4xaL6ZYNRPwkzMC4npDTSP38Y=;
 b=NURJoNcVveUDs2kJkzYWbNWo07hSMH3iiaYroBNcap/MJKesnU5iarn1DhEla4fDgp
 k/BurQc77QQMkKSydNNHxvpGWH7WtmyLi3GJUQRUW0PlkxAoxID8f7I7RREBE5DLhMT5
 +cxt6h0oUjB520tDRnP///nKYtejY2uuOjf6AQ9b1fw0x+cW1Ow4X1CEF5ZB6qnz/fF4
 ybfzxutf/nY7rWJ+w/AwRQuKB3cKg9080++D23TE0ioMx17svuIIzYKIy+2kR/hLMUJ7
 4C/ENKUeSssui9F/QYQINCmP+lJqLwoTW+5iCynQu8OvpN6kRlBf007EppQMSzZfqvy/
 +EwQ==
X-Gm-Message-State: AOJu0YyaHmvuUEQ5pYA+dOtoGK6sDkw9lOQ7uzpIbQ8PCBAQ4sUmCgTT
 TV3b/Xytd5uRYrUdGrZTOZOiMcWwyC2O6g6GGaAAcYPZRBrpTY8FjQjGCaSyaCyMgjqWDkAVlQr
 lGWtjdK+o
X-Gm-Gg: Acq92OEGmVumJsAzsaVK1RHZJ/AomjjrTLg+PTu/XRamMBVJRPhcHvhQYvmdjS+ZvVb
 6ELKsrgj48r14SUA0INDfzjVhYzlWTBnVgDrWni/MGenjDPpEcYqjm6FqZbhTu4D2rFpFlJftHR
 R91sF+c6oUOBYr4D622PU94yk0k8CQOP9ZtK5lxBx60hWDuVOmoMZRi01gojwqjKNAJ43TdlANi
 3wxec+vsds833rWKBwCeXRvoHD1B2NkEe5LVNGIO+OiQV3Z0IL/s+NmbcT5EzCdao0jnJ55J6H4
 o7GM1p2RM4Hz0DJ2cSvIeZfoicijHQEvnLz6MiR4UgBcqSoCASbHbEVwV/csnyODnETXUecQDCg
 YJADBpuGsuvJghRiE9n+H+VUpIL8f5aLE+37i/bJcs6gUtwKwCAY89F4sUEIBXbEWywIIv7Zj7x
 XcW6ZW8WXWx1sSRoWfYw==
X-Received: by 2002:a05:6820:1991:b0:694:843a:553d with SMTP id
 006d021491bc7-69d6b98e9ebmr537459eaf.18.1779307989943; 
 Wed, 20 May 2026 13:13:09 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d045e6fb1sm8862051eaf.2.2026.05.20.13.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 13:13:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 1/2] cmd: nvedit: Use getopt() in env export
Date: Wed, 20 May 2026 14:12:13 -0600
Message-ID: <20260520201218.3752042-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520201218.3752042-1-sjg@chromium.org>
References: <20260520201218.3752042-1-sjg@chromium.org>
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

This is one of the gnarliest hand-rolled parsers in nvedit.c

The code walks each -prefixed argv element by hand, opens an inner
while (*++arg) to split grouped flags, and tracks a fmt counter to
catch a second -b / -c / -t

It also adds a 'goto NXTARG' that jumps over the inner loop after
consuming the argument to -s SIZE, since the rest of the current
argv element no longer makes sense once -s has eaten the next slot.

getopt() collapses all of that. The mutex check for the format flags
is done after the option loop (it is a per-command rule, not an
option-parsing rule), the -s argument arrives in gs.arg, and the
trailing positional list is read from argv + gs.index.

Adjust CMD_EXPORTENV to select GETOPT so the parser is linked in on
boards that did not already enable it.

Also redo the sep_err logic, use env_set_hex() and shorten error
messages to reduce code size.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/Kconfig  |  1 +
 cmd/nvedit.c | 89 ++++++++++++++++++++++------------------------------
 2 files changed, 38 insertions(+), 52 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c71c6824a19..a5a20bde4b5 100644
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
index 636bddee1be..5dca1b804fd 100644
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
@@ -634,73 +635,62 @@ static int do_env_delete(struct cmd_tbl *cmdtp, int flag,
 static int do_env_export(struct cmd_tbl *cmdtp, int flag,
 			 int argc, char *const argv[])
 {
-	char	buf[32];
+	struct getopt_state gs;
 	ulong	addr;
-	char	*ptr, *cmd, *res;
+	char	*ptr, *res;
 	size_t	size = 0;
 	ssize_t	len;
 	env_t	*envp;
 	char	sep = '\n';
 	int	chk = 0;
 	int	fmt = 0;
-
-	cmd = *argv;
-
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
+	int	opt;
+
+	getopt_init_state(&gs);
+	while ((opt = getopt(&gs, argc, argv, "bcs:t")) > 0) {
+		fmt++;
+		switch (opt) {
+		case 'b':		/* raw binary format */
+			sep = '\0';
+			break;
+		case 'c':		/* external checksum format */
+			sep = '\0';
+			chk = 1;
+			break;
+		case 's':		/* size given */
+			size = hextoul(gs.arg, NULL);
+			fmt--;
+			break;
+		case 't':		/* text format (default) */
+			break;
+		default:
+			return CMD_RET_USAGE;
 		}
-NXTARG:		;
 	}
 
-	if (argc < 1)
+	if (gs.index >= argc)
 		return CMD_RET_USAGE;
+	if (fmt > 1) {
+		printf("## Error: %s: only one of -b/c/t allowed\n", argv[0]);
+		return 1;
+	}
 
-	addr = hextoul(argv[0], NULL);
+	addr = hextoul(argv[gs.index++], NULL);
 	ptr = map_sysmem(addr, size);
 
 	if (size)
 		memset(ptr, '\0', size);
 
-	argc--;
-	argv++;
-
 	if (sep) {		/* export as text file */
 		len = hexport_r(&env_htab, sep,
-				H_MATCH_KEY | H_MATCH_IDENT,
-				&ptr, size, argc, argv);
+				H_MATCH_KEY | H_MATCH_IDENT, &ptr, size,
+				argc - gs.index, &argv[gs.index]);
 		if (len < 0) {
-			pr_err("## Error: Cannot export environment: errno = %d\n",
+			pr_err("## Error: Cannot export environment (err %dE)\n",
 			       errno);
 			return 1;
 		}
-		sprintf(buf, "%zX", (size_t)len);
-		env_set("filesize", buf);
+		env_set_hex("filesize", len);
 
 		return 0;
 	}
@@ -713,10 +703,10 @@ NXTARG:		;
 		res = ptr;
 
 	len = hexport_r(&env_htab, '\0',
-			H_MATCH_KEY | H_MATCH_IDENT,
-			&res, ENV_SIZE, argc, argv);
+			H_MATCH_KEY | H_MATCH_IDENT, &res, ENV_SIZE,
+			argc - gs.index, &argv[gs.index]);
 	if (len < 0) {
-		pr_err("## Error: Cannot export environment: errno = %d\n",
+		pr_err("## Error: Cannot export environment (err %dE)\n",
 		       errno);
 		return 1;
 	}
@@ -731,11 +721,6 @@ NXTARG:		;
 	env_set_hex("filesize", len + offsetof(env_t, data));
 
 	return 0;
-
-sep_err:
-	printf("## Error: %s: only one of \"-b\", \"-c\" or \"-t\" allowed\n",
-	       cmd);
-	return 1;
 }
 #endif
 
-- 
2.43.0

