Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC8BCD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 05:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC624847E1;
	Wed,  6 May 2026 07:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="MTlNhI9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E82198481F; Wed,  6 May 2026 07:05:34 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B38D584704
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 07:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+4ivS5/H2MQVok9vv5z8OXVmvNme5706m91hLVlirTOz7lYzVyu9DZNlR9s3LRnco60af7ecHz7BQyUvLXrwv0DwmGEataGSqRc/iM/TpCmxOBR6cxwE6YfmaK6Ud1AWnq5ljynQXfh58zqk91cHZ1cH+HM96Qv3AjbL6hKgWxepgLkuvB1c4Lcj730m8/fiSiLw6uEttqJamP7n/MtGiE/ys60vouD8qxs5OS12JgiC1pbJkYf4GOanNYN8ZXPK0tU4S5J9q3JiR+puNaobp7vR5sK7ohlXrcCHvgj/X0HBgJfrD0OipKKJfz7pw9MUrs2lsgFXpiPXTbHZ63GzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oo6XX5DHYq4VkoZWzRW+A5uQmB/kHedamT8bNpCjEjY=;
 b=eRBLjpMoQ2rtO5D8mgS4zI9lyTPm1kgTacnaosSaWLZ79nzAFz11CdQSBM6RqBWSAutq57u+B5ovnP5oADVMfVUrcik9ofH6hezekZfcqRjmW62ZF9NG8En8hG97nzx1vZua/TNCkrwG3DAnsTL6Q1vwkrr/McJeh6BCRnaRUHa1CdniFnUaK43KDC8A4HlgGFaNjKxp/fNeBwYgDSI0lQ1RcWxJatEfJAgSpfkbksGdbjyiIpunl8MImdBno5mXtF5BPpp+5pM6ibn+RpijDoX3F+RqwEsokshXfwAVVMesFYelgs9eNjvEiEYMre49R6Z9G+ajSnY/rY6GE/ipkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oo6XX5DHYq4VkoZWzRW+A5uQmB/kHedamT8bNpCjEjY=;
 b=MTlNhI9FDneU8Jlcjk6P0XN6T3v6nEjguebRNKrvRKWWM5n8o/FkKUBYD9mYgXyKhVuy3j5ZSjU1Kqy9W3rlyxAC5DWAH+mPz40eSU28CJHkd8tTmcjqghzjjq5gzOxmQVZvlfTht4x6SLyUKS+5hWhFI/xIzAyOOsDpo3JQI8Vyyfw5eW9QK0KJ8aXyI95GESgUWlswaMMAXR5ivUntHcpSZyP27gZl8TxUUudO02x5xDrk+gVjxI+CQYpEnZq35di6iuZ3nqvk627PVZWBrNacz1A82+pwukfY8+lrZ865GG1ErzREhzT6/dv6aUncd1z80KzDENi72m+zaaUWKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by LV3PR03MB7521.namprd03.prod.outlook.com (2603:10b6:408:19f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 05:05:30 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 05:05:30 +0000
Message-ID: <b485bbea-c4d1-4429-9795-ff8582951184@altera.com>
Date: Wed, 6 May 2026 13:05:22 +0800
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
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|LV3PR03MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c056392-98b8-4a30-752d-08deab2d17d2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 79jDBHT2+lX2XVFc7DroKVhwLPSHlyk98xYF3zglZFAmDqhm9l5q484TAQX8ZuWizlnFLWmfp8B7hmH9m7gLBujRliiyCFfQ7KH+N0zByfoAqFUPI0v3GdtCmdckaZk4yX4ZXkIcaEC2ovyK2L6/PK2Ic5c3LUiFy8TN2wcUEitEPIYSwQhBbozEPyZbAk46BillPdsERYTmkk7BAQWF2BelJg3SuGbD4Q2CF5PFeJIbY7Ayb/s1y/guzLKgJz7gkER3shfm5ojW4XFirIFH3yLLSCjlr7IGbTfftlPoz4diVEzXUgkHa02iEfYTRbfBOHBV+f0zh+gA+QttBBkn7feo5HGNwoxJWflT7hjwtRcSx9m35lvckH6FnclAX0NpKbH3/+L/bopJV9G/5tav562WTzQJ8PJNqjho+XbqB8GgGEjgHAHXRdnOnqGufpbUKdz4ZUlZcjl2IIDVTbbr32P4jQNw0RTJxh+5GpWP5VP6iuyQkTuaWWhE37ZDClWAkm0Wu3MfY2obRhcQxV2NTskK0+kLt2NxsqrgmanW4lxV6El0CGd+8LpiRBA34VLMokV1WmOS6/+OgWD6oP0LH4Zs/1RKMb6c7r1lYgWGQtVW9cBrnYNTrM/OOpz0jTZ4wKBphjtLuBKyIqKs9/mSfSNtZlvxoYQzsPKT+i7epfPuw+9X7gquF/HMOzjR4fKY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGxld1pkMllna2tVd1RyWktqU3hTeUYrMFprcnNadm5EYnJVbk1sM01NQTBZ?=
 =?utf-8?B?K0xzWktCTG90UGJQUHFYV2ZjZnUxT20xeVlvOVlOaFlUdDQ4Q2MwdGRuNm5q?=
 =?utf-8?B?bGFCRGN6RUplbWVtTWQwQzN2MXBYZGtzYThLdk85RzFFR1kwRGN5WS8zajhJ?=
 =?utf-8?B?SC9RUEpialIrbnlKbkxjdkdHT2xSL0hjVWk4bDQ4ZGN4SVBJMzcxL25jNmc2?=
 =?utf-8?B?SnZyN05pVFJCeCs2ZGY1OUJEdlpyQlpMZFdsWjg0RHFIWFdWNGs2S1MrVGRu?=
 =?utf-8?B?T0V4amxGYzNCdmZBZTU0N29wdUNNZUduNUo3UFZjS3NqTFJmVm5TejcvVHk3?=
 =?utf-8?B?WGVsSnlnbVMwK3ZtOFRBOTBHNDRzL29SYnZDdEJQaHVNNnlOWE5hZHpYejZ4?=
 =?utf-8?B?MTNPWk4vZVNWdm9uY29HV21LYkJUUjNHRGZZbFlURkg1b1draDBXa3FLUkNE?=
 =?utf-8?B?bFNvRWZNaHpiWVovUGJzcFR5U0RSSE4vZmFObWIvaHdMaG1mT2ZQelJLVmR1?=
 =?utf-8?B?M2VEcHRuQ1g3R0JjdmdyMHNTTjhrUElaeEZMc3JXVEdNVmMzYmFuYzRYZ00r?=
 =?utf-8?B?TVpKRUVYYTZuZEh0N1lSVEZmNlBoRERQZ1hpSGdrb3FObVhLdWhrTEJ2UWpx?=
 =?utf-8?B?RytyMTQrYlJTZ1JMRlhHV0xNVkZDTnlrWTA2bFNIclQ0M25JTXZyQWpFUXNG?=
 =?utf-8?B?a2JtOWZPTWlndjJ5amxzQmRFNXd4QldVMTFRUW9oT2Uxd2RhaWRxeEhOZytG?=
 =?utf-8?B?SDY5S0JNenhxbW1oSFJkRXBsY1NFODc3YW5NSTVoYU1IeW9wYWUyaGJHOFRx?=
 =?utf-8?B?TDZyaE9zN0h6Wm1aaFVuUzhvNGdLZjd6MmtPSS9GRVZoeE9laEtIblVhQWNv?=
 =?utf-8?B?TXVOQW5NbmUxMm9oa3FFMS9meVVUT3ZycWtUUDl2ZnAwdUJjcWJnOFhqaS9i?=
 =?utf-8?B?cGt0cUU5VXdmamF2TDg5VWkxb0t1Y3ovQXNjOTZLa3BNV0crR3FwSHBoNGsx?=
 =?utf-8?B?UGpxUFo5YXQydVNlTVF4MjY4ZFQ5V1RXYmlrTXltR2JhaDN4dkRoUEl5MVJL?=
 =?utf-8?B?NzMxcjYxQUdSMy9naHIvUEFOYU5NeUZoMEVUWWF5U2pBbm5UR3FXbW1wYlgr?=
 =?utf-8?B?QVFDblAxMVdSTWU4VlJkaEZzL05naXF6L2pQY1dabHcwdW9uZ2pab3hMQUlK?=
 =?utf-8?B?RG8xRTFpanFMY21HRjlraXRRbVBqVXN6ODAwZ2RIdm00M0UwMThidi9HOVE1?=
 =?utf-8?B?cS8yRUVWOUpxNlFLak85NlMySlp6QmFOdXl2RFdVVHByb041aGpRU1FIYnFW?=
 =?utf-8?B?VHZHRmUxK3hoYlo0TmNpcS9aNmV4ZDV3YklKL2pQR2xybFBLZDdaUTZyOXFl?=
 =?utf-8?B?MFMwakRWZnhsRUpvdVRkNzB2Qytzb0FFa2xYd1A1RlAzdXZsN2hsRTVTOWRa?=
 =?utf-8?B?Vm1OTXpJK093aFBpQTEvUFVaUTlNSGVUQ0FtbVo3bUhTdFkrL0I1c1JXN01R?=
 =?utf-8?B?Y0VCR003M3lyazlPQTFUQ3AyL2ZtWmh2RXRDY2RYU2pQSXpLMk5qSHhFU2lF?=
 =?utf-8?B?V1VTVFZiZTlPdzNWS0tCTGNOdjh0QjdMMUtrNDF1YWwzdHRSN1hZcFZsZDRt?=
 =?utf-8?B?Ni8rckxhZVlEclBXbXFwcVJuYlNUNmMrUmcrY1ZKREh3OFVFbXZlbk4yQjdT?=
 =?utf-8?B?d1I0QmJlMkdzOG1jQk52dDQrMU9IQmpuOHRzY2dvR21MMEl2QUFqNkRkdzVQ?=
 =?utf-8?B?VStrYVJZbzJ6Z0t1S05BZU8rRVl1Nk5UQUp3dVZMbm53Q3I0Yk1rT3B4RHND?=
 =?utf-8?B?RkVtVmQ1NnF1NTRiOUcwWlpQZFo4SDFkMDBXNWZaclEwNG03OTV0WFBKS092?=
 =?utf-8?B?MHZ5VlMwK1VsT3ZHbDQ1aGd6RlFoODFsMmZnT0IwWk93OWZzcTNZdFdMSm85?=
 =?utf-8?B?cE5HdHlTRWNINzJNWXZxRXZ6RHRjblNOY0Rmd2F1cFFsd3lqYW5aY0pGN25K?=
 =?utf-8?B?aFJPa0Z2UW5CWDA0OGh5RWJTU1krK0VnS3VQMHdxVE1nMUU0Vk5Jbm5aRVFU?=
 =?utf-8?B?UHVwMXJOZlFwMGMxeEh5U0JZZE5EZ3hOSW1EeE1QUTVabnB0RVE3QjlFdkNM?=
 =?utf-8?B?ZjR0U2syZVoyeEhZOWtXUmFyeEpoVDNPUTI3NHViL3JPYTFHM1ZQNXdod1hq?=
 =?utf-8?B?ZWNqL2d0TVVCQ250OHhySngxa25xVHEvTXJtUUExQjhVS1Q4ajRCZ3pSNTZh?=
 =?utf-8?B?WVZVcDFKdU9MeDNwOUV5L3pCalZWMENjUG85Sm9aYjVwMWFaUTFMbW9LMVl3?=
 =?utf-8?B?SEpFdmxTY3dMcmpyZEI3b2UyaStZY2xnZW1GcFJ2RmZBYjBpemFYc2VhSWJY?=
 =?utf-8?Q?uy3mN78g2QuZ4sBmX9n3YlOGbBj7VTOeGVWHk?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c056392-98b8-4a30-752d-08deab2d17d2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 05:05:29.9787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEee8QrLxuZ/NGkD8hdBhor4YgDFIiIZeBrvTsmnONtXR1jfzRuKCYLFpLR3Xn4GXZOE6fzUlQ/PRSWXLylApt5D8ZOg3bXZE/CMPNvM7ic=
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
Thank you for your input. I will address this in v3.

Alif
