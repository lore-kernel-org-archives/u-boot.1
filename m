Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC7AC02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 276DB8082A;
	Sat,  8 Feb 2025 18:57:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gfjpJQHN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0095380834; Sat,  8 Feb 2025 18:12:09 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4076980820
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3ce915a8a25so10371375ab.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034724; x=1739639524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+BexATUQVOCdsgTVF4spwE0tkPiO1qDCc8wEnNw+4xI=;
 b=gfjpJQHND5wAK9hr5M8a8r5T1/MA3HoAhdKXg3EbBBrNMO9a4MBHbqe6fHm8goq4d/
 7Vnc7CARgZXLMF1l325Pv1YyLkfAYX9HZfkQEFylKXDozYJLcR6loyZyOycXovXxDjrP
 x60xPkrriVKLy9ci7ljrjfjifOcHfeWnly7HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034724; x=1739639524;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+BexATUQVOCdsgTVF4spwE0tkPiO1qDCc8wEnNw+4xI=;
 b=TwkLLt3yvIZ90OtqgpLUy39xpbWLDhI5NzFKFLxQVKb0yXy+0WYggRaDeyWnqhAqqC
 5HhJpAkRFZuXmhJak/0LC39WU/tkOe7wrJS8IfqfjOOsR4gnNhDa//uSMYOBwl5x33NP
 IpkPo9by+9E5iF/NbhwmAXQHj7mm7P34ri7diMOWAfKfp5rXd3eIsjvTZZ6SJAgdVfZs
 H07zj1PTC6452l0J8/1DFW4d2p9bGBwjl5kXiHm8Idew08JD7ne/PdR6jn56q47FdOF9
 +BzJ1sQ2+L6gfHdZlJ7JNZcrck7v+tUAs96w6nO2mG6L7uRIkDQccJx6v6xFXy3afNgB
 T3AQ==
X-Gm-Message-State: AOJu0YyPHdrFcFNIbPoeaaf+AFaLerGvTFNeMS3NLWuHLHL1J/EzqedF
 0mw+W8dUw9kqMSBs+l7h+a8w5kw61JD1rAskH9x0rra1cy+kxRBXagsgiK21ZjE4hS+CyRip2x8
 =
X-Gm-Gg: ASbGncv082yDT1pNoHKTNCbD0UyE/iqRTEAk+0PIZZKlA/tQtBXSojUfq8jZAHbr4Nn
 IXiCX1D5sYqdR5M2ooYAvTCCCDD8pfKf2cSEFP9UMTOs9sJfmo4dAwpQG+Y8QX6i3JORn/doGWb
 v9HsU4FUZ9LTNYwQd2kjqnXN6VFmXRPgaVeNCGZoHdy3bGKcvsAsqzePs6enoz7BmlvD4QW1ngp
 DRqd8+QPnlFZJw0+ROp7q/VWErvfleuKow24KkErnCQhCpg1/lEKHFPARPDQeJ7dHGulZklv+SY
 O38v/5XPve+CrzOjVJeYZO5vn6M6k4XaO47nTr48SXD1p34T2fjO
X-Google-Smtp-Source: AGHT+IHRhT4hRoNkz1hByfcvBZcovHpTVhq8gY3/rkUiaPm+1LPEVgPOYHJDfVDoTw45nXZPNDblKw==
X-Received: by 2002:a92:cd8c:0:b0:3d0:134b:6762 with SMTP id
 e9e14a558f8ab-3d13dd23891mr50316605ab.6.1739034723826; 
 Sat, 08 Feb 2025 09:12:03 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Anatolij Gustschin <agust@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Anton Bambura <jenneron@protonmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>, Heiko Schocher <hs@denx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Leo <ycliang@andestech.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Matthias Brugger <mbrugger@suse.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Richard Weinberger <richard@nod.at>, Rick Chen <rick@andestech.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 00/29] arm: Support building as an EFI app
Date: Sat,  8 Feb 2025 10:11:20 -0700
Message-ID: <20250208171154.1305761-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 08 Feb 2025 18:57:50 +0100
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

The original x86 EFI-app was written back in 2015, about a year before
the EFI-loader was introduced. At that point, ARM mostly used U-Boot and
FIT (Flat Image Tree).

Today, sadly, there are a few efforts to re-invent FIT poorly, to cater
to more primitive boot-environments than U-Boot. One justification for
this re-invetion has been that EDK2 did not support FIT.

EDK2 does now support FIT but only for the firmware stage. Even then,
vendors tend to use their own forks, so any new features are slow to
make it into the market.

EDK2 also supports the ext4 filesystem, but many devices don't include
that feature, so most distros make use of FAT for storing their boot
files. Since FAT is not journalled, it is not particularly reliable in
the face of reset, power failure, etc.

As an interim measure, we can use U-Boot as an EFI app running on top of
whatever EDK2 fork is in use. This allows use of modern features such as
FIT and filesystems other than FAT. So far this only supports x86, but
recent ARM laptops are making use of EFI too.

So this series adds an EFI app for 64-bit ARM.

Note: Since U-Boot does not support EFI's GOP 'blt-only' mode, the
vidconsole does not operate, but it can still be used, since EDK2
handles drawing instead of U-Boot. As a result, the U-Boot logo is not
shown.

