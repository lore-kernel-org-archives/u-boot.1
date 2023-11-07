Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AACC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:44:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10AE387677;
	Tue,  7 Nov 2023 22:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RYjpp36c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EEA787663; Tue,  7 Nov 2023 22:42:27 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02F798762C
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32fa7d15f4eso4135799f8f.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393334; x=1699998134;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2gC2uc8mcXuH+rcxRmhrCiahKWth0TENLQZSncOpBI=;
 b=RYjpp36cddkeMB5Wy7tK2jw2Nh9AiENU8wsqU1CwX2aFw9+dyqDfHDfkIr82H2CGxG
 YAd22HiivxsgmxZuDvTLzoQXJ7nEMXo7kQegR0RJb2DOtQZFjV3eYQsUk2jVioSuZkQ8
 MdBbCiNtpujRoIwGPwDk8GyK6NBSi5z/7k0co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393334; x=1699998134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t2gC2uc8mcXuH+rcxRmhrCiahKWth0TENLQZSncOpBI=;
 b=qoEH7QfcI8B3vm1sEq4SW36/W6p4pNOuxfvXclARPNOkC92GfFZ6jPAZ8yj6qG/1LR
 pW4Tl0DVvWkaEpCzrmlrEciGSHhYgu4nFAmYxiA6R2z2dAiD3VqHsx0ph2dZDdHUPfmI
 ybTZItpyz2tsEZVaElcfjBAcmb5TbN2GZD/VKC7NSU2POdrRpJfAHK9zhXZrnXBf0g0K
 Zkmx7b2h6H2uE9djo32/4VVNNfZt0miEUilZFJCs10gJZ+93IuWA92ITxRLcwJ/wUTHE
 Qd/rF/5Vo3DNqjGbLyj2LLRNufHfm7bxGx2qmz97m2ib8oIVI8srmCTVJxOgIynSgLXs
 zvKA==
X-Gm-Message-State: AOJu0YzmTIYlEyFE+6d0LbHYihp94FmzxoZFDF4A46EVk1hrH9SN1KHU
 8RiYpLfaKAkejZQNwkxWpH85rfCpPU8byCfemLA=
X-Google-Smtp-Source: AGHT+IG1rRVs1aKwNwTqnaNLBWSqsodPUh8C0Y+o26WAnxbqrtz82jstIyG2OGm2WkKEoESqOm2ZVg==
X-Received: by 2002:a05:6000:4014:b0:32d:b991:1a71 with SMTP id
 cp20-20020a056000401400b0032db9911a71mr66080wrb.0.1699393334475; 
 Tue, 07 Nov 2023 13:42:14 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:42:14 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v11 14/24] cli: hush_2021: Add functions to be called from
 run_command()
Date: Tue,  7 Nov 2023 23:41:11 +0200
Message-Id: <20231107214121.132079-15-francis.laniel@amarulasolutions.com>
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

