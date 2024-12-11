Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D344AE77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 15:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AF6180328;
	Wed, 11 Dec 2024 16:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N5MykcQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A03580327; Wed, 11 Dec 2024 16:52:48 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17E2780303
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:52:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa66e4d1d5aso664790366b.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 07:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733932365; x=1734537165; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rvGkD2M3YUPpQMognrWlHnxec4uWPRCc84jqhL0UrqM=;
 b=N5MykcQOWEoWDOQdvcuWX+taPZ6HBwtkX+OCiaZmGzcPmYAnAZ0gciZsOLwHO44E7Z
 kUsqcuqNcAt9P+YzVxjPBa3jm7zXKe4gu8B6F2xbbJhwDhxqf6uE2LaKs/n8zGOhkHrQ
 z/xadwtmwY+KO1lcKP7VSdXkZRpvbLEt8j4EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733932365; x=1734537165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rvGkD2M3YUPpQMognrWlHnxec4uWPRCc84jqhL0UrqM=;
 b=qARQqMkp/PEfpxrzhRFGR3QlDkiyNAzJ4EZjbMrUxArdGcclTpvLVjh4Aqh/D15Axo
 +DoSt7ucjNBMW2UlKvmQwoUYD804VcSPc+FPgMj+ss6CdyKO1HUJexfLfST9BKAJif3Q
 GVIx+C3KUsCrj1Yi3cbxRWiR65+m0p5lVfAhGEKcU7pC0J3pso0laLCcT3/5yNU3n1kl
 JevuyJXsXs25R3v01TW601XF3wmgvRiXUfq3xy/rAn/Dw6d9Ewy2n7y1uL1lG9MosSWw
 0S3pSzVmqISQDdRk9CeBGwQAmR4rxBZI86zQExcya4E44moppLzGwDTQ7fMfD70tBIeT
 5dsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2UaV7wzqWX/Qy+zIIMopPOnLkgZ7ZRkPAWCnJ+Gzzflq7f+rQOG2jNFirTQ5NU58KdvOBpQE=@lists.denx.de
X-Gm-Message-State: AOJu0YwP257IhEgfM4TASr9d9drBX00zyumOkRgDUpBhIhTsf3bOkagF
 0Plk+NMe80+dS9XgqWtUaUoshnUWUZY8kIznL/laTlO3d1Ji2KOc/6295weAq7QHS2UYEQJIhoc
 aIvYl4Rd8bAL5U4VxyB34lX5cmnENqqlh+qpd
X-Gm-Gg: ASbGncsDc9hneNpsSI2qeR33E4+ZoZhzcG1VN5O2ZBRBuSTsQmieWixAP6YPoug32F8
 ldoYUxyqOq+ocgkG3URClHlw6v3IijP5ziGuB
X-Google-Smtp-Source: AGHT+IGIuhODouWBBcpbE31q/Yln9hob0BPj9JJ9EJ21KDo1jUeIl/a9wddaNqVw2OsDB5uh88/3WcGyHXYFpu6ydzY=
X-Received: by 2002:a17:906:314f:b0:aa6:558b:fcc3 with SMTP id
 a640c23a62f3a-aa6b10f5539mr292848766b.4.1733932365533; Wed, 11 Dec 2024
 07:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20241211-dtb_dt_embedded_within_fdtdec-v1-0-7840469f0084@salutedevices.com>
 <20241211-dtb_dt_embedded_within_fdtdec-v1-1-7840469f0084@salutedevices.com>
In-Reply-To: <20241211-dtb_dt_embedded_within_fdtdec-v1-1-7840469f0084@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Dec 2024 08:52:33 -0700
Message-ID: <CAFLszTjiBiYjyjOSDr5ij_PJi4nTKZATRwXpBt5tymJCYsxcZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fdtdec: encapsulate dtb_dt_embedded() within
To: Evgeny Bachinin <EABachinin@salutedevices.com>
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 kernel@salutedevices.com, evgen89bachinin@gmail.com, u-boot@lists.denx.de
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

On Tue, 10 Dec 2024 at 15:40, Evgeny Bachinin
<EABachinin@salutedevices.com> wrote:
>
>   Patch keeps the access to dtb_dt_embedded() within fdtdec API,
> by means of new API function introduction. This new function is a
> common place for updating appropriate global_data fields for
> OF_EMBED case.
>
>   Also, the consequence of the patch is movement of '___dtb_dt_*begin'
> symbols' declaration from header file, because nobody used symbols
> outside the lib/fdtdec.c.
>
> Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
> Suggested-by: Simon Glass <sjg@chromium.org>
> ---
>  common/board_r.c |  4 ++--
>  include/fdtdec.h | 24 +++++++-----------------
>  lib/fdtdec.c     | 26 ++++++++++++++++++++++++--
>  3 files changed, 33 insertions(+), 21 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Thank you


