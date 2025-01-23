Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3391EC02181
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 01:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3AED807B9;
	Thu, 23 Jan 2025 02:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3999780275; Thu, 23 Jan 2025 02:01:34 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20715.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::715])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E549803B5
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 02:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHGopJm1U4nDSDGqgHN5iBGxtFfxO9do4mBmDUkY0q2Ecqha4JYRg3Dxor2DUU48s7F8TbC+WBUOL/wkD95sJsv3/DqncaZ0PutEL6H8cbtefVdXyGHJV+pf5rBWkJEGprgXG6q7EM+8tIhiBGl7mfgAjSjH5scQ//EIsOk6T+cXC8Lhc1uBICFfoMfwThmDc2N6h6gB+Se5Kp9sW/gjoo1o/12hbXlWKe9F46g2a2rEj6J4GRixJL3KXYqpUzt1ORQMLassa4c1LZhU041i2UVan5RtS8pe6R2rB9tac0ATXgsVBWCqINMaCW/IiRV3sJH2t2u+05RRRdqe6asNdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9i53la1VNiU6heQr3vHq2DqWrEeh3RAZI9L6meFCug=;
 b=Ive6bVU8phKUzywY3Vmqe8sDjhevP9yufxWE+y1/rqdiLa6VYzx0tunNKr8giRxhYK/KE28RGA6J/rI0A7HWgNYAIv3KaQoGycNJ/WckxhQkzEzIKUdUIw3gMkg9CcYEBo0qOqKNCkvDmK6POhPFQAbqLxNeOUwbM64DABKudxgs2C68N3fZ8G7wpK4KR7ScNbz7gkpmKZM0N3s5DdGlVfXrAoHQeVwr497PERWWTtOMq/qHzDOBUNn5Nfug5SKKfZaydkz8hmf+ALXlI9bslmRto+EK17IXdTHsPF7DaQf7LlXY97JwyYb6Ohz7BV+zHacMYoI1VakrY+eDQCh7JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0813.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.8; Thu, 23 Jan
 2025 01:01:25 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Thu, 23 Jan 2025 01:01:25 +0000
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
Subject: [PATCH v6 3/8] phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
Date: Thu, 23 Jan 2025 09:01:07 +0800
Message-Id: <20250123010112.78924-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250123010112.78924-1-minda.chen@starfivetech.com>
References: <20250123010112.78924-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0029.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::10) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0813:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b3e0f4-14db-4865-ee2c-08dd3b4975c7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: vRLCQy6HsZ+PmPqWmk7Wo4xW+pZ9KGA//FYi53hfQYF8TAb64QBBoRwx+jBNnKVNo+azV8mu20ftXU1la1aawy5xW3V0mI/I4LCT93rN2tgqwxx2rSGDqhzOXUN66Jl6D7GGigMGArVaUaXMxGqdVcqp0RorIu/or6GM5d8rWjZs5YKjuR27iAsmjMJQu0C/kCpRY0xYx5XILU7/144S6mnSjKaVQnDzXGjtqy1x4fGVjM+Bum9Etym7MHpj8HRYA4ZqaGndqT6/Qq5wIjWn4nfSJ6dvWZbur6i9yUkDn1CDZ0HakN3AIth6FUxw1JtuYhIueCJZuzlK1fYYJv7VxZLa3ozQvaH0TpCpr0EpP2khFXobquJcnME/43f0LJf8JWcX7sAjAqy9KX5yGXRZX04Z1Mjh4KYF0Q+VYQW69QIvkiMYtJmd61G2sBHg/qKRdUzfOfAiNaJMj+XnJiCHw3ZVEyFaqtdHLTqz4RGHDe7TXjj4Wx7pSh1Afhfacq/HU7a5L4WLIeu5x7YJucBcvl2GYwT9nMYOflp9xWl1BIaoSz6DfS29jcpVgH2C+rOFg68hME3OJW/sLtUbxVtR5rZMOIvsbiQQLEEZVzWJu2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LJBJlM7zKc7kNBqhpUmFgJsF4CWeZPqOUZnr33j0EB0HlfVBJ1kXmpAkVkX9?=
 =?us-ascii?Q?fH+ClhJ6Z1eS+Tzf21G+siymHi0/QIEr8il+dsWU1TWyEljktp9aI4v7ZBR1?=
 =?us-ascii?Q?ckPOJoaPBAvCUu+7RxKRIJKkL4MIK4YoyybO66EBIVg84cfgMH4nheY3iHxA?=
 =?us-ascii?Q?77bqikfewULH2xH0w/lENHnwlxYwO4YLVzbrWITQQIOU6Zv3cLQ3pvxJ1Vuk?=
 =?us-ascii?Q?9ZWMIdWRbWN9tdxOq78UKWxCmWxtbwmeHW8ryKEujEMx+Z0ULymY5ri5I9mk?=
 =?us-ascii?Q?VRRPV/Wmo5Or59OZm8iUqcMlvKmG6vYdabHGMnkXW3esPwkzJlaxJTLbKCpk?=
 =?us-ascii?Q?UWW9hLGy8R30+DRlrNyGadP8+Bu+vmx7iq9t8O5gKuNI65mjXLHfYhaZmDsD?=
 =?us-ascii?Q?mKSOGOUkKJujhF1U18ge/Hekr/2fLrvf9EqVblfStnjXVPoX8JCPetN1Lfbh?=
 =?us-ascii?Q?gq3HMEVmaoKrzX5EJ27QZ3vnUbuLmnnuGONcMxw42KytVNY0VIgsdDXYpK4X?=
 =?us-ascii?Q?ktM4RX/CjCSOszjtvFQxWgPWH1BdowkWwJjFUbQFQG3U7gh6K8O3TApCF05X?=
 =?us-ascii?Q?c/T48PvKtBx8SvCbVUiPQxoXuBQRtdKtpefT3Ewc1vr8ikkZTavSc60qowhs?=
 =?us-ascii?Q?godn+MZnb0su06hITLOrwTIy4C3GwWoqCBMdfpCSZuUDXO/R1o0SpUzkCsj0?=
 =?us-ascii?Q?daKT2QZMy8exSwy0sE+XNZ9vepFE6VU4iRNI0wJyRLdu3+gOCEEY61+EiDWf?=
 =?us-ascii?Q?qH9g0mjxo637D3EGKNB/jc1i9c5RItiNp9x78V3BqvOZ/DlbIGEeuichl9nN?=
 =?us-ascii?Q?cymxY8b9706ElLV+xX+Jdfv0LIgOcsgA0+oUt+o4UbDXdrjOGGgD8upP/1ev?=
 =?us-ascii?Q?jQlj0K4CUqCuHaH0z6X8uuLcCfOj+zWpBbUHvEcsfcYGsAUC+/108vrlzxYm?=
 =?us-ascii?Q?hrAs06fffnntT1XDSqVT5LWpZd9J8IrTBUa5aUyLsBWPcPBHjYHJQS2m1XJ0?=
 =?us-ascii?Q?KCkYgKhMHl17GJs1tBfSehnCTMZ70EUkjeclu89BseSamL7T9rEFKs1SKr5I?=
 =?us-ascii?Q?gwcopIdvZKUFGBICejctlU1WA7G1SXfFUbWZs/uu1lhViDQc7WUonIt/GPIK?=
 =?us-ascii?Q?vM98LLzdQkxbOIyFBrcFDZhn6rs89geK286QDCuCDAKMBOzzfewf+u7m7auV?=
 =?us-ascii?Q?Tozhz/VfVd1oXtJXPYVUhXE5ZV2n0xvfKDmfoILa4AgxMACD9ssJBJBhv/VW?=
 =?us-ascii?Q?cTpspSM/46SenHMmpIFyHt0daZYK4nfzdbiKJENWvoHkm2jPboHf1tWOAK/+?=
 =?us-ascii?Q?jhnMUrIWxpHKkVXevBuUf6/YkqIpmJ2DW2tYB//dQ4VXIP2oMsFCRV2OXf0L?=
 =?us-ascii?Q?mJBScReUW+/sEfu5QRLuhEo/dkRwYMybqJ7LxwJbcAPKG2UF3fFOBW/jggjn?=
 =?us-ascii?Q?fJ8lmNYLvNdBWcVvTiVoWxAy9ICcp4ms2w0a+eK1eUqU7iJtzf25uMzSqXsY?=
 =?us-ascii?Q?fC0FW/SuBibK6nQNR+lfJ8D6GwWARwZNffqpCrcmfG8wi47IWTPm/YLlPJ7c?=
 =?us-ascii?Q?z2CPL1ltVhEnAlQhxsyy8Jqna/VT67o+4uMzz0vTlWUwJd8uthhwei3NFKbJ?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b3e0f4-14db-4865-ee2c-08dd3b4975c7
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 01:01:25.2507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qi8IJ9yqQvJOJ1Rl/cY5wi+i9vwb1gHxs8EI1Y95X+kDZ/0bF84MMyhNJuMGhoDyddJkyyfiALlT7TZu8m+ujoYW5Du8ZcbAYC3Sxf71c4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0813
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

