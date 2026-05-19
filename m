Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D97CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90979848FB;
	Wed, 20 May 2026 01:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WnwZqP+Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65CA7848F3; Wed, 20 May 2026 01:32:59 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27E1E8488F
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dcd17e19b6so2329995a34.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779233575; x=1779838375; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZNQaucFkcvV/m1wfIJ1UrBgRiA8MtqS/tdBqY/rn3c=;
 b=WnwZqP+ZlFpNQ96QkwszSWi5RDlDAmDpT2EZ/J8cm5MXt9tkd4z/HBwTDMSvKZp7nc
 c7nkomgGoS5GSSj4pWalpCviCZny/BFkkNhiMP+DyGRHJ2Y5ZEJpnVDhGBVazoeVTrWH
 gtwucEaVKDp3D1sa1DpJ/mdvkhUaPQ0WxMFm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233575; x=1779838375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IZNQaucFkcvV/m1wfIJ1UrBgRiA8MtqS/tdBqY/rn3c=;
 b=HzEG8cpwg7rnyfZs4cU62oC5KKSVPehpI+NaYCaSpZhcHH7CO4R0t9ufHFC6aLh59C
 3RMqfYUUtdttWli8r7CLoVRgQ6Ihc6ulj5/h6S90H1Lm9sSxIWiqvRfyBEHbm9f3t9hT
 +VnryQgHXDeeAjj2siREPur/DRxFAv5/uo1GE7nanGN4ZvkIPdWVcdiPts7WH2CmkXyX
 8OokwhU04LabgQ2q8d8bMe+lnhzFtU3s4wF+XawVCbefsrm/ngirPUYy/1s2TD9kt0jz
 Iqf4myZ1vISUNCh4Q3NVK8/OL7pDZdNe7Wqg29yqJcNq6bzyXb7bQ//Fg3tmeOobega5
 x5cw==
X-Gm-Message-State: AOJu0Yzp6+8bpabuFWXlTzU48gDYXeGfdfS7pJXH2YWkrFdV2MPW7B/c
 9BbLOHbwzFZfB+iAK4L/Qq04310cdbJFWEsD2TvuhXCJfxlJPAogOIe9cBlqKnJrEUYqBBsIEYy
 EjBNxw0dm
X-Gm-Gg: Acq92OE5mtElsURapno0tLouhcAbbg8dOOOl49tRm8q0j/UvhkJtqWlNOc/FxTu0IG+
 75Ggrgge4uw/TeBviOx+ej9VFKoRiKiT/lxZ4mNHm0SQvAoFjZYQ4DOCZdsc2pIMDlbKcw75yOD
 s6KajhkWd5WoOxL31W9XR+bAcwmafAiNztm98gaa+qJHNXTM3URvn0Knbe507aUr5OS8PFir6ug
 pn0LvgWlb8KXFtitiNRaNP5CVt6W2icm6F2cPDogDhfnd+oxuKRtyEqspZXD9z/PcNIRcLEw93M
 nokbHh2feTbVVW+E3DFXEz1QOj1fUPCZAMi5QZq48BnWcnQZBTGzG5hrPe9H5ZV7z9G5QTdBcbX
 iCpRiFhqJkT22TbWncAMExw7uWONSgqFtGKMo5CWTsA00hb4WA8XhPE37OwMabVxt+F80V1ddkp
 MNiHs0bW68Fcoqd57NF1Bt43nDrluF6O35+DCJ4Hg=
X-Received: by 2002:a05:6820:f012:b0:696:6f52:95ea with SMTP id
 006d021491bc7-69c942a4a61mr13092202eaf.7.1779233575293; 
 Tue, 19 May 2026 16:32:55 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d04911744sm7983725eaf.12.2026.05.19.16.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 16:32:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [RFC PATCH v2 10/17] cmd: nvedit: Use getopt() in env export
Date: Tue, 19 May 2026 17:31:36 -0600
Message-ID: <20260519233207.2765755-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519233207.2765755-1-sjg@chromium.org>
References: <20260519233207.2765755-1-sjg@chromium.org>
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
stays in the case arms (it is a per-command rule, not an option-parsing
rule), the -s argument arrives in gs.arg, and the trailing positional
list is read straight out of gs.args + gs.index with gs.nonopts as the
count.

Permutation now lets, for example, 'env export 1000000 -t -s 1000'
work the same way as the conventional 'env export -t -s 1000 1000000'.

Tests cover single flags, grouped flags, the mutex-violation path
(both -bt and -t -b forms) and -s SIZE in joined and separated form.

Adjust CMD_EXPORTENV to select GETOPT so the parser is linked in on
boards that did not already enable it.

Also redo the sep_err logic, use env_set_hex() and shorten error
messages to reduce code size.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Redo the sep_err logic to reduce code size

 cmd/Kconfig  |  1 +
 cmd/nvedit.c | 85 ++++++++++++++++++++++------------------------------
 2 files changed, 36 insertions(+), 50 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 8ba7b1e6bd1..b5cc07b499a 100644
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
index 35cc0ee85bf..f2cad21b5f4 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -632,73 +632,63 @@ static int do_env_delete(struct cmd_tbl *cmdtp, int flag,
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
+	if (gs.nonopts < 1)
 		return CMD_RET_USAGE;
+	if (fmt > 1) {
+		printf("## Error: %s: only one of -b/c/t allowed\n", argv[0]);
+		return 1;
+	}
 
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
+				gs.nonopts, &gs.argv[gs.index]);
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
@@ -711,10 +701,10 @@ NXTARG:		;
 		res = ptr;
 
 	len = hexport_r(&env_htab, '\0',
-			H_MATCH_KEY | H_MATCH_IDENT,
-			&res, ENV_SIZE, argc, argv);
+			H_MATCH_KEY | H_MATCH_IDENT, &res, ENV_SIZE,
+			gs.nonopts, &gs.argv[gs.index]);
 	if (len < 0) {
-		pr_err("## Error: Cannot export environment: errno = %d\n",
+		pr_err("## Error: Cannot export environment (err %dE)\n",
 		       errno);
 		return 1;
 	}
@@ -729,11 +719,6 @@ NXTARG:		;
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

