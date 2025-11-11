Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A02CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 06:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9AAF83E63;
	Tue, 11 Nov 2025 07:17:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="u6BLu7fs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73FE383D2E; Tue, 11 Nov 2025 07:17:18 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1264B83E36
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 07:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=je8K67mZg94Ulb8L4N/qOtn5bd8BcX+NNzc3shzk683GFKHyvy0XjlGvgqDyBBzxbfJ5fIDX2FYdvqqfpjPjFu//JC0PIHsiIaoUI5GxECJ2gionyEfTtatZuRU6VQsGbA2Bo+CeptA/dsDM9TnHpaysRuxDqVtb6irLfHmpP2GuS5YHI1M17GYVAPzdLvw33PYOwromXyhBNvldgEWICa+1ZcYwu5PlcQNKXXQ1PmgScalRzjFTNL4Sjbpm2TyIgOJs4sHpVhQXzhe+iio0liau8+ay0hT+gm3d8aTAsUKf4kv3tRXGbNydwEtMirPuYYo44btA4WeTCoAXK/6X7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGK3kVrGRLfI3EBHzbOuRA8EgkGcTcubnwNMEEDE9d4=;
 b=hJiw1AIcasZf6X7PAE3bG0UmFYRvElUtovALk4jKDEGVhrWJZabIiRXtDqo0pMOgEs8vQvginm8vB8Fxds85dG/tVSshPe7xESRxYHo1Dy5esB8CnltOrNn6NpqPidNo5590ya/jTWZIXKTZ0G2ZFRnB+77WoQLZh8bCGpUcaW+eB2jazTjshBN8AwjH3TdlMc97MR9HhDUQeLoqgd9EO977UOWBXcpN0BP2YnjZr7jo1DuyVigIWRHJFE1gnRgRpX5altPX7jr3utVeRKhYR04mFPuIb/K+wCdd74OE9vFuoUHsYbB6Ooelg4oKrtlmeswUoa/UlMNtdk7ghtqzpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGK3kVrGRLfI3EBHzbOuRA8EgkGcTcubnwNMEEDE9d4=;
 b=u6BLu7fsuIqmp5u42QX8+YlThhQOktPA9r6YPQFMxkVjNZHWhzCFsdu1RL7v4q5ROg61dxqMEXIiDi43uR84MBFG/CrPrsfg8RguXMiS33C2FdVJ8+bMNEtdvyoXuz1SHkzo//UgBTvDBWLvPU+er7NtNGevkw5kRa4MwfcMPOM=
Received: from CH0PR04CA0051.namprd04.prod.outlook.com (2603:10b6:610:77::26)
 by LV0PR10MB997614.namprd10.prod.outlook.com (2603:10b6:408:33d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 06:17:13 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::d7) by CH0PR04CA0051.outlook.office365.com
 (2603:10b6:610:77::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 06:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 06:17:13 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 00:17:10 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 00:17:09 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 00:17:09 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AB6GkPR448280;
 Tue, 11 Nov 2025 00:17:05 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <c-vankar@ti.com>,
 <u-kumar1@ti.com>, <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <peng.fan@nxp.com>, <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>,
 <jm@ti.com>, <m-chawdhry@ti.com>, <ahalaney@redhat.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v2 4/5] configs: j784s4_evm_r5_defconfig: Enable configs for
 PCIe boot
