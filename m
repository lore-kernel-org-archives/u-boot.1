Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3946BC3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 13:15:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40438829EF;
	Thu,  8 May 2025 15:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="HF8/doW4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDA24829CD; Thu,  8 May 2025 15:15:01 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2072b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::72b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA7CA8212F
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 15:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hO21Sp6bBo8unoAxWDgLFoOVdmm5I9+17Rz0q7gZib6LvKBp5nXLMk7haMfwvRwllE2G54Hypr1K8AUBz04apabrFZT+TRiCKlhnHFW2z8BjzPr2uZJ6Ri7C9AxVPbRu95WJXL403F3NPbuHk042iN6O+pj4zkBF6bPToJDrnb85tYUQUPJ15q1Qtxm48Jd3SZH+jkXiCBi/xa8+enkO6dPjoK6pYF95V1s1ZenNVqoPYXlS7vvZ+wueAFzr/3QTeMCLdj2cj4pAYE8eazpoiWJtiTOLd8+wKQrASL4FEia0Gwj0NvO0SAI2BNC9EGRDTNas2hC8K6tgNkKPDILJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqjnaTEEA2Kr/9GP9z+yagrpX26QdQm2tjhmtwAyghE=;
 b=rOC/KiVeSVI32FMDFrnWCDFp+bRrxJ+4oOcweDG2tFT7gZVCgY1fwrUVZg8mfyMwM2GmQ4kthtjIg8gvI9zVBldudx9aTUuaMn0HJnxeIolTnr4wtx1l491LUz7tL31Ybe3D3DIlpGvfDJE/xi0t/R3qKmMOtRiOwlpERg3L94XO/7xkwDs8N+wbcdm0q/KhoJ2mm7mabT6WhjqAS1s7kBrJEBkBPNdI3mTUbGb+NFcrWpClPh2Wugiwlf+4jZAXNnZnz4KAH/ro/M6CDwdw/sujYjcy4ADJPWW6qefuXb1Wi5hj8Ep1fhOsscEXtfKfP8zxxYMxwdI2RVHnl24Wog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqjnaTEEA2Kr/9GP9z+yagrpX26QdQm2tjhmtwAyghE=;
 b=HF8/doW41cZkLnZ9hgITFqmr/x8sM5tXSiV2BLwv8/sk4JUaG6H+qdu+BAoZA1hfXQjYmUtu6jIQeeIdiVbpEeZVho+MUgr5TLh5jS6AdbEOZWTS5NOm7CB6MIGKHEjeL7QWBSzHHfb5dfJkkOnK20Y1SUDG4TPLPWaNGteY2nLpX5MD/OVTvmgNMEyD0jsZnRyIsnA09u9PU/NnuCGrOkidh9NnMhVMASHYOKwcEoAj0LzGOpJDTZq/559C199Y+S2wSGOePm0CVLD6kmC0xbXzL5lDUZao+WU2x8G/8y2gmG2RtOPg3Nm44MhDtQjf6PSllW4bHbT6XE1DfcYKWw==
