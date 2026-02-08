Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83893EF06E3
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 18:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 502AE8341A;
	Sun,  8 Feb 2026 19:36:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PGyZSqOm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C930F8366F; Sun,  8 Feb 2026 19:36:15 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEDC8805D7
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 19:36:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dg3L5dacu+QO5gd+EDZXsN1w/tNVjzIj/tt1waVh9CEu6h4sj4ePbHr55JtG+pR63qNEwgzL46M73p8fWeb7MEMc2siKcM6Q2qWJBbMV4IcNnj0t759ZQSUJgMTzrEDpzj7NgOeg3rKX9nt+RoTMmTCiIQfnKFIK43gtlt3O8DeVtkfryYos6OrD8evHu3o9OLp7PLrQwzyIMhquRdkxiqH+o3ieG1y9TRWcEVEyKxmv6V8G/QXrp8FoL9JOS11bl0tfqBrejFULLzzyaKmdvA7IsgiEq+iiyzM67U0j4L1+aKO8KkfGfMSlmpKti4fvcs7cMJ05iJ5StQoix8hbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpscOJmEGyLC3z1AYhPj6KBhdDp26eXJXwQyeIaQjDw=;
 b=iYFstmOBln2kiS9HmcbzvPOOn270MTZ/0/Mlutn1tPkQ+AQeC6B+xpDUgLtUSDKamO9nVhuEbOytR+m4J+KKVaL1cCAJgwRU3/avjSmJ9csN11qxt9FKG0AChvjpwqL7iW9yiK5YUxQUNDhFIdCEl0NY2IpCCMvwv8iCQ6P/KWJnrtTopbE6w9NLVm4mWiXxWY8jq8ZYnVs1xXh9pozwlxjLW+KJMzxHfsmizVDl8Ywtt/dpp9hZHveWsJHq11LP0XoqxbPOFBY+2b36o9RUhtVx7lecBZxcilV/BI5ZGo6amtUjARmKbgH8Ff5YT+wb+Ea/Dsx8mG2Rug8IvZT9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpscOJmEGyLC3z1AYhPj6KBhdDp26eXJXwQyeIaQjDw=;
 b=PGyZSqOmWf1+6nmvF1P54+eDTkQp5KJ+e/yIJKLoBpDuHrP2D4mKaT+r9DRScRVWOhJOetbqdYXhJwPntm3iuyGRrTnZVA8mvnx5hDj17zZrqcakGaaiSDAzok1HTqwWxB/HIQlf1futAWzguCrka1wEZnqOg6BmP0egVHwt2PI=
