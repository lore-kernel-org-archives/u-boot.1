Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC780CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 15:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F7AC88010;
	Wed,  3 Apr 2024 17:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EqsUKX4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2B6C8815D; Wed,  3 Apr 2024 17:36:24 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B41CA87D1A
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 17:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-513e134f73aso8595654e87.2
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 08:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712158581; x=1712763381; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OzsI03HIoZcM1gBvAA8Faz7yKmUY6ESfO/kwylt0etQ=;
 b=EqsUKX4a+silT60Tqm+heuoNUXppnJhjYS2yeBfHdxAyGmLC4NFeKrXexVw/HQWDsP
 AUdCd1dEP211BxiVIoN4DRJQV1Aw6PkjVmCaT0DayL6xARuKLoVrbXuQAH3INpd7XrgA
 kpiZdCeVMG08wHnx3VXLwCXyyvDbu/x5QhTItkJe3Ps9oeh8W9UbUYUPDxUpcDfTTSUg
 ZvxWJMf1DFppTlZ943qgh1cGYn7FKf/6snhcDvXa6qHs4cxQT9kXXxOZD1pT3OwDf8r+
 MLpxTcLi5MOPnV+uL8QCMJJCm6R8ythLmbKyaXUtbgIoI/ykGaH22aliUskVoTnB6Rhz
 QYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712158581; x=1712763381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OzsI03HIoZcM1gBvAA8Faz7yKmUY6ESfO/kwylt0etQ=;
 b=Gs4PMBghDb1Ahatu2Xe4G+JKNsoq6Kx4/A9T+ILfDwExgmlKHeNFiyVzy5h1T+zH/Y
 7w3frh9hWJUgjQycOX5KZ37MhiclPjiXxxEyx2aKM7/qOvQji8KY5gRvqgYgbVH2L7Gv
 nOg19XAAHeoezDkfkgBrGbUlrSJWQYwPSRbWB0d+axcnFqB0ehKjdSiIqjdhS14wW67F
 gFMVIdYHdr6bI7lnEi14fdLZEQLQ2Zx7VFJB6dysXWLBDrYNIa4LKQ7ymMJlOC5ei/f3
 GnGG71dRX+5hajtThDBoac7go+XkWagmi2z17GE5ZARX0M6Fg+YMPz9WEic6IHgg0YI2
 etnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPM9NIlRjqcbUVSN7Yg07PKwiXdoNerpmvdWTz0EkZk7JIPhR/NIQ65/S9RaLtCNn7vFS2Ls2YTfFFZgbJ7+cUm9mzEg==
X-Gm-Message-State: AOJu0YxtqBazhQXw5uTU2uLVNTw5ioUIpTaB70p3YYPgRNK5Yh8pfXn5
 YeAj6V/AE8dL+l9wlnWShxFKCr9FdKJLzgL709Fb/kEO1e7XSu10oqVL3k6VZNfLqMRuCl/gxsP
 3SpsWHNTq1QCwopnTnsUO2Pngq/gKmaRzQSqyVg==
X-Google-Smtp-Source: AGHT+IEXQvxNSiHiRaKgLe8+ZAu1dOL1CJh3I3YZP+k2CrX4jivmWwbFc6aq6spOC4DKyLSyJuMkYRR8WpV/D2OU84U=
X-Received: by 2002:ac2:55a3:0:b0:515:cd30:cd4 with SMTP id
 y3-20020ac255a3000000b00515cd300cd4mr11692866lfg.43.1712158581215; Wed, 03
 Apr 2024 08:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240403153335.96971-1-heinrich.schuchardt@canonical.com>
 <20240403153335.96971-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240403153335.96971-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 3 Apr 2024 18:35:44 +0300
Message-ID: <CAC_iWj+7vn+KX0iBcWbLbMjqLJ5nk3+HYhHCPdL78nZ0O-XqgA@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi_loader: all variable attributes are 32bit
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
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

On Wed, 3 Apr 2024 at 18:34, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> GetVariable() and SetVariable() use an uint32_t value for attributes.
> The UEFI specification defines the related constants as 32bit.
>
> Add the missing EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS constant.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/efi.h                   | 15 ++++++++-------
>  lib/efi_loader/efi_var_common.c |  2 +-
>  lib/efi_loader/efi_variable.c   |  4 ++--
>  3 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/include/efi.h b/include/efi.h
> index f0e5faa7549..62cfb993d2e 100644
> --- a/include/efi.h
> +++ b/include/efi.h
> @@ -492,13 +492,14 @@ extern char _binary_u_boot_bin_start[], _binary_u_boot_bin_end[];
>  /*
>   * Variable Attributes
>   */
> -#define EFI_VARIABLE_NON_VOLATILE       0x0000000000000001
> -#define EFI_VARIABLE_BOOTSERVICE_ACCESS 0x0000000000000002
> -#define EFI_VARIABLE_RUNTIME_ACCESS     0x0000000000000004
> -#define EFI_VARIABLE_HARDWARE_ERROR_RECORD 0x0000000000000008
> -#define EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS 0x0000000000000010
> -#define EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS 0x0000000000000020
> -#define EFI_VARIABLE_APPEND_WRITE      0x0000000000000040
> +#define EFI_VARIABLE_NON_VOLATILE                              0x00000001
> +#define EFI_VARIABLE_BOOTSERVICE_ACCESS                                0x00000002
> +#define EFI_VARIABLE_RUNTIME_ACCESS                            0x00000004
> +#define EFI_VARIABLE_HARDWARE_ERROR_RECORD                     0x00000008
> +#define EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS                        0x00000010
> +#define EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS     0x00000020
> +#define EFI_VARIABLE_APPEND_WRITE                              0x00000040
> +#define EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS             0x00000080
>
>  #define EFI_VARIABLE_MASK      (EFI_VARIABLE_NON_VOLATILE | \
>                                 EFI_VARIABLE_BOOTSERVICE_ACCESS | \
> diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
> index d528747f3fb..16b2c3d4882 100644
> --- a/lib/efi_loader/efi_var_common.c
> +++ b/lib/efi_loader/efi_var_common.c
> @@ -99,7 +99,7 @@ efi_status_t EFIAPI efi_set_variable(u16 *variable_name,
>                   data_size, data);
>
>         /* Make sure that the EFI_VARIABLE_READ_ONLY flag is not set */
> -       if (attributes & ~(u32)EFI_VARIABLE_MASK)
> +       if (attributes & ~EFI_VARIABLE_MASK)
>                 ret = EFI_INVALID_PARAMETER;
>         else
>                 ret = efi_set_variable_int(variable_name, vendor, attributes,
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index 40f7a0fb10d..efe17d98f5a 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -259,7 +259,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>         /* check if a variable exists */
>         var = efi_var_mem_find(vendor, variable_name, NULL);
>         append = !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> -       attributes &= ~(u32)EFI_VARIABLE_APPEND_WRITE;
> +       attributes &= ~EFI_VARIABLE_APPEND_WRITE;
>         delete = !append && (!data_size || !attributes);
>
>         /* check attributes */
> @@ -384,7 +384,7 @@ efi_status_t efi_query_variable_info_int(u32 attributes,
>             EFI_VARIABLE_RUNTIME_ACCESS)
>                 return EFI_INVALID_PARAMETER;
>
> -       if (attributes & ~(u32)EFI_VARIABLE_MASK)
> +       if (attributes & ~EFI_VARIABLE_MASK)
>                 return EFI_INVALID_PARAMETER;
>
>         *maximum_variable_storage_size = EFI_VAR_BUF_SIZE -
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
