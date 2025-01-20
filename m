Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588AAC02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D69A8081A;
	Mon, 20 Jan 2025 22:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UhLxMeXl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C60580771; Mon, 20 Jan 2025 22:27:37 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5F5E801CF
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a8165cfae8so13798975ab.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408453; x=1738013253; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhXZZHBA+iQwD28WvhoPObAP9uJAZqbnIBt7zpPtYMI=;
 b=UhLxMeXl2AzFm3XvR65lL4Xk8MAq87gMRd/uTiyfEfOWoZELGo2VjfQF/qykW8cZUw
 v8m5TKPGtbUURyPgaZuGp5AJ3xbigIwdnB43jj8lTs0LhLQ4MpaM75RqX//lkBWY3uyy
 riCZ1CDY+WmjS/jzIseD9B+80/R5k/WJByUh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408453; x=1738013253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UhXZZHBA+iQwD28WvhoPObAP9uJAZqbnIBt7zpPtYMI=;
 b=wWelzIvCfU9I2lUHg5YDUORe9MVaW05lawWrPMRSIEdOgkrAeKmsPdatRSrNoDfukL
 9DYkSVwwUtbqU4HvWOcYVA7E8pGm0ensbvY74ye7FBfYvHaqE1hV/CvtQhcKBKcZb7lS
 g4QrhPjo9162bZh7P0WuNhRrDBDQlXoCyT7AOnlC3/5gzF8WH8fVoQ45x8baHsNZB+EP
 0jamjhjr9mH6D/piUkxfB95IRyZpny8N9eT+dhoE/uf+73cejI8ayVwKptGBjJulxng/
 saLelhe14qgmQE2LxypJVLeEua/8Ri/oARE8Pq0h82nCZSE7414MD0TjKzb/D9zjFPys
 6zDQ==
X-Gm-Message-State: AOJu0Yy1UK9dQeUECN7r9DfahEE3L6CFPUV0kgWM53cYo6UObqB3Vv34
 MHTWr1/VSuZXBiyIh+FooPV2J4sLmxVgcoU7uO3rVSaHwBPLR+kNuzaT1t4sGy7UbufPrI28xCw
 =
X-Gm-Gg: ASbGncuhWuoUFU6vZ4Y9zC+OdOcwvor0LhZ4rODA+FsMeT533WKEef1ItePuTv6jLT7
 gCrIWr5/pXt7dIT6zGi+9N4jNxH+PRxAMJuUTko/xuq36hoDcgeEQvolvbg9FLeE1P+TXHzyxKl
 oazPA17MnOO30fR5pOA6Rio2s4V5Ebt3RaY3otantIS+gD5N9pVFzQ4nFR8acDSgvctYHIFIbC9
 b49q/4dX5rJoaRrFW4ijTjezwvU/XBSKTzaDssBVUAx1vMKiezwNqQCpAwih77v1dh2Hzc0R2Tp
 fe4V/rFklj6rLyObpmCL240WU1Qojrk=
X-Google-Smtp-Source: AGHT+IH9vtfO4jMfqqwMpdP7qAR6WfmFGzI1Oy6MCLJoccEocdL4ocoO4DViK0mve2viknPpkYxSIQ==
X-Received: by 2002:a92:c563:0:b0:3ce:31f4:91c2 with SMTP id
 e9e14a558f8ab-3cf744192cbmr100703125ab.11.1737408452960; 
 Mon, 20 Jan 2025 13:27:32 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 36/44] test: Pass the test state to cmd_ut_category()
Date: Mon, 20 Jan 2025 14:25:58 -0700
Message-ID: <20250120212613.516664-37-sjg@chromium.org>
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

Update this function to access a unit-test state, so that the caller can
collect results from running multiple suites.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/test/suites.h         | 20 +++++++++++--------
 test/boot/bootstd_common.c    |  7 ++++---
 test/cmd_ut.c                 | 37 ++++++++++++++++++-----------------
 test/overlay/cmd_ut_overlay.c | 10 +++-------
 4 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index 20e6a2a113b..774dd893378 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -9,14 +9,18 @@
 
 struct cmd_tbl;
 struct unit_test;
+struct unit_test_state;
 
 /* 'command' functions normally called do_xxx where xxx is the command name */
