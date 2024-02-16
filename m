Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FCFC48260
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 17:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C0EF86FEF;
	Fri, 16 Feb 2024 18:23:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e/Dq+3zx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E012287E50; Fri, 16 Feb 2024 18:23:24 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F37086FEF
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 18:23:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a3cfacf0eadso265489766b.2
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 09:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708104195; x=1708708995; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ADuSKG0OxM4RTw/c7f7cKaocbpCoxstL+N7uifqVV/8=;
 b=e/Dq+3zxRs3yTIl+XIpa+ihLibtOhOf0/gvP9i6qyY5KIRH22FoilnO0RqedrLICw/
 tGws5iATdJU4UpirsWkCkl5EMq38s5Rb/3Mc5taHS5rN2I92PoQreobLaaUBtOf3Y0rE
 nrVD/qEyzHBqKGrDGHo48PlHkkqQ8D5FUx+pc2kSYFWraUvVK7eC5bPku0brVUz10uei
 SbtaDQM7IpCbtFHnnMxhxdzAeyKZd24QXQy9rMvXIBivuEob81Q6Sverqyc62pA3fdtR
 vkYS1IrjEKeFXx8sLCiMl8RZNzJn5KFqA6MoVVTtKz5iP78lLpZrA5J3VaBpBnhvsuTl
 aShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708104195; x=1708708995;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ADuSKG0OxM4RTw/c7f7cKaocbpCoxstL+N7uifqVV/8=;
 b=i7IeYeG6KaqnWYbtALhiRbh0hdgybjQuoGAti1sl7ay2qbGjeYcLFjHkepXffbh9rH
 Mjb9Nbwy7tcl8uA7ynNusl7X/2jU0dQEqu44/EWjjiSZ7RKCkRfXkT6sHEq0/m/rp5xa
 YIeQvxv5xu66B3RHRByrIo0eLZMNBLZBHTigCkjuSlp3YTcRQps8DdxPWlqJqlkcViAO
 bbGXibYhcF5YLQdbJAcL9cErECPVfkx2hsxBAH2lhyLgOy3qjGqlSanPUKQ++Ii4VDty
 PALEXvz8AIoZeILh6taRCkRY6ayRIwtYvNMjsDCQvpn9TtJY/0kHSHRWca1IfYiw6Sk8
 D+Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkt84QwJ98dY1NTwweNSfo9nJjGjb3NxuQI3c7Gu7F7pbQ4iBIUIhW/gLdH/h6vwYiUgfREFs/L471n3g3uxNR0OSovA==
X-Gm-Message-State: AOJu0Ywsqge4/GMEDxBM9qBxNEA5QZ+QuL+1xObiCMR9oDZQBThhMyAp
 PVK7b35WwLl6GSVmHVPtIuSZtC9dtmyUrKchsTMOimJicqCGofEz+jUBhvi5gkU=
X-Google-Smtp-Source: AGHT+IHM+XCd6z2q9v3F/Cd7sNYIPgWfx5C2LLgIFT0c9PYtxqnEmSB/7UnJ0EeATlMZzVx27wnkCw==
X-Received: by 2002:a17:906:ccc7:b0:a3e:a98:6df4 with SMTP id
 ot7-20020a170906ccc700b00a3e0a986df4mr206382ejb.19.1708104195386; 
 Fri, 16 Feb 2024 09:23:15 -0800 (PST)
Received: from hera (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 u25-20020a170906c41900b00a3ce1bef210sm155996ejz.28.2024.02.16.09.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 09:23:15 -0800 (PST)
Date: Fri, 16 Feb 2024 19:23:12 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 19/39] board: dragonboard820c: use
 LINUX_KERNEL_IMAGE_HEADER
Message-ID: <Zc-aAFf6G1hDwQz9@hera>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-19-ed06355c634a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215-b4-qcom-common-target-v4-19-ed06355c634a@linaro.org>
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

