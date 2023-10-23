Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF19BC25B46
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 17:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 026F787938;
	Mon, 23 Oct 2023 19:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qq7aGP+n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE5A687934; Mon, 23 Oct 2023 19:14:12 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 209B387932
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 19:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c54c8934abso49789541fa.0
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 10:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698081249; x=1698686049; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nhgjwGzrm0UypzLxiyUSxbAAK1WPrbh2WeeQyZORS14=;
 b=Qq7aGP+n2G/hgF3zDXCfSh9aRIZHMVszLYfFi6Rm4t7EQ5/PCesJTO6UaXf7sSlnUc
 7g2+H3SmloxREFHOmHGp84F2PoLQVbo0q91BKAmWx5omfKmxb3pX8AYhBGifx9HDlN73
 DxV3hwxVbfpIAKJejYe6IoLnJYvPt4oOtb07s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698081249; x=1698686049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nhgjwGzrm0UypzLxiyUSxbAAK1WPrbh2WeeQyZORS14=;
 b=oDTRqVI9CCS7wZudyDs/zbJMxdMhX/LM16O0zBAqv96bF8D+b3a3vwcD8Rc3J0qSy+
 vxqBCt8aMjgF6wYlqO0N9jl30oYFuUeC+VgYZ2i9B6N3yBeG3J9SgmUzLjXP2F1rEQAc
 uTsum73h80f4HVUT5wnV3Wj9jd/zFG8QtVqB4RWm5koZVZ1nBgpa1YvulWsgdaLbzDog
 GdhXuwxYkAAMkLype1WdT7DOCenN39FsYaI83Z/0hF+3fiqBVTbWBL3eGWbVQq29IWux
 1b3aFllwLIauuN4zI7Pyyp38cnUMO/Xpu7mTlv9Cr9Wdj8EwXiMx7uoY8ytsrmztjAAP
 cxCQ==
X-Gm-Message-State: AOJu0YxzO5HiWNiZT4OM61D8QA2w8oWjstWTGZ5EILodNZOXohpHqp1J
 N7xWnwh+xOVLJJ8oIEPW8MmTdyZu2xvAHk8lIED+nA==
X-Google-Smtp-Source: AGHT+IH4BoM+omhrrAqKEqMN2j69DDsbEXe2YUr2keKJ3GNm+guQXbeVah1fkM1Nseq2edBU5AnPeQoe8sJe2LdsrXo=
X-Received: by 2002:a19:e04a:0:b0:507:a766:ad29 with SMTP id
 g10-20020a19e04a000000b00507a766ad29mr6516722lfj.12.1698081248761; Mon, 23
 Oct 2023 10:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231022233727.84947-1-heinrich.schuchardt@canonical.com>
 <20231023170258.GT496310@bill-the-cat>
In-Reply-To: <20231023170258.GT496310@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Oct 2023 10:13:55 -0700
Message-ID: <CAPnjgZ0Lbgmga7EhWPq3mThYih81Y18h0rHBL0Wdn=_nRU4NNQ@mail.gmail.com>
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

On Mon, 23 Oct 2023 at 10:03, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 23, 2023 at 01:37:27AM +0200, Heinrich Schuchardt wrote:
> > The sandbox should closely mimic other architectures.
> >
> > Place each function or data in a separate section and let the linker
> > eliminate unused ones. This will reduce the binary size.
> >
> > In the linker script mark that u_boot_sandbox_getopt are to be kept.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> > v2:
> >       mark _u_boot_sandbox_getopt secitons a KEEP()
> > ---
> >  arch/sandbox/config.mk      | 4 +++-
> >  arch/sandbox/cpu/u-boot.lds | 6 +++---
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/sandbox/config.mk b/arch/sandbox/config.mk
> > index 2d184c5f65..c02f0229c2 100644
> > --- a/arch/sandbox/config.mk
> > +++ b/arch/sandbox/config.mk
> > @@ -2,7 +2,7 @@
> >  # Copyright (c) 2011 The Chromium OS Authors.
> >
> >  PLATFORM_CPPFLAGS += -D__SANDBOX__ -U_FORTIFY_SOURCE
> > -PLATFORM_CPPFLAGS += -fPIC
> > +PLATFORM_CPPFLAGS += -fPIC -ffunction-sections -fdata-sections
> >  PLATFORM_LIBS += -lrt
> >  SDL_CONFIG ?= sdl2-config
> >
> > @@ -26,6 +26,7 @@ cmd_u-boot__ = $(CC) -o $@ -Wl,-T u-boot.lds $(u-boot-init) \
> >       $(KBUILD_LDFLAGS:%=-Wl,%) \
> >       $(SANITIZERS) \
> >       $(LTO_FINAL_LDFLAGS) \
> > +     -Wl,--gc-section \
> >       -Wl,--whole-archive \
> >               $(u-boot-main) \
> >               $(u-boot-keep-syms-lto) \
> > @@ -37,6 +38,7 @@ cmd_u-boot-spl = (cd $(obj) && $(CC) -o $(SPL_BIN) -Wl,-T u-boot-spl.lds \
> >       $(SANITIZERS) \
> >       $(LTO_FINAL_LDFLAGS) \
> >       $(patsubst $(obj)/%,%,$(u-boot-spl-init)) \
> > +     -Wl,--gc-section \
> >       -Wl,--whole-archive \
> >               $(patsubst $(obj)/%,%,$(u-boot-spl-main)) \
> >               $(patsubst $(obj)/%,%,$(u-boot-spl-platdata)) \
>
> There's already a call to --gc-sections for u-boot-spl on sandbox (in
> the last line of the link command).  We should probably move the main
> u-boot call there too, for consistency.
>

For the moment I really don't want this in sandbox. I think I explain
that there is very little benefit in terms of size and it takes us
away from how native apps are normally built. It also seems to mask
problems in your CMDLINE series

Regards,
Simon
