Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341C6C4452F
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 12:47:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5C7580ED7;
	Tue, 21 Jul 2026 12:47:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P1unYdsgE_mp; Tue, 21 Jul 2026 12:47:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C8F080EBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784638053;
	bh=ZkPZOhscYItds8hYt94EkzFkC7lJHTuUTmGTJ9CM22U=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=AKUsrU9AUOGACNxkLwOpZqV0IihNZX7dIM9/igyDYrLRFfT56Nz3G+8QkyxkZGTBy
	 EVpCZtnXFXp1S81WT6HwxKXxN1LUcT2BAZ6jLbDf/M6/C0npFKgV4fdRR0lDJWp0YH
	 TcPZe7MzMgNO5GP+q3thSfoTea/ghu480GmJFPPqt3KA1Scql0WIoTSR3IC2dtr9WL
	 otjDmJ+z6d9MBFeRpJ4z7kLCzbcpQactms8D6sMCOWgGB/cyDzeHTtvCpNSk52DA7k
	 MjWXyekpGpGog+M1YXx5TiEgSbXJBRqg1zezQJ71QHxJXqSFnsciuI5U/CTcwXh2W9
	 cEpAAzLiT4JFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C8F080EBF;
	Tue, 21 Jul 2026 12:47:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 604F8224
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 46BDF80EB7
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:47:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dfqzGRP3Azeh for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 12:47:31 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0637680EBF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0637680EBF
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0637680EBF
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:47:30 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66B2C84659; Tue, 21 Jul 2026 14:47:29 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73263803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 14:47:27 +0200 (CEST)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-69c5f6f7a40so11358229a12.0
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 05:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638047; cv=none;
 d=google.com; s=arc-20260327;
 b=ZkZp9lnoaskfdhFrw7xUEfXd6eP6vG+YeJfPcGPWJ9ssfcBjg6EpWAuzhrUhX3ZMnD
 GVChE+MFCJLQa3LMnSMXen8lWq+EuNKg+KPKgOLETGaQHgl3tR4r+eUopQQ9w2B8uyg2
 EnUYbNvU3C+pHRTyMZftpeo+NVkcGrpqt/HoRKda7V8S4xC4IFQP1z11j8Gon7/nwgHt
 gPQj4feDUYBn7YSny5Fk4zjWugEcXOrj67ih26l5hnGtMzxbeVRzHwLTZeWaWTeoUi4l
 N+TlKwPsch/Hbu7zzPyIRvvi972+k8hs0AW0tJzobt22J4YZpZ2aO5jNTBN4zQkiPAby
 yiPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZkPZOhscYItds8hYt94EkzFkC7lJHTuUTmGTJ9CM22U=;
 fh=OuowzhnSXj1Fq0buMNvfvwCFCBmsDZM9xd1zaiexQbw=;
 b=kQpvkz0kbmqqI8glJA7zqOINS9dDc5kxdBXhiEGB0mYTQodK/HogqdkMiZnNErIKjV
 p2CYoigcTIclM/0nI3rOY9vHLkTrtLKqrf7jTkWm6tPKdnhiqZx8tOHpU+1PX+gMmrdX
 rukIZKFcgd6x2LrSa5/ht/LsyusgVM4ND9L34VdL+sQlizxDB5C+U+Kqa2QvVZVNzr22
 Sfn+hR1iugDktE9ocIFg9G48IWZKUf4Q4JxmDXHzKHl0slbpRwQUMsy/1JJdwrKCsF0Q
 wafZxDretGuCn7syrbM1a4/H3cnU/6xbWMkNup/UVZniygUzexS7QB+YwYbNj/BORPtn
 v3NQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784638047; x=1785242847;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZkPZOhscYItds8hYt94EkzFkC7lJHTuUTmGTJ9CM22U=;
 b=INlHyHZgC8ODFCaABdi6B3vrluvg1S+z+teMFdrnGuR83QUTM1QG5+CWy3kN+P46U1
 LuR0RNdHdo1aYZ2lNtLeClNCIAOIm8Dg2Kl/nrPOzSdrtDD4w5ohssfLBDElThezEuoX
 U2JxL9jz1W3pJa/BtH38AgroJggeUwsp+cUphqMnkv9Fc8TF8ZbSqHv5pYk5Zzsyc8rd
 +Qi6TodplDQL5uJeqMOX9EH+lBOF1xzCnqKDNvnJ0CeyoODo/F4NPoJOHJ36B9hPUYbE
 AgEIgM8lOooITYBwy+o0LiDHdbec4kwBdBLhBTKWMD/3bcHZoF4Cev9mCVzO20+zXqfh
 C1vQ==
