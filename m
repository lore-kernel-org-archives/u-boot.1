Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAA3D3C526
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 18:19:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 950378908F;
	Thu, 17 Oct 2024 20:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wvevZ028";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFF5E89092; Thu, 17 Oct 2024 20:19:24 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D77D8900A
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 20:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-208cf673b8dso13628585ad.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 11:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729189160; x=1729793960; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sXB2i8yi19j5MgVoWtC1G7q+6tMqY4UQejjePVNumxg=;
 b=wvevZ0289regIHWeZ4gn9h89g+jpYpPSppCOyHjFRLpPCaYZ85jzNmRNmB0Spnt2AH
 Qs8Nso/pzRPceJAt9i16dOrK/rgxPvUqg8/14UJtB/W1bwIMlrm3Un8TYdzcXQQbUsx/
 AWNMD907qYaNX1S8R/SVfR14/MHSfB25bKOWIat4E4GXwjIy5rRwXw8h1ClXdASVvF9C
 lLS/BEZYokJVKFHEagj69SNu3vsc+tYF/biFNnlEZlwDQrsdwO0Ir3k/GwXHZZUsMxGf
 lQRFx65wvNyn9bxzbjBguj5V9SpGZLUibUt9TmvBMe6nRjQneKdjHb1ff6JxbmLUqBAh
 HneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729189160; x=1729793960;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sXB2i8yi19j5MgVoWtC1G7q+6tMqY4UQejjePVNumxg=;
 b=vmfn0wtrGuZwa+6Np9u9Nk7ZZUxaT4ekFDZiljlfl6iL1grsQAhYtPxSSrSiBbXRHI
 W+940tGod51daItG3hF/xyBTsnEXaT1V4ACNHIyxkE9vSHhtlbe9gtus47cm94RoJtku
 YBUtZ0V7dpvVOTkQ5hfo3F+RkP/GEJY2x75B6aPIebe4j8D7LyD/wGrudPkg97dOrSeT
 VJwwnT0Rsm3tcbbjha8De3SNktFw6s/50nAPS/gy1WNpdLe0bxoZAIc9bwaMSyRZCBws
 mH7E0dk8AigNjcizG5mGZp5dVXh7BJBnhkcwyp7iv7sxdXPmuQSo61yWAB41O21q/ztI
 v49Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0afLnIc1IoukTF0z3YsgEH7Sor2h17fqoRPL8nHVkw0d26Mk2Oxa5Uh1eG53ehaLd0g8YzS8=@lists.denx.de
X-Gm-Message-State: AOJu0YxgRfHxqG+VWMuobI9TPR8xm8z0ugLNycpy9QBIsnpowOHxeOXh
 iA35wqd2A6OfCt7YPIfokrPs6RPgOt3IXr3R10MhdUryHUVqXxjPaGTSGGQ+2e1EM7p6e+rZOxN
 tbPaAmfT3i3J2FPkefSr7BTh50gWVa3wyzQYMWw==
X-Google-Smtp-Source: AGHT+IH3UxE/LJQe8xFu2+eeUiMhTRIivdM1FcmnkboXn9omi+4VwcyLS5c/Jbp8BtLLK3v2SNq5vOLwX17j6CGdcLQ=
X-Received: by 2002:a17:902:ecc8:b0:20c:5cdd:a9e with SMTP id
 d9443c01a7336-20d27eeab51mr108996755ad.28.1729189159994; Thu, 17 Oct 2024
 11:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20241017181306.6615-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241017181306.6615-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Oct 2024 21:18:44 +0300
Message-ID: <CAC_iWjKsSgN=LTAvpdvwDVtMQN17FxWifJSqucaKcY5bp864sw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: remove ERROR:,
 WARNING: prefixes in messages
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

