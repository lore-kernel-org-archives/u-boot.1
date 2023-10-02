Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6597EE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75E958720E;
	Mon,  2 Oct 2023 03:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QF4ahdZe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B512870F7; Mon,  2 Oct 2023 03:17:30 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55C9F8722C
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3515deaa7c1so23375005ab.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209379; x=1696814179; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J48Mn5wbsUERptAMWNXHdljGIN8T1gmxnN9MjhXeU2I=;
 b=QF4ahdZeNgDiGU7TyqQYxMB2QBirp50r0P5Lpl6GAc5sDfxnEhYm3tk2itoyXqBeff
 qKx1G6unBAkqCDOQqSjpO2spsQ9j/EVvlCT058+I3EugwFOSOK1TlE+wrCF+H0GB3AfB
 8uCJjTEvTC34/5Z9xMYsRtnWClSJYAsG3qkdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209379; x=1696814179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J48Mn5wbsUERptAMWNXHdljGIN8T1gmxnN9MjhXeU2I=;
 b=bvY9n1luxDjFayCklHcxk6A3Vm+4B73uc10kkNqmo1l+5++WbQWxzHLTr1+WdjBBbZ
 K8eQKVlq5cxOo+bCpchW4mmNOUk63ZrKl748hgc3dWSbfG77TFjaYo50JDV2CCfSFOfT
 gbHRVchttXi6s3ROPjpuTxA8rzLIx6vpSNZRgkjdOCVZ5kWB/ZsACy7ryfxoXVqGrsdg
 xjCRR+fSgIg+ydqtd/UYm8Hwv5gr2VAQILD722yXLEomTgwvzPqZlvmqwyHEFGh4bHeP
 Nf3BVYJq5o1CiqUtvjCVj6o/ZlOUTITizl17RkQ9xQfLhU49wzik5DemoLgq38YQX95L
 dSdw==
X-Gm-Message-State: AOJu0Yz571vfdd9Og6JEl8XHTBNux2oBFkfOrGcDnzqZ/WRWqw9w33eo
 X+feGj4s/k+CY5dNtB9d6pgwi8Q33aoMKVQKmo8=
X-Google-Smtp-Source: AGHT+IH5zgM+f0SKgwfkkO5/+5LF6wX2Pff7hQSogzZCUTKDfAqhy+krDTKjpLXHvRZuKeqjIEr/SQ==
X-Received: by 2002:a05:6e02:1112:b0:351:80c:bc29 with SMTP id
 u18-20020a056e02111200b00351080cbc29mr10109408ilk.17.1696209379272; 
 Sun, 01 Oct 2023 18:16:19 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 15/34] bootstd: Add a menu option to bootflow scan
Date: Sun,  1 Oct 2023 19:15:25 -0600
Message-ID: <20231002011553.463514-16-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

Allow showing a menu and automatically booting, with 'bootflow scan'.
This is more convenient than using a script.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/bootflow.c             | 27 +++++++++++--
 doc/usage/cmd/bootflow.rst |  5 +++
 test/boot/bootflow.c       | 82 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 4 deletions(-)

diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 1516f8a4193b..e4ed4ab83d9d 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -135,7 +135,7 @@ static int do_bootflow_scan(struct cmd_tbl *cmdtp, int flag, int argc,
 	struct udevice *dev = NULL;
 	struct bootflow bflow;
 	bool all = false, boot = false, errors = false, no_global = false;
-	bool list = false, no_hunter = false;
+	bool list = false, no_hunter = false, menu = false, text_mode = false;
 	int num_valid = 0;
 	const char *label = NULL;
 	bool has_args;
@@ -155,6 +155,8 @@ static int do_bootflow_scan(struct cmd_tbl *cmdtp, int flag, int argc,
 			no_global = strchr(argv[1], 'G');
 			list = strchr(argv[1], 'l');
 			no_hunter = strchr(argv[1], 'H');
+			menu = strchr(argv[1], 'm');
+			text_mode = strchr(argv[1], 't');
 			argc--;
 			argv++;
 		}
@@ -213,15 +215,32 @@ static int do_bootflow_scan(struct cmd_tbl *cmdtp, int flag, int argc,
 		}
 		if (list)
 			show_bootflow(i, &bflow, errors);
-		if (boot && !bflow.err)
+		if (!menu && boot && !bflow.err)
 			bootflow_run_boot(&iter, &bflow);
 	}
 	bootflow_iter_uninit(&iter);
 	if (list)
 		show_footer(i, num_valid);
 
