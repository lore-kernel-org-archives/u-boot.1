Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BE7E8FDB1
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 05:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFA8B83CDF;
	Mon, 29 Dec 2025 06:11:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ifh55ftK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75F6E83D07; Mon, 29 Dec 2025 06:11:27 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B0EB83CAA
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 06:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gr4dBuddbH2JpgScnsgipKFEuQxM5P7MQsAkwtkfOpzFKgQklrAQrxLZ6fSZnfAktEBTY3CHp4UUjXeGLN5TBPXv0E3SaJUKZXG39YvupaueOBB6GHKTcm9mprBiRNnOUuQNePbnxyI0mJaof5eXhqB0oFX2U69xqtXHKBAnZBc+Q/2Us7ZIvxXiyyu5MhelRvGiLDaC8Z6PPyTqqATmJfKLmmXyIDuwvntZp8x7uNEEjMO+hUu+cwJ94rbutC50X1zaCqO13/dwmYPJ5I+JEOI4No2QhiOToRqsqH0GJigGj1zX7g4vmcu+bHJGoQl9URBMC8Qn4iYiHFQCwuddng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtRvrayc2Nh+0pBDeAN4g2tPfwhaU4hbubhkCuAe6t4=;
 b=mbFV4FqzldXAF/BUHe/0Jrd9BclyW6pTGLfo681Y5ibBWgjeMNvduVOPO6xJq30ZQCfGplycdL7t3uSOhHzaqq8PBsO0faOEL4Ae4h2mI0ZReh6aQTq2h1r9dJc2iIwWIs5Im70ZMqapwZ7o4oA1qIgcoqz50Cncx9C/yv5SmfCRXIDoqGR2wCUjaGSLOQVN6BnE+0I5teaPbnh2Jx0F0CAck80dQ5aaoIrpn+CvTnTasZVzgP3m8P7t6JeKSvkOgERHHw1QsTSlDsVDD1kmTejn/SyKR20b177AeLhavKDztn0T9bwIhtbrZKm37DvVx2ZHYj8sXezW9bOg4ivOug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtRvrayc2Nh+0pBDeAN4g2tPfwhaU4hbubhkCuAe6t4=;
 b=Ifh55ftK4vMrUPGWYVNfC4vDv1vGE2pHNcfdkccZQMwU6v5F+XfLN2rrEW/OaFljg0WD3HZ8YPfU+X7VH6XrYN0OH7K6HyZJpHPUHQ2PeEcehZ8460zZApQYbCBxTAcaahN+js6HCHPyxuh7iec1gYyuVK8v99MrDxS016XZf3c=
Received: from BN9PR03CA0689.namprd03.prod.outlook.com (2603:10b6:408:10e::34)
 by IA4PR10MB8518.namprd10.prod.outlook.com (2603:10b6:208:56a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 05:11:18 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::8b) by BN9PR03CA0689.outlook.office365.com
 (2603:10b6:408:10e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 05:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 05:11:17 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 28 Dec
 2025 23:11:16 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 28 Dec
 2025 23:11:16 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Dec 2025 23:11:16 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BT5BDfx2876936;
 Sun, 28 Dec 2025 23:11:14 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3] configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used
 by PPA
