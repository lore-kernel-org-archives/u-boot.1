Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54724CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 09:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1015283A1B;
	Mon, 10 Nov 2025 10:42:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JAsJmbXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7375083A3A; Mon, 10 Nov 2025 10:42:12 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A260839E2
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 10:42:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRD+F0b2B9Ddymit0Rmekrnq53c06cIDpSFGxXQ/PPHsDdIHog/EAEvK1wPh69vKr/wLxEBIiahjm+Ts+a/a7FXYXLBmEsbweJqJcQHixJN1uPw6LEljEeVfpylDfKcp2CQMgFqa5ZWNhnlWitsuZLB3pkAxvCafm2r+kjsyxs0GhEJoA0SUgVGLUXNMrWQs+4r/7ThOciUPkKN5YSVv+cMFcosMbyAR4OJJPelI+ArfCTFqjlbieI9IkuEowCFH8T/IXWRK/HXIH2PQHbBrb8B6lBv0Qzx5DRzKKu/XtgY/+ZCRH/M0XrzRacy6VtBLFdQg0p+VHIp8y+GL5qx2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSjLxAR27zUeRfE0n78SVZwvssxPVjl14YoZXly+c6s=;
 b=nEKhpX9PbTygChdgEs4uHBH+HDyJqOW3+L/NxmST17HGFUsoqL5g//kgW/ZfUBncWl0VePkInL/ifkbENx9HZCAyDjkLfKfs0ees5bjDaNEciVc4zCZcyyWSf0iHpzx3DjXl9fzSySa1AhxwUJ7SQfCHDIjcfi/Yu5ark1BJQ3mM7ZbtFldCMsxYS8BOj9g43aDqVy7dMwbV8B4cyoDkx2K8qHgzrKtL8SrV+7m9laQ9bpyeRYoUEVAwC+imX/J/sx55CQ76tV/b7gzlaPf2dFHxqm+yqzHilfIVwx0DhmG7TyJ+FnsiA5cNqmc4OM8d/kdT3X3r/DDueqT/UQI3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSjLxAR27zUeRfE0n78SVZwvssxPVjl14YoZXly+c6s=;
 b=JAsJmbXG6n98Dw9G1hTn+od5eBeT0p4W0FhnU6XEskYTptzkosrCp79oiLfScVYbbDiAYEnR8s6Xtds2KQgGREuoSYFTO6yQc8mYIQrSFVQjE5VYYOeUKym0ug7KTjuD0275cpib2t8VQejqh4P7IoN8FKepxjlUKO9VhC0naPM=
Received: from SA1P222CA0125.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::19)
 by MN6PR10MB7443.namprd10.prod.outlook.com (2603:10b6:208:46f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:42:07 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::73) by SA1P222CA0125.outlook.office365.com
 (2603:10b6:806:3c5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 09:41:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 09:42:07 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 03:42:03 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 03:42:02 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 10 Nov 2025 03:42:02 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AA9fit33156252;
 Mon, 10 Nov 2025 03:41:58 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <c-vankar@ti.com>,
 <u-kumar1@ti.com>, <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <peng.fan@nxp.com>, <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>,
 <jm@ti.com>, <m-chawdhry@ti.com>, <ahalaney@redhat.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH 3/5] phy: ti: Add config to enable J721E WIZ SERDES wrapper at
 SPL stage
