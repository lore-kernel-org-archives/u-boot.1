Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB95C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 01:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F06888B70;
	Fri, 19 Jul 2024 03:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F18E68818B; Fri, 19 Jul 2024 03:38:43 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20709.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 303D78855B
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 03:38:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JntEcIYz6Y5CuZUwcDobgDyUQ2T9tuPkuDKywjuQkWj67iUhKXb0CLkLPPumOfC5D/UQfTE6R0ABMuqVKS01sJUWR3msxxDSYz+3EtXqi5GKymoxqhnaqNOaJoy55J+saoOObNNoLMjYnswU7cnb8dyelrm+wEYdOR+GTwJrXRMelibQDQQftyT1TnBMI7OIKY/ZVV/rHYhBtRzn721cgohrpRFjjOtGoTDuJeFKhb9H6/2FKEBEx6ZzSM8AmOMFHs3Ukxzef7mnbK1GDjsXukQ8FlwyM5gHUtG4MKXmkagkAIRZLshfK7cs2XYE0lkruoBd4XIOu+6R0Dg3INPr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ir3VFEfLhABBHxWohfRXc1ZR9TyjNjxE7Sdef6cWNU=;
 b=WaY2uPUifA3yJrcpk/9aWquR6MBvNtQnVEY3e58e/ltcSRsKkm3tmoVFeLkDbyVfvUMC7as4a8DP1w1Ok9Pe+LvAhlXPyKEguVMnMzE+Vt8pdi2UIQtdTxa5nS4sWJobo9TAUZ0KmJBPAGfZNHjiq0SaaIepLtQldTSyzd7jRlCTL9kjX2ka0T04ij1QR9kz0iw6D/kvjNW2uwAk5peg/NAFc8/J5e85ELaW5PzYpkrhl2gKON5Z3qfjpukoOI1PwW963wjtxc2+11WpSeJI/4Dhkvfp1kjV66FNewtMn28Y6eJeofg5A4iJrIfqDyDPR5lok9nYaKfZIMKI6hw/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.46; Fri, 19 Jul
 2024 01:38:35 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::bd9e:fb57:ebf7:9d71]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::bd9e:fb57:ebf7:9d71%4])
 with mapi id 15.20.7741.046; Fri, 19 Jul 2024 01:38:35 +0000
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
Subject: [PATCH v3 4/8] usb: cdns: starfive: Add cdns USB driver
Date: Fri, 19 Jul 2024 09:38:18 +0800
Message-Id: <20240719013822.101374-5-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: fa2cfb93-ebfc-4815-11ac-08dca7938182
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|52116014|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: hiLHqaaC8Q5SuvsufjmzRfp1zAlqO/OZDhTrKrguDj+cTQKm19CxpcLyrjkCNocCYDmWiTN09zf/8Z7VZbGq2h8K5UaVqyeHvVkMqFLa0ggnqlKY+7NuIlFMsdewNSS8mREv1YJQM2MvY9FmDoQYXZgRTEeJFoE4gERGi6EbmX/JUYrpf5GKpkvjateUT4ObF65nZ+LspE365sofNs8lWqIzcLLfFoxLanFRf/qimcoSfu6fYEyWuQ4UXjq367Rm1s9zhRe8BG9dIme2PG/Z7OSB5rWL9UPZwLsWoAGqaj7xQIqG6KpcNyu3WYK2+pT2MjKcpSUosIETMdFnDEQT0lHU4ZNqhM/9U7ujcPDODYhRSihmXDXxZfMnQAuJHOzmiOgP5iNOuym8NcpJttOJqIqVlCN9xp8kNuRELr7sAkstbw9nH3QGlN877SmeC8W6McOdOXBEdE0Qphgqt98mpgsBmbyMSoRPRayYKPeB8w/AF1ZTEijCXcmpbYtEcE4isUcwWqMfGPNOoxR1rffPykJQ82mf6JJJtkpEmeYeHISNyT5buqYZ7FaU2MdVCKPVXvxsQ2+ibBOoHxBo2ONOfW16e3BL0h2pPBBGTk9F1sw8sdKMf9s+tbpiJ00uofw6glpwqTTbd5X7YpdzfmG2ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(52116014)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W3Fe6hC7dXhMQUb4t2fT5bSkVtEbgtspQi2h4RGBQ2/MxD81/KYx7g5HwSh/?=
 =?us-ascii?Q?bJdJGgJ+qMgb6xKfD5GDs3RHtZFSixHyxfZMrzoNqaOGqt379J/04DZNBjMF?=
 =?us-ascii?Q?Jvx7nkVD/LuKqLFebW4LCQqWHNPjx5sg5i4lExf6O6MRTRmSDrhYy/J6LZz3?=
 =?us-ascii?Q?JQhWR5NRg16xZOFtiACjujm2VheuUfqZgBXHu9NwQ2KpagG9I/cHoDTfY0Gb?=
 =?us-ascii?Q?kkcmasb2Ji3ShbSre6ovpd0ehjSP8WJHa+cOYQtmV9Y3pqNLg3KdVlwSKjM4?=
 =?us-ascii?Q?8Orkjgo3r3DOMrcu6Mxh39QMPuLhN3vfMdIxLJo+ShzT/To4LIj3MEXqCnvJ?=
 =?us-ascii?Q?Cdz/Rrb6pgHCdn0SWac3nTlyS41At6lmNxaeY/RjN4VPPa+AoPoJblPgxdIR?=
 =?us-ascii?Q?W10bWYQhormO4zLcqKR9ujDT89UlH9za0GQ1yaqdLp8xaCAmS593p0G0c8hW?=
 =?us-ascii?Q?1JSqJetC4wj2VQ5QgEVYlg+rR+yiJmC+T6RsgHZeBKM3RIJ6zKfpQYxoiQpo?=
 =?us-ascii?Q?twoZ8KsW6/dxI/fhyMSXGsklNhdcffD2pqCKbdiXSAfixq+STfwvUZoHDf+1?=
 =?us-ascii?Q?oNsFbSIZLTrfMgrw3xpn1LMaQuKLW+kA7lwm/LMMJcwpmEHPYRP6dMNlCxLe?=
 =?us-ascii?Q?+dmvS7QHJinS85q53Mgg7IrDZT6rD3bqjfXE/HyWIa37aFAvWQ2YJFlNsjFr?=
 =?us-ascii?Q?moYFmPXma3HmaQrnuNz1dY2kRJLRXsUe4hiYmu11dKb9gA+dinKwSANBOhTn?=
 =?us-ascii?Q?wBHR6Uub3IpqcA8BFbKbgwBC+32EE2lyFKNJrlUbk2DiPrE0Dbykfk5bHhUK?=
 =?us-ascii?Q?YYpXWCJjTuxvUJWbzzzux2ZXR648TimM6xkLaXgGzm8a5w13IDROA6j/XJ8v?=
 =?us-ascii?Q?4YVYe71Jx8kRmnE9K87FhAtG7PxFEOmy2ku8e7atqM8J1bbi4OiYDq9Tl/Hk?=
 =?us-ascii?Q?evMW2D/AN+YifR4Egitmt8NqYqPRCLVnOC6xAaY72WG/NBD+iN3aICQ+elVO?=
 =?us-ascii?Q?p2xsQwrGlVwawCcFUBbJg/Dtv+0/DnYccj3pT3e9ZnJEqjQFOQJ619eE8uEh?=
 =?us-ascii?Q?BkrVkVVqjagvZn8KUiRtoNJ8lnE50fQYIPwB3kz59hbSQAIkgni3hZmpd997?=
 =?us-ascii?Q?mpM1r2ZTJLPY39kbuJASuyUEYP1gn36Goco6uYsbU2im6WST3VSiThIeacgt?=
 =?us-ascii?Q?0b+jcAQGqOtQcR1zY3/sT1SkBvy2ramFe4E86wzM1Hfy11/GBNVdAIBs/uvM?=
 =?us-ascii?Q?mm8dPwPXCp+t209KtMPSl3Wgu81wbQA2dCHM+MEXd5p/hs3xqj7OplsOPVoA?=
 =?us-ascii?Q?KXiFLx6+4EShv1Un2iqW5jvjoFOomCHERAiWS7AKubnfbj74OVTHbAnb98X6?=
 =?us-ascii?Q?1EipTwa4m5pWtYnfdycLhOMwocxCEEuMaLrld6Ajao9SjGNWJ2FmTqqQwBIZ?=
 =?us-ascii?Q?d0dyZkbS3i3UIrA/Vz+XLYHQGsXrxsMiwB3e5t3ihVO790/8Ni+s6QPC3y+B?=
 =?us-ascii?Q?yEj/0p/a634Us4ElIN8oVoHdmaUZ3XMc8b8ZI8dTqrbvpwCDTrOI5eVSvpvV?=
 =?us-ascii?Q?pm3W9qngyZpuqFhDFb8PJ+k6noivNRbpDtcVIm9H0+M/KqUCexCqxFOF89ui?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2cfb93-ebfc-4815-11ac-08dca7938182
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 01:38:35.5338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlQprOZdmIckxy85aYdWu46HD+1aheG/VA2aufhNZ+vthpnkFoyIfWXdPZJswPIrBy5oOUhEpbU3JvK+hoS/dmZUN2ZhTCMIqI9Hj9ChTwY=
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

