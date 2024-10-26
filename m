Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A18DD10BFF
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 16:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4653E88E67;
	Sat, 26 Oct 2024 18:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jAumIgbR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9B6D89011; Sat, 26 Oct 2024 17:52:31 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFDA788D70
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 17:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c9589ba577so500390a12.1
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 08:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729957944; x=1730562744; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QHTmbtyHQ24HhuPTgAIEvpWDiX60v1x9tjdux3Oj2gQ=;
 b=jAumIgbR27oZ1lvPgdQs4sUZV78WODQJCiEpd9w2C+AC+s8rzNXDxCr+dHr3hYsUAz
 NUf83Eb05sU8oRTsrcs0AJKi9YL8WcNN2r/3NlhHrB2OShbtQZrpCrP4ti7Z2f5ar9yf
 FubcXtt4Ty8BdZnbunCHgmZIHoColCSF2gGF3Csm84fXn/ZbolUbd8x6zI8qbqV/BasK
 78RZ6eNl01vRjEa3fqWiIrtXTsi3qIu7NcwpklUXLJNbe8Jeh1PR6P7yNE8KVcm4cZHr
 BGqk4XrbnkDAgjmNg3FhAsTn2jwpxzNkaXKb+O0egdwMG6F09Sn3XdSmMWsVN5Eqndxl
 0Luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729957944; x=1730562744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QHTmbtyHQ24HhuPTgAIEvpWDiX60v1x9tjdux3Oj2gQ=;
 b=nxCGlGJF7hST7L3gZ99wLeWpid1fsXZdrGV3OKzyjkFvW0MXp91yf8vKfNIGaBHIlK
 pmsARZ0Nyq8ED/WUcQWsMNdtvHZheiqDoqUp0pvitKaVEP4DWQit98a2IDGeyw7sPTjH
 kBJEgg+OEYjLUFTM/QM9631O67yfn0rPQd6raOVoyt1aIq9meCgB2ClynrVDIAIKAtJ+
 Z/HV376b0gwoJ64qM572jxBjvTjCodLqfwBFBRBC2vlg1qtvBz/840M0bUOixursfNpj
 9H0fjKvAqX9eKwJLNgp6jhcv6nV2fbdds0MH7hEsbdWSrtBrPA/ucEkrMjZxmEiuix//
 o/Aw==
X-Gm-Message-State: AOJu0YxJ1wDhhKxDNXjAXNLy4T/Pris7qwBzcx3WPBfn/VCMx4DKv3Wc
 2bYwaIxF/u7UWfnJBiZtSQw8nBiM623JITLwg65b2iaaTWsN9aRFzRc7ww==
X-Google-Smtp-Source: AGHT+IEOnumUvUPTi4GTRy0SHI1JR1w7Cum2AXk8z6rLLO0c8Mdgq1FkChQSPN4yq11WbggOyz7Axg==
X-Received: by 2002:a05:6402:5188:b0:5cb:69ba:b3d1 with SMTP id
 4fb4d7f45d1cf-5cbbfa82295mr962611a12.7.1729957944018; 
 Sat, 26 Oct 2024 08:52:24 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb63197casm1620179a12.63.2024.10.26.08.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 08:52:22 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH v4 00/11] add support for Enclustra Mercury AA1 SoMs
Date: Sat, 26 Oct 2024 15:52:09 +0000
Message-Id: <20241026155220.26300-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 26 Oct 2024 18:16:43 +0200
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
Lothar Rubusch (11):
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
  doc: develop: orthographic delights

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
 doc/develop/gdb.rst                           |   2 +-
 drivers/misc/Kconfig                          |   2 +-
 include/configs/socfpga_mercury_aa1.h         |  23 ++
 tools/binman/binman.rst                       |   4 +-
 tools/binman/entries.rst                      |  22 +-
 29 files changed, 1511 insertions(+), 26 deletions(-)
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
2.25.1

