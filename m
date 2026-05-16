Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03E9CD4F21
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 09:44:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D08E4845E3;
	Sat, 16 May 2026 11:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="bUjJbQmm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5123C84609; Sat, 16 May 2026 11:44:03 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68F7383E76
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 11:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeRqvnd32ocGnet1Sn/Ae/oUe+vctsI/SnBy/bprPQKHtAGjT665IKShr6LKMjmXsZJVyM5Ga/dC5+TjqIW8dyr71Me8US8IyMHcfc8RNgv5kNn4L4h2SYl47+pJCNQhWG0lavlgVq7Q8vxclW+Qp0Bwk8ctvE8qhRqL401C4zP6rZ6fRgL7F435TffNHaFUEdnbC1wUzAPfiaQ/OtHCnBP7a2+X/Zrsd3BkGdU4dYEAWKm4gHZ8gAld+RnpVcsUE3YXy1wFjAxT5hTWMSmRStfOmHXGlTuHB0JzmYSqBa7wWDvv3X3jCkGGlct4NwbSCm0qwj3xla7EDI8SMzD/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3zXhgX9RanJP8RdZ89OvuL1IjJH2qEKn4TxU4joHYo=;
 b=JOYbTeo4tOO/kcjSM3mSj/oxc9U6+tjRqU9voIdGDLFkezXnOE2AcdgwTH/+yb/9uQ3Yk8Iz3100jqlWUoE2Zyq32zZ/yWvof85EXTtJeMlEyxynEMO0wNaQV5cvJ9ezG5qC5hGtkjG9S6UIL1fDUYk4tfaIpFf1w2taYmr8T+SkhIrQCtASgtYPqwlB2QHOskEWQ6gu1KPG6sJcUvM3DaNNgE7ULNgWsaJAAtUyD/WyFL+BguIW/raDpkGnCjLJv/OfmgSOXyWbM1ZSwvB3wf//eShyAODmqp98OkAW7u4enfR6rDMTibwpQ5hQl8qx1uxJ3jeszIliAZrJ8Y+h3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3zXhgX9RanJP8RdZ89OvuL1IjJH2qEKn4TxU4joHYo=;
 b=bUjJbQmmsuaFZ9N+s1D+4lGKvl44qScRcZUujLC9b6CXjWm4T4JCGkXvz42MYhQFzuttwnk9w5gLZVKcMXzV+GcyWiq02LxF7i7gx0wD0+VRQn1MDGieRc3SBAHjSCZNCLeWCC6eTvRyuF4z3fB/IgAYFu5NXClM4myDrEaNeYou8kqJ1L5G0Jn+RLDsmWP+0DeYA2KCq3ufQnR7dHoAUu+XfpJOXyLoFtjz51qKecJEGsjNACWpgZKjB+xynF49k2QiETypE/Pw49sh7nvBUeCb/3NCsPXoRjo+QA4L4QY8wU0X1upm7YoFIS+bVVEA9oY71dci8tC+vt5u8Ni55w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB7026.namprd03.prod.outlook.com (2603:10b6:a03:4e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Sat, 16 May
 2026 09:43:56 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.21.0025.020; Sat, 16 May 2026
 09:43:55 +0000
Message-ID: <1d2c6aef-9184-44a5-867a-f28762ff4c2c@altera.com>
Date: Sat, 16 May 2026 15:13:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sd: Handle UHS-I voltage signaling without power
 cycle
To: Peng Fan <peng.fan@oss.nxp.com>, Judith Mendez <jm@ti.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, marex@denx.de, tien.fong.chee@altera.com
References: <20251021204526.22701-1-tanmay.kathpalia@altera.com>
 <agg8f-Q_RnVI9Gyl@nxa18884-linux.ap.freescale.net>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <agg8f-Q_RnVI9Gyl@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::23) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ0PR03MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: d401ca06-aa66-4d67-b4af-08deb32fa52b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|4143699003|11063799003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: kxoD20vj+nnYzs+Cm8okJUfTt6V6LwhqeQMuvaBXFEps8atzjSVC8I/DbJvD2vcJwnk/yfstQj0kE8mBbOJpwn0umojto5z9kxlyUKXZpGpC3WnULqvxAVdRUf/1u3HFixBfoi6dT4aARPd1LZuGtrlSjTL/dIMbksXpm/k48otM+31C2CDWUEMnc3BpByYxOOo8jggeps928qHuFNKde+kxiNW5mXar5fobr6vjDO+SzbrqRJ85Rd9XU/JMo7lBeseD3qvIN0lmFRxgPJ5DwKQuOlYDcA5JmCQwbTr1ip+zgIHw9Sk7qHZO/cwET15bNHzDTbj9QaDn6EtSNXfvWVa7NajrzW6dYVPgvpiigqMKLxnjcd7vnpdGJFqONR12KHMpNDKaRugV3aJkr/xNlJC+Kr8L5LXMVpGcQM/sHKJBalXQEw9aDa1OYbDuQHJs11iaFiSdxuKt4LDYrrB+8ivRbvlfOL7ZwDHJZJVMeBf4IFuVAtXTuUuuorV9hsPiQuDHpvpfjKaNw80xoC5jTEVR6jVMteVs1SbNko/56FfYG8QPUeNv5E1r7pFz8h3/AH5o9o08RAWlhdUhCKluSP5mvQ73Q6MX5qlIpqJa0Yv8GBhRmAVpKwPRQ5sjrAnr9j5fQno/TnBlQkYYmyRN1o4jN8R5+RLcf5LwvAdcivaxPXbAntKS8/ZFpphbdE/+6+dZAQxa9hUZtOXmDZRtcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(4143699003)(11063799003)(56012099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1dVeDNpb2NZNkk4RWVnRE1HNk8wMlc3aDkzdTZtQktkWlRvbThOazhRYnZF?=
 =?utf-8?B?akFOVGkvNEcvQ1o4U28wTDNzUUwvN1dSbFd2SG40ejU0cTJFalJvL0dHRE0r?=
 =?utf-8?B?VWRiZEt3NlB3UmRyT0JmWnJIYWd5K2c0akkvWU5YNnloQlpTR29xODltZm81?=
 =?utf-8?B?YTlOdHFvb0tQR1FXV3VSdWlsSllNdGd2NzNrZU52MXpmWGJoeGVaT1B4QkFq?=
 =?utf-8?B?b0xyRWZldmMyM085R3hNV3hHWTh6UGZlVTJwYUNvWlZHMTJoN2JHOHBGdUdK?=
 =?utf-8?B?bythSkZEZGNhYW5lWWpZVmhVbEVNc1pCeTF3YVI1LzU3KzR3ZnI5NTQwZk9i?=
 =?utf-8?B?bG91NnVKTTlhK0hKcnpWcE45bk1HYzVaQU5kdi9sOWNhU3JITjdSZjJJYTg4?=
 =?utf-8?B?OXlSei80MW5ieWdtQzdOYXdNT25kQ2lqMUcyK0VKZktJYi9DMU9kK3NocnlM?=
 =?utf-8?B?UjRHRVBWcnJUOG5aQTdFcHZLVDhKS2ZKSnljMko0SGFsWW80VnFEcDN2bWVy?=
 =?utf-8?B?UVdPbENIcXdudDJyVVczTkR0L2orVUl1dHp6a3JLUTNYMEJxQWZvK2R6Yk5C?=
 =?utf-8?B?VGVWWStjZFdSWmFaSklxNDVrcURKUnpOZ2lxZ0g5QUwrR3VXZGxXRVpVOW4r?=
 =?utf-8?B?YzRaUWhSY1JBL2wvWFhYell5VFpDMDZxYmc0ZEpRYXZ2amplYlRrUVk4WjM3?=
 =?utf-8?B?anZDam83R0VRUjc4Z2YySE9uYUtCUFhRcnhsakFuam1HZ3FjUU41YzYxRnd1?=
 =?utf-8?B?Qm82T2VCeHBDSit0c2FyQ2w3R2lLTmNQSS9uQlJodjZOVGhyNXJDMkVYWEhl?=
 =?utf-8?B?Q1B3UXFjQm9YSyt1cm5rSzF2VTlOcFMwSENJU0x2Q0JkdWI2dmxpbWVaWGxu?=
 =?utf-8?B?eUtxQmNETy9jRmRKRmVSK0g5MXpIa0lxdHNGb2ZVQnRtSEZFSmUraEtNdHRG?=
 =?utf-8?B?U1ZocWhuYnE4bk1tME9oMC9XMjdTMzNCL2RDVkc5WnU1MmV2RXFrREtpOHdS?=
 =?utf-8?B?am9kdnR6ZnZjR1FhdFFkYkZBNm1QbWJJTU9Qazl3VnZ0RWhsY1BBWGlNZDgx?=
 =?utf-8?B?R3FMMm1VbWNMbDFHRU9Oa0VuWjcrNlZLR3NiTDFhNHI2OHVkQUcrVW1UMjZ4?=
 =?utf-8?B?VVVyRUNWWStUcVhHRWcxMlRzUGlrNlhCcndLSUtUMks4MkJ2cVBqRHZ2eHF6?=
 =?utf-8?B?YWZPWXV2bndVRWFNdTAzZ1VVOW9xODRXMHpiMG4zbG1UZXJZVjdoeldlQkdL?=
 =?utf-8?B?MFptZ3FHejRJWXpadmdtaVJLRkdiVmo2K2M3Z2pGZFpZOWl0Sm1aMnV6b01H?=
 =?utf-8?B?dkZZYkJmeU5sQ3VRUGs2S2V3L09ocUZrTWNGVnQzV01jVVdyWEZNdEFOR294?=
 =?utf-8?B?WVlodVl6cjgvaDFpcmZad2tHaU1uT2Zkc1kxMEExdVlVU2ErZjlXc2F5NDRi?=
 =?utf-8?B?UkNiSXNOTUdUZGFQK0NVbzAzMkRjQkpFb2pCZ1MvQUcxdkw1N2dNc2RwMUdN?=
 =?utf-8?B?aFgvdzZtRTA3VjVwYXlLY3piM0JWT0pRN1VrL0JpZWNRMmxHMUdCeFp0amtL?=
 =?utf-8?B?bTdQTXI5SUZ2MVo5MXYwTXUwQmJIUXlldmdOMUhwVXpadkNvQXZNMXJWNkJD?=
 =?utf-8?B?NnhpM3ZCRnVmMmZGdVRUVE9kZjlLWmJzeUtkNlMxVjNUQ3daMGNHY29uTGM2?=
 =?utf-8?B?bTUvSTVCYnpHWUttellPZHVaY1QrSmFlVHB1L0FCOFdqV2N6NytXT0l4MUw0?=
 =?utf-8?B?ZU80LzluV0dlRTFJY09QelUvZDQ3WDNyVGNUWEQ5clFyeGFYNjRhRHdqVXhx?=
 =?utf-8?B?bHFnK1pNUXMwMjFYKzdVZ2xyQktacTh6R3pmVFVBYU9XbW0ydTVFa2ZpL0No?=
 =?utf-8?B?czFaSmszS09QRXozejdhRzRDazJ6Z05OLzJqb3pGRmQ0OG5vamMxRCtFQWVZ?=
 =?utf-8?B?QWVLNzZSSGxEZEduNEQ3UHhhc2xMUnVMcVpPRG13TGc3K2gvcDVod3Q5cHd3?=
 =?utf-8?B?cEgyWDY5WHZzK0xvckVEUnhCWFY1dHpwejZ2Nkc1MGVxL1c1NEsyT1RmZ0hj?=
 =?utf-8?B?eWczdmJwdXpodDJNQlRIY1owT0F0dW0wTENrWWxFR0JvbjhZZDE3WWlsM1Ja?=
 =?utf-8?B?WnoycmJYcFYwbjdnSm94ZnppWXFmeUFEalhBM0l1NlFPYll0K1hoL0RlY2ZF?=
 =?utf-8?B?Ni9zODZNSStFSktqc0F1M0hndTBhZjNaTm5rQW5MVzEvQ1NZZGVyd0Evbm95?=
 =?utf-8?B?VWhsTGlTbk1ETURIeUxLQm1xU29qeU1FZFEyd3owWG1Id0NxYnlYajVNWFBU?=
 =?utf-8?B?VzB3WXR6RlFrYzdIaWpERTZvdnp1aTZ6UG1HenRvRldCM3BxQTNyc1VXL1hH?=
 =?utf-8?Q?KUyh0LODJWNDAsrQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d401ca06-aa66-4d67-b4af-08deb32fa52b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 09:43:55.6901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCOrZfl+eG4T5WyRbMfVsBzUeQQuZ7ejNNRdovuliazwBXQqWXwJg2+Q75bu296xeCBeRKn+MgdW/x30MflIJDiddXg+iuQ9AAf5Qu3eIHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7026
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

Hi Peng,
Thank you for reviewing and for the detailed feedback.

On 5/16/2026 3:14 PM, Peng Fan wrote:
> Revisit this patch, since it break one board [1].
>
> [1] https://lore.kernel.org/all/52ec8007-ce50-4f12-b796-4b8c2aa1822e@ti.com/
>
> On Tue, Oct 21, 2025 at 01:45:26PM -0700, Tanmay Kathpalia wrote:
>> Some boards have SD card connectors where the power rail cannot be switched
>> off by the driver. However there are various circumstances when a card
>> might be re-initialized, such as after system resume, warm re-boot, or
>> error handling. However, a UHS card will continue to use 1.8V signaling
>> unless it is power cycled.
>>
>> If the card has not been power cycled, it may still be using 1.8V
>> signaling. According to the SD spec., the Bus Speed Mode (function group 1)
>> bits 2 to 4 are zero if the card is initialized at 3.3V signal level. Thus
>> they can be used to determine if the card has already switched to 1.8V
>> signaling. Detect that situation and try to initialize a UHS-I (1.8V)
>> transfer mode.
>>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> ---
>> drivers/mmc/mmc.c | 55 ++++++++++++++++++++++++++++++++++++++---------
>> include/mmc.h     |  3 +++
>> 2 files changed, 48 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>> index ec61ed92e86..e1f62a5d0ad 100644
>> --- a/drivers/mmc/mmc.c
>> +++ b/drivers/mmc/mmc.c
>> @@ -643,6 +643,19 @@ static int mmc_switch_voltage(struct mmc *mmc, int signal_voltage)
>>
>> 	return 0;
>> }
>> +
>> +static bool mmc_sd_card_using_v18(struct mmc *mmc)
>> +{
>> +	/*
>> +	 * According to the SD spec., the Bus Speed Mode (function group 1) bits
>> +	 * 2 to 4 are zero if the card is initialized at 3.3V signal level. Thus
>> +	 * they can be used to determine if the card has already switched to
>> +	 * 1.8V signaling.
>> +	 */
>> +	bool volt = mmc->sd3_bus_mode &
>> +	       (SD_MODE_UHS_SDR50 | SD_MODE_UHS_SDR104 | SD_MODE_UHS_DDR50);
> This is wrong.
> sd3_bus_mode is sd supported bits, not the current running bits.
>
> To detect the sd card running bits, need to use:
> (__be32_to_cpu(switch_status[4]) >> 24) & 0xF
You are correct that sd3_bus_mode stores the supported bits - as can be
seen in sd_get_capabilities() where it is filled from the CMD6 status
response:

     mmc->sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;

However, the intent here is not to read the currently active function
code, but to use the supported bits as a proxy for the signaling voltage
level.

According to the SD Physical Layer Simplified Specification v9.0,
Section 4.3.10.4 (Switch Function Command, CMD6): the UHS-I speed modes
SDR50, SDR104, and DDR50 (function group 1 bits 2–4) are only available
when the card is operating at 1.8V signaling. When the card is
initialized at 3.3V, those bits read as zero. Therefore, if any of bits
2-4 are set in the supported field, we can safely infer the card is a
UHS-I card and, when not power cycled, retains 1.8V signaling.

Using switch_status[4] to read the currently active function would
actually NOT work for this scenario. After a warm reboot, the card
receives CMD0 (GO_IDLE_STATE), which resets the card's selected function
back to 0 (SDR12/default) — even though the 1.8V signaling level is
retained. So switch_status[4] would always return 0 in this path,
making it unsuitable as a 1.8V indicator here.

>> +	return volt;
>> +}
>> #endif
>>
>> static int sd_send_op_cond(struct mmc *mmc, bool uhs_en)
>> @@ -1369,9 +1382,6 @@ static int sd_get_capabilities(struct mmc *mmc)
>> 	ALLOC_CACHE_ALIGN_BUFFER(__be32, switch_status, 16);
>> 	struct mmc_data data;
>> 	int timeout;
>> -#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>> -	u32 sd3_bus_mode;
>> -#endif
>>
>> 	mmc->card_caps = MMC_MODE_1BIT | MMC_CAP(MMC_LEGACY);
>>
>> @@ -1451,16 +1461,16 @@ static int sd_get_capabilities(struct mmc *mmc)
>> 	if (mmc->version < SD_VERSION_3)
>> 		return 0;
>>
>> -	sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;
>> -	if (sd3_bus_mode & SD_MODE_UHS_SDR104)
>> +	mmc->sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;
>> +	if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR104)
>> 		mmc->card_caps |= MMC_CAP(UHS_SDR104);
>> -	if (sd3_bus_mode & SD_MODE_UHS_SDR50)
>> +	if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR50)
>> 		mmc->card_caps |= MMC_CAP(UHS_SDR50);
>> -	if (sd3_bus_mode & SD_MODE_UHS_SDR25)
>> +	if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR25)
>> 		mmc->card_caps |= MMC_CAP(UHS_SDR25);
>> -	if (sd3_bus_mode & SD_MODE_UHS_SDR12)
>> +	if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR12)
>> 		mmc->card_caps |= MMC_CAP(UHS_SDR12);
>> -	if (sd3_bus_mode & SD_MODE_UHS_DDR50)
>> +	if (mmc->sd3_bus_mode & SD_MODE_UHS_DDR50)
>> 		mmc->card_caps |= MMC_CAP(UHS_DDR50);
>> #endif
>>
>> @@ -1830,7 +1840,11 @@ static int sd_select_mode_and_width(struct mmc *mmc, uint card_caps)
>> 	uint widths[] = {MMC_MODE_4BIT, MMC_MODE_1BIT};
>> 	const struct mode_width_tuning *mwt;
>> #if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>> -	bool uhs_en = (mmc->ocr & OCR_S18R) ? true : false;
>> +	/*
>> +	 * Enable UHS mode if the card advertises 1.8V support (S18R in OCR)
>> +	 * or is already operating at 1.8V signaling.
>> +	 */
>> +	bool uhs_en = (mmc->ocr & OCR_S18R) || mmc_sd_card_using_v18(mmc);
> In theory,
>
> bool uhs_en = (mmc->ocr & OCR_S18R) ? true : false; is correct.
>
> OCR (including S18R/S18A) only reflects voltage switch negotiation
> capability and intent, not the current signaling voltage. So your sd card
> should have OCR_S18R returned per my understanding.

