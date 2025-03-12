Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78F1C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 17:22:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3ED3801BE;
	Wed, 12 Mar 2025 18:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="K/rUPEEU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42BD28056A; Wed, 12 Mar 2025 18:22:05 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D07F8800B6
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 18:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=51668757de=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CFohk3027842;
 Wed, 12 Mar 2025 18:21:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=kdz/IAbUohDKdEP6CqjWK7
 fAhjVuq0R5V6Vl5IFmIy8=; b=K/rUPEEUijaaE/mLMmIoGKL/xOZSbvFm8XYBHc
 RGkvqjuJr4LfCm46TcIAycy6nPs1rNE2GM2NA0dN+DHCdPMTIDXQP4Unmjn8Yiqt
 kuJdRZM0V4p0OL8rzrWGskhdwmU2CsW63YDJM5lpVZkdp/PezkEuCZvjPzYhatzR
 qn3BoEN7BARWpMovhuTeigwviySgtetupg3ayopYHO+9f2o4TulY6BSX3ncp6pnH
 qOq7v6apWsGeu9YbDmkvmZ/2U4NqAKFYSjhJsEpuRPPbJDdS4Rt0GvLpeA6/n+u7
 7nN9pZ7nQzZFAjnBNjdL0m+O+mAK/tgwiox7jeSKv+awYxFw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45au3nvve1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 18:21:55 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BB33C4004D;
 Wed, 12 Mar 2025 18:20:59 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7C097527FE1;
 Wed, 12 Mar 2025 18:20:38 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 18:20:37 +0100
Message-ID: <4f602c93-271e-4722-88cf-60079ea11009@foss.st.com>
Date: Wed, 12 Mar 2025 18:20:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot next / v2025.07 = u-boot-stm32-20250312
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Cheick Traore <cheick.traore@foss.st.com>, Linus Walleij
 <linus.walleij@linaro.org>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, <patrice.chotard@foss.st.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
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

Please pull the STM32 related patches for u-boot/next, v2025.07 = u-boot-stm32-20250312

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/25112

Thanks
Patrice