Date: Tue, 11 Nov 2025 11:46:44 +0530
Message-ID: <20251111061645.1004382-5-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111061645.1004382-1-h-salunke@ti.com>
References: <20251111061645.1004382-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|LV0PR10MB997614:EE_
X-MS-Office365-Filtering-Correlation-Id: e063e79c-ad76-4315-d7a6-08de20e9f497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lulAFy62q+IDCY3qmZIFizihxyT+2INMQG62ZBeU46bACAvNOZ0Mo0XKtGoo?=
 =?us-ascii?Q?HFXHwkMWhbqT5NPAiAaSS5vhZpzsjwmu9oXRoIfLgKEZ0olUXmU76p7m3AvM?=
 =?us-ascii?Q?cXq1v0l9uJeZBPz77HRABKJgLGQxX5SAVk8rkC1h7siUB2GNVph0Ogcfl4Os?=
 =?us-ascii?Q?LsZpiRoFXyDWdkAc9/rgdGUtyHRPL9VqYkDPu41FTeaB/o5bBi2oeDHMKF9j?=
 =?us-ascii?Q?Fqz6u9ulrsy9nD7I3I+3VHdO6NnLgQ/hfnZHCO9JKLv6SZXSv/Rv9ZKyiwrP?=
 =?us-ascii?Q?ubGcjiwaJedQ0Y3gn08RMg3m1uP+VuWIG0HnP0jY+3Wh2ooPUZK2KFwuYwtz?=
 =?us-ascii?Q?XywDmsD7oTnKhaHQst4g77axDOIIFg6TA4mJi5RDjWtprkFun65a+hLrmj6k?=
 =?us-ascii?Q?/TrycShaxYXlL2B6ijtJjlK2Hf+UV2UsD+ja4AlKF9ZTUmHggGe3VcEHha9M?=
 =?us-ascii?Q?0NvQUN4JWdPf92m+9qqY1e8EQ1jfKPk0o/ZNVhMRG7MJLjLG1h4L/TYFXTxS?=
 =?us-ascii?Q?AmYTmJd2E5LmQenh2NZOk+GIVcN1GeATinuzgKasgDCW3VhYLMzYpBSNM/ma?=
 =?us-ascii?Q?LRb3Mrr7SXRIqZ2Jp8GVAXNvxKms4MbBxI5yGLHWF0vIqyYZzWFbHwvxux6p?=
 =?us-ascii?Q?da/wvhifXnT15fhFe2Cmp2G2wp67cT8rxkXUWJ3dhvV2fm0gcViDCqGt5YZD?=
 =?us-ascii?Q?BQldXdQ+4NwmoG/FUV5OQGHCjcePpdShl3Xh3dyBQQ+Z3XmR4oZLVOMCoSIw?=
 =?us-ascii?Q?hBDmpuSLt6EQ/Y84KlyCBduScO99koNNbUxuEuvGzrgTGVOEK+KyyWjMUyrg?=
 =?us-ascii?Q?JUVgs+u7NUXD0sbA7Z5qF2k6HLUUYSnIRFJpsCzfhs82PsMojxsStaeKVYiW?=
 =?us-ascii?Q?WHnNcD0ZQK0/YCcgb4PFSHkz9tDxV8rSXhCGK+aH2ig86urJ67q+ZgsN9seY?=
 =?us-ascii?Q?3xFWilokkTs7c1gkBRFnvFsn/a+0vL1As0F9Ipw9UTEFx7PZqI3A9Li51/dP?=
 =?us-ascii?Q?NJegxJZm4ZsmsM41PLYEfRzNjf6h1SnewvY6yRCCKZ5/wK5OxWCANN3zi1oo?=
 =?us-ascii?Q?7Kbw0HN7rlR7cu/6jLHNFW6qpRrYqQpQSYmMKE20JRA8ApfyFXvEFu8lPO2L?=
 =?us-ascii?Q?seAvwTlL9qb8dC75JhgwWzgatHAnNnmFGjQiwKgph/Z9cSHsm/p4klyl2E28?=
 =?us-ascii?Q?i6qnhl6dj1HiXeepHJ8Ije0hHg3AfqeDF5GE0uKWxjCF6Csm4K6cM85eqyqx?=
 =?us-ascii?Q?EI0DKC9Jew2190ivGMv3jdwrBcN5GPgwKrwW9ZbORS2lQ+Ck56pZP6MOPSyH?=
 =?us-ascii?Q?hxK3Uj39Lqxy2Uq3y+Smo28+g28GL5irfvqwYI1JKm1E9ywdUd4KM8DJfHYW?=
 =?us-ascii?Q?1ULTJZn1355HYNaxsE1XWjkAwkDunkUEL07l4v+KEUm0E2Fffw7AZ+HO3yFG?=
 =?us-ascii?Q?rREYXNLsYCcqBEh2hBw/4cqXErlrCy+QJaoY48BwYji2Va7uH8EVe7CWldqy?=
 =?us-ascii?Q?DL1ANf4jshhyqFVWFpzkcdIUjyFuAFzG+CkkkPugtIS9vkD+CDp2cvj96CGY?=
 =?us-ascii?Q?wZwrmIs07f9Yoo7Otgrdz6w4rk0klch55und0fGi?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:17:13.4755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e063e79c-ad76-4315-d7a6-08de20e9f497
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997614
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

J784S4 SoC has two instances of PCIe, namely PCIe0 and PCIe1. The
PCIe1 instance is used for PCIe endpoint boot. Enable the configs
required for PCIe boot on the J784S4 platform.

Additionally, enable configs for J721E WIZ SERDES wrapper, Cadence
Torrent PHY, and MMIO multiplexer. These are required to configure
the SERDES lanes at the R5 SPL stage for PCIe endpoint operation.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 configs/j784s4_evm_r5_defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index cc340a2fe76..2279ba7f173 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -52,9 +52,16 @@ CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_PCI_ENDPOINT=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_PCI_DFU=y
+CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS=0x80800000
+CONFIG_SPL_PCI_DFU_BAR_SIZE=0x400000
+CONFIG_SPL_PCI_DFU_VENDOR_ID=0x104c
+CONFIG_SPL_PCI_DFU_DEVICE_ID=0xb010
+CONFIG_SPL_PCI_DFU_BOOT_PHASE="tiboot3.bin"
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
@@ -122,6 +129,12 @@ CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_S28HX_T=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_MULTIPLEXER=y
+CONFIG_SPL_MUX_MMIO=y
+CONFIG_PCIE_CDNS_TI_EP=y
+CONFIG_SPL_PHY=y
+CONFIG_SPL_PHY_CADENCE_TORRENT=y
+CONFIG_SPL_PHY_J721E_WIZ=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
-- 
2.34.1

