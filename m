Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A529C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 22:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C269487833;
	Wed, 20 Dec 2023 23:58:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="HG43Eooy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B741874D5; Wed, 20 Dec 2023 23:58:02 +0100 (CET)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 715CD86F1E
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 23:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4b6d12cafbfso60976e0c.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 14:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1703113079; x=1703717879;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZP4EQZkcUWa+PrKuBAo18j/pDDl6KqDQsZemHXUzNQ=;
 b=HG43EooywGM40jIVnxmWopRSZp4oP7FhoZkPPFmSZob3FQDUEtBferMPs35lbPoqGL
 W8ESvtJc5CY+Lj9FzojtSlf2AESkTcg9r5K8U9Z3NjX+pVYCRB8kB+1Cvr4KVfUnqZPo
 mHf3by6TYNpEyviiQcw1lDYhwHDzDsw8zm1H6zdVCGb5l6gn2ba9weZjWwKw9rSV8wx2
 96nfJOR2udim8GaizYtuBAbOSevNKsVDD0xgPgegZAFnB9A1QZiv5ZBz5MhnV3ESPKjj
 wcdbz9JrFL6l6LynbGAib+IfCwx1OV5V+i4yl3FDn/i7aFHsQ+Bj2X66s7SBwrOyY+pf
 esAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703113079; x=1703717879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZP4EQZkcUWa+PrKuBAo18j/pDDl6KqDQsZemHXUzNQ=;
 b=au/rlr+lsjAMGlNmOi7z6NHG7hq3+mNJGbKUlOaeIMdYRciFboNlz1MP+LJq4uOJMa
 3wrRnx++/9SGF+iIRPfuK0WJ77lUZpmX7qYndNvWXAG9/LABoeY39lhGr6aPBVfW+A6Z
 IrWAmp+Iv2VB5H+ZcMmK5X4zL+RUt5c6rauAchDJyHSac3rdF5H/MvdDK+vO2bQbKQ4u
 kM+tWi0MMDo1D1oasrk2PXlQpwmeoOjogWgGBORgUi6070Rd4WIleR2/ArySwXzBX7br
 u9TM27WgneBz1/cgBCFRD8RQX0MafcOemRmzy+XdPr97V7FqXjoK68KshJ/F2LqpbAgS
 Ocvw==
X-Gm-Message-State: AOJu0Ywe7qN2V0nLAD+MyhOVJiSuYQ2RZUhYKCJBw/SRJQXT4jqGDupa
 aeCue9+yOk7JYCpKFy+msaaki7bUAwzoaxZoKa9S8w==
X-Google-Smtp-Source: AGHT+IGEfD0Ff6zqnXh9lsCFX2tBpj+lkHKtA7Jfk4I1hIfgsTBesCT+ZY/+PCsfvMMMtK1SxdW271qoVGNR5y4+/W4=
X-Received: by 2002:a05:6122:4d12:b0:4b6:f1e0:956 with SMTP id
 fi18-20020a0561224d1200b004b6f1e00956mr294266vkb.17.1703113079178; Wed, 20
 Dec 2023 14:57:59 -0800 (PST)
MIME-Version: 1.0
References: <B06FB6F5-416C-440D-BC72-070673DF3177@gmx.de>
 <20231219101124.2847425-1-mwalle@kernel.org>
 <87plz2nzr1.fsf@bloch.sibelius.xs4all.nl>
 <f2eb636cd895aae348d4357537267fd2@kernel.org>
 <CAC_iWj+gPVEm3obJZ2rxr8wd7DD5P9bdadeqW22QmwL0=B825g@mail.gmail.com>
 <CALeDE9NZyAF5iFrbfA2BtWxWdB__cijaME7ppyaPk5Cf7Fd-ZQ@mail.gmail.com>
In-Reply-To: <CALeDE9NZyAF5iFrbfA2BtWxWdB__cijaME7ppyaPk5Cf7Fd-ZQ@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Wed, 20 Dec 2023 22:57:48 +0000
Message-ID: <CABEcMwVvu7e9sr8oZKJN+s3DH4wz_+LFx9cADAFZQj4eG+7skw@mail.gmail.com>
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michael Walle <mwalle@kernel.org>, 
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

Hi Illias,

On Wed, Dec 20, 2023 at 3:43=E2=80=AFPM Peter Robinson <pbrobinson@gmail.co=
m> wrote:
>
> On Wed, Dec 20, 2023 at 6:37=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Michael
> >
> > On Tue, 19 Dec 2023 at 14:47, Michael Walle <mwalle@kernel.org> wrote:
> > >
> > > Hi Mark,
> > >
> > > >> > Any runtime device drivers for variable storage should not be in=
 the
> > > >> > U-Boot runtime but live in the secure world (e.g. OP-TEE) FF-A i=
s the
> > > >> > new ARM protocol for talking to the secure world and hence fits =
into
> > > >> > the picture.
> > > >>
> > > >> What if I just want a simple embedded boot stack where I don't
> > > >> want any secure world and just want to be able to boot a COTS linu=
x
> > > >> distribution via EFI?
> > > >
> > > > That already works for many Linux distros.  As long as the distro
> > > > installs the appropriate BOOTxxx.EFI file you don't actually need t=
o
> > > > set any EFI variables for the OS to boot.  It can't get any simpler
> > > > than that.  Of the main Linux distros it seems that only Debian
> > > > doesn't do this.  Someone should probably lobby Debian to do this a=
s
> > > > well as it would mean that Debian would just work on an EBBR compli=
ant
> > > > system.
> > >
> > > I know. Last time I checked CentOS (or was it Ubuntu?) tried to
> > > set EFI variables and the installer just failed. Might be fixed now,
> > > though.
> >
> > It's not. The error message is less scary in distros nowadays, but
> > setting the variable for Boot0000 is still not working. That being
> > said I have a plan to fix it for variables stored in a file, that's
> > why we standardized the efi variable format in EBBR.

Does this mean supporting SetVariableRT for files ?
If yes, would it work without the driver model in runtime?

Kind regards,
Shantur
