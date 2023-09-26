Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B64E7D241
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 07:00:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0CD886D4C;
	Tue, 26 Sep 2023 08:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZO8d3Ife";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EE8386C00; Tue, 26 Sep 2023 08:58:47 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9C0C86D65
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 08:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3ae4bd149d2so303245b6e.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 23:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695711523; x=1696316323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0FkoP3w1CPqPpr0ceh6OYlsga4yz8DeWrXbi96YnB0=;
 b=ZO8d3IfeLelxeM1dM7AGCIvmTV7xKepNr4cZ7HaDw32sK89Wi9CJNW0+ep4MZkG4Is
 kNEIcdU6yc7Who4BSXxuF/nuHAifus6XTGqYXCyv/DqXX7SXOnnOUoXzMtvh+aUJvTms
 t0dyy0JgLFSbuWJ8tDay81AE39uMNhOzjiF3CcwoVk8QdzUwNb0t7oVeloTZibVaj94I
 eQRQHk2nWI1Zvo/bKQ1HRddiYp36XQ6n2p5U2JpjuAjmYd3CcalNaZLCq06UW8F1veri
 1oZwTo5Pc85quO/qpRWoCmwr+dYho2GGTqj1YZBHLZsLLogT4c2nRcqPtNh+z6tSoPUR
 h5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695711523; x=1696316323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q0FkoP3w1CPqPpr0ceh6OYlsga4yz8DeWrXbi96YnB0=;
 b=ejmynjy+Ezwg4Nnibeudd1RQ8OhY/cAU6Zmrp9SV+NyF1yfRyuwaaHuRzlXZcyYegK
 Gh4SRKxgkiDu0tih921nPSTwZO5Li9YEaJE1AKiP/fgPlOhmu7RPMiEV7KqqxciXtzi0
 I63bP3k68mzrFrq7whCSr3nR5N/Y8AzThPTDDdbdy9q7kbXceA8ZXoVWdYh0ynH2iMtc
 OOfFVVzhEj6PPAfZpZaYOWMBF+diWQawsbxbdVUH7ygMdh33TTT2KY4Gb4kVb2jAkPJ/
 Vn4QhpBJf77cOsSBuXRU+P+L0ON67iJYJDnPIsOtQaxmi1mfplBig6Z9pnuWOox9ugmv
 R14Q==
X-Gm-Message-State: AOJu0YxCY5YAQpH6Eiy+rTejeZZI7yj/V9MmRXWzIc2IaHDjsLgHSc17
 9TW5PxGDzyCRMVdP+WRFL2fq/Q==
X-Google-Smtp-Source: AGHT+IGbQ/ehQUFGiGN6GWQf5wG1xoALJOyvi5AMjEvNcOk/ML5GdCZ074F6uXhRHhpVjp9hZd2Kmw==
X-Received: by 2002:a05:6870:3126:b0:1a7:f79c:2fbc with SMTP id
 v38-20020a056870312600b001a7f79c2fbcmr8157466oaa.0.1695711523166; 
 Mon, 25 Sep 2023 23:58:43 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:6585:aea6:5002:a825])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a639242000000b0057825bd3448sm8758874pgn.51.2023.09.25.23.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 23:58:42 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v5 14/16] cmd: add scmi command for SCMI firmware
Date: Tue, 26 Sep 2023 15:57:48 +0900
Message-Id: <20230926065750.734440-15-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926065750.734440-1-takahiro.akashi@linaro.org>
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
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

This command, "scmi", may provide a command line interface to various SCMI
protocols. It supports at least initially SCMI base protocol and is
intended mainly for debug purpose.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
v3
* describe that arguments are in hex at a help message
* modify the code for dynamically allocated agent names
v2
* remove sub command category, 'scmi base', for simplicity
---
 cmd/Kconfig  |   9 ++
 cmd/Makefile |   1 +
 cmd/scmi.c   | 337 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 347 insertions(+)
 create mode 100644 cmd/scmi.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 43ca10f69ccf..f46152ace7d8 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2533,6 +2533,15 @@ config CMD_CROS_EC
 	  a number of sub-commands for performing EC tasks such as
 	  updating its flash, accessing a small saved context area
 	  and talking to the I2C bus behind the EC (if there is one).
