Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D3EC3DA6E
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 07:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB5268774E;
	Sat, 23 Dec 2023 08:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="Omtr1Lmq";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="wj0gl+UI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 452CC87756; Sat, 23 Dec 2023 08:09:50 +0100 (CET)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3776E87650
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 08:09:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id 1c676344;
 Sat, 23 Dec 2023 07:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=N4
 jkFHYnlDPzhTkkMBXAJi8kCwg=; b=Omtr1Lmq0jlAuF2TQxMIQNrrEYpvtpwdZl
 1ZtDuOZ4vlTC3oVCoE5ZYFVnepUkNMsIs//BCFaZLh3AjC605dyo19nOnuLhB+2H
 dkJZSLYQ2M2rZkzz1xNAmH5hpV2nGxVXUVhJ44SVfZaLKdZcUAiMKazUvDLioO6D
 FSihEEWoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 I2Ue4r+CMBJp36Ht6wbdLaAeQN4coAgS+4Zgrj9o3+PrJXNqou0jMBXbCY7L6SKW
 H3UZXvwXiUbzbS0tgTl2/znA43//wzWUD4TieWMCPmuYE+MF2nnIJ5Mc0RRQqTlF
 IUZPEcBM0PhN1Et8ofSObZs8sANR0ABa0G4MPOBSSMk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1703315365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EpzaNmQHFgNqb1ifwXo5F4CE4MidJL+S3Lxo2a6zODc=;
 b=wj0gl+UIrIEAqApwTJLZCJuJKlBCgfCgtBVncpBqIj1lEQTp3CJzLkl0f3/ugz6SB9DtHe
 0Q/HQkxuWoy3HoAWRLPq/KuDX1CDvXytE/esJ/bD2rvu0a4Ihkg2JlOJU/K3ZJqKdeAzlc
 YyJ6i2K0qWwfrXewq9mR59uxJ4q4gAo=
Received: from [192.168.0.2] (host-79-30-236-127.retail.telecomitalia.it
 [79.30.236.127])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id e68b487f
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sat, 23 Dec 2023 07:09:25 +0000 (UTC)
Message-ID: <0d6bf326-b2d4-29f0-2e4e-99d53054a1e1@kernel-space.org>
Date: Sat, 23 Dec 2023 08:09:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 04/14] treewide: Make arch-specific bootm code depend on
 BOOTM
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20231204003144.899097-1-sjg@chromium.org>
 <20231204003144.899097-4-sjg@chromium.org>
From: Angelo Dureghello <angelo@kernel-space.org>
Content-Language: en-US, it
In-Reply-To: <20231204003144.899097-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Simon,

Acked-by: Angelo Dureghello <angelo@kernel-space.org>

