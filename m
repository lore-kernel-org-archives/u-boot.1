Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780ECC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 12:36:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE1DA86DCE;
	Mon, 13 Nov 2023 13:36:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="TRAkvyYU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68A9D86F64; Mon, 13 Nov 2023 13:36:31 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A5C486D12
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 13:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9681a1e6ac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3AD9Uj7i007581; Mon, 13 Nov 2023 13:36:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:cc:from:subject:to:content-type
 :content-transfer-encoding; s=selector1; bh=7pfCcW9A7FlL00pdiKof
 sZUeJxXHNZJxNRaNuuU7Ps8=; b=TRAkvyYU+8Ba8VKJ7ZwYnf56VJRKRwYeOBOV
 njaiET+L1gayMneWB//Yr1F14ZSa96U+1UBLaO+qKG4TT9m/JcYuo7iWUIMZGRM6
 weOVRooVexapnA9+Btn/MRjmgCTqHQxwVMgPXK+nShgclPd3KS1apzkwNunpmGDq
 UZQYUxjOK/ALOVIuuSZfGADlvCRA+YX9dhdJ8GnuGXWfIckZfu8yMCbUhICSTpgF
 6ep2bToXID9iWk0BI+aMvK9sVkM5XJxbdC1lWiTfc6dsZe5xy0U1duY3U+t32Tq/
 UNuDBmbKgAOvWiUKMNMt1XR4LVBxHxcoJjyIIZJcZCY+MDhgAQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u9ywky9bn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Nov 2023 13:36:25 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B1A4B10005B;
 Mon, 13 Nov 2023 13:36:23 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A8328215BD8;
 Mon, 13 Nov 2023 13:36:23 +0100 (CET)
Received: from [10.201.20.54] (10.201.20.54) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 13 Nov
 2023 13:36:23 +0100
Message-ID: <b3779eaa-b063-446b-94a9-a5f458182f75@foss.st.com>
Date: Mon, 13 Nov 2023 13:36:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
CC: U-Boot Mailing List <u-boot@lists.denx.de>, <patrice.chotard@foss.st.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot next / v2024.04 = u-boot-stm32-20231113
To: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.54]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_03,2023-11-09_01,2023-05-22_02
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

Please pull the STM32 related patches for u-boot/next, v2024.04: u-boot-stm32-20231113

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/18567

