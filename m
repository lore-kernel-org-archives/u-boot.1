Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E43BC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 19:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17DEE87AFD;
	Thu, 14 Dec 2023 20:47:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kl11YYPK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1725687B1C; Thu, 14 Dec 2023 20:47:54 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A31D87AD4
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 20:47:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2cc2683fdaaso10129851fa.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 11:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702583270; x=1703188070; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cDh+GiOi2VsfIudSjLcoalrI31bXosdNhgkeDA4LIjw=;
 b=kl11YYPKBO8p21+L7mQNPpM9GSpEFmsKte6+FoXA0WVsiLORvKtnQd2jsO2oR91UdR
 lVA02yP/S6whdz+6KeJHdtVKSEVCMb3YZuTjnAqOK/zQGxXeM2KjLChrrxlj056dK7t/
 7DK3DaDKyXtdYtz8p41/86pHqsQ7kxU6bN2WZ5faHOvY/eIc43hcZ6N8Psdnb8ttO+08
 rnDkPPv8BowknqT44GVAYH8q8Mo45P/QIoNuTSNaYEHu/jz9ke5XpbiE0SaZXTspdkzF
 PW4iPyXtoPSduoUBY5ocfPyUaS7zFCrWiNp2sT41ejmG4yPD+P327GtZ0AQ+55vJ/0yE
 c2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702583270; x=1703188070;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cDh+GiOi2VsfIudSjLcoalrI31bXosdNhgkeDA4LIjw=;
 b=dsNSI/V0EQpHbzOVTiu+EuyPyNKh1rABZ7MMMcy0HfqYHR7DywviBxHKDf1/7l3I2r
 Ni3pv3FmhncmHKQfvoODlgdXgawCVVGqDZYLmqYZZArmzMJ6gpWsjbWcZqqgFB7EWviK
 wYi+LS/eCrHjVh0QtYsxM6sqemYUHxYzyJp5D+F6HIpelkZ5k7Ru/DqzhSvp9Tqfp3OD
 FdrywB2xKfMKN8hGKAFpYjM9faxQCJ/gwGwZW15A0JjUX/D5FyP4JnG5KYYIQ9XiG+om
 GOM3WRMnIdgZHqaQaWRxcVN1VUzrHvHFY7fXgnBPC29rlfh/LLQ5GIRWLPQhj869iFoL
 yL4Q==
X-Gm-Message-State: AOJu0YykK0Mx7yuPgIgrUoqcF/QfZyxTEDZPKHtfIFpwsSGdr6LmsASk
 wxqiVhGOOiZp29iCrg1ucP++uoQ5MmjilVVdYnAPKQ==
X-Google-Smtp-Source: AGHT+IFC2sx5BUwVdXv8HyTucCvVLq52Wx+L2yOX4VaiDEbfx2RfcpFW642aHZ5Aw7vux9lfQHrYSssArAEaoDmcnVU=
X-Received: by 2002:a2e:9295:0:b0:2ca:2346:8044 with SMTP id
 d21-20020a2e9295000000b002ca23468044mr5819867ljh.4.1702583269794; Thu, 14 Dec
 2023 11:47:49 -0800 (PST)
MIME-Version: 1.0
References: <20231214155346.GB295924@e130802.arm.com>
 <87ttok689d.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87ttok689d.fsf@bloch.sibelius.xs4all.nl>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 14 Dec 2023 21:47:13 +0200
Message-ID: <CAC_iWjKYa1_GrU3XPKqbnOf6VJxx426qTfD1WcSMkmj982ECSw@mail.gmail.com>
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
To: Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Abdellatif El Khlifi <Abdellatif.ElKhlifi@arm.com>
Cc: xypron.glpk@gmx.de, sjg@chromium.org, Drew.Reed@arm.com, 
 u-boot@lists.denx.de, nd@arm.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Mark, Abdellatif

On Thu, 14 Dec 2023 at 18:47, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > Date: Thu, 14 Dec 2023 15:53:46 +0000
> > From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>
> Hi Abdellatif,
>
> > Hi guys,
> >
> > I'd like to ask for advice regarding adding EFI RT support to the Arm's FF-A bus
> > in U-Boot.
> >
> > The objective is to enable the FF-A messaging APIs in EFI RT to be
> > used for comms with the secure world. This will help getting/setting
> > EFI variables through FF-A.
> >
> > The existing FF-A APIs in U-Boot call the DM APIs (which are not available at RT).
> >
> > Two possible solutions:
> >
> > 1/ having the entire U-Boot in RT space (as Simon stated in this discussion[1])
>
> I don't think this is a terribly good idea.  With this approach orders
> of magnitude more code will be present in kernel address space one the
> OS kernel is running and calling into the EFI runtime.  Including code
> that may access hardware devices that are now under OS control.  It
> will be nigh impossible to audit all that code and make sure that only
> a safe subset of it gets called.  So...

+100
I think we should draw a line here. I mentioned it on another thread,
but I did a shot BoF in Plumbers discussing issues like this,
problems, and potential solutions [0] [1]. Since that talk patches for
the kernel that 'solve' the problem for RPMBs got pulled into
linux-next [2].
The TL;DR of that talk is that if the kernel ends up being in control
of the hardware that stores the EFI variables, we need to find elegant
ways to teach the kernel how to store those directly. The EFI
requirement of an isolated flash is something that mostly came from
the x86 world and is not a reality on the majority of embedded boards.
I also think we should give up on Authenticated EFI variables in that
case. We get zero guarantees unless the medium has similar properties
to an RPMB.
If a vendor cares about proper UEFI secure boot he can implement
proper hardware.

>
> >
> > 2/ Create an RT variant for the FF-A APIs needed.
> >       These RT variant don't call the DM APIs
> >       (e.g: ffa_mm_communicate_runtime, ffa_sync_send_receive_runtime, ...)
> >
> > What do you recommend please ?
>
> ...this is what I would recommend.  Preferably in a way that refactors
> the code such that the low-level functionality is shared between the
> DM and non-DM APIs.

Yes. The only thing you need to keep alive is the machinery to talk to
the secure world. The bus, flash driver etc should all be running
isolated in there. In that case you can implement SetVariableRT as
described the the EFI spec.

[...]

[0] https://www.youtube.com/watch?v=UdQk0SCUAlA
[1] https://lpc.events/event/17/contributions/1653/attachments/1338/2682/Plumbers%20-%20EFI%20setvariable%20problems%20and%20solutions.pdf
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=c44b6be62e8dd4ee0a308c36a70620613e6fc55f


/Ilias
