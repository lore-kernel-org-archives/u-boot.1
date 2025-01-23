Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D07C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 01:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9536A80586;
	Thu, 23 Jan 2025 02:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B073805C5; Thu, 23 Jan 2025 02:01:34 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20715.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::715])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1634F80275
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 02:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiP53MveBzC0aP1JiRO63H49CCNHBZovqhoeUzXGtrWDR0u2dEtcmVBb5BNhlkkPBRW3PbIiwUjVRoABnImGwEEgsyDtLQIMlxKokdfemUw4Pnus2eZsbLvKKOsv425H8YqOXcq+qpR3F1DQTBJKSoh5c7V8fucqiRp5N/9OlIJ+dJlQ4TixZnGILso4vhuVmeSpVxUb+e5pMDcpZEWEwfdzzjWn00vI/5mes9r2UTXD40NyJtsCGqQ78hwwXw5x5JmeU6Fvhk1XgYymFInJy9iKPNmJaYo9OatgtyJt3UWJpcI0+0b/k5M7QlyPZBO17DSINMiN9LHBoQcZ67t3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlL+T7nX1Z1ZhZ8pI1i7FDCxrA5NNCN/4G+Ek/mMtGw=;
 b=C05ZNfWjxtvDab3ydGn1WJp+C2EwWbhHVxcEB/y9BwRLIr1SPZlaooKwJqIsNOAS76fK2geHMLqc2SlydHZCOXfjfmJf5SEcUPe2s7ORjgaiH1fMyrPdENPXB6zQmvafvAhYP10MMRxHH/w4R7JD0dOOUGyskiD0fjUkLwYLW7/qny7oKAx6kQLgTkMSkKNegI1gtdNhFAFDkjrZRNTRWnpJ+uDgWlXLAu9NCKKYi332VOJZugaF5WLg53EmjgKxzinvPGQdzRqJPRECw8Jufq5OS9+R2/aVfnW4zWing8phJiOp9FvbKQNzg22sLr6FI1FoeZnalZ/puX9ZNec90g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0813.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.8; Thu, 23 Jan
 2025 01:01:23 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Thu, 23 Jan 2025 01:01:23 +0000
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
Subject: [PATCH v6 2/8] phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
Date: Thu, 23 Jan 2025 09:01:06 +0800
Message-Id: <20250123010112.78924-3-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1b539da8-2d60-411f-f5ba-08dd3b4974e1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: uWvuwdaoGroQWHeGyGFK4V2femly+2fXIFsoeu/ODZ6yfRVg7jX9k4j3/1+3QF1QiDYY737+6DvBTqEqdGMV831dTe3S6fmodIdccN19VnScSokgZm1c57mYvlXkYErsA0pAQQK9WxjUL0acxmdrjRTODVqHpp3oDWVmtgqdfq8PDwQbBY4eAdR8zxAdjHpsQzYe9mvG8aJ0tuYDHcb8V2DFls87UEwdSedXIqb6mmr652GSHlDsQ4LpcsmoeG2U8J/9om6BD7SFCymYfZHSq3DAOuPoH63AcB95GQuuOJHVcxRLv9HkK7hgvmpWCv4K/kbNk8RAdPR6LUDbVwRpStFZUrdT5uDW1lYeydWdh9S7dJZci0+Sra1TyBt72sdDsBPT9w8ttN4/d90IP0HUsYkvtIm2NWR3ksOFrC8ttilrNQaZuo+1kBxIW37u4aZx5xCJweHLik/hL0JSYB32EIRGq4944od1GDu4FCxqLVMfeqWRObFUtaJLGPimbveHQzYN1uA4bxFEhAx8XVNKAzuLotVH1nvfPgWFW+2Rr3n9FtZabGwfQzdX9/wUyENuuz+lgwi+gOxvjYU3+XhaNErFIbz7+4dYvy5AmmH/Ja4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rRmlNHCpcMIBBrxOUxgtfoizmx3WKoWBwwCqHVhWH8iIIsULH1B6lEsLMB8y?=
 =?us-ascii?Q?78e43UPgDiL13pjJZtnANzcKL8c6YsNK3rxGgbx2kBRLmiSFfGjzeffG6QOV?=
 =?us-ascii?Q?wdTVU+OFn4r3Lcs8b0XDBYppsU6fSiD8+TgpOWPwooQzyiRJVL9eDoE6jbRh?=
 =?us-ascii?Q?qvJZLsDQonv8/wh2QkngXkTxIr4OAWLNXfJ2IHbypK1dYt832COSLJbmPppx?=
 =?us-ascii?Q?qAhiaqqrtn6Xe/IkJcqGn1ImmjlkeIboHvnSJAcaib/pMKJYyG7srnOtKHgS?=
 =?us-ascii?Q?Hbrd3V6f3AAIdyr30rFC8pi9BoMbgoCkKBWL54cJ57tDuRT4pZlD6uYOseW9?=
 =?us-ascii?Q?oN0lv6rdNCixItLwVRAo4AuYbA4oD1MC3oSdyOAx56q+iPBYnpGNK8LDrbuj?=
 =?us-ascii?Q?oU7qtROUJ/eoqvoBwYjZtQ6t/sB10RYbVMs3LN8P7x4rr9ZnDu23MItWH8SR?=
 =?us-ascii?Q?tiQa/wDBdbeFlVj+6U6iS4kgAIa/ndPoeME4h5wMUXfDAgezXRygn9cM2238?=
 =?us-ascii?Q?tmfzRY9lnnIVFwCZ2VsejqsW0a/PcWlK9zhmpxzcUGWI7eoft1KdE7A6QIm+?=
 =?us-ascii?Q?W52fvbluZVCh4/9VFZDqWycL6jkBeZ8lZvjKKC3rbce1/W2QYq0Kkjm/VD9R?=
 =?us-ascii?Q?aEVV6LizTKhlo0g6IkF7Wv5jT8Rt4QEn4wtNNXNwNJLd+K265F8UHJ+/kI6n?=
 =?us-ascii?Q?pJCvJno65AIP60t91NjKwN/QhDm/JXR6Cs7c9xx9CIP4mLTb1Bv0MRCwNwh/?=
 =?us-ascii?Q?Zzc/F7v4cPK4ollwOK0wVOhzwPeRoeaJO62FLYL2QNUftaepyQf5v2SlspjQ?=
 =?us-ascii?Q?2zClzlIzqz63t6y7YbtduTjy3Q9DWq3zK+wh0O6HmLBPoKasVbY/el6x6O1J?=
 =?us-ascii?Q?5cter1o8MQhpmMDk3AddJbRlav2LXPx2uREmVuH5AAeqkocwKb5aGDn14XHq?=
 =?us-ascii?Q?5HRtO06gWLIF4sDsV6yHIQ0gmMMrPyXlfZ64gtIInYttVIxaWBpaq/yoFvTD?=
 =?us-ascii?Q?e9syjkH7ILDSBT8Rd+FIajkFQ151AktJ1+j0WaMKk8jy8NoilyUfoUaFttQu?=
 =?us-ascii?Q?ms07TwsgN/WezTZtG3ZQfGD2tW1Op4AGl3QCPIxduTCzDn7bzAjrmK2by9Rz?=
 =?us-ascii?Q?/Gcr/YRr1Td7Ma5veTI5yd4ZI6Gg21SJhsDMyJXZUVmxFBtBjbnx9RzUEf2t?=
 =?us-ascii?Q?pWEGHymRveAI5lMoelxruCgKUz+07BLHsn0Wcz09LwMArMLUpGtsLYSYYDDT?=
 =?us-ascii?Q?EgOfUgoTjOlsHXaNrc3fhsws2ghXESQkrzoQs5kBTnykKEcp1D9ltg/J0bV4?=
 =?us-ascii?Q?UII/FUpYe54Q0qthjNQc6DDHGeFWvys9bOEfrusEbJtqvKLcyPdYHODCzpFx?=
 =?us-ascii?Q?OF/gE20T49m57Nx9+qBE5pyg7s1FgvzLy5tR4IphiWPPcH5agq5vgC7KJqPt?=
 =?us-ascii?Q?ABZyAfnPw5dO7vompNlCHeB6SJoL8Ny2uOOxfwp16dBRrlvAHW38ONVSLTl1?=
 =?us-ascii?Q?YOW/AujbxeGkKV5tmnsetrP56TNgZqi/Bqq1x/dhs5Wq4o32ibL153jd0BSS?=
 =?us-ascii?Q?yxDLCJfOpozdmSWXe6r5ZITP6RoYCsNmzhXMIg0yANpfAlEyNEs5He8Q8FvF?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b539da8-2d60-411f-f5ba-08dd3b4974e1
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 01:01:23.7572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HC2E9gQR7d8IMBGZQn+o4fVc5Lm4vNIVYyozFGkTT1Jp0ElUNv/6rmeMB4Suvl8bzgBD46OB+thvsnLSgJtkZT0QORA5EOrmEcCahAXgzkQ=
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

