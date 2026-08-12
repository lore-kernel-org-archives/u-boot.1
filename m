Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBBCC5B572
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 16:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB63760A51;
	Wed, 12 Aug 2026 16:48:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eNKTARAtm930; Wed, 12 Aug 2026 16:48:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A2FF607FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786553333;
	bh=r5zwrGwoOMLUFjGeKVjTYD2Ub4CfUdhwNwVhpT8f4wc=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=olzXp0q0dcmuPvxqB6EzTo+V2NDBWimLRxy4rOZb3YuPnjJlapkGPVVYZNH62Q3IX
	 RtjVMrDwoBsuxsfrbdulBkE7ytgntEIBk8XAg0diLUazVJSMrzgmB3VTx2jmgPuINk
	 SBy3NJYY9FWJYnqzaBJsgMR3yHAtS+PVAR9m9MHeXXbDPiUl/xBpYyXGZmxn0D06Xp
	 kMJn0p/mPYk+2WaCK5yw1Y1lF3WCSyz73hQnHE346D3bAfvuVyKIr7k4WhDtpHsyDo
	 ApQLEyO44ay5xkDU4llvFXEhkYwIEQB7B0DwfKvrSGB8tztQ3MNzuQeSZHmB9j+D4B
	 +T4aY4RPWEncA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A2FF607FF;
	Wed, 12 Aug 2026 16:48:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 78057270
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 16:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 544C581007
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 16:48:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UEdeizd7LFSr for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 16:48:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.12;
 helo=smtp-190c.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 24E5780E4F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24E5780E4F
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [185.125.25.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 24E5780E4F
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 16:48:48 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hKvZj6twGzmdY;
 Wed, 12 Aug 2026 18:48:45 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hKvZh6SnXzbp5; Wed, 12 Aug 2026 18:48:44 +0200 (CEST)
Message-ID: <c613cf1a-9fa7-4f9f-abdc-b3130d18e9c4@0leil.net>
Date: Wed, 12 Aug 2026 18:48:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] adc: rockchip-saradc: Add driver data for RK3506
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-4-jonas@kwiboo.se>
 <ca0eef0e-4e4e-49f9-82bc-d498d54ddd3c@0leil.net>
 <64823d5b-2e70-47b0-b071-82651e7b1968@kwiboo.se>
Content-Language: en-US
In-Reply-To: <64823d5b-2e70-47b0-b071-82651e7b1968@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786553325;
 bh=r5zwrGwoOMLUFjGeKVjTYD2Ub4CfUdhwNwVhpT8f4wc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JlNMAcPnmtJ66PgLlxs9RNt34lO6tAj81ZcDoNT+EgjMhV3wYkVVJ9+jnfABJXait
 /lcMI1fRjrV2vqjIB926ZKoOdQwJ+EQkIM8FpLWaP0NnT1ttHa8KVXYhZoUTis9Jnr
 yc3jGxjQi5k8Hn0RK17rMXrk1oqoAPPQfYQ7S3iKgtaBVw6jGCdqGtbY7hZSWRMU8L
 sMBJRRQcxog8+y7mJsEWXW8P8+uJopcSskH7wXiYYBSQir31/KzrnCSLbtkk6Ut0lY
 IlEJ2kDNbMd6v1xgKKd+VrHRQbdoK/SGeXE9Fto4XUcoAKDeRgRJfpyup/Yw+aO/I1
 XyoZZhPFVXxXA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=JlNMAcPn
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 8/12/26 6:20 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 8/12/2026 12:33 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 8/3/26 9:09 PM, Jonas Karlman wrote:
>>> Current rockchip,rk3528-saradc fallback instruct the driver to use a
>>
>> There is no rk3506 DTSI available either in Linux kernel or U-Boot, so
>> this fallback technically doesn't even exist and we don't have an issue
>> (yet). Just say that none of the the v2 SARADC data match what the
>> RK3506 can do (due to the divider and parent clocks not being able to
>> achieve the requested 1MHz). Please simply rename the commit title to
>> reflect you're adding support for the SARADC found on the RK3506.
> 
> Sure, I will update the commit message in a v2.
> 
> The rk3528 fallback mentioned was in reference to the dt-bindings:
> 
>        - items:
>            - const: rockchip,rk3506-saradc
>            - const: rockchip,rk3528-saradc
> 

Ha! Completely missed that, thanks the clarification.

>>
>>> 1 GHz clock rate. However, the CLK_SARADC used on RK3506 can only be
>>> configured to use a 32 KHz, 400 KHz or 1.5-24 GHz rate.
>>>
>> This is quite misleading. The parent clocks are 32KHz, 400KHz or 24MHz.
>> The divider is between 1 and 16.
> 
> You are correct, I must have mixed up this clock with a different clock
> that had multiple parent options and the divider was for one of those
> parent options.
> 
>>
>> This means that 1MHz is not achievable with the dividers and we need to
>> aim for something else. Please reword the commit log to reflect this.
>> I'm also not sure where people got 32KHz, 400KHz and 24MHz but it's
>> what's specified in the Linux kernel, so fine with me :)
>>
>>> Add driver data for rockchip,rk3506-saradc that request use of a 1.5 GHz
>>> clock rate, to avoid clock divider overflow in the RK3506 clock driver.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>    drivers/adc/rockchip-saradc.c | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
>>> index 1515951403c9..50861b61eea4 100644
>>> --- a/drivers/adc/rockchip-saradc.c
>>> +++ b/drivers/adc/rockchip-saradc.c
>>> @@ -339,6 +339,14 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
>>>    	.stop = rockchip_saradc_stop_v1,
>>>    };
>>>    
>>> +static const struct rockchip_saradc_data rk3506_saradc_data = {
>>> +	.num_bits = 10,
>>
>> It has 12 bits according to the TRM.
> 
> Hum, in the datasheet for RK3506J v1.2, RK3506B v1.4, RK3506G2 v1.5 and
> RK3506 TRM v1.1/v1.2 it lists 10-bit resolution.
> 

Well, I read the register description and it says 11:0. But the first 
sentence in the SARADC section says "10-bit"... sooooo /me shrugs. 
Ideally, we should check whether the ADC returns close to 1023 (10 bits) 
or 4095 (12 bits) when it's fed 1.8V and then we would know for sure :)

Cheers,
Quentin
