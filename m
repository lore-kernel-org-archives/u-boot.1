Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B6ACD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 04:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C38198467E;
	Thu,  4 Jun 2026 06:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="YMc1oRrH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15064848DC; Thu,  4 Jun 2026 06:18:54 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 094D783314
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 06:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJB59ReF2UW90vYLVdAvAszoQ0BJbY1+ggE8V6gnHyf3sCNilQn0JJigBl29v6f7Ktt2IsSg5X87TBz1RdCNVx7xuv/aD3XuF6dT0KQEalYMVlmMs8m1mO4JQLTASh+v5VKRY7BUAKXL2BRZMaa0lJpezDOtypDuG4PJvfe13G76zpaoP2Hsdt1EGAQcNZf/wjmTlbOPEG1/Ee63EZwclmXU5YF72zrwk57w0QHu78apgfKJEEDxRlV44LmWELHzKsWPfP59/qxZZiKXp0uUk5BYyHbcitHl1fP8Tx7gUYXUxdIOrKaFftQ2w7kV5orfJwcDjrF5M002i2bT41E9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tor0n9Tc8NvDdEp5FXUeBjfqJKHIYCcURmwC6fPBvE=;
 b=ty8k58nrwzSwx812i+tiaWpLK2IvVhQEqNsnXSdz+448h5nv0QCa3TTqze3DkfLp018U+qp+uIFt+83XtkASYxvJw75n8in/wVjUDU8JicB5cr3Y7xjGTqqVM8rGW5SnivmbR5wiFIKiF3LdipBEdt67wfjBcyyZ77yLyjbnXEOyMgaSnpmwf9f1XWtcFDYId3Pn7xnEaMN90v1dSn49pUVhCboLXXxG2KnldvkQke9vIyQI74pUO5PY3RpKtbWv039a3qK/PXk0Efg+xQk33y/YZxEe7R0hk+Mho02jpR/R0UgHb5efVqonw7jKDbg7PhjIXrzFKa/b3/e7cqt9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tor0n9Tc8NvDdEp5FXUeBjfqJKHIYCcURmwC6fPBvE=;
 b=YMc1oRrHRzPpDWehN35YYw62N9Fj9roKVS5bUsYIWX0fbDbmdyiIcrwR/D9oK6MXWRioYQ3koemhWMtQQuUX+u9MfJ5d73zoSJyP0iU+z30F57lh6z1bNUEcezepVhoRk9u10qVZWIKBwySnNlJ8vJOzkSJtlD4Vce93SHj1oFP4Q3LLN6wHK9HnY0HCgLj1ktOKMj2HSX5HC++ubpbYbBJfu52iJCjzPqxSBuj9TSEyD8w2xUsy+np9/5XLN72iWXMdttrndi2zSWGZGSP7Ha3weyueK4VjmAh5bjs0HrGNbTOyFME55ASkoJrR0dbeq2Ae8Md8hX+Q5pFxjnveSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by PH0PR03MB989257.namprd03.prod.outlook.com (2603:10b6:510:3bc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 04:18:49 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 04:18:49 +0000
Message-ID: <540e5004-87ec-4463-9489-47277391d277@altera.com>
Date: Thu, 4 Jun 2026 12:18:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] arm: socfpga: Update Stratix10 SPL data save and
 restore implementation
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
 <20260518011245.19083-5-alif.zakuan.yuslaimi@altera.com>
 <6d1cbe3c-a1cd-404a-b0fe-60567af380e0@altera.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <6d1cbe3c-a1cd-404a-b0fe-60567af380e0@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|PH0PR03MB989257:EE_
