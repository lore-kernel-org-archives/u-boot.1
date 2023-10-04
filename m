Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8457DE8FDC3
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 02:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A02087493;
	Wed,  4 Oct 2023 04:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MUc/95GE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B3AD874AC; Wed,  4 Oct 2023 04:12:27 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7570887479
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 04:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5a2536adaf3so19905437b3.2
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 19:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696385541; x=1696990341; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1qnbcWbk0JqTVsX6yUJIZFevfvA3v6KLo242kxa5d7g=;
 b=MUc/95GEdzpo7m6x34Z7YfaIkYSZ1pmOlGnbFFRu2Rvd7CJH8MQduPdUxIF3G8MR6+
 SKugh1ZF8PNn5OMjNFb0Htr8SeGKWUwid7NPTBTiaKz4/W+zkEGYsKaXO4Gp54f9q3rP
 Cg/S3MnRb5Sy/uLl7kvbV9jGrFLqZ/gDmiy1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696385541; x=1696990341;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1qnbcWbk0JqTVsX6yUJIZFevfvA3v6KLo242kxa5d7g=;
 b=l0LqSWk9+lyL+krsYuhLtOlOcfvDOM9MIH79DNGgXV63OLZsp/DNW5Q48Rhspu+QwQ
 sfWzfRzY0QAyVgDrsTR2soG6yWEiRrIgJthHqkdJahU+7Ao5VxaWxQBag61maYLsFWEV
 VRYr8OpM5WoHLX9w5txMtPpL0xVYGbfi25FofzulItOo2sFY+A4ts7ee1XOyFZe98jbV
 N5a+aPdSOL1EFkz1H+qdiCQeg/zl/J0ONeSdKVVt9cYK/VW0XRoyORltoxRM06xjo2oa
 P2MrZq9hk+utCe4jo4WIkpF6iM/qY2qexKqWFOnIMsO1VDsl2lyFFEJbdCXFbbd+vk1y
 a+gg==
X-Gm-Message-State: AOJu0Ywq51iRnYBAi6t04vGDnkoOgEyaM1Pn0J0DzUZxRFL6Xn6aQN0/
 hBRkdMCWSYhYF9n39UrCWA7Ay9em0A2KD61U7ho4gD9Vmd3cOpwHoJo=
X-Google-Smtp-Source: AGHT+IFkc2c5eWBJTsWCHPWMqYcP4WRQrYlSZ+fqQlx9qhKRYhWUmmNnGyOhTKplPmuZRnT9iSI3wy4ZUKfBn5BuJj0=
X-Received: by 2002:a0d:dec7:0:b0:59e:9a44:9db9 with SMTP id
 h190-20020a0ddec7000000b0059e9a449db9mr1175320ywe.26.1696385540450; Tue, 03
 Oct 2023 19:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-4-sjg@chromium.org>
 <20230925003959.GO305624@bill-the-cat>
In-Reply-To: <20230925003959.GO305624@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Oct 2023 20:11:11 -0600
Message-ID: <CAPnjgZ1Mxf_1G0-q0mLTehO2gZriaKWH7VfW5J9H_g-Y3u16_A@mail.gmail.com>
Subject: Re: [PATCH 03/25] autoboot: Correct dependencies on CMDLINE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Sun, 24 Sept 2023 at 18:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Sep 24, 2023 at 02:39:21PM -0600, Simon Glass wrote:
>
> > Make AUTOBOOT depend on CMDLINE since it is mostly meaningless without it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  boot/Kconfig | 23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index f74ac7e9cc72..41ec2c34bf74 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -1167,14 +1167,16 @@ menu "Autoboot options"
> >
> >  config AUTOBOOT
> >       bool "Autoboot"
> > +     depends on CMDLINE
> >       default y
> >       help
> >         This enables the autoboot.  See doc/README.autoboot for detail.
>
> This is fine and correct.
>
> > +if AUTOBOOT
> > +
> >  config BOOTDELAY
> >       int "delay in seconds before automatically booting"
> >       default 2
> > -     depends on AUTOBOOT
> [snip]
> > @@ -1322,6 +1324,9 @@ config AUTOBOOT_STOP_STR_SHA256
> >         includes a ":", the portion prior to the ":" will be treated
> >         as a salt value.
> >
> > +endif  # AUTOBOOT_KEYED
> > +endif  # AUTOBOOT
>
> So it's ~200 lines, yes, hiding this under an if, or perhaps a menu
> makes sense, however...
>
> >  config AUTOBOOT_USE_MENUKEY
> >       bool "Allow a specify key to run a menu from the environment"
> >       depends on !AUTOBOOT_KEYED
>
> It looks like there's more stuff to move under a menu/if here?

Well this depends on !AUTOBOOT_KEYED so can't be in the 'if
AUTOBOOT_KEYED'. But yes I can create a new 'if !AUTOBOOT_KEYED' for
these two items. Normally we want 2-3 options to warrant an 'if', so I
don't see this as a strong case.

Regards,
Simon
