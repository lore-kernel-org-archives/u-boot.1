Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A996CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 06:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7555D83FEC;
	Mon,  8 Jun 2026 08:07:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="onbnUWco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21D688466E; Mon,  8 Jun 2026 08:07:41 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65B13807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 08:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrybHnbs5H45THsXSDYUzWQoZ29G1P4viqdL00rOrPJcCDSqJW89Ba95YBJ7pfM3dNt32No6NL7a+58eWFjS1qzpa37lYC7MGZrOh7M6CPJvw/wKlISWDhzJBy42+nYlTiAyFL7pdoU90RFoRlR+tYaF7yJguST20aNUOq/TAgHtpCtiG+CHD9qOK56CeyKJJPO1BSoo6J/i73/reE55BDStURadi4qE8yuI2OKUDmlcX4BTegXBqxFKAkHlbAY7ry1YKIlb3CB8uf1riZ3OHSErQFmAEbXXfHARHNst+zS6toEKnye5yzFGjie9hXaM/1tYDz6ue6FqoYZ1CV7H7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+XzbbIVTmICipVC7OOKIj70Q4eIiNrvHHZoLw5A+FA=;
 b=EUXMVQXm61iULq8I2zM71Jw0Se+2eBD3nLZ3nBe3PHUnY93ioUryzRLA+mol38ozZIpTjtAyLH4cQs5mtUTlfGy+LfpiCbjjcHLUQBELq3fLy0HzuBziTcDmPC1XVi3xdv8SPTgdGm15iWjhJEv/jkYZO5GL0alOgJ9Hi9bvlmYYqvlikkw+83ruskY3ebwa9KeWUXudHWKreta5cHJA2lJCSYyHKziDlF40tgk/kIR+l2N9xOzXy6QN0fET1jCwqRvAx3xzkVskL7OGfGEOegKyNyarUYukuD9XsThTH2PaSq9cNtvy6Tnuo2YiBSisqoLCDa5frdnN0c7dr9POLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+XzbbIVTmICipVC7OOKIj70Q4eIiNrvHHZoLw5A+FA=;
 b=onbnUWcoW6P8kKtaIukEdO6oPLG/j6iZfZXDaemPmthgU4VMMWwjsAOaaJCLOLfYLZld/1hJDeSniFZa0GtRb8k3YdZJokuYz9WbTIDC/sX55Wz4EgFPFZ9Q2wkM1T+QedzpDz9DIymV8+zMnqGVboEj1Z3iah5Oe4it1wvj5Q4J4K1+q85/nAXiMXh9jWP1BmFvTXy673lv4lZsFxlfj4+tjGHkaXgSmCQguuauE+vfJQmhagmT0pmJnnoZVco4cwVzhhA/JRyBB8ZK9u5GQoJJTJRIM0ZeTdmbDpOffe2raNIkd/qVE0YN4g8btYUexGlWYNOTl0TioCYQlDh4og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ0PR03MB6987.namprd03.prod.outlook.com (2603:10b6:a03:43b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 06:07:33 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.007; Mon, 8 Jun 2026
 06:07:33 +0000
Message-ID: <d19a255f-ab8c-4331-88a5-37aa5e8e438f@altera.com>
Date: Mon, 8 Jun 2026 14:07:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ddr: socfpga: Implement ECC DRAM scrubbing support
 for both Gen5/Arria10
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Brian Sune <briansune@gmail.com>,
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>
References: <20260512064957.32497-1-alif.zakuan.yuslaimi@altera.com>
 <20260512064957.32497-4-alif.zakuan.yuslaimi@altera.com>
 <47e3b753-e0c8-4218-a427-020d0ec06c15@altera.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <47e3b753-e0c8-4218-a427-020d0ec06c15@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ0PR03MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: e26e9a8a-4306-4a97-cf4a-08dec5243b15
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003|55112099003|13003099007;
X-Microsoft-Antispam-Message-Info: IVpai10f8Gxg2SpAi21VBXJ+9wRlIc2BGjZA4hpyo6r0Hd3If3xoDXCYzkdbpJTGPopLVDo7dVEMjAAWWSa++ZsI/0G0piDAS6aEJAsDGn15WblQzpePITgcE0WobdFgF07NHuSnz6ay7pBLy+gxy1zMSRMfmhWeuth3j5fgfMLXTib3OHoUO/xKh1bG1iS/pgdW6SvXg18WPpLOapJs8n4iGWEy41gIH8XqbH6vBepUZJkT0U7eeaw3RlXVLK/rQG/s7llDI6Y6tzngXt6k+T4tlS+thBxvoUknAI6DA9mTqMixi4zlcGY9wBAXjo3l3mXMQR5mKHXtFgC4RreTtWiaTrwVPBtL4sUZwIgwtJMbDZWVsujrW0SqdsJRAQcq2DRw9QxP1gXwiKqanZBM2MgHcJaGXYsI1PPlVgQQruCJSqZcdCr1IgdF8tAN7UZeFn3w0pDqJqMor6+Axg4PhyO1VrsIhrn5L7vF41cGtqyIERfmLm8Y5qkkpR6btKaoBSSJjT3iITE9I1yK/e8Gqf4+7emsOIGNU9B648wu7JI6as4wcj9YSyRFCS7h2yxj4uQaD520YLWZc+ioD26qe0gHv1g+3U8AXK7GZKuKJ6Rlu+TK7w7Pi0EokQcgRMn9My85flORgr/WtlufWpu5XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(55112099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d29zanhnQWJQU2hLdnNCbVZGa3V3cVlNclhoZFkraHBFMzBveEUzT3hUV1JH?=
 =?utf-8?B?MHdXaVQ0V015NVAxajBYUHJUTzdTTVljb05DRTFzeGdXREdvQmZOTklza1R4?=
 =?utf-8?B?ZHZrcVRmeEJ6WkF0Z29LOWJRcjU2SndpVWZ2eGxFK29QTU1iSDVBL0xmc0lm?=
 =?utf-8?B?Q0JONit5NDdFODVCS3hCZXQ2S09CMVBiN1JqOWlvQzlnMldXOG9nNUc5cG5p?=
 =?utf-8?B?L0N0ek9JcnZ6VjJOTVVsR01pU3d2OTRyeDUxQkdZbVJGZVBGVndDSmdjem5k?=
 =?utf-8?B?cm00aTdIWnBWOFVMVDZ4amNKNTJmM3NSa2hmbEdZR25qUEIrUGpZVUpoRWRC?=
 =?utf-8?B?cERKeHFQWlJqNzU3Q3NQNGNEQUl1VkF0Yjh6VmVLVUhjTDlRWDRHZzNzNTJt?=
 =?utf-8?B?RFFxTk9yOXFpZ3pPcmhjMkhya0s2RVVxUE1ZRWJkNTU4RnZ2THEzcTVVSExB?=
 =?utf-8?B?RTB2WUMvVFdoNndNVWJIRWYrWkNPL0Fua0FFckp1dnJNOGlPRFBHQjhZVC95?=
 =?utf-8?B?TWk0ZnRPVzFpbjUzK2x0WllxelJOdWJzcW5OVEFzL0ExL1VwakVJWkZxeGk2?=
 =?utf-8?B?bkt6THNWRWdTVFlObmQwNXhqbUhKV0FDM0ZwWkpOa3FpR3kxR3VOYnZwdFp4?=
 =?utf-8?B?WmE4cEpXUkhReTRNcE1RcUNobnc3V3Nxemk5YytmUTd6TjU0N0JwQTcyaHl1?=
 =?utf-8?B?UWx3d24vU0NTMkoreTZ6b1RXa0Z3Ti90SVd4VGZpVVdxSUFOK3poNWhQb0xV?=
 =?utf-8?B?a1RNd3kxWmpHZzlIT05IM2doNHRBL3RmMHBtdmVwTFowRmsxdTAwTUZwNzBw?=
 =?utf-8?B?SzdVODFnZE9Tbm16YjBLaE5sMDJUd1pZNFljckFQTmhZMHUrTVNXUzV2ZXVq?=
 =?utf-8?B?UE8ydDgrREt6L1BMak1YcGw0OENCV1dmSWE5cndkNHhBZXorNndTeE9xVWY2?=
 =?utf-8?B?Ylo5M0ZSWVZlWjBZNysvSXYzU3NxTWpWK0Y2TEJHbFAzRjhxcEcxTTZOUWxN?=
 =?utf-8?B?dU8xeGJCVUJuMVEzaHJIQjAvejhMalFubVBmSXVpSjdUZnhWekozVkl5cEFZ?=
 =?utf-8?B?RGsxQk1wczVLenhjZ1hsaEtJc3NQQi9NV3N6M1JIU01RTjNQVGJOTDdjZXk5?=
 =?utf-8?B?OWlvL3Y4RnI0YWVod0t0b1h4Z2RhRUliVTVuWlFETnVjVHc0MGI5Qk1XL1hW?=
 =?utf-8?B?Q0J0c0tWeHFXQ0pQZ0tNaStrOGJCN0VUbWRxYmU0RjdlYVhEaGdVUWhrTmZF?=
 =?utf-8?B?ZUhya21qMUMrZHQ5bGdmUmdqZ1B4Z3FDSGVzYTVwWEJNcHp1TkJIVEpsOWt6?=
 =?utf-8?B?VkpyaC96UTkrZS9HYllWcHpMMk8yZUtHd0JJUXpYQndEZTZDTmRsVmpNU2Zl?=
 =?utf-8?B?RnliZkdCa1FkS1hZVU5lVGliaGlLVHAyRm1ZUTZINklkZ1FGTXAxQk1xMzQ3?=
 =?utf-8?B?U1oyclJ5S1hLTDNEYUQxV2JUbmUxSk9LVnpQK2hEZlhVU0FLQWVFeHlvUERy?=
 =?utf-8?B?Vjd2cGI1VW5jQ2UyVjlEV1hrd2Q3NFRSb2VmWXoxOHhyVHpVSGZyY25ESmVZ?=
 =?utf-8?B?NmxGdVplWlFyZ1ppbUREQmxkWXZyVU14TEF4VGd1VXdqalp6Rm10VjN1RFZW?=
 =?utf-8?B?QUo3Y2FpVlUzWEtxeWwwVlNNdVIvYlF3Z3R0aGsxYVBsOEZQUHBCOS9MOURL?=
 =?utf-8?B?Sm56RVMvQ2xnRlVxeW9Va2ZUSkJYUGkyNnA5RHBnek1jSjA3MjFndzMyVnY4?=
 =?utf-8?B?N0s2TGpPWTVwTUxPQStpV3NmQzdycWJxYlMyc2JKUWtTSWg0RDh6RnhCMHly?=
 =?utf-8?B?S3dHbDFpOGZvY3dVYk1qQXRUSGFIaWZyYkxFYlE3Y1J6VW9URm5VS3cxZFdj?=
 =?utf-8?B?UEN3VGtUNXJtWWRnK2NmUGRPYnNKVC9YQyt1SkE1U05VLzN1R2duVUErMjli?=
 =?utf-8?B?ZHY5a3FNSTJQZ3U0UGFrdlU1NHdDNnZlMUFmQ3M0ckVpaFFRTzUxY2FkR0N6?=
 =?utf-8?B?OFhqaUprL0txRjFLZXVGYkYvK001RHBvV2kzb0ZtMnBrN1V4TUdpeW9xQWQz?=
 =?utf-8?B?dUpFYXJrRndVWlplY1liY3RlMlNneGZPUzE2M2piR1c4bWV1Y0hxanh3ZkZv?=
 =?utf-8?B?bFhmZEdVeC9nbUwvZzFJRTErNXk2aHNHSWIwRWlNWi93M0M0cmJnUXFUbFZV?=
 =?utf-8?B?bkhNSDQ2U21teVdiM2poTGxLTXFzK2l6cnNNQm5SbFZPR1dKVVJ5ZFdSejN5?=
 =?utf-8?B?bHZHMkFQUEJyR0pQUzFFNDFpVHB4QU5Zd2FwVXhzOXlSM0RPVGorSDhvb3VB?=
 =?utf-8?B?aWdmc045MHZ1S1pXbDJPV254cm1adlFSbDE5czNIY1VHSGtBbld1R0NyUHpU?=
 =?utf-8?Q?5o0B467TKWNTwwvc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26e9a8a-4306-4a97-cf4a-08dec5243b15
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 06:07:33.7329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1rvz7R8YXpyk7IZYinmNMIPmbFCKKh67Wz82C4LpVONcLOpRvLdNIbKk9TBKJMKY1qV1ZfR2f7s2s9nZ8P5SRe2whIRNd8NQpCZiN7M17Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6987
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

On 5/6/2026 12:56 pm, Chee, Tien Fong wrote:
> Hi Alif,
> 
> 
> On 12/5/2026 2:49 pm, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> Enable ECC scrubbing support for Gen5 by moving sdram_init_ecc_bits() 
>> from
>> sdram_arria10.c to a new common file, sdram_soc32.c which is shared by 
>> both
>> Arria10 and Gen5 devices. This makes ECC scrubbing support no longer
>> exclusive only to Arria10.
>>
>> New Kconfig is introduced to enable this implementation only on the 
>> default
>> Arria10 and CycloneV boards as this will increase the SPL size which
>> will exceed some Gen5 devices' SPL size limit.
>>
>> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>> ---
>>
>> Changes in v3:
>> - Updated commit message
>> - Removed legacy HW watchdog check in favor of current WDT DM for 
>> Gen5/Arria10
>> - Dead code cleanups, indentation fixes
>>
>> Changes in v2:
>> - ECC scrubbing is set as optional via Kconfig and defaulted on only for
>>    the reference Arria10/CycloneV boards to avoid SPL overflows on
>>    size-limited Gen5 defconfigs.
>>
>>   arch/arm/mach-socfpga/Kconfig      | 12 +++++
>>   arch/arm/mach-socfpga/spl_a10.c    | 11 ++--
>>   arch/arm/mach-socfpga/spl_gen5.c   | 10 +++-
>>   drivers/ddr/altera/Makefile        |  4 +-
>>   drivers/ddr/altera/sdram_arria10.c | 31 ++++-------
>>   drivers/ddr/altera/sdram_gen5.c    | 39 ++++++++++++--
>>   drivers/ddr/altera/sdram_soc32.c   | 85 ++++++++++++++++++++++++++++++
>>   drivers/ddr/altera/sdram_soc32.h   | 15 ++++++
>>   8 files changed, 172 insertions(+), 35 deletions(-)
>>   create mode 100644 drivers/ddr/altera/sdram_soc32.c
>>   create mode 100644 drivers/ddr/altera/sdram_soc32.h
>>
>> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/ 
>> Kconfig
>> index b814e034ecd..dd71691b724 100644
>> --- a/arch/arm/mach-socfpga/Kconfig
>> +++ b/arch/arm/mach-socfpga/Kconfig
>> @@ -6,6 +6,13 @@ config ERR_PTR_OFFSET
>>   config NR_DRAM_BANKS
>>       default 1
>> +config SOCFPGA_ECC_SUPPORT
>> +    bool "Enable ECC support for DRAM"
>> +    help
>> +     Adds CPU-based ECC support for DRAM at boot. This will initialize
>> +     all DRAM ECC metadata to zero, preventing false ECC errors and
>> +     improving reliability.
>> +
>>   config SOCFPGA_DRAM_SIZE_CHECK
>>       bool "Enable DRAM size checking for safety"
>>       help
>> @@ -105,6 +112,7 @@ config ARCH_SOCFPGA_ARRIA10
>>       select ETH_DESIGNWARE_SOCFPGA
>>       imply FPGA_SOCFPGA
>>       imply SPL_USE_TINY_PRINTF
>> +    select SOCFPGA_ECC_SUPPORT
>>   config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
>>       bool "Always reprogram Arria 10 FPGA"
>> @@ -117,6 +125,9 @@ config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
>>   config ARCH_SOCFPGA_CYCLONE5
>>       bool
>>       select ARCH_SOCFPGA_GEN5
>> +    select SOCFPGA_ECC_SUPPORT if \
>> +      !TARGET_SOCFPGA_TERASIC_SOCKIT && !TARGET_SOCFPGA_EBV_SOCRATES \
>> +      && !TARGET_SOCFPGA_SOFTING_VINING_FPGA
>>       select SOCFPGA_DRAM_SIZE_CHECK if !TARGET_SOCFPGA_TERASIC_SOCKIT \
>>         && !TARGET_SOCFPGA_EBV_SOCRATES && \
>>         !TARGET_SOCFPGA_SOFTING_VINING_FPGA
>> @@ -124,6 +135,7 @@ config ARCH_SOCFPGA_CYCLONE5
>>   config ARCH_SOCFPGA_GEN5
>>       bool
>>       select SPL_ALTERA_SDRAM
>> +    select SPL_CACHE if SPL && SOCFPGA_ECC_SUPPORT
>>       imply FPGA_SOCFPGA
>>       imply SPL_SIZE_LIMIT_SUBTRACT_GD
>>       imply SPL_SIZE_LIMIT_SUBTRACT_MALLOC
>> diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/ 
>> spl_a10.c
>> index c20376f7f8e..0d0412d3507 100644
>> --- a/arch/arm/mach-socfpga/spl_a10.c
>> +++ b/arch/arm/mach-socfpga/spl_a10.c
>> @@ -25,6 +25,7 @@
>>   #include <asm/sections.h>
>>   #include <fdtdec.h>
>>   #include <watchdog.h>
>> +#include <wdt.h>
>>   #include <asm/arch/pinmux.h>
>>   #include <asm/arch/fpga_manager.h>
>>   #include <mmc.h>
>> @@ -265,14 +266,8 @@ void board_init_f(ulong dummy)
>>       /* Configure the clock based on handoff */
>>       cm_basic_init(gd->fdt_blob);
>> -#ifdef CONFIG_HW_WATCHDOG
>> -    /* release osc1 watchdog timer 0 from reset */
>> -    socfpga_reset_deassert_osc1wd0();
>> -
>> -    /* reconfigure and enable the watchdog */
>> -    hw_watchdog_init();
>> -    schedule();
>> -#endif /* CONFIG_HW_WATCHDOG */
>> +    if (CONFIG_IS_ENABLED(WDT))
>> +        initr_watchdog();
>>       config_dedicated_pins(gd->fdt_blob);
>>       schedule();
>> diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/ 
>> spl_gen5.c
>> index a9825173189..530863b1564 100644
>> --- a/arch/arm/mach-socfpga/spl_gen5.c
>> +++ b/arch/arm/mach-socfpga/spl_gen5.c
>> @@ -22,12 +22,14 @@
>>   #include <debug_uart.h>
>>   #include <fdtdec.h>
>>   #include <watchdog.h>
>> +#include <wdt.h>
>>   #include <dm/uclass.h>
>>   #include <linux/bitops.h>
>>   DECLARE_GLOBAL_DATA_PTR;
>> -#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT) || \
>> +    IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>>   static struct bd_info bdata __attribute__ ((section(".data")));
>>   #endif
>> @@ -113,6 +115,9 @@ void board_init_f(ulong dummy)
>>       if (cm_basic_init(cm_default_cfg))
>>           hang();
>> +    if (CONFIG_IS_ENABLED(WDT))
>> +        initr_watchdog();
>> +
>>       /* Enable bootrom to configure IOs. */
>>       sysmgr_config_warmrstcfgio(1);
>> @@ -150,7 +155,8 @@ void board_init_f(ulong dummy)
>>       /* enable console uart printing */
>>       preloader_console_init();
>> -#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT) || \
>> +    IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>>       gd->bd = &bdata;
>>   #endif
>> diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
>> index 8259ab04a7e..ece6a131897 100644
>> --- a/drivers/ddr/altera/Makefile
>> +++ b/drivers/ddr/altera/Makefile
>> @@ -7,8 +7,8 @@
>>   # Copyright (C) 2014-2025 Altera Corporation <www.altera.com>
>>   ifdef CONFIG_$(PHASE_)ALTERA_SDRAM
>> -obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
>> -obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += sdram_arria10.o
>> +obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += sdram_soc32.o sdram_gen5.o 
>> sequencer.o
>> +obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += sdram_soc32.o sdram_arria10.o
>>   obj-$(CONFIG_ARCH_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
>>   obj-$(CONFIG_ARCH_SOCFPGA_AGILEX) += sdram_soc64.o sdram_agilex.o
>>   obj-$(CONFIG_ARCH_SOCFPGA_N5X) += sdram_soc64.o sdram_n5x.o
>> diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/ 
>> sdram_arria10.c
>> index c281f711fdf..ac5d3f03f05 100644
>> --- a/drivers/ddr/altera/sdram_arria10.c
>> +++ b/drivers/ddr/altera/sdram_arria10.c
>> @@ -22,6 +22,8 @@
>>   #include <linux/bitops.h>
>>   #include <linux/delay.h>
>>   #include <linux/kernel.h>
>> +#include <linux/sizes.h>
>> +#include "sdram_soc32.h"
>>   DECLARE_GLOBAL_DATA_PTR;
>> @@ -193,24 +195,6 @@ static int sdram_is_ecc_enabled(void)
>>             ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK);
>>   }
>> -/* Initialize SDRAM ECC bits to avoid false DBE */
>> -static void sdram_init_ecc_bits(u32 size)
>> -{
>> -    icache_enable();
>> -
>> -    memset(0, 0, 0x8000);
>> -    gd->arch.tlb_addr = 0x4000;
>> -    gd->arch.tlb_size = PGTABLE_SIZE;
>> -
>> -    dcache_enable();
>> -
>> -    printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
>> -    memset((void *)0x8000, 0, size - 0x8000);
>> -    flush_dcache_all();
>> -    printf("DDRCAL: Scrubbing ECC RAM done.\n");
>> -    dcache_disable();
>> -}
>> -
>>   /* Function to startup the SDRAM*/
>>   static int sdram_startup(void)
>>   {
>> @@ -735,8 +719,15 @@ int ddr_calibration_sequence(void)
>>       if (of_sdram_firewall_setup(gd->fdt_blob))
>>           puts("FW: Error Configuring Firewall\n");
>> -    if (sdram_is_ecc_enabled())
>> -        sdram_init_ecc_bits(gd->ram_size);
>> +    if (sdram_is_ecc_enabled()) {
>> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>> +        sdram_init_ecc_bits();
>> +#else
>> +        puts("DDR: Enable CONFIG_SOCFPGA_ECC_SUPPORT when SDRAM ");
>> +        puts("ECC is enabled.\n");
>> +        hang();
>> +#endif
>> +    }
>>       sdram_size_check();
>> diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/ 
>> sdram_gen5.c
>> index 1c3c70ea8ae..9c58e4355ae 100644
>> --- a/drivers/ddr/altera/sdram_gen5.c
>> +++ b/drivers/ddr/altera/sdram_gen5.c
>> @@ -2,6 +2,7 @@
>>   /*
>>    * Copyright Altera Corporation (C) 2014-2015
>>    */
>> +#include <cpu_func.h>
>>   #include <dm.h>
>>   #include <errno.h>
>>   #include <div64.h>
>> @@ -19,8 +20,9 @@
>>   #include <asm/global_data.h>
>>   #include <asm/io.h>
>>   #include <dm/device_compat.h>
>> -
>> +#include <linux/sizes.h>
>>   #include "sequencer.h"
>> +#include "sdram_soc32.h"
>>   #ifdef CONFIG_XPL_BUILD
>> @@ -566,6 +568,19 @@ static unsigned long sdram_calculate_size(struct 
>> socfpga_sdr_ctrl *sdr_ctrl)
>>       return temp;
>>   }
>> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>> +static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
>> +{
>> +    return !!(readl(&sdr_ctrl->ctrl_cfg) &
>> +          SDR_CTRLGRP_CTRLCFG_ECCEN_MASK);
>> +}
>> +#else
>> +static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
>> +{
>> +    return 0;
>> +}
>> +#endif
>> +
>>   static int altera_gen5_sdram_of_to_plat(struct udevice *dev)
>>   {
>>       struct altera_gen5_sdram_plat *plat = dev_get_plat(dev);
>> @@ -608,10 +623,13 @@ static int altera_gen5_sdram_probe(struct 
>> udevice *dev)
>>       sdram_size = sdram_calculate_size(sdr_ctrl);
>>       debug("SDRAM: %ld MiB\n", sdram_size >> 20);
>> -#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK) || \
>> +    IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>>       /* setup the dram info within bd */
>>       dram_init_banksize();
>> +#endif
>> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>>       if (sdram_size != gd->bd->bi_dram[0].size) {
>>           printf("DDR: Warning: DRAM size from device tree (%lu MiB)\n",
>>                  (ulong)(gd->bd->bi_dram[0].size >> 20));
>> @@ -626,8 +644,23 @@ static int altera_gen5_sdram_probe(struct udevice 
>> *dev)
>>       }
>>   #endif
>> +    if (sdram_is_ecc_enabled(sdr_ctrl)) {
>> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>> +        /* Must set USEECCASDATA to 0 if ECC is enabled */
>> +        clrbits_le32(&sdr_ctrl->static_cfg,
>> +                 SDR_CTRLGRP_STATICCFG_USEECCASDATA_MASK);
>> +        sdram_init_ecc_bits();
>> +#else
>> +        puts("DDR: Enable CONFIG_SOCFPGA_ECC_SUPPORT when SDRAM ");
>> +        puts("ECC is enabled.\n");
>> +        puts("DDR: Without scrub, false ECC errors may occur.\n");
>> +        hang();
>> +#endif
>> +    }
>> +
>>       /* Sanity check ensure correct SDRAM size specified */
>> -#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK) || \
>> +    IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>>       if (get_ram_size(0, gd->bd->bi_dram[0].size) !=
>>           gd->bd->bi_dram[0].size) {
>>   #else
>> diff --git a/drivers/ddr/altera/sdram_soc32.c b/drivers/ddr/altera/ 
>> sdram_soc32.c
>> new file mode 100644
>> index 00000000000..2fc06fddd4c
>> --- /dev/null
>> +++ b/drivers/ddr/altera/sdram_soc32.c
>> @@ -0,0 +1,85 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>> + */
>> +
>> +#include "sdram_soc32.h"
>> +#include <string.h>
>> +#include <hang.h>
>> +#include <linux/sizes.h>
>> +#include <cpu_func.h>
>> +#include <watchdog.h>
>> +#include <wait_bit.h>
>> +#include <asm/global_data.h>
>> +#include <asm/system.h>
>> +#if !IS_ENABLED(CONFIG_WATCHDOG) && !CONFIG_IS_ENABLED(WDT)
>> +#include <asm/arch/reset_manager.h>
>> +#endif
>> +
>> +DECLARE_GLOBAL_DATA_PTR;
>> +
>> +#define PGTABLE_OFF    0x4000
>> +#define PGTABLE_RESERVE (PGTABLE_OFF + PGTABLE_SIZE)
>> +
>> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>> +static void socfpga_prepare_watchdog_for_long_op(void)
>> +{
>> +#if !IS_ENABLED(CONFIG_WATCHDOG) && !CONFIG_IS_ENABLED(WDT)
> 
> 
> note in commit that legacy HW_WATCHDOG path was removed in v3
> 
> 
>> +    /*
>> +     * No watchdog driver is active in U-Boot. The bootrom or a
>> +     * previous boot stage may have left L4WD0 running. Assert and
>> +     * deassert its reset to stop it before the long ECC scrub,
>> +     * preventing a spurious watchdog reset during DDR init.
>> +    */
> 
> 
> checkpatch BLOCK_COMMENT_STYLE on */
> 
> 
>> +    socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
>> +    socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
>> +#endif
>> +}
>> +
>> +/* Initialize SDRAM ECC bits to avoid false DBE */
>> +void sdram_init_ecc_bits(void)
>> +{
>> +    u32 start;
>> +    phys_addr_t start_addr;
>> +    phys_size_t size, size_init;
>> +
>> +    start = get_timer(0);
>> +
>> +    start_addr = gd->bd->bi_dram[0].start;
>> +    size = gd->bd->bi_dram[0].size;
>> +
>> +    printf("DDRCAL: Scrubbing ECC RAM (%lu MiB).\n",
>> +           (ulong)(size >> 20));
>> +
>> +    if (size <= PGTABLE_RESERVE) {
>> +        printf("DDRCAL: Error: DRAM size %#llx smaller than scrub 
>> reserve %#x\n",
>> +               (unsigned long long)size, PGTABLE_RESERVE);
>> +        hang();
>> +    }
>> +
>> +    memset((void *)start_addr, 0, PGTABLE_RESERVE);
>> +    gd->arch.tlb_addr = start_addr + PGTABLE_OFF;
>> +    gd->arch.tlb_size = PGTABLE_SIZE;
>> +    start_addr += PGTABLE_RESERVE;
>> +    size -= PGTABLE_RESERVE;
>> +
>> +    dcache_enable();
>> +
>> +    socfpga_prepare_watchdog_for_long_op();
>> +
>> +    while (size > 0) {
>> +        size_init = min_t(phys_size_t, (phys_size_t)SZ_1G, size);
>> +        memset((void *)start_addr, 0, size_init);
>> +        size -= size_init;
>> +        start_addr += size_init;
>> +
>> +        /* Service DM watchdog cyclic callbacks */
>> +        schedule();
>> +    }
>> +
>> +    dcache_disable();
>> +
>> +    printf("DDRCAL: SDRAM-ECC initialized success with %u ms\n",
> 
> 
>   “initialized success” → “initialized successfully”
> 
> Best regards,
> 
> Tien Fong
> 

Thank you for your input. Further clean up will be done for v4 
submission based on your comments

Alif
