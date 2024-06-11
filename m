Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE547C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 13:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47DE6886A3;
	Tue, 11 Jun 2024 15:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RGNnhE7a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD69C886D7; Tue, 11 Jun 2024 15:52:54 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6836488685
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-6e40ee57f45so935155a12.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 06:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718113971; x=1718718771; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zMP3YA+q9kjuDbcMqC+cuBYTcN0vxIUDh/NobpVhrGI=;
 b=RGNnhE7aykyRUBelwgpOPafkCTjlC9NhQvil7ZDgqK3AMJJv+n0Z4rQFjePZKZogdD
 tFkAPt5sQgFMFoWVHb4S40CG0mVwvqyZc5nwfZhz45omarErHtn5moIH49RU2Wvdd0DB
 hgl66RmyQ/45bGx5PpOd4bDJCYaXFW/LfIh39YuY4vqcQ03mXEEpnMWFahKlu+gp2p9j
 LcL1wt3E6M8BnzuTy/Se+TflDuBiZt3gsMNE+7FShsBKQgAPrpVJ5osnBcSNUqldP6wu
 cl2FHrtMXCg3zW/+yaSKdKl8HoKcDfso4KQCYT0cOeHwJkTaEKIHqy2fiRtV89TAUYeQ
 mY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718113971; x=1718718771;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zMP3YA+q9kjuDbcMqC+cuBYTcN0vxIUDh/NobpVhrGI=;
 b=dDrdlGc/cNY02ozn/86yGUn5o1R67p58hRpiu5nXeJcgCYpMCmwcadn5EkvXhnfQrp
 VRBdVt05dVwzLV0iSxhHD/Ip9Yi3qcETQRdjEU4zqMuKoldoQ9tULvj5h/CX2Xle3gE0
 iIdLudkSrN51/DsHs9s2W9qT3WxJ0pHYkkIdkS7wJCm6gO8GQ1AosVY41rY/QdSOBcS0
 mcO5Hj5Skvty4cOVhwCAfuppNmnplqyyp53lqaxpGoIcfDkaKU4HKN0A+Xpkgo00y/81
 6H88xCroy9eq3n7mGqPVamXOUb0CAzdLzb8bAr0PnraWzeCcwivo8/aBvQbG+HrgOMBu
 qYTw==
X-Gm-Message-State: AOJu0Yy+BbbJ/cty/CpcfdaBupVpgnNz1hb/Fz38LbNxJV36AUJLZvUU
 por0INvF554ik3nGWs1kzC119U/nDByS6uoQmS2nZePhMsj9+xg4u6tAB2T9y17kprCuD4+g5MJ
 AmOoQ9Yu9/bkDBgS0xydDMIj0cldQUKj8foAHxQ==
X-Google-Smtp-Source: AGHT+IErTWXMQkd9dX+NEt98089vRZNWsPbUnFeK2pvHJMzf9ngw4F4HxjcYCCzGBqMcCaUrB8a6AMOcZG+y/gEZKr4=
X-Received: by 2002:a17:903:2351:b0:1f7:3948:9541 with SMTP id
 d9443c01a7336-1f7394897fdmr13150155ad.65.1718113970887; Tue, 11 Jun 2024
 06:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
 <20240517-mips-efi-v1-6-79096e3ca3b3@flygoat.com>
