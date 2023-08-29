Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C509C83F14
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 10:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50D95864E7;
	Tue, 29 Aug 2023 12:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TuLoTJTz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CD8F864E8; Tue, 29 Aug 2023 12:33:54 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2F32864C7
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 12:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2bcda0aaf47so59239871fa.1
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 03:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693305230; x=1693910030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K8aPQ77ClURucANugiRC6EgxyErcFc7K0iicrXDzQxQ=;
 b=TuLoTJTzOoI32H8FGjyGqhSnj0DdomgwHOUFOjDYY4YKydijVoAL8WnQLYMvC2LjkZ
 1CgmCKlXpgfa4lUzMYmKEzBF9f55pyVN5u9ULGVhNyEhEPWaD8A8t6QObRaIJ05998Ll
 L31yRuyFCfS6WssE7jHDHdemqi4+WhaLp9SIbNLdhyRKt9UGAQQNjOsv3QqQBuSCahxv
 9XmSut5ATUDoPG4MZqRYxEWfOkQr4a7CwXjwh21ukoLyD91QBzpNos6es8T80+NL0C17
 l6vMPtB78xDTNqj8yGQuW6pKjdZ22cXEGEsq+HHtVgorPxV5lTjbgSn50RVty6XrpRhO
 iPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693305230; x=1693910030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K8aPQ77ClURucANugiRC6EgxyErcFc7K0iicrXDzQxQ=;
 b=iutZYHH7UcUjghQJCKEAssoJtlWpQxby6nkwEIcPvxAs72S06I+Z6eryUPkqDzt8ux
 71L0tIOh2Q/CF7XzCtTrkkmFn2vLIQkUxZKDI6mhjfC2a9JqabqYK+Z+Hgo2W1bgYL++
 EmDxdANNP5VAYl/hEypw5yDjP1FI8XHAVww6Rbviuf4EJR98XFAhHuYsJ+3lSEzQfIbW
 4VtnQY9OUdOGMF8RxHjpUUZEK6LkYj2eKjCEDH4WKy0OzcBp22Cff3lc8fD+QzD5l9UW
 O2S932OyPfCcG/TyoSRhnF0ftjlq0VE3cH7wSbzXchFdSV6WdFe5EcZb5BZnabkR29N3
 E5hQ==
X-Gm-Message-State: AOJu0YyZRvsNEK8VApdmgE8C2tO8M5rNaTr7mEoRDiyURkmz0GlkbU+0
 m6+lw+ODIEq9IRlJ8DakDdbjlKcqgsW/8Bvj964=
X-Google-Smtp-Source: AGHT+IF7JQbMo7r6nKZZQyIh+n3PI1oaptSfhjhXaFtalXEapplcAyw0ohW6VHuBdWmowaDq/2lXHVjtBp3r/pfNevc=
X-Received: by 2002:a2e:b615:0:b0:2bc:c433:fbac with SMTP id
 r21-20020a2eb615000000b002bcc433fbacmr779392ljn.26.1693305229826; Tue, 29 Aug
 2023 03:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 29 Aug 2023 11:33:38 +0100
Message-ID: <CALeDE9NUZ5vUzMrZgTcYtNR9dXyWEsZ+6zXNTFuFSvfL4XoM8Q@mail.gmail.com>
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

> > > > > > Provide a way for removing certain devicetree nodes and/or properties
> > > > > > from the devicetree. This is needed to purge certain nodes and
> > > > > > properties which may be relevant only in U-Boot. Such nodes and
> > > > > > properties are then removed from the devicetree before it is passed to
> > > > > > the kernel. This ensures that the devicetree passed to the OS does not
> > > > > > contain any non-compliant nodes and properties.
> > > > > >
> > > > > > The removal of the nodes and properties is being done through an
> > > > > > EVT_FT_FIXUP handler. I am not sure if the removal code needs to be
> > > > > > behind any Kconfig symbol.
> > > > > >
> > > > > > I have only build tested this on sandbox, and tested on qemu arm64
> > > > > > virt platform. This being a RFC, I have not put this through a CI run.
> > > > > >
> > > > > > Sughosh Ganu (5):
> > > > > >   dt: Provide a way to remove non-compliant nodes and properties
> > > > > >   fwu: Add the fwu-mdata node for removal from devicetree
> > > > > >   capsule: Add the capsule-key property for removal from devicetree
> > > > > >   bootefi: Call the EVT_FT_FIXUP event handler
> > > > > >   doc: Add a document for non-compliant DT node/property removal
> > > > > >
> > > > > >  cmd/bootefi.c                                 | 18 +++++
> > > > > >  .../devicetree/dt_non_compliant_purge.rst     | 64 ++++++++++++++++
> > > > > >  drivers/fwu-mdata/fwu-mdata-uclass.c          |  5 ++
> > > > > >  include/dt-structs.h                          | 11 +++
> > > > > >  lib/Makefile                                  |  1 +
> > > > > >  lib/dt_purge.c                                | 73 +++++++++++++++++++
> > > > > >  lib/efi_loader/efi_capsule.c                  |  7 ++
> > > > > >  7 files changed, 179 insertions(+)
> > > > > >  create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.rst
> > > > > >  create mode 100644 lib/dt_purge.c
> > > > >
> > > > > What is the point of removing them? Instead, we should make sure that
> > > > > we upstream the bindings and encourage SoC vendors to sync them. If we
> > > > > remove them, no one will bother and U-Boot just becomes a dumping
> > > > > ground.
> > > >
> > > > Well things like the binman entries in DT are U-Boot specific and not
> > > > useful for HW related descriptions or for Linux or another OS being
> > > > able to deal with HW so arguably we're already a dumping ground to
> > > > some degree for not defining hardware.
> > >
> > > I have started the process to upstream the binman bindings.
> >
> > I don't think they should be in DT at all, they don't describe
> > anything to do with hardware, or generally even the runtime of a
> > device, they don't even describe the boot/runtime state of the
> > firmware, they describe build time, so I don't see what that has to do
> > with device tree? Can you explain that? To me those sorts of things
> > should live in a build time style config file.
>
> I beg to differ. Devicetree is more than just hardware and always has
> been. See, for example the /chosen and /options nodes.

Can you give me an example of "options" as grep doesn't give me a
single one in the kernel tree? I think we can just agree to disagree
here.

> We need run-time configuration here, since we cannot know at build
> time what we will be asked to do by a previous firmware phase.

Can you provide an example as to how that is used during runtime? Do
you mean runtime during the build process or runtime on the device?

> >
> > > Perhaps we should use the issue tracker[1] to follow progress on all
> > > of this. We need to clean it up.
> > >
> > > >
> > > > > Instead of this, how about working on bringing the DT validation into
> > > > > U-Boot so we can see what state things are in?
> > > > >
> > > > > Please send the bindings for Linaro's recent series (which I suspect
> > > > > are motivating this series) so we can start the process.
> > >
> > > Regards,
> > > Simon
> > >
> > > [1] https://source.denx.de/u-boot/u-boot/-/issues
>
> Regards,
> Simon
