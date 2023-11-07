Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E827C4167B
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70E00876B5;
	Tue,  7 Nov 2023 22:42:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AStXPJ8V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7812987685; Tue,  7 Nov 2023 22:42:29 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37D6C87689
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so45911195e9.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393335; x=1699998135;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Wjs3NVtMPOahE1jkViEJs+pwH3OZv9jt2LfFSIAPtE=;
 b=AStXPJ8VFNiu80aEKvxuQUmB5HaN/SgZK+45VnPk7HnjOsr6NkLNVWdwDFaYInomqe
 H7ywlvQchp6D47KRpHutQxKpHH/i1Ng1ue2XW8wwPOTmw9Nrswi6OFYOwF36F3jPSmiQ
 TVfmteJ2z105wQGlwRZttb3hpR7i8hjX6PXnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393335; x=1699998135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Wjs3NVtMPOahE1jkViEJs+pwH3OZv9jt2LfFSIAPtE=;
 b=gw4HBJGYkY33IdrruhTD9ixAC0rBs9eRZRa89nkUcP02RNgSY3Vxfsf8IPn5eQSua+
 HSb8X/15yS0Wi3PFCObvOeHOfaI2sOjQiFBVihlPt+xNNSReLI7zbDKZUPQVqNf4vqRS
 4mhQ4khcDBW9K8a6vEdVTDBPAlcu4+puTk33EKtsPM/OeGxQMnhcs++BQHf7ZMXunaD6
 kUiLIX/Nf2B3om83Eicfesfd1fpxDMvU8kxt+oOHoXB+H07h1i4p6oii6buOTSQlQS2K
 G3bIK7jIUKqajFPsNmQNWxt7H+p8X8vMHBidUseLdIRK+04ADyZ+/7CGAOPWRLaw2udZ
 LslQ==
X-Gm-Message-State: AOJu0Yzfqkkegci+aVYK6o8E0yu+ApfCd5qnU/+GSYjQSMDK+uDWG+mX
 V9jxxi4D+Cx6mJ3l0vb7koevSETLCj5VMKN9s9g=
X-Google-Smtp-Source: AGHT+IGqtdgHpemdpCvayeOdkk7ziodDYJdCztRRTc/L9pLBS/hR23wt4GgWSUChy/pR/CMjJmhQBw==
X-Received: by 2002:a05:600c:1c17:b0:401:bdf9:c336 with SMTP id
 j23-20020a05600c1c1700b00401bdf9c336mr204410wms.27.1699393335765; 
 Tue, 07 Nov 2023 13:42:15 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:42:15 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hector Palacios <hector.palacios@digi.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>, Marek Vasut <marex@denx.de>
Subject: [PATCH v11 15/24] cli: add hush 2021 as parser for run_command*()
Date: Tue,  7 Nov 2023 23:41:12 +0200
Message-Id: <20231107214121.132079-16-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
References: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
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
 common/cli.c               | 67 ++++++++++++++++++++++++++++----------
 common/cli_hush_upstream.c |  2 +-
 2 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/common/cli.c b/common/cli.c
index e3e2bc7fe1..e332bdd670 100644
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
-#else /* HUSH_2021_PARSER */
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
+	 * FLAG_PARSE_SEMICOLON: Hush 2021 parses ';' and does not stop
+	 * first time it sees one. So, I think we do not need this flag.
+	 * FLAG_REPARSING: For the moment, I do not understand the goal
+	 * of this flag.
+	 * FLAG_CONT_ON_NEWLINE: This flag seems to be used to continue
+	 * parsing even when reading '\n' when coming from
+	 * run_command(). In this case, Hush 2021 reads until it finds
+	 * '\0'. So, I think we do not need this flag.
+	 */
+	return parse_string_outer_2021(cmd, FLAG_EXIT_FROM_LOOP);
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
+		ret = parse_string_outer_2021(cmd,
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
-#else /* HUSH_2021_PARSER */
-	/* Not yet implemented. */
-	rcode = 1;
-#endif
+	if (use_hush_old()) {
+		rcode = parse_string_outer(buff, FLAG_PARSE_SEMICOLON);
+	} else {
+		rcode = parse_string_outer_2021(buff, FLAG_PARSE_SEMICOLON);
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