Received: from CH5P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::14)
 by BN5PR12MB9538.namprd12.prod.outlook.com (2603:10b6:408:2ac::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 18:36:07 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::6e) by CH5P222CA0013.outlook.office365.com
 (2603:10b6:610:1ee::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 18:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 18:36:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 8 Feb
 2026 12:36:06 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Feb
 2026 12:36:05 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 8 Feb 2026 12:36:03 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, "Tom
 Rini" <trini@konsulko.com>
Subject: [PATCH v2] mtd: spi-nor: Add support for flash reset
Date: Mon, 9 Feb 2026 00:05:41 +0530
Message-ID: <20260208183556.695948-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|BN5PR12MB9538:EE_
X-MS-Office365-Filtering-Correlation-Id: aaecb875-28b0-4431-1dde-08de6740ec54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j84pISshweJM6Pt6AyT9zkZyAn2OrY3a3fuHJ+rRDHMXhxtKFxvtG35dR0Yi?=
 =?us-ascii?Q?isOTVMHSRRWpe8fyNkErMEG/7GcJ7WxONxUj8GlvEqjvfWy6qvQzQKe3XZYC?=
 =?us-ascii?Q?Nv9/gvtqFZhs66mmYfSCDp0G03+PA23D0bpeJ+1Xz8RycLFPIuYnN5OU8gDd?=
 =?us-ascii?Q?UcjmUQNY2VAmTd4qqGmJtZdKRxhAXVwK/n11FWNj5k/1MCnLDGWM+MhdVTfj?=
 =?us-ascii?Q?VoAeQPfRuqrQlIMQRkaRXeFImpcheKDXJNGHMZ5Y1j1l7xcXbDPyd2moMh6v?=
 =?us-ascii?Q?Oy05Okx1FfptzRab7P8RS2JOM654X5u0KYmpFgt5MzjVZqDnOk2cCjbBwobY?=
 =?us-ascii?Q?yxLTzxsswephiA5VcgFXi7mdZYnlytZHq+VKm1XPul8zx+GFFtcs+x3G0aC7?=
 =?us-ascii?Q?rO5zPi/tKBPG23ZzU2hVQO3WVRH4CcxWpA5H3PPetkGGhOaJN5HLD9cFn+J1?=
 =?us-ascii?Q?9FuEHMpBijmZ7OUx0B3kI03wXpz0kqsbaRQ6ihMSktlgQwg++aeGASMZjYaj?=
 =?us-ascii?Q?pbi68SWrTKmq7EBD5AyF9+YpX0LHaMVDwHfkp5IqFj5btRHW+tDKlXbYDQG/?=
 =?us-ascii?Q?MPYG5cHb7JfKh8rqmhVoG8ekmo8lKdUuQLEaoqFtBME0mBT6/uSX4F3fl5aT?=
 =?us-ascii?Q?l0RlYEaz2lCTrEMISqxVij44hIo8FhsdCPU5PCIq12b0idwJW7oDOOLSUV93?=
 =?us-ascii?Q?1yTMCVvdbt7zWIfPE/xeTdlIw3knPvE+sRzF8sV+z2fpdRT7t9BiiU8tfcB2?=
 =?us-ascii?Q?pVe4GXVbOtRBvucQdJIN05hNP8uU2lwMCT5r3WScFDWmDPOm6sAqsN+S38XF?=
 =?us-ascii?Q?HkInFCtyOTbF6mtnZP6czfvkpYZzbENmQ7fS/qo17sjE3QweaKZ6MoV0u5l5?=
 =?us-ascii?Q?wUyst8zbNNuxq9CqdxTgNqnvme556IrpiDEnSXbdG0oBlG9Wvf7usbKnLWIO?=
 =?us-ascii?Q?RHtOzIyw12SYuByXvQtF45/PxVuLo1P24rNVF5DbpVBprsi4ozyvIuHSUYUW?=
 =?us-ascii?Q?02sedSAFoJl4tvOVZ6V62hPuJ40uWQGjsYE+0bBzPr+CdOLLLLGfp2q2jNR7?=
 =?us-ascii?Q?bxeBbi9eVvJPOajGkBkwVkJsKxzKh8kGSuQfdmBe1Eryy2J21QmxxTSisymy?=
 =?us-ascii?Q?rdzbYay9m9IQvatUPIUghZgisRboOYXIahLqW3DG4qGI0JgZud2q2SgH90uF?=
 =?us-ascii?Q?dtyw05vVDwqewwwRdjEpiXfrgdN20eSkF7KgQ8/JDWN9op6iGamfeJOvLloC?=
 =?us-ascii?Q?TNPts0x8m817rHte7vnjZFmXkRjn4buIUne9xIRlQNWtIuKNRll+GgNMbSSA?=
 =?us-ascii?Q?61ghHvwwLhx+d45w6fbRIz41ApuKOv6yUTyIFdzH6MFf9MWEm4yGi7vQQbpX?=
 =?us-ascii?Q?/Bx759W0Pf/pZZ6JWEhLtxzCgqG96k5yL8s1OxVXaB+mLBjD+XBXHmZtgGi+?=
 =?us-ascii?Q?o/WlVVmIplNBvW4n2jCFUd897TTELWe+12mf3AM4wi8UM8wS8jMQ6MgpY3JJ?=
 =?us-ascii?Q?0gDwfOBbzxrSakA8e+qKJ6PJDXL1VavSzsOMbRqL2zo7bYjsEIO7fH37IgT8?=
 =?us-ascii?Q?DNmXGDjBnU+OKhsk7N/cZVy7q9nF0CxVrvpsAH3ejKSpeJNLULzfGXL15WSW?=
 =?us-ascii?Q?EH725HEatN1wG6KndButYI90Kxv0D7S0Ht10EpH/7OJLKDKlvWDW6g+RU9J3?=
 =?us-ascii?Q?h+R86A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UlHNIHbVbJ6mNqbxQANwgJETsxO7YTRAMQBV2y5oOJla2IAZpDiZt58/QH63ECkulhnwjZkIsP4mJBG0zz+px+0laM09BLBA4ygx7C5ypcO0qG7x/qGZPFo/IUqkpZDz+zh8K5+gOP9GStiLlsvyT8mWQcG0u+fA7b/IsoPz1dtPjhTmFRQQe/ev5plmhgLH/I18JfD0D+H3pweoIz0gZyCRrJ9zmYWYhZaLvjsUiIfLSM9oYZZKTTK2L3d31tSb6A/J/AD02MBxiMUA2Kolx6DnYbWjpUy4k2WSDgIGCmwBCKc9K/UMnR131b27gmezuV11701jvLZwYbOKKAJadgaCVHzlyDvudl/eQe3xFBVVSNHwedIQsSdakiMN7WdunwGrraCAKZETHD6lngzv1KeC6OUev1G6yaoY92gA0l1EJuiHIR40b1ywKx56yYcn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:36:07.3156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaecb875-28b0-4431-1dde-08de6740ec54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9538
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

Add support for spi-nor flash reset via GPIO controller
by reading the reset-gpios property.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
Change in v2:
-Add missing gpio header in the patch
---
 drivers/mtd/spi/spi-nor-core.c | 41 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h    |  1 +
 2 files changed, 42 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 76c33b24368..e3de667214b 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -12,6 +12,7 @@
 #include <display_options.h>
 #include <log.h>
 #include <watchdog.h>
+#include <asm-generic/gpio.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
@@ -4466,6 +4467,40 @@ void spi_nor_set_fixups(struct spi_nor *nor)
 #endif /* SPI_FLASH_MACRONIX */
 }
 