X-Gm-Message-State: AOJu0Yx3PjhD+wjT1e61UEuXRHPEwvJqZB8bu3DFnBzne94tXI0FbrOQ
 VBAiAYmyc0Kj14rsklW7ODVTOIwl4IIA30+sv5QV1yTbvRIRfLPBz5LwFWFYyMoPlqv0NcdVtGV
 u8myniv8beyf/302fIXajWyKAEUAamVWU8tcHou692g==
X-Gm-Gg: AR+sD11XVjujq3Mkj5AZCwHKbM8Vd+42NNM5qmjgjYXlRRDoO50OaA6eVJYnQBPd9WC
 Ka6jdCvqQPDIsH+06jFg6d1PYpvUsy5h9GL3X9Dstf9Kks6rvOUugfU6UaM8Ds+R4j7ejsTJ/rs
 QPAywzb64XoNx1QhOVsuMR14C7qQsEZHd1A4VK+aVw72GbFD6It/+ehuMT4TiCpXARDxPOwVMvp
 pFpImgHVUuN8gJrx+FnSHOlvuzcRg2ubJPqnCQjEF/8bd2e6czCeI2BoRbnHTfx7xFicklK0YRO
 cx2U4uQbBKG6eJzmBw==
X-Received: by 2002:a17:907:9720:b0:bf0:2253:ad67 with SMTP id
 a640c23a62f3a-c16b482612amr792319266b.46.1784638046729; Tue, 21 Jul 2026
 05:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
 <20260713-rk3588-fracpll-v1-4-cdf47f2ca0b8@flipper.net>
 <3bdc641d-7279-4618-94a4-dd9f33442388@cherry.de>
In-Reply-To: <3bdc641d-7279-4618-94a4-dd9f33442388@cherry.de>
Date: Tue, 21 Jul 2026 16:47:13 +0400
X-Gm-Features: AUfX_my6TIDUUW4N_WuKJnsWtnsDIKAtf_1Gtg6XpLBuq8Q9bmwuSPOEsR8yJH0
Message-ID: <CAKTNdwH88yh_x7U_d2eJ2L9chvj5tSyD3LcNdSaASnPmbij_LA@mail.gmail.com>
Subject: Re: [PATCH 4/6] clk: rockchip: pll: let rockchip_rk3588_pll_k_get
 update m directly
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
 d=flipper.net; s=google; t=1784638047; x=1785242847; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZkPZOhscYItds8hYt94EkzFkC7lJHTuUTmGTJ9CM22U=;
 b=p2H5DNg6Psp7szUrF/WCRTFAffc1a0pOi97cfkllmPAhUpzibXOlppiImwItf69pM3
 HPc9UYX8VT4uEYUjit/yGKggoYlG7oMIsITSOUkKBwIfh1mMARDpPha+uND/6IqxvtCe
 JHsA3f2t0qMlYa9WZLs8SVt2aM5uHPhAvP2yMWfzit0858fEpfC0xkBe7eOfjw0AlNkB
 8vVR5+r2f6Cf4eqOtQmPqMvfSzhp/3Kr4+UAKC9Z9NmeerZEiqemsCrU9Z/5lvLDXOZN
 ydCzSp7Nk4uhOQ5R24hybUvEr4n0sil1b6bQVT84t7USXm6O/ghfqiibVDBIZEc6lij2
 RPzg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=p2H5DNg6
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alchark@flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=flipper.net header.i=@flipper.net header.b="p2H5DNg6"; 
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

