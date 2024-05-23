Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C016DC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 16:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5241B885E2;
	Thu, 23 May 2024 18:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Wvf1P1JH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16B7D885E1; Thu, 23 May 2024 18:26:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCA26876D3
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 18:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1716481585; x=1717086385; i=xypron.glpk@gmx.de;
 bh=QboHKGMMjVZQcW5N4AacFMK4RxtHoqKBSo5qXq4v05s=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Wvf1P1JHNijVJLY8qTzINjx9qxfBnKcYqhmE0OLiXXJgc0Di53ZJ7K9Np5S8DXBM
 yEya8g5Fvt+nWHNaW9mA7fmeyzNiCsndkHJXzF1c2eqI2Y6jbxXwt++mMAyjafCOS
 HOMpCgloW7D4wCXwDrII3B9PDayB6FW/TWNdS//PISXhA6CpwwTXCQAgA4ISa4gP6
 NL+cEYaFckUR6dWIEzfrodpz3uLqTMZa912/WqTi/k/KRhcVwWryGae/P1nHWYD8f
 pdHwW4UCosKG4azllntq82qn7Z58qYwCQcAz78xM8dkyGCajIjPz25PQA+WQnOiqT
 /+PVAsyPf+oIg7AY4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbFs-1sQC1P2NpW-00sh4Z; Thu, 23
 May 2024 18:26:25 +0200
Message-ID: <fc95549e-fd0b-462d-b290-2612de601297@gmx.de>
Date: Thu, 23 May 2024 18:26:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] efi: LoongArch: Implement everything
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240522-loongarch-v1-16-1407e0b69678@flygoat.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240522-loongarch-v1-16-1407e0b69678@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LnY6MoWxJhNrEPE3Y21SExlFpRuHlifaThC+iKSAJYIadbVSaAA
 J0dXR2M7UpXW9rxbe4IQ3IA08qN1JYTxmctxMoL53vY9XnqF4DbpgO2Xh94cmK9Cg9YYek0
 g3M3DGlFOe9TgvB25pB8Coof4seX5FWX7Zy5mZI41znQMfGam7UpFX6oA1b55ZlPryDC/Pu
 hkRf4HGkWDesx9q/JB5pw==
UI-OutboundReport: notjunk:1;M01:P0:X3oflwTx254=;xJclPxKfj1qd2JBeNvZpkrsWOGk
 /bUiLKrdQv1yBjLeL+eJc9KKysisOEvI4SuswUkdidcRqN0+Itn+PE6MDXcW25RkPMve1MzYk
 XVdj7ENa7Cv5hj4LYUmxBLD/nqX9suF16qUMgMYDj4k7G3It3wlE3015Du/bWv6us1Gd5W7GN
 hJcDMJK/tkcBvIMJsRccm10mfTkPg9qb9P4qshxmjjfrAUqYlQjd2nztUHpJBbDObvc+e1nFr
 J6SYl/t91eg5iydSbWdHc0qBy+CwJeCjlL3Pm8DPTAxTMjRx0l8efZZGrpaRGeHMc0dNDLmnA
 RPh5geEz/WQ1LXAuDRuOy6+d/VeR+o8Zk5qgSzIvEyxWXTMqvK5JIIqqGS3ZuCaZiPUql1/y3
 QXhhlHHhYMhCavd/DgDabKaXegLOXGNU283q2dSG66DiavKsenQKboBdsGb3ekd1Ney/ZFaN5
 Q2SUZViNjk+ZxSFVKTF/hhVnizN9pEOMiNvHX4TDvfb5ApoqZAq+9SW9mUls+04iQrYVexX/X
 7VrlPKzcWrguG6gMsQDKGPCZjKjnkKIAymZGpHcOPixyX2oapJIKCJaAYKDbyhrxkDp8QepUz
 kZCS8QPWrhVSWPfsxA4A8CEuXDB+sE51rA90naark0JfxxBaeQEq09lZimUnlgVtMq4Rd3YYG
 N5wmrVVZ5v5OxlXprr3Z+PRyRv5CKObbYabGx3F+8OAURC71zD05MFqB/H65NysPiL0ZKVjgW
 S6Lp8p4UO12L2lAjxm3VBz6coRhnvqz1v91wDYlakYeYuf984DFCwiqSw1MYXETCHdri0xATz
 036iOJtZIH3WxvIfwyfspIIic/B98nPbsUHC1Lh1q5REo=
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

