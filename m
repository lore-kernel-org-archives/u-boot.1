Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EA2E6C5E4
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 00:20:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5643688AAC;
	Tue,  3 Dec 2024 01:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SVGQJf4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12F3488A0A; Tue,  3 Dec 2024 01:20:18 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B735D88AAC
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 01:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ffc1009a06so71906861fa.2
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 16:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733185213; x=1733790013; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+Tt2AI5fk2mjA3xItkDnp5Hh2jQaV9N5MytQijGXAU=;
 b=SVGQJf4trFt2wbWAW1s0YOxBpvdlkqQkHEPWMBiWNvVujxUVhBrWEsxXxTTbou91/9
 VoskZS89XkUOFPHzJMZKU0GJqR9XczDIFq1C4PYiSON4TDLnKi4Q0wZ/PL03EYRpvn/U
 XlmOmTju4CMIledpKZdPeedtvu6vsAQkmCEIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733185213; x=1733790013;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m+Tt2AI5fk2mjA3xItkDnp5Hh2jQaV9N5MytQijGXAU=;
 b=rtHgmjdaab/MBHXG8+zdhTFQGPbQo0aHV5cUUMxnyZNm6lheil7+gbv1lhQksjuOJh
 JsbL72bKmgzmOBElWKSU2pmJKd6K+Fd9hq8lPq1v1MD/IYpTnpltoFPjl9lbmkNxWulb
 etqmqNYWZ674XQYSbPk/K7oLhSI6b2RdGuPkvzi5CetBon/kpXTcZ0k89krqkd4F1l59
 9C/24e12K+n86AiCX2UIlRpUREb3EU2a0u5DCw3tLXc3o6L0gfTMtMh2hAcU+jM9p5nB
 ZlPyXkxhXhATz6WqIwAzGReX+Bb/I0VApF+d+Gm0cxtaOdeyyCApIv/iHRdcHVcrqQRR
 2B/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUX88MGahL98z99/L99Cs3yfsZjGP0K2TK3fbXvGGaYy/oGynfuP7Qfx2hkQc8RINg9Mxullg=@lists.denx.de
X-Gm-Message-State: AOJu0YwucuX/SFmr5oGuHJ/IZb/y+ioeBHDbLVlNMEv7YtdYCeOgnR5d
 d0mCaAuC75qfqdwUYHmM7mrNtp2vUM6dN1EkQqSepgDUkWHVu5/orhWz8R01NAib+Kos/y/8jnR
 4czfduqR/aw4eAZJuHqG7FoIsOY05SFqc8QcW
X-Gm-Gg: ASbGnctenCy63U4IL2F3+DOB8GPI6Nb/nmSK0lC83aFST2BjBFy082xZ55kxwZtJq2L
 aZocQINe0saz86VtyVSIHXcxTC6+42AOb
X-Google-Smtp-Source: AGHT+IE8TgS9jqy0C0gcB70oAdPSKxRZe7vEpuyxPYa1vyciPBfgTIZtUcGm/huAR4xMiR6RJXho7XJwxVbbClqjJHg=
X-Received: by 2002:a2e:a812:0:b0:300:3de:628e with SMTP id
 38308e7fff4ca-30009d0c33dmr4050491fa.41.1733185212888; Mon, 02 Dec 2024
 16:20:12 -0800 (PST)
MIME-Version: 1.0
References: <20241122015858.557561-1-marex@denx.de>
 <20241122015858.557561-3-marex@denx.de>
 <CAFLszTigYfBSSmQwKs87CrVwtZRqPRJ+7yc-RdDk3uh5Sgwcfw@mail.gmail.com>
 <CAHCN7xK7UbP=JgaoVW4d+OxZ0HE8=0kyFacBJeaVEbNR4sPhSA@mail.gmail.com>
In-Reply-To: <CAHCN7xK7UbP=JgaoVW4d+OxZ0HE8=0kyFacBJeaVEbNR4sPhSA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Dec 2024 17:20:00 -0700
Message-ID: <CAFLszTg5eR7U2sraikz3fVeNZ7XES-5=FWjvsMmAzwz=f+fUDw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: imx8mn: Remove unreferenced
 clock-controller clocks in SPL DTs
