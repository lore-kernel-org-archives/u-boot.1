Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D675CC87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 12:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09F5183AA7;
	Fri,  1 Aug 2025 14:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="JNGNOudc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E2883A8C; Fri,  1 Aug 2025 14:33:43 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2603C83A89
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 14:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=301ae58c2=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1754051603; x=1785587603;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DaDfSec5yi1u29eaYZQdkV4c2HjCSmPDQOIOf/a0ct0=;
 b=JNGNOudcMY0XaN0+Lyqi1qQnvuB9epc6Jm/NtmTz3AZAzyhPP5Ag/KOZ
 Z4aVkaNd76yXWFQMil+NpNxMBWelN7qGBgiSfAPCp/BWscwLmzdvWunVo
 Iy0g6Tvi8joGpAeaexRpUvD5InzqsVIdBQkO+Futvh5FCqisadZGHIjfl
 4PcVwZqRXOIFaj8Nn96ak40SdDrXocWRJEtlyLyJMp0LzUIKjMkXWUkYE
 0WfM6bs8W9YSSL0cRV7wzCb8bliwElswuDhTyG2JVql0YciCt7D6rBJin
 OCvVMWEaNxN9rQ3+EX1OWgxoIjA11xWaKYogJ3qYzDfCnzvRUUO5lZoiW Q==;
X-CSE-ConnectionGUID: shIRiUSSTtOu5z34fSbi5g==
X-CSE-MsgGUID: SU5zfpElR1+6z4jXWor6gA==
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; d="scan'208";a="212121935"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Aug 2025 05:33:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 1 Aug 2025 05:32:55 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 1 Aug 2025 05:32:54 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Cyril Jean
 <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, <jamie.gibbons@microchip.com>
Subject: [PATCH 4/6] misc: add PolarFire SoC system controller
Date: Fri, 1 Aug 2025 13:36:24 +0100
Message-ID: <20250801123626.1972658-5-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250801123626.1972658-1-jamie.gibbons@microchip.com>
References: <20250801123626.1972658-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 01 Aug 2025 14:41:57 +0200
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

This driver provides an interface to access the functions of the system
controller on the Microchip PolarFire SoC.
This driver includes functions to use the system controller to read
the device serial number.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 drivers/misc/Kconfig              |   9 ++
 drivers/misc/Makefile             |   1 +
 drivers/misc/mpfs_syscontroller.c | 157 ++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)
 create mode 100644 drivers/misc/mpfs_syscontroller.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 0f753b9dbb9..c1843b6e4f1 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -658,6 +658,15 @@ config MICROCHIP_FLEXCOM
 	  Only one function can be used at a time and is chosen at boot time
 	  according to the device tree.
 
+config MPFS_SYSCONTROLLER
+	bool "Enable Microchip PolarFire SoC (MPFS) System Services support"
+	depends on MISC
+	depends on MPFS_MBOX
+	help
+	  This driver adds support for the PolarFire SoC (MPFS) system controller.
+	  
+	  If unsure, say N.
+
 config K3_AVS0
 	depends on ARCH_K3 && SPL_DM_REGULATOR
 	bool "AVS class 0 support for K3 devices"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index f7422c8e95a..dc5eb3af19c 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_VEXPRESS_CONFIG) += vexpress_config.o
 obj-$(CONFIG_WINBOND_W83627) += winbond_w83627.o
 obj-$(CONFIG_JZ4780_EFUSE) += jz4780_efuse.o
 obj-$(CONFIG_MICROCHIP_FLEXCOM) += microchip_flexcom.o
+obj-$(CONFIG_MPFS_SYSCONTROLLER) += mpfs_syscontroller.o
 obj-$(CONFIG_K3_AVS0) += k3_avs.o
 obj-$(CONFIG_ESM_K3) += k3_esm.o
 obj-$(CONFIG_K3_BIST) += k3_bist.o
