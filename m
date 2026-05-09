Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E07CD37AC
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7686484E38;
	Sat,  9 May 2026 02:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="IP0i3JY0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE58284E10; Sat,  9 May 2026 02:04:55 +0200 (CEST)
Received: from mail-dl1-x122e.google.com (mail-dl1-x122e.google.com
 [IPv6:2607:f8b0:4864:20::122e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91BF584E02
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 02:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-13246950f3cso2617295c88.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 17:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778285089; x=1778889889;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sx9NICbsiHn/bnRMoIEsoWLvd8d/hf90nuL0/ybK97M=;
 b=IP0i3JY05s0VzurkCErvp0AeNvHqOEluHle93mleAJPnoGVkXLKtGSnGST9sDjDLNa
 Vkyn9mzIkEIUhjAflOXjXa6eVkAQrtAwYP+w+PpywdYNrpmHp6T8toNI6z5M9X5S2tMr
 NqiD5xJUQcjyBecWLm0yMzGPzv2o2ezAJ5jXW9WWgfKglE3y8IeHVWnxA44oocEf+8Zw
 xScWp7QWDqzE8KgAL4tITLlJU5TddlbUogvHR6SPM6Fa91sf0zWP98zFh/CKLQVcKWQX
 EPV/lTSJsq+W9/eO6RVYq3hcME+yvJn98mh0e2oPEIfKuX2TSoU6FSHn5N46viNnDwIn
 Sh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778285089; x=1778889889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sx9NICbsiHn/bnRMoIEsoWLvd8d/hf90nuL0/ybK97M=;
 b=GddMNq/g4bj/sn1j+Joi2JzzPrr1/2y0BvDi7bosItex7mEaHo2pOt0kSaEIKzQocs
 mZu1T80nhoVLDDW6CCwB+DPIrqLY8ZT9+WEZIMk0OplekTqpXNPmEZ2yRmUbJZaS5wq/
 70HNppNU5dNHAUee1BF7C86Q1/I5Rf/sy18EZIR6/MgpAr0js8GLAUVjpQ+MT9irftAt
 o6Y5LW3HCQD7jHtQ79ZB14rPViTXWLLsVIBf54rvSxCzhdkiM0gQJYXtkEvSesnaBsmn
 YnZNhv62zNHwM+cXXiyfuiDtDL0e/TO7M0D4XU5e/qxCCmDkMvU2WACrgBbEh7m/IhBe
 eugg==
X-Gm-Message-State: AOJu0YyEMxQ4nA9XeYDxXvbk+HVdLWSLgqMwfqB+MzYavXWwe5MsNGtT
 ZHdFKCORTjPMRbaOFAFEt3+I6cDt4nKsBURCuNCv8KOUKbNr3FaUgkBr7wEM2qbw4CxeDaJzY2R
 GT8qa
X-Gm-Gg: AeBDiev5/IsG+HYJ9IfjM4M6Tmvp0sBbA+ZwQESRmwRikWZsrT2In+4gt1W8ChZWDjJ
 lDZq10y6RVaOuhvctGAR6vJ06owIkXHdnoI0uGipRLif/rgpV3CMzZyXRqhcu/BbJ2R5kirYODO
 t64r6CIuMiZBtVfE+tvNYPOvr/37ybCFiI9ObQJIHAp2V0MmxI8bvHaKPrk+7V+xztkeah1uHQH
 xSnPF30LXDsUcyQpvWIJvOqpg8yDBsqQzRCUuIxacPjRbJpcEUrj6VwTUnHKBxdWf0Ncl4CV9aE
 QpqTZ9Xq8f6ztXn9o1Bo5eDfDsCssYWDqY6WQW3D46e6Ikn+X8Bld7cZxXeEq6IHKzADi65u2cm
 IgSYbm31KEdM0/2RmbLztMoFUGoAWlSvTS0oJhBsGeOpQY46VMEnu1KJkbIEdKXW12rbl7iwKd/
 sDu95l9qx/EXE6WHdU8u5cn1dfO65TXqJT+ZT/wZDxrofI8ATmQKGzVQd27PpgkSbh2T1PBc+Hv
 GtXGxadK4Ljj3SSrYtzOA==
X-Received: by 2002:a05:7022:222a:b0:12d:c039:6599 with SMTP id
 a92af1059eb24-132a81d8c9bmr275717c88.22.1778285088097; 
 Fri, 08 May 2026 17:04:48 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132787673ffsm5505030c88.15.2026.05.08.17.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 17:04:47 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: David Garske <david@wolfssl.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 08/12] cmd: refactor tpm2 command into frontend/backend
 architecture
Date: Fri,  8 May 2026 17:04:15 -0700
Message-ID: <94b785256db46e90c2c7f4b862c4686de37ea6e4.1778277334.git.aidan@wolfssl.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1778277334.git.aidan@wolfssl.com>
References: <cover.1778277334.git.aidan@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 May 2026 02:40:11 +0200
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

From: Aidan <aidan@wolfssl.com>

Split the tpm2 command implementation into a shared frontend and
two selectable backends. This allows wolfTPM to provide its own
TPM2 command implementations while keeping the command table,
dispatcher, and help text shared.

Architecture:

cmd/tpm-v2.c (frontend - always compiled):
  Contains the tpm2_commands[] table, get_tpm2_commands(), the
  do_tpm2() dispatcher, and the U_BOOT_CMD help text. References
  backend functions via cmd/tpm2-backend.h. When CONFIG_TPM_WOLF
  is enabled, additional wolfTPM-only commands (caps, pcr_print,
  firmware_update, firmware_cancel) are added to the table.

cmd/tpm2-backend.h (new):
  Declares all backend function prototypes that both backends must
  implement: do_tpm2_device, do_tpm2_info, do_tpm2_init,
  do_tpm2_startup, do_tpm2_selftest, do_tpm2_clear,
  do_tpm2_pcr_extend, do_tpm2_pcr_read, do_tpm2_get_capability,
  do_tpm2_dam_reset, do_tpm2_dam_parameters, do_tpm2_change_auth,
  do_tpm2_pcr_setauthpolicy, do_tpm2_pcr_setauthvalue,
  do_tpm2_pcr_allocate, plus wolfTPM-only functions.

cmd/native_tpm2.c (new - native backend):
  Contains the original tpm2 command implementations that use
  U-Boot's TPM driver model (tpm_api.h, tpm-v2.h). Compiled when
  CONFIG_TPM_WOLF is not set. Common commands delegate to
  tpm-common.c helpers (do_tpm_device, do_tpm_info, etc.).

cmd/wolftpm.c (new - wolfTPM backend):
  Implements all tpm2 commands using wolfTPM library APIs directly
  (wolfTPM2_Init, wolfTPM2_GetCapabilities, wolfTPM2_ExtendPCR,
  etc.). Includes Infineon-specific firmware update and cancel
  commands. Each command initializes its own WOLFTPM2_DEV instance
  rather than going through U-Boot's driver model.

cmd/Kconfig:
  Adds CMD_WOLFTPM option that selects TPM_WOLF and CMD_TPM_V2,
  providing a single menuconfig toggle for wolfTPM support.

cmd/Makefile:
  Conditionally compiles wolftpm.o (when CONFIG_TPM_WOLF=y) or
  native_tpm2.o (otherwise) alongside the shared tpm-v2.o frontend.
  Sets wolfTPM include paths and -DWOLFTPM_USER_SETTINGS.

The reason for separate backend files rather than a callback-based
approach is that wolfTPM uses fundamentally different types and
initialization patterns (WOLFTPM2_DEV vs struct udevice, direct
library calls vs driver model ops), making runtime dispatch
impractical without heavy abstraction.

Signed-off-by: Aidan Garske <aidan@wolfssl.com>
---
 cmd/Kconfig        |   11 +
 cmd/Makefile       |   10 +-
 cmd/native_tpm2.c  |  516 +++++++++++++++++++
 cmd/tpm-v2.c       |  559 +++------------------
 cmd/tpm2-backend.h |   66 +++
 cmd/wolftpm.c      | 1170 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 1840 insertions(+), 492 deletions(-)
 create mode 100644 cmd/native_tpm2.c
 create mode 100644 cmd/tpm2-backend.h
 create mode 100644 cmd/wolftpm.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index b71ac554c0b..fe9b3819eaa 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -3194,4 +3194,15 @@ config CMD_SPAWN_NUM_JOBS
 	  When a jobs exits, its identifier is available to be re-used by the next
 	  spawn command.
 
+config CMD_WOLFTPM
+	bool "Use wolfTPM as TPM2 backend"
+	depends on TPM_V2
+	select TPM_WOLF
+	select CMD_TPM_V2
+	help
+	  Use the wolfTPM library as the backend for TPM2 commands instead
+	  of the standard U-Boot TPM2 implementation. wolfTPM offers additional
+	  features including firmware update support for Infineon TPMs and
+	  enhanced capabilities reporting.
+
 endif
diff --git a/cmd/Makefile b/cmd/Makefile
index 4cd13d4fa6e..2b12b26e61f 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -191,9 +191,17 @@ obj-$(CONFIG_CMD_TIMER) += timer.o
 obj-$(CONFIG_CMD_TRACE) += trace.o
 obj-$(CONFIG_HUSH_PARSER) += test.o
 obj-$(CONFIG_CMD_TPM) += tpm-common.o
-obj-$(CONFIG_CMD_TPM_V1) += tpm-v1.o
 obj-$(CONFIG_CMD_TPM_TEST) += tpm_test.o
+obj-$(CONFIG_CMD_TPM_V1) += tpm-v1.o
 obj-$(CONFIG_CMD_TPM_V2) += tpm-v2.o
+ifeq ($(CONFIG_TPM_WOLF),y)
+ccflags-y += -I$(srctree)/lib/wolftpm \
+             -I$(srctree)/include/configs \
+             -DWOLFTPM_USER_SETTINGS
+obj-$(CONFIG_CMD_TPM_V2) += wolftpm.o
+else
+obj-$(CONFIG_CMD_TPM_V2) += native_tpm2.o
+endif
 obj-$(CONFIG_CMD_CROS_EC) += cros_ec.o
 obj-$(CONFIG_CMD_UBI) += ubi.o
 obj-$(CONFIG_CMD_UBIFS) += ubifs.o
diff --git a/cmd/native_tpm2.c b/cmd/native_tpm2.c
new file mode 100644
index 00000000000..d8dea956156
--- /dev/null
+++ b/cmd/native_tpm2.c
@@ -0,0 +1,516 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Native TPM2 backend implementation
+ *
+ * Copyright (c) 2018 Bootlin
+ * Author: Miquel Raynal <miquel.raynal@bootlin.com>
+ */
+
+#include <command.h>
+#include <dm.h>
+#include <log.h>
+#include <mapmem.h>
+#include <tpm-common.h>
+#include <tpm-v2.h>
+#include "tpm-user-utils.h"
+
+/* Wrappers for common commands - delegate to tpm-common.c */
+int do_tpm2_device(struct cmd_tbl *cmdtp, int flag, int argc,
+		   char *const argv[])
+{
+	return do_tpm_device(cmdtp, flag, argc, argv);
+}
+
+int do_tpm2_info(struct cmd_tbl *cmdtp, int flag, int argc,
+		 char *const argv[])
+{
+	return do_tpm_info(cmdtp, flag, argc, argv);
+}
+
+int do_tpm2_state(struct cmd_tbl *cmdtp, int flag, int argc,
+		  char *const argv[])
+{
+	return do_tpm_report_state(cmdtp, flag, argc, argv);
+}
+
+int do_tpm2_init(struct cmd_tbl *cmdtp, int flag, int argc,
+		 char *const argv[])
+{
+	return do_tpm_init(cmdtp, flag, argc, argv);
+}
+
+int do_tpm2_autostart(struct cmd_tbl *cmdtp, int flag, int argc,
+		      char *const argv[])
+{
+	return do_tpm_autostart(cmdtp, flag, argc, argv);
+}
+
+int do_tpm2_startup(struct cmd_tbl *cmdtp, int flag, int argc,
+		    char *const argv[])
+{
+	enum tpm2_startup_types mode;
+	struct udevice *dev;
+	int ret;
+	bool bon = true;
+
+	ret = get_tpm(&dev);
+	if (ret)
+		return ret;
+
+	/* argv[2] is optional to perform a TPM2_CC_SHUTDOWN */
+	if (argc > 3 || (argc == 3 && strcasecmp("off", argv[2])))
+		return CMD_RET_USAGE;
+
+	if (!strcasecmp("TPM2_SU_CLEAR", argv[1])) {
+		mode = TPM2_SU_CLEAR;
+	} else if (!strcasecmp("TPM2_SU_STATE", argv[1])) {
+		mode = TPM2_SU_STATE;
+	} else {
+		printf("Couldn't recognize mode string: %s\n", argv[1]);
+		return CMD_RET_FAILURE;
+	}
+
+	if (argv[2])
+		bon = false;
+
+	return report_return_code(tpm2_startup(dev, bon, mode));
+}
+
+int do_tpm2_selftest(struct cmd_tbl *cmdtp, int flag, int argc,
+		     char *const argv[])
+{
+	enum tpm2_yes_no full_test;
+	struct udevice *dev;
+	int ret;
+
+	ret = get_tpm(&dev);
+	if (ret)
+		return ret;
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	if (!strcasecmp("full", argv[1])) {
+		full_test = TPMI_YES;
+	} else if (!strcasecmp("continue", argv[1])) {
+		full_test = TPMI_NO;
+	} else {
+		printf("Couldn't recognize test mode: %s\n", argv[1]);
+		return CMD_RET_FAILURE;
+	}
+
+	return report_return_code(tpm2_self_test(dev, full_test));
+}
+
+int do_tpm2_clear(struct cmd_tbl *cmdtp, int flag, int argc,
+		  char *const argv[])
+{
+	u32 handle = 0;
+	const char *pw = (argc < 3) ? NULL : argv[2];
+	const ssize_t pw_sz = pw ? strlen(pw) : 0;
+	struct udevice *dev;
+	int ret;
+
+	ret = get_tpm(&dev);
+	if (ret)
+		return ret;
+
+	if (argc < 2 || argc > 3)
+		return CMD_RET_USAGE;
+
+	if (pw_sz > TPM2_DIGEST_LEN)
+		return -EINVAL;
+
+	if (!strcasecmp("TPM2_RH_LOCKOUT", argv[1]))
+		handle = TPM2_RH_LOCKOUT;
+	else if (!strcasecmp("TPM2_RH_PLATFORM", argv[1]))
+		handle = TPM2_RH_PLATFORM;
+	else
+		return CMD_RET_USAGE;
+
+	return report_return_code(tpm2_clear(dev, handle, pw, pw_sz));
+}
+
+int do_tpm2_pcr_extend(struct cmd_tbl *cmdtp, int flag, int argc,
+		       char *const argv[])
+{
+	struct udevice *dev;
+	struct tpm_chip_priv *priv;
+	u32 index = simple_strtoul(argv[1], NULL, 0);
+	void *digest = map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
+	int algo = TPM2_ALG_SHA256;
+	int algo_len;
+	int ret;
+	u32 rc;
+
+	if (argc < 3 || argc > 4)
+		return CMD_RET_USAGE;
+	if (argc == 4) {
+		algo = tpm2_name_to_algorithm(argv[3]);
+		if (algo == TPM2_ALG_INVAL)
+			return CMD_RET_FAILURE;
+	}
+	algo_len = tpm2_algorithm_to_len(algo);
+
+	ret = get_tpm(&dev);
+	if (ret)
+		return ret;
+
+	priv = dev_get_uclass_priv(dev);
+	if (!priv)
+		return -EINVAL;
+
+	if (index >= priv->pcr_count)
+		return -EINVAL;
+
+	rc = tpm2_pcr_extend(dev, index, algo, digest, algo_len);
+	if (!rc) {
+		printf("PCR #%u extended with %d byte %s digest\n", index,
+		       algo_len, tpm2_algorithm_name(algo));
+		print_byte_string(digest, algo_len);
+	}
+
+	unmap_sysmem(digest);
+
+	return report_return_code(rc);
+}
+
+int do_tpm2_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
+		     char *const argv[])
+{
+	enum tpm2_algorithms algo = TPM2_ALG_SHA256;
+	struct udevice *dev;
+	struct tpm_chip_priv *priv;
+	u32 index, rc;
+	int algo_len;
+	unsigned int updates;
+	void *data;
+	int ret;
+
+	if (argc < 3 || argc > 4)
+		return CMD_RET_USAGE;
+	if (argc == 4) {
+		algo = tpm2_name_to_algorithm(argv[3]);
+		if (algo == TPM2_ALG_INVAL)
+			return CMD_RET_FAILURE;
+	}
+	algo_len = tpm2_algorithm_to_len(algo);
+
+	ret = get_tpm(&dev);
+	if (ret)
+		return ret;
+
+	priv = dev_get_uclass_priv(dev);
+	if (!priv)
+		return -EINVAL;
+
+	index = simple_strtoul(argv[1], NULL, 0);
+	if (index >= priv->pcr_count)
+		return -EINVAL;
+
+	data = map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
+
+	rc = tpm2_pcr_read(dev, index, priv->pcr_select_min, algo,
+			   data, algo_len, &updates);
+	if (!rc) {
+		printf("PCR #%u %s %d byte content (%u known updates):\n", index,
+		       tpm2_algorithm_name(algo), algo_len, updates);
+		print_byte_string(data, algo_len);
+	}
+
+	unmap_sysmem(data);
+
+	return report_return_code(rc);
+}
+
+int do_tpm2_get_capability(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[])
+{
+	u32 capability, property, rc;
+	u8 *data;
+	size_t count;
+	int i, j;
+	struct udevice *dev;
+	int ret;
+
+	ret = get_tpm(&dev);
+	if (ret)
+		return ret;
+
+	if (argc != 5)
+		return CMD_RET_USAGE;
+
+	capability = simple_strtoul(argv[1], NULL, 0);
+	property = simple_strtoul(argv[2], NULL, 0);
+	data = map_sysmem(simple_strtoul(argv[3], NULL, 0), 0);
+	count = simple_strtoul(argv[4], NULL, 0);
+
+	rc = tpm2_get_capability(dev, capability, property, data, count);
+	if (rc)
+		goto unmap_data;
+
+	printf("Capabilities read from TPM:\n");
+	for (i = 0; i < count; i++) {
+		printf("Property 0x");
+		for (j = 0; j < 4; j++)
+			printf("%02x", data[(i * 8) + j + sizeof(u32)]);
+		printf(": 0x");
+		for (j = 4; j < 8; j++)
+			printf("%02x", data[(i * 8) + j + sizeof(u32)]);
+		printf("\n");
+	}
+
+unmap_data:
+	unmap_sysmem(data);
+
+	return report_return_code(rc);
+}
+
+static u32 select_mask(u32 mask, enum tpm2_algorithms algo, bool select)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
+		if (hash_algo_list[i].hash_alg != algo)
+			continue;
+
+		if (select)
+			mask |= hash_algo_list[i].hash_mask;
+		else
+			mask &= ~hash_algo_list[i].hash_mask;
+
+		break;
+	}
+
+	return mask;
+}
+
+static bool
+is_algo_in_pcrs(enum tpm2_algorithms algo, struct tpml_pcr_selection *pcrs)
+{
+	size_t i;
+
+	for (i = 0; i < pcrs->count; i++) {
+		if (algo == pcrs->selection[i].hash)
+			return true;
+	}
+
+	return false;
+}
+
+int do_tpm2_pcr_allocate(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[])
+{
+	struct udevice *dev;
+	int ret;
+	enum tpm2_algorithms algo;
+	const char *pw = (argc < 4) ? NULL : argv[3];
+	const ssize_t pw_sz = pw ? strlen(pw) : 0;
+	static struct tpml_pcr_selection pcr = { 0 };
+	u32 pcr_len = 0;
+	bool bon = false;
+	static u32 mask;
+	int i;
+
+	/* argv[1]: algorithm (bank), argv[2]: on/off */
+	if (argc < 3 || argc > 4)
+		return CMD_RET_USAGE;
+
+	if (!strcasecmp("on", argv[2]))
+		bon = true;
+	else if (strcasecmp("off", argv[2]))
+		return CMD_RET_USAGE;
+
+	algo = tpm2_name_to_algorithm(argv[1]);
+	if (algo == TPM2_ALG_INVAL)
+		return CMD_RET_USAGE;
+
+	ret = get_tpm(&dev);
+	if (ret)
+		return ret;
+
+	if (!pcr.count) {
+		/*
+		 * Get current active algorithms (banks), PCRs and mask via the
+		 * first call
+		 */
+		ret = tpm2_get_pcr_info(dev, &pcr);
+		if (ret)
+			return ret;
+
+		for (i = 0; i < pcr.count; i++) {
+			struct tpms_pcr_selection *sel = &pcr.selection[i];
+			const char *name;
+
+			if (!tpm2_is_active_bank(sel))
+				continue;
+
+			mask = select_mask(mask, sel->hash, true);
+			name = tpm2_algorithm_name(sel->hash);
+			if (name)
+				printf("Active bank[%d]: %s\n", i, name);
+		}
+	}
+
+	if (!is_algo_in_pcrs(algo, &pcr)) {
+		printf("%s is not supported by the tpm device\n", argv[1]);
+		return CMD_RET_USAGE;
+	}
+
+	mask = select_mask(mask, algo, bon);
+	ret = tpm2_pcr_config_algo(dev, mask, &pcr, &pcr_len);
+	if (ret)
+		return ret;
+
+	return report_return_code(tpm2_send_pcr_allocate(dev, pw, pw_sz, &pcr,
+							 pcr_len));
+}
+
+int do_tpm2_dam_reset(struct cmd_tbl *cmdtp, int flag, int argc,
+		      char *const argv[])
+{
+	const char *pw = (argc < 2) ? NULL : argv[1];
+	const ssize_t pw_sz = pw ? strlen(pw) : 0;
+	struct udevice *dev;
+	int ret;
+
+	ret = get_tpm(&dev);
+	if (ret)
+		return ret;
+
+	if (argc > 2)
+		return CMD_RET_USAGE;
+
+	if (pw_sz > TPM2_DIGEST_LEN)
+		return -EINVAL;
+
+	return report_return_code(tpm2_dam_reset(dev, pw, pw_sz));
+}
+
+int do_tpm2_dam_parameters(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[])
+{
+	const char *pw = (argc < 5) ? NULL : argv[4];
+	const ssize_t pw_sz = pw ? strlen(pw) : 0;
+	/*
+	 * No Dictionary Attack Mitigation (DAM) means:
+	 * maxtries = 0xFFFFFFFF, recovery_time = 1, lockout_recovery = 0
+	 */
+	unsigned long int max_tries;
+	unsigned long int recovery_time;
+	unsigned long int lockout_recovery;
+	struct udevice *dev;
+	int ret;
+
+	ret = get_tpm(&dev);
+	if (ret)
+		return ret;
+
+	if (argc < 4 || argc > 5)
+		return CMD_RET_USAGE;
+
+	if (pw_sz > TPM2_DIGEST_LEN)
+		return -EINVAL;
+
+	if (strict_strtoul(argv[1], 0, &max_tries))
+		return CMD_RET_USAGE;
+
+	if (strict_strtoul(argv[2], 0, &recovery_time))
+		return CMD_RET_USAGE;
+
+	if (strict_strtoul(argv[3], 0, &lockout_recovery))
+		return CMD_RET_USAGE;
+
+	log(LOGC_NONE, LOGL_INFO, "Changing dictionary attack parameters:\n");
+	log(LOGC_NONE, LOGL_INFO, "- maxTries: %lu", max_tries);
+	log(LOGC_NONE, LOGL_INFO, "- recoveryTime: %lu\n", recovery_time);
+	log(LOGC_NONE, LOGL_INFO, "- lockoutRecovery: %lu\n", lockout_recovery);
+
+	return report_return_code(tpm2_dam_parameters(dev, pw, pw_sz, max_tries,
+						      recovery_time,
+						      lockout_recovery));
+}
+
+int do_tpm2_change_auth(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	u32 handle;
+	const char *newpw = argv[2];
+	const char *oldpw = (argc == 3) ? NULL : argv[3];
+	const ssize_t newpw_sz = strlen(newpw);
+	const ssize_t oldpw_sz = oldpw ? strlen(oldpw) : 0;
+	struct udevice *dev;
+	int ret;
+
+	ret = get_tpm(&dev);
+	if (ret)
+		return ret;
+
+	if (argc < 3 || argc > 4)
+		return CMD_RET_USAGE;
+
+	if (newpw_sz > TPM2_DIGEST_LEN || oldpw_sz > TPM2_DIGEST_LEN)
+		return -EINVAL;
+
+	if (!strcasecmp("TPM2_RH_LOCKOUT", argv[1]))
+		handle = TPM2_RH_LOCKOUT;
+	else if (!strcasecmp("TPM2_RH_ENDORSEMENT", argv[1]))
+		handle = TPM2_RH_ENDORSEMENT;
+	else if (!strcasecmp("TPM2_RH_OWNER", argv[1]))
+		handle = TPM2_RH_OWNER;
+	else if (!strcasecmp("TPM2_RH_PLATFORM", argv[1]))
+		handle = TPM2_RH_PLATFORM;
+	else
+		return CMD_RET_USAGE;
+
+	return report_return_code(tpm2_change_auth(dev, handle, newpw, newpw_sz,
+						   oldpw, oldpw_sz));
+}
+
+int do_tpm2_pcr_setauthpolicy(struct cmd_tbl *cmdtp, int flag, int argc,
+			      char *const argv[])
+{
+	u32 index = simple_strtoul(argv[1], NULL, 0);
+	char *key = argv[2];
+	const char *pw = (argc < 4) ? NULL : argv[3];
+	const ssize_t pw_sz = pw ? strlen(pw) : 0;
+	struct udevice *dev;
+	int ret;
+
+	ret = get_tpm(&dev);
+	if (ret)
+		return ret;
+
+	if (strlen(key) != TPM2_DIGEST_LEN)
+		return -EINVAL;
+
+	if (argc < 3 || argc > 4)
+		return CMD_RET_USAGE;
+
+	return report_return_code(tpm2_pcr_setauthpolicy(dev, pw, pw_sz, index,
+							 key));
+}
+
+int do_tpm2_pcr_setauthvalue(struct cmd_tbl *cmdtp, int flag,
+			     int argc, char *const argv[])
+{
+	u32 index = simple_strtoul(argv[1], NULL, 0);
+	char *key = argv[2];
+	const ssize_t key_sz = strlen(key);
+	const char *pw = (argc < 4) ? NULL : argv[3];
+	const ssize_t pw_sz = pw ? strlen(pw) : 0;
+	struct udevice *dev;
+	int ret;
+
+	ret = get_tpm(&dev);
+	if (ret)
+		return ret;
+
+	if (strlen(key) != TPM2_DIGEST_LEN)
+		return -EINVAL;
+
+	if (argc < 3 || argc > 4)
+		return CMD_RET_USAGE;
+
+	return report_return_code(tpm2_pcr_setauthvalue(dev, pw, pw_sz, index,
+							key, key_sz));
+}
diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
index 847b2691581..a131a81d1a4 100644
--- a/cmd/tpm-v2.c
+++ b/cmd/tpm-v2.c
@@ -1,507 +1,51 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
+ * TPM2 command frontend - command table, dispatcher, and help text
+ *
+ * The actual command implementations are provided by the backend:
+ *   - native_tpm2.c: U-Boot native TPM2 APIs (driver model)
+ *   - wolftpm.c: wolfTPM library APIs
+ *
  * Copyright (c) 2018 Bootlin
  * Author: Miquel Raynal <miquel.raynal@bootlin.com>
  */
 
 #include <command.h>
