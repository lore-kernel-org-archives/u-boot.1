Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA34C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 15:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99C75801BE;
	Fri,  7 Feb 2025 16:10:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ODi3czJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F259080737; Fri,  7 Feb 2025 16:10:49 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D99BA80141
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 16:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2f9d627b5fbso3927002a91.2
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 07:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738941045; x=1739545845; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aspt4dmjbkRYef3dUkK8MoWCKxJdw3SPOn+nmFBrVqg=;
 b=ODi3czJn9YomVYxx1+nQBRS12aJshUxEyYVwXftCh4sf2HB2AAPtYe312u2H+5vGMv
 miHuBaMFntbxQ77+tPn3I4F3ycI/6Ngk7uZebn8Ggjt0+o2mgAlftaz29VjqbICcPoDK
 pDQ5NaltwasOdJm6COazIKOdlPxVzt4chegBYlUbHa70a6zSfkvfk5ZU98mHeIjiRjLf
 OTl+laKR5JDb5YPLA68dyMqWbnCbvIcFYCN+W6M/ixvwZLpxM7SrvW7PPHeTexw+Y0xY
 4tQvgWKR1lSuq9pYesfQOp/cZ6J2P+XTV2yptap13TuGECeIqpQmbiBt4iNT1S1hD+En
 IeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738941045; x=1739545845;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aspt4dmjbkRYef3dUkK8MoWCKxJdw3SPOn+nmFBrVqg=;
 b=nuF9imxMbmWdQoEqwKsG7Lp96n/Yf42PyqCt5zc4NGn2oa7YQVB2bFrhlD4Pjx/Ubn
 o6F9wIaxGZ+8nl2KYrKpMx8UeWLWDjG9ue+ROPE0rYIb0+bUh4Q80Y2/UsxD7/ggMSA4
 LRwce8bf4wHJ4/wat37LVIRlocn64F0y7Xnvgd62g+iC8fE0/bcZopaF1EEDIaq2G5nE
 Uqpxta3eluOnU6z53AZEVwXc0zw+Mtd1pvtVkr93I/18w1D9zvIgH/8MUpK2ZtnWRbq3
 6R3BAUCVcy0r+CTNymw7am0JSHCazq4U50IiZuNtkmHic45294sjQr8cMtQHkPKpEevL
 Pk7g==
X-Gm-Message-State: AOJu0YwhK59QKFXDvlYfKT9rf4kIH7S3rWZD1CSYCWL87wKCeCc3IRvK
 /kTRYYTrUjhJ03DmAhgnVNxwgZhSJVL/3gT5+sT7WwY7NpBbLAitdzJpuvgw4l7DQkiA5gv9MDf
 EN/JcUEshYU5m1tG+sY0rqGIG6ZgwPzVPMUVSOQ==
X-Gm-Gg: ASbGnctqNQ3YkY5PvbLRLvvDt79R1L6I0okxILAEy3/oY96nlg7AU2FijpLifhHXUg7
 uxQLRXozb4gmEH9p/Cg4fLYZPloFt35MVSZSIwj0VDyC9DSwhxrmg/1GPTbi/MbuU9beYCPOppw
 0lMfduAg7YxrJ7WPzL1sJHoDqYM/wQ
X-Google-Smtp-Source: AGHT+IGzL+h1JRDkcuAM8wiN9vmfy/2BZt1LyqMX1LDUowbPoeAzk5wM8M5Ak1LxRjsWEKKnZ5JDVJu5Ywa/RWpF2wk=
X-Received: by 2002:a17:90b:3786:b0:2fa:1851:a023 with SMTP id
 98e67ed59e1d1-2fa2451eccbmr4948963a91.35.1738941045149; Fri, 07 Feb 2025
 07:10:45 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-29-sjg@chromium.org>
 <CAEfUkUKoe+1LQaqOUb8_1M5yy8ELr=jG66+wRd1b3Oq5BB2bSA@mail.gmail.com>
 <CAFLszTg=UDJUdjCPsyMBjZ3r_r9dNyWYiXNrmhm8mxgEbQoaOg@mail.gmail.com>
 <CAEfUkUL7H5twRqZZBcfEHuExwtHFUrT9h7NV-3T0jx0c0SBEbw@mail.gmail.com>
 <CAFLszThvDjXTDdm7FiGZSBbtDv0px509x2jjn5WX++5Ck4PtOQ@mail.gmail.com>
