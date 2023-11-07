Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCC6C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E71C87672;
	Tue,  7 Nov 2023 22:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cdCNjn5+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 156C387677; Tue,  7 Nov 2023 22:42:27 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21D9A87686
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:42:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50943ccbbaeso8902047e87.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393333; x=1699998133;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gv3JWwSbnb0G/ArlmTGV7a5vOPAwcVmescNy9DnCW9M=;
 b=cdCNjn5+SGeAkqk2xV8Ix5pr98zdRHfHdXYUiQ7c+zD90p+cTKRXoZ6PodjczbPGKP
 JEz0f9airaL2HEbc0JA2NsksMPIgTsYRnkATjTmxHBJdtQkG2DRe5qIZMWEa5EDb96d3
 55GI5wK8hSFd4cXySPz9/EqPNKTSTflcRfiLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393333; x=1699998133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gv3JWwSbnb0G/ArlmTGV7a5vOPAwcVmescNy9DnCW9M=;
 b=FgTzG9UIGh3ef2gG6patly92WDY9HOrqMeAN6pigwHaK1qaOHNnF4mrkE7w2aD7PPf
 rRvAu77bCbJ8iIic6xMetqlt0y+RNH474ltuYpHAiOCA/fWePVp9tr13t/hENKmJPSt5
 mE0tbLxSJxuJkO5bdysnkP7Y6naBUgghFV/rTMaJIeprupw4ap+ExJl6iXUgGS+gpkH3
 GNfPWXYxMJkUAdF/IN7jSq79BIQGl7ahAjIPLZXz3Jo4XAiIJ0HUb8KImY0DUc9T5YGV
 r8Ys5BtNrOnocrU5Fp3OdwDO8+L7ZZ1+UNJ3TNd97CzQb4Dh8ylv3xPF9QivtkgzrHCm
 gXBg==
X-Gm-Message-State: AOJu0YzLqkWfzssTRU+kOFUZ7ZPnJpczHhtVkpIkSvdkdUGUgOPWtxpI
 Q9sW1+0pAEfsKabmC/hL56QxheCZtBYC9SBSNA4=
X-Google-Smtp-Source: AGHT+IHNbWLnOFrv8nndeAetht20/kOyOIXxWBBuFAvuColqwc++oQghb1iJbcgni62O/6vfxaq/cg==
X-Received: by 2002:a05:6512:3b10:b0:507:96a3:596d with SMTP id
 f16-20020a0565123b1000b0050796a3596dmr31125765lfv.49.1699393333463; 
 Tue, 07 Nov 2023 13:42:13 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:42:13 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v11 13/24] cli: hush_2021: Enable variables expansion for hush
 2021
Date: Tue,  7 Nov 2023 23:41:10 +0200
Message-Id: <20231107214121.132079-14-francis.laniel@amarulasolutions.com>
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

Enables variables expansion for hush 2021, both for local and environment
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
 common/cli_hush_2021.c     | 17 +++++++
 common/cli_hush_upstream.c | 91 +++++++++++++++++++++++++++++++++++---
 2 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/common/cli_hush_2021.c b/common/cli_hush_2021.c
index 653ea52929..7dd30ea0ef 100644
--- a/common/cli_hush_2021.c
+++ b/common/cli_hush_2021.c
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
index 84227a248e..b806c5c653 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -3486,7 +3486,6 @@ static int o_get_last_ptr(o_string *o, int n)
 	return ((int)(uintptr_t)list[n-1]) + string_start;
 }
 
-#ifndef __U_BOOT__
 /*
  * Globbing routines.
  *
@@ -3741,8 +3740,10 @@ static int glob_needed(const char *s)
  */
 static int perform_glob(o_string *o, int n)
 {
+#ifndef __U_BOOT__
 	glob_t globdata;
 	int gr;
+#endif /* __U_BOOT__ */
 	char *pattern;
 
 	debug_printf_glob("start perform_glob: n:%d o->data:%p\n", n, o->data);
@@ -3751,13 +3752,16 @@ static int perform_glob(o_string *o, int n)
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
@@ -3793,16 +3797,22 @@ static int perform_glob(o_string *o, int n)
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
@@ -3810,7 +3820,6 @@ static int o_save_ptr(o_string *o, int n)
 		if (!o->has_empty_slot)
 			return perform_glob(o, n); /* o_save_ptr_helper is inside */
 	}
-#endif /* !__U_BOOT__ */
 	return o_save_ptr_helper(o, n);
 }
 
@@ -5456,7 +5465,20 @@ static int parse_dollar(o_string *as_string,
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
@@ -7031,7 +7053,20 @@ static NOINLINE int expand_one_var(o_string *output, int n,
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
 
@@ -7376,7 +7411,11 @@ static NOINLINE int expand_vars_to_list(o_string *output, int n, char *arg)
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
@@ -9977,7 +10016,30 @@ static NOINLINE int run_pipe(struct pipe *pi)
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
@@ -10092,6 +10154,25 @@ static NOINLINE int run_pipe(struct pipe *pi)
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

