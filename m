Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99000C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 22:32:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92DFA876A5;
	Fri,  8 Dec 2023 23:31:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BspEus1f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46CA5876B5; Fri,  8 Dec 2023 23:31:10 +0100 (CET)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2B268768A
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 23:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-3332fc9b9b2so2397090f8f.1
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 14:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702074665; x=1702679465;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eg3G4VV2vxelZufKKzQ7J9plUKedoGU/EdQlbFDcRU=;
 b=BspEus1fQ320M9EzZ+vM6qEuBOZ/Bf9G2oUkjRt98Dk2eFi1vqUWT+wlFXrw3ShQAn
 od59u958yNHZGVWKkcpTHYUyxVyVtQbQEx+1XxCmNerhU0hSv67cTTPDyDb0zPX1RaVb
 mCczrgJDOrQybQYv7EzL2UEGHvy/y0A5RUR1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702074665; x=1702679465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5eg3G4VV2vxelZufKKzQ7J9plUKedoGU/EdQlbFDcRU=;
 b=c/+iE6oedU5CeFIQw0GhMoAOfopVNIiBd4JZZP/KbgmBQrXPNGKseJZdwoq7+RC3MN
 B5yCxH6LhxUyHlTLWO434sqX0Mc/rRGvHAVVG/Zu5INyUpdkWp+kJO7c4kGkKRY4ByM8
 y1vCykbl5kl4kRAq9fnH9lC8N6WO3WQ2n42Iid8sYhUXIqjFEowcIyQ3HQbgrmFcGZ8E
 Retmz7SjPXL1s+ziJBxta5KTa3zke4BgAuCZryV1S/C+W/WewjC6cl3N6cDbsTOg+1L4
 EBcaxRJXBUO1I+Qlnrg2OIj70IgL+Yeen++X7CudwsxhPdy8SGP0HbxEV+2NsTN+x1+t
 5T4w==
X-Gm-Message-State: AOJu0Ywr0ywrLjyUnwNbNqFUVJ+UwZRELUyLE2PMNvN0JUsZ1CYqnSFP
 eJLMXG8BLeD/FI/6vw/aVTVEBBSR8ggDtc5C8+wTZBe1
X-Google-Smtp-Source: AGHT+IEP5VRI7SK0JSA1yFCw7JWxWV0GHq+LxD2W3s55CRyiJkUER9nYlhjhBBkITrET+7WxhLzrTA==
X-Received: by 2002:a05:600c:4d0e:b0:40b:5e22:2d5 with SMTP id
 u14-20020a05600c4d0e00b0040b5e2202d5mr166949wmp.65.1702074664876; 
 Fri, 08 Dec 2023 14:31:04 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c350b00b0040b4cb14d40sm6357863wmq.19.2023.12.08.14.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 14:31:04 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v12 08/24] cli: Port upstream Busybox hush to U-Boot
Date: Fri,  8 Dec 2023 23:30:09 +0100
Message-Id: <20231208223025.55076-9-francis.laniel@amarulasolutions.com>
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

Adds new file cli_hush_upstream.c, it is a copy of Busybox hush file as it was of
time to commit 37460f5da.
This commit modifies Busybox hush to not compile some part specific to Busybox
and adds some code needed by U-Boot.
The modifications consists mainly on adding code #if(n)def guards.

For the moment, this refurbished flavor of hush only permits running command
without any keywords (i.e., if and for are not recognized) or variable expansion
(i.e., echo $foo prints foo and not value stored in variable foo).

A new file was also added to define some functions specific to U-Boot.

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
Signed-off-by: Harald Seiler <hws@denx.de>
---
 common/cli_hush_modern.c   | 274 ++++++++++++++++++++
 common/cli_hush_upstream.c | 502 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 774 insertions(+), 2 deletions(-)
 create mode 100644 common/cli_hush_modern.c

diff --git a/common/cli_hush_modern.c b/common/cli_hush_modern.c
new file mode 100644
index 0000000000..34278fdca2
--- /dev/null
+++ b/common/cli_hush_modern.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * This file defines the compilation unit for the new hush shell version.  The
+ * actual implementation from upstream BusyBox can be found in
+ * `cli_hush_upstream.c` which is included at the end of this file.
+ *
+ * This "wrapper" technique is used to keep the changes to the upstream version
+ * as minmal as possible.  Instead, all defines and redefines necessary are done
+ * here, outside the upstream sources.  This will hopefully make upgrades to
+ * newer revisions much easier.
+ *
+ * Copyright (c) 2021, Harald Seiler, DENX Software Engineering, hws@denx.de
+ */
+
+#include <common.h>         /* readline */
+#include <env.h>
+#include <malloc.h>         /* malloc, free, realloc*/
+#include <linux/ctype.h>    /* isalpha, isdigit */
+#include <console.h>
+#include <bootretry.h>
+#include <cli.h>
+#include <cli_hush.h>
+#include <command.h>        /* find_cmd */
+#include <asm/global_data.h>
+
+/*
+ * BusyBox Version: UPDATE THIS WHEN PULLING NEW UPSTREAM REVISION!
+ */
+#define BB_VER			"1.34.0.git37460f5daff9"
+
+/*
+ * Define hush features by the names used upstream.
+ */
+#define ENABLE_HUSH_INTERACTIVE	1
+#define ENABLE_FEATURE_EDITING	1
+/* No MMU in U-Boot */
+#define BB_MMU			0
+#define USE_FOR_NOMMU(...)	__VA_ARGS__
+#define USE_FOR_MMU(...)
+
+/*
+ * Size-saving "small" ints (arch-dependent)
+ */
+#if CONFIG_IS_ENABLED(X86) || CONFIG_IS_ENABLED(X86_64) || CONFIG_IS_ENABLED(MIPS)
+/* add other arches which benefit from this... */
+typedef signed char smallint;
+typedef unsigned char smalluint;
+#else
+/* for arches where byte accesses generate larger code: */
+typedef int smallint;
+typedef unsigned smalluint;
+#endif
+
+/*
+ * Alignment defines used by BusyBox.
+ */
+#define ALIGN1			__attribute__((aligned(1)))
+#define ALIGN2			__attribute__((aligned(2)))
+#define ALIGN4			__attribute__((aligned(4)))
+#define ALIGN8			__attribute__((aligned(8)))
+#define ALIGN_PTR		__attribute__((aligned(sizeof(void*))))
+
+/*
+ * Miscellaneous compiler/platform defines.
+ */
+#define FAST_FUNC /* not used in U-Boot */
+#define UNUSED_PARAM		__always_unused
+#define ALWAYS_INLINE		__always_inline
+#define NOINLINE		noinline
+
+/*
+ * Defines to provide equivalents to what libc/BusyBox defines.
+ */
+#define EOF			(-1)
+#define EXIT_SUCCESS		0
+#define EXIT_FAILURE		1
+
+/*
+ * Stubs to provide libc/BusyBox functions based on U-Boot equivalents where it
+ * makes sense.
+ */
+#define utoa			simple_itoa
+
+static void __noreturn xfunc_die(void)
+{
+	panic("HUSH died!");
+}
+
+#define bb_error_msg_and_die(format, ...) do { \
+panic("HUSH: " format, __VA_ARGS__); \
+} while (0);
+
+#define bb_simple_error_msg_and_die(msg) do { \
+panic_str("HUSH: " msg); \
+} while (0);
+
+/* fdprintf() is used for debug output. */
+static int __maybe_unused fdprintf(int fd, const char *format, ...)
+{
+	va_list args;
+	uint i;
+
+	assert(fd == 2);
+
+	va_start(args, format);
+	i = vprintf(format, args);
+	va_end(args);
+
+	return i;
+}
+
+static void bb_verror_msg(const char *s, va_list p, const char* strerr)
+{
+	/* TODO: what to do with strerr arg? */
+	vprintf(s, p);
+}
+
+static void bb_error_msg(const char *s, ...)
+{
+	va_list p;
+
+	va_start(p, s);
+	bb_verror_msg(s, p, NULL);
+	va_end(p);
+}
+
+static void *xmalloc(size_t size)
+{
+	void *p = NULL;
+	if (!(p = malloc(size)))
+		panic("out of memory");
+	return p;
+}
+
+static void *xzalloc(size_t size)
+{
+	void *p = xmalloc(size);
+	memset(p, 0, size);
+	return p;
+}
+
+static void *xrealloc(void *ptr, size_t size)
+{
+	void *p = NULL;
+	if (!(p = realloc(ptr, size)))
+		panic("out of memory");
+	return p;
+}
+
+#define xstrdup		strdup
+#define xstrndup	strndup
+
+static void *mempcpy(void *dest, const void *src, size_t len)
+{
+	return memcpy(dest, src, len) + len;
+}
+
+/* Like strcpy but can copy overlapping strings. */
+static void overlapping_strcpy(char *dst, const char *src)
+{
+	/*
+	 * Cheap optimization for dst == src case -
+	 * better to have it here than in many callers.
+	 */
+	if (dst != src) {
+		while ((*dst = *src) != '\0') {
+			dst++;
+			src++;
+		}
+	}
+}
+
+static char* skip_whitespace(const char *s)
+{
+	/*
+	 * In POSIX/C locale (the only locale we care about: do we REALLY want
+	 * to allow Unicode whitespace in, say, .conf files? nuts!)
+	 * isspace is only these chars: "\t\n\v\f\r" and space.
+	 * "\t\n\v\f\r" happen to have ASCII codes 9,10,11,12,13.
+	 * Use that.
+	 */
+	while (*s == ' ' || (unsigned char)(*s - 9) <= (13 - 9))
+		s++;
+
+	return (char *) s;
+}
+
+static char* skip_non_whitespace(const char *s)
+{
+	while (*s != '\0' && *s != ' ' && (unsigned char)(*s - 9) > (13 - 9))
+		s++;
+
+	return (char *) s;
+}
+
+#define is_name(c)	((c) == '_' || isalpha((unsigned char)(c)))
+#define is_in_name(c)	((c) == '_' || isalnum((unsigned char)(c)))
+
+static const char* endofname(const char *name)
+{
+	if (!is_name(*name))
+		return name;
+	while (*++name) {
+		if (!is_in_name(*name))
+			break;
+	}
+	return name;
+}
+
+struct in_str;
+static int u_boot_cli_readline(struct in_str *i);
+
+struct in_str;
+static int u_boot_cli_readline(struct in_str *i);
+
+/*
+ * BusyBox globals which are needed for hush.
+ */
+static uint8_t xfunc_error_retval;
+
+static const char defifsvar[] __aligned(1) = "IFS= \t\n";
+#define defifs (defifsvar + 4)
+
+/*
+ * This define is used for changes that need be done directly in the upstream
+ * sources still. Ideally, its use should be minimized as much as possible.
+ */
+#define __U_BOOT__
+
+/*
+ *
+ * +-- Include of the upstream sources --+ *
+ * V                                     V
+ */
+#include "cli_hush_upstream.c"
+/*
+ * A                                     A
+ * +-- Include of the upstream sources --+ *
+ *
+ */
+
+int u_boot_hush_start_modern(void)
+{
+	INIT_G();
+	return 0;
+}
+
+static int u_boot_cli_readline(struct in_str *i)
+{
+	char *prompt;
+	char __maybe_unused *ps_prompt = NULL;
+
+	if (!G.promptmode)
+		prompt = CONFIG_SYS_PROMPT;
+#ifdef CONFIG_SYS_PROMPT_HUSH_PS2
+	else
+		prompt = CONFIG_SYS_PROMPT_HUSH_PS2;
+#else
+	/* TODO: default value? */
+	#error "SYS_PROMPT_HUSH_PS2 is not defined!"
+#endif
+
+	if (CONFIG_IS_ENABLED(CMDLINE_PS_SUPPORT)) {
+		if (!G.promptmode)
+			ps_prompt = env_get("PS1");
+		else
+			ps_prompt = env_get("PS2");
+
+		if (ps_prompt)
+			prompt = ps_prompt;
+	}
+
+	return cli_readline(prompt);
+}
diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index c970d9097e..3f2e4a5495 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -343,6 +343,7 @@
 //usage:#define hush_full_usage "\n\n"
 //usage:	"Unix shell interpreter"
 
