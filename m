Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF66C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC3BD87E60;
	Mon, 18 Dec 2023 16:02:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GhiYWNPo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D65DE87E0A; Mon, 18 Dec 2023 16:02:46 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D4F587E3A
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5e76948cda7so554067b3.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702911753; x=1703516553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1LZFuybsunCdBYorS01/1fmt+YuOdA2ZcOSqPsl/CLU=;
 b=GhiYWNPolAreUR22FXXDnvF/MCSMwraDQ/af6Y8Im34pWyjteIyveggmKduYCYzzYF
 4spx2ziNRzzsDcIGK8KBKun/EmiKgW4B2DFGN2gdckHFanp4XSymbeyi5BpXjYSe6cw0
 29V8c3dvEtKdswj6As/JLRtcRQQYV9r6ghNk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911753; x=1703516553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1LZFuybsunCdBYorS01/1fmt+YuOdA2ZcOSqPsl/CLU=;
 b=kMoevv6RYt4dBmzBW/hhgfuhvwxQ99Bz4KobIq8ehqEvOEqO8poYccoKqUp110t3u9
 FYgcarjNaolyqsbFs0dh+fKh3Fo7tWcnRUUi/C+I+JfIHt2NBPdBkqfa6JFJBoxg/vYh
 mhkkid0925pqOgtMzawIGSYDBndqwruiHEnENMMwoQQfuZG06eQbHNxd0a5084fGAddU
 zjIfgOsSZaJ8cQmd4osRMnDlBGmP82d38lfXj0FLeP3ChGOGg+9q5QfMJA24FOAqAc03
 PVW3sBzIvzWIjc9rcc6yXs5MCA8ILc+i36LgdyQfdizNhADHfRsy4s+T7yWm8x3MRHFC
 XbWQ==
X-Gm-Message-State: AOJu0YzCJWznu1C1tAgkQfaNBqkxMs8QEkVgFharsO2SOPl36GFkvf3j
 M1IBT5Zv0QAqwa/abhOeyUqkytFP+/Y9EOxX8WGQxw==
X-Google-Smtp-Source: AGHT+IF/6cZPrRqki15hBAQxZq9r6MkyNkcJuBAckkE/5U1gShhqdUsgY1yWmZM46Mp1EkcgX8I6KJ6X2Coh2as2eRM=
X-Received: by 2002:a0d:f546:0:b0:5d8:b575:9681 with SMTP id
 e67-20020a0df546000000b005d8b5759681mr13337666ywf.80.1702911752811; Mon, 18
 Dec 2023 07:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20231214155346.GB295924@e130802.arm.com>
 <87ttok689d.fsf@bloch.sibelius.xs4all.nl>
 <CAC_iWjKYa1_GrU3XPKqbnOf6VJxx426qTfD1WcSMkmj982ECSw@mail.gmail.com>
In-Reply-To: <CAC_iWjKYa1_GrU3XPKqbnOf6VJxx426qTfD1WcSMkmj982ECSw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 18 Dec 2023 08:01:44 -0700
Message-ID: <CAPnjgZ1TsFCzTd2pD3j4SoAhnJWw1qz90DfEzsU6Y-4bSkEf7A@mail.gmail.com>
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Abdellatif El Khlifi <Abdellatif.ElKhlifi@arm.com>, xypron.glpk@gmx.de,
 Drew.Reed@arm.com, u-boot@lists.denx.de, nd@arm.com
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

Hi,

On Thu, 14 Dec 2023 at 12:47, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Mark, Abdellatif
>
> On Thu, 14 Dec 2023 at 18:47, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >
> > > Date: Thu, 14 Dec 2023 15:53:46 +0000
> > > From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> >
> > Hi Abdellatif,
> >
> > > Hi guys,
> > >
> > > I'd like to ask for advice regarding adding EFI RT support to the Arm's FF-A bus
> > > in U-Boot.
> > >
> > > The objective is to enable the FF-A messaging APIs in EFI RT to be
> > > used for comms with the secure world. This will help getting/setting
> > > EFI variables through FF-A.
> > >
> > > The existing FF-A APIs in U-Boot call the DM APIs (which are not available at RT).
> > >
> > > Two possible solutions:
> > >
> > > 1/ having the entire U-Boot in RT space (as Simon stated in this discussion[1])
> >
> > I don't think this is a terribly good idea.  With this approach orders
> > of magnitude more code will be present in kernel address space one the
> > OS kernel is running and calling into the EFI runtime.  Including code
> > that may access hardware devices that are now under OS control.  It
> > will be nigh impossible to audit all that code and make sure that only
> > a safe subset of it gets called.  So...
>
> +100
> I think we should draw a line here. I mentioned it on another thread,
> but I did a shot BoF in Plumbers discussing issues like this,
> problems, and potential solutions [0] [1]. Since that talk patches for
> the kernel that 'solve' the problem for RPMBs got pulled into
> linux-next [2].
> The TL;DR of that talk is that if the kernel ends up being in control
> of the hardware that stores the EFI variables, we need to find elegant
> ways to teach the kernel how to store those directly. The EFI
> requirement of an isolated flash is something that mostly came from
> the x86 world and is not a reality on the majority of embedded boards.
> I also think we should give up on Authenticated EFI variables in that
> case. We get zero guarantees unless the medium has similar properties
> to an RPMB.
> If a vendor cares about proper UEFI secure boot he can implement
> proper hardware.

Just to copy in my thoughts as they are lost at this point:

> We would need to publish a runtime interface with access to the driver
> API. I did ask for this when the EFI runtime support was added, but it
> wasn't done.

> It would be possible to create a new 'runtime' phase of U-Boot (RPL?),
> separate from the others. That will be much easier once we get the XPL
> stuff sorted out., since adding new [hase would be fairly trivial  CPL
> died as another contributor had a series which went in first...then I
> never got back to it.

> So for now having the entire U-Boot in runtime space seems reasonable to me.

> I'll also mention that it would be nice to have s new-style API
> (replacing the old API U-Boot currently has) which uses more of a
> module approach. E.g. we could declare that uclass_first_device() is
> exported and can be called from outside U-Boot.

>
> >
> > >
> > > 2/ Create an RT variant for the FF-A APIs needed.
> > >       These RT variant don't call the DM APIs
> > >       (e.g: ffa_mm_communicate_runtime, ffa_sync_send_receive_runtime, ...)
> > >
> > > What do you recommend please ?
> >
> > ...this is what I would recommend.  Preferably in a way that refactors
> > the code such that the low-level functionality is shared between the
> > DM and non-DM APIs.
>
> Yes. The only thing you need to keep alive is the machinery to talk to
> the secure world. The bus, flash driver etc should all be running
> isolated in there. In that case you can implement SetVariableRT as
> described the the EFI spec.

The current approach is pretty brittle, since it relies on putting
some of the U-Boot code into a separate area. There is no good way to
know which U-Boot code should be in that area, since we don't create a
separate build. If a function calls one that has not been specially
marked, or accesses data that is not in the area, then it will crash
or hang.

So, as I said, I think we need a new build, if we want to avoid all of
U-Boot in there. Anything else is hard to maintain.

>
> [...]
>
> [0] https://www.youtube.com/watch?v=UdQk0SCUAlA
> [1] https://lpc.events/event/17/contributions/1653/attachments/1338/2682/Plumbers%20-%20EFI%20setvariable%20problems%20and%20solutions.pdf
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=c44b6be62e8dd4ee0a308c36a70620613e6fc55f
>

Regards,
Simon
