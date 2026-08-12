Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EE0C5B56A
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 17:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAFC781205;
	Wed, 12 Aug 2026 17:08:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vGJRodpgGfa3; Wed, 12 Aug 2026 17:08:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 229228120C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786554502;
	bh=HgDNNwwGxYxZ3oRQWMSM+pKGk6HiGFYPvrkZZ7kVJ/Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xIvJGXur++ZGanNi7qicodmhMjyVlchN00c3/3ep1ldti5SQQUuaG9GJt8tTzRLGh
	 f8zHqTBM3SuLqDBSEiRrf8FNyUgiYn5G3eh0kpBszfa6J23GZGZVTu93hK8Ffd34J3
	 1cJRftKd85pUtA8TgK4eGtqnJzFmiFQCVc3HLI1JKTlkw7Zf2qEHy52tmxWZdjMoWx
	 ysnmS1N/lh5iUltOxLNWQCPmmTdw4DHMthe8U6sasFUhXRyh+VOENxsIo+cF1h0wQb
	 OgOwMI9n4PEWTFjKMZ771og7IZXcP+xys/3ShR5zjYNDX3WnbNkrg5uSyKf70lOlb9
	 9sNTHGkWaF34g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 229228120C;
	Wed, 12 Aug 2026 17:08:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EF286270
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 17:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E14588120C
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 17:08:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZAUbrodn2Ajp for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 17:08:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f498=gg=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E15E081205
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E15E081205
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E15E081205
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 17:08:19 +0000 (UTC)
X-Forward-Email-ID: 6a7ca881cf67b390aab71fae
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.13.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <ede92cc8-2f36-470b-8e7a-bdb04f723b03@kwiboo.se>
Date: Wed, 12 Aug 2026 19:08:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] adc: rockchip-saradc: Add driver data for RK3506
To: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-4-jonas@kwiboo.se>
 <ca0eef0e-4e4e-49f9-82bc-d498d54ddd3c@0leil.net>
 <64823d5b-2e70-47b0-b071-82651e7b1968@kwiboo.se>
 <c613cf1a-9fa7-4f9f-abdc-b3130d18e9c4@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <c613cf1a-9fa7-4f9f-abdc-b3130d18e9c4@0leil.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1786554498;
 bh=HgDNNwwGxYxZ3oRQWMSM+pKGk6HiGFYPvrkZZ7kVJ/Q=;
 b=YzLwEN3XP0WfLai/JsTrrImYVhVXnAOdYUWQWUez2mN0mlYz3VqjACxYbbzVJeBZePz+7JfcK
 Ovi3kf8L469uFhM/OHCpilk6ZPx39PHQ736YsJpzvYsFT+ADgw5ps4pKulYj07p7AFRN9Q0uCHo
 dTP6OlyVzH+osxiz5qQ1whhmQb+xlydPY/q9k/8Noboom9nsV/Emw+bcC/k2TlgdV8vagTc2ucJ
 O12XP+vO0PCGivb+aE2xY+UmmCK3PgbtP+K1zXHB7kXiNIGmBFLknDcQZYswh0dprb3cocNDdSC
 WztYlWIw9Lzts6FCrcSz50SrXlE7bmL/dINo+vljVWuA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=YzLwEN3X
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Quentin,

On 8/12/2026 6:48 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/12/26 6:20 PM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 8/12/2026 12:33 PM, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 8/3/26 9:09 PM, Jonas Karlman wrote:
>>>> Current rockchip,rk3528-saradc fallback instruct the driver to use a
>>>
>>> There is no rk3506 DTSI available either in Linux kernel or U-Boot, so
>>> this fallback technically doesn't even exist and we don't have an issue
>>> (yet). Just say that none of the the v2 SARADC data match what the
>>> RK3506 can do (due to the divider and parent clocks not being able to
>>> achieve the requested 1MHz). Please simply rename the commit title to
>>> reflect you're adding support for the SARADC found on the RK3506.
>>
>> Sure, I will update the commit message in a v2.
>>
>> The rk3528 fallback mentioned was in reference to the dt-bindings:
>>
>>        - items:
>>            - const: rockchip,rk3506-saradc
>>            - const: rockchip,rk3528-saradc
>>
> 
> Ha! Completely missed that, thanks the clarification.
> 
>>>
>>>> 1 GHz clock rate. However, the CLK_SARADC used on RK3506 can only be
>>>> configured to use a 32 KHz, 400 KHz or 1.5-24 GHz rate.
>>>>
>>> This is quite misleading. The parent clocks are 32KHz, 400KHz or 24MHz.
>>> The divider is between 1 and 16.
>>
>> You are correct, I must have mixed up this clock with a different clock
>> that had multiple parent options and the divider was for one of those
>> parent options.
>>
>>>
>>> This means that 1MHz is not achievable with the dividers and we need to
>>> aim for something else. Please reword the commit log to reflect this.
>>> I'm also not sure where people got 32KHz, 400KHz and 24MHz but it's
>>> what's specified in the Linux kernel, so fine with me :)
>>>
>>>> Add driver data for rockchip,rk3506-saradc that request use of a 1.5 GHz
>>>> clock rate, to avoid clock divider overflow in the RK3506 clock driver.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>>    drivers/adc/rockchip-saradc.c | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
>>>> index 1515951403c9..50861b61eea4 100644
>>>> --- a/drivers/adc/rockchip-saradc.c
>>>> +++ b/drivers/adc/rockchip-saradc.c
>>>> @@ -339,6 +339,14 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
>>>>    	.stop = rockchip_saradc_stop_v1,
>>>>    };
>>>>    
>>>> +static const struct rockchip_saradc_data rk3506_saradc_data = {
>>>> +	.num_bits = 10,
>>>
>>> It has 12 bits according to the TRM.
>>
>> Hum, in the datasheet for RK3506J v1.2, RK3506B v1.4, RK3506G2 v1.5 and
>> RK3506 TRM v1.1/v1.2 it lists 10-bit resolution.
>>
> 
> Well, I read the register description and it says 11:0. But the first 
> sentence in the SARADC section says "10-bit"... sooooo /me shrugs. 
> Ideally, we should check whether the ADC returns close to 1023 (10 bits) 
> or 4095 (12 bits) when it's fed 1.8V and then we would know for sure :)

I did a quick 'adc scan' test on my ArmSoM Forge1.

With '.num_bits = 10':

  => adc scan adc@ff4e8000
  [00]: 1019, 1792961 uV
  [01]: 1019, 1792961 uV
  [02]: 0, 0 uV
  [03]: 1011, 1778885 uV

And with '.num_bits = 12':

  => adc scan adc@ff4e8000
  [00]: 1019, 447912 uV
  [01]: 1019, 447912 uV
  [02]: 0, 0 uV
  [03]: 1011, 444395 uV

RK3506G_REF_V11_20241114 lists ADC 0-1023 in the SARADC_IN0_BOOT table,
with 1023 for FSPI--SDMMC(eMMC/SD Card)--USB/SPI2APB.

So with this data I think 10-bit should be correct, without having to
measure or apply 1.8v on an ADC pin.

Regards,
Jonas

> 
> Cheers,
> Quentin

