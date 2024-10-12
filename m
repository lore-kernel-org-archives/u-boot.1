Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAF1D1A42C
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 03:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 017F388A3C;
	Sat, 12 Oct 2024 05:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07DE488C60; Sat, 12 Oct 2024 05:13:57 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20708.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::708])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD54B88B55
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 05:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECxxL3yMM0EBX32AjYpTzhXolp+bHVtZr7rmaCALU4bSAS20rhZ7OcuRY2XWDUg7cgG5fPdgjlhQgnNDNYlzuITCsTDwepuB+oFwLxZHbOB34XEkniNzeG7sTvubgPdvccfCWw8r3/weHKkxyWKaJtzup1qN8KU73IkyJwe8ryThCgcrCBa6JZij2qVVqWkLXIxioxrdg08rq+m1mznFGP6ydfnNZHxr9oN+yrpeLqqe/oi2AWoCOaP8DLBu0zfyeRDPFwDyQJe8oQ0ZkBO2hmFNt4oQP/enFQInfnrCTdrQwbtuvt3PjHMdmAnn1YKQV76m5mrfouhfpgpJH5s2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9i53la1VNiU6heQr3vHq2DqWrEeh3RAZI9L6meFCug=;
 b=Ml0KfyNrngmhm8y0aJSGEQbAx+Nqaf4r7OH6NnKCuB8c6IdQlcaHrdKOvaci/cn5I9JoFx2MGO2e3CdfMk/bG6W9/mAvMNF0lJqXyWWXRNEF5WSVi1lgK/7o9FHLlXWIFDFMNZ3d54ruSZUMTz1K5JydYTyQHfczo0VDSjR6JI+LRX1LXPwnmxz8D/Pd1JLY667zPzvvEKRFjHWu1/vuAuf+/pvoPM7BtxIRU2uvJ/cX73o908jhZRdoYwuDZccWJ5Xc3zZgZGJSALoCLnFWrzQ77KJeGWnRi9fx1SrkDTjyRP1wzN85sScxeSSKSsRghSuAiEZk1l7sxKCCTLV26g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17) by BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 12 Oct
 2024 03:13:46 +0000
Received: from BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 ([fe80::480b:a135:6e33:10ff]) by
 BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn ([fe80::480b:a135:6e33:10ff%5])
 with mapi id 15.20.8048.017; Sat, 12 Oct 2024 03:13:46 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v5 3/8] phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
