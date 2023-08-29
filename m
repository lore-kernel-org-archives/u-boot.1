Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C508C71153
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 20:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F3138647D;
	Tue, 29 Aug 2023 22:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J0Jr8tfX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98C64864D7; Tue, 29 Aug 2023 22:31:52 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DAE9863FD
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 22:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52a0856b4fdso6282069a12.1
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 13:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693341108; x=1693945908; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PNPlL2weBCx5HnxKV/aO0zqwQc1hVWS5Ujjb/TWTyJ0=;
 b=J0Jr8tfX50/0JTcMVbFHqMKaSOOgMivpWBKtmKgD4uyl0Gt0X3CdRCSOHxzFyH2Uml
 odiKz4m3jriR8wBbB9Qw59BMmPI5YjrcyxsvvYFXT00Y7hSsUA6Vk9KEkdoknZtlT55t
 IRTEctbmDDsX91XKEIOW3xv9Urqi5ncZ6d0yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693341108; x=1693945908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PNPlL2weBCx5HnxKV/aO0zqwQc1hVWS5Ujjb/TWTyJ0=;
 b=QR7llti4bErUHaAXYQmGhrydF+OAjA3CvIg9z14BJGFWvRXJtizlPAxotDCetZOCuI
 ZHEm2eQ6juVsaPrjRjTP9YyZEiJ4QcFN/VZDr2vFxvV5mghH/Anfk5RvYQly9CvzdZvY
 o2WQ3TgrOmjxPUxslU7mvY76y+/ueeX7CPHUtoDhZoSYBvmGmZ/VwNhx/RlCBnNgxIPE
 8Nry0Mowj5OMuG9wFG1uvZwNGzitjTadvhrPqiC+pplDe/QTeODsybahfgnQU0DpbPk+
 5MKkJl84MapEo9iYQHIOAEKn+fZBBRcEqYy5fE1eRgbhuAbh0cWbD1vZJMJNbXX8PO5e
 YN0w==
X-Gm-Message-State: AOJu0YzNiWvA6BoIJUcrhgpB/xiDbmS/AbU3QmGgHncUXBtVQNSou4kk
 Y60NAAwEnQD/PKc/vq8KBggdTjLx31ag4ME9j4cgAQ==
X-Google-Smtp-Source: AGHT+IHa2cANK+WiuHWR7fsQnCeRMys6oo/IF7hgCqyK+0RHW1HxuZG5PTZimBcimAAJXlL/BW6dsV8XNo06queFO5Y=
X-Received: by 2002:a05:6402:120b:b0:52a:3ee9:a786 with SMTP id
 c11-20020a056402120b00b0052a3ee9a786mr232677edw.26.1693341107758; Tue, 29 Aug
 2023 13:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <CALeDE9NUZ5vUzMrZgTcYtNR9dXyWEsZ+6zXNTFuFSvfL4XoM8Q@mail.gmail.com>
In-Reply-To: <CALeDE9NUZ5vUzMrZgTcYtNR9dXyWEsZ+6zXNTFuFSvfL4XoM8Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Aug 2023 14:31:36 -0600
Message-ID: <CAPnjgZ2zVcwfm1=+ce_J89sMEFQR6HsTwe-X31ZqjbWrNkxcYQ@mail.gmail.com>
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

