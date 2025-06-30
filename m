Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D45FC83029
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 15:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8491E809A5;
	Mon, 30 Jun 2025 17:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="RXZQ/1Xl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D78CF80B9B; Mon, 30 Jun 2025 17:17:55 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
 by phobos.denx.de (Postfix) with ESMTP id BFDFA8003E
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 17:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1751296460;
 bh=XSMxOxslwfJuTuVfXcZmlqSyRgBinTLkUu4ZBlE3guU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=RXZQ/1XlsRboU8NxkI2oOUBCDbGZBRMu8Yyh9RXFLdhZgMNvFv/4x0J4QztVYvlU1
 73BhFyZkfP7bSiAjdY//eZAYoBAZ9DQPcueOf5WU/+akX1DtrYofzLVfKbZlM+EYMD
 4vn+iXeOVDmlhMlweDaZ1WGYY4xiIjtezc/iCvImZQQUHxe9PsSx8ZVp7sDAzE0t5D
 1ci6RMU0eQLAfZ+unB6slk8Gn5BCB8Z2P0Uodj4ewNqlUCzNEJgvtNVO5j8yG2T7WJ
 eQEYqzq8Rr/EzFx5JS7T6gn9zBF2ZyMPxAyA/wZdYKnmfXltUpP1WqN8F6n649LCGX
 f+YU4J+ATgp+A==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH V4 1/3] cmd: nvedit: Convert the parsing of arguments to
 getopt()
Date: Mon, 30 Jun 2025 17:12:30 +0200
Message-ID: <20250630151232.39100-2-cniedermaier@dh-electronics.com>
X-klartext: yes
In-Reply-To: <20250630151232.39100-1-cniedermaier@dh-electronics.com>
References: <20250630151232.39100-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The entire parsing of the arguments is done manually. Improve this
by converting all parsing of arguments to getopt().

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
V3: - Add this patch to the series
V4: - No changes
---
 cmd/nvedit.c | 335 +++++++++++++++++++++++++--------------------------
 env/Kconfig  |   1 +
 2 files changed, 164 insertions(+), 172 deletions(-)

diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 11c3cea882b..945db536bf2 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -41,6 +41,7 @@
 #include <linux/stddef.h>
 #include <asm/byteorder.h>
 #include <asm/io.h>
+#include <getopt.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -92,19 +93,26 @@ static int do_env_print(struct cmd_tbl *cmdtp, int flag, int argc,
 	int i;
 	int rcode = 0;
 	int env_flag = H_HIDE_DOT;
+	struct getopt_state gs;
+	int opt;
 
