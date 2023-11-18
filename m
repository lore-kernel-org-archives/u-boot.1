Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4793C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EACD5874BB;
	Sat, 18 Nov 2023 22:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SBGevGch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A698755E; Sat, 18 Nov 2023 22:06:41 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D97BB8752B
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7b074e318b5so76058339f.0
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341585; x=1700946385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Bg4bF7vg9gCcbEY2RV4DFqowZJAr280giOtin56WCE=;
 b=SBGevGchxLJ+8hLHS2hDEI1nUTf0JmvVJUH63nvSefpHWitimb5SvCHmM9yZYUYcbI
 D1jWWpH0Kr2lwXy+xaZieZ1D8qmOhGm97SK7LwnFcL1yf0YxQqbRx16DgE9rQbj3s2Gq
 1+rahxEQ0b/Eta+u+1dlJZY3TlqehhLHBzzLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341585; x=1700946385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Bg4bF7vg9gCcbEY2RV4DFqowZJAr280giOtin56WCE=;
 b=T63OHBaAOM5cZgwo5v5kBzZe0EH5NlIx6t0JNVdWpy2POb0urgBEcmQMdwRhEn80Xo
 m9kKLGHe4vXXyOUbIw3OdwIyRKBnt0u1GI9ol6mK4maCLnpWr/uqZHrz4ui51Fvtvauf
 n7tnr31ZiDCggfUapmZXR5ZpL/kxrNgfu4gXNIfycdAXvfgTvDi0eZ5tpZUH7SRp+pnl
 n4RSmeRz/inDVfNnglovOMNAFO14xD6SCz20OzF77/w4jSTVKwmQ7AE7g1uA30wpSm85
 4W1n3iSVxEqkYYLOvSw2+bhGo6+3BFrNZlMF8v1j4zWU67DfgOzNBjdnuJvNSsap8QFv
 m2Ug==
X-Gm-Message-State: AOJu0YwRhKK9Isd4pPmDpS8ufhH1cXbovnB1yrWAFMvGebxc7yaTatPy
 bCHXt8NSParmfyP0/LsUxcm26Ig9neTvrjvu1ZliVw==
X-Google-Smtp-Source: AGHT+IHmwu9bTw6UrH2A49FyF2kj2FQ6YdZkxDVdMjQZZO9B/qaD38Vx7Y0kQWh2gyZ3YF6DTcDXcA==
X-Received: by 2002:a5e:a810:0:b0:79d:1b4e:fb8a with SMTP id
 c16-20020a5ea810000000b0079d1b4efb8amr7911202ioa.9.1700341585349; 
 Sat, 18 Nov 2023 13:06:25 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Alexander Gendin <agendin@matrox.com>,
 Eddie James <eajames@linux.ibm.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Linus Walleij <linus.walleij@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <seanga2@gmail.com>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3 32/32] command: Introduce functions to obtain command
 arguments
Date: Sat, 18 Nov 2023 14:05:20 -0700
Message-ID: <20231118210547.577026-33-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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

Add some functions which provide an argument to a command, or NULL if
the argument does not exist.

Use the same numbering as argv[] since it seems less confusing than the
previous idea.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Tom Rini <trini@konsulko.com>
---

Changes in v3:
- Drop RFC tag

Changes in v2:
- Add new patch to obtain command arguments

 boot/bootm.c       |  4 ++--
 cmd/booti.c        |  4 ++--
 cmd/bootz.c        |  4 ++--
 cmd/disk.c         |  4 ++--
 cmd/fuse.c         |  2 +-
 cmd/mmc.c          |  2 +-
 drivers/misc/gsc.c |  6 +++---
 fs/fs.c            |  4 ++--
 include/command.h  | 33 +++++++++++++++++++++++++++++++++
 test/cmd_ut.c      |  2 +-
 10 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 07aae26af01f..a0d17be7742c 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1014,8 +1014,8 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 		ulong img_addr;
 
 		img_addr = argc ? hextoul(argv[0], NULL) : image_load_addr;
