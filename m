Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C901DC25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2157287649;
	Thu, 26 Oct 2023 20:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="skqdXJHW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 991848712F; Thu, 26 Oct 2023 20:56:21 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D2A286F45
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c523ac38fbso19156631fa.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698346578; x=1698951378; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3S6eVwS7JMnozSWrD2Ad8DK4nAb2JRVNg6Z2zj1vwQ=;
 b=skqdXJHWKEtUCjuomtOGjId+YAPxV4u1HrLliheud7ALn7gtBfDacdLmJbiOrm6Jq6
 VeQxzhywxma2fhwH0XRhjr8g2ybBmhgslzwEa9psdgq2n7NpjuKrT69qX8HQWvNi8EEf
 AbZbGIqAXFVt3HpRa0zQkawWnyEDBvGABfK87VrBa22aPvIUWEapgOSmT+5zRmnq47Aq
 25v5bTTVoHvnJgjmfhMWI/AU2LlXKzUfZQnYol6fjzwRgqJcDDkFxMSiJ6ls1jPTkii8
 /q1afJDqeL9Hq/sDoGGIABULOTsP0DNLe6bxdKGxE3Nxp5st3Vyd8fbs6ifTJVpv8BXT
 huhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698346578; x=1698951378;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F3S6eVwS7JMnozSWrD2Ad8DK4nAb2JRVNg6Z2zj1vwQ=;
 b=gq8FVnBzUzwuzd7bt/BmUCEqFiTauI+GlGvI6KrAgDjkArhR2+e2HqfP4U+ycUwLyv
 BZg8T//YPmjkARIDzz/qbJKMhwN+nUaeHUJWHpWkddBdVk/ALH/ulqOQxpRiu51v9HUx
 CPC8V3YBeEUh2VRRyPqoLxDvlnwgvZLt3t4QqTbuBnxFvrHfyGTJcjuiA96cBXV+f23z
 4Mx6QtDBssOtJoCJsEvVAlXGmFZKxRJWm2fV18py7jUjJHZyE53GUSJgWnTOQ5ec8YsD
 I5C6NHYkdv37UpQruyrucMeeoGREfKVOxZQGZue3Fl8kRLtIj2PojbqOtnUAMjW4UoSX
 UM1w==
X-Gm-Message-State: AOJu0YyGucVk/giEYXmSk9ce22eShM6W0LRPl+GxE8DI5Re8CxvKjOYV
 WXlzi2VNG/Cf0iFKmBUefsiWQVW1FhynGJX/FJkU0A==
X-Google-Smtp-Source: AGHT+IEnbLkWNxEEGvPzh6/NiudL/Sj0SYedEpRn7QUF46GF+CPSjl5TcKAIvMtCVv7O2KmZ56kVdJy4QEIaMasNhSc=
X-Received: by 2002:a05:6512:3da3:b0:507:a671:3231 with SMTP id
 k35-20020a0565123da300b00507a6713231mr227353lfv.52.1698346578270; Thu, 26 Oct
 2023 11:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <OS3P286MB14955A84C3B71A32C4BBA352F6DFA@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
 <CAPnjgZ1A8vyEUx2wiXqOCb8Kf9zP96wqy4kXanfKRR-uN6yOmg@mail.gmail.com>
 <OS3P286MB1495889DF57AD742064FDB56F6DEA@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
 <CAPnjgZ0Bb7zzVabU05hfg12tcrQbzT1iWQVdrui2GmsEZekZDA@mail.gmail.com>
 <TYYP286MB15006711E2339FD6BB432045F6DDA@TYYP286MB1500.JPNP286.PROD.OUTLOOK.COM>
 <CAPnjgZ0nrq5y-1eAfcaTCmPJ+xq49xS9DGUSjd5fn8rSFekO2g@mail.gmail.com>
In-Reply-To: <CAPnjgZ0nrq5y-1eAfcaTCmPJ+xq49xS9DGUSjd5fn8rSFekO2g@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Oct 2023 21:55:42 +0300
Message-ID: <CAC_iWjJTcgzmGQVBLM1H9fG_Y=tSE6nTg_=H8G3GGuSyq1j+EA@mail.gmail.com>
Subject: Re: quick question about TPM
To: Simon Glass <sjg@google.com>
Cc: "niek.nooijens@omron.com" <niek.nooijens@omron.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi all

