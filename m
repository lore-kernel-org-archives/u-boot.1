Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB976E6816B
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 11:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C06F83DDD;
	Tue, 17 Feb 2026 12:22:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VrwZ47Mh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1715F83E21; Tue, 17 Feb 2026 12:22:28 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C713683D8A
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 12:22:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VU5H2jcKMjd2E78QWs+v2S9mq3SQ3Y/vZPXqb/QeAzmo58E+l3h7gfotHiuJOydq/QrkiOia1vkCBEAN2Q8Wh6nflsQVTmLYjlb2xJ9E3P5iNz/3aDgQn5Kn6hOuhWJlXgJ95M5ctS+t3g2ErJzmvMS+9O0KwVL31yzqxiDDwWg+XmTCa+O/MyBntiEsAoUOOCuIprbg5IN7yO/gWEY39LmaJOeQ9ce4pOYwXzUDBhvyzmZbSvE8DQwXa4vXbU+IabKFVWb7LG4muk8pPOg4VPcz3rWGcUp5stexvR+sFaa/9UpRk++eFbb+xOTZhzqYbSbZNxxcM54dk/CMCXYjQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MiqZ3Vyb0Nq/aocg77nO6pyuPrtWKd1F+klEsryafM=;
 b=Sz8u6TnCL+qLWSBJfec0lvW8fZrGEMPLQfoqLcieCR2098QZo9fY2L2pixgIgdVbN77+3d3aD0vTvButR2d1ujCG80nGyz2WCSDFN1QaIho9jrM4wdCoyFb464jVjCkfBlgz2bQwqcNLeNCjJIFInbUOsV7lNZ94FPT2jfc+p6By//fJxTXrVtjXVJMmqymnfnM9WmGoSnJJof1NbxKKEU6JgOeVtjNgEPYnsWPswOeHGQa31TEMBsWfgf23M4WhERE7O/rZDA6JcOaKI7Eads3UjEWHGhbfw7pMh6FLGnRFnjh0PF8C5tQYIPM4TEqPkNerA8B2w20AwMkaajKvRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MiqZ3Vyb0Nq/aocg77nO6pyuPrtWKd1F+klEsryafM=;
 b=VrwZ47MhqxaIEZVTBoYEDO0fl5WWd9w79lhLOnnI04xP76IpQ5eu85W4zq1aY0ML2ypjFlv1xVXDUkA3MUVk95I1751Ds7m2ehOj0S4YUalaX8/fg+Z6+SyCdSYsSECrrDh6cyVZLZ7y0T1lTCXkkzMXtltFXBJRc+BpqymRLog=
Received: from BY5PR17CA0014.namprd17.prod.outlook.com (2603:10b6:a03:1b8::27)
 by SJ0PR10MB5664.namprd10.prod.outlook.com (2603:10b6:a03:3e2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 11:22:18 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::78) by BY5PR17CA0014.outlook.office365.com
 (2603:10b6:a03:1b8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 11:22:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 11:22:18 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:22:17 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:22:17 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 05:22:17 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.51.206] (may be
 forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61HBLutR3263329;
 Tue, 17 Feb 2026 05:22:14 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <jagan@amarulasolutions.com>, <trini@konsulko.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <boon.khai.ng@altera.com>, <a-dutta@ti.com>, <s-k6@ti.com>,
 <gehariprasath@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 5/7] mtd: nand: spi: Enable spinand build Kconfig option for
 spl
