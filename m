Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7B0C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 15:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51C1040889;
	Tue, 21 Jul 2026 15:21:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9oBO-5HCHeVW; Tue, 21 Jul 2026 15:21:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 58CCA4070F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784647306;
	bh=3HWYxV6ZwxeKnrER7EtD7RkZP68AScN5MIZBHBawDJs=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=vyj7okwNFzu1y0XGMdJvQ4B75P37VGB9kEdMlLiKWMcW//6eCoWsmnhlkdKuuFaah
	 5PM0UGJvW2ephM8fTBy2kR+4uCdq1ECixr/GtaR24ZBtklRz108THihFLSEwOFNblp
	 cfMuSprFuVc3Gnne8fHUMV0BvvFe5vX0ktP36O5pK+VHNzZeiuYprj53ZyQ0O+IqeX
	 FNjLnMpp+IJoGyQqfixNwFZoxVlC/MLl7SP0oH4Ebm0eptfSyGLvykBqvVittacjyq
	 7kZi2oBKF5D6WOpVTGrmqpD1WnogvLcgbPy5awDaeYRYr33pVNxBe7z4ySm2igAFUq
	 lCmZaYC5tE97Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58CCA4070F;
	Tue, 21 Jul 2026 15:21:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9762CEB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D87580D91
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:21:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IaU0wAaWgI8B for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 15:21:44 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3812F80DFA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3812F80DFA
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3812F80DFA
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:21:44 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA87C8495B; Tue, 21 Jul 2026 17:21:42 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F326846A4
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 17:21:40 +0200 (CEST)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c15b33f7b23so1678488266b.3
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 08:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784647300; cv=none;
 d=google.com; s=arc-20260327;
 b=r3yg6I1vou5yba5bCcIa0l725YF92IWkl09t7kd/R/JpWMiPgWE57Opg3cBZBBQCDc
 LJJ9oj+MO9V8HCS3OaPI6nL16gcGW0NCMpg/TgQrqmBM+dRhzPy/9mbnTzcv0KklJ27S
 a0Y8I6doMHmuMzmIMy/2dWHzkx7u1Kacl03jywjTvpLeAioINOmWDzkmptvn7tJQO+kZ
 etf3AC8qla8OBhBIUYdRXFCOIplG/dpdx1Q/xmzfcbMzCjXg6yUzsPzn/GbRPPSpuayW
 Ppokb+cdK9pZ958W6dVuqfNrWJ4es3TxIy9YAn9yYtPbPYgLyuN9oELrICHKVUyUVZxt
 MmCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3HWYxV6ZwxeKnrER7EtD7RkZP68AScN5MIZBHBawDJs=;
 fh=OuowzhnSXj1Fq0buMNvfvwCFCBmsDZM9xd1zaiexQbw=;
 b=PZaHCkUrzy9Jdf0Ncc5Or/nUxDBr+mm0e+0nmB0gwFPvmAeb0s3/I6v9ST3mOfXbYp
 51RtCj16zTcZ5CMh6TVBX5crQ5sjkUkAQVOtlimKm8lpY1xGp661kL6FYL/vvQ4zQNaL
 hVhHfxJJ3wLhwTQDeXJGw1gt+Be+czU+4Sw90hbCJCcNElygzo+uCj1z+11SuIwdnqw1
 TXrirSjIg/h7EqziF8FStQdtKLVH6UBfKWSwCCSmk+ETmljf+Qx2wFc49Cj+tOJiDV3i
 /jbT4YL/Dmcf3vrJvUwJ1Z/jWNA7S83ex/RHBbP6WP6vQcS39Y5iEJtNpNfEu7scj9IN
 dhiQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784647300; x=1785252100;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3HWYxV6ZwxeKnrER7EtD7RkZP68AScN5MIZBHBawDJs=;
 b=EAJeLTeaFtdd10cgUa02HsTLZWGHFqxR5NJi2kCD3B6PeI1KKTH9m1XWuMD+Qjf0pS
 GDN0bvlzUiPlnd+fLWyNP1OyrSM7ViNWUpVI4MefwrCpGFrYV/VtGyynkZagRPwlHyAw
 CoofZTnJmONDzmbeJoCoIo7GICSxxFYXdJkHiDdF8Lfj/8tHtlS7nCXk34MnSSKV1dNp
 NCwVSLzmb/dQcu2n0Ax7UrLi8ZrhKaqM7sDW+imChCbTQ0ddp1kOAxz3nOOYJTsFGu3A
 zIfdx5WBoi1veuwIY5LfRhlM/k3JDdMoNnFgxwlio+RGxaP3H5hS4pGIkyjcjiGcq/Yi
 zv+g==
