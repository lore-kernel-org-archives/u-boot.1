Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754E1D32D97
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 19:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF53688FCE;
	Tue, 12 Nov 2024 20:54:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="UGDhec8m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 775BE88F2A; Tue, 12 Nov 2024 20:54:31 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71A4588E5C
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 20:54:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAofgvqggRRwZAx/zNAo1XPgeOn4H8oMJ2AULaY31hctf4FUXgwQWPP7wamkSyyX9WAHGRLGL2SJOABYwn8oeFog55/1zcMhoZJGXX7YIr/wvQOtx6dVmklZbumcXboMiGo8dKMsCc1EhLrMHiUXUnyMSLC5eEjn1sxEbj4PLO5Jr1kou/ojfNsz435SfBinjz1QBq/Ho9pcfrLNf6GntsG7WJ8mGzw4i51i7aTskwEXEU4EGTtodqlXrAIgRMSJMnr98YR6Gc4Hv82xSXBS4Mbp51BXQA99UBWAxwhP0ORsaC9bQ19ltjIXxNdG7SsXjdHWdcVpH+l9RHbG1U4nTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5zrEYZ+XEHrvUCxZj7MAw1urnwqhUmpBf7A5crsUoU=;
 b=iXAZ/q8MDNBD+2NXVLrY/SYsUJo+dJNXpDK2Exbu3L3/7jguinSfRkDUFvk9yZahMhBejGsPe52VAuwQEYo192E3uN97r7vXDiYEYpP4hrMzsvHsyWG9rjaWwSSGgCOfVC2nd7WBkypCwz+Wy0cN7lhTEqsIGme4ST1f3HRrg9NgsvxkZOJlT/xqoUzAy10G9tNjtO21untM8r5Omq+i2sWzKcqpiNYUv1qZQTjoSxnTHbSCNOTfps9myDwtvbW67nuVSfM4VgBB6SKLxc8zWYHYx7WqgjUbFs3AtoKPFXonjEbE4MWTCMCmb+BObqgPtm/bIBG05SBHCLq1BBjBpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=phytec.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5zrEYZ+XEHrvUCxZj7MAw1urnwqhUmpBf7A5crsUoU=;
 b=UGDhec8mlEAShG1v6teypsXj7Vml/VGyKBBnJt+XwmEG/YSHAkcD6ZBsCjkJQ0RMLoc11eK19Y8wNWu4SazKAUwhCgUnXXc/PK0jqh1dQraD4pxPCWv2krAb0TXOhYG/2fECQBrfa2a3ZJphHGkWnCvvscwh7PiHl3ZImeawAjM=
Received: from DU7P194CA0029.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::22)
 by DU0P195MB1959.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 19:54:27 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::ba) by DU7P194CA0029.outlook.office365.com
 (2603:10a6:10:553::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Tue, 12 Nov 2024 19:54:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 19:54:25 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 12 Nov
 2024 20:54:25 +0100
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 12 Nov
 2024 20:54:24 +0100
Message-ID: <a53a67ee-0330-498e-9995-3b08468ed42a@phytec.de>
Date: Tue, 12 Nov 2024 20:54:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC U-Boot Upstream] board: phytec: common: Introduce
 CONFIG_PHYTEC_K3_DDR_PATCH
To: Garrett Giordano <ggiordano@phytec.com>, <trini@konsulko.com>,
 <afd@ti.com>, <d-gole@ti.com>, <marcel.ziswiler@toradex.com>,
 <sumit.garg@linaro.org>, <nm@ti.com>, <d.schultz@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
