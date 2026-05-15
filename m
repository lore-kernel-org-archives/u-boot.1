Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9F4CD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 20:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82C6B84885;
	Fri, 15 May 2026 22:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sb2V3Hbp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FE1F84884; Fri, 15 May 2026 22:33:55 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E94B84877
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 22:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dbe437b072so128523a34.2
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 13:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778877232; x=1779482032; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tbiEMyCfKdLicwEY87tlk2mB7xF+OvzwYhWo66ZpvKM=;
 b=Sb2V3HbpnKm/9DyeT015wV4Km/EIZJKsFLcxn9LQ1DwTZDXSlMHi7eM9ZZz3MuH6XV
 vj2uZq8+Bl3xxfe+Jfjpc33rIa7fVIcBDuUwHldA1eivgtIuJK3g5XVCIPgzTXyhunHj
 XI+9mEI285ssjoefjQGH6cYKZNSaYVhNX5d7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778877232; x=1779482032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tbiEMyCfKdLicwEY87tlk2mB7xF+OvzwYhWo66ZpvKM=;
 b=EuWTJIuLfZIgk3isUXat2DnGcuqz07CepgnA2czgQDiZDza2yRpQRbfwSGGFeNVu+/
 RDErwdzdkmGVjQbvuoCzP3EtnQ7AyncPPmmsgfOfx0kscABsDgOSQdqmlqUJxACD1TLn
 Lhy/HQwv8zsFGH0xk52SCoCAIosCEDo11VBCxTEB2jd3IjA7uZ/f4b+VE4AAgtUx8iW5
 iPgkhCJsElg2s3Ba71C3Pi6D+7PgwfU7UbyFAdH2GtGYv1qstf6lHoUKcFN1vW3p1CJe
 TrKWWbXfACsqANdz/c7MQBIT9oJBHngM6MpZcnhkf1bCza7Ik5/QqpcuBoyzhh9ARZI0
 DLdg==
X-Gm-Message-State: AOJu0Yx/5eV0VdTQZezrfzHjOdPypXM+/o+xiB7w2Z907H/OqPn8H2Ks
 02poZwDOoAX8MA4p4atzKqmoPS5LDiHc2igfgLUZJyG6jwq5pGmHRllv3tuRHvuoeW9I887MVet
 LvKntsg==
X-Gm-Gg: Acq92OHGkKaE7yh/Z92svmrZFEXxjG3npTexmnalMuT53Ba1m1OaRLNHF81RTKRYGQ7
 5c4WmBaRQiP/a3myy3xdFMAxw9gvoxt+6+0L99ZTpzweEF0YNCSXHw1F06vYNO2IhjGOvuYnnut
 +qLH2o2RwwRes7+hIgXo08z/Zm9s/hNhEppoacCF+iVjv5iLBgzbXodTylt1ipAwpi8OfF4Ox+M
 Ao8+OZ9S9nxnKKot51fY9dbLDnFPq54meMFhONXthodkTxGfmZCtnMmEo9f+nVlFd2jmYS0xwAu
 +KzKiy3RcO1EVGJbnKnJaMH8ECIaxvQ06+wnGPqnl5z3gGDPBaR5Wx4H7K3y7d3Ud2CbtBq89ke
 kx9B1onUDGMxbJr8jBGAs6MFjxEI3EDwPnlTjoK5wQgyImIZbrwSTu+NJRsUdbh2TmvI3CNyu6o
 MbRQu888jxOuENd1hKyg==
X-Received: by 2002:a05:6830:d04:b0:7d9:f50f:968a with SMTP id
 46e09a7af769-7e4ea03b63amr3676583a34.5.1778877231661; 
 Fri, 15 May 2026 13:33:51 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b95b82fsm2414906a34.12.2026.05.15.13.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 13:33:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 10/11] cmd: nvedit: Use getopt() in env export and env
 import
Date: Fri, 15 May 2026 14:33:01 -0600
Message-ID: <20260515203311.2555651-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515203311.2555651-1-sjg@chromium.org>
References: <20260515203311.2555651-1-sjg@chromium.org>
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

These are the gnarliest hand-rolled parsers in nvedit.c

Each one walks each -prefixed argv element by hand, opens an inner
while (*++arg) to split grouped flags, and tracks a fmt counter to catch
a second -b / -c / -t

env export adds a 'goto NXTARG' that jumps over the inner loop after
consuming the argument to -s SIZE, since the rest of the current argv
element no longer makes sense once -s has eaten the next slot.

getopt() collapses all of that. The mutex check for the format flags
stays in the case arms (it is a per-command rule, not an option-parsing
rule), the -s argument arrives in gs.arg, and the trailing positional
list is read straight out of gs.args + gs.index with gs.nonopts as the
count.

Permutation now lets, for example, 'env export 1000000 -t -s 1000' work
the same way as the conventional 'env export -t -s 1000 1000000'.

Tests cover single flags, grouped flags, the mutex-violation path (both
-bt and -t -b forms), -s SIZE in joined and separated form, a
setenv/export/clear/import roundtrip with -d, and an out-of-order
'import 0x... -t -d' invocation.

