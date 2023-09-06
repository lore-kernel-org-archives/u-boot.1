Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB9EEE14B9
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 18:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F51A869D6;
	Wed,  6 Sep 2023 20:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Ao6vTQZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDDB7869DD; Wed,  6 Sep 2023 20:10:31 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 916CF866EC
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 20:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=laurentiu.tudor@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRUrHXFosO9Oo9BYHMPwI8iTwHfft0hCoJy6vrOQt3r2jKwaQX7BD1DGuKWTsgJWrS5GTzNw0wM3I0rmgWTSVJ95i+qqkmzQHB6YKlzZ9Jc8bzIAZ7N3Qo0T8ifcscPTzPiSvQltRZ8elydeqsxjmPoGkibgyKDP7hsGEe564e3BRkE+R8UeDSr2D8GUSi2qOXbfb9xrFNOhYQehgusK9TAHIFcYdeMosYRpbLiVI4tF8fnjgYZZf+ONL1ElKI5mlawYw2L2SZQhxBdPIevEPRQpJwmnu3ivL0U9V+p7IEB3RFR2+9g9PppGYA7nJqOWcwBVKUou8FTBlfJf6yYkOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UJozbazRRCnRiPqOcv8mhyFaa/AiAVrfROP8pTjwI4=;
 b=hgaTta3SsFb0VUJtJW/dCS1S6SpziLhCi5uqigwEFPprJwzZZN9wxFP5AoqEuhnBmgb6NT7p5weqteePHSO3OV+07184COvN3WA+meMA7EzL5mLkA7lyiCzlgj+i3mGzybR/dkaH3H0aVxGTZDVEexqegOJiF0RosR0QO4r8QWna/cv3v0SWN5CjJH7Tnx5USxo7L6nt/rICuynlzaBJrqF/io8ygdGsp9wuCWWx4oorria2ZNDM33Znc+ssIHi22h933dcLpn4egEdHQZbP9L741AyGIiMq0gRf1qMHxtmIM6icNYxTz70EUkpKKFi7CefGwkXTfTWnjaHit2NTog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UJozbazRRCnRiPqOcv8mhyFaa/AiAVrfROP8pTjwI4=;
 b=Ao6vTQZTTqbSDWu61H4y7TDRMnI0+pTbTxJpNXfe4SldI0llOjIN1u7L8l0fMDkgbSNiWAz8kchnjXnxu8qaRFD85gYa93fx0e2MK+g0G44HtjoKqMIL86Uqbfd0hDVX3tboraZZxpiblHYZZCLFDhwGtn6SUmjucI5F/iKu+1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by AM0PR04MB6834.eurprd04.prod.outlook.com (2603:10a6:208:17e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 18:10:26 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 18:10:26 +0000
Message-ID: <1931b72d-8345-73a7-7a2d-8c64a5168047@nxp.com>
Date: Wed, 6 Sep 2023 21:10:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/5] armv8: fsl-layerscape: create bypass smmu mapping for
 MC
Content-Language: en-CA
To: Robin Murphy <robin.murphy@arm.com>, Ashish.Kumar@nxp.com,
 priyanka.jain@nxp.com, wasim.khan@nxp.com, meenakshi.aggarwal@nxp.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, peng.fan@nxp.com,
 sjg@chromium.org, sean.anderson@seco.com, ioana.ciornei@nxp.com,
 u-boot@lists.denx.de
