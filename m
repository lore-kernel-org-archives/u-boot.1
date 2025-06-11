Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42285C61CE7
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 09:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D691828A2;
	Wed, 11 Jun 2025 11:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="yxb95gUR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B1EF82B20; Wed, 11 Jun 2025 11:37:23 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9475380050
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 11:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=8257ebf683=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B7lawX007268;
 Wed, 11 Jun 2025 11:37:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=BceTY9nUrSPTl9cujAJUym
 8FI6RpH4OVgFf4ubwUoHI=; b=yxb95gURv1D0qxSxpYn5L5/+Zcmjrmvu9WN0z5
 VUPSOLXjAtA798IkUva7h1IxHVc0DYK8sPQKggQjiPWORJf8rcMhd2y+jfPv1kjt
 +ZZQzDpzP6simPBCl5TtBaqSHasLHvsFf0SOQ/IEX5TeJ2/sqgv5Tc0hSkCxDpk0
 ayhesrxHVQdN6mAxFkdXdCrDdh2SAd6g5+D+3WH3e/f3W/Nsq+ByIIQpMPQBSfqE
 JlmjpgZ8mY5kh52lqS7vZVbkZ8ZZD66t4M1RoLJnLa/0ACNMMtfTurWp0VijIv5n
 HvcAUVZf4+u91ib3znhADSY2LNcYQ6TAx0MotZqUVGJc8ucQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4750cnxd3e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 11:37:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AE8B640048;
 Wed, 11 Jun 2025 11:36:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5BF7BB1DA7E;
 Wed, 11 Jun 2025 11:35:35 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 11:35:34 +0200
Message-ID: <65e007f8-fe6b-4fc4-ae88-9f6abd4d554b@foss.st.com>
Date: Wed, 11 Jun 2025 11:35:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Gabriel FERNANDEZ
 <gabriel.fernandez@foss.st.com>, Marek Vasut <marex@denx.de>, Patrick
 DELAUNAY <patrick.delaunay@foss.st.com>, <patrice.chotard@foss.st.com>,
 Simeon Marijon <simeon.marijon@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot next / v2025.10 = u-boot-stm32-20250611
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_04,2025-06-10_01,2025-03-28_01
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

Please pull the STM32 related patches for u-boot/next, v2025.10 = u-boot-stm32-20250611

https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/26607

Thanks
Patrice

