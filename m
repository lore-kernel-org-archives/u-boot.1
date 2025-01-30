Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA9BC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 09:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A979481FAB;
	Thu, 30 Jan 2025 10:20:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LHpVS6EO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5BDA81FEE; Thu, 30 Jan 2025 10:20:11 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9843C80C85
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 10:20:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e398484b60bso1052736276.1
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 01:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738228808; x=1738833608; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nM5DrwdI4/MSRtRWCq1T/S1xg/wCSXq3G1vAEfaaJAo=;
 b=LHpVS6EOGYDg1gwivqik0KxNrI0dWo9vBBXleYgmwqP4+zMe1+10Hfd5N2rkWt++qF
 5TZJU/414R2nyxWC3xICB4wWhGhU/IWPizquzU50SqfSTE2GlT50zpC6a9V8VoAJTsyL
 ukm3ymBi25DSU0GljxanNCTUQoQdOLPrAcFFnXIm3fH/CqxudaZkgx/Mq5AeU8okEAWh
 9iulxgr8xAZj1/ckeP1Sy7fEstD9tWy+CqUqjjnxi0mzems2epAAdBOGNg1GBJe/g+4y
 sMOmO1JiS9mNCxZEgehj78iJpe7pkdlzKCl3IOU5+uwe2zoFPKP0eCA1T1LbtRfyiJRI
 m/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738228808; x=1738833608;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nM5DrwdI4/MSRtRWCq1T/S1xg/wCSXq3G1vAEfaaJAo=;
 b=X4SkGRgAxfUjO3Wd0+CJp4WmMcUnEqbIrWlpeA+BNydUdK43D+vuESa0UO4PwSeIat
 X2tnP9t58qen3nRtQD+WDrF/VxhJZ5qVRcpwgrl/RAPW9ws0aV48lLrIJkcmIyWg0eEh
 7lzB/PU7vNGdXfK+gcf9gxqla/7JhLtFlxgLS+pLDy1bgKN5+TGoUMi5uJTIOfP+21o5
 dvGHSuR7ZxLwUNmzCXkW4oQBl7/a8zrWHYVLYRtbn1stI1oEHWCLKI1+qexnCe9vEhU6
 PGYIHUNdjdKCxAg0Rlz0dP6FDBjeeh/2/c2HvmBvSFQl/dPClef+AMHyqkoEMRA77xod
 emfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa87gdr38HwVd5G2UM7JieY3bVqWoNzb3P1mR5nL0MBPEtKAWCvNgyoKrDGasjUWcpX/Mk11k=@lists.denx.de
X-Gm-Message-State: AOJu0YxXbrgEDUbOqE6BR+NLEQxkDXqqk+3am8S6YwYuzcDyoItlFAlI
 hIAzNVCMCYf90y4Ow8N/oTZ0O5Gy2aYaOi9p11k2vRP+EJczvpS42YXbbYY2zJxSsqtQ90+pzzb
 PIrRAJAuFmAGUzmr5yJ1WQLdnYchzeXRa6GxZAw==
X-Gm-Gg: ASbGnctBFwsCSTbvQftC7eqKcmIokOrDy10Z3IYfzG+pN7coz37w/cSw60pkn9I0Mfg
 7PnKlFDuVMU0C+zAmwhQSSaF9PIyPU1UYKddTxNeDvZBW50A+GcOTsrEqtenawGUBz/jus0h4
X-Google-Smtp-Source: AGHT+IE/Nbt6XIjD87EmdytweuJNPZZWcJExt9w8iAWpGTsn/WIHZovFFDRICJRj3z3lr/AA8KXdt4bpDAOxM/sSjXA=
X-Received: by 2002:a05:6902:128a:b0:e58:1501:23a7 with SMTP id
 3f1490d57ef6-e58a4a9c792mr4595271276.10.1738228808297; Thu, 30 Jan 2025
 01:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <20250130072100.27297-3-ilias.apalodimas@linaro.org>
 <21b86615-7538-4a65-b12d-1ef86f4861de@linaro.org>
In-Reply-To: <21b86615-7538-4a65-b12d-1ef86f4861de@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 Jan 2025 11:19:32 +0200
X-Gm-Features: AWEUYZluSXhoYlnaAlxEukbvyF4YxF2p0NbIGk813CQBL6Y7z8OYficB37-Oe6I
Message-ID: <CAC_iWj+0rYANKZRSxDe6GYEdJmQOfERZcE6rAcOxk-3HPzB_Qg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] arm: Prepare linker scripts for memory permissions
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: maz@kernel.org, trini@konsulko.com, CFSworks@gmail.com, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Sam Day <me@samcday.com>, Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Michal Simek <michal.simek@amd.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Thu, 30 Jan 2025 at 11:09, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Ilias,
>
> On 1/30/25 08:20, Ilias Apalodimas wrote:
> > Upcoming patches are switching the memory mappings to RW, RO, RW^X page
> > permissions after the U-Boot binary and its data are relocated. Add
> > annotations in the linker scripts to and mark text, data, rodata etc
> > sections and align them to a page boundary
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  Makefile                       | 15 +++++++++------
> >  arch/arm/cpu/armv8/u-boot.lds  | 32 +++++++++++++++++++-------------
> >  include/asm-generic/sections.h |  2 ++
> >  lib/efi_loader/efi_runtime.c   |  2 ++
> >  4 files changed, 32 insertions(+), 19 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 33bb86343c5b..8d7c062ec830 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2176,13 +2176,16 @@ System.map:   u-boot
> >  # ARM relocations should all be R_ARM_RELATIVE (32-bit) or
> >  # R_AARCH64_RELATIVE (64-bit).
> >  checkarmreloc: u-boot
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
>
> s/false/exit 1/ otherwise the loop won't break and make won't get a
> failure status unless the error is on the last reloc.
>
> > +             fi; \
> > +     done
>
> This Makefile change seems unrelated to the current patch. Should it
> go into a separate fixup patch?
>
> >  tools/version.h: include/version.h
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
> >                  __efi_runtime_stop = .;
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
> >  #ifdef CONFIG_ARMV8_PSCI
> > @@ -98,27 +101,30 @@ SECTIONS
> >       }
> >  #endif
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
> >                  __efi_runtime_rel_start = .;
> >               *(.rel*.efi_runtime)
> >               *(.rel*.efi_runtime.*)
> > +             . = ALIGN(4096);
> >                  __efi_runtime_rel_stop = .;
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
> >  extern char __entry_text_start[], __entry_text_end[];
> >  extern char __initdata_begin[], __initdata_end[];
> >  extern char __start_rodata[], __end_rodata[];
> > +extern char __start_data[], __end_data[];
> >  extern char __efi_helloworld_begin[];
> >  extern char __efi_helloworld_end[];
> >  extern char __efi_var_file_begin[];
> > @@ -63,6 +64,7 @@ static inline int arch_is_kernel_data(unsigned long addr)
> >
> >  /* Start of U-Boot text region */
> >  extern char __text_start[];
> > +extern char __text_end[];
> >
> >  /* This marks the text region which must be relocated */
> >  extern char __image_copy_start[], __image_copy_end[];
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
> It looks like this may need to go into the same fixup patch as the
> Makefile changes above.
>
> >               case R_RELATIVE:
> >  #ifdef IS_RELA
> >               newaddr = rel->addend + offset - CONFIG_TEXT_BASE;
>
> For the linker script changes:

All of these are needed in a single patch. The alignment changes
trigger the emitted R_AARCH64_NONE relocs.

Cheers
/Ilias
>
> Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
