Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA539C71159
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 16:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BF3182C4D;
	Mon, 16 Jun 2025 18:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="YkgXJQKS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2233C82C84; Mon, 16 Jun 2025 18:58:36 +0200 (CEST)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE85A82BCD
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 18:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0slcmhsGXZfux6yT4NJpZOurhWw37wcbcAauDfkNtzRNRjHNhXt7ZBKbGN3ZaryA3CTh/sTROuHOk/vmAwCz25YultYued2z3Ttm3obNymWo50wl1QpnBaECC5bTjB37tP5TijoQZoAcMZiKiC9Dbr8N6mYbklQTLteDtGgITudW6vrHyj6l7oR2Le2CtYjXxMflevfdwkT+7d/Fa02dIYRlojPSYyQ8RJdx3l6PG/K+pyK3X+lZjonJ3Nc/sM7waoLKuf639LRHOtNNc8jEyNZ+0O12hV6U+APAOTzf1TM4063Lf15YZz4bdgE7P1uHgWgFmAX+Xhke40gwroI6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjDh4x7E3qfcnAB1ZE2xaUSB6eRI6UGNZKRzxhY8E4E=;
 b=WP1Y0uvYtWvxq9Z1lHRsMZCm627CCHb6w2S9reQL43V4lMFTuYO3ijy3zP6WEAXLAmSzOKl/O9djvt33vgfLKJAGcYzOa7VDxt4Yhw7w6smu+eLQmaKGda3SLITvJcAQC0spVWJ2+jf9RVZkkQoJxPcCZ3XPgFhRPD6zzEVrPHSFSwoB7JRsZTbFSoWE0P7ql/vcbWaHOW1uiFUnP3JC2u0moYOaMuuA2ur3XVad/oZTz7WryWFjixgFLas9D+7DlGrBcV3pRZKJpdhxlfxKKF5VbjGvM7gC/TEXpJXjWUrS6ScpoxEFZL1DrZDQRZ/5jbkd13usX531xXuG8lNNlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjDh4x7E3qfcnAB1ZE2xaUSB6eRI6UGNZKRzxhY8E4E=;
 b=YkgXJQKSpePhc3VeHzSx3W4YwKiNTn0dFPK98BGL4/ACm3mxFcQynCVoneNfa2ZnMY8LWTEqWVRN2CEEk/U+EiFrHcLMoCtLP5sjErDokkg7UBW2qtUUyIokVcRqHr2tb+I+v/fjEmLyCMYURnaKu5PwrBv8rCXrfLfuUcsTEn8687cHhKPKspmWTzerljotN7WVG9M/dhG0LJElJjre9mMW3Wsf6tLIlFFkV8RZbPCXx2hP4KwzSNKUuJxl6C2MvsWvVB0NVrgre0PJh8yvVSdrwWGIMsezs1pFrleJGbR/mIKKstTCHqEWIubv4GRN+cjJxfPp+gq8/L4fxLx8pg==
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com (2603:1096:101:52::6)
 by TY0PR02MB6127.apcprd02.prod.outlook.com (2603:1096:400:265::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 16:58:29 +0000
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::cb39:3489:a58d:107f]) by SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::cb39:3489:a58d:107f%4]) with mapi id 15.20.8769.031; Mon, 16 Jun 2025
 16:58:29 +0000
Message-ID: <SEYPR02MB5557210DAFC9A63FA1FC27C09670A@SEYPR02MB5557.apcprd02.prod.outlook.com>
Date: Tue, 17 Jun 2025 00:58:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: meson: support gpio toggle command
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250617-meson_ppinctrl-v1-1-593aa15f288a@outlook.com>
 <28b0f2cc-4403-4473-8258-c08f12b1bd5e@linaro.org>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <28b0f2cc-4403-4473-8258-c08f12b1bd5e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To SEYPR02MB5557.apcprd02.prod.outlook.com
 (2603:1096:101:52::6)