-	if (IS_ENABLED(CONFIG_CMD_BOOTFLOW_FULL) && !num_valid && !list)
-		printf("No bootflows found; try again with -l\n");
+	if (IS_ENABLED(CONFIG_CMD_BOOTFLOW_FULL) && IS_ENABLED(CONFIG_EXPO)) {
+		if (!num_valid && !list) {
+			printf("No bootflows found; try again with -l\n");
+		} else if (menu) {
+			struct bootflow *sel_bflow;
+
+			ret = bootflow_handle_menu(std, text_mode, &sel_bflow);
+			if (!ret && boot) {
+				ret = console_clear();
+				if (ret) {
+					log_err("Failed to clear console: %dE\n",
+						ret);
+					return ret;
+				}
+
+				bootflow_run_boot(NULL, sel_bflow);
+			}
+		}
+	}
 
 	return 0;
 }
diff --git a/doc/usage/cmd/bootflow.rst b/doc/usage/cmd/bootflow.rst
index 6a0645c28d07..795d5990bdc3 100644
--- a/doc/usage/cmd/bootflow.rst
+++ b/doc/usage/cmd/bootflow.rst
@@ -52,6 +52,8 @@ Flags are:
     matters, since by then the system boots in the OS and U-Boot is no-longer
     running. `bootflow scan -b` is a quick way to boot the first available OS.
     A valid bootflow is one that made it all the way to the `loaded` state.
+    Note that if `-m` is provided as well, booting is delayed until the user
+    selects a bootflow.
 
 -e
     Used with -l to also show errors for each bootflow. The shows detailed error
@@ -71,6 +73,9 @@ Flags are:
     priority or label is tried, to see if more bootdevs can be discovered, but
     this flag disables that process.
 
+-m
+    Show a menu of available bootflows for the user to select. When used with
+    -b it then boots the one that was selected, if any.
 
 The optional argument specifies a particular bootdev to scan. This can either be
 the name of a bootdev or its sequence number (both shown with `bootdev list`).
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 04a5bd5d7a80..a57f5017364a 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -637,6 +637,88 @@ static int bootflow_cmd_menu(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_cmd_menu, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
 
+/* Check 'bootflow scan -m' to select a bootflow using a menu */
+static int bootflow_scan_menu(struct unit_test_state *uts)
+{
+	struct bootstd_priv *std;
+	const char **old_order, **new_order;
+	char prev[3];
+
+	/* get access to the current bootflow */
+	ut_assertok(bootstd_get_priv(&std));
+
+	ut_assertok(prep_mmc_bootdev(uts, "mmc4", false, &old_order));
+
+	/* Add keypresses to move to and select the second one in the list */
+	prev[0] = CTL_CH('n');
+	prev[1] = '\r';
+	prev[2] = '\0';
+	ut_asserteq(2, console_in_puts(prev));
+
+	ut_assertok(run_command("bootflow scan -lm", 0));
+	new_order = std->bootdev_order;
+	std->bootdev_order = old_order;
+
+	ut_assert_skip_to_line("No more bootdevs");
+	ut_assert_nextlinen("--");
+	ut_assert_nextline("(2 bootflows, 2 valid)");
+
+	ut_assert_nextline("Selected: Armbian");
+	ut_assertnonnull(std->cur_bootflow);
+	ut_assert_console_end();
+
+	/* Check not selecting anything */
+	prev[0] = '\e';
+	prev[1] = '\0';
+	ut_asserteq(1, console_in_puts(prev));
+
+	std->bootdev_order = new_order; /* Blue Monday */
+	ut_assertok(run_command("bootflow scan -lm", 0));
+	std->bootdev_order = old_order;
+
+	ut_assertnull(std->cur_bootflow);
+	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
+	ut_assert_nextline("Nothing chosen");
+	ut_assert_console_end();
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_scan_menu,
+	     UT_TESTF_DM | UT_TESTF_SCAN_FDT | UT_TESTF_CONSOLE_REC);
+
+/* Check 'bootflow scan -mb' to select and boot a bootflow using a menu */
+static int bootflow_scan_menu_boot(struct unit_test_state *uts)
+{
+	struct bootstd_priv *std;
+	const char **old_order;
+	char prev[3];
+
+	/* get access to the current bootflow */
+	ut_assertok(bootstd_get_priv(&std));
+
+	ut_assertok(prep_mmc_bootdev(uts, "mmc4", false, &old_order));
+
+	/* Add keypresses to move to and select the second one in the list */
+	prev[0] = CTL_CH('n');
+	prev[1] = '\r';
+	prev[2] = '\0';
+	ut_asserteq(2, console_in_puts(prev));
+
+	ut_assertok(run_command("bootflow scan -lmb", 0));
+	std->bootdev_order = old_order;
+
+	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
+
+	ut_assert_nextline("Selected: Armbian");
+	ut_assert_skip_to_line("Boot failed (err=-14)");
+	ut_assertnonnull(std->cur_bootflow);
+	ut_assert_console_end();
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_scan_menu_boot,
+	     UT_TESTF_DM | UT_TESTF_SCAN_FDT | UT_TESTF_CONSOLE_REC);
+
 /* Check searching for a single bootdev using the hunters */
 static int bootflow_cmd_hunt_single(struct unit_test_state *uts)
 {
-- 
2.42.0.582.g8ccd20d70d-goog

