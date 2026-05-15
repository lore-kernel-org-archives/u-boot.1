Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B4DCD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 15:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E22E9847FD;
	Fri, 15 May 2026 17:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ALNMkofV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C41F9847D9; Fri, 15 May 2026 17:06:02 +0200 (CEST)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51627847FD
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 17:06:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-56f72d27e7eso1143452e0c.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 08:06:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778857559; cv=none;
 d=google.com; s=arc-20240605;
 b=lIKPApaVW0HjjVzT5f0XIK+gv9zCiOj05cbkEyLvZfg1sR1WjqyPdUAzKqW1/37rXr
 yDwHD1OR2E4brpzxALYHX0F227OfM9jTWvC7zN5Zs22HOE4xGRk1b/GITRnjlNt5w1AK
 EhIDRgfVI5cYl/uP5DK5GOMRWsfPBAjwj4bJpur/z/P5fHLf+DHi+22FVA7XTMUiZvtF
 7Wc0uL+/bN31diyWG9etO60wpK5Qx5SkR9ZBWhrpvZQQf2sJo/Sagr3ZFMRLBgQ1H2YZ
 BhMOO+TVZD5O+tvNfsSoox9ak1iFLZ65ssaA6eRdz8M6grhYlEbkPJsLmK6H8EBykjQA
 eW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8G+g87qmBSvW7sFKMsB0cJz1j9cJWEgRdzS1dC8IheQ=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=DQyUoSwdaimyK2wLmRP+3d7lGij3HYUCJAcyN1ivTpAkMnGeRnrKLkSRwdo3gnsdCN
 M8HJ605KQx/SJSZpF/BipckIOXflqw9nYljIRRk1aLtVVshIFAif0YT0nLN7sL7DwnMd
 4swAwly/c+hzUBBYdcZk2nyGTIWY2tVQsDD+Q+WfamZcTMtdGomooavuXBW7L0bpvON2
 cvOa3/ZBsn93SnH0QwVlJZprM6zlkKbvHsciN/PuLJSL8aTg7TyFFwkFGskZaHmtnwEc
 5cO/bwWmq4emHfoJ/lwX9tV9Wb5mWK51oyQFUtM+pcxU41TX0iGb6qy7ZADGPXwGgXid
 Metg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778857559; x=1779462359; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8G+g87qmBSvW7sFKMsB0cJz1j9cJWEgRdzS1dC8IheQ=;
 b=ALNMkofVbNWP2t03rdwB9iuV4IipGyank1BRljg3VYKeHJGSHD1wy31mQapwovNbLT
 qmxaYO3vMr7VZ8BvXPgZ1NrndBPnpIHn46wzqfyDrxJdk1m7We5wBRITwgDyke4HQsKu
 gctxQ14W+TGpNhvhv8tl3Hkn6sXQZsspMU06SfVmDqHqGYcIHfYrAhe8996WIO2UquEK
 A8lhVIh7psCjicrA8qagiR6xa/E7tTZAvNZynnyK5z2xiIkwBcG6YfREhj/toL8MdKYb
 Zgx0WKgYgtZ20JApZBIvLq6/Kt2F9M9oeVFITDkrCmYRedtz+9kXHj5z+vLmd6EE1psE
 VMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778857559; x=1779462359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8G+g87qmBSvW7sFKMsB0cJz1j9cJWEgRdzS1dC8IheQ=;
 b=eZuextx/5s5i6TK1fOduBon2J/1GQHUuD8ZcUvMo8HU189PAUrHGOrpRpOyBEFJvij
 PSHf5kXvXnKwqHwxG74i5oiR1oVhOU5dYyffnaU0sHXXJ8uEIiYNyk3XOBjoLgBDN7kz
 3EBrC8wO8eHZ2MrgkbzvikG8mTRUb5N1U4x3T8Ah+n/e6PelZbRjKI627t4H4lE+IaCW
 00LX0Xl9+izee6obU3LHo7qBMNhYBrju5gGGoSSc0jXruqcNFIlzzzrgtyr2XoO/6Tjm
 hrRox5E3XhYUrHyBwN4ibOcOyORSCB29YMwPyr1jpwhfH+uP2qekc5OL3RvT3+5TCzZC
 ZNGA==
X-Gm-Message-State: AOJu0YwB6qK4Sgn86xlp/FkmAPB4l5T9dtrPgxuMuw9lZTLRmafGtqOm
 sPjRIzgKYHlkHmYCpv2XCL7l/sZyhYQyRW3GW5Buk/Nhp/l7fT3StJ7Rh4kv4SIbBIJJc8hDTdG
 WuTjgK1dSF54Y4V5zqu9zdgEPw/8g63ZGfeDG
