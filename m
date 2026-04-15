Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8681FA0C26
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 03:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 338A183936;
	Wed, 15 Apr 2026 05:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="pe91V49b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D2CC839D5; Wed, 15 Apr 2026 05:55:41 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AE1380086
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 05:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBF+F+hsnJEi3B3uR9BJRWx18Q2ErypaCqi+QHvZWA8DOMaXbibK7pSND8Y9chSSzHSeMn2G07cvcmfWXiVH8uBP+bOqH8+ZpZVm91Gg6uShbAKbebrau+I8wXVeQISZo6EwhsLEsnYYBD6y5mt/nhZK8434orIfIjZ2pF0kGcl8+tcAhVT9AObZ0gZLsAdD2mCRaFn/AsHkKRa1LUuNOnhllOkKQ6+94AbEwvqEzY1ed60HbLIpBlauztHQMPZuGkq7tDzuAeTq86GJW5vORYyV5+OVcYqwyrCx/2IJjLnKC7H5u8iKNlEyWr5UfUA+RtHyIMx3ZBVBWBu+M2DFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCDBbemsyeofR/kQirv1XBUCGzWM0s/DGtVku189bZA=;
 b=ptTlPjCXq3hZOhecmoKP+Hzr/zjedl7/WBzi/hwGCC/LIf11Q8OzvHLLFTwU5Qz6qBg3S9KFmUZ3F+nnPBCInY/BUzhNwU03SOYxvmj5hn9v+o1XOrH4zdHWZEd80lOK3Klqz6E6mdJnD78NtNsEiksGnDLRVMUaBPMBoowL4jUV1pXFDI/mW3RWpp6soRqFz4EihdoCmomFjWnCpsjUcs4sUK9XgmT7Ik8s4MSUClVj+kH4NAAY3omekn2YKsidQQ9xBvfSbYoyuBpF4A1CCnqxliWInqcIpa06HRxFVbuJrYAUapZHXnbiyGPD1GwSO/ZhNL66TygWKA15vyk+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCDBbemsyeofR/kQirv1XBUCGzWM0s/DGtVku189bZA=;
 b=pe91V49bO+kSSRqAJTB2nGYxlwdUZYFhyb0NkMA4Z9uoUhGpgNPvGEEmzJ0JLPGolG7/dVPqMddZBOcYg2ja8cb0eQRjwop6qypBMQy7NxP6zgkIWfhXiy0RCn3uWHOIf8mZDHrooAmwVghxfB6wfrAjAxsonivLaNlSx0FW33zBw3CEeo93HfqmkJ2LvTB4nQpIzNJ/ZfNk+84ujhiFW7oHqE6eMz5PohhB0hQ5rxgsKCdU+HAD0O4sJWG9pi6veZixHyhPfbbGUfxm7mI4KuZs5SKXUh6ETWeSECvOH8xconcd/ha2CYYE23mrtNR/yADcaW+JN/sEFYu6luUclw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by PH0PR03MB6219.namprd03.prod.outlook.com (2603:10b6:510:e8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 03:55:32 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 03:55:32 +0000
Message-ID: <a7327c7c-e4a1-4bdc-a817-6fabc92f1191@altera.com>
Date: Wed, 15 Apr 2026 11:55:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm: socfpga: Use custom header target buffer in SPL
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
References: <20260304033029.10825-1-dinesh.maniyam@altera.com>
 <20260304033029.10825-2-dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260304033029.10825-2-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|PH0PR03MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: f1494ec8-7d46-484f-1b68-08de9aa2d757
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|55112099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: W+EJTMNpbbzzpU7h05rCROrSkMdQ1Xta8t4YsbjRgmB4/zIw9nW6jUe/C0q/iHX+JHSS+HDQyfrfdJty9oRNP5YYqFES+IWoNkTKCDu2NjuCUDzB6XE9aDyKgamUzRWtzrYxFh/1rh2i7XIQuqmMCYRtTaq3KSZfSzY2LEFfJGed8Fj5+02w/iCpNQEqgulLKR51TgIZs2aE3YBK3DGbftJ8NnhE5fSqfB6NeHb8Ms/nUDNmqNQO1zqq0kDo19EVOTeD1kh727rc69qkblnsj0oHbeRniPYfwAPY2gq7XN9T5Qrs2lQfdxDLkx7w4VfkUddOGFL9/3pWW3MrQx/y2X3GxnJxfxkJ6eic2TOO4ObqK8rTiCTv4QHJUw6tJjfvUea8DayndudJd7r5huRy9GCUli+mkRKClo5fBmkOWIVrags8xM/wZMnVvVd2e8BtIgt4UDHSMiBZW7S25dunQjaE1nJgbzITxmi/GUUCi0/e76NYmZnqD+FmACY3JKRKJ9x8picpCauAow5E5bA1hNB0TLURlb3oxt2M8Ys4suf6nhiSKzgF8F0nQ94NzdITJ9m1nvHQ0Ji4CEwZrCC9ZxObTKIoaV+fIYS9QUohmLBbzoz50+nZammc69P1E1RYazHPL/VPtDs185V56mm2cT9EekOcQyd5wBTCE1hQTpkF7E5vRHgeUE5xHqs6EntYCll8RqjCQF309J0ZMqDf4VUgKHCgbfcWOA4G/WVfS3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVkvbkpUMzlscCt3SVFpQmFFYnlKNTkxS00zcFpJTjlvRVRLcmZ2KzErcEdK?=
 =?utf-8?B?ME1CUzhuWXlIaUxpQXJxS2dOWHdYeURhR0FoWXBCRUVGa1VvSjVvYWtPdWc0?=
 =?utf-8?B?WXo5dkU5YUtWNlQ3ekNsaFh3VmxhK2w2aGpEVGZXdUg1TXcvZHlkKzBka0xS?=
 =?utf-8?B?c3Bra2RFS0J1MjNlSWtNdmFJOXFpcjZ6d1ZTKzkwS1YwcnZuK0JNUStWcURK?=
 =?utf-8?B?K2lDa3Y1U1hFd3orcU9aNSt0d0xheHlpRXg3NzhZbHVsNkpFZUZPMW5HOTUz?=
 =?utf-8?B?WGZTeXZtUlZka2tXQmcrc0VMZm9Uek43QUc3U210a2dQb3VQc2VBMmVDRHZY?=
 =?utf-8?B?c2hscVNNREVhTDhqd1dOWkZuWnJGeEtsTE9td2N1Rzl2UjVzWWJHZTVOUUlD?=
 =?utf-8?B?QTZYZk1XNXo4U3A3MEVWR0IwL2Vsa3NFS2RaVGx0MTVUTTdaR0ptTHZhQlBa?=
 =?utf-8?B?aWpBTzRMUXBvNkFLS1QwWXBLN2pJbWd0OTdvN1VZNDEwNGc5NHVvcnlmTSs3?=
 =?utf-8?B?VytoV294NnpDbVJtdGtSamZ5TTUyQjlpTkh1ZWtnUXhzNlNBbWJDcXZhTEFE?=
 =?utf-8?B?M1ludUJCc080dEhIYXZyQnNYVVlHTVNmMmhpaFlmWFFRaUJWUnhDMEhidzMv?=
 =?utf-8?B?bVRvSVFPNjRhMWp1ZnFEbTNZQnpkTlV3SFF0TURjeGtudTFyQjNwNitCQ3VU?=
 =?utf-8?B?Ny9vTVF4aHI5VHNaOC9YZ0RqTzFDN1dUcnpQM21iMXVORnNkK1huQVRISU0w?=
 =?utf-8?B?VldrUFBBUExwMG92d1ExUFFrekxoNjMrQnZlZTNqSmlOQmNvQ1B4STkwTE1E?=
 =?utf-8?B?bUFlazU3Z0xKK2E1VmYvN2JYcDUvSlhiQXFuWjVXRURmV1hnU21iQ2NrVHRa?=
 =?utf-8?B?b0hoSGtSb2FnYmNGc2Z3YUdUUzhCeGpEaCtsc2szUGloUHM0QWlQQjJzUGxC?=
 =?utf-8?B?aUVXcnNUOGdiVVFGa3hiOHM1WVZEZkR2NkdZbGFvREVWcHpoNjlXZS9BNkpK?=
 =?utf-8?B?d1VsY05QcThnb3pQWi9IS25FQi9uMlRLNyt6bFc1ZjRwOThCT2lRWFVwbWxC?=
 =?utf-8?B?aXFnWC82b1lCNERkaDgwd2IxRDVzNHRybklwSGVhTUw2ZUtzU2JnL28raGRN?=
 =?utf-8?B?R05ZSnBDQytsWG5lQ0ZjU2orNCs0emhpQktRcVNiWmZDTEpXYWlEZ0pjbS94?=
 =?utf-8?B?SGU1OHhnUFRxeHEyUzREdzVzakcwODB4Rmo2cmlxL3dHN1Y5MTQ1cXVxTGFH?=
 =?utf-8?B?VXJGR3UwaXVNYlVTeHg4UGV1Z3BjSlRGNldqRjRFRDEwWUJ4K3dVWksycnRR?=
 =?utf-8?B?alRsMzhKdTB2SmEzdVVLekdadkZLcTVCTzJ0RHg0UEpmNzU3Qy9oakRMNzV5?=
 =?utf-8?B?a1djK01OLyszTjh5dkFxaSs5R1hSem10cGhsaHp2YTJtK01KUlNFdjZxVk15?=
 =?utf-8?B?YmJiTlQzQWFjL2RuVXNFcUczV3NrblM3Ylpwc0hVOVRMZWV2YzdIaUVGSnRP?=
 =?utf-8?B?a0FTY1RIcW9Wejl2a2ZzVTgrYjljN2p3dFNXU1ZQVCtPTmEwZFdsRDlhY1dF?=
 =?utf-8?B?RDZxMjY1Rzh5NHJITlVzbXNmZzhXSFFUT0JxMzdkc2xFeHVoa2dLSGM3NWEw?=
 =?utf-8?B?aTlFcWo3RXV4eGpFbWxIaUZDV0p2dDl1ZjhFVktKSklwdnBNOEk2dlRtRzIv?=
 =?utf-8?B?cU1tTGtJT1gzNk1FNDFlRU80Z2RySjZOWEgzbmh3Qkx5cHNHUFNKZ3RVcllY?=
 =?utf-8?B?VG9aTVdoejV6dlZsdFJySVFkQlZja09CMWhpU1JuR2o2WTYwZHFKMUp3WDQy?=
 =?utf-8?B?cDBodkZtVTF4azd5TDBobmZBVGs1VjFyVS8wODNGUzNCTytWNldKd3BkSnNr?=
 =?utf-8?B?YkVOcWNveHVabVF4L2FXbEt0TnRmV2ZtUXhpTnhvM3k5a1o2Z0ZDZnVtbDIy?=
 =?utf-8?B?OGx5bTYvcW9xVG5vbU1SaGxaUEVGc3FKeWFmRGx1ZEZhclpLMi91MHRLb1dK?=
 =?utf-8?B?Y0hGSXViZCtWSnhNUUJSMndKOEkrZ0JWdENFRE9ncWVsL01JaXFkSGJITlVm?=
 =?utf-8?B?M0h2bTc1VWpKUEp0YkkrakZZNWp1R1ZWakZUZEZQaEp0NVh4MSsyRnBJdXNM?=
 =?utf-8?B?dlJGcnUrTHpUOTFId1pEODExM1JNcU1STmhQUG1nNDllcGo2MTJnVmMyK1BC?=
 =?utf-8?B?U2NOZWJOa2UvVTk0TVFHUUN5Umswd0JEWWZmS2dIbU4vUk5xbUU0d3BuRWty?=
 =?utf-8?B?N3d3Nnl1cVpiaUM4Y2V3WHRkaENaZU1NWis4c2ZEY09IMzVLdHNVUmpNUkZX?=
 =?utf-8?B?Z2k1WExIc01iTFRzZjF6VHFzelliOVpEWjBtZXliRmp2YmkwRlFSUG04T2hx?=
 =?utf-8?Q?QfrKcksJeg/Hmz0o=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1494ec8-7d46-484f-1b68-08de9aa2d757
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 03:55:32.4065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8vrhHY3Sve2Gg9IPzUmOlglpesTuVGaCWtvTVLIQUZ+oaAwfIJGB1YmLx7byp63qdJ6HY5p6/37w1Jp6HfMt+560QBu5mpM2M/Kv5dS/Fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6219
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

On 4/3/2026 11:30 am, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>
> Allocate buffer from bottom half of DDR for the image headers in SPL on
> Arria10. This allows SPL to load the fitImage header, parse it,
> extract the FPGA core bitstream section from it, and program the FPGA.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   arch/arm/mach-socfpga/spl_a10.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
> index c20376f7f8e..c3fd90de8c5 100644
> --- a/arch/arm/mach-socfpga/spl_a10.c
> +++ b/arch/arm/mach-socfpga/spl_a10.c
> @@ -27,6 +27,8 @@
>   #include <watchdog.h>
>   #include <asm/arch/pinmux.h>
>   #include <asm/arch/fpga_manager.h>
> +#include <exports.h>
> +#include <log.h>
>   #include <mmc.h>
>   #include <memalign.h>
>   #include <linux/delay.h>
> @@ -284,3 +286,13 @@ void spl_board_prepare_for_boot(void)
>   	writel(FSBL_IMAGE_IS_VALID, socfpga_get_sysmgr_addr() +
>   	       SYSMGR_A10_ROMCODE_INITSWSTATE);
>   }
> +
> +#if CONFIG_IS_ENABLED(SPL_LOAD_FIT) && CONFIG_IS_ENABLED(SPL_SPI_LOAD)
> +struct legacy_img_hdr  *spl_get_load_buffer(int offset, size_t size)
> +{
> +	if (gd->ram_size)
> +		return (struct legacy_img_hdr *)(gd->ram_size / 2);


The function currently returns gd->ram_size is a size, not a DRAM base 
address,

so ram_size/2 is not a valid pointer unless DRAM happens to start at 0.  
Even if A10 SDRAM is currently at 0x0,

please use gd->ram_base (or CONFIG_SYS_SDRAM_BASE) instead of assuming 
base=0.

That makes the code robust if the memory map changes or if this logic is 
reused elsewhere

This can lead to SPL writing headers to an invalid/unmapped address or 
corrupting memory.

Please compute the buffer address using RAM base(if valid) + offset, and 
also honor the offset argument and bound-check against the reserved region.

Since you want a scalable solution across DDR sizes, you can dynamically 
reserve the upper half of DRAM for header parsing:

     /* Be defensive */
     if (offset < 0)
         return NULL;

     /* Need DRAM initialized and sized */
     if (!gd->ram_size)
         return NULL;

hdr_base = gd->ram_base + gd->ram_size / 2
hdr_size = gd->ram_size / 2
require (size_t)offset + size <= hdr_size
and return hdr_base + offset (aligned - ALIGN(addr, 64);).

Also please drop unused includes (exports.h, log.h) if they’re not 
needed after the respin.

Best regards,

Tien Fong

