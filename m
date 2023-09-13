Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7F6EE49B7
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 02:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DEA486D3C;
	Wed, 13 Sep 2023 04:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="h+nIarze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9519D86D3E; Wed, 13 Sep 2023 04:23:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 280E586D34
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 04:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fei2.wu@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694571816; x=1726107816;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=z356RdXHee3J1ouYMQx08Kmjf37qH7N8cAbbOwEPBvQ=;
 b=h+nIarzeb1vzHi6jsbh93WaSPUwIx056bwLtimf+5axvJaxWzgV60aBV
 KP+nE6Zgi5oURsLF/qMfxiFB+C44MlhRuQ4L1rRmsHPwOUIy79qzZ81/X
 hpBJ60tqSuvCM8cdbCCqIMpTcJAxwH4gEjbA+6uEvuoJ7RJv1DeSrfvi1
 SySi4jYhaG6TqsKOpQ9KXQEJ0OYJKq3Wvv+nk1JIQw/a9x8nzbcsdA7en
 V0MfSNRjZrkfG9p+N5ofBL5Ak7DN7O5Fe7/DDrYNFv12AtXnmVroBUJsF
 GX1pN8WI0NEcOOQ8a9W9E47DMTJ2WHquZSdXkCmqQUGFwS7OHeTJeAc6N g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="363580428"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; d="scan'208";a="363580428"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2023 19:23:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="779030109"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; d="scan'208";a="779030109"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Sep 2023 19:23:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 19:23:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 19:23:33 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 19:23:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpnH2WFcwdsnu8Pp6mf3C6btNGJMiLPokCz5BKZiPDCKXvpPAMs3MySYfWIRHrN/AXdZ/OGj+ES6siJzh0t48nQw9kNAh1hiiHylNiCiOD04FpxctjZ1HAVDOmZNfO4v0Mw9peOjv8wbnieSGmwsRDnbDVXb/tylMmjKmpC10zw+t1BLw8z81QGbLksFUK1H7Ua43Gsa08tf8KMmNrrkX7H1eSGFKaRkZ+z5yGLGbq5ey8otZ4sO+0LPdqqsyJgoWvYwg5F3uV7hb2fyG3/EAmruWcrmF7Q2yaoNamLQuSocMH7NFH7N/3ncTIq3k3DeI6MrDNs8N/s6Izg6Ju9WDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSuHvIbZbghZX4NIaY42eysaVhiRahH6C7SasYbdDE0=;
 b=EOUH7Z8Mw43PUBLfp3sZy5b6hmjb4BIH7Wc0F1eTTJCcKMwoogwdB+dIjRPp92ryUPxhOyt1DNBTHKRtXa4QOJ2XxbHFOViLaP1exEsXRJS/TeJ+z4/TtW2vXi3/HvarQwfVvI+Jz19o4/l8dnJ/b8rO/QdzaDrfm6h5O2NSlvrenhiot96X6GqyukFnpjQ3cEpDgw3cuR7yucfpJomEbf7vIt494IIJGwxC79hK+31HjNmco14s7+9SxRJ+hWD7EnU/1N884d5+AkKgUMJHPhApKCxp/nayInjwy1UofohSX0S1/um6VhMClky12WPAXi6PEk8Q0MJPqPGDWH5evQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Wed, 13 Sep
 2023 02:23:26 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::a71b:fe6d:968d:291b]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::a71b:fe6d:968d:291b%7]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 02:23:25 +0000
Message-ID: <92e300b3-d4d5-4965-4ed4-ae3974fba279@intel.com>
Date: Wed, 13 Sep 2023 10:23:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH] riscv: enable multi-range memory layout
To: <rick@andestech.com>, <ycliang@andestech.com>, <bmeng.cn@gmail.com>,
 <sjg@chromium.org>, <pali@kernel.org>, <u-boot@lists.denx.de>,
 <andrei.warkentin@intel.com>, <sunilvl@ventanamicro.com>,
 <xypron.glpk@gmx.de>
