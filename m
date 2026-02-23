Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C625E98DED
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 06:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8036A83D0F;
	Mon, 23 Feb 2026 07:19:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dtUsK9Wf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F31E783DCB; Mon, 23 Feb 2026 07:19:18 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E9C583935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 07:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4lv1keGnt6pOXJzjLm78FMYHqGowVbkJngXGBihF/dWifJNiuAzWyWRwo0mK1pmpJvUcZbbc0LSa06YKFpleCpIk3caKOSn/uWiY5uC0mx+yKY1nmm1cjz5SBg9Fzb8HK6SL3v22Zi9gikJNpi8SQw6ADxqfYqiszbY+Q16X4XixhF046YRuFCoH+RKbhtGgqQrkBrmZIr8JYPuO/QzVFP3HXKPanNhNFn0h4pBlBL3r2SmCqYI5nYnKqDHrT74aJaBYWS6LGtMK1Z4/b8VhlIFTYsBUDE3ZQDM0aEJ4oFsCYkSvtQUzE18KgXJwJJiJs6KKX0ou4bWtqjYThVFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCx0yDpHLlF5cJ4Pw0tF0Qjfi0/ywApRHq4I8QsiPIY=;
 b=cAtLgxGRDiZwEhAsBjWluPCOaWYUfDr7+V2AAspCbZl3WaIHdR9OXfNF5gXL6tWXyHVHMtdPnYcbcw05+96BtER/9joQnUFwn0RvXXarFMcYoStJPp3t2AptS5mqCGY7akGXaUp+hLhiSv1E0l+mBy5HbjmpCdeyimExRq++byzGH3oLZsCzQFd+7r+UapjzTlx36CbNYEjNMJiZ7Qi6NA9aTTTjD4LcpXDVXVu7mcaJF92Idc+e48BiTm2pMc/eqNMxaUzJWzCZw/H0Z3yiV+DMjvx8VkVYByhejRVjMGW5kOFhWEkow70rgFJ1lk/zSE7iRCFMKBn43ctMdlPREg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCx0yDpHLlF5cJ4Pw0tF0Qjfi0/ywApRHq4I8QsiPIY=;
 b=dtUsK9WfQZSbG087m5odJQ6M+SmdhYUts0orbRN60Ro9sbJefG3hrFOhcXPf2VByZJHbzhEgyWn+XPFXMYAHZh64xeutJK8gOSvUu+q7cTUzeQIDJYHbjcvzMvlhyFQZQ6n3k3t0ATXi+ZiROyNl1HARb9A7A3U84uGplVnUXIQ=
Received: from SN6PR01CA0010.prod.exchangelabs.com (2603:10b6:805:b6::23) by
 SJ2PR10MB7081.namprd10.prod.outlook.com (2603:10b6:a03:4d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 06:19:12 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::24) by SN6PR01CA0010.outlook.office365.com
 (2603:10b6:805:b6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 06:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 06:19:10 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 00:19:10 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 00:19:10 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 00:19:10 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.233.254])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61N6J7Xu3992071;
 Mon, 23 Feb 2026 00:19:08 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH 0/2] OSPI NOR boot support
