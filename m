Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F56C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17DC3801BE;
	Fri,  7 Feb 2025 19:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xJgj0fAT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92B81801DE; Fri,  7 Feb 2025 19:27:05 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C6DE80141
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:27:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2fa1fb3c445so2308650a91.2
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738952821; x=1739557621; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=duI4aKSKs4tSnfw2G5bEFZ2WAVCFDiD03NnBnLuqJzY=;
 b=xJgj0fAT3RaouFY9wtFM2dItFE1eL4wKWl9Z2lX8TTWCwh+DScIeIm47jrivIUpxte
 ttkGjxEM6B2zRrGrhUkkILYTxy0LUMZ5rBoH/6s2J9ZwUJFUDfDfDWcTgV4i31llcU+G
 lohn0+n6yhiSkKrzXBfhho4hk3mPKlSQ/Q+8+xd4/4om9UXQrpDpozJhFqEiqKPnCPdt
 +IpysR4oz9uLibsqHUM7HhCZtP0Y24lBmLGP/AFxiuAvwBgEO7xDfQ77vMPzktHWgJ6c
 gDsQcYc/hKVYsMLYhtNngmS4cTFqoN7aKbfmChB/a8En/gXhjerClKeZm8qLBEg3Uq2G
 Ft4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738952821; x=1739557621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=duI4aKSKs4tSnfw2G5bEFZ2WAVCFDiD03NnBnLuqJzY=;
 b=CoTqIMuWAPxsUa9vkJkn1EYHXvps6Ga6Xhy58vhGW6yuVQenpJuK2rhPxhizHNlJ1b
 ozpU6OlvVFRkk+4Y4qR4+5hG5tUoX4lMZL+LJNWdXbXA/sapt90kVvjjglcDSN31r0uT
 ZzXj2IYQffhf1wCncD83f4sSZmrTkvNYLVEqjWv/ZYpwU55JdECUrEqmiUn4G1oKuFkb
 Bmg9VFbYbNrOgrEGbKZTp1RUidFgQq6tK6Xcq/SVY4klPsAvadOYFTQnwBzdUsVJLtC+
 UeDzQ52U+N2qugQFg6YzSrYoPbDvV4CvF1MnFHPLdJk1i6Hzqvg770rvgIKbTrr6v37s
 UXqg==
X-Gm-Message-State: AOJu0Yw7h9fkSCQwUpmce+2ttlEATjbaSbJqVHwsv4jd0M190oI7PyQz
 nxEiPcRpLMSJJE9LcTpDygiYq79MvRv7xfMNy+xKJoVJGDKhxUU7hlYm9MVOY1zGRcKulW1kXSN
 Ujz+AEpQcMLiNbnwJJrDlzdm9mgY119QX9sfvQP3pnK4c9HSQxWM=
X-Gm-Gg: ASbGncuocPlCTok/5JhbISmvXefm656K5B9rO+aJCt+lHhGqlwllTypeMDJYW8yCgek
 K6TKDVDiIUlSbSd8nyl9ymFx0t1U2PMP5AX3gnqMzewO2yIl3kLIn66Q2t8r0mXoB4wsNos516H
 Lf3ianxBtStd7QgON4rIQurcyA+1Z2
X-Google-Smtp-Source: AGHT+IHAcjT7ApfqF0d8tWuz/lFHRY/Pm9Yiv7jkBMPR83pvECQ1SLFBUP/lkXDzQ2L84QKAn8PeYJGAvJDQg9Fg05s=
X-Received: by 2002:a17:90b:3a87:b0:2f6:d266:f462 with SMTP id
 98e67ed59e1d1-2fa2450d5famr5902028a91.35.1738952820750; Fri, 07 Feb 2025
 10:27:00 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-29-sjg@chromium.org>
 <CAEfUkUKoe+1LQaqOUb8_1M5yy8ELr=jG66+wRd1b3Oq5BB2bSA@mail.gmail.com>
 <CAFLszTg=UDJUdjCPsyMBjZ3r_r9dNyWYiXNrmhm8mxgEbQoaOg@mail.gmail.com>
 <CAEfUkUL7H5twRqZZBcfEHuExwtHFUrT9h7NV-3T0jx0c0SBEbw@mail.gmail.com>
 <CAFLszThvDjXTDdm7FiGZSBbtDv0px509x2jjn5WX++5Ck4PtOQ@mail.gmail.com>
 <CAEfUkUKoN_xGZ+sGTsdExgVpA54TfYD924VVnu-eQqNVO5tbHA@mail.gmail.com>
 <CAFLszTgLR2RR+fFi6iY3X3=6bQgcyaQhEGDNmWfNubU_GCQUhA@mail.gmail.com>
