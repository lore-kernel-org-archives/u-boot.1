Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8DDC02196
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3143B801DE;
	Mon,  3 Feb 2025 18:52:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IFzm2L5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4076580137; Mon,  3 Feb 2025 18:43:06 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0440800B3
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:43:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3eba559611aso1344434b6e.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604582; x=1739209382; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5BpW7NnSjMyJEknTJCIuvU8hjNfagJlUSc6R/mF6e38=;
 b=IFzm2L5gZNDy8ayv8gN3uoGZG0AnF39nDNfxqFrqaPK60zmcffxlwg0P8KgYqFrDXJ
 uZh3AW+AqQDEpNPRC5YBVGRFnRoK/4CP0Koj7FZlCFKvFybcdJp7CdrpJq3Zar3MEA4R
 hrLDSfSwtjV4CaAyvbI7jNZzdvPMazb0Ar6tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604582; x=1739209382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5BpW7NnSjMyJEknTJCIuvU8hjNfagJlUSc6R/mF6e38=;
 b=Ho9hMszzcLfX8KLKdgfawXd7ur6bUmKeqPUSWP/OeOSaWBKYWhMYc+vA9nlhYxeKYG
 Q7lwRYj55Ozcl8PuwKnP/Xcg2UaCLpOaKGREaVo8WtFck0O5cDYnSJUPb5QXrHzq/3X4
 IKkClrea1viCMUHgliwmpcqsFGE0NJX1dUUJwHY5okV9wCGanuDbWH9pn2RPyILrb3dV
 5zAcRkK8u++OLPihGmqsQI/UZXCcmAymOVTrG5PS31akVfdX9bmCunSSOsjVESJo7+WY
 s7Nlp7DjtzIsBGNHPTQrr/Pk2pddFsr1u0iwOT0Wsp9ePrs+6DanfYG5pyL+yLa5vuvC
 cI9g==
X-Gm-Message-State: AOJu0YyhqVVm926y0RzmW+9xjLHDo5ji0Bzdzf33WetLq6X5P1LCWtIN
 /6lmzQrkLjlDh6xrAWqwGWDU4wxCwT1lFJ4uLQ5U6Gd/0SYBOy2xWNLlf/8ZDWJilpk4W9DQwrk
 =
X-Gm-Gg: ASbGnctNYcCR7eTfkQ3Csv5ZfLlGU7NwfeDaep2yvCrc1CcPWdet6PmaysIt5+wHyxe
 FkNpPVqdLBeuNYoi+9Bw6RQieUjefn3JgFXEZItctPI8kxUSyLUUDZkZmHVAP+Rw802modLeg1c
 rzhzrDO/s4vudcTBS+eiS4zLuNAX/Cz0FEhwpjAk8dDqH0FPwhALg4tEhW2cz4Kp1E4FvV+TlTh
 9zoufI7CcSgSPfdXkYC5meiKXBi4CwvdcvtKbTK/OzmqsL4da5c63uuNiJhXlAdEX6BqNCdbWmi
 DE6UB7QsuTIc1WAytG2BF+1Za6OGlgnVtW0lQPlNaOoxcdIn+JZd
X-Google-Smtp-Source: AGHT+IGf7XTjmebSdXvfFnQB09TETH9L4xSz7ij83nq3iajfRpOPiNofbpAf+WRLBee1J9FJeRggmQ==
X-Received: by 2002:a05:6808:3206:b0:3e8:1ed7:e6cf with SMTP id
 5614622812f47-3f3239f4c1fmr15270189b6e.7.1738604581730; 
 Mon, 03 Feb 2025 09:43:01 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:43:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Anton Bambura <jenneron@protonmail.com>, Bryan Brattlof <bb@ti.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Heiko Schocher <hs@denx.de>,
 Janne Grunau <j@jannau.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Leo <ycliang@andestech.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Matthias Brugger <mbrugger@suse.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Weinberger <richard@nod.at>, Rick Chen <rick@andestech.com>,
 Robert Marko <robert.marko@sartura.hr>, Sam Edwards <CFSworks@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 00/32] arm: Support building as an EFI app
Date: Mon,  3 Feb 2025 10:41:53 -0700
Message-ID: <20250203174245.1331464-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 03 Feb 2025 18:51:59 +0100
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


