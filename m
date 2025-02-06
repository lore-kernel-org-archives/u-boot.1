Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4A1C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 22:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E76CE80E94;
	Thu,  6 Feb 2025 23:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tJba3KC8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F329180ECC; Thu,  6 Feb 2025 23:35:15 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D21B80BA0
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 23:35:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so2055788a91.3
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 14:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738881311; x=1739486111; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wLEYQA555e7vnQ4nRcPXZ3xis7P7NMB1aq/LXQ4KeOs=;
 b=tJba3KC8PT63Et4WHrDmLxKmqv0qwSZgEM90AVRv9TRLx7NgcMfMYq8OYyecLCQoiF
 pxj7qucL479oJEpSSu91xpLEbJVWzRRvBmlkIFDLP5cXn9tdcvuLLWXRY/0hCJv33pcw
 UDJiEpyVsyH3e/jc8B+58VGTyMXk0sv+TqVfALvuz+Qb910iAAOASPu68CcfVF1f6kjg
 se4dunN/oOvOBY3y1T5A/xH2f7zh12E+Vwp/lEpYRFgPUFDa0u38sDfZGGYbChW5qVNl
 K0u6Aw5AiQPhL1bICvDwRl5+rURH6BxSZFPssjDJdsw8BkxS+iwdBR6hJa2leKpsuEWe
 JzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738881311; x=1739486111;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wLEYQA555e7vnQ4nRcPXZ3xis7P7NMB1aq/LXQ4KeOs=;
 b=GFj8bie1enBmI45VbzAvAFvLJoQnQrTf0geD4vEZcX94j6sVTPUYDEQhxdTRbW8M46
 C9UqvarJGSk6SMtkmtZKWEBQrtT5gbW5ZsJ80je2KvzpM+/KJA/4+J68hEHnoqvyjLgD
 n+htfaGjENBKzr9PcUqQNO0FVsAIh+xWz2McVwZl8c3b2DIg5XUaI3ug8/+yar8QOx3i
 e0nZrhaIO6XDI0RlE9lx4CBtDerMvaQVSniJumggANTlW3H49ciOb9jJoJQQ9kjCSEnb
 n0+L3LPf5qAyej8AT0VovIfHbKUh0cYkYIn/kZRtqFuFh5++oOCW3qlq/s/17Ty/b9/t
 HGpQ==
X-Gm-Message-State: AOJu0YyfxuJX/S5W+iZky/OKz61M4GF2dzp07CNDO1eGZr5dYEpT1vk4
 UvgK9ve1dHmvUUDjlbUVcofiVaC2oMT1RBHRuuKAca+as3z8OktKBL422Dp2jJ6gAvoifI6R5wr
 4AlAwFYkSwVgMhlKPTWdRUROOpVRlKyixUAIzWQ==
X-Gm-Gg: ASbGncsqc0QmTFLSNby3NS7U4RXZcVwlLXsMrlUxk4/Eum8ofPv8vSmnKauPbxaF6JL
 wOw5mwArxV3z7oKZFJH/uvmtEaztDUXVIONh2aC6kr4pxX1RoC3Fyzl5dPc4U+VLmCo0TJgwhF4
 QYEQMg+b08PXZQVLuVbYDpK3xEMyiN
X-Google-Smtp-Source: AGHT+IGLsFGBZCehHRlOLOnNkttPN8O01ZnhePddrCw8IgpF2GnFvaCkm+bMi7KoDaJ14cVnqEdIlCc011rTd6YFHpA=
X-Received: by 2002:a17:90b:19c9:b0:2f1:30c8:6e75 with SMTP id
 98e67ed59e1d1-2fa243f2121mr1066248a91.32.1738881311492; Thu, 06 Feb 2025
 14:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-29-sjg@chromium.org>
 <CAEfUkUKoe+1LQaqOUb8_1M5yy8ELr=jG66+wRd1b3Oq5BB2bSA@mail.gmail.com>
 <CAFLszTg=UDJUdjCPsyMBjZ3r_r9dNyWYiXNrmhm8mxgEbQoaOg@mail.gmail.com>
