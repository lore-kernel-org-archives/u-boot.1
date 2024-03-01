Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB05C5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 13:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D289E8813D;
	Fri,  1 Mar 2024 14:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b86l49YH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7F7C88136; Fri,  1 Mar 2024 14:14:40 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E5A088143
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 14:14:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51325c38d10so1542744e87.1
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 05:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709298878; x=1709903678; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3SW6z0QnDAG2v+i5n2WwGOMA7XmfbGrSmqy6hamAW6w=;
 b=b86l49YHYjvHJtkdxEOmMxrXeg4Nb4l1Ii+jAtUYbjhqdKuBfGWBepqE/Uoi5415mC
 hgvp83b+r8O6W5gNzm5ICE8jvkYDI1OOmwRtPyqlveI998PO3DuYwwqgZb/VEL10BtRw
 wrVKetmgDmoQxwqvEgomUQk2dVJmQMePJ+bWrojeyOpNn8TQWdVsxRPWIfrI/KwC+g54
 jV/K32StkwQMTOe+Bs4ecypLswk2KLiBx0VyYM5sV1YugNJBy4lgqcbAX2iRL/+Banrh
 o5TPNmU0HrPpnGo9mIcyCeN9Ghdm+JZQyX/ODc+3ftiSz6GiUc/LTiDCN37uLhzUA2kr
 NSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709298878; x=1709903678;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3SW6z0QnDAG2v+i5n2WwGOMA7XmfbGrSmqy6hamAW6w=;
 b=X0vfWk4U2ZnQ1q5wdhSROyaqaGbBxDtQrqpNl/MBi5oDhOad3UN3zAGrMEPFbxgUWB
 3r2ubeqBYvo/FHYYvP5XoL1DB8M2GKhUIzZb1yQq+IEoYJaYWcvuBnnAWXb+cjn8/ciR
 f2rwm37FOIOfmQ97dO7eE4z+5FzUtdjUPaMjsIv1s+HQFsDjmK23THAYpuZIWwwg89sf
 LlGvitNsH0gaI7lghRqmFvOma/oL6Y2LypoWftmczJ+WINsOl1eYST3PNOrZ9857CUAb
 +ZTXfMV8rBdVTmQKbq4OI2vvXLKYzvroW5lH8dfUsBMvdpHksSPF0Ct22hwwgp73vDf+
 6m9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2ACD6e6L4+HixcDd/EkcnNhxFwPirZQyTnUZpHffu3XQkhrHcVvMcnISsPtiMIrvDLyKL8EWHelbsVADDhp9T46Qycw==
X-Gm-Message-State: AOJu0YyUZAEOf0a1nJenrJQFYMLPmR7xdeDmw8QFJt4pRuaxYEi9PXsV
 PrHSCY5dP42435LWOznbE9I++4F5ByNeGfn2y3X4VLQsZo7oovg/GpbZtBgqMNu+OYQzsb3ClAn
 EtLNmxnp2hhgBeRF84FGWQj+2rvjlWHnDtNHL8Q==
X-Google-Smtp-Source: AGHT+IEbG1oaH+0R8mmv/e2EVkokIwYcJ1xYTU7MVv2yqMQXWNz9mvgCC5hSw2prBKIuQjgT5bM/ZPLTwvv357Jba1k=
X-Received: by 2002:a05:6512:360a:b0:512:eb14:2ada with SMTP id
 f10-20020a056512360a00b00512eb142adamr698397lfs.0.1709298877638; Fri, 01 Mar
 2024 05:14:37 -0800 (PST)
MIME-Version: 1.0
References: <20240228104811.1366694-1-ilias.apalodimas@linaro.org>
 <CALeDE9OGc5ePPThdHc7RwUGkp67HGjZJZwq8GhtwGSBPXRYXWQ@mail.gmail.com>
 <CAC_iWjKAyUs2JrYN9OLrNKaOyChigdi7QH_780ZbXtRSFH2icw@mail.gmail.com>
 <c0c1387a-8bc2-450d-a9f1-5106ac83d67f@gmail.com>
In-Reply-To: <c0c1387a-8bc2-450d-a9f1-5106ac83d67f@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 1 Mar 2024 15:14:01 +0200
Message-ID: <CAC_iWjKa75G=Sp6WuTv5=BFFB0HwL8P1CxtTnaRoLX2tdR+wOQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Clean up arm linker scripts
To: Sam Edwards <cfsworks@gmail.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, caleb.connolly@linaro.org, sumit.garg@linaro.org, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Michal Simek <michal.simek@amd.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shiji Yang <yangshiji66@outlook.com>,
 Bin Meng <bmeng@tinylab.org>
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

Thanks Sam

On Thu, 29 Feb 2024 at 23:07, Sam Edwards <cfsworks@gmail.com> wrote:
>
>
>
> On 2/28/24 04:15, Ilias Apalodimas wrote:
> > On Wed, 28 Feb 2024 at 13:11, Peter Robinson <pbrobinson@gmail.com> wrote:
> >>
> >> On Wed, 28 Feb 2024 at 10:58, Ilias Apalodimas
> >> <ilias.apalodimas@linaro.org> wrote:
> >>>
> >>> The arm linker scripts had a mix of symbols and C defined variables in an
> >>> effort to emit relative references instead of absolute ones e.g [0].
> >>> This has led to confusion over the years, ending up with mixed section
> >>> definitions. Some sections being defined with overlays and different
> >>> definitions between v7 and v8 architectures.
> >>> For example __efi_runtime_rel_start/end is defined as a linker symbol for
> >>> armv8 and a C variable in armv7.
> >>>
> >>> I am not sure if this used to be a compiler bug, but linker scripts nowadays
> >>> can emit relative references, as long as the symbol definition is contained
> >>> within the section definition. So let's switch most of the C defined variables
> >>
> >> Should we be setting/upping the minimum version of the linker version
> >> as part of this?
> >
> > The patch that added those as C-defined variables, was in 2013. So any
> > linker that's not ancient history should emit those correctly.
> >
>
> GNU ld fixed the problem on 2016-02-23, with this entry in the bfd
> changelog:
>
>         * elflink.c (bfd_elf_record_link_assignment): Check for shared
>         library, instead of PIC, and don't check PDE when making linker
>         assigned symbol dynamic.
>
> It looks like the change was first included in binutils 2.27, released
> 2016-08-03. I don't know where the minimum linker version requirement is
> memorialized but there's a good chance that U-Boot already requires a
> version more recent than that. (Someone who knows where that is will
> have to check.)

