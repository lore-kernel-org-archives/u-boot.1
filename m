Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5BAC35FF8
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 08:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47EF588C78;
	Tue, 17 Sep 2024 10:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Uj3AzIvB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58F4088C78; Tue, 17 Sep 2024 10:58:01 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFE2D87FA7
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 10:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7d50a42ce97so2190296a12.0
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 01:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726563474; x=1727168274; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eschBkz81Vvh/TVB+hHpwZyL6eSJxn+tnYjSS6uSfEE=;
 b=Uj3AzIvBZ8PRv7aQkfqwYIgF6Su9PKTNXvLcIGhZ5qLAsBNQA6o6TRzu2WxgY5OwCY
 J7QxeynbIYOya4Gvcug+CiOXNbt2d8TqKXuCbH8kIDS6VrP3paUrd3OM7ldEVfnNXy+g
 kAnnCqyIcmSEQ1toIQy6imMVZaCITKiAwT05OA1HK+rlUg8M2vRIuu3sAlwp9En0fcld
 ey1j96TtFg9EQEfWJCoIIhWjr6Fd1SuKWpr4xo4z8NQ+Or2l9C7rRUsFdO12CLXgllRr
 mlEv+zxwOZFHn6QalYlSvvJKsNp83m+BbiEnkq76hqSVXSKvEy7Qej/vkONzIkF194rq
 7VFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726563474; x=1727168274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eschBkz81Vvh/TVB+hHpwZyL6eSJxn+tnYjSS6uSfEE=;
 b=eU/5LcgrZKZE5gaso7BIkrWp/NhN2trKLkfu4rgm3SmP8FMJNpeqapwQp2rmom8Qlc
 N+8a8/LmgD1aoMqylVXqoMfPevSQrjYJVlqTCmNGLs9L874gFqoLaQGrQSSAsKb12SF4
 vkGBkYs3ooggdEqz31oadh/iPeMnzqNPn9mZ8577ECzlDOBLZMx33TYFpH7kOQBMjpSq
 QH3ST5p48QpVt49ERUdW52rU3z7SqgC9uoEkLPu9R7snKR2LDcVTPC1KRmUzr9J7p1N5
 g+pvUga2gu1vdM9yErPW3b5EJp+vkntFQl8TmZefTd61hn/n1KuGQajzic8SniLXvwJp
 /Q+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEaZavWeD1wLo3FeLa+i/ktVVjA3aniaXVHlbvvnoN3XNQxciBT6nqGAalIrrv0aqTk2PimTs=@lists.denx.de
X-Gm-Message-State: AOJu0YxxiltxKzsGMwiCf4vsrr+WCCw2vJfBBacVm3EnVScVod5Gjtsm
 XH0qERrkOdFhvBR2Tx82aM9nSvfkvFMYyEIOZh1Xxx9EMGNZh6/p8tgyXb8EfTAF6WDNrPLU4kO
 aFoCENpZLlJGz+GKWFYf0UipVHaoVtZa9IWtjPg==
X-Google-Smtp-Source: AGHT+IFjwGCeq5UGjFypumYSJgVwjbtjh0ip26uLXlyz3P2XLnuCwlEliavdZFEUDjtH6FC8UXhTyUOL7l/PUFgDCqk=
X-Received: by 2002:a05:6a21:58b:b0:1cf:6953:2872 with SMTP id
 adf61e73a8af0-1cf764c27f2mr25122957637.48.1726563474265; Tue, 17 Sep 2024
 01:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240917084929.41888-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240917084929.41888-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Sep 2024 11:57:18 +0300
Message-ID: <CAC_iWjJ22gKJb+20Du=ayzoBGV66NiC9VAO7AAyq9X=MYPro1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efi_leader: delete rng-seed if having EFI RNG
 protocol
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Tue, 17 Sept 2024 at 11:49, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> For measured be boot we must avoid any volatile values in the device-tree.
> We already delete /chosen/kaslr-seed if we provide and EFI RNG protocol.
>
> Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         Use an index instead of a position pointer for better readability
> ---
>  include/efi_loader.h          |  2 +-
>  lib/efi_loader/efi_dt_fixup.c | 15 ++++++++++-----
>  lib/efi_loader/efi_helper.c   |  2 +-
>  3 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index f84852e384f..511281e150e 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -567,7 +567,7 @@ efi_status_t EFIAPI efi_convert_pointer(efi_uintn_t debug_disposition,
>  /* Carve out DT reserved memory ranges */
>  void efi_carve_out_dt_rsv(void *fdt);
>  /* Purge unused kaslr-seed */
> -void efi_try_purge_kaslr_seed(void *fdt);
> +void efi_try_purge_rng_seed(void *fdt);
>  /* Called by bootefi to make console interface available */
>  efi_status_t efi_console_register(void);
>  /* Called by efi_init_obj_list() to proble all block devices */
> diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
> index 9d017804eea..0dac94b0c6c 100644
> --- a/lib/efi_loader/efi_dt_fixup.c
> +++ b/lib/efi_loader/efi_dt_fixup.c
> @@ -41,7 +41,7 @@ static void efi_reserve_memory(u64 addr, u64 size, bool nomap)
>  }
>
>  /**
> - * efi_try_purge_kaslr_seed() - Remove unused kaslr-seed
> + * efi_try_purge_rng_seed() - Remove unused kaslr-seed, rng-seed
>   *
>   * Kernel's EFI STUB only relies on EFI_RNG_PROTOCOL for randomization
>   * and completely ignores the kaslr-seed for its own randomness needs
> @@ -51,8 +51,9 @@ static void efi_reserve_memory(u64 addr, u64 size, bool nomap)
>   *
>   * @fdt: Pointer to device tree
>   */
> -void efi_try_purge_kaslr_seed(void *fdt)
> +void efi_try_purge_rng_seed(void *fdt)
>  {
> +       const char * const prop[] = {"kaslr-seed", "rng-seed"};
>         const efi_guid_t efi_guid_rng_protocol = EFI_RNG_PROTOCOL_GUID;
>         struct efi_handler *handler;
>         efi_status_t ret;
> @@ -67,9 +68,13 @@ void efi_try_purge_kaslr_seed(void *fdt)
>         if (nodeoff < 0)
>                 return;
>
> -       err = fdt_delprop(fdt, nodeoff, "kaslr-seed");
> -       if (err < 0 && err != -FDT_ERR_NOTFOUND)
> -               log_err("Error deleting kaslr-seed\n");
> +       for (size_t i = 0; i < ARRAY_SIZE(prop); ++i) {
> +               err = fdt_delprop(fdt, nodeoff, prop[i]);
> +               if (err < 0 && err != -FDT_ERR_NOTFOUND)
> +                       log_err("Error deleting %s\n", prop[i]);
> +               else
> +                       log_debug("Deleted /chosen/%s\n", prop[i]);
> +       }
>  }
>
>  /**
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 96f847652ec..a481eb4b7e3 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -522,7 +522,7 @@ efi_status_t efi_install_fdt(void *fdt)
>         /* Create memory reservations as indicated by the device tree */
>         efi_carve_out_dt_rsv(fdt);
>
> -       efi_try_purge_kaslr_seed(fdt);
> +       efi_try_purge_rng_seed(fdt);
>
>         if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
>                 ret = efi_tcg2_measure_dtb(fdt);
> --
> 2.45.2
>

I saw the comment on RISC-V. If there's size issues you are concerned,
I am fine with v2 as well -- just add a comment on why if you decide
to merge that

For v2 & v3
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
