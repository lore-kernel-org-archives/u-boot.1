Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995F7C3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 05:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D348E888C7;
	Thu,  4 Jul 2024 07:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22E1A8881D; Thu,  4 Jul 2024 07:50:37 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20731.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6311888A4
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 07:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfDfNAzhiVTXZUfX1Sd3cUVWmZl9Ex/SaB0Gv5vWek1pm/KS2boHrneajkpBkohX4wneDJFy8ichINHV1tcarND0sxMWUp6sHlNWdgjnnjccMpNabrau3h3dEf4TLceVt2rnIzm1UiEtwzak7zjBwXOvQDAyxPB00ywsRUQXKtFtyc5tc4fDjTOxs9Ps5z1Y5YaXyFdfw18VsdioQEyq50AXsiYbXYA49ajrR2zPZzJ7vrLjHIf7nJ3u0SkMDZFGvF2ZCMRsRvNcAPgLDizcWdFBFMs7u++W71qSsmKoYAaNwRZAJ7aJJtR6gFK6tHWCSlAV6FX2eKYV5swqvvzPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mGiCLBm4G1ohn6l+J5unY1rRtA0ug9nXWWir1L4i5A=;
 b=UrpbwoS/GoWx74twawpA6uMAD7PW9mWYUbbNgJvTQomt3ueoK4qZQQbqGr4ofS4YRLyLmNJwnbUyBToBuCi2jqDb7YOPOFcL8xDUPUl9kiq0J+2dgf5Fm3Jn7tviQUdbLldbI6A7twT7/6KJAb+hgnCHJQmT7eQGaKen6S/2fVjHsLIdMffPjW1el8F94vrB/DKDmU4eGmnEVwfZ2Hzr71kaDqvQHtydg7e3aQEHVgmvJqfTHOPUYxGFJyWfLWqFF2kfaZxf4vzCX0qRk9wWGIkK4bfzokeqGeO2oweuIA0CgyiPm9gAAM/yhqmeTJ0yTEUbT51TN2VTyIrqudEIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0766.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 05:50:24 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::358e:d57d:439f:4e8a]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::358e:d57d:439f:4e8a%7])
 with mapi id 15.20.7719.029; Thu, 4 Jul 2024 05:50:24 +0000
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
Subject: [PATCH v2 2/8] phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
Date: Thu,  4 Jul 2024 13:50:08 +0800
Message-Id: <20240704055014.55117-3-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: b1fef2f4-a3d9-4bca-813a-08dc9bed32e0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: StZpJQfMFKR/0kMMS9aN/LoO/KWVmzv4ugjHnnNGDQLffBuB4O1++Wi8HOExJApzI6N8Sb9o8OgmBDHwePonwIm1mxrS+qilWMspAZBVxkb1HkG8nzEGflzn+69Szn3/xhSHLVtkm/YM9IXd1SJ/zlQyKBcz+s9s7ZSvuOycoXsjAJoDmhyMrmR5m6dgdf9DgMl670d2+/eDbQVaxjd2Cc/ji8Ntzh9Mtsk+EMFz4inJQta+dZsZx+4gFw2r/U9dXietaiVXIz9zFAf+D7j/BfqSHVlLrdwJA2vtyCW6zPG0XY2SfAbrP8tQWCIt9Cq/WICjb2rtmXclFLAo1GdK9XyCzoJOVRpFotW/y53oo+jDcq8x8KJw61cOTmyhoUxAsZr7Uxs1rrdygsIS9qJ/Qlq+6ayeM3JixvPNtZuzoHrEOg/edGNLJe0j/EPZufSl9upDdocBdYwwl1ZCMnzWDNfLRE7i9rwZ40KfNGfNqDY8rMXvGXqmEfQjnvX0CtgV72lody+hxzGcTrYqxOSnC/JJK99/vcf2xWxyDKBS+GIarXd0XP2D/RKLkY25nQyOyN5yFYjybYbtMHXMwxnoT4lk5MO7qW51fpeoKcV/ozXqbKu/MfJprYnyh/pByNCPwGPKiD8YR+BEjsCtirrXBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(7416014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vjHyJ+v7bsRpBkGUWB3+5aas6ze9K008osn7aLuhAi2om++fHRhuC7oBDekt?=
 =?us-ascii?Q?UzpAbmbSLJ2Kq5AIxErfpozv+FP+DLOjvVryNyh85sePN3XV01VYLT65E1yL?=
 =?us-ascii?Q?rzqKvQLO9W5S/1lLa84kLgU1Ql6ao2p70yYsQtLk97wrjEFdUx2st0cykn4W?=
 =?us-ascii?Q?Bt6M5ymgiWwW9C/xkwCxrFl4WW6XFzK98etKjxZukX84srkEUFhOATOSwryc?=
 =?us-ascii?Q?+Gl9D1JbyINGV+FAiNvxotmqk1biNc+MU4PD1WxFTEQj+e5W7u7AS3Y6MvO8?=
 =?us-ascii?Q?Lanm0HYIfyNDRkjtmd+VxCQdXRHkLGUnu6zVaXLZ129bWIRPsDAObZJ4VFy9?=
 =?us-ascii?Q?IVR1qYzMLDpSVKVDFwWvZkeyLml26mShNXTGmaKd2yPqaIU8eKtGFvXDnaZH?=
 =?us-ascii?Q?iuoqdSzt69+ZfdMdZvTAsAYZYp5+psBaED4lJNO9YTVfQNdBa/APtKjO/gP3?=
 =?us-ascii?Q?0HH1Qz5Ew1roXxSQglEzinTnczxJeJwdNf+RQrpSLMsvsgKPs8+FNfMQ6wKR?=
 =?us-ascii?Q?sLSaLi4uYQGj9a+Mki1czEAocjgikUnP1vwVG0APNtJERHzTnq5uRhMdYYsx?=
 =?us-ascii?Q?d1TSYWDgJWCKxFEcR/pIbrrSbifjx2QyM3U/MxmGRSiFY5Ld9f4M70thwo74?=
 =?us-ascii?Q?FBOSAjERJSi5CJD9l9xpeBdB1FYFZTsGEDKJwvaDmgg/5Ig3cNJpUq3eshEE?=
 =?us-ascii?Q?yhTgQ9S2wkc/AKIN8DxAY3qu1sQVkQf4N5XJR3iXGzEuD3FyEh3MQ2ukvwoh?=
 =?us-ascii?Q?4XUNOppuJ+9zADHwD2Q6I6NJMDIWb0KOMb5ddX4d4fnuQ5d13P9/FhdQRDJt?=
 =?us-ascii?Q?jZh/vPzVrGMpDaXbDbUc/ql8W+0RvbiEhoLp0lHT8AntuuLhHzgnBOxztS3x?=
 =?us-ascii?Q?/Q0G/D1ISyaZkppCPkv1+SaecU7bWgHLqDK5yBh07jbKHDZQcgkluD+bzF65?=
 =?us-ascii?Q?GMdjH0yRtQytjnVBHXLD5QCcjEtgycKgxOkTuTkvJ7TzJ3OoSLvbGI+IDOnM?=
 =?us-ascii?Q?0CfP+Zx/ohlAPXwUMAtgvpKdVyq0xG/Rr13pUvG7EAGlaXE8oRk0SrsKk/cL?=
 =?us-ascii?Q?MxSfVXNy8ImiHnlEtJKbafdKn3xhtAcxzqvns4Q0Taxc5sBLPBH64Twebq0d?=
 =?us-ascii?Q?8nwAlSvVD1eaEIbNE99XBbQyNuwLi8+8H8Hxn6cV0spbXosWHMcGcSltX5jx?=
 =?us-ascii?Q?cTk8/KXAXbUi03Pnp7jPTbE11La5ujSBfZTseU2x/76gfaps8a6QF8uBTk5E?=
 =?us-ascii?Q?9bPkpk25Q5fsGYT+T/w2/a+yf4Bn3uVzWrB8RSTR4hl7sZmI5h7WeeZ2GRt2?=
 =?us-ascii?Q?kYeEU0r5LnZVQr4xVz+WM1h8wDuy27CFZCdGw4DStJ1mOS2LwOn4SdF8eXMF?=
 =?us-ascii?Q?FKRVbW9UgX+RgW7ifp7bIqaf7cw10PpvaNMss57Me1n3VQC2c12rCGpm/H+B?=
 =?us-ascii?Q?5SVYvSJhOJt7tWXPPHp9pzjoNE2R6cxOW232bAmsG89G8z+K9126H4iwzqf4?=
 =?us-ascii?Q?nSA6IT+KZnu80sBkxDc9P7z9UmyZn2jGqcarlycI7Wm7Sx2Xbtu1RM3rZ1Ce?=
 =?us-ascii?Q?p5/+EwvIqkbnJQRJM4dIAWOCJEfrtSI94u2Fh4xbc59jfOG+N4o2meKjzLbB?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fef2f4-a3d9-4bca-813a-08dc9bed32e0
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 05:50:24.4295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUZdnUQnlTE2qKjtUUUK8fEWFo7QcSAz9PcM22AcFbdcSs1WETKqNAGWHHObGwlxMb4k4T3sTMOackjUENCOv43+jc0k6LG0RBE4zhQvXOo=
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

Add Starfive JH7110 USB 2.0 PHY driver, which is generic
PHY driver.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
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
index 0000000000..11a819f8b2
--- /dev/null
+++ b/drivers/phy/starfive/Kconfig
@@ -0,0 +1,14 @@
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