Add cdns USB3 wrapper driver.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/usb/cdns3/Kconfig          |   7 ++
 drivers/usb/cdns3/Makefile         |   2 +
 drivers/usb/cdns3/cdns3-starfive.c | 191 +++++++++++++++++++++++++++++
 3 files changed, 200 insertions(+)
 create mode 100644 drivers/usb/cdns3/cdns3-starfive.c

diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
index 35b61497d9..f8f363982b 100644
--- a/drivers/usb/cdns3/Kconfig
+++ b/drivers/usb/cdns3/Kconfig
@@ -55,4 +55,11 @@ config USB_CDNS3_TI
 	help
 	  Say 'Y' here if you are building for Texas Instruments
 	  platforms that contain Cadence USB3 controller core. E.g.: J721e.
+
+config USB_CDNS3_STARFIVE
+	tristate "Cadence USB3 support on Starfive platforms"
+	default USB_CDNS3
+	help
+	  Say 'Y' here if you are building for Starfive platforms
+	  that contain Cadence USB3 controller core. E.g.: JH7110.
 endif
diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
index 18d7190755..03d1eadb2f 100644
--- a/drivers/usb/cdns3/Makefile
+++ b/drivers/usb/cdns3/Makefile
@@ -9,3 +9,5 @@ cdns3-$(CONFIG_$(SPL_)USB_CDNS3_GADGET)	+= gadget.o ep0.o
 cdns3-$(CONFIG_$(SPL_)USB_CDNS3_HOST)	+= host.o
 
 obj-$(CONFIG_USB_CDNS3_TI)		+= cdns3-ti.o
