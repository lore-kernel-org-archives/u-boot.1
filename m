Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85E3CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 14:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0570F86FBF;
	Wed, 18 Oct 2023 16:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k2XTtQ+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 513B686FBC; Wed, 18 Oct 2023 16:01:45 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BC8E86FBF
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 16:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9b96c3b4be4so1079906666b.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 07:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697637702; x=1698242502; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9maT3JowIE34YzP4AzrqMJEVZvB3Nof/CT52XgFDZrY=;
 b=k2XTtQ+9hnsDfltmRHut7Een0lkEjBNm/mPT1TaMimYzkhT1OXuox287QIhPp+qlWu
 hrU5bCjy16zIksCmlLdjZ/rYUdyhEEmJh5JgAF6TF70aFyOEMjysoIiFqe4AhJZSqv6z
 ZvFLuYTNWqXUZuIgkBVybZIMyR8/l9DvFVth5eTP+IuVEc1rKzLshOGIp7uLiGniCned
 OnrJxZddc4N2Vjbbe2YIKogGFRRE+cY77YLFQvmqPLtFtUX65xzkOqZ2A8oDhvq2F8G8
 X/PNiCRGt+Jw2a2mYri/gRNwXn7evM4U8lqkVSC3SsqNDcE/Q1ol+ISE+QCSls+CJP7f
 5eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697637702; x=1698242502;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9maT3JowIE34YzP4AzrqMJEVZvB3Nof/CT52XgFDZrY=;
 b=I1EZ1U+D6fyceZPR47PbVqD7LpaAwip1kZvAdYem/BxvCWAoBT+aD8hZxl+0ftDBKA
 UObmo39bnfwlvSrIGPHLfRCPOmc+BixeXUaproM4uOYELask3jlu0hQER2kIYmdHsEAq
 PiA2fNtGiVP6RFVua7+ex2fx5U55gYuoSHgY5lnFKcENeB+3ZGT1MzbFhPb7DzyP7aDp
 SMAV1AmzFDoKfcLjyimM32FjiLcu8I8xOys0X7e0jB+p8NJV6dLlSUIRbk+LJERrB/Hu
 nVeXRF+My6sQp2gu7t19NLFkRNUJc2J+9blezlwMYPQU8WTL8ShRe+n8y5uisnjC9V0R
 rdpQ==
X-Gm-Message-State: AOJu0YzooEFIDMidzhzm/tlS1CkJQpXjcTm5/3vju1C5NNC4b93uikEE
 lkWGbL9wQOT5q7VWNae1Hb4=
X-Google-Smtp-Source: AGHT+IHGLgJZCLPPVqf42UIU/fvv48KgDmOnwmrQ5ZfpKvwqoDfNTpHgQ5W+4xxEHg5rvmoxG4QEfw==
X-Received: by 2002:a17:907:961f:b0:9b2:cf77:a105 with SMTP id
 gb31-20020a170907961f00b009b2cf77a105mr4265979ejc.15.1697637701634; 
 Wed, 18 Oct 2023 07:01:41 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 m26-20020a50999a000000b00537666d307csm2935335edb.32.2023.10.18.07.01.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 07:01:41 -0700 (PDT)
Message-ID: <28275529-ddab-6924-f25a-69661c5f3e7e@gmail.com>
Date: Wed, 18 Oct 2023 16:01:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 5/8] rockchip: cmd: add rkmtd command
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 marex@denx.de, u-boot@lists.denx.de
References: <7fd0d9d1-2e93-a48b-edfd-6d4fec314a60@gmail.com>
Content-Language: en-US
In-Reply-To: <7fd0d9d1-2e93-a48b-edfd-6d4fec314a60@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

The command rkmtd creates a virtual block device to transfer
Rockchip boot block data to and from NAND with block orientated
tools like "ums" and "rockusb".

