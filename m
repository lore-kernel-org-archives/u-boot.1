Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FE5CD4F49
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 14:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0848C846CE;
	Mon, 18 May 2026 16:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="FeHozdcE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2809D83EF9; Mon, 18 May 2026 16:13:32 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B7D284676
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 16:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=59164dd44=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1779113610; x=1810649610;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ku5M5BSKwC/C8SDb/+YQyDhyz1q2fhJnvLqQHz4Pl5M=;
 b=FeHozdcExZb16cnD/r8EmLjjkINeX8t8OmnLGBZIasVqqiRfm25YDZ3L
 1yGvX+EojRuzJkb83Zj/YP25Vdmgsdu5AsO/QUUp/5TCzjdIUdnjvDZH2
 qDl2AOjJqYNIpC2N6dzg3OhvsVDyeRcL5MKoR852bDVY4iLAfBkJa1Vpl
 PcMO8sDuxTZW9Sd7OS8THtK69PHXmReJ0IaBKfndbx9URA8QnV5G3BgY/
 ZCCEGZGKfcqFn1FXDHCrzrRSv/BEKPyPSje5LhI4RMRU5sPd/5OV4CxQ7
 vUTN2BzNzEKG9RvzKZAuquufylNk9sNkzBIM3Xjri+ML5IZgnLLAc2K1C w==;
X-CSE-ConnectionGUID: MHo6V6AdTRGzlrmNSHWs7A==
X-CSE-MsgGUID: MtSzhh7VSW+PFyDbmvzazw==
X-IronPort-AV: E=Sophos;i="6.23,242,1770620400"; d="scan'208";a="56885208"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 07:13:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Mon, 18 May 2026 07:13:28 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 18 May 2026 07:13:26 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Michael Trimarchi <michael@amarulasolutions.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, <jamie.gibbons@microchip.com>
Subject: [PATCH 4/4] mailbox: mpfs-mbox: support new syscon based devicetree
 configuration
Date: Mon, 18 May 2026 15:17:12 +0100
Message-ID: <20260518141712.3597880-5-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518141712.3597880-1-jamie.gibbons@microchip.com>
References: <20260518141712.3597880-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 18 May 2026 16:52:36 +0200
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

The original PolarFire SoC mailbox devicetree bindings described the
control/status and interrupt registers as standalone reg regions of the
mailbox device. This was incorrect, as these registers are shared system
control blocks and should instead be modeled as syscon devices.

Linux has since corrected this by introducing syscon-based bindings for
the MPFS mailbox and updating the mailbox driver to access the control
and interrupt registers via syscon/regmap. U-Boot, however, continued to
expect the legacy binding, causing mailbox access to fail when using
Linux-aligned devicetrees.

Update the U-Boot MPFS mailbox driver to support the new syscon-based
bindings by resolving the control and sysreg syscon nodes and accessing
the registers through regmap. Support for the legacy mailbox binding is
retained for backwards compatibility with existing firmware-provided
devicetrees.

This brings the U-Boot mailbox driver in line with the corrected hardware
description and matches the behavior of the Linux mailbox driver.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
Hi Tom,

Should this have the following fix tag?

Thanks,
Jamie.

Fixes: 5d401bfbdf1d ("Subtree merge tag 'v7.0-dts' of dts repo [1] into dts/upstream")
---
 drivers/mailbox/Kconfig     |  2 +
 drivers/mailbox/mpfs-mbox.c | 99 +++++++++++++++++++++++++++----------
 2 files changed, 74 insertions(+), 27 deletions(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index f45e611c966..1d9e284cfd1 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -32,6 +32,8 @@ config MPFS_MBOX
 	bool "Enable MPFS system controller support"
 	depends on DM_MAILBOX && ARCH_RV64I
 	select DEVRES
+	depends on SYSCON
+	depends on REGMAP
 	help
 	  Enable support for the mailboxes that provide a communication
 	  channel with the system controller integrated on PolarFire SoC.
diff --git a/drivers/mailbox/mpfs-mbox.c b/drivers/mailbox/mpfs-mbox.c
index 08c51c96718..b1ce377525e 100644
--- a/drivers/mailbox/mpfs-mbox.c
+++ b/drivers/mailbox/mpfs-mbox.c
@@ -13,19 +13,21 @@
 #include <dm/device-internal.h>
 #include <dm/device.h>
 #include <dm/device_compat.h>
-#include <dm/devres.h>
 #include <dm/ofnode.h>
 #include <linux/bitops.h>
 #include <linux/compat.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
+#include <linux/err.h>
+#include <linux/errno.h>
 #include <log.h>
 #include <mailbox-uclass.h>
-#include <malloc.h>
 #include <mpfs-mailbox.h>
+#include <regmap.h>
+#include <syscon.h>
 
 #define SERVICES_CR_OFFSET 0x50u
 #define SERVICES_SR_OFFSET 0x54u
+#define MESSAGE_INT_OFFSET 0x18cu
+#define MAILBOX_REG_OFFSET 0x800u
 
 #define SERVICE_CR_REQ_MASK 0x1u
 #define SERVICE_SR_BUSY_MASK 0x2u
@@ -35,8 +37,10 @@
 
 struct mpfs_mbox {
 	struct udevice *dev;
-	void __iomem *ctrl_base;
 	void __iomem *mbox_base;
+	void __iomem *int_reg;
+	struct regmap *control_scb;
+	struct regmap *sysreg_scb;
 };
 
 static bool mpfs_mbox_busy(struct mbox_chan *chan)
@@ -44,7 +48,7 @@ static bool mpfs_mbox_busy(struct mbox_chan *chan)
 	struct mpfs_mbox *mbox = dev_get_priv(chan->dev);
 	u32 status;
 
-	status = readl(mbox->ctrl_base + SERVICES_SR_OFFSET);
+	regmap_read(mbox->control_scb, SERVICES_SR_OFFSET, &status);
 
 	return status & SERVICE_SR_BUSY_MASK;
 }
