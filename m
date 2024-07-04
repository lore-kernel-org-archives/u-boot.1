Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD27C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 05:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B92888B1;
	Thu,  4 Jul 2024 07:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 251DD88001; Thu,  4 Jul 2024 07:50:35 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61C5888895
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 07:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLHhHQQyzsoHQgl31uNzWsTMFgTCf6XUD8Hsr5bKa1DT1nnfyTUl+K5/xYbg7I+6lQIAg0euIZDbjMNSEKRWoMusk0AJKvaqHdHf3HW1abtKjoB7oP8U5qQ2ywZQI++ksW3zx5RUG2FcAJdHpfThFFi4Kv0ACXXxMrevXhVOMmIE7h1eRageCOv2c+Ert9AS8emVdxy3CsH029ecJy6XQBR4mgnjsBJIGk5Yl2mffg57HRMpcBwORn54HHB7p0pV2MDKOFh8kImwj8yQYZGqzUJrzbh/J/egEooBLyFuNNzXVp+cc4wPK0qNbO9LgvwkvterWLt9Q4lyUk6LLnbQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwleQ8IIQrRRQcQzIQCssdkFHA3jUlnIGC63e4YFZlc=;
 b=m9BfBGE9vPrJXhpYWVs2ci1H1slUG8glV/p1rOgtR8Zejteos66Va/SFeQbydICK1qFr2v1wVuorKzH3f0Z1mUfwoPn/VXvzP2rO5okersFmWdk51eUA6lAjwdFe6ts7mHVW6Z2rNils+eyOQ1qciQ41JAwKc/Ily2dkLOozwby4C4SLG5w2HxWCy5kB/IPOw8oCAuJpb/mtYvz91qnGY/loqk88+72Pd4FS/tUTo4Oskx0ZDJeNspUUtxyfpfR+HW7lN6ArBJjg66hftbAc7Bu9C4f+kKyUNG1D8VzlTGbPMbALnCXCGVyLnh0uBjMtv2ITERhXcBogTQFuccKgdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0766.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 05:50:26 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::358e:d57d:439f:4e8a]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::358e:d57d:439f:4e8a%7])
 with mapi id 15.20.7719.029; Thu, 4 Jul 2024 05:50:26 +0000
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
Subject: [PATCH v2 4/8] usb: cdns: starfive: Add cdns USB driver
Date: Thu,  4 Jul 2024 13:50:10 +0800
Message-Id: <20240704055014.55117-5-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3334a966-1540-4793-812a-08dc9bed33d9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: +vT+xQqD+vHEghT77cf6qFUM1ahlKrNA2AhMsN/veS8u8iKw5TMP2G+32ln+XCx4HT1E0QGXAb6LEMEK8dsWipNpKeQEer9M13TlgN/1AbCDRsK8thTR9wYXygZ2YilmQVemtKN53KaWUHfDkw2bV46Lrzi4SMrCIHHBjAJclugCl0gQylHjlSx43uP8jpdBO/OR41TTnDC2leojWo/4Z228Zeb7P/m7HZFbEPZ7ak+mp309nt2adZUp5kkfnyhvN8kX4o2EtCQprxR4cPrDQQmg3OuOCL3Bh/3kO4rfyaIhSZMJTx+RxgAdvsTvjixsqgJzGEfh2VJcxbkLD9n1kKX/lAGF79mrIC9K3W/n6t3wGn11O/7br1SweVhLidMXhE3PaYC9L3hZxfa5xcdSvOyeP5TPscSEF6BloCELNzyeJbvG+EV1iBeGtCU9YMFsQ1pctPiJP+jUrS8Bmm3KfX9zOOJaOvkYrCn6+m9NY2fyxoFz6jhGWgfkAFJ6+OYFWM/UscLpJxd8XobJVeyTMPgoJy64fwTWoVQLrpCwdphN6IpQSJRGksDlAxKLH5ppzzUBJEo9rqVQCUuK3sPd0YQTLUypDs5HdejtGxkZ5XyaVfO/GbPcU9D9zXcILY+W9aXexSshuUOD8XMaqZEnMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(7416014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZRelenIg5FiSaKMm5eQHtWpKCJbO9f8epPDOBMrsKTawhDGOMULY6XumOGGD?=
 =?us-ascii?Q?+9vUN/Cui2uDsM4bmD/EzDddBoFAHKINqKh+f4P+fbQLPa+8QGzZQVzA9fA2?=
 =?us-ascii?Q?MAwwf3oQESiGW/J2WPb084WsuwJ4OeZ9rAOCOp+DwY4/xZlhcyCSiaqIwt4X?=
 =?us-ascii?Q?LwUG4PWdUb2XZm6IC+FBDqlO+r/DIZ5rkolaVThTZ98y1aAxGVDz14YUmoSa?=
 =?us-ascii?Q?wXKoYQRXYscpKH5iVTARFedCIlKEGRwd4rzKCWzRrad+pJRNfCC1M/dyis/G?=
 =?us-ascii?Q?IOWL0PLSYT7ut1s/wBRyzM9/lxcqpeD6NHnTvcAki+XUbQi4MwIdTiErMhM7?=
 =?us-ascii?Q?/Is7Zo0EuGi+Ac7lGdEKnOVYIpwEYJL9gU8KuzLeSXkBwr48w1feXYxGrBdO?=
 =?us-ascii?Q?VSnvUhIC9UzfUJIJbFocLuosmXC4ej5wKPbV1iJozvtOtsvb+2EIjNsu3khq?=
 =?us-ascii?Q?Sj62Hdopu/6cwvc+nYVENM7HFSQTWybiasvLVwUTJkJDWRJ+JbcySipNI4N0?=
 =?us-ascii?Q?0QOAu/8C53TTDQxUBOyby2+8a1hYzcUYFuxA973+1OuAAM/P5ksuKimpNtmb?=
 =?us-ascii?Q?8cCkTakt/Pl0gbHzAJS+2TylDn5VDeCUI3e0dYuS52Ip6h3Z6gQTNH90UcmC?=
 =?us-ascii?Q?0DET6o+mtFyRnDZ1+33eqQtV18jrRAvqhkMKyTno1YGcFH1Q2yP6rvqcs/7F?=
 =?us-ascii?Q?YjdChnUrgH8IIIsAMfTpId3I7BGwIMimzXrzgW2XEDkGfiuj8QwXQ8B1cxJj?=
 =?us-ascii?Q?QyUDKvWPtT4DrvbAFrrE9veTHI5sUe1Fja4XB8Mh056Se6zPEo8pxbu+hzjB?=
 =?us-ascii?Q?TfYsmXI9h8AG1wqLalKJOF35jD8cj2j1KcT9j1sqvCXk3F9RidKEHSzDG9ww?=
 =?us-ascii?Q?WAC3CuYiVWrZUT6Sf0MndzJDlBmMUJvjclHXzAohV+indC8J8veOSRgSyj9D?=
 =?us-ascii?Q?u9qDwnMMZDeGIE4m5Ur6Urwt5Rus3QrPeRKSi5PPe3CQ9v2IxMh6nf+W4+68?=
 =?us-ascii?Q?WpErARN3Xi5pIDeGfc0CepIb9zuxsVO3we3roNAzWv/wrZBPH26S38vK7KoN?=
 =?us-ascii?Q?ttjzyRXzm842XE3BRVCDcjgMsLbXrGFWxjSU1bkeuCJOLwr4Va5l7a428e8w?=
 =?us-ascii?Q?7IyQw0Jp3eKb+8X0XLS1/YIraIAseQsqyEBJX2V8J2bAFDB5yrRfh7VXATFU?=
 =?us-ascii?Q?g4hQXrHnsBs1IbeIJXSiaI/86LMDwC9DGJaGhSE+GpOiNi9IsYQQDK/tYtIU?=
 =?us-ascii?Q?YroDwQdmesDBusXWCBuvEq959MPlaH9jQNDKmLQRXBlbGA7g28/7YliEITdU?=
 =?us-ascii?Q?8tTKxSL5CF3aJh335WBS/Ep1Ev5L90SXgMozlUT2PTOyTXymnJwErD0bpZaL?=
 =?us-ascii?Q?ta0S7KI3FjlsVxwuSQszbRcCHqe3WiiQJz8gHiEyz+uLwF0UybgC/LH8hAWY?=
 =?us-ascii?Q?OQfXLvYTP9tttqLnGRETxGInkzLU2VmUOZAx4fAgZb9GtbTeaysVbv9A9w0O?=
 =?us-ascii?Q?SN4LcTYOoAgoX7g5HXC+SnK2q4twhZBfz1yYCgoLTsYky2AGpDeSoPia7L/z?=
 =?us-ascii?Q?c2mnJ/roGY+yX0z6I3iMmu6nIbXy3n5lisVLIonFq1+XGumOLPyL4o7UuKy+?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3334a966-1540-4793-812a-08dc9bed33d9
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 05:50:26.0126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hHbUJPmBz1jkY+oGM/nBnP7NTevTE+D+HHAxlggAphc6sjwuNYTzV7PzLIpJ0f9LmK0Flnu83oO5G3DVWebrs1v+1v6Ssy0sIVQ0dQVmxk=
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

Add cdns USB3 wrapper driver.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/usb/cdns3/Kconfig          |   7 ++
 drivers/usb/cdns3/Makefile         |   2 +
 drivers/usb/cdns3/cdns3-starfive.c | 183 +++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)
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
index 0000000000..660833fb5b
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
+	if (ret)
+		goto err_en_clk;
+
+	ret = reset_deassert_bulk(&data->resets);
+	if (ret)
+		goto err_reset;
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
+
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
+
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
+	cdns_mode_init(data, dr_mode);
+
+	return cdns_clk_rst_init(data);
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

