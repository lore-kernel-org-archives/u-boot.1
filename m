Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A04CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:38:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CD2A84874;
	Wed, 20 May 2026 01:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JyqtV2pH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D8B184877; Wed, 20 May 2026 01:37:59 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D774384868
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-4042fe53946so1609869fac.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779233874; x=1779838674; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QqgXqYMaDriQEAAo7zxSexdOCp9E7x2JjduAzIL19l4=;
 b=JyqtV2pHyupvmx1QEQzm2oZzQX8BpJbk6blXpF3ukxiJXo4B7ZL4vSweU/zjxfHhH4
 naijXRwwaev2oSlP+7XbSQWUFxMfmeaQQIgDUPvpPJKfU77N9WC68gj76eqEoKWmwIBn
 5ZjBy5Qp0ARJ6G/LaweMTXKglZjhzQpkrVlig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233874; x=1779838674;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QqgXqYMaDriQEAAo7zxSexdOCp9E7x2JjduAzIL19l4=;
 b=r0LwW1bbL+k6e6EFOqZYPxSTOsQ7uHLse3ulE5SH3opo2HSptVeYN1U7AdGx1zgHu2
 ZQ1YHLq9SpBnNJpD/J3XJ5mxo4CYu5G1NaqcINgOgcsblfS6WXF93Z92wmpmSG8Z02wD
 HC4suvNiDm1lhFGV7mnKDWuXtBuCITz8DJZk9MxKlnt87HcHjXY1aVGu7g2e8WDXu8p1
 fXDLfqVOFxKnM5ZnPXrLM53VABzNZP8RwUso8zWQ/UJEiATwHY8zEj7Rq3iH9MAI/a2Q
 UmauqliS4N+tsIRCiIk1sZbJpkeSbEJ/UMzOyJO9qZspA/fN7J1t7uxifSWWaAIPuvw/
 tkbQ==
X-Gm-Message-State: AOJu0YwRTdTr5ezxcll1yFjZlxcEE7Q4Q+AI0RvN6iksbBXFsO8Ezb7V
 KloWfRVU9t2MZvY0U6+AC/ZVAAcQYiwtrjFOF9iyTy6nazab8uhLTJhykRxo/cyDSps=
X-Gm-Gg: Acq92OHWbj00Vqz2gWLaMcXW4jQbNFgCtZMeR2CHjX2QJt5k8aD8LxZD69UNwNe97HB
 y76j40wan8ySHtDQM9yPxdmRRNLQna5QIVYkun0Ao4jKnwj//3AmjAguKCiRirlxLXFeGVZ+mKe
 vccyl+FPXQOmX6HNkMwpav29JOVzFoPeLwRYiOEvpf+kBvWl8/Nh5Qtf31v7ETQnLBZ7joWuKcb
 VwszSxqgqh3r6HsvMyxdUXFg/N5ewK1yif7+a81oPOtElrLPIro/E0/Padgbe1EhPt/h+4yu0qT
 gOFQ9lOMbDhdqXukJBSYDHTc7y25JpjbcuHF2M5/7+3rOKKWyWJ/wiUwJG/bh1fTzPKJWuPO2Jw
 fTXsgdLEvqVKqv5CqTM9i179jrrfvyP/Xlxz/ekEf6jw9+lVZpbYeA2869yTcjOI/SZ73z5pAlA
 mOvN65FvYJnCClgU2PkcjBF//UcHeC6c0Mfbj9cC7oxtqyDUDJRlfCu1zzHdNUDidpytXRT6jk2
 6y1q4bM8ISmu02n/0e3eHV4sKsAFzwiK8ArzM1CeX5ij0VXfK0=
X-Received: by 2002:a05:6820:4b8f:b0:696:97e3:1195 with SMTP id
 006d021491bc7-69c9bfb094cmr12919169eaf.49.1779233874409; 
 Tue, 19 May 2026 16:37:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d0460b68bsm8230115eaf.4.2026.05.19.16.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 16:37:53 -0700 (PDT)
Date: Tue, 19 May 2026 17:37:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/3] bloblist: Rework bloblist_init and
 bloblist_maybe_init
Message-ID: <20260519233751.GI1858239@bill-the-cat>
References: <20260514175457.4047707-1-trini@konsulko.com>
 <20260519162225.770071-1-trini@konsulko.com>
 <20260519162225.770071-4-trini@konsulko.com>
 <CAMDkj5zeh9VzNRUayENHsVgAJ2Lw8k5qM+c0pv2oHWm6n02rVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LVFgykaKrJkJvCQE"
