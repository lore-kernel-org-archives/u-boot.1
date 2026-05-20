Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08926CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 01:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D7B48488F;
	Wed, 20 May 2026 03:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XWUIkz6L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7186C84894; Wed, 20 May 2026 03:25:08 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00AFA84877
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 03:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-69d42abd04dso809469eaf.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 18:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779240299; x=1779845099; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WF2h5YemqmITirIUCsDN4/S5ccXQkjRcI1JYesPgGW8=;
 b=XWUIkz6LReZoXcIe9anruyD0SEw1eFkumJg4DbtwGuxmUxyILb3h0cAgwYUi/twJCt
 LqKGFw42KB1gWoruwPCMq115KCpQgyTQL3hPOcvxDVrVK9GGk9RSi6gpuhpznKg+0REM
 8RWtFotkfAegoyAx/M7JefwDnC+HB78Z//b9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779240299; x=1779845099;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WF2h5YemqmITirIUCsDN4/S5ccXQkjRcI1JYesPgGW8=;
 b=XisknEHmP2Px/pVbq0MX96/eQMHQbaqVN/JGTlVLZVFtIQwE43JtQ98uEANQU1uk5T
 ukZxw8iAqkbnyPqf/8Akj7GQavSkl1eAHKmzJ7dS8dObLZz3KuyyCJtTc+D2GXBnnBAN
 WTbZYe3ER+2qQsbj16Im7n8N2wAfxgPswEG8pOYCORj7pYeQQsUUinSwmTkSoXwqXV/q
 xyVrZ/63cJ5uwr+mC9fpzFup4JmV/dBb8AzpU+6V9Paf0Zy58wpRSUuoZ68sKZYCK+Ed
 /o4/IYio2G+lh/tB2j2216V1+8m+WtGkf2QFmtQV6VWXTJ15GHjU/zo+5Mm46gpNoVYt
 nHVw==
X-Gm-Message-State: AOJu0Yy9rHeTbOd50a7R6oebkvW+1QMChSv7V+pBFOiHLbkXRs1vT4SK
 hFyMID5UXCl0NXjtJMEwwCK09chHxX3SbVN4sNLrY3eHwEyIz8InvIUEQ1n2pdLgJlRCppydcjF
 painQ1DuMW/1f
X-Gm-Gg: Acq92OE5ehdVXdbFXdRSS81j1c9zRs5hG9Q03tmpBuGHIl2+AfxLevnQLDQVwKLUSZn
 76X8EexGGHSQ4eN5kZ+HHdOBmvb/kEj9r/QdfbqA7+g2l/hAlVWtK0CAFvS3VK5kpfkRufWHunY
 aN6t8FpuHavGkktWkW4FT9PdxKKP3KnqVoo7dQcasTRlOLJhPBSWiSKgm70ciVqJwJx9CQEveG3
 attkeTBpE/z765SqIFL1KBQLB3sPBXAwcGPlN1xbeI+EvFY6cgmnId06mCE2sVtuqRIr/5bQCgv
 9xRjHCdw5qZord/b4acVELDKNLjiq5Z5s8GzrUvBlt8plzof+0V5/C8cPgQiVit3zKEixli86vf
 XjvkaQuNXFyyDpba/F0zHbZ/Fa9bCY8ysxVpXjUZAtnFCORcKGy42IzOzPCBKus6YmwxIr/Febq
 hCRjHqqryVBUZGhZm25Li6CZNKw+mj0SKu9kkhsPSETD6luYBOwihHcgnUs8ZBdA/2wG+t+VRjO
 t9yobPdvqnZgqoJL3bVs3KxjOb6+NvQB6NGpciK4v0x3hQ32pw=
X-Received: by 2002:a05:6820:f005:b0:696:573c:9f16 with SMTP id
 006d021491bc7-69c942ae189mr14735676eaf.2.1779240299174; 
 Tue, 19 May 2026 18:24:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d041da4basm7929103eaf.0.2026.05.19.18.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 18:24:58 -0700 (PDT)
Date: Tue, 19 May 2026 19:24:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/3] bloblist: Rework bloblist_init and
 bloblist_maybe_init
Message-ID: <20260520012456.GK1858239@bill-the-cat>
References: <20260514175457.4047707-1-trini@konsulko.com>
 <20260519162225.770071-1-trini@konsulko.com>
 <20260519162225.770071-4-trini@konsulko.com>
 <CAMDkj5zeh9VzNRUayENHsVgAJ2Lw8k5qM+c0pv2oHWm6n02rVg@mail.gmail.com>
 <20260519233751.GI1858239@bill-the-cat>
 <CAMDkj5zFbiYWbGXu79qSy77uSn3Sk75DzsogjKSqYmsGUzGHuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9r4EXYVGJn3LUjNX"
Content-Disposition: inline
In-Reply-To: <CAMDkj5zFbiYWbGXu79qSy77uSn3Sk75DzsogjKSqYmsGUzGHuA@mail.gmail.com>
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


