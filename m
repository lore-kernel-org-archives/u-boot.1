Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE4AD0D16D
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 20:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73DCE840A9;
	Wed,  7 Jan 2026 21:19:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L/xAqSc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E2BC83A2D; Wed,  7 Jan 2026 21:19:01 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24562839A5
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 21:18:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-34c718c5481so1622087a91.3
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 12:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767817136; x=1768421936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mw4BjUUVFSi/yy92Zm5EiIpZazNLorrHFCPLDqDPG2k=;
 b=L/xAqSc5Y25yxh/c3vf9Y1rWlgER11eYDaLNvkNpUG5z/HiTYzEVjRTyVm/fECpx/2
 wB7D8kKLyk+PTZuvXPXJpoZExVG5h1qdUnhK+6SRt71u/oDPYVdUj3IlCioP2DgkZzUb
 N9fuFhfsgWPBeA3M2jKpCNf3Qrmy6C2yr4SqOoZ3CzqoSKe7WTiwW9GDiw0/z00r/nj1
 7ih6FlqTRNbiQa4FlnbrbELbdj69ve4tJ7cAc+9PwNecZ6RB30OEi9gemqUbx7kXQ7B7
 JLRdk7km7ktp+bA2QfO9Al0A/fKY1W58EArGx/wUuzDyWMD5jGypp57d7C3LrnpSjZib
 dYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767817136; x=1768421936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mw4BjUUVFSi/yy92Zm5EiIpZazNLorrHFCPLDqDPG2k=;
 b=ibuKknsNza7l9SD076FXFCmeQdm9Ny9Wgd8K+eZCI3RdYUsgnt/Hyhd6v/RahzU+pI
 eBuC22o2bhkE57zJnMwt9nFYnH7ma61xidcckJHrtEYolVpsyHUoYl2+4QTIwZwviboj
 NH7iTMUif8ztdOxO9kVzrqsJ14sKHydYBYubEGOeJF05VwUhjlFD3kgBVvzK5w0yUZ06
 WkPlxtWe1u7X1jabtUO6IPs4WLX80+7kV/CLDQGp8AcwdiAp/nPnZqTY0rvkjsCuaDWY
 0/9wLmrxrG3lSaGbBwaCyDmKZ5M69Bh1PB7ScN55jWbAgAFCBy6oULSVR+LyQV5IY5Nk
 y4Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXawlK4n8WjyfYgedBam+NPkiVPSITRBPZZhYbzBy7pgGSoDQLeoYYQQpXkZSgSfQXXc8G+MEY=@lists.denx.de
X-Gm-Message-State: AOJu0YwF6fCy14IcE3FgSpR6d3x6S4IqWO9Rk+tO89eCpvlfy3O193VG
 Gq7NoZ3UyfwHVhF/T4JzFAIaK05aLYIQGAxca7VamPVp08lGMbTjjrUO
X-Gm-Gg: AY/fxX7yAJfPTDbDrV31DkhYK/dxlRHs+Fr0N9TllU/T5OzD5y1b5RdhRcvAY7OMRKY
 fh3i5QQJ2nFBU4VxT1UGNRrcYUXc8CasVVSzaqR526Tg4v2GqnKos8QEXXzKBHlTkV57mkzKa3z
 5/+hhOoGXqM5R8lmButnBnIHlFLABqYeT2CSNdS+X0H8/K8pln80ZEjkUiVk3L+mBI2y8rNMesR
 VujijupCbkn2VWFmDlwbOF5TnA7sFv7vZ7+Fk63kdH02G1RpaYq/GRC4nfwlHQ+JxcwiZbim745
 oNq7bKvDCQRlJcqfRaLg/zxywzGBuNpO/DOHP3Hc5RTTyPBeUChBrGpvkMhjUP7ci1Lb4rwqxwZ
 v0n1xcGwM3Hyv8k4sEn9mIew+Uup4Jv652EgqkrrT3eOmfa4mu0QMLzHDMb3S8rz2kJu2L+Bnwv
 cxMPuTo0TYEsBJy69IVOv21UHXHB8HpsryRJbv2wD97sO4pQ9Tmx9hfF7ycClNIAFEvaAypI//V
 Z8Ejqr2YS9imBhh3Wjvtg==
