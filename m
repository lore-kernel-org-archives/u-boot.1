Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDA1D1A427
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 03:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E78288B58;
	Sat, 12 Oct 2024 05:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 119FE88B1F; Sat, 12 Oct 2024 05:13:59 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20708.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::708])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D99E88B79
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 05:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+JOMOFax9P/V0KnF7u2U4qSey/UsbylfUI9ifol70UEDr9VNOwmOycQzyBDcoeExHXYKgH7Tm1hkFTvuK6q0FHTpj0w4TE67wTGaqt7Afxsgc28XofChuXgTpjjL6LJAxlDSBU+xH4bhS3H7XXi5bFqLLxp8B4NTzeYRr4IhylvUH46ayfb7nDjUJAJUgnfAxxmfKPaoVsbaD+p5ZoJQm1ZARzoJuXPG6x9NGmOYefODh1OYTNrUrpQknHm/ZUKpzMXH3G3AmWPdNAT1cAbMZb7ECKR8oDo/vPxao21n1DJqXKLRQ7ARS1msRw4zNErVF5aAZ6+A5pmd1PUQVc0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSWpKZwjKglNyD5kUDo03tGh1KBM8g2582ABro9Ujso=;
 b=UAYuDog9QfVQjOarMN2miQLDsTD4wFoGRP4RMjKO01p+ITSN3nl4+wfC+0qNhV87P4dYvIPIdIGTkZlRBnsu/EF9LFi3Sg/zNs5fKtljTu91m+y+XRQpfqDUKya1pDlzHJ9yRtJ2KyukD6pgWgKdddXK2pXPjQy3cjwBP+UWeVCLG0nfpAHUE/92CobPiIGX0huwI53llR/EajzVPeqkon2DupWeKRBpt55UchzLR1ty3cUqklcPt8pKlBpqkCANaCkLvr2oa+5Catw1F+YixS2b6Jwx0aTDNlRyeNoGhKVscBjbf85DCp5bGAMJ3QvY7yiVNCdG7Sa0Ge9GgdVlRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17) by BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 12 Oct
 2024 03:13:47 +0000
