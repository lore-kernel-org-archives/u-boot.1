Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52FEC3DA61
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 01:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 296A488B5B;
	Fri, 19 Jul 2024 03:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7C3388B45; Fri, 19 Jul 2024 03:38:43 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20709.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DB1488B4F
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 03:38:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRU+fvk+oI7wdfQ7PEU9CX3Q72H0qo7LRoCUbSb8Hpojkeln+r29AeQm8c0NO4c40Cx8hrM7P29rbjuvE31yykbhZ+u/SbEgArswO7NvomJ1B3qIxj3dSd7anYlb4ayvRaD1unJhEbqoVepGdZxWqwhL67aPFn1bxuaMT2rCYR9GeZ1Ii567DkiffU/EgvtEqhnxaMiqVUkRe531izNwQNt06l3vtf9PLo3dw5G/7QC9Ix4gYab3nXRUj/PUt2l2HGUWlXYXraXEzkjHIqf28r4P4oHxWUkxIMNef+jffK6t6KffG3H5rC3M8EyTRP/ZuVk4uTweHkkevwy8Xr0jAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DzdXCN0r1HhiunYJGK7SWgQtfsfg1VFWboujuKwomQ=;
 b=bbTDGAPWhqa+0RTs0z3L2HlTLyXCL8TAeeWMwJH/tR3/hcl2J2NZPdcJeCqknNGIaPw8vm41AI60jcJUdcGwigobrjY1qkHW/OxMLE6p+1ATihbq42fRby+CNFgtaJI9Pm9K2KB3jxV5x3LJvJTp/fXPDpPPOro6j6oH+vSE6TE6vBYjs65Z/FIk6QZDdvIkJRM1NPQ4LUJjunt3CBtlv5Veq68QtZhvAItDrgiR0iZ8dpYbT/qdoi0fxwqy69zU+NdFjKtzouhoc241iWMlBu6Frfi/qvwEI/PgMSO4r4g58/KxqhR4iArk9fuex5LM82DK7X7LqsUVVK+PaDhZcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.46; Fri, 19 Jul
 2024 01:38:34 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::bd9e:fb57:ebf7:9d71]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::bd9e:fb57:ebf7:9d71%4])
 with mapi id 15.20.7741.046; Fri, 19 Jul 2024 01:38:34 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v3 3/8] phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