On Tue, Jul 21, 2026 at 4:19=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 7/13/26 8:35 PM, Alexey Charkov wrote:
> > Selecting the next integer multiplier m is coupled to setting a negativ=
e
> > fractional coefficient k. The current code checks for negative k in two
> > separate places, which is error-prone.
> >
>
> Yeah and it's kinda ugly :)
>
> > Let rockchip_rk3588_pll_k_get update m directly, to make it the single
> > source of truth for the final value of the integer multiplier m, which
> > also reduces the number of scattered conditional branches in the code.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >   drivers/clk/rockchip/clk_pll.c | 21 +++++++++++++--------
> >   1 file changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_=
pll.c
> > index c6fbeb71c77a..6324c11091af 100644
> > --- a/drivers/clk/rockchip/clk_pll.c
> > +++ b/drivers/clk/rockchip/clk_pll.c
> > @@ -168,16 +168,21 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
> >   }
> >
> >   static s16
> > -rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u64 fin_hz, u64 fvco)
> > +rockchip_rk3588_pll_k_get(u32 *m, u32 p, u32 s, u64 fin_hz, u64 fvco)
> >   {
> >       u64 fref, ffrac;
> >       int k;
> >
> >       fref =3D fin_hz / p;
> > -     ffrac =3D fvco - (m * fref);
> > +     ffrac =3D fvco - (*m) * fref;
> >       k =3D ffrac * 65536 / fref;
> >       if (k > 32767) {
> > -             ffrac =3D ((m + 1) * fref) - fvco;
> > +             /*
> > +              * The requested rate is closer to the next integer multi=
plier
> > +              * m, so pick it and use a negative fractional coefficien=
t k
> > +              */
> > +             *m +=3D 1;
> > +             ffrac =3D (*m) * fref - fvco;
> >               /*
> >                * Round up to avoid overshooting requested rate for nega=
tive k
> >                */
> > @@ -201,7 +206,10 @@ rockchip_rk3588_pll_frac_by_auto(unsigned long fin=
_hz, unsigned long fout_hz)
> >                       for (m =3D 64; m <=3D 1023; m++) {
> >                               if ((fvco >=3D m * fin_hz / p) &&
> >                                   (fvco < (m + 1) * fin_hz / p)) {
> > -                                     k =3D rockchip_rk3588_pll_k_get(m=
, p, s,
> > +                                     u32 m_tmp =3D m;
> > +
> > +                                     k =3D rockchip_rk3588_pll_k_get(&=
m_tmp,
> > +                                                                   p, =
s,
> >                                                                     fin=
_hz,
> >                                                                     fvc=
o);
> >                                       if (!k)
> > @@ -209,10 +217,7 @@ rockchip_rk3588_pll_frac_by_auto(unsigned long fin=
_hz, unsigned long fout_hz)
> >                                       rate_table->p =3D p;
> >                                       rate_table->s =3D s;
> >                                       rate_table->k =3D k;
> > -                                     if (k > 32767)
> > -                                             rate_table->m =3D m + 1;
> > -                                     else
> > -                                             rate_table->m =3D m;
> > +                                     rate_table->m =3D m_tmp;
> >                                       return rate_table;
>
> I don't like this much more, it's a halfway-solution to me. I suggest to
> pass rate_table pointer directly, instead of only m, and update
> rate_table m, p, s and k if we can find a k that works, otherwise leave
> the pointer untouched. Change the function to return 0 on success, 1 (or
> -EINVAL) otherwise and return rate_table in the for-loop if 0 is
> returned, otherwise continue.

Indeed, can do that. Will reshuffle in v2. Thanks for the idea!

Best regards,
Alexey
