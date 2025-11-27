Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72AAD11183
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 08:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1469584335;
	Thu, 27 Nov 2025 09:59:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zyF6ujXs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1428B84337; Thu, 27 Nov 2025 09:59:48 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6C5A84303
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 09:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V18WS+ESx20mEWvtBs+AJP4k1hGPeXrofMMQ8WiPkNAQjIpAZMMy5XTPWrY3yoNYMDRXxpsFTbHIn560aLVNifKi6SBYTSjdXZVqxtUBD8jayu/CL/NwG1P+iceHPAMavIgkBa6/I9sQCHajnp9h7K3k8PcpzQWbOr1WfF5fE0PWiaix17JjQeynxfiCNsbmUZTVylXWOIgDttdc7lwzIxsBh59LNBDjVNmRQPECiRuh1FeUJcAKeaCmboB+XCMrtZlDe+VlkZ1GKBPbr6bQKAWdGfqE32QWQu4AadDT1lAo++D/lmCggolB9fCdrF/62WePa6/zXhXofHXdSl4F8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZolHPZ0fL+b5tu8ys13rgvTr0WRtHfZF7FyOzOw19zM=;
 b=PsXZ/GdwJpWGrgLEFk5zDAmemxrK3dd/Dt3qu3/RnDNfvPFGK6pCSzEwrj/Ac7OQ2fXwAissDUT+bAxyRbuvurcNTOm+z27O5HOkw/0p9nEfcMP5JN2JI/jBQsxc+LFbLJdvi0X88hYDiFdGTAf/bgWMc8pECzzxDT1YulyhFhyTiJM4q8iWWo56pVy719pK4Pfi0E2vVJDXt/D4dxFXCUfL3nUC5LLkTdx2gVskn+Ed5I7MebI5+WN0k8wjGeiJfRWySpjZQ17L9bkpCU/0iyADz84LdtwpVVJ+NgvQFys1+amgc/mdJEScnWg+BIETLAlEd9mD1ez26QLI0R4ocA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZolHPZ0fL+b5tu8ys13rgvTr0WRtHfZF7FyOzOw19zM=;
 b=zyF6ujXsHdwYHHQ1Ij5ZTP1S9TlErGN+tBb/82MAPgxn3incMDawLQeB6QrNTNx2Q+KRNvgebcgcnbM3DNXnW4gw01t9sJuwsyNih0P0oVMGkuaBjx4LtBl3TbUhwutXV1RZlk06G8X0C/YcRQBu+v4HOgmcjCSJ0z6vMPE/vWM=
