Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960F3CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 05:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 469DB8480B;
	Wed,  6 May 2026 07:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Y6SnyUcf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C89758480B; Wed,  6 May 2026 07:51:16 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90A8C84807
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 07:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwwL83roxdTDwMpWI7HEze3uuSsloOMBhAD3Rk1iMyfspfnTkDyh+xEuj059Dq/uZqN35MQ+SgQipLtyAcfiQxnd/o4nsQ+1w4h5VC1XFH1T3Sh2zMywhds5O5hJvr/BTyMtNMlAa4DBHF/63S6AYoqmIGYuasakNFhGA91pHrv6zN+5w+RDAO7YoXRBBdKVpxgQt0kM6TJn3Qtk3ym2vPHgE2ML1S7+zcwtYQtyibe98vJX9V3DiFUCnnMQIrxGMErdHPDL3z6RXxuve2Ppj/1H9pKxqd3ogoXGAEFYaxTctwB9auaptKTqpLmWYK0CZp0AVm5O+DIH7MquZPvA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72bIY1c07h8q8ju7HqM8aSDG+sfZ0hQW8sSQ11D3uZY=;
 b=wO03kBXx/GVgrzGmrwBK9yDpC4lUjBBSj6rA/CXxDukYYHJiGatJ8FjPRFA9ThUD4MJ9kSDGN84hn2G+rvfsLeQQZb5dOCG1GQr5lGULTN9lBcdn7E44ZQGz6BPE1EfxSO541eWZkg6O+uoGfXZXW1JQLn8G5iLqilsELEZz1EqCwUrzRtWvUFe91jhbgOhIDEGBhkg5B7vlJRYt6JsVAkAWnUIsnVgenfvB79DRcMvvuYWFtEaLEDaEj1zVqvB0AE8I0PH8CP7n8YEpBimJeSO2orD75OYFzrJn86g0qo5jJlcYADmTFYSoMbkoLHQYInLOa1ukuNJiLBj8MaTvdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72bIY1c07h8q8ju7HqM8aSDG+sfZ0hQW8sSQ11D3uZY=;
 b=Y6SnyUcfGPmcwijHo6FOnImR9/c1UW9r7FwjGyk2Ytd7x+c3H9trGzCPG9Qn5tHtwo3PrbLhZ2zavkXYNbigG42rA95FgP1vkqdKthCaJuaqK6IHhJzKqoMjufwnVxup6iAY/VrS40DyzWw0bZpkG9H//cDYk/yztd+eDKyGLEh8hpxT6V/gT+VfZ7/b6N89s9uyALiO4z+YOSLreTH5WRP/zO8Yssz3INZ6SrntT5m74CJ4B5RlLyWb0GPjkKRiQXWs5r+KxZMlB/jBDAOniQiqQA88b5zHtWwvsK/T2IzZqFliMUKnNbqEvJx50sLLWz7Episr1IRugg2mrD/M8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA0PR03MB5644.namprd03.prod.outlook.com (2603:10b6:806:b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 05:51:12 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 05:51:11 +0000
