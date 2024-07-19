Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399F2C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 01:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABE3888B4F;
	Fri, 19 Jul 2024 03:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74AD888B45; Fri, 19 Jul 2024 03:38:43 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20709.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D46A88B44
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 03:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTjgCYQtHzzXTs6/dttQeU7Qc5N1G1Sh4z+kgUfZm5rt+A8xLRe4OGte3bROUQTxC7rpdJudKQrpF1bjDfMbT9Ooh7wl4XkvUgBshVLXDK5i/Cj5EvxiE3o5PrthKhCBVgBeH0+xpZgWy1Jc7FOBcBi+XIn9Jf/VP+fWf4kz7NeSBSOg9WInSQdcGJgIgeJ0sg2lSgtQVg23GCxAoTIxmwiUUGR7bGEQRi2UawB1aoMrNtWdbiRaGi43wje8XHsEpYeX8Lc1EZ013SvOeQFHnW66iwaHn3B+vS14h893rMZBFbLz9rHftT4F6KY8QO2A5H2GBLPnAvfAKClMQl2zAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgiH6+XJCa0hOGH8xeoFO4XRX05zUyVc9LlNJknswXI=;
 b=J9yk6oA9mRxoZic8lAVPR5V0Elo4n/urOy4jt+a7UXilWDx5JYu9uHCiSX8Ppt3LttPn4IvfRbG3O/TPUVei9gscV2jdybC5vZfyAWt6dW4U8WZ5KKvUznFbcPWwwb0aS4LcPZzi9IL+sLQJ2jIL7wAX/djYRR96O7OORSqsOhUx2zBVSAwGoWngFtloqF4LT5WOtBA+Filc4JmcVhwQL65UGEdNP5bZG6cO6MFsuDa+8gS3Yk1ZJlaL3ppBeKOU1BHsXWf2EpKauPyOCUzvm/Q1KAZSW27HPmbOHqjKPJ1hzvHYBt+A7u7cgRaEJNSn4KpUH1Lqmxqkqy6mQlIFLg==
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
Subject: [PATCH v3 2/8] phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
Date: Fri, 19 Jul 2024 09:38:16 +0800
Message-Id: <20240719013822.101374-3-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2d48cbd2-33b4-4f89-ca27-08dca7938093
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|52116014|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 7sQNszYLhjB9Q15wNIoNpMKLNedfyLsIe1yTHOsFll7m2cI+pppdTaEPiS5YedVg1cWjzuhHxHO53YFW7iihO5EFP+iA7359z0fcpcyEjJbz8E9q3H1cX9JtdDACJbAyKRAqTuGsRyi855aEl/trwf9sOhwaXYKH57Pkm1tV3sxFDiVkZMeX7yd034uH3w1lUB6BWLTArD9joRCSakAoos6haDF82y7ES0J9qy/+n8YdUzA09go2O4Kvf+Qa75YRLg1CA/bGHZK0dNukfvwHXK5SM2Lpy3/6aDCgR/DJ5eMEohrqCIDUQDNsAkNwrlm0Sc0R6L5fGc08IM0NLLY4dLOD5TaQ4iP827qYQi+6yFT8MJPQmiUeBkJkA6OhH1254BsnmwSR8vBMy/N8ahf9KE+DuLP4FpVHz0ovq9GKOjxHdOGRekKG6U5wSkhx9k2D0Q2j9CLy6WK29yJ7/Akxdj5Pqa78BffxvXN58o/NLHOeH9P6ZE3wmbhleFO9l9amMDDuyRjnxCdIx1VuCtfR6QUhhUxR6WkP5tYD3l8/odnXxIDHLMrVgRSR62umJA0SfGNCeUQ4hih7b2dxAoi+qBFez2i53fPb8+FWYD7MIdsMDFjNRH2VcSqh+fYV91JmlqNoUYIR1WIPIqlHH+A1eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(52116014)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9mvBZphmVUhSOOJF9YBQAJlLPH52CLnqyjxBhzfY59PGZXaJnYaRvMgd5Xp2?=
 =?us-ascii?Q?1mcIsNuJdTWKLtur63pu3Q0P0FKOdXYl6Uo7xoP0TdqXbwkmQTGfUOWPoXXL?=
 =?us-ascii?Q?QTvdZJ6V94UuC3NE7OZ74MR7IDOsGrNX/teF3jhoGMR8B0r+Ni5OgIc5c706?=
 =?us-ascii?Q?YJrXVB54aoFgz/gbMDuPWd5cT4WKTsqq+zSLcQVr4NGyZakAEpcEJKCtphKy?=
 =?us-ascii?Q?CZfyoLdbsL/pokDemOHVo/O+ZddOIQko7cMNUCGPuqrrN47l1/vp4rsnmGb7?=
 =?us-ascii?Q?wuBwQgwZoDRh9N5qp3KR2OyPSE8QA1k3wdVqkIAMK/agk++mFiaN0orpVPQL?=
 =?us-ascii?Q?veDHxYQlgCrS00E0YLkEw8q5yBUvgi9jjzHYaDjXVi6becCigR1MmUN/ahX0?=
 =?us-ascii?Q?jnzPg5Fohhz6Pw3mfviUx041qZDvy/jv+NZ3+p8zol++NuVr1JSrdxdGtrU/?=
 =?us-ascii?Q?5Pa12KzKiW0PVZZjYGEzOriSuljDqbCfpC83c6MW3bYkrRxpVcwrSH/RKadP?=
 =?us-ascii?Q?pPSIlj1xnn0no4FnT424gkkgUQPnebmJP3ELO7UyI4OVgipTrX7aHq9qxoz2?=
 =?us-ascii?Q?YZVEvt/1xAkSzSElxcELl4vuqP7bd5wN4I8iwNRJMY/nG0DCEtjNeBxto16J?=
 =?us-ascii?Q?rDD50H3I3kNE8dKHnOQgHQcRIDTojB70Hpk1RN82wEhQv5PGi+MhCtgdh5Kn?=
 =?us-ascii?Q?PDZIbLBOD68T1qUbnjb9vbuKaaXMcHvi9M356PXZ/PhMYE9z5bFarknQGmk4?=
 =?us-ascii?Q?e9atordiyIAFJOoUoGf+ruudmB1WKdUnEYEUyySf1Njuu5lOe+r24p2VEhzZ?=
 =?us-ascii?Q?mxKvKfiPzpur05jShaDULuxxm+EVctViHQrhsbmNkvDfCxoo9hB9JlNwYpLg?=
 =?us-ascii?Q?C6BZGIhjFt/oNvBWVVH+2gtI1hHweBROVZPUjSXP913IQFpmmKvYWR1gFS2w?=
 =?us-ascii?Q?9b15AMOrnsW75Yi1Xss1Iz8rLi+wNr1PmBpU3B+t9FtDyAi+ZCjssTpDUz3F?=
 =?us-ascii?Q?rYnaJNMpnv/EHTvZrHkSLl6ykPd8e3e+fmexOoUjFX56OEBqUckJ5fDbzzEN?=
 =?us-ascii?Q?bpBHtQBykPsUpra50VGO+V/5IX8STxWfr2pDl3QsFkX1vgqSURY9nG7F1tFV?=
 =?us-ascii?Q?lF9imZ5GMBt4deFNNwiZ7OkJtAEIhMau1lsj+0toFh1Zcn7MLgMr0+bXjCpV?=
 =?us-ascii?Q?yNo7tf/AHTx//Z2patdDXqP5iJG0h/UaplnJq1DHrINN3JcKousI3v/d1ZRn?=
 =?us-ascii?Q?0tKH12NfukZj7HqbthH2wwu7DCajXDtD2IS7nNbh9SKIbrlUZlZLstF3LXB0?=
 =?us-ascii?Q?rzaWip58NHzLUpsZZ0sjKA/6xl4zzFhjr7JK5ZTG78konJcE/PEJS640rTGm?=
 =?us-ascii?Q?XFg73/68o3YBOjEqCaDM+WpHjnekD1EgRmNKKja/azUigDig87zBzQ+r4rju?=
 =?us-ascii?Q?B4v3Eow2e3j4rwoKRidPTn48xXfF7P0n60NpXs0jfnIX45QVKKukONzYPfKx?=
 =?us-ascii?Q?uy9Svns4r+YStMCepeZvW7o98JIzddMFxa3qv+TefLL9YRkU3hCW7KzoiWEq?=
 =?us-ascii?Q?5AeEQsN7NxQkPz3CSrpu7w/r1VVuWmFfEW0xzCEUxOglaTO12zkhwymb754D?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d48cbd2-33b4-4f89-ca27-08dca7938093
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 01:38:34.0144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91bhC51z6YnhSKD7ePyn9eXeBTNDI/K2NowZSQo9k1YNWf5e0p0MpxI0AdiMBll7HT/PX9xSC5iqoXL/SIvAW8nMTOMbz5aF4UO4fkC2zTI=
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