Content-Disposition: inline
In-Reply-To: <CAMDkj5zeh9VzNRUayENHsVgAJ2Lw8k5qM+c0pv2oHWm6n02rVg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--LVFgykaKrJkJvCQE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 07:30:53PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Tue, May 19, 2026 at 12:23=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > With bloblist, we need to both see if one already exists as well as
> > create one if it does not. However, the current implementation leads to
> > odd cases where we attempt to create a bloblist before this is possible
> > and have things be overly complicated when we are given one to work
> > with.
> >
> > This reworks things to instead have a bloblist_exists function, which as
> > the name implies checks for an existing bloblist. This is used in
> > the case of booting, to see if we have one and in turn if we have a
> > device tree there as well as in the bloblist_init function to see if we
> > need to do anything.
> >
> > In practical details, we move the logic from bloblist_init that was
> > checking for a bloblist to the new bloblist_exists function and then can
> > clarify the logic as it is much easier to state when we know we do not
> > have one rather than all the ways we might have one. Then we have the
> > locations that set gd->bloblist now also set the GD_FLG_BLOBLIST_READY
> > flag.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Changes in v2:
> > - As noted by Raymond, we need to still check if SPL is being passed a
> >   bloblist by TPL.
> > ---
> >  common/bloblist.c  | 144 +++++++++++++++++++++++----------------------
> >  common/board_f.c   |   4 +-
> >  include/bloblist.h |  32 +++++-----
> >  lib/fdtdec.c       |  15 ++---
> >  4 files changed, 96 insertions(+), 99 deletions(-)
> >
> > diff --git a/common/bloblist.c b/common/bloblist.c
> > index 09afdd1f96b4..51ae9cc50a5f 100644
> > --- a/common/bloblist.c
> > +++ b/common/bloblist.c
> > @@ -448,6 +448,7 @@ int bloblist_new(ulong addr, uint size, uint flags,=
 uint align_log2)
