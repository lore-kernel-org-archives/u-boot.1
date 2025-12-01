Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69381D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 11:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9632383B21;
	Mon,  1 Dec 2025 12:01:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="V7MgmTSi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EE5A83B85; Mon,  1 Dec 2025 12:01:44 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43E9583AAC
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 12:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NabiX62Ztb7AXlg9m6krwIeI0c03OFJGScQu6Q7r7jvtrQx63j4keiifKuHci6LnYCmJ2agx6hxv4/O4wkfes/KdMryMe7TpQi7YxnD6TnrpYkTPd3/uW0AuGO4fHNTDzmxJbI/gaVPZpsUJ6upRkZxS67ui/xoyu9areWc8msNT2US6f8hWBRRzoS+hPyqXwFxB4rSWjxufcTokjtP8eGqZywjLUhTyh3VLiqHtFQvBO34YDv+O1qvEYiPQ8p49iHDBD6hziRwCU0ixi60CqezpZQ857v8OdDnrS9LMEQZFIOoufr/hjuuTvW6nKnLoA1r2ka/8s/MhuaABxVf5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meJVrZSMQMYmfRVWRLWU1Jo0hIl9pJI7XU0xttqS8HE=;
 b=V94d58HxluvmacKHqmgqd//Tq/xuxOSEorS7LIajamYAo6fVr49xnTXSeYIxZPqkKBHvSw6oHxvd7p4zj9WnkExrdohiqt7/ifGuuMPPkIQKQVWeSPjZSEFh0I+PRvghSqK1ZLLdi+OYIwvCEok6pwv6upNPNahg33UbiL0wnG1EnhFz8PwqHJF3s0K3BrNvncKg1eTVVnwI05z4lNyl3SGUoMv8pzAZ0iDme8xTPi8XZ3La34phSqs23tM3jYU7hTHlBA8s7dFeR4gk3lAU1kk9QPw//5gO4HJvHQDJzIkF8cNIM0ONILKLPCNKiAjOQKotQMj5u+ei/pK845O6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meJVrZSMQMYmfRVWRLWU1Jo0hIl9pJI7XU0xttqS8HE=;
 b=V7MgmTSiIKSCWIhvsV+9Zx8ulTJhO0N1+PgNFRToUAc2KoCKvRptu8N9Y0rFxXGayHf7mJOqR3vmTttNfD5+6N6b+MvYupM5D6fT7MXF0/46pF+9RWdorNHjq1PZdqrZtKRBEF0f4a4B0V95O2wMg2KrgH1+C9M8a036hQwTxLY=
Received: from DS0PR17CA0017.namprd17.prod.outlook.com (2603:10b6:8:191::28)
 by CO1PR10MB4803.namprd10.prod.outlook.com (2603:10b6:303:92::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 11:01:39 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::7e) by DS0PR17CA0017.outlook.office365.com
 (2603:10b6:8:191::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 11:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 11:01:38 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:38 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:36 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 05:01:36 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1B14qd306512;
 Mon, 1 Dec 2025 05:01:32 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <m-chawdhry@ti.com>,
 <c-vankar@ti.com>, <u-kumar1@ti.com>, <j-keerthy@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <jm@ti.com>,
 <anshuld@ti.com>, <s-vadapalli@ti.com>, <ahalaney@redhat.com>,
 <semen.protsenko@linaro.org>, <mkorpershoek@kernel.org>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v4 06/10] configs: am69_sk_r5_defconfig: Disable PCIe boot
 configs