The following changes since commit 3b6db6901ff5babbb9d21f0fca750996e29d85e0:

  Merge branch '2023-11-10-improve-semihosting-armv6' into next (2023-11-10 12:52:33 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20231113

for you to fetch changes up to 01a701994b0590b6452516a7c67353359d053c94:

  stm32mp2: initial support (2023-11-13 10:55:38 +0100)

----------------------------------------------------------------
Introduce STM32MP2 SoCs family support
Add STM32MP257F-EV1 board

----------------------------------------------------------------
Patrice Chotard (8):
      arm: caches: Make DCACHE_DEFAULT_OPTION accessible for ARM64 arch
      stm32mp: dram_init: Get RAM size from DT if no RAM driver found
      stm32mp: dram_init: Limit DDR usage under 4GB boundary for STM32MP
      stm32mp: bsec: Fix AARCH64 compilation warnings
      serial: stm32: Fix AARCH64 compilation warnings
      pinctrl: pinctrl_stm32: Add stm32mp2 support
      ARM: dts: stm32: Add STM32MP257F Evaluation board support
      stm32mp2: initial support

Patrick Delaunay (1):
      stm32mp: dram_init: Fix AARCH64 compilation warnings

 arch/arm/Kconfig                                     |   2 +-
 arch/arm/dts/Makefile                                |   3 +++
 arch/arm/dts/stm32mp25-pinctrl.dtsi                  |  38 +++++++++++++++++++++++++++++++++++
 arch/arm/dts/stm32mp25-u-boot.dtsi                   | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/stm32mp251.dtsi                         | 285 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/stm32mp253.dtsi                         |  23 ++++++++++++++++++++++
 arch/arm/dts/stm32mp255.dtsi                         |   9 +++++++++
 arch/arm/dts/stm32mp257.dtsi                         |   9 +++++++++
 arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi             |  20 +++++++++++++++++++
 arch/arm/dts/stm32mp257f-ev1.dts                     |  55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/stm32mp25xc.dtsi                        |   8 ++++++++
 arch/arm/dts/stm32mp25xf.dtsi                        |   8 ++++++++
 arch/arm/dts/stm32mp25xxai-pinctrl.dtsi              |  83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/stm32mp25xxak-pinctrl.dtsi              |  71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/stm32mp25xxal-pinctrl.dtsi              |  71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/system.h                        |  16 +++++++--------
 arch/arm/mach-stm32mp/Kconfig                        |  26 +++++++++++++++++++++++-
 arch/arm/mach-stm32mp/Kconfig.25x                    |  43 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-stm32mp/Makefile                       |  15 ++++----------
 arch/arm/mach-stm32mp/bsec.c                         |  29 ++++++++++++++-------------
 arch/arm/mach-stm32mp/dram_init.c                    |  17 ++++++++++++----
 arch/arm/mach-stm32mp/include/mach/stm32.h           | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------
 arch/arm/mach-stm32mp/include/mach/sys_proto.h       |  26 ++++++++++++++++++++++++
 arch/arm/mach-stm32mp/stm32mp1/Makefile              |  20 +++++++++++++++++++
 arch/arm/mach-stm32mp/{ => stm32mp1}/cpu.c           |   0
 arch/arm/mach-stm32mp/{ => stm32mp1}/fdt.c           |   0
 arch/arm/mach-stm32mp/{ => stm32mp1}/psci.c          |   0
 arch/arm/mach-stm32mp/{ => stm32mp1}/pwr_regulator.c |   0
 arch/arm/mach-stm32mp/{ => stm32mp1}/spl.c           |   0
 arch/arm/mach-stm32mp/{ => stm32mp1}/stm32mp13x.c    |   0
 arch/arm/mach-stm32mp/{ => stm32mp1}/stm32mp15x.c    |   0
 arch/arm/mach-stm32mp/{ => stm32mp1}/tzc400.c        |   0
 arch/arm/mach-stm32mp/stm32mp2/Makefile              |   9 +++++++++
 arch/arm/mach-stm32mp/stm32mp2/arm64-mmu.c           |  68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-stm32mp/stm32mp2/cpu.c                 | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-stm32mp/stm32mp2/fdt.c                 |  16 +++++++++++++++
 arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c          | 194 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-stm32mp/syscon.c                       |   4 ++--
 board/st/stm32mp2/Kconfig                            |  13 ++++++++++++
 board/st/stm32mp2/MAINTAINERS                        |   9 +++++++++
 board/st/stm32mp2/Makefile                           |   6 ++++++
 board/st/stm32mp2/stm32mp2.c                         |  52 ++++++++++++++++++++++++++++++++++++++++++++++++
 configs/stm32mp25_defconfig                          |  52 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl_stm32.c                      |   2 ++
 drivers/serial/serial_stm32.c                        |  23 ++++++++++++----------
 drivers/serial/serial_stm32.h                        |   2 +-
 include/configs/stm32mp25_common.h                   |  24 +++++++++++++++++++++++
 include/dt-bindings/pinctrl/stm32-pinfunc.h          |   3 +++
 48 files changed, 1597 insertions(+), 108 deletions(-)
 create mode 100644 arch/arm/dts/stm32mp25-pinctrl.dtsi
 create mode 100644 arch/arm/dts/stm32mp25-u-boot.dtsi
 create mode 100644 arch/arm/dts/stm32mp251.dtsi
 create mode 100644 arch/arm/dts/stm32mp253.dtsi
 create mode 100644 arch/arm/dts/stm32mp255.dtsi
 create mode 100644 arch/arm/dts/stm32mp257.dtsi
 create mode 100644 arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
 create mode 100644 arch/arm/dts/stm32mp257f-ev1.dts
 create mode 100644 arch/arm/dts/stm32mp25xc.dtsi
 create mode 100644 arch/arm/dts/stm32mp25xf.dtsi
 create mode 100644 arch/arm/dts/stm32mp25xxai-pinctrl.dtsi
 create mode 100644 arch/arm/dts/stm32mp25xxak-pinctrl.dtsi
 create mode 100644 arch/arm/dts/stm32mp25xxal-pinctrl.dtsi
 create mode 100644 arch/arm/mach-stm32mp/Kconfig.25x
 create mode 100644 arch/arm/mach-stm32mp/stm32mp1/Makefile
 rename arch/arm/mach-stm32mp/{ => stm32mp1}/cpu.c (100%)
 rename arch/arm/mach-stm32mp/{ => stm32mp1}/fdt.c (100%)
 rename arch/arm/mach-stm32mp/{ => stm32mp1}/psci.c (100%)
 rename arch/arm/mach-stm32mp/{ => stm32mp1}/pwr_regulator.c (100%)
 rename arch/arm/mach-stm32mp/{ => stm32mp1}/spl.c (100%)
 rename arch/arm/mach-stm32mp/{ => stm32mp1}/stm32mp13x.c (100%)
 rename arch/arm/mach-stm32mp/{ => stm32mp1}/stm32mp15x.c (100%)
 rename arch/arm/mach-stm32mp/{ => stm32mp1}/tzc400.c (100%)
 create mode 100644 arch/arm/mach-stm32mp/stm32mp2/Makefile
 create mode 100644 arch/arm/mach-stm32mp/stm32mp2/arm64-mmu.c
 create mode 100644 arch/arm/mach-stm32mp/stm32mp2/cpu.c
 create mode 100644 arch/arm/mach-stm32mp/stm32mp2/fdt.c
 create mode 100644 arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
 create mode 100644 board/st/stm32mp2/Kconfig
 create mode 100644 board/st/stm32mp2/MAINTAINERS
 create mode 100644 board/st/stm32mp2/Makefile
 create mode 100644 board/st/stm32mp2/stm32mp2.c
 create mode 100644 configs/stm32mp25_defconfig
 create mode 100644 include/configs/stm32mp25_common.h
