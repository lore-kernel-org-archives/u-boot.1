Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF246C44501
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 00:04:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B360848EB;
	Wed,  8 Jul 2026 02:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UTIyuOyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BCEB84942; Wed,  8 Jul 2026 02:04:36 +0200 (CEST)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47F4584118
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 02:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-7396940aebcso66476137.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 17:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783469073; cv=none;
 d=google.com; s=arc-20260327;
 b=KrSaFSt3TG79PffRXaiT7n+kd4TujZkZANofFsJds6PzOlzOSIbPLboliw2YR0CrRZ
 shs4U+FTvg57enqJyseOig6MInmiUUvUoWGYN7l2KukyHNB3qwmIgPtMbKreURbkx96M
 bI9/6H5OZ408OI8Wmr9FxJgrJ+ALi9dZOo/jgogjA5O6tkpY2qwEJ1dySxnMgQszNyNe
 Qm2wNP8Nzh34oSIl7646Mx03tZJz6psLsRLpUUByygjC9F+WtPUAjxNK4YEiDE6bIN8h
 uqRAnDkcrNCoz1KzsVoznqY21FOpm6Ca1Xjf0G6SudLDq9CKmlxN6dip112vQYf9LHlo
 WO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QDGQoOzmsdSlXaurKGeoTkQmvKfAI0kfVLcr7Bc3uz0=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=O/MEaALm8ZZ1b3yAgIrKxO6aMyiFunwCaAA0q146LL6jGUexbwmMVs3EZQEax5VVQx
 1uSblj0xb51SQF/r+I77rsgdMT1xG3dA4IkI36AGIGL+ISJX5qDZYjOideeH5rpE2ZwR
 lQadV2fKe8vOfcJxN7TNFu/Pt3H19Fk8IN/ePqWox+/lJMTiUWlOBvUU9OTbchozQmvs
 2OzWUKAekQUJxvHNnvPgqTOl2WBHPJaucayN09ciMzge7vdnoL9754vUxxpEYpEqrMUP
 Byd9kV+srN0xINLL721J3IXOFi22075/VvqgJD48n19vYIZ0emOvTjc1GuvKxPPGbrq8
 urvA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783469073; x=1784073873; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QDGQoOzmsdSlXaurKGeoTkQmvKfAI0kfVLcr7Bc3uz0=;
 b=UTIyuOyW2Smy6f7P4Srg1dHQkWfhK3A2G45XL9FzMciuO28g+3DLRYTXaFdbaYE3U/
 JNIVyxE6vnQVAtxfAMNKzN3viRifkB8o1pSdrUnjxI85iMkV4ty0WyHcC6vFWHij+pZd
 jG/e84fS94T1RQ3Iv3agwAwCfWBPA23OlWhNM2O5re3SWLF6kD8K2Cs7Tlp9J2iQXfBM
 qIFDUDeaBWrH/L3HaieJn6wZySxCewdq7zW6sksx8pUuQBB3PmhpE2XN+wiuzuxD7Ti8
 XkH0nTqklWJTGupAaSgFphpcYQ5Gbv27pP81EUU81ukwFvVya864wM6MVvvimLbn8J7c
 d/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783469073; x=1784073873;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QDGQoOzmsdSlXaurKGeoTkQmvKfAI0kfVLcr7Bc3uz0=;
 b=X7gdA2DaRpJxwOcMCDoc8x+okuIKYM40uarPcYnXvw/pbHMFaRcn3RVWY5QfwXnnKy
 sQKKFpoZEA4GFbPZUYevlqR7ypcVj1v6vDYAoIwyqFHZnWjP1enZ4eRA/MCZfHti0HZe
 zN+E/Hi7h9v5l41L442f5iasVF6OW9GpgZcxJP/SmYQqXcopYDe0aPmpPb3/URaXqft/
 stSYpsAHIb3Sfn1cTvN/kFnb2bufge1flE3iH7iHIiE5UVpIz2vqgQ5funsCB1c1++/p
 VBR5sSplBRuvdG3M2bpFDD7G2a2mbAwXH4iECBGJ79l0smdMLxLnfrmN13anaGxwIkvK
 5WQA==
X-Gm-Message-State: AOJu0YyvY8VUO8pIZp0Oa5vQGXqjzm9VF18NPBNhi0kqn5QpbmjiECpe
 5GGDPRLDR1ytr94xOq4DDTblGmXkx0BsdlujTyybQoB2fDyCTNPUVWwQQz2Gufb9or0jvb49o1+
 fbwCxDPpelxubVicCjVRjZhvqkqAPpZM6wwEV2oE=
X-Gm-Gg: AfdE7cmQeVvX5ie/YeCCn+g9PTzEpIAJOpH70fqmM9lzBT5PBpnlmdMt2PzEzAmyRdb
 mT/l0nXBf14kfCPOrq/g+RnL/4ryhFmAAvOK8K+vkhTeoqyKGuZ7hIoz8ARzclh+E0MOcGtyc/B
 Uhn/TZ008kZhxTS46g4dzzEMWYy0+eospJOpjLm7nzEr1wqu+r9oZ747XPbtSDcId1cQ0kLFAil
 1kFxyKaOARB9z721zmeET1qWbk4QWM8qY718XTCqackGWC1sK/ddQoEtHMwBultcRYVVdF4