diff --git a/drivers/misc/mpfs_syscontroller.c b/drivers/misc/mpfs_syscontroller.c
new file mode 100644
index 00000000000..160be09b3eb
--- /dev/null
+++ b/drivers/misc/mpfs_syscontroller.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Microchip's PolarFire SoC (MPFS) System Controller Driver
+ *
+ * Copyright (C) 2024 Microchip Technology Inc. All rights reserved.
+ *
+ * Author: Jamie Gibbons <jamie.gibbons@microchip.com>
+ *
+ */
+
+#include <asm/system.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <env.h>
+#include <errno.h>
+#include <linux/compat.h>
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/mtd/mtd.h>
+#include <log.h>
+#include <mailbox.h>
+#include <misc.h>
+#include <mpfs-mailbox.h>
+
+/* Descriptor table */
+#define CMD_OPCODE						0x0u
+#define CMD_DATA_SIZE					0U
+#define CMD_DATA						NULL
+#define MBOX_OFFSET						0x0
+#define RESP_OFFSET						0x0
+#define RESP_BYTES						16U
+
+/**
+ * struct mpfs_syscontroller_priv - Structure representing System Controller data.
+ * @chan:	Mailbox channel
+ * @c:	Completion signal
+ */
+struct mpfs_syscontroller_priv {
+	struct mbox_chan chan;
+	struct completion c;
+};
+
+/**
+ * mpfs_syscontroller_run_service() - Run the MPFS system service
+ * @sys_controller:	corresponding MPFS system service device
+ * @msg:	Message to send
+ *
+ * Return: 0 if all goes good, else appropriate error message.
+ */
+int mpfs_syscontroller_run_service(struct mpfs_syscontroller_priv *sys_controller, struct mpfs_mss_msg *msg)
+{
+	int ret;
+
+	reinit_completion(&sys_controller->c);
+
+	/* Run the System Service Request */
+	ret = mbox_send(&sys_controller->chan, msg);
+	if (ret < 0) {
+		dev_warn(sys_controller->chan.dev, "MPFS sys controller service timeout\n");
+	}
+
+	debug("%s: Service successful %s\n",
+		  __func__, sys_controller->chan.dev->name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mpfs_syscontroller_run_service);
+
+/**
+ * mpfs_syscontroller_read_sernum() - Use system service to read the device serial number
+ * @sys_serv_priv:	system service private data
+ * @device_serial_number:	device serial number
+ *
+ * Return: 0 if all went ok, else return appropriate error
+ */
+int mpfs_syscontroller_read_sernum(struct mpfs_sys_serv *sys_serv_priv, u8 *device_serial_number)
+{
+	unsigned long timeoutsecs = 300;
+	int ret;
+
+	struct mpfs_mss_response response = {
+		.resp_status = 0U,
+		.resp_msg = (u32 *)device_serial_number,
+		.resp_size = RESP_BYTES};
+	struct mpfs_mss_msg msg = {
+		.cmd_opcode = CMD_OPCODE,
+		.cmd_data_size = CMD_DATA_SIZE,
+		.response = &response,
+		.cmd_data = CMD_DATA,
+		.mbox_offset = MBOX_OFFSET,
+		.resp_offset = RESP_OFFSET};
+
+	ret = mpfs_syscontroller_run_service(sys_serv_priv->sys_controller, &msg);
+	if (ret) {
+		dev_err(sys_serv_priv->sys_controller->chan.dev, "Service failed: %d, abort\n", ret);
+		return ret;
+	}
+
+	/* Receive the response */
+	ret = mbox_recv(&sys_serv_priv->sys_controller->chan, &msg, timeoutsecs);
+	if (ret) {
+		dev_err(sys_serv_priv->sys_controller->chan.dev, "Service failed: %d, abort. Failure: %u\n", ret, msg.response->resp_status);
+		return ret;
+	}
+
+	debug("%s: Read successful %s\n",
+		__func__, sys_serv_priv->sys_controller->chan.dev->name);
+
+	return 0;
+}
+EXPORT_SYMBOL(mpfs_syscontroller_read_sernum);
+
+static int mpfs_syscontroller_probe(struct udevice *dev)
+{
+	struct mpfs_syscontroller_priv *sys_controller = dev_get_priv(dev);
+	int ret;
+
+	ret = mbox_get_by_index(dev, 0, &sys_controller->chan);
+	if (ret) {
+		dev_err(dev, "%s: Acquiring mailbox channel failed. ret = %d\n",
+				__func__, ret);
+		return ret;
+	}
+
+	init_completion(&sys_controller->c);
+	dev_info(dev, "Registered MPFS system controller\n");
+
+	return 0;
+}
+
+static const struct udevice_id mpfs_syscontroller_ids[] = {
+	{ .compatible = "microchip,mpfs-sys-controller" },
+	{ }
+};
+
+struct mpfs_syscontroller_priv *mpfs_syscontroller_get(struct udevice *dev)
+{
+	struct mpfs_syscontroller_priv *sys_controller;
+
+	sys_controller = dev_get_priv(dev);
+	if (!sys_controller) {
+		debug("%s: MPFS system controller found but could not register as a sub device %p\n",
+			__func__, sys_controller);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	return sys_controller;
+}
+EXPORT_SYMBOL(mpfs_syscontroller_get);
+
+U_BOOT_DRIVER(mpfs_syscontroller) = {
+	.name           = "mpfs_syscontroller",
+	.id             = UCLASS_MISC,
+	.of_match       = mpfs_syscontroller_ids,
+	.probe          = mpfs_syscontroller_probe,
+	.priv_auto	= sizeof(struct mpfs_syscontroller_priv),
+};
-- 
2.43.0

