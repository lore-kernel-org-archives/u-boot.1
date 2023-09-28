Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD50E80A8A
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 00:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C84A86D67;
	Thu, 28 Sep 2023 02:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SRyogUft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B5BF868D9; Thu, 28 Sep 2023 02:49:38 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12807868BB
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 02:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50433d8385cso19352552e87.0
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 17:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695862175; x=1696466975; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgZ+D3QHehtCpgM6L1k4rMXdLVAfsBCeX11Z0wElHDQ=;
 b=SRyogUfteubRWDHd4mPKrW2aqeh0+mCK1b29smlfh8r9igkzxZs7uBpem9EJuQF0O2
 qGpEdMt7rmNOBmPIHgnvWIYra4bW8Q8MG6Nu2dLbjFUERhD9UhU1YkJpXV4zWOCtUgPA
 /t19mFFud0dc9j5iHI2TVClYYLRokh4qxbaiSk4xvdubSQI/ZqKok9RhsRN9G5Dc3lnc
 4wftdYgx0tUirVVlAYEd84VKrZY1xITQzBRsmrt4tyQXdXJIXYOw0xu8u1ff61jRgHqf
 NpBvt9Gi98zHpbsWwyjKurR0P1YO14+fTuyysfB3ODSPWcjZEhhEu847E3/7H/pPwbPe
 hjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695862175; x=1696466975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dgZ+D3QHehtCpgM6L1k4rMXdLVAfsBCeX11Z0wElHDQ=;
 b=lNwCLzlLViuSdZEcxdipFrePBPBw2RDdHRbM7gJSQ2W42wmVuUBhRnVTmq+QrR2HvE
 s9yML2IMgKjj4WC7zRifdmF9KvpGYIwV/fha3/pNO76g74rT0doeiHe6kYSproYDYklE
 +DYtEgOCg3DL3/BNE2GS/HiADHNNKYMTNw5cYSeRGjKbJ2EQXBNL8yIGaOWkfINczSGX
 /+4BaN4b0Rt5BE2nGxRV1eKim8R9DntGWkfY7GStxm8pZP0NZzVUvdT6RAuzi5VuFVwI
 ufePBOjVwMTCeRd3FpFrsmHsv3TZeZ/7ELwCjAN8a7XsfTGZE3KR66bS3EKEsu2oVJUk
 BSaw==
X-Gm-Message-State: AOJu0YwpIXmQt+iGH5A4wzdXvTBfnBPtNRVr7sCdjrNQXgAv2QkljYmm
 pmhUejd12V+bpMhpxSLrb2qIJe/AS0YXnZc8oXk=
X-Google-Smtp-Source: AGHT+IFQotaJq1jt/exQj8aGTOuPyxe9F/yFFRCuCnD38OsuPVolUdU63SInePIOxLq9GsW7Zm85AREpT9XheK3xQfQ=
X-Received: by 2002:a05:6512:324d:b0:4ff:8f71:9713 with SMTP id
 c13-20020a056512324d00b004ff8f719713mr2659644lfr.42.1695862174857; Wed, 27
 Sep 2023 17:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230926085651.395069-1-JJLIU0@nuvoton.com>
 <20230926085651.395069-4-JJLIU0@nuvoton.com>
 <20230926134807.GT305624@bill-the-cat>
In-Reply-To: <20230926134807.GT305624@bill-the-cat>
From: Jim Liu <jim.t90615@gmail.com>
Date: Thu, 28 Sep 2023 08:49:23 +0800
Message-ID: <CAKUZ0+FRnrEuyGpNMeqD_Tbi8VXTgtV=8A1ZoQPU=ZaMJRT3TQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] arm: npcm8xx: support dcache off
To: Tom Rini <trini@konsulko.com>
Cc: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, u-boot@lists.denx.de
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

Hi Tom

Thanks for the quick review.

if we set the CONFIG_SYS_DCACHE_OFF the  armv8 will build error.
So we added a workaround for our bmc uboot.

the error message as below:

CONFIG_SYS_DCACHE_OFF can't be enabled on armv8, or the following
build error would happen.

arch/arm/cpu/armv8/cpu.o: in function `cleanup_before_linux':
arch/arm/cpu/armv8/cpu.c:60: undefined reference to `icache_disable'
arch/arm/cpu/armv8/cpu.c:68: undefined reference to `dcache_disable'
arch/arm/cpu/armv8/cpu.c:69: undefined reference to `invalidate_dcache_all'

Best regards,
Jim

On Tue, Sep 26, 2023 at 9:48=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, Sep 26, 2023 at 04:56:50PM +0800, Jim Liu wrote:
>
> > do not enable dcache by setting CONFIG_SYS_NPCM_DCACHE_OFF=3Dy
> >
> > Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> > ---
> >  arch/arm/mach-npcm/npcm8xx/Kconfig |  4 ++++
> >  arch/arm/mach-npcm/npcm8xx/cpu.c   | 12 +++++++++++-
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-npcm/npcm8xx/Kconfig b/arch/arm/mach-npcm/np=
cm8xx/Kconfig
> > index 5f4a0506dc..163e7e7d48 100644
> > --- a/arch/arm/mach-npcm/npcm8xx/Kconfig
> > +++ b/arch/arm/mach-npcm/npcm8xx/Kconfig
> > @@ -6,6 +6,10 @@ config SYS_CPU
> >  config SYS_SOC
> >       default "npcm8xx"
> >
> > +config SYS_NPCM_DCACHE_OFF
> > +     bool "Do not enable dcache"
> > +     default n
> > +
> >  config TARGET_ARBEL_EVB
> >       bool "Arbel Evaluation Board"
> >       help
>
> Why do we need a new Kconfig option here on top of the existing generic
> ones to control cache?
>
> --
> Tom
