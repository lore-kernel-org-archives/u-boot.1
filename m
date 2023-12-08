Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E117C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 22:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99256876FC;
	Fri,  8 Dec 2023 23:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VVDVS3sS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D888C876F9; Fri,  8 Dec 2023 23:31:34 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFB40876A7
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 23:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40c1e3ea2f2so26001695e9.2
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 14:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702074677; x=1702679477;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GcgWnrKNZXtZm+uBJoJwaI9hTnQh1RjJo9gecM8vdQU=;
 b=VVDVS3sS8yp01Bzx/9QeEYWBQ6Jq13tCHoLgkgUa/gUAxdBtuqxvTq2qzmAF4252m4
 7OakbgWyy3nF4tDkeWY5Jlqmy2obup/LncXbP2S7mMlJQP+5JsTZeUqPY84x2JrFcSHb
 TsujscsIw5JFlVXRxQzg/cIlH/bVDz0Ex6r4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702074677; x=1702679477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GcgWnrKNZXtZm+uBJoJwaI9hTnQh1RjJo9gecM8vdQU=;
 b=vA9hckn5w6RLxV2H6lDYV3gNA4228b6ld3BTjE+BrG9F1kpvj1k/PWM6FYK0ygj6EZ
 TXu7TtfN0Dim+PL7RA2ys195QLn+2VRm+9Dsyscv/DFXAeHrLyNpiKWFC9fBbEkndsXl
 aHggQOpYT8BgCsoYd0bTHU5wgB2ZiZ4GI14fUSzU/dvKu+GixEeMr9cQRFLq0xkRRawd
 J40MikYwbiPOGZ2HX0+JF1ZCAXCA9VCtbtAzioBvM4+TUquVbWmFU3dzo5zO+OopjbBw
 kIdLzPpVB5ssvh01ZCgZ+CrXEU8tVwt9NV5OlawUfJ74TPfQMsMpCQhaw+puPka/eIpE
 meoA==
X-Gm-Message-State: AOJu0YyGXNLHqd8R53GjXCzZF95EtA/A6xR/TtL9ML5ev3en+cYxVAEc
 FFfaCfSrj6HONDWltKieOWaXeDCv7FKOm2R3FiQskQ==
X-Google-Smtp-Source: AGHT+IHTFrNMEtSbtwYSf6mkZH++eMsoNnnORJgaOlESnr7NU2w7XfP9qzghkWnHUsK3gqVnCK97/w==
X-Received: by 2002:a1c:7213:0:b0:40b:4b29:aa1c with SMTP id
 n19-20020a1c7213000000b0040b4b29aa1cmr403112wmc.30.1702074677442; 
 Fri, 08 Dec 2023 14:31:17 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c350b00b0040b4cb14d40sm6357863wmq.19.2023.12.08.14.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 14:31:17 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Hector Palacios <hector.palacios@digi.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH v12 15/24] cli: add modern hush as parser for run_command*()
Date: Fri,  8 Dec 2023 23:30:16 +0100
Message-Id: <20231208223025.55076-16-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
References: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
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

Enables using, in code, modern hush as parser for run_command function family.
It also enables the command run to be used by CLI user of modern hush.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 common/cli.c               | 67 ++++++++++++++++++++++++++++----------
 common/cli_hush_upstream.c |  2 +-
 2 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/common/cli.c b/common/cli.c
index b3eb512b62..a34938294e 100644
--- a/common/cli.c
+++ b/common/cli.c
@@ -25,6 +25,14 @@
 #include <linux/errno.h>
 
 #ifdef CONFIG_CMDLINE
+
+static inline bool use_hush_old(void)
+{
+	return IS_ENABLED(CONFIG_HUSH_SELECTABLE) ?
+	gd->flags & GD_FLG_HUSH_OLD_PARSER :
+	IS_ENABLED(CONFIG_HUSH_OLD_PARSER);
+}
+
 /*
  * Run a command using the selected parser.
  *
@@ -43,15 +51,30 @@ int run_command(const char *cmd, int flag)
 		return 1;
 
 	return 0;
-#elif CONFIG_IS_ENABLED(HUSH_OLD_PARSER)
-	int hush_flags = FLAG_PARSE_SEMICOLON | FLAG_EXIT_FROM_LOOP;
-
-	if (flag & CMD_FLAG_ENV)
-		hush_flags |= FLAG_CONT_ON_NEWLINE;
-	return parse_string_outer(cmd, hush_flags);
-#else /* HUSH_MODERN_PARSER */
-	/* Not yet implemented. */
-	return 1;
+#else
+	if (use_hush_old()) {
+		int hush_flags = FLAG_PARSE_SEMICOLON | FLAG_EXIT_FROM_LOOP;
+
+		if (flag & CMD_FLAG_ENV)
+			hush_flags |= FLAG_CONT_ON_NEWLINE;
+		return parse_string_outer(cmd, hush_flags);
+	}
+	/*
+	 * Possible values for flags are the following:
+	 * FLAG_EXIT_FROM_LOOP: This flags ensures we exit from loop in
+	 * parse_and_run_stream() after first iteration while normal
+	 * behavior, * i.e. when called from cli_loop(), is to loop
+	 * infinitely.
+	 * FLAG_PARSE_SEMICOLON: modern Hush parses ';' and does not stop
+	 * first time it sees one. So, I think we do not need this flag.
+	 * FLAG_REPARSING: For the moment, I do not understand the goal
+	 * of this flag.
+	 * FLAG_CONT_ON_NEWLINE: This flag seems to be used to continue
+	 * parsing even when reading '\n' when coming from
+	 * run_command(). In this case, modern Hush reads until it finds
+	 * '\0'. So, I think we do not need this flag.
+	 */
+	return parse_string_outer_modern(cmd, FLAG_EXIT_FROM_LOOP);
 #endif
 }
 
@@ -67,12 +90,23 @@ int run_command_repeatable(const char *cmd, int flag)
 #ifndef CONFIG_HUSH_PARSER
 	return cli_simple_run_command(cmd, flag);
 #else
+	int ret;
+
+	if (use_hush_old()) {
+		ret = parse_string_outer(cmd,
+					 FLAG_PARSE_SEMICOLON
+					 | FLAG_EXIT_FROM_LOOP);
+	} else {
+		ret = parse_string_outer_modern(cmd,
+					      FLAG_PARSE_SEMICOLON
+					      | FLAG_EXIT_FROM_LOOP);
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
@@ -111,12 +145,11 @@ int run_command_list(const char *cmd, int len, int flag)
 		buff[len] = '\0';
 	}
 #ifdef CONFIG_HUSH_PARSER
-#if CONFIG_IS_ENABLED(HUSH_OLD_PARSER)
-	rcode = parse_string_outer(buff, FLAG_PARSE_SEMICOLON);
-#else /* HUSH_MODERN_PARSER */
-	/* Not yet implemented. */
-	rcode = 1;
-#endif
+	if (use_hush_old()) {
+		rcode = parse_string_outer(buff, FLAG_PARSE_SEMICOLON);
+	} else {
+		rcode = parse_string_outer_modern(buff, FLAG_PARSE_SEMICOLON);
+	}
 #else
 	/*
 	 * This function will overwrite any \n it sees with a \0, which
diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index 7f6b058e6c..11870c51e8 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -8022,7 +8022,7 @@ static int parse_and_run_string(const char *s)
 }
 
 #ifdef __U_BOOT__
-int parse_string_outer(const char *cmd, int flags)
+int parse_string_outer_modern(const char *cmd, int flags)
 {
 	int ret;
 	int old_flags;
-- 
2.34.1

