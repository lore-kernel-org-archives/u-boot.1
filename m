Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DA9C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 13:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B29B880A55;
	Thu, 13 Feb 2025 14:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U+htNloa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB64180A55; Thu, 13 Feb 2025 14:53:59 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73025807D9
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 14:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43955067383so6448545e9.0
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 05:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739454837; x=1740059637; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TeT+rVjJ0GKPhR7bHvFEmGYgsgFk7hNg4LSUx75zmuQ=;
 b=U+htNloalpTH2OfPc4jLDV5Dd6aw77kNq7LInZuFPcBudLUr8eH2c4SnrULkX+J88W
 o62VhGplP0GP7/PC9ZqvVBd/cIPwj44I/UWumv8akKplzaIAaCE2cgzalZuIIeE5NYZI
 sCYc5A6s3djhsK1LnVwZjk7Vj/ejp1LX+DVaQvTR+3NKCUmG+i3e0WVuwYo1FT2f4Taq
 GTfwxcjHcGRClXvCBSJBCuAPThd0ULB7QfZVcDOzlvek2u0YyvFi8/9bEYPP2z7fTtax
 PTjLTFjfGG1wFXPMiuyc5A/XtYdfALrgUL3GBRX45YAA2LvsnRu3CKRXN+9UogmM7HaR
 iQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739454837; x=1740059637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TeT+rVjJ0GKPhR7bHvFEmGYgsgFk7hNg4LSUx75zmuQ=;
 b=UUiV3i4d66f2kKyv6heONcSHWfHBrfOr1zRWgJuuFiELCc/k3hNgMZ8r11WSS0sCGb
 7cESJ9eskqD+uaezjb3dFaRLDbiLVMyzW1TUotBWAM5+l9RK+4i4rwNKs1C7I37U6a1K
 xlllOwMd/sHlaFpkClpgDb7wtlPMIETRiw2siVMS1tCAE8Xjk5KMSbTA7cp204VcIYju
 9MGwcQ4QCagcPJEAfJ6ebW9BtL5cwQR9JsFS7OaWVKfWNFDigZ4FXpF5kRg/kxuWmqPB
 qlvJiHXAULmeXALsx8uFUTB9WIUQGFvfhi2aN2jHmtLC8dre0ZIQaqGSd5Qs0+1BOXX5
 /79A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZHv+FuGktmXdXcUdwkG5TxYswu7HUX7p8Ft/4O58dBrxz81JtJb8fka4TNFIZFAR80MGjHJk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9q/bLX5LMAZCkrPljIydyq73iBvjfNN0pZCyN686DTzdK4b3q
 DqTom3j3J/5bFWllZoORPEwWzQW6DIEmAMbRUNs+Y/SzuNPgHAldpBA0BJLpJys9P6Q+U5/9lEG
 ng1l2RQF0mBU3lvRH9ZPl0l962Lk=
X-Gm-Gg: ASbGncstAX2L+kFZpQf2H5J6GDB2B0eR/HU56uC7zgmQtdhAKH2YNuJ/rZwK3bYbjxY
 kMvjzNDCi7x+K47KxJUyBfjkziw+QTIkvg/LA6f5XJ3VIqkVs7349t1/CNBDPXzTVx1cdKdx92g
 ==
X-Google-Smtp-Source: AGHT+IGP3AQqy/LKUOn9ygH/2vTSZ+2G6LjMMyUMBbjYAahWlYT5MXdz4e5ovTp12dlCESN/S/9XoV7oLRCmqCNE4tE=
X-Received: by 2002:a05:600c:1c82:b0:439:5803:414f with SMTP id
 5b1f17b1804b1-43959925af0mr76114175e9.5.1739454836672; Thu, 13 Feb 2025
 05:53:56 -0800 (PST)
MIME-Version: 1.0
References: <20241212101331.6135-1-clamor95@gmail.com>
 <20241212101331.6135-6-clamor95@gmail.com>
 <CAPVz0n3Ek8Nchc9ZDzLKd03ac2H2Di=Z_NY3LqxruycL85VouA@mail.gmail.com>
In-Reply-To: <CAPVz0n3Ek8Nchc9ZDzLKd03ac2H2Di=Z_NY3LqxruycL85VouA@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 13 Feb 2025 15:53:45 +0200
X-Gm-Features: AWEUYZkdR9GNzX_g0ulLOfB_9-skaf5mhQpF9W9_VKuBDP_QqiDavgT4QtRWqE4
Message-ID: <CAPVz0n1hfoTnP3pKsDMGxWhOo=UGVA5_k=ScaFES8GAeh_7HTg@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] ARM: tegra124: dts: mark HOST1X and DC with
 pre-relocation flag
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 u-boot@lists.denx.de
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

=D1=81=D1=80, 12 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 13:20 Svya=
toslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D1=87=D1=82, 12 =D0=B3=D1=80=D1=83=D0=B4. 2024=E2=80=AF=D1=80. =D0=BE 12=
:13 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Same as on previous SoC generations this is required for proper
> > video output work.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  arch/arm/dts/tegra124-nyan-big-u-boot.dtsi |  7 -------
> >  arch/arm/dts/tegra124-u-boot.dtsi          | 13 +++++++++++++
> >  2 files changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm/dts/tegra124-nyan-big-u-boot.dtsi b/arch/arm/dts/=
tegra124-nyan-big-u-boot.dtsi
> > index 376dcdf68fb..79de06761bb 100644
> > --- a/arch/arm/dts/tegra124-nyan-big-u-boot.dtsi
> > +++ b/arch/arm/dts/tegra124-nyan-big-u-boot.dtsi
> > @@ -7,13 +7,6 @@
> >  #include "tegra-u-boot.dtsi"
> >
> >  / {
> > -       host1x@50000000 {
> > -               bootph-all;
> > -               dc@54200000 {
> > -                       bootph-all;
> > -               };
> > -       };
> > -
> >         spi@7000d400 {
> >                 spi-deactivate-delay =3D <500>;
> >                 spi-max-frequency =3D <3000000>;
> > diff --git a/arch/arm/dts/tegra124-u-boot.dtsi b/arch/arm/dts/tegra124-=
u-boot.dtsi
> > index 7c119725528..6a02714a258 100644
> > --- a/arch/arm/dts/tegra124-u-boot.dtsi
> > +++ b/arch/arm/dts/tegra124-u-boot.dtsi
> > @@ -1,3 +1,16 @@
> >  #include <config.h>
> >
> >  #include "tegra-u-boot.dtsi"
> > +
> > +/ {
> > +       host1x@50000000 {
> > +               bootph-all;
> > +               dc@54200000 {
> > +                       bootph-all;
> > +               };
> > +
> > +               dc@54240000 {
> > +                       bootph-all;
> > +               };
> > +       };
> > +};
> > --
> > 2.43.0
> >
>
> This commit for some reason breaks u-boot build for nyan-big
> https://source.denx.de/u-boot/custodians/u-boot-tegra/-/jobs/1020521
>
> Video device 'dc@54200000' cannot allocate frame buffer memory -
> ensure the device is set up before relocation
>
> Indicates that bootph-all is missing though it should be present, just
> moved into tegra124-u-boot.dtsi (this is required for any other
> tegra124 device which would like to have video output). Isn't
> tegra124-u-boot.dtsi applied if device specific -u-boot.dtsi is
> defined? May anyone clarify this?

RE-sending
