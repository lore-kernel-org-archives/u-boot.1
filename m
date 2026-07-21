Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0FCC4452B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 17:27:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51DB2407D1;
	Tue, 21 Jul 2026 17:27:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4a9vRXQlpDAV; Tue, 21 Jul 2026 17:27:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13BAE407E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784654869;
	bh=CEih9lKjrJrSNOklWMhfiYyIX2GHb8+Xfe/JLBBMCyw=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=kvSqo3j+Meqx9o8b+PKTHuUT0LfkrxFYmRReGjCzv18/8lpJCMw3v3z01p67EpfDL
	 lACQA3kT7CoWDKhscHBWllvBk9PeSj+KX6r6PBcdqO7X69AUHMwTgok1lu2g0tcT48
	 zd2oxiuSqMQbivhBl04FEfK+O3Cgw5b6/4IYyjOdqLqvZDoss9vntGCx5luFYjX323
	 nKKfn7yI3b5MJKr1KhWQfkKV3WoRex6ekAD5mEvS/UReGMmIA/sMpODLy5LIm3doxT
	 y87SEVNMq5B7oXQbv7WYE0X/1/qbvbxyUdliiYAkiLknD5/wzUoWhV3V7nY2sgHFFd
	 g0h1tGutyLzrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13BAE407E0;
	Tue, 21 Jul 2026 17:27:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B0B25109C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 17:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C4FB40115
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 17:27:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hsvn0u-35Qj4 for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 17:27:46 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D934C4007F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D934C4007F
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D934C4007F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 17:27:45 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E331846A4; Tue, 21 Jul 2026 19:27:43 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CF9D803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 19:27:40 +0200 (CEST)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c15b1da6b82so889339966b.1
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 10:27:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784654860; cv=none;
 d=google.com; s=arc-20260327;
 b=qNPp1CnPEcyuyEeR7i8UO2TVCCg8w2ESBwDa10lCRJPJgtP6YwoOrMoKLjFs8IsmTT
 qE/h1Qfg97hAlIbF6S08UjG+yOz1MQJnyDFork2Ya2ykss+sjjQtmEEFvnZ+cjs+K7Fj
 +UrDEXt3qmgBeA8gvwk8o2wRRLkZkeUAIZT8Sq0pVKsStamrxx1xjV4i6dOpg0G7Bu2+
 vs+18CWiVhlA+bxu8d10kV93u5ouRMzAssPZSVxc0cah5LV1e4awHdsVE529aXoY35Bw
 8+s0tTCJ0DJWCxmnQnmsLenGufDFQ8M4oEyI/szh+p1IAtGaJlLtPHYIBmu67o5FERFQ
 tXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CEih9lKjrJrSNOklWMhfiYyIX2GHb8+Xfe/JLBBMCyw=;
 fh=OuowzhnSXj1Fq0buMNvfvwCFCBmsDZM9xd1zaiexQbw=;
 b=TLD7VGaorWKbjs9nIRfB4rUd344GKPIzlahok51T7RYM3LEguUeOWveThJ+rnC+wE/
 yWIevhHmiI2jvo8iY7ZLTQm+HzK421Y2VzcH7JUB5haZ37HUYk0J3IWASxMhjeXr3ubX
 H3DlDq4d3RakXEk+srlgUmThV/gwsjFgqeYU2wfMl/W1cUS9OtV5imkp94U0VQ6s5Rni
 Bj3+6bvrFDOJQmM1lOTIEWkg6HsNgyZGoN5LSrR5/rle+aYRsZm9IomTA/y1A2uuFhqA
 FHCKOT3IHp4gGnajUF6hX9/XMU2z8RdmkfdXQFg46cxwG/dJC4I1ZY8GheObl9jtTyLx
 Rrgw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784654860; x=1785259660;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CEih9lKjrJrSNOklWMhfiYyIX2GHb8+Xfe/JLBBMCyw=;
 b=AKZZahmuKDg00T3xY8iZwgjW3I9Zg7W6R1Jl/BKvysRoVAgyMKIZMhfwUpbrwtxwcI
 1i8qAe8im1u31NMvARfojxmy/VaihnDzdI0cg1rYi1AFbEIGMpTW5MzIkxx8gr0ftPDv
 QoyIjO82bG+Yy5mrzGlgjlbVcab2Ohcyhf8RONAIGERSKVCHw0rPVcxBv5XGgEknvNne
 w+6EFB8YaOvfp6cM00xskTDq7OXAGsMw4NX/vuj4QGAhPNlHu4P2WdFwaC95l9yllwT+
 vhWz0/iyHOXBqdKlWzT1kEOSa+Ie6fKVcBlP9oopUBfnbAyoZwRrnBSFqRzPl9zmIXZo
 GEZQ==
