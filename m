Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49606C47072
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36D0887800;
	Fri, 22 Dec 2023 22:03:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="h1wsidn0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38ECF877BC; Fri, 22 Dec 2023 22:03:45 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59A1A87824
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:03:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40c48d7a7a7so17167205e9.3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703279018; x=1703883818;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqMi235ZWwmnD2KBHenN1UfUx3XSh/WiDgFCrq644ds=;
 b=h1wsidn0nibJW2gAMn9XMKhtW9foXtLVhGTeTUakLkirTUtbJIpVlakbExRZhFfMwE
 etB/CD/l4rAUkdiqjwT6bPBmd6ho25qPxVUornKHCuBWhbjO7Q+NzFT3qwhehjXX//+f
 jbuhuv6zVTMnPJDFz4L7c3l7CBLszCR0UmkQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703279018; x=1703883818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oqMi235ZWwmnD2KBHenN1UfUx3XSh/WiDgFCrq644ds=;
 b=slCflP2bEbqlLpuAZ3bdz5qcmjNR3LkYBNFVpGbpaNHf1nElsOy27PqbeifcoHpaoP
 HCcZKS2uwJaRpsZV2bKHcuL0l3dN5w4lLKtnVUVc80i58BrIZqmAPmLtqYWXlmfbq8Qy
 JNarpdwS9a2RsdnZ3186xTClUd7qbiohW/u64lj0mYJ5Cynp9bhe3Ff5yss1kjFlbkRG
 NTfAvkiyentDjjp9LXNh8BCZ/PtbsVCoau0Mhtycn9+o04yU+fioaWK4dDH7tQJZIc9Y
 94wwWkIQ9MrQy/ssuEjzpANR4DytudRkX0/vUAnFYbnQ4zMJ0oqwYCGKa6mhMZp8ek3B
 t3bg==
X-Gm-Message-State: AOJu0Yzmx8vRSMlWadsq1v80M9r06w8SYuaLOX5ogT5wUoHTV2j+NEY5
 eeZUMjXUbhPapV/vKNb0xskgUGEV/++SzfXXNkNlrTI49YM=
X-Google-Smtp-Source: AGHT+IGsgmvsdCMoUQBAvufEOsdHSFFNCNsIi4y7VBR/n45JUsGjKJnwlVPpOOsFI6YDctHMMoarCw==
X-Received: by 2002:a05:600c:3c88:b0:40d:418a:eece with SMTP id
 bg8-20020a05600c3c8800b0040d418aeecemr1209761wmb.106.1703279017935; 
 Fri, 22 Dec 2023 13:03:37 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm348294wmq.16.2023.12.22.13.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:03:37 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v13 19/24] cli: hush_modern: Enable if keyword
Date: Fri, 22 Dec 2023 22:02:39 +0100
Message-Id: <20231222210244.91830-20-francis.laniel@amarulasolutions.com>
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

Adds support for "if then else" construct both for command line interface and
through run_command().

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/cli_hush_modern.c   | 11 +++++++++++
 common/cli_hush_upstream.c | 12 ++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/common/cli_hush_modern.c b/common/cli_hush_modern.c
index 15bb1f0d92..6360747f21 100644
--- a/common/cli_hush_modern.c
+++ b/common/cli_hush_modern.c
@@ -33,6 +33,7 @@
  */
 #define ENABLE_HUSH_INTERACTIVE	1
 #define ENABLE_FEATURE_EDITING	1
+#define ENABLE_HUSH_IF		1
 /* No MMU in U-Boot */
 #define BB_MMU			0
 #define USE_FOR_NOMMU(...)	__VA_ARGS__
@@ -124,6 +125,11 @@ static void bb_error_msg(const char *s, ...)
 	va_end(p);
 }
 
+static void bb_simple_error_msg(const char *s)
+{
+	bb_error_msg("%s", s);
+}
+
 static void *xmalloc(size_t size)
 {
 	void *p = NULL;
@@ -147,6 +153,11 @@ static void *xrealloc(void *ptr, size_t size)
 	return p;
 }
 
