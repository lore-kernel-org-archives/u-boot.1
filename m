Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E56EEE25C
	for <u-boot@archiver.kernel.org>; Thu,  1 Jan 2026 21:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FFD783B0B;
	Thu,  1 Jan 2026 22:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WT/w9x0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F47083C40; Thu,  1 Jan 2026 18:54:40 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 911E983AAD
 for <u-boot@lists.denx.de>; Thu,  1 Jan 2026 18:54:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a07f8dd9cdso120174045ad.1
 for <u-boot@lists.denx.de>; Thu, 01 Jan 2026 09:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767290076; x=1767894876; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wmJJW9SMmMjZ+T5ZIAn0RimGnT/tS45GAdCX6TviPGA=;
 b=WT/w9x0nD/JYkb/zzqzXTQXu0edWYJ15ZLE981yIdRfCpTNWgvKguOK1MoUiYmo52p
 R+BZRMJP1dvZvLxWZ8ObFNB7AClKOOLJDjikLqTyqx77YyC9IMpRfj//rpU/xwuPZqge
 fFUygJJa7zdQjxIuhlBU4w+3mn8FMUx3p93A/TECioOI2D9IZFRUqXdkljrOzLhr7BeE
 4Ej/hH6X3L4cEyDlJnz9grRKI1hYetIHZdTK62gaZioFzPWBwrfy39uDbqmqxfEzX2SM
 ZqFxfv8CdgfWkPTjcAuMsIt51YP3/esHSIf7w0YjzXZynvlxVcDMgY7psMgpDvRwdczD
 k30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767290076; x=1767894876;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmJJW9SMmMjZ+T5ZIAn0RimGnT/tS45GAdCX6TviPGA=;
 b=o2gtRNPfHPHkJ3zdVRKmCTiTODd/TjQ44BS3eV4eJrCz3wHEVWEjY7o9hN5pJOWMnt
 ASVf8wF44GSIgD/JwCqEpmHbFQvB56dPjq2MqvjPEHnwuO+x6j0guwQ1kISwe5HOH4jZ
 pfjvvEtGS4dg0T+gx6S47Vp3x2kHOMh2FyvK9B+WTgXirWeiGexY1tW6uadjXmmRuB9S
 etP9ErzJxH9BTYGSHO6gmutAjcv279c4Vd854/5QvGy2OoTLzCnshjyz7NoHjQdOu+b+
 j/8QjGjh89zXluoDbOR4LNBz/+MEnLmedHPL0hV8IOGKKC7Jk+Jnft2IoSNhgLBiOiSu
 JjyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF5337KibjdODK869Q74hyQOwVOvydQ7w/bAC5od02RnKHPbZFn+bEsWgaxRVU8ZQYs/uuBBo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx78+n9raBcga3sGNkLasOzLt3P4jFdGiWATXy4e5fM74y3e0mP
 DQNKxKuq7K5FPy8L5Nqv50g+mpi0jU8QuQl5AkeaXY42voQLAE77sAvM
X-Gm-Gg: AY/fxX6VlWvJ1brPrUKW1qOdRmx8Rj5rBQxCk8TbUemksyJ8b6Bs8SZifBl2YHGkSfJ
 V4VEaj36azDSV6yJ9UQuiNzyfajj1eXuKJvdVMBSfV3k3ZbS6XqzouXsZkLDaWg4eX6/NVVo4WY
 ahzRzyrHOiqD1PasOCvTXddQlfXScELRSqBqvPz3jPHgVcTdobFp+C7xY96b25c03WLxhEMt1tp
 58y9woE6ZyAURe19QcZXaAuSeJunTxH64p9SGZLAL5VD+IsU6i/9H3VCSEpTM5CxqvBRkK+uOrI
 XjcRq6kbra5mJwrVbVFL4srH7icyPw4mpcjMN2CxvPliMaIA7YWcHBNvNbiMjbyNpywPG5xet2i
 +1Bl307YMGdH1dMK8FYc2CRU2UyOIf8NwNea12U/Ftz4SCBtl6M/DxAPecc2xUk1/qvQBL+vINY
 VEGYG+MNLvVxsz92oO1QDzyBG1cXojkC2Di1wPJ6MeoNAepsoE5S1tdwv1iN5hXAzXBKsgLrED9
 uYhtqRld7iQsgwTnDEYRQ==
