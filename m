Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC927FA0C22
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 04:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94F3484129;
	Wed, 15 Apr 2026 06:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="foKO+Ape";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E57283B99; Wed, 15 Apr 2026 05:37:14 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE4E380086
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 05:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhsUm0MFFHaC+q3UVRG5vayYYy6CcAwd/yEkmuswebg//QgXJS+UmKwBXom099At/xUgmsdwAQMEeGklYODL5zYT1+T6rmdG/XPM4o64M1ULJXpCMgAlYgVSyezQ7Mfg8OsfJMd7eI6GqFlYh/hgHvAaiFQmj71fJ50hVnojUIZGe4E6aFJTN+F4mFGTAnRH2LwgnxSDmT1vrphsAVXtTrSVKPeLGCOJYSWwLLjOyvsaxFk91i0Uggpd6zGJ66phR7A3ITzby6ppZQBDBKh+zNPlYX82DIy3ew2a+saOiqXEX8ahKeXtI03qpdDwpEwiPg5U/ox9PtiBdWs98VfEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svdes5SC6izOgrUU4OThHdlABVjHdtfilOlN7tTEZyA=;
 b=S6W9jV/kEnUjpYmFlkLAefX8uGXjzrsvjvZPIre+t4ezr0uijOqBbgAgf3kp47qA+Mw7uJQP7nALI7/VsIJI1I8l1j4rqN5RuhpCFBqIgYFWhsqqZ5r2NhiEcnwyO0ODkt8Uq9gp8uwyCK9/uN+KNlWexBvBXP0hKUlgFRn3h1F/xHYcD4B679E1dugPBIlH2ooJkM+Rcwnps09EOnb9iDoOM287vtFfYz5nMK+zDqVbtZsY6Zbj231plrqB65qh33JQhcq6MCY1nFQ7l/ThrdkkJrYcFMWuhWDTbLL7mx2vI3fkR9/qquThC4RnIoNGGXG3CAnTa/R1+emU7M/UhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svdes5SC6izOgrUU4OThHdlABVjHdtfilOlN7tTEZyA=;
 b=foKO+ApeqbweWdKMpohgF6xu74SiHc7NAPdBXnOjpAcDd5GgJK38zR9DfIXz307TUpS/R0upXiTan4f6FlbGKQ9hK50k9wP7uu4EWsOpGssly54R9JdnXvC0zpu44zd/hqbnKyD5qNMQYJ4Au7gi0OEecNP4KrtOKAS3tMMaLmHWdbar60+05VeAj/hJjrJm8L18HzETmoiPUZI3AcBUgiAueQUPZv2Rjmd9v6f1hbi0PWfFpE7H/4Ch3Rb2RhcbBQI9XQQKP/1+jFS3eWxe0TTERvDZIwQvpBQhNrAdipiQy+qzibcBVKmzcY4i+QX+Taya/Pm90U+8J4emMyuJMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by DS7PR03MB5400.namprd03.prod.outlook.com (2603:10b6:5:2cc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 03:37:06 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 03:36:57 +0000
Message-ID: <f457c2ec-708e-47ac-b5aa-4ee1296b9396@altera.com>
Date: Wed, 15 Apr 2026 11:36:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mtd: spi-nor-ids: Add support for IS25WP01GG SPI NOR
 flash
To: u-boot@lists.denx.de
Cc: Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260318025905.13304-1-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Lok, Chen Huei" <chen.huei.lok@altera.com>
In-Reply-To: <20260318025905.13304-1-chen.huei.lok@altera.com>
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|DS7PR03MB5400:EE_
X-MS-Office365-Filtering-Correlation-Id: f9c7c613-3e23-46cf-f62a-08de9aa03ee5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|22082099003|18002099003|55112099003|13003099007|56012099003;
X-Microsoft-Antispam-Message-Info: xU4CCE1VC/7pMs6wpCtojcCmrlVc74SsLscepf599BnTsWgLIPvE2hIuRrORzU6Y/rWBSrNTPkK2fwfatSsOjMNHO3bB4JW3DGjK/shxeGVG9YwV46aLTtNE+naUJx5RnKRlibU0Mg9mimHNOJWhT+BUE3j7wnkq7zs3S7U2k0sF+BLwCuJdkzmsmMxpFz9Oixk91YR84rSHyzy7ERTwh+ByCoXxm50bnRGZMaFG3sPdMgLgdXCBVHPSqbBQ0nHHvCH3JRyUzFTkajyAkUpD8aigoiHq6hiMv8xkSqSyeFmzksPFGdg0GdzTyqb3053WVHLJRS+1J9K7uLIFXjoaphgKxX8Bidq3lWs3UNZHPrsZaxq/ETEAbFMVVS2/PD5BIkwMoskPUc5WG4q/fMvBmYarzMaDL2qKzJvXLlon1sjOBtbd2jwquAh0mDJnD5tjJG7cKkmqX6PJa43SsuLjJlAVA+En4DeApuhso8eORmDVdtEqQXx0rvssiH3LBYAlcS64Zfb8s2gZYHLIjJ3PlusG6heOsKH5x5caCSzPFpEzzSzqNCjBqnESorZTghl6nEdmAW3M4TLdiiAvD+obFtIEwI27CdXg9ZYm+wX8MsOOAym7eBHYGipSuMt+MnoIZz+lBQhxElmYqeWkUtKMKhKvexqs47b1xIqTWNyFaRLLc6ZJDNDzmGsSGHtlI74s
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(22082099003)(18002099003)(55112099003)(13003099007)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0puSWQ0NnlaTExxZ0YrajQ1dlZNNm16WUVtV256cWhsS1BpMzV0eWc0QWlR?=
 =?utf-8?B?SU51ckdsalQvNG9oOEZMWXRVRFNsMmxHU0xnMkxUTEdtaWh0MEppTks3eWQv?=
 =?utf-8?B?Tms3OW9sK2UrRnBoWFNZSEEveno3MnNWRnBSZE04MFpQUU9sWGlCNnVKQWtv?=
 =?utf-8?B?bFcwekYyTjFRZlQrcm03V1JRSWF1UHdnWlYxMGR1ZGJ1Mlg3bnpmVkViWDhw?=
 =?utf-8?B?c0s1Sm1JWjlGYWR6YnJpRTZ2di95SzU0M3oxQXRGQXFRQS82TVBTVE0rdWNK?=
 =?utf-8?B?bHpnc1BzZzg1UFFjNEk4N2Z0Z0lBNE5aa1V3RXNadTI1Q2NaVExSUXBST1dX?=
 =?utf-8?B?R3d2TllBUUxOVEZ1YnRsc1dzN2lXZndUdnRDa2tKc1FUaHo0TG92WWhKVGd5?=
 =?utf-8?B?OGhoWXFrN1d4MHNmMlB0S0tEQ3J3d2diWEhkL0JqREhWWE92VVZzUkpYTkZH?=
 =?utf-8?B?TXZodTlwamZLSngwMHcwMHlJYy9LMVg5TlVoMmhzL2Q2Z08xcmIyVklSMVdF?=
 =?utf-8?B?b0xqWnhuQjUvdnUyQTRacnF1dUVWVHcvcEdaMFpuTjlEaWQ5bWsveGpDcFp5?=
 =?utf-8?B?OGxiQUpPWVp2aDVTR2pQY0dUTitqaUhNZmxZVnFuYmprVTRCWHVXdkRQZ1JZ?=
 =?utf-8?B?RFQ4aExtSG5ON3M3Z0FZVmFUVVpUY3NZZlJvU0Yza3FWc2pyMjJIUEVyQURM?=
 =?utf-8?B?WE9BN1dMcTlnS05XaVZzQ0hHV1p1bDJMVE5SVkJ2SHp3MG16aFh6bUpvUEtr?=
 =?utf-8?B?VXdEbkNyWmVmQ0I1a052WjJoUXBmZmlXeHlDOEdDUFMrUmJBYml3emRqYmRr?=
 =?utf-8?B?SFQ2YmFnTHUrNTNXZVhTMElCU3Fxb2N2K1JIZDVjUElFYnNlbVBzYUJnanNy?=
 =?utf-8?B?VHhBWllFMW0zSXhtbVFMWmdMcDJQdW16UHhiZUQ2b3dkSFpkcWZ1M2t6UnFN?=
 =?utf-8?B?RzhZa3duT1NVSzVGb0Q5SzNsNlpTR1ByQWFlY2ZPUUpvcjNpMEhSbjhyRTZu?=
 =?utf-8?B?ZHpwcEI3WVNveUk0SVl3aExPSmRxMkZnN3dFcUsvclg2dHRYK3p6T3lJZlhX?=
 =?utf-8?B?aGlRblJ3amJVRjRJZDBDcEg3Yk9WU2VvRHpaVDZMbTFNc0Y1Rys3OTJISjRt?=
 =?utf-8?B?QjRwREdSVytWbm5LVE9vUlRlUUsyZjFyYmZNY2o3VFd6YW42aWdmaTZkQkcy?=
 =?utf-8?B?ek13S2ZvMnpVY3hYRjRFZS81MG1JSitZZzlWR2ZURExHRWx2cXUvYjhYQm5K?=
 =?utf-8?B?U3ZjYTZzMm01NW1xdTBlRTI2dnFhclhsRDNqRi9iaVIrb3NMTkRzUW5DNHhx?=
 =?utf-8?B?OVUySDFiYkRpbnF2OTVoaHdiUEJwNlZwVXdHV3R1ak1TNXVVdFcxS3V4djNW?=
 =?utf-8?B?UWxHaVliM2NQMUpBcGVoT0xxMHRwVGM2V0RFV2hhUkdJQW1IaXZReHl0eDRT?=
 =?utf-8?B?ZjRUQzg1MzJoNkJXOEg0ZHF4VHVldUJ6U3hxdlQ5SnB0U1BkcVRVYWMyNHU4?=
 =?utf-8?B?OXkxVjNBVW5VaktZSlA2WFYzajIrUHF0NW9NSUY1NzJ5a1l1VEdCZk9ENWV6?=
 =?utf-8?B?eTdvMTNLVEswRmVETnNnK3FMb1NKY2tOTENzdDRORy8zcFgvK09QZWprMXdQ?=
 =?utf-8?B?U3J6bzNxNWNQNWkwS2l0WXZIQjF0bXFENGlKNUdXOWM1L1JveFNvSXFpbGFW?=
 =?utf-8?B?WEk4dDFTblBXcGhOTFNucnR6dW50aVdOR252ZWozUVZYd0luUURobXdSV25C?=
 =?utf-8?B?eExQKzhBZHczT0FnSDVja0lpWjBWRHpqRThuT0FCMWZ2TDV1d1E0UlBPQXJp?=
 =?utf-8?B?N0pOS0VnbEtrdmFjd0lTM043UWRKYUFxTm0zTDVQZ2JlYzdqRFExWFhWemdp?=
 =?utf-8?B?Q3ZhZ1VSMVV1OVk5NE8zY2srT0k3VWV1ZldHMXoyUDN1NnlYR0xVVjN6ZHM3?=
 =?utf-8?B?Ti90RGdnMjVubnpaVUVyM244akJZeHgwNTR0ZzkzTHZWRkpRQTBhcUhzSVFN?=
 =?utf-8?B?V05rOVJIY1ErQS9QM1AyeVM4dE9VQm83RlRCajJvaXEyRUhaRWxES0huRlJB?=
 =?utf-8?B?NUFWdzlZcmFKL0xaWkR4R2tRa25TQ0tvZkZmdW53T0V3cVo1RjhnemkvQ21p?=
 =?utf-8?B?eDUwcXdEZmRJWXBSalMvM0VOMVhxWHRGZ0VkUDQ5UFZQRXN0ZzFyTDB4WlJK?=
 =?utf-8?B?amtoakVZazlGaUR6ZkViQUg4ZGtiSUFVZzhJa1dKSTg2TXluWnJjTXMvTXVz?=
 =?utf-8?B?QXJuNEJGeVVOc1FuSktUSDZRRytxODdNR2VlODJoMi91bnIxU253K0VUa2Fk?=
 =?utf-8?B?a0pkc3d6RGNKOVJldk5WSzFURGNvS0hlSkhxMkdaVHBlY0lMUWpFbnc3bFl3?=
 =?utf-8?Q?t9/CXGnyOapsnw/A=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c7c613-3e23-46cf-f62a-08de9aa03ee5
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 03:36:57.7413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EsrutY/+OX7Hog/rJV84/FdX8TJE7zlBLZv99a25cjiTu/RaZewogl5ATuDMU3IqhziU4pZoCfRFxnGCks2kR+ceNzSJ8CN9o7D72R6PmHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5400
X-Mailman-Approved-At: Wed, 15 Apr 2026 06:10:26 +0200
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Jagan, Tom,

I wanted to follow up to see if there are any comments.
If there are no concerns, would it be possible to consider this for 
inclusion?
Thanks for your time.

Best Regards,
Lok

On 18/3/2026 10:59 am, Chen Huei Lok wrote:
> Add a new entry for the IS25WP01GG SPI NOR flash (ID 0x9d7021,
> 64KB sectors, 2KB page size) with 4K sectors, dual and quad read
> support. This flash is used and tested on N5X boards.
>
> Datasheet :
> https://www.issi.com/WW/pdf/25LP-WP01GG.pdf
>
> Signed-off-by: Chen Huei Lok<chen.huei.lok@altera.com>
> ---
>   drivers/mtd/spi/spi-nor-ids.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index b6a07fa9063..3e82058e9df 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -237,6 +237,8 @@ const struct flash_info spi_nor_ids[] = {
>   			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>   	{ INFO("is25wp01g",  0x9d701b, 0, 64 * 1024, 2048,
>   			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ INFO("is25wp01gg",  0x9d7021, 0, 64 * 1024, 2048,
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>   	{ INFO("is25wx256",  0x9d5b19, 0, 128 * 1024, 256,
>   			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
>   	{ INFO("is25lx512",  0x9d5a1a, 0, 64 * 1024, 1024,
> --
> 2.19.0
>
