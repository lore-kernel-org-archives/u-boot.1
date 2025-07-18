Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41A3C83F17
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 07:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B84D98350A;
	Fri, 18 Jul 2025 09:04:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nm5LJ/9m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A1978353A; Fri, 18 Jul 2025 09:04:50 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B1A18331F
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 09:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJo3mp/TzxjlaJ9Xu0bcnjoqi0d3gYUzxP/K/oce+49tkNfRL3ER0ROuFtfNk0KjlVrEur5ZrZU1Ph40L4cGlcVVIThEvKSn6GSMMsPnnJMHR8mvOX1UCKza5DKcaqb0vlS05VuMG8LvLiRVIYLtXHtc9l5ftGPjggYp9wg1D4IixRbauFQ2+qLZ8uIegQkiExH3SJSMcWf5BSjk5OMDgwNHXw3/EM/z4UB0cSyFc41xWW1m8l69uXQkL5zpNvmYhw7POmyh3PtyXP8NDa8Xt/tWrnMb5Ys/Sp1iTrLWYXQK08Clfg9ed+fhZjVCA3KfUMDV/cjbxXR30rlp++ptRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtC2vO0/DJmYBqKCcIT8PN8+ype00fkgVfnEHqhLBM4=;
 b=W8ZCQssYUSJ8I7wTM6TG1yf/EjwpV3hwqnCsqEM5nI78zUZIWzlGr/aMoC6G1cizbT91HSpuOVzUeCyd66SM+NLeb06LjI/qKxRDVYK//W55RwCyYu508FjdQMazh/4yZ4SQiYIjK00X0124vh/1VmwnCCZcRogDhh0Sz1piLRgmciHn0nKXRCobB0bfwDlswxxTIbF0U3onWDujgsdF5EH0Pzz9zlCZGftqzJRHF2wkD8bSbGJgNpy8FRY2d1lV7mXdRQzuhrKk/VvNAA3KkQqU0jw9IW/AInDLHwuI6ZeVI5cgse02imhZUzBBHzXWwHhtvTVEE4elVsBjh0MjZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtC2vO0/DJmYBqKCcIT8PN8+ype00fkgVfnEHqhLBM4=;
 b=Nm5LJ/9mpG+kXeSpTxvWjfPJM7IeN43oouZDtjCFJq7SFnABhVVkkUVLochRiAqfTtsmPTYd3VKHHmp7OEynOMROYUZcOd6PCfc3rxMwR6/HJwy9AqDOW60B6yFvWFtUKmPbKMDtsCmpLHGvncT6tftYAuklciznKSFVpfIflTY=