Date: Fri, 19 Jul 2024 09:38:17 +0800
Message-Id: <20240719013822.101374-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240719013822.101374-1-minda.chen@starfivetech.com>
References: <20240719013822.101374-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0623:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d83d28d-18b9-4c9b-50ce-08dca793810a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|52116014|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: ayBa0tVKNAAKrf2OklQvenTD2Dp6BuueobnxLW7JjxZStCcp2tVvYz6+axoxWhOxvGU9MtuRL62xAPa1VV6ZXGp6jhJpORsQBmxjM6QKqrM4mDM8c+VqvOVspGWMbJnyEz//RYbOeWlc8/IwP1p+ESwgJdN8gUIRERFGS1sECZx2pwo+KkayuiRESQj18V3uCRwxv69bgRKymFucBEXnZN8/ZavexjyvcE/6CJEhjJVWqVJw6Eye1lA+DIqXOGSi5LY5pvGDuwZwpXvLjtUMRTw5rlpSvD0881Pj78bmPaTgnJF++V5fHtE5wY0rpZ5nuaCZ1D6Lnc2sr88HWZIM/5KbJ7b2pvfDnpDaK5flZcsUmdVb9XIIviM6pL3DQDub2snnwVRQMyNQCZD10XufdDh8Y6NpdomJ+4BAXXUzNei4dW0JxLpe/dLqRe9aeHfaXvAmQvPU5DCO90Fmup/YK12uXKlTJYkz+67ebCo5gphWzu3ONhEOehTg7/6yzr1zqz21vKCg+CvEuVJvNU4PnA2nii5ljwvR/QTUDK4e+UsOX8urN8kzHpUPRzZzBc7ymSrRXL0F3honiadle4Rwohq2bUD2WXsGMyNoaaEYunuK5BhZcHCT2bKCGBXJW/Ddm5j+6FheZq2USJM87tGupw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(52116014)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vgoHFI7NGnuUBI+rqtufgxndxTjWb2ZDi79F7YCs9EAtRCgkFgzmVDH891GL?=
 =?us-ascii?Q?PtMKl3Mo8HUSUkPWcwVv4JzHRCvdPJGP+LA8E42OV9nRLSxGV8tfVNpvVK8W?=
 =?us-ascii?Q?zGqxm23mpIj6oDl0M7bFMtUIC+DXx9yqiqCBzN8XeHZ0GQzHZPHV7M2a8fYN?=
 =?us-ascii?Q?0YNYJLk+7lKj9yAOVbyl6dp5CcMBCQFjFp/G3TkdXjxnBQ1pfvabr1EsvcwI?=
 =?us-ascii?Q?psoBT+hSWd56Ds9+jxIondbeoRPVPTHH4u4IJKiUgkqAHDtVTB+gnYdXq+gw?=
 =?us-ascii?Q?sqeDlj1RctesJCOvGh7PaRNZ3Zo27GqtM8tEeXRZdqae+TMgmm3zI/71lASz?=
 =?us-ascii?Q?4Zv/zef6c4rx3qtuOlWTMdWtLQY8BoxfRKs29zlltMTasXnSf2q1LV8KRp0a?=
 =?us-ascii?Q?UAYcmq3i8gX7syZNysDk/Q69P8rnacx2Q1l/YjDC0xMq4EGF21A1GVumYQRJ?=
 =?us-ascii?Q?wkAiYTDsgxIUY9iz/5Pp07gBMxsuog3OHbLstdgu9Fss7iunYe4Co1V0tmON?=
 =?us-ascii?Q?3H/QT85YkAc8IBMqiIAFRZ/ZwgdUZRzY6GVhvDiiPewW85LngUyGXPW+CtY8?=
 =?us-ascii?Q?3owCYM159C1sB2XgabFEKnzVvyJj6/tEJZ+ng/4Ia63wuuAoMw/0wE+KOawC?=
 =?us-ascii?Q?52lwFjdLeI61YvbndCEoTFPU4aQOUXe3IHbXgUxJcFFDmJuTgVGVCAlgvlMM?=
 =?us-ascii?Q?NxgVHv3NL0/03zRNKCwX8xolNNDEytBjLOjsS64SyuYWk2LoedYVYuvG8Xh0?=
 =?us-ascii?Q?9kaSBBUAkS/IIB8E0Ef2SbAIdwg5TQA8RZBZqoFxeTdvHjjtD6jisdZw6BmR?=
 =?us-ascii?Q?KYC7S8WKvZihQh5aNy041KKOdT++/1zG3yFyjTba25L9V/8vdrNbKFpTM9z2?=
 =?us-ascii?Q?LASibr3ebsGTdXGNfJWJeeuIRqAAiufwGYUP7BBzu31Y/23F7AV211/dHeU3?=
 =?us-ascii?Q?fgccy07CpVI9WhzjNB5GR/NZB09m895K9DVgRoT00K11xJzdbNAXuaYAUgpF?=
 =?us-ascii?Q?/VGw8asBoV686T1z60Tpn5vs2lwTnYXwh1UHguLrvwd2UBSLmLdxVc6v7QP/?=
 =?us-ascii?Q?a/Jeuo/bGiO1l3JRE4ttV8U4sxep5OCW431HaaO4ov1MeGuehPvFoT+YC16c?=
 =?us-ascii?Q?2XBIkjLsaTtuEbw+3SnPAUAPuFNLkpJz/yBvcU1Ww28162eDmhzKG4ZquhQp?=
 =?us-ascii?Q?tmqEbDzLYwM809xpfmk5xIouglxOzzcxnGIVYixEOUiKBjCS6lj00/qTqqrt?=
 =?us-ascii?Q?K1RGxzfyusqHLXH2lHHSRhK67/zylsgSwXIo7PJk8yC2Z0OhjxsBHyhdyh1K?=
 =?us-ascii?Q?ey0OuJKFSvz+haH4yp/bx8jLLVEg6xUX8+cdt2WK/m+o2R92g+WG3LEprffj?=
 =?us-ascii?Q?j9PUvjZmFR2+QprhthbTtB+UhYJJX9d28qMJxq38/bFlt5voQR3+hPjL3iuN?=
 =?us-ascii?Q?37PPvRMxVZTceCmaE/leDT9XD179bwqjrhiABBsqblSi7lCsdaiT56L7VmWg?=
 =?us-ascii?Q?UHOsQnX28WO+kH27P8I26KoqgPi8p2Xpzb1hqYj9tb+eYT65rjb6e3PqCw8q?=
 =?us-ascii?Q?pN7r8QQCFLxHwjRx4kNm8Zwss5JI0zPZEbyFvzXlrlutlybQJwCLg1POjiuB?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d83d28d-18b9-4c9b-50ce-08dca793810a
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 01:38:34.7952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/mC4VrPdHlKZJjX0rKetHKcaB1esC3oCBjvybopb62byPIXZPrVoRKL5Q8vNXaAFlWGYmQ5CE+RXYQODagPhgTRtY93mTN1X68bhQKjUew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0623
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
 drivers/phy/starfive/phy-jh7110-pcie.c | 237 +++++++++++++++++++++++++
 3 files changed, 245 insertions(+)
 create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c

diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
index f28529d1f9..0843070b74 100644
--- a/drivers/phy/starfive/Kconfig
+++ b/drivers/phy/starfive/Kconfig
@@ -4,6 +4,13 @@
 
 menu "Starfive PHY driver"
 
+config PHY_STARFIVE_JH7110_PCIE
+	bool "Starfive JH7110 PCIe 2.0 PHY driver"
+	select PHY
+	help
+	  Enable this to support the Starfive JH7110 PCIE 2.0/USB 3.0 PHY.
+	  Generic PHY driver JH7110 USB 3.0/ PCIe 2.0.
+
 config PHY_STARFIVE_JH7110_USB2
 	bool "Starfive JH7110 USB 2.0 PHY driver"
 	select PHY
diff --git a/drivers/phy/starfive/Makefile b/drivers/phy/starfive/Makefile
index a405a75e34..82f25aa21b 100644
--- a/drivers/phy/starfive/Makefile
+++ b/drivers/phy/starfive/Makefile
@@ -3,4 +3,5 @@
 # Copyright (C) 2023 Starfive
 #
 
+obj-$(CONFIG_PHY_STARFIVE_JH7110_PCIE)	+= phy-jh7110-pcie.o
 obj-$(CONFIG_PHY_STARFIVE_JH7110_USB2)	+= phy-jh7110-usb2.o
diff --git a/drivers/phy/starfive/phy-jh7110-pcie.c b/drivers/phy/starfive/phy-jh7110-pcie.c
new file mode 100644
index 0000000000..53bfc4839e
--- /dev/null
+++ b/drivers/phy/starfive/phy-jh7110-pcie.c
@@ -0,0 +1,237 @@
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
+			dev_err(data->phy->dev, "doesn't support usb3 mode\n");
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
+static int jh7110_pcie_phy_set_mode(struct phy *_phy,
+				    enum phy_mode mode, int submode)
+{
+	struct udevice *dev = _phy->dev;
+	struct jh7110_pcie_phy *phy = dev_get_priv(dev);
+	int ret;
+
+	if (mode == phy->mode)
+		return 0;
+
+	switch (mode) {
+	case PHY_MODE_USB_HOST:
+	case PHY_MODE_USB_DEVICE:
+	case PHY_MODE_USB_OTG:
+		ret = phy_pcie_mode_set(phy, 1);
+		if (ret)
+			return ret;
+		break;
+	case PHY_MODE_PCIE:
+		phy_pcie_mode_set(phy, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dev_dbg(_phy->dev, "Changing phy mode to %d\n", mode);
+	phy->mode = mode;
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
+	struct reg_field usb_split  = REG_FIELD(split, 17, 17);
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
+	ret = dev_read_phandle_with_args(dev, "starfive,sys-syscon", NULL, 1, 0,
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
+		ret = phy_sys_regfield_init(dev, stg_phandle.args[0]);
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

