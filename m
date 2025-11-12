Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE069CCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 06:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2905A83C14;
	Wed, 12 Nov 2025 07:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dpng+2qz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DDE083C11; Wed, 12 Nov 2025 07:47:43 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C92283AB4
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 07:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6/fyM1cVVCCW4xxAyW0YmPgLzObrwi3S+CbYLyzPdao9u9/FfDC2rQx5ABFFiLwLdiT8o6LPQoD9T0BucbXGVSDnq2/+T9+fi8GIpxveCGY+tC/ohqbRALfHZPGA4wmAWTDePnrFocVfLy8bln5wcADn9KfnaeOg6psvqspbISIRv+osTLp3+nGvmueldN7t+pE/QybL84dI9ssXcM162W9RDtINgp3HUXvniWGx0t9ZYaBNvo2jhOnfam9Anc2Dbtg7XzawRxn+4pRmvAWE5YkNeCQoF0n3DjJHaSDEChAWiYwBrUZcZRDKVhqD/TDjbBNvaOCnW31KIkXzFKLKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNFDipIjpdqqSySukPiZPxX5suvluRVfUQl1bUH3zmw=;
 b=oA+2tjDOC8MnxFs3B2UYlcSz6mTaDAlWsaf2Xy2ySSDkPvVUiREkqjeq1T1d/eulbz8GZqPLd5fAM0SVri++jR+WAnRUH2BeU5Ru5OEBgxdCran6+Eqy9DO3EFqj7vm9+uPM/iIfY0FqGrpyCF95RVU9xtFXsTVvowFCsHSN0BGLvLt9+bczVCI+sBrxqqvIIH5JSI5zjF2OXd1sm/tRAU/9yiRB94+hd5/8eDKgNmhO1QjeUGZ7CyVnGWBf2Dn5uGNgqKUy0enuY3t6VkEiVPCGz1pcwfQ/r4CY5STWEN5dK3FBaUQSQPAK2SSXLA+9kolUxJg0Iw5+FaDX6F6zwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNFDipIjpdqqSySukPiZPxX5suvluRVfUQl1bUH3zmw=;
 b=dpng+2qzirzsuMd1QmFpp0EU9CViUJz3PZkQCpc8rVW83S2ziBnpgV89Ry+veeoR/BUpRqIt0jSrCnaGKFddCtQTF02USYtAtTMNIOvNyZeetYEDGd3exYFZz4wr0BjxfEN2gYVzZf5k98qSQBgxm9h2Q/t2GIMpV3wIsEaeOLY=
Received: from MN2PR22CA0020.namprd22.prod.outlook.com (2603:10b6:208:238::25)
 by DS7PR10MB5167.namprd10.prod.outlook.com (2603:10b6:5:38e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 06:47:37 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:238:cafe::15) by MN2PR22CA0020.outlook.office365.com
 (2603:10b6:208:238::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 06:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 06:47:36 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 00:47:29 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 00:47:29 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 00:47:29 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AC6lPoV2217584;
 Wed, 12 Nov 2025 00:47:26 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <c-vankar@ti.com>, <u-kumar1@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <peng.fan@nxp.com>,
 <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>, <jm@ti.com>,
 <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v3 0/5] arm: k3: j784s4: Add PCIe boot support