In-Reply-To: <CAFLszTg=UDJUdjCPsyMBjZ3r_r9dNyWYiXNrmhm8mxgEbQoaOg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 6 Feb 2025 17:34:58 -0500
X-Gm-Features: AWEUYZk9rQv3DUjm_I4DBv0gKr7ygiWRvOfjIONJSlJ4zy4vsNcTNx1C9-H0aaM
Message-ID: <CAEfUkUL7H5twRqZZBcfEHuExwtHFUrT9h7NV-3T0jx0c0SBEbw@mail.gmail.com>
Subject: Re: [PATCH 28/29] Revert "bloblist: Load the bloblist from the
 previous loader"
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Thu, 6 Feb 2025 at 10:41, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Wed, 5 Feb 2025 at 08:25, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > +CC Ilias,
> >
> > Hi Simon,
> >
> > On Tue, 4 Feb 2025 at 20:57, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > The logic of this has become too confusing.
> > >
> > > The primary issue with the patch is that U-Boot needs to set up a
> > > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > > phases can then use that bloblist.
> > >
> > > But the first phase of U-Boot cannot assume that one exists.
> > >
> > > Reverting this commit seems like a better starting point for getting
> > > things working for all use-cases.
> > >
> > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> > >
> > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> >
> > If my understanding is correct, you want to add some logic to control
> > when the U-Boot should or should not get the bloblist from the
> > existing register argument.
> > But xferlist_from_boot_arg() should be called when a valid register
> > argument is there, I didn't see this in your patch.
> > Maybe you plan to do this with other patch series, but simply
> > reverting this results in a breaking of handoff policy and the
> > firmware handoff won't work.
>
> Yes, I certainly did not want to revert it, but the current code is
> too hard to understand and I did not look at it at the time it went
> in. I've had three tries at working with what you have here, but each
> turns to spaghetti.
>

Still not very clear on what concerns you have and what is the way you
want to go.
The logic is straight forward, when U-Boot has a previous loader and
the registers pass in valid arguments - It indicates handoff should be
done using the transfer list.
Other kconfig options decide whether to use the passed in address
directly or copy to a predefined address.
But in either way, xferlist_from_boot_arg() is doing the right thing
to get the transfer list from the register if it exists and is valid.
I don't see a reason for removing it.

Regards,
Raymond

