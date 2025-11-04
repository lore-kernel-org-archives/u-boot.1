Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E9CCCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 11:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65949838EC;
	Tue,  4 Nov 2025 12:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sh+0BYol";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB9F7838E7; Tue,  4 Nov 2025 12:19:54 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazhn15011023.outbound.protection.outlook.com [52.102.137.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F589832AD
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 12:19:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/0PExkwpgDfOgREauy9G3joLIZydwS5EIrjR4wHDyQ3wfklwbrVMd2gtcbjupToRTnDsL4cHmtL7Z4PGBbEhP1P14rKGjLWiI/iSQbJPnzUmSiFbZQEKjA7qbUMxOEevSGY53XsTdti6rT/gi9T0DLDLgEhReYU97BJVMoCkde3DRtXomy4TfT80ladyBlzin7j6fZ9KYTkWElcZxqVrsFlb62yw88bueO5AAjHOYQFtep2FF7Veu2eKGAXGunZlDhTjqugnnBEdUFu3X93vQq659xtAFFkiTea4FaJXHhtVnqzZZIx8n2nJrobyYFSf6cqNAqxVrBFsSxiT7GW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IEDpcuyg2wxSHTHD0xAMnBRwGwCoXGOV01YHaRZZUA=;
 b=RwRrKLxJTkUeqC8cHQJ1bwpHiw7xUsGn/d+J3fwt9RlyqTNJHDKO4t1Jzl0MzdgjnTFGsoqmYsqyTU+CMK2bdyU/4wcoostkQTbAWUQmGloPgphvmYFdMmZbQgH6Ucx4JdfEQc0CJs4uVg6Y60Tp8E/+O5lT5BxZWLk4V9YpLwDCcLre3DZF1Uty+X3xhJtW2sxXE4sln12p8Rvu/4Mor4ppqseErcd41WsJcATCDq+MkxaImo2Ve5THPgCfud6FnQFXRQPzqzZD8rvbPMydcWLldNlN9ekYSQ2s4KN87R0zujMNOKnsq75FYWw8JcyPBNoLeL4kzbfib6Cm5/4T2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IEDpcuyg2wxSHTHD0xAMnBRwGwCoXGOV01YHaRZZUA=;
 b=sh+0BYolxUnick4MwsRoiKJ0cec3zC4uW1K2Y0NY4X5tdlvFzYSyE0ty49cQsk7+t/AqckTlrrSCjje7eLxh4sp/62StnxDZrmNdJbwdFDQPJZJIUF1tAq+QdjhUWROUzRpIJhVQz5xrgWkMpzufRKxJpsVxIBDZC6qRVLSD1UM=
