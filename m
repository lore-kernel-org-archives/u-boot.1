Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D43CCCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 06:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C80983B0B;
	Tue, 11 Nov 2025 07:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dsXjyzLx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FC0683AF6; Tue, 11 Nov 2025 07:17:07 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADCA583A98
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 07:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHFKia73wLVdEbuZ8zyqEytCDSH9JIU+n1xm7ndkAq3pxEw8whtoeg+S4LXrmMZqqPKWkWqpchGli2aOUH3LnwIeq7f5EDRg0Nq6s8eTVqYfchCuW9YCYDbP6PxUFu8PWc7xbxZxRAdMXb0gqU0AWW5dXSi5cEgvPaxcgl6P1aO3HeGQ3JOjiXikDeeIW95GN5so2f5LZAMFvwZHfrBUKuxupp/NCA+abJwUf5bWzcuWTBIXHZ/9IevFJj0NCkf17+T/fty92Dp1zsyesBifWC1pzCtbqDcWY/umHQTBHLUvdP1YGHZblnQRruwy04w3NmJTbxxDrZVxjK//RTlofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YscU8dF9DDLMYmqy6jX4mdcOtNRm+BG40pBqoHoXhk=;
 b=gmaQMP2CU69+HC5HN0ojFhGUDnngAAvncjNQ7ih31PDOH1+JxxmFbAJWpwP5G7uahKa3O+bycOoXTZZPovafmyL1VCZ6cjt25RfHGALUOovjOl5PMGCaV4/1G2p5h/Ef6MSih8OEhUjZN5eN9YIxPd87q04WJS2Km7fNtPW6GD1NSPqVx9E9FLP/gPfdHP5JDGrj6/+GmvnJBOV7u/QfVKjtgWYbY4u6AqzKeGfrfsHQNvfdVBHqpsUG/OfC4rNCDTaZm7NQUAGNHP6BAvm+XHCltR8O1cOnzCM0iRqmHl39md12YVqSc4QkYZ1s6mIh3+N3lL2eN1puqBccVPQ+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YscU8dF9DDLMYmqy6jX4mdcOtNRm+BG40pBqoHoXhk=;
 b=dsXjyzLxBI8rzKwUi5K9Z5OHAzijFEA7CxC5QAWuMfa3JAxfBX5SGwix0+ii5o/YPZUDryHOjJvkH26xMiW61OepjSYtWsZRcvthnWSr6E9t4ESN0ce/6vKudJou7/5LsEWWGJHiUyaMDx/XnWzzKFs0EH8KfebooEE/dAwTYnM=
Received: from DS7PR03CA0012.namprd03.prod.outlook.com (2603:10b6:5:3b8::17)
 by SJ0PR10MB4509.namprd10.prod.outlook.com (2603:10b6:a03:2d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Tue, 11 Nov
 2025 06:17:01 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::f9) by DS7PR03CA0012.outlook.office365.com
 (2603:10b6:5:3b8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 06:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 06:17:00 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 00:16:53 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 00:16:50 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 00:16:50 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AB6GkPN448280;
 Tue, 11 Nov 2025 00:16:46 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <c-vankar@ti.com>,
 <u-kumar1@ti.com>, <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <peng.fan@nxp.com>, <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>,
 <jm@ti.com>, <m-chawdhry@ti.com>, <ahalaney@redhat.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v2 0/5] arm: k3: j784s4: Add PCIe boot support
