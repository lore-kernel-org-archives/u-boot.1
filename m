Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A195AC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 06:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BABAC812D9;
	Thu,  6 Mar 2025 07:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D63D80E94; Thu,  6 Mar 2025 07:20:56 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20731.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51247810DC
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 07:20:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b02ldmBzN0DIwGvCqnT16nXNozg9to7PKkRt8RSSGDSFm+W9/mym6CpAEOVBasiXwnupvn5CaDVb1ibs4Ygz9s0iKJ+eOMnd7KaFXUI6M+YuSdAqexW5BOKuwYsWehb2xQZW9ruzhNBWn+sHz8J0idoetIbg7RJ4yjWfYIgeWA2XFdy5yMnzDhfW4KryOBmboTk30aiui4NpVbaAYoVkxLJHXQMafD+uindcKrzQQueND0sefTd41vgn19TGF0pYlZBL9caFGKXPda2NIi+7nAW6IrzLCAwxcHLtedipAMfatyFx1v4/TJa2IY899pgpwo08l0M2ghQD/AI5DZahYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gt9/82McEp8EOrMnO/L+bz7kriHu4Xzv1XUGabRn5eM=;
 b=m2hLItXMCmMyh5gjG/Z/YNK62qY0YRe1wJtK5Hq0mnuTZr7gqM9klr6B5gcy+hpdkQtLxGnf0VVUVecQBKVnpB7s2tMQaDK3Oknf4MrIaYAeU4nt1GuMkEPZUfvcXPCnXd/H1ad5hz2lAnVOr7tNIbqOSrnWTNWECbOnuxBEt+L1A8gi3wpl9JxSCFrFcqZnMVySRwGIUmxSnJ+EDZNHAVWC0RSEsMz4af8BFjOOhultwQAkj83iqnDLEWCKdsL5kO7Fqql6N6wdH4Bm47OZJ4Fzu+yk5FP++QvVaDg1ZK63Nj838TW2xHktC1b8H/8+kR6fMFhtuLUD2sdfl/Xs8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.30; Thu, 6 Mar
 2025 06:20:43 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Thu, 6 Mar 2025 06:20:43 +0000
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
Subject: [PATCH v7 2/8] phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
Date: Thu,  6 Mar 2025 14:20:26 +0800
Message-Id: <20250306062032.50314-3-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: decf456e-d740-462e-6e3d-08dd5c770692
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|41320700013|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: j4699CdIsdNxfY3V3YQc4DheD8KGNyKzOl13kSDURk5AZG211DGpBRjoo7tykk90WsJS3USD5fYtEonP4oO4kvzEv90JDgYGpwqZFhduiXrn66PJVN028eKR/pJ1HD0U4SOYeeFEn3gB9xcapkXxtr7vcpD1+T03YbSVTIrd2b+FXUn60hUEz4leAcl2g1NIPjLcRAYSAh00LKBF6RRzDQ/eu/96v6MsrhwWQq/FMQ5GB47h2Cxcuraz4GLHByMJjm2g6oXW/Vzd2HI/uzPuSE0iFKPct+LvVxY3ATEIwhltJSHzxzBm+AOpvcjl4OM9Rnx2R1TkSs7s8oskwpeDypPJ0R2p4m2Iu+/ygNsayytW7kBECxcaYpDN/c852hMAsv1k5wVsEBteT8owI6qXtsjjiAUuQf/4n1B9d9mPUPozNbLFNTK8Fol7+2xWjVZuJDqktu9IzlrUZZU3l1197xAFGMKbo5p20JTAoRdsuRKpqRLpstv7L40mBmJo9IFO0D2F6J2WkzVZ8IK7RjROupT1lPapVWKE+xtl6FSQ2PYq1m/ub5ishPLcrLZ1rLzx0eqdw+AVS/W+nwJBK4dkBrUbfxt2QRkXN6GBkXMU5+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(41320700013)(7416014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QqhdzJRvOilFMIGJpE/MNVKSur3Dwe9UU4ZIIBoh/g749Clau6QlIQo3PkxQ?=
 =?us-ascii?Q?EdMt707IWacC4EviuecfzTbuOJRlbjsF+v/WtGjlEUv5nzYjghLiJp3unkvm?=
 =?us-ascii?Q?YiYxXPb9CMG8aIYyAnNF1QVzztNpMYZMKa6lhspUnE0U4fTBL8bIMep5JZ0K?=
 =?us-ascii?Q?KBCWGJaivR+FQIZEnWAoITxUuNl0qQX4Sje/lKTFuMnjpsD6hlUId4tjoPN7?=
 =?us-ascii?Q?aNpUYML7K5QDTgkuNcqwARyhc2fBdSm+azR9eaHWKDdIdf1ylEFwx0cBjQj3?=
 =?us-ascii?Q?BB5sBMTvcE7s+tAlQZC0vq5b0ZBgUPrZI10z2r3w+PYXOIWcWA0nz/AlC0SF?=
 =?us-ascii?Q?AN1OssDpCugeSwQcCX310uqG9qQ9CKsWuwRNgyyQDskmFb2HxgOWY1c36AYV?=
 =?us-ascii?Q?60sC0zkT+pIYIEs2SH6aoeemcLjdLra3WSbGaxbqlgm53Vfa/gRH32T123vr?=
 =?us-ascii?Q?noIcva7/COvBnlfgJtsga5jg9BFtcXURGuyVM4ST5lHJege6CISP+3b44hkp?=
 =?us-ascii?Q?Gn3HL1Gg6my31JmV+QTq+kVqPrt+8vN2Dy1AL2ZVfJ/y8rDI7PE97gFwbnKQ?=
 =?us-ascii?Q?FC/Jn4uzpIl5WkviliOdiE2+YcSYSWlzahiFqabvr34s4Tc/AZEf6Ve/YLyC?=
 =?us-ascii?Q?aZxf+S5J1TIbafcf77BOI9dacKdmBRVP58F0NBD5UBuqYJhMOrnGJkmtXxq7?=
 =?us-ascii?Q?Gh5qonxhz04rflKx+dd+fdoVBSSYptf4XWdjE9RV2QY3ivdn8YWJoyClg5bQ?=
 =?us-ascii?Q?zaPFgE0CoKogLdfuT7lL7Re9UPAhOUQU+dzXkETrH9PTX3GWnYwlxGXBmF3I?=
 =?us-ascii?Q?J+fk8O6YCfLvUMrAK1WekRwRF0dRGo8KwD88pGJ5AnX7Gc9aeLrsnrgJwuLZ?=
 =?us-ascii?Q?No1BiHYmZfetNCYlIAnCDXK5Bt3dJe1m1Knnyd82OaUv+cq2TF7TEtdWiYS0?=
 =?us-ascii?Q?tUdvgjZ7Z1RLYel08DL2ayC5E431ZAqZva+ZvOzdj1ZJ3oxkSNyxWYu/fy4w?=
 =?us-ascii?Q?KTOPGZ8zib7NJiMDB204cLKP9DiZCwOufaErMyGiavRkd1HV0I6oSD2AXcCd?=
 =?us-ascii?Q?6Kg/jPzc+XkfJ2ly6clEB5Dx+eDcKgILxp720InaMRrcfNBswO7QcdWA86ZL?=
 =?us-ascii?Q?eGzDGbqLHChgvU2YWpnQwexc9YY9y02XF/kK97LttTM+1BmlS6xnzuni59zu?=
 =?us-ascii?Q?OFGBO7M59yfSbvsxn7AJ7QEeipfOUmJ7JHWotUd0qAm5WtuW7R/7bIUDu+PS?=
 =?us-ascii?Q?+RsLX7MyZRyLFz9Ik2EYYZcB3aCiF8Q0/YVBaiDlJmp/ZFo4v9pkviH/rCXT?=
 =?us-ascii?Q?gf2ES4tNJVEcFwgAwZMYdljASmc1AxiSAiSw9fVE94FYOI0PUaFQStaWkLHa?=
 =?us-ascii?Q?WjF2OfHLCYO/pFpxVGVK5HqSbb2/HfdQJ1fLg9ThBOo+Hmrvkr1J0HVBqEMY?=
 =?us-ascii?Q?aJJn0QKZoYIkP2v6CdBtuFuwLRgF24qBB8S5JhdVYtQc0wijBCp9MpOezKP5?=
 =?us-ascii?Q?tyNva5rUPWADNQEdcn4htPoLDVVFReBeLwBpGQBJJkyjN+xAqLfZrpA7VQob?=
 =?us-ascii?Q?UzlA+s/E9SJkEM9iG+94ULknBsY2h6G+Guv613/RuaMOYdgVGW4RPRSUFT7C?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decf456e-d740-462e-6e3d-08dd5c770692
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 06:20:43.8737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0OR/FFFvkAF6E73E1aiipU4VuiMZjzQqJg576Y4bE6sXuVo6U1Nbr3GDDxgqAw/zeY6NICqLgMvdSxPypNP/SWF8mDD7dRKgiQypyL/bwA=
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

Add Starfive JH7110 USB 2.0 PHY driver, which is generic
PHY driver.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Tested-by: E Shattow <lucent@gmail.com>
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

