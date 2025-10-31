Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12259CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 859CC83968;
	Fri, 31 Oct 2025 16:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fDmFmVRX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A10DE83968; Fri, 31 Oct 2025 16:15:50 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AE2A83952
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgkjIwgnp3FPqcCgJyXIr1GFit4biF64LLXalo4hE3EZ/omsEd43+euRpyzLUo/3KBCwhZEHuyWecF85wCXjHjq5q690AWoaSS+Kby6l1ePnvazbWiSWXPsq6SJZertFui8BM9IwSVQSJGcLlmZEGvSReE8XSPH4oncGvgyik8oOrKePaI4XUAd/ebWIGRAKNUjzIyfMaF1r4lq5yHeGUR+qXOtEpsaE3ZCRBGkWVTkCpielO5e2nNbJ610icKpNCHieE8XG6c+ujXa9GtkYoUjLiIjcqwSWY4Y+DUMQz8sFhuVh9T3An3oPeEIYIIWytGr+sJ57ldm6FEwGjuaCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqJhGvcaig2h8xkSFWf6fB2ZjPewqC4yj8dUsFfxWo4=;
 b=e5/de6VMCSbHn55j3XW6AMTZ9I3qfouG5xNMg/bpOy5+Xaw7yC2u2fFjvugUm6NEdmHZCR2wLTyRIsiCn4cy5zqi8lTobRWKwCEkxJz0YIF1pHTY2pSI/dQCzLZmfuDSnkRdNMQoJ7uE7JP8ZRuWXdKQDsuvQpDl3jLy9p+7SagwXj58lfdkHPXalFBcZWGflMySIwVFgY1bDSi+8haGfaCeiHSEDQMG5MuvnHLeHf4SoxjUmF2QTWj+7UMjl7I4XvqvXEhIGiARMLe80wAci4AR3gMilE1pYd978nmiFlioC2QwALIRW58QgU+qVYwUovhnW/T8w96cNFFk11Tq/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqJhGvcaig2h8xkSFWf6fB2ZjPewqC4yj8dUsFfxWo4=;
 b=fDmFmVRX7oB/TomzFCCiWBjZMm8Rg4ZG9z80yTlVF9cu7kfAzLq+/2kOPX0OL3qoCd6ZMzOgnKT2wiLE4jCnzR7qsjBq3tTw4Y0yJCzcCHRH7NN2B6NzdGNL97+GfaZG7AdKG3IzA7Z6E+SHAKINgWcfnnERc77S5pjXpRXuQYM=