+#ifndef __U_BOOT__
 #if !(defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) \
 	|| defined(__APPLE__) \
     )
@@ -378,6 +379,7 @@
 #else
 # define NUM_SCRIPTS 0
 #endif
+#endif /* !__U_BOOT__ */
 
 /* So far, all bash compat is controlled by one config option */
 /* Separate defines document which part of code implements what */
@@ -421,10 +423,10 @@
 # define USE_FOR_MMU(...)
 #endif
 
+#ifndef __U_BOOT__
 #include "NUM_APPLETS.h"
 #if NUM_APPLETS == 1
 /* STANDALONE does not make sense, and won't compile */
-# undef CONFIG_FEATURE_SH_STANDALONE
 # undef ENABLE_FEATURE_SH_STANDALONE
 # undef IF_FEATURE_SH_STANDALONE
 # undef IF_NOT_FEATURE_SH_STANDALONE
@@ -432,6 +434,7 @@
 # define IF_FEATURE_SH_STANDALONE(...)
 # define IF_NOT_FEATURE_SH_STANDALONE(...) __VA_ARGS__
 #endif
+#endif /* __U_BOOT__ */
 
 #if !ENABLE_HUSH_INTERACTIVE
 # undef ENABLE_FEATURE_EDITING
@@ -477,8 +480,13 @@
 #define JOB_STATUS_FORMAT    "[%u] %-22s %.40s\n"
 
 #define _SPECIAL_VARS_STR     "_*@$!?#-"
+#ifndef __U_BOOT__
 #define SPECIAL_VARS_STR     ("_*@$!?#-" + 1)
 #define NUMERIC_SPECVARS_STR ("_*@$!?#-" + 3)
+#else /* __U_BOOT__ */
+#define SPECIAL_VARS_STR     "*@$!?#-"
+#define NUMERIC_SPECVARS_STR "$!?#-"
+#endif /* __U_BOOT__ */
 #if BASH_PATTERN_SUBST
 /* Support / and // replace ops */
 /* Note that // is stored as \ in "encoded" string representation */
@@ -511,6 +519,7 @@ typedef struct nommu_save_t {
 } nommu_save_t;
 #endif
 