Date: Tue, 11 Nov 2025 11:46:40 +0530
Message-ID: <20251111061645.1004382-1-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SJ0PR10MB4509:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d17955-cea5-41a2-6c96-08de20e9ed14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M/KjzQXP7A78v+VJ9i7PLlxL6CTXBMx1KmpK9vgz+un0SV03HseNSIPkljp0?=
 =?us-ascii?Q?lEzjuL3dmgrX1xP7RjkIhO+MtygTuen4VBaMQJourfO85WA4JsC0rdQI8Z0v?=
 =?us-ascii?Q?R4a7QT7hzVstcLQcgmPEYxV9ekXQjOTDV4gXfKKYjiPrHxQLFVaGxcBfcT1j?=
 =?us-ascii?Q?kDG/+pZodNIL8xC5dB92OCtDxHDVEmyJ9fDx3UzgdeTtxDfdL7srliE9YwvG?=
 =?us-ascii?Q?wo+Ux+XEDEk9x/cXMLLJXtY5kZzhWm1ZFLv77AyHAylS8ubPlXihRuGZKA4S?=
 =?us-ascii?Q?0ni5hKb7KLHgJtc9Q3wU90ulsjGM7OASdAm6aKh/Y5WZqQh/CdJvgJ2k1lxk?=
 =?us-ascii?Q?/jHqgYkg98fEbfJE88owzeoKLXUXGqCsEiVBu2mkopvh4Z4gzCqyZm1QIjv5?=
 =?us-ascii?Q?DyQqCKHL68GsoMeQnGoeRJ5G3w8cXdQ0hAbiWx/7EeiMMRnVVXR6e4P9FrrM?=
 =?us-ascii?Q?Z8B/oaiBbWVcw+gWYVGOAnxVeJLhJuLmOR1mUSM6YSH0e8yUK4XZjzIak0CC?=
 =?us-ascii?Q?JEZwtakuaflf3bm5TAn21yf878h8lLKyUncztaPEAYJP8vmu6joJPtwzd01H?=
 =?us-ascii?Q?WoSbNc8DeRlt5jn4RdVNdhETKg1YEovRlEbVZk4j1cwkvV+kMX0rVJXy6coQ?=
 =?us-ascii?Q?q9nuzauTkhM7nfElzdYeTdGDRKnHmHJZ2E1SDbxg6uwfsOlFQsghrSCRP5LS?=
 =?us-ascii?Q?JixdXWEm5ytoIySsm/RsaaJtX3l7McBKIuX5haFcFhRmtPTTTtHQ0321/TBA?=
 =?us-ascii?Q?ZapmrzVC5NRnTBscqnxYJJHv0aqeajvbMlKOOWAE+BGxVSNrv8wRvAD2C4/K?=
 =?us-ascii?Q?R4KQV/lYbZITSLAVx0Dm7s+8ykgU7CWAlR8oxL9NuyK8NMkWm7I60ViIQqhf?=
 =?us-ascii?Q?rjaOqrTSRizIe40OwF2a+QnchkAhrgVf/38l1j91dlK72TUHEpawHqYjNENl?=
 =?us-ascii?Q?En4L04y+QdpqHzYXiGDHykm+8BHKMwRbaFj1DRW6tALiT69/sRIivVrVv5kh?=
 =?us-ascii?Q?UkqJeVTv8v0upaVvYJHvETZAEaEMF+dlhiPcnSOU4VW8NMPNDAGUv0lJmXeQ?=
 =?us-ascii?Q?1UKK94AbHEhRhkgfSLOlXRfdbOQzBu2/P0N+Bg+WxOnD6Na5tIfTge/Cw+QE?=
 =?us-ascii?Q?03Ht0ApamD1l+e432TL68anjmvAop/Tnp0Ekg2rCbCbR9vjgp/TGisGbDEna?=
 =?us-ascii?Q?des7ANnaAPrLKt1MKVbwEX3215DvjHmX0QXzuXpljkLeEX4/2JDoifysFJVU?=
 =?us-ascii?Q?aSgPEOjI6l475WDivlfaAIZlWuBgVsP4+MHmXN9IWHKdACOyce8TlLNDx2Cz?=
 =?us-ascii?Q?V6BXkJ+V74pOX+I3QApBQugM4LFFOHKloem9jEOplJe3++lG1iJFrtGhsQ2f?=
 =?us-ascii?Q?UfJrMhn8CXj5B6WoWJ/TnG/PyQkpZIsbKBRJNC3y5181J1q7589VJO1eGO3M?=
 =?us-ascii?Q?y5pRjkyHxTs5x/PFJByWqo5PqhEr0hRzUtZUv/ZgZyI74bJGsp6L4envokLM?=
 =?us-ascii?Q?6YQx2VzXINY7sbcC/Cc4+5y96u5xSBtc6Sx0?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:17:00.9774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d17955-cea5-41a2-6c96-08de20e9ed14
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4509
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

Changes in v2:
- Fixed SPDX license identifier to use "GPL-2.0-or-later" instead of "GPL-2.0+"
  in clk-data.c and dev-data.c
- Changed SPL_PHY_CADENCE_TORRENT config type from "tristate" to "bool"
- Changed SPL_PHY_J721E_WIZ config type from "tristate" to "bool"

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

