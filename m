Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4204CE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82FFF86BD6;
	Sun, 24 Sep 2023 22:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F3v+Jxo6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F83186BBB; Sun, 24 Sep 2023 22:40:36 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05F0786ACC
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34fcd361e91so16853335ab.3
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588032; x=1696192832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hckWlsrA1ycDB8d5FIK8L3zSPqG+FE1gESS81VlVAq8=;
 b=F3v+Jxo6p0lYQWFF+JjKisBJAVm/WMqo14x5h55p37Ktt3PRM0tOr9SkJFVeNZ6oFw
 9PblQO7tGz6sn4IcXCakuiANba6hLtwrBRWZkdrQXzDLkISbhIl8VeZYIj8+C7K3ly0n
 BHYzq0bVUrbxUvYWQp2a4e9WSLIbXmToA7BVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588032; x=1696192832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hckWlsrA1ycDB8d5FIK8L3zSPqG+FE1gESS81VlVAq8=;
 b=iBK9kGSunqCRARWTooucx2hjkKOHqpbbC45kcHWapBzBzzzzscMrWAMJvn7+AiZtlJ
 aAlyy12hnqnn6Ix6R08FjfZAzO8mWQ/nfSCPqBaKPB7ExmL8zLB8uWADklkz1T0ZsShf
 xkSdwKirWp7OEPpIhSJe9cXfEiaZhS6Ry5hKsLo7tv0NJham02JY0iQPcVG5i88ik1GU
 hTd9JryQlixvB30UY6upwp+vU8GebPV49h2RLANaU1AnzlQpIdCrOJvhwEPjlnkha+p4
 MF/LjkDqeEKMXswhQUJoK+OkYdsgO4uCltaQ2toLx5D0jITbU/PUar20Sd+AJklo+O82
 nxbA==
X-Gm-Message-State: AOJu0YzAYtW0OPfwAUE0upQyiXEyTz9Ix13047oJKbXBegad7m/uTlVe
 spzORBI1ETjY2T81jmmDduhpxX8YuowSvoM0STg=
X-Google-Smtp-Source: AGHT+IFhLTJuJI15he/q1uL4jsD3ysHW3OgvsrLuSmGBShR9/IDctwOx+peqxItZDMr0qyjmvlmU0w==
X-Received: by 2002:a05:6e02:b42:b0:34c:f2cb:b2c with SMTP id
 f2-20020a056e020b4200b0034cf2cb0b2cmr7715754ilu.19.1695588032494; 
 Sun, 24 Sep 2023 13:40:32 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Roger Knecht <rknecht@pm.me>, Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH 14/25] env: Split out non-command code into a new file
Date: Sun, 24 Sep 2023 14:39:32 -0600
Message-ID: <20230924203953.1829820-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

It is not possible to set environment variables without having
CONFIG_CMD_NVEDIT enabled. When CONFIG_CMDLINE is disabled, we need a
way to set variables.

Split the setting code out into its own file, so that env_set() is
available even when CONFIG_CMDLINE is not. If it is never called, the
code will be dropped at link time.

Update the Makefile rule to only include the env commands when
CONFIG_CMD_NVEDIT is enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/Makefile           |   2 +-
 cmd/nvedit.c           | 122 ++-----------------------------------
 env/Makefile           |   1 +
 env/env_set.c          | 132 +++++++++++++++++++++++++++++++++++++++++
 include/env_internal.h |  23 +++++++
 5 files changed, 161 insertions(+), 119 deletions(-)
 create mode 100644 env/env_set.c

diff --git a/cmd/Makefile b/cmd/Makefile
index 9bebf321c397..5be2b4bd3800 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -240,7 +240,7 @@ endif # !CONFIG_SPL_BUILD
 obj-$(CONFIG_$(SPL_)CMD_TLV_EEPROM) += tlv_eeprom.o
 
 # core command
-obj-y += nvedit.o
+obj-$(CONFIG_$(SPL_)CMDLINE) += nvedit.o
 
 obj-$(CONFIG_CMD_BCM_EXT_UTILS) += broadcom/
 
diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index fe99157fd17b..0c9efa052baf 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -48,20 +48,6 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 #define	MAX_ENV_SIZE	(1 << 20)	/* 1 MiB */
 
