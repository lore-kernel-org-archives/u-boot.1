Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBFDC43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:47:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B3D184BC6;
	Wed,  1 Jul 2026 13:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lKRvZNor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CCC984BEE; Wed,  1 Jul 2026 13:47:15 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD1F984BE4
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-495b250b01cso432053b6e.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782906431; x=1783511231; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0U5E2wfmje3WjYcIdjsUDgFcPaDU2s2IrUMd2T06Mkc=;
 b=lKRvZNorVHv0OSce3MjwpB14tpAcWLIKHmX+ozv3y86fO5XzQwBFWKo5+toMOmNxGE
 7XWghNxJdFDBLB74tvKmBX+LbJDThv8bY9BSCsUl6FOMcRYsR+GOGw9BmO6/n0GmuYtA
 pfFRHuRy2TbpFuSa6FDeV9WEE5fseXCuzlBos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782906431; x=1783511231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0U5E2wfmje3WjYcIdjsUDgFcPaDU2s2IrUMd2T06Mkc=;
 b=gqaz5AeXob6a4XcR6pyiqvHsNDq4lKMa/CmZv7NKFSXrpwZHgDMHXzntTFmFsjSGYS
 KdlTbBOY6HaXjlMm5z5ltoiuqzES/vVZeEfidywT/fF7dL5w3XhcYHyCx88ZrnOHVZd9
 WfidFVEeWUdxuqKn56JD2OddCzscky1598HU5wrrg1VvooVwSCZqDL6So1nd6V/pKlfj
 F8KDQuz+c/VG8+AfKOMAe4HSJ6ez5tAeZXGmkXn6jTS2Xm1ThfZR+mgePytHM1sQooRp
 Yi0o5aurVtFe/U9qtGxN2evNkSdzMBsktDAIvNESwdLBDLLb/DP9Js6RMsso4y+v2l6c
 z3SQ==
X-Gm-Message-State: AOJu0YzNAf6vOFwRplasjGR2hcqYyPI9ZBUMoO3anZUnAJ0sAemWkCr5
 dZXL3d0KEWpNLLFuDf1S6c6cJxq9tnRpzPk8q+3ApWIsyENEyoyF6+4RsKzvHeuRos74jFcdmeU
 UruU=
X-Gm-Gg: AfdE7cmUFGc1JE29jQVrRSJhgDOKzoLYZeVYefZHIBD8LUAVzN8pjVoSIhW7FiPRBVZ
 8/UGOG/KcZThZYOKG8XHAQdeAMYF/ojDyajwlCLETjbAcldslrH3djsGGhlk0/c7DuoUuO7Qf5+
 UIsXP9bQwgER/2+MBRvchUJb+8cNQTE0wEWMc+VKaL+sCEX93jhB2BqTPFk5o6BWy06Dym5wOmL
 LqreRsGy0E1IZpJ9qbXE7C16s4CMOw/4ZSH9FwazjDbAu53vmArzsJWgtiNMk0T494IUonl2NTO
 D2cT3zCOFA2f5UDDjbkKP7EAue39R7Dy6nBpzMr37jyNA+Aff9bWY9XwbYsE5NLt0aHUYbzoVC9
 zM2wEgIuNE2t7ic35hqK1lSQy7hpE/d8nV7lm+NnJxVmmhu5Q0jcC7920rvd54AujeAl/V+1Cq5
 tw1bVfT8E=
X-Received: by 2002:a05:6808:308d:b0:495:f293:61ce with SMTP id
 5614622812f47-4962d9730demr178844b6e.21.1782906431534; 
 Wed, 01 Jul 2026 04:47:11 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4960655e3e2sm1199823b6e.0.2026.07.01.04.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 04:47:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Adam Lackorzynski <adam@l4re.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 06/14] command: Replace the cmd_rep pointer with a
 CMDF_REPEATABLE flag
Date: Wed,  1 Jul 2026 05:42:26 -0600
Message-ID: <20260701114248.1396125-7-sjg@chromium.org>
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

Each struct cmd_tbl entry carries a ->cmd_rep function pointer used to
report whether a command may be repeated by pressing Enter at an empty
prompt. For all but one command it points at cmd_always_repeatable() or
cmd_never_repeatable(), trampolines that just set the repeatable flag
and call cmd_invoke() - so a whole pointer per command encodes a single
bit, on every board.