Date: Mon, 23 Feb 2026 11:49:04 +0530
Message-ID: <20260223061906.1794872-1-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SJ2PR10MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a478ad-4349-4a65-62b1-08de72a3755f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wXtNdTecgQs+o9RWilQeD1gOxpBMF1PTltivCv8YWpEwOTOhYXSwYirN5enu?=
 =?us-ascii?Q?pXXV/ch46N3e82g1WcMonvTU4API/Oc/vUaAFPHh1MwKGRlLQkRX7tyz0cso?=
 =?us-ascii?Q?18+M3qryIS7M6Cmz8QZY+DS32t1v33mh16sdpPyKmi3dJ31XhMv+Ds82mKCH?=
 =?us-ascii?Q?jcxnt2/BwJiXTWcPBcSQQ9RpjmoRvEwEWXy16XBLlAZ37fA0CaJ2LTmYsuNw?=
 =?us-ascii?Q?QLjbVWz7Q2EbNXWDlpjLxWM6HLXB/PU1dLpzvTfjH1NVM7KBenV+chMVx8Q5?=
 =?us-ascii?Q?FOOG7rOvN2NR0nz+6f5mRcB1j6zsHUW+BpfovQ8ZthxCHECiGIEeuP4IVYFy?=
 =?us-ascii?Q?ICKGDFI+Qe+V49nAipxWzACc5bFRl6Vm7KmZwpWp1xyHUNRseM35Y26OnK71?=
 =?us-ascii?Q?xXwaCATyRipLMd6luXZjF002cg/qWXmePygfDpCEJtUDFy1JiJ8orBTCZvtb?=
 =?us-ascii?Q?9IUtTE9Et1Ydk7+wK0vLRYjehj56JbhaS+Vzg9pyHJbsudfLr3P99i4cQEbv?=
 =?us-ascii?Q?y9NE/ulLG3LPKM6G6ke9QLpfOLfZ8Lvu08155LRU91tFzhSzklEKyB9UTz8y?=
 =?us-ascii?Q?A5VcGbwjSSP8ygrRuh9bdeoD3q5xwZUHbojuocLmtX7DXEz3AMMFo5qrt9Sd?=
 =?us-ascii?Q?iVGOYQHZS61+IFry36AgH9AUHWcH5fxTD3JfUo8b5Kwv6E831yxRzdKPMy/L?=
 =?us-ascii?Q?qA4XZQKLlVUWVQyL/n+wgzg2Nbvuh3epOZwle3zKbxWJKL461gpAZAD2PRDz?=
 =?us-ascii?Q?WU6ZaAhN4GMcS2Zs2bS3eUjW17jjTlwBklcd1GYukwuJzivnKQVvViZoJ5xx?=
 =?us-ascii?Q?IaXn+R9aa1hLbT8eWv+qKQGxnAR3fOnhzt6FZ4E6EjRPVGJ62VhSNYdlBYpo?=
 =?us-ascii?Q?U9dXVMcvPtEo5S0uJUWlHwDi3+l5dCrkpWsuVOevnNwDEQz7wZz9ylB8Q1Q1?=
 =?us-ascii?Q?X1fHU8DkKlLIoqFOdK17Dcoq3VhIlIN7aykVjUgje0FF/TNoNwZDqOtsMJIl?=
 =?us-ascii?Q?GjU9FlEiuCz2auLtCzNHVuFHiw7dcOuPRaZtOrJLmgLKDcO2Kjx4ekBen1WE?=
 =?us-ascii?Q?zxIxnqKRCDjmEt6CLCb8TQ6/sZEW+TVqC+2dHA1cQlIPE6SFmse33WIR21do?=
 =?us-ascii?Q?7zzFA7AdrPp2gT7FcENQ4WmfVJROOTnCkWP9Gy45+ZCRWYg4mSIT3ZzOZ1CW?=
 =?us-ascii?Q?Jtl/DnLGz5tWuSugCNNQB5CeImSNM7iRIpwgSijh7Gd1HSmxh6QiNva154cX?=
 =?us-ascii?Q?zAh1AhppfGk/Zcipus4xPUBLZ1XRVw4sODj7nyJTtZ8FoLWdsGPco6cwEMTv?=
 =?us-ascii?Q?Y1FJ0QUvm8ShjGyglgVXTgguJD4d9oLDcHtMjkUBXKC32wfHnSR8ZDFCJx8b?=
 =?us-ascii?Q?ZdLWK1aNuHAZKPeb52fSMFr5ebxs+aHWL1ow2t91id19dYs22QZyjmNqtIoa?=
 =?us-ascii?Q?SEg8OSyl8Qspkz7SqxpyRCo4F2/sXyaHZMznNOnLfPmfIGHkQNEr249Ts5VM?=
 =?us-ascii?Q?mqMD5cTZ4gOywtVPAOecceNVBSDfJJ6s2iTpmMYTlZEh2LdKM71dpbuJGlxf?=
 =?us-ascii?Q?DUVN/zizOlp81ozXfUL+wtEWKNHLJvs3rv/Sl9TlRg4JUbKuYA7761WJ63pO?=
 =?us-ascii?Q?Fg=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xc9jGEGRJg/A18aK6tVhZCqHHt8HBzjiGO57ikN1Xav2qSqHOVA3V+LDDXL3mNPSPMB3tFTu/fx2WIkJpuYlknzij65MlH4gynaGyzPYR3Cn3rEzMsFtebAAHI6dpWqi3XahF6a2VftzV5jwZgYNttsYWYDQrM34q1T6lyGy/lZP7+HYxzDhvw3cfbpGUwbdaN4u1lKARr/olOYROaANelX0iIAhukEhNgxUbutskPTECLhNEx1Iu/bV12e9spMLZQ2ooufNQ2O99L2EUbTAstO1LP3FOwm7FxO1Kx4sAuGVWf2odfg2f0j45SZs0ePZFwHa5DiQ6Y8ppzHlvucxTN7t+4Sj61ILdcWc7HYwy7hoR91O5A7E2hFcs8jirP8NUDK1UUC3Ja7qH0REBm5gFgowUz9hKq9/vrH+v2N5QCgqXZRT9uAkGP2RtjDGpZV2
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 06:19:10.6981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a478ad-4349-4a65-62b1-08de72a3755f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7081
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

TI's AM64x EVM has an OSPI NOR flash which can be used as a boot media.
This series enables the support for it.

Test log: https://gist.github.com/santhosh21/638d1b3c97e77787c8c5e59a0ae43824

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

Santhosh Kumar K (2):
  configs: am64x*: Add OSPI NOR boot support
  arm: dts: k3-am64-evm: Add "bootph-all"

 arch/arm/dts/k3-am642-evm-u-boot.dtsi | 1 +
 configs/am64x_evm_a53_defconfig       | 1 +
 configs/am64x_evm_r5_defconfig        | 4 ++++
 3 files changed, 6 insertions(+)

-- 
2.34.1