Date: Mon, 29 Dec 2025 10:41:13 +0530
Message-ID: <20251229051113.2136908-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|IA4PR10MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: 197ff4aa-b0c7-4edb-e9b8-08de4698b23d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zzszL5AdaEXdj6uR3yIkGln8f9A89jqX7EVQ9V1HpG4Q5HrzyKIvWI+rR4+V?=
 =?us-ascii?Q?g27DMPT/tW1shfwHCy5+LML8YAFNiXsLVISZLXB6a8IUnZ/1nYMpQ+EydEAP?=
 =?us-ascii?Q?tpfiWiEpTzYpi3kEPO5uB/NV/jEismKFukcKPYlqNOKtM3OFw226rC7utLwx?=
 =?us-ascii?Q?GovQi9asSxLS9lmxc8L2bOcKEjffejfxxNaQmpwZHCXIjrqQfRm65n3IcylS?=
 =?us-ascii?Q?Psu7pMEX4XlYKEsZdP8f7wP4ABjR92A/kQb0IYfc/Zin/o6KLdrW6qm/AL9r?=
 =?us-ascii?Q?KIGY2Op8cUBo2G9INtY8aAE4inpSBv8EQZqlnBpqky+8pXm/XEMJh5olY1vS?=
 =?us-ascii?Q?7bkbk+RydpMMi9GuVJJKxjk/6q7WPPsd1EyOc5rGOrXTjG7XAzwUOvxbXDl4?=
 =?us-ascii?Q?CzPTnqWtSEpoYipXHaFkkuN0JHRCHNTBvAkErn6Y04D52uUpUOvrJnugCPdp?=
 =?us-ascii?Q?FPPtX3ewkiHUJwqlvKcGeDjgwvk9VxhjEw6Urw9k96ZbxrGGY9Ea+ohpuBAX?=
 =?us-ascii?Q?BAbBkSqY6jycetWCzg4qvtv3SkHC84yFlolJ2wLTpqTltPSLHvYcyYY6taV+?=
 =?us-ascii?Q?P6Php2nGq7FRVbxZPWcI5s65ErdAcKRM+Y7oCVO1fsh26mAX/E882zNbZyp9?=
 =?us-ascii?Q?Sg4U2ZvN/hVWm+zWVGqtAxycAWUpROGaChaTddXJp7JoCuJMwOf8YIIV5v+j?=
 =?us-ascii?Q?V7OAR1cb1hlmJAMik97fhUDnLZ036cP3Ylq/X2G7M3BHMtoerNCCY+iBzvB3?=
 =?us-ascii?Q?xRgO9VoKVmKr4029Kpi8f+32pBj2lIa3H2UloSVTJVVmNIQJdB6p0fE++PpG?=
 =?us-ascii?Q?QgxjqdAvkdDK7i1N+1SLV7S7veacKElyjkMR3bAjNeGavxMXcWCNUkPi7bCk?=
 =?us-ascii?Q?ad0tVJQbMZpMbgXIMsiLOQjqGkGAApn26ztwIcahryfFAHvUrGV5b8Nwg53/?=
 =?us-ascii?Q?Mevc5GgXHj1cmibqPqRkOO+ZpQVFOCQLtf9SsW4+Up7CexFhbvQEe+wC7HU8?=
 =?us-ascii?Q?PvAlDcKbWhNgFdhib2CbZePwXnloXtwQXR4jrXPB0hmal/tP6Y74XY6haEFx?=
 =?us-ascii?Q?BCpAs5jbP6Oy3KgTsujCtAjNJIo9ShcTYdhwhmHjm48s6RV5FZ8kC8r0bx/v?=
 =?us-ascii?Q?QbxaRDW4LRxDl6Gg4UGOMXM7d9inZbcryq+MaNzpW2jTRcom5HhRfFXDm/Xh?=
 =?us-ascii?Q?ZotZlLlc2peE0h8dFMm8FEstDa7Oyg+5TS/MRtpPY9lBfF6NRGqupnd0IEZ4?=
 =?us-ascii?Q?5nu4/9TcJRxg+/un3gLu1pry+c7sdK1/eEl5+DQvo0kGoX6UTJyejGd6DZhy?=
 =?us-ascii?Q?7zow0/N+GmSHBX1kmceQxWEwhnIPmEA3X0o+ukFIYdy5K0QAXMDixrWjwLJY?=
 =?us-ascii?Q?YSVH3CMt5GAEMys5gweJteXlk8MG2U+XJ+TCSStc0yn1O1tZ7cp9pXUPvhqT?=
 =?us-ascii?Q?akuBpYVEDM0mqUXRj7iV6Xk66zzqRlHZe0veVnbfJjtdKtzTKgSDG2KdXUvJ?=
 =?us-ascii?Q?AWxXgNetwZmHbL7TTAxN3Bz9Nn5uRyfQCFD0u6lEWANc04gkIZLtmSz/O6aT?=
 =?us-ascii?Q?b0GnBcp1GKCHMU2Qs2yWCB/DtawUvvkUZsC/W7Pj?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 05:11:17.1452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 197ff4aa-b0c7-4edb-e9b8-08de4698b23d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8518
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

The AM571x SoC has 1 GB DDR space. As part of normal re-location process
U-Boot copies itself to the top of DDR bank. However, on HS devices, the
top 37 MB is used by PPA and is firewalled. This results in an exception
and the boot fails. Set CONFIG_SYS_MEM_TOP_HIDE to reserve the top 38 MB
memory (aligned to 2MB as per page size for ARM32) to fix the boot.

Note: This limitation does not exist for other AM57x devices, but this
config is applied in the common defconfig since adding a separate
defconfig only for AM571x is not justified. Losing 38MB of memory at the
bootloader stage on other devices is acceptable.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Fix boot for TI AM571x HS EVM board

v3: Changelog:
1. Carry the changes in the common am57xx_hs_evm_defconfig file

Link to v2:
https://lore.kernel.org/all/20251128150455.3279166-1-b-padhi@ti.com/

v2: Changelog:
1. Drop [PATCH v1 2/2] in v2 series. There is no need to add reserved
memory node in DT as it is done by U-Boot as part of FDT fixups
https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-omap2/fdt-common.c#L72-L107
2. Add entry in MAINTAINERS for new config.
3. Update commit message to use memory size in MB than raw hex bytes

Link to v1:
https://lore.kernel.org/all/20251128064353.1295063-1-b-padhi@ti.com/

Test logs:
https://gist.github.com/3V3RYONE/e86b3f4551986b0400d0e0f66d6ecc66

 configs/am57xx_hs_evm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am57xx_hs_evm_defconfig b/configs/am57xx_hs_evm_defconfig
index 6e4704470e8..3db30d2397e 100644
--- a/configs/am57xx_hs_evm_defconfig
+++ b/configs/am57xx_hs_evm_defconfig
@@ -16,6 +16,7 @@ CONFIG_SPL=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_ARMV7_LPAE=y
+CONFIG_SYS_MEM_TOP_HIDE=0x2600000
 CONFIG_AHCI=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
-- 
2.34.1

