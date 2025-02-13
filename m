Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70876C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 14:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAD8580A55;
	Thu, 13 Feb 2025 15:01:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nXJBuzKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D994A80C77; Thu, 13 Feb 2025 15:01:02 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D0D3807D9
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 15:01:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5dccc90a52eso1371349a12.0
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 06:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739455260; x=1740060060; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B8qf3oVmpvDkdwyRtFYyx7wHO8NvkyoyXDv7X8RTLNM=;
 b=nXJBuzKH2JXvL47BzQfDRC8Z7wJ0/gIU83nD7ZMCMKsYLnJP7pw2UvzzLVpOHt8bFx
 BzMM2C7tnW6bJVhYG+WpADp5vPJpBaj1rzsC2C2geARb90z2xEZvmdO4kJavAOVlGLWe
 smARYQO2YNTllcvm9WsYy2DuVSGLwtkqQrl0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739455260; x=1740060060;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B8qf3oVmpvDkdwyRtFYyx7wHO8NvkyoyXDv7X8RTLNM=;
 b=U600oc+kyMs2AZFvjA0LRXzFwVfT3u+M+iFXoeJGAefkcyYam/MnqH0OUFu6Mt4gdB
 qoVEMach1px0WmDdeHwLZ0wYGSis1M9H46LQcKxJncs10MnqrBQUzBDGhSzBHbjgIsmE
 sUsW76aRz598ZfyEjsMng/1tET/CqIgjIUpGs+8CqAPbtzgeuXiO8kabyt6uW2WL2exM
 TWVTzRGjORLmuBjEIjgGNfbREqkFD2qqkOPMsqTzVbzGtX9HhsPiGYG+nOAj+e+aK3ES
 jqOD8hTJ5iDA4RGsBpa/VvkzLdC/2ONSKjwwHkQgDEKg4cKnI0phRtaC7USNylhX16tH
 RLVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY09odqs2pcJma4Nvt2Fkbvk48P6MHpFVg+U9f8vZNAKtTJQJgtvg5/+FgsoKKn0UfFNCibaM=@lists.denx.de
X-Gm-Message-State: AOJu0YynKXenC4OyIpUMObJEHZ4RirkqBVs3iEdojHHuNBaCFQWVvk9g
 xGpHGw/aa0awgQ4t7gCIQwndQ66+LYMle9gZA5TJSKPX+RQsouRZ1Zd2DjlHHwVKWPdAd/GtZgK
 cDb8yQxtUTQlLs2e5RS47StGHfv7sAe4xCH5s
X-Gm-Gg: ASbGncu26VqFidCWTSR9/3RC/UsK+LzhQHjJdH6TDxJo+RMi0IExY5LWTTmuWLjG7Ph
 iMfmQ1bCL5eZzsjC8bak6d7HBi2BErJFEjxhGKFGtneMMpnUHTcb/tgjUM3uM6LNWMuQMgFj+fT
 CwBhnOL5ol0hWbTma9WngmIDSfyPRx
X-Google-Smtp-Source: AGHT+IHWKJWcze0Iro53mfbxfmJwSzvd2+W2RLR/uW4DjWRVbNaO3xLPWUH59Q9N0KETRHA3uC7VUJ5t8O++mXMGvqE=
X-Received: by 2002:a05:6402:40c1:b0:5dc:1289:7f1c with SMTP id
 4fb4d7f45d1cf-5deade0a57fmr7352807a12.29.1739455258282; Thu, 13 Feb 2025
 06:00:58 -0800 (PST)
MIME-Version: 1.0
References: <20241212101331.6135-1-clamor95@gmail.com>
 <20241212101331.6135-6-clamor95@gmail.com>
 <CAPVz0n3Ek8Nchc9ZDzLKd03ac2H2Di=Z_NY3LqxruycL85VouA@mail.gmail.com>
 <CAPVz0n1hfoTnP3pKsDMGxWhOo=UGVA5_k=ScaFES8GAeh_7HTg@mail.gmail.com>
