Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705F8EF071F
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 07:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BDD7839A5;
	Mon,  9 Feb 2026 08:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="S9HMTTPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D93783BF4; Mon,  9 Feb 2026 08:28:40 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 062FD80325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 08:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMB/gMLCQj0/ZB7FZl/UtToEO1mTahYflDMdXgUQun1ldulXhqFy0G3M4s6HwS+Z2yafCFg/oow4ujtY1S6Qp2aQEUD1vBLZt2EFybGTzSgBxjgzfWlJdkC68S7HNwlFcAbC3bTYXHAKxEqgrcvY8pqjcuCz/qqUhEhqFB6tAPxeXdDq2/i7WXuV+eUtUETH/ma2CIJTB48cJ74aEQ8YW1+2o/jp7Ax/ni7hq2KGn2dB55nDC4YsA4IgvZ9S6yMZhclABC7eN0ae05CpWfiEkDkgcgeKsvfKGncoqncY26gYMddOxe/sE60lNDM0lUmg1mRXXw3shQ3FHKkRoVG+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+1n/V6KXZSz4RwmMXYXiooRC/RyS+Dos2OLCg8gmrw=;
 b=KBT1mFcpfbPdqPMHyJXejLOysw5Skt2gx/xM1DCpP/dmT4kokQtKT+/pn0Wpmsa+KNDhI7gaXRUYb2yufbVkfZoW1H1LmQtlgdb2oxl9evlaeXvFgxU62w34E1mq8RQNv9jbHw8+Lex1ZXPs2I05Qo/6CBGcZrXEm0ORr0wJDQSWhAA4ARTpCJAaHm5Eg6KeKjLHr6jOhsHSl0xJtUIfUfJfFXipBA0uvdHviFFDU4J2EgoFX/FlUQHsRLHjyGT2n6fVFYMmlYkFmEc9lKOzEtU6TbCnN5SA7EHh8R6HLMuO0K8X1JoIRiD8KQBWPs1Zd2mYiTP75bvKNYYq81bg3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+1n/V6KXZSz4RwmMXYXiooRC/RyS+Dos2OLCg8gmrw=;
 b=S9HMTTPdsdy3fyrc/t3pv3BpEal82xiv0CMUajmAfIs5rrVt8GJdojtMFHi4Q+JVETs36t26hSWxOcaGUJU0oU3/CPjtwyAFiXyWBNLs3OmQT/xxTC5vIP5PrEoE5jQ9/gaSGWFR22qyW2tJ8TEZgYqT6Euef3xY/2Q3hnhGfPI=