On Thu, Feb 15, 2024 at 08:52:37PM +0000, Caleb Connolly wrote:
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
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index ad6671081910..f897c393464f 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -45,6 +45,7 @@ config TARGET_DRAGONBOARD410C
>
>  config TARGET_DRAGONBOARD820C
>  	bool "96Boards Dragonboard 820C"
> +	select LINUX_KERNEL_IMAGE_HEADER
>  	imply CLK_QCOM_APQ8096
>  	imply PINCTRL_QCOM_APQ8096
>  	imply BUTTON_QCOM_PMIC
> diff --git a/board/qualcomm/dragonboard820c/Makefile b/board/qualcomm/dragonboard820c/Makefile
> index 643311f5b3ba..2ae6d16364aa 100644
> --- a/board/qualcomm/dragonboard820c/Makefile
> +++ b/board/qualcomm/dragonboard820c/Makefile
> @@ -3,4 +3,3 @@
>  # (C) Copyright 2017 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@gmail.com>
>
>  obj-y	:= dragonboard820c.o
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
> -	b _start
> -	.word 0
> -	.quad   CONFIG_TEXT_BASE-PHYS_SDRAM_1 /* Image load offset, LE */
> -	.quad   0    /* Effective size of kernel image, little-endian */
> -	.quad   0    /* kernel flags, little-endian */
> -	.quad   0    /* reserved */
> -	.quad   0    /* reserved */
> -	.quad   0    /* reserved */
> -	.byte   0x41 /* Magic number, "ARM\x64" */
> -	.byte   0x52
> -	.byte   0x4d
> -	.byte   0x64
> -	.word   0    /* reserved (used for PE COFF offset) */
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
> -	. = 0x00000000;
> -
> -	. = ALIGN(8);
> -	.text :
> -	{
> -		*(.__image_copy_start)
> -		board/qualcomm/dragonboard820c/head.o (.text*)
> -		CPUDIR/start.o (.text*)
> -	}
> -
> -	/* This needs to come before *(.text*) */
> -	.efi_runtime : {
> -                __efi_runtime_start = .;
> -		*(.text.efi_runtime*)
> -		*(.rodata.efi_runtime*)
> -		*(.data.efi_runtime*)
> -                __efi_runtime_stop = .;
> -	}
> -
> -	.text_rest :
> -	{
> -		*(.text*)
> -	}
> -
> -	. = ALIGN(8);
> -	.rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
> -
> -	. = ALIGN(8);
> -	.data : {
> -		*(.data*)
> -	}
> -
> -	. = ALIGN(8);
> -
> -	. = .;
> -
> -	. = ALIGN(8);
> -	__u_boot_list : {
> -		KEEP(*(SORT(__u_boot_list*)));
> -	}
> -
> -	. = ALIGN(8);
> -
> -	.efi_runtime_rel : {
> -                __efi_runtime_rel_start = .;
> -		*(.rel*.efi_runtime)
> -		*(.rel*.efi_runtime.*)
> -                __efi_runtime_rel_stop = .;
> -	}
> -
> -	. = ALIGN(8);
> -
> -	.image_copy_end :
> -	{
> -		*(.__image_copy_end)
> -	}
> -
> -	. = ALIGN(8);
> -
> -	.rel_dyn_start :
> -	{
> -		*(.__rel_dyn_start)
> -	}
> -
> -	.rela.dyn : {
> -		*(.rela*)
> -	}
> -
> -	.rel_dyn_end :
> -	{
> -		*(.__rel_dyn_end)
> -	}
> -
> -	_end = .;
> -
> -	. = ALIGN(8);
> -
> -	.bss_start : {
> -		KEEP(*(.__bss_start));
> -	}
> -
> -	.bss : {
> -		*(.bss*)
> -		 . = ALIGN(8);
> -	}
> -
> -	.bss_end : {
> -		KEEP(*(.__bss_end));
> -	}
> -
> -	/DISCARD/ : { *(.dynsym) }
> -	/DISCARD/ : { *(.dynstr*) }
> -	/DISCARD/ : { *(.dynamic*) }
> -	/DISCARD/ : { *(.plt*) }
> -	/DISCARD/ : { *(.interp*) }
> -	/DISCARD/ : { *(.gnu*) }
> -}
>
> --
> 2.43.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

