Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC44D116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 06:44:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EE058432D;
	Fri, 28 Nov 2025 07:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LTBvycZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81FD58432D; Fri, 28 Nov 2025 07:44:12 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C55F842FC
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 07:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGFdkR5UKnJwNvRVrVz1U9rNyEiSXi+LkvBlg3cbQE/CLrIz1m79IwgPFpXwFtRl3Yfyp2q4Bt1giWczEgGiiLhud3vBoRP7dp4DXDjBsg9uasdMK3xAjSKGXy9Tmz6Yk3LjprqCAIIWbiTFTGuHudPBalUdk1Tt4syPBkpYBKOG30tJEIOwrvhX1yPoXyEMRyZjnO9SP5wFbcak3iRNQ7aNH2uohYbKSV4EBEsHEfZsbtB0q3rQS3CRAjvgUWPM2KoAxKO8S4Rhef/VgT+rf1Arn9mASbN8jP9DP6YeUhZspdrnM3Jizl0A+WwEcbyKQjB4EGMb7V4iefIS05LmZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3nriPwKI4ubPsg0Aq3zc8U/h/vIrMA/uGAzFlMZiUo=;
 b=kqVsi7iA6QfIHSpCR7u3b9t2W2XnGKjcDnSg8dnPEkyai0aNKU5KewEk3XEfWYa2+JJXxcXCJvAuMTiPvuuHjL0/dcZ05DOaNdkTEfLq05MpYFOuHwCF2+C7Y+3IINGImNDABxVnCrCGdoWb9ws1Y3e9fEBdZkoT0iSv05zc/9suBgwi4isacp2n3werZzAjafMyUgdykTVFkdlXTfPx3U0ljhcTAUkhtMBznVWJsdutHZk5v2EO/6z82PUCtdahQlJDEJsdmWhOR84hyv4v8bqeVhIBGxZZv9YwI1obNs4ekvQbDzvtq8R/HyS13V4mwI6HQ9r9OcDghhZw9Cz9ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3nriPwKI4ubPsg0Aq3zc8U/h/vIrMA/uGAzFlMZiUo=;
 b=LTBvycZ4WX30huIZ7+x7IZi3Fbk+BbWmEpPkF0fCz1MG63omXXgKgA6PB9MWFE4VFt5qWR8yNsiGuzqL9HyvtX+u8Qqo6LjGK1gq6w+E+W5OVvv7IK4BlqT7Uh2IYTa+NidTZ3/oDzQBqQzA3TfGfcQ+6bb8e47L4o5gb4jh9nM=
Received: from BN0PR04CA0102.namprd04.prod.outlook.com (2603:10b6:408:ec::17)
 by PH0PR10MB5895.namprd10.prod.outlook.com (2603:10b6:510:14c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Fri, 28 Nov
 2025 06:44:06 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:ec:cafe::16) by BN0PR04CA0102.outlook.office365.com
 (2603:10b6:408:ec::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.15 via Frontend Transport; Fri,
 28 Nov 2025 06:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 06:44:04 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 00:43:59 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 00:43:59 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 28 Nov 2025 00:43:59 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AS6hrRT4092368;
 Fri, 28 Nov 2025 00:43:57 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 1/2] configs: am571x_hs_evm_defconfig: Reserve EMIF memory
 used by PPA
