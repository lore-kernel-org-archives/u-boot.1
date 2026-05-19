Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49895CD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1669C848E6;
	Wed, 20 May 2026 01:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UIK9GNKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA255848B9; Wed, 20 May 2026 01:32:53 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4E418488F
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-685017d0fbcso2254912eaf.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779233570; x=1779838370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ML2VBf+kQ6Llm9B4+xcICICAcJ+qLCVsXPaGUL2CL0=;
 b=UIK9GNKcmBKiOggYAK0QioWOAQDbYPLcPotg4sV2mgBEeVIODmVSsPOWLcpzzi7r33
 QiQmwRcBbCCjJotXvBj0OkBuMRLc9wYA2hlINUlYQv6uhEoSENsUQoixY61oF+mnCpTm
 icT6IF48ssQ5fJvoemwYgosBKbX7IPS0I8gj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233570; x=1779838370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9ML2VBf+kQ6Llm9B4+xcICICAcJ+qLCVsXPaGUL2CL0=;
 b=Ofxii++bHp0sgdFApxVl2ckC7vdv3PZgWnb2XueUPvz1ngFKgMRIMF9nIoAN8VC4/p
 NwudmQYP79P3jMJoxgLY14PphqnT4KKlmIdlm3ycUwVytdxOWd8AUbx9FW6Y7gr1cGtC
 YDAXKzvZxzjc2aWAQZgoFkW12SI1YFN9C/bK1fsN0sOAFC82saik6n+qfWgYFZKFki+t
 tZYfCsSUcUnno6/EqSYadaAr0D6A/D0IpO9YNIHt9lCQ+FIsWmKogu60gGSNI/09aLtM
 E0nRv7NtIogML6o7H+pK3Rfj9s915oHeVW/svH84u5Ma9ZAsdqI+RdZvfDi7kcKXtjfN
 D5Pw==
X-Gm-Message-State: AOJu0YyoaUctxLnO67uMArqeqr5uFZ/I9mYEvw/4J0eqyltRh5VnlXMn
 TEnPGiUjm7yfc+rmy/6IyHaN/rLB9Ssw2VRrDF4FxkhPI2izHg9vEljVdrSKIIKPZds3mClY/kF
 JvCewjPG2
X-Gm-Gg: Acq92OHmlcQu9EJqKl/jF9l9ipFj2F8j82nC2JSJh2yPSSFqiAggYN50sJCcwd0Qdvv
 a9pSmRoaxjmtAltPWhPd0wRzM/CBPgqzwP18BvY+aNPlEdgByTyihyCCV0GcV9eG9ffcCXfDStU
 +ZK4iZgdH8NT620nrJm6vEf3//hSDTG8jFkTwMqkHwtEhoquKTymidbHP0TIh2wqXGHpp7laG2a
 EmPgxVjGdgQnbMOPPVd1X7r/z/0wEXUdJ3AKB6gxeMl5imE/0+Zbql+qRvwkgz2VHQy5XOxq8/g
 RUXyVzZG1nQOT0LM4BvTACn2ikLaOCHv2QQH4T57ALwV6cwRhXrbbAjddx5HCEI5PVJ3YMQYfhZ
 ckHIeZ7cv/t4AlEchPWtnzZVn8RlrThWh6goi2mCLzD11xiwefRk++JbWAE5quXulMdlZTfiprD
 LW4DgXPnou2EnXpfPVaA==
X-Received: by 2002:a05:6820:200c:b0:67c:1b19:cd8a with SMTP id
 006d021491bc7-69c9c019449mr12812293eaf.60.1779233569797; 
 Tue, 19 May 2026 16:32:49 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d04911744sm7983725eaf.12.2026.05.19.16.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 16:32:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [RFC PATCH v2 08/17] cmd: hash: Use getopt() for option parsing
Date: Tue, 19 May 2026 17:31:34 -0600
Message-ID: <20260519233207.2765755-9-sjg@chromium.org>
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

The open-coded check for -v only matches it as the first argument, so
'hash sha256 -v 0 4 <expected>' treats -v as the algorithm name and
fails. Replace with getopt(), which also lets -v appear anywhere in the
command line.

Guard the option-parsing loop with IS_ENABLED(CONFIG_HASH_VERIFY) so it
is compiled out when verification is disabled. After parsing,
getopt_pop() pulls the algorithm off the positional list, strlower()
normalises it, and the tail is forwarded to hash_command() unchanged.

CMD_HASH selects GETOPT so the parser is linked in on boards that did
not already enable it.

Tweak the var declarations to use Reverse Christmas Tree.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/Kconfig |  1 +
 cmd/hash.c  | 37 +++++++++++++++++++++----------------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 709696c3c41..eb7c85c1fe9 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2798,6 +2798,7 @@ config CMD_BLOB
 
 config CMD_HASH
 	bool "Support 'hash' command"
+	select GETOPT
 	select HASH
 	help
 	  This provides a way to hash data in memory using various supported
diff --git a/cmd/hash.c b/cmd/hash.c
index 96d0e443a5b..321d1d4d22c 100644
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
@@ -23,25 +24,29 @@
 static int do_hash(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[])
 {
-	char *s;
 	int flags = HASH_FLAG_ENV;
+	struct getopt_state gs;
+	char *algo;
 
-	if (argc < 4)
-		return CMD_RET_USAGE;
+	getopt_init_state(&gs, argc, argv);
+	if (IS_ENABLED(CONFIG_HASH_VERIFY)) {
+		int opt;
 
-#if IS_ENABLED(CONFIG_HASH_VERIFY)
-	if (!strcmp(argv[1], "-v")) {
-		flags |= HASH_FLAG_VERIFY;
-		argc--;
-		argv++;
+		while ((opt = getopt(&gs, "v")) > 0) {
+			if (opt != 'v')
+				return CMD_RET_USAGE;
+			flags |= HASH_FLAG_VERIFY;
+		}
 	}
-#endif
-	/* Move forward to 'algorithm' parameter */
-	argc--;
-	argv++;
-	for (s = *argv; *s; s++)
-		*s = tolower(*s);
-	return hash_command(*argv, flags, cmdtp, flag, argc - 1, argv + 1);
+
+	/* Need at least: algorithm address count */
+	if (gs.nonopts < 3)
+		return CMD_RET_USAGE;
+
+	algo = strlower(getopt_pop(&gs));
+
+	return hash_command(algo, flags, cmdtp, flag,
+			    gs.nonopts, &gs.argv[gs.index]);
 }
 
 U_BOOT_CMD(
-- 
2.43.0

