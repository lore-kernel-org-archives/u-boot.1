Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0490BC43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 13:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C511847C8;
	Sun,  5 Jul 2026 15:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="SOYLGg6b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55BE9847C8; Sun,  5 Jul 2026 15:07:28 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE073846F8
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 15:07:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cc84e77e78so3345795ad.2
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 06:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783256844; x=1783861644;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ohVnJD0I0LmF/141N728BIl6XD4o/rcsFHZEAh2u9D8=;
 b=SOYLGg6bBhmoiQlORDZHDOwfjPo3VGTWp+MD+8XKxuj8+byWIsCsiYCuzkeq3T8eGn
 6C6eM4BclUqe22KfAvCV+5T0xhUGyt0naEJtZr8Ie8dWnfLlkiB8aqvSdtz+R48BwJ+w
 52fIFmV07KTK5pBBoBFOCPY2koAsB++1ybjAeLCDZ6eZccti/8uRUbvdAbR7ntpH04do
 +zKef3BSg1fXo9ZnoX3Wn4jw6RzP4ef1ZEd9pfpPNc620aiDHpdBNFyNrW1LD38sPAe/
 Saix8/5WMV6k5AXQwemSbYBLmL87luWOVRubLUhhXolNBUrQvC6Vr1f8prE/0kaJ/XlD
 Dtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783256844; x=1783861644;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ohVnJD0I0LmF/141N728BIl6XD4o/rcsFHZEAh2u9D8=;
 b=ZrEBfzbp10yEeGEMGmxbhZyL2ZI+toAJ8e/SgAZY1/SsNsoPtlb+3cXJeXmK3R5Pk3
 ajqcvlJajStqvYTTs3x/pQs9+wJ7B3VifDmID/A3VYxJt1Qgpi9frLvKmSGd5GYrIX0T
 pAZX43YCubU1OfKjxYFmrF73bOF2ZP2RLyujlzEWTmSgv4/++2W7gOiG/r7Uhv2H1QJT
 8+qUjXnbajB51OLo6mydHd8+dbh8oalOiYfW7eFBQCU9yx08fLB6pT/+vqdVWLxf6eMb
 5E7U9IMqK+Hul/tnR1QFRGjeDycihdfTGkTW/egjF9i/+S7kY+P2tFquEFT+jIjv3uWm
 JHhg==
X-Gm-Message-State: AOJu0YycaXslDoRZ3emIoElwXARrMZt9ls0G73bFvIW+0kHcLnNWbmrt
 WAI/YLOwj8a2TUBgfKcAIXoQRFEcxwlreslHK8UvtJVquU8k9/7Xj/0t+uy1YbfqcnA=
X-Gm-Gg: AfdE7cmnaEKgHKLeuIQz7zlsim6RpUchPxGw2EaJhJYySqLZbpXS091Wj6iNFkOPuFY
 dlqWjmzXI/4sAoIJJ0q5kvcsgBiBCD/cByZGdPi+Ksfu91HW0JEB9nlyO42G0sAofpB8KyFHxaF
 bh0sT9B6jF3XwYWudCdN/zZXS+Mn2dryuYd23e6Lmaph85snAO/DgmI1J5yQGscQmyn0ZmHpyYA
 rZJO0Ux/uMenMEwdvsIk5Jn8sm+ri6vepPPYnGn+4upACQS8kTW/XqTeNRTbLsfFWPV8KzQKwRt
 9KjIFCVU/yNqmfmFYzLLwPC6utl2pyY2dXidG5MN0C6igk/iwrlYCUQ7tsenX8Z41kWMbg8FSEk
 OKUweuFNY3qnM1twAfciBgNcOfDD8VQV+/WjXFle0kPVxcLaI2Vo5cmKtMyI3JupPtfGRklZ5dd
 gYHxOjjoVA0mQnIr1EzdFwKyHWobKjNtCQh4IWKY0751v1MSPTIkyFerVjpKr9sod/3ORo4eHlh
 x5kxJNs3FLFMp9Pig6Xqi2jcMMZL1EdVU3Ba0SeGGSGXH199vhz