Date: Mon, 10 Nov 2025 15:11:42 +0530
Message-ID: <20251110094144.886956-4-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110094144.886956-1-h-salunke@ti.com>
References: <20251110094144.886956-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|MN6PR10MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f0cde9-aa94-4c68-90b4-08de203d69a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GctPBMIX7GRfQzurmCdtxDixqyRFGl1ic7kQhf4kEZbuKQ8q6pdVUQhBbCoT?=
 =?us-ascii?Q?GRvnpBCgYVjEMFScuSL6ZqZ+xjaKE51rwd8qM+3i9lxvmmPKvR9WE0kPlwTm?=
 =?us-ascii?Q?zBilKeEX/3jjZP5wNm3gN30AQVLVEgDXpF4bbnJXdy7Ex7mL3yJli2PoJfXp?=
 =?us-ascii?Q?C1J+7VcJWCPNjqPV3guCfNU2tGSc5hFY7V8RDJVhYydWNMop5pbRatDOrS60?=
 =?us-ascii?Q?aanZFKVkl4dqE2aLeQ7Kh1SCi6mRjcOYBTtp0bbwOG5v2IegJsOpX8FmwI79?=
 =?us-ascii?Q?nRsi+ZsB+eqFP7Ia49uY0HwDooLl5vAbtfbyUAPjMd6vbj+rqypkyXqVxUyu?=
 =?us-ascii?Q?YNS36Wl4Su6S7GYP28J5GAEfMW/Df2rKEs9FFjtMziA2Iohym4VdtV9ZpTVo?=
 =?us-ascii?Q?q6Ftfz8ZR7x9VzIczjkgJxy0ItB1FTfZBR94PyLSy0I/3vkDcCJKAXB7cUU4?=
 =?us-ascii?Q?7wEaOuaHRhqO2aT9BKDIPYR86WQWtF4FYl6Ro5173eJryb4xLQM98OMBQD0O?=
 =?us-ascii?Q?GL43DJdXMwUjxTeZsC+7xiD43pRFJ5sEpbhsQ+eIPSEYiHT6wIBPglKHuIMt?=
 =?us-ascii?Q?zo9CuziSZCLXHbrFgFq6+qALwakS86ZVvi21s5/MmkvwOKDwuN0+h7RaSzeG?=
 =?us-ascii?Q?PMEaUGG+a5lzWLrWN/En/hmkH0uODQpcgJrcALPrvEo619UcTBPZ1FwoAAFT?=
 =?us-ascii?Q?B6OVGbU64rJP7fQAFm5Y7LOqX21VVniBWmbStiWGr1DnjEDKdi8I/s4FU5TA?=
 =?us-ascii?Q?CG8PqsBGFZVEhWqwTK+zpwu52r4+Ag0SibXkXq9t84gY1/loaBbfUYx8ASlT?=
 =?us-ascii?Q?ir+470WJJL7T6nsyQ5kAtnjTY23QYL9nOBXEfP1h2ljCsVdkIX5nFD2Fi/7E?=
 =?us-ascii?Q?tZQ9QLvIk9bIjw4g9PExv/uAQE2XLXnGX4GaWmlg8SVAoI12EWt2zdTOjQVV?=
 =?us-ascii?Q?4m64GaVaYEEbgAM6rxiWzKa6pJAVEdoUsZFH0DrZbIfbiFTxNyeJhVRJngIY?=
 =?us-ascii?Q?DvOmoDC5izTFRSmhg7OHkk/BG+BtJN4SPyhnezT34TH853OpayR7kQxlCEu9?=
 =?us-ascii?Q?5ILkSOIXfqjdseEbIIfr4jFmU2Piul74MIXGNHjVyld0RIObfOn/EBEIrSEs?=
 =?us-ascii?Q?ka3EaA73JJig9t5SOrWtaYnzVpFeV0fV9/tGycHCYkZ3pCP4X9K/bja4AJxQ?=
 =?us-ascii?Q?vcMV4TP4QoDgDN9rJ9tCYv5N1DrxmUjBgIckqgFtE20VRrYjIiBuNkF4i62M?=
 =?us-ascii?Q?Vz/xtYgr8kUOYl/z8RHmJwqwjSsLvy0qNUTrB6p6SeGyRnpYlrMqkwD96ynE?=
 =?us-ascii?Q?6fS1GuGQnua0lj2QmLwUEF/xQJP78pVxWTWuB7WQm9fsteXj4A/t7vQWfWbU?=
 =?us-ascii?Q?TOcaav6pulhkrb6x8V8+sAXH+nbkjWyGhXIAaEJ8KSIjCSFJhuH/pmjQHuHt?=
 =?us-ascii?Q?F/U0KEuCLnMN2a5/YJHP6uEKEYMVSLk07VlUzSDlLhqRVPz5SYHRU8dAe071?=
 =?us-ascii?Q?usHAejQF8eF2WiAefO8h7sgJ1hSxX8SWj2Tk3BLm2i2pdbSvLsfn9plI+rBI?=
 =?us-ascii?Q?/AcQwRZdyHCWrEEDrQyC7rA6j9TmkDoBD/vo6geW?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:42:07.0054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f0cde9-aa94-4c68-90b4-08de203d69a5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7443
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

Add SPL_PHY_J721E_WIZ configuration option to enable the WIZ SERDES
wrapper driver in SPL stage. This is required for PCIe boot support
where SERDES configuration must be done early in the boot sequence
before loading bootloader image over PCIe.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 drivers/phy/ti/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
index 111085f235d..bc52a4992fb 100644
--- a/drivers/phy/ti/Kconfig
+++ b/drivers/phy/ti/Kconfig
@@ -7,3 +7,13 @@ config PHY_J721E_WIZ
 	  signals to the SERDES (Sierra/Torrent). This driver configures
 	  three clock selects (pll0, pll1, dig) and resets for each of the
 	  lanes.
+
+config SPL_PHY_J721E_WIZ
+	tristate "TI J721E WIZ (SERDES Wrapper) support"
+	depends on ARCH_K3
+	help
+	  This option enables support for WIZ module present in TI's J721E
+	  SoC at SPL stage. WIZ is a serdes wrapper used to configure some
+	  of the input signals to the SERDES (Sierra/Torrent). This driver
+	  configures three clock selects (pll0, pll1, dig) and resets for
+	  each of the lanes.
-- 
2.34.1

