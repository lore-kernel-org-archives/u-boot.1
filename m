Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C287C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8EF084C01;
	Wed,  1 Jul 2026 13:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hp6v5Mqs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B162F84BAA; Wed,  1 Jul 2026 13:47:24 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C769184C02
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-495b250b01cso432116b6e.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782906440; x=1783511240; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCbwED3yz+UPmqpBdVUeIo8zMTFgxFBqDmX3E5/8Hc4=;
 b=Hp6v5Mqs+lJvszAdfKHkID1s9vj1u3dKOTLJGpfPVv0c/o9vBlDhrIBSquo2b9JXWt
 X3/NzXWk5KPfC1yW7Ssy+fMROFa7A4ilAxS5YGLw/AR0GgCjWdkwmPcWt/BtgBeUfYj4
 ha2gBQZxo1xI14jeYHbXduIqg8VPoASPh+Dew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782906440; x=1783511240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SCbwED3yz+UPmqpBdVUeIo8zMTFgxFBqDmX3E5/8Hc4=;
 b=a0aY4mnx6e4WxdzbwWdb5AjyjnFGyk0N6fIcjPzaoYb2xTqffjwPj4NAZUox1nYj2s
 HzUfSYiNV/d2La+fgC0JBgqPPkZU4q3uz00H/wIj4AjMzMPRjEpLcowjJZckklptnRUE
 O0CWL13Zkf8PHX/St+PeJrznNzWgq/s9/2wd2eEYtf5MOGduGvjD3k+gdl7BIye67RdU
 qMHAeoReSCvEISksmav+YW5EUunhkMukiokC+5pSe6o6nGAjyfLh6a4qD1MBkpyOuPoq
 KKw32iFhRz5fguhtnaRVQ3SY/rcSa5bT9MrlghU06O2QVCdTSSnkJOd8RSUoiCpSrJeE
 gC3g==
X-Gm-Message-State: AOJu0Ywmbudp33RrQ763UeWNQ4XRRULpX5xXNlYcdRyc2E+vBUIA46O2
 IdEwtvILjBAqgeFaRBY0K226R6vGBbkSNOoZt2gFxxoTNAUGs4CAwUDVCWwMArCnBOTHZk0MRca
 wMcE=
X-Gm-Gg: AfdE7ckJhmH8ZUfN9szO7h3B/JSb9LNMtP9C4AZdA2MmTxr3DB7kc5cAGIm5nKAk4Ew
 TafUb8B+LG0vc8++nrRPJ5D/11/K7tlAESPr4pkdy+C7ixI9O7rc4Y8+1lQB/i9w79bob8JE8mC
 Rjhvi2m70Pu5uKJ0Xo5mNDZ2HSSFf2Qn3Yo56MLQ/Mkgcf0jA/g7yK10XC3EKeS3GAmZBT/nD/4
 e2z+GhhdnL6/o6u56EchIUGVxINqcEcjy7LPZcT9BvbCz1T60NA0lO3hwK+m3rpRtsZAy/QvvVT
 NscI3aCW/ALDe7FynppHbmOxZ3WVa2Sf/iBfoGyChkiK7P/J30r6cgDF/YiYaF3Arws99aq+w1M
 3Nsn/ub2ekg/dhfSdWdfavy1t80HEhBowZJENyHQciFafyp+r5QO5c/cOFo1rAUgnTteQZrwChX
 HDUuYywxJYWJIgOLStjw==
X-Received: by 2002:a05:6808:190c:b0:495:fd9b:1808 with SMTP id
 5614622812f47-4962d73c506mr145888b6e.8.1782906440502; 
 Wed, 01 Jul 2026 04:47:20 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4960655e3e2sm1199823b6e.0.2026.07.01.04.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 04:47:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Johan Jonker <jbx6244@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 09/14] cmd: hash: Use getopt() for option parsing
Date: Wed,  1 Jul 2026 05:42:29 -0600
Message-ID: <20260701114248.1396125-10-sjg@chromium.org>
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

The open-coded check for -v only matches it as the first argument and
duplicates the argument-shuffling logic that every option-parsing
command repeats. Convert do_hash() to the getopt-state command
signature and parse -v with getopt().

Build the optstring from IS_ENABLED(CONFIG_HASH_VERIFY) so getopt() is
always called, and prefix it with '+' so it works in POSIX mode and
stops at the first non-option. -v therefore stays a leading option
('hash -v algorithm address count'), matching the documented usage and
the existing tests, and no argv permutation is needed. After parsing,
require three positionals (algorithm address count), strlower() the
algorithm and forward the tail to hash_command() unchanged.

CMD_HASH selects only GETOPT. With this, no in-tree command selects
GETOPT_PERMUTE, so the permute machinery (the writable argv copy and
nonopts tracking) stays compiled out of a default image, which drops
about 2 KB of text. GETOPT_PERMUTE remains available as an opt-in for
commands that genuinely need options after positionals.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Make hash parse in POSIX mode so nothing selects GETOPT_PERMUTE

 cmd/Kconfig |  1 +
 cmd/hash.c  | 42 +++++++++++++++++++++++-------------------
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index ca1039f6a03..3c5abddd31f 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2804,6 +2804,7 @@ config CMD_BLOB
 
 config CMD_HASH
 	bool "Support 'hash' command"
+	select GETOPT
 	select HASH
 	help
 	  This provides a way to hash data in memory using various supported
diff --git a/cmd/hash.c b/cmd/hash.c
index f4f1dcf02f9..929759ce45b 100644
--- a/cmd/hash.c
+++ b/cmd/hash.c
@@ -11,8 +11,9 @@
 
 #include <command.h>
 #include <env.h>
+#include <getopt.h>
 #include <hash.h>
-#include <linux/ctype.h>
+#include <linux/string.h>
 
 #if IS_ENABLED(CONFIG_HASH_VERIFY)
 #define HARGS 6
@@ -20,31 +21,34 @@
 #define HARGS 5
 #endif
 
-static int do_hash(struct cmd_tbl *cmdtp, int flag, int argc,
-		   char *const argv[])
+static int do_hash(struct getopt_state *gs)
 {
-	char *s;
+	const char *optstring = IS_ENABLED(CONFIG_HASH_VERIFY) ? "+v" : "+";
 	int flags = HASH_FLAG_ENV;
+	char *algo;
+	int opt;
 
-	if (argc < 4)
+	while ((opt = getopt(gs, optstring)) > 0) {
+		switch (opt) {
+		case 'v':
+			flags |= HASH_FLAG_VERIFY;
+			break;
+		default:
+			return CMD_RET_USAGE;
+		}
+	}
+
+	/* Need at least: algorithm address count */
+	if (gs->argc - gs->index < 3)
 		return CMD_RET_USAGE;
 
-#if IS_ENABLED(CONFIG_HASH_VERIFY)
-	if (!strcmp(argv[1], "-v")) {
-		flags |= HASH_FLAG_VERIFY;
-		argc--;
-		argv++;
-	}
-#endif
-	/* Move forward to 'algorithm' parameter */
-	argc--;
-	argv++;
-	for (s = *argv; *s; s++)
-		*s = tolower(*s);
-	return hash_command(*argv, flags, argc - 1, argv + 1);
+	algo = strlower(getopt_pop(gs));
+
+	return hash_command(algo, flags, gs->argc - gs->index,
+			    &gs->argv[gs->index]);
 }
 
-U_BOOT_CMD(
+U_BOOT_CMD_GETOPT(
 	hash,	HARGS,	1,	do_hash,
 	"compute hash message digest",
 	"algorithm address count [[*]hash_dest]\n"
-- 
2.43.0

