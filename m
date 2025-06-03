Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEDCC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 15:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CB3F82BD6;
	Tue,  3 Jun 2025 17:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mjnCzAbl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A30BF82B48; Tue,  3 Jun 2025 17:22:22 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACCF382AA7
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 17:22:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-606bbe60c01so1494480a12.2
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 08:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748964140; x=1749568940; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nbllBhmzSx5V1PAyGr0qyNbVTqw8c9k+pvlIfcxRzFI=;
 b=mjnCzAbl0YINK+rl1ZYgOGlxIWc3Xu9YxylQRoJS0y7dI5dogzFtXPGPPYZb+iJOY/
 KKWusZAMNMsiAKDdQmNkA456zn4P5g2ZU6t+cO0I/J76GnQyVDPprAjUWXljk6sT+p3+
 AJjOySn+c8+l2TrmdLgsqxYY5KDt0WIEl0+Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748964140; x=1749568940;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nbllBhmzSx5V1PAyGr0qyNbVTqw8c9k+pvlIfcxRzFI=;
 b=TW1Y20zzufnZece3Kx0Zs+u5RXSAd4hK2IWqAA6hRap6/KDzcJRo9Z208FgIVTFTTK
 JWb/YuFxetURutvtkXagfdDiP0EJwm9MlFp98yIKuhLx9vPBmcXrGcAlaYHLXWAO76Uw
 1Z2JUxZAfTXRJ/rRYDVKlEVu8YfWmE1JVy/dNaiJmUytJ+mS4fjPQ/j4gf+eseqlSS2y
 lcrm/N0K+XaEnHLKKIIQW3Gu5FSwFmwQKSTcREJ1wV0Wnqv/jL83F5aPAvu0KIAX+zbe
 yaZc3vZhlVdzgH2mXpEXM4lNAeKBCg+wjeLg3eA8hjPQlhO57W4dfIUa/vFjIJk7OXLx
 xNAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7HTIm1BgWpykCIszrXA3Q5AG9UE9e56DXoT0ft1/ZEOYrz3KZ7/7IB0zP+DLxYZcoYD2Ovis=@lists.denx.de
X-Gm-Message-State: AOJu0YyfQ14Pcq25WX5qO3kSzxcU5S4+BmjqU6FeW5BDR0me2voK9Y4R
 CEYPxMjFBGURukhhpMAjnFoQVNYXnKXwuGu0mL2Tktu3jioGN9Y0o9zYsAKL8CYTA5SjdJT1ffM
 GhSY7KgjgGx6swkqZ+3H23Afk9v1YyrI0TgSqznl76Z6V2dKBtNM=
X-Gm-Gg: ASbGncvDbmG/JLIdaxo/i4EgZCgjsWCVcmBVkZUWgADJjLd6sIEpZzwoAckQaesV1EA
 ZOHSo49X3qmFtfsJawF/EGhxOkSAWywnHDnUk9b3bjfQOC4IxFgjX+UVxu2P8DQx+TKTiML4mXC
 upwcGb5qPbvVrwOFvuv0W8DsiKYrERQ/qrAw==
X-Google-Smtp-Source: AGHT+IGQpceKsBHuKCCf/OmorslqoJ6C3SMr/Llkdqi39wu1II5jzgi71jYeliRXdL9L5lHg4CVp3hCvxCjoB/XxoY0=
X-Received: by 2002:a05:6402:3593:b0:601:6c34:5ed2 with SMTP id
 4fb4d7f45d1cf-605b77213d4mr11919526a12.4.1748964140037; Tue, 03 Jun 2025
 08:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250520203515.25839-1-dev@benjarobin.fr>
 <CAFLszTigMGxSjxPZ44BUx4WoWqVdNY3p6AeQwy3xK3gJ+VccTw@mail.gmail.com>
 <20250523140801.GR100073@bill-the-cat>
In-Reply-To: <20250523140801.GR100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Jun 2025 09:22:06 -0600
X-Gm-Features: AX0GCFvP_LgFKLuZIMm77ovxHD3DNUkDjK2Souh8XtYq02dJ4SuXQED_QqE7WEw
Message-ID: <CAFLszThXfsaQ=7qoSBwhNyAmcFeHLac6Fx_w34b3PS5NcfwO6Q@mail.gmail.com>
Subject: Re: [PATCH v2] bootm: Fix bmi->images pointer not initialized in some
 cases
To: Tom Rini <trini@konsulko.com>
Cc: Benjamin ROBIN <dev@benjarobin.fr>, u-boot@lists.denx.de
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

On Fri, 23 May 2025 at 08:08, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 23, 2025 at 02:48:15PM +0100, Simon Glass wrote:
> > Hi Benjamin,
> >
> > On Tue, 20 May 2025 at 22:35, Benjamin ROBIN <dev@benjarobin.fr> wrote:
> > >
> > > When building with only bootz command, without bootm, images pointer
> > > inside bootm_info structure is not initialized. And since this structure
> > > is stored in stack, the generated error is kind of random, but most of
> > > the time this will generate: "ramdisk - allocation error".
> > >
> > > Also, after analysis, this problem could occur with the command booti,
> > > if the command bootm is disabled.
> > >
> > > Currently bootm_init() is called by: do_bootz(), do_bootm(), do_booti()
> > > and by do_stm32prog(). And all of these commands execute bootm_run_states()
> > > which access the images pointer stored into bootm_info structure.
> > >
> > > So, to fix this issue, just do the assignment unconditionally.
> > >
> > > Fixes: c2211ff65136 ("bootm: Add more fields to bootm_info")
> > > Signed-off-by: Benjamin ROBIN <dev@benjarobin.fr>
> > > ---
> > >  boot/bootm.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/boot/bootm.c b/boot/bootm.c
> > > index f6aa32746b7e..108ca7fb472e 100644
> > > --- a/boot/bootm.c
> > > +++ b/boot/bootm.c
> > > @@ -1169,8 +1169,7 @@ void bootm_init(struct bootm_info *bmi)
> > >  {
> > >         memset(bmi, '\0', sizeof(struct bootm_info));
> > >         bmi->boot_progress = true;
> > > -       if (IS_ENABLED(CONFIG_CMD_BOOTM))
> > > -               bmi->images = &images;
> > > +       bmi->images = &images;
> >
> > In my tree I have:
> >
> > if (IS_ENABLED(CONFIG_CMD_BOOTM) || IS_ENABLED(CONFIG_CMD_BOOTZ) ||
> >     IS_ENABLED(CONFIG_CMD_BOOTI) || IS_ENABLED(CONFIG_PXE_UTILS))
> >
> > but it seems that the few boards that didn't include boot/bootm.c have
> > been dropped, so your patch is fine.
>
> Yes, looking at the code, we should have always been doing the
> assignment as there's a few places where we reference bmi->images and
> not the global images, FYI.

My intent is to eventually drop the global, but that is a ways off.

Regards,
Simon
