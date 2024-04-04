Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE780CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 14:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11F4288264;
	Thu,  4 Apr 2024 16:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hKPGOvY8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B75C388264; Thu,  4 Apr 2024 16:29:16 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA0EE8826D
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 16:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d6c220a377so12363901fa.2
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 07:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712240954; x=1712845754; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H38P/q/l+wpWedEof62X1+fPxGV4ywwXHMIbk05T6O4=;
 b=hKPGOvY86MIh+MXuPh5tmYKDCDGh6haK8eLEKkvACkVWuCNRmSPGTVCjS/Zcf/bFbi
 cR2HefgK2EQQy2B/YiHvboUsmVmTkXorTpb3jjZ8hgzE8hGTcLalCxRlAX8Gijw/WjDB
 lPg5h9//8pIatNOj9d1qj9cYEwFfZuDf7OmAbphLd86UMMxlqXyUti9m7e1dQgHDyMF2
 Cy4OA2ynQIHYLDxQCv9Lg4P3YcsBC4FTCvM9MsuExlPrKJYlKDFcpMRbI7R9UIrV+1PQ
 bSdnpA9ZawaZZFfCFYWl6C6C6NTzl0yn4z99QpfeOH3f5LgAtsC+dPhcp/PpeWkeNVw2
 Jvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712240954; x=1712845754;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H38P/q/l+wpWedEof62X1+fPxGV4ywwXHMIbk05T6O4=;
 b=AMfNM8I9kPnJyMaj+eaHjQMTeFH4NX1PrtHCXrKvRcQlHS6pDwbJaIC04HcUT5sMaS
 2RhmBo9fvhix4o9JxJnMP7bOuzOpT0PtNNgeXGVBq5YSeanv50JkUIaIzEtJ0gaSKIS7
 2G5vg1Zo2jK0Un7eBUdnBsXN9mYcMA1aTcki/rj9ARl7/vzMVSmMPJFCZDkBXuc5WaVr
 5xVzNcR+WPrqfh3OuYNS8/zs7hwpmcDJ+YnZoeslt0uc0dy+Hzc23iEpxDFJdQEVbr5w
 qJ3Yw7t4yrBhsJTTz/Sxz2fYWgPdC0Y/7vNAEnOG4IzZ4viXUvfxlb+lOp6VVxTOq7ir
 KSsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUad+JTqfGy82bOpqVnQokbjhajv1kt+zrHUXT56iOUT2oylehjwKvHU97DS0VRnP3FqR5UninK4jzyFZqYa1cvRvyr4g==
X-Gm-Message-State: AOJu0YylGVvp4ikTAfieqghx2t7Q1ovulfiCfTKWq6fPruFsO5JBY0v/
 VJUu+ULuvrncpABU+VX9AN62qCnAcD4IN9CiE8EE4GBE8rbhx1a2OcaaVE4hn9G1D7FzsFNVrgr
 qNLrxqTAY0BJ9Jysd26BO+EKjZH/VN4lVAjBhcw==
X-Google-Smtp-Source: AGHT+IG86h3lmBPdkaDOXdyEdmCkODmjPL+tX6UE+qmsuDmrQMz4q95JRNWDlNiMFm3WhgN9r69YxhGAlCm59zMjI+Y=
X-Received: by 2002:a2e:890f:0:b0:2d8:5af8:460e with SMTP id
 d15-20020a2e890f000000b002d85af8460emr1375912lji.18.1712240953943; Thu, 04
 Apr 2024 07:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240404114742.81187-1-heinrich.schuchardt@canonical.com>
 <20240404114742.81187-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240404114742.81187-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Apr 2024 17:28:36 +0300
Message-ID: <CAC_iWj+1+vF_yNE8e6056khJp=-7Q4vYXiMOsp=Qvy0hpr_iXQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] boot: enable booting via EFI boot manager by
 default
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, 
 "Leon M . Busch-George" <leon@georgemail.eu>,
 Eddie James <eajames@linux.ibm.com>, Bin Meng <bmeng@tinylab.org>, 
 Shantur Rathore <i@shantur.com>, Mark Kettenis <kettenis@openbsd.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Sean Edmond <seanedmond@microsoft.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 E Shattow <lucent@gmail.com>, u-boot@lists.denx.de
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

On Thu, 4 Apr 2024 at 14:49, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If UEFI is enabled in U-Boot, we want it to conform to the UEFI
> specification. This requires enabling the boot manager boot method.
>
> Reported-by: E Shattow <lucent@gmail.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         fix building with EFI_BOOT_MGR but w/o BOOTSTD
> ---
>  boot/Kconfig           | 10 ++++++++++
>  boot/Makefile          |  2 +-
>  lib/efi_loader/Kconfig |  1 -
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 3d7aabd27d6..d9a6c270059 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -558,6 +558,16 @@ config BOOTMETH_EFILOADER
>
>           This provides a way to try out standard boot on an existing boot flow.
>
> +config BOOTMETH_EFI_BOOTMGR
> +       bool "Bootdev support for EFI boot manager"
> +       depends on EFI_BOOTMGR
> +       select BOOTMETH_GLOBAL
> +       default y
> +       help
> +         Enable booting via the UEFI boot manager. Based on the EFI variables
> +         the EFI binary to be launched is determined. To set the EFI variables
> +         use the eficonfig command.
> +
>  config BOOTMETH_VBE
>         bool "Bootdev support for Verified Boot for Embedded"
>         depends on FIT
> diff --git a/boot/Makefile b/boot/Makefile
> index f0a279cde16..84ccfeaecec 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -34,8 +34,8 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
>  obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
>  obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SCRIPT) += bootmeth_script.o
>  obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
> +obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EFI_BOOTMGR) += bootmeth_efi_mgr.o
>  ifdef CONFIG_$(SPL_TPL_)BOOTSTD_FULL
> -obj-$(CONFIG_EFI_BOOTMGR) += bootmeth_efi_mgr.o
>  obj-$(CONFIG_$(SPL_TPL_)EXPO) += bootflow_menu.o
>  obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootflow_menu.o
>  endif
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index a7c3e05c13a..e13a6f9f4c3 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -44,7 +44,6 @@ config EFI_BINARY_EXEC
>  config EFI_BOOTMGR
>         bool "UEFI Boot Manager"
>         default y
> -       select BOOTMETH_GLOBAL if BOOTSTD
>         help
>           Select this option if you want to select the UEFI binary to be booted
>           via UEFI variables Boot####, BootOrder, and BootNext. You should also
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
