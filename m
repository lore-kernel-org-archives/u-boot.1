Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D40FD6C2B9
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 00:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5441A89617;
	Wed, 20 Nov 2024 01:27:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mf8wRXs+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF168895DC; Tue, 19 Nov 2024 23:46:50 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C78188ED9
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 23:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43159555f29so5964525e9.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732056406; x=1732661206; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+2bqoT9z3FBe5Beh9Pn23jgYbyWOAduMEnsv0pAUZxo=;
 b=mf8wRXs+48k1d/0ex+ADHAnjrV1neI+60z7Xbh6oLKsyypICixzzBy5oqRplik6sfX
 BZZhvCAO1osx558AWrrUrbr61VFp6Q14LHu02zo4Qu5OlJh9Nha4EJdgdxIP1fmsu6le
 dOwOZz2jgko/+r5ZZdq/ztvvyXcUBUtjzdsEf07hatEjnrcvUl58CGf/iAcLOIIDMCW2
 UUoPtWnSLtajygGhjlNbbtMEh+EDKIYPyF9QSMuAf4GTwqw/Hm/xiIy9jmFHIzyw8s7L
 An6jM6GQ5JWNL4M8zLiUXYFxN4GNRbaONPFB+J0hCVQ3oubYj1C34cnCMLxbHQsQiyVU
 +zWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732056406; x=1732661206;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+2bqoT9z3FBe5Beh9Pn23jgYbyWOAduMEnsv0pAUZxo=;
 b=HC1dmzHlYX409R3pR2t5g8y4BgN7sE3YaT18fI12cTsyNJxYezgwp7vBM+WsuHOSK6
 E066khQ1JSITw3vHRMTIE1jfkrUS565+UJ7wp1b7deajCf7c8wcRrSHNxdlllwAS7FMm
 2ols4MJ9dZ3LpgmBkGxfpiFuYPyKJ/shnTKls7CBHgkDui0noglBlURvgCNG3WXGIirB
 Rn4TlsMjAWvNzipaTgAtGvmYycw9yBWe52vNp7ppODUtvQ64slwGOb/e828v1XsdFMBh
 6suDUlVU7ms0P+bvHHN1+jCBpLTjP22CAB8X6cmv+uBx02XAkHIPoq77ViqfGl7E7sCr
 Mr9w==
X-Gm-Message-State: AOJu0YyFs3l162sSVF4ggk4+yHHnTgFnRm0aRhr54OWpoBOCMKG+cdwJ
 dV9trn9lm3Q8SCiLg1nVWzsYCWvXFCshQXaEibDLSpV9EnKYg6TjxRTnmq+H
X-Gm-Gg: ASbGnctvRxEtUQ5QcqZ+cAe/ldLFbECHwmYe/7e92nPchCSrN0X0ZcOZ8E98P+7/ms1
 w971i3S3i7XERiCKq7qAEoWk93c27Vui/Z4N+nMw6BTbLXrZ+UGIN8m/LUby2EWU+xmdipIjLTV
 Xa9980JQFyNojJFh7Um+Iqngk51+pzHpy4OjUoRHdULIZ2jK2aK1xXBNv1jB3TkWjgm0+4fWMuC
 ogyMaXmtsWzVGRgDbHlKUzhaAtdJUyF7dtYqNtqhMX7pl8LYHaTFZPa2qCHNg2iQTzrR6ZrRPzP
 DL8+X6JRx0RI/d1KUiruRvuAHawV
X-Google-Smtp-Source: AGHT+IHsOc7G3/yFb9G66QBthPjeXgebogYD0B1KbLa7NHGaCAOxDL1j7d0YywJu0gcaW/WVk4cq0A==
X-Received: by 2002:a05:600c:444f:b0:430:4db0:3ffd with SMTP id
 5b1f17b1804b1-4334f013d8cmr1917235e9.4.1732056405692; 
 Tue, 19 Nov 2024 14:46:45 -0800 (PST)
Received: from d71e1d1a2016.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da27fc8esm216979795e9.21.2024.11.19.14.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 14:46:44 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH v4 v5 00/10] add support for Enclustra Mercury AA1 SoMs
Date: Tue, 19 Nov 2024 22:46:33 +0000
Message-Id: <20241119224643.27692-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Nov 2024 01:27:55 +0100
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

Introduce the support for three variants of Enclustra's Intel Mercury AA1 (with
Intel Arria10) SoMs and additional configs.

The DT approach is partly based on dts/upstream, which are (going to be)
upstreamed to the linux kernel.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v4 -> v5:
- exclude typo / wording fixes for binman.rst, gdb.rst and binman/entries.rst
- implicitely builds using binman
v3 -> v4:
- fix wrong mail address in v2 and author
- update scripts for stdboot and generic load
- clean up patch organization (patch 7/10 was malformed and almost empty,
  added and removed stances,..)
- fix binding used for "enclustra,altera_set_storage"
- separate u-boot specific part of .dts to a
  socfpga_arria10_mercury_aa1-u-boot.dtsi file
- integrate fpga.itb build with binman in the -u-boot.dtsi file
  note:
  1. due to binman, now the build will need binman build (i.e. requirements)
     and is build then with "make NO_PYTHON=1"
  2. the fpga bitstream files bitstream.core.rbf and bitstream.periph.rbf
     are generated by a particular Quartus design, so they can't be committed
     here. This makes the build fail, if build with binman.
     For testing, thus build with
     "make CONFIG_BINMAN=n"
