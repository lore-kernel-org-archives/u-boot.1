Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AC4F41984
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 09:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D26983C2B;
	Wed, 15 Apr 2026 11:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="dqU7IGNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6955083D8A; Wed, 15 Apr 2026 11:52:05 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0DF883936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 11:52:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CK3ezjJSq8EjM1reUZg/f98T/j84nxlj+x9hY5nzDqIIZag5V+UPE4SiUEJDmQChMj2kYbebIKhsrPHQBziUhFAAZrf6P9NAAf4CMxMoKmndP8p6WphFs2mV/tZ5o0eNq66CRGCChfWGFTTtcn0zpx2OlJ+o0T1owFxJ8u6s9iMdZEmkMz77I7kfp19iFulGLYtd6/YyzHDof38Br4Fq1HWqj4SUs9A0M2yAQgLMi9+p7x4mTfeJNYj1eroHbwkgBTVd3bZfxFSuXJe9Dvd19skpio1fxins40MoA+FaHEI/2lPOctAifRwurfjLJeXvgIyQDqS1gHTwXgmzYyEL0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+okCROaOB9EZC618UVFZs2bDfQ2erWjPQS1BteZ7/ms=;
 b=gQc2WAI3yVs1oM94LsklBH3bdw4CObke/vPj/QpfHuHZ27ApqeJ5Vk+smRdcCPk78vSg5digdR0kmPdMmMabRhGIwppj23FItJW2JcCs93UsQsHVduUZMXJQpizYlG3nUPlANblsiSVsD8kTAFs2cO8cghGQu+mZTf3aP0fOkukvKoymgOuDjVu5lm6QEix+Mwf7X661pUTR5kisYv8gB9p1YSl9JJug4RRS0pbfiPw3MPQpvklMdFLfGP62M6fgTCoPqUJpYPwah5VDmm7tKRGN9sQde9X75c8vnZj2l2/Ofb++lWPV1fCigoCMm0+hYGW/+unCcgcq6OiY1Tl9dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+okCROaOB9EZC618UVFZs2bDfQ2erWjPQS1BteZ7/ms=;
 b=dqU7IGNhRxeTc48Sa0OEhOkhXfM76lEGpeeNlllmEhfm6Bkc6JampjC/6gs6t/g7epuGTFsOq6zjA+tvQTobA7YKMAuLHTQx4UWNhtMVnLuK/RWqzP7asvcCvZ0BhgY6BuuBijSASAz/NJl7NqSJzZyUAHgGJI9a3KQwwrrJscCtH/Gfge/aa2pK643iBU91o9r8XUVuJK27j485h3No9ETWdgHxhJBEQcfSk63cGnsijAxs1csQ8u2UC9ea+mbSmE9MWAbQfqwkrp7itzNvny7kOUO50+zjpd9avghskE/H2nsx2xovV1ILJ6B0fjcQ+Hp8NhG6vXMn75xCmV/dUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by CH3PR03MB7507.namprd03.prod.outlook.com (2603:10b6:610:19b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 09:51:55 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 09:51:55 +0000
Message-ID: <16a14964-a42c-4506-b09b-c403a32b9afc@altera.com>
Date: Wed, 15 Apr 2026 17:51:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: watchdog: Enhance watchdog support in SPL for N5X
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260304040843.11298-1-dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260304040843.11298-1-dinesh.maniyam@altera.com>
X-ClientProxiedBy: SGBP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::27)
 To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|CH3PR03MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f65afe-45cd-4acb-3667-08de9ad4a0a5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|8096899003|55112099003;
