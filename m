Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B384CEEB565
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 17:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E60C58414E;
	Wed, 31 Dec 2025 18:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Hp2Jqiyp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A13C1840DE; Wed, 31 Dec 2025 18:37:15 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AC688414B
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 18:37:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4Vj8cnHMk1FFEJnwi7TC4qE9mKhryynBn2HI1qMzMEfJ3pIDGfMJfyTjHXbpghIUlkchsMzGUwOVOLe6wFgD3iqW1XHQr5lnW1r45aYywhFA9WJXCAus5dHJm+5QgVS1mH9J0U4EeLAdgM1ml+eHjGkg7T6Glh4RpLl1XTtacs5W405jNVwYoEwwWIY8Vvsv/2ScNAyzrSNuBtouZtZqpyKdi89Dxo8kuURVCkESvSqcvBg/1BM0moDxqNBnAncZLTw4LSzwtqFWJyyOjL9NyUqcPtzf3w8J3jNK3c/0cXzRIUUs8Jy4COVu0qA9LP97YnSwNRy3MAT6bKfpB5zCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS4w7WaUExCnUkMxkkTOlQcbAteiHIlMUlvCtnRwjt4=;
 b=XGxZyuAfffmlz5wCXLr3guGFnLwEWpz5T7flK/J68jZ8ezvKLTV1wMpMbK545uJBcO4Ds+JpJo8A4Tauj5DwhdzO91rv+p4hNxvTprZtOzMm7aTxWaRldeEsJtAk9OxQ8MsDiFEU6oC2Udwg4XbBOu07HOHXODM0yTrm+myhF3oRwx7/S0BSqg6NNU3CahWy9uyGyMbEkQV2mRxu0U9hslftjfhBDf3/htuQUfH7rSLj50MsDuJnFJQP2gOshW/5bNeTvaHFl087yjBqkOOmbS7XVl99JUK/wn4P7ImQ69Gqy5Usw8lh+SUOgGPCSXH03wOIH20coXqVsO72Yt+7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS4w7WaUExCnUkMxkkTOlQcbAteiHIlMUlvCtnRwjt4=;
 b=Hp2Jqiyp7ofErcc+gxmNsSAAfWK1xbq5r4zF/IdbCH/o3p8UylM+LkUoDu2ozwzuze2O95wWxLSggzxhpWz2MHpMY73xmnN8ogmGasKWzg+8q8lB8hQ/Tyd691DxBWJ8p0by4BSieyR0rZRkROqFFAuInHUIcnu8k7sZ5gXTQuA=
Received: from BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::15)
 by DM4PR10MB5942.namprd10.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Wed, 31 Dec
 2025 17:37:11 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::55) by BL1P223CA0010.outlook.office365.com
 (2603:10b6:208:2c4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed,
 31 Dec 2025 17:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Wed, 31 Dec 2025 17:37:09 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:37:06 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:37:05 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 31 Dec 2025 11:37:05 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BVHaOr22541396;
 Wed, 31 Dec 2025 11:37:03 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 11/11] configs: j722s_evm_r5_hsmboot: Add new defconfig to
 show HSM boot
Date: Wed, 31 Dec 2025 23:06:21 +0530
Message-ID: <20251231173621.1069988-12-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251231173621.1069988-1-b-padhi@ti.com>
References: <20251231173621.1069988-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DM4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0d8741-a31e-42b6-f4a7-08de489339ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rKhDSroE4eVobZy/Nq8G8IHqziXGShpNhZ1CXhprCQxJrp4D1XXy7mI7/LR4?=
 =?us-ascii?Q?hWlkcG8/STjYAFCnB8bJDCHevymiE87714BLTRlZ29YLpKDXOm5TwKt+D9pf?=
 =?us-ascii?Q?S2scZDKULyG+ztuvb9DD5KQ8YJDfKiSUrZANp7kiP9QEhgb3XwseqpAedPxF?=
 =?us-ascii?Q?/RsmjvM52GJCmS40om/1k5MMh+3v1mkm4HbPyfpO7zgFqwPNY+cdIDtNJ6ZX?=
 =?us-ascii?Q?jCDGCiV5XB3ah9zx0T+vywPVcndQkyDLdZ5nhRqwrxiTVUx7mmMbS45QmorO?=
 =?us-ascii?Q?TIveCex0gvlG94vXuw34O/+3pR/HXInLhjL/iEC+scJY1EVzMwPDpUqIZpkP?=
 =?us-ascii?Q?JAl4D0Wx5yqu8KA2WSyNApUeIQeEZOXr/A1k9nyy006xKQHxW4tekXEoi17L?=
 =?us-ascii?Q?cwx+lb5bB3+Q2Kw9et74tW849xDDgJ/fYTC635Y70vVJLMzl2EVVFVEoi/Ft?=
 =?us-ascii?Q?krogP7usvgOJOYpttENQrAOuQ7j+oLbMhiOoqyAKgUD4W7qPf2dv09uiYQBq?=
 =?us-ascii?Q?UdqDyq2EbTcKlJper2k+YNMYCtgdrSqcNlmqN1i8qWTVcNEibUbVdN/po7F3?=
 =?us-ascii?Q?T+qVZDUFHcpRGPnHGN64/f/JQiGkMIEvcWFcZvGw9JXPZL4QAUCWTB4BGo7q?=
 =?us-ascii?Q?1Vs5Regunr73RalSNhwX1c8mpW5/EP/npD8LgFwhMjJsQy0A2aLRotErCo7/?=
 =?us-ascii?Q?VzywjC0bXv8ahDLfQoM0SJfCi5xJ2gNcudmPeg1JxZB00czpivNCAKY5kuty?=
 =?us-ascii?Q?syCYH0hnWgcRUOzy4CEWrDUwKEBGfQYXvoTmlEUOgSfWNQW7Es4FJEo2G0eE?=
 =?us-ascii?Q?mNZ6pFqmwRDkcyX71TyHbGcWt0ZXB/bdGyKbsf6rQNnIU3HHKoCcbVB/EL68?=
 =?us-ascii?Q?+nIBdqeaKjkGM4TTOnH4D9ZChbn6BUI0kpXh8aux0UAc3k3v3vLfpgFZqEvS?=
 =?us-ascii?Q?q6b6kEI15avmHLGTi0a0YxLFZ1smEt9NkmjDPv8RTFNA98OVmUmgvDM4MUBa?=
 =?us-ascii?Q?m/IOg06nDFF5nTGWm8kocWxiPxDy1vTKUb2X2mgH3t0kSxzSgp8whI71iSJh?=
 =?us-ascii?Q?K+P/cqlXW6DIIueAQCqguoWVgW5cdvdhv2Q9IUdntfNEDpGOEiHYTmObD2oP?=
 =?us-ascii?Q?AAe9cY0H8PhmfvUsXmPY9e0TDyAN3girFkJkde/7USrHtPOf4LdM7QUNbKgY?=
 =?us-ascii?Q?33Rr8ZNNIrL+LidBhHcXlstg3OXdTgsSte9sNsx9uJisPNMyAtIcoKxio9RY?=
 =?us-ascii?Q?+m1zfnT/AG/iiUhOLhPsyuRjzeI1OqEnR3sLH4RWcrd+HN9aMWRmom3FITkD?=
 =?us-ascii?Q?FbCIy12wo+00naYvpcq1vHD7NlI9Vm8TnLiVRztUv2wb761GTBMnLy29CAZy?=
 =?us-ascii?Q?XA5JnYqgTDrNRtDtaq8G7kGHn+rPEyivVOkvt2S0YsPhkLLdWAreyd93WJwl?=
 =?us-ascii?Q?8EWmKo2zMYcb3yMPOW35+3cM7MqIMUBN9fnnc/cwsHBuvKSzOaltZrvawKUP?=
 =?us-ascii?Q?iXns9XfbcjCwDCDuecxeQiq3CJPMP1BGtMpM/5s7pssiuPQUz08SXXk4PrM7?=
 =?us-ascii?Q?QmoEBkKkckdPFodsPME=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 17:37:09.9095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0d8741-a31e-42b6-f4a7-08de489339ca
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5942
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

