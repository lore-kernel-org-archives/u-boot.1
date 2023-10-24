Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F24C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 389298797E;
	Tue, 24 Oct 2023 20:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cG5ouL7D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFDFB8726A; Tue, 24 Oct 2023 20:02:37 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF7CC87490
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso685033466b.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698170552; x=1698775352; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=itq0oS/uWWREFXq4XONNi1C9Vt1XYOXHaVy4smrhD0A=;
 b=cG5ouL7DzeGCCeKdgfO5GYlt0I+EyG3tQ0MXNv3wRjs62Zz9FCvVJxBP5CkreMYELu
 Jpa7iHiEaPq1AWLyWTAbonDmOXbtndWHfp43mdem15jmC5imgYeDzmYReQrzi1PVmNuL
 q8SQtI1SFHJ37feYx0mkK7rRrMAqvrnfltRaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698170552; x=1698775352;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=itq0oS/uWWREFXq4XONNi1C9Vt1XYOXHaVy4smrhD0A=;
 b=IIrLlupy1WJxpxUPPd2MXOrr6jHdkeGULQGnWKDFJLe9KHP2rhyH+m1kX7+s1+k8SV
 gAuXj36NYAnfESA1TcPnY1HbWZ52ZSaLYXaKv0CfYefvIBldVfmyMz/8uk13HkUNGhrX
 wP4+Hy1WCgbgD1+19tUgYRFo+vz05GIyucZxTxKVbPy4hc3dnw9Rj3lRhMCss/5ki3uC
 ENeglM7ygoB5SjNnLE50UzHP2gBVRt2iPPPSdUvKOK+z4MP1P4Ljlg200sTTerqmJyKB
 HZRztoRbZhabSl1ihA5zqy8GZQr4MkLhW33NDDXmBaZeXOBR/bdwC70xSD9OcEr2msvF
 bhWQ==
X-Gm-Message-State: AOJu0YyB/pBLqKH9T7iHte1c/hguGrgELZvVs10reDiOawxVLzyGBAJQ
 lfFbRH0RZ8c2lUxCZjVzBXPC91peR6VYQevKBmKrpyCldzSWfOaJk0VghpQl
X-Google-Smtp-Source: AGHT+IHtpJn5YqFy/cIlVrLyH6bAa3PH+X/I1w2HV5qL2zVr5FbH5ibTcxA+Y3LAowTv+UfsjTTLLFi93oLULpc1Wok=
X-Received: by 2002:a17:907:7da9:b0:9b2:982e:339a with SMTP id
 oz41-20020a1709077da900b009b2982e339amr10868993ejc.22.1698170552123; Tue, 24
 Oct 2023 11:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231022233727.84947-1-heinrich.schuchardt@canonical.com>
 <20231023170258.GT496310@bill-the-cat>
 <CAPnjgZ0Lbgmga7EhWPq3mThYih81Y18h0rHBL0Wdn=_nRU4NNQ@mail.gmail.com>
 <20231023172428.GU496310@bill-the-cat>
In-Reply-To: <20231023172428.GU496310@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 24 Oct 2023 11:02:12 -0700
Message-ID: <CAPnjgZ39WAKiBOHVu36es6wwQ8mbMhQKSeSSSRkEj8p1kykFVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] sandbox: eliminate unused functions from binaries
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de
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

On Mon, 23 Oct 2023 at 10:24, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 23, 2023 at 10:13:55AM -0700, Simon Glass wrote:
> > Hi,
> >
> > On Mon, 23 Oct 2023 at 10:03, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 23, 2023 at 01:37:27AM +0200, Heinrich Schuchardt wrote:
> > > > The sandbox should closely mimic other architectures.
> > > >
> > > > Place each function or data in a separate section and let the linker
> > > > eliminate unused ones. This will reduce the binary size.
> > > >
> > > > In the linker script mark that u_boot_sandbox_getopt are to be kept.
> > > >
> > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > > ---
> > > > v2:
> > > >       mark _u_boot_sandbox_getopt secitons a KEEP()
> > > > ---
> > > >  arch/sandbox/config.mk      | 4 +++-
> > > >  arch/sandbox/cpu/u-boot.lds | 6 +++---
> > > >  2 files changed, 6 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/arch/sandbox/config.mk b/arch/sandbox/config.mk
> > > > index 2d184c5f65..c02f0229c2 100644
> > > > --- a/arch/sandbox/config.mk
> > > > +++ b/arch/sandbox/config.mk
> > > > @@ -2,7 +2,7 @@
> > > >  # Copyright (c) 2011 The Chromium OS Authors.
> > > >
> > > >  PLATFORM_CPPFLAGS += -D__SANDBOX__ -U_FORTIFY_SOURCE
> > > > -PLATFORM_CPPFLAGS += -fPIC
> > > > +PLATFORM_CPPFLAGS += -fPIC -ffunction-sections -fdata-sections
> > > >  PLATFORM_LIBS += -lrt
> > > >  SDL_CONFIG ?= sdl2-config
> > > >
> > > > @@ -26,6 +26,7 @@ cmd_u-boot__ = $(CC) -o $@ -Wl,-T u-boot.lds $(u-boot-init) \
> > > >       $(KBUILD_LDFLAGS:%=-Wl,%) \
> > > >       $(SANITIZERS) \
> > > >       $(LTO_FINAL_LDFLAGS) \
> > > > +     -Wl,--gc-section \
> > > >       -Wl,--whole-archive \
> > > >               $(u-boot-main) \
> > > >               $(u-boot-keep-syms-lto) \
> > > > @@ -37,6 +38,7 @@ cmd_u-boot-spl = (cd $(obj) && $(CC) -o $(SPL_BIN) -Wl,-T u-boot-spl.lds \
> > > >       $(SANITIZERS) \
> > > >       $(LTO_FINAL_LDFLAGS) \
> > > >       $(patsubst $(obj)/%,%,$(u-boot-spl-init)) \
> > > > +     -Wl,--gc-section \
> > > >       -Wl,--whole-archive \
> > > >               $(patsubst $(obj)/%,%,$(u-boot-spl-main)) \
> > > >               $(patsubst $(obj)/%,%,$(u-boot-spl-platdata)) \
> > >
> > > There's already a call to --gc-sections for u-boot-spl on sandbox (in
> > > the last line of the link command).  We should probably move the main
> > > u-boot call there too, for consistency.
> >
> > For the moment I really don't want this in sandbox. I think I explain
> > that there is very little benefit in terms of size and it takes us
> > away from how native apps are normally built. It also seems to mask
> > problems in your CMDLINE series
>
> This fixes problems with sandbox not acting like a proper U-Boot target.
> It is not at all about size reduction, it's about being able to use
> normal conventions in U-Boot.

I've said everything I can say here. I would prefer not to go down
this path, but we can always try it and see what happens.

Regards,
Simon