Ok, this is useful. Thanks for digging it up. I'll update the commit
messages on the next version.

>
> In either case, I strongly agree: sections.c is an unnecessary
> workaround with any reasonably recent linker version, it's
> fickle/incompatible with non-GNU linkers such as LLD, and the marker
> symbols belong in the linker script. This patchset is a big step in the
> right direction!

Yes and the only reason I haven't removed secure_start/end etc, is
that I don't have a platform to test.
So I'd rather land this first and then clean up the remaining 5
entries of sections.c (and the file itself)

Cheers
/Ilias
>
> >
> >>
> >>> and clean up the arm sections.c file. There's still a few symbols remaining --
> >>> __secure_start/end, __secure_stack_start/end and __end which can be cleaned up
> >>> in a followup series.
> >>>
> >>> The resulting binary (tested in QEMU v7/v8) had no size differences apart from
> >>> the emited sections and object types of those variables. I've also added prints
> >>> throughout the U-Boot init sequence. The offsets and delta for 'end - start'
> >>> section sizes is unchanged.
> >>>
> >>> For example on QEMU v8:
> >>> $~ ./scripts/bloat-o-meter u-boot u-boot.new
> >>> add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
> >>> Function                                     old     new   delta
> >>> Total: Before=798861, After=798861, chg +0.00%
> >>>
> >>> $~ readelf -sW u-boot | grep bss_s
> >>>      12: 00000000001029b8     0 SECTION LOCAL  DEFAULT   12 .bss_start
> >>>    8088: 0000000000000018     0 NOTYPE  GLOBAL DEFAULT    1 _bss_start_ofs
> >>>    8376: 00000000001029b8     0 OBJECT  GLOBAL DEFAULT   12 __bss_start
> >>> $~ readelf -sW u-boot.new | grep bss_s
> >>>    8085: 0000000000000018     0 NOTYPE  GLOBAL DEFAULT    1 _bss_start_ofs
> >>>    8373: 00000000001029b8     0 NOTYPE  GLOBAL DEFAULT   12 __bss_start
> >>>
> >>> For QEMU v7 the differences are a bit bigger but only affect the variables
> >>> placed in the .bss section because that was defined as an OVERLAY in the
> >>> existing linker script.
> >>> For example:
> >>> $~ nm u-boot | grep tftp_prev_block
> >>> 000ca0dc ? tftp_prev_block
> >>> $~ nm u-boot.new | grep tftp_prev_block
> >>> 000e0a5c b tftp_prev_block -----> The symbol is now placed into .bss
> >>>
> >>> It's worth noting that since the efi regions are affected by the change, booting
> >>> with EFI is preferable while testing. Booting the kernel only should be enough
> >>> since the efi stub and the kernel proper do request boottime and runtime
> >>> services respectively.
> >>> Something along the lines of
> >>>> virtio scan && load virtio 0 $kernel_addr_r Image && bootefi $kernel_addr_r
> >>> will work for QEMU aarch64.
> >>>
> >>> Tested platforms:
> >>> - QEMU aarch64
> >>> - Xilinx kv260 kria starter kit & zynq
> >>> - QEMU armv7
> >>> - STM32MP157C-DK2
> >>>
> >>> [0] commit 3ebd1cbc49f0 ("arm: make __bss_start and __bss_end__ compiler-generated")
> >>>
> >>> Ilias Apalodimas (6):
> >>>    arm: baltos: remove custom linker script
> >>>    arm: clean up v7 and v8 linker scripts for bss_start/end
> >>>    arm: fix __efi_runtime_rel_start/end definitions
> >>>    arm: clean up v7 and v8 linker scripts for __rel_dyn_start/end
> >>>    arm: fix __efi_runtime_start/end definitions
> >>>    arm: move image_copy_start/end to linker symbols
> >>>
> >>>   arch/arm/cpu/armv8/u-boot-spl.lds         |  14 +--
> >>>   arch/arm/cpu/armv8/u-boot.lds             |  45 ++------
> >>>   arch/arm/cpu/u-boot.lds                   |  74 +++----------
> >>>   arch/arm/lib/sections.c                   |  10 --
> >>>   arch/arm/mach-rockchip/u-boot-tpl-v8.lds  |  22 +---
> >>>   arch/arm/mach-zynq/u-boot.lds             |  72 +++---------
> >>>   board/qualcomm/dragonboard820c/u-boot.lds |  41 ++-----
> >>>   board/vscom/baltos/u-boot.lds             | 128 ----------------------
> >>>   include/asm-generic/sections.h            |   3 +
> >>>   lib/efi_loader/efi_runtime.c              |   1 +
> >>>   10 files changed, 58 insertions(+), 352 deletions(-)
> >>>   delete mode 100644 board/vscom/baltos/u-boot.lds
> >>>
> >>> --
> >>> 2.37.2
> >>>