+
 enum {
 	RES_NONE  = 0,
 #if ENABLE_HUSH_IF
@@ -594,6 +603,7 @@ typedef struct in_str {
 	HFILE *file;
 } in_str;
 
+#ifndef __U_BOOT__
 /* The descrip member of this structure is only used to make
  * debugging output pretty */
 static const struct {
@@ -640,9 +650,12 @@ typedef enum redir_type {
 	HEREDOC_QUOTED   = 2,
 } redir_type;
 
+#endif /* !__U_BOOT__ */
 
 struct command {
+#ifndef __U_BOOT__
 	pid_t pid;                  /* 0 if exited */
+#endif /* !__U_BOOT__ */
 	unsigned assignment_cnt;    /* how many argv[i] are assignments? */
 #if ENABLE_HUSH_LINENO_VAR
 	unsigned lineno;
@@ -684,6 +697,9 @@ struct command {
  * When command is freed, it severs the link
  * (sets ->child_func->parent_cmd to NULL).
  */
+#endif
+#ifdef __U_BOOT__
+	int argc; /* number of program arguments */
 #endif
 	char **argv;                /* command name and arguments */
 /* argv vector may contain variable references (^Cvar^C, ^C0^C etc)
@@ -692,15 +708,23 @@ struct command {
  * Example: argv[0]=='.^C*^C.' here: echo .$*.
  * References of the form ^C`cmd arg^C are `cmd arg` substitutions.
  */
+#ifndef __U_BOOT__
 	struct redir_struct *redirects; /* I/O redirections */
+#endif /* !__U_BOOT__ */
 };
 /* Is there anything in this command at all? */
+#ifndef __U_BOOT__
 #define IS_NULL_CMD(cmd) \
 	(!(cmd)->group && !(cmd)->argv && !(cmd)->redirects)
 
+#else /* __U_BOOT__ */
+#define IS_NULL_CMD(cmd) \
+	(!(cmd)->group && !(cmd)->argv)
+#endif /* __U_BOOT__ */
 struct pipe {
 	struct pipe *next;
 	int num_cmds;               /* total number of commands in pipe */
+#ifndef __U_BOOT__
 	int alive_cmds;             /* number of commands running (not exited) */
 	int stopped_cmds;           /* number of commands alive, but stopped */
 #if ENABLE_HUSH_JOB
@@ -708,6 +732,7 @@ struct pipe {
 	pid_t pgrp;                 /* process group ID for the job */
 	char *cmdtext;              /* name of job */
 #endif
+#endif /* !__U_BOOT__ */
 	struct command *cmds;       /* array of commands in pipe */
 	smallint followup;          /* PIPE_BG, PIPE_SEQ, PIPE_OR, PIPE_AND */
 	IF_HAS_KEYWORDS(smallint pi_inverted;) /* "! cmd | cmd" */
@@ -731,8 +756,10 @@ struct parse_context {
 	struct pipe *pipe;
 	/* last command in pipe (being constructed right now) */
 	struct command *command;
+#ifndef __U_BOOT__
 	/* last redirect in command->redirects list */
 	struct redir_struct *pending_redirect;
+#endif /* !__U_BOOT__ */
 	o_string word;
 #if !BB_MMU
 	o_string as_string;
@@ -766,19 +793,23 @@ enum {
 	WORD_IS_KEYWORD       = 3,
 };
 
+#ifndef __U_BOOT__
 /* On program start, environ points to initial environment.
  * putenv adds new pointers into it, unsetenv removes them.
  * Neither of these (de)allocates the strings.
  * setenv allocates new strings in malloc space and does putenv,
  * and thus setenv is unusable (leaky) for shell's purposes */
 #define setenv(...) setenv_is_leaky_dont_use()
+#endif /* !__U_BOOT__ */
 struct variable {
 	struct variable *next;
 	char *varstr;        /* points to "name=" portion */
 	int max_len;         /* if > 0, name is part of initial env; else name is malloced */
+#ifndef __U_BOOT__
 	uint16_t var_nest_level;
 	smallint flg_export; /* putenv should be done on this var */
 	smallint flg_read_only;
+#endif /* !__U_BOOT__ */
 };
 
 enum {
@@ -850,6 +881,7 @@ enum {
 /* "Globals" within this file */
 /* Sorted roughly by size (smaller offsets == smaller code) */
 struct globals {
+#ifndef __U_BOOT__
 	/* interactive_fd != 0 means we are an interactive shell.
 	 * If we are, then saved_tty_pgrp can also be != 0, meaning
 	 * that controlling tty is available. With saved_tty_pgrp == 0,
@@ -870,6 +902,10 @@ struct globals {
 #else
 # define G_interactive_fd 0
 #endif
+#else /* __U_BOOT__ */
+# define G_interactive_fd 0
+#endif /* __U_BOOT__ */
+#ifndef __U_BOOT__
 #if ENABLE_FEATURE_EDITING
 	line_input_t *line_input_state;
 #endif
@@ -888,8 +924,10 @@ struct globals {
 #else
 # define G_saved_tty_pgrp 0
 #endif
+#endif /* !__U_BOOT__ */
 	/* How deeply are we in context where "set -e" is ignored */
 	int errexit_depth;
+#ifndef __U_BOOT__
 	/* "set -e" rules (do we follow them correctly?):
 	 * Exit if pipe, list, or compound command exits with a non-zero status.
 	 * Shell does not exit if failed command is part of condition in
@@ -915,13 +953,16 @@ struct globals {
 #endif
 	char opt_s;
 	char opt_c;
+#endif /* !__U_BOOT__ */
 #if ENABLE_HUSH_INTERACTIVE
 	smallint promptmode; /* 0: PS1, 1: PS2 */
 #endif
 	smallint flag_SIGINT;
+#ifndef __U_BOOT__
 #if ENABLE_HUSH_LOOPS
 	smallint flag_break_continue;
 #endif
+#endif /* !__U_BOOT__ */
 #if ENABLE_HUSH_FUNCTIONS
 	/* 0: outside of a function (or sourced file)
 	 * -1: inside of a function, ok to use return builtin
@@ -937,6 +978,7 @@ struct globals {
 	smalluint last_exitcode;
 	smalluint expand_exitcode;
 	smalluint last_bg_pid_exitcode;
+#ifndef __U_BOOT__
 #if ENABLE_HUSH_SET
 	/* are global_argv and global_argv[1..n] malloced? (note: not [0]) */
 	smalluint global_args_malloced;
@@ -947,6 +989,7 @@ struct globals {
 #if ENABLE_HUSH_BASH_COMPAT
 	int dead_job_exitcode; /* for "wait -n" */
 #endif
+#endif /* !__U_BOOT__ */
 	/* how many non-NULL argv's we have. NB: $# + 1 */
 	int global_argc;
 	char **global_argv;
@@ -954,19 +997,30 @@ struct globals {
 	char *argv0_for_re_execing;
 #endif
 #if ENABLE_HUSH_LOOPS
+#ifndef __U_BOOT__
 	unsigned depth_break_continue;
+#endif /* !__U_BOOT__ */
 	unsigned depth_of_loop;
 #endif
+#ifndef __U_BOOT__
 #if ENABLE_HUSH_GETOPTS
 	unsigned getopt_count;
 #endif
+#endif /* !__U_BOOT__ */
 	const char *ifs;
+#ifdef __U_BOOT__
+	int flag_repeat;
+	int do_repeat;
+#endif /* __U_BOOT__ */
 	char *ifs_whitespace; /* = G.ifs or malloced */
+#ifndef __U_BOOT__
 	const char *cwd;
+#endif /* !__U_BOOT__ */
 	struct variable *top_var;
 	char **expanded_assignments;
 	struct variable **shadowed_vars_pp;
 	unsigned var_nest_level;
+#ifndef __U_BOOT__
 #if ENABLE_HUSH_FUNCTIONS
 # if ENABLE_HUSH_LOCAL
 	unsigned func_nest_level; /* solely to prevent "local v" in non-functions */
@@ -1022,9 +1076,11 @@ struct globals {
 	int x_mode_fd;
 	o_string x_mode_buf;
 #endif
+#endif /* !__U_BOOT__ */
 #if HUSH_DEBUG >= 2
 	int debug_indent;
 #endif
+#ifndef __U_BOOT__
 	struct sigaction sa;
 	char optstring_buf[sizeof("eixcs")];
 #if BASH_EPOCH_VARS
@@ -1033,19 +1089,35 @@ struct globals {
 #if ENABLE_FEATURE_EDITING
 	char user_input_buf[CONFIG_FEATURE_EDITING_MAX_LEN];
 #endif
+#endif /* !__U_BOOT__ */
 };
+#ifdef __U_BOOT__
+struct globals *ptr_to_globals;
+#endif /* __U_BOOT__ */
 #define G (*ptr_to_globals)
 /* Not #defining name to G.name - this quickly gets unwieldy
  * (too many defines). Also, I actually prefer to see when a variable
  * is global, thus "G." prefix is a useful hint */
+#ifdef __U_BOOT__
+#define SET_PTR_TO_GLOBALS(x) do { \
+	(*(struct globals**)&ptr_to_globals) = (void*)(x); \
+	barrier(); \
+} while (0)
+#define INIT_G() do { \
+	SET_PTR_TO_GLOBALS(xzalloc(sizeof(G))); \
+	G.promptmode = 1; \
+} while (0)
+#else /* !__U_BOOT__ */
 #define INIT_G() do { \
 	SET_PTR_TO_GLOBALS(xzalloc(sizeof(G))); \
 	/* memset(&G.sa, 0, sizeof(G.sa)); */  \
 	sigfillset(&G.sa.sa_mask); \
 	G.sa.sa_flags = SA_RESTART; \
 } while (0)
+#endif /* !__U_BOOT__ */
 
 
+#ifndef __U_BOOT__
 /* Function prototypes for builtins */
 static int builtin_cd(char **argv) FAST_FUNC;
 #if ENABLE_HUSH_ECHO
@@ -1245,6 +1317,7 @@ static const struct built_in_command bltins2[] ALIGN_PTR = {
 #endif
 };
 
+#endif /* !__U_BOOT__ */
 
 /* Debug printouts.
  */
@@ -1396,7 +1469,11 @@ static void die_if_script(void)
 	}
 }
 
+#ifdef __U_BOOT__
+static void __maybe_unused msg_and_die_if_script(unsigned lineno, const char *fmt, ...)
+#else /* !__U_BOOT__ */
 static void msg_and_die_if_script(unsigned lineno, const char *fmt, ...)
+#endif /* !__U_BOOT__ */
 {
 	va_list p;
 
@@ -1409,6 +1486,7 @@ static void msg_and_die_if_script(unsigned lineno, const char *fmt, ...)
 	die_if_script();
 }
 
+#ifndef __U_BOOT__
 static void syntax_error(unsigned lineno UNUSED_PARAM, const char *msg)
 {
 	if (msg)
@@ -1417,6 +1495,7 @@ static void syntax_error(unsigned lineno UNUSED_PARAM, const char *msg)
 		bb_simple_error_msg("syntax error");
 	die_if_script();
 }
+#endif /* !__U_BOOT__ */
 
 static void syntax_error_at(unsigned lineno UNUSED_PARAM, const char *msg)
 {
@@ -1465,13 +1544,16 @@ static void syntax_error_unexpected_ch(unsigned lineno UNUSED_PARAM, int ch)
 # define syntax_error_unexpected_ch(ch) syntax_error_unexpected_ch(__LINE__, ch)
 #endif
 
-
 /* Utility functions
  */
 /* Replace each \x with x in place, return ptr past NUL. */
 static char *unbackslash(char *src)
 {
+#ifdef __U_BOOT__
+	char *dst = src = (char *)strchrnul(src, '\\');
+#else /* !__U_BOOT__ */
 	char *dst = src = strchrnul(src, '\\');
+#endif /* !__U_BOOT__ */
 	while (1) {
 		if (*src == '\\') {
 			src++;
@@ -1539,6 +1621,7 @@ static char **add_string_to_strings(char **strings, char *add)
 	v[1] = NULL;
 	return add_strings_to_strings(strings, v, /*dup:*/ 0);
 }
+
 #if LEAK_HUNTING
 static char **xx_add_string_to_strings(int lineno, char **strings, char *add)
 {
@@ -1564,6 +1647,7 @@ static void free_strings(char **strings)
 	free(strings);
 }
 
+#ifndef __U_BOOT__
 static int dup_CLOEXEC(int fd, int avoid_fd)
 {
 	int newfd;
@@ -1749,6 +1833,7 @@ static int fd_in_HFILEs(int fd)
 	return 0;
 }
 
+#endif /* !__U_BOOT__ */
 
 /* Helpers for setting new $n and restoring them back
  */
@@ -1756,9 +1841,12 @@ typedef struct save_arg_t {
 	char *sv_argv0;
 	char **sv_g_argv;
 	int sv_g_argc;
+#ifndef __U_BOOT__
 	IF_HUSH_SET(smallint sv_g_malloced;)
+#endif /* !__U_BOOT__ */
 } save_arg_t;
 
+#ifndef __U_BOOT__
 static void save_and_replace_G_args(save_arg_t *sv, char **argv)
 {
 	sv->sv_argv0 = argv[0];
@@ -1789,8 +1877,10 @@ static void restore_G_args(save_arg_t *sv, char **argv)
 	G.global_argc = sv->sv_g_argc;
 	IF_HUSH_SET(G.global_args_malloced = sv->sv_g_malloced;)
 }
+#endif /* !__U_BOOT__ */
 
 
+#ifndef __U_BOOT__
 /* Basic theory of signal handling in shell
  * ========================================
  * This does not describe what hush does, rather, it is current understanding
@@ -1969,7 +2059,9 @@ static sighandler_t install_sighandler(int sig, sighandler_t handler)
 	sigaction(sig, &G.sa, &old_sa);
 	return old_sa.sa_handler;
 }
+#endif /* !__U_BOOT__ */
 
+#ifndef __U_BOOT__
 static void hush_exit(int exitcode) NORETURN;
 
 static void restore_ttypgrp_and__exit(void) NORETURN;
@@ -2039,7 +2131,9 @@ static void sigexit(int sig)
 # define enable_restore_tty_pgrp_on_exit()  ((void)0)
 
 #endif
+#endif /* !__U_BOOT__ */
 
+#ifndef __U_BOOT__
 static sighandler_t pick_sighandler(unsigned sig)
 {
 	sighandler_t handler = SIG_DFL;
@@ -2066,7 +2160,9 @@ static sighandler_t pick_sighandler(unsigned sig)
 	}
 	return handler;
 }
+#endif /* !__U_BOOT__ */
 
+#ifndef __U_BOOT__
 /* Restores tty foreground process group, and exits. */
 static void hush_exit(int exitcode)
 {
@@ -2226,6 +2322,7 @@ static const char *get_cwd(int force)
 	return G.cwd;
 }
 
+#endif /* !__U_BOOT__ */
 
 /*
  * Shell and environment variable support
@@ -2263,8 +2360,10 @@ static const char* FAST_FUNC get_local_var_value(const char *name)
 	if (vpp)
 		return (*vpp)->varstr + len + 1;
 
+#ifndef __U_BOOT__
 	if (strcmp(name, "PPID") == 0)
 		return utoa(G.root_ppid);
+#endif /* !__U_BOOT__ */
 	// bash compat: UID? EUID?
 #if ENABLE_HUSH_RANDOM_SUPPORT
 	if (strcmp(name, "RANDOM") == 0)
@@ -2293,6 +2392,7 @@ static const char* FAST_FUNC get_local_var_value(const char *name)
 	return NULL;
 }
 
+#ifndef __U_BOOT__
 #if ENABLE_HUSH_GETOPTS
 static void handle_changed_special_names(const char *name, unsigned name_len)
 {
@@ -2307,15 +2407,25 @@ static void handle_changed_special_names(const char *name, unsigned name_len)
 /* Do not even bother evaluating arguments */
 # define handle_changed_special_names(...) ((void)0)
 #endif
+#else /* __U_BOOT__ */
+/* Do not even bother evaluating arguments */
+# define handle_changed_special_names(...) ((void)0)
+#endif /* __U_BOOT__ */
 
 /* str holds "NAME=VAL" and is expected to be malloced.
  * We take ownership of it.
  */
+#ifndef __U_BOOT__
 #define SETFLAG_EXPORT   (1 << 0)
 #define SETFLAG_UNEXPORT (1 << 1)
 #define SETFLAG_MAKE_RO  (1 << 2)
+#endif /* !__U_BOOT__ */
 #define SETFLAG_VARLVL_SHIFT   3
+#ifndef __U_BOOT__
 static int set_local_var(char *str, unsigned flags)
+#else /* __U_BOOT__ */
+int set_local_var_modern(char *str, int flags)
+#endif /* __U_BOOT__ */
 {
 	struct variable **cur_pp;
 	struct variable *cur;
@@ -2323,7 +2433,9 @@ static int set_local_var(char *str, unsigned flags)
 	char *eq_sign;
 	int name_len;
 	int retval;
+#ifndef __U_BOOT__
 	unsigned local_lvl = (flags >> SETFLAG_VARLVL_SHIFT);
+#endif /* !__U_BOOT__ */
 
 	eq_sign = strchr(str, '=');
 	if (HUSH_DEBUG && !eq_sign)
@@ -2337,6 +2449,7 @@ static int set_local_var(char *str, unsigned flags)
 			continue;
 		}
 
+#ifndef __U_BOOT__
 		/* We found an existing var with this name */
 		if (cur->flg_read_only) {
 			bb_error_msg("%s: readonly variable", str);
@@ -2389,6 +2502,7 @@ static int set_local_var(char *str, unsigned flags)
 			}
 			break;
 		}
+#endif /* !__U_BOOT__ */
 
 		if (strcmp(cur->varstr + name_len, eq_sign + 1) == 0) {
 			debug_printf_env("assignement '%s' does not change anything\n", str);
@@ -2420,15 +2534,22 @@ static int set_local_var(char *str, unsigned flags)
 	}
 
 	/* Not found or shadowed - create new variable struct */
+#ifndef __U_BOOT__
 	debug_printf_env("%s: alloc new var '%s'/%u\n", __func__, str, local_lvl);
+#else /* __U_BOOT__ */
+	debug_printf_env("%s: alloc new var '%s'\n", __func__, str);
+#endif /* __U_BOOT__ */
 	cur = xzalloc(sizeof(*cur));
+#ifndef __U_BOOT__
 	cur->var_nest_level = local_lvl;
+#endif /* !__U_BOOT__ */
 	cur->next = *cur_pp;
 	*cur_pp = cur;
 
  set_str_and_exp:
 	cur->varstr = str;
  exp:
+#ifndef __U_BOOT__
 #if !BB_MMU || ENABLE_HUSH_READONLY
 	if (flags & SETFLAG_MAKE_RO) {
 		cur->flg_read_only = 1;
@@ -2436,7 +2557,9 @@ static int set_local_var(char *str, unsigned flags)
 #endif
 	if (flags & SETFLAG_EXPORT)
 		cur->flg_export = 1;
+#endif /* !__U_BOOT__ */
 	retval = 0;
+#ifndef __U_BOOT__
 	if (cur->flg_export) {
 		if (flags & SETFLAG_UNEXPORT) {
 			cur->flg_export = 0;
@@ -2449,6 +2572,7 @@ static int set_local_var(char *str, unsigned flags)
 			 */
 		}
 	}
+#endif /* !__U_BOOT__ */
 	free(free_me);
 
 	handle_changed_special_names(cur->varstr, name_len - 1);
@@ -2456,6 +2580,7 @@ static int set_local_var(char *str, unsigned flags)
 	return retval;
 }
 
+#ifndef __U_BOOT__
 static void FAST_FUNC set_local_var_from_halves(const char *name, const char *val)
 {
 	char *var = xasprintf("%s=%s", name, val);
@@ -2467,6 +2592,7 @@ static void set_pwd_var(unsigned flag)
 {
 	set_local_var(xasprintf("PWD=%s", get_cwd(/*force:*/ 1)), flag);
 }
+#endif /* !__U_BOOT__ */
 
 #if ENABLE_HUSH_UNSET || ENABLE_HUSH_GETOPTS
 static int unset_local_var_len(const char *name, int name_len)
@@ -2509,6 +2635,7 @@ static int unset_local_var(const char *name)
 #endif
 
 
+#ifndef __U_BOOT__
 /*
  * Helpers for "var1=val1 var2=val2 cmd" feature
  */
@@ -2602,11 +2729,13 @@ static void reinit_unicode_for_hush(void)
 	}
 }
 
+#endif /* !__U_BOOT__ */
 /*
  * in_str support (strings, and "strings" read from files).
  */
 
 #if ENABLE_HUSH_INTERACTIVE
+#ifndef __U_BOOT__
 /* To test correct lineedit/interactive behavior, type from command line:
  *	echo $P\
  *	\
@@ -2639,8 +2768,15 @@ static const char *setup_prompt_string(void)
 	debug_printf("prompt_str '%s'\n", prompt_str);
 	return prompt_str;
 }
+#endif /* !__U_BOOT__ */
+
+#ifndef __U_BOOT__
 static int get_user_input(struct in_str *i)
+#else /* __U_BOOT__ */
+static void get_user_input(struct in_str *i)
+#endif /* __U_BOOT__ */
 {
+#ifndef __U_BOOT__
 # if ENABLE_FEATURE_EDITING
 	/* In EDITING case, this function reads next input line,
 	 * saves it in i->p, then returns 1st char of it.
@@ -2716,37 +2852,139 @@ static int get_user_input(struct in_str *i)
 	}
 	return r;
 # endif
+#else /* __U_BOOT__ */
+	int n;
+	int promptme;
+	static char the_command[CONFIG_SYS_CBSIZE + 1];
+
+	bootretry_reset_cmd_timeout();
+	promptme = 1;
+	n = u_boot_cli_readline(i);
+
+# ifdef CONFIG_BOOT_RETRY_TIME
+	if (n == -2) {
+		puts("\nTimeout waiting for command\n");
+#  ifdef CONFIG_RESET_TO_RETRY
+		do_reset(NULL, 0, 0, NULL);
+#  else
+#	error "This currently only works with CONFIG_RESET_TO_RETRY enabled"
+#  endif
+	}
+# endif
+	if (n == -1 ) {
+		G.flag_repeat = 0;
+		promptme = 0;
+	}
+	n = strlen(console_buffer);
+	console_buffer[n] = '\n';
+	console_buffer[n+1]= '\0';
+	if (had_ctrlc())
+		G.flag_repeat = 0;
+	clear_ctrlc();
+	G.do_repeat = 0;
+#ifndef __U_BOOT__
+	if (G.promptmode == 1) {
+#else /* __U_BOOT__ */
+	if (!G.promptmode) {
+#endif /* __U_BOOT__ */
+		if (console_buffer[0] == '\n'&& G.flag_repeat == 0) {
+			strcpy(the_command, console_buffer);
+		}
+		else {
+			if (console_buffer[0] != '\n') {
+				strcpy(the_command, console_buffer);
+				G.flag_repeat = 1;
+			}
+			else {
+				G.do_repeat = 1;
+			}
+		}
+		i->p = the_command;
+	}
+	else {
+		if (console_buffer[0] != '\n') {
+			if (strlen(the_command) + strlen(console_buffer)
+				< CONFIG_SYS_CBSIZE) {
+				n = strlen(the_command);
+#ifdef __U_BOOT__
+				/*
+				 * To avoid writing to bad places, we check if
+				 * n is greater than 0.
+				 * This bug was found by Harald Seiler.
+				 */
+				if (n > 0)
+					the_command[n-1] = ' ';
+				strcpy(&the_command[n], console_buffer);
+#else /* !__U_BOOT__ */
+			the_command[n-1] = ' ';
+			strcpy(&the_command[n], console_buffer);
+#endif /* !__U_BOOT__ */
+				}
+				else {
+					the_command[0] = '\n';
+					the_command[1] = '\0';
+					G.flag_repeat = 0;
+				}
+		}
+		if (promptme == 0) {
+			the_command[0] = '\n';
+			the_command[1] = '\0';
+		}
+		i->p = console_buffer;
+	}
+#endif /* __U_BOOT__ */
 }
 /* This is the magic location that prints prompts
  * and gets data back from the user */
 static int fgetc_interactive(struct in_str *i)
 {
 	int ch;
+#ifndef __U_BOOT__
 	/* If it's interactive stdin, get new line. */
 	if (G_interactive_fd && i->file == G.HFILE_stdin) {
+#endif /* !__U_BOOT__ */
+#ifndef __U_BOOT__
 		/* Returns first char (or EOF), the rest is in i->p[] */
 		ch = get_user_input(i);
+#else /* __U_BOOT__ */
+		/* Avoid garbage value and make clang happy. */
+		ch = 0;
+		/*
+		 * get_user_input() does not return anything when used in
+		 * U-Boot.
+		 * So, we need to take the read character from i->p[].
+		 */
+		get_user_input(i);
+		if (i->p && *i->p) {
+			ch = *i->p++;
+		}
+#endif /* __U_BOOT__ */
 		G.promptmode = 1; /* PS2 */
 		debug_printf_prompt("%s promptmode=%d\n", __func__, G.promptmode);
+#ifndef __U_BOOT__
 	} else {
 		/* Not stdin: script file, sourced file, etc */
 		do ch = hfgetc(i->file); while (ch == '\0');
 	}
+#endif /* !__U_BOOT__ */
 	return ch;
 }
 #else  /* !INTERACTIVE */
+#ifndef __U_BOOT__
 static ALWAYS_INLINE int fgetc_interactive(struct in_str *i)
 {
 	int ch;
 	do ch = hfgetc(i->file); while (ch == '\0');
 	return ch;
 }
+#endif /* !__U_BOOT__ */
 #endif  /* !INTERACTIVE */
 
 static int i_getch(struct in_str *i)
 {
 	int ch;
 
+#ifndef __U_BOOT__
 	if (!i->file) {
 		/* string-based in_str */
 		ch = (unsigned char)*i->p;
@@ -2758,6 +2996,7 @@ static int i_getch(struct in_str *i)
 		return EOF;
 	}
 
+#endif /* !__U_BOOT__ */
 	/* FILE-based in_str */
 
 #if ENABLE_FEATURE_EDITING
@@ -2767,6 +3006,7 @@ static int i_getch(struct in_str *i)
 		goto out;
 	}
 #endif
+#ifndef __U_BOOT__
 	/* peek_buf[] is an int array, not char. Can contain EOF. */
 	ch = i->peek_buf[0];
 	if (ch != 0) {
@@ -2778,6 +3018,7 @@ static int i_getch(struct in_str *i)
 		goto out;
 	}
 
+#endif /* !__U_BOOT__ */
 	ch = fgetc_interactive(i);
  out:
 	debug_printf("file_get: got '%c' %d\n", ch, ch);
@@ -2793,6 +3034,7 @@ static int i_getch(struct in_str *i)
 
 static int i_peek(struct in_str *i)
 {
+#ifndef __U_BOOT__
 	int ch;
 
 	if (!i->file) {
@@ -2827,6 +3069,11 @@ static int i_peek(struct in_str *i)
 	i->peek_buf[0] = ch;
 	/*i->peek_buf[1] = 0; - already is */
 	return ch;
+#else /* __U_BOOT__ */
+	/* string-based in_str */
+	/* Doesn't report EOF on NUL. None of the callers care. */
+	return (unsigned char)*i->p;
+#endif /* __U_BOOT__ */
 }
 
 /* Only ever called if i_peek() was called, and did not return EOF.
@@ -2835,7 +3082,9 @@ static int i_peek(struct in_str *i)
  */
 static int i_peek2(struct in_str *i)
 {
+#ifndef __U_BOOT__
 	int ch;
+#endif /* !__U_BOOT__ */
 
 	/* There are two cases when i->p[] buffer exists.
 	 * (1) it's a string in_str.
@@ -2846,6 +3095,7 @@ static int i_peek2(struct in_str *i)
 	if (i->p)
 		return (unsigned char)i->p[1];
 
+#ifndef __U_BOOT__
 	/* Now we know it is a file-based in_str. */
 
 	/* peek_buf[] is an int array, not char. Can contain EOF. */
@@ -2859,6 +3109,9 @@ static int i_peek2(struct in_str *i)
 
 	debug_printf("file_peek2: got '%c' %d\n", ch, ch);
 	return ch;
+#else
+	return 0;
+#endif /* __U_BOOT__ */
 }
 
 static int i_getch_and_eat_bkslash_nl(struct in_str *input)
@@ -2897,13 +3150,20 @@ static int i_peek_and_eat_bkslash_nl(struct in_str *input)
 	}
 }
 
+#ifndef __U_BOOT__
 static void setup_file_in_str(struct in_str *i, HFILE *fp)
+#else /* __U_BOOT__ */
+static void setup_file_in_str(struct in_str *i)
+#endif /* __U_BOOT__ */
 {
 	memset(i, 0, sizeof(*i));
+#ifndef __U_BOOT__
 	i->file = fp;
 	/* i->p = NULL; */
+#endif /* !__U_BOOT__ */
 }
 
+#ifndef __U_BOOT__
 static void setup_string_in_str(struct in_str *i, const char *s)
 {
 	memset(i, 0, sizeof(*i));
@@ -2911,6 +3171,7 @@ static void setup_string_in_str(struct in_str *i, const char *s)
 	i->p = s;
 }
 
+#endif /* !__U_BOOT__ */
 
 /*
  * o_string support
@@ -2980,10 +3241,12 @@ static void o_addstr(o_string *o, const char *str)
 	o_addblock(o, str, strlen(str));
 }
 
+#ifndef __U_BOOT__
 static void o_addstr_with_NUL(o_string *o, const char *str)
 {
 	o_addblock(o, str, strlen(str) + 1);
 }
+#endif /* !__U_BOOT__ */
 
 #if !BB_MMU
 static void nommu_addchr(o_string *o, int ch)
@@ -2995,6 +3258,7 @@ static void nommu_addchr(o_string *o, int ch)
 # define nommu_addchr(o, str) ((void)0)
 #endif
 
+#ifndef __U_BOOT__
 #if ENABLE_HUSH_MODE_X
 static void x_mode_addchr(int ch)
 {
@@ -3025,6 +3289,7 @@ static void x_mode_flush(void)
 	G.x_mode_buf.length = 0;
 }
 #endif
+#endif /* !__U_BOOT__ */
 
 /*
  * HUSH_BRACE_EXPANSION code needs corresponding quoting on variable expansion side.
@@ -3156,7 +3421,11 @@ static void debug_print_list(const char *prefix, o_string *o, int n)
 	if (n) {
 		const char *p = o->data + (int)(uintptr_t)list[n - 1] + string_start;
 		indent();
+#ifndef __U_BOOT__
 		fdprintf(2, " total_sz:%ld\n", (long)((p + strlen(p) + 1) - o->data));
+#else /* __U_BOOT__ */
+		printf(" total_sz:%ld\n", (long)((p + strlen(p) + 1) - o->data));
+#endif /* __U_BOOT__ */
 	}
 }
 #else
@@ -3216,6 +3485,7 @@ static int o_get_last_ptr(o_string *o, int n)
 	return ((int)(uintptr_t)list[n-1]) + string_start;
 }
 
+#ifndef __U_BOOT__
 /*
  * Globbing routines.
  *
@@ -3524,12 +3794,14 @@ static int perform_glob(o_string *o, int n)
 	return n;
 }
 
+#endif /* !__U_BOOT__ */
 #endif /* !HUSH_BRACE_EXPANSION */
 
 /* If o->o_expflags & EXP_FLAG_GLOB, glob the string so far remembered.
  * Otherwise, just finish current list[] and start new */
 static int o_save_ptr(o_string *o, int n)
 {
+#ifndef __U_BOOT__
 	if (o->o_expflags & EXP_FLAG_GLOB) {
 		/* If o->has_empty_slot, list[n] was already globbed
 		 * (if it was requested back then when it was filled)
@@ -3537,6 +3809,7 @@ static int o_save_ptr(o_string *o, int n)
 		if (!o->has_empty_slot)
 			return perform_glob(o, n); /* o_save_ptr_helper is inside */
 	}
+#endif /* !__U_BOOT__ */
 	return o_save_ptr_helper(o, n);
 }
 
@@ -3567,10 +3840,14 @@ static struct pipe *free_pipe(struct pipe *pi)
 	struct pipe *next;
 	int i;
 
+#ifndef __U_BOOT__
 	debug_printf_clean("free_pipe (pid %d)\n", getpid());
+#endif /* !__U_BOOT__ */
 	for (i = 0; i < pi->num_cmds; i++) {
 		struct command *command;
+#ifndef __U_BOOT__
 		struct redir_struct *r, *rnext;
+#endif /* !__U_BOOT__ */
 
 		command = &pi->cmds[i];
 		debug_printf_clean("  command %d:\n", i);
@@ -3605,6 +3882,7 @@ static struct pipe *free_pipe(struct pipe *pi)
 		free(command->group_as_string);
 		//command->group_as_string = NULL;
 #endif
+#ifndef __U_BOOT__
 		for (r = command->redirects; r; r = rnext) {
 			debug_printf_clean("   redirect %d%s",
 					r->rd_fd, redir_table[r->rd_type].descrip);
@@ -3619,13 +3897,16 @@ static struct pipe *free_pipe(struct pipe *pi)
 			free(r);
 		}
 		//command->redirects = NULL;
+#endif /* !__U_BOOT__ */
 	}
 	free(pi->cmds);   /* children are an array, they get freed all at once */
 	//pi->cmds = NULL;
+#ifndef __U_BOOT__
 #if ENABLE_HUSH_JOB
 	free(pi->cmdtext);
 	//pi->cmdtext = NULL;
 #endif
+#endif /* !__U_BOOT__ */
 
 	next = pi->next;
 	free(pi);
@@ -3655,6 +3936,7 @@ static void debug_print_tree(struct pipe *pi, int lvl)
 		[PIPE_OR ] = "OR" ,
 		[PIPE_BG ] = "BG" ,
 	};
+#ifndef __U_BOOT__
 	static const char *RES[] = {
 		[RES_NONE ] = "NONE" ,
 # if ENABLE_HUSH_IF
@@ -3684,6 +3966,7 @@ static void debug_print_tree(struct pipe *pi, int lvl)
 		[RES_XXXX ] = "XXXX" ,
 		[RES_SNTX ] = "SNTX" ,
 	};
+#endif /* !__U_BOOT__ */
 	static const char *const CMDTYPE[] = {
 		"{}",
 		"()",
@@ -3701,8 +3984,10 @@ static void debug_print_tree(struct pipe *pi, int lvl)
 				lvl*2, "",
 				pin,
 				pi->num_cmds,
+#ifdef __U_BOOT__
 				(IF_HAS_KEYWORDS(pi->pi_inverted ? "! " :) ""),
 				RES[pi->res_word],
+#endif /* !__U_BOOT__ */
 				pi->followup, PIPE[pi->followup]
 		);
 		prn = 0;
@@ -3734,8 +4019,10 @@ static void debug_print_tree(struct pipe *pi, int lvl)
 				fdprintf(2, " '%s'", *argv);
 				argv++;
 			}
+#ifndef __U_BOOT__
 			if (command->redirects)
 				fdprintf(2, " {redir}");
+#endif /* __U_BOOT__ */
 			fdprintf(2, "\n");
 			prn++;
 		}
@@ -3869,8 +4156,13 @@ static void done_pipe(struct parse_context *ctx, pipe_style type)
 	) {
 		struct pipe *new_p;
 		debug_printf_parse("done_pipe: adding new pipe: "
+#ifndef __U_BOOT__
 				"not_null:%d ctx->ctx_res_w:%d\n",
 				not_null, ctx->ctx_res_w);
+#else /* __U_BOOT__ */
+				"not_null:%d\n",
+				not_null);
+#endif /* __U_BOOT__ */
 		new_p = new_pipe();
 		ctx->pipe->next = new_p;
 		ctx->pipe = new_p;
@@ -4096,6 +4388,7 @@ static int done_word(struct parse_context *ctx)
 		return 0;
 	}
 
