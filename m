Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2444CCE7A88
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 23:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 177A386898;
	Sat, 23 Sep 2023 01:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cXdN9Quh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84E79865D0; Sat, 23 Sep 2023 01:06:33 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CAA686898
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 01:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c007d6159aso49101401fa.3
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695423991; x=1696028791; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W0NR8LFgIcCGtwrSQyZE+8pp5k90FLXFV/LOpc2i2xs=;
 b=cXdN9Quhw2r1QrJd1Al5d46a8C14HaRCKavYHxw4nKV6IVA+Zr9qaAWdlE6UaEeVh7
 UzSsYKD/R2XBO/42jXI2pnr0uDnnuPnMoZGbnMSd6X+PhHbC/MZxZm9dMqagGjeNZUw7
 iCLP87ZjnJWa6pCjOcIy6/IEuPJ4GYOkn40so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695423991; x=1696028791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W0NR8LFgIcCGtwrSQyZE+8pp5k90FLXFV/LOpc2i2xs=;
 b=t/fjkIZ4tSq+P5TjgpE7/bY824sB1zLUTffBdbLfXBKlxGzLxIUil35/zLO2LNeaDG
 u2LLtjQb5awGLnk7f1ZMQlfT+P+cCIQ9pHcofb7PTbTpMXUQFBLs9NVKySFnlVwF9GQW
 Mk7lkFGZCdodMNNzZq7vjXruTtnBxs2GZ74XCqjHofkVb/OJN8tlhVx5uusETbJsdzZx
 3yH5Rh9dvFobaM3KT3e6O0iXTE9ssLG8S4nJNA5uEVdjJ7rJfo6TqxC0U6bqAQrM4aY5
 5P2/O0fZARqH1WZ4FYixs3VAD/lAI5msApzJ7P/2P+RWFw3a8okjsSOmDe2RmLU7Xc6v
 ryOw==
X-Gm-Message-State: AOJu0YyyqYn2UJdhIMvkfwKyZ8hBAULYg0wz4l8XwE9oSvab6hGbU1u0
 LPzUlpV/tyQRpagMmr/hXg28NfAvO7g3b9lOt4ewng==
X-Google-Smtp-Source: AGHT+IHRsch5Hip/MQzJISHqTJISfJXDkjJoqUJVrz/QrKVk5o/KuESW0+AAqDfWBKKk9bvEE89Ov21/b0BX3ZazEVg=
X-Received: by 2002:a2e:99d4:0:b0:2bc:c490:10cf with SMTP id
 l20-20020a2e99d4000000b002bcc49010cfmr503887ljj.18.1695423990361; Fri, 22 Sep
 2023 16:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-10-sjg@chromium.org>
 <20230830213916.GL3101304@bill-the-cat>
 <CAPnjgZ165AgX0VTWWbHTiEfwP_R5qdwcUQKWoJ7x3G0PYHT3aw@mail.gmail.com>
 <20230921153557.GR305624@bill-the-cat>
 <CAPnjgZ0ZqySaVa6LKWz7p7h8gjH1yTsLtds_8hF+DEXQGC459g@mail.gmail.com>
 <20230922192847.GD305624@bill-the-cat>
In-Reply-To: <20230922192847.GD305624@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 17:06:13 -0600
Message-ID: <CAPnjgZ0z3HwWwb-xKo5zOXWQsDxn9_9LgOdCmLJ4wC0HUJcL4w@mail.gmail.com>
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

