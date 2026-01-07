Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166CDCFD64C
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 15:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FD7183A26;
	Wed,  7 Jan 2026 16:01:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C3EnGgOf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EC0A83A2D; Wed,  7 Jan 2026 16:01:06 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E947839D7
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 16:01:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-790abc54b24so19126027b3.3
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 07:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767798061; x=1768402861; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WIqfKBiW2ZkzOMh37XHlk8dRjDrh2u/3+UuV5QL/67g=;
 b=C3EnGgOftuMWECzyR/q02Yn1f80IfadjeRzbQhIdDEeO8Q5ji8Hg3VhpJmXX7WH7CT
 YYAwTC99I8ACpDDbY3qwmm5nl7Swl2r26N8Nc6uUJWAEzIxmYIvbvxg0GHxbCncavBO+
 hLzSqwWURisok6PbTaqqc/1nZ8qebVqBI3wIIC0uQE+8ih7pXbOM9j+ueek9Gi/U7QYf
 IrdfVq5ext/VBkk62bJbfgphprgy0MmPePHZXHxyECN+BmaiAWbGxUIccZ+FKzNBbalt
 q0qgeehhKsq5ba2ZB9Oc9vJMjHokGQMDqxdUmQYmdkXsxNgUPoM83vA0GxxEkWXcovD6
 7FaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767798061; x=1768402861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WIqfKBiW2ZkzOMh37XHlk8dRjDrh2u/3+UuV5QL/67g=;
 b=tGRIZ8Sqs+iwfF2G46LkyuTCLD/AcbqlKO8V1+1pWEEV5+5D6X2VX1g4Mdloj1NoSu
 4pb9BTDk4ZvA8Jmbm3tVm69dr93oy/YKjOl7yYSN/pjUdDiwSDf9+vktCcTa8hbWpn/0
 Xa7BGT9StK5MrDSr6U32cCFcrUq1l5NYXsepDR1K1l48LnCW0MFTsxARKBT4Km6IEROM
 YNj0vn6cD2eKmS8nLb+U9/hAHA5vkzc0Dc4Shv+GVB1S/Wk5mxHP7EIO/7Zgc9hTiakM
 wAInbVMfC/s8F14kSPSTPPBkzfSpxyuiJMWydJXHG9/AGkq7ipJldrlAPlEgF2MbTDh2
 odNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyUUr7I8HVXBRw97Gn5ENVr4AI4U09GVymDVw/+Zh4YFXWIEiqeb5YhHPuKpnwLnag37RzHRo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9mcqSwcvYm5+7sz9oag88Yct8IYHBJ4vEud2VaDjqvL9QtZVu
 DCrFJJOnMUfEaJsUHS4UOkW3JoX6pKPvkOEShDeFck+VVzNzpiJo7YEt6kNm+nMAcWkERrBhcTY
 xprFLRfT5S7vURLy3aefkduiVx1zqLaytWOheTNMaaQ==
X-Gm-Gg: AY/fxX4SGkwiVfydBE5Cf/tkrigkkxmPsA7QzfEu21Dzod1nPshi4ldVpDP7bl+gTlT
 dyYGY9BIYz1f2fKzZHT5w8IQHtPHIRNKGYgStOh3oTaEPbCZy4mz5LHyAbg3Jo6emMUAwRBjNwt
 iXCT2YRT5HajEY1eGh/iALr9rc9bPS5CgGvi2oSgJkDZP2nDigOlkfDvIjHWPxmxtzJUl4cJw0O
 FbjOx4YjC3ovnY6eTKBEjaxP083lBmLGglxn7n/D4gu8AVWrfps0vMur0/q6mooqsCoP6XbZXSp
 dawP4YIJxD0tJjlzNzTOQBKs74gfBfaEK26+8ckuYeS4gNK3jnhJHNqvJaSSRgT6Hqr5aua998H
 C4GuhfurJpdapz0qDt9dbaPMVIGkrN7mvFT5LKMK918fne+aFlm7XTe1bHT/dx6monw/d67dzsS
 HYyavSXqIo1XiYUciyMOEdL77z5DCoODX9CJ0Kg9wMWT3O3UaSQaFxqaMGMrJKdY6oUHrey29YP
 3ZvK0ASt2YRWRJdn5xe0qQSmvoieZ9O9/PEfz9sKCmmwmTlzDyXxMPK+VELWRQF/FslHHuNBmmB
 bNMbbcuEYTNspwJdS/wVGPkYo8QFS+M=