X-Google-Smtp-Source: AGHT+IHLPalyUg0KzVV4s34dEExn1UYpeHkjktCNLeDCmaWwpAbwsT2lg2x5psAG9rL/w99syhM72Q==
X-Received: by 2002:a17:90b:57f0:b0:349:3fe8:e7de with SMTP id
 98e67ed59e1d1-34f68c27620mr2922786a91.28.1767817136464; 
 Wed, 07 Jan 2026 12:18:56 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa947ecsm5766077a91.6.2026.01.07.12.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 12:18:56 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 sjg@chromium.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v6 0/8] m68k: Add support for QEMU virt machine
Date: Wed,  7 Jan 2026 20:18:29 +0000
Message-ID: <20260107201838.3448806-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 07 Jan 2026 21:19:27 +0100
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

Add support for the QEMU 'virt' machine on the m68k architecture. The
QEMU virt machine models a generic system utilizing Goldfish virtual
peripherals and is capable of emulating various classic 68k CPUs.

Currently, U-Boot's m68k architecture support focuses on ColdFire
variants. This series expands support to include the classic M680x0
architecture, implementing the necessary exception vectors, startup
code, and a bootinfo parser compatible with the QEMU interface.

Drivers for Goldfish peripherals (TTY, Timer, RTC) and the QEMU
Virtual System Controller (sysreset) are also added to enable serial
console, timekeeping, and system reset functionality.

The implementation has been verified on QEMU targeting the M68040 CPU,
confirming successful hardware initialization and boot to the U-Boot
command shell. Additionally, the CI configuration was verified locally
using gitlab-ci-local "qemu_m68k_virt test.py", resulting in
PASS qemu_m68k_virt test.py.
---
Changes in v6:
- Refactor Goldfish drivers (TTY, Timer, RTC) to strictly separate
  of_to_plat (parsing) and probe (mapping), supporting both device tree
  and explicit platform data.
- Introduce a new sysreset driver for the QEMU virtual system controller,
  replacing the previous board-file implementation.
- Refactor m68k Kconfig/Makefile to use a hidden CONFIG_ARCH_COLDFIRE
  symbol for cleaner file grouping.
- Improve board initialization: move bootinfo parsing to board_early_init_f
  and remove all hardcoded MMIO addresses.
- Update MAINTAINERS to reflect the removal of inactive maintainers.

Changes in v5:
- Rebase on u-boot/next branch.
- Add 'imply CMD_DM' to TARGET_QEMU_M68K in Kconfig.
- Add a new patch to update the M68K entry in MAINTAINERS and add myself
  as a co-maintainer.

Changes in v4:
- Support DT probing with platform data as a fallback. (serial & timer)
- Fix sandbox build warnings by removing incorrect type casting.
- Add comment explaining read latching behavior in the timer driver.
- Sort headers alphabetically in the timer driver.

Changes in v3:
- Add Goldfish timer driver.
- Update Goldfish RTC driver to support non-DT probing.
- Enable Goldfish RTC and Timer support in board configuration.
- Add safety loop limit to bootinfo parsing in dram_init.
- Remove dummy timer functions from architecture code.
- Remove unnecessary type casts in Goldfish TTY driver.
- Remove TEST_PY_ID from CI job definitions.
- Update documentation to include new RTC support.

Changes in v2:
- Refactor Goldfish TTY driver to use priv data for the RX buffer and
  ensure single-byte reads.
- Rename arch/m68k/cpu/m68040 to arch/m68k/cpu/m680x0 to separate the
  architecture family from the specific CPU model.
- Introduce M680x0 Kconfig symbol and separate MAINTAINERS entries for
  the architecture and the board.
- Regenerate qemu-m68k_defconfig using make savedefconfig and add the
  board to the documentation index.
- Add a new patch to enable CI testing on GitLab and Azure Pipelines.
- Update SPDX identifiers to GPL-2.0-or-later.
- Sort headers alphabetically.
- Fix tabs vs spaces.

v5: https://lore.kernel.org/u-boot/20260105165221.1816070-1-visitorckw@gmail.com/
v4: https://lore.kernel.org/u-boot/20260101175420.4118024-1-visitorckw@gmail.com/
v3: https://lore.kernel.org/u-boot/20251230160112.3045527-1-visitorckw@gmail.com/
v2: https://lore.kernel.org/u-boot/20251226175400.1154417-1-visitorckw@gmail.com/
v1: https://lore.kernel.org/u-boot/20251218185252.957388-1-visitorckw@gmail.com/

