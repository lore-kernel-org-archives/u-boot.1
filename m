Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1F5C5B572
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 12:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70E3D8123D;
	Wed, 12 Aug 2026 12:46:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J0--L2jalSc8; Wed, 12 Aug 2026 12:46:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8030B81239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786538809;
	bh=KcwV3ztOuACBu+9Dtz41slxccs5DQDcAX+DYKZ8dl+k=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Tw/QGE24aFC+5YeefsShuDQd00ZJCt3RMzk8WGEbaxU2vCU5TZrqUpJLUEDD9fwej
	 +HtsQrq5LrPVWtb0xYlpAg1z1LJdexyAduHqzKgjcPhBDWP/W8PsMU6YE9eZUFKWto
	 IOxY3qeIaxiKuaulvfOmGt7OHuk0FKJN7srBxENH6rGrObbwYKuigQbWSuzDI5QwxU
	 NLZDdzVoCISK03OzjzWnI5vI4Mk92YJcSMORqrf5dNfsxvstQAw871kRcNQ7SMew00
	 /IW1TNMMMVDA4RDvJhjhxSAfX/3G2k/Q7nkwQHjxnYMpj012P2Hec1ociWSX0dFjAk
	 Sgrat1w6RBm3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8030B81239;
	Wed, 12 Aug 2026 12:46:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E17D43A4
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 12:46:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D377D60674
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 12:46:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0LAtcKtlCMQX for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 12:46:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.9;
 helo=smtp-bc09.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 57328605AC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57328605AC
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [45.157.188.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57328605AC
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 12:46:44 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hKpCQ42JvzJHq;
 Wed, 12 Aug 2026 14:46:42 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hKpCP18WmzVSW; Wed, 12 Aug 2026 14:46:40 +0200 (CEST)
Message-ID: <3401575e-f03f-4c4a-a84f-1adb27eb2c21@0leil.net>
Date: Wed, 12 Aug 2026 14:46:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] clk: rockchip: rk3506: Fix CLK_SARADC set rate issues
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-5-jonas@kwiboo.se>
 <a27ec69a-30a0-45bf-8eac-77344670053b@0leil.net>
Content-Language: en-US
In-Reply-To: <a27ec69a-30a0-45bf-8eac-77344670053b@0leil.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786538802;
 bh=KcwV3ztOuACBu+9Dtz41slxccs5DQDcAX+DYKZ8dl+k=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=VkI0lyktg6OjV7Yhr9VpeoQBRuOhVkFH/3LbF68DNzpSDw2pgieBMxHIjdmRIp7Sr
 c9dMDYNCVmh6QjepsYojZHvMb3cCq/Kc/AuytKh5QlFvnkcHth9O7iE6N5pzDmwO7e
 PrcjIvsSC79wpUqjUcF14F79qcdVQ1SNbpdPJaZ6znZh8bKKrv8+IlCXSVHCbBEzna
 LfuJFPrsJ95G+2TnLxo7wmYxJP9t+alMihf9mq8jyLNdrmZbSVWTmJ2OYcfdYRGHfM
 /V1DuXZmUrDTqKg24Kl/TcpD29Tin5b3cTh8SJrYo4c2gmlp3Pbhj5FDZrfua4FnKZ
 lL4Of+CqT0mUA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=VkI0lykt
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

On 8/12/26 12:40 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/3/26 9:09 PM, Jonas Karlman wrote:
>> The set_rate ops for the CLK_SARADC clock in RK3506 clock driver
>> force use of 32 KHz or 400 KHz rates when any requested rate is
>> divisible with 32 KHz or 400 KHz.
>>
>> Adjust logic to better match the 32 KHz, 400 KHz or 1.5-24 GHz rate
>> limitation of the CLK_SARADC clock in RK3506.
>>
> 
> Same typo as previous patch, it's MHz and not GHz. Same remark as 
> previous patch, the divider applies to any of the parent clock so the 
> 1.5-24MHz is kinda misleading.
> 
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   drivers/clk/rockchip/clk_rk3506.c | 13 +++++--------
>>   1 file changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/ 
>> clk_rk3506.c
>> index 457082eea87b..e156bf19a6b4 100644
>> --- a/drivers/clk/rockchip/clk_rk3506.c
>> +++ b/drivers/clk/rockchip/clk_rk3506.c
>> @@ -440,22 +440,19 @@ static ulong rk3506_sdmmc_set_rate(struct 
>> rk3506_clk_priv *priv, ulong clk_id,
>>   static ulong rk3506_saradc_get_rate(struct rk3506_clk_priv *priv, 
>> ulong clk_id)
>>   {
>>       u32 con, div, sel;
>> -    ulong prate;
>>       con = readl(RK3506_CLKSEL_CON(54));
>>       sel = FIELD_GET(CLK_SARADC_SEL_MASK, con);
>>       div = FIELD_GET(CLK_SARADC_DIV_MASK, con);
>>       if (sel == CLK_SARADC_SEL_24M)
>> -        prate = OSC_HZ;
>> +        return DIV_TO_RATE(OSC_HZ, div);
>>       else if (sel == CLK_SARADC_SEL_400K)
>> -        prate = 400000;
>> +        return 400000;
>>       else if (sel == CLK_SARADC_SEL_32K)
>> -        prate = 32000;
>> +        return 32000;
>>       else
>>           return -EINVAL;
>> -
>> -    return DIV_TO_RATE(prate, div);
> 
> I'm not sure this is correct. The divider applies to any parent clock 
> and this applies the divider only to the 24MHz parent clock.
> 
>>   }
>>   static ulong rk3506_saradc_set_rate(struct rk3506_clk_priv *priv, 
>> ulong clk_id,
>> @@ -463,10 +460,10 @@ static ulong rk3506_saradc_set_rate(struct 
>> rk3506_clk_priv *priv, ulong clk_id,
>>   {
>>       u32 div, sel;
>> -    if (32000 % rate == 0) {
>> +    if (rate <= 32768) {
>>           sel = CLK_SARADC_SEL_32K;
>>           div = 1;
>> -    } else if (400000 % rate == 0) {
>> +    } else if (rate == 400000) {
>>           sel = CLK_SARADC_SEL_400K;
>>           div = 1;
> 
> This is also not correct.
> 
> I think what you want instead is to modify div to not be always 1 but 
> rather 32000 / rate and 4000000 / rate.

Is any of those two clocks externally provided by any chance? Heiko told 
me the 32K clock is generally externally provided, usually by an RTC, 
and thus I believe we really shouldn't allow those clocks to be selected 
if they indeed are external. I don't think we have a mechanism in place 
to enable the external clock and make sure it's running at the expected 
clock rate. So maybe the answer is to actually remove support for 
anything but the 24MHz clock for the SARADC (and other IPs whose parent 
clocks can be clk_rc and/or clk_deepslow).

Cheers,
Quentin
