Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33383C282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 06:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D14C181273;
	Thu,  6 Mar 2025 07:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 080C3810ED; Thu,  6 Mar 2025 07:21:00 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20731.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC4F5811C1
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 07:20:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8UdrsdmwJb9pSaTrQiO6MbGlnTolv/h90U3NL6hgopRHt1jXVbmvOMesHF7aTMAgHBXKocLjh2UKNyFOU542JK+n8nwQVUIbJiW65j8GnKLL26R0n7A+ugDWqvawwvKghdLpgcdWaTeU4Sn+epow1E6Jcqr4Nn+y8b9IBdJ6ZY5FXxL+vOg4Ay80XV9AUgUMDYYPT88flOP3+6rrnYlYXwqy4PLYlqjcvARzxiSiSX5zd6k20M5TU+Lqb3P0k4HnUL7iCaZwoQwnIho7Vy2sSuw+iYiyFNKRlDfIwgXrHomTQwWGxKRYD1g4iokLajOpjU153noWZspzng9zOxQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxdLBJSsJnRgNQ3W+OciEdsz4kmR+paO4jVDXYhP7E8=;
 b=T01fYPmnj+o/W/tJcCOhoMJQR1sPSKdJUOYQtwLOJX64XEIHuOKCtYuhCtfW9mRUuwOHq7UYBFWV5BL5CYc48GgVSh7dC06hYrsNAUSDn6+Dv64xBEBKvp0ymVo+lphCSbIXC1FrNyY6ixe0cSHHnMvV1O0n7QsqvcTxiAX4tt3VFxkmgyNKw/hZKSsEZlKyv4fQe6GzgYyD18e1hVhSZ3cOvMeVbBkdEnyvemucoaF7ckgBF68y9w/GF4City5Kse0NHSy5i6AFpgDhNWERiXRL+mLGa8cZanzSY7VwO/V9fxzecW6qb/BifW81OvRH/vB+jvN6iwT0F5eDk+tT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.30; Thu, 6 Mar
 2025 06:20:45 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Thu, 6 Mar 2025 06:20:45 +0000
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
Subject: [PATCH v7 3/8] phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
Date: Thu,  6 Mar 2025 14:20:27 +0800
Message-Id: <20250306062032.50314-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250306062032.50314-1-minda.chen@starfivetech.com>
References: <20250306062032.50314-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::35) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: d75a8250-14d8-4a6e-7d07-08dd5c770760
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|41320700013|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: hxq1MsSKEayxAFfVfVEXOFx7GQF5bCfeg5sDZQXOU9iqCiFNyLuxftQMMwjhs0INSXCul7eBnMdsWJHz8G48x4lhu/1LNu2CMBS2AZNvk4FSs/7A9ZoHCj75Q96eLGAJRs7CjOQGgf4XXFw/m99NUmvv0tOKBMTjBFamMrinTUc+CyFbUAq1ZoaTCOMKInQFfLxDXkRuHy86OsTvlvaGllxo4leTmEYRiGe/SS0wvbOnhGubjPt733VMZvL9kBXxebYycA2d2iTdZcf3VUtWHMlU/46RqvJaMThTcvWyYfObvCT0zjPy/51gu3Vb8doZEWHqd8uuf0NVUcXSd1SSuU6VMHGPLv3rCeImIOseEsxjzxRmxHzc06Xk5rG9I3/gJx9/cZZQMeHp+WjOEbUr1wjDnuj6YDqjxVSMCICFweENSTompNN36i+ImRmUnxdWdM4gDp+nhHFrNPErXJWy7oYpqotQQ1OdRAvS+nIFQa9JllZ3Ju1bQrBZVk2GIg0ok7PDyfW5ctku6aE6cGakjRGodP++ZVpyf3OHWiBoagrgNQ6aPjd37Cr2AHhXLvNssKWdlWOHzGMCQ5h+KMZ2X77yzQ3Ew/mNSFdpwEXhgOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(41320700013)(7416014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xWjxy7LuAVsi4yw1mP20d9nPQ41X7+y3J0/PrBAAvHQoXOgq0ynpywamPcQ5?=
 =?us-ascii?Q?bIJPyQ7d3PUmfSUGpht15FkG1ysTvA/c1K5/+be+KfBJvhFa4OwoxtxMGRga?=
 =?us-ascii?Q?7ReFNsLNfi+g9MMosBgg0cJcsymc5knqD6diT56lRocLi8nk9rDl+Wh4nxyB?=
 =?us-ascii?Q?hU0HCz4oglSHdIDVr8p2mE/dd3XbPARFn1tQRACwmTvG4zWnEqwQ4hCHFCZM?=
 =?us-ascii?Q?hhq851TgTF/o0Z00NCqu+e9O5BP0uCVVJjj1CFrbERRNipUon8eHFxFAKrr3?=
 =?us-ascii?Q?wXuPHj8PUfat+P7c6HqF4+X/AoNDgEKeZ8ws5FbxnLOJVLGieJeQYNHlR9gn?=
 =?us-ascii?Q?rE2+DSWIzhf9ulBuSTa1Qb7FATJ14fSNVr8I2rqqVB2wnazbQEOvZWzWWkx9?=
 =?us-ascii?Q?91ORKkYUWY0Fe94OKP6bw9QkBhJrpKJgBC9+4MxjJ2PBFROWuluYrx/dlv+0?=
 =?us-ascii?Q?VRmHabZ9Aj9G2wxLK/QneFJVfcXoiLDXn09NatwdCf1qjfHGIq29wAOhW0k6?=
 =?us-ascii?Q?DObRukO8bKPQmQ15a9QVb6L0m25kztZ2mb8oX82AzRaWKtfKS9nCg+w5toz0?=
 =?us-ascii?Q?GZHa6qAOTOYtqe8TBzlq/XOlR6j0ApzEmOtu0YM6w2vn+m5nDTEb5hQlWZ3F?=
 =?us-ascii?Q?btrf7aLqCgoh9I7hdXrFXxisew3Op5AEID0r0ZJdtokiH0jfqMtZa7udy7DJ?=
 =?us-ascii?Q?keiJaE0EfaN6SWEWePkdqi/NgMgNmp2v3VR9VPknZ9gxR5WyH5AOdTrK3pnY?=
 =?us-ascii?Q?AYtlQ4x+Pj2R1ZzEIew59tR/d4z40dZEbJ/1IncGGziBVoBQexkNTZ9zsMuM?=
 =?us-ascii?Q?BlTuDZcThirTCExpjmTfRykMARld6BvItvLUVTTwTz+emz7Ety81EQLzyDGq?=
 =?us-ascii?Q?vNI0AhpSbWLjzWdwitTUG7FFbMvcxnnhiUs/iNL5T8w0qdoi8p7ehbpda7AY?=
 =?us-ascii?Q?gbhQQChU5YE1vksGnuoREf+QmQ6PL6W8YgQOWBGyj+rEiw2Q/DJRrlftpQQ3?=
 =?us-ascii?Q?39S2ak1lkR3gLBh0s4EYwiycf0MUpcGCCT6rC9S4Q40KSDzxZnfzFKemUpNb?=
 =?us-ascii?Q?9Q7erwHy7+kmxRvug/gNEauW8iChDYZLuGOvXUxzrbwHxrycXb5maPyktGkZ?=
 =?us-ascii?Q?KjmMm1w2hYHe6UHF9Q9nLYpGPtp+Y361442QBKjS0nn38ceztPlT6LVezGWg?=
 =?us-ascii?Q?z1693LmGC3rax76w2wDihLcTZwN0quGMF0Ifhj7sRrTpIG+AdQIdjRrPhMLJ?=
 =?us-ascii?Q?lTUYv7BuG0HcQHkrVH3DUg9FZ9lOk08Wp2El8+Dr808jk+rfCw6JOiK4yty/?=
 =?us-ascii?Q?zeCjoRpNnolcrvGkNdtQsH630snNLY7NCS3Wd5Ik3ULi6KzmuOaimmkIJuL6?=
 =?us-ascii?Q?n1X6UzAB9sOMrUKBFw/Ae4umDyUwPj9k9z84PCLV0KO4aOWxGh7X9fjEOSgG?=
 =?us-ascii?Q?Z/0HDUanTp03pVlQsdIvrt1NGCD29LtTFBhgHOhXR8aogGLF31lgpi/9V/A7?=
 =?us-ascii?Q?fjw7o8wRnw/1N3cOrql0TBtvNdJh7gjY2TOVypZ8BnypPoNOJVPB3Fl9kGsB?=
 =?us-ascii?Q?8I+WIJ53NN9o/sb83vzKTgQZ+9iG8NFBsMBN1ftbppPtXDolfKNFaiRACm3L?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75a8250-14d8-4a6e-7d07-08dd5c770760
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 06:20:45.2083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjsUtRknPV7/lxdHH3pVIzwuSmKzibRYJE9/T0mlAH8rQVpEuwhba86aFBw+q7yL1C/MThZ1PjepR1orYKi44CbTikQP/HRS30SLHLyMw14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496
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
Tested-by: E Shattow <lucent@gmail.com>
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

