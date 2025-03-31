Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B45C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF6EA820B0;
	Mon, 31 Mar 2025 14:31:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WxLbw9ts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C77581F0D; Mon, 31 Mar 2025 14:31:56 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1678582045
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso31400065e9.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743424313; x=1744029113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2aLrWfKtfqnU92onvG84yCpeMIndD96SJj3KPZDlJ8E=;
 b=WxLbw9tsm5owP4pxK49oeMIA/Ls9c1/uZM7uXBuDNpXOlGv+kgHlkDyOlPziFyVd1f
 Oq/vc7BvcsUoVuOE/IyzV1d4uEb9Vkv5zI/3Hp1hlJyEB7Kpe/RJnkrNiM45UElZlBii
 0X73H/nVDUgtlmwbAZ9dA4N35xM/LWkBnwNp9QTzGAbfKOR2LUa229sTfAp9RjmQSVFt
 SkrzPP1W8c/zjFNZAhuFuf26ihQ3Ny6YX42sIDqWIxQqFo9WFHnLSoaDiDIy7Q0R2VJs
 G3tRYP6jW0A1TpF48UmeTtmYbcqLCjn455HN671gny2VbsBsRG8hjxtt+qCsgbONWFJI
 aVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743424313; x=1744029113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2aLrWfKtfqnU92onvG84yCpeMIndD96SJj3KPZDlJ8E=;
 b=tRGVfY6H9hOkTAzSYtxJFRDyKEDBktHPQziChcd3mCl8CK8seXfMnYyAVf8oowj7I2
 Ob+oUXQK4vSPNFd1jjKE9sBtaYdxkUFGb/BZpBl8sHjt2C/Pj7a2P+q5/VRoiEYJm2Ze
 /dFSiAXDvJzYP6c+N2m5vsS8ObUGmuDzDHTlmkAuz6mUHuWLKfy22xC2LXb8OdeFo6Gn
 da6Z+s05F5GFpHcPEmt6u8F3iFLOtItfsAmatsrAeIpPu2g1km3T+0EzOcWoN9ljIJvQ
 vUheyi/CUz2RpqtQtFkenU0D8+znEYam09Q6hDwfgZ+dNj8dfoqP2F3haTuD5b6GsD9m
 S4eA==
X-Gm-Message-State: AOJu0YyfQH35bHXSOw3ks4wDQD3Hup5pItuTTjwjkumnk146NIz61x5U
 DXRU5imlwgynFmWk0W1p5HL0gvaNnRFlLwfoUZQdv7tss2cg3cz3GZD4D/dhQMWnfg/rrFkj/ff
 Baf/+VQ==
X-Gm-Gg: ASbGncurXZ9d8Tn/qb1X5c/upFHOXdn1xXjMwZsgG3oYLRPxkNMIYgQnfWvr/2oqs/b
 9oom93kzcjnxLZqHF2ljKPEdf6/MktyNB8VAt/1W4iofH1UkrwVOg9prAmrTuoUWBBMDQSBTK/3
 2aVUn0x6N2iGeUwfHTc3KghwHch0a6N0OWqA0qiCAHP4ZVvm7UXIW5FwmLYgNan4YhQr/A8KDh4
 o+geV+dEzYeEA10z5nsDA8KraJIG+RG6am5KNn8SMsPIoyKMpwjKhKOT6uIH8AlFfMYp61VqB0O
 9guEbagpK7HJMMFDUFI+FOBgGwKsnlqZel+fJVab1XP18qZSyBJj
X-Google-Smtp-Source: AGHT+IHbcux5/dnjwth6TLmNYUJFHaePIYuRCwSTWN771+EupGz/OvesfSuGSymqoefgqoU+MYTLrw==
X-Received: by 2002:a05:600c:4eca:b0:43d:abd:ad0e with SMTP id
 5b1f17b1804b1-43db6249689mr84364745e9.18.1743424313366; 
 Mon, 31 Mar 2025 05:31:53 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f23c:25c9:dc74:be1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6589e4sm11337029f8f.10.2025.03.31.05.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:31:52 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v5 14/16] cmd: add spawn and wait commands
Date: Mon, 31 Mar 2025 14:31:08 +0200
Message-ID: <20250331123120.2025062-15-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331123120.2025062-1-jerome.forissier@linaro.org>
References: <20250331123120.2025062-1-jerome.forissier@linaro.org>
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
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
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
index 00000000000..5879fff5bbd
--- /dev/null
+++ b/cmd/spawn.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025, Linaro Ltd.
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