I think there is a gap in understanding here. The scenario this patch
targets is warm reboot or system resume - the card was never power cycled,
so it is still operating at 1.8V signaling.

In that situation, when ACMD41 is re-issued, the card will NOT assert
S18A (Switching to 1.8V Accepted) in the OCR response, because the
voltage negotiation already happened in the previous session and the card
has no need to re-negotiate. Per the SD Physical Layer Simplified
Specification v9.0, S18A is set only during the initial 1.8V request
handshake. A card already running at 1.8V will not set S18A again on a
subsequent ACMD41 after warm reset.

This is exactly the corner case: OCR_S18R/S18A will be zero, yet the card
is already at 1.8V. The existing code misses this entirely.

>> #else
>> 	bool uhs_en = false;
>> #endif
>> @@ -2701,6 +2715,27 @@ static int mmc_startup(struct mmc *mmc)
>> 		err = sd_get_capabilities(mmc);
>> 		if (err)
>> 			return err;
>> +
>> +#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>> +		/*
>> +		 * If the card has already switched to 1.8V signaling, then
>> +		 * set the signal voltage to 1.8V.
>> +		 */
>> +		if (mmc_sd_card_using_v18(mmc)) {
> To switch voltage, ACMD41 is required, see mmc_switch_voltage.
> Forcing switch to 1.8 here has some risk.

Agreed - ACMD41 is required to initiate a voltage switch on a card that is
currently at 3.3V. However, in this path the card has already completed
the voltage switch in a prior session and is still running at 1.8V. There
is no card-side voltage transition happening; only the host controller
needs to be reconfigured to match the 1.8V signaling level the card
retained. Sending ACMD41 again in this context would be incorrect, as the
card is not in a state to re-negotiate voltage.

>> +			/*
>> +			 * During a signal voltage level switch, the clock must be gated
>> +			 * for 5 ms according to the SD spec.
>> +			 */
>> +			mmc_set_clock(mmc, mmc->clock, MMC_CLK_DISABLE);
>> +			err = mmc_set_signal_voltage(mmc, MMC_SIGNAL_VOLTAGE_180);
>> +			if (err)
>> +				return err;
>> +			/* Keep clock gated for at least 10 ms, though spec only says 5 ms */
>> +			mdelay(10);
>> +			mmc_set_clock(mmc, mmc->clock, MMC_CLK_ENABLE);
>> +		}
>> +#endif
> A proper redesign is required. So I am going to revert this patch.
>

I would respectfully ask to reconsider before reverting. This patch is
specifically targeted at the warm reboot / system resume / error recovery
scenario where the card is not power cycled. The check in
mmc_sd_card_using_v18() acts as a guard - it only triggers when the
card is already at 1.8V and the normal OCR path did not catch it. On
a cold boot with a fresh 3.3V card, the UHS supported bits will be zero
and this path is never entered, so it cannot regress cold-boot behavior
for any board.

Regarding the reported regression [1], Judith mentioned that he will
debug once he is back. If possible, let us wait for him to conclude
before deciding to revert.

This problem is not unique to U-Boot. Similar discussions and solutions
have been proposed in the Linux community:

https://lore.kernel.org/linux-mmc/a367a679-28f7-898a-c043-27df8c9c9aba@intel.com/
https://lore.kernel.org/linux-mmc/1506328144-13666-1-git-send-email-adrian.hunter@intel.com/

I am happy to rework this in v2 with a tighter guard condition (already
addressed in [2]) once we have more information from the regression
report.

Please let me know your thoughts.

Thanks,
Tanmay
