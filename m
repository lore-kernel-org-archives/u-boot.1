Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C096E71068
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 12:57:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C07ED8645F;
	Thu, 21 Sep 2023 14:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="0vEHNv7B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D84386484; Thu, 21 Sep 2023 14:57:08 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5478286420
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 14:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9ad810be221so109374366b.2
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 05:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1695301026; x=1695905826;
 darn=lists.denx.de; 
 h=content-transfer-encoding:autocrypt:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWNFMlqxEs6OmBqMuPBBfui4BImZaamIxgW6V6YbMow=;
 b=0vEHNv7BYrcj8aMGR2f2foWXuftvckdQxiGChczp/zrwaosb9zI/EzijOXdQMsp2uB
 1U99sgBsMy8iRE2jpT8gD3FtpW3dYfRyAdbvNTNFuweVJgtZZL6QtXkxN/mmwoN+YGXP
 bbV+VjTd+0W6+9ukWV8oY2xsP2I/iUIK7RBiTG97gC9xlb3MKTTK/tMK4RL/xGHasksO
 tqsXJsKinwk1ty8RnoR/d4N5NYG84FPVDAC7ILKJjWsPBQd8q0yACiQXqN+eSCx3rQvK
 yBoGbVXwoglKUbiMeZTX4USM0kHAiqF0BvnitolA3PYsPOYmFkALE/2w/+RGrebLa8AS
 GzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695301026; x=1695905826;
 h=content-transfer-encoding:autocrypt:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wWNFMlqxEs6OmBqMuPBBfui4BImZaamIxgW6V6YbMow=;
 b=n/exYNqxPDGKv6vW3PsGLBn6LQBbiSf7jrG93SJwp4PV5mCn4wAUwSLctrTvUbJS8S
 i7AmOepsXZiAg+CHlLdackbo8/lXK35rSCRxZnIQbYfdrGY3TcfDUIREz9qRlOQqqkEs
 iDe84NjXxI8o+ZnTt2sD+/Kx89zP49Z83Y95nnlDoGq+xLIeIJ06lTV9+tJm7YJ4ROgR
 IpqfO3rlS6aizfx72HJnULtPdBLhi7TkacDJ0RVQm8oX2OVJvAAhrbWsPMILQxheYkIK
 RLUtcCZgz16ZcskjvXIqOPRPsuiSNEM5qLMau2TJUshBSrUYIQoxVrUrWAOo6b2WhMhj
 /DNw==
X-Gm-Message-State: AOJu0YyH2dWBSXSaxvMKEFjspsJ+ldgaR3UeGqhmxlumDZrrx+/9SMdS
 orkt6Novz9mvgRm5CVR6B/qvmQ==
X-Google-Smtp-Source: AGHT+IFoIffELHOfIyU7xPJo5u4LmzzUTEQpN1yP22Qv3312F3diLrnurSaNzb+2GS5YQRWmhwMZ/A==
X-Received: by 2002:a17:907:2da3:b0:9a1:f521:c3ff with SMTP id
 gt35-20020a1709072da300b009a1f521c3ffmr6626080ejc.40.1695301025488; 
 Thu, 21 Sep 2023 05:57:05 -0700 (PDT)
Received: from [192.168.137.2] ([149.199.62.128])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a170906584d00b00992b8d56f3asm1008278ejs.105.2023.09.21.05.57.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 05:57:04 -0700 (PDT)
Message-ID: <836f196c-e6db-41fd-9bfd-8d48d14c5800@monstr.eu>
Date: Thu, 21 Sep 2023 14:56:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] xilinx patches for v2024.01-rc1 v2
Autocrypt: addr=monstr@monstr.eu; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

please pull these patches to your next branch.
I am sending it as v2 in spite of v1 didn't really went through. I created tag 
but CI failed because of sandbox CI trace failure. After fixing it and reviewing 
by Simon I am adding it to be able to extend ofnode functions for getting 
functionality for our SOCs. All non Xilinx patches are reviewed mostly by Simon.

There are other pending changes which are still under review which should go to 
v2024.01 but I wanted to get this part done because amount of patches is bigger 
than I would like have.

I was thinking about sending cmd/flash_is_unloacked fix to 2023.07 but it looks 
like none is actually using spi locking that's why it shouldn't be a problem to 
fix in 2024.01. But feel free to pick it up to master if you like.

Thanks,
Michal


The following changes since commit c58ee1c9946a1550b1f6fee2b25da9ecc89baf71:

   Merge branch '2023-09-19-tidy-up-some-kconfig-options' into next (2023-09-19 
17:44:18 -0400)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2024.01-rc1-v2

for you to fetch changes up to a3ade3dae4d93f9b5282ddb4885d69161729ec6d:

   spi: zynqmp_qspi: Workaround for small data cache issue (2023-09-21 13:20:12 
+0200)

----------------------------------------------------------------
Xilinx changes for v2024.01-rc1

clk:
- Dont return error when assigned-clocks is empty or missing

dm:
- Support reading a single indexed u64 value
- Add support for reading bootscript address/flash address from DT

cmd:
- Fix flash_is_unlocked API

