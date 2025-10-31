Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FA5CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 11:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4418783885;
	Fri, 31 Oct 2025 12:33:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bbbhSKY4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9571838AE; Fri, 31 Oct 2025 12:32:58 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 604AF8331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 12:32:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9cA6CJsbdJbpZaMG8dKeN0X9uL3eNS1d5xakR3C22RBTKZQqUDlXsZ3Z2eTWSIwiTzg9hZIN7+FNX8RM4NWnNy/jvk0idzJ94NRyVmJht0awBxSxVlEVd7QHqJ4MhR+1CTFPZKE9Ynjyzg2DdYYircgUvDqMuHUBjynI3lW2jQA8j/NnfziE9iSUhRRYkPgRz/Xqx8RN/+GpP3fIOLubFZkeJJXmr/kDOEXySo1bpj8EhLeqF5JsYm63Ju5gZHiv/uGmkvp08cqkHFaHa0euM2LJA0qFY/hgoMLVZV4BaAnchrzZlfq5OsExPUaxNebYfku73DCqxEgeJ2VuFkxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fbzs98xEhAmBBlqC3uuBX9Px4scJcKYimM24oz6T73s=;
 b=jJa3ztt74zJutDT8eUgNb0iTqT1axWIYBwBa3cquIbWj1UIVmPiYohUtscns848SLBvX9Pb/Wo0neGegAxxEcZlyDOVIfB/MnrJ8GmNvsllS9AsCHETPbfva3TXT/bMOKoBo4bDiS6JsdR7QBWqfiDGP3anigy0tPDO0cGmbwKVVoR2H1XErtre7+q2cX02upb83EJgLCc0SgVUaecZ+sP0ZEPffOwZB2W5Z0sKo3WBtkFH47RpPWL7QckGj44gBIl/yP8asSgiwKGmPStAaL4Kvl5xdYIGWV7SHX50V1+dOWnvY+M/sgspH+eyyZeKSFbBbO+qLVXXReKVTmmM8MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fbzs98xEhAmBBlqC3uuBX9Px4scJcKYimM24oz6T73s=;
 b=bbbhSKY429xUYdgkXtkJe5EQAK7Ssd1WkET2iaisaHlpMs3+y/kJqJd1skPujWuvinySALpN5bVycpV+TYEsNo/sxB6UBLQGLEhfDFS9we8hG5e7worCBvWoHfOngDcwrlF6E5Tf4/4E49OxSqpLu7olhJXzuJk69A5VixwWdLg=
