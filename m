Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08921E6ADC2
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 21:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 806368912E;
	Fri, 22 Nov 2024 22:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eZdyHv+k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C11C4897D0; Fri, 22 Nov 2024 22:44:50 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D39988E4B
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 22:44:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-720c2db824eso2634643b3a.0
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 13:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732311887; x=1732916687; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NW7szDSIMyDloxywuujDSQI8jlwJDoaxi/di9nqY5FQ=;
 b=eZdyHv+kvK67yReh+xOMqboioGcAqY+8cNnuxt2ZaBDkM3oW6ufKcZyLqY7f4eYYM4
 Hm1WUodMj67d56o/37vO137wYTcbNqRvvWQ4YBsz2WqqB3GQ9MTsizZ2PdUbkOHO7e/v
 supNEetEEyUBTtMYGkcudIN2mWBiYAg7F6JVWsTdkbQpO+ccwskDcOb6E5GU4yZVZSyp
 hrWKwpFOXdFIAodpgBo+Eah8/dr0NHs+boGBLQpAZNsBZ2JoxkUMm/wh6edYn+dwAhhM
 t1fUGt4DucXfX2J1RUkEGwNkdh2vO4JoIG9aHBYZthjzpJ2ZmTsi8Kr3AWGpydahXzBJ
 jgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732311887; x=1732916687;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NW7szDSIMyDloxywuujDSQI8jlwJDoaxi/di9nqY5FQ=;
 b=rmAwS6dRtWC+DNVU8qY3dB0Jo0aPtKCnKeTmfa4gaD3+VtrmLSi3FE5CcRx4iyZat5
 ksvGAtwXp+5GoHBrzPWkwHGepHhEy6ywojWbIjpQ6gF5VSH9MhDlUrXRbRLSqfeai1U9
 f6WwREPhCUXUx4OCVzeNZ8DBs0IG+qrl5n+MvEbWKo+OBml5iI/sJi/PpL0/Q64CrXXz
 EAhn3emTD32TOHNMBxwo/G5nweMFsoG0+PVufOTyxAimCk8466w0n9Nng1FFmwHEDg6X
 tJTeedyj0OlpVnrORLTvC5BYuwCABKA6QCNYRWOC0M2hHOpzbRe7/5+iozD9jevALcbQ
 NSJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnmzbHb2HpY8ALMQsnKzaigPzNFEJXK6TUOkuFlAq8fF5irYaNrDPqLKM589/DYiT+K03+U7Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxY6bnhSAcy+p7WaDlanEq44nThVpyHzkWd6E1MNwU4SAQXk5zo
 7gonIWoOhfoOQR8JkG6uqT9MDhO4dEQOvYzQAOjNlH2l0XDGJyZt3VBdacZeeGWdx0cwgwnVRah
 F8ewB5QA2l4UYpmC4JA38iIX9iCI=
X-Gm-Gg: ASbGncvBQjin/GfapHOM9zTMBYV8OQptMcrgyMKnfHuqhriKwzEYuNBS48iinIcax1q
 H5vZRwHgLhypEn7NTUv8F9pMKAQPxIQI=
X-Google-Smtp-Source: AGHT+IGiRlixZ9mNb5lfqG3Uy4yl7LT3Sd0HYSLQop542FdyzGGALermHBOb0JnaAAwXsLDKu6JC6roC5UpZzBz35Uw=
X-Received: by 2002:a17:902:e543:b0:20c:e6e4:9daf with SMTP id
 d9443c01a7336-2129fd0bd0fmr63228735ad.13.1732311886894; Fri, 22 Nov 2024
 13:44:46 -0800 (PST)
MIME-Version: 1.0
References: <20241122015858.557561-1-marex@denx.de>
 <20241122015858.557561-3-marex@denx.de>
 <CAFLszTigYfBSSmQwKs87CrVwtZRqPRJ+7yc-RdDk3uh5Sgwcfw@mail.gmail.com>
In-Reply-To: <CAFLszTigYfBSSmQwKs87CrVwtZRqPRJ+7yc-RdDk3uh5Sgwcfw@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 22 Nov 2024 15:44:35 -0600
Message-ID: <CAHCN7xK7UbP=JgaoVW4d+OxZ0HE8=0kyFacBJeaVEbNR4sPhSA@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: imx8mn: Remove unreferenced
 clock-controller clocks in SPL DTs
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
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

On Fri, Nov 22, 2024 at 8:33=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Marek,
>
> On Thu, 21 Nov 2024 at 18:59, Marek Vasut <marex@denx.de> wrote:
> >
> > Since 50cdd3f74af3 ("clk: imx: clk-imx8mn Fix nand and spi clock parent=
"),
> > drivers/clk/imx/clk-imx8mn.c clk_get_by_name(dev, "osc_24m", &osc_24m_c=
lk)
> > fails with error -22 EINVAL in SPL. This is because clk_get_by_name() i=
n the
> > end calls fdtdec_parse_phandle_with_args(), which iterates over all pha=
ndles
> > in clock-controller@30380000 { clocks =3D <&osc_32k>, <&osc_24m>, ... }=
 node
> > 'clocks' property in an attempt to find the "osc_24m" clock, but fails =
to
> > resolve the &osc_32k phandle and returns with -EINVAL.
> >
> > Remove the clocks property phandles which cannot be resolved because th=
eir
> > matching nodes are removed from SPL DTs, so fdtdec_parse_phandle_with_a=
rgs()
> > can resolve all the remaining valid nodes and successfully look up the =
osc_24m
> > clock.
> >
> > Fixes: 50cdd3f74af3 ("clk: imx: clk-imx8mn Fix nand and spi clock paren=
t")
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > ---
> > Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> > Cc: Bryan Brattlof <bb@ti.com>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: Greg Malysa <greg.malysa@timesys.com>
> > Cc: Ian Roberts <ian.roberts@timesys.com>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Jonathan Humphreys <j-humphreys@ti.com>
> > Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
> > Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> > Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Stefano Babic <sbabic@denx.de>
> > Cc: Sumit Garg <sumit.garg@linaro.org>
> > Cc: Tim Harvey <tharvey@gateworks.com>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: u-boot@lists.denx.de
> > ---
> > NOTE: For v2025.04
> > ---
> >  arch/arm/dts/imx8mn-u-boot.dtsi | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-bo=
ot.dtsi
> > index 6d80d856365..38e1934aee8 100644
> > --- a/arch/arm/dts/imx8mn-u-boot.dtsi
> > +++ b/arch/arm/dts/imx8mn-u-boot.dtsi
> > @@ -51,6 +51,10 @@
> >         /delete-property/ assigned-clocks;
> >         /delete-property/ assigned-clock-parents;
> >         /delete-property/ assigned-clock-rates;
> > +#ifdef CONFIG_SPL_BUILD
> > +       clocks =3D <&osc_24m>;
> > +       clock-names =3D "osc_24m";
> > +#endif
> >  };
> >
> >  #ifdef CONFIG_FSL_CAAM
> > --
> > 2.45.2
> >
>
> We should not be checking U-Boot CONFIG things in .dts sources, since
> there is no way it could go upstream.

This file has the -u-boot.dtsi ending, so doesn't that mean it would
be unique to U-Boot and not be pushed to Linux?

adam
>
> get_phandle_argc() shows how this is done in dtoc. It seems we will
> need similar logic in fdtgrep to handle this. You'll be pleased to
> hear it is written in C :-)
>
> BTW the bootph tags should be able to go upstream and be dropped from
> the .dtsi - the only thing in the dtsi these days in the Binman
> definition, which is barely started upstream.
>
> Regards,
> Simon
