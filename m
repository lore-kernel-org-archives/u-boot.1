Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5049EC369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66E3182A96;
	Mon, 28 Apr 2025 15:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ZO9wsEuH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57DC082AA4; Mon, 28 Apr 2025 15:38:30 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D07982A8D
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7213f5eaf8=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S9P7Pr012480;
 Mon, 28 Apr 2025 15:38:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=zv5/YdQxbfHovGjyGz85X3
 e5B5okQxDz/jc4Cl87ijo=; b=ZO9wsEuHYYoHQUjUy3ArVa1oHy82z1asNjkjnt
 f07rpG9HKhCOK5AzK0lG7YSaViwMwxNhZHoadhKj/tqdle/XbmKIZeQDXjxFRZsB
 LfA9UFDQJl0t9M2Q0hin2ow0OVWeX7+Q3pe/MfWGEN6lhwhOCcaoUpvFXqaO/q6F
 pgvLWMQE7KpQ+WlPGM1WcXzEQpin1/YfNyh5ZT1NajDxWTBGmp2yH5E2txl98sYX
 dHG6TltmJ3uDzhKB2tsm27QNjKk8fXbtmIIsOE+A7TUWBSFRI4FL86tghU5ihi18
 oUlLQPdt8FY6kfWDCEiNZoCPlwkdwEqWhdjpiVdYLgMYYrzQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 468mwky8wp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 15:38:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B8FE640053;
 Mon, 28 Apr 2025 15:37:19 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C4294A6272D;
 Mon, 28 Apr 2025 15:35:04 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 15:35:04 +0200
Message-ID: <e7fc1441-c4a6-4173-bf7f-974f347f9f67@foss.st.com>
Date: Mon, 28 Apr 2025 15:35:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, <patrice.chotard@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot master / v2025.07 =
 u-boot-stm32-20250428
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_05,2025-04-24_02,2025-02-21_01
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


Please pull the STM32 related patches for u-boot/master, v2025.07 = u-boot-stm32-20250428

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/25970


