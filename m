Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084BDC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 11:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 539188804B;
	Wed, 28 Feb 2024 12:09:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aFCVqvUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76C5888079; Wed, 28 Feb 2024 12:09:15 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C6388061
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 12:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-512f3e75391so4516469e87.2
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 03:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709118546; x=1709723346; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4oVGVfEKpQCAbo7FeFn9htP2gGXt1H6fv3GoA4S8Dqo=;
 b=aFCVqvUSRAc7mg+/tma7fyoX6neHDDZd99kLRnNvNJHkkcmhzocAt2AY5e5NJ+BnGn
 becNp734Tfa9W8iLICbNuRMAZokarhRt75WKhuxTTV7Y5pmGnXItWHzqrrheEByYx9/r
 AQ/hlgYZPtMWEnvaQQiC1+/iuawEMn+L6v/M1yIrrm4RUCLr4BQ9XB4cvnYI6VeR62yB
 kISH/frIdCF/WBgHgwsJ/pInnda3N6BX+gKKiU2V5hAo1MKRrG8SgQ+fkETYMUPPZ7dh
 /g1D5LAl4758BGP1Tpd978zpM+QoyYWDXi9Z+WLuO1wt27qkTrNw9QC3xEaZe6U46se4
 JRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709118546; x=1709723346;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4oVGVfEKpQCAbo7FeFn9htP2gGXt1H6fv3GoA4S8Dqo=;
 b=DXGrT0rfyc8EUPYf0hyZ6M4XOC7a/y/uIdlEi9gBrgjYbE86iw28eRf/fcCGcHEtbn
 wtCVv4tGW71coybsXbUmik2wYFheHCWb/Cn7oSAZnZSO77xkWWlIh1U1ek19NV931Mb0
 aS7g9vv4Kosz9vHpyfZ5yqcRCB3173CiIQaIiaNSoN+H6y7cK3vAHzHQ+Vps6EcCyjkG
 06XRQZsGKTWIvINm/YdeGkvL/pA/Un7x31ynUJUXYqOZMEXalyK8QtSt4n3p/kZlZYoV
 S++bo4mXhuueluBNHdsFOFT75LIEmnthzUPv6ZZTgdDij+Cc93yHcyIRiyN/MosjrZDY
 bcJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNYhTqELtESdrOqP332geBz7qLE/KQxiv+kK9BLpZIqAGmfHSy6vZi3caTGgXk372qhEGqwAbs2xJTigT7DUmMd7WL2Q==
X-Gm-Message-State: AOJu0YyaKFvb7ZVA9RpmYRaw0snGb6UUWASTTOq4TocgrtadmTAIN60P
 OAb+mKXcdgDaF91jSbdkhRxxbwf6WU029E32GlpyrZV1PqLHds3lW1JbdyR7nQ8Y4WmgHG0Qby9
 tfYaRtIQgz9LFp7Zg/mztBP0Ui7mNro5ms1nvsw==
X-Google-Smtp-Source: AGHT+IEMXolxf4poVaW4lMqgvwgbEmvPZI+PtSmo3Aq0sIIf0WpPkQZ1xbqHA2WnRv3c5Upa/03aDJ0R+za3i/PutCY=
X-Received: by 2002:a05:6512:3f06:b0:512:dab0:836d with SMTP id
 y6-20020a0565123f0600b00512dab0836dmr10942832lfa.43.1709118546396; Wed, 28
 Feb 2024 03:09:06 -0800 (PST)
MIME-Version: 1.0
References: <20240226212408.7535-1-heinrich.schuchardt@canonical.com>
 <20240226212408.7535-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240226212408.7535-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 28 Feb 2024 13:08:30 +0200
