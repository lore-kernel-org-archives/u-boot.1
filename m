Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CB0C83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 11:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD7CF83857;
	Thu, 31 Jul 2025 13:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="y77Lzq88";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F6AF838AB; Thu, 31 Jul 2025 13:55:09 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6BAC83852
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 13:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0307a9198e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VAGJi4030935;
 Thu, 31 Jul 2025 13:55:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=/sgq77nsM+yMfIHjoWxg8b
 JZO0F17OZnu0qqBk8++JU=; b=y77Lzq88og9vVbausVZPErqBxyD7fLyIFrOOiq
 DU2D3eGJEsl3vSQAjE7Jpyr1r77Z3vgaq02LF7L47Ye/PvofW2ApPZrP5Y8GTZsh
 spHy4AuojthNL0z7TGDXPqyMmdKlFyTEN0GwV353Fywo8dSD/fucgafDfc0uGei4
 QZCvbmXL1xg7jtaljKh3ellb/z1ecVYCN5wOZv2ZPkKnqbNtXZFSbXdAjaJki13v
 og7ILy7KizE5XO3jclFiK+LG3wUTlBgJLS5OZDgLBjsjI4nCpp9oUgWlXj+6T2bT
 GNcLc2lL9lPtkSwlmFPOIZ3oDmKiTdFGw3jiJJhVKQvaULDQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484memyhjs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Jul 2025 13:55:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2A8C240045;
 Thu, 31 Jul 2025 13:53:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1452E76373E;
 Thu, 31 Jul 2025 13:53:36 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 13:53:35 +0200
Message-ID: <dd84eff8-cbc6-4ae5-b19c-0ae52f09e363@foss.st.com>
Date: Thu, 31 Jul 2025 13:53:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Content-Language: en-US
To: TOM Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Alice Guo <alice.guo@nxp.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>,
 Cheick Traore <cheick.traore@foss.st.com>, Marek Vasut <marex@denx.de>,
 <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>
Subject: [PULL] Pull request for u-boot master / v2025.10 =
 u-boot-stm32-20250731
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_01,2025-03-28_01
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

Please pull the STM32 related patches for u-boot/master, v2025.10 = u-boot-stm32-20250731

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/27236

Thanks
Patrice

