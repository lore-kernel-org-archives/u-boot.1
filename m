Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA98C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 10:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7004181D5D;
	Tue, 18 Mar 2025 11:47:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mTlabkeR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 275A9819AA; Tue, 18 Mar 2025 11:47:37 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08F3A81D0B
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 11:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so4678801f8f.1
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742294854; x=1742899654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2sekQU63kloVru5EHGh5HfRGGGGNQWsXJL/Sb3hAiTA=;
 b=mTlabkeRYM/en4JrYvTj7Ctx7GVzEP7NETGbg2R5WdBHb9r2DhEyA6kj0qBLZ1CrBg
 otEgwdYGOhzcPASvNHNk9LYiXeEvCDDOcavlLU6zbpCrtShys6uDvTc3trfXgu398mJl
 AGqGxMDB8+IuenCExI100SuZLyCKyh4c6JQ5RE81L/LlEiPOt0hgK+QRY7fyh+rj8wKb
 ijtb18R/bio4fCUCVpbV+QN1ftFXHhGk5N3geb3aEJNFRn0G+5MD21cevBtg23CRc4fP
 l3ZTs1wPTQmdUeeQlDOMb90jJlHAtpr/GGeP1Ows37b5T+nnVduHJ0XJt0lUHkkrCH/1
 hj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742294854; x=1742899654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2sekQU63kloVru5EHGh5HfRGGGGNQWsXJL/Sb3hAiTA=;
 b=Xbze2qJ8A6M72VJJK2lqDxQEk99UYlLkRhcVkZo9lHxbJoou2hlX+pEurViB0caGI6
 xKpqAAEzgC210o+c6byVvNCANZgBeTJILfKrCOQqrDuMlVHNkk+Dz5QlUWTmY1q0xP3B
 A9wyKRykiyliPttfTTZ4vd011nYPiiz+bRA9xcH4wYj0xHhx9K/wx0DLdepwuRsulW51
 +jnVpNvrn4DM6OyGK4kvaBa5t5i987MpPoCoBPRYlnJ2b7IwiGsCvR28X1u9/BsA0lt6
 6/VSzFIbmGA7HJHQnlfATtAMRF3mpr5xxRh8CPwl+x9Nzrdblt/DtLh1dOH4HhH83DV0
 8wgw==
X-Gm-Message-State: AOJu0Yzpk1ZZD9DIaAoErzT7nAMOk9blsONZ46zkkiHg5DJ4DKqyiKIy
 13Jo6RX7df3GFLNL2cSGcLjvbOccS4CJ34FpUY5vw3cIGWHIQz7x4EZ5m/NIanidhbgZqyYpK4o
 Vajg=
X-Gm-Gg: ASbGnctKDG5dcYz/ie1YXZv05W+WLtVkMcYpkxmfiAIARy3QmOzS7JnUDzTNKBwQp8q
 YaHCfmCL5xa+DrtPPWKf5rZbYNWFlgphYUe235R+5NUIl+9qitbslVF+B/AZn80JY66TtQY/heJ
 mgErM+p1aiAvqiIibSdGtNI6H/LHJ1tvnhl8RwLLxSExQE/ROtlBKhaRHEGgH7hTKkNPCCbhOlQ
 d/sbYt43nyui93IgHgJKIwI2cmZ+Dngbca3aCG1bdDmd2BswJhjnVz74Es7zmJNHgIh19liuYIl
 Rntc1DZMvazTJIAGWRx9h0QBhPGDjOemcnhX5zfW6MRt74QNOd750w==
X-Google-Smtp-Source: AGHT+IHefRkATaTjOMfBhRrT+q8NjRyaCCwQjgsgYLA1qNbcQohAga+5sMJBweu9p+I3tXUCD0ULMA==
X-Received: by 2002:a05:6000:1ace:b0:391:41c9:7a87 with SMTP id
 ffacd0b85a97d-3971fdc6db1mr17812194f8f.51.1742294854184; 
 Tue, 18 Mar 2025 03:47:34 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:78bd:2e7e:120c:26bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdda2dbsm131788185e9.2.2025.03.18.03.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 03:47:33 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v4 12/14] cmd: add spawn and wait commands
Date: Tue, 18 Mar 2025 11:46:48 +0100
Message-ID: <20250318104659.1114340-13-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318104659.1114340-1-jerome.forissier@linaro.org>
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
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
 cmd/Kconfig  |  17 +++++
 cmd/Makefile |   2 +
 cmd/spawn.c  | 188 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 207 insertions(+)
 create mode 100644 cmd/spawn.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index cd391d422ae..0cbb75edfbe 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -3079,4 +3079,21 @@ config CMD_MESON
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
index c1275d466c8..b61f6586157 100644
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
index 00000000000..f7a9f225f93
--- /dev/null
+++ b/cmd/spawn.c
@@ -0,0 +1,188 @@
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
-- 
2.43.0

