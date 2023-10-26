Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D508C27C47
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CD1187B6D;
	Thu, 26 Oct 2023 20:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mBiA9X0O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64D7887648; Thu, 26 Oct 2023 20:31:51 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68FFC875B8
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-778a47bc09aso90535285a.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345107; x=1698949907; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L8D6ZBxo7xumgfvNycxQ3Cjf5zl+c/VvOgxht/rW5+4=;
 b=mBiA9X0OsovPPCbv4QRuGbfozlQnLqth3SonezAMelJr6jKc0A9nFbKKHFp5jhfCrD
 szYTWhkzUINzQlBrMAdizOkGuhJdztADbf0xr2lvpN3nGCDQsrVxjYIyznc5DPGyLo3h
 8+/c3/yGdGyr5p9q90HQT6tDlvugNKs8NJJjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345107; x=1698949907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L8D6ZBxo7xumgfvNycxQ3Cjf5zl+c/VvOgxht/rW5+4=;
 b=O2B7vnT72wevQTQKR4fH/lYnyN0h6ikO6AnMaemchgHBz93fKtOeKlxRkp24F7jbtP
 U7YRMLwWv5/XkVPx8HSYOiph27VaExvQbNtmTMjYCkmiAsgHEjTRnQRB0PIVFyUJjfn9
 biF8q9Cnm0YlL6MTMZjdFKcfhb/jqwBLcHcPqMDcRCtQDM7Nj1JzKX6XltRlJYSMAbPJ
 n5WCYegwTTH4YgsS6FT5PxayT1pwvquuK6udhQgQsTpa4pUuapQ94F8mrkZXwzxt+W9H
 kGu7RPUHVQG4PZWrCQvVe/5TWXneuZquAMFubuqK78dzss50t6rHbkw3L6ro+ckAZNBE
 5ZiQ==
X-Gm-Message-State: AOJu0YyQq68SLE0tFCDfDXb2ggtc1mwVSDHSyKGxz2cR1NmdUtUBAN1m
 aNvZtBQzLXfrOjPwBzC4Q9s/gqRb435pixrJWqdF2Q==
X-Google-Smtp-Source: AGHT+IHLnlJYiA3504f1Eyog2lV/34rpXRio3YDsrnDCeeeUmKYMyBJ0ms8cRzIkaqVCqWehECripw==
X-Received: by 2002:a05:620a:6893:b0:775:79d6:9e57 with SMTP id
 rv19-20020a05620a689300b0077579d69e57mr115100qkn.61.1698345106798; 
 Thu, 26 Oct 2023 11:31:46 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.45
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v5 08/30] env: Move env_set() out of cmd/nvedit.c and in to
 env/common.c
Date: Thu, 26 Oct 2023 14:31:16 -0400
Message-Id: <20231026183138.636948-8-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

Inside of env/common.c we already have our helper env_set_xxx functions,
and even have a comment that explains why env_set() itself wasn't moved.
We now handle that move. This requires that we rename the previous
_do_env_set() to env_do_env_set() and note it as an internal env
function. Add comments about this function to explain why we do this
when we add the prototype. Add a new function, env_inc_id() to allow for
the counter to be updated by both commands and callers, and document
this as well by the prototype.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/Makefile           |   4 +-
 cmd/nvedit.c           | 122 ++---------------------------------------
 env/common.c           | 113 ++++++++++++++++++++++++++++++++++++--
 include/env.h          |   8 +++
 include/env_internal.h |  12 ++++
 5 files changed, 135 insertions(+), 124 deletions(-)

diff --git a/cmd/Makefile b/cmd/Makefile
index 9a6790cc1708..dbeeebe2c4b1 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -128,6 +128,7 @@ endif
 obj-$(CONFIG_CMD_MUX) += mux.o
 obj-$(CONFIG_CMD_NAND) += nand.o
 obj-$(CONFIG_CMD_NET) += net.o
+obj-$(CONFIG_ENV_SUPPORT) += nvedit.o
 obj-$(CONFIG_CMD_NVEDIT_EFI) += nvedit_efi.o
 obj-$(CONFIG_CMD_ONENAND) += onenand.o
 obj-$(CONFIG_CMD_OSD) += osd.o
@@ -245,9 +246,6 @@ endif # !CONFIG_SPL_BUILD
 
 obj-$(CONFIG_$(SPL_)CMD_TLV_EEPROM) += tlv_eeprom.o
 
-# core command
-obj-y += nvedit.o
-
 obj-$(CONFIG_CMD_BCM_EXT_UTILS) += broadcom/
 
 filechk_data_gz = (echo "static const char data_gz[] ="; cat $< | scripts/bin2c; echo ";")
diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index daf1ad37f9be..e77338f81394 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -49,20 +49,6 @@ DECLARE_GLOBAL_DATA_PTR;
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
@@ -198,104 +184,6 @@ DONE:
 #endif
 #endif /* CONFIG_SPL_BUILD */
 
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
-
 #ifndef CONFIG_SPL_BUILD
 static int do_env_set(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
@@ -303,7 +191,7 @@ static int do_env_set(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (argc < 2)
 		return CMD_RET_USAGE;
 
-	return _do_env_set(flag, argc, argv, H_INTERACTIVE);
+	return env_do_env_set(flag, argc, argv, H_INTERACTIVE);
 }
 
 /*
@@ -381,7 +269,7 @@ int do_env_ask(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 
 	/* Continue calling setenv code */
-	return _do_env_set(flag, len, local_args, H_INTERACTIVE);
+	return env_do_env_set(flag, len, local_args, H_INTERACTIVE);
 }
 #endif
 
@@ -561,12 +449,12 @@ static int do_env_edit(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (buffer[0] == '\0') {
 		const char * const _argv[3] = { "setenv", argv[1], NULL };
 
-		return _do_env_set(0, 2, (char * const *)_argv, H_INTERACTIVE);
+		return env_do_env_set(0, 2, (char * const *)_argv, H_INTERACTIVE);
 	} else {
 		const char * const _argv[4] = { "setenv", argv[1], buffer,
 			NULL };
 
-		return _do_env_set(0, 3, (char * const *)_argv, H_INTERACTIVE);
+		return env_do_env_set(0, 3, (char * const *)_argv, H_INTERACTIVE);
 	}
 }
 #endif /* CONFIG_CMD_EDITENV */
@@ -679,7 +567,7 @@ static int do_env_delete(struct cmd_tbl *cmdtp, int flag,
 	}
 	debug("Final value for argc=%d\n", argc);
 
-	env_id++;
+	env_inc_id();
 
 	while (--argc > 0) {
 		char *name = *++argv;
diff --git a/env/common.c b/env/common.c
index eb1a91379539..656748c1f5b7 100644
--- a/env/common.c
+++ b/env/common.c
@@ -37,11 +37,116 @@ struct hsearch_data env_htab = {
 };
 
 /*
- * This env_set() function is defined in cmd/nvedit.c, since it calls
- * _do_env_set(), whis is a static function in that file.
- *
- * int env_set(const char *varname, const char *varvalue);
+ * This variable is incremented each time we set an environment variable so we
+ * can be check via env_get_id() to see if the environment has changed or not.
+ * This makes it possible to reread an environment variable only if the
+ * environment was changed, typically used by networking code.
  */
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
+int env_do_env_set(int flag, int argc, char *const argv[], int env_flag)
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
+		printf("## Error: illegal character '='"
+		       "in variable name \"%s\"\n", name);
+		return 1;
+	}
+
+	env_inc_id();
+
+	/* Delete only ? */
+	if (argc < 3 || argv[2] == NULL) {
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
+	if (value == NULL) {
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
+			name, errno);
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
+	if (varvalue == NULL || varvalue[0] == '\0')
+		return env_do_env_set(0, 2, (char * const *)argv, H_PROGRAMMATIC);
+	else
+		return env_do_env_set(0, 3, (char * const *)argv, H_PROGRAMMATIC);
+}
 
 /**
  * Set an environment variable to an integer value
diff --git a/include/env.h b/include/env.h
index 430c4fa94a42..9778e3e4f2ce 100644
--- a/include/env.h
+++ b/include/env.h
@@ -72,6 +72,14 @@ enum env_redund_flags {
  */
 int env_get_id(void);
 
+/**
+ * env_inc_id() - Increase the sequence number for the environment
+ *
+ * Increment the value that is used by env_get_id() to inform callers
+ * if the environment has changed since they last checked.
+ */
+void env_inc_id(void);
+
 /**
  * env_init() - Set up the pre-relocation environment
  *
diff --git a/include/env_internal.h b/include/env_internal.h
index 6a6949464689..ae7816d38e58 100644
--- a/include/env_internal.h
+++ b/include/env_internal.h
@@ -193,6 +193,18 @@ struct env_driver {
 
 extern struct hsearch_data env_htab;
 
+/**
+ * env_do_env_set() - Perform the actual setting of an environment variable
+ *
+ * Due to the number of places we may need to set an environmental variable
+ * from we have an exposed internal function that performs the real work and
+ * then call this from both the command line function as well as other
+ * locations.
+ *
+ * Return: 0 on success or 1 on failure
+ */
+int env_do_env_set(int flag, int argc, char *const argv[], int env_flag);
+
 /**
  * env_ext4_get_intf() - Provide the interface for env in EXT4
  *
-- 
2.34.1

