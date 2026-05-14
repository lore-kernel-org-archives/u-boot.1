Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2677CD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 05:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F3E080F0E;
	Thu, 14 May 2026 07:35:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="atl2p7W6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23ACA839D9; Thu, 14 May 2026 07:35:51 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A49FA8056B
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 07:35:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DICxEHkCRNCLj1bczjRZFrbNP8pciJcappgt31it3GXsOjLLQFBrqPDUBTn/88rhe6VCu5F+YM6IP0dx6hIjLcXtHQTh3/bCZWG56efTBkq1q+75hc1Nq7daNtdDMtfxX07Ybx6C+X+p89RUAyWScx0bFey6QPWco9Qnzt78VWnqHoNMJAUgnBCOlJabV2OyN+L8+G4pGbSFadi7KjIiTkXnLR4t8RSrSGjNJVfuUbDVXds6xEfOseTmYCVYH4Fy176u9T8b/6L7M51nUDBu5xXemNLYvpLvEr4S2R2qG3wQdrD1QTNAg4PXD9PcdirHl2IMEcoDmqGmDMAwnOMBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFcg3Vv+zWr73jgm6MyXS+cSrVy9dc8xtNNckaskms4=;
 b=k+RbGIEVXDJuFn/j9n4RMdDk86CAV0sMS5087PBTfW+T5VLak3Tuo25Jt11RXMCfEqYu9uNrIHvZTuQ0anPNVoTRJoWOgNXqpU+qhE3vfx1Lpmquqw94v8z6CoQ9fvjz4XYx4L57Ch/kutxjJXiikm/BZNkVJEdUQr9i0DTq8nDQ09N3Br2HGCYUwtYs972V65wbrdRKMojzW+4B1OlvKgWHSIt/fMNKm2Pnanp68qUyavl86mijzugT1KVSYssARUzoGEacYln0+kHhwY0kUZ2yPvDZlh2Jetf37boKVwEA1Dayhhv86S/AXIQeZnQpX/yMKY6e63jssg5R5hzyNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFcg3Vv+zWr73jgm6MyXS+cSrVy9dc8xtNNckaskms4=;
 b=atl2p7W6aiWLeBZGh6LPFa8DhKvsPEwvpmW4/2FJvRVkj/LsLpFRKPYHSwkIM5eYmJvv//Nhxlr+haUm7EPBV2iP7/JUZN55e0FFrqdvdH8z9AbsX4kb4ZHootBflVrABpSfIHXaHCH4o3AMCMs08XkDCIUVpk0BVXyqJ7Qysdt7f2Ujo2pzl+mwLL/8xk1NX7IQNkLqwMepchvxj3t7WKuUuWbzeOH5yD77Li4C3P8zGiH8CkE5hSnSK46k0wja3WXDs0m6dc//ZZT0zFHEgxSA8KVAs1lksoM3sFOYDpDuPjNUl3Iy4k37678li1gD1RmAE/DVIBVqm43hEHKzmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DM4PR03MB6160.namprd03.prod.outlook.com (2603:10b6:5:39c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 05:35:44 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 05:35:44 +0000