Date: Fri, 28 Nov 2025 12:13:52 +0530
Message-ID: <20251128064353.1295063-2-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128064353.1295063-1-b-padhi@ti.com>
References: <20251128064353.1295063-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|PH0PR10MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f5895e8-9e88-4fb2-44c4-08de2e49859d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cXCAK467ermS6K+6Bx8CsW6qFj4rafGnrOTORk7SfdlvKuOh6n5B34HVHQc0?=
 =?us-ascii?Q?qx//zBBtBmio4sRJP/Lz+MIdat3VtPBRaAo08AB0udPsxW6rJx16dyMpig5Q?=
 =?us-ascii?Q?N59ostq3rHqw3t4q0aJ5jeZ4sCjEWlIhNq9DVSDgylK/kuLgXTPNujLYB+xn?=
 =?us-ascii?Q?IUkXwu5GYvFmse/+w7QY+lUwGJ/mCYDmRY770Om2t32pJIb+shY8OoekfBIB?=
 =?us-ascii?Q?pxQQGhyR8G0pVZVGA9pUxfwUCiyH88bvzPIjFx/l3dZlC+0D7+tTPqsPseNA?=
 =?us-ascii?Q?TUbVlGf7KX0/1spU14566sVUz8VB05Qjb3gjbfLA43aKC3VG7dCnmVEeTHqq?=
 =?us-ascii?Q?VXKvGk1GjG9FRw7ye6FdmjtA7T60DQ9OwKCnUJfEcOUV2S54LuJrqcH7+D80?=
 =?us-ascii?Q?l257F1/hxd8I9056FqD8tCnrNivE8TTxLtPObT0pwNd4mdoAqn680sZhvVM6?=
 =?us-ascii?Q?CQZgbyF+1zyt+dg+OHpVjxjZbZYgq201rE4Bg3ccGak1dadYjzMoMMVCwM8x?=
 =?us-ascii?Q?2yLEvu7YjMger7kN5FYrQNZtXYrI+DCmBe6MohWt0ZMUopSpmwzb0gKo3St+?=
 =?us-ascii?Q?qvuwL0RbSwcVMZZTBD8bYXA4McK6jiIi/FoG1rZpJdmoNc0TwKF2ym/YvUlw?=
 =?us-ascii?Q?TpVZene8bkAU0cr5Xqx6Kzb/SVtb9XkpuvEs+CWHNUdDJX2cGHw0B5P3Bpke?=
 =?us-ascii?Q?Kc5LbVBLbMRZ94aOEzSsz4vpt1jTbk5k6cFfbG/g7jgJ2yq7vZZKuE9UQ4qL?=
 =?us-ascii?Q?cBemK9nvVEyoARbeQV19laPjOpddYr5tUalncak5pOQp0ML9LCjbN1uMZinN?=
 =?us-ascii?Q?YNf4w4o8Ks0Iq+q2zxho5xAGktwqCZau+niKBRATOxnsGvsrd61M/3E6RcjN?=
 =?us-ascii?Q?p/bEjPHs0CVei23Lx/idwmjF0sn696WcDtYdrWC3S1qPtzG+SeVOVgeuzta0?=
 =?us-ascii?Q?sfQ9XDwH911vJHRKv+l9nrIDG7DEbxvm8xAv4IvBdCKaGPyBA7Hbl6ouapEH?=
 =?us-ascii?Q?Sv8zt/81R24BAsAuQZTZ3+WfGVKBHoIVmoeSoYqgouBZtWyycHTki0gjNMOQ?=
 =?us-ascii?Q?dzf4Tg60bch6cahZJfb7jRzOqvccMrdcREnUV7llpcX6iHIwGdTDTruEfQSL?=
 =?us-ascii?Q?FWA7pMx3BDGoMMlCPExocQzhJe/GfZkADVugUE7UeK9O/L/l2gxCb9kDBcaM?=
 =?us-ascii?Q?2O8UPZVIz/uDkPDthwU9flXBGAwzfJ1758EmlNaXaTSvOwGYHQyJGDj/PPKN?=
 =?us-ascii?Q?SL/DW1KKjjAGUtkEjF2ir2vYXIsALNAZUa+d4ZanBcov1bN3hU0qXUaVs7QF?=
 =?us-ascii?Q?lXKiQ1qZP86WLuwiFvv7jmwptYLAxyj7QdDQxM99l2vPgi3efI8F8OeTNOTT?=
 =?us-ascii?Q?D8ZON/6WP07RXeGgwrQWHyy0Tleuki0m2XEiiTt+9/VVwzwhPSYTeKBf4iCo?=
 =?us-ascii?Q?HMxgVeIfnjvQwUgdE32BiLpf/uiiUUXf1SAEZIG8c6MpXrcjaY0/kwndnlWQ?=
 =?us-ascii?Q?ynHwDYViYCOvF7FhJtn9NwN4Z/bCggYwc4+91ilMKGdT/niXadahXDTlanzq?=
 =?us-ascii?Q?X/cooz+Ie+3J+8Tp/N0=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 06:44:04.1146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5895e8-9e88-4fb2-44c4-08de2e49859d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5895
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
top 0x2500000 is used by PPA and is firewalled. This results in an
exception and the boot fails.

Introduce a new defconfig for AM571x HS platforms and set
CONFIG_SYS_MEM_TOP_HIDE to reserve the top 0x2600000 memory (aligned to
2MB as per page size for ARM32) for the same.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 configs/am571x_hs_evm_defconfig | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 configs/am571x_hs_evm_defconfig

diff --git a/configs/am571x_hs_evm_defconfig b/configs/am571x_hs_evm_defconfig
new file mode 100644
index 00000000000..7e44ee5221a
--- /dev/null
+++ b/configs/am571x_hs_evm_defconfig
@@ -0,0 +1,3 @@
+#include <configs/am57xx_hs_evm_defconfig>
+
+CONFIG_SYS_MEM_TOP_HIDE=0x2600000
-- 
2.34.1

