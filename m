Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15658C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 08:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98CEF80040;
	Wed, 15 Jan 2025 09:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KuwCE72p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD49580214; Wed, 15 Jan 2025 09:04:22 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B9480027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 09:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e3a0acba5feso8687959276.2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 00:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736928259; x=1737533059; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5Jt4+DqEUPZmpiRM0nmgiVgzv+X13eE8t2EExgOXMS4=;
 b=KuwCE72pdMDRSUq8mz92hh/cGMU3YoojAsIlGtx3843AKS1X1bcTZv56agMa7NlpzJ
 P9Lp0f0mj+5bpOaFQReTkvhvR6jZDDSFC6yXzO9hea5NOwR6hQtPlk1b0xfKHsyp9nn9
 XMiq2IOGDkh1BxP+o7JLR0HLrxXX08lXQqBOukh2b9dHx6iyKqIi/7Xzq73zp0pEfZ3N
 qTusrNxMdrdXZ+pU/FVpffLF1989MOoL/8b8BFt2edWfbuucOZivMWYbdXv/BmH8eiCp
 IO8cLJwAYf+X3hxutk3K8gMjUd8V1m0mNWltUkE6o3RoAByDRJX4BHdhWZFpRFIWBQM5
 k+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736928259; x=1737533059;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Jt4+DqEUPZmpiRM0nmgiVgzv+X13eE8t2EExgOXMS4=;
 b=txq0PAEJMtGUJWm2Vq75+OaLtE4HtM8qSDo8UJSyaI8AGMchQun8yw60HOlVATs5SL
 1rLj8gUn/YbIT19HEeofVPWCZ9OzVhQWv8kIR88snsi2/IBO8IFtMmQE8uYunMmkqyS3
 7Z6AxthXRcDhwjH035PABedKjDEeLrNEZMX7cJVTCk0NPWMJTYzA4w9ilXumBBFUAOZT
 Mzdp5gxnAEvgUNUhMcvCpl9aPI+C4UAVXHh7+KZD0y0f+Azlj2Zwiv5Nnm7VsTRVsjU9
 dkLQbwqZOgg4AF+n0ws+OflHuZMy2TigP6OIZ4PmPO7qFNQYkprPBOJUZCd/9KBOMeY9
 KJtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrKoUH6ur+CCzyR0jdC+NryKuvSeUBZHhZ9nTQmt9Vv3NK2UUaTJUyJ4KfxAOrc2xPfe5s+/I=@lists.denx.de
X-Gm-Message-State: AOJu0YyryFScnafCi9Ejtkq2ViRsmN1XgTdiwve22mUy2C7xGy+Tdglh
 ctTg0MLD9PQs+yXxwaglhgr9sgPdl1wMqGvCkweSOPIX/ikAifG425t/TvOc5dePJKV30cGtT9b
 z6rKeQTSfxb3+eci/laKoDiXp5lFKupVFy4I+9A==
X-Gm-Gg: ASbGncssF15Z6/zO1Q506xSNRbZQRCiauw6wQZfW1smHbLHDopKZpt8l0RqH2CDETYh
 Rl2LAdHmKL+tguPEedXkvuFqfQxOMF53m39SShw==
X-Google-Smtp-Source: AGHT+IGi+QB1R7ntElKQ03bBEJxe+7SCutKlDS7Uh377aUBWgTfJVYY9BpNAMsDZoXS0wXQbIpVpbOZ+QVt0GinilLI=
X-Received: by 2002:a05:690c:385:b0:6ee:6c7d:4888 with SMTP id
 00721157ae682-6f53124c5c6mr218159997b3.22.1736928259088; Wed, 15 Jan 2025
 00:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20250114102953.64381-1-heinrich.schuchardt@canonical.com>
 <20250114102953.64381-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250114102953.64381-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 15 Jan 2025 10:03:43 +0200