On Fri, 22 Sept 2023 at 13:28, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Sep 22, 2023 at 12:27:36PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 21 Sept 2023 at 09:36, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Sep 20, 2023 at 07:03:34PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 30 Aug 2023 at 15:39, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Aug 30, 2023 at 12:04:40PM -0600, Simon Glass wrote:
> > > > > > Use an accessor in the header file to avoid this.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > >  common/spl/spl.c                  | 9 +++++----
> > > > > >  include/asm-generic/global_data.h | 7 +++++++
> > > > > >  2 files changed, 12 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > > > > > index f0a90c280da..f5cef81000c 100644
> > > > > > --- a/common/spl/spl.c
> > > > > > +++ b/common/spl/spl.c
> > > > > > @@ -876,10 +876,11 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
> > > > > >       } else {
> > > > > >               debug("Unsupported OS image.. Jumping nevertheless..\n");
> > > > > >       }
> > > > > > -#if CONFIG_VAL(SYS_MALLOC_F_LEN) && !defined(CONFIG_SPL_SYS_MALLOC_SIZE)
> > > > > > -     debug("SPL malloc() used 0x%lx bytes (%ld KB)\n", gd->malloc_ptr,
> > > > > > -           gd->malloc_ptr / 1024);
> > > > > > -#endif
> > > > > > +     if (IS_ENABLED(CONFIG_SYS_MALLOC_F) &&
> > > > > > +         !IS_ENABLED(CONFIG_SPL_SYS_MALLOC_SIZE))
> > > > > > +             debug("SPL malloc() used 0x%lx bytes (%ld KB)\n",
> > > > > > +                   gd_malloc_ptr(), gd_malloc_ptr() / 1024);
> > >
> > > This is not more readable.  But I guess my comment was unclear as you're
> > > mixing changes here.  gd_malloc_ptr() rather than gd->malloc_ptr is a
> > > wash, to me.  I think one could argue it's not a helpful abstraction.
> > > but it's so that you can avoid CONFIG_VAL here, and say "if (...)" not
> > > "#if ..." here.
> >
> > Yes,
> >
> > >
> > > > > > +
> > > > > >       bootstage_mark_name(get_bootstage_id(false), "end phase");
> > > > > >  #ifdef CONFIG_BOOTSTAGE_STASH
> > > > > >       ret = bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
> > > > > > diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> > > > > > index 8fc205ded1a..edf9ff6823f 100644
> > > > > > --- a/include/asm-generic/global_data.h
> > > > > > +++ b/include/asm-generic/global_data.h
> > > > > > @@ -573,6 +573,13 @@ static_assert(sizeof(struct global_data) == GD_SIZE);
> > > > > >  #define gd_malloc_start()    0
> > > > > >  #define gd_set_malloc_start(val)
> > > > > >  #endif
> > > > > > +
> > > > > > +#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> > > > > > +#define gd_malloc_ptr()              gd->malloc_ptr
> > > > > > +#else
> > > > > > +#define gd_malloc_ptr()              0L
> > > > > > +#endif
> > > > > > +
> > > > > >  /**
> > > > > >   * enum gd_flags - global data flags
> > > > > >   *
> > > > >
> > > > > This is another case where readability is not improved. I also have a
> > > > > bad feeling that changing that exact area had some unintended
> > > > > consequences from the compiler, that totally should not have happened.
> > > > > But maybe that was something in a similar code section instead.
> > > >
> > > > The improvement is in the C file...here we have an accessor in the
> > > > header file as has been done elsewhere.
> > > >
> > > > Do you have any more details on the problem you mention? I will align
> > > > the accessor to the struct member which should resolve it.
> > >
> > > It's unfortunately one of those cases to do a global before/after build
> > > and see if anything does or does not get tripped up.  As I believe I did
> > > use CONFIG_VAL there and not a check on CONFIG_SYS_MALLOC_F itself for a
> > > reason, at the time.
> >
> > But the CONFIG_VAL symbols actually depends on CONFIG_SYS_MALLOC_F, so
> > I can't imagine what it might be. Of course if the value is 0, then
> > the 'if CONFIG_VAL()' test would fail, but to what purpose?
>
> Yes, there's been a time or two where I banged my head against the
> figurative wall trying to understand what exactly the compiler could be
> seeing as why to change something.  I don't have a "reasonable"
> explanation.  Readability aside, "tidy things up" changes need to be on
> their own so that their impact can be seen aside from the new
> functionality changes.
>

Ah, I see. Yes this is quite a mess. I had not noticed exactly what
was going on there. The _F suffix is not really correct, but I suppose
we want the same symbol in SPL and proper.

I will add a new patch before this one.

Regards,
Simon