References: <20241112184029.1030756-1-ggiordano@phytec.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241112184029.1030756-1-ggiordano@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D07:EE_|DU0P195MB1959:EE_
X-MS-Office365-Filtering-Correlation-Id: d69a9812-eed2-47df-9179-08dd0353cf93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blF1M3VRZ2Z1WEIwQTV2TDE3ZmN6K3NBSGtTRUhwZExzb1pBb1p6YlZrQzVX?=
 =?utf-8?B?RElMR1d4cXB1cFpJN3RONTRPUitnR04ybHJpUDBGQmg1clBrUDRwRXl3WVVS?=
 =?utf-8?B?Y0JGS0RueU9CVzNJSEhaaXg3cWRIQUtKaVpTMG14Ymt5TVg5bHpMS2ZUaDJ5?=
 =?utf-8?B?NVl5UEsyaUl2bnVkNGdlNE5DN2hGejBMUVZBOUxEaWpFTzNTVk1FcFcyWGRD?=
 =?utf-8?B?MXpGb0cvYXAvZzYxZE1odHVTeFBVQTM4aitzWGdNRGZ1dFFhbWtuYnBQaXRP?=
 =?utf-8?B?RVhQM2FISTR4OENTOWQwcU1yeGhoUDRrRWVxQ24vcklFRGlxQ1QrNFlQei9x?=
 =?utf-8?B?aHN2V0k2bzNPL05GS1NhdFVUS1dGYTBOODEvT2dBTHhXNzRyWGZWalE1WHgy?=
 =?utf-8?B?QXBjaXprM1hxeXJLR1U2Qzl5eWYwbXBmQ0pCK3U1cnVtK2hjNTVHbEIxR3dX?=
 =?utf-8?B?OUtvbE4veGx3UWVGbmJBRUYyWXpJbnUyMUUxMmRIb00yZWkrSjcyRWZWL1BQ?=
 =?utf-8?B?UWw3YzBDUDN5MStvRFhqdnozQ3FMK1FhZUJiLzUvTEYyUkMwSWJpSnM2NmR3?=
 =?utf-8?B?VHVDSlRxZHlGYjZxajNJWDJlM0hjbkhQalB2Y2pMS0pFNE5nRTdNQ2F1cXA1?=
 =?utf-8?B?bWxpa3Y4L2ZsL251Y1pHcjlVYUt4MG13NUtpYnJYK0tPSFJISDZLWlowTkxH?=
 =?utf-8?B?MHltdWo1U1hnWVZ0dSsyQ0tsdDdEdUNySUNUbk1rQS96TUVwRFNpdmt3T1lF?=
 =?utf-8?B?R0VOMnRQM3dldzYzOUE5WGxXRjF1dE80MVNTcnUrQXM5eWJCOWFMNGNkTGpL?=
 =?utf-8?B?VTBXSjdkUmU2aDdSUkpUVXVqTnBJTUpNa3liZlpHNWF2QkQ4OHBLTlRmdGJv?=
 =?utf-8?B?dWg4Skt1bnNUUWZBTENIVnE3Vk9IVzluUU1xQzd1WWo1ZnZUdzVYc3BMVis5?=
 =?utf-8?B?ajl0dkNkaGVqRWxhYWZ3d0NwQU1zOUtTQnVsY0Q5M1hEV2g2ejdMcGp5eTFw?=
 =?utf-8?B?bUdlb0E0RzhKeWdRVll2TTU4eHEySnpDVUpGaWltWmVvaHU4RVBxMTRpbzRh?=
 =?utf-8?B?YitoOVp4Sm9IaGFVQ2FiZ0M5elhqTWNxbFg0NkxqaGRUU3NZWnQrV2hXTlRv?=
 =?utf-8?B?SitBSC9rWVNsUkNjelB4RUQwVWNGaXVlcWxIbkJaMXAreWRxUXQzZ2lLQWpl?=
 =?utf-8?B?L0dBV3RsVzB3c2x5L20vQng0RWZyWExTUlR5bll1Mnl3QndYcWNjbnB2ZlVG?=
 =?utf-8?B?aHpUbmQ3MTRGMFR2aUhGOXJYcHFwN0VTSDBJc1ZzdHJCRlFwZEMrd3ptaHFS?=
 =?utf-8?B?bHVGK0s5aytEM29nMTZQOFhMZ2szQ1IzMmNRVWhpSjZ6Tjk4ZXlQY3A2bUEv?=
 =?utf-8?B?bVE0c2ZlWVZlN2FUZTN2dXV0N21HdnRhOWxqU0w4N3NtZTNrRFg2SXdTQzR1?=
 =?utf-8?B?VlFoM0UyY2JyRlY5NTNJSjBYdzI3Z1hxOUhGM0xNVi80Unp4K1JMcUtsSER5?=
 =?utf-8?B?SVlmcDFmNnk1K2Rzb2ozNHgxb0s1ODJMT215N3FDNHZrRkJFRTBVQzA1a3VV?=
 =?utf-8?B?Zkh6Zlpod1I4bWFsdmtxZXIrYUZFQXlUeEFCNTB5WDd1YU9vdG5qUGdIY3Rr?=
 =?utf-8?B?VE5zQ2tGRUUyVEJubzVtd1VGRDkveXdhdkxFTVZ0OUpQTVJHOTRLUXNTWk91?=
 =?utf-8?B?b28zamhrMkxaTDB6S3pGQjN2MGJ2cEI4ai9rdnR0VzRFVk95NXowMFZraStv?=
 =?utf-8?B?T1Nqejkzc2RBSFZRY1VwMDRiUzN4S1lTQ0EzQ1ZWNDFNUG5tYlpJWXFBZWZh?=
 =?utf-8?B?MmZNV053cG4zWXkrd0VFVlNPcFRBek1WSHNjR0hUdXhvbFVwTEcrQ0tVL1VU?=
 =?utf-8?B?NjhxbzN6NU1IcGRJa0EvcFppQmVKUURjbDRFUWFnQUcxVFE9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 19:54:25.5108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d69a9812-eed2-47df-9179-08dd0353cf93
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1959
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

