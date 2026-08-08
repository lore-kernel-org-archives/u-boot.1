Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EA0C5AD4E
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 19:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D79D60656;
	Sat,  8 Aug 2026 19:46:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xCQXVUCxgbLn; Sat,  8 Aug 2026 19:46:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8339C6065E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786218390;
	bh=HjS0D0p3EbT7nKTzbi3fG3iVfyJtDycq7zUxFp8W43c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W0JiYwhAgVhOJJucHmFVNS6j1GLC7oFRpVkYy/UuGCDfSMpHZ0mESjxUrxKJEtxrF
	 cMGr44Na3vJQM1AlgVTBf/BdlTyvTzB0Od9lZTRc6iBeDfLL8N3zXGL1ykrk7cnXx+
	 Z9dqy0az2JMx5DaeUKlNNTrw86hRuO54V/5bE1x7Ty+4Vzdx0DrDBFwC3uDaFq9ZTa
	 5FWdIZM/uwa9BMPgH6i1B247M80Ar5/vLaPhIhQobtoS2hpQcdpUrK+yNpWLJOnlC3
	 zbDuyN9195MFWA+nzKeQZMKvIv7Ee90iS9vZPqXIoDyIw17VYapWzWZK3WPIwdyA+o
	 Jwd4YKu2PPBwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8339C6065E;
	Sat,  8 Aug 2026 19:46:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6372B2F5
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 55F5280DC5
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:46:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oV8raaky27Xu for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 19:46:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b70c=gc=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 94D0380DBF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 94D0380DBF
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 94D0380DBF
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:46:28 +0000 (UTC)
X-Forward-Email-ID: 6a77877dd6d5f90d44f6ef9f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.10
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <8abb4515-95d8-4f86-99a1-96ab670ed91c@kwiboo.se>
Date: Sat, 8 Aug 2026 21:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] clk: rockchip: rk3588: Always init clocks in SPL build
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang
 <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Alexey Charkov <alchark@flipper.net>,
 u-boot@lists.u-boot-project.org
References: <20260804002643.2308515-1-jonas@kwiboo.se>
 <20260804002643.2308515-3-jonas@kwiboo.se>
 <CAFLszTjPE85w92ONGRZhHiSuwnA3s88hh_bntKzGeY5uv9CbXA@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTjPE85w92ONGRZhHiSuwnA3s88hh_bntKzGeY5uv9CbXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1786218387;
 bh=HjS0D0p3EbT7nKTzbi3fG3iVfyJtDycq7zUxFp8W43c=;
 b=IGJmARbeRoxL/XDK20+KJ0mX5JeZ9AqQvDfB2JvWA0fn24HZXyvS93a5zGu8ZD+at7W82Ch21
 R9UCpEpeB024JnzrNcBvB9t/LKkNxNkO28UUhLtKsDD4VkwH8/wNRZrYlg0Hk3AlnOYALn7BdGo
 vbX2RtZSl66nX7q7ITYXGHmC+A+l0OVF3GjA/Qystrc1qm0yT27JjHI8XT37Rcb++gstFOukqEq
 2BtxojcP2xxed0tJqORlX0VaH2YYmpT4wQTEJnJ2kApUsmwNu3tJ9B7Q7KumChstR/ViaPt+vIl
 wyzGoPmIlIkfzl310MrLei3M1sEw7yjtuAMHlRpGMqTw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=IGJmARbe
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

On 8/8/2026 7:32 PM, Simon Glass wrote:
> Hi Jonas,
> 
> On 2026-08-04T00:26:39, Jonas Karlman <jonas@kwiboo.se> wrote:
>> clk: rockchip: rk3588: Always init clocks in SPL build
>>
>> The CPU PLLs and SPLL are only initialized in SPL on RK3588.
>>
>> Ensure clock driver is always probed after bind for SPL builds to
>> initialize core PLLs and clocks in SPL phase on RK3588.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>
>> drivers/clk/rockchip/clk_rk3588.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
> 
>> diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
>> @@ -2138,6 +2142,15 @@ static int rk3588_scru_clk_probe(struct udevice *dev)
>>       return 0;
>>  }
>>
>> +static int rk3588_scru_clk_bind(struct udevice *dev)
>> +{
>> +     /* Ensure clocks are initialized after bind in SPL build */
>> +     if (IS_ENABLED(CONFIG_SPL_BUILD))
>> +             dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>> +
>> +     return 0;
>> +}
> 
> The entire SCRU section starting at line 2052 is wrapped in #ifdef
> CONFIG_XPL_BUILD, so this bind function only exists in an XPL build -
> s0 are you specifically wanting this to only happen in the SPL phase?
> If so, I think you should use xpl_phase() == PHASE_SPL

Correct, this should only happen in SPL builds, as originally intended.

The change to XPL came from "drivers: Use CONFIG_XPL_BUILD instead of
CONFIG_SPL_BUILD" and you not wanting to address my remarks about the
unintended changes for the Rockchip platform ;-)

I have future refactoring plans for all RK35xx clock drivers, e.g.
change to use FIELD_PREP_WM16 and more, was hoping to defer the
unintended use of XPL_BUILD until such future series.

For now we only have SPL support for RK35xx, so the mixed use of XPL and
SPL have no real difference until that changes.

Regards,
Jonas

> 
>> diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
>> @@ -2009,6 +2009,10 @@ static int rk3588_clk_bind(struct udevice *dev)
>>       struct udevice *sys_child;
>>       struct sysreset_reg *priv;
>>
>> +     /* Ensure clocks are initialized after bind in SPL build */
>> +     if (IS_ENABLED(CONFIG_SPL_BUILD))
>> +             dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>> +
> 
> Same question here.
> 
> Regards,
> Simon

