Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE8CCCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 09:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A195683A1A;
	Mon, 10 Nov 2025 10:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aRKPlkaW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E90C83A1E; Mon, 10 Nov 2025 10:42:27 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 305DA83AA4
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 10:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RD8aEWBH1EuljIe8QxyJxQjz5LunmXPkg87WsjDnisWeohI3sUnG0XxSS+JdsurwQKlXVP3cRotJe94uGoq9bEl46NvCO81BIpOU4X25iLfHJI3uaXRiax9g9YBVpea2FPkbJN1ubPdP3N2t13uosRK+i35V5FkJ6Ny+OMpBiXqcMz5ADf/fQEwlkdX+wpdrIDOZh03fbTIQaPk6ygNJ1jscUs2ICsxEaDdW5ygroGSeWiY2+egVJ/7F1ck0d8CENPVPPHkq+CE+c37m/nACS1k1Chg95wjsUD2cXxfhcAhEC3nz78u/11oQxKOf3iIwn5LLK1pwiecbMi4/gI0UhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNz67oxvMBHnq5F88vmTGqF2JTothu8BydOB7SR2sIU=;
 b=rTMKeO+lYIVDy7E14hpOt6yt6Yy0gS6KwVsR6kuExmd0kzgH7CMnD/79InRvgH8JRcLB9V2xlojDEx30zu8JcpLyfTBTK/rH3wmQTjNDhLx/r5TxqpIjGONi58/Ln+0C/reM43hy5URd6t7h7d+Cjcip2K1STG2zaWeYrU8WSYVZDV8r4dd3cK28502zpr33b5/WGYEBXtV1NoE18Hdu5m6VPmWjq4jaWcHcwEkTSeQ+56tMNlCd0bP1WGXiJNBIyxm82CA4vF3+pwQID8krBFofAxe7HLjE92xWBi3YVMxjrlAymVxwk34Knptv52RKGQTDzH5EHFz7vntvbs8cSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNz67oxvMBHnq5F88vmTGqF2JTothu8BydOB7SR2sIU=;
 b=aRKPlkaWFslNijlgGbvQ8b9IAGBUfMcKvv06QHVJp4a5hlWmplMNtJnpq+gm3IlJsKXs1Jx+eLwDa/wGDE6fMKVZa32pjnIrxiqkhKk0OP3VML4im+gQk3yJZFd+s2y/LsQJlZsAGyQ4xsELTMUBQYMM4sqG9yzivkyGHApQwfA=
Received: from DM6PR10CA0011.namprd10.prod.outlook.com (2603:10b6:5:60::24) by
 PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Mon, 10 Nov 2025 09:42:21 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::fb) by DM6PR10CA0011.outlook.office365.com
 (2603:10b6:5:60::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 09:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 09:42:19 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 03:42:12 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 03:42:10 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 10 Nov 2025 03:42:10 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AA9fit53156252;
 Mon, 10 Nov 2025 03:42:06 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <c-vankar@ti.com>,
 <u-kumar1@ti.com>, <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <peng.fan@nxp.com>, <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>,
 <jm@ti.com>, <m-chawdhry@ti.com>, <ahalaney@redhat.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH 5/5] configs: j784s4_evm_a72_defconfig: Enable configs for
 PCIe boot
