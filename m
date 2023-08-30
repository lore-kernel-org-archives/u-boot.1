Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4431C83F01
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 08:19:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DAD28643D;
	Wed, 30 Aug 2023 10:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oH8KTozA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DB1C8643D; Wed, 30 Aug 2023 10:19:37 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A2E4862F1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 10:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b72161c6e9so7504591fa.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 01:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693383574; x=1693988374; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=knSWMdpxTHP5t4p7W0Lft/Nm58wXAoYis8FqirBCYJw=;
 b=oH8KTozA4zenbZ3/8wMYss/2bgA/IBzCK9NOCp2DpBtvlZ2V8A2LcrFbMmaAALNlU2
 rVaJYvHwCFVRZc6l3ij4kHW06hDZZ1hx6ak+hd3UF4lW1mrBsqHE9CYg0hjoiRnug+OL
 eqeIIcbtYA0niCjiyrvZG7Np4fqPYpFkUierq5uA0S2EHicY70hd0fsxpZ4E5Wrku2r5
 BnHtqwy3ET3gjzYaERzHwr0DD0TR353KwdndIzJCBdJMdR/5lUQl2TWCAOZuIJdbg5Xr
 4HZWXw6sLurKgpGuFAJ4+tAZNdjWVFO0ngKKo4lmAXuPGQK8/1N9z6eXrfK+aNqfWXkW
 S61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693383574; x=1693988374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=knSWMdpxTHP5t4p7W0Lft/Nm58wXAoYis8FqirBCYJw=;
 b=UidSVuzxCj46wDJ/gzcyNqVuG4mm43H3l0eF4svTpGh279oqhGB+vf8++NhC2DU3k2
 RvPnCwvckPa6XPI6UG78u5yBn1F5Qc9nJTliGFQAptYKCJ4g70O7nvLWxBC4b6Ucp1ye
 SENx0zVBQutNB0EtlRKavQVDFphDQFKyoi/UucK5F+HI6NCvBG8kbrrL7aZwrDHwp08Y
 RC8eIf+P4pDKPmVR1h9ttUpT8X/jL87A8cdBpnq8mRsb3RUYWgJzb+1zVYVLx5XqmxPf
 EkecwDsPLMg65v2UYD54zbsdq20Q0QF06yYvMEUvNEatridBhKYNTE6zJxLghEzE6AHF
 Jx+Q==
X-Gm-Message-State: AOJu0YxOB3RPgOsdtLtlERWpXcSwnmFNdvcuIXItFeuTcSq4NOoi80xg
 smCzQeDNfJc8hBhhKG6QcHFhDYFsTlbKjOOpgoQ=
X-Google-Smtp-Source: AGHT+IHU6f7Tc+cS2VoXFpwv3ICQuVWMJDB3Z22wYOkoePkKMTBr0cBj2L88oZ4Mw1hB2YEP+7tQV1lQAr1E14um0es=
X-Received: by 2002:a2e:95ca:0:b0:2bb:94e4:6b07 with SMTP id
 y10-20020a2e95ca000000b002bb94e46b07mr633000ljh.12.1693383573482; Wed, 30 Aug
 2023 01:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <CALeDE9NUZ5vUzMrZgTcYtNR9dXyWEsZ+6zXNTFuFSvfL4XoM8Q@mail.gmail.com>
 <CAPnjgZ2zVcwfm1=+ce_J89sMEFQR6HsTwe-X31ZqjbWrNkxcYQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ2zVcwfm1=+ce_J89sMEFQR6HsTwe-X31ZqjbWrNkxcYQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 30 Aug 2023 09:19:22 +0100
Message-ID: <CALeDE9PbgPVWDCH0VMN8ftJ55VvkgksHUxNwoOK1ksCOJpNN=w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
To: Simon Glass <sjg@chromium.org>
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

> > > > > I have started the process to upstream the binman bindings.
> > > >
> > > > I don't think they should be in DT at all, they don't describe
> > > > anything to do with hardware, or generally even the runtime of a
> > > > device, they don't even describe the boot/runtime state of the
> > > > firmware, they describe build time, so I don't see what that has to do
> > > > with device tree? Can you explain that? To me those sorts of things
> > > > should live in a build time style config file.
> > >
> > > I beg to differ. Devicetree is more than just hardware and always has
> > > been. See, for example the /chosen and /options nodes.
> >
> > Can you give me an example of "options" as grep doesn't give me a
> > single one in the kernel tree? I think we can just agree to disagree
> > here.
>
> See here: https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/options/u-boot.yaml

All of those options look to me like they would work just fine in a
.env file like you've added board/raspberrypi/rpi/rpi.env

> I don't mind disagreeing, so long as it doesn't result in any
> restrictions on using devicetree in firmware. But it is very important
> to the success of firmware that we can make full use of the
> devicetree.

That statement doesn't make sense, of course the firmware makes full
use of the DT because it needs it to instantiate the HW. You don't
actually answer my question though.

> > > We need run-time configuration here, since we cannot know at build
> > > time what we will be asked to do by a previous firmware phase.
> >
> > Can you provide an example as to how that is used during runtime? Do
> > you mean runtime during the build process or runtime on the device?
>
> I mean runtime on the device. An example is that we might want to
> control whether the serial UART is enabled, without having to rebuild
> each program in the firmware stack.

That is describing the HW though, such as whether a serial port is
enabled or not, it's not how the binman pieces you're adding to DT are
used during runtime which is the question I was asking.

> >
> > > >
> > > > > Perhaps we should use the issue tracker[1] to follow progress on all
> > > > > of this. We need to clean it up.
> > > > >
> > > > > >
> > > > > > > Instead of this, how about working on bringing the DT validation into
> > > > > > > U-Boot so we can see what state things are in?
> > > > > > >
> > > > > > > Please send the bindings for Linaro's recent series (which I suspect
> > > > > > > are motivating this series) so we can start the process.
> > > > >
> > > > > Regards,
> > > > > Simon
> > > > >
> > > > > [1] https://source.denx.de/u-boot/u-boot/-/issues
> > >
> > > Regards,
> > > Simon
>
> Regards,
> Simon
