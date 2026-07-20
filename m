Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3DFC4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A49182991;
	Mon, 20 Jul 2026 10:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EUVb3kB2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 659F083E76; Mon, 20 Jul 2026 10:00:13 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE52080517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-9063b380982so70930046d6.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:00:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784534410; cv=none;
 d=google.com; s=arc-20260327;
 b=o8iHM8YZ7O/apdBwfiQZnkN/tyQme+76euXQ8ip/epZoF6maocdM3Ds8+toMEZnxpj
 v8JqZsKJVoPTxbw7mC+F4vsoTmzh0G0yTzNI66j72HdmpTqLOHvb1nil2IX2n5Z6i+K/
 P3gwzW69fDDiSUA7/yckUnD02lw12ydL98SNyXuKap838lESBWxNAnroGw/UOQjGGVnm
 G4WZ+fYjOdgwViQr6fhMpfJqtcJynUqM1m5cG+S+Nc7gTgvtk0WGibng9CBqqhMuAN+o
 p9UQWQgty4x5Ccs9NBzA52bB2r3eJCFY2k4Pa43AjvNlpjjKQHnOgm/fGpoJB2Et91Kw
 u1Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Eq0DiwfO/cI7KtBojXo02hrfwCwK9o/B+352sh/Ph3g=;
 fh=Y6mMHk8/m+QDOd5xaaDvLtBkSaKqdM/AAf9kf88Cr9M=;
 b=KHqpH28iCvwoGPDnsYJRLJBhML8+mIjSWh16rEMFvEXwhlB9ckLMh/r8XMKkMjWzPk
 ciBUUX/SMIFHm7zm1eaTu1M62t3a2GiFy6cM1ByBzuXOIDUGbgebLmaKRwtVAl1KWWk7
 60B9k9g1WgzXIKT+9n6I1gsfJaeOP7Gwv9anaDAE955q2xGW1oZFqHDJWEfnhW1QLGus
 GGVMXLT2Uuih7cGDBpdd+IztIjwJENIVWdDt2EWwtwEfbPUJ2a8Up3UkGq8AUKd6LDne
 qKMJdfK+oi8zqfC020NngjfEcWUe9cCeM672uu/Roq78EiY5x/wVWBWy1zpT6f6fhSSL
 4YHQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784534410; x=1785139210; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Eq0DiwfO/cI7KtBojXo02hrfwCwK9o/B+352sh/Ph3g=;
 b=EUVb3kB2jzfNDrgDbyIZ6w9YuVAvrvMX+DOF2e1pOG6v+PQn3F/0mE2GuchFY+HcDP
 I4GVeU3cuosS9ZOB1/PGUPF5K2UsoSV7ynGeX2qTaNSN2TaWthDrt6ITS53qg0tpP3uC
 wh6weNzhB7ZnCcv1rVQvQ/EANcXw91toRaRgq6+iQi0HfgfyHdZPwVO0/yEiLcbKARWX
 AV+3QAihSwfOxewaifDmPbNUezjypsL0ahH7piEKyXHHkjHD1+i1dmcFbLErndk4dV2B
 ziuET6GeRuowlq7JsO47OMzRrdlifFUiOmIRpgiR4Kr3M8yQaiiZS+MCb2dWlEl0lcIm
 s8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784534410; x=1785139210;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Eq0DiwfO/cI7KtBojXo02hrfwCwK9o/B+352sh/Ph3g=;
 b=shz62LtPdYhJspIZamCT3MjkzGbDHa6OhT3pXOmt7rj2oD/ZCyhfLKyAXr1BXkLHup
 /zBMfVE1D7d5PaLORO7byCLbqV7Dy7JkDyib/CKxX2+OJ4FezbMMmBGaRqXLavPrSatd
 dS5G5DyNUbG21BHVkibH6LPR5Q0DF6z3ssRLkQ/RKDDK+eY6iI4gB3L9IGexwpVhQ7bL
 IwhgITed0bibc4BK2XmJlENSade3eroX4rJYEvvPoubuD7VQQ1hpzScVvhdRj8hclaYz
 lpMcJBQFDkD79t/AhjHtG0X7Os2vB9AZXxXFEg6qdwn5VSF2AV9AGoOZcfLH9evhUTiR
 Rbbg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXAtQU/YUKl3nsHsuHTxm3QxQcsYOrwBpTMrAJCVRXHG0HLt27TVBTpIxFmnPhL+h5IBDRLXk=@lists.denx.de
