Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A27CD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 08:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60CE4847C3;
	Thu, 18 Jun 2026 10:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Zimw9mpR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFF6784874; Thu, 18 Jun 2026 10:15:12 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B01198460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 10:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qgvo35CFZWL49wiQVGEhbFEfpmh7t5hLaK4udL0R869REIqC8UeBQyicf834Qz9g04gxlgzfTYo25ltENbVZa8SGsJ3XSzexZqA+aUzqVjOondKUJmrtJrVSPIhnuWg/PeZdrYDBgCQxwq0/uEGCEFiXqNjZOOp77fdLpu5GKOPJVYenUueotphZ6Jz+RjzwBYaVlg6AosuoCseKiadaHXodb+347M2T4hH55LsU27vlExJZyX4Qms1gmgJcCM5FJe933yn/oVpV0jVGge6XjlD8H/v+jevyA2BUEKEZNDeyCOG4DP5meWCj+PqlSofkGK7barfm312TF4nql+CJJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOhmRmmsyTVinlI2LYe7IT9/7xuZlxvZUCxgy73ze18=;
 b=thZz+iolBrZcrUPm848mGtopDbLDXmEwB+yP6DV8Lu7+N1QKSmJJMSLlY9D/VcVFQ/UTyBaV6hNnzmz9kQU1e9nmqjP+CiIB7e00QOCxPdO/xvtRjKPw3wPZcHANgdTdIu1oDMeQAlBvNWwg646qwmcFTen/wHQNvMYAfCPd6vopm/LHR/IAILUwZXtjNmUlvzr1k8auRwffBHfvhsJgJBlTtN2fY94rlvNYwp708mU026r6o960MhQ2PKlYb/SWnmPHHMz2lbpcHvW+hErVKOevHmvzyA6Gua0TSaSGsuoNvT/lAwwhWLwOld574zQfQl22J1hB8383rkAUxSYgQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOhmRmmsyTVinlI2LYe7IT9/7xuZlxvZUCxgy73ze18=;
 b=Zimw9mpRDF3bwJdOcYy/ER/UnOFxmdv0vM+kfIqqHwJQ5afQfOvLOZIEXSeaEsGdgTjoEXaSKOsk6lFOa91/AIqD1pIFq1lHv+wsEnYwy7hNJzuROIWT6bUusUi94MRrnF3l5mntQoHFMeHf0kZLbu4dco+h44gjZLRCeAH4+7wMRZ2hJI1CIARULzF6gfRp+JiGDFMJygVa6S7sLSkjZefgALwOBRb97+YCESeKD22fkxQlgnNK+jriyFykynZZX0VrLq6+EVA1rwJaPzSswu2jNFOHmrtm8Oob11On5ENJAtZ2XC2YZQdRSSQB/AkYrDX+g74IIQjJQjmH+Oq4BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV4PR04MB11969.eurprd04.prod.outlook.com
 (2603:10a6:150:2e7::15) by AM9PR04MB8777.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 08:15:06 +0000
