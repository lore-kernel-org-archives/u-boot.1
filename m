Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCB7C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 12:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C743408E3;
	Tue, 21 Jul 2026 12:52:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6bhUPeUSlpSq; Tue, 21 Jul 2026 12:52:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E034B40840
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784638327;
	bh=p9EJ8ktiySQRHo3N1MEeGTVrItSD3tGcCyjrnOdSCn4=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MKW32izkO1VVe0ghu4MA9ejmzMDrcKsn9ubXAjIqXG2XL78r7A7eBLXt8joI3fqGo
	 H1NP2zrK1gq8iXbUd40P7qt0jvb2ZN5phWB10YeREQWr1F9rTwBgbr/qq4weTBa6a/
	 dmXaKsVAP2LW1Cg7fEdHpyptoCB8+j2kS7g1kHpEDW29xAquc/Y8jCLvfP1NFPtr5x
	 +pd8iZOWAstAcALr6m2/lL/L8EkRDxLqS2+jCEtavtI81pR1fRcrY5WQCfP8+Y4/qr
	 JTT7rBXJRlhfBQkP130ASnLKRM4Dnjej8ffnCM0zgF7YYuMU9uSKQjk1nYGdUqIHgy
	 bTw2Ogzbi2d7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E034B40840;
	Tue, 21 Jul 2026 12:52:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B68C224
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:52:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8CF20607FF
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:52:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A59Sri0aw5oZ for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 12:52:05 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 80C1D60646
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 80C1D60646
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 80C1D60646
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:52:04 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0129484659; Tue, 21 Jul 2026 14:52:02 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC843803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 14:51:59 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c15f47e6297so817274166b.0
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 05:51:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638319; cv=none;
 d=google.com; s=arc-20260327;
 b=VRrx2tUQ7ayc+ZOhvR6OK3eh989OnIw9wzZ0EcmOefBujJan8XdxtMX0wY862B0zxN
 qSQL5RkGvs7pQ2FHQGL/ohqfds6pxkcmLazBfl4C8bBKuHpaur1Kpq+mfPmai2a3R9oP
 wHSKg9NulMiZi3bS9v4W779EO5t14U26nQzENW3k86FtXoIvwrOGiunM0Ev7qGwc8Woj
 03LZkZqrn2GF/d0HaTIKzr0Vn+AaMapmev5tV+IyyA1Fqw75kjSp8svJPMNIO9wR6sL4
 vaqfZIGVfuM/DweyPeuK1LNvYdF3A+IHuutFUitrlGz4zAwtGtvOZ8huG1FfySNXSJQ/
 2Rsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=p9EJ8ktiySQRHo3N1MEeGTVrItSD3tGcCyjrnOdSCn4=;
 fh=OuowzhnSXj1Fq0buMNvfvwCFCBmsDZM9xd1zaiexQbw=;
 b=FC4s8aiD67QODQkcQD8EN1y1eXeQ+bgYH/kuUmirrR8zUYzlgVOfbERh1f6a0FSXSY
 MYan0YhBRJBVnTRiyKGIH2NoQDIRkdB6QtyU8A4zc7/Y5zFDhz/QSP1701ik5OK6bvmI
 9Q50LO2ZPkkF4lzNXO6WiL7NTkGOuL/YztdGij1lSykJQVtiF4ghhdUqRU3ikAKyELP+
 FEtfH+pBFgGTMb0EA0V+eA9K2KuStm5uBX8yzM7Er7xbaZjgpIy1akrlCVy1k4UdArfp
 O6rVzrGsOD8mnQ1Zcf36xuAqjqOlNF51mbrrCF6CN0SZ0f6ykOTRpaEJAvAcnAW2GmaX
 P2mw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784638319; x=1785243119;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p9EJ8ktiySQRHo3N1MEeGTVrItSD3tGcCyjrnOdSCn4=;
 b=sYpB47xiqePNH95FHIlqWGjHH7QA5NduTJe2F/Mkrjsh+NLx2Jr4j1s+2ZHE1dxKfy
 6a+hUWoxxDP/mGBogxT4VLZlyvcDutjcNwq4UYN5XsAbMbWhC3j7xedHYEm3FB6KU1aT
 EeX1TV71oKeNCIf7d8JVL9+pGcim/qaLGzyh+OQcfItGNXF1wTefSEqpyIsxUFZYnrzC
 8vZ0Cg/3D+lZ94HIAsxsCH5ntPl73Ggx5Yp1tWuIgiU8hFGI6nX8SZ5sLOIG3fmkrBio
 +Nw4sOsx4s1yKKOlx7KJnXRKa9X69sa2AKgl4nPx4QqFRn4UIh820TPB1kL+TgyXTYKU
 chxw==
