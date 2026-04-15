Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA396F433CE
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 22:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 094E983015;
	Thu, 16 Apr 2026 00:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="E4mZW8uI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AgCuajuB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B844E84201; Thu, 16 Apr 2026 00:14:02 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 367CD84214
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 00:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fwwQr4Jxgz9tZ7;
 Thu, 16 Apr 2026 00:13:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776291236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nqaIGo7unODaNf/2gq3MPvfViE/I7CMwxHZ7lpdhPiQ=;
 b=E4mZW8uIsrATft6QbT7UcJgRJ0umlI2OPt0Zr6D9K2ARkZgfpJLoFSj1akmPxJMNDTaUpd
 ZfBWkfAUldq1PyICcv00skq+AQtcju7OA1+5bTi0dqZAc5iU+nMMR8aMrRBOAKXH8mSKO6
 MF/F25AbfN/o63YQKmANZIf670r8PYBahIjpmcUO+Shsqik9n8STWFbLeFzNaYkNjCJnSi
 VIhYAvWfdlKKbXgXzgxlARFoOSoePCcjCNJ4pda8YzjhntClsqnkzI7dcbNfd9VNS1n+W8
 tBuLzDgDbxan0n6AzuQyLHRArtk+wBGZq0fiGZTLgeFG6mW8ewfuRmo2gmAKBQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=AgCuajuB;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776291234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nqaIGo7unODaNf/2gq3MPvfViE/I7CMwxHZ7lpdhPiQ=;
 b=AgCuajuBaevFZK4WOzGPspSEj0wxqxTGIRadIb1LvoaVD5Ajd5uaYXclsFel3JDMsABp6Q
 PKCTzbKN7N9EM3g9Wa1GzliHUmTqmLyey+J0H9KxdjodXlJBSz12k1Ec2KEv7DRv1zUMBe
 Rz8BpzoLyQ9AntYciRBj0y2ps2Xnk1+i48opIXCnyPPViajJzLNxOcezhOYBEaw0HQLO4Y
 d/AZ1xWbcA62h9yy068JQV/yqDEEcthbAq2pLu0oAtRI7eZs3yIjEJPrhTI8TXtG2ReHRH
 HjbEO5wPgnthpS8T01OXKBX1Lddowc/HfdFGwz6beheslIxv9V65ySjDOJDajg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH] remoteproc: renesas: Add Renesas R-Car Gen5 remote processor
 driver
Date: Thu, 16 Apr 2026 00:12:43 +0200
Message-ID: <20260415221349.450669-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4d6be2c73f0eada8dcc
X-MBO-RS-META: w44rqwzkoo3x78zxkz9gopcymj53t1fy
X-Rspamd-Queue-Id: 4fwwQr4Jxgz9tZ7
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

Add R-Car Gen5 RSIP controller remoteproc driver capable of starting
the SCP, Cortex-R52 and Cortex-A720 cores in Renesas R-Car R8A78000
X5H SoC. The SCP core is started by releasing the core from reset,
the Cortex-R52 and Cortex-A720 are started using the SCP SCMI call.
The entry point for SCP core is fixed to its STCM, entry points for
Cortex-R52 and Cortex-A720 are set during rproc load.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
 drivers/remoteproc/Kconfig        |   9 +
 drivers/remoteproc/Makefile       |   1 +
 drivers/remoteproc/renesas_rsip.c | 358 ++++++++++++++++++++++++++++++
 3 files changed, 368 insertions(+)
 create mode 100644 drivers/remoteproc/renesas_rsip.c

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index f07ae903a28..7f9e35283f9 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -48,6 +48,15 @@ config REMOTEPROC_RENESAS_APMU
 	  Say 'y' here to add support for Renesas R-Car Gen4 Cortex-R52
 	  processor via the remoteproc framework.
 
+config REMOTEPROC_RENESAS_RSIP
+	bool "Support for Renesas R-Car Gen5 RSIP start of SCP/CR52/CA720 processors"
+	select REMOTEPROC
+	depends on ARCH_RENESAS && RCAR_GEN5 && DM && OF_CONTROL
+	help
+	  Say 'y' here to add support for Renesas R-Car Gen5 RSIP
+	  start of SCP, Cortex-R52 and Cortex-A720 processors via
+	  the remoteproc framework.
+
 config REMOTEPROC_SANDBOX
 	bool "Support for Test processor for Sandbox"
 	select REMOTEPROC
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 7ea8023c50b..250915d0de4 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_K3_SYSTEM_CONTROLLER) += k3_system_controller.o
 obj-$(CONFIG_REMOTEPROC_ADI_SC5XX) += adi_sc5xx_rproc.o
 obj-$(CONFIG_REMOTEPROC_IMX) += imx_rproc.o
 obj-$(CONFIG_REMOTEPROC_RENESAS_APMU) += renesas_apmu.o
