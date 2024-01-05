Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A04C3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 16:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2848C87646;
	Fri,  5 Jan 2024 17:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kDHA3xtP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11560877CD; Fri,  5 Jan 2024 17:04:07 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78E418761C
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 17:04:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e3a67ca9fso4039335e9.0
 for <u-boot@lists.denx.de>; Fri, 05 Jan 2024 08:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704470644; x=1705075444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nh+g78OdcKB9P8k62/pfi3iJzyGRmniCRGTOIUXmHJY=;
 b=kDHA3xtPSTlVIqS59NnBWZx0e9zIrIBJlWmZq8s/e4jR2IWzaMsOm8s1flmtvnHpjY
 xr9fdR7goj/jSFxt5VRAHfGXn63szYWqmHJShvxsudm3SHA8pB90fiEXfHp2ksq+2stQ
 GcvLJO/HPZ9i/4YTXnw0mqeJG7OS02BLKlPVp6LnSrZu9n1ttyGpGDBZzWUbJETWxEZ/
 eQkwrlGLxPylozQ+NiBOWdj9M6/chJoXpsYAojptxwjGjtDaXgxeXqzUKbdInQhhMXkZ
 GaISFHHHpLWKwfVtLpN8nCvnrcCDOSolTwFFge1dFy9cyRrl7X7ojgxVZEf+Mlm1HRke
 qFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704470644; x=1705075444;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nh+g78OdcKB9P8k62/pfi3iJzyGRmniCRGTOIUXmHJY=;
 b=GPKfURBoQjIgO1VpTxbAODClsdTrAXB1oGXf4gdgX+UMt6kh4UZX7336oSYlvvhX1/
 AZlsO8yEExK+QSjxUxDfKcpDp2cn1HSqYFudhn6jGJIlRb/vfSoOBQq0oF5LbCbFxXVt
 jYzBlEMoxprjB8L0GZGkusHWbgRSTCIL8qwqC/DXfVoxteHddn641BZP9UOQkcGIMbLE
 jJf/560hLZtkJA7eEBe5I7wg4C44NyxezLpua2vM1N9hpkFzzCEYJvC6ckjqwsVD9X3V
 pQETXW5BEFRMcIjbpRjJsNs1QUJLKZq5r8DP7MKDurKMVZN9RnWN58l+312CdjNmE6zK
 7UZg==
X-Gm-Message-State: AOJu0YygsHg0hOii0LRVV9dWuMeuRPsbcGc7W716IckMU+vHYEwjIKAA
 mIqbzbp36JTKNSNhXk1FgvNrAIUpPIRhrA==
X-Google-Smtp-Source: AGHT+IH3Bzx3jDHpvlDJB7DThhjWpwJodt2kPVekOjDH4mDTPgz7aFtRz1Aeevjt9HPJR+iyLL8CPA==
X-Received: by 2002:a05:600c:45cd:b0:40d:38ba:544e with SMTP id
 s13-20020a05600c45cd00b0040d38ba544emr1398819wmo.60.1704470643765; 
 Fri, 05 Jan 2024 08:04:03 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-230.as13285.net.
 [92.17.96.230]) by smtp.gmail.com with ESMTPSA id
 m39-20020a05600c3b2700b0040d85a304desm1977372wms.35.2024.01.05.08.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 08:04:03 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH] boot: add support for button commands
Date: Fri,  5 Jan 2024 16:03:58 +0000
Message-ID: <20240105160359.634310-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.42.1
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

With the relatively new button API in U-Boot, it's now much easier to
model the common usecase of mapping arbitrary actions to different
buttons during boot - for example entering fastboot mode, setting some
additional kernel cmdline arguments, or booting with a custom recovery
ramdisk, to name a few.

Historically, this functionality has been implemented in board code,
making it fixed for a given U-Boot binary and requiring the code be
duplicated and modified for every board.

Implement a generic abstraction to run an arbitrary command during boot
when a specific button is pressed. The button -> command mapping is
configured via environment variables with the following format:

  button_cmd_N_name=<button label>
  button_cmd_N=<command to run>

Where N is the mapping number starting from 0. For example:

  button_cmd_0_name=vol_down
  button_cmd_0=fastboot usb 0

This will cause the device to enter fastboot mode if volume down is held
during boot.

After we enter the cli loop the button commands are no longer valid,
this allows the buttons to additionally be used for navigating a boot
menu.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 boot/Kconfig              | 14 +++++++
 common/Makefile           |  1 +
 common/button_cmd.c       | 83 +++++++++++++++++++++++++++++++++++++++
 common/main.c             |  3 ++
 doc/usage/environment.rst |  4 ++
 include/button.h          |  9 +++++
 6 files changed, 114 insertions(+)
 create mode 100644 common/button_cmd.c

diff --git a/boot/Kconfig b/boot/Kconfig
index fbc49c5bca47..9580ef1cfca4 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -20,6 +20,20 @@ config TIMESTAMP
 	  loaded that does not, the message 'Wrong FIT format: no timestamp'
 	  is shown.
 
