Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F241C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 13:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 612C882977;
	Thu,  8 May 2025 15:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="H6RKAfJT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CA5482AB1; Thu,  8 May 2025 15:16:55 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::717])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73FEB82977
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 15:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOtlAXRWRLXLBwIJUpdbT7nG0wSPvUPtEMhJZJw69qFPDA+R4aiNgMcgCzh9Qi3LUARlO2ssYU6buhXo9ulPo800F0xn2SEEVHCRzsL2/nhg9ZrorfvH4GylOtVyWjIOoGDP4UR5iCtPRcZefUYNxN6W/Wa6nMWRRkOOLI0vmGMw9ad6DOjXP3ZDcfai4TKeGd++dwoPCLrse7oIMhTvb8++G/+HcRABQVOsiugF/LxGr1PNI5CvqtJwkL8Q8ZdI07+h2Is6EQeR5n/01Pa+IlDUkq05KVA15Fvnx2mbpDczxO+hcsGtqC3KnfxknPmnvcjCcHwXQOnjRVc679aHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqjnaTEEA2Kr/9GP9z+yagrpX26QdQm2tjhmtwAyghE=;
 b=y4KKkl37RDNp3JWzdQL83nEmOb82Z3MTYEH+RsswJOik5BoclAp1qUCY/1a3rk29A/ncScjNEsfY6+8biXqgpG60B67RwjuBNIOaZVK6jVgin1crcx42730ox0Ac8grU7FAt01686EuAa4dC/fbkXNj1SO7CcXG9GcjODAIjtGaE5emSJGqiV92OJ80L87K3vBW5gPhczND4Z7N/7h+5+SBFhjST+Ga91UvSLoUkQVE2/AQYgmGXu0lcreTbKRFJybjQi5qQadyy/uAo1Qouw2QLBJlT4yhMSy45QT0md88Nj411DlO8KWA/nvWzbDPdX1jiJ0v4XJLYsOgFlGZ9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqjnaTEEA2Kr/9GP9z+yagrpX26QdQm2tjhmtwAyghE=;
 b=H6RKAfJT8bAiHstCqxnjI/Vy2vQ83d+RB28w+S1q7rkEABP+mcK2bBDx/3m26CfgVT60c1tshRpkZYj/dRWTXkW1IPg0e3EPIOHfKlMFA1lzmAlEu4SH93b60zlNJJy1wBsD8ksgfxKNmSka4O57mcxxBOefv++hLHQ1Q8KzfrTGHlnPyXQCZFZ/sbcViKTOH2NTmOa8CCD69bbX9vt7f4ZFtfMHsc/x6+cjKcER7RMERG4PhPV2wzvdDD8/UUhcJueFbSazZaGLDpPCiJ1AZpDhkwflbmXf0BUITliCUr/yd1CyuW08ptw9kZnEhGO5xeB5cKWB/shPCkHVBSVBiA==
