Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C613C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 09:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9282C806FB;
	Fri, 17 Jan 2025 10:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fij6vgw7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3467A80737; Fri, 17 Jan 2025 10:20:34 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFBC380312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso3067805276.1
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 01:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737105631; x=1737710431; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zOJYOLPptNF5iUTSZL0R14aVDmrbAUZ5d66XaWDk1gQ=;
 b=fij6vgw7GkUH/ppaaetFdAWNbsv0ekmD9L4T6OSONRZ6yiDljQztGdXqrqFTwyfZ8z
 vAitr1eZIVHxDipSoaZzbHwhq6I0k+Hf1diMMhXrJNfTq9nPK65PHkp2dadYGAD++gS+
 nOpzI2akXyFaDF1dhTBjVJqqQGv5Nvzo+kNBs8y+i/6BuAjC1rgpbcSphtQ9QGKXqhbZ
 OWIZge3WcvB22UQOcy1NcFmjvITJ6ymP2ibd4t4Sg5hN3ST8uXSg7zNmnd95OCEjqLdy
 hC2M6eMWms135ugziX/yr34Dg+vD8PqEC6zuLrZFErUFbL1Zr2UiQRpPYzYT3pVQdJiw
 m50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737105631; x=1737710431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zOJYOLPptNF5iUTSZL0R14aVDmrbAUZ5d66XaWDk1gQ=;
 b=wx9NEjLdEIxgyfoUJVxDPfFEr96aSAN+SKsBB0DORPg21956o2IpUF+NKMgEGhGnhz
 ylNvGGXldPd0vumZOk1yZm2lO+jBDrIkcNHDHawFwVNqnTjtIRvR4Z3my0qhDtIeIytF
 67yscctI+4NqKfTGgdBdtqSbTLRvpeNuJkEif6jhnf05AtMNq4AFaAnRht17iLpsV4m6
 RRNDjf2DL97IpzVax2SQ0e9VYtEXoxexHSKtxabZSImgb/YXa76o7CPnid6XjJMlhuKL
 3kSOl/27MmxSDyFJWs65Ohe3ph/019oFunOPGr/2hfuqDLxLFt8xh/S9Pw0YoBxW2IGX
 1E7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwVbsttMAsuSqGOTo4syZ+QEv6XaZERk7eC2yQFRljVi7EmR7Qq9hxvMx3qfZjgP7eGdQxBUs=@lists.denx.de
X-Gm-Message-State: AOJu0Ywx/Evwnel+Ck2xVymBJYmGYyLgBERu9BnnSaIb2gU7oM9jHVbk
 ZWs43WDtfEF02DLLlZN1dwKHjMtU2lMb+tZOZS4gAJrZ1x6czsRE1LdOs1BMWarA3PeXsEUpRcY
 EO2FhUyOOZmFuREQv4O3pgQpZBLRn+FzmiHPhqA==
X-Gm-Gg: ASbGncukIY+AysbUfIYcywyN2/HDfi4KQcP5ugk4VTDxMd43PJ22r20ykP2jRx+wxMy
 u8oBEXRQBFeJZq/DCVgvOvP/4PZuvK3KrfxzHAw==
X-Google-Smtp-Source: AGHT+IEJDvlrYkLeXq39ew9DK37YVO5Z3HDrtfDOghd2v8aQMenR3zAKUyqYjwqlkpVKCDh8r9wszHnIeISMsAfxxEg=
X-Received: by 2002:a05:690c:7344:b0:6ef:5ab8:2c53 with SMTP id
 00721157ae682-6f6eb68695cmr13222237b3.19.1737105630837; Fri, 17 Jan 2025
 01:20:30 -0800 (PST)
MIME-Version: 1.0
References: <20250116113909.113950-1-heinrich.schuchardt@canonical.com>
 <20250116113909.113950-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250116113909.113950-6-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 17 Jan 2025 11:19:55 +0200
