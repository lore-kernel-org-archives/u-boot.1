Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9024FE776CB
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 23:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 090D487120;
	Tue,  3 Oct 2023 01:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="dplCCNnZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F249887184; Tue,  3 Oct 2023 01:11:43 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1769386C59
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 01:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9b275afb6abso814528766b.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 16:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696288301; x=1696893101; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LmvVESK/g262JdCF472UxMcEBE43VtE0HPV8+yl0GvE=;
 b=dplCCNnZ3dQSYG+VTWqrQ2CxjtjIDNW9I/Ad06PiN0SrJ0j/T1wrFCbm0cyyFU7wDM
 FlcPVH/EohQVoKCJO+uZg7Nc0cQe2PobBiihhw3vfMQV/o9Uty37/zfbJoBptuILzFX3
 1S8i2+su0AHb/ujZENzMv6VVnOBwaQjULkcQSVn0/9NtQv/BoVnyLzdHtTWDZS/dGOdD
 rFz9fOWxGZdD4J8gU7EtAM5bEXaZVOo354DS8bC9vVBLom3sZQWn632+vUX1YFQGeBdR
 OgbJVOJ4vSw5F0YpiBopu1/Inal3TP7YOslzrJCaGv3rJYow2VRn5z7c9yQshB3riKt7
 9INQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696288301; x=1696893101;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LmvVESK/g262JdCF472UxMcEBE43VtE0HPV8+yl0GvE=;
 b=E36W+1oymGBcd6H0GApjvmUNxSvwYsQCxVnS9uYobSaFyBIGNk3SBoaYpIWF5wbMh0
 Cfwgk2GIO3WqNH1FhK7DBZ8Kuj9aeFgesddV8dzsl9XVBezWtVmiLaXaTaJHpcbh7N0/
 NYG1sVd6jWZQpULPzPsLYu4o+iILtYpdcxXHafULXKJpnJebhCmtFs+NW/OcmyBReVnC
 Ek6he/gucLSijqpS6K80kHxTiGqdBDdKp63T/14xQnymgRX5BGEPeyRd4iKJNQHI0hkY
 9zhdF4NZ/MlzCYoGZzTzXG09zRhvwhf5q3oHNW2ws6PzzuQSSIzJURBOLJN411jg6Q6B
 WJQQ==
X-Gm-Message-State: AOJu0YzhJVTylQLyKsOGCHdcErX+CrWIqq/BjTGxjnlsP1w2Y65Ei4lO
 d4bpJmmGK68vsSq2cTtBLEls6iHOjvc7a6YhkUEKRHDCrigphy6ZgOQ=
X-Google-Smtp-Source: AGHT+IHsMdbn3vAbzTwY1EQ/+m/32WQgsvKx1vQAlhjLnGJ/uIflcCymcZK5adAY+a02IdmCbQJlxo8Yf42T9O8FSF4=
X-Received: by 2002:a17:907:784b:b0:9a1:b144:30f4 with SMTP id
 lb11-20020a170907784b00b009a1b14430f4mr999366ejc.14.1696288301407; Mon, 02
 Oct 2023 16:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231002222725.25125-1-heinrich.schuchardt@canonical.com>
 <20231002224641.GB8465@bill-the-cat>
In-Reply-To: <20231002224641.GB8465@bill-the-cat>
From: Simon Glass <sjg@google.com>
Date: Mon, 2 Oct 2023 17:11:30 -0600
Message-ID: <CAPnjgZ06=_xW5totG-nu1xtoDLF=Q7Rr8BaMLF22VEF0+9xSgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] input: avoid NULL dereference
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

Hi Tom,

On Mon, 2 Oct 2023 at 16:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 03, 2023 at 12:27:25AM +0200, Heinrich Schuchardt wrote:
> > Before using the result of env_get("stdin") we must check if it is NULL.
> >
> > Avoid #if. This resolves the -Wunused-but-set-variable issue and we don't
> > need a dummy assignment in the else branch. Anyway this warning is
> > disabled in the Makefile.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> > v2:
> >       Avoid #if.
> > ---
> >  drivers/input/input.c | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/input/input.c b/drivers/input/input.c
> > index a4341e8c7c..de62189782 100644
> > --- a/drivers/input/input.c
> > +++ b/drivers/input/input.c
> > @@ -669,17 +669,19 @@ int input_stdio_register(struct stdio_dev *dev)
> >       int error;
> >
> >       error = stdio_register(dev);
> > -#if !defined(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)
> > -     /* check if this is the standard input device */
> > -     if (!error && strcmp(env_get("stdin"), dev->name) == 0) {
> > -             /* reassign the console */
> > -             if (OVERWRITE_CONSOLE ||
> > -                             console_assign(stdin, dev->name))
> > -                     return -1;
> > +     if ((IS_ENABLED(SPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)) &&
> > +         !error) {
> > +             const char *cstdin;
> > +
> > +             /* check if this is the standard input device */
> > +             cstdin = env_get("stdin");
> > +             if (cstdin && !strcmp(cstdin, dev->name)) {
> > +                     /* reassign the console */
> > +                     if (OVERWRITE_CONSOLE ||
> > +                         console_assign(stdin, dev->name))
> > +                             return -1;
> > +             }
> >       }
> > -#else
> > -     error = error;
> > -#endif
> >
> >       return 0;
> >  }
>
> This is an example I think of where #if is more readable.

I have seen you make this comment a bit, lately. I would have thought
that dropping a build path would be a win...is it the extra
indentation you don't like?

Regards,
Simon