Message-ID: <074fcd82-42a3-43e6-970d-4844b5239dd8@altera.com>
Date: Wed, 6 May 2026 13:51:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ddr: altera: gen5: Add DRAM size checking
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Brian Sune <briansune@gmail.com>,
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>
References: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
 <20260428033230.7777-3-alif.zakuan.yuslaimi@altera.com>
 <054e0e7f-1f32-4370-a753-5193c8511509@altera.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <054e0e7f-1f32-4370-a753-5193c8511509@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA0PR03MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: 172b3d58-1c5b-41e2-0e38-08deab337a3a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: egOoS8v3auruqvAb4olVF7Kf/rKcSv1RYo97QJOmiAHrLDGG441V/mO+4j7G65sd52wZz25+xRe/9/0qu6w+xflxREiZ5ng1IwfckaOsXr4PV+uPlF/2szb8WFGqcEN1jFb8gAJ532N54fiYcUjYf1r2Za2jP8cLuLMzw6oFSpnqvgHyT0ovLtcZareXKDMIkW8LG4FJspXOpsLynZBHF6YgoQOc3P1QyxDT06hd5/RUa0UNxcaiTKY8lbMPl8b/1NYoyrjgD10FPoI+rLKyjQHW8KnIgXH/n8mwEzx9ruj8uVljRgVYK+JL+qm3EqhTP4hY1A/kbGz5MEXGvpm5giC6s4k1aQIWNy5VtGipl7r3ES3nY5IRWGn6O0Rny9qhalfD6R+hcNujqXOe+7XsbGp3fjnMQlVe1ebuE7qijgeTWjfxxQs6cIwPAVPMQSFcNBJNBMBeRi6tPdV6X5+DorDBld3fvsoDptRiPxmlzyzKl8fJuhgVIQpP+nhFsiBFDm2ZvXvuRmnP6Lpt6VGXsoxIK9JL/Zwrz3A+p7qo3/3hp+9SU6VD2LbIJmp5sXKNIh0W/hqTNH4Rvg8Gu5GQ63/xSfrbTQH7I7JMSg3eRDx8aB/47QSSos4ITxXh8UkQ8W6cocRh4KwDGl/GsY51cWR1VVOq3aQSL9tIXBIp+a5hNW2wG1s7H0v4jx87HxaQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmV3QmdSZ3lIUlJHb0lzbDdaOURPclZod2dDbzlYaGJrejZLeUFoSHJaWjA2?=
 =?utf-8?B?QlNJM1hNeWU0QXFVTG50N1loTXdnVlh6R0ZMcGZHK2xIbERyaWFPY0V0bm9v?=
 =?utf-8?B?RDV5TWhTdmF1OEMrUWZ4YXRVQlhYYmhKUVNBclJCbE5WT3F2MmhLZFo5VHBK?=
 =?utf-8?B?VHVkT3dtS21HaGZMZ1F0MzlGSUIxZXRpNDVmdmVhYUxUaEpwcVhERWI5RVps?=
 =?utf-8?B?WVloQ2x6WFhHMkRSRUE5SHNJU3lManhQaVdYUzh5RzgyZUlzU3J6NmQ4c1pV?=
 =?utf-8?B?eFVMMllDUHZxcU8xdFNiQjk5b1A0ZDNNRm0ybE8zb3dWUU8zUE44aTBaMTg0?=
 =?utf-8?B?bVA3WVFLKy8zL3ZWUnJDajViRkhURGkyRm8reGgySUVOeTVHY2xRRUtmMUUw?=
 =?utf-8?B?dk1JYWU2S1g0dnlzUTBqR0hzSDk2YVFENHlRWGtZWi9XQTVmUkZNc2RXRHB2?=
 =?utf-8?B?R3dubmZmVlVJa1h5bHkyaEJ0UHNyYktVK1lPbGlOcExuai93dzF2SmdSYm9P?=
 =?utf-8?B?bVZmMkFUNmt0VmV3SVFCWmJ1YXo3aERReUxUQ3MwZ2c0OXBaZ2NEd2lVbG1y?=
 =?utf-8?B?MnhRN1hDcURxMURORDZYR1pOSXpoVXNmT0tKMkNoOHJENEVFbWEzWmtwK1g1?=
 =?utf-8?B?SkVWNHc2cFBySW9Fc20rcnBicW1GQTcvWDA4ZWdDdEp5S0Q2NWhWQjh4NnVm?=
 =?utf-8?B?aXBSNzBEUWt2dzQxZnkxK1M5dklEMkJPYnNDQTdiS3FTODR3cllXa2JoM3o4?=
 =?utf-8?B?b2UzNjZqRHBFelEzbkgyTEx4eXRXM0J3QktCd0RBcWNEQi9VTy91a3BKN3Nu?=
 =?utf-8?B?Zk1EMXIrVk5wcWJrWFk5SEFLRks5U3ZQRUdJd1d1VHM3ZnlPRVJna0pZNjg3?=
 =?utf-8?B?dzNCdHJkQzJvYVZEUWJ4Vy9TRDV1Rm1laEx1T3VITW1XZk1XRURnYmdFeWRG?=
 =?utf-8?B?SVA4ZDNXYmEzZGJicGhPY1NObDF6SnRjNjdlbEY0TE9rOUI2c0FaM0UrMS83?=
 =?utf-8?B?VHhSUTF3OEhmSEhqUWRJeHEvc1Z5Mk0wNFFIM0dTMmNrQmdmdjRpeUorUCtB?=
 =?utf-8?B?QUFQd1IvNUpTdDdaTlIrNDRPcUg4UEpVU3Z3dnZPNUVnR0IxSU4zTWIweEg5?=
 =?utf-8?B?SlVLR0JGbC9uUjZ2WmxscS9KNDRnRDRsdExMdnF6cDdrYWxyNnE5cHM5ZlNj?=
 =?utf-8?B?bi9yQjR3dlhDTG96NFMvV25xVks5UnBZeitqaG5pZXB3dExKRDBsUmUzem9F?=
 =?utf-8?B?K0hYQlR0bTFHZEh2dlFONEY0Q0RzRGpzNWJrTE9Lak8wc1RRcW53L0tiMlc3?=
 =?utf-8?B?WmI3ZHU2UUtZSFhkdzdLNVg3a21Ma1poOE5JeExzakhmK0ZBbE45ejV3SjF4?=
 =?utf-8?B?Wm5nbUYwazFVVEZyb0RCV2NUTXdVZ01NOFRqYUhuRTIvMnhUODF1ZG42K21T?=
 =?utf-8?B?d0txSVR2WWxGLzh6M0NteS9wQzBEc0ZURnlqTU8zMEl3Vi91clBDSUNrbjEr?=
 =?utf-8?B?eHQxUWFrMEk0cDRBaDgwQ3ZPQjJTdG90R0daQjJDbWo0d3dmWHB1cnU0ZldZ?=
 =?utf-8?B?Q081d1ExVW9lKy9pSG1zR0NYWVRsZXJaZTRwMGpCUEhwanBNNEdXamtuUjNh?=
 =?utf-8?B?R25JNGkwNTBMaXhneVBvSjNLdVVrUUV3MUpBUUowRnIrQTJ1djlpbVJYS09G?=
 =?utf-8?B?SGZ0RllPenhMeDdJMHpIV0lrUk9nSW0velNtZ0RDUDFEUGdGdGFRQU1Oc0NT?=
 =?utf-8?B?Q3Y2V2ZTbXhXNkpPV2JYV3I0TzhWRlBFcHF0T050QUFaY2F3M3RUN09vN0lo?=
 =?utf-8?B?TmJQZ0ZwOTA0TEpjQkFnbWJydFBQQldBSXRoQXE1U1IzcktQeE1zNXl1a1NE?=
 =?utf-8?B?djRSdEt2ZHE2Z1R0YU5USmc4M0RRcFcxcXhpSTFQV1FuSE1VVUwwRXhza0Yy?=
 =?utf-8?B?TVVidnVOZW1qaG1hNm5ZRk02ZjZFcG8raGU3Qkd1VUxwZjBQcitZMlZRbm90?=
 =?utf-8?B?M3FHdTNWR21oN0p1MGFYN1phdm9GUTVpbEowMFVtSzRSeVEreFg2OUpRVEo4?=
 =?utf-8?B?bFBXcHB1ZEZKRnVLNURpNWRCRXBEOEd5WGREc0hkSnd1ZC8wYzBHY1hSeXJQ?=
 =?utf-8?B?UjA3Vzd1TzR6eEV3c2NIMDRJc2N6OUtnTEdNcWF5RjRtRUpCaG16WC85cnFH?=
 =?utf-8?B?QXBxY0FPWkZ5eEJQK1ppckF6bC9YRmNidDZaQm5GUU93eTFLVnA2QTRUL3p4?=
 =?utf-8?B?cksxMUd1aGwvTTBwRTRDdVJ6a1dZZnBJcXFvNVJnUDRPTWk2S1JWVkZKS3Mv?=
 =?utf-8?B?WTByaFR1N3Y0aFdiQk5jM3BEVkxOdTVFM1YwWG41LzVUYmR0cWFOYW1WQnB0?=
 =?utf-8?Q?zG0UkQlpkYUvHTsNULzdkOgh5B03zfcZxa/fw?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172b3d58-1c5b-41e2-0e38-08deab337a3a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 05:51:11.8981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TammiJkK9pVROYmKLPGoUkpsKGR/4v91NsaT7XWn6h9qbUz1I+sf4DLoH2RVMkoN2Ixxx9qixRTzjYWM5MPS8q78UQmc4X428yBR2yAr4CE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5644
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

