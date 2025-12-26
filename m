Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4AFE8FDBE
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 23:03:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DAB783AAC;
	Sat, 27 Dec 2025 00:03:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DnlmhbW0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B55A5839FA; Fri, 26 Dec 2025 18:54:23 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1DDF838FA
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 18:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7f651586be1so3469590b3a.1
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 09:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766771659; x=1767376459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=96IPq7fsTIUkq85KHkhd42Z+/5jipLFzjgx5YF6xDVU=;
 b=DnlmhbW0cTWItEBhGquFeC8r9bZjwoi0spdj1nEIOBR0oDHivbBZMCp6tKxHv8mRQk
 i9EMRCFZ7aDAWGMYJU6SgDZwmI+QoG8cygS/koafq2TXPp+LUfXE2nltUVXDdjAq4RtL
 7A6d2tKhNwU7DEHdb1MeS6ZqVeLVXVxUbqc5bQmhGMprQFssnupWLDFe0grcMFO9KQEL
 AmztZ5gcIm9TujkrKkEnOQCApZwWhT+GO9pRjIBPNex0pEOSC9bwiJ8dSpiuDc74zGy5
 /qWBY6uxzVmQhZpij9cZ2JDkaV2Cx1bFSBPJSkQLuJTv73fVLXHnnw60smclynyAMzN7
 GwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766771659; x=1767376459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96IPq7fsTIUkq85KHkhd42Z+/5jipLFzjgx5YF6xDVU=;
 b=dYb+UF28fYZsffDPJ/TxkV1AZ073uFRyWUSeFRNeQ1QtG2RS7mYWzzAngPLl81a9QD
 5M3958iezXLL8yl7mDPxIg1aaTUl19CPM3xtEOhGX8jLwZRLFf+8Lw773N0CXXhRVkMy
 ic69WkYCQxNRU/WCWoGACT3tCRHx8r48QwRBd2aMhpXj5XG9htjjS9eSPVaIwNhKxQS4
 NHkkZE0GaltFbXvbpwz93xjpyq+/MugiYzHBwfOm3+IW7APVsz2EYBCDeCQNAQvDpECT
 XNEMciQyBSUiCMDuLITxVZO8OkmkTjoheQEECafK3Nth8JP2IxPRGlCMViL9Sdc2Le1r
 pa2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3Um7ZovGJEdVme/8WxEXZJJQ9aC8gFkYPq79ISVJYiaReSJN+70XS3PKtOJ6criH8s6JfOX0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5vc+CnzGuIXpz+bdYdr1hfQlXe97NypGCZEUIEiVfIasDpffq
 XfIum1BMXkXoBpdcKjd57Lqnjq+obtx6oa39tn8xqtQZ9XApfIE5pAFJ
X-Gm-Gg: AY/fxX4Oe/gSqEjFTaJU9A3IwguswvABFxqkdL0472WEA2d/+pm6CvSgsEhtUkU9Mgp
 pGjnIwAUW5/+77ltPLj0+/lQs9XDDuhxJoMKCx2SwqL5bqzds/E8YpzKetMAD6LzOyRNjLjlTOO
 VprTjzyk/uKncH1upWRWRafxv6sMtSABAqC105QAaymne1XevGCtdFZZ31HgiCi7YwRdoGyE9bg
 MaynuYoqCLp6DsUDqO5/naMYH0zr4uMuqI7wnkVsLbwEESwg4nv7KjkVf3oeBCrSJ4k+4iceU8F
 522mN9+c+Tg0LbKpKlyPGxCaVUDNJeOICH0Zsnv20mQQZFu2xFIYqMPhq4rlTl4yu/OqzoTwQEY
 M7Bu5TADJFu6gZflDsd37RYc0MLvhbiRJq5pjY4qHxo3Cu4PyHTIdeIHDVXZCFZsEVXM86eu//q
 +R4THFD9BY3SFl+IUVEXfl+EPMUwZNTCvNZE2Gywh7XHUyk//SKJpkZbwu/ioUug2oGScMKU0gK
 054LaePr47X1ap3VE88vBbGZutIyJ+R
X-Google-Smtp-Source: AGHT+IE19CA1FoAC0K/G0KcV7bUJNI2LAGcm2E/ortIqvwyJTGRm468OEGWY+bCtkv24XErUBko8DQ==
X-Received: by 2002:a05:6a00:944e:b0:7e8:3fcb:9afd with SMTP id
 d2e1a72fcca58-7fe0d79eabamr23940351b3a.19.1766771659188; 
 Fri, 26 Dec 2025 09:54:19 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e0a0595sm22463704b3a.44.2025.12.26.09.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 09:54:18 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org
Cc: trini@konsulko.com, me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 0/4] m68k: Add support for QEMU virt machine
Date: Fri, 26 Dec 2025 17:53:56 +0000
Message-ID: <20251226175400.1154417-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 27 Dec 2025 00:03:47 +0100
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

v1: https://lore.kernel.org/u-boot/20251218185252.957388-1-visitorckw@gmail.com/

Kuan-Wei Chiu (4):
  serial: Add Goldfish TTY driver
  m68k: Add support for M68040 CPU
  board: Add QEMU m68k virt board support
  CI: Add test jobs for QEMU m68k virt machine

 .azure-pipelines.yml                  |   4 +
 .gitlab-ci.yml                        |   7 ++
 MAINTAINERS                           |  12 +++
 arch/m68k/Kconfig                     |  24 ++++++
 arch/m68k/Makefile                    |   1 +
 arch/m68k/config.mk                   |  10 ++-
 arch/m68k/cpu/m680x0/Makefile         |   6 ++
 arch/m68k/cpu/m680x0/cpu.c            |  77 +++++++++++++++++++
 arch/m68k/cpu/m680x0/start.S          |  73 ++++++++++++++++++
 arch/m68k/cpu/m680x0/u-boot.lds       |  47 ++++++++++++
 arch/m68k/include/asm/bootinfo.h      |  31 ++++++++
 arch/m68k/lib/Makefile                |   9 +--
 board/emulation/qemu-m68k/Kconfig     |  12 +++
 board/emulation/qemu-m68k/MAINTAINERS |   8 ++
 board/emulation/qemu-m68k/Makefile    |   5 ++
 board/emulation/qemu-m68k/qemu-m68k.c |  84 +++++++++++++++++++++
 configs/qemu-m68k_defconfig           |  12 +++
 doc/board/emulation/index.rst         |   1 +
 doc/board/emulation/qemu-m68k.rst     |  38 ++++++++++
 drivers/serial/Kconfig                |   8 ++
 drivers/serial/Makefile               |   1 +
 drivers/serial/serial_goldfish.c      | 104 ++++++++++++++++++++++++++
 include/configs/qemu-m68k.h           |  18 +++++
 include/goldfish_tty.h                |  18 +++++
 24 files changed, 602 insertions(+), 8 deletions(-)
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
 create mode 100644 include/configs/qemu-m68k.h
 create mode 100644 include/goldfish_tty.h

-- 
2.52.0.358.g0dd7633a29-goog

