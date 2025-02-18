Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC05BC021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 02:58:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9061680F56;
	Tue, 18 Feb 2025 03:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IuBcJIQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FBF580F84; Tue, 18 Feb 2025 03:58:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9861480ADF
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 03:58:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739847498; x=1771383498;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DTZcVVAXPZo6532Gfoq71Uc6nnxGt/mZWneM0XtE6Qc=;
 b=IuBcJIQ/nHDqqEvFbYu7lUMN8AWAIWZqFom+WYKoV2w6ic6hgRy/sMR9
 qVLMSqrZ7HZoMLG+mnuqOTE2koAsulzz/Q1+8tTm+BEk+7yDd0L3DdiQK
 mzZ3aNR1oQFzveGrnN2fCHpaK0zSMwftpmrwAk44GoWiTmXDEl2LhZUo3
 2HEh3NebxaXZfVrB6XXiBbBMW8Za2SSSklAQFNV5ZKNaVSOZVBjhh0hOV
 Ex56sJXTnT79cfhiLnsHoLVXtzpbtq9Xv/K76YA5X1D9tGqqcW4M+yPuJ
 LvZkNDSUNvNjHFoLl7D/LVWsRoBGfCcECNPFMLiHvVVpWcyFA2xcBqHYH A==;
X-CSE-ConnectionGUID: EA50J/7WQZq8Bchz6EyvLw==
X-CSE-MsgGUID: aXx8TC/ORXiQb8gH10Y6uA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51174475"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="51174475"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 18:58:17 -0800
X-CSE-ConnectionGUID: IB5QUj0hR5emQdoTuvacJA==
X-CSE-MsgGUID: vf0zldw9R5GG1Ph9ynn/Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="119259310"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2025 18:58:10 -0800
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Wang Jie <dave.wang@rock-chips.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH 09/10] cmd: Add i3c command support.
Date: Tue, 18 Feb 2025 10:57:04 +0800
Message-Id: <20250218025705.50051-10-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250218025705.50051-1-dinesh.maniyam@intel.com>
References: <20250218025705.50051-1-dinesh.maniyam@intel.com>
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

Add i3c command file to support select, get i3c device
target list, read and write operation.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 cmd/i3c.c                          | 193 +++++++++++++++++++++++++++++
 drivers/i3c/master/dw-i3c-master.c |  35 +++++-
 include/dw-i3c.h                   |   2 +
 include/i3c.h                      |   4 +
 4 files changed, 233 insertions(+), 1 deletion(-)
 create mode 100644 cmd/i3c.c

