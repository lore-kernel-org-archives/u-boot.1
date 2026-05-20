Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C465CCD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 00:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DAAF84877;
	Wed, 20 May 2026 02:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d0XBxxOA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D9F8487C; Wed, 20 May 2026 02:51:27 +0200 (CEST)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB22584868
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 02:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-6314cc192a4so1213133137.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 17:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779238283; cv=none;
 d=google.com; s=arc-20240605;
 b=bhxa0071UYIgEf+00AA1rqS1ckkcF3Sjq4REv31O4r1WpC91HTz5z1cXenSyLP+AWS
 n0m5U1QL2LHx2KCNyHZBn9Z9AtrUafOxYdoDfsWHcgoVbFHO2556oNbC7+BTgSC3779S
 9MICuBVysSkvjz+Hdav4Z7p9VejwJzMxuqE2mCyJ8wUChGQHUEfaEY+8APa8xwI843aL
 m4M2W6lSepHUqsb+hiJE4L159oqAdpbQY3NgfgJsyqHSira5ibVYqh7UZHIdP8OLuPyl
 ZMlZnS5xTEOmSmkaHMu/CkUnIqelRefl0ETyff19lUpL9lBCeCm8A/Tl2RxUlVG/xs/I
 iz0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HLp4pRJPEMeD+tF0cGtPccAcqDi+RLuOHClfyS5rflY=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=F/Vrwq1zITWSP85FcQtEhbEjiVXNiDGMXu98S/Y4ScEukmQfPDAYqqfFUrjUGAI68/
 pi0ZpACzZYL9k+DGlQ2WeyrRUursO8MIitWUawboNm4+cl000oipp+VN87/51VET+yGF
 ywGFH63S8KPvIwJXThco1qpmmtv871sFQ94dmnpaTKO2zSeC/tUpMx/aai87En8s55DB
 JoMjAgT1VSs1InYvC4hNj8DwgWzyszeSmEHKsPlt88vfx/4bOykLLKdMy1NzTM8EDZ/k
 oK9wRZseNGOzn+30aFszfnUm/RU7LbQ6br5rOFF0C+YNViU4+RBfmfroflUScQajhF1w
 tdKg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779238283; x=1779843083; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLp4pRJPEMeD+tF0cGtPccAcqDi+RLuOHClfyS5rflY=;
 b=d0XBxxOAag3/eyDPLAdbKBlRXRKOoNC51I6tGzOpY4pQ1KH8nTRbfQJ24UojMZEGbV
 eNIE73FxZKmFZU0TSE88nipPA8cwa4zjwWAU5PTr4KVubNh0zGbYh0dyzFH7uHcoPPhH
 sNPylGXYKUEV0hLnjHPkmlYu9+4fma+3pXHFTjxTU0M3T/U1/iw9kulukqc8ZdHk/gYI
 ymlWh5B4hQ7tjyzNW4Aiatgoe04dmLP/9IXNyjgow1Qw3+1sF5sLnf7LSEpfhT3ByyFs
 wS7MoSbqFQqweU7UyxT+I8uztPlRfKAdp04zjIBEAggSZeX7Mu+SHhkxDzwJGfyBl9te
 OvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779238283; x=1779843083;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HLp4pRJPEMeD+tF0cGtPccAcqDi+RLuOHClfyS5rflY=;
 b=bTPX0NptpxWM6dLbSgZ1+GuzkyILHDdiYGVVv+QIVhNoElqGOLVlxJLoniIQ5Qy8NW
 Y/0TkFhT+79UyeiaJSY5+/iNE7hO9+niyeHE4Zxh8VUK0zq/meUiytEeyc3ylnRdVPW9
 WWReHJ4eZ3mcG89NZmYmNShJemkeF8gOqG1vkIgrti/W+5ZMQUH3uuY3XWmq2Q1PaG+w
 OmtJUtMJmxIk1wpym01eI8hFSneBvvhTIvzy2heHYJhx6Jtn6I+Tvs+BkbkqygyiqoWr
 C143yecqVU6DNsYIx8/B4qiUoaoohS4KhRGcKJ1N2+vVNFxCYMQ6v9KXVOvzGQ+55Kyb
 uphg==
