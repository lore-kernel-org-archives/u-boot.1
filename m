Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DDCC4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 16:02:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1E5280DA6;
	Tue, 21 Jul 2026 16:02:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vA8kNXLoaBLh; Tue, 21 Jul 2026 16:02:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 495C080E49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784649762;
	bh=YrDUn5kIHg+h+UheSvWyO+i474hxCjRIXy+UKlNyuXA=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=hcjUbTdWTIwju40GSVAEszrnM70r3Pl6D6h8Q2S3+cXDvFe6DskXp/c0FoTUZCJfd
	 4kbQg3o+rnzXFYY3lIJD0LS3ZNaMUq6P6K0hB1wuRsYdyeA//3epOixVm6DL+UvVHZ
	 hJqMgr+8eG4wRz/O/JUvBXyH9kkgJkGcyybhuhtw3I/GNE7fbz6EOGYJh80D05Nned
	 NsDuWcvikKLqHqiXyDsUEhsPM/c+uRw/CtqXIa4KmVY35w6Anc/ZFfA/oYvgO5O9nG
	 qJi6VJfi086qtdHczTVMN3vs7iFY3ayVtw/6OaTOZ1VYcbEwZ40TyJUGS+rJVS4+KN
	 JDvv2LeLEsWoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 495C080E49;
	Tue, 21 Jul 2026 16:02:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7513EEB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B2E760843
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:02:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u1cOhiD2tNaz for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 16:02:39 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0E44760831
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E44760831
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0E44760831
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:02:38 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 883C2849A1; Tue, 21 Jul 2026 18:02:37 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48B0384974
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 18:02:35 +0200 (CEST)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c15c42a45adso792432466b.0
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 09:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784649755; cv=none;
 d=google.com; s=arc-20260327;
 b=Wbqv3/vklVBFGQ18q1fHWThu4G2x6yxw9TImn1PW4xq6fzlAE1MOJc7PzG9UsUSf+9
 9+UJoZKbtpiGkuWGY6Of3mfj0nIxCCYG3V4P2XSq7C3Uo4VwmLMILfgiTImxstLCPwPr
 2odHbskTUvh3ORbQN6ryYPqs43/ApDtl1+vmbWlJF25Nh8tYBrb1Dblf+qM9147emv6j
 cGfmyTbF0MiHd6ql0bnU9gUxFGp9RPlGPcsx/biptCKTAW/UR7Ubuw+x540BiDzqAmPA
 Ucg30+l69diNZ/u2NV8mauWDbOZDF6IXi5zdX6PYVxiTU4r29gAwuAHGPKQEn7bJoWuI
 HiQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YrDUn5kIHg+h+UheSvWyO+i474hxCjRIXy+UKlNyuXA=;
 fh=OuowzhnSXj1Fq0buMNvfvwCFCBmsDZM9xd1zaiexQbw=;
 b=TpFXCgoAb55NfUt3gmf0eHI5byW4pQ+Ex5lroAAvRLNtpxhedqOQh4TNfHyU7LznP7
 Qb205I7d3RN1z5UUJBFpOdiBn1/7VxWTNtXNdLWtOX0lhBs0eg+VQnCS9MPk7UZkE8Ep
 wJ8sh5P8hMF9zw6UHUdZnC3f8bso6Ng+QFoP/sUlwzqOtxWAS+1y9QVeaVjOLri1ierx
 TozP+rSx6PZ98+K0muxjVYbZR7c53VegSaKB2fwTq8ON1tuKhNfSHRhFK6rhCLCr/3yR
 AW1LfN+a2Nl1l1zCHDv4qsmCxp7RXZli/AMDgHqHuywbPltb2y1nZpY1cNjlj2qm3VJv
 bviA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784649755; x=1785254555;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YrDUn5kIHg+h+UheSvWyO+i474hxCjRIXy+UKlNyuXA=;
 b=f64LUtGZYzPfRyftw8ocj2fvQzOM5UkpadP0KS4ISR0/FiLKit2R5g+YE5BNYbydUB
 Lm45LW32HJCyvklkAom+ZIHGo1YWZH5OThX3v6HkLRzu94roKPQYc5Dr5uhmOzLg4igd
 5S+heOiX5GnO+fL7RxhaGbfmD0sihh6wlXy8ZMSoBKoX/dGE+sxA1VI4Sv/VkNLDFIo9
 TdUNfgpbmQyRrYhEQQVtRRlLVGU6Oep6Ku3cuMFJM0dQT5iV+ob7nqCV/RQ05IGD1AWx
 V2ItrWnpBu8P0tDwfsJUhBW/4azCt6g7E4SZSH34WjI7F26pzA72nn+TIMLmy+E6DjY4
 I1mg==
