Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D414BC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 15:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A127807D7;
	Thu,  6 Feb 2025 16:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c1l5ECoD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 626F9807FB; Thu,  6 Feb 2025 16:41:24 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C812380737
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 16:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ab74ecfdae4so158667066b.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 07:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738856481; x=1739461281; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HGJII3av7ntL+j1NuSBtfudSUMxCP7xHZEHEgrmPAgg=;
 b=c1l5ECoDZJ3GRaISeu5qy4A6SD6TJzGLdiLBh7by+EpYTwuYq17IPLluEIfbil1yxQ
 GUX6wz88gqBqgLPkJ1SwLWUijY6SQl4/0mzJqAJC0qmQERTl3rhsiQmBsdbpZCxnbKeA
 XBLbxtIExSymOI3rwvflz8ld7ZrHYpZXxg3rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738856481; x=1739461281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HGJII3av7ntL+j1NuSBtfudSUMxCP7xHZEHEgrmPAgg=;
 b=YosnZBuvOjtVy1icO7wCm0HpBE7A9nnf9jCtWmsRiv3/Udv4292jOaKlCSIw9yifgn
 0yP9JhFsVNuyxe+TdEc8aS3/RaIZYuY+6yS9NfJYEBLdye9pzW51yOjMMWP9Cs0e6iKo
 8Tg8MOylmmcb6gZ1+w9nKwMdJBldyQ4aR/+GcjKThr3BC/nf/pcSDEzGhAgtvJzcGYq/
 BAGKyDGwc5N5CF3rRe9IgSiAcAQ2N2iL58lsQA3Lf2sKK5EwIA2JMNLLEQ0KEXmM9vx6
 4D3uBbGYmSgXg9SERhT6UbTJrhQ/zJfFblt6quX0jTxEIyaspn4L7YeGf6pr2paH1AcW
 CU5w==
X-Gm-Message-State: AOJu0YyFCDvV8BO+Jll+pIn6vB/WawDOUjGmbYT0LklMKcf12xrF3u5z
 borVkRnzRFtvs5wYR4ODvUsKS/oyYy+Scf7WIcl/AQjyKq9BIamJuQ3/wW2PXWU/Njj5gwkY0pE
 9GE+VIDSSGJLUPgg81xjKcpOJIqYWqM1RSLgy
X-Gm-Gg: ASbGncusEjTxDVbnBJyNOkwqpr93HW17k8CfwUIbFAk34ReSrfu87xGlzRuPFevjj0S
 COaBQkk2d4QBKxkZCx+X5ScsL6sBKntkUuTTydkCGxX2l9D3JieR4lleg1w9EAj69E69+TOVbxA
 ==
X-Google-Smtp-Source: AGHT+IEpTYotcz0gMDzsJTiVqBKwH5R8isEGx0iePINts0DL8B+14T2yUC3TG26ENDAvq9L3NA4eZ2TbWu3j00U7oQo=
X-Received: by 2002:a17:907:7e8e:b0:aae:eb0b:f39a with SMTP id
 a640c23a62f3a-ab75e2f6de6mr851798766b.42.1738856480913; Thu, 06 Feb 2025
 07:41:20 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-29-sjg@chromium.org>
 <CAEfUkUKoe+1LQaqOUb8_1M5yy8ELr=jG66+wRd1b3Oq5BB2bSA@mail.gmail.com>
In-Reply-To: <CAEfUkUKoe+1LQaqOUb8_1M5yy8ELr=jG66+wRd1b3Oq5BB2bSA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 08:41:09 -0700
X-Gm-Features: AWEUYZm_JSjA352naZEw9FhY-owUU1_2ArZEXKDUZXe-EHB7zAd6GtQeJbEkkgM
Message-ID: <CAFLszTg=UDJUdjCPsyMBjZ3r_r9dNyWYiXNrmhm8mxgEbQoaOg@mail.gmail.com>
Subject: Re: [PATCH 28/29] Revert "bloblist: Load the bloblist from the
 previous loader"
To: Raymond Mao <raymond.mao@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Raymond,

On Wed, 5 Feb 2025 at 08:25, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> +CC Ilias,
>
> Hi Simon,
>
> On Tue, 4 Feb 2025 at 20:57, Simon Glass <sjg@chromium.org> wrote:
> >
> > The logic of this has become too confusing.
> >
> > The primary issue with the patch is that U-Boot needs to set up a
> > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > phases can then use that bloblist.
> >
> > But the first phase of U-Boot cannot assume that one exists.
> >
> > Reverting this commit seems like a better starting point for getting
> > things working for all use-cases.
> >
> > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> >
> > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
>
> If my understanding is correct, you want to add some logic to control
> when the U-Boot should or should not get the bloblist from the
> existing register argument.
> But xferlist_from_boot_arg() should be called when a valid register
> argument is there, I didn't see this in your patch.
> Maybe you plan to do this with other patch series, but simply
> reverting this results in a breaking of handoff policy and the
> firmware handoff won't work.

Yes, I certainly did not want to revert it, but the current code is
too hard to understand and I did not look at it at the time it went
in. I've had three tries at working with what you have here, but each
turns to spaghetti.