Received: from BN0PR03CA0037.namprd03.prod.outlook.com (2603:10b6:408:e7::12)
 by IA0PR10MB6865.namprd10.prod.outlook.com (2603:10b6:208:435::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 11:19:48 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::45) by BN0PR03CA0037.outlook.office365.com
 (2603:10b6:408:e7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 11:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 11:19:46 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 05:19:42 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 05:19:42 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 05:19:42 -0600
Received: from localhost (kamlesh.dhcp.ti.com [172.24.233.19])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A4BJeBc1821262;
 Tue, 4 Nov 2025 05:19:41 -0600
From: Kamlesh Gurudasani <kamlesh@ti.com>
Date: Tue, 4 Nov 2025 16:49:30 +0530
Subject: [PATCH v4 1/2] clk: scmi: fix set_parent support when CCF is not
 being used
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251104-b4-scmi-v1-v4-1-51f101a6f8c3@ti.com>
References: <20251104-b4-scmi-v1-v4-0-51f101a6f8c3@ti.com>
In-Reply-To: <20251104-b4-scmi-v1-v4-0-51f101a6f8c3@ti.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Tom
 Rini" <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, Maxim Kochetkov
 <fido_max@inbox.ru>, <d-gole@ti.com>
CC: <u-boot@lists.denx.de>, Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762255178; l=805;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=yyozV8/oAttMnD863ICAjIa2+dz2mpZLekvsKO+wXh0=;
 b=4Do26KCcLukpCXDeluJ/4dlObSernvRmLuQqj4oUVfof+IwrMcYPRsYyqcODIGvPqSQeGs+3S
 LmcSwVOSal/Ad5U/qgQtvXLkx+8uygkqChuyZuf4E5tUOr440ZUiQBN
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|IA0PR10MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c5e3847-7cbd-400f-0c53-08de1b940ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|34020700016|36860700013|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rnc3bVFsWVUxZDFQOXNtY2g2eG9pVDM5QS9BdlpldWZWblJvM05FVzZvVG1x?=
 =?utf-8?B?N2t2bGR6b0JBTVpVdklqV0Z6Tlc2STNyT1VpRWo1bHVlWWE1QjFucnphZ1Fl?=
 =?utf-8?B?MC9LcU1PWkxiMGVUVWVWRTA3blZhTEF2SmlCcVZJTS9vS3B0SkorNktPSW1a?=
 =?utf-8?B?eWFlajZCN2NrNTVCMFdEMHdtZ3lsRlJHWnpsZjlFeHVKUHdFaHNVOVoxcnA0?=
 =?utf-8?B?OFJMNUREaVdJYzlnVEt6K1MvcjJueThyM0RTVUE1TTkzZ3Z2N2pYSWVPN0ZT?=
 =?utf-8?B?azJxTGkvVm9Qd3hwamtwWTNFWjZXMkFzMmZ3UlVubkx4akVhamdpRzEyMVor?=
 =?utf-8?B?UkViU28xS3BRN2grQ0FjVU4zeng5N0RIdFZWRC91M1o3Tnk4MHdkYVcweGo3?=
 =?utf-8?B?T0VxQlhPeUVDdTFGZlZkY1o2aEsrcS9xWFVEVHdvMGF6QTFxRHY5NmtObk5L?=
 =?utf-8?B?MUdTLzJhVHBzbGJnMHZyZStlOHNMV1pjZElNL0pFVTF3aXBTVTNhOGtKaVhn?=
 =?utf-8?B?ZmhRTWk0cjNlMG1Xdi9DeWJGN1pXTWlOemRwb2lOUjZLRkJweXU1dmlxZHVM?=
 =?utf-8?B?RVltZkduN3owdUlTUFh6RG84V2hBaVV6MVNMT0tNN2RSb3R0QU1vdEs2T3FB?=
 =?utf-8?B?WnJ4VGtmZmMyRjl6RDdRKzNGUEFhdzFIcHZtOEtReFBrZVc4TFEzeFV5Zjdh?=
 =?utf-8?B?MWg0Y2VYcnM1c2RzaEZkMmhGRVZuMENKL3Fod1gwams3OXJZVGNuT2x1Z01E?=
 =?utf-8?B?bkZudDMzcllzdU95QU8xVHVyZm9mL2RXRURhQjV4K2hSc01lZ3lZUmkzZnVE?=
 =?utf-8?B?eU9rM3FBb3ZWeWRNVFpBVTVxcTZaVm5HNzA4a1cxTlZiQjltamk0NUVhV3U5?=
 =?utf-8?B?cEVDdEM0a2wxeTEzZmkwb09FMnBvdGpWK3BOSnZBV0JXdUxHa0txNVJDTWFT?=
 =?utf-8?B?ZkcwdGtONTZKa2dtaVVMWXd6aEZ0VXFIV0pCdUNiOEYxdUR1Uk9NeU82U3hp?=
 =?utf-8?B?RDhDYzBGcmxCZE1qelV1SzU0eTE1dFA1eDlpT1E3TmhvOWFFOHNLQ1NsUDlF?=
 =?utf-8?B?eno2anBrOUpVN3QvaEs4VEpLUGk3YU1odTYzTE5XK2xuWHNIbGZzRmlkdzdZ?=
 =?utf-8?B?U0VZb214Y1JuN2wxRUV5NERha0x6TVB0TXdDNTltOTRCSVkvdUVkTmxTYWhJ?=
 =?utf-8?B?Yng2dlQyT1FueUl5LzNJZzl4YjF4YjNMY1diMFovUUhBZmpMVFZsb3dNeENU?=
 =?utf-8?B?TGNJMUVwd3IxWGdDS0owb2V3b1FoTkFhQ1lKZ1hFNlJUNzNDd0EvQUF3SWNm?=
 =?utf-8?B?UnRaK3hSM05vaFFsa1dCQVlqSW1qbGkwTUtkL1oxMXpVS2FsUmRzVUxXTDY4?=
 =?utf-8?B?N2NlMnJxUEhGaWwwMUdHTVlRY0d0MEM4SFEyWW1SOStRTUFLMlI0YTlmSHpF?=
 =?utf-8?B?cVFuWFZlcnNCK0tVQkU1SnJiWFdrc0cvOWQrR1F5NjZhSmVqNy81WGRTY2RG?=
 =?utf-8?B?bThYK0dYV2piVzE4bzhvWFNrSlgvSk5sZ2RBVFF3Mzk1R0xBSkxBd2RyOEZD?=
 =?utf-8?B?anZMTy9TVHlQWEpXbEF6Q1NBbitvejM4bHB4L0hGMUJ3Mmp6ZWdQclZFMzVa?=
 =?utf-8?B?cjNOdEI0Y3ExSGtlVnpWMGhKQWpTQzR3NVJESkhiaEdIelRaME41N0hUOThr?=
 =?utf-8?B?VDhsYnl3bEROU3pMZHRTT2hTd2U0TDljL2VCN016NHhFK2UvVnB3TFFpc1VC?=
 =?utf-8?B?MVNrYUNwTVFoUFNydUNndjkwZUh3WjRFVE1meHBMd1BhUnM0M2I4eHo3aG1r?=
 =?utf-8?B?eEpBRE1QQ0ZWd1RKL3phWmhwME5wT21JVEJtTU81VWk2bHFGaU9qZ1d4djgv?=
 =?utf-8?B?SlMzaFN6U253ejJwbHF5RFN6bTg3Z1ZFclF5aTVFQmYvWHlid1k0cmZabXhE?=
 =?utf-8?B?SjE4cjBQMmhYYlhVV0FyUXYzVUVpeXhXak5hZlRGU1psMDVEcDIybXpVaXpu?=
 =?utf-8?B?bWhKWFhPVVdTU3loejF5d0xXYUNrUlRRL2JySU9Tc3FIcE5PR1dpV21GV1Zh?=
 =?utf-8?B?MWlTSVozREdEYzIwYng4cU1TcUxNY3VXK0pZR1hyYWZBMG1Sek9rSEV6b0F0?=
 =?utf-8?Q?YnK8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(34020700016)(36860700013)(1800799024)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 11:19:46.9416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5e3847-7cbd-400f-0c53-08de1b940ffc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6865
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

When not using Common clock framework(CCF), calls to
scmi_clk_set_parent returns -ENOTSUPP, which should not be the case.
Fix that.

Fixes: 15fdfef6642c ("clk: scmi: check the clock state/parent/rate
control permissions)

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 drivers/clk/clk_scmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 0c9a81cabcc..83ea7bb4286 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -359,7 +359,7 @@ static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 	int ret;
 
 	if (!CONFIG_IS_ENABLED(CLK_CCF))
-		return -ENOTSUPP;
+		return __scmi_clk_set_parent(clk, parent);
 
 	ret = clk_get_by_id(clk->id, &c);
 	if (ret)

-- 
2.34.1