X-Gm-Message-State: AOJu0YyHEFfn5b+jLBMD0dNCqDjc/c2T0DMQEqd+6f1dBLBEtkUFP4E5
 BNviX1ULLJqsM7kFpqzmAYo424uNyngrzIJidkdlJvzcTxTmp0V6h8FsDrCoKROZxij3O+jrpQY
 bS83e/VCSNFSwH5Vatgy99gC8oqVR3jOv0HYZOLxvzA==
X-Gm-Gg: AR+sD110OPleDvr8yXDmIcCb8hWHF4V17qO3PPWey3kdOp+qsYaCx4iEpv+VZqZfyMV
 7twviCxFPZxalkP1kp31LpCBmilY2js4/NlTJOQHI8KLVWGi4uJ+YklIXw6A+b9Zm1DwNMuCMHQ
 KSpJoQiIfRkN/jBc1IdyWZ0By2g27kmT/lQ0tZVWHM6/JeUbEkiegDFF3U2cCLv3w1a8N9aXDO9
 BraGi+alq0ggrcU1GOlzDZPm4EEn79JEpcdw0arQq0l1YxZfBeiQ15gV6kHUjC+enFU5FU4rEMl
 xI+B1Gt0uhd+6pI0kw==
X-Received: by 2002:a17:907:f818:b0:c15:fc5b:b667 with SMTP id
 a640c23a62f3a-c1c30f584d8mr10331966b.19.1784649754449; Tue, 21 Jul 2026
 09:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
 <20260713-rk3588-fracpll-v1-6-cdf47f2ca0b8@flipper.net>
 <c6beb0ac-0155-4437-a398-0e01241f0e47@cherry.de>
 <CAKTNdwGusMZxvAwrCtmnYDEAn1+dSBfEY4+MSgZx-UJiBKfaPA@mail.gmail.com>
 <9052feea-38e6-454b-b74c-53ab92a281c7@cherry.de>
In-Reply-To: <9052feea-38e6-454b-b74c-53ab92a281c7@cherry.de>
Date: Tue, 21 Jul 2026 20:02:23 +0400
X-Gm-Features: AUfX_mwa_3KjwlzEdl8mIoxDV0P6-PGqtcv8UretzJvEEDgZDlqrA2vlLH5BYMg
Message-ID: <CAKTNdwFSXig4dQ-V-Do38T-DC_tP0UExopr7=Y5Xmg=HUYterQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] clk: rockchip: pll: fix overflow and drop manual
 two's complement in rk3588_pll_get_rate
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
 d=flipper.net; s=google; t=1784649755; x=1785254555; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YrDUn5kIHg+h+UheSvWyO+i474hxCjRIXy+UKlNyuXA=;
 b=00Wp46qSUCwLK41kDGKJue/jOZkHYxdMxZ0l7FpQWcIANXDpQ29Fv8GjyDqWZ4zeRr
 M/t4AiIDfKGGaDiuH0+E/1f46eV1z9svaUP//Xn7De9hX42OWN4bPIVLz4xbDR8jBWmz
 KUibW71qzGiGyqe03BWwz6xBmQpVRsoSfsjwlW0+Ictk95O6YLmYCZWKW769NMYCzumh
 Ehp1EmBNqFTEqMRp3RxegRY1OxTaSDbQ54wUki2MVY+xBYLDx3HFTpTKGK2Mr43nVecq
 5Vp2SzCB4lB8U3e4hdM3+jkIda4gY/4s2hwK21wjUBMLUFV4SLb3BhItpnkaxdwoPCHe
 6x1g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=00Wp46qS
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alchark@flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=flipper.net header.i=@flipper.net header.b="00Wp46qS"; 
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

