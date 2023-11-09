Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B7FC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 19:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19ACD8749B;
	Thu,  9 Nov 2023 20:12:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hf3uwyPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64507874C8; Thu,  9 Nov 2023 20:12:05 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 145AB8723E
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 20:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-41e3e77e675so7822961cf.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 11:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699557121; x=1700161921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I0f5rgOciIVfZZ6QggXx/2NGQ9BzWTZ5+Vg3PSEkWsM=;
 b=hf3uwyPd/+IbLoIxGReB4EcqpMY5HviSuFt+2TSHYUoqnu9jXloNsuHbTRUZaqJG0j
 j03jPMxxA07NY66SHmHF/qrIiovNCXa8IdlosoUUAMVsDCDBcEDsWMhf0/PbwlbfW5gN
 nxCnhBe4V44Rbg1JkNlwHlRgZy4+SuZLrBwG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699557121; x=1700161921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I0f5rgOciIVfZZ6QggXx/2NGQ9BzWTZ5+Vg3PSEkWsM=;
 b=GFqsRnqelehUlW2Ii/wSd13EltwSDg0k0hM5wKuqE7eVflapXxysd+eZc2BACPfKt9
 9qIjMBa5dh9STGRn2mjIvMp03ToU3SxAs2XZUMb0n4BaVNBzawJ18jq7cqoXypQR0NII
 2JKGkNNc4F76DfzItfiRUO+VfCGxTvu01o+q1XLPYBqUzOohneL67Zc0NZ9ukxbrg8+A
 XGMvWVSwUL3NEYP42HqnQqO6UhsZNc5Cyu24FNrPxYX43g5ITWfRczGFdykmoj5nbhEo
 dWYDbtXo2h32eICmUSysCqaHK/oY1nRwQ01sb/EOo5tffglhZpqtTjinIJVjYlZD8sOt
 Q5QQ==
X-Gm-Message-State: AOJu0Yxy0pyqsjfszWS/GfTgVqL8+mfYwsbxi93BOYzbI3gOsPZ3n86H
 ySbrnAf4F97VeK+pKaOqyvFzrDfHdTMp2bGb1rWZTQ==
X-Google-Smtp-Source: AGHT+IG+Sw4pEUBNTMDwH/kCiL1GDRMWZum4BN8GyV58ckEbGnQ82HgSnPDQSyPzro45oMy6mZPTxw==
X-Received: by 2002:a05:622a:250:b0:415:2623:d8df with SMTP id
 c16-20020a05622a025000b004152623d8dfmr5644395qtx.7.1699557121495; 
 Thu, 09 Nov 2023 11:12:01 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a05622a019400b0041519614354sm2187463qtw.7.2023.11.09.11.12.00
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 11:12:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] squash! Remove some ifndef __U_BOOT__ checks in new hush
Date: Thu,  9 Nov 2023 14:12:00 -0500
Message-Id: <20231109191200.3229267-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107214121.132079-9-francis.laniel@amarulasolutions.com>
References: <20231107214121.132079-9-francis.laniel@amarulasolutions.com>
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

Looking at the code, we had a number of places where the blocks were:
#ifndef __U_BOOT__
...
#endif /* !__U_BOOT__ */

#ifndef __U_BOOT__
...
#endif /* !__U_BOOT__ */

And so we can just remove the center endif/ifndef. If the enclosed
functionality gets ported to U-Boot at some point in the future, then we
can re-enclose things as needed. In a similar manner, we sometimes had:

#ifndef __U_BOOT__
void foo(void)
{
...
#ifndef __U_BOOT__
...
#endif /* !__U_BOOT__ */
...
}
#endif /* !__U_BOOT__ */

And we can remove those inner tests, along the same thinking. If
appropriate later, we can add them when we do whatever else is needed
for that particular hush feature to be functional.

After this it would be good to compare the file with the upstream base
and ensure we don't have any extra empty lines, etc, anywhere.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/cli_hush_upstream.c | 58 +-------------------------------------
 1 file changed, 1 insertion(+), 57 deletions(-)

diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index 709c055d2fdd..de9253c44aac 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -794,14 +794,12 @@ enum {
 	WORD_IS_KEYWORD       = 3,
 };
 
-#ifndef __U_BOOT__
 /* On program start, environ points to initial environment.
  * putenv adds new pointers into it, unsetenv removes them.
  * Neither of these (de)allocates the strings.
  * setenv allocates new strings in malloc space and does putenv,
  * and thus setenv is unusable (leaky) for shell's purposes */
 #define setenv(...) setenv_is_leaky_dont_use()
-#endif /* !__U_BOOT__ */
 struct variable {
 	struct variable *next;
 	char *varstr;        /* points to "name=" portion */
@@ -1004,11 +1002,9 @@ struct globals {
 #endif /* !__U_BOOT__ */
 	unsigned depth_of_loop;
 #endif
-#ifndef __U_BOOT__
 #if ENABLE_HUSH_GETOPTS
 	unsigned getopt_count;
 #endif
-#endif /* !__U_BOOT__ */
 	const char *ifs;
 #ifdef __U_BOOT__
 	int flag_repeat;
@@ -1881,10 +1877,8 @@ static void restore_G_args(save_arg_t *sv, char **argv)
 	G.global_argc = sv->sv_g_argc;
 	IF_HUSH_SET(G.global_args_malloced = sv->sv_g_malloced;)
 }
-#endif /* !__U_BOOT__ */
 
 
-#ifndef __U_BOOT__
 /* Basic theory of signal handling in shell
  * ========================================
  * This does not describe what hush does, rather, it is current understanding
@@ -2077,9 +2071,7 @@ static sighandler_t install_sighandler(int sig, sighandler_t handler)
 	sigaction(sig, &G.sa, &old_sa);
 	return old_sa.sa_handler;
 }
-#endif /* !__U_BOOT__ */
 
-#ifndef __U_BOOT__
 static void hush_exit(int exitcode) NORETURN;
 
 static void restore_ttypgrp_and__exit(void) NORETURN;
@@ -2178,9 +2170,7 @@ static sighandler_t pick_sighandler(unsigned sig)
 	}
 	return handler;
 }
-#endif /* !__U_BOOT__ */
 
-#ifndef __U_BOOT__
 /* Restores tty foreground process group, and exits. */
 static void hush_exit(int exitcode)
 {
@@ -2416,7 +2406,6 @@ static const char* FAST_FUNC get_local_var_value(const char *name)
 	return NULL;
 }
 