@@ -79,14 +83,15 @@ static int mpfs_mbox_send(struct mbox_chan *chan, const void *data)
 
 	cmd_shifted = msg->cmd_opcode << SERVICE_CR_COMMAND_SHIFT;
 	cmd_shifted |= SERVICE_CR_REQ_MASK;
-	writel(cmd_shifted, mbox->ctrl_base + SERVICES_CR_OFFSET);
+
+	regmap_write(mbox->control_scb, SERVICES_CR_OFFSET, cmd_shifted);
 
 	do {
-		value = readl(mbox->ctrl_base + SERVICES_CR_OFFSET);
+		regmap_read(mbox->control_scb, SERVICES_CR_OFFSET, &value);
 	} while (SERVICE_CR_REQ_MASK == (value & SERVICE_CR_REQ_MASK));
 
 	do {
-		value = readl(mbox->ctrl_base + SERVICES_SR_OFFSET);
+		regmap_read(mbox->control_scb, SERVICES_SR_OFFSET, &value);
 	} while (SERVICE_SR_BUSY_MASK == (value & SERVICE_SR_BUSY_MASK));
 
 	msg->response->resp_status = (value >> SERVICE_SR_STATUS_SHIFT);
@@ -117,6 +122,11 @@ static int mpfs_mbox_recv(struct mbox_chan *chan, void *data)
 	for (idx = 0; idx < response->resp_size; idx++)
 		*((u8 *)(response->resp_msg) + idx) = readb(mbox->mbox_base + msg->resp_offset  + idx);
 
+	if (mbox->sysreg_scb)
+		regmap_write(mbox->sysreg_scb, MESSAGE_INT_OFFSET, 0);
+	else
+		writel_relaxed(0, mbox->int_reg);
+
 	return 0;
 }
 
@@ -125,36 +135,71 @@ static const struct mbox_ops mpfs_mbox_ops = {
 	.recv = mpfs_mbox_recv,
 };
 
-static int mpfs_mbox_probe(struct udevice *dev)
+/*
+ * Use global compatible lookup instead of phandles, as U-Boot may run
+ * with a reduced or firmware-provided device tree where mailbox syscon
+ * phandle properties are not guaranteed to be present.
+ */
+static int mpfs_mbox_syscon_probe(struct udevice *dev, struct mpfs_mbox *mbox)
 {
-	struct mpfs_mbox *mbox;
-	struct resource regs;
 	ofnode node;
-	int ret;
 
-	node = dev_ofnode(dev);
+	node = ofnode_by_compatible(ofnode_null(), "microchip,mpfs-control-scb");
+	if (!ofnode_valid(node))
+		return -ENODEV;
 
-	ret = ofnode_read_resource(node, 0, &regs);
-	if (ret) {
-		dev_err(dev, "No reg property for controller base\n");
-		return ret;
-	};
+	mbox->control_scb = syscon_node_to_regmap(node);
+	if (IS_ERR(mbox->control_scb))
+		return PTR_ERR(mbox->control_scb);
+
+	node = ofnode_by_compatible(ofnode_null(), "microchip,mpfs-sysreg-scb");
+	if (!ofnode_valid(node))
+		return -ENODEV;
+
+	mbox->sysreg_scb = syscon_node_to_regmap(node);
+	if (IS_ERR(mbox->sysreg_scb))
+		return PTR_ERR(mbox->sysreg_scb);
+
+	mbox->mbox_base = dev_read_addr_ptr(dev);
+	if (!mbox->mbox_base)
+		return -EINVAL;
+
+	return 0;
+}
 
-	mbox->ctrl_base = devm_ioremap(dev, res.start, resource_size(&res));
+static int mpfs_mbox_legacy_probe(struct udevice *dev, struct mpfs_mbox *mbox)
+{
+	int ret;
 
-	ret = ofnode_read_resource(node, 2, &regs);
-	if (ret) {
-		dev_err(dev, "No reg property for mailbox base\n");
+	ret = regmap_init_mem_index(dev_ofnode(dev), &mbox->control_scb, 0);
+	if (ret)
 		return ret;
-	};
 
-	mbox->mbox_base = devm_ioremap(dev, res.start, resource_size(&res));
+	mbox->mbox_base = dev_read_addr_index_ptr(dev, 2);
+	if (!mbox->mbox_base)
+		mbox->mbox_base = dev_read_addr_index_ptr(dev, 0) + MAILBOX_REG_OFFSET;
 
-	mbox->dev = dev;
+	mbox->int_reg = dev_read_addr_index_ptr(dev, 1);
+	if (!mbox->int_reg)
+		return -EINVAL;
 
 	return 0;
 }
 
+static int mpfs_mbox_probe(struct udevice *dev)
+{
+	struct mpfs_mbox *mbox = dev_get_priv(dev);
+	int ret;
+
+	mbox->dev = dev;
+
+	ret = mpfs_mbox_syscon_probe(dev, mbox);
+	if (!ret)
+		return 0;
+
+	return mpfs_mbox_legacy_probe(dev, mbox);
+}
+
 static const struct udevice_id mpfs_mbox_ids[] = {
 	{.compatible = "microchip,mpfs-mailbox"},
 	{ }
@@ -167,4 +212,4 @@ U_BOOT_DRIVER(mpfs_mbox) = {
 	.probe = mpfs_mbox_probe,
 	.priv_auto = sizeof(struct mpfs_mbox),
 	.ops = &mpfs_mbox_ops,
-};
+};
\ No newline at end of file
-- 
2.43.0

