Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45CCCCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 13:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22D7D83977;
	Mon, 13 Oct 2025 15:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F0pOWAGF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1E1283965; Mon, 13 Oct 2025 15:41:38 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 301DA8383E
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 15:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-631787faf35so8368512a12.3
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 06:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760362896; x=1760967696; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M1eITCYmZX6O6TOCoM7idJ9RH3ITjso1LMOoIXdPrBU=;
 b=F0pOWAGF+fZMn9Q6aBqmiTKcWQ0+b3jV1D2TqIK2CWXZYESaCW9c9u/J4jLyTqLy54
 N0npUg116LLeKg6IhCr6MoBN8QRalVplmoes77cNSm5p3/8OgxULd+z5PKkFq48PzWUY
 ScyOOPfqax4eC+iM5yYU3nlAyd2yrN2c5BD0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760362896; x=1760967696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M1eITCYmZX6O6TOCoM7idJ9RH3ITjso1LMOoIXdPrBU=;
 b=g3D0W+EFgfc3C8yDmKIxNsWsH0hqWjtsvy/6sOVHCnRgklBxgIzpszJ7XmCrciwNY5
 F9orPKqAehNGk/nHfcTsdRRY+45oEmJU2mrbsMRwCMnmURH+yVt4EqsIw+TBXTAibjm0
 RfRf9DSDvhrUX8jYctMeMwhpxe3lcPQ5vmd4J6iqRW7Xt97Q+ANxUmuICcawtLmR5ms5
 AkXn1Z44ZlyW2YwaINcSeRJ0rYfQL0R/CSHWLB0q2oalbGH7ZT6XfJ6vqWhHMOBrP/2I
 hiZ/0pFJvzvpXE7ynNgTmXMp9YxB+phX3UbrE4Z8gvgPq5at0gtnGoWYpIVv9E/yx2uj
 NrDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSTZjrR25uw28a9fMAHrFnf3+DltONUhngoca1u/6U0VU5u8j2JknQbPNuCYoYFCi3lc5B4Kc=@lists.denx.de
X-Gm-Message-State: AOJu0Yyvs4IqpzEPZ+7q6tmpsvgMuJ5pc0HI6nOv4hEDRLut2ml113cF
 Am7aLWBipD0kfeaTzHfTd99oe6hZCRAShjV8QNsLI9VGfpakLD53AvNCJ3o4ivDrbIt1Vyv0rg0
 XYM5UnmGIlxibMeCEhwx/lkdRRebrmKqr5RDavGVY
X-Gm-Gg: ASbGnctlezCUDg74spedly4NDQEAO1wiItICEbw8urj+0TtE/91rg4q+c2ZhBxBb5eg
 KMHjIdBBZ9Nnr/tPmWlNqCXpnGoXRSD1oJEr0gn1Whr1pgRrSWbg2bhdCrHP3AFuXYg0HgAoJI+
 ZFcsNdPmztDjX8gkrUm5Rbfo+3s9MV4vp2hcGDUn/L8iUIhqYPk1hhPvxWyixD6Y+Ah27Y0TIsp
 lOfozH1YBC57q5T/MTfUGCfvJ8A17/y+6JvqyivAt+kHAS+k6Wc3TJMciKsGDDmqif/Qw==
X-Google-Smtp-Source: AGHT+IFY28zEDMDLi/7vbejdsy+0Ii9vF+t0eDTK2UFs3MOP97Y7etFeQNLbbs1SWoFvkJlcISBz4bl2a0On20xRLkA=
X-Received: by 2002:a05:6402:d0b:b0:637:e581:714b with SMTP id
 4fb4d7f45d1cf-639d5c44856mr19356301a12.21.1760362895613; Mon, 13 Oct 2025
 06:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20251012064412.2892979-1-sjg@chromium.org>
 <20251012064412.2892979-3-sjg@chromium.org>
 <88c25ace-fa91-4f30-8697-9f65cf98959b@gmx.de>
