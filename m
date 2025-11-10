Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3DFCCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 09:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C480283968;
	Mon, 10 Nov 2025 10:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mOtJy7bs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F03E83A15; Mon, 10 Nov 2025 10:42:05 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14CFC83968
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 10:42:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6N1ZE+vqButl77nsPBwIvUTVLvMFA1ZbKHSdSUJ2VoQn6jt6qAlnXqyfrsKeqtWB3adMZCQASGkiyNjxd720/RDtJKlvt1/ExiaM/MAUpK7WK093+TvnzNohSp5B4sSoT9gaQOpYbyzvx+jfS+kJn39ICqFczh5Vxiv7OR/rJupNYt9ZIrGHimVjpPIdwqEiZof0DQzsAmrbGJlsv7soDH6WLuoI85fwGDcbRQUoVVO0KGvx3Rgn5r/RVJw2eM9aS48C2presGtxB0Uo22X20ssuLWjL9DAfr6fBo+OC4qcXuAWz/UFYlAqyvzTtHHReDFd6QJQhzC2JZmU/OWplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlD2+Mujm1gPV6YC/EX5zmo34szMXlHP5cW47rByi/Y=;
 b=Jf2yVKsEzV5n/DiN90LgtzTIVzcn8uBYvxXy5+GLrZYqWfWECN0vmPBcJC39IdtAcpGpIs8d8oGIbpYpBy/lVdMrw5yMRcaPXh0XTJJ3O2m7uU1zlal0CGznvY3Wd638hyjtEkFec2vMLaXT8LnEgPZstVtPYDiSoK79x54DnIfGCwvQXCLneNIys6ClEEhXiwE/aA0jrtXzZw7k/Ooq/muMMc2hJzoXnScsSAeJm7f/KwpHpHaldC6ibbOLz/SzIFpRx8esG7PL9rLwYtSXszgYwjNk1n6LKWxxm06gq7lWhgfWni5d1WJj3sq8G6P+N8HWPKBG+xeCJ9y98fT94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlD2+Mujm1gPV6YC/EX5zmo34szMXlHP5cW47rByi/Y=;
 b=mOtJy7bsP3o0UTfhJNYDdvWEjnezzIf0OkH9qZ1WEeHPjmeVHr5x6Nw42XLQ52gkC9YWmsjEYE4fWd/kQqgPo/bhgR/DcLt1e+JQFLIUXFykBiaAEFdhD1p+OSIOWA4D4srIZxNAMwrf9A5euAYYkUeQ6+In6a8CxwCtg5Bu9Do=
Received: from CH2PR11CA0019.namprd11.prod.outlook.com (2603:10b6:610:54::29)
 by PH0PR10MB5641.namprd10.prod.outlook.com (2603:10b6:510:f8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:41:59 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::cc) by CH2PR11CA0019.outlook.office365.com
 (2603:10b6:610:54::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 09:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 09:41:59 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 03:41:58 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 03:41:57 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 10 Nov 2025 03:41:57 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AA9fit23156252;
 Mon, 10 Nov 2025 03:41:53 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <c-vankar@ti.com>,
 <u-kumar1@ti.com>, <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <peng.fan@nxp.com>, <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>,
 <jm@ti.com>, <m-chawdhry@ti.com>, <ahalaney@redhat.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH 2/5] phy: cadence: Add config to enable Cadence Torrent PHY at
 SPL stage
