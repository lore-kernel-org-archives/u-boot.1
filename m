Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D71DC5AD44
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 20:41:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1947080B3D;
	Sat,  8 Aug 2026 20:41:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UaF-v37SuDeB; Sat,  8 Aug 2026 20:41:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86E0680B11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786221711;
	bh=he8jub8cLJgcAfjUILqNbf1IS/zmg6kNl8hZLLW0zWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aIAa1wfdwwftz7w7wwl98KHb7NF1nB49O6aNDainHAYVsVcqMGETcITMIR/ipgARH
	 10vzNMggcfxLIOq4ftQ5j9cnuUI7z0CywUgX2IxhXK/dVV2/9GSzWGd9Itazio5IFp
	 LgT/+m+ZbnQTAqb7JMPVr1pQJrLZy8g0Z+VcZTltKBElKGG3GhgdWNqc/KsloVS+W1
	 eULliZZrSSfMcLRT2PbhrVlFof2AMrO3Abokf6eO96ZI8Eyne7PGecwVVu459orp5+
	 71lczV6Ad7whqu1tNS/t9VycGEMoNqKB55dxDJdt+MAtf05emh1Hta0fjvEXMoUjpa
	 qanNsO4yZVbZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86E0680B11;
	Sat,  8 Aug 2026 20:41:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C65AA296
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 20:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC239403E4
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 20:41:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wIc_oVcsVlKe for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 20:41:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b70c=gc=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E75794034F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E75794034F
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E75794034F
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 20:41:47 +0000 (UTC)
X-Forward-Email-ID: 6a779482bc4c5c3a0ebab63d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.10
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <799cedbc-9569-4865-90a8-14ce779825ac@kwiboo.se>
Date: Sat, 8 Aug 2026 22:41:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] clk: rockchip: rk3506: Fix CLK_SARADC set rate issues
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang
 <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, u-boot@lists.u-boot-project.org
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-5-jonas@kwiboo.se>
 <CAFLszThN9ivtWft4VcM6SHZ8-yorzgsOqyFSqVTgsxV_3oq7Rw@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszThN9ivtWft4VcM6SHZ8-yorzgsOqyFSqVTgsxV_3oq7Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1786221707;
 bh=he8jub8cLJgcAfjUILqNbf1IS/zmg6kNl8hZLLW0zWE=;
 b=XpG9P94Mcuwl9UbSgAuhi6XJ0OqT2ZAABy80LW4bXoZQ2fCfBobJdE0FFUoBIKPZkTfngBx+v
 k7Us5F1tIPc1KYKPMUFbxopA2QDrMiII/g5jpF2a8f0ODZF0RuXUS658AL0PjHNS3lD8D9yDzFG
 66/bP/tr+evHp9zBjIiPT5LzFgynmNrZwMLCyPoJVtzfG7hkYUFzIHYYFB/7G0WFBlYprFLlH+3
 pZ8Ho39jI10p22fgTR2/esM8+78mMNwCJtNuooMeF/LNuqsp6VR87ZNss/elbX5iDfXKKMhiYT7
 C3r2vvBwtLljQQ4KUeghT7bnjy/E+dTUs623i8v8sQAw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=XpG9P94M
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
>> clk: rockchip: rk3506: Fix CLK_SARADC set rate issues
>>
>> The set_rate ops for the CLK_SARADC clock in RK3506 clock driver
>> force use of 32 KHz or 400 KHz rates when any requested rate is
>> divisible with 32 KHz or 400 KHz.
>>
>> Adjust logic to better match the 32 KHz, 400 KHz or 1.5-24 GHz rate
>> limitation of the CLK_SARADC clock in RK3506.
> 
> Shouldn't that should be 1.5-24 MHz, not GHz?
> 
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>
>> drivers/clk/rockchip/clk_rk3506.c | 13 +++++--------
>>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
>> diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
>> @@ -440,22 +440,19 @@ static ulong rk3506_sdmmc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
>>  static ulong rk3506_saradc_get_rate(struct rk3506_clk_priv *priv, ulong clk_id)
>>  {
>>       u32 con, div, sel;
>> -     ulong prate;
> 
>>
>>       con = readl(RK3506_CLKSEL_CON(54));
>>       sel = FIELD_GET(CLK_SARADC_SEL_MASK, con);
>>       div = FIELD_GET(CLK_SARADC_DIV_MASK, con);
>>
>>       if (sel == CLK_SARADC_SEL_24M)
>> -             prate = OSC_HZ;
>> +             return DIV_TO_RATE(OSC_HZ, div);
>>       else if (sel == CLK_SARADC_SEL_400K)
>> -             prate = 400000;
>> +             return 400000;
>>       else if (sel == CLK_SARADC_SEL_32K)
>> -             prate = 32000;
>> +             return 32000;
> 
> The commit message only mentions set_rate, but this changes get_rate
> to ignore the divider on the 32K/400K paths. Please mention this and
> explain why - I assume the hardware divider is only wired to the 24
> MHz mux input, but that isn't obvious from the code. Also div is now
> read but unused on those two paths.

The divider is configured to 1 in set_rate path, so this change is a
simplification to ensure the ops for CLK_SARADC works as expected had
set_rate been run.

The commit message already mentions that logic is adjusted to better
match the limitation of the CLK_SARADC clock.

> 
>> diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
>> @@ -463,10 +460,10 @@ static ulong rk3506_saradc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
>>  {
>>       u32 div, sel;
> 
>>
>> -     if (32000 % rate == 0) {
>> +     if (rate <= 32768) {
>>               sel = CLK_SARADC_SEL_32K;
>>               div = 1;
> 
> The threshold 32768 is odd given that get_rate reports this source as
> 32000 - please pick one value and use it consistently, or add a
> comment. I suspect the real source is 32.768 kHz, in which case
> get_rate should return 32768.

I would also think it should be 32768, however TRM only state 32K and
vendor U-Boot use 32000.

Due to this uncertainty and how the fallback use a very narrow divider
field, 4-bits, it is more appropriate to check for <= 32768 or rate
may have fallback to 1.5-24 MHz depending on bits [3:0] of the
DIV_ROUND_UP(24000000, rate)-1 when close to 32 KHz is requested.

I still think this change fits under adjust logic to fit clock
limitations.

Regards,
Jonas

> 
> Regards,
> Simon

