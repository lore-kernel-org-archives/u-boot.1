Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78C8C4706F
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B095D8785B;
	Fri, 22 Dec 2023 22:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TNqzZT4y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B242B87768; Fri, 22 Dec 2023 22:03:39 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE50887846
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c48d7a7a7so17166585e9.3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703279009; x=1703883809;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7FQiGT6dyvRqJqLFqOZMqShA1Ng02KSe8nZFEAUKyrY=;
 b=TNqzZT4yC9whKybY+fqqwuyjL7pky+H8MI17Lgz8RQRO6z+q43gEOXiwWmyKpjMT5z
 pnTgS7E15/2eN5XyRiZJsYrcBLXfQUadwg11x6vYaitENfeNT+dJsPkl4i9LJAS2rX9X
 nGTdEFMVQIFfIwOhfTyp1lsfgzNfSe3xZSzuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703279009; x=1703883809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7FQiGT6dyvRqJqLFqOZMqShA1Ng02KSe8nZFEAUKyrY=;
 b=flCk2vZE1x/ZuP3EUGPTbKaPj8mbd5UeQCrjjvmS8vMH8Qv340xtNkVgo9S0mNDo9L
 1yqf8HWh3yQ1Sal7I1jxdQOgw9FGJtSs8cJ8X+FchwQEZ4KivvHkpMV1in9pL/ZtiNcq
 GE5ERdq7Y5lAukKqK6G9y696E6wXak4tqpoH/MQTuzOIQ4yae4KkLmFu6y/0K/H/+IiI
 tJU/WMujyTAinl//v6QiOI8zxI26VJjEdr7NpWe50vz47GY1ngrK462Ho/30lvAyfeoB
 Q4m0zflPHGDw7QQuGhbfJV58Vvrdc12RlhxnkZfRK8I1+fzNKDxnQnKOa16UC7lyYSiw
 yBAw==
X-Gm-Message-State: AOJu0YwfrrIw9LxfcEqgUyo3Zml5Gy8lPRApT0ZepLIg1GeZpcKmG1Lz
 u/IkYsoGlDILkHLqnPu9ZSB5L1GsMy4B5PEqKlMVZxj1voQ=
X-Google-Smtp-Source: AGHT+IFt5yFm1UpKjpdCo6CAHwq3k0HPs8PkFyUaDIzSJxpvf6UtNaTV/yie109BQQgtLklc8EI8Xg==
X-Received: by 2002:a05:600c:3d8a:b0:40c:3245:4448 with SMTP id
 bi10-20020a05600c3d8a00b0040c32454448mr1044678wmb.83.1703279009261; 
 Fri, 22 Dec 2023 13:03:29 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm348294wmq.16.2023.12.22.13.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:03:28 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v13 13/24] cli: hush_modern: Enable variables expansion for
 modern hush
Date: Fri, 22 Dec 2023 22:02:33 +0100
Message-Id: <20231222210244.91830-14-francis.laniel@amarulasolutions.com>
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

Enables variables expansion for modern hush, both for local and environment
variables.
So the following commands:
foo=bar
echo $foo
setenv bar foo
echo $bar
leads to "bar" and "foo" being printed on console output.

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/cli_hush_modern.c   | 17 +++++++
 common/cli_hush_upstream.c | 91 +++++++++++++++++++++++++++++++++++---
 2 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/common/cli_hush_modern.c b/common/cli_hush_modern.c
index 626fed089b..15bb1f0d92 100644
--- a/common/cli_hush_modern.c
+++ b/common/cli_hush_modern.c
@@ -207,6 +207,23 @@ static const char* endofname(const char *name)
 	return name;
 }
 
+/**
+ * list_size() - returns the number of elements in char ** before NULL.
+ *
+ * Argument must contain NULL to signalize its end.
+ *
+ * @list The list to count the number of element.
+ * @return The number of element in list.
+ */
+static size_t list_size(char **list)
+{
+	size_t size;
+
+	for (size = 0; list[size] != NULL; size++);
+
+	return size;
+}
+
 struct in_str;
 static int u_boot_cli_readline(struct in_str *i);
 
diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index 4b6ab20f3b..ff4a57c6e3 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -3485,7 +3485,6 @@ static int o_get_last_ptr(o_string *o, int n)
 	return ((int)(uintptr_t)list[n-1]) + string_start;
 }
 
-#ifndef __U_BOOT__
 /*
  * Globbing routines.
  *
@@ -3740,8 +3739,10 @@ static int glob_needed(const char *s)
  */
 static int perform_glob(o_string *o, int n)
 {
+#ifndef __U_BOOT__
 	glob_t globdata;
 	int gr;
+#endif /* __U_BOOT__ */
 	char *pattern;
 
 	debug_printf_glob("start perform_glob: n:%d o->data:%p\n", n, o->data);
@@ -3750,13 +3751,16 @@ static int perform_glob(o_string *o, int n)
 	pattern = o->data + o_get_last_ptr(o, n);
 	debug_printf_glob("glob pattern '%s'\n", pattern);
 	if (!glob_needed(pattern)) {
+#ifndef __U_BOOT__
  literal:
+#endif /* __U_BOOT__ */
 		/* unbackslash last string in o in place, fix length */
 		o->length = unbackslash(pattern) - o->data;
 		debug_printf_glob("glob pattern '%s' is literal\n", pattern);
 		return o_save_ptr_helper(o, n);
 	}
 
+#ifndef __U_BOOT__
 	memset(&globdata, 0, sizeof(globdata));
 	/* Can't use GLOB_NOCHECK: it does not unescape the string.
 	 * If we glob "*.\*" and don't find anything, we need
@@ -3792,16 +3796,22 @@ static int perform_glob(o_string *o, int n)
 	if (DEBUG_GLOB)
 		debug_print_list("perform_glob returning", o, n);
 	return n;
+#else /* __U_BOOT__ */
+	/*
+	 * NOTE We only use perform glob to call unbackslash to remove backslash
+	 * from string once expanded.
+	 * So, it seems OK to return this if no previous return was done.
+	 */
+	return o_save_ptr_helper(o, n);
+#endif /* __U_BOOT__ */
 }
 