On Tue, 29 Aug 2023 at 04:33, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> > > > > > > Provide a way for removing certain devicetree nodes and/or properties
> > > > > > > from the devicetree. This is needed to purge certain nodes and
> > > > > > > properties which may be relevant only in U-Boot. Such nodes and
> > > > > > > properties are then removed from the devicetree before it is passed to
> > > > > > > the kernel. This ensures that the devicetree passed to the OS does not
> > > > > > > contain any non-compliant nodes and properties.
> > > > > > >
> > > > > > > The removal of the nodes and properties is being done through an
> > > > > > > EVT_FT_FIXUP handler. I am not sure if the removal code needs to be
> > > > > > > behind any Kconfig symbol.
> > > > > > >
> > > > > > > I have only build tested this on sandbox, and tested on qemu arm64
> > > > > > > virt platform. This being a RFC, I have not put this through a CI run.
> > > > > > >
> > > > > > > Sughosh Ganu (5):
> > > > > > >   dt: Provide a way to remove non-compliant nodes and properties
> > > > > > >   fwu: Add the fwu-mdata node for removal from devicetree
> > > > > > >   capsule: Add the capsule-key property for removal from devicetree
> > > > > > >   bootefi: Call the EVT_FT_FIXUP event handler
> > > > > > >   doc: Add a document for non-compliant DT node/property removal
> > > > > > >
> > > > > > >  cmd/bootefi.c                                 | 18 +++++
> > > > > > >  .../devicetree/dt_non_compliant_purge.rst     | 64 ++++++++++++++++
> > > > > > >  drivers/fwu-mdata/fwu-mdata-uclass.c          |  5 ++
> > > > > > >  include/dt-structs.h                          | 11 +++
> > > > > > >  lib/Makefile                                  |  1 +
> > > > > > >  lib/dt_purge.c                                | 73 +++++++++++++++++++
> > > > > > >  lib/efi_loader/efi_capsule.c                  |  7 ++
> > > > > > >  7 files changed, 179 insertions(+)
> > > > > > >  create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.rst
> > > > > > >  create mode 100644 lib/dt_purge.c
> > > > > >
> > > > > > What is the point of removing them? Instead, we should make sure that
> > > > > > we upstream the bindings and encourage SoC vendors to sync them. If we
> > > > > > remove them, no one will bother and U-Boot just becomes a dumping
> > > > > > ground.
> > > > >
> > > > > Well things like the binman entries in DT are U-Boot specific and not
> > > > > useful for HW related descriptions or for Linux or another OS being
> > > > > able to deal with HW so arguably we're already a dumping ground to
> > > > > some degree for not defining hardware.
> > > >
> > > > I have started the process to upstream the binman bindings.
> > >
> > > I don't think they should be in DT at all, they don't describe
> > > anything to do with hardware, or generally even the runtime of a
> > > device, they don't even describe the boot/runtime state of the
> > > firmware, they describe build time, so I don't see what that has to do
> > > with device tree? Can you explain that? To me those sorts of things
> > > should live in a build time style config file.
> >
> > I beg to differ. Devicetree is more than just hardware and always has
> > been. See, for example the /chosen and /options nodes.
>
> Can you give me an example of "options" as grep doesn't give me a
> single one in the kernel tree? I think we can just agree to disagree
> here.

See here: https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/options/u-boot.yaml

I don't mind disagreeing, so long as it doesn't result in any
restrictions on using devicetree in firmware. But it is very important
to the success of firmware that we can make full use of the
devicetree.

> > We need run-time configuration here, since we cannot know at build
> > time what we will be asked to do by a previous firmware phase.
>
> Can you provide an example as to how that is used during runtime? Do
> you mean runtime during the build process or runtime on the device?

I mean runtime on the device. An example is that we might want to
control whether the serial UART is enabled, without having to rebuild
each program in the firmware stack.

>
> > >
> > > > Perhaps we should use the issue tracker[1] to follow progress on all
> > > > of this. We need to clean it up.
> > > >
> > > > >
> > > > > > Instead of this, how about working on bringing the DT validation into
> > > > > > U-Boot so we can see what state things are in?
> > > > > >
> > > > > > Please send the bindings for Linaro's recent series (which I suspect
> > > > > > are motivating this series) so we can start the process.
> > > >
> > > > Regards,
> > > > Simon
> > > >
> > > > [1] https://source.denx.de/u-boot/u-boot/-/issues
> >
> > Regards,
> > Simon

Regards,
Simon