Date: Sat, 12 Oct 2024 11:13:23 +0800
Message-Id: <20241012031328.4268-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241012031328.4268-1-minda.chen@starfivetech.com>
References: <20241012031328.4268-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::26) To BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0850:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f113b0d-1711-4cd1-f935-08dcea6be25b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: y/Zu+M/DfRBl8pZ9M/7QerHbVCW8+0WAk8jJT7Vqv1rllNsS7II4WJZajG47FyjWvibgyZI410cjw3PQIEh05pkh6w3AAgI3FVuH5JbV5Bh3lf5u1+7W6dma5AFCYv5an4xoZK5QHxSGqzwSHRRhXkcKcc1mJ3b6yVHDXM6A4Cjj9XIe5shaMKQ6hx6rgaAsVcKa3cd9MOhsFfPK0Q8qc4mhVgSfy6Zsplnm41pCp6qkRmkY0/NDH9GnvQqJ5E0YXuR4ffeYVaayO5y8zlTfLJzYEkxcX7QcGOa6hDhnC1N13c7lWfXIAMuV7pHVUNpZdNKsAUEXAK9cKp9DuacYmPa2lwXVYUaRqJr56yF+OYZPQgZlD1vDlAi0cOa7QHwnX55dfbt5JkcstA7coMVcuFzBuo9ekP24pwc/m88+YglIPYi5cxKU9ST0jVhMtRftmYkfEYcNVyEeUKNFY4mGi9+44GeF/Wau3Fll3jkRMMaFkxR+sGCvoiEi7DixCpGCjkS+Je/UQNDyhv75VRq5oQsWAX7DkfnATvZ/exaYbrCpKnIPhMCIwoI2FuKL5LeE9CJ3ggzWHDc7aW0icrMG/qZ1QWyoSzQ2XsfZU+fbtwG5z2Usv+1JHlx6aYnvw0pR8rFA1hW/HYuY1b0hht4Vqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s8rmJChsIawfI9hVeAsQuSVSy8bfhctr65zOOX7KiKQu3MFpmIcV79mfiwCk?=
 =?us-ascii?Q?FsaSu4MgBWvZxfRQCSCaHEf+srIU57Mk1wgZfQFuEed/cV6I7q447U8yOFnD?=
 =?us-ascii?Q?W1D6cPn/dJlA26SEnvH8pnMZgpecCAGuDHU7pltn1f3tCKU7SkzpREI00Z/8?=
 =?us-ascii?Q?1yN84NoutPjYVZrawAgxzi5WgBdMPdGgbNlMWiB5OPzqks/hYh/iTHMRjfyI?=
 =?us-ascii?Q?HJdrh+7os2iYCJnkaJ1bu651qzN5wkzBy+E9rGUFB7OEhNXjJDuXkO8XZ5XI?=
 =?us-ascii?Q?ShFqCsiPBRae0DSwb5qoGdwrhblbkvd/Me5fBH/wDE2biEQl+QP7KGhtYgIT?=
 =?us-ascii?Q?MHrJVnJ8Jwp8tupOxIDCQ15fXrmhPMxh1eX8qHdCrqz2ABsBWVG+FPJNzHYI?=
 =?us-ascii?Q?4Ee0hwhQDORZ5756OkTlP9nc0PuVq1mDpL01gtbtyM8PXtiuEt+2aRYFDrKP?=
 =?us-ascii?Q?FdDRQ2CRrUuxgu2NmRwsgtiEybQ7sfWnZRGAagOA5Xd1tXvmrX9R4uCrjsMO?=
 =?us-ascii?Q?p+gJWmB92h9wuxdE0jU1dTXxde+tlRHcydoyu65LZVMKuxkwdqmcB21KEQAU?=
 =?us-ascii?Q?3bC74uiQstfv4YQAhDNP1BMCyp9zhof4/C/RHAcKivjdTfgy1tFtU4X9CdAX?=
 =?us-ascii?Q?mPptczyvZRHff0G23bEoxEeYzbiT2VC3cUCS1iuTT64lpqpNxA/g7b33xZF9?=
 =?us-ascii?Q?BgTJBQ1JbF3BFhUJpxjWYqzVq7Q8PuWMmLvVu0f+hf5JC4SRdcH7+efDqc8T?=
 =?us-ascii?Q?wyFMXbIB2G1RgLOJ+u38XNj54SWyWpSCDX5uv8oRQsVty/zPHE7qK/ddgSNb?=
 =?us-ascii?Q?yVyszzQ7r4AnrzaFwAsEdDLao8wTg0gzFpEIRiQqu7cS2pda0JSAqOepXhUQ?=
 =?us-ascii?Q?WkwycSp+zIy6SyV/sEJyMiycCuLZUUw06syqcD/y81eitGy2vHMgNuH0UFbI?=
 =?us-ascii?Q?j19D1bA7UbPS2YLu58AVRfCpi2q6ThmGcVthOUuNx3mddMvoaLL042FMVbp9?=
 =?us-ascii?Q?nrCAne4Y2nnY3g4uf/uchJzmu68rGyzlclsvhzLCo5r3mNioZfoaDGuG4BSY?=
 =?us-ascii?Q?IlUFFeE6LEWLTLisvtnjrl2xTJp3OsBCPVSWHVnIn+8MGfLtkmgW/9sf/vL/?=
 =?us-ascii?Q?vXnB9/PnNLDhMXiPvKh2TT0JGf8bMCjveuDo1EEA1Ieqq6hJi5q+zHs2wx0B?=
 =?us-ascii?Q?3YSG3cOWItYzirROAfz/LpQwMdIphZSdwUXraGR5DNM8pKT3wDbnMwNYdNgd?=
 =?us-ascii?Q?G6gyqxFIa6rpaeNu/TsD4VMru4TTXMuVs9/t1jiFx3+njnYhQxrY0KCze8AA?=
 =?us-ascii?Q?B+b8zpCcsMsu3igicZ8pt1ywWKQJheJ/pF7fS7H2nnbOQpcTBmKSeYERtm2V?=
 =?us-ascii?Q?MK0n95Dd8Ioq+R0bgMa8m4UthN07/5V6VF/PoHQn+eVwbigOuxJemebHnj1Z?=
 =?us-ascii?Q?piaR8+GZncQ6Nio3LMiYC6tHRJJPwT70KE4SektB6il2N3bjTTCULNsm30YQ?=
 =?us-ascii?Q?5Y71VhpGwZFZGHHxiF3Pw/8Tp2rE4vTttAYTiqaqFB1YXAxZa6onIGLjIf0E?=
 =?us-ascii?Q?YUbpPtGF/DPCiEd8/q3DZs9AYMF+S+V8M2LFoc7t+EMvQ2YP/pzuSKfMn91B?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f113b0d-1711-4cd1-f935-08dcea6be25b
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 03:13:46.0839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itm8kIjHsJP3ugsujRrrLNY+rZge8o9xK+2ypgGJ4rBhzdS6LZt5JOOL7lLa8YTirvsXDy+6h1PFwtYKxR/6xfirNNYg2ZtMED1b2h/H59o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0850
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

