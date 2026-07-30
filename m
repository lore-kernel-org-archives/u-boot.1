Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5F6C55160
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 12:26:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E39AD6068C;
	Thu, 30 Jul 2026 12:26:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1xBsELT_8FHt; Thu, 30 Jul 2026 12:26:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E432860890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785414366;
	bh=Nj+CJA7gn2IvNI7FUsowVn0ANFBbfOE044zRHz554lQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Girm+JvUMn3HOPX6jAxFiU3XlwNY3szgiQedYyh9dIHLOn4AMtyUSlh74S5FHpcA4
	 wrTunTcqpobOyhDtTOOlZS5F9HOeZ8ArtbrYyYZKZhuKV3wpzk/a9wEa3BRXmkEG9/
	 nbmBAgI9x8QwhwUIUbp8ISb35kPlQlBcu9LdU2sZrMi/EukOLlTXiK+HoHGP2sBcty
	 jtdCzz2jtuRL2zeUDUaS/mxsty3pY6VXCjmcLKshz30srcQMvTUQ65ytMb8ggMUGAJ
	 UKgJ6hWYh6DGxfSLKOVWbANM9nzd1xc8HbpA2oGExc8dHasvoYyWysJT4KkSl5T72J
	 lR3sX6LaXBSWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E432860890;
	Thu, 30 Jul 2026 12:26:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D002E42A
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 12:26:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1A20409E3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 12:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xkaesAl_Nz7L for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 12:26:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 89C364094D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89C364094D
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89C364094D
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 12:26:01 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-69fc2261f2bso3215148a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 05:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785414359; cv=none;
 d=google.com; s=arc-20260327;
 b=e1/evQZoWHORTPpU3wb6Lgm6IYKUYSf2PyQelN1HPCmuexn0y0vqcEOnR8AV2YzqBH
 5Z3rE/949ueV6Eht8tYkT2CVi3RTq9T51pRqOqvOC2Wrl5+XeF2bde45smNNNz55Oax1
 9S5tZQTPm0Sgvn7YWCpbMhXbnVsPYb36cixApcaElagygKMokGJ7HGrFBXQGkdaZdmKB
 LJBbJjxxto60f1tAwlNf2j3SRkYvEE3d1HyUhp9SqG8U/pnfCI40qvN3tCh9Oh9GgHPV
 CUkSCtnOWXx8p4bbQK6Bpm++w12xJvGigIG+eI4Brl7vpxagp7Bhr0g6PF/72e64OxrX
 r4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Nj+CJA7gn2IvNI7FUsowVn0ANFBbfOE044zRHz554lQ=;
 fh=ilVjBmvQ8waar/Vk3BoODLeJhWGJlNd6Qr8GzyBDCAQ=;
 b=ZAEs8Q17qJtU36eVnxe8DtAGKvYsUQCXO4p89rU4ohcmRYFcEA5kzPaq2WfIAHjNnN
 tdeNowJ8Z3vHydBY+134pEX/+RNnNQBWs1PrBYcaXX2KropnWVbzfJa8tucZfHvl4hyz
 DzEznWRT7OP8lt0M6SEbZIh9mLDZE8cxpq5iIostXor4qoUEjUvzGfr6gVd4QXtWnhNW
 KPyz6a6P8CahBLExI+l3MBD5fv+v2JJL4Dek68VnnC68md1MeRA0wFE1E7pH4Znqbvp8
 a+4CE/VuQWgGcR4ZK+kFiRVmcb6S7N9eZWq+2MdB2cuaPMAIrlPwoAMXZvwWXsM0ztR2
 rA7w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785414359; x=1786019159;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nj+CJA7gn2IvNI7FUsowVn0ANFBbfOE044zRHz554lQ=;
 b=fvfK1Eg1JCRw5jDH5c3ou4yl8mo+aSZ2KsqmDcHRNU+ufw1YlU1NWcVSbhkE8jYn47
 MIfgJQzlIDPIPAYBrBRxGCWuLOFHJhbFU+Nr2Fxms89UpCwAcEV4kq/lt9GLOx3qpC7K
 gogqm5rDbzDtpX05GW5lcQKOYO8EQj0otum2oSbKZwYx9YL88XauUbLq/165r7qg5JLF
 hjat+/M8pozSsLP734vCMKcDEHbJWNjhNCwDVlSOeP6WPv3I1gz7ezqZxKjg1CHoFs9l
 pID3Lq+oByCV0wL4Z6HU6TnRrYAI+GCDiZqIGKoypyuaxltAmmQgz1aade9y05uPmMSW
 6Jwg==
X-Gm-Message-State: AOJu0Yxtc6ut5vz2d7fOnNwYl96izPxIa2g0fL1/YkfN8R8ipeRVkk1g
 o201veqhhjaGzGUxaaVIGzdnpAdfxJ+gAiBVFHLDK6UTjnskZqwGlhL7mBXie5olg705VRYRAnO
 A8YYyv9oHGC7jEZ0qYrtLenGS9wk15d91WSv3vDf0dAR7vuWY7sRBDynIMUdR
