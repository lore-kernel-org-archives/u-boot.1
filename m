Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BF2C4345F
	for <u-boot@archiver.kernel.org>; Sat,  4 May 2024 15:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 268528858E;
	Sat,  4 May 2024 17:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA0358858D; Sat,  4 May 2024 17:04:18 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20709.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41D148859C
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 17:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nD0D2EsKtaIZOPzYtwNZ2/kUKE8P3rkmUte00HDpeHQ8lbNYKvfP8h4ZijsttOdk0qb91ZEb//y0MXWFCkj6kUOF2H6o299FaZ04VRns9trkWD+cErShvFRpGDvGf90NpwEf4wKD1HuNp1Kzv8P5rKrf4LXt1yNh0vRt8sfF6k17DjJ8Bz90lFEZcJyGgBJ2O6020xHpZWsTES1w4w6v0FyE1leQGOQve7ObUhw2ixEJAc5Ci/0pfS3vfmC1YhweF5KaMhdEOGXTeE1YB91aBLqMQspzSOidIYtonm6bM0bJMHOUveo3x5yM9ur8W+wSJnW0Hk6p8uxxLej0epR4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2GTFuAlTq25yr6XHdTZQUGNkQk0TSYSo7704GJstDU=;
 b=aeViHK4YNfRrqa1WUOPD3OZhYlpnJPPCVxrHidGCxC/verE0EAt/JSQPT6mU4LOZKPsRQxvcX6/53hwNRsUBmAXCaDojifWg+9kh7gYs0DWjKlt0tzkn5yYKkMn7ttxzXe8/b79jS4p7RHNNillYqHK3GBCzmprcFYKv5VaFxofzgwFWDISaMQrUDb9dfRCeO29MMOVCeyp2tGjBmZzMJ8YJdV5rc3wNdJZ7gWZ5ZSBuzfR2FUJM+E6W4XfU5BnW/ERX0h/3iZC8OyqLrbp94YitvE39aJbScyQQbpPUKbHIpGtE6FyWko3FW9mxRFojp9q10eJvlX+VC/Lgtsullw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0839.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Sat, 4 May
 2024 15:04:11 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::3e54:57b5:e3e3:7f09]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::3e54:57b5:e3e3:7f09%6])
 with mapi id 15.20.7472.044; Sat, 4 May 2024 15:04:11 +0000
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
Subject: [PATCH v1 4/7] usb: cdns: starfive: Add cdns USB driver
Date: Sat,  4 May 2024 23:03:55 +0800
Message-Id: <20240504150358.19600-5-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240504150358.19600-1-minda.chen@starfivetech.com>
References: <20240504150358.19600-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0005.CHNPR01.prod.partner.outlook.cn (10.2.0.75)
 To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn (10.43.36.12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0839:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d48a39f-cb2b-4daa-0418-08dc6c4b748f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gpINXEL+6Z/wzqJIoLRkMClgcfOYv2zFmIB58A39MMefEuOACPftYAfa9ZmUX6zUpKDyP1t892g8BXt7LKeGSgTjw5y7BKhIwluPasqv+lyW0P/YN4F7H60p5OLyuzX1YsVcJg7oSB7ri8I+kuICnSho9wFyKSzK+/6H7kTGmwQb6JIeIOdd80L0Haap3VAXrjjjTC7ymTKgkVFoKTBaheaXyZBNYXzFrHHP7/Mh+E4DQTtnPXNAA2Ezi5Q/aeaA5unrfZtIsZ1S/Y6gZs88FNB9P5ehMBU9mkVSXM8D+DXca2v4a7qLek18bUj53sc2mKh+NTic+PYbBSXVHO8pG9TOsX7eDDpsHSIT8FW1u+bpQdOH87QH30nnOQgYh5Qwn4/2DFA+8v1peMbb8CEdPnkYT7YR47Kzj1Xh/10gA4PFYkrdCKB9+dmUFJthJryv6VNUMpsK+r7liSVcor9ZMXmJjcyFHVGboB5p9Uk2AzGwKji705rwEnLK2KDGVa5u8W/FqXvXLI7djO1bitDoborHdR1qnJVmnhl/b/uQx84TApYQBp4cqVjyo0q1QOiVtq8ZOEYwXtEecen2HZN1e4q953IAm6gd3vg2Hg47pGgU9aTVYxD7GaQL0NH9MG0LzAR5TmSOIwzJtE1Qdk/KtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(366007)(41320700004)(7416005)(38350700005)(921011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Cdeuq2Tpw8YZ+1NlOFyweNelpyLJgZ7lrg20icn92HWMbBuJp2tbdKRBwVf?=
 =?us-ascii?Q?XnQcziDclBNHK764zmecwcDws/RH49ZhMRpKoQD3Jloi1KBCJGpjYrKpAEME?=
 =?us-ascii?Q?wRrvjci7PlEm/H3zMoBH73u42Wr7BdN31b4yf6623av7TFcRZaOWw85YWV/O?=
 =?us-ascii?Q?9SEut9SVRPQxYC6/bVeLvrHo0lKz3xNxBIMrLR71KhQfxLwD3nUPkRlaGpBC?=
 =?us-ascii?Q?opGIAWNJajNadguycsOJAGOwJ6iFw3A6eAbkMXgz+0OSucO6WbvF9cez2tS1?=
 =?us-ascii?Q?+n9JZskmDUu3j0qLVH1T95S4GiCzKjzSlmvjIagIQisLj+al2N08kLSCbmil?=
 =?us-ascii?Q?YHncEQ83r2Ldb01JDuQgWQXuhxbOr6Zxz8yEN7RjllDfUjblVEt2i50HukiP?=
 =?us-ascii?Q?IZlRnxSOFEnPczH0xCqwgqJj+iLDgqkAQmPHIVlAVV0bW8V+lrYgQUKKLVVc?=
 =?us-ascii?Q?5deUmzbGAbyFL7XWxyX1mLvfTXFBYBJzGhBuLX71ZnYY9YeoVuDe3x3Qs9MB?=
 =?us-ascii?Q?k06NpoZtKCLnQBROWViRpyfhfEkQNwIMzNwUlNPP8IRDxatcLlJjEloc+YF6?=
 =?us-ascii?Q?XuO5a46TAXY8UEeVrTUMGCK2eXHFrjuKlgX6Sxpf5TW3GFl7bni/t34t/129?=
 =?us-ascii?Q?oURjnkTgvrw0/NOnE8toA/zAvPZkD8mPMRLLcmbRgSZ4xSv9f/V4emwfahuB?=
 =?us-ascii?Q?2dVJOyR2Iv+GWUnJhf/SOQd02yiU4W5JWBPyaq3nQYTFfnqP7DFRASQizA/Q?=
 =?us-ascii?Q?MOiF85L3kU1lh97ueYMBl27Js+mNfl0GX7ZopqZhyqQRDvgunP1ajBcq0POA?=
 =?us-ascii?Q?jtUgeNPxAjTSo2gVwuBi9fMW5d6Nw08EsN5SzDrFDmrJWO7p2hhWSjnNH1fH?=
 =?us-ascii?Q?QodLHcZaC/44F2ZmedjUnKH4P8FiJPUM3AT6zRc/hlIUq9vcIKWHMrNmA7FZ?=
 =?us-ascii?Q?FafgMC+W8XIyxGyvq8Jzk5p/05P+WcypzWkEjPgDjwOh9tTluQsMa35j5L8h?=
 =?us-ascii?Q?qMzdB890JpQiko5QVDxEbZQBngwS2uWVNKXjx9dSoexh0TQAe22rMe2XOkg6?=
 =?us-ascii?Q?KB+IP4H3Y9EhVSRZRQ6/yuTcZNrGmNYYiv85EURvAFWiXoO8YBdlguPS34rp?=
 =?us-ascii?Q?Zu2N7G5FaexT1YwvqNblkcaOxmraNdzxKBMDWITmSXIiPdkQh2Xu9Ytasx+M?=
 =?us-ascii?Q?CbsdNK52u+dFCtpzjCuExTfvX0YkCrK/XyotbNnr9bLDoCQV06Qrtee3Me3E?=
 =?us-ascii?Q?LtGHBUviRPmIbXPcVyjr2+3e8gqvUNUeUfobLRQymqMWnQQrAsiA+sk2qvf0?=
 =?us-ascii?Q?kfNvHI3v1RKGiouVsRs7x+XTMpAQL+JukTdu6NTiQF1vVP1SbAsXaJ0Ihjpi?=
 =?us-ascii?Q?VWG0L2iUiIRF7S3RpZ5TsSzXzb3U7B8KhTeG3p+cusnQfJljF2KOf88DRQEL?=
 =?us-ascii?Q?Ey5Kpclf0Lhtn1r6gygsxVpQNGfy2PxoZI3ZjOe3x8mm1agjd+4kyEjH2uft?=
 =?us-ascii?Q?579M5EgywAahHlJ6rpJ4YMMOC0Bff6QN0luIqEGSvHSBnG776urENplyGpcC?=
 =?us-ascii?Q?bHQjrvEwClZtES7CeIPczeYsdjal1/fxKgQPoGKcmq4Ni2EWj2HGgIwH5At0?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d48a39f-cb2b-4daa-0418-08dc6c4b748f
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 15:04:11.4885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZ+S86Z7tA/hQCqRyAQAtDIZq25CNSXnWp3vLxsoOl7PxrUT1KRv75StnmTR89OseEltpf29kuHUBNAf+oLR1NoaWsqTNvIM5lyS+/tG1RI=
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

Add cdns USB3 wrapper driver.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/usb/cdns3/Kconfig          |   7 ++
 drivers/usb/cdns3/Makefile         |   2 +
 drivers/usb/cdns3/cdns3-starfive.c | 184 +++++++++++++++++++++++++++++
 3 files changed, 193 insertions(+)
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
index 0000000000..efda47e2a5
--- /dev/null
+++ b/drivers/usb/cdns3/cdns3-starfive.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * cdns3-starfive.c - StarFive specific Glue layer for Cadence USB Controller
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
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
+	regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
+			   USB_MISC_CFG_MASK,
+			   USB_SUSPENDM_BYPS | USB_PLL_EN | USB_REFCLK_MODE);
+
+	switch (mode) {
+	case USB_DR_MODE_HOST:
+		regmap_update_bits(data->stg_syscon,
+				   data->stg_usb_mode,
+				   USB_STRAP_MASK,
+				   USB_STRAP_HOST);
+		regmap_update_bits(data->stg_syscon,
+				   data->stg_usb_mode,
+				   USB_SUSPENDM_MASK,
+				   USB_SUSPENDM_HOST);
+		break;
+
+	case USB_DR_MODE_PERIPHERAL:
+		regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
+				   USB_STRAP_MASK, USB_STRAP_DEVICE);
+		regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
+				   USB_SUSPENDM_MASK, 0);
+		break;
+	default:
+		break;
+	}
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