+config BUTTON_CMD
+	bool "Support for running a command if a button is held during boot"
+	default n
+	help
+	  For many embedded devices it's useful to enter a special flashing mode
+	  such as fastboot mode when a button is held during boot. This option
+	  allows arbitrary commands to be assigned to specific buttons. These will
+	  be run after "preboot" if the button is held. Configuration is done via
+	  the environment variables "button_cmd_N_name" and "button_cmd_N" where n is
+	  the button number (starting from 0). e.g:
+
+	    "button_cmd_0_name=vol_down"
+	    "button_cmd_0=fastboot usb 0"
+
 menuconfig FIT
 	bool "Flattened Image Tree (FIT)"
 	select HASH
diff --git a/common/Makefile b/common/Makefile
index cdeadf72026c..53105a6ce12a 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -10,6 +10,7 @@ obj-y += main.o
 obj-y += exports.o
 obj-$(CONFIG_HUSH_PARSER) += cli_hush.o
 obj-$(CONFIG_AUTOBOOT) += autoboot.o
+obj-$(CONFIG_BUTTON_CMD) += button_cmd.o
 
 # # boards
 obj-y += board_f.o
diff --git a/common/button_cmd.c b/common/button_cmd.c
new file mode 100644
index 000000000000..1caea50d3f84
--- /dev/null
+++ b/common/button_cmd.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 Linaro Ltd.
+ *   Author: Caleb Connolly <caleb.connolly@linaro.org>
+ */
+
+#include <button.h>
+#include <command.h>
+#include <env.h>
+#include <log.h>
+#include <vsprintf.h>
+
+/* Some sane limit "just in case" */
+#define MAX_BTN_CMDS 32
+
+struct button_cmd {
+	bool pressed;
+	const char *btn_name;
+	const char *cmd;
+};
+
+/*
+ * Button commands are set via environment variables, e.g.:
+ * button_cmd_N_name=Volume Up
+ * button_cmd_N=fastboot usb 0
+ *
+ * This function will retrieve the command for the given button N
+ * and populate the cmd struct with the command string and pressed
+ * state of the button.
+ *
+ * Returns 1 if a command was found, 0 otherwise.
+ */
+int get_button_cmd(int n, struct button_cmd *cmd)
+{
+	const char *cmd_str;
+	struct udevice *btn;
+	char buf[24];
+
+	snprintf(buf, sizeof(buf), "button_cmd_%d_name", n);
+	cmd->btn_name = env_get(buf);
+	if (!cmd->btn_name)
+		return 0;
+
+	button_get_by_label(cmd->btn_name, &btn);
+	if (!btn) {
+		log_err("No button labelled '%s'\n", cmd->btn_name);
+		return 0;
+	}
+
+	cmd->pressed = button_get_state(btn) == BUTTON_ON;
+	/* If the button isn't pressed then cmd->cmd will be unused so don't waste
+	 * cycles reading it
+	 */
+	if (!cmd->pressed)
+		return 1;
+
+	snprintf(buf, sizeof(buf), "button_cmd_%d", n);
+	cmd_str = env_get(buf);
+	if (!cmd_str) {
+		log_err("No command set for button '%s'\n", cmd->btn_name);
+		return 0;
+	}
+
+	cmd->cmd = cmd_str;
+
+	return 1;
+}
+
+void process_button_cmds(void)
+{
+	struct button_cmd cmd = {0};
+	int i = 0;
+
+	while (get_button_cmd(i++, &cmd) && i < MAX_BTN_CMDS) {
+		if (!cmd.pressed)
+			continue;
+
+		log_info("BTN '%s'> %s\n", cmd.btn_name, cmd.cmd);
+		run_command(cmd.cmd, CMD_FLAG_ENV);
+		/* Don't run commands for multiple buttons */
+		return;
+	}
+}
diff --git a/common/main.c b/common/main.c
index 7c70de2e59a8..717e8b7e8bd2 100644
--- a/common/main.c
+++ b/common/main.c
@@ -8,6 +8,7 @@
 
 #include <common.h>
 #include <autoboot.h>
+#include <button.h>
 #include <bootstage.h>
 #include <cli.h>
 #include <command.h>
@@ -61,6 +62,8 @@ void main_loop(void)
 			efi_launch_capsules();
 	}
 
+	process_button_cmds();
+
 	s = bootdelay_process();
 	if (cli_process_fdt(&s))
 		cli_secure_boot_cmd(s);
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index c57b717caaf3..ce5a9627f025 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -190,6 +190,10 @@ bootm_size
 bootstopkeysha256, bootdelaykey, bootstopkey
     See README.autoboot
 
+button_cmd_0, button_cmd_0_name ... button_cmd_N, button_cmd_N_name
+    Used to map commands to run when a button is held during boot.
+    See CONFIG_BUTTON_CMD.
+
 updatefile
     Location of the software update file on a TFTP server, used
     by the automatic software update feature. Please refer to
diff --git a/include/button.h b/include/button.h
index 207f4a0f4dbd..43e4ffdca1e7 100644
--- a/include/button.h
+++ b/include/button.h
@@ -74,4 +74,13 @@ enum button_state_t button_get_state(struct udevice *dev);
  */
 int button_get_code(struct udevice *dev);
 
+#ifdef CONFIG_BUTTON_CMD
+/* Process button command mappings specified in the environment,
+ * running the commands for buttons which are pressed
+ */
+void process_button_cmds(void);
+#else
+static inline void process_button_cmds(void) {}
+#endif /* CONFIG_BUTTON_CMD */
+
 #endif
-- 
2.42.1