It uses the Rockchip MTD driver to scan for boot blocks and copies
data from the first block in a GPT formated virtual disk.
Data must be written in U-boot "idbloader.img" format and start at
partition "loader1" offset 64. The data header is parsed
for length and offset. When the last sector is received
it erases up to 5 erase blocks on NAND and writes bootblocks
in a pattern depending on the NAND ID. Data is then verified.
When a block turns out bad the block header is discarded.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changed V4:
  Sort includes

Changed V3:
  Split driver from command
  Split header
  Restyle
---
 cmd/Kconfig  |   8 ++
 cmd/Makefile |   1 +
 cmd/rkmtd.c  | 204 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 213 insertions(+)
 create mode 100644 cmd/rkmtd.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 6470b138d2f8..1979c6c62aa7 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1561,6 +1561,14 @@ config CMD_USB_SDP
 	  Enables the command "sdp" which is used to have U-Boot emulating the
 	  Serial Download Protocol (SDP) via USB.

+config CMD_RKMTD
+	bool "rkmtd"
+	select RKMTD
+	help
+	  Enable the command "rkmtd" to create a virtual block device to transfer
+	  Rockchip boot block data to and from NAND with block orientated tools
+	  like "ums" and "rockusb".
+
 config CMD_ROCKUSB
 	bool "rockusb"
 	depends on USB_FUNCTION_ROCKUSB
diff --git a/cmd/Makefile b/cmd/Makefile
index 9bebf321c397..11927a5904e6 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -151,6 +151,7 @@ obj-$(CONFIG_CMD_REISER) += reiser.o
 obj-$(CONFIG_CMD_REMOTEPROC) += remoteproc.o
 obj-$(CONFIG_CMD_RNG) += rng.o
 obj-$(CONFIG_CMD_KASLRSEED) += kaslrseed.o
+obj-$(CONFIG_CMD_RKMTD) += rkmtd.o
 obj-$(CONFIG_CMD_ROCKUSB) += rockusb.o
 obj-$(CONFIG_CMD_RTC) += rtc.o
 obj-$(CONFIG_SANDBOX) += host.o