Add Starfive JH7110 USB 2.0 PHY driver, which is generic
PHY driver.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/phy/Kconfig                          |   1 +
 drivers/phy/Makefile                         |   1 +
 drivers/phy/starfive/Kconfig                 |  14 ++
 drivers/phy/starfive/Makefile                |   6 +
 drivers/phy/starfive/phy-jh7110-usb-syscon.h |   9 ++
 drivers/phy/starfive/phy-jh7110-usb2.c       | 162 +++++++++++++++++++
 6 files changed, 193 insertions(+)
 create mode 100644 drivers/phy/starfive/Kconfig
 create mode 100644 drivers/phy/starfive/Makefile
 create mode 100644 drivers/phy/starfive/phy-jh7110-usb-syscon.h
 create mode 100644 drivers/phy/starfive/phy-jh7110-usb2.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index e12347e8a03..f940648fe58 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -309,5 +309,6 @@ source "drivers/phy/cadence/Kconfig"
 source "drivers/phy/ti/Kconfig"
 source "drivers/phy/qcom/Kconfig"
 source "drivers/phy/renesas/Kconfig"
+source "drivers/phy/starfive/Kconfig"
 
 endmenu
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index c35f9294dd9..ce4ea28b299 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -44,3 +44,4 @@ obj-y += cadence/
 obj-y += ti/
 obj-y += qcom/
 obj-y += renesas/
