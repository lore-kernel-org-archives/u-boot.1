Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD796C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4CB586456;
	Mon, 28 Aug 2023 19:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="crBpRQvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FE0F8648B; Mon, 28 Aug 2023 19:54:51 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C2DF86430
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-52713d2c606so4622536a12.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693245288; x=1693850088;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d6zbYKwInL6DZyuMLJnYMmG22rNEbvDadKSxIuLW3KY=;
 b=crBpRQvftbJjdWVbWHmaLrTvKI/MmxgermRiK74wPUmosV9IPgBixInUtIJhFzEz1/
 W8o7Tz8tJftGn/kQA4VyPAl1xu7L6YHws8cpaGmml8kCySuL4OCVNIuaAV9x/7Y3gKmH
 a0WuyNFHdx+oh1UuktNtb+uU/kGR8WXU8Y26s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693245288; x=1693850088;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d6zbYKwInL6DZyuMLJnYMmG22rNEbvDadKSxIuLW3KY=;
 b=HGICGGXubAEi7WoT+ByXZH5nvXE9DBXOcs0H7opDoDss0C6pYy9a8z/zJql0O35qj1
 aoHuWf4H0ZemjPzujMvWIJwXw7Xn0eOFoNBsxgJx2L9VJGabfh6vcc6Y7wwUTUd2LtA/
 tzAsC1PjRmVKZIS1/K2Emgk3PMitmQ+7biADMspV7QZ8xi85+nQPKYnYDK0WRgieyEJe
 NBPHoi8lViyhrvzNdHwLYQxEWBAI3/x7IHoC2/973BwAjqQMUBjef6KV9jloSu1gx8vQ
 hAnYT+bOZ+00jOykJX64XiuuUJuenFyvBBk2XoPUDEK2F0E/sytPmcGS2wN1GnYobfzH
 fvfA==
X-Gm-Message-State: AOJu0YwYErfcISPlArocwLg7nXEtWgA99LYnrYdZgK8SYthFdahcH0j0
 kj8Wbm6k2625x1/nf1mq9vQ7YGzn52xWPXg3N+dZWw==
X-Google-Smtp-Source: AGHT+IEZ6q62pcBsNHbybDvHf69J6jN35EzQlDZGtSeN2CT1Lq/HpeS/UgsDVms5pp4iUJyRnHK1+4SeWChwEUGqbG4=
X-Received: by 2002:a50:ed09:0:b0:525:6d9e:67c0 with SMTP id
 j9-20020a50ed09000000b005256d9e67c0mr20142345eds.23.1693245287799; Mon, 28
 Aug 2023 10:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
In-Reply-To: <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 11:54:36 -0600
Message-ID: <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Peter,

On Mon, 28 Aug 2023 at 10:37, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Mon, Aug 28, 2023 at 5:20=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi,
> >
> > On Sat, 26 Aug 2023 at 03:07, Sughosh Ganu <sughosh.ganu@linaro.org> wr=
ote:
> > >
> > >
> > > Provide a way for removing certain devicetree nodes and/or properties
> > > from the devicetree. This is needed to purge certain nodes and
> > > properties which may be relevant only in U-Boot. Such nodes and
> > > properties are then removed from the devicetree before it is passed t=
o
> > > the kernel. This ensures that the devicetree passed to the OS does no=
t
> > > contain any non-compliant nodes and properties.
> > >
> > > The removal of the nodes and properties is being done through an
> > > EVT_FT_FIXUP handler. I am not sure if the removal code needs to be
> > > behind any Kconfig symbol.
> > >
> > > I have only build tested this on sandbox, and tested on qemu arm64
> > > virt platform. This being a RFC, I have not put this through a CI run=
.
> > >
> > > Sughosh Ganu (5):
> > >   dt: Provide a way to remove non-compliant nodes and properties
> > >   fwu: Add the fwu-mdata node for removal from devicetree
> > >   capsule: Add the capsule-key property for removal from devicetree
> > >   bootefi: Call the EVT_FT_FIXUP event handler
> > >   doc: Add a document for non-compliant DT node/property removal
> > >
> > >  cmd/bootefi.c                                 | 18 +++++
> > >  .../devicetree/dt_non_compliant_purge.rst     | 64 ++++++++++++++++
> > >  drivers/fwu-mdata/fwu-mdata-uclass.c          |  5 ++
> > >  include/dt-structs.h                          | 11 +++
> > >  lib/Makefile                                  |  1 +
> > >  lib/dt_purge.c                                | 73 +++++++++++++++++=
++
> > >  lib/efi_loader/efi_capsule.c                  |  7 ++
> > >  7 files changed, 179 insertions(+)
> > >  create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.rst
> > >  create mode 100644 lib/dt_purge.c
> >
> > What is the point of removing them? Instead, we should make sure that
> > we upstream the bindings and encourage SoC vendors to sync them. If we
> > remove them, no one will bother and U-Boot just becomes a dumping
> > ground.
>
> Well things like the binman entries in DT are U-Boot specific and not
> useful for HW related descriptions or for Linux or another OS being
> able to deal with HW so arguably we're already a dumping ground to
> some degree for not defining hardware.

I have started the process to upstream the binman bindings.

Perhaps we should use the issue tracker[1] to follow progress on all
of this. We need to clean it up.

>
> > Instead of this, how about working on bringing the DT validation into
> > U-Boot so we can see what state things are in?
> >
> > Please send the bindings for Linaro's recent series (which I suspect
> > are motivating this series) so we can start the process.

Regards,
Simon

[1] https://source.denx.de/u-boot/u-boot/-/issues
