Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45A9C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 17:51:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 302E5801BE;
	Fri,  7 Feb 2025 18:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JopUhfn7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CFE0801DE; Fri,  7 Feb 2025 18:51:56 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BDC9800B3
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 18:51:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5dcea56d6e2so4331939a12.1
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 09:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738950713; x=1739555513; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DQJQThWQcL+B7y5ge1+B4cKlQU2IvDMC7H8/j3OxKNA=;
 b=JopUhfn7O/iWD3tclJ1ZgIiOgAhBOzpZwWrx7KvzIEtAKcc0BW5uPFfl9YT533Nrlm
 fg3IN2Wm06Ka95clxfNJ07Lbeyax4nYdNmd9NAh+tasOh3qFrB+QoClkEbw5cPHFFaFI
 4Sz6PBNs6FOePE0B768mrbXJzkrIpf0KywaxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738950713; x=1739555513;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DQJQThWQcL+B7y5ge1+B4cKlQU2IvDMC7H8/j3OxKNA=;
 b=mk0FEQrvpATdrDcunvNb+f+gbM6CXthknD2lJYgBgNC4qWwQBuHY2hz20wtV9pMrQw
 PixnyFjQwwEV/eGxE79IlkSq3f5YfR47f65ZRK0+RBDbgKSii32mWtYRxgYrhA0a71L0
 eCPdteDeeGkO4IFyWUrselV0kn+vjEn1dK1ZlzeHSv99/o7rDTth+nH6P8Je3gXy7Yrc
 JF2fQviyC22NNVejd3aeFqCZ0T0stZ7SLJqezo7PsuAH2ThZpXkjnvo37yDxxgbdCjrI
 mlZ4sTJMbiWZ/El0b2TinK2IsLJdolZAtQ08jMWI5RWj0BmViicyxsPJNelhodtCiEjy
 q3xQ==
X-Gm-Message-State: AOJu0YwGu9ktI7C/3AFFH0tZqm4KzvCPvep4vvoWrfqHAhErHS4nfg/W
 Nhxwc61qJgeqI+GBsNRM1YJaCF2B7JbgoSZMWTGYfr9HLMUtIb+Dr0qjukgHfIBz9bpFArphNmE
 aoBJ9g7Jq49z98wssGcdTZ0pJ/0QHSNPfKu+s
X-Gm-Gg: ASbGncsErrkx1oWQBBokyDMIefhVtnAawEn3XYjlvmARHF0QTBv6OqwZDLHiEtxwCa2
 LQ+FmLUOxi5SY8rZGYzhuYUdDD6ab3LP1iY/igTY2eu30hOmN+R/hJ5dDhfkihRn2RbJYh6D7ww
 ==
X-Google-Smtp-Source: AGHT+IG+gPoLNG9MjJtXlh+0GGXA4t9rNdL8ihNINhzWH5ZHWoa7wqcHLfRMPCLG09dK17P0YcoBAPjRUX6ugLAA0P0=
X-Received: by 2002:a05:6402:51cf:b0:5dc:57a5:c414 with SMTP id
 4fb4d7f45d1cf-5de45088202mr4798557a12.30.1738950712753; Fri, 07 Feb 2025
 09:51:52 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-29-sjg@chromium.org>
 <CAEfUkUKoe+1LQaqOUb8_1M5yy8ELr=jG66+wRd1b3Oq5BB2bSA@mail.gmail.com>
 <CAFLszTg=UDJUdjCPsyMBjZ3r_r9dNyWYiXNrmhm8mxgEbQoaOg@mail.gmail.com>
 <CAEfUkUL7H5twRqZZBcfEHuExwtHFUrT9h7NV-3T0jx0c0SBEbw@mail.gmail.com>
 <CAFLszThvDjXTDdm7FiGZSBbtDv0px509x2jjn5WX++5Ck4PtOQ@mail.gmail.com>
 <CAEfUkUKoN_xGZ+sGTsdExgVpA54TfYD924VVnu-eQqNVO5tbHA@mail.gmail.com>
