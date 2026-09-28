Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC95CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 11:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F33180CC4;
	Mon, 28 Sep 2026 11:27:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yghdi7EALfGU; Mon, 28 Sep 2026 11:27:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7AFE880CAB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790594858;
	b=IHAljzn9T5RB3nWPwv4FImvszuo+aakS/ePEs6P1/Tkh/QQPI428mbl5SSjRFM4uNHVk
	 uQTDdT75i6VyXnNr7cCk4gLPjbhmlDOc+fkvsChbcxn/2Mgs7dy+4H6VIBTlffSQ6evNp
	 Ppw77Gg5OEoR5L3LmKGSxl8uVd+jhtO5bYrWeg8t+dV/QKR2o6qUhgxPs/OgfjxhF8qSa
	 eXjIAtIrRuwUAQcP5PctQ517oC+chWKjAzamjHUACjiiE21a/BYQB6LVQLJ2kK4kvVjAY
	 0J27M6I8axl+9D6/DpdJzugTR72/GCLEBBmf80/4NMDE6rYOdSTCUVKJrRiOqisGewA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790594858;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=u5Mc4G182hL/nIW5qxrYYeGvtRlUkwTlTDGFqa3c8Os=;
	b=P+iyVa8xKFL9bzd51MZsHmqziHmakxWtnDhRzXCjpOI0PgGVHcqNLK3M8l2NyFRJwkpA
	 t1JJTO1rHu4vLlhqdFY7LUFsElNZjRmbEojqgcilnAb9qrycmM5K7dafhwPvoIeIWLm3d
	 ENwXhmZwbr1WJx9vwyfiNCm1k6GueK7+dPFTZtaD95wIrcnNzHiUPK+VV9949AjXEt3jH
	 ipACHdo4hmTWHIdwYK+CtMedoM9E11HI0QXLxtloR3vNCh3kj905u9I1a4X5QFUCAUsjw
	 jW4fxADOk9gb7KAp7UmO4m2y8rsoNc+fJQ4kUsN+XzfwSFNxNtGmP2ecYisHP5dB5Yw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790594858;
	bh=u5Mc4G182hL/nIW5qxrYYeGvtRlUkwTlTDGFqa3c8Os=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K+0HunEt3QQg9IPl8+pJD39veNPpSVYGgiJAY2coGz4qBsHQR90OusPoMHPM2DtdB
	 whoLEddyKX4nYZERkcxaHTD0UO/bFRk45tM/dJ3fexusZ4AUmtJLiK7bjleL18irxS
	 kejnJ9xBsL7YKDUgo/lwC84U8g3Yn0uEGdk6ELNE6w4pkYuH9liKRrjSnE2VubzKZm
	 9i8OO2DdEp9JKMJfKVGs+T27sMrGtlnM77nywyKFMTVujSdY5BeA+7R7J8ZIbhaEe9
	 0swGCFwutj79S1JFY73MAcgQFXDs8juxNvCNDa32K8RGw9Z9o+bSMrPjnRND+F2wo8
	 0OYfnJulxkSAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AFE880CAB;
	Mon, 28 Sep 2026 11:27:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CE36224E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:27:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B49856061F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:27:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id od7vTZwAocKd for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:27:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A125C60631
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790594855;
 b=J4ZhnztXCGCSMwNjOIRGgfWvGjUcA4La70zkyJoyl1ZTu7D3mmm9OVkXtU9xznNPaDfc
 /+FM2+9WLO8TCfQcSLI0Raz+bNaQlaa3pvTsdpzmeeYhYqUEy7spt6QA8ieUSgiAcgEr1
 3FT4DC+tR2TuxVc56U14SvQO8omE09Vz+HlDLCA01CnR2gU/BpYSelitAZc7+I9pJyexY
 TmTbb5KG8NTSQo48e6ZCkin/cHnHtTs8jp+ddDMT1FIPtFisYnyMIEVVhtWjPipOwS5DT
 bzW4fdOl/my06tjv/i5eeBcaUFSKqmYnDyToEBMS0U/Iq/1H+pYxbDubREH0BgHijFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790594855;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=u5Mc4G182hL/nIW5qxrYYeGvtRlUkwTlTDGFqa3c8Os=;
 b=P3xnqbkmdr+AME/ugScghupZozcpfoAQNQ1MNFX++2DQXaStJVbc1T06PC4wKs3VH7vO
 J7d4j+Y621yCXrDF8puz90yWEf4ZuwhfPwVhaRJBcKGWAEHWHuNdIfPJZ/+1xkq7UHW2c
 4CA76rPqfcn+e+E05fD3h/5BgUI3iejItRju+zW4/yc21LOtLJKCkqt3thIsZTyvq4uwq
 r0Xv/DiS1vdyI3mSUqPga+sufY/Yp/uCi2DrBKpcADdwXRYCmbL+JNdpydw2T56KB8INo
 GzSDbsYa2jK/4Ue586dO0hATkQEvM4TbaBH3+Jih1/8glFvdKRNtzY39oHi3hBGE6Lg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=kLxBjqom; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=c238=hu=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=kLxBjqom
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A125C60631
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1790594853;
 bh=u5Mc4G182hL/nIW5qxrYYeGvtRlUkwTlTDGFqa3c8Os=;
 b=kLxBjqom/xktpvj9yHi8Y/3LATlpCSvUaOUWBd2LXULp4RQU1us25Fm063AmkZCf8gGnD9CO+
 R8ed4Dk5Uow1LLmecRBjg3j3w3L6371I9UVXmen8UnP4LLFNYzywCsmxHj2i4glfRtsFuOaCc3k
 jn4dv6vgT89h6LhYhAXOy87z9zDCfYkYdnevYEWBZ5B1bNc1/gIue5BQ6WFzTWZ2mAYSyY7GhJr
 r4LuxQG4Xux+iG19vL2dlE8HybIM8F/gdE279/2OJ9Si+dUo7JqXP2xZaRX0p9ykfwf87Hs+TVs
 RWVxmznBNbVfquQxFxMXcMbY0m+a/I4h63qGZxZUXv7Q==