In-Reply-To: <CAFLszThvDjXTDdm7FiGZSBbtDv0px509x2jjn5WX++5Ck4PtOQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 7 Feb 2025 10:10:31 -0500
X-Gm-Features: AWEUYZlTBX04ppWCuVv1JUzLdrRT6ezd1l5W5RWery33_dYkerBuGt_LNorK2B8
Message-ID: <CAEfUkUKoN_xGZ+sGTsdExgVpA54TfYD924VVnu-eQqNVO5tbHA@mail.gmail.com>
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

On Thu, 6 Feb 2025 at 19:09, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Thu, 6 Feb 2025 at 15:35, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Thu, 6 Feb 2025 at 10:41, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Raymond,
> > >
> > > On Wed, 5 Feb 2025 at 08:25, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > >
> > > > +CC Ilias,
> > > >
> > > > Hi Simon,
> > > >
> > > > On Tue, 4 Feb 2025 at 20:57, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > The logic of this has become too confusing.
> > > > >
> > > > > The primary issue with the patch is that U-Boot needs to set up a
> > > > > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > > > > phases can then use that bloblist.
> > > > >
> > > > > But the first phase of U-Boot cannot assume that one exists.
> > > > >
> > > > > Reverting this commit seems like a better starting point for getting
> > > > > things working for all use-cases.
> > > > >
> > > > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> > > > >
> > > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > >
> > > > If my understanding is correct, you want to add some logic to control
> > > > when the U-Boot should or should not get the bloblist from the
> > > > existing register argument.
> > > > But xferlist_from_boot_arg() should be called when a valid register
> > > > argument is there, I didn't see this in your patch.
> > > > Maybe you plan to do this with other patch series, but simply
> > > > reverting this results in a breaking of handoff policy and the
> > > > firmware handoff won't work.
> > >
> > > Yes, I certainly did not want to revert it, but the current code is
> > > too hard to understand and I did not look at it at the time it went
> > > in. I've had three tries at working with what you have here, but each
> > > turns to spaghetti.
> > >
> >
> > Still not very clear on what concerns you have and what is the way you
> > want to go.
> > The logic is straight forward, when U-Boot has a previous loader and
> > the registers pass in valid arguments - It indicates handoff should be
> > done using the transfer list.
> > Other kconfig options decide whether to use the passed in address
> > directly or copy to a predefined address.
> > But in either way, xferlist_from_boot_arg() is doing the right thing
> > to get the transfer list from the register if it exists and is valid.
> > I don't see a reason for removing it.
>
> Here is the initial code:
> >>>>
> bool from_addr = fixed && !xpl_is_first_phase();
> /*
> * If U-Boot is in the first phase that an arch custom routine should
> * install the bloblist passed from previous loader to this fixed
> * address.
> */
> bool from_boot_arg = fixed && xpl_is_first_phase();
>
> if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
>    from_addr = false;
> <<<<
>
> and by the way, that is my tree. In -next it is even worse:
> >>>>
> /*
> * If U-Boot is not in the first phase, an existing bloblist must be
> * at a fixed address.
> */
> bool from_addr = fixed && !xpl_is_first_phase();
> /*
> * If U-Boot is in the first phase that an arch custom routine should
> * install the bloblist passed from previous loader to this fixed
> * address.
> */
> bool from_boot_arg = fixed && xpl_is_first_phase();
>
> if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> from_addr = false;
> if (fixed)
> addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
>       CONFIG_BLOBLIST_ADDR);
> size = CONFIG_BLOBLIST_SIZE;
>
> if (from_boot_arg)
> ret = xferlist_from_boot_arg(addr, size);
> else if (from_addr)
> ret = bloblist_check(addr, size);
> <<<<
>
> I want to update it so that TPL creates a bloblist and passes it
> through the following phases, ending up at U-Boot.
>
> To my mind, if CONFIG_IS_ENABLED(BLOBLIST), then we should check the
> registers and always accept standard passage. If not, we should
> either:
> - create a bloblist (if this *is* the first phase with
> CONFIG_IS_ENABLED(BLOBLIST))
> - use an existing bloblistl, which must exist (if not)
>