X-Received: by 2002:a17:903:b8f:b0:2c9:cf41:adf9 with SMTP id
 d9443c01a7336-2cbb9f0eb2amr65493765ad.47.1783256844031; 
 Sun, 05 Jul 2026 06:07:24 -0700 (PDT)
Received: from [127.0.1.1] ([120.204.57.249]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad71458f6sm34272305ad.32.2026.07.05.06.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 06:07:23 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 05 Jul 2026 21:06:28 +0800
Subject: [PATCH 2/3] pci: spacemit: add DesignWare PCIe host controller driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-pci-v1-2-beca83440a27@riscstar.com>
References: <20260705-pci-v1-0-beca83440a27@riscstar.com>
In-Reply-To: <20260705-pci-v1-0-beca83440a27@riscstar.com>
To: u-boot@lists.denx.de, u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Alice Guo <alice.guo@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Pranav Sanwal <pranav.sanwal@amd.com>, Ye Li <ye.li@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong.xu@riscstar.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

Add PCIe host controller driver for Spacemit K1 SoC using the
Synopsys DesignWare PCIe core. Supports up to 3 ports.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
 drivers/pci/Kconfig            |   7 +
 drivers/pci/Makefile           |   1 +
 drivers/pci/pcie_dw_spacemit.c | 383 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie_dw_spacemit.h |  78 +++++++++
 4 files changed, 469 insertions(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 9ffccc3a80b..688f5eee571 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -478,4 +478,11 @@ config PCIE_DW_IMX
 	  Say Y here if you want to enable DW PCIe controller support on
 	  iMX SoCs.
 
+config PCIE_DW_SPACEMIT
+	bool "Enable Spacemit K1 PCIe"
+	select PCIE_DW_COMMON
+	help
+	  Say Y here if you want to enable PCIe controller support on
+	  K1 SoC.
+
 endif
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index e6d71fd172b..80b1ac04195 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -58,3 +58,4 @@ obj-$(CONFIG_PCIE_PLDA_COMMON) += pcie_plda_common.o
 obj-$(CONFIG_PCIE_STARFIVE_JH7110) += pcie_starfive_jh7110.o
 obj-$(CONFIG_PCIE_DW_AMD) += pcie_dw_amd.o
 obj-$(CONFIG_PCIE_DW_IMX) += pcie_dw_imx.o
+obj-$(CONFIG_PCIE_DW_SPACEMIT) += pcie_dw_spacemit.o
diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemit.c
new file mode 100644
index 00000000000..037b08cfe86
--- /dev/null
+++ b/drivers/pci/pcie_dw_spacemit.c
@@ -0,0 +1,383 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Spacemit K1 PCIe host controller driver
+ *
+ * Copyright (c) 2023, Spacemit Corporation.
+ * Copyright (c) 2026, RISCstar Ltd.
+ *
+ */
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm-generic/gpio.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/ofnode.h>
+#include <dm/read.h>
+#include <generic-phy.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <log.h>
+#include <pci.h>
+#include <power-domain.h>
+#include <reset.h>
+
+#include "pcie_dw_common.h"
+#include "pcie_dw_spacemit.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+struct pcie_dw_spacemit {
+	/* Must be first member of the struct */
+	struct pcie_dw dw;
+	void __iomem		*apmu_base;
+	u32			apmu_offset;
+	void __iomem		*phy_ahb;	/* DT "link" */
+	int			port_id;
+
+	/* reset, clock resources */
+	struct clk_bulk		clks;
+	struct reset_ctl_bulk	rsts;
+	struct gpio_desc		pwr_on_gpio;
+	int			power_on_status;
+};
+
+static inline u32 spacemit_pcie_readl(struct pcie_dw_spacemit *pcie, u32 offset)
+{
+	return readl(pcie->apmu_base + pcie->apmu_offset + offset);
+}
+
+static inline void spacemit_pcie_writel(struct pcie_dw_spacemit *pcie,
+					u32 offset, u32 value)
+{
+	writel(value, pcie->apmu_base + pcie->apmu_offset + offset);
+}
+
+static inline u32 spacemit_pcie_phy_ahb_readl(struct pcie_dw_spacemit *pcie, u32 offset)
+{
+	return readl(pcie->phy_ahb + offset);
+}
+
+static void pcie_dw_configure(struct pcie_dw_spacemit *pci, u32 cap_speed)
+{
+	u32 val;
+
+	dw_pcie_dbi_write_enable(&pci->dw, true);
+
+	val = readl(pci->dw.dbi_base + PCIE_LINK_CAPABILITY);
+	val &= ~TARGET_LINK_SPEED_MASK;
+	val |= cap_speed;
+	writel(val, pci->dw.dbi_base + PCIE_LINK_CAPABILITY);
+
+	val = readl(pci->dw.dbi_base + PCIE_LINK_CTL_2);
+	val &= ~TARGET_LINK_SPEED_MASK;
+	val |= cap_speed;
+	writel(val, pci->dw.dbi_base + PCIE_LINK_CTL_2);
+
+	dw_pcie_dbi_write_enable(&pci->dw, false);
+}
+
+static int is_link_up(struct pcie_dw_spacemit *pci)
+{
+	u32 val;
+
+	val = readl(pci->dw.dbi_base + PCIE_PORT_DEBUG0);
+	val &= PORT_LOGIC_LTSSM_STATE_MASK;
+
+	return (val == PORT_LOGIC_LTSSM_STATE_L0);
+}
+
+static int wait_link_up(struct pcie_dw_spacemit *pci)
+{
+	unsigned long timeout;
+
+	timeout = get_timer(0) + PCIE_LINK_UP_TIMEOUT_MS;
+	while (!is_link_up(pci)) {
+		if (get_timer(0) > timeout) {
+			dev_dbg(pci->dw.dev, "LTSSM link training timeout\n");
+			return 0;
+		}
+	}
+
+	return 1;
+}
+
+static int pcie_dw_spacemit_pcie_link_up(struct pcie_dw_spacemit *pci, u32 cap_speed)
+{
+	u32 reg;
+
+	if (is_link_up(pci)) {
+		printf("PCI Link already up before configuration!\n");
+		return 1;
+	}
+
+	/* DW pre link configurations */
+	pcie_dw_configure(pci, cap_speed);
+
+	/* Initiate link training */
+	reg = spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
+	reg |= LTSSM_EN;
+	reg &= ~APP_HOLD_PHY_RST;
+	spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, reg);
+
+	/* Check that link was established */
+	if (!wait_link_up(pci))
+		return 0;
+
+	/*
+	 * Link can be established in Gen 1, still need to wait
+	 * until MAC negotiation is completed
+	 */
+	udelay(100);
+
+	return 1;
+}
+
+static int pcie_set_mode(struct pcie_dw_spacemit *pci,
+			 enum dw_pcie_device_mode mode)
+{
+	u32 reg;
+
+	switch (mode) {
+	case DW_PCIE_RC_TYPE:
+		reg = spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
+		reg |= DEVICE_TYPE_RC | PCIE_AUX_PWR_DET;
+		spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, reg);
+
+		reg = spacemit_pcie_readl(pci, PCIE_CTRL_LOGIC);
+		reg |= PCIE_IGNORE_PERSTN;
+		spacemit_pcie_writel(pci, PCIE_CTRL_LOGIC, reg);
+		break;
+	case DW_PCIE_EP_TYPE:
+		reg = spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
+		reg &= ~DEVICE_TYPE_RC;
+		spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, reg);
+		break;
+	default:
+		dev_err(pci->dw.dev, "INVALID device type %d\n", mode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int spacemit_pcie_host_init(struct pcie_dw_spacemit *pci)
+{
+	u32 reg;
+
+	mdelay(100);
+	/* set Perst# gpio high state*/
+	reg = spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
+	reg &= ~PCIE_RC_PERST;
+	spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, reg);
+
+	return 0;
+}
+
+static int pcie_dw_init_id(struct pcie_dw_spacemit *pci)
+{
+	dw_pcie_dbi_write_enable(&pci->dw, true);
+	writew(SPACEMIT_PCIE_VENDOR_ID, pci->dw.dbi_base + PCI_VENDOR_ID);
+	writew(SPACEMIT_PCIE_DEVICE_ID, pci->dw.dbi_base + PCI_DEVICE_ID);
+	dw_pcie_dbi_write_enable(&pci->dw, false);
+
+	return 0;
+}
+
+static int k1x_power_on(struct pcie_dw_spacemit *pci, int on)
+{
+	struct pcie_dw *dwp = &pci->dw;
+	int gpio_val = 0;
+
+	if (on) {
+		if (pci->power_on_status)
+			gpio_val = 1;
+		else
+			gpio_val = 0;
+	} else {
+		if (pci->power_on_status)
+			gpio_val = 0;
+		else
+			gpio_val = 1;
+	}
+
+	if (dm_gpio_is_valid(&pci->pwr_on_gpio)) {
+		dev_info(dwp->dev, "PCIe interface power %s, set gpio %d to %d\n",
+			 on ? "on" : "off", pci->pwr_on_gpio.offset, gpio_val);
+		dm_gpio_set_value(&pci->pwr_on_gpio, gpio_val);
+	}
+
+	return 0;
+}
+
+static int pcie_dw_spacemit_probe(struct udevice *dev)
+{
+	struct pcie_dw_spacemit *pci = dev_get_priv(dev);
+	struct udevice *ctlr = pci_get_controller(dev);
+	struct pci_controller *hose = dev_get_uclass_priv(ctlr);
+	struct phy phy0 = {0};
+	int ret;
+	u32 reg;
+
+	/* enable pcie clk and deassert resets */
+	clk_enable_bulk(&pci->clks);
+	reset_deassert_bulk(&pci->rsts);
+
+	reg = spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
+	reg &= ~LTSSM_EN;
+	spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, reg);
+
+	/* set Perst# (fundamental reset) gpio low state*/
+	reg = spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
+	reg |= PCIE_RC_PERST;
+	spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, reg);
+
+	ret = generic_phy_get_by_name(dev, "pcie-phy", &phy0);
+	if (!ret) {
+		reg = spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
+		reg |= DEVICE_TYPE_RC | APP_HOLD_PHY_RST | PCIE_PHY_LANE_CTRL_MASK;
+		reg &= ~GLOBAL_PHY_RST;
+		spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, reg);
+		reg &= ~(u32)APP_HOLD_PHY_RST;
+		spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, reg);
+
+		ret = generic_phy_init(&phy0);
+		if (ret) {
+			dev_err(dev, "failed to init PHY: %d\n", ret);
+			return ret;
+		}
+
+		ret = generic_phy_power_on(&phy0);
+		if (ret) {
+			dev_err(dev, "failed to power on PHY: %d\n", ret);
+			return ret;
+		}
+	} else {
+		dev_err(dev, "failed to get pcie-phy: %d\n", ret);
+		return ret;
+	}
+
+	pci->dw.first_busno = dev_seq(dev);
+	pci->dw.dev = dev;
+
+	pcie_set_mode(pci, DW_PCIE_RC_TYPE);
+
+	/* power on the interface */
+	k1x_power_on(pci, 1);
+
+	spacemit_pcie_host_init(pci);
+	pcie_dw_setup_host(&pci->dw);
+	pcie_dw_init_id(pci);
+
+	if (!pcie_dw_spacemit_pcie_link_up(pci, LINK_SPEED_GEN_1)) {
+		printf("PCIE-%d: Link down\n", dev_seq(dev));
+		return -ENODEV;
+	}
+
+	printf("PCIE-%d: Link up (Gen%d-x%d, Bus%d)\n", dev_seq(dev),
+	       pcie_dw_get_link_speed(&pci->dw),
+	       pcie_dw_get_link_width(&pci->dw),
+	       hose->first_busno);
+
+	ret = pcie_dw_prog_outbound_atu_unroll(&pci->dw, PCIE_ATU_REGION_INDEX0,
+					       PCIE_ATU_TYPE_MEM,
+					       pci->dw.mem.phys_start,
+					       pci->dw.mem.bus_start,
+					       pci->dw.mem.size);
+
+	return 0;
+}
+
+static int pcie_dw_spacemit_of_to_plat(struct udevice *dev)
+{
+	int ret = 0;
+	struct pcie_dw_spacemit *pcie = dev_get_priv(dev);
+	struct ofnode_phandle_args args;
+	fdt_addr_t dbi_addr;
+
+	/* Get the controller base address */
+	pcie->dw.dbi_base = (void *)dev_read_addr_name(dev, "dbi");
+	if ((fdt_addr_t)pcie->dw.dbi_base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	dbi_addr = (fdt_addr_t)pcie->dw.dbi_base;
+
+	/* Get the config space base address and size */
+	pcie->dw.cfg_base = (void *)dev_read_addr_size_name(dev, "config",
+							 &pcie->dw.cfg_size);
+	if ((fdt_addr_t)pcie->dw.cfg_base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	/* Get the iATU base address and size */
+	pcie->dw.atu_base = (void *)dev_read_addr_name(dev, "atu");
+	if ((fdt_addr_t)pcie->dw.atu_base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	/* Get the PHY AHB base address (called "link" in Linux DTS) */
+	pcie->phy_ahb = (void *)dev_read_addr_name(dev, "link");
+	if ((fdt_addr_t)pcie->phy_ahb == FDT_ADDR_T_NONE) {
+		pcie->phy_ahb = (void *)dev_read_addr_name(dev, "phy_ahb");
+		if ((fdt_addr_t)pcie->phy_ahb == FDT_ADDR_T_NONE)
+			return -EINVAL;
+	}
+
+	/* Get APMU regmap from spacemit,apmu property */
+	ret = dev_read_phandle_with_args(dev, "spacemit,apmu", NULL, 1, 0,
+					 &args);
+	if (ret)
+		return ret;
+
+	pcie->apmu_base = (void __iomem *)ofnode_get_addr(args.node);
+	if (!pcie->apmu_base)
+		return -EINVAL;
+	pcie->apmu_offset = args.args[0];
+
+	/* Derive port ID from DBI base address */
+	pcie->port_id = (dbi_addr - SPACEMIT_PCIE_DBI_BASE) / SPACEMIT_PCIE_DBI_STRIDE;
+
+	ret = clk_get_bulk(dev, &pcie->clks);
+	if (ret) {
+		dev_warn(dev, "failed to get clocks: %d\n", ret);
+		return ret;
+	}
+
+	ret = reset_get_bulk(dev, &pcie->rsts);
+	if (ret) {
+		dev_warn(dev, "failed to get resets: %d\n", ret);
+		return ret;
+	}
+
+	gpio_request_by_name(dev, "k1x,pwr_on", 0, &pcie->pwr_on_gpio,
+			     GPIOD_IS_OUT);
+	if (!dm_gpio_is_valid(&pcie->pwr_on_gpio))
+		dev_info(dev, "has no power on gpio.\n");
+
+	ret = dev_read_u32(dev, "power-on-status", &pcie->power_on_status);
+	if (ret) {
+		dev_info(dev, "has no power-on-status flag, use default.\n");
+		pcie->power_on_status = 1;
+	}
+
+	return 0;
+}
+
+static const struct dm_pci_ops pcie_dw_spacemit_ops = {
+	.read_config	= pcie_dw_read_config,
+	.write_config	= pcie_dw_write_config,
+};
+
+static const struct udevice_id pcie_dw_spacemit_ids[] = {
+	{ .compatible = "spacemit,k1-pcie" },
+	{ }
+};
+
+U_BOOT_DRIVER(pcie_dw_spacemit) = {
+	.name			= "pcie_dw_spacemit",
+	.id			= UCLASS_PCI,
+	.of_match		= pcie_dw_spacemit_ids,
+	.ops			= &pcie_dw_spacemit_ops,
+	.of_to_plat	= pcie_dw_spacemit_of_to_plat,
+	.probe			= pcie_dw_spacemit_probe,
+	.priv_auto	= sizeof(struct pcie_dw_spacemit),
+};
diff --git a/drivers/pci/pcie_dw_spacemit.h b/drivers/pci/pcie_dw_spacemit.h
new file mode 100644
index 00000000000..2c17f113b75
--- /dev/null
+++ b/drivers/pci/pcie_dw_spacemit.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Spacemit K1 DesignWare PCIe host controller driver
+ *
+ * Copyright (c) 2023, Spacemit Corporation.
+ * Copyright (c) 2026, RISCstar Ltd.
+ */
+
+#ifndef _PCIE_DW_SPACEMIT_H_
+#define _PCIE_DW_SPACEMIT_H_
+
+#include <linux/bitops.h>
+
+/* PCIe DW common registers */
+#define PCIE_LINK_CAPABILITY		0x7c
+#define PCIE_LINK_CTL_2			0xa0
+#define TARGET_LINK_SPEED_MASK		0xf
+#define LINK_SPEED_GEN_1		0x1
+#define LINK_SPEED_GEN_2		0x2
+#define LINK_SPEED_GEN_3		0x3
+
+#define PCIE_MISC_CONTROL_1_OFF	0x8bc
+#define PCIE_DBI_RO_WR_EN		BIT(0)
+
+#define PLR_OFFSET			0x700
+#define PCIE_PORT_DEBUG0		(PLR_OFFSET + 0x28)
+#define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
+#define PORT_LOGIC_LTSSM_STATE_L0	0x11
+
+#define PCIE_LINK_UP_TIMEOUT_MS		1000
+
+/* Vendor and device IDs */
+#define PCIE_VENDORID_MASK		GENMASK(15, 0)
+#define PCIE_DEVICEID_SHIFT		16
+#define SPACEMIT_PCIE_VENDOR_ID		0x201F
+#define SPACEMIT_PCIE_DEVICE_ID		0x0001
+
+/* Application register offsets */
+#define PCIE_CMD_STATUS			0x04
+#define LTSSM_EN_VAL			BIT(0)
+
+/* K1X_CONF_DEVICE_CMD register */
+#define PCIECTRL_K1X_CONF_DEVICE_CMD	0x0000
+#define LTSSM_EN			BIT(6)
+#define PCIE_PERST_IN			BIT(7)
+#define GLOBAL_PHY_RST			BIT(8)
+#define PCIE_AUX_PWR_DET		BIT(9)
+#define PCIE_CLKREQ_IN			BIT(10)	/* read-only: CLKREQ# IO input value */
+#define PCIE_REFCLK_EN			BIT(11)
+#define PCIE_RC_PERST			BIT(12)
+#define PCIE_EP_WAKE			BIT(13)
+#define APP_HOLD_PHY_RST		BIT(30)
+#define DEVICE_TYPE_RC			BIT(31)
+
+/* PCIE_CTRL_LOGIC register */
+#define PCIE_CTRL_LOGIC			0x0004
+#define PCIE_SOFT_RESET			BIT(0)
+#define PCIE_IGNORE_PERSTN		BIT(2)
+
+/* PHY AHB link status */
+#define K1X_PHY_AHB_LINK_STS		0x0004
+#define SMLH_LINK_UP			BIT(1)
+#define RDLH_LINK_UP			BIT(12)
+
+/* PHY lane control mask (bits 0-5 in DEVICE_CMD) */
+#define PCIE_PHY_LANE_CTRL_MASK		0x3f
+
+/* PCIe DBI address calculation */
+#define SPACEMIT_PCIE_DBI_BASE		0xca000000
+#define SPACEMIT_PCIE_DBI_STRIDE	0x400000
+
+enum dw_pcie_device_mode {
+	DW_PCIE_UNKNOWN_TYPE,
+	DW_PCIE_EP_TYPE,
+	DW_PCIE_RC_TYPE,
+};
+
+#endif /* _PCIE_DW_SPACEMIT_H_ */

-- 
2.51.0