On 22.05.24 17:34, Jiaxun Yang wrote:
> Implement crt, reloc, linker scripts, wire things up in
> Makefiles and Kconfig.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   arch/loongarch/config.mk                 |   4 +
>   arch/loongarch/lib/Makefile              |  12 ++
>   arch/loongarch/lib/crt0_loongarch_efi.S  | 182 +++++++++++++++++++++++=
++++++++
>   arch/loongarch/lib/elf_loongarch_efi.lds |  76 +++++++++++++
>   arch/loongarch/lib/reloc_loongarch_efi.c | 107 ++++++++++++++++++
>   lib/efi_loader/Kconfig                   |   2 +-
>   6 files changed, 382 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/config.mk b/arch/loongarch/config.mk
> index 7c247400e361..bae4566e9b62 100644
> --- a/arch/loongarch/config.mk
> +++ b/arch/loongarch/config.mk
> @@ -21,3 +21,7 @@ endif
>   PLATFORM_CPPFLAGS	+=3D -fpic
>   PLATFORM_RELFLAGS	+=3D -fno-common -ffunction-sections -fdata-sections
>   LDFLAGS_u-boot		+=3D --gc-sections -static -pie
> +
> +EFI_LDS				:=3D elf_loongarch_efi.lds
> +EFI_CRT0			:=3D crt0_loongarch_efi.o
> +EFI_RELOC			:=3D reloc_loongarch_efi.o
> diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
> index e65e66357a9b..17d2b1160b41 100644
> --- a/arch/loongarch/lib/Makefile
> +++ b/arch/loongarch/lib/Makefile
> @@ -12,3 +12,15 @@ ifeq ($(CONFIG_$(SPL_)SYSRESET),)
>   obj-y	+=3D reset.o
>   endif
>   obj-y	+=3D setjmp.o
> +
> +# For building EFI apps
> +CFLAGS_NON_EFI :=3D -fstack-protector-strong
> +CFLAGS_$(EFI_CRT0) :=3D $(CFLAGS_EFI)
> +CFLAGS_REMOVE_$(EFI_CRT0) :=3D $(CFLAGS_NON_EFI)
> +
> +CFLAGS_$(EFI_RELOC) :=3D $(CFLAGS_EFI)
> +CFLAGS_REMOVE_$(EFI_RELOC) :=3D $(CFLAGS_NON_EFI)
> +
> +extra-$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE) +=3D $(EFI_CRT0) $(EFI_RELOC)
> +extra-$(CONFIG_CMD_BOOTEFI_SELFTEST) +=3D $(EFI_CRT0) $(EFI_RELOC)
> +extra-$(CONFIG_EFI) +=3D $(EFI_CRT0) $(EFI_RELOC)
> diff --git a/arch/loongarch/lib/crt0_loongarch_efi.S b/arch/loongarch/li=
b/crt0_loongarch_efi.S
> new file mode 100644
> index 000000000000..5be47045ad8a
> --- /dev/null
> +++ b/arch/loongarch/lib/crt0_loongarch_efi.S
> @@ -0,0 +1,182 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * crt0-efi-loongarch.S - PE/COFF header for LoongArch EFI applications
> + *
> + * Copright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + */
> +
> +#include <asm-generic/pe.h>
> +#include <asm/asm.h>
> +
> +#ifdef __loongarch64
> +#define PE_MACHINE	IMAGE_FILE_MACHINE_LOONGARCH64
> +#define PE_MAGIC    IMAGE_NT_OPTIONAL_HDR64_MAGIC
> +#define IMG_CHARACTERISTICS \
> +	(IMAGE_FILE_EXECUTABLE_IMAGE | \
> +	 IMAGE_FILE_LINE_NUMS_STRIPPED | \
> +	 IMAGE_FILE_LOCAL_SYMS_STRIPPED | \
> +	 IMAGE_FILE_LARGE_ADDRESS_AWARE | \
> +	 IMAGE_FILE_DEBUG_STRIPPED)
> +#else
> +#define PE_MACHINE	IMAGE_FILE_MACHINE_LOONGARCH32
> +#define PE_MAGIC    IMAGE_NT_OPTIONAL_HDR32_MAGIC
> +#define IMG_CHARACTERISTICS \
> +	(IMAGE_FILE_EXECUTABLE_IMAGE | \
> +	 IMAGE_FILE_LINE_NUMS_STRIPPED | \
> +	 IMAGE_FILE_LOCAL_SYMS_STRIPPED | \
> +	 IMAGE_FILE_DEBUG_STRIPPED)
> +#endif
> +
> +	.section	.text.head
> +
> +	/*
> +	 * Magic "MZ" signature for PE/COFF
> +	 */
> +	.globl	ImageBase
> +ImageBase:
> +	.short	IMAGE_DOS_SIGNATURE		/* 'MZ' */
> +	.skip	58
> +	.long	pe_header - ImageBase		/* Offset to the PE header */
> +pe_header:
> +	.long	IMAGE_NT_SIGNATURE		/* 'PE' */
> +coff_header:
> +	.short	PE_MACHINE			/* LoongArch 64/32-bit */
> +	.short	3				/* nr_sections */
> +	.long	0				/* TimeDateStamp */
> +	.long	0				/* PointerToSymbolTable */
> +	.long	0				/* NumberOfSymbols */
> +	.short	section_table - optional_header	/* SizeOfOptionalHeader */
> +	.short	IMG_CHARACTERISTICS		/* Characteristics */
> +optional_header:
> +	.short	PE_MAGIC			/* PE32(+) format */
> +	.byte	0x02				/* MajorLinkerVersion */
> +	.byte	0x14				/* MinorLinkerVersion */
> +	.long	_edata - _start			/* SizeOfCode */
> +	.long	0				/* SizeOfInitializedData */
> +	.long	0				/* SizeOfUninitializedData */
> +	.long	_start - ImageBase		/* AddressOfEntryPoint */
> +	.long	_start - ImageBase		/* BaseOfCode */
> +#ifndef __loongarch64
> +	.long	0				/* BaseOfData */
> +#endif
> +
> +extra_header_fields:
> +	LONG	0
> +	.long	0x200				/* SectionAlignment */
> +	.long	0x200				/* FileAlignment */
> +	.short	0				/* MajorOperatingSystemVersion */
> +	.short	0				/* MinorOperatingSystemVersion */
> +	.short	1				/* MajorImageVersion */
> +	.short	0				/* MinorImageVersion */
> +	.short	0				/* MajorSubsystemVersion */
> +	.short	0				/* MinorSubsystemVersion */
> +	.long	0				/* Win32VersionValue */
> +
> +	.long	_edata - ImageBase		/* SizeOfImage */
> +
> +	/*
> +	 * Everything before the kernel image is considered part of the header
> +	 */
> +	.long	_start - ImageBase		/* SizeOfHeaders */
> +	.long	0				/* CheckSum */
> +	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION /* Subsystem */
> +#if CONFIG_VENDOR_EFI
> +	.short	0				/* DllCharacteristics */
> +#else
> +	.short	IMAGE_DLLCHARACTERISTICS_NX_COMPAT
> +#endif
> +	LONG	0				/* SizeOfStackReserve */
> +	LONG	0				/* SizeOfStackCommit */
> +	LONG	0				/* SizeOfHeapReserve */
> +	LONG	0				/* SizeOfHeapCommit */
> +
> +	.long	0				/* LoaderFlags */
> +	.long	0x6				/* NumberOfRvaAndSizes */
> +
> +	.quad	0				/* ExportTable */
> +	.quad	0				/* ImportTable */
> +	.quad	0				/* ResourceTable */
> +	.quad	0				/* ExceptionTable */
> +	.quad	0				/* CertificationTable */
> +	.quad	0				/* BaseRelocationTable */
> +
> +	/* Section table */
> +section_table:
> +
> +	/*
> +	 * The EFI application loader requires a relocation section
> +	 * because EFI applications must be relocatable.  This is a
> +	 * dummy section as far as we are concerned.
> +	 */
> +	.ascii	".reloc"
> +	.byte	0
> +	.byte	0			/* end of 0 padding of section name */
> +	.long	0
> +	.long	0
> +	.long	0			/* SizeOfRawData */
> +	.long	0			/* PointerToRawData */
> +	.long	0			/* PointerToRelocations */
> +	.long	0			/* PointerToLineNumbers */
> +	.short	0			/* NumberOfRelocations */
> +	.short	0			/* NumberOfLineNumbers */
> +	.long	0x42100040		/* Characteristics (section flags) */
> +
> +
> +	.ascii	".text"
> +	.byte	0
> +	.byte	0
> +	.byte	0			/* end of 0 padding of section name */
> +	.long	_etext - _start		/* VirtualSize */
> +	.long	_start - ImageBase	/* VirtualAddress */
> +	.long	_etext - _start		/* SizeOfRawData */
> +	.long	_start - ImageBase	/* PointerToRawData */
> +	.long	0			/* PointerToRelocations (0 for executables) */
> +	.long	0			/* PointerToLineNumbers (0 for executables) */
> +	.short	0			/* NumberOfRelocations  (0 for executables) */
> +	.short	0			/* NumberOfLineNumbers  (0 for executables) */
> +	/* Characteristics (section flags) */
> +	.long	(IMAGE_SCN_MEM_READ | \
> +		 IMAGE_SCN_MEM_EXECUTE | \
> +		 IMAGE_SCN_CNT_CODE)
> +
> +	.ascii	".data"
> +	.byte	0
> +	.byte	0
> +	.byte	0			/* end of 0 padding of section name */
> +	.long	_edata - _data		/* VirtualSize */
> +	.long	_data - ImageBase	/* VirtualAddress */
> +	.long	_edata - _data		/* SizeOfRawData */
> +	.long	_data - ImageBase	/* PointerToRawData */
> +	.long	0			/* PointerToRelocations */
> +	.long	0			/* PointerToLineNumbers */
> +	.short	0			/* NumberOfRelocations */
> +	.short	0			/* NumberOfLineNumbers */
> +	/* Characteristics (section flags) */
> +	.long	(IMAGE_SCN_MEM_WRITE | \
> +		 IMAGE_SCN_MEM_READ | \
> +		 IMAGE_SCN_CNT_INITIALIZED_DATA)
> +
> +	.align		12
> +	.globl	_start
> +	.type	_start, @function
> +_start:
> +	PTR_ADDI	sp, sp, -(3 * LONGSIZE)
> +	LONG_S		ra, sp, 0
> +	LONG_S		a0, sp, (1 * LONGSIZE)
> +	LONG_S		a1, sp, (2 * LONGSIZE)
> +
> +	move		a2, a0		/* a2: ImageHandle */
> +	move		a3, a1		/* a3: SystemTable */
> +	la.local	a0, ImageBase	/* a0: ImageBase */
> +	la.local	a1, _DYNAMIC	/* a1: DynamicSection */
> +	bl 	  	_relocate
> +	bnez		a0, 0f
> +
> +	LONG_L		a0, sp, (1 * LONGSIZE)
> +	LONG_L		a1, sp, (2 * LONGSIZE)
> +	bl		efi_main
> +
> +0:	LONG_L		ra, sp, 0
> +	PTR_ADDI	sp, sp, (3 * LONGSIZE)
> +	jr			ra
> +	.end	  _start
> diff --git a/arch/loongarch/lib/elf_loongarch_efi.lds b/arch/loongarch/l=
ib/elf_loongarch_efi.lds
> new file mode 100644
> index 000000000000..050e5a52a0b3
> --- /dev/null
> +++ b/arch/loongarch/lib/elf_loongarch_efi.lds
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: BSD-2-Clause */
> +/*
> + * U-Boot LoongArch
> + *
> + * Modified from arch/riscv/lib/elf_riscv64_efi.lds
> + */
> +
> +OUTPUT_ARCH(loongarch)
> +
> +PHDRS
> +{
> +	data PT_LOAD FLAGS(3); /* SHF_WRITE | SHF_ALLOC */
> +}
> +
> +ENTRY(_start)
> +SECTIONS
> +{
> +	.text 0x0 : {
> +		_text =3D .;
> +		*(.text.head)
> +		*(.text)
> +		*(.text.*)
> +		*(.gnu.linkonce.t.*)
> +		*(.srodata)
> +		*(.rodata*)
> +		. =3D ALIGN(16);
> +		*(.dynamic);
> +		. =3D ALIGN(512);
> +	}
> +	.rela.dyn : { *(.rela.dyn) }
> +	.rela.plt : { *(.rela.plt) }
> +	.rela.got : { *(.rela.got) }
> +	.rela.data : { *(.rela.data) *(.rela.data*) }
> +	_etext =3D .;
> +	_text_size =3D . - _text;
> +	. =3D ALIGN(4096);
> +	.data : {
> +		_data =3D .;
> +		*(.sdata)
> +		*(.data)
> +		*(.data1)
> +		*(.data.*)
> +		*(.got.plt)
> +		*(.got)
> +
> +		/*
> +		 * The EFI loader doesn't seem to like a .bss section, so we
> +		 * stick it all into .data:
> +		 */
> +		. =3D ALIGN(16);
> +		_bss =3D .;
> +		*(.sbss)
> +		*(.scommon)
> +		*(.dynbss)
> +		*(.bss)
> +		*(.bss.*)
> +		*(COMMON)
> +		. =3D ALIGN(512);
> +		_bss_end =3D .;
> +		_edata =3D .;
> +	} :data
> +	_data_size =3D _edata - _data;
> +
> +	. =3D ALIGN(4096);
> +	.dynsym   : { *(.dynsym) }
> +	. =3D ALIGN(4096);
> +	.dynstr   : { *(.dynstr) }
> +	. =3D ALIGN(4096);
> +	.note.gnu.build-id : { *(.note.gnu.build-id) }
> +	/DISCARD/ : {
> +		*(.rel.reloc)
> +		*(.eh_frame)
> +		*(.note.GNU-stack)
> +	}
> +	.comment 0 : { *(.comment) }
> +}
> diff --git a/arch/loongarch/lib/reloc_loongarch_efi.c b/arch/loongarch/l=
ib/reloc_loongarch_efi.c
> new file mode 100644
> index 000000000000..32a7d792103d
> --- /dev/null
> +++ b/arch/loongarch/lib/reloc_loongarch_efi.c