X-Gm-Message-State: AOJu0YyLPaWugDAobRS+wVofv1ffgw7/aokveMJ/io2HpQ5LmAeXFApL
 ZBdulMWUKmzb/Qop/WmofDeRoSnYPLYz7z8KwwFNVxZjr1ia/va6cqdCXEMmMjILTImzAg/nJqJ
 xNJqHfp2SMDD1krfjw+79HXmPno3Z65OnlIBW
X-Gm-Gg: Acq92OF9MhyOHezxpNL1D6frZFrf6cZIHSdvE7o+ndtNqmUlN9PAl8nDWD10nyGmPrc
 oq6Fbe9YnlokegKPTrGuFG3eIK6tBPn1dITrNqE1G9o1hOGTJpbPI9L6MWmkNgyncH4EuGl9Egi
 BhWHMvcA8xitrD4t9S6KxGU5BgRTq9gMQ+P13A1UbWhtpVDA+05Z70DrXtqMP9E4iQaAX3vAgRh
 boFiUKsYA64a0ii5vbrByknZfiyBChnJmXEQ9WWFe36M2yJldMuwl0qB/yrT9TTouV7jvCmXQDO
 RU/HTyuM
X-Received: by 2002:a05:6102:14a4:b0:66b:a0d7:abc4 with SMTP id
 ada2fe7eead31-66ba0d7c68cmr404867137.0.1779238283366; Tue, 19 May 2026
 17:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260514175457.4047707-1-trini@konsulko.com>
 <20260519162225.770071-1-trini@konsulko.com>
 <20260519162225.770071-4-trini@konsulko.com>
 <CAMDkj5zeh9VzNRUayENHsVgAJ2Lw8k5qM+c0pv2oHWm6n02rVg@mail.gmail.com>
 <20260519233751.GI1858239@bill-the-cat>
In-Reply-To: <20260519233751.GI1858239@bill-the-cat>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Tue, 19 May 2026 20:51:12 -0400
X-Gm-Features: AVHnY4LYaSYAHsKTXoy1rjS4dggc7AJ2gPLpm9gfTzSbnfUw1adlcse7-Hxc3Z4
Message-ID: <CAMDkj5zFbiYWbGXu79qSy77uSn3Sk75DzsogjKSqYmsGUzGHuA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] bloblist: Rework bloblist_init and
 bloblist_maybe_init
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, May 19, 2026 at 7:37=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, May 19, 2026 at 07:30:53PM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Tue, May 19, 2026 at 12:23=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > With bloblist, we need to both see if one already exists as well as
> > > create one if it does not. However, the current implementation leads =
to
> > > odd cases where we attempt to create a bloblist before this is possib=
le
> > > and have things be overly complicated when we are given one to work
> > > with.
> > >
> > > This reworks things to instead have a bloblist_exists function, which=
 as
