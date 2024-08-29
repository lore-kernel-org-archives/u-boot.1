Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A5CC7115B
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 01:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2751B88B3F;
	Thu, 29 Aug 2024 03:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 216A888B31; Thu, 29 Aug 2024 03:31:21 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20711.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4544088AD2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 03:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOLKQUUaHS+bTJRsMNKFJSiiMzCWp0yot7xVCN8Nthq5f93/r6TEdBFDmkOJIGZD2HEpwfyLvDeXWwY3hkW2mHPjFApcT89pN0G1qy9F3Ni6OGKM+xrR8N4ck4u5MuZm+vbiFEhrR8U1KJy3IG28Kta+f5rXUSIY5YhMARIfxyI8t+OqkfciQCtFxNPVI8Y9kB8xzzbnpLYaX4zGLGHDyR4SWJuQnaUGeJbNIrABUQUBPB0GrIJXH+ccfK+oLWvI7UCDyJRGdcZe1gkkMoL/YKNtvZRY7WO0u4LIsJQRHrwRdEr60vPTNcZeBbEPyoxVwdyF0Khd02LJm7Js8vtUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4sBbbaSlku6jLAWUAYlOE7NYoaNDEDYelFsdmopd3g=;
 b=dQlEs3Y/N7zblGOXdobPe8jVIzRo30rtnq7M4DXpEBV4jEUbBsCMyV3LNo/dCzdzNp4VOEW8ReSJOK27Dk0IABqSf67l2J2I5p7I0HVvWGedxTzBGaxl7Cn1Tb9+VHBDiehYCcGPI6u2E1M9tTM+5JBRbSEmWTEnhwHLbAqvlkwiwVV8Cbu62/tlazG9U3vSV+9qnfTbKYlT3bmmd/DWzMWOoLB0PC/2200gkQtAKksMJpPlJct4YfMn3jtD614QcLIWRYj4O2eUNYELzXxAKVsTLZHRMT8PkUUB8XhgMEPcBIBqLyjfEUXSZ9sPBIGTYjqxbEpFMJVvHVo7/l7aAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0830.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 01:31:11 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.7897.027; Thu, 29 Aug 2024 01:31:11 +0000
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
Subject: [PATCH v4 3/9] phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
Date: Thu, 29 Aug 2024 09:30:52 +0800
Message-Id: <20240829013058.6178-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240829013058.6178-1-minda.chen@starfivetech.com>
References: <20240829013058.6178-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0047.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::14) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0830:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b97a97-76a7-4468-f9f3-08dcc7ca43a9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|52116014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: atMwAPcCXmg+TS9i/Ej7/Z2aX3g0YIJQFfQ0i2o+Ebdl+gW+/UBztWot4cmUOH/2IfU0YlkIA3sDNWspivNekSRh5ptNWJMkYiv0lHpw6QB/FIoAnhGaCxcQr9Ydt49gFVVpE87HwVnpysY+s2R3j67bXyl3clNoXPp/aF/hF2/M9lms5g0EUOR5hn/+WmB9MBeczPPnDp/8CI2mhHWOCq878H/MvZNvm8YnLGkU1PNv6TNTvwENqcOI0o5RSdauRfB9AJpNUv3xH89ZtaAMUI3SHHaMc+C75CnksV/pKsp5ZV9m9Ci0wa9vX4FE7k5ZM+jLwN+8oXD8ssQpikJ30ONkC6vAzTNaUEkbbrviA9u8cb8Nwbtnx9lPEAsYo6pRv55nvkPeGp8x+jRsWsnBX98cVu+0Q1kT4YyuGJiLtzDdwpJ1+4adpDmFXKROqn2lylHDZ5zTrX9k2V5o2yRVIfTXD/JzE9SaKUQhtAbGzccOR/eMfTqEmVpQOx3XvBQnKgnXcnb53d3PK/WHlDGEeuW0qs4IxUe0AhM2eXcK3IuJsopUKfnQ8Op/eClHcUYRW8sDu7zKmRFbBqtv4FwGYT4uFdwNVyxu+TB7F56/j7Umh6DHbKccfiHE0Cm2tON7ORhIqSN+dkooAC/TNFKDQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(52116014)(7416014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6BzOF54sk4U5JDrxnwQRzQ6XJvtINlmNPv9OmlDlEdqiWrDXBsdFesSb0e6Y?=
 =?us-ascii?Q?WRBei4GLn8u+tw/q6uEy7jWeJpLu3stpaK2GaO/Tb/JIUow/6Ld16+asfWOD?=
 =?us-ascii?Q?UDCXSyU70gZZT1RTl/mQx5xfnjvzE+inkzFc3M8nfEYtBTXV/Qg2msXQM+vg?=
 =?us-ascii?Q?DvjVUGAWNUPW7FB7snK++TcPot5hPIXKGIeuNz7SK0+6GjK2lDUi9r6g4RnX?=
 =?us-ascii?Q?LNRRdHDuJ6Ke/65kOwAA8GjBtWguLiZgvhL9Y+GHn6LOOhnCLCu1ECNGgDZx?=
 =?us-ascii?Q?4C+iBvABgxfajr7tdBJR/gP/1hcFKxm0erP4XlDCUENfD8eRUw2jevClVPMn?=
 =?us-ascii?Q?S6v95/PB0YLiv73Bc7nQ4GlvqPjo1ndKi1Li/I0lJkuLnYvrldOSz5OD1Ru9?=
 =?us-ascii?Q?AwuqFIxClc249BQALgIS0MoC2aKIsLyCXvMh/88PCCnxsxacJM/iscN9p4y1?=
 =?us-ascii?Q?R/K8hK7/LaX+NpfkVA0y5iZBl+fTlHCoUY54e7jXF8fCEXDVlWEKV1QJRZZl?=
 =?us-ascii?Q?PcsUS+oerebnTxtUnsZKm1tDwlf3BMyPADYmBlCK5yeCTrGTTk3iwzUx+T2f?=
 =?us-ascii?Q?EYl866p4ECP+9GLXUD9Awin0urn4Hj8YKZv8B2iLP9Mn9q4u5bAll8aInvHe?=
 =?us-ascii?Q?+fsBQpcAu4GQHHdwJnolAb6LvuulDgm9QDjdYMwiyx9KWOrbEZrpWJBJxa3O?=
 =?us-ascii?Q?Gxfsg4EhricDQkCTB/pVi4e1m02sOUfDVvFOvhrBwz39Nbqvwq+0ahZanxLK?=
 =?us-ascii?Q?klrKIxhf7cG1MWlIWainTRxJENcFFS9yJgk5T1rYEviQUC85/NI6bX+QsGIA?=
 =?us-ascii?Q?Ecny3NnmM0xX5eIgIKy/k3ZJNIqYziujMTgc4+8GQ+7DlSj/JUUWmfMGlEUh?=
 =?us-ascii?Q?Sk0m/7Lx/EqpRufHOpc1UCeKl52XLgUY7A24il9QSI3Q8cTR2Zb2Sb/8S2me?=
 =?us-ascii?Q?ej+rwOr7fOjhKGMD9fnzzmJXBA7WQw/E0yawaUcHNo1Gjf+GkMWj+eqT1LJv?=
 =?us-ascii?Q?+L6uKr47h11hkrZz/Id4UAf90w3WzRyf5GC6ZcQJVOnYwUespOieRAoivUu/?=
 =?us-ascii?Q?91g1svthiXweSIrGE60XEzIvw6gJJTjKj8oAhyh8ZjqEmMfEz3/U480zVoWW?=
 =?us-ascii?Q?1HHQfQ5ok2RIQFT/LApPITI7IRYVbUKiD8kIsm7pzms0ejH5xgX2rGTxerzW?=
 =?us-ascii?Q?NcPuzqhgzpPBrJ9Kpw48vyUf/JTLwHQ5ED1zsq+2zFtzfLqMe+5uiu1ZYgXN?=
 =?us-ascii?Q?k0NB29QO0N9Mdv1WvGCIoqa8mvdykJLGueqm6XJgkc+5jmWaGzJO770pYsPB?=
 =?us-ascii?Q?XslHLl7tn9MNvX+uSf5U8Dtvq8K+CiuBrr8UKcijqxZX2dYfzh/l7kEVIJBU?=
 =?us-ascii?Q?c0K9GpeYp3UbEEqkvv0sR+D1B8fFkrkbP+oxffUuftM+2cRdT6v0TFVHPSUw?=
 =?us-ascii?Q?aZRvgRZq+6bkppXqB4mtlHqVgblCc9NveN2fKRnDAd5ZyijVGeHDWmxgJv8L?=
 =?us-ascii?Q?8dEkh4PmJVbTavsHJFWRvPVA58NhAhvnzA/wrpH7EyKG8XZOWPQK+LhK9EnR?=
 =?us-ascii?Q?GF9KRrDjRDXBaWXgm70XDgLRa3kEoEhuBfRAqeOdj3NHee+4dwWws+MKGhqP?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b97a97-76a7-4468-f9f3-08dcc7ca43a9
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 01:31:11.3247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlYxCU/kzOjbws9/nxrrQPVeAnkGLg+dsUOfvm+9KPJ+T6mhD8v7UVd2x92YzckshrmtOiMMm/YBYqKsxfpz5TtyUOptINJrKHRWZjNaUag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0830
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
index 0000000000..d3b04cd166
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
+		ret = phy_sys_regfield_init(dev, sys_phandle.args[0]);
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

