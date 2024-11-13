Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC9DD41C1D
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 09:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5C85894AB;
	Wed, 13 Nov 2024 10:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kd8mSt9q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0B62894F3; Wed, 13 Nov 2024 10:11:51 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B756890FD
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 10:11:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e11YGCAHT0ryYrRFbAdCJY6tE3m4cEmVLHXIuQsi9qUj/BGvua9+TMU2vLdtmSJbEosrw7Rh69xIyEpmiowiv3DF5UyVDAxFHAJGNXG4WzVKdSSC2K6RYx5oRw3C0Q2ROFbBDsGM6VYrez+hov68R7zUr8PvapUk35UcSh5Au/uUbhjbdZH6UCFppj+W36X4mZ+FnTeVYWIvrdv7ZrNdBNBecU3UaDgSvegAZX+rSpWEQgqwBT2mKRc4lbZqSA3ZKq6EfOZusW+XTslhWql0RbKFJIYJjz8K8t0dffQYsdPgko1czP7RHh06mWBlM9vXZTCSp/XcnJxWR7MimLiJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuNEw7BZ/9K8fCT4M1VME1/v6H0L1pkGHNquEqB742Q=;
 b=u2098vW1mZY+fK42uUlKvFhnihay0lmx5nab1mLqIokGxnNytTfZZaA6VqqAlBlwLDrVLhbjsbWY2Fginysw1aENmbh7VsHjFsaSl/V6I6qIcdrNHEwOxzkZECXwsacP2KiqVmxmqVxxihU7j658A6bGurCj0OrJ/m5SWtuNNcGADhaFeukHLXcraqBbBVYrBw+k4DaT+qrLvfHaqJFSJMwGNdndf+9nBbHHiRLKy0gmYuFOsMpv0MmB6JAuqXwJaiJw5xJz0UMdKIP+qyeRLZV+F0ayR5+CF1o3z3dcyoO8uIHpaAYmAIuFpVNniDOCws4FI3avLrJiQQKPNrcCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuNEw7BZ/9K8fCT4M1VME1/v6H0L1pkGHNquEqB742Q=;
 b=kd8mSt9qoCk0vNwAPeTrv5ifWCtxrC89jsiZ/gG+WIRIL6yDq0i/GGnMghKuMcG5GQKp9cui2qRvngZkY+NB3eeSKwWaXeOQ4nWITNm4HGKCeDGTIy/KAbkdJV3etqlgr66zJpJ6g7jneX6s4lRfjzTedWY3UslQ5uXO0qoCEIw=
