Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39669C369CB
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 10:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 997EF82AB1;
	Thu, 17 Apr 2025 12:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="dIGKo5oH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2605F82B7C; Thu, 17 Apr 2025 12:17:36 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6809C82A96
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 12:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-abbb12bea54so91257666b.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 03:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1744885053; x=1745489853;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=afGr91QQswqf2Lt5TlL35xn1I1YDNikD6qymbYV/b/A=;
 b=dIGKo5oHj5zmH+O9+oLjp+JDhRY0dvd6XWIW2AhoKnRTTzDnmCQDbmo46FEqEs+HIT
 LCzzK9Hi/+i2sixfOsjvXM7XE3sakDzc4N8ytn9A+880sbr+WdJSRiBHGEQZSkBoXJW3
 UQazq7Uv1jFDPwjcoRzlcK9ikqT0Fl4Cha3Um57Crnbox41g3UzylpnoYzhvPepuqHfL
 9ksOYQgsDRtMorJ/JF4HKQROTPtdaWrNy51qaa5L/wLPMD2pxOh8uj/IkwJ0D70r977p
 z3sP4RkCtra2EDqzqB/lFY/p5xFRq2hpmqRmNz3vtr0E0LQToVAC20J+83mci8FNzld8
 XfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744885053; x=1745489853;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=afGr91QQswqf2Lt5TlL35xn1I1YDNikD6qymbYV/b/A=;
 b=Qyqhf2H99kTItcn851jIwn8cqCrxoMge3dKZc0e3s3Z35XUbZHTCDOHW75uvpPQFUo
 Qk/WN0Xo5ipmtpWYCseAd/A2PMj0y1w043VN1A/9y+5Xx1z/MDDtK2LT84rt5aT4F1wr
 0xekv9sXN4vExsfYkVfsKAEL1JUIdNPoZVgDumlhH5TjPfygBLABV5Kv1c72PqTfzQxf
 XBu06zWyXGXyz6l+IvQWtQIT71ngKtN5VDK/2edZqgKlXLNWP9eMI584I/CXIW6B0eyc
 L6b/FwsyA7GVxta/Wmnf1pwxUgDT2tJYgtl4DlGW/p3MTvtdE6D0At3NFQXNZFJcEJdU
 iPxA==
X-Gm-Message-State: AOJu0Yzz0m62zvF6x42wCYUFNa5m1WdXhiNHlxDFWK4hH+1UoZdQuNlX
 qa70tDICW07+6kDnZX2nI8H/fvQbWLjfD0aFBeLXKHl42kh6R4IGZ8i7scqm0isYFouqRlSslrC
 eAQ==
X-Gm-Gg: ASbGncvXUj/yI3WensryYJNy3+rtSdnT/IpEEv+JLI6UaBc8fgQlO45p6yhHGuDLP8G
 hBz3/OPSGDEuDn/IsCWOSTheAUJB+mgWEep6AHosuIgMUVLLhHI4vh2IZM5ynDns+q941saS4+C
 monIf2lCkbjbobwhPnRv3q4PxY++ZfcSG7e+p8WTvHaeUQ2b2fmCjhr15ZMxiC230S3vdY2zqor
 XsAZLLD3tELJOqbNN0ys7eBE2DwaJCNsB3Mu0CYOjq3c+WCOJxpKs++txQBiTX020razzjkjo1C
 ss5geEfPspDuPcDiDNDis34Zd3NjjnT1HMeRq6NVwdx5bTEmSXUu60G0
X-Google-Smtp-Source: AGHT+IEPKuofUHYXFI9DVQ3o/IKuUXDQ0bAvbV/2WnZVCn3sZxmURouZwJH+jPCVTAcTc/k7NlMNuA==
X-Received: by 2002:a17:907:7207:b0:aca:c8aa:5899 with SMTP id
 a640c23a62f3a-acb428e4905mr431946966b.22.1744885052572; 
 Thu, 17 Apr 2025 03:17:32 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb3cd6257bsm270960466b.13.2025.04.17.03.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 03:17:32 -0700 (PDT)
Message-ID: <ab80d61e-5a76-4d8f-9ed1-7e6ab443292b@monstr.eu>
Date: Thu, 17 Apr 2025 12:17:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] AMD/Xilinx changes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Tom,

please pull these patches to your tree. The biggest LOCs are around BuR Zynq 
boards. The rest are just small updates especially in connection to new Versal 
Gen 2 SoC and extending it's support.

Thanks,
Michal



The following changes since commit a08425586799374ccded78eb5fdef6e2235e1ad9:

   Merge tag 'tpm-master-14042025' of 
https://source.denx.de/u-boot/custodians/u-boot-tpm (2025-04-15 07:36:25 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2025.07-rc1

