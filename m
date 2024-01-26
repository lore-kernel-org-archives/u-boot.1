Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C80AC47DDB
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 08:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBBE687BC4;
	Fri, 26 Jan 2024 09:10:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hrNxSkNE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 398E787BC9; Fri, 26 Jan 2024 09:10:24 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4931987BAD
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 09:10:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ccec119587so1844561fa.0
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 00:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706256621; x=1706861421; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/4nz/2aec/IHkdg/FLMqJemKNgvOAiRZpgPF2KYgTxg=;
 b=hrNxSkNEkoYJYxMZLsNBq6ws2oO+h8VMWMlOO2ht1VBqXj6Ixv0OQDnO1HprCicy/b
 HUprqsg7wmrUSg3THHg5Gn1UcjW/PeEnCDrAAr4s5BBOq9YJ3FjWCE2A8xTVXVD8+WG4
 m4Nf+N9LZ3zFV0a2Ug1S3ERaJIgcQoTl8MikxgYpDAJvSu3fw8T+Aob3OZVEP171Ekpj
 nEuoAS0JSAf0ZXBLQRboL/jK/4wWTm844hLeSKK8VkjSaaj8+R9OLnDOkEa5h/+FF93u
 mzwsSLzxIMYk+5Ox42b1E9IfkuqvIFeanG4qqXEBM5tJqn2gDwqFfQbOhcerMEZx8D+l
 9E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706256621; x=1706861421;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/4nz/2aec/IHkdg/FLMqJemKNgvOAiRZpgPF2KYgTxg=;
 b=Nk5wOiEB2oLN9su9JlhhRhyOBGYJhi3ZDcosJdVR724YQ/QAoKloMhf8UWZJZBlAMj
 C/WcfRb+JBpIRVRy/TUAGo8wfentuYlvcypVr/NbxVxHdQWhiXjIG3ILIET7Si5YlXi+
 /RyKZ81R5IgaEwl+t+DfTJlbGQiDKeIRPPn5p3iJseftMXSeyG11lfHUjhXLP/r8r/6k
 IFxL1faUFMT7vIMGxTBu5yaOPz/xmLfbCm3NNJw2BnDPVetJcdMOiLm3tu4qO43aigsx
 9v/sU+m5t2HA2Zf8ujJ4CDP/HZHnEPglswRQSt9BOGgVCdEeA2Yh3o9XAXLeBX9k0hz4
 luBw==
X-Gm-Message-State: AOJu0Yw4vUuW5CqdZIpg1Ts+MzHL3kFHqWGYpS3AfuJlVwLb3nBVTkQy
 lxW8yHfP8D7KsKQvf+fYDKf47aXrFb+zYK7AjsfGzOpP3GDxO+4XuutWy04zUe08dNwhLSakPMA
 VbBnLamzv5yUPfpJKYNcgNyABFTKIWIGH6eCAgA==
X-Google-Smtp-Source: AGHT+IHna7TCm1zs/k5Lfk6XCH3w/fUbV+CIsuWFIvPB0glcE2o/mMTIUmdhpshklot8C2vLWjr3xDJZlAh1Yup0GF8=
X-Received: by 2002:a2e:9d84:0:b0:2cf:1f0b:5119 with SMTP id
 c4-20020a2e9d84000000b002cf1f0b5119mr944231ljj.17.1706256621691; Fri, 26 Jan
 2024 00:10:21 -0800 (PST)
MIME-Version: 1.0
References: <20240126075431.22876-1-heinrich.schuchardt@canonical.com>
 <20240126075431.22876-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240126075431.22876-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 26 Jan 2024 10:09:45 +0200
Message-ID: <CAC_iWjKFgzSu=42iU-ysOxGGo4y1ii7=_ACx2RLhw5E+rU0xBg@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi_loader: export efi_get_configuration_table
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
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

On Fri, 26 Jan 2024 at 09:54, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> In multiple places we need a function to find an EFI configuration table.
> Rename get_config_table() to efi_get_configuration_table() and export it.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/efi_loader.h        | 2 ++
>  lib/efi_loader/efi_helper.c | 6 +++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index d5fca2fa5ef..2c44614dde4 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -545,6 +545,8 @@ void efi_setup_console_size(void);
>  /* Set up load options from environment variable */
>  efi_status_t efi_env_set_load_options(efi_handle_t handle, const char *env_var,
>                                       u16 **load_options);
> +/* Get EFI configuration table */
> +void *efi_get_configuration_table(const efi_guid_t *guid);
>  /* Install device tree */
>  efi_status_t efi_install_fdt(void *fdt);
>  /* Execute loaded UEFI image */
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 11066eb505d..5dd9cc876e4 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -380,12 +380,12 @@ done:
>  }
>
>  /**
> - * get_config_table() - get configuration table
> + * efi_get_configuration_table() - get configuration table
>   *
>   * @guid:      GUID of the configuration table
>   * Return:     pointer to configuration table or NULL
>   */
> -static void *get_config_table(const efi_guid_t *guid)
> +void *efi_get_configuration_table(const efi_guid_t *guid)
>  {
>         size_t i;
>
> @@ -430,7 +430,7 @@ efi_status_t efi_install_fdt(void *fdt)
>                 uintptr_t fdt_addr;
>
>                 /* Look for device tree that is already installed */
> -               if (get_config_table(&efi_guid_fdt))
> +               if (efi_get_configuration_table(&efi_guid_fdt))
>                         return EFI_SUCCESS;
>                 /* Check if there is a hardware device tree */
>                 fdt_opt = env_get("fdt_addr");
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
