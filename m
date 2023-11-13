Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A79C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 01:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BE738709A;
	Mon, 13 Nov 2023 02:49:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HzRiqlLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B172386FF4; Mon, 13 Nov 2023 02:49:42 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B333886F7E
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 02:49:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3b2e08526b9so373662b6e.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 17:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699840176; x=1700444976; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oONLZU+k1c7pjdGca1S1UQvtxT+y3sBxYGld3kTp6Js=;
 b=HzRiqlLhg7+7bUSggOK02PeEYyAcVLFsxfc/+VvffBvANoLlsnPEX4G1JNZD4ovLUJ
 v5GqDjten5zCvS1D0LmItmCh3yN3PpRyHdk46uqVhq4kpHPHEto/srdRXwiVT/1gd1oo
 ovvKjmGWZH6mUFrRaZLkIgLFEFGY4KyrobwSNJ9qUMqUrQUe5HNZdna/SwSslmMqgl25
 tpoYtXx6dKQFrOp8gNfJ6ZVWeUSdOiEIQMXOL4GdJLmXF1ycwuQ8trCIonvm/t6FBBrj
 V9PC4SwCd+V+nhBUXlDtRjI83ESaBggIhLC/xMa6xOxJfOyCE9GuGzjaXYMkdMjoYX+q
 DagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699840176; x=1700444976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oONLZU+k1c7pjdGca1S1UQvtxT+y3sBxYGld3kTp6Js=;
 b=GlIf/27uJJ57VEZhgPiLh4B/2DgNIZqjqRxe/dYB1o8A7rYUuNLmw9Xn3RcJiaumtQ
 XDxOF6S6w49cj7RNad9fTsy0KSQTljYwNI6LgBbxUdAY3jX9B+8hUGqYLwJPsgle/saH
 FUYxT9kPNHlV/7VZxn74l+z68ZA1A219N3T0FPiVYhnAFa5axLPswHiqJR1Waz9LMHyW
 9+1kZfdCsy1Za7euwHysJtuohX6Ap/Evdk8UoQgNTKiE0MNnoH2RJB9v3v/u/Hfg96S+
 4IGAuEkToBK3PCFXvbbGiMBk97O36K3AoaVjRDM+6G70hMGQTvgILHMOSOuqcMVDyMOo
 AfbQ==
X-Gm-Message-State: AOJu0Yz2uReX6asXOTykNB4BGrjN0csf0FET/MDmvDMPnLvD8Nkg0c3E
 grvHNafW5i//+539NwTLPgX0HA==
X-Google-Smtp-Source: AGHT+IEj1hAKQc5dezDZTl1PJVbzYsZAT9Te4LzD4ChCpc99oG0VUyXs9RbSXeO6KDBvRsgxvv5LWA==
X-Received: by 2002:a9d:6e91:0:b0:6cd:74d:1f34 with SMTP id
 a17-20020a9d6e91000000b006cd074d1f34mr6409871otr.1.1699840176269; 
 Sun, 12 Nov 2023 17:49:36 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:ba59:509b:48bc:9f1])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a65644e000000b005b92e60cf57sm2635549pgv.56.2023.11.12.17.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 17:49:35 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v2 3/5] cmd: add scmi command for SCMI firmware
Date: Mon, 13 Nov 2023 10:49:09 +0900
Message-Id: <20231113014911.3308990-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113014911.3308990-1-takahiro.akashi@linaro.org>
References: <20231113014911.3308990-1-takahiro.akashi@linaro.org>
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
v8 (actually v2 as SCMI cmd)
* localize global variables to avoid pytest errors
v3
* describe that arguments are in hex at a help message
* modify the code for dynamically allocated agent names
v2
* remove sub command category, 'scmi base', for simplicity
---
 cmd/Kconfig  |   9 ++
 cmd/Makefile |   1 +
 cmd/scmi.c   | 384 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 394 insertions(+)
 create mode 100644 cmd/scmi.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index df6d71c103f9..ca9f742dcf78 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2559,6 +2559,15 @@ config CMD_CROS_EC
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
index 9a6790cc1708..320f0b5266eb 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -159,6 +159,7 @@ obj-$(CONFIG_CMD_SATA) += sata.o
 obj-$(CONFIG_CMD_NVME) += nvme.o
 obj-$(CONFIG_SANDBOX) += sb.o
 obj-$(CONFIG_CMD_SF) += sf.o
+obj-$(CONFIG_CMD_SCMI) += scmi.o
 obj-$(CONFIG_CMD_SCSI) += scsi.o disk.o
 obj-$(CONFIG_CMD_SHA1SUM) += sha1sum.o
 obj-$(CONFIG_CMD_SEAMA) += seama.o
diff --git a/cmd/scmi.c b/cmd/scmi.c
new file mode 100644
index 000000000000..664062c4eff5
--- /dev/null
+++ b/cmd/scmi.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  SCMI (System Control and Management Interface) utility command
+ *
+ *  Copyright (c) 2023 Linaro Limited
+ *		Author: AKASHI Takahiro
+ */
+
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
+ * get_agent() - get SCMI agent device
+ *
+ * Return:	Pointer to SCMI agent device on success, NULL on failure
+ */
+static struct udevice *get_agent(void)
+{
+	struct udevice *agent;
+
+	if (uclass_get_device(UCLASS_SCMI_AGENT, 0, &agent)) {
+		printf("Cannot find any SCMI agent\n");
+		return NULL;
+	}
+
+	return agent;
+}
+
+/**
+ * get_base_proto() - get SCMI base protocol device
+ * @agent:	SCMI agent device
+ *
+ * Return:	Pointer to SCMI base protocol device on success,
+ *		NULL on failure
+ */
+static struct udevice *get_base_proto(struct udevice *agent)
+{
+	struct udevice *base_proto;
+
+	if (!agent) {
+		agent = get_agent();
+		if (!agent)
+			return NULL;
+	}
+
+	base_proto = scmi_get_protocol(agent, SCMI_PROTOCOL_ID_BASE);
+	if (!base_proto) {
+		printf("SCMI base protocol not found\n");
+		return NULL;
+	}
+
+	return base_proto;
+}
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
+	struct udevice *agent, *base_proto;
+	u32 agent_id, num_protocols;
+	u8 *agent_name, *protocols;
+	int i, ret;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	agent = get_agent();
+	if (!agent)
+		return CMD_RET_FAILURE;
+	base_proto = get_base_proto(agent);
+	if (!base_proto)
+		return CMD_RET_FAILURE;
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
+	struct udevice *base_proto;
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
+	base_proto = get_base_proto(NULL);
+	if (!base_proto)
+		return CMD_RET_FAILURE;
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
+	struct udevice *base_proto;
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
+	base_proto = get_base_proto(NULL);
+	if (!base_proto)
+		return CMD_RET_FAILURE;
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
+	struct udevice *base_proto;
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
+	base_proto = get_base_proto(NULL);
+	if (!base_proto)
+		return CMD_RET_FAILURE;
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
+	" perm_proto <agent-id in hex> <device-id in hex> <protocol-id in hex> <flags in hex>\n"
+	"   - set protocol permission to device\n"
+	" reset <agent-id in hex> <flags in hex>\n"
+	"   - reset platform resource settings\n"
+	"";
+
+U_BOOT_CMD(scmi, CONFIG_SYS_MAXARGS, 0, do_scmi, "SCMI utility",
+	   scmi_help_text);
-- 
2.34.1

