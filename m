Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85565C43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:47:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F05CA84BF2;
	Wed,  1 Jul 2026 13:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XLJSbsJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E49184BF2; Wed,  1 Jul 2026 13:47:12 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C372584BE4
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-44856d185bcso275561fac.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782906428; x=1783511228; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wvcMVoh8h+oQgqiqXdjH1pxKBnp4/pa+cdgnM+nszXY=;
 b=XLJSbsJu1J7pEL2Pg0JEXAKJV8q8HsIqyPFaXCgQ14pC+nGHTkRo7mkmmfl5HSusZ6
 K6qAsXq0ELl0fhyWwya24UC4V2WsR/Hip/lOHSubTPxGM2V0Al52mEghV+R0vmCzxTKl
 9VI3wVHvDAuIPlCgino1/uuRPnNfN2cjbTF1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782906428; x=1783511228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wvcMVoh8h+oQgqiqXdjH1pxKBnp4/pa+cdgnM+nszXY=;
 b=OrfIhCGbA1AhWdWCo0lDyIDzZ1zgny3WIzCOm/3ZqWIlteLg8Kj10a4I1XcqZC0Ioj
 Q3ti7UpqrTt5zmJzgA2Lj5P3Nji74MPU89z4YtUH+hzmicB2be7aur6WgZ02doj1Yi5w
 PqGdTIV7urJc8fmzcETTqTE97J14+huJtYa+X+tk8keZ28sBtsJGnyPoCPA/ZRUHp5AO
 dFoYskCcZq34tw5jEJBEncBG0MAkIOpkAErXOKBsOI75PkFYzVG+5hz2pcYWpgCXuTnf
 pFBuKqiXGHxUNht/cClXdurQ3G8SyN65rPpE/j/YxFv2coTOC1X55v8dZXgImO+jxydM
 6Bhw==
X-Gm-Message-State: AOJu0YyuQxLs+tH2Vk3G1Ftx8vcxPnk+CkIVhLL0YOhZbAj3Zn/VTXpQ
 Ms9EAaJHaxwW7Dbzqxq4Kvcy/tG7+e/EACLx9n0qyznNqiqmbr/+l0QUiLxA0APhM9YCvp9Yjse
 kb5c=
X-Gm-Gg: AfdE7cnXJdjRlbjk6vF+sq6hqAHQ692PsvFFRrpAXUVpR5Pds8ep1EddqecGzjolldg
 Ej+X3Fhj7UAk94RiagVxpzFvpRLkfiB99ULoJ3ziOxXrCTlqSwCHAg+XirfBLdWgIRAd/AzwurK
 zYJPJDX4UaF7dnrPBwMuS/D0OnAw/2sCBL7Pu5MsKYckLNonD+8Ae1HgPYLQM9NLzUbD/FeRhqe
 FT7UGuMLTxEbVDJ8QbmYOBtLKGvajy8RL/Re4wIKU8wK8U1kLoXJ08/DQoCsn5rCeimbcLXQvNv
 AVQ1or0dC4czSCbwleDQtpS9oVumm7yS7iOKUEfrJGhnZEUUch2KFIW0zu4PfEr3MzoQ7bKUMxb
 R4Mk4XFLd01rdzA1D5C8j161hL6QO2D54/RsNxMhJq5SSK63sRhO7lx53Vm5ziyCLRAHTYAhxVR
 t1CfQwGJI=
X-Received: by 2002:a05:6808:150b:b0:492:d1c8:e528 with SMTP id
 5614622812f47-4962d863a20mr152653b6e.30.1782906428430; 
 Wed, 01 Jul 2026 04:47:08 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4960655e3e2sm1199823b6e.0.2026.07.01.04.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 04:47:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Adam Lackorzynski <adam@l4re.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 05/14] command: Support a getopt-based command signature
Date: Wed,  1 Jul 2026 05:42:25 -0600
Message-ID: <20260701114248.1396125-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701114248.1396125-1-sjg@chromium.org>
References: <20260701114248.1396125-1-sjg@chromium.org>
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

U-Boot commands take a (cmdtp, flag, argc, argv) argument list, so a
command which parses options must declare a struct getopt_state, call
getopt_init_state() and thread argc/argv through getopt(). This is the
same duplication in every such command.

Add a second command signature which takes a single struct getopt_state
pointer. A command marked with CMDF_GETOPT stores a function of this
type in its ->cmd slot; cmd_invoke() sets up the getopt_state and calls
it. Commands without the flag are called as before, so the two
signatures coexist and commands can be moved over one at a time.

