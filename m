Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F16BC02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:28:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B74F2807B1;
	Mon, 20 Jan 2025 22:26:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TensP/5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56205807EC; Mon, 20 Jan 2025 22:26:53 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F4AF807E5
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:26:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3ce7a77e5a1so13768535ab.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408408; x=1738013208; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BsP9hPf+JYLkYdxJ3O7QLiBPIkkCmKhn09VFf78TbKs=;
 b=TensP/5gWN8w+RvjSaNk0n+JV6h5NysNm4TnXfx3VrQv1SVevx5YCia2HofzpEzTRg
 gj10PJdVtYMxEW9W4GMalTRJjgsRFEgnubboRfiA2QZMUDnpS2BhBIhR6uerOodMGHAz
 4B/bOHueTI4+5aNkl+q0boNVXbC/UwrUWe2RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408408; x=1738013208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BsP9hPf+JYLkYdxJ3O7QLiBPIkkCmKhn09VFf78TbKs=;
 b=RMAHJCgof5J2RY8cr01Ff1XoN8sWS+2HmXlbDbyEMXHmwpSrk2ypMnPK2adtbdUBT7
 ptCStRdjBrpShH+aV3O//THPujVcZyUmUAk+mt98gOV5f9nY1Uz0zNAfElxw8oro40vo
 T7A7Yhp7CISn6MVq5lQjIoG7LbumjqcVSHa0SeY69MO0bNfpVkuzPQL/zYoMF1tTyK+m
 5BibZXCbOqdFZxI/6aFJQglJ8Qlki/0XuXGV6aTC+eawXIWHNCtM5KtBQzjd9HO+llUS
 +QwhR7hNl+UwlVxsSqpoqJZuntCtelIIvOCRbDIeYzo1ebjYzcjXxShPUldEa08ugVlH
 QX5Q==
X-Gm-Message-State: AOJu0YxNtznRgDUMywiwK8Bhox6PbYGEsb5JgptYyjIgDy4z84TK531M
 Hdp4mgcRSee3k5mHB/qL8P6sMtee93hqRB+Krk4vbaAb+2pCGHNOl86B9wlFkkCML7yHi9IyHpQ
 =
X-Gm-Gg: ASbGncsrn86JJb1cax8ZOvfhV+ZEWU2z2Fyp8A3UF3iSP0hfAb+9/IbFjgsuaMSkDTw
 Umw2idQHhEuz6ZbEKIlH4vWk2uQUPG6IAJZX9miwrh5i9lMvXSwwD922/39Se/0JtfTC3IcL2wK
 +yexXJU/hQC+i2RyZRthOKKJi7S3kVUAuUaTg9zB7FkOh/+09XoFUJ3yevaloGvFxbSKdg9IsvW
 6+neoM4N2lPQk9OA3elYR35zgiC7QkCCVhHqPehQoPCg/T21FNBEEazQrC3qENDanejVOgeItXo
 CoUp4t5D+3YyQTIpr4nTOMeqWyASOqE=
X-Google-Smtp-Source: AGHT+IErFyy6EibLKF+JfrCZyQ01+XMNZZkSuSP+4uQb/mo7eLRelqafacmjL9v4flBr4V2icVYPdQ==
X-Received: by 2002:a05:6e02:148f:b0:3cf:6c4f:396f with SMTP id
 e9e14a558f8ab-3cf7447c7cfmr113784965ab.15.1737408408209; 
 Mon, 20 Jan 2025 13:26:48 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:26:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/44] test: Introduce a better array of test suites
Date: Mon, 20 Jan 2025 14:25:33 -0700
Message-ID: <20250120212613.516664-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
References: <20250120212613.516664-1-sjg@chromium.org>
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

The current cmd_ut_sub[] array was fine when there were only a few test
suites. But is quite unwieldy now:

- it requires a separate do_ut_xxx for each suite, even though the code
  for most is almost identical
- running more than one suite requires running multiple commands, and
  there is no record of which suites passed or failed
- 'ut all' runs all suites but reports their results individually
- we need lots of #ifdefs in the array, mirroring those in the makefile
  but maintained in a separate place

In fact the tests are all in the same linker list. The suites are
grouped, so it is possible to access the information without a command.

Introduce a 'suite' array, which holds the cmd_ut_...() function to
call, but can also support running a suite without that function. This
means that the array of struct cmd_tbl is transformed into an array of
'struct suite'.

This will allow removal of many of the functions, particularly those
without test-specific init.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Tidy up the comments for struct suite

 include/test/suites.h |   4 +
 test/cmd_ut.c         | 205 +++++++++++++++++++++++++++++++++---------
 2 files changed, 166 insertions(+), 43 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index e40ad634702..c1119e44999 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -10,6 +10,10 @@
 struct cmd_tbl;
 struct unit_test;
 