> >         hdr->align_log2 =3D align_log2 ? align_log2 : BLOBLIST_BLOB_ALI=
GN_LOG2;
> >         hdr->chksum =3D 0;
> >         gd->bloblist =3D hdr;
> > +       gd->flags |=3D GD_FLG_BLOBLIST_READY;
> >
> >         return 0;
> >  }
> > @@ -475,6 +476,7 @@ int bloblist_check(ulong addr, uint size)
> >                 return log_msg_ret("Bad checksum", -EIO);
> >         }
> >         gd->bloblist =3D hdr;
> > +       gd->flags |=3D GD_FLG_BLOBLIST_READY;
> >
> >         return 0;
> >  }
> > @@ -576,90 +578,88 @@ int __weak xferlist_from_boot_arg(ulong __always_=
unused *addr)
> >         return -ENOENT;
> >  }
> >
> > -int bloblist_init(void)
> > +bool bloblist_exists(void)
> >  {
> > -       bool fixed =3D IS_ENABLED(CONFIG_BLOBLIST_FIXED);
> > -       int ret =3D 0;
> > -       ulong addr =3D 0, size;
> > +       int ret;
> > +       ulong addr =3D 0;
> >
> >         /* Check if a valid transfer list passed in */
> > -       if (!xferlist_from_boot_arg(&addr)) {
> > -               size =3D bloblist_get_total_size();
> > -       } else {
> > -               /*
> > -                * If U-Boot is not in the first phase, an existing blo=
blist must
> > -                * be at a fixed address.
> > -                */
> > -               bool from_addr =3D fixed && !xpl_is_first_phase();
> > -
> > -               /*
> > -                * If Firmware Handoff is mandatory but no transfer lis=
t is
> > -                * observed, report it as an error.
> > -                */
> > -               if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
> > -                       return -ENOENT;
> > -
> > -               ret =3D -ENOENT;
> > -
> > -               if (xpl_prev_phase() =3D=3D PHASE_TPL &&
> > -                   !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> > -                       from_addr =3D false;
> > -               if (fixed)
> > -                       addr =3D IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> > -                                             CONFIG_BLOBLIST_ADDR);
> > -               size =3D CONFIG_BLOBLIST_SIZE;
> > -
> > -               if (from_addr)
> > -                       ret =3D bloblist_check(addr, size);
> > +       if (!xferlist_from_boot_arg(&addr))
> > +               goto found;
> >
> > -               if (ret)
> > -                       log_debug("Bloblist at %lx not found (err=3D%d)=
\n",
> > -                                 addr, ret);
> > -               else
> > -                       /* Get the real size */
> > -                       size =3D gd->bloblist->total_size;
> > -       }
> > +       /*
> > +        * If Firmware Handoff is mandatory but no transfer list is
> > +        * observed, report it as an error.
> > +        */
> > +       if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
> > +               return false;
> >
> > -       if (ret) {
> > -               /*
> > -                * If we don't have a bloblist from a fixed address, or=
 the one
> > -                * in the fixed address is not valid. we must allocate =
the
> > -                * memory for it now.
> > -                */
> > -               if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
> > -                       void *ptr =3D memalign(BLOBLIST_ALIGN, size);
> > -
> > -                       if (!ptr)
> > -                               return log_msg_ret("alloc", -ENOMEM);
> > -                       addr =3D map_to_sysmem(ptr);
> > -               } else if (!fixed) {
> > -                       return log_msg_ret("BLOBLIST_FIXED is not enabl=
ed",
> > -                                          ret);
> > -               }
> > -               log_debug("Creating new bloblist size %lx at %lx\n", si=
ze,
> > -                         addr);
> > -               ret =3D bloblist_new(addr, size, 0, 0);
> > -       } else {
> > -               log_debug("Found existing bloblist size %lx at %lx\n", =
size,
> > -                         addr);
> > -       }
> > +       /*
> > +        * We have checked for a valid transfer list being passed. At t=
his
> > +        * point, if we do not have a fixed address for the bloblist, w=
e cannot
> > +        * be provided with one.
> > +        */
> > +       if (xpl_is_first_phase() || !IS_ENABLED(CONFIG_BLOBLIST_FIXED))
> > +               return false;
> >
> > -       if (ret)
> > -               return log_msg_ret("ini", ret);
> > -       gd->flags |=3D GD_FLG_BLOBLIST_READY;
> > +       /*
> > +        * Check for a valid list as the configured address.
> > +        */
> > +       addr =3D IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> > +                             CONFIG_BLOBLIST_ADDR);
> > +       ret =3D bloblist_check(addr, CONFIG_BLOBLIST_SIZE);
> > +       if (!ret)
> > +               goto found;
> > +
> > +       log_debug("Bloblist at %lx not found (err=3D%d)\n", addr, ret);
> > +       return false;
> >
> > +found:
> >  #ifdef DEBUG
> >         bloblist_show_stats();
> >         bloblist_show_list();
> >  #endif
> > -
> > -       return 0;
> > +       return true;
> >  }
> >
> > -int bloblist_maybe_init(void)
> > +int bloblist_init(void)
> >  {
> > -       if (CONFIG_IS_ENABLED(BLOBLIST) && !(gd->flags & GD_FLG_BLOBLIS=
T_READY))
> > -               return bloblist_init();
> > +       int ret;
> > +       ulong addr =3D 0, size =3D CONFIG_BLOBLIST_SIZE;
> > +
> > +       if (gd->flags & GD_FLG_BLOBLIST_READY) {
> > +               log_debug("Found existing bloblist size %x at %p\n",
> > +                         gd->bloblist->total_size, gd->bloblist);
> > +               return 0;
> > +       }
> > +
>=20
> This part is a bit difficult to read.
> The patch seems to try to assume that '!(gd->flags &
> GD_FLG_BLOBLIST_READY)' means 'no handoff from the previous stage',

Correct.

> but I doubt this is a part of GD_FLG_BLOBLIST_READY's semantics.

It is part of the semantics now, however with this patch. That said, I
don't love the name GD_FLG_BLOBLIST_READY but that name was a side
effect of the old behavior too and needing to bail out from
"maybe_init".

> Under the 'handoff from the previous stage' scenario, if
> GD_FLG_BLOBLIST_READY is not set in time, the logic here breaks.

Now that "exists" is not part of "init", we should have already called
bloblist_check and set the flag before we can get here.

--=20
Tom

--LVFgykaKrJkJvCQE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagz0SwAKCRAr4qD1Cr/k
CnJFAPsEWafNBNMc4b6nHrJ0KvJtHKf0xTDcaFIw3/j4RSM1VwEAuiBz18nWnMnn
VqVXi6Ht3d9Ti5Ep5kQpb6vR4N5iOgA=
=+dU4
-----END PGP SIGNATURE-----

--LVFgykaKrJkJvCQE--
