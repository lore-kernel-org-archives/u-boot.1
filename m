Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A234C5AD2C
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B76260754;
	Sat,  8 Aug 2026 17:39:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2XgpcojZf8Pm; Sat,  8 Aug 2026 17:39:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E604D606BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786210778;
	bh=srGv6Re/5MVl3J4k13F4smrx1ggoGqv+zYxJ1pt66iA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=btfSZHYpHRC91fXjdzL07MZ7xeJrighMmKzXRliEdXRbf7dddFnORYdM+C0udWiJ5
	 189npo/Ind3zcas03EO8xdRSnqhnk3HAA7E/x+WuTh1sVBIOAIaj6jl+C5t+Q0NsYM
	 v9z+uZ0wkJgYTJMBLcIapYxHzQdbHV2EkWqsZccCtwskpceeYtc2SKgt0JqumaWHLu
	 tPXPI+avJmo8FHP/GsvN51qudK00xeZQKINMMoO23HGPmWLpIZO/IFPfnDIHZ5WtoY
	 IJbBBCnDCwaU0uhH2z8rAhhcM3Bty7g3A2+jtb5p68VFYCVK+MhcnTnQogfXsNOkr+
	 dLTk29qWyFFAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E604D606BB;
	Sat,  8 Aug 2026 17:39:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 730A4282
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:39:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 70B9E405E5
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:39:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W84aHKDd_vs0 for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:39:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A2A67405CF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A2A67405CF
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2A67405CF
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:39:35 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a17cb94b26so798905a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786210774; cv=none;
 d=google.com; s=arc-20260327;
 b=sBnvRwk2eRFMVSc4Zpb2ifj8M7XDCV3lbdkC+XdCvSlreuS4E5tj9kv1Q0OFLWHpIL
 j0To8K7jh+I1ueZouci+3010CAGn/fIjUPe+mr5oTAf4qUkADSLaNAJFwW++Wi9kr/5T
 NteHYi3BtkD/Rt/mPFHWBq8CGzMkswv3emDPGl0NVhpUYqjPbk9OHBMUNNj0KlFxlobj
 A/E83oTpLiRLFN90Npxyg+IXVTt5r8X3kbx2olomYa2MgO+N2aJZaEFQRv540reiPnMs
 jK+64rtd2rsPFfw067+0/8BLmG6H0rckj59tRMNlWZWh2Cz9Er+tMPZASPVpVbCIGV99
 IVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=srGv6Re/5MVl3J4k13F4smrx1ggoGqv+zYxJ1pt66iA=;
 fh=T/HbrtMQzWzPkOs83zclDhfGXwx8Ob+Xyh50EgCQLqI=;
 b=dT71w08qokrohMp8a1OccsgwrjzaBhebEOROcPrtRl86rQH2GHSkIigUUu+MFEaozY
 VGaM0yoO+AUbcrmJ8nOTEYEkXq6SAbe3QVxg0ok8xsXDdBw5zMnalmjcQikIWdh7ko7Z
 0uWf2ZVZVmXczHqCqSzqgTR56wXI23iLxxv6i/TqLyzQyX3xdYHKE4yj4XDUKbbaCar3
 JaRvBbCEq4zcMoLYzEzguPSkMTq6K/VEj011vUKfsRW89q79pyHrFqmiVCb5DxHnt0p9
 Wwjd5BJEZik/I82wZQrVPXLpdmb1S59XYPUzrQFhgfD+4UWQyrDQuDc5LDHy7REqnxKB
 KQUw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786210774; x=1786815574;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=srGv6Re/5MVl3J4k13F4smrx1ggoGqv+zYxJ1pt66iA=;
 b=sVvp4gYg0EfqFYSiaV9y+8tGGpxJ2CRQ3PqGhRNrpuT5Boph5ZXv+qnmhPJkY76n/J
 CNbHgFk8lxIuzJIPO5j4zRV4y8mrVJ2w4CFw61KRYW5jA5/YbMoNXmDge2ni6zVYyxb9
 qlk5CNJOYpTF0ker9wOI/eUjtzs/sOSshVBPnHxS+en2wF1kI/G9izD5f3IfK5qHjtlh
 cCTIyPsOPBdz9aBH1yA+glAQmJeB5B+3ECQVmdTSgmeoRSmBumGgvC7PTxETJTM/UXO0
 NEDoGaGPDLk3sjtl7I1fSyQ9iipXU5PYiI7OLeEnZDL9E6rZaGijUhAqQP3YIZFz0LQa
 pL6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrlIlgnwkS9ClHblw8l5FWUqEAGuHU8m5W7bwAGo0mGZpQY/n3dqZc5cl2/IdJAVAkJKmkX1tc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yyhm9G1G5HWldC3PiuKqtWzR5HXLrUL0cMcMY2SHAXA9CjATDcI
 MGMqeztZYGHiWOOBoyCjBsxMofNGeLgl++t3713N+Qi3fc4zGKROiN34yVRWDJLTgAZqCBl8iam
 UKKOyJD8TY0jEQqU1U+AXxIAhAcKiiQWqUv+D08J8