X-Microsoft-Antispam-Message-Info: gzNohaLPVFUU03SoTq+4/SOpMD56Zbq+Qk8slRb6UM0EkvnJm41eDorj3kQUqIQAARCPJJZKsT475uXuRFWB+BB14zg1Vpsxb3e52mqmKNOHh6FxSEQtq9g5Osk7A7snUFMExai7wh+yLpgPBDZb4unxyVD3zY3cdisalifd3gss40PyNJhW/r2PNSjpoFEtpwQWGZSlINBAAeFMAEKqoag472pyQYf7qgcMmNO52lN/VetZjh08nqa5fgw8FcATUPC7KmmI5+ju2EiY1FJpWFruncpqSeNi/oyXB19BhxkeY3ouYyZfUDfwuR8qXHZW/mvE2ClGRT7JdNYVvdmCqQMSWTa748A1cNQlFQ0l4o6daPYIqaozEvyaxQSQpd+p1A5rXLFhHwQmrBNXWW377K24RMfP6AWABs4geNd6PGvlwdJc0Xi35hzgJZS3uEGpg20z9ejcDGDV9iN1pc0wbDOmBzoiY6jsZN7xTPFbBP78s1nJUj4nfXvBsTbcmaKgNJUTEUqTiLLVqNJm9IkN1LXJ+yKaG477IegjBHNIkno8n5m0o+tvjZxB8zYoCUhqfldP10FaSfDe4dQpK2pTCAQzhGLXv3baP1cNjwYh8QglbaueK9Z/WH3FRzBG0QXVdHuO5OxsZQjkZN+3Sm9ILA9IPTfK3fnH7b7/MEalUhoCB7WzQB1sveldM8UBy5xtAxl1qIG8a8ZXN1/L8nZc5AWr5PKawo2obUpG6rN18Jc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(8096899003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djcrOUNzcnFCZExrYloxekRUdzBHTGJhZm5SRkQ2SjNoRUhIZU45Y0pDdStN?=
 =?utf-8?B?OEZmTGFlbGkxRkhQSXRRbW1yd3ZmRkM3WVY2Z0lDMFpyd3R0Y1NmQWNWQTdU?=
 =?utf-8?B?cFJGYlA4bjZ2Vk1tNnIwY2MyTlA4MllkYk1wMHNOL1dSL0RJNkNhSVI1VmZQ?=
 =?utf-8?B?akxWY1RWUlpodFkyZGV3bGYwWnpuMmFoRVI2eTdkNERGUnRDYUpSN0pHVitC?=
 =?utf-8?B?TUpMcGc3WnkrbHk0Z2J2M3NCcGpEYStDUG1wb0FZaDVNaTdRb0JqUUduQnRJ?=
 =?utf-8?B?NnhVVVZ5TUdkQ0NTTVYwQzAzNHc4NUtTYWpNMytFcTVuZGNvVEdlVzQzZkNw?=
 =?utf-8?B?WXc2Z3hDbjZ1R25HMnU3V3JFWDdDQUtlRkJxNlVWOTAzSUovYlppRi9sYlpn?=
 =?utf-8?B?dlRVZjlBZGpNK29KWjRYL0FIa2hrRk1qZ09MNnBzT3Q2M1ZTcEppVFcrRWsv?=
 =?utf-8?B?R3NkMDY5cDB4MzZzU0xZdHgwT3h4RUl5aExvN1o2RkRzY1VGMThlNTduQ2tv?=
 =?utf-8?B?UFhJU1RDSzVTM1J4czhJWkJWOXFTNzZFYitJUWdlN1BpNGZRSkdjbnJuTnl0?=
 =?utf-8?B?TnlTTk4ybnZ3MEF1QW92ZXNPb1MyWEVZS3ZQaGlIQ2U2L2EvNE0rOE54YytD?=
 =?utf-8?B?MTllb0ZZQlJBVWtiZ1B2WTllM1o3SmZJNlp6QjVrWVhCQWZKbVJxNm51VG9i?=
 =?utf-8?B?US9jL1FDL0o4c3dmV0VxOUxHaUptdnJGOVdMQmtPeGRqemV1UHhJalpXd1cw?=
 =?utf-8?B?UzdYNytlT1M4MTJoTEtUZzRPRjZzNllvODY5bVkrcDBITUY4eXdQeFgrb2Na?=
 =?utf-8?B?RWdzWndWeURZa043WlREZC9wY1ROZUtHdzQ3VEYzMWtEUkxhWFVlVFgwUVRS?=
 =?utf-8?B?ZEphbEF0VHFIMDVOdHVHQ3NDdUhLMk0rUXB5a3N0S0R5NGRrbDBlV1pBd3RC?=
 =?utf-8?B?YkNVcm9iSGtqcVlEZWN0dDNGeFp6a3hXUXBVdFFEMFg3M1V3SnN6NDRnYWtU?=
 =?utf-8?B?WkxuUUh0WnUvWXVVR0dBQkpyS2I4UWJLcGZFbGVzT1g5RzBFLzcybHlXYWll?=
 =?utf-8?B?bXFZeWN6eFJYc096Z1ZSRytkOHI1UU84L21FUS9NNUdIdVBrZ1FYSlV4Tllh?=
 =?utf-8?B?Y08zencxM21nRUQ2NlZSUnljL2FiQmpIU1U1aXNpUit3S0c2cEtUb2tlT2JO?=
 =?utf-8?B?cUppWVdJVTlmVW1PcWNyOWh6Y0FYMnhVYkQ3NVZsOVl3WERtU3NmRUtrcTRw?=
 =?utf-8?B?MmZEME9qNFBlb2MrU2FtVG51OE1vSXA2UUNrMDJSc1RDZHorZk9XUkZBajkr?=
 =?utf-8?B?NEsxbWswcnNBOXpnZDNHSUdzcXpzT0hQZUd6YlpKNUNlNWFHdFY5M2NqY25X?=
 =?utf-8?B?WXg2U013c2ZmbUZiWlNGUXVuSE9wTzlPMmJWVVNSSXU2L1BvWlpUWE5Nek84?=
 =?utf-8?B?R1ZyMHZ5ZFhLQTVRYWN6cUtROXlUajIvaDdJSXpmU3pNS3F4TWZPV3VCUGVh?=
 =?utf-8?B?cEZJeVNOWGY2OXZSN0JQalRtM3RrOXl6eXNEQjRHalRZd3IzZXNRWU1NUTQ0?=
 =?utf-8?B?M25zdUZlSytqNWFuTlhaaWR5S2RnaUk2SWczdXo4bGwwa1JlQktlMXNrdEU3?=
 =?utf-8?B?NmpJSjg4MW5GZS82UWFpY3ZQSG5HVTVqV3B2Q0xVd3Y2Ym9vaGVMOVB2ZnZG?=
 =?utf-8?B?cEQ1OW5nR3NUWlBYeElYRE16ZEo3YTU3SGNsYUxrOXV2N0R2TmF3SXB2a2R3?=
 =?utf-8?B?TXZTeVZRN1RUMnc3WkpRMXU2OThuV3UvM2p4Y3ZwNWZCTWJ6N25tbmozbGly?=
 =?utf-8?B?NmkvalZLOGZZeGUxdGJXUWU5MFVtcFRJZW5KaDNoa2FmdGJtTXJHUHFNK0hl?=
 =?utf-8?B?SDExbDJTQTFrQXNObXJwSE5yR3pGT1l5NWhkNldHZytjNnNQNWJzMjNnRndX?=
 =?utf-8?B?WWhOSnhDRWZLdVRhYWM3Smg1b29FbERoeG1CZHhsS0N0ajdXelZEdXRzcWtL?=
 =?utf-8?B?RE1yYnY1ZnR0K2cveTN1bXYrWnUrYXI3OGc2RW9uZzhNN2pzdlFZK0ZnQWZZ?=
 =?utf-8?B?VkQ4ZVZIOGhPc042ZzBtYXFVNnJqaWxmNnBMeFVNRlRYRnV2WUkrZCtvU1po?=
 =?utf-8?B?U2loYms0cUZqK2RIQTBTdzNacGZhRk1wNm9GTEZwSHNEOVBLT2pScWVMa1p1?=
 =?utf-8?B?cnEyTDBMU25HZkVXZjRyTkNQRGdoWVVhNjJnSi9FaHNXNmdkK1E1aVl2aUhm?=
 =?utf-8?B?NEltMU9NMmNIUklBMG1VeTRHeWxiazNhdm5hbFhoRHVORU9WeUtQa0Ftbzlu?=
 =?utf-8?B?ai9SWG9kdjVVK1dCSWhObjRGc2hUZ25IS05Xb3JPOG9xVFZ5S0JnTk8yRjFo?=
 =?utf-8?Q?NO/WjMP53M5qER/w=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f65afe-45cd-4acb-3667-08de9ad4a0a5
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 09:51:55.5641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 183aYGA0M+MSZNK/pqeW6aIIsFKVGhTqF9OvW1oKc27tT8761jYmSekxixhg/8NB4VOi5UYg5AgJoYeR1wwoQ1LS8X1+oU+yAq0jfkakx2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7507
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


On 4/3/2026 12:08 pm, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam<dinesh.maniyam@altera.com>


commit subject scope mismatch, expect arm: socfpga: spl_n5x: ...


>
> Enable watchdog before initializing other component (example: DDR).
> Thus, watchdog need to be fully executed in onchip ram.


The commit message does not fully describe the actual change which 
switches from the

legacy CONFIG_HW_WATCHDOG path (hw_watchdog_init()) to

DM watchdog init (initr_watchdog() with CONFIG_IS_ENABLED(WDT)).

Please update the message to clearly state that behavior change and 
rationale

Wording/grammar Minor wording clean-up would help readability, e.g.:
“before initializing other components”
“Watchdog needs to be enabled after the clock driver because it 
retrieves the watchdog clock frequency.”


>
> Signed-off-by: Dinesh Maniyam<dinesh.maniyam@altera.com>
> ---
>   arch/arm/mach-socfpga/spl_n5x.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
> index 81283ef7162..22c20f89b4b 100644
> --- a/arch/arm/mach-socfpga/spl_n5x.c
> +++ b/arch/arm/mach-socfpga/spl_n5x.c
> @@ -9,6 +9,7 @@
>   #include <asm/arch/mailbox_s10.h>
>   #include <asm/arch/misc.h>
>   #include <asm/arch/reset_manager.h>
> +#include <asm/arch/smmu_s10.h>


  doesn’t appear used by the patch itself


>   #include <asm/arch/system_manager.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> @@ -19,6 +20,7 @@
>   #include <init.h>
>   #include <spl.h>
>   #include <watchdog.h>
> +#include <wdt.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> @@ -37,13 +39,6 @@ void board_init_f(ulong dummy)
>   	writel(SYSMGR_WDDBG_PAUSE_ALL_CPU,
>   	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_WDDBG);
>   
> -#ifdef CONFIG_HW_WATCHDOG
> -	/* Enable watchdog before initializing the HW */
> -	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
> -	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
> -	hw_watchdog_init();
> -#endif
> -
>   	/* ensure all processors are not released prior Linux boot */
>   	writeq(0, CPU_RELEASE_ADDR);
>   
> @@ -69,6 +64,14 @@ void board_init_f(ulong dummy)
>   		hang();
>   	}
>   
> +	/*
> +	 * Enable watchdog as early as possible before initializing other
> +	 * component. Watchdog need to be enabled after clock driver because
> +	 * it will retrieve the clock frequency from clock driver.
> +	 */
> +	if (CONFIG_IS_ENABLED(WDT))
> +		initr_watchdog();
> +
>   	print_reset_info();
>   	cm_print_clock_quick_summary();
>   

Best regards,

Tien Fong