>
> diff --git a/common/board_r.c b/common/board_r.c
> index 88dc756b2a5e5a44f55f9b0fd012adc798a8afdb..3c6a4c1f5df80d5f5bf86ed4047fccf981dbc244 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -155,11 +155,11 @@ static int initr_reloc_global_data(void)
>
>         /*
>          * For CONFIG_OF_EMBED case the FDT is embedded into ELF, available by
> -        * __dtb_dt_begin. After U-boot ELF self-relocation to RAM top address
> +        * __dtb_dt_begin. After U-Boot ELF self-relocation to RAM top address
>          * it is worth to update fdt_blob in global_data
>          */
>         if (IS_ENABLED(CONFIG_OF_EMBED))
> -               gd->fdt_blob = dtb_dt_embedded();
> +               fdtdec_setup_embed();
>
>  #ifdef CONFIG_EFI_LOADER
>         /*
> diff --git a/include/fdtdec.h b/include/fdtdec.h
> index 555c952037964e6b1d9419156171f7ef4b35f448..88eeb5129780878a6fa4ac7a357e4e704347ab43 100644
> --- a/include/fdtdec.h
> +++ b/include/fdtdec.h
> @@ -136,23 +136,6 @@ struct fdt_pci_addr {
>         u32     phys_lo;
>  };
>
> -extern u8 __dtb_dt_begin[];    /* embedded device tree blob */
> -extern u8 __dtb_dt_spl_begin[];        /* embedded device tree blob for SPL/TPL */
> -
> -/* Get a pointer to the embedded devicetree, if there is one, else NULL */
> -static inline u8 *dtb_dt_embedded(void)
> -{
> -#ifdef CONFIG_OF_EMBED
> -# ifdef CONFIG_XPL_BUILD
> -       return __dtb_dt_spl_begin;
> -# else
> -       return __dtb_dt_begin;
> -# endif
> -#else
> -       return NULL;
> -#endif
> -}
> -
>  /**
>   * Compute the size of a resource.
>   *
> @@ -1155,6 +1138,13 @@ int fdtdec_set_carveout(void *blob, const char *node, const char *prop_name,
>                         const char *name, const char **compatibles,
>                         unsigned int count, unsigned long flags);
>
> +/**
> + * fdtdec_setup_embed - pick up embedded DTS
> + *
> + * Should be invoked under CONFIG_OF_EMBED guard.
> + */
> +void fdtdec_setup_embed(void);
> +
>  /**
>   * Set up the device tree ready for use
>   */
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index b06559880296276bebd434e9d1de6d2fa923fa98..9cb94a158441cfd291a0f173c321a722e896bcb2 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -93,6 +93,23 @@ static const char *const fdt_src_name[] = {
>         [FDTSRC_BLOBLIST] = "bloblist",
>  };
>
> +extern u8 __dtb_dt_begin[];    /* embedded device tree blob */
> +extern u8 __dtb_dt_spl_begin[];        /* embedded device tree blob for SPL/TPL */
> +
> +/* Get a pointer to the embedded devicetree, if there is one, else NULL */
> +static u8 *dtb_dt_embedded(void)
> +{
> +#ifdef CONFIG_OF_EMBED
> +# ifdef CONFIG_XPL_BUILD
> +       return __dtb_dt_spl_begin;
> +# else
> +       return __dtb_dt_begin;
> +# endif
> +#else
> +       return NULL;
> +#endif
> +}
> +
>  const char *fdtdec_get_srcname(void)
>  {
>         return fdt_src_name[gd->fdt_src];
> @@ -1664,6 +1681,12 @@ static void setup_multi_dtb_fit(void)
>         }
>  }
>
> +void fdtdec_setup_embed(void)
> +{
> +       gd->fdt_blob = dtb_dt_embedded();
> +       gd->fdt_src = FDTSRC_EMBED;
> +}
> +
>  int fdtdec_setup(void)
>  {
>         int ret = -ENOENT;
> @@ -1699,8 +1722,7 @@ int fdtdec_setup(void)
>                         gd->fdt_blob = fdt_find_separate();
>                         gd->fdt_src = FDTSRC_SEPARATE;
>                 } else { /* embed dtb in ELF file for testing / development */
> -                       gd->fdt_blob = dtb_dt_embedded();
> -                       gd->fdt_src = FDTSRC_EMBED;
> +                       fdtdec_setup_embed();
>                 }
>         }
>
>
> --
> 2.34.1
>
