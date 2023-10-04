Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AA9E7C4E2
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 830F587594;
	Wed,  4 Oct 2023 18:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="if3zrZnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35B24863C9; Wed,  4 Oct 2023 18:43:41 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C87187595
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53447d0241eso4457034a12.3
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437798; x=1697042598;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2gC2uc8mcXuH+rcxRmhrCiahKWth0TENLQZSncOpBI=;
 b=if3zrZnUz4B/7UvHFy2yhfeqAx8MR1AS7vz0EpXMJYKtkavRsfJhLJH1JyeemRx56l
 YX8tiOXxzSndS/iN99Sn457XDGcvzAvt14XpKS76oNnGo/TGedsNNgJaQF8R83VPacwi
 OYSWQ/YHW4rPFfPrew+so/9Ltcij1MIi5fgAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437798; x=1697042598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t2gC2uc8mcXuH+rcxRmhrCiahKWth0TENLQZSncOpBI=;
 b=kS2NLiDBAJdC5Qc+6FTyw38DWj3M8QljKLnGlc8kJqZM1/S0u0lZVoegb5YVUhE68Y
 BmFKW9eZphpUz9pBmaDP/2JMt4FKCU4RpHPi7QLzqyv46xXNBFU13YVVhaHzWRHusm4f
 sFjdxndCSd4WNQhVdKQLjeagrzFTiakJ+0Yr22SOdREuONLfuWA9PBmfacHLhxqMHFCh
 yL+F5lRZjD1LCQexU4vgeP+C8IsxLgGG5NBGTjT/yddBvzB3yfAyv6okIzSbxyWfQs+h
 15zIuO5IiEXEdhznKwlV3g8Zg/stb+gCPS3bxAkm1sbvum8fW801K3xf+2RpFApK3koc
 yUYQ==
X-Gm-Message-State: AOJu0Yy4bp7jD3B0uiRSPhJkoQ2gPiDUnvL4senu6wcz3Tclibt4Yiyk
 GxZLgQsLc+Zg8xUWIJqcw4/dCj3wH//oOXePja4=
X-Google-Smtp-Source: AGHT+IGyzHXJvywHg8YGzdgHmfSvZZzbOg6jdlkn3m9gkAG7wjgfdJKfeQq92nE7nXoVNTIIPk9dPA==
X-Received: by 2002:aa7:c909:0:b0:530:97b5:49ce with SMTP id
 b9-20020aa7c909000000b0053097b549cemr2715756edt.10.1696437797933; 
 Wed, 04 Oct 2023 09:43:17 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:43:17 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [RFC PATCH v10 14/24] cli: hush_2021: Add functions to be called from
 run_command()
Date: Wed,  4 Oct 2023 19:42:10 +0300
Message-Id: <20231004164220.15738-15-francis.laniel@amarulasolutions.com>
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

run_command() is called internally by the command run and it can also be called
directly from U-Boot code, e.g. to do unit tests.
This commit adds this path to go to hush 2021.

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/cli_hush_upstream.c | 66 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index b806c5c653..b11445c3ac 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -1012,6 +1012,7 @@ struct globals {
 #ifdef __U_BOOT__
 	int flag_repeat;
 	int do_repeat;
+	int run_command_flags;
 #endif /* __U_BOOT__ */
 	char *ifs_whitespace; /* = G.ifs or malloced */
 #ifndef __U_BOOT__
@@ -3005,7 +3006,24 @@ static int i_getch(struct in_str *i)
 	if (i->p && *i->p != '\0') {
 		ch = (unsigned char)*i->p++;
 		goto out;
+#ifndef __U_BOOT__
 	}
+#else /* __U_BOOT__ */
+	/*
+	 * There are two ways for command to be called:
+	 * 1. The first one is when they are typed by the user.
+	 * 2. The second one is through run_command() (NOTE command run
+	 * internally calls run_command()).
+	 *
+	 * In the second case, we do not get input from the user, so once we
+	 * get a '\0', it means we need to stop.
+	 * NOTE G.run_command_flags is only set on run_command call stack, so
+	 * we use this to know if we come from user input or run_command().
+	 */
+	} else if (i->p && *i->p == '\0' && G.run_command_flags){
+		return EOF;
+	}
+#endif /* __U_BOOT__ */
 #endif
 #ifndef __U_BOOT__
 	/* peek_buf[] is an int array, not char. Can contain EOF. */