+
+config CMD_SCMI
+	bool "Enable scmi command"
+	depends on SCMI_FIRMWARE
+	default n
+	help
+	  This command provides user interfaces to several SCMI (System
+	  Control and Management Interface) protocols available on Arm
+	  platforms to manage system resources.
 endmenu
 
 menu "Filesystem commands"
diff --git a/cmd/Makefile b/cmd/Makefile
index 9bebf321c397..ad3810b17e93 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -158,6 +158,7 @@ obj-$(CONFIG_CMD_SATA) += sata.o
 obj-$(CONFIG_CMD_NVME) += nvme.o
 obj-$(CONFIG_SANDBOX) += sb.o
 obj-$(CONFIG_CMD_SF) += sf.o
+obj-$(CONFIG_CMD_SCMI) += scmi.o
 obj-$(CONFIG_CMD_SCSI) += scsi.o disk.o
 obj-$(CONFIG_CMD_SHA1SUM) += sha1sum.o
 obj-$(CONFIG_CMD_SEAMA) += seama.o
diff --git a/cmd/scmi.c b/cmd/scmi.c
new file mode 100644
index 000000000000..5efec8ad87fd
--- /dev/null
+++ b/cmd/scmi.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  SCMI (System Control and Management Interface) utility command
+ *
+ *  Copyright (c) 2023 Linaro Limited
+ *		Author: AKASHI Takahiro
+ */
+
+#include <common.h>
+#include <command.h>
+#include <exports.h>
+#include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
+#include <stdlib.h>
+#include <asm/types.h>
+#include <dm/device.h>
+#include <dm/uclass.h> /* uclass_get_device */
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+
+static struct udevice *agent;
+static struct udevice *base_proto;
+
+struct {
+	enum scmi_std_protocol id;
+	const char *name;
+} protocol_name[] = {
+	{SCMI_PROTOCOL_ID_BASE, "Base"},
+	{SCMI_PROTOCOL_ID_POWER_DOMAIN, "Power domain management"},
+	{SCMI_PROTOCOL_ID_SYSTEM, "System power management"},
+	{SCMI_PROTOCOL_ID_PERF, "Performance domain management"},
+	{SCMI_PROTOCOL_ID_CLOCK, "Clock management"},
+	{SCMI_PROTOCOL_ID_SENSOR, "Sensor management"},
+	{SCMI_PROTOCOL_ID_RESET_DOMAIN, "Reset domain management"},
+	{SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN, "Voltage domain management"},
+};
+
+/**
+ * get_proto_name() - get the name of SCMI protocol
+ *
+ * @id:		SCMI Protocol ID
+ *
+ * Get the printable name of the protocol, @id
+ *
+ * Return:	Name string on success, NULL on failure
+ */
+static const char *get_proto_name(enum scmi_std_protocol id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(protocol_name); i++)
+		if (id == protocol_name[i].id)
+			return protocol_name[i].name;
+
+	return NULL;
+}
+
+/**
+ * do_scmi_info() - get the information of SCMI services
+ *
+ * @cmdtp:	Command table
+ * @flag:	Command flag
+ * @argc:	Number of arguments
+ * @argv:	Argument array
+ *
+ * Get the information of SCMI services using various interfaces
+ * provided by the Base protocol.
+ *
+ * Return:	CMD_RET_SUCCESS on success, CMD_RET_RET_FAILURE on failure
+ */
+static int do_scmi_info(struct cmd_tbl *cmdtp, int flag, int argc,
+			char * const argv[])
+{
+	u32 agent_id, num_protocols;
+	u8 *agent_name, *protocols;
+	int i, ret;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	printf("SCMI device: %s\n", agent->name);
+	printf("  protocol version: 0x%x\n", scmi_version(agent));
+	printf("  # of agents: %d\n", scmi_num_agents(agent));
+	for (i = 0; i < scmi_num_agents(agent); i++) {
+		ret = scmi_base_discover_agent(base_proto, i, &agent_id,
+					       &agent_name);
+		if (ret) {
+			if (ret != -EOPNOTSUPP)
+				printf("base_discover_agent() failed for id: %d (%d)\n",
+				       i, ret);
+			break;
+		}
+		printf("    %c%2d: %s\n", i == scmi_agent_id(agent) ? '>' : ' ',
+		       i, agent_name);
+		free(agent_name);
+	}
+	printf("  # of protocols: %d\n", scmi_num_protocols(agent));
+	num_protocols = scmi_num_protocols(agent);
+	protocols = scmi_protocols(agent);
+	if (protocols)
+		for (i = 0; i < num_protocols; i++)
+			printf("      %s\n", get_proto_name(protocols[i]));
+	printf("  vendor: %s\n", scmi_vendor(agent));
+	printf("  sub vendor: %s\n", scmi_sub_vendor(agent));
+	printf("  impl version: 0x%x\n", scmi_impl_version(agent));
+
+	return CMD_RET_SUCCESS;
+}
+
+/**
+ * do_scmi_set_dev() - set access permission to device
+ *
+ * @cmdtp:	Command table
+ * @flag:	Command flag
+ * @argc:	Number of arguments
+ * @argv:	Argument array
+ *
+ * Set access permission to device with SCMI_BASE_SET_DEVICE_PERMISSIONS
+ *
+ * Return:	CMD_RET_SUCCESS on success, CMD_RET_RET_FAILURE on failure
+ */
+static int do_scmi_set_dev(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char * const argv[])
+{
+	u32 agent_id, device_id, flags, attributes;
+	char *end;
+	int ret;
+
+	if (argc != 4)
+		return CMD_RET_USAGE;
+
+	agent_id = simple_strtoul(argv[1], &end, 16);
+	if (*end != '\0')
+		return CMD_RET_USAGE;
+
+	device_id = simple_strtoul(argv[2], &end, 16);
+	if (*end != '\0')
+		return CMD_RET_USAGE;
+
+	flags = simple_strtoul(argv[3], &end, 16);
+	if (*end != '\0')
+		return CMD_RET_USAGE;
+
+	ret = scmi_base_protocol_message_attrs(base_proto,
+					       SCMI_BASE_SET_DEVICE_PERMISSIONS,
+					       &attributes);
+	if (ret) {
+		printf("This operation is not supported\n");
+		return CMD_RET_FAILURE;
+	}
+
+	ret = scmi_base_set_device_permissions(base_proto, agent_id,
+					       device_id, flags);
+	if (ret) {
+		printf("%s access to device:%u failed (%d)\n",
+		       flags ? "Allowing" : "Denying", device_id, ret);
+		return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+/**
+ * do_scmi_set_proto() - set protocol permission to device
+ *
+ * @cmdtp:	Command table
+ * @flag:	Command flag
+ * @argc:	Number of arguments
+ * @argv:	Argument array
+ *
+ * Set protocol permission to device with SCMI_BASE_SET_PROTOCOL_PERMISSIONS
+ *
+ * Return:	CMD_RET_SUCCESS on success, CMD_RET_RET_FAILURE on failure
+ */
+static int do_scmi_set_proto(struct cmd_tbl *cmdtp, int flag, int argc,
+			     char * const argv[])
+{
+	u32 agent_id, device_id, protocol_id, flags, attributes;
+	char *end;
+	int ret;
+
+	if (argc != 5)
+		return CMD_RET_USAGE;
+
+	agent_id = simple_strtoul(argv[1], &end, 16);
+	if (*end != '\0')
+		return CMD_RET_USAGE;
+
+	device_id = simple_strtoul(argv[2], &end, 16);
+	if (*end != '\0')
+		return CMD_RET_USAGE;
+
+	protocol_id = simple_strtoul(argv[3], &end, 16);
+	if (*end != '\0')
+		return CMD_RET_USAGE;
+
+	flags = simple_strtoul(argv[4], &end, 16);
+	if (*end != '\0')
+		return CMD_RET_USAGE;
+
+	ret = scmi_base_protocol_message_attrs(base_proto,
+					       SCMI_BASE_SET_PROTOCOL_PERMISSIONS,
+					       &attributes);
+	if (ret) {
+		printf("This operation is not supported\n");
+		return CMD_RET_FAILURE;
+	}
+
+	ret = scmi_base_set_protocol_permissions(base_proto, agent_id,
+						 device_id, protocol_id,
+						 flags);
+	if (ret) {
+		printf("%s access to protocol:0x%x on device:%u failed (%d)\n",
+		       flags ? "Allowing" : "Denying", protocol_id, device_id,
+		       ret);
+		return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+/**
+ * do_scmi_reset() - reset platform resource settings
+ *
+ * @cmdtp:	Command table
+ * @flag:	Command flag
+ * @argc:	Number of arguments
+ * @argv:	Argument array
+ *
+ * Reset platform resource settings with BASE_RESET_AGENT_CONFIGURATION
+ *
+ * Return:	CMD_RET_SUCCESS on success, CMD_RET_RET_FAILURE on failure
+ */
+static int do_scmi_reset(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char * const argv[])
+{
+	u32 agent_id, flags, attributes;
+	char *end;
+	int ret;
+
+	if (argc != 3)
+		return CMD_RET_USAGE;
+
+	agent_id = simple_strtoul(argv[1], &end, 16);
+	if (*end != '\0')
+		return CMD_RET_USAGE;
+
+	flags = simple_strtoul(argv[2], &end, 16);
+	if (*end != '\0')
+		return CMD_RET_USAGE;
+
+	ret = scmi_base_protocol_message_attrs(base_proto,
+					       SCMI_BASE_RESET_AGENT_CONFIGURATION,
+					       &attributes);
+	if (ret) {
+		printf("Reset is not supported\n");
+		return CMD_RET_FAILURE;
+	}
+
+	ret = scmi_base_reset_agent_configuration(base_proto, agent_id, flags);
+	if (ret) {
+		printf("Reset failed (%d)\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+static struct cmd_tbl cmd_scmi_sub[] = {
+	U_BOOT_CMD_MKENT(info, CONFIG_SYS_MAXARGS, 1,
+			 do_scmi_info, "", ""),
+	U_BOOT_CMD_MKENT(perm_dev, CONFIG_SYS_MAXARGS, 1,
+			 do_scmi_set_dev, "", ""),
+	U_BOOT_CMD_MKENT(perm_proto, CONFIG_SYS_MAXARGS, 1,
+			 do_scmi_set_proto, "", ""),
+	U_BOOT_CMD_MKENT(reset, CONFIG_SYS_MAXARGS, 1,
+			 do_scmi_reset, "", ""),
+};
+
+/**
+ * do_scmi() - SCMI utility
+ *
+ * @cmdtp:	Command table
+ * @flag:	Command flag
+ * @argc:	Number of arguments
+ * @argv:	Argument array
+ *
+ * Provide user interfaces to SCMI protocols.
+ *
+ * Return:	CMD_RET_SUCCESS on success,
+ *		CMD_RET_USAGE or CMD_RET_RET_FAILURE on failure
+ */
+static int do_scmi(struct cmd_tbl *cmdtp, int flag,
+		   int argc, char *const argv[])
+{
+	struct cmd_tbl *cp;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	argc--; argv++;
+
+	if (!agent) {
+		if (uclass_get_device(UCLASS_SCMI_AGENT, 0, &agent)) {
+			printf("Cannot find any SCMI agent\n");
+			return CMD_RET_FAILURE;
+		}
+	}
+
+	if (!base_proto)
+		base_proto = scmi_get_protocol(agent, SCMI_PROTOCOL_ID_BASE);
+	if (!base_proto) {
+		printf("SCMI base protocol not found\n");
+		return CMD_RET_FAILURE;
+	}
+
+	cp = find_cmd_tbl(argv[0], cmd_scmi_sub, ARRAY_SIZE(cmd_scmi_sub));
+	if (!cp)
+		return CMD_RET_USAGE;
+
+	return cp->cmd(cmdtp, flag, argc, argv);
+}
+
+static char scmi_help_text[] =
+	" - SCMI utility\n"
+	" info - get the info of SCMI services\n"
+	" perm_dev <agent-id in hex> <device-id in hex> <flags in hex>\n"
+	"   - set access permission to device\n"
+	" perm_proto <agent-id in hex> <device-id in hex> <protocol-id in hex>"
+	" <flags in hex>\n"
+	"   - set protocol permission to device\n"
+	" reset <agent-id in hex> <flags in hex>\n"
+	"   - reset platform resource settings\n"
+	"";
+
+U_BOOT_CMD(scmi, CONFIG_SYS_MAXARGS, 0, do_scmi, "SCMI utility",
+	   scmi_help_text);
-- 
2.34.1