> > > the name implies checks for an existing bloblist. This is used in
> > > the case of booting, to see if we have one and in turn if we have a
> > > device tree there as well as in the bloblist_init function to see if =
we
> > > need to do anything.
> > >
> > > In practical details, we move the logic from bloblist_init that was
> > > checking for a bloblist to the new bloblist_exists function and then =
can
> > > clarify the logic as it is much easier to state when we know we do no=
t
> > > have one rather than all the ways we might have one. Then we have the
> > > locations that set gd->bloblist now also set the GD_FLG_BLOBLIST_READ=
Y
> > > flag.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > Changes in v2:
> > > - As noted by Raymond, we need to still check if SPL is being passed =
a
> > >   bloblist by TPL.
> > > ---
> > >  common/bloblist.c  | 144 +++++++++++++++++++++++--------------------=
--
> > >  common/board_f.c   |   4 +-
> > >  include/bloblist.h |  32 +++++-----
> > >  lib/fdtdec.c       |  15 ++---
> > >  4 files changed, 96 insertions(+), 99 deletions(-)
> > >
> > > diff --git a/common/bloblist.c b/common/bloblist.c
> > > index 09afdd1f96b4..51ae9cc50a5f 100644
> > > --- a/common/bloblist.c
> > > +++ b/common/bloblist.c
> > > @@ -448,6 +448,7 @@ int bloblist_new(ulong addr, uint size, uint flag=
s, uint align_log2)
> > >         hdr->align_log2 =3D align_log2 ? align_log2 : BLOBLIST_BLOB_A=
LIGN_LOG2;
> > >         hdr->chksum =3D 0;
> > >         gd->bloblist =3D hdr;
> > > +       gd->flags |=3D GD_FLG_BLOBLIST_READY;
> > >
> > >         return 0;
> > >  }
> > > @@ -475,6 +476,7 @@ int bloblist_check(ulong addr, uint size)
> > >                 return log_msg_ret("Bad checksum", -EIO);
> > >         }
> > >         gd->bloblist =3D hdr;
> > > +       gd->flags |=3D GD_FLG_BLOBLIST_READY;
> > >
> > >         return 0;
> > >  }
> > > @@ -576,90 +578,88 @@ int __weak xferlist_from_boot_arg(ulong __alway=
s_unused *addr)
> > >         return -ENOENT;
> > >  }
> > >
> > > -int bloblist_init(void)
> > > +bool bloblist_exists(void)
> > >  {
> > > -       bool fixed =3D IS_ENABLED(CONFIG_BLOBLIST_FIXED);
> > > -       int ret =3D 0;
> > > -       ulong addr =3D 0, size;
> > > +       int ret;
> > > +       ulong addr =3D 0;
> > >
> > >         /* Check if a valid transfer list passed in */
> > > -       if (!xferlist_from_boot_arg(&addr)) {
> > > -               size =3D bloblist_get_total_size();
> > > -       } else {
> > > -               /*
> > > -                * If U-Boot is not in the first phase, an existing b=
loblist must
> > > -                * be at a fixed address.
> > > -                */
> > > -               bool from_addr =3D fixed && !xpl_is_first_phase();
> > > -
> > > -               /*
> > > -                * If Firmware Handoff is mandatory but no transfer l=
ist is
> > > -                * observed, report it as an error.
> > > -                */
> > > -               if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
> > > -                       return -ENOENT;
> > > -
> > > -               ret =3D -ENOENT;
> > > -
> > > -               if (xpl_prev_phase() =3D=3D PHASE_TPL &&
> > > -                   !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> > > -                       from_addr =3D false;
> > > -               if (fixed)
> > > -                       addr =3D IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED=
,
> > > -                                             CONFIG_BLOBLIST_ADDR);
> > > -               size =3D CONFIG_BLOBLIST_SIZE;
> > > -
> > > -               if (from_addr)
> > > -                       ret =3D bloblist_check(addr, size);
> > > +       if (!xferlist_from_boot_arg(&addr))
> > > +               goto found;
> > >
> > > -               if (ret)
> > > -                       log_debug("Bloblist at %lx not found (err=3D%=
d)\n",
> > > -                                 addr, ret);
> > > -               else
> > > -                       /* Get the real size */
> > > -                       size =3D gd->bloblist->total_size;
> > > -       }
> > > +       /*
> > > +        * If Firmware Handoff is mandatory but no transfer list is
> > > +        * observed, report it as an error.
> > > +        */
> > > +       if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
> > > +               return false;
> > >
> > > -       if (ret) {
> > > -               /*
> > > -                * If we don't have a bloblist from a fixed address, =
or the one
> > > -                * in the fixed address is not valid. we must allocat=
e the
> > > -                * memory for it now.
> > > -                */
> > > -               if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
> > > -                       void *ptr =3D memalign(BLOBLIST_ALIGN, size);
> > > -
> > > -                       if (!ptr)
> > > -                               return log_msg_ret("alloc", -ENOMEM);
> > > -                       addr =3D map_to_sysmem(ptr);
> > > -               } else if (!fixed) {
> > > -                       return log_msg_ret("BLOBLIST_FIXED is not ena=
bled",
> > > -                                          ret);
> > > -               }
> > > -               log_debug("Creating new bloblist size %lx at %lx\n", =
size,
> > > -                         addr);
> > > -               ret =3D bloblist_new(addr, size, 0, 0);
> > > -       } else {
> > > -               log_debug("Found existing bloblist size %lx at %lx\n"=
, size,
> > > -                         addr);
> > > -       }
> > > +       /*
> > > +        * We have checked for a valid transfer list being passed. At=
 this
> > > +        * point, if we do not have a fixed address for the bloblist,=
 we cannot
> > > +        * be provided with one.
> > > +        */
> > > +       if (xpl_is_first_phase() || !IS_ENABLED(CONFIG_BLOBLIST_FIXED=
))
> > > +               return false;
> > >
> > > -       if (ret)
> > > -               return log_msg_ret("ini", ret);
> > > -       gd->flags |=3D GD_FLG_BLOBLIST_READY;
> > > +       /*
> > > +        * Check for a valid list as the configured address.
> > > +        */
> > > +       addr =3D IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> > > +                             CONFIG_BLOBLIST_ADDR);
> > > +       ret =3D bloblist_check(addr, CONFIG_BLOBLIST_SIZE);
> > > +       if (!ret)
> > > +               goto found;
> > > +
> > > +       log_debug("Bloblist at %lx not found (err=3D%d)\n", addr, ret=
);
> > > +       return false;
> > >
> > > +found:
> > >  #ifdef DEBUG
> > >         bloblist_show_stats();
> > >         bloblist_show_list();
> > >  #endif
> > > -
> > > -       return 0;
> > > +       return true;
> > >  }
> > >
> > > -int bloblist_maybe_init(void)
> > > +int bloblist_init(void)
> > >  {
> > > -       if (CONFIG_IS_ENABLED(BLOBLIST) && !(gd->flags & GD_FLG_BLOBL=
IST_READY))
> > > -               return bloblist_init();
> > > +       int ret;
> > > +       ulong addr =3D 0, size =3D CONFIG_BLOBLIST_SIZE;
> > > +
> > > +       if (gd->flags & GD_FLG_BLOBLIST_READY) {
> > > +               log_debug("Found existing bloblist size %x at %p\n",
> > > +                         gd->bloblist->total_size, gd->bloblist);
> > > +               return 0;
> > > +       }
> > > +
> >
> > This part is a bit difficult to read.
> > The patch seems to try to assume that '!(gd->flags &
> > GD_FLG_BLOBLIST_READY)' means 'no handoff from the previous stage',
>
> Correct.
>
> > but I doubt this is a part of GD_FLG_BLOBLIST_READY's semantics.
>
> It is part of the semantics now, however with this patch. That said, I
> don't love the name GD_FLG_BLOBLIST_READY but that name was a side
> effect of the old behavior too and needing to bail out from
> "maybe_init".
>
> > Under the 'handoff from the previous stage' scenario, if
> > GD_FLG_BLOBLIST_READY is not set in time, the logic here breaks.
>
> Now that "exists" is not part of "init", we should have already called
> bloblist_check and set the flag before we can get here.
>

Just one minor suggestion, can we introduce a GD_FLG_BLOBLIST_HANDOFF?
Since the _READY has an ambiguity that "it is ready from alloc"...
But with or without above suggested change, overall the patch cleans
up the logics, thus it is fine to me:
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Regards,
Raymond

> --
> Tom