Received: from GV4PR04MB11969.eurprd04.prod.outlook.com
 ([fe80::5985:e1fe:4d87:d892]) by GV4PR04MB11969.eurprd04.prod.outlook.com
 ([fe80::5985:e1fe:4d87:d892%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 08:15:06 +0000
Message-ID: <2313d770-7d1a-4275-b2e3-068df38f2852@oss.nxp.com>
Date: Thu, 18 Jun 2026 16:14:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] imx9: scmi: Fix SPL trampoline buffer for 1GB DDR
To: Francesco Dolcini <francesco@dolcini.it>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Cc: festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com
References: <20260618011749.2871269-1-ye.li@oss.nxp.com>
 <20260618070028.GB18945@francesco-nb>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <20260618070028.GB18945@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::15)
 To GV4PR04MB11969.eurprd04.prod.outlook.com
 (2603:10a6:150:2e7::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV4PR04MB11969:EE_|AM9PR04MB8777:EE_
X-MS-Office365-Filtering-Correlation-Id: 34480b10-281a-4a96-3397-08decd11b47a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|19092799006|1800799024|376014|366016|23010399003|3023799007|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: BOKq+SRE9Y0YvILnV6U8bfWohh3AxOsP7PPYZ99/KpqX9s/4aUUbIoLkNEiNOFmKMR/+UVLJvJqbZtm+A/YDNMSku6MnvGTouhlSTwRzieWospAQdy8cFII9n24kFYcADiiItQgfJOSPD86r0FB6RGbh4jYN7pHmsK/9hrsVmnhqyRbbq8Sb6wM4TuXRwuS+3EBQGZUHou10VuJJ39AsEeqIV06odPELiyVA1F+6A9yu4mr5vqCEioALIO7DX7RefzWq2Hf58wJhEgfAg10YJhXWNKc3HQByCzIt2eFBmuzTk8opYql0RkAjoDvMWf9o+SwvOhlCc/c5Z+qhlOz91wYI0Oh7UFec2wd00fdCGTvadm/56+JRiBjdJr7WL4fa0p3cOJY450p1TCfX7H8SiOIv3AHuylgoP5045FfW9CN+vGai2WrK750AwXO0wJkhmXE3+Hvk0os4GLyIgbkRAFAA1yDsSPNAgQtJgPdPZXPGpLz62MAkUODbKVoEkSzUL/YqPs+bo+HQ6GC3YrIVETadNoHDxgkFnpQ+yaQ1qKkBy0NnHYXIepRF1vf8gHxtwXgLWwgCwqYXA32RpEqYkaaIFd91mcz+OEVuKVwQGwp2yoerGLF8Qe88HyZhXHnVYwzPgU1/dagNR96ovwFwBkFNptLHEDw1vgqD6Bx7Xk898Nxdk77X5oLs8gA1uAsC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV4PR04MB11969.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(19092799006)(1800799024)(376014)(366016)(23010399003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3RweGpzMG9Bekc0eU4zdjBVUC9aRmZUZXB2bmU2dDRqVnp0dVZuUDViYVZy?=
 =?utf-8?B?TXBZMFdsckhZcVc1RjZ5VHY1NUFSZjdoSW4vL05BVDBKVGdXa2dxSkZqSWFn?=
 =?utf-8?B?NWJWbnNSbkk4TEpJR0NrRXlock9PTUNYUDVUTjBPUzBLT213bDNiZTJFdHZk?=
 =?utf-8?B?dmlSNmxoU08rUUNlZXJiWkhGYzZXZnNjN05jSnVzSlIxK0I0QjJ2ekdNOC94?=
 =?utf-8?B?YU9SeWI1QXRETWZqWFNDMU9HUWpYYy9UVkdsKzAvcUdXaGVHaG5qQmFtZFNJ?=
 =?utf-8?B?aDRhUjFtSmlJemRGUW5waEZZejRJeXpvWDFlblo0UDd0VGJaSkpnSS9uUEdm?=
 =?utf-8?B?YkhZc1dydSt3aTVVWU8xYUxUZkhPb3FDQmxBZ3FvcWdQSGlyeFVRTFpzMkVR?=
 =?utf-8?B?VW5CenNFbFlSUXM4ZWRMTDdIRnpQdUx2VnBRT2cwMi9JdnErd25kVWxOdHVo?=
 =?utf-8?B?YXpjMUJsZE9Yc1JJZHdFYmZqS2NUMEpTRXJCZnRFam84bzdCRkpEKzY0SHFT?=
 =?utf-8?B?SGFHeHJNNUxaa1pKcVB4VWlab0VWdGoweHNtMGlBOW91eU9OSjhFbEd2ck53?=
 =?utf-8?B?RXQ1cjNRTCtOV1oxeUo1M1FTRUdRV3pvL0JGalM2OE1LdGVhM0kyNGxrMGFy?=
 =?utf-8?B?a0dPUVdKNEFnUEpnMVk5VWNxdGhIbTlMbEpPT3RpTUR1LzVPdDRUeEZFbkxY?=
 =?utf-8?B?aldxeXFORUhpZ3VFRk1FcTQvZkMyeUlSS0VKcEU5KytuYTZDeXZkR2VhU3hS?=
 =?utf-8?B?cVhHWFBZOUNvN3RMWGpaS2t3a0J1VEJRQStsREcxZ3cxYU5lUVBaeW9BZDk5?=
 =?utf-8?B?RmNTM3JSTkx4NjYrOVJncTEyVlZPa2M1b0VYeXNOWXR3eHBPSXFxTVVabmJO?=
 =?utf-8?B?Wm51YkVzT0R6c010cHdzV3IzQVplQzBvdFdBT1dMN2pRUENLSGhBZ2dlTmIw?=
 =?utf-8?B?WFM5VGRrbVluNkRRZzZ3Rmc0SVJYOEJKYlp4V0hVOG83N2ZFV1d2eldmL01C?=
 =?utf-8?B?OWNCZU9xL1ZFRnBnL0E3L3R1MTBjZ1JlYVJNTkdHM016dFRGTC9zNkY2aXFP?=
 =?utf-8?B?eXI1MnBITDltUkMwbGE5THJnbHUxOUNSWk91QjNKVjQxd1pnK2VhSHJRTHdX?=
 =?utf-8?B?eEFrMEwyVGRHZUREbjRqcHU5R3Flb2ZpVFBBNFpNZklZM092WEtYTzU2UDBL?=
 =?utf-8?B?T0ZRU0IwYVVEK3BselBhakVzb0lEN2VoelRVaEphd2JhcEF6VC9GMjFSWTZ3?=
 =?utf-8?B?RytpSUdBbkRpSXNNaDZJeStPWlQzUGRiaHBYSS9Va1laTGIzallkczFPc1hl?=
 =?utf-8?B?a2ZqVTBpa2dYcHBubUUzODJONEtDWGhTeU9GTmdxaE16QlI3NDVFdEpianVF?=
 =?utf-8?B?MUxyMHZKcmRVRnVNVCtMNHMrejByTXBPN0hiV3lxbUh0d1FVRzBZUldQQnkz?=
 =?utf-8?B?Q1JrVG5OUS9FNXJFQnc1YW5OWlpVVFdIZitLMmZpeE44Q05mY2Vib1BYSjNa?=
 =?utf-8?B?NGhHdXl5V2hGbHRlU3Nad0V4TUc5WThSbzZMV1ZBNnl3MUFuRUpiNVN5dzJU?=
 =?utf-8?B?anFMS1NmU2o0MEYvZnlJdzZ3U0grUGRwTlBJdG5rd25wZDZIOUVmR3JYV0hJ?=
 =?utf-8?B?Y3B5UlBmMG1sY3REVTlZb0ZPYlZiekZveVllNFpJOVkxSElzeHRDRDhzcGh6?=
 =?utf-8?B?SyttdGI5YmNTdmJJNjFMMnpNNkdFR1lpRDZzeFFzVTJIZ3R2VytWWUJhWUtB?=
 =?utf-8?B?S0RNeUZRQ3F2N1lkbytvc1ppbStvMWltNlE4cFRqSDJNTXJoZTJ2MzlrbUdw?=
 =?utf-8?B?OXczYlJtT05EbzZpVVRrRVJETWUxdUp3MHUwQ3UrZVhlYlZ5WnNkMHF2VGp1?=
 =?utf-8?B?SE1yekFVQzM1OU12eFRxSDhaS3p3K3lHcU9yU1ZEMWlzQzVyeFYzNFVhc2Qv?=
 =?utf-8?B?TmQ1cWcxLzBWc2xMem42dk9MWWg3S0RRTW16Vk03SFZwYWVJQlAzVFIxdW5s?=
 =?utf-8?B?VkxkUEpwS29neWMyQ2psc0tTNE5nMEhNOVg5Y2tXekFRZkpVSXBFTUQxWGMr?=
 =?utf-8?B?SnFXZnNVcTBFU1N2RVR3dlNTTWlBbWQxZjNiZnFUdFRuVU9EMEZ4c21sTWdz?=
 =?utf-8?B?TVJ4UDY0bUVxWEpOekxWbUI2cmwxUzVGclZETmlRck5iYk9BYmUyYzdCZThE?=
 =?utf-8?B?UXhlUW1tS2duQ2NIcGlneElMOVVoSkl5VDJHZ0djTVl6ZU45dVh1RUJhcUg2?=
 =?utf-8?B?dTcvVWJjTXJHWnZBanBWWEUrWXlaVGcyOXcxUjZEWjVNdHVMdTNsVzBZcWZY?=
 =?utf-8?Q?3mqg2jEO67t5xxRqhl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34480b10-281a-4a96-3397-08decd11b47a
X-MS-Exchange-CrossTenant-AuthSource: GV4PR04MB11969.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 08:15:06.4058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsxPTthzyAdDiMvtTwrTcq+xJIvkh0ooTtGTfX92O4Zp+O5frnu7hER0GGRoR98/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8777
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



On 6/18/2026 3:00 PM, Francesco Dolcini wrote:
> + Emanuele
> 
> On Thu, Jun 18, 2026 at 09:17:47AM +0800, ye.li@oss.nxp.com wrote:
>> From: Ye Li <ye.li@nxp.com>
>>
>> After supporting get DRAM size from SM, the trampoline buffer address
>> still depends on PHYS_SDRAM_SIZE. If the real DDR size is less than
>> PHYS_SDRAM_SIZE, the trampoline buffer address is invalid and SPL will
>> crash. So use board_phys_sdram_size to get real DDR size to calculate
>> correct address.
>>
>> Fixes: e1cc7117b630 ("imx9: scmi: Get DDR size through SM SCMI API")
>> Signed-off-by: Ye Li <ye.li@nxp.com>
>> ---
>>   arch/arm/mach-imx/imx9/scmi/soc.c | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
>> index 00b8693fbe0..ce86cdf8574 100644
>> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
>> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
>> @@ -1177,10 +1177,11 @@ enum boot_device get_boot_device(void)
>>   
>>   bool arch_check_dst_in_secure(void *start, ulong size)
>>   {
>> -	ulong ns_end = CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE;
>> -#ifdef PHYS_SDRAM_2_SIZE
>> -	ns_end += PHYS_SDRAM_2_SIZE;
>> -#endif
>> +	ulong ns_end;
>> +	phys_size_t dram_size;
>> +
>> +	board_phys_sdram_size(&dram_size);
> 
> Emanuele: does this change has any impact on the memory size detection we have
> implemented in our i.MX95 based boards?
> 
> Peng: board_phys_sdram_size() in board/toradex/verdin-imx95/verdin-imx95.c
> 
It won't have impact on the memory size detection. It uses the output of 
memory size detection for selection correct address for trampoline buffer.
Previously trampoline buffer uses PHYS_SDRAM_SIZE which is defined as 
2GB - 256MB, if the real DDR size detected at runtime is less than 
PHYS_SDRAM_SIZE (for example 1GB), this buffer address is invalid.

Best regards,
Ye Li

> Francesco
> 