In-Reply-To: <CAFLszTgLR2RR+fFi6iY3X3=6bQgcyaQhEGDNmWfNubU_GCQUhA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 7 Feb 2025 13:26:46 -0500
X-Gm-Features: AWEUYZnrkbADSzJZv_PJHXUzr545eVm-B0CF3IKVThVZPz9OrZY9OOnRBNSFir0
Message-ID: <CAEfUkUL1OQwL8h-NJcFW+++ff_6tWAEweNiKaSjJsa-U5yGfvA@mail.gmail.com>
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

On Fri, 7 Feb 2025 at 12:51, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Fri, 7 Feb 2025 at 08:10, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Thu, 6 Feb 2025 at 19:09, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Raymond,
> > >
> > > On Thu, 6 Feb 2025 at 15:35, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Thu, 6 Feb 2025 at 10:41, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Raymond,
> > > > >
> > > > > On Wed, 5 Feb 2025 at 08:25, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > > >
> > > > > > +CC Ilias,
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Tue, 4 Feb 2025 at 20:57, Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > The logic of this has become too confusing.
> > > > > > >
> > > > > > > The primary issue with the patch is that U-Boot needs to set up a
> > > > > > > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > > > > > > phases can then use that bloblist.
> > > > > > >
> > > > > > > But the first phase of U-Boot cannot assume that one exists.
> > > > > > >
> > > > > > > Reverting this commit seems like a better starting point for getting
> > > > > > > things working for all use-cases.
> > > > > > >
> > > > > > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> > > > > > >
> > > > > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > >
> > > > > > If my understanding is correct, you want to add some logic to control
> > > > > > when the U-Boot should or should not get the bloblist from the
> > > > > > existing register argument.
> > > > > > But xferlist_from_boot_arg() should be called when a valid register
> > > > > > argument is there, I didn't see this in your patch.
> > > > > > Maybe you plan to do this with other patch series, but simply
> > > > > > reverting this results in a breaking of handoff policy and the
> > > > > > firmware handoff won't work.
> > > > >
> > > > > Yes, I certainly did not want to revert it, but the current code is
> > > > > too hard to understand and I did not look at it at the time it went
> > > > > in. I've had three tries at working with what you have here, but each
> > > > > turns to spaghetti.
> > > > >
> > > >
> > > > Still not very clear on what concerns you have and what is the way you
> > > > want to go.
> > > > The logic is straight forward, when U-Boot has a previous loader and
> > > > the registers pass in valid arguments - It indicates handoff should be
> > > > done using the transfer list.
> > > > Other kconfig options decide whether to use the passed in address
> > > > directly or copy to a predefined address.
> > > > But in either way, xferlist_from_boot_arg() is doing the right thing
> > > > to get the transfer list from the register if it exists and is valid.
> > > > I don't see a reason for removing it.
> > >
> > > Here is the initial code:
> > > >>>>
> > > bool from_addr = fixed && !xpl_is_first_phase();
> > > /*
> > > * If U-Boot is in the first phase that an arch custom routine should
> > > * install the bloblist passed from previous loader to this fixed
> > > * address.
> > > */
> > > bool from_boot_arg = fixed && xpl_is_first_phase();
> > >
> > > if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> > >    from_addr = false;
> > > <<<<
> > >
> > > and by the way, that is my tree. In -next it is even worse:
> > > >>>>
> > > /*
> > > * If U-Boot is not in the first phase, an existing bloblist must be
> > > * at a fixed address.
> > > */
> > > bool from_addr = fixed && !xpl_is_first_phase();
> > > /*
> > > * If U-Boot is in the first phase that an arch custom routine should
> > > * install the bloblist passed from previous loader to this fixed
> > > * address.
> > > */
> > > bool from_boot_arg = fixed && xpl_is_first_phase();
> > >
> > > if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> > > from_addr = false;
> > > if (fixed)
> > > addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> > >       CONFIG_BLOBLIST_ADDR);
> > > size = CONFIG_BLOBLIST_SIZE;
> > >
> > > if (from_boot_arg)
> > > ret = xferlist_from_boot_arg(addr, size);
> > > else if (from_addr)
> > > ret = bloblist_check(addr, size);
> > > <<<<
> > >
> > > I want to update it so that TPL creates a bloblist and passes it
> > > through the following phases, ending up at U-Boot.
> > >
> > > To my mind, if CONFIG_IS_ENABLED(BLOBLIST), then we should check the
> > > registers and always accept standard passage. If not, we should
> > > either:
> > > - create a bloblist (if this *is* the first phase with
> > > CONFIG_IS_ENABLED(BLOBLIST))
> > > - use an existing bloblistl, which must exist (if not)
> > >
> >
> > To my mind, first we should check whether there is a valid transfer
> > list passed in, which is done by xferlist_from_boot_arg().
> > If it does, and BLOBLIST is selected, then use the transfer list as bloblist.
> > And we do need a new kconfig (e.g. FIRMWARE_HANDOFF_MANDATORY) to
> > determine whether fw handoff is mandatory.
> >
> > See below pseudo code:
> > ```
> > if (!xferlist_from_boot_arg()) {
> >     /* a valid transfer list exists */
> >     if (!CONFIG_IS_ENABLED(BLOBLIST))
> >         return ERROR;
> >
> >     /* use the transfer list as a bloblist */
> >     [...]
> > } else if (CONFIG_IS_ENABLED(FIRMWARE_HANDOFF_MANDATORY)) {
> >     /* no valid transfer list passed in, but the arm spec is mandatory */
> >     return ERROR;
> > } else {
> >     /* arm spec is not in use at all, create or use a static bloblist */
> >     [...]
> > }
> > ```
> >
>
> Yes, that sounds good to me. Please go ahead.