-/*
- * This variable is incremented on each do_env_set(), so it can
- * be used via env_get_id() as an indication, if the environment
- * has changed or not. So it is possible to reread an environment
- * variable only if the environment was changed ... done so for
- * example in NetInitLoop()
- */
-static int env_id = 1;
-
-int env_get_id(void)
-{
-	return env_id;
-}
-
 #ifndef CONFIG_SPL_BUILD
 /*
  * Command interface: print one or all environment variables
@@ -194,108 +180,8 @@ DONE:
 
 	return 0;
 }
-#endif
-#endif /* CONFIG_SPL_BUILD */
-
-/*
- * Set a new environment variable,
- * or replace or delete an existing one.
- */
-static int _do_env_set(int flag, int argc, char *const argv[], int env_flag)
-{
-	int   i, len;
-	char  *name, *value, *s;
-	struct env_entry e, *ep;
-
-	debug("Initial value for argc=%d\n", argc);
-
-#if !IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_CMD_NVEDIT_EFI)
-	if (argc > 1 && argv[1][0] == '-' && argv[1][1] == 'e')
-		return do_env_set_efi(NULL, flag, --argc, ++argv);
-#endif
-
-	while (argc > 1 && **(argv + 1) == '-') {
-		char *arg = *++argv;
-
-		--argc;
-		while (*++arg) {
-			switch (*arg) {
-			case 'f':		/* force */
-				env_flag |= H_FORCE;
-				break;
-			default:
-				return CMD_RET_USAGE;
-			}
-		}
-	}
-	debug("Final value for argc=%d\n", argc);
-	name = argv[1];
-
-	if (strchr(name, '=')) {
-		printf("## Error: illegal character '='"
-		       "in variable name \"%s\"\n", name);
-		return 1;
-	}
-
-	env_id++;
-
-	/* Delete only ? */
-	if (argc < 3 || argv[2] == NULL) {
-		int rc = hdelete_r(name, &env_htab, env_flag);
-
-		/* If the variable didn't exist, don't report an error */
-		return rc && rc != -ENOENT ? 1 : 0;
-	}
-
-	/*
-	 * Insert / replace new value
-	 */
-	for (i = 2, len = 0; i < argc; ++i)
-		len += strlen(argv[i]) + 1;
-
-	value = malloc(len);
-	if (value == NULL) {
-		printf("## Can't malloc %d bytes\n", len);
-		return 1;
-	}
-	for (i = 2, s = value; i < argc; ++i) {
-		char *v = argv[i];
-
-		while ((*s++ = *v++) != '\0')
-			;
-		*(s - 1) = ' ';
-	}
-	if (s != value)
-		*--s = '\0';
-
-	e.key	= name;
-	e.data	= value;
-	hsearch_r(e, ENV_ENTER, &ep, &env_htab, env_flag);
-	free(value);
-	if (!ep) {
-		printf("## Error inserting \"%s\" variable, errno=%d\n",
-			name, errno);
-		return 1;
-	}
-
-	return 0;
-}
-
-int env_set(const char *varname, const char *varvalue)
-{
-	const char * const argv[4] = { "setenv", varname, varvalue, NULL };
-
-	/* before import into hashtable */
-	if (!(gd->flags & GD_FLG_ENV_READY))
-		return 1;
-
-	if (varvalue == NULL || varvalue[0] == '\0')
-		return _do_env_set(0, 2, (char * const *)argv, H_PROGRAMMATIC);
-	else
-		return _do_env_set(0, 3, (char * const *)argv, H_PROGRAMMATIC);
-}
+#endif /* CONFIG_CMD_GREPENV */
 