The following changes since commit 59d00e20fced23e6463aa09db889dd548baee677:

  Merge tag 'v2025.07-rc4' into next (2025-06-09 16:28:28 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20250611

for you to fetch changes up to 40c158933307d8977d9d7871ab1c8d1415a6bcde:

  board: stm32: add stm32h747-discovery board support (2025-06-11 09:42:56 +0200)

----------------------------------------------------------------
Add clock and reset drivers support for STM32MP25
Add STM32H747-Discovery board support
Add tamp_nvram driver
Add SPL support and clock tree init to STM32MP13 RCC driver
Add STM32MP13xx ram support
Add support for STM32 Image V2.0 for STM32MP13xx
Fix SYSRAM size on STM32MP13xx
Fix DBGMCU macro on STM32MP13xx
Auto-detect ROM API table on STM32MP15xx

----------------------------------------------------------------
Dario Binacchi (9):
      ARM: dts: stm32h7-pinctrl: add _a suffix to u[s]art_pins phandles
      dt-bindings: arm: stm32: add compatible for stm32h747i-disco board
      dt-bindings: clock: stm32h7: rename USART{7, 8}_CK to UART{7, 8}_CK
      ARM: dts: stm32: add uart8 node for stm32h743 MCU
      ARM: dts: stm32: add pin map for UART8 controller on stm32h743
      ARM: dts: stm32: add an extra pin map for USART1 on stm32h743
      ARM: dts: stm32: support STM32h747i-disco board
      ARM: dts: stm32: add stm32h747i-disco-u-boot DTS file
      board: stm32: add stm32h747-discovery board support

Gabriel Fernandez (4):
      clk: stm32mp25: Add clock driver support
      clk: stm32mp25: implement clock check security function
      clk: stm32: fix clock counter
      reset: stm32mp25: add stm32mp25 reset driver

Marek Vasut (8):
      ARM: stm32: Drop unnecessary space
      ARM: stm32: Fix SYSRAM size on STM32MP13xx
      ARM: stm32: Fix DBGMCU macro on STM32MP13xx
      ARM: stm32: Auto-detect ROM API table on STM32MP15xx
      clk: stm32mp13: Fix typo in STM32MP13 RCC driver
      clk: stm32mp13: Add SPL support and clock tree init to STM32MP13 RCC driver
      ram: stm32mp1: Add STM32MP13xx support
      tools: stm32image: Add support for STM32 Image V2.0

Patrice Chotard (3):
      ARM: dts: stm32: switch from fixed to scmi clocks for stm32mp257f-ev1
      configs: stm32mp13: increase SYS_MALLOC_F_LEN to 0x210000
      configs: stm32mp25: increase SYS_MALLOC_F_LEN to 0x60000

Patrick Delaunay (6):
      clk: add CONFIG_CLK_AUTO_ID
      clk: sandbox: update driver for CONFIG_CLK_AUTO_ID support
      sandbox: test: update for CONFIG_CLK_AUTO_ID support
      clk: fixed_rate: configure clock ID with CONFIG_CLK_AUTO_ID
      clk: scmi: manage properly the clk identifier with CCF
      phy: stm32-usbphyc: manage properly the clk identifier with CCF

Simeon Marijon (1):
      stm32mp: Add tamp_nvram driver

Valentin Caron (1):
      clk: scmi: add compatibility with clock protocol 2.0

 MAINTAINERS                                           |    3 +-
 arch/arm/cpu/armv7/Kconfig                            |    3 +-
 arch/arm/dts/stm32h747i-disco-u-boot.dtsi             |  104 +++++++++++++++
 arch/arm/dts/stm32mp25-u-boot.dtsi                    |    8 ++
 arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi              |   74 -----------
 arch/arm/mach-stm32/stm32h7/Kconfig                   |    4 +
 arch/arm/mach-stm32mp/Kconfig                         |    9 ++
 arch/arm/mach-stm32mp/Makefile                        |    2 +
 arch/arm/mach-stm32mp/include/mach/stm32.h            |    7 +-
 arch/arm/mach-stm32mp/stm32mp1/cpu.c                  |    3 +-
 arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c           |    5 +-
 arch/arm/mach-stm32mp/tamp_nvram.c                    |  666 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 board/st/stm32h747-disco/Kconfig                      |   15 +++
 board/st/stm32h747-disco/MAINTAINERS                  |    7 +
 board/st/stm32h747-disco/Makefile                     |    6 +
 board/st/stm32h747-disco/stm32h747-disco.c            |   42 ++++++
 boot/image.c                                          |    1 +
 configs/stm32h747-disco_defconfig                     |   35 +++++
 configs/stm32mp13_defconfig                           |    2 +-
 configs/stm32mp25_defconfig                           |    2 +-
 drivers/clk/Kconfig                                   |   11 ++
 drivers/clk/clk-uclass.c                              |    9 +-
 drivers/clk/clk_fixed_rate.c                          |    1 +
 drivers/clk/clk_sandbox.c                             |   30 +++--
 drivers/clk/clk_sandbox_ccf.c                         |   48 +++----
 drivers/clk/clk_scmi.c                                |   62 ++++++---
 drivers/clk/stm32/Kconfig                             |    9 ++
 drivers/clk/stm32/Makefile                            |    1 +
 drivers/clk/stm32/clk-stm32-core.c                    |   73 +++++++++-
 drivers/clk/stm32/clk-stm32-core.h                    |    3 +-
 drivers/clk/stm32/clk-stm32h7.c                       |    5 +
 drivers/clk/stm32/clk-stm32mp13.c                     | 1311 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 drivers/clk/stm32/clk-stm32mp25.c                     |  782 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/stm32/stm32mp13_rcc.h                     |   93 +++++++++++++
 drivers/misc/stm32_rcc.c                              |   66 +++++----
 drivers/phy/phy-stm32-usbphyc.c                       |   19 +++
 drivers/ram/stm32mp1/stm32mp1_ddr.c                   |   95 ++++++++++---
 drivers/ram/stm32mp1/stm32mp1_ddr.h                   |    6 +
 drivers/ram/stm32mp1/stm32mp1_ram.c                   |    5 +
 drivers/reset/Kconfig                                 |    9 +-
 drivers/reset/Makefile                                |    4 +-
 drivers/reset/stm32-reset.c                           |   97 --------------
 drivers/reset/stm32/Kconfig                           |   23 ++++
 drivers/reset/stm32/Makefile                          |    9 ++
 drivers/reset/stm32/stm32-reset-core.c                |   92 +++++++++++++
 drivers/reset/stm32/stm32-reset-core.h                |   31 +++++
 drivers/reset/stm32/stm32-reset-mp1.c                 |   55 ++++++++
 drivers/reset/stm32/stm32-reset-mp25.c                |  159 ++++++++++++++++++++++
 drivers/reset/stm32/stm32-reset.c                     |   43 ++++++
 dts/upstream/Bindings/arm/stm32/stm32.yaml            |    4 +
 dts/upstream/include/dt-bindings/clock/stm32h7-clks.h |    4 +-
 dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi          |   34 ++++-
 dts/upstream/src/arm/st/stm32h743.dtsi                |    8 ++
 dts/upstream/src/arm/st/stm32h743i-disco.dts          |    2 +-
 dts/upstream/src/arm/st/stm32h743i-eval.dts           |    2 +-
 dts/upstream/src/arm/st/stm32h747i-disco.dts          |  136 +++++++++++++++++++
 dts/upstream/src/arm/st/stm32h750i-art-pi.dts         |    6 +-
 include/clk.h                                         |   24 ++++
 include/configs/stm32h747-disco.h                     |   32 +++++
 include/dt-bindings/clock/stm32mp13-clksrc.h          |  399 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/image.h                                       |    1 +
 include/linux/clk-provider.h                          |    9 +-
 include/scmi_protocols.h                              |   15 +++
 include/stm32_rcc.h                                   |    7 +-
 include/stm32mp25_rcc.h                               |  712 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 test/dm/clk_ccf.c                                     |   30 ++---
 tools/stm32image.c                                    |  215 ++++++++++++++++++++++--------
 67 files changed, 5347 insertions(+), 442 deletions(-)
 create mode 100644 arch/arm/dts/stm32h747i-disco-u-boot.dtsi
 create mode 100644 arch/arm/mach-stm32mp/tamp_nvram.c
 create mode 100644 board/st/stm32h747-disco/Kconfig
 create mode 100644 board/st/stm32h747-disco/MAINTAINERS
 create mode 100644 board/st/stm32h747-disco/Makefile
 create mode 100644 board/st/stm32h747-disco/stm32h747-disco.c
 create mode 100644 configs/stm32h747-disco_defconfig
 create mode 100644 drivers/clk/stm32/clk-stm32mp25.c
 delete mode 100644 drivers/reset/stm32-reset.c
 create mode 100644 drivers/reset/stm32/Kconfig
 create mode 100644 drivers/reset/stm32/Makefile
 create mode 100644 drivers/reset/stm32/stm32-reset-core.c
 create mode 100644 drivers/reset/stm32/stm32-reset-core.h
 create mode 100644 drivers/reset/stm32/stm32-reset-mp1.c
 create mode 100644 drivers/reset/stm32/stm32-reset-mp25.c
 create mode 100644 drivers/reset/stm32/stm32-reset.c
 create mode 100644 dts/upstream/src/arm/st/stm32h747i-disco.dts
 create mode 100644 include/configs/stm32h747-disco.h
 create mode 100644 include/dt-bindings/clock/stm32mp13-clksrc.h
 create mode 100644 include/stm32mp25_rcc.h