Kuan-Wei Chiu (8):
  serial: Add Goldfish TTY driver
  timer: Add Goldfish timer driver
  rtc: goldfish: Support platform data for non-DT probing
  sysreset: Add QEMU virtual system controller driver
  m68k: Add support for M68040 CPU
  board: Add QEMU m68k virt board support
  CI: Add test jobs for QEMU m68k virt machine
  MAINTAINERS: Update m68k entry

 .azure-pipelines.yml                       |   3 +
 .gitlab-ci.yml                             |   6 ++
 MAINTAINERS                                |  28 ++++-
 arch/m68k/Kconfig                          |  39 +++++++
 arch/m68k/Makefile                         |   1 +
 arch/m68k/config.mk                        |  10 +-
 arch/m68k/cpu/m680x0/Makefile              |   6 ++
 arch/m68k/cpu/m680x0/cpu.c                 |  73 +++++++++++++
 arch/m68k/cpu/m680x0/start.S               |  73 +++++++++++++
 arch/m68k/cpu/m680x0/u-boot.lds            |  47 +++++++++
 arch/m68k/include/asm/bootinfo.h           |  39 +++++++
 arch/m68k/lib/Makefile                     |   7 +-
 board/emulation/qemu-m68k/Kconfig          |  12 +++
 board/emulation/qemu-m68k/MAINTAINERS      |   8 ++
 board/emulation/qemu-m68k/Makefile         |   5 +
 board/emulation/qemu-m68k/qemu-m68k.c      | 117 +++++++++++++++++++++
 configs/qemu-m68k_defconfig                |  20 ++++
 doc/board/emulation/index.rst              |   1 +
 doc/board/emulation/qemu-m68k.rst          |  39 +++++++
 drivers/rtc/goldfish_rtc.c                 |  23 +++-
 drivers/serial/Kconfig                     |   8 ++
 drivers/serial/Makefile                    |   1 +
 drivers/serial/serial_goldfish.c           | 117 +++++++++++++++++++++
 drivers/sysreset/Kconfig                   |   8 ++
 drivers/sysreset/Makefile                  |   1 +
 drivers/sysreset/sysreset_qemu_virt_ctrl.c |  55 ++++++++++
 drivers/timer/Kconfig                      |   8 ++
 drivers/timer/Makefile                     |   1 +
 drivers/timer/goldfish_timer.c             |  89 ++++++++++++++++
 include/configs/qemu-m68k.h                |  18 ++++
 include/goldfish_rtc.h                     |  15 +++
 include/goldfish_timer.h                   |  13 +++
 include/goldfish_tty.h                     |  18 ++++
 include/qemu_virt_ctrl.h                   |  13 +++
 34 files changed, 908 insertions(+), 14 deletions(-)
 create mode 100644 arch/m68k/cpu/m680x0/Makefile
 create mode 100644 arch/m68k/cpu/m680x0/cpu.c
 create mode 100644 arch/m68k/cpu/m680x0/start.S
 create mode 100644 arch/m68k/cpu/m680x0/u-boot.lds
 create mode 100644 arch/m68k/include/asm/bootinfo.h
 create mode 100644 board/emulation/qemu-m68k/Kconfig
 create mode 100644 board/emulation/qemu-m68k/MAINTAINERS
 create mode 100644 board/emulation/qemu-m68k/Makefile
 create mode 100644 board/emulation/qemu-m68k/qemu-m68k.c
 create mode 100644 configs/qemu-m68k_defconfig
 create mode 100644 doc/board/emulation/qemu-m68k.rst
 create mode 100644 drivers/serial/serial_goldfish.c
 create mode 100644 drivers/sysreset/sysreset_qemu_virt_ctrl.c
 create mode 100644 drivers/timer/goldfish_timer.c
 create mode 100644 include/configs/qemu-m68k.h
 create mode 100644 include/goldfish_rtc.h
 create mode 100644 include/goldfish_timer.h
 create mode 100644 include/goldfish_tty.h
 create mode 100644 include/qemu_virt_ctrl.h

-- 
2.52.0.457.g6b5491de43-goog

