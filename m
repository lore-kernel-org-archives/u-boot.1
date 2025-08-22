Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58BECA0EEB
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 17:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F43D80422;
	Fri, 22 Aug 2025 19:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="V2UJ2R7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EED3F8006D; Fri, 22 Aug 2025 19:06:00 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A058182998
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 19:05:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-30cce8c3afaso1492504fac.1
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 10:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1755882356; x=1756487156; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cY88SbMzrPRc+vp4uCDzFK2rASzKCDzg+MbgJpskbds=;
 b=V2UJ2R7tjKRc/YKQ/P1P8RzmSA1i1hU76eW5UHJEVd7wHWbyUzstNj+A0fnWMvDhbC
 jtDnWu314nvvI4KlGJyUBbmb/R7xHwr7ga/Vguj9Rfu/hGfbVVVcpjW/qFcnYfkHAyAa
 f4h+3tfikYa50Rz4AJAz93y15cTTsmJ+wNKA4ZhdfkAz9ttGIkK62W9C3jhJpTf+CH3h
 gf48EZuBjBx+z8rIg9J8q7ifX/yye6VZXQLEltDpmr6L9UWP7ywaQdLMKrlP7uVvpMRt
 E6G3mOcgmmBqbYpJo2+htQ9UQWiEmA8X+wXx37+pOar0FTBhWVA+oaqYvv0E1RUgsgrP
 XFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755882356; x=1756487156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cY88SbMzrPRc+vp4uCDzFK2rASzKCDzg+MbgJpskbds=;
 b=PZ+j6lLbKhapHrsZvtVASmQCxjSdjWMnHI7l7PmogGbCxgUK7U3FQWlFVFxv5kAxOu
 VlYftegpHK4sgSGYNzFfecfHHgMTD1s1ef3RakDz5U63UxE+g1nktBMLpWsyuIorgr+9
 1YPOe1gtUdnMDQpQ+epKsuKTFYmVYR2qRhyiibEXurCXic1aHGjEBNm0auyIy+2ENXA/
 tkf3Pa4ggru0hbbdhZSlkjNFlzAwrrZ0Nk/JeDEk8HGx11dpyduQRTVf+paOXCZasZWF
 uk+kIvihvgQE6PH4dXnj8eI5bWQLMutbvn75fSyNpDxlhyV162rSl7qeYbyoUNbtsTmD
 4R0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrsQK1ijR8KYP6Oxg+YmfSBPOejHbo8WqW3qyC5K7lbJlQ9GGIXsyq00QlCu/us3EVrmtVEh0=@lists.denx.de
X-Gm-Message-State: AOJu0YynkV6iEqm0bjADqcmpk57hW1P0pkHWr+l4NQL3vNgkIm+Hu99s
 gso1q+BbrRyWh5x8+pkCrjeRf1O/OyqHzRbmunn9qHq6ZXfTXkB505HHinB04ywgpfZn+FiWFPh
 W65VSvFvoOLwat3ZBYZjSOZSyvOF80mt3g5+P2BqiAQ==
X-Gm-Gg: ASbGncsTp8S027D+unuF2P5tO4fHLgA4AgumwYVobOWUULlq4AVvQgQdMnK7uMS+Y3K
 4FzLlly5mk7MdabNgbWO+tj8vV6nnH8gfbnkQ78uBaIz2ezg1Fi5T19ZuPvLCTntfjtXX2QAPU6
 Q8I0MM3OcRaxJ/FGjblMHZxtYxhNNDFjD853piFJV4rDUK06EKQ3JKotrQ4GMjnkH907LEvHBux
 UhLjiM97q1HTYBMdQ==
X-Google-Smtp-Source: AGHT+IHH+3V4RSUbeot8lqOUkJQzRabb3mA7V7jySuH4qS0RecmJsACIbF+gBOH1mT6m3MxOOCj9YGdHE2AQO+89LtI=
X-Received: by 2002:a05:6871:4009:b0:300:3df6:921f with SMTP id
 586e51a60fabf-314dcac768fmr1445290fac.8.1755882356351; Fri, 22 Aug 2025
 10:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <pqr4l75nuc57vmrp4r3hjwjxi4p5dgwxlz7h5nrn77rfxwpfmr@dto7364jv2ei>
 <beef5a40-acb8-4f47-944d-d876f5634cdc@kontron.de>