@Tom Rini @Ilias Apalodimas What's your idea? If all of you feel good
I will post a patch for it.

Regards,
Raymond

>
> Regards,
> Simon
>
> >
> > > I just don't think the existing logic is a good starting point as it
> > > is too confusing.
> > >
> > > Perhaps, putting it another way, what do you like about the current
> > > code (either version)?
> > >
> > > Regards,
> > > Simon
> > >
> > >
> > >
> > > >
> > > > Regards,
> > > > Raymond
> > > >
> > > > > I would like to build on this and get something running in CI which
> > > > > uses standard passage. As Tom suggests, perhaps we should disconnect
> > > > > bloblist and standard passage?
> > > > >
> > > > > On the CI point, is there a board we could add that uses the
> > > > > xferlist_from_boot_arg() call?
> > > > >
> > > > > Regards,
> > > > > Simon
> > > > >
> > > > > >
> > > > > > Regards,
> > > > > > Raymond
> > > > > >
> > > > > > >  common/bloblist.c  | 64 ++++++++++++++--------------------------------
> > > > > > >  include/bloblist.h | 10 --------
> > > > > > >  2 files changed, 19 insertions(+), 55 deletions(-)
> > > > > > >
> > > > > > > diff --git a/common/bloblist.c b/common/bloblist.c
> > > > > > > index e8acfc74331..7eda94ecdf9 100644
> > > > > > > --- a/common/bloblist.c
> > > > > > > +++ b/common/bloblist.c
> > > > > > > @@ -487,57 +487,37 @@ int bloblist_reloc(void *to, uint to_size)
> > > > > > >         return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > -/*
> > > > > > > - * Weak default function for getting bloblist from boot args.
> > > > > > > - */
> > > > > > > -int __weak xferlist_from_boot_arg(ulong __always_unused addr,
> > > > > > > -                                 ulong __always_unused size)
> > > > > > > -{
> > > > > > > -       return -ENOENT;
> > > > > > > -}
> > > > > > > -
> > > > > > >  int bloblist_init(void)
> > > > > > >  {
> > > > > > >         bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
> > > > > > >         int ret = -ENOENT;
> > > > > > > -       ulong addr = 0, size;
> > > > > > > -       /*
> > > > > > > -        * If U-Boot is not in the first phase, an existing bloblist must be
> > > > > > > -        * at a fixed address.
> > > > > > > -        */
> > > > > > > -       bool from_addr = fixed && !xpl_is_first_phase();
> > > > > > > -       /*
> > > > > > > -        * If U-Boot is in the first phase that an arch custom routine should
> > > > > > > -        * install the bloblist passed from previous loader to this fixed
> > > > > > > +       ulong addr, size;
> > > > > > > +       bool expected;
> > > > > > > +
> > > > > > > +       /**
> > > > > > > +        * We don't expect to find an existing bloblist in the first phase of
> > > > > > > +        * U-Boot that runs. Also we have no way to receive the address of an
> > > > > > > +        * allocated bloblist from a previous stage, so it must be at a fixed
> > > > > > >          * address.
> > > > > > >          */
> > > > > > > -       bool from_boot_arg = fixed && xpl_is_first_phase();
> > > > > > > -
> > > > > > > +       expected = fixed && !xpl_is_first_phase();
> > > > > > >         if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> > > > > > > -               from_addr = false;
> > > > > > > +               expected = false;
> > > > > > >         if (fixed)
> > > > > > >                 addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> > > > > > >                                       CONFIG_BLOBLIST_ADDR);
> > > > > > >         size = CONFIG_BLOBLIST_SIZE;
> > > > > > > -
> > > > > > > -       if (from_boot_arg)
> > > > > > > -               ret = xferlist_from_boot_arg(addr, size);
> > > > > > > -       else if (from_addr)
> > > > > > > +       if (expected) {
> > > > > > >                 ret = bloblist_check(addr, size);
> > > > > > > -
> > > > > > > -       if (ret)
> > > > > > > -               log_warning("Bloblist at %lx not found (err=%d)\n",
> > > > > > > -                           addr, ret);
> > > > > > > -       else
> > > > > > > -               /* Get the real size */
> > > > > > > -               size = gd->bloblist->total_size;
> > > > > > > -
> > > > > > > +               if (ret) {
> > > > > > > +                       log_warning("Expected bloblist at %lx not found (err=%d)\n",
> > > > > > > +                                   addr, ret);
> > > > > > > +               } else {
> > > > > > > +                       /* Get the real size, if it is not what we expected */
> > > > > > > +                       size = gd->bloblist->total_size;
> > > > > > > +               }
> > > > > > > +       }
> > > > > > >         if (ret) {
> > > > > > > -               /*
> > > > > > > -                * If we don't have a bloblist from a fixed address, or the one
> > > > > > > -                * in the fixed address is not valid. we must allocate the
> > > > > > > -                * memory for it now.
> > > > > > > -                */
> > > > > > >                 if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
> > > > > > >                         void *ptr = memalign(BLOBLIST_ALIGN, size);
> > > > > > >
> > > > > > > @@ -545,8 +525,7 @@ int bloblist_init(void)
> > > > > > >                                 return log_msg_ret("alloc", -ENOMEM);
> > > > > > >                         addr = map_to_sysmem(ptr);
> > > > > > >                 } else if (!fixed) {
> > > > > > > -                       return log_msg_ret("BLOBLIST_FIXED is not enabled",
> > > > > > > -                                          ret);
> > > > > > > +                       return log_msg_ret("!fixed", ret);
> > > > > > >                 }
> > > > > > >                 log_debug("Creating new bloblist size %lx at %lx\n", size,
> > > > > > >                           addr);
> > > > > > > @@ -559,11 +538,6 @@ int bloblist_init(void)
> > > > > > >                 return log_msg_ret("ini", ret);
> > > > > > >         gd->flags |= GD_FLG_BLOBLIST_READY;
> > > > > > >
> > > > > > > -#ifdef DEBUG
> > > > > > > -       bloblist_show_stats();
> > > > > > > -       bloblist_show_list();
> > > > > > > -#endif
> > > > > > > -
> > > > > > >         return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > diff --git a/include/bloblist.h b/include/bloblist.h
> > > > > > > index 1e1ca34aa92..5063ab66e4a 100644
> > > > > > > --- a/include/bloblist.h
> > > > > > > +++ b/include/bloblist.h
> > > > > > > @@ -482,14 +482,4 @@ static inline int bloblist_maybe_init(void)
> > > > > > >   */
> > > > > > >  int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig);
> > > > > > >
> > > > > > > -/**
> > > > > > > - * xferlist_from_boot_arg() - Get bloblist from the boot args and relocate it
> > > > > > > - *                           to the specified address.
> > > > > > > - *
> > > > > > > - * @addr: Address for the bloblist
> > > > > > > - * @size: Size of space reserved for the bloblist
> > > > > > > - * Return: 0 if OK, else on error
> > > > > > > - */
> > > > > > > -int xferlist_from_boot_arg(ulong addr, ulong size);
> > > > > > > -
> > > > > > >  #endif /* __BLOBLIST_H */
> > > > > > > --
> > > > > > > 2.43.0
> > > > > > >