+/* 'command' functions normally called do_xxx where xxx is the command name */
+typedef int (*ut_cmd_func)(struct cmd_tbl *cmd, int flags, int argc,
+			   char *const argv[]);
+
 /**
  * cmd_ut_category() - Run a category of unit tests
  *
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 978974e6687..c5df8b397b3 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -11,6 +11,24 @@
 #include <test/test.h>
 #include <test/ut.h>
 
+/**
+ * struct suite - A set of tests for a certain topic
+ *
+ * All tests end up in a single 'struct unit_test' linker-list array, in order
+ * of the suite they are in
+ *
+ * @name: Name of suite
+ * @start: First test in suite
+ * @end: End test in suite (points to the first test in the next suite)
+ * @cmd: Command to use to run the suite
+ */
+struct suite {
+	const char *name;
+	struct unit_test *start;
+	struct unit_test *end;
+	ut_cmd_func cmd;
+};
+
 static int do_ut_all(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[]);
 
@@ -54,85 +72,149 @@ int cmd_ut_category(const char *name, const char *prefix,
 	return ret ? CMD_RET_FAILURE : 0;
 }
 
-static struct cmd_tbl cmd_ut_sub[] = {
-	U_BOOT_CMD_MKENT(all, CONFIG_SYS_MAXARGS, 1, do_ut_all, "", ""),
-	U_BOOT_CMD_MKENT(info, 1, 1, do_ut_info, "", ""),
+/* declare linker-list symbols for the start and end of a suite */
+#define SUITE_DECL(_name) \
+	ll_start_decl(suite_start_ ## _name, struct unit_test, ut_ ## _name); \
+	ll_end_decl(suite_end_ ## _name, struct unit_test, ut_ ## _name)
+
+/* declare a test suite which uses a subcommand to run */
+#define SUITE_CMD(_name, _cmd_func) { \
+	#_name, \
+	suite_start_ ## _name, \
+	suite_end_ ## _name, \
+	_cmd_func, \
+	}
+
+/* declare a test suite which can be run directly without a subcommand */
+#define SUITE(_name) { \
+	#_name, \
+	suite_start_ ## _name, \
+	suite_end_ ## _name, \
+	NULL, \
+	}
+
+SUITE_DECL(info);
+SUITE_DECL(bdinfo);
+SUITE_DECL(bootstd);
+SUITE_DECL(cmd);
+SUITE_DECL(common);
+SUITE_DECL(dm);
+SUITE_DECL(env);
+SUITE_DECL(exit);
+SUITE_DECL(fdt);
+SUITE_DECL(font);
+SUITE_DECL(optee);
+SUITE_DECL(overlay);
+SUITE_DECL(lib);
+SUITE_DECL(log);
+SUITE_DECL(mbr);
+SUITE_DECL(mem);
+SUITE_DECL(setexpr);
+SUITE_DECL(measurement);
+SUITE_DECL(bloblist);
+SUITE_DECL(bootm);
+SUITE_DECL(addrmap);
+SUITE_DECL(hush);
+SUITE_DECL(loadm);
+SUITE_DECL(pci_mps);
+SUITE_DECL(seama);
+SUITE_DECL(upl);
+
+static struct suite suites[] = {
+	SUITE_CMD(info, do_ut_info),
 #ifdef CONFIG_CMD_BDI
-	U_BOOT_CMD_MKENT(bdinfo, CONFIG_SYS_MAXARGS, 1, do_ut_bdinfo, "", ""),
+	SUITE_CMD(bdinfo, do_ut_bdinfo),
 #endif
 #ifdef CONFIG_UT_BOOTSTD
-	U_BOOT_CMD_MKENT(bootstd, CONFIG_SYS_MAXARGS, 1, do_ut_bootstd,
-			 "", ""),
+	SUITE_CMD(bootstd, do_ut_bootstd),
 #endif
 #ifdef CONFIG_CMDLINE
-	U_BOOT_CMD_MKENT(cmd, CONFIG_SYS_MAXARGS, 1, do_ut_cmd, "", ""),
+	SUITE_CMD(cmd, do_ut_cmd),
 #endif
-	U_BOOT_CMD_MKENT(common, CONFIG_SYS_MAXARGS, 1, do_ut_common, "", ""),
+	SUITE_CMD(common, do_ut_common),
 #if defined(CONFIG_UT_DM)
-	U_BOOT_CMD_MKENT(dm, CONFIG_SYS_MAXARGS, 1, do_ut_dm, "", ""),
+	SUITE_CMD(dm, do_ut_dm),
 #endif
 #if defined(CONFIG_UT_ENV)
-	U_BOOT_CMD_MKENT(env, CONFIG_SYS_MAXARGS, 1, do_ut_env, "", ""),
+	SUITE_CMD(env, do_ut_env),
 #endif
-	U_BOOT_CMD_MKENT(exit, CONFIG_SYS_MAXARGS, 1, do_ut_exit, "", ""),
+	SUITE_CMD(exit, do_ut_exit),
 #ifdef CONFIG_CMD_FDT
-	U_BOOT_CMD_MKENT(fdt, CONFIG_SYS_MAXARGS, 1, do_ut_fdt, "", ""),
+	SUITE_CMD(fdt, do_ut_fdt),
 #endif
 #ifdef CONFIG_CONSOLE_TRUETYPE
-	U_BOOT_CMD_MKENT(font, CONFIG_SYS_MAXARGS, 1, do_ut_font, "", ""),
+	SUITE_CMD(font, do_ut_font),
 #endif
 #ifdef CONFIG_UT_OPTEE
-	U_BOOT_CMD_MKENT(optee, CONFIG_SYS_MAXARGS, 1, do_ut_optee, "", ""),
+	SUITE_CMD(optee, do_ut_optee),
 #endif
 #ifdef CONFIG_UT_OVERLAY
-	U_BOOT_CMD_MKENT(overlay, CONFIG_SYS_MAXARGS, 1, do_ut_overlay, "", ""),
+	SUITE_CMD(overlay, do_ut_overlay),
 #endif
 #ifdef CONFIG_UT_LIB
-	U_BOOT_CMD_MKENT(lib, CONFIG_SYS_MAXARGS, 1, do_ut_lib, "", ""),
+	SUITE_CMD(lib, do_ut_lib),
 #endif
 #ifdef CONFIG_UT_LOG
-	U_BOOT_CMD_MKENT(log, CONFIG_SYS_MAXARGS, 1, do_ut_log, "", ""),
+	SUITE_CMD(log, do_ut_log),
 #endif
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_CMD_MBR) && defined(CONFIG_CMD_MMC) \
         && defined(CONFIG_MMC_SANDBOX) && defined(CONFIG_MMC_WRITE)
-	U_BOOT_CMD_MKENT(mbr, CONFIG_SYS_MAXARGS, 1, do_ut_mbr, "", ""),
+	SUITE_CMD(mbr, do_ut_mbr),
 #endif
-	U_BOOT_CMD_MKENT(mem, CONFIG_SYS_MAXARGS, 1, do_ut_mem, "", ""),
+	SUITE_CMD(mem, do_ut_mem),
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_CMD_SETEXPR)
-	U_BOOT_CMD_MKENT(setexpr, CONFIG_SYS_MAXARGS, 1, do_ut_setexpr, "",
-			 ""),
+	SUITE_CMD(setexpr, do_ut_setexpr),
 #endif
 #ifdef CONFIG_MEASURED_BOOT
