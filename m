Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA89CD4851
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 00:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABB1384877;
	Sat, 16 May 2026 02:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TIoW46kZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3362F84886; Sat, 16 May 2026 02:11:07 +0200 (CEST)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 867DE84812
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 02:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-95f6b47b309so50756241.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 17:11:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778890261; cv=none;
 d=google.com; s=arc-20240605;
 b=B2d0BggI2SNk/kZSXwp8nOpRpQgwGlGibHqDgzU1WAb46Azpuj0J9UP31k+yRWbrNB
 aeSl4VGu244Pf80kBj6bqeVsbY7N2zKqTOgiywgUl6b+46pteJl164yHbGjsxGlc/P8C
 ib5Gjdyg0KGK3tX43PLr2ltGKBjt/7m1FOhgbIb6LJljzkY9QP+YLqd4C+t+DYxEuKSG
 7wqDTKjRIUOeO+du4z307P/bxyQPEOp/qDy+LlMDww88CqsEYg3kByckBjoqZwiHWxbW
 sTrQTyJeF+7BvqB8itLHMU53jvSsZ4Pev7NAdoBohkyF+75MbMEjPhj+sPpEaMQelRD2
 5v2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xWGve6nAq0oy2xY/P4XlvKrHBnlY0TqCFw9SrvowwCU=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=hA13HqfNoP31TvYkC26K/S/0usZo+twh40s27nqD+H9QMH5B+utQrm14xEjJrRmGaj
 S40FxM1fKL4fVscMO2S6Yi5dkZ5zd9WcCg9/GdENZhUlCfzOe6FqEOFpZjxr2TqR03kb
 9VpLy3ZykhMIerp9olIYw1MR3RycTyT2yS0fJU/M7A1gPMPRZ8pGBGl7+FR5KcR6eGB4
 zB9rL72LpudN0d5mOjQteqH7J81LeWMbs6R+c4gMIqWxV/UD5v79fWC85utYF7IKMUB5
 OsOcVoad04o8ZtYgWoUrWYQJxHBDDy4I8TLJUqViMF3ocz613Y4aJpNH3bO6pqN7HFOn
 v6VA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778890261; x=1779495061; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xWGve6nAq0oy2xY/P4XlvKrHBnlY0TqCFw9SrvowwCU=;
 b=TIoW46kZX0ajonPd1Rk4EpfAdymZUWQ+g0sjIFr9Of/7t2koB+KxtMxOcgIFFSiEcq
 +bCJQct01/VOEkMrsWyumNDk8Tr4M3Bw+DE8J+gJyuSvQIDxod9LgleGW8tcgWvqiePn
 Q9SLyMkeV5Ak8t1FTkykqFz3CiICd92d0SWyvDMY3pdsjhSyuPNHxhEU3p0gpPS+vJ4G
 GYSWzU7v1glUBdBpjV9ZmkxtMJVE6SqPxqy2VjKcz6eBbaxXvE6lLPdXyJxNuDn75I8V
 8laJtqhN/dJA8qbTp+T3qBTJTC+czM2cV0QmghozOGQ5vYeRLe/XsM73n+15XL2uavQD
 7dDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778890261; x=1779495061;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xWGve6nAq0oy2xY/P4XlvKrHBnlY0TqCFw9SrvowwCU=;
 b=YP/2252vAlR5BoQjvjl911AABy7V1tUi6E5qRaFFIWTztAbaXj4Dw/pZz06Au2Xv/1
 COQEKAt6gWy+P2IeW8RcttqK8Gy2ppwwmXTL5qpbKAzwpwcJwBJjWKTRr2I6jUjklBE8
 JVSBREnn5YHStzoVbko2oPHyNIRibi8KBMe/cStvZdcCQC/f6dJrRMJSsCcZRgP5tpOg
 bwoBMZv+/K/y9JGA2pNRwKQcCqB9l6nZ8zMhP6YbgTYyW3N2Kva0O9eTjBrqF2TihnS1
 0QcSdjpQr1cUkAomGpQZZaZk6nkZuQe7vYB51DKl01j98tSmJ0E4py/LWHwc7JGMRSRW
 dt9g==
X-Gm-Message-State: AOJu0Yx4Xjz/oYJLAPmxwwTUYvK8DKSr7kSSI43IvLCA5a+DQbzw0qTJ
 g2w3/cVHEIQ2tpfnX0BNQkkaJQ3T9pHKzCUwBKRzQFPTGqnQkK1k8J4d70f6hCAF0vrd0V8jgtc
 gl4ZpPK1zJcS202QMlr1PiHVRU0wMpPVjoQ==