Message-ID: <CAC_iWj+wYUqdzgWenzWjZgNDKSTx6WThBgKbZnCwFfVNajvrcg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm: separate .data and .text sections of EFI
 binaries
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Mon, 26 Feb 2024 at 23:24, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> EFI binaries should not contain sections that are both writable and
> executable. Separate the RX .text section from the RW .data section.
>
> We currently don't created relocation sections (.rel.*) for our EFI
> binaries. Anyway these would have to be converted to PE/COFF relocations.
> Enumerate them under DISCARD and add a comment.
>
> Correct the characteristics of the sections.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         Consider that 32-bit arm uses .rel and not .rela relocations
>         and discard them as they are cannot be used in EFI binaries.
>         Correct the characteristics of the .reloc section.
> ---
>  arch/arm/lib/crt0_arm_efi.S  | 40 ++++++++++++++++++++++++++++--------
>  arch/arm/lib/elf_arm_efi.lds | 28 ++++++++++++++++++-------
>  2 files changed, 52 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
> index 7a4e5dff75..7219c0f2fe 100644
> --- a/arch/arm/lib/crt0_arm_efi.S
> +++ b/arch/arm/lib/crt0_arm_efi.S
> @@ -23,7 +23,7 @@ pe_header:
>         .long   IMAGE_NT_SIGNATURE              /* 'PE' */
>  coff_header:
>         .short  IMAGE_FILE_MACHINE_THUMB        /* Mixed ARM/Thumb */
> -       .short  2                               /* nr_sections */
> +       .short  3                               /* nr_sections */
>         .long   0                               /* TimeDateStamp */
>         .long   0                               /* PointerToSymbolTable */
>         .long   0                               /* NumberOfSymbols */
> @@ -98,22 +98,44 @@ section_table:
>         .long   0                       /* PointerToLineNumbers */
>         .short  0                       /* NumberOfRelocations */
>         .short  0                       /* NumberOfLineNumbers */
> -       .long   0x42100040              /* Characteristics (section flags) */
> +       /* Characteristics (section flags) */
> +       .long   (IMAGE_SCN_MEM_READ | \
> +                IMAGE_SCN_MEM_DISCARDABLE | \
> +                IMAGE_SCN_CNT_INITIALIZED_DATA)
>
>         .ascii  ".text"
>         .byte   0
>         .byte   0
>         .byte   0                       /* end of 0 padding of section name */
> -       .long   _edata - _start         /* VirtualSize */
> +       .long   _text_size              /* VirtualSize */
>         .long   _start - image_base     /* VirtualAddress */
> -       .long   _edata - _start         /* SizeOfRawData */
> +       .long   _text_size              /* SizeOfRawData */
>         .long   _start - image_base     /* PointerToRawData */
> +       .long   0                       /* PointerToRelocations */
> +       .long   0                       /* PointerToLineNumbers */
> +       .short  0                       /* NumberOfRelocations */
> +       .short  0                       /* NumberOfLineNumbers */
> +       /* Characteristics (section flags) */
> +       .long   (IMAGE_SCN_MEM_READ | \
> +                IMAGE_SCN_MEM_EXECUTE | \
> +                IMAGE_SCN_CNT_CODE)
>
> -       .long   0               /* PointerToRelocations (0 for executables) */
> -       .long   0               /* PointerToLineNumbers (0 for executables) */
> -       .short  0               /* NumberOfRelocations  (0 for executables) */
> -       .short  0               /* NumberOfLineNumbers  (0 for executables) */
> -       .long   0xe0500020      /* Characteristics (section flags) */
> +       .ascii  ".data"
> +       .byte   0
> +       .byte   0
> +       .byte   0                       /* end of 0 padding of section name */
> +       .long   _data_size              /* VirtualSize */
> +       .long   _data - image_base      /* VirtualAddress */
> +       .long   _data_size              /* SizeOfRawData */
> +       .long   _data - image_base      /* PointerToRawData */
> +       .long   0                       /* PointerToRelocations */
> +       .long   0                       /* PointerToLineNumbers */
> +       .short  0                       /* NumberOfRelocations */
> +       .short  0                       /* NumberOfLineNumbers */
> +       /* Characteristics (section flags) */
> +       .long   (IMAGE_SCN_MEM_WRITE | \
> +                IMAGE_SCN_MEM_READ | \
> +                IMAGE_SCN_CNT_INITIALIZED_DATA)
>
>         .align          12
>  _start:
> diff --git a/arch/arm/lib/elf_arm_efi.lds b/arch/arm/lib/elf_arm_efi.lds
> index 767ebda635..41440594aa 100644
> --- a/arch/arm/lib/elf_arm_efi.lds
> +++ b/arch/arm/lib/elf_arm_efi.lds
> @@ -7,6 +7,12 @@
>
>  OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
>  OUTPUT_ARCH(arm)
> +
> +PHDRS
> +{
> +       data PT_LOAD FLAGS(3); /* PF_W | PF_X */
> +}
> +
>  ENTRY(_start)
>  SECTIONS
>  {
> @@ -18,11 +24,13 @@ SECTIONS
>                 *(.gnu.linkonce.t.*)
>                 *(.srodata)
>                 *(.rodata*)
> +               . = ALIGN(16);
> +               *(.dynamic);
>                 . = ALIGN(512);
>         }
>         _etext = .;
>         _text_size = . - _text;
> -       .dynamic  : { *(.dynamic) }
> +       . = ALIGN(4096);
>         .data : {
>                 _data = .;
>                 *(.sdata)
> @@ -47,14 +55,20 @@ SECTIONS
>                 . = ALIGN(512);
>                 _bss_end = .;
>                 _edata = .;
> -       }
> -       .rel.dyn : { *(.rel.dyn) }
> -       .rel.plt : { *(.rel.plt) }
> -       .rel.got : { *(.rel.got) }
> -       .rel.data : { *(.rel.data) *(.rel.data*) }
> -       _data_size = . - _etext;
> +       } :data
> +       _data_size = . - _data;
>
>         /DISCARD/ : {
> +               /*
> +                * We don't support relocations. These would have to be
> +                * translated from ELF to PE format and added to the .reloc
> +                * section.
> +                */
> +               *(.rel.dyn)
> +               *(.rel.plt)
> +               *(.rel.got)
> +               *(.rel.data)
> +               *(.rel.data*)
>                 *(.rel.reloc)
>                 *(.eh_frame)
>                 *(.note.GNU-stack)
> --
> 2.43.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
