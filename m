Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD79C54787
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 13:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A097F87DC0;
	Tue, 20 Feb 2024 14:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c5bX018I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 302AC87C35; Tue, 20 Feb 2024 14:29:20 +0100 (CET)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E18D87DC0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:29:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7ce603b9051so2174785241.2
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708435739; x=1709040539; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TjU+PZf9DXVUmSKwrHtd2X/g0gMBWK2Hc+XqvgrDn3w=;
 b=c5bX018I37jy1XutUtBjli7LvisPimxn4vgtQvWrJzZzQ8V3CH29R1/boWp9Ntmybv
 zQ0IEG+cTKYPV92mu3suKaV0YZo5rYyXRXxLn05bJmPDEraXM/CaPwo4cttjjjrtvg0n
 72Reyp0YjABaH0KuV47XQSbJU5C/TE7B1nefL4FdqH0fOsjNoQbl02AZys5SZ08bMbym
 Jvy+sec0uRiBM2/rbiLGUYA6d7JTuST1LJ3EW50ZphzjIx/ASib1YNIUsuOZ7vXa6T6b
 fsq2onDwoGC3z6oDMR8lhssCBSLYKk7K+2/9b7JB7i3NmknbhuI91QY4laXXdISf9E1Q
 uc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708435739; x=1709040539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TjU+PZf9DXVUmSKwrHtd2X/g0gMBWK2Hc+XqvgrDn3w=;
 b=DqnjG7pDMfaRkCEv/BvfjoFhsJjQspbI8PHNIrHy7I3q78bDKDXEo4i8uU4rrGc5gk
 DgioBmUE66RRuKkAvcvrGSPjcLmtsIJodEqVPszO0xaYkAeaWmWfISApEOAARnWNjAJk
 dZSWxsYLpN8RtF+H7LaVPnzTIiyyXHc5929Hrun2oUslDvzH0XmTqhHUyuOGKTYqAGjU
 vX6DHkqfNbFXs1viIfE3sOiagDfASyg+OOcNiT40IX7X+zuQI4hLWvTECqFLvn7J3L1a
 s0D5rjDdt/IRCvW5Ip7pFe8OoDdAmJy8ZksYvx8gvXIQKcV+YUjAlVypOSuq+PBRYb8a
 Ob4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHI7ur8AWOYJNbTcDQDi89lXW8WkINgkx+yvEps+5zGTuGSfVWjh6j1zsNWym5ORL750jv2H1/bgSZrbsFx3rFYpyyVw==
X-Gm-Message-State: AOJu0YxGeu1eOZQdL33bBLL/YpjhjG5xJ16bz0ie9gEr5CfgwdytP1yR
 qhvQhUddQpqOgRDhUUW0tR7xAUDY8iXMhbrOW7LF7UZDeUe7hzxE5gDT/mdQgjlrkc3Hj3I1jlj
 AlzGubDwuioewfHIvliFfdHuPA0MtlKjI1IUESg==
X-Google-Smtp-Source: AGHT+IGFN6uNaGSDT2WLOySI+MXOJtA/3TF6QR3J568Uwh+9t8RAjsBD4LLzKNn+rdwwe/p9wtTgPp15kGUBhS9yWwU=
X-Received: by 2002:a05:6102:3bf8:b0:470:52f5:9ea3 with SMTP id
 be24-20020a0561023bf800b0047052f59ea3mr4608101vsb.7.1708435739312; Tue, 20
 Feb 2024 05:28:59 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-19-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-19-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 18:58:48 +0530
