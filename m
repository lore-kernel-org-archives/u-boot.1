Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8A3CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0482D86D65;
	Mon, 16 Oct 2023 23:33:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697491993;
	bh=zigmsZmtj9bMyRNorrXTJ94PIfNJhMzUl8z+IkOiJzA=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Qbi35N9RPbQWyz3y1pPz7Xsst+H4Fz+qy1LOisuN9QKJ2KviqxLYqLcR/oEp+FZgj
	 uwVO7MEFB6SJjTvlXyAVELrFuC2HSj8HUcKVH6bLwq9cUQE8rAAzYui5NW9LAMa3sf
	 hiRbxp+D3VMul9H2/hwzhdQb1VPyEqSgru/0jrC0Sa8i6E6PVrGxw1YIjlj3fd+LLi
	 IVx7wynnF7JreqCOn7dWVx4rBqY7MBIrV3+ZogE030S6GrRVrg59M4ww3e30nrvH3K
	 IWjcUe2JV6IJ7xSnw0Wk+7WdNPBOYIL9QJDJ9AxiUeRLWYL3NXxzGaPJNJ+JQxWCuP
	 ysD+UZGPiijeg==
Received: from [IPV6:2001:a61:606e:f301:54d3:fa40:6980:4d01] (unknown
 [IPv6:2001:a61:606e:f301:54d3:fa40:6980:4d01])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: sbabic@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8DBC286EE0;
 Mon, 16 Oct 2023 23:32:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697491967;
 bh=zigmsZmtj9bMyRNorrXTJ94PIfNJhMzUl8z+IkOiJzA=;
 h=Date:To:Cc:From:Subject:From;
 b=ykmM3xnqKnw1QkFKoTQ1v1f3FQNB7Kc/1cpYwoxFedUqnQoYSgQxpWrQafulJqCol
 O3xbjul5Ok/FhNY843G+y5LhGR8Udhvbp+E9pceIQPVLaMF3ZiUB01mWczjRgPTzZa
 A6ZWdFSvUv1YjY+a56NYDgvy+09ksDEndmcoCkUeLW/XHlhsJ+rkt7c/ae6q48KhvU
 maBwG7z4AQvRIN/u9FoF86m7/tSGe0SxvJnHt8w+dxzXbqdAcJNF+dd6gj0hKSPy6d
 +1QmbUBthRvSQobOQFQ9a0j4WU9fVLF7oTjvItXORHMkixNVvgwJChy0seC0aO5mer
 WHCU/eQfXN7nA==
Message-ID: <0740042b-3c8f-4a53-8270-b528efaeef52@denx.de>
Date: Mon, 16 Oct 2023 23:32:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tom Rini <trini@konsulko.com>
Content-Language: de-DE
Cc: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
From: Stefano Babic <sbabic@denx.de>
Subject: Pull request: please pull u-boot-imx-20231016
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

please pull from u-boot-imx, thanks !

The following changes since commit 3c3f1626919cd93cbe6c56e3849937de5be18dbb:

   Merge tag 'dm-pull-13oct23' of 
https://source.denx.de/u-boot/custodians/u-boot-dm (2023-10-14 10:50:20 
-0400)

are available in the Git repository at:

   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git 
tags/u-boot-imx-20231016

for you to fetch changes up to b0eef7326920ff55ec22dfb86812033d84737839:

   imx8mp-evk: Add USB0 OTG support (2023-10-16 18:52:20 +0200)

----------------------------------------------------------------
u-boot-imx-20231016
-------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/18168

- Imrovement MX93
- Toradex: fixes
- Convert to DM (serial, watchdog) for some boards
- HAB improvements for Secure Boot
- DTO overlay for DHCOM
- USB fixes, Mass storage for MX28
- Cleanup some code
- Phytec MX8M : EEProm detection, fixes
- Gateworks Boards improvements

----------------------------------------------------------------
Alice Guo (1):
       arm: dts: imx93: add a per clock for LPUART1

Andrej Rosano (1):
       usbarmory: Add DM_I2C and DM_SERIAL support

Andrejs Cainikovs (1):
       board: toradex: verdin-imx8mm: set fixed LPDDR4 refresh rate as 
per errata ERR050805

Eduard Strehlau (1):
       smegw01: Remove misuse of CONFIG_ENV_IS_NOWHERE

Fabio Estevam (9):
       usb: ehci: mxs: Fix the USB node pointer retrieval
       usb: ehci: mxs: Use regulator_set_enable_if_allowed()
       mx28evk: Add USB Mass Storage support
       imx7d-sdb-u-boot: Pass SPDX-License tag
       mx7dsabresd: Convert to watchdog driver model
       smegw01: Convert to watchdog driver model
       mxs: Kconfig: Remove TARGET_XFI3 symbol
       pico-pi-imx7d: Unselect CONFIG_CONSOLE_MUX
       imx8mp-evk: Add USB0 OTG support

