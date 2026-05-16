Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A9BCD4F21
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 15:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AE6384671;
	Sat, 16 May 2026 17:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t4mBP2SH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC88584676; Sat, 16 May 2026 17:32:17 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A2AA845E3
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 17:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-404254ffe8aso726433fac.0
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778945534; x=1779550334; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BP/tyuimQQpq2VV47bdvKWV9gAOU6WPJaC15i9wrKpA=;
 b=t4mBP2SHOMil533UmN0/kA43Zmg0CT0hK1i5KzRORXfBQNGURnw30L6WgrY0UonSiQ
 HPs048NjFfDbtYFnMYnhswV2dw5+gLIdAzCGEt1tmre4zVgX8EXur1zXuNiKTxV2zDXR
 fHwFPBnJL14i1MGOttepeEVcmqic0ep5LpcZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778945534; x=1779550334;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BP/tyuimQQpq2VV47bdvKWV9gAOU6WPJaC15i9wrKpA=;
 b=L8h3a1YNrf1jkn5moTbeEMbiFotZr6Pfuo191zp4DWuMBwk/oPQiqvnhnzDUgI7YcZ
 gihP5smNpc3SOtWcPfiSgWRlHuYEvkR8L/GUq6CUfNNv6gdbqZsQJTXDnVPMigEROYti
 uPcUlXSK+MTOwDKRyBMbqAWYptGbUa3c5EJh//NFlo7R2i1tDjmVtyD2WoiktRRFI1HY
 z86xH0Mk1RE1HwKQzLep9DLRRJrsz4QrsbQfG+ohf7vP1pUm0oplLFTTwTqPE7/+HuTx
 NCESkqP+X0fSSf8wUoT13RkRfDC2FfT7zZ5W456n49UJV01aKMNWC8cRa3G+n5fIAKDT
 3ZBQ==
X-Gm-Message-State: AOJu0YzUYM6Occ+/sGUKPNQj/nBkZgWoLs9zgDSUEB5GcWk8Ke3G5ghD
 anztgzmmDb8l29XgzgMZSKWgYKWT44cVzhbjFFm0laNYdhtU6P56wtg1AHa3vAJlUTc=
X-Gm-Gg: Acq92OHAaNSIKSQ4qmLS4RuPTnRjFQ9GRGMTBtuvck4UnclfE7w/8EY9UinvPOXtOjf
 cy6pPija0dw8axLBY9vu1vRh6qJIPT9/QV9Af1TBiOpKzag8O3OFv3paWmtF9ZGWF61BBgfg5BB
 jpK5RyHLqAWtmQwa2oDOyaw8RqLbEcPm49K8xcsAfrPzVOvNWmRZkLVcRXlf4UpkAeg+8OflBfj
 EMofxmICPFfqmR+s8wCEqzbGutQ/pQLl4awYkXHyQNDkRh5Q/7G+sdpeCW4Z4g8cX9Iwb7Sp3kd
 IzuRjThy8PEcYlSK13QDPp8qUYkEoO3es559devx2NM9o9fRU5zonE82SCLlQGhQR/YoOe103oD
 VMW2zRjPuFI0+KHYf32SAHKCOFbjq9tJJhsIJZgGRVTq6qgLb1/Bg5DHMpfUyqGd1T8SbMeIgAX
 YiM9dcSaMHnmrAoudIbbJDWmCoNXRbbSSmmkTU+0bcfV5DCyznmqkpWbOOFXxTAcRLLO5IPHBHy
 dOW6zmYnBbHecDqH+xCQ5BI74yb03oXdE/4c36NWVCiFBEb8y/6JCazJZE87A==
X-Received: by 2002:a05:6870:8dcd:b0:430:3591:26c6 with SMTP id
 586e51a60fabf-439f90ef68amr6834903fac.4.1778945533790; 
 Sat, 16 May 2026 08:32:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-439fc1fc14csm6769343fac.6.2026.05.16.08.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 08:32:12 -0700 (PDT)
Date: Sat, 16 May 2026 09:32:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] bloblist: Rework bloblist_init and bloblist_maybe_init
Message-ID: <20260516153210.GO1858239@bill-the-cat>
References: <20260514175457.4047707-1-trini@konsulko.com>
 <20260514175457.4047707-4-trini@konsulko.com>
 <CAMDkj5zyg1YcjwphhqKiZYX9DpzwjzDWLdecT2=a_0sGbhSCjw@mail.gmail.com>
 <20260515163054.GG1858239@bill-the-cat>
 <CAMDkj5yb1cmqe3FEYnoQzPpG5+VCasi4FX7+RGwe8BLMDwo36w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="owdlBzfXH93kEDvn"