Received: from BN9PR03CA0371.namprd03.prod.outlook.com (2603:10b6:408:f7::16)
 by SN7PR10MB6382.namprd10.prod.outlook.com (2603:10b6:806:26e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 11:32:51 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:f7:cafe::8b) by BN9PR03CA0371.outlook.office365.com
 (2603:10b6:408:f7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Fri,
 31 Oct 2025 11:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 11:32:49 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 06:32:40 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 06:32:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 06:32:40 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59VBWeep3837884;
 Fri, 31 Oct 2025 06:32:40 -0500
Date: Fri, 31 Oct 2025 06:32:40 -0500
From: Bryan Brattlof <bb@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <s-k6@ti.com>, <m-chawdhry@ti.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <gehariprasath@ti.com>
Subject: Re: [PATCH 1/6] arm: dts: k3-j7200: ddr: Update to v0.12.0 of DDR
 config tool
Message-ID: <20251031113240.b3kdiupm2v6n6tob@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20251031053425.3960963-1-n-francis@ti.com>
 <20251031053425.3960963-2-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20251031053425.3960963-2-n-francis@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|SN7PR10MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb05a2c-98c5-44af-9310-08de18713902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|34020700016|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEJDdGN5aWpvanZhQlIzaUtEb2hXQlp3dHYxaFg5NTRJd0JFR25xUnNYUHVH?=
 =?utf-8?B?N2F6a1R5QnIrclRaUUp6MElMMHYrbWJnczFtQVI5S0NDM3pyUENWbGNaMFFv?=
 =?utf-8?B?aVArRVVSQTNxazZhM215Qm9qZnA2aFRhZ25NSEMyQWJKT3dQcTVaN2dCbGxN?=
 =?utf-8?B?RlR5cy9zNWxzN3BsMzFsN2Z4d0FCWi85UUlGQVNmV21SZGxlcU1JOXQ5c3J0?=
 =?utf-8?B?R1VIcnlYQk03ek9UM2xpYmhMNFhlYUJkbmM1ekJHbkFkQVNzVzNLY0NIYnNS?=
 =?utf-8?B?cWxhcVZWYnVPZWUrakZ1YTR6ZlZ4UVM3S3FidEFGbnN1N1JVbVlUdE14bjRJ?=
 =?utf-8?B?WlJMeE5SMGp2MXlySS9UMnVTdmk2NmFTeDNmdC9wakNBWHZ0bEFpSXNnYVpC?=
 =?utf-8?B?bnVGQ1pseHpaVzdWV3RXRnpyam1NeW5nUnBDTVNHZkEyNHFFSWRXZXd1OWFi?=
 =?utf-8?B?SE9pMll3VzB4RjRPc0dmaW5mUndxR0dMZFRRekkxR2xjUEd6eXBPTDA2b0cw?=
 =?utf-8?B?azZRWTBIZzI1L1V1NCs3bEp2WmRXRnBLNkVhYktHa25ZZldpMzFXbmxHR3Uv?=
 =?utf-8?B?Q091SzFBSU5pSTc3aE9WNmVtL1M4L3NXMElSUEprYUV6b0R6akgrTXNrRnZY?=
 =?utf-8?B?VndQWUswV2hmZlc3QjJWK3dNVHBiR1FZclF3S1hSbHNORFhFQUJJd0tBbXZt?=
 =?utf-8?B?b0Q4Y3lGU2p0aWh1cWhDVldVajNmQ0hzaHpHQnkzVnNrNHV4RzlRdDcrQ3Nx?=
 =?utf-8?B?U24yL3QweG82WW9EdXZPclB5SVdqUmVEK0owWGRkNzZ2L3FmRVZobG1waU5q?=
 =?utf-8?B?amJtRWpZeVpleXp5Z2RkT1A0NVAwakJLYnBpSVBNVmdNOWcxQi94elpZSTZ0?=
 =?utf-8?B?ZkRLZkdXVzZ5c1lUeWVkSVV1M3Bmazc2ZlF2QlJEYk5ONFB2L0J2YnFqYXNw?=
 =?utf-8?B?OWszOTNLcVRWL2VoSjhVbC9nT2R5OTljZElnbEZqZXlXM0RURlpPNVBCTEl3?=
 =?utf-8?B?aG1mbGpuM0NWRWs3T201QU5XZkpWUVhscWk4WmZqOWFzRjVDVlpwTTJHb1A0?=
 =?utf-8?B?Y1cxc3F6b3FzcHN1Z0x5a2tLemxwbkNibWNtSmxMa1BmMXJwYUxyYkZ2d1I2?=
 =?utf-8?B?enh1UVdWZUxnbVA1MDVoUDViM3orc1FhVWFSSENOUWQ1aG9NYVZYbC9xQlJX?=
 =?utf-8?B?dndXOEVqQlRMQ1ZyYlZRT2NxYlYvcE5qR1JqZ3ZKVm1VMHk5TlpTQmpwVWtM?=
 =?utf-8?B?bHhYNk1YNEtGRk9vWUJNamp1ZE1oVTlITkdkNUkvYWF2WUd6blRoQ1h2UEZ4?=
 =?utf-8?B?amZ3OGhZUkVxSitYZDk4QlBIQ1pJTU9LZFBCTDRvNGs3UjBoOUErazZGejl6?=
 =?utf-8?B?dTRUUC9iVDRSMU4xaGIrdkk3Y1k1THg0Vld0MjBrdEphaW5EMDZUNGViM1Fi?=
 =?utf-8?B?OTlPak5mOThUWldmbGxUS3M4blNhbXdQemJLaWFXY3dHYmpTVFBoRWdlekxu?=
 =?utf-8?B?R0JxcFhKUnE2RDR4aVdTaFZKWTUwRkRvRE84b0ozQmVsNjRJMi9oR2lqaFBL?=
 =?utf-8?B?TDFCTXdlOWZPVWRhbll3RkhpdkhwZEVkWThobEVxb0Zxbno2RnJYVU5LamFC?=
 =?utf-8?B?Z0Q0OFZQRGlBNnBYNkxvL3Bta3krSjJhdmh3T1o0dFQybnAvdFNWS2hKRFlK?=
 =?utf-8?B?L21XVVhNcU9Pa3hJb0RaVmtJeFhkOUFDQUtNU1RKTTdPeW5NR3lESFlmVkNo?=
 =?utf-8?B?dWZpcUIvaW5qUjFYbmw1V3Q2ZXJENkJZelJwSjVaM3R0cm8zdkh6S21OaHkx?=
 =?utf-8?B?YVJxQ1BhSUVOakJCU1FGQ095c040dnNseGJKTGwrNDVTQXp5d3JIcVlSUUNP?=
 =?utf-8?B?aFduNk5LRldBb2g5Q2Vud2xoVUY2WHd3MGx5NStVaTB5YnRKUjlYajBLQktt?=
 =?utf-8?B?b1JjdG1IakxnQUdQbk9LbDhJTm1nczZlVzNEejNrbnVYZFQzTXNBUWo2UW1K?=
 =?utf-8?Q?WEAlPbc/gk3VYI2mBiPpHwrkjiWcfE=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(34020700016)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 11:32:49.8857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb05a2c-98c5-44af-9310-08de18713902
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6382
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

On October 31, 2025 thus sayeth Neha Malcom Francis:
> Update the DDR configuration for J7200 according to the SysConfig
> DDR Configuration tool v0.12.0. Log of changes between 0.9.1 to 0.12.0
> is [0].
> 
> [0] https://dev.ti.com/tirex/content/TDA4x_DRA8x_AM67x-AM69x_DDR_Config_0.12.00.0000/docs/RevisionHistory.html
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi   | 2207 +++++++++++++++++
>  .../arm/dts/k3-j7200-r5-common-proc-board.dts |    2 +-
>  2 files changed, 2208 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
> 
> diff --git a/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi b/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
> new file mode 100644
> index 00000000000..810415494ce
> --- /dev/null
> +++ b/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
> @@ -0,0 +1,2207 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
> + * This file was generated with the following tool revisions:
> + *     - SysConfig: Revision 1.25.0+4268
> + *     - Jacinto7_DDRSS_RegConfigTool: Revision 0.12.0
> + * This file was generated on Thu Oct 30 2025 13:11:41 GMT+0530 (India Standard Time)
> +*/
> +

...

> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts 
> b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> index e35b767a7e3..3127ac83d7f 100644
> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> @@ -6,7 +6,7 @@
>  /dts-v1/;
>  
>  #include "k3-j7200-common-proc-board.dts"
> -#include "k3-j7200-ddr-evm-lp4-2666.dtsi"

These are automatically generated files. Why are we keeping the older 
configuration around? 

~Bryan

> +#include "k3-j7200-ddr-evm-lp4-3200.dtsi"
>  #include "k3-j721e-ddr.dtsi"
>  #include "k3-j7200-common-proc-board-u-boot.dtsi"
>  
> -- 
> 2.34.1
> 
