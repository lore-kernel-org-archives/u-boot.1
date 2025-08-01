Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA785C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 12:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E42283A9C;
	Fri,  1 Aug 2025 14:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="VVABbvcs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB1783A8C; Fri,  1 Aug 2025 14:33:24 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB7C1839F1
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 14:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=301ae58c2=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1754051601; x=1785587601;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1aKGwqbeLKcUYVNyEFIoK2eCt2FVttKJz2Nml3afGTQ=;
 b=VVABbvcsYHIqSvxWN/Nf/xH0mthcjlVx1FHk3mXAJq2gFaxUya0fGjH9
 UaZi3WTLLMLJO23vOtorw57Z0uKFimp+aFuGySQHTQ5ZnT8cuO63S65N5
 znmgDyoyI80bW6wF4OIWrDgbggmS22dOgyePcci4ffVQUzTpk6QW6TiTn
 hV1fx3rgH4JvdAmS4muJX2lho9rtaujoFQHD//iUNU/1swIThIXjsbMzo
 W4lFqwnC9U9LOV2N8coTpRiBHd/4jaxcCQ8WOptU4/I+ChkxtJgfr2B2y
 sWAlpX7HBtd5f1fzEuGu98lJrlGxF7EqFyQgxAXywxfgNFQFf7KSBH+Sr Q==;
X-CSE-ConnectionGUID: shIRiUSSTtOu5z34fSbi5g==
X-CSE-MsgGUID: QAsxa+cWQGWe+ebI1MRjTg==
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; d="scan'208";a="212121934"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Aug 2025 05:33:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 1 Aug 2025 05:32:46 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 1 Aug 2025 05:32:44 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Cyril Jean
 <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, <jamie.gibbons@microchip.com>
Subject: [PATCH 3/6] mailbox: add PolarFire SoC mailbox driver
Date: Fri, 1 Aug 2025 13:36:23 +0100
Message-ID: <20250801123626.1972658-4-jamie.gibbons@microchip.com>
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

This driver adds support for the single mailbox channel of the MSS
system controller on the Microchip PolarFire SoC.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 drivers/mailbox/Kconfig     |   7 ++
 drivers/mailbox/Makefile    |   1 +
 drivers/mailbox/mpfs-mbox.c | 177 ++++++++++++++++++++++++++++++++++++
 include/mpfs-mailbox.h      |  67 ++++++++++++++
 4 files changed, 252 insertions(+)
 create mode 100644 drivers/mailbox/mpfs-mbox.c
 create mode 100644 include/mpfs-mailbox.h

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 4d9f004ebad..5a31ac707dc 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -28,6 +28,13 @@ config IMX_MU_MBOX
 	  Enable support for i.MX Messaging Unit for communication with other
 	  processors on the SoC using mailbox interface
 
+config MPFS_MBOX
+	bool "Enable MPFS system controler support"
+	depends on DM_MAILBOX && ARCH_RV64I
+	help
+	  Enable support for the mailboxes that provide a comminucation
+	  channel with the system controller integrated on PolarFire SoC.
+
 config SANDBOX_MBOX
 	bool "Enable the sandbox mailbox test driver"
 	depends on DM_MAILBOX && SANDBOX
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index e8c745f7d79..b54fbdfff15 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_$(PHASE_)DM_MAILBOX) += mailbox-uclass.o
 obj-$(CONFIG_APPLE_MBOX) += apple-mbox.o
 obj-$(CONFIG_IMX_MU_MBOX) += imx-mailbox.o
+obj-$(CONFIG_MPFS_MBOX) += mpfs-mbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox-test.o
 obj-$(CONFIG_STM32_IPCC) += stm32-ipcc.o
