Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8942BCDB482
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 14:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D2E186F12;
	Tue, 17 Oct 2023 16:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aPaNk+r2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D3E986F12; Tue, 17 Oct 2023 16:16:42 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D637B86380
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 16:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507b9408c61so1655528e87.0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 07:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697552196; x=1698156996; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PFwoZyDHXInIdNRXwskaWymeIepujt49Om8cK7Mev6M=;
 b=aPaNk+r2gry9paRFBuQKOefhp0liLXn3K/UuxlwR4dym5O2PLykkq4nlSVkq30WY4l
 NtJKcq0CHLm9mc/9fqKgG32WGPLKqlAaseA0rulYozDCVhQli567vMsoX1Qq6FJge3Lj
 THuAjflsL+NEc2LDwsCMSqt6MEtuVLDPhhwNuUWan3dwwWNOvrpZ0lrRe6xFz+BMd/i3
 TazCN07PuEIncmlA8RT4y4xXQCXbvT1YYwXeQriK2n/G5n6mZ92REhv9BdrDAXQsvjg0
 djbheDXtPV0MDpqasy7dT2sbSXziQB2+BE6TPgbVafzn+fswqWOwnTACKIC//kcLlJXS
 JqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697552196; x=1698156996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PFwoZyDHXInIdNRXwskaWymeIepujt49Om8cK7Mev6M=;
 b=JtXmo8T+F87Jx97kcp48OdnUycPOIG+uWGyONKh+3AIsOEP3KTGJTk01E3wx5isYt2
 P5yoNrsIQNvm8cmGZOs0QtV84RcRZOjYvz9ITs5T6zd7QYgkk0Yj+veFamaNe5Vnue0e
 q1G8kVbrNp8ori95aiePyChjRzYzotfiuIEfZYYMSZCMuVJJxzt6TFcKq5/ndJDLkGQL
 /HZ6lhfQcZDl11oviQjlgYuukxwDYSz9CyI8B4VAzuptzX09DQ7xVhlX958Ng8474ZBd
 Te68xzMZ3ADrevWRboy94oEex2OjXf+DjvQsd+VH/T6xd3ci/rWvKXYv/RxmZumlPk76
 MZQg==
X-Gm-Message-State: AOJu0Yyh4jwUmeis7fX9Uuf5DBFivm5c92AFemUy1Hnh9nhvPAfPgXKP
 XvJMnZzfCMmLTYH9+OPu7xXx9haLSnBOQ0Gc1bnA1A==
X-Google-Smtp-Source: AGHT+IHoLRq59fTJf66iHAQOu0cpSFG6EQxMva1bf1w+8K5LMpCv7dLCKI9ksQpBbFN1ZI26JzKumwmBXHL8qEXseZY=
X-Received: by 2002:ac2:52b3:0:b0:502:afea:dfdd with SMTP id
 r19-20020ac252b3000000b00502afeadfddmr1724111lfm.13.1697552196092; Tue, 17
 Oct 2023 07:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231017134951.26672-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231017134951.26672-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Oct 2023 17:15:59 +0300
Message-ID: <CAC_iWjL_qXo8Mhv6MdMKxDSzrDa2a79iU4G7kSLnQ=FW8+GdhA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efi_loader: expose the device-tree file name
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Tue, 17 Oct 2023 at 16:50, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Forward and backward compatibility of Linux kernel device-trees is
> sometimes missing. One solution approach is to load a kernel specific
> device-tree. This can either be done via a U-Boot scripts (like the one
> generated by Debian package flash-kernel or by a boot loader like GRUB.
> The boot loader approach currently requires to know the device-tree name
> before first boot which makes it unusable for generic images.
>
> Expose the device-tree file name as EFI variable FdtFile.
> This will allow bootloaders to load a kernel specific device-tree.
>
> The variable will not be exposed on ACPI based systems or if the
> environment variable fdtfile is not defined.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         Use a unique GUID to enable future U-Boot independent
>         standardization.
>         Do not try to add the variable on ACPI based systems.
> ---
>  include/efi_loader.h       |  5 +++++
>  lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index e24410505f..2faa1c191c 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -152,6 +152,11 @@ static inline efi_status_t efi_launch_capsules(void)
>         EFI_GUID(0x8108ac4e, 0x9f11, 0x4d59, \
>                  0x85, 0x0e, 0xe2, 0x1a, 0x52, 0x2c, 0x59, 0xb2)
>
> +/* Vendor GUID for the FdtFile variable */
> +#define VENDOR_FDTFILE_GUID \
> +       EFI_GUID(d45dde69, 0x3bd6, 0x40e0, \
> +                0x90, 0xd5, 0x6b, 0x60, 0x6a, 0xa5, 0x77, 0x30)
> +
>  /* Use internal device tree when starting UEFI application */
>  #define EFI_FDT_USE_INTERNAL NULL
>
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index e6de685e87..71bcde645b 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -17,6 +17,8 @@
>
>  efi_status_t efi_obj_list_initialized = OBJ_LIST_NOT_INITIALIZED;
>
> +efi_guid_t vendor_fdtfile_guid = VENDOR_FDTFILE_GUID;
> +
>  /*
>   * Allow unaligned memory access.
>   *
> @@ -26,6 +28,27 @@ void __weak allow_unaligned(void)
>  {
>  }
>
> +/**
> + * efi_init_fdtfile() - set EFI variable FdtFile
> + *
> + * Return:     status code
> + */
> +static efi_status_t efi_init_fdtfile(void)
> +{
> +       char *val;
> +
> +       val = env_get("fdtfile");
> +       if (!val)
> +               return EFI_SUCCESS;
> +
> +       return efi_set_variable_int(u"FdtFile",
> +                                   &vendor_fdtfile_guid,
> +                                   EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                                   EFI_VARIABLE_RUNTIME_ACCESS |
> +                                   EFI_VARIABLE_READ_ONLY,
> +                                   strlen(val) + 1, val, false);
> +}
> +
>  /**
>   * efi_init_platform_lang() - define supported languages
>   *
> @@ -250,6 +273,13 @@ efi_status_t efi_init_obj_list(void)
>         if (ret != EFI_SUCCESS)
>                 goto out;
>
> +       /* Define EFI variable FdtFile */
> +       if (!CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)) {
> +               ret = efi_init_fdtfile();
> +               if (ret != EFI_SUCCESS)
> +                       goto out;
> +       }
> +
>         /* Indicate supported features */
>         ret = efi_init_os_indications();
>         if (ret != EFI_SUCCESS)
> --
> 2.40.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