diff --git a/cmd/rkmtd.c b/cmd/rkmtd.c
new file mode 100644
index 000000000000..5b80427cb949
--- /dev/null
+++ b/cmd/rkmtd.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *
+ * Driver interface derived from:
+ * /cmd/host.c
+ * Copyright (c) 2012, Google Inc.
+ *
+ * Copyright (C) 2023 Johan Jonker <jbx6244@gmail.com>
+ */
+
+#include <common.h>
+#include <blk.h>
+#include <command.h>
+#include <dm.h>
+#include <rkmtd.h>
+#include <stdio.h>
+#include <dm/device-internal.h>
+#include <dm/uclass-internal.h>
+
+static int do_rkmtd_bind(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[])
+{
+	struct udevice *dev;
+	const char *label;
+	int ret;
+
+	argc--;
+	argv++;
+
+	if (argc < 1)
+		return CMD_RET_USAGE;
+
+	if (argc > 1)
+		return CMD_RET_USAGE;
+
+	label = argv[0];
+	ret = rkmtd_create_attach_mtd(label, &dev);
+	if (ret) {
+		printf("Cannot create device / bind mtd\n");
+		return CMD_RET_FAILURE;
+	}
+
+	return 0;
+}
+
+static struct udevice *parse_rkmtd_label(const char *label)
+{
+	struct udevice *dev;
+
+	dev = rkmtd_find_by_label(label);
+	if (!dev) {
+		int devnum;
+		char *ep;
+
+		devnum = hextoul(label, &ep);
+		if (*ep ||
+		    uclass_find_device_by_seq(UCLASS_RKMTD, devnum, &dev)) {
+			printf("No such device '%s'\n", label);
+			return NULL;
+		}
+	}
+
+	return dev;
+}
+
+static int do_rkmtd_unbind(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[])
+{
+	struct udevice *dev;
+	const char *label;
+	int ret;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	label = argv[1];
+	dev = parse_rkmtd_label(label);
+	if (!dev)
+		return CMD_RET_FAILURE;
+
+	ret = rkmtd_detach(dev);
+	if (ret) {
+		printf("Cannot detach mtd\n");
+		return CMD_RET_FAILURE;
+	}
+
+	ret = device_unbind(dev);
+	if (ret) {
+		printf("Cannot unbind device '%s'\n", dev->name);
+		return CMD_RET_FAILURE;
+	}
+
+	return 0;
+}
+
+static void show_rkmtd_dev(struct udevice *dev)
+{
+	struct rkmtd_dev *plat = dev_get_plat(dev);
+	struct blk_desc *desc;
+	struct udevice *blk;
+	int ret;
+
+	printf("%3d ", dev_seq(dev));
+
+	ret = blk_get_from_parent(dev, &blk);
+	if (ret)
+		return;
+
+	desc = dev_get_uclass_plat(blk);
+	printf("%12lu %-15s\n", (unsigned long)desc->lba, plat->label);
+}
+
+static int do_rkmtd_info(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[])
+{
+	struct udevice *dev;
+
+	if (argc < 1)
+		return CMD_RET_USAGE;
+
+	dev = NULL;
+	if (argc >= 2) {
+		dev = parse_rkmtd_label(argv[1]);
+		if (!dev)
+			return CMD_RET_FAILURE;
+	}
+
+	printf("%3s %12s %-15s\n", "dev", "blocks", "label");
+	if (dev) {
+		show_rkmtd_dev(dev);
+	} else {
+		struct uclass *uc;
+
+		uclass_id_foreach_dev(UCLASS_RKMTD, dev, uc)
+			show_rkmtd_dev(dev);
+	}
+
+	return 0;
+}
+
+static int do_rkmtd_dev(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	struct udevice *dev;
+	const char *label;
+
+	if (argc < 1 || argc > 3)
+		return CMD_RET_USAGE;
+
+	if (argc == 1) {
+		struct rkmtd_dev *plat;
+
+		dev = rkmtd_get_cur_dev();
+		if (!dev) {
+			printf("No current rkmtd device\n");
+			return CMD_RET_FAILURE;
+		}
+		plat = dev_get_plat(dev);
+		printf("Current rkmtd device: %d: %s\n", dev_seq(dev),
+		       plat->label);
+		return 0;
+	}
+
+	label = argv[1];
+	dev = parse_rkmtd_label(argv[1]);
+	if (!dev)
+		return CMD_RET_FAILURE;
+
+	rkmtd_set_cur_dev(dev);
+
+	return 0;
+}
+
+static struct cmd_tbl cmd_rkmtd_sub[] = {
+	U_BOOT_CMD_MKENT(bind, 4, 0, do_rkmtd_bind, "", ""),
+	U_BOOT_CMD_MKENT(unbind, 4, 0, do_rkmtd_unbind, "", ""),
+	U_BOOT_CMD_MKENT(info, 3, 0, do_rkmtd_info, "", ""),
+	U_BOOT_CMD_MKENT(dev, 0, 1, do_rkmtd_dev, "", ""),
+};
+
+static int do_rkmtd(struct cmd_tbl *cmdtp, int flag, int argc,
+		    char *const argv[])
+{
+	struct cmd_tbl *c;
+
+	argc--;
+	argv++;
+
+	c = find_cmd_tbl(argv[0], cmd_rkmtd_sub, ARRAY_SIZE(cmd_rkmtd_sub));
+
+	if (c)
+		return c->cmd(cmdtp, flag, argc, argv);
+	else
+		return CMD_RET_USAGE;
+}
+
+U_BOOT_CMD(
+	rkmtd, 8, 1, do_rkmtd,
+	"Rockchip MTD sub-system",
+	"bind <label>      - bind RKMTD device\n"
+	"rkmtd unbind <label>    - unbind RKMTD device\n"
+	"rkmtd info [<label>]    - show all available RKMTD devices\n"
+	"rkmtd dev [<label>]     - show or set current RKMTD device\n"
+);
--
2.39.2