Simon Glass (32):
  Convert build-efi script to Python
  Makefile: Avoid using TEXT_BASE if not present
  video: Move vesa_setup_video_priv() into its own file
  video: Use a local mode_info struct in the EFI driver
  lib: Provide fdtdec_get_pci_bar32() only with PCI enabled
  scripts: Update build-efi to support building U-Boot
  scripts: Update build-efi to support arm64
  efi: Rename app and payload to include x86
  efi: Allow board/efi Kconfig to be used outside x86
  efi: x86: Move EFI SDRAM-handling into a common file
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
  efi: arm: Allow use of the EFI table in the app
  efi: arm: Disable --gc-sections for the app
  efi: arm: Drop startup code from the app
  efi: arm: Adjust how the monitor length is calculated
  efi: arm: Select the EFI linker script for the app
  efi: arm: Provide startup and relocation code
  efi: Generate the app as a shared library
  efi: arm: Disable STATIC_RELA for the EFI app
  efi: arm: Use EFI flags for all compilation with the app
  efi: arm: Simplify the crt0 file and update link script
  efi: arm: Add an EFI app for arm64

 Kconfig                               |   1 +
 MAINTAINERS                           |   6 +-
 Makefile                              |   8 +-
 arch/Kconfig                          |   2 +
 arch/arm/Kconfig                      |   6 +-
 arch/arm/Makefile                     |   2 +
 arch/arm/config.mk                    |  12 ++
 arch/arm/cpu/armv8/Makefile           |   4 +-
 arch/arm/cpu/armv8/config.mk          |   7 +-
 arch/arm/dts/efi-arm_app.dts          |  31 +++
 arch/arm/include/asm/global_data.h    |  16 +-
 arch/arm/lib/Makefile                 |  12 +-
 arch/arm/lib/bootm.c                  |   7 +-
 arch/arm/lib/cache.c                  |   3 +
 arch/arm/lib/crt0_aarch64_efi.S       | 158 +++-----------
 arch/arm/lib/elf_aarch64_efi.lds      |  49 +++--
 arch/riscv/lib/crt0_riscv_efi.S       |  28 +--
 arch/x86/Kconfig                      |   4 +-
 arch/x86/cpu/efi/Makefile             |   1 -
 arch/x86/include/asm/global_data.h    |   7 +
 board/efi/Kconfig                     |  41 +++-
 board/efi/efi-arm_app/Kconfig         |  16 ++
 board/efi/efi-arm_app/MAINTAINERS     |  13 ++
 board/efi/efi-arm_app/Makefile        |   5 +
 board/efi/efi-arm_app/board.c         |  18 ++
 board/efi/efi-arm_app/efi-arm_app.env |  11 +
 board/efi/efi-x86_payload/Kconfig     |   2 +-
 common/board_f.c                      |   4 +-
 common/board_r.c                      |   9 +-
 configs/efi-arm_app64_defconfig       |  51 +++++
 configs/efi-x86_app32_defconfig       |   4 +-
 configs/efi-x86_app64_defconfig       |   4 +-
 configs/efi-x86_payload32_defconfig   |   4 +-
 configs/efi-x86_payload64_defconfig   |   4 +-
 doc/develop/uefi/u-boot_on_efi.rst    |  21 +-
 drivers/pci/pci_rom.c                 |  32 ---
 drivers/video/Makefile                |   2 +
 drivers/video/efi.c                   |   1 +
 drivers/video/vesa_helper.c           |  41 ++++
 include/asm-generic/sections.h        |   2 +
 include/vesa.h                        |   2 +
 lib/efi/Kconfig                       |   2 +-
 lib/efi/Makefile                      |   1 +
 lib/efi/efi_app.c                     |  13 +-
 {arch/x86/cpu => lib}/efi/sdram.c     |   1 -
 lib/fdtdec.c                          |   2 +
 lib/lmb.c                             |   3 +-
 scripts/build-efi.py                  | 293 ++++++++++++++++++++++++++
 scripts/build-efi.sh                  | 207 ------------------
 49 files changed, 719 insertions(+), 454 deletions(-)
 create mode 100644 arch/arm/dts/efi-arm_app.dts
 create mode 100644 board/efi/efi-arm_app/Kconfig
 create mode 100644 board/efi/efi-arm_app/MAINTAINERS
 create mode 100644 board/efi/efi-arm_app/Makefile
 create mode 100644 board/efi/efi-arm_app/board.c
 create mode 100644 board/efi/efi-arm_app/efi-arm_app.env
 create mode 100644 configs/efi-arm_app64_defconfig
 create mode 100644 drivers/video/vesa_helper.c
 rename {arch/x86/cpu => lib}/efi/sdram.c (94%)
 create mode 100755 scripts/build-efi.py
 delete mode 100755 scripts/build-efi.sh

-- 
2.43.0

