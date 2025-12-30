Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3342EE498F
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 16:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5409983F5C;
	Tue, 30 Dec 2025 17:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W6XSvlkU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7484583F6D; Tue, 30 Dec 2025 17:01:32 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA5D183F69
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 17:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7acd9a03ba9so10526630b3a.1
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 08:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767110488; x=1767715288; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3A7meMBvLH+jTEXOuy3hPxlaFLYyk+kgg9Eudy0EUz4=;
 b=W6XSvlkUTe5iI3w65xJijhVfVBz3YbkWTLdo/PtT9vlSoGMi0dzWzafoVmRmOWakun
 6CUM7wvbJ73KLjRqh460ytf02Tg0cZ+Fe2FzFLDwaEoQSkhw6rUSBGKljXqWFneBG2u9
 NVvvmrjGAKA/0iCYeqPWLeSZoxT1nikeRCmYc+G+okk0A6OmeGH202obFZpj453iM/V6
 opPsxyoiD6MsskPLwrGN3GO5QAD9mZf3kbNkEnQnMOvDg0tWQJim0vtctCN/o5rVknBx
 stFfrz7zfPTCTU5Vj22BFHAvxLClMsAfvBRSc8U1cPQebaxiaKu1TcyVB3b39FxlClMa
 eVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767110488; x=1767715288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3A7meMBvLH+jTEXOuy3hPxlaFLYyk+kgg9Eudy0EUz4=;
 b=V11G6nysoXrngajOhTBJnTB3kzsbASIAvxRYwhU4CcL7Vnozq+iy20GoDqAyJLXTw0
 WQ/+KgAaZwNjJdjacR9wOG2EAHovhb24/I39pKq4RohzxQA6ynKR58l7oVsxq+HtW4Fq
 L+MxyHkGy48vylYFwnPaYrDKIkDTMjGI/DUHa+oTaY1KZhEhIhKqy1m0/LZkXaqkNtbb
 OY0/QC7RG/N8s+r8/lFUeMJYkU2Q4hMj7h5to4PSFOpQDUhvriaS2vxroXF/ARFV/N48
 fzG8wWFYz7CZNMjFXQN+Y/O26Sqy0UmqIxlcGJSS8KFpg9XXgNE7d7BTZRDvN/AmTLvM
 4SoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMQ60lX/QMivX/A0CMS6qbzHPdFyyCBiTM1E4afgvwBY14KXK3ifa8T3RzyvyMCzui1cRKK6k=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8F9mm/2LAvtvsy6ZZ+npxX/7PiN7/E3uHAYvtyZUI6c/LGHkO
 KIbZdmXEt8cPopO4ciO7F4+0wYl6k6hj7Odp9TGK5/iUy1CEOrxAb94I
X-Gm-Gg: AY/fxX6Wo8ve5K+o8Xt2SHuSOzn8c4B79Bo1rHAbT9sa4pcQBFKOB4AK7aGrKlEn69v
 6KxFtJmZ5w5WgcqwHJg1Zipr2w9sAC1Cu+06uUQy2tMWnM8mxfhXk6Yl5YTtnqocrXo+yz1fHfC
 gDTzMXOJfRu6IR6qlKzHXZMVEdYn6DB+NoaRVB8S5xKmsdJtF0JBcyPC/Iarj39YdL0gmnX5VE6
 6UnpfwZDWPEcfshXWO9O4T9MGTt1tV73ITWRYmHYt8hQ3l/Y8K0eUcV8gwFs8R2Hr1BFplEfVm2
 RZJhaQUdviLQfsjJzx6N+z2ah/tINMwwo0M4F0YpONrljlMYsOVl+jv4+9ND9hvwZHz0MnWUvOR
 CAmpE0TXrSigBo6ROA1MN+LhPB7cwnKgx05+qDv/bmr/7TIi34pfLiz55JRlsB5JOEv3GrfeRN2
 2jcatLvnHo3QVJdlSXlMdwViM0NDphi93RYrKj1RznZrurmBRdgrczBTc4ae7gWNJauxAZ2JLlU
 GQUokplwaI966/PNxQeEjJyfz480xfC
X-Google-Smtp-Source: AGHT+IFMYbASnR5udvLLUoKi69mwqlffMlD7hK0XDJx+uQlNCqBXr/s1JSgIi//oWyJtYMypcSUKIA==
X-Received: by 2002:a05:6a20:975a:b0:35d:53dc:cb61 with SMTP id
 adf61e73a8af0-37cba052f66mr13012675637.24.1767110487818; 
 Tue, 30 Dec 2025 08:01:27 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7961c8a2sm28558883a12.6.2025.12.30.08.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 08:01:27 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 0/6] m68k: Add support for QEMU virt machine
Date: Tue, 30 Dec 2025 16:01:06 +0000
Message-ID: <20251230160112.3045527-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Dec 2025 17:55:53 +0100
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
 drivers/rtc/goldfish_rtc.c            |  10 ++-
 drivers/serial/Kconfig                |   8 ++
 drivers/serial/Makefile               |   1 +
 drivers/serial/serial_goldfish.c      | 102 +++++++++++++++++++++++
 drivers/timer/Kconfig                 |   8 ++
 drivers/timer/Makefile                |   1 +
 drivers/timer/goldfish_timer.c        |  60 ++++++++++++++
 include/configs/qemu-m68k.h           |  18 ++++
 include/goldfish_rtc.h                |  15 ++++
 include/goldfish_timer.h              |  13 +++
 include/goldfish_tty.h                |  18 ++++
 30 files changed, 740 insertions(+), 10 deletions(-)
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

