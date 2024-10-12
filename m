Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A868AD1A42C
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 03:14:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A77C788C63;
	Sat, 12 Oct 2024 05:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D43488B55; Sat, 12 Oct 2024 05:13:57 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072d.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D885388B0B
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 05:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwIpRzgwqvOJfvjtzlfQBlCdF4BbTjCzFxEFIm2Kg0dHV3/RXwkCNxDAsmGkFe9OglBlRHiZeuzLbdn2dr9GNv34KrnDqrm67Yg8ZLTaEstSBS5jka4y5gVw068uA6lRxVjboE0r7C2WQIDsvavLf4J9ewuM4Im0SFt+vauIl7u5TPBEvBXQfUEKWF5/aZC4UHgH8bkNJUs5WGv1C+z2rO0zQGuaR1WdmaIWP5hN8UcqXgssLg8EtQWDycHE0SFGZobf8AWf64Sw0fXIaK588lIb0nwYJWfIoF0vAruqPiQCiUo5zpcLtlixRyVzDLtdtPqjkPxcyvVFOZhZYHkm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SidO0zidTwgoP7J7wAUX23vUwIbuPBNHHvRerpK5Dm4=;
 b=WUZX0IIXX6p2PqF+TQEy5H2gbk5ATl+zeoyQBqDBkBguBLg6amxyTn2JOxhIT6nkKaQVlNuCrqi+6lJoJiQgJcik3GIrpoAUUqVKUtM+xMKZNL1ODlSkazARWF985vtjyMvguXnmKZBmz1S+rJbePEBLrtKGTVEhzqziSZVss09bjIoV8dQOdM9fGJxgLPxlwROwBPxw1NGr5owDiY5sAvOZQQYF8ZhgcHpUH0WFbbBwzmMWhdukGft/NoNVLvEM1ZkJHM2mdgDmXhUqUl4KW9YJokL0LfYV60eYoUy0IZcKysc9KCJeGMWPwOtA4sG5C5U+Z1YEHWlH/H3S31fD5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17) by BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 12 Oct
 2024 03:13:45 +0000
