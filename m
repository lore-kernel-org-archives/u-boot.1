Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5C9C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 16:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BD5181110;
	Tue, 25 Feb 2025 17:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uXsJLFLm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B118807EE; Tue, 25 Feb 2025 17:35:30 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46D48810ED
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 17:35:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38f2b7ce319so4855259f8f.2
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 08:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740501327; x=1741106127; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OthUcvUIuZBCEF+aN20wP8+dBhQiAg81fe/EO+MQUZs=;
 b=uXsJLFLmAAJ/iM17We/XoNGzAgdxwd38NbAr8GeXTifc/SR7ofV1PkO6RWNSFpxQJB
 k1V5s/F7+wW6t9pTnLA9sdQkMyiJNVOz8ZtE0d3yEnzDpbkEyZt/zpO29l38oZ9ZvQKI
 PLyM6zL87/L34bnZ4hJIrz+X705fwpvD86GCI5J+5kLr5AJ978FhirHYGWbMDDfVhyM3
 CsduFGumbx83jPjqdHXxVoS6VRxcb2fCnVYqg5AcB8ncYRHeZKzZPdXGJ6T5QWqgT7mz
 BU3uQ924ueJCaZdpmDGLP2IHSuIf0Io922x6lAuIGe9CdLOl5F8KGGAToW8WGR4YYWT8
 3+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740501327; x=1741106127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OthUcvUIuZBCEF+aN20wP8+dBhQiAg81fe/EO+MQUZs=;
 b=hzJW/oXS/81vlISmzwQervBPatdO0VUsSjsgR3V5tJscD43HvhZjLHX6gb5U5fjlnY
 T+HY+xD5HklnowhvJkPqcp84rP3RHVl9nUZFBBxGLqxbp4x36EiwsGXmD24GVVpf2cw4
 fhr8tG8vOeOT79JZkN4on51ttoPgTlnTx/naReOz/9sxdzJSW7YUeHqecpk6Bfcy/Pyj
 55giIiB1UCjCRKmUASmSJxnNU6y1vuvVFJPiaP1s2obqqAyumumsPA23eaegJ7jbN2bW
 PQ+fc8NFpfp7miVyLGnwiVK4ZmEEsjeey1YPYaxU2OGS/kO7gfqEbg24q+ZK5zovZrPi
 haFQ==
X-Gm-Message-State: AOJu0YzocVsdrpV/CtMJia4XVm/6JLfLHYxdEY+F9WpyQ0pPccuQjLie
 0kDDUz5VhkAVvK7mhVzuB0pzax7tmxrObZVIdxT1Bj2E3GKM6SkggR7NkqbABErdgnKUwkqHZUX
 BWnT6XQ==
X-Gm-Gg: ASbGnctdw5p0X8lAZuzmPIbjEgFgAn6yIR27cL/ki76wdbnDffF5JKPboWcRvCfkdb/
 BiiUKpM7/+OpTmqjlnSGxd5OeaXo9o/WJyoAucUWlgOd1QnkV9NXbboMxtC6YQ3GaAX4PBO+Xy6
 QHxaU0Gm0PB/skMaUXUKXtAg1u6V8m0EpSgiY18xX7IDw5goeJGozj5ST6UT7HBz1XIToOpahAi
 efsmOsSsMt9adpFymdMTM4/HBM7GfON6V1e7uP+kBOVbDsdrc2GXT9mPwvcJKBkr3FvEcYzHPXz
 cOJ68Mf/i7nA74NUlq6egXpH2CTDw5l9tU4=
X-Google-Smtp-Source: AGHT+IHr+5+TkQZIv8uv12Qym9gODzLxrWB/B+ngd2UPVOpmr7NLs3P4fBy+Z3hgrn/C2ijPrIgr6w==
X-Received: by 2002:a05:6000:4026:b0:38f:2856:7d9a with SMTP id
 ffacd0b85a97d-38f6e7563cfmr16711102f8f.3.1740501327365; 
 Tue, 25 Feb 2025 08:35:27 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce735sm146356195e9.3.2025.02.25.08.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:35:27 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH v2 13/14] cmd: add spawn and wait commands
Date: Tue, 25 Feb 2025 17:34:39 +0100
Message-ID: <0c5c69d56b8505d2e678de96d07ea066f3459ccc.1740499185.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740499185.git.jerome.forissier@linaro.org>
References: <cover.1740499185.git.jerome.forissier@linaro.org>
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