--9r4EXYVGJn3LUjNX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 08:51:12PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Tue, May 19, 2026 at 7:37=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Tue, May 19, 2026 at 07:30:53PM -0400, Raymond Mao wrote:
> > > Hi Tom,
> > >
> > > On Tue, May 19, 2026 at 12:23=E2=80=AFPM Tom Rini <trini@konsulko.com=
> wrote:
> > > >
> > > > With bloblist, we need to both see if one already exists as well as
> > > > create one if it does not. However, the current implementation lead=
s to
> > > > odd cases where we attempt to create a bloblist before this is poss=
ible
> > > > and have things be overly complicated when we are given one to work
> > > > with.
> > > >
> > > > This reworks things to instead have a bloblist_exists function, whi=
ch as
> > > > the name implies checks for an existing bloblist. This is used in
> > > > the case of booting, to see if we have one and in turn if we have a
> > > > device tree there as well as in the bloblist_init function to see i=
f we
> > > > need to do anything.
> > > >
> > > > In practical details, we move the logic from bloblist_init that was
> > > > checking for a bloblist to the new bloblist_exists function and the=
n can
> > > > clarify the logic as it is much easier to state when we know we do =
not
> > > > have one rather than all the ways we might have one. Then we have t=
he
> > > > locations that set gd->bloblist now also set the GD_FLG_BLOBLIST_RE=
ADY
> > > > flag.
> > > >
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > Changes in v2:
> > > > - As noted by Raymond, we need to still check if SPL is being passe=
d a
> > > >   bloblist by TPL.
> > > > ---
> > > >  common/bloblist.c  | 144 +++++++++++++++++++++++------------------=
----
> > > >  common/board_f.c   |   4 +-
> > > >  include/bloblist.h |  32 +++++-----
> > > >  lib/fdtdec.c       |  15 ++---
> > > >  4 files changed, 96 insertions(+), 99 deletions(-)
> > > >
> > > > diff --git a/common/bloblist.c b/common/bloblist.c
> > > > index 09afdd1f96b4..51ae9cc50a5f 100644
> > > > --- a/common/bloblist.c
> > > > +++ b/common/bloblist.c
> > > > @@ -448,6 +448,7 @@ int bloblist_new(ulong addr, uint size, uint fl=
ags, uint align_log2)
> > > >         hdr->align_log2 =3D align_log2 ? align_log2 : BLOBLIST_BLOB=
_ALIGN_LOG2;
> > > >         hdr->chksum =3D 0;
> > > >         gd->bloblist =3D hdr;
> > > > +       gd->flags |=3D GD_FLG_BLOBLIST_READY;
> > > >
> > > >         return 0;
> > > >  }
> > > > @@ -475,6 +476,7 @@ int bloblist_check(ulong addr, uint size)
> > > >                 return log_msg_ret("Bad checksum", -EIO);
> > > >         }
> > > >         gd->bloblist =3D hdr;
> > > > +       gd->flags |=3D GD_FLG_BLOBLIST_READY;
> > > >
> > > >         return 0;
> > > >  }
> > > > @@ -576,90 +578,88 @@ int __weak xferlist_from_boot_arg(ulong __alw=
ays_unused *addr)
> > > >         return -ENOENT;
> > > >  }
> > > >
> > > > -int bloblist_init(void)
> > > > +bool bloblist_exists(void)
> > > >  {
> > > > -       bool fixed =3D IS_ENABLED(CONFIG_BLOBLIST_FIXED);
> > > > -       int ret =3D 0;
> > > > -       ulong addr =3D 0, size;
> > > > +       int ret;
> > > > +       ulong addr =3D 0;
> > > >
> > > >         /* Check if a valid transfer list passed in */
> > > > -       if (!xferlist_from_boot_arg(&addr)) {
> > > > -               size =3D bloblist_get_total_size();
> > > > -       } else {
> > > > -               /*
> > > > -                * If U-Boot is not in the first phase, an existing=
 bloblist must
> > > > -                * be at a fixed address.
> > > > -                */
> > > > -               bool from_addr =3D fixed && !xpl_is_first_phase();
> > > > -
> > > > -               /*
> > > > -                * If Firmware Handoff is mandatory but no transfer=
 list is
> > > > -                * observed, report it as an error.
> > > > -                */
> > > > -               if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
> > > > -                       return -ENOENT;
> > > > -
> > > > -               ret =3D -ENOENT;
> > > > -
> > > > -               if (xpl_prev_phase() =3D=3D PHASE_TPL &&
> > > > -                   !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> > > > -                       from_addr =3D false;
> > > > -               if (fixed)
> > > > -                       addr =3D IF_ENABLED_INT(CONFIG_BLOBLIST_FIX=
ED,
> > > > -                                             CONFIG_BLOBLIST_ADDR);
> > > > -               size =3D CONFIG_BLOBLIST_SIZE;
> > > > -
> > > > -               if (from_addr)
> > > > -                       ret =3D bloblist_check(addr, size);
> > > > +       if (!xferlist_from_boot_arg(&addr))
> > > > +               goto found;
> > > >
> > > > -               if (ret)
> > > > -                       log_debug("Bloblist at %lx not found (err=
=3D%d)\n",
> > > > -                                 addr, ret);
> > > > -               else
> > > > -                       /* Get the real size */
> > > > -                       size =3D gd->bloblist->total_size;
> > > > -       }
> > > > +       /*
> > > > +        * If Firmware Handoff is mandatory but no transfer list is
> > > > +        * observed, report it as an error.
> > > > +        */
> > > > +       if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
> > > > +               return false;
> > > >
> > > > -       if (ret) {
> > > > -               /*
> > > > -                * If we don't have a bloblist from a fixed address=
, or the one
> > > > -                * in the fixed address is not valid. we must alloc=
ate the
> > > > -                * memory for it now.
> > > > -                */
> > > > -               if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
> > > > -                       void *ptr =3D memalign(BLOBLIST_ALIGN, size=
);
> > > > -
> > > > -                       if (!ptr)
> > > > -                               return log_msg_ret("alloc", -ENOMEM=
);
> > > > -                       addr =3D map_to_sysmem(ptr);
> > > > -               } else if (!fixed) {
> > > > -                       return log_msg_ret("BLOBLIST_FIXED is not e=
nabled",
> > > > -                                          ret);
> > > > -               }
> > > > -               log_debug("Creating new bloblist size %lx at %lx\n"=
, size,
> > > > -                         addr);
> > > > -               ret =3D bloblist_new(addr, size, 0, 0);
> > > > -       } else {
> > > > -               log_debug("Found existing bloblist size %lx at %lx\=
n", size,
> > > > -                         addr);
> > > > -       }
> > > > +       /*
> > > > +        * We have checked for a valid transfer list being passed. =
At this
> > > > +        * point, if we do not have a fixed address for the bloblis=
t, we cannot
> > > > +        * be provided with one.
> > > > +        */
> > > > +       if (xpl_is_first_phase() || !IS_ENABLED(CONFIG_BLOBLIST_FIX=
ED))
> > > > +               return false;
> > > >
> > > > -       if (ret)
> > > > -               return log_msg_ret("ini", ret);
> > > > -       gd->flags |=3D GD_FLG_BLOBLIST_READY;
> > > > +       /*
> > > > +        * Check for a valid list as the configured address.
> > > > +        */
> > > > +       addr =3D IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> > > > +                             CONFIG_BLOBLIST_ADDR);
> > > > +       ret =3D bloblist_check(addr, CONFIG_BLOBLIST_SIZE);
> > > > +       if (!ret)
> > > > +               goto found;
> > > > +
> > > > +       log_debug("Bloblist at %lx not found (err=3D%d)\n", addr, r=
et);
> > > > +       return false;
> > > >
> > > > +found:
> > > >  #ifdef DEBUG
> > > >         bloblist_show_stats();
> > > >         bloblist_show_list();
> > > >  #endif
> > > > -
> > > > -       return 0;
> > > > +       return true;
> > > >  }
> > > >
> > > > -int bloblist_maybe_init(void)
> > > > +int bloblist_init(void)
> > > >  {
> > > > -       if (CONFIG_IS_ENABLED(BLOBLIST) && !(gd->flags & GD_FLG_BLO=
BLIST_READY))
> > > > -               return bloblist_init();
> > > > +       int ret;
> > > > +       ulong addr =3D 0, size =3D CONFIG_BLOBLIST_SIZE;
> > > > +
> > > > +       if (gd->flags & GD_FLG_BLOBLIST_READY) {
> > > > +               log_debug("Found existing bloblist size %x at %p\n",
> > > > +                         gd->bloblist->total_size, gd->bloblist);
> > > > +               return 0;
> > > > +       }
> > > > +
> > >
> > > This part is a bit difficult to read.
> > > The patch seems to try to assume that '!(gd->flags &
> > > GD_FLG_BLOBLIST_READY)' means 'no handoff from the previous stage',
> >
> > Correct.
> >
> > > but I doubt this is a part of GD_FLG_BLOBLIST_READY's semantics.
> >
> > It is part of the semantics now, however with this patch. That said, I
> > don't love the name GD_FLG_BLOBLIST_READY but that name was a side
> > effect of the old behavior too and needing to bail out from
> > "maybe_init".
> >
> > > Under the 'handoff from the previous stage' scenario, if
> > > GD_FLG_BLOBLIST_READY is not set in time, the logic here breaks.
> >
> > Now that "exists" is not part of "init", we should have already called
> > bloblist_check and set the flag before we can get here.
> >
>=20
> Just one minor suggestion, can we introduce a GD_FLG_BLOBLIST_HANDOFF?
> Since the _READY has an ambiguity that "it is ready from alloc"...
> But with or without above suggested change, overall the patch cleans
> up the logics, thus it is fine to me:

That would be good to see in a follow-up, as I do worry about putting
too much in a patch.

> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks!

--=20
Tom

--9r4EXYVGJn3LUjNX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCag0NZQAKCRAr4qD1Cr/k
CrJnAQC4Vhixu8M+R5BApfndxB9L5UrlkN8F0nosWJ9eI7sSzQEA2i6BmuXUUZgP
/C2HVVsZrmAzmSl50ZzaN51jaxYRcQQ=
=V0YU
-----END PGP SIGNATURE-----

--9r4EXYVGJn3LUjNX--