In-Reply-To: <CAPVz0n1hfoTnP3pKsDMGxWhOo=UGVA5_k=ScaFES8GAeh_7HTg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Feb 2025 07:00:46 -0700
X-Gm-Features: AWEUYZnW6wzPpfx3VXR6tKlOouMP6mnTJSJhN498IdiR5vNeWgNzpg5x-GbUkVw
Message-ID: <CAFLszTixFztEdYYjxQiTU3HNUFyGzoynDhTX+0xfN4QWixpivw@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] ARM: tegra124: dts: mark HOST1X and DC with
 pre-relocation flag
To: Svyatoslav Ryhel <clamor95@gmail.com>
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

Hi Svyatoslav,

On Thu, 13 Feb 2025 at 06:53, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> =D1=81=D1=80, 12 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 13:20 Sv=
yatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > =D1=87=D1=82, 12 =D0=B3=D1=80=D1=83=D0=B4. 2024=E2=80=AF=D1=80. =D0=BE =
12:13 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Same as on previous SoC generations this is required for proper
> > > video output work.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  arch/arm/dts/tegra124-nyan-big-u-boot.dtsi |  7 -------
> > >  arch/arm/dts/tegra124-u-boot.dtsi          | 13 +++++++++++++
> > >  2 files changed, 13 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/arm/dts/tegra124-nyan-big-u-boot.dtsi b/arch/arm/dt=
s/tegra124-nyan-big-u-boot.dtsi
> > > index 376dcdf68fb..79de06761bb 100644
> > > --- a/arch/arm/dts/tegra124-nyan-big-u-boot.dtsi
> > > +++ b/arch/arm/dts/tegra124-nyan-big-u-boot.dtsi
> > > @@ -7,13 +7,6 @@
> > >  #include "tegra-u-boot.dtsi"
> > >
> > >  / {
> > > -       host1x@50000000 {
> > > -               bootph-all;
> > > -               dc@54200000 {
> > > -                       bootph-all;
> > > -               };
> > > -       };
> > > -
> > >         spi@7000d400 {
> > >                 spi-deactivate-delay =3D <500>;
> > >                 spi-max-frequency =3D <3000000>;
> > > diff --git a/arch/arm/dts/tegra124-u-boot.dtsi b/arch/arm/dts/tegra12=
4-u-boot.dtsi
> > > index 7c119725528..6a02714a258 100644
> > > --- a/arch/arm/dts/tegra124-u-boot.dtsi
> > > +++ b/arch/arm/dts/tegra124-u-boot.dtsi
> > > @@ -1,3 +1,16 @@
> > >  #include <config.h>
> > >
> > >  #include "tegra-u-boot.dtsi"
> > > +
> > > +/ {
> > > +       host1x@50000000 {
> > > +               bootph-all;
> > > +               dc@54200000 {
> > > +                       bootph-all;
> > > +               };
> > > +
> > > +               dc@54240000 {
> > > +                       bootph-all;
> > > +               };
> > > +       };
> > > +};
> > > --
> > > 2.43.0
> > >
> >
> > This commit for some reason breaks u-boot build for nyan-big
> > https://source.denx.de/u-boot/custodians/u-boot-tegra/-/jobs/1020521
> >
> > Video device 'dc@54200000' cannot allocate frame buffer memory -
> > ensure the device is set up before relocation
> >
> > Indicates that bootph-all is missing though it should be present, just
> > moved into tegra124-u-boot.dtsi (this is required for any other
> > tegra124 device which would like to have video output). Isn't
> > tegra124-u-boot.dtsi applied if device specific -u-boot.dtsi is
> > defined? May anyone clarify this?

Yes it should be. You can examine the final u-boot.dtb to see what results.

In terms of the error, dc@54240000 is disabled for Nyan_big but I'm
not sure if that is related. You could add debugging to
tegra124_lcd_bind() perhaps?

Regards,
Simon