On Thu, 26 Oct 2023 at 20:44, Simon Glass <sjg@google.com> wrote:
>
> +Ilias Apalodimas as well
>
> On Thu, 26 Oct 2023 at 02:22, niek.nooijens@omron.com
> <niek.nooijens@omron.com> wrote:
> >
> > Hi Simon
> >
> > Yes that fixes it! Thanks!
> > Maybe an Idea to add a dedicated TPM page to the docs with information =
like this?
> > (https://u-boot.readthedocs.io/en/latest/index.html) Cause I wouldn't h=
ave thought I needed an option tugged away under Library routines.
>
> Thank you for the feedback. I added Ilias to take a look.

Thanks Simon.
Yea, adding a bit of documentation seems reasonable. I'll see what I can do=
.

Thanks
/Ilias
>
>
> - Simon
>
> >
> > Anyhow Thanks!
> > Niek
> >
> >
> >
> > ________________________________
> > =E5=B7=AE=E5=87=BA=E4=BA=BA: Simon Glass <sjg@google.com>
> > =E9=80=81=E4=BF=A1=E6=97=A5=E6=99=82: 2023=E5=B9=B410=E6=9C=8826=E6=97=
=A5 03:23
> > =E5=AE=9B=E5=85=88: Niek Nooijens / OC-IAB PBD-C DEVEL 1-1 <niek.nooije=
ns@omron.com>
> > CC: u-boot@lists.denx.de <u-boot@lists.denx.de>
> > =E4=BB=B6=E5=90=8D: Re: quick question about TPM
> >
> > Hi Niek,
> >
> > On Tue, 24 Oct 2023 at 19:26, niek.nooijens@omron.com
> > <niek.nooijens@omron.com> wrote:
> > >
> > > Hi Simon
> > >
> > > Driver model is enabled, so it's pretty weird it doesn't show up.
> > > CONFIG_DM=3Dy
> > > CONFIG_SPL_DM=3Dy
> > > CONFIG_DM_WARN=3Dy
> > >
> > > The TPM menu is there, yet somehow empty.
> > > This is just after "make socfpga_cyclone5_defconfig" and "make menuco=
nfig"
> >
> > Do you enable CONFIG_TPM here?:
> >
> > Library routines -> Security support -> Trusted Platform Module (TPM) S=
upport
> >
> > then the drivers appear for me (under device drivers)
> >
> > > if I use "make snow_defconfig" the menu is usable like normal, so som=
ething is disabling it, yet when grep-ping for TPM in socfpga there are no =
results.
> > > Adding it to .config manually also doesn't seem to work. so I'm a bit=
 confused about what's going on. Anyhow thanks for the help!
> >
> > You can edit the defconfig to add CONFIG_TPM and whatever driver you ne=
ed.
> >
> > Regards,
> > Simon
> >
> >
> > >
> > > Niek
> > > ________________________________
> > > =E5=B7=AE=E5=87=BA=E4=BA=BA: Simon Glass <sjg@google.com>
> > > =E9=80=81=E4=BF=A1=E6=97=A5=E6=99=82: 2023=E5=B9=B410=E6=9C=8825=E6=
=97=A5 03:03
> > > =E5=AE=9B=E5=85=88: Niek Nooijens / OC-IAB PBD-C DEVEL 1-1 <niek.nooi=
jens@omron.com>
> > > CC: u-boot@lists.denx.de <u-boot@lists.denx.de>
> > > =E4=BB=B6=E5=90=8D: Re: quick question about TPM
> > >
> > > Hi Niek,
> > >
> > > On Tue, 24 Oct 2023 at 04:51, niek.nooijens@omron.com
> > > <niek.nooijens@omron.com> wrote:
> > > >
> > > > Hi
> > > >
> > > > Just a quick question. I'm developing a platform using the socfpga_=
cyclone5_defconfig
> > > > everything is working, linux boots, but we decided to add a TPM to =
it's SPI bus.
> > > > For some reason the TPM support menu in the menuconfig is disabled =
and I can't seem to find out why, or which file disables it. can you point =
me in the right direction?
> > >
> > > The only thing 'config TPM' depends on is DM (driver model). Is that
> > > somehow disabled? Once you enable that, it should appear.
> > >
> > > Regards,
> > > Simon