Received: from BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 ([fe80::480b:a135:6e33:10ff]) by
 BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn ([fe80::480b:a135:6e33:10ff%5])
 with mapi id 15.20.8048.017; Sat, 12 Oct 2024 03:13:45 +0000
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
Subject: [PATCH v5 2/8] phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
Date: Sat, 12 Oct 2024 11:13:22 +0800
Message-Id: <20241012031328.4268-3-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 94059cc9-9444-4aba-d095-08dcea6be1b2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: qvi7undRAhNHSWqXmiI+IapZbsG7NS+S5TyYZiDwMktGWYfgaJhiWthkGJG2CZAtUCpj0zeCsz50epARToO40vsuzq9n/ETbRlG35l3Z+fcaCfyEMg2/n1lSh8SCyilcXhTa2MOoN2Jm6SX9Vyu3iYf2id5jnQ4WwxrwoQWilec9q2Fo83o0N2VafQvFCdRgyz/h4KcRpFEmFz/e/2R34K6Pls6QWSewt6VezcLXxgs4qMZ2aHA8v+nPriChKV3QY3QMsyuacI6Vb5UXRO9x5mBBMni/bU3lfzaAghuleAM1J2CtmTElUZ5PyZg3MQgLe2MHywsV7Eh0lIEt6PM5u6ZLGDlQG39tpI3sqhqtk3gQLlCIrR7e5yMFC2o8CWe1RHLHwM4248NxkQFm3GkV6V+pqREMSm3boHLPY35Y6eg7x4jTd0tq9Cen6qwEQ1qS8A1biLzvhrCT/IU+p6xJby55WC0/2W0ELPi7m+5FdHNq2PozAUAouTpXi1FHGkuxCIB9XYYgbdwSvLEkn//4owutZvXGxnQThzxulfusF+trj1TrfQOWI5LZzrYn2iIJl/9zUcA89yop9lXOTTQG/qbkWKFFA5RyaJNNjQ7scO/BESI3Ws+lkAGDOvnykaXt9UT+Wf1cxj5i2j8bs27yEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?35/q7juQBeBTtPAf4TrHqJJAvVztjrfSW/BGS15lEd7SKAW2gDnm620cu42K?=
 =?us-ascii?Q?8BoXD/Ab6aQn1OU+UvfPKXjRvgTje9O1K5ybom7yj9cVrD+snBq2h5BPbFFP?=
 =?us-ascii?Q?Kpy1sx4lRHXITU72PmR5xsfSSDb2nwrUDeSsS9zDCCDwNVRCeQG1FFfx3trN?=
 =?us-ascii?Q?cRJ3nEwASl+HYhHChK/Mv+4fW6Km3YxK+O26gf1k7x8pA4NfDbhxmdBDPPk3?=
 =?us-ascii?Q?EJb3h2KOlWIDfUa8yhd5ImTT9+OI1/gK698iUAJxFKC2KZtNg9S+mOT8dzu6?=
 =?us-ascii?Q?sQ3F/TWlhbgsvGxg1xVI0bNk7Rvj10QYOkpBnP+Q+UkGlFau/VMfY1v768kW?=
 =?us-ascii?Q?OGhF48mULfT0JiIPoCzB8VffBoV1Ala3TeBcDNGJkeoZdtTvSlO5+85+tTdl?=
 =?us-ascii?Q?wO7nCPNII0j0lqaf28qZWmwc+kvxjTn2To1Q4pQtPS7Cel/zTXdbqE7rjAe7?=
 =?us-ascii?Q?Oj8kfeHHOJpLnfgbhanj/eOViUuJmpg49jMCF7+8VsKVBozsOztUPSLrnitU?=
 =?us-ascii?Q?cgX87Nv4eAU1sdshT3mTY+B+L0XSUts2bcj47UlV1jDhSieGKzfWImrNSyhN?=
 =?us-ascii?Q?EMx1+8AjI6Mo4Z08e89TL/CgZaqcPu0z+o6iA9zfCrNG5aPe0N4kLgbMxZbI?=
 =?us-ascii?Q?6fugeyU6Pq17ppyrSZJOGypgI8LL2XfGb8mlCjKWvkyoUDcOOf4+YrKqa60q?=
 =?us-ascii?Q?Vqo/xnw+2p+M39uxl0eLXdo0vFu9kMKTAEFU7bqus5eLJtWQ1qRjpqQVRQf/?=
 =?us-ascii?Q?btsh58fX52SDCLweaGYWPR0bRJF87l+T6TuvW/TMT9ZzKyTrGmstotZmYqmQ?=
 =?us-ascii?Q?FOSupBe8cq+lsG+5l5gTvM2iRp6l5V5Dne01tF3NJaBaPtDe+PiXglf0J9XF?=
 =?us-ascii?Q?p95X4JhOp7vk9QtKDY7g/ecvpBisI5TJ1N4tc63xhxKUiddbheCYLyzhSSox?=
 =?us-ascii?Q?1wEHUn4RJXgGt801iJ/3wTs4/DjrpseOoWhTTswWEYDHai1VdQlQBNL359sq?=
 =?us-ascii?Q?ATYGHkzSq5kxtwqqAF/sXY1vWDe8y+Zhx0vVnOL2OGjmmdqDZop5Md8ESiQj?=
 =?us-ascii?Q?VBHiLs5uylnhbEl4oFhR9RD9Tjt/GtbPsm2uVkUPZMwbak/53fvsHsoKacB/?=
 =?us-ascii?Q?Gsh41cKUY8zzd5HAlomzjvGce0A2ah0iykVDhQciPMx1J2Iomh6OepDmIV0O?=
 =?us-ascii?Q?8fRu9E5ZGIUCI2B45ir7yFLAMV4zeD8L5+iGhw7yIh5TP4nXP1gdOreDWUIT?=
 =?us-ascii?Q?c6FVhAjXgnHKRzGnOIFoNtgmUDbBbNdw9Jnl9xQriNtKl2ZnN2Rgk5Xnhsez?=
 =?us-ascii?Q?Z3dlEu25r5Gia6nSnK6KVX2hFCUcZSbdjwC+xvq4a+gmC1l4RbSGAEYgeOQg?=
 =?us-ascii?Q?2FntPBhzcr6DrOWbDIwGANkaO7j5qGHjBsOlneaweLmCh2vDBppEe31B5OzB?=
 =?us-ascii?Q?jtFqgbmXtM6qxMCKpOTU2a6J4e+5+pn/vJse+gL+RIOViCe7HbJIFSr/I9tA?=
 =?us-ascii?Q?cDXXsHPd9PRGWKh5YGZxxXPjMqCUk5ruR5I7dvYhQQbx74pqPpBUO1vnaO6e?=
 =?us-ascii?Q?JwfN89DTcWZJaVlafo5Z8AjYpMfq57815uoxbVWE25mkrjlfpoAtsmBcluY1?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94059cc9-9444-4aba-d095-08dcea6be1b2
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 03:13:44.9744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMVeYecVjO9mxp8m/+sF7SEfN2skkgChAzgxkpA5W2eU1uRWBu2BkHqYLeMOeSECEUpOCYw444Gy1l7T4MvF9dDdSKQWRq7jQyLrxcEF1jQ=
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
index 7a2b764492b..6ac867350cb 100644
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