Replace it with a CMDF_REPEATABLE flag in the existing cmd_flags byte.
The _rep argument of the U_BOOT_CMD*() macros now sets this bit, and
cmd_call() reads it directly before invoking ->cmd, dropping the
trampolines entirely.

Sub-command dispatchers (U_BOOT_CMD_WITH_SUBCMDS, and the x86 zboot
command) still need to report the repeatability of the sub-command they
pick, which they do through the extended (..., int *repeatable)
signature. Keep that ability with a CMDF_SUBCMD_REP flag: such a command
stores its dispatcher in ->cmd and is tagged CMDF_SUBCMD_REP, and
cmd_call() calls it with the repeatable pointer. The dispatcher refines
*repeatable from the chosen sub-command's CMDF_REPEATABLE bit.

This removes a pointer from every struct cmd_tbl entry: the struct
shrinks from 56 to 48 bytes on 64-bit and by 4 bytes per entry on
32-bit, with no change in behaviour and no new config option. On
turris_1x_nor (ppc32, ~100 commands) this recovers about 670 bytes,
enough to keep the board within its NOR section after the getopt
conversion.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add new patch to replace the ->cmd_rep pointer with a
  CMDF_REPEATABLE flag, dropping a pointer from every command entry

 cmd/help.c        |   2 +-
 cmd/test.c        |   2 +-
 cmd/x86/zboot.c   |   2 +-
 common/command.c  |  44 +++++++-------------
 include/command.h | 104 ++++++++++++++++++++++------------------------
 5 files changed, 67 insertions(+), 87 deletions(-)

