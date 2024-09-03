Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F69FCD37A9
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 17:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 414BE88B68;
	Tue,  3 Sep 2024 19:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dHAWYelw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BAA088C36; Tue,  3 Sep 2024 19:10:13 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A07088646
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 19:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42bbc70caa4so37347285e9.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 10:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1725383411; x=1725988211;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TgmdcYgYRatdmy1jfjSmCulDd0JlSWa77FZrwmdHjkg=;
 b=dHAWYelw/6Ve1oMpm1wIMTC62WMJUR9j2QxN9iIYWJ3wz+VEzJuquwSqDDmEb5ZbdH
 Buehvlh1Ro4rKr1HHa24I4quGTUJRmlrc8j6u5ic0lrEpFDtTLirD8a6dzChK86Q1Kqc
 jm4VQ7rUD9unkSHECHQMrlau8f+TJHuu1SFw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725383411; x=1725988211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TgmdcYgYRatdmy1jfjSmCulDd0JlSWa77FZrwmdHjkg=;
 b=t7oY+j+M9OSqQSHdPGS7ML+7w4YG1WXrtB25k2UWaT6cw4CqTkAkPCZ7GDy620ouev
 vQ67l1owFyIa7ubSvjqHTbVZN/FlsxebL3Z2yt3+Ji9H1hgMv8upMDtkV7xQ1n+x4eK5
 /tQ/C1dYQ2iiUEnqAE0khj+yCkGKrpGIkz58ekKlpqng2trHMBjBfMJEuP4a40huc7Ky
 HMgVODLScuU4ALbdIJ9jhfnrj6ullo9qkYqm9EtRTRH2YxQgg9e53Xw2T/CfFKHIu1Mm
 prY45Pvm9D0ChltfBiI7HquyrKQJb2RFfUhLlEIvSHEh3nr8FdXJdUuwRFqFW438N5WG
 FDAA==
X-Gm-Message-State: AOJu0YzFW8BZYATt6TERKT0F0uRMI0B6YwLULLbhcurkDx3UrLJOc6hM
 L840BTpvFzjJWijHuvLOOqLHq5wXF28fQmWrhnaBO4PVzGqthyG360X2mCZxVE3Va1/nHlyAQbf
 k
X-Google-Smtp-Source: AGHT+IGC7NWgCAnrTb3T+PeOD0iP7ZeCnpBXvgJAzdGYDBf44U5/BIElxzDlizsUKAG/PB3UDMsh6Q==
X-Received: by 2002:a05:600c:3b22:b0:428:2502:75b5 with SMTP id
 5b1f17b1804b1-42c8de79fefmr11353125e9.11.1725383410511; 
 Tue, 03 Sep 2024 10:10:10 -0700 (PDT)
Received: from pwmachine.numericable.fr
 (2a02-8429-e2c2-8d01-f9a2-0489-9dd5-0071.rev.sfr.net.
 [2a02:8429:e2c2:8d01:f9a2:489:9dd5:71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bbd1eee1bsm146364975e9.9.2024.09.03.10.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 10:10:10 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Harald Seiler <hws@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 2/2] cli: modern_hush: Add upstream commits up to 13 July 2024
Date: Tue,  3 Sep 2024 19:09:43 +0200
Message-Id: <20240903170944.98747-3-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903170944.98747-1-francis.laniel@amarulasolutions.com>
References: <20240903170944.98747-1-francis.laniel@amarulasolutions.com>
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

This commit adds the following hush busybox upstream commits:
23da5c4b716b ("hush: do not exit interactive shell on some redirection errors")
14e28c18ca1a ("hush: fix "exec 3>FILE" aborting if 3 is exactly the next free fd")
6c38d0e9da2d ("hush: avoid duplicate fcntl(F_SETFD, FD_CLOEXEC) during init")
758b21402abc ("hush: detect when terminating "done"/"fi" is missing")
2639f3bc72ac ("hush: set G.ifs sooner (prevents segfault)")

Adding specific ifdef and endif guard was needed for 2639f3bc72ac.

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 common/cli_hush_modern.c   |   2 +-
 common/cli_hush_upstream.c | 150 ++++++++++++++++++++++++-------------
 2 files changed, 98 insertions(+), 54 deletions(-)

diff --git a/common/cli_hush_modern.c b/common/cli_hush_modern.c
index cd88c9de8ab..deb61c3389d 100644
--- a/common/cli_hush_modern.c
+++ b/common/cli_hush_modern.c
@@ -25,7 +25,7 @@
 /*
  * BusyBox Version: UPDATE THIS WHEN PULLING NEW UPSTREAM REVISION!
  */
-#define BB_VER			"1.35.0.git7d1c7d833785"
+#define BB_VER			"1.37.0.git23da5c4b716b"

 /*
  * Define hush features by the names used upstream.
diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index 7874b399d14..ab5aa5f9b36 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -1651,12 +1651,22 @@ static int dup_CLOEXEC(int fd, int avoid_fd)
 	newfd = fcntl(fd, F_DUPFD_CLOEXEC, avoid_fd + 1);
 	if (newfd >= 0) {
 		if (F_DUPFD_CLOEXEC == F_DUPFD) /* if old libc (w/o F_DUPFD_CLOEXEC) */
-			fcntl(newfd, F_SETFD, FD_CLOEXEC);
+			close_on_exec_on(newfd);
 	} else { /* newfd < 0 */
 		if (errno == EBUSY)
 			goto repeat;
 		if (errno == EINTR)
 			goto repeat;
+		if (errno != EBADF) {
+			/* "echo >&9999" gets EINVAL trying to save fd 1 to above 9999.
+			 * We could try saving it _below_ 9999 instead (how?), but
+			 * this probably means that dup2(9999,1) to effectuate >&9999
+			 * would also not work: fd 9999 can't exist.
+			 * (This differs from "echo >&99" where saving works, but
+			 * subsequent dup2(99,1) fails if fd 99 is not open).
+			 */
+			bb_perror_msg("fcntl(%d,F_DUPFD,%d)", fd, avoid_fd + 1);
+		}
 	}
 	return newfd;
 }