Up until now, the R5 SPL in J722S platform was configured to start out
of the SMS0_HSM_SRAM0_0 (0x0043C00000, 512KB) memory region. However,
with the requirement of loading HSM M4F core with its own secure
firmware, R5 SPL can no longer utilize that memory to execute itself.

Therefore, utilize the MSRAM8KX256E0_RAM (0x0043C40000, 256KB) memory
region for loading and executing R5 SPL. Naturally, the SPL size has now
to be trimmed to be fit inside the smaller 256KB region.

As an example, create a new defconfig (j722s_evm_r5_hsmboot_defconfig)
which removes the SPI related configs to trim down the SPL size to
~175KB. The above defconfig demonstrates loading HSM core with SD, eMMC
and UART bootmodes.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v3: Changelog:
1. New patch. Show an example of booting HSM core on J722S SoC.

 configs/j722s_evm_r5_hsmboot_defconfig | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 configs/j722s_evm_r5_hsmboot_defconfig

diff --git a/configs/j722s_evm_r5_hsmboot_defconfig b/configs/j722s_evm_r5_hsmboot_defconfig
new file mode 100644
index 00000000000..517cfd40018
--- /dev/null
+++ b/configs/j722s_evm_r5_hsmboot_defconfig
@@ -0,0 +1,41 @@
+#include<configs/j722s_evm_r5_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_J722S=y
+CONFIG_TARGET_J722S_R5_EVM=y
+CONFIG_DEFAULT_DEVICE_TREE="k3-j722s-r5-evm"
+# Enable HSM loading
+CONFIG_REMOTEPROC_TI_K3_HSM_M4F=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x43C78800
+CONFIG_SPL_TEXT_BASE=0x43c40000
+CONFIG_SPL_BSS_START_ADDR=0x43c7c290
+# Remove SPI configs to reduce SPL size
+CONFIG_SPL_GPIO=n
+CONFIG_DM_GPIO=n
+CONFIG_SPL_SPI_FLASH_SUPPORT=n
+CONFIG_SPL_SPI=n
+CONFIG_OF_BOARD_SETUP=n
+CONFIG_SPL_MTD=n
+CONFIG_SPL_MTD_LOAD=n
+CONFIG_SPL_NAND_SPI_SUPPORT=n
+CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=n
+CONFIG_SPL_SPI_LOAD=n
+CONFIG_DA8XX_GPIO=n
+CONFIG_DM_PCA953X=n
+CONFIG_SPL_DM_PCA953X=n
+CONFIG_MTD=n
+CONFIG_DM_MTD=n
+CONFIG_MTD_SPI_NAND=n
+CONFIG_DM_SPI_FLASH=n
+CONFIG_SPI_FLASH_SFDP_SUPPORT=n
+CONFIG_SPI_FLASH_SOFT_RESET=n
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=n
+CONFIG_SPI_FLASH_SPANSION=n
+CONFIG_SPI_FLASH_S28HX_T=n
+CONFIG_SPI=n
+CONFIG_DM_SPI=n
+CONFIG_CADENCE_QSPI=n
+CONFIG_CADENCE_QSPI_PHY=n
+CONFIG_SPL_DM_SPI_FLASH=n
+CONFIG_SPL_DM_SPI=n
-- 
2.34.1