+obj-y += starfive/
diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
new file mode 100644
index 00000000000..a7cf0a55dff
--- /dev/null
+++ b/drivers/phy/starfive/Kconfig
@@ -0,0 +1,14 @@
+#
+# PHY drivers for Starfive platforms
+#
+
+menu "Starfive PHY driver"
+
+config PHY_STARFIVE_JH7110_USB2
+	bool "Starfive JH7110 USB 2.0 PHY driver"
+	depends on PHY
+	help
+	  Enable this to support the Starfive JH7110 USB 2.0 PHY.
+	  Generic PHY driver JH7110 USB 2.0.
+
+endmenu
diff --git a/drivers/phy/starfive/Makefile b/drivers/phy/starfive/Makefile
new file mode 100644
index 00000000000..a405a75e34c
--- /dev/null
+++ b/drivers/phy/starfive/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2023 Starfive
+#
+
+obj-$(CONFIG_PHY_STARFIVE_JH7110_USB2)	+= phy-jh7110-usb2.o
diff --git a/drivers/phy/starfive/phy-jh7110-usb-syscon.h b/drivers/phy/starfive/phy-jh7110-usb-syscon.h
new file mode 100644
index 00000000000..0eb66f0d859
--- /dev/null
+++ b/drivers/phy/starfive/phy-jh7110-usb-syscon.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef PHY_JH7110_USB_SYSCON_H_
+#define PHY_JH7110_USB_SYSCON_H_
+
+#define SYSCON_USB_PDRSTN_REG_OFFSET	0x18
+#define USB_PDRSTN_SPLIT_BIT		 17
+
+#endif
diff --git a/drivers/phy/starfive/phy-jh7110-usb2.c b/drivers/phy/starfive/phy-jh7110-usb2.c
new file mode 100644
index 00000000000..1a28381e0df
--- /dev/null
+++ b/drivers/phy/starfive/phy-jh7110-usb2.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * StarFive JH7110 USB 2.0 PHY driver
+ *
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ * Author: Minda Chen <minda.chen@starfivetech.com>
+ */
+
+#include <asm/io.h>
+#include <clk.h>
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
+#define USB_LS_KEEPALIVE_OFF		0x4
+#define USB_LS_KEEPALIVE_ENABLE		BIT(4)
+#define USB_PHY_CLK_RATE		125000000
+
+struct jh7110_usb2_phy {
+	struct phy *phy;
+	struct regmap *sys_syscon;
+	void __iomem *regs;
+	struct clk *usb_125m_clk;
+	struct clk *app_125m;
+	struct regmap_field *usb_split;
+	enum phy_mode mode;
+};
+
+static void usb2_set_ls_keepalive(struct jh7110_usb2_phy *phy, bool set)
+{
+	/* Host mode enable the LS speed keep-alive signal */
+	clrsetbits_le32(phy->regs + USB_LS_KEEPALIVE_OFF,
+			USB_LS_KEEPALIVE_ENABLE,
+			set ? USB_LS_KEEPALIVE_ENABLE : 0);
+}
+
+static int usb2_phy_set_mode(struct phy *phy,
+			     enum phy_mode mode, int submode)
+{
+	struct udevice *dev = phy->dev;
+	struct jh7110_usb2_phy *usb2_phy = dev_get_priv(dev);
+
+	if (mode == usb2_phy->mode)
+		return 0;
+
+	switch (mode) {
+	case PHY_MODE_USB_HOST:
+	case PHY_MODE_USB_DEVICE:
+	case PHY_MODE_USB_OTG:
+		dev_dbg(dev, "Changing PHY to %d\n", mode);
+		usb2_phy->mode = mode;
+		usb2_set_ls_keepalive(usb2_phy, (mode != PHY_MODE_USB_DEVICE));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* set default split usb 2.0 only mode */
+	regmap_field_write(usb2_phy->usb_split, true);
+
+	return 0;
+}
+
+static int jh7110_usb2_phy_init(struct phy *phy)
+{
+	struct udevice *dev = phy->dev;
+	struct jh7110_usb2_phy *usb2_phy = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_set_rate(usb2_phy->usb_125m_clk, USB_PHY_CLK_RATE);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set 125m clock\n");
+		return ret;
+	}
+
+	return clk_prepare_enable(usb2_phy->app_125m);
+}
+
+static int jh7110_usb2_phy_exit(struct phy *phy)
+{
+	struct udevice *dev = phy->dev;
+	struct jh7110_usb2_phy *usb2_phy = dev_get_priv(dev);
+
+	clk_disable_unprepare(usb2_phy->app_125m);
+
+	return 0;
+}
+
+struct phy_ops jh7110_usb2_phy_ops = {
+	.init     = jh7110_usb2_phy_init,
+	.exit     = jh7110_usb2_phy_exit,
+	.set_mode = usb2_phy_set_mode,
+};
+
+int jh7110_usb2_phy_probe(struct udevice *dev)
+{
+	struct jh7110_usb2_phy *phy = dev_get_priv(dev);
+	ofnode node;
+	struct reg_field usb_split;
+	int ret;
+
+	phy->regs = dev_read_addr_ptr(dev);
+	if (!phy->regs)
+		return -EINVAL;
+
+	node = ofnode_by_compatible(ofnode_null(), "starfive,jh7110-sys-syscon");
+	if (!ofnode_valid(node)) {
+		dev_err(dev, "Can't get syscon dev node\n");
+		return -ENODEV;
+	}
+
+	phy->sys_syscon = syscon_node_to_regmap(node);
+	if (IS_ERR(phy->sys_syscon)) {
+		dev_err(dev, "Can't get syscon regmap: %d\n", ret);
+		return PTR_ERR(phy->sys_syscon);
+	}
+
+	usb_split.reg = SYSCON_USB_PDRSTN_REG_OFFSET;
+	usb_split.lsb = USB_PDRSTN_SPLIT_BIT;
+	usb_split.msb = USB_PDRSTN_SPLIT_BIT;
+	phy->usb_split = devm_regmap_field_alloc(dev, phy->sys_syscon, usb_split);
+	if (IS_ERR(phy->usb_split)) {
+		dev_err(dev, "USB split field init failed\n");
+		return PTR_ERR(phy->usb_split);
+	}
+
+	phy->usb_125m_clk = devm_clk_get(dev, "125m");
+	if (IS_ERR(phy->usb_125m_clk)) {
+		dev_err(dev, "Failed to get 125m clock\n");
+		return PTR_ERR(phy->usb_125m_clk);
+	}
+
+	phy->app_125m = devm_clk_get(dev, "app_125m");
+	if (IS_ERR(phy->app_125m)) {
+		dev_err(dev, "Failed to get app 125m clock\n");
+		return PTR_ERR(phy->app_125m);
+	}
+
+	return 0;
+}
+
+static const struct udevice_id jh7110_usb2_phy[] = {
+	{ .compatible = "starfive,jh7110-usb-phy"},
+	{},
+};
+
+U_BOOT_DRIVER(jh7110_usb2_phy) = {
+	.name = "jh7110_usb2_phy",
+	.id = UCLASS_PHY,
+	.of_match = jh7110_usb2_phy,
+	.probe = jh7110_usb2_phy_probe,
+	.ops = &jh7110_usb2_phy_ops,
+	.priv_auto	= sizeof(struct jh7110_usb2_phy),
+};
-- 
2.17.1