I would like to build on this and get something running in CI which
uses standard passage. As Tom suggests, perhaps we should disconnect
bloblist and standard passage?

On the CI point, is there a board we could add that uses the
xferlist_from_boot_arg() call?

Regards,
Simon

>
> Regards,
> Raymond
>
> >  common/bloblist.c  | 64 ++++++++++++++--------------------------------
> >  include/bloblist.h | 10 --------
> >  2 files changed, 19 insertions(+), 55 deletions(-)
> >
> > diff --git a/common/bloblist.c b/common/bloblist.c
> > index e8acfc74331..7eda94ecdf9 100644
> > --- a/common/bloblist.c
> > +++ b/common/bloblist.c
> > @@ -487,57 +487,37 @@ int bloblist_reloc(void *to, uint to_size)
> >         return 0;
> >  }
> >
> > -/*
> > - * Weak default function for getting bloblist from boot args.
> > - */
> > -int __weak xferlist_from_boot_arg(ulong __always_unused addr,
> > -                                 ulong __always_unused size)
> > -{
> > -       return -ENOENT;
> > -}
> > -
> >  int bloblist_init(void)
> >  {
> >         bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
> >         int ret = -ENOENT;
> > -       ulong addr = 0, size;
> > -       /*
> > -        * If U-Boot is not in the first phase, an existing bloblist must be
> > -        * at a fixed address.
> > -        */
> > -       bool from_addr = fixed && !xpl_is_first_phase();
> > -       /*
> > -        * If U-Boot is in the first phase that an arch custom routine should
> > -        * install the bloblist passed from previous loader to this fixed
> > +       ulong addr, size;
> > +       bool expected;
> > +
> > +       /**
> > +        * We don't expect to find an existing bloblist in the first phase of
> > +        * U-Boot that runs. Also we have no way to receive the address of an
> > +        * allocated bloblist from a previous stage, so it must be at a fixed
> >          * address.
> >          */
> > -       bool from_boot_arg = fixed && xpl_is_first_phase();
> > -
> > +       expected = fixed && !xpl_is_first_phase();
> >         if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> > -               from_addr = false;
> > +               expected = false;
> >         if (fixed)
> >                 addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> >                                       CONFIG_BLOBLIST_ADDR);
> >         size = CONFIG_BLOBLIST_SIZE;
> > -
> > -       if (from_boot_arg)
> > -               ret = xferlist_from_boot_arg(addr, size);
> > -       else if (from_addr)
> > +       if (expected) {
> >                 ret = bloblist_check(addr, size);
> > -
> > -       if (ret)
> > -               log_warning("Bloblist at %lx not found (err=%d)\n",
> > -                           addr, ret);
> > -       else
> > -               /* Get the real size */
> > -               size = gd->bloblist->total_size;
> > -
> > +               if (ret) {
> > +                       log_warning("Expected bloblist at %lx not found (err=%d)\n",
> > +                                   addr, ret);
> > +               } else {
> > +                       /* Get the real size, if it is not what we expected */
> > +                       size = gd->bloblist->total_size;
> > +               }
> > +       }
> >         if (ret) {
> > -               /*
> > -                * If we don't have a bloblist from a fixed address, or the one
> > -                * in the fixed address is not valid. we must allocate the
> > -                * memory for it now.
> > -                */
> >                 if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
> >                         void *ptr = memalign(BLOBLIST_ALIGN, size);
> >
> > @@ -545,8 +525,7 @@ int bloblist_init(void)
> >                                 return log_msg_ret("alloc", -ENOMEM);
> >                         addr = map_to_sysmem(ptr);
> >                 } else if (!fixed) {
> > -                       return log_msg_ret("BLOBLIST_FIXED is not enabled",
> > -                                          ret);
> > +                       return log_msg_ret("!fixed", ret);
> >                 }
> >                 log_debug("Creating new bloblist size %lx at %lx\n", size,
> >                           addr);
> > @@ -559,11 +538,6 @@ int bloblist_init(void)
> >                 return log_msg_ret("ini", ret);
> >         gd->flags |= GD_FLG_BLOBLIST_READY;
> >
> > -#ifdef DEBUG
> > -       bloblist_show_stats();
> > -       bloblist_show_list();
> > -#endif
> > -
> >         return 0;
> >  }
> >
> > diff --git a/include/bloblist.h b/include/bloblist.h
> > index 1e1ca34aa92..5063ab66e4a 100644
> > --- a/include/bloblist.h
> > +++ b/include/bloblist.h
> > @@ -482,14 +482,4 @@ static inline int bloblist_maybe_init(void)
> >   */
> >  int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig);
> >
> > -/**
> > - * xferlist_from_boot_arg() - Get bloblist from the boot args and relocate it
> > - *                           to the specified address.
> > - *
> > - * @addr: Address for the bloblist
> > - * @size: Size of space reserved for the bloblist
> > - * Return: 0 if OK, else on error
> > - */
> > -int xferlist_from_boot_arg(ulong addr, ulong size);
> > -
> >  #endif /* __BLOBLIST_H */
> > --
> > 2.43.0
> >