-#ifndef CONFIG_SPL_BUILD
 static int do_env_set(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -455,7 +341,7 @@ int do_env_callback(struct cmd_tbl *cmdtp, int flag, int argc,
 	hwalk_r(&env_htab, print_active_callback);
 	return 0;
 }
-#endif
+#endif /* CONFIG_CMD_ENV_CALLBACK */
 
 #if defined(CONFIG_CMD_ENV_FLAGS)
 static int print_static_flags(const char *var_name, const char *flags,
@@ -528,7 +414,7 @@ int do_env_flags(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	hwalk_r(&env_htab, print_active_flags);
 	return 0;
 }
-#endif
+#endif /* CONFIG_CMD_ENV_FLAGS */
 
 /*
  * Interactively edit an environment variable
@@ -678,7 +564,7 @@ static int do_env_delete(struct cmd_tbl *cmdtp, int flag,
 	}
 	debug("Final value for argc=%d\n", argc);
 
-	env_id++;
+	env_inc_id();
 
 	while (--argc > 0) {
 		char *name = *++argv;
diff --git a/env/Makefile b/env/Makefile
index 673b979fdfa9..5250b6df2cfc 100644
--- a/env/Makefile
+++ b/env/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_$(SPL_TPL_)ENV_SUPPORT) += common.o
 obj-$(CONFIG_$(SPL_TPL_)ENV_SUPPORT) += env.o
+obj-$(CONFIG_$(SPL_TPL_)ENV_SUPPORT) += env_set.o
 obj-$(CONFIG_$(SPL_TPL_)ENV_SUPPORT) += attr.o
 obj-$(CONFIG_$(SPL_TPL_)ENV_SUPPORT) += flags.o
 
diff --git a/env/env_set.c b/env/env_set.c
new file mode 100644
index 000000000000..eccbda6a791c
--- /dev/null
+++ b/env/env_set.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2000-2013
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ *
+ * (C) Copyright 2001 Sysgo Real-Time Solutions, GmbH <www.elinos.com>
+ * Andreas Heppel <aheppel@sysgo.de>
+ *
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ */
+
+#include <common.h>
+#include <command.h>
+#include <env.h>
+#include <env_internal.h>
+#include <malloc.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/*
+ * This variable is incremented on each do_env_set(), so it can
+ * be used via env_get_id() as an indication, if the environment
+ * has changed or not. So it is possible to reread an environment
+ * variable only if the environment was changed ... done so for
+ * example in NetInitLoop()
+ */
+static int env_id = 1;
+
+int env_get_id(void)
+{
+	return env_id;
+}
+
+void env_inc_id(void)
+{
+	env_id++;
+}
+
+int _do_env_set(int flag, int argc, char *const argv[], int env_flag)
+{
+	int   i, len;
+	char  *name, *value, *s;
+	struct env_entry e, *ep;
+
+	debug("Initial value for argc=%d\n", argc);
+
+#if !IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_CMD_NVEDIT_EFI)
+	if (argc > 1 && argv[1][0] == '-' && argv[1][1] == 'e')
+		return do_env_set_efi(NULL, flag, --argc, ++argv);
+#endif
+
+	while (argc > 1 && **(argv + 1) == '-') {
+		char *arg = *++argv;
+
+		--argc;
+		while (*++arg) {
+			switch (*arg) {
+			case 'f':		/* force */
+				env_flag |= H_FORCE;
+				break;
+			default:
+				return CMD_RET_USAGE;
+			}
+		}
+	}
+	debug("Final value for argc=%d\n", argc);
+	name = argv[1];
+
+	if (strchr(name, '=')) {
+		printf("## Error: illegal character '=' in variable name \"%s\"\n",
+		       name);
+		return 1;
+	}
+
+	env_id++;
+
+	/* Delete only ? */
+	if (argc < 3 || !argv[2]) {
+		int rc = hdelete_r(name, &env_htab, env_flag);
+
+		/* If the variable didn't exist, don't report an error */
+		return rc && rc != -ENOENT ? 1 : 0;
+	}
+
+	/*
+	 * Insert / replace new value
+	 */
+	for (i = 2, len = 0; i < argc; ++i)
+		len += strlen(argv[i]) + 1;
+
+	value = malloc(len);
+	if (!value) {
+		printf("## Can't malloc %d bytes\n", len);
+		return 1;
+	}
+	for (i = 2, s = value; i < argc; ++i) {
+		char *v = argv[i];
+
+		while ((*s++ = *v++) != '\0')
+			;
+		*(s - 1) = ' ';
+	}
+	if (s != value)
+		*--s = '\0';
+
+	e.key	= name;
+	e.data	= value;
+	hsearch_r(e, ENV_ENTER, &ep, &env_htab, env_flag);
+	free(value);
+	if (!ep) {
+		printf("## Error inserting \"%s\" variable, errno=%d\n",
+		       name, errno);
+		return 1;
+	}
+
+	return 0;
+}
+
+int env_set(const char *varname, const char *varvalue)
+{
+	const char * const argv[4] = { "setenv", varname, varvalue, NULL };
+
+	/* before import into hashtable */
+	if (!(gd->flags & GD_FLG_ENV_READY))
+		return 1;
+
+	if (!varvalue || !varvalue[0])
+		return _do_env_set(0, 2, (char * const *)argv, H_PROGRAMMATIC);
+	else
+		return _do_env_set(0, 3, (char * const *)argv, H_PROGRAMMATIC);
+}
diff --git a/include/env_internal.h b/include/env_internal.h
index 6a6949464689..99e358b6d8a5 100644
--- a/include/env_internal.h
+++ b/include/env_internal.h
@@ -260,6 +260,29 @@ const char *env_fat_get_intf(void);
  * Return: string of device and partition
  */
 char *env_fat_get_dev_part(void);
+
+/*
+ * _do_env_set() - Add / replace / delete an environment variable
+ *
+ * This implements the bulk of the 'env set' command:
+ *
+ *	env set [-f] name [value]
+ *
+ * Sets the value of variable <name>
+ * If <value> is NULL, it removes the variable
+ * Use the -f flag to overwrite read-only/write-once variables
+ *
+ * @flag: CMD_FLAG_... value
+ * @argc: Number of arguments
+ * @args: List of arguments
+ * @env_flag: H_... flags from search.h
+ * Return: 0 if OK, 1 on failure, or CMD_RET_USAGE for invalid flag
+ */
+int _do_env_set(int flag, int argc, char *const argv[], int env_flag);
+
+/** env_inc_id() - Increment the environment ID */
+void env_inc_id(void);
+
 #endif /* DO_DEPS_ONLY */
 
 #endif /* _ENV_INTERNAL_H_ */
-- 
2.42.0.515.g380fc7ccd1-goog

