Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D82C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 08:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C39880756;
	Wed, 26 Mar 2025 09:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jsbslicw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE8D5808B6; Wed, 26 Mar 2025 09:24:44 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BE408070C
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 09:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6ff4faf858cso49449067b3.2
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 01:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742977481; x=1743582281; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBcFkV8SPwW+1jv5bo7lDV1pq1kdnHOb3vTvynZdNo8=;
 b=Jsbslicwm64Bomti6oFm6OcsRsSfp9ShFxUSWo6anRsUEHtniW6Lz6gRcXBiK7C5/m
 li0TmCkrJ1emjBg8MSbK2FqhphfPMiogGMYgy3epgNfg+oAeZ/5ZJZmL+4fXCF49Kacm
 71peWSMrBMCxxROV141elRyD4psbAYazcyGhN2JvtvJwIwO3ILMkizczMNyho7dSHLFN
 tmt0VoB0S7TmRqzr9V6nIV7746JRLYoqM0Qn2HeeLXoxI5nkMgcSDQY0HEd1qeY2NU13
 /WjUI5PuddqK1KONj/lGvKqwecTU7CYMDXD7jjSHo6fBiXgXb+GnPgBmd1dbshjwHCBU
 vvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742977481; x=1743582281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZBcFkV8SPwW+1jv5bo7lDV1pq1kdnHOb3vTvynZdNo8=;
 b=SvT1IjWSk2ulGEXlYmsbqzyvDoWhvQ3VXCkNDYYQQYbI5NfBKwAAAHTtPJeezaC/zr
 y8J3ImYidSw/rXeHtuIjuCJo4GFq4xvOwdhLU0BOyuEO8vjLocRaEkTQ6gDt3FzyM3ru
 IF8ag31z7txZk5vaLjBKEoVeco/NWLOFioxWAnY/JKkOBS5C15dQCdoTWFnnqKbZvwne
 XU42F0oP/dI8VMeZ0TX3CVrsbWLave0nJNFfxUeXAxWJEhuNLo5NIDf0MsuQVBKmPU23
 7WZMyphtegj+ZLWcaPn++vbIP+5dxXFsM7Fl8rYiFILxhLrZ79nqHDByM2wHZ9J2A27d
 b2LA==
X-Gm-Message-State: AOJu0Yy0OCJxQFR+M+fZDUpRt0g+TDGl1OUn4x3122ltEqTkCayFAbnP
 dHzw3yL5BEI81yday6U6K9FF1mrVxMR32lmtTieMILIYkpKF8W0gf6CcVhHdGqiuuzgt02Dy3ip
 Hee/fa8G76oWdveslIqVO3lWUBoaSoHV0gNyr0Q==
X-Gm-Gg: ASbGncuylu6tPbkQ0nZjSkP9395RPXSi7pFQi3R1S33wGGeO6tgkKn7Bb0sL27XX14t
 ZpFfhzcfMuny+ipUzq6YXJ4n7bIBkfc7rRul47/hfdQ7apBfyjnZcWzzDkHr0itRTIm7pxt9Ek1
 53+Wtw/Rxqq4V1fAe1VUxSR/ytluccczjfanKRSw==
X-Google-Smtp-Source: AGHT+IEX3cHWKlfLP+8TzX6+f5/vIaKYr02HTZx759LMh+1HTExGeezAaxJU9Ox9dQMwun8ROgc8xRakLm7yXL6+Ees=
X-Received: by 2002:a05:690c:64ca:b0:6f9:78c0:3a5f with SMTP id
 00721157ae682-700bac5f614mr292887277b3.19.1742977481233; Wed, 26 Mar 2025
 01:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250317083402.412310-1-sughosh.ganu@linaro.org>
 <20250317083402.412310-3-sughosh.ganu@linaro.org>
In-Reply-To: <20250317083402.412310-3-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Mar 2025 10:24:05 +0200
X-Gm-Features: AQ5f1JrXoHvOq6qFKHKq4VEAxSQLmrAbdInVqvJ3iKRbhyIaeBeTVfT6uVTWtAc
Message-ID: <CAC_iWjJgOwvovyLTtiDu3PqMvCFX4SrOGj6CCE5QQMV-Ypq=Tw@mail.gmail.com>
Subject: Re: [PATCH v9 2/8] efi_loader: install device-tree on configuration
 table on every invocation
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>
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