X-Gm-Gg: AR+sD13bCPvG++eVKjuoqyp0+oT4sZaRO45UCqgwFG4mg0mvRLnD49rdFXTT9wa9OCq
 axGmWWg6xjg+mQ1K6oCluilMfQZjbpTZwGshbvd37o6ZEsx1GHu7pNmk1isT7ZUP+sso0FyL5kK
 MwV/ESZLCpw22zR8W1hNJIj7/MHFEKXZT+tBS13dYh4WJp1HCabzMhFqCGi9ov8QsEJbQCrfcqf
 3Z5Saw8UagkkMZRnp/V/kXCCl7Qcj8yauzLetrDn8K5DJ+wxmH6NJWdFk7ODhgGdZix5rMXA9p/
 58H/4nqrGcwWtv+NGa5dpfudboVc8IriqXGRRnTcUkM=
X-Received: by 2002:a05:6402:504e:b0:69f:2c1d:d83c with SMTP id
 4fb4d7f45d1cf-6a1e62d8b29mr6011891a12.21.1786210773695; Sat, 08 Aug 2026
 10:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-5-jonas@kwiboo.se>
In-Reply-To: <20260803190946.2259514-5-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:39:19 -0600
X-Gm-Features: AUfX_mzmSHmVFRjqAxhjU5t6Y2tYwMcDMpsnYVzO2AuJH0A6zEYG_gCTbFMHvh0
Message-ID: <CAFLszThN9ivtWft4VcM6SHZ8-yorzgsOqyFSqVTgsxV_3oq7Rw@mail.gmail.com>
Subject: Re: [PATCH 4/6] clk: rockchip: rk3506: Fix CLK_SARADC set rate issues
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786210774; x=1786815574;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=srGv6Re/5MVl3J4k13F4smrx1ggoGqv+zYxJ1pt66iA=;
 b=koYEGg4sS2JNSQsJjYmJzUFSU0j6d41xjxDKEAfnkIuC5nGr1Ln9QI2l34NqVBD74B
 remDOuqM1zjaXqPHNKMb2POQpKtWM251VCvLKWkHtz4val+BRuIaCq/geMiJPoL90FMm
 eM4JH1wBc7cDSgahiCaENAHc5paBYK78ttGUk=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=koYEGg4s
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

Hi Jonas,

On 2026-08-03T19:09:38, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3506: Fix CLK_SARADC set rate issues
>
> The set_rate ops for the CLK_SARADC clock in RK3506 clock driver
> force use of 32 KHz or 400 KHz rates when any requested rate is
> divisible with 32 KHz or 400 KHz.
>
> Adjust logic to better match the 32 KHz, 400 KHz or 1.5-24 GHz rate
> limitation of the CLK_SARADC clock in RK3506.

Shouldn't that should be 1.5-24 MHz, not GHz?

>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
> drivers/clk/rockchip/clk_rk3506.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)

> diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
> @@ -440,22 +440,19 @@ static ulong rk3506_sdmmc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
>  static ulong rk3506_saradc_get_rate(struct rk3506_clk_priv *priv, ulong clk_id)
>  {
>       u32 con, div, sel;
> -     ulong prate;

>
>       con = readl(RK3506_CLKSEL_CON(54));
>       sel = FIELD_GET(CLK_SARADC_SEL_MASK, con);
>       div = FIELD_GET(CLK_SARADC_DIV_MASK, con);
>
>       if (sel == CLK_SARADC_SEL_24M)
> -             prate = OSC_HZ;
> +             return DIV_TO_RATE(OSC_HZ, div);
>       else if (sel == CLK_SARADC_SEL_400K)
> -             prate = 400000;
> +             return 400000;
>       else if (sel == CLK_SARADC_SEL_32K)
> -             prate = 32000;
> +             return 32000;

The commit message only mentions set_rate, but this changes get_rate
to ignore the divider on the 32K/400K paths. Please mention this and
explain why - I assume the hardware divider is only wired to the 24
MHz mux input, but that isn't obvious from the code. Also div is now
read but unused on those two paths.

> diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
> @@ -463,10 +460,10 @@ static ulong rk3506_saradc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
>  {
>       u32 div, sel;

>
> -     if (32000 % rate == 0) {
> +     if (rate <= 32768) {
>               sel = CLK_SARADC_SEL_32K;
>               div = 1;

The threshold 32768 is odd given that get_rate reports this source as
32000 - please pick one value and use it consistently, or add a
comment. I suspect the real source is 32.768 kHz, in which case
get_rate should return 32768.

Regards,
Simon