X-Gm-Message-State: AOJu0YxyGUY7CrxdtzuQu6eBBAwEkhQTe2vlpY+mo7eYhjiEMBMevECp
 Vkh7zAozdxOYXucHt6krsaxJLcVjvo6EUOnCkdWTAF/vGFbpayHs94x0KJ6QVZW1QGoMfYgflIA
 BrsoPUnVC1deHJN6UYTvkh0kP1GqsNcYEF03NzdFZ3w==
X-Gm-Gg: AR+sD10Z8XLiDl17unA2wjUUIpDIQQxN/U4+rOUlaEixDYBsFxGlSAO7ayWTMHtC3U9
 sPmstx5kuLiujRgW0kI5++atS63ZvceM4VPs31aQGiKH8/RwQym1q7Qr93FJg5CX/w0AtB/Ldmt
 SnEqr7L3vlmLw6T0y3a5qQaXoA8qL7ajYhQCC5bd3ZWjwmiVo97ZMwQMYx6Of9F2ridKJViS97i
 xFzUNbY8eiisANUMWIhZb5r7Fy1nlvhEcFUf439ah5HRwBcfLohTTP+s9uxre02RxR58IFUfrpy
 puhZ8tViIwUABMcaOQ==
X-Received: by 2002:a17:907:3e9a:b0:c15:cccd:336b with SMTP id
 a640c23a62f3a-c16b477c675mr937171466b.31.1784647299880; Tue, 21 Jul 2026
 08:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
 <20260713-rk3588-fracpll-v1-5-cdf47f2ca0b8@flipper.net>
 <153cd45a-b62c-4d3a-93dd-0dc94d74ddcc@cherry.de>
 <CAKTNdwFeUNxcVz-Jv1BGXRfsx7mKo0w9hTQEoEtFabfaco65vg@mail.gmail.com>
 <c42cd1f8-2a74-4ef7-a426-ad43ee038b56@cherry.de>
In-Reply-To: <c42cd1f8-2a74-4ef7-a426-ad43ee038b56@cherry.de>
Date: Tue, 21 Jul 2026 19:21:28 +0400
X-Gm-Features: AUfX_mxC1ZqHDk8ZkzcKMelx5FCj-UnCdVEbVPKqY9AXGalgNharjKDU7qlKsE4
Message-ID: <CAKTNdwGikt3VqNhRLWVK7fUtycijLkCS269Xgm4uqHPknpg7Bg@mail.gmail.com>
Subject: Re: [PATCH 5/6] clk: rockchip: pll: fractional PLL coefficient is
 two's complement
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Elaine Zhang <zhangqing@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1784647300; x=1785252100; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3HWYxV6ZwxeKnrER7EtD7RkZP68AScN5MIZBHBawDJs=;
 b=o6QD1HxE5Brgi+F6IDIeUtOI9XAGLnXmqeYT4APQaxNRL9ipRlfx/ZgyTuC5i8oKez
 Ml9PeoyTxDUY4v3pUiA7PKCQpVcKL+s7EHbwWSSl7c5+JAV+2f/mZpH5lsSabO95HvYT
 CBeZPzg/fd6FSFA71n8dwNTYA9tX+pTX2ZEtDpSSdHKQfaZwv6B5qsuXPVCvNszNu0U1
 6S6hmyA90LpKvYE8SvsafW/omUSQSqyw8HwRs5X7fTc11yMgppPz0pcL1CL04J50wMzX
 DsZPQxbRqjCTrfhqRUyxAOXPgzDXD00+ZpVrNsE6+PZt2Jy9U2IK4PTfgPn6EzRRaQUy
 ERpw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=o6QD1HxE
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alchark@flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=flipper.net header.i=@flipper.net header.b="o6QD1HxE"; 
 dkim-atps=neutral
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
From: Alexey Charkov via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Alexey Charkov <alchark@flipper.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue, Jul 21, 2026 at 6:34=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 7/21/26 2:46 PM, Alexey Charkov wrote:
> > Hi Quentin,
> >
> > On Tue, Jul 21, 2026 at 4:20=E2=80=AFPM Quentin Schulz <quentin.schulz@=
cherry.de> wrote:
> >>
> >> Hi Alexey,
> >>
> >> On 7/13/26 8:35 PM, Alexey Charkov wrote:
> >>> The TRM defines the fractional PLL adjustment coefficient as a signed
> >>> two's complement number, 16 bits wide, so store it as such to avoid
> >>> confusion.
> >>>
> >>
> >> Yet...
> >>
> >>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >>> ---
> >>>    arch/arm/include/asm/arch-rockchip/clock.h | 2 +-
> >>>    drivers/clk/rockchip/clk_pll.c             | 3 ++-
> >>>    2 files changed, 3 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/in=
clude/asm/arch-rockchip/clock.h
> >>> index 95b08bfd046f..f9bfdfb8a6a3 100644
> >>> --- a/arch/arm/include/asm/arch-rockchip/clock.h
> >>> +++ b/arch/arm/include/asm/arch-rockchip/clock.h
> >>> @@ -104,7 +104,7 @@ struct rockchip_pll_rate_table {
> >>>        unsigned int m;
> >>>        unsigned int p;
> >>>        unsigned int s;
> >>> -     unsigned int k;
> >>> +     int k;
> >>
> >> ... you use int here instead of s16, any specific reason?
> >
> > Yes. What matters here is the signedness. The table value never gets
> > written to or read from the hardware without accessor functions, which
> > mask on writes and sign-extend on reads anyway. A generic 'int'
> > usually performs better than a fixed-width type because it aligns
> > better and requires fewer instructions for arithmetic.
> >
>
> Is the performance gain worth the potential confusion around int vs s16?

I'm not particularly attached to either approach. I just prefer using
general types when there is no hardware-dictated reason to use
forced-width, and there isn't one in this case. The other coefficients
use general unsigned types too, so mixing in a single fixed-width felt
ugly to me. But again, it doesn't matter much, so happy to switch if
you prefer.

> > It also reduces potential churn if this table definition is ever
> > reused for another SoC with a different width for the k coefficient,
> > but this latter point is more theoretical.
> >
>
> The kernel uses a union in rockchip_pll_rate_table, maybe we should be
> doing the same (totally unrelated to your patch though)? It also uses an
> unsigned int k (still, but maybe you're working on that? haven't seen
> patches on the ML at a quick glance though). In general, I like to not
> differ tooooo much from the kernel as ideally it would allow to backport
> patches from the kernel and more eyes have read the code.

The kernel also uses a wrong denominator for the fractional component
(65535 instead of 65536). I have a local patch to fix that, but
haven't yet sent it out (mostly due to the fact that the kernel
doesn't use rate auto-calculation anyway, and writing out a table
value directly to the register doesn't care if it's signed or not).