+	getopt_init_state(&gs);
+	while ((opt = getopt(&gs, argc, argv, "ea")) > 0) {
+		switch (opt) {
+		case 'e':
 #if defined(CONFIG_CMD_NVEDIT_EFI)
-	if (argc > 1 && argv[1][0] == '-' && argv[1][1] == 'e')
-		return do_env_print_efi(cmdtp, flag, --argc, ++argv);
+			return do_env_print_efi(cmdtp, flag, argc - gs.index, &argv[gs.index]);
 #endif
-
-	if (argc > 1 && argv[1][0] == '-' && argv[1][1] == 'a') {
-		argc--;
-		argv++;
-		env_flag &= ~H_HIDE_DOT;
+			break;
+		case 'a':
+			env_flag &= ~H_HIDE_DOT;
+			break;
+		default:
+			return CMD_RET_USAGE;
+		}
 	}
 
-	if (argc == 1) {
+	if (gs.index == argc) {
 		/* print all env vars */
 		rcode = env_print(NULL, env_flag);
 		if (!rcode)
@@ -116,7 +124,7 @@ static int do_env_print(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	/* print selected env vars */
 	env_flag &= ~H_HIDE_DOT;
-	for (i = 1; i < argc; ++i) {
+	for (i = gs.index; i < argc; ++i) {
 		int rc = env_print(argv[i], env_flag);
 		if (!rc) {
 			printf("## Error: \"%s\" not defined\n", argv[i]);
@@ -133,6 +141,8 @@ static int do_env_grep(struct cmd_tbl *cmdtp, int flag,
 {
 	char *res = NULL;
 	int len, grep_how, grep_what;
+	struct getopt_state gs;
+	int opt;
 
 	if (argc < 2)
 		return CMD_RET_USAGE;
@@ -140,36 +150,31 @@ static int do_env_grep(struct cmd_tbl *cmdtp, int flag,
 	grep_how  = H_MATCH_SUBSTR;	/* default: substring search	*/
 	grep_what = H_MATCH_BOTH;	/* default: grep names and values */
 
-	while (--argc > 0 && **++argv == '-') {
-		char *arg = *argv;
-		while (*++arg) {
-			switch (*arg) {
+	getopt_init_state(&gs);
+	while ((opt = getopt(&gs, argc, argv, "envb")) > 0) {
+		switch (opt) {
 #ifdef CONFIG_REGEX
-			case 'e':		/* use regex matching */
-				grep_how  = H_MATCH_REGEX;
-				break;
+		case 'e':		/* use regex matching */
+			grep_how  = H_MATCH_REGEX;
+			break;
 #endif
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
 	len = hexport_r(&env_htab, '\n',
 			flag | grep_what | grep_how,
-			&res, 0, argc, argv);
+			&res, 0, argc - gs.index, &argv[gs.index]);
 
 	if (len > 0) {
 		puts(res);
@@ -510,37 +515,34 @@ static int do_env_default(struct cmd_tbl *cmdtp, int flag,
 			  int argc, char *const argv[])
 {
 	int all = 0, env_flag = H_INTERACTIVE;
-
-	debug("Initial value for argc=%d\n", argc);
-	while (--argc > 0 && **++argv == '-') {
-		char *arg = *argv;
-
-		while (*++arg) {
-			switch (*arg) {
-			case 'a':		/* default all */
-				all = 1;
-				break;
-			case 'f':		/* force */
-				env_flag |= H_FORCE;
-				break;
-			case 'k':
-				env_flag |= H_NOCLEAR;
-				break;
-			default:
-				return cmd_usage(cmdtp);
-			}
+	struct getopt_state gs;
+	int opt;
+
+	getopt_init_state(&gs);
+	while ((opt = getopt(&gs, argc, argv, "afk")) > 0) {
+		switch (opt) {
+		case 'a':		/* default all */
+			all = 1;
+			break;
+		case 'f':		/* force */
+			env_flag |= H_FORCE;
+			break;
+		case 'k':
+			env_flag |= H_NOCLEAR;
+			break;
+		default:
+			return cmd_usage(cmdtp);
 		}
 	}
-	debug("Final value for argc=%d\n", argc);
-	if (all && (argc == 0)) {
+	if (all && (argc == gs.index)) {
 		/* Reset the whole environment */
 		env_set_default("## Resetting to default environment\n",
 				env_flag);
 		return 0;
 	}
-	if (!all && (argc > 0)) {
+	if (!all && (argc > gs.index)) {
 		/* Reset individual variables */
-		env_set_default_vars(argc, argv, env_flag);
+		env_set_default_vars(argc - gs.index, &argv[gs.index], env_flag);
 		return 0;
 	}
 
@@ -552,32 +554,26 @@ static int do_env_delete(struct cmd_tbl *cmdtp, int flag,
 {
 	int env_flag = H_INTERACTIVE;
 	int ret = 0;
+	struct getopt_state gs;
+	int opt;
+	int i;
 
-	debug("Initial value for argc=%d\n", argc);
-	while (argc > 1 && **(argv + 1) == '-') {
-		char *arg = *++argv;
-
-		--argc;
-		while (*++arg) {
-			switch (*arg) {
-			case 'f':		/* force */
-				env_flag |= H_FORCE;
-				break;
-			default:
-				return CMD_RET_USAGE;
-			}
+	getopt_init_state(&gs);
+	while ((opt = getopt(&gs, argc, argv, "f")) > 0) {
+		switch (opt) {
+		case 'f':		/* force */
+			env_flag |= H_FORCE;
+			break;
+		default:
+			return CMD_RET_USAGE;
 		}
 	}
-	debug("Final value for argc=%d\n", argc);
 
 	env_inc_id();
 
-	while (--argc > 0) {
-		char *name = *++argv;
-
-		if (hdelete_r(name, &env_htab, env_flag))
+	for (i = gs.index; i < argc; i++)
+		if (hdelete_r(argv[i], &env_htab, env_flag))
 			ret = 1;
-	}
 
 	return ret;
 }
@@ -633,64 +629,58 @@ static int do_env_export(struct cmd_tbl *cmdtp, int flag,
 {
 	char	buf[32];
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
+	struct getopt_state gs;
+	int opt;
+
+	getopt_init_state(&gs);
+	while ((opt = getopt(&gs, argc, argv, "bcs:t")) > 0) {
+		switch (opt) {
+		case 'b':		/* raw binary format */
+			if (fmt++)
+				goto sep_err;
+			sep = '\0';
+			break;
+		case 'c':		/* external checksum format */
+			if (fmt++)
+				goto sep_err;
+			sep = '\0';
+			chk = 1;
+			break;
+		case 's':		/* size given */
+			size = hextoul(gs.arg, NULL);
+			break;
+		case 't':		/* text format */
+			if (fmt++)
+				goto sep_err;
+			sep = '\n';
+			break;
+		default:
+			return CMD_RET_USAGE;
 		}
-NXTARG:		;
 	}
 
-	if (argc < 1)
+	if (argc == gs.index)
 		return CMD_RET_USAGE;
 
-	addr = hextoul(argv[0], NULL);
+	addr = hextoul(argv[gs.index], NULL);
 	ptr = map_sysmem(addr, size);
 
+	gs.index++;
+
 	if (size)
 		memset(ptr, '\0', size);
 
-	argc--;
-	argv++;
-
 	if (sep) {		/* export as text file */
 		len = hexport_r(&env_htab, sep,
 				H_MATCH_KEY | H_MATCH_IDENT,
-				&ptr, size, argc, argv);
+				&ptr, size, argc - gs.index, &argv[gs.index]);
 		if (len < 0) {
 			pr_err("## Error: Cannot export environment: errno = %d\n",
 			       errno);
@@ -711,7 +701,7 @@ NXTARG:		;
 
 	len = hexport_r(&env_htab, '\0',
 			H_MATCH_KEY | H_MATCH_IDENT,
-			&res, ENV_SIZE, argc, argv);
+			&res, ENV_SIZE, argc - gs.index, &argv[gs.index]);
 	if (len < 0) {
 		pr_err("## Error: Cannot export environment: errno = %d\n",
 		       errno);
@@ -731,7 +721,7 @@ NXTARG:		;
 
 sep_err:
 	printf("## Error: %s: only one of \"-b\", \"-c\" or \"-t\" allowed\n",
-	       cmd);
+	       argv[0]);
 	return 1;
 }
 #endif
@@ -765,7 +755,7 @@ static int do_env_import(struct cmd_tbl *cmdtp, int flag,
 			 int argc, char *const argv[])
 {
 	ulong	addr;
-	char	*cmd, *ptr;
+	char	*ptr;
 	char	sep = '\n';
 	int	chk = 0;
 	int	fmt = 0;
@@ -773,42 +763,40 @@ static int do_env_import(struct cmd_tbl *cmdtp, int flag,
 	int	crlf_is_lf = 0;
 	int	wl = 0;
 	size_t	size;
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
+	struct getopt_state gs;
+	int opt;
+
+	getopt_init_state(&gs);
+	while ((opt = getopt(&gs, argc, argv, "bctrd")) > 0) {
+		switch (opt) {
+		case 'b':		/* raw binary format */
+			if (fmt++)
+				goto sep_err;
+			sep = '\0';
+			break;
+		case 'c':		/* external checksum format */
+			if (fmt++)
+				goto sep_err;
+			sep = '\0';
+			chk = 1;
+			break;
+		case 't':		/* text format */
+			if (fmt++)
+				goto sep_err;
+			sep = '\n';
+			break;
+		case 'r':		/* handle CRLF like LF */
+			crlf_is_lf = 1;
+			break;
+		case 'd':
+			del = 1;
+			break;
+		default:
+			return CMD_RET_USAGE;
 		}
 	}
 
-	if (argc < 1)
+	if (argc == gs.index)
 		return CMD_RET_USAGE;
 
 	if (!fmt)
@@ -817,11 +805,13 @@ static int do_env_import(struct cmd_tbl *cmdtp, int flag,
 	if (sep != '\n' && crlf_is_lf )
 		crlf_is_lf = 0;
 
-	addr = hextoul(argv[0], NULL);
+	addr = hextoul(argv[gs.index], NULL);
 	ptr = map_sysmem(addr, 0);
 
-	if (argc >= 2 && strcmp(argv[1], "-")) {
-		size = hextoul(argv[1], NULL);
+	gs.index++;
+
+	if (argc - gs.index >= 1 && strcmp(argv[gs.index], "-")) {
+		size = hextoul(argv[gs.index], NULL);
 	} else if (chk) {
 		puts("## Error: external checksum format must pass size\n");
 		return CMD_RET_FAILURE;
@@ -844,7 +834,7 @@ static int do_env_import(struct cmd_tbl *cmdtp, int flag,
 		printf("## Info: input data size = %zu = 0x%zX\n", size, size);
 	}
 
-	if (argc > 2)
+	if (argc - gs.index > 1)
 		wl = 1;
 
 	if (chk) {
@@ -866,8 +856,10 @@ static int do_env_import(struct cmd_tbl *cmdtp, int flag,
 		ptr = (char *)ep->data;
 	}
 
+	gs.index++;
+
 	if (!himport_r(&env_htab, ptr, size, sep, del ? 0 : H_NOCLEAR,
-		       crlf_is_lf, wl ? argc - 2 : 0, wl ? &argv[2] : NULL)) {
+		       crlf_is_lf, wl ? argc - gs.index : 0, wl ? &argv[gs.index] : NULL)) {
 		pr_err("## Error: Environment import failed: errno = %d\n",
 		       errno);
 		return 1;
@@ -878,7 +870,7 @@ static int do_env_import(struct cmd_tbl *cmdtp, int flag,
 
 sep_err:
 	printf("## %s: only one of \"-b\", \"-c\" or \"-t\" allowed\n",
-		cmd);
+		argv[0]);
 	return 1;
 }
 #endif
@@ -971,6 +963,8 @@ static int do_env_info(struct cmd_tbl *cmdtp, int flag,
 	int eval_flags = 0;
 	int eval_results = 0;
 	bool quiet = false;
+	struct getopt_state gs;
+	int opt;
 #if defined(CONFIG_CMD_SAVEENV) && !IS_ENABLED(CONFIG_ENV_IS_DEFAULT)
 	enum env_location loc;
 #endif
@@ -980,23 +974,20 @@ static int do_env_info(struct cmd_tbl *cmdtp, int flag,
 		return print_env_info();
 
 	/* process options */
-	while (--argc > 0 && **++argv == '-') {
-		char *arg = *argv;
-
-		while (*++arg) {
-			switch (*arg) {
-			case 'd':
-				eval_flags |= ENV_INFO_IS_DEFAULT;
-				break;
-			case 'p':
-				eval_flags |= ENV_INFO_IS_PERSISTED;
-				break;
-			case 'q':
-				quiet = true;
-				break;
-			default:
-				return CMD_RET_USAGE;
-			}
+	getopt_init_state(&gs);
+	while ((opt = getopt(&gs, argc, argv, "dpq")) > 0) {
+		switch (opt) {
+		case 'd':
+			eval_flags |= ENV_INFO_IS_DEFAULT;
+			break;
+		case 'p':
+			eval_flags |= ENV_INFO_IS_PERSISTED;
+			break;
+		case 'q':
+			quiet = true;
+			break;
+		default:
+			return CMD_RET_USAGE;
 		}
 	}
 
diff --git a/env/Kconfig b/env/Kconfig
index d7a7e81144b..1bc83769b04 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -2,6 +2,7 @@ menu "Environment"
 
 config ENV_SUPPORT
 	def_bool y
+	select GETOPT
 
 config ENV_SOURCE_FILE
 	string "Environment file to use"
-- 
2.30.2