- fix some typos in binman and gdb documentation (additional patch)

v2 -> v3:
- update of DT concept to work with dts/upstream
- update of DT parts in arch/arm/dts, because of:
  -- the handoff initialization of the Arria10 SoC
  -- the fpga loader for the bitstream in the DTS
  -- the adjustments to access the boot media, from where to load the fpga.itb
  -- and to mux media for booting, e.g. QSPI off, when booting from MMC
- implementation of kconfig options to combine SoM .dtsi file, carrier board
  .dtsi files, boot-mode parts, and so on resulting in a single .dts
  file located in arch/arm/dts because of the above mentioned reasons
- adjustents to (better) satisfy dtb checks
- updated MAINTAINERS
- updated documentation
- update to use standard boot and environment as only environment, removal of
  explicit variables and environment files
- removal of duplicate codes
- cleanup and implement altera_set_storage (boot media switch command in
  u-boot shell) based on DM
- fix spansion flash access to allow flashing from off the u-boot shell,
  this patch was already presented separately, the fix is actively needed for
  the AA1 SoM
- sort lists in several files alfabetically
- update boot commands using && instead of ;

v1 -> v2:
- removal si5338 driver
- removal si5338 driver usage
- rename .c file for the boot cmd, build conditionally
- add separate .c file for late boot init to read MAC address from eeprom
- keep DT approach for u-boot under discussion
- fix issues in doc
- update MAINTAINERS to cover doc

---
Lothar Rubusch (10):
  doc: board: enclustra: add Enclustra Mercury+ AA1
  ARM: socfpga: add Mercury+ AA1 SoM support
  ARM: dts: socfpga: add Mercury+ AA1 for u-boot dts
  ARM: socfpga: add Enclustra storage switch
  ARM: socfpga: add Mercury+ AA1 boot scripts
  ARM: socfpga: AA1: support MAC from secure eeprom
  misc: atsha204a: update kconfig description
  ARM: dts: arria10: update according to DTSpec
  ARM: socfpga: update function call to modern API
  ARM: socfpga: apply binman approach to fpga parts

 arch/arm/dts/socfpga_arria10.dtsi             |  42 ++-
 ..._arria10_enclustra_mercury_aa1-u-boot.dtsi |  89 +++++
 .../socfpga_arria10_enclustra_mercury_aa1.dts |  62 ++++
 .../socfpga_arria10_mercury_aa1-u-boot.dtsi   |  19 ++
 .../dts/socfpga_arria10_mercury_aa1_handoff.h | 305 ++++++++++++++++++
 arch/arm/mach-socfpga/Kconfig                 |  10 +
 arch/arm/mach-socfpga/misc_arria10.c          |   2 -
 board/enclustra/bootscripts/qspi-aa1.cmd      |  12 +
 board/enclustra/bootscripts/sd-aa1.cmd        |   9 +
 board/enclustra/common/Kconfig                |  25 ++
 board/enclustra/common/Makefile               |   7 +
 board/enclustra/common/enclustra_mac.h        |  48 +++
 board/enclustra/common/mac_atsha204.c         | 102 ++++++
 board/enclustra/common/mac_common.c           |  52 +++
 board/enclustra/common/mac_ds28.c             |  93 ++++++
 board/enclustra/mercury_aa1/Kconfig           |  52 +++
 board/enclustra/mercury_aa1/MAINTAINERS       |  12 +
 board/enclustra/mercury_aa1/Makefile          |  10 +
 .../mercury_aa1/aa1_board_late_init.c         |  17 +
 .../mercury_aa1/aa1_set_storage_cmd.c         | 190 +++++++++++
 .../socfpga_enclustra_mercury_aa1_defconfig   |  86 +++++
 doc/board/enclustra/index.rst                 |   9 +
 doc/board/enclustra/mercury-aa1.rst           | 230 +++++++++++++
 doc/board/index.rst                           |   1 +
 drivers/misc/Kconfig                          |   2 +-
 include/configs/socfpga_mercury_aa1.h         |  23 ++
 26 files changed, 1497 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
 create mode 100644 arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h
 create mode 100644 board/enclustra/bootscripts/qspi-aa1.cmd
 create mode 100644 board/enclustra/bootscripts/sd-aa1.cmd
 create mode 100644 board/enclustra/common/Kconfig
 create mode 100644 board/enclustra/common/Makefile
 create mode 100644 board/enclustra/common/enclustra_mac.h
 create mode 100644 board/enclustra/common/mac_atsha204.c
 create mode 100644 board/enclustra/common/mac_common.c
 create mode 100644 board/enclustra/common/mac_ds28.c
 create mode 100644 board/enclustra/mercury_aa1/Kconfig
 create mode 100644 board/enclustra/mercury_aa1/MAINTAINERS
 create mode 100644 board/enclustra/mercury_aa1/Makefile
 create mode 100644 board/enclustra/mercury_aa1/aa1_board_late_init.c
 create mode 100644 board/enclustra/mercury_aa1/aa1_set_storage_cmd.c
 create mode 100644 configs/socfpga_enclustra_mercury_aa1_defconfig
 create mode 100644 doc/board/enclustra/index.rst
 create mode 100644 doc/board/enclustra/mercury-aa1.rst
 create mode 100644 include/configs/socfpga_mercury_aa1.h

-- 
2.39.2