cmd_invoke() builds the state with getopt_init_state(), which already
records argc/argv (and a working copy of argv) in the state, so the
command can reach them through the same pointer. Add U_BOOT_CMD_GETOPT()
for declaring a top-level command and U_BOOT_CMD_MKENT_GETOPT() for a
command-table entry that uses the new signature, along with _COMPLETE
variants that also take an auto-complete function so a getopt command
can still offer tab completion.

The new CMDF_GETOPT flag goes in a cmd_flags byte, which fits in the
padding freed by narrowing maxargs to a short. The two command entries
built by hand rather than through a U_BOOT_CMD_MKENT*() macro (the '['
alias in test and the '?' alias in help) gain an explicit cmd_flags
slot.

Guard the getopt path in cmd_invoke() with CONFIG_IS_ENABLED(GETOPT) so
the getopt_init_state() call compiles out when GETOPT is disabled.
getopt_init_state() lives in lib/getopt.c (built only for
CONFIG_GETOPT), and cmd_invoke() is always-compiled core code, so
without the guard every board that has commands but not GETOPT fails to
link with an undefined reference. Only commands that select GETOPT set
CMDF_GETOPT, so the guard never disables a reachable path.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Guard cmd_invoke() with CONFIG_IS_ENABLED(GETOPT) so boards without
  GETOPT still link

 cmd/help.c        |  2 +-
 cmd/test.c        |  2 +-
 common/command.c  | 20 +++++++++--
 include/command.h | 84 ++++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 100 insertions(+), 8 deletions(-)