Hiago De Franco (3):
       verdin-imx8mp: drop unused tdx easy installer ifdef
       toradex: colibri_imx7: Enable nand/emmc detection and set boot 
variant
       arm: mach-imx: Makefile: Extend u-boot-nand.imx padding

Joao Paulo Goncalves (1):
       toradex: verdin-imx8mm/imx8mp: Remove bootcmd_mfg

Marcel Ziswiler (1):
       board: toradex: verdin-imx8mm: enable usb sdp spl recovery support

Marek Vasut (9):
       imx: hab: Use CONFIG_SPL_LOAD_FIT_ADDRESS in the CSF example
       ARM: dts: imx: Switch USB1 port control to GPIO on Data Modul 
i.MX8M Plus eDM SBC
       imx: hab: Use size parameter
       spl: fit: Add board level function to decide application of DTO
       arm64: dts: imx8mp: Switch to DT overlays for i.MX8MP DHCOM SoM
       arm64: dts: imx8mp: Update i.MX8MP DHCOM SoM DT to production rev.200
       arm64: dts: imx8mp: Drop i.MX8MP DHCOM rev.100 PHY address 
workaround from PDK3 DT
       arm64: dts: imx8mp: Add DT overlay describing i.MX8MP DHCOM SoM 
rev.100
       arm64: dts: imx8mp: Make GPIO3 available early in U-Boot proper 
on i.MX8MP DHCOM

Michael Scott (1):
       imx: syscounter: allow timer_init for SPL build

Rasmus Villemoes (4):
       imx8mp: binman: rename spl and u-boot nodes
       imx: spl_imx_romapi: avoid tricky use of spl_load_simple_fit() to 
get full FIT size
       imx: spl_imx_romapi.c: remove dead code
       mx8m: csf.sh: pad csf blob for u-boot.itb to CSF_SIZE minus IVT 
header

Ricardo Salveti (1):
       arm: dts: imx6ull-14x14-evk-u-boot: add rngb

Sébastien Szymanski (2):
       clk: imx: add i.MX93 CCF driver
       imx93_evk: defconfig: enable clock driver

Teresa Remmet (6):
       board: phytec: Add common PHYTEC SoM detection
       board: phytec: common: Add imx8m specific EEPROM detection support
       board: phytec: phycore_imx8mp: Update 2GB RAM Timings
       board: phytec: common: phytec_som_detection: Add helper for PCB 
revision
       board: phytec: phycore-imx8mp: Add EEPROM detection initialisation
       board: phytec: phycore_imx8mp: Add 4000MTS RAM timings based on 
PCB rev

Tim Harvey (10):
       board: gateworks: venice: add imx8mp-gw71xx-2x support
       board: gateworks: venice: add imx8mp-gw72xx-2x support
       board: gateworks: venice: add imx8mp-gw73xx-2x support
       board: gateworks: venice: add imx8mm-gw7905-0x support
       board: gateworks: venice: updates for imx8mp-venice-gw74xx revB PCB
       arm: dts: imx8mm: move firmware/optee node to common 
imx8mm-u-boot.dtsi
       arm: dts: imx8mp: move firmware/optee node to common 
imx8mp-u-boot.dtsi
       arm: dts: imx8mn: protect the firmware/optee node with ifdef
       arm: dts: imx8m: move CAAM nodes into common u-boot.dtsi
       arm: imx: imx8m: add optee configuration to ft_system_setup

Ye Li (1):
       serial: lpuart: Enable IPG clock

  arch/arm/dts/Makefile                                |   9 +++++++
  arch/arm/dts/imx6ull-14x14-evk-u-boot.dtsi           |   4 ++++
  arch/arm/dts/imx7d-sdb-u-boot.dtsi                   |  14 +++++++++++
  arch/arm/dts/imx7d-smegw01-u-boot.dtsi               |  13 ++++++++++
  arch/arm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi    |   7 ------
  arch/arm/dts/imx8mm-cl-iot-gate-u-boot.dtsi          |   7 ------
  arch/arm/dts/imx8mm-evk-u-boot.dtsi                  |  23 
------------------
  arch/arm/dts/imx8mm-kontron-bl-common-u-boot.dtsi    |  23 
------------------
  arch/arm/dts/imx8mm-phg-u-boot.dtsi                  |   7 ------
  arch/arm/dts/imx8mm-u-boot.dtsi                      |  29 
