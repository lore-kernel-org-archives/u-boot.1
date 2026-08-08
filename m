Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC887C5AD4E
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 20:20:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0284480974;
	Sat,  8 Aug 2026 20:20:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5sG3AeLuyZaE; Sat,  8 Aug 2026 20:20:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D9CFA80972
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786220406;
	bh=jK/m8yh7jtPnwSD1jaHIIlRBGAPenIiShJIh5sb6oEY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CqIKNb6mesGU37oaEYPzZiooGvWwLmQNme5I5YoGzkSw0pz7yApg4IqcMC+w65rFF
	 QVM+TTNi1qjsTAPQB6/YMTOJ92DTqUYiR6PRRYJVaefQd3Coy18l7Jco69/uzj0HR+
	 2QWw5I3JnRq6NFcSJcUoDIK2SHeYMZpXImZQrXFDxRQSEC6+zpvgh9CqINEmAmYWc9
	 SHGNaIopBpO9QKzL1/zR8K6epB4m6mA+LoAhmzNXUIlWnErybuXGNO5zWyoRT8810B
	 hjpxY557lqHpPSGOGxnKwtmxGTlt/ktvmlOtCydC0pU5ymidnaMFvUrjG2TlSVSU2O
	 yj44mKMSYNWXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9CFA80972;
	Sat,  8 Aug 2026 20:20:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 20CAB2F5
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 20:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1344180972
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 20:20:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ohcpAOEHayPf for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 20:20:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b70c=gc=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 574D980971
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 574D980971
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 574D980971
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 20:20:03 +0000 (UTC)
X-Forward-Email-ID: 6a778f6e1d349bd11180a028
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.10
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c5f7b272-1724-4a68-8efd-a6e5dd010741@kwiboo.se>
Date: Sat, 8 Aug 2026 22:19:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] adc: rockchip-saradc: Add driver data for RK3506
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang
 <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-4-jonas@kwiboo.se>
 <CAFLszTi9GQNih7W338r2PtfNJoY8TEgCqTNKT=6rCbH67MAefA@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTi9GQNih7W338r2PtfNJoY8TEgCqTNKT=6rCbH67MAefA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1786220402;
 bh=jK/m8yh7jtPnwSD1jaHIIlRBGAPenIiShJIh5sb6oEY=;
 b=FDsqJwixjMLebKRTnPaW0iEXd3XnzlQtGcqL9fAABh5Hn48fCafud1ruxAdggpM0w2AMDz06+
 02HXLUeYtOnIuuvOiAPBl9vZRZ65PJagtoQwI0LrmhkSbqxDBOBX7/Q3CZvU4Upah0KceycFgYh
 texrhlx2VZgu5Vrk8/ZyLFqEC1Tafu8lwCsgifByR92xPnJJYVyAlxJKIHWTmgU/orDBs3CGaO6
 8yGYJ22nlCm24xkF9TcWCtpuAunBhUz/TSTdvVds/pgBqj+1/+FCv/zrEKg3O1XksefBV6UCd46
 EQahtFUaahhb2DaVG3SBWBA2GCucqCV7H2EvWOMVqsBg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=FDsqJwix
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

Hi Simon,

On 8/8/2026 7:39 PM, Simon Glass wrote:
> Hi Jonas,
> 
> On 2026-08-03T19:09:38, Jonas Karlman <jonas@kwiboo.se> wrote:
>> adc: rockchip-saradc: Add driver data for RK3506
>>
>> Current rockchip,rk3528-saradc fallback instruct the driver to use a
>> 1 GHz clock rate. However, the CLK_SARADC used on RK3506 can only be
>> configured to use a 32 KHz, 400 KHz or 1.5-24 GHz rate.
> 
>>
>> Add driver data for rockchip,rk3506-saradc that request use of a 1.5 GHz
>> clock rate, to avoid clock divider overflow in the RK3506 clock driver.
> 
> Units look wrong throughout - clk_rate is in Hz, so 1000000 is 1 MHz
> and 1500000 is 1.5 MHz, not GHz. Please s/GHz/MHz/ in all four places.
> Also 'instruct' -> 'instructs' and 'request' -> 'requests'.

Hehe, you are correct, it should be MHz and not GHz :-)

> 
>>
>> Add driver data for rockchip,rk3506-saradc that request use of a 1.5 GHz
>> clock rate, to avoid clock divider overflow in the RK3506 clock driver.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>
>> drivers/adc/rockchip-saradc.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
> 
>> diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
>> @@ -339,6 +339,14 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
>> +static const struct rockchip_saradc_data rk3506_saradc_data = {
>> +     .num_bits = 10,
>> +     .num_channels = 4,
>> +     .clk_rate = 1500000,
>> +     .channel_data = rockchip_saradc_channel_data_v2,
>> +     .start_channel = rockchip_saradc_start_channel_v2,
>> +};
> 
> Just to check - the other v2 entries (rk3528, rk3588) also omit .stop,
> so this matches the existing pattern. Is that deliberate because v2
> hardware auto-stops, or is a stop_v2 callback missing? A brief note in
> the commit message would help.

To my knowledge the v1 needs to be power up/down, hence start/stop. And
the v2 only need to do initial configuration for single read, and the
interrupt is acknowledged as part channel_data, after first waiting for
said interrupt and reading out the data. As you mention this is just a
copy of the rk3528 (fallback) driver data, so not sure what you want me
to mention related to this.

Regards,
Jonas

> 
> Regards,
> Simon