+#ifndef __U_BOOT__
 	if (ctx->pending_redirect) {
 		/* We do not glob in e.g. >*.tmp case. bash seems to glob here
 		 * only if run as "bash", not "sh" */
@@ -4137,6 +4430,7 @@ static int done_word(struct parse_context *ctx)
 		debug_printf_parse("word stored in rd_filename: '%s'\n", ctx->word.data);
 		ctx->pending_redirect = NULL;
 	} else {
+#endif /* !__U_BOOT__ */
 #if HAS_KEYWORDS
 # if ENABLE_HUSH_CASE
 		if (ctx->ctx_dsemicolon
@@ -4247,8 +4541,14 @@ static int done_word(struct parse_context *ctx)
 		}
 		debug_printf_parse("ctx->is_assignment='%s'\n", assignment_flag[ctx->is_assignment]);
 		command->argv = add_string_to_strings(command->argv, xstrdup(ctx->word.data));
+#ifdef __U_BOOT__
+		command->argc++;
+#endif /* __U_BOOT__ */
 		debug_print_strings("word appended to argv", command->argv);
+
+#ifndef __U_BOOT__
 	}
+#endif /* !__U_BOOT__ */
 
 #if ENABLE_HUSH_LOOPS
 	if (ctx->ctx_res_w == RES_FOR) {
@@ -4280,6 +4580,7 @@ static int done_word(struct parse_context *ctx)
 }
 
 