-typedef int (*ut_cmd_func)(struct cmd_tbl *cmd, int flags, int argc,
-			   char *const argv[]);
+typedef int (*ut_cmd_func)(struct unit_test_state *uts, struct cmd_tbl *cmd,
+			   int flags, int argc, char *const argv[]);
 
 /**
  * cmd_ut_category() - Run a category of unit tests
  *
+ * @uts: Unit-test state, which must be ready for use, i.e. ut_init_state()
+ *	has been called. The caller is responsible for calling
+ *	ut_uninit_state() after this function returns
  * @name:	Category name
  * @prefix:	Prefix of test name
  * @tests:	List of tests to run
@@ -26,14 +30,14 @@ typedef int (*ut_cmd_func)(struct cmd_tbl *cmd, int flags, int argc,
  * @argv:	Arguments: argv[1] is the test to run (if @argc >= 2)
  * Return: 0 if OK, CMD_RET_FAILURE on failure
  */
-int cmd_ut_category(const char *name, const char *prefix,
-		    struct unit_test *tests, int n_ents,
+int cmd_ut_category(struct unit_test_state *uts, const char *name,
+		    const char *prefix, struct unit_test *tests, int n_ents,
 		    int argc, char *const argv[]);
 
-int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
-		  char *const argv[]);
+int do_ut_bootstd(struct unit_test_state *uts, struct cmd_tbl *cmdtp, int flag,
+		  int argc, char *const argv[]);
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
-		  char *const argv[]);
+int do_ut_overlay(struct unit_test_state *uts, struct cmd_tbl *cmdtp, int flag,
+		  int argc, char *const argv[]);
 
 #endif /* __TEST_SUITES_H__ */
diff --git a/test/boot/bootstd_common.c b/test/boot/bootstd_common.c
index 6bd9bb65a40..724e3d9bdd2 100644
--- a/test/boot/bootstd_common.c
+++ b/test/boot/bootstd_common.c
@@ -94,7 +94,8 @@ void bootstd_reset_usb(void)
 	usb_started = false;
 }
 
-int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+int do_ut_bootstd(struct unit_test_state *uts, struct cmd_tbl *cmdtp, int flag,
+		  int argc, char *const argv[])
 {
 	struct unit_test *tests = UNIT_TEST_SUITE_START(bootstd);
 	const int n_ents = UNIT_TEST_SUITE_COUNT(bootstd);
@@ -106,6 +107,6 @@ int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return CMD_RET_FAILURE;
 	}
 
-	return cmd_ut_category("bootstd", "bootstd_", tests, n_ents,
-			       argc, argv);
+	return cmd_ut_category(uts, "bootstd", "bootstd_",
+			       tests, n_ents, argc, argv);
 }
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 16490e00ab3..80df954694f 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -29,17 +29,16 @@ struct suite {
 	ut_cmd_func cmd;
 };
 
-static int do_ut_all(struct cmd_tbl *cmdtp, int flag, int argc,
-		     char *const argv[]);
+static int do_ut_all(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
+		     int flag, int argc, char *const argv[]);
 
 static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[]);
 
