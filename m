Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7B9D111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 11:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA6E983B43;
	Mon,  1 Dec 2025 12:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="A75MQVMa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B18C83B5E; Mon,  1 Dec 2025 12:01:35 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 173B783B21
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 12:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+D2WbDA7j9RWCHTtUoayQyhZm1R4ycKJEAKiN5bG5bRqlL+/7uCHsikpLpQWwESb0iDxSP67r4Gzz1bkBTzjvb6U5BTqH11wBI6eOnGO0Yy+sd08L+LTUXO7zd7MFyuj6WMyXVCqLJ6N1DzpaAyG1+dTw9gRCaG7X2Z3rIzEJVCU7w1lQA6Ki3Imdl9X3Ok8P0S5gjZ1IusZLxCjsWMR4r6P3wckn+1UoaTPLGgqt+e08pp53tGoOBolzu8Fi8ySMm3T/DA9YRvPFRuWowG9Ef/ju+QJIZxG4UXHYCLZlote/hZJdHHkjSbxbMg0jhXDrFpjmJMljbWvqNpnizH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKNiTjQmcg6e3F8ihFYLpi4asFuAdwHU+4UM55hTixk=;
 b=PPUKVoxwHyIZR/T1t/t+OiPujFgRTt01VFHw1BwxgfON7f8AMifAs5//Cjhru4j2SL8ZKM9RwnPxBhClZdP80iBVgnsxdAS59+dLApFBAFXBq9De+12iWtk+AVruSdrgAMnAVjEECimyMo8OTQJNnnYdu7iDHNZT++MOfNWwqd2Y2VWqsnm0qpGcltQUd0w8oB9OaVy33KCzXSeTo5Q7pmk36kKyaBoahv2UUagysXNUmxYdlxjr2Z7oVPTA6vxBzgn0LLTLLb647Pa8KnxCR9Y9CgbXGvxlToQ4T+p3+D5ui27jBWVI39yz5Pp4SBfmwE6C3Zrx4jazwQLQUGx6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKNiTjQmcg6e3F8ihFYLpi4asFuAdwHU+4UM55hTixk=;
 b=A75MQVMasYs+4Nx3yHcnBujv9YFM5pwYXezmdAMgWGsz6YaFKbnQuRwQ88DKUcxTz1oiA6oOnCPcvYz1PCLVMN8kbcxVkPnLQPiKpsX+HXwLz/Frpb8no9lAQ9NgyF0DDhM/IZCDo8XqF0BFAXav2VC6Q/jJQjuHIoJGsDOBLoA=
Received: from DS7PR05CA0029.namprd05.prod.outlook.com (2603:10b6:5:3b9::34)
 by IA1PR10MB7486.namprd10.prod.outlook.com (2603:10b6:208:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 11:01:30 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::9c) by DS7PR05CA0029.outlook.office365.com
 (2603:10b6:5:3b9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Mon, 1
 Dec 2025 11:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 11:01:28 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:28 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:27 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 05:01:27 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1B14qb306512;
 Mon, 1 Dec 2025 05:01:23 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <m-chawdhry@ti.com>,
 <c-vankar@ti.com>, <u-kumar1@ti.com>, <j-keerthy@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <jm@ti.com>,
 <anshuld@ti.com>, <s-vadapalli@ti.com>, <ahalaney@redhat.com>,
 <semen.protsenko@linaro.org>, <mkorpershoek@kernel.org>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v4 04/10] configs: j784s4_evm_r5_defconfig: Enable configs for
 PCIe boot