Received: from BN9PR03CA0202.namprd03.prod.outlook.com (2603:10b6:408:f9::27)
 by CH1PR12MB9622.namprd12.prod.outlook.com (2603:10b6:610:2b2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 27 Nov
 2025 08:59:41 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:f9:cafe::dc) by BN9PR03CA0202.outlook.office365.com
 (2603:10b6:408:f9::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Thu,
 27 Nov 2025 08:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Thu, 27 Nov 2025 08:59:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 27 Nov
 2025 02:59:38 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 27 Nov 2025 00:59:37 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Andrew Goodbody <andrew.goodbody@linaro.org>, Boon Khai Ng
 <boon.khai.ng@altera.com>, Jagan Teki <jagan@amarulasolutions.com>, "Naman
 Trivedi" <naman.trivedimanojbhai@amd.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Prasad Kummari <prasad.kummari@amd.com>, "Senthil
 Nathan Thangaraj" <senthilnathan.thangaraj@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: versal: Get rid of xlnx-versal-power.h from bindings
Date: Thu, 27 Nov 2025 09:59:25 +0100
Message-ID: <a0f0154ef89929517c3217efe025e8021a910b90.1764233963.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4458; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=VZg7nQIADGBBGUxL9Id4s1pzHBrbbyjo4boRFKcrMJY=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRqCH0yb1gSrpbRIRQ62z7YMVSx8BDT7bl/Vu/dl+d9m
 a9PNCmlo5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACZyx4CR4ejkG392ps+eZ/G0
 1Nwrx1N+V+rNOweO3JlxVlB6aTv74+0M/0xa0jZNvdr17fusbGvGZNslUefOqAVPXuRS9PtUync
 RDkYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|CH1PR12MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf21f62-f4ea-4ec2-eefe-08de2d934c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FzcRuQVL+utkCbICgohhA7rf2f7bdmjaeoP+37BtK2sj4nborMNk8+RZ9ln/?=
 =?us-ascii?Q?G7KAdCyvxs8QzP9/+qh2xpFErdUFfl7bf40C0PQRmfQsvZ6DTCCWvkF5dZbI?=
 =?us-ascii?Q?N2dDXBKbUUoeTdFN0yn71MWMG2vMUMbB2o1kW/SRu21kqt442Xy7TPPTY5yA?=
 =?us-ascii?Q?JYP2/A4Z+7/KeH8/XPKV+ZoH4iJ03BFrzfQ1/TNuTLTaFAcXVNtOQ3U5ntNZ?=
 =?us-ascii?Q?CHX1mrZHTKRInAwXHBMmKCYkXVIwwwBUD9lDUbqGOTmzEldHH3ekryKbQVod?=
 =?us-ascii?Q?aQaTiP/Bn+jAFJWaoLcU5B2mQtdDmZOsxAz5Q2UKjlq6ExD5qYCwnBEZNNDx?=
 =?us-ascii?Q?jMzTSkv1+Nf2yjI/EYJi/fg8TowdvJFVZJlJZUB/oQznkkOor/8k7YFoYckf?=
 =?us-ascii?Q?PPUEKXNiqOCvmkE4GHdfW2nxV/FGRAab+m7LdRKR4jDt6NE/Sp2k0dWjsj1t?=
 =?us-ascii?Q?o1Ca0PGc41NrYHYZnQh8+FPAorHH38diDTqacRk5drf4m/Shfx3lUgRXsF5Z?=
 =?us-ascii?Q?VIVFLE5P1evDOvZmzdqjPlUNcu7zt4iYSbPPclSSav10x6BJ5L0+50TR5m1J?=
 =?us-ascii?Q?YvJbFgeHTDMAkX+VwOkw7fp3QfuO5pCjF56vFHhCo42/1SRm89+yEi+Z3LsE?=
 =?us-ascii?Q?o6LgcEls9aM1eg14jGbUpxb91AqnRQ16neiRDpgScet2kVr/I8RqrdKpQqMG?=
 =?us-ascii?Q?DmO9UHOEg2vzxo0Ox26Psq1zDXCmI12laCY1M6Qxkr7Z4IAnBEPVTLUd9TzM?=
 =?us-ascii?Q?p0vb+Zq+NT5clrSJuTjarbonC14GyPMEsYy3iR0EGuq+oryNb90esphy3BzV?=
 =?us-ascii?Q?Vv/986f6RjQ4xoPQe9kIyPt2S4yETS8JmH1mdz7E9D3CglSipzRze31pnoSW?=
 =?us-ascii?Q?/haR1ERPhWIoh0X5pEIL3ZcfvLI7+DH/LPmEDVvbdj8jLDLQ1JFNWU845hIB?=
 =?us-ascii?Q?kmJrbMQ4Gxwul+P6td0TjoHx5ESolIjrDQkd64tJzYGvLImDbGAydubOvSJi?=
 =?us-ascii?Q?jlPZh6mnNYihW4uCKT3/y44zBZEl2begakNLKo3Vi0RvydQ45p5mpBJ6rQWQ?=
 =?us-ascii?Q?2EHJw0BI2305s0mZ25dCy1HSlquRp0QvqIIAlL3U3qubTqSpdNS+x9eZk4HN?=
 =?us-ascii?Q?Pu+o4BP0EzWU4XMxWO9exOE7kPsEFH7zWmje7ESSR5EGYSB+SBkPT7m4exTd?=
 =?us-ascii?Q?V5gw0cODb8Tylxz/DN9jmr1J1kHjv5c0CQ1mjUROEgz1+9L6C0s1HUt1ggtp?=
 =?us-ascii?Q?e00FN4cjPkPmLvcxQZ5PH+PosfqDcS0W8wQ3bl8OZz7//5MMXyM6SSKSrBc4?=
 =?us-ascii?Q?craxb3ZqlVoUdEL8mehnxmN+au9ppjmB/X5KleItWg0KOP8XBFLjVXhCF7Az?=
 =?us-ascii?Q?UBDg7WFRQlNvISUEhWcshQKdGly0tKFqx4kqNw3+v4kIZ+D04Fmpv2TIYefc?=
 =?us-ascii?Q?veQjCMF4ZODBj3KOK792Q03iUC5eVGqOMDOTlQGHiMktaJjY10AUt5lUO3YB?=
 =?us-ascii?Q?ayovqrfAcogBoDTGCvd8O3m6pCH4QwEeQW4bRx9FRX1b5YMY07fXLJcn4UTa?=
 =?us-ascii?Q?ISSFlUQnlTxepHOPStg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 08:59:39.2322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf21f62-f4ea-4ec2-eefe-08de2d934c0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9622
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

Remove xlnx-versal-power.h dt binding header because they should be moved
directly to folder where DTs are. In the Linux kernel this shift already
started by moving xlnx-zynqmp-clk.h to arch/arm64/boot/dts/xilinx/ folder.

U-Boot is using only one PD_DEV_OSPI constact which is moved to
zynqmp_firmware.h header. But handling around it should be fixed anyway
because no driver should be calling xilinx_pm_request() directly.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/spi/cadence_ospi_versal.c             |  1 -
 drivers/spi/cadence_qspi.c                    |  1 -
 include/dt-bindings/power/xlnx-versal-power.h | 54 -------------------
 include/zynqmp_firmware.h                     |  2 +
 4 files changed, 2 insertions(+), 56 deletions(-)
 delete mode 100644 include/dt-bindings/power/xlnx-versal-power.h

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index e3ddf127e5a8..a00642d09d34 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -15,7 +15,6 @@
 #include <zynqmp_firmware.h>
 #include <asm/arch/hardware.h>
 #include "cadence_qspi.h"
-#include <dt-bindings/power/xlnx-versal-power.h>
 
 int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 			      const struct spi_mem_op *op)
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 2d2469565b5d..d1404e13810a 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -20,7 +20,6 @@
 #include <linux/time.h>
 #include <zynqmp_firmware.h>
 #include "cadence_qspi.h"
