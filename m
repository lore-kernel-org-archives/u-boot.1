Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDCCCD3436
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 02:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61FA0847D9;
	Thu,  7 May 2026 04:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="aRjESyMq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB895847D9; Thu,  7 May 2026 04:55:09 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F41AC846B1
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 04:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjjStMwpZqBqL2Qg8JKMUcuUeIcle6Dk0SAH0qysiohwR0rtKBm6n+A+tw1wm51Q8QU6K7KWCRSX7RrCm75G7aYU4GwUP9ctB0+x/Ab56kOT+dkXx6ZBeVyJLbsBYkMe5Qt1s5mtZ4ECgfNgCfmZ4cV4B1FHIjjYw3jS3in5wU0JF3fahLg77gr1MXRiDfqqZvQ6+FdqQqm4tphYqi+Y61ZW7lNHUgUGLJ04Ehm/PxLXRvig1JlZfrZTsQiLs1r97pK5TclFAI8XVwX7VpCMOrygJTSj5XzgMeHSWZVJ3VP2N4sTvQxKCA2qR7qxEqhMsPaYz7rI8n/81rmgBzhZLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JT/VYuXqeUYLrzyhVy7IjpGhPZrQPuMYrz5cV9uxhZs=;
 b=WEUSRBYnXmPUxr8IZ611bFnTRc0HTf12kDQifr6rnWStzwUtw7kJODbHAC4mCm+r0a5l54nkG9tpzcPL2tYb3So42J4eY2kNSGsZ5gXwUCmu5/JWa2NAPkqDeq4CmvqFF9o3B5abgD62+i5/4xQxw3KMnvmguR8f8i2QCHjSM9Bm+95J5raZb9QETQ7i9Kx2ZYMx0rGJVIs4+wt9KuUcT+3k09gMaHYlm8sORgh7vjMyaX3BmHoLZRzWEm9MRmpc44C5IiHK0ncYNEE2vPuUUxLCrFZTUKsU9bXb7bWMXUOJrkpAfR/oDSDExGI11yJWW5Iq/Ia7V5yFrLSHg7JdzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT/VYuXqeUYLrzyhVy7IjpGhPZrQPuMYrz5cV9uxhZs=;
 b=aRjESyMq3C5Kaa8F1ztswT1mb//Hw3RJYCihKr1StpK94/Mg6NgB3Dl+0XBKaYTIv0H6h2RK3l6Jxmn4/q13hcySHE/25DI+bRYIATwWlmOpIg92O9OPujJ/dNo4YPkt7LFX/r+zuPafzEt7+exYF62PQIYjVZhB5OnjA0D+9E1GACZ+pxCRuh9fY0uGR52abTvop3bIr6tWaYOgWwFNDgNXyfyyJ5AGy3SEVkdim+XEt/xUz1WpWiQdIgmqgsf67LngK6VbNEwVlHKxYU/zPiEJMQPhol7QdQ47ZV7dwg8tjKqRL+a0xNx7TTfmnMToN0xCbuv6Zj07egFWFsi7tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BLAPR03MB5634.namprd03.prod.outlook.com (2603:10b6:208:285::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 02:55:03 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 02:55:03 +0000
Message-ID: <b0a3ab80-2324-4e2e-8e4c-eab7ce3430fa@altera.com>
Date: Thu, 7 May 2026 10:54:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ddr: socfpga: Add ECC DRAM scrubbing support for
 Gen5/Arria10
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Brian Sune <briansune@gmail.com>,
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>
References: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
 <20260428033230.7777-4-alif.zakuan.yuslaimi@altera.com>
 <2880c529-5740-40b4-bb98-aa471f0c628f@altera.com>
 <7f81aed4-16e9-429d-a1ce-5ef60da00b01@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <7f81aed4-16e9-429d-a1ce-5ef60da00b01@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|BLAPR03MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a3fd23-5159-44c1-8d74-08deabe407a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|55112099003|13003099007|56012099003;