Message-ID: <5ea9a521-a27e-49c1-8963-d4e3ff9d8dca@altera.com>
Date: Thu, 14 May 2026 13:35:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] arch: arm: dts: stratix10: Switch to using
 upstream Linux DT config
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
 <20260428034822.23756-2-alif.zakuan.yuslaimi@altera.com>
 <cde9444b-1f01-4932-be46-d751e347379c@altera.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <cde9444b-1f01-4932-be46-d751e347379c@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DM4PR03MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba10c52-723d-4beb-87b2-08deb17aa4b7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|55112099003|4143699003|13003099007|56012099003|18002099003|22082099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: JJq85f645a+GPvHig69vA7Y52RyqALsbXyLust4hVgYcL9KeFgF+Jgc1pq+q1e5+JOJsc/GN+G6+wzvFsnR3Arhm8ADO3OAxKcRJkg//SfV/okn98GAcQHdWF1+PQHZiemT8kpgD4eiIxqEROS9K6umJT0K4fuSDT+H7z4av9alho4z16kppXqkys7oLLDxD05s4RBxUpjWocTky/JEzsYnHovZ7tXPPJc6z+Pe728SsZzrXyKleGCqTJLY5Fp+9fqFcKZaIhamT1kMVsVC7kfAG3fmX1H6KWF6dXjbYemN8jD+xBsyLTKQau/h8dvZEGHTnrNl51cxWXnIVmOtgjJ9FymtGIIySneXtV/tsz+KNRStmD79otjq4bTewcvkW807ITf7YM7oMijIOy/2hjTBY/VTY9bMSRJdnyReupblA3Wugr22qlf08iyJIY7IUWGnRr+yGqqolInG1XStAoQ9LoaZSeckb4g5DkR5UFvIUCqEm7jcmPu3GvTWrmtlYJdwdGVsRsGV4uu/C/9ysUPRvshPSD0IOooSnF8Br9Ia2VGo9GvBvAdvvARc9a0qpo86UATPMpHzcGvPvnTCRv4/VMKmrHeh6PtLklMyES78ytfy2KWezLV32WuegRFqT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(55112099003)(4143699003)(13003099007)(56012099003)(18002099003)(22082099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VldJc2EwWEJBcVVIT1VENXlGbTBNWkpaU3J5WXA2dWJqU3VjK1NtUlM5aFZr?=
 =?utf-8?B?SndRUTJFUVl2VC9qcllwVTFiZEtQZ0JwSk0rL3JGVnRGZnhmYWlUM1hZWkE2?=
 =?utf-8?B?RkcvSjViUkpDVm5ITkJxZlloZHgrbzM5OEtBemtrOFh5SWJYa25qalF0dVVn?=
 =?utf-8?B?ODNwZFZvb2pNNGJrYVdhblQ1RUN1UWFXZUNUZWdWeDVDNEV4UlAvM2RYSXM5?=
 =?utf-8?B?cTV6Yi9oejJ1dGxqODlPUUVhNGJWUGVWbVdXNkhUNmZnRVlHU0tDdGZTR2I0?=
 =?utf-8?B?ZXMvYjNhdkM5eHBnUHIrQXE3aWkwMEx3WFJEVS9HVlRkbjBMbU9yMUFXUGhy?=
 =?utf-8?B?NFdUb0daczVlSVM0YnMrcGRLR091dk93WDgrVVpMYSt6czhORUpsUXpBWVFz?=
 =?utf-8?B?ZVRKRldPMVR0SUNsMHUzQTFrWUxXcVhaRjRqNi9jd1d5dENlNk12YURPM0lR?=
 =?utf-8?B?cXlLQ1B5L1UyelBUdGpGYzlpWkMvWHZMM1lvTUhpUjZUMzJ6RFpPYnkyZmZu?=
 =?utf-8?B?Z3JvSDFJNXFQZGRwL2V1WUlmUEhpeExvUzExc01YTE1xeXB6RWFFanYxbVcr?=
 =?utf-8?B?SEtITWREeTJFdURZQTJQUzZacmRITnpLdmFDclNGckppSTZ4U0puWXpaNU4w?=
 =?utf-8?B?RUVJTWNzYjFaTHl4WndqWDJlb003K1NKQUxwUGxSZ2d2cDVDdnJyMFIyQlN3?=
 =?utf-8?B?M0NuTGowK3FYczNPZ2w4OTQ5LzJsUFZFRGQ3MGRnYzdJUzl1ZHhFZk9aWjNu?=
 =?utf-8?B?NXRNZFYxQlRqWUR5ZzVWaHdxeHNub0dTdURhd2Q4Z3BpenNjZkNxQ1ZGWWVt?=
 =?utf-8?B?Z1FZanhXa1l3bittYkNORnIrSEVVdUV3SHdSc2hzRlF0bkI3NHdzWEppenJl?=
 =?utf-8?B?RTdaY3hQUk5wQkVnektvL0NoU2dyNVJlVGU0dGVaem9MeThTa1VKQ2crYkQw?=
 =?utf-8?B?c3FReG1KZVVlZG5JeC9BT2pBOUV1WWlpVDJQQmpGdElwdzE0alBYM1NZblZw?=
 =?utf-8?B?YWZXT3JqWDQrNk5XNFJJNjMxL0JLY2h1Y25nYmZBampnQkNKZ3E0OWp5cm03?=
 =?utf-8?B?bGViZ0VTMWJtbm8rTGdQOUQwY2xsdWFnZEVxRSt3WjBMRHZuRkliN3RVTjk2?=
 =?utf-8?B?eHduTUZzaXJibXM3NFpnMHpXbFdrUXhPQ3FObjNKSWpBTCtmWUtrVFRpVG1K?=
 =?utf-8?B?aEc5MVc2eHpkWE9EYmhSdEk5T0Vqc3RpWHNYMUhybDVOLzNpdDJCeW42NjVp?=
 =?utf-8?B?Y3dHNG4yODh4eXZBeDZFZEx2Yjdld1FNOENmbzhnSklWUWNCckdNRjRlbzVu?=
 =?utf-8?B?MVZydUtDZEJQRExIb20wcTZNWlFLQTliaTNaUkpkTUVPeEVBTUltekw1Sjlj?=
 =?utf-8?B?UkRuWUJjNXM5YTlVdUpKRVlDZE0xQU4xZTNtY1JjN1MzOFA3dVpxVUZBZldx?=
 =?utf-8?B?b0VGQVJxcndoUzJ4d0o1NVY1bDRNZC81TkRSQzFyaE0xZ0Q2bDZHalNBSXlr?=
 =?utf-8?B?M0taTi82T2ZYRzNrbDIxckhmaDZqd2FxSjB2cTZPVFM1enROY25CZ20yaWxp?=
 =?utf-8?B?ak9ieHdzV0hUaC84U0djU1BFWTc0c3VENVRkbHRoZzhULzBlbStKVmQvNHVZ?=
 =?utf-8?B?V3VMZjhod2s1MVFXVGg4a0ZQaTYvWU5MUnpXK3RDOTdzL213N3Q5cG5MdVIw?=
 =?utf-8?B?N2dWS0wwRlVkSlVud2EyV0tubFNuZ2ZoczVidklnUUxNODdVb0NkQkNRblRL?=
 =?utf-8?B?ci9tSS9wRmFJcjgzTTFTUElNVC9NN3o5WVlTR1BNeit3RmE0bzhmMGhTeEFx?=
 =?utf-8?B?RXNidzBnaEhPdEwxMHVCbmozSU1JQVljTlhjNTNBMDNsZkF5Y0hEZXVCRlV5?=
 =?utf-8?B?djJUZU84T25GNXFRa2RmMnpFSGhKRnQwYlZhZS9iajRvblRLUURrSVo4VGFP?=
 =?utf-8?B?Z1Q1NkRNS1ExSFYvSXFZRm1KbWtvd205SkJDUkd0cjI2TnRPOFJtSCt3RU5h?=
 =?utf-8?B?TERzTjJmVUFlSzFENi9wTjRpdnhaSmVYeXlRSldWNmQ2REhvQVV5SHNWazdn?=
 =?utf-8?B?ZzI0Z3U4NUJNemRBKy96TjhwaEsxMlpxRDhDbVRvUzh3RXVSMlBzcWhiZm1W?=
 =?utf-8?B?TS91alFNZ1o1cjZ6ejFZa28wSHIxOEd0Sy9ONzl3cXA0akN4VDF4cWJsL1ZY?=
 =?utf-8?B?cGRYM0JHdWZNR2FQVDBwZzJ5WnhtMW9CamxJY1hyUkE4ZnlKOU82ckdxY2Uv?=
 =?utf-8?B?THFVVDBMSGxOYk9neXI1OGtkU3lSM2pOVWQvcEVtbFdvN1hHZjVVeDJORHRF?=
 =?utf-8?B?WmQwVjFYbEllTWNQUFhJdWJ2UEd0QkFKczM0dzBDdS9YOEUvZ1JlWi9XeWQ1?=
 =?utf-8?Q?4Wje6PZyI/GMCf4Ib/X2A9cgBzzF4EkWY2zzg?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba10c52-723d-4beb-87b2-08deb17aa4b7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 05:35:44.4311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkYItKlqHjvKl6UiC+Tt5N7ZuZ7Ip8SCgPMsoecvLSNAZ5AXIJPSawcrhceF41j6IzWOSEeMWwR0gpfWW1KLqKMLftoklJoosaqELNAa4Yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6160
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

