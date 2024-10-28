Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4028FD13570
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 07:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F71A8905F;
	Mon, 28 Oct 2024 08:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xNOMYK7q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC47088FD9; Mon, 28 Oct 2024 08:03:55 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9577A8906D
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 08:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yS73bmTRTB6n26ZdFNNfDTGyXNcCZYQdAGSU86O9JsBvnzQdMXGXqen3zQ/35oS9X6tknEBLyDUlXMvjRlPa1zsVwea3fN8Z0QobaaCoigrEwC0AKHWl7berOOf7F8W6GGTk7eCJ4iUP45ido+2BM1hCtOEWf8rMm122i3lybv1anUVxT/Rz2cMD9jFctBeyTlJB2LRI2e/EQXFi00hQSUyXKnvw5tWKnjBNU2/MTa60kO0DAvLTK6JcZtrcRvmRCpn5E30VCfh4wT9gn7zp3NZR9sTHBiyBGh9hIw22ob/kLRxmd8QmZE0Im75I12aVgI8b5jZsm5RK7m4INze+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RW5Gg7z5zWKW/hbQHUe3D/oR0/Hf40Rs4mCaw07IEgM=;
 b=LMGsV+Z1T3htLSAqEDyMQx0WVeEQp678usQUGJ9JuMaIjRXX4oqBLOR2z1o6gtZU3KjoWjxmw7AGU9IMdpo1PoFq/1kBndzWT6AMqFKZh12wKYBZq5GEdYogIQ4xKVNEyEkJWC1BjWhI1Xi1lx+OxlJdRipk9pZ00Sd0aew7kidxjt1BlmT21xJCHzVRYkTEvoFBrnHvcjkH39XszBqzD1ML+2wY9WFuDjJWOGfRRU5+g6b8zb64OyrOwG1xUIS7KIJ6UmFqWDz27v6mySRg1kz7AYR6sp1UZjODnfUMPl3qHvih7V/KcXdeEEl29NLw0JXzpbNd+SCeCR7TWT0cIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RW5Gg7z5zWKW/hbQHUe3D/oR0/Hf40Rs4mCaw07IEgM=;
 b=xNOMYK7q5MEZRRKeFv3TAGyaxEQ7+E9I0l7fmdU293f+TIkWIL4gWLfTxjJ4Fujlu/seMgrLJQ24EXxe72Jrc72s16yFOCe3H/d2EqKkFveb+NUQU4NGzy/1EPyUbd2v9DoFsZM4eBpERSMkGTFY63M5ycr+Ad10TFGkkr5qzjg=
