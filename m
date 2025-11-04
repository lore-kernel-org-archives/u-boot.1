Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E807CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 14:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C27258004F;
	Tue,  4 Nov 2025 15:04:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="I26fJDbO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 215DF82A9E; Tue,  4 Nov 2025 15:04:46 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DC278003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 15:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BICAFFSjETx/slmCA736eDzrQhLh4/6z7a6ycK/v/HFCgxBv6YtJW2HJKOe1R4MX583oNWunJTnKLqONlAp+2PVY1y5HZk3wU2MMfEWd5VHbnsKBFY4VKAlwGDBSwOz/3lSdZ4aZJEOScMLiv0GlxM4QPUDlAXI5uGTFMg4OnN3oeY9l9JS6eSJSnZcFfaq4mfDxQHcy7BsLyTivQY3AQtnnv1UNqntk7uKvxH9hmuJhBfaOjDFzG9z6jcu8DDZdmRVNKAAYB1LzFpH5X2n5IitAX+Jt6L4+gACluM9KTLx9N+g9weTDYpFujcogR8plo4iAxu4zpdk5RY68cfPdog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6FT7cHG4gX5HxRe+iIIHlWQurBotU2U1bBifD9R6Vg=;
 b=fj5iflSJsbadYDzbGNFhSRhVGrGQQL0D0xX0X3Ee0V04Badzls52QpusBOUNq+FrTu9NCMKj0sUHTHkujKv0/5w0/8Cb4i+OJcBtcUc8Cm4Yq2ybHPJfYUX7KjaXn8CdI4o2vca27c3Dq619Ywf1QRJ21zL1hoqnIxtNIAGOVHQbcoKuYZqPEX7Ws91+c5tclALjYElYNh/ZlQS+Nwg/9LPX4RZrGGNc7iTEpRpQRd7GZJcEAuQW6DLjMPAmVmQlXuVHYaB0hF91w5FVS1BY/Qm/3hsBPaDqgfcY4BWijcndG8cH2rm/f3rcwoHnZ0loRvJjH8kTqaFP6wF9bw8ubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6FT7cHG4gX5HxRe+iIIHlWQurBotU2U1bBifD9R6Vg=;
 b=I26fJDbOD1DC4CLrCCMbFLb+9PYrbo8TAQdX5+lIGiygfd+STTHFa6njwOVcPfmf3+wydyxsAvLE4kc0RQvSOA86Lok1Kjxb21zLzJHZwmHTFYYN1G5NTtVU/xZrRJFMoZuTauQJz+a4xX6wd1vxhdCAdiZn6SYMkUtds9vHvOM=
Received: from BN9PR03CA0727.namprd03.prod.outlook.com (2603:10b6:408:110::12)
 by DM3PPFC7C228AEC.namprd10.prod.outlook.com (2603:10b6:f:fc00::c4a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 14:03:59 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:408:110:cafe::7a) by BN9PR03CA0727.outlook.office365.com
 (2603:10b6:408:110::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 14:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:03:57 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 08:03:54 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 08:03:53 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 08:03:53 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A4E3rre2016442;
 Tue, 4 Nov 2025 08:03:53 -0600
Date: Tue, 4 Nov 2025 08:03:53 -0600
From: Bryan Brattlof <bb@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: Santhosh Kumar K <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Dave Gerlach <d-gerlach@ti.com>, <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Andrew Davis <afd@ti.com>, Judith Mendez <jm@ti.com>,
 Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] mach-k3: Kconfig: fix NR_DRAM_BANKS for AM62x and AM64x
