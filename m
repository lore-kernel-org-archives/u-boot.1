Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D5DCD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF4D284874;
	Wed, 20 May 2026 01:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZjOZHzhb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 527D2848D7; Wed, 20 May 2026 01:32:50 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 289138483C
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dbe07d3ec3so2124131a34.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779233566; x=1779838366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bGekHsc5IXmpBJsjtfO8XsIW8H9YxSmMxZj8/9IKxi4=;
 b=ZjOZHzhbXXXDJgngGVTLWoqPdLpssn+sa7rTlU+qI2LhwOpFN42NRu/OZXuXRP2V6/
 D3tkIwihAP89cWOH3Svy6/nSzPJ2jaJoDo+Lk/CNVqyUTRlksczBcMJ2Lo1gFlWQ5DOS
 QQiJPw8hL28en7ZRyTG6Y7bROIfoZA7kucteE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233566; x=1779838366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bGekHsc5IXmpBJsjtfO8XsIW8H9YxSmMxZj8/9IKxi4=;
 b=kuESEHFGKJx/XVPrPC3afrRDUFBhTDVIKtwcr+mYkdcsJPEeY+o1N6l6R4wJeXQ2lD
 /SOatlyijRqw4+yu8bfkmdSYFmOTzPtNR27dlrUZbf2bHiUoGcarbj7nj+oH9FoKDoRI
 yID2uP0kffb9ojnEiS4ezUeG6q/4nuYWGhHIa2ByFisb7yWWqOzHGcJ9L0E9o21BMZBt
 ITd/lxMJhpM2q3sHm5xydQdCNg8jQr0AdpMU3V6zEB+KvIUCiRcIABdokjDIAwssx+7b
 CtyYfKmA3N654lA9SgGVn9IuIuxysRpSRbGR5mHy93GXXXb+lGumX55XGXbmO4rJp3Xe
 0LJw==
X-Gm-Message-State: AOJu0YzoLePObQpB5vt+a/wMCYH2KckIXqGZGMiYgAJIQytp7528Pzu9
 R7HrcYlstDHws1ZBO8EoDhxaB+8r9uuIsZl7rqQMGLibWxekTjkr/GWNVCScJ//mkDQYl7DEe1v
 G3d6TiuhC
X-Gm-Gg: Acq92OEOg+lxUD4vworC5k4rfvtZiWGDeE20rtIVmj+TuPqTsfuEjxzDippu/5xCxnN
 ewBkXZpCR9hFLFCAAkVhkjhc6a98vu2K304iaquJOoSLRZipSu9H7w2BNkn39NXK8mTvW+FyunD
 SakbzcmK57s2eQYMpxTDI2GKn1WY+fcN/cm+NeB2f5bwiSzYbntOSZZZ83EGTwQdS0eG68ytGxp
 4s3+oZdPfnvnlEwF0wQWPsG5qPR79NhXPaE6BX9BZhY1WGDwxmQYJe0r76qU4b9tDmWDm1YzJSH
 haFqUbvBijvmaAVcfJW/TmXiYcGd4NKGNqxg5kYAL0VpD2mmcaRwatAU/PPIWrvXpv8ZaJvqF8W
 KSE1+zpfqoE6Xm/hQW9Zjd+Ct8KTsJnYcO4+8k7WEW3bjCjyDxkiPKoNZ+xfvnwsWk938E33nmG
 WDQN4EZhP9TaGYF5gyAX3SSY24vJba
X-Received: by 2002:a05:6820:1893:b0:696:8098:b0e5 with SMTP id
 006d021491bc7-69c9bfea57dmr12917870eaf.55.1779233566637; 
 Tue, 19 May 2026 16:32:46 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d04911744sm7983725eaf.12.2026.05.19.16.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 16:32:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>
Subject: [RFC PATCH v2 07/17] cmd: echo: Use getopt() with '+' prefix for
 option parsing
Date: Tue, 19 May 2026 17:31:33 -0600
Message-ID: <20260519233207.2765755-8-sjg@chromium.org>
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

The 'echo' command's option parser is a single strcmp against argv[1]
that decides whether to suppress the trailing newline. Convert it to
getopt() so echo follows the same shape as the other commands in this
series and exercises the '+' prefix that POSIX-style 'stop at first
non-option' callers need.

The optstring uses the '+' prefix to preserve bash echo behaviour: -n is
honoured only as the very first argument, so 'echo hello -n' still
prints 'hello -n\n' verbatim.

Two minor differences from the bash builtin remain, both of which
the user can work around with quoting or --:

* -x (an unknown short option) returns CMD_RET_USAGE rather than
  printing literally; use 'echo -- -x' to print it.
* -nfoo (joined form) parses -n and then errors on the trailing
  characters.

Add three test cases that pin down the new behaviour: trailing -n stays
literal, -- ends option parsing, and -- is consumed even after a
recognised flag. The positional loop uses getopt_pop() as an iterator.
CMD_ECHO selects GETOPT so the parser is linked in on boards that don't
already enable it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/Kconfig          |  1 +
 cmd/echo.c           | 23 ++++++++++++++---------
 test/cmd/test_echo.c | 10 ++++++++++
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c71c6824a19..709696c3c41 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1916,6 +1916,7 @@ config CMD_CAT
 config CMD_ECHO
 	bool "echo"
 	default y
+	select GETOPT
 	help
 	  Echo args to console
 
diff --git a/cmd/echo.c b/cmd/echo.c
index d1346504cfb..63422c75cc6 100644
--- a/cmd/echo.c
+++ b/cmd/echo.c
@@ -5,27 +5,32 @@
  */
 
 #include <command.h>
-#include <linux/string.h>
+#include <getopt.h>
 
 static int do_echo(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[])
 {
-	int i = 1;
+	struct getopt_state gs;
 	bool space = false;
 	bool newline = true;
+	char *arg;
+	int opt;
 
-	if (argc > 1) {
-		if (!strcmp(argv[1], "-n")) {
+	getopt_init_state(&gs, argc, argv);
+	while ((opt = getopt(&gs, "+n")) > 0) {
+		switch (opt) {
+		case 'n':
 			newline = false;
-			++i;
+			break;
+		default:
+			return CMD_RET_USAGE;
 		}
 	}
 
-	for (; i < argc; ++i) {
-		if (space) {
+	while ((arg = getopt_pop(&gs))) {
+		if (space)
 			putc(' ');
-		}
-		puts(argv[i]);
+		puts(arg);
 		space = true;
 	}
 
diff --git a/test/cmd/test_echo.c b/test/cmd/test_echo.c
index 7ed534742f7..5fc139fbe68 100644
--- a/test/cmd/test_echo.c
+++ b/test/cmd/test_echo.c
@@ -35,6 +35,16 @@ static struct test_data echo_data[] = {
 	/* Test handling of shell variables. */
 	{"setenv jQx; for jQx in 1 2 3; do echo -n \"${jQx}, \"; done; echo;",
 	 "1, 2, 3, "},
+	/* -n only suppresses the newline when it comes before any
+	 * positional argument; a trailing -n is just another argument.
+	 */
+	{"echo hello -n", "hello -n"},
+	/* "--" ends option parsing, so a following dash-prefixed token
+	 * is printed verbatim instead of being rejected.
+	 */
+	{"echo -- -x", "-x"},
+	/* "--" is consumed even when it follows a recognised flag. */
+	{"echo -n -- foo; echo done", "foodone"},
 };
 
 static int lib_test_hush_echo(struct unit_test_state *uts)
-- 
2.43.0

