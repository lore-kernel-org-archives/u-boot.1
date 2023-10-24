Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0244C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 19:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28BE487134;
	Tue, 24 Oct 2023 21:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CktxuAE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20CE4879D2; Tue, 24 Oct 2023 21:33:53 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22E0287134
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 21:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c50906f941so73903621fa.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 12:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698176029; x=1698780829; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vH+54Fjq2LJmS6P8/VoYe1r5wYyie7I75uTqrVcqgBs=;
 b=CktxuAE/3cSuOccpWA2DRhIiFCjngdsUh/0XSAxgb2gvv/QDlk5SIXraCVjWP2xUKB
 nYoBW8c6F8V8ElMFsiUEYxa18WThL+Y7Xwj64W30WBXQ+8y13HnTW/OrgzMOGW6E/70C
 nOnO7KmY840FuT5zUIR8g00ZCkP379xvDPMcHg8KJamhqtGniE9CKED94sNUxP3mHBDu
 Frhjstwlf3xOU8DhqXqIAbnJeGjT1YjaxCWPWIH1PYxnxnizX6M9vedIP1Tl3TR3JdfJ
 NEp24anws9c1DkbxQgeUqsNcPDa6KeVjZbjrYi0rCOIbCc4bKxvstOQSGPrM+pC+TyBq
 zHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698176029; x=1698780829;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vH+54Fjq2LJmS6P8/VoYe1r5wYyie7I75uTqrVcqgBs=;
 b=HWzBVUPNpuEvsr5OIpSppzhnBxgqwjcXoj85QJGf9jq85JM5ZC/5+mW1MxpazCOAcQ
 q4GrxzdtNCWx3C5xfMBSs6UBzS6wDYMshQ5zMTO83FoQuiqDN9JHe5+fnMY9uFphidX1
 8QTOL9Owd5IYBKj/tAcQIgQVV8Vh1KJ91nKDYBWMMPWje1Q2syedWOfb1JTla8PmLJu8
 DzHCJBgdqDNtUlV50mYb2QIc1FWBDF0I9H95Nyuikc+eCZoKmGWbZhly9y+HgqH+HtXP
 vHgg+0YKZE1k7LUmdLO+7MtIZCz+yDXhXvjBMRlo+QstQk/DkhsSpSlCeF/Xz3enKlV8
 XJHg==
X-Gm-Message-State: AOJu0YyxqLrJ76aXYy/mXf1IPgwZd48rxAPSn0AVWmMMfpkFIElqPxEQ
 QSAFO8UqG9vBX4kwJSdzuwdpH9QK6WJgQhzoGcigtw==
X-Google-Smtp-Source: AGHT+IEumIkZLjQlD3CgmSRCYP8pkIL2VzPdjffFe6L7z5y+au+y7PP6MpQqHpHJOL6Wre97Gkk7Mly96ZUb1QELSM0=
X-Received: by 2002:a2e:7004:0:b0:2c2:9872:dfc1 with SMTP id
 l4-20020a2e7004000000b002c29872dfc1mr9604802ljc.42.1698176029385; Tue, 24 Oct
 2023 12:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231024062032.8543-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231024062032.8543-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 24 Oct 2023 22:33:13 +0300
Message-ID: <CAC_iWjKeKRc4VVPzY98+OSCs5h5KZXkVkO9+EjL4_BFpqVxU9A@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] efi_loader: expose the device-tree file name
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Tue, 24 Oct 2023 at 09:20, Heinrich Schuchardt
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
> v4:
>         Generalize the description of the content of $fdtfile.
> v3:
>         Add documentation
> v2:
>         Use a unique GUID to enable future U-Boot independent
>         standardization.
>         Do not try to add the variable on ACPI based systems.
> ---
>  doc/develop/uefi/uefi.rst  | 14 ++++++++++++++
>  include/efi_loader.h       |  5 +++++
>  lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+)
>
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index fb16ac743a..702c490831 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -916,6 +916,20 @@ So our final format of the FilePathList[] is::
>
>      Loaded image - end node (0xff) - VenMedia - initrd_1 - [end node (0x01) - initrd_n ...] - end node (0xff)
>
> +EFI variable FdtFile
> +~~~~~~~~~~~~~~~~~~~~
> +
> +Ideally U-Boot would always expose a device-tree that can be used for booting
> +any operating systems. Unfortunately operating systems like Linux sometimes
> +break forward and backward compatibility. In this case there is a need to load
> +an operating system version specific device-tree.
> +
> +U-Boot has an environment variable fdtfile identifying the device-tree file to
> +load. The content of this variable is exposed as EFI variable Fdtfile, vendor
> +GUID d45dde69-3bd6-40e0-90d5-6b606aa57730. It contains the device-tree path
> +name as a NUL terminated ASCII string. On many architectures the file name is
> +preceded by a vendor directory ('vendor-directory/board-name.dtb').
> +
>  Links
>  -----
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index e24410505f..146e7f1bce 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -152,6 +152,11 @@ static inline efi_status_t efi_launch_capsules(void)
>         EFI_GUID(0x8108ac4e, 0x9f11, 0x4d59, \
>                  0x85, 0x0e, 0xe2, 0x1a, 0x52, 0x2c, 0x59, 0xb2)
>
> +/* Vendor GUID for the FdtFile variable */
> +#define VENDOR_FDTFILE_GUID \
> +       EFI_GUID(0xd45dde69, 0x3bd6, 0x40e0, \
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
