Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E5DD1D461
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9493D8422F;
	Thu,  8 Jan 2026 15:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xE5gRFiV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0CB384223; Thu,  8 Jan 2026 15:37:23 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFD5B841C2
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:37:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QegoYJRtPjBspjKkKxA0VPKD6rI6IcmvEKytxbFQSb62vyy52f51GL8+ThP417QYW009IRXD7HYq2OLBwhjPPq7gvRtepRCxQhsfGIOHtmHasB9ZEcA9ozMgRfqoyJ/C+5WX9ywzeXmd6L10fcnPQXIhfr97rQXnvvxwDSSSFudjR3AOgVs19jAiRug7sy0yxi0rR4W9ITyAIeKSs4WJoFHs+DUjQZLFsfFwdcPwTdpvA993MV5SDMcBBiBKKPQCoEA0gdAO7p9eU6YKdQKaelhZf1wIz07LpSV2gMgvkGXrLgZ6Lzz5Y1vxXaJO9sZh+Tntur/rDYpfdz2OgIRKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqpDW4d9mv0OlLUiMs8GaNhhMfZh38k8mo0lvYVbvxs=;
 b=dn6DRX98JZt8lJZifKHnIa/MAkA8QZhn0G6W8IA3JuOnhDSsf+3fOxvmlleAWUfpCu03dCJjfSNlO1e8GNq3q3HPR2fXA8UwwLzlwV4zJBoyjyCPnC6kxFqUimEtG8kFBnQ3kV+apZYgUZRq4pQ4/hsFaBM+owLqpyfxFg16lsjlf+kmlGOAdbWO6nFVyQZ0XN0o9c0r1RnWJxF44lvQZKs4rDqfi9jPEsvVLRGuwtAXhL1A4qBT6NObZj6ppqWiWAb/DZ30wQSfu2Ki5npguZCkNhZFoR24gSmvs5WCwmuIm4cC2wp5VEW01bAr+uWiqV2YKooyY2lJ/IEQHfsgOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqpDW4d9mv0OlLUiMs8GaNhhMfZh38k8mo0lvYVbvxs=;
 b=xE5gRFiVmmd1wcRxquWLOSYjZJrr+e+Kwb05n9A3XsRYdBr2qCPdH2UnkA7ESQm20p+2B7Q+LJtGM0VbbDt4Hye0PwnSn5CqjHxHwlco89uPzqmRl9wA39Qv+DSAgZXSU/zLE+EpBbGIuHIdNZkXm//yqGx9HNLs25s7XOrTX3c=