Content-Disposition: inline
In-Reply-To: <CAMDkj5yb1cmqe3FEYnoQzPpG5+VCasi4FX7+RGwe8BLMDwo36w@mail.gmail.com>
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


--owdlBzfXH93kEDvn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 08:10:48PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Fri, May 15, 2026 at 12:30=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Fri, May 15, 2026 at 11:05:47AM -0400, Raymond Mao wrote:
> > > Hi Tom,
> > >
> > > On Thu, May 14, 2026 at 1:55=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
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
> > > > +       /*
> > > > +        * If Firmware Handoff is mandatory but no transfer list ha=
s been
> > > > +        * observed by fdtdec_setup, report it as an error.
> > > > +        */
> > > > +       if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
> > > > +               return -ENOENT;
> > > > +
> > > > +       /*
> > > > +        * If we don't have an existing bloblist, we either need
> > > > +        * to allocate one now, or initialize the fixed address
> > > > +        * space as a bloblist.
> > > > +        */
> > > > +       if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
> > > > +               void *ptr =3D memalign(BLOBLIST_ALIGN, size);
> > > > +
> > > > +               if (!ptr)
> > > > +                       return log_msg_ret("alloc", -ENOMEM);
> > > > +               addr =3D map_to_sysmem(ptr);
> > > > +       } else
> > > > +               addr =3D IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> > > > +                                     CONFIG_BLOBLIST_ADDR);
> > > > +
> > > > +       log_debug("Creating new bloblist size %lx at %lx\n", size,
> > > > +                 addr);
> > > > +       ret =3D bloblist_new(addr, size, 0, 0);
> > > > +       if (ret)
> > > > +               return log_msg_ret("ini", ret);
> > > >
> > > >         return 0;
> > > >  }
> > > > @@ -687,7 +687,9 @@ int bloblist_check_reg_conv(ulong rfdt, ulong r=
zero, ulong rsig, ulong xlist)
> > > >                 return ret;
> > > >
> > > >         if (rfdt !=3D (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0=
)) {
> > > > -               gd->bloblist =3D NULL;  /* Reset the gd bloblist po=
inter */
> > > > +               /* Remove this bloblist from gd */
> > > > +               gd->bloblist =3D NULL;
> > > > +               gd->flags &=3D ~GD_FLG_BLOBLIST_READY;
> > > >                 return -EIO;
> > > >         }
> > > >
> > > > diff --git a/common/board_f.c b/common/board_f.c
> > > > index ce87c619e680..c39e3b940d3b 100644
> > > > --- a/common/board_f.c
> > > > +++ b/common/board_f.c
> > > > @@ -894,7 +894,9 @@ static void initcall_run_f(void)
> > > >         INITCALL(log_init);
> > > >         INITCALL(initf_bootstage); /* uses its own timer, so does n=
ot need DM */
> > > >         INITCALL(event_init);
> > > > -       INITCALL(bloblist_maybe_init);
> > > > +#if CONFIG_IS_ENABLED(BLOBLIST)
> > > > +       INITCALL(bloblist_init);
> > > > +#endif
> > > >         INITCALL(setup_spl_handoff);
> > > >  #if CONFIG_IS_ENABLED(CONSOLE_RECORD_INIT_F)
> > > >         INITCALL(console_record_init);
> > > > diff --git a/include/bloblist.h b/include/bloblist.h
> > > > index e67b2a76358d..4c5787729654 100644
> > > > --- a/include/bloblist.h
> > > > +++ b/include/bloblist.h
> > > > @@ -488,10 +488,24 @@ const char *bloblist_tag_name(enum bloblist_t=
ag_t tag);
> > > >   */
> > > >  int bloblist_reloc(void *to, uint to_size);
> > > >
> > > > +/**
> > > > + * bloblist_exists() - Check for the prior existence of a bloblist
> > > > + *
> > > > + * This will check for a transfer list having been passed via stan=
dard
> > > > + * convention. If CONFIG_BLOBLIST_PASSAGE_MANDATORY is selected an=
d one is not
> > > > + * found, we return false.
> > > > + *
> > > > + * If CONFIG_BLOBLIST_FIXED is selected, it uses CONFIG_BLOBLIST_A=
DDR and
> > > > + * CONFIG_BLOBLIST_SIZE to check for a bloblist.
> > > > + *
> > > > + * Return: true if found, false if not
> > > > + */
> > > > +bool bloblist_exists(void);
> > > > +
> > > >  /**
> > > >   * bloblist_init() - Init the bloblist system with a single blobli=
st
> > > >   *
> > > > - * This locates and sets up the blocklist for use.
> > > > + * This creates a bloblist for use, if not already found.
> > > >   *
> > > >   * If CONFIG_BLOBLIST_FIXED is selected, it uses CONFIG_BLOBLIST_A=
DDR and
> > > >   * CONFIG_BLOBLIST_SIZE to set up a bloblist for use by U-Boot.
> > > > @@ -508,22 +522,6 @@ int bloblist_reloc(void *to, uint to_size);
> > > >   */
> > > >  int bloblist_init(void);
> > > >
> > > > -#if CONFIG_IS_ENABLED(BLOBLIST)
> > > > -/**
> > > > - * bloblist_maybe_init() - Init the bloblist system if not already=
 done
> > > > - *
> > > > - * Calls bloblist_init() if the GD_FLG_BLOBLIST_READY flag is not =
set
> > > > - *
> > > > - * Return: 0 if OK, -ve on error
> > > > - */
> > > > -int bloblist_maybe_init(void);
> > > > -#else
> > > > -static inline int bloblist_maybe_init(void)
> > > > -{
> > > > -       return 0;
> > > > -}
> > > > -#endif /* BLOBLIST */
> > > > -
> > > >  /**
> > > >   * bloblist_check_reg_conv() - Check whether the bloblist is compl=
iant to
> > > >   *                            the register conventions according t=
o the
> > > > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > > > index c67b6e8c133e..7fd7f7ff01e5 100644
> > > > --- a/lib/fdtdec.c
> > > > +++ b/lib/fdtdec.c
> > > > @@ -1822,17 +1822,12 @@ int fdtdec_setup(void)
> > > >         int ret =3D -ENOENT;
> > > >
> > > >         /*
> > > > -        * If allowing a bloblist, check that first. There was disc=
ussion about
> > > > -        * adding an OF_BLOBLIST Kconfig, but this was rejected.
> > > > -        *
> > > > -        * The necessary test is whether the previous phase passed =
a bloblist,
> > > > -        * not whether this phase creates one.
> > > > +        * If allowing a bloblist, check that first. The necessary =
test is
> > > > +        * whether the previous phase passed a bloblist, not whethe=
r this phase
> > > > +        * creates one.
> > > >          */
> > > > -       if (CONFIG_IS_ENABLED(BLOBLIST) &&
> > > > -           (xpl_prev_phase() !=3D PHASE_TPL ||
> > > > -            IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> > > > -               ret =3D bloblist_maybe_init();
> > > > -               if (!ret) {
> > > > +       if (CONFIG_IS_ENABLED(BLOBLIST) && (xpl_prev_phase() !=3D P=
HASE_TPL)) {
> > >
> > > I think this change drops the TPL-provided blobs on TPL->SPL boots.
> > > When TPL_BLOBLIST is selected, the next phase starts with
> > > xpl_prev_phase() =3D=3D PHASE_TPL.
> > > This new guard now skips bloblist_exists(), so gd->flags never gets
> > > GD_FLG_BLOBLIST_READY; the later bloblist_init() in common/spl/spl.c
> > > then creates a fresh bloblist and overwrites the fixed-address list
> > > from TPL.
> >
> > Ah right, oops. I guess the only question is if we should continue to
> > optimize the TPL case (it can't exist) or just always check (maybe
> > there's some 4 stage boot..).
> >
>=20
> That really depends on whether we shall consider the scenario of TPL.
> For the case of the Arm Firmware Handoff, stages before BL2 are not
> considered to hand information over to the next stage via Transfer
> List (aka. bloblist in U-Boot).

OK, I think we can just go with SPL or higher looks for a bloblist, TPL
can create one but not be passed one. It's simple enough to change if
there's somehow a 4 stage boot we need to worry about later.

--=20
Tom

--owdlBzfXH93kEDvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagiN9gAKCRAr4qD1Cr/k
CjnYAP9WcL3TN2bL1Aq+P55+mCznbr/w3Scp5oFUtBdZcuNYtgD/VySm3Upbbj14
XjblA4bY8Jq5DRMs+zxNbI32NJT38A8=
=/YuU
-----END PGP SIGNATURE-----

--owdlBzfXH93kEDvn--