X-Gm-Message-State: AOJu0YxRmNGRxEhIB0dsw4dHQMH8gyCkJjPWwXMpB5IbQ45If6A3eiuB
 ISsgEM8cYlM9Q2kRexH4aaJoe7IyZkLV/sSOc6pblNTx/6QhqxbVs7nUi6e1PFO3F872XkJsxfz
 AlLodH7RoOOXzs9wVb60696ryjcTWuvDn1k8NDGwoTA==
X-Gm-Gg: AR+sD125lPTqOoBKbo3P6YPdTwXzDFdb/ZJ8rNKI8H74XgvpI37fip6QC8IDn5Rgl+0
 fl84VkAb7NloA6+xZ3V5/iwfJtbFcslKjtMqTmsQBiiXPItId5Litz5soANVd7OSlwEpK9rxMEn
 cNwMcjJKuaMa8uGSJRwhLXh9OIJ23IOrEp4n6L17K77VrGVWZSaPDcZzqsCRFErDvrtpx8Kn//7
 11wkCvzFtUIOBNcQOEV2WwdN9M2/f+sRvKvAaumb2S2W0CA3fvIcttt/ngHYLtTFeVHfUmtEcur
 sGibhlcXMlcVDjqMqSETUqbHPtVV
X-Received: by 2002:a05:6938:a091:10b0:c16:2d90:6878 with SMTP id
 a640c23a62f3a-c16b477f7ebmr509855666b.34.1784654859907; Tue, 21 Jul 2026
 10:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
 <20260713-rk3588-fracpll-v1-5-cdf47f2ca0b8@flipper.net>
 <153cd45a-b62c-4d3a-93dd-0dc94d74ddcc@cherry.de>
 <CAKTNdwFeUNxcVz-Jv1BGXRfsx7mKo0w9hTQEoEtFabfaco65vg@mail.gmail.com>
 <c42cd1f8-2a74-4ef7-a426-ad43ee038b56@cherry.de>
 <CAKTNdwGikt3VqNhRLWVK7fUtycijLkCS269Xgm4uqHPknpg7Bg@mail.gmail.com>
 <8b27556e-057b-4461-9ed4-f7b6ecd1267c@cherry.de>
In-Reply-To: <8b27556e-057b-4461-9ed4-f7b6ecd1267c@cherry.de>
Date: Tue, 21 Jul 2026 21:27:29 +0400
X-Gm-Features: AUfX_mz9sk21K10_Y8lHNIoHr2B-U2UJvoYPMD9UFn9bPclVtL90c7tpMwJAXB0
Message-ID: <CAKTNdwEa1EZNdbaP6GYzHKNVv15qFA6KLdm_za6cycmsxFym-A@mail.gmail.com>
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
 d=flipper.net; s=google; t=1784654860; x=1785259660; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CEih9lKjrJrSNOklWMhfiYyIX2GHb8+Xfe/JLBBMCyw=;
 b=mnWMczdl531p24Ijd3Z2JrGDeQ176Gz6XxCwYPbBY4LT88v05LB8seD5azCOS1GLKh
 SgiYuFqSgP03RPcfL6/jGZGYcmvsWNmGEBqH0DSm3qwg5r4Bu9pKeBYrfXM5hFrkhaUe
 /2Yeu2oIQJwJLcYaXNgk8SM6ZqSwr06pFbWEI+eh2OuUZjYgPIBsF8CThMQsVaQ6H8jO
 ZmjLtyYCVW6dcAApauDG+UyYNInyjrC5d1UqYn+KtGy8hZGoTMgnPLXlnECN/503byEv
 CVRlubxeX+YlUpdDvn0fEb9NEI+nAlWjm/PW2EziRyPrCrT0rGodlB/PjVNtIVzCm1HV
 4uWw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=mnWMczdl
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alchark@flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=flipper.net header.i=@flipper.net header.b="mnWMczdl"; 
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