References: <20230905100935.428120-1-fei2.wu@intel.com>
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <20230905100935.428120-1-fei2.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|SN7PR11MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: ef4e4f72-77c1-4968-9cf9-08dbb40068d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cfV4YwJbaw8GFfOqsBW1vAKLG3lVzhDbXTAoy4rwAIVBXVFNr/oZxtRX23WjZq+PlEQrGGOiVMpIDHVYS8/DNY05a5LCwh5xNIpi5g/MVCApgOOAwu3nyRHUF242XKojCRlPgGm95KpanMneBFgsuNh4gLR+7yFlUMQwgtXgqOK1S58BFDwslqNuNFnYu045R/RuopuLc+T1WlFVZujaegCAxDIi1tXWlNzYCOZ322Et9VaJGUb3T78ZA5xPnqB6GbHzX/lmf+uigErgbROSGZRkxtPipGH/JUfQ0L471Ver+HpKOvC9qnXj+muF1Ai7C0WUDoJuuv7K+KlbPEbruyIJ2sFas5VTfyIyk0PewUqwaE8fOTP2a3Ku0RuUqnSWtPa5ZdbvxU8dUMU1tuGKwBfYQW4HPjmeKdiGklAo4RsRWKEDX4D1/5rwd45JewOiQJJbaQ64i3x8MbbyumQLOCitRXADdNyFKj+vFJWNvuARQ9EA5x1nJC11UlNjvkyLTp9jREDcDjnz1bX5cMon+NWoh4B53koIFLqCSZ/IKxMUKIcJYNuZSujAQz76gbESV1NMFaZ1i5vAg45qT8CfGZNZotu2sLdyeofCxSmRgCKgdu8iATdhPpU1MCnWsjUMfhhmmy4Kaf6XZWjK6wF6xQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(1800799009)(186009)(451199024)(6486002)(6666004)(6506007)(53546011)(6512007)(83380400001)(2616005)(316002)(2906002)(66556008)(26005)(8676002)(66946007)(66476007)(5660300002)(8936002)(478600001)(31696002)(86362001)(36756003)(38100700002)(82960400001)(31686004)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OS9TcFJ1UmR6Mkt3OTZYekNvT0sxTGpxYmJMZDlFcGJSVCt0TzIzRCs1ZmQ3?=
 =?utf-8?B?eXNQbjhlZUQzRnhZaWZkbHJ1SWVwV1hTTnUzL1VYWXpNYWVnYld0RzlTdlJI?=
 =?utf-8?B?TEtOL3Y5YWdZZFluN2JyanpkQ0NRRXVkcFpoQm10OGZ3bHV1TWR1NFp0RzhD?=
 =?utf-8?B?amF3eFJwQVdmVnJwOVB0cXpDMnp5amR6andnK3IvM1I0d3FFc2VlclQrbXVx?=
 =?utf-8?B?d1o3U2RJSHQ5eXkzT0ZmbXhTKzFIejdMMUJSN1pGVENZVklQaXdEbldPb0Rm?=
 =?utf-8?B?N2pFT1pMZG1lMWR6RHZJYWFRZDFVQ3ZKZkgwakdBN3VlZlhIL2kwcUlrMk9v?=
 =?utf-8?B?N3JETlV6WmNYZURRNUUwSGlLdllvVHMzazM1Nm8wZjM0QVBKNlRVSitCVXN4?=
 =?utf-8?B?MVlRamRmalBWTXBVbEpRL2ZDU1hIR3ZySVZZMTJsUXFiMDF2MENNYnowdWEz?=
 =?utf-8?B?eUVyNDJKenN6NFRHbS9nQnlENitWQ0lxaTJLMkZHMkN2MFptUGFzWUFtN0RJ?=
 =?utf-8?B?Y1FTZFBURmpQOGdHMGg2SmpSdTFiU0w5bEV1ZXNnUkh4ODJhYVVUQllHR244?=
 =?utf-8?B?MHJtcFBVQ3ZEZVNiZ1NicG82eHBHK2pORjF5ZUZKRW9DQitoSVo2T08ycm41?=
 =?utf-8?B?VDhrN0JZU0pHc0FiZDZoVCtLUzloUVJLWHpuZjdJY29EMC9PdW1TWTR1bEtx?=
 =?utf-8?B?ZjZleXZyWndxbXg2Unl5clZ0QXZBRmJweGtrREVua2JMbHVOY2ViS1pYRnRY?=
 =?utf-8?B?ZkN2UHB4eE5SZS9SeUhlWkpoa0Ixei9TWmVKWU0wbTRycng3VVBYVDNoQUNv?=
 =?utf-8?B?WWxyOUxTcFV1M3M2RzJ6TVVoZS8vRnVmQTRCQXliMTFHOEIwUXlUdWI5UHBL?=
 =?utf-8?B?dFFFYnFTYkpNSkhqZXRXZjk1ZUg2cWVROWVoNkNNSkM1YXdyaVNPMTY2eU5z?=
 =?utf-8?B?M0dqd3h3UlROaTBiOVllZWVZU09qSGpiRnNJdjVnbnh6eE9obllUVS81Q2VM?=
 =?utf-8?B?QTA5MENzaFNrTXRXbEh2dDFTRVRQeDZRWHlBTFVvalpsRW9FYVkzZEtjcW41?=
 =?utf-8?B?WmRtSUduOGsxcW1GVk5DNjM4RTd2RmlsOUtLNzZlVzQwTE05VitmR0VMR2Jw?=
 =?utf-8?B?SHY0SHp4dk5wWEpwUXZvTGdPTE5uL01EKzNvTEs0cDluZ0d5ZFJsSGlSakJ6?=
 =?utf-8?B?Tm9pcHVnY3EzZ2NUTWovdDV3NnBOL0ErU1NmbEFHbWgxaTUya1JnOUlWSS9N?=
 =?utf-8?B?bzkzMUNZdGxCUDlqb3p2NTUrTE5EeXlxc1haMGE2MTlZNlFxVUE4Uzl1anJw?=
 =?utf-8?B?L2dvK2tQQnFVeXl2dDZFRU1xOUtxcTh5bHRVSGt2bUplTlo2WHlQanFEZ3pS?=
 =?utf-8?B?RW9hNnFJQndocXh0MDBZeEhnMlY0UHY0ZFNzVVRnNHdHanlveDJvQ3BESVFI?=
 =?utf-8?B?R2E3azYxOGdTTEJzcDduT1hUZnZTcWxFbEplSnFkS3lDYVNleWtjdkxjbVRN?=
 =?utf-8?B?RWJjalJRV1pNQWY4UGlRMzdnaCtDS1Fkdmc5OXFOeHdzZmh5T2hEeEJSSWg2?=
 =?utf-8?B?akhvenJWY2o2OFpDSjc0OEdBd1R1dXhSb1Q5U09lRmRCRUxoRCtqV05GYlVF?=
 =?utf-8?B?MnJVUHZnekNjT2kzalk1N0RmN2ZVanUzaytScERNTWdmT0trcHBGM3BxSVhV?=
 =?utf-8?B?VHR5NGhvU2pOVFVrMmFXYTlPQjlpSnROU0w0SzM0RVdwUVZLV1VjOFRRcmxE?=
 =?utf-8?B?QkJXVHZzSDl5RVVsT2R4eWtxanJtMGhLRVBaUlpIblczVFNBcXBaZlJoMnNa?=
 =?utf-8?B?eUhmRGJxT2RuWkViNnNWUWFUS1FHSjVIMnk0TFhTenExM2QzN3llazV2bWRt?=
 =?utf-8?B?MlNiOWI1V1pUYnRqWFZvSlVSLzBlbXJ3UEhFY1VKbUd0eEVsZGtwcUdDUG8r?=
 =?utf-8?B?K0JBd3ZSY2pwemVqcG12V2xnWHJTYXRYMk5DMlpUcXB2ci9BVjdYckdYa2cw?=
 =?utf-8?B?Rlg4OVorMEpKdVc4TW1UK053SEYzeS93NU16bi9adU44dUViUFh1Tm9WcWRM?=
 =?utf-8?B?bzdYRDFId1RLK3ZMZWtndzlQclUvYlIwMG5MOUxpKytTK0p3aTFKaG1iVWxN?=
 =?utf-8?Q?/nKzOsxL0LpNfW3R82VZEM3L5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4e4f72-77c1-4968-9cf9-08dbb40068d4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 02:23:25.7685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fomeb3+X2sG83XbRvRUkHVcoCgi+nyedyEbpi+SSydcPwJw3Po61YyKaLiQJUR6fdc9iWPPYFzLyMBI7oc2+WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8283