-	U_BOOT_CMD_MKENT(measurement, CONFIG_SYS_MAXARGS, 1, do_ut_measurement,
-			 "", ""),
+	SUITE_CMD(measurement, do_ut_measurement),
 #endif
 #ifdef CONFIG_SANDBOX
 #if CONFIG_IS_ENABLED(BLOBLIST)
-	U_BOOT_CMD_MKENT(bloblist, CONFIG_SYS_MAXARGS, 1, do_ut_bloblist,
-			 "", ""),
-	U_BOOT_CMD_MKENT(bootm, CONFIG_SYS_MAXARGS, 1, do_ut_bootm, "", ""),
+	SUITE_CMD(bloblist, do_ut_bloblist),
+	SUITE_CMD(bootm, do_ut_bootm),
 #endif
 #endif
 #ifdef CONFIG_CMD_ADDRMAP
-	U_BOOT_CMD_MKENT(addrmap, CONFIG_SYS_MAXARGS, 1, do_ut_addrmap, "", ""),
+	SUITE_CMD(addrmap, do_ut_addrmap),
 #endif
 #if CONFIG_IS_ENABLED(HUSH_PARSER)
-	U_BOOT_CMD_MKENT(hush, CONFIG_SYS_MAXARGS, 1, do_ut_hush, "", ""),
+	SUITE_CMD(hush, do_ut_hush),
 #endif
 #ifdef CONFIG_CMD_LOADM
-	U_BOOT_CMD_MKENT(loadm, CONFIG_SYS_MAXARGS, 1, do_ut_loadm, "", ""),
+	SUITE_CMD(loadm, do_ut_loadm),
 #endif
 #ifdef CONFIG_CMD_PCI_MPS
-	U_BOOT_CMD_MKENT(pci_mps, CONFIG_SYS_MAXARGS, 1, do_ut_pci_mps, "", ""),
+	SUITE_CMD(pci_mps, do_ut_pci_mps),
 #endif
 #ifdef CONFIG_CMD_SEAMA