Received: from BYAPR07CA0100.namprd07.prod.outlook.com (2603:10b6:a03:12b::41)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 09:11:45 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::de) by BYAPR07CA0100.outlook.office365.com
 (2603:10b6:a03:12b::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 09:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 09:11:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 03:11:42 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 13 Nov 2024 03:11:39 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <git@amd.com>
Subject: [PATCH v2] mtd: spi-nor: Add support for flash reset
Date: Wed, 13 Nov 2024 14:41:32 +0530
Message-ID: <20241113091132.28272-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d83ba66-0818-4632-3f8c-08dd03c331f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wrg02XK5jmpIOmp6g1mmwhyUMHalaWLjd9i04763qOELvUBK4n71PEvH7z+X?=
 =?us-ascii?Q?EXp4mRwEpmjBSyz0XKeNkzLIoXc+hvT0Ri+B3K74U4T1ZDManvAk/pmt5evy?=
 =?us-ascii?Q?/7eGz5E5oCi1aFbfKxLqB5/dchn1G1ul2GO/bQvHUg1loyBGsp0jhrSxTvlw?=
 =?us-ascii?Q?evTzPd443vy8fZ2UWcZKpIC4quakkRt2Xb0Yal5zJCqZ8whlL/oIwOXbLVXj?=
 =?us-ascii?Q?56xc9DiwuKCZSGlaTyGNfnQYgge+qGW1iPKqP0M4yBZ82aU/ZamYCboShFWs?=
 =?us-ascii?Q?mhNsflh8ks2tpHjuxPScyMR7+4YjNVqIIep7vsJrbpx1xtE3LmhD9LOcGdVx?=
 =?us-ascii?Q?M4gqCc5WV5MbkRLqlqXzZj49gpkjzSJ1hWmbsIstSDdEOZiN3IpZPUchq1xB?=
 =?us-ascii?Q?DffIS4SE2/NIELSl/njCEvaN/J4dZ4dS78qR5EVuSRq1x7DkX0l9Rriqbwyp?=
 =?us-ascii?Q?jpD4ydW2xQsUIZzvzHTLgCNJYrKsVBMHVBZyUs50ABDxDf4ptxyCGup+4Dtz?=
 =?us-ascii?Q?6WRaZ65o3LTlARBW/ScBj776ydEBSQX/VFks/7ZrDQsA02HCzORuD3DkxGKm?=
 =?us-ascii?Q?NS8Jn51y3HwZun+iNfBMJ+12F/HL+Ku5RdSWom5TkHrdlefS9oR9ObczjHKQ?=
 =?us-ascii?Q?hTq5ty1Ro6YTq5wVIFZZTvV2lSBfPObAKLkgVBE0Id5Oipdnc7PhStgJn2I7?=
 =?us-ascii?Q?JKFjV7762pNlK/qElOEby9wLa95LZhlFfazRK51W+m8P+Pr8sImVspCEo2Vz?=
 =?us-ascii?Q?r0E4kBY2dwKW6tuLNKgzpZDbjBUEaRwHcxtFsKLpZ5bCK62BtfLQ4hK/am89?=
 =?us-ascii?Q?zoRci5worcssjFM2OUzgL0eeEtCOABCOcrIxOlris0U5iasGQGAclv+Yp8xK?=
 =?us-ascii?Q?Z1F2mHUD/46svkvS+JMX75kp5fNm26xHRaGIV+e2xgvLD0PqVB9uZhXgpdMD?=
 =?us-ascii?Q?WHpbUBEtuJX4qEMsH9xj5TvtxAitwS0SDIAk8067OiqFRqfvvA3SD15gp6aL?=
 =?us-ascii?Q?vF8IbFwU0EDWK1pQSg3pfLgiy2XwFJG6sthPmONy6C009lbs/R+ViKLJTAMb?=
 =?us-ascii?Q?cisYsiPowsMA21LJzdkW3i/xd5i5AB2LAZBDxM80QV6AFK7dffS+bQO5lmzI?=
 =?us-ascii?Q?NI0pth51PBgaVoF5nX/eG0lLmfSSjAJM0fktTlJKq6WVTep5dKmTpkVV9jby?=
 =?us-ascii?Q?JCqWg3LvhTCm1V/s09aZ72jgktzXWUgvE1p6F0oIjVJIGjC6SzXg0eNB0Hiq?=
 =?us-ascii?Q?Iqy3fMqWQXWBvTy/Xh2jgZt/CERsgUuUHycVqJjjmcwOrYMveRY0zP0FUlfx?=
 =?us-ascii?Q?VohpKJc9TR7l2EQhxU60qKEgh99dF5uyx+XRQ5/YKVE9ZiKtDGlEyGOX/Cpu?=
 =?us-ascii?Q?adFEVFkTchBS4rNTjlH6QRuXo08cf2W3z7CEVp/w1LCNqFokQA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 09:11:44.5953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d83ba66-0818-4632-3f8c-08dd03c331f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452
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

[Ported from Linux kernel commit
8f1ee9ef71d0 ("mtd: spi-nor: Add support for flash reset") ]

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Removed the code from spi_nor_remove() as gpio descriptor is
managed by DEVRES.
---
 drivers/mtd/spi/spi-nor-core.c | 38 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h    |  1 +
 2 files changed, 39 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ec841fb13b..93a7d046c0 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -12,6 +12,7 @@
 #include <display_options.h>
 #include <log.h>
 #include <watchdog.h>
+#include <asm/gpio.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
@@ -4415,6 +4416,37 @@ void spi_nor_set_fixups(struct spi_nor *nor)
 #endif /* SPI_FLASH_MACRONIX */
 }
 
+static int spi_nor_hw_reset(struct spi_nor *nor)
+{
+	struct udevice *dev = nor->spi->dev;
+	int rc;
+
+	nor->flash_gpio_reset = devm_gpiod_get_optional(dev, "reset",
+							GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
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
+	return 0;
+}
+
 int spi_nor_scan(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter params;
@@ -4440,6 +4472,12 @@ int spi_nor_scan(struct spi_nor *nor)
 
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
index b8b207f7b5..eb2e9c90b2 100644
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
2.17.1