Date: Mon, 1 Dec 2025 16:30:59 +0530
Message-ID: <20251201110103.845413-7-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201110103.845413-1-h-salunke@ti.com>
References: <20251201110103.845413-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|CO1PR10MB4803:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b55747-1875-4666-e5f9-08de30c9004e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bKCiGD/vQiLh3dP07ezMPbrA/HNfSjTtIJyFcnx8zV5U3hsYvJlTiE1gcDFz?=
 =?us-ascii?Q?iJJ1xC5e3UohCMb37SY8kDWVxdwb5U+pQTX62RHnpa5iKvqgHtxQNFS5Feoz?=
 =?us-ascii?Q?9Iujfn5DuJBqCEB3nw5uPsmiDsdumfB7DhHybiOH11IuqaXiKfbMrretNpLH?=
 =?us-ascii?Q?uUABEWtqhawJAM5PtZkzMcR00fdlvKBuXN2Kl7PLUBvb5WlUoQe7r2AGgxxg?=
 =?us-ascii?Q?133R37DryS7u5XJAvv/yUH+lc+SLMwmLqWL1mDRIlZV3/CHFoGtUQC7flNNO?=
 =?us-ascii?Q?PtmqJwwTorKKNdT2ZpXDF+eDQgoCnlnHfab6i7Ay4v1uq4O/tiilikdEnzsQ?=
 =?us-ascii?Q?nWr8Rg3NqTIUkMSklFF8nB6whZ34nttT2YJZ5NAvKkWK4ZnWgW5+QvPkqna8?=
 =?us-ascii?Q?wXMGKCVk/6hMv2E7NnPGcIdoXOUxCq3Ymn1x+5Odzsm39f1VHYGH96VdYJwv?=
 =?us-ascii?Q?S8ADxp/+1+mxdmsXL99apldgrYn1a+UMJpJeZ4+s8/WkDKRs8v/qZ3AsFHD7?=
 =?us-ascii?Q?NgG22Q0hY7GoX80F5eniI3T4c+lOQPZ5U2nl0sPcjauEcJoQFCH1Qr3wCaeu?=
 =?us-ascii?Q?LKG+HsyXEeTIrrAL7rEaCrfEUhPQaQCKDBvBt/W2Wj173RNpevezzLlpF5a7?=
 =?us-ascii?Q?LsyqOiexpo5nGo9DOeQyL331JnB63jxgSLzjpGrC3GEa9yl+CVccwSwkp1B+?=
 =?us-ascii?Q?l89GR663yvY5xCoueFHjCbMD3B373QXa1lOeMZYt832LqTpp/p75XvRyX/7u?=
 =?us-ascii?Q?tcAgww2WpIheupAaEwxKwtYVMtUO2L5VZSEvg0v7ELSRPGFYLVcBqizHnzn/?=
 =?us-ascii?Q?tBU2DxktpmMEgrfvmGG+lzebbLbOv7iV8M4hDt8VaL/02O9tnrG1XEi2KXXW?=
 =?us-ascii?Q?PRCOzdzpwAExAqcxbXwnCiBvvlPST1ERFDw80PS943DqG9OnFpkibtTHVaSj?=
 =?us-ascii?Q?k9afTmakbJxYH9ohnL0KW3+Q+ODHYTv4coi34XL3mhcEJ/JYwZOZulUG7UhM?=
 =?us-ascii?Q?uZ2fRH0Bmbie86rpgmmKfwEYapaEH26whGJQ0UbQK6FYsCbIAL2yA8sPKmC1?=
 =?us-ascii?Q?lf1TzDimJlg6WDMGrMzMS3HYolpxhZHJycQzYEOmwU70g4nCy4KnjoySi+l6?=
 =?us-ascii?Q?gGOOEFp0f5TO0FxJz8mIOahdsA4mokTRUi8bSgFtmc06pcft+1OxoqzrqZei?=
 =?us-ascii?Q?+Ejg5jKcJUQb6GSdeDzJxstLzeynGfaIFBVkyFf/Twr9RTtYBoLKbydTOwLC?=
 =?us-ascii?Q?ZtyshQYHVtb3dH8YS0XS+3wWu0UAvTYbiE18zt9yyuxDGXFxDJXYTN9q+Slu?=
 =?us-ascii?Q?aflv/7qK2HnWjOhjgICD6O1peBhRP79Y4Jfrs5+K2IVQLS3+p3Cbkn5PrHgm?=
 =?us-ascii?Q?7HtA8r8/PH9Lg3CbwZ/W5tBNhhhzMsomq3ykcMNi3ul7pHtlH1d37THXDY90?=
 =?us-ascii?Q?bYle46Jn4+XNalbASAoajxs9rsnb1C33yZAixDQsiCMPe8GPDxINM4d6Xbyj?=
 =?us-ascii?Q?wzRDGx/UBeR2PNbWthd7buNHxcN1p/5Gr6gd/GtdNugUS7PlklDwndLZ7H1d?=
 =?us-ascii?Q?0ZxvwgAkral0SImJUZVWKCPbKjrfU9FXs3AVIiMT?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 11:01:38.3950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b55747-1875-4666-e5f9-08de30c9004e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4803
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

AM69 SK does not support PCIe boot. Disable PCI boot related
configurations that are not applicable.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 configs/am69_sk_r5_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configs/am69_sk_r5_defconfig b/configs/am69_sk_r5_defconfig
index 2186b9a0490..385fd999d30 100644
--- a/configs/am69_sk_r5_defconfig
+++ b/configs/am69_sk_r5_defconfig
@@ -5,6 +5,15 @@ CONFIG_ARCH_K3=y
 CONFIG_SOC_K3_J784S4=y
 CONFIG_TARGET_J784S4_R5_EVM=y
 
+CONFIG_MULTIPLEXER=n
+CONFIG_SPL_MUX_MMIO=n
+CONFIG_SPL_PCI_ENDPOINT=n
+CONFIG_SPL_PCI_DFU=n
+CONFIG_PCIE_CDNS_TI_EP=n
+CONFIG_SPL_PHY=n
+CONFIG_SPL_PHY_CADENCE_TORRENT=n
+CONFIG_SPL_PHY_J721E_WIZ=n
+
 CONFIG_DEFAULT_DEVICE_TREE="k3-am69-r5-sk"
 CONFIG_SPL_OF_LIST="k3-am69-r5-sk"
 CONFIG_OF_LIST="k3-am69-r5-sk"
-- 
2.34.1