The code seems to be very similar for all architectures. I wonder if one
implementation could cover them all.

Best regards

Heinrich

> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* reloc_loongarch.c - position independent ELF shared object relocator
> +   Copyright (C) 2018 Alexander Graf <agraf@suse.de>
> +   Copyright (C) 2014 Linaro Ltd. <ard.biesheuvel@linaro.org>
> +   Copyright (C) 1999 Hewlett-Packard Co.
> +	Contributed by David Mosberger <davidm@hpl.hp.com>.
> +
> +    All rights reserved.
> +
> +    Redistribution and use in source and binary forms, with or without
> +    modification, are permitted provided that the following conditions
> +    are met:
> +
> +    * Redistributions of source code must retain the above copyright
> +      notice, this list of conditions and the following disclaimer.
> +    * Redistributions in binary form must reproduce the above
> +      copyright notice, this list of conditions and the following
> +      disclaimer in the documentation and/or other materials
> +      provided with the distribution.
> +    * Neither the name of Hewlett-Packard Co. nor the names of its
> +      contributors may be used to endorse or promote products derived
> +      from this software without specific prior written permission.
> +
> +    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
> +    CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
> +    INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> +    MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
> +    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
> +    BE LIABLE FOR ANYDIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
> +    OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
> +    PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
> +    PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> +    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> +    TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
> +    THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> +    SUCH DAMAGE.
> +*/
> +
> +#include <efi.h>
> +
> +#include <elf.h>
> +
> +#ifdef __loongarch64
> +#define Elf_Dyn		Elf64_Dyn
> +#define Elf_Rela	Elf64_Rela
> +#define ELF_R_TYPE	ELF64_R_TYPE
> +#else
> +#define Elf_Dyn		Elf32_Dyn
> +#defiggne Elf_Rela	Elf32_Rela
> +#define ELF_R_TYPE	ELF32_R_TYPE
> +#endif
> +
> +efi_status_t EFIAPI _relocate(long ldbase, Elf_Dyn *dyn)
> +{
> +	long relsz =3D 0, relent =3D 0;
> +	Elf_Rela *rel =3D 0;
> +	unsigned long *addr;
> +	int i;
> +
> +	for (i =3D 0; dyn[i].d_tag !=3D DT_NULL; ++i) {
> +		switch (dyn[i].d_tag) {
> +		case DT_RELA:
> +			rel =3D (Elf_Rela *)
> +				((unsigned long)dyn[i].d_un.d_ptr
> +					+ ldbase);
> +			break;
> +		case DT_RELASZ:
> +			relsz =3D dyn[i].d_un.d_val;
> +			break;
> +		case DT_RELAENT:
> +			relent =3D dyn[i].d_un.d_val;
> +			break;
> +		case DT_PLTGOT:
> +			addr =3D (unsigned long *)
> +				((unsigned long)dyn[i].d_un.d_ptr
> +					+ ldbase);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	if (!rel && relent =3D=3D 0)
> +		return EFI_SUCCESS;
> +
> +	if (!rel || relent =3D=3D 0)
> +		return EFI_LOAD_ERROR;
> +
> +	while (relsz > 0) {
> +		/* apply the relocs */
> +		switch (ELF_R_TYPE(rel->r_info)) {
> +		case R_LARCH_NONE:
> +			break;
> +		case R_LARCH_RELATIVE:
> +			addr =3D (unsigned long *)
> +				(ldbase + rel->r_offset);
> +			*addr +=3D ldbase;
> +			break;
> +		default:
> +			break;
> +		}
> +		rel =3D (Elf_Rela *)((char *)rel + relent);
> +		relsz -=3D relent;
> +	}
> +	return EFI_SUCCESS;
> +}
> +
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 430bb7f0f7dc..1d82a062a215 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -5,7 +5,7 @@ config EFI_LOADER
>   			SYS_CPU =3D arm1176 || \
>   			SYS_CPU =3D armv7   || \
>   			SYS_CPU =3D armv8)  || \
> -		X86 || RISCV || SANDBOX)
> +		X86 || RISCV || LOONGARCH || SANDBOX)
>   	# We need EFI_STUB_64BIT to be set on x86_64 with EFI_STUB
>   	depends on !EFI_STUB || !X86_64 || EFI_STUB_64BIT
>   	# We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
>