Adjust CMD_EXPORTENV and CMD_IMPORTENV to select GETOPT so the parser is
linked in on boards that did not already enable it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/Kconfig  |   2 +
 cmd/nvedit.c | 159 ++++++++++++++++++++++++---------------------------
 2 files changed, 78 insertions(+), 83 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 8ba7b1e6bd1..e9bf58b39a6 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -704,12 +704,14 @@ config CMD_ASKENV
 config CMD_EXPORTENV
 	bool "env export"
 	default y
+	select GETOPT
 	help
 	  Export environments.
 
 config CMD_IMPORTENV
 	bool "env import"
 	default y
+	select GETOPT
 	help
 	  Import environments.
 
diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 8561c408992..6af5f52907e 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -632,66 +632,58 @@ static int do_env_delete(struct cmd_tbl *cmdtp, int flag,
 static int do_env_export(struct cmd_tbl *cmdtp, int flag,
 			 int argc, char *const argv[])
 {
+	struct getopt_state gs;
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
+	getopt_init_state(&gs, argc, argv);
+	while ((opt = getopt(&gs, "bcs:t")) > 0) {
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
+	if (gs.nonopts < 1)
 		return CMD_RET_USAGE;
 
-	addr = hextoul(argv[0], NULL);
+	addr = hextoul(getopt_pop(&gs), NULL);
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
+				gs.nonopts, &gs.args[gs.index]);
 		if (len < 0) {
 			pr_err("## Error: Cannot export environment: errno = %d\n",
 			       errno);
@@ -711,8 +703,8 @@ NXTARG:		;
 		res = ptr;
 
 	len = hexport_r(&env_htab, '\0',
-			H_MATCH_KEY | H_MATCH_IDENT,
-			&res, ENV_SIZE, argc, argv);
+			H_MATCH_KEY | H_MATCH_IDENT, &res, ENV_SIZE,
+			gs.nonopts, &gs.args[gs.index]);
 	if (len < 0) {
 		pr_err("## Error: Cannot export environment: errno = %d\n",
 		       errno);
@@ -732,7 +724,7 @@ NXTARG:		;
 
 sep_err:
 	printf("## Error: %s: only one of \"-b\", \"-c\" or \"-t\" allowed\n",
-	       cmd);
+	       argv[0]);
 	return 1;
 }
 #endif
@@ -765,8 +757,9 @@ sep_err:
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
@@ -774,55 +767,53 @@ static int do_env_import(struct cmd_tbl *cmdtp, int flag,
 	int	crlf_is_lf = 0;
 	int	wl = 0;
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
+	getopt_init_state(&gs, argc, argv);
+	while ((opt = getopt(&gs, "bctrd")) > 0) {
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
+	if (gs.nonopts < 1)
 		return CMD_RET_USAGE;
 
 	if (!fmt)
 		printf("## Warning: defaulting to text format\n");
 
-	if (sep != '\n' && crlf_is_lf )
+	if (sep != '\n' && crlf_is_lf)
 		crlf_is_lf = 0;
 
-	addr = hextoul(argv[0], NULL);
+	addr = hextoul(getopt_pop(&gs), NULL);
 	ptr = map_sysmem(addr, 0);
 
-	if (argc >= 2 && strcmp(argv[1], "-")) {
-		size = hextoul(argv[1], NULL);
+	tok = getopt_pop(&gs);		/* size, "-", or absent */
+	if (tok && strcmp(tok, "-")) {
+		size = hextoul(tok, NULL);
 	} else if (chk) {
 		puts("## Error: external checksum format must pass size\n");
 		return CMD_RET_FAILURE;
@@ -832,7 +823,7 @@ static int do_env_import(struct cmd_tbl *cmdtp, int flag,
 		size = 0;
 
 		while (size < MAX_ENV_SIZE) {
-			if ((*s == sep) && (*(s+1) == '\0'))
+			if ((*s == sep) && (*(s + 1) == '\0'))
 				break;
 			++s;
 			++size;
@@ -845,7 +836,7 @@ static int do_env_import(struct cmd_tbl *cmdtp, int flag,
 		printf("## Info: input data size = %zu = 0x%zX\n", size, size);
 	}
 
-	if (argc > 2)
+	if (gs.nonopts > 0)
 		wl = 1;
 
 	if (chk) {
@@ -868,7 +859,9 @@ static int do_env_import(struct cmd_tbl *cmdtp, int flag,
 	}
 
 	if (!himport_r(&env_htab, ptr, size, sep, del ? 0 : H_NOCLEAR,
-		       crlf_is_lf, wl ? argc - 2 : 0, wl ? &argv[2] : NULL)) {
+		       crlf_is_lf,
+		       wl ? gs.nonopts : 0,
+		       wl ? &gs.args[gs.index] : NULL)) {
 		pr_err("## Error: Environment import failed: errno = %d\n",
 		       errno);
 		return 1;
@@ -879,7 +872,7 @@ static int do_env_import(struct cmd_tbl *cmdtp, int flag,
 
 sep_err:
 	printf("## %s: only one of \"-b\", \"-c\" or \"-t\" allowed\n",
-		cmd);
+	       argv[0]);
 	return 1;
 }
 #endif
-- 
2.43.0

