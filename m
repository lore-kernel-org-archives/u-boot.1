Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09036C4345F
	for <u-boot@archiver.kernel.org>; Sat,  4 May 2024 15:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26B0388590;
	Sat,  4 May 2024 17:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D49E488581; Sat,  4 May 2024 17:04:18 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20709.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A112788596
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 17:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ka7P3hXb/G7DBoIScpcnWoKty1+KQBkzpHNjSB5x+hIYKl2taawPmCleJ07V7HPReHqRl2ATZffqqjuy0TWSvePH7EEGAkTyE4inSsixe6DYc4854TK+gA0vj1v0nqMZs/5jiFRNs6hDpsl7VzfvF1s2SBtFjbycisYyMiC1JmsFuZBR2qYfSObfzyq8MPiMYFMFyHxd+D9j6m6hcWdHWTq8oEgzzzCTglNaQZ5G3jd3ZD/nNskc7cSqOWMZQZru0RsMCJ4G1xFuROaOwhHcj6opWufnzzcyZxSE13ivKuoPggvVQWhPh96v+o+OGg4Azjw/K48voZudqN7mFDevOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvuOyQ9jzU6xfR93o/rMNFOwEhwd24mCRx7TQ7qMSg0=;
 b=VTJJfaa5l9jRraM3Cx0ZBQAXwsQtxuhY21Cue0uZxaYkw7f+7xONJYQgtBBwTFY+TwyuqF/4wphcWW/FJ67dCzmb+/RXNYrGMTlUqNyM7rwnchP1u70qkOzuZYcifb5T2ddZHSWT55BSWLsYgYQUzsesi8HT2pi6b/qbBBRfRICcE0DsH8redBWiMEX/Ce3d7GNtLmLjQUoyXf0EaYSxVg4q7uiiplotqUrXFP+gMtKLHOt25PlVc0lG7ql/0170Dmmai0n4yHaFPq5lQDhkrXkSYavvisU5RwsA1A8IxfxX66WDrjc8+Un36+07eiQrMnNvdbHOEbeqP3d3h5NqWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0839.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Sat, 4 May
 2024 15:04:10 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::3e54:57b5:e3e3:7f09]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::3e54:57b5:e3e3:7f09%6])
 with mapi id 15.20.7472.044; Sat, 4 May 2024 15:04:10 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v1 3/7] phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