X-MS-Office365-Filtering-Correlation-Id: 1719a945-d538-4e25-5252-08dec1f060c2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|55112099003|56012099006|11063799006|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vwhl6upJRQzcT4gLldwE1xih/4sXu6psCiZAN4zv71GtUk9Cwftc/sd0G7udqymPlanCzZ6hoQtcu9TdlKKtNSsFQ8Vnmf8Fgy6mPN6Iftc+r1KOOEvR6VP5msZZ0NbJWbKx7RVhCGha+lwOtHzc0M5vuqfjrNaMIBqXerjVWO8hu9yS31xXCsq4gl9aS9ZIyimJBvwSNjp7o/PiWxLpOpbHt6YVYOmcF37DRzEEejEVrZLttmpKNwj+KK9ZlIBLxfH9qvMGGSsIqevViLA7kLHeE5qNErLsEros3PxQy0irQWQ/cWVoNvN9eklGhd6uy4QSBQHT2EfdNNpdeyE4+ONnh2FOdy82eZAEWLUW6TYJESWUaTM+/eoESHFgw7FEzedS2le4psx62kbcgklMk2wTV3Sg2nTbF5zwwoczLU7bSu+Yyqc58oV23rMH3P5DE8D1Me4f+wSbo29hnVH0BONUuhl8ipSysMBfG3R/RGYXK1Zy64oLBHXPWx6y7zaLtwRBBjCx0fMMClWCAEwe+/Efo1SPaEInEKsghULH9vFlh0cVa2/YQpvjsN+HBm85umSPo+JcIG1IgOoS4+3vw0epgDzrfFXvPI8K2wZGlm1d1IUvHiLOcsS5UTlv7BocVHQxeH5yGrr2OAxatTmBRE032OzdN4Cj8qQK5clePqM5YprDebfvCUT2XAsyyBAm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(55112099003)(56012099006)(11063799006)(4143699003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2xORmFyN1c2cjZoNlV1eWFaYzV6d1ZTWmJhQmFmeUlWc3k0SDVtNVBzSmlr?=
 =?utf-8?B?RUZxaGd4bUl1eGRnQ2ZkaWxXMlQwSElZOGVjblMxQldJSzN1QkhnQVV5K0Jm?=
 =?utf-8?B?R1B0Yk1xeFJRWDlGNDJlTEdMdlFvS1I1S1JvVkM4SE45ZHkwNUtodTRPK2tL?=
 =?utf-8?B?blp1Y0haUmxsc2tTVHdsVHFKQlAvWlIrVGVtMFRKT25mT0tXMkRzQS9ZVm8v?=
 =?utf-8?B?VEx1anZyRHlFblplZXQ4YWV4Q2Rob0VlWDV5ZjBoRWQrc3NIQTNhNER1VWdq?=
 =?utf-8?B?QmdDSG84L1lCbWJ1dWZwUm44NzgySnl3KytZS2EyQjFiaC9ZSmxwVWs1cGZK?=
 =?utf-8?B?ZGlCeHhaM2Jsb3pyd0lWNkU5akRobm1qb21uTVhZZHVGRzU4cDQwbFo2S2p1?=
 =?utf-8?B?dmJINHo0ek9VY0tjaHNqcjVlMFZGMHBhbEtDbC9XMW9ldFpNeHJ2LzJiL2lR?=
 =?utf-8?B?aXc4Z3hQVHc0eUYvRXpFN2dHUGxxNmF0bzVxb3dDWFdDOERubVdwYkdRaWVR?=
 =?utf-8?B?ckNDZFNBejFYdUJWVkdHeGN4SFVqOUxDUG5iL0hVcE50UVVUSzBBdVMzb053?=
 =?utf-8?B?d0RvWUFOTG8vMFREVjI1TFhXbzFyME9NTmJSem5Qd3JwNmFyYU5CN20ycHVW?=
 =?utf-8?B?RmF2ZG8zYlpydVNQME9iS2p5eXRHV1dNRGtHZm4yOForaWMzOXJNc3pFQUZ6?=
 =?utf-8?B?bzdwRUdxVlRPYWRhZ2I2UC9MUWdwZklRNlprcjR3UnJ6QmgwQjBONUhpUGph?=
 =?utf-8?B?SStRS285SThBTDNnbEJNR3lYRG9FaTUxbWRzZ0UyS0IvRjhYUnAwenptMjVR?=
 =?utf-8?B?MndQMVNPZFE4ZGJzbmlvRDhXSUlmTDUvMDFvOGx5elpEaVZoUkIzSDFTU0Ur?=
 =?utf-8?B?ck90RjNXZ3NyZkVGUGU2ZGRJRHhVUXJ0cDFTWHVTK0diZmFDbW11c0k4OXN3?=
 =?utf-8?B?NlhLdjMyc3VzcEZWWUl2cmtmRUN0SjVDTmpWZ0xXVFlHdjU5THBNNThPS3l3?=
 =?utf-8?B?VEd6R2t2R2hjOUlnOGRPcTN4Uk5kYmIwRGREL2dlNDJOWTQ2ZWR5SFlaKzMv?=
 =?utf-8?B?Ykt2QUM3TDhTV0JCTHQyVm9vcTRVZnFYdkJiT3Z2cytsQ2k0blJkemI1MnBx?=
 =?utf-8?B?WXYrOWpZVjJSbSthd2dKZzdNaHg4dVFRbTJBTytJQ3hGa1F6WkdOdkZ2KzFK?=
 =?utf-8?B?dG43T3o5cjY2QjJPdlN6SHJOazlLN01RL3ZkV1pMVkgzTU0wMVltRmRzUDJ4?=
 =?utf-8?B?Y0NHejJ3bThyRHQ2aDR3ajNiOTVDcnVsdHpPc0Q3NnBidHllRHhTWktHMGta?=
 =?utf-8?B?cU1KNUxDVlpWMHpPMkZCNVkwNHJVbnRvc2JPN3Y5c01Ldk1yYjBSdW1NeHR6?=
 =?utf-8?B?L1NiZ3V6a0FFK3lzMUVoQkJSWDlQbCtVbXBlUU1RMFJwQzRhRzFOdFdxZldv?=
 =?utf-8?B?RjJKSGs4L3BQcjdTZjdlMXJGU2p2U2ZwTHYwTU5MNlEyVEY1NVpXYlJTbnZt?=
 =?utf-8?B?RGdwaWUvSTdEbERxN1NQZGovQ014ejNvaE8zNVNWcUNkS0tDUXhlVlk0cW5z?=
 =?utf-8?B?OHQ5Q3JnOG42RHAvQTdWWVRpVzU2bjVlTjhER2xHanlMMVJWTFRUM0dPbno5?=
 =?utf-8?B?MW80ZVdnblVyQW5XRm9qREU3clQ5UFBLbktlUkt1VGtiaUUvK3FDajdxeVR2?=
 =?utf-8?B?UGhWU3c3V1Vpa2RRbG51aUI3NWRKQzR2aDFkMWg0YWNabytvZThmSXB4QmV5?=
 =?utf-8?B?aHZkL0QrTjh1OWhXMmxZUkEzOTVOSXV6WTg1ZXdzOUFkcWZraTN0czhWWjVW?=
 =?utf-8?B?aXFnbkZkdkQxbDcxM2JhUFNvdmlvcktmTTR5UmhQMWphZTA1dVFGOW80RG8r?=
 =?utf-8?B?K1p6b0dyR1pGa1FBSmgrQ3hpYUNNRXkrTFpzQ1NyRFQyeVdlN2xEMzJoL2Jk?=
 =?utf-8?B?ak5KS1k3WVk2bWc0bElMcTF3ZXlZSisyVjdscm03WUVDcm5CaGo2ZU1VZkZM?=
 =?utf-8?B?TTN3S3g5ZXlqTHd2WjVGaFV1Zm5CT1pObXFNSkM3dDNVOHlDMmlhUXp0ekZJ?=
 =?utf-8?B?MCtUOWtUaDV4Q3VoQmxFbGNTaHNScWIrdExCS1BBTnJ2MEFibzhyWU9HK3du?=
 =?utf-8?B?TTV5OFVMRzIrbDF2QldxZ05yK1FSUVlVOC9yS0FQN0krRTlGNFNMOVpQTytE?=
 =?utf-8?B?eWVObG8rb20xMVZzaG9NejVUYVp6c0tSSXg4RjZFcEswY09nMjRuaTZiTWlh?=
 =?utf-8?B?eTRQd0NrNFZGaGZvWXdkRWJFYlZ0bHIxY1JwMmMxSjNCb2RKM3FlVmdkOHpr?=
 =?utf-8?B?UTFTK004V3N3cnZLd1c2cW05RkZGeThWc2V0REg5K25oaVlFQnNsb2hjNTdS?=
 =?utf-8?Q?wUfzfhdDR40ydMLBPQMf4V3zQOBOAKsDyOK8s?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1719a945-d538-4e25-5252-08dec1f060c2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 04:18:49.6043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytjkHc8oQyNfNof0WniiVSeoBVm73/13HwVuGOWQtFQZQ+51LZnlLvJy8sgtkxfco1A1G29PzA96gYQUQicr68RW4YEEBjvw1SCqoT7+h8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989257
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

Hi Tien Fong,

On 3/6/2026 3:17 pm, Chee, Tien Fong wrote:
> Hi Alif,
> 
> 
> On 18/5/2026 9:12 am, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> Enable backup for data section to support warm reset in Stratix10 SPL as
>> no SPL image would be reloaded in warm reset.
>>
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>> ---
>>
>> (no changes since v1)
>>
>>   arch/arm/mach-socfpga/spl_s10.c     | 17 +++++++++++++++++
>>   configs/socfpga_stratix10_defconfig |  2 +-
>>   2 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/ 
>> spl_s10.c
>> index 8ab80740c6e..ce1d5d4c8ff 100644
>> --- a/arch/arm/mach-socfpga/spl_s10.c
>> +++ b/arch/arm/mach-socfpga/spl_s10.c
>> @@ -21,12 +21,29 @@
>>   #include <watchdog.h>
>>   #include <dm/uclass.h>
>> +u32 reset_flag(void)
> 
> 
> spl_save_restore_data() calls reset_flag(cold_reboot_flag). S10 defines 
> reset_flag(void), which is not a proper override of the weak 
> reset_flag(u32 flag) and may break under strict prototypes. Logic 
> matches Agilex5 (0 = warm → restore, 1 = cold → save); only the 
> signature needs fixing.
> 

Thanks for pointing this out, I will fix this in v4.

Regards,
Alif

> 
> Best regards,
> 
> Tien Fong
> 