X-Gm-Message-State: AOJu0YxeP809/H5gfWA4ure5bcTOpxADHJYvk3Qj9agl1gcvo61YAKRF
 J9pZglhnI2XoHaxPW4FKK6FAUwo2aveSfi4Rd5ckAz1tC85O0GV40u6piu1OrJr7X4SoCRRMQzL
 4Abty9AhcFd+T09v0y65AeoPR/pJ2sN0=
X-Gm-Gg: AfdE7cm4ZqSiK0jAp2OyjKbzwWg/YszekUsgsgDvb9ajFn2fp0grpKpjc6/51ybzMF2
 Jm2FKDhsv0wMQ7zsfJ0IKlwFNb07KrlQ4LUB3H1wyWKV2BAt7lknUTshYFMC/WBU0+lYKKduDLO
 dN9dPPwVa9yw/IcU0jn0hjZLM6jVYhfYNOcwSQgZQLEZjPBk0zbxSr6kDimVQz6dyhHPbBn/zkJ
 4lcA0ry0NvSaqlu3zCSP4sJE3/3ZVS4LSrJc74JqXRXgORRgCTsQ7/Kk9kmVA6fX7NuUcqaU7wR
 dnzpVf3xCo7TBbwM4pkBd9kl4dnFLMC6NkDLOwmbiiF74bYZA7wAYw3shPrURQj3JgnEIo3Edom
 +KSECt9pl3wT8zK90vHIdWletcUJv76em8KYcII05d1ZFYJDl2ZycCOO7
X-Received: by 2002:a05:6214:43ca:b0:8e8:4c4:339a with SMTP id
 6a1803df08f44-90778312665mr138860796d6.12.1784534409584; Mon, 20 Jul 2026
 01:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <09e8f60c19d19b1bef47594e89de52585e6405ad.1784423890.git.daniel@makrotopia.org>
 <CAOP2_ThcJNDU1Q8Otvg37LXjOTZGVoR5XruDBBypGqJ3Q8E=KQ@mail.gmail.com>
In-Reply-To: <CAOP2_ThcJNDU1Q8Otvg37LXjOTZGVoR5XruDBBypGqJ3Q8E=KQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 20 Jul 2026 08:59:57 +0100
X-Gm-Features: AUfX_mzVfkTW8d_6YuWAigjDY_rn-l6ZD4Ol0jE-MN6vu0qzlr14lgQUyjMYRts
Message-ID: <CALeDE9MQsvqUryOeHogR87t8Et7JZ6NbzqjXknxz9ipcjOFxXw@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: rk3568-nanopi-r5s: drop eMMC HS400 modes from
 the U-Boot FDT
To: Tianling Shen <cnsztl@gmail.com>
Cc: daniel@makrotopia.org, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, 20 Jul 2026 at 02:59, Tianling Shen <cnsztl@gmail.com> wrote:
>
> Hi Daniel,
>
> On Sun, Jul 19, 2026 at 9:53=E2=80=AFAM Daniel Golle <daniel@makrotopia.o=
rg> wrote:
> >
> > U-Boot passes its control FDT to Linux, so the &sdhci override adding
> > mmc-hs400-1_8v and mmc-hs400-enhanced-strobe reached the kernel, which
> > unlike U-Boot actually drives those modes and then failed on the eMMC.
> > Keep HS200, which works, and leave HS400 out. Affects the R5C too, whic=
h
> > includes this dtsi.
> >
> > Fixes: 0ef326b5e92e ("rockchip: rk3568: Add support for FriendlyARM Nan=
oPi R5S")
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi b/arch/arm/dts/=
rk3568-nanopi-r5s-u-boot.dtsi
> > index 64c43374c04..7e0b2ba02e4 100644
> > --- a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> > +++ b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> > @@ -15,8 +15,6 @@
> >  &sdhci {
> >         cap-mmc-highspeed;
> >         mmc-hs200-1_8v;
> > -       mmc-hs400-1_8v;
> > -       mmc-hs400-enhanced-strobe;
> >         pinctrl-0 =3D <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>=
;
> >  };
>
> The whole sdhci node can be removed from u-boot.dtsi since these props
> are already included by upstream dts.

I've already sent a patch to do exactly this, it was on my list to
chase up for this cycle:
https://lists.denx.de/pipermail/u-boot/2025-December/605369.html

> Thanks,
> Tianling.
>
> >
> >
> > base-commit: ece349ade2973e220f524ce59e59711cc919263f
> > --
> > 2.55.0