Received: from MN2PR08CA0023.namprd08.prod.outlook.com (2603:10b6:208:239::28)
 by DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Fri, 31 Oct
 2025 15:15:42 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::a) by MN2PR08CA0023.outlook.office365.com
 (2603:10b6:208:239::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 15:15:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 15:15:41 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 10:15:23 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 10:15:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 10:15:23 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59VFFKcs4106032;
 Fri, 31 Oct 2025 10:15:20 -0500
Message-ID: <b72301e7-cdf1-41a6-ab9a-2c915f74d6b6@ti.com>
Date: Fri, 31 Oct 2025 20:45:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm: dts: k3-j742s2: ddr: Update to v0.12.0 of DDR
 config tool
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>,
 <s-k6@ti.com>, <bb@ti.com>
CC: <m-chawdhry@ti.com>, <u-boot@lists.denx.de>, <gehariprasath@ti.com>,
 <u-kumar1@ti.com>
References: <20251031053425.3960963-1-n-francis@ti.com>
 <20251031053425.3960963-7-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251031053425.3960963-7-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|DS7PR10MB5134:EE_
X-MS-Office365-Filtering-Correlation-Id: 63683e00-bd8e-449e-68c9-08de18905aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|34020700016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1lTK3JwaUZ5L2RGTnJ2YmdWWGxwdDNOUlNmdFcyallMUXJYb0wxQ1NqMyt1?=
 =?utf-8?B?VTcxd3JWUVRLdFlLZlBuWXJIQXBTaDNyUEZrOGFOLzBQSnluR2pDeHRIVkZN?=
 =?utf-8?B?TlQyZnJzZTlJbzAwRzJBY044cTF6NWYyWCswN21XZVpIR3d0dXovUGxpb2VR?=
 =?utf-8?B?NDdKeGVtUldZcEdyblBrY2dWMXdaRms0SFdPek1WL1RralRsRENyaWc1UUky?=
 =?utf-8?B?V3hiVGVCdGxQL2xYR014RE4vak9ySkxsYTdNSm9XSW9IV1FkaHJvRlkvdnhl?=
 =?utf-8?B?SWdsRDBtVEFGRlNKM0VVQmVJdE9CaGtYOUM4WTBDR3lMK0ZyM1AyVUZOMXpN?=
 =?utf-8?B?SmJZSXNvbGJYU1E1NFhNdnkzN04yTGNEMnVDb0w4TjVNMEl0SHprbHpFYytu?=
 =?utf-8?B?L0VCdDFvR2dHUHpPVWwxc0RncE1LT3BXTURmdEpNUk43cExGbnM2WHFNSjl1?=
 =?utf-8?B?SkhJVEhZQmlaWXQzZ3E0czduVUR0dC9qUWJsaFYrelZvZWZTb0cyMFZmNnds?=
 =?utf-8?B?OE5QQjdzS1pUZjlsSGV6MTBVYlRleC9RMGRJUStSZ3F0UUI5ZG9XZkZWWFBm?=
 =?utf-8?B?N2FQTEJVa1VuWHNneFVkVW8rV2l4R1VxbFk3VmtQcHIyNVpkOHU0K1Fad3I4?=
 =?utf-8?B?WGdCNWZ5NkxLUForUHhsRXJRNTh6ci9xM1ZpSHlmSUZ2bDkyWjlyQzVPSWpW?=
 =?utf-8?B?bUNnYmZrd05xSlM3R2t6N0FNK2RkcGVSNDA2eUJuQ1RBVDc1RWt0RCtmdE53?=
 =?utf-8?B?MXFhVDNBMi9NaFBKNkx6SFVvdFpBRTd3RWdHSXRHVEhjTkxMWndxZGMzOHRa?=
 =?utf-8?B?SllGYlU3THZoVjU3MjJDd3RVMHFYTUo1NDk2alVMMmltUTY4bGtJRm11akpN?=
 =?utf-8?B?SWlxV0pJSytaZFdqSFdiSjB2VCtBZThkMCtIcmRhVHpoUWozTGFJeVd1OHlI?=
 =?utf-8?B?cGlLaGZ4RnAvRWhnUHF2ODJpemlYL251aDJ5M2VLcnRRRTNkYTBzSFJQckdP?=
 =?utf-8?B?RmZ1czZ5U0kzOExBWklTRnQ1cjdEbmQ5Q3R4a3JOMkZOTGVyMi9FQURwT0ta?=
 =?utf-8?B?NTh2UVNDamhQMVZjVms2blljRlVDS0tOZmtjSTZrWkhrWk1vV0JrblJsbmND?=
 =?utf-8?B?YzF1UGVyeWw0eExvRlpqUlp0MzJCZTBoTEtxaFY0ZVIvaWVOZXNnZGh6bTcv?=
 =?utf-8?B?em1VdkhSWXZxRFdZRWxVSXpiSjRwYW9ndjcxRlpON0FickVGRVZQdHNJWHF4?=
 =?utf-8?B?MzFOUkVVa1NsZ2hEUmd0YjZWclprR2Z6RGpTM241Q3FjbUh3WkI4REh5YTRW?=
 =?utf-8?B?aGRsODJoWWR0cG0wVzRwUTdhVHJERWZWQVZzcHpCTkI0dnZPY2o5bGJxeklL?=
 =?utf-8?B?N2cxaUNTaE43a29qL0gzQ25SMkRpQ0NSeURQRndJK3Nld3AzbUxzaVIyRXN4?=
 =?utf-8?B?YWMyVUFrNDlWQUtRd3hIYzRxNFFEZ1MwTDRid2JtS1Rqc0lScGlmY2tqelpW?=
 =?utf-8?B?QVJpc3hod05zUUNhU1ZzZ0t2QlVEbm1HZmRtbEFrVEowVnM1Q2h6Y3BHd2Vx?=
 =?utf-8?B?djJ2SkN5OWlDZzNEY1JvaUlEdis4VUpBRFdGS2t3dmNlMUVrbElxVmdMb0po?=
 =?utf-8?B?ZU04T05NV2dZSHNiSjIzdk4vdUJhdVhrRGtUVEZlYTR3OUtOV1YwQ1Fndysw?=
 =?utf-8?B?aFJOOWpXd09iVStQT3oyeE14QkY2ZFlpUlB0bUxUUStuUG95NzJNeldBU2VS?=
 =?utf-8?B?SitJODc3d3c2N2NISkp1L0syRkZMYlNibzUybnJER252azNnczNzZDd3c3RN?=
 =?utf-8?B?N1daQnhjakVneFd0SndLYk1BRVdkRUpwQVRObjdjeFNneUJMR3phQnhmWGlT?=
 =?utf-8?B?OGhQeGlpUDB4R1Y2SjhUVTNacThyNDJsa2RtQkpHbnYyNzhQOVpwMnRiTU15?=
 =?utf-8?B?aW5HOU5nb0Yza1daWDdzc1hJczFhelF6d1lNd1ovT1ZsV2FJdG1WUGlQbkFI?=
 =?utf-8?B?YlMyMXRQMzhMdUVCVXlZQTV5akxWOWJPU3psQUxGV0RkVnJBbkQ4U2R4bDUw?=
 =?utf-8?Q?8G65i3?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(34020700016)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 15:15:41.2042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63683e00-bd8e-449e-68c9-08de18905aef
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5134
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


On 10/31/2025 11:04 AM, Neha Malcom Francis wrote:
> Update the DDR configuration for J742S2 according to the SysConfig
> DDR Configuration tool v0.12.0. Log of changes between 0.9.1 to 0.12.0
> is [0].
>
> [0] https://dev.ti.com/tirex/content/TDA4x_DRA8x_AM67x-AM69x_DDR_Config_0.12.00.0000/docs/RevisionHistory.html
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   arch/arm/dts/k3-j742s2-ddr-evm-lp4-4266.dtsi | 4872 +-----------------
>   1 file changed, 263 insertions(+), 4609 deletions(-)
>
> diff --git a/arch/arm/dts/k3-j742s2-ddr-evm-lp4-4266.dtsi b/arch/arm/dts/k3-j742s2-ddr-evm-lp4-4266.dtsi
> index a64d19b05f3..2cd21efbf93 100644
> --- a/arch/arm/dts/k3-j742s2-ddr-evm-lp4-4266.dtsi
> +++ b/arch/arm/dts/k3-j742s2-ddr-evm-lp4-4266.dtsi
> @@ -1,10 +1,23 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
> - * Copyright (C) 2024 Texas Instruments Incorporated - http://www.ti.com/
> - * This file was generated by the Jacinto7_DDRSS_RegConfigTool, Revision: 0.9.0
> - */
> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
> + * This file was generated with the following tool revisions:
> + *     - SysConfig: Revision 1.25.0+4268
> + *     - Jacinto7_DDRSS_RegConfigTool: Revision 0.12.0
> + * This file was generated on Thu Oct 30 2025 15:02:20 GMT+0530 (India Standard Time)
> + *
> + * Multi DDR Configuration (table based on register configuration tool inputs):
> + * |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
> + * | DDRSS | PHYSICAL SIZE | SOFTWARE ACCESSIBLE SIZE |
> + * |~~~~~~~|~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~|
> + * |   0   |      8 GB     |           8 GB           |
> + * |~~~~~~~|~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~|
> + * |   1   |      8 GB     |           8 GB           |
> + * |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
> +*/
>   

For whole Series

Tested-by: Udit Kumar <u-kumar1@ti.com>


> [..]