diff --git a/cmd/i3c.c b/cmd/i3c.c
new file mode 100644
index 0000000000..5631f487cc
--- /dev/null
+++ b/cmd/i3c.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Intel Coporation.
+ */
+
+#include <bootretry.h>
+#include <cli.h>
+#include <command.h>
+#include <console.h>
+#include <dm.h>
+#include <dw-i3c.h>
+#include <edid.h>
+#include <errno.h>
+#include <log.h>
+#include <malloc.h>
+#include <asm/byteorder.h>
+#include <linux/compiler.h>
+#include <linux/delay.h>
+#include <u-boot/crc.h>
+#include <linux/i3c/master.h>
+
+static struct udevice *currdev;
+static struct udevice *prevdev;
+static struct dw_i3c_master *master;
+
+void low_to_high_bytes(void *data, size_t size)
+{
+	unsigned char *byte_data = (unsigned char *)data;
+	size_t start = 0;
+	size_t end = size - 1;
+
+	while (start < end) {
+		unsigned char temp = byte_data[start];
+
+		byte_data[start] = byte_data[end];
+		byte_data[end] = temp;
+		start++;
+		end--;
+	}
+}
+
+/**
+ * do_i3c() - Handle the "i3c" command-line command
+ * @cmdtp:    Command data struct pointer
+ * @flag:    Command flag
+ * @argc:    Command-line argument count
+ * @argv:    Array of command-line arguments
+ *
+ * Returns zero on success, CMD_RET_USAGE in case of misuse and negative
+ * on error.
+ */
+static int do_i3c(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	struct uclass *uc;
+	int ret;
+	struct udevice *dev_list;
+	u32 length, bytes;
+	u8 *data;
+	u8 *rdata;
+	u8 device_num;
+
+	if (argc > 1) {
+		ret = uclass_get_device_by_name(UCLASS_I3C, argv[1], &currdev);
+		if (ret) {
+			if (!strcmp(argv[1], "help"))
+				return CMD_RET_USAGE;
+
+			currdev = prevdev;
+			if (!currdev) {
+				ret = uclass_get(UCLASS_I3C, &uc);
+				if (ret)
+					return CMD_RET_FAILURE;
+
+				uclass_foreach_dev(dev_list, uc)
+					printf("%s (%s)\n", dev_list->name, dev_list->driver->name);
+
+				printf("i3c master controller is not initialized: %s\n", argv[1]);
+				return CMD_RET_FAILURE;
+			}
+		} else {
+			master = dev_get_priv(currdev);
+			printf("current dev: %s\n", currdev->name);
+			prevdev = currdev;
+		}
+	} else {
+		if (!currdev) {
+			printf("No i3c device set!\n");
+			return CMD_RET_FAILURE;
+		}
+		printf("dev: %s\n", currdev->name);
+	}
+
+	if (!strcmp(argv[1], "list")) {
+		ret = uclass_get(UCLASS_I3C, &uc);
+		if (ret)
+			return CMD_RET_FAILURE;
+
+		uclass_foreach_dev(dev_list, uc)
+		printf("%s (%s)\n", dev_list->name, dev_list->driver->name);
+	}
+
+	if (!strcmp(argv[1], "current")) {
+		if (!currdev)
+			printf("no current dev!\n");
+		else
+			printf("current dev: %s\n", currdev->name);
+	}
+
+	if ((!strcmp(argv[1], "write")) && !(argv[2] == NULL) && !(argv[3] == NULL) &&
+	    !(argv[4] == NULL)) {
+		length = hextoul(argv[3], NULL);
+
+		data = (u8 *)malloc(sizeof(u8) * length);
+		if (!data) {
+			debug("Memory allocation for data failed\n");
+			return -ENOMEM;
+		}
+
+		device_num = hextoul(argv[4], NULL);
+		bytes = hextoul(argv[2], NULL);
+
+		for (int i = 0; i < length; i++)
+			data[i] = (u8)((bytes >> (8 * i)) & 0xFF);
+
+		low_to_high_bytes(data, length);
+		ret = dm_i3c_write(currdev, device_num, data, length);
+		if (ret) {
+			ret = CMD_RET_FAILURE;
+			goto write_out;
+		}
+	}
+
+	if (!strcmp(argv[1], "read") && !(argv[2] == NULL) && !(argv[3] == NULL)) {
+		length = hextoul(argv[2], NULL);
+
+		rdata = (u8 *) malloc(sizeof(u8) * length);
+		if (!rdata) {
+			debug("Memory allocation for rdata failed\n");
+			return -ENOMEM;
+		}
+
+		device_num = hextoul(argv[3], NULL);
+
+		ret = dm_i3c_read(currdev, device_num, rdata, length);
+		if (ret) {
+			ret =  CMD_RET_FAILURE;
+		} else {
+			printf("Read buff: ");
+			for (size_t i = 0; i < length; ++i)
+				printf("%02x", rdata[i]);
+
+			printf("\n");
+		}
+
+		goto read_out;
+	}
+
+	if (!strcmp(argv[1], "device_list")) {
+		if (master) {
+			for (int i = 0; i < master->num_i3cdevs; i++) {
+				printf("device:%d\n", i);
+				printf("dynamic address:0x%X\n", master->i3cdev[i]->info.dyn_addr);
+				printf("PID:%llx\n", master->i3cdev[i]->info.pid);
+				printf("BCR:%X\n", master->i3cdev[i]->info.bcr);
+				printf("DCR:%X\n", master->i3cdev[i]->info.dcr);
+				printf("Max Read DS:%X\n", master->i3cdev[i]->info.max_read_ds);
+				printf("Max Write DS:%X\n", master->i3cdev[i]->info.max_write_ds);
+				printf("\n");
+			}
+		}
+	}
+
+	return CMD_RET_SUCCESS;
+
+read_out:
+	free(rdata);
+	return ret;
+
+write_out:
+	free(data);
+	return ret;
+}
+
+U_BOOT_CMD(
+	i3c,    5,    1,     do_i3c,
+	"access the system i3c\n",
+	"i3c write<data><length><device_number> - write to device.\n"
+	"i3c read<length><device_number> - read from device.\n"
+	"i3c device_list   - List valid target devices\n"
+	"i3c <i3c name>   - Select i3c controller.\n"
+	"i3c list   - List all the available i3c controller.\n"
+	"i3c current   - print current i3c controller.\n"
+);
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index af6e472f23..98bf894701 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -670,8 +670,11 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 	newdevs &= ~olddevs;
 
 	for (pos = 0; pos < master->maxdevs; pos++) {
-		if (newdevs & BIT(pos))
+		if (newdevs & BIT(pos)) {
 			i3c_master_add_i3c_dev_locked(m, master->addrs[pos]);
+			master->i3cdev[pos] = m->this;
+			master->num_i3cdevs++;
+		}
 	}
 
 	dw_i3c_master_free_xfer(xfer);
