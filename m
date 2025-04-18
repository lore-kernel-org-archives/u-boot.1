Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09EDC369CA
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4367E832BF;
	Fri, 18 Apr 2025 16:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O0K5YHxO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B15483335; Fri, 18 Apr 2025 16:11:48 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39F36832A4
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso16513315e9.0
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744985504; x=1745590304; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=chWyipr7Iga6dO7xyssNXgSX1qr0xJqct2dEjWcjxNA=;
 b=O0K5YHxOPWvRFFs0UooaMgVYchoTZqu0QqtW3tP3d9d1059yyHWRbVtLijSdYG+9uT
 D8RYyvJdztI+/YQ7hkvn9GUSwNmuqH2+2xBW/0sVqxJQa1V1X0wwu/4s3xDVeAxZGTMg
 cZN29LOBFDawz9ECd0We3ChscULz36FPd6q85vr85YfeVSvW/w3p2M4PwQZUnm92bUWa
 ViEgRgfSyrwQZo1dyNAqa2lUiWp3yUWnUVneH/QtwtY2+Vg4m+vKvwbqGKTDDY+v0ZoQ
 PUX/M+M1fu0wMtP5jRb+ph7AsAtoBMbQrrG82skDbTIlnrC2XR+ZCq6V2QFLeqlKigiK
 ZO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985504; x=1745590304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=chWyipr7Iga6dO7xyssNXgSX1qr0xJqct2dEjWcjxNA=;
 b=bddmH0A8vwvZYAVgvs7nGIvGKRmPSb78TLzBC9gQoufec40fmI3FerOLXPacVx0BIi
 FvzK4CvM23Mv/EjcLtA6ydHYk6RAqT4FeGeQJBcWR1oI2Wvk+znLwf/QkxzrnXAk9mUv
 FSefurxOzaxNoxQdzMUG+840SjX/ojLZsIiN+bM5RCueYNKax3NQmQ+eIFNA56igUe2R
 JVqq0Jeern/BQG6QP2ro/7uxVW/B4UGV30kSBX2KqfjEmi3QaI2ad9lZH55aIo8hyOzz
 XWA0HKMOWPDpNxJcj4hpFrtRnXE5Q2JedabqcK7ZknVchxsiIcnIaV0+mKzSk9mVVhe5
 AVtA==
X-Gm-Message-State: AOJu0YxbzBdAy//ArB76X20BGLxXQK5BgUi9VKxmVJZSiiBSnzsro2Rc
 EcK64gpiocEygJqzEbsusdFDCj12WTxu0izCN3EFL/nrCp5rvKNoH61bviEjQIgQT3/GKceemOV
 ggZpDvw==
X-Gm-Gg: ASbGncutcMI6DysKcOmznWPCP0UCcP1udf4WNJKnLvTCfSUf08f0lByHwHzLG6bbTdT
 ku99Ixu+og+g4acA3d49QeItI7CjMBdOHH4L84Ittrcw93mIklQy33BEifpeHpwVLAEzex3XtB1
 bv66TT25zn9yLnG/q3cqqgD8kIusUrnSijDMo+btqgcgebsBtDfSHEFhPN8NckngdWDqphtcE3a
 4fFuMn/BP8loKA6Crl7nuq6f5h8YVKtfhNkF3IzW+VypJ0bP0DRQE14G7MlfkWdW85ELeNYRaqE
 HzumxxVodCikKmgr8Vfr2dB2sJBHqutcLWCiFBIDW+bQke0GgQ==
X-Google-Smtp-Source: AGHT+IFslq083g7CG1afin9rupcEzD9eZTvY4EtNfDd77lOy2exbbXC0WvAiYlnuVOnwJS+9zKW2Sw==
X-Received: by 2002:a05:600c:1d8a:b0:43d:878c:7c40 with SMTP id
 5b1f17b1804b1-4406ab937demr31919145e9.10.1744985504368; 
 Fri, 18 Apr 2025 07:11:44 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1526:5ffd:d63c:cc85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcc3sm23734385e9.19.2025.04.18.07.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:11:43 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 14/17] cmd: add spawn and wait commands
Date: Fri, 18 Apr 2025 16:09:42 +0200
Message-ID: <20250418141114.2056981-15-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418141114.2056981-1-jerome.forissier@linaro.org>
References: <20250418141114.2056981-1-jerome.forissier@linaro.org>
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
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes in v6:
- Replace one invalid occurence of idx with i in do_wait()
- Fix badly formatted comment block

 cmd/Kconfig  |  17 +++++
 cmd/Makefile |   2 +
 cmd/spawn.c  | 187 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+)
 create mode 100644 cmd/spawn.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c2ce519d1e3..2d31abcef73 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -3081,4 +3081,21 @@ config CMD_MESON
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
index 8f0cee8d714..80cf70b7fe8 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -239,6 +239,8 @@ obj-$(CONFIG_CMD_SCP03) += scp03.o
 
 obj-$(CONFIG_HUSH_SELECTABLE) += cli.o
 
+obj-$(CONFIG_CMD_SPAWN) += spawn.o
+
 obj-$(CONFIG_ARM) += arm/
 obj-$(CONFIG_RISCV) += riscv/
 obj-$(CONFIG_SANDBOX) += sandbox/
diff --git a/cmd/spawn.c b/cmd/spawn.c
new file mode 100644
index 00000000000..eddbcb792b3
--- /dev/null
+++ b/cmd/spawn.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2011 The Chromium OS Authors.
+ */
+
+#include <command.h>
+#include <console.h>
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
+/* Return values of the commands run as jobs */
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
+	ret = uthread_create(NULL, spawn_thread, spa, 0, job[idx]);
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
+	int prev = disable_ctrlc(false);
+
+	while (!uthread_grp_done(job[idx])) {
+		if (ctrlc()) {
+			puts("<INTERRUPT>\n");
+			disable_ctrlc(prev);
+			return CMD_RET_FAILURE;
+		}
+		uthread_schedule();
+	}
+
+	job[idx] = 0;
+	disable_ctrlc(prev);
+
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
+			if (job[i])
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
-- 
2.43.0