X-Google-Smtp-Source: AGHT+IFmcjhGX3QNLaqhLhC8pq7VBOO7bxu3LdiNeSMz2ak32El3YwHwqmCvoxERzyWhFAzZqVk49GbCvTnnbQ+g2ZA=
X-Received: by 2002:a53:c059:0:10b0:646:7b46:55c0 with SMTP id
 956f58d0204a3-64716c7da70mr2193699d50.74.1767798059059; Wed, 07 Jan 2026
 07:00:59 -0800 (PST)
MIME-Version: 1.0
References: <20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com>
 <20260106122134.2047864-2-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260106122134.2047864-2-aswin.murugan@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 7 Jan 2026 17:00:23 +0200
X-Gm-Features: AQt7F2rPK7WgF082--HUhKgoG3NOH7giWA9ZJ6Uy7YWhRq6ZlX1V3bsUkbvHhPo
Message-ID: <CAC_iWjJb+PfxO+5gC8bYNp-803s6Tf3v59aL9UJeTBZW+X5i_A@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] efi_loader: Add platform hook for FDT loading
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, xypron.glpk@gmx.de, 
 varadarajan.narayanan@oss.qualcomm.com, adrianox@gmail.com, 
 paul.liu@linaro.org, sjg@chromium.org, wolfgang.wallner@at.abb.com, 
 javier.tia@linaro.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

Hi Aswin,

On Tue, 6 Jan 2026 at 14:22, Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> Introduce a weak function efi_load_platform_fdt() to allow platforms
> to provide custom device tree selection logic. This enables platforms
> with special requirements (such as multi-DTB selection based on
> hardware detection) to load fdt.
>
> The default weak implementation does nothing, Platforms can provide
> a strong implementation to load platform-specific device trees.

We have multiple methods of loading an alternative DT. You can for
example define them as a boot option ion the eficonfig command.
How you elaborate more on the requirements your platforms have and why
the existing code isn't enough?

Thanks
/Ilias
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  include/efi_loader.h         |  2 ++
>  lib/efi_loader/efi_bootmgr.c |  4 ++++
>  lib/efi_loader/efi_fdt.c     | 23 +++++++++++++++++++++++
>  3 files changed, 29 insertions(+)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 3e70ac07055..62c3df48f71 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -1303,4 +1303,6 @@ int efi_get_distro_fdt_name(char *fname, int size, int seq);
>
>  void efi_load_distro_fdt(efi_handle_t handle, void **fdt, efi_uintn_t *fdt_size);
>
> +void efi_load_platform_fdt(efi_handle_t handle, void **fdt, efi_uintn_t *fdt_size);
> +
>  #endif /* _EFI_LOADER_H */
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index a687f4d8e85..ed06a65feb7 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -1332,6 +1332,10 @@ efi_status_t efi_bootmgr_run(void *fdt)
>                         efi_load_distro_fdt(handle, &fdt_distro, &fdt_size);
>                         fdt = fdt_distro;
>                 }
> +               if (!fdt) {
> +                       efi_load_platform_fdt(handle, &fdt_distro, &fdt_size);
> +                       fdt = fdt_distro;
> +               }
>         }
>
>         /*
> diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
> index bfaa9cfc207..bfcfd933adf 100644
> --- a/lib/efi_loader/efi_fdt.c
> +++ b/lib/efi_loader/efi_fdt.c
> @@ -78,6 +78,29 @@ int efi_get_distro_fdt_name(char *fname, int size, int seq)
>         return 0;
>  }
>
> +/**
> + * efi_load_platform_fdt() - Platform-specific FDT loading hook (weak)
> + *
> + * @handle:    handle of loaded image
> + * @fdt:       on return device-tree, must be freed via efi_free_pages()
> + * @fdt_size:  buffer size
> + *
> + * This weak function allows platforms to provide custom DTB selection logic.
> + * The default implementation does nothing, allowing the standard distro boot
> + * path to handle FDT loading. Platforms can override this function to
> + * implement custom multi-DTB selection or other platform-specific logic.
> + *
> + * If this function successfully loads a DTB, it should set *fdt to point to
> + * the loaded DTB and return. If it cannot load a DTB, it should set *fdt to
> + * NULL, and the standard distro boot logic will be used as fallback.
> + */
> +__weak void efi_load_platform_fdt(efi_handle_t handle, void **fdt,
> +                                 efi_uintn_t *fdt_size)
> +{
> +       /* Default: do nothing, let standard distro boot handle it */
> +       *fdt = NULL;
> +}
> +
>  /**
>   * efi_load_distro_fdt() - load distro device-tree
>   *
> --
> 2.34.1
>
