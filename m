Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3D6C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E540F8723C;
	Sun, 12 Nov 2023 21:03:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c0DWty0r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38BB886D62; Sun, 12 Nov 2023 21:03:13 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D49BB8713D
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-359d27f6d46so13111915ab.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819382; x=1700424182; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxK20rOJRv/ri5JwuO3rtcShp8zyi81HE5O+GMRq7js=;
 b=c0DWty0rxOKGaD5/PmybnhFtRKD0jqk3oJSO9UjZtYzCs4Z61FK+RKt8IZNmf5QGD0
 285Lg4z5uGI9Gcv1mMNkbqt+5EmU0UQCDR3HjtT5+hENdV6HyzTNMy0XdPn4EwQBwfTG
 U9r1sgGnEoCrAk/LcdankcI9zpDQVFP74KGRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819382; x=1700424182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DxK20rOJRv/ri5JwuO3rtcShp8zyi81HE5O+GMRq7js=;
 b=o1SjoigVW6x8BFagYHg5XbQe0RypsTAZqIWMuJSMBSIk4UHyP2RuOIP6QzS3hgGhb1
 kSfHpU3BI4dVI/VSQMQMNnVRyT0GnXr6ly3thila0C0iqycEjPfKGINux2VOgrVxA2IA
 Qv8+AhyQBWa23sAIcZL7d+MWuZrsLuPuz1CzT2z/e4PV1msL+sSwAro2vgCDWFxOO8Qv
 jiIF7llAkw96UgthsXN6nR0b3cFJg/Yi+FhQ7yijOmalCwf0IqBoe4OWCP8M4RzWCBN4
 6QiYy7mpsz5lKSw+XbmMDaYBXXlhDSBTRNe/TbY218R01yHcBbO/vZryL1vqs8mOIXJK
 Qb3g==
X-Gm-Message-State: AOJu0YxA1fzTlROw7YamiRdqNCBa8iR2f0ngz61Fd9oYYPQ6CMR8OAiX
 FeANNo/fjEi2V7BQAfZarc+o70x1ODew+QlXAONBBw==
X-Google-Smtp-Source: AGHT+IFFiM3SzT4r31KZ61EMn6LfFHlakD6Saj5kAHNLpVW/xBtwQnKmqRdbXmqwUodLXufhVbi5Cg==
X-Received: by 2002:a05:6e02:216e:b0:359:4b03:d943 with SMTP id
 s14-20020a056e02216e00b003594b03d943mr7328581ilv.11.1699819381986; 
 Sun, 12 Nov 2023 12:03:01 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a923204000000b0035761b749casm1208256ile.46.2023.11.12.12.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 12:03:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Jaewon Jung <jaewon8868@gmail.com>
Subject: [PATCH v4 03/12] bootstd: Add a return code to bootflow menu
Date: Sun, 12 Nov 2023 13:02:40 -0700
Message-ID: <20231112130245.v4.3.Iaa9b5bbab0f25012cfc68a803a9da83e71b19aaf@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112200255.172351-1-sjg@chromium.org>
References: <20231112200255.172351-1-sjg@chromium.org>
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

(no changes since v3)

Changes in v3:
- Add missing word 'function' in the commit message

Changes in v2:
- Add new patch to add a return code to bootflow menu

 cmd/bootflow.c             | 53 +++++++++++++++++++++++-------
 doc/usage/cmd/bootflow.rst | 67 ++++++++++++++++++++++++++++++++++++++
 test/boot/bootflow.c       | 15 +++++++++
 3 files changed, 123 insertions(+), 12 deletions(-)

diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index ad39ebe4379f..3aeb40d690f4 100644
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
index 9c5ea9c5d84e..2198ff60493e 100644
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
index 102b2b561356..b97c566f000b 100644
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
2.42.0.869.gea05f2083d-goog

