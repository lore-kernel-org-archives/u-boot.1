Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06532E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CCF5871EE;
	Mon,  2 Oct 2023 03:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CvWXp89x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 827C98713B; Mon,  2 Oct 2023 03:15:42 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 278868714A
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3af8b498d31so591615b6e.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209297; x=1696814097; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T63e+csyAHuwUMalC0DxLLMlxLayO8CUgJZYFlzlegg=;
 b=CvWXp89xXilixOpkuWH+lAuE8OdSj67ztO8tN9VQ2CKCm7RkIP4M7X2vDanfgSY5UX
 BYHsDfw6IxlwKVQH7xEE6ipI+7q78IM02bO4HSiqKIliKv84MpieP6+29BQGQbCfUIKd
 jXOOqQ+JmWK9TkGwWxCXZRwiUv0DyjJJkWjrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209297; x=1696814097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T63e+csyAHuwUMalC0DxLLMlxLayO8CUgJZYFlzlegg=;
 b=AG7EYToByZ/v4WRKzyF7YSaeSTyONdcQAhgb8VIMPmusya0497Ut5NnUmkOC2lzLd5
 4MvWVpYrqcSg4svyObrcCPN5JpCeSz4nMi+gDfWgpwpuVTD650G26vZv2uYD0dQXZ30k
 hA7+EhdpuIpT8t2Tfz0G2jRdahjM2hmLOMFJfFpHhY1Gmzd0qvJ7T2R+axyQCfOIT0UR
 eB83g65DFa/SJ+XpqO8zKwqr2mXYZWwZpobnXb4Rv6pJ2EqhhXGIycYQ21/v8gH82DMY
 NiGj5zEg0XK+A7GmNazkq1GWCiTV2hJo3/VBQJe1dkKqtWlVkhxDebu8xIXzO4vznUhs
 NQTg==
X-Gm-Message-State: AOJu0YwW+UEN4mfwiZBm7GHBG5jSdWQSWk5qBr8eVmpU//y1HBZ9yday
 KtkRc4fDnIOy4N6YDmH5sswOj77/MQB4Y7+bIMM=
X-Google-Smtp-Source: AGHT+IHFXYL8jdLXNjkVsF+l0lqHM0lN4mWlfdA3xWYquwwFOUVkiCFnSP3lYxUFPjZ5ykgXPJ8mag==
X-Received: by 2002:aca:91a:0:b0:3ab:8295:f2f1 with SMTP id
 26-20020aca091a000000b003ab8295f2f1mr11745637oij.45.1696209297189; 
 Sun, 01 Oct 2023 18:14:57 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s23-20020a02c517000000b0042b2e309f97sm6522951jam.177.2023.10.01.18.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 03/12] bootstd: Add a return code to bootflow menu
Date: Sun,  1 Oct 2023 19:14:38 -0600
Message-ID: <20231001191444.v3.3.Iaa9b5bbab0f25012cfc68a803a9da83e71b19aaf@changeid>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011450.462468-1-sjg@chromium.org>
References: <20231002011450.462468-1-sjg@chromium.org>
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

Return an error when the user does not select an OS, so we know whether
to boot or not.

Move calling of bootflow_menu_run() into a separate function so we can
call it from other places.

Expand the test to cover these cases.

Add some documentation also, while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add missing word 'function' in the commit message

Changes in v2:
- Add new patch to add a return code to bootflow menu

 cmd/bootflow.c             | 53 +++++++++++++++++++++++-------
 doc/usage/cmd/bootflow.rst | 67 ++++++++++++++++++++++++++++++++++++++
 test/boot/bootflow.c       | 15 +++++++++
 3 files changed, 123 insertions(+), 12 deletions(-)

diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 300ad3aaa760..1516f8a4193b 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -89,6 +89,44 @@ static void show_footer(int count, int num_valid)
 	       num_valid);
 }
 