X-Gm-Gg: Acq92OFqmv/XidwomPVhmkzKAn6DQZie6P+SAK6Cwt6UXfDMYGLkdzDLziKPs/HxA3u
 U/iK77nZTuInrxnZ13aSyk3ae9VVeWEVMhm1kvkcgbj4pRVlKCgqALDAb9/eNxg2ntsZVXwcLd4
 0AeqlPk2rp01T/qaJvb6PVb9Ll333sVMcNcgU2RIt6LExW2mmI8RxVFaX6m6fxe28eK5r73bQQY
 xCwFU34iVWu34Tp653u3WimjvGrXJxLbKxU1CeXSVge6jlt8hi4ywHjBd9/ZZZBBDgOI7vTIBtV
 gKEoVwby
X-Received: by 2002:a05:6122:340a:b0:575:9f5:ac57 with SMTP id
 71dfb90a1353d-5760b80c496mr2089856e0c.4.1778857558963; Fri, 15 May 2026
 08:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260514175457.4047707-1-trini@konsulko.com>
 <20260514175457.4047707-4-trini@konsulko.com>
In-Reply-To: <20260514175457.4047707-4-trini@konsulko.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 15 May 2026 11:05:47 -0400
X-Gm-Features: AVHnY4IJD7qQ8rrJ6wFC0O-fYdK1pGqrfAr6QzW_fmMaxap4Tfmq9Rv-jggYehU
Message-ID: <CAMDkj5zyg1YcjwphhqKiZYX9DpzwjzDWLdecT2=a_0sGbhSCjw@mail.gmail.com>
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