On 04/12/23 1:31 AM, Simon Glass wrote:
> Allow these functions to be compiled in when CONFIG_BOOTM is enabled,
> even if CONFIG_CMD_BOOTM is not.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   arch/arc/lib/Makefile        | 2 +-
>   arch/arm/lib/Makefile        | 2 +-
>   arch/m68k/lib/Makefile       | 2 +-
>   arch/microblaze/lib/Makefile | 2 +-
>   arch/mips/lib/Makefile       | 2 +-
>   arch/nios2/lib/Makefile      | 2 +-
>   arch/powerpc/lib/Makefile    | 2 +-
>   arch/riscv/lib/Makefile      | 2 +-
>   arch/sandbox/lib/Makefile    | 2 +-
>   arch/sh/lib/Makefile         | 2 +-
>   arch/x86/lib/Makefile        | 2 +-
>   arch/xtensa/lib/Makefile     | 2 +-
>   12 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arc/lib/Makefile b/arch/arc/lib/Makefile
> index 0eb44bcf33d0..bde1c3d8af3a 100644
> --- a/arch/arc/lib/Makefile
> +++ b/arch/arc/lib/Makefile
> @@ -12,6 +12,6 @@ obj-y += reset.o
>   obj-y += ints_low.o
>   obj-y += init_helpers.o
>   
> -obj-$(CONFIG_CMD_BOOTM) += bootm.o
> +obj-$(CONFIG_BOOTM) += bootm.o
>   
>   lib-$(CONFIG_USE_PRIVATE_LIBGCC) += _millicodethunk.o libgcc2.o
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index b1bcd3746625..b20a467f684c 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -31,7 +31,7 @@ endif
>   obj-$(CONFIG_CPU_V7M) += cmd_boot.o
>   obj-$(CONFIG_OF_LIBFDT) += bootm-fdt.o
>   obj-$(CONFIG_CMD_BOOTI) += bootm.o image.o
> -obj-$(CONFIG_CMD_BOOTM) += bootm.o
> +obj-$(CONFIG_BOOTM) += bootm.o
>   obj-$(CONFIG_CMD_BOOTZ) += bootm.o zimage.o
>   else
>   obj-$(CONFIG_$(SPL_TPL_)FRAMEWORK) += spl.o
> diff --git a/arch/m68k/lib/Makefile b/arch/m68k/lib/Makefile
> index 6e1fd938f526..5ccd9545cb5c 100644
> --- a/arch/m68k/lib/Makefile
> +++ b/arch/m68k/lib/Makefile
> @@ -8,7 +8,7 @@
>   lib-$(CONFIG_USE_PRIVATE_LIBGCC) += lshrdi3.o muldi3.o ashldi3.o ashrdi3.o
>   
>   obj-y	+= bdinfo.o
> -obj-$(CONFIG_CMD_BOOTM) += bootm.o
> +obj-$(CONFIG_BOOTM) += bootm.o
>   obj-y	+= cache.o
>   obj-y	+= interrupts.o
>   obj-y	+= time.o
> diff --git a/arch/microblaze/lib/Makefile b/arch/microblaze/lib/Makefile
> index dfd8135f4f25..2f234825f804 100644
> --- a/arch/microblaze/lib/Makefile
> +++ b/arch/microblaze/lib/Makefile
> @@ -3,6 +3,6 @@
>   # (C) Copyright 2003-2006
>   # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>   
> -obj-$(CONFIG_CMD_BOOTM) += bootm.o
> +obj-$(CONFIG_BOOTM) += bootm.o
>   obj-$(CONFIG_CMD_BDI) += bdinfo.o
>   obj-y	+= muldi3.o
> diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
> index 9ee1fcb5c702..f8e162c53b58 100644
> --- a/arch/mips/lib/Makefile
> +++ b/arch/mips/lib/Makefile
> @@ -10,7 +10,7 @@ obj-y	+= reloc.o
>   obj-y	+= stack.o
>   obj-y	+= traps.o
>   
> -obj-$(CONFIG_CMD_BOOTM) += bootm.o
> +obj-$(CONFIG_BOOTM) += bootm.o
>   obj-$(CONFIG_CMD_GO) += boot.o
>   obj-$(CONFIG_SPL_BUILD) += spl.o
>   
> diff --git a/arch/nios2/lib/Makefile b/arch/nios2/lib/Makefile
> index a9f3c7100e72..68a5ca007d55 100644
> --- a/arch/nios2/lib/Makefile
> +++ b/arch/nios2/lib/Makefile
> @@ -4,5 +4,5 @@
>   # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>   
>   obj-y	+= cache.o
> -obj-$(CONFIG_CMD_BOOTM) += bootm.o
> +obj-$(CONFIG_BOOTM) += bootm.o
>   obj-y	+= libgcc.o
> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index bb819dcbb6cc..dcce9834927d 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -34,7 +34,7 @@ obj-y	+= ticks.o
>   endif
>   obj-y	+= reloc.o
>   
> -obj-$(CONFIG_CMD_BOOTM) += bootm.o
> +obj-$(CONFIG_BOOTM) += bootm.o
>   obj-y	+= cache.o
>   obj-y	+= extable.o
>   obj-y	+= interrupts.o
> diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
> index 9a05b662fd63..0b2c88db6bad 100644
> --- a/arch/riscv/lib/Makefile
> +++ b/arch/riscv/lib/Makefile
> @@ -6,7 +6,7 @@
>   # Copyright (C) 2017 Andes Technology Corporation
>   # Rick Chen, Andes Technology Corporation <rick@andestech.com>
>   
> -obj-$(CONFIG_CMD_BOOTM) += bootm.o
> +obj-$(CONFIG_BOOTM) += bootm.o
>   obj-$(CONFIG_CMD_BOOTI) += bootm.o image.o
>   obj-$(CONFIG_CMD_GO) += boot.o
>   obj-y	+= cache.o
> diff --git a/arch/sandbox/lib/Makefile b/arch/sandbox/lib/Makefile
> index a2bc5a7ee60f..c4924b23c832 100644
> --- a/arch/sandbox/lib/Makefile
> +++ b/arch/sandbox/lib/Makefile
> @@ -7,5 +7,5 @@
>   
>   obj-y	+= fdt_fixup.o interrupts.o sections.o
>   obj-$(CONFIG_PCI)	+= pci_io.o
> -obj-$(CONFIG_CMD_BOOTM) += bootm.o
> +obj-$(CONFIG_BOOTM) += bootm.o
>   obj-$(CONFIG_CMD_BOOTZ) += bootm.o
> diff --git a/arch/sh/lib/Makefile b/arch/sh/lib/Makefile
> index e7520a328d54..8c3c30293a3c 100644
> --- a/arch/sh/lib/Makefile
> +++ b/arch/sh/lib/Makefile
> @@ -6,7 +6,7 @@
>   extra-y	+= start.o
>   
>   obj-y	+= board.o
> -obj-$(CONFIG_CMD_BOOTM) += bootm.o
> +obj-$(CONFIG_BOOTM) += bootm.o
>   obj-y	+= time.o
>   obj-$(CONFIG_CMD_SH_ZIMAGEBOOT) += zimageboot.o
>   
> diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> index 8fc35e1b51ea..94aa335ede4c 100644
> --- a/arch/x86/lib/Makefile
> +++ b/arch/x86/lib/Makefile
> @@ -16,7 +16,7 @@ obj-$(CONFIG_X86_32BIT_INIT) += string.o
>   endif
>   
>   ifndef CONFIG_SPL_BUILD
> -obj-$(CONFIG_CMD_BOOTM) += bootm.o
> +obj-$(CONFIG_BOOTM) += bootm.o
>   endif
>   obj-y	+= cmd_boot.o
>   obj-$(CONFIG_$(SPL_)COREBOOT_SYSINFO)	+= coreboot/
> diff --git a/arch/xtensa/lib/Makefile b/arch/xtensa/lib/Makefile
> index ad4fe32cb699..bb9157f30f0f 100644
> --- a/arch/xtensa/lib/Makefile
> +++ b/arch/xtensa/lib/Makefile
> @@ -3,6 +3,6 @@
>   # (C) Copyright 2007 - 2013 Tensilica Inc.
>   # (C) Copyright 2014 - 2016 Cadence Design Systems Inc.
>   
> -obj-$(CONFIG_CMD_BOOTM) += bootm.o
> +obj-$(CONFIG_BOOTM) += bootm.o
>   
>   obj-y	+= cache.o misc.o relocate.o time.o