diff --git a/drivers/mailbox/mpfs-mbox.c b/drivers/mailbox/mpfs-mbox.c
new file mode 100644
index 00000000000..55238847ecd
--- /dev/null
+++ b/drivers/mailbox/mpfs-mbox.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microchip's PolarFire SoC (MPFS) Mailbox Driver
+ *
+ * Copyright (C) 2024 Microchip Technology Inc. All rights reserved.
+ *
+ * Author: Jamie Gibbons <jamie.gibbons@microchip.com>
+ *
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <dm/ofnode.h>
+#include <linux/bitops.h>
+#include <linux/compat.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <log.h>
+#include <mailbox-uclass.h>
+#include <malloc.h>
+#include <mpfs-mailbox.h>
+
+#define SERVICES_CR_OFFSET 0x50u
+#define SERVICES_SR_OFFSET 0x54u
+
+#define SERVICE_CR_REQ_MASK 0x1u
+#define SERVICE_SR_BUSY_MASK 0x2u
+#define SERVICE_SR_STATUS_SHIFT 16
+#define SERVICE_CR_COMMAND_SHIFT 16
+#define MASK_8BIT 0xFF
+
+struct mpfs_mbox {
+	struct udevice *dev;
+	void __iomem *ctrl_base;
+	void __iomem *mbox_base;
+	struct mbox_chan *chan;
+};
+
+static bool mpfs_mbox_busy(struct mbox_chan *chan)
+{
+	struct mpfs_mbox *mbox = dev_get_priv(chan->dev);
+	uint16_t status;
+
+	status = readl(mbox->ctrl_base + SERVICES_SR_OFFSET);
+
+	return status & SERVICE_SR_BUSY_MASK;
+}
+
+static int mpfs_mbox_send(struct mbox_chan *chan, const void *data)
+{
+	struct mpfs_mbox *mbox = dev_get_priv(chan->dev);
+	struct mpfs_mss_msg *msg = (struct mpfs_mss_msg *)data;
+	u32 mailbox_val, cmd_shifted, value;
+	u8 *byte_buf;
+	u8 idx, byte_idx, byte_offset;
+
+	u32 *word_buf = (u32 *)msg->cmd_data;
+
+	if (mpfs_mbox_busy(chan))
+		return -EBUSY;
+
+	for (idx = 0; idx < (msg->cmd_data_size / BYTES_4); idx++)
+		writel(word_buf[idx], mbox->mbox_base + msg->mbox_offset + idx * BYTES_4);
+
+	if ((msg->cmd_data_size % BYTES_4) > 0) {
+		byte_offset = (msg->cmd_data_size / BYTES_4) * BYTES_4;
+		byte_buf = (u8 *)(msg->cmd_data + byte_offset);
+		mailbox_val = readl(mbox->mbox_base + msg->mbox_offset + idx * BYTES_4);
+
+		for (byte_idx = 0; byte_idx < (msg->cmd_data_size % BYTES_4); byte_idx++) {
+			mailbox_val &= ~(MASK_8BIT << (byte_idx * 0x8u));
+			mailbox_val |= (u32)byte_buf[byte_idx] << (byte_idx * 0x8u);
+		}
+		writel(mailbox_val, mbox->mbox_base + msg->mbox_offset + idx * BYTES_4);
+	}
+
+	cmd_shifted = msg->cmd_opcode << SERVICE_CR_COMMAND_SHIFT;
+	cmd_shifted |= SERVICE_CR_REQ_MASK;
+	writel(cmd_shifted, mbox->ctrl_base + SERVICES_CR_OFFSET);
+
+	do {
+		value = readl(mbox->ctrl_base + SERVICES_CR_OFFSET);
+	} while (SERVICE_CR_REQ_MASK == (value & SERVICE_CR_REQ_MASK));
+
+	do {
+		value = readl(mbox->ctrl_base + SERVICES_SR_OFFSET);
+	} while (SERVICE_SR_BUSY_MASK == (value & SERVICE_SR_BUSY_MASK));
+
+	msg->response->resp_status = (value >> SERVICE_SR_STATUS_SHIFT);
+	if (msg->response->resp_status)
+		return -EBADMSG;
+
+	return 0;
+}
+
+static int mpfs_mbox_recv(struct mbox_chan *chan, void *data)
+{
+	struct mpfs_mbox *mbox = dev_get_priv(chan->dev);
+	struct mpfs_mss_msg *msg = data;
+	struct mpfs_mss_response *response = msg->response;
+	u8 idx;
+
+	if (!response->resp_msg) {
+		dev_err(chan->dev, "failed to assign memory for response %d\n", -ENOMEM);
+		return -EINVAL;
+	}
+
+	if (mpfs_mbox_busy(chan)) {
+		dev_err(chan->dev, "mailbox is busy\n");
+		response->resp_status = 0xDEAD;
+		return -EINVAL;
+	}
+
+	for (idx = 0; idx < response->resp_size; idx++)
+		*((u8 *)(response->resp_msg) + idx) = readb(mbox->mbox_base + msg->resp_offset  + idx);
+
+	return 0;
+}
+
+static const struct mbox_ops mpfs_mbox_ops = {
+	.send = mpfs_mbox_send,
+	.recv = mpfs_mbox_recv,
+};
+
+static int mpfs_mbox_probe(struct udevice *dev)
+{
+	struct mpfs_mbox *mbox;
+	struct resource regs;
+	ofnode node;
+	int ret;
+
+	node = dev_ofnode(dev);
+
+	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
+	if (!mbox)
+		return -ENOMEM;
+
+	ret = ofnode_read_resource(node, 0, &regs);
+	if (ret) {
+		dev_err(dev, "No reg property for controller base\n");
+		return ret;
+	};
+
+	mbox->ctrl_base = devm_ioremap(dev, regs.start, regs.start - regs.end);
+
+	ret = ofnode_read_resource(node, 2, &regs);
+	if (ret) {
+		dev_err(dev, "No reg property for mailbox base\n");
+		return ret;
+	};
+
+	mbox->mbox_base = devm_ioremap(dev, regs.start, regs.start - regs.end);
+
+	mbox->dev = dev;
+	dev_set_priv(dev, mbox);
+	mbox->chan->con_priv = mbox;
+
+	return 0;
+}
+
+static const struct udevice_id mpfs_mbox_ids[] = {
+	{.compatible = "microchip,mpfs-mailbox"},
+	{ }
+};
+
+U_BOOT_DRIVER(mpfs_mbox) = {
+	.name = "mpfs-mbox",
+	.id = UCLASS_MAILBOX,
+	.of_match = mpfs_mbox_ids,
+	.probe = mpfs_mbox_probe,
+	.priv_auto = sizeof(struct mpfs_mbox),
+	.ops = &mpfs_mbox_ops,
+};
diff --git a/include/mpfs-mailbox.h b/include/mpfs-mailbox.h
new file mode 100644
index 00000000000..fe83364ed4c
--- /dev/null
+++ b/include/mpfs-mailbox.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *
+ * Microchip PolarFire SoC (MPFS)
+ *
+ * Copyright (c) 2020 Microchip Corporation. All rights reserved.
+ *
+ *
+ */
+
+#ifndef _MPFS_MAILBOX_H__
+#define _MPFS_MAILBOX_H__
+
+#include <linux/types.h>
+
+#define BYTES_4 4
+
+struct udevice;
+
+/**
+ * struct mpfs_mss_msg - PolarFire SoC message structure
+ * @cmd_opcode:	Command opcode
+ * @cmd_data_size:	Size of the command data.
+ * @response:	Pointer to the response data.
+ * @cmd_data:	Pointer to the command data.
+ * @mbox_offset:	Mailbox offset
+ * @resp_offset:	Response offset
+ *
+ */
+struct mpfs_mss_msg
+{
+	u8 cmd_opcode;
+	u16 cmd_data_size;
+	struct mpfs_mss_response *response;
+	u8 *cmd_data;
+	u16 mbox_offset;
+	u16 resp_offset;
+};
+
+/**
+ * struct mpfs_mss_response - PolarFire SoC response structure
+ * @resp_status:	Reponse status
+ * @resp_msg:	Pointer to response message.
+ * @resp_size:	Size of the response message.
+ *
+ */
+struct mpfs_mss_response
+{
+	u32 resp_status;
+	u32 *resp_msg;
+	u16 resp_size;
+};
+
+struct mpfs_syscontroller_priv;
+
+struct mpfs_sys_serv {
+	struct udevice *dev;
+	struct mpfs_syscontroller_priv *sys_controller;
+	struct mpfs_mss_msg *msg;
+};
+
+int mpfs_syscontroller_run_service(struct mpfs_syscontroller_priv *sys_controller, struct mpfs_mss_msg *msg);
+int mpfs_syscontroller_read_sernum(struct mpfs_sys_serv *sys_serv_priv, u8 *device_serial_number);
+void mpfs_syscontroller_process_dtbo(struct mpfs_sys_serv *sys_serv_priv);
+struct mpfs_syscontroller_priv *mpfs_syscontroller_get(struct udevice *dev);
+
+#endif /* __MPFS_MAILBOX_H__ */
\ No newline at end of file
-- 
2.43.0