X-Forward-Email-ID: 6aba4f237c3fbae63f6e1b92
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.16.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <2793a3c3-19c0-4da5-9708-c9c04f9384da@kwiboo.se>
Date: Mon, 28 Sep 2026 13:27:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] clk: rockchip: rk3568: Use fixed PMU CRU base
 address
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <u-boot@0leil.net>, u-boot@lists.u-boot-project.org
References: <20260804214442.2592597-1-jonas@kwiboo.se>
 <20260804214442.2592597-5-jonas@kwiboo.se>
 <CAC928HbEk6wha23vnMBMgpgsDs0ir3q+zWH8pypsHz9TbzwKzg@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAC928HbEk6wha23vnMBMgpgsDs0ir3q+zWH8pypsHz9TbzwKzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Massimo,

On 9/27/2026 10:33 AM, Massimo Pegorer wrote:
> Hi Jonas,
> 
> On 8/4/2026 9:44 PM, Jonas Karlman wrote:
>>
>> The RK3568 PMU PLL helpers lookup the PMU CRU udevice before accessing
>> PMU PLL regs. This may trigger a full PMU clock driver probe to get the
>> PMU CRU base address from the clock driver private data, something that
>> can take several ms.
>>
>> Change to use the RK3568 specific PMU CRU base address consant directly
>> to simplify and remove the unneeded complexity of using runtime lookup
>> in SoC specific code.
> 
> If we agree on using constants, we should do this throughout the whole source
> file, replacing any reference to priv->cru and priv->pmucru with constants. I
> know it sounds quite old-fashioned, but if abstraction provides no advantage,
> IMO it's just obfuscating the triviality, thus I would drop it and focus on
> consistency, instead.

Refactoring the clock drivers to fully use constants is in works for a
future series, at the moment this is only something I have in my local
tree. The most recent added RK clock driver already only uses constants
and there are some discussions related in a thread at [1], and in my
rk3562 branch [2] I have transitioned all clock drivers for the added
rk3562, rv1106, rv1103b, rv1126b, rk3538 and rk3572 SoCs to use
constants and other proposed changes.

This series tries to reduce impact on callers, and exclude any
refactoring not tied to reading CRU base address from clock driver
private data. I see no reason to bundle full clock driver refactoring
to this series, that is better suited in a separate future series.

[1] https://lore.kernel.org/u-boot/20260803190946.2259514-1-jonas@kwiboo.se/T/
[2] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/tree/rk3562/drivers/clk/rockchip

> 
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  drivers/clk/rockchip/clk_rk3568.c | 34 +++++--------------------------
>>  1 file changed, 5 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
>> index 5a05f1b4de00..eaf51728520a 100644
>> --- a/drivers/clk/rockchip/clk_rk3568.c
>> +++ b/drivers/clk/rockchip/clk_rk3568.c
>> @@ -94,44 +94,20 @@ static ulong
>>  rk3568_pmu_pll_set_rate(struct rk3568_clk_priv *priv,
>>                         ulong pll_id, ulong rate)
> 
> Please, drop the priv argument too, as unused (it was already, of course).

Such refactoring is better handled in a separate patch/series, and I
partially disagree with dropping the priv argument, keeping arguments
consistent for all set_rate/get_rate helpers tend to weight higher for
my taste.

Regards,
Jonas

> 
>>  {
>> -       struct udevice *pmucru_dev;
>> -       struct rk3568_pmuclk_priv *pmu_priv;
>> -       int ret;
>> -
>> -       ret = uclass_get_device_by_driver(UCLASS_CLK,
>> -                                         DM_DRIVER_GET(rockchip_rk3568_pmucru),
>> -                                         &pmucru_dev);
>> -       if (ret) {
>> -               printf("%s: could not find pmucru device\n", __func__);
>> -               return ret;
>> -       }
>> -       pmu_priv = dev_get_priv(pmucru_dev);
>> -
>> -       rockchip_pll_set_rate(&rk3568_pll_clks[pll_id],
>> -                             pmu_priv->pmucru, pll_id, rate);
>> +       static void * const pmu_cru_base = (void *)RK3568_PMU_CRU_BASE;
>>
>> -       return 0;
>> +       return rockchip_pll_set_rate(&rk3568_pll_clks[pll_id],
>> +                                    pmu_cru_base, pll_id, rate);
>>  }
>>  #endif
>>
>>  static ulong rk3568_pmu_pll_get_rate(struct rk3568_clk_priv *priv,
>>                                      ulong pll_id)
> 
> Ditto.
> 
>>  {
>> -       struct udevice *pmucru_dev;
>> -       struct rk3568_pmuclk_priv *pmu_priv;
>> -       int ret;
>> -
>> -       ret = uclass_get_device_by_driver(UCLASS_CLK,
>> -                                         DM_DRIVER_GET(rockchip_rk3568_pmucru),
>> -                                         &pmucru_dev);
>> -       if (ret) {
>> -               printf("%s: could not find pmucru device\n", __func__);
>> -               return ret;
>> -       }
>> -       pmu_priv = dev_get_priv(pmucru_dev);
>> +       static void * const pmu_cru_base = (void *)RK3568_PMU_CRU_BASE;
>>
>>         return rockchip_pll_get_rate(&rk3568_pll_clks[pll_id],
>> -                                     pmu_priv->pmucru, pll_id);
>> +                                    pmu_cru_base, pll_id);
>>  }
>>
>>  /*
>> --
>> 2.54.0

