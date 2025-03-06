Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6718BC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 06:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B9D58141E;
	Thu,  6 Mar 2025 07:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5046C810ED; Thu,  6 Mar 2025 07:21:00 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20731.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C01A81273
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 07:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/P9cOhxs5E5hNbT6g75DRNAuIm3tXym5yU6KXFadf3/m2HkPU+TGKtKdgPIYCbnaVDvfOCXrCn3GOFK7Ta5NFDjRYPQaoFn1CDhudbLZftnHDOaztjYlGdxNErNoNliC95LE91vnu+yV6YwD7Skwr7NIVaZnWeHKoz31E57DMEbWl7syFL4PJyB/ai35pPNoUYXQKXOW/Fgvu3cV95NxxwwWUU7xKP9VRH96sA+bLQwYABRzJYnn3r9rqfmvPFf8q4B2Jwi8Whgy2p4dDnCV2LeBgbokyI+abIHQRwV1JVuSMp7TI2G8mg1owL6b3kab45pP/vIc82vNioh2OvWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpNp2QaWdfmvhh4gYpPfSa7jSxKgMcGNB8suQ2nmcdg=;
 b=LNQ5Ifv/F0MDnclkIWh+sxfGe+Fptt3YO2UtjGiNH7XP/5voMqH6VAgKjclA7fypG1zDw1saKdiKQIY9zQTAe0JzEoz5HH0QRvFHyNDI6Rxuzh/Ux3hUGcLQsfzyIZTitPTuRd0qW29IpcvOxudwsWDpqkymQ+Dovqzt3mGLxohNChSCA5n7c+FqPuY7Th4vj8h0jXDu+hYNY6QJA0Pbnyun6imojTqiCNVV7Ql3TlpBJoRqLkBlV+kHjM/GgguqlnjeDrFjIIj1gvwmZgT5ci0Stkc05UHvt3d2UaKmKX3xAhFdXiaXuyOv5//fEAXDhUwHbAwe36tznDm0lahILA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.30; Thu, 6 Mar
 2025 06:20:47 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Thu, 6 Mar 2025 06:20:47 +0000
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
Subject: [PATCH v7 5/8] usb: cdns: starfive: Add cdns USB driver
Date: Thu,  6 Mar 2025 14:20:29 +0800
Message-Id: <20250306062032.50314-6-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0a6e143f-c10f-4870-8599-08dd5c7708f8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|41320700013|7416014|52116014|38350700014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: o6hgTnwl6KTwsj29UTCvmd3y3JLf17GiobLktmkSsWhH6XpP7xtMTPuAXerCPVNvz8gkHGh87GjSzPz0+tsYy8ctUJOnk98BdHphQUpO2ZNfbV+ImafmLlQaVjgpccf+gXM7eIy3dPb0GGiPjXppVuOg0U7ksdC08o5qqmwG8ZbsWULwbhO+G1id+AO8wUpNDN5M0/T1SNVfePVgpRL2rCKAgE8f7mDV8BVvW6ptt87zjySOEOWVKqhoBWng6XOlkKh/Lo+aoFk0Ya5APMZjx3POI1nSki2x4orZFgdj9Szp9xPA/QjRNTlhx3z99URBqT6b5uLtkJa9WVntf6eiaJNNBjljO6v1XaL2tPv4jIqYoa4IQ5/rM0WAR6jx7JYhU9JeFc1t1SPfeuIkflP+hya/7Y9bsLu9kIlcqpimp1PVKPCju+5p9ASqGX+oebdR98UNtMRwc64F62hoLS7E6jjsSR1fUQ20vc9pD0AD2dm0pAEeG8BV/gPMVm0ZpV2wElOigNOjT4ic1v2v5CN/bQsWafFIua54tzVYnqIIxIFDe17CzXuPR2iwGjcbTrGrtdDiQjDGKiF+Uv2+yjXKy1F7+ntUtbo/A5FTrjc49pk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(41320700013)(7416014)(52116014)(38350700014)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JfaMQszQAS6HlkEpWatl6jq9YYU4i6VY+Cj8TY228ZN3puIOIb9XW0amx/ji?=
 =?us-ascii?Q?tFJW1eQ1bxpmYeAJ+2v3LiIJ4j1MPMWIi2hSIn/aCuLRpstVKP0vFolDcmHK?=
 =?us-ascii?Q?Zklk2sN5wqmrntkqYNDakRPRLQhsnyxUzWCH7B71JdWsf2t8PoXn2PJl7jRN?=
 =?us-ascii?Q?pqVXj+YCyq5R8kywzNiPS1bdT4lpZkAv98Q+QJoOdAHulrcsRVAb4IBKNz3r?=
 =?us-ascii?Q?BjsLoXAKic0ZVEWIwzqQGzs9J0X34gH6BGVHEkFmt8v93zzz83Roi9Hr3w/c?=
 =?us-ascii?Q?EVn3iB52IUtm5ARqaVx5H5GKhrcbUKvR2I22wttUQIi9eqajh+MsuhbrNAI2?=
 =?us-ascii?Q?ttVb5dml7BSqOYyuU9zyU0b0bi0WTzCAQixqPdWPPLkNraqawcdPg9Uczm9/?=
 =?us-ascii?Q?MOcbx1p2vKtDqM7ZR/yPenfPKp3qRPHJlzZMFh+6CVr1bcTLOfrxU3THRiK6?=
 =?us-ascii?Q?nA1PYVKvXIuPkKzHCUsjWA82pdFmL/WbymcCQElHf6duLEjB9krsw5sGfo/J?=
 =?us-ascii?Q?kZXTlC7P9Na6Vkt+RaahM/bQVGwP4CMfnXvKaCKWVP3mTVEiDmCAYv06TKMU?=
 =?us-ascii?Q?SgblyCR+eSniqTK0q+ev+2zGxqYCgIr5KP0lg4eKaTdqJ+e2ocr2S0xGD2pX?=
 =?us-ascii?Q?0QTGO1Lx5PiATLBZzci8F2xQeP/5AdE7mAneNUGiBdxwxb3IVCyG7yWkDct0?=
 =?us-ascii?Q?8JEkSQAyvzF4FyzU5biTfdKdMNZJ5GqVcLaQeRu2qaHHw5dr6MlqNxHPSgR/?=
 =?us-ascii?Q?FqNTE2Zij6uTHuPxfJ+iwpHYtHFnTZLC3926VCcfBnp+w6h7ZKkCTwwJEDvz?=
 =?us-ascii?Q?2PISBLIq1kyftLtef1VXnuNopvVTPPfzgwu4VqSUOfRSi4Zig/M/guu3tZO3?=
 =?us-ascii?Q?TeU9xqYK9iz21AIGLmpEgdqXYfREaipuEbtONCe5+VmEkj0YieHrbDoT+NHL?=
 =?us-ascii?Q?2d6LaoiYwmlSP3gBdef7uuxaQlXdW7AC3u1Di5Rm9lzyo+4S8beSaIXPUYAB?=
 =?us-ascii?Q?8/B7EpHR5TSPr1U1BbJVurSiwt+oXdzmkvf7v76ZNtjatrkIIBpETsw8cT+n?=
 =?us-ascii?Q?NQayxhnc6TdTvug1+ePAusG1nj2dWdAbIvWoOa6tw/jICwmcPoIKDle6XyUw?=
 =?us-ascii?Q?lvIkigUgCDDbGp0BnU2bJMaGygU9gX1NxmkFTm/5/nTi6AzZ+P2K0zecZiDV?=
 =?us-ascii?Q?uOmuPDqLaza2/5LmobGRGXDfjm6UgjmuiVHAyoZgnYyUd2p2EdRdR3gjaVh4?=
 =?us-ascii?Q?u0Gczlfz7jeVdt2jzENgONCuWXdviDVeaX/V1lX9iNLoLw9TlPZC1Xi2D7NZ?=
 =?us-ascii?Q?uwOZPW2GXwdHLxfPw24s2txq9+0+58Y6sP4tVGOifCQvEcS62IKDD6oTCKT0?=
 =?us-ascii?Q?QeH3L/KiR7aSiYpBTWJSinBI3ifeLluZ6i9KWlaJrugoQ3ya38RfsfEPnmBC?=
 =?us-ascii?Q?Kb723VrGOsyt6EsMjFk2OSw5RgvgPWuSQxS44IRYuGrMFlgyDfNvjNS+LZIF?=
 =?us-ascii?Q?RvU/moE/VqZfFtq9EQCqAEfpgmCvcCkwXdlN6VMuDKK22QRyxmo2cq3568d0?=
 =?us-ascii?Q?UWoYcZY36lCGtVTyIlhkycssUuM4bQ7wA0jtf470xE8J+Yxv/QTCHvmPtyp7?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6e143f-c10f-4870-8599-08dd5c7708f8
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 06:20:47.8802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87xbfIAiMc52HOpm+8kIfJ0TYpHeD7kIy2auG4Wo7Noxa/5KRZWU276CKkV/Sg+4CR6MXpd2nxs1mc4iJSzWPr2WagcyB2juSKTZznBsMmo=
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

