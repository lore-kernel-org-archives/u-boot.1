Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68339CCD195
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 01:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B850183043;
	Mon, 20 Oct 2025 03:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="E3gC9kPj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 105B68334F; Mon, 20 Oct 2025 03:29:41 +0200 (CEST)
Received: from mail-m1973173.qiye.163.com (mail-m1973173.qiye.163.com
 [220.197.31.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79EE5807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 03:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shawn.lin@rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 266e49e77;
 Mon, 20 Oct 2025 09:29:32 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>, YiFeng Zhao <zyf@rock-chips.com>,
 u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>,
 Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/2] ufs: rockchip: Add initial support
Date: Mon, 20 Oct 2025 09:29:14 +0800
Message-Id: <1760923754-47718-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1760923754-47718-1-git-send-email-shawn.lin@rock-chips.com>
References: <1760923754-47718-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a99ff3c679c09cckunmb1003277433aa1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR1KGlZCS0xLTB5PHhodHkxWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=E3gC9kPjBYVCnPKs51h1duPfblP4Z+K9w0nfyhUqTDnzYCVX+LlAZohAGwSpUKbVS1WH+9p4ZY6znC3PuQJYXdu8is8rMzzsBkqt3g3Ktb+hupwxWs/aBLezadGGNgSeaDMH9O5Z7acsr6aoTQqvLaZUbEtme2fabfc5nCpwbqY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=h1e0qtCpKNTbsFjQ/68MSseLZceUJqCfupLFXhC1WxA=;
 h=date:mime-version:subject:message-id:from;
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

This patch adds initial support for UFS controller on Rockchip
platforms.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
Changes since v1:

- remove unused structures from header file
- correct U-Boot driver name

---
 MAINTAINERS                |   1 +
 drivers/ufs/Kconfig        |   9 ++
 drivers/ufs/Makefile       |   1 +
 drivers/ufs/ufs-rockchip.c | 211 +++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs-rockchip.h |  88 ++++++++++++++++
 5 files changed, 310 insertions(+)
 create mode 100644 drivers/ufs/ufs-rockchip.c
 create mode 100644 drivers/ufs/ufs-rockchip.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 671903605d1..ee4ab3711b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -575,6 +575,7 @@ F:	drivers/mmc/rockchip_dw_mmc.c
 F:	drivers/pinctrl/rockchip/
 F:	drivers/ram/rockchip/
 F:	drivers/sysreset/sysreset_rockchip.c
+F:	drivers/ufs/*rockchip*
 F:	drivers/video/rockchip/
 F:	tools/rkcommon.c
 F:	tools/rkcommon.h
diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index b08ca08b07c..3d367855173 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -33,6 +33,15 @@ config QCOM_UFS
 	  This selects the platform driver for the UFS host
 	  controller present on Qualcomm Snapdragon SoCs.
 
+config ROCKCHIP_UFS
+	bool "Rockchip specific hooks to UFS controller platform driver"
+	depends on UFS
+	help
+	  This selects the Rockchip specific additions to UFSHCD platform driver.
+
+	  Select this if you have UFS controller on Rockchip chipset.
+	  If unsure, say N.
+
 config TI_J721E_UFS
 	bool "Glue Layer driver for UFS on TI J721E devices"
 	help
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index 2a378e45111..41e910cfc51 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_QCOM_UFS) += ufs-qcom.o
 obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
 obj-$(CONFIG_UFS_PCI) += ufs-pci.o
 obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
+obj-$(CONFIG_ROCKCHIP_UFS) += ufs-rockchip.o
 obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
new file mode 100644
index 00000000000..c8578fae2c0
--- /dev/null
+++ b/drivers/ufs/ufs-rockchip.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Rockchip UFS Host Controller driver
+ *
+ * Copyright (C) 2025 Rockchip Electronics Co.Ltd.
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/ioport.h>
+#include <reset.h>
+#include <ufs.h>
+
+#include "ufs.h"
+#include "unipro.h"
+#include "ufs-rockchip.h"
+
+static int ufs_rockchip_hce_enable_notify(struct ufs_hba *hba,
+					  enum ufs_notify_change_status status)
+{
+	int err = 0;
+
+	if (status != POST_CHANGE)
+		return 0;
+
+	ufshcd_dme_reset(hba);
+	ufshcd_dme_enable(hba);
+
+	if (hba->ops->phy_initialization) {
+		err = hba->ops->phy_initialization(hba);
+		if (err)
+			dev_err(hba->dev,
+				"Phy init failed (%d)\n", err);
+	}
+
+	return err;
+}
+
+static void ufs_rockchip_rk3576_phy_parameter_init(struct ufs_hba *hba)
+{
+	struct ufs_rockchip_host *host = dev_get_priv(hba->dev);
+
+	ufs_sys_writel(host->mphy_base, 0x80, CMN_REG23);
+	ufs_sys_writel(host->mphy_base, 0xB5, TRSV0_REG14);
+	ufs_sys_writel(host->mphy_base, 0xB5, TRSV1_REG14);
+	ufs_sys_writel(host->mphy_base, 0x03, TRSV0_REG15);
+	ufs_sys_writel(host->mphy_base, 0x03, TRSV1_REG15);
+	ufs_sys_writel(host->mphy_base, 0x38, TRSV0_REG08);
+	ufs_sys_writel(host->mphy_base, 0x38, TRSV1_REG08);
+	ufs_sys_writel(host->mphy_base, 0x50, TRSV0_REG29);
+	ufs_sys_writel(host->mphy_base, 0x50, TRSV1_REG29);
+	ufs_sys_writel(host->mphy_base, 0x80, TRSV0_REG2E);
+	ufs_sys_writel(host->mphy_base, 0x80, TRSV1_REG2E);
+	ufs_sys_writel(host->mphy_base, 0x18, TRSV0_REG3C);
+	ufs_sys_writel(host->mphy_base, 0x18, TRSV1_REG3C);
+	ufs_sys_writel(host->mphy_base, 0x03, TRSV0_REG16);
+	ufs_sys_writel(host->mphy_base, 0x03, TRSV1_REG16);
+	ufs_sys_writel(host->mphy_base, 0x20, TRSV0_REG17);
+	ufs_sys_writel(host->mphy_base, 0x20, TRSV1_REG17);
+	ufs_sys_writel(host->mphy_base, 0xC0, TRSV0_REG18);
+	ufs_sys_writel(host->mphy_base, 0xC0, TRSV1_REG18);
+	ufs_sys_writel(host->mphy_base, 0x03, CMN_REG25);
+	ufs_sys_writel(host->mphy_base, 0x03, TRSV0_REG3D);
+	ufs_sys_writel(host->mphy_base, 0x03, TRSV1_REG3D);
+	ufs_sys_writel(host->mphy_base, 0xC0, CMN_REG23);
+	udelay(1);
+	ufs_sys_writel(host->mphy_base, 0x00, CMN_REG23);
+	udelay(200);
+}
+
+static int ufs_rockchip_rk3576_phy_init(struct ufs_hba *hba)
+{
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(PA_LOCAL_TX_LCC_ENABLE, 0x0), 0x0);
+	/* enable the mphy DME_SET cfg */
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(MPHY_CFG, 0x0), MPHY_CFG_ENABLE);
+	for (int i = 0; i < 2; i++) {
+		/* Configuration M-TX */
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_CLK_PRD, SEL_TX_LANE0 + i), 0x06);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_CLK_PRD_EN, SEL_TX_LANE0 + i), 0x02);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_LINERESET_VALUE, SEL_TX_LANE0 + i), 0x44);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_LINERESET_PVALUE1, SEL_TX_LANE0 + i), 0xe6);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_LINERESET_PVALUE2, SEL_TX_LANE0 + i), 0x07);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_TASE_VALUE, SEL_TX_LANE0 + i), 0x93);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_BASE_NVALUE, SEL_TX_LANE0 + i), 0xc9);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_POWER_SAVING_CTRL, SEL_TX_LANE0 + i), 0x00);
+		/* Configuration M-RX */
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_CLK_PRD, SEL_RX_LANE0 + i), 0x06);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_CLK_PRD_EN, SEL_RX_LANE0 + i), 0x00);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_LINERESET_VALUE, SEL_RX_LANE0 + i), 0x58);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_LINERESET_PVALUE1, SEL_RX_LANE0 + i), 0x8c);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_LINERESET_PVALUE2, SEL_RX_LANE0 + i), 0x02);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_LINERESET_OPTION, SEL_RX_LANE0 + i), 0xf6);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_POWER_SAVING_CTRL, SEL_RX_LANE0 + i), 0x69);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_SAVE_DET_CTRL, SEL_RX_LANE0 + i), 0x18);
+	}
+
+	/* disable the mphy DME_SET cfg */
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(MPHY_CFG, 0x0), MPHY_CFG_DISABLE);
+
+	ufs_rockchip_rk3576_phy_parameter_init(hba);
+
+	/* start link up */
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(MIB_T_DBG_CPORT_TX_ENDIAN, 0), 0x0);
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(MIB_T_DBG_CPORT_RX_ENDIAN, 0), 0x0);
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(N_DEVICEID, 0), 0x0);
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(N_DEVICEID_VALID, 0), 0x1);
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(T_PEERDEVICEID, 0), 0x1);
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(T_CONNECTIONSTATE, 0), 0x1);
+
+	return 0;
+}
+
+static int ufs_rockchip_common_init(struct ufs_hba *hba)
+{
+	struct udevice *dev = hba->dev;
+	struct ufs_rockchip_host *host = dev_get_priv(dev);
+	struct resource res;
+	int err = 0;
+
+	/* system control register for hci */
+	err = dev_read_resource_byname(dev, "hci_grf", &res);
+	if (err) {
+		dev_err(dev, "cannot ioremap for hci system control register\n");
+		return -ENODEV;
+	}
+	host->ufs_sys_ctrl = (void *)(res.start);
+
+	/* system control register for mphy */
+	err = dev_read_resource_byname(dev, "mphy_grf", &res);
+	if (err) {
+		dev_err(dev, "cannot ioremap for mphy system control register\n");
+		return -ENODEV;
+	}
+	host->ufs_phy_ctrl = (void *)(res.start);
+
+	/* mphy base register */
+	err = dev_read_resource_byname(dev, "mphy", &res);
+	if (err) {
+		dev_err(dev, "cannot ioremap for mphy base register\n");
+		return -ENODEV;
+	}
+	host->mphy_base = (void *)(res.start);
+
+	host->phy_config_mode = dev_read_u32_default(dev, "ufs-phy-config-mode", 0);
+
+	err = reset_get_bulk(dev, &host->rsts);
+	if (err) {
+		dev_err(dev, "Can't get reset: %d\n", err);
+		return err;
+	}
+
+	host->hba = hba;
+
+	return 0;
+}
+
+static int ufs_rockchip_rk3576_init(struct ufs_hba *hba)
+{
+	int ret = 0;
+
+	ret = ufs_rockchip_common_init(hba);
+	if (ret) {
+		dev_err(hba->dev, "%s: ufs common init fail\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct ufs_hba_ops ufs_hba_rk3576_vops = {
+	.init = ufs_rockchip_rk3576_init,
+	.phy_initialization = ufs_rockchip_rk3576_phy_init,
+	.hce_enable_notify = ufs_rockchip_hce_enable_notify,
+};
+
+static const struct udevice_id ufs_rockchip_of_match[] = {
+	{ .compatible = "rockchip,rk3576-ufshc", .data = (ulong)&ufs_hba_rk3576_vops},
+	{},
+};
+
+static int ufs_rockchip_probe(struct udevice *dev)
+{
+	struct ufs_hba_ops *ops = (struct ufs_hba_ops *)dev_get_driver_data(dev);
+	int err;
+
+	err = ufshcd_probe(dev, ops);
+	if (err)
+		dev_err(dev, "ufshcd_pltfrm_init() failed %d\n", err);
+
+	return err;
+}
+
+static int ufs_rockchip_bind(struct udevice *dev)
+{
+	struct udevice *scsi_dev;
+
+	return ufs_scsi_bind(dev, &scsi_dev);
+}
+
+U_BOOT_DRIVER(rockchip_ufs) = {
+	.name		= "ufshcd-rockchip",
+	.id		= UCLASS_UFS,
+	.of_match	= ufs_rockchip_of_match,
+	.probe		= ufs_rockchip_probe,
+	.bind		= ufs_rockchip_bind,
+	.priv_auto	= sizeof(struct ufs_rockchip_host),
+};
diff --git a/drivers/ufs/ufs-rockchip.h b/drivers/ufs/ufs-rockchip.h
new file mode 100644
index 00000000000..b6d44dcc4b3
--- /dev/null
+++ b/drivers/ufs/ufs-rockchip.h
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Rockchip UFS Host Controller driver
+ *
+ * Copyright (C) 2025 Rockchip Electronics Co.Ltd.
+ */
+
+#ifndef _UFS_ROCKCHIP_H_
+#define _UFS_ROCKCHIP_H_
+
+#define UFS_MAX_CLKS 3
+
+#define SEL_TX_LANE0			0x0
+#define SEL_TX_LANE1			0x1
+#define SEL_TX_LANE2			0x2
+#define SEL_TX_LANE3			0x3
+#define SEL_RX_LANE0			0x4
+#define SEL_RX_LANE1			0x5
+#define SEL_RX_LANE2			0x6
+#define SEL_RX_LANE3			0x7
+
+#define VND_TX_CLK_PRD                  0xAA
+#define VND_TX_CLK_PRD_EN               0xA9
+#define VND_TX_LINERESET_PVALUE2        0xAB
+#define VND_TX_LINERESET_PVALUE1        0xAC
+#define VND_TX_LINERESET_VALUE          0xAD
+#define VND_TX_BASE_NVALUE              0x93
+#define VND_TX_TASE_VALUE               0x94
+#define VND_TX_POWER_SAVING_CTRL        0x7F
+#define VND_RX_CLK_PRD                  0x12
+#define VND_RX_CLK_PRD_EN               0x11
+#define VND_RX_LINERESET_PVALUE2        0x1B
+#define VND_RX_LINERESET_PVALUE1        0x1C
+#define VND_RX_LINERESET_VALUE          0x1D
+#define VND_RX_LINERESET_OPTION         0x25
+#define VND_RX_POWER_SAVING_CTRL        0x2F
+#define VND_RX_SAVE_DET_CTRL            0x1E
+
+#define CMN_REG23                       0x8C
+#define CMN_REG25                       0x94
+#define TRSV0_REG08                     0xE0
+#define TRSV1_REG08                     0x220
+#define TRSV0_REG14                     0x110
+#define TRSV1_REG14                     0x250
+#define TRSV0_REG15                     0x134
+#define TRSV1_REG15                     0x274
+#define TRSV0_REG16                     0x128
+#define TRSV1_REG16                     0x268
+#define TRSV0_REG17                     0x12C
+#define TRSV1_REG17                     0x26c
+#define TRSV0_REG18                     0x120
+#define TRSV1_REG18                     0x260
+#define TRSV0_REG29                     0x164
+#define TRSV1_REG29                     0x2A4
+#define TRSV0_REG2E                     0x178
+#define TRSV1_REG2E                     0x2B8
+#define TRSV0_REG3C                     0x1B0
+#define TRSV1_REG3C                     0x2F0
+#define TRSV0_REG3D                     0x1B4
+#define TRSV1_REG3D                     0x2F4
+
+#define MPHY_CFG                        0x200
+#define MPHY_CFG_ENABLE                 0x40
+#define MPHY_CFG_DISABLE                0x0
+
+#define MIB_T_DBG_CPORT_TX_ENDIAN	0xc022
+#define MIB_T_DBG_CPORT_RX_ENDIAN	0xc023
+
+struct ufs_rockchip_host {
+	struct ufs_hba *hba;
+	void __iomem *ufs_phy_ctrl;
+	void __iomem *ufs_sys_ctrl;
+	void __iomem *mphy_base;
+	struct reset_ctl_bulk rsts;
+	struct clk ref_out_clk;
+	uint64_t caps;
+	uint32_t phy_config_mode;
+};
+
+#define ufs_sys_writel(base, val, reg)	\
+	writel((val), (base) + (reg))
+#define ufs_sys_readl(base, reg) readl((base) + (reg))
+#define ufs_sys_set_bits(base, mask, reg)	\
+	ufs_sys_writel((base), ((mask) | (ufs_sys_readl((base), (reg)))), (reg))
+#define ufs_sys_ctrl_clr_bits(base, mask, reg)	\
+	ufs_sys_writel((base), ((~(mask)) & (ufs_sys_readl((base), (reg)))), (reg))
+
+#endif /* _UFS_ROCKCHIP_H_ */
-- 
2.43.0

