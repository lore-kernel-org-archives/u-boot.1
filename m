Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74ADCE7C4E2
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:46:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C4D9875CC;
	Wed,  4 Oct 2023 18:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="B6FjaKcu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1186E875D0; Wed,  4 Oct 2023 18:43:44 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDF49875C7
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-532c81b9adbso4196777a12.1
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437800; x=1697042600;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnowZuUrE17g+tKuxT2zBkYxjYxVi7CpX1ywM+CZUCk=;
 b=B6FjaKcukqvyYpQ0CzjnLFxgpZR5CljH2rRxsXGTmqXeOm2/HqsL5jgr65vUCvOtbc
 dgDY8NqqJPOSQmx/LotSpcUSlylGgeCfsRSoLBGdSo3wtZFYyOJA8/ftp0LRgiOmT6SL
 uprjBcePXP4LaZUFybY3CcQ3njo38AjiEClWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437800; x=1697042600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jnowZuUrE17g+tKuxT2zBkYxjYxVi7CpX1ywM+CZUCk=;
 b=cfEFqnUyvc+I5atDLjsAbTu3FH3BSqrumRkhPL7OdMCunjN9WFpMlK9nu+Fl5zU8P8
 1oBrzZqp1VSzFfzOy17qQGY9VkWUq9LwAlKbFcCm+Y1Ui5041FjEX+gE3pZc45ClF6I/
 INFm/ubsnXCEMVp7XqpkxBw89xMW6Zs/sFYzoEgq0pfazWFGY3qE0XFpPII456KEieDM
 4Z0HZeRYhRNUPDCF1k0oVOgwnPI1rBAG9AKXLmw6nat4IcewVuPx7oKTYlpXBen43rjB
 0Lla0fM7LSRt2GCAMl4eaz8uCU/hr/s8QLbPdf0evNb09ehX/PVxPmyLIyCFlf/OpJZQ
 xp6Q==
X-Gm-Message-State: AOJu0YzDtVNPaeIfCyWbl9HFgIoUvsytsawCmZ2Dzn9cTwDpj1krYMJo
 s/AUcLjvMatj7sf7k31Uf8SQdpkWY+Uk0pQq5+E=
X-Google-Smtp-Source: AGHT+IHZGB9RL57vZG7aoFYxphJHAUq+R98kbBF1eYXynvBjOtu9DtqdK7TK5FEMa+TXE7edvX2Zlg==
X-Received: by 2002:a50:fb87:0:b0:532:e1a2:b0b8 with SMTP id
 e7-20020a50fb87000000b00532e1a2b0b8mr2717470edq.8.1696437799928; 
 Wed, 04 Oct 2023 09:43:19 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:43:19 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hector Palacios <hector.palacios@digi.com>, Marek Vasut <marex@denx.de>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>, Tony Dinh <mibodhi@gmail.com>
Subject: [RFC PATCH v10 15/24] cli: add hush 2021 as parser for run_command*()
Date: Wed,  4 Oct 2023 19:42:11 +0300
Message-Id: <20231004164220.15738-16-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
References: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
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

Enables using, in code, hush 2021 as parser for run_command function family.
It also enables the command run to be used by CLI user of hush 2021.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 common/cli.c               | 63 ++++++++++++++++++++++++++++----------
 common/cli_hush_upstream.c |  2 +-
 2 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/common/cli.c b/common/cli.c
index e3e2bc7fe1..899007da9d 100644
--- a/common/cli.c
+++ b/common/cli.c
@@ -43,14 +43,31 @@ int run_command(const char *cmd, int flag)
 		return 1;
 
 	return 0;
-#elif CONFIG_IS_ENABLED(HUSH_OLD_PARSER)
-	int hush_flags = FLAG_PARSE_SEMICOLON | FLAG_EXIT_FROM_LOOP;
-
-	if (flag & CMD_FLAG_ENV)
-		hush_flags |= FLAG_CONT_ON_NEWLINE;
-	return parse_string_outer(cmd, hush_flags);
-#else /* HUSH_2021_PARSER */
-	/* Not yet implemented. */
+#else
+	if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		int hush_flags = FLAG_PARSE_SEMICOLON | FLAG_EXIT_FROM_LOOP;
+
+		if (flag & CMD_FLAG_ENV)
+			hush_flags |= FLAG_CONT_ON_NEWLINE;
+		return parse_string_outer(cmd, hush_flags);
+	} else if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
+		/*
+		 * Possible values for flags are the following:
+		 * FLAG_EXIT_FROM_LOOP: This flags ensures we exit from loop in
+		 * parse_and_run_stream() after first iteration while normal
+		 * behavior, * i.e. when called from cli_loop(), is to loop
+		 * infinitely.
+		 * FLAG_PARSE_SEMICOLON: Hush 2021 parses ';' and does not stop
+		 * first time it sees one. So, I think we do not need this flag.
+		 * FLAG_REPARSING: For the moment, I do not understand the goal
+		 * of this flag.
+		 * FLAG_CONT_ON_NEWLINE: This flag seems to be used to continue
+		 * parsing even when reading '\n' when coming from
+		 * run_command(). In this case, Hush 2021 reads until it finds
+		 * '\0'. So, I think we do not need this flag.
+		 */
+		return parse_string_outer_2021(cmd, FLAG_EXIT_FROM_LOOP);
+	}
 	return 1;
 #endif
 }
@@ -67,12 +84,25 @@ int run_command_repeatable(const char *cmd, int flag)
 #ifndef CONFIG_HUSH_PARSER
 	return cli_simple_run_command(cmd, flag);
 #else
+	int ret;
+
+	if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		ret = parse_string_outer(cmd,
+					 FLAG_PARSE_SEMICOLON
+					 | FLAG_EXIT_FROM_LOOP);
+	} else if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
+		ret = parse_string_outer_2021(cmd,
+					      FLAG_PARSE_SEMICOLON
+					      | FLAG_EXIT_FROM_LOOP);
+	} else {
+		ret = 1;
+	}
+
 	/*
 	 * parse_string_outer() returns 1 for failure, so clean up
 	 * its result.
 	 */
-	if (parse_string_outer(cmd,
-			       FLAG_PARSE_SEMICOLON | FLAG_EXIT_FROM_LOOP))
+	if (ret)
 		return -1;
 
 	return 0;
@@ -111,12 +141,13 @@ int run_command_list(const char *cmd, int len, int flag)
 		buff[len] = '\0';
 	}
 #ifdef CONFIG_HUSH_PARSER
-#if CONFIG_IS_ENABLED(HUSH_OLD_PARSER)
-	rcode = parse_string_outer(buff, FLAG_PARSE_SEMICOLON);
-#else /* HUSH_2021_PARSER */
-	/* Not yet implemented. */
-	rcode = 1;
-#endif
+	if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		rcode = parse_string_outer(buff, FLAG_PARSE_SEMICOLON);
+	} else if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
+		rcode = parse_string_outer_2021(buff, FLAG_PARSE_SEMICOLON);
+	} else {
+		rcode = 1;
+	}
 #else
 	/*
 	 * This function will overwrite any \n it sees with a \0, which
diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index b11445c3ac..dbf77ad503 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -8023,7 +8023,7 @@ static int parse_and_run_string(const char *s)
 }
 
 #ifdef __U_BOOT__
-int parse_string_outer(const char *cmd, int flags)
+int parse_string_outer_2021(const char *cmd, int flags)
 {
 	int ret;
 	int old_flags;
-- 
2.34.1