Date: Mon, 1 Dec 2025 16:30:57 +0530
Message-ID: <20251201110103.845413-5-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201110103.845413-1-h-salunke@ti.com>
References: <20251201110103.845413-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|IA1PR10MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b30e6e3-8930-457f-494d-08de30c8fa9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lUd9mBPXbpaPXX3oPsWZN053BVsefSaRdRUUVVtzBsJhCM5jkdI+8tdVMJJl?=
 =?us-ascii?Q?aEJDOmFBiND1lqChFuHgNmRENL1V50EQlDkmWKbF24QvgXJHLVudPTl088ay?=
 =?us-ascii?Q?ud7KEmY9wMZd57eX5AoYuRW5w8yEe/LlHtWJEA3N9U6ESvmY+r/hRpy4abLJ?=
 =?us-ascii?Q?Ms5M+F11dwx/rVzscdGS3il2zbQFv3V/soIWSP17yuzCI6svHgKahyQYhxAk?=
 =?us-ascii?Q?n9lokzz5ICFl5WcO2qJXNCRNq6jiJTi0/e85P3R8p4A987haaDzn7/nRCG2g?=
 =?us-ascii?Q?ohlcF1YfARizvPFzhAm4sZIWwHlXOyy/TPREryG4qEI169EohTA526U4c1aj?=
 =?us-ascii?Q?vL9MHWC1rljn9zd4pwGtIb18hDjSJDRxbF7i2KalVoQlk2n6H4UP1s2BkxP6?=
 =?us-ascii?Q?KfWlKloVo9/kLswYeGFdeMYUK43svRBUd/35xqG0gxj4pkMNX0SJnEPWMjCP?=
 =?us-ascii?Q?PYtMTc8TDU0z/HpvMlOyvCtVxZ766H1tH/VQUrdxzz0r+noVvSrVJQ3Jijas?=
 =?us-ascii?Q?hm5YfiSRpwITKsTtLDEH5M4xM3iymnZwiNRm7c4jMv7rIJIwPxJNMxpAdUL6?=
 =?us-ascii?Q?N0B6R2DdM/wFF3oIR5ea8l06W0AlrN27fy1VSb5ftKXmtFakgNSP/o+sWAbK?=
 =?us-ascii?Q?cW3EGntiB0tbglnXXwODi6ynF1nzqKANReIflpGmsDAD4UN1n/sh7SmkcbLP?=
 =?us-ascii?Q?s+xykHtdG6UonGCfN/+QMBoEKIFP8jkb3tJWYpZWdyOlO9FfdiZlOswHx2IG?=
 =?us-ascii?Q?gKdABNLr91B4YXUZfARuRr1wydj9dpIbaOc6q8CQSwsCLibBzA4kqfLjbQvF?=
 =?us-ascii?Q?O3KgsDEq0/ahJlVA1fdFqFW84ESMIQTMehJMWc7XLvKqLhvunZdJRf8W8AQq?=
 =?us-ascii?Q?I5aO9qj7b/NH/HAOnnmtZr1D783r10sfOIDMJFVXddOyXqPXUzKG+lSQWyKh?=
 =?us-ascii?Q?sTp85RqfKbAWkwouF+V2HD0SzV5Pc2/qKi3Xw9gdjAprwYCTes0WZwpMIZkC?=
 =?us-ascii?Q?Bk4x5KdhXzs8e49jW+dLcIAyByQsmHWhbJgHZKhHEvEseVpGgFKC5ii3TV0P?=
 =?us-ascii?Q?Sdkb3ViCaj3uzl1/NNrhaT+ag+jT4QymY/XLoSL3oK6b/KlwXsjjPPWB076z?=
 =?us-ascii?Q?k7MzHdMrvOeh7v/myF5U3b0Qsu5Mr7JZ72xmeEjEEZRQx/XYelQ39drEOTJK?=
 =?us-ascii?Q?G/MUemoPyenq3qyt19wQtNdru+EgDbolMhJXHGNctJua+ScvRROPOSlA5BJj?=
 =?us-ascii?Q?qKFFU63PtGOiHeooDj38rDwVfQJeYOr8uTQ/Uga3tl9orqyufo5NStryVTsN?=
 =?us-ascii?Q?EENg9ksk5zE+L+DlG7C7yj9dnhibo82mok4P14Z9mZ8sxEZdy5u5W0kYt+m3?=
 =?us-ascii?Q?TqMETHwnBX9W4W7SS92kOxhEJndgaRnZrOtMqCRLvvfuMZYoHM752mcVPdB2?=
 =?us-ascii?Q?pPuIqIytIfWEqFFVNgCD26vIa1urH2kHgF7TtivwLynd77OOTS7wFJLC6oKS?=
 =?us-ascii?Q?M3aPtMsRDpdv/HXUWb0rZ+RsZHonhYCK7Zr3k6WFvbR4EFZPMhDuAf4XXtyS?=
 =?us-ascii?Q?gIne3PeFMKwhCiZwHm8sK3wnET2es07JvsP8NtOO?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 11:01:28.8193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b30e6e3-8930-457f-494d-08de30c8fa9a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7486
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
index cc340a2fe76..a69a253ad12 100644
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
+CONFIG_SPL_PCI_DFU_DEVICE_ID=0xb012
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