Add a spawn command which runs another command in the background, as
well as a wait command to suspend the shell until one or more background
jobs have completed. The job_id environment variable is set by spawn and
wait accepts optional job ids, so that one can selectively wait on any
job.

Example:

 => date; spawn sleep 5; spawn sleep 3; date; echo "waiting..."; wait; date
 Date: 2025-02-21 (Friday)    Time: 17:04:52
 Date: 2025-02-21 (Friday)    Time: 17:04:52
 waiting...
 Date: 2025-02-21 (Friday)    Time: 17:04:57
 =>

Another example showing how background jobs can make initlizations
faster. The board is i.MX93 EVK, with one spinning HDD connected to
USB1 via a hub, and a network cable plugged into ENET1.

 # From power up / reset
 u-boot=> setenv autoload 0
 u-boot=> setenv ud "usb start; dhcp"
 u-boot=> time run ud
 [...]
 time: 8.058 seconds

 # From power up / reset
 u-boot=> setenv autoload 0
 u-boot=> setenv ud "spawn usb start; spawn dhcp; wait"
 u-boot=> time run ud
 [...]
 time: 4.475 seconds

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig      |  17 +++++
 cmd/Makefile     |   2 +
 cmd/spawn.c      | 176 +++++++++++++++++++++++++++++++++++++++++++++++
 common/console.c |   2 +
 4 files changed, 197 insertions(+)
 create mode 100644 cmd/spawn.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 8dd42571abc..209ca365f4c 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -3058,4 +3058,21 @@ config CMD_MESON
 	help
 	  Enable useful commands for the Meson Soc family developed by Amlogic Inc.
 
+config CMD_SPAWN
+	bool "spawn and wait commands"
+	depends on UTHREAD
+	help
+	  spawn runs a command in the background and sets the job_id environment
+	  variable. wait is used to suspend the shell execution until one or more
+	  jobs are complete.
+
+config CMD_SPAWN_NUM_JOBS
+	int "Maximum number of simultaneous jobs for spawn"
+	default 16
+	help
+	  Job identifiers are in the range 1..CMD_SPAWN_NUM_JOBS. In other words
+	  there can be no more that CMD_SPAWN_NUM_JOBS running simultaneously.
+	  When a jobs exits, its identifier is available to be re-used by the next
+	  spawn command.
+
 endif
diff --git a/cmd/Makefile b/cmd/Makefile
index 8410be576bb..eeda40855bf 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -240,6 +240,8 @@ obj-$(CONFIG_CMD_SCP03) += scp03.o
 
 obj-$(CONFIG_HUSH_SELECTABLE) += cli.o
 
+obj-$(CONFIG_CMD_SPAWN) += spawn.o
+
 obj-$(CONFIG_ARM) += arm/
 obj-$(CONFIG_RISCV) += riscv/
 obj-$(CONFIG_SANDBOX) += sandbox/