X-Gm-Message-State: AOJu0Yz9uBwRkuQ8SQjp7qe2XjCsLJOvhfrrAUHKkrEhcWHUDpYTvASS
 bXb+K0oFErmaaGCJFbAu00q31tEG6zM4pkqhYfpQ+TCwb7M8/Jp6hm682XctP2gvrCwFPmaasB9
 YhX35W6jhxr/8PAxZcOC4GFksU4y1pPCHZwbYUnRvZw==
X-Gm-Gg: AR+sD116u2wrLhzGg/To+POI4rQdNWfExVr3WSncrooS3655OoYU7Q4+NygtwmFu3VA
 ejKK9BPp6RHHgSU2vn6f2A51DzkkTIGJ9kQ4l2Oedt+gLAjdNQM01VSeReKwNANi2fQorl/XfdA
 z+6X7607PmepkmzHcxmoYfJOSjFdQFKxMYfANpstHHvYjZYsWTwOpFpg62Jrmvt7msgu8W5t/u5
 opyazpkVMhYrEmwGG2YH1G3zyv2Y/XQEiFAvHWUo1cqOLSWv+Z8o0Jr3ysRXTqILZZot3vNR2jJ
 0AnPpxUHCDLZQ7rhBA==
X-Received: by 2002:a17:907:746:b0:c15:f26a:342f with SMTP id
 a640c23a62f3a-c16b4737d65mr691581266b.23.1784638319112; Tue, 21 Jul 2026
 05:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
 <20260713-rk3588-fracpll-v1-3-cdf47f2ca0b8@flipper.net>
 <f2dc4c58-20a9-46d3-90ca-497d473519a3@cherry.de>
In-Reply-To: <f2dc4c58-20a9-46d3-90ca-497d473519a3@cherry.de>
Date: Tue, 21 Jul 2026 16:51:45 +0400
X-Gm-Features: AUfX_mx66-3HyFhVpq-utu-SE9De4cr7VKaV8mMAAn00tJoMKnVMi4ZtbGsRtJI
Message-ID: <CAKTNdwFkqckWyEhnFy1jk8bnGCOutAhWJ0T1g=R3HWBATJtFCw@mail.gmail.com>
Subject: Re: [PATCH 3/6] clk: rockchip: pll: fix RK3588 frac PLL result for
 k=-32768
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
 d=flipper.net; s=google; t=1784638319; x=1785243119; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p9EJ8ktiySQRHo3N1MEeGTVrItSD3tGcCyjrnOdSCn4=;
 b=btXj1pnH3TGrFNTIhDvEA8Njqnk4OlF7Kwm61N/t0WLjIp9L2T4MZgVZ1IJnTIyOJZ
 +Ja05TTdRM0NESPR/4SR5JwPckAA5Z9pmm0dtDwRFYOJNIR13k3XSV0j6Fw3KNWZMMVj
 nO0gqCSHjTz+aPF9l4toG0HjaLPMfVQ9NNdewlV6zEAPp8Sj7h0lWi6ruMYVLHe72cS7
 DNuahv9q34tEO/BWTKBS6RY+W3dhNPOlAZrYFU4cGH8j5d6h/K8MnqQc7R0ThS34WePF
 HAXDMOtElCW1qfAukTHl1AjDcpsNcjsM3ftdS6fygx+aMq3QfsXXjkFp1kf5YlQLgqVp
 hcRg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=btXj1pnH
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alchark@flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=flipper.net header.i=@flipper.net header.b="btXj1pnH"; 
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