Date: Mon, 10 Nov 2025 15:11:41 +0530
Message-ID: <20251110094144.886956-3-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110094144.886956-1-h-salunke@ti.com>
References: <20251110094144.886956-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|PH0PR10MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed111dc-9211-4135-e2ad-08de203d6545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y0I/sYQMTrdSFd7J6wiSyk0/2IfY0Lh2KbXU+2pDDzE+lekJLyRpPj+/Rg4J?=
 =?us-ascii?Q?MyjdiZivEuF6u8Uc+VXOvPRkQA4bQuiV6LE2UqlY8OK3rdNj/j6ajZijcTOY?=
 =?us-ascii?Q?HCEpG01R4enOeLWzL2xjBRllzMCKGCmS5U2COIwjs3dRJ9T5J9wF89gN2vlz?=
 =?us-ascii?Q?++HU0U+rG4g0ZIkIJrZtkj/CN8/BtumRkRhjzr0OVJap3l+7tAS9QCXXMiRk?=
 =?us-ascii?Q?zo+2oXG0RhSBIdxLI6N9BeyktDF2qBN/miU9oTOi9hqPStzHORJovEq68T3K?=
 =?us-ascii?Q?peQAoAvcIkXmL9TL8lLMcLAU4pb8hr2OZSqX538V6SNbLO6jP2Y0sItW36qf?=
 =?us-ascii?Q?FNHaC7M8jqInsUiHeptByq9laUCbj/xEzsZyYUnE5GAE44P9mewa15vuYTZI?=
 =?us-ascii?Q?tOGrzJoIRxRCvx8AghzQWe8Pmwn8jnEdBSSf0XD3DtHZOw9rDRm0Ha2QuRH9?=
 =?us-ascii?Q?FRxRe8eDbctnIVhLRfEaIqBdLBGrTQ7jMwAiVg9Fg6rozuHfcjss2Crq2aot?=
 =?us-ascii?Q?aYWcfr675py8oCtxLaZQmRYCEzTDGtaBxz7ZMU5eIyduL+IIO/6gJAmz7IjC?=
 =?us-ascii?Q?Ic3J32mNamlnb5WM1jpLKJko2FBMChgLHvl2Bi1AlThJ/0UG8LHVSmgwLVi+?=
 =?us-ascii?Q?731My2cKKTVMh/calkKL1jb78hsKPPIA7LB4dlO0AB+bJMftqDjht31LhvAJ?=
 =?us-ascii?Q?Ozf/qFb8GI7YxA74z3QybZ87OQUCaL62khjKoAq7AbsiAoteJE/W6+NYj4zc?=
 =?us-ascii?Q?Lb1CVjWqu6loRQTM3WW05cJ1h4KECRFdo0DBcix83X+DVrnx7LuTSpb6ZdLL?=
 =?us-ascii?Q?3t56LSMV9qlPt9JMKl87Vfhyvf2zzmtSqVuzT2Bde8HDXRfx1mhFcxe0aPxH?=
 =?us-ascii?Q?t7nix85WTfPToXtk/jw2NB8Iov6mCfe3Hc+GDmvNDiVpiJC+RgSRjl5vp7Nf?=
 =?us-ascii?Q?U8PPZI5tQbeq6APS4OKIGdEwPILvreAk/xY5YgxTCXUic8TL/nY6wpA2e9RX?=
 =?us-ascii?Q?BO3dGMXnQizL7JSstOKUNWqaIhm6tfJ9VGanYqL1Rtq2PDyQr2lRBvtWnrto?=
 =?us-ascii?Q?AIYk3VWa2B0pASETe8OlA0MrVRC9n6ijFce4Zmb+Zv0AxUliYfq+2dtHyhaO?=
 =?us-ascii?Q?HSbEcajw+iAXEmHvQ2ApSu1/sZXira4yP48WotlMobkXxSFoew3WJZxy95XC?=
 =?us-ascii?Q?MO782T39pk32Y/5GDwN/1Ox4KQwo52UiAiz06HMFVAuj18fF4z9xDtEmwBRq?=
 =?us-ascii?Q?s5sJVlJr6xEE69UxJGxfY0AC8t+jSMUhTygWRuTwYs/308CtfanpEvZ8rR82?=
 =?us-ascii?Q?IWtsD8lXPmFMfpGNKN+qYoEA/9m8Ot+JuYPp4cbig0vaIultKE4QlrmV9d1m?=
 =?us-ascii?Q?qYRwVh8eAoRLkY5MfXKqSGdb5z6uI9Z7eIRe0ApSFJy4OSb9ik3T1NYgw1V/?=
 =?us-ascii?Q?ZYiDYRcFc81syjLk/T4XK29GNb49tQWoeMwEWVypdaXZpbkguJ74yGa6ICq1?=
 =?us-ascii?Q?0wnHBqXuAaS41rT/148Ji9kxFmkGWO5ebEKDIRb/Wdk4Ln/g1btoaoFSDxwx?=
 =?us-ascii?Q?CcDvbVc22ScE+Sj+J8RGXcTrB6SDtoy7HO9N8j9a?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:41:59.6655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed111dc-9211-4135-e2ad-08de203d6545
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5641
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

Add SPL_PHY_CADENCE_TORRENT configuration option to enable the Cadence
Torrent PHY driver in SPL stage. This is required for PCIe boot support
where SERDES configuration must be done early in the boot sequence
before loading bootloader image over PCIe.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 drivers/phy/cadence/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
index 549ddbf5046..f5b1f7a30db 100644
--- a/drivers/phy/cadence/Kconfig
+++ b/drivers/phy/cadence/Kconfig
@@ -9,3 +9,10 @@ config PHY_CADENCE_TORRENT
 	depends on DM_RESET
 	help
 	  Enable this to support the Cadence Torrent PHY driver
+
+config SPL_PHY_CADENCE_TORRENT
+	tristate "Cadence Torrent PHY Driver"
+	depends on SPL_DM_RESET
+	help
+	  Enable this to support the Cadence Torrent PHY driver at SPL
+	  stage.
-- 
2.34.1