Date: Mon, 10 Nov 2025 15:11:44 +0530
Message-ID: <20251110094144.886956-6-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110094144.886956-1-h-salunke@ti.com>
References: <20251110094144.886956-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: a475ec28-9337-4945-dfc0-08de203d710d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cQG+goc+Vx44gCk5bjykHbzt9vIXc6CBHrPMeI9TOvIby5xRIXY6L8HgQByQ?=
 =?us-ascii?Q?ZAYEGAWlH7UoCyPAabhcjhGRowbf6GkqO37nQVptl1G8kQ+H+GxtFDURCgal?=
 =?us-ascii?Q?UcoKDtbRgoDhEUsg1rD/uwiVjp5tNlQCKcahvRUGxGAsgGzJFp12e3/ciDiv?=
 =?us-ascii?Q?P57/UVyIuQHv9McExK+gGeX1ycjZmzX5Ln8ABG0oEQAy98wTMwdBJyBU85dL?=
 =?us-ascii?Q?+31lIiF3mRpuPwPXB7rOZ84FaIleNmVJZnX7+Qotn7cnRWHezdhUsOBJSSOO?=
 =?us-ascii?Q?l5dD7o6nqsY6UnwBlB8AvjlCCdvkLBl/C8djNDlmR5nozJGnmwAPnQfbsopx?=
 =?us-ascii?Q?H3VjxofEFevcMRsgtt4fqQkJJqjuaUdDZr5McIDP++ugcwgrVODhXpLxWT0e?=
 =?us-ascii?Q?lAUQEIiOhDAW0pQ2sU0EeA0No5GhVSn9BMRGNtfx4djaLwa0Lsj435nQvN6T?=
 =?us-ascii?Q?P6Yp7Da3dg8fUH8/7W54cADyNGqvD7uH5XWKw0kKE/neXdWc0pMRTBNfaTC1?=
 =?us-ascii?Q?ejYTdT9raw/I97cgBwJc4L8zuOmE8uh6mLGQSqDilnSKkHezYxFV1TLlwCcK?=
 =?us-ascii?Q?ENQA+f/nh34IaUn9Xg35SYz475UOea1vWsntg6vM1FuWramyo9rhrfoTYMe1?=
 =?us-ascii?Q?SBXNJ5PMdacrOXv3ZE+JMvkmPo9aXzT52cNKDw144hSC8keeMNsnzLJGCX/w?=
 =?us-ascii?Q?brhJLB6djpdZvZXDDK68rXePKxAcoCdEOBHsTyrY/nukNUid/hlnRrWKxS7u?=
 =?us-ascii?Q?GIx0ocNwmRep42k+8Yd3YIx/ALF/n98iqbmyXXIz9wrFV2DwQ0AHJkyoY2mV?=
 =?us-ascii?Q?QmnSSEhJ5J9lBlVkYBIjX7kXK8nQu5S0TiIr+/AHrSGthlc2/WnuV0uLLgKU?=
 =?us-ascii?Q?D3v0PZdYDj9v7ziuNZJxIEpJiiWHwgUHZiaJ/QqMnae2f4VrlkXoWe1DFQSw?=
 =?us-ascii?Q?0ieYiQv81I35KfBROkj9f8qQVspnHprclJxNBzHubgXdVktHqxayCzZ134HF?=
 =?us-ascii?Q?23W9HPr645P0jnCIzCb1Vdk1qL4PNMN8jr98dtMwYKkcU2HgtlZpxkVCxOgc?=
 =?us-ascii?Q?IYWR3l9oU++bweHHbbaETJdhPv2ZQJFSmc+mc9YPocmtb5aXB5oBGtq/QN1e?=
 =?us-ascii?Q?q6+2yEzqci+fazVm3TBQpqFzHaJRMhzEEkFMQyrld28oK9Ma33kW13uanzwy?=
 =?us-ascii?Q?1WwZ1p/W+xirFkWoErbMa1Z6E17tWqwoPlEYmW76aD4k+jLNU085cIBCdw7A?=
 =?us-ascii?Q?cg8pbCYawSf8DAHvlJxv1kpZpsZvo7AYfAW76NJLO9cCOBBTrtEjgBrIpDUh?=
 =?us-ascii?Q?a7EeNnthn9teUaoLVxo/ZdO3iIoC6mAQM2qkGnO0KUsCzX5jayzlb63oyS2i?=
 =?us-ascii?Q?tndVgbzUNWIFj2Gm0z/y3InTjHFnGGJRy86ghj6amKj0opB6ogXkjPoxSdmE?=
 =?us-ascii?Q?xbpYZRjtNlAwYx72LZtzqhstJ+AGltFQpZ4FugfCc/1RieVdbZFEXDEhZc4q?=
 =?us-ascii?Q?gWyI+FZao6yj1fv5kx05WgrI1BJ14Nk9UImi6fYyz7DNUj3bW1NGi0V1cZgv?=
 =?us-ascii?Q?R29Qpnw/FtnyT3GA96GUCbVVuMSqRhhKNrov1jdI?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:42:19.4142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a475ec28-9337-4945-dfc0-08de203d710d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
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

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 configs/j784s4_evm_a72_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index fc7acbae694..f3c23470295 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -46,9 +46,16 @@ CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_PCI_ENDPOINT=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_PCI_DFU=y
+CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS=0x81000000
+CONFIG_SPL_PCI_DFU_BAR_SIZE=0x400000
+CONFIG_SPL_PCI_DFU_VENDOR_ID=0x104c
+CONFIG_SPL_PCI_DFU_DEVICE_ID=0xb010
+CONFIG_SPL_PCI_DFU_BOOT_PHASE="tispl.bin"
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
-- 
2.34.1