Cc: thierry.reding@gmail.com
References: <20230906160152.24185-1-laurentiu.tudor@nxp.com>
 <20230906160152.24185-3-laurentiu.tudor@nxp.com>
 <56c3c58c-e871-5bfc-d256-fff30cc5cbf6@arm.com>
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
In-Reply-To: <56c3c58c-e871-5bfc-d256-fff30cc5cbf6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0014.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::17) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|AM0PR04MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: c26d27b7-71da-499f-cfbd-08dbaf048b75
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 878Ricqa0UF86/4Y2bZ7m31oS4wDmhkkSBT9X2kjQcFFj9H1i4QiUd1PmTv3v0aYqZDVke98K+sZk4mGHI6YwADnGSTiclY4YynMBRsqBaqZwKwGJ8uzssFPx3N6T8OnqYekOQKcVuarXic+IWqUgkgOg1guBY+ee3cf6aeTLWk4Dgm67FkxfBTJilSlvu14nMhEADn+KkaVhHKu1G+/d6kUZpJTA7Tlxa+TqzeaGnaNM0KlMWDlUPlRcfoVNAfgXb0s9je4nUeKQD02cU1pNtlyXcNBUbe/1nZY1p6NtquCCZ7W1YmlxGpTGXfOnVskddAHCgQoOsf3zbzDcYqPLBYurYXzgKbfcgrCPGeLceLsqtoJL1a7kScuDAuxI9QUeOZ5o9+XRctRxJrSSipIyt8schOywK38sEutpLZ5y8+zYG5PiJHFvbdLreL8+WjNU3Dj/6CHwR31iZd+tkQAbI/g/QNVKoF3nO8eEEw+m4t6TeIqOoNwK20vNttKcZYl9WAVKQAqewZoAWgoTrYS4+o85kqpJzP+omOQEIXD24DtLG8tLUf1dzoAqtJeN69ynW3WIIrfb/S4McDDGY2boH2zTE1cTAb5ntaCkJCShQ5gKoh38U7GKuVREc9xuIjuDJ+Jpnueb/5+1FdFJqvrjay+BjvTf7BN4E/qbpvE3wao+onb8SwSH2pH8cboJnSY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9380.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(1800799009)(186009)(451199024)(8676002)(44832011)(4326008)(6506007)(6486002)(8936002)(6666004)(31686004)(66556008)(66476007)(66946007)(5660300002)(41300700001)(478600001)(966005)(55236004)(6512007)(52116002)(53546011)(2906002)(316002)(26005)(2616005)(83380400001)(31696002)(38350700002)(38100700002)(921005)(86362001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2hNTFZIZHRjdzVtQ0t2VU9NVEk1ZmlVK2JHK1E4VEttNVQ1OThQM3d6T2l6?=
 =?utf-8?B?a1pGQW56WDZhcE5ia3RmQ0w5STNncGFiY1plMzZvYU1NcUZWaExRYzdDS1lY?=
 =?utf-8?B?Q0xMUW5Qc05jVjQzSDRKVTFpbmxFVlpCSThFRUxURWZqMC82YjErRGZGeGpW?=
 =?utf-8?B?aTUrcnl4KzdhTzRtS3cxTTA0REcza3dzejZocHVmVWc5TnozeFZ4Zk9PNkFl?=
 =?utf-8?B?VHNUdzZiZ2VjMHV3c25zSmN3WmtKNFBlU1llWnBML2JDZHhGMjJOMUhJOFRI?=
 =?utf-8?B?cWpHY3E2SFdoS3JMUFdWY1FOazRHK2JsOEh1dlJyYlVGRm51QmUrUTdlUmJQ?=
 =?utf-8?B?ZlJBNzgzUUFkdVYyWjRRbUtibmdhRmlzOGw4SHJhSVIvNG84Nllyb3piMkZk?=
 =?utf-8?B?SjJSSENRTkRueGJhRTVUQ1Q0YStJQ2RoN0hQM3RIcGxBcXJMVjJXWjFWRW91?=
 =?utf-8?B?VUhJKzBtc2JBZkRZeGhzeTNLUkJqWkxlQnNzaVRYMDZDdjVhQmFVdnYrZDR3?=
 =?utf-8?B?QngrSXEwUkU4U3dWS2tLNkVKY0pYdHhiT2h5RVdzWWZyOTJIUFRvdUltdy9Q?=
 =?utf-8?B?VVYveHo4ZVNDMG5GTmU3cDN3YUxua1g4eXFkL1AxaUlEcSswVnlmNVJmS2g4?=
 =?utf-8?B?NnB2eEtHMUEwdE1Pd0JoSWlNelNqMjRFOXZXNFBYR0R0eWgvanova2oyemNS?=
 =?utf-8?B?U3J2Yit2VWhiYUptYXFxeEJla1JEdER1aTJydDA4K0V2MFlMY091WGpMQnYv?=
 =?utf-8?B?SWFPb0hoOEh1QzFUMW95T1BGR1pUUkRpZUplWlRWK3NsVlJ3UWhVWncrcFJr?=
 =?utf-8?B?K2s3MDRla21pRGRwSGtEMlJRT2ZqRjdqaUZubVQvTFlXVk9EQzF5MmFFb040?=
 =?utf-8?B?SFJwVTFOcUxHSm1oL3ArSUp0WExnTUcvdHJuaHFEcDZOZ0YwSlRjVENFa29w?=
 =?utf-8?B?NTZJcnZzVzVLdkhHTThSVkdyVFJHSkdocHVnZzdkSVRPajhHSFVXdkFNTzJW?=
 =?utf-8?B?cGExZko0N3lJeUw0MEhNY21LdEJqazdQanhEMHF0bU9TMjFnOHBXdloyL2M0?=
 =?utf-8?B?Y1l5L0lOdDRhVlVoQWg5dDllbXRyYmdGUWtUSkhvam5nOXpZUlpSUVgva3Zt?=
 =?utf-8?B?S3FGQmdBcXhJejA0bngwZWJzZnhwRkxJS0tCSUdRQlBaQ3dTcXRPRWZaYkJY?=
 =?utf-8?B?MW5tbU9DOHNBNHFnQ21IQ0Jtd3Jqdm40Z2hHYmRBOFlGbTh3N0x6REdwNCtI?=
 =?utf-8?B?aUVxVjhFZ2F2Sm9TOFpTRStjcWNCb0thZnRqRXpBSDJwSXNWQmQ0RGJCUWtj?=
 =?utf-8?B?YUs1MHczR1FNMHFyKzRITXhuRWZnTS83NFpNUHBEVkdsQUtLVi9GcWVVTHVQ?=
 =?utf-8?B?aHVXMmJlcnRnZk1TMGVZcEY3ZFhwVkVMK1FIRDZoZ3BWTTFCS3J2VHpWV1Nn?=
 =?utf-8?B?T3hCUStoZHhHMlFVbDdTSzRtV2dybnFMNTh6Um1lNWtNTlNGM3NWalF1anBE?=
 =?utf-8?B?ZGtxUk01eXlPbmtkOC9JbmI1MUh2M1ZlNnFSVVREQitDNTNVNXVhT0hQZWVU?=
 =?utf-8?B?eDNPNEtob2VqN2o3Q0Y3NENsQ2Y4VS9hTzRwRnVDTGtKdnV1Y29GczJSTjJr?=
 =?utf-8?B?dzVDTDFuU0FtVzdiZHJTSHFqN0RRZHUwT0JjVjlEeGdpM000R2p2eXMzN2Js?=
 =?utf-8?B?ZU5wYi9wdXl4QXFQVTFJMEt2d2o0YlF3N0R5b1hJbC81dWVuYlBQaC9SVDIx?=
 =?utf-8?B?cVlRZ1pLOEVDS0ZzTG9PcnJFMjlsYzlFbEk1d3pldlNWVHJldDg4QjBqRjhP?=
 =?utf-8?B?bENRVWxnRmpueGUwWXFIS3d2QmpjMkErY1VZOS9aRmMxNTNLSGJZZzJ4cHYx?=
 =?utf-8?B?dmdiT2ozRm9HS2ZHcWthUHBkMzQwbThBNWhoOXNaMUN1S1JvMUZZWXhDblRh?=
 =?utf-8?B?OENpYjdTS21pc0JFTmlZRHJGVTI1WFZ5OGhzVXZ6WGFWZ0N2Mk5kNklPeWNM?=
 =?utf-8?B?RFV2WFlBSHpXZHo0WnJtRS9qUFZZYUY1Y3pqdGlpQmpyajAzWlpBRWkzakkr?=
 =?utf-8?B?UC9qSUZhMzhyMS91VVUyUnJYRWp5NmUyUU5wMXFxLzJLUjRrTnRnZGxQMDRH?=
 =?utf-8?B?bzd6SU1NUi9QN1hla29pL0lkcW5IQU8wT2F3Z21ZSkdFRlJTMmpxQVBPOXMy?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26d27b7-71da-499f-cfbd-08dbaf048b75
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 18:10:25.9977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50qxdMniNoF8s2TGAhFvzrncCdc4/TNWM+RwbyeuHaz8KSGiYgce1oZQtQ9cvlo63ljrDb+6BnpcQHmXhijX0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6834
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



On 9/6/2023 8:21 PM, Robin Murphy wrote:
> On 2023-09-06 17:01, Laurentiu Tudor wrote:
>> MC being a plain DMA master as any other device in the SoC and
>> being live at OS boot time, as soon as the SMMU is probed it
>> will immediately start triggering faults because there is no
>> mapping in the SMMU for the MC. Pre-create such a mapping in
>> the SMMU, being the OS's responsibility to preserve it.
> 
> Does U-Boot enable the SMMU? AFAICS the only thing it knows how to do is 
> explicitly turn it *off*, therefore programming other registers appears 
> to be a complete waste of time.

No, it doesn't enable SMMU but it does mark a SMR as valid for MC FW. 
And the ARM SMMU driver subtly preserves it, see [1] (it's late and I 
might be wrong, but I'll double check tomorrow). :-)

> All that should matter to the OS, and that it is responsible for 
> upholding, is the reserved memory regions from patch #2. For instance, 
> if the OS is Linux, literally the first thing arm_smmu_device_reset() 
> does is rewrite all the S2CRs and SMRs without so much as looking.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/arm/arm-smmu/arm-smmu.c#n894

---
Best Regards, Laurentiu

> 
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> ---
>>   arch/arm/cpu/armv8/fsl-layerscape/soc.c       | 26 ++++++++++++++++---
>>   .../asm/arch-fsl-layerscape/immap_lsch3.h     |  9 +++++++
>>   2 files changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/soc.c 
>> b/arch/arm/cpu/armv8/fsl-layerscape/soc.c
>> index 3bfdc3f77431..870b99838ab5 100644
>> --- a/arch/arm/cpu/armv8/fsl-layerscape/soc.c
>> +++ b/arch/arm/cpu/armv8/fsl-layerscape/soc.c
>> @@ -376,6 +376,18 @@ void bypass_smmu(void)
>>       val = (in_le32(SMMU_NSCR0) | SCR0_CLIENTPD_MASK) & 
>> ~(SCR0_USFCFG_MASK);
>>       out_le32(SMMU_NSCR0, val);
>>   }
>> +
>> +void setup_smmu_mc_bypass(int icid, int mask)
>> +{
>> +    u32 val;
>> +
>> +    val = SMMU_SMR_VALID_MASK | (icid << SMMU_SMR_ID_SHIFT) |
>> +        (mask << SMMU_SMR_MASK_SHIFT);
>> +    out_le32(SMMU_REG_SMR(0), val);
>> +    val = SMMU_S2CR_EXIDVALID_VALID_MASK | SMMU_S2CR_TYPE_BYPASS_MASK;
>> +    out_le32(SMMU_REG_S2CR(0), val);
>> +}
>> +
>>   void fsl_lsch3_early_init_f(void)
>>   {
>>       erratum_rcw_src();
>> @@ -402,10 +414,18 @@ void fsl_lsch3_early_init_f(void)
>>           bypass_smmu();
>>   #endif
>> -#if defined(CONFIG_ARCH_LS1088A) || defined(CONFIG_ARCH_LS1028A) || \
>> -    defined(CONFIG_ARCH_LS2080A) || defined(CONFIG_ARCH_LX2160A) || \
>> -    defined(CONFIG_ARCH_LX2162A)
>> +#ifdef CONFIG_ARCH_LS1028A
>> +    set_icids();
>> +#endif
>> +
>> +#if defined(CONFIG_ARCH_LS1088A) || defined(CONFIG_ARCH_LS2080A)
>> +    set_icids();
>> +    setup_smmu_mc_bypass(0x300, 0);
>> +#endif
>> +
>> +#if defined(CONFIG_ARCH_LX2160A) || defined(CONFIG_ARCH_LX2162A)
>>       set_icids();
>> +    setup_smmu_mc_bypass(0x4000, 0);
>>   #endif
>>   }
>> diff --git a/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h 
>> b/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h
>> index ca5e33379ba9..bec5355adaed 100644
>> --- a/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h
>> +++ b/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h
>> @@ -190,6 +190,15 @@
>>   #define SCR0_CLIENTPD_MASK        0x00000001
>>   #define SCR0_USFCFG_MASK        0x00000400
>> +#define SMMU_REG_SMR(n)            (SMMU_BASE + 0x800 + ((n) << 2))
>> +#define SMMU_REG_S2CR(n)        (SMMU_BASE + 0xc00 + ((n) << 2))
>> +#define SMMU_SMR_VALID_MASK        0x80000000
>> +#define SMMU_SMR_MASK_MASK        0xffff0000
>> +#define SMMU_SMR_MASK_SHIFT        16
>> +#define SMMU_SMR_ID_MASK        0x0000ffff
>> +#define SMMU_SMR_ID_SHIFT        0
>> +#define SMMU_S2CR_EXIDVALID_VALID_MASK    0x00000400
>> +#define SMMU_S2CR_TYPE_BYPASS_MASK    0x00010000
>>   /* PCIe */
>>   #define CFG_SYS_PCIE1_ADDR            (CONFIG_SYS_IMMR + 0x2400000)
