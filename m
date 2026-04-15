Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B076BFA0C3C
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 07:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2737883D8A;
	Wed, 15 Apr 2026 09:47:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="cHzdVPi8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1CA68407D; Wed, 15 Apr 2026 09:47:44 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7450B83936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 09:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7+CADbtejua/OjuzRpslRPWeKEmFCD1J34CtSav7FthrBj6txGGQBc6eMBs6vcvB9KuKJLjQRiMrARFGYFWzbe9h/UbekfgMcDFNddLyKtJ1X1UdsQ+lrItrw6W3ARH12evhPRmxSaM4u3J2E6RJdyuAIfTZYdZc/w3f1c50mXUM4MuHKUAhlgZFwdN7omwse8SAKCyyKGDmhJnK+1D7flP+HdPOychWTXgTa/uPLkioAKdh/PYUF0onuMWdHymNVtOuks87ObtSnEfBF43q4LkqV4/ynWPiwIFN012kU/3z2t06pM84bQyMMBdCQlYhGGI4ENkRivAfNmxWZJbwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Isrb7AoIyCl1rPiUU32JryKNEqxcD3TYxRH6EvEPivI=;
 b=iYNRYdpG53+FWH6okcWvBNw1uYIX3dCBzRaGGYo0CBzQjiiDrkNLab/u7pbIhOf4Xt25mhrvYaYMJ5+XabEaL7qGmZl9btd6QomLhBhWIh1pTURTOOJpoxlgoJ+c/AF0gsYnZQXYrGxrqztgIwEt9lwVH8yjtxEIhi9zh1KmW+fB8b6F2OC6K0tHc+QmGpfnSGxnJDsEHKszOtqa8fxGEIF03OoiEAKWAJZfFjo4+TseUuWTJaNX1MQ9Fl9Elo75i7SgYcbiwgDKbdm1NeLYDkreOA3SDx/VJEeodD76dvHl6htEW6PABK1i3pup+Qr4Nx3YwE9ZAM6IErnEAplPTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Isrb7AoIyCl1rPiUU32JryKNEqxcD3TYxRH6EvEPivI=;
 b=cHzdVPi8d95D78BEecuVjdEWo/f/ouAEEBYa+8yYM6dbhRU8CjC7B1ySgw3G2PsGNAtJ7fER/S4Mhsc6TMSdHGuCwyB8d7FOxpGGrwSjNG37pCdCDd9v5MItx1p/UAI4UK3b65TbW4tEQi0jV6uVkhFHUU2sLcyDi3rYCw8tc9ZMuqnh2d/FyuNLtCX83HjPZgsrVQCfqyEvSLsmU0GXE+oBhuftshcVSfpW6eI9u7KCAgUKyGePeXnaipECB2UC8wMzuIvi5Q7CMCB1wZfFc7fvqXL1VCeCWSjVqIR2+cLDo4HpHiWVnDEVLuAWkDEKm4FID5ZWWU52Sj3oNvwyVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by CHXPR03MB989196.namprd03.prod.outlook.com (2603:10b6:610:2fd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 07:47:38 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 07:47:38 +0000
Message-ID: <a5545cd8-9a37-4793-b020-98a577598e11@altera.com>
Date: Wed, 15 Apr 2026 15:47:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: socfpga: Ensure FPGA in user mode before enabling
 the bridges
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
References: <20260304034354.2871-1-dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260304034354.2871-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|CHXPR03MB989196:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f34455-2e04-4996-c79e-08de9ac343df
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4gC/FKY2a6HSVKTX60G1CLo9Q0hddGMDTP86o9RkNGcPZz8aB5KXWvmVr6NvhgiAbJxXvKSTkaIzrqb253sMbwz7AWQfwArfuVwgbwK8L5An2h/+1TXVrpmvXGoOGGlL2rzSerU2mVbx9O16L3c77v2PnNXI3QFdSrgpxqx9v0W0zwEjYe7ZVVQT6vjNBAl4/CIqga5aU2UAHz/WcpDF9VR3DA6tNXr+qsHJHYIVuTADmCTgBaZfP6G2OEFomXkxrm1LS9IuSPmH+VxRF1ENnWtjXYnqjLDzl4Xz6q21BxRZ+kqbWxjbK9Fith6pdryolaQNZ8RnAD2ithP617qIFugzplT5FyoyHO7pxwUEYCyrZ9oH4rgUA2L7OqGYn3m6ByTYAImfwKksOLIYmCFcuLbSvOEfEqKRRIQ/d2YX7UR10pypUAsDJMFrd4X28432kkcxpNLXPJ58J+v2niwQXlbatJhV7Ixr6aMj2ot6tIRFdTqVGJ4fLAbPmV2n4ehLGKSEeaZ4bbLcolFi9BGhrfN9B6d/ZvmMFRo5mP+Hzb6AuOcWnsUEU/aA7V2LCFSE6kU1SQLmJ1RkkRyhlsICqwmiO9U0Jkj28XwbuQbiOstXVOmDvKdk70KEegtytVZ7cX9/gsGxfEeKv4OLoaaf6SpngWFa+RMKWz9OWeIbU34iAgeFesmT23KCO18RsgtxGYrLusIrAzsnGqbaDiJXV3a0n1Q8Ox4ChrggpAhpNU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE54clJOMDRxemUxT3l6ekJaazFaZFl1MFMvUHhuQ05lNURxVlRUL1krY2NU?=
 =?utf-8?B?cEJvZzdySFpPNG0zeXZKbSt6WTZYa2o4RWpwVUNSRTlKNTZzR3B4TDVUd3p1?=
 =?utf-8?B?RlNweTV2TFJWL0FJa1JOdGhXdTdPTWxPdGxpVkpYZHRtaDdmdGZxWUZlZUNp?=
 =?utf-8?B?QnZnWVhsZUMrZXNmeGl0U1UrcE14WEYxeWxVSDhPZXQ4UE81Nkkxdm5lODdR?=
 =?utf-8?B?cGE4YVJNeHNobllZMWd5Sm5CREtxWmJ5aUNSWnJtclVZbG5ISTlGUExiaC9N?=
 =?utf-8?B?cE5ZSTQ2RDllUUpySjNpVTFxMzZETm5XVmNnM1dUZkFmQ004bXlXQVpnRTZT?=
 =?utf-8?B?WEx3UlpxWWZDcVhzNTh6ZDJURTRvYmZvZjdtcGE2MTRZUTE5TytoTkYxSWly?=
 =?utf-8?B?MWJVSjlDdDBvOUhoU1FwdzBCRHdBVWdnZlF5bWtRUzN2SU1CbHMyVVNPU0Rl?=
 =?utf-8?B?d0RiQmpIczJ5VjVIRVhZZ1ZnVnN5eDBXN1BhTjJnSXE1T2xSdCtzV3pENUMz?=
 =?utf-8?B?QjliRGx4b1JlaWFDTUNCQjZyMitLQTZ6TDNUZDB5ZW9vRTNrR3ZDOTkrZ0Ji?=
 =?utf-8?B?WFplZ1NSTzR6Y1FSaHVVZjVQZi84bkhoVE5TTE0vdlNBTFM3Y0JXaEp4VHUr?=
 =?utf-8?B?NG1PUEdmQWo5Tmk4VTcrK2FIZklZdWpYdkd4cmVrTkJjaVc3bkV5RHJaN1Fl?=
 =?utf-8?B?R1BsamhML1c5LzZmV2tFL3U0VUpRSWZpMXNOR3NTdDFRRDdMRFJJYXRTQkRn?=
 =?utf-8?B?d1NCeko4ME56VkExcU9kL3VyNjBjbEljMG1pZ1ZKcTZoNlNTNWtZN1lscFl6?=
 =?utf-8?B?NnBOdjV3U1ptSFJIZEpaL1lPQ0lPM2d3N1dBdXBpV2VRbFlyY1ozcklkUno2?=
 =?utf-8?B?ZU82U0hsMWtPMGhmaWs3MlpNeVVIVTlLbURvMWwvd3Y3Ym9vSFVsUlFGdHha?=
 =?utf-8?B?NGdITE1OSjJYZEpEMGZiRkNhVGtBblJuS0FFRTE4YlpVc2lYRVBsVWFvNWpj?=
 =?utf-8?B?cUhNRzJEVm92TTRyTUI0dDJOUExvWmdRTS9mazN0bXZTZHVaaGtRdEh2bSsy?=
 =?utf-8?B?d3Q5RVU1QW9SajdyWHJmOWdvSWw3RXdyakgzaW05WGJjckV0Z1lURnJORUky?=
 =?utf-8?B?VHlRRitnUUU1bGkzQlh4djBTUm9LUnc0WHNtWXhYcjVEYUIxcjY3TEhKSU15?=
 =?utf-8?B?VVU5V2llRUtTNEFZZW9tMXpyM0lsdDJ3Wm5jRENJaENhbGtMWGp3L2xTNXdY?=
 =?utf-8?B?clkwb0VkNy84R04wRkR3cTQyR29IenNzeERtcGx4ZUd1MWcyTmlzTmd6Mlc5?=
 =?utf-8?B?K0ZxRWJaQndlcXNOV004S1Z4TzRhNEExSnZvelowcDhxajBERG9tclpLUmN2?=
 =?utf-8?B?YjZqZTRCOU91Mk1SVzNUMTNaaTExYTArdW5ZeExuK3Y3OVhBRmFnK3g3TGZi?=
 =?utf-8?B?OWwwQS9rajhjVjduemdRRU01Wmt6bklZU09aOTIxQ0hGeUNrUkdTeHhtdFps?=
 =?utf-8?B?dndTQnVPcWNjaFZ1TXhVUkFMVG5WM2hwOVByaFlvS2JOakFRYTh3NzY0dnlY?=
 =?utf-8?B?ZDdueHJJU0t1TDU0Q2Y5NDYwWS96UVEvMTN2TlIzMmFrbXEyNWxyMXpYSys5?=
 =?utf-8?B?a2o5TGZWaG0yZzd6RnVWc1pFUmdRSitNWEIzQ2Y4Q1JkUGEyMnp6NDJSVHli?=
 =?utf-8?B?L21rVXJHc2JmUVFxSThpbGNybFByd0djVjBlZ25CZUpsZ1VkWlBRaHMySHFD?=
 =?utf-8?B?ejJkSFdSc1dwL3JLYkFOVDhLbFU1cXFCQjJ3VnMxWWlPL0hXVTJncmRvRWtr?=
 =?utf-8?B?VXZQVVhqcGFjeFdwT0hTYnNObmx6a3F3eCszSTVWVmM3VFNVUHZ2czNvL0xn?=
 =?utf-8?B?Z1FKWkhBUmdUZlRFeCtNa0wwVXpmbFRUVEFXaDZId0FYUDFFZGE0ZUdITVZn?=
 =?utf-8?B?UVhPZ05hYTBkNnJIZ2hkTTdqR2hJaDUvU1RlTTllcHArZlk2QjZZaXF5aEE4?=
 =?utf-8?B?NjVOSituZFdOcFpqcXBlUTBkR0k5aXcxYmtuc0VCbGRLSDh0eUNGQ0g0NjV3?=
 =?utf-8?B?M29TNVRrMk1hOS9aZTYvbDEwK0V4c1NJZGd1WWxkWXZ6WnVzV3ZJdWVSaUE5?=
 =?utf-8?B?ZjE2c3pKbEZEU3dHdjBpeUhLaE5JMjFsaHBHUW9JYWRERTZ0OFhxYXhTaHR4?=
 =?utf-8?B?UHNpbzlRL21waWRZV2RlN1hiTFBDZFFOWGR4a1NXcGtEUVNiWFVmRFAyZURx?=
 =?utf-8?B?SGJBRDhiSVRxUXEwbWZZYkcwYzhsTzZoWFpKUkluSmhoRjc1Ujl2UnpGZllo?=
 =?utf-8?B?UktaSVh3dHloa2l6ZTFnYjRIZ2lnWXBsWUZYRmpEL0FZTFV3MEJ5Qlo1WEZs?=
 =?utf-8?Q?d+VqB/rQO+Pqm04o=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f34455-2e04-4996-c79e-08de9ac343df
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 07:47:38.2790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmZMXErmEmz5Niux4PPMUWCZCtIJ+zp+903iE2ZYRM7s/H7tDY2JfIjQFidUOqAgBwwvbXHPm2pIVqbYr91D57D2ObtvH1dej6lzGZ8mRtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR03MB989196
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

Hi Dinesh,

On 4/3/2026 11:43 am, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>
> Unexpected behavior and error can occur if FPGA is accessed in unknown
> state.Always checking with FPGA in user mode is required to ensure
> system stability.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   arch/arm/mach-socfpga/misc_arria10.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-socfpga/misc_arria10.c
> index 7e0f3875b7c..6b25ab917ca 100644
> --- a/arch/arm/mach-socfpga/misc_arria10.c
> +++ b/arch/arm/mach-socfpga/misc_arria10.c
> @@ -13,6 +13,7 @@
>   #include <ns16550.h>
>   #include <spi_flash.h>
>   #include <watchdog.h>
> +#include <asm/arch/fpga_manager.h>
>   #include <asm/arch/misc.h>
>   #include <asm/arch/pinmux.h>
>   #include <asm/arch/reset_manager.h>
> @@ -126,10 +127,16 @@ int print_cpuinfo(void)
>   
>   void do_bridge_reset(int enable, unsigned int mask)


mask is unused on Arria 10—please mark it __maybe_unused so we do not 
trip -Wunused-parameter while keeping the shared API.

Example: unsigned int mask __maybe_unused


>   {
> -	if (enable)
> -		socfpga_reset_deassert_bridges_handoff();
> -	else
> +	if (enable) {
> +		if (is_fpgamgr_user_mode()) {
> +			socfpga_reset_deassert_bridges_handoff();
> +		} else {
> +			puts("Bridges: Failed to enable because FPGA is not ");
> +			puts("in user mode\n");


Single line puts is preferred

Example:
         puts("Bridges: failed to enable because FPGA is not "
                 "in user mode\n");

Best regards,

Tien Fong