Add Starfive JH7110 USB 2.0 PHY driver, which is generic
PHY driver.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/phy/Kconfig                    |   1 +
 drivers/phy/Makefile                   |   1 +
 drivers/phy/starfive/Kconfig           |  14 +++
 drivers/phy/starfive/Makefile          |   6 ++
 drivers/phy/starfive/phy-jh7110-usb2.c | 135 +++++++++++++++++++++++++
 5 files changed, 157 insertions(+)
 create mode 100644 drivers/phy/starfive/Kconfig
 create mode 100644 drivers/phy/starfive/Makefile
 create mode 100644 drivers/phy/starfive/phy-jh7110-usb2.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 8f767877e7..0c4d63a01f 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -307,5 +307,6 @@ source "drivers/phy/cadence/Kconfig"
 source "drivers/phy/ti/Kconfig"
 source "drivers/phy/qcom/Kconfig"
 source "drivers/phy/renesas/Kconfig"
+source "drivers/phy/starfive/Kconfig"
 
 endmenu
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 7a2b764492..6ac867350c 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -44,3 +44,4 @@ obj-y += cadence/
 obj-y += ti/
 obj-y += qcom/
 obj-y += renesas/
+obj-y += starfive/
diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
new file mode 100644
index 0000000000..f28529d1f9
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
+	select PHY
+	help
+	  Enable this to support the Starfive JH7110 USB 2.0 PHY.
+	  Generic PHY driver JH7110 USB 2.0.
+
+endmenu
diff --git a/drivers/phy/starfive/Makefile b/drivers/phy/starfive/Makefile
new file mode 100644
index 0000000000..a405a75e34
--- /dev/null
+++ b/drivers/phy/starfive/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2023 Starfive
+#
+
+obj-$(CONFIG_PHY_STARFIVE_JH7110_USB2)	+= phy-jh7110-usb2.o
diff --git a/drivers/phy/starfive/phy-jh7110-usb2.c b/drivers/phy/starfive/phy-jh7110-usb2.c
new file mode 100644
index 0000000000..d48c9f8a74
--- /dev/null
+++ b/drivers/phy/starfive/phy-jh7110-usb2.c
@@ -0,0 +1,135 @@
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
+#define USB_LS_KEEPALIVE_OFF		0x4
+#define USB_LS_KEEPALIVE_ENABLE		BIT(4)
+#define USB_PHY_CLK_RATE		125000000
+
+struct jh7110_usb2_phy {
+	struct phy *phy;
+	void __iomem *regs;
+	struct clk *usb_125m_clk;
+	struct clk *app_125m;
+	enum phy_mode mode;
+};
+
+static void usb2_set_ls_keepalive(struct jh7110_usb2_phy *phy, bool set)
+{
+	/* Host mode enable the LS speed keep-alive signal */
+	if (set)
+		clrsetbits_le32(phy->regs + USB_LS_KEEPALIVE_OFF,
+				USB_LS_KEEPALIVE_ENABLE,
+				USB_LS_KEEPALIVE_ENABLE);
+	else
+		clrsetbits_le32(phy->regs + USB_LS_KEEPALIVE_OFF,
+				USB_LS_KEEPALIVE_ENABLE, 0);
+}
+
+static int usb2_phy_set_mode(struct phy *_phy,
+			     enum phy_mode mode, int submode)
+{
+	struct udevice *dev = _phy->dev;
+	struct jh7110_usb2_phy *phy = dev_get_priv(dev);
+
+	if (mode == phy->mode)
+		return 0;
+
+	switch (mode) {
+	case PHY_MODE_USB_HOST:
+	case PHY_MODE_USB_DEVICE:
+	case PHY_MODE_USB_OTG:
+		dev_dbg(dev, "Changing phy to %d\n", mode);
+		phy->mode = mode;
+		usb2_set_ls_keepalive(phy, (mode != PHY_MODE_USB_DEVICE));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int jh7110_usb2_phy_init(struct phy *_phy)
+{
+	struct udevice *dev = _phy->dev;
+	struct jh7110_usb2_phy *phy = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_set_rate(phy->usb_125m_clk, USB_PHY_CLK_RATE);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set 125m clock\n");
+		return ret;
+	}
+
+	return clk_prepare_enable(phy->app_125m);
+}
+
+static int jh7110_usb2_phy_exit(struct phy *_phy)
+{
+	struct udevice *dev = _phy->dev;
+	struct jh7110_usb2_phy *phy = dev_get_priv(dev);
+
+	clk_disable_unprepare(phy->app_125m);
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
+
+	phy->regs = dev_read_addr_ptr(dev);
+	if (!phy->regs)
+		return -EINVAL;
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