X-Google-Smtp-Source: AGHT+IF0KHGUzLSSJeJIuVO3zKpbmBG0HE0sZiU6Loy60CXY/tLl8zsvx3gJoFKS60h2JvazhuNVVw==
X-Received: by 2002:a17:902:d488:b0:2a0:9b4f:5ebd with SMTP id
 d9443c01a7336-2a2f2229d26mr364946345ad.15.1767290075900; 
 Thu, 01 Jan 2026 09:54:35 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3a8770e66sm40000615ad.42.2026.01.01.09.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jan 2026 09:54:35 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v4 0/6] m68k: Add support for QEMU virt machine
Date: Thu,  1 Jan 2026 17:54:14 +0000
Message-ID: <20260101175420.4118024-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 Jan 2026 22:15:35 +0100
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
variants. Expand this to include the classic M680x0 architecture,
implementing the necessary exception vectors, startup code, and a
bootinfo parser compatible with the QEMU interface. A driver for the
Goldfish TTY is also added to enable serial console output.

The implementation has been verified on QEMU targeting the M68040 CPU,
confirming successful hardware initialization and boot to the U-Boot
command shell. Additionally, the CI configuration was verified locally
using gitlab-ci-local "qemu_m68k_virt test.py", resulting in
PASS qemu_m68k_virt test.py.
---
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

v3: https://lore.kernel.org/u-boot/20251230160112.3045527-1-visitorckw@gmail.com/
v2: https://lore.kernel.org/u-boot/20251226175400.1154417-1-visitorckw@gmail.com/
v1: https://lore.kernel.org/u-boot/20251218185252.957388-1-visitorckw@gmail.com/

Kuan-Wei Chiu (6):
  serial: Add Goldfish TTY driver
  timer: Add Goldfish timer driver
  rtc: goldfish: Support platform data for non-DT probing
  m68k: Add support for M68040 CPU
  board: Add QEMU m68k virt board support
  CI: Add test jobs for QEMU m68k virt machine

 .azure-pipelines.yml                  |   3 +
 .gitlab-ci.yml                        |   6 ++
 MAINTAINERS                           |  18 ++++
 arch/m68k/Kconfig                     |  24 ++++++
 arch/m68k/Makefile                    |   1 +
 arch/m68k/config.mk                   |  10 ++-
 arch/m68k/cpu/m680x0/Makefile         |   6 ++
 arch/m68k/cpu/m680x0/cpu.c            |  72 ++++++++++++++++
 arch/m68k/cpu/m680x0/start.S          |  73 ++++++++++++++++
 arch/m68k/cpu/m680x0/u-boot.lds       |  47 +++++++++++
 arch/m68k/include/asm/bootinfo.h      |  31 +++++++
 arch/m68k/lib/Makefile                |   9 +-
 board/emulation/qemu-m68k/Kconfig     |  12 +++
 board/emulation/qemu-m68k/MAINTAINERS |   8 ++
 board/emulation/qemu-m68k/Makefile    |   5 ++
 board/emulation/qemu-m68k/qemu-m68k.c | 115 ++++++++++++++++++++++++++
 configs/qemu-m68k_defconfig           |  16 ++++
 doc/board/emulation/index.rst         |   1 +
 doc/board/emulation/qemu-m68k.rst     |  39 +++++++++
 drivers/rtc/goldfish_rtc.c            |  13 ++-
 drivers/serial/Kconfig                |   8 ++
 drivers/serial/Makefile               |   1 +
 drivers/serial/serial_goldfish.c      | 109 ++++++++++++++++++++++++
 drivers/timer/Kconfig                 |   8 ++
 drivers/timer/Makefile                |   1 +
 drivers/timer/goldfish_timer.c        |  81 ++++++++++++++++++
 include/configs/qemu-m68k.h           |  18 ++++
 include/goldfish_rtc.h                |  15 ++++
 include/goldfish_timer.h              |  13 +++
 include/goldfish_tty.h                |  18 ++++
 30 files changed, 770 insertions(+), 11 deletions(-)
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
 create mode 100644 drivers/timer/goldfish_timer.c
 create mode 100644 include/configs/qemu-m68k.h
 create mode 100644 include/goldfish_rtc.h
 create mode 100644 include/goldfish_timer.h
 create mode 100644 include/goldfish_tty.h

-- 
2.52.0.358.g0dd7633a29-goog