Received: from SJ0PR03CA0146.namprd03.prod.outlook.com (2603:10b6:a03:33c::31)
 by SJ2PR10MB7705.namprd10.prod.outlook.com (2603:10b6:a03:57b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 07:28:35 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:33c:cafe::1b) by SJ0PR03CA0146.outlook.office365.com
 (2603:10b6:a03:33c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 07:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 07:28:35 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 01:28:30 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 01:28:29 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Feb 2026 01:28:29 -0600
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6197SSnO1580203;
 Mon, 9 Feb 2026 01:28:29 -0600
From: Paresh Bhagat <p-bhagat@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <c-shilwant@ti.com>, <s-k6@ti.com>, 
 <nm@ti.com>, <afd@ti.com>
Subject: [PATCH 1/2] arm: dts: k3-am62d2-r5: Add DMA and OSPI configuration
Date: Mon, 9 Feb 2026 12:58:19 +0530
Message-ID: <20260209072820.2576854-2-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209072820.2576854-1-p-bhagat@ti.com>
References: <20260209072820.2576854-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SJ2PR10MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: a0458654-35e7-4211-bf06-08de67acd5e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Krxm+KiSZEREEXSlu3zkpMGNMn96tftMULKzFiBB58WbFFsnUlMJ+hGqGED9?=
 =?us-ascii?Q?2bVESpks9xrOAxPKUYUUE+eKafdEqsKSw/AfVdxnQ/PSS6hUK8excbZc3Ln1?=
 =?us-ascii?Q?N6t7jZcLkAap88vU+hcX0pB/orWWcDHlCysoRdOUVy8g5vvM6hfcrS5twCTs?=
 =?us-ascii?Q?0kW9gJGVJWzpMvmUZ9BhIDkN+wyzmPPjMarwmqMPv2nUfpRBT7/YqzVLR/Rf?=
 =?us-ascii?Q?wuYxAKXRnZzWfnSdrfdk4Xze9klBr1peQXvT/ccP41fXOkGnO/zOEBFQmvnq?=
 =?us-ascii?Q?ROxavO6pxuaYb/QnNuYpkpFbh+zo4IAZRQuOVTKOPXIpDdBFAV7NTjaUOdbC?=
 =?us-ascii?Q?hFXCrMrrXAJx3Ct3aWZsv3elRFvsujssBGvXz5iO4vT/wQ2qP4WfeziTft0c?=
 =?us-ascii?Q?GctqrNzZ9WKgLhFO/ToKZdzVlKRHGpS5koZqaukTEZOnMrPvhcyOgRI+ijZk?=
 =?us-ascii?Q?p6/9s+XHcNOXPPaRLpYgCjHFNFCooVxg7iSAQ9recN3K+r7RG0kiaihgb35v?=
 =?us-ascii?Q?A/RGdR/coUXRfip3Kyv3wrjtDe2yLoP8/Zt+ZRlh229K4Cx/FimmxiQIsLgV?=
 =?us-ascii?Q?5ufgclBkJHSylGF68UF2JJfIZ0osW5uWNJfoPBnOknHzO7okf++ytI+2WvCb?=
 =?us-ascii?Q?egIa1uM9S2jE4niRhXlmweGvq2EEfl1hPLYuFj7L+PXc3HiWWXN16ljYoK2i?=
 =?us-ascii?Q?wMc58BsK5gliR0LYqg2rppw6VXul9NlOZQ9qKV9N6h6VitEFQnIL2Qqtjh6u?=
 =?us-ascii?Q?cJdcVSeVrTEGSaqQ6O5V8RtLrwkz2s8gVsHPGjv8XbVhDJrEPLWbQ4mV9pnt?=
 =?us-ascii?Q?4PvYTScb1WgfUGnHIETHbXaq+f4BLy4zJNyMPTNq8BChal6eODvZ3PNjspeH?=
 =?us-ascii?Q?5PA/TNBzbjKZ3tKhdtP6f1g6TAgCmDffC+aBZTQbOqglELTDVs7pytBO3G+Q?=
 =?us-ascii?Q?aumvSLKBhXXOHky9esC1yL0Z3DR4hD24vIOvwrgDnEAvWYqO7wH9rEpn8YPB?=
 =?us-ascii?Q?NcSv/t4ojcSsHpFcuOv0ui86R476YT37RVdPuzksUIzmrzfQcWsOmmVb67RX?=
 =?us-ascii?Q?xs9cyVZfyn+1eksDS7Pam0n7IhkxE3ZTQHCXknDZmkoI8sZr4IXMbz1QTneG?=
 =?us-ascii?Q?GRXbj1gNntds4Ag6G68m5IsxvF+rpWfqT/GRDMdjCTgrrhzi2JlyZ3hLE63D?=
 =?us-ascii?Q?SrwwOOvR8TwJ8sRWhDzZ9ecCQQKOfQC1C8jzWRQ0c9ZspL+aZLmpMRev3HSP?=
 =?us-ascii?Q?Q8BgXACfnErCBB8nhNUkmkOoXLh7jVdlpjnxO/bDnsIUGrPLBXssny7vVk17?=
 =?us-ascii?Q?Ma+sd6hvVhLAa75ibLrhpFZdq7CZp/qOpyFVMVHWmZJuwz9JoT5m5zwQxtfY?=
 =?us-ascii?Q?9aW0sQxG4wAREFD9RRR9hM9vtmErOjx7GqV/71XF+7xx2GYUlIbxwWcKzIok?=
 =?us-ascii?Q?ISf3/SpLpsClZzpCllemHUYPSBAoC7DJUi6KdZmMx0GuwF12OdzRICT5jlou?=
 =?us-ascii?Q?9XX0BfE+U/B8sAGZgc1eJzmdsqiIDkh6q1WDXoG2XqOTTMWk2h9sYAL4EBxV?=
 =?us-ascii?Q?h3rHhQ/VdeOE0DUNLY1+RMSCNgzmVf0h7Soxqn1udTfE6fJsYYOI8WqJEz7G?=
 =?us-ascii?Q?4H5XUuJWNaS4ovYgRx1ZEFp62lPSL75c5c40jDogOjrjfoaxHm08Ax60QiJR?=
 =?us-ascii?Q?90WgrA=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +CIPiNh2drhgNmexxLQtwLgBcA4T7vGKf2oO/neQLd7/zj/q3bbOo+tF7K79jhVwHni7fotvryNUAA/wZu//SbPP5BWAvSu2OyfQ64rIAiozDHLduWkTnA43hlWK4OJrYsLhzPSC82S3ixIoNpR3q5NYFLiWDZlWT6YmjW17PLLnrkziGagKgTCZpqLvaaxoDICVX3HvcQIJAaiqT9fPf/UcXuZBbzBq2CFb6DTLKf87nKRAdITu9FCd4SbuuSss//XCP+xRVG5iR93hqDm3QZzKy2TJ8imo6JYQ3LTrsBlrsJZpGQku/XAjAvJgMnE3StxcSy17hpD6hU0Vrk4MhnqaUMXUXuuEOP0io1iQtfn7g1CbU2khszYQFGRyqZRN2jvlRPHOafR94A5O7UMHEPF/4glUIGtIigSH6ZDeO1903sJs9+/x+vvqEfQcyjkm
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 07:28:35.2561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0458654-35e7-4211-bf06-08de67acd5e6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7705
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

Enable WKUP UART0 for DM firmware logs, configure DMA controllers with
TI SCI references, and update OSPI0 register mapping.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 arch/arm/dts/k3-am62d2-r5.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/dts/k3-am62d2-r5.dtsi b/arch/arm/dts/k3-am62d2-r5.dtsi
index 23dfc49c2ea..4a58711bfbc 100644
--- a/arch/arm/dts/k3-am62d2-r5.dtsi
+++ b/arch/arm/dts/k3-am62d2-r5.dtsi
@@ -73,3 +73,21 @@
 	clock-frequency = <25000000>;
 	bootph-pre-ram;
 };
+
+/* WKUP UART0 is used for DM firmware logs */
+&wkup_uart0 {
+	status = "okay";
+};
+
+&main_pktdma {
+	ti,sci = <&dm_tifs>;
+};
+
+&main_bcdma {
+	ti,sci = <&dm_tifs>;
+};
+
+&ospi0 {
+	reg = <0x00 0x0fc40000 0x00 0x100>,
+		<0x00 0x60000000 0x00 0x08000000>;
+};
-- 
2.34.1