+++++++++++++++++++++++
  arch/arm/dts/imx8mm-venice-gw7905-0x-u-boot.dtsi     |  58 
+++++++++++++++++++++++++++++++++++++++++++++
  arch/arm/dts/imx8mm-venice-gw7905-0x.dts             |  28 
++++++++++++++++++++++
  arch/arm/dts/imx8mm-venice-gw7905.dtsi               | 303 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi      |  24 
+++++++++++++------
  arch/arm/dts/imx8mn-ddr4-evk-u-boot.dtsi             |  16 -------------
  arch/arm/dts/imx8mn-u-boot.dtsi                      |  22 
+++++++++++++++++
  arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi           |  23 
------------------
  arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi   |  30 
++++++++++++++++++++++++
  arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dts  |  10 ++++++++
  arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts    |  10 ++++++++
  arch/arm/dts/imx8mp-dhcom-pdk3.dts                   |   4 ----
  arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dts  |  43 
++++++++++++++++++++++++++++++++++
  arch/arm/dts/imx8mp-dhcom-som-overlay-eth2xfast.dts  |  24 
+++++++++++++++++++
  arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts     | 120 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  arch/arm/dts/imx8mp-dhcom-som.dtsi                   | 176 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
  arch/arm/dts/imx8mp-dhcom-u-boot.dtsi                |  72 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  arch/arm/dts/imx8mp-evk-u-boot.dtsi                  |  35 
++++++++++-----------------
  arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi |  23 
------------------
  arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi           |   7 ------
  arch/arm/dts/imx8mp-u-boot.dtsi                      |  35 
+++++++++++++++++++++++++--
  arch/arm/dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi     |  54 
++++++++++++++++++++++++++++++++++++++++++
  arch/arm/dts/imx8mp-venice-gw71xx-2x.dts             |  19 +++++++++++++++
  arch/arm/dts/imx8mp-venice-gw71xx.dtsi               | 236 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  arch/arm/dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi     |  89 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  arch/arm/dts/imx8mp-venice-gw72xx-2x.dts             |  19 +++++++++++++++
  arch/arm/dts/imx8mp-venice-gw72xx.dtsi               | 371 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  arch/arm/dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi     |  95 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  arch/arm/dts/imx8mp-venice-gw73xx-2x.dts             |  19 +++++++++++++++
  arch/arm/dts/imx8mp-venice-gw73xx.dtsi               | 414 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi        |  77 
+++++++++++++++++++++++++++++++++---------------------------
  arch/arm/dts/imx8mp-venice-gw74xx.dts                | 263 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------------------
  arch/arm/dts/imx8mp-venice-u-boot.dtsi               |   8 +++++++
  arch/arm/dts/imx8mp-venice.dts                       |  14 +++++++++++
  arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi      |  23 
------------------
  arch/arm/dts/imx93-11x11-evk-u-boot.dtsi             |  23 
++++++++++++++++++
  arch/arm/dts/imx93.dtsi                              |   4 ++--
  arch/arm/mach-imx/Makefile                           |   4 +++-
  arch/arm/mach-imx/imx8m/soc.c                        |  78 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
  arch/arm/mach-imx/mxs/Kconfig                        |   3 ---
  arch/arm/mach-imx/spl.c                              |   2 +-
  arch/arm/mach-imx/spl_imx_romapi.c                   |  75 
++++++++++++++++++++++++++++++++++++++++------------------
  arch/arm/mach-imx/syscounter.c                       |   2 +-
  board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c    | 228 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  board/dhelectronics/dh_imx8mp/spl.c                  |  62 
++++++++++++++++++++++++++++++++++++++++++++++++
  board/freescale/imx93_evk/imx93_evk.c                |   2 --
  board/gateworks/venice/spl.c                         |   4 ++--
  board/phytec/common/Kconfig                          |  13 ++++++++++
  board/phytec/common/Makefile                         |  11 +++++++++
  board/phytec/common/imx8m_som_detection.c            | 168 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  board/phytec/common/imx8m_som_detection.h            |  54 
++++++++++++++++++++++++++++++++++++++++++
  board/phytec/common/phytec_som_detection.c           | 203 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  board/phytec/common/phytec_som_detection.h           | 109 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  board/phytec/phycore_imx8mp/Kconfig                  |   1 +
  board/phytec/phycore_imx8mp/lpddr4_timing.c          | 278 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------------------------------------------------
  board/phytec/phycore_imx8mp/spl.c                    |  78 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  board/storopack/smegw01/smegw01.c                    |  15 ------------
  board/toradex/colibri_imx7/colibri_imx7.c            |  24 