+static int spi_nor_hw_reset(struct spi_nor *nor)
+{
+#if CONFIG_IS_ENABLED(DM_GPIO)
+	struct udevice *dev = nor->spi->dev;
+	int rc;
+
+	nor->flash_gpio_reset = devm_gpiod_get_optional(dev, "reset",
+							GPIOD_IS_OUT |
+							GPIOD_ACTIVE_LOW);
+
+	if (nor->flash_gpio_reset) {
+		/*
+		 * Experimental delay values by looking at different flash device
+		 * vendors datasheets.
+		 */
+		udelay(5);
+
+		/* Toggle gpio to reset the flash device. */
+		rc = dm_gpio_set_value(nor->flash_gpio_reset, 1);
+		if (rc)
+			return rc;
+
+		udelay(150);
+
+		rc = dm_gpio_set_value(nor->flash_gpio_reset, 0);
+		if (rc)
+			return rc;
+
+		udelay(1200);
+	}
+#endif
+	return 0;
+}
+
 int spi_nor_scan(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter params;
@@ -4491,6 +4526,12 @@ int spi_nor_scan(struct spi_nor *nor)
 
 	nor->setup = spi_nor_default_setup;
 
+	if (CONFIG_IS_ENABLED(DM_GPIO)) {
+		ret = spi_nor_hw_reset(nor);
+		if (ret)
+			return ret;
+	}
+
 #ifdef CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT
 	/*
 	 * When the flash is handed to us in a stateful mode like 8D-8D-8D, it
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 4eef4ab0488..8017d0dd9db 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -583,6 +583,7 @@ struct spi_nor {
 	u8			cmd_buf[SPI_NOR_MAX_CMD_SIZE];
 	enum spi_nor_cmd_ext	cmd_ext_type;
 	struct spi_nor_fixups	*fixups;
+	struct gpio_desc	*flash_gpio_reset;
 
 	int (*setup)(struct spi_nor *nor, const struct flash_info *info,
 		     const struct spi_nor_flash_parameter *params);
-- 
2.34.1