The following changes since commit 9d3f1ebaf8751f0287b5d02158cc706435f8fb19:

  tools/make_pip: Use venv when invoking pip (2025-04-24 16:30:37 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20250428

for you to fetch changes up to 9d679cc4adbf2fdf077411bb4e2cb5ef4c1fd8b8:

  configs: stm32mp25: enable DISTRO_DEFAULT and BOOTCOMMAND (2025-04-25 16:00:23 +0200)

----------------------------------------------------------------
- Add OF_UPSTREAM flag support for STi, STM32 MCU and MPU platforms.
- Add ETZPC as system bus for STM32MP1 platforms
- Add RIFSC as sytem bus for STM32MP2 platforms
- Update STM32MP2 board/machine support:
  - update cmd_stm32key.
  - update cmd_stm32prog.
  - update STM32MP25 configs.
  - add leds and buttons support.
  - add boot_mode support (USB/PXE/MMC/NOR/NAND).
  - add bootcmd support.
  - enable MMC support.

----------------------------------------------------------------
Lionel Debieve (3):
      ARM: stm32mp: add ETZPC system bus driver for STM32MP1
      ARM: dts: stm32: add ETZPC as a system bus for STM32MP1x boards
      stm32mp: fdt: remove ETZPC peripheral cleanup

Patrice Chotard (23):
      ARM: dts: sti: convert stih410-b2260 board to OF_UPSTREAM
      ARM: dts: stm32: convert stm23h7 boards to OF_UPSTREAM
      ARM: dts: stm32: convert stm23f7 boards to OF_UPSTREAM
      ARM: dts: stm32: convert stm23f4 boards to OF_UPSTREAM
      ARM: dts: stm32: convert stm32mp13 board to OF_UPSTREAM
      ARM: dts: stm32: convert stm32mp15 board to OF_UPSTREAM
      configs: stm32: introduce stm32mp15-odyssey_defconfig
      clk: stm32mp1: fix DSI clock setting
      ARM: dts: stm32: convert stm32mp2 board to OF_UPSTREAM
      configs: stm32mp25: add MMC support
      configs: stm32mp25: add bootcmd for stm32mp25 platform
      board: st: stm32mp2: add env_get_location()
      board: st: stm32mp2: add mmc_get_env_dev()
      ARM: dts: stm32: add "u-boot,mmc-env-partition" for stm32mp257f-ev1-u-boot
      configs: stm32mp25: add support of NAND and NOR boot
      configs: stm32mp25: add USB host boot support
      configs: stm32mp25: add PXE boot support
      ARM: dts: stm32: add sdmmc1 fixed clock for stm32mp257f-ev1-u-boot
      arm: stm32mp: increase EARLY_TLB_SIZE to 0x10000
      arm: stm32mp: disable console for UART serial boot
      arm: stm32mp: fix package IDs for stm32mp25
      arm: stm32mp: cmd_stm32key: update command for stm32mp25x
      configs: stm32mp25: enable DISTRO_DEFAULT and BOOTCOMMAND

Patrick Delaunay (9):
      ARM: stm32mp: add RIFSC system bus driver for STM32MP25
      arm: stm32mp: add boot_mode support for STM32MP25
      board: st: stm32mp2: add led support
      board: st: stm32mp2: add user button support
      board: st: stm32mp2: change bootcmd for ST boards
      arm: stm32mp: implement new STM32MP25 revision ID system
      arm: stm32mp: add helper function stm32mp_is_closed()
      arm: stm32mp: stm32prog: PTA BSEC is not supported on closed device
      arm: stm32mp: stm32prog: add support rootfs-a for OTA

 arch/arm/dts/Makefile                                          |   31 --
 arch/arm/dts/st-pincfg.h                                       |   72 ---
 arch/arm/dts/stih407-clock.dtsi                                |  323 -------------
 arch/arm/dts/stih407-family.dtsi                               | 1000 ----------------------------------------
 arch/arm/dts/stih407-pinctrl.dtsi                              | 1262 ---------------------------------------------------
 arch/arm/dts/stih410-b2260-u-boot.dtsi                         |   46 +-
 arch/arm/dts/stih410-b2260.dts                                 |  214 ---------
 arch/arm/dts/stih410-clock.dtsi                                |  333 --------------
 arch/arm/dts/stih410-pinctrl.dtsi                              |   31 --
 arch/arm/dts/stih410.dtsi                                      |  300 ------------
 arch/arm/dts/stm32429i-eval.dts                                |  284 ------------
 arch/arm/dts/stm32746g-eval.dts                                |  186 --------
 arch/arm/dts/stm32f4-pinctrl.dtsi                              |  447 ------------------
 arch/arm/dts/stm32f429-disco.dts                               |  190 --------
 arch/arm/dts/stm32f429-pinctrl.dtsi                            |   55 ---
 arch/arm/dts/stm32f429.dtsi                                    |  758 -------------------------------
 arch/arm/dts/stm32f469-disco.dts                               |  213 ---------
 arch/arm/dts/stm32f469-pinctrl.dtsi                            |   55 ---
 arch/arm/dts/stm32f469.dtsi                                    |   18 -
 arch/arm/dts/stm32f7-pinctrl.dtsi                              |  415 -----------------
 arch/arm/dts/stm32f746-disco-u-boot.dtsi                       |   13 +-
 arch/arm/dts/stm32f746-disco.dts                               |  169 -------
 arch/arm/dts/stm32f746-pinctrl.dtsi                            |   11 -
 arch/arm/dts/stm32f746.dtsi                                    |  613 -------------------------
 arch/arm/dts/stm32f769-disco-u-boot.dtsi                       |   60 +--
 arch/arm/dts/stm32f769-disco.dts                               |  133 ------
 arch/arm/dts/stm32f769-pinctrl.dtsi                            |   11 -
 arch/arm/dts/stm32h7-pinctrl.dtsi                              |  274 -----------
 arch/arm/dts/stm32h7-u-boot.dtsi                               |    1 -
 arch/arm/dts/stm32h743.dtsi                                    |  695 ----------------------------
 arch/arm/dts/stm32h743i-disco.dts                              |   75 ---
 arch/arm/dts/stm32h743i-eval.dts                               |  160 -------
 arch/arm/dts/stm32h750.dtsi                                    |    5 -
 arch/arm/dts/stm32h750i-art-pi.dts                             |  188 --------
 arch/arm/dts/stm32mp13-pinctrl.dtsi                            |  888 ------------------------------------
 arch/arm/dts/stm32mp13-u-boot.dtsi                             |    4 +
 arch/arm/dts/stm32mp131.dtsi                                   | 1567 ---------------------------------------------------------------
 arch/arm/dts/stm32mp133.dtsi                                   |   98 ----
 arch/arm/dts/stm32mp135.dtsi                                   |   12 -
 arch/arm/dts/stm32mp135f-dk.dts                                |  376 ---------------
 arch/arm/dts/stm32mp13xc.dtsi                                  |   18 -
 arch/arm/dts/stm32mp13xf.dtsi                                  |   18 -
 arch/arm/dts/stm32mp15-pinctrl.dtsi                            | 2826 -----------------------------------------------------------------------------------------------------------------
 arch/arm/dts/stm32mp15-scmi.dtsi                               |   88 ----
 arch/arm/dts/stm32mp15-u-boot.dtsi                             |    4 +
 arch/arm/dts/stm32mp151.dtsi                                   | 1868 ---------------------------------------------------------------------------
 arch/arm/dts/stm32mp153.dtsi                                   |   59 ---
 arch/arm/dts/stm32mp157.dtsi                                   |   48 --
 arch/arm/dts/stm32mp157a-dk1-scmi.dts                          |   82 ----
 arch/arm/dts/stm32mp157a-dk1.dts                               |   25 -
 arch/arm/dts/stm32mp157a-icore-stm32mp1-ctouch2.dts            |   49 --
 arch/arm/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts |  161 -------
 arch/arm/dts/stm32mp157a-microgea-stm32mp1-microdev2.0.dts     |   59 ---
 arch/arm/dts/stm32mp157a-microgea-stm32mp1.dtsi                |  148 ------
 arch/arm/dts/stm32mp157c-dk2-scmi.dts                          |   88 ----
 arch/arm/dts/stm32mp157c-dk2.dts                               |   94 ----
 arch/arm/dts/stm32mp157c-ed1-scmi.dts                          |   87 ----
 arch/arm/dts/stm32mp157c-ed1.dts                               |  403 ----------------
 arch/arm/dts/stm32mp157c-ev1-scmi.dts                          |   93 ----
 arch/arm/dts/stm32mp157c-ev1.dts                               |  414 -----------------
 arch/arm/dts/stm32mp15xc.dtsi                                  |   18 -
 arch/arm/dts/stm32mp15xx-dkx.dtsi                              |  741 ------------------------------
 arch/arm/dts/stm32mp15xxaa-pinctrl.dtsi                        |   85 ----
 arch/arm/dts/stm32mp15xxab-pinctrl.dtsi                        |   57 ---
 arch/arm/dts/stm32mp15xxac-pinctrl.dtsi                        |   73 ---
 arch/arm/dts/stm32mp15xxad-pinctrl.dtsi                        |   57 ---
 arch/arm/dts/stm32mp25-pinctrl.dtsi                            |   38 --
 arch/arm/dts/stm32mp251.dtsi                                   |  301 ------------
 arch/arm/dts/stm32mp253.dtsi                                   |   23 -
 arch/arm/dts/stm32mp255.dtsi                                   |    9 -
 arch/arm/dts/stm32mp257.dtsi                                   |    9 -
 arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi                       |   81 ++++
 arch/arm/dts/stm32mp257f-ev1.dts                               |   55 ---
 arch/arm/dts/stm32mp25xc.dtsi                                  |    8 -
 arch/arm/dts/stm32mp25xf.dtsi                                  |    8 -
 arch/arm/dts/stm32mp25xxai-pinctrl.dtsi                        |   83 ----
 arch/arm/dts/stm32mp25xxak-pinctrl.dtsi                        |   71 ---
 arch/arm/dts/stm32mp25xxal-pinctrl.dtsi                        |   71 ---
 arch/arm/mach-stm32/Kconfig                                    |    3 +
 arch/arm/mach-stm32mp/Kconfig                                  |   11 +-
 arch/arm/mach-stm32mp/cmd_stm32key.c                           |  286 ++++++++++--
 arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig                    |    2 +
 arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c                |    6 +-
 arch/arm/mach-stm32mp/include/mach/etzpc.h                     |   32 ++
 arch/arm/mach-stm32mp/include/mach/rif.h                       |   26 ++
 arch/arm/mach-stm32mp/include/mach/stm32.h                     |   16 +
 arch/arm/mach-stm32mp/include/mach/sys_proto.h                 |   24 +-
 arch/arm/mach-stm32mp/stm32mp1/Makefile                        |    1 +
 arch/arm/mach-stm32mp/stm32mp1/etzpc.c                         |  194 ++++++++
 arch/arm/mach-stm32mp/stm32mp1/fdt.c                           |  258 -----------
 arch/arm/mach-stm32mp/stm32mp2/Makefile                        |    1 +
 arch/arm/mach-stm32mp/stm32mp2/cpu.c                           |  170 ++++++-
 arch/arm/mach-stm32mp/stm32mp2/rifsc.c                         |  364 +++++++++++++++
 arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c                    |   31 +-
 board/st/stm32mp1/MAINTAINERS                                  |    2 +
 board/st/stm32mp2/Kconfig                                      |    2 +-
 board/st/stm32mp2/MAINTAINERS                                  |    1 +
 board/st/stm32mp2/stm32mp2.c                                   |  140 +++++-
 configs/stih410-b2260_defconfig                                |    3 +-
 configs/stm32746g-eval_defconfig                               |    3 +-
 configs/stm32746g-eval_spl_defconfig                           |    3 +-
 configs/stm32f429-discovery_defconfig                          |    2 +-
 configs/stm32f429-evaluation_defconfig                         |    2 +-
 configs/stm32f469-discovery_defconfig                          |    2 +-
 configs/stm32f746-disco_defconfig                              |    3 +-
 configs/stm32f746-disco_spl_defconfig                          |    3 +-
 configs/stm32f769-disco_defconfig                              |    4 +-
 configs/stm32f769-disco_spl_defconfig                          |    4 +-
 configs/stm32h743-disco_defconfig                              |    2 +-
 configs/stm32h743-eval_defconfig                               |    2 +-
 configs/stm32h750-art-pi_defconfig                             |    2 +-
 configs/stm32mp13_defconfig                                    |    2 +-
 configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig             |    2 +-
 configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig            |    2 +-
 configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig    |    2 +-
 configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig        |    2 +-
 configs/stm32mp15-odyssey_defconfig                            |  172 +++++++
 configs/stm32mp15_basic_defconfig                              |    4 +-
 configs/stm32mp15_defconfig                                    |    4 +-
 configs/stm32mp15_trusted_defconfig                            |    4 +-
 configs/stm32mp25_defconfig                                    |   34 +-
 drivers/clk/stm32/clk-stm32mp1.c                               |    1 +
 include/configs/stm32f746-disco.h                              |    2 +-
 include/configs/stm32mp25_common.h                             |  102 +++++
 include/configs/stm32mp25_st_common.h                          |   51 +++
 include/dt-bindings/clock/stih407-clks.h                       |   90 ----
 include/dt-bindings/clock/stih410-clks.h                       |   25 -
 include/dt-bindings/mfd/st-lpc.h                               |   16 -
 include/dt-bindings/reset/stih407-resets.h                     |   65 ---
 129 files changed, 1761 insertions(+), 20430 deletions(-)
 delete mode 100644 arch/arm/dts/st-pincfg.h
 delete mode 100644 arch/arm/dts/stih407-clock.dtsi
 delete mode 100644 arch/arm/dts/stih407-family.dtsi
 delete mode 100644 arch/arm/dts/stih407-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/stih410-b2260.dts
 delete mode 100644 arch/arm/dts/stih410-clock.dtsi
 delete mode 100644 arch/arm/dts/stih410-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/stih410.dtsi
 delete mode 100644 arch/arm/dts/stm32429i-eval.dts
 delete mode 100644 arch/arm/dts/stm32746g-eval.dts
 delete mode 100644 arch/arm/dts/stm32f4-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/stm32f429-disco.dts
 delete mode 100644 arch/arm/dts/stm32f429-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/stm32f429.dtsi
 delete mode 100644 arch/arm/dts/stm32f469-disco.dts
 delete mode 100644 arch/arm/dts/stm32f469-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/stm32f469.dtsi
 delete mode 100644 arch/arm/dts/stm32f7-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/stm32f746-disco.dts
 delete mode 100644 arch/arm/dts/stm32f746-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/stm32f746.dtsi
 delete mode 100644 arch/arm/dts/stm32f769-disco.dts
 delete mode 100644 arch/arm/dts/stm32f769-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/stm32h7-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/stm32h743.dtsi
 delete mode 100644 arch/arm/dts/stm32h743i-disco.dts
 delete mode 100644 arch/arm/dts/stm32h743i-eval.dts
 delete mode 100644 arch/arm/dts/stm32h750.dtsi
 delete mode 100644 arch/arm/dts/stm32h750i-art-pi.dts
 delete mode 100644 arch/arm/dts/stm32mp13-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/stm32mp131.dtsi
 delete mode 100644 arch/arm/dts/stm32mp133.dtsi
 delete mode 100644 arch/arm/dts/stm32mp135.dtsi
 delete mode 100644 arch/arm/dts/stm32mp135f-dk.dts
 delete mode 100644 arch/arm/dts/stm32mp13xc.dtsi
 delete mode 100644 arch/arm/dts/stm32mp13xf.dtsi
 delete mode 100644 arch/arm/dts/stm32mp15-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/stm32mp15-scmi.dtsi
 delete mode 100644 arch/arm/dts/stm32mp151.dtsi
 delete mode 100644 arch/arm/dts/stm32mp153.dtsi
 delete mode 100644 arch/arm/dts/stm32mp157.dtsi
 delete mode 100644 arch/arm/dts/stm32mp157a-dk1-scmi.dts
 delete mode 100644 arch/arm/dts/stm32mp157a-dk1.dts
 delete mode 100644 arch/arm/dts/stm32mp157a-icore-stm32mp1-ctouch2.dts
 delete mode 100644 arch/arm/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts
 delete mode 100644 arch/arm/dts/stm32mp157a-microgea-stm32mp1-microdev2.0.dts
 delete mode 100644 arch/arm/dts/stm32mp157a-microgea-stm32mp1.dtsi
 delete mode 100644 arch/arm/dts/stm32mp157c-dk2-scmi.dts
 delete mode 100644 arch/arm/dts/stm32mp157c-dk2.dts
 delete mode 100644 arch/arm/dts/stm32mp157c-ed1-scmi.dts
 delete mode 100644 arch/arm/dts/stm32mp157c-ed1.dts
 delete mode 100644 arch/arm/dts/stm32mp157c-ev1-scmi.dts
 delete mode 100644 arch/arm/dts/stm32mp157c-ev1.dts
 delete mode 100644 arch/arm/dts/stm32mp15xc.dtsi
 delete mode 100644 arch/arm/dts/stm32mp15xx-dkx.dtsi
 delete mode 100644 arch/arm/dts/stm32mp15xxaa-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/stm32mp15xxab-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/stm32mp15xxac-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/stm32mp15xxad-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/stm32mp25-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/stm32mp251.dtsi
 delete mode 100644 arch/arm/dts/stm32mp253.dtsi
 delete mode 100644 arch/arm/dts/stm32mp255.dtsi
 delete mode 100644 arch/arm/dts/stm32mp257.dtsi
 delete mode 100644 arch/arm/dts/stm32mp257f-ev1.dts
 delete mode 100644 arch/arm/dts/stm32mp25xc.dtsi
 delete mode 100644 arch/arm/dts/stm32mp25xf.dtsi
 delete mode 100644 arch/arm/dts/stm32mp25xxai-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/stm32mp25xxak-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/stm32mp25xxal-pinctrl.dtsi
 create mode 100644 arch/arm/mach-stm32mp/include/mach/etzpc.h
 create mode 100644 arch/arm/mach-stm32mp/include/mach/rif.h
 create mode 100644 arch/arm/mach-stm32mp/stm32mp1/etzpc.c
 create mode 100644 arch/arm/mach-stm32mp/stm32mp2/rifsc.c
 create mode 100644 configs/stm32mp15-odyssey_defconfig
 create mode 100644 include/configs/stm32mp25_st_common.h
 delete mode 100644 include/dt-bindings/clock/stih407-clks.h
 delete mode 100644 include/dt-bindings/clock/stih410-clks.h
 delete mode 100644 include/dt-bindings/mfd/st-lpc.h
 delete mode 100644 include/dt-bindings/reset/stih407-resets.h