-#ifndef __U_BOOT__
 #if ENABLE_HUSH_GETOPTS
 static void handle_changed_special_names(const char *name)
 {
@@ -2429,19 +2418,13 @@ static void handle_changed_special_names(const char *name)
 /* Do not even bother evaluating arguments */
 # define handle_changed_special_names(...) ((void)0)
 #endif
-#else /* __U_BOOT__ */
-/* Do not even bother evaluating arguments */
-# define handle_changed_special_names(...) ((void)0)
-#endif /* __U_BOOT__ */
 
 /* str holds "NAME=VAL" and is expected to be malloced.
  * We take ownership of it.
  */
-#ifndef __U_BOOT__
 #define SETFLAG_EXPORT   (1 << 0)
 #define SETFLAG_UNEXPORT (1 << 1)
 #define SETFLAG_MAKE_RO  (1 << 2)
-#endif /* !__U_BOOT__ */
 #define SETFLAG_VARLVL_SHIFT   3
 #ifndef __U_BOOT__
 static int set_local_var(char *str, unsigned flags)
@@ -2926,11 +2909,7 @@ static void get_user_input(struct in_str *i)
 		G.flag_repeat = 0;
 	clear_ctrlc();
 	G.do_repeat = 0;
-#ifndef __U_BOOT__
-	if (G.promptmode == 1) {
-#else /* __U_BOOT__ */
 	if (!G.promptmode) {
-#endif /* __U_BOOT__ */
 		if (console_buffer[0] == '\n'&& G.flag_repeat == 0) {
 			strcpy(the_command, console_buffer);
 		}
@@ -2950,7 +2929,6 @@ static void get_user_input(struct in_str *i)
 			if (strlen(the_command) + strlen(console_buffer)
 				< CONFIG_SYS_CBSIZE) {
 				n = strlen(the_command);
-#ifdef __U_BOOT__
 				/*
 				 * To avoid writing to bad places, we check if
 				 * n is greater than 0.
@@ -2959,10 +2937,6 @@ static void get_user_input(struct in_str *i)
 				if (n > 0)
 					the_command[n-1] = ' ';
 				strcpy(&the_command[n], console_buffer);
-#else /* !__U_BOOT__ */
-			the_command[n-1] = ' ';
-			strcpy(&the_command[n], console_buffer);
-#endif /* !__U_BOOT__ */
 				}
 				else {
 					the_command[0] = '\n';
@@ -3014,14 +2988,12 @@ static int fgetc_interactive(struct in_str *i)
 	return ch;
 }
 #else  /* !INTERACTIVE */
-#ifndef __U_BOOT__
 static ALWAYS_INLINE int fgetc_interactive(struct in_str *i)
 {
 	int ch;
 	do ch = hfgetc(i->file); while (ch == '\0');
 	return ch;
 }
-#endif /* !__U_BOOT__ */
 #endif  /* !INTERACTIVE */
 
 static int i_getch(struct in_str *i)
@@ -3323,7 +3295,6 @@ static void nommu_addchr(o_string *o, int ch)
 # define nommu_addchr(o, str) ((void)0)
 #endif
 
-#ifndef __U_BOOT__
 #if ENABLE_HUSH_MODE_X
 static void x_mode_addchr(int ch)
 {
@@ -3354,7 +3325,6 @@ static void x_mode_flush(void)
 	G.x_mode_buf.length = 0;
 }
 #endif
-#endif /* !__U_BOOT__ */
 
 /*
  * HUSH_BRACE_EXPANSION code needs corresponding quoting on variable expansion side.
@@ -3975,12 +3945,10 @@ static struct pipe *free_pipe(struct pipe *pi)
 	}
 	free(pi->cmds);   /* children are an array, they get freed all at once */
 	//pi->cmds = NULL;
-#ifndef __U_BOOT__
 #if ENABLE_HUSH_JOB
 	free(pi->cmdtext);
 	//pi->cmdtext = NULL;
 #endif
-#endif /* !__U_BOOT__ */
 
 	next = pi->next;
 	free(pi);
@@ -4834,11 +4802,7 @@ static char *fetch_till_str(o_string *as_string,
 			nommu_addchr(as_string, ch);
 		if (ch == '\n' || ch == EOF) {
  check_heredoc_end:
-#ifndef __U_BOOT__
 			if ((heredoc_flags & HEREDOC_QUOTED) || prev != '\\') {
-#else /* __U_BOOT__ */
-			if (prev != '\\') {
-#endif
 				/* End-of-line, and not a line continuation */
 				if (strcmp(heredoc.data + past_EOL, word) == 0) {
 					heredoc.data[past_EOL] = '\0';
@@ -4858,11 +4822,7 @@ static char *fetch_till_str(o_string *as_string,
 						ch = i_getch(input);
 						if (ch != EOF)
 							nommu_addchr(as_string, ch);
-#ifndef __U_BOOT__
 					} while ((heredoc_flags & HEREDOC_SKIPTABS) && ch == '\t');
-#else /* __U_BOOT__ */
-				} while (ch == '\t');
-#endif
 					/* If this immediately ended the line,
 					 * go back to end-of-line checks.
 					 */
@@ -6913,7 +6873,6 @@ static NOINLINE int encode_then_append_var_plusminus(o_string *output, int n,
 }
 #endif /* !__U_BOOT__ */
 
-#ifndef __U_BOOT__
 #if ENABLE_FEATURE_SH_MATH
 static arith_t expand_and_evaluate_arith(const char *arg, const char **errmsg_p)
 {
@@ -6934,9 +6893,7 @@ static arith_t expand_and_evaluate_arith(const char *arg, const char **errmsg_p)
 	return res;
 }
 #endif
-#endif /* !__U_BOOT__ */
 
-#ifndef __U_BOOT__
 #if BASH_PATTERN_SUBST
 /* ${var/[/]pattern[/repl]} helpers */
 static char *strstr_pattern(char *val, const char *pattern, int *size)
@@ -7009,7 +6966,6 @@ static char *replace_pattern(char *val, const char *pattern, const char *repl, c
 	return result;
 }
 #endif /* BASH_PATTERN_SUBST */
-#endif /* !__U_BOOT__ */
 
 static int append_str_maybe_ifs_split(o_string *output, int n,
 		int first_ch, const char *val)
@@ -7800,9 +7756,7 @@ static void switch_off_special_sigs(unsigned mask)
 		install_sighandler(sig, SIG_DFL);
 	}
 }
-#endif /* !__U_BOOT__ */
 
-#ifndef __U_BOOT__
 #if BB_MMU
 /* never called */
 void re_execute_shell(char ***to_free, const char *s,
@@ -8153,7 +8107,6 @@ void parse_and_run_file(void)
 #endif /* !__U_BOOT__ */
 }
 
-#ifndef __U_BOOT__
 #if ENABLE_HUSH_TICK
 static int generate_stream_from_string(const char *s, pid_t *pid_p)
 {
@@ -8299,6 +8252,7 @@ static int process_command_subs(o_string *dest, const char *s)
 #endif /* ENABLE_HUSH_TICK */
 
 
+#ifndef __U_BOOT__
 static void setup_heredoc(struct redir_struct *redir)
 {
 	struct fd_pair pair;
@@ -8769,9 +8723,7 @@ static const char * FAST_FUNC hush_command_name(int i)
 	return NULL;
 }
 #endif
-#endif /* !__U_BOOT__ */
 
-#ifndef __U_BOOT__
 static void remove_nested_vars(void)
 {
 	struct variable *cur;
@@ -9041,10 +8993,8 @@ static void exec_builtin(char ***to_free,
 			argv);
 #endif
 }
-#endif /* !__U_BOOT__ */
 
 
-#ifndef __U_BOOT__
 static void execvp_or_die(char **argv) NORETURN;
 static void execvp_or_die(char **argv)
 {
@@ -9126,9 +9076,7 @@ static void dump_cmd_in_x_mode(char **argv)
 #else
 # define dump_cmd_in_x_mode(argv) ((void)0)
 #endif
-#endif /* !__U_BOOT__ */
 
-#ifndef __U_BOOT__
 #if ENABLE_HUSH_COMMAND
 static void if_command_vV_print_and_exit(char opt_vV, char *cmd, const char *explanation)
 {
@@ -9154,7 +9102,6 @@ static void if_command_vV_print_and_exit(char opt_vV, char *cmd, const char *exp
 #else
 # define if_command_vV_print_and_exit(a,b,c) ((void)0)
 #endif
-#endif /* !__U_BOOT__ */
 
 #if BB_MMU
 #define pseudo_exec_argv(nommu_save, argv, assignment_cnt, argv_expanded) \
@@ -9163,7 +9110,6 @@ static void if_command_vV_print_and_exit(char opt_vV, char *cmd, const char *exp
 	pseudo_exec(command, argv_expanded)
 #endif
 
-#ifndef __U_BOOT__
 /* Called after [v]fork() in run_pipe, or from builtin_exec.
  * Never returns.
  * Don't exit() here.  If you don't exec, use _exit instead.
@@ -11300,7 +11246,6 @@ int hush_main(int argc, char **argv)
 		}
 	}
 
-#ifndef __U_BOOT__
 	/* -c takes effect *after* -l */
 	if (G.opt_c) {
 		/* Possibilities:
@@ -11377,7 +11322,6 @@ int hush_main(int argc, char **argv)
 	/* "implicit" -s: bare interactive hush shows 's' in $- */
 	G.opt_s = 1;
 
-#endif /* __U_BOOT__ */
 	/* Up to here, shell was non-interactive. Now it may become one.
 	 * NB: don't forget to (re)run install_special_sighandlers() as needed.
 	 */
-- 
2.34.1