-#endif /* !__U_BOOT__ */
 #endif /* !HUSH_BRACE_EXPANSION */
 
 /* If o->o_expflags & EXP_FLAG_GLOB, glob the string so far remembered.
  * Otherwise, just finish current list[] and start new */
 static int o_save_ptr(o_string *o, int n)
 {
-#ifndef __U_BOOT__
 	if (o->o_expflags & EXP_FLAG_GLOB) {
 		/* If o->has_empty_slot, list[n] was already globbed
 		 * (if it was requested back then when it was filled)
@@ -3809,7 +3819,6 @@ static int o_save_ptr(o_string *o, int n)
 		if (!o->has_empty_slot)
 			return perform_glob(o, n); /* o_save_ptr_helper is inside */
 	}
-#endif /* !__U_BOOT__ */
 	return o_save_ptr_helper(o, n);
 }
 
@@ -5455,7 +5464,20 @@ static int parse_dollar(o_string *as_string,
 			nommu_addchr(as_string, ch);
 			if (ch == '}')
 				break;
+#ifndef __U_BOOT__
 			if (!isalnum(ch) && ch != '_') {
+#else /* __U_BOOT__ */
+			/*
+			 * In several places in U-Boot, we use variable like
+			 * foo# (e.g. serial#), particularly in env.
+			 * So, we need to authorize # to appear inside
+			 * variable name and then expand this variable.
+			 * NOTE Having # in variable name is not permitted in
+			 * upstream hush but expansion will be done (even though
+			 * the result will be empty).
+			 */
+			if (!isalnum(ch) && ch != '_' && ch != '#') {
+#endif /* __U_BOOT__ */
 				unsigned end_ch;
 #ifndef __U_BOOT__
 				unsigned char last_ch;
@@ -7030,7 +7052,20 @@ static NOINLINE int expand_one_var(o_string *output, int n,
 		}
 #endif /* !__U_BOOT__ */
 		default:
+#ifndef __U_BOOT__
 			val = get_local_var_value(var);
+#else /* __U_BOOT__ */
+			/*
+			 * Environment variable set with setenv* have to be
+			 * expanded.
+			 * So, we first search if the variable exists in
+			 * environment, if this is not the case, we default to
+			 * local value.
+			 */
+			val = env_get(var);
+			if (!val)
+				val = get_local_var_value(var);
+#endif /* __U_BOOT__ */
 		}
 	}
 
@@ -7375,7 +7410,11 @@ static NOINLINE int expand_vars_to_list(o_string *output, int n, char *arg)
 		case '*':
 		case '@': {
 			int i;
+#ifndef __U_BOOT__
 			if (!G.global_argv[1])
+#else /* __U_BOOT__ */
+			if (!G.global_argv || !G.global_argv[1])
+#endif /* __U_BOOT__ */
 				break;
 			i = 1;
 			cant_be_null |= first_ch; /* do it for "$@" _now_, when we know it's not empty */
@@ -9976,7 +10015,30 @@ static NOINLINE int run_pipe(struct pipe *pi)
 #endif /* !__U_BOOT__ */
 		command = &pi->cmds[cmd_no];
 		cmd_no++;
-		if (command->argv) {
+
+#ifdef __U_BOOT__
+		/* Replace argv and argc by expanded if it exists. */
+		if (argv_expanded) {
+			/*
+			 * We need to save a pointer to argv, we will restore it
+			 * later, so it will be freed when pipe is freed.
+			 */
+			argv = command->argv;
+
+			/*
+			 * After expansion, there can be more or less argument, so we need to
+			 * update argc, for example:
+			 * - More arguments:
+			 *   foo='bar quuz'
+			 *   echo $foo
+			 * - Less arguments:
+			 *   echo $foo (if foo was never set)
+			 */
+			command->argc = list_size(argv_expanded);
+			command->argv = argv_expanded;
+		}
+#endif /* __U_BOOT__ */
+			if (command->argv) {
 			debug_printf_exec(": pipe member '%s' '%s'...\n",
 					command->argv[0], command->argv[1]);
 		} else {
@@ -10091,6 +10153,25 @@ static NOINLINE int run_pipe(struct pipe *pi)
 		rcode = cmd_process(G.do_repeat ? CMD_FLAG_REPEAT : 0,
 				    command->argc, command->argv,
 				    &(G.flag_repeat), NULL);
+
+		if (argv_expanded) {
+			/*
+			 * expand_strvec_to_strvec() allocates memory to expand
+			 * argv, we need to free it.
+			 */
+			free(argv_expanded);
+
+			/*
+			 * We also restore command->argv to its original value
+			 * so no memory leak happens.
+			 */
+			command->argv = argv;
+
+			/*
+			 * NOTE argc exists only in U-Boot, so argv freeing does
+			 * not rely on it as this code exists in BusyBox.
+			 */
+		}
 #endif /* __U_BOOT__ */
 	}
 
-- 
2.34.1