The following changes since commit 743c15b9fdd2f639012a2c26734dc146dc568218:

  Merge patch series "This series adds support for file renaming to EFI_FILE_PROTOCOL.SetInfo()." (2025-03-07 12:06:21 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20250312

for you to fetch changes up to 1a87755ecd0d36ec29acdbcbc9b381e76cfd6cfd:

  serial: stm32: restrict _debug_uart_init() usage (2025-03-12 16:44:31 +0100)

----------------------------------------------------------------
- Add drivers for MFD STM32 TIMERS and STM32 PWM and enable them on stm32mp135f-dk
- Restrict _debug_uart_init() usage in STM32 serial driver
- Add support for environment in eMMC on STM32MP13xx DHCOR SoM
- Introduce DH STM32MP15xx DHSOM board specific defconfigs
- Fix CONFIG_BOOTCOUNT_ALTBOOTCMD update on DH STM32MP1 DHSOM
- Update maintainer for board stm32f746-disco
- Fix Linux cmdline for stm32f769-disco
- Cleanup in stm32f***-u-boot.dtsi and in board_late_init() by removing
  legacy led and button management.

----------------------------------------------------------------
Cheick Traore (4):
      mach-stm32: add multifunction timer driver support
      pwm: stm32: add driver to support pwm with timer
      configs: stm32mp13: Enable MFD timer and PWM for stm32mp13_defconfig
      ARM: dts: stm32: Add TIMERS inverted PWM channel 3 on STM32MP135F-DK

Dario Binacchi (3):
      ARM: dts: stm32: drop "st,button1" compatible
      ARM: dts: stm32: drop "st,led1" compatible
      board: stm32f746-disco: drop board_late_init()

Linus Walleij (1):
      configs: stm32f769-disco: Fix console cmdline

Marek Vasut (4):
      ARM: dts: stm32: Add support for STM32MP13xx DHCOR SoM and DHSBC rev.200 board
      ARM: stm32: Fix CONFIG_BOOTCOUNT_ALTBOOTCMD update on DH STM32MP1 DHSOM
      ARM: stm32: Introduce DH STM32MP15xx DHSOM board specific defconfigs
      ARM: dts: stm32: Add support for environment in eMMC on STM32MP13xx DHCOR SoM

Patrice Chotard (2):
      board: st: stm32f746-disco: Update MAINTAINERS file
      serial: stm32: restrict _debug_uart_init() usage

 arch/arm/dts/stm32746g-eval-u-boot.dtsi             |  10 ---------
 arch/arm/dts/stm32f746-disco-u-boot.dtsi            |  10 ---------
 arch/arm/dts/stm32f769-disco-u-boot.dtsi            |  10 ---------
 arch/arm/dts/stm32mp13-pinctrl.dtsi                 |  15 ++++++++++++++
 arch/arm/dts/stm32mp135f-dhcor-dhsbc-u-boot.dtsi    |  22 ++++++++++++++++++++
 arch/arm/dts/stm32mp135f-dk.dts                     |  14 +++++++++++++
 arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi          |   2 ++
 arch/arm/mach-stm32mp/Kconfig                       |   6 ++++++
 arch/arm/mach-stm32mp/Makefile                      |   1 +
 arch/arm/mach-stm32mp/include/mach/timers.h         |  55 ++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-stm32mp/stm32mp1/cpu.c                |   2 --
 arch/arm/mach-stm32mp/timers.c                      |  82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 board/st/stm32f746-disco/MAINTAINERS                |   2 +-
 board/st/stm32f746-disco/stm32f746-disco.c          |  36 ---------------------------------
 configs/stm32746g-eval_defconfig                    |   1 -
 configs/stm32746g-eval_spl_defconfig                |   1 -
 configs/stm32f746-disco_defconfig                   |   1 -
 configs/stm32f746-disco_spl_defconfig               |   1 -
 configs/stm32f769-disco_defconfig                   |   2 +-
 configs/stm32mp13_defconfig                         |   4 ++++
 configs/stm32mp13_dhcor_defconfig                   |   5 ++++-
 configs/stm32mp15_dhcom_basic.config                |   8 ++++++++
 configs/stm32mp15_dhcom_basic_defconfig             |   9 +--------
 configs/stm32mp15_dhcom_drc02_basic_defconfig       |   4 ++++
 configs/stm32mp15_dhcom_pdk2_basic_defconfig        |   4 ++++
 configs/stm32mp15_dhcom_picoitx_basic_defconfig     |   4 ++++
 configs/stm32mp15_dhcor_avenger96_basic_defconfig   |   4 ++++
 configs/stm32mp15_dhcor_basic.config                |   8 ++++++++
 configs/stm32mp15_dhcor_basic_defconfig             |   9 +--------
 configs/stm32mp15_dhcor_drc_compact_basic_defconfig |   4 ++++
 configs/stm32mp15_dhcor_testbench_basic_defconfig   |   4 ++++
 drivers/pwm/Kconfig                                 |   8 ++++++++
 drivers/pwm/Makefile                                |   1 +
 drivers/pwm/pwm-stm32.c                             | 205 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/serial/serial_stm32.c                       |  18 +++++++++++------
 35 files changed, 475 insertions(+), 97 deletions(-)
 create mode 100644 arch/arm/mach-stm32mp/include/mach/timers.h
 create mode 100644 arch/arm/mach-stm32mp/timers.c
 create mode 100644 configs/stm32mp15_dhcom_basic.config
 create mode 100644 configs/stm32mp15_dhcom_drc02_basic_defconfig
 create mode 100644 configs/stm32mp15_dhcom_pdk2_basic_defconfig
 create mode 100644 configs/stm32mp15_dhcom_picoitx_basic_defconfig
 create mode 100644 configs/stm32mp15_dhcor_avenger96_basic_defconfig
 create mode 100644 configs/stm32mp15_dhcor_basic.config
 create mode 100644 configs/stm32mp15_dhcor_drc_compact_basic_defconfig
 create mode 100644 configs/stm32mp15_dhcor_testbench_basic_defconfig
 create mode 100644 drivers/pwm/pwm-stm32.c
