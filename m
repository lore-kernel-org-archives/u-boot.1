Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E506CFD342
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 11:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D55AD892EF;
	Fri, 11 Oct 2024 13:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bQG0/Oqt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A6A1892F6; Fri, 11 Oct 2024 13:04:15 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37854892C6
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 13:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20c767a9c50so16245205ad.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 04:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728644652; x=1729249452; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZxH0wB+ONHHJQsHvwG9WpCYZg6FxF/9WzYBCu7VeEmA=;
 b=bQG0/OqteSI+tdQbHeQt3/Rnhpj5V+gMg3Cd8ARAd/hlkRa7PqtbPm3tW29qwCjoUv
 t8qccFmTUC9hGvJBI6JShw2dgVxRFQVnrGtbnqXD/9C/4sa6MFTCcVSX8gUqEjt9WV7t
 4e6x99CLGQeq5s69VCFWiYodWJ3qaQz0UNn9x/OZrrFHFWdVDaUYqeqBLX1DIMnaUCmO
 +SYYRFfySiUxTkj8GmfkpM1yfPd2wDgrKYdEYAWyJ3Y8buCDOJDtUyyxbka882p7lL7t
 dnM9uz8sX5lNIQ7K7m0upkP9KJi1/uPVjVJeJk9ux7LIsSBXncHOCeUhbLHoz07WaBNy
 1Rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728644652; x=1729249452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZxH0wB+ONHHJQsHvwG9WpCYZg6FxF/9WzYBCu7VeEmA=;
 b=Pa+jvJptbeGQewLEk6YUd2ZZhPHomi7UXV6J8NIRK2GCxLBZBsEGtPyAWAukg/2Qtk
 VxFaxABwYcWvj4ePo4/2asQrVAFfY4rK8wwH5MVoBjVhPBLCsRWlnI7N3ZhahXtUvthS
 OcuFkyAcU8WPIbdXeTx521Sc55MXfoNhmC2nFT6YTr2XlOTISA6s2cj0bJnU5XDJ/eo/
 4oWogxrYxevDESD3jIO7VBg2bNCS0lkyUsi3vrYPLmyetwUlThGqMFetGrO3or50S5ow
 L+SuPKOK5wPb1StX3doedI2Pl116igCN9J6wirMRtYxYOQWvGo0tQujX309n4uK6NNZX
 u2kg==
X-Gm-Message-State: AOJu0YxkmngyWz75n28W3dxn8KoveNdk70IrE95kbx4bZa9UhlB1oOE/
 72ALJlwhaD8L76nFiCYfSjwDCUoD9/BqChKA/gfsWjyySSeNs2Bp2qpeDeeXwB500CbR08U62oG
 IaJKklkpOnXWtnwSWCorcU3LAmwgNLHdqwVj8lw==
X-Google-Smtp-Source: AGHT+IGhJ3GAK/V7zlFlMZcx/xNgU9gAt3fqI6RS8H4U5Se4+an+YErbdKahXVYABH0hBrvxP6Uxad4eTOUrpPoHLtw=
X-Received: by 2002:a17:903:110c:b0:20c:6bff:fcae with SMTP id
 d9443c01a7336-20ca142b864mr34711325ad.5.1728644651749; Fri, 11 Oct 2024
 04:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
 <20241008181435.1753814-14-sughosh.ganu@linaro.org>
In-Reply-To: <20241008181435.1753814-14-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Oct 2024 14:03:35 +0300
Message-ID: <CAC_iWjLwV-NXU1TuYFRy-fyUon5-_eeNvAcpf_CdZjkyoE9PcQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] lmb: remove call to efi_lmb_reserve()
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Tue, 8 Oct 2024 at 21:15, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The EFI memory allocations are now being done through the LMB
> module. With this change, there is no need to get the EFI memory map
> and set aside EFI allocated memory.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Do not remove the inclusion of efi_loader.h as it is now needed for
>   the lmb_map_update_notify()
>
>  lib/lmb.c | 35 -----------------------------------
>  1 file changed, 35 deletions(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 82dfd36364b..82fa9cd14b9 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -208,38 +208,6 @@ static void lmb_fix_over_lap_regions(struct alist *lmb_rgn_lst,
>         lmb_remove_region(lmb_rgn_lst, r2);
>  }
>
> -/**
> - * efi_lmb_reserve() - add reservations for EFI memory
> - *
> - * Add reservations for all EFI memory areas that are not
> - * EFI_CONVENTIONAL_MEMORY.
> - *
> - * Return:     0 on success, 1 on failure
> - */
> -static __maybe_unused int efi_lmb_reserve(void)
> -{
> -       struct efi_mem_desc *memmap = NULL, *map;
> -       efi_uintn_t i, map_size = 0;
> -       efi_status_t ret;
> -
> -       ret = efi_get_memory_map_alloc(&map_size, &memmap);
> -       if (ret != EFI_SUCCESS)
> -               return 1;
> -
> -       for (i = 0, map = memmap; i < map_size / sizeof(*map); ++map, ++i) {
> -               if (map->type != EFI_CONVENTIONAL_MEMORY) {
> -                       lmb_reserve_flags(map_to_sysmem((void *)(uintptr_t)
> -                                                       map->physical_start),
> -                                         map->num_pages * EFI_PAGE_SIZE,
> -                                         map->type == EFI_RESERVED_MEMORY_TYPE
> -                                             ? LMB_NOMAP : LMB_NONE);
> -               }
> -       }
> -       efi_free_pool(memmap);
> -
> -       return 0;
> -}
> -
>  static void lmb_reserve_uboot_region(void)
>  {
>         int bank;
> @@ -286,9 +254,6 @@ static void lmb_reserve_common(void *fdt_blob)
>
>         if (CONFIG_IS_ENABLED(OF_LIBFDT) && fdt_blob)
>                 boot_fdt_add_mem_rsv_regions(fdt_blob);
> -
> -       if (CONFIG_IS_ENABLED(EFI_LOADER))
> -               efi_lmb_reserve();
>  }
>
>  static __maybe_unused void lmb_reserve_common_spl(void)
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