-#include <dm.h>
-#include <log.h>
-#include <mapmem.h>
 #include <tpm-common.h>
-#include <tpm-v2.h>
-#include "tpm-user-utils.h"
-
-static int do_tpm2_startup(struct cmd_tbl *cmdtp, int flag, int argc,
-			   char *const argv[])
-{
-	enum tpm2_startup_types mode;
-	struct udevice *dev;
-	int ret;
-	bool bon = true;
-
-	ret = get_tpm(&dev);
-	if (ret)
-		return ret;
-
-	/* argv[2] is optional to perform a TPM2_CC_SHUTDOWN */
-	if (argc > 3 || (argc == 3 && strcasecmp("off", argv[2])))
-		return CMD_RET_USAGE;
-
-	if (!strcasecmp("TPM2_SU_CLEAR", argv[1])) {
-		mode = TPM2_SU_CLEAR;
-	} else if (!strcasecmp("TPM2_SU_STATE", argv[1])) {
-		mode = TPM2_SU_STATE;
-	} else {
-		printf("Couldn't recognize mode string: %s\n", argv[1]);
-		return CMD_RET_FAILURE;
-	}
-
-	if (argv[2])
-		bon = false;
-
-	return report_return_code(tpm2_startup(dev, bon, mode));
-}
-
-static int do_tpm2_self_test(struct cmd_tbl *cmdtp, int flag, int argc,
-			     char *const argv[])
-{
-	enum tpm2_yes_no full_test;
-	struct udevice *dev;
-	int ret;
-
-	ret = get_tpm(&dev);
-	if (ret)
-		return ret;
-	if (argc != 2)
-		return CMD_RET_USAGE;
-
-	if (!strcasecmp("full", argv[1])) {
-		full_test = TPMI_YES;
-	} else if (!strcasecmp("continue", argv[1])) {
-		full_test = TPMI_NO;
-	} else {
-		printf("Couldn't recognize test mode: %s\n", argv[1]);
-		return CMD_RET_FAILURE;
-	}
-
-	return report_return_code(tpm2_self_test(dev, full_test));
-}
-
-static int do_tpm2_clear(struct cmd_tbl *cmdtp, int flag, int argc,
-			 char *const argv[])
-{
-	u32 handle = 0;
-	const char *pw = (argc < 3) ? NULL : argv[2];
-	const ssize_t pw_sz = pw ? strlen(pw) : 0;
-	struct udevice *dev;
-	int ret;
-
-	ret = get_tpm(&dev);
-	if (ret)
-		return ret;
-
-	if (argc < 2 || argc > 3)
-		return CMD_RET_USAGE;
-
-	if (pw_sz > TPM2_DIGEST_LEN)
-		return -EINVAL;
-
-	if (!strcasecmp("TPM2_RH_LOCKOUT", argv[1]))
-		handle = TPM2_RH_LOCKOUT;
-	else if (!strcasecmp("TPM2_RH_PLATFORM", argv[1]))
-		handle = TPM2_RH_PLATFORM;
-	else
-		return CMD_RET_USAGE;
-
-	return report_return_code(tpm2_clear(dev, handle, pw, pw_sz));
-}
-
-static int do_tpm2_pcr_extend(struct cmd_tbl *cmdtp, int flag, int argc,
-			      char *const argv[])
-{
-	struct udevice *dev;
-	struct tpm_chip_priv *priv;
-	u32 index = simple_strtoul(argv[1], NULL, 0);
-	void *digest = map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
-	int algo = TPM2_ALG_SHA256;
-	int algo_len;
-	int ret;
-	u32 rc;
-
-	if (argc < 3 || argc > 4)
-		return CMD_RET_USAGE;
-	if (argc == 4) {
-		algo = tpm2_name_to_algorithm(argv[3]);
-		if (algo == TPM2_ALG_INVAL)
-			return CMD_RET_FAILURE;
-	}
-	algo_len = tpm2_algorithm_to_len(algo);
-
-	ret = get_tpm(&dev);
-	if (ret)
-		return ret;
-
-	priv = dev_get_uclass_priv(dev);
-	if (!priv)
-		return -EINVAL;
-
-	if (index >= priv->pcr_count)
-		return -EINVAL;
-
-	rc = tpm2_pcr_extend(dev, index, algo, digest, algo_len);
-	if (!rc) {
-		printf("PCR #%u extended with %d byte %s digest\n", index,
-		       algo_len, tpm2_algorithm_name(algo));
-		print_byte_string(digest, algo_len);
-	}
-
-	unmap_sysmem(digest);
-
-	return report_return_code(rc);
-}
-
-static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
-			   char *const argv[])
-{
-	enum tpm2_algorithms algo = TPM2_ALG_SHA256;
-	struct udevice *dev;
-	struct tpm_chip_priv *priv;
-	u32 index, rc;
-	int algo_len;
-	unsigned int updates;
-	void *data;
-	int ret;
-
-	if (argc < 3 || argc > 4)
-		return CMD_RET_USAGE;
-	if (argc == 4) {
-		algo = tpm2_name_to_algorithm(argv[3]);
-		if (algo == TPM2_ALG_INVAL)
-			return CMD_RET_FAILURE;
-	}
-	algo_len = tpm2_algorithm_to_len(algo);
-
-	ret = get_tpm(&dev);
-	if (ret)
-		return ret;
-
-	priv = dev_get_uclass_priv(dev);
-	if (!priv)
-		return -EINVAL;
-
-	index = simple_strtoul(argv[1], NULL, 0);
-	if (index >= priv->pcr_count)
-		return -EINVAL;
-
-	data = map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
-
-	rc = tpm2_pcr_read(dev, index, priv->pcr_select_min, algo,
-			   data, algo_len, &updates);
-	if (!rc) {
-		printf("PCR #%u %s %d byte content (%u known updates):\n", index,
-		       tpm2_algorithm_name(algo), algo_len, updates);
-		print_byte_string(data, algo_len);
-	}
-
-	unmap_sysmem(data);
-
-	return report_return_code(rc);
-}
-
-static int do_tpm_get_capability(struct cmd_tbl *cmdtp, int flag, int argc,
-				 char *const argv[])
-{
-	u32 capability, property, rc;
-	u8 *data;
-	size_t count;
-	int i, j;
-	struct udevice *dev;
-	int ret;
-
-	ret = get_tpm(&dev);
-	if (ret)
-		return ret;
-
-	if (argc != 5)
-		return CMD_RET_USAGE;
-
-	capability = simple_strtoul(argv[1], NULL, 0);
-	property = simple_strtoul(argv[2], NULL, 0);
-	data = map_sysmem(simple_strtoul(argv[3], NULL, 0), 0);
-	count = simple_strtoul(argv[4], NULL, 0);
-
-	rc = tpm2_get_capability(dev, capability, property, data, count);
-	if (rc)
-		goto unmap_data;
-
-	printf("Capabilities read from TPM:\n");
-	for (i = 0; i < count; i++) {
-		printf("Property 0x");
-		for (j = 0; j < 4; j++)
-			printf("%02x", data[(i * 8) + j + sizeof(u32)]);
-		printf(": 0x");
-		for (j = 4; j < 8; j++)
-			printf("%02x", data[(i * 8) + j + sizeof(u32)]);
-		printf("\n");
-	}
-
-unmap_data:
-	unmap_sysmem(data);
-
-	return report_return_code(rc);
-}
-
-static u32 select_mask(u32 mask, enum tpm2_algorithms algo, bool select)
-{
-	size_t i;
-
-	for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
-		if (hash_algo_list[i].hash_alg != algo)
-			continue;
-
-		if (select)
-			mask |= hash_algo_list[i].hash_mask;
-		else
-			mask &= ~hash_algo_list[i].hash_mask;
-
-		break;
-	}
-
-	return mask;
-}
-
-static bool
-is_algo_in_pcrs(enum tpm2_algorithms algo, struct tpml_pcr_selection *pcrs)
-{
-	size_t i;
-
-	for (i = 0; i < pcrs->count; i++) {
-		if (algo == pcrs->selection[i].hash)
-			return true;
-	}
-
-	return false;
-}
-
-static int do_tpm2_pcrallocate(struct cmd_tbl *cmdtp, int flag, int argc,
-			       char *const argv[])
-{
-	struct udevice *dev;
-	int ret;
-	enum tpm2_algorithms algo;
-	const char *pw = (argc < 4) ? NULL : argv[3];
-	const ssize_t pw_sz = pw ? strlen(pw) : 0;
-	static struct tpml_pcr_selection pcr = { 0 };
-	u32 pcr_len = 0;
-	bool bon = false;
-	static u32 mask;
-	int i;
-
-	/* argv[1]: algorithm (bank), argv[2]: on/off */
-	if (argc < 3 || argc > 4)
-		return CMD_RET_USAGE;
-
-	if (!strcasecmp("on", argv[2]))
-		bon = true;
-	else if (strcasecmp("off", argv[2]))
-		return CMD_RET_USAGE;
-
-	algo = tpm2_name_to_algorithm(argv[1]);
-	if (algo == TPM2_ALG_INVAL)
-		return CMD_RET_USAGE;
-
-	ret = get_tpm(&dev);
-	if (ret)
-		return ret;
-
-	if (!pcr.count) {
-		/*
-		 * Get current active algorithms (banks), PCRs and mask via the
-		 * first call
-		 */
-		ret = tpm2_get_pcr_info(dev, &pcr);
-		if (ret)
-			return ret;
-
-		for (i = 0; i < pcr.count; i++) {
-			struct tpms_pcr_selection *sel = &pcr.selection[i];
-			const char *name;
-
-			if (!tpm2_is_active_bank(sel))
-				continue;
-
-			mask = select_mask(mask, sel->hash, true);
-			name = tpm2_algorithm_name(sel->hash);
-			if (name)
-				printf("Active bank[%d]: %s\n", i, name);
-		}
-	}
-
-	if (!is_algo_in_pcrs(algo, &pcr)) {
-		printf("%s is not supported by the tpm device\n", argv[1]);
-		return CMD_RET_USAGE;
-	}
-
-	mask = select_mask(mask, algo, bon);
-	ret = tpm2_pcr_config_algo(dev, mask, &pcr, &pcr_len);
-	if (ret)
-		return ret;
-
-	return report_return_code(tpm2_send_pcr_allocate(dev, pw, pw_sz, &pcr,
-							 pcr_len));
-}
-
-static int do_tpm_dam_reset(struct cmd_tbl *cmdtp, int flag, int argc,
-			    char *const argv[])
-{
-	const char *pw = (argc < 2) ? NULL : argv[1];
-	const ssize_t pw_sz = pw ? strlen(pw) : 0;
-	struct udevice *dev;
-	int ret;
-
-	ret = get_tpm(&dev);
-	if (ret)
-		return ret;
-
-	if (argc > 2)
-		return CMD_RET_USAGE;
-
-	if (pw_sz > TPM2_DIGEST_LEN)
-		return -EINVAL;
-
-	return report_return_code(tpm2_dam_reset(dev, pw, pw_sz));
-}
-
-static int do_tpm_dam_parameters(struct cmd_tbl *cmdtp, int flag, int argc,
-				 char *const argv[])
-{
-	const char *pw = (argc < 5) ? NULL : argv[4];
-	const ssize_t pw_sz = pw ? strlen(pw) : 0;
-	/*
-	 * No Dictionary Attack Mitigation (DAM) means:
-	 * maxtries = 0xFFFFFFFF, recovery_time = 1, lockout_recovery = 0
-	 */
-	unsigned long int max_tries;
-	unsigned long int recovery_time;
-	unsigned long int lockout_recovery;
-	struct udevice *dev;
-	int ret;
-
-	ret = get_tpm(&dev);
-	if (ret)
-		return ret;
-
-	if (argc < 4 || argc > 5)
-		return CMD_RET_USAGE;
-
-	if (pw_sz > TPM2_DIGEST_LEN)
-		return -EINVAL;
-
-	if (strict_strtoul(argv[1], 0, &max_tries))
-		return CMD_RET_USAGE;
-
-	if (strict_strtoul(argv[2], 0, &recovery_time))
-		return CMD_RET_USAGE;
-
-	if (strict_strtoul(argv[3], 0, &lockout_recovery))
-		return CMD_RET_USAGE;
-
-	log(LOGC_NONE, LOGL_INFO, "Changing dictionary attack parameters:\n");
-	log(LOGC_NONE, LOGL_INFO, "- maxTries: %lu", max_tries);
-	log(LOGC_NONE, LOGL_INFO, "- recoveryTime: %lu\n", recovery_time);
-	log(LOGC_NONE, LOGL_INFO, "- lockoutRecovery: %lu\n", lockout_recovery);
-
-	return report_return_code(tpm2_dam_parameters(dev, pw, pw_sz, max_tries,
-						      recovery_time,
-						      lockout_recovery));
-}
-
-static int do_tpm_change_auth(struct cmd_tbl *cmdtp, int flag, int argc,
-			      char *const argv[])
-{
-	u32 handle;
-	const char *newpw = argv[2];
-	const char *oldpw = (argc == 3) ? NULL : argv[3];
-	const ssize_t newpw_sz = strlen(newpw);
-	const ssize_t oldpw_sz = oldpw ? strlen(oldpw) : 0;
-	struct udevice *dev;
-	int ret;
-
-	ret = get_tpm(&dev);
-	if (ret)
-		return ret;
-
-	if (argc < 3 || argc > 4)
-		return CMD_RET_USAGE;
-
-	if (newpw_sz > TPM2_DIGEST_LEN || oldpw_sz > TPM2_DIGEST_LEN)
-		return -EINVAL;
-
-	if (!strcasecmp("TPM2_RH_LOCKOUT", argv[1]))
-		handle = TPM2_RH_LOCKOUT;
-	else if (!strcasecmp("TPM2_RH_ENDORSEMENT", argv[1]))
-		handle = TPM2_RH_ENDORSEMENT;
-	else if (!strcasecmp("TPM2_RH_OWNER", argv[1]))
-		handle = TPM2_RH_OWNER;
-	else if (!strcasecmp("TPM2_RH_PLATFORM", argv[1]))
-		handle = TPM2_RH_PLATFORM;
-	else
-		return CMD_RET_USAGE;
-
-	return report_return_code(tpm2_change_auth(dev, handle, newpw, newpw_sz,
-						   oldpw, oldpw_sz));
-}
-
-static int do_tpm_pcr_setauthpolicy(struct cmd_tbl *cmdtp, int flag, int argc,
-				    char *const argv[])
-{
-	u32 index = simple_strtoul(argv[1], NULL, 0);
-	char *key = argv[2];
-	const char *pw = (argc < 4) ? NULL : argv[3];
-	const ssize_t pw_sz = pw ? strlen(pw) : 0;
-	struct udevice *dev;
-	int ret;
-
-	ret = get_tpm(&dev);
-	if (ret)
-		return ret;
-
-	if (strlen(key) != TPM2_DIGEST_LEN)
-		return -EINVAL;
-
-	if (argc < 3 || argc > 4)
-		return CMD_RET_USAGE;
-
-	return report_return_code(tpm2_pcr_setauthpolicy(dev, pw, pw_sz, index,
-							 key));
-}
-
-static int do_tpm_pcr_setauthvalue(struct cmd_tbl *cmdtp, int flag,
-				   int argc, char *const argv[])
-{
-	u32 index = simple_strtoul(argv[1], NULL, 0);
-	char *key = argv[2];
-	const ssize_t key_sz = strlen(key);
-	const char *pw = (argc < 4) ? NULL : argv[3];
-	const ssize_t pw_sz = pw ? strlen(pw) : 0;
-	struct udevice *dev;
-	int ret;
-
-	ret = get_tpm(&dev);
-	if (ret)
-		return ret;
-
-	if (strlen(key) != TPM2_DIGEST_LEN)
-		return -EINVAL;
-
-	if (argc < 3 || argc > 4)
-		return CMD_RET_USAGE;
-
-	return report_return_code(tpm2_pcr_setauthvalue(dev, pw, pw_sz, index,
-							key, key_sz));
-}
+#include "tpm2-backend.h"
 
 static struct cmd_tbl tpm2_commands[] = {
-	U_BOOT_CMD_MKENT(device, 0, 1, do_tpm_device, "", ""),
-	U_BOOT_CMD_MKENT(info, 0, 1, do_tpm_info, "", ""),
-	U_BOOT_CMD_MKENT(state, 0, 1, do_tpm_report_state, "", ""),
-	U_BOOT_CMD_MKENT(init, 0, 1, do_tpm_init, "", ""),
+	U_BOOT_CMD_MKENT(device, 0, 1, do_tpm2_device, "", ""),
+	U_BOOT_CMD_MKENT(info, 0, 1, do_tpm2_info, "", ""),
+	U_BOOT_CMD_MKENT(state, 0, 1, do_tpm2_state, "", ""),
+	U_BOOT_CMD_MKENT(init, 0, 1, do_tpm2_init, "", ""),
+	U_BOOT_CMD_MKENT(autostart, 0, 1, do_tpm2_autostart, "", ""),
 	U_BOOT_CMD_MKENT(startup, 0, 1, do_tpm2_startup, "", ""),
-	U_BOOT_CMD_MKENT(self_test, 0, 1, do_tpm2_self_test, "", ""),
+	U_BOOT_CMD_MKENT(self_test, 0, 1, do_tpm2_selftest, "", ""),
 	U_BOOT_CMD_MKENT(clear, 0, 1, do_tpm2_clear, "", ""),
 	U_BOOT_CMD_MKENT(pcr_extend, 0, 1, do_tpm2_pcr_extend, "", ""),
-	U_BOOT_CMD_MKENT(pcr_read, 0, 1, do_tpm_pcr_read, "", ""),
-	U_BOOT_CMD_MKENT(get_capability, 0, 1, do_tpm_get_capability, "", ""),
-	U_BOOT_CMD_MKENT(dam_reset, 0, 1, do_tpm_dam_reset, "", ""),
-	U_BOOT_CMD_MKENT(dam_parameters, 0, 1, do_tpm_dam_parameters, "", ""),
-	U_BOOT_CMD_MKENT(change_auth, 0, 1, do_tpm_change_auth, "", ""),
-	U_BOOT_CMD_MKENT(autostart, 0, 1, do_tpm_autostart, "", ""),
+	U_BOOT_CMD_MKENT(pcr_read, 0, 1, do_tpm2_pcr_read, "", ""),
+	U_BOOT_CMD_MKENT(get_capability, 0, 1, do_tpm2_get_capability, "", ""),
+	U_BOOT_CMD_MKENT(dam_reset, 0, 1, do_tpm2_dam_reset, "", ""),
+	U_BOOT_CMD_MKENT(dam_parameters, 0, 1, do_tpm2_dam_parameters, "", ""),
+	U_BOOT_CMD_MKENT(change_auth, 0, 1, do_tpm2_change_auth, "", ""),
 	U_BOOT_CMD_MKENT(pcr_setauthpolicy, 0, 1,
-			 do_tpm_pcr_setauthpolicy, "", ""),
+			 do_tpm2_pcr_setauthpolicy, "", ""),
 	U_BOOT_CMD_MKENT(pcr_setauthvalue, 0, 1,
-			 do_tpm_pcr_setauthvalue, "", ""),
-	U_BOOT_CMD_MKENT(pcr_allocate, 0, 1, do_tpm2_pcrallocate, "", ""),
+			 do_tpm2_pcr_setauthvalue, "", ""),
+	U_BOOT_CMD_MKENT(pcr_allocate, 0, 1, do_tpm2_pcr_allocate, "", ""),
+#ifdef CONFIG_TPM_WOLF
+	U_BOOT_CMD_MKENT(caps, 0, 1, do_tpm2_caps, "", ""),
+	U_BOOT_CMD_MKENT(pcr_print, 0, 1, do_tpm2_pcr_print, "", ""),
+#ifdef WOLFTPM_FIRMWARE_UPGRADE
+#if defined(WOLFTPM_SLB9672) || defined(WOLFTPM_SLB9673)
+	U_BOOT_CMD_MKENT(firmware_update, 0, 1,
+			 do_tpm2_firmware_update, "", ""),
+	U_BOOT_CMD_MKENT(firmware_cancel, 0, 1,
+			 do_tpm2_firmware_cancel, "", ""),
+#endif /* WOLFTPM_SLB9672 || WOLFTPM_SLB9673 */
+#endif /* WOLFTPM_FIRMWARE_UPGRADE */
+#endif /* CONFIG_TPM_WOLF */
 };
 
 struct cmd_tbl *get_tpm2_commands(unsigned int *size)