X-Microsoft-Antispam-Message-Info: idOqGZr+Xor7F0aPieFwXuZ7nrTSZr4GBTw1IVzaVS/+vmQ2ztvelzm1l9eQu7+YXr1v0yBnTPNBFFLbL/lFy4qmn2Hfd2VsPNkdPEVi2cN2Q1yOW4genGuFW3DUvUZ7pknMeCZ4kcCA+AwkRT/fbLFMlehut0pQksG9HAKJvny3NDqLtSjU1Ggq/Qo+Co80URiILQ/mBS3OObAkIXJhDf7JHCCIkWvPNjG0HWMZKtdgRQH5KLnPu2x+pHZJe2vIuAmifr3iDdU6oeKE8ZxqsFDONx4MbZ+aSEtQ6PgaOswAH0UwA6287HIM8F7+WI9iWqsinqbKz6dzGBFF5iNM9PflJvHv2wdxNT/PuO1IoFdhR4VKiuqlKiaBVlZUW27gJfS/2lVxzwj6IpG+seCXdzWTwjP1qYgPX9uMf/Bw/gyBSenMHq8HwU5NvN0wqrTXURG+WCbLUY7Yphvq6QXz5DyHkeUTVBl3BnRVdY+Jvn4jIGPiDwlTX8x4nRL5SzM/O4OxiqQlA24Zmh9hogEa3Gqj7LhkLWSDD+I92wz4ZPJUDvtRPuPVR/c60QBcT6hBZoJ0isL1UZ/VYonjzEaz6EEBnw9h1LEnrL7QWzn67V6AOZV4ASr670PixAxF+bQJ3CgCqih3TajkEpTv0Gkhaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(55112099003)(13003099007)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zmh4ZE5abHQwdzJod0JYL1pqbkpaQ1lqcy9ReXZOVW9KNUhQbTBaK1Q2TlZx?=
 =?utf-8?B?NFpkai9uNGJiaEV0emZSaHBiTDZjZUlaT3ROV1NVMjRRY3BwNHJVQm1xMkZt?=
 =?utf-8?B?T1loUmlqbXV0Q2g3TEFKYWo5b0xtZXBLUm00djBzamNrbXQ4TWxTY2ovdU1D?=
 =?utf-8?B?Wkd5MDdsMC8zN3kwaENJTCtKZXluckk2Y3BkazRHNThvVWFkK2tkaFJvMDdw?=
 =?utf-8?B?dm83U05uNGdhYjJBNkdtKzlwcGdVR3Y0bVZDZmJBN0htZkV1YjlTa1pxTzNG?=
 =?utf-8?B?dlY1OWIxeXh0ekV6UHMyUXBlN080ZHJNRUhRVjZ5cDJIb2xwWndxWjZDeVFV?=
 =?utf-8?B?b3lpT2ovZnM4WmhlaE1VU1hLb24zTjVhN2xwSlM4WXBBUW9qUnB5LzRFTWc0?=
 =?utf-8?B?OTM3b09MdjNVU2tmMldLcnY4RGhBL2Q2MFBtVVIvUTBMb2ZWZmJleGpWKytY?=
 =?utf-8?B?ek9qVFJ5d2FibmcxSG5WbGpzMUUzWjBGMzVOSUVhd2FaUGdRRW8vMkRRbzkw?=
 =?utf-8?B?aHZTZ1RPWThUb1lGNUFwS0tKaVJOaURSbHRETkJiWExjbG1UZ0pjaUNMaTd3?=
 =?utf-8?B?aGVpSUdKWVpiNWxWVkNZR1RzemQzWmVHQ29QRno3Z3ZzWXpGTjhlSXRvL2FK?=
 =?utf-8?B?b3lMOUllTUJESUxzZDdVWGtTQ2J5eExhekdlSkp3MTh0WnhXU1ZsZGh4c0xo?=
 =?utf-8?B?WDdRRk5hOFQyRnFqQ0ZNYjhxZUdPalFEREtFejR6TGdEdUNIY2tVS2JHWVNl?=
 =?utf-8?B?KzhsUFB0MU1BcXNnd2gzNXppOXdxb09nOExrWTVxRUVBeHBRbWoya0M2SHZ0?=
 =?utf-8?B?R1lJbzUwb2V1M1ZXQ1Q4YjRGVi8xbkFkamdFcFIyOVREeHByMjRIUml4Vi9W?=
 =?utf-8?B?ek5iN3Z2TVc3cWprQit5bnJjWHVmdkVxd2RhMWs4d09nN2pkU2lCdGNkSzRy?=
 =?utf-8?B?bFhqVHlkNFE3ZUNKTThUaGF2dkJmdWZpbExFYS9vTjNINnpyS3hZdE04bDJq?=
 =?utf-8?B?YmdNS2JGclVtRW5DV0JzS2NqN2h0aDN4Sjg2QmxRRjRzVXRrUk9NYWhQZlBa?=
 =?utf-8?B?ZGRWOEtmUDZISDF6M0dBcDlQQ3I0SFNoZm5ramc1bXdvbkxsSkNWNDJ1MXhQ?=
 =?utf-8?B?SWp6ZEFBY2RKVjdGYTg5a3p3NGFTV01KTkNDNXhab1ZId1hlZ0xKNmkrWnNa?=
 =?utf-8?B?VURmSkZId01aK210N1JFaSs4bDlMN3k1RzNhRlpycldNTGRMOVdic01lOGhJ?=
 =?utf-8?B?Y1JnU3d2MStaQUtFYzVUc0liNHkza3RWZnhMN3RGVnFCNXNvNTgzZVNGMFY5?=
 =?utf-8?B?N0dzUWhmL1JWNnlKemFBWkNUM2IyWWhGRnNpRDd5WGNNZjduL1lGL3BINUVV?=
 =?utf-8?B?YW1XOWdsUEZvRTJMdXQ0eUEwam1TT0lBa0plblZtY1VlQnRGMGovc3dWSElD?=
 =?utf-8?B?TCtWbVk3YW5WUFNDT25LUHpUUUo4SXJxRVcwUE90THkzNVhiczg5RC90NmR3?=
 =?utf-8?B?VnFsOEpkYjFhTDlxOW04OFpYczJoQnZjbUdHeDVXK0NyWXlYYXliLzRPWGEy?=
 =?utf-8?B?NXZlbHJoeStheUhkQ0krcUtabnJuczBDUUxBZ1NTaEhnQmtPK3g4RWEvVjlR?=
 =?utf-8?B?Rk1wN3dUY1NNdXhRMUpibFIyS25pNVI0emxMQkl0eVJQeUlWRHdodmorMVhl?=
 =?utf-8?B?d2dtM0xMTmFCMWJLY2tWY0psN1JjVjBrU0ozRkpPcEwwN3hPdXVVWVljRGlU?=
 =?utf-8?B?RVBoQkNpaGVWZDRYT3VCTC85RG9RS3pDMTRCZWc5RTlZMTlnMytCVWhOR2h2?=
 =?utf-8?B?Yld0TTM5ZWt6REYyVkcxRWllYTFrQVhycVZTQU1NYVlBNmRrUUdJVFI3Wk5Q?=
 =?utf-8?B?TXVmQXpveFdYd2tsbHh0WWxvUE5zeTJJTXVETXZCM1Q1cVZyRFRqSFdwZ3NW?=
 =?utf-8?B?K1JPL2Z1SmFLVUM0cTRyMk1RaXc0RFEvbWJYT0poM3V6eGFVMXNDMVkwbE5L?=
 =?utf-8?B?VFpNSFEyN1BjT0ZpaXhRUCszSStmaENVUzBNdk1MREJKZXB2Znp5cGdGR00y?=
 =?utf-8?B?SUV6eGhJMmE5L0JINUh3N1B1RUlJdWZmczQ0b3J0c2x3QXdZdzFTWlJiUkZj?=
 =?utf-8?B?MWdQc3VVSDdQem9wUS9oSlF5d25tRkZkRzhabUdJZ2NVWmZuY1ZrWTZzaXMy?=
 =?utf-8?B?SGRTNGszSmF6Ui8yK1VUVi92RXduWEZsSS9FY3RiM3dvREQ1ZlNYQXpBTHNv?=
 =?utf-8?B?LzI3ZnQ5aDFmUEdTS1hjYmhidzJoNEhJZmNtNmMzV1g4NFFSbWNGSHhBVVBF?=
 =?utf-8?B?VU5JY0VnL3FuR2Z4c1B2c01vMFZBRFloSGRUU1dPNE9ndEV1Y1ZGcFA1Q2dH?=
 =?utf-8?Q?dPqWyWaVM4VGYjVM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a3fd23-5159-44c1-8d74-08deabe407a2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 02:55:03.0971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8tq8apXLT8SxEFz5uQqVjVv+St+080xHURkpsclhf4Ftmm3DtW9rZgMOdoCnmc/lq4NC1BkZrTtxe/2DKZNztX/aRzs4SbJGfrttxw+zdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5634
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