The following changes since commit 182cb30084516c3085d2ca5dde3f105f7625d774:

  Prepare v2025.10-rc1 (2025-07-28 18:23:01 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20250731

for you to fetch changes up to e064db5fe77caaddb21a7793f266119ad89dd79a:

  reset: stm32: Fix set_clr field (2025-07-30 14:55:17 +0200)

----------------------------------------------------------------
Add support for STM32 TIMERS and STM32 PWM on STM32MP25
Add STM32MP13xx SPL and OpTee-OS start support
Fix header misuse in stm32 reset drivers
Fix STMicroelectronics spelling
Fix clk-stm32h7 wrong macros used in register read
Fix PRE_CON_BUF_ADDR on STM32MP13
Fix clock identifier passed to struct scmi_clk_parent_set_in
Fix stm32 reset for STM32F4/F7 and H7
Enable OF_UPSTREAM_BUILD_VENDOR for stm32mp13_defconfig
Add STM32MP23 SoC and stm32mp235f-dk board support

----------------------------------------------------------------
Alice Guo (1):
      clk: scmi: Fix clock identifier passed to struct scmi_clk_parent_set_in

Andrew Goodbody (1):
      clk: stm32: Wrong macros used in register read

Cheick Traore (3):
      arm: stm32mp2: add multifunction timer support for stm32mp25
      pwm: stm32: add support for stm32mp25
      configs: stm32mp25: Enable MFD timer and PWM for stm32mp25_defconfig

Marek Vasut (11):
      reset: stm32: Fix header misuse
      ARM: stm32: Add STM32MP13xx SPL Kconfig options
      ARM: stm32: Add STM32MP13xx SPL hardware initialization
      ARM: stm32: Limit early cache enablement in SPL to STM32MP15xx
      ARM: stm32: Add STM32MP13xx PMIC initialization for DDR3 DRAM type
      ARM: stm32: Add STM32MP13xx debug UART initialization
      ARM: dts: stm32: Add stm32mp13-ddr.dtsi template
      ARM: dts: stm32: Add 512 MiB DRAM settings for DH STM32MP13xx DHCOR DHSBC
      ARM: dts: stm32: Add STM32MP13x SPL specific DT additions
      ARM: dts: stm32: Add SPL specifics for DH STM32MP13xx DHCOR DHSBC
      ARM: dts: stm32: Switch defconfig to SPL for DH STM32MP13xx DHCOR DHSBC

Patrice Chotard (6):
      ARM: stm32mp: Add STM32MP23 support
      ARM: dts: stm32: Add stm32mp235f-dk-u-boot
      arm: stm32mp: replace space by tab in sys_proto.h
      configs: stm32mp13: Enable OF_UPSTREAM_BUILD_VENDOR
      treewide: Fix STMicroelectronics spelling
      reset: stm32: Fix set_clr field

Patrick Delaunay (1):
      ARM: stm32: fix PRE_CON_BUF_ADDR on STM32MP13

 MAINTAINERS                                            |   1 -
 arch/arm/dts/stm32mp1-ddr.dtsi                         | 187 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/stm32mp13-ddr.dtsi                        |  49 +++++++++++++++++++++++++++++++
 arch/arm/dts/stm32mp13-ddr3-dhsom-1x2Gb-1066-binG.dtsi | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/stm32mp13-u-boot.dtsi                     |  89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi             | 160 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm/dts/stm32mp15-ddr.dtsi                        | 170 +-----------------------------------------------------------------------------------------------------------
 arch/arm/dts/stm32mp23-u-boot.dtsi                     | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/stm32mp235f-dk-u-boot.dtsi                |  27 ++++++++++++++++++
 arch/arm/include/asm/arch-am33xx/mem.h                 |   2 +-
 arch/arm/include/asm/arch-omap5/mem.h                  |   2 +-
 arch/arm/mach-stm32mp/Kconfig                          |  34 ++++++++++++++++++++--
 arch/arm/mach-stm32mp/Kconfig.13x                      |   5 ++--
 arch/arm/mach-stm32mp/Kconfig.23x                      |  37 ++++++++++++++++++++++++
 arch/arm/mach-stm32mp/Makefile                         |   1 +
 arch/arm/mach-stm32mp/cmd_stm32key.c                   |   8 +++---
 arch/arm/mach-stm32mp/include/mach/stm32.h             |  10 ++++---
 arch/arm/mach-stm32mp/include/mach/sys_proto.h         |  53 +++++++++++++++++++++++-----------
 arch/arm/mach-stm32mp/include/mach/timers.h            |   9 ++++++
 arch/arm/mach-stm32mp/stm32mp1/cpu.c                   |   9 ++++--
 arch/arm/mach-stm32mp/stm32mp1/spl.c                   |   3 +-
 arch/arm/mach-stm32mp/stm32mp1/stm32mp13x.c            | 204 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-stm32mp/stm32mp2/Makefile                |   1 +
 arch/arm/mach-stm32mp/stm32mp2/stm32mp23x.c            | 191 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-stm32mp/timers.c                         |  34 +++++++++++++++++++++-
 board/st/common/Kconfig                                |   2 +-
 board/st/common/stpmic1.c                              |  51 ++++++++++++++++++++++-----------
 board/st/stm32mp1/debug_uart.c                         |  21 ++++++++++++--
 board/st/stm32mp2/Kconfig                              |  14 +++++++++
 configs/stm32mp13_defconfig                            |   2 ++
 configs/stm32mp13_dhcor_defconfig                      |  30 +++++++++++++------
 configs/stm32mp15_dhsom.config                         |  48 +++++--------------------------
 configs/stm32mp23_defconfig                            |  82 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 configs/stm32mp25_defconfig                            |   4 +++
 configs/stm32mp_dhsom.config                           |  35 +++++++++++++++++++++--
 drivers/clk/clk_scmi.c                                 |   4 +--
 drivers/clk/stm32/clk-stm32h7.c                        |   4 +--
 drivers/pwm/pwm-stm32.c                                |  11 ++++++-
 drivers/reset/stm32/Kconfig                            |   2 +-
 drivers/reset/stm32/stm32-reset-core.c                 |   2 +-
 drivers/reset/stm32/stm32-reset-mp1.c                  |   2 +-
 drivers/reset/stm32/stm32-reset-mp25.c                 |   2 +-
 drivers/reset/stm32/stm32-reset.c                      |   4 +--
 include/configs/stm32mp23_common.h                     | 130 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/configs/stm32mp23_st_common.h                  |  51 +++++++++++++++++++++++++++++++++
 include/configs/stm32mp25_st_common.h                  |   2 +-
 46 files changed, 1701 insertions(+), 292 deletions(-)
 create mode 100644 arch/arm/dts/stm32mp1-ddr.dtsi
 create mode 100644 arch/arm/dts/stm32mp13-ddr.dtsi
 create mode 100644 arch/arm/dts/stm32mp13-ddr3-dhsom-1x2Gb-1066-binG.dtsi
 create mode 100644 arch/arm/dts/stm32mp23-u-boot.dtsi
 create mode 100644 arch/arm/dts/stm32mp235f-dk-u-boot.dtsi
 create mode 100644 arch/arm/mach-stm32mp/Kconfig.23x
 create mode 100644 arch/arm/mach-stm32mp/stm32mp2/stm32mp23x.c
 create mode 100644 configs/stm32mp23_defconfig
 create mode 100644 include/configs/stm32mp23_common.h
 create mode 100644 include/configs/stm32mp23_st_common.h