X-Gm-Gg: Acq92OFAeYsjhqchg2N5BnxuS4JHhKxFAIunqmJfM5SGTrjH2JLpY17t4jMvuLRC42e
 j8D94hqWJElQ7yuOkQWPCRmSIS4W8MVRIQcv2k6p/wb8tt/n9sMvN9pru7DENBQPacfhmhU1VbS
 ELaBe1arWsHi3yvYLKRdom7Wk37NEwrLMnb3OT4ygFILHBB0DCQingwJJaSgN0yu5D1DT/7KA2p
 Cb+SQj3c4UEm0u8RwybXnh875UKf0Moy2Vv73NDy9HxKrGA8Ut5b+mEMX7V3PkMuv3NTMpP7L86
 iG2kHR+fJ7tTwoo2wnE=
X-Received: by 2002:a05:6102:6444:b0:611:6fef:90d with SMTP id
 ada2fe7eead31-63a404b93c7mr3840687137.31.1778890260526; Fri, 15 May 2026
 17:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260514175457.4047707-1-trini@konsulko.com>
 <20260514175457.4047707-4-trini@konsulko.com>
 <CAMDkj5zyg1YcjwphhqKiZYX9DpzwjzDWLdecT2=a_0sGbhSCjw@mail.gmail.com>
 <20260515163054.GG1858239@bill-the-cat>
In-Reply-To: <20260515163054.GG1858239@bill-the-cat>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 15 May 2026 20:10:48 -0400
X-Gm-Features: AVHnY4LWzR_EMX4S9g-uABiu5qGgVFopw_SSnHPzmT3Qbz_-IVsCRZLXf4ntZY4
Message-ID: <CAMDkj5yb1cmqe3FEYnoQzPpG5+VCasi4FX7+RGwe8BLMDwo36w@mail.gmail.com>
Subject: Re: [PATCH 3/3] bloblist: Rework bloblist_init and bloblist_maybe_init
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

On Fri, May 15, 2026 at 12:30=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Fri, May 15, 2026 at 11:05:47AM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Thu, May 14, 2026 at 1:55=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
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
> > > +       /*
> > > +        * If Firmware Handoff is mandatory but no transfer list has =
been
> > > +        * observed by fdtdec_setup, report it as an error.
> > > +        */
> > > +       if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
> > > +               return -ENOENT;
> > > +
> > > +       /*
> > > +        * If we don't have an existing bloblist, we either need
> > > +        * to allocate one now, or initialize the fixed address
> > > +        * space as a bloblist.
> > > +        */
> > > +       if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
> > > +               void *ptr =3D memalign(BLOBLIST_ALIGN, size);
> > > +
> > > +               if (!ptr)
> > > +                       return log_msg_ret("alloc", -ENOMEM);
> > > +               addr =3D map_to_sysmem(ptr);
> > > +       } else
> > > +               addr =3D IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> > > +                                     CONFIG_BLOBLIST_ADDR);
> > > +
> > > +       log_debug("Creating new bloblist size %lx at %lx\n", size,
> > > +                 addr);
> > > +       ret =3D bloblist_new(addr, size, 0, 0);
> > > +       if (ret)
> > > +               return log_msg_ret("ini", ret);
> > >
> > >         return 0;
> > >  }
> > > @@ -687,7 +687,9 @@ int bloblist_check_reg_conv(ulong rfdt, ulong rze=
ro, ulong rsig, ulong xlist)
> > >                 return ret;
> > >
> > >         if (rfdt !=3D (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0))=
 {
> > > -               gd->bloblist =3D NULL;  /* Reset the gd bloblist poin=
ter */
> > > +               /* Remove this bloblist from gd */
> > > +               gd->bloblist =3D NULL;
> > > +               gd->flags &=3D ~GD_FLG_BLOBLIST_READY;
> > >                 return -EIO;
> > >         }
> > >
> > > diff --git a/common/board_f.c b/common/board_f.c
> > > index ce87c619e680..c39e3b940d3b 100644
> > > --- a/common/board_f.c
> > > +++ b/common/board_f.c
> > > @@ -894,7 +894,9 @@ static void initcall_run_f(void)
> > >         INITCALL(log_init);
> > >         INITCALL(initf_bootstage); /* uses its own timer, so does not=
 need DM */