> If all we care is signedness, I would rather have all s16 or int, not a
> mix. But if the kernel keeps using an unsigned int for k, maybe we
> should wait for them to change or just stay with what we have here?
>
> I understand using an unsigned int for what is effectively an s16 to be
> quite confusing, at the very least we can add a comment in the struct.
>
> > Shall I reword the commit description accordingly?
> >
> > Happy to set the type to s16 if you believe it's more expressive,
> > though; we aren't doing much arithmetic on the table values anyway.
> >
>
> I'm undecided whether we should diverge from how the kernel represents
> the rate table (that is, switch away from unsigned int for k), but if we
> do, I think we really should be consistent and avoid optimization at the
> cost of readability/confusion (except if gains are substantial).

Happy to convert the whole struct to fixed-width values for
consistency then, and submit a corresponding change to Linux along the
way.

> I see that the kernel only has a table of rates, and doesn't do maths to
> figure out k and it seems they store negative k's in their
> representation in a unsigned form (that is, values above 32767 to
> represent negative k's). I'm guessing we cannot store tables in U-Boot
> because they would take too much space.

We do store them (drivers/clk/rockchip/clk_rk3576.c:22 and
drivers/clk/rockchip/clk_rk3588.c:22), but our table is smaller than
the kernel's.

> I'm sorry this mail is a bit all over the place, but I think there's
> another issue in the driver. I believe we shouldn't check for rate->k
> before calling rk_clrsetreg(base + pll->con_offset +
> RK3588_PLLCON(2),...) otherwise we may not clear an existing non-zero k
> when setting a new rate. Is that correct? Not required for this series,
> but I think it should be fixed (if I'm indeed right).

The check looks wrong: it should be conditional on the given PLL
supporting the fractional coefficient, not on the rate having a
fractional component. PLLCON(2) register is not defined for
integer-only PLLs such as LPLL or BPLL, so I'm not sure if they react
nicely to a k being written there, be it zero or not.

> I'm wondering also if we couldn't merge the loops in
> rockchip_rk3588_pll_frac_by_auto() and rk3588_pll_clk_set_by_auto(). The
> only difference I see is that p cannot be 1 when we have an exact match
> (the for-loop in rk3588_pll_clk_set_by_auto()), but if we modify
> rockchip_rk3588_pll_k_get() as suggested in another patch in this series
> to return 0 on success, we could have the function set k to 0 and still
> be valid. What do you think? This is further improvement and is not
> required for this series.

I think it would be tricky to explicitly prefer integer matches if we
try both integer and fractional in the same loop. And we want to
prefer all-integer settings wherever possible, as it avoids the whole
sigma-delta block, along with the additional clock jitter it can
introduce.

What we can do is just inline the rockchip_rk3588_pll_frac_by_auto()
helper into the "else" branch of rk3588_pll_clk_set_by_auto(). Having
the two loops next to each other can make them easier to compare
visually. Let me know what you think - happy to rearrange those in v2.

Best regards,
Alexey
