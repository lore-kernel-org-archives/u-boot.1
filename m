Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64BEEC142E
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 11:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E57BE838BB;
	Tue,  3 Mar 2026 12:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="SryKzHk6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B39FE83E7F; Tue,  3 Mar 2026 12:07:53 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 774A08063E
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 12:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceGg1V5Yo7DIwMUySmSKZhDCBdOPbG59ROdeYvQEzhq49dtgLIzFHnjJed5Je6lrbLbD1VDb70+GNnbJvw2bELfTBKVHErPSJXtYeIGKPU0kOkDr+cA2q4YQIUE8IVl40zRzIKO8MyV2LwI7nZodtoeOEGMgcFWpDBHz7RY554cgAMqhg41ORak5pquRtl2qCP2SmoYdFFOKL5EPbTXxf50TRgfmwKg1CZM3B1COaeVLsh0XNy4YYt0dpyQNvKJZW4HhHgp5Z7EhjgKCHfjmmMsVmKYnFbFEybbzt6i7nwzm9yRD24LTk9w4LJNhglFjPFzyIpZrJNMWbR3/uE813g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilftRNWvVSQIR8GLCGjPHo+swMOkg4QwdSRRbyV95O0=;
 b=ZiwXmAp93FFBzzf3t2iOn9TFjNj7kPp3Ny0zLKzY0Z3erwYn159CfMFn4VcTo1QBTog1TmCQTDYTjEXVfiM5VW5JamdiWJ+OsTjI+tgEiZBdWW847d91I1cW/xDfizOdlESvb2jWeQFuphb+QR3xRtPG3Yflm1FSK3ejYQpUw8dwGt9tdJkNgWzu+j6N1dqdTzbxMhzSo8ocuNm/QkOnDWBbIaA5HcfydOUAoZ2ALImsUkF+/s4gEfC3Xf6RVpif17Q3sW8vFzdSPjBq6mAA9cCc7S+bDz0mkN+wGhRpdwY1+K6kusysm1Xyc03CmK3jq5UQ9RR/VjfIwzTT5xbz1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilftRNWvVSQIR8GLCGjPHo+swMOkg4QwdSRRbyV95O0=;
 b=SryKzHk67jhkHQAH1lw6+0HynlaRQqDs3m1fr63vEJRtiqoWn1Tur7VULQK0mi/NWgQWyk8mAHbsDmlTPC5OqwY/abJCHiu3IgleNlV9T9MZATgfjMvIeObCk6tTvbc08359OHJMh2hzQ2+BWMB9/YJgP4fL00H8jJskdrbuPlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB9PR04MB9329.eurprd04.prod.outlook.com (2603:10a6:10:36f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 11:07:49 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 11:07:49 +0000
Message-ID: <9a229a29-7ba1-4f23-8940-7be3d56ad7da@cherry.de>
Date: Tue, 3 Mar 2026 12:07:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] led: led_pwm: fix active-low behavior
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Ivan Vozvakhov <i.vozvakhov@vk.team>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 u-boot@lists.denx.de
References: <20260209180718.32451-1-clamor95@gmail.com>
 <20260209180718.32451-2-clamor95@gmail.com>
 <d194a890-6921-472b-935f-8b2d01c1289c@cherry.de>
 <CAPVz0n3Tsx2rvfmBhDQDyW-_fLm3XLiPzzna3ZCxbt=LeQAF3w@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAPVz0n3Tsx2rvfmBhDQDyW-_fLm3XLiPzzna3ZCxbt=LeQAF3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::15) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB9PR04MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: a31e34bc-a41b-4ebd-233e-08de79151b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: KHBbyzcQuhWcqsodUo3oQVQCL/GLfz0a8Ng1ZhOLeStPhpSkEFuVFA7cMjjxw0tNvcjas5GubeG+3ps9LZjFbk1doWe136ve0DpopMwdm0ub1gk2ljfcrIORToYPoE1tLvHfu2cDl2RIG9XfDaRZT0YlbryxSMgAn6SWBGC1fPXzY3l8DIobT+vEbrqmFxR3xT9uNkj6Rr50O33wDz17HpYmP2f3lc97ipIfNKgubQ9nMW5x/4lgisPot+MblhWnTa2F3q9QOCJq8SZ0tJjmjeXPeIbdqxkTRDLnoedXxaaQxRcCbgzuDT2Wjtv2UdFiJ3/fu7JCk5KKaOV4gChvfo8XekNFyUHCjJSbmySNHNSi6qix/OpYiWmXOiVbeKleXdX1uikKR3/KXZMpZ6qAIC7SboEjUaYqVjQCfK9RoUrOOl9jINKuNH9A4O5xoZM4G3uKfi6F1Ou1ijGjoWKHIxc6ISPqoKqnDqNnRxnYJIyY3fauQ+lLb4hXLJHtPlxl24PB5XeKPkG/Uq8/tK2TMZWENWN69bXFDI6WnT/h73uY6HrqvZNTgHCAHxsV1gAkvjSUfhjghPW+9+NlFx4ZU1nU313LEWiN17tCc5FoLtkP33/tx+UGmtHURQir/RPvDulxsvVOgdvf2dG2Fy0SufY6SlhWQFCV0y6cjpBQaSXYbdXCjW3xiYMCLW/sFq+Ad1n9mAdM+0Y7NK6LliYEky3DORQXS0dpatnWH8PtXcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGs0MVlkd2h0WUwya0d6OVZ0VVA4ZnVJNmRBVnUvb3g1T2J1UWE2V29CRkk5?=
 =?utf-8?B?dmtmVS9NSjYvN2QvWnBreUVnUWpzS2kxSjkrMzRjQnRWb1M1TjNjS1VSOThn?=
 =?utf-8?B?YkhKcWY5ZEQ0dFlJRGVXZWg1ZXlxY1RtSEFlMk5uMGRHbkx4UndQc3JrSXdi?=
 =?utf-8?B?ak80ZnJJZDUzVTVFQ3YyQ1BCdlBKczEyR1dOWlIyUjhkZHZmVmdBcmN5WTkr?=
 =?utf-8?B?WnFpZWJRdlpIZFg1THIzaE81Z2dZTnRzNm5IQ3grUG9ObnNhUWNlVzVvcGpp?=
 =?utf-8?B?cEJtSmF3YUpGMGdZcFNScXJyMXc2MUhyWC9pV1M2VVUzTkRyT3RXSXI1VlhI?=
 =?utf-8?B?c0IyNitLR3dCRXFWUEp4KzZCL08zT292ZE9GZktDMHNOeWJEM3hiWU5uWnEx?=
 =?utf-8?B?OE5aMmM0RWNNYWZkVVlCWk9EM1V5ZVR0RXdKcG4vV1RVd3BSbFV1N0tiVE1K?=
 =?utf-8?B?VkUySFRYbjlCQXNVaTI1MWJoTEVWSXZxM1dlVkgyT1U5T1J0aWNya3Z1UnNy?=
 =?utf-8?B?bjVBdTdacFpGNkRkbGFqT0QzeWRyTE9ZczNDLzhvWDZOWVk3UER4cWh4YWhH?=
 =?utf-8?B?bmVkQlI5bThJTGtQaU1scVlmV3Z0Sk1IRndHcitOUit1Njl0Ry8xMjQwbnUr?=
 =?utf-8?B?UzF6K0kxTWVqSitOcTBsUFEvN0R6QXZBMGs1dEQ0YlhHd0d5VWVFYzJYMXho?=
 =?utf-8?B?Q1ozMkE5OHlGbXFIazFOekRXM0kyYXNhOWNiMDB2R2FiU3E1eW41bDRySUtP?=
 =?utf-8?B?eDNtcEN0Mk96czVzUGg1TTEzdzlNSjNxa3lZSTROcTU1bEo1bTIvNGxrdis0?=
 =?utf-8?B?SE40Y3VQTmFtYmtaRkFBd2xlelhyVFZPVWtMSmdVVHh2TWJuRGZLdS82QmV6?=
 =?utf-8?B?M2NwWVRnRVViWFRFQUY5T2pyeDJlNnBzc0VOdWZVWGZsSnhBK0RIbkNKNDVQ?=
 =?utf-8?B?eU4xOVUyOGNWclI0cE5zUXRCUFcyTVFkUkZhY2tNWEFiM3lra2hDWUdIVHdB?=
 =?utf-8?B?dC9McVdhN2c4Ymo5SDY1TGUrMGlwcWxtb2JMOW5HSXJkRXhHVFJSMzJRczJO?=
 =?utf-8?B?YU1TZys1Z3paaVl3cE5ybDROc1pMOG5HQ3F5bzhOZzcrRWo5RWtXM2NBa1dP?=
 =?utf-8?B?dXNwUGZDdm5iakVydVF3TDlqT1VHa25aaEs0K0VpWlUxOVB1djR6dHJ0N1Y5?=
 =?utf-8?B?UWp1bmJjalBtdEZFOTZYQTRiMlYxaFJjSE1GZlBVU0h3a2U0SlRLMnpMcElP?=
 =?utf-8?B?S0dTek0wRGpTeHNQMHRBWnZqVTNZNzZTakFoTFlBZDhxV1dVcHNPUGdJTVRy?=
 =?utf-8?B?TVg0Zi9QVzFlVkJhMXVWem1ZL2RXTXQzZ3V2K1FwcnFONWlJT0NqZlZKYzdt?=
 =?utf-8?B?TnVieHJmaXJDa2R3ZTlZOC9CTjV2NDJRZGlkd0ZpMmlCZmhhaDd5cXRKcmlC?=
 =?utf-8?B?d29nQ1hiT0ZCeVNVQXFJemlIMFNMSkpFbVcxK0xqZTRTRTBsMkhLSTUxT2tw?=
 =?utf-8?B?a0ZvaE0veDN3UVRFYmU3ZXVKL3FwNFFwa096WEVlajJkSjlCdVFKd05INDla?=
 =?utf-8?B?Kzg2K1BIZjJZcEoxbVZJY3RLd1JXRGg5aXpkQkNKNnEyU2lGRmk3TFFzL1pj?=
 =?utf-8?B?eVFlUXZzYU54ZlZXQ0RaWjhVNDVBR1N0TVBHMUhXRTNIYWs4ODdyRGZrKzM3?=
 =?utf-8?B?aUpYRmFvTDdzWUhnYSt1aTZyZHBaTENMVTVMdVc4UWxYT1U2VFUzUU8xayt5?=
 =?utf-8?B?Mkp3WDE2Tmg4NnlvUit0b01xYk1HWkdrUHByRkg2UmdIVTlYUXVqWGpXNlVs?=
 =?utf-8?B?NklmREN5cW1paHI4YndHM1pVcGhFaXl3OWh5Z1RWTzVFUG5EdnBFZUw0M2N6?=
 =?utf-8?B?Vis4UCt0b2FybnpHa1hLNm14RGNQbExCalZvYUo0a0dYejRGMko1K01OVG53?=
 =?utf-8?B?aXNqS3Y4ZENMUXN1TW51SHBsa3VXbUNGVHFHSEFXNktwbVFicTBRVy8wUlRu?=
 =?utf-8?B?Y1dKZ2JwaGV6OS9NWmx1WDJlTFU1cnkxVkRqM2F4RG9hYXY4b052UVQ0VHlY?=
 =?utf-8?B?aUY5VnlwazFQVXlGd3duRkZXdGE4RkNxeFNCUVBsUzI2dTVVNkhhUGJ6dmdq?=
 =?utf-8?B?dE1tdXB6dEl1VG5UTzZlU3E2MXdRVnZuZHk3MXo5UGxLMXZ1aEpFbFlOSnQ2?=
 =?utf-8?B?cmlxc1RpVnNadGxxNk1IUlA0Zkg1RExoYWtTU0dVOG9HNzJxR1ZZMUNCVUpZ?=
 =?utf-8?B?V0JGV1U4L0RheURSVkdOVXRtL295K0c0Y3FadVBZaHdQV2tsdWtkTEc2NUVv?=
 =?utf-8?B?OUxheEtjQkN3VXZpcGpNSklzS1JySlBQT1NLV3RiMyttZ3BSc1F0Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a31e34bc-a41b-4ebd-233e-08de79151b0a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 11:07:48.9580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cp/ycL3qiCAMBkbxKcrTHa2YCvJZdpsVZjXwZLyf7fVucvUDKqbbOPFv+cdXlZBXfS1efYcIu/C+1me0EJPpIFE8CPzFFfQMMMAVBk4yrTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9329
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

