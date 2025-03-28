Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F195C3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4A8981F00;
	Fri, 28 Mar 2025 13:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CgYITRxd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F13DC805C8; Fri, 28 Mar 2025 12:34:43 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6F15805C8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 12:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so405927866b.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 04:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743161681; x=1743766481; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WOW+WKUUNc+YjYo4cboqEstBazuLYny0sHLema/4kWs=;
 b=CgYITRxduZVPOsAwJmJUlcJdg3K33AbQ3ohJXRu/ItiYEwlB8Nm5N97A4SbbFP321q
 P1jSSi0j4jTBEwE23YQQM9yC7eTQXGfxq0YGqRf1OUdaPS+D2TgbYleOw9YhfT+qmlGb
 dd8h9daPrflLJjfbvYFxnh0ON7ZrYW7/buOaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743161681; x=1743766481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WOW+WKUUNc+YjYo4cboqEstBazuLYny0sHLema/4kWs=;
 b=R8DVZPObpo3qIO8biwYgJSGNehuyl/dYdUikfYt3x89Ic8uu7F/wux61ZipXoptnDC
 wQT8EnwvcYf550bwIheffapbTQBb0Nw/tpXnO6hthByhFoLI3MnLMPZKeiPqNKKBj47e
 q6QmDtdE+9xU572reiIHQyuzv+2A+tLlOlS4suMNkSTNKT5iSjcbzb30fTv+YvwqyAr/
 SUoYSHnrrfaRNulWj1tpzHro6UY0NVH+xwakhFJyObqoV+Q/92aJw619RUR7QB3r6QKi
 DVLgN3eMo3sqkqSFfC7+B2lzD8kFHJ7/BCW0Qxj6w5k0pk188+cGncqHrYvxoVy6MZjG
 maBg==
X-Gm-Message-State: AOJu0YyJU1Bo338ByUGwZUi3jZZGK+vQko1kkWfE4qd/pwGyTlCMV6tn
 wQcw3cJP/Seb+BbyIefpe1jRIlrrbcORZ6w1nSCtsrr+wa2zWuZqtB6ICvgwL765YavafdtGx91
 uPjy7rvRka9u22lxKREUaqXEvQvlJHrHfgln2
X-Gm-Gg: ASbGnctQJPLYrv42UBSfFv7ZPLmY1SUsWQBzWcq+0mJZk4K1jKlzCqUT4h3bCaK69Qr
 F2n4SGKjphFnK0OWJ/wVfISZjWEZAq238T4Shf8zSNBndY8w5roPJR7CqPAaT0i3rgIcN9jBGgb
 dPQGwpQbRr1WWMAeXRe1hdh6TE6Pc=
X-Google-Smtp-Source: AGHT+IEhGmV5Ztcs5wfv48n3okDgplxTmqXIHx3fwtYrYb/XT+uLZ+IdG43tmuq+P+RooVc3yHbfzKhLzVXBgi3TFZk=
X-Received: by 2002:a17:906:f59d:b0:ac3:2d47:f6af with SMTP id
 a640c23a62f3a-ac6faeb1b91mr729494966b.20.1743161680922; Fri, 28 Mar 2025
 04:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250215032254.4121030-1-sjg@chromium.org>
 <0476a23e-3de6-4619-b2f1-d2be7765e23d@linaro.org>
In-Reply-To: <0476a23e-3de6-4619-b2f1-d2be7765e23d@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 05:34:28 -0600
X-Gm-Features: AQ5f1JqeAWV9r2c3SE0lBue_sBY_1HAhAI_mxZQOi-zrAb8z8vm_zp6EDEomRiI
Message-ID: <CAFLszTjqRqe+9jCS7hfK1NOTDZdudv3zBoLuoPSCGqXs1mSBfQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/29] arm: Support building as an EFI app
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <agust@denx.de>, Angelo Dureghello <angelo@kernel-space.org>,
 Anton Bambura <jenneron@protonmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Greg Malysa <greg.malysa@timesys.com>, Janne Grunau <j@jannau.net>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Masahiro Yamada <masahiroy@kernel.org>, Matthew Garrett <mgarrett@aurora.tech>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <contact@paulk.fr>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Weinberger <richard@nod.at>, 
 Rick Chen <rick@andestech.com>, Sam Edwards <CFSworks@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>, 
 Trevor Woerner <twoerner@gmail.com>, Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 28 Mar 2025 13:42:48 +0100
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

Hi Caleb,

