Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCB0C83F2B
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DACC286554;
	Thu, 31 Aug 2023 05:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QwvdLHe7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D30986567; Thu, 31 Aug 2023 05:38:21 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 754CB86550
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:38:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-500c37d479aso790169e87.2
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693453098; x=1694057898; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o7aH3etJoNj11J8MEJUkN8gGuf1qoU7XUzpttRWuiZQ=;
 b=QwvdLHe7VELwPoqshmfaF5vleAa/gc2ZJuYT7SRzdXfgLmaTkrPXAJPHUrAcMOncUt
 9ZqYrt97SjqN6KdnSHq4MR2OOquXF+ktUIUGPb99WHYOSIQq/smFAYkAEhYLXixnf+WF
 HQGMS/U8+MbgifgamVVrJr/MW89Hk6fOLfMt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693453098; x=1694057898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o7aH3etJoNj11J8MEJUkN8gGuf1qoU7XUzpttRWuiZQ=;
 b=U5CBfOOSXdYMtYISd1RWUiBX0tI6cIifIOpG7I0u7paaDfllRgZDEPic2xOLNFevdP
 qeCt4qc/y7aa3apXlt8LdvXTW8W0PncAQ76csaTyvcIrk3AfJ9XSG9/BK74114m6GZ2g
 RXsc/qXM77JYq50GzfmjiYCd9Ouwmqa5KsToqRVobBwm7nLbOwPa6WGCzsJAJPa4IsHO
 SgGc68gT5avAecA0sj3tj+/AmpTDik9mz0717KeDK7JYhTMvIJzmrQem0oIJW2X1hFQI
 VVtRS1ljFX7NAuGIk3iEKug/1e8XkQrobasTd5hVL+CbmmvcpSKpr9RkgAK9qmu6Qfta
 /fjA==
X-Gm-Message-State: AOJu0YzA4Z+Kx47ulo2moNU18jAlqHojT+tg+sfPXnUHkzany3OHdECh
 vZY4kbeC4+s+tvuMcnCXuvi4avFcdDg+7QStVRr5JA==
X-Google-Smtp-Source: AGHT+IGzcTRojVh+KwqUSk68tzb2Iu2y98X2LQFaMpv2xvrALli55z9EJO1g11UFqQy/uT4g3AAi1Ko9YyAmW83NBLw=
X-Received: by 2002:a05:6512:398e:b0:4f8:62a6:8b2 with SMTP id
 j14-20020a056512398e00b004f862a608b2mr2990330lfu.46.1693453097581; Wed, 30
 Aug 2023 20:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <CALeDE9NUZ5vUzMrZgTcYtNR9dXyWEsZ+6zXNTFuFSvfL4XoM8Q@mail.gmail.com>
 <CAPnjgZ2zVcwfm1=+ce_J89sMEFQR6HsTwe-X31ZqjbWrNkxcYQ@mail.gmail.com>
 <CALeDE9PbgPVWDCH0VMN8ftJ55VvkgksHUxNwoOK1ksCOJpNN=w@mail.gmail.com>
In-Reply-To: <CALeDE9PbgPVWDCH0VMN8ftJ55VvkgksHUxNwoOK1ksCOJpNN=w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Aug 2023 21:38:05 -0600
Message-ID: <CAPnjgZ3x8OgnnPWYndRvRpYB+5JTfrSEsA_i3aXiri2eh-nonA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Peter,

On Wed, 30 Aug 2023 at 02:19, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> > > > > > I have started the process to upstream the binman bindings.
> > > > >
> > > > > I don't think they should be in DT at all, they don't describe
> > > > > anything to do with hardware, or generally even the runtime of a
> > > > > device, they don't even describe the boot/runtime state of the
> > > > > firmware, they describe build time, so I don't see what that has to do
> > > > > with device tree? Can you explain that? To me those sorts of things
> > > > > should live in a build time style config file.
> > > >
> > > > I beg to differ. Devicetree is more than just hardware and always has
> > > > been. See, for example the /chosen and /options nodes.
> > >
> > > Can you give me an example of "options" as grep doesn't give me a
> > > single one in the kernel tree? I think we can just agree to disagree
> > > here.
> >
> > See here: https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/options/u-boot.yaml
>
> All of those options look to me like they would work just fine in a
> .env file like you've added board/raspberrypi/rpi/rpi.env

But that is built into U-Boot. How can it be controlled by another
previous progress in the firmware stack?

>
> > I don't mind disagreeing, so long as it doesn't result in any
> > restrictions on using devicetree in firmware. But it is very important
> > to the success of firmware that we can make full use of the
> > devicetree.
>
> That statement doesn't make sense, of course the firmware makes full
> use of the DT because it needs it to instantiate the HW. You don't
> actually answer my question though.

I think I tried to answer your question but we are not on the same
page. Please don't say that DT is just for hardware, since that is a
sore point with me. It helf back U-Boot for many years, to no useful
purpose.

Perhaps you could restate the question?

Also, why are you trying to keep things out of the DT?

>
> > > > We need run-time configuration here, since we cannot know at build
> > > > time what we will be asked to do by a previous firmware phase.
> > >
> > > Can you provide an example as to how that is used during runtime? Do
> > > you mean runtime during the build process or runtime on the device?
> >
> > I mean runtime on the device. An example is that we might want to
> > control whether the serial UART is enabled, without having to rebuild
> > each program in the firmware stack.
>
> That is describing the HW though, such as whether a serial port is
> enabled or not, it's not how the binman pieces you're adding to DT are
> used during runtime which is the question I was asking.

There is:

1. whether the serial device is enabled in the DT
2. whether it emits character or not

Often we always want 1, in case we need to emit something. But for 2
we want to control it with a global setting that applies to all
programs in the firmware flow.

Another example would be a framebuffer address, where we want to
provide it in the DT so that all programs can use the same one.


>
> > >
> > > > >
> > > > > > Perhaps we should use the issue tracker[1] to follow progress on all
> > > > > > of this. We need to clean it up.
> > > > > >
> > > > > > >
> > > > > > > > Instead of this, how about working on bringing the DT validation into
> > > > > > > > U-Boot so we can see what state things are in?
> > > > > > > >
> > > > > > > > Please send the bindings for Linaro's recent series (which I suspect
> > > > > > > > are motivating this series) so we can start the process.
> > > > > >
> > > > > > Regards,
> > > > > > Simon
> > > > > >
> > > > > > [1] https://source.denx.de/u-boot/u-boot/-/issues

Regards,
Simon