Received: from SJ0PR13CA0112.namprd13.prod.outlook.com (2603:10b6:a03:2c5::27)
 by DS0PR10MB8056.namprd10.prod.outlook.com (2603:10b6:8:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:37:19 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::e1) by SJ0PR13CA0112.outlook.office365.com
 (2603:10b6:a03:2c5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Thu, 8
 Jan 2026 14:37:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:37:18 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 08:37:14 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 08:37:14 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 8 Jan 2026 08:37:14 -0600
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.68])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 608EbEVi2521105;
 Thu, 8 Jan 2026 08:37:14 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Bryan Brattlof
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 3/4] board: ti: am62ax: Enable 32k crystal on the board
Date: Thu, 8 Jan 2026 08:37:12 -0600
Message-ID: <20260108143713.1130054-4-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108143713.1130054-1-vishalm@ti.com>
References: <20260108143713.1130054-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|DS0PR10MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 9898f26c-03d8-42bd-968b-08de4ec36ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|34020700016|34070700014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+vGPaYoSTuFx5IOGuxVAyJQpmd2qmLeJq3UNlHMXP0QW4VEvcf4uW94SR0Da?=
 =?us-ascii?Q?ZF+i4Aq1xwboJXl2ok2rt14uW4wz6aLUffLuWvPlCb3FMPA+EjFI1HGXgEQT?=
 =?us-ascii?Q?5Ncotyeoooh5mwzRqAJPgcMhXO3PGVcEZK2FgJh3tPQE0W1kp6X69JYHLDPd?=
 =?us-ascii?Q?dxwgCWhYMtTlLGEF+Zm4UuNdAhCi9no2hZx7IXdPCsaWxThyVz5L36/R/LVj?=
 =?us-ascii?Q?jfQZMdS85TSrXBnRBWYUTNfbywrQ9nCipapGehZqE4/PfNACPYcVGNmtL8Rb?=
 =?us-ascii?Q?eOPa9dLKOUKdWEtt5Geu76CAGhmMuRy4UHc0ul2AkDn+sVDl91dBGehwV+8A?=
 =?us-ascii?Q?w3xj4YyTv8I5n5Olg+anHrzp5YiP/aUWgvKELJ8lKY3SKmFzmPWXP6d4u7Bx?=
 =?us-ascii?Q?8ABw8NkG6NIU0qJGh6gO9uCTqrwDuK1MzMYVaCtj1MLLvvGOiz5tw3+F8ClD?=
 =?us-ascii?Q?hsyADMLIanOD85f38j9QiOFZoKOLpAi1AeRfgTkmpx4tMS6BkZBDRgJdP0tB?=
 =?us-ascii?Q?DE8dE3v2R0QrlojoKqfdyMAN1FRxMTDGbf0LsOI6rIyw8pA1ms/FnmzplFjn?=
 =?us-ascii?Q?3gOYAILIMq7nXbW1eR+2JIlGlqtLq1B5j9N0Us/PLXmnewQ3bPbfDmbrT7qL?=
 =?us-ascii?Q?KDs8E5WwEVh15bzvez3sLmDX6T8Qaz5HKxIg9rrKwJgInjKVMfFvXSxluVIA?=
 =?us-ascii?Q?/KCjtgJu75UsU6DhHjQkBKLORURALYfkCcuMpJPjvWL7Ac/z63bBiFfmYkUk?=
 =?us-ascii?Q?Rw4lcd3wWEJUuOUAHNwn8zJ4zFQ885B5vwnlhYo6T+RBYTNLSBiUztPwraaC?=
 =?us-ascii?Q?gtpQwtPWXXB/K2yXg25WdEIS3IGvf4Qz2ngMn3H6pgLj6jBafrKDOS3BtV4M?=
 =?us-ascii?Q?Vmnf11buDFnP66iNY9MWMdBXVvv0UkC2tzVVZuqFo+YUg1jsmZJ4g16YZElK?=
 =?us-ascii?Q?AnNq3RD1kst5958UGJjx85GsjUmNKk37X6ov2eVitWJ0QiuNv5F6YA9Sscfe?=
 =?us-ascii?Q?ZU8Kns13gelksk8b19bijpc0+koMlwdEq8OK6jvHqwvNxsLAoRihO3aAIP8B?=
 =?us-ascii?Q?Iasp463sszJhksdp7mXcQ1cDM3LLSLKIB8mvON2j5sBQtevgyfBc2fc5wtmR?=
 =?us-ascii?Q?p/3Tx/FDh4DJPMzFXlVaKB/s8Z1MC4Jrszov1da6/1NPg0GtjSxp3VQcdl7d?=
 =?us-ascii?Q?Lsq9A9iFBfbDHb0imr2vnqiI7DZ9AN++4vbuIFdOBrHGmk1cfNxRRawk/O88?=
 =?us-ascii?Q?M4pS8TXwR85+eiySCMe2QE8SdKUWC6UgcqAmeHgIhlSoZxc03o4QORLjjj26?=
 =?us-ascii?Q?q+gzhZo41bBSTQ/i/YFCe/Oo4bgJfLWqsRGRH5EFI9rNou57qQ2orgLx7pX2?=
 =?us-ascii?Q?eKnv4pofJSMef6+CGx5S9MrxD5u5mihqt2e7EvhGrxWvURZb4zMWZMAGLqog?=
 =?us-ascii?Q?49juQoLsVXMjgXVRfzMDOFI/TyLElS+y5x3FPlbuT6TwcSYMnCK7DOgSLN/0?=
 =?us-ascii?Q?9PZEHbq/GFzCz2AmDYSiSBvdLONc49FCZAEu0x1+AzWXqo4kmM5Yb9tHaeXb?=
 =?us-ascii?Q?5pGluKJFkjzB/xsECEk=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(34020700016)(34070700014)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:37:18.4856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9898f26c-03d8-42bd-968b-08de4ec36ce8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8056
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

Enable 32k crystal on the board. If external 32k source is not
used, 32k rc-osc comes into play, which is accurate to +-20%.

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---
 board/ti/am62ax/evm.c           | 7 +++++++
 configs/am62ax_evm_r5_defconfig | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/board/ti/am62ax/evm.c b/board/ti/am62ax/evm.c
index da6c31176cd..4916eec3b2b 100644
--- a/board/ti/am62ax/evm.c
+++ b/board/ti/am62ax/evm.c
@@ -15,6 +15,7 @@
 #include <asm/arch/k3-ddr.h>
 
 #include "../common/fdt_ops.h"
+#include "../common/k3_32k_lfosc.h"
 
 #if defined(CONFIG_XPL_BUILD)
 void spl_perform_board_fixups(struct spl_image_info *spl_image)
@@ -26,6 +27,12 @@ void spl_perform_board_fixups(struct spl_image_info *spl_image)
 		fixup_memory_node(spl_image);
 	}
 }
+
+void spl_board_init(void)
+{
+	if (IS_ENABLED(CONFIG_TI_K3_BOARD_LFOSC))
+		enable_32k_lfosc();
+}
 #endif
 
 #ifdef CONFIG_BOARD_LATE_INIT
diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 9336392a5ed..a94ae0cef1d 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -102,3 +102,5 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_TI_K3_BOARD_LFOSC=y
-- 
2.34.1

