Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C980C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 14:36:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ADC3877E5;
	Thu, 21 Dec 2023 15:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="T4xC1JbR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C943E876C6; Thu, 21 Dec 2023 15:36:46 +0100 (CET)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 583FF8785E
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 15:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4669ac6df36so224072137.2
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 06:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1703169403; x=1703774203;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FQG9AEZlS3YYuVfBUWKIq+NOirDegPC/Qv09a0OItI=;
 b=T4xC1JbRGmiuX4ZAWFwJh82BVPkyVv9Qlcr683CeDc0bBepgVCxlLum+y6XlmuUrgY
 Z7FSCCYTmpAN2zRBldTuDNbVc5+VBga6nLyaf1mQLIqO8umwnYK8TWwoNH5GjzoJcv4X
 2PeU+q1NCI0l+MuSyv/PtTXlFnzdBsbcjXWl3WbbzhqC3e9ByxdsHpq/TTFqf5h3rRfE
 cZdOsxeddURiGC9JH9O79K7JzFur5Ot0jnLGf2XHZva4WwKZpx6OvTA54K0Tfn8wL4zG
 Y+A3pjvKMInfYtOtSgLGc11zkbYIahDbidjR9KDKQ2d1jcrb3jTp0o17/UBMPdZKohVI
 VQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703169403; x=1703774203;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+FQG9AEZlS3YYuVfBUWKIq+NOirDegPC/Qv09a0OItI=;
 b=mj8/BI2tadkvf00KRvL4QZDgpmE6qhv6zvFORIJabsPKKT6XbEfPD5FefjvHiMcsYo
 FgxTrJC7SS8+LvtmDGV2SKRko5P19hVoXXEq5KpDryOrtS6mHVpap35jdmBA1Gy1JFQ+
 boqgOXyLfDn5gVFqCCuaKmB8vBm6IlRt2s8tPS00FkhDpqS6fZSMLqwnCq1r1hZioCJ4
 94+U+7BsuF7zTYf0Qp3jUVwTPDBi5wVt3KEWUhxQp1R/XOM3VOENmkbup9YDYZeloYfc
 L2vsXyoCUZUFQNXBZLXreE5VmDI/HYqwMjwxwPuviNFFR48EWmiw4bVjwO6VTm/pXphF
 ky1w==
X-Gm-Message-State: AOJu0YzsRhf8RCfdIvRbFjzrBppN3eexbSy73VuuECHZNtkpO006nOeu
 wIzPSl0yzz9X45/klyaIJiWw4N7fmlJpDHZ1YVZOmw==
X-Google-Smtp-Source: AGHT+IEG//SCgyCVukMA6nOJxhlEKx0fEZ13AdSHoTWEg9wy9wywf+W2YsK3ghpI+A85qFvpoHRn1yfLdr7jwYkaDeA=
X-Received: by 2002:a05:6122:3694:b0:4b6:e467:4ea1 with SMTP id
 ec20-20020a056122369400b004b6e4674ea1mr821818vkb.13.1703169402988; Thu, 21
 Dec 2023 06:36:42 -0800 (PST)
MIME-Version: 1.0
References: <B06FB6F5-416C-440D-BC72-070673DF3177@gmx.de>
 <20231219101124.2847425-1-mwalle@kernel.org>
 <87plz2nzr1.fsf@bloch.sibelius.xs4all.nl>
 <f2eb636cd895aae348d4357537267fd2@kernel.org>
 <CAC_iWj+gPVEm3obJZ2rxr8wd7DD5P9bdadeqW22QmwL0=B825g@mail.gmail.com>
 <CALeDE9NZyAF5iFrbfA2BtWxWdB__cijaME7ppyaPk5Cf7Fd-ZQ@mail.gmail.com>
 <CABEcMwVvu7e9sr8oZKJN+s3DH4wz_+LFx9cADAFZQj4eG+7skw@mail.gmail.com>
 <CAC_iWjJOi3DmxVYx2X2aXtsFpvHDFOqskCYZu3s1U04ak5u7XQ@mail.gmail.com>
