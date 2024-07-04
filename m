Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01633C3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 05:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1D79885BF;
	Thu,  4 Jul 2024 07:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D4C888885; Thu,  4 Jul 2024 07:50:33 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C82658888D
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 07:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1xFpza8U7WMAZYDnRtX4yE++i/S57bch/6Q/HtH4RGuBvSrUEuXwMEehk8xSf4/ngb7rwIduwjYguRCai0hjW35xPWfpMqGubFR47QX/A38GyX4Jiy7HNP9ceZDrjh1Wht6Enp4t30vdiHaZUSGB0zO7SSTyiQJC2KYwrH0Hbx3c1L3w5PFpqKK9ObpGNQFJv07yvq1i62A5z2wTXi1jXyxsS7051hA0DQnMnYmYC5UF50J27LS6PngU+n6CqjisUqx2l+/WzjoxaFatpvRutYv2WXdGaC+7qiD2/O3cNDyG13b9P/lclUM0jrp8zXsJdGGSi88n9DfMAiTQdJ0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3OwfL+cz0add48gkmATESCH7dzfyEcUvrVlbZM57gE=;
 b=Nhd4nWHgmp8dmVtD5mJCgVs81R3qdYqVFrpprgQSnKJA+AcVn1lgPpU6rasFXTtiZHX9yfPa+sQWi2vaxvGgooH6Dk1IusdQ8eNFizEJ+LGEwKj+4l97pqQeAqSPQFXq2j7SwrEGxvBgDLAat6bWB52+ZBmLttg/x2I5CQg+G/GJQ6igiWeiMG3KQ+W/7u3uAQw6xlKmniIsKwWfkhPjZoCQb539DiV4g6gnWDVX8Uw+B09mutqe5aNlC+CIvIpLzZxo/1SeIgloUUcppKEZQiID2CNeOH0PMY3FfOA+p7Ge3PIRA6Z9701QMw5ft7GM0I06HkjJXzxJcwdbQS9qkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0766.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 05:50:25 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::358e:d57d:439f:4e8a]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::358e:d57d:439f:4e8a%7])
 with mapi id 15.20.7719.029; Thu, 4 Jul 2024 05:50:25 +0000
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
Subject: [PATCH v2 3/8] phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
Date: Thu,  4 Jul 2024 13:50:09 +0800
Message-Id: <20240704055014.55117-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240704055014.55117-1-minda.chen@starfivetech.com>
References: <20240704055014.55117-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::21) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0766:EE_
X-MS-Office365-Filtering-Correlation-Id: 18dc7a59-f4a8-465e-98ca-08dc9bed335f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 3LDhLMzu6PbNNQ68UgTXzmdxv+T72x5FDCKvnx/VXE9U+wbuOGz9dFb2bkc9bzKTVSFMxbdXjvUjTThT3G+i2NO4cKOMwjh6qZYL4OzpvQzlukFs2v7lVpU4bM823S4LoNN6l0c1i/wk5HBJzkyzXzOmf852aAR8zt50u1aerBQEhfthweda+t1y4afzrr3M4Y4XH6XiioNzTMlwcfPM9g5EZ1LIjJapHwP5ty2lhxUjnKSPMscpzC3fKWisRGiuJsBYr2S+aeKM1yv6+GxhoE+xgg7Uot8netCTGxYKcrL5C+UiQgjxNmDd/cC3nYA479IO6hPGtft20/Z7FeJsQjyeGeecshn7NsNbx6qieelupoLA0FYFN3YE6w9BbuExhvRqmOsZedvcYhFP6fEtlMzdU9Qe015ymbezyIUZZS0OM+LCfCmDDsEB7o1AqYTOcQiKh6ndTbCMqfrXEr69SZjMYqbYzC2HPaSX7iHeTVrxgcl7PWC1TEnPvTRJkkp7khx/lwkthPljoRLyBFodJdPlPX0IafFfnf8WwQJamxLwJQ8rK1CG3qYtmZNzDpDzpn46bvCgulWlZaqNDBTxa0Yhj6MkgojgJTM24zYafRfertOPgwiZyF6VPnn5kfObhw2rDWgC6f9r9SaAG/j3oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(7416014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sQonu8bkPpzHdqTwmigRAkPgg4ctOVNupnZsqkuxt9hJPm9Xnp4jFwCmEnJs?=
 =?us-ascii?Q?TsJQY5RPzHLlYrhAW8XimLK4/qV2Q6zCFnbvZ14XbaNObOot7N+DQ/v8CQZu?=
 =?us-ascii?Q?+YuET9bc9dK/KDveVDjYyHjoYzqtODwvvtZ/GC5rAG/lFKYgGzS1toGocEnG?=
 =?us-ascii?Q?0MVG+N/HZVuNo3u6HGL6e/epfm/e3hL3B/9ly3RWamTABxSuP2kUrOBgkR7b?=
 =?us-ascii?Q?mZNr3EwP+0bsQrRqczYoz2V6Qa+OFFjebYK4YAWFZvL1Us+ChgkUjU1mXD+1?=
 =?us-ascii?Q?WfysEvCBicIoDVI/4MNSi6FEZPxVgXs95zqQe0DVPl4ywGsF6vM9sp1gkNFu?=
 =?us-ascii?Q?FoTd03qi9mOpA4FmOzXo1Z1B2MFuFFuf46ioLmiwvpVuQS3bmJaEDurIEUJI?=
 =?us-ascii?Q?imc7KQkLxb6LAvB163W4PgepbwWEROBYJFfM82vEDmkIz9RFvjt/8HoupPDa?=
 =?us-ascii?Q?O0R2EGIXDZG02Prt/t7gIcwoHqjYKk8oJBInqlw+ez8nm4dnjuaXxwr+bjw4?=
 =?us-ascii?Q?TSCnTfG+7KQfJNFKBjTqnB9K6g3KMTBnFZHxLvEXP0EtTgorckkk4C2b+V+r?=
 =?us-ascii?Q?n6lEXpJw5A1wCKP6icygJxmndVqL2wICXw22oaA1YDTFZyDgV+J4frunEwwf?=
 =?us-ascii?Q?EGYSQcWxeW/qVPsqb6lvQlR4uVjv2HUEY81TXfvpunt5vsBjlL91LtV+J5Zx?=
 =?us-ascii?Q?C9s312nVeJk1Mmt1KtQwCIvbs8OBqq3S4R95fXt1Iabg7VyLBwbsXHxOXiDx?=
 =?us-ascii?Q?0xhdChASUe5MudsORib2F8L8+35F4FUYtrUrAAxB2OiDlzVTU3XwB/SE9x/M?=
 =?us-ascii?Q?G4q2eA0Rs6bHVw4lCBgpxSfUJ6HHDH3pTisV25aUIaaXGqcC54FImS5Fulnx?=
 =?us-ascii?Q?KZHwnV2jxBxx3wmYKSaGQUcnQg81MWiJ/riPPXr4jK0Msq+wfrb4MUycatCe?=
 =?us-ascii?Q?IUSg7g7T1hG7v5inUpzA02unN7BsL/MrSPlXDrEq3yhFiSgg5IlxzgFiYF12?=
 =?us-ascii?Q?78fCLh2E+Wo1vDQLeS2+UAjFlOD4C5X/e9MTjxUvr6lyR/bixOgIqfHzNpnL?=
 =?us-ascii?Q?J8NpgY1VwcifXPrA846gxr14EGiDadsSwFSO5jkYjwEJc/aYaRCwmO+yUT8Y?=
 =?us-ascii?Q?SAAVc0WUhoEEhGNmlmWNHtxb4X6tWFXXa8auuejpso1fBwk+uhzW4IYC/dIu?=
 =?us-ascii?Q?nWuxLIXoSAgz/yaa+11IA06voKb7qo88DnjYPtsRR76f83CIshVttD68D8aQ?=
 =?us-ascii?Q?1/K8BMVFE3x8D8t1Lamm0q8wWt3xdIzGATZd1RKSwO0Zxl20IejcOgUnb8pt?=
 =?us-ascii?Q?pozto6Hn7/e8Rf/efSQ2AcRvDisJpmZNd2k4yf9eJCrXSkXkDQ8qwPag8L+U?=
 =?us-ascii?Q?dDDzH3sjJBsDEHKIt2Rr0shwzPd9Qlm3bTmSagtNKwe/evu2Dqv0u4eUJZFJ?=
 =?us-ascii?Q?hzvMoYA+ffh6kQpt4wfbM03JrMusna+B4VNZLCq35yWY8Jwb143hjO/KjOXS?=
 =?us-ascii?Q?uIA1bf4HQowk+AHTIQB5eeTCZOArTU42qnliLgTsRf+bc7Wv2UGHpNHhpSMy?=
 =?us-ascii?Q?7vtYNZpBjpEukHk5zOR55Ayxhw31i220lyZm16ZvRSa+m663UJ9OiBvg+pqV?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18dc7a59-f4a8-465e-98ca-08dc9bed335f
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 05:50:25.2198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVXgF88egLr+rGT/llPE9DIm6sNInfAkRhSo01+C6MJADwPMjpYjOvheEZgtU0fEnVis+iWytPFvqWY9ofrTGMPnTSlnLlXZrpv6zOeCA5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0766
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
 drivers/phy/starfive/phy-jh7110-pcie.c | 202 +++++++++++++++++++++++++
 3 files changed, 210 insertions(+)
 create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c

diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
index 11a819f8b2..5d49684bc7 100644
--- a/drivers/phy/starfive/Kconfig
+++ b/drivers/phy/starfive/Kconfig
@@ -4,6 +4,13 @@
 
 menu "Starfive PHY driver"
 
+config PHY_STARFIVE_JH7110_PCIE
+        bool "Starfive JH7110 PCIe 2.0 PHY driver"
+        select PHY
+        help
+          Enable this to support the Starfive JH7110 PCIE 2.0/USB 3.0 PHY.
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
index 0000000000..57d5d8bf53
--- /dev/null
+++ b/drivers/phy/starfive/phy-jh7110-pcie.c
@@ -0,0 +1,202 @@
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
+#define PCIE_KVCO_LEVEL_OFF		0x28
+#define PCIE_USB3_PHY_PLL_CTL_OFF	0x7c
+#define PCIE_USB3_PHY_SS_MODE		BIT(4)
+#define PCIE_KVCO_TUNE_SIGNAL_OFF	0x80
+#define PHY_KVCO_FINE_TUNE_LEVEL	0x91
+#define PHY_KVCO_FINE_TUNE_SIGNALS	0xc
+
+#define USB_PDRSTN_SPLIT		BIT(17)
+
+#define PCIE_USB3_PHY_MODE		BIT(20)
+#define PCIE_PHY_MODE_MASK		GENMASK(21, 20)
+#define PCIE_USB3_BUS_WIDTH_MASK	GENMASK(3, 2)
+#define PCIE_BUS_WIDTH			BIT(3)
+#define PCIE_USB3_RATE_MASK		GENMASK(6, 5)
+#define PCIE_USB3_RX_STANDBY_MASK	BIT(7)
+#define PCIE_USB3_PHY_ENABLE		BIT(4)
+
+struct jh7110_pcie_phy {
+	struct phy *phy;
+	struct regmap *stg_syscon;
+	struct regmap *sys_syscon;
+	void __iomem *regs;
+	u32 sys_phy_connect;
+	u32 stg_pcie_mode;
+	u32 stg_pcie_usb;
+	enum phy_mode mode;
+};
+
+static int phy_pcie_mode_set(struct jh7110_pcie_phy *data, bool usb_mode)
+{
+	unsigned int phy_mode, width, usb3_phy, ss_mode;
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
+	} else {
+		phy_mode = 0;
+		width = PCIE_BUS_WIDTH;
+		usb3_phy = 0;
+		ss_mode = 0;
+	}
+
+	regmap_update_bits(data->stg_syscon, data->stg_pcie_mode,
+			   PCIE_PHY_MODE_MASK, phy_mode);
+	regmap_update_bits(data->stg_syscon, data->stg_pcie_usb,
+			   PCIE_USB3_BUS_WIDTH_MASK, width);
+	regmap_update_bits(data->stg_syscon, data->stg_pcie_usb,
+			   PCIE_USB3_PHY_ENABLE, usb3_phy);
+	clrsetbits_le32(data->regs + PCIE_USB3_PHY_PLL_CTL_OFF,
+			PCIE_USB3_PHY_SS_MODE, ss_mode);
+
+	regmap_update_bits(data->sys_syscon, data->sys_phy_connect,
+			   USB_PDRSTN_SPLIT, 0);
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
+	if (!IS_ERR_OR_NULL(phy->sys_syscon)) {
+		/* get syscon register offset */
+		phy->sys_phy_connect = sys_phandle.args[0];
+	} else {
+		phy->sys_syscon = NULL;
+	}
+
+	phy->stg_syscon = syscon_node_to_regmap(stg_phandle.node);
+	if (!IS_ERR_OR_NULL(phy->stg_syscon)) {
+		phy->stg_pcie_mode = stg_phandle.args[0];
+		phy->stg_pcie_usb = stg_phandle.args[1];
+	} else {
+		phy->stg_syscon = NULL;
+	}
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
+
-- 
2.17.1