+obj-$(CONFIG_REMOTEPROC_RENESAS_RSIP) += renesas_rsip.o
 obj-$(CONFIG_REMOTEPROC_SANDBOX) += sandbox_testproc.o
 obj-$(CONFIG_REMOTEPROC_STM32_COPRO) += stm32_copro.o
 obj-$(CONFIG_REMOTEPROC_TI_K3_ARM64) += ti_k3_arm64_rproc.o
diff --git a/drivers/remoteproc/renesas_rsip.c b/drivers/remoteproc/renesas_rsip.c
new file mode 100644
index 00000000000..76ccaf93b1a
--- /dev/null
+++ b/drivers/remoteproc/renesas_rsip.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+/*
+ * Copyright (C) 2026 Renesas Electronics Corp.
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <errno.h>
+#include <hang.h>
+#include <linux/iopoll.h>
+#include <linux/sizes.h>
+#include <malloc.h>
+#include <remoteproc.h>
+
+/* R-Car X5H contains 1 SCP core, 6 lockstep Cortex-R52 and 32 Cortex-A720AE cores. */
+#define RCAR5_SCP_CORES			1
+#define RCAR5_CR52_CORES		12
+#define RCAR5_CA720_CORES		32
+
+#define SCP_BASE			0xc1340000
+#define SCP_CPUWAIT			(SCP_BASE + 0x30)
+#define SCP_CPUWAIT_WAIT		BIT(0)
+#define SCP_STCM			0xc1000000
+
+struct scp_scmi_shmem {
+	u32	reserved0;
+	u32	status;
+	u64	reserved1;
+	u32	flags;
+	u32	length;
+	u32	message_header;
+	u8	payload[];
+};
+
+struct scp_scmi_pd_power_state_set_a2p {
+	u32	flags;
+	u32	domain_id;
+	u32	power_state;
+	u32	boot_addr;
+};
+
+/* The addresses in range 0x08000000..0x1fffffff are incremented by 0xa0000000 */
+#define MFIS_COMMON_BASE	0xb89e1000
+#define MFIS_SCP_WACNTR		(MFIS_COMMON_BASE + 0x904)
+
+/* The addresses in range 0x08000000..0x1fffffff are incremented by 0xa0000000 */
+#define MFIS_SCP_BASE		0xb8840000
+#define MFIS_SCP_REICR8		(MFIS_SCP_BASE + 0x28004)
+#define MFIS_SCP_CODEVALUE	0xacc00000
+#define MFIS_SCP_REG_MASK	GENMASK(19, 0)
+
+/**
+ * mfis_scp_unlock() - Release MFIS-SCP lock
+ * @lck: MFIS lock register
+ */
+static void mfis_scp_unlock(const u32 lck)
+{
+	writel(MFIS_SCP_CODEVALUE | (lck & MFIS_SCP_REG_MASK), MFIS_SCP_WACNTR);
+}
+
+#define SCP_SCMI_SHMEM_AREA09		0xc1060800
+#define SCP_SCMI_STATUS_MASK		0x3
+#define SCP_SCMI_STATUS_FREE		0x1
+
+/**
+ * scp_wait_fw_free() - Wait for SCP channel to be free for communication
+ */
+static void scp_wait_fw_free(void)
+{
+	struct scp_scmi_shmem *shmem = (struct scp_scmi_shmem *)SCP_SCMI_SHMEM_AREA09;
+
+	while ((shmem->status & SCP_SCMI_STATUS_MASK) != SCP_SCMI_STATUS_FREE)
+		mdelay(1);
+}
+
+/**
+ * scp_send_interrupt() - Raise interrupt on SCP side
+ */
+static void scp_send_interrupt(void)
+{
+	mfis_scp_unlock(MFIS_SCP_REICR8);
+	/* Send SCP IRQ */
+	writel(1, MFIS_SCP_REICR8);
+}
+
+/* SCMI power domain IDs */
+#define SCMI_PD_CORE_RT_CORE00			117
+#define SCMI_PD_CORE_AP_CORE00			129
+
+/*
+ * FIXME: This is custom extension to the SCMI PD protocol:
+ * - Protocol 0x11 (PD)
+ * - Command 0x11 (POWER_STATE_SET_BOOTADDR - custom)
+ * This must be removed when proper upstream SCP port exists
+ */
+#define SCMI_PD_POWER_STATE_SET_BOOTADDR	0x4411
+
+/**
+ * scp_cpu_core_start() - Boot CPU core by invoking SCP via SCMI
+ * @core: CPU core to boot
+ * @ep: Entry point
+ */
+static void scp_cpu_core_start(const u32 core, const u32 ep)
+{
+	struct scp_scmi_shmem *shmem = (struct scp_scmi_shmem *)SCP_SCMI_SHMEM_AREA09;
+	struct scp_scmi_pd_power_state_set_a2p scmi_parameter = {
+		.flags = 1,	/* Asynchronous power transition using APMU */
+		.domain_id = core,
+		.power_state = 0,	/* Power on */
+		.boot_addr = ep,
+	};
+	u32 status;
+
+	/* Wait for SCP to be free, then set it busy */
+	scp_wait_fw_free();
+	shmem->status &= ~SCP_SCMI_STATUS_FREE;
+
+	/* Set up the message and copy it to SHMEM */
+	shmem->message_header = SCMI_PD_POWER_STATE_SET_BOOTADDR;
+	memcpy(shmem->payload, &scmi_parameter, sizeof(scmi_parameter));
+	shmem->length = sizeof(shmem->message_header) + sizeof(scmi_parameter);
+
+	/* Send message to SCP and wait for completion */
+	scp_send_interrupt();
+	scp_wait_fw_free();
+
+	/* Read back the result */
+	status = readl((uintptr_t)shmem->payload);
+	if (status)
+		printf("SCP POWER_STATE_SET failed, status=0x%x\n", status);
+}
+
+/**
+ * struct renesas_rsip_rproc_privdata - remote processor private data
+ * @core_id:		CPU core id
+ * @ep:			Entry point
+ */
+struct renesas_rsip_rproc_privdata {
+	ulong		core_id;
+	ulong		ep;
+};
+
+/**
+ * renesas_rsip_rproc_load() - Load the remote processor
+ * @dev:	corresponding remote processor device
+ * @addr:	Address in memory where image is stored
+ * @size:	Size in bytes of the image
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_rsip_rproc_load(struct udevice *dev, ulong addr, ulong size)
+{
+	struct renesas_rsip_rproc_privdata *priv = dev_get_priv(dev);
+
+	priv->ep = addr;
+
+	if (priv->core_id == 0)		/* SCP */
+		memcpy((void *)SCP_STCM, (void *)addr, size);
+
+	return 0;
+}
+
+/**
+ * renesas_rsip_rproc_start() - Start the remote processor
+ * @dev:	corresponding remote processor device
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_rsip_rproc_start(struct udevice *dev)
+{
+	struct renesas_rsip_rproc_privdata *priv = dev_get_priv(dev);
+	int scmi_core;
+
+	if (priv->core_id == 0) {
+		/* SCP */
+		clrbits_le32(SCP_CPUWAIT, SCP_CPUWAIT_WAIT);
+		return 0;
+	} else if (priv->core_id >= RCAR5_SCP_CORES &&
+		   priv->core_id < RCAR5_SCP_CORES + RCAR5_CR52_CORES) {
+		/* CR52 */
+		scmi_core = priv->core_id - RCAR5_SCP_CORES +
+			    SCMI_PD_CORE_RT_CORE00;
+	} else if (priv->core_id >= RCAR5_SCP_CORES + RCAR5_CR52_CORES &&
+		   priv->core_id < RCAR5_SCP_CORES + RCAR5_CR52_CORES + RCAR5_CA720_CORES) {
+		/* CA720 */
+		scmi_core = priv->core_id - RCAR5_SCP_CORES - RCAR5_CR52_CORES +
+			    SCMI_PD_CORE_AP_CORE00;
+	}
+
+	scp_cpu_core_start(scmi_core, priv->ep);
+
+	return 0;
+}
+
+/**
+ * renesas_rsip_rproc_stop() - Stop the remote processor
+ * @dev:	corresponding remote processor device
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_rsip_rproc_stop(struct udevice *dev)
+{
+	struct renesas_rsip_rproc_privdata *priv = dev_get_priv(dev);
+
+	if (priv->core_id == 0) {	/* SCP */
+		setbits_le32(SCP_CPUWAIT, SCP_CPUWAIT_WAIT);
+		return 0;
+	}
+
+	return 0;
+}
+
+/**
+ * renesas_rsip_rproc_reset() - Reset the remote processor
+ * @dev:	corresponding remote processor device
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_rsip_rproc_reset(struct udevice *dev)
+{
+	renesas_rsip_rproc_stop(dev);
+	renesas_rsip_rproc_start(dev);
+	return 0;
+}
+
+/**
+ * renesas_rsip_rproc_is_running() - Is the remote processor running
+ * @dev:	corresponding remote processor device
+ *
+ * Return: 0 if the remote processor is running, 1 otherwise
+ */
+static int renesas_rsip_rproc_is_running(struct udevice *dev)
+{
+	/* We assume the core is stopped. */
+	return 1;
+}
+
+/**
+ * renesas_rsip_rproc_init() - Initialize the remote processor
+ * @dev:	corresponding remote processor device
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_rsip_rproc_init(struct udevice *dev)
+{
+	return 0;
+}
+
+/**
+ * renesas_rsip_rproc_device_to_virt() - Convert device address to virtual address
+ * @dev:	corresponding remote processor device
+ * @da:		device address
+ * @size:	Size of the memory region @da is pointing to
+ * @is_iomem:	optional pointer filled in to indicate if @da is iomapped memory
+ *
+ * Return: converted virtual address
+ */
+static void *renesas_rsip_rproc_device_to_virt(struct udevice *dev, ulong da,
+					       ulong size, bool *is_iomem)
+{
+	return (void *)da;
+}
+
+static const struct dm_rproc_ops renesas_rsip_rproc_ops = {
+	.init		= renesas_rsip_rproc_init,
+	.load		= renesas_rsip_rproc_load,
+	.start		= renesas_rsip_rproc_start,
+	.stop		= renesas_rsip_rproc_stop,
+	.reset		= renesas_rsip_rproc_reset,
+	.is_running	= renesas_rsip_rproc_is_running,
+	.device_to_virt	= renesas_rsip_rproc_device_to_virt,
+};
+
+/**
+ * renesas_rsip_rproc_of_to_plat() - Convert OF data to platform data
+ * @dev:	corresponding remote processor device
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_rsip_rproc_of_to_plat(struct udevice *dev)
+{
+	struct renesas_rsip_rproc_privdata *priv = dev_get_priv(dev);
+
+	priv->core_id = dev_get_driver_data(dev);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(renesas_rsip_core) = {
+	.name		= "rcar-rsip-core",
+	.id		= UCLASS_REMOTEPROC,
+	.ops		= &renesas_rsip_rproc_ops,
+	.of_to_plat	= renesas_rsip_rproc_of_to_plat,
+	.priv_auto	= sizeof(struct renesas_rsip_rproc_privdata),
+};
+
+/**
+ * renesas_rsip_rproc_bind() - Bind rproc driver to each core control
+ * @dev:	corresponding remote processor parent device
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_rsip_rproc_bind(struct udevice *parent)
+{
+	ofnode pnode = dev_ofnode(parent);
+	struct udevice *cdev;
+	struct driver *cdrv;
+	char name[32];
+	ulong i;
+	int ret;
+
+	cdrv = lists_driver_lookup_name("rcar-rsip-core");
+	if (!cdrv)
+		return -ENOENT;
+
+	/* Singleton SCP core is core 0 */
+	ret = device_bind_with_driver_data(parent, cdrv,
+					   strdup("rcar-rsip-scp"),
+					   0, pnode, &cdev);
+	if (ret)
+		return ret;
+
+	/* Cores 1..13 are Cortex-R52 */
+	for (i = 0; i < RCAR5_CR52_CORES; i++) {
+		snprintf(name, sizeof(name), "rcar-rsip-cr.%ld", i);
+		ret = device_bind_with_driver_data(parent, cdrv, strdup(name),
+						   i + RCAR5_SCP_CORES, pnode,
+						   &cdev);
+		if (ret)
+			return ret;
+	}
+
+	/* Cores 14..46 are Cortex-A720 */
+	for (i = 0; i < RCAR5_CA720_CORES; i++) {
+		snprintf(name, sizeof(name), "rcar-rsip-ca.%ld", i);
+		ret = device_bind_with_driver_data(parent, cdrv, strdup(name),
+						   i + RCAR5_SCP_CORES + RCAR5_CR52_CORES,
+						   pnode, &cdev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id renesas_rsip_rproc_ids[] = {
+	{ .compatible = "renesas,r8a78000-rproc" },
+	{ }
+};
+
+U_BOOT_DRIVER(renesas_rsip_rproc) = {
+	.name		= "rcar-rsip-rproc",
+	.of_match	= renesas_rsip_rproc_ids,
+	.id		= UCLASS_NOP,
+	.bind		= renesas_rsip_rproc_bind,
+};
-- 
2.53.0

