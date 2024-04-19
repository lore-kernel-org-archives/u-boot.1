Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADC2C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A2C188746;
	Fri, 19 Apr 2024 14:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="RFO/kKG3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A30118873F; Fri, 19 Apr 2024 14:02:12 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 493E688748
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43JAiQsd020736; Fri, 19 Apr 2024 14:02:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:cc:from:subject:to:content-type
 :content-transfer-encoding; s=selector1; bh=u8puF3O3aSuQNV7mMBfC
 LzzIRXw2/GryFBgdcI9BMJk=; b=RFO/kKG3dXQ4ZwquYV6QqY5y/ZmV6PtJ76VZ
 jbk4jx43KDouvHEL0E47jmGadRMbzDemt7RhbaKt5ujRZltAa7etITBYWeBQqiMW
 ub9YkrT2Zpq+J00do5oEc1Nd0Ea3zC7G0qpubXlVYr7YUfG22VGM6eJBAus5ya63
 o4nnZdjWCn2p0oxVqTdQYamwPNYwJO46NODvKAhwt9pAkHcjgRs1uxsglOYTyEw8
 mkOK9lWCili8N2bUr+oqmEVuiDQHfT3KwS4pVbekgxIaucLYtL6FFcirM/Zyt8Sn
 PDcVrRwjdUVwgwe6qXrfWT75YPdZqJEypoSZfXdCgR0pSLBFUQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg3m1275t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:02:07 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3414B4002D;
 Fri, 19 Apr 2024 14:02:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8FFFF218606;
 Fri, 19 Apr 2024 14:01:48 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:01:48 +0200
Message-ID: <7d10ae39-6134-4bd2-bf81-8b16ec88d294@foss.st.com>
Date: Fri, 19 Apr 2024 14:01:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
CC: Christophe Roullier <christophe.roullier@foss.st.com>, Christophe KERELLO
 <christophe.kerello@foss.st.com>, Marek Vasut <marex@denx.de>, Patrick
 DELAUNAY <patrick.delaunay@foss.st.com>, <patrice.chotard@foss.st.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot master / v2024.07 =
 u-boot-stm32-20240419
To: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.13.94]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_08,2024-04-19_01,2023-05-22_02
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

Hi Tom

Please pull the STM32 related patches for u-boot/master, v2024.07: u-boot-stm32-20240419

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/20430