X-Microsoft-Original-Message-ID: <4e2a2b33-9ca3-47da-8bd5-9f5b70d7beb5@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB5557:EE_|TY0PR02MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d905e9-b82b-4002-823a-08ddacf70483
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|41001999006|6090799003|15080799009|19110799006|8060799009|5072599009|461199028|3412199025|440099028|40105399003|52005399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2JaN1k4Sk5lV0NlTTNneVRHSllkMlcxMTEwVUJZcnB5UUNhMEs0VnhJVlFI?=
 =?utf-8?B?QXhqZHlXRW9YcFJ1VlBwRmhoTzN6NlNxa2E4d05FK2NxWUE0V1dpRWd1d1VY?=
 =?utf-8?B?bWpYc3k5QzFKck1wdVNuV3ZEV3pFY1lZV1FSQThvdE1nS2cxQ1ZBbkQ0ejQ0?=
 =?utf-8?B?TWhkOXhwd29rOGRuQkdqc1M2T1lFUXFKODZsZEJ6UVJ5eHJqaHBFN2VadnUw?=
 =?utf-8?B?M2JLcEFQWlhDeXFDb2ljV09TRytDWnZWNVowQ3ZWblM1M2N0TE1iQ1VwTk93?=
 =?utf-8?B?VU9hZDh6aUZ3am42UGYwOFRvUWxibGxpQlpOM3hWZFRMUUJwMjByTU5EaE5G?=
 =?utf-8?B?V3BOOVRraEl1WUdsVExLRFl5b0twOFRVZ2l6U1B6ZThKVmcxd09Na1JlUXJ4?=
 =?utf-8?B?SzVWMmhVaFU5TzFwVitTQUJvVXFhdytJeStjRDV2OE5vM3ZOVVpxVGtmWDUz?=
 =?utf-8?B?c0FmV2Jzem9iUGtEVzBlZmt4RmluZVNWYTBaR1FLL2Fyck9EcmJaSCtGNUE5?=
 =?utf-8?B?MXBTSU8zVWZzd0tEZHVtL3dkQW54WEx1TkVOcllzYk8xQmVZV3dZZE9XUXlh?=
 =?utf-8?B?Q3h6K1EyWURFVk92anlQK0JFYkUxcUwyeFdpWEE3ZzFLMmVmWEhDZWt4T2xl?=
 =?utf-8?B?UUxvZ1hVTndJQStteTVCTkFQRHhMWVpBSEwyZ2NDSmVwbFRTOXFmSnZMa2Rm?=
 =?utf-8?B?VW83N2h6YVgyZWhtN3l6TXl4dUVOZE9iRU9ickhhbGxxRzN4c1JLTVRTWUFx?=
 =?utf-8?B?R0cxN1dCQzZGbHlnUmF3VUxGbEpFVDFzdGVKSmorTUdXYzhBRmFnZ0N1dGJ2?=
 =?utf-8?B?RjNPVXJRR3AvUGQ1OHFOYVVERG0xd0IzdGs4dzVSQUZ5R0E4WjgwczZuWnZD?=
 =?utf-8?B?cGMyWmJUZlpOUUlJazZMQVBOZHFBaXg1TlY0ZTltVWtqSEU2K2VHLzA2ZytH?=
 =?utf-8?B?bkxMRjcweXBXSjFqL3hIZHlQajZMeHFKTG4yWW1zeVRRTzFJSFVxRDNrbFpu?=
 =?utf-8?B?bm41YU1lSzdiaGVJVG5IRjVDS2JGZUpQazdZQ3krclRaTG8rZG5VakFkTk5B?=
 =?utf-8?B?OGc1QVc2YkxDQ2JNU0VOVkhZQ28rZzhsSDRFUjdZaFB4Q2UxU1NZZU80dFNQ?=
 =?utf-8?B?YWV1VU94SU5YNitoN3VFNjNMbEsvYzZHME84Z05vTFVtUHNuVW9meE0ya0tZ?=
 =?utf-8?B?aHlOOHZDSmEza0RVbGFtNXhEOUpHNUhWSnl3VGRvSjZZVkFKYk1yZFc4Tzh5?=
 =?utf-8?B?NTNqdWJ3NWplTEN0U2dMTEpjem5JMGJ0NlNQQ3NFTmM3RW13YlFQcUl0QmJO?=
 =?utf-8?B?Z05idkRFVXJYempwVTM2b0UvT21YOFNtckRBZlFCQ2lkU1l1TkFPWWplTnFR?=
 =?utf-8?B?ZVZSc29raDdIVHFSUWZnTERVSk05Mll6ZWFnanZwa1VmVDA4ZEFhUlVNUFRV?=
 =?utf-8?B?dVhiNTNoOW81RHB4TURPYjd2Zmh0SC9YbkFMM3Jqb0FDdGhvdTd6UUIxZmE1?=
 =?utf-8?B?c0o2QXR6OFZBM3RGSnJSU1Y4OWVaaWIwWmFLYTFaajJnMis2THZMSHMyZTZ5?=
 =?utf-8?B?Z2ZYOUZQNTM3QTI1bjExOUI3RTN3T2R3SFc1OE1Qa3NuZmM4Ym1UVjVKRXAw?=
 =?utf-8?B?L28zR2JFbmkyTXQ1dU5STU5wR05KYlE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVd4TEpCNmJWdDMwRHB2ZGs2dU9IMjl2em1GYVA3aG9TNUV0WXhReFdPRkRX?=
 =?utf-8?B?dlVCZnYrRHFhMFp4dnB6VzJPUWVGN3oyYWs0R29haTFDcnROdjJWTG1FWjdF?=
 =?utf-8?B?UEt1WUE4endSY0ZHeXpTODJDUEdjektHUmQ1ejVENHFybnJYUVhDVVg3WmRi?=
 =?utf-8?B?U0pQT0Faa1FSSTMzbTkyYW1tWW1PbXQvMDl6SUhFWFVGZ0ZHQVo0bloxN0F1?=
 =?utf-8?B?SHhac1JNU3VKZHoyMTh0dTVTSnRNYTRicmhGcGY1Y09yZXlDYTJpTzJuZ2FK?=
 =?utf-8?B?L2cxbFZXcnRkOXNjNmE0S1NLd0hBQU9CU01OM3pOenFnV0ZxVndjVHY3eFpy?=
 =?utf-8?B?bkdYaC9vNTJZaUNLdXArcmhlYi9UZTR6NEcwQm1DZTk5N3JDREZVT1FiYUlT?=
 =?utf-8?B?eUFLOXJHMEErNlh0ZUJvNEFBd1lMVm40aUpIL3VSUnVaZUplREJZR1N4TVRI?=
 =?utf-8?B?anhRdlBEaTJFcmgrY2ZSTEV5L1BSWFNpWGx1MmR1bXJXU0hqUUxyQlNrTFhZ?=
 =?utf-8?B?TE1wanJvRjNDeEpQeHd3U2ZuVU85OUdyM2M4d09ENVlNa1lxR0QyRC9uUVlU?=
 =?utf-8?B?TklzY09aTjVjWHJtYlhaYlg3L0hLeVJtdUcyNktwSHQ0SmRmM1FYSnhST05B?=
 =?utf-8?B?QjRrWVcycjlZRVJKbFlvUkdpRWJidTBRZ0RkMk9LdWUrR0RqTUU0L09iS2lE?=
 =?utf-8?B?Zy82MzNMQlFSYlk0RGVPVnRXaTU5NnZkVjhFVldqL3crWWZOY0VuRWVJUzla?=
 =?utf-8?B?NzhmSkFkTWVldGgwQ3VkTGg1aytHODlOUCtCUWI3ak03ei9yNE9KNFM1cG1i?=
 =?utf-8?B?dWdWQ1hiTGZNZzFpZjFkT0k3cTdEdU4rc1o0RHJreTVubG9Eelh3d0ZHN2xo?=
 =?utf-8?B?cWVuSzdjZkVvdWo2KzJKTithOHV6RGdRTzdtSEh6RDNwOE1xSkZJVW5IRWNL?=
 =?utf-8?B?SlJEdW9JQTBVTTVUYUhteURwM29ObFdzREg0dXNEb2dSN0VIV2pHOWdqOHMv?=
 =?utf-8?B?VUI2TWF0Nld0aS9tVWpYN3B1SE93TGN3TXRGdTJPTFY4c2FyK0toczUzc2c4?=
 =?utf-8?B?c0FEeFR2djJuVWZSNWpPZk1nQ21tRlJYaGJUb21BQkZmVDFyTXJQa3Vhemx0?=
 =?utf-8?B?Q1hzZjJZSHpuTEJsWnVXRmZ5ODhGUkdIWU5memczL0JNM0g4SHd0ZzdNQjdv?=
 =?utf-8?B?WVFGY1FBMmE2ck5lRzR1SVVQZW5udzY0TXd1N1psS3gwcXlIai9vZ0JCdXdM?=
 =?utf-8?B?eEFYR2tCT0lHbTROajE1NWdyWWhKd0N5eko4Qm1FSWlmZ1NMTHN6MUJOZFRs?=
 =?utf-8?B?T2RCcWV4M0pJQkc1dWgvTlg0UFVwcWdrLzlHS0RQMHpkZmJUOFVsdy9FbVBJ?=
 =?utf-8?B?b0ZmMm96RTlvZ29ZZVpDSXhHaDNzdFNScVVuVkRMLzNSdlZSdVJjREE2ZjJN?=
 =?utf-8?B?YnVNd0pwZ1AwTStqaXVpOHloMHR6RzRXQ2gxaHQ1NW9Gam5CSWZQOThqdDll?=
 =?utf-8?B?V1dxQTdSQWRlWmtqK0xDcFB4ZkxEcVJMYnY0Y2l5bVlyNlQ3V0MrTDZDdUxw?=
 =?utf-8?B?NlpjaTBHWkFJMm56dmlVbHZwbG9WVk02LzYxQ3kxMXRzU0c0T0xRZ3FsWjJk?=
 =?utf-8?B?TS9RVzNZWkRPdDZ2OWM0UVpVYWE5Q1ZvVzQ3dmVNN1I1N2Jrd2ZLTXVxaVY4?=
 =?utf-8?Q?lfyWNLfYzV/Rxmd6H2Qr?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d905e9-b82b-4002-823a-08ddacf70483
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB5557.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 16:58:29.2097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB6127
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