> I would like to build on this and get something running in CI which
> uses standard passage. As Tom suggests, perhaps we should disconnect
> bloblist and standard passage?
>
> On the CI point, is there a board we could add that uses the
> xferlist_from_boot_arg() call?
>
> Regards,
> Simon
>
> >
> > Regards,
> > Raymond
> >
> > >  common/bloblist.c  | 64 ++++++++++++++--------------------------------
> > >  include/bloblist.h | 10 --------
> > >  2 files changed, 19 insertions(+), 55 deletions(-)
> > >
> > > diff --git a/common/bloblist.c b/common/bloblist.c
> > > index e8acfc74331..7eda94ecdf9 100644
> > > --- a/common/bloblist.c
> > > +++ b/common/bloblist.c
> > > @@ -487,57 +487,37 @@ int bloblist_reloc(void *to, uint to_size)
> > >         return 0;
> > >  }
> > >
> > > -/*
> > > - * Weak default function for getting bloblist from boot args.
> > > - */
> > > -int __weak xferlist_from_boot_arg(ulong __always_unused addr,
> > > -                                 ulong __always_unused size)
> > > -{
> > > -       return -ENOENT;
> > > -}
> > > -
> > >  int bloblist_init(void)
> > >  {
> > >         bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
> > >         int ret = -ENOENT;
> > > -       ulong addr = 0, size;
> > > -       /*
> > > -        * If U-Boot is not in the first phase, an existing bloblist must be
> > > -        * at a fixed address.
> > > -        */
> > > -       bool from_addr = fixed && !xpl_is_first_phase();
> > > -       /*
> > > -        * If U-Boot is in the first phase that an arch custom routine should
> > > -        * install the bloblist passed from previous loader to this fixed
> > > +       ulong addr, size;
> > > +       bool expected;
> > > +
> > > +       /**
> > > +        * We don't expect to find an existing bloblist in the first phase of
> > > +        * U-Boot that runs. Also we have no way to receive the address of an
> > > +        * allocated bloblist from a previous stage, so it must be at a fixed
> > >          * address.
> > >          */
> > > -       bool from_boot_arg = fixed && xpl_is_first_phase();
> > > -
> > > +       expected = fixed && !xpl_is_first_phase();
> > >         if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> > > -               from_addr = false;
> > > +               expected = false;
> > >         if (fixed)
> > >                 addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> > >                                       CONFIG_BLOBLIST_ADDR);
> > >         size = CONFIG_BLOBLIST_SIZE;
> > > -
> > > -       if (from_boot_arg)
> > > -               ret = xferlist_from_boot_arg(addr, size);
> > > -       else if (from_addr)
> > > +       if (expected) {
> > >                 ret = bloblist_check(addr, size);
> > > -
> > > -       if (ret)
> > > -               log_warning("Bloblist at %lx not found (err=%d)\n",
> > > -                           addr, ret);
> > > -       else
> > > -               /* Get the real size */
> > > -               size = gd->bloblist->total_size;
> > > -
> > > +               if (ret) {
> > > +                       log_warning("Expected bloblist at %lx not found (err=%d)\n",
> > > +                                   addr, ret);
> > > +               } else {
> > > +                       /* Get the real size, if it is not what we expected */
> > > +                       size = gd->bloblist->total_size;
> > > +               }
> > > +       }
> > >         if (ret) {
> > > -               /*
> > > -                * If we don't have a bloblist from a fixed address, or the one
> > > -                * in the fixed address is not valid. we must allocate the
> > > -                * memory for it now.
> > > -                */
> > >                 if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
> > >                         void *ptr = memalign(BLOBLIST_ALIGN, size);
> > >
> > > @@ -545,8 +525,7 @@ int bloblist_init(void)
> > >                                 return log_msg_ret("alloc", -ENOMEM);
> > >                         addr = map_to_sysmem(ptr);
> > >                 } else if (!fixed) {
> > > -                       return log_msg_ret("BLOBLIST_FIXED is not enabled",
> > > -                                          ret);
> > > +                       return log_msg_ret("!fixed", ret);
> > >                 }
> > >                 log_debug("Creating new bloblist size %lx at %lx\n", size,
> > >                           addr);
> > > @@ -559,11 +538,6 @@ int bloblist_init(void)
> > >                 return log_msg_ret("ini", ret);
> > >         gd->flags |= GD_FLG_BLOBLIST_READY;
> > >
> > > -#ifdef DEBUG
> > > -       bloblist_show_stats();
> > > -       bloblist_show_list();
> > > -#endif
> > > -
> > >         return 0;
> > >  }
> > >
> > > diff --git a/include/bloblist.h b/include/bloblist.h
> > > index 1e1ca34aa92..5063ab66e4a 100644
> > > --- a/include/bloblist.h
> > > +++ b/include/bloblist.h
> > > @@ -482,14 +482,4 @@ static inline int bloblist_maybe_init(void)
> > >   */
> > >  int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig);
> > >
> > > -/**
> > > - * xferlist_from_boot_arg() - Get bloblist from the boot args and relocate it
> > > - *                           to the specified address.
> > > - *
> > > - * @addr: Address for the bloblist
> > > - * @size: Size of space reserved for the bloblist
> > > - * Return: 0 if OK, else on error
> > > - */
> > > -int xferlist_from_boot_arg(ulong addr, ulong size);
> > > -
> > >  #endif /* __BLOBLIST_H */
> > > --
> > > 2.43.0
> > >
