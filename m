Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4071C4345F
	for <u-boot@archiver.kernel.org>; Sat,  4 May 2024 15:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5E7D884BB;
	Sat,  4 May 2024 17:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E6958858F; Sat,  4 May 2024 17:04:18 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20709.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7EE08858D
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 17:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEtJ2ycayWu5XLItwkVc0FnKiHi6TyGZmViq/6ItO8m3ba9PLKT+ePe11ZlW1uL2Xpwrk+nPkwKjPjGPc9YCj3DY7TZNZ9ipv+lSh5F2SPOwuDWkeOheGM7n4V+wLe1np8Pk5XVXLUAuKrckDpWpAXeeN08bRNeZ/8SNXV5FVZCzpY0OnMnUZw+c5ldAvrEK0DCbL8POwoSzLx/g5Cho3bXtFBUL7zBgdbiymJUoxOz1S007twTt+RoNWbEaNReYZNcYN3xzRKGlIVqtkpoLHKREqNBJlfMC5rlu37qVA8cGl5fR49D2kHWJfV/iLLzB9jcdTfDLzMOSq2zp9OsQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWmU/f2svaBBcCrL6T61tVLQg8MVX7TokKFLB8N7zdE=;
 b=C+HJeilS0VpGBKwvqn/JO3cUOQGxYIaR24K0OxhQgIvvjoa3wO+1N5rw1Ub8xBpeymGwBU4RZKut26hdHvSPS3lnaqKwMW9TY7kHG0D2pyDEh/9tjk4APkJmViv8Zdy3by2w0YGfNdlC5IZM3lFzKvX3lJqQs3Pm36YOT2KmYg86B/icu9OF+pbXykPoQaJs8j+or5cwutRXB1FljY+v94qUj58NDPqa5ci91tYp/rjs24h148J+6huCZStk0K+O6UDfm7Y/KNkpP+2YCdp9zEw1kZw1tsmpGomn65tK01FtUTeqbqIUjm8Uz1Aee+s1df5/ArDOhgGMw9ytP2KwYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0839.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Sat, 4 May
 2024 15:04:09 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::3e54:57b5:e3e3:7f09]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::3e54:57b5:e3e3:7f09%6])
 with mapi id 15.20.7472.044; Sat, 4 May 2024 15:04:09 +0000
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
Subject: [PATCH v1 2/7] phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
Date: Sat,  4 May 2024 23:03:53 +0800
Message-Id: <20240504150358.19600-3-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240504150358.19600-1-minda.chen@starfivetech.com>
References: <20240504150358.19600-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0005.CHNPR01.prod.partner.outlook.cn (10.2.0.75)
 To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn (10.43.36.12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0839:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f2e26d-3727-45da-8b38-08dc6c4b7340
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xNNLkcZ7Y2qZKIPYHHVbuVoqQyq1IiQ3tUX4v7um0Vo25sTIaz2TIwBrEcd75eY+TdHIrCoG0IwGNV/AwfYYhJWdpWAnf73b0/4MlNFnA9xy8mF3E11uYOREe+zhLiWflELni8CHlGjBwIR14ENpM+P7ra7P/8ssa8f2AyJvHoWKnp3B6ZHphQLaDC4I/jv/QR7Zfyg3rHu2NI7ioJfzhgbHgZZJ6snfsa2hy1y7o8XEmb2vdDHBf2QNwKDQC8O0FqMYCMxMCr/Go/ut+FnArCtdgMo1o10/mMNNJwWFaEfmnRZUGiI15MACg97OPlo8KauN7YwW8anEZN2SAtPnR4B0jA6DjQ/af2r5H/U1dfq9yOTjBJtCLEx1kUIUax7x1k24ivSCm705vd3yvvOLwgdnmC9L5lx3gAPMNyhbBooavrK811ntoU8aNU3ZE1FbM8+VTjrORumqEzZrXU7SrJho4jzXZDxOFqFDzN+XhJ+Q3Vo3Vt+dHvVQfuvgRwul+ERYJNzKU695kuCW9G8rMkjB3VDRVmOiyg4xRWnPzpJZizYVpeNOUC2O03V0iySX/brmGEv33hIn0YWxrRZDrAKTc2vvX6eYnCAQHFhavNtpRFCfAxHQAXlkdDIADRa1QapdzE4+Vh9PXGnqyMrqgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(366007)(41320700004)(7416005)(38350700005)(921011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eGacSdc/yIH2d/ggmA0Rx1aaOzyih1ezVDYWIRqMg48KaGZGiup39C/ng6+v?=
 =?us-ascii?Q?uBVdwKOehPt+N5PrnRzRB4Z4AVcUZG2GAO4z12Yqvw3xPa7hRvnDlnsRrH7Y?=
 =?us-ascii?Q?YEUDkuFPNHcO6PGvB+fBuGU6ouUP1ApNCSqwd+IdcU054U5MFtEDZijxSvtS?=
 =?us-ascii?Q?ZI1PQjPUdADEKOUjtmt8xLjaMHVPw9+A+wGt4/Bgr1H4JhQFiACmAwUweeYx?=
 =?us-ascii?Q?UEh+lBO3tf7R3UtrLsnJI35BE5JSCUeIhQmkn0Pp/G66TI4S/W+sAnXgogzz?=
 =?us-ascii?Q?ETsm43k1c/kS44dsBGLA1HAjqjm6OxXje4CfkBlXBb5v7Ea7iWPil2NS9Rsy?=
 =?us-ascii?Q?gyKVVjrmHSWyl8I8vQi0dPiygFUSVC2mV9xQ4VLAsePso7nJl4Aqs5I99q3T?=
 =?us-ascii?Q?rzE76D26pOvw5JfojFmkPfhr/+dz8E3VvZ04cbCwKYewMwKc3xUVIglhZIBm?=
 =?us-ascii?Q?oxdG47Jh3wksjqyoUmyKVqdi5BX/uhgyoEZA/llsMVy0iyxVQEmzxYQ4mD/t?=
 =?us-ascii?Q?X58lkYePLlBndVkg0vygzgl91Zwszr0LI45awwsCv8XSrBZTVBGQ00P0AEQd?=
 =?us-ascii?Q?1cse6eTJZsx7jsDw7FTn2Ql2BufJ/toX3dyKciMf6Pmop52j3e1RWafIGRyC?=
 =?us-ascii?Q?mpBwf/bLYqhIKrn9xvXeIDpAZaJxLy8GvQPyRuDTtbP/xEjGSMvocK5D3N5e?=
 =?us-ascii?Q?SdZaZeSVawwkV3s16G3MeNY5FrnkNBxKmCiVaA1GLqAJnAOLh4qO6eIxUru0?=
 =?us-ascii?Q?qckXdB9ZCyTt/fpH2pQG6ROXxq2eCxo9Bf0peewAU+ipZCZV+ZUpD69ari/o?=
 =?us-ascii?Q?X7OVS4qVfC2UAEAVrtdbQKvBqoKPTYkl2ui7zovFKynP2wTvy8e0PPpHsNX4?=
 =?us-ascii?Q?jdU9iB8JmqI3vj5vwl4mE2gZckw+jL/NbKSEjv3gyWhQJpnmZTyu2xqnAS/4?=
 =?us-ascii?Q?yMvCAYELpSNff7EjtZr0Qdt5Q0JGHr0e17i6poK4aqw6pnEscIW2G+hAB0h7?=
 =?us-ascii?Q?8kVjubbbt/u5UlAVfFOdFKdbmKUNZ/ZtmLriJI+ZV08ByTavqVmNnuWa/6PE?=
 =?us-ascii?Q?oC4k/E7QuZGKgDuAqlZOWPvdAg52U7zsQgY0JoDAU0VA6wNtWZudXALUgdFB?=
 =?us-ascii?Q?3tcz4wfncLVsFhTWkfZLQWCKNGglvfAO3pf1IuxEn9cNQ/f7Covg+V930q6E?=
 =?us-ascii?Q?QfE71mPniqvikyQkc8od0hbd7BWPpNnC9uV8LE30n4ce7t+RWKHLPvB1szpr?=
 =?us-ascii?Q?Mn0l+zOLdX1jwznH3uZW/Y/wDy/rYfnZrcYycisjoNlYGhqDsO0Zqle/J1BJ?=
 =?us-ascii?Q?q8t4mobI79OSKAgOJMHPesa4jjifsbJ7VnJXj/vyACnfVys+yyyqgYmTaeP+?=
 =?us-ascii?Q?H5KzAjAZjdmBmGAtP2ZNrJWcbiKsb/eUvXtC/8ev0c3QMNTGiHzJEYuB5O7D?=
 =?us-ascii?Q?bcLCyFU3iSVWjFdHhh/+5WUkEzuDRr+7CnYdZ4+HcBSVvS3pwsDQDw2/wCvs?=
 =?us-ascii?Q?c4IOCOrrVp+Rw0+agAndOT4KEyLO/xJJ6LjprigJBY9bf/EIVu4yTfM2FaQ4?=
 =?us-ascii?Q?qGFbWtOTQjkJKlRM96G+RthAkJR1bLckWf42KUJymiRWKwb644auhpvfVMDr?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f2e26d-3727-45da-8b38-08dc6c4b7340
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 15:04:09.2955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMOOGYO/Dd1qxoYpNqE1yAM+JvjiuzLA2xGKPVRsH2UvT3hBimtlLEGNswpK8b8N+et126Pv/XLNE+4RWjDTN5B0Ct9FIzSxxbtwGda9cx0=
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

Add Starfive JH7110 USB 2.0 PHY driver, which is generic
PHY driver.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/phy/Kconfig                    |   1 +
 drivers/phy/Makefile                   |   1 +
 drivers/phy/starfive/Kconfig           |  13 +++
 drivers/phy/starfive/Makefile          |   6 ++
 drivers/phy/starfive/phy-jh7110-usb2.c | 135 +++++++++++++++++++++++++
 5 files changed, 156 insertions(+)
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
index 0000000000..5d78fde12e
--- /dev/null
+++ b/drivers/phy/starfive/Kconfig
@@ -0,0 +1,13 @@
+#
+# Phy drivers for Starfive platforms
+#
+
+menu "Starfive PHY driver"
+
+config PHY_STARFIVE_JH7110_USB2
+	bool "Starfive JH7110 USB 2.0 PHY driver"
+	select PHY
+	help
+	  Enable this to support the Starfive USB 2.0 PHY.
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
index 0000000000..ffbd96d721
--- /dev/null
+++ b/drivers/phy/starfive/phy-jh7110-usb2.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * StarFive JH7110 USB 2.0 PHY driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
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
+	unsigned int val;
+
+	/* Host mode enable the LS speed keep-alive signal */
+	val = readl(phy->regs + USB_LS_KEEPALIVE_OFF);
+	if (set)
+		val |= USB_LS_KEEPALIVE_ENABLE;
+	else
+		val &= ~USB_LS_KEEPALIVE_ENABLE;
+
+	writel(val, phy->regs + USB_LS_KEEPALIVE_OFF);
+}
+
+static int usb2_phy_set_mode(struct phy *_phy,
+			     enum phy_mode mode, int submode)
+{
+	struct udevice *dev = _phy->dev;
+	struct jh7110_usb2_phy *phy = dev_get_priv(dev);
+
+	switch (mode) {
+	case PHY_MODE_USB_HOST:
+	case PHY_MODE_USB_DEVICE:
+	case PHY_MODE_USB_OTG:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (mode != phy->mode) {
+		dev_dbg(dev, "Changing phy to %d\n", mode);
+		phy->mode = mode;
+		usb2_set_ls_keepalive(phy, (mode != PHY_MODE_USB_DEVICE));
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
+	ret = clk_prepare_enable(phy->app_125m);
+	if (ret)
+		return ret;
+
+	return 0;
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
+
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