> > >         INITCALL(event_init);
> > > -       INITCALL(bloblist_maybe_init);
> > > +#if CONFIG_IS_ENABLED(BLOBLIST)
> > > +       INITCALL(bloblist_init);
> > > +#endif
> > >         INITCALL(setup_spl_handoff);
> > >  #if CONFIG_IS_ENABLED(CONSOLE_RECORD_INIT_F)
> > >         INITCALL(console_record_init);
> > > diff --git a/include/bloblist.h b/include/bloblist.h
> > > index e67b2a76358d..4c5787729654 100644
> > > --- a/include/bloblist.h
> > > +++ b/include/bloblist.h
> > > @@ -488,10 +488,24 @@ const char *bloblist_tag_name(enum bloblist_tag=
_t tag);
> > >   */
> > >  int bloblist_reloc(void *to, uint to_size);
> > >
> > > +/**
> > > + * bloblist_exists() - Check for the prior existence of a bloblist
> > > + *
> > > + * This will check for a transfer list having been passed via standa=
rd
> > > + * convention. If CONFIG_BLOBLIST_PASSAGE_MANDATORY is selected and =
one is not
> > > + * found, we return false.
> > > + *
> > > + * If CONFIG_BLOBLIST_FIXED is selected, it uses CONFIG_BLOBLIST_ADD=
R and
> > > + * CONFIG_BLOBLIST_SIZE to check for a bloblist.
> > > + *
> > > + * Return: true if found, false if not
> > > + */
> > > +bool bloblist_exists(void);
> > > +
> > >  /**
> > >   * bloblist_init() - Init the bloblist system with a single bloblist
> > >   *
> > > - * This locates and sets up the blocklist for use.
> > > + * This creates a bloblist for use, if not already found.
> > >   *
> > >   * If CONFIG_BLOBLIST_FIXED is selected, it uses CONFIG_BLOBLIST_ADD=
R and
> > >   * CONFIG_BLOBLIST_SIZE to set up a bloblist for use by U-Boot.
> > > @@ -508,22 +522,6 @@ int bloblist_reloc(void *to, uint to_size);
> > >   */
> > >  int bloblist_init(void);
> > >
> > > -#if CONFIG_IS_ENABLED(BLOBLIST)
> > > -/**
> > > - * bloblist_maybe_init() - Init the bloblist system if not already d=
one
> > > - *
> > > - * Calls bloblist_init() if the GD_FLG_BLOBLIST_READY flag is not se=
t
> > > - *
> > > - * Return: 0 if OK, -ve on error
> > > - */
> > > -int bloblist_maybe_init(void);
> > > -#else
> > > -static inline int bloblist_maybe_init(void)
> > > -{
> > > -       return 0;
> > > -}
> > > -#endif /* BLOBLIST */
> > > -
> > >  /**
> > >   * bloblist_check_reg_conv() - Check whether the bloblist is complia=
nt to
> > >   *                            the register conventions according to =
the
> > > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > > index c67b6e8c133e..7fd7f7ff01e5 100644
> > > --- a/lib/fdtdec.c
> > > +++ b/lib/fdtdec.c
> > > @@ -1822,17 +1822,12 @@ int fdtdec_setup(void)
> > >         int ret =3D -ENOENT;
> > >
> > >         /*
> > > -        * If allowing a bloblist, check that first. There was discus=
sion about
> > > -        * adding an OF_BLOBLIST Kconfig, but this was rejected.
> > > -        *
> > > -        * The necessary test is whether the previous phase passed a =
bloblist,
> > > -        * not whether this phase creates one.
> > > +        * If allowing a bloblist, check that first. The necessary te=
st is
> > > +        * whether the previous phase passed a bloblist, not whether =
this phase
> > > +        * creates one.
> > >          */
> > > -       if (CONFIG_IS_ENABLED(BLOBLIST) &&
> > > -           (xpl_prev_phase() !=3D PHASE_TPL ||
> > > -            IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> > > -               ret =3D bloblist_maybe_init();
> > > -               if (!ret) {
> > > +       if (CONFIG_IS_ENABLED(BLOBLIST) && (xpl_prev_phase() !=3D PHA=
SE_TPL)) {
> >
> > I think this change drops the TPL-provided blobs on TPL->SPL boots.
> > When TPL_BLOBLIST is selected, the next phase starts with
> > xpl_prev_phase() =3D=3D PHASE_TPL.
> > This new guard now skips bloblist_exists(), so gd->flags never gets
> > GD_FLG_BLOBLIST_READY; the later bloblist_init() in common/spl/spl.c
> > then creates a fresh bloblist and overwrites the fixed-address list
> > from TPL.
>
> Ah right, oops. I guess the only question is if we should continue to
> optimize the TPL case (it can't exist) or just always check (maybe
> there's some 4 stage boot..).
>

That really depends on whether we shall consider the scenario of TPL.
For the case of the Arm Firmware Handoff, stages before BL2 are not
considered to hand information over to the next stage via Transfer
List (aka. bloblist in U-Boot).

Regards,
Raymond

> --
> Tom