-	U_BOOT_CMD_MKENT(seama, CONFIG_SYS_MAXARGS, 1, do_ut_seama, "", ""),
+	SUITE_CMD(seama, do_ut_seama),
 #endif
 #ifdef CONFIG_CMD_UPL
-	U_BOOT_CMD_MKENT(upl, CONFIG_SYS_MAXARGS, 1, do_ut_upl, "", ""),
+	SUITE_CMD(upl, do_ut_upl),
 #endif
 };
 
+/** run_suite() - Run a suite of tests */
+static int run_suite(struct suite *ste, struct cmd_tbl *cmdtp, int flag,
+		     int argc, char *const argv[])
+{
+	int ret;
+
+	if (ste->cmd) {
+		ret = ste->cmd(cmdtp, flag, argc, argv);
+	} else {
+		int n_ents = ste->end - ste->start;
+		char prefix[30];
+
+		/* use a standard prefix */
+		snprintf(prefix, sizeof(prefix), "%s_test", ste->name);
+		ret = cmd_ut_category(ste->name, prefix, ste->start, n_ents,
+				      argc, argv);
+	}
+
+	return ret;
+}
+
 static int do_ut_all(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
 {
@@ -140,9 +222,12 @@ static int do_ut_all(struct cmd_tbl *cmdtp, int flag, int argc,
 	int retval;
 	int any_fail = 0;
 
-	for (i = 1; i < ARRAY_SIZE(cmd_ut_sub); i++) {
-		printf("----Running %s tests----\n", cmd_ut_sub[i].name);
-		retval = cmd_ut_sub[i].cmd(cmdtp, flag, 1, &cmd_ut_sub[i].name);
+	for (i = 0; i < ARRAY_SIZE(suites); i++) {
+		struct suite *ste = &suites[i];
+		char *const argv[] = {(char *)ste->name, NULL};
+
+		printf("----Running %s tests----\n", ste->name);
+		retval = run_suite(ste, cmdtp, flag, 1, argv);
 		if (!any_fail)
 			any_fail = retval;
 	}
@@ -155,7 +240,7 @@ static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	const char *flags;
 
-	printf("Test suites: %d\n", (int)ARRAY_SIZE(cmd_ut_sub) - 1);
+	printf("Test suites: %d\n", (int)ARRAY_SIZE(suites));
 	printf("Total tests: %d\n", (int)UNIT_TEST_ALL_COUNT());
 
 	flags = cmd_arg1(argc, argv);
@@ -164,16 +249,38 @@ static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 
 		puts("\nTests  Suite\n");
 		puts("-----  -----\n");
-		for (i = 1; i < ARRAY_SIZE(cmd_ut_sub); i++)
-			printf("%5s  %s\n", "?", cmd_ut_sub[i].name);
+		for (i = 1; i < ARRAY_SIZE(suites); i++) {
+			struct suite *ste = &suites[i];
+			long n_ent = ste->end - ste->start;
+
+			if (n_ent)
+				printf("%5ld  %s\n", n_ent, ste->name);
+			else
+				printf("%5s  %s\n", "?", ste->name);
+		}
 	}
 
 	return 0;
 }
 
+static struct suite *find_suite(const char *name)
+{
+	struct suite *ste;
+	int i;
+
+	for (i = 0, ste = suites; i < ARRAY_SIZE(suites); i++, ste++) {
+		if (!strcmp(ste->name, name))
+			return ste;
+	}
+
+	return NULL;
+}
+
 static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct cmd_tbl *cp;
+	struct suite *ste;
+	const char *name;
+	int ret;
 
 	if (argc < 2)
 		return CMD_RET_USAGE;
@@ -182,12 +289,24 @@ static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	argc--;
 	argv++;
 
-	cp = find_cmd_tbl(argv[0], cmd_ut_sub, ARRAY_SIZE(cmd_ut_sub));
+	name = argv[0];
+	if (!strcmp(name, "all")) {
+		ret = do_ut_all(cmdtp, flag, argc, argv);
+	} else if (!strcmp(name, "info")) {
+		ret = do_ut_info(cmdtp, flag, argc, argv);
+	} else {
+		ste = find_suite(argv[0]);
+		if (!ste) {
+			printf("Suite '%s' not found\n", argv[0]);
+			return CMD_RET_FAILURE;
+		}
 
-	if (cp)
-		return cp->cmd(cmdtp, flag, argc, argv);
+		ret = run_suite(ste, cmdtp, flag, argc, argv);
+	}
+	if (ret)
+		return ret;
 
-	return CMD_RET_USAGE;
+	return 0;
 }
 
 U_BOOT_LONGHELP(ut,
-- 
2.43.0