Add Starfive JH7110 PCIe 2.0 PHY driver, which is generic
PHY driver and can be used as USB 3.0 driver.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/phy/starfive/Kconfig           |   7 +
 drivers/phy/starfive/Makefile          |   1 +
 drivers/phy/starfive/phy-jh7110-pcie.c | 239 +++++++++++++++++++++++++
 3 files changed, 247 insertions(+)
 create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c

diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
index a7cf0a55dff..d11338ed484 100644
--- a/drivers/phy/starfive/Kconfig
+++ b/drivers/phy/starfive/Kconfig
@@ -4,6 +4,13 @@
 
 menu "Starfive PHY driver"
 
+config PHY_STARFIVE_JH7110_PCIE
+	bool "Starfive JH7110 PCIe 2.0 PHY driver"
+	depends on PHY
+	help
+	  Enable this to support the Starfive JH7110 PCIE 2.0/USB 3.0 PHY.
+	  Generic PHY driver JH7110 USB 3.0/ PCIe 2.0.
+
 config PHY_STARFIVE_JH7110_USB2
 	bool "Starfive JH7110 USB 2.0 PHY driver"
 	depends on PHY
diff --git a/drivers/phy/starfive/Makefile b/drivers/phy/starfive/Makefile
index a405a75e34c..82f25aa21b7 100644
--- a/drivers/phy/starfive/Makefile
+++ b/drivers/phy/starfive/Makefile
@@ -3,4 +3,5 @@
 # Copyright (C) 2023 Starfive
 #
 
+obj-$(CONFIG_PHY_STARFIVE_JH7110_PCIE)	+= phy-jh7110-pcie.o
 obj-$(CONFIG_PHY_STARFIVE_JH7110_USB2)	+= phy-jh7110-usb2.o