To my mind, first we should check whether there is a valid transfer
list passed in, which is done by xferlist_from_boot_arg().
If it does, and BLOBLIST is selected, then use the transfer list as bloblist.
And we do need a new kconfig (e.g. FIRMWARE_HANDOFF_MANDATORY) to
determine whether fw handoff is mandatory.

See below pseudo code:
```
if (!xferlist_from_boot_arg()) {
    /* a valid transfer list exists */
    if (!CONFIG_IS_ENABLED(BLOBLIST))
        return ERROR;

    /* use the transfer list as a bloblist */
    [...]
} else if (CONFIG_IS_ENABLED(FIRMWARE_HANDOFF_MANDATORY)) {
    /* no valid transfer list passed in, but the arm spec is mandatory */
    return ERROR;
} else {
    /* arm spec is not in use at all, create or use a static bloblist */
    [...]
}
```

Regards,
Raymond


> I just don't think the existing logic is a good starting point as it
> is too confusing.
>
> Perhaps, putting it another way, what do you like about the current
> code (either version)?
>
> Regards,
> Simon
>
>
>
> >
> > Regards,
> > Raymond
> >
> > > I would like to build on this and get something running in CI which
> > > uses standard passage. As Tom suggests, perhaps we should disconnect
> > > bloblist and standard passage?
> > >
> > > On the CI point, is there a board we could add that uses the
> > > xferlist_from_boot_arg() call?
> > >
> > > Regards,
> > > Simon
> > >
> > > >
> > > > Regards,
> > > > Raymond
> > > >
> > > > >  common/bloblist.c  | 64 ++++++++++++++--------------------------------
> > > > >  include/bloblist.h | 10 --------
> > > > >  2 files changed, 19 insertions(+), 55 deletions(-)
> > > > >
> > > > > diff --git a/common/bloblist.c b/common/bloblist.c
> > > > > index e8acfc74331..7eda94ecdf9 100644
> > > > > --- a/common/bloblist.c
> > > > > +++ b/common/bloblist.c
> > > > > @@ -487,57 +487,37 @@ int bloblist_reloc(void *to, uint to_size)
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > -/*
> > > > > - * Weak default function for getting bloblist from boot args.
> > > > > - */
> > > > > -int __weak xferlist_from_boot_arg(ulong __always_unused addr,
> > > > > -                                 ulong __always_unused size)
> > > > > -{
> > > > > -       return -ENOENT;
> > > > > -}
> > > > > -
> > > > >  int bloblist_init(void)
> > > > >  {
> > > > >         bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
> > > > >         int ret = -ENOENT;
> > > > > -       ulong addr = 0, size;
> > > > > -       /*
> > > > > -        * If U-Boot is not in the first phase, an existing bloblist must be
> > > > > -        * at a fixed address.
> > > > > -        */
> > > > > -       bool from_addr = fixed && !xpl_is_first_phase();
> > > > > -       /*
> > > > > -        * If U-Boot is in the first phase that an arch custom routine should
> > > > > -        * install the bloblist passed from previous loader to this fixed
> > > > > +       ulong addr, size;
> > > > > +       bool expected;
> > > > > +
> > > > > +       /**
> > > > > +        * We don't expect to find an existing bloblist in the first phase of
> > > > > +        * U-Boot that runs. Also we have no way to receive the address of an
> > > > > +        * allocated bloblist from a previous stage, so it must be at a fixed
> > > > >          * address.
> > > > >          */
> > > > > -       bool from_boot_arg = fixed && xpl_is_first_phase();
> > > > > -
> > > > > +       expected = fixed && !xpl_is_first_phase();
> > > > >         if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> > > > > -               from_addr = false;
> > > > > +               expected = false;
> > > > >         if (fixed)
> > > > >                 addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> > > > >                                       CONFIG_BLOBLIST_ADDR);
> > > > >         size = CONFIG_BLOBLIST_SIZE;
> > > > > -
> > > > > -       if (from_boot_arg)
> > > > > -               ret = xferlist_from_boot_arg(addr, size);
> > > > > -       else if (from_addr)
> > > > > +       if (expected) {
> > > > >                 ret = bloblist_check(addr, size);
> > > > > -
> > > > > -       if (ret)
> > > > > -               log_warning("Bloblist at %lx not found (err=%d)\n",
> > > > > -                           addr, ret);
> > > > > -       else
> > > > > -               /* Get the real size */
> > > > > -               size = gd->bloblist->total_size;
> > > > > -
> > > > > +               if (ret) {
> > > > > +                       log_warning("Expected bloblist at %lx not found (err=%d)\n",
> > > > > +                                   addr, ret);
> > > > > +               } else {
> > > > > +                       /* Get the real size, if it is not what we expected */
> > > > > +                       size = gd->bloblist->total_size;
> > > > > +               }
> > > > > +       }
> > > > >         if (ret) {
> > > > > -               /*
> > > > > -                * If we don't have a bloblist from a fixed address, or the one
> > > > > -                * in the fixed address is not valid. we must allocate the
> > > > > -                * memory for it now.
> > > > > -                */
> > > > >                 if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
> > > > >                         void *ptr = memalign(BLOBLIST_ALIGN, size);
> > > > >
> > > > > @@ -545,8 +525,7 @@ int bloblist_init(void)
> > > > >                                 return log_msg_ret("alloc", -ENOMEM);
> > > > >                         addr = map_to_sysmem(ptr);
> > > > >                 } else if (!fixed) {
> > > > > -                       return log_msg_ret("BLOBLIST_FIXED is not enabled",
> > > > > -                                          ret);
> > > > > +                       return log_msg_ret("!fixed", ret);
> > > > >                 }
> > > > >                 log_debug("Creating new bloblist size %lx at %lx\n", size,
> > > > >                           addr);
> > > > > @@ -559,11 +538,6 @@ int bloblist_init(void)
> > > > >                 return log_msg_ret("ini", ret);
> > > > >         gd->flags |= GD_FLG_BLOBLIST_READY;
> > > > >
> > > > > -#ifdef DEBUG
> > > > > -       bloblist_show_stats();
> > > > > -       bloblist_show_list();
> > > > > -#endif
> > > > > -
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > diff --git a/include/bloblist.h b/include/bloblist.h
> > > > > index 1e1ca34aa92..5063ab66e4a 100644
> > > > > --- a/include/bloblist.h
> > > > > +++ b/include/bloblist.h
> > > > > @@ -482,14 +482,4 @@ static inline int bloblist_maybe_init(void)
> > > > >   */
> > > > >  int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig);
> > > > >
> > > > > -/**
> > > > > - * xferlist_from_boot_arg() - Get bloblist from the boot args and relocate it
> > > > > - *                           to the specified address.
> > > > > - *
> > > > > - * @addr: Address for the bloblist
> > > > > - * @size: Size of space reserved for the bloblist
> > > > > - * Return: 0 if OK, else on error
> > > > > - */
> > > > > -int xferlist_from_boot_arg(ulong addr, ulong size);
> > > > > -
> > > > >  #endif /* __BLOBLIST_H */
> > > > > --
> > > > > 2.43.0
> > > > >