Received: from MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::9) by
 CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.27; Mon, 28 Oct 2024 07:03:47 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::b1) by MW4P223CA0004.outlook.office365.com
 (2603:10b6:303:80::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 07:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 28 Oct 2024 07:03:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 02:03:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 02:03:34 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Oct 2024 02:03:32 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <p.yadav@ti.com>, <trini@konsulko.com>, <tudor.ambarus@linaro.org>,
 <marex@denx.de>, <sjg@chromium.org>, <git@amd.com>
Subject: [PATCH] mtd: spi-nor: Add support for flash reset
Date: Mon, 28 Oct 2024 12:33:25 +0530
Message-ID: <20241028070325.17666-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|CY5PR12MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e756f1-9416-44e2-aee8-08dcf71eaafc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nB4QvJbeyZkZPoW4jp7ILsC39KCHFA5eClAjB9WiA1FCUgZ+Im+YMs55OoNM?=
 =?us-ascii?Q?4apv3ktUOr2yK9/YHuYiB7meWGMqY32GY9QBSBWKTNI51ZQmwieWz15TW8vN?=
 =?us-ascii?Q?uErKtJZKNM+o85kvOgzeFndEChGqzI035/8N/P1wtGJ/QFikAcwFS7wOGBqV?=
 =?us-ascii?Q?7M/WWz5pZIWQ1xMGieapFpfKwMPt4NjQN76DJXzsy/XvdMpzJ2uV/VfPMqFX?=
 =?us-ascii?Q?21D7aPRj36oonJg2yNLamo5AaH4oczDIY+RY8yH3rrKqpeJAE8Q49X69gJGw?=
 =?us-ascii?Q?lqhq/yDTXaId1tArBnD22BsqzifWi+1BBqSgaMMATn0261vl+7lE4bzNJI/1?=
 =?us-ascii?Q?+zYnvbuO1N7bWdJVwJsYqmTukkjuK6wGZwhHL+aicA4doycuB/hUSRqzUGbi?=
 =?us-ascii?Q?mGbsp1eZz08YhIMh5+vkB5r5JwtB2XU4JBZpK21xt8ZE7xjib515QahD0SrD?=
 =?us-ascii?Q?66KzyADbxGZji4qUK2sFP9QrO8c2XYbDc40MFHW/WUT4zDiaRI9DahLmezl8?=
 =?us-ascii?Q?x72i+oKcjALN/1CzZ26pOs2RM1U5cbmN93NVfarbrWlITJ+0mc2il5Bvj3ze?=
 =?us-ascii?Q?wgo9eUtdA+Yzm9L31epekon25ov3W74wtmY3fVQriwm2A2fb8ACXlkpwKKmT?=
 =?us-ascii?Q?mtt9Np2oWXbLWGHSFxSx4OmvXBwzSDrKAppzTD1pPUVM8DO4J5lJq+t2MxKt?=
 =?us-ascii?Q?/DlwBK/WQnmjcX0tzcawYrVVcqIm34bKfQNvzHhoDUPXF70Wg/c6cdR0BcE4?=
 =?us-ascii?Q?gGku/n3zu5JwgyPFu29pgMBltSHr02b+CrSf74nkGyJkJ0RPsekXatZB1Djl?=
 =?us-ascii?Q?7WMwqwwNJQv2G17JqblOszdgsHjEJ+bv5syDEKP/TNGvw0bxLSsEGmv5S40l?=
 =?us-ascii?Q?kLJdb4N/NQ1xw4ZIPoYRmGEm+vSXav8huK6K0yOEDziyOd4/XsaEF6D4yvGc?=
 =?us-ascii?Q?Xu4rUQXvFmmmFuBUiMrTWtGMTHa2qNCwy8Ibqfo9q7ucHP3poDw/zD630pJu?=
 =?us-ascii?Q?qZvxfqFT4BVxg2QFKmPtekFxpLPW9T6f1eNy2matKqll5W6tWsjiBMU33Mdd?=
 =?us-ascii?Q?curC9CF79lS7WFkDW3lHuAWZBro0EUxpUWdhN9KCLWPzBOTtyASI/ABJH41Y?=
 =?us-ascii?Q?V8fdZxzkfKJZ17Ijc3QTApl98YlAupeU8w5CdUVlleWBd4alxuLMNO0TXfsl?=
 =?us-ascii?Q?pPPAYY9oif9bN31ScUdwxZ7CzENy4CquNdV8dksBFTJzrEjIYmtPuUwnrUKv?=
 =?us-ascii?Q?DgNx5AUvVHfyPaxaqK7uixuoK/7z9dvOF0SZrxR3qmPuYe/uU1smHgf98xoW?=
 =?us-ascii?Q?BuFt2ICF9JMQBYbum0n4Is1c0m84TcGu16mGKdUxoCBe5Jvuqic2JQQLrnNT?=
 =?us-ascii?Q?Exj7CB3dWyPSnGHxaEMUhUbHlO4jmKkmjcVwFIglMXCJ0WxH0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 07:03:46.7971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e756f1-9416-44e2-aee8-08dcf71eaafc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
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
 drivers/mtd/spi/spi-nor-core.c | 44 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h    |  1 +
 2 files changed, 45 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index f5c9868bbc..900f66b0e8 100644
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
@@ -4401,7 +4402,13 @@ int spi_nor_remove(struct spi_nor *nor)
 	    nor->flags & SNOR_F_SOFT_RESET)
 		return spi_nor_soft_reset(nor);
 #endif
+	if (CONFIG_IS_ENABLED(DM_GPIO)) {
+		if (nor->flash_gpio_reset) {
+			struct gpio_desc *flash_gpio_reset = nor->flash_gpio_reset;
 
+			dm_gpio_free(flash_gpio_reset->dev, flash_gpio_reset);
+		}
+	}
 	return 0;
 }
 
@@ -4448,6 +4455,37 @@ void spi_nor_set_fixups(struct spi_nor *nor)
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
@@ -4473,6 +4511,12 @@ int spi_nor_scan(struct spi_nor *nor)
 
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
index 655a6d197e..7c5337c636 100644
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