On Thu, May 14, 2026 at 1:55=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> With bloblist, we need to both see if one already exists as well as
> create one if it does not. However, the current implementation leads to
> odd cases where we attempt to create a bloblist before this is possible
> and have things be overly complicated when we are given one to work
> with.
>
> This reworks things to instead have a bloblist_exists function, which as
> the name implies checks for an existing bloblist. This is used in
> the case of booting, to see if we have one and in turn if we have a
> device tree there as well as in the bloblist_init function to see if we
> need to do anything.
>
> In practical details, we move the logic from bloblist_init that was
> checking for a bloblist to the new bloblist_exists function and then can
> clarify the logic as it is much easier to state when we know we do not
> have one rather than all the ways we might have one. Then we have the
> locations that set gd->bloblist now also set the GD_FLG_BLOBLIST_READY
> flag.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  common/bloblist.c  | 144 +++++++++++++++++++++++----------------------
>  common/board_f.c   |   4 +-
>  include/bloblist.h |  32 +++++-----
>  lib/fdtdec.c       |  15 ++---
>  4 files changed, 96 insertions(+), 99 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 09afdd1f96b4..51ae9cc50a5f 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -448,6 +448,7 @@ int bloblist_new(ulong addr, uint size, uint flags, u=
int align_log2)
>         hdr->align_log2 =3D align_log2 ? align_log2 : BLOBLIST_BLOB_ALIGN=
_LOG2;
>         hdr->chksum =3D 0;
>         gd->bloblist =3D hdr;
> +       gd->flags |=3D GD_FLG_BLOBLIST_READY;
>
>         return 0;
>  }
> @@ -475,6 +476,7 @@ int bloblist_check(ulong addr, uint size)
>                 return log_msg_ret("Bad checksum", -EIO);
>         }
>         gd->bloblist =3D hdr;
> +       gd->flags |=3D GD_FLG_BLOBLIST_READY;
>
>         return 0;
>  }
> @@ -576,90 +578,88 @@ int __weak xferlist_from_boot_arg(ulong __always_un=
used *addr)
>         return -ENOENT;
>  }
>
> -int bloblist_init(void)
> +bool bloblist_exists(void)
>  {
> -       bool fixed =3D IS_ENABLED(CONFIG_BLOBLIST_FIXED);
> -       int ret =3D 0;
> -       ulong addr =3D 0, size;
> +       int ret;
> +       ulong addr =3D 0;
>
>         /* Check if a valid transfer list passed in */
> -       if (!xferlist_from_boot_arg(&addr)) {
> -               size =3D bloblist_get_total_size();
> -       } else {
> -               /*
> -                * If U-Boot is not in the first phase, an existing blobl=
ist must
> -                * be at a fixed address.
> -                */
> -               bool from_addr =3D fixed && !xpl_is_first_phase();
> -
> -               /*
> -                * If Firmware Handoff is mandatory but no transfer list =
is
> -                * observed, report it as an error.
> -                */
> -               if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
> -                       return -ENOENT;
> -
> -               ret =3D -ENOENT;
> -
> -               if (xpl_prev_phase() =3D=3D PHASE_TPL &&
> -                   !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> -                       from_addr =3D false;
> -               if (fixed)
> -                       addr =3D IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> -                                             CONFIG_BLOBLIST_ADDR);
> -               size =3D CONFIG_BLOBLIST_SIZE;
> -
> -               if (from_addr)
> -                       ret =3D bloblist_check(addr, size);
> +       if (!xferlist_from_boot_arg(&addr))
> +               goto found;
>
> -               if (ret)
> -                       log_debug("Bloblist at %lx not found (err=3D%d)\n=
",
> -                                 addr, ret);
> -               else
> -                       /* Get the real size */
> -                       size =3D gd->bloblist->total_size;
> -       }
> +       /*
> +        * If Firmware Handoff is mandatory but no transfer list is
> +        * observed, report it as an error.
> +        */
> +       if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
> +               return false;
>
> -       if (ret) {
> -               /*
> -                * If we don't have a bloblist from a fixed address, or t=
he one
> -                * in the fixed address is not valid. we must allocate th=
e
> -                * memory for it now.
> -                */
> -               if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
> -                       void *ptr =3D memalign(BLOBLIST_ALIGN, size);
> -
> -                       if (!ptr)
> -                               return log_msg_ret("alloc", -ENOMEM);
> -                       addr =3D map_to_sysmem(ptr);
> -               } else if (!fixed) {
> -                       return log_msg_ret("BLOBLIST_FIXED is not enabled=
",
> -                                          ret);
> -               }
> -               log_debug("Creating new bloblist size %lx at %lx\n", size=
,
> -                         addr);
> -               ret =3D bloblist_new(addr, size, 0, 0);
> -       } else {
> -               log_debug("Found existing bloblist size %lx at %lx\n", si=
ze,
> -                         addr);
> -       }
> +       /*
> +        * We have checked for a valid transfer list being passed. At thi=
s
> +        * point, if we do not have a fixed address for the bloblist, we =
cannot
> +        * be provided with one.
> +        */
> +       if (xpl_is_first_phase() || !IS_ENABLED(CONFIG_BLOBLIST_FIXED))
> +               return false;
>
> -       if (ret)
> -               return log_msg_ret("ini", ret);
> -       gd->flags |=3D GD_FLG_BLOBLIST_READY;
> +       /*
> +        * Check for a valid list as the configured address.
> +        */
> +       addr =3D IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> +                             CONFIG_BLOBLIST_ADDR);
> +       ret =3D bloblist_check(addr, CONFIG_BLOBLIST_SIZE);
> +       if (!ret)
> +               goto found;
> +
> +       log_debug("Bloblist at %lx not found (err=3D%d)\n", addr, ret);
> +       return false;
>
> +found:
>  #ifdef DEBUG
>         bloblist_show_stats();
>         bloblist_show_list();
>  #endif
> -
> -       return 0;
> +       return true;
>  }
>
> -int bloblist_maybe_init(void)
> +int bloblist_init(void)
>  {
> -       if (CONFIG_IS_ENABLED(BLOBLIST) && !(gd->flags & GD_FLG_BLOBLIST_=
READY))
> -               return bloblist_init();
> +       int ret;
> +       ulong addr =3D 0, size =3D CONFIG_BLOBLIST_SIZE;
> +
> +       if (gd->flags & GD_FLG_BLOBLIST_READY) {
> +               log_debug("Found existing bloblist size %x at %p\n",
> +                         gd->bloblist->total_size, gd->bloblist);
> +               return 0;
> +       }
> +
> +       /*
> +        * If Firmware Handoff is mandatory but no transfer list has been
> +        * observed by fdtdec_setup, report it as an error.
> +        */
> +       if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
> +               return -ENOENT;
> +
> +       /*
> +        * If we don't have an existing bloblist, we either need
> +        * to allocate one now, or initialize the fixed address
> +        * space as a bloblist.
> +        */
> +       if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
> +               void *ptr =3D memalign(BLOBLIST_ALIGN, size);
> +
> +               if (!ptr)
> +                       return log_msg_ret("alloc", -ENOMEM);
> +               addr =3D map_to_sysmem(ptr);
> +       } else
> +               addr =3D IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> +                                     CONFIG_BLOBLIST_ADDR);
> +
> +       log_debug("Creating new bloblist size %lx at %lx\n", size,
> +                 addr);
> +       ret =3D bloblist_new(addr, size, 0, 0);
> +       if (ret)
> +               return log_msg_ret("ini", ret);
>
>         return 0;
>  }
> @@ -687,7 +687,9 @@ int bloblist_check_reg_conv(ulong rfdt, ulong rzero, =
ulong rsig, ulong xlist)
>                 return ret;
>
>         if (rfdt !=3D (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
> -               gd->bloblist =3D NULL;  /* Reset the gd bloblist pointer =
*/
> +               /* Remove this bloblist from gd */
> +               gd->bloblist =3D NULL;
> +               gd->flags &=3D ~GD_FLG_BLOBLIST_READY;
>                 return -EIO;
>         }
>
> diff --git a/common/board_f.c b/common/board_f.c
> index ce87c619e680..c39e3b940d3b 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -894,7 +894,9 @@ static void initcall_run_f(void)
>         INITCALL(log_init);
>         INITCALL(initf_bootstage); /* uses its own timer, so does not nee=
d DM */
>         INITCALL(event_init);
> -       INITCALL(bloblist_maybe_init);
> +#if CONFIG_IS_ENABLED(BLOBLIST)
> +       INITCALL(bloblist_init);
> +#endif
>         INITCALL(setup_spl_handoff);
>  #if CONFIG_IS_ENABLED(CONSOLE_RECORD_INIT_F)
>         INITCALL(console_record_init);
> diff --git a/include/bloblist.h b/include/bloblist.h
> index e67b2a76358d..4c5787729654 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -488,10 +488,24 @@ const char *bloblist_tag_name(enum bloblist_tag_t t=
ag);
>   */
>  int bloblist_reloc(void *to, uint to_size);
>
> +/**
> + * bloblist_exists() - Check for the prior existence of a bloblist
> + *
> + * This will check for a transfer list having been passed via standard
> + * convention. If CONFIG_BLOBLIST_PASSAGE_MANDATORY is selected and one =
is not
> + * found, we return false.
> + *
> + * If CONFIG_BLOBLIST_FIXED is selected, it uses CONFIG_BLOBLIST_ADDR an=
d
> + * CONFIG_BLOBLIST_SIZE to check for a bloblist.
> + *
> + * Return: true if found, false if not
> + */
> +bool bloblist_exists(void);
> +
>  /**
>   * bloblist_init() - Init the bloblist system with a single bloblist
>   *
> - * This locates and sets up the blocklist for use.
> + * This creates a bloblist for use, if not already found.
>   *
>   * If CONFIG_BLOBLIST_FIXED is selected, it uses CONFIG_BLOBLIST_ADDR an=
d
>   * CONFIG_BLOBLIST_SIZE to set up a bloblist for use by U-Boot.
> @@ -508,22 +522,6 @@ int bloblist_reloc(void *to, uint to_size);
>   */
>  int bloblist_init(void);
>
> -#if CONFIG_IS_ENABLED(BLOBLIST)
> -/**
> - * bloblist_maybe_init() - Init the bloblist system if not already done
> - *
> - * Calls bloblist_init() if the GD_FLG_BLOBLIST_READY flag is not set
> - *
> - * Return: 0 if OK, -ve on error
> - */
> -int bloblist_maybe_init(void);
> -#else
> -static inline int bloblist_maybe_init(void)
> -{
> -       return 0;
> -}
> -#endif /* BLOBLIST */
> -
>  /**
>   * bloblist_check_reg_conv() - Check whether the bloblist is compliant t=
o
>   *                            the register conventions according to the
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index c67b6e8c133e..7fd7f7ff01e5 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1822,17 +1822,12 @@ int fdtdec_setup(void)
>         int ret =3D -ENOENT;
>
>         /*
> -        * If allowing a bloblist, check that first. There was discussion=
 about
> -        * adding an OF_BLOBLIST Kconfig, but this was rejected.
> -        *
> -        * The necessary test is whether the previous phase passed a blob=
list,
> -        * not whether this phase creates one.
> +        * If allowing a bloblist, check that first. The necessary test i=
s
> +        * whether the previous phase passed a bloblist, not whether this=
 phase
> +        * creates one.
>          */
> -       if (CONFIG_IS_ENABLED(BLOBLIST) &&
> -           (xpl_prev_phase() !=3D PHASE_TPL ||
> -            IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> -               ret =3D bloblist_maybe_init();
> -               if (!ret) {
> +       if (CONFIG_IS_ENABLED(BLOBLIST) && (xpl_prev_phase() !=3D PHASE_T=
PL)) {

I think this change drops the TPL-provided blobs on TPL->SPL boots.
When TPL_BLOBLIST is selected, the next phase starts with
xpl_prev_phase() =3D=3D PHASE_TPL.
This new guard now skips bloblist_exists(), so gd->flags never gets
GD_FLG_BLOBLIST_READY; the later bloblist_init() in common/spl/spl.c
then creates a fresh bloblist and overwrites the fixed-address list
from TPL.

Regards,
Raymond

> +               if (bloblist_exists()) {
>                         gd->fdt_blob =3D bloblist_find(BLOBLISTT_CONTROL_=
FDT, 0);
>                         if (gd->fdt_blob) {
>                                 gd->fdt_src =3D FDTSRC_BLOBLIST;
> --
> 2.43.0
>