diff --git a/cmd/spawn.c b/cmd/spawn.c
new file mode 100644
index 00000000000..26532a30087
--- /dev/null
+++ b/cmd/spawn.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2011 The Chromium OS Authors.
+ */
+
+#include <command.h>
+#include <malloc.h>
+#include <vsprintf.h>
+#include <uthread.h>
+
+/* Spawn arguments and job index  */
+struct spa {
+	int argc;
+	char **argv;
+	unsigned int job_idx;
+};
+
+/*
+ * uthread group identifiers for each running job
+ * 0: job slot available, != 0: uthread group id
+ * Note that job[0] is job_id 1, job[1] is job_id 2 etc.
+ */
+static unsigned int job[CONFIG_CMD_SPAWN_NUM_JOBS];
+/*
+ * Return values of the commands run as jobs */
+static enum command_ret_t job_ret[CONFIG_CMD_SPAWN_NUM_JOBS];
+
+static void spa_free(struct spa *spa)
+{
+	int i;
+
+	if (!spa)
+		return;
+
+	for (i = 0; i < spa->argc; i++)
+		free(spa->argv[i]);
+	free(spa->argv);
+	free(spa);
+}
+
+static struct spa *spa_create(int argc, char *const argv[])
+{
+	struct spa *spa;
+	int i;
+
+	spa = calloc(1, sizeof(*spa));
+	if (!spa)
+		return NULL;
+	spa->argc = argc;
+	spa->argv = malloc(argc * sizeof(char *));
+	if (!spa->argv)
+		goto err;
+	for (i = 0; i < argc; i++) {
+		spa->argv[i] = strdup(argv[i]);
+		if (!spa->argv[i])
+			goto err;
+	}
+	return spa;
+err:
+	spa_free(spa);
+	return NULL;
+}
+
+static void spawn_thread(void *arg)
+{
+	struct spa *spa = (struct spa *)arg;
+	ulong cycles = 0;
+	int repeatable = 0;
+
+	job_ret[spa->job_idx] = cmd_process(0, spa->argc, spa->argv,
+					    &repeatable, &cycles);
+	spa_free(spa);
+}
+
+static unsigned int next_job_id(void)
+{
+	int i;
+
+	for (i = 0; i < CONFIG_CMD_SPAWN_NUM_JOBS; i++)
+		if (!job[i])
+			return i + 1;
+
+	/* No job available */
+	return 0;
+}
+
+static void refresh_jobs(void)
+{
+	int i;
+
+	for (i = 0; i < CONFIG_CMD_SPAWN_NUM_JOBS; i++)
+		if (job[i] && uthread_grp_done(job[i]))
+			job[i] = 0;
+
+}
+
+static int do_spawn(struct cmd_tbl *cmdtp, int flag, int argc,
+		    char *const argv[])
+{
+	unsigned int id;
+	unsigned int idx;
+	struct spa *spa;
+	int ret;
+
+	if (argc == 1)
+		return CMD_RET_USAGE;
+
+	spa = spa_create(argc - 1, argv + 1);
+	if (!spa)
+		return CMD_RET_FAILURE;
+
+	refresh_jobs();
+
+	id = next_job_id();
+	if (!id)
+		return CMD_RET_FAILURE;
+	idx = id - 1;
+
+	job[idx] = uthread_grp_new_id();
+
+	ret = uthread_create(spawn_thread, spa, 0, job[idx]);
+	if (ret) {
+		job[idx] = 0;
+		return CMD_RET_FAILURE;
+	}
+
+	ret = env_set_ulong("job_id", id);
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+U_BOOT_CMD(spawn, CONFIG_SYS_MAXARGS, 0, do_spawn,
+	   "run commands and summarize execution time",
+	   "command [args...]\n");
+
+static enum command_ret_t wait_job(unsigned int idx)
+{
+	while (!uthread_grp_done(job[idx]))
+		uthread_schedule();
+	job[idx] = 0;
+	return job_ret[idx];
+}
+
+static int do_wait(struct cmd_tbl *cmdtp, int flag, int argc,
+		   char *const argv[])
+{
+	enum command_ret_t ret = CMD_RET_SUCCESS;
+	unsigned long id;
+	unsigned int idx;
+	int i;
+
+	if (argc == 1) {
+		for (i = 0; i < CONFIG_CMD_SPAWN_NUM_JOBS; i++)
+			if (job[idx])
+				ret = wait_job(i);
+	} else {
+		for (i = 1; i < argc; i++) {
+			id = dectoul(argv[i], NULL);
+			if (id < 0 || id > CONFIG_CMD_SPAWN_NUM_JOBS)
+				return CMD_RET_USAGE;
+			idx = (int)id - 1;
+			ret = wait_job(idx);
+		}
+	}
+
+	return ret;
+}
+
+U_BOOT_CMD(wait, CONFIG_SYS_MAXARGS, 0, do_wait,
+	   "wait for one or more jobs to complete",
+	   "[job_id ...]\n"
+	   "    - Wait until all specified jobs have exited and return the\n"
+	   "      exit status of the last job waited for. When no job_id is\n"
+	   "      given, wait for all the background jobs.\n");
diff --git a/common/console.c b/common/console.c
index 863ac6aa9dc..2c8eaa37ad7 100644
--- a/common/console.c
+++ b/common/console.c
@@ -24,6 +24,7 @@
 #include <watchdog.h>
 #include <asm/global_data.h>
 #include <linux/delay.h>
+#include <uthread.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -508,6 +509,7 @@ int fgetc(int file)
 		 */
 		for (;;) {
 			schedule();
+			uthread_schedule();
 			if (CONFIG_IS_ENABLED(CONSOLE_MUX)) {
 				/*
 				 * Upper layer may have already called tstc() so
-- 
2.43.0

