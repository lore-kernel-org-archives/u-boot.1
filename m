Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F04C02190
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 10:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 147BF81F69;
	Thu, 30 Jan 2025 11:31:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NRbzjQXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14E1B82012; Thu, 30 Jan 2025 11:31:01 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C59DB80C85
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 11:30:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e580d6211c8so1183806276.1
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 02:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738233057; x=1738837857; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zFfx6bzwH6AmTgbCnIGSAVe5dqt0tW6ZupvyXBkhIcY=;
 b=NRbzjQXXtJ6oc8xqHYxynWtV5rtOacSNFdVDvEBDMRiVT80GVu+YyYWMpoVMq1rb2Z
 sHD9ItUchfFOKbZ83AUMa9KdGmdaqSpnEzNoUio8EDIh5/xNm7lbbw5s7vjBk4TgOaNe
 hThX1aGFpa9ZtErz7OlYWz/zDF+h1vZzWd+Me3Ujv62cdVpVF11ThfiTCSGB+1qsWH9d
 WDECeo7AOWGpuE2rPQTM96G/inx2ASIazBOZyJhQgAg2TowQqH8zM/NdAYYaOREKOlKs
 DNrXHMUk0PT8H1nE2hOWCdSmWU4E6ZX8bPRJzbcsCdCz1z0xIFkzvn7QIiiX6ddS1QTR
 mWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738233057; x=1738837857;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zFfx6bzwH6AmTgbCnIGSAVe5dqt0tW6ZupvyXBkhIcY=;
 b=d9oUp5dllJjjnWkf6MRQQJFSOw5szbXWgea1uvxVimSRmHuFcbVutuMSMkJcx7+LPp
 QSG5ZoaYBjMjiEz1Z1qiqF9Bn0geyAQKu6Oevay3xLk1x+Tk+UWztnK01ULVvnQgKxWT
 l/U01Git9+stp3M1RgqFqKrR7VsrB7Y7SS93vFJ3PnGwV3cW2u2/hdQVSQvbPC8zE+g5
 3Amxsxt/+0Nqzx8Q+4Tkkei1mV1SgqQvpxlGV9sVhSDHb2mCIGvMLj4w+Jr35T6X030y
 mL3r4A0KD+EEWxMQrwHmKTbbe1+hTux7IPO4ebNGucM5Sg01kG1JZwMKWrtCGa2N4l98
 F3ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUofP+EiZ8PdEiNgZyElmjEfj9yFEkG5ouUrOHpFlsDc3t4Thc4sHndYcLCqee9qQyi16wxeqE=@lists.denx.de
X-Gm-Message-State: AOJu0YwmiFxlI1sfoRllzV1AsXEfz0dasO05bdpHIGfh9x6H18PU/6ze
 ve3NA1EICJxaLoCZ8oV8h7E3QmRRobicGfSrc+OBTcT4W5yWqBdu4evzpo/ekUflw54NmFsMD2a
 ttLx+4KK3pn1Bg2qo2Ki3tLq7ArtvuvAk0GETbA==
X-Gm-Gg: ASbGncvwQPw8Sl4rpFKcfuGe4invwYGlaSUMqEjVJ8bzA7STKFju32SpdPupIEALPxu
 qSlFGRQlOGsZUYz43gN79v3eR8xBswdwW0+VpfQ9DWEPvTi1ezsVS5vkVzcXqPDa02cYtG+vG
X-Google-Smtp-Source: AGHT+IF+m8EuPTMIxF78p4ato7nTetmUryfJvHQPOVyZ8kKiJPT1Zta1mqAclkQ033OESdCy1qAwoM5f8vX3tgju9aM=
X-Received: by 2002:a05:6902:e82:b0:e56:7cf6:7b49 with SMTP id
 3f1490d57ef6-e58a4bd7ecbmr4742921276.38.1738233056956; Thu, 30 Jan 2025
 02:30:56 -0800 (PST)
MIME-Version: 1.0
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <20250130072100.27297-3-ilias.apalodimas@linaro.org>
 <1c795dd4-9074-434a-afb5-4bf4b35a04b3@gmx.de>
In-Reply-To: <1c795dd4-9074-434a-afb5-4bf4b35a04b3@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 Jan 2025 12:30:21 +0200
X-Gm-Features: AWEUYZnglnFCXSTY5efOZSddQKeAQMjX-49qIu8hAibSSS34QHGOLZUy_vfNfNw
Message-ID: <CAC_iWj+M+eBJ3mr5UNzXRd5EBiXXfdzjz+S-Y47nBf3qR8-+Uw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] arm: Prepare linker scripts for memory permissions
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Sam Day <me@samcday.com>, Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, 
 maz@kernel.org, trini@konsulko.com, CFSworks@gmail.com
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

Hi Heinrich

On Thu, 30 Jan 2025 at 12:08, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 1/30/25 07:20, Ilias Apalodimas wrote:
> > Upcoming patches are switching the memory mappings to RW, RO, RW^X page
>
> RWX, RO, RW?

RW, RX, RO :)