@@ -511,7 +55,22 @@ struct cmd_tbl *get_tpm2_commands(unsigned int *size)
 	return tpm2_commands;
 }
 
-U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
+static int do_tpm2(struct cmd_tbl *cmdtp, int flag, int argc,
+		   char *const argv[])
+{
+	struct cmd_tbl *cmd;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	cmd = find_cmd_tbl(argv[1], tpm2_commands, ARRAY_SIZE(tpm2_commands));
+	if (!cmd)
+		return CMD_RET_USAGE;
+
+	return cmd->cmd(cmdtp, flag, argc - 1, argv + 1);
+}
+
+U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm2, "Issue a TPMv2.x command",
 "<command> [<arguments>]\n"
 "\n"
 "device [num device]\n"
@@ -521,7 +80,7 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
 "state\n"
 "    Show internal state from the TPM (if available)\n"
 "autostart\n"
-"    Initalize the tpm, perform a Startup(clear) and run a full selftest\n"
+"    Initialize the tpm, perform a Startup(clear) and run a full selftest\n"
 "    sequence\n"
 "init\n"
 "    Initialize the software stack. Always the first command to issue.\n"
@@ -573,6 +132,10 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
 "    <password>: optional password of the LOCKOUT hierarchy\n"
 "change_auth <hierarchy> <new_pw> [<old_pw>]\n"
 "    <hierarchy>: the hierarchy\n"