Received: from BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 ([fe80::480b:a135:6e33:10ff]) by
 BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn ([fe80::480b:a135:6e33:10ff%5])
 with mapi id 15.20.8048.017; Sat, 12 Oct 2024 03:13:47 +0000
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
Subject: [PATCH v5 4/8] usb: cdns: starfive: Add cdns USB driver
Date: Sat, 12 Oct 2024 11:13:24 +0800
Message-Id: <20241012031328.4268-5-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 94d4dcad-3cda-4fbb-f142-08dcea6be2f9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: pA/7e7A0xBosdZPItsz/nuSQrOO6wOFF/Dcncqchsv76BhAhwlTNrQiiw+C90FzZZMHPhfZ4eQzNsO3ZptuTUZzSTaflNJNWsd6zOMqLfHH0pKptjw53o72E8gcBrFdK7S6PqVzNdZwQoa80ghOsLwjWtrY4Ge/LfYjddaSgfEpC1+ouXZhLuHZ06Qk5xAmcoCn8y4y9BUmRFUVib1QG6sZ8gwLg9TpK24QY/HOnZj5oWspcqTmuYkOHm31JX9d05RO1o5VziLFsMz6bt3EQwQTzKmJ9h7WfEDzMYuICWzNN8Y3uUdh8DuqaFcxWUNFFlb1jc28UCfjGt5sdztok0P6/VKEqpYJiPiJRXwn5pzZ+9Rg7tJft9lBpXZvyBVrOxww0PV8g4cDcjhQiMAniAodtdoI7mC0hyjyTGQ/rQg1K6vGg3S/Y5RJDU+dgOm4wHEIiMlqY4voa/7uFWzKZCH/fo9BSDIYQu4puLlk1FU7dZTKlNoZ3tDgxicWhntFDjHt4e+HqIHrbmoieULNMYdgemCTs0uz5nbF2Dsa9mAAwqOMwG2NSAiwIOT2d7AEluwNdVkTlKY7+zB0YHYDj/4VAZTt/F5nE5t7SqfJh1oAjxjn44wg/Cm9pgUc33yN/rmFH9XXfW0+x6tlHlum6eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wwo9K+PNoim6BTEMpl1q2s23fJAMZWye2f0/liibKmDbuJCkJQfCJF4bRNVd?=
 =?us-ascii?Q?pH5SDsCADnDyWbNPr49o6PAgNuz1KqtacFC5Xn+ekqoZ4qoUkvbzppUSnth3?=
 =?us-ascii?Q?hyqTI8fLOFNO0ez/ZD2w5Tkw9QDo5bG2apaWv8OfhE4CUSm+qm1gE9IvFpea?=
 =?us-ascii?Q?s0FeTRArSI/2Ceo00rwsr9E5/VfHWGF0/rPIeKNhEgv3TmwAzKXipi8HDECc?=
 =?us-ascii?Q?R7kHc9eiQD/by32ijFp2RofYQx1RdbBNQ8A3shbYhpbRZ3VGn/sdh1IGRRni?=
 =?us-ascii?Q?Zc0tTTA56TS5JJbQXaxyyjggWv8RZBKrV/cbbsaJLmKhP3jvT7fmrPUUVg4f?=
 =?us-ascii?Q?YBHsly9XtCmrvzMiDUwtkWKgHn0gVfoYcTCog9SEC7foUDz+xSNsDqwxurBH?=
 =?us-ascii?Q?rHFVJCP6p53d+95AurKXZ6WSDyq+YN6c/HgOHvwPiT5/CWwJ5fC+/M95CTG9?=
 =?us-ascii?Q?hkfy6FmPqsPLf6+CyEKCxgsMgfQrr6ytoxe6gvdyABOcQLDENs2ihjeqFMaH?=
 =?us-ascii?Q?tffTsDmDoAno0jzJNx+LI+s1eGgvOYFcc6UIXuu1rkiVJuLYirj3MmmpM7t+?=
 =?us-ascii?Q?s39rI4wGeOsgPNYDYfufe2kYEVIEFKVZ4jzwyjjoUxs49ac0IaO6oYUaxlDh?=
 =?us-ascii?Q?9q8HgbGJFUDqNfcyi23iZvZrkg3nH4B6GEQqxY9hIa6W0QXxfAIorEo9lQrc?=
 =?us-ascii?Q?O1BKvyVFLckq0YAOwkdjxs3G9VNRkZs+I9PmUOEjQj9jbbxpqLJz+TMPCwdt?=
 =?us-ascii?Q?DU4pgMyH/CK63sAeIuT1ynGbJXDGIzV6fCN458ooZW4B4l5rTkpxDyiU8KYj?=
 =?us-ascii?Q?V/tzjvmRmJLuvpI5k4jnMtySBhNP+h5EzMa6aCGICvpr2o9L3OXsZxHhpi3Y?=
 =?us-ascii?Q?HfuBhVrI6P7kRSJrrfShVL3B1bPizSXHYMTxZnp/9jXkYWFNwzEkjWlUQ5Bj?=
 =?us-ascii?Q?iln1Y3gHYB+vNF0YqlwVj5n7YO0qZ7HUtIzxsjQSAJzWQPBCLgrZmYFtJhCU?=
 =?us-ascii?Q?liXbO51vXBRC+8c8yLVJMgAH2yeS6L9E6EUMoftLyb7b+ISTkBReQV4MhQyX?=
 =?us-ascii?Q?81iAZ/sKzcb3v1iKIeDEIQOPmkLXCgB1yS+CNwmUQsSrWWwJp8iMHHAzNLaw?=
 =?us-ascii?Q?dfWycfANRT7HPlIHQuEidGyOkS9DNyD/GKcDsUyjEOBYQBDMtMR6/2VkTT3X?=
 =?us-ascii?Q?RI/HXhGjmsro/A/07lQvoJa09SnYOn8MLu/lSXAnhboSA+P2tEfMOvPuELwB?=
 =?us-ascii?Q?QrhvxiSvCANnWjSOoIZz2SN7sktm1uNj9X6bf7YOoZl0ivDSCU0HokqtsbIS?=
 =?us-ascii?Q?8wDPtEfYbR49kv50AAYdoYuc6bIK+CTIUneEmAYur7zbtHwO+G14gi+Z0Z/o?=
 =?us-ascii?Q?29WB+5HMbmsiOykKTAZyv4dSmFznEEeDgL/fPWfBDI4XGdE5Tui74BQpihnp?=
 =?us-ascii?Q?iLmgtlvvilzyCOXA6SLu8MVLrUiA3TMuYhZq08YePybtJVTYVHWZIKCMeD6a?=
 =?us-ascii?Q?9Mm4WFr0mLhmuMhBXeTY4sWjnOgcxisG31OADo43pBG43sPTB7zmtTg4pLaN?=
 =?us-ascii?Q?1GBGycCCVGX/UBvH4ejIan/a2zvEgHvqjP44zQFSZqeA85EUcrEdPTf7EmAa?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d4dcad-3cda-4fbb-f142-08dcea6be2f9
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 03:13:47.1276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGK9T3shENGUNa0huqssrjhxzLqhTUGM+8rD+oOZiQCBMIecGnhN5fgFzc/C65vBqT4FQPfH382rvvHok6GL45ABbJiwhvvMKSfjgftEmR8=
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