In-Reply-To: <CAEfUkUKoN_xGZ+sGTsdExgVpA54TfYD924VVnu-eQqNVO5tbHA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Feb 2025 10:51:41 -0700
X-Gm-Features: AWEUYZlVCsLWOzwwBtBPcZFn_YQ7fkTaa5puVPwrrdf0vyndL5FwFevBXi3j8dM
Message-ID: <CAFLszTgLR2RR+fFi6iY3X3=6bQgcyaQhEGDNmWfNubU_GCQUhA@mail.gmail.com>
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

On Fri, 7 Feb 2025 at 08:10, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 6 Feb 2025 at 19:09, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Raymond,
> >
> > On Thu, 6 Feb 2025 at 15:35, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Thu, 6 Feb 2025 at 10:41, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Raymond,
> > > >
> > > > On Wed, 5 Feb 2025 at 08:25, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > >
> > > > > +CC Ilias,
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Tue, 4 Feb 2025 at 20:57, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > The logic of this has become too confusing.
> > > > > >
> > > > > > The primary issue with the patch is that U-Boot needs to set up a
> > > > > > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > > > > > phases can then use that bloblist.
> > > > > >
> > > > > > But the first phase of U-Boot cannot assume that one exists.
> > > > > >
> > > > > > Reverting this commit seems like a better starting point for getting
> > > > > > things working for all use-cases.
> > > > > >
> > > > > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> > > > > >
> > > > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > >
> > > > > If my understanding is correct, you want to add some logic to control
> > > > > when the U-Boot should or should not get the bloblist from the
> > > > > existing register argument.
> > > > > But xferlist_from_boot_arg() should be called when a valid register
> > > > > argument is there, I didn't see this in your patch.
> > > > > Maybe you plan to do this with other patch series, but simply
> > > > > reverting this results in a breaking of handoff policy and the
> > > > > firmware handoff won't work.
> > > >
> > > > Yes, I certainly did not want to revert it, but the current code is
> > > > too hard to understand and I did not look at it at the time it went
> > > > in. I've had three tries at working with what you have here, but each
> > > > turns to spaghetti.
> > > >
> > >
> > > Still not very clear on what concerns you have and what is the way you
> > > want to go.
> > > The logic is straight forward, when U-Boot has a previous loader and
> > > the registers pass in valid arguments - It indicates handoff should be
> > > done using the transfer list.
> > > Other kconfig options decide whether to use the passed in address
> > > directly or copy to a predefined address.
> > > But in either way, xferlist_from_boot_arg() is doing the right thing
> > > to get the transfer list from the register if it exists and is valid.
> > > I don't see a reason for removing it.
> >
> > Here is the initial code:
> > >>>>
> > bool from_addr = fixed && !xpl_is_first_phase();
> > /*
> > * If U-Boot is in the first phase that an arch custom routine should
> > * install the bloblist passed from previous loader to this fixed
> > * address.
> > */
> > bool from_boot_arg = fixed && xpl_is_first_phase();
> >
> > if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> >    from_addr = false;
> > <<<<
> >
> > and by the way, that is my tree. In -next it is even worse:
> > >>>>
> > /*
> > * If U-Boot is not in the first phase, an existing bloblist must be
> > * at a fixed address.
> > */
> > bool from_addr = fixed && !xpl_is_first_phase();
> > /*
> > * If U-Boot is in the first phase that an arch custom routine should
> > * install the bloblist passed from previous loader to this fixed
> > * address.
> > */
> > bool from_boot_arg = fixed && xpl_is_first_phase();
> >
> > if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> > from_addr = false;
> > if (fixed)
> > addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> >       CONFIG_BLOBLIST_ADDR);
> > size = CONFIG_BLOBLIST_SIZE;
> >
> > if (from_boot_arg)
> > ret = xferlist_from_boot_arg(addr, size);
> > else if (from_addr)
> > ret = bloblist_check(addr, size);
> > <<<<
> >
> > I want to update it so that TPL creates a bloblist and passes it
> > through the following phases, ending up at U-Boot.
> >
> > To my mind, if CONFIG_IS_ENABLED(BLOBLIST), then we should check the
> > registers and always accept standard passage. If not, we should
> > either:
> > - create a bloblist (if this *is* the first phase with
> > CONFIG_IS_ENABLED(BLOBLIST))
> > - use an existing bloblistl, which must exist (if not)
> >
>
> To my mind, first we should check whether there is a valid transfer
> list passed in, which is done by xferlist_from_boot_arg().
> If it does, and BLOBLIST is selected, then use the transfer list as bloblist.
> And we do need a new kconfig (e.g. FIRMWARE_HANDOFF_MANDATORY) to
> determine whether fw handoff is mandatory.
>
> See below pseudo code:
> ```
> if (!xferlist_from_boot_arg()) {
>     /* a valid transfer list exists */
>     if (!CONFIG_IS_ENABLED(BLOBLIST))
>         return ERROR;
>
>     /* use the transfer list as a bloblist */
>     [...]
> } else if (CONFIG_IS_ENABLED(FIRMWARE_HANDOFF_MANDATORY)) {
>     /* no valid transfer list passed in, but the arm spec is mandatory */
>     return ERROR;
> } else {
>     /* arm spec is not in use at all, create or use a static bloblist */
>     [...]
> }
> ```
>

