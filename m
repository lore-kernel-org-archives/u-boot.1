Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42608C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 20:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F7AB87239;
	Wed, 29 Nov 2023 21:35:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GMdK/Sf9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A178286A26; Wed, 29 Nov 2023 21:22:51 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB90C868AE
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 21:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=phanbagiabao2001@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-54bec1d3854so301146a12.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 12:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701289369; x=1701894169; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/nz0iCtgk4S0Tw2+OnNUsZi84bl+qMg7g3QHKdhYZcY=;
 b=GMdK/Sf9DOdxaFNQuf5s9y0ax4Z2EWUc5SWBLPwh8uqhUgzPVKnzXxFH6MumzESlZf
 spb3evz0Q5z/xQjSiuhGiDFPMpYwrFEC9uG5km/kubGQ9Y0ICEp6RzNhqgjmOq0iQi5i
 Zx6P3paNGzRP89bpx82iR1aQck/DAxNk4fEFpIC/oEt0oQwwDB6R9YcmI13K5Ktp67Iy
 kt2mOC8XnTF+aXrLiuGnMETkQnDXYVJgEuFbRDXT+IiDYTTo7Qi5t7145RSLRhsahQoG
 tEbSHFYDA0w91MRTVFHHPFoqTGJnzqFpOQWEqaaxJAx3XiWKhsSgGfLSPUfFSSzdXBAt
 3Jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701289369; x=1701894169;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/nz0iCtgk4S0Tw2+OnNUsZi84bl+qMg7g3QHKdhYZcY=;
 b=DK3BgO3C3MqKMfiZfrjLUxnxPygoRGwJ8XPVkjf9pkc/I+jXWqajgNlVRETIFxSNad
 2yPFn5t8hIqQ+3/f6ytfbz+edTiKq5T8rSnCCEv6EYl8Kg31mOphPUTKyCXpur/Du+vX
 cZtGrNJjnShs4bV12JzpCqfYbyR8bWbCztc4DhUPRC6iyH9O/Y/ujpIIVoI4eVi5zJ6t
 +bkAATvzRDyPSfVL/5dYoRg8a5Y314Zw3MJ1JqAwg6Qag+CAH6jdzOjuCuEEr3Wz1mkR
 GzwGfLQQAKcNaxvAsHx6QDjS2B5xRn5bsymxlIP73cwNXMqfwa0HPIJHPEuYWTHEIPLc
 Uhdw==
X-Gm-Message-State: AOJu0Yy3kztvzZxYBZtdQRcTBcX08K/DL9Vl21m/vf77Et5nsmT0iW0w
 mnZI6sknFxQ0Lavi4L5s5ITt+PNOqRz1CA69fes=
X-Google-Smtp-Source: AGHT+IGgAG5YzFLvHwEAfbql4AMwJV8Kfy8BW902Z+79INGQCd+vqZOxzzj59ZnFyiL9pKyTPlMD4zFiOJehKuOnZQs=
X-Received: by 2002:aa7:d3d5:0:b0:54a:f72d:38b7 with SMTP id
 o21-20020aa7d3d5000000b0054af72d38b7mr13942192edr.1.1701289368913; Wed, 29
 Nov 2023 12:22:48 -0800 (PST)
MIME-Version: 1.0
References: <CAK9R8u_QmcHLv6KbNm8+8EDvnmgehFZfoPNVCVn8n5P17ArErw@mail.gmail.com>
 <CAPnjgZ2JUCWjr35yL6pb2XSEs7659A1Sjh4CgQ6B=vXCLhRvtA@mail.gmail.com>
 <CAFyOScryXf_J7ya7aFgQPQA6qLKt74EOuADw0LL1CP2nTopypA@mail.gmail.com>
In-Reply-To: <CAFyOScryXf_J7ya7aFgQPQA6qLKt74EOuADw0LL1CP2nTopypA@mail.gmail.com>
From: Ba Gia Bao Phan <phanbagiabao2001@gmail.com>
Date: Wed, 29 Nov 2023 21:22:38 +0100
Message-ID: <CAK9R8u9E9Rgewi=sOmzPFdoARexnUB9dTvYONssrpyAsNdYWDQ@mail.gmail.com>
Subject: Re: Setting up boot chain ACPI on ARM with STM32MPU
To: Moritz Fischer <moritzf@google.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 andy.shevchenko@gmail.com, trini@konsulko.com
X-Mailman-Approved-At: Wed, 29 Nov 2023 21:35:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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
>
> Overall I think it's a worthwhile endeavour to get this sorted for at
> least one ARM platform as a starting point.

So, do you know are there any ARM platforms having ACPI enabled?


Le mer. 29 nov. 2023 =C3=A0 20:45, Moritz Fischer <moritzf@google.com> a =
=C3=A9crit :

> Hi,
>
> On Wed, Nov 29, 2023 at 11:28=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > +Heinrich Schuchardt
> >
> > Hi,
> >
> > On Wed, 29 Nov 2023 at 08:29, Ba Gia Bao Phan
> > <phanbagiabao2001@gmail.com> wrote:
> > >
> > > Hello everyone,
> > >
> > > I am a trainee at STMicroelectronics France. I am working on a projec=
t
> "Setting up a boot chain ACPI" for STM32MPU, which is based on ARM Cortex=
-A
> . The objective of my project is to add a way of booting (with ACPI)
> besides Device Tree available on STM32MPU.
> > >
> > > I found that ACPI was enabled on some x86 platforms but I don't know
> whether it was set up on ARM or not. I found a PATCH that discussed
> Enabling ACPI booting on ARM with Raspberry Pi 4 but I don't know if it
> functioned or not. Did anyone here succeed in setting up ACPI on ARM by
> U-boot?
> >
> > Sort-of...the refactoring to allow ACPI tables on ARM is completed,
> > but I don't think any U-Boot board uses this.
> >
> > >
> > > What are the differences between x86 and ARM platforms when enabling
> ACPI? The architecture of my board STM32PMU is ARM so can I apply the
> technique used on platform x86 for my board?
> >
> > Firstly I wonder why you want ACPI?
>
> I think STM32MPU is as good as any platform to get the pipe flushed
> with enabling ACPI on ARM platforms.
>
> Overall I think it's a worthwhile endeavour to get this sorted for at
> least one ARM platform as a starting point.
>
> > Secondly, if you have the tables somewhere it should be easy enough to
> > build them, building on the series you pointed to. Heinrich is
> > interested in this, I think. I can help with advice. I have been
> > toying with going back to that rpi series but have not done so yet.
>
> I've started to mess around with this over the holidays. Feel free to
> CC me on future work in that direction.
>
> - Moritz
>


--=20
PHAN Ba Gia Bao
Etudiant en 5A STI - INSA Centre Val de Loire