X-Gm-Gg: AR+sD12LzAtB6MPq3YkGdaRHrtHDwsBiuNwS4rUFq1/uTGfF1hvvZ1gpxK/5E83lYAL
 D7w4JdwZjB07G57OaabGUodMhc58TzxG1UbQbppqwhodzZ/fM9laKPDpdyhqFz8vFJzNXAGg8im
 DQIvKgUk2TZwRqn95oW2nGt8DqTXtoZO+I/E+/9qJKTy44aNh4kRlQlrC//eOogEzqRQAiAub/t
 98D4l42AuCEgWh6Uvzh5Vv29Ty56StwsgMeRHHRFg0YHoINISZmElgB98gqfTGKDNi3Gy2RcZOn
 dnpUe1god6jPwhpIxMYrV3vZEq1LVdUAPB3S3vxacqW7+EVnUTpbp47cG58nBPhmyCAnLOdDiRj
 OQVa3tm0qDvhzn3aB2zLPRwE=
X-Received: by 2002:a17:907:a681:b0:c16:6469:3f1b with SMTP id
 a640c23a62f3a-c1fa575ef27mr128848866b.41.1785414359250; Thu, 30 Jul 2026
 05:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-rk3588-fracpll-v2-0-382d113f3a80@flipper.net>
 <20260723-rk3588-fracpll-v2-2-382d113f3a80@flipper.net>
 <b258fdf7-16e2-49ae-b016-a54e710c4ae1@kwiboo.se>
In-Reply-To: <b258fdf7-16e2-49ae-b016-a54e710c4ae1@kwiboo.se>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 30 Jul 2026 16:25:48 +0400
X-Gm-Features: AUfX_mwtoaEfAMpDWc7Sn9Jdj9yD8Vr2zcXMB7BbhCUMPMJSM_MRDxEurE6dZ7U
Message-ID: <CAKTNdwEHeTHU1RPQrKVu4JEvxv0pnsa04m+kxT=5BOAEMZ3j7g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] clk: rockchip: pll: fix rounding of negative k in
 RK3588 frac PLL
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.u-boot-project.org, Elaine Zhang <zhangqing@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Finley Xiao <finley.xiao@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785414359; x=1786019159;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Nj+CJA7gn2IvNI7FUsowVn0ANFBbfOE044zRHz554lQ=;
 b=XsnyyO4KiopSHbwG41BK8hb8fpfg2CwMhDXQnZ7mR2KZIczpbdooOLGG01wYBZGMnU
 Fqou+z5XrNcCtCdupjUd0MVXplQ1YEGx1V7r19twyKC81bVDS5MbPfoPoTt2EPaMq34x
 y7JIRGf0bMNTwDIrgQvXwQD6Ipfm6GenC8h3dW+YUnin5K3xV65oM8e4cGInyMuNwlKg
 6806KnLHZ7lAv38Z5zk3HATZ5SLTh+Mbk7kL0avF6Yv1x2wDgZUEuYF3lfXKNdYQTek+
 grZtGcK1Wlgoy8AzbhP5AXb9+A+hhK1FryD7NWCsgf8i4B2DrCLSLDvbXu6IsojpPYZZ
 fH3w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=XsnyyO4K
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

On Thu, Jul 30, 2026 at 4:16=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi Alexey,
>
> On 7/23/2026 5:04 PM, Alexey Charkov wrote:
> > Current code uses magical constants when rounding up the magnitude of
> > negative fractional PLL component k. This leads to overshooting the
> > requested rate when the calculated fractional part has less than 0.3 in
> > its decimal part due to failure to round up the fractional part.
> >
> > Use a proper rounding up function to avoid overshooting the requested
> > rate and make the calculation more readable.
> >
> > Fixes: 6bfb37e70209 ("clk: rockchip: rk3588: fix up the frac pll calcul=
ation")
> > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >  drivers/clk/rockchip/clk_pll.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_=
pll.c
> > index d0df3b8fb49d..69d2d182dcb5 100644
> > --- a/drivers/clk/rockchip/clk_pll.c
> > +++ b/drivers/clk/rockchip/clk_pll.c
> > @@ -11,6 +11,7 @@
> >  #include <asm/arch-rockchip/hardware.h>
> >  #include <div64.h>
> >  #include <linux/delay.h>
> > +#include <linux/math64.h>
> >
> >  static struct rockchip_pll_rate_table rockchip_auto_table;
> >
> > @@ -177,7 +178,10 @@ rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u64=
 fin_hz, u64 fvco)
> >       k =3D ffrac * 65536 / fref;
> >       if (k > 32767) {
> >               ffrac =3D ((m + 1) * fref) - fvco;
> > -             k =3D ((ffrac * 65536 * 10 / fref) + 7) / 10;
> > +             /*
> > +              * Round up to avoid overshooting requested rate for nega=
tive k
> > +              */
> > +             k =3D DIV64_U64_ROUND_UP(ffrac * 65536, fref);
>
> Use of DIV64_U64_ROUND_UP() seem to cause build errors for Rockchip 32-bi=
t
> tagets, see CI job at [1].
>
> [1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/jo=
bs/54629#L4016

Weirdly, the macro is only defined for 64bit [2], even though the
function it wraps around also exists for other word sizes.
This calls for a separate fix to take the macro definition to the
bottom of the header, like Linux does [3].

[2] https://elixir.bootlin.com/u-boot/v2026.07/source/include/linux/math64.=
h#L51-L53
[3] https://elixir.bootlin.com/linux/v7.2-rc3/source/include/linux/math64.h=
#L344-L355

Thanks for spotting this!

Best regards,
Alexey
