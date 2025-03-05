Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDF9C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 16:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4C1180BAA;
	Wed,  5 Mar 2025 17:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UZwkVt04";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1EFB80E94; Wed,  5 Mar 2025 15:15:31 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 423C98083E
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-abf52666efdso591803966b.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 06:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741184129; x=1741788929; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Biupsq3jGvRREgNkGpW37CPSTFIgh7/bmobed9H4EfM=;
 b=UZwkVt04ovDEppGA9Hsr+cLX/ZIHb/KZ5Ai4QCbjrFgUb07zrx+26qCjYmazp/R+d9
 KHG3Abue+/A00iCpJLcLw2KfV5hSBlM/QoDhTOrUWkYrejam3eQy6B3TEDjQqUTQqetR
 T3D7zczWAqv5vabnuz3n9DI9t8YKI1zwj0dpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741184129; x=1741788929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Biupsq3jGvRREgNkGpW37CPSTFIgh7/bmobed9H4EfM=;
 b=ixAnLqVePnADxcl3sDh4bDtsl7eH7Gdh5xlXY1vqyJNVA5ltEl0nbIHOR12kRLzHcN
 YIWZG7Bhz5ZykFDr45RQ2bjxdNCwTVnzqBeKHJFt+Q8T3C0yT8lQ031nxTP0qBKLokFn
 REGFb9+Q0XwhWgnLE1PlkyNeKIN9NfzPTG9DMe1xsGrSdNK2gneMGV7JMP6Ra+qr38ZG
 Wj8s7x7xivk+9xlIFiVXTzDPgHt/ZfY0iHWFA0rG6W97Vy8S54mZ7FBQzS0aKQLIfdyB
 3jt7XqItZgbB6kJ1ONwvamPRR8WenF8j9hHO8tYGpRD0uF42rHqpUAQsfCnSF2xNjEyH
 2zKw==
X-Gm-Message-State: AOJu0YynV3I+SxRUfI4tIG+FFzqfYFk5na9gnhc8nPjWEJK6NYPL1z+j
 xUj20MVLKogpT28PixKNj8nV2t0+DFFonPfuFx7cYZzzII3GA8XaohgnhmhuoxUbMNI2wMklXQO
 ElfMkQNhNGqM8Golgi4dybhxZ2/jLzXtW4awk
X-Gm-Gg: ASbGncty9AYm1qVtSUURjhd6yyKcO3NR20r251PvSyeHw+GV3rz6ICKZcckqFtBPEET
 PBwk/NFUl1doJezxMdtxiaj/N9+FUbzF2H3O17VuBXpwpfa+n3CgYKQwrYC8vtO2Vx2ZjcIol8B
 apPpylpiTZ5IASqjjniISga5aGC4M=
X-Google-Smtp-Source: AGHT+IHmy8y8QTQMjlZ/305CpSzGMfQ+wUPiFpdLeyjFKSXS/o/uQBLLMTdHpGBaE+kiGBb30b7wtT0dOdQFwHkB8KE=
X-Received: by 2002:a17:907:97d6:b0:abf:76d1:f0fd with SMTP id
 a640c23a62f3a-ac20d8bc996mr285117566b.19.1741184128404; Wed, 05 Mar 2025
 06:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20250215032254.4121030-1-sjg@chromium.org>
 <CAByghJZ67PaYGLYk-fcoD2uteF9eKvhYrrSfc7BiWn5cSD0pdQ@mail.gmail.com>
In-Reply-To: <CAByghJZ67PaYGLYk-fcoD2uteF9eKvhYrrSfc7BiWn5cSD0pdQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Mar 2025 07:15:16 -0700
X-Gm-Features: AQ5f1Jq_JiU0mfQgkKAWhzpVwn6XnLx1dPpUUwiIeIXwGxYATk1rl5oPEyFDKVs
Message-ID: <CAFLszTiuoMfO6q3E9obWCr21sg-6asE7wsu_TKkaNQegptVhQw@mail.gmail.com>
Subject: Re: [PATCH v4 00/29] arm: Support building as an EFI app
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <agust@denx.de>, Angelo Dureghello <angelo@kernel-space.org>,
 Anton Bambura <jenneron@protonmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Greg Malysa <greg.malysa@timesys.com>,
 Janne Grunau <j@jannau.net>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>,
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
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 05 Mar 2025 17:31:35 +0100
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

Hi Igor,