fpga:
- Define fpga_load() for debug build

global:
- U-Boot project name cleanup (next2)

net:
- zynq_gem: Use generic_phy_valid() helper
- axienet: Convert to ofnode functions
- gmii2rgmii: Read bridge address from DT

pytest:
- skip tpm2_startup when env__tpm_device_test_skip=True

spi-nor:
- Add mx25u25635f support
- zynqmp_qspi: Tune cache behavior

trace:
- Fix flyrecord alignment issue

xilinx:
- Move scriptaddr to DT as bootscr-address
- Pick script_offset_f/script_size_f from DT as bootscr-flash-offset/size
- Do not generate distro boot variables if disabled

versal:
- Extend memory ranges to cover HBM
- Enable TPM, sha1sum and KASLRSEED
- Fix distroboot prioritization in connection to available devices
- Clean mini targets bootcommand
- Fix clock driver

versal-net:
- Enable TPM, sha1sum and KASLRSEED
- Fix distroboot prioritization in connection to available devices

zynqmp;
- Allow AES to run from SPL
- Enable CMD_KASLRSEED
- Add proper dependencies for USB and remove ZYNQMP_USB
- Fix user si570 default frequency for zcu* boards
- Cover SOM rev2 revision
- Various DT changes
- Add firmware and pinctrl support for tristate configuration
   (high impedance/output enable)
- Add output-enable pins to SOMs
- Fix distroboot prioritization in connection to available devices
- Read bootscript address/flash address from DT
- Fix pcap_prog address

----------------------------------------------------------------
Algapally Santosh Sagar (1):
       xilinx: board: Add support to pick bootscr address from DT

Amit Kumar Mahapatra (1):
       arm64: versal: Add no-wp DT property in OSPI flash node

Ashok Reddy Soma (5):
       firmware: zynqmp: Add support to check feature
       pinctrl: zynqmp: Add version check for TRISTATE configuration
       pinctrl: zynqmp: Add support for output-enable and bias-high-impedance
       clk: Dont return error when assigned-clocks is empty or missing
       spi: zynqmp_qspi: Change flush cache to invalidate cache

Chanho Park (1):
       fpga: define dummy fpga_load function for debug build

Christian Taedcke (1):
       xilinx: zynqmp: Extract aes operation into new file

Lukas Funke (1):
       arm64: zynqmp: Corrected pcap_prog register address

Maxim Kochetkov (1):
       net: axi_emac: Convert to ofnode functions

Michal Simek (16):
       xilinx: Remove scriptaddr from config files and move it to DT
       arm64: zynqmp: Setup default si570 frequency to 156.25MHz
       arm64: zynqmp: Add support for K26 rev2 boards
       dm: core: support reading a single indexed u64 value
       test/py: tpm2: skip tpm2_startup when env__tpm_device_test_skip=True
       dm: core: ofnode: Add ofnode_read_bootscript_address()
       dm: core: ofnode: Add ofnode_read_bootscript_flash()
       xilinx: board: Add support to pick bootscr flash offset/size from DT
       arm64: versal: Do not define boot command for mini configurations
       arm64: xilinx: Guard distro boot variable generation
       global: Use proper project name U-Boot (next2)
       dm: core: ofnode: Fix error message in ofnode_read_bootscript_address/flash()
       arm64: zynqmp: Rename xlnx, mio_bank to xlnx, mio-bank for DLC21
       trace: Use 64bit variable for start and len
       trace: Move trace_clocks description above record offset calculation
       trace: Fix alignment logic in flyrecord header

Neal Frager (2):
       drivers/mtd/spi/spi-nor-ids.c: add mx25u25635f support
       arm64: zynqmp: Add output-enable pins to SOMs

Saeed Nowshadi (1):
       arm64: zynqmp: Fix i2c address for si570_user1 clock

Srinivas Neeli (1):
       arm64: zynqmp: Add resets property for CAN nodes

Tejas Bhumkar (1):
       net: phy: xilinx-gmii2rgmii: Removed hardcoded phy address 0 for bridge

Thippeswamy Havalige (1):
       arm64: zynqmp: Update ECAM size to discover up to 256 buses

