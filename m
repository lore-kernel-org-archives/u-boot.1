Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5FFC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0C71875E9;
	Wed, 20 Dec 2023 05:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mL7caDjl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C913E87669; Wed, 20 Dec 2023 05:48:13 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 660AC8753E
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-553eb4cee4aso42008a12.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703047691; x=1703652491; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MQryz8iwFhQBChmncC3G3gKTIqgT7a4dToJXjUUIXVE=;
 b=mL7caDjl9N6I++fL3sppX+6VeZ52joy+51PzT3DP2rdbOTHlausUEYUjF158csfQS2
 9S/srOadyQqjpEns+/OlX5Mnh9mfptFNZ0+ItV1tRQdvS0wThIni9jGlIpFDV/eJom0s
 VFFvt6leJyBBnjPy934/hcVbGy/efZqja5IYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703047691; x=1703652491;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MQryz8iwFhQBChmncC3G3gKTIqgT7a4dToJXjUUIXVE=;
 b=TeKani5DkougVXHgqhctJsv1J7nc9p5AQkwHKIWx0ARwGCKI+fFfE9Rw5Db3qNb/Y9
 k6ExB800XoYgGrxVewVWyBq9eERfzQMqSvnP9ZayYMQYM4F8lvXo1jkMVCq2lKuah2uH
 kmMw5qFAOXGPtpwxd7AtcrMNxY+g6/nRhBmhdXXsA2S7xa0Jq9myk0TqNx47QD9xSNh3
 zXP4DiQri77EgzHmcZrGtoyUVgjNCE4KX46eFQA+AwbqBDmVsG9mQEfN1UgX4kCe2BG3
 zPvgrAU/ZD4d3sxVl1p2p9zbOotUiOsjgmuDmBrwF5wIBcSozMluvY3CwrAYKIpFWYlX
 a12w==
X-Gm-Message-State: AOJu0Yw9aIm5Pt52DyD24KDcTyP5Huv+vcpPEj04KHEivCssmdVHCglR
 Q+axx1cpD9fTKWAo5yy6KV5BK7NDZJ6h0FSNlgdDqQ==
X-Google-Smtp-Source: AGHT+IFANJmLuLzhb8rBrIYFE0JGxXUonUruhKprxRQ8hERlzHHybSOCM7h8o1qCsnMg6Mmdvfg8nSzpG48HJdGt7+E=
X-Received: by 2002:a17:906:73d3:b0:a23:4faa:dd66 with SMTP id
 n19-20020a17090673d300b00a234faadd66mr2280475ejl.137.1703047690590; Tue, 19
 Dec 2023 20:48:10 -0800 (PST)
MIME-Version: 1.0
References: <20231214155346.GB295924@e130802.arm.com>
 <87ttok689d.fsf@bloch.sibelius.xs4all.nl>
 <CAC_iWjKYa1_GrU3XPKqbnOf6VJxx426qTfD1WcSMkmj982ECSw@mail.gmail.com>
 <CAPnjgZ1TsFCzTd2pD3j4SoAhnJWw1qz90DfEzsU6Y-4bSkEf7A@mail.gmail.com>
 <B06FB6F5-416C-440D-BC72-070673DF3177@gmx.de>
In-Reply-To: <B06FB6F5-416C-440D-BC72-070673DF3177@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:47:59 -0700
Message-ID: <CAPnjgZ227GHMy2r=9fmK2XWNShpUL_vwt9-VhGeZMNec0qJ7XA@mail.gmail.com>
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Abdellatif El Khlifi <Abdellatif.ElKhlifi@arm.com>, Drew.Reed@arm.com,
 u-boot@lists.denx.de, nd@arm.com
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

Hi Heinrich,

