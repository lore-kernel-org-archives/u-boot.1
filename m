Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEA8C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42777883DC;
	Wed,  5 Jun 2024 21:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hQOqBNt7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01A2188096; Wed,  5 Jun 2024 21:03:44 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEF228825E
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-421392b8156so2201425e9.3
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717614221; x=1718219021; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kAchuuqYasjbhcIK8f5QyboGfJdVtxSSRcXm0nlSPoQ=;
 b=hQOqBNt7rtcg8jenVPCpzZZ0ECILp+FuJ1WsmWNEThE7FazIh/lsZUZONxbBX8RYA7
 7BuCfkRJAimEnr8qs/2xbo8MLjTL1tZLHOTgxq+VMD+zELHa8Bgp//LCCB2o+Sn3F/US
 HHVx35nzqK01QVT0IH9U3NW3/lpwnJdIXAc9gIZqDVUwP7z/fkyFLx+4GU7i4wE9d5F/
 FqczpiXooP6p+MqV5ICHHeIt3BIU0K8Q5hq8YwlbD90JEkrDXXv20PmBu+ZpIdv0LUWa
 7vCGWlXpXlfktawtsnDEmB23UEij1HwisSVDL3kFiSetFBKEctc9Majj3ivmnYmGjlbK
 E8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717614221; x=1718219021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kAchuuqYasjbhcIK8f5QyboGfJdVtxSSRcXm0nlSPoQ=;
 b=NJWOZB85jJdqO8LqFiMhAUVJJEM77Nff9jxTXBqcWYk39aYO2+IrdBXlu0enHjxAbs
 AMRJ7DDyCwGeFGtJMLr2b/5/OLRXmVxXyPQpCzKT4guMzht7qnhCXy4t5PXkjq6tGg3M
 TWE+iU7EJBjMuvQde3Zu+NPXHGIIS1LdfwndoWcsqj2+KHoWLWW5IZlWDTiDQcdErYIN
 xtMnNhW6NHkNaQK8h+FR4tW/DinDxnkyumojoAgTA27zrc49zLbGfi96LQCHL4ukweuh
 /1yf/cxoYGMf4QmcC9EEZBy8tmupwV5gr53xlu9vcn5QiHHmt21q4Gc+oxVLhFjh6zf8
 upbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLwXZqBEAmMu5dz9dRMLlxqMtw2+tJKVKKwLv2QEIJ0EqshNCsZ1xyCDBDXeyryDiFaMUJFONLnPA8Ol/DGD4ZBuOjqA==
X-Gm-Message-State: AOJu0YzhftVQq4/fsHnM7gXzCk6bObklAPjXcQhpkI4NHSXRcqUIdAYQ
 6CAcddKz/iWYKGGGLN6YCTMB+I1gedtqvs/mGMv1X4HY+KJi7ZkJ
X-Google-Smtp-Source: AGHT+IEKomzD62O7CtHH8RliVjEHPeVEYPpz3sc0pIIhifeZ/7DU9Wt037Yb010O0U89p9v8n9mhnA==
X-Received: by 2002:a05:600c:4fd3:b0:41b:855b:5d26 with SMTP id
 5b1f17b1804b1-421562c2773mr28879355e9.2.1717614221052; 
 Wed, 05 Jun 2024 12:03:41 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214a4abdd5sm44772195e9.0.2024.06.05.12.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:03:40 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 Francois Berder <fberder@outlook.fr>, Simon Glass <sjg@chromium.org>,
 Julien Masson <jmasson@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Michal Simek <michal.simek@amd.com>, John Crispin <john@phrozen.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mason Huo <mason.huo@starfivetech.com>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Sergei Antonov <saproj@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 02/11] pci: mediatek: add PCIe controller support for filogic
 silicon
Date: Wed,  5 Jun 2024 21:02:09 +0200
Message-ID: <20240605190220.17616-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605190220.17616-1-ansuelsmth@gmail.com>
References: <20240605190220.17616-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 21:37:35 +0200
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

From: John Crispin <john@phrozen.org>

Add MediaTek GEN3 PCIe controller support for filogic silicon.
This is adapted from the Linux version of the driver.