Hi Svyatoslav,

On 3/3/26 8:13 AM, Svyatoslav Ryhel wrote:
> пн, 2 бер. 2026 р. о 15:07 Quentin Schulz <quentin.schulz@cherry.de> пише:
>>
>> Hi Svyatoslav, Jonas,
>>
>> On 2/9/26 7:07 PM, Svyatoslav Ryhel wrote:
>>> From: Jonas Schwöbel <jonasschwoebel@yahoo.de>
>>>
>>> In the case of active-low behavior the Duty Cycle needs to be set to 100%.
>>> The PWM driver takes care of this but the LED_PWM driver does not take
>>> this into account. Adjust LED_PWM to take into account polarity of PWM.
>>>
>>> Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>> ---
>>>    drivers/led/led_pwm.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/led/led_pwm.c b/drivers/led/led_pwm.c
>>> index 15dd836509b..7edfa286468 100644
>>> --- a/drivers/led/led_pwm.c
>>> +++ b/drivers/led/led_pwm.c
>>> @@ -34,7 +34,7 @@ static int led_pwm_enable(struct udevice *dev)
>>>        if (ret)
>>>                return ret;
>>>
>>> -     ret = pwm_set_enable(priv->pwm, priv->channel, true);
>>> +     ret = pwm_set_enable(priv->pwm, priv->channel, priv->active_low);
>>>        if (ret)
>>>                return ret;
>>>
>>> @@ -52,7 +52,7 @@ static int led_pwm_disable(struct udevice *dev)
>>>        if (ret)
>>>                return ret;
>>>
>>> -     ret = pwm_set_enable(priv->pwm, priv->channel, false);
>>> +     ret = pwm_set_enable(priv->pwm, priv->channel, priv->active_low);
>>
>> This feels wrong. Why would both enable and disable paths use the exact
>> same value for pwm_set_enable()?
>>
> 
> Hello Quentin!
> 
> You are mixing up the LED with the PWM that controls it.
> pwm_set_enable() triggers a PWM configuration update; therefore, the
> process is the same for both enabling and disabling.
> 

