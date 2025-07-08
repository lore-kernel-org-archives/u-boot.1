Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C0CC8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 15:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 539DB83390;
	Tue,  8 Jul 2025 17:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="y5CvyTX2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 157C083390; Tue,  8 Jul 2025 17:35:37 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7DFB832F0
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 17:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ae0d758c3a2so751534266b.2
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 08:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1751988934; x=1752593734;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oIU5KmbOc0FVRlI3BOhsjkiTNoK0U3ceqDvHi8115ao=;
 b=y5CvyTX2hXqUrb67f0p6lT1i4NL34khjMQRJTRg0ve1LyImbcKsGA6fIc1q9aO//4S
 LvuN9pOXlKVz0yEN5ABgpQXt78ZAiiLWVBiz+43mFvYmqEXYz7ifG7/e/kXt2cviloxp
 nkmLBgtJtDO6f3U0DCjhjguuvNbOVM5fY3x0EMfDdHm+Zn9Xt72nbLf21QI5JUlv1s/L
 DOwGv8DsQUpH8PZcRCz9wo5CkIlWZfL3RCmsrDyLNa3whl0BjL+eQCyq4DXoKMbVMwFx
 UPwsEyAwisuwDO2TFIziW4Bb65qwBPAIzyw4MmQZ5Lc0N6cWWleb18Qhkomh2TfHHwQF
 F9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751988934; x=1752593734;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oIU5KmbOc0FVRlI3BOhsjkiTNoK0U3ceqDvHi8115ao=;
 b=E3ieOvpRfiWUZTzJ/E1gUEhKffo97/rDeLu8KJNOvR2DXcXfpXKm3FeLIEmnRvpT/5
 CJXgiUN/mFyOX7EWFMtYhmhaPRTO8lcj6g2f+9gQJZwEB3apIxwF6Jynj3DoXi3XNC+T
 S2fh0odoPBZ80DASh18JEv2CYQLs4tZIaK54yhnivha9R5jB/vWVOKWrHaw3ijTTrnrX
 8ncvwNAM6bdpmyc04NlFtP5j1Izu4aS+wDXFC0Tde02kghpPLhuUddxHcAzXcQ4nD5mm
 ofvR8Qs/sLu+XVu+HaDUsdxe8D9YHAPr2pF1EKxmviff2DQt8vclmCiHN+myknIopT5H
 PSxw==
X-Gm-Message-State: AOJu0Yw/p/qppCjBL8t0I63Pwpkf/MqyY9H7wO18cc08jsNQ2VRVpG0v
 dnrvRQJub69dlbm1LCTLK/XkYHnhdLWcKno2DENtz4ZrGPiQCUSX+Dym9Ey6AYosYWxDqldscOH
 FGqxDZQ==
X-Gm-Gg: ASbGncvl06i5+lIRfASxJdASW4kuR21BlMES1fk5MwhI9u4eZLPEAoyyyFWh4VBzudJ
 d7gfn52GcJjX6Glj0MOxrTvk8v5FZXGL/tkGWAQ45hLRw+hssCEPfno/jZ71tI0jKZCY2HBDbuX
 8ES11htRf5CsFmTo1sVemWTSTf+vOd5gqnKdVp5V4Jzd4x5vUNAmHgqBhw5Cg2oC/3Ncp+l4oua
 /pBqSLzbIXs8H/HDzux6+MKltp86XDyo45OiKh5f7IXvSUl8k8GEGMvS8zInyoIdg1lBc3wGhNO
 BYFaJBokNirjzHGuS+NVAQqkppOS7g7HyhVmRaQJz20Tx+RBxl3k6XzqII/d4fwzJZWE3aU9Zgg
 =
X-Google-Smtp-Source: AGHT+IF10T1oSKib8ZluT0QKzzaV3tC6VQFIkcICiYa2rnz5yhPbfsbU3ao2HsFSs52UrzEeup9Tig==
X-Received: by 2002:a17:907:9705:b0:ae0:b3cd:b7f8 with SMTP id
 a640c23a62f3a-ae6b0e30386mr417918866b.40.1751988933870; 
 Tue, 08 Jul 2025 08:35:33 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f692fdcesm918678966b.63.2025.07.08.08.35.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 08:35:33 -0700 (PDT)
Message-ID: <4fb58823-45e5-4cbb-b3cb-f648e42d9104@monstr.eu>
Date: Tue, 8 Jul 2025 17:35:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] AMD/Xilinx changes for 2025-10-rc1
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

please pull these patches to your tree. Gitlab CI is not reporting any new 
issue. Most of the changes are related to mini configurations and then small 
cleanups which I have collected so far.

Thanks,
Michal

