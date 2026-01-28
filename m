Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44DDD25B4C
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 12:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAD1183CEA;
	Wed, 28 Jan 2026 13:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VORfeM68";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A7C683D0F; Wed, 28 Jan 2026 13:24:51 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5DAF83C65
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 13:24:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppEUvOWX1RDVFNFAonP3sCRgttiq5tzQ2tTORC0GFTEqKVOsMLkNwKIUC9XlMTD/KX51NuIyB+m+vf4E8yEU7UYE5M34IWYR6d82WDwdLjGflRsYf8gGl7vJvuFrDnEE0NXUzQrn7Lns+97BcWZw8YTSMNowRuNjRfRTPnxCBhhbsGwSOXA4flgmTgvsZ3sXpv3e4ZxSYVa0+rb4B/CnJ5XBrlIzXa/p7OI/ofrwVvXTF7MTd4PvyITDDu/VsecAQdJGS7qo0dosCLEHpk3d80ZwU77NJgkRk3C0qlwl0dxZHuj02RIc9qZkIyN6oNf4pLMn9Dw8o7MkEjErVC5jUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTZhqkXl9T5XE/nyeFzeOebZ9xBv+9S2QbSY7FaDL9M=;
 b=WSKZoIAbzBblrcz9GlXftY06Rmcs5dWcgwgd+V/HxZtz+GM9ixCpaR2EFjudgPWFj97TLNoc3l2fuqNniIvk9/BC7YotPpiQ2ApTVcubNuoxo79PsEn/tDTVUUE7Ba0gxzBnOzZlaUnntOEgnd1ETn0TS4xVA8OsmwxPNMPh/ccwtlw7VQbb9EzghirNWyw/RcdCw8tm0SHb7JFv/y0OJcz0mlYlFKjHVwFDCSjpfcaEwweHf9UeoEKZ3omBdz0Aqjz2IgVtdwt8NKSnrevbLWZ/vPIpPwHI3jdB7rc0PZGDIPAXIoTq/UlwhsfZcNm2MVO+fmTLPo8WX/2NoJeNEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTZhqkXl9T5XE/nyeFzeOebZ9xBv+9S2QbSY7FaDL9M=;
 b=VORfeM682fimMBdePHNlEwHvDkxlJHhIz4YnwBqHS+hro8Y0xC+O3+k0SlKfHAjqR75lpaNlFrXQkQTCDIZbVV4uLkzH95sIU4HYwocT4P+r0K+SbdIhXIIDAQqxlb5k8Yno+Zz5kCQ+QI3yVytIdCZNJPaLzwFPaOF53+RTjJU=
Received: from PH7P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::11)
 by BLAPR10MB5060.namprd10.prod.outlook.com (2603:10b6:208:333::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 12:24:46 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::cb) by PH7P222CA0028.outlook.office365.com
 (2603:10b6:510:33a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 12:24:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 12:24:44 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 06:24:44 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 06:24:44 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 28 Jan 2026 06:24:44 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60SCOgJU2344654;
 Wed, 28 Jan 2026 06:24:42 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] PENDING: arm: mach-k3: manually set the main_pll3