+#ifndef __U_BOOT__
 /* Peek ahead in the input to find out if we have a "&n" construct,
  * as in "2>&1", that represents duplicating a file descriptor.
  * Return:
@@ -4463,7 +4764,11 @@ static char *fetch_till_str(o_string *as_string,
 			nommu_addchr(as_string, ch);
 		if (ch == '\n' || ch == EOF) {
  check_heredoc_end:
+#ifndef __U_BOOT__
 			if ((heredoc_flags & HEREDOC_QUOTED) || prev != '\\') {
+#else /* __U_BOOT__ */
+			if (prev != '\\') {
+#endif
 				/* End-of-line, and not a line continuation */
 				if (strcmp(heredoc.data + past_EOL, word) == 0) {
 					heredoc.data[past_EOL] = '\0';
@@ -4483,7 +4788,11 @@ static char *fetch_till_str(o_string *as_string,
 						ch = i_getch(input);
 						if (ch != EOF)
 							nommu_addchr(as_string, ch);
+#ifndef __U_BOOT__
 					} while ((heredoc_flags & HEREDOC_SKIPTABS) && ch == '\t');
+#else /* __U_BOOT__ */
+				} while (ch == '\t');
+#endif
 					/* If this immediately ended the line,
 					 * go back to end-of-line checks.
 					 */
@@ -4520,6 +4829,7 @@ static char *fetch_till_str(o_string *as_string,
 			prev = ch;
 	}
 }
+#endif /* !__U_BOOT__ */
 
 /* Look at entire parse tree for not-yet-loaded REDIRECT_HEREDOCs
  * and load them all. There should be exactly heredoc_cnt of them.
@@ -4539,10 +4849,13 @@ static int fetch_heredocs(o_string *as_string, struct pipe *pi, int heredoc_cnt,
 				cmd->argv ? cmd->argv[0] : "NONE"
 		);
 		for (i = 0; i < pi->num_cmds; i++) {
+#ifndef __U_BOOT__
 			struct redir_struct *redir = cmd->redirects;
 
+#endif /* !__U_BOOT__ */
 			debug_printf_heredoc("fetch_heredocs: %d cmd argv0:'%s'\n",
 					i, cmd->argv ? cmd->argv[0] : "NONE");
