Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F12EC79FB7
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 18:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5526E83D8A;
	Mon,  5 Jan 2026 19:19:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lgog5AQH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7665183DEE; Mon,  5 Jan 2026 17:52:40 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B98F183D71
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:52:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a0a33d0585so921685ad.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767631956; x=1768236756; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O6tUzJTT+bA1naNelFfJLm7pgmXpUcWb7Mgg/zoOWK4=;
 b=lgog5AQH/wVn5aVCB18vHlWCica0ByphdX4cfiGtpiY+wdH9KnOXFHRFiDphYOF4ij
 y4ScqeDvyFfREyXMmJinjiewmeJscFFQpEDtoBlTnL9p8djdhsE+fkO6bRWhcbCmikao
 /QGnIqyqwohjMFjpXaccjz1bcgv+r2CoplQxuIO2eG7xmxKRdCmxabnQnOmb/AsMMT/Y
 QvxiSmddi5bJZkOXBVn546srXQ+uitSt2w2CjovBMWKCdkgkpRgrKvQHKt6Gf+ZRWqPp
 siFIViGpxesJ261NGrIgolMjSmAlktQhyY3kCU2sX6+YBIpst9JrA5ycw0kGIVNRvAwR
 IIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631956; x=1768236756;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O6tUzJTT+bA1naNelFfJLm7pgmXpUcWb7Mgg/zoOWK4=;
 b=RQZTd5HZZA64PxFux21FKxM2vVaZAcm0sSqH9pKf78ElZCx1s+tdIvZkdtIFy/vsO/
 SA0/XdUznvvUFAlEDIIsrPnIVFZVMm68EbsT9+tXL2Xo4zho7xByY01rH1PdcMwLXLR2
 CtH5B/nlGNIJfTg8OGFwJl0gpogXCzqGVJK06mcPbKMI8FEb2/zqC5/1cmKPpVBMRe6I
 EDm5cPwFt0d+7atbejRKzqM/KqXGB+wcr1oRV/wGyu3iXWkLsSRVOl4Eyd8byz1xSAZw
 ATz8CfspfesbEHjdUelLNzbrHMKp6NWlkUjNBfEZ78N8QXVXDg3x49MskwxzeQgCKmH6
 D5aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWBpuQbXUBHYEtgdasQ9nSB8AUXr97mayuFiNujwdqxOvy8scbdlpRuOjCvr25FjmJTV4dFv8=@lists.denx.de
X-Gm-Message-State: AOJu0YzuXzS26si0rqgkPwhDYAZH7utj5B6nfbVZFYSG4juQ8kv8MAlh
 MEKwZ1jJ3yZaPa+/y2cKhtln0ioRSY/ebgzlG3OmXC+za9jf6bLjuTZ/
X-Gm-Gg: AY/fxX6BF1tGCmskCOxHRKJk3zq5NS2ydeKmVD2IPsBIxTv8PDGYXYWz+1gjLn8/3ju
 Dy9AfptKGAZLg6dq96OXN/7ulVwyoebzHc3s39uk7UczzdYR/JYBT5ve6TC7csN9OA5drJRT+FV
 ht7gN0gRj7Z2rM9e3SrOK5SQO4HYuSnx+aEJviq/9zxJS60qDiGPF8WdOEq2SGVH09LWjHlr/Ur
 xYJnr2fyVljUNmOt0ZxALDcU7ZPt2bgaK4aAHm9J91xBkNbWYyNIxge7nzmMS1/jofnsFLv7AA4
 PcCzEJrZFrjZ6ljge0MbukME8CtYqF6iLue5PjrnQUHCOUnZBlAcvw3C6YvciMJ5fd7bZXmMZrz
 8Mphu3N0nbNvXbyJAwNKafvkMt0f0A8WoKcPJDSXhzLfENXD2JXQ2+CRL+5LmB9X1UF6YzkuN3j
 shVGE2DjDiZPo851FtdRPrRQY/MogrjuF7wN46voO2j6ADXuu6Iv6mnRcAbr/8Ru2S0YXs6Hif5
 tKj9HSWaSjNe3Qk/w7VlF1gH7llyYhr
X-Google-Smtp-Source: AGHT+IFJtbutFY4TSul+pLj5BK112S+/f37/iyd7B/ajGPZ601b94iTxjAbL+029oaN8OFKrztaF2g==
X-Received: by 2002:a17:903:b8b:b0:2a2:acc7:f1ea with SMTP id
 d9443c01a7336-2a3e2e3861amr2217405ad.59.1767631955982; 
 Mon, 05 Jan 2026 08:52:35 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e2ba8748sm2707435ad.101.2026.01.05.08.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:52:35 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v5 0/7] m68k: Add support for QEMU virt machine
Date: Mon,  5 Jan 2026 16:52:14 +0000
Message-ID: <20260105165221.1816070-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 Jan 2026 19:19:16 +0100
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

v4: https://lore.kernel.org/u-boot/20260101175420.4118024-1-visitorckw@gmail.com/
v3: https://lore.kernel.org/u-boot/20251230160112.3045527-1-visitorckw@gmail.com/
v2: https://lore.kernel.org/u-boot/20251226175400.1154417-1-visitorckw@gmail.com/
v1: https://lore.kernel.org/u-boot/20251218185252.957388-1-visitorckw@gmail.com/

Kuan-Wei Chiu (7):
  serial: Add Goldfish TTY driver
  timer: Add Goldfish timer driver
  rtc: goldfish: Support platform data for non-DT probing
  m68k: Add support for M68040 CPU
  board: Add QEMU m68k virt board support
  CI: Add test jobs for QEMU m68k virt machine
  MAINTAINERS: Update m68k entry

 .azure-pipelines.yml                  |   3 +
 .gitlab-ci.yml                        |   6 ++
 MAINTAINERS                           |  21 ++++-
 arch/m68k/Kconfig                     |  25 ++++++
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
 30 files changed, 773 insertions(+), 12 deletions(-)
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