Add Starfive cdns USB3 wrapper driver.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Tested-by: E Shattow <lucent@gmail.com>
---
 drivers/usb/cdns3/Kconfig          |   7 ++
 drivers/usb/cdns3/Makefile         |   1 +
 drivers/usb/cdns3/cdns3-starfive.c | 182 +++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 drivers/usb/cdns3/cdns3-starfive.c

diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
index 35b61497d9c..1d5e4afac6c 100644
--- a/drivers/usb/cdns3/Kconfig
+++ b/drivers/usb/cdns3/Kconfig
@@ -49,6 +49,13 @@ config SPL_USB_CDNS3_HOST
 	  Host controller is compliant with XHCI so it will use
 	  standard XHCI driver.
 
+config USB_CDNS3_STARFIVE
+	tristate "Cadence USB3 support on Starfive platforms"
+	default y if STARFIVE_JH7110
+	help
+	  Say 'Y' here if you are building for Starfive platforms
+	  that contain Cadence USB3 controller core. E.g.: JH7110.
+
 config USB_CDNS3_TI
 	tristate "Cadence USB3 support on TI platforms"
 	default USB_CDNS3
diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
index d6047856091..1f00f23f704 100644
--- a/drivers/usb/cdns3/Makefile
+++ b/drivers/usb/cdns3/Makefile
@@ -8,4 +8,5 @@ cdns3-$(CONFIG_$(XPL_)USB_CDNS3_GADGET)	+= gadget.o ep0.o
 
 cdns3-$(CONFIG_$(XPL_)USB_CDNS3_HOST)	+= host.o
 