+
+obj-$(CONFIG_USB_CDNS3_STARFIVE)	+= cdns3-starfive.o
diff --git a/drivers/usb/cdns3/cdns3-starfive.c b/drivers/usb/cdns3/cdns3-starfive.c
new file mode 100644
index 0000000000..839d72e4e1
--- /dev/null
+++ b/drivers/usb/cdns3/cdns3-starfive.c
@@ -0,0 +1,191 @@
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
+#include <reset.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <malloc.h>
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
+
+	case USB_DR_MODE_PERIPHERAL:
+		strap = USB_STRAP_DEVICE;
+		suspendm = 0;
+		break;
+	default:
+		return;
+	}
+
+	regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
+			   USB_STRAP_MASK, strap);
+	regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
+			   USB_SUSPENDM_MASK, suspendm);
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
+	ofnode node;
+	int ret;
+
+	data->dev = dev;
+
+	ret = cdns_starfive_get_syscon(data);
+	if (ret)
+		return ret;
+
+	node = ofnode_by_compatible(dev_ofnode(dev), "cdns,usb3");
+	if (!ofnode_valid(node)) {
+		dev_err(dev, "failed to get usb node\n");
+		return -ENODEV;
+	}
+
+	dr_mode = usb_get_dr_mode(node);
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