+/**
+ * bootflow_handle_menu() - Handle running the menu and updating cur bootflow
+ *
+ * This shows the menu, allows the user to select something and then prints
+ * what happened
+ *
+ * @std: bootstd information
+ * @text_mode: true to run the menu in text mode
+ * @bflowp: Returns selected bootflow, on success
+ * Return: 0 on success (a bootflow was selected), -EAGAIN if nothing was
+ *	chosen, other -ve value on other error
+ */
+__maybe_unused static int bootflow_handle_menu(struct bootstd_priv *std,
+					       bool text_mode,
+					       struct bootflow **bflowp)
+{
+	struct bootflow *bflow;
+	int ret;
+
+	ret = bootflow_menu_run(std, text_mode, &bflow);
+	if (ret) {
+		if (ret == -EAGAIN) {
+			printf("Nothing chosen\n");
+			std->cur_bootflow = NULL;
+		} else {
+			printf("Menu failed (err=%d)\n", ret);
+		}
+
+		return ret;
+	}
+
+	printf("Selected: %s\n", bflow->os_name ? bflow->os_name : bflow->name);
+	std->cur_bootflow = bflow;
+	*bflowp = bflow;
+
+	return 0;
+}
+
 static int do_bootflow_scan(struct cmd_tbl *cmdtp, int flag, int argc,
 			    char *const argv[])
 {
@@ -455,18 +493,9 @@ static int do_bootflow_menu(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (ret)
 		return CMD_RET_FAILURE;
 
-	ret = bootflow_menu_run(std, text_mode, &bflow);
-	if (ret) {
-		if (ret == -EAGAIN)
-			printf("Nothing chosen\n");
-		else {
-			printf("Menu failed (err=%d)\n", ret);
-			return CMD_RET_FAILURE;
-		}
-	}
-
-	printf("Selected: %s\n", bflow->os_name ? bflow->os_name : bflow->name);
-	std->cur_bootflow = bflow;
+	ret = bootflow_handle_menu(std, text_mode, &bflow);
+	if (ret)
+		return CMD_RET_FAILURE;
 
 	return 0;
 }
diff --git a/doc/usage/cmd/bootflow.rst b/doc/usage/cmd/bootflow.rst
index ead493d0aaf8..6a0645c28d07 100644
--- a/doc/usage/cmd/bootflow.rst
+++ b/doc/usage/cmd/bootflow.rst
@@ -15,6 +15,7 @@ Synopis
     bootflow read
     bootflow boot
     bootflow cmdline [set|get|clear|delete|auto] <param> [<value>]
+    bootfloe menu [-t]
 
 Description
 -----------
@@ -24,6 +25,9 @@ locate bootflows, list them and boot them.
 
 See :doc:`../../develop/bootstd` for more information.
 
+Note that `CONFIG_BOOTSTD_FULL` (which enables `CONFIG_CMD_BOOTFLOW_FULL) must
+be enabled to obtain full functionality with this command. Otherwise, it only
+supports `bootflow scan` which scans and boots the first available bootflow.
 
 bootflow scan
 ~~~~~~~~~~~~~
@@ -247,6 +251,16 @@ can be used to set the early console (or console) to a suitable value so that
 output appears on the serial port. This is only supported by the 16550 serial
 driver so far.
 
+bootflow menu
+~~~~~~~~~~~~~
+
+This shows a menu with available bootflows. The user can select a particular
+bootflow, which then becomes the current one.
+
+The `-t` flag requests a text menu. Otherwise, if a display is available, a
+graphical menu is shown.
+
+
 Example
 -------
 
@@ -658,6 +672,56 @@ Now the buffer can be accessed::
     77b7e4e0: 320fc000 08e8ba0f c031300f b8d0000f  ...2.....01.....
     77b7e4f0: 00000020 6ad8000f 00858d10 50000002   ......j.......P
 
+This shows using a text menu to boot an OS::
+
+    => bootflow scan
+    => bootfl list
+    => bootfl menu -t
+    U-Boot    :    Boot Menu
+
+    UP and DOWN to choose, ENTER to select
+
+      >    0  mmc1        mmc1.bootdev.whole
+           1  mmc1        Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
+           2  mmc1        mmc1.bootdev.part_1
+           3  mmc4        mmc4.bootdev.whole
+           4  mmc4        Armbian
+           5  mmc4        mmc4.bootdev.part_1
+           6  mmc5        mmc5.bootdev.whole
+           7  mmc5        ChromeOS
+           8  mmc5        ChromeOS
+    U-Boot    :    Boot Menu
+
+    UP and DOWN to choose, ENTER to select
+
+           0  mmc1        mmc1.bootdev.whole
+      >    1  mmc1        Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
+           2  mmc1        mmc1.bootdev.part_1
+           3  mmc4        mmc4.bootdev.whole
+           4  mmc4        Armbian
+           5  mmc4        mmc4.bootdev.part_1
+           6  mmc5        mmc5.bootdev.whole
+           7  mmc5        ChromeOS
+           8  mmc5        ChromeOS
+    U-Boot    :    Boot Menu
+
+    Selected: Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
+    => bootfl boot
+    ** Booting bootflow 'mmc1.bootdev.part_1' with extlinux
+    Ignoring unknown command: ui
+    Ignoring malformed menu command:  autoboot
+    Ignoring malformed menu command:  hidden
+    Ignoring unknown command: totaltimeout
+    Fedora-Workstation-armhfp-31-1.9 Boot Options.
+    1:	Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
+    Enter choice: 1
+    1:	Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
+    Retrieving file: /vmlinuz-5.3.7-301.fc31.armv7hl
+    Retrieving file: /initramfs-5.3.7-301.fc31.armv7hl.img
+    append: ro root=UUID=9732b35b-4cd5-458b-9b91-80f7047e0b8a rhgb quiet LANG=en_US.UTF-8 cma=192MB cma=256MB
+    Retrieving file: /dtb-5.3.7-301.fc31.armv7hl/sandbox.dtb
+    ...
+
 
 Return value
 ------------
@@ -667,6 +731,9 @@ return to U-Boot. If something about the U-Boot processing fails, then the
 return value $? is 1. If the boot succeeds but for some reason the Operating
 System returns, then $? is 0, indicating success.
 
+For `bootflow menu` the return value is $? is 0 (true) if an option was choses,
+else 1.
+
 For other subcommands, the return value $? is always 0 (true).
 
 
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 0a992e2bcc14..04a5bd5d7a80 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -604,8 +604,12 @@ static int scan_mmc4_bootdev(struct unit_test_state *uts)
 /* Check 'bootflow menu' to select a bootflow */
 static int bootflow_cmd_menu(struct unit_test_state *uts)
 {
+	struct bootstd_priv *std;
 	char prev[3];
 
+	/* get access to the current bootflow */
+	ut_assertok(bootstd_get_priv(&std));
+
 	ut_assertok(scan_mmc4_bootdev(uts));
 
 	/* Add keypresses to move to and select the second one in the list */
@@ -616,6 +620,17 @@ static int bootflow_cmd_menu(struct unit_test_state *uts)
 
 	ut_assertok(run_command("bootflow menu", 0));
 	ut_assert_nextline("Selected: Armbian");
+	ut_assertnonnull(std->cur_bootflow);
+	ut_assert_console_end();
+
+	/* Check not selecting anything */
+	prev[0] = '\e';
+	prev[1] = '\0';
+	ut_asserteq(1, console_in_puts(prev));
+
+	ut_asserteq(1, run_command("bootflow menu", 0));
+	ut_assertnull(std->cur_bootflow);
+	ut_assert_nextline("Nothing chosen");
 	ut_assert_console_end();
 
 	return 0;
-- 
2.42.0.582.g8ccd20d70d-goog