-		ret = bootm_find_other(img_addr, argc > 1 ? argv[1] : NULL,
-				       argc > 2 ? argv[2] : NULL);
+		ret = bootm_find_other(img_addr, cmd_arg1(argc, argv),
+				       cmd_arg2(argc, argv));
 	}
 
 	if (IS_ENABLED(CONFIG_MEASURED_BOOT) && !ret &&
diff --git a/cmd/booti.c b/cmd/booti.c
index dc73c83f0db0..2db8f4a16ff2 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -95,8 +95,8 @@ static int booti_start(struct cmd_tbl *cmdtp, int flag, int argc,
 	 * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
 	 * have a header that provide this informaiton.
 	 */
-	if (bootm_find_images(image_load_addr, argc > 1 ? argv[1] : NULL,
-			      argc > 2 ? argv[2] : NULL, relocated_addr,
+	if (bootm_find_images(image_load_addr, cmd_arg1(argc, argv),
+			      cmd_arg2(argc, argv), relocated_addr,
 			      image_size))
 		return 1;
 
diff --git a/cmd/bootz.c b/cmd/bootz.c
index bcf232b4f305..a652879ea5ec 100644
--- a/cmd/bootz.c
+++ b/cmd/bootz.c
@@ -54,8 +54,8 @@ static int bootz_start(struct cmd_tbl *cmdtp, int flag, int argc,
 	 * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
 	 * have a header that provide this informaiton.
 	 */
-	if (bootm_find_images(image_load_addr, argc > 1 ? argv[1] : NULL,
-			      argc > 2 ? argv[2] : NULL, images->ep,
+	if (bootm_find_images(image_load_addr, cmd_arg1(argc, argv),
+			      cmd_arg2(argc, argv), images->ep,
 			      zi_end - zi_start))
 		return 1;
 
diff --git a/cmd/disk.c b/cmd/disk.c
index 3d7bc2f60189..92eaa02f4a13 100644
--- a/cmd/disk.c
+++ b/cmd/disk.c
@@ -40,8 +40,8 @@ int common_diskboot(struct cmd_tbl *cmdtp, const char *intf, int argc,
 
 	bootstage_mark(BOOTSTAGE_ID_IDE_BOOT_DEVICE);
 
-	part = blk_get_device_part_str(intf, (argc == 3) ? argv[2] : NULL,
-					&dev_desc, &info, 1);
+	part = blk_get_device_part_str(intf, cmd_arg2(argc, argv),
+				       &dev_desc, &info, 1);
 	if (part < 0) {
 		bootstage_error(BOOTSTAGE_ID_IDE_TYPE);
 		return 1;
diff --git a/cmd/fuse.c b/cmd/fuse.c
index 0676bb7a812f..f884c894fb00 100644
--- a/cmd/fuse.c
+++ b/cmd/fuse.c
@@ -44,7 +44,7 @@ static int confirm_prog(void)
 static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[])
 {
-	const char *op = argc >= 2 ? argv[1] : NULL;
+	const char *op = cmd_arg1(argc, argv);
 	int confirmed = argc >= 3 && !strcmp(argv[2], "-y");
 	u32 bank, word, cnt, val, cmp;
 	ulong addr;
diff --git a/cmd/mmc.c b/cmd/mmc.c
index 96befb27eec6..2d5430a53079 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -946,7 +946,7 @@ static int do_mmc_partconf(struct cmd_tbl *cmdtp, int flag,
 	}
 
 	if (argc == 2 || argc == 3)
-		return mmc_partconf_print(mmc, argc == 3 ? argv[2] : NULL);
+		return mmc_partconf_print(mmc, cmd_arg2(argc, argv));
 
 	ack = dectoul(argv[2], NULL);
 	part_num = dectoul(argv[3], NULL);
diff --git a/drivers/misc/gsc.c b/drivers/misc/gsc.c
index 65c9c2c6ce37..feb02f970650 100644
--- a/drivers/misc/gsc.c
+++ b/drivers/misc/gsc.c
@@ -531,10 +531,10 @@ static int do_gsc(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]
 		if (!gsc_wd_disable(dev))
 			return CMD_RET_SUCCESS;
 	} else if (strcasecmp(argv[1], "thermal") == 0) {
-		char *cmd, *val;
+		const char *cmd, *val;
 
-		cmd = (argc > 2) ? argv[2] : NULL;
-		val = (argc > 3) ? argv[3] : NULL;
+		cmd = cmd_arg2(argc, argv);
+		val = cmd_arg3(argc, argv);
 		if (!gsc_thermal(dev, cmd, val))
 			return CMD_RET_SUCCESS;
 	}
diff --git a/fs/fs.c b/fs/fs.c
index 4cb4310c9cc2..f33b85f92b61 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -749,7 +749,7 @@ int do_load(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 	if (argc > 7)
 		return CMD_RET_USAGE;
 
-	if (fs_set_blk_dev(argv[1], (argc >= 3) ? argv[2] : NULL, fstype)) {
+	if (fs_set_blk_dev(argv[1], cmd_arg2(argc, argv), fstype)) {
 		log_err("Can't set block device\n");
 		return 1;
 	}
@@ -818,7 +818,7 @@ int do_ls(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 	if (argc > 4)
 		return CMD_RET_USAGE;
 
-	if (fs_set_blk_dev(argv[1], (argc >= 3) ? argv[2] : NULL, fstype))
+	if (fs_set_blk_dev(argv[1], cmd_arg2(argc, argv), fstype))
 		return 1;
 
 	if (fs_ls(argc >= 4 ? argv[3] : "/"))
diff --git a/include/command.h b/include/command.h
index 5bd3ecbe8f91..4cec63454534 100644
--- a/include/command.h
+++ b/include/command.h
@@ -60,6 +60,39 @@ struct cmd_tbl {
 #endif
 };
 
+/**
+ * cmd_arg_get() - Get a particular argument
+ *
+ * @argc: Number of arguments
+ * @argv: Argument vector of length @argc
+ * @argnum: Argument to get (0=first)
+ * Return: Pointer to argument @argnum if it exists, else NULL
+ */
+static inline const char *cmd_arg_get(int argc, char *const argv[], int argnum)
+{
+	return argc > argnum ? argv[argnum] : NULL;
+}
+
+static inline const char *cmd_arg0(int argc, char *const argv[])
+{
+	return cmd_arg_get(argc, argv, 0);
+}
+
+static inline const char *cmd_arg1(int argc, char *const argv[])
+{
+	return cmd_arg_get(argc, argv, 1);
+}
+
+static inline const char *cmd_arg2(int argc, char *const argv[])
+{
+	return cmd_arg_get(argc, argv, 2);
+}
+
+static inline const char *cmd_arg3(int argc, char *const argv[])
+{
+	return cmd_arg_get(argc, argv, 3);
+}
+
 #if defined(CONFIG_CMD_RUN)
 int do_run(struct cmd_tbl *cmdtp, int flag, int argc,
 	   char *const argv[]);
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 2d5b80f992e3..2ead1c68e0ea 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -45,7 +45,7 @@ int cmd_ut_category(const char *name, const char *prefix,
 	}
 
 	ret = ut_run_list(name, prefix, tests, n_ents,
-			  argc > 1 ? argv[1] : NULL, runs_per_text, force_run,
+			  cmd_arg1(argc, argv), runs_per_text, force_run,
 			  test_insert);
 
 	return ret ? CMD_RET_FAILURE : 0;
-- 
2.43.0.rc0.421.g78406f8d94-goog