Received: from AS4P189CA0007.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::18)
 by DU0P195MB1796.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 8 May
 2025 13:14:55 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::b7) by AS4P189CA0007.outlook.office365.com
 (2603:10a6:20b:5d7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Thu,
 8 May 2025 13:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70E.mail.protection.outlook.com (10.167.16.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 13:14:55 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 15:14:53 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 15:14:53 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <tudor.ambarus@linaro.org>, <joe.hershberger@ni.com>, <sjg@chromium.org>,
 <d.schultz@phytec.de>
Subject: [PATCH 2/2] mtd: bootdev: Add Kconfig option for defining script
 parameters
Date: Thu, 8 May 2025 15:14:45 +0200
Message-ID: <20250508131445.2557222-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508131445.2557222-1-w.egorov@phytec.de>
References: <20250508131445.2557222-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70E:EE_|DU0P195MB1796:EE_
X-MS-Office365-Filtering-Correlation-Id: c98c5c91-a24c-47db-0f5b-08dd8e325338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+nqv24XWzcuUzQBkp0F6A9vlKpL4DuUimysRI2o58ttfBSYJfPBzRfkMWwSR?=
 =?us-ascii?Q?cTlTXQishqIDZOKti80vmYww9BBIaTD638lwa0i5lqa9VU8ZI4fcgT5OnZis?=
 =?us-ascii?Q?r4ZZbYVjL2ML2FpM2xz0gIhX5Vd6RSMKJlO4ONeVU6/h/nwi+FHAeJn2sAAQ?=
 =?us-ascii?Q?Ctjy+9igByKr5aVimBVchPRQf3etqpfkk+dII1qjpw15LZahaAF19GiPoD5g?=
 =?us-ascii?Q?Anfnyw/K+DvxpAV11fIJrGTKluX45laiImc0n7eo3/rBxsJHtO+mIFDCXAmN?=
 =?us-ascii?Q?uaw6LLbDeO34rmpFczCT/APP11Yr8a0VJBNS+Z0NE5+1g6v9eM6dA/PGEeGH?=
 =?us-ascii?Q?35l2jFwVDvGPHk5LpGjJDBDKNGI+cWOCftbP8+ZJCSRLpoBdrkeWqVI+sB3k?=
 =?us-ascii?Q?icXxw6ftMpuEdKv/8CvAnatdMD0uUUsWUNx+BqTBMp000Xlph4q2XFh7BIVO?=
 =?us-ascii?Q?ybgkyKCjYbGbEKnoWwDKHC4HqzfR7620S/t3CdmeLn6fAzR4uJIim/f5CN5R?=
 =?us-ascii?Q?8pmYV7kPuShTrCggJNxXf/dOw39cDDmRG9wK5RVAsl93tm35Ms7nejRL+zhY?=
 =?us-ascii?Q?TRPUYOQrHe0NI1cGhFjT1n//ViAxBxbS9u3Dh8+3x7RuRQXgkrg6QA1tOqdR?=
 =?us-ascii?Q?CYMSxvp+SwdIqoQDq2cve/db+TX2rg/s56m1VnwdhAaWMjRo1tbfV0m8jkpp?=
 =?us-ascii?Q?qpgqTdi5EZKVIlx6yHvWUf3neicIqrrpVW4coxKLK6ZJ66sFUWz3tAjufVHC?=
 =?us-ascii?Q?/hptlTeRPcmhMuDM4uzMCC75KBYH6id8GvLIF0Sl0YXKQ9ifyDX1qzKDj4GZ?=
 =?us-ascii?Q?zpDcZP9QJaZ2vOCN5yLFFRK7zuDNylWtPPAxdBYWu+24tEYTPmzXqyNhRF5J?=
 =?us-ascii?Q?6mgw7XXDOWlJIhzJ46x0IT5id6DlyxYvwguAqRZ6mU9rpJMTv+zjiuVH+RJb?=
 =?us-ascii?Q?AIYs6qoHbP20TgK0hvRFOTD09FeOlvzEeuJjx1ttU0CfkCJf1V5T+F7tRbtK?=
 =?us-ascii?Q?s6o8NLoHF5Zdd92XLPyBjxhXIemaJmUwrmTgM9dhAe5N/iJ/YCTPMdpZJMeQ?=
 =?us-ascii?Q?lr7Dq5SJ6ZFXWtm+wA9rpTIjJWMlUylFRQEClBLdAuOzRGJJR2Mhdv9vYoWX?=
 =?us-ascii?Q?Zv9vt8ZN4Zi5Ytw9YYLhZqkf6M4tgQDEqcY3LpwRdEt+Df1WaBbfAStBNNco?=
 =?us-ascii?Q?5fnoGKSLaxf7BgW7NE4NUi3suLJHsvzFQgfbdYrxwSD5oGGtYaVivq1RlKMi?=
 =?us-ascii?Q?xQPY0r152FBX2zTZVNpdect5I/VVq0xMAguiJ+fI7AMT6kPtnT9/j02l3cfu?=
 =?us-ascii?Q?2qyVrxVns/fq0w8cWSONx6Rv5LpUQxYXxSwvU0TcI6HaSIXrWD3SG9mJ2b1p?=
 =?us-ascii?Q?oqHDhacD80vcsYSf4U7dr5tnxHeAtyRbP8l/A3EG2I65cRi4WQQXh5TrxaG3?=
 =?us-ascii?Q?wFu1DMpd7pjw2UduSsUBqMAxEusUHGY3obbzcAn4uJj0zc2HvosSlAOC5f4+?=
 =?us-ascii?Q?An9pWqmYlBOaM8jjXnSbNzfy7O1UfBMnKrU8?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 13:14:55.1694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c98c5c91-a24c-47db-0f5b-08dd8e325338
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1796
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

Introduce USE_SPI_FLASH_SCRIPT Kconfig option to enable setting default
environment values for loading boot scripts from SPI flash. When enabled,
SPI_FLASH_SCRIPT_OFFSET and SPI_FLASH_SCRIPT_SIZE define the default
script_offset_f and script_size_f variables.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 drivers/mtd/spi/Kconfig | 26 ++++++++++++++++++++++++++
 include/env_default.h   |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
index ca60a425ba3..fc154ec89d7 100644
--- a/drivers/mtd/spi/Kconfig
+++ b/drivers/mtd/spi/Kconfig
@@ -89,6 +89,32 @@ config BOOTDEV_SPI_FLASH
 
 	  If unsure, say N
 
+config USE_SPI_FLASH_SCRIPT
+	bool "Enable default SPI flash script parameters"
+	depends on BOOTDEV_SPI_FLASH
+	help
+	  Enable this option to provide default values for SPI flash script loading.
+	  These values will be assigned to the 'script_offset_f' and 'script_size_f'
+	  environment variables at boot time if not already defined in the environment.
+
+	  If unsure, say N.
+
+config SPI_FLASH_SCRIPT_OFFSET
+	hex "Offset for SPI flash script (script_offset_f)"
+	depends on USE_SPI_FLASH_SCRIPT
+	help
+	  This option sets the default value for the 'script_offset_f' environment
+	  variable. It specifies the offset (in bytes) in SPI flash from which
+	  the boot script should be loaded.
+
+config SPI_FLASH_SCRIPT_SIZE
+	hex "Size of SPI flash script (script_size_f)"
+	depends on USE_SPI_FLASH_SCRIPT
+	help
+	  This option sets the default value for the 'script_size_f' environment
+	  variable. It specifies the number of bytes to read from SPI flash to
+	  load the boot script.
+
 config SPI_FLASH_SFDP_SUPPORT
 	bool "SFDP table parsing support for SPI NOR flashes"
 	depends on !SPI_FLASH_BAR
diff --git a/include/env_default.h b/include/env_default.h
index c72cf123004..9f2f222519d 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -127,6 +127,10 @@ const char default_environment[] = {
 #ifdef CONFIG_BOOTSCRIPT_DHCP
 	"boot_script_dhcp="	CONFIG_BOOTSCRIPT_DHCP	"\0"
 #endif
+#ifdef USE_SPI_FLASH_SCRIPT
+	"script_offset_f="	__stringify(CONFIG_SPI_FLASH_SCRIPT_OFFSET)"\0"
+	"script_size_f="	__stringify(CONFIG_SPI_FLASH_SCRIPT_SIZE)"\0"
+#endif
 #ifdef CONFIG_EXTRA_ENV_TEXT
 	/* This is created in the Makefile */
 	CONFIG_EXTRA_ENV_TEXT
-- 
2.34.1