+"        * TPM2_RH_LOCKOUT\n"
+"        * TPM2_RH_ENDORSEMENT\n"
+"        * TPM2_RH_OWNER\n"
+"        * TPM2_RH_PLATFORM\n"
 "    <new_pw>: new password for <hierarchy>\n"
 "    <old_pw>: optional previous password of <hierarchy>\n"
 "pcr_setauthpolicy|pcr_setauthvalue <pcr> <key> [<password>]\n"
@@ -596,4 +159,18 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
 "        * off - Clear all available PCRs associated with the specified\n"
 "                algorithm (bank)\n"
 "    <password>: optional password\n"
+#ifdef CONFIG_TPM_WOLF
+"caps\n"
+"    Show TPM capabilities and info\n"
+"pcr_print\n"
+"    Prints the current PCR state\n"
+#ifdef WOLFTPM_FIRMWARE_UPGRADE
+#if defined(WOLFTPM_SLB9672) || defined(WOLFTPM_SLB9673)
+"firmware_update <manifest_addr> <manifest_sz> <firmware_addr> <firmware_sz>\n"
+"    Update TPM firmware\n"
+"firmware_cancel\n"
+"    Cancel TPM firmware update\n"
+#endif /* WOLFTPM_SLB9672 || WOLFTPM_SLB9673 */
+#endif /* WOLFTPM_FIRMWARE_UPGRADE */
+#endif /* CONFIG_TPM_WOLF */
 );