+++++++++++++++++++
  board/toradex/verdin-imx8mm/lpddr4_timing.c          |  51 
+++++++++++++++++++---------------------
  common/spl/spl_fit.c                                 |  23 
+++++++++++++++---
  configs/imx8mm_venice_defconfig                      |   2 +-
  configs/imx8mp_dhcom_pdk3_defconfig                  |   4 +++-
  configs/imx8mp_evk_defconfig                         |  31 
++++++++++++++++++++++++
  configs/imx8mp_venice_defconfig                      |   2 +-
  configs/imx93_11x11_evk_defconfig                    |   2 ++
  configs/mx28evk_defconfig                            |   9 +++++++
  configs/mx7dsabresd_defconfig                        |   3 +++
  configs/phycore-imx8mp_defconfig                     |   1 +
  configs/pico-dwarf-imx7d_defconfig                   |   1 +
  configs/pico-hobbit-imx7d_defconfig                  |   1 +
  configs/pico-imx7d_bl33_defconfig                    |   1 +
  configs/pico-imx7d_defconfig                         |   1 +
  configs/pico-nymph-imx7d_defconfig                   |   1 +
  configs/pico-pi-imx7d_defconfig                      |   1 +
  configs/smegw01_defconfig                            |   4 +++-
  configs/usbarmory_defconfig                          |   3 ++-
  configs/verdin-imx8mm_defconfig                      |  20 
++++++++++++++++
  doc/imx/habv4/csf_examples/mx8m/csf.sh               |  13 ++++++++++
  doc/imx/habv4/csf_examples/mx8m/csf_fit.txt          |   2 +-
  drivers/clk/imx/Kconfig                              |  18 ++++++++++++++
  drivers/clk/imx/Makefile                             |   2 ++
  drivers/clk/imx/clk-composite-93.c                   | 142 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/clk/imx/clk-fracn-gppll.c                    | 382 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/clk/imx/clk-gate-93.c                        | 148 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/clk/imx/clk-imx93.c                          | 343 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/clk/imx/clk.h                                |  42 
+++++++++++++++++++++++++++++++++
  drivers/serial/serial_lpuart.c                       |  14 ++++++++++-
  drivers/usb/host/ehci-mxs.c                          |  15 ++++++------
  include/configs/verdin-imx8mm.h                      |   1 -
  include/configs/verdin-imx8mp.h                      |  11 ++-------
  include/dt-bindings/clock/imx93-clock.h              |   6 ++++-
  include/spl.h                                        |  16 +++++++++++++
  101 files changed, 4801 insertions(+), 856 deletions(-)
  create mode 100644 arch/arm/dts/imx8mm-venice-gw7905-0x-u-boot.dtsi
  create mode 100644 arch/arm/dts/imx8mm-venice-gw7905-0x.dts
  create mode 100644 arch/arm/dts/imx8mm-venice-gw7905.dtsi
  create mode 100644 arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dts
  create mode 100644 arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts
  create mode 100644 arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dts
  create mode 100644 arch/arm/dts/imx8mp-dhcom-som-overlay-eth2xfast.dts
  create mode 100644 arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts
  create mode 100644 arch/arm/dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi
  create mode 100644 arch/arm/dts/imx8mp-venice-gw71xx-2x.dts
  create mode 100644 arch/arm/dts/imx8mp-venice-gw71xx.dtsi
  create mode 100644 arch/arm/dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi
  create mode 100644 arch/arm/dts/imx8mp-venice-gw72xx-2x.dts
  create mode 100644 arch/arm/dts/imx8mp-venice-gw72xx.dtsi
  create mode 100644 arch/arm/dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi
  create mode 100644 arch/arm/dts/imx8mp-venice-gw73xx-2x.dts
  create mode 100644 arch/arm/dts/imx8mp-venice-gw73xx.dtsi
  create mode 100644 board/phytec/common/Kconfig
  create mode 100644 board/phytec/common/Makefile
  create mode 100644 board/phytec/common/imx8m_som_detection.c
  create mode 100644 board/phytec/common/imx8m_som_detection.h
  create mode 100644 board/phytec/common/phytec_som_detection.c
  create mode 100644 board/phytec/common/phytec_som_detection.h
  create mode 100644 drivers/clk/imx/clk-composite-93.c
  create mode 100644 drivers/clk/imx/clk-fracn-gppll.c
  create mode 100644 drivers/clk/imx/clk-gate-93.c
  create mode 100644 drivers/clk/imx/clk-imx93.c

Best regards,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
