Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA46C0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 11:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00DE382166;
	Fri, 31 Jan 2025 12:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ILy5nin0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A60282169; Fri, 31 Jan 2025 12:01:52 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F199E82163
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 12:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=41261629dd=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VAKwH0020145;
 Fri, 31 Jan 2025 12:01:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=o1uE1wYcacvV3annMphIbq
 y6EcxiYVBtXFMvD/qZD8g=; b=ILy5nin0Yuf17fNrCBQlUoYj3a6yX3iBYmnam5
 MuV7pouczW5RXckzvyA5GHCnjfCjOBqg6iURn8GBhKBYBN2YbK2RWfC3QXQ7k9ye
 Qbwctfd9ztdy/UZgDnG9WPh+xweP5dEPGoShxb61qv4c6u8fXuO2vTCW9xQJ8RiI
 SWpc0L8tiIX5d57rckRYoWk38QwDUoTmIgYVQe3dhkiTHily/+0f45fCqYuARYdA
 D80EDyAv2gNtxmgZriUEKXq2aYgVAMrJfRSNpahtBMSiiiD72cm/c+xmWmIAv5j4
 CKsD1RNWzUXRpicAss1Mm49rXIs2f2u47PQT1OpMi6GjC+3A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44gf7dtkr1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jan 2025 12:01:47 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AF72F4007E;
 Fri, 31 Jan 2025 12:00:30 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0F1A62D97E8;
 Fri, 31 Jan 2025 11:57:06 +0100 (CET)
Received: from [10.252.27.7] (10.252.27.7) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 31 Jan
 2025 11:57:05 +0100
Message-ID: <a8e492b4-b2fc-4432-8ce9-669a8a70d1ed@foss.st.com>
Date: Fri, 31 Jan 2025 11:57:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot master / v2025.04 =
 u-boot-stm32-20250131
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.27.7]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_04,2025-01-31_01,2024-11-22_01
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

Please pull the STM32 related patches for u-boot/master, v2025.04 = u-boot-stm32-20250131

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/24410

The following changes since commit a517796cfa5d8f4ca2f0c11c78c24a08a102c047:

  Prepare v2025.04-rc1 (2025-01-27 16:38:46 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20250131

for you to fetch changes up to 84bbb8f59a89b24daebc9eff532df6160f049faf:

  ARM: dts: stm32: Update ck_flexgen_08 frequency. (2025-01-31 10:13:10 +0100)

----------------------------------------------------------------
STM32 MPU:
- Remove dt-bindings headers available in dts/upstream
- Fixes for stm32prog
- Enable CONFIG_SYS_64BIT_LBA for STM32MP15/13/25 defconfigs
- Add upport of ck_usbo_48m in pre-reloc stage for STM32MP13
- Clean env_get_location() for STM32MP1
- Fix board_get_usable_ram_top() to fix infinite loop in cache
  management for STM32MP2.
- Fix ck_flexgen_08 frequency for STM32MP2

STM32 MCU:
- Tune CYCLIC_MAX_CPU_TIME_US to avoid cyclic warning for STM32F469-Disco
- Tune CYCLIC_MAX_CPU_TIME_US to avoid cyclic warning for STM32F769-Disco

----------------------------------------------------------------
Patrice Chotard (11):
      fastboot: Fix warning when CONFIG_SYS_64BIT_LBA is enable
      arm: stm32mp: stm32prog: fix warning when CONFIG_SYS_64BIT_LBA is enable
      arm: stm32mp: stm32prog: update multiplier is part-size is above SZ_1G
      configs: stm32mp13: enable CONFIG_SYS_64BIT_LBA
      configs: stm32mp15: enable CONFIG_SYS_64BIT_LBA
      configs: stm32mp25: enable CONFIG_SYS_64BIT_LBA
      board: st: stm32mp1: Clean env_get_location()
      configs: stm32f769-disco: Set CYCLIC_MAX_CPU_TIME_US to 8000 for stm32f769-disco
      configs: stm32f469-disco: Set CYCLIC_MAX_CPU_TIME_US to 50000 for stm32f469-disco
      stm32mp: Fix board_get_usable_ram_top()
      ARM: dts: stm32: Update ck_flexgen_08 frequency.

Patrick Delaunay (2):
      stm32: remove dt-binding headers that are available upstream
      ARM: dts: stm32mp13: Add support of ck_usbo_48m in pre-reloc stage

 arch/arm/dts/stm32mp13-u-boot.dtsi                     |   5 +++
 arch/arm/dts/stm32mp251.dtsi                           |   2 +-
 arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c        |   9 ++++--
 arch/arm/mach-stm32mp/dram_init.c                      |   2 +-
 board/st/stm32mp1/stm32mp1.c                           |   2 --
 configs/stm32f469-discovery_defconfig                  |   1 +
 configs/stm32f769-disco_defconfig                      |   1 +
 configs/stm32f769-disco_spl_defconfig                  |   1 +
 configs/stm32mp13_defconfig                            |   1 +
 configs/stm32mp15_basic_defconfig                      |   1 +
 configs/stm32mp15_defconfig                            |   1 +
 configs/stm32mp15_trusted_defconfig                    |   1 +
 configs/stm32mp25_defconfig                            |   1 +
 drivers/clk/stm32/clk-stm32h7.c                        |   3 ++
 drivers/fastboot/fb_mmc.c                              |   8 ++---
 include/dt-bindings/clock/stm32fx-clock.h              |  63 ------------------------------------
 include/dt-bindings/clock/stm32h7-clks.h               | 167 ----------------------------------------------------------------------------------------------
 include/dt-bindings/clock/stm32mp1-clks.h              | 274 ----------------------------------------------------------------------------------------------------------------------------------------------------------
 include/dt-bindings/clock/stm32mp13-clks.h             | 229 --------------------------------------------------------------------------------------------------------------------------------
 include/dt-bindings/mfd/stm32f4-rcc.h                  | 108 -------------------------------------------------------------
 include/dt-bindings/mfd/stm32f7-rcc.h                  | 115 -----------------------------------------------------------------
 include/dt-bindings/mfd/stm32h7-rcc.h                  | 138 ------------------------------------------------------------------------------
 include/dt-bindings/pinctrl/stm32-pinfunc.h            |  45 --------------------------
 include/dt-bindings/regulator/st,stm32mp13-regulator.h |  42 ------------------------
 include/dt-bindings/reset/stm32mp1-resets.h            | 123 ---------------------------------------------------------------------
 include/dt-bindings/reset/stm32mp13-resets.h           | 100 --------------------------------------------------------
 26 files changed, 28 insertions(+), 1415 deletions(-)
 delete mode 100644 include/dt-bindings/clock/stm32fx-clock.h
 delete mode 100644 include/dt-bindings/clock/stm32h7-clks.h
 delete mode 100644 include/dt-bindings/clock/stm32mp1-clks.h
 delete mode 100644 include/dt-bindings/clock/stm32mp13-clks.h
 delete mode 100644 include/dt-bindings/mfd/stm32f4-rcc.h
 delete mode 100644 include/dt-bindings/mfd/stm32f7-rcc.h
 delete mode 100644 include/dt-bindings/mfd/stm32h7-rcc.h
 delete mode 100644 include/dt-bindings/pinctrl/stm32-pinfunc.h
 delete mode 100644 include/dt-bindings/regulator/st,stm32mp13-regulator.h
 delete mode 100644 include/dt-bindings/reset/stm32mp1-resets.h
 delete mode 100644 include/dt-bindings/reset/stm32mp13-resets.h