diff --git a/cmd/tpm2-backend.h b/cmd/tpm2-backend.h
new file mode 100644
index 00000000000..39e9a3a6b7b
--- /dev/null
+++ b/cmd/tpm2-backend.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * TPM2 backend function declarations
+ *
+ * Each backend (native_tpm2.c or wolftpm.c) implements these functions.
+ * The frontend (tpm-v2.c) references them in the command table.
+ */
+
+#ifndef __TPM2_BACKEND_H
+#define __TPM2_BACKEND_H
+
+#include <command.h>
+
+/* Common TPM2 command handlers - both backends must implement these */
+int do_tpm2_device(struct cmd_tbl *cmdtp, int flag, int argc,
+		   char *const argv[]);
+int do_tpm2_info(struct cmd_tbl *cmdtp, int flag, int argc,
+		 char *const argv[]);
+int do_tpm2_state(struct cmd_tbl *cmdtp, int flag, int argc,
+		  char *const argv[]);
+int do_tpm2_init(struct cmd_tbl *cmdtp, int flag, int argc,
+		 char *const argv[]);
+int do_tpm2_autostart(struct cmd_tbl *cmdtp, int flag, int argc,
+		      char *const argv[]);
+int do_tpm2_startup(struct cmd_tbl *cmdtp, int flag, int argc,
+		    char *const argv[]);
+int do_tpm2_selftest(struct cmd_tbl *cmdtp, int flag, int argc,
+		     char *const argv[]);
+int do_tpm2_clear(struct cmd_tbl *cmdtp, int flag, int argc,
+		  char *const argv[]);
+int do_tpm2_pcr_extend(struct cmd_tbl *cmdtp, int flag, int argc,
+		       char *const argv[]);
+int do_tpm2_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
+		     char *const argv[]);
+int do_tpm2_get_capability(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[]);
+int do_tpm2_dam_reset(struct cmd_tbl *cmdtp, int flag, int argc,
+		      char *const argv[]);
+int do_tpm2_dam_parameters(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[]);
+int do_tpm2_change_auth(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[]);
+int do_tpm2_pcr_setauthpolicy(struct cmd_tbl *cmdtp, int flag, int argc,
+			      char *const argv[]);
+int do_tpm2_pcr_setauthvalue(struct cmd_tbl *cmdtp, int flag, int argc,
+			     char *const argv[]);
+int do_tpm2_pcr_allocate(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[]);
+
+/* wolfTPM-only command handlers */
+#ifdef CONFIG_TPM_WOLF
+int do_tpm2_caps(struct cmd_tbl *cmdtp, int flag, int argc,
+		 char *const argv[]);
+int do_tpm2_pcr_print(struct cmd_tbl *cmdtp, int flag, int argc,
+		      char *const argv[]);
+#ifdef WOLFTPM_FIRMWARE_UPGRADE
+#if defined(WOLFTPM_SLB9672) || defined(WOLFTPM_SLB9673)
+int do_tpm2_firmware_update(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char *const argv[]);
+int do_tpm2_firmware_cancel(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char *const argv[]);
+#endif /* WOLFTPM_SLB9672 || WOLFTPM_SLB9673 */
+#endif /* WOLFTPM_FIRMWARE_UPGRADE */
+#endif /* CONFIG_TPM_WOLF */
+
+#endif /* __TPM2_BACKEND_H */
diff --git a/cmd/wolftpm.c b/cmd/wolftpm.c
new file mode 100644
index 00000000000..06ea8d47c8a
--- /dev/null
+++ b/cmd/wolftpm.c
@@ -0,0 +1,1170 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * TPM2 command implementation using wolfTPM library
+ *
+ * Copyright (C) 2025 wolfSSL Inc.
+ * Author: Aidan Garske <aidan@wolfssl.com>
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <wolftpm/tpm2.h>
+#include <wolftpm/tpm2_wrap.h>
+#include <wolftpm/tpm2_packet.h>
+#include <wolftpm.h>
+
+#include <stdio.h>
+#include <hash.h>
+#ifndef WOLFTPM2_NO_WRAPPER
+
+#include <hal/tpm_io.h>
+#include <examples/wrap/wrap_test.h>
+
+/* U-boot specific includes */
+#include <command.h>
+#include <tpm-common.h>
+#include <vsprintf.h>
+#include <mapmem.h>
+#include <errno.h>
+#include <log.h>
+#include <string.h>
+
+/* Firmware update info structure for Infineon TPM */
+#ifdef WOLFTPM_FIRMWARE_UPGRADE
+#if defined(WOLFTPM_SLB9672) || defined(WOLFTPM_SLB9673)
+struct fw_info {
+	byte *manifest_buf;
+	byte *firmware_buf;
+	size_t manifest_bufSz;
+	size_t firmware_bufSz;
+};
+#endif
+#endif
+
+/******************************************************************************/
+/* --- BEGIN Common Commands -- */
+/******************************************************************************/
+
+int do_tpm2_device(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	WOLFTPM2_DEV dev;
+	WOLFTPM2_CAPS caps;
+	int rc;
+
+	/* Expected 1 arg only in native SPI mode (no device switching) */
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	/* Try to initialize and get device info */
+	rc = wolfTPM2_Init(&dev, TPM2_IoCb, NULL);
+	if (!rc) {
+		rc = wolfTPM2_GetCapabilities(&dev, &caps);
+		if (!rc) {
+			printf("TPM Device 0: %s (%s) FW=%d.%d\n",
+				   caps.mfgStr, caps.vendorStr,
+				   caps.fwVerMajor, caps.fwVerMinor);
+		}
+		wolfTPM2_Cleanup(&dev);
+	}
+
+	if (rc != 0) {
+		printf("No TPM device found (rc=%d: %s)\n", rc, TPM2_GetRCString(rc));
+		return CMD_RET_FAILURE;
+	}
+
+	return 0;
+}
+
+int do_tpm2_info(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	WOLFTPM2_DEV dev;
+	WOLFTPM2_CAPS caps;
+	int rc;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	/* Init the TPM2 device */
+	rc = wolfTPM2_Init(&dev, TPM2_IoCb, NULL);
+	if (!rc) {
+		rc = wolfTPM2_GetCapabilities(&dev, &caps);
+		if (!rc) {
+			printf("TPM 2.0: %s (%s)\n", caps.mfgStr, caps.vendorStr);
+			printf("  Firmware: %d.%d (0x%08X)\n",
+				   caps.fwVerMajor, caps.fwVerMinor, caps.fwVerVendor);
+			printf("  Type: 0x%08X\n", caps.tpmType);
+		}
+		wolfTPM2_Cleanup(&dev);
+	}
+
+	if (rc != 0) {
+		printf("Couldn't get TPM info (rc=%d: %s)\n", rc, TPM2_GetRCString(rc));
+		return CMD_RET_FAILURE;
+	}
+
+	log_debug("tpm2 info: rc = %d (%s)\n", rc, TPM2_GetRCString(rc));
+	return 0;
+}
+
+int do_tpm2_state(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	WOLFTPM2_DEV dev;
+	WOLFTPM2_CAPS caps;
+	int rc;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	/* Init the TPM2 device */
+	rc = wolfTPM2_Init(&dev, TPM2_IoCb, NULL);
+	if (!rc) {
+		rc = wolfTPM2_GetCapabilities(&dev, &caps);
+		if (!rc) {
+			printf("TPM State:\n");
+			printf("  Manufacturer: %s\n", caps.mfgStr);
+			printf("  Vendor: %s\n", caps.vendorStr);
+			printf("  Firmware: %d.%d\n", caps.fwVerMajor, caps.fwVerMinor);
+#if defined(WOLFTPM_SLB9672) || defined(WOLFTPM_SLB9673)
+			printf("  Mode: Infineon SLB967x (Native SPI)\n");
+			printf("  OpMode: %d\n", caps.opMode);
+#else
+			printf("  Mode: Native wolfTPM SPI\n");
+#endif
+		}
+		wolfTPM2_Cleanup(&dev);
+	}
+
+	if (rc != 0) {
+		printf("Couldn't get TPM state (rc=%d: %s)\n", rc, TPM2_GetRCString(rc));
+		return CMD_RET_FAILURE;
+	}
+
+	log_debug("tpm2 state: rc = %d (%s)\n", rc, TPM2_GetRCString(rc));
+	return 0;
+}
+
+int do_tpm2_init(struct cmd_tbl *cmdtp, int flag, int argc,
+	char *const argv[])
+{
+	WOLFTPM2_DEV dev;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	/* Init the TPM2 device */
+	return TPM2_Init_Device(&dev, NULL);
+}
+
+int do_tpm2_autostart(struct cmd_tbl *cmdtp, int flag, int argc,
+	char *const argv[])
+{
+	int rc;
+	WOLFTPM2_DEV dev;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	/* Init the TPM2 device */
+	rc = TPM2_Init_Device(&dev, NULL);
+	if (rc != TPM_RC_SUCCESS)
+		return rc;
+
+	/* Perform a startup clear - doStartup=1: Just starts up the TPM */
+	rc = wolfTPM2_Reset(&dev, 0, 1);
+	/* TPM_RC_INITIALIZE means already started - treat as success */
+	if (rc == TPM_RC_INITIALIZE)
+		rc = TPM_RC_SUCCESS;
+	if (rc != TPM_RC_SUCCESS) {
+		log_debug("wolfTPM2_Reset failed 0x%x: %s\n", rc,
+			TPM2_GetRCString(rc));
+		return rc;
+	}
+
+	/* Perform a full self test */
+	rc = wolfTPM2_SelfTest(&dev);
+	if (rc != TPM_RC_SUCCESS)
+		log_debug("wolfTPM2_SelfTest failed 0x%x: %s\n", rc,
+			TPM2_GetRCString(rc));
+
+	log_debug("tpm2 autostart: rc = %d (%s)\n", rc, TPM2_GetRCString(rc));
+
+	return rc;
+}
+
+/******************************************************************************/
+/* --- END Common Commands -- */
+/******************************************************************************/
+
+/******************************************************************************/
+/* --- START TPM 2.0 Commands -- */
+/******************************************************************************/
+
+int do_tpm2_get_capability(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	GetCapability_In  in;
+	GetCapability_Out out;
+	u32 capability, property, rc;
+	u8 *data;
+	size_t count;
+	int i, j;
+
+	if (argc != 5)
+		return CMD_RET_USAGE;
+
+	capability = simple_strtoul(argv[1], NULL, 0);
+	property = simple_strtoul(argv[2], NULL, 0);
+	data = map_sysmem(simple_strtoul(argv[3], NULL, 0), 0);
+	count = simple_strtoul(argv[4], NULL, 0);
+
+	memset(&in, 0, sizeof(in));
+	memset(&out, 0, sizeof(out));
+	in.capability = capability;
+	in.property = property;
+	in.propertyCount = count;
+	rc = TPM2_GetCapability(&in, &out);
+	if (!rc) {
+		memcpy(data, &out.capabilityData.data, sizeof(out.capabilityData.data));
+
+		printf("Capabilities read from TPM:\n");
+		for (i = 0; i < count; i++) {
+			printf("Property 0x");
+			for (j = 0; j < 4; j++)
+				printf("%02x", data[(i * 8) + j + sizeof(u32)]);
+			printf(": 0x");
+			for (j = 4; j < 8; j++)
+				printf("%02x", data[(i * 8) + j + sizeof(u32)]);
+			printf("\n");
+		}
+	}
+
+	unmap_sysmem(data);
+
+	log_debug("tpm2 get_capability: rc = %d (%s)\n", rc, TPM2_GetRCString(rc));
+
+	return rc;
+}
+
+int do_tpm2_caps(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	int rc;
+	WOLFTPM2_DEV dev;
+	WOLFTPM2_CAPS caps;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	/* Init the TPM2 device */
+	rc = TPM2_Init_Device(&dev, NULL);
+	if (rc != TPM_RC_SUCCESS)
+		return rc;
+
+	rc = wolfTPM2_GetCapabilities(&dev, &caps);
+	if (rc != TPM_RC_SUCCESS)
+		goto cleanup;
+
+	log_debug("Mfg %s (%d), Vendor %s, Fw %u.%u (0x%x), "
+		"FIPS 140-2 %d, CC-EAL4 %d\n",
+		caps.mfgStr, caps.mfg, caps.vendorStr, caps.fwVerMajor,
+		caps.fwVerMinor, caps.fwVerVendor, caps.fips140_2, caps.cc_eal4);
+#if defined(WOLFTPM_SLB9672) || defined(WOLFTPM_SLB9673)
+	log_debug("Operational mode: %s (0x%x)\n",
+		TPM2_IFX_GetOpModeStr(caps.opMode), caps.opMode);
+	log_debug("KeyGroupId 0x%x, FwCounter %d (%d same)\n",
+		caps.keyGroupId, caps.fwCounter, caps.fwCounterSame);
+#endif
+
+	/* List the active persistent handles */
+	rc = wolfTPM2_GetHandles(PERSISTENT_FIRST, NULL);
+	if (rc >= TPM_RC_SUCCESS)
+		log_debug("Found %d persistent handles\n", rc);
+
+	/* Print the available PCR's */
+	rc = TPM2_PCRs_Print();
+
+cleanup:
+	/* Only doShutdown=1: Just shut down the TPM */
+	wolfTPM2_Reset(&dev, 1, 0);
+	wolfTPM2_Cleanup(&dev);
+
+	log_debug("tpm2 caps: rc = %d (%s)\n", rc, TPM2_GetRCString(rc));
+
+	return rc;
+}
+
+#ifdef WOLFTPM_FIRMWARE_UPGRADE
+#if defined(WOLFTPM_SLB9672) || defined(WOLFTPM_SLB9673)
+int do_tpm2_firmware_update(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	int rc;
+	WOLFTPM2_DEV dev;
+	WOLFTPM2_CAPS caps;
+	struct fw_info fwinfo;
+	ulong manifest_addr, firmware_addr;
+	size_t manifest_sz, firmware_sz;
+	uint8_t manifest_hash[TPM_SHA384_DIGEST_SIZE];
+	int recovery = 0;
+
+	memset(&fwinfo, 0, sizeof(fwinfo));
+
+	/* Need 5 args: command + 4 arguments */
+	if (argc != 5) {
+		log_debug("Error: Expected 5 arguments but got %d\n", argc);
+		return CMD_RET_USAGE;
+	}
+	printf("TPM2 Firmware Update\n");
+
+	/* Convert all arguments from strings to numbers */
+	manifest_addr = simple_strtoul(argv[1], NULL, 0);
+	manifest_sz = simple_strtoul(argv[2], NULL, 0);
+	firmware_addr = simple_strtoul(argv[3], NULL, 0);
+	firmware_sz = simple_strtoul(argv[4], NULL, 0);
+
+	/* Map the memory addresses */
+	fwinfo.manifest_buf = map_sysmem(manifest_addr, manifest_sz);
+	fwinfo.firmware_buf = map_sysmem(firmware_addr, firmware_sz);
+	fwinfo.manifest_bufSz = manifest_sz;
+	fwinfo.firmware_bufSz = firmware_sz;
+
+	if (fwinfo.manifest_buf == NULL || fwinfo.firmware_buf == NULL) {
+		log_debug("Error: Invalid memory addresses\n");
+		return CMD_RET_FAILURE;
+	}
+
+	printf("Infineon Firmware Update Tool\n");
+	printf("\tManifest Address: 0x%lx (size: %zu)\n",
+		manifest_addr, manifest_sz);
+	printf("\tFirmware Address: 0x%lx (size: %zu)\n",
+		firmware_addr, firmware_sz);
+
+	rc = TPM2_Init_Device(&dev, NULL);
+	if (rc != TPM_RC_SUCCESS)
+		goto fw_cleanup;
+
+	rc = wolfTPM2_GetCapabilities(&dev, &caps);
+	if (rc != TPM_RC_SUCCESS)
+		goto fw_cleanup;
+
+	TPM2_IFX_PrintInfo(&caps);
+	if (caps.keyGroupId == 0)
+		log_debug("Error getting key group id from TPM!\n");
+	if (caps.opMode == 0x02 || (caps.opMode & 0x80))
+		recovery = 1;
+
+	if (recovery) {
+		printf("Firmware Update (recovery mode):\n");
+		rc = wolfTPM2_FirmwareUpgradeRecover(&dev,
+			fwinfo.manifest_buf, (uint32_t)fwinfo.manifest_bufSz,
+			TPM2_IFX_FwData_Cb, &fwinfo);
+	} else {
+		/* Normal mode - hash with wc_Sha384Hash */
+		printf("Firmware Update (normal mode):\n");
+		rc = wc_Sha384Hash(fwinfo.manifest_buf,
+			(uint32_t)fwinfo.manifest_bufSz, manifest_hash);
+		if (rc != TPM_RC_SUCCESS)
+			goto fw_cleanup;
+		rc = wolfTPM2_FirmwareUpgradeHash(&dev, TPM_ALG_SHA384,
+			manifest_hash, (uint32_t)sizeof(manifest_hash),
+			fwinfo.manifest_buf, (uint32_t)fwinfo.manifest_bufSz,
+			TPM2_IFX_FwData_Cb, &fwinfo);
+	}
+
+	if (!rc)
+		TPM2_IFX_PrintInfo(&caps);
+
+fw_cleanup:
+	if (fwinfo.manifest_buf)
+		unmap_sysmem(fwinfo.manifest_buf);
+	if (fwinfo.firmware_buf)
+		unmap_sysmem(fwinfo.firmware_buf);
+
+	if (rc != TPM_RC_SUCCESS)
+		log_debug("Infineon firmware update failed 0x%x: %s\n",
+			rc, TPM2_GetRCString(rc));
+
+	wolfTPM2_Cleanup(&dev);
+
+	log_debug("tpm2 firmware_update: rc=%d (%s)\n", rc, TPM2_GetRCString(rc));
+
+	return rc;
+}
+
+int do_tpm2_firmware_cancel(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	int rc;
+	WOLFTPM2_DEV dev;
+	uint8_t cmd[TPM2_HEADER_SIZE + 2];
+	uint16_t val16;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	/* Init the TPM2 device */
+	rc = TPM2_Init_Device(&dev, NULL);
+	if (rc == TPM_RC_SUCCESS) {
+		/* Setup command size in header */
+		val16 = TPM2_HEADER_SIZE + 2;
+		memcpy(cmd, &val16, sizeof(val16));
+		val16 = 0;
+		memcpy(&cmd[TPM2_HEADER_SIZE], &val16, sizeof(val16));
+
+		rc = TPM2_IFX_FieldUpgradeCommand(TPM_CC_FieldUpgradeAbandonVendor,
+			cmd, sizeof(cmd));
+		if (rc != TPM_RC_SUCCESS) {
+			log_debug("Firmware abandon failed 0x%x: %s\n",
+				rc, TPM2_GetRCString(rc));
+		}
+	}
+
+	wolfTPM2_Cleanup(&dev);
+
+	log_debug("tpm2 firmware_cancel: rc=%d (%s)\n", rc, TPM2_GetRCString(rc));
+
+	return rc;
+}
+#endif /* WOLFTPM_SLB9672 || WOLFTPM_SLB9673 */
+#endif /* WOLFTPM_FIRMWARE_UPGRADE */
+
+int do_tpm2_startup(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	int rc;
+	WOLFTPM2_DEV dev;
+	Startup_In startupIn;
+	Shutdown_In shutdownIn;
+	int doStartup = YES;
+
+	/* startup TPM2_SU_CLEAR|TPM2_SU_STATE [off] */
+	if (argc < 2 || argc > 3)
+		return CMD_RET_USAGE;
+	/* Check if shutdown requested */
+	if (argc == 3) {
+		if (strcmp(argv[2], "off") != 0)
+			return CMD_RET_USAGE;
+		doStartup = NO; /* shutdown */
+	}
+	printf("TPM2 Startup\n");
+
+	memset(&startupIn, 0, sizeof(startupIn));
+	memset(&shutdownIn, 0, sizeof(shutdownIn));
+
+	/* Init the TPM2 device */
+	rc = TPM2_Init_Device(&dev, NULL);
+	if (rc != TPM_RC_SUCCESS)
+		return rc;
+
+	if (!strcmp(argv[1], "TPM2_SU_CLEAR")) {
+		if (doStartup == YES)
+			startupIn.startupType = TPM_SU_CLEAR;
+		else
+			shutdownIn.shutdownType = TPM_SU_CLEAR;
+	} else if (!strcmp(argv[1], "TPM2_SU_STATE")) {
+		if (doStartup == YES)
+			startupIn.startupType = TPM_SU_STATE;
+		else
+			shutdownIn.shutdownType = TPM_SU_STATE;
+	} else {
+		log_debug("Couldn't recognize mode string: %s\n", argv[1]);
+		wolfTPM2_Cleanup(&dev);
+		return CMD_RET_FAILURE;
+	}
+
+	/* startup */
+	if (doStartup == YES) {
+		rc = TPM2_Startup(&startupIn);
+		/* TPM_RC_INITIALIZE = Already started */
+		if (rc != TPM_RC_SUCCESS && rc != TPM_RC_INITIALIZE) {
+			log_debug("TPM2 Startup: Result = 0x%x (%s)\n", rc,
+				TPM2_GetRCString(rc));
+		}
+	/* shutdown */
+	} else {
+		rc = TPM2_Shutdown(&shutdownIn);
+		if (rc != TPM_RC_SUCCESS) {
+			log_debug("TPM2 Shutdown: Result = 0x%x (%s)\n", rc,
+				TPM2_GetRCString(rc));
+		}
+	}
+
+	wolfTPM2_Cleanup(&dev);
+
+	if (rc >= 0)
+		rc = 0;
+
+	log_debug("tpm2 startup (%s): rc = %d (%s)\n",
+		doStartup ? "startup" : "shutdown", rc, TPM2_GetRCString(rc));
+
+	return rc;
+}
+
+int do_tpm2_selftest(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	int rc;
+	WOLFTPM2_DEV dev;
+	TPMI_YES_NO fullTest = YES;
+
+	/* Need 2 arg: command + type */
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	/* Init the TPM2 device */
+	rc = TPM2_Init_Device(&dev, NULL);
+	if (rc == TPM_RC_SUCCESS) {
+		if (!strcmp(argv[1], "full")) {
+			fullTest = YES;
+		} else if (!strcmp(argv[1], "continue")) {
+			fullTest = NO;
+		} else {
+			log_debug("Couldn't recognize test mode: %s\n", argv[1]);
+			wolfTPM2_Cleanup(&dev);
+			return CMD_RET_FAILURE;
+		}
+
+		/* full test */
+		if (fullTest == YES) {
+			rc = wolfTPM2_SelfTest(&dev);
+			if (rc != TPM_RC_SUCCESS) {
+				log_debug("TPM2 Self Test: Result = 0x%x (%s)\n", rc,
+					TPM2_GetRCString(rc));
+			}
+		/* continue test */
+		} else {
+			rc = wolfTPM2_SelfTest(&dev);
+			if (rc != TPM_RC_SUCCESS) {
+				log_debug("TPM2 Self Test: Result = 0x%x (%s)\n", rc,
+					TPM2_GetRCString(rc));
+			}
+		}
+	}
+
+	wolfTPM2_Cleanup(&dev);
+
+	log_debug("tpm2 selftest (%s): rc = %d (%s)\n",
+		fullTest ? "full" : "continue", rc, TPM2_GetRCString(rc));
+
+	return rc;
+}
+
+int do_tpm2_clear(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	int rc;
+	WOLFTPM2_DEV dev;
+	Clear_In clearIn;
+	TPMI_RH_CLEAR handle;
+
+	/* Need 2 arg: command + type */
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	if (!strcasecmp("TPM2_RH_LOCKOUT", argv[1]))
+		handle = TPM_RH_LOCKOUT;
+	else if (!strcasecmp("TPM2_RH_PLATFORM", argv[1]))
+		handle = TPM_RH_PLATFORM;
+	else
+		return CMD_RET_USAGE;
+
+	/* Init the TPM2 device */
+	rc = TPM2_Init_Device(&dev, NULL);
+	if (rc == TPM_RC_SUCCESS) {
+		/* Set up clear */
+		memset(&clearIn, 0, sizeof(clearIn));
+		clearIn.authHandle = handle;
+
+		rc = TPM2_Clear(&clearIn);
+		if (rc != TPM_RC_SUCCESS) {
+			log_debug("TPM2 Clear: Result = 0x%x (%s)\n", rc,
+				TPM2_GetRCString(rc));
+		}
+	}
+
+	wolfTPM2_Cleanup(&dev);
+
+	log_debug("tpm2 clear (%s): rc = %d (%s)\n",
+		handle == TPM_RH_LOCKOUT ? "TPM2_RH_LOCKOUT" : "TPM2_RH_PLATFORM",
+		rc, TPM2_GetRCString(rc));
+
+	return rc;
+}
+
+int do_tpm2_pcr_extend(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	int rc;
+	WOLFTPM2_DEV dev;
+	uint32_t pcrIndex;
+	int algo = TPM_ALG_SHA256;
+	int digestLen;
+	void *digest;
+	ulong digest_addr;
+
+	/* Need 3-4 args: command + pcr + digest_addr + [algo] */
+	if (argc < 3 || argc > 4)
+		return CMD_RET_USAGE;
+	printf("TPM2 PCR Extend\n");
+
+	pcrIndex = simple_strtoul(argv[1], NULL, 0);
+	digest_addr = simple_strtoul(argv[2], NULL, 0);
+
+	/* Optional algorithm */
+	if (argc == 4) {
+		algo = TPM2_GetAlgId(argv[3]);
+		if (algo < 0) {
+			log_debug("Couldn't recognize algorithm: %s\n", argv[3]);
+			return CMD_RET_FAILURE;
+		}
+		log_debug("Using algorithm: %s\n", TPM2_GetAlgName(algo));
+	}
+
+	/* Get digest length based on algorithm */
+	digestLen = TPM2_GetHashDigestSize(algo);
+	if (digestLen <= 0) {
+		log_debug("Invalid algorithm digest length\n");
+		return CMD_RET_FAILURE;
+	}
+
+	/* Map digest from memory address */
+	digest = map_sysmem(digest_addr, digestLen);
+	if (digest == NULL) {
+		log_debug("Error: Invalid digest memory address\n");
+		return CMD_RET_FAILURE;
+	}
+
+	log_debug("TPM2 PCR Extend: PCR %u with %s digest\n",
+		(unsigned int)pcrIndex, TPM2_GetAlgName(algo));
+
+	/* Init the TPM2 device */
+	rc = TPM2_Init_Device(&dev, NULL);
+	if (rc != TPM_RC_SUCCESS) {
+		unmap_sysmem(digest);
+		return rc;
+	}
+
+	/* Extend the PCR */
+	rc = wolfTPM2_ExtendPCR(&dev, pcrIndex, algo, digest, digestLen);
+	if (rc != TPM_RC_SUCCESS) {
+		log_debug("TPM2_PCR_Extend failed 0x%x: %s\n", rc,
+			TPM2_GetRCString(rc));
+	}
+
+	unmap_sysmem(digest);
+	wolfTPM2_Cleanup(&dev);
+
+	log_debug("tpm2 pcr_extend: rc = %d (%s)\n", rc, TPM2_GetRCString(rc));
+
+	return rc;
+}
+
+int do_tpm2_pcr_read(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	int rc;
+	WOLFTPM2_DEV dev;
+	uint32_t pcrIndex;
+	int algo = TPM_ALG_SHA256;
+	void *digest;
+	ulong digest_addr;
+	int digestLen;
+
+	/* Need 3-4 args: command + pcr + digest_addr + [algo] */
+	if (argc < 3 || argc > 4)
+		return CMD_RET_USAGE;
+
+	pcrIndex = simple_strtoul(argv[1], NULL, 0);
+	digest_addr = simple_strtoul(argv[2], NULL, 0);
+
+	/* Optional algorithm */
+	if (argc == 4) {
+		algo = TPM2_GetAlgId(argv[3]);
+		if (algo < 0) {
+			log_debug("Couldn't recognize algorithm: %s\n", argv[3]);
+			return CMD_RET_FAILURE;
+		}
+		log_debug("Using algorithm: %s\n", TPM2_GetAlgName(algo));
+	}
+
+	/* Get digest length based on algorithm */
+	digestLen = TPM2_GetHashDigestSize(algo);
+	if (digestLen <= 0) {
+		log_debug("Invalid algorithm digest length\n");
+		return CMD_RET_FAILURE;
+	}
+
+	/* Map digest from memory address */
+	digest = map_sysmem(digest_addr, digestLen);
+	if (digest == NULL) {
+		log_debug("Error: Invalid digest memory address\n");
+		return CMD_RET_FAILURE;
+	}
+
+	log_debug("TPM2 PCR Read: PCR %u to %s digest\n",
+		(unsigned int)pcrIndex, TPM2_GetAlgName(algo));
+
+	/* Init the TPM2 device */
+	rc = TPM2_Init_Device(&dev, NULL);
+	if (rc != TPM_RC_SUCCESS) {
+		unmap_sysmem(digest);
+		return rc;
+	}
+
+	/* Read the PCR */
+	rc = wolfTPM2_ReadPCR(&dev, pcrIndex, algo, digest, &digestLen);
+	if (rc != TPM_RC_SUCCESS) {
+		log_debug("TPM2_PCR_Read failed 0x%x: %s\n", rc,
+			TPM2_GetRCString(rc));
+	}
+
+	unmap_sysmem(digest);
+	wolfTPM2_Cleanup(&dev);
+
+	log_debug("tpm2 pcr_read: rc = %d (%s)\n", rc, TPM2_GetRCString(rc));
+
+	return rc;
+}
+
+int do_tpm2_pcr_allocate(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	int rc;
+	WOLFTPM2_DEV dev;
+	PCR_Allocate_In in;
+	PCR_Allocate_Out out;
+	TPM2B_AUTH auth;
+
+	/* Need 3-4 args: command + algorithm + on/off + [password] */
+	if (argc < 3 || argc > 4)
+		return CMD_RET_USAGE;
+
+	/* Init the TPM2 device */
+	rc = TPM2_Init_Device(&dev, NULL);
+	if (rc != TPM_RC_SUCCESS)
+		return rc;
+
+	/* Setup PCR Allocation command */
+	memset(&in, 0, sizeof(in));
+	in.authHandle = TPM_RH_PLATFORM;
+
+	/* Single PCR bank allocation */
+	in.pcrAllocation.count = 1; /* Change only one bank */
+	in.pcrAllocation.pcrSelections[0].hash = TPM2_GetAlgId(argv[1]);
+	in.pcrAllocation.pcrSelections[0].sizeofSelect = PCR_SELECT_MAX;
+
+	/* Set all PCRs for this algorithm */
+	if (!strcmp(argv[2], "on")) {
+		memset(in.pcrAllocation.pcrSelections[0].pcrSelect, 0xFF,
+			PCR_SELECT_MAX);
+	} else if (!strcmp(argv[2], "off")) {
+		/* Clear all PCRs for this algorithm */
+		memset(in.pcrAllocation.pcrSelections[0].pcrSelect, 0x00,
+			PCR_SELECT_MAX);
+	} else {
+		log_debug("Couldn't recognize allocate mode: %s\n", argv[2]);
+		wolfTPM2_Cleanup(&dev);
+		return CMD_RET_USAGE;
+	}
+	log_debug("Attempting to set %s bank to %s\n",
+		TPM2_GetAlgName(in.pcrAllocation.pcrSelections[0].hash),
+		argv[2]);
+
+	/* Set auth password if provided */
+	if (argc == 4) {
+		memset(&auth, 0, sizeof(auth));
+		auth.size = strlen(argv[3]);
+		memcpy(auth.buffer, argv[3], auth.size);
+		rc = wolfTPM2_SetAuth(&dev, 0, TPM_RH_PLATFORM, &auth, 0, NULL);
+		if (rc != TPM_RC_SUCCESS) {
+			log_debug("wolfTPM2_SetAuth failed 0x%x: %s\n", rc,
+				TPM2_GetRCString(rc));
+			wolfTPM2_Cleanup(&dev);
+			return rc;
+		}
+	}
+
+	/* Allocate the PCR */
+	rc = TPM2_PCR_Allocate(&in, &out);
+	if (rc != TPM_RC_SUCCESS) {
+		log_debug("TPM2_PCR_Allocate failed 0x%x: %s\n", rc,
+			TPM2_GetRCString(rc));
+	}
+
+	/* Print current PCR state */
+	printf("\n\tNOTE: A TPM restart is required for changes to take effect\n");
+	printf("\nCurrent PCR state:\n");
+	TPM2_PCRs_Print();
+
+	wolfTPM2_Cleanup(&dev);
+
+	printf("Allocation Success: %s\n",
+		out.allocationSuccess ? "YES" : "NO");
+	log_debug("tpm2 pcr_allocate %s (%s): rc = %d (%s)\n",
+		TPM2_GetAlgName(in.pcrAllocation.pcrSelections[0].hash),
+		argv[2], rc, TPM2_GetRCString(rc));
+
+	return rc;
+}
+
+/*
+ * Without wolfCrypt, parameter encryption is not available.
+ * A session is required to protect the new platform auth.
+ */
+#ifndef WOLFTPM2_NO_WOLFCRYPT
+static int TPM2_PCR_SetAuth(int argc, char *const argv[],
+	int isPolicy)
+{
+	int rc;
+	WOLFTPM2_DEV dev;
+	WOLFTPM2_SESSION session;
+	TPM2B_AUTH auth;
+	const char *pw = (argc < 4) ? NULL : argv[3];
+	const char *key = argv[2];
+	const ssize_t key_sz = strlen(key);
+	u32 pcrIndex = simple_strtoul(argv[1], NULL, 0);
+
+	/* Need 3-4 args: command + pcr + auth + [platform_auth] */
+	if (argc < 3 || argc > 4)
+		return CMD_RET_USAGE;
+
+	/* Init the TPM2 device for value/policy */
+	rc = TPM2_Init_Device(&dev, NULL);
+	if (rc != TPM_RC_SUCCESS)
+		return rc;
+
+	/* Start the session */
+	rc = wolfTPM2_StartSession(&dev, &session, NULL, NULL,
+		isPolicy ? TPM_SE_POLICY : TPM_SE_HMAC, TPM_ALG_NULL);
+	if (rc != TPM_RC_SUCCESS) {
+		log_debug("wolfTPM2_StartSession failed 0x%x: %s\n", rc,
+			TPM2_GetRCString(rc));
+		wolfTPM2_Cleanup(&dev);
+		return rc;
+	}
+
+	/* Set the platform auth if provided */
+	if (pw) {
+		TPM2B_AUTH platformAuth;
+
+		memset(&platformAuth, 0, sizeof(platformAuth));
+		platformAuth.size = strlen(pw);
+		memcpy(platformAuth.buffer, pw, platformAuth.size);
+		rc = wolfTPM2_SetAuth(&dev, 0, TPM_RH_PLATFORM,
+			&platformAuth, 0, NULL);
+		if (rc != TPM_RC_SUCCESS) {
+			log_debug("wolfTPM2_SetAuth failed 0x%x: %s\n", rc,
+				TPM2_GetRCString(rc));
+			wolfTPM2_UnloadHandle(&dev, &session.handle);
+			wolfTPM2_Cleanup(&dev);
+			return rc;
+		}
+	}
+
+	printf("Setting %s auth for PCR %u\n",
+		isPolicy ? "policy" : "value", pcrIndex);
+
+	/* Set up the auth value/policy */
+	memset(&auth, 0, sizeof(auth));
+	auth.size = key_sz;
+	memcpy(auth.buffer, key, key_sz);
+
+	if (isPolicy) {
+		/* Use TPM2_PCR_SetAuthPolicy command */
+		PCR_SetAuthPolicy_In in;
+
+		memset(&in, 0, sizeof(in));
+		in.authHandle = TPM_RH_PLATFORM;
+		in.authPolicy = auth;
+		in.hashAlg = TPM_ALG_SHA256; /* Default to SHA256 */
+		in.pcrNum = pcrIndex;
+		rc = TPM2_PCR_SetAuthPolicy(&in);
+	} else {
+		/* Use TPM2_PCR_SetAuthValue command */
+		PCR_SetAuthValue_In in;
+
+		memset(&in, 0, sizeof(in));
+		in.pcrHandle = pcrIndex;
+		in.auth = auth;
+		rc = TPM2_PCR_SetAuthValue(&in);
+	}
+
+	if (rc != TPM_RC_SUCCESS) {
+		log_debug("TPM2_PCR_SetAuth%s failed 0x%x: %s\n",
+			isPolicy ? "Policy" : "Value",
+			rc, TPM2_GetRCString(rc));
+	}
+
+	wolfTPM2_UnloadHandle(&dev, &session.handle);
+	wolfTPM2_Cleanup(&dev);
+
+	log_debug("tpm2 set_auth %s: rc = %d (%s)\n",
+		isPolicy ? "Policy" : "Value", rc, TPM2_GetRCString(rc));
+
+	return rc;
+}
+
+int do_tpm2_pcr_setauthpolicy(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	return TPM2_PCR_SetAuth(argc, argv, YES);
+}
+
+int do_tpm2_pcr_setauthvalue(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	return TPM2_PCR_SetAuth(argc, argv, NO);
+}
+
+int do_tpm2_change_auth(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	int rc;
+	WOLFTPM2_DEV dev;
+	WOLFTPM2_SESSION session;
+	const char *newpw = argv[2];
+	const char *oldpw = (argc == 4) ? argv[3] : NULL;
+	const ssize_t newpw_sz = strlen(newpw);
+	const ssize_t oldpw_sz = oldpw ? strlen(oldpw) : 0;
+	HierarchyChangeAuth_In in;
+	TPM2B_AUTH newAuth;
+
+	/* Need 3-4 args: command + hierarchy + new_pw + [old_pw] */
+	if (argc < 3 || argc > 4)
+		return CMD_RET_USAGE;
+
+	/* Init the TPM2 device */
+	rc = TPM2_Init_Device(&dev, NULL);
+	if (rc != TPM_RC_SUCCESS)
+		return rc;
+
+	memset(&in, 0, sizeof(in));
+
+	/* Set the handle */
+	if (!strcmp(argv[1], "TPM2_RH_LOCKOUT"))
+		in.authHandle = TPM_RH_LOCKOUT;
+	else if (!strcmp(argv[1], "TPM2_RH_ENDORSEMENT"))
+		in.authHandle = TPM_RH_ENDORSEMENT;
+	else if (!strcmp(argv[1], "TPM2_RH_OWNER"))
+		in.authHandle = TPM_RH_OWNER;
+	else if (!strcmp(argv[1], "TPM2_RH_PLATFORM"))
+		in.authHandle = TPM_RH_PLATFORM;
+	else {
+		wolfTPM2_Cleanup(&dev);
+		return CMD_RET_USAGE;
+	}
+
+	/* Validate password length if provided */
+	if (newpw_sz > TPM_SHA256_DIGEST_SIZE ||
+		oldpw_sz > TPM_SHA256_DIGEST_SIZE) {
+		wolfTPM2_Cleanup(&dev);
+		return -EINVAL;
+	}
+
+	/* Start auth session */
+	rc = wolfTPM2_StartSession(&dev, &session, NULL, NULL,
+		TPM_SE_HMAC, TPM_ALG_CFB);
+	if (rc != TPM_RC_SUCCESS) {
+		log_debug("wolfTPM2_StartSession failed 0x%x: %s\n", rc,
+			TPM2_GetRCString(rc));
+		wolfTPM2_Cleanup(&dev);
+		return rc;
+	}
+
+	/* If old password exists then set it as the current auth */
+	if (oldpw) {
+		TPM2B_AUTH oldAuth;
+
+		memset(&oldAuth, 0, sizeof(oldAuth));
+		oldAuth.size = oldpw_sz;
+		memcpy(oldAuth.buffer, oldpw, oldpw_sz);
+		rc = wolfTPM2_SetAuthPassword(&dev, 0, &oldAuth);
+		if (rc != TPM_RC_SUCCESS) {
+			log_debug("wolfTPM2_SetAuthPassword failed 0x%x: %s\n", rc,
+				TPM2_GetRCString(rc));
+			wolfTPM2_UnloadHandle(&dev, &session.handle);
+			wolfTPM2_Cleanup(&dev);
+			return rc;
+		}
+	}
+
+	memset(&newAuth, 0, sizeof(newAuth));
+	newAuth.size = newpw_sz;
+	memcpy(newAuth.buffer, newpw, newpw_sz);
+	in.newAuth = newAuth;
+
+	/* Change the auth based on the hierarchy */
+	rc = wolfTPM2_ChangeHierarchyAuth(&dev, &session, in.authHandle);
+	if (rc != TPM_RC_SUCCESS) {
+		log_debug("wolfTPM2_ChangeHierarchyAuth failed 0x%x: %s\n", rc,
+			TPM2_GetRCString(rc));
+	} else {
+		log_debug("Successfully changed auth for %s\n", argv[1]);
+	}
+
+	wolfTPM2_UnloadHandle(&dev, &session.handle);
+	wolfTPM2_Cleanup(&dev);
+
+	log_debug("tpm2 change_auth: rc = %d (%s)\n", rc, TPM2_GetRCString(rc));
+
+	return rc;
+}
+#else /* WOLFTPM2_NO_WOLFCRYPT */
+int do_tpm2_change_auth(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	printf("wolfCrypt support required for change_auth\n");
+	return CMD_RET_FAILURE;
+}
+
+int do_tpm2_pcr_setauthpolicy(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	printf("wolfCrypt support required for pcr_setauthpolicy\n");
+	return CMD_RET_FAILURE;
+}
+
+int do_tpm2_pcr_setauthvalue(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	printf("wolfCrypt support required for pcr_setauthvalue\n");
+	return CMD_RET_FAILURE;
+}
+#endif /* !WOLFTPM2_NO_WOLFCRYPT */
+
+int do_tpm2_pcr_print(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	int rc;
+	WOLFTPM2_DEV dev;
+
+	/* Need 1 arg: command */
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	/* Init the TPM2 device */
+	rc = TPM2_Init_Device(&dev, NULL);
+	if (rc == TPM_RC_SUCCESS) {
+		/* Print the current PCR state */
+		TPM2_PCRs_Print();
+	}
+	wolfTPM2_Cleanup(&dev);
+
+	log_debug("tpm2 pcr_print: rc = %d (%s)\n", rc, TPM2_GetRCString(rc));
+
+	return rc;
+}
+
+int do_tpm2_dam_reset(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	int rc;
+	WOLFTPM2_DEV dev;
+	const char *pw = (argc < 2) ? NULL : argv[1];
+	const ssize_t pw_sz = pw ? strlen(pw) : 0;
+	DictionaryAttackLockReset_In in;
+	TPM2_AUTH_SESSION session[MAX_SESSION_NUM];
+
+	/* Need 1-2 args: command + [password] */
+	if (argc > 2)
+		return CMD_RET_USAGE;
+
+	/* Validate password length if provided */
+	if (pw && pw_sz > TPM_SHA256_DIGEST_SIZE) {
+		log_debug("Error: Password too long\n");
+		return -EINVAL;
+	}
+
+	/* Init the TPM2 device */
+	rc = TPM2_Init_Device(&dev, NULL);
+	if (rc == TPM_RC_SUCCESS) {
+		/* set lock handle */
+		memset(&in, 0, sizeof(in));
+		in.lockHandle = TPM_RH_LOCKOUT;
+
+		/* Setup auth session only if password provided */
+		memset(session, 0, sizeof(session));
+		session[0].sessionHandle = TPM_RS_PW;
+		if (pw) {
+			session[0].auth.size = pw_sz;
+			memcpy(session[0].auth.buffer, pw, pw_sz);
+		}
+		TPM2_SetSessionAuth(session);
+
+		rc = TPM2_DictionaryAttackLockReset(&in);
+		log_debug("TPM2_Dam_Reset: Result = 0x%x (%s)\n", rc,
+			TPM2_GetRCString(rc));
+	}
+	wolfTPM2_Cleanup(&dev);
+
+	log_debug("tpm2 dam_reset: rc = %d (%s)\n", rc, TPM2_GetRCString(rc));
+
+	return rc;
+}
+
+int do_tpm2_dam_parameters(struct cmd_tbl *cmdtp, int flag,
+	int argc, char *const argv[])
+{
+	int rc;
+	WOLFTPM2_DEV dev;
+	const char *pw = (argc < 5) ? NULL : argv[4];
+	const ssize_t pw_sz = pw ? strlen(pw) : 0;
+	DictionaryAttackParameters_In in;
+	TPM2_AUTH_SESSION session[MAX_SESSION_NUM];
+
+	/*
+	 * Need 4-5 args: command + max_tries + recovery_time +
+	 * lockout_recovery + [password]
+	 */
+	if (argc < 4 || argc > 5)
+		return CMD_RET_USAGE;
+
+	/* Validate password length if provided */
+	if (pw && pw_sz > TPM_SHA256_DIGEST_SIZE) {
+		log_debug("Error: Password too long\n");
+		return -EINVAL;
+	}
+
+	/* Init the TPM2 device */
+	rc = TPM2_Init_Device(&dev, NULL);
+	if (rc == TPM_RC_SUCCESS) {
+		/* Set parameters */
+		memset(&in, 0, sizeof(in));
+		in.newMaxTries = simple_strtoul(argv[1], NULL, 0);
+		in.newRecoveryTime = simple_strtoul(argv[2], NULL, 0);
+		in.lockoutRecovery = simple_strtoul(argv[3], NULL, 0);
+
+		/* set lock handle */
+		in.lockHandle = TPM_RH_LOCKOUT;
+
+		/* Setup auth session only if password provided */
+		memset(session, 0, sizeof(session));
+		session[0].sessionHandle = TPM_RS_PW;
+		if (pw) {
+			session[0].auth.size = pw_sz;
+			memcpy(session[0].auth.buffer, pw, pw_sz);
+		}
+		TPM2_SetSessionAuth(session);
+
+		/* Set DAM parameters */
+		rc = TPM2_DictionaryAttackParameters(&in);
+		if (rc != TPM_RC_SUCCESS) {
+			log_debug("TPM2_DictionaryAttackParameters failed 0x%x: %s\n", rc,
+				TPM2_GetRCString(rc));
+		}
+
+		printf("Changing dictionary attack parameters:\n");
+		printf("  maxTries: %u\n", in.newMaxTries);
+		printf("  recoveryTime: %u\n", in.newRecoveryTime);
+		printf("  lockoutRecovery: %u\n", in.lockoutRecovery);
+	}
+	wolfTPM2_Cleanup(&dev);
+
+	log_debug("tpm2 dam_parameters: rc = %d (%s)\n", rc, TPM2_GetRCString(rc));
+
+	return rc;
+}
+
+#endif /* !WOLFTPM2_NO_WRAPPER */
-- 
2.47.3

