Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83906CD4F5E
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 20:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50FC2846B0;
	Wed, 20 May 2026 22:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XtTaU3vd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EA73846B0; Wed, 20 May 2026 22:13:17 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C13843B6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 22:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-482de4ef03aso3934117b6e.1
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 13:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779307993; x=1779912793; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=melcj5jdm50ahxLQNIW8DXIXm37n03ZySCsw6C0WSxw=;
 b=XtTaU3vd9VkvCiTSbW0sQfosmz5eJaE3zCqmXSnHWJ3hvhvCjSu/iH0Z73jFaCK/9j
 /HqKMxBVGy1x2KsK0Gr4vKgroOTiYcuuB0QCIp6tvXeLfo+6jK4Det+PpTJEqhqSsdVp
 6TLiw9ocPGWmOdlF0lbhgrwZC3OTDD9b0jT40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779307993; x=1779912793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=melcj5jdm50ahxLQNIW8DXIXm37n03ZySCsw6C0WSxw=;
 b=fXbOsExaLQmmrgaO37Qb+MnyaeXdQta7dC5WOzzdttBv8ifFtQUdI7pVyHK6DZptrZ
 A3PqLKbfun9GcoSu5NvIbyvGxcX+CSHHpYfCdb02JH1Tlmj8BcIGziYa17ANP5thEgFY
 4+698pJZIq+gXmIq6ZHegoHbYEK21U9U6KLEUxETBDUUjxxl/Dmj71S+JQEFNNuwElOc
 9mwCFzzmkNUKS/vFlslcQPI6Yit/rbJfxeIveM8kTmCe4VxnUZ+srkd6DhITFwvKRIOr
 tVnEkRMld6o56Y3OeJm1rV/wg9JkFY5o2GQQXKOhmpSY+3OraWRD/8DG9d5Se9jYenGz
 Y5/g==
X-Gm-Message-State: AOJu0YzPwJimah9uunS1R46MiazhFojSWkBT8iWfWiAp4VAECWKs+AUZ
 QxIzCSoreufFHvOt2jzz21st2Mb+yTsK23U+EBhNV2FCbrz34BfKfmc6okOUlDZzLU28uYePJw7
 8a9dlFvy5
X-Gm-Gg: Acq92OHsdnJPTyHAEHINrCVFfD2p5RrAQhRC3h/6OqbG1Od20+CS3tbFXD/FcYEetRu
 dm5p2DHaRblLZ4Pyhwxk+vxhpcdV6aEGHPzxziZtjH2VzGE1hJbCUC0QMoAMnIjira2ZEfTNGEc
 oYmamR3FKUv9o6cTxnhKBQ/Ndrozy0hjg98wTwXYytm5hq33ByyQOFO4ZjJIwIKDqoGwboZFvLL
 7GGUdAlTlZVWTNeTGywnB3eP+cUB9MXhqY1s/0Td/p1bsZPYyWgKP5+b7CIQo3vjtfebnQ7pM5q
 ApYoJupZ/dDA134G86ZK2sA0a6bMiKg61NsRnWrTFJW5RR9dWETi3v8pCn6ST3bpRBJwvR704V9
 oWcLiof9+OFlPYSt5G816+FD87l0n68nOZibGrKvLADCAtj8GX2xa6fjayRUYMOmONRa6GvqVRs
 JdB6rx2qpjrJbM+CtT4C9OLnHxFEMA
X-Received: by 2002:a05:6820:134f:b0:696:2c6f:b99b with SMTP id
 006d021491bc7-69d6b9b469bmr561710eaf.21.1779307993094; 
 Wed, 20 May 2026 13:13:13 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d045e6fb1sm8862051eaf.2.2026.05.20.13.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 13:13:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 2/2] cmd: nvedit: Use getopt() in env import
Date: Wed, 20 May 2026 14:12:14 -0600
Message-ID: <20260520201218.3752042-3-sjg@chromium.org>
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

This is the other gnarly hand-rolled parser in nvedit.c

The code walks each -prefixed argv element by hand, opens an inner
while (*++arg) to split grouped flags, and tracks a fmt counter to
catch a second -b / -c / -t

getopt() collapses all of that. The mutex check for the format flags
is done after the option loop (it is a per-command rule, not an
option-parsing rule) and the trailing positional list is read from
argv + gs.index.

Adjust CMD_IMPORTENV to select GETOPT so the parser is linked in on
boards that did not already enable it.

Also redo the sep_err logic and error message, along with a fmt tweak
to reduce code size.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/Kconfig  |  1 +
 cmd/nvedit.c | 95 ++++++++++++++++++++++++----------------------------
 env/common.c |  2 +-
 3 files changed, 46 insertions(+), 52 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index a5a20bde4b5..72ff4dbfe60 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -711,6 +711,7 @@ config CMD_EXPORTENV
 config CMD_IMPORTENV
 	bool "env import"
 	default y
+	select GETOPT
 	help
 	  Import environments.
 
diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 5dca1b804fd..ce1f0e9bd2c 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -752,64 +752,64 @@ static int do_env_export(struct cmd_tbl *cmdtp, int flag,
 static int do_env_import(struct cmd_tbl *cmdtp, int flag,
 			 int argc, char *const argv[])
 {
+	struct getopt_state gs;
 	ulong	addr;
-	char	*cmd, *ptr;
+	char	*ptr, *tok;
 	char	sep = '\n';
 	int	chk = 0;
 	int	fmt = 0;
 	int	del = 0;
 	int	crlf_is_lf = 0;
-	int	wl = 0;
+	int	wl;
 	size_t	size;
+	int	opt;
 
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
-			case 't':		/* text format */
-				if (fmt++)
-					goto sep_err;
-				sep = '\n';
-				break;
-			case 'r':		/* handle CRLF like LF */
-				crlf_is_lf = 1;
-				break;
-			case 'd':
-				del = 1;
-				break;
-			default:
-				return CMD_RET_USAGE;
-			}
+	getopt_init_state(&gs);
+	while ((opt = getopt(&gs, argc, argv, "bctrd")) > 0) {
+		fmt++;
+		switch (opt) {
+		case 'b':		/* raw binary format */
+			sep = '\0';
+			break;
+		case 'c':		/* external checksum format */
+			sep = '\0';
+			chk = 1;
+			break;
+		case 't':		/* text format (default) */
+			break;
+		case 'r':		/* handle CRLF like LF */
+			crlf_is_lf = 1;
+			fmt--;
+			break;
+		case 'd':
+			del = 1;
+			fmt--;
+			break;
+		default:
+			return CMD_RET_USAGE;
 		}
 	}
 
-	if (argc < 1)
+	if (gs.index >= argc)
+		return CMD_RET_USAGE;
+	if (fmt > 1) {
+		printf("## Error: %s: only one of -b/c/t allowed\n", argv[0]);
+
 		return CMD_RET_USAGE;
+	}
 
 	if (!fmt)
 		printf("## Warning: defaulting to text format\n");
 
-	if (sep != '\n' && crlf_is_lf )
+	if (sep != '\n' && crlf_is_lf)
 		crlf_is_lf = 0;
 
-	addr = hextoul(argv[0], NULL);
+	addr = hextoul(argv[gs.index++], NULL);
 	ptr = map_sysmem(addr, 0);
 
-	if (argc >= 2 && strcmp(argv[1], "-")) {
-		size = hextoul(argv[1], NULL);
+	tok = gs.index < argc ? argv[gs.index++] : NULL;
+	if (tok && strcmp(tok, "-")) {
+		size = hextoul(tok, NULL);
 	} else if (chk) {
 		puts("## Error: external checksum format must pass size\n");
 		return CMD_RET_FAILURE;
@@ -825,22 +825,19 @@ static int do_env_import(struct cmd_tbl *cmdtp, int flag,
 			++size;
 		}
 		if (size == MAX_ENV_SIZE) {
-			printf("## Warning: Input data exceeds %d bytes"
+			printf("## Warning: Input exceeds %d bytes"
 				" - truncated\n", MAX_ENV_SIZE);
 		}
 		size += 2;
-		printf("## Info: input data size = %zu = 0x%zX\n", size, size);
+		printf("## Info: input size = %zu = %#zX\n", size, size);
 	}
 
-	if (argc > 2)
-		wl = 1;
-
 	if (chk) {
 		uint32_t crc;
 		env_t *ep = (env_t *)ptr;
 
 		if (size <= offsetof(env_t, data)) {
-			printf("## Error: Invalid size 0x%zX\n", size);
+			printf("## Error: Invalid size %#zX\n", size);
 			return 1;
 		}
 
@@ -854,20 +851,16 @@ static int do_env_import(struct cmd_tbl *cmdtp, int flag,
 		ptr = (char *)ep->data;
 	}
 
+	wl = argc - gs.index;
 	if (!himport_r(&env_htab, ptr, size, sep, del ? 0 : H_NOCLEAR,
-		       crlf_is_lf, wl ? argc - 2 : 0, wl ? &argv[2] : NULL)) {
-		pr_err("## Error: Environment import failed: errno = %d\n",
+		       crlf_is_lf, wl, wl ? &argv[gs.index] : NULL)) {
+		pr_err("## Error: Environment import failed (err %dE)\n",
 		       errno);
 		return 1;
 	}
 	gd->flags |= GD_FLG_ENV_READY;
 
 	return 0;
-
-sep_err:
-	printf("## %s: only one of \"-b\", \"-c\" or \"-t\" allowed\n",
-		cmd);
-	return 1;
 }
 #endif
 
diff --git a/env/common.c b/env/common.c
index b2adbe93dbe..986400f912f 100644
--- a/env/common.c
+++ b/env/common.c
@@ -402,7 +402,7 @@ void env_set_default(const char *s, int flags)
 	if (himport_r(&env_htab, default_environment,
 			sizeof(default_environment), '\0', flags, 0,
 			0, NULL) == 0) {
-		pr_err("## Error: Environment import failed: errno = %d\n",
+		pr_err("## Error: Environment import failed (err %dE)\n",
 		       errno);
 		return;
 	}
-- 
2.43.0