Message-ID: <20251104140353.pfql2n5rmaa7lqpg@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20251104-fix_nr_dram_banks-v1-1-761ddb57f4cc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20251104-fix_nr_dram_banks-v1-1-761ddb57f4cc@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|DM3PPFC7C228AEC:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d8f915-f6ab-4a22-7048-08de1baaff73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|34020700016|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1k1N3dpajVnQkRpS2FuN0s0dTBzVnFCdFcyL1FPWGxqWE5tQnludFFKRk50?=
 =?utf-8?B?VlNYUzhMZjFaU2lQM1N5MlYxSDlhempSTkkxdnA5TkJuYlNIM3MyQ3JyQnN6?=
 =?utf-8?B?aDZKNWZ6UHhVR2lmTlJ4aEdaT2VIazY4YzMzS0ZRQU01cTg4engybjFFQWc0?=
 =?utf-8?B?Nkl0Wk02Z3RCRS9oQzVsL1hWdVZvTUwzZDI1aGZ3Mi9sVms0WlIxeGgwZ1My?=
 =?utf-8?B?VUVXeDQzNm10eXllZzFiWk5EWWtzNE9WbEg2YkVpWHVBY3N5MGxxV3NKUGVJ?=
 =?utf-8?B?VTRnYXhGbnpZamRXMnRucFlRTTdOVmtaNGFEQzU5ZHYvdVdXV3FZeXlGMThr?=
 =?utf-8?B?eU1LUi9RbFU0MXB3UjdhOXFESko2OUxrcm9TUC9iOFliWWl3ZGFHaGFQMTVH?=
 =?utf-8?B?c0g5UWFRbnp6WnUrUUIyNXdWaUtnWE5FbGJld2FNQ3JWK2NFU3ZMaUZaZEtH?=
 =?utf-8?B?MklSUTRiVjJrVVNWLzEwNkNRSnY0UDV5aHVSOFBmMWRrcytxb21mQkJ0ejdX?=
 =?utf-8?B?OFhxWFp0OVplck8zNVd1R3V0YXV0eFVBeDlBWnJ1WW1rVXl1L3UwT2ErWC92?=
 =?utf-8?B?MzNiNktxVEVUT1FaN0dYdWlITEp3STRtVWhDajdmRUxRRHFxcXFiU0NwUTZJ?=
 =?utf-8?B?UGNuS0s2cnA4ampSY0pFTTRPMXdmUGtNN2o0L1YyVHRRZERaT2VVOXY4anVQ?=
 =?utf-8?B?VkticlRRbC9hSjFmQUpLZ2RxR2sxNmEzaDduTXVrR3MwRVlqcXE2Vmg0aFhP?=
 =?utf-8?B?anJmc0pGeXViVU4yM3R4UjJNVlFXbVJqVlh2SjNGZGwrOUh0NkUxeVNSYnY3?=
 =?utf-8?B?ZlFwUzFrUWtsVjIzbVNEK25ZdWk0ekJkbEtCZ3ZUVnEydlRPYW9zcHNqbUgr?=
 =?utf-8?B?VUR5K3IrRzJ2SWtJL3BVWUhsUHBWQzhNTlBWRzFtaVhQU1NtSUkwUmVBZ28w?=
 =?utf-8?B?UkdiYmZqSnJGNURBbkV4R01EdmY4MUgwOFd6UXBvcXI0cTNyckJvdDk3ZHUy?=
 =?utf-8?B?dVU4SjNBekcwZnpHTmtHVGNuaVo3ajNvYVVwTllFdUxwaWVqc0dNc0pqZEtH?=
 =?utf-8?B?RDNWQ1dnYmFWVjlGUGVZOVJFTFBSZVF3NXM2c2dqdWVzMUI2eDZ3Sk5PZFZz?=
 =?utf-8?B?UDM1ZERqRCsrWFZISkVFQkdRTDI5U2x6clBVcFArcnVkSVoySjg1cmUzSy96?=
 =?utf-8?B?SDN6MzZ6ZmxBczcrSDdhMnFTMElrN0dmRmlzcE12ckhmL210TU10WjRmcWtP?=
 =?utf-8?B?Nm9TdDhZbmxmRU9kcTEwdjJCQkhSeC9nb1J6TGUrSXdVZDFrN3pNT2lobS96?=
 =?utf-8?B?Zno1c1NJN25JcHZHSm5TVWdlMFI5eTlkMjlXWmlWMXZ0djJWSlEyWWtxYUY2?=
 =?utf-8?B?M1REK090dXhRcVZmQ2Fza2NTNFhxYTRKL3dYZENMc3YvUjNobkVCRGJqbUg0?=
 =?utf-8?B?UUtGREtYSVcwYjdTNnVEa3Y1OUhBNEFNZ1Q3MVRPN3RvM1NEOWVKZ2pzZ3dp?=
 =?utf-8?B?dVgxa1VjYkhaOCtFSkF4UmxLWFNEVGdKYWtHYzdUZ0VXSkp2aFR1aXNxN05L?=
 =?utf-8?B?OWlsVjNocFR4YXNNa1F4eTlDQk01NmJYaFBKdFpvcjlRS0x2dTV4WjBROFp4?=
 =?utf-8?B?eTBza3d1N3FNUkNLREk4U003ZzNNTkhQMEtpMzRBcDlwRlBIZTdCT3hwdVBl?=
 =?utf-8?B?UktyLzl3ajZhczBkK21lbWJ5R1g0czJreW55cjNCcXJjeDY3Q3EyamxhSW1M?=
 =?utf-8?B?Y3pGRUttc2htN0YvQ3dLYzNZZkZObFlDcEIwOTJNYlVpVlMwK1AzRjVQYjBz?=
 =?utf-8?B?bHFBb3crdGxTZlRoTjNyRVFmdnM2a09sbjJDbC9GcmVib3RIcjFZK1FHWmty?=
 =?utf-8?B?WURUWDNxbmRMVVlNT0owdGQyd0dZUHgrWDk3WVhCaW1ocWtmYjRnMCtQSnBj?=
 =?utf-8?B?amIzaXY4TmdqSyszUXdEY3dORXk1R3g4UzBSejdTazBrZGRUb2ZpOEEvdGQw?=
 =?utf-8?B?WGxrNnhqZnk4cFdQZ05ZZUQ5bXZtakVUdVlGSGR3ejZ1Q0c0MzF5bThGWndi?=
 =?utf-8?B?TkVreG0rZG1kcnlRU28wOHFQZDRZaE92MlMvcVE3aU5GTUU1SEpvNEdJaTFH?=
 =?utf-8?Q?WSnY=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(34020700016)(82310400026)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:03:57.6659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d8f915-f6ab-4a22-7048-08de1baaff73
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC7C228AEC
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