diff --git a/cmd/help.c b/cmd/help.c
index b87c19003d4..ab6f9c95739 100644
--- a/cmd/help.c
+++ b/cmd/help.c
@@ -28,7 +28,7 @@ U_BOOT_CMD(
  * nor can we rely on the CONFIG_SYS_LONGHELP helper macro
  */
 ll_entry_declare(struct cmd_tbl, question_mark, cmd) = {
-	"?",	CONFIG_SYS_MAXARGS, 0, cmd_always_repeatable,	do_help,
+	"?",	CONFIG_SYS_MAXARGS, CMDF_REPEATABLE,	do_help,
 	"alias for 'help'",
 #ifdef  CONFIG_SYS_LONGHELP
 	""
diff --git a/cmd/test.c b/cmd/test.c
index f0b89aa0af0..32c5238972d 100644
--- a/cmd/test.c
+++ b/cmd/test.c
@@ -244,7 +244,7 @@ U_BOOT_CMD(
  * This does not use the U_BOOT_CMD macro as [ can't be used in symbol names
  */
 ll_entry_declare(struct cmd_tbl, lbracket, cmd) = {
-	"[",	CONFIG_SYS_MAXARGS, 0, cmd_always_repeatable, do_test,
+	"[",	CONFIG_SYS_MAXARGS, CMDF_REPEATABLE, do_test,
 	"alias for 'test'",
 #ifdef CONFIG_SYS_LONGHELP
 	" <test expression> ]"
diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index 3876d163236..ef3e27e622d 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -165,7 +165,7 @@ int do_zboot_parent(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_FAILURE;
 }
 
-U_BOOT_CMDREP_COMPLETE(
+U_BOOT_SUBCMD_DECL(
 	zboot, 8, do_zboot_parent, "Boot bzImage",
 	"[addr] [size] [initrd addr] [initrd size] [setup] [cmdline]\n"
 	"      addr -        The optional starting address of the bzimage.\n"
diff --git a/common/command.c b/common/command.c
index c747bef7883..4204c6e2df2 100644
--- a/common/command.c
+++ b/common/command.c
@@ -508,11 +508,6 @@ void fixup_cmdtable(struct cmd_tbl *cmdtp, int size)
 	for (i = 0; i < size; i++) {
 		ulong addr;
 
-		addr = (ulong)(cmdtp->cmd_rep) + gd->reloc_off;
-		cmdtp->cmd_rep =
-			(int (*)(struct cmd_tbl *, int, int,
-				 char * const [], int *))addr;
-
 		addr = (ulong)(cmdtp->cmd) + gd->reloc_off;
 #ifdef DEBUG_COMMANDS
 		printf("Command \"%s\": 0x%08lx => 0x%08lx\n",
@@ -558,30 +553,6 @@ int cmd_invoke(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return cmdtp->cmd(cmdtp, flag, argc, argv);
 }
 
-int cmd_always_repeatable(struct cmd_tbl *cmdtp, int flag, int argc,
-			  char *const argv[], int *repeatable)
-{
-	*repeatable = 1;
-
-	return cmd_invoke(cmdtp, flag, argc, argv);
-}
-
-int cmd_never_repeatable(struct cmd_tbl *cmdtp, int flag, int argc,
-			 char *const argv[], int *repeatable)
-{
-	*repeatable = 0;
-
-	return cmd_invoke(cmdtp, flag, argc, argv);
-}
-
-int cmd_discard_repeatable(struct cmd_tbl *cmdtp, int flag, int argc,
-			   char *const argv[])
-{
-	int repeatable;
-
-	return cmdtp->cmd_rep(cmdtp, flag, argc, argv, &repeatable);
-}
-
 /**
  * Call a command function. This should be the only route in U-Boot to call
  * a command, so that we can track whether we are waiting for input or
@@ -599,7 +570,20 @@ static int cmd_call(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	int result;
 
-	result = cmdtp->cmd_rep(cmdtp, flag, argc, argv, repeatable);
+	*repeatable = !!(cmdtp->cmd_flags & CMDF_REPEATABLE);
+
+	if (cmdtp->cmd_flags & CMDF_SUBCMD_REP) {
+		/*
+		 * A sub-command dispatcher refines *repeatable for the
+		 * sub-command it picks, so call it with the extended signature.
+		 */
+		cmd_rep_func_t func = (cmd_rep_func_t)cmdtp->cmd;
+
+		result = func(cmdtp, flag, argc, argv, repeatable);
+	} else {
+		result = cmd_invoke(cmdtp, flag, argc, argv);
+	}
+
 	if (result)
 		debug("Command failed, result=%d\n", result);
 	return result;
diff --git a/include/command.h b/include/command.h
index 495d6a07d75..b201100870a 100644
--- a/include/command.h
+++ b/include/command.h
@@ -39,16 +39,6 @@ struct cmd_tbl {
 	char		*name;		/* Command Name			*/
 	short		maxargs;	/* maximum number of arguments	*/
 	u8		cmd_flags;	/* CMDF_... flags		*/
-					/*
-					 * Same as ->cmd() except the command
-					 * tells us if it can be repeated.
-					 * Replaces the old ->repeatable field
-					 * which was not able to make
-					 * repeatable property different for
-					 * the main command and sub-commands.
-					 */
-	int		(*cmd_rep)(struct cmd_tbl *cmd, int flags, int argc,
-				   char *const argv[], int *repeatable);
 					/* Implementation function	*/
 	int		(*cmd)(struct cmd_tbl *cmd, int flags, int argc,
 			       char *const argv[]);
@@ -76,8 +66,24 @@ enum {
 	 * (int (*)(struct getopt_state *)) instead of the classic one
 	 */
 	CMDF_GETOPT	= BIT(0),
+	/* the command may be repeated by pressing Enter at an empty prompt */
+	CMDF_REPEATABLE	= BIT(1),
+	/*
+	 * ->cmd holds a sub-command dispatcher with the extended signature
+	 * (..., int *repeatable), so it can report the repeatable property of
+	 * the sub-command it dispatched to. cmd_call() calls it accordingly.
+	 */
+	CMDF_SUBCMD_REP	= BIT(2),
 };
 
+/*
+ * Type of a sub-command dispatcher (a CMDF_SUBCMD_REP command's ->cmd). It has
+ * the classic command arguments plus a @repeatable output which it sets from
+ * the sub-command it dispatches to.
+ */
+typedef int (*cmd_rep_func_t)(struct cmd_tbl *cmdtp, int flag, int argc,
+			      char *const argv[], int *repeatable);
+
 /**
  * cmd_arg_get() - Get a particular argument
  *
@@ -142,17 +148,9 @@ int cmd_usage(const struct cmd_tbl *cmdtp);
  */
 int cmd_invoke(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
-/* Dummy ->cmd and ->cmd_rep wrappers. */
-int cmd_always_repeatable(struct cmd_tbl *cmdtp, int flag, int argc,
-			  char *const argv[], int *repeatable);
-int cmd_never_repeatable(struct cmd_tbl *cmdtp, int flag, int argc,
-			 char *const argv[], int *repeatable);
-int cmd_discard_repeatable(struct cmd_tbl *cmdtp, int flag, int argc,
-			   char *const argv[]);
-
 static inline bool cmd_is_repeatable(struct cmd_tbl *cmdtp)
 {
-	return cmdtp->cmd_rep == cmd_always_repeatable;
+	return cmdtp->cmd_flags & CMDF_REPEATABLE;
 }
 
 #ifdef CONFIG_AUTO_COMPLETE
@@ -416,8 +414,9 @@ int cmd_source_script(ulong addr, const char *fit_uname, const char *confname);
 		    !cmd_is_repeatable(subcmd))				\
 			return CMD_RET_SUCCESS;				\
 									\
-		return subcmd->cmd_rep(subcmd, flag, argc - 1,		\
-				       argv + 1, repeatable);		\
+		*repeatable &= cmd_is_repeatable(subcmd);		\
+									\
+		return cmd_invoke(subcmd, flag, argc - 1, argv + 1);	\
 	}
 
 #ifdef CONFIG_AUTO_COMPLETE
@@ -441,21 +440,17 @@ int cmd_source_script(ulong addr, const char *fit_uname, const char *confname);
 	U_BOOT_SUBCMDS_COMPLETE(_cmdname)
 
 #if CONFIG_IS_ENABLED(CMDLINE)
-#define U_BOOT_CMDREP_MKENT_COMPLETE(_name, _maxargs, _cmd_rep,		\
-				     _usage, _help, _comp)		\
-		{ #_name, _maxargs, 0, _cmd_rep, cmd_discard_repeatable,	\
-		  _usage, _CMD_HELP(_help) _CMD_COMPLETE(_comp) }
+/* Encode the _rep argument as the CMDF_REPEATABLE flag bit */
+#define _CMD_REP_FLAG(_rep)	((_rep) ? CMDF_REPEATABLE : 0)
 
 #define U_BOOT_CMD_MKENT_COMPLETE(_name, _maxargs, _rep, _cmd,		\
 				_usage, _help, _comp)			\
-		{ #_name, _maxargs, 0,					\
-		 _rep ? cmd_always_repeatable : cmd_never_repeatable,	\
+		{ #_name, _maxargs, _CMD_REP_FLAG(_rep),		\
 		 _cmd, _usage, _CMD_HELP(_help) _CMD_COMPLETE(_comp) }
 
 #define U_BOOT_CMD_MKENT_GETOPT_COMPLETE(_name, _maxargs, _rep, _cmd,	\
 					 _usage, _help, _comp)		\
-		{ #_name, _maxargs, CMDF_GETOPT,			\
-		 _rep ? cmd_always_repeatable : cmd_never_repeatable,	\
+		{ #_name, _maxargs, CMDF_GETOPT | _CMD_REP_FLAG(_rep),	\
 		 (int (*)(struct cmd_tbl *, int, int,			\
 			  char *const []))(_cmd),			\
 		 _usage, _CMD_HELP(_help) _CMD_COMPLETE(_comp) }
@@ -480,11 +475,18 @@ int cmd_source_script(ulong addr, const char *fit_uname, const char *confname);
 		U_BOOT_CMD_MKENT_GETOPT_COMPLETE(_name, _maxargs, _rep,	\
 						 _cmd, _usage, _help, _comp)
 
-#define U_BOOT_CMDREP_COMPLETE(_name, _maxargs, _cmd_rep, _usage,	\
-			       _help, _comp)				\
-	ll_entry_declare(struct cmd_tbl, _name, cmd) =			\
-		U_BOOT_CMDREP_MKENT_COMPLETE(_name, _maxargs, _cmd_rep,	\
-					     _usage, _help, _comp)
+/*
+ * Declare a top-level command whose ->cmd is a sub-command dispatcher with
+ * the extended (..., int *repeatable) signature (see CMDF_SUBCMD_REP). The
+ * dispatcher is stored in ->cmd and tagged so cmd_call() invokes it with the
+ * repeatable pointer.
+ */
+#define U_BOOT_SUBCMD_DECL(_name, _maxargs, _do_cmd, _usage, _help, _comp) \
+	ll_entry_declare(struct cmd_tbl, _name, cmd) = {		\
+		#_name, _maxargs, CMDF_SUBCMD_REP | CMDF_REPEATABLE,	\
+		(int (*)(struct cmd_tbl *, int, int,			\
+			 char *const []))(_do_cmd),			\
+		_usage, _CMD_HELP(_help) _CMD_COMPLETE(_comp) }
 
 #else
 #define U_BOOT_SUBCMD_START(name)	static struct cmd_tbl name[] = {};
@@ -498,14 +500,6 @@ int cmd_source_script(ulong addr, const char *fit_uname, const char *confname);
 		return 0;						\
 	}
 
-#define _CMD_REMOVE_REP(_name, _cmd)					\
-	int __remove_ ## _name(void)					\
-	{								\
-		if (0)							\
-			_cmd(NULL, 0, 0, NULL, NULL);			\
-		return 0;						\
-	}
-
 #define _CMD_REMOVE_GETOPT(_name, _cmd)					\
 	int __remove_ ## _name(void)					\
 	{								\
@@ -514,19 +508,14 @@ int cmd_source_script(ulong addr, const char *fit_uname, const char *confname);
 		return 0;						\
 	}
 
-#define U_BOOT_CMDREP_MKENT_COMPLETE(_name, _maxargs, _cmd_rep,		\
-				     _usage, _help, _comp)		\
-		{ #_name, _maxargs, 0, 0 ? _cmd_rep : NULL, NULL, _usage, \
-			_CMD_HELP(_help) _CMD_COMPLETE(_comp) }
-
 #define U_BOOT_CMD_MKENT_COMPLETE(_name, _maxargs, _rep, _cmd, _usage,	\
 				  _help, _comp)				\
-		{ #_name, _maxargs, 0, NULL, 0 ? _cmd : NULL, _usage,	\
+		{ #_name, _maxargs, 0, 0 ? _cmd : NULL, _usage,		\
 			_CMD_HELP(_help) _CMD_COMPLETE(_comp) }
 
 #define U_BOOT_CMD_MKENT_GETOPT_COMPLETE(_name, _maxargs, _rep, _cmd,	\
 					 _usage, _help, _comp)		\
-		{ #_name, _maxargs, CMDF_GETOPT, NULL,			\
+		{ #_name, _maxargs, CMDF_GETOPT,			\
 		 0 ? (int (*)(struct cmd_tbl *, int, int,		\
 			      char *const []))(_cmd) : NULL, _usage,	\
 			_CMD_HELP(_help) _CMD_COMPLETE(_comp) }
@@ -547,9 +536,16 @@ int cmd_source_script(ulong addr, const char *fit_uname, const char *confname);
 				   _help, _comp)			\
 	_CMD_REMOVE_GETOPT(sub_ ## _name, _cmd)
 
-#define U_BOOT_CMDREP_COMPLETE(_name, _maxargs, _cmd_rep, _usage,	\
-			       _help, _comp)				\
-	_CMD_REMOVE_REP(sub_ ## _name, _cmd_rep)
+#define _CMD_REMOVE_REP(_name, _cmd)					\
+	int __remove_ ## _name(void)					\
+	{								\
+		if (0)							\
+			_cmd(NULL, 0, 0, NULL, NULL);			\
+		return 0;						\
+	}
+
+#define U_BOOT_SUBCMD_DECL(_name, _maxargs, _do_cmd, _usage, _help, _comp) \
+	_CMD_REMOVE_REP(sub_ ## _name, _do_cmd)
 
 #endif /* CONFIG_CMDLINE */
 
@@ -571,7 +567,7 @@ int cmd_source_script(ulong addr, const char *fit_uname, const char *confname);
 
 #define U_BOOT_CMD_WITH_SUBCMDS(_name, _usage, _help, ...)		\
 	U_BOOT_SUBCMDS(_name, __VA_ARGS__)				\
-	U_BOOT_CMDREP_COMPLETE(_name, CONFIG_SYS_MAXARGS, do_##_name,	\
-			       _usage, _help, complete_##_name)
+	U_BOOT_SUBCMD_DECL(_name, CONFIG_SYS_MAXARGS, do_##_name,	\
+			   _usage, _help, complete_##_name)
 
 #endif	/* __COMMAND_H */
-- 
2.43.0