Received: from AS4P189CA0004.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::7)
 by GVXP195MB2031.EURP195.PROD.OUTLOOK.COM (2603:10a6:150::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Thu, 8 May 2025 13:16:49 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::d5) by AS4P189CA0004.outlook.office365.com
 (2603:10a6:20b:5d7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Thu,
 8 May 2025 13:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70E.mail.protection.outlook.com (10.167.16.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 13:16:49 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 15:16:48 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 15:16:48 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <tudor.ambarus@linaro.org>, <joe.hershberger@ni.com>, <sjg@chromium.org>,
 <d.schultz@phytec.de>
Subject: [PATCH 2/2] mtd: bootdev: Add Kconfig option for defining script
 parameters
Date: Thu, 8 May 2025 15:16:41 +0200
Message-ID: <20250508131641.2561876-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508131641.2561876-1-w.egorov@phytec.de>
References: <20250508131641.2561876-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70E:EE_|GVXP195MB2031:EE_
X-MS-Office365-Filtering-Correlation-Id: fb02896c-4f0a-468a-318d-08dd8e329775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FsEP5vQH+KL9VvmUhoMuYmvx85Itq0LOBTYYUE/ZdII09YzMS+aBgfbHR+4H?=
 =?us-ascii?Q?F5icyXrPCtkaGSDg2iWhiLbeq4/hA7+mEZR5gmrk7IVeVnmsQdkLZN/+1A1m?=
 =?us-ascii?Q?ibuIvaKS7nNT6VN6XD7Kop1xDKEC4UzQyM5AeHc5O4KzO3+dOOMOSGHMISCp?=
 =?us-ascii?Q?iud0uNn9xTn0WCCN+5J5TzRHUBQBeH5IPMcVbCeQuHOEaa3rMbqKAC33ySIq?=
 =?us-ascii?Q?pUVBK4Do8WkazA+mqdhGZJ6iuFfqO2YZ6AurfPc+dMoa8oqZZERABTZY/lYK?=
 =?us-ascii?Q?UPOPICsTFqS45oVqZ6Ay4pwH2Sr/6aPXgqADu3OqUrCfuVewi5Ho0P18Sl8T?=
 =?us-ascii?Q?ieUyiq4GSZF2oZJhfpfhsgxLKkR/HaV/J7S6n36WqLHeCyjNbTYhRsbYffGK?=
 =?us-ascii?Q?j3G5XF516vyuv0RDM5F+jikssWGYPKTRrDWkygpTjB6WF4ukIFwL6ADyMOdp?=
 =?us-ascii?Q?KtBtw/JoQ9KJSFn9tAsxUc2CIHG2T69tOh9glJfcs08TN7HsjrIVK7TOETUk?=
 =?us-ascii?Q?dOip6FQ4VAL8Yj6PnGF5LDiayA3HJoEukCHijMcyndPGlodhHR9G0Fc7vcye?=
 =?us-ascii?Q?igdSOphjXxBP4aQ/AxjHAZ2Av8B0PNGisQIzDJilgKIXUYYZnala9MF0LsX/?=
 =?us-ascii?Q?k6za6LhrQCEWGKsJfgOrELf0xErIp5M3Y2eYGbYNpvsixjJZAJCE5c2jnve2?=
 =?us-ascii?Q?asCvtiCnGDdG11l815oRfwjrW3JibwK39lsSUVXHrOjkkL1yDp/7UWvDw6Ef?=
 =?us-ascii?Q?LV5HEiMMRdG9cuvAmEzYPPkszYDKBHa/TFGGqglvDYhUcqMGyx66L0YbY8cz?=
 =?us-ascii?Q?UgMYGABhI4z0GBwIThhbBVBgo/YSpkT2j2Q5EKNyCcDqFh4giIcvxAFcYyqZ?=
 =?us-ascii?Q?TY+Oq7RMFdB92ESbNQw8piilrwg3AwXjiMVNNGTTGqFBvKTr4OykmhTksxDt?=
 =?us-ascii?Q?/EtQevTByYviw5CZ83z0qPTP+PY9khAKMjVp2FjVlU0iFVa4m9z0EMgY2GbQ?=
 =?us-ascii?Q?2/wuclpp3D9fypb3UtZwzqrlOl2LCMuikMIq0ItTYgGWtonrIhX9fpeFUQXa?=
 =?us-ascii?Q?FU3eb8cnshQnPSpgccoIhVSeI6qmka5G1Aw5xGJ/M+dErYcjTfctJxgEV3Lu?=
 =?us-ascii?Q?yHa2s7DfqX1AVnD7AMfn2H8YrfYA3+wR4ZcSEjkNvx9Q3+ghbp5dmJeG4KG0?=
 =?us-ascii?Q?Msmi3Uo6sLWXt1vhJCFIQ3Ops9UelUa+MqsdLMkJsbXbuSvU3osVpa3IbvCw?=
 =?us-ascii?Q?omR9g5a4FsWLo2eG144KXGi8Hq8GlG0pnQyROpAuHr2vI0Zm0riE/lIFk3IY?=
 =?us-ascii?Q?DVg/P1YJNFnGhqMCD9IV8GEA9cFVj7pt4aLV8WfgQS7H7VrHTXo4IyIBS+In?=
 =?us-ascii?Q?WAwJEsxn+6bXb/Ml1+DnzrYCRy34T0xRtUFHOas9k84H9HnE7xtlywXFyBcr?=
 =?us-ascii?Q?uwJfBdbOVd4BN3o+85NCNF1X71nTyHPKlrv8nV16diQRZagtrGAhpNxM3bjk?=
 =?us-ascii?Q?MMdlQi2GYkw0NXKfoe+fHrd+/fsDpVmjjySv?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 13:16:49.6534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb02896c-4f0a-468a-318d-08dd8e329775
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB2031
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