On Tue, 4 Mar 2025 at 07:50, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
>
> Hello Simon,
>
> On Sat, Feb 15, 2025 at 2:08=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > The original x86 EFI-app was written back in 2015, about a year before
> > the EFI-loader was introduced. At that point, ARM mostly used U-Boot an=
d
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
> > As an interim measure, we can use U-Boot as an EFI app running on top o=
f
> > whatever EDK2 fork is in use. This allows use of modern features such a=
s
> > FIT and filesystems other than FAT. So far this only supports x86, but
> > recent ARM laptops are making use of EFI too.
> >
> > So this series adds an EFI app for 64-bit ARM.
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
> >   Makefile: Avoid using TEXT_BASE with the EFI APP
> >   video: Move vesa_setup_video_priv() into its own file
> >   video: Use a local mode_info struct in the EFI driver
> >   lib: Provide fdtdec_get_pci_bar32() only with PCI enabled
> >   efi: Rename app and payload to include x86
> >   efi: Allow board/efi Kconfig to be used outside x86
> >   efi: x86: Move EFI SDRAM-handling into a common file
> >   treewide: Rename VENDOR_EFI to ARCH_EFI
> >   efi: x86: Rework VENDOR_EFI option to permit other archs
> >   efi: x86: Allow setting the global_data pointer with EFI
> >   efi: Tidy up setup of global_data
> >   efi: Rename ImageBase to image_base
> >   efi: lmb: Avoid access to _start
> >   efi: arm: Don't do the EL2 switch when running under EFI
> >   efi: arm: Avoid allocating page tables when running under EFI
> >   efi: arm: Avoid enabling caches when running under EFI
> >   efi: arm: Implement access to global_data for EFI
> >   efi: arm: Omit the ARM start-up code in the EFI app
> >   efi: arm: Drop exception-level code when running as EFI app
> >   efi: arm: x86: Allow use of the EFI table in the app
> >   efi: arm: Disable --gc-sections for the app
> >   efi: arm: Drop startup code from the app
> >   efi: arm: Adjust how the monitor length is calculated
> >   efi: arm: Provide startup and relocation code
> >   efi: Generate the app as a shared library
> >   efi: arm: Disable STATIC_RELA for the EFI app
> >   efi: arm: Use EFI flags for all compilation with the app
> >   efi: arm: Simplify the crt0 file and update link script
> >   efi: arm: Add an EFI app for arm64
> >
> >  Kconfig                               |   1 +
> >  MAINTAINERS                           |   4 +-
> >  Makefile                              |   7 +-
> >  arch/Kconfig                          |   2 +
> >  arch/arm/Kconfig                      |   6 +-
> >  arch/arm/Makefile                     |   2 +
> >  arch/arm/config.mk                    |  12 ++
> >  arch/arm/cpu/armv8/Makefile           |   4 +-
> >  arch/arm/cpu/armv8/config.mk          |   2 +-
> >  arch/arm/dts/efi-arm_app.dts          |  31 +++++
> >  arch/arm/include/asm/global_data.h    |  18 ++-
> >  arch/arm/lib/Makefile                 |  12 +-
> >  arch/arm/lib/bootm.c                  |   7 +-
> >  arch/arm/lib/cache.c                  |   3 +
> >  arch/arm/lib/crt0_aarch64_efi.S       | 158 ++++----------------------
> >  arch/arm/lib/crt0_arm_efi.S           |   2 +-
> >  arch/arm/lib/elf_aarch64_efi.lds      |  49 +++++---
> >  arch/riscv/lib/crt0_riscv_efi.S       |  30 ++---
> >  arch/x86/Kconfig                      |   4 +-
> >  arch/x86/cpu/efi/Makefile             |   1 -
> >  arch/x86/include/asm/global_data.h    |   9 +-
> >  board/efi/Kconfig                     |  44 ++++++-
> >  board/efi/efi-arm_app/Kconfig         |  19 ++++
> >  board/efi/efi-arm_app/MAINTAINERS     |  13 +++
> >  board/efi/efi-arm_app/Makefile        |   5 +
> >  board/efi/efi-arm_app/board.c         |  18 +++
> >  board/efi/efi-arm_app/config.mk       |   4 +
> >  board/efi/efi-arm_app/efi-arm_app.env |  11 ++
> >  board/efi/efi-x86_payload/Kconfig     |   2 +-
> >  common/board_f.c                      |   6 +-
> >  common/board_r.c                      |   9 +-
> >  configs/efi-arm_app64_defconfig       |  51 +++++++++
> >  configs/efi-x86_app32_defconfig       |   4 +-
> >  configs/efi-x86_app64_defconfig       |   4 +-
> >  configs/efi-x86_payload32_defconfig   |   4 +-
> >  configs/efi-x86_payload64_defconfig   |   4 +-
> >  doc/develop/uefi/u-boot_on_efi.rst    |  17 +--
> >  drivers/pci/pci_rom.c                 |  32 ------
> >  drivers/video/Makefile                |   2 +
> >  drivers/video/efi.c                   |   1 +
> >  drivers/video/vesa_helper.c           |  41 +++++++
> >  include/asm-generic/sections.h        |   2 +
> >  include/vesa.h                        |   2 +
> >  lib/efi/Kconfig                       |   2 +-
> >  lib/efi/Makefile                      |   1 +
> >  lib/efi/efi_app.c                     |  13 ++-
> >  {arch/x86/cpu =3D> lib}/efi/sdram.c     |   1 -
> >  lib/fdtdec.c                          |   2 +
> >  lib/lmb.c                             |   3 +-
> >  49 files changed, 431 insertions(+), 250 deletions(-)
> >  create mode 100644 arch/arm/dts/efi-arm_app.dts
> >  create mode 100644 board/efi/efi-arm_app/Kconfig
> >  create mode 100644 board/efi/efi-arm_app/MAINTAINERS
> >  create mode 100644 board/efi/efi-arm_app/Makefile
> >  create mode 100644 board/efi/efi-arm_app/board.c
> >  create mode 100644 board/efi/efi-arm_app/config.mk
> >  create mode 100644 board/efi/efi-arm_app/efi-arm_app.env
> >  create mode 100644 configs/efi-arm_app64_defconfig
> >  create mode 100644 drivers/video/vesa_helper.c
> >  rename {arch/x86/cpu =3D> lib}/efi/sdram.c (94%)
> >
> > --
> > 2.43.0
> >
>
> It looks like some patches, such as "efi: x86: Move EFI SDRAM-handling
> into a common file,"
> depend on another patch series from Matthew Garrett [1], which has
> already been merged into "ci/master.".
>
> Could you please provide a link to that branch (assuming it's [1])? I
> wasn't able to
> find it in the custodian trees.
>
> [1] https://www.mail-archive.com/u-boot@lists.denx.de/msg528541.html
>

Yes, it is here:

https://sjg.u-boot.org/u-boot/u-boot/-/tree/master?ref_type=3Dheads

Regards,
Simon