Date: Sat,  4 May 2024 23:03:54 +0800
Message-Id: <20240504150358.19600-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240504150358.19600-1-minda.chen@starfivetech.com>
References: <20240504150358.19600-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0005.CHNPR01.prod.partner.outlook.cn (10.2.0.75)
 To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn (10.43.36.12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0839:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f8d6f4-418d-479e-3ae5-08dc6c4b73ea
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ye5c9J0aVOe6pa3ajaTnLTCMOcKnXIriO32jbRv24qQ0czHw2skFlBIPKS/Whe1J8B19JVTSpT0727GwzqM/A+OGmoeoGhsWEeumBq9TdBCCHFBKBlKgFsanI4TRsIFUa/C4VJx+4zRsE1tgFGlEIIwkph6U8hoy5ni0RRKABcwjmvpdhME8iXD9IGTh48wExCmfFfGMvx4NErfs9xochNtAGEVLXC4eqXhQOR6y4Bo36iOPqmDYQSikcH3N4pEfunSa4Z6ViOaQ2rov/FADl4Q8ucun6u9gybNrOAvqGnwez/Ss1yBehR/3SHHWyRzbR4xSkYcSHBjG/bucrYY3LbsrvSoEFXaMa/Ygf/FNXfUzO3JWAMGBUjPDSwKr7HARIzQqOgnVg8CuVMuOGCB2zHvu6Htc15/kZRJcaJmnoTgZ5aKGTW/qMH4qlAG2XqXbM9Xuy7FSv/Q98KH7x4pEJxnUNzQlWYCo5QQg+E/5E2EdTQyHI+1xwTsd7OJt/8OVtAGHA1mhRNjLInWhOS0z+a0svcN7YbxPNfWJQORviRiTAVQpoHX5B/lZvOEJeuIbjN+bvJPK07Y6bok3tXR5Q1gOA2Ez4//ka9+akIGPuQggB/ywIS3g73toTz+zMEmk3RdjnfSGlw8lZPb1vIh9EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(366007)(41320700004)(7416005)(38350700005)(921011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/49HZZ1/9zhdE0e9uD/wQK1qSVcvzNvxPnl8PA2ThsOdHlEuGkiJ5XozFwlR?=
 =?us-ascii?Q?YK5hGG2Ihx4Jft65hG4xt2XcD2MkBisHzl0OieR8vhUG3fewSrtv0KT1YFWa?=
 =?us-ascii?Q?/efW/jEUH06j7SLZN87E61FdWkLMQauPqwrdxr7OlYJN/9hI8Ng7DUpd0z0/?=
 =?us-ascii?Q?brDiF839Np2GC1pd3KNXIeEjG1FI7vDIbK+olsjnoww8kN5Q+pAsobM5oEJ/?=
 =?us-ascii?Q?/NQBv4VC5s/fLaRd+WBS9N1GwU97inf3S+lTDq+xvIT2fcCXp4CWXjUYChio?=
 =?us-ascii?Q?EXwJJeXE/J2Ccr19dABQwzbjODMetSPsBECRic+FAmB63O5uMXdCueCd4iqv?=
 =?us-ascii?Q?ObPHxUKZJgtSAD/M+1AbvmZ6ZHftdn290aABENaSoD24WuTdaufm0kgqs2SA?=
 =?us-ascii?Q?T1d/YXgWd5wu3c+IVlBfafg2tw88/MKVN14gYD+kGB4dSdjQtiggW5SbcyBI?=
 =?us-ascii?Q?KCWfQDQEzWyBfDwKWmpH2PFmf0YtF4K4Xwox0m2vw2wZwqH4LI1gbmuFwQ+Z?=
 =?us-ascii?Q?V0heER1LnmodqzPyDNwaPt7HB4+tBe/RbkHMwc9twBIuBAaviX/9jiWzf8KR?=
 =?us-ascii?Q?pP50lgDBZ96f2jC4bsnvybNIIEobkk5uRPYhtRZDsH/Cv1gF/iSiC4S20mDj?=
 =?us-ascii?Q?jTcxb7MLTexEXMHL3AwxqI2JQ5FG8+zpZoDC6k80XIOyBqhQX3r/sXLURdUc?=
 =?us-ascii?Q?LSg2S493L8jgcoaUiCNuT8BY1qyMuDW5NW+UBYEGwJ5H0nR2x93YK03lRYgZ?=
 =?us-ascii?Q?gxXQP9Ak6ba75CR1Nc7qhjm4pKKex8ZDDz5llDFezwW8dJX9pzuqIVkQ7oko?=
 =?us-ascii?Q?A0ofQsIml1HxchTLWMDSy1JDEjG+lEL9E72tbVuEE81ziyemYCLCCJhG+wlY?=
 =?us-ascii?Q?1kgDL+19N4Ddql2CRpTHSC0wqTfx8OMbZwbYJrW/i85OLFGPYbOg3JA714RJ?=
 =?us-ascii?Q?om/hI7k/8JAmbAjGtYrQKmVfUoX4cTiQobn+DK8kLWRSEjycEqcn76S9Qhuv?=
 =?us-ascii?Q?oTQxh/Xxf1T2HxA1ymerA5hRSivvCgDW7RZg3B5cXNKD4Urjhod67YcOpiK0?=
 =?us-ascii?Q?9njWSK8ktpCnhAti8Mjm4+DR8Z2Ejl5OGjL7zTo8bmtrdKP8F6je5k2R7SqV?=
 =?us-ascii?Q?WPnojFUuhOkiSQJVQ3nCHGuF/juhWLNpgoVTBJRZz/YRDtqLcZbbTGFY7kfs?=
 =?us-ascii?Q?UQDOFYttj0YUGqnUAUJi1/oH0t6yo+WZDso8gVDPTrO+bWEf+QY1sRCesJxz?=
 =?us-ascii?Q?qfocbQkwG2zYAK9VrTxAE4SP0lKNL/FD9jQscS2wdoJMzwWIqQTPlZwH161N?=
 =?us-ascii?Q?VOWmOiO/apoYcyguCG3w4TGyW04BavN2QFsgfhBiZLHmkamCEY/3GGlBIbc9?=
 =?us-ascii?Q?KAbktRhkDzQ0iiLehqoL8sw9icxBd+ZoDSbVvwsaDLGQt4PPkPgAWPALCnNm?=
 =?us-ascii?Q?KFY0yciABL9NcPahyf9MLCKuUWD+ILH40mXgx5k6s5gBg6CPNWoSR9Dm74Hk?=
 =?us-ascii?Q?6uIlKx1qZShvYvs/YL0nyVNSyPGLNuJnrDewFuXn/KPw30pPim6yKRIm+kX8?=
 =?us-ascii?Q?s6CcIkY6PHjzm9hd2Fk+/KjRkbeX3pr2fDoOVGTi8ShVzFIJpmN4OD8EWUhn?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f8d6f4-418d-479e-3ae5-08dc6c4b73ea
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 15:04:10.3857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reU/FjVW8hP3PwbbHilxuJkx9q4YwYjoQ9cZGsMOUvapoI7FZIFSm0Jsd3nrGt3n2LGkeHW3RZhCKXMV3wANVquLV3typnHaYYCpc/4y69I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0839
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
 drivers/phy/starfive/Kconfig           |   6 +
 drivers/phy/starfive/Makefile          |   1 +
 drivers/phy/starfive/phy-jh7110-pcie.c | 211 +++++++++++++++++++++++++
 3 files changed, 218 insertions(+)
 create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c

diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
index 5d78fde12e..eaebb2b47d 100644
--- a/drivers/phy/starfive/Kconfig
+++ b/drivers/phy/starfive/Kconfig
@@ -4,6 +4,12 @@
 
 menu "Starfive PHY driver"
 
+config PHY_STARFIVE_JH7110_PCIE
+        bool "Starfive JH7110 PCIe 2.0 PHY driver"
+        select PHY
+        help
+          Enable this to support the Starfive PCIE 2.0/USB 3.0 PHY.
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
index 0000000000..e875d6e0f4
--- /dev/null
+++ b/drivers/phy/starfive/phy-jh7110-pcie.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * StarFive JH7110 PCIe 2.0 PHY driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
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
+#define PCIE_KVCO_TUNE_SIGNAL_OFF	0x80
+#define PCIE_USB3_PHY_ENABLE		BIT(4)
+#define PHY_KVCO_FINE_TUNE_LEVEL	0x91
+#define PHY_KVCO_FINE_TUNE_SIGNALS	0xc
+
+#define USB_PDRSTN_SPLIT		BIT(17)
+
+#define PCIE_PHY_MODE			BIT(20)
+#define PCIE_PHY_MODE_MASK		GENMASK(21, 20)
+#define PCIE_USB3_BUS_WIDTH_MASK	GENMASK(3, 2)
+#define PCIE_USB3_BUS_WIDTH		BIT(3)
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
+static int phy_usb3_mode_set(struct jh7110_pcie_phy *data)
+{
+	if (!data->stg_syscon || !data->sys_syscon) {
+		dev_err(data->phy->dev, "doesn't support usb3 mode\n");
+		return -EINVAL;
+	}
+
+	regmap_update_bits(data->stg_syscon, data->stg_pcie_mode,
+			   PCIE_PHY_MODE_MASK, PCIE_PHY_MODE);
+	regmap_update_bits(data->stg_syscon, data->stg_pcie_usb,
+			   PCIE_USB3_BUS_WIDTH_MASK, 0);
+	regmap_update_bits(data->stg_syscon, data->stg_pcie_usb,
+			   PCIE_USB3_PHY_ENABLE, PCIE_USB3_PHY_ENABLE);
+
+	/* Connect usb 3.0 phy mode */
+	regmap_update_bits(data->sys_syscon, data->sys_phy_connect,
+			   USB_PDRSTN_SPLIT, 0);
+
+	/* Configuare spread-spectrum mode: down-spread-spectrum */
+	writel(PCIE_USB3_PHY_ENABLE, data->regs + PCIE_USB3_PHY_PLL_CTL_OFF);
+
+	return 0;
+}
+
+static void phy_pcie_mode_set(struct jh7110_pcie_phy *data)
+{
+	u32 val;
+
+	/* default is PCIe mode */
+	if (!data->stg_syscon || !data->sys_syscon)
+		return;
+
+	regmap_update_bits(data->stg_syscon, data->stg_pcie_mode,
+			   PCIE_PHY_MODE_MASK, 0);
+	regmap_update_bits(data->stg_syscon, data->stg_pcie_usb,
+			   PCIE_USB3_BUS_WIDTH_MASK,
+			   PCIE_USB3_BUS_WIDTH);
+	regmap_update_bits(data->stg_syscon, data->stg_pcie_usb,
+			   PCIE_USB3_PHY_ENABLE, 0);
+
+	regmap_update_bits(data->sys_syscon, data->sys_phy_connect,
+			   USB_PDRSTN_SPLIT, 0);
+
+	val = readl(data->regs + PCIE_USB3_PHY_PLL_CTL_OFF);
+	val &= ~PCIE_USB3_PHY_ENABLE;
+	writel(val, data->regs + PCIE_USB3_PHY_PLL_CTL_OFF);
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
+		ret = phy_usb3_mode_set(phy);
+		if (ret)
+			return ret;
+		break;
+	case PHY_MODE_PCIE:
+		phy_pcie_mode_set(phy);
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
+
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