Signed-off-by: John Crispin <john@phrozen.org>
[ fix minor problems, fix checkpatch errors ]
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pci/Kconfig              |   7 +
 drivers/pci/Makefile             |   1 +
 drivers/pci/pcie_mediatek_gen3.c | 382 +++++++++++++++++++++++++++++++
 3 files changed, 390 insertions(+)
 create mode 100644 drivers/pci/pcie_mediatek_gen3.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 8d02ab82ad9..22a56f4ca38 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -350,6 +350,13 @@ config PCIE_MEDIATEK
 	  Say Y here if you want to enable Gen2 PCIe controller,
 	  which could be found on MT7623 SoC family.
 
+config PCIE_MEDIATEK_GEN3
+	bool "MediaTek PCIe Gen3 controller"
+	depends on ARCH_MEDIATEK
+	help
+	  Say Y here if you want to enable Gen3 PCIe controller,
+	  which could be found on the Mediatek Filogic SoC family.
+
 config PCIE_DW_MESON
 	bool "Amlogic Meson DesignWare based PCIe controller"
 	depends on ARCH_MESON
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 2927c519129..5b2d2969802 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_PCIE_INTEL_FPGA) += pcie_intel_fpga.o
 obj-$(CONFIG_PCIE_DW_COMMON) += pcie_dw_common.o
 obj-$(CONFIG_PCI_KEYSTONE) += pcie_dw_ti.o
 obj-$(CONFIG_PCIE_MEDIATEK) += pcie_mediatek.o
+obj-$(CONFIG_PCIE_MEDIATEK_GEN3) += pcie_mediatek_gen3.o
 obj-$(CONFIG_PCIE_ROCKCHIP) += pcie_rockchip.o
 obj-$(CONFIG_PCIE_DW_ROCKCHIP) += pcie_dw_rockchip.o
 obj-$(CONFIG_PCIE_DW_MESON) += pcie_dw_meson.o