Venkatesh Yadav Abbarapu (16):
       arm64: versal: Increase the number of DRAM banks to 36
       arm64: zynqmp: Enable the config CMD_KASLRSEED
       arm64: versal: Enable TPM for xilinx platforms
       arm64: versal: Enable sha1sum command
       arm64: versal: Enable the config CMD_KASLRSEED
       arm64: versal-net: Enable TPM for xilinx platforms
       arm64: versal-net: Enable sha1sum command
       arm64: versal-net: Enable the config CMD_KASLRSEED
       xilinx: versal-net: Do not setup boot_targets if driver is not enabled
       xilinx: versal: Do not setup boot_targets if driver is not enabled
       xilinx: zynqmp: Do not setup boot_targets if driver is not enabled
       clk: versal: Fix the function versal_clock_ref
       cmd: thordown: Add proper dependency for CMD_THOR_DOWNLOAD
       zynqmp: config: Add proper dependencies for USB
       cmd: sf: Fix the flash_is_unlocked api size parameter
       spi: zynqmp_qspi: Workaround for small data cache issue

  arch/arm/dts/versal-mini-ospi.dtsi             |   1 +
  arch/arm/dts/versal-net-mini-ospi.dtsi         |   1 +
  arch/arm/dts/xilinx-versal-net-virt.dts        |   6 +
  arch/arm/dts/xilinx-versal-virt.dts            |   6 +
  arch/arm/dts/zynq-7000.dtsi                    |   7 ++
  arch/arm/dts/zynqmp-dlc21-revA.dts             |   4 +-
  arch/arm/dts/zynqmp-e-a2197-00-revA.dts        |   7 +-
  arch/arm/dts/zynqmp-sck-kr-g-revA.dts          |   6 +
  arch/arm/dts/zynqmp-sck-kr-g-revB.dts          |   6 +
  arch/arm/dts/zynqmp-sck-kv-g-revA.dts          |   5 +
  arch/arm/dts/zynqmp-sck-kv-g-revB.dts          |   5 +
  arch/arm/dts/zynqmp-sm-k26-revA.dts            |   8 +-
  arch/arm/dts/zynqmp-smk-k26-revA.dts           |   8 +-
  arch/arm/dts/zynqmp-zcu102-revA.dts            |   2 +-
  arch/arm/dts/zynqmp-zcu106-revA.dts            |   2 +-
  arch/arm/dts/zynqmp-zcu208-revA.dts            |   2 +-
  arch/arm/dts/zynqmp-zcu216-revA.dts            |   2 +-
  arch/arm/dts/zynqmp.dtsi                       |  11 +-
  arch/arm/mach-zynqmp/Kconfig                   |   3 -
  arch/arm/mach-zynqmp/Makefile                  |   3 +-
  arch/arm/mach-zynqmp/aes.c                     |  59 +++++++++
  arch/arm/mach-zynqmp/include/mach/hardware.h   |   2 +-
  arch/arm/mach-zynqmp/include/mach/zynqmp_aes.h |  32 +++++
  arch/sandbox/dts/test.dts                      |  26 ++++
  board/cobra5272/README                         |  18 +--
  board/emulation/qemu-ppce500/qemu-ppce500.c    |   2 +-
  board/xilinx/common/board.c                    |  33 +++++-
  board/xilinx/versal-net/board.c                | 102 +++++++++-------
  board/xilinx/versal/board.c                    |  96 ++++++++-------
  board/xilinx/zynqmp/cmds.c                     |  43 +------
  board/xilinx/zynqmp/zynqmp.c                   | 125 +++++++++++---------
  cmd/Kconfig                                    |   2 +
  cmd/sf.c                                       |   2 +-
  configs/xilinx_versal_mini_defconfig           |   2 -
  configs/xilinx_versal_mini_emmc0_defconfig     |   2 -
  configs/xilinx_versal_mini_emmc1_defconfig     |   2 -
  configs/xilinx_versal_net_virt_defconfig       |   6 +-
  configs/xilinx_versal_virt_defconfig           |   7 +-
  configs/xilinx_zynqmp_virt_defconfig           |   2 +-
  doc/board/xilinx/zynq.rst                      |   2 +-
  doc/board/xilinx/zynqmp-r5.rst                 |   4 +-
  doc/imx/mkimage/imximage.txt                   |   2 +-
  doc/usage/environment.rst                      |   2 +-
  doc/usage/semihosting.rst                      |   2 +-
  drivers/clk/clk-uclass.c                       |   8 +-
  drivers/clk/clk_versal.c                       |  98 +++++++++------
  drivers/core/of_access.c                       |  16 ++-
  drivers/core/ofnode.c                          |  89 ++++++++++++++
  drivers/firmware/firmware-zynqmp.c             |  13 ++
  drivers/mtd/spi/spi-nor-ids.c                  |   1 +
  drivers/net/phy/phy.c                          |   5 +-
  drivers/net/xilinx_axi_emac.c                  |  50 ++++----
  drivers/pinctrl/pinctrl-zynqmp.c               |  15 +++
  drivers/spi/zynqmp_gqspi.c                     |   4 +-
  include/configs/xilinx_versal.h                |   7 +-
  include/configs/xilinx_versal_net.h            |   7 +-
  include/configs/xilinx_zynqmp.h                |  11 +-
  include/configs/zynq-common.h                  |   2 -
  include/dm/of_access.h                         |  19 +++
  include/dm/ofnode.h                            |  65 ++++++++++
  include/fpga.h                                 |   8 ++
  include/zynqmp_firmware.h                      |   3 +
  test/dm/clk.c                                  |   9 ++
  test/dm/ofnode.c                               |  27 +++++
  test/py/tests/test_tpm2.py                     |   3 +
  tools/proftool.c                               |  39 +++++-
  66 files changed, 858 insertions(+), 311 deletions(-)
  create mode 100644 arch/arm/mach-zynqmp/aes.c
  create mode 100644 arch/arm/mach-zynqmp/include/mach/zynqmp_aes.h

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
