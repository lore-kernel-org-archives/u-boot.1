Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E813BCD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EEEA8483C;
	Wed, 20 May 2026 01:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H7TM+LuB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F9E684859; Wed, 20 May 2026 01:31:10 +0200 (CEST)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEFAD84707
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-56f75445470so3194710e0c.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:31:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779233466; cv=none;
 d=google.com; s=arc-20240605;
 b=dxW+stTpayv9tEP69H+1M/NvLCxfaFCjOF9l/zrPmXVjy0FeYyFbXyPdDOAI+Xu2PN
 Vj+UQ9CgbBpJExWD49GNT3/RdxJ8F6wU9kEk6o2zoy86Hq9+9vm19JSHyfUYdaSNXg/J
 CulBrGpU8YukvrAemfhEZ7oNp4hThvnTzbvs3CuiS4pTxVgp8zjCAnSKaz1hWHMpqbED
 2usNbsKmcCiV6QViQmB8o9jlseKTeqqu0KWtLhY18jjVTzUaqtbh2iPSNP/lbKjWixAX
 5D10P2kRC0mMeRAJx9eDcnER+SRHjiOvYI7aNnJKENddeOWLQL9LZEmCzQzhUQsE7dfw
 o6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2AWVMMNrbg27CaITLy/RKGTffyGiJRd9s/DfIhz+3gI=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=Ot6dvlb8q+tLiyU8WiIJyxwhbYhh0RKEXNyHlBVYwg1r5Q2BjtvE/6Z2Eu1LUkbZPS
 mqsXwionwkI2eh+BbUx0BBHsUJeBOwh5Do1ZqKaYc3nnoXTqxRMLuspCjO60IfxWL78h
 +VjqQZJrbhvlFjIefJPeYBGJBkbHmj+gdi8m0rC0em0zs6+hNdqE+dWBIsZmqYZbGayX
 fUlMqyOjsVmMip3WCXL1x6qYY7JnXH7TcT/MPP0IjTv8dAO7g7bkCx8C/S/uJIxH3wGZ
 kHAg9eYXaWe4t9sN+RKQOFEs7a0d9pFGVyBgYCJQqOMuSJtXQ4bY64gst4lqZmyhnE9w
 Fh2A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779233466; x=1779838266; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2AWVMMNrbg27CaITLy/RKGTffyGiJRd9s/DfIhz+3gI=;
 b=H7TM+LuBIgjpqS8rADqPcR+wnADrpCtspE3hgkKVWueBspReFY8uWjO3i7arf/kWMV
 hRAfD9oUFh4430HTccYyILtxC5d5uFSQVK8J3JBtzLIER9yrVfl01BjlY8zDN8FzDTbw
 yiScue1TSgrhd/7Gemc166cyKpDySyqhLpvtEHGyry9ezOZTJOXDzXUIDK/IR3u3QJ/T
 T5G/OcsrvWbAFWfg3pCf28/ScSFDnbrdVudZZol2jfbP+XKEYGI8jGzIT+VCkQuPRUBH
 zXtU7gOKuxLKDfN3RHcuyM+Jc+QW5V79sk1PKHUpHhCUs+vuEFVvgfmx7SSdJBxd/tsk
 NC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233466; x=1779838266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2AWVMMNrbg27CaITLy/RKGTffyGiJRd9s/DfIhz+3gI=;
 b=XkszF5iuSiNEOjnmYAbHJm5PS10bcqzq8xQsrRavbDGITy7MlOn4e2kwp1+Ixu2J4R
 7481d/bMsDGMFUQX+Q0IvMNOOIP2VQfRvFYf4+rxESZHbS/WaA+Rwis2f03M5SYZMS0j
 B6Jpwr8vJ2Ac0ogJgydgkrm9gyCTnc6YIlpWKWDENcOrJV/QTkxXC8s3eIRvhVWRzLAB
 ZnD1LSMPpT6zbAvsGVhr3JPONwKI2YMz2owwyno0LeErNviTO+j/JZgMphwmp23kZEco
 bIlLMhIb/z2wEarle+uo3q5Kf+Tn40N9kylJQ20Uc6ySa9WCZb/vmGlhN7cwGhw44d6L
 ucww==
X-Gm-Message-State: AOJu0YzkIHGqxZ8N3e/z4tXmQEbxE0sIsEPm+PIKxDjF5pwdPxba0ALr
 I4QAWxFiyygIRYi8apObYN/6ktQVOYkgz7HF1Bp41TYOahgA5+fBjsOrMxwaTvbVtljPa26y6Sr
 +kCUx8/ZnRM6shYIClxzNrCEvsmQsxAOEoxlq
X-Gm-Gg: Acq92OHiS/6QY7ugmC8juNaIaOAMLii8sbmgSF3ih2yffLod2q7m7PiZFC8Wkzcrfic
 cMgB6E30FaZFnmnHthYs/VOVeUDYvNDP1uXx3/Kt3vb7MG9bu6d5tk8AcoUrybPYJdK9DlkvuCJ
 0jIIfX/ejey0ywpQ24MClOuO/05RZK9y/VP+9VRy/0+MY0s9cjgKaMQlpHVz919ukVZ8nd1Telh
 Cf8vrzZjftYYV92EeRXSytQro3JrWo9kAdjryjELJK0nlyfjV1AxDqyWZQt+G6Gf5Xc4Y5/We4j
 DdUox1cj
X-Received: by 2002:a05:6102:5a90:b0:618:442a:9e76 with SMTP id
 ada2fe7eead31-63a3d72b0bfmr11983925137.10.1779233465540; Tue, 19 May 2026
 16:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260514175457.4047707-1-trini@konsulko.com>
 <20260519162225.770071-1-trini@konsulko.com>
 <20260519162225.770071-4-trini@konsulko.com>
In-Reply-To: <20260519162225.770071-4-trini@konsulko.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Tue, 19 May 2026 19:30:53 -0400
X-Gm-Features: AVHnY4KHQD-7OhtZTKJsCKcEinUKLYoocisZgNkFt_jksUSTRr9MWcEWjzg-1bc
Message-ID: <CAMDkj5zeh9VzNRUayENHsVgAJ2Lw8k5qM+c0pv2oHWm6n02rVg@mail.gmail.com>
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

On Tue, May 19, 2026 at 12:23=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
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
> Changes in v2:
> - As noted by Raymond, we need to still check if SPL is being passed a
>   bloblist by TPL.
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

This part is a bit difficult to read.
The patch seems to try to assume that '!(gd->flags &
GD_FLG_BLOBLIST_READY)' means 'no handoff from the previous stage',
but I doubt this is a part of GD_FLG_BLOBLIST_READY's semantics.
Under the 'handoff from the previous stage' scenario, if
GD_FLG_BLOBLIST_READY is not set in time, the logic here breaks.

Regards,
Raymond

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
> index c67b6e8c133e..d0a84b5034b8 100644
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
> +       if (CONFIG_IS_ENABLED(BLOBLIST) && (xpl_phase() > PHASE_TPL)) {
> +               if (bloblist_exists()) {
>                         gd->fdt_blob =3D bloblist_find(BLOBLISTT_CONTROL_=
FDT, 0);
>                         if (gd->fdt_blob) {
>                                 gd->fdt_src =3D FDTSRC_BLOBLIST;
> --
> 2.43.0
>
