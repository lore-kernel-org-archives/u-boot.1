Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111EFCA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 13:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D68582B07;
	Wed, 20 Aug 2025 15:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c/61P9zT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A97582F30; Wed, 20 Aug 2025 15:25:46 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BE208211F
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 15:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45a15fd04d9so6263975e9.1
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755696342; x=1756301142; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=taGT/GTm+Nvy2crIoQl71h9pKwGxAWSvfmnAiCINxbY=;
 b=c/61P9zTROjRY8x89COgc9CQxw4IHNrO6yz+gUbGleq2kY4/BNfBV6MTd3GjWBXrLn
 eZI4adZ/LFVo9SAYAh9D6uajX4vMerqNHNacIJOZ4zoqEe1aNm53BYsRqjtQ2Lpo7S4e
 UzAc3NmodZ6C7o9rTRBB9aiMPeWUHS7mmO/V5ofU+jgN4sOmOOdExRgGjX++t4evmBwM
 20Fg59xT8MFE3U5/zN6mBZkpxioBNRxF+Vk6a0sj2FAz2JUgeRL56Tp7r4Av6lGgJKoB
 u5o6TmEoTCN6sQ4sYPKoidiZQarEJNkna2yETYVfWtPtKsXy/1tmSYrR5OSuUWKrcGP7
 5H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755696342; x=1756301142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=taGT/GTm+Nvy2crIoQl71h9pKwGxAWSvfmnAiCINxbY=;
 b=bo0LFWZCdpdjWU3K11rEai8Ydzp4it1gRV211FcfplpY4n4WUyvmXOMQ5uOUxIhTbm
 9cTKiIwB6+0zNdimMaOBOdPC+jWgxZhbg+sQcKEW0kJD5HJxTafw4/y15aTG5AqASod9
 cq/Dwg7+EifgASsJxeh+I0p8qUbE9VKtrM5Doa730wcil5/ekYYhhsXrRXw3+NPd4CCl
 kibX1AhqjpuNk+7USv0qPTxO8AWWAsPDNccYNEE31/YGoqCIjNvFW3DwsMxxZkkRp2HI
 sAXTCsmQW/dEhIet8HeCZg4JmKWh6Mf0pBJ43hG4AzVUXR+gayc8+GvUIwjNECnu5RQv
 GWiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYQ4jLQ/SjPlllVpv1azqikLQpfRXCvhV5ybNzos6WBmNewtl1X9kDM+8Nq7sSLAhiz23GfTc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8rrMgNnnxc7FOSnSeu823MR3W2bU1uFc/sA6omIL+n1Gz+17P
 dxX0l2WplBhyKJNGbiVa8i/KmvqhhM4+sWY126KJVYHK8ITfmXAbp30g+8Qe2kSGHig7i4HYkUf
 +Km0ecS/qgUP1BmloglrtmTCiO1f8SJE=
X-Gm-Gg: ASbGncvRqiyF3QqSum48a9F1UiLQp6oKoX0HJSuxJkOKTIMZs4fyCqxA5IwsDz+yuuC
 K0t71RH/Iw1F6ANmOPwsNJWMnu5F2H+i7bfupJdBOrohCc4Fu8ToqaU0gJ03ejbfOhJFRTCF8Ho
 VL9wrdpYDFwlso14PaC7QoFfHYAKaDZrJPNrUEqtnVEnjx4Xi/uqT15uNftDjoN0DCSPkwIQJ8Y
 J0p8TMR
X-Google-Smtp-Source: AGHT+IGizEBGmA6rE3fGBdTslGo2Gwq2uVL9oEd0PxUv6YRl6SueWZjA0ReA2Vy7F7R/83EPETxBbndCoN2TcxXsYfI=
X-Received: by 2002:a05:600d:10:b0:45b:47e1:f602 with SMTP id
 5b1f17b1804b1-45b47e1f7famr17989875e9.17.1755696342325; Wed, 20 Aug 2025
 06:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250819154025.604784-1-pbrobinson@gmail.com>
 <20250819154025.604784-2-pbrobinson@gmail.com>
 <ifxdnkrcovvzzabf6w7nilhogxhu7ojrkdyurpwt6e7zfeuo2o@krp33vulky5r>
In-Reply-To: <ifxdnkrcovvzzabf6w7nilhogxhu7ojrkdyurpwt6e7zfeuo2o@krp33vulky5r>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 20 Aug 2025 16:25:30 +0300
X-Gm-Features: Ac12FXw32TyqDjQPuP0vAWuRMawoVm3-HBVcGzEZd0FpfRotl5FS-f3hZpVESuc
Message-ID: <CAPVz0n3pEMPD8yovi8Jqpp3T0mZJe734y00YtP5RTVecHu8wdA@mail.gmail.com>
Subject: Re: [PATCH 2/2] p3450: fix Jetson Nano SPI flash
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
 Tom Warren <twarren@nvidia.com>, u-boot@lists.denx.de
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

=D1=81=D1=80, 20 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 13:0=
9 Thierry Reding <treding@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Aug 19, 2025 at 04:40:14PM +0100, Peter Robinson wrote:
> > The Nano's SPI flash stopped working in U-Boot, as the
> > prior stage loaded U-Boot, the only thing it was used
> > for was save/loading env vars so update the DT so it
> > can now initialise it. It also drops enabling the old
> > TEGRA114_SPI driver, as the flash hangs off the faster
> > TEGRA210_QSPI interface, nothing on the Nano uses the
> > old interface by default so it's surplus.
> >
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >  arch/arm/dts/tegra210-p3450-0000.dts | 9 ++++++++-
> >  arch/arm/dts/tegra210.dtsi           | 6 +++---
> >  configs/p3450-0000_defconfig         | 1 -
> >  3 files changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/dts/tegra210-p3450-0000.dts b/arch/arm/dts/tegra2=
10-p3450-0000.dts
> > index 9ef744ac8b0..ddeeb232de2 100644
> > --- a/arch/arm/dts/tegra210-p3450-0000.dts
> > +++ b/arch/arm/dts/tegra210-p3450-0000.dts
> > @@ -124,7 +124,14 @@
> >
> >       spi@70410000 {
> >               status =3D "okay";
> > -             spi-max-frequency =3D <80000000>;
> > +
> > +             flash@0 {
> > +                     compatible =3D "jedec,spi-nor";
> > +                     reg =3D <0>;
> > +                     spi-max-frequency =3D <104000000>;
> > +                     spi-tx-bus-width =3D <2>;
> > +                     spi-rx-bus-width =3D <2>;
> > +             };
> >       };
> >
> >       usb@7d000000 {
> > diff --git a/arch/arm/dts/tegra210.dtsi b/arch/arm/dts/tegra210.dtsi
> > index 28ecd2b467a..6dd8fe26c38 100644
> > --- a/arch/arm/dts/tegra210.dtsi
> > +++ b/arch/arm/dts/tegra210.dtsi
> > @@ -762,10 +762,10 @@
> >               interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> >               #address-cells =3D <1>;
> >               #size-cells =3D <0>;
> > -             clocks =3D <&tegra_car TEGRA210_CLK_QSPI>;
> > -             clock-names =3D "qspi";
> > +             clocks =3D <&tegra_car TEGRA210_CLK_QSPI>,
> > +                     <&tegra_car TEGRA210_CLK_QSPI_PM>;
>
> Nit: We usually indent so that subsequent lines align with the first, so
> an extra space would be required here. I don't feel strongly about it,
> though, so no need to resend just for this.
>
> Acked-by: Thierry Reding <treding@nvidia.com>

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>

Applied to u-boot-tegra/staging, thank you!
