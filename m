Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A5AE784BE
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DC97871B1;
	Mon,  2 Oct 2023 17:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="jHyMazWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB8A9871B0; Mon,  2 Oct 2023 17:21:58 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3540871A2
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
Received: from arisu.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id D44EB6607310;
 Mon,  2 Oct 2023 16:21:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1696260116;
 bh=Km4+/WZ0Q3YVkgKbmhY1Aw5q0Y4dYPTkkP46rUcQ++A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jHyMazWFRxnWD7Eg/3/52yjB7CrjIT8x++3sdpGC9VeVbkLs/5W6Pv/vmmZsYptxH
 DaBY9T0DJUHQSONQZZ8G1yY7WIxHYqP/s3pdHk7tzym/jc61hopFUcwVkiB5Ugjvde
 blIHqgE/u5yzUL27pgvkUT/WKkE8hefuWNiM6eB/8dp7CDD8mxbZUd6WggufavsMZY
 udpMrnHJLcD3msA/4ly+HRcSZ/zT8ebg4yyY6D4Cu+aHG5FL4u4Y0cTTc2B8aopEy/
 1dqi1DRN3XNdacnc58f1kD5ZqOKY5zXpYTLF4ZdsUnT2eXMlO3D/93DBroKZSjhCEf
 mHECoJxWR92Rg==
From: Detlev Casanova <detlev.casanova@collabora.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Simon Glass <sjg@chromium.org>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v5 2/6] cmd: Add a sysinfo command
Date: Mon,  2 Oct 2023 11:20:06 -0400
Message-ID: <20231002152142.76516-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002152142.76516-1-detlev.casanova@collabora.com>
References: <20231002152142.76516-1-detlev.casanova@collabora.com>
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

The command is able to show different information for the running
system:
* Model name
* Board ID
* Revision

This command can be used by boot shell scripts to select configurations
depending on the specific running system.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 cmd/Kconfig   |   6 +++
 cmd/Makefile  |   1 +
 cmd/sysinfo.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+)
 create mode 100644 cmd/sysinfo.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 43ca10f69cc..67d019aa795 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -218,6 +218,12 @@ config CMD_SBI
 	help
 	  Display information about the SBI implementation.
 
+config CMD_SYSINFO
+	bool "sysinfo"
+	depends on SYSINFO
+	help
+	  Display information about the system.
+
 endmenu
 
 menu "Boot commands"
diff --git a/cmd/Makefile b/cmd/Makefile
index 9bebf321c39..972f3a4720e 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -167,6 +167,7 @@ obj-$(CONFIG_CMD_SPI) += spi.o
 obj-$(CONFIG_CMD_STRINGS) += strings.o
 obj-$(CONFIG_CMD_SMC) += smccc.o
 obj-$(CONFIG_CMD_SYSBOOT) += sysboot.o
+obj-$(CONFIG_CMD_SYSINFO) += sysinfo.o
 obj-$(CONFIG_CMD_STACKPROTECTOR_TEST) += stackprot_test.o
 obj-$(CONFIG_CMD_TEMPERATURE) += temperature.o
 obj-$(CONFIG_CMD_TERMINAL) += terminal.o
diff --git a/cmd/sysinfo.c b/cmd/sysinfo.c
new file mode 100644
index 00000000000..46369ff9ac7
--- /dev/null
+++ b/cmd/sysinfo.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023
+ * Detlev Casanova <detlev.casanova@collabora.com>
+ */
+
+#include <command.h>
+#include <env.h>
+#include <sysinfo.h>
+#include <exports.h>
+
+static int get_sysinfo(struct udevice **devp)
+{
+	int ret = sysinfo_get(devp);
+
+	if (ret) {
+		printf("Cannot get sysinfo: %d\n", ret);
+		return ret;
+	}
+
+	ret = sysinfo_detect(*devp);
+	if (ret) {
+		printf("Cannot detect sysinfo: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int do_sysinfo_model(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char *const argv[])
+{
+	struct udevice *dev;
+	char model[64];
+	int ret = get_sysinfo(&dev);
+
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	ret = sysinfo_get_str(dev,
+			      SYSINFO_ID_BOARD_MODEL,
+			      sizeof(model),
+			      model);
+	if (ret) {
+		printf("Cannot get sysinfo str: %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	if (argc == 2)
+		ret = env_set(argv[1], model);
+	else
+		printf("%s\n", model);
+
+	if (ret)
+		return CMD_RET_FAILURE;
+	else
+		return CMD_RET_SUCCESS;
+}
+
+static int do_sysinfo_id(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[])
+{
+	struct udevice *dev;
+	u32 board_id;
+	int ret = get_sysinfo(&dev);
+
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	ret = sysinfo_get_int(dev, SYSINFO_ID_BOARD_ID, &board_id);
+	if (ret) {
+		printf("Cannot get sysinfo int: %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	if (argc == 2)
+		ret = env_set_hex(argv[1], board_id);
+	else
+		printf("0x%02x\n", board_id);
+
+	if (ret)
+		return CMD_RET_FAILURE;
+	else
+		return CMD_RET_SUCCESS;
+}
+
+static int do_sysinfo_revision(struct cmd_tbl *cmdtp, int flag, int argc,
+			       char *const argv[])
+{
+	struct udevice *dev;
+	int rev_major;
+	int rev_minor;
+	char rev[64];
+	int ret = get_sysinfo(&dev);
+
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	ret = sysinfo_get_int(dev, SYSINFO_ID_BOARD_REV_MAJOR, &rev_major);
+	if (ret) {
+		printf("Cannot get sysinfo int: %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	ret = sysinfo_get_int(dev, SYSINFO_ID_BOARD_REV_MINOR, &rev_minor);
+	if (ret) {
+		printf("Cannot get sysinfo int: %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	snprintf(rev, sizeof(rev), "%d.%d", rev_major, rev_minor);
+
+	if (argc == 2)
+		ret = env_set(argv[1], rev);
+	else
+		printf("%s\n", rev);
+
+	if (ret)
+		return CMD_RET_FAILURE;
+	else
+		return CMD_RET_SUCCESS;
+}
+
+static char sysinfo_help_text[] =
+	"model <varname>     - Show or set the board model in varname\n"
+	"sysinfo id <varname>        - Show or set the board id in varname (in format 0xHH)\n"
+	"sysinfo revision <varname>  - Show or set the board revision in varname";
+
+U_BOOT_CMD_WITH_SUBCMDS(sysinfo, "System information", sysinfo_help_text,
+			U_BOOT_SUBCMD_MKENT(model, 2, 1, do_sysinfo_model),
+			U_BOOT_SUBCMD_MKENT(id, 2, 1, do_sysinfo_id),
+			U_BOOT_SUBCMD_MKENT(revision, 2, 1, do_sysinfo_revision),
+);
-- 
2.41.0

