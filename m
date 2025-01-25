Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4667C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 23:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 560D380F10;
	Sun, 26 Jan 2025 00:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k0F49k9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4309180F7A; Sun, 26 Jan 2025 00:00:22 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AABC80F85
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 00:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d982de9547so6209847a12.2
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 15:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737846018; x=1738450818; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JIpf/b3uGGu1eMZxvlKW7JcST4SWSwjaPTZV659JSdo=;
 b=k0F49k9gVBhZ8Zdg/ivUzui8dFxHeY5HA48gFG5PWrvhofvhB/RHrF4IByC5M53wts
 Di1DwNQ7+dBInt44ToYJcm67QK80mXcFq83Hbi0Bsh1/qADMZiPxAkxv7jSyvKBk5hYA
 IdfaHWkLziz6Ugu7CLun3mRWbWdqF1MxXvI1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737846018; x=1738450818;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JIpf/b3uGGu1eMZxvlKW7JcST4SWSwjaPTZV659JSdo=;
 b=g1c3a6HUI2SB5z5PyIokT6EaeTwJCqahOuO3G/fybT6PiShbeAXJffyDT8O7HV8EuH
 QeMjteqDoZcS5G5sbeYgII6mn6ahPdcnkMDi0wLVnjndzUhNj7UUQ/KBCZyi9RtT0BQ0
 vYkQVprzJyX20uhbSNK75nv4WVP3sWKCzV+838G0QitTMR9Lvcs5P2ZUDcdwPa6x1KVp
 O7BSW8WGEfJgpTDejveL/ybfqAT5mR4etLT9aMgZAQKDTSUCBxlhL0M9kxsiK1oWYkjP
 J6YxsVXXW9yT/oLK5csDbPyMvjmWbD3CnVM3bnNGLi/yk/TgH820e8zadj/LhTcZSjkc
 SUVQ==
X-Gm-Message-State: AOJu0YwasRLAMsQ9vD7XDG446avnDZYlbLvJg2HGUg3jhg+X+a69AZXK
 Z8jncoO7r4KfE0d7RwYR42838A38I7O9Bc7Ri5Ggf3SSOivJZ6k+M3ECrBXb32DD+yPFFkSsCET
 zdQaxu1u5eRKA4GFglVt2C3moWFP23eOvuBtLJrTYq+ZE5mQ=
X-Gm-Gg: ASbGnctwl8u/Ki9/kdXCeEAVQWm+SITyb0vMhYkG9K5w2fbK6CNLFgX8rDvP/o9zTIV
 DccuB3WgHqZe+DR9ybctQOIPjnL9q4eT3vXBfT9meE7tLhr9offZc+JVBBc9zOEpJK1YVMnxc8Q
 ==
X-Google-Smtp-Source: AGHT+IEzqMptMVDjxVfa5xI7zuzU6ZjkZ9/kNYIS/Y/DledNTJCYau7gf57c1kw3rtPz/7P2spXbq9Ma1yCTgv6a2+8=
X-Received: by 2002:a05:6402:2807:b0:5db:7316:6309 with SMTP id
 4fb4d7f45d1cf-5db7d2dc140mr31888765a12.7.1737846017673; Sat, 25 Jan 2025
 15:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-4-sjg@chromium.org>
 <20250125214317.GC60249@bill-the-cat>
In-Reply-To: <20250125214317.GC60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 16:00:05 -0700
X-Gm-Features: AWEUYZlpjkYFBO7y4KVierLXP0jyUSGSLzSqVQR271Oqz0kEMUoRmjf8Ruqf2K4
Message-ID: <CAFLszTg+ZFn55j31CZMisvjg-e25R+q57pW-Dt-6zFqjSVwwtw@mail.gmail.com>
Subject: Re: [PATCH 3/4] test/py: Show info about module-loading
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>
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

Hi Tom,

On Sat, 25 Jan 2025 at 14:43, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jan 25, 2025 at 02:31:38PM -0700, Simon Glass wrote:
> > It is sometimes tricky to figure out what modules test.py is loading
> > when it starts up. The result can be a silent failure with no clue as to
> > what when wrong.
> >
> > Add a section which lists the modules loaded as well as those not
> > found.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  test/py/conftest.py | 33 ++++++++++++++++++++-------------
> >  1 file changed, 20 insertions(+), 13 deletions(-)
> >
> > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > index 5096c20ed65..23435b7db3c 100644
> > --- a/test/py/conftest.py
> > +++ b/test/py/conftest.py
> > @@ -286,19 +286,26 @@ def pytest_configure(config):
> >      ubconfig = ArbitraryAttributeContainer()
> >      ubconfig.brd = dict()
> >      ubconfig.env = dict()
> > -
> > -    modules = [
> > -        (ubconfig.brd, 'u_boot_board_' + board_type_filename),
> > -        (ubconfig.env, 'u_boot_boardenv_' + board_type_filename),
> > -        (ubconfig.env, 'u_boot_boardenv_' + board_type_filename + '_' +
> > -            board_identity_filename),
> > -    ]
> > -    for (dict_to_fill, module_name) in modules:
> > -        try:
> > -            module = __import__(module_name)
> > -        except ImportError:
> > -            continue
> > -        dict_to_fill.update(module.__dict__)
> > +    not_found = []
> > +
> > +    with log.section('Loading lab modules', 'load_modules'):
> > +        modules = [
> > +            (ubconfig.brd, 'u_boot_board_' + board_type_filename),
> > +            (ubconfig.env, 'u_boot_boardenv_' + board_type_filename),
> > +            (ubconfig.env, 'u_boot_boardenv_' + board_type_filename + '_' +
> > +                board_identity_filename),
> > +        ]
> > +        for (dict_to_fill, module_name) in modules:
> > +            try:
> > +                module = __import__(module_name)
> > +            except ImportError:
> > +                not_found.append(module_name)
> > +                continue
> > +            dict_to_fill.update(module.__dict__)
> > +            log.info(f"Loaded {module}")
> > +
> > +        if not_found:
> > +            log.warning(f"Failed to find modules: {' '.join(not_found)}")
> >
> >      ubconfig.buildconfig = dict()
>
> We won't see this warning normally, only if some level of verbosity is
> used, yes? It's normal to not have both u_boot_boardenv files for
> example.

There is a '[-] Section: Loading lab modules' section so you only see
it if you open that.

I feel that test.py is a bit cryptic at present.

Regards,
Simon