Yes, that sounds good to me. Please go ahead.

Regards,
Simon

>
> > I just don't think the existing logic is a good starting point as it
> > is too confusing.
> >
> > Perhaps, putting it another way, what do you like about the current
> > code (either version)?
> >
> > Regards,
> > Simon
> >
> >
> >
> > >
> > > Regards,
> > > Raymond
> > >
> > > > I would like to build on this and get something running in CI which
> > > > uses standard passage. As Tom suggests, perhaps we should disconnect
> > > > bloblist and standard passage?
> > > >
> > > > On the CI point, is there a board we could add that uses the
> > > > xferlist_from_boot_arg() call?
> > > >
> > > > Regards,
> > > > Simon
> > > >
> > > > >
> > > > > Regards,
> > > > > Raymond
> > > > >
> > > > > >  common/bloblist.c  | 64 ++++++++++++++--------------------------------
> > > > > >  include/bloblist.h | 10 --------
> > > > > >  2 files changed, 19 insertions(+), 55 deletions(-)
> > > > > >
> > > > > > diff --git a/common/bloblist.c b/common/bloblist.c
> > > > > > index e8acfc74331..7eda94ecdf9 100644
> > > > > > --- a/common/bloblist.c
> > > > > > +++ b/common/bloblist.c
> > > > > > @@ -487,57 +487,37 @@ int bloblist_reloc(void *to, uint to_size)
> > > > > >         return 0;
> > > > > >  }
> > > > > >
> > > > > > -/*
> > > > > > - * Weak default function for getting bloblist from boot args.
> > > > > > - */
> > > > > > -int __weak xferlist_from_boot_arg(ulong __always_unused addr,
> > > > > > -                                 ulong __always_unused size)
> > > > > > -{
> > > > > > -       return -ENOENT;
> > > > > > -}
> > > > > > -
> > > > > >  int bloblist_init(void)
> > > > > >  {
> > > > > >         bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
> > > > > >         int ret = -ENOENT;
> > > > > > -       ulong addr = 0, size;
> > > > > > -       /*
> > > > > > -        * If U-Boot is not in the first phase, an existing bloblist must be
> > > > > > -        * at a fixed address.
> > > > > > -        */
> > > > > > -       bool from_addr = fixed && !xpl_is_first_phase();
> > > > > > -       /*
> > > > > > -        * If U-Boot is in the first phase that an arch custom routine should
> > > > > > -        * install the bloblist passed from previous loader to this fixed
> > > > > > +       ulong addr, size;
> > > > > > +       bool expected;
> > > > > > +
> > > > > > +       /**
> > > > > > +        * We don't expect to find an existing bloblist in the first phase of
> > > > > > +        * U-Boot that runs. Also we have no way to receive the address of an
> > > > > > +        * allocated bloblist from a previous stage, so it must be at a fixed
> > > > > >          * address.
> > > > > >          */
> > > > > > -       bool from_boot_arg = fixed && xpl_is_first_phase();
> > > > > > -
> > > > > > +       expected = fixed && !xpl_is_first_phase();
> > > > > >         if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> > > > > > -               from_addr = false;
> > > > > > +               expected = false;
> > > > > >         if (fixed)
> > > > > >                 addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> > > > > >                                       CONFIG_BLOBLIST_ADDR);
> > > > > >         size = CONFIG_BLOBLIST_SIZE;
> > > > > > -
> > > > > > -       if (from_boot_arg)
> > > > > > -               ret = xferlist_from_boot_arg(addr, size);
> > > > > > -       else if (from_addr)
> > > > > > +       if (expected) {
> > > > > >                 ret = bloblist_check(addr, size);
> > > > > > -
> > > > > > -       if (ret)
> > > > > > -               log_warning("Bloblist at %lx not found (err=%d)\n",
> > > > > > -                           addr, ret);
> > > > > > -       else
> > > > > > -               /* Get the real size */
> > > > > > -               size = gd->bloblist->total_size;
> > > > > > -
> > > > > > +               if (ret) {
> > > > > > +                       log_warning("Expected bloblist at %lx not found (err=%d)\n",
> > > > > > +                                   addr, ret);
> > > > > > +               } else {
> > > > > > +                       /* Get the real size, if it is not what we expected */
> > > > > > +                       size = gd->bloblist->total_size;
> > > > > > +               }
> > > > > > +       }
> > > > > >         if (ret) {
> > > > > > -               /*
> > > > > > -                * If we don't have a bloblist from a fixed address, or the one
> > > > > > -                * in the fixed address is not valid. we must allocate the
> > > > > > -                * memory for it now.
> > > > > > -                */
> > > > > >                 if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
> > > > > >                         void *ptr = memalign(BLOBLIST_ALIGN, size);
> > > > > >
> > > > > > @@ -545,8 +525,7 @@ int bloblist_init(void)
> > > > > >                                 return log_msg_ret("alloc", -ENOMEM);
> > > > > >                         addr = map_to_sysmem(ptr);
> > > > > >                 } else if (!fixed) {
> > > > > > -                       return log_msg_ret("BLOBLIST_FIXED is not enabled",
> > > > > > -                                          ret);
> > > > > > +                       return log_msg_ret("!fixed", ret);
> > > > > >                 }
> > > > > >                 log_debug("Creating new bloblist size %lx at %lx\n", size,
> > > > > >                           addr);
> > > > > > @@ -559,11 +538,6 @@ int bloblist_init(void)
> > > > > >                 return log_msg_ret("ini", ret);
> > > > > >         gd->flags |= GD_FLG_BLOBLIST_READY;
> > > > > >
> > > > > > -#ifdef DEBUG
> > > > > > -       bloblist_show_stats();
> > > > > > -       bloblist_show_list();
> > > > > > -#endif
> > > > > > -
> > > > > >         return 0;
> > > > > >  }
> > > > > >
> > > > > > diff --git a/include/bloblist.h b/include/bloblist.h
> > > > > > index 1e1ca34aa92..5063ab66e4a 100644
> > > > > > --- a/include/bloblist.h
> > > > > > +++ b/include/bloblist.h
> > > > > > @@ -482,14 +482,4 @@ static inline int bloblist_maybe_init(void)
> > > > > >   */
> > > > > >  int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig);
> > > > > >
> > > > > > -/**
> > > > > > - * xferlist_from_boot_arg() - Get bloblist from the boot args and relocate it
> > > > > > - *                           to the specified address.
> > > > > > - *
> > > > > > - * @addr: Address for the bloblist
> > > > > > - * @size: Size of space reserved for the bloblist
> > > > > > - * Return: 0 if OK, else on error
> > > > > > - */
> > > > > > -int xferlist_from_boot_arg(ulong addr, ulong size);
> > > > > > -
> > > > > >  #endif /* __BLOBLIST_H */
> > > > > > --
> > > > > > 2.43.0
> > > > > >