@@ -1006,8 +1009,38 @@ err_assert_rst:
 	return ret;
 }
 
+static int dw_i3c_master_priv_read(struct udevice *dev, u8 dev_number,
+				   u8 *buf, int buf_size)
+{
+	struct dw_i3c_master *master = dev_get_priv(dev);
+	struct i3c_dev_desc *i3cdev = master->i3cdev[dev_number];
+	struct i3c_priv_xfer i3c_xfers;
+
+	i3c_xfers.data.in = buf;
+	i3c_xfers.len = buf_size;
+	i3c_xfers.rnw = I3C_MSG_READ;
+
+	return dw_i3c_master_priv_xfers(i3cdev, &i3c_xfers, 1);
+}
+
+static int dw_i3c_master_priv_write(struct udevice *dev, u8 dev_number,
+				    u8 *buf, int buf_size)
+{
+	struct dw_i3c_master *master = dev_get_priv(dev);
+	struct i3c_dev_desc *i3cdev = master->i3cdev[dev_number];
+	struct i3c_priv_xfer i3c_xfers;
+
+	i3c_xfers.data.out = buf;
+	i3c_xfers.len = buf_size;
+	i3c_xfers.rnw = I3C_MSG_WRITE;
+
+	return dw_i3c_master_priv_xfers(i3cdev, &i3c_xfers, 1);
+}
+
 static const struct dm_i3c_ops dw_i3c_ops = {
 	.i3c_xfers = dw_i3c_master_priv_xfers,
+	.read = dw_i3c_master_priv_read,
+	.write = dw_i3c_master_priv_write,
 };
 
 static const struct udevice_id dw_i3c_ids[] = {
diff --git a/include/dw-i3c.h b/include/dw-i3c.h
index 42c37d6dfa..c652de7740 100644
--- a/include/dw-i3c.h
+++ b/include/dw-i3c.h
@@ -241,6 +241,8 @@ struct dw_i3c_master {
 	char type[5];
 	u8 addrs[MAX_DEVS];
 	bool first_broadcast;
+	struct i3c_dev_desc *i3cdev[I3C_BUS_MAX_DEVS];
+	u16 num_i3cdevs;
 };
 
 struct dw_i3c_i2c_dev_data {
diff --git a/include/i3c.h b/include/i3c.h
index 6ef4982dcf..969753ae49 100644
--- a/include/i3c.h
+++ b/include/i3c.h
@@ -28,6 +28,10 @@ struct dm_i3c_ops {
 	int (*i3c_xfers)(struct i3c_dev_desc *dev,
 			 struct i3c_priv_xfer *i3c_xfers,
 			 int i3c_nxfers);
+	int (*read)(struct udevice *dev, u8 dev_number,
+		    u8 *buf, int num_bytes);
+	int (*write)(struct udevice *dev, u8 dev_number,
+		     u8 *buf, int num_bytes);
 };
 
 #define i3c_get_ops(dev)	((struct dm_i3c_ops *)(dev)->driver->ops)
-- 
2.26.2

