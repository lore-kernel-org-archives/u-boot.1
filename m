Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438C2CD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 20:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFA668484C;
	Fri, 15 May 2026 22:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PWkRF+XD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CBC58483C; Fri, 15 May 2026 22:33:48 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA15E84867
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 22:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dca5f64e86so289876a34.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 13:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778877224; x=1779482024; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWXzil8Za8eMTvx5P4Ig+qtNR2rYUWylqACp9O7BElY=;
 b=PWkRF+XDpJJ+Ixupoh6srZ0tqqyeMkOBr9WjfwW7T6bsDNVEQBRlzY2XzbZf9/bIFX
 trvz3tDLYhkl2Etr+L3JJR4gI+XspJk83fjgmocF/rAJKr4U7/8q4YuWaYO5zDsI6218
 H5b7dUBzmS6ZrEb+F1ehjrj2MfPThhoiLrnes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778877224; x=1779482024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HWXzil8Za8eMTvx5P4Ig+qtNR2rYUWylqACp9O7BElY=;
 b=njgiXm3SQ97b0DcislSxSML1E8RANajkWONdeir0ydHuXeH/JMTzZ8qYlEw5m6hwfa
 xHOuAAYGScHdqGjfRaN/tUWJQRMBC9Sj2w+6Lq26UmlGbtmhlL/PVSpFSFGGUiMmHDAt
 zinf5Xxr3qkGtg8eg8qKj/2Jbq1SiGHsNpIFeAO88uJIbFkq6n97rPIq7zjufOYxFhJm
 +H9DTIL8PQ8b+Ph0MJCbIbhuuKReEbquXLLgoNAde1oFNaN3gNjwz+hhVaDgiOeJVfUd
 s88KTmYMU3WvKvT8mbZxBHYLiHEMETE2rtY6DqdpU5o2OLPYbMaDXgYF1KBPj/m1Vs+R
 IP/w==
X-Gm-Message-State: AOJu0YzEpOYYkit94wfuScN7P8al4XHzkWSCErD8tJa7Z5IyGQaZ1Knp
 0S0oKYqOh0DOMZ/tnrMP71w1lQOOpyHSXqZnU245hEv7v64idKlTBjWjiHk2AM6ONEZhciyz2Go
 p4G8pTQ==
X-Gm-Gg: Acq92OEOt+tNXp617P9Y4m0UQwof/T1bOlcB3Z5fQ0TIuK+3B4V+H/JWqRimTlq6aKo
 KpKCPcAwQjfyTnSFgWDW/IttelCRthYQkf51drVvsoAWcrECRVz24oQRHMnVm6SivgXe54YgHHU
 6x0ajHhx9+hIdXJ0KHR8CHBsWjIXC0WBXVPGDwyKl1FX5n8VACVwfN293jqJazb1yFNouuLKKBJ
 c6DpuiSmO70haUhlqLLBaO6le3ZER6KxTN8ULc2bkD6oWNgyjvPMr9p/AKhKtGQuK3MmiRL+K91
 2HJQSdXasw+5NTun14ANu2cvhhyRBlNr5+NNE1OqpCcVAZD9tZkz/HyHc5Bd6mVPHQM8eUuWQAU
 0eT3tEKnPrlrCbOzO2IkIuadqR6/aJgTplLalA4C75xWSWbpDxyH1AB3dyGm0tw5LHqq/UNLMVc
 dE09YD2ddWjAfgv+k5QA==
X-Received: by 2002:a05:6830:4887:b0:7db:a184:2b35 with SMTP id
 46e09a7af769-7e4ea083bdamr3690761a34.8.1778877224584; 
 Fri, 15 May 2026 13:33:44 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b95b82fsm2414906a34.12.2026.05.15.13.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 13:33:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
Subject: [RFC PATCH 07/11] cmd: echo: Use getopt() with '+' prefix for option
 parsing
Date: Fri, 15 May 2026 14:32:58 -0600
Message-ID: <20260515203311.2555651-8-sjg@chromium.org>
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