On 6/17/2025 12:40 AM, Neil Armstrong wrote:
> On 16/06/2025 18:23, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> meson_gpio_get() always assumes gpio is configured to input mode. This
>> is incorrect and breaks `gpio toggle` command:
>>
>> gpio: pin aobus-banks2 (gpio 2) value is 0
>>     Warning: value of pin is still 1
>>
>> Fix it by adding the logic to handle both input and output mode.
>>
>> Fixes: 2009a8d03fe5 ("pinctrl: meson: add GPIO support")
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   drivers/pinctrl/meson/pinctrl-meson.c | 21 ++++++++++++++++++++-
>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c 
>> b/drivers/pinctrl/meson/pinctrl-meson.c
>> index babf1bccc969..a1f4afd11f94 100644
>> --- a/drivers/pinctrl/meson/pinctrl-meson.c
>> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
>> @@ -117,8 +117,27 @@ int meson_gpio_get(struct udevice *dev, unsigned 
>> int offset)
>>       struct meson_pinctrl *priv = dev_get_priv(dev->parent);
>>       unsigned int reg, bit;
>>       int ret;
>> +    enum gpio_func_t direction;
>> +    enum meson_reg_type reg_type;
>>   -    ret = meson_gpio_calc_reg_and_bit(dev->parent, offset, REG_IN, 
>> &reg,
>> +    direction = meson_gpio_get_direction(dev, offset);
>> +
>> +    switch (direction) {
>> +    case GPIOF_INPUT:
>> +        reg_type = REG_IN;
>> +        break;
>> +
>> +    case GPIOF_OUTPUT:
>> +        reg_type = REG_OUT;
>> +        break;
>> +
>> +    default:
>> +        reg_type = REG_IN;
>> +        dev_warn(dev, "Failed to get current direction of Pin %u\n", 
>> offset);
>> +        break;
>
> Just return -EINVAL here


Fixed in v2

>
> Thanks,
> Neil
>
>> +    }
>> +
>> +    ret = meson_gpio_calc_reg_and_bit(dev->parent, offset, reg_type, 
>> &reg,
>>                         &bit);
>>       if (ret)
>>           return ret;
>>
>> ---
>> base-commit: c5afa1fef49f55146e78d6157470520391c40eca
>> change-id: 20250617-meson_ppinctrl-5139ca06b828
>>
>> Best regards,
>

-- 
Regards,
Yang Xiwen