+obj-$(CONFIG_USB_CDNS3_STARFIVE)	+= cdns3-starfive.o
 obj-$(CONFIG_USB_CDNS3_TI)		+= cdns3-ti.o
diff --git a/drivers/usb/cdns3/cdns3-starfive.c b/drivers/usb/cdns3/cdns3-starfive.c
new file mode 100644
index 00000000000..78ceb831b19
--- /dev/null
+++ b/drivers/usb/cdns3/cdns3-starfive.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * cdns3-starfive.c - StarFive specific Glue layer for Cadence USB Controller
+ *
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ *
+ * Author:	Minda Chen <minda.chen@starfivetech.com>
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <linux/usb/otg.h>
+#include <malloc.h>
+#include <reset.h>
+#include <regmap.h>
+#include <syscon.h>
+
+#include "core.h"
+
+#define USB_STRAP_HOST			BIT(17)
+#define USB_STRAP_DEVICE		BIT(18)
+#define USB_STRAP_MASK			GENMASK(18, 16)
+
+#define USB_SUSPENDM_HOST		BIT(19)
+#define USB_SUSPENDM_MASK		BIT(19)
+
+#define USB_MISC_CFG_MASK		GENMASK(23, 20)
+#define USB_SUSPENDM_BYPS		BIT(20)
+#define USB_PLL_EN			BIT(22)
+#define USB_REFCLK_MODE			BIT(23)
+
+struct cdns_starfive {
+	struct udevice *dev;
+	struct regmap *stg_syscon;
+	struct reset_ctl_bulk resets;
+	struct clk_bulk clks;
+	u32 stg_usb_mode;
+	enum usb_dr_mode mode;
+};
+
+static void cdns_mode_init(struct cdns_starfive *data, enum usb_dr_mode mode)
+{
+	unsigned int strap, suspendm;
+
+	regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
+			   USB_MISC_CFG_MASK,
+			   USB_SUSPENDM_BYPS | USB_PLL_EN | USB_REFCLK_MODE);
+
+	switch (mode) {
+	case USB_DR_MODE_HOST:
+		strap = USB_STRAP_HOST;
+		suspendm = USB_SUSPENDM_HOST;
+		break;
+	case USB_DR_MODE_PERIPHERAL:
+		strap = USB_STRAP_DEVICE;
+		suspendm = 0;
+		break;
+	default:
+		return;
+	}
+
+	regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
+			   USB_SUSPENDM_MASK | USB_STRAP_MASK,
+			   strap | suspendm);
+}
+
+static void cdns_clk_rst_deinit(struct cdns_starfive *data)
+{
+	reset_assert_bulk(&data->resets);
+	clk_disable_bulk(&data->clks);
+}
+
+static int cdns_clk_rst_init(struct cdns_starfive *data)
+{
+	int ret;
+
+	ret = clk_get_bulk(data->dev, &data->clks);
+	if (ret)
+		return ret;
+
+	ret = reset_get_bulk(data->dev, &data->resets);
+	if (ret)
+		goto err_clk;
+
+	ret = clk_enable_bulk(&data->clks);
+	if (ret) {
+		dev_err(data->dev, "clk enable failed: %d\n", ret);
+		goto err_en_clk;
+	}
+
+	ret = reset_deassert_bulk(&data->resets);
+	if (ret) {
+		dev_err(data->dev, "reset deassert failed: %d\n", ret);
+		goto err_reset;
+	}
+
+	return 0;
+
+err_reset:
+	clk_disable_bulk(&data->clks);
+err_en_clk:
+	reset_release_bulk(&data->resets);
+err_clk:
+	clk_release_bulk(&data->clks);
+
+	return ret;
+}
+
+static int cdns_starfive_get_syscon(struct cdns_starfive *data)
+{
+	struct ofnode_phandle_args phandle;
+	int ret;
+
+	ret = dev_read_phandle_with_args(data->dev, "starfive,stg-syscon", NULL, 1, 0,
+					 &phandle);
+	if (ret < 0) {
+		dev_err(data->dev, "Can't get stg cfg phandle: %d\n", ret);
+		return ret;
+	}
+
+	data->stg_syscon = syscon_node_to_regmap(phandle.node);
+	if (IS_ERR(data->stg_syscon)) {
+		dev_err(data->dev, "fail to get regmap: %d\n", (int)PTR_ERR(data->stg_syscon));
+		return PTR_ERR(data->stg_syscon);
+	}
+
+	data->stg_usb_mode = phandle.args[0];
+
+	return 0;
+}
+
+static int cdns_starfive_probe(struct udevice *dev)
+{
+	struct cdns_starfive *data = dev_get_plat(dev);
+	enum usb_dr_mode dr_mode;
+	int ret;
+
+	data->dev = dev;
+
+	ret = cdns_starfive_get_syscon(data);
+	if (ret)
+		return ret;
+
+	dr_mode = usb_get_dr_mode(dev_ofnode(dev));
+
+	data->mode = dr_mode;
+	ret = cdns_clk_rst_init(data);
+	if (ret) {
+		dev_err(data->dev, "clk reset failed: %d\n", ret);
+		return ret;
+	}
+	cdns_mode_init(data, dr_mode);
+
+	return 0;
+}
+
+static int cdns_starfive_remove(struct udevice *dev)
+{
+	struct cdns_starfive *data = dev_get_plat(dev);
+
+	cdns_clk_rst_deinit(data);
+	return 0;
+}
+
+static const struct udevice_id cdns_starfive_of_match[] = {
+	{ .compatible = "starfive,jh7110-usb", },
+	{},
+};
+
+U_BOOT_DRIVER(cdns_starfive) = {
+	.name = "cdns-starfive",
+	.id = UCLASS_NOP,
+	.of_match = cdns_starfive_of_match,
+	.bind = cdns3_bind,
+	.probe = cdns_starfive_probe,
+	.remove = cdns_starfive_remove,
+	.plat_auto	= sizeof(struct cdns_starfive),
+	.flags = DM_FLAG_OS_PREPARE,
+};
-- 
2.17.1