On Thu, 17 Oct 2024 at 21:13, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We should not write "ERROR:" or "WARNING:" when using log_err() or
> log_warning(). These prefixed don't provide additional information.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_helper.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index a481eb4b7e3..00167bd2a10 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -412,7 +412,7 @@ static efi_status_t copy_fdt(void **fdtp)
>                                  EFI_ACPI_RECLAIM_MEMORY, fdt_pages,
>                                  &new_fdt_addr);
>         if (ret != EFI_SUCCESS) {
> -               log_err("ERROR: Failed to reserve space for FDT\n");
> +               log_err("Failed to reserve space for FDT\n");
>                 goto done;
>         }
>         new_fdt = (void *)(uintptr_t)new_fdt_addr;
> @@ -468,7 +468,7 @@ efi_status_t efi_install_fdt(void *fdt)
>          * but not both.
>          */
>         if (CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE) && fdt)
> -               log_warning("WARNING: Can't have ACPI table and device tree - ignoring DT.\n");
> +               log_warning("Can't have ACPI table and device tree - ignoring DT.\n");
>
>         if (fdt == EFI_FDT_USE_INTERNAL) {
>                 const char *fdt_opt;
> @@ -483,13 +483,13 @@ efi_status_t efi_install_fdt(void *fdt)
>                 if (!fdt_opt) {
>                         fdt_opt = env_get("fdtcontroladdr");
>                         if (!fdt_opt) {
> -                               log_err("ERROR: need device tree\n");
> +                               log_err("need device tree\n");
>                                 return EFI_NOT_FOUND;
>                         }
>                 }
>                 fdt_addr = hextoul(fdt_opt, NULL);
>                 if (!fdt_addr) {
> -                       log_err("ERROR: invalid $fdt_addr or $fdtcontroladdr\n");
> +                       log_err("invalid $fdt_addr or $fdtcontroladdr\n");
>                         return EFI_LOAD_ERROR;
>                 }
>                 fdt = map_sysmem(fdt_addr, 0);
> @@ -497,7 +497,7 @@ efi_status_t efi_install_fdt(void *fdt)
>
>         /* Install device tree */
>         if (fdt_check_header(fdt)) {
> -               log_err("ERROR: invalid device tree\n");
> +               log_err("invalid device tree\n");
>                 return EFI_LOAD_ERROR;
>         }
>
> @@ -510,12 +510,12 @@ efi_status_t efi_install_fdt(void *fdt)
>         /* Prepare device tree for payload */
>         ret = copy_fdt(&fdt);
>         if (ret) {
> -               log_err("ERROR: out of memory\n");
> +               log_err("out of memory\n");
>                 return EFI_OUT_OF_RESOURCES;
>         }
>
>         if (image_setup_libfdt(&img, fdt, false)) {
> -               log_err("ERROR: failed to process device tree\n");
> +               log_err("failed to process device tree\n");
>                 return EFI_LOAD_ERROR;
>         }
>
> @@ -527,7 +527,7 @@ efi_status_t efi_install_fdt(void *fdt)
>         if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
>                 ret = efi_tcg2_measure_dtb(fdt);
>                 if (ret == EFI_SECURITY_VIOLATION) {
> -                       log_err("ERROR: failed to measure DTB\n");
> +                       log_err("failed to measure DTB\n");
>                         return ret;
>                 }
>         }
> @@ -535,7 +535,7 @@ efi_status_t efi_install_fdt(void *fdt)
>         /* Install device tree as UEFI table */
>         ret = efi_install_configuration_table(&efi_guid_fdt, fdt);
>         if (ret != EFI_SUCCESS) {
> -               log_err("ERROR: failed to install device tree\n");
> +               log_err("failed to install device tree\n");
>                 return ret;
>         }
>
> @@ -574,7 +574,7 @@ efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options)
>          */
>         ret = efi_set_watchdog(300);
>         if (ret != EFI_SUCCESS) {
> -               log_err("ERROR: Failed to set watchdog timer\n");
> +               log_err("failed to set watchdog timer\n");
>                 goto out;
>         }
>
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
