Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8979DC35FE4
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 06:38:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 995E188D22;
	Tue, 17 Sep 2024 08:38:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w34pGwnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65E3188D0F; Tue, 17 Sep 2024 08:38:36 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AF4188AB9
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 08:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8a6d1766a7so674168266b.3
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 23:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726555104; x=1727159904; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WglgPxMz0sewTIEvNBe3SKrgg8sx/M9l8y9pgko2QkU=;
 b=w34pGwnUdNp2el2QTZXqVafbyl/9RTu5lgc07mB3TX3dyw8Mk5ROG6eX5bdIxoxi0z
 WD8l+78iDl9BWynEkYcGb0k8JknnOZwARdr6vUwm4d6KczZVEzrCMdDNMkjCy0EEMr8M
 0FvDJf98NNocMtgXfwkmvIdJcL//tKoN3z82FzkXPDtZHAyzdWODyBSORC/TdVyyLmKa
 pC/EnsBOD83f9q18tF/cLjzv7hFpjhjKlV5mzEiC+YjIdFqQ87mfYLDPyQVDFRtDw5Kk
 KUg+fTv4FFw2ztklR7u1yGVdQwHFybioh3ztVnr6P8/tvt+mN8A0mn5Lhl6inHZouP1A
 f7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726555104; x=1727159904;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WglgPxMz0sewTIEvNBe3SKrgg8sx/M9l8y9pgko2QkU=;
 b=EdR2lRKc/pRRQ35OpbjKPJjzWa4eYcKiz6nmpq9Xqi6lFVKzJ27OGvY4P8LrQTF8LN
 /lRNXgD7BtnnskDyCTcej88Um1vXZuJzJwVej2aqZbTK0/g0vppDYNHn0anLd6/O4WWC
 rJa6bWEMVF96EtvD7XqmY/NMynhb0EN04ZS+fGAKUjjoxGgzOZHbvKcZdU9r7QUlTwtY
 amjZfgjJIIFFz9G8msnKoeLfZNc626wx2SPIx+7cTPDKGemuiqPWVPuDGdnhRD/nK473
 yuDJo2ikUo+AOYckwKS3Vc13W0XS/lp2IchpT+tl+ZwIUTRi9SfEtmq8VsNegQx7xTrL
 +2Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMNGJqCXtRtof9Vpnetn6YFRsDlxFs34tgWIqa7CT6jbEwHSMhfiwAvCq38R6LaRUmJkZ+CRU=@lists.denx.de
X-Gm-Message-State: AOJu0YxFuhxumBWEzgzFZpvxWRlMNDCd2azP9PXQbcQxMg8HSD/iqGO6
 Q9H+O0+Imcl+iHQ+6P5J2P1/CZpZWyx2NadslNp9J3UEP68Kc6gtSwwN/QhFQkU=
X-Google-Smtp-Source: AGHT+IHkCuAcfvwyq7iicpvldyneU5hngXsvyHgs/IPfoh/eqSeU0lCFN0ov7okyC67VQsILfhMCZQ==
X-Received: by 2002:a17:907:60d5:b0:a8a:cc5a:7f3c with SMTP id
 a640c23a62f3a-a90296715f7mr1739081866b.58.1726555103825; 
 Mon, 16 Sep 2024 23:38:23 -0700 (PDT)
Received: from hera (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df770sm409687466b.145.2024.09.16.23.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 23:38:12 -0700 (PDT)
Date: Tue, 17 Sep 2024 09:38:02 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] efi_leader: delete rng-seed if having EFI RNG
 protocol
Message-ID: <ZukjyhHgzQB3SCvf@hera>
References: <20240914160812.43632-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914160812.43632-1-heinrich.schuchardt@canonical.com>
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

On Sat, Sep 14, 2024 at 06:08:12PM +0200, Heinrich Schuchardt wrote:
> For measured be boot we must avoid any volatile values in the device-tree.
> We already delete /chosen/kaslr-seed if we provide and EFI RNG protocol.
>
> Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	put log_debug() in else branch
> ---
>  include/efi_loader.h          |  2 +-
>  lib/efi_loader/efi_dt_fixup.c | 16 +++++++++++-----
>  lib/efi_loader/efi_helper.c   |  2 +-
>  3 files changed, 13 insertions(+), 7 deletions(-)
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
> index 9d017804eea..b97758d1305 100644
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
> +	const char * const prop[] = {"kaslr-seed", "rng-seed"};
>  	const efi_guid_t efi_guid_rng_protocol = EFI_RNG_PROTOCOL_GUID;
>  	struct efi_handler *handler;
>  	efi_status_t ret;
> @@ -67,9 +68,14 @@ void efi_try_purge_kaslr_seed(void *fdt)
>  	if (nodeoff < 0)
>  		return;
>
> -	err = fdt_delprop(fdt, nodeoff, "kaslr-seed");
> -	if (err < 0 && err != -FDT_ERR_NOTFOUND)
> -		log_err("Error deleting kaslr-seed\n");
> +	for (const char * const *pos = prop; pos < &prop[ARRAY_SIZE(prop)];

I think
for (int i = 0; i < ARRAY_SIZE(prop); i++)
    fdt_delprop(fdt, nodeoff, prop[i]);

is a lot easier to read

Other than that, the patch looks fine

Thanks
/Ilias

> +	     ++pos) {
> +		err = fdt_delprop(fdt, nodeoff, *pos);
> +		if (err < 0 && err != -FDT_ERR_NOTFOUND)
> +			log_err("Error deleting %s\n", *pos);
> +		else
> +			log_debug("Deleted /chosen/%s\n", *pos);
> +	}
>  }
>
>  /**
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 96f847652ec..a481eb4b7e3 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -522,7 +522,7 @@ efi_status_t efi_install_fdt(void *fdt)
>  	/* Create memory reservations as indicated by the device tree */
>  	efi_carve_out_dt_rsv(fdt);
>
> -	efi_try_purge_kaslr_seed(fdt);
> +	efi_try_purge_rng_seed(fdt);
>
>  	if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
>  		ret = efi_tcg2_measure_dtb(fdt);
> --
> 2.45.2
>