diff --git a/drivers/phy/starfive/phy-jh7110-pcie.c b/drivers/phy/starfive/phy-jh7110-pcie.c
new file mode 100644
index 00000000000..ecb04bdedfa
--- /dev/null
+++ b/drivers/phy/starfive/phy-jh7110-pcie.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * StarFive JH7110 PCIe 2.0 PHY driver
+ *
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ * Author: Minda Chen <minda.chen@starfivetech.com>
+ */
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <generic-phy.h>
+#include <regmap.h>
+#include <soc.h>
+#include <syscon.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+
+#include "phy-jh7110-usb-syscon.h"
+
+#define PCIE_KVCO_LEVEL_OFF			0x28
+#define PCIE_USB3_PHY_PLL_CTL_OFF		0x7c
+#define PCIE_USB3_PHY_SS_MODE			BIT(4)
+#define PCIE_KVCO_TUNE_SIGNAL_OFF		0x80
+#define PHY_KVCO_FINE_TUNE_LEVEL		0x91
+#define PHY_KVCO_FINE_TUNE_SIGNALS		0xc
+
+#define PCIE_USB3_PHY_MODE			0x1
+#define PCIE_BUS_WIDTH				0x2
+#define PCIE_USB3_PHY_ENABLE			0x1
+#define PCIE_USB3_PHY_SPLIT			0x1
+
+struct jh7110_pcie_phy {
+	struct phy *phy;
+	struct regmap *stg_syscon;
+	struct regmap *sys_syscon;
+	void __iomem *regs;
+	struct regmap_field *phy_mode;
+	struct regmap_field *bus_width;
+	struct regmap_field *usb3_phy_en;
+	struct regmap_field *usb_split;
+	enum phy_mode mode;
+};
+
+static int phy_pcie_mode_set(struct jh7110_pcie_phy *data, bool usb_mode)
+{
+	unsigned int phy_mode, width, usb3_phy, ss_mode, split;
+
+	/* default is PCIe mode */
+	if (!data->stg_syscon || !data->sys_syscon) {
+		if (usb_mode) {
+			dev_err(data->phy->dev, "doesn't support USB3 mode\n");
+			return -EINVAL;
+		}
+		return 0;
+	}
+
+	if (usb_mode) {
+		phy_mode = PCIE_USB3_PHY_MODE;
+		width = 0;
+		usb3_phy = PCIE_USB3_PHY_ENABLE;
+		ss_mode = PCIE_USB3_PHY_SS_MODE;
+		split = 0;
+	} else {
+		phy_mode = 0;
+		width = PCIE_BUS_WIDTH;
+		usb3_phy = 0;
+		ss_mode = 0;
+		split = PCIE_USB3_PHY_SPLIT;
+	}
+
+	regmap_field_write(data->phy_mode, phy_mode);
+	regmap_field_write(data->bus_width, width);
+	regmap_field_write(data->usb3_phy_en, usb3_phy);
+	clrsetbits_le32(data->regs + PCIE_USB3_PHY_PLL_CTL_OFF,
+			PCIE_USB3_PHY_SS_MODE, ss_mode);
+	regmap_field_write(data->usb_split, split);
+
+	return 0;
+}
+
+static void phy_kvco_gain_set(struct jh7110_pcie_phy *phy)
+{
+	/* PCIe Multi-PHY PLL KVCO Gain fine tune settings: */
+	writel(PHY_KVCO_FINE_TUNE_LEVEL, phy->regs + PCIE_KVCO_LEVEL_OFF);
+	writel(PHY_KVCO_FINE_TUNE_SIGNALS, phy->regs + PCIE_KVCO_TUNE_SIGNAL_OFF);
+}
+
+static int jh7110_pcie_phy_set_mode(struct phy *phy,
+				    enum phy_mode mode, int submode)
+{
+	struct udevice *dev = phy->dev;
+	struct jh7110_pcie_phy *pcie_phy = dev_get_priv(dev);
+	int ret;
+
+	if (mode == pcie_phy->mode)
+		return 0;
+
+	switch (mode) {
+	case PHY_MODE_USB_HOST:
+	case PHY_MODE_USB_DEVICE:
+	case PHY_MODE_USB_OTG:
+		ret = phy_pcie_mode_set(pcie_phy, 1);
+		if (ret)
+			return ret;
+		break;
+	case PHY_MODE_PCIE:
+		phy_pcie_mode_set(pcie_phy, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dev_dbg(phy->dev, "Changing PHY mode to %d\n", mode);
+	pcie_phy->mode = mode;
+
+	return 0;
+}
+
+static const struct phy_ops jh7110_pcie_phy_ops = {
+	.set_mode	= jh7110_pcie_phy_set_mode,
+};
+
+static int phy_stg_regfield_init(struct udevice *dev, int mode, int usb3)
+{
+	struct jh7110_pcie_phy *phy = dev_get_priv(dev);
+	struct reg_field phy_mode = REG_FIELD(mode, 20, 21);
+	struct reg_field bus_width = REG_FIELD(usb3, 2, 3);
+	struct reg_field usb3_phy_en = REG_FIELD(usb3, 4, 4);
+
+	phy->phy_mode = devm_regmap_field_alloc(dev, phy->stg_syscon, phy_mode);
+	if (IS_ERR(phy->phy_mode)) {
+		dev_err(dev, "PHY mode reg field init failed\n");
+		return PTR_ERR(phy->phy_mode);
+	}
+
+	phy->bus_width = devm_regmap_field_alloc(dev, phy->stg_syscon, bus_width);
+	if (IS_ERR(phy->bus_width)) {
+		dev_err(dev, "PHY bus width reg field init failed\n");
+		return PTR_ERR(phy->bus_width);
+	}
+
+	phy->usb3_phy_en = devm_regmap_field_alloc(dev, phy->stg_syscon, usb3_phy_en);
+	if (IS_ERR(phy->usb3_phy_en)) {
+		dev_err(dev, "USB3 PHY enable field init failed\n");
+		return PTR_ERR(phy->bus_width);
+	}
+
+	return 0;
+}
+
+static int phy_sys_regfield_init(struct udevice *dev, int split)
+{
+	struct jh7110_pcie_phy *phy = dev_get_priv(dev);
+	struct reg_field usb_split  = REG_FIELD(split, USB_PDRSTN_SPLIT_BIT, USB_PDRSTN_SPLIT_BIT);
+
+	phy->usb_split = devm_regmap_field_alloc(dev, phy->sys_syscon, usb_split);
+	if (IS_ERR(phy->usb_split)) {
+		dev_err(dev, "USB split field init failed\n");
+		return PTR_ERR(phy->usb_split);
+	}
+
+	return 0;
+}
+
+static int starfive_pcie_phy_get_syscon(struct udevice *dev)
+{
+	struct jh7110_pcie_phy *phy = dev_get_priv(dev);
+	struct ofnode_phandle_args sys_phandle, stg_phandle;
+	int ret;
+
+	/* get corresponding syscon phandle */
+	ret = dev_read_phandle_with_args(dev, "starfive,sys-syscon", NULL, 0, 0,
+					 &sys_phandle);
+
+	if (ret < 0) {
+		dev_err(dev, "Can't get sys cfg phandle: %d\n", ret);
+		return ret;
+	}
+
+	ret = dev_read_phandle_with_args(dev, "starfive,stg-syscon", NULL, 2, 0,
+					 &stg_phandle);
+
+	if (ret < 0) {
+		dev_err(dev, "Can't get stg cfg phandle: %d\n", ret);
+		return ret;
+	}
+
+	phy->sys_syscon = syscon_node_to_regmap(sys_phandle.node);
+	/* get syscon register offset */
+	if (!IS_ERR(phy->sys_syscon)) {
+		ret = phy_sys_regfield_init(dev, SYSCON_USB_PDRSTN_REG_OFFSET);
+		if (ret)
+			return ret;
+	} else {
+		phy->sys_syscon = NULL;
+	}
+
+	phy->stg_syscon = syscon_node_to_regmap(stg_phandle.node);
+	if (!IS_ERR(phy->stg_syscon))
+		return phy_stg_regfield_init(dev, stg_phandle.args[0],
+					     stg_phandle.args[1]);
+	else
+		phy->stg_syscon = NULL;
+
+	return 0;
+}
+
+int jh7110_pcie_phy_probe(struct udevice *dev)
+{
+	struct jh7110_pcie_phy *phy = dev_get_priv(dev);
+	int rc;
+
+	phy->regs = dev_read_addr_ptr(dev);
+	if (!phy->regs)
+		return -EINVAL;
+
+	rc = starfive_pcie_phy_get_syscon(dev);
+	if (rc)
+		return rc;
+
+	phy_kvco_gain_set(phy);
+
+	return 0;
+}
+
+static const struct udevice_id jh7110_pcie_phy[] = {
+	{ .compatible = "starfive,jh7110-pcie-phy"},
+	{},
+};
+
+U_BOOT_DRIVER(jh7110_pcie_phy) = {
+	.name = "jh7110_pcie_phy",
+	.id = UCLASS_PHY,
+	.of_match = jh7110_pcie_phy,
+	.probe = jh7110_pcie_phy_probe,
+	.ops = &jh7110_pcie_phy_ops,
+	.priv_auto	= sizeof(struct jh7110_pcie_phy),
+};
-- 
2.17.1