diff --git a/drivers/pci/pcie_mediatek_gen3.c b/drivers/pci/pcie_mediatek_gen3.c
new file mode 100644
index 00000000000..673813b8b75
--- /dev/null
+++ b/drivers/pci/pcie_mediatek_gen3.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MediaTek PCIe host controller driver.
+ *
+ * Copyright (c) 2023 John Crispin <john@phrozen.org>
+ * Driver is based on u-boot gen1/2 and upstream linux gen3 code
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <generic-phy.h>
+#include <log.h>
+#include <malloc.h>
+#include <pci.h>
+#include <reset.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <linux/bitops.h>
+#include <linux/iopoll.h>
+#include <linux/list.h>
+#include "pci_internal.h"
+
+/* PCIe shared registers */
+#define PCIE_CFG_ADDR			0x20
+#define PCIE_CFG_DATA			0x24
+
+#define PCIE_SETTING_REG		0x80
+
+#define PCIE_PCI_IDS_1			0x9c
+#define PCIE_RC_MODE			BIT(0)
+#define PCI_CLASS(class)		((class) << 8)
+
+#define PCIE_CFGNUM_REG			0x140
+#define PCIE_CFG_DEVFN(devfn)		((devfn) & GENMASK(7, 0))
+#define PCIE_CFG_BUS(bus)		(((bus) << 8) & GENMASK(15, 8))
+#define PCIE_CFG_BYTE_EN(bytes)		(((bytes) << 16) & GENMASK(19, 16))
+#define PCIE_CFG_FORCE_BYTE_EN		BIT(20)
+#define PCIE_CFG_OFFSET_ADDR		0x1000
+#define PCIE_CFG_HEADER(bus, devfn)	(PCIE_CFG_BUS(bus) | PCIE_CFG_DEVFN(devfn))
+
+#define PCIE_RST_CTRL_REG		0x148
+#define PCIE_MAC_RSTB			BIT(0)
+#define PCIE_PHY_RSTB			BIT(1)
+#define PCIE_BRG_RSTB			BIT(2)
+#define PCIE_PE_RSTB			BIT(3)
+
+#define PCIE_LINK_STATUS_REG		0x154
+#define PCIE_PORT_LINKUP		BIT(8)
+
+#define PCIE_INT_ENABLE_REG		0x180
+
+#define PCIE_MISC_CTRL_REG		0x348
+#define PCIE_DISABLE_DVFSRC_VLT_REQ	BIT(1)
+
+#define PCIE_TRANS_TABLE_BASE_REG       0x800
+#define PCIE_ATR_SRC_ADDR_MSB_OFFSET    0x4
+#define PCIE_ATR_TRSL_ADDR_LSB_OFFSET   0x8
+#define PCIE_ATR_TRSL_ADDR_MSB_OFFSET   0xc
+#define PCIE_ATR_TRSL_PARAM_OFFSET      0x10
+#define PCIE_ATR_TLB_SET_OFFSET         0x20
+
+#define PCIE_MAX_TRANS_TABLES           8
+#define PCIE_ATR_EN                     BIT(0)
+#define PCIE_ATR_SIZE(size) \
+	(((((size) - 1) << 1) & GENMASK(6, 1)) | PCIE_ATR_EN)
+#define PCIE_ATR_ID(id)                 ((id) & GENMASK(3, 0))
+#define PCIE_ATR_TYPE_MEM               PCIE_ATR_ID(0)
+#define PCIE_ATR_TYPE_IO                PCIE_ATR_ID(1)
+#define PCIE_ATR_TLP_TYPE(type)         (((type) << 16) & GENMASK(18, 16))
+#define PCIE_ATR_TLP_TYPE_MEM           PCIE_ATR_TLP_TYPE(0)
+#define PCIE_ATR_TLP_TYPE_IO            PCIE_ATR_TLP_TYPE(2)
+
+struct mtk_pcie {
+	void __iomem *base;
+	void *priv;
+	struct clk pl_250m_ck;
+	struct clk tl_26m_ck;
+	struct clk peri_26m_ck;
+	struct clk top_133m_ck;
+	struct reset_ctl reset_phy;
+	struct reset_ctl reset_mac;
+	struct phy phy;
+};
+
+static void mtk_pcie_config_tlp_header(const struct udevice *bus,
+				       pci_dev_t devfn,
+				       int where, int size)
+{
+	struct mtk_pcie *pcie = dev_get_priv(bus);
+	int bytes;
+	u32 val;
+
+	size = 1 << size;
+	bytes = (GENMASK(size - 1, 0) & 0xf) << (where & 0x3);
+
+	val = PCIE_CFG_FORCE_BYTE_EN | PCIE_CFG_BYTE_EN(bytes) |
+	      PCIE_CFG_HEADER(PCI_BUS(devfn), (devfn >> 8));
+
+	writel(val, pcie->base + PCIE_CFGNUM_REG);
+}
+
+static int mtk_pcie_config_address(const struct udevice *udev, pci_dev_t bdf,
+				   uint offset, void **paddress)
+{
+	struct mtk_pcie *pcie = dev_get_priv(udev);
+
+	*paddress = pcie->base + PCIE_CFG_OFFSET_ADDR + offset;
+
+	return 0;
+}
+
+static int mtk_pcie_read_config(const struct udevice *bus, pci_dev_t bdf,
+				uint offset, ulong *valuep,
+				enum pci_size_t size)
+{
+	int ret;
+
+	mtk_pcie_config_tlp_header(bus, bdf, offset, size);
+	ret = pci_generic_mmap_read_config(bus, mtk_pcie_config_address,
+					   bdf, offset, valuep, size);
+	return ret;
+}
+
+static int mtk_pcie_write_config(struct udevice *bus, pci_dev_t bdf,
+				 uint offset, ulong value,
+				 enum pci_size_t size)
+{
+	mtk_pcie_config_tlp_header(bus, bdf, offset, size);
+
+	switch (size) {
+	case PCI_SIZE_8:
+	case PCI_SIZE_16:
+		value <<= (offset & 0x3) * 8;
+	case PCI_SIZE_32:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return pci_generic_mmap_write_config(bus, mtk_pcie_config_address,
+					     bdf, (offset & ~0x3), value, PCI_SIZE_32);
+}
+
+static const struct dm_pci_ops mtk_pcie_ops = {
+	.read_config	= mtk_pcie_read_config,
+	.write_config	= mtk_pcie_write_config,
+};
+
+static int mtk_pcie_set_trans_table(struct udevice *dev, struct mtk_pcie *pcie,
+				    u64 cpu_addr, u64 pci_addr, u64 size,
+				    unsigned long type, int num)
+{
+	void __iomem *table;
+	u32 val;
+
+	if (num >= PCIE_MAX_TRANS_TABLES) {
+		dev_err(dev, "not enough translate table for addr: %#llx, limited to [%d]\n",
+			(unsigned long long)cpu_addr, PCIE_MAX_TRANS_TABLES);
+		return -ENODEV;
+	}
+
+	dev_dbg(dev, "set trans table %d: %#llx %#llx, %#llx\n", num, cpu_addr,
+		pci_addr, size);
+	table = pcie->base + PCIE_TRANS_TABLE_BASE_REG +
+		num * PCIE_ATR_TLB_SET_OFFSET;
+
+	writel(lower_32_bits(cpu_addr) | PCIE_ATR_SIZE(fls(size) - 1), table);
+	writel(upper_32_bits(cpu_addr), table + PCIE_ATR_SRC_ADDR_MSB_OFFSET);
+	writel(lower_32_bits(pci_addr), table + PCIE_ATR_TRSL_ADDR_LSB_OFFSET);
+	writel(upper_32_bits(pci_addr), table + PCIE_ATR_TRSL_ADDR_MSB_OFFSET);
+
+	if (type == PCI_REGION_IO)
+		val = PCIE_ATR_TYPE_IO | PCIE_ATR_TLP_TYPE_IO;
+	else
+		val = PCIE_ATR_TYPE_MEM | PCIE_ATR_TLP_TYPE_MEM;
+	writel(val, table + PCIE_ATR_TRSL_PARAM_OFFSET);
+
+	return 0;
+}
+
+static int mtk_pcie_startup_port(struct udevice *dev)
+{
+	struct mtk_pcie *pcie = dev_get_priv(dev);
+	struct udevice *ctlr = pci_get_controller(dev);
+	struct pci_controller *hose = dev_get_uclass_priv(ctlr);
+	u32 val;
+	int i, err;
+
+	/* Set as RC mode */
+	val = readl(pcie->base + PCIE_SETTING_REG);
+	val |= PCIE_RC_MODE;
+	writel(val, pcie->base + PCIE_SETTING_REG);
+
+	/* setup RC BARs */
+	writel(PCI_BASE_ADDRESS_MEM_TYPE_64,
+	       pcie->base + PCI_BASE_ADDRESS_0);
+	writel(0x0, pcie->base + PCI_BASE_ADDRESS_1);
+
+	/* setup interrupt pins */
+	clrsetbits_le32(pcie->base + PCI_INTERRUPT_LINE,
+			0xff00, 0x100);
+
+	/* setup bus numbers */
+	clrsetbits_le32(pcie->base + PCI_PRIMARY_BUS,
+			0xffffff, 0x00ff0100);
+
+	/* setup command register */
+	clrsetbits_le32(pcie->base + PCI_PRIMARY_BUS,
+			0xffff,
+			PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
+			PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
+
+	/* Set class code */
+	val = readl(pcie->base + PCIE_PCI_IDS_1);
+	val &= ~GENMASK(31, 8);
+	val |= PCI_CLASS(PCI_CLASS_BRIDGE_PCI << 8);
+	writel(val, pcie->base + PCIE_PCI_IDS_1);
+
+	/* Mask all INTx interrupts */
+	val = readl(pcie->base + PCIE_INT_ENABLE_REG);
+	val &= ~0xFF000000;
+	writel(val, pcie->base + PCIE_INT_ENABLE_REG);
+
+	/* Disable DVFSRC voltage request */
+	val = readl(pcie->base + PCIE_MISC_CTRL_REG);
+	val |= PCIE_DISABLE_DVFSRC_VLT_REQ;
+	writel(val, pcie->base + PCIE_MISC_CTRL_REG);
+
+	/* Assert all reset signals */
+	val = readl(pcie->base + PCIE_RST_CTRL_REG);
+	val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
+	writel(val, pcie->base + PCIE_RST_CTRL_REG);
+
+	/*
+	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
+	 * and 2.2.1 (Initial Power-Up (G3 to S0)).
+	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
+	 * for the power and clock to become stable.
+	 */
+	mdelay(100);
+
+	/* De-assert reset signals */
+	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB);
+	writel(val, pcie->base + PCIE_RST_CTRL_REG);
+
+	mdelay(100);
+
+	/* De-assert PERST# signals */
+	val &= ~(PCIE_PE_RSTB);
+	writel(val, pcie->base + PCIE_RST_CTRL_REG);
+
+	/* 100ms timeout value should be enough for Gen1/2 training */
+	err = readl_poll_timeout(pcie->base + PCIE_LINK_STATUS_REG, val,
+				 !!(val & PCIE_PORT_LINKUP),
+				 100 * 1000);
+	if (err) {
+		dev_dbg(dev, "no card detected\n");
+		return -ETIMEDOUT;
+	}
+	dev_dbg(dev, "detected a card\n");
+
+	for (i = 0; i < hose->region_count; i++) {
+		struct pci_region *reg = &hose->regions[i];
+
+		if (reg->flags != PCI_REGION_MEM)
+			continue;
+
+		mtk_pcie_set_trans_table(dev, pcie, reg->bus_start, reg->phys_start,
+					 reg->size, reg->flags, 0);
+	}
+
+	return 0;
+}
+
+static int mtk_pcie_power_on(struct udevice *dev)
+{
+	struct mtk_pcie *pcie = dev_get_priv(dev);
+	int err;
+
+	pcie->base = dev_remap_addr_name(dev, "pcie-mac");
+	if (!pcie->base)
+		return -ENOENT;
+
+	pcie->priv = dev;
+
+	err = generic_phy_get_by_name(dev, "pcie-phy", &pcie->phy);
+	if (err)
+		return err;
+
+	/*
+	 * Upstream linux kernel devine these clock without clock-names
+	 * and use clk bulk API to enable them all.
+	 */
+	err = clk_get_by_index(dev, 0, &pcie->pl_250m_ck);
+	if (err)
+		return err;
+
+	err = clk_get_by_index(dev, 1, &pcie->tl_26m_ck);
+	if (err)
+		return err;
+
+	err = clk_get_by_index(dev, 2, &pcie->peri_26m_ck);
+	if (err)
+		return err;
+
+	err = clk_get_by_index(dev, 3, &pcie->top_133m_ck);
+	if (err)
+		return err;
+
+	err = generic_phy_init(&pcie->phy);
+	if (err)
+		return err;
+
+	err = generic_phy_power_on(&pcie->phy);
+	if (err)
+		goto err_phy_on;
+
+	err = clk_enable(&pcie->pl_250m_ck);
+	if (err)
+		goto err_clk_pl_250m;
+
+	err = clk_enable(&pcie->tl_26m_ck);
+	if (err)
+		goto err_clk_tl_26m;
+
+	err = clk_enable(&pcie->peri_26m_ck);
+	if (err)
+		goto err_clk_peri_26m;
+
+	err = clk_enable(&pcie->top_133m_ck);
+	if (err)
+		goto err_clk_top_133m;
+
+	err = mtk_pcie_startup_port(dev);
+	if (err)
+		goto err_startup;
+
+	return 0;
+
+err_startup:
+err_clk_top_133m:
+	clk_disable(&pcie->top_133m_ck);
+err_clk_peri_26m:
+	clk_disable(&pcie->peri_26m_ck);
+err_clk_tl_26m:
+	clk_disable(&pcie->tl_26m_ck);
+err_clk_pl_250m:
+	clk_disable(&pcie->pl_250m_ck);
+err_phy_on:
+	generic_phy_exit(&pcie->phy);
+
+	return err;
+}
+
+static int mtk_pcie_probe(struct udevice *dev)
+{
+	struct mtk_pcie *pcie = dev_get_priv(dev);
+	int err;
+
+	pcie->priv = dev;
+
+	err = mtk_pcie_power_on(dev);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static const struct udevice_id mtk_pcie_ids[] = {
+	{ .compatible = "mediatek,mt8192-pcie" },
+	{ }
+};
+
+U_BOOT_DRIVER(pcie_mediatek_gen3) = {
+	.name		= "pcie_mediatek_gen3",
+	.id		= UCLASS_PCI,
+	.of_match	= mtk_pcie_ids,
+	.ops		= &mtk_pcie_ops,
+	.probe		= mtk_pcie_probe,
+	.priv_auto	= sizeof(struct mtk_pcie),
+};
-- 
2.43.0

