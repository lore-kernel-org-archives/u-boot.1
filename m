Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED152C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 22:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FC9A87702;
	Fri,  8 Dec 2023 23:31:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cJ9AarUA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16086876D5; Fri,  8 Dec 2023 23:31:25 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 736F78767B
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 23:31:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40c2d50bfbfso10475695e9.0
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 14:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702074676; x=1702679476;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8atAYcSxJqkLUa7wNntNkVGkl8V2j+VlYvx4/+374E=;
 b=cJ9AarUAX47HFitSqZchcdiGbBjB6x3j0QcBNKee8mQdPRcqhO0m/W8787GWUEYsSD
 QhpoeNmiCW4DApX7jviGW36aMzYbl8ExOydqSZpsSVLXERbLSjXWYC8NQC9GyENatI9J
 tkIuSVi0VZ+oIqr8yqTer2CjTukDgcRum/A/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702074676; x=1702679476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o8atAYcSxJqkLUa7wNntNkVGkl8V2j+VlYvx4/+374E=;
 b=WKMRTTIuDLKJJiY6iWFxIJ/DI5x1qya18AarIkqCbmPxpQv+6MP11eaauRlqgAceau
 Y0ZN3Xb6D7jkCSNr/8L6CeNc92v1gY6t72mnM0CUnTzbQL1Z8c8QQDOvM6+fVxnfCD/n
 jgB5MOMZBy5468OHpzHlFWhZpl5OnT9mvOfHT9FyquT9JPPFRLsxpkLmNVJoRwzSfZpn
 x1Az820F1mqttd5nyOV1mQx70sLQcbhpojhFp7UhFJshdELPWqg1pDSbDmmUCWwkgOxl
 IKoO1txoeogv5LvvyEP1rJmG868Lw9UTzm0HKyEeYUifu6QNET3mSPFJCDTflBrzi+Kl
 Dl3A==
X-Gm-Message-State: AOJu0YwXKmsQmSGaNPnPlboNZVM32ZdTWUmmR+ofpjq92zhXFdACAcp/
 ZhPhWM6lgCZSU1qmeCED31aZWH3kXU6IB64vV/xrzQ==
X-Google-Smtp-Source: AGHT+IEAcac8NgxCq9eZl9e3KKMUnM29RjdF6QsYz2z6SNYXxNP92fTwtc8LMCzc31Ft6yxrZ2XLEg==
X-Received: by 2002:a05:600c:1503:b0:40b:5e26:2371 with SMTP id
 b3-20020a05600c150300b0040b5e262371mr366991wmg.34.1702074676019; 
 Fri, 08 Dec 2023 14:31:16 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c350b00b0040b4cb14d40sm6357863wmq.19.2023.12.08.14.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 14:31:15 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v12 14/24] cli: hush_modern: Add functions to be called from
 run_command()
Date: Fri,  8 Dec 2023 23:30:15 +0100
Message-Id: <20231208223025.55076-15-francis.laniel@amarulasolutions.com>
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

run_command() is called internally by the command run and it can also be called
directly from U-Boot code, e.g. to do unit tests.
This commit adds this path to go to modern hush.

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/cli_hush_upstream.c | 66 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index ff4a57c6e3..7f6b058e6c 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -1011,6 +1011,7 @@ struct globals {
 #ifdef __U_BOOT__
 	int flag_repeat;
 	int do_repeat;
+	int run_command_flags;
 #endif /* __U_BOOT__ */
 	char *ifs_whitespace; /* = G.ifs or malloced */
 #ifndef __U_BOOT__
@@ -3004,7 +3005,24 @@ static int i_getch(struct in_str *i)
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
@@ -3163,7 +3181,6 @@ static void setup_file_in_str(struct in_str *i)
 #endif /* !__U_BOOT__ */
 }
 
-#ifndef __U_BOOT__
 static void setup_string_in_str(struct in_str *i, const char *s)
 {
 	memset(i, 0, sizeof(*i));
@@ -3171,7 +3188,6 @@ static void setup_string_in_str(struct in_str *i, const char *s)
 	i->p = s;
 }
 
-#endif /* !__U_BOOT__ */
 
 /*
  * o_string support
@@ -7910,7 +7926,11 @@ static int run_and_free_list(struct pipe *pi);
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
@@ -7919,7 +7939,11 @@ static void parse_and_run_stream(struct in_str *inp, int end_trigger)
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
@@ -7966,21 +7990,57 @@ static void parse_and_run_stream(struct in_str *inp, int end_trigger)
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