On 7/5/2026 4:37 pm, Chee, Tien Fong wrote:
> Hi Alif,
> 
> 
> On 28/4/2026 11:48 am, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> Migrate the legacy Stratix10 platform to use the upstream Linux device 
>> tree
>> configuration. This helps reduce maintenance overhead and aligns U-Boot
>> with the Linux kernel's DTS hierarchy and naming conventions.
>>
>> This change improves consistency between U-Boot and Linux by removing
>> custom/legacy DTS handling and instead relying on the standardized
>> definitions provided by the upstream Linux DTS.
>>
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>> ---
> 
> 
> Please add the change log for each version.
> 
> 
Noted, I will add change log for related patches in v3.

>>   arch/arm/dts/Makefile                         |   3 +-
>>   arch/arm/dts/socfpga_stratix10-u-boot.dtsi    | 158 +++++++
>>   arch/arm/dts/socfpga_stratix10.dtsi           | 430 ------------------
>>   .../dts/socfpga_stratix10_socdk-u-boot.dtsi   | 143 +++++-
>>   arch/arm/dts/socfpga_stratix10_socdk.dts      | 143 ------
>>   configs/socfpga_stratix10_defconfig           |   3 +-
>>   6 files changed, 286 insertions(+), 594 deletions(-)
>>   delete mode 100644 arch/arm/dts/socfpga_stratix10.dtsi
>>   delete mode 100644 arch/arm/dts/socfpga_stratix10_socdk.dts
>>
>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>> index bff341d6118..2832123218f 100644
>> --- a/arch/arm/dts/Makefile
>> +++ b/arch/arm/dts/Makefile
>> @@ -460,8 +460,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=                \
>>       socfpga_cyclone5_vining_fpga.dtb        \
>>       socfpga_cyclone5_ac501soc.dtb            \
>>       socfpga_cyclone5_ac550soc.dtb            \
>> -    socfpga_n5x_socdk.dtb                \
>> -    socfpga_stratix10_socdk.dtb
>> +    socfpga_n5x_socdk.dtb
>>   dtb-$(CONFIG_TARGET_DRA7XX_EVM) += dra72-evm.dtb dra7-evm.dtb    \
>>       dra72-evm-revc.dtb dra71-evm.dtb dra76-evm.dtb
>> diff --git a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi b/arch/arm/ 
>> dts/socfpga_stratix10-u-boot.dtsi
>> index 3e3a3780469..a3b4c0564f9 100644
>> --- a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
>> +++ b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
>> @@ -3,6 +3,164 @@
>>    * U-Boot additions
>>    *
>>    * Copyright (C) 2020 Intel Corporation <www.intel.com>
>> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
>>    */
>>   #include "socfpga_soc64_fit-u-boot.dtsi"
>> +
>> +/{
>> +    aliases {
>> +        spi0 = &qspi;
>> +        i2c0 = &i2c1;
>> +        freeze_br0 = &freeze_controller;
>> +    };
>> +
>> +    memory@0 {
>> +        device_type = "memory";
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
> 
> 
> make dtbs_check (Linux dt-validate) will flag it as a schema violation 
> since memory nodes must not define #address-cells / #size-cells because 
> no child node according to the dt spec.
> 
> Remove both properties from the memory@0
> 
> [...]
> 
> 
Removing these properties will result in boot failure in SPL during DDR 
init.

fdtdec_decode_ram_size() in lib/fdtdec.c applied #cells to the wrong DT 
node, triggering libfdt’s default #size-cells = 1, which misparses reg 
encoded for #size-cells = <2> which is the way to describe 64-bit 
physical addresses and sizes ≥ 4 GiB for Stratix10.

Refer commit - 90c08fa038451d6d7b7d8711bfd829b61d64c490

>> diff --git a/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi b/arch/ 
>> arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
>> index ef0df769762..da19943ec3b 100644
>> --- a/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
>> +++ b/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
>> @@ -3,47 +3,154 @@
>>    * U-Boot additions
>>    *
>>    * Copyright (C) 2019-2022 Intel Corporation <www.intel.com>
>> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
>>    */
>>   #include "socfpga_stratix10-u-boot.dtsi"
>>   /{
>> -    aliases {
>> -        spi0 = &qspi;
>> -        freeze_br0 = &freeze_controller;
>> +    chosen {
>> +        stdout-path = "serial0:115200n8";
>> +        u-boot,spl-boot-order = &mmc,&flash0,&nand;
>>       };
>> -    soc {
>> -        freeze_controller: freeze_controller@f9000450 {
>> -            compatible = "altr,freeze-bridge-controller";
>> -            reg = <0xf9000450 0x00000010>;
>> -            status = "disabled";
>> +    memory@0 {
>> +        /* 4GB */
>> +        reg = <0 0x00000000 0 0x80000000>,
>> +              <1 0x80000000 0 0x80000000>;
>> +    };
>> +};
>> +
>> +&qspi {
>> +    status = "okay";
>> +};
>> +
>> +&gmac0 {
>> +    mdio0 {
>> +        ethernet_phy0: ethernet-phy@0 {
>> +            reg = <4>;
>> +            txd0-skew-ps = <0>; /* -420ps */
>> +            txd1-skew-ps = <0>; /* -420ps */
>> +            txd2-skew-ps = <0>; /* -420ps */
>> +            txd3-skew-ps = <0>; /* -420ps */
>> +            rxd0-skew-ps = <420>; /* 0ps */
>> +            rxd1-skew-ps = <420>; /* 0ps */
>> +            rxd2-skew-ps = <420>; /* 0ps */
>> +            rxd3-skew-ps = <420>; /* 0ps */
>> +            txen-skew-ps = <0>; /* -420ps */
>> +            txc-skew-ps = <900>; /* 0ps */
>> +            rxdv-skew-ps = <420>; /* 0ps */
>> +            rxc-skew-ps = <1680>; /* 780ps */
>>           };
>>       };
>>   };
>> -&clkmgr {
>> +&mmc {
>> +    drvsel = <3>;
>> +    smplsel = <2>;
>>       bootph-all;
>>   };
>>   &qspi {
>> -    status = "okay";
>> -    bootph-all;
>> +    /delete-property/ clocks;
>>   };
>>   &flash0 {
>> -    compatible = "jedec,spi-nor";
>> -    spi-max-frequency = <100000000>;
>> +    reg = <0>;
>>       spi-tx-bus-width = <4>;
>>       spi-rx-bus-width = <4>;
>>       bootph-all;
>> +
>> +    m25p,fast-read;
>> +    cdns,page-size = <256>;
>> +    cdns,block-size = <16>;
>> +    cdns,tshsl-ns = <50>;
>> +    cdns,tsd2d-ns = <50>;
>> +    cdns,tchsh-ns = <4>;
>> +    cdns,tslch-ns = <4>;
>> +    /delete-property/ cdns,read-delay;
>> +
>> +    partitions {
>> +        compatible = "fixed-partitions";
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +
>> +        qspi_boot: partition@0 {
>> +            label = "u-boot";
>> +            reg = <0x0 0x04200000>;
>> +        };
>> +
>> +        root: partition@4200000 {
>> +            label = "root";
>> +            reg = <0x04200000 0x0BE00000>;
>> +        };
>> +    };
>>   };
>> -&sysmgr {
>> -    bootph-all;
>> +&fdt_0_blob {
>> +    filename = "dts/upstream/src/arm64/altera/ 
>> socfpga_stratix10_socdk.dtb";
>>   };
>> -&watchdog0 {
>> -    status = "okay";
>> -    bootph-all;
>> +&images {
>> +    fdt-1 {
>> +        description = "socfpga_socdk_nand";
>> +        type = "flat_dt";
>> +        compression = "none";
>> +        fdt_1_blob: blob-ext {
>> +            filename = "dts/upstream/src/arm64/altera/ 
>> socfpga_stratix10_socdk_nand.dtb";
>> +        };
>> +        hash {
>> +            algo = "crc32";
>> +        };
>> +    };
>> +
>> +    fdt-2 {
>> +        description = "socfpga_socdk_emmc";
>> +        type = "flat_dt";
>> +        compression = "none";
>> +        fdt_2_blob: blob-ext {
>> +            filename = "dts/upstream/src/arm64/altera/ 
>> socfpga_stratix10_socdk_emmc.dtb";
> 
> 
> This file is absent. Binman references dts/upstream/src/arm64/altera/ 
> socfpga_stratix10_socdk_emmc.dtb.
> 
> If those source DTS files do not exist in the upstream tree, binman 
> fails with a file-not-found error at image build time
> 
> 
> Best regards,
> 
> Tien Fong
> 