+static void *xmemdup(const void *s, int n)
+{
+	return memcpy(xmalloc(n), s, n);
+}
+
 #define xstrdup		strdup
 #define xstrndup	strndup
 
diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index a56ea6c5c8..06af538a48 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -1487,7 +1487,6 @@ static void msg_and_die_if_script(unsigned lineno, const char *fmt, ...)
 	die_if_script();
 }
 
-#ifndef __U_BOOT__
 static void syntax_error(unsigned lineno UNUSED_PARAM, const char *msg)
 {
 	if (msg)
@@ -1496,7 +1495,6 @@ static void syntax_error(unsigned lineno UNUSED_PARAM, const char *msg)
 		bb_simple_error_msg("syntax error");
 	die_if_script();
 }
-#endif /* !__U_BOOT__ */
 
 static void syntax_error_at(unsigned lineno UNUSED_PARAM, const char *msg)
 {
@@ -3961,7 +3959,6 @@ static void debug_print_tree(struct pipe *pi, int lvl)
 		[PIPE_OR ] = "OR" ,
 		[PIPE_BG ] = "BG" ,
 	};
-#ifndef __U_BOOT__
 	static const char *RES[] = {
 		[RES_NONE ] = "NONE" ,
 # if ENABLE_HUSH_IF
@@ -3991,7 +3988,6 @@ static void debug_print_tree(struct pipe *pi, int lvl)
 		[RES_XXXX ] = "XXXX" ,
 		[RES_SNTX ] = "SNTX" ,
 	};
-#endif /* !__U_BOOT__ */
 	static const char *const CMDTYPE[] = {
 		"{}",
 		"()",
@@ -4009,10 +4005,8 @@ static void debug_print_tree(struct pipe *pi, int lvl)
 				lvl*2, "",
 				pin,
 				pi->num_cmds,
-#ifdef __U_BOOT__
 				(IF_HAS_KEYWORDS(pi->pi_inverted ? "! " :) ""),
 				RES[pi->res_word],
-#endif /* !__U_BOOT__ */
 				pi->followup, PIPE[pi->followup]
 		);
 		prn = 0;
@@ -9832,6 +9826,7 @@ static NOINLINE int run_pipe(struct pipe *pi)
 		rcode = 1; /* exitcode if redir failed */
 #ifndef __U_BOOT__
 		if (setup_redirects(command, &squirrel) == 0) {
+#endif /* !__U_BOOT__ */
 			debug_printf_exec(": run_list\n");
 //FIXME: we need to pass squirrel down into run_list()
 //for SH_STANDALONE case, or else this construct:
@@ -9840,10 +9835,11 @@ static NOINLINE int run_pipe(struct pipe *pi)
 //and in SH_STANDALONE mode, "find" is not execed,
 //therefore CLOEXEC on saved fd does not help.
 			rcode = run_list(command->group) & 0xff;
+#ifndef __U_BOOT__
 		}
 		restore_redirects(squirrel);
-		IF_HAS_KEYWORDS(if (pi->pi_inverted) rcode = !rcode;)
 #endif /* !__U_BOOT__ */
+		IF_HAS_KEYWORDS(if (pi->pi_inverted) rcode = !rcode;)
 		debug_leave();
 		debug_printf_exec("run_pipe: return %d\n", rcode);
 		return rcode;
@@ -10362,12 +10358,12 @@ static int run_list(struct pipe *pi)
 			break;
 		if (G_flag_return_in_progress == 1)
 			break;
+#endif /* !__U_BOOT__ */
 
 		IF_HAS_KEYWORDS(rword = pi->res_word;)
 		debug_printf_exec(": rword=%d cond_code=%d last_rword=%d\n",
 				rword, cond_code, last_rword);
 
-#endif /* !__U_BOOT__ */
 		sv_errexit_depth = G.errexit_depth;
 		if (
 #if ENABLE_HUSH_IF
-- 
2.34.1