The following changes since commit b379335f141e3ddca0cdbb5d9d39af0444530542:

   configs: Resync with savedefconfig (2025-07-07 14:15:18 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2025.10-rc1

for you to fetch changes up to a00f312e745db563e5c992e461dc4d24ed949370:

   arm64: versal2: Remove the ZynqMP Firmware from mini ospi (2025-07-08 
15:01:25 +0200)

----------------------------------------------------------------
AMD/Xilinx changes for v2025.10-rc1

cmd:
- Introduce CMD_HELP Kconfig option

fpga:
- Fix in intel_smd_mb

mini:
- Remove simple-bus driver and description
- Disable CMD_HELP

firmware:
- Fix dependencies
- Switch to new SMC firmware format

cadence qspi:
- Fix read/write STIG mode
- Set tshsl_ns to at least one sclk_ns

sdhci:
- Call sdhci reset if wired

zynqmp-clk:
- Add support for DPLL clock source

zynqmp:
- Sync clock ID bindings with Linux
- defconfig updates
- Enable rng-seed generation

versal:
- Fix clock dependency

versal2:
- defconfig updates
- Enable sysreset

----------------------------------------------------------------
Michal Simek (6):
       clk: versal: Fix clock driver dependency
       firmware: xilinx: Prepare code for new SMC firmware format
       xilinx: Remove simple-bus description from mini configurations
       arm64: zynqmp: Enable rng-seed generation
       cmd: Introduce CMD_HELP
       xilinx: Disable help command for all mini configurations

Naresh Kumar Ravulapalli (1):
       drivers: fpga: intel_sdm_mb: Check SIP SMC status in send_bitstream()

Padmarao Begari (2):
       clk: zynqmp: Add support for dpll clock source
       xilinx: zynqmp: Enable xilinx ethernet phy

Tom Rini (2):
       arm: zynqmp: Remove local copy of 'dt-bindings/clock/xlnx-zynqmp-clk.h'
       firmware: xilinx: Tighten dependencies for ZYNQMP_FIRMWARE

Venkatesh Yadav Abbarapu (10):
       mmc: zynq_sdhci: Reset the host controller
       config: amd: Enable the SPI_STACKED_PARALLEL config option
       xilinx: zynqmp: disable CONFIG_SPI_FLASH_BAR
       arm64: versal2: Do not define do_reset() if sysreset is enabled
       arm64: versal2: Enable reset and poweroff via sysreset framework
       config: versal2: Update timer clock to 100Mhz
       spi: cadence_qspi: Fix odd byte write issue in STIG mode
       spi: cadence_qspi: Set tshsl_ns to at least one sclk_ns
       cadence_qspi: fix odd byte read issue in STIG mode
       arm64: versal2: Remove the ZynqMP Firmware from mini ospi

  arch/arm/dts/versal-mini-emmc0.dts               |  36 +++---
  arch/arm/dts/versal-mini-emmc1.dts               |  36 +++---
  arch/arm/dts/versal-mini-ospi.dtsi               |  52 ++++----
  arch/arm/dts/versal-mini-qspi.dtsi               |  40 +++----
  arch/arm/dts/versal-net-mini-emmc.dts            |  36 +++---
  arch/arm/dts/versal-net-mini-ospi.dtsi           |  56 ++++-----
  arch/arm/dts/versal-net-mini-qspi.dtsi           |  42 +++----
  arch/arm/dts/versal-net-mini.dts                 |  26 ++--
  arch/arm/dts/zynqmp-clk-ccf.dtsi                 |   2 +-
  arch/arm/dts/zynqmp-mini-emmc0.dts               |  31 ++---
  arch/arm/dts/zynqmp-mini-emmc1.dts               |  31 ++---
  arch/arm/dts/zynqmp-mini-nand.dts                |  35 +++---
  arch/arm/dts/zynqmp-mini-qspi.dts                |  25 ++--
  board/amd/versal2/board.c                        |   2 +
  board/xilinx/common/board.c                      |  33 ++++-
  cmd/Kconfig                                      |   6 +
  cmd/Makefile                                     |   2 +-
  cmd/help.c                                       |   6 -
  configs/amd_versal2_mini_defconfig               |   2 +
  configs/amd_versal2_mini_emmc_defconfig          |   2 +
  configs/amd_versal2_mini_ospi_defconfig          |   5 +-
  configs/amd_versal2_mini_qspi_defconfig          |   2 +
  configs/amd_versal2_virt_defconfig               |   6 +-
  configs/xilinx_versal_mini_defconfig             |   2 +
  configs/xilinx_versal_mini_emmc0_defconfig       |   2 +
  configs/xilinx_versal_mini_emmc1_defconfig       |   2 +
  configs/xilinx_versal_mini_ospi_defconfig        |   2 +
  configs/xilinx_versal_mini_qspi_defconfig        |   2 +
  configs/xilinx_versal_net_mini_defconfig         |   2 +
  configs/xilinx_versal_net_mini_emmc_defconfig    |   2 +
  configs/xilinx_versal_net_mini_ospi_defconfig    |   2 +
  configs/xilinx_versal_net_mini_qspi_defconfig    |   2 +
  configs/xilinx_versal_net_virt_defconfig         |   1 +
  configs/xilinx_versal_virt_defconfig             |   1 +
  configs/xilinx_zynqmp_kria_defconfig             |   1 +
  configs/xilinx_zynqmp_mini_defconfig             |   2 +
  configs/xilinx_zynqmp_mini_emmc0_defconfig       |   2 +
  configs/xilinx_zynqmp_mini_emmc1_defconfig       |   2 +
  configs/xilinx_zynqmp_mini_nand_defconfig        |   2 +
  configs/xilinx_zynqmp_mini_nand_single_defconfig |   2 +
  configs/xilinx_zynqmp_mini_qspi_defconfig        |   2 +
  configs/xilinx_zynqmp_virt_defconfig             |   2 +-
  drivers/clk/Kconfig                              |   2 +-
  drivers/clk/clk_zynqmp.c                         |  20 ++++
  drivers/firmware/Kconfig                         |   1 +
  drivers/firmware/firmware-zynqmp.c               |  60 ++++++----
  drivers/fpga/intel_sdm_mb.c                      |   3 +-
  drivers/mmc/zynq_sdhci.c                         |  22 ++++
  drivers/spi/cadence_ospi_versal.c                |  12 +-
  drivers/spi/cadence_qspi.h                       |   4 +-
  drivers/spi/cadence_qspi_apb.c                   |  13 +-
  include/dt-bindings/clock/xlnx-zynqmp-clk.h      | 126 --------------------
  include/zynqmp_firmware.h                        |   9 ++
  test/py/tests/test_help.py                       |   1 +
  54 files changed, 383 insertions(+), 439 deletions(-)
  delete mode 100644 include/dt-bindings/clock/xlnx-zynqmp-clk.h

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