In-Reply-To: <20240517-mips-efi-v1-6-79096e3ca3b3@flygoat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Jun 2024 16:52:14 +0300
Message-ID: <CAC_iWjJV7T3GG-7_m1EfrU4wAYksNdjm59UB-pWk3HsQ=FFr4w@mail.gmail.com>
Subject: Re: [PATCH 6/7] MIPS: Define MIPS EFI related bits everywhere
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Fri, 17 May 2024 at 19:33, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> Various file names, instruction defines, magic numbers
> related to MIPS's EFI implementation.
>
> PE magic numbers are from winnt.h, DHCP numbers are
> from IANA page, boot file names are from other
> implementations.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  include/asm-generic/pe.h                          |  5 +++++
>  include/config_distro_bootcmd.h                   |  6 ++++++
>  include/efi_default_filename.h                    |  8 ++++++++
>  include/elf.h                                     |  8 ++++++++
>  lib/efi_loader/efi_image_loader.c                 | 17 +++++++++++++++++
>  lib/efi_selftest/efi_selftest_miniapp_exception.c |  2 ++
>  6 files changed, 46 insertions(+)
>
> diff --git a/include/asm-generic/pe.h b/include/asm-generic/pe.h
> index cd5b6ad62bf0..42c4cbedbc95 100644
> --- a/include/asm-generic/pe.h
> +++ b/include/asm-generic/pe.h
> @@ -31,6 +31,11 @@
>
>  /* Machine types */
>  #define IMAGE_FILE_MACHINE_I386                        0x014c
> +#define IMAGE_FILE_MACHINE_R3000_BE            0x0160
> +#define IMAGE_FILE_MACHINE_R3000               0x0162
> +#define IMAGE_FILE_MACHINE_R4000_BE            0x0164
> +#define IMAGE_FILE_MACHINE_R4000               0x0166
> +#define IMAGE_FILE_MACHINE_R10000              0x0168
>  #define IMAGE_FILE_MACHINE_ARM                 0x01c0
>  #define IMAGE_FILE_MACHINE_THUMB               0x01c2
>  #define IMAGE_FILE_MACHINE_ARMNT               0x01c4
> diff --git a/include/config_distro_bootcmd.h b/include/config_distro_bootcmd.h
> index 2a136b96a6d9..9e03d10acec5 100644
> --- a/include/config_distro_bootcmd.h
> +++ b/include/config_distro_bootcmd.h
> @@ -366,6 +366,12 @@
>  #elif defined(CONFIG_ARCH_RV64I) || ((defined(__riscv) && __riscv_xlen == 64))
>  #define BOOTENV_EFI_PXE_ARCH "0x1b"
>  #define BOOTENV_EFI_PXE_VCI "PXEClient:Arch:00027:UNDI:003000"
> +#elif defined(CONFIG_CPU_MIPS32) || ((defined(__mips) && __mips == 32))
> +#define BOOTENV_EFI_PXE_ARCH "0x21"
> +#define BOOTENV_EFI_PXE_VCI "PXEClient:Arch:00033:UNDI:003000"
> +#elif defined(CONFIG_CPU_MIPS64) || ((defined(__mips) && __mips == 64))
> +#define BOOTENV_EFI_PXE_ARCH "0x22"
> +#define BOOTENV_EFI_PXE_VCI "PXEClient:Arch:00034:UNDI:003000"
>  #elif defined(CONFIG_SANDBOX)
>  # error "sandbox EFI support is only supported on ARM and x86"
>  #else
> diff --git a/include/efi_default_filename.h b/include/efi_default_filename.h
> index 77932984b557..eb94a54514bc 100644
> --- a/include/efi_default_filename.h
> +++ b/include/efi_default_filename.h
> @@ -47,6 +47,14 @@
>  #define BOOTEFI_NAME "BOOTRISCV32.EFI"
>  #elif defined(CONFIG_ARCH_RV64I)
>  #define BOOTEFI_NAME "BOOTRISCV64.EFI"
> +#elif defined(CONFIG_CPU_MIPS32) && defined(CONFIG_SYS_BIG_ENDIAN)
> +#define BOOTEFI_NAME "BOOTMIPS.EFI"
> +#elif defined(CONFIG_CPU_MIPS32) && defined(CONFIG_SYS_LITTLE_ENDIAN)
> +#define BOOTEFI_NAME "BOOTMIPSEL.EFI"
> +#elif defined(CONFIG_CPU_MIPS64) && defined(CONFIG_SYS_BIG_ENDIAN)
> +#define BOOTEFI_NAME "BOOTMIPS64.EFI"
> +#elif defined(CONFIG_CPU_MIPS64) && defined(CONFIG_SYS_LITTLE_ENDIAN)
> +#define BOOTEFI_NAME "BOOTMIPS64EL.EFI"
>  #else
>  #error Unsupported UEFI architecture
>  #endif
> diff --git a/include/elf.h b/include/elf.h
> index a4ba74d8abeb..95de6ffbce31 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -545,6 +545,9 @@ typedef struct {
>  #define DT_LOPROC      0x70000000      /* reserved range for processor */
>  #define DT_HIPROC      0x7fffffff      /* specific dynamic array tags */
>
> +/* MIPS */
> +#define DT_MIPS_LOCAL_GOTNO    0x7000000a      /* Number of local got entries */
> +
>  /* Dynamic Tag Flags - d_un.d_val */
>  #define DF_ORIGIN      0x01            /* Object may use DF_ORIGIN */
>  #define DF_SYMBOLIC    0x02            /* Symbol resolutions starts here */
> @@ -699,6 +702,11 @@ unsigned long elf_hash(const unsigned char *name);
>  #define R_RISCV_64             2
>  #define R_RISCV_RELATIVE       3
>
> +/* MIPS Relocations */
> +#define R_MIPS_NONE            0
> +#define R_MIPS_REL32           3
> +#define R_MIPS_64              18
> +
>  #ifndef __ASSEMBLY__
>  int valid_elf_image(unsigned long addr);
>  unsigned long load_elf64_image_phdr(unsigned long addr);
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> index cedc4d822fe7..8df469851851 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -51,6 +51,23 @@ static int machines[] = {
>         IMAGE_FILE_MACHINE_RISCV64,
>  #endif
>
> +#if defined(__mips__) && (__mips == 32) && defined(__BIG_ENDIAN)
> +       IMAGE_FILE_MACHINE_R3000_BE,
> +#endif
> +
> +#if defined(__mips__) && (__mips == 32) && defined(__LITTLE_ENDIAN)
> +       IMAGE_FILE_MACHINE_R3000,
> +#endif
> +
> +#if defined(__mips__) && (__mips == 64) && defined(__BIG_ENDIAN)
> +       IMAGE_FILE_MACHINE_R4000_BE,
> +#endif
> +
> +#if defined(__mips__) && (__mips == 64) && defined(__LITTLE_ENDIAN)
> +       IMAGE_FILE_MACHINE_R4000,
> +       IMAGE_FILE_MACHINE_R10000,
> +#endif
> +
>         0 };
>
>  /**
> diff --git a/lib/efi_selftest/efi_selftest_miniapp_exception.c b/lib/efi_selftest/efi_selftest_miniapp_exception.c
> index f668cdac4ab2..f3b4ee926f8f 100644
> --- a/lib/efi_selftest/efi_selftest_miniapp_exception.c
> +++ b/lib/efi_selftest/efi_selftest_miniapp_exception.c
> @@ -33,6 +33,8 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
>         asm volatile (".word 0xe7f7defb\n");
>  #elif defined(CONFIG_RISCV)
>         asm volatile (".word 0xffffffff\n");
> +#elif defined(CONFIG_MIPS)
> +       asm volatile ("break 0xf\n");
>  #elif defined(CONFIG_X86)
>         asm volatile (".word 0xffff\n");
>  #elif defined(CONFIG_SANDBOX)
>
> --
> 2.34.1
>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