On Mon, 18 Dec 2023 at 13:59, Heinrich Schuchardt <xypron.glpk@gmx.de> wrot=
e:
>
>
>
> Am 18. Dezember 2023 16:01:44 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi,
> >
> >On Thu, 14 Dec 2023 at 12:47, Ilias Apalodimas
> ><ilias.apalodimas@linaro.org> wrote:
> >>
> >> Hi Mark, Abdellatif
> >>
> >> On Thu, 14 Dec 2023 at 18:47, Mark Kettenis <mark.kettenis@xs4all.nl> =
wrote:
> >> >
> >> > > Date: Thu, 14 Dec 2023 15:53:46 +0000
> >> > > From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> >> >
> >> > Hi Abdellatif,
> >> >
> >> > > Hi guys,
> >> > >
> >> > > I'd like to ask for advice regarding adding EFI RT support to the =
Arm's FF-A bus
> >> > > in U-Boot.
> >> > >
> >> > > The objective is to enable the FF-A messaging APIs in EFI RT to be
> >> > > used for comms with the secure world. This will help getting/setti=
ng
> >> > > EFI variables through FF-A.
> >> > >
> >> > > The existing FF-A APIs in U-Boot call the DM APIs (which are not a=
vailable at RT).
> >> > >
> >> > > Two possible solutions:
> >> > >
> >> > > 1/ having the entire U-Boot in RT space (as Simon stated in this d=
iscussion[1])
> >> >
> >> > I don't think this is a terribly good idea.  With this approach orde=
rs
> >> > of magnitude more code will be present in kernel address space one t=
he
> >> > OS kernel is running and calling into the EFI runtime.  Including co=
de
> >> > that may access hardware devices that are now under OS control.  It
> >> > will be nigh impossible to audit all that code and make sure that on=
ly
> >> > a safe subset of it gets called.  So...
> >>
> >> +100
> >> I think we should draw a line here. I mentioned it on another thread,
> >> but I did a shot BoF in Plumbers discussing issues like this,
> >> problems, and potential solutions [0] [1]. Since that talk patches for
> >> the kernel that 'solve' the problem for RPMBs got pulled into
> >> linux-next [2].
> >> The TL;DR of that talk is that if the kernel ends up being in control
> >> of the hardware that stores the EFI variables, we need to find elegant
> >> ways to teach the kernel how to store those directly. The EFI
> >> requirement of an isolated flash is something that mostly came from
> >> the x86 world and is not a reality on the majority of embedded boards.
> >> I also think we should give up on Authenticated EFI variables in that
> >> case. We get zero guarantees unless the medium has similar properties
> >> to an RPMB.
> >> If a vendor cares about proper UEFI secure boot he can implement
> >> proper hardware.
> >
> >Just to copy in my thoughts as they are lost at this point:
> >
> >> We would need to publish a runtime interface with access to the driver
> >> API. I did ask for this when the EFI runtime support was added, but it
> >> wasn't done.
> >
> >> It would be possible to create a new 'runtime' phase of U-Boot (RPL?),
> >> separate from the others. That will be much easier once we get the XPL
> >> stuff sorted out., since adding new [hase would be fairly trivial  CPL
> >> died as another contributor had a series which went in first...then I
> >> never got back to it.
> >
> >> So for now having the entire U-Boot in runtime space seems reasonable =
to me.
> >
> >> I'll also mention that it would be nice to have s new-style API
> >> (replacing the old API U-Boot currently has) which uses more of a
> >> module approach. E.g. we could declare that uclass_first_device() is
> >> exported and can be called from outside U-Boot.
> >
> >>
> >> >
> >> > >
> >> > > 2/ Create an RT variant for the FF-A APIs needed.
> >> > >       These RT variant don't call the DM APIs
> >> > >       (e.g: ffa_mm_communicate_runtime, ffa_sync_send_receive_runt=
ime, ...)
> >> > >
> >> > > What do you recommend please ?
> >> >
> >> > ...this is what I would recommend.  Preferably in a way that refacto=
rs
> >> > the code such that the low-level functionality is shared between the
> >> > DM and non-DM APIs.
> >>
> >> Yes. The only thing you need to keep alive is the machinery to talk to
> >> the secure world. The bus, flash driver etc should all be running
> >> isolated in there. In that case you can implement SetVariableRT as
> >> described the the EFI spec.
> >
> >The current approach is pretty brittle, since it relies on putting
> >some of the U-Boot code into a separate area. There is no good way to
> >know which U-Boot code should be in that area, since we don't create a
> >separate build. If a function calls one that has not been specially
> >marked, or accesses data that is not in the area, then it will crash
> >or hang.
> >
> >So, as I said, I think we need a new build, if we want to avoid all of
> >U-Boot in there. Anything else is hard to maintain.
>
> The EFI runtime is the most security exposed part of U-Boot. We should st=
rive to keep the attack surface small. No matter how we define the runtime =
(by section assignment as today or by a dedicated build) I would not want t=
o have the driver model in the runtime.
>
> The only drivers that are required by the EBBR are for resetting the syst=
em. ARM has PSCI as reset handler, RISC-V has SBI. These are invoked by sim=
ple ecalls.

So why not have Linux do it? Why do we need the runtime at all?

But from the other POV, what if this expands? We are creating a little
runtime stub without driver model? I suppose it will work until it
doesn't.

>
> Any runtime device drivers for variable storage should not be in the U-Bo=
ot runtime but live in the secure world (e.g. OP-TEE). FF-A is the new  ARM=
 protocol for talking to the secure world and hence fits into the picture.

OK. This is all very complicated, of course. But OK.

>
> @Abdellatif
>
> Does an OP-TEE module for managing EFI variables via FF-A already exist? =
For QEMU?
>
> Best regards
>
> Heinrich
>
> >
> >>
> >> [...]
> >>
> >> [0] https://www.youtube.com/watch?v=3DUdQk0SCUAlA
> >> [1] https://lpc.events/event/17/contributions/1653/attachments/1338/26=
82/Plumbers%20-%20EFI%20setvariable%20problems%20and%20solutions.pdf
> >> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.gi=
t/commit/?id=3Dc44b6be62e8dd4ee0a308c36a70620613e6fc55f
> >>
> >

Regards,
Simon
