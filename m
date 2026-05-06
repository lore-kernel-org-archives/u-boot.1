Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E291DCD3424
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 05:04:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63785847E1;
	Wed,  6 May 2026 07:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tKlTrcV3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5DAA847E8; Wed,  6 May 2026 07:04:35 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D663A84704
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 07:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlLvyWLS12dGSKUPQVxlslNZiC/XWiZBmaIuPg0vZjgOkCKTnl2yle21LAQG33p1/3k53W29dB6qb+/vrLDsRVEjiGdv7sRs1mWnNWWs3I7xKs1t9brRLrZbcNfVTNST2w5xiS1nnJHNW6RaVfJPuWPXR6t+aILm4AatHq0LASgc9f/B1aXpkx7MF2MXzrkIRNOQpe+pRblhqH1PyNKm5Jw9YuLsiZCsT/c2umREs66BlFRQ+iXiD10rHI0Z6yPHYK9VjxRmCPQ6eBRHMidHNievHMFNbh+I4u9CEtcdEwbLQrVrlYoDGxYDo3/1Xm/ZMouZ5wzM3f+kcGRB/7EWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlqIId5WGbZ0uhLujucbTlEHm7XNPRz368VhkFrH+98=;
 b=MJXHmk9RNFaqTeW/urMHa4R6jMbkjcBh634aG0MmnSFgfOMmrKNBH2h24mg2Uu+iB7BZrAoKPQ6GwDOqjtD8xBjHninltxwcgBpBTLXrCCr3+/Y+kLw9IQdRtMWXzQqjCyatx8CwCccxAOuR6FggGB1N+vyO7xQPj4rvlqwvo1vfgJgDQBnSyjdx6YqPniXwuBRpNnN4SCZrdP09QPGygrc27y7Kbc7lu6+2Yy3R0ydtfILK3cbIf5P3jicV9jAxSHxXt8pFqSe7HW3YQ57ULoT6xfD5FJyxDNtqyP33ybyhv3E4ZkAahK3lnNbLtGfhTMBTpW6auJeCOHEzQeNfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlqIId5WGbZ0uhLujucbTlEHm7XNPRz368VhkFrH+98=;
 b=tKlTrcV3ij+hWUWumdk5h8ckqeUMmlTluPJhtebikBAdord6DErOnhk1XJP5ocKfZ9h8L4m47KqneAPVsHW+0L7TgMz6IjZPlZUgu2rE5EvBrEUhtOhjcl159kKYzTpcGpBXscoGsuuDr7Xjx2Uz6FEHMjXclKkN/KTqALpb3Nb4EO8nOmABA3Zriw6OjtqtGRV2ZYJkfZLSo+47oG3yMXBxheA13DRjUoUuoRbwBMaPQUXINiaBypGG52BlsG3SgUiqJ36GwXGwVS7HrWBcitZUvC6sOwcbCivqqUH3UEVB2nDxxYEKxBnbgQEadba3P2Be7RV/+NmVYwSSM/f7ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by LV3PR03MB7521.namprd03.prod.outlook.com (2603:10b6:408:19f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 05:04:29 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 05:04:29 +0000
Message-ID: <d3ae9bf1-e734-4d59-be28-a3f85e6a91a0@altera.com>
Date: Wed, 6 May 2026 13:04:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm: socfpga: Consolidate dram_bank_mmu_setup()
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Brian Sune <briansune@gmail.com>,
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>
References: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
 <20260428033230.7777-2-alif.zakuan.yuslaimi@altera.com>
 <5ce3b23e-97a7-46b5-a0d6-2ba28d7a2c68@altera.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <5ce3b23e-97a7-46b5-a0d6-2ba28d7a2c68@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|LV3PR03MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3a8172-1169-414b-98d4-08deab2cf3b7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: S99Y6SNAgeLpmJdLveIqPmr8CQWbHBFjk6gF/dYNTk8Z6sXGCFUaQl5v35PAFObF5yj8xH8AB0aaUvhlOdQF1K2AafRSJUABmcDtkC7k/2AXTijJDj2K9X9krGRJ6+brb3n3ddsk/9C14nQ3xsOnPMqsjUC0JB0DPIPjUOkXjRcHWGFDnIaKdLNVuihWPshhb9Da5PwqFG2nFch5+mv/4ryqjH50t5XAOhTRSkgJRKLihzCt76EMVSiHy7yu1al17GywJgNJAFGHhbI2oxHSeSQ22Wf4Asw/e8W7Q/aL/y7WqhPuh6wgJwbqHeLM2x/zSucFl7ERqprCqzlhJvmNn1nU1dOXSbBnofJEN+oWd+BjvrjVz8wTYS8a8VgqdOjRX0/wEVxBs+gvVI42cnMos/gYu18zzQcaXyXpP+ozbT/jkAt3Uc/gKqyFlFmHe933pivMdkXHeWuE1XzOy2l6ye5aXI0Qp1kYVp+iPsE0cgDy4pZxCzZW3S1uNIyloM6I+QMDqKqNMKJG41S9zj8i8tPDDYTcWor35agVLXUcNYcZt7iZ4pjFMIeUg5EH5dXKqF85IwjIsYifSxPckrcVJgHZP5ddd8zFPywAab125VVzbg/5RjUEvD+3rJ5ymROQKDkYIOhtj1zUaW/B5oDPbi/dau8eVhcdNUAlRqIAv4wES7mcuTfe+l21pOToGvzn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkdGQXRqakxncGY1cDdNMS8vaVhsUGZZdGwvZVltMGZ6TCtwM1dMM3d3V1h4?=
 =?utf-8?B?SlUyRC9LRGZIOHJHdnhuSnBsQXFiZTV0SU5mWWJoZGdnbEtKVUFoWWZ1Nzl1?=
 =?utf-8?B?U3JianZyUUU2ZWhDbk5IT3RROERFQnByUDFmNGlJOGZ4dHZQOUZ1dk5xVjUw?=
 =?utf-8?B?TjlPZU9tSHdkcmlVNm1zS1RkOWROTFlsL0J3eVNGYzdKT0w0SUJUUDd6enRx?=
 =?utf-8?B?SzZCZ2srbGdrUUZEVGROcUc3anVzeXBMZ2JKbFFtbFMreFB4ZEdNTWw3UEdx?=
 =?utf-8?B?bEJwYlBGaTNQNzk5NXhNYkd2LzREZGx3c1hoUVlQMWMraDkzcU9vUkw5Mmxo?=
 =?utf-8?B?eG1hVUdsQnY0cncxUjIxSFA0RTRkZ1FSMVd2U2FuRkdoakREdC9ncHV6cmxD?=
 =?utf-8?B?cTJVWnRrc3htUWxqaDVJaEpOaVN2QXEzWTlvdmtqRDg1Nld2SFJETVQ0STho?=
 =?utf-8?B?N0lpbjFxRzZHWTFLeWZ4Mms3SFZrK1RRbTFHNWE5ZnNTOEN6MGFJZHBNM0sr?=
 =?utf-8?B?NmhrY3E1TThRektqenpqY3Q3M01KcmlsakFQd1VjZlpnMlRmTXlzZ2krZmdY?=
 =?utf-8?B?ZW8rZDdDbXFEOWNTVHZNTzcwR0JxSHVFQmZKQXpVNVdZSFVTMTBWa0NycXdV?=
 =?utf-8?B?RnZWNUhWczFvR05mUitoVmpXT1VWOHZEalBtVXp5eHc1akl4MXB5ZHRmcWtp?=
 =?utf-8?B?eWxVZTZqbnpjS094K1NTZ2VtOGpYaHZxdS9pVHArd3BCb3o1NW5DR2JxNVlP?=
 =?utf-8?B?aDU5OGhmb3RNQ0dwb0loMldpelRGeXFad2xCRXNVVDVFTEcyVFVFa3VzSXN4?=
 =?utf-8?B?NWR5bVQvUTNMb3R1SGE4cmRtRWM0S1RkczBBbFVXK3NITytRbkRJeVdnTFpD?=
 =?utf-8?B?c0JhZU9tV1BjZU9JUUYrdkZXRy9wNjBlczQ3bW1Bb0hpZ1BTU29wdTYxN2Rp?=
 =?utf-8?B?aU1tTDhsd2FHemRVczR2YkNwSVR2UmdpR2tkaGlwS1ZvblVycjkyZzlVTTFC?=
 =?utf-8?B?LzhyRm9zSzM3MG43ZXdKeWZNUGtwQ3FsWDVGdzRWcCt0QUl5WTJ0VXdialMr?=
 =?utf-8?B?NElsRzNrNGYrdUp2QUpoSllqTU1UWnpQZHQ5SjRsbTNSeC9KRE1ma0dmNjRz?=
 =?utf-8?B?WW53NzlFMWFkdkxLcEgzZmp4SEhjd2dpdmhTVzVoeXV6Sk4rZjJpS0doNWNF?=
 =?utf-8?B?TVdwWW1rMFg2REN6RGdXZFVsS3EwanlJMnI3N0lPazA2TUdvRkh6NXZXdHRy?=
 =?utf-8?B?dmdHWjBLSWZDcllpYXRuQktqLytQdjBvU2phcDNiWnpraVpUd1ZwRHVlRkVw?=
 =?utf-8?B?SnlxbWVVemVacXVyZEpobVAwdmRHR0lUR2gwZWJWQnp3TkVRUDcybnQrTUdl?=
 =?utf-8?B?U3N4aDBZRkw2SlpEU2VuZCtmNFdkSzZzTGtJbE9jTlhzNEE4NHptMC9NZ205?=
 =?utf-8?B?MUtCeWE1REVEOGFGNUxCZnRDempzL0E5bVJxdVJrckExU2J1Y3JxMXZFMGZN?=
 =?utf-8?B?ZU9jYjRmZ3kxRzgyUFNjb0xjUGtZVjEweVJ2cmNHbU5pRkEzdWJ4enlEdzR4?=
 =?utf-8?B?UHp5dXFPd1RQUXVWWWxJaUVWZDVqQ0FkTU51V1FlR3NscVFGaHU5a3A4SnBp?=
 =?utf-8?B?cWNSVXo3SmJVSks1VnlOMmsxejJpMldBL1lyUzNYd2tBeDlDYkcyM29sNUFK?=
 =?utf-8?B?NHdQbU5VWlY3SG9FQk9wQzU3MS9jTHFCTWw1bzRibTRodUxIM3pvSDdoN0ls?=
 =?utf-8?B?RWt4SzBiNWhvdlRJYTRMTWJmd2t4cHdBVmowYWpHOXFtNjYrQ1R1YVUrNFhr?=
 =?utf-8?B?NkRobXhxd3IrU1NrVHozUkpUVmZTTkx1NjkrNWdLaDYvY2JaQXp5d3Z3dnM2?=
 =?utf-8?B?bU90QWNIMSsvZHZjMjVwTXVIZzBkVjdabVhpWUlnOWJhOEJxMjBOTzVPVjJn?=
 =?utf-8?B?QmxMTXZnUlc1RWRGWnI2Y2NpY2RhamdzVDVsMlVwUllEVkc2WHYvVUd4dmdv?=
 =?utf-8?B?RFdseWJhenNHQVVnK1hDcDVQZkhKcy9Ta2ZtbVduTVZqTjdOQmJQTUZGNEd5?=
 =?utf-8?B?RklJR0k4biswNFFGSzZVTWlwQ2VaRWJwWTkrZGRzaWFURTRpMEp1RDh1dU0z?=
 =?utf-8?B?WmtoWEREOUlPYVNDT2ZQekNubVZhQ1pMdkwvVFgxTFk3UWlBem4xdlVnU2dF?=
 =?utf-8?B?UFZYNW05MXB6YzhxQzlhckxYNE5pKzhLbnpiQjVGQm9wNEtwUjFmaHNaeExF?=
 =?utf-8?B?OTFnTkVJYm10MzNUYjBpU2RCRitJOFM2R3pQeEtOZWV1akJGdTQwZlpScEw1?=
 =?utf-8?B?dVUxQ2J3dUVNUkxNdVBYQ2gwNTVPRjBTS1hMb2lyaG5ma1FYeXZOM1MvZFZm?=
 =?utf-8?Q?eljwajysH/oi0rVUTnb6Nyiq3JCjb1QYA2VHi?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3a8172-1169-414b-98d4-08deab2cf3b7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 05:04:29.3975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sPMqj5iytOb2dj7/U0NNB55x38XjkcTQ0B4sGWriN0B0cd1/y+MuKU7AL8bntudeOc7JhaMUSz3JjzklK7WxdVaY68koc/D/+ZZ+SyqcXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7521
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

On 5/5/2026 1:03 pm, Chee, Tien Fong wrote:
> Hi Alif,
> 
> 
> On 28/4/2026 11:32 am, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> Relocate the dram_bank_mmu_setup() implementation from misc_arria10.c to
>> the common socfpga misc.c and update the function to correctly handle 
>> both
>> pre-relocation and post-relocation cases for DRAM cache enabling for
>> consistent MMU/dcache setup across Arria10 and CycloneV platforms.
>>
>> These changes help to improve maintainability and consistency of DRAM
>> initialization as well as MMU configuration for Arria10 and CycloneV
>> platforms.
>>
>> New Kconfig is introduced to enable this implementation only on the 
>> default
>> Arria10 and CycloneV boards as this will increase the SPL size which
>> will exceed some Gen5 devices' SPL size limit.
>>
>> Fixes: e26ecebc684b ("socfpga: arria10: Allow dcache_enable before 
>> relocation")
>>
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>> ---
>>   arch/arm/mach-socfpga/Kconfig        |  1 +
>>   arch/arm/mach-socfpga/misc.c         | 31 ++++++++++++++++++++++++++++
>>   arch/arm/mach-socfpga/misc_arria10.c | 26 -----------------------
>>   3 files changed, 32 insertions(+), 26 deletions(-)
>>
>> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/ 
>> Kconfig
>> index fb98b647442..e2fdd6bb30f 100644
>> --- a/arch/arm/mach-socfpga/Kconfig
>> +++ b/arch/arm/mach-socfpga/Kconfig
>> @@ -115,6 +115,7 @@ config ARCH_SOCFPGA_CYCLONE5
>>   config ARCH_SOCFPGA_GEN5
>>       bool
>>       select SPL_ALTERA_SDRAM
>> +    select SPL_CACHE if SPL
> 
> 
> Concern: Two-step SPL_CACHE Kconfig creates dangerous intermediate 
> bisect state
> 
> Impact:
> 
> Bisect or backport landing only patch 1 forces SPL_CACHE=y for 
> TARGET_SOCFPGA_TERASIC_SOCKIT,
> 
> TARGET_SOCFPGA_EBV_SOCRATES, TARGET_SOCFPGA_SOFTING_VINING_FPGA. SPL 
> exceeds 64 KiB limit and fails to boot.
> 
> Fix:
> 
> Remove the 'select SPL_CACHE if SPL' hunk from patch 1 entirely.
> 
> Add the correct conditional form 'select SPL_CACHE if SPL && 
> SOCFPGA_ECC_SUPPORT' only in patch 3 alongside SOCFPGA_ECC_SUPPORT.
> 
> Best regards,
> 
> Tien Fong
> 
Thank you for your input. I will address this in v3.

Alif