+#ifndef __U_BOOT__
 			while (redir) {
 				if (redir->rd_type == REDIRECT_HEREDOC) {
 					char *p;
@@ -4561,6 +4874,7 @@ static int fetch_heredocs(o_string *as_string, struct pipe *pi, int heredoc_cnt,
 				}
 				redir = redir->next;
 			}
+#endif /* !__U_BOOT__ */
 			if (cmd->group) {
 				//bb_error_msg("%s:%u heredoc_cnt:%d", __func__, __LINE__, heredoc_cnt);
 				heredoc_cnt = fetch_heredocs(as_string, cmd->group, heredoc_cnt, input);
@@ -4651,13 +4965,17 @@ static int parse_group(struct parse_context *ctx,
 	}
 #endif
 
+#ifndef __U_BOOT__
  IF_HUSH_FUNCTIONS(skip:)
+#endif /* !__U_BOOT__ */
 
 	endch = '}';
 	if (ch == '(') {
 		endch = ')';
+#ifndef __U_BOOT__
 		IF_HUSH_FUNCTIONS(if (command->cmd_type != CMD_FUNCDEF))
 			command->cmd_type = CMD_SUBSHELL;
+#endif /* !__U_BOOT__ */
 	} else {
 		/* bash does not allow "{echo...", requires whitespace */
 		ch = i_peek(input);
@@ -4725,6 +5043,7 @@ static int parse_group(struct parse_context *ctx,
 #undef as_string
 }
 
+#ifndef __U_BOOT__
 #if ENABLE_HUSH_TICK || ENABLE_FEATURE_SH_MATH || ENABLE_HUSH_DOLLAR_OPS
 /* Subroutines for copying $(...) and `...` things */
 /* '...' */
@@ -4754,6 +5073,7 @@ static int add_till_single_quote_dquoted(o_string *dest, struct in_str *input)
 		o_addqchr(dest, ch);
 	}
 }
+
 /* "...\"...`..`...." - do we need to handle "...$(..)..." too? */
 static int add_till_backquote(o_string *dest, struct in_str *input, int in_dquote);
 static int add_till_double_quote(o_string *dest, struct in_str *input)
@@ -4780,6 +5100,8 @@ static int add_till_double_quote(o_string *dest, struct in_str *input)
 		//if (ch == '$') ...
 	}
 }
+
+
 /* Process `cmd` - copy contents until "`" is seen. Complicated by
  * \` quoting.
  * "Within the backquoted style of command substitution, backslash
@@ -5014,6 +5336,7 @@ static int parse_dollar_squote(o_string *as_string, o_string *dest, struct in_st
 #else
 # #define parse_dollar_squote(as_string, dest, input) 0
 #endif /* BASH_DOLLAR_SQUOTE */
+#endif /* !__U_BOOT__ */
 
 /* Return code: 0 for OK, 1 for syntax error */
 #if BB_MMU
