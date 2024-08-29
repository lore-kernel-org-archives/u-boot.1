Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1923AC7115A
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 01:31:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F3B888A76;
	Thu, 29 Aug 2024 03:31:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7896288A75; Thu, 29 Aug 2024 03:31:18 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20711.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A207A88AB9
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 03:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uzt5xuqJfGHoaJe32P4rTiL9EtNM7mS2WAcCzHFYBLGk7a64VsIj+hGrQvNQnXlBTp4rrQcMYbciXpuw/IR0c7xpAVL3U6V2oQ2hqabacSOlS0H9I5f3xDRW4OzH9kgBPa3zVhUyKbgdBxeJcZlvy/Jm9KicclO5O6I+kcQ5jg9h/ynjBW2VsrtjuailYK/JoPt0o/UimjJPsx4qD9jXXFYw1uJn9rfNtutTfdnulfM/RTKWGS4Gnxx9THFEju684LD1FVqIGedyqmIYnYlBaG+qLlMt7kdnjfuOuntE7zLPmwtDgypN6WTW5TlDo+6lXMRS6KHuT5KDb84n0L3X/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3kRgBU1/VrY0T6ILq+PphvatxPp76pNKZHZvHEqgi0=;
 b=JuTKta9aq6RCKrvortKALdzWVwIrRyE0eAkzsSw+Xy2RQFhRIPvv92dHFkShHJLc9Lp8ANHBeSyn3qNfIJcxv6K1XjpFY2Dyd62vGmS4RVH+f4eP6WWeWX+DNE2FPbmBykkstnhvqbxosLw3F3koj7h0o01l1n0xzsz5w9L7F7hQsvAfWI9gdKobfLrQL/Ub1DA2IaGkBIH1GAvLS1BaHKqAqU7xlgjkEuzN13SwOUoUPysMO/2bZF+K2p3gqUYXs8V8eHuOSrWcCwJ5YRE0TZ3gce9Qa5jbctXEKRgK1tfzvxGCDPnj3w+XzsW0Jt3N3us6DMGpIVhytUk+Fewrtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0830.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 01:31:10 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.7897.027; Thu, 29 Aug 2024 01:31:10 +0000
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
Subject: [PATCH v4 2/9] phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
Date: Thu, 29 Aug 2024 09:30:51 +0800
Message-Id: <20240829013058.6178-3-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: ae8793c2-2c7c-4e25-c6c3-08dcc7ca42e3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|52116014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: H8eoLHM5EIhX9dqgnGpxpgcyxB0fB97VIKQRp6g0p581d9+Eb2Kd771C/Xm8qeaktge17NY3b0Ef0i0MFIreciVxykTWOG/4FlYU+XK1n6EJKwHBSkDsMafxAt112EpoWsw4hDkOvkzki2XEN+TGGURNgZPC/CfVy14ps43yHskGRkkgdOOjB/SHQFf3dao3A0ST/6ke3CiVepgtrkyQTGk72jnq7Q3prMad8Mysmd7fDc2kyJ4/+63DeUsSr7ZuYouWOrY5kZbjFEI1WRsDFkcRzWE9XlkE7f7RxuoKzCO0EKnbMDP+2bOquZHaH67T2xYP9A5L+aBNecyczi/oqmomlk595vRlY+cX0/o3a8HXjt9D3VuUsT7k3oIFw+zsdkytZ89H3FsdFWxFzG8Y54/JxIZ0KAK3uQ09coc0ZwDYalbsz3l9VOmKm0ydsscnlZHbAhQW9GAwmdF0ElbFJAYnMnq9wsTTyjqni7oloeOS/qMRVoB7P8PA7TrTrAfUl8VjTUtQCHn/7DT912MuOYPtlbbAk9eEc51S+2M3x+KqQ+ijrfV9gbeQHBbYFkrkKWtGwAw4ENH3QZkdcgRRCkU3FOIPW4sFgMKjaqbce5qR7PXo7iNk6c8hdU60WUr63W3u7XCvkoGAzytXb3DPHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(52116014)(7416014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cQhsNKDciT1rKkUXNXhzgnCSk2eKfCeJ/lPSr4+TYGTSZxP28p0P+XKpBLuO?=
 =?us-ascii?Q?TuESgIErGK9l/FZlqS9yB30PYvgQvkhOnlMziX8hTiVywoQ6WGOB50VFIEAg?=
 =?us-ascii?Q?RXksAmGcTiicQGZfgp+2OabKCNBFofsak9UfR49O7Z5gGcI246ZWG+ARKlYP?=
 =?us-ascii?Q?dZQT2iAbhvmA/PwfmAPc1GJuAvrp/+xWDVtn+j6FB990q2vT69+Rf/IFEcm0?=
 =?us-ascii?Q?8LM4TcawV9N0GNMQpEPiY7vfNoxd8lhHAJoG0dhOXnEcsJmt+r25K9hlZKNj?=
 =?us-ascii?Q?YzqJIsLOpVfOftGoYch3jGXRshNJ7NVkpMQ2PMIFmwlRqnj3zN9On5Yq95uV?=
 =?us-ascii?Q?+k0ve1EX3rr8U8G3/VVLGWpS92g5DvAN8lbXBPyUthhmp0sTE5T1/ZZ8DMMw?=
 =?us-ascii?Q?hBcH26ccmdDSXvbd6SyKRZGfRRfVFtpl9A06gaBUvbsRzAF8ujU0t3mKm3Y9?=
 =?us-ascii?Q?1LTo0MwxAMejxKjYd/xMCn9ogF0HT4g8qqjn5CnQv8+Vxe6d2G9PW/+1PMqg?=
 =?us-ascii?Q?TF59+t9ZZMUnjZCmQAs4s5oruF2ZCjEJs6tA9sv7v3XQB9N/SGLbyl+t+BJK?=
 =?us-ascii?Q?KJynPWMrS39TeLNGW0x1Ih1GgPMv3SjD7PW2+OqKrBfCZrolIpQgQBVGQ+dD?=
 =?us-ascii?Q?YT0JGtGt68zvCIV52pxGuJBAMteOa3e/O8psJb/6TEiwDB7c4KmyiswRfnxZ?=
 =?us-ascii?Q?jlBYA9EUR44CXHgyNUxg1mIcwZ/Ntf5/obvVsHl0pK9no4LMxN2omUL8u5OX?=
 =?us-ascii?Q?8SuAhFV6D3n1oiW6y1eoxRcyD7rrqcizXE5BBhLEgZBb3omMdc2bimMQ9Jw4?=
 =?us-ascii?Q?xMzMbXqazz5LelWL0123U/+WbWujA6qXRqa2/csJHqP0ilvadBql7l0NzR9s?=
 =?us-ascii?Q?zZ4bNKOrYRzWh2m84lOJwesv0uv417pKJ75tstGMIAES3GwpjOX048bUxoNv?=
 =?us-ascii?Q?fCZAvEID26PV8KZCwldWvtSjl64uqSy1nrYgzJFN6hM5NW5B7YwaHauqAwTN?=
 =?us-ascii?Q?bFLiFMwCofeXeW5x5XD0VlJ4l9b39XbkqtieYN2ufedKaPS8/omLCRWUy481?=
 =?us-ascii?Q?sb92j7EnhBtyi4PXJEfPSGpZbF4HRG2RNcx+O25CnHxn2Q6/NUqn2CWSgiUs?=
 =?us-ascii?Q?MbiTdvl2CeKYTqvuX1qZLQL5aP3Vve3KTHK8+zfB60Wh9WsZYAp0ZUQS1xif?=
 =?us-ascii?Q?0dI9PiFBzExAb5fthx+smujXsoDeJ1klLFT+gp8d6SkcIP+xGdPzQA++sTvh?=
 =?us-ascii?Q?bTb/A7p/zx4JxkpH8+cTEK2XqfT1MEOrfn+qSrP5gkrt2qEpLbkYSeGOMcZU?=
 =?us-ascii?Q?vfkSfErTf/fLzh7tLxQz0REg9QJZRTd02b7nGiC1kfSXeR8q9Y9WtCdqRqbE?=
 =?us-ascii?Q?GzrgO58fJ9rJrLLfr3CQ+8nKNOWO3L+Yqp6BfTd2bKurc3SwrB8kCuMo//db?=
 =?us-ascii?Q?qdpYiciQmMuEmdGEbPdCphHjrN2qo0HK5OxXcqYOX+hD7+8XBq53XzLlCeIm?=
 =?us-ascii?Q?U78ErvHDiPWasN2AV0H8gxQKV79B2/yO1Za3i15YQ+WGqVxPjZaEcaK940C6?=
 =?us-ascii?Q?IZenlaL8iXn3IDQN+Hv7R0kYwsVLktNhe/y5+Nm11KNiCsPN2NIoC+WMR/8p?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8793c2-2c7c-4e25-c6c3-08dcc7ca42e3
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 01:31:10.0241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4z1QQ/clrsYswU7bmWIAZCbE4115GlBYjQ/li/ZVwawCNR7NvjwKSsZsjp6YER4tgrSuyIXreJCpOQ1Uu+fVe4pgpiSwIUGAtSF3WG+t4U=
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

Add Starfive JH7110 USB 2.0 PHY driver, which is generic
PHY driver.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/phy/Kconfig                    |   1 +
 drivers/phy/Makefile                   |   1 +
 drivers/phy/starfive/Kconfig           |  14 +++
 drivers/phy/starfive/Makefile          |   6 +
 drivers/phy/starfive/phy-jh7110-usb2.c | 166 +++++++++++++++++++++++++
 5 files changed, 188 insertions(+)
 create mode 100644 drivers/phy/starfive/Kconfig
 create mode 100644 drivers/phy/starfive/Makefile
 create mode 100644 drivers/phy/starfive/phy-jh7110-usb2.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index e12347e8a0..f940648fe5 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -309,5 +309,6 @@ source "drivers/phy/cadence/Kconfig"
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
index 0000000000..6b5780e5fd
--- /dev/null
+++ b/drivers/phy/starfive/phy-jh7110-usb2.c
@@ -0,0 +1,166 @@
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
+	/* set default split usb 2.0 only mode */
+	regmap_field_write(phy->usb_split, true);
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
+	struct ofnode_phandle_args sys_phandle;
+	struct reg_field usb_split;
+	int ret;
+
+	phy->regs = dev_read_addr_ptr(dev);
+	if (!phy->regs)
+		return -EINVAL;
+
+	ret = dev_read_phandle_with_args(dev, "starfive,sys-syscon", NULL, 1, 0,
+					 &sys_phandle);
+
+	if (ret < 0) {
+		dev_err(dev, "Can't get sys cfg phandle: %d\n", ret);
+		return ret;
+	}
+
+	phy->sys_syscon = syscon_node_to_regmap(sys_phandle.node);
+	if (IS_ERR(phy->sys_syscon)) {
+		dev_err(dev, "Can't get syscon regmap: %d\n", ret);
+		return PTR_ERR(phy->sys_syscon);
+	}
+
+	usb_split.reg = sys_phandle.args[0];
+	usb_split.lsb = 17;
+	usb_split.msb = 17;
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