X-Gm-Features: AbW1kvbAykxCObM1NEh2sW5kxu8Str83zzGUbjIeK6PhH2B5VUMoSZeWHiAo9lk
Message-ID: <CAC_iWjJOpQWXZvGPHvjJ7qpkyGUGExr2_qtxSfrVX8E8t70+9w@mail.gmail.com>
Subject: Re: [PATCH 3/4] efi_loader: use INCLUDE in EFI linker scripts
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Prasad Kummari <prasad.kummari@amd.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Tue, 14 Jan 2025 at 12:30, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Except for the architecture specific lines ARM and RISC-V can use the same
> linker script. Move the common lines to an include.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/arm/lib/elf_aarch64_efi.lds   | 68 +--------------------------
>  arch/riscv/lib/elf_riscv32_efi.lds | 68 +--------------------------
>  arch/riscv/lib/elf_riscv64_efi.lds | 68 +--------------------------
>  lib/efi_loader/elf_efi.ldsi        | 74 ++++++++++++++++++++++++++++++
>  4 files changed, 77 insertions(+), 201 deletions(-)
>  create mode 100644 lib/efi_loader/elf_efi.ldsi
>
> diff --git a/arch/arm/lib/elf_aarch64_efi.lds b/arch/arm/lib/elf_aarch64_efi.lds
> index e382254a6cf..453d3511c28 100644
> --- a/arch/arm/lib/elf_aarch64_efi.lds
> +++ b/arch/arm/lib/elf_aarch64_efi.lds
> @@ -8,70 +8,4 @@
>  OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
>  OUTPUT_ARCH(aarch64)
>
> -PHDRS
> -{
> -       data PT_LOAD FLAGS(3); /* SHF_WRITE | SHF_ALLOC */
> -}
> -
> -ENTRY(_start)
> -SECTIONS
> -{
> -       .text 0x0 : {
> -               _text = .;
> -               *(.text.head)
> -               *(.text)
> -               *(.text.*)
> -               *(.gnu.linkonce.t.*)
> -               *(.srodata)
> -               *(.rodata*)
> -               . = ALIGN(16);
> -               *(.dynamic);
> -               . = ALIGN(512);
> -       }
> -       .rela.dyn : { *(.rela.dyn) }
> -       .rela.plt : { *(.rela.plt) }
> -       .rela.got : { *(.rela.got) }
> -       .rela.data : { *(.rela.data) *(.rela.data*) }
> -       . = ALIGN(4096);
> -       _etext = .;
> -       _text_size = . - _text;
> -       .data : {
> -               _data = .;
> -               *(.sdata)
> -               *(.data)
> -               *(.data1)
> -               *(.data.*)
> -               *(.got.plt)
> -               *(.got)
> -
> -               /*
> -                * The EFI loader doesn't seem to like a .bss section, so we
> -                * stick it all into .data:
> -                */
> -               . = ALIGN(16);
> -               _bss = .;
> -               *(.sbss)
> -               *(.scommon)
> -               *(.dynbss)
> -               *(.bss)
> -               *(.bss.*)
> -               *(COMMON)
> -               . = ALIGN(512);
> -               _bss_end = .;
> -               _edata = .;
> -       } :data
> -       _data_size = _edata - _data;
> -
> -       . = ALIGN(4096);
> -       .dynsym   : { *(.dynsym) }
> -       . = ALIGN(4096);
> -       .dynstr   : { *(.dynstr) }
> -       . = ALIGN(4096);
> -       .note.gnu.build-id : { *(.note.gnu.build-id) }
> -       /DISCARD/ : {
> -               *(.rel.reloc)
> -               *(.eh_frame)
> -               *(.note.GNU-stack)
> -       }
> -       .comment 0 : { *(.comment) }
> -}
> +INCLUDE lib/efi_loader/elf_efi.ldsi
> diff --git a/arch/riscv/lib/elf_riscv32_efi.lds b/arch/riscv/lib/elf_riscv32_efi.lds
> index 7b9bd7b7f15..e23521c4931 100644
> --- a/arch/riscv/lib/elf_riscv32_efi.lds
> +++ b/arch/riscv/lib/elf_riscv32_efi.lds
> @@ -8,70 +8,4 @@
>  OUTPUT_FORMAT("elf32-littleriscv", "elf32-littleriscv", "elf32-littleriscv")
>  OUTPUT_ARCH(riscv)
>
> -PHDRS
> -{
> -       data PT_LOAD FLAGS(3); /* SHF_WRITE | SHF_ALLOC */
> -}
> -
> -ENTRY(_start)
> -SECTIONS
> -{
> -       .text 0x0 : {
> -               _text = .;
> -               *(.text.head)
> -               *(.text)
> -               *(.text.*)
> -               *(.gnu.linkonce.t.*)
> -               *(.srodata)
> -               *(.rodata*)
> -               . = ALIGN(16);
> -               *(.dynamic);
> -               . = ALIGN(512);
> -       }
> -       .rela.dyn : { *(.rela.dyn) }
> -       .rela.plt : { *(.rela.plt) }
> -       .rela.got : { *(.rela.got) }
> -       .rela.data : { *(.rela.data) *(.rela.data*) }
> -       _etext = .;
> -       _text_size = . - _text;
> -       . = ALIGN(4096);
> -       .data : {
> -               _data = .;
> -               *(.sdata)
> -               *(.data)
> -               *(.data1)
> -               *(.data.*)
> -               *(.got.plt)
> -               *(.got)
> -
> -               /*
> -                * The EFI loader doesn't seem to like a .bss section, so we
> -                * stick it all into .data:
> -                */
> -               . = ALIGN(16);
> -               _bss = .;
> -               *(.sbss)
> -               *(.scommon)
> -               *(.dynbss)
> -               *(.bss)
> -               *(.bss.*)
> -               *(COMMON)
> -               . = ALIGN(512);
> -               _bss_end = .;
> -               _edata = .;
> -       } :data
> -       _data_size = _edata - _data;
> -
> -       . = ALIGN(4096);
> -       .dynsym   : { *(.dynsym) }
> -       . = ALIGN(4096);
> -       .dynstr   : { *(.dynstr) }
> -       . = ALIGN(4096);
> -       .note.gnu.build-id : { *(.note.gnu.build-id) }
> -       /DISCARD/ : {
> -               *(.rel.reloc)
> -               *(.eh_frame)
> -               *(.note.GNU-stack)
> -       }
> -       .comment 0 : { *(.comment) }
> -}
> +INCLUDE lib/efi_loader/elf_efi.ldsi
> diff --git a/arch/riscv/lib/elf_riscv64_efi.lds b/arch/riscv/lib/elf_riscv64_efi.lds
> index d0b4f3d1d64..8e4844c2eea 100644
> --- a/arch/riscv/lib/elf_riscv64_efi.lds
> +++ b/arch/riscv/lib/elf_riscv64_efi.lds
> @@ -8,70 +8,4 @@
>  OUTPUT_FORMAT("elf64-littleriscv", "elf64-littleriscv", "elf64-littleriscv")
>  OUTPUT_ARCH(riscv)
>
> -PHDRS
> -{
> -       data PT_LOAD FLAGS(3); /* SHF_WRITE | SHF_ALLOC */
> -}
> -
> -ENTRY(_start)
> -SECTIONS
> -{
> -       .text 0x0 : {
> -               _text = .;
> -               *(.text.head)
> -               *(.text)
> -               *(.text.*)
> -               *(.gnu.linkonce.t.*)
> -               *(.srodata)
> -               *(.rodata*)
> -               . = ALIGN(16);
> -               *(.dynamic);
> -               . = ALIGN(512);
> -       }
> -       .rela.dyn : { *(.rela.dyn) }
> -       .rela.plt : { *(.rela.plt) }
> -       .rela.got : { *(.rela.got) }
> -       .rela.data : { *(.rela.data) *(.rela.data*) }
> -       _etext = .;
> -       _text_size = . - _text;
> -       . = ALIGN(4096);
> -       .data : {
> -               _data = .;
> -               *(.sdata)
> -               *(.data)
> -               *(.data1)
> -               *(.data.*)
> -               *(.got.plt)
> -               *(.got)
> -
> -               /*
> -                * The EFI loader doesn't seem to like a .bss section, so we
> -                * stick it all into .data:
> -                */
> -               . = ALIGN(16);
> -               _bss = .;
> -               *(.sbss)
> -               *(.scommon)
> -               *(.dynbss)
> -               *(.bss)
> -               *(.bss.*)
> -               *(COMMON)
> -               . = ALIGN(512);
> -               _bss_end = .;
> -               _edata = .;
> -       } :data
> -       _data_size = _edata - _data;
> -
> -       . = ALIGN(4096);
> -       .dynsym   : { *(.dynsym) }
> -       . = ALIGN(4096);
> -       .dynstr   : { *(.dynstr) }
> -       . = ALIGN(4096);
> -       .note.gnu.build-id : { *(.note.gnu.build-id) }
> -       /DISCARD/ : {
> -               *(.rel.reloc)
> -               *(.eh_frame)
> -               *(.note.GNU-stack)
> -       }
> -       .comment 0 : { *(.comment) }
> -}
> +INCLUDE lib/efi_loader/elf_efi.ldsi
> diff --git a/lib/efi_loader/elf_efi.ldsi b/lib/efi_loader/elf_efi.ldsi
> new file mode 100644
> index 00000000000..190a88fb69e
> --- /dev/null
> +++ b/lib/efi_loader/elf_efi.ldsi
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: BSD-2-Clause */
> +/*
> + * U-Boot EFI linker script include
> + *
> + * Modified from elf_aarch64_efi.lds in gnu-efi
> + */
> +
> +PHDRS
> +{
> +       data PT_LOAD FLAGS(3); /* SHF_WRITE | SHF_ALLOC */
> +}
> +
> +ENTRY(_start)
> +SECTIONS
> +{
> +       .text 0x0 : {
> +               _text = .;
> +               *(.text.head)
> +               *(.text)
> +               *(.text.*)
> +               *(.gnu.linkonce.t.*)
> +               *(.srodata)
> +               *(.rodata*)
> +               . = ALIGN(16);
> +               *(.dynamic);
> +               . = ALIGN(512);
> +       }
> +       .rela.dyn : { *(.rela.dyn) }
> +       .rela.plt : { *(.rela.plt) }
> +       .rela.got : { *(.rela.got) }
> +       .rela.data : { *(.rela.data) *(.rela.data*) }
> +       . = ALIGN(4096);
> +       _etext = .;
> +       _text_size = . - _text;
> +       .data : {
> +               _data = .;
> +               *(.sdata)
> +               *(.data)
> +               *(.data1)
> +               *(.data.*)
> +               *(.got.plt)
> +               *(.got)
> +
> +               /*
> +                * The EFI loader doesn't seem to like a .bss section, so we
> +                * stick it all into .data:
> +                */
> +               . = ALIGN(16);
> +               _bss = .;
> +               *(.sbss)
> +               *(.scommon)
> +               *(.dynbss)
> +               *(.bss)
> +               *(.bss.*)
> +               *(COMMON)
> +               . = ALIGN(512);
> +               _bss_end = .;
> +               _edata = .;
> +       } :data
> +       _data_size = _edata - _data;
> +
> +       . = ALIGN(4096);
> +       .dynsym   : { *(.dynsym) }
> +       . = ALIGN(4096);
> +       .dynstr   : { *(.dynstr) }
> +       . = ALIGN(4096);
> +       .note.gnu.build-id : { *(.note.gnu.build-id) }
> +       /DISCARD/ : {
> +               *(.rel.reloc)
> +               *(.eh_frame)
> +               *(.note.GNU-stack)
> +       }
> +       .comment 0 : { *(.comment) }
> +}
> --
> 2.47.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
