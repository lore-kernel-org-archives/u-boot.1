Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF60C4167D
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 15:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 239A586590;
	Tue,  7 Nov 2023 16:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="JONnC6QU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EE1D87464; Tue,  7 Nov 2023 16:31:33 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C45F686590
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 16:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-991c786369cso874381666b.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 07:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1699371090; x=1699975890;
 darn=lists.denx.de; 
 h=content-transfer-encoding:autocrypt:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMqTT4O2jw+jf4UZiCoiG4MFeAeCuzFAbrzxH5OUSjQ=;
 b=JONnC6QUANRWZQqtFbyHWdQ3/Vv0HWbOdwJmD7iSgezerVBQ6yUISKp4vrrSTVZlI3
 Ou4tD+c4bSDOr1eRJGKQhdYFeuqHLvHJXc3Mcmr9nbYyRzjqJgjm5yZgj3HOceGAEcuB
 Fc1FLnrZUIB6vyCTBQ/QwBOTTg88HS0Aszq/cRmkSSrl65h46AnuXdHn+UQdT1DDp13P
 mG/BLW7gpc1Zpadk8ab4PTV1QGhFOGkBOB3/A6AeRof4O/WmWa1wg7vufO+HzwLT/cw5
 14JzkY2gkotRkIPgg2lf3rD+LgmFmQx2lSH/ttfWIy9aZCRPbWL8cyFDx9n0vNf+th5q
 /sHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699371090; x=1699975890;
 h=content-transfer-encoding:autocrypt:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WMqTT4O2jw+jf4UZiCoiG4MFeAeCuzFAbrzxH5OUSjQ=;
 b=a4ayQY7CC8QRb5+G4WMrk60UYhkvUDjLzgkCbkpFMjtH8WwtPNmiHjHZnvgPlFh8cv
 uvinCFCaxKY8m7blxGD2+az51aGX5ZwUHRaGfCY0oh+KVRuQ1cjhBC35ykz6O4Sr6TF9
 IOjtlCyhINMD9FdDeBCJSwCsF4rHhKWgpKB9Fmws7ELk9QjBr8mhsPPhKYI2PT2sQZGd
 vKDta2jeZLrUVdwBKjkcsjvfloH4HV8+RqZ6ww0jeiTF9/d4hQUEarQDzhrefe96SC2B
 7WPVrOK8vPoauDyWbLwZhORNfTf2RfPyx8bSQXS2YuEJyMzg+/ffE41Ld5XrPXKMWB0R
 AqRA==
X-Gm-Message-State: AOJu0Yzy/YaXblrpXAL7rc36XyjJr6NyX7qaHhJvG9fQ+KXzMwa/2nLo
 olcPFh/zhH7HEysLQNRmsUDGlrIG9eH2kZY6qVkPPg==
X-Google-Smtp-Source: AGHT+IEcOXVlqDuhQwL1ARJJGUBiz0zRPDN21xnq5whs68Ohd4jB+CeY4dOewBCfQhS0qyjA5S1BXg==
X-Received: by 2002:a17:906:db0d:b0:9d3:ccd1:a905 with SMTP id
 xj13-20020a170906db0d00b009d3ccd1a905mr17594652ejb.51.1699371090155; 
 Tue, 07 Nov 2023 07:31:30 -0800 (PST)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 ay1-20020a170906d28100b009b928eb8dd3sm1153928ejb.163.2023.11.07.07.31.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 07:31:29 -0800 (PST)
Message-ID: <c57462d6-33cd-4f16-87c8-a83de771fdf7@monstr.eu>
Date: Tue, 7 Nov 2023 16:31:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] xilinx patches for v2024.01-rc3
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

please pull these patches to your tree. Most of them are dt related to aligned 
our dts in u-boot with dt-schema and fix issues around it.
There are small updates out in spi to fix 64bit support and allow disable flash 
locking code to save some space for our mini configurations.
And last change was related to reading baudrate from DT which was ack by Simon.
There are some other things pending but not ready yet that's why I wanted to get 
these patches merged to have more time for testing.
Gitlab CI is not showing any issue too.