X-OriginatorOrg: intel.com
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

On 9/5/2023 6:09 PM, Fei Wu wrote:
> In order to enable PCIe passthrough on qemu riscv, the physical memory
> range between 3GB and 4GB is reserved. Therefore if guest has 4GB ram,
> two ranges are created as [2G, 3G) and [4G, 7G), currently u-boot sets
> ram_top to 4G - 1 if the gd->ram_top is above 4G in
> board_get_usable_ram_top(), but that address is not backed by ram. This
> patch selects the lowest range instead.
> 
I think multi-range memory layout is a common requirement, PCIe
passthrough happens to be the first one to require it. Could anyone
please take a look at this patch and give your comments?

Thanks,
Fei.

> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> ---
>  arch/riscv/cpu/generic/dram.c        | 2 +-
>  configs/qemu-riscv64_smode_defconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/cpu/generic/dram.c b/arch/riscv/cpu/generic/dram.c
> index 44e11bd56c..fb53a57b4e 100644
> --- a/arch/riscv/cpu/generic/dram.c
> +++ b/arch/riscv/cpu/generic/dram.c
> @@ -13,7 +13,7 @@ DECLARE_GLOBAL_DATA_PTR;
>  
>  int dram_init(void)
>  {
> -	return fdtdec_setup_mem_size_base();
> +	return fdtdec_setup_mem_size_base_lowest();
>  }
>  
>  int dram_init_banksize(void)
> diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv64_smode_defconfig
> index 1d0f021ade..de08a49dab 100644
> --- a/configs/qemu-riscv64_smode_defconfig
> +++ b/configs/qemu-riscv64_smode_defconfig
> @@ -1,6 +1,6 @@
>  CONFIG_RISCV=y
>  CONFIG_SYS_MALLOC_LEN=0x800000
> -CONFIG_NR_DRAM_BANKS=1
> +CONFIG_NR_DRAM_BANKS=2
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>  CONFIG_ENV_SIZE=0x20000