The following changes since commit 97b34f6ace539c9c16eb8565f8b58730848ba97a:

  env: mmc: print MMC device being read (2024-04-18 16:37:25 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20240419

for you to fetch changes up to b0283b5e3d37daff48b45c3f98d298844603def4:

  ARM: dts: stm32: Add led-blue for stm32mp157c-ed1-scmi-u-boot (2024-04-19 12:05:10 +0200)

----------------------------------------------------------------
MP1:
 _ Add OHCI HCD support for STM32MP15xx DHSOM
 _ Report OTP-CLOSED instead of rev.? on closed STM32MP15xx
 _ Initialize TAMP_SMCR BKP..PROT fields on STM32MP15xx
 _ Jump to ep on successful resume in PSCI suspend code
 _ Add FASTBOOT support for STM32MP13
 _ Fix/Rework key and leds management for STM32MP13/15
 _ net: dwc_eth_qos: Clean up STM32 glue code and add STM32MP13xx support

MP2:
 _ Add stm32-fmc-ebi support
 _ Add: sdmmc2 support and fix AARCH64 compilation

----------------------------------------------------------------
Christophe Kerello (3):
      memory: stm32-fmc2-ebi: add MP25 support
      memory: stm32-fmc2-ebi: add MP25 RIF support
      mtd: rawnand: stm32_fmc2: add MP25 support

Christophe Roullier (2):
      net: dwc_eth_qos: Add DT parsing for STM32MP13xx platform
      net: dwc_eth_qos: Add support of STM32MP13xx platform

Marek Vasut (14):
      arm: stm32: Enable OHCI HCD support on STM32MP15xx DHSOM
      net: dwc_eth_qos: Split STM32 glue into separate file
      net: dwc_eth_qos: Rename eqos_stm32_config to eqos_stm32mp15_config
      net: dwc_eth_qos: Fold board_interface_eth_init into STM32 glue code
      net: dwc_eth_qos: Scrub ifdeffery
      net: dwc_eth_qos: Use FIELD_PREP for ETH_SEL bitfield
      net: dwc_eth_qos: Move log_debug statements on top of case block
      net: dwc_eth_qos: Use consistent logging prints
      net: dwc_eth_qos: Constify st, eth-* values parsed out of DT
      net: dwc_eth_qos: Add support for st, ext-phyclk property
      ARM: stm32: Jump to ep on successful resume in PSCI suspend code
      ARM: stm32: Drop superfluous Makefile entry for ecdsa_romapi.o
      ARM: stm32: Report OTP-CLOSED instead of rev.? on closed STM32MP15xx
      ARM: stm32: Initialize TAMP_SMCR BKP..PROT fields on STM32MP15xx

Patrice Chotard (29):
      ARM: dts: stm32: Fix partition node name for stm32mp157c-ev1-u-boot
      ARM: dts: stm32: Fix partition node name for stm32mp15xx-dhcor-u-boot
      ARM: dts: stm32: Fix partition node name for stm32mp15xx-dhcom-u-boot
      mmc: stm32_sdmmc2: Fix AARCH64 compilation warnings
      configs: stm32mp13: Enable FASTBOOT
      configs: stm32mp1: Enable BUTTON_GPIO flag for stm32mp15_defconfig
      configs: stm32mp1: Enable BUTTON_GPIO flag for stm32mp15_basic_defconfig
      configs: stm32mp1: Enable BUTTON_GPIO flag for stm32mp15_trusted_defconfig
      configs: stm32mp1: Enable BUTTON_GPIO flag for stm32mp13_defconfig
      board: st: stmp32mp1: Use BUTTON UCLASS in board_key_check()
      ARM: dts: stm32: Add gpio-keys for stm32mp135f-dk-u-boot
      ARM: dts: stm32: Don't probe led-red/led-blue at boot for stm32mp135f-dk-u-boot
      ARM: dts: stm32: Clean led-red node for stm32mp135f-dk-u-boot
      ARM: dts: stm32: Add gpio-keys for stm32mp157a-dk1-scmi-u-boot
      ARM: dts: stm32: Don't probe red led at boot for stm32mp157a-dk1-scmi-u-boot
      ARM: dts: stm32: Update red led node for stm32mp157a-dk1-scmi-u-boot
      ARM: dts: stm32: Add led-blue for stm32mp157a-dk1-scmi-u-boot
      ARM: dts: stm32: Add gpio-keys for stm32mp157a-dk1-u-boot
      ARM: dts: stm32: Don't probe red led at boot for stm32mp157a-dk1-u-boot
      ARM: dts: stm32: Update red led node for stm32mp157a-dk1-u-boot
      ARM: dts: stm32: Update u-boot, boot-led for stm32mp157a-dk1-u-boot
      ARM: dts: stm32: Add gpio-keys for stm32mp157c-ed1-u-boot
      ARM: dts: stm32: Don't probe red led at boot for stm32mp157c-ed1-u-boot
      ARM: dts: stm32: Update red led node for stm32mp157c-ed1-u-boot
      ARM: dts: stm32: Add led-blue for stm32mp157c-ed1-u-boot
      ARM: dts: stm32: Add gpio-keys for stm32mp157c-ed1-scmi-u-boot
      ARM: dts: stm32: Don't probe red led at boot for stm32mp157c-ed1-scmi-u-boot
      ARM: dts: stm32: Update red led node for stm32mp157c-ed1-scmi-u-boot
      ARM: dts: stm32: Add led-blue for stm32mp157c-ed1-scmi-u-boot

Patrick Delaunay (2):
      stm32mp: cmd_stm32prog: add dependencies with USB_GADGET_DOWNLOAD
      mmc: stm32_sdmmc2: Add "st,stm32mp25-sdmmc2" compatible

 arch/arm/dts/stm32mp135f-dk-u-boot.dtsi       |  19 +++++-
 arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi |  32 ++++++---
 arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi      |  32 ++++++---
 arch/arm/dts/stm32mp157c-ed1-scmi-u-boot.dtsi |  34 +++++++---
 arch/arm/dts/stm32mp157c-ed1-u-boot.dtsi      |  34 +++++++---
 arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi      |   8 +--
 arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi    |   6 +-
 arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi    |   6 +-
 arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig   |   1 +
 arch/arm/mach-stm32mp/stm32mp1/Makefile       |   1 -
 arch/arm/mach-stm32mp/stm32mp1/psci.c         |  14 ++++
 arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c   |  35 +++++++++-
 board/dhelectronics/dh_stm32mp1/board.c       |  82 -----------------------
 board/st/stm32mp1/stm32mp1.c                  | 150 ++++++++++++------------------------------
 configs/stm32mp13_defconfig                   |  11 +++-
 configs/stm32mp15_basic_defconfig             |   2 +
 configs/stm32mp15_defconfig                   |   2 +
 configs/stm32mp15_dhcom_basic_defconfig       |   2 +
 configs/stm32mp15_dhcor_basic_defconfig       |   2 +
 configs/stm32mp15_trusted_defconfig           |   2 +
 drivers/memory/stm32-fmc2-ebi.c               | 449 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 drivers/mmc/stm32_sdmmc2.c                    |   9 +--
 drivers/mtd/nand/raw/stm32_fmc2_nand.c        |  47 ++++++++++++--
 drivers/net/Makefile                          |   1 +
 drivers/net/dwc_eth_qos.c                     | 171 ++----------------------------------------------
 drivers/net/dwc_eth_qos.h                     |   2 +
 drivers/net/dwc_eth_qos_stm32.c               | 326 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 27 files changed, 1051 insertions(+), 429 deletions(-)
 create mode 100644 drivers/net/dwc_eth_qos_stm32.c
