Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748DECCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:40:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C351838AE;
	Mon, 27 Oct 2025 17:40:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hO2ETln4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fxx9V1nQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AC678391C; Mon, 27 Oct 2025 17:39:58 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92876838AB
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cwK3w2n5bz9sqC;
 Mon, 27 Oct 2025 17:39:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=W+I0dTyIRHiMOzastKP52WqXUhYEO50gJNviDlsSfok=;
 b=hO2ETln471TujrUz+ZE4QmiSjddHHrjL+FtBbLhQIeH24acJdmjIQa+dlN5ndVMmAaibTU
 H+8r+QWWHrmVT6ewiCAOBFDks3vfpNao8BXrh4Ep+X0s1TDMmNzZh2AAoU3OFL0WT5CwQH
 WOhI8u28aspgSoJc/gU8yFS9F95MwCbP1YgPbZ/nG/h95lL2GXQJjnY8iznD3raU7GEjpw
 fhp1+/jL2ki5uqmq71Df4UxjgGhvlhJcGOiMppZ4DHVA6eQoE/68egRiywytrcu3HNWlu8
 6VZ6Psx+3BmBy1OWZmy6bY2tf8JSgcjfxn7l2xVqBJAr6dcr9+YHAsPMW0ut4w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=W+I0dTyIRHiMOzastKP52WqXUhYEO50gJNviDlsSfok=;
 b=fxx9V1nQ4cWY+mcmSUtH4wBTXl0PxXq8c4W9BqvR52QmgwO8/Lu8eueAYW+ahiOGmRu5m4
 mpPxsbRgTgKv8IBLKqIWWmbX5dJUPLEet3RWrkk2ABDtcTVA1tox+uSiblWBU3VTlWDxih
 X5EKv3AXxX2AAC/nY+n92ivY9LKbZ8yr9w3yASXnU72ggskp5Nxu52EAvReeqz68k4kuG/
 JWjLzO80LWU2Jt+MG5PPYc7JPXY9w+R/2Q4aSGhTeTgmygrXPFn7NJwyT/bwpWgYbFAOqe
 D8mOkMhutR+KyvaKjguKZqbwEZIT3EIV0Ow/JlluLyd5cYGK3r4IQVNbOu3JPQ==
To: u-boot@lists.denx.de
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Jamie Gibbons <jamie.gibbons@microchip.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Viorel Suman <viorel.suman@nxp.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH] mailbox: renesas: Add Renesas MFIS Multifunctional Interface
 mailbox driver
Date: Mon, 27 Oct 2025 17:39:17 +0100
Message-ID: <20251027163949.11846-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: j3d8w5zk9ny79if5w57iemuq7p1p1fxg
X-MBO-RS-ID: 063abbe46cde06f3f12
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

From: Tuyen Dang <tuyen.dang.xa@renesas.com>

Add support for the Renesas MFIS mailbox, which provides an interface
between the different CPU Cores, such as AP System Core domain and the
Realtime Core domain, SCP Core domain and AP System Core domain or
Realtime Core domain and AP System Core domain or Realtime Core domain.

Signed-off-by: Tuyen Dang <tuyen.dang.xa@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # Update the driver
[Marek: Rename the driver to renesas-mfis, simplify the driver.
        Always use only one TX channel and no RX channel, drop all
	unnecessary code. Perform 1ms delay in send callback which
	is perfectly fine to do in U-Boot which does RX polling]
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Jamie Gibbons <jamie.gibbons@microchip.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
Cc: Viorel Suman <viorel.suman@nxp.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
 drivers/mailbox/Kconfig        | 10 ++++++
 drivers/mailbox/Makefile       |  1 +
 drivers/mailbox/renesas-mfis.c | 59 ++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)
 create mode 100644 drivers/mailbox/renesas-mfis.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index f9531c1627c..cfd2a3be3fd 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -66,6 +66,16 @@ config K3_SEC_PROXY
 	  Select this driver if your platform has support for this hardware
 	  block.
 
+config RCAR_MFIS_MBOX
+	bool "Renesas MFIS Multifunctional Interface mailbox driver"
+	depends on DM_MAILBOX && ARCH_RENESAS
+	help
+	  This enables support for the Renesas MFIS mailbox module, which
+	  provides an interface between the different CPU Cores, such as AP
+	  System Core domain and the Realtime Core domain, SCP Core domain
+	  and AP System Core domain or Realtime Core domain and AP System
+	  Core domain or Realtime Core domain.
+
 config ZYNQMP_IPI
 	bool "Xilinx ZynqMP IPI controller support"
 	depends on DM_MAILBOX && (ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2)
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index b54fbdfff15..b3a36691497 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -12,4 +12,5 @@ obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox-test.o
 obj-$(CONFIG_STM32_IPCC) += stm32-ipcc.o
 obj-$(CONFIG_TEGRA_HSP) += tegra-hsp.o
 obj-$(CONFIG_K3_SEC_PROXY) += k3-sec-proxy.o
+obj-$(CONFIG_RCAR_MFIS_MBOX) += renesas-mfis.o
 obj-$(CONFIG_ZYNQMP_IPI) += zynqmp-ipi.o
diff --git a/drivers/mailbox/renesas-mfis.c b/drivers/mailbox/renesas-mfis.c
new file mode 100644
index 00000000000..1e9e8285974
--- /dev/null
+++ b/drivers/mailbox/renesas-mfis.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020-2025, Renesas Electronics Corporation.
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <mailbox-uclass.h>
+
+#define COM		0x0
+#define IIR		BIT(0)
+
+struct mfis_priv {
+	void __iomem	*tx_base;
+};
+
+static int mfis_send(struct mbox_chan *chan, const void *data)
+{
+	struct mfis_priv *mfis = dev_get_priv(chan->dev);
+
+	writel(IIR, mfis->tx_base + COM);
+
+	/* Give the remote side some time. */
+	mdelay(1);
+
+	writel(0, mfis->tx_base + COM);
+
+	return 0;
+}
+
+struct mbox_ops mfis_mbox_ops = {
+	.send		= mfis_send,
+};
+
+static int mfis_mbox_probe(struct udevice *dev)
+{
+	struct mfis_priv *mbox = dev_get_priv(dev);
+
+	mbox->tx_base = dev_read_addr_index_ptr(dev, 0);
+	if (!mbox->tx_base)
+		return -ENODEV;
+
+	return 0;
+}
+
+static const struct udevice_id mfis_mbox_of_match[] = {
+	{ .compatible = "renesas,mfis-mbox", },
+	{},
+};
+
+U_BOOT_DRIVER(renesas_mfis) = {
+	.name		= "renesas-mfis",
+	.id		= UCLASS_MAILBOX,
+	.of_match	= mfis_mbox_of_match,
+	.probe		= mfis_mbox_probe,
+	.priv_auto	= sizeof(struct mfis_priv),
+	.ops		= &mfis_mbox_ops,
+};
-- 
2.51.0