To: Adam Ford <aford173@gmail.com>
Cc: Marek Vasut <marex@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Bryan Brattlof <bb@ti.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Greg Malysa <greg.malysa@timesys.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Stefano Babic <sbabic@denx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
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

Hi Adam,

On Fri, Nov 22, 2024, 14:44 Adam Ford <aford173@gmail.com> wrote:
>
> On Fri, Nov 22, 2024 at 8:33=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Marek,
> >
> > On Thu, 21 Nov 2024 at 18:59, Marek Vasut <marex@denx.de> wrote:
> > >
> > > Since 50cdd3f74af3 ("clk: imx: clk-imx8mn Fix nand and spi clock pare=
nt"),
> > > drivers/clk/imx/clk-imx8mn.c clk_get_by_name(dev, "osc_24m", &osc_24m=
_clk)
> > > fails with error -22 EINVAL in SPL. This is because clk_get_by_name()=
 in the
> > > end calls fdtdec_parse_phandle_with_args(), which iterates over all p=
handles
> > > in clock-controller@30380000 { clocks =3D <&osc_32k>, <&osc_24m>, ...=
 } node
> > > 'clocks' property in an attempt to find the "osc_24m" clock, but fail=
s to
> > > resolve the &osc_32k phandle and returns with -EINVAL.
> > >
> > > Remove the clocks property phandles which cannot be resolved because =
their
> > > matching nodes are removed from SPL DTs, so fdtdec_parse_phandle_with=
_args()
> > > can resolve all the remaining valid nodes and successfully look up th=
e osc_24m
> > > clock.
> > >
> > > Fixes: 50cdd3f74af3 ("clk: imx: clk-imx8mn Fix nand and spi clock par=
ent")
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > ---
> > > Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> > > Cc: Bryan Brattlof <bb@ti.com>
> > > Cc: Fabio Estevam <festevam@gmail.com>
> > > Cc: Greg Malysa <greg.malysa@timesys.com>
> > > Cc: Ian Roberts <ian.roberts@timesys.com>
> > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Cc: Jonathan Humphreys <j-humphreys@ti.com>
> > > Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
> > > Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> > > Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > > Cc: Simon Glass <sjg@chromium.org>
> > > Cc: Stefano Babic <sbabic@denx.de>
> > > Cc: Sumit Garg <sumit.garg@linaro.org>
> > > Cc: Tim Harvey <tharvey@gateworks.com>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > Cc: u-boot@lists.denx.de
> > > ---
> > > NOTE: For v2025.04
> > > ---
> > >  arch/arm/dts/imx8mn-u-boot.dtsi | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-=
boot.dtsi
> > > index 6d80d856365..38e1934aee8 100644
> > > --- a/arch/arm/dts/imx8mn-u-boot.dtsi
> > > +++ b/arch/arm/dts/imx8mn-u-boot.dtsi
> > > @@ -51,6 +51,10 @@
> > >         /delete-property/ assigned-clocks;
> > >         /delete-property/ assigned-clock-parents;
> > >         /delete-property/ assigned-clock-rates;
> > > +#ifdef CONFIG_SPL_BUILD
> > > +       clocks =3D <&osc_24m>;
> > > +       clock-names =3D "osc_24m";
> > > +#endif
> > >  };
> > >
> > >  #ifdef CONFIG_FSL_CAAM
> > > --
> > > 2.45.2
> > >
> >
> > We should not be checking U-Boot CONFIG things in .dts sources, since
> > there is no way it could go upstream.
>
> This file has the -u-boot.dtsi ending, so doesn't that mean it would
> be unique to U-Boot and not be pushed to Linux?
>

No, we upstream all bindings so we should only have things in there on
a temporary basis.

The correct solution is to enhance fdtgrep which I think I explained
on the other thread. Let me know if I can assist with that.

Regards,
Simon

>
>
> adam
> >
> > get_phandle_argc() shows how this is done in dtoc. It seems we will
> > need similar logic in fdtgrep to handle this. You'll be pleased to
> > hear it is written in C :-)
> >
> > BTW the bootph tags should be able to go upstream and be dropped from
> > the .dtsi - the only thing in the dtsi these days in the Binman
> > definition, which is barely started upstream.
> >
> > Regards,
> > Simon