X-Received: by 2002:a05:6102:1443:10b0:744:dd70:a364 with SMTP id
 ada2fe7eead31-744dd70a59fmr109926137.9.1783469073018; Tue, 07 Jul 2026
 17:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260707224842.261424-1-trini@konsulko.com>
In-Reply-To: <20260707224842.261424-1-trini@konsulko.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Tue, 7 Jul 2026 20:04:22 -0400
X-Gm-Features: AVVi8CfYIEMGb479F1SuzROMDgJSd3pc_iKBqDsm23yjMz5CoYujyLAQPtsNlDw
Message-ID: <CAMDkj5z3tTVxZeusOsNwjmfUr3qCAthBeRUQqgBpifZS4LDy7w@mail.gmail.com>
Subject: Re: [PATCH] bloblist: Rename GD_FLG_BLOBLIST_READY to
 GD_FLG_BLOBLIST_HANDOFF
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

On Tue, Jul 7, 2026 at 6:48=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> Now that we have made bloblist have distinct "find" and "create"
> functions, the global data tag "GD_FLG_BLOBLIST_READY" doesn't quite
> make sense anymore. Rename it to GD_FLG_BLOBLIST_HANDOFF.
>
> Suggested-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  common/bloblist.c                 | 8 ++++----
>  include/asm-generic/global_data.h | 4 ++--
>  include/bloblist.h                | 2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
>

Sounds good to me.
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

BTW, do we need another flag for the locally allocated/static-assigned blob=
list?

Regards,
Raymond

> diff --git a/common/bloblist.c b/common/bloblist.c
> index 51ae9cc50a5f..846c8047f746 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -448,7 +448,7 @@ int bloblist_new(ulong addr, uint size, uint flags, u=
int align_log2)
>         hdr->align_log2 =3D align_log2 ? align_log2 : BLOBLIST_BLOB_ALIGN=
_LOG2;
>         hdr->chksum =3D 0;
>         gd->bloblist =3D hdr;
> -       gd->flags |=3D GD_FLG_BLOBLIST_READY;
> +       gd->flags |=3D GD_FLG_BLOBLIST_HANDOFF;
>
>         return 0;
>  }
> @@ -476,7 +476,7 @@ int bloblist_check(ulong addr, uint size)
>                 return log_msg_ret("Bad checksum", -EIO);
>         }
>         gd->bloblist =3D hdr;
> -       gd->flags |=3D GD_FLG_BLOBLIST_READY;
> +       gd->flags |=3D GD_FLG_BLOBLIST_HANDOFF;
>
>         return 0;
>  }
> @@ -627,7 +627,7 @@ int bloblist_init(void)
>         int ret;
>         ulong addr =3D 0, size =3D CONFIG_BLOBLIST_SIZE;
>
> -       if (gd->flags & GD_FLG_BLOBLIST_READY) {
> +       if (gd->flags & GD_FLG_BLOBLIST_HANDOFF) {
>                 log_debug("Found existing bloblist size %x at %p\n",
>                           gd->bloblist->total_size, gd->bloblist);
>                 return 0;
> @@ -689,7 +689,7 @@ int bloblist_check_reg_conv(ulong rfdt, ulong rzero, =
ulong rsig, ulong xlist)
>         if (rfdt !=3D (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
>                 /* Remove this bloblist from gd */
>                 gd->bloblist =3D NULL;
> -               gd->flags &=3D ~GD_FLG_BLOBLIST_READY;
> +               gd->flags &=3D ~GD_FLG_BLOBLIST_HANDOFF;
>                 return -EIO;
>         }
>
> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/glob=
al_data.h
> index ad7ebb1bbc95..fd116b0cebf2 100644
> --- a/include/asm-generic/global_data.h
> +++ b/include/asm-generic/global_data.h
> @@ -697,9 +697,9 @@ enum gd_flags {
>          */
>         GD_FLG_DM_DEAD =3D 0x400000,
>         /**
> -        * @GD_FLG_BLOBLIST_READY: bloblist is ready for use
> +        * @GD_FLG_BLOBLIST_HANDOFF: bloblist has been found.
>          */
> -       GD_FLG_BLOBLIST_READY =3D 0x800000,
> +       GD_FLG_BLOBLIST_HANDOFF =3D 0x800000,
>         /**
>          * @GD_FLG_HUSH_OLD_PARSER: Use hush old parser.
>          */
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 4c5787729654..fcd290eeb165 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -516,7 +516,7 @@ bool bloblist_exists(void);
>   * If CONFIG_BLOBLIST_PASSAGE_MANDATORY is selected, bloblist in the inc=
oming
>   * standard passage is mandatorily required.
>   *
> - * Sets GD_FLG_BLOBLIST_READY in global_data flags on success
> + * Sets GD_FLG_BLOBLIST_HANDOFF in global_data flags on success
>   *
>   * Return: 0 if OK, -ve on error
>   */
> --
> 2.43.0
>