Date: Wed, 28 Jan 2026 17:56:00 +0530
Message-ID: <20260128122604.2735602-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|BLAPR10MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: 5309dc82-51ca-4f2e-6431-08de5e68387c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wieN/AH+0DxJ6YCH1276E4DcP94+o3aCe75GxMSeq1koEpI5CNDiOTdBh9Cc?=
 =?us-ascii?Q?d8xhQTvD79LM+2BDZ/57Jr8qi+WhelyYp7uGlngnS0mBbRX8pidrYCk+qHVI?=
 =?us-ascii?Q?J4xlxNYij4EhsgdyQZsusHU6PFRWvWduPgDQwzEIjkP+XosPyk1g3FVUVf/j?=
 =?us-ascii?Q?/yS8+DODXQ+sU+AK3T72xM+HUvgADRY9ZADZttpTQldZGXl4rOD5jAk/X3wZ?=
 =?us-ascii?Q?Ufe3CXsKdh/pSL4YBCEWrM/5g/cePN23ZV9g5tnFYHVKGNRzvfm5Ca97SmXE?=
 =?us-ascii?Q?RFVt6OmvRpBBO1Q9eB9rrfLic39hG0PmDSS5xYOag8mEdbebMiQaQ120m4rS?=
 =?us-ascii?Q?pJ4eCTMY29pmNBJdLz8q3gH0583WNkkI5OkJdpL3OhB1IvRyKt4o9YOGsi+a?=
 =?us-ascii?Q?3X1STo/JQ8t7morNf0CFSXiv3sQKsZN5TkACL6GC6Erca0IhgYchfNTsiSNz?=
 =?us-ascii?Q?DBURu7+B+TUO8NnxgDbNRkq5UEvpqEMBY4iCt8QDehrl5ItyEXVqM3mp95yc?=
 =?us-ascii?Q?eiUcf1TH5wHESZsz6BSte1ZCeQV8lmfua5kvquSZ7jOC50+iQlwcri7Dno1T?=
 =?us-ascii?Q?GxK2rcmTlJBHlynUqPvzZT1JPYZiJGQNhT/5deDR0SbSl6lvJHLwat+bCKBh?=
 =?us-ascii?Q?8Fo1IywjPOIRL+Rxn6CmhHgN3vmurO93glP9tWO39qvF4OZbf2p+8AgsNGUV?=
 =?us-ascii?Q?8C74R1edmB1RI7gOInzOJv5D1x771dLm89o0aYUajE1rTYt/saI3KRYETSyg?=
 =?us-ascii?Q?CZ/NwnEfgtRpIsyW7az8DCuFVRAu3GyQP9E5YduqGIxSwkmbJfQ6LRjmY+ax?=
 =?us-ascii?Q?BgLoRJNyUZTcoORVh4QdK+HU6UtQrYbPEKce5g0wf9Vll+yF2J7F9jRgEiDL?=
 =?us-ascii?Q?KOUg9SP/MvGl8UZPKhgLvLtFNPW5Ixf0mxp5CJgE3yTIRY/FFNbGYOcj/DPb?=
 =?us-ascii?Q?ayCYrhLI9ViWglFibWFmab72KUUF2rEPuFRdZ7TggfRXw9pdJCQotifBc2Pu?=
 =?us-ascii?Q?N9TtBoMv6Rb3ksN7BfoskTTc9KSq1FdwGFNLeDcrNR8pZ6Bt3RkNGataOdRS?=
 =?us-ascii?Q?+YuDS1YWUHSbvhwrYZs2RbfAe2hPG0bDB8je2QzDkrlaLz1SfhJmWMX4RZDK?=
 =?us-ascii?Q?DbhD+Vl2D+/vvH/qsCzOdjfqVs/Az8bAM4ks7NsLAa85DwMO25+pAKlRGIRV?=
 =?us-ascii?Q?rvARzAIzh9h7SJ//tT7UTTs3Q4esRubykInBLwknQpFzHQHf0VpOWaA5h6ri?=
 =?us-ascii?Q?mTav2wuizCFwV1zQ6IR9oWwwsYpuX8k7BEWRMLbBVc9mt38Otit8dZ/lgXez?=
 =?us-ascii?Q?n5foywBN7g2cvUFCRHYhPHqWzIr2SYAwuHJQ/pFeeNYfYz7LeVW6/MFvScNY?=
 =?us-ascii?Q?yXM9x8/Hf97VLlbE9saIpWStNfksFdUrZdRwTQUuGfje33C0najbggSx3jt5?=
 =?us-ascii?Q?Xf+sEtb7YLF5+6pgx+3qYoGXbo+WuTD3l3QglzumcDkhGzmkPLjWz76cgR/L?=
 =?us-ascii?Q?4B0cYl6JICQ1ZMSSytp6mwiVjrEphWkWR12LO4JfCmPy2/7Nw99846bwZ43h?=
 =?us-ascii?Q?i28FtpiuW7J2p0j8V+bbjz8GIvZ8A2pp5nHrfA3EkBtsfSMSueuhWOx68laF?=
 =?us-ascii?Q?cryNQpNhUshJuho5rd/fE8GFLAZlu5ZRa/jGWKjmHnjAzcIPOz2CSPo6viJp?=
 =?us-ascii?Q?CVTOhA=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 12:24:44.9641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5309dc82-51ca-4f2e-6431-08de5e68387c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5060
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

From: Bryan Brattlof <bb@ti.com>

Moving forward, DM firmware will no longer mess with the MAIN_PLL3.
This means MAIN_PLL3 will need to be manually set to 2GHz in order for
the CPSW9G HSDIV to have the correct 250MHz output for RGMII.

Signed-off-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
431f1ce46bb Revert a number of incorrect commits
of the master branch of U-Boot.

Regards,
Siddharth.

 arch/arm/mach-k3/r5/j721e/clk-data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/r5/j721e/clk-data.c b/arch/arm/mach-k3/r5/j721e/clk-data.c
index e4511092c86..bb7f61901b4 100644
--- a/arch/arm/mach-k3/r5/j721e/clk-data.c
+++ b/arch/arm/mach-k3/r5/j721e/clk-data.c
@@ -539,7 +539,7 @@ static const struct clk_data clk_list[] = {
 	CLK_PLL("pllfrac2_ssmod_16fft_main_2_foutvcop_clk", "main_pll_hfosc_sel_out2", 0x682000, 0),
 	CLK_PLL("pllfrac2_ssmod_16fft_main_23_foutvcop_clk", "main_pll_hfosc_sel_out23", 0x697000, 0),
 	CLK_PLL("pllfrac2_ssmod_16fft_main_25_foutvcop_clk", "main_pll25_hfosc_sel_out0", 0x699000, 0),
-	CLK_PLL("pllfrac2_ssmod_16fft_main_3_foutvcop_clk", "main_pll_hfosc_sel_out3", 0x683000, 0),
+	CLK_PLL_DEFFREQ("pllfrac2_ssmod_16fft_main_3_foutvcop_clk", "main_pll_hfosc_sel_out3", 0x683000, 0, 2000000000),
 	CLK_PLL("pllfrac2_ssmod_16fft_main_5_foutvcop_clk", "main_pll_hfosc_sel_out5", 0x685000, 0),
 	CLK_PLL("pllfrac2_ssmod_16fft_main_6_foutvcop_clk", "main_pll_hfosc_sel_out6", 0x686000, 0),
 	CLK_PLL("pllfrac2_ssmod_16fft_main_7_foutvcop_clk", "main_pll_hfosc_sel_out7", 0x687000, 0),
-- 
2.51.1