-int cmd_ut_category(const char *name, const char *prefix,
-		    struct unit_test *tests, int n_ents,
+int cmd_ut_category(struct unit_test_state *uts, const char *name,
+		    const char *prefix, struct unit_test *tests, int n_ents,
 		    int argc, char *const argv[])
 {
-	struct unit_test_state uts;
 	const char *test_insert = NULL;
 	int runs_per_text = 1;
 	bool force_run = false;
@@ -63,11 +62,9 @@ int cmd_ut_category(const char *name, const char *prefix,
 		argc--;
 	}
 
-	ut_init_state(&uts);
-	ret = ut_run_list(&uts, name, prefix, tests, n_ents,
+	ret = ut_run_list(uts, name, prefix, tests, n_ents,
 			  cmd_arg1(argc, argv), runs_per_text, force_run,
 			  test_insert);
-	ut_uninit_state(&uts);
 
 	return ret ? CMD_RET_FAILURE : 0;
 }
@@ -170,28 +167,29 @@ static bool has_tests(struct suite *ste)
 }
 
 /** run_suite() - Run a suite of tests */
-static int run_suite(struct suite *ste, struct cmd_tbl *cmdtp, int flag,
-		     int argc, char *const argv[])
+static int run_suite(struct unit_test_state *uts, struct suite *ste,
+		     struct cmd_tbl *cmdtp, int flag, int argc,
+		     char *const argv[])
 {
 	int ret;
 
 	if (ste->cmd) {
-		ret = ste->cmd(cmdtp, flag, argc, argv);
+		ret = ste->cmd(uts, cmdtp, flag, argc, argv);
 	} else {
 		int n_ents = ste->end - ste->start;
 		char prefix[30];
 
 		/* use a standard prefix */
 		snprintf(prefix, sizeof(prefix), "%s_test", ste->name);
-		ret = cmd_ut_category(ste->name, prefix, ste->start, n_ents,
-				      argc, argv);
+		ret = cmd_ut_category(uts, ste->name, prefix, ste->start,
+				      n_ents, argc, argv);
 	}
 
 	return ret;
 }
 
-static int do_ut_all(struct cmd_tbl *cmdtp, int flag, int argc,
-		     char *const argv[])
+static int do_ut_all(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
+		     int flag, int argc, char *const argv[])
 {
 	int i;
 	int retval;
@@ -203,7 +201,7 @@ static int do_ut_all(struct cmd_tbl *cmdtp, int flag, int argc,
 
 		if (has_tests(ste)) {
 			printf("----Running %s tests----\n", ste->name);
-			retval = run_suite(ste, cmdtp, flag, 1, argv);
+			retval = run_suite(uts, ste, cmdtp, flag, 1, argv);
 			if (!any_fail)
 				any_fail = retval;
 		}
@@ -263,6 +261,7 @@ static struct suite *find_suite(const char *name)
 
 static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	struct unit_test_state uts;
 	struct suite *ste;
 	const char *name;
 	int ret;
@@ -274,9 +273,10 @@ static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	argc--;
 	argv++;
 
+	ut_init_state(&uts);
 	name = argv[0];
 	if (!strcmp(name, "all")) {
-		ret = do_ut_all(cmdtp, flag, argc, argv);
+		ret = do_ut_all(&uts, cmdtp, flag, argc, argv);
 	} else if (!strcmp(name, "info")) {
 		ret = do_ut_info(cmdtp, flag, argc, argv);
 	} else {
@@ -290,10 +290,11 @@ static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			return CMD_RET_FAILURE;
 		}
 
-		ret = run_suite(ste, cmdtp, flag, argc, argv);
+		ret = run_suite(&uts, ste, cmdtp, flag, argc, argv);
 	}
 	if (ret)
 		return ret;
+	ut_uninit_state(&uts);
 
 	return 0;
 }
diff --git a/test/overlay/cmd_ut_overlay.c b/test/overlay/cmd_ut_overlay.c
index e0483afc31d..aefa147ec04 100644
--- a/test/overlay/cmd_ut_overlay.c
+++ b/test/overlay/cmd_ut_overlay.c
@@ -210,21 +210,17 @@ static int fdt_overlay_stacked(struct unit_test_state *uts)
 }
 OVERLAY_TEST(fdt_overlay_stacked, 0);
 
-int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+int do_ut_overlay(struct unit_test_state *uts, struct cmd_tbl *cmdtp, int flag,
+		  int argc, char *const argv[])
 {
 	struct unit_test *tests = UNIT_TEST_SUITE_START(overlay);
 	const int n_ents = UNIT_TEST_SUITE_COUNT(overlay);
-	struct unit_test_state *uts;
 	void *fdt_base = &__dtb_test_fdt_base_begin;
 	void *fdt_overlay = &__dtbo_test_fdt_overlay_begin;
 	void *fdt_overlay_stacked = &__dtbo_test_fdt_overlay_stacked_begin;
 	void *fdt_overlay_copy, *fdt_overlay_stacked_copy;
 	int ret = -ENOMEM;
 
-	uts = calloc(1, sizeof(*uts));
-	if (!uts)
-		return -ENOMEM;
-
 	ut_assertok(fdt_check_header(fdt_base));
 	ut_assertok(fdt_check_header(fdt_overlay));
 
@@ -272,7 +268,7 @@ int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	/* Apply the stacked overlay */
 	ut_assertok(fdt_overlay_apply(fdt, fdt_overlay_stacked_copy));
 
-	ret = cmd_ut_category("overlay", "", tests, n_ents, argc, argv);
+	ret = cmd_ut_category(uts, "overlay", "", tests, n_ents, argc, argv);
 
 	free(fdt_overlay_stacked_copy);
 err3:
-- 
2.43.0