Hi Garrett,

no need to tag as RFC. Otherwise, it looks good to me.

Am 12.11.24 um 19:40 schrieb Garrett Giordano:
> Introduce CONFIG_PHYTEC_K3_DDR_PATCH to make DDR timing patch code
> optional for PHYTEC K3 boards. This allows better control over which
> boards receive DDR timing patches, rather than compiling the code for
> all boards with K3_DDRSS enabled.
> 
> Also enable the feature by default for PHYCORE_AM62X_R5.
> 
> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   arch/arm/mach-k3/am62x/Kconfig     | 1 +
>   board/phytec/common/k3/Kconfig     | 5 +++++
>   board/phytec/common/k3/Makefile    | 2 +-
>   board/phytec/phycore_am62x/Kconfig | 1 +
>   4 files changed, 8 insertions(+), 1 deletion(-)
>   create mode 100644 board/phytec/common/k3/Kconfig
> 
> diff --git a/arch/arm/mach-k3/am62x/Kconfig b/arch/arm/mach-k3/am62x/Kconfig
> index 8b0cdd74f4f..81199ada3a1 100644
> --- a/arch/arm/mach-k3/am62x/Kconfig
> +++ b/arch/arm/mach-k3/am62x/Kconfig
> @@ -42,6 +42,7 @@ config TARGET_PHYCORE_AM62X_R5
>   	select SPL_RAM
>   	select K3_DDRSS
>   	select BINMAN
> +	select PHYTEC_K3_DDR_PATCH
>   	imply SYS_K3_SPL_ATF
>   
>   config TARGET_VERDIN_AM62_A53
> diff --git a/board/phytec/common/k3/Kconfig b/board/phytec/common/k3/Kconfig
> new file mode 100644
> index 00000000000..282f4b79742
> --- /dev/null
> +++ b/board/phytec/common/k3/Kconfig
> @@ -0,0 +1,5 @@
> +config PHYTEC_K3_DDR_PATCH
> +	bool "Patch DDR timings on PHYTEC K3 SoMs"
> +	help
> +	   Allow to override default DDR timings prior to
> +	   DDRSS driver probing.
> diff --git a/board/phytec/common/k3/Makefile b/board/phytec/common/k3/Makefile
> index 40e91a43e99..6861c70e17e 100644
> --- a/board/phytec/common/k3/Makefile
> +++ b/board/phytec/common/k3/Makefile
> @@ -1,3 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   obj-y += board.o
> -obj-$(CONFIG_K3_DDRSS) += k3_ddrss_patch.o
> +obj-$(CONFIG_PHYTEC_K3_DDR_PATCH) += k3_ddrss_patch.o
> diff --git a/board/phytec/phycore_am62x/Kconfig b/board/phytec/phycore_am62x/Kconfig
> index 7c179ef0078..ecee5873c0c 100644
> --- a/board/phytec/phycore_am62x/Kconfig
> +++ b/board/phytec/phycore_am62x/Kconfig
> @@ -33,6 +33,7 @@ config SPL_LDSCRIPT
>   	default "arch/arm/mach-omap2/u-boot-spl.lds"
>   
>   source "board/phytec/common/Kconfig"
> +source "board/phytec/common/k3/Kconfig"
>   
>   endif
>   