On Tue, Jul 21, 2026 at 6:05=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 7/21/26 3:34 PM, Alexey Charkov wrote:
> > Hi Quentin,
> >
> > On Tue, Jul 21, 2026 at 4:56=E2=80=AFPM Quentin Schulz <quentin.schulz@=
cherry.de> wrote:
> >>
> >> Hi Alexey,
> >>
> >> On 7/13/26 8:35 PM, Alexey Charkov wrote:
> >>> Current code calculates the fractional component in 32 bits before
> >>> assigning it to a 64-bit holding variable, causing overflow for real-=
world
> >>> values of k, given that OSC_HZ is 24000000U. It also does bitwise man=
ual
> >>> massaging of an unsigned representation of what is actually a two's
> >>> complement signed value, which is confusing and makes the code harder=
 to
> >>> read.
> >>>
> >>> Read k into a properly signed type and promote operands to avoid over=
flow,
> >>
> >> I'm not sure this is correct? Converting an unsigned integer (readl
> >> returns an u32 and con is a u32) to signed (k is s16) is
> >> implementation-defined as far as I understood (c.f.
> >> https://en.cppreference.com/c/language/conversion). I'm sure I
> >> misunderstood the spec but considering signed integer overflow is
> >> undefined (and I guess one could understand casting a u32 storing a
> >> number bigger than S16_MAX into an s16 to be some kind of overflow), I=
'm
> >> a bit concerned here. I probably forgot important stuff I learned a
> >> decade ago :) Can you point me where/what I misunderstood?
> >
> > It is indeed implementation defined in the C standard, but given that
> > U-Boot enforces the gnu11 convention, it's defined to be reduction
> > modulo 2^16 [1] along with two's complement representation, which is
> > exactly what we need here.
> >
>
> That is helpful thank you! I was sure I was missing something as I don't
> think we explicitly handle this anywhere in U-Boot or the Linux kernel
> :) A few more related questions though if you don't mind :)
>
> I'm assuming we're simply masking the bits 16+ to be 0 (modulo 2**16) as
> stored in the u32 (which already carries an s16 value just "as" u32) and
> not care about signedness when doing that (otherwise we would have an
> issue since the MSB of the u32 is necessarily a 0, thus a positive
> value, since the register returns 0 for [31:16] according to the TRM).
> Is that what you meant by "along with two's complement representation"?

The masking that the driver does is technically redundant, but doesn't
hurt. It's the same modulo operation that the compiler does upon
assignment of a u32 value to a narrower type.

Two's complement representation ensures that bit(15) is the sign bit
and that 0x8000..0xffff map to -32768..-1, so assigning a masked value
to an s16 variable correctly interprets the value as what the hardware
implies for both positive and negative values.

> We also build with clang, but I'm assuming it respects the GNU
> implementation with the -std=3Dgnu11 argument we have in KBUILD_CFLAGS.
> May I ask how you know this implementation is part of gnu11 from that
> webpage?

I guess I stand corrected here: the webpage defines the specific
"implementation-defined" behavior for this case for the specific
implementation in GNU GCC, although it's not one of the GNU extensions
to the C11 per se (and shouldn't be, given that C11 explicitly leaves
this part to the implementation). Clang tries to maintain
compatibility with GCC, so I assume it handles it the same way, but I
haven't found any official documentation to confirm this.

For a two's complement signed representation this is perhaps the only
sane approach IMO, so I'd be surprised if any mainstream compilers
chose to do it differently :)

FWIW, Exynos does a similar thing in drivers/clk/exynos/clk-pll.c:88

Best regards,
Alexey