Thanks,
Michal

The following changes since commit 3af0e9556c968fc2c40e3778d8f1e668a90af92e:

   Prepare v2024.01-rc2 (2023-11-06 14:47:25 -0500)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2024.01-rc3

for you to fetch changes up to 37f500d711ec1f6b25189c1f6022ffe5e70a38ab:

   dt-bindings: Remove VSC8531 specific RGMII delay definitions (2023-11-07 
13:47:09 +0100)

----------------------------------------------------------------
Xilinx changes for v2024.01-rc3

xilinx:
- Disable lock in mini spi configurations

zynq:
- DTS syncups
- Kconfig updates

zynqmp:
- DTS syncups
- Kconfig fixups

versal:
- Make 30MHz as default freq for spi

versal net:
- Enable ADMA for mmc

serial:
- Read baudrate from DT

spi:
- Put spi lock under one Kconfig
- Support 64bit addresses in cadance_ospi
- zynqmp_gqspi - change logging support

firmware:
- Handle errors in zynqmp_pm_feature()

include:
- Sync vsc8531 dt binding with kernel

----------------------------------------------------------------
Algapally Santosh Sagar (2):
       configs: Add support in Kconfig and convert for armada boards
       serial: zynqmp: Fetch baudrate from dtb and update

Amit Kumar Mahapatra (1):
       arm64: dts: zynqmp: make hw-ecc as the default ecc mode

Ibai Erkiaga (1):
       zynqmp: migrate gqspi debug to logging

Michal Simek (17):
       arm64: zynqmp: Remove fclk driver
       arm64: zynqmp: Use mdio node by vp-x-a2785-00-revA and vpk120-revA
       arm64: zynqmp: Remove xlnx,zynqmp-aes node
       Revert "arm64: zynqmp: Add power domain description for PL"
       arm64: zynqmp: Remove address/size-cells from ams node
       arm: xilinx: Add missing dual parallel flash description
       arm64: zynqmp: Fix Kconfig entry indentation
       xilinx: versal: Setup 30MHz as default spi frequency
       ARM: zynq: Add DTSes for mini qspi configurations
       ARM: zynq: Add DTSes for mini qspi configurations
       arm64: versal: Add DTSes for mini qspi/ospi configuration
       arm64: versal-net: Add DTSes for mini qspi/ospi configuration
       arm64: zynqmp: Comment all smmu entries
       xilinx: Enable SPI_FLASH_MTD by default
       ARM: zynq: Add partition description
       arm64: zynqmp: Add description for nvmem efuse layout
       dt-bindings: Remove VSC8531 specific RGMII delay definitions

Piyush Mehta (1):
       arm64: zynqmp: remove snps, xhci-stream-quirk property for usb

Tejas Bhumkar (1):
       arm64: zynqmp: Disable Tri-state for MIO38 Pin

