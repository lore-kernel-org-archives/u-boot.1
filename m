Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11814CD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CC5686D61;
	Thu, 21 Sep 2023 03:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WsyibXwQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 879F886D28; Thu, 21 Sep 2023 03:06:06 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9D2486D24
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-59c0b5f984aso5281807b3.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258357; x=1695863157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zo2D2hAb1mXrsYpPciEVf1kN0Usi9Gb/l35FFDHvDnY=;
 b=WsyibXwQzOZNDQRMqqLizHnVG+P4VFeywbut0Aez404qfoPo9vH7GWYjOSnsVdaVDl
 S+YVoHMMp3eYnl3p5ON4hW4FIqTYkeUKgH7q9FKpxdDBIoJnS5XAmomtwsoSKTV/DqPX
 6Ou4g5VtielcgYmOUCs+rED2PUyB1ID3dNQYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258357; x=1695863157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zo2D2hAb1mXrsYpPciEVf1kN0Usi9Gb/l35FFDHvDnY=;
 b=rcr484V6U4dfbq+9lEOrsUwAnlx0kJTWKMjdxj6rNo7bGkEGTPlgYnvZyjeUSovGAZ
 Jpqd07L5n6OQtyoxjAJOaQJ8ORS1RwrLL1tuiQd9UVpyhSvmgHK7R7xR2Zk4VXJW/Yhs
 a6NmqeMGKGJ8bjxbM5WaWv+JWbplPpe1Dx14UUfHleSSQ+CABD3q2ZJfbs/8LuNkfo0y
 CEuIEcaWbQ7kYBv50J6WufgQc3pg/srSArBHD2hFKyM0iNBHWVpWz4MbCOqWlLucohM0
 loODg9xhApcCkj/7WBKSqDTuov0LXxAYvGVg1XHfY9vBmJ2TMWZqcjdlZYthYYdh05Qr
 aubg==
X-Gm-Message-State: AOJu0YxnhpRLle/7OdddtOjjOwV4vOEVkU2qa791wvnyMyXazwwxHxiQ
 KHK2tc4uak98ndHile74SGFdWOUpWoq1rEO41lUwgQ==
X-Google-Smtp-Source: AGHT+IHrPY9yWbTpvO9+Nd1YoEE8Sn5NTT67qmUWJobVJ0hKzff1iEFV1zSF66H83OVR33ZmebSg9MrqTXf3fBcezbw=
X-Received: by 2002:a0d:fbc4:0:b0:59b:4bb2:fc2c with SMTP id
 l187-20020a0dfbc4000000b0059b4bb2fc2cmr3563517ywf.48.1695258357423; Wed, 20
 Sep 2023 18:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-10-sjg@chromium.org>
 <20230830213916.GL3101304@bill-the-cat>
In-Reply-To: <20230830213916.GL3101304@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:03:34 -0600
Message-ID: <CAPnjgZ165AgX0VTWWbHTiEfwP_R5qdwcUQKWoJ7x3G0PYHT3aw@mail.gmail.com>
Subject: Re: [PATCH 09/32] spl: Avoid an #ifdef when printing gd->malloc_ptr
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Bin Meng <bmeng@tinylab.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stefan Roese <sr@denx.de>
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

On Wed, 30 Aug 2023 at 15:39, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Aug 30, 2023 at 12:04:40PM -0600, Simon Glass wrote:
> > Use an accessor in the header file to avoid this.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  common/spl/spl.c                  | 9 +++++----
> >  include/asm-generic/global_data.h | 7 +++++++
> >  2 files changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > index f0a90c280da..f5cef81000c 100644
> > --- a/common/spl/spl.c
> > +++ b/common/spl/spl.c
> > @@ -876,10 +876,11 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
> >       } else {
> >               debug("Unsupported OS image.. Jumping nevertheless..\n");
> >       }
> > -#if CONFIG_VAL(SYS_MALLOC_F_LEN) && !defined(CONFIG_SPL_SYS_MALLOC_SIZE)
> > -     debug("SPL malloc() used 0x%lx bytes (%ld KB)\n", gd->malloc_ptr,
> > -           gd->malloc_ptr / 1024);
> > -#endif
> > +     if (IS_ENABLED(CONFIG_SYS_MALLOC_F) &&
> > +         !IS_ENABLED(CONFIG_SPL_SYS_MALLOC_SIZE))
> > +             debug("SPL malloc() used 0x%lx bytes (%ld KB)\n",
> > +                   gd_malloc_ptr(), gd_malloc_ptr() / 1024);
> > +
> >       bootstage_mark_name(get_bootstage_id(false), "end phase");
> >  #ifdef CONFIG_BOOTSTAGE_STASH
> >       ret = bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
> > diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> > index 8fc205ded1a..edf9ff6823f 100644
> > --- a/include/asm-generic/global_data.h
> > +++ b/include/asm-generic/global_data.h
> > @@ -573,6 +573,13 @@ static_assert(sizeof(struct global_data) == GD_SIZE);
> >  #define gd_malloc_start()    0
> >  #define gd_set_malloc_start(val)
> >  #endif
> > +
> > +#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> > +#define gd_malloc_ptr()              gd->malloc_ptr
> > +#else
> > +#define gd_malloc_ptr()              0L
> > +#endif
> > +
> >  /**
> >   * enum gd_flags - global data flags
> >   *
>
> This is another case where readability is not improved. I also have a
> bad feeling that changing that exact area had some unintended
> consequences from the compiler, that totally should not have happened.
> But maybe that was something in a similar code section instead.

The improvement is in the C file...here we have an accessor in the
header file as has been done elsewhere.

Do you have any more details on the problem you mention? I will align
the accessor to the struct member which should resolve it.

Regards,
Simon