Date: Tue, 17 Feb 2026 16:51:54 +0530
Message-ID: <20260217112156.272154-6-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217112156.272154-1-a-dutta@ti.com>
References: <20260217112156.272154-1-a-dutta@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|SJ0PR10MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9f548b-6384-4053-193b-08de6e16cf8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?usn1Pg5lLcRs3PTI9wLMdHUkb0juGSEyOMKpzKi5eXREaVXCb6fhJF41oOxV?=
 =?us-ascii?Q?ebmaKKAhptOfXgMuyHUrzrLtCQs1R2niUZqPJKTsRCvSEWgfWOMrrzHec1Xs?=
 =?us-ascii?Q?XbGuPHqPzAU0O/tbM1fO4sTb6cnt/QqZmzrTC+b4GZKgj2DQuNjq3qcr34/A?=
 =?us-ascii?Q?16uLYjF5h3it4P9GPj9qVc4vWH9niYHwXDtdlULLdrCRXvDkJYSO4bhUP+zb?=
 =?us-ascii?Q?nYl72bYTwmZVP2GmcAFaHdPsP5nCOiCXyf5Ce/10DiDoflJdxBo3vDopBYRU?=
 =?us-ascii?Q?Pcp2z3Ta87Rck4jIKfv87hF4TVz3YFddb7hIZ9VKwqKDkCh30WpN3xLI20tr?=
 =?us-ascii?Q?vLU6CFr2r29930eXxxQ0gx7utGDR8bssFcL+onLBGHcrx+OxQRutzELwD9wy?=
 =?us-ascii?Q?O81wvVgLqPDivI2p5vHs6LN9tEvX0+WyhZfDr1LGsdfxjWjTe72Nq9uCpaDb?=
 =?us-ascii?Q?wLfiJtIkF1whrENblUNOtJbqbCNfzPpmxwgZ96Tkq4VQNmiwa2gF7I0GTyXP?=
 =?us-ascii?Q?yH3AwISjy8RuqkV+q5nLn3LiuOODDYpm0YN+TnA+NMKb39MSUmggG7Wyh335?=
 =?us-ascii?Q?yEqp95L1QgOJ476+Nzpg3YcfUL7hKlmCAkIW8G+S0aXWvEuvaXMvZNDArhHq?=
 =?us-ascii?Q?4ePu9T0hIXf+NPNKN7MLBIDfv8C7X6bV3/mqGN8UlvrEvo2vWl25L3CYQ/59?=
 =?us-ascii?Q?djSLvGmb0HtlQDl3bTKUnnw4TrIoh7iERMEunzV4AliHIII8G1pB78moOY3L?=
 =?us-ascii?Q?o6F0S3ekpFt3EBcHvkNZMQM2jWjOqnwFP26eueUercNgHd0MaGFiXAVf2puc?=
 =?us-ascii?Q?y0A+1UTEedeEonmA7C3age/T0YuO+vLFFrsIEygCfhkGdmEBg6/hqcJzPKbA?=
 =?us-ascii?Q?Okczre7vvR6kVc8XOCcz4DrGhM1NyPBcYgxmlUQ9RJpoWbVfHKpFRC8YUYbX?=
 =?us-ascii?Q?bebQS60adkVr/St1hbeTulgFKszpwng/X/qCCJz/I3nGAnFFbYGkEtese1F7?=
 =?us-ascii?Q?bjuCc3KSw31GlNemlLmQ67ut8BgvyfOgqYQH0SPsOUYEIGGqx83/zruhq5Lm?=
 =?us-ascii?Q?hOvaLGM1EbZ7U+HA5+oumGpmPyJuWfZkectKlj6hPAHhG7pySc4B62YHpVYp?=
 =?us-ascii?Q?NUqn6IFaXk9N3lDQogTitpnfHU74DXgn1b6XOD24Q3H6Kt9mC7uhxwNDbC46?=
 =?us-ascii?Q?TGCd0OaqEc/eirU/lKRjyNnOLo73oGjKfCD053P1Fbgt0aGc8ZCrtAOplDFP?=
 =?us-ascii?Q?m49Y7bnPP6VIbcox7l1/toA3Q2U87SI9j0PBBCK7uhRBsXrgzJuHvF6QFxxP?=
 =?us-ascii?Q?gXAh0Zl5NjUKdcgHz0V7kQlHduOv39hcLcJEn4vCInasrsFIejOMCdKr7qPN?=
 =?us-ascii?Q?1H/1WCzauTsX1mR0sBrvdfbUgYcyj171Y80insCGisAsinisgQc0tc19jj/D?=
 =?us-ascii?Q?HJX7pmVr4qeXLpi6wsfLFh9jpprAYGwNCYTVg1+oWqqVjw5v7JC/vQi7dzn/?=
 =?us-ascii?Q?zA/nkb5aK46no8vkaR6cMYOqz++1IVCkDuRAqfX5CmJq0zhZcJhxh64M3Im4?=
 =?us-ascii?Q?FPFa1ynwxXO3SkDluitDMI65xBTah72U2MbHRXU4HKvM3dLzfmx/NXLOC2pb?=
 =?us-ascii?Q?3qaY30GWCDmhO7rWYX4esTGk2F11O7Z9vRBpGIDh5S1EFE7iHUpE/uy4tipP?=
 =?us-ascii?Q?Y7677Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UP4EfusF5BJGN9HnGfS0CMNY+XK+7Y2l/LbXC9Ie4BcPNwpZxJ+QcWrK+dq1PRpKAoU6xvSL5hTM+tq4V+qBPP9VVAvpuoXSWo5xgRkqvb2XwrV5G4C6dc5kOjIylvo9RxkaUpXF9bn+8GSv3BhEH0E+xghllt94Bv30oQiNxNbGJOzwE2yeBGY5EGHtPOaJDvrzviEU6HUSR9EDaHiWSsgXmm7F3NtXe2XLXcAamTAVd+OlCy8MzPn05nbSUHgaUkpbuw/ysxLjsHKGeRYUzLHDRGTybp8NPGrJ+ZarZOVpxe5ap0WlbwXBzx70kfIA10EAksezWrVRuOetMPgSRz2qGhYz6VAB7fj/Q4ukMdtOENZ2YK4cBFBs1DjdqBshuk6peLABvc3bz1/cY6x7+Nc+AHu12KL9FBy59+MjRg1GhcaPNr9Vvvj6EjhgdSg4
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:22:18.2432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9f548b-6384-4053-193b-08de6e16cf8e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5664
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