@@ -5056,8 +5379,10 @@ static int parse_dollar(o_string *as_string,
 		o_addchr(dest, ch | quote_mask);
 		o_addchr(dest, SPECIAL_VAR_SYMBOL);
 	} else switch (ch) {
+#ifndef __U_BOOT__
 	case '$': /* pid */
 	case '!': /* last bg pid */
+#endif /* !__U_BOOT__ */
 	case '?': /* last exit code */
 	case '#': /* number of args */
 	case '*': /* args */
@@ -5132,7 +5457,9 @@ static int parse_dollar(o_string *as_string,
 				break;
 			if (!isalnum(ch) && ch != '_') {
 				unsigned end_ch;
+#ifndef __U_BOOT__
 				unsigned char last_ch;
+#endif /* !__U_BOOT__ */
 				/* handle parameter expansions
 				 * http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_06_02
 				 */
@@ -5151,6 +5478,7 @@ static int parse_dollar(o_string *as_string,
  eat_until_closing:
 				/* Eat everything until closing '}' (or ':') */
 				end_ch = '}';
+#ifndef __U_BOOT__
 				if (BASH_SUBSTR
 				 && ch == ':'
 				 && !strchr(MINUS_PLUS_EQUAL_QUESTION, i_peek(input))
@@ -5169,6 +5497,7 @@ static int parse_dollar(o_string *as_string,
 					}
 					end_ch = '}' * 0x100 + '/';
 				}
+#endif /* !__U_BOOT__ */
 				o_addchr(dest, ch);
 				/* The pattern can't be empty.
 				 * IOW: if the first char after "${v//" is a slash,
@@ -5179,21 +5508,28 @@ static int parse_dollar(o_string *as_string,
 				if (i_peek(input) == '/') {
 					o_addchr(dest, i_getch(input));
 				}
+#ifndef __U_BOOT__
  again:
+#endif /* !__U_BOOT__ */
 				if (!BB_MMU)
 					pos = dest->length;
 #if ENABLE_HUSH_DOLLAR_OPS
+#ifndef __U_BOOT__
 				last_ch = add_till_closing_bracket(dest, input, end_ch);
 				if (last_ch == 0) /* error? */
 					return 0;
+#endif /* !__U_BOOT__ */
 #else
 # error Simple code to only allow ${var} is not implemented
 #endif
 				if (as_string) {
 					o_addstr(as_string, dest->data + pos);
+#ifndef __U_BOOT__
 					o_addchr(as_string, last_ch);
+#endif /* !__U_BOOT__ */
 				}
 
+#ifndef __U_BOOT__
 				if ((BASH_SUBSTR || BASH_PATTERN_SUBST)
 					 && (end_ch & 0xff00)
 				) {
@@ -5212,6 +5548,7 @@ static int parse_dollar(o_string *as_string,
 						o_addstr(dest, "999999999");
 					} /* else: it's ${var/[/]pattern} */
 				}
+#endif /* !__U_BOOT__ */
 				break;
 			}
 			len_single_ch = 0; /* it can't be ${#C} op */
@@ -5415,8 +5752,10 @@ static struct pipe *parse_stream(char **pstring,
 		const char *is_special;
 		int ch;
 		int next;
+#ifndef __U_BOOT__
 		int redir_fd;
 		redir_type redir_style;
+#endif /* !__U_BOOT__ */
 
 		ch = i_getch(input);
 		debug_printf_parse(": ch=%c (%d) escape=%d\n",
@@ -5506,8 +5845,10 @@ static struct pipe *parse_stream(char **pstring,
 		if (ch == '\'') {
 			ctx.word.has_quoted_part = 1;
 			next = i_getch(input);
+#ifndef __U_BOOT__
 			if (next == '\'' && !ctx.pending_redirect)
 				goto insert_empty_quoted_str_marker;
+#endif /* !__U_BOOT__ */
 
 			ch = next;
 			while (1) {
@@ -5534,7 +5875,11 @@ static struct pipe *parse_stream(char **pstring,
 			next = i_peek_and_eat_bkslash_nl(input);
 
 		is_special = "{}<>&|();#" /* special outside of "str" */
+#ifndef __U_BOOT__
 				"$\"" IF_HUSH_TICK("`") /* always special */
+#else /* __U_BOOT__ */
+				"$\""
+#endif /* __U_BOOT__ */
 				SPECIAL_VAR_SYMBOL_STR;
 #if defined(CMD_TEST2_SINGLEWORD_NOGLOB)
 		if (ctx.command->cmd_type == CMD_TEST2_SINGLEWORD_NOGLOB) {
@@ -5649,7 +5994,11 @@ static struct pipe *parse_stream(char **pstring,
 		 * } is an ordinary char in this case, even inside { cmd; }
 		 * Pathological example: { ""}; } should exec "}" cmd
 		 */
+#ifndef __U_BOOT__
 		if (ch == '}') {
+#else /* __U_BOOT__ */
+		if (ch == '}' || ch == ')') {
+#endif /* __U_BOOT__ */
 			if (ctx.word.length != 0 /* word} */
 			 || ctx.word.has_quoted_part    /* ""} */
 			) {
@@ -5725,6 +6074,7 @@ static struct pipe *parse_stream(char **pstring,
 		/* Catch <, > before deciding whether this word is
 		 * an assignment. a=1 2>z b=2: b=2 is still assignment */
 		switch (ch) {
+#ifndef __U_BOOT__
 		case '>':
 			redir_fd = redirect_opt_num(&ctx.word);
 			if (done_word(&ctx)) {
@@ -5771,6 +6121,7 @@ static struct pipe *parse_stream(char **pstring,
 			if (parse_redirect(&ctx, redir_fd, redir_style, input))
 				goto parse_error_exitcode1;
 			continue; /* get next char */
+#endif /* !__U_BOOT__ */
 		case '#':
 			if (ctx.word.length == 0 && !ctx.word.has_quoted_part) {
 				/* skip "#comment" */
@@ -5798,8 +6149,10 @@ static struct pipe *parse_stream(char **pstring,
  skip_end_trigger:
 
 		if (ctx.is_assignment == MAYBE_ASSIGNMENT
+#ifndef __U_BOOT__
 		 /* check that we are not in word in "a=1 2>word b=1": */
 		 && !ctx.pending_redirect
+#endif /* !__U_BOOT__ */
 		) {
 			/* ch is a special char and thus this word
 			 * cannot be an assignment */
@@ -5821,8 +6174,10 @@ static struct pipe *parse_stream(char **pstring,
 			o_addchr(&ctx.word, ch);
 			continue; /* get next char */
 		case '$':
+#ifndef __U_BOOT__
 			if (parse_dollar_squote(&ctx.as_string, &ctx.word, input))
 				continue; /* get next char */
+#endif /* !__U_BOOT__ */
 			if (!parse_dollar(&ctx.as_string, &ctx.word, input, /*quote_mask:*/ 0)) {
 				debug_printf_parse("parse_stream parse error: "
 					"parse_dollar returned 0 (error)\n");
@@ -5831,9 +6186,15 @@ static struct pipe *parse_stream(char **pstring,
 			continue; /* get next char */
 		case '"':
 			ctx.word.has_quoted_part = 1;
+#ifndef __U_BOOT__
 			if (next == '"' && !ctx.pending_redirect) {
+#else /* __U_BOOT__ */
+			if (next == '"') {
+#endif /* __U_BOOT__ */
 				i_getch(input); /* eat second " */
+#ifndef __U_BOOT__
  insert_empty_quoted_str_marker:
+#endif /* !__U_BOOT__ */
 				nommu_addchr(&ctx.as_string, next);
 				o_addchr(&ctx.word, SPECIAL_VAR_SYMBOL);
 				o_addchr(&ctx.word, SPECIAL_VAR_SYMBOL);
@@ -6140,6 +6501,7 @@ static int expand_on_ifs(o_string *output, int n, const char *str)
 	return n;
 }
 
+#ifndef __U_BOOT__
 /* Helper to expand $((...)) and heredoc body. These act as if
  * they are in double quotes, with the exception that they are not :).
  * Just the rules are similar: "expand only $var and `cmd`"
@@ -6440,7 +6802,9 @@ static int encode_then_append_var_plusminus(o_string *output, int n,
 	o_free(&dest);
 	return n;
 }
+#endif /* !__U_BOOT__ */
 
+#ifndef __U_BOOT__
 #if ENABLE_FEATURE_SH_MATH
 static arith_t expand_and_evaluate_arith(const char *arg, const char **errmsg_p)
 {
@@ -6461,7 +6825,9 @@ static arith_t expand_and_evaluate_arith(const char *arg, const char **errmsg_p)
 	return res;
 }
 #endif
+#endif /* !__U_BOOT__ */
 
+#ifndef __U_BOOT__
 #if BASH_PATTERN_SUBST
 /* ${var/[/]pattern[/repl]} helpers */
 static char *strstr_pattern(char *val, const char *pattern, int *size)
@@ -6529,6 +6895,7 @@ static char *replace_pattern(char *val, const char *pattern, const char *repl, c
 	return result;
 }
 #endif /* BASH_PATTERN_SUBST */
+#endif /* !__U_BOOT__ */
 
 static int append_str_maybe_ifs_split(o_string *output, int n,
 		int first_ch, const char *val)
@@ -6593,6 +6960,7 @@ static NOINLINE int expand_one_var(o_string *output, int n,
 			exp_saveptr = var+1 + strcspn(var+1, VAR_ENCODED_SUBST_OPS);
 		}
 		exp_op = exp_save = *exp_saveptr;
+#ifndef __U_BOOT__
 		if (exp_op) {
 			exp_word = exp_saveptr + 1;
 			if (exp_op == ':') {
@@ -6608,29 +6976,37 @@ static NOINLINE int expand_one_var(o_string *output, int n,
 			}
 			*exp_saveptr = '\0';
 		} /* else: it's not an expansion op, but bare ${var} */
+#endif /* !__U_BOOT__ */
 	}
 
 	/* Look up the variable in question */
 	if (isdigit(var[0])) {
 		/* parse_dollar should have vetted var for us */
+#ifndef __U_BOOT__
 		int nn = xatoi_positive(var);
+#else /* __U_BOOT__ */
+		int nn = simple_strtoul(var, NULL, 10);
+#endif /* __U_BOOT__ */
 		if (nn < G.global_argc)
 			val = G.global_argv[nn];
 		/* else val remains NULL: $N with too big N */
 	} else {
 		switch (var[0]) {
+#ifndef __U_BOOT__
 		case '$': /* pid */
 			val = utoa(G.root_pid);
 			break;
 		case '!': /* bg pid */
 			val = G.last_bg_pid ? utoa(G.last_bg_pid) : "";
 			break;
+#endif /* !__U_BOOT__ */
 		case '?': /* exitcode */
 			val = utoa(G.last_exitcode);
 			break;
 		case '#': /* argc */
 			val = utoa(G.global_argc ? G.global_argc-1 : 0);
 			break;
+#ifndef __U_BOOT__
 		case '-': { /* active options */
 			/* Check set_mode() to see what option chars we support */
 			char *cp;
@@ -6652,11 +7028,13 @@ static NOINLINE int expand_one_var(o_string *output, int n,
 			*cp = '\0';
 			break;
 		}
+#endif /* !__U_BOOT__ */
 		default:
 			val = get_local_var_value(var);
 		}
 	}
 
+#ifndef __U_BOOT__
 	/* Handle any expansions */
 	if (exp_op == 'L') {
 		reinit_unicode_for_hush();
@@ -6936,6 +7314,7 @@ static NOINLINE int expand_one_var(o_string *output, int n,
 		*exp_saveptr = exp_save;
 	} /* if (exp_op) */
 
+#endif /* !__U_BOOT__ */
 	arg[0] = arg0;
 	*pp = p;
 
@@ -7248,6 +7627,7 @@ static char* expand_strvec_to_string(char **argv)
 }
 #endif
 
+#ifndef __U_BOOT__
 static char **expand_assignments(char **argv, int count)
 {
 	int i;
@@ -7289,7 +7669,9 @@ static void switch_off_special_sigs(unsigned mask)
 		install_sighandler(sig, SIG_DFL);
 	}
 }
+#endif /* !__U_BOOT__ */
 
+#ifndef __U_BOOT__
 #if BB_MMU
 /* never called */
 void re_execute_shell(char ***to_free, const char *s,
@@ -7479,6 +7861,7 @@ static void re_execute_shell(char ***to_free, const char *s,
 }
 #endif  /* !BB_MMU */
 
+#endif /* !__U_BOOT__ */
 
 static int run_and_free_list(struct pipe *pi);
 
@@ -7537,6 +7920,7 @@ static void parse_and_run_stream(struct in_str *inp, int end_trigger)
 	}
 }
 
+#ifndef __U_BOOT__
 static void parse_and_run_string(const char *s)
 {
 	struct in_str input;
@@ -7546,18 +7930,30 @@ static void parse_and_run_string(const char *s)
 	parse_and_run_stream(&input, '\0');
 	//IF_HUSH_LINENO_VAR(G.parse_lineno = sv;)
 }
+#endif /* !__U_BOOT__ */
 
+#ifndef __U_BOOT__
 static void parse_and_run_file(HFILE *fp)
+#else /* __U_BOOT__ */
+void parse_and_run_file(void)
+#endif /* __U_BOOT__ */
 {
 	struct in_str input;
+#ifndef __U_BOOT__
 	IF_HUSH_LINENO_VAR(unsigned sv = G.parse_lineno;)
 
 	IF_HUSH_LINENO_VAR(G.parse_lineno = 1;)
 	setup_file_in_str(&input, fp);
+#else /* __U_BOOT__ */
+	setup_file_in_str(&input);
+#endif /* __U_BOOT__ */
 	parse_and_run_stream(&input, ';');
+#ifndef __U_BOOT__
 	IF_HUSH_LINENO_VAR(G.parse_lineno = sv;)
+#endif /* !__U_BOOT__ */
 }
 
+#ifndef __U_BOOT__
 #if ENABLE_HUSH_TICK
 static int generate_stream_from_string(const char *s, pid_t *pid_p)
 {
@@ -8163,7 +8559,9 @@ static const char * FAST_FUNC get_builtin_name(int i)
 	return NULL;
 }
 #endif
+#endif /* !__U_BOOT__ */
 
+#ifndef __U_BOOT__
 static void remove_nested_vars(void)
 {
 	struct variable *cur;
@@ -8215,6 +8613,7 @@ static void leave_var_nest_level(void)
 
 	remove_nested_vars();
 }
+#endif /* __U_BOOT__ */
 
 #if ENABLE_HUSH_FUNCTIONS
 static struct function **find_function_slot(const char *name)
@@ -8399,6 +8798,7 @@ static int run_function(const struct function *funcp, char **argv)
 #endif /* ENABLE_HUSH_FUNCTIONS */
 
 
+#ifndef __U_BOOT__
 #if BB_MMU
 #define exec_builtin(to_free, x, argv) \
 	exec_builtin(x, argv)
@@ -8431,8 +8831,10 @@ static void exec_builtin(char ***to_free,
 			argv);
 #endif
 }
+#endif /* !__U_BOOT__ */
 
 
+#ifndef __U_BOOT__
 static void execvp_or_die(char **argv) NORETURN;
 static void execvp_or_die(char **argv)
 {
@@ -8514,7 +8916,9 @@ static void dump_cmd_in_x_mode(char **argv)
 #else
 # define dump_cmd_in_x_mode(argv) ((void)0)
 #endif
+#endif /* !__U_BOOT__ */
 
+#ifndef __U_BOOT__
 #if ENABLE_HUSH_COMMAND
 static void if_command_vV_print_and_exit(char opt_vV, char *cmd, const char *explanation)
 {
@@ -8540,6 +8944,7 @@ static void if_command_vV_print_and_exit(char opt_vV, char *cmd, const char *exp
 #else
 # define if_command_vV_print_and_exit(a,b,c) ((void)0)
 #endif
+#endif /* !__U_BOOT__ */
 
 #if BB_MMU
 #define pseudo_exec_argv(nommu_save, argv, assignment_cnt, argv_expanded) \
@@ -8548,6 +8953,7 @@ static void if_command_vV_print_and_exit(char opt_vV, char *cmd, const char *exp
 	pseudo_exec(command, argv_expanded)
 #endif
 
+#ifndef __U_BOOT__
 /* Called after [v]fork() in run_pipe, or from builtin_exec.
  * Never returns.
  * Don't exit() here.  If you don't exec, use _exit instead.
@@ -9186,18 +9592,34 @@ static int redirect_and_varexp_helper(
 
 	return setup_redirects(command, sqp);
 }
+#endif /* !__U_BOOT__ */
+
 static NOINLINE int run_pipe(struct pipe *pi)
 {
 	static const char *const null_ptr = NULL;
 
 	int cmd_no;
+#ifndef __U_BOOT__
 	int next_infd;
+#endif /* !__U_BOOT__ */
 	struct command *command;
 	char **argv_expanded;
 	char **argv;
+#ifndef __U_BOOT__
 	struct squirrel *squirrel = NULL;
+#endif /* !__U_BOOT__ */
 	int rcode;
 
+#ifdef __U_BOOT__
+	/*
+	 * Set rcode here to avoid returning a garbage value in the middle of
+	 * the function.
+	 * Also, if an error occurs, rcode value would be changed and last
+	 * return will signal the error.
+	 */
+	rcode = 0;
+#endif /* __U_BOOT__ */
+
 	debug_printf_exec("run_pipe start: members:%d\n", pi->num_cmds);
 	debug_enter();
 
@@ -9230,11 +9652,14 @@ static NOINLINE int run_pipe(struct pipe *pi)
 		G.ifs_whitespace = (char*)G.ifs;
 	}
 
+#ifndef __U_BOOT__
 	IF_HUSH_JOB(pi->pgrp = -1;)
 	pi->stopped_cmds = 0;
+#endif /* !__U_BOOT__ */
 	command = &pi->cmds[0];
 	argv_expanded = NULL;
 
+#ifndef __U_BOOT__
 	if (pi->num_cmds != 1
 	 || pi->followup == PIPE_BG
 	 || command->cmd_type == CMD_SUBSHELL
@@ -9243,6 +9668,7 @@ static NOINLINE int run_pipe(struct pipe *pi)
 	}
 
 	pi->alive_cmds = 1;
+#endif /* !__U_BOOT__ */
 
 	debug_printf_exec(": group:%p argv:'%s'\n",
 		command->group, command->argv ? command->argv[0] : "NONE");
@@ -9274,6 +9700,7 @@ static NOINLINE int run_pipe(struct pipe *pi)
 		/* { list } */
 		debug_printf_exec("non-subshell group\n");
 		rcode = 1; /* exitcode if redir failed */
+#ifndef __U_BOOT__
 		if (setup_redirects(command, &squirrel) == 0) {
 			debug_printf_exec(": run_list\n");
 //FIXME: we need to pass squirrel down into run_list()
@@ -9286,6 +9713,7 @@ static NOINLINE int run_pipe(struct pipe *pi)
 		}
 		restore_redirects(squirrel);
 		IF_HAS_KEYWORDS(if (pi->pi_inverted) rcode = !rcode;)
+#endif /* !__U_BOOT__ */
 		debug_leave();
 		debug_printf_exec("run_pipe: return %d\n", rcode);
 		return rcode;
@@ -9293,10 +9721,12 @@ static NOINLINE int run_pipe(struct pipe *pi)
 
 	argv = command->argv ? command->argv : (char **) &null_ptr;
 	{
+#ifndef __U_BOOT__
 		const struct built_in_command *x;
 		IF_HUSH_FUNCTIONS(const struct function *funcp;)
 		IF_NOT_HUSH_FUNCTIONS(enum { funcp = 0 };)
 		struct variable **sv_shadowed;
+#endif /* !__U_BOOT__ */
 		struct variable *old_vars;
 
 #if ENABLE_HUSH_LINENO_VAR
@@ -9311,8 +9741,10 @@ static NOINLINE int run_pipe(struct pipe *pi)
 			unsigned i;
 			G.expand_exitcode = 0;
  only_assignments:
+#ifndef __U_BOOT__
 			rcode = setup_redirects(command, &squirrel);
 			restore_redirects(squirrel);
+#endif /* !__U_BOOT__ */
 
 			/* Set shell variables */
 			i = 0;
@@ -9335,7 +9767,11 @@ static NOINLINE int run_pipe(struct pipe *pi)
 				}
 #endif
 				debug_printf_env("set shell var:'%s'->'%s'\n", *argv, p);
+#ifndef __U_BOOT__
 				if (set_local_var(p, /*flag:*/ 0)) {
+#else /* __U_BOOT__ */
+				if (set_local_var_modern(p, /*flag:*/ 0)) {
+#endif
 					/* assignment to readonly var / putenv error? */
 					rcode = 1;
 				}
@@ -9378,6 +9814,7 @@ static NOINLINE int run_pipe(struct pipe *pi)
 		}
 
 		old_vars = NULL;
+#ifndef __U_BOOT__
 		sv_shadowed = G.shadowed_vars_pp;
 
 		/* Check if argv[0] matches any functions (this goes before bltins) */
@@ -9501,8 +9938,10 @@ static NOINLINE int run_pipe(struct pipe *pi)
 		debug_leave();
 		debug_printf_exec("run_pipe return %d\n", rcode);
 		return rcode;
+#endif /* !__U_BOOT__ */
 	}
 
+#ifndef __U_BOOT__
  must_fork:
 	/* NB: argv_expanded may already be created, and that
 	 * might include `cmd` runs! Do not rerun it! We *must*
@@ -9511,9 +9950,11 @@ static NOINLINE int run_pipe(struct pipe *pi)
 	/* Going to fork a child per each pipe member */
 	pi->alive_cmds = 0;
 	next_infd = 0;
+#endif /* !__U_BOOT__ */
 
 	cmd_no = 0;
 	while (cmd_no < pi->num_cmds) {
+#ifndef __U_BOOT__
 		struct fd_pair pipefds;
 #if !BB_MMU
 		int sv_var_nest_level = G.var_nest_level;
@@ -9522,6 +9963,7 @@ static NOINLINE int run_pipe(struct pipe *pi)
 		nommu_save.argv = NULL;
 		nommu_save.argv_from_re_execing = NULL;
 #endif
+#endif /* !__U_BOOT__ */
 		command = &pi->cmds[cmd_no];
 		cmd_no++;
 		if (command->argv) {
@@ -9531,6 +9973,7 @@ static NOINLINE int run_pipe(struct pipe *pi)
 			debug_printf_exec(": pipe member with no argv\n");
 		}
 
+#ifndef __U_BOOT__
 		/* pipes are inserted between pairs of commands */
 		pipefds.rd = 0;
 		pipefds.wr = 1;
@@ -9633,17 +10076,30 @@ static NOINLINE int run_pipe(struct pipe *pi)
 			close(pipefds.wr);
 		/* Pass read (output) pipe end to next iteration */
 		next_infd = pipefds.rd;
+#else /* __U_BOOT__ */
+		/* Process the command */
+		rcode = cmd_process(G.do_repeat ? CMD_FLAG_REPEAT : 0,
+				    command->argc, command->argv,
+				    &(G.flag_repeat), NULL);
+#endif /* __U_BOOT__ */
 	}
 
+#ifndef __U_BOOT__
 	if (!pi->alive_cmds) {
 		debug_leave();
 		debug_printf_exec("run_pipe return 1 (all forks failed, no children)\n");
 		return 1;
 	}
+#endif /* __U_BOOT__ */
 
 	debug_leave();
+#ifndef __U_BOOT__
 	debug_printf_exec("run_pipe return -1 (%u children started)\n", pi->alive_cmds);
 	return -1;
+#else /* __U_BOOT__ */
+	debug_printf_exec("run_pipe return %d\n", rcode);
+	return rcode;
+#endif /* __U_BOOT__ */
 }
 
 /* NB: called by pseudo_exec, and therefore must not modify any
@@ -9670,8 +10126,10 @@ static int run_list(struct pipe *pi)
 	smallint last_rword; /* ditto */
 #endif
 
+#ifndef __U_BOOT__
 	debug_printf_exec("run_list start lvl %d\n", G.run_list_level);
 	debug_enter();
+#endif /* !__U_BOOT__ */
 
 #if ENABLE_HUSH_LOOPS
 	/* Check syntax for "for" */
@@ -9719,10 +10177,15 @@ static int run_list(struct pipe *pi)
 	rcode = G.last_exitcode;
 
 	/* Go through list of pipes, (maybe) executing them. */
+#ifndef __U_BOOT__
 	for (; pi; pi = IF_HUSH_LOOPS(rword == RES_DONE ? loop_top : ) pi->next) {
+#else /* __U_BOOT__ */
+	for (; pi; pi = pi->next) {
+#endif /* __U_BOOT__ */
 		int r;
 		int sv_errexit_depth;
 
+#ifndef __U_BOOT__
 		if (G.flag_SIGINT)
 			break;
 		if (G_flag_return_in_progress == 1)
@@ -9732,6 +10195,7 @@ static int run_list(struct pipe *pi)
 		debug_printf_exec(": rword=%d cond_code=%d last_rword=%d\n",
 				rword, cond_code, last_rword);
 
+#endif /* !__U_BOOT__ */
 		sv_errexit_depth = G.errexit_depth;
 		if (
 #if ENABLE_HUSH_IF
@@ -9885,8 +10349,10 @@ static int run_list(struct pipe *pi)
 		 * OTOH, in non-interactive shell this is useless
 		 * and only leads to extra job checks */
 		if (pi->num_cmds == 0) {
+#ifndef __U_BOOT__
 			if (G_interactive_fd)
 				goto check_jobs_and_continue;
+#endif /* !__U_BOOT__ */
 			continue;
 		}
 
@@ -9895,20 +10361,33 @@ static int run_list(struct pipe *pi)
 		 * after run_pipe to collect any background children,
 		 * even if list execution is to be stopped. */
 		debug_printf_exec(": run_pipe with %d members\n", pi->num_cmds);
+#ifndef __U_BOOT__
 #if ENABLE_HUSH_LOOPS
 		G.flag_break_continue = 0;
 #endif
+#endif /* !__U_BOOT__ */
 		rcode = r = run_pipe(pi); /* NB: rcode is a smalluint, r is int */
+#ifdef __U_BOOT__
+		if (r == -2) {
+			/* -2 indicates exit was called, so we need to quit now. */
+			G.last_exitcode = rcode;
+
+			break;
+		}
+#endif
 		if (r != -1) {
 			/* We ran a builtin, function, or group.
 			 * rcode is already known
 			 * and we don't need to wait for anything. */
 			debug_printf_exec(": builtin/func exitcode %d\n", rcode);
 			G.last_exitcode = rcode;
+#ifndef __U_BOOT__
 			check_and_run_traps();
+#endif /* !__U_BOOT__ */
 #if ENABLE_HUSH_TRAP && ENABLE_HUSH_FUNCTIONS
 			rcode = G.last_exitcode; /* "return" in trap can change it, read back */
 #endif
+#ifndef __U_BOOT__
 #if ENABLE_HUSH_LOOPS
 			/* Was it "break" or "continue"? */
 			if (G.flag_break_continue) {
@@ -9934,6 +10413,7 @@ static int run_list(struct pipe *pi)
 				checkjobs(NULL, 0 /*(no pid to wait for)*/);
 				break;
 			}
+
 		} else if (pi->followup == PIPE_BG) {
 			/* What does bash do with attempts to background builtins? */
 			/* even bash 3.2 doesn't do that well with nested bg:
@@ -9969,13 +10449,18 @@ static int run_list(struct pipe *pi)
 			rcode = G.last_exitcode; /* "return" in trap can change it, read back */
 #endif
 		}
+#endif /* !__U_BOOT__ */
 
+#ifndef __U_BOOT__
 		/* Handle "set -e" */
 		if (rcode != 0 && G.o_opt[OPT_O_ERREXIT]) {
 			debug_printf_exec("ERREXIT:1 errexit_depth:%d\n", G.errexit_depth);
 			if (G.errexit_depth == 0)
 				hush_exit(rcode);
 		}
+#else /* __U_BOOT__ */
+		} /* if (r != -1) */
+#endif /* __U_BOOT__ */
 		G.errexit_depth = sv_errexit_depth;
 
 		/* Analyze how result affects subsequent commands */
@@ -9983,8 +10468,10 @@ static int run_list(struct pipe *pi)
 		if (rword == RES_IF || rword == RES_ELIF)
 			cond_code = rcode;
 #endif
+#ifndef __U_BOOT__
  check_jobs_and_continue:
 		checkjobs(NULL, 0 /*(no pid to wait for)*/);
+#endif /* !__U_BOOT__ */
  dont_check_jobs_but_continue: ;
 #if ENABLE_HUSH_LOOPS
 		/* Beware of "while false; true; do ..."! */
@@ -10021,8 +10508,10 @@ static int run_list(struct pipe *pi)
 #if ENABLE_HUSH_CASE
 	free(case_word);
 #endif
+#ifndef __U_BOOT__
 	debug_leave();
 	debug_printf_exec("run_list lvl %d return %d\n", G.run_list_level + 1, rcode);
+#endif /* !__U_BOOT__ */
 	return rcode;
 }
 
@@ -10031,10 +10520,14 @@ static int run_and_free_list(struct pipe *pi)
 {
 	int rcode = 0;
 	debug_printf_exec("run_and_free_list entered\n");
+#ifndef __U_BOOT__
 	if (!G.o_opt[OPT_O_NOEXEC]) {
+#endif /* !__U_BOOT__ */
 		debug_printf_exec(": run_list: 1st pipe with %d cmds\n", pi->num_cmds);
 		rcode = run_list(pi);
+#ifndef __U_BOOT__
 	}
+#endif /* !__U_BOOT__ */
 	/* free_pipe_list has the side effect of clearing memory.
 	 * In the long run that function can be merged with run_list,
 	 * but doing that now would hobble the debugging effort. */
@@ -10044,6 +10537,7 @@ static int run_and_free_list(struct pipe *pi)
 }
 
 
+#ifndef __U_BOOT__
 static void install_sighandlers(unsigned mask)
 {
 	sighandler_t old_handler;
@@ -10460,6 +10954,7 @@ int hush_main(int argc, char **argv)
 		}
 	}
 
+#ifndef __U_BOOT__
 	/* -c takes effect *after* -l */
 	if (G.opt_c) {
 		/* Possibilities:
@@ -10536,6 +11031,7 @@ int hush_main(int argc, char **argv)
 	/* "implicit" -s: bare interactive hush shows 's' in $- */
 	G.opt_s = 1;
 
+#endif /* __U_BOOT__ */
 	/* Up to here, shell was non-interactive. Now it may become one.
 	 * NB: don't forget to (re)run install_special_sighandlers() as needed.
 	 */
@@ -10681,6 +11177,7 @@ int hush_main(int argc, char **argv)
 }
 
 
+
 /*
  * Built-ins
  */
@@ -12160,3 +12657,4 @@ static int FAST_FUNC builtin_memleak(char **argv UNUSED_PARAM)
 	return l;
 }
 #endif
+#endif /* !__U_BOOT__ */
-- 
2.34.1