Received: from SJ0PR03CA0372.namprd03.prod.outlook.com (2603:10b6:a03:3a1::17)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 07:04:42 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::90) by SJ0PR03CA0372.outlook.office365.com
 (2603:10b6:a03:3a1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 07:04:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 07:04:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 02:04:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 02:04:40 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Jul 2025 02:04:39 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Let fit-dtb.blob generated all the time
Date: Fri, 18 Jul 2025 09:04:32 +0200
Message-ID: <c2952da3c064d67821cd166d2392db39c1d23b2c.1752822270.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=868; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=hda2s+FhSR7q1V2bfgT/AgU7RIqb9TtyHYnDsG8VlzI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRUfmKM+JygXCh4T+XohYDPCVYpFxRq6tu0jsp++/5kg
 bvmDv2zHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAnCRAwx/uMT+zf2er1y7Sszt
 W9zJ5iWXWy8qPil9uPHd/3UHjTRDuBgZ3jv0ef9ZU7U20lhJwvb0goV3dcIrJognH/xqzBsd8Su
 SCQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|SA0PR12MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e5d4cd-f3dd-4177-a4d5-08ddc5c95eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OlJJ6tdsw8r/myHvS1yhs/7EsE2iYjCKMNcEGZZqe/y7jG8cHjNTNoKyL31Z?=
 =?us-ascii?Q?7LLxnTJYvuCLQ/AshiprwyRAkXW08E7LKsF7gMyk2hxpnR6BoYDDTU/ASIRq?=
 =?us-ascii?Q?q9uem96th/O0oIatRidrNeMMauN4gM1Fu2UcRKa6ccz8NEEw969JZtwCGPvc?=
 =?us-ascii?Q?9UscIVAUZvv8Da1Nixra1LRu9ZRqTzGqsFTel2kbU2jy6ukQG9r/xwHYedrk?=
 =?us-ascii?Q?vwH7uUXlwrqUknMpNOz9z0Uu0EWDXLx7oddvyhvUDHbBpTqZcYSJrhWquZyy?=
 =?us-ascii?Q?st/QUgfRUeVzz+g3zMMtXyot3sP5BoeeV553LOj1tkqS5BVCEf0wqePc0ZpV?=
 =?us-ascii?Q?cuuSvo1R4Fo4GBpy8tYOnk34EH/fYTzob3lsgxkJfBm5oBHPkik0fMmb2MR+?=
 =?us-ascii?Q?7u4IfDHMD7YwfIso1S1d8Jp7nij2EH7OzTgansb+mIR8IaP0/gxEp1Y2FdFl?=
 =?us-ascii?Q?3SqVjvHwZJi0bt/tf8ge2AgYplzW1sdqQlxWLN3EwOBx/hi+T9aex0PWwhXO?=
 =?us-ascii?Q?Sm9r9N/QDv+FxfhYAnr4MhQkRO/IW5L88j0+9BUQSMQHZMFajkjzhHjtMmRd?=
 =?us-ascii?Q?MYszHGJzlRmj6T+0xuoTs100JnjVlPbvGjNOKQB/Q2b3DTdsHt0r6hS/gSS5?=
 =?us-ascii?Q?oFoM1EmHjlZPh/hgNBAyIgNZITpPZSMkAvjpbWSAekVd+596IpNQRQ5POGef?=
 =?us-ascii?Q?3g/lJL9p5zB5icSkfDuR1fCKk8VSm1qs3eV6RbryYSs1uGQueNeI5pqMUSPF?=
 =?us-ascii?Q?aSCcEh9YU+vlD/JcusasovcJMHre3kMvP8cg6wVxaKWPr7Hu5MJL0gg2+tFd?=
 =?us-ascii?Q?+g4e7Ib5P3FUkKLGLcNveFdlTu2CXYucJdjK9NmMqStvb3WjnvNk75tS5opr?=
 =?us-ascii?Q?NMXmtPS31t/yR5dT/6RNVlDMGZuDBNfAkEUhAvh55koH54Bk6cAaFvSI5RGl?=
 =?us-ascii?Q?d6A38F7yQp8bHVwMlV8gLF0uUZcNnrtroaSLj8aoaEJD5TyDRJDaTCN7+SFe?=
 =?us-ascii?Q?knrWzWfw/rnEWxMbMO9XiIwk4TS+mog2oCob1QlMQttY/9w851z3NZ+xtLTp?=
 =?us-ascii?Q?a7z5JDsOLA0IPrKViQkIh37K8UfVhW728qOIccYUdtGiQEriQSasICeNg8+B?=
 =?us-ascii?Q?aYpB+0b0tvJPYY2gG+YCFIdKgi9PBaFn6pgbE3lSpUmN+ynapWD454uiJiFe?=
 =?us-ascii?Q?A6RUqTPhcKL72BhpzFr8LmL4LNRmiy216BwCTQVU/EOF4YCeIrTSzM+pSKDw?=
 =?us-ascii?Q?mCeuVorErInc16ulbb/iD8pLBaX3wXx23rwCZvbs3hGpvHW/PnaL9G+mtGWg?=
 =?us-ascii?Q?8c0bf4hvD7AwhuqhvGSsMdkbcw9ohzoN6KiWKflkZMzWP2igafdlwwpn8k+k?=
 =?us-ascii?Q?Gn9+XjaLvTyQ+rZW51Ds/Bg9KsixIHgal1Eo5YvicMfydhqXYkWZuEZ7tglB?=
 =?us-ascii?Q?YeR+GJlwV4LMs/kAc33DaUvIZxUqqm1G7jFTM+eIhqScHZiFHzs/M8/GiV5u?=
 =?us-ascii?Q?w8f8dV8jjXrVmagE+IIntvujhc8MbDpE7ryr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 07:04:42.3936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e5d4cd-f3dd-4177-a4d5-08ddc5c95eb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349
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

There is a value to generate fit-dtb.blob even for cases without SPL
because flows with FSBL also require it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-binman-som.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp-binman-som.dts b/arch/arm/dts/zynqmp-binman-som.dts
index a70123feeadd..469b94bbde60 100644
--- a/arch/arm/dts/zynqmp-binman-som.dts
+++ b/arch/arm/dts/zynqmp-binman-som.dts
@@ -20,7 +20,6 @@
 	binman: binman {
 		multiple-images;
 
-#ifdef CONFIG_SPL
 		fit-dtb.blob {
 			filename = "fit-dtb.blob";
 			pad-byte = <0>;
@@ -109,6 +108,7 @@
 			};
 		};
 
+#ifdef CONFIG_SPL
 		/* Generation in a static way */
 		itb {
 			filename = U_BOOT_ITB_FILENAME;
-- 
2.43.0

base-commit: d6a4c0cd9937150c5c1c90317cf073c8a71ffda1
branch: debian-sent3
