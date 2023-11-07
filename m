Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FC1C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:45:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5E1587655;
	Tue,  7 Nov 2023 22:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EzXCNthk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 560298769F; Tue,  7 Nov 2023 22:42:33 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2364387622
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:42:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4079ed65471so45508235e9.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393339; x=1699998139;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6m96BWRNrUs7wLN2G3qt/SSwCbl/84LCFDpBmC79iE=;
 b=EzXCNthkEa53YAJc9mhnGilVJFWLM9dZjZ8WbaKAF3bbgcwikKmEN3bki7OAAn40Wq
 FXHpXRJUH3abD5BfYDzxjcG1a2yNR8VbPd8srGTATlKVLRaoKYwcAaFlFLI6bXdFVwm3
 JnXLOe0AfnmTi2SjDIwVdaK44mrtyZSsaRqw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393339; x=1699998139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M6m96BWRNrUs7wLN2G3qt/SSwCbl/84LCFDpBmC79iE=;
 b=TGOtkyIgzkYYdijyEiiF+xqfWX7Inxo/rB8FZKesHtDEerA7B6VVHrZX2P7WP4E/Yf
 Tlxiluvp0eGy8wQyMmQWwCDv5TuGhk1ZJWAGihUvwz9TnKwTJ7wFghJ6GwaRwvo20CRg
 NLqxGimsamPXnw5MRtDO5swf1RBxWN5emUtvgqFWtlISq5C1Hk9XEGwe3z4j2vKgvn56
 fMYXS8bpyHkrluCeHHTQD257k0SEsd3/2aJ9TCXD2gNe4AwFSZ7U0bvPbkmY2C7J2eJj
 +sFVJ9/5FSCA5MfEXLYY1B6jbiOsDfB6kQ5DKZRClyOV/dDwzNHUDVF2WE9kli+6EUml
 fWWA==
X-Gm-Message-State: AOJu0YwOdTtY+MWaZMVk5uAk/ghOt+FhLngn12G9vuXtqhD6pMa+WvEY
 oLx6kVjI4P14XghfgUv/BR7yZZnr3coO5g3nk6o=
X-Google-Smtp-Source: AGHT+IG0pDIH+g1Iens6deixwdmK2zJuKu8FmrpSY3p3G+cBj0881jDCpNCW8WqPY+XDc8QAqgK7hg==
X-Received: by 2002:adf:e78e:0:b0:32f:9697:ec48 with SMTP id
 n14-20020adfe78e000000b0032f9697ec48mr43418wrm.23.1699393339742; 
 Tue, 07 Nov 2023 13:42:19 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:42:19 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v11 19/24] cli: hush_2021: Enable if keyword
Date: Tue,  7 Nov 2023 23:41:16 +0200
Message-Id: <20231107214121.132079-20-francis.laniel@amarulasolutions.com>
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

Adds support for "if then else" construct both for command line interface and
through run_command().

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/cli_hush_2021.c     | 11 +++++++++++
 common/cli_hush_upstream.c | 12 ++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/common/cli_hush_2021.c b/common/cli_hush_2021.c
index 7dd30ea0ef..aba5dcbbcd 100644
--- a/common/cli_hush_2021.c
+++ b/common/cli_hush_2021.c
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
index 68a9a4bb72..9b65dcbde1 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -1488,7 +1488,6 @@ static void msg_and_die_if_script(unsigned lineno, const char *fmt, ...)
 	die_if_script();
 }
 
-#ifndef __U_BOOT__
 static void syntax_error(unsigned lineno UNUSED_PARAM, const char *msg)
 {
 	if (msg)
@@ -1497,7 +1496,6 @@ static void syntax_error(unsigned lineno UNUSED_PARAM, const char *msg)
 		bb_simple_error_msg("syntax error");
 	die_if_script();
 }
-#endif /* !__U_BOOT__ */
 
 static void syntax_error_at(unsigned lineno UNUSED_PARAM, const char *msg)
 {
@@ -3962,7 +3960,6 @@ static void debug_print_tree(struct pipe *pi, int lvl)
 		[PIPE_OR ] = "OR" ,
 		[PIPE_BG ] = "BG" ,
 	};
-#ifndef __U_BOOT__
 	static const char *RES[] = {
 		[RES_NONE ] = "NONE" ,
 # if ENABLE_HUSH_IF
@@ -3992,7 +3989,6 @@ static void debug_print_tree(struct pipe *pi, int lvl)
 		[RES_XXXX ] = "XXXX" ,
 		[RES_SNTX ] = "SNTX" ,
 	};
-#endif /* !__U_BOOT__ */
 	static const char *const CMDTYPE[] = {
 		"{}",
 		"()",
@@ -4010,10 +4006,8 @@ static void debug_print_tree(struct pipe *pi, int lvl)
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
@@ -9833,6 +9827,7 @@ static NOINLINE int run_pipe(struct pipe *pi)
 		rcode = 1; /* exitcode if redir failed */
 #ifndef __U_BOOT__
 		if (setup_redirects(command, &squirrel) == 0) {
+#endif /* !__U_BOOT__ */
 			debug_printf_exec(": run_list\n");
 //FIXME: we need to pass squirrel down into run_list()
 //for SH_STANDALONE case, or else this construct:
@@ -9841,10 +9836,11 @@ static NOINLINE int run_pipe(struct pipe *pi)
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
@@ -10363,12 +10359,12 @@ static int run_list(struct pipe *pi)
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

