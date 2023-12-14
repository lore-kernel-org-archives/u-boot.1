Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5F3C4167B
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 14:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD0B487980;
	Thu, 14 Dec 2023 15:14:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="JcSpEpmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 220AD87A42; Thu, 14 Dec 2023 15:14:36 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFD568796E
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 15:14:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-20316647099so1627393fac.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 06:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1702563272; x=1703168072;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=28e7S0xfYIfVd2NmiktRn6IUySZTQEoiafvIq6EQgjg=;
 b=JcSpEpmEMpCGH2E1IHsl/Qv11zYXYTap5754bI5geT3//Q5XXbz3kgvELzgKqENroc
 7uFYxAylG7oZb6C5jgITkSjQXPtUjFR6oTCAQsAeSEsrN+vAEPy6nlajWtt3l5weusO+
 COSr1+siNe/h3z2vJG0iY7PqQ3ZR/nRbYEb+0N2UIO+5uelLCNLb4FBxboSAlcrH5JCL
 xmEEYHJJvB5Eo2E5EiBDEnHV12VdxRbnZ35pHzYNO5EicaUYGNC0oNhs3phBToP9mCmb
 590ZsLRg7dlM1cqhOlkRhHr14Lfvn+luoYBhwE7mgvXZsmVAcWUQ1FpYxXB2g9Pjurbm
 reWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702563272; x=1703168072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=28e7S0xfYIfVd2NmiktRn6IUySZTQEoiafvIq6EQgjg=;
 b=xLRNmoSzMZIUo4B+x0NJHboRqx9fYxG7988bpv3owWdJE11679yqVVNnXjNnPTY0Fz
 OhulCjNhGjEGdJJKQhfWwZgaBUr0RQLM6IpqqOnfFOXjSpp0g5SILuo9JUV9IXdpMDII
 tjC+Uf8zTUm+EXJQvHKzOssLpYS1FQv72MdrA0rddhQm40oNQRCElOMR3WzK6NMd8ebE
 4VSgJaMq3XBtPSOHTg8ksQxqIsBbvYCnTc7hQOjIDgd1ULR7c/gBVbxgd6xf3IGlwKcP
 ZLYTIyZrCEzsnpMnZgfr46yudva6ztuGycea3rWyWA46YncNhB5+PkH+X04vM4mScp3p
 B3Iw==
X-Gm-Message-State: AOJu0YymRC5VVtQlv+f82LiznLe9njGKzN9N97v7+EVoboxlAKQUOLUH
 igGroBkg0P5SryDEtr7j5D/C0FG18E9k4MVhKvx3qQ==
X-Google-Smtp-Source: AGHT+IFB6TNX3lySGQrI8Kd8MxyFYtQtvSe/ulQL7DIEFglGzDggDR6/A/5dcbjsHwWLPKaDPaKWW9WsBWXunXBFu30=
X-Received: by 2002:a05:6870:1ec3:b0:203:5906:87c1 with SMTP id
 pc3-20020a0568701ec300b00203590687c1mr352005oab.109.1702563272426; Thu, 14
 Dec 2023 06:14:32 -0800 (PST)
MIME-Version: 1.0
References: <cfad9ff8b9263104cc48aaabe4e1eddb@manjaro.org>
 <20231113112309.730323-1-i@shantur.com>
 <CABEcMwUwDypY090MOYSEtBGMRZOBnTk6hKuM2-OcJW-n+M7OHg@mail.gmail.com>
 <20231211205326.GX2513409@bill-the-cat>
 <CAPnjgZ23x6dAwq8UDvTXBikRgC3mbTfH5PV=KVF45pFPXY3cQA@mail.gmail.com>
 <20231213202951.GH2513409@bill-the-cat>
 <CAPnjgZ2=P-kmGFEO0k_fp=XVps0YC16YJ_+yAqk4xVz0CGYz=g@mail.gmail.com>
In-Reply-To: <CAPnjgZ2=P-kmGFEO0k_fp=XVps0YC16YJ_+yAqk4xVz0CGYz=g@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Thu, 14 Dec 2023 14:14:21 +0000
Message-ID: <CABEcMwVbb-6670ESQJKFva_jnSPQMzCrzrscDmwnGvQqhXHMSw@mail.gmail.com>
Subject: Re: [PATCH v4] arm: dts: rockpro64: Add RockPro64 smbios
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, 
 kever.yang@rock-chips.com, jagan@amarulasolutions.com
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

Hi,

On Wed, Dec 13, 2023 at 8:41=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Tom,
>
> On Wed, 13 Dec 2023 at 13:29, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Dec 13, 2023 at 12:50:06PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 11 Dec 2023 at 13:53, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Dec 11, 2023 at 08:42:19PM +0000, Shantur Rathore wrote:
> > > > > Hi,
> > > > >
> > > > > On Mon, Nov 13, 2023 at 11:24=E2=80=AFAM Shantur Rathore <i@shant=
ur.com> wrote:
> > > > > >
> > > > > > Add smbios information for Pine64 RockPro64 board and enable in
> > > > > > config
> > > > > >
> > > > > > Signed-off-by: Shantur Rathore <i@shantur.com>
> > > > > > ---
> > > > > >  Changes
> > > > > >  v4: Change PINE64 to Pine64
> > > > > >  v3: Enable SYSINFO and SYSINFO_SMBIOS in defconfig
> > > > > >
> > > > > >  arch/arm/dts/rk3399-rockpro64-u-boot.dtsi | 22 +++++++++++++++=
+++++++
> > > > > >  configs/rockpro64-rk3399_defconfig        |  2 ++
> > > > > >  2 files changed, 24 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch/a=
rm/dts/rk3399-rockpro64-u-boot.dtsi
> > > > > > index 732727d9b0..089732524a 100644
> > > > > > --- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> > > > > > +++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> > > > > > @@ -9,6 +9,28 @@
> > > > > >         chosen {
> > > > > >                 u-boot,spl-boot-order =3D "same-as-spl", &spi_f=
lash, &sdmmc, &sdhci;
> > > > > >         };
> > > > > > +
> > > > > > +        smbios {
> > > > > > +                compatible =3D "u-boot,sysinfo-smbios";
> > > > > > +                smbios {
> > > > > > +                        system {
> > > > > > +                                manufacturer =3D "Pine64";
> > > > > > +                                product =3D "RockPro64";
> > > > > > +                        };
> > [snip]
> > > > Yes, we should just defer this and pickup the SMBIOS series that Il=
ias
> > > > has posted.
> > >
> > > I don't think it is a suitable substitute, it is just a fallback.
> > >
> > > So I believe this patch should be applied.
> >
> > Please note that this patch is adding _less_ details than the top-level
> > model field contains today for the platform.  The only difference is
> > "Pine64" vs "pine64".
>
> The top-level model is "Pine64 RockPro64 v2.1", I believe. But:
>
> - the first part of that is the manufacturer, not the product
> - the second part is what we have in this patch
> - the third part is the version
>
> SMBIOS tries to split things up into separate fields.
>
> So, perhaps a new version of this patch could add:
>
>    system {
>      version =3D "2.1";
>    };
>

I can add the above or any more details needed to a new patch
Will that be enough to make it merge-able

Kind regards,
Shantur