@@ -1677,7 +1687,7 @@ static int xdup_CLOEXEC_and_close(int fd, int avoid_fd)
 		xfunc_die();
 	}
 	if (F_DUPFD_CLOEXEC == F_DUPFD) /* if old libc (w/o F_DUPFD_CLOEXEC) */
-		fcntl(newfd, F_SETFD, FD_CLOEXEC);
+		close_on_exec_on(newfd);
 	close(fd);
 	return newfd;
 }
@@ -5851,6 +5861,15 @@ static struct pipe *parse_stream(char **pstring,
 			}
 			o_free_and_set_NULL(&ctx.word);
 			done_pipe(&ctx, PIPE_SEQ);
+
+			/* Do we sit inside of any if's, loops or case's? */
+			if (HAS_KEYWORDS
+			IF_HAS_KEYWORDS(&& (ctx.ctx_res_w != RES_NONE || ctx.old_flag != 0))
+			) {
+				syntax_error_unterm_str("compound statement");
+				goto parse_error_exitcode1;
+			}
+
 			pi = ctx.list_head;
 			/* If we got nothing... */
 			/* (this makes bare "&" cmd a no-op.
@@ -5873,7 +5892,7 @@ static struct pipe *parse_stream(char **pstring,
 			//	*heredoc_cnt_ptr = heredoc_cnt;
 			debug_leave();
 			debug_printf_heredoc("parse_stream return heredoc_cnt:%d\n", heredoc_cnt);
-			debug_printf_parse("parse_stream return %p\n", pi);
+			debug_printf_parse("parse_stream return %p: EOF\n", pi);
 			return pi;
 		}

@@ -8384,10 +8403,16 @@ static struct squirrel *add_squirrel(struct squirrel *sq, int fd, int avoid_fd)
 	if (sq) for (; sq[i].orig_fd >= 0; i++) {
 		/* If we collide with an already moved fd... */
 		if (fd == sq[i].moved_to) {
-			sq[i].moved_to = dup_CLOEXEC(sq[i].moved_to, avoid_fd);
-			debug_printf_redir("redirect_fd %d: already busy, moving to %d\n", fd, sq[i].moved_to);
-			if (sq[i].moved_to < 0) /* what? */
-				xfunc_die();
+			moved_to = dup_CLOEXEC(sq[i].moved_to, avoid_fd);
+			debug_printf_redir("redirect_fd %d: already busy, moving to %d\n", fd, moved_to);
+			if (moved_to < 0) {
+				/* "echo 2>/dev/tty 10>&9999" testcase:
+				 * We move fd 2 to 10, then discover we need to move fd 10
+				 * (and not hit 9999) and the latter fails.
+				 */
+				return NULL; /* fcntl failed */
+			}
+			sq[i].moved_to = moved_to;
 			return sq;
 		}
 		if (fd == sq[i].orig_fd) {
@@ -8401,7 +8426,7 @@ static struct squirrel *add_squirrel(struct squirrel *sq, int fd, int avoid_fd)
 	moved_to = dup_CLOEXEC(fd, avoid_fd);
 	debug_printf_redir("redirect_fd %d: previous fd is moved to %d (-1 if it was closed)\n", fd, moved_to);
 	if (moved_to < 0 && errno != EBADF)
-		xfunc_die();
+		return NULL; /* fcntl failed (not because fd is closed) */
 	return append_squirrel(sq, i, fd, moved_to);
 }