In-Reply-To: <88c25ace-fa91-4f30-8697-9f65cf98959b@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Oct 2025 14:41:22 +0100
X-Gm-Features: AS18NWC3AeWTg7dp7zbUt_btavbzMB7nYS5wdE50AQFRLAyj57TILz2Q2G2RySs
Message-ID: <CAFLszTgwZLiMpq6g6_ru4-CKWO4ATJbiDbxWLx3aiVfCiP9POw@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] boot: Move obtaining the label into a common file
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Mon, 13 Oct 2025 at 11:01, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/12/25 08:43, Simon Glass wrote:
> > The 'bootflow list' command supports looking at the EFI device-path when
> > available. Move this piece into a common function so it can be used
> > elsewhere.
> >
> > This updates the output from 'bootflow list'.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v5:
> > - Move 'usb' rename into a separate patch
> >
> >   boot/bootflow.c    | 16 ++++++++++++++++
> >   cmd/bootflow.c     |  8 +++++---
> >   include/bootflow.h |  8 ++++++++
> >   3 files changed, 29 insertions(+), 3 deletions(-)
> >
> > diff --git a/boot/bootflow.c b/boot/bootflow.c
> > index 15df7069209..6485d473d69 100644
> > --- a/boot/bootflow.c
> > +++ b/boot/bootflow.c
> > @@ -11,6 +11,7 @@
> >   #include <bootmeth.h>
> >   #include <bootstd.h>
> >   #include <dm.h>
> > +#include <efi_device_path.h>
> >   #include <env_internal.h>
> >   #include <malloc.h>
> >   #include <serial.h>
> > @@ -1010,3 +1011,18 @@ int bootflow_get_seq(const struct bootflow *bflow)
> >
> >       return alist_calc_index(&std->bootflows, bflow);
> >   }
> > +
> > +const char *bootflow_guess_label(const struct bootflow *bflow)
> > +{
> > +     const char *name = NULL;
>
> Why would you not return bootflow->name if it is allocated?

This is intended to show the label of the bootdev which produced the
bootflow. If you look below you can see that the bootflow name is
already shown, so we don't want to show it twice.

>
> > +
> > +     if (bflow->dev) {
> > +             struct udevice *media = dev_get_parent(bflow->dev);
> > +
> > +             name = dev_get_uclass_name(media);
> > +     }
> > +     if (!name)
> > +             name = "(none)";
>
> Label "(none)" makes no sense to bootflows created for BOOTMETHF_GLOBAL.
> Can't we return a string for the bootmeth instead?

Similarly, the bootmeth name is already shown. See below.

>
> > +
> > +     return name;
> > +}
> > diff --git a/cmd/bootflow.c b/cmd/bootflow.c
> > index 551dffbb8b8..5b803d4ace5 100644
> > --- a/cmd/bootflow.c
> > +++ b/cmd/bootflow.c
> > @@ -70,10 +70,12 @@ static void report_bootflow_err(struct bootflow *bflow, int err)
> >    */
> >   static void show_bootflow(int index, struct bootflow *bflow, bool errors)
> >   {
> > +     const char *name = bootflow_guess_label(bflow);
>
> Why would we guess a name if bflow->name != NULL?

It isn't the name we are trying to guess, it is the bootdev. We are
trying to show a friendly name for the bootdev.

>
> > +
> >       printf("%3x  %-11s  %-6s  %-9.9s %4x  %-25.25s %s\n", index,
> > -            bflow->method->name, bootflow_state_get_name(bflow->state),
> > -            bflow->dev ? dev_get_uclass_name(dev_get_parent(bflow->dev)) :
> > -            "(none)", bflow->part, bflow->name, bflow->fname ?: "");
> > +            bflow->method ? bflow->method->name : "(none)",
> > +            bootflow_state_get_name(bflow->state), name, bflow->part,
> > +            bflow->name, bflow->fname ?: "");
> >       if (errors)
> >               report_bootflow_err(bflow, bflow->err);
> >   }
> > diff --git a/include/bootflow.h b/include/bootflow.h
> > index 2ef6eb25cf5..657e3731f11 100644
> > --- a/include/bootflow.h
> > +++ b/include/bootflow.h
> > @@ -692,4 +692,12 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
> >    */
> >   int bootflow_menu_poll(struct expo *exp, int *seqp);
> >
> > +/**
> > + * bootflow_guess_label() - Produce a plausible label for a bootflow
> > + *
> > + * This uses the uclass name or EFI device-path to come up with a useful label
> > + * for display to the user. Ideally it will say "mmc", "usb", nvme", etc.
>
> Please, describe the fallback.
>
> The documentation is comprehensible but unfortunately incomplete for
> what we want to generate in doc/api
>
> Please, add '@bootflow:', 'Return:'.
> cf.
> https://www.kernel.org/doc/html/v4.16/doc-guide/kernel-doc.html#function-documentation
>

OK


> Best regards
>
> Heinrich
>
> > + */
> > +const char *bootflow_guess_label(const struct bootflow *bflow);
> > +
> >   #endif
>

Regards,
Simon