>
> > permissions after the U-Boot binary and its data are relocated. Add
> > annotations in the linker scripts to and mark text, data, rodata etc
> > sections and align them to a page boundary
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   Makefile                       | 15 +++++++++------
> >   arch/arm/cpu/armv8/u-boot.lds  | 32 +++++++++++++++++++-------------
> >   include/asm-generic/sections.h |  2 ++
> >   lib/efi_loader/efi_runtime.c   |  2 ++
> >   4 files changed, 32 insertions(+), 19 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 33bb86343c5b..8d7c062ec830 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2176,13 +2176,16 @@ System.map:   u-boot
> >   # ARM relocations should all be R_ARM_RELATIVE (32-bit) or
> >   # R_AARCH64_RELATIVE (64-bit).
> >   checkarmreloc: u-boot
> > -     @RELOC="`$(CROSS_COMPILE)readelf -r -W $< | cut -d ' ' -f 4 | \
> > +     @RELOCS="`$(CROSS_COMPILE)readelf -r -W $< | cut -d ' ' -f 4 | \
> >               grep R_A | sort -u`"; \
> > -     if test "$$RELOC" != "R_ARM_RELATIVE" -a \
> > -              "$$RELOC" != "R_AARCH64_RELATIVE"; then \
> > -             echo "$< contains unexpected relocations: $$RELOC"; \
> > -             false; \
> > -     fi
> > +     for reloc in $$RELOCS; do \
> > +             if [ "$$reloc" != "R_ARM_RELATIVE" -a \
> > +                  "$$reloc" != "R_AARCH64_RELATIVE" -a \
> > +             "$$reloc" != "R_AARCH64_NONE" ]; then \
> > +                     echo "$< contains unexpected relocations: $$reloc"; \
> > +                     false; \
> > +             fi; \
> > +     done
>
> This seems to be an unrelated change that should go into a separate patch.

It's not, R_AARCH64_NONE relocation are emitted now due to the section
alignments.

>
> >
> >   tools/version.h: include/version.h
> >       $(Q)mkdir -p $(dir $@)
> > diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> > index 857f44412e07..18e168e27135 100644
> > --- a/arch/arm/cpu/armv8/u-boot.lds
> > +++ b/arch/arm/cpu/armv8/u-boot.lds
> > @@ -22,7 +22,7 @@ SECTIONS
> >
> >       . = ALIGN(8);
> >       __image_copy_start = ADDR(.text);
> > -     .text :
> > +     .text ALIGN(4096):
> >       {
> >               CPUDIR/start.o (.text*)
> >       }
> > @@ -36,9 +36,12 @@ SECTIONS
> >                   __efi_runtime_stop = .;
> >       }
> >
> > -     .text_rest :
> > +     .text_rest ALIGN(4096) :
> >       {
> > +             __text_start = .;
> >               *(.text*)
> > +             . = ALIGN(4096);
> > +             __text_end = .;
> >       }
> >
> >   #ifdef CONFIG_ARMV8_PSCI
> > @@ -98,27 +101,30 @@ SECTIONS
> >       }
> >   #endif
> >
> > -     . = ALIGN(8);
> > -     .rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
> > +     .rodata ALIGN(4096): {
> > +         __start_rodata = .;
> > +         *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
> > +         . = ALIGN(4096);
> > +         __end_rodata = .;
> > +     }
> >
> > -     . = ALIGN(8);
> > -     .data : {
> > +     .data ALIGN(4096) : {
> > +         __start_data = .;
> >               *(.data*)
> > +         . = ALIGN(4096);
> > +         __end_data = .;
> >       }
> >
> > -     . = ALIGN(8);
> > -
> > -     . = .;
> > -
> >       . = ALIGN(8);
> >       __u_boot_list : {
> >               KEEP(*(SORT(__u_boot_list*)));
> >       }
> >
> > -     .efi_runtime_rel : {
> > +     .efi_runtime_rel ALIGN(4096) : {
> >                   __efi_runtime_rel_start = .;
> >               *(.rel*.efi_runtime)
> >               *(.rel*.efi_runtime.*)
> > +             . = ALIGN(4096);
> >                   __efi_runtime_rel_stop = .;
> >       }
> >
> > @@ -136,10 +142,10 @@ SECTIONS
> >       /*
> >        * arch/arm/lib/crt0_64.S assumes __bss_start - __bss_end % 8 == 0
> >        */
> > -     .bss ALIGN(8) : {
> > +     .bss ALIGN(4096) : {
> >               __bss_start = .;
> >               *(.bss*)
> > -             . = ALIGN(8);
> > +             . = ALIGN(4096);
> >               __bss_end = .;
> >       }
> >
> > diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> > index b6bca53db10d..5626df796f33 100644
> > --- a/include/asm-generic/sections.h
> > +++ b/include/asm-generic/sections.h
> > @@ -23,6 +23,7 @@ extern char __kprobes_text_start[], __kprobes_text_end[];
> >   extern char __entry_text_start[], __entry_text_end[];
> >   extern char __initdata_begin[], __initdata_end[];
> >   extern char __start_rodata[], __end_rodata[];
> > +extern char __start_data[], __end_data[];
> >   extern char __efi_helloworld_begin[];
> >   extern char __efi_helloworld_end[];
> >   extern char __efi_var_file_begin[];
> > @@ -63,6 +64,7 @@ static inline int arch_is_kernel_data(unsigned long addr)
> >
> >   /* Start of U-Boot text region */
> >   extern char __text_start[];
> > +extern char __text_end[];
> >
> >   /* This marks the text region which must be relocated */
> >   extern char __image_copy_start[], __image_copy_end[];
> > diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> > index 35eb6a777665..c10a79301a92 100644
> > --- a/lib/efi_loader/efi_runtime.c
> > +++ b/lib/efi_loader/efi_runtime.c
> > @@ -742,6 +742,8 @@ void efi_runtime_relocate(ulong offset, struct efi_mem_desc *map)
> >                     rel->info, *p, rel->offset);
> >
> >               switch (rel->info & R_MASK) {
> > +             case 0:
> > +                     break;
>
> This seems to be an unrelated patch that should be in a separate patch.

Same as above

Cheers
/Ilias
>
> Best regards
>
> Heinrich
>
> >               case R_RELATIVE:
> >   #ifdef IS_RELA
> >               newaddr = rel->addend + offset - CONFIG_TEXT_BASE;
>