On November  4, 2025 thus sayeth Anshul Dalal:
> CONFIG_NR_DRAM_BANKS was improperly configured for AM64x and AM62x.
> 
> Although the commit b7d70fe68b9c ("configs: am62x: fix
> CONFIG_NR_DRAM_BANKS to 1") fixed the issue for AM62x, a better fix
> would have been to default to the correct value based on the SoC type
> instead of relying on board defconfigs to set the correct value.
> 
> Fixes: 01fa91bd5bbc ("arm: mach-k3: Set NR_DRAM_BANKS to 2")
> Fixes: 55afd2d8f5af ("configs: am64x_evm_a53: Add Initial support")
> Fixes: ca1d803a4740 ("configs: am64x_evm_r5: Add CONFIG_NR_DRAM_BANKS as done in a53 defconfig")
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/mach-k3/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 1b8c0b1eb968f0414107c0bf3142f744ce8364c8..9c99cf4744410601f770838aae29d3643c4f170b 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -155,6 +155,7 @@ config K3_X509_SWRV
>  	  SWRV for X509 certificate used for boot images
>  
>  config NR_DRAM_BANKS
> +	default 1 if (SOC_K3_AM625 || SOC_K3_AM642)

Why does AM625 fall into this category? I can understand the AM64 which 
only have 15 address lines for the DDR controller but the entire AM62* 
family should be able to back the full 16b addresses

~Bryan