for you to fetch changes up to 8e25e76fff0698c8268b279af3d7859ed2e14ea5:

   board/BuR/zynq: initial commit (2025-04-16 15:39:48 +0200)

----------------------------------------------------------------
AMD/Xilinx/FPGA changes for v2025.07-rc1

AMD/Xilinx:
- Synchronize enums around tcm_mode
- Access bootmode registers via firmware interface
- Setup default values for DEBUG_UART
- Fix dfu alt buffer clearing
- Convert loadpdi command to fpga
- Fix board detection code
- Minor defconfig updates

Versal:
- Wire multi_boot register

Versal Gen 2:
- Enable missing drivers
- Wire i2c FRU decoding at start
- Wire saving variables to different locations
- Disable default DEBUG_UART
- Wire USB/UFS boot and fix access via firmware interface
- Minor fixes

ZynqMP/Kria:
- Enable mkfwumdata
- Topic board update
- Enhance binman configurations
- Kria usb update

BuR:
- Add multiple Zynq based boards

cadence_ospi:
- Enable device reset

fpga:
- Add support for loading bitstream for Altera SoCs

----------------------------------------------------------------
Bernhard Messerklinger (4):
       board/BuR/common: use strlcpy instead of strncpy
       board/BuR/common: add parameter for reset controller I2C bus selection
       board/BuR/common: split br_resetc_bmode function
       board/BuR/zynq: initial commit

Marek Vasut (1):
       arm64: zynqmp: versal: Consistently use enum tcm_mode

Michal Simek (10):
       xilinx: Enable mkfwumdata tool for a/b update for Kria
       versal2: Fix .*get_bootmode function name
       serial: Setup default base and frequency for Versal platforms
       arm64: versal2: Disable debug console
       arm64: versal2: Disable DEBUG uart for mini configurations
       arm64: zynqmp: Use CONFIG_SPL_FS_LOAD_PAYLOAD_NAME in binman
       amd: versal2: Enable SMBIOS command
       amd: versal2: Enable NVMEM framework
       xilinx: Remove UARTLITE from defconfigs
       xilinx: Free memory when variable is saved in boot_targets_setup()

Mike Looijmans (2):
       xilinx: Allow alternative boot strategies in zynq-common.h
       topic: Use distro_boot for topic-miami boards

Muhammad Hazim Izzat Zamri (2):
       drivers: fpga: Add FPGA configuration during bootm for Intel SOCFPGA
       drivers: fpga: Follow mainline to pass compatible flags to fpga_load

Padmarao Begari (4):
       configs: versal: Fix initial stack pointer
       board: xilinx: Store board info data in data section
       arm64: versal2: Remove dtb reselect and multi dtb
       board: amd: Read an eeprom after relocation

Prasad Kummari (5):
       xilinx: versal: add firmware access to CRP Boot mode register
       xilinx: versal: add firmware access to PMC multi Boot mode register
       arm64: versal-net: Add PL bit stream load support
       arm64: versal2: Add PL bit stream load support
       xilinx: versal: remove versal loadpdi command

Venkatesh Yadav Abbarapu (10):
       amd: versal2: Enable reset and power domain drivers
       amd: versal2: Add the UFS boot mode support
       spi: cadence_ospi: Add device reset via OSPI controller
       ufs: amd-versal2: Use raw read/write for SLCR/CACHE registers
       arm64: versal2: Update the text base and dtb address
       arm64: zynqmp: Start usb automatically via preboot on Kria
       arm64: versal2: Add ufs distro boot command
       arm64: versal2: Add usb distro boot command
       arm64: versal2: Update the number of DRAM banks to 36
       amd: versal2: Add support for saving env based on bootmode

