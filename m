Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85870CD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A238490A;
	Wed, 20 May 2026 01:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Kd2kObxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F3F984901; Wed, 20 May 2026 01:33:00 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62505848E7
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:32:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-69d2e3b45a1so1504532eaf.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779233577; x=1779838377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HRqT37cK/S6e4m0575ho0RoyMe7Ab+iJNKZyZipvwz8=;
 b=Kd2kObxAQM8ohMfiHtheODTGq4aNO/d5bi381nKAQ6z0MMpClKP2Q1Z8ttGLHCNk12
 dOQvo6MXLsmRkqXvcOAENKX831oJYm1YYtRIOdmIG2QVr64r/SHfq+bGmbhYWw5+n/av
 sEhf6QBo/kbKRI4LZ4nInjHMGjqCYMxfdbgt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233577; x=1779838377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HRqT37cK/S6e4m0575ho0RoyMe7Ab+iJNKZyZipvwz8=;
 b=fFbZ56Hp37MeSu2d8gz4fHnc+FLCZkjy2rPsvkxfXGK2izm5Qj7/PBhW4NrcI+UDMk
 Kyg/Ap72sW2Sp4977+bGyYpgdMlZ2G3c0hoolrLoTFHaAGB1dAFW3xVE0N04PNIggyya
 YZRRlcWJp1bPtXUi+vbXf+ChcZ3ubsuQ7N6n2Nz/EGcjsGWipOZPAutWUxHOMhJtEn17
 hEVPXdRB3GhfJiEyJbjh93gIHzyBSApXPnduqYmo9Y7qtfDwMDVenzXHA++HEta8AFeb
 6vrtABMYFC6HJuK2oF+/8DtvtOMQ7sWsZiFi1ixURLcOOaG3dysrnQ28TFA7NXhUmIXu
 3iRg==
X-Gm-Message-State: AOJu0Yz+6CWfr30hz7f2KIU/w2nwc/JMc5Pk4SJnt1YvmcMfUpKnJmAP
 pn3eghd20ruCe3ckRc37rRpg2wOMpJE3p6DSJD7b4c2QDtwBUhcZduJhQyPpuwYVzmDJ6qbnIOU
 QjLJIbgXH
X-Gm-Gg: Acq92OFvYbtVqSKCjRxxMrajSGL4UdpOTizUxMjvo+BLbgzluYCWszJco70h3B4ofjg
 rkhefi8jfZEMlgKVSlxVsKgklmrp2oDah5C0BWZahk0D8cLEvTdSUw4hEvNTV3eMgBon7mn1rZL
 et0kc1u7i7p3DOzxAfCw1qWddXLGjaJ9E7iEUBAC2nsVniLzueQ6K9T7Ok044u3G2xE2uOpaeyE
 3tcMQ6qOgeyaPBilTyBF64QAssPxH6Zp//jVoM9w3SGPHYD1sI+THOTYWf3El9rhYTxrEA64jOO
 iZt7/tlMA6hXXv5cR72dkh0HYqx7/g6zA/aXIKzmWnvhTfOyzXPwVI3aZN+Ar06nZMret7Lbtsb
 KaV68xTMjr6+S8w5imIss0mTZZn0DITIq4e0493mNr0KJ+zHjNUeDKvCMI2Bx8GMzkBfD6HElK7
 U7PpNpgKjNm7/bjlVSUg==
X-Received: by 2002:a05:6820:c2cb:20b0:69d:5033:b84b with SMTP id
 006d021491bc7-69d5033bc78mr1774391eaf.58.1779233577064; 
 Tue, 19 May 2026 16:32:57 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d04911744sm7983725eaf.12.2026.05.19.16.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 16:32:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [RFC PATCH v2 11/17] cmd: nvedit: Use getopt() in env import
Date: Tue, 19 May 2026 17:31:37 -0600
Message-ID: <20260519233207.2765755-12-sjg@chromium.org>
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

This is the other gnarly hand-rolled parser in nvedit.c

The code walks each -prefixed argv element by hand, opens an inner
while (*++arg) to split grouped flags, and tracks a fmt counter to
catch a second -b / -c / -t

getopt() collapses all of that. The mutex check for the format flags
stays in the case arms (it is a per-command rule, not an option-parsing
rule) and the trailing positional list is read straight out of
gs.args + gs.index with gs.nonopts as the count.

Permutation now lets options follow positional arguments, so an
out-of-order 'import 0x... -t -d' is accepted alongside the
conventional 'import -t -d 0x...'.

Tests cover a setenv/export/clear/import roundtrip with -d, and an
out-of-order 'import 0x... -t -d' invocation.

Adjust CMD_IMPORTENV to select GETOPT so the parser is linked in on
boards that did not already enable it.

Also redo the sep_err logic and error message, along with a fmt tweak
to reduce code size.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/nvedit.c | 95 ++++++++++++++++++++++++----------------------------
 env/common.c |  2 +-
 2 files changed, 45 insertions(+), 52 deletions(-)

diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index f2cad21b5f4..5fca52b58a7 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -750,64 +750,63 @@ static int do_env_export(struct cmd_tbl *cmdtp, int flag,
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
+	if (gs.nonopts < 1)
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
@@ -823,22 +822,19 @@ static int do_env_import(struct cmd_tbl *cmdtp, int flag,
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
 
@@ -853,19 +849,16 @@ static int do_env_import(struct cmd_tbl *cmdtp, int flag,
 	}
 
 	if (!himport_r(&env_htab, ptr, size, sep, del ? 0 : H_NOCLEAR,
-		       crlf_is_lf, wl ? argc - 2 : 0, wl ? &argv[2] : NULL)) {
-		pr_err("## Error: Environment import failed: errno = %d\n",
+		       crlf_is_lf,
+		       gs.nonopts ?: 0,
+		       gs.nonopts ? &gs.argv[gs.index] : NULL)) {
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