X-Gm-Features: AbW1kvaVUiBw9qwMpcOzuJKmIGyxWj9Gg-eX2_6l5Gfh4hAuVhU2sn30888NYTc
Message-ID: <CAC_iWj+Lrs=m49UNNejwa+tSusHQOa2w3a9u5rSnV83kvyXfcA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] efi_loader: use include in ARM EFI linker script
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Michal Simek <michal.simek@amd.com>, Prasad Kummari <prasad.kummari@amd.com>,
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

On Thu, 16 Jan 2025 at 13:39, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Use the same include as arm64 for the linker script.
>
> Adjust the 32-bit ARM PE-COFF header accordingly and harmonize it with the
> 64-bit ARM header.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         Do not rename field image_base to ImageBase.
>         Move SizeOfCode change to separate patch.
> ---
>  arch/arm/lib/crt0_arm_efi.S  |  9 +++--
>  arch/arm/lib/elf_arm_efi.lds | 71 +-----------------------------------
>  2 files changed, 6 insertions(+), 74 deletions(-)
>
> diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
> index 3664cce8412..91b0fe12c51 100644
> --- a/arch/arm/lib/crt0_arm_efi.S
> +++ b/arch/arm/lib/crt0_arm_efi.S
> @@ -46,8 +46,8 @@ optional_header:
>         .long   0                               /* BaseOfData */
>
>  extra_header_fields:
> -       .long   0                               /* image_base */
> -       .long   0x200                           /* SectionAlignment */
> +       .long   0                               /* ImageBase */
> +       .long   0x1000                          /* SectionAlignment */
>         .long   0x200                           /* FileAlignment */
>         .short  0                               /* MajorOperatingSystemVersion */
>         .short  0                               /* MinorOperatingSystemVersion */
> @@ -84,6 +84,7 @@ extra_header_fields:
>         .quad   0                               /* CertificationTable */
>         .quad   0                               /* BaseRelocationTable */
>
> +       /* Section table */
>  section_table:
>
>         /*
> @@ -111,9 +112,9 @@ section_table:
>         .byte   0
>         .byte   0
>         .byte   0                       /* end of 0 padding of section name */
> -       .long   _text_size              /* VirtualSize */
> +       .long   _etext - _start         /* VirtualSize */
>         .long   _start - image_base     /* VirtualAddress */
> -       .long   _text_size              /* SizeOfRawData */
> +       .long   _etext - _start         /* SizeOfRawData */
>         .long   _start - image_base     /* PointerToRawData */
>         .long   0                       /* PointerToRelocations */
>         .long   0                       /* PointerToLineNumbers */
> diff --git a/arch/arm/lib/elf_arm_efi.lds b/arch/arm/lib/elf_arm_efi.lds
> index 41440594aa6..eb16fae74cf 100644
> --- a/arch/arm/lib/elf_arm_efi.lds
> +++ b/arch/arm/lib/elf_arm_efi.lds
> @@ -8,73 +8,4 @@
>  OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
>  OUTPUT_ARCH(arm)
>
> -PHDRS
> -{
> -       data PT_LOAD FLAGS(3); /* PF_W | PF_X */
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
> -       _data_size = . - _data;
> -
> -       /DISCARD/ : {
> -               /*
> -                * We don't support relocations. These would have to be
> -                * translated from ELF to PE format and added to the .reloc
> -                * section.
> -                */
> -               *(.rel.dyn)
> -               *(.rel.plt)
> -               *(.rel.got)
> -               *(.rel.data)
> -               *(.rel.data*)
> -               *(.rel.reloc)
> -               *(.eh_frame)
> -               *(.note.GNU-stack)
> -               *(.dynsym)
> -               *(.dynstr)
> -               *(.note.gnu.build-id)
> -               *(.comment)
> -       }
> -}
> +INCLUDE lib/efi_loader/elf_efi.ldsi
> --
> 2.47.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