@@ -3164,7 +3182,6 @@ static void setup_file_in_str(struct in_str *i)
 #endif /* !__U_BOOT__ */
 }
 
-#ifndef __U_BOOT__
 static void setup_string_in_str(struct in_str *i, const char *s)
 {
 	memset(i, 0, sizeof(*i));
@@ -3172,7 +3189,6 @@ static void setup_string_in_str(struct in_str *i, const char *s)
 	i->p = s;
 }
 
-#endif /* !__U_BOOT__ */
 
 /*
  * o_string support
@@ -7911,7 +7927,11 @@ static int run_and_free_list(struct pipe *pi);
  * NUL: parse all, execute, return
  * ';': parse till ';' or newline, execute, repeat till EOF
  */
+#ifndef __U_BOOT__
 static void parse_and_run_stream(struct in_str *inp, int end_trigger)
+#else /* __U_BOOT__ */
+static int parse_and_run_stream(struct in_str *inp, int end_trigger)
+#endif /* __U_BOOT__ */
 {
 	/* Why we need empty flag?
 	 * An obscure corner case "false; ``; echo $?":
@@ -7920,7 +7940,11 @@ static void parse_and_run_stream(struct in_str *inp, int end_trigger)
 	 * this breaks "false; echo `echo $?`" case.
 	 */
 	bool empty = 1;
+#ifndef __U_BOOT__
 	while (1) {
+#else /* __U_BOOT__ */
+	do {
+#endif /* __U_BOOT__ */
 		struct pipe *pipe_list;
 
 #if ENABLE_HUSH_INTERACTIVE
@@ -7967,21 +7991,57 @@ static void parse_and_run_stream(struct in_str *inp, int end_trigger)
 		empty = 0;
 		if (G_flag_return_in_progress == 1)
 			break;
+#ifndef __U_BOOT__
 	}
+#else /* __U_BOOT__ */
+	/*
+	 * This do/while is needed by run_command to avoid looping on a command
+	 * with syntax error.
+	 */
+	} while (!(G.run_command_flags & FLAG_EXIT_FROM_LOOP));
+
+	return G.last_exitcode;
+#endif /* __U_BOOT__ */
 }
 
 #ifndef __U_BOOT__
 static void parse_and_run_string(const char *s)
+#else /* __U_BOOT__ */
+static int parse_and_run_string(const char *s)
+#endif /* __U_BOOT__ */
 {
 	struct in_str input;
 	//IF_HUSH_LINENO_VAR(unsigned sv = G.parse_lineno;)
 
 	setup_string_in_str(&input, s);
+#ifndef __U_BOOT__
 	parse_and_run_stream(&input, '\0');
+#else /* __U_BOOT__ */
+	return parse_and_run_stream(&input, '\0');
+#endif /* __U_BOOT__ */
 	//IF_HUSH_LINENO_VAR(G.parse_lineno = sv;)
 }
-#endif /* !__U_BOOT__ */
 
+#ifdef __U_BOOT__
+int parse_string_outer(const char *cmd, int flags)
+{
+	int ret;
+	int old_flags;
+
+	/*
+	 * Keep old values of run_command to be able to restore them once
+	 * command was executed.
+	 */
+	old_flags = G.run_command_flags;
+	G.run_command_flags = flags;
+
+	ret = parse_and_run_string(cmd);
+
+	G.run_command_flags = old_flags;
+
+	return ret;
+}
+#endif /* __U_BOOT__ */
 #ifndef __U_BOOT__
 static void parse_and_run_file(HFILE *fp)
 #else /* __U_BOOT__ */
-- 
2.34.1

