Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793E9C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 17:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEC3A80EEB;
	Sat, 15 Feb 2025 18:21:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PKE8w35E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06D8480EFB; Sat, 15 Feb 2025 18:21:58 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDCCB80EAF
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 18:21:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5ded46f323fso3608600a12.1
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 09:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739640115; x=1740244915; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4dpzxAotG91k7wKFSpEaITrRPFw35TLHBoz7mAj8CZ0=;
 b=PKE8w35EYXjxX5XWlUK2yqfIhU97c9GvXPnnZGvitijO7QsYt7XIDe3E3RGwz3mOfz
 u4/hGtX1YLU3UPySV5C3Gwc8pPilSlC5toPlQRjCasm4n8EvSa4R5yvs2AD6UTiAWNl/
 Ok9nuhkdNm0+JCVx75JT8Dx/T+CKajGFxebPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739640115; x=1740244915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4dpzxAotG91k7wKFSpEaITrRPFw35TLHBoz7mAj8CZ0=;
 b=SKscwmvFnuK4dP60TaG+swDXwcmEYbhojf/Smk0dLzsQDORev9OaR0MBjs8XorhUdX
 DBRYhmp01iVyfD0dVEqofiIrxRI501TR++KAgHaqOku/Fla7/seX55EV7KRCrfPn7md3
 dXHbY1UE7C1dkm4H1jrXQ7335kIzUgX8C4hOIZqynThBW33h5Bi1mu2oUFhWqoj+ZGaW
 GMCKVIWoJwmtucgg1JCYf+RjUqrOQb9jijOGRMgEVuBcLrxIy9I0SSRlmvuUgiQ9n0AH
 /pF4CMKacBSt+yYVRIWiAOgFm5+Tq1PfJ940w6fg4MSzYmQ+f5RKVXh0Yn6D6nPms759
 KF/A==
X-Gm-Message-State: AOJu0Yx09M99qd1l4WS/4I34UD+DBHt2XKvHx852ybIvj4Yar/izaCfQ
 sWc0GZSqZgY0N/X/4w4C0eJQ78Haq3X/Q2MDr07C1BIlqUAxk8PedNnMdMhYKpBoy+B7hp2THbo
 +Zt9Ycq23s/ArRhaDAGx3IT59kGPAaZr/kHwMz+tufuMYfHk=
X-Gm-Gg: ASbGncv92Fj001RS/aaBdHELCZvKE77EQkZa0wNJEyGe/nwnuN7Q0e2e4Rmm66jg4DB
 uHXRtjcsWKoz66aJdyLX+wtnvYUKrBNGWSCJycvU6Xl0k4NWLb2jiqJ1nqwIzhgZ7Uc4W0y3B9A
 ==
X-Google-Smtp-Source: AGHT+IFL64SZE2ejxSuY5OoE9SImJOTiW2+yMv4gOyU3tCLe9aqVcYlWz7KPZl/XBXv1VAos865AuCTCzod6NQD9pgk=
X-Received: by 2002:a17:907:1b2a:b0:ab7:f096:61d0 with SMTP id
 a640c23a62f3a-abb70dde454mr332568366b.45.1739640115220; Sat, 15 Feb 2025
 09:21:55 -0800 (PST)
MIME-Version: 1.0
References: <20250209160725.1054845-1-sjg@chromium.org>
 <20250209160725.1054845-6-sjg@chromium.org>
 <20250210155252.GL1233568@bill-the-cat>
 <CAFLszTh=AuLyxUhpR5FbWbvS6xkwnnhA1Hf-nuMd+7=wOZZyNg@mail.gmail.com>
 <20250215144856.GO1233568@bill-the-cat>
In-Reply-To: <20250215144856.GO1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 10:21:43 -0700
X-Gm-Features: AWEUYZngLjPdGwGggUmncmLO73b3Ohv-NdFLOVZF8LtOYcmRIvNQldLkPcZ1fb8
Message-ID: <CAFLszThWr3z_GHp1vbubgKdX4hrW4vafetA=VzGpiZ5-K0+cyw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] test/py: Show info about module-loading
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

On Sat, 15 Feb 2025 at 07:49, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Feb 15, 2025 at 05:17:48AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 10 Feb 2025 at 08:52, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Feb 09, 2025 at 09:07:18AM -0700, Simon Glass wrote:
> > >
> > > > It is sometimes tricky to figure out what modules test.py is loading
> > > > when it starts up. The result can be a silent failure with no clue as to
> > > > what when wrong.
> > > >
> > > > Add a section which lists the modules loaded as well as those not
> > > > found.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  test/py/conftest.py | 33 ++++++++++++++++++++-------------
> > > >  1 file changed, 20 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > > > index 8d0e786ee5c..e59897c1f78 100644
> > > > --- a/test/py/conftest.py
> > > > +++ b/test/py/conftest.py
> > > > @@ -289,19 +289,26 @@ def pytest_configure(config):
> > > >      ubconfig = ArbitraryAttributeContainer()
> > > >      ubconfig.brd = dict()
> > > >      ubconfig.env = dict()
> > > > -
> > > > -    modules = [
> > > > -        (ubconfig.brd, 'u_boot_board_' + board_type_filename),
> > > > -        (ubconfig.env, 'u_boot_boardenv_' + board_type_filename),
> > > > -        (ubconfig.env, 'u_boot_boardenv_' + board_type_filename + '_' +
> > > > -            board_identity_filename),
> > > > -    ]
> > > > -    for (dict_to_fill, module_name) in modules:
> > > > -        try:
> > > > -            module = __import__(module_name)
> > > > -        except ImportError:
> > > > -            continue
> > > > -        dict_to_fill.update(module.__dict__)
> > > > +    not_found = []
> > > > +
> > > > +    with log.section('Loading lab modules', 'load_modules'):
> > > > +        modules = [
> > > > +            (ubconfig.brd, 'u_boot_board_' + board_type_filename),
> > > > +            (ubconfig.env, 'u_boot_boardenv_' + board_type_filename),
> > > > +            (ubconfig.env, 'u_boot_boardenv_' + board_type_filename + '_' +
> > > > +                board_identity_filename),
> > > > +        ]
> > > > +        for (dict_to_fill, module_name) in modules:
> > > > +            try:
> > > > +                module = __import__(module_name)
> > > > +            except ImportError:
> > > > +                not_found.append(module_name)
> > > > +                continue
> > > > +            dict_to_fill.update(module.__dict__)
> > > > +            log.info(f"Loaded {module}")
> > > > +
> > > > +        if not_found:
> > > > +            log.warning(f"Failed to find modules: {' '.join(not_found)}")
> > >
> > > Since no platform contains all of those files this is too verbose.
> >
> > So perhaps only show the message if all files are missing?
>
> Sure. Or a log.debug maybe?

The log.debug() doesn't show up though and people wouldn't know where
to look. So if you are OK with having the message only if there is
nothing, I will do that.

Regards,
SImon


>
> --
> Tom
