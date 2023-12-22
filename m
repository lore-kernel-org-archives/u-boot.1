Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F359C47072
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38EAA8788F;
	Fri, 22 Dec 2023 22:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RNQy0VhU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE28C87874; Fri, 22 Dec 2023 22:03:39 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAFA787842
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40d4103aed7so21033935e9.3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703279010; x=1703883810;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8atAYcSxJqkLUa7wNntNkVGkl8V2j+VlYvx4/+374E=;
 b=RNQy0VhU4rXPDDHAe/zhf6jkLbPkJeMkswhHqZPKLnGgvlT6ZV7FEQxBTWpVUIBgbr
 uBSSngFmDDDW3GWcCCHWI1RI/qIkDdgIgSMS9CitUmRwqFSaQA4nOLoFshIK36f0Vt2n
 0QcEYrEZOXmPFIBkjiGluhMd4nNHnqOcXyWaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703279010; x=1703883810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o8atAYcSxJqkLUa7wNntNkVGkl8V2j+VlYvx4/+374E=;
 b=wH7quUY77OzSOsUKfykv4SocEaz7BnUy46PuuryDJjFdaV2/twaIm/8sQEDAByThk0
 XM6Ol6juGRXKJCOlJ9xHojLJ7ouNQ8iHWM/yBxftuTH8JzRh8KRngaOW/q1K7z56vQ43
 nRCdrOKIQtuBBrfprNkn9i0L/wOc6tn8Fanl9i/fpjnls0D3j6gRySGO9vFUkvCayNOk
 sFsUdf34FIZA06IgVXoQmhCZtFQHkDxjKEpxZiPiTn1mrpMuUEJeiNILcnkW/f1/DThV
 i4DGhQMNtIUHdt23YLexyxGG1QjhZycKslprWs2Qk4lePGIZTp4LOCYufbtnEggd2PuM
 nWDA==
X-Gm-Message-State: AOJu0YxboJFphvR7395RyUh6F+p8A2s4BdJq8opvZircvn/NqOF5ayxD
 zTTunaDB4G23JPLXK+y+csC76qGW/IWf3/+xE0Hyc1JpRas=
X-Google-Smtp-Source: AGHT+IGk8705LUHBxtA8qhIVRMCIStk+iIqzP178AYU9S1ZNua5SgD5pYA8fJMD+xidF2c+2k8zJhA==
X-Received: by 2002:a05:600c:1e20:b0:40c:2671:2c52 with SMTP id
 ay32-20020a05600c1e2000b0040c26712c52mr1189753wmb.99.1703279010554; 
 Fri, 22 Dec 2023 13:03:30 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm348294wmq.16.2023.12.22.13.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:03:30 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v13 14/24] cli: hush_modern: Add functions to be called from
 run_command()
Date: Fri, 22 Dec 2023 22:02:34 +0100
Message-Id: <20231222210244.91830-15-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
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