Message-ID: <CAFA6WYPmYsHhn__LMHH17gChHBs3-hBwh88+g94gt760JDboag@mail.gmail.com>
Subject: Re: [PATCH v4 19/39] board: dragonboard820c: use
 LINUX_KERNEL_IMAGE_HEADER
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Fri, 16 Feb 2024 at 02:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> db820c predated support for prepending the kernel image header
> automatically, drop it's custom linker script and head.S in favour of
> this generic support.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/Kconfig          |   1 +
>  board/qualcomm/dragonboard820c/Makefile   |   1 -
>  board/qualcomm/dragonboard820c/head.S     |  33 ---------
>  board/qualcomm/dragonboard820c/u-boot.lds | 111 ------------------------------
>  4 files changed, 1 insertion(+), 145 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index ad6671081910..f897c393464f 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -45,6 +45,7 @@ config TARGET_DRAGONBOARD410C
>
>  config TARGET_DRAGONBOARD820C
>         bool "96Boards Dragonboard 820C"
> +       select LINUX_KERNEL_IMAGE_HEADER
>         imply CLK_QCOM_APQ8096
>         imply PINCTRL_QCOM_APQ8096
>         imply BUTTON_QCOM_PMIC
> diff --git a/board/qualcomm/dragonboard820c/Makefile b/board/qualcomm/dragonboard820c/Makefile
> index 643311f5b3ba..2ae6d16364aa 100644
> --- a/board/qualcomm/dragonboard820c/Makefile
> +++ b/board/qualcomm/dragonboard820c/Makefile
> @@ -3,4 +3,3 @@
>  # (C) Copyright 2017 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@gmail.com>
>
>  obj-y  := dragonboard820c.o
> -extra-y += head.o
> diff --git a/board/qualcomm/dragonboard820c/head.S b/board/qualcomm/dragonboard820c/head.S
> deleted file mode 100644
> index b052a858fd32..000000000000
> --- a/board/qualcomm/dragonboard820c/head.S
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * ARM64 header for proper chain-loading with Little Kernel.
> - *
> - * Little Kernel shipped with Dragonboard820C boots standard Linux images for
> - * ARM64. This file adds header that is required to boot U-Boot properly.
> - *
> - * For details see:
> - * https://www.kernel.org/doc/Documentation/arm64/booting.txt
> - *
> - * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
> - */
> -
> -#include <config.h>
> -
> -/*
> - *   per document in linux/Doc/arm64/booting.text
> - */
> -.global _arm64_header
> -_arm64_header:
> -       b _start
> -       .word 0
> -       .quad   CONFIG_TEXT_BASE-PHYS_SDRAM_1 /* Image load offset, LE */
> -       .quad   0    /* Effective size of kernel image, little-endian */
> -       .quad   0    /* kernel flags, little-endian */
> -       .quad   0    /* reserved */
> -       .quad   0    /* reserved */
> -       .quad   0    /* reserved */
> -       .byte   0x41 /* Magic number, "ARM\x64" */
> -       .byte   0x52
> -       .byte   0x4d
> -       .byte   0x64
> -       .word   0    /* reserved (used for PE COFF offset) */
> diff --git a/board/qualcomm/dragonboard820c/u-boot.lds b/board/qualcomm/dragonboard820c/u-boot.lds
> deleted file mode 100644
> index 5251b59fbe76..000000000000
> --- a/board/qualcomm/dragonboard820c/u-boot.lds
> +++ /dev/null
> @@ -1,111 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Override linker script for fastboot-readable images
> - *
> - * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
> - *
> - * Based on arch/arm/cpu/armv8/u-boot.lds (Just add header)
> - */
> -
> -OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
> -OUTPUT_ARCH(aarch64)
> -ENTRY(_arm64_header)
> -SECTIONS
> -{
> -       . = 0x00000000;
> -
> -       . = ALIGN(8);
> -       .text :
> -       {
> -               *(.__image_copy_start)
> -               board/qualcomm/dragonboard820c/head.o (.text*)
> -               CPUDIR/start.o (.text*)
> -       }
> -
> -       /* This needs to come before *(.text*) */
> -       .efi_runtime : {
> -                __efi_runtime_start = .;
> -               *(.text.efi_runtime*)
> -               *(.rodata.efi_runtime*)
> -               *(.data.efi_runtime*)
> -                __efi_runtime_stop = .;
> -       }
> -
> -       .text_rest :
> -       {
> -               *(.text*)
> -       }
> -
> -       . = ALIGN(8);
> -       .rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
> -
> -       . = ALIGN(8);
> -       .data : {
> -               *(.data*)
> -       }
> -
> -       . = ALIGN(8);
> -
> -       . = .;
> -
> -       . = ALIGN(8);
> -       __u_boot_list : {
> -               KEEP(*(SORT(__u_boot_list*)));
> -       }
> -
> -       . = ALIGN(8);
> -
> -       .efi_runtime_rel : {
> -                __efi_runtime_rel_start = .;
> -               *(.rel*.efi_runtime)
> -               *(.rel*.efi_runtime.*)
> -                __efi_runtime_rel_stop = .;
> -       }
> -
> -       . = ALIGN(8);
> -
> -       .image_copy_end :
> -       {
> -               *(.__image_copy_end)
> -       }
> -
> -       . = ALIGN(8);
> -
> -       .rel_dyn_start :
> -       {
> -               *(.__rel_dyn_start)
> -       }
> -
> -       .rela.dyn : {
> -               *(.rela*)
> -       }
> -
> -       .rel_dyn_end :
> -       {
> -               *(.__rel_dyn_end)
> -       }
> -
> -       _end = .;
> -
> -       . = ALIGN(8);
> -
> -       .bss_start : {
> -               KEEP(*(.__bss_start));
> -       }
> -
> -       .bss : {
> -               *(.bss*)
> -                . = ALIGN(8);
> -       }
> -
> -       .bss_end : {
> -               KEEP(*(.__bss_end));
> -       }
> -
> -       /DISCARD/ : { *(.dynsym) }
> -       /DISCARD/ : { *(.dynstr*) }
> -       /DISCARD/ : { *(.dynamic*) }
> -       /DISCARD/ : { *(.plt*) }
> -       /DISCARD/ : { *(.interp*) }
> -       /DISCARD/ : { *(.gnu*) }
> -}
>
> --
> 2.43.1
>