On 5/5/2026 2:17 pm, Chee, Tien Fong wrote:
> Hi Alif,
> 
> 
> On 28/4/2026 11:32 am, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> Add DRAM size checking compare between size from device tree and actual
>> hardware.
>>
>> Trigger hang if DRAM size from device tree is greater than actual 
>> hardware.
>> Display warning message if DRAM size mismatch between device tree and
>> actual hardware.
>>
>> get_ram_size() uses size from device tree. So, it has consistency with
>> other device families.
>>
>> New Kconfig is introduced to enable this implementation only on the 
>> default
>> CycloneV board as this will increase the SPL size which will exceed some
>> Gen5 devices' SPL size limit.
>>
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>> ---
>>   arch/arm/mach-socfpga/Kconfig   |  9 +++++++++
>>   drivers/ddr/altera/sdram_gen5.c | 27 +++++++++++++++++++++++++++
>>   2 files changed, 36 insertions(+)
>>
>> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/ 
>> Kconfig
>> index e2fdd6bb30f..830585a72cc 100644
>> --- a/arch/arm/mach-socfpga/Kconfig
>> +++ b/arch/arm/mach-socfpga/Kconfig
>> @@ -6,6 +6,12 @@ config ERR_PTR_OFFSET
>>   config NR_DRAM_BANKS
>>       default 1
>> +config SOCFPGA_DRAM_SIZE_CHECK
>> +    bool "Enable DRAM size checking for safety"
>> +    help
>> +     Compares device tree DRAM size with actual hardware. Hangs on
>> +     oversized claim.
>> +
>>   config SOCFPGA_SECURE_VAB_AUTH
>>       bool "Enable boot image authentication with Secure Device Manager"
>>       depends on ARCH_SOCFPGA_AGILEX || ARCH_SOCFPGA_N5X || \
>> @@ -111,6 +117,9 @@ config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
>>   config ARCH_SOCFPGA_CYCLONE5
>>       bool
>>       select ARCH_SOCFPGA_GEN5
>> +    select SOCFPGA_DRAM_SIZE_CHECK if !TARGET_SOCFPGA_TERASIC_SOCKIT \
>> +      && !TARGET_SOCFPGA_EBV_SOCRATES && \
>> +      !TARGET_SOCFPGA_SOFTING_VINING_FPGA
>>   config ARCH_SOCFPGA_GEN5
>>       bool
>> diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/ 
>> sdram_gen5.c
>> index 3c79bb11802..1c3c70ea8ae 100644
>> --- a/drivers/ddr/altera/sdram_gen5.c
>> +++ b/drivers/ddr/altera/sdram_gen5.c
>> @@ -5,6 +5,7 @@
>>   #include <dm.h>
>>   #include <errno.h>
>>   #include <div64.h>
>> +#include <hang.h>
>>   #include <init.h>
>>   #include <log.h>
>>   #include <ram.h>
>> @@ -15,6 +16,7 @@
>>   #include <asm/arch/sdram.h>
>>   #include <asm/arch/system_manager.h>
>>   #include <asm/bitops.h>
>> +#include <asm/global_data.h>
>>   #include <asm/io.h>
>>   #include <dm/device_compat.h>
>> @@ -22,6 +24,8 @@
>>   #ifdef CONFIG_XPL_BUILD
>> +DECLARE_GLOBAL_DATA_PTR;
>> +
>>   struct altera_gen5_sdram_priv {
>>       struct ram_info info;
>>   };
>> @@ -604,8 +608,31 @@ static int altera_gen5_sdram_probe(struct udevice 
>> *dev)
>>       sdram_size = sdram_calculate_size(sdr_ctrl);
>>       debug("SDRAM: %ld MiB\n", sdram_size >> 20);
>> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>> +    /* setup the dram info within bd */
>> +    dram_init_banksize();
>> +
>> +    if (sdram_size != gd->bd->bi_dram[0].size) {
> 
> 
> Building socfpga_cyclone5_defconfig with only patch 2 applied produces a 
> binary that NULL-dereferences in the RAM probe. Not bisect-safe.
> 
> 
> Fix: Move the bdata declaration and gd->bd = &bdata assignment from 
> patch 3 spl_gen5.c into patch 2, making patch 2 self-contained.
> 
> Best regards,
> 
> Tien Fong
> 
Thanks for the suggestion. I will implement this in v3.

Alif