Vincent Stehlé (3):
       arm64: versal: fix dfu alt buffer clearing
       xilinx: zynq: fix dfu alt buffer clearing
       arm64: zynqmp: fix dfu alt buffer clearing

  arch/arm/dts/Makefile                         |   7 +
  arch/arm/dts/zynq-binman-brcp1.dtsi           | 102 +++++++
  arch/arm/dts/zynq-brcp1.dtsi                  | 131 +++++++++
  arch/arm/dts/zynq-brcp150-u-boot.dtsi         |  34 +++
  arch/arm/dts/zynq-brcp150.dts                 | 173 ++++++++++++
  arch/arm/dts/zynq-brcp170-u-boot.dtsi         |  26 ++
  arch/arm/dts/zynq-brcp170.dts                 | 139 ++++++++++
  arch/arm/dts/zynq-brcp1_1r-u-boot.dtsi        |  30 +++
  arch/arm/dts/zynq-brcp1_1r.dts                |  28 ++
  arch/arm/dts/zynq-brcp1_1r_switch-u-boot.dtsi |   1 +
  arch/arm/dts/zynq-brcp1_1r_switch.dts         |  30 +++
  arch/arm/dts/zynq-brcp1_2r-u-boot.dtsi        |   1 +
  arch/arm/dts/zynq-brcp1_2r.dts                |  21 ++
  arch/arm/dts/zynq-brsmarc2-u-boot.dtsi        |  30 +++
  arch/arm/dts/zynq-brsmarc2.dts                | 157 +++++++++++
  arch/arm/dts/zynq-topic-miami.dts             |  33 +--
  arch/arm/dts/zynqmp-binman-som.dts            |  14 +-
  arch/arm/dts/zynqmp-binman.dts                |  14 +-
  arch/arm/mach-versal-net/Kconfig              |   1 -
  arch/arm/mach-versal/Kconfig                  |   1 -
  arch/arm/mach-versal/include/mach/hardware.h  |   2 +
  arch/arm/mach-versal/include/mach/sys_proto.h |  10 +-
  arch/arm/mach-versal/mp.c                     |  12 +-
  arch/arm/mach-versal2/Kconfig                 |   1 -
  arch/arm/mach-versal2/include/mach/hardware.h |   7 +
  arch/arm/mach-zynq/Kconfig                    |   1 +
  arch/arm/mach-zynqmp/cpu.c                    |   2 +-
  arch/arm/mach-zynqmp/include/mach/sys_proto.h |  12 +-
  arch/arm/mach-zynqmp/mp.c                     |  81 +++---
  arch/arm/mach-zynqmp/zynqmp.c                 |   2 +-
  board/BuR/common/Kconfig                      |   8 +
  board/BuR/common/br_resetc.c                  | 139 ++++++----
  board/BuR/common/br_resetc.h                  |   1 +
  board/BuR/common/common.c                     |   2 +-
  board/BuR/zynq/Kconfig                        |  14 +
  board/BuR/zynq/MAINTAINERS                    |  11 +
  board/BuR/zynq/Makefile                       |  15 ++
  board/BuR/zynq/brcp150/board.c                |   4 +
  board/BuR/zynq/brcp150/ps7_init_gpl.c         | 278 ++++++++++++++++++++
  board/BuR/zynq/brcp170/board.c                |   4 +
  board/BuR/zynq/brcp170/ps7_init_gpl.c         | 274 +++++++++++++++++++
  board/BuR/zynq/brcp1_1r/board.c               |   4 +
  board/BuR/zynq/brcp1_1r/ps7_init_gpl.c        | 274 +++++++++++++++++++
  board/BuR/zynq/brcp1_1r_switch/board.c        |   4 +
  board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c | 270 +++++++++++++++++++
  board/BuR/zynq/brcp1_2r/board.c               |   4 +
  board/BuR/zynq/brcp1_2r/ps7_init_gpl.c        | 277 +++++++++++++++++++
  board/BuR/zynq/brsmarc2/board.c               |  30 +++
  board/BuR/zynq/brsmarc2/ps7_init_gpl.c        | 276 +++++++++++++++++++
  board/BuR/zynq/common/board.c                 | 231 ++++++++++++++++
  board/BuR/zynq/env/brcp1.env                  | 109 ++++++++
  board/BuR/zynq/env/brcp150.env                | 119 +++++++++
  board/amd/versal2/Kconfig                     |  16 --
  board/amd/versal2/Makefile                    |   1 -
  board/amd/versal2/board.c                     |  65 ++++-
  board/amd/versal2/cmds.c                      |  80 ------
  board/xilinx/common/board.c                   |   5 +-
  board/xilinx/versal-net/Kconfig               |  17 --
  board/xilinx/versal-net/Makefile              |   1 -
  board/xilinx/versal-net/board.c               |  19 +-
  board/xilinx/versal-net/cmds.c                |  80 ------
  board/xilinx/versal/Kconfig                   |  14 -
  board/xilinx/versal/Makefile                  |   1 -
  board/xilinx/versal/board.c                   |  18 +-
  board/xilinx/versal/cmds.c                    | 101 -------
  board/xilinx/zynq/board.c                     |   2 +-
  board/xilinx/zynqmp/zynqmp.c                  |   2 +-
  board/xilinx/zynqmp/zynqmp_kria.env           |   2 +-
  configs/amd_versal2_mini_defconfig            |   6 -
  configs/amd_versal2_mini_emmc_defconfig       |   6 -
  configs/amd_versal2_mini_ospi_defconfig       |   6 -
  configs/amd_versal2_mini_qspi_defconfig       |   6 -
  configs/amd_versal2_virt_defconfig            |  20 +-
  configs/brcp150_defconfig                     | 121 +++++++++
  configs/brcp170_defconfig                     | 120 +++++++++
  configs/brcp1_1r_defconfig                    | 120 +++++++++
  configs/brcp1_1r_switch_defconfig             | 121 +++++++++
  configs/brcp1_2r_defconfig                    | 120 +++++++++
  configs/brsmarc2_defconfig                    | 120 +++++++++
  configs/topic_miami_defconfig                 |  21 +-
  configs/xilinx_versal_mini_ospi_defconfig     |   2 +-
  configs/xilinx_versal_net_virt_defconfig      |   3 +-
  configs/xilinx_versal_virt_defconfig          |   1 -
  configs/xilinx_zynqmp_kria_defconfig          |   2 +-
  configs/xilinx_zynqmp_virt_defconfig          |   1 -
  drivers/firmware/firmware-zynqmp.c            |  74 ++++++
  drivers/fpga/altera.c                         |  41 +++
  drivers/fpga/versalpl.c                       |  11 +-
  drivers/serial/Kconfig                        |   3 +
  drivers/spi/cadence_ospi_versal.c             |  19 ++
  drivers/spi/cadence_qspi.c                    |   9 +
  drivers/spi/cadence_qspi.h                    |   3 +
  drivers/ufs/ufs-amd-versal2.c                 |  66 +----
  env/Kconfig                                   |   2 +-
  include/configs/amd_versal2.h                 |  16 ++
  include/configs/brzynq.h                      |  21 ++
  include/configs/topic_miami.h                 | 116 ++++----
  include/configs/zynq-common.h                 |   8 +-
  include/xilinx.h                              |   2 +
  include/zynqmp_firmware.h                     |  12 +
  100 files changed, 4445 insertions(+), 629 deletions(-)
  create mode 100644 arch/arm/dts/zynq-binman-brcp1.dtsi
  create mode 100644 arch/arm/dts/zynq-brcp1.dtsi
  create mode 100644 arch/arm/dts/zynq-brcp150-u-boot.dtsi
  create mode 100644 arch/arm/dts/zynq-brcp150.dts
  create mode 100644 arch/arm/dts/zynq-brcp170-u-boot.dtsi
  create mode 100644 arch/arm/dts/zynq-brcp170.dts
  create mode 100644 arch/arm/dts/zynq-brcp1_1r-u-boot.dtsi
  create mode 100644 arch/arm/dts/zynq-brcp1_1r.dts
  create mode 120000 arch/arm/dts/zynq-brcp1_1r_switch-u-boot.dtsi
  create mode 100644 arch/arm/dts/zynq-brcp1_1r_switch.dts
  create mode 120000 arch/arm/dts/zynq-brcp1_2r-u-boot.dtsi
  create mode 100644 arch/arm/dts/zynq-brcp1_2r.dts
  create mode 100644 arch/arm/dts/zynq-brsmarc2-u-boot.dtsi
  create mode 100644 arch/arm/dts/zynq-brsmarc2.dts
  create mode 100644 board/BuR/common/Kconfig
  create mode 100644 board/BuR/zynq/Kconfig
  create mode 100644 board/BuR/zynq/MAINTAINERS
  create mode 100644 board/BuR/zynq/Makefile
  create mode 100644 board/BuR/zynq/brcp150/board.c
  create mode 100644 board/BuR/zynq/brcp150/ps7_init_gpl.c
  create mode 100644 board/BuR/zynq/brcp170/board.c
  create mode 100644 board/BuR/zynq/brcp170/ps7_init_gpl.c
  create mode 100644 board/BuR/zynq/brcp1_1r/board.c
  create mode 100644 board/BuR/zynq/brcp1_1r/ps7_init_gpl.c
  create mode 100644 board/BuR/zynq/brcp1_1r_switch/board.c
  create mode 100644 board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c
  create mode 100644 board/BuR/zynq/brcp1_2r/board.c
  create mode 100644 board/BuR/zynq/brcp1_2r/ps7_init_gpl.c
  create mode 100644 board/BuR/zynq/brsmarc2/board.c
  create mode 100644 board/BuR/zynq/brsmarc2/ps7_init_gpl.c
  create mode 100644 board/BuR/zynq/common/board.c
  create mode 100644 board/BuR/zynq/env/brcp1.env
  create mode 100644 board/BuR/zynq/env/brcp150.env
  delete mode 100644 board/amd/versal2/Kconfig
  delete mode 100644 board/amd/versal2/cmds.c
  delete mode 100644 board/xilinx/versal-net/Kconfig
  delete mode 100644 board/xilinx/versal-net/cmds.c
  delete mode 100644 board/xilinx/versal/Kconfig
  delete mode 100644 board/xilinx/versal/cmds.c
  create mode 100644 configs/brcp150_defconfig
  create mode 100644 configs/brcp170_defconfig
  create mode 100644 configs/brcp1_1r_defconfig
  create mode 100644 configs/brcp1_1r_switch_defconfig
  create mode 100644 configs/brcp1_2r_defconfig
  create mode 100644 configs/brsmarc2_defconfig
  create mode 100644 include/configs/brzynq.h

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
