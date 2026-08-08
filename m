Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372DAC5AD4E
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 19:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FF8960687;
	Sat,  8 Aug 2026 19:33:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y3wlE0Y4bbfA; Sat,  8 Aug 2026 19:33:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7BAB060664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786217623;
	bh=ZLeyrn7rveRc6UGTZvEouAkKw6Adobb9FwMOHZB2hVI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DopgG8VDeT9YUIZdrER4joNYPUJ95gQ1ZaSrsiyA9PnCDzjUTD4+kPN78zTwajQgX
	 9LBVAGrNsHLqeDSn/jScB/r9Obc/DqYgFnzurIqxfizEf0TnNEztid871ZC22C9Sav
	 +XLe4aqIjXAL3MYHE4hDmz+BXKtTWAwjwI6sUe/C2qcJmn7W1A3/i0jTW2lVNIWyLK
	 mLHyGih2CBLlfC/YpNImZ9DISa725Z8c6UOpzZaivy2QSbFeqeqpYfGOHlCgTnJXIX
	 bwaH/eQAPKuEw4he5adJwBLMsNngRQB8P2Qo7deE7ZuO6s2n8q8ilkG2UrLPJe06Ro
	 WjmjPLvIxDPBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BAB060664;
	Sat,  8 Aug 2026 19:33:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 85D7310E
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:33:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6BD2280BF3
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:33:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VMWysMkLKRbl for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 19:33:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b70c=gc=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5DF9D80BDD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5DF9D80BDD
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5DF9D80BDD
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:33:38 +0000 (UTC)
X-Forward-Email-ID: 6a7784891d349bd111805ad5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.10
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d3912c4d-90d4-4e62-b9eb-9a53ba4a170e@kwiboo.se>
Date: Sat, 8 Aug 2026 21:33:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] clk: rockchip: rk3568: Always init clocks in SPL build
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang
 <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Alexey Charkov <alchark@flipper.net>,
 u-boot@lists.u-boot-project.org
References: <20260804002643.2308515-1-jonas@kwiboo.se>
 <20260804002643.2308515-2-jonas@kwiboo.se>
 <CAFLszTjXANOTC8r0FbXAL80Zs2m7EpbEPb5BnDF3kWf1QxHpiQ@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTjXANOTC8r0FbXAL80Zs2m7EpbEPb5BnDF3kWf1QxHpiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1786217618;
 bh=ZLeyrn7rveRc6UGTZvEouAkKw6Adobb9FwMOHZB2hVI=;
 b=OmYXxL0qJTTvTisWVY777hCRugC0JhtXrOhveFAJZqKPdvpLth7sRYkZhquSyGtCCUDl7P8w4
 d2H5gd9n52YyofoBkpYeHqAI9gqdildFmGNDg2FlUFhGPkKbmNoUcb2Mrxx+TA98aagTaVoR7Aw
 HIvwaBT6Gg8SNCK1FEZYntFrpL7Q4PMJEg01Uk/7WsCq40TvFvoUP/9n5VMaGZz4skRvZxSQC6x
 9FxoWoMFviIJQZeuCiFnp3y4xRAzAWL3c9x90mpqdhUzDHQFVBLDezdB0FiASFjSSQ/sTH55pKv
 ncXy9Lyd5++oyQ3OVFvllL7DMxbUpn4EA0fWvtEjpgjw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=OmYXxL0q
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

On 8/8/2026 7:30 PM, Simon Glass wrote:
> Hi Jonas,
> 
> On 2026-08-04T00:26:39, Jonas Karlman <jonas@kwiboo.se> wrote:
>> clk: rockchip: rk3568: Always init clocks in SPL build
>>
>> The ACLK_BUS clock is initialized to 150 MHz in SPL on RK3568.
> 
>>
>> Ensure clock driver is always probed after bind for SPL builds to
>> initialize core PLLs and clocks in SPL phase on RK3568.
> 
> Just to check: "is initialized to 150 MHz" reads as if this already
> happens. My understanding is that probe() contains the ACLK_BUS setup,
> but nothing forces the CRU to be probed in SPL, so it is silently
> skipped. Please spell that out - something like "the clock driver is
> currently only probed on demand, so the ACLK_BUS init in probe() is
> skipped when no SPL consumer references it" - so the motivation
> matches the speedup Alexey reported on the rk3576 patch.

Correct, I will reword the commit message.

Unless the clock driver is probed in SPL, the ACLK_BUS never gets
initialized to 150 MHz.

> 
>>
>> Ensure clock driver is always probed after bind for SPL builds to
>> initialize core PLLs and clocks in SPL phase on RK3568.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>
>> drivers/clk/rockchip/clk_rk3568.c | 4 ++++
>>  1 file changed, 4 insertions(+)
> 
>> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
>> @@ -2938,6 +2938,10 @@ static int rk3568_clk_bind(struct udevice *dev)
>>       struct udevice *sys_child;
>>       struct sysreset_reg *priv;
>>
>> +     /* Ensure clocks are initialized after bind in SPL build */
>> +     if (IS_ENABLED(CONFIG_SPL_BUILD))
>> +             dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>> +
> 
> Have you considered marking the CRU node bootph-all (or equivalent) in
> the DT instead? That is the more usual DM way to force a device up
> early, and it avoids sprinkling a phase check into every SoC driver.
> If PROBE_AFTER_BIND is genuinely the right hammer here, please add a
> note in the commit message explaining why.

Use of bootph-all does not automatically triggers probe of the device.

The main issue is the on demand driver probing, and depending on what
boot source is used the clock driver may never be probed in SPL, e.g.
when booting from RAM/USB.

We should possible move out some of these one-time clock initialization
into e.g. arch_cpu_init() or similar in future to avoid having to use
probe after bind.

Regards,
Jonas

> 
> Regards,
> Simon