On Tue, Jul 21, 2026 at 8:34=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> On 7/21/26 5:21 PM, Alexey Charkov wrote:
> > On Tue, Jul 21, 2026 at 6:34=E2=80=AFPM Quentin Schulz <quentin.schulz@=
cherry.de> wrote:
> >>
> >> Hi Alexey,
> >>
> >> On 7/21/26 2:46 PM, Alexey Charkov wrote:
> >>> Hi Quentin,
> >>>
> >>> On Tue, Jul 21, 2026 at 4:20=E2=80=AFPM Quentin Schulz <quentin.schul=
z@cherry.de> wrote:
> >>>>
> >>>> Hi Alexey,
> >>>>
> >>>> On 7/13/26 8:35 PM, Alexey Charkov wrote:
> >>>>> The TRM defines the fractional PLL adjustment coefficient as a sign=
ed
> >>>>> two's complement number, 16 bits wide, so store it as such to avoid
> >>>>> confusion.
> >>>>>
> >>>>
> >>>> Yet...
> >>>>
> >>>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >>>>> ---
> >>>>>     arch/arm/include/asm/arch-rockchip/clock.h | 2 +-
> >>>>>     drivers/clk/rockchip/clk_pll.c             | 3 ++-
> >>>>>     2 files changed, 3 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/=
include/asm/arch-rockchip/clock.h
> >>>>> index 95b08bfd046f..f9bfdfb8a6a3 100644
> >>>>> --- a/arch/arm/include/asm/arch-rockchip/clock.h
> >>>>> +++ b/arch/arm/include/asm/arch-rockchip/clock.h
> >>>>> @@ -104,7 +104,7 @@ struct rockchip_pll_rate_table {
> >>>>>         unsigned int m;
> >>>>>         unsigned int p;
> >>>>>         unsigned int s;
> >>>>> -     unsigned int k;
> >>>>> +     int k;
> >>>>
> >>>> ... you use int here instead of s16, any specific reason?
> >>>
> >>> Yes. What matters here is the signedness. The table value never gets
> >>> written to or read from the hardware without accessor functions, whic=
h
> >>> mask on writes and sign-extend on reads anyway. A generic 'int'
> >>> usually performs better than a fixed-width type because it aligns
> >>> better and requires fewer instructions for arithmetic.
> >>>
> >>
> >> Is the performance gain worth the potential confusion around int vs s1=
6?
> >
> > I'm not particularly attached to either approach. I just prefer using
> > general types when there is no hardware-dictated reason to use
> > forced-width, and there isn't one in this case. The other coefficients
> > use general unsigned types too, so mixing in a single fixed-width felt
> > ugly to me. But again, it doesn't matter much, so happy to switch if
> > you prefer.
> >
> >>> It also reduces potential churn if this table definition is ever
> >>> reused for another SoC with a different width for the k coefficient,
> >>> but this latter point is more theoretical.
> >>>
> >>
> >> The kernel uses a union in rockchip_pll_rate_table, maybe we should be
> >> doing the same (totally unrelated to your patch though)? It also uses =
an
> >> unsigned int k (still, but maybe you're working on that? haven't seen
> >> patches on the ML at a quick glance though). In general, I like to not
> >> differ tooooo much from the kernel as ideally it would allow to backpo=
rt
> >> patches from the kernel and more eyes have read the code.
> >
> > The kernel also uses a wrong denominator for the fractional component
> > (65535 instead of 65536). I have a local patch to fix that, but
> > haven't yet sent it out (mostly due to the fact that the kernel
> > doesn't use rate auto-calculation anyway, and writing out a table
> > value directly to the register doesn't care if it's signed or not).
> >
> >> If all we care is signedness, I would rather have all s16 or int, not =
a
> >> mix. But if the kernel keeps using an unsigned int for k, maybe we
> >> should wait for them to change or just stay with what we have here?
> >>
> >> I understand using an unsigned int for what is effectively an s16 to b=
e
> >> quite confusing, at the very least we can add a comment in the struct.
> >>
> >>> Shall I reword the commit description accordingly?
> >>>
> >>> Happy to set the type to s16 if you believe it's more expressive,
> >>> though; we aren't doing much arithmetic on the table values anyway.
> >>>
> >>
> >> I'm undecided whether we should diverge from how the kernel represents
> >> the rate table (that is, switch away from unsigned int for k), but if =
we
> >> do, I think we really should be consistent and avoid optimization at t=
he
> >> cost of readability/confusion (except if gains are substantial).
> >
> > Happy to convert the whole struct to fixed-width values for
> > consistency then, and submit a corresponding change to Linux along the
> > way.
> >
>
> Let's see what the kernel has to say and then we can do the same in
> U-Boot once there's some agreement there.
>
> >> I see that the kernel only has a table of rates, and doesn't do maths =
to
> >> figure out k and it seems they store negative k's in their
> >> representation in a unsigned form (that is, values above 32767 to
> >> represent negative k's). I'm guessing we cannot store tables in U-Boot
> >> because they would take too much space.
> >
> > We do store them (drivers/clk/rockchip/clk_rk3576.c:22 and
> > drivers/clk/rockchip/clk_rk3588.c:22), but our table is smaller than
> > the kernel's.
> >
>
> I'm really starting to wonder if it makes sense to have both a static
> table and a way to figure out the dividers (including fractional)
> dynamically, especially since we fallback to the latter if we cannot
> find the desired rate in the static table. And then we ask to find a
> rate with an input frequency of 24MHz but this expects the PLL to have
> its parent configured to use the 24MHz (xin_osc0) input clock... which
> isn't guaranteed as far as I could tell (yes, it's the register reset
> value but we better hope nothing changes it before U-Boot runs this
> code). While looking for this, I started to read the clock driver a bit
> more and oh boy... it doesn't look good. We **really** shouldn't be
> using anything rk3588 for rk3576 because many assumptions are made that
> it is only rk3588 and not anything else (e.g. it uses pll_id **integer**
> value instead of enum (because it cannot, otherwise it wouldn't compile
> on non-rk3588 devices which don't define the enum) to identify PLLs and
> decide to which offsets to write, etc... and of course, the enum integer
> values are different between rk3576 and rk3588.... I wish I hadn't read
> this code.....

Yeah, storing a precalculated rate table and never using it is an
interesting implementation choice :) As are some others here.

> >> I'm sorry this mail is a bit all over the place, but I think there's
> >> another issue in the driver. I believe we shouldn't check for rate->k
> >> before calling rk_clrsetreg(base + pll->con_offset +
> >> RK3588_PLLCON(2),...) otherwise we may not clear an existing non-zero =
k
> >> when setting a new rate. Is that correct? Not required for this series=
,
> >> but I think it should be fixed (if I'm indeed right).
> >
> > The check looks wrong: it should be conditional on the given PLL
> > supporting the fractional coefficient, not on the rate having a
> > fractional component. PLLCON(2) register is not defined for
> > integer-only PLLs such as LPLL or BPLL, so I'm not sure if they react
> > nicely to a k being written there, be it zero or not.
> >
>
> Yeah, better not try to write to undocumented registers if the vendor
> BSP isn't doing it as well. I don't think we store which PLL is an
> integer PLL and we cannot simply use the PLL ID as they aren't all
> defined for all SoCs (e.g. RK3576 doesn't have NPLL, B0PLL, B1PLL and
> RK3588 doesn't have BPLL)... I guess we may need a new member in the
> struct to reflect that.
>
> At the same time, the kernel doesn't seem to bother checking that and
> simply writes to PLLCON(2) regardless of the type? c.f.
> https://elixir.bootlin.com/linux/v7.1.4/source/drivers/clk/rockchip/clk-p=
ll.c#L967
> so maybe we shouldn't as well (yes I said the opposite in the previous
> paragraph :) ).

A struct member won't hurt IMO. Not sure if the mainline Linux source
is a very good reference in this regard, as I suspect no-one ever
tested fractional rates there, given they are recalculated with a
wrong denominator and without accounting for the two's complement
value of k.

> We also don't check whether the PLL actually supports fractional
> dividing, we only check whether the input and output frequency are
> multiples of 1MHz, but we could have something based on an integer PLL
> try to get a frequency that wouldn't match this requirement no? Or do we
> have a mechanism in place to make sure this cannot happen?

The check for multiples of 1MHz looks bogus to me, too. Some
(10/7)*OSC_HZ is a perfectly fine integer PLL config, and it's not a
multiple of 1MHz. On the other hand, some 1151 MHz is impossible to
obtain from a 24 MHz source with integer operations alone.

> >> I'm wondering also if we couldn't merge the loops in
> >> rockchip_rk3588_pll_frac_by_auto() and rk3588_pll_clk_set_by_auto(). T=
he
> >> only difference I see is that p cannot be 1 when we have an exact matc=
h
> >> (the for-loop in rk3588_pll_clk_set_by_auto()), but if we modify
> >> rockchip_rk3588_pll_k_get() as suggested in another patch in this seri=
es
> >> to return 0 on success, we could have the function set k to 0 and stil=
l
> >> be valid. What do you think? This is further improvement and is not
> >> required for this series.
> >
> > I think it would be tricky to explicitly prefer integer matches if we
> > try both integer and fractional in the same loop. And we want to
> > prefer all-integer settings wherever possible, as it avoids the whole
> > sigma-delta block, along with the additional clock jitter it can
> > introduce.
> >
> > What we can do is just inline the rockchip_rk3588_pll_frac_by_auto()
> > helper into the "else" branch of rk3588_pll_clk_set_by_auto(). Having
> > the two loops next to each other can make them easier to compare
> > visually. Let me know what you think - happy to rearrange those in v2.
> >
>
> Meh. Less appealing now :) I wouldn't bother but you do you :)

Alright, let me leave it for dessert then :) Looks like we're not yet
done with the main course here.

Best regards,
Alexey
