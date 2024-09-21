Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC67FCF9C5B
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 11:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 127F38839A;
	Sat, 21 Sep 2024 13:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KDT8AeRI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88FBC88413; Sat, 21 Sep 2024 13:38:05 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF490880A7
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 13:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7a9b72749bcso258147685a.0
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726918682; x=1727523482; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fCY0p3wJYVng114upsVEmMUz9yTCak4if8cQEfyV8pE=;
 b=KDT8AeRIipKWNL/02acPhXEOaG88CJ4rZtDtg+Jrisb39xn1LB6c2cFLwIgfBOANpJ
 r/aO+IDV2Z8SaFBSE/TO8ED6HLLG5mUU3rCaATbWv2SbVZGPtGpxDVUCu7ivHw4aLaUg
 2ULJ+rjiqP7sBsv/XnK7TQSDR21emJPFfzWtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726918682; x=1727523482;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fCY0p3wJYVng114upsVEmMUz9yTCak4if8cQEfyV8pE=;
 b=Ht6wP68rw7GBQg78abIz9eKqRjJjpmbTM8S7HZNEBVDWAuHASZMjnPQcbvKPZLORvg
 xRD4GYvVzY2jnklWZsFyOkYRH4k2k7/76FGOb8iaIxvndfe/Z4CjUZabhiNCM+ErvsLL
 tsYTFnEG7TtwVzQmua0G1+4j84jiKqzXTSFEeqyB8yBI40Nz+GfTRDHq5TevGYjdEqbQ
 DTR3vUjmACpWphE8pG3mBI1cKE1saHSW/KNe6nhOJeKWU9m0vsgJ86JvXhMmo7ZC6o6T
 EtweyHXELejFi4IBtRac4lhC9sPnaYRyDnib37TkdwXHMP/2ubnw2ZglKFvD08k+7D7n
 WPsw==
X-Gm-Message-State: AOJu0YzA6VvCn4gxf+jba6qZbpHfgJeZP6c/7T+p5CQaCm4ENlg4tsMQ
 ztgNUy1bAUHUJzxg2uGWF8gZlyI5IkPqKBxZ51qeluWFhsYP/UaQ0JFuoatWW/XcwJMxqpt4sN0
 gTciV7+zsG2SyX1bhleJ0S8JvKFqf1EKxzR0NRdbXZFduH0AGXpwe5nw=
X-Google-Smtp-Source: AGHT+IE5kgGniuELg4y+DnncsWP1TknjDszw5FoMKNNe+Dv2MCVGbqgQolmfwIJj7ctNOOpk49w8F8D+OvOk88sp8ho=
X-Received: by 2002:a05:6214:3f88:b0:6c7:c777:1a8e with SMTP id
 6a1803df08f44-6c7c7771b86mr46363236d6.49.1726918681821; Sat, 21 Sep 2024
 04:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240829145802.1827952-1-sjg@chromium.org>
 <20240829145802.1827952-7-sjg@chromium.org>
 <20240829172626.GK2479150@bill-the-cat>
 <CAFLszThacdwBNMP8Rq3uEXd=MT-8NpVXHOjhcMrdvLR-KrNPXg@mail.gmail.com>
 <20240920145942.GC4252@bill-the-cat>
 <CAFLszThSLXLOxMVQBCwpuLEOm6CPx0N-p2taz9Z6NEw1-P86Gg@mail.gmail.com>
 <20240920163510.GG4252@bill-the-cat>
In-Reply-To: <20240920163510.GG4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 21 Sep 2024 13:37:51 +0200
Message-ID: <CAFLszTgAZ8BiiU6iEUJ9e4A1mFXMOA=ukBoPpX9AYSt8+fh_EQ@mail.gmail.com>
Subject: Re: [PATCH 06/19] malloc: Show amount of used space when memory runs
 out
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

On Fri, 20 Sept 2024 at 18:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Sep 20, 2024 at 06:04:01PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 20 Sept 2024 at 16:59, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Sep 20, 2024 at 09:25:44AM +0200, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 29 Aug 2024 at 19:26, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Aug 29, 2024 at 08:57:49AM -0600, Simon Glass wrote:
> > > > > > Show a bit more information when malloc() space is exhausted and
> > > > > > debugging is enabled.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > >  common/malloc_simple.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/common/malloc_simple.c b/common/malloc_simple.c
> > > > > > index 5a8ec538f8f..f2b3dc53689 100644
> > > > > > --- a/common/malloc_simple.c
> > > > > > +++ b/common/malloc_simple.c
> > > > > > @@ -26,7 +26,8 @@ static void *alloc_simple(size_t bytes, int align)
> > > > > >       log_debug("size=%lx, ptr=%lx, limit=%x: ", (ulong)bytes, new_ptr,
> > > > > >                 gd->malloc_limit);
> > > > > >       if (new_ptr > gd->malloc_limit) {
> > > > > > -             log_err("alloc space exhausted\n");
> > > > > > +             log_err("alloc space exhausted %lx %x\n", new_ptr,
> > > > > > +                     gd->malloc_limit);
> > > > > >               return NULL;
> > > > > >       }
> > > > >
> > > > > Since debugging is enabled you should update the error message to say
> > > > > what the values mean...
> > > >
> > > > OK, will do. This message is shown without debugging enabled, so I do
> > > > want to keep it short.
> > >
> > > The commit message says "and debugging is enabled", so is that the case
> > > or not?
> >
> > Oh, I see. It should say 'not' :-) I will send a new patch.
>
> Thanks!

OK done, it is here:

https://patchwork.ozlabs.org/project/uboot/patch/20240921113450.319072-6-sjg@chromium.org/

Regards,
Simon
