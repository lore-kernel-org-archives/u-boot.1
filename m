Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7F5E7C4E3
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:47:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1A6B8760C;
	Wed,  4 Oct 2023 18:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="B2ciz/Bz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E33FC87513; Wed,  4 Oct 2023 18:43:47 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88ACC875D4
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5384975e34cso4302550a12.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437807; x=1697042607;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6m96BWRNrUs7wLN2G3qt/SSwCbl/84LCFDpBmC79iE=;
 b=B2ciz/BzoiO+OwDAm/IOgekKZsdShSl1iwTvcV0QsxlLivR5D9EALIEZcPshnUJRaN
 T9Pb9oLTnoOMWHUL9m90EdP+atGxvpLamNne7OMyoOwVRpS4K24TllujVUOuNjUR1jKZ
 iYWiJYeFpZSHq6OhMS1p/6Vp7uHeXdSP8j+Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437807; x=1697042607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M6m96BWRNrUs7wLN2G3qt/SSwCbl/84LCFDpBmC79iE=;
 b=k+3aoNxryc5ReXhTr/gUBBDCrAsQbgEPF5ozaEVkb74udnNbVVEXrUEBk8JK/da1q5
 j1AVCqot05AAJvSeSIjPArOq4a7gEtIaNaDwWvIcBvQ331PZDEdU1LxmwjrQdDr4Df5M
 8/WkrXhpFpF3Pw83aV46/7yyHFrPp4ylqSBK1HiRI7pkqEMw4dQsx6lqzhU56feYLPy9
 VyJnGdQRiKJqYnD4Fabrd6fuuYW3WZWl2ufErr6DKU5Bl/yhCqx5YhPCazpTIsAcl9SU
 QylU6DUcyBPVIml0UXyAaa1RyJmGBW0Hz7s3SDXWHfg+SOUoatm4JQwakPOKMxG3QRdz
 b7cg==
X-Gm-Message-State: AOJu0YzrR839tY0j6tCHgYu22sIhKr4+EpRAm/RtAkCTM8tkrIRBFY5I
 xJgJUFkniWffaJpQxYHd6IPeA+zlkRaItJT0SWo=
X-Google-Smtp-Source: AGHT+IFWk65QZT+jlxCUXrXMxVreTgKaHMyjMNRZUN3TAOxn8pK69t9oYaJP4DYVDV3CHtdlKFO1DA==
X-Received: by 2002:a05:6402:28a:b0:538:8d4:2077 with SMTP id
 l10-20020a056402028a00b0053808d42077mr2665155edv.13.1696437807217; 
 Wed, 04 Oct 2023 09:43:27 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:43:27 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [RFC PATCH v10 19/24] cli: hush_2021: Enable if keyword
Date: Wed,  4 Oct 2023 19:42:15 +0300
Message-Id: <20231004164220.15738-20-francis.laniel@amarulasolutions.com>
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