-#include <dt-bindings/power/xlnx-versal-power.h>
 
 #define CQSPI_STIG_READ			0
 #define CQSPI_STIG_WRITE		1
diff --git a/include/dt-bindings/power/xlnx-versal-power.h b/include/dt-bindings/power/xlnx-versal-power.h
deleted file mode 100644
index 51d1def67739..000000000000
--- a/include/dt-bindings/power/xlnx-versal-power.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  Copyright (C) 2019 - 2021 Xilinx, Inc.
- */
-
-#ifndef _DT_BINDINGS_VERSAL_POWER_H
-#define _DT_BINDINGS_VERSAL_POWER_H
-
-#define PM_DEV_RPU0_0				(0x18110005U)
-#define PM_DEV_RPU0_1				(0x18110006U)
-#define PM_DEV_OCM_0				(0x18314007U)
-#define PM_DEV_OCM_1				(0x18314008U)
-#define PM_DEV_OCM_2				(0x18314009U)
-#define PM_DEV_OCM_3				(0x1831400aU)
-#define PM_DEV_TCM_0_A				(0x1831800bU)
-#define PM_DEV_TCM_0_B				(0x1831800cU)
-#define PM_DEV_TCM_1_A				(0x1831800dU)
-#define PM_DEV_TCM_1_B				(0x1831800eU)
-#define PM_DEV_USB_0				(0x18224018U)
-#define PM_DEV_GEM_0				(0x18224019U)
-#define PM_DEV_GEM_1				(0x1822401aU)
-#define PM_DEV_SPI_0				(0x1822401bU)
-#define PM_DEV_SPI_1				(0x1822401cU)
-#define PM_DEV_I2C_0				(0x1822401dU)
-#define PM_DEV_I2C_1				(0x1822401eU)
-#define PM_DEV_CAN_FD_0				(0x1822401fU)
-#define PM_DEV_CAN_FD_1				(0x18224020U)
-#define PM_DEV_UART_0				(0x18224021U)
-#define PM_DEV_UART_1				(0x18224022U)
-#define PM_DEV_GPIO				(0x18224023U)
-#define PM_DEV_TTC_0				(0x18224024U)
-#define PM_DEV_TTC_1				(0x18224025U)
-#define PM_DEV_TTC_2				(0x18224026U)
-#define PM_DEV_TTC_3				(0x18224027U)
-#define PM_DEV_SWDT_FPD				(0x18224029U)
-#define PM_DEV_OSPI				(0x1822402aU)
-#define PM_DEV_QSPI				(0x1822402bU)
-#define PM_DEV_GPIO_PMC				(0x1822402cU)
-#define PM_DEV_I2C_PMC				(0x1822402dU)
-#define PM_DEV_SDIO_0				(0x1822402eU)
-#define PM_DEV_SDIO_1				(0x1822402fU)
-#define PM_DEV_RTC				(0x18224034U)
-#define PM_DEV_ADMA_0				(0x18224035U)
-#define PM_DEV_ADMA_1				(0x18224036U)
-#define PM_DEV_ADMA_2				(0x18224037U)
-#define PM_DEV_ADMA_3				(0x18224038U)
-#define PM_DEV_ADMA_4				(0x18224039U)
-#define PM_DEV_ADMA_5				(0x1822403aU)
-#define PM_DEV_ADMA_6				(0x1822403bU)
-#define PM_DEV_ADMA_7				(0x1822403cU)
-#define PM_DEV_AMS_ROOT				(0x18224055U)
-#define PM_DEV_AI				(0x18224072U)
-
-#endif
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index 72f6459b91c8..05df49f292a1 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -527,4 +527,6 @@ extern smc_call_handler_t __data smc_call_handler;
 #define PLM_MODULE_ID_MASK	GENMASK(15, 8)
 #define API_ID_MASK		GENMASK(7, 0)
 
+#define PM_DEV_OSPI		(0x1822402aU)
+
 #endif /* _ZYNQMP_FIRMWARE_H_ */
-- 
2.43.0

base-commit: fd7564ce2f51d965c273e939e98de01beb92e6f5
branch: debian-sent3
