Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20595CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 22:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C420686BA6;
	Mon, 16 Oct 2023 00:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W8ls1vBq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02A0486BA6; Mon, 16 Oct 2023 00:34:19 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F21C186C26
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 00:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9c2a0725825so96527166b.2
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 15:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697409211; x=1698014011; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9maT3JowIE34YzP4AzrqMJEVZvB3Nof/CT52XgFDZrY=;
 b=W8ls1vBqGcGSubt1TdTKKO9M1Up49pHN8Agcj4deeaCEl8lIRrcDhCv+0nOgB78V38
 5ZHXXaKGyuA4LIe1KYfzPZtaEet+LCTyeL/ymEgLJWcuGwdVqFs9D7/28NEMmb3yF0Y3
 4KUPqm8hvJdZOMdDqHBVrCVzCNpTAgk5Z+vQttDHnLutAP+hAnutOyQylX8f9mHhbTel
 YlRevaT7en0I9+XSyzp7X0yZ08c9x/AYIr4ulb2abT9V20ioWz5KMEOe7e6plbkqpnX0
 +Hs/aVs62cHfkQ8teQkT3CgAGD3SBgZGPFX0g6Q4/7olq6Aqt7Rh9HLIz9tNSrXvgtZk
 LuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697409211; x=1698014011;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9maT3JowIE34YzP4AzrqMJEVZvB3Nof/CT52XgFDZrY=;
 b=hUr+g0rWEt36hvcLawcctv11VPuoTtNPE15AEnnuHKEiVcCZEiXJGj7ELFAd6G5J81
 rrkj7payQrWk0GOMf9PlYzwvmHZhKX6koJHvQgiCPve7AtLFOeIReLnH3K69YCN9o61v
 PuclTwwFTEGH42VRo7gJIaCHsWA3t28nH+74xFS3jfEyoJfPWRpjnBIMUJaM9BGXfSTG
 xUlQkq7nWwmoEIADS9IpduAHR8C5M895oeiRhW7unA7Bdg1JzLs4mGXSvSz1r4p4emkU
 GXVeWKT17twbCmLqhSTtrI5GLeYi1uws39EGRyPHQocxA4e6RJJEJghKcETtISVwh13j
 ojUQ==
X-Gm-Message-State: AOJu0YzMRniYIRPIzbv4E3AjgoH/chUcouD6hleH4oRQ/Zklt6lXJp2r
 MLTxLwZEyNUm7Wn3DAO8QOM=
X-Google-Smtp-Source: AGHT+IGGmjxedIJWSDNuscBgW67zdhRGvtP7/BzgRck9GfyxigIb4IJBpPjQoXfwryOGLNix1Oi8yA==
X-Received: by 2002:a17:906:32cb:b0:9b2:abda:2543 with SMTP id
 k11-20020a17090632cb00b009b2abda2543mr27974413ejk.65.1697409211077; 
 Sun, 15 Oct 2023 15:33:31 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 y23-20020a170906519700b0099bd5d28dc4sm2865226ejk.195.2023.10.15.15.33.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 15:33:30 -0700 (PDT)
Message-ID: <7799ffaa-0ea8-7b50-eed8-bfc9e5f18b37@gmail.com>
Date: Mon, 16 Oct 2023 00:33:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 5/8] rockchip: cmd: add rkmtd command
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 u-boot@lists.denx.de
References: <8c0f5bb6-0110-b7b5-3c40-2d8d98a94dfa@gmail.com>
Content-Language: en-US
In-Reply-To: <8c0f5bb6-0110-b7b5-3c40-2d8d98a94dfa@gmail.com>
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

