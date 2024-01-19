Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4B0C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87C0F87D5C;
	Fri, 19 Jan 2024 17:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ksm+lK5W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 301A187B9D; Fri, 19 Jan 2024 17:59:13 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 120DC87D60
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=17487c629f=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40JDZkNQ021854; Fri, 19 Jan 2024 17:59:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:from:subject:to:cc:content-type
 :content-transfer-encoding; s=selector1; bh=BxwPm2NhZVvvIgWD0K4F
 7/ogcL9Zf4oRh8vWJWAIWus=; b=ksm+lK5WrIotd/PLYXhcCHkt+zDU3uemO7xe
 jhsauYPQQLz3s4H/rbITFU9x7gpgdpge8UJvyA0NRpNQYPn49O15epEsuy5tlf0o
 VAFYVuMke2iK+MNl34WnoQvyUkPc3CSvWUlPCspTwgZRdtskO9KpA4+sNJsnlq3Z
 dPO9Z+i9Myira1GTsziuieMexRS9bWMvHYuxTWlk8jQrYVjL/g2jNV0MQSNHLuIe
 qBLNd4RTunP5f82CVFAh9lpt/tJ4Bdl/ts/uo1TysFi3Gb13T/9ecpPi9Tkbs/nY
 2Ky+25HFFcrJVUx7VxJvIC5ZHK6NnhqK2iyEqLUAIs/EmRKmhQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkma6eu6w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jan 2024 17:59:09 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 790D2100081;
 Fri, 19 Jan 2024 17:59:08 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6D740260275;
 Fri, 19 Jan 2024 17:59:08 +0100 (CET)
Received: from [10.252.4.250] (10.252.4.250) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Jan
 2024 17:59:08 +0100
Message-ID: <fc4c4d9c-187a-4e67-9be4-9e7ab9f414c3@foss.st.com>
Date: Fri, 19 Jan 2024 17:59:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot master / v2024.04 =
 u-boot-stm32-20240119
To: Tom Rini <trini@konsulko.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, Yann Gautier <yann.gautier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.4.250]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_10,2024-01-19_02,2023-05-22_02
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

Please pull the STM32 related patches for u-boot/master, v2024.04: u-boot-stm32-20240119

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/19379

The following changes since commit f7cca7ccc5117eaafcc2bde91ad1bed6fee7cfc3:

  Revert "test: hush: dollar: fix bugous behavior" (2024-01-18 11:38:25 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20240119

for you to fetch changes up to 8a4d098bb0859b3a26c9e1100ed08d7bd1f8ed30:

  stm32mp2: Fix CONFIG_STM32MP25X flag usage (2024-01-19 15:49:20 +0100)

----------------------------------------------------------------
Add CMDLINE dependecy for CMD_STM32KEY

STM32MP1:
---------
Set stdio to serial on DH STM32MP15xx DHSOM
Fix reset for usart1 in scmi configuration

STM32MP2:
---------
Add BSEC and OTP support for STM32MP25
Fix CONFIG_STM32MP25X flag usage

----------------------------------------------------------------
Marek Vasut (1):
      ARM: stm32: Set stdio to serial on DH STM32MP15xx DHSOM

Patrice Chotard (3):
      ARM: dts: stm32: Fix reset for usart1 in scmi configuration
      stm32mp: add setup_serial_number for stm32mp25
      stm32mp2: Fix CONFIG_STM32MP25X flag usage

Patrick Delaunay (13):
      arm64: dts: st: add bsec support to stm32mp25
      stm32mp: bsec: add driver data
      stm32mp: bsec: add support of stm32mp25
      configs: stm32mp25: add support of fuse command
      stm32mp: add soc.c file
      smt32mp: add setup_mac_address for stm32mp25
      stm32mp: stm32prog: add support of stm32mp25
      stm32mp: activate the command stboard for stm32mp25 boards
      board: st: stm32mp2: add checkboard
      board: st: stm32mp2: display the board identification
      arm: Rename STM32MP13x
      arm: Rename STM32MP15x
      stm32mp: Add dependencies on CMDLINE for command stm32key

Yann Gautier (1):
      arm: stm32mp: add Rev.B support for STM32MP25

 arch/arm/dts/Makefile                           |   4 ++--
 arch/arm/dts/stm32mp15-scmi-u-boot.dtsi         |   2 +-
 arch/arm/dts/stm32mp15-u-boot.dtsi              |   2 +-
 arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi        |   4 ++--
 arch/arm/dts/stm32mp157c-ed1-u-boot.dtsi        |   4 ++--
 arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi        |   4 ++--
 arch/arm/dts/stm32mp25-u-boot.dtsi              |   4 ++++
 arch/arm/dts/stm32mp251.dtsi                    |  16 ++++++++++++++++
 arch/arm/mach-stm32mp/Kconfig                   |   9 +++++----
 arch/arm/mach-stm32mp/Kconfig.13x               |   4 ++--
 arch/arm/mach-stm32mp/Kconfig.15x               |   6 +++---
 arch/arm/mach-stm32mp/Makefile                  |   5 +++--
 arch/arm/mach-stm32mp/bsec.c                    |  45 +++++++++++++++++++++++++++++++++++++--------
 arch/arm/mach-stm32mp/cmd_stm32key.c            |  20 ++++++++++----------
 arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.h |  12 ++++++++++--
 arch/arm/mach-stm32mp/include/mach/stm32.h      |  24 +++++++++++++-----------
 arch/arm/mach-stm32mp/include/mach/sys_proto.h  |   1 +
 arch/arm/mach-stm32mp/soc.c                     | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-stm32mp/stm32mp1/Makefile         |   4 ++--
 arch/arm/mach-stm32mp/stm32mp1/cpu.c            |  96 +-----------------------------------------------------------------------------------------------
 arch/arm/mach-stm32mp/stm32mp1/fdt.c            |  10 +++++-----
 arch/arm/mach-stm32mp/stm32mp2/cpu.c            |  14 +++-----------
 arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c     |   3 +++
 board/st/common/Kconfig                         |   2 +-
 board/st/common/cmd_stboard.c                   |   2 ++
 board/st/stm32mp1/Kconfig                       |   4 ++--
 board/st/stm32mp1/stm32mp1.c                    |   6 +++---
 board/st/stm32mp2/stm32mp2.c                    |  37 +++++++++++++++++++++++++++++++++++++
 configs/stm32mp13_defconfig                     |   4 ++--
 configs/stm32mp15_basic_defconfig               |   2 +-
 configs/stm32mp15_defconfig                     |   2 +-
 configs/stm32mp15_trusted_defconfig             |   4 ++--
 configs/stm32mp25_defconfig                     |   1 +
 drivers/clk/stm32/Kconfig                       |   4 ++--
 include/configs/stm32mp15_dh_dhsom.h            |  11 +++++++----
 35 files changed, 307 insertions(+), 183 deletions(-)
 create mode 100644 arch/arm/mach-stm32mp/soc.c