Add cdns USB3 wrapper driver. And cdns core driver also get
dr mode from wrapper devcie dts node to make it is same with
Starfive cdns USB Linux kernel driver, preparing for enable
OF_UPSTREAM.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/usb/cdns3/Kconfig          |   7 ++
 drivers/usb/cdns3/Makefile         |   2 +
 drivers/usb/cdns3/cdns3-starfive.c | 183 +++++++++++++++++++++++++++++
 drivers/usb/cdns3/core.c           |   3 +
 4 files changed, 195 insertions(+)
 create mode 100644 drivers/usb/cdns3/cdns3-starfive.c

diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
index 35b61497d9c..6c9595c3c49 100644
--- a/drivers/usb/cdns3/Kconfig
+++ b/drivers/usb/cdns3/Kconfig
@@ -55,4 +55,11 @@ config USB_CDNS3_TI
 	help
 	  Say 'Y' here if you are building for Texas Instruments
 	  platforms that contain Cadence USB3 controller core. E.g.: J721e.
+
+config USB_CDNS3_STARFIVE
+	tristate "Cadence USB3 support on Starfive platforms"
+	default y if STARFIVE_JH7110
+	help
+	  Say 'Y' here if you are building for Starfive platforms
+	  that contain Cadence USB3 controller core. E.g.: JH7110.
 endif
diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
index 18d7190755d..03d1eadb2ff 100644
--- a/drivers/usb/cdns3/Makefile
+++ b/drivers/usb/cdns3/Makefile
@@ -9,3 +9,5 @@ cdns3-$(CONFIG_$(SPL_)USB_CDNS3_GADGET)	+= gadget.o ep0.o
 cdns3-$(CONFIG_$(SPL_)USB_CDNS3_HOST)	+= host.o
 
 obj-$(CONFIG_USB_CDNS3_TI)		+= cdns3-ti.o
+
+obj-$(CONFIG_USB_CDNS3_STARFIVE)	+= cdns3-starfive.o
diff --git a/drivers/usb/cdns3/cdns3-starfive.c b/drivers/usb/cdns3/cdns3-starfive.c
new file mode 100644
index 00000000000..fad05451c80
--- /dev/null
+++ b/drivers/usb/cdns3/cdns3-starfive.c
@@ -0,0 +1,183 @@
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
diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index cbe06a9e7b6..9d0a56fd0e7 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -410,6 +410,9 @@ int cdns3_bind(struct udevice *parent)
 	name = ofnode_get_name(node);
 	dr_mode = usb_get_dr_mode(node);
 
+	if (dr_mode == USB_DR_MODE_UNKNOWN)
+		dr_mode = usb_get_dr_mode(dev_ofnode(parent));
+
 	switch (dr_mode) {
 #if defined(CONFIG_SPL_USB_HOST) || \
 	(!defined(CONFIG_SPL_BUILD) && defined(CONFIG_USB_HOST))
-- 
2.17.1

