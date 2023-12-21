Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930F1C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 06:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85E2C876DE;
	Thu, 21 Dec 2023 07:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rBn7Vy7P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7715D8763E; Thu, 21 Dec 2023 07:30:13 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3648C875A0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 07:30:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50c0f13ea11so557760e87.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 22:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703140210; x=1703745010; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FkQhaEyCFaTxrVNARIGkcVeh0YpJHUPFaojNcdZDUAA=;
 b=rBn7Vy7PUbEMbR2NYTI6eTpNhnNDj3+etAPm9xwKIHul8VTkmNizrnwwPRC+7xJf4J
 AYE1MS5xrOoB733OYT1msyB/TYdQAAbfcumNr53fm30bj1Z51KfJ4FGlOCDDezcbv4l/
 TXje5YyJ27SzPIEggZi145OPNjSvTLRUkFFWS0VsWF4wcI5LPWG5soCzeHVJnLuHGEfr
 FYjzuGZgkpAbsZXHUWkoVxRO0BEL7yCXjjNAFCgED6cKixMA92euQEBvy/UzGon0uqUG
 VT90/pF5FRyxkQ2BT5Anuz18aRMESlV0roBHfMEknkJKKoaCsH/ssX/6O/4YYrJHP6c5
 92Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703140210; x=1703745010;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FkQhaEyCFaTxrVNARIGkcVeh0YpJHUPFaojNcdZDUAA=;
 b=LDGxCvG4UcEEXiMsC6U5mqLypOE19RKUO3fSDFE8FgQ6sO4iBLdZkAITBa6/mdz47+
 SjCvUycYidEN44pKITLI3M5YItz18AyBBx+VIWybG43GSRhwS00CL/CShVJ3pysmG3Ek
 11xcVFpwMpUFRbyaqMluSJqR6mmE655KKDrJLJAmtqmOWKVreSQY8G3e0V7gmDH6/BUo
 xM497EdHB1gqeJyIZBGpz/unluNXvktQxcFsbYSz2YzdDTuRTITyyg0HPphHda+7z7cS
 N4yqjaZNF/ppFK/WnS1cX+ytOdwxYca9T4csOAY3TjZhV6T1Uv3JMulQwzhIXl4Y6JIE
 iREA==
X-Gm-Message-State: AOJu0YzRNvhijKYMpiOzyYqUFmlcpJU9KlZDnZyc+eAkPY0WLAiqwOuQ
 pSMWJcqs4/WqBXyIDkhaJAJ05C85VH96VHORE9rF9g==
X-Google-Smtp-Source: AGHT+IGC8qQHTeQzW60XvoOHpl+5fl1uF+gGDGIqiaeVnuiRIdm2H/y6BVmiWAVFuOS1TWV1kOaeqZtqg2hZVt8B2ts=
X-Received: by 2002:a05:6512:12c4:b0:50e:3f07:771b with SMTP id
 p4-20020a05651212c400b0050e3f07771bmr3154185lfg.129.1703140210303; Wed, 20
 Dec 2023 22:30:10 -0800 (PST)
MIME-Version: 1.0
References: <B06FB6F5-416C-440D-BC72-070673DF3177@gmx.de>
 <20231219101124.2847425-1-mwalle@kernel.org>
 <87plz2nzr1.fsf@bloch.sibelius.xs4all.nl>
 <f2eb636cd895aae348d4357537267fd2@kernel.org>
 <CAC_iWj+gPVEm3obJZ2rxr8wd7DD5P9bdadeqW22QmwL0=B825g@mail.gmail.com>
 <CALeDE9NZyAF5iFrbfA2BtWxWdB__cijaME7ppyaPk5Cf7Fd-ZQ@mail.gmail.com>
 <CABEcMwVvu7e9sr8oZKJN+s3DH4wz_+LFx9cADAFZQj4eG+7skw@mail.gmail.com>
In-Reply-To: <CABEcMwVvu7e9sr8oZKJN+s3DH4wz_+LFx9cADAFZQj4eG+7skw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 21 Dec 2023 08:29:34 +0200
Message-ID: <CAC_iWjJOi3DmxVYx2X2aXtsFpvHDFOqskCYZu3s1U04ak5u7XQ@mail.gmail.com>
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
To: Shantur Rathore <i@shantur.com>
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

Hi Shantur

On Thu, 21 Dec 2023 at 00:57, Shantur Rathore <i@shantur.com> wrote:
>
> Hi Illias,
>
> On Wed, Dec 20, 2023 at 3:43=E2=80=AFPM Peter Robinson <pbrobinson@gmail.=
com> wrote:
> >
> > On Wed, Dec 20, 2023 at 6:37=E2=80=AFAM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Michael
> > >
> > > On Tue, 19 Dec 2023 at 14:47, Michael Walle <mwalle@kernel.org> wrote=
:
> > > >
> > > > Hi Mark,
> > > >
> > > > >> > Any runtime device drivers for variable storage should not be =
in the
> > > > >> > U-Boot runtime but live in the secure world (e.g. OP-TEE) FF-A=
 is the
> > > > >> > new ARM protocol for talking to the secure world and hence fit=
s into
> > > > >> > the picture.
> > > > >>
> > > > >> What if I just want a simple embedded boot stack where I don't
> > > > >> want any secure world and just want to be able to boot a COTS li=
nux
> > > > >> distribution via EFI?
> > > > >
> > > > > That already works for many Linux distros.  As long as the distro
> > > > > installs the appropriate BOOTxxx.EFI file you don't actually need=
 to
> > > > > set any EFI variables for the OS to boot.  It can't get any simpl=
er
> > > > > than that.  Of the main Linux distros it seems that only Debian
> > > > > doesn't do this.  Someone should probably lobby Debian to do this=
 as
> > > > > well as it would mean that Debian would just work on an EBBR comp=
liant
> > > > > system.
> > > >
> > > > I know. Last time I checked CentOS (or was it Ubuntu?) tried to
> > > > set EFI variables and the installer just failed. Might be fixed now=
,
> > > > though.
> > >
> > > It's not. The error message is less scary in distros nowadays, but
> > > setting the variable for Boot0000 is still not working. That being
> > > said I have a plan to fix it for variables stored in a file, that's
> > > why we standardized the efi variable format in EBBR.
>
> Does this mean supporting SetVariableRT for files ?
> If yes, would it work without the driver model in runtime?

Yes.

The reasoning here is pretty simple. You can't keep alive drivers etc
for devices that the *kernel* eventually owns. The proposal is to
ignore the EFI spec and teach the kernel to write those directly. We
already do that when the variables are stored in an RPMB, we need to
figure out a decent scalable architecture for the rest.

/Ilias
>
> Kind regards,
> Shantur