diff --git a/cmd/help.c b/cmd/help.c
index 1be83ba607d..b87c19003d4 100644
--- a/cmd/help.c
+++ b/cmd/help.c
@@ -28,7 +28,7 @@ U_BOOT_CMD(
  * nor can we rely on the CONFIG_SYS_LONGHELP helper macro
  */
 ll_entry_declare(struct cmd_tbl, question_mark, cmd) = {
-	"?",	CONFIG_SYS_MAXARGS, cmd_always_repeatable,	do_help,
+	"?",	CONFIG_SYS_MAXARGS, 0, cmd_always_repeatable,	do_help,
 	"alias for 'help'",
 #ifdef  CONFIG_SYS_LONGHELP
 	""
diff --git a/cmd/test.c b/cmd/test.c
index c76ebf800ee..f0b89aa0af0 100644
--- a/cmd/test.c
+++ b/cmd/test.c
@@ -244,7 +244,7 @@ U_BOOT_CMD(
  * This does not use the U_BOOT_CMD macro as [ can't be used in symbol names
  */
 ll_entry_declare(struct cmd_tbl, lbracket, cmd) = {
-	"[",	CONFIG_SYS_MAXARGS, cmd_always_repeatable, do_test,
+	"[",	CONFIG_SYS_MAXARGS, 0, cmd_always_repeatable, do_test,
 	"alias for 'test'",
 #ifdef CONFIG_SYS_LONGHELP
 	" <test expression> ]"
diff --git a/common/command.c b/common/command.c
index eb2c2123534..c747bef7883 100644
--- a/common/command.c
+++ b/common/command.c
@@ -13,6 +13,7 @@
 #include <command.h>
 #include <console.h>
 #include <env.h>
+#include <getopt.h>
 #include <image.h>
 #include <log.h>
 #include <mapmem.h>
@@ -542,12 +543,27 @@ void fixup_cmdtable(struct cmd_tbl *cmdtp, int size)
 	}
 }
 
+int cmd_invoke(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	if (CONFIG_IS_ENABLED(GETOPT) && (cmdtp->cmd_flags & CMDF_GETOPT)) {
+		int (*func)(struct getopt_state *gs);
+		struct getopt_state gs;
+
+		func = (int (*)(struct getopt_state *))cmdtp->cmd;
+		getopt_init_state(&gs, argc, argv);
+
+		return func(&gs);
+	}
+
+	return cmdtp->cmd(cmdtp, flag, argc, argv);
+}
+
 int cmd_always_repeatable(struct cmd_tbl *cmdtp, int flag, int argc,
 			  char *const argv[], int *repeatable)
 {
 	*repeatable = 1;
 
-	return cmdtp->cmd(cmdtp, flag, argc, argv);
+	return cmd_invoke(cmdtp, flag, argc, argv);
 }
 
 int cmd_never_repeatable(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -555,7 +571,7 @@ int cmd_never_repeatable(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	*repeatable = 0;
 
-	return cmdtp->cmd(cmdtp, flag, argc, argv);
+	return cmd_invoke(cmdtp, flag, argc, argv);
 }
 
 int cmd_discard_repeatable(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/include/command.h b/include/command.h
index 2e9646c97fb..495d6a07d75 100644
--- a/include/command.h
+++ b/include/command.h
@@ -13,7 +13,9 @@
 #include <linker_lists.h>
 #include <limits.h>
 
+#include <linux/bitops.h>
 #include <linux/compiler_attributes.h>
+#include <linux/types.h>
 
 #ifndef NULL
 #define NULL	0
@@ -36,6 +38,7 @@
 struct cmd_tbl {
 	char		*name;		/* Command Name			*/
 	short		maxargs;	/* maximum number of arguments	*/
+	u8		cmd_flags;	/* CMDF_... flags		*/
 					/*
 					 * Same as ->cmd() except the command
 					 * tells us if it can be repeated.
@@ -66,6 +69,15 @@ struct cmd_tbl {
  */
 #define CMD_MAXARGS	SHRT_MAX
 
+/* Values for cmd_tbl->cmd_flags */
+enum {
+	/*
+	 * ->cmd holds a function with the getopt_state signature
+	 * (int (*)(struct getopt_state *)) instead of the classic one
+	 */
+	CMDF_GETOPT	= BIT(0),
+};
+
 /**
  * cmd_arg_get() - Get a particular argument
  *
@@ -116,6 +128,20 @@ int complete_subcmdv(struct cmd_tbl *cmdtp, int count, int argc,
 
 int cmd_usage(const struct cmd_tbl *cmdtp);
 
+/**
+ * cmd_invoke() - Call a command's implementation function
+ * @cmdtp: Command to call
+ * @flag: Command flags (CMD_FLAG_...)
+ * @argc: Number of arguments
+ * @argv: Argument list
+ *
+ * This calls @cmdtp->cmd, handling both the classic command signature
+ * and the &struct getopt_state signature (CMDF_GETOPT).
+ *
+ * Return: result of the command (0 if OK, else CMD_RET_...)
+ */
+int cmd_invoke(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+
 /* Dummy ->cmd and ->cmd_rep wrappers. */
 int cmd_always_repeatable(struct cmd_tbl *cmdtp, int flag, int argc,
 			  char *const argv[], int *repeatable);
@@ -417,20 +443,43 @@ int cmd_source_script(ulong addr, const char *fit_uname, const char *confname);
 #if CONFIG_IS_ENABLED(CMDLINE)
 #define U_BOOT_CMDREP_MKENT_COMPLETE(_name, _maxargs, _cmd_rep,		\
 				     _usage, _help, _comp)		\
-		{ #_name, _maxargs, _cmd_rep, cmd_discard_repeatable,	\
+		{ #_name, _maxargs, 0, _cmd_rep, cmd_discard_repeatable,	\
 		  _usage, _CMD_HELP(_help) _CMD_COMPLETE(_comp) }
 
 #define U_BOOT_CMD_MKENT_COMPLETE(_name, _maxargs, _rep, _cmd,		\
 				_usage, _help, _comp)			\
-		{ #_name, _maxargs,					\
+		{ #_name, _maxargs, 0,					\
 		 _rep ? cmd_always_repeatable : cmd_never_repeatable,	\
 		 _cmd, _usage, _CMD_HELP(_help) _CMD_COMPLETE(_comp) }
 
+#define U_BOOT_CMD_MKENT_GETOPT_COMPLETE(_name, _maxargs, _rep, _cmd,	\
+					 _usage, _help, _comp)		\
+		{ #_name, _maxargs, CMDF_GETOPT,			\
+		 _rep ? cmd_always_repeatable : cmd_never_repeatable,	\
+		 (int (*)(struct cmd_tbl *, int, int,			\
+			  char *const []))(_cmd),			\
+		 _usage, _CMD_HELP(_help) _CMD_COMPLETE(_comp) }
+
+#define U_BOOT_CMD_MKENT_GETOPT(_name, _maxargs, _rep, _cmd,		\
+				_usage, _help)				\
+	U_BOOT_CMD_MKENT_GETOPT_COMPLETE(_name, _maxargs, _rep, _cmd,	\
+					 _usage, _help, NULL)
+
 #define U_BOOT_CMD_COMPLETE(_name, _maxargs, _rep, _cmd, _usage, _help, _comp) \
 	ll_entry_declare(struct cmd_tbl, _name, cmd) =			\
 		U_BOOT_CMD_MKENT_COMPLETE(_name, _maxargs, _rep, _cmd,	\
 						_usage, _help, _comp)
 
+#define U_BOOT_CMD_GETOPT(_name, _maxargs, _rep, _cmd, _usage, _help)	\
+	U_BOOT_CMD_GETOPT_COMPLETE(_name, _maxargs, _rep, _cmd,		\
+				   _usage, _help, NULL)
+
+#define U_BOOT_CMD_GETOPT_COMPLETE(_name, _maxargs, _rep, _cmd, _usage,	\
+				   _help, _comp)			\
+	ll_entry_declare(struct cmd_tbl, _name, cmd) =			\
+		U_BOOT_CMD_MKENT_GETOPT_COMPLETE(_name, _maxargs, _rep,	\
+						 _cmd, _usage, _help, _comp)
+
 #define U_BOOT_CMDREP_COMPLETE(_name, _maxargs, _cmd_rep, _usage,	\
 			       _help, _comp)				\
 	ll_entry_declare(struct cmd_tbl, _name, cmd) =			\
@@ -457,20 +506,47 @@ int cmd_source_script(ulong addr, const char *fit_uname, const char *confname);
 		return 0;						\
 	}
 
+#define _CMD_REMOVE_GETOPT(_name, _cmd)					\
+	int __remove_ ## _name(void)					\
+	{								\
+		if (0)							\
+			_cmd(NULL);					\
+		return 0;						\
+	}
+
 #define U_BOOT_CMDREP_MKENT_COMPLETE(_name, _maxargs, _cmd_rep,		\
 				     _usage, _help, _comp)		\
-		{ #_name, _maxargs, 0 ? _cmd_rep : NULL, NULL, _usage,	\
+		{ #_name, _maxargs, 0, 0 ? _cmd_rep : NULL, NULL, _usage, \
 			_CMD_HELP(_help) _CMD_COMPLETE(_comp) }
 
 #define U_BOOT_CMD_MKENT_COMPLETE(_name, _maxargs, _rep, _cmd, _usage,	\
 				  _help, _comp)				\
-		{ #_name, _maxargs, NULL, 0 ? _cmd : NULL, _usage,	\
+		{ #_name, _maxargs, 0, NULL, 0 ? _cmd : NULL, _usage,	\
+			_CMD_HELP(_help) _CMD_COMPLETE(_comp) }
+
+#define U_BOOT_CMD_MKENT_GETOPT_COMPLETE(_name, _maxargs, _rep, _cmd,	\
+					 _usage, _help, _comp)		\
+		{ #_name, _maxargs, CMDF_GETOPT, NULL,			\
+		 0 ? (int (*)(struct cmd_tbl *, int, int,		\
+			      char *const []))(_cmd) : NULL, _usage,	\
 			_CMD_HELP(_help) _CMD_COMPLETE(_comp) }
 
+#define U_BOOT_CMD_MKENT_GETOPT(_name, _maxargs, _rep, _cmd,		\
+				_usage, _help)				\
+	U_BOOT_CMD_MKENT_GETOPT_COMPLETE(_name, _maxargs, _rep, _cmd,	\
+					 _usage, _help, NULL)
+
 #define U_BOOT_CMD_COMPLETE(_name, _maxargs, _rep, _cmd, _usage, _help,	\
 			    _comp)				\
 	_CMD_REMOVE(sub_ ## _name, _cmd)
 
+#define U_BOOT_CMD_GETOPT(_name, _maxargs, _rep, _cmd, _usage, _help)	\
+	_CMD_REMOVE_GETOPT(sub_ ## _name, _cmd)
+
+#define U_BOOT_CMD_GETOPT_COMPLETE(_name, _maxargs, _rep, _cmd, _usage,	\
+				   _help, _comp)			\
+	_CMD_REMOVE_GETOPT(sub_ ## _name, _cmd)
+
 #define U_BOOT_CMDREP_COMPLETE(_name, _maxargs, _cmd_rep, _usage,	\
 			       _help, _comp)				\
 	_CMD_REMOVE_REP(sub_ ## _name, _cmd_rep)
-- 
2.43.0

