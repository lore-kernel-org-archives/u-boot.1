Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70719CD4850
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 18:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01E6986BB3;
	Fri, 22 Sep 2023 20:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h3TGlj+i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA73C86B5E; Fri, 22 Sep 2023 20:29:19 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6D7186B82
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 20:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-579de633419so30401037b3.3
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695407354; x=1696012154; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cGcWrW8MD+HlW/z/IFj830YzAykR6TGoY0PXL6r1u14=;
 b=h3TGlj+i3cmFQJwJnUT7ySJexpCSlyHtesTDlgeoRERyjYj7xo4qE9rBqhDEOUaYJZ
 sYW0bba30u01rwW01TPFGnJz7hSkJmf04KAiqGE3rhPAnJLH+mAPQuLBX7NpBz8IwAmQ
 JtMw1ApxTKHvGpN8S4shuRxB3Gkf5tksuR+Tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695407354; x=1696012154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cGcWrW8MD+HlW/z/IFj830YzAykR6TGoY0PXL6r1u14=;
 b=mIxML/p6vx7i4OiUnfo8380sx+uimKTu+KBg0uB6vnoh36df04vMdrUdJIt2qCfZyY
 C2AQHAwO4elBzoxAQlIDU2yVjWVvGeIfZEr7G93VFI5NxtnJ3q+TYT2sGr/7Axlz53zq
 WY8Ro2r71Hsb7GRGBABUsQ2qYhRbsbqi6h3eAw9pWHVOVVO4RtcYgjlmwWlEjpgQwiuR
 At0xp4moLAcyzlQTouk7wrSE25jcwe+ZjBlriireFOeWRxt60uroDDl9bGjCVe+rylLZ
 jNljj9o/S4HulRZVafYm8297SvE0nlcgrNgEwAxhbOGaDg2uR41iqfFze/xsvhAaQRSH
 EBgw==
X-Gm-Message-State: AOJu0YxMFCgLs/ga8s+cuhS+t8CEm0g5mQbPkcUBXYnXAFwhFyqY0fiN
 QpDOyGu3qiHBdJcQli5/xoTtMEJ20ge1gJOTdNxuydF6tu3qKp/4a6Y=
X-Google-Smtp-Source: AGHT+IFN9DmdoNcjew6FIMk1Qrngh9kxNtr3UP3sr0cRYjFnvBYyzAq3Cj9QLXYV2YUlQ2FtIKc6G01cOQPxHuYz214=
X-Received: by 2002:a0d:e8cc:0:b0:586:9c4b:95fb with SMTP id
 r195-20020a0de8cc000000b005869c4b95fbmr638319ywe.19.1695407354415; Fri, 22
 Sep 2023 11:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-10-sjg@chromium.org>
 <20230830213916.GL3101304@bill-the-cat>
 <CAPnjgZ165AgX0VTWWbHTiEfwP_R5qdwcUQKWoJ7x3G0PYHT3aw@mail.gmail.com>
 <20230921153557.GR305624@bill-the-cat>
In-Reply-To: <20230921153557.GR305624@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 12:27:36 -0600
Message-ID: <CAPnjgZ0ZqySaVa6LKWz7p7h8gjH1yTsLtds_8hF+DEXQGC459g@mail.gmail.com>
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

On Thu, 21 Sept 2023 at 09:36, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Sep 20, 2023 at 07:03:34PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 30 Aug 2023 at 15:39, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Aug 30, 2023 at 12:04:40PM -0600, Simon Glass wrote:
> > > > Use an accessor in the header file to avoid this.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  common/spl/spl.c                  | 9 +++++----
> > > >  include/asm-generic/global_data.h | 7 +++++++
> > > >  2 files changed, 12 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > > > index f0a90c280da..f5cef81000c 100644
> > > > --- a/common/spl/spl.c
> > > > +++ b/common/spl/spl.c
> > > > @@ -876,10 +876,11 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
> > > >       } else {
> > > >               debug("Unsupported OS image.. Jumping nevertheless..\n");
> > > >       }
> > > > -#if CONFIG_VAL(SYS_MALLOC_F_LEN) && !defined(CONFIG_SPL_SYS_MALLOC_SIZE)
> > > > -     debug("SPL malloc() used 0x%lx bytes (%ld KB)\n", gd->malloc_ptr,
> > > > -           gd->malloc_ptr / 1024);
> > > > -#endif
> > > > +     if (IS_ENABLED(CONFIG_SYS_MALLOC_F) &&
> > > > +         !IS_ENABLED(CONFIG_SPL_SYS_MALLOC_SIZE))
> > > > +             debug("SPL malloc() used 0x%lx bytes (%ld KB)\n",
> > > > +                   gd_malloc_ptr(), gd_malloc_ptr() / 1024);
>
> This is not more readable.  But I guess my comment was unclear as you're
> mixing changes here.  gd_malloc_ptr() rather than gd->malloc_ptr is a
> wash, to me.  I think one could argue it's not a helpful abstraction.
> but it's so that you can avoid CONFIG_VAL here, and say "if (...)" not
> "#if ..." here.

Yes,

>
> > > > +
> > > >       bootstage_mark_name(get_bootstage_id(false), "end phase");
> > > >  #ifdef CONFIG_BOOTSTAGE_STASH
> > > >       ret = bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
> > > > diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> > > > index 8fc205ded1a..edf9ff6823f 100644
> > > > --- a/include/asm-generic/global_data.h
> > > > +++ b/include/asm-generic/global_data.h
> > > > @@ -573,6 +573,13 @@ static_assert(sizeof(struct global_data) == GD_SIZE);
> > > >  #define gd_malloc_start()    0
> > > >  #define gd_set_malloc_start(val)
> > > >  #endif
> > > > +
> > > > +#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> > > > +#define gd_malloc_ptr()              gd->malloc_ptr
> > > > +#else
> > > > +#define gd_malloc_ptr()              0L
> > > > +#endif
> > > > +
> > > >  /**
> > > >   * enum gd_flags - global data flags
> > > >   *
> > >
> > > This is another case where readability is not improved. I also have a
> > > bad feeling that changing that exact area had some unintended
> > > consequences from the compiler, that totally should not have happened.
> > > But maybe that was something in a similar code section instead.
> >
> > The improvement is in the C file...here we have an accessor in the
> > header file as has been done elsewhere.
> >
> > Do you have any more details on the problem you mention? I will align
> > the accessor to the struct member which should resolve it.
>
> It's unfortunately one of those cases to do a global before/after build
> and see if anything does or does not get tripped up.  As I believe I did
> use CONFIG_VAL there and not a check on CONFIG_SYS_MALLOC_F itself for a
> reason, at the time.

But the CONFIG_VAL symbols actually depends on CONFIG_SYS_MALLOC_F, so
I can't imagine what it might be. Of course if the value is 0, then
the 'if CONFIG_VAL()' test would fail, but to what purpose?

Regards,
Simon