Hi Quentin,

On Tue, Jul 21, 2026 at 4:16=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 7/13/26 8:35 PM, Alexey Charkov wrote:
> > Current code needlessly sets the k value to 0 when it is calculated as
> > -32768, which is a valid value for the RK3588 frac PLL. This results in
> > the PLL output frequency being higher than requested when the requested
> > frequency is exactly halfway between two integer-multiplier PLL output
> > frequencies.
> >
> > Negative k values can never go below -32768 either, because that case i=
s
> > handled just above this code, so the check for k > 32767 is redundant.
> >
>
> and because we add 1 to m, which is eventually multiplied by 65536 and
> thus if k is >32767 before adding 1 to m, it can only be <=3D32768 after
> adding 1 to m as we also invert the sign of k.
>
> > What remains of the if statement is a hand-rolled two's complement
> > negation of the result, so write it out as such for clarity, and return
> > the true S16 type of k as specified in the TRM.
> >
> > Fixes: 6bfb37e70209 ("clk: rockchip: rk3588: fix up the frac pll calcul=
ation")
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >   drivers/clk/rockchip/clk_pll.c | 10 +++-------
> >   1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_=
pll.c
> > index 69d2d182dcb5..c6fbeb71c77a 100644
> > --- a/drivers/clk/rockchip/clk_pll.c
> > +++ b/drivers/clk/rockchip/clk_pll.c
> > @@ -167,11 +167,11 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
> >       return rate_table;
> >   }
> >
> > -static u32
> > +static s16
> >   rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u64 fin_hz, u64 fvco)
> >   {
> >       u64 fref, ffrac;
> > -     u32 k =3D 0;
> > +     int k;
> >
> >       fref =3D fin_hz / p;
> >       ffrac =3D fvco - (m * fref);
> > @@ -181,11 +181,7 @@ rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u64=
 fin_hz, u64 fvco)
> >               /*
> >                * Round up to avoid overshooting requested rate for nega=
tive k
> >                */
> > -             k =3D DIV64_U64_ROUND_UP(ffrac * 65536, fref);
> > -             if (k > 32767)
> > -                     k =3D 0;
> > -             else
> > -                     k =3D ~k + 1;
> > +             k =3D -(int)DIV64_U64_ROUND_UP(ffrac * 65536, fref);
>
> I don't like migrating k to s16 in multiple commits, especially since
> there's also a mix of int/s16 in there. It's quite confusing.

It is somewhat. I did it primarily to make the derivations of all the
maths churn easy to follow, and I've double-checked that all the sign
extension and signed->unsigned promotion works out correctly. It might
be easier to squash the whole thing though :)

> It's kinda bad to store the return value of this function and then do
> some additional based on its value and set the rate_table based on it.
> Considering the next patch, I think it also itches you :)
> I'm thinking to move the whole rate_table->X assignment within
> rockchip_rk3588_pll_k_get(), also pass rate_table pointer as argument
> and simply return 0 if it worked, 1 (or -EINVAL or whatever) otherwise
> and have the for-loop return rate_table if rockchip_rk3588_pll_k_get()
> returns 0.
>
> Keep the current type when moving the assignments into the function,
> then migrate rate_table->k to be an s16 (including the struct
> definition) in another commit, then fix the k=3D-32768 case. I think it's
> clearer that way and avoid implicit casts and a mix of signed and
> unsigned types.

Sounds good, let me try that in v2. Thanks for the suggestion!

Best regards,
Alexey