Changes in v2:
- Depend on CONFIG_EFI_APP instead
- Drop change to u-boot-elf rule
- Mention '64-bit ARM' here, rather than just 'ARM'
- Drop the word 'Sadly'
- Mention '64-bit ARM' here, rather than just 'ARM'
- Add new patch to rename VENDOR_EFI to ARCH_EFI
- Update to use ARCH_EFI instead of VENDOR_EFI
- Mention '64-bit ARM' here, rather than just 'ARM'
- Mention '64-bit ARM' here, rather than just 'ARM'
- Rework the commit message to clarify the relationship to link-scripts
- Expand commit message to explains that EFI_APP skips relocation
- Mention '64-bit ARM' here, rather than just 'ARM'
- Document the x86 field better and add a comment for ARM too
- Mention '64-bit ARM' here, rather than just 'ARM'
- Put the EFI-app case first in setup_mon_len(), for clarity
- Use ARCH_EFI instead of VENDOR_EFI
- Merge the linker-script rules into Kconfig in this patch
- Drop patch 'Select the EFI linker script for the app'

Simon Glass (29):
  Makefile: Avoid using TEXT_BASE if not present
  video: Move vesa_setup_video_priv() into its own file
  video: Use a local mode_info struct in the EFI driver
  lib: Provide fdtdec_get_pci_bar32() only with PCI enabled
  efi: Rename app and payload to include x86
  efi: Allow board/efi Kconfig to be used outside x86
  efi: x86: Move EFI SDRAM-handling into a common file
  treewide: Rename VENDOR_EFI to ARCH_EFI
  efi: x86: Rework VENDOR_EFI option to permit other archs
  efi: x86: Allow setting the global_data pointer with EFI
  efi: Tidy up setup of global_data
  efi: Rename ImageBase to image_base
  efi: lmb: Avoid access to _start
  efi: arm: Don't do the EL2 switch when running under EFI
  efi: arm: Avoid allocating page tables when running under EFI
  efi: arm: Avoid enabling caches when running under EFI
  efi: arm: Implement access to global_data for EFI
  efi: arm: Omit the ARM start-up code in the EFI app
  efi: arm: Drop exception code when running as an EFI app
  efi: arm: x86: Allow use of the EFI table in the app
  efi: arm: Disable --gc-sections for the app
  efi: arm: Drop startup code from the app
  efi: arm: Adjust how the monitor length is calculated
  efi: arm: Provide startup and relocation code
  efi: Generate the app as a shared library
  efi: arm: Disable STATIC_RELA for the EFI app
  efi: arm: Use EFI flags for all compilation with the app
  efi: arm: Simplify the crt0 file and update link script
  efi: arm: Add an EFI app for arm64

 Kconfig                               |   1 +
 MAINTAINERS                           |   4 +-
 Makefile                              |   6 +
 arch/Kconfig                          |   2 +
 arch/arm/Kconfig                      |   6 +-
 arch/arm/Makefile                     |   2 +
 arch/arm/config.mk                    |  12 ++
 arch/arm/cpu/armv8/Makefile           |   4 +-
 arch/arm/cpu/armv8/config.mk          |   6 +-
 arch/arm/dts/efi-arm_app.dts          |  31 +++++
 arch/arm/include/asm/global_data.h    |  18 ++-
 arch/arm/lib/Makefile                 |  12 +-
 arch/arm/lib/bootm.c                  |   7 +-
 arch/arm/lib/cache.c                  |   3 +
 arch/arm/lib/crt0_aarch64_efi.S       | 158 ++++----------------------
 arch/arm/lib/crt0_arm_efi.S           |   2 +-
 arch/arm/lib/elf_aarch64_efi.lds      |  49 +++++---
 arch/riscv/lib/crt0_riscv_efi.S       |  30 ++---
 arch/x86/Kconfig                      |   4 +-
 arch/x86/cpu/efi/Makefile             |   1 -
 arch/x86/include/asm/global_data.h    |   9 +-
 board/efi/Kconfig                     |  44 ++++++-
 board/efi/efi-arm_app/Kconfig         |  19 ++++
 board/efi/efi-arm_app/MAINTAINERS     |  13 +++
 board/efi/efi-arm_app/Makefile        |   5 +
 board/efi/efi-arm_app/board.c         |  18 +++
 board/efi/efi-arm_app/efi-arm_app.env |  11 ++
 board/efi/efi-x86_payload/Kconfig     |   2 +-
 common/board_f.c                      |   6 +-
 common/board_r.c                      |   9 +-
 configs/efi-arm_app64_defconfig       |  51 +++++++++
 configs/efi-x86_app32_defconfig       |   4 +-
 configs/efi-x86_app64_defconfig       |   4 +-
 configs/efi-x86_payload32_defconfig   |   4 +-
 configs/efi-x86_payload64_defconfig   |   4 +-
 doc/develop/uefi/u-boot_on_efi.rst    |  17 +--
 drivers/pci/pci_rom.c                 |  32 ------
 drivers/video/Makefile                |   2 +
 drivers/video/efi.c                   |   1 +
 drivers/video/vesa_helper.c           |  41 +++++++
 include/asm-generic/sections.h        |   2 +
 include/vesa.h                        |   2 +
 lib/efi/Kconfig                       |   2 +-
 lib/efi/Makefile                      |   1 +
 lib/efi/efi_app.c                     |  13 ++-
 {arch/x86/cpu => lib}/efi/sdram.c     |   1 -
 lib/fdtdec.c                          |   2 +
 lib/lmb.c                             |   3 +-
 48 files changed, 431 insertions(+), 249 deletions(-)
 create mode 100644 arch/arm/dts/efi-arm_app.dts
 create mode 100644 board/efi/efi-arm_app/Kconfig
 create mode 100644 board/efi/efi-arm_app/MAINTAINERS
 create mode 100644 board/efi/efi-arm_app/Makefile
 create mode 100644 board/efi/efi-arm_app/board.c
 create mode 100644 board/efi/efi-arm_app/efi-arm_app.env
 create mode 100644 configs/efi-arm_app64_defconfig
 create mode 100644 drivers/video/vesa_helper.c
 rename {arch/x86/cpu => lib}/efi/sdram.c (94%)

-- 
2.43.0