In-Reply-To: <CAC_iWjJOi3DmxVYx2X2aXtsFpvHDFOqskCYZu3s1U04ak5u7XQ@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Thu, 21 Dec 2023 14:36:31 +0000
Message-ID: <CABEcMwU==WKegXX0kKiVecAEmQQ=752Qiw8kFyF9oUC4w7_GEw@mail.gmail.com>
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, Michael Walle <mwalle@kernel.org>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, xypron.glpk@gmx.de,
 Abdellatif.ElKhlifi@arm.com, 
 Drew.Reed@arm.com, nd@arm.com, sjg@chromium.org, u-boot@lists.denx.de
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

Hi Ilias,

On Thu, Dec 21, 2023 at 6:30=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Shantur
>
> On Thu, 21 Dec 2023 at 00:57, Shantur Rathore <i@shantur.com> wrote:
> >
> > Hi Illias,
> >
> > On Wed, Dec 20, 2023 at 3:43=E2=80=AFPM Peter Robinson <pbrobinson@gmai=
l.com> wrote:
> > >
> > > On Wed, Dec 20, 2023 at 6:37=E2=80=AFAM Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Michael
> > > >
> > > > On Tue, 19 Dec 2023 at 14:47, Michael Walle <mwalle@kernel.org> wro=
te:
> > > > >
> > > > > Hi Mark,
> > > > >
> > > > > >> > Any runtime device drivers for variable storage should not b=
e in the
> > > > > >> > U-Boot runtime but live in the secure world (e.g. OP-TEE) FF=
-A is the
> > > > > >> > new ARM protocol for talking to the secure world and hence f=
its into
> > > > > >> > the picture.
> > > > > >>
> > > > > >> What if I just want a simple embedded boot stack where I don't
> > > > > >> want any secure world and just want to be able to boot a COTS =
linux
> > > > > >> distribution via EFI?
> > > > > >
> > > > > > That already works for many Linux distros.  As long as the dist=
ro
> > > > > > installs the appropriate BOOTxxx.EFI file you don't actually ne=
ed to
> > > > > > set any EFI variables for the OS to boot.  It can't get any sim=
pler
> > > > > > than that.  Of the main Linux distros it seems that only Debian
> > > > > > doesn't do this.  Someone should probably lobby Debian to do th=
is as
> > > > > > well as it would mean that Debian would just work on an EBBR co=
mpliant
> > > > > > system.
> > > > >
> > > > > I know. Last time I checked CentOS (or was it Ubuntu?) tried to
> > > > > set EFI variables and the installer just failed. Might be fixed n=
ow,
> > > > > though.
> > > >
> > > > It's not. The error message is less scary in distros nowadays, but
> > > > setting the variable for Boot0000 is still not working. That being
> > > > said I have a plan to fix it for variables stored in a file, that's
> > > > why we standardized the efi variable format in EBBR.
> >
> > Does this mean supporting SetVariableRT for files ?
> > If yes, would it work without the driver model in runtime?
>
> Yes.
>
> The reasoning here is pretty simple. You can't keep alive drivers etc
> for devices that the *kernel* eventually owns. The proposal is to
> ignore the EFI spec and teach the kernel to write those directly. We
> already do that when the variables are stored in an RPMB, we need to
> figure out a decent scalable architecture for the rest.
>
Thanks for explaining this.
It would be a good idea to provide EFI var storage info like location,
offset, maxsize to linux
and linux can modify vars as required.

Eg.

location=3Despfile://u-boot-efi.vars offset=3D0 maxsize=3D-1
or
location=3Dspi://0 offset=3D0x3D0000 maxsize=3D0xFFFF

Then the linux kernel is able to modify vars correctly.
I think SPI might be simpler to implement vs file as there can be.
many different
ESP partitions on multiple drives or no ESP partition at all.

Kind regards,
Shantur

> /Ilias
> >
> > Kind regards,
> > Shantur