On Thu, 27 Mar 2025 at 11:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 2/15/25 04:22, Simon Glass wrote:
> > The original x86 EFI-app was written back in 2015, about a year before
> > the EFI-loader was introduced. At that point, ARM mostly used U-Boot and
> > FIT (Flat Image Tree).
> >
> > Today, sadly, there are a few efforts to re-invent FIT poorly, to cater
> > to more primitive boot-environments than U-Boot. One justification for
> > this re-invetion has been that EDK2 did not support FIT.
> >
> > EDK2 does now support FIT but only for the firmware stage. Even then,
> > vendors tend to use their own forks, so any new features are slow to
> > make it into the market.
> >
> > EDK2 also supports the ext4 filesystem, but many devices don't include
> > that feature, so most distros make use of FAT for storing their boot
> > files. Since FAT is not journalled, it is not particularly reliable in
> > the face of reset, power failure, etc.
> >
> > As an interim measure, we can use U-Boot as an EFI app running on top of
> > whatever EDK2 fork is in use. This allows use of modern features such as
> > FIT and filesystems other than FAT. So far this only supports x86, but
> > recent ARM laptops are making use of EFI too.
> >
> > So this series adds an EFI app for 64-bit ARM.
>
> It also does a lot of small tangential cleanup (and is kinda big). Could
> you send patches 2, 3, 11 and 12 separately? These are all sensible in
> their own right (and would help with EFI stub as well).
>
> A looot of the later patches look like they can be squashed too, as-is I
> don't think this series is bisect-safe (which in fairness would probably
> only affect someone who is actually building the EFI app, but even so).
>
> I'm looking forward to getting all this EFI loader stuff in better shape
> for when I finally get back around to working on the EFI stub support
> for ARM, so happy to see this cleanup.

OK good.

BTW I'm not sure what you mean by the cleanup patches, but they are
only needed by this series and wouldn't have much motivation
otherwise.

There is definitely work to do on the EFI loader side so I look
forward to seeing your patches.

For now, the app boots Linux, but we don't have CI tests, etc.