From: Apurva Nandan <a-nandan@ti.com>

Only RAW NANDs are supported in the SPL, so create a new Kconfig
config for building SPI NAND subsystem in the SPL build using
SPL_NAND_SPI_SUPPORT Kconfig option.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 common/spl/Kconfig        | 8 ++++++++
 drivers/mtd/Makefile      | 1 +
 drivers/mtd/nand/Makefile | 3 ++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index fb167933c60..1a28eb257dd 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1071,6 +1071,14 @@ config SPL_RELOC_LOADER
 	  to temporary memory, then copying it into place afterwards, then
 	  jumping to it.
 
+config SPL_NAND_SPI_SUPPORT
+	bool "Support loading from SPI NAND flash"
+	depends on SPL_MTD_LOAD
+	help
+	  Enable support for SPI NAND flash devices in SPL boot flow.
+	  When enabled, SPL can load U-Boot from SPI NAND using the MTD
+	  subsystem.
+
 config SPL_UBI
 	bool "Support UBI"
 	help
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index ce05e206073..a1f9a1ddeda 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -35,6 +35,7 @@ ifneq ($(mtd-y),)
 obj-$(CONFIG_SPL_MTD) += mtd.o
 endif
 obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += nand/
+obj-$(CONFIG_$(PHASE_)NAND_SPI_SUPPORT) += nand/
 obj-$(CONFIG_SPL_ONENAND_SUPPORT) += onenand/
 obj-$(CONFIG_$(PHASE_)SPI_FLASH_SUPPORT) += spi/
 obj-$(CONFIG_SPL_UBI) += ubispl/
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index c8169cf7390..44cdf8ac1b2 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -1,10 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
 nandcore-objs := core.o bbt.o
+ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
 obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
 obj-$(CONFIG_MTD_RAW_NAND) += raw/
 obj-$(CONFIG_MTD_SPI_NAND) += spi/
 else
 obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += raw/
+obj-$(CONFIG_$(PHASE_)NAND_SPI_SUPPORT) += spi/ nandcore.o
 endif
-- 
2.34.1