In-Reply-To: <beef5a40-acb8-4f47-944d-d876f5634cdc@kontron.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 22 Aug 2025 10:05:45 -0700
X-Gm-Features: Ac12FXwX6e-IvofeJS9rrRVYJFY6aCgp-C2-8LmQ-oBVE90DBbmHlYXICcMxUAo
Message-ID: <CAJ+vNU0pWaYCG86_XNwb9dMOLhTUzw_9hdFE7xpbMh4G73X0nA@mail.gmail.com>
Subject: Re: [PATCH] arm: imx: imx9: scmi: Fix booting from USB
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Francesco Dolcini <francesco@dolcini.it>, Peng Fan <peng.fan@oss.nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
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

On Tue, Aug 5, 2025 at 11:53=E2=80=AFPM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> Am 31.07.25 um 20:47 schrieb Jo=C3=A3o Paulo Gon=C3=A7alves:
> > Hello,
> >
> > On Mon, Jul 28, 2025 at 11:25:04AM -0300, Fabio Estevam wrote:
> >> What confuses me about Jo=C3=A3o's patch is that it was not tested aga=
inst
> >> the mainline U-Boot.
> >
> > In the end, the code is nearly identical between the downstream and
> > mainline U-Boot.
> >
> > On Wed, Jul 30, 2025 at 08:35:40AM +0200, Frieder Schrempf wrote:
> >> I have the below patch in our downstream fork to fix the issue mention=
ed
> >> here for i.MX93. It is derived from Fabio's patch [1]. I'm not sure if
> >> it's correct, though.
> >
> > We are also doing something similar on our branch.
> >
> > I have two proposals. My goal is to prevent the board from hanging when
> > booting from USB if CONFIG_ENV_IS_NOWHERE=3Dn (since the current code
> > assumes it is always enabled) and/or if the environment is defined
> > elsewhere:
> >
> > 1) Imply CONFIG_ENV_IS_NOWHERE for i.MX9 (as mentioned earlier), to mak=
e
> > it clear that it is required by ARCH.
> >
> > or
> >
> > 2) Doing something similar to what Frieder showed for USB boot (which i=
s
> > almost the same on i.MX8MM/i.MX8MP), but preserving the current
> > behavior:
> >
> > diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9=
/scmi/soc.c
> > index 13f13ca7d105..f973652d0cbe 100644
> > --- a/arch/arm/mach-imx/imx9/scmi/soc.c
> > +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
> > @@ -635,7 +635,8 @@ enum env_location env_get_location(enum env_operati=
on op, int prio)
> >
> >         switch (dev) {
> >         case QSPI_BOOT:
> > -               env_loc =3D ENVL_SPI_FLASH;
> > +               if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
> > +                       env_loc =3D ENVL_SPI_FLASH;
> >                 break;
> >         case SD1_BOOT:
> >         case SD2_BOOT:
> > @@ -643,10 +644,16 @@ enum env_location env_get_location(enum env_opera=
tion op, int prio)
> >         case MMC1_BOOT:
> >         case MMC2_BOOT:
> >         case MMC3_BOOT:
> > -               env_loc =3D  ENVL_MMC;
> > +               if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
> > +                       env_loc =3D  ENVL_MMC;
> >                 break;
> >         default:
> > -               env_loc =3D ENVL_NOWHERE;
> > +               if (IS_ENABLED(CONFIG_ENV_IS_NOWHERE))
> > +                       env_loc =3D ENVL_NOWHERE;
> > +               else if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
> > +                       env_loc =3D ENVL_SPI_FLASH;
> > +               else if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
> > +                       env_loc =3D ENVL_MMC;
> >                 break;
> >         }
> >
> > With this patch, I believe Peng's concerns are addressed, and it also
> > works for our use case.
> >
> > What do you think?
>
> On first glance, this looks good to me. If possible, can you please also
> send a patch for i.MX93 (arch/arm/mach-imx/imx9/soc.c) to align the
> behavior of both platforms?
>
> Thanks!
>

Hi Jo=C3=A3o,

This does resolve an issue I encountered as well on the imx95 while
booting via USB2 SDP.

Can you submit a formal patch?

Best Regards,

Tim