>
> Kind regards,
> >
> > Note: Since U-Boot does not support EFI's GOP 'blt-only' mode, the
> > vidconsole does not operate, but it can still be used, since EDK2
> > handles drawing instead of U-Boot. As a result, the U-Boot logo is not
> > shown.
> >
> > Changes in v4:
> > - Got back to depending on HAVE_TEXT_BASE
> > - Drop the confusing comment about position-independent code
> > - Put EFI_LDS back as it is required for building helloword.efi etc.
> > - Put the config.mk changes in the board directory
> >
> > Changes in v3:
> > - Use the same copyright message as the original pci_rom.c file
> > - Rewrite the commit message
> > - Drop setting of EFI_LDS and rely on the CONFIG_SYS_LDSCRIPT value
> >
> > Changes in v2:
> > - Depend on CONFIG_EFI_APP instead
> > - Drop change to u-boot-elf rule
> > - Mention '64-bit ARM' here, rather than just 'ARM'
> > - Drop the word 'Sadly'
> > - Mention '64-bit ARM' here, rather than just 'ARM'
> > - Add new patch to rename VENDOR_EFI to ARCH_EFI
> > - Update to use ARCH_EFI instead of VENDOR_EFI
> > - Mention '64-bit ARM' here, rather than just 'ARM'
> > - Mention '64-bit ARM' here, rather than just 'ARM'
> > - Rework the commit message to clarify the relationship to link-scripts
> > - Expand commit message to explains that EFI_APP skips relocation
> > - Mention '64-bit ARM' here, rather than just 'ARM'
> > - Document the x86 field better and add a comment for ARM too
> > - Mention '64-bit ARM' here, rather than just 'ARM'
> > - Put the EFI-app case first in setup_mon_len(), for clarity
> > - Use ARCH_EFI instead of VENDOR_EFI
> > - Merge the linker-script rules into Kconfig in this patch
> > - Drop patch 'Select the EFI linker script for the app'
> >
> > Simon Glass (29):
> >    Makefile: Avoid using TEXT_BASE with the EFI APP
> >    video: Move vesa_setup_video_priv() into its own file
> >    video: Use a local mode_info struct in the EFI driver
> >    lib: Provide fdtdec_get_pci_bar32() only with PCI enabled
> >    efi: Rename app and payload to include x86
> >    efi: Allow board/efi Kconfig to be used outside x86
> >    efi: x86: Move EFI SDRAM-handling into a common file
> >    treewide: Rename VENDOR_EFI to ARCH_EFI
> >    efi: x86: Rework VENDOR_EFI option to permit other archs
> >    efi: x86: Allow setting the global_data pointer with EFI
> >    efi: Tidy up setup of global_data
> >    efi: Rename ImageBase to image_base
> >    efi: lmb: Avoid access to _start
> >    efi: arm: Don't do the EL2 switch when running under EFI
> >    efi: arm: Avoid allocating page tables when running under EFI
> >    efi: arm: Avoid enabling caches when running under EFI
> >    efi: arm: Implement access to global_data for EFI
> >    efi: arm: Omit the ARM start-up code in the EFI app
> >    efi: arm: Drop exception-level code when running as EFI app
> >    efi: arm: x86: Allow use of the EFI table in the app
> >    efi: arm: Disable --gc-sections for the app
> >    efi: arm: Drop startup code from the app
> >    efi: arm: Adjust how the monitor length is calculated
> >    efi: arm: Provide startup and relocation code
> >    efi: Generate the app as a shared library
> >    efi: arm: Disable STATIC_RELA for the EFI app
> >    efi: arm: Use EFI flags for all compilation with the app
> >    efi: arm: Simplify the crt0 file and update link script
> >    efi: arm: Add an EFI app for arm64
> >
> >   Kconfig                               |   1 +
> >   MAINTAINERS                           |   4 +-
> >   Makefile                              |   7 +-
> >   arch/Kconfig                          |   2 +
> >   arch/arm/Kconfig                      |   6 +-
> >   arch/arm/Makefile                     |   2 +
> >   arch/arm/config.mk                    |  12 ++
> >   arch/arm/cpu/armv8/Makefile           |   4 +-
> >   arch/arm/cpu/armv8/config.mk          |   2 +-
> >   arch/arm/dts/efi-arm_app.dts          |  31 +++++
> >   arch/arm/include/asm/global_data.h    |  18 ++-
> >   arch/arm/lib/Makefile                 |  12 +-
> >   arch/arm/lib/bootm.c                  |   7 +-
> >   arch/arm/lib/cache.c                  |   3 +
> >   arch/arm/lib/crt0_aarch64_efi.S       | 158 ++++----------------------
> >   arch/arm/lib/crt0_arm_efi.S           |   2 +-
> >   arch/arm/lib/elf_aarch64_efi.lds      |  49 +++++---
> >   arch/riscv/lib/crt0_riscv_efi.S       |  30 ++---
> >   arch/x86/Kconfig                      |   4 +-
> >   arch/x86/cpu/efi/Makefile             |   1 -
> >   arch/x86/include/asm/global_data.h    |   9 +-
> >   board/efi/Kconfig                     |  44 ++++++-
> >   board/efi/efi-arm_app/Kconfig         |  19 ++++
> >   board/efi/efi-arm_app/MAINTAINERS     |  13 +++
> >   board/efi/efi-arm_app/Makefile        |   5 +
> >   board/efi/efi-arm_app/board.c         |  18 +++
> >   board/efi/efi-arm_app/config.mk       |   4 +
> >   board/efi/efi-arm_app/efi-arm_app.env |  11 ++
> >   board/efi/efi-x86_payload/Kconfig     |   2 +-
> >   common/board_f.c                      |   6 +-
> >   common/board_r.c                      |   9 +-
> >   configs/efi-arm_app64_defconfig       |  51 +++++++++
> >   configs/efi-x86_app32_defconfig       |   4 +-
> >   configs/efi-x86_app64_defconfig       |   4 +-
> >   configs/efi-x86_payload32_defconfig   |   4 +-
> >   configs/efi-x86_payload64_defconfig   |   4 +-
> >   doc/develop/uefi/u-boot_on_efi.rst    |  17 +--
> >   drivers/pci/pci_rom.c                 |  32 ------
> >   drivers/video/Makefile                |   2 +
> >   drivers/video/efi.c                   |   1 +
> >   drivers/video/vesa_helper.c           |  41 +++++++
> >   include/asm-generic/sections.h        |   2 +
> >   include/vesa.h                        |   2 +
> >   lib/efi/Kconfig                       |   2 +-
> >   lib/efi/Makefile                      |   1 +
> >   lib/efi/efi_app.c                     |  13 ++-
> >   {arch/x86/cpu => lib}/efi/sdram.c     |   1 -
> >   lib/fdtdec.c                          |   2 +
> >   lib/lmb.c                             |   3 +-
> >   49 files changed, 431 insertions(+), 250 deletions(-)
> >   create mode 100644 arch/arm/dts/efi-arm_app.dts
> >   create mode 100644 board/efi/efi-arm_app/Kconfig
> >   create mode 100644 board/efi/efi-arm_app/MAINTAINERS
> >   create mode 100644 board/efi/efi-arm_app/Makefile
> >   create mode 100644 board/efi/efi-arm_app/board.c
> >   create mode 100644 board/efi/efi-arm_app/config.mk
> >   create mode 100644 board/efi/efi-arm_app/efi-arm_app.env
> >   create mode 100644 configs/efi-arm_app64_defconfig
> >   create mode 100644 drivers/video/vesa_helper.c
> >   rename {arch/x86/cpu => lib}/efi/sdram.c (94%)
> >
>
> --
> Caleb (they/them)
>

Regards,
SImon