Hi Sughosh

On Mon, 17 Mar 2025 at 10:34, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The efi_install_fdt() function is called before booting an EFI binary,
> either directly, or through a bootmanager. This function installs a
> copy of the device-tree(DT) on the EFI configuration table, which is
> passed on to the OS.
>
> The current logic in this function does not install a DT if a
> device-tree is already installed as an EFI configuration
> table. However, this existing copy of the DT might not be up-to-date,
> or it could be a wrong DT for the image that is being booted. Always
> install a DT afresh to the configuration table before booting the EFI
> binary.
>
> Installing a new DT also involves some additional checks that are
> needed to clean up memory associated with the existing DT copy. Check
> for an existing copy, and free up that memory.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V8:
> * Re-word the commit message to indicate DT being installed as EFI
>   configuration table
> * Remove the existing EFI config table in copy_fdt()
> * Move assignment of new_fdt_addr and fdt_pages variables to the block
>   freeing up the existing config table memory
>
>  lib/efi_loader/efi_helper.c | 39 +++++++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 10 deletions(-)
>
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 15ad042bc61..f6fbcdffe82 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -454,11 +454,30 @@ efi_status_t efi_env_set_load_options(efi_handle_t handle,
>   */
>  static efi_status_t copy_fdt(void **fdtp)
>  {
> -       unsigned long fdt_pages;
>         efi_status_t ret = 0;
>         void *fdt, *new_fdt;
> -       u64 new_fdt_addr;
> -       uint fdt_size;
> +       static u64 new_fdt_addr;
> +       static efi_uintn_t fdt_pages;
> +       ulong fdt_size;
> +
> +       /*
> +        * Remove the configuration table that might already be
> +        * installed, ignoring EFI_NOT_FOUND if no device-tree
> +        * is installed
> +        */
> +       efi_install_configuration_table(&efi_guid_fdt, NULL);
> +
> +       if (new_fdt_addr) {
> +               log_debug("%s: Found allocated memory at %#llx, with %#zx pages\n",
> +                         __func__, new_fdt_addr, fdt_pages);
> +
> +               ret = efi_free_pages(new_fdt_addr, fdt_pages);
> +               if (ret != EFI_SUCCESS)
> +                       log_err("Unable to free up existing FDT memory region\n");
> +
> +               new_fdt_addr = 0;
> +               fdt_pages = 0;
> +       }
>
>         /*
>          * Give us at least 12 KiB of breathing room in case the device tree
> @@ -473,15 +492,18 @@ static efi_status_t copy_fdt(void **fdtp)
>                                  &new_fdt_addr);
>         if (ret != EFI_SUCCESS) {
>                 log_err("Failed to reserve space for FDT\n");
> -               goto done;
> +               return ret;
>         }
> +       log_debug("%s: Allocated memory at %#llx, with %#zx pages\n",
> +                 __func__, new_fdt_addr, fdt_pages);
> +
>         new_fdt = (void *)(uintptr_t)new_fdt_addr;
>         memcpy(new_fdt, fdt, fdt_totalsize(fdt));
>         fdt_set_totalsize(new_fdt, fdt_size);
>
> -       *fdtp = (void *)(uintptr_t)new_fdt_addr;
> -done:
> -       return ret;
> +       *fdtp = new_fdt;
> +
> +       return EFI_SUCCESS;
>  }
>
>  /**
> @@ -534,9 +556,6 @@ efi_status_t efi_install_fdt(void *fdt)
>                 const char *fdt_opt;
>                 uintptr_t fdt_addr;
>
> -               /* Look for device tree that is already installed */
> -               if (efi_get_configuration_table(&efi_guid_fdt))
> -                       return EFI_SUCCESS;

This is the last nit I have an I think these are ready for  -next.

Instead of removing the existing table in copy_fdt, can we remove it
before calling copy_fdt() in efi_install_fdt()

if (efi_get_configuration_table(&efi_guid_fdt))
    efi_install_configuration_table(&efi_guid_fdt, NULL);
should be enough and you can also check the return code that way

Cheers
/Ilias


>                 /* Check if there is a hardware device tree */
>                 fdt_opt = env_get("fdt_addr");
>                 /* Use our own device tree as fallback */
> --
> 2.34.1
>