Hi Alif,

On 6/5/2026 1:19 pm, Yuslaimi, Alif Zakuan wrote:
> Hi Tien Fong,
>
> On 5/5/2026 2:54 pm, Chee, Tien Fong wrote:
>> Hi Alif,
>>
>>
>> On 28/4/2026 11:32 am, alif.zakuan.yuslaimi@altera.com wrote:
>>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>>
>>> The SDRAM must first be rewritten by zeroes if ECC is used to 
>>> initialize
>>> the ECC metadata. Make the CPU overwrite the DRAM with zeroes in such a
>>> case.
>>>
>>> This implementation turns the caches on temporarily, then overwrites 
>>> the
>>> whole RAM with zeroes, flushes the caches and turns them off again.
>>> This provides satisfactory performance.
>>>
>>> Move common code sdram_init_ecc_bits() to new common file 
>>> sdram_soc32.c.
>>> Preparation for Gen5 uses the same memory initialization function as
>>> Arria10.
>>>
>>> New Kconfig is introduced to enable this implementation only on the 
>>> default
>>> Arria10 and CycloneV boards as this will increase the SPL size which
>>> will exceed some Gen5 devices' SPL size limit.
>>>
>>> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
>>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>> ---
>>>   arch/arm/mach-socfpga/Kconfig      | 13 ++++-
>>>   arch/arm/mach-socfpga/spl_a10.c    |  4 ++
>>>   arch/arm/mach-socfpga/spl_gen5.c   | 17 ++++++
>>>   drivers/ddr/altera/Makefile        |  4 +-
>>>   drivers/ddr/altera/sdram_arria10.c | 34 +++++-------
>>>   drivers/ddr/altera/sdram_gen5.c    | 41 ++++++++++++--
>>>   drivers/ddr/altera/sdram_soc32.c   | 85 
>>> ++++++++++++++++++++++++++++++
>>>   drivers/ddr/altera/sdram_soc32.h   | 15 ++++++
>>>   8 files changed, 187 insertions(+), 26 deletions(-)
>>>   create mode 100644 drivers/ddr/altera/sdram_soc32.c
>>>   create mode 100644 drivers/ddr/altera/sdram_soc32.h
>>>
>>> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/ 
>>> Kconfig
>>> index 830585a72cc..dd71691b724 100644
>>> --- a/arch/arm/mach-socfpga/Kconfig
>>> +++ b/arch/arm/mach-socfpga/Kconfig
>>> @@ -6,6 +6,13 @@ config ERR_PTR_OFFSET
>>>   config NR_DRAM_BANKS
>>>       default 1
>>> +config SOCFPGA_ECC_SUPPORT
>>> +    bool "Enable ECC support for DRAM"
>>> +    help
>>> +     Adds CPU-based ECC support for DRAM at boot. This will initialize
>>> +     all DRAM ECC metadata to zero, preventing false ECC errors and
>>> +     improving reliability.
>>> +
>>>   config SOCFPGA_DRAM_SIZE_CHECK
>>>       bool "Enable DRAM size checking for safety"
>>>       help
>>> @@ -105,6 +112,7 @@ config ARCH_SOCFPGA_ARRIA10
>>>       select ETH_DESIGNWARE_SOCFPGA
>>>       imply FPGA_SOCFPGA
>>>       imply SPL_USE_TINY_PRINTF
>>> +    select SOCFPGA_ECC_SUPPORT
>>>   config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
>>>       bool "Always reprogram Arria 10 FPGA"
>>> @@ -117,6 +125,9 @@ config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
>>>   config ARCH_SOCFPGA_CYCLONE5
>>>       bool
>>>       select ARCH_SOCFPGA_GEN5
>>> +    select SOCFPGA_ECC_SUPPORT if \
>>> +      !TARGET_SOCFPGA_TERASIC_SOCKIT && !TARGET_SOCFPGA_EBV_SOCRATES \
>>> +      && !TARGET_SOCFPGA_SOFTING_VINING_FPGA
>>>       select SOCFPGA_DRAM_SIZE_CHECK if 
>>> !TARGET_SOCFPGA_TERASIC_SOCKIT \
>>>         && !TARGET_SOCFPGA_EBV_SOCRATES && \
>>>         !TARGET_SOCFPGA_SOFTING_VINING_FPGA
>>> @@ -124,7 +135,7 @@ config ARCH_SOCFPGA_CYCLONE5
>>>   config ARCH_SOCFPGA_GEN5
>>>       bool
>>>       select SPL_ALTERA_SDRAM
>>> -    select SPL_CACHE if SPL
>>> +    select SPL_CACHE if SPL && SOCFPGA_ECC_SUPPORT
>>>       imply FPGA_SOCFPGA
>>>       imply SPL_SIZE_LIMIT_SUBTRACT_GD
>>>       imply SPL_SIZE_LIMIT_SUBTRACT_MALLOC
>>> diff --git a/arch/arm/mach-socfpga/spl_a10.c 
>>> b/arch/arm/mach-socfpga/ spl_a10.c
>>> index c20376f7f8e..4d0696bbaf6 100644
>>> --- a/arch/arm/mach-socfpga/spl_a10.c
>>> +++ b/arch/arm/mach-socfpga/spl_a10.c
>>> @@ -25,6 +25,7 @@
>>>   #include <asm/sections.h>
>>>   #include <fdtdec.h>
>>>   #include <watchdog.h>
>>> +#include <wdt.h>
>>>   #include <asm/arch/pinmux.h>
>>>   #include <asm/arch/fpga_manager.h>
>>>   #include <mmc.h>
>>> @@ -265,6 +266,9 @@ void board_init_f(ulong dummy)
>>>       /* Configure the clock based on handoff */
>>>       cm_basic_init(gd->fdt_blob);
>>> +    if (CONFIG_IS_ENABLED(WDT))
>>> +        initr_watchdog();
>>> +
>>>   #ifdef CONFIG_HW_WATCHDOG
>>>       /* release osc1 watchdog timer 0 from reset */
>>>       socfpga_reset_deassert_osc1wd0();
>>
>>
>> Why not remove this?
>>
>>
> Thanks for pointing this out. I must have missed this out for Arria10.
> I will remove this in v3.
>
>>> diff --git a/arch/arm/mach-socfpga/spl_gen5.c 
>>> b/arch/arm/mach-socfpga/ spl_gen5.c
>>> index 08b756db2ca..530863b1564 100644
>>> --- a/arch/arm/mach-socfpga/spl_gen5.c
>>> +++ b/arch/arm/mach-socfpga/spl_gen5.c
>>> @@ -6,6 +6,7 @@
>>>   #include <hang.h>
>>>   #include <init.h>
>>>   #include <log.h>
>>> +#include <asm/global_data.h>
>>>   #include <asm/io.h>
>>>   #include <asm/utils.h>
>>>   #include <image.h>
>>> @@ -21,9 +22,17 @@
>>>   #include <debug_uart.h>
>>>   #include <fdtdec.h>
>>>   #include <watchdog.h>
>>> +#include <wdt.h>
>>>   #include <dm/uclass.h>
>>>   #include <linux/bitops.h>
>>> +DECLARE_GLOBAL_DATA_PTR;
>>> +
>>> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT) || \
>>> +    IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>>> +static struct bd_info bdata __attribute__ ((section(".data")));
>>> +#endif
>>> +
>>>   u32 spl_boot_device(void)
>>>   {
>>>       const u32 bsel = readl(socfpga_get_sysmgr_addr() +
>>> @@ -106,6 +115,9 @@ void board_init_f(ulong dummy)
>>>       if (cm_basic_init(cm_default_cfg))
>>>           hang();
>>> +    if (CONFIG_IS_ENABLED(WDT))
>>> +        initr_watchdog();
>>> +
>>>       /* Enable bootrom to configure IOs. */
>>>       sysmgr_config_warmrstcfgio(1);
>>> @@ -143,6 +155,11 @@ void board_init_f(ulong dummy)
>>>       /* enable console uart printing */
>>>       preloader_console_init();
>>> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT) || \
>>> +    IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>>> +    gd->bd = &bdata;
>>> +#endif
>>> +
>>>       ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>>>       if (ret) {
>>>           debug("DRAM init failed: %d\n", ret);
>>> diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
>>> index 8259ab04a7e..ece6a131897 100644
>>> --- a/drivers/ddr/altera/Makefile
>>> +++ b/drivers/ddr/altera/Makefile
>>> @@ -7,8 +7,8 @@
>>>   # Copyright (C) 2014-2025 Altera Corporation <www.altera.com>
>>>   ifdef CONFIG_$(PHASE_)ALTERA_SDRAM
>>> -obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
>>> -obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += sdram_arria10.o
>>> +obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += sdram_soc32.o sdram_gen5.o 
>>> sequencer.o
>>> +obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += sdram_soc32.o sdram_arria10.o
>>>   obj-$(CONFIG_ARCH_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
>>>   obj-$(CONFIG_ARCH_SOCFPGA_AGILEX) += sdram_soc64.o sdram_agilex.o
>>>   obj-$(CONFIG_ARCH_SOCFPGA_N5X) += sdram_soc64.o sdram_n5x.o
>>> diff --git a/drivers/ddr/altera/sdram_arria10.c 
>>> b/drivers/ddr/altera/ sdram_arria10.c
>>> index c281f711fdf..09d3526603e 100644
>>> --- a/drivers/ddr/altera/sdram_arria10.c
>>> +++ b/drivers/ddr/altera/sdram_arria10.c
>>> @@ -22,9 +22,13 @@
>>>   #include <linux/bitops.h>
>>>   #include <linux/delay.h>
>>>   #include <linux/kernel.h>
>>> +#include <linux/sizes.h>
>>> +#include "sdram_soc32.h"
>>>   DECLARE_GLOBAL_DATA_PTR;
>>> +#define PGTABLE_OFF    0x4000
>>
>>
>> Dead code, remove PGTABLE_OFF, only sdram_soc32.c uses it
>>
>>
> Sure, I will clean this up in v3.
>
>>> +
>>>   static void sdram_mmr_init(void);
>>>   static u64 sdram_size_calc(void);
>>> @@ -193,24 +197,6 @@ static int sdram_is_ecc_enabled(void)
>>>             ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK);
>>>   }
>>> -/* Initialize SDRAM ECC bits to avoid false DBE */
>>> -static void sdram_init_ecc_bits(u32 size)
>>> -{
>>> -    icache_enable();
>>> -
>>> -    memset(0, 0, 0x8000);
>>> -    gd->arch.tlb_addr = 0x4000;
>>> -    gd->arch.tlb_size = PGTABLE_SIZE;
>>> -
>>> -    dcache_enable();
>>> -
>>> -    printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
>>> -    memset((void *)0x8000, 0, size - 0x8000);
>>> -    flush_dcache_all();
>>> -    printf("DDRCAL: Scrubbing ECC RAM done.\n");
>>> -    dcache_disable();
>>> -}
>>> -
>>>   /* Function to startup the SDRAM*/
>>>   static int sdram_startup(void)
>>>   {
>>> @@ -735,8 +721,16 @@ int ddr_calibration_sequence(void)
>>>       if (of_sdram_firewall_setup(gd->fdt_blob))
>>>           puts("FW: Error Configuring Firewall\n");
>>> -    if (sdram_is_ecc_enabled())
>>> -        sdram_init_ecc_bits(gd->ram_size);
>>> +    if (sdram_is_ecc_enabled()) {
>>> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>>> +        sdram_init_ecc_bits();
>>> +    }
>>> +#else
>>> +        puts("DDR: Enable CONFIG_SOCFPGA_ECC_SUPPORT when SDRAM ");
>>> +        puts("ECC is enabled.\n");
>>> +        hang();
>>> +    }
>>> +#endif
>>
>>
>>   confusing pattern, moves the } outside the preprocessor block 
>> entirely to here
>>
>>
> Thanks for the suggestion, I will implement this in v3.
>
>>>       sdram_size_check();
>>> diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/ 
>>> sdram_gen5.c
>>> index 1c3c70ea8ae..76effb264e2 100644
>>> --- a/drivers/ddr/altera/sdram_gen5.c
>>> +++ b/drivers/ddr/altera/sdram_gen5.c
>>> @@ -2,6 +2,7 @@
>>>   /*
>>>    * Copyright Altera Corporation (C) 2014-2015
>>>    */
>>> +#include <cpu_func.h>
>>>   #include <dm.h>
>>>   #include <errno.h>
>>>   #include <div64.h>
>>> @@ -19,8 +20,11 @@
>>>   #include <asm/global_data.h>
>>>   #include <asm/io.h>
>>>   #include <dm/device_compat.h>
>>> -
>>> +#include <linux/sizes.h>
>>>   #include "sequencer.h"
>>> +#include "sdram_soc32.h"
>>> +
>>> +#define PGTABLE_OFF    0x4000
>>
>>
>> Dead code, remove PGTABLE_OFF, only sdram_soc32.c uses it
>>
>>
> I will clean this up in v3.
>
>>>   #ifdef CONFIG_XPL_BUILD
>>> @@ -566,6 +570,19 @@ static unsigned long 
>>> sdram_calculate_size(struct socfpga_sdr_ctrl *sdr_ctrl)
>>>       return temp;
>>>   }
>>> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>>> +static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
>>> +{
>>> +    return !!(readl(&sdr_ctrl->ctrl_cfg) &
>>> +          SDR_CTRLGRP_CTRLCFG_ECCEN_MASK);
>>> +}
>>> +#else
>>> +static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
>>> +{
>>> +    return 0;
>>
>>
>> 4 spaces (WRONG, should be \t)
>>
>> ERROR: code indent should use tabs where possible from checkpatch
>>
>>
> I must have missed this checkpatch error. Thanks for pointing this 
> out. I will clean this up in v3.
>
>>> +}
>>> +#endif
>>> +
>>>   static int altera_gen5_sdram_of_to_plat(struct udevice *dev)
>>>   {
>>>       struct altera_gen5_sdram_plat *plat = dev_get_plat(dev);
>>> @@ -608,10 +625,13 @@ static int altera_gen5_sdram_probe(struct 
>>> udevice *dev)
>>>       sdram_size = sdram_calculate_size(sdr_ctrl);
>>>       debug("SDRAM: %ld MiB\n", sdram_size >> 20);
>>> -#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>>> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK) || \
>>> +    IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>>>       /* setup the dram info within bd */
>>>       dram_init_banksize();
>>> +#endif
>>> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>>>       if (sdram_size != gd->bd->bi_dram[0].size) {
>>>           printf("DDR: Warning: DRAM size from device tree (%lu 
>>> MiB)\n",
>>>                  (ulong)(gd->bd->bi_dram[0].size >> 20));
>>> @@ -626,8 +646,23 @@ static int altera_gen5_sdram_probe(struct 
>>> udevice *dev)
>>>       }
>>>   #endif
>>> +    if (sdram_is_ecc_enabled(sdr_ctrl)) {
>>> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>>> +        /* Must set USEECCASDATA to 0 if ECC is enabled */
>>> +        clrbits_le32(&sdr_ctrl->static_cfg,
>>> +                 SDR_CTRLGRP_STATICCFG_USEECCASDATA_MASK);
>>> +        sdram_init_ecc_bits();
>>> +#else
>>> +        puts("DDR: Enable CONFIG_SOCFPGA_ECC_SUPPORT when SDRAM ");
>>> +        puts("ECC is enabled.\n");
>>> +        puts("DDR: Without scrub, false ECC errors may occur.\n");
>>> +        hang();
>>> +#endif
>>> +}
>>
>>
>> WRONG, should be \t
>>
>>
> I wil clean this up in v3.
>
>>> +
>>>       /* Sanity check ensure correct SDRAM size specified */
>>> -#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>>> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK) || \
>>> +    IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>>>       if (get_ram_size(0, gd->bd->bi_dram[0].size) !=
>>>           gd->bd->bi_dram[0].size) {
>>>   #else
>>> diff --git a/drivers/ddr/altera/sdram_soc32.c b/drivers/ddr/altera/ 
>>> sdram_soc32.c
>>> new file mode 100644
>>> index 00000000000..7556d4933f4
>>> --- /dev/null
>>> +++ b/drivers/ddr/altera/sdram_soc32.c
>>> @@ -0,0 +1,85 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
>>> + */
>>> +
>>> +#include "sdram_soc32.h"
>>> +#include <string.h>
>>> +#include <hang.h>
>>> +#include <linux/sizes.h>
>>> +#include <cpu_func.h>
>>> +#include <watchdog.h>
>>> +#include <wait_bit.h>
>>
>>
>> Unused header
>>
>>
> This header file is needed for get_timer() function declaration. 
> Removing this header will cause compilation failure.


OK


>
>>> +#include <asm/global_data.h>
>>> +#include <asm/system.h>
>>
>>
>> Unused header, please check!
>>
>>
> This header file is needed to define PGTABLE_SIZE.
> Removing this header will cause compilation failure.


OK


>
>>> +#if !defined(CONFIG_HW_WATCHDOG)
>>
>>
>> #if !IS_ENABLED(CONFIG_WATCHDOG)


i think reset_manager.h is included to support socfpga_per_reset, using 
this,

#if !IS_ENABLED(CONFIG_WATCHDOG) && !CONFIG_IS_ENABLED(WDT)


>>
>>
>>> +#include <asm/arch/reset_manager.h>
>>> +#endif
>>> +
>>> +DECLARE_GLOBAL_DATA_PTR;
>>> +
>>> +#define PGTABLE_OFF    0x4000
>>> +#define PGTABLE_RESERVE (PGTABLE_OFF + PGTABLE_SIZE)
>>> +
>>> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>>> +static void socfpga_prepare_watchdog_for_long_op(void)
>>> +{
>>> +#if !IS_ENABLED(CONFIG_WATCHDOG)
>>
>>
>> #if IS_ENABLED(CONFIG_WATCHDOG) || IS_ENABLED(CONFIG_WDT)
>>
>>
> Shouldn't it be "#if !IS_ENABLED(CONFIG_WATCHDOG) || 
> !IS_ENABLED(CONFIG_WDT)" instead? This is for no DM watchdog enabled 
> scenario.


Yes for no watchdog enabled scenario, it should be


#if !IS_ENABLED(CONFIG_WATCHDOG) && !CONFIG_IS_ENABLED(WDT)
     /*
      * No watchdog driver is active in U-Boot. The bootrom or a
      * previous boot stage may have left L4WD0 running. Assert and
      * deassert its reset to stop it before the long ECC scrub,
      * preventing a spurious watchdog reset during DDR init.
      */
     socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
     socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
#endif


>
>>> +    /*
>>> +     * No DM watchdog support enabled. Previous boot stage may have 
>>> left
>>> +     * L4WD0 running, so stop it once before long DDR scrub operation.
>>> +     */
>>> +    socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
>>> +    socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
>>> +#endif
>>> +} 


Best regards,

Tien Fong