Venkatesh Yadav Abbarapu (8):
       mtd: spi-nor: Add spi flash lock config option
       arm64: versal: Disable the lock option for mini ospi and qspi
       arm64: versal_net: Disable the lock option for mini ospi and qspi
       drivers: firmware: Handle error case in the zynqmp_pm_feature
       spi: cadence_ospi_versal: Add support for 64-bit address
       arm64: zynqmp: Disable the lock option for mini qspi
       ARM: zynq: Disable the config CONFIG_SPI_FLASH_USE_4K_SECTORS
       arm64: versal-net: enable CONFIG_MMC_SDHCI_ADMA

  arch/arm/dts/Makefile                            |  27 +++++
  arch/arm/dts/bitmain-antminer-s9.dts             |   2 +
  arch/arm/dts/versal-mini-ospi-stacked.dts        |  22 ++++
  arch/arm/dts/versal-mini-qspi-parallel.dts       |  22 ++++
  arch/arm/dts/versal-mini-qspi-stacked.dts        |  22 ++++
  arch/arm/dts/versal-mini-qspi-x1-single.dts      |  17 +++
  arch/arm/dts/versal-mini-qspi-x1-stacked.dts     |  23 ++++
  arch/arm/dts/versal-mini-qspi-x2-single.dts      |  17 +++
  arch/arm/dts/versal-mini-qspi-x2-stacked.dts     |  23 ++++
  arch/arm/dts/versal-net-mini-ospi-stacked.dts    |  22 ++++
  arch/arm/dts/versal-net-mini-qspi-parallel.dts   |  22 ++++
  arch/arm/dts/versal-net-mini-qspi-stacked.dts    |  22 ++++
  arch/arm/dts/versal-net-mini-qspi-x1-single.dts  |  17 +++
  arch/arm/dts/versal-net-mini-qspi-x1-stacked.dts |  23 ++++
  arch/arm/dts/versal-net-mini-qspi-x2-single.dts  |  17 +++
  arch/arm/dts/versal-net-mini-qspi-x2-stacked.dts |  23 ++++
  arch/arm/dts/zynq-7000.dtsi                      |   4 -
  arch/arm/dts/zynq-cse-qspi-parallel.dts          |  22 ++++
  arch/arm/dts/zynq-cse-qspi-stacked.dts           |  22 ++++
  arch/arm/dts/zynq-cse-qspi-x1-single.dts         |  16 +++
  arch/arm/dts/zynq-cse-qspi-x1-stacked.dts        |  22 ++++
  arch/arm/dts/zynq-cse-qspi-x2-single.dts         |  16 +++
  arch/arm/dts/zynq-cse-qspi-x2-stacked.dts        |  22 ++++
  arch/arm/dts/zynq-zc702.dts                      |  25 +++++
  arch/arm/dts/zynq-zc706.dts                      |  30 ++++-
  arch/arm/dts/zynq-zc770-xm010.dts                |  25 +++++
  arch/arm/dts/zynq-zc770-xm011.dts                |  19 ++++
  arch/arm/dts/zynq-zc770-xm012.dts                |  25 +++++
  arch/arm/dts/zynq-zc770-xm013.dts                |  30 ++++-
  arch/arm/dts/zynq-zed.dts                        |  29 ++++-
  arch/arm/dts/zynqmp-clk-ccf.dtsi                 |   6 -
  arch/arm/dts/zynqmp-m-a2197-01-revA.dts          |   4 +-
  arch/arm/dts/zynqmp-m-a2197-02-revA.dts          |   4 +-
  arch/arm/dts/zynqmp-m-a2197-03-revA.dts          |   4 +-
  arch/arm/dts/zynqmp-mini-qspi-parallel.dts       |  21 ++++
  arch/arm/dts/zynqmp-mini-qspi-single.dts         |  12 ++
  arch/arm/dts/zynqmp-mini-qspi-stacked.dts        |  21 ++++
  arch/arm/dts/zynqmp-mini-qspi-x1-single.dts      |  17 +++
  arch/arm/dts/zynqmp-mini-qspi-x1-stacked.dts     |  23 ++++
  arch/arm/dts/zynqmp-mini-qspi-x2-single.dts      |  17 +++
  arch/arm/dts/zynqmp-mini-qspi-x2-stacked.dts     |  23 ++++
  arch/arm/dts/zynqmp-sck-kv-g-revA.dtso           |  25 +++++
  arch/arm/dts/zynqmp-sck-kv-g-revB.dtso           |  25 +++++
  arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts       |  10 +-
  arch/arm/dts/zynqmp-vpk120-revA.dts              |  10 +-
  arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts         |   6 +-
  arch/arm/dts/zynqmp.dtsi                         | 117 +++++++++++++-------
  arch/arm/mach-zynqmp/Kconfig                     |  24 ++--
  arch/sandbox/dts/test.dts                        |   1 +
  cmd/sf.c                                         |   4 +-
  configs/eDPU_defconfig                           |   1 +
  configs/mvebu_db-88f3720_defconfig               |   1 +
  configs/mvebu_espressobin-88f3720_defconfig      |   1 +
  configs/uDPU_defconfig                           |   1 +
  configs/xilinx_versal_mini_ospi_defconfig        |   1 +
  configs/xilinx_versal_mini_qspi_defconfig        |   1 +
  configs/xilinx_versal_net_mini_ospi_defconfig    |   1 +
  configs/xilinx_versal_net_mini_qspi_defconfig    |   1 +
  configs/xilinx_versal_net_virt_defconfig         |   1 +
  configs/xilinx_versal_virt_defconfig             |   1 +
  configs/xilinx_zynq_virt_defconfig               |   2 +
  configs/xilinx_zynqmp_mini_qspi_defconfig        |   1 +
  doc/README.serial_dt_baud                        |  41 +++++++
  drivers/core/ofnode.c                            |  18 +++
  drivers/firmware/firmware-zynqmp.c               |   2 +
  drivers/mtd/spi/Kconfig                          |   7 ++
  drivers/mtd/spi/spi-nor-core.c                   |   8 +-
  drivers/serial/Kconfig                           |  15 +++
  drivers/serial/serial-uclass.c                   |  49 ++++++++
  drivers/spi/cadence_ospi_versal.c                |   4 +-
  drivers/spi/zynqmp_gqspi.c                       |  82 ++++++--------
  include/configs/mvebu_armada-37xx.h              |   1 -
  include/dm/ofnode.h                              |  14 ++-
  include/dt-bindings/net/mscc-phy-vsc8531.h       |   9 --
  include/env_default.h                            |   8 +-
  include/env_internal.h                           |   2 +-
  include/serial.h                                 |   7 ++
  test/dm/serial.c                                 |   1 +
  78 files changed, 1138 insertions(+), 145 deletions(-)
  create mode 100644 arch/arm/dts/versal-mini-ospi-stacked.dts
  create mode 100644 arch/arm/dts/versal-mini-qspi-parallel.dts
  create mode 100644 arch/arm/dts/versal-mini-qspi-stacked.dts
  create mode 100644 arch/arm/dts/versal-mini-qspi-x1-single.dts
  create mode 100644 arch/arm/dts/versal-mini-qspi-x1-stacked.dts
  create mode 100644 arch/arm/dts/versal-mini-qspi-x2-single.dts
  create mode 100644 arch/arm/dts/versal-mini-qspi-x2-stacked.dts
  create mode 100644 arch/arm/dts/versal-net-mini-ospi-stacked.dts
  create mode 100644 arch/arm/dts/versal-net-mini-qspi-parallel.dts
  create mode 100644 arch/arm/dts/versal-net-mini-qspi-stacked.dts
  create mode 100644 arch/arm/dts/versal-net-mini-qspi-x1-single.dts
  create mode 100644 arch/arm/dts/versal-net-mini-qspi-x1-stacked.dts
  create mode 100644 arch/arm/dts/versal-net-mini-qspi-x2-single.dts
  create mode 100644 arch/arm/dts/versal-net-mini-qspi-x2-stacked.dts
  create mode 100644 arch/arm/dts/zynq-cse-qspi-parallel.dts
  create mode 100644 arch/arm/dts/zynq-cse-qspi-stacked.dts
  create mode 100644 arch/arm/dts/zynq-cse-qspi-x1-single.dts
  create mode 100644 arch/arm/dts/zynq-cse-qspi-x1-stacked.dts
  create mode 100644 arch/arm/dts/zynq-cse-qspi-x2-single.dts
  create mode 100644 arch/arm/dts/zynq-cse-qspi-x2-stacked.dts
  create mode 100644 arch/arm/dts/zynqmp-mini-qspi-parallel.dts
  create mode 100644 arch/arm/dts/zynqmp-mini-qspi-single.dts
  create mode 100644 arch/arm/dts/zynqmp-mini-qspi-stacked.dts
  create mode 100644 arch/arm/dts/zynqmp-mini-qspi-x1-single.dts
  create mode 100644 arch/arm/dts/zynqmp-mini-qspi-x1-stacked.dts
  create mode 100644 arch/arm/dts/zynqmp-mini-qspi-x2-single.dts
  create mode 100644 arch/arm/dts/zynqmp-mini-qspi-x2-stacked.dts
  create mode 100644 doc/README.serial_dt_baud

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