@@ -8434,6 +8459,8 @@ static struct squirrel *add_squirrel_closed(struct squirrel *sq, int fd)
  */
 static int save_fd_on_redirect(int fd, int avoid_fd, struct squirrel **sqp)
 {
+	struct squirrel *new_squirrel;
+
 	if (avoid_fd < 9) /* the important case here is that it can be -1 */
 		avoid_fd = 9;

@@ -8497,7 +8524,10 @@ static int save_fd_on_redirect(int fd, int avoid_fd, struct squirrel **sqp)
 	}

 	/* Check whether it collides with any open fds (e.g. stdio), save fds as needed */
-	*sqp = add_squirrel(*sqp, fd, avoid_fd);
+	new_squirrel = add_squirrel(*sqp, fd, avoid_fd);
+	if (!new_squirrel)
+		return -1; /* redirect error */
+	*sqp = new_squirrel;
 	return 0; /* "we did not close fd" */
 }

@@ -8568,8 +8598,11 @@ static int internally_opened_fd(int fd, struct squirrel *sq)
 	return 0;
 }

-/* squirrel != NULL means we squirrel away copies of stdin, stdout,
- * and stderr if they are redirected. */
+/* sqp != NULL means we squirrel away copies of stdin, stdout,
+ * and stderr if they are redirected.
+ * If redirection fails, return 1. This will make caller
+ * skip command execution and restore already created redirect fds.
+ */
 static int setup_redirects(struct command *prog, struct squirrel **sqp)
 {
 	struct redir_struct *redir;
@@ -8580,7 +8613,8 @@ static int setup_redirects(struct command *prog, struct squirrel **sqp)

 		if (redir->rd_type == REDIRECT_HEREDOC2) {
 			/* "rd_fd<<HERE" case */
-			save_fd_on_redirect(redir->rd_fd, /*avoid:*/ 0, sqp);
+			if (save_fd_on_redirect(redir->rd_fd, /*avoid:*/ 0, sqp) < 0)
+				return 1;
 			/* for REDIRECT_HEREDOC2, rd_filename holds _contents_
 			 * of the heredoc */
 			debug_printf_redir("set heredoc '%s'\n",
@@ -8600,7 +8634,7 @@ static int setup_redirects(struct command *prog, struct squirrel **sqp)
 				 * "cmd > <file" (2nd redirect starts too early)
 				 */
 				syntax_error("invalid redirect");
-				continue;
+				return 1;
 			}
 			mode = redir_table[redir->rd_type].mode;
 			p = expand_string_to_string(redir->rd_filename,
@@ -8615,7 +8649,9 @@ static int setup_redirects(struct command *prog, struct squirrel **sqp)
 				 */
 				return 1;
 			}
-			if (newfd == redir->rd_fd && sqp) {
+			if (newfd == redir->rd_fd && sqp
+			 && sqp != ERR_PTR /* not a redirect in "exec" */
+			) {
 				/* open() gave us precisely the fd we wanted.
 				 * This means that this fd was not busy
 				 * (not opened to anywhere).
@@ -8637,6 +8673,8 @@ static int setup_redirects(struct command *prog, struct squirrel **sqp)
 		/* if "N>&-": close redir->rd_fd (newfd is REDIRFD_CLOSE) */

 		closed = save_fd_on_redirect(redir->rd_fd, /*avoid:*/ newfd, sqp);
+		if (closed < 0)
+			return 1; /* error */
 		if (newfd == REDIRFD_CLOSE) {
 			/* "N>&-" means "close me" */
 			if (!closed) {
@@ -8650,13 +8688,16 @@ static int setup_redirects(struct command *prog, struct squirrel **sqp)
 			 * and second redirect closes 3! Restore code then closes 3 again.
 			 */
 		} else {
-			/* if newfd is a script fd or saved fd, simulate EBADF */
+			/* if newfd is a script fd or saved fd, do not allow to use it */
 			if (internally_opened_fd(newfd, sqp && sqp != ERR_PTR ? *sqp : NULL)) {
-				//errno = EBADF;
-				//bb_perror_msg_and_die("can't duplicate file descriptor");
-				newfd = -1; /* same effect as code above */
+				bb_error_msg("fd#%d is not open", newfd);
+				return 1;
+			}
+			if (dup2(newfd, redir->rd_fd) < 0) {
+				/* "echo >&99" testcase */
+				bb_perror_msg("dup2(%d,%d)", newfd, redir->rd_fd);
+				return 1;
 			}
-			xdup2(newfd, redir->rd_fd);
 			if (redir->rd_dup == REDIRFD_TO_FILE)
 				/* "rd_fd > FILE" */
 				close(newfd);
@@ -9731,6 +9772,7 @@ static int checkjobs_and_fg_shell(struct pipe *fg_pipe)
 	return rcode;
 }
 #endif
+#endif /* !__U_BOOT__ */

 /* Start all the jobs, but don't wait for anything to finish.
  * See checkjobs().
@@ -9758,6 +9800,38 @@ static int checkjobs_and_fg_shell(struct pipe *fg_pipe)
  * backgrounded: cmd &     { list } &
  * subshell:     ( list ) [&]
  */
+static void set_G_ifs(void)
+{
+	/* Testcase: set -- q w e; (IFS='' echo "$*"; IFS=''; echo "$*"); echo "$*"
+	 * Result should be 3 lines: q w e, qwe, q w e
+	 */
+	if (G.ifs_whitespace != G.ifs)
+		free(G.ifs_whitespace);
+	G.ifs = get_local_var_value("IFS");
+	if (G.ifs) {
+		char *p;
+		G.ifs_whitespace = (char*)G.ifs;
+		p = skip_whitespace(G.ifs);
+		if (*p) {
+			/* Not all $IFS is whitespace */
+			char *d;
+			int len = p - G.ifs;
+			p = skip_non_whitespace(p);
+			G.ifs_whitespace = xmalloc(len + strlen(p) + 1); /* can overestimate */
+			d = mempcpy(G.ifs_whitespace, G.ifs, len);
+			while (*p) {
+				if (isspace(*p))
+					*d++ = *p;
+				p++;
+			}
+			*d = '\0';
+		}
+	} else {
+		G.ifs = defifs;
+		G.ifs_whitespace = (char*)G.ifs;
+	}
+}
+#ifndef __U_BOOT__
 #if !ENABLE_HUSH_MODE_X
 #define redirect_and_varexp_helper(command, sqp, argv_expanded) \
 	redirect_and_varexp_helper(command, sqp)
@@ -9810,34 +9884,7 @@ static NOINLINE int run_pipe(struct pipe *pi)
 	debug_printf_exec("run_pipe start: members:%d\n", pi->num_cmds);
 	debug_enter();

-	/* Testcase: set -- q w e; (IFS='' echo "$*"; IFS=''; echo "$*"); echo "$*"
-	 * Result should be 3 lines: q w e, qwe, q w e
-	 */
-	if (G.ifs_whitespace != G.ifs)
-		free(G.ifs_whitespace);
-	G.ifs = get_local_var_value("IFS");
-	if (G.ifs) {
-		char *p;
-		G.ifs_whitespace = (char*)G.ifs;
-		p = skip_whitespace(G.ifs);
-		if (*p) {
-			/* Not all $IFS is whitespace */
-			char *d;
-			int len = p - G.ifs;
-			p = skip_non_whitespace(p);
-			G.ifs_whitespace = xmalloc(len + strlen(p) + 1); /* can overestimate */
-			d = mempcpy(G.ifs_whitespace, G.ifs, len);
-			while (*p) {
-				if (isspace(*p))
-					*d++ = *p;
-				p++;
-			}
-			*d = '\0';
-		}
-	} else {
-		G.ifs = defifs;
-		G.ifs_whitespace = (char*)G.ifs;
-	}
+	set_G_ifs();

 #ifndef __U_BOOT__
 	IF_HUSH_JOB(pi->pgrp = -1;)
@@ -10362,6 +10409,8 @@ static int run_list(struct pipe *pi)
 	debug_enter();
 #endif /* !__U_BOOT__ */

+	set_G_ifs();
+
 #if ENABLE_HUSH_LOOPS
 	/* Check syntax for "for" */
 	{
@@ -11377,7 +11426,7 @@ int hush_main(int argc, char **argv)
 		G_interactive_fd = dup_CLOEXEC(STDIN_FILENO, 254);
 		if (G_interactive_fd < 0) {
 			/* try to dup to any fd */
-			G_interactive_fd = dup(STDIN_FILENO);
+			G_interactive_fd = dup_CLOEXEC(STDIN_FILENO, -1);
 			if (G_interactive_fd < 0) {
 				/* give up */
 				G_interactive_fd = 0;
@@ -11387,8 +11436,6 @@ int hush_main(int argc, char **argv)
 	}
 	debug_printf("interactive_fd:%d\n", G_interactive_fd);
 	if (G_interactive_fd) {
-		close_on_exec_on(G_interactive_fd);
-
 		if (G_saved_tty_pgrp) {
 			/* If we were run as 'hush &', sleep until we are
 			 * in the foreground (tty pgrp == our pgrp).
@@ -11463,9 +11510,6 @@ int hush_main(int argc, char **argv)
 				G_interactive_fd = 0;
 		}
 	}
-	if (G_interactive_fd) {
-		close_on_exec_on(G_interactive_fd);
-	}
 	install_special_sighandlers();
 #else
 	/* We have interactiveness code disabled */
--
2.34.1