Date: Wed, 12 Nov 2025 12:17:20 +0530
Message-ID: <20251112064725.1049199-1-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|DS7PR10MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: a473f3a9-dbf2-4d6a-fc9b-08de21b75d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FkW4+Jw0LbVZTvE8ugCv2hDSpa8F1Nf2rLMs2ek3MwPPJ4ms1wQqWWUQw3pq?=
 =?us-ascii?Q?tPjUE9mU4ILtRNGAC+NLwW8Q9UBHOOlH+uaTH2EUFhAuNiZPgCBJHg2z3SXE?=
 =?us-ascii?Q?68kR7WLa7Mgvl0mkw4z9JnphssgEh3W9kf8tB57XZyO21nU9HJWiyvDihTKu?=
 =?us-ascii?Q?VYJ5ZyWWWO8QwFlsQ13oEFpPuqk9vc/2d2iBg/Z2y2Wd+ND4uBlmazhcLOlm?=
 =?us-ascii?Q?0y08Wk0mXGIkh+kDjaOoTQ+nkRm2BbEIzpLA8qIdnHKGn5Jebg8TNsbr/HrD?=
 =?us-ascii?Q?CAyB93ZC3xWBkgPgV8f2g1jVi24TQ8/cBhLy/SRQbNg76IV6eT3b9ukYtRYN?=
 =?us-ascii?Q?XsEfQBhaKJ5EOj4VwaOQUqtzM/cAkzbuPhrXHfduuhJZRhX8loHJolB0cF+q?=
 =?us-ascii?Q?473ya2LCYbhffXsdWaiCsIFzzo+P3+G77xHD/7ae2ZJCxMSavennaqfvKJua?=
 =?us-ascii?Q?cC7v1KXth2j6Zb2pnoV2qWS6zWYN72yd2mLMshJq+6PnLEpAk03Gpfg5A1AA?=
 =?us-ascii?Q?fiymtQa0lJXlhRDqW/sX0X+MFq8MghXb1VH0mwHRGF/IWFl+I6ynjApyS2jw?=
 =?us-ascii?Q?4GHGQF5nFssi2uawgXdbGvLnR0B7K5UfwTvyN10sJ5jj7T9AZvOGKO0b6rUi?=
 =?us-ascii?Q?EcnZ13XWgJFmtYuXa5O3aZwRb/ccBYpdIrTbjXFQvXq5YTH4ME8Br0QG38Go?=
 =?us-ascii?Q?3NYnh56jCTZTGVSDgoEYAaT9PtDh2hoMXaYAN1q92srNJiBjYijLZMO50kcB?=
 =?us-ascii?Q?C9az5K27SpC6LT+baco3beYe91TqQb06ldks+TR+xuoyiu6wtDzyHfLs8+UF?=
 =?us-ascii?Q?73UV/qyTy2hxap1iDFCvnTS8CZ6O8vswoZiEOknFDcVY8ZNj7NmDlFYmE5xK?=
 =?us-ascii?Q?oMtAxD1aiPdobgADPexyfSlB27EDPUiKZ3B114HdeQvAlSDdoR51j1BM2xWR?=
 =?us-ascii?Q?5fcPm3aLNjEDB2GH+GKWBdGpN1Fa27+65UldwH4yxUHaO975EVEhOZNuYLSb?=
 =?us-ascii?Q?sN6WsZntKXFEKGxgSuBY7l/YcRSmdbFUUjJDFejwx0JvRNnA1n5gaa3MpH4D?=
 =?us-ascii?Q?21XK2ne95hJHpDrsY+kYn4mGLX7RE/CjrFhB1PJ+TxKo+nDP2fcG9KfdT1ZU?=
 =?us-ascii?Q?CwxSfsCzQe8hTceizBCASJXKWCkamtVSDdPSi5L43i18m5zq81ZiC/rm73uZ?=
 =?us-ascii?Q?gydy6NgwHR2NNThzK6mpsM/iZUmXy0ErFhhwbQVHmhQW8d3LihmNAgkMQ5GJ?=
 =?us-ascii?Q?3Ru6Q96KwjoC+IdPbKUSPiOGfbSH1HHe1NUhFl0FgHeYh8YM7R1aAHcf6jB5?=
 =?us-ascii?Q?rvGntRhqXH9Lo3I16xm6/xLUZH34PpOzh+OZPFWY+4JxiyR5j+tphbd2ZdCI?=
 =?us-ascii?Q?HGX6SKYH26JY8VnqyLFH3x1q/U43fn6c+YG9RUuQdGLB1VUksZiRSM3HzTKQ?=
 =?us-ascii?Q?Y3XTnlDyOVIrg5YF8T9t8JgT+hkFdXIZZMuFb0o8K4R//4kAI8x9J0uhjO+d?=
 =?us-ascii?Q?/kqz23FWHGmn/wUOWE+HCwzIlUlMq3l7B86G?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:47:36.1972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a473f3a9-dbf2-4d6a-fc9b-08de21b75d69
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5167
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

This series adds PCIe endpoint boot support for the TI J784S4 SoC.

PCIe boot allows the device to boot as a PCIe endpoint, where the
bootloader images are loaded by a PCIe host through Device Firmware
Upgrade (DFU) over PCIe.

The J784S4 SoC uses PCIe1 instance with SERDES0 for endpoint boot.
To enable this functionality, the SERDES and PCIe peripherals must be
configured early in the R5 SPL stage before the bootloader images can
be transferred from the host.

This series:
1. Adds the required clock and device data for SERDES0 and PCIe1
2. Enables Cadence Torrent PHY driver at SPL stage
3. Enables J721E WIZ SERDES wrapper driver at SPL stage
4. Enables PCIe boot configs for R5 and A72 stage

This feature has been tested on J784S4 EVM. Following are the logs
corresponding to this feature.

https://gist.github.com/hrushikesh221/cf48b512eb4cd90c1612ad2e531b8ffe

Program used to copy bootloaders from PCIe Root-Complex to Endpoint:

https://gist.github.com/hrushikesh221/94e6042dbd717c74b74a5c9fc8ec5b6c

This series is based on commit :
6b27b688694 Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh

v2 : https://patchwork.ozlabs.org/project/uboot/cover/20251111061645.1004382-1-h-salunke@ti.com/

Changes in v3:
- Corrected the PCI device ID for the J784S4 PCIe controller

Hrushikesh Salunke (5):
  arm: mach-k3: j784s4: Update SoC autogen data to enable PCIe boot
  phy: cadence: Add config to enable Cadence Torrent PHY at SPL stage
  phy: ti: Add config to enable J721E WIZ SERDES wrapper at SPL stage
  configs: j784s4_evm_r5_defconfig: Enable configs for PCIe boot
  configs: j784s4_evm_a72_defconfig: Enable configs for PCIe boot

 arch/arm/mach-k3/r5/j784s4/clk-data.c | 209 +++++++++++++++++++++++++-
 arch/arm/mach-k3/r5/j784s4/dev-data.c |  43 +++---
 configs/j784s4_evm_a72_defconfig      |   7 +
 configs/j784s4_evm_r5_defconfig       |  13 ++
 drivers/phy/cadence/Kconfig           |   7 +
 drivers/phy/ti/Kconfig                |  10 ++
 6 files changed, 262 insertions(+), 27 deletions(-)

-- 
2.34.1