Does it? All drivers in drivers/pwm actually write to their registers in 
the set_config callback, some even re-enable the PWM controller if it 
was running before entering the set_config function.

The sunxi driver notably does not do anything on set_invert callback, 
it's only applied on next call to set_enable.

pwm_set_enable() clearly states it's for enabling or disabling the PWM. 
So why would we call pwm_set_enable(,,false) in led_pwm_enable() if 
active-low property isn't set in the DT? Why would we call 
pwm_set_enable(,,true) in led_pwm_disable() if the active-low property 
is set?

>> I can also see that the disable path doesn't actually call
>> pwm_set_invert() unlike in the enable path. I'm assuming this means we
>> cannot call disable before enable and have consistent behavior?
>>
> 
> The inversion setting is only relevant when the PWM is enabled. Since
> the disable operation forces the duty cycle to 0, the inversion state
> is inconsequential.
> 

If you have inverted polarity, I'm assuming you need 100% duty cycle to 
turn the LED off.. So we definitely need to have the PWM running and the 
inversion setting configured, no?

>> The kernel seems to use active_low as a way to invert the duty cycle if
>> I'm understanding the code properly. In U-Boot, it seems we don't handle
>> that at all and always pass the "normal" duty cycle. Maybe there's
>> something we need to do there.
>>
> 
> In U-Boot PWM should handle this in the set_invert operation.
> 
>> I'm also assuming there are setups where PWM should be enabled but with
>> a duty cycle of 0?
>>
> 
> A duty cycle of 0 is equivalent to pwm being turned off. In general

I don't think that's necessarily true? What happens to the PWM pin when 
the PWM controller is disabled? You're not driving the line low (or high 
for inverted polarity) so who's to say the state of the LED is off?

> most devices won't work on very low duty cycles. Fan needs at least
> 30%, LEDs make no sense below 10%, also most Display are not usable
> below 10%
> 
>> I'm also unsure what's the difference between active-low and
>> PWM_POLARITY_INVERTED (I've seen them both mentioned or mixed in the
>> kernel DTSes).
>>
> 
> These are properties of two different device classes: active-low is
> used with PWM-LEDs, while PWM_POLARITY_INVERTED is strictly a PWM
> property.
> 

Sure... but don't they mean the same thing? It seems we are not reading 
the flag property in the PWM cell in the PWM LED driver and only read 
the active-low property to decide on the polarity. What are we supposed 
to do if we only have one of both enabled? Assume it's inverted 
polarity? Then what do we do if both are enabled, is it doubly-inverted, 
meaning normal polarity? Or is it a simple binary OR?

I unfortunately don't have HW to test this.

Cheers,
Quentin
