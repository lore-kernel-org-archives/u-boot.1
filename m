Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624CFC4167B
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 20:58:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CD9D87605;
	Wed,  1 Nov 2023 21:58:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UKozEUNu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3251C87683; Wed,  1 Nov 2023 21:56:20 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FDC687033
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 21:56:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A1Ku5Nm048031;
 Wed, 1 Nov 2023 15:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698872165;
 bh=8KsTuO8Teo/yxAHfDizmP94jhg3O0GWl5wuZRTlFxbE=;
 h=From:To:CC:Subject:Date;
 b=UKozEUNuv1RZOVrqut8UDfT0ft304+kOgUHqiuo1ufUk/P0vFdTkoCFYYykqy3jnh
 Ub88pUmeWfFRKDxodBrNDde+Y4CCu/liv+U7PKDza7fM2RKQdaxs+wpB1MzCXD6/FU
 QLDuKossfIqSOIh0iMo5pgZfW4Su6FoqGNAq2HVs=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A1Ku5Le070874
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 1 Nov 2023 15:56:05 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 1
 Nov 2023 15:56:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 1 Nov 2023 15:56:04 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A1Ku4hG010247;
 Wed, 1 Nov 2023 15:56:04 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] tree-wide: Replace http:// link with https:// link for ti.com
Date: Wed, 1 Nov 2023 15:56:03 -0500
Message-ID: <20231101205603.1786870-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 01 Nov 2023 21:58:11 +0100
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

Replace instances of http://www.ti.com with https://www.ti.com

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/cpu/armv7/mpu_v7r.c                        |  2 +-
 arch/arm/dts/am335x-baltos.dts                      |  2 +-
 arch/arm/dts/am335x-evm-u-boot.dtsi                 |  2 +-
 arch/arm/dts/am335x-evmsk.dts                       |  2 +-
 arch/arm/dts/am335x-icev2-u-boot.dtsi               |  2 +-
 arch/arm/dts/am335x-icev2.dts                       |  2 +-
 arch/arm/dts/am335x-pxm2.dtsi                       |  2 +-
 arch/arm/dts/am335x-pxm50.dts                       |  2 +-
 arch/arm/dts/am335x-rut.dts                         |  2 +-
 arch/arm/dts/am335x-sancloud-bbe-extended-wifi.dts  |  2 +-
 arch/arm/dts/am335x-sancloud-bbe-lite-u-boot.dtsi   |  2 +-
 arch/arm/dts/am335x-sancloud-bbe-lite.dts           |  2 +-
 arch/arm/dts/am4372-generic-u-boot.dtsi             |  2 +-
 arch/arm/dts/am4372-generic.dts                     |  2 +-
 arch/arm/dts/am4372-u-boot.dtsi                     |  2 +-
 arch/arm/dts/am437x-gp-evm-u-boot.dtsi              |  2 +-
 arch/arm/dts/am437x-idk-evm-u-boot.dtsi             |  2 +-
 arch/arm/dts/am437x-sk-evm-u-boot.dtsi              |  2 +-
 arch/arm/dts/am571x-idk-u-boot.dtsi                 |  2 +-
 arch/arm/dts/am5729-beagleboneai.dts                |  2 +-
 arch/arm/dts/am572x-idk-u-boot.dtsi                 |  2 +-
 arch/arm/dts/am574x-idk-u-boot.dtsi                 |  2 +-
 arch/arm/dts/am57xx-beagle-x15-revb1-u-boot.dtsi    |  2 +-
 arch/arm/dts/am57xx-beagle-x15-revc-u-boot.dtsi     |  2 +-
 arch/arm/dts/am57xx-beagle-x15-u-boot.dtsi          |  2 +-
 arch/arm/dts/am57xx-cl-som-am57x-u-boot.dtsi        |  2 +-
 arch/arm/dts/am57xx-idk-common-u-boot.dtsi          |  2 +-
 arch/arm/dts/am57xx-sbc-am57x-u-boot.dtsi           |  2 +-
 arch/arm/dts/da850-lcdk-u-boot.dtsi                 |  2 +-
 arch/arm/dts/dra7-evm-u-boot.dtsi                   |  2 +-
 arch/arm/dts/dra7-ipu-common-early-boot.dtsi        |  2 +-
 arch/arm/dts/dra71-evm-u-boot.dtsi                  |  2 +-
 arch/arm/dts/dra72-evm-revc-u-boot.dtsi             |  2 +-
 arch/arm/dts/dra72-evm-u-boot.dtsi                  |  2 +-
 arch/arm/dts/dra76-evm-u-boot.dtsi                  |  2 +-
 arch/arm/dts/k3-am654-base-board-ddr4-1600MTs.dtsi  |  4 ++--
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi        |  2 +-
 arch/arm/dts/k3-am654-ddr.dtsi                      |  2 +-
 arch/arm/dts/k3-am654-r5-base-board-u-boot.dtsi     |  2 +-
 arch/arm/dts/k3-am654-r5-base-board.dts             |  2 +-
 arch/arm/dts/k3-j7200-ddr-evm-lp4-2666.dtsi         |  2 +-
 arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi |  2 +-
 arch/arm/dts/k3-j721e-ddr-evm-lp4-4266.dtsi         |  2 +-
 arch/arm/dts/k3-j721e-ddr-sk-lp4-4266.dtsi          |  2 +-
 arch/arm/dts/k3-j721e-ddr.dtsi                      |  2 +-
 arch/arm/dts/k3-j721e-r5-common-proc-board.dts      |  2 +-
 arch/arm/dts/keystone-clocks.dtsi                   |  2 +-
 arch/arm/dts/keystone-k2e-clocks.dtsi               |  2 +-
 arch/arm/dts/keystone-k2e-evm-u-boot.dtsi           |  2 +-
 arch/arm/dts/keystone-k2e-evm.dts                   |  2 +-
 arch/arm/dts/keystone-k2e-netcp.dtsi                |  2 +-
 arch/arm/dts/keystone-k2e.dtsi                      |  2 +-
 arch/arm/dts/keystone-k2g-evm-u-boot.dtsi           |  2 +-
 arch/arm/dts/keystone-k2g-evm.dts                   |  2 +-
 arch/arm/dts/keystone-k2g-generic-u-boot.dtsi       |  2 +-
 arch/arm/dts/keystone-k2g-generic.dts               |  2 +-
 arch/arm/dts/keystone-k2g-ice-u-boot.dtsi           |  2 +-
 arch/arm/dts/keystone-k2g-ice.dts                   |  2 +-
 arch/arm/dts/keystone-k2g-netcp.dtsi                |  2 +-
 arch/arm/dts/keystone-k2g.dtsi                      |  2 +-
 arch/arm/dts/keystone-k2hk-clocks.dtsi              |  2 +-
 arch/arm/dts/keystone-k2hk-evm-u-boot.dtsi          |  2 +-
 arch/arm/dts/keystone-k2hk-evm.dts                  |  2 +-
 arch/arm/dts/keystone-k2hk-netcp.dtsi               |  2 +-
 arch/arm/dts/keystone-k2hk.dtsi                     |  2 +-
 arch/arm/dts/keystone-k2l-clocks.dtsi               |  2 +-
 arch/arm/dts/keystone-k2l-evm-u-boot.dtsi           |  2 +-
 arch/arm/dts/keystone-k2l-evm.dts                   |  2 +-
 arch/arm/dts/keystone-k2l-netcp.dtsi                |  2 +-
 arch/arm/dts/keystone-k2l.dtsi                      |  2 +-
 arch/arm/dts/keystone.dtsi                          |  2 +-
 arch/arm/dts/omap3-u-boot.dtsi                      |  2 +-
 arch/arm/dts/omap5-u-boot.dtsi                      |  2 +-
 arch/arm/dts/tps6507x.dtsi                          |  4 ++--
 arch/arm/dts/tps65217.dtsi                          |  4 ++--
 arch/arm/dts/tps65910.dtsi                          |  4 ++--
 arch/arm/dts/twl4030.dtsi                           |  2 +-
 arch/arm/dts/twl6030.dtsi                           |  4 ++--
 arch/arm/dts/twl6030_omap4.dtsi                     |  2 +-
 arch/arm/include/asm/arch-am33xx/clk_synthesizer.h  |  2 +-
 arch/arm/include/asm/arch-am33xx/clock.h            |  2 +-
 arch/arm/include/asm/arch-am33xx/clocks_am33xx.h    |  2 +-
 arch/arm/include/asm/arch-am33xx/cpu.h              |  2 +-
 arch/arm/include/asm/arch-am33xx/ddr_defs.h         |  2 +-
 arch/arm/include/asm/arch-am33xx/hardware.h         |  2 +-
 arch/arm/include/asm/arch-am33xx/hardware_am33xx.h  |  2 +-
 arch/arm/include/asm/arch-am33xx/hardware_am43xx.h  |  2 +-
 arch/arm/include/asm/arch-am33xx/mmc_host_def.h     |  2 +-
 arch/arm/include/asm/arch-am33xx/mux.h              |  2 +-
 arch/arm/include/asm/arch-am33xx/mux_am33xx.h       |  2 +-
 arch/arm/include/asm/arch-am33xx/mux_am43xx.h       |  2 +-
 arch/arm/include/asm/arch-am33xx/omap.h             |  2 +-
 arch/arm/include/asm/arch-am33xx/sys_proto.h        |  2 +-
 arch/arm/include/asm/arch-omap3/emif4.h             |  2 +-
 arch/arm/include/asm/arch-omap4/ehci.h              |  2 +-
 arch/arm/include/asm/arch-omap4/hardware.h          |  2 +-
 arch/arm/include/asm/arch-omap5/ehci.h              |  2 +-
 arch/arm/include/asm/arch-omap5/hardware.h          |  2 +-
 arch/arm/include/asm/ehci-omap.h                    |  2 +-
 arch/arm/include/asm/ti-common/omap_wdt.h           |  2 +-
 arch/arm/mach-davinci/config.mk                     |  2 +-
 arch/arm/mach-k3/Makefile                           |  2 +-
 arch/arm/mach-k3/am654_init.c                       |  2 +-
 arch/arm/mach-k3/cache.S                            |  2 +-
 arch/arm/mach-k3/common.c                           |  2 +-
 arch/arm/mach-k3/common.h                           |  2 +-
 arch/arm/mach-k3/include/mach/am6_hardware.h        |  2 +-
 arch/arm/mach-k3/include/mach/am6_spl.h             |  2 +-
 arch/arm/mach-k3/include/mach/clock.h               |  2 +-
 arch/arm/mach-k3/include/mach/hardware.h            |  2 +-
 arch/arm/mach-k3/include/mach/j721e_hardware.h      |  2 +-
 arch/arm/mach-k3/include/mach/j721e_spl.h           |  2 +-
 arch/arm/mach-k3/include/mach/j721s2_hardware.h     |  2 +-
 arch/arm/mach-k3/include/mach/j721s2_spl.h          |  2 +-
 arch/arm/mach-k3/include/mach/spl.h                 |  2 +-
 arch/arm/mach-k3/j7200/Makefile                     |  2 +-
 arch/arm/mach-k3/j721e/Makefile                     |  2 +-
 arch/arm/mach-k3/j721e_init.c                       |  2 +-
 arch/arm/mach-k3/j721s2/Makefile                    |  2 +-
 arch/arm/mach-k3/j721s2_init.c                      |  2 +-
 arch/arm/mach-k3/lowlevel_init.S                    |  2 +-
 arch/arm/mach-k3/r5_mpu.c                           |  2 +-
 arch/arm/mach-k3/security.c                         |  2 +-
 arch/arm/mach-k3/sysfw-loader.c                     |  2 +-
 arch/arm/mach-k3/sysfw-loader.h                     |  2 +-
 arch/arm/mach-keystone/mon.c                        |  2 +-
 arch/arm/mach-omap2/am33xx/Makefile                 |  2 +-
 arch/arm/mach-omap2/am33xx/board.c                  |  2 +-
 arch/arm/mach-omap2/am33xx/chilisom.c               |  2 +-
 arch/arm/mach-omap2/am33xx/clk_synthesizer.c        |  2 +-
 arch/arm/mach-omap2/am33xx/clock.c                  |  2 +-
 arch/arm/mach-omap2/am33xx/clock_am33xx.c           |  2 +-
 arch/arm/mach-omap2/am33xx/clock_am43xx.c           |  2 +-
 arch/arm/mach-omap2/am33xx/ddr.c                    |  2 +-
 arch/arm/mach-omap2/am33xx/emif4.c                  |  2 +-
 arch/arm/mach-omap2/am33xx/mux.c                    |  2 +-
 arch/arm/mach-omap2/am33xx/sys_info.c               |  2 +-
 arch/arm/mach-omap2/boot-common.c                   |  2 +-
 arch/arm/mach-omap2/config.mk                       |  2 +-
 arch/arm/mach-omap2/config_secure.mk                |  2 +-
 arch/arm/mach-omap2/omap3/emif4.c                   |  2 +-
 arch/arm/mach-omap2/omap3/sdrc.c                    |  2 +-
 arch/arm/mach-omap2/vc.c                            |  2 +-
 arch/arm/mach-sunxi/dram_sun8i_a23.c                |  2 +-
 board/bosch/guardian/board.c                        |  2 +-
 board/bosch/guardian/board.h                        |  2 +-
 board/bosch/guardian/mux.c                          |  2 +-
 board/bosch/shc/Makefile                            |  2 +-
 board/bosch/shc/board.c                             |  2 +-
 board/bosch/shc/board.h                             |  2 +-
 board/bosch/shc/mux.c                               |  2 +-
 board/davinci/da8xxevm/da850evm.c                   |  2 +-
 board/davinci/da8xxevm/omapl138_lcdk.c              |  2 +-
 board/eets/pdu001/README                            |  2 +-
 board/eets/pdu001/board.c                           |  2 +-
 board/eets/pdu001/board.h                           |  2 +-
 board/eets/pdu001/mux.c                             |  2 +-
 board/grinn/chiliboard/board.c                      |  2 +-
 board/lego/ev3/legoev3.c                            |  2 +-
 board/logicpd/am3517evm/Makefile                    |  2 +-
 board/logicpd/am3517evm/am3517evm.c                 |  2 +-
 board/logicpd/am3517evm/am3517evm.h                 |  2 +-
 board/phytec/phycore_am335x_r2/Makefile             |  2 +-
 board/phytec/phycore_am335x_r2/board.c              |  2 +-
 board/siemens/common/board.c                        |  2 +-
 board/siemens/draco/Makefile                        |  2 +-
 board/siemens/draco/board.c                         |  2 +-
 board/siemens/draco/board.h                         |  2 +-
 board/siemens/draco/mux.c                           |  2 +-
 board/siemens/pxm2/Makefile                         |  2 +-
 board/siemens/pxm2/board.c                          |  2 +-
 board/siemens/pxm2/board.h                          |  2 +-
 board/siemens/pxm2/mux.c                            |  2 +-
 board/siemens/pxm2/pmic.h                           |  2 +-
 board/siemens/rut/Makefile                          |  2 +-
 board/siemens/rut/board.c                           |  2 +-
 board/siemens/rut/board.h                           |  2 +-
 board/siemens/rut/mux.c                             |  2 +-
 board/tcl/sl50/board.c                              |  2 +-
 board/tcl/sl50/board.h                              |  2 +-
 board/tcl/sl50/mux.c                                |  2 +-
 board/ti/am335x/Makefile                            |  2 +-
 board/ti/am335x/board.c                             |  2 +-
 board/ti/am335x/board.h                             |  2 +-
 board/ti/am335x/mux.c                               |  2 +-
 board/ti/am43xx/Makefile                            |  2 +-
 board/ti/am43xx/board.c                             |  2 +-
 board/ti/am43xx/board.h                             |  2 +-
 board/ti/am43xx/mux.c                               |  2 +-
 board/ti/am57xx/board.c                             |  2 +-
 board/ti/am57xx/mux_data.h                          |  2 +-
 board/ti/am65x/Kconfig                              |  2 +-
 board/ti/am65x/Makefile                             |  2 +-
 board/ti/am65x/evm.c                                |  2 +-
 board/ti/common/Makefile                            |  2 +-
 board/ti/common/board_detect.c                      |  2 +-
 board/ti/common/board_detect.h                      |  2 +-
 board/ti/j721e/Kconfig                              |  2 +-
 board/ti/j721e/Makefile                             |  2 +-
 board/ti/j721e/evm.c                                |  2 +-
 board/ti/j721s2/evm.c                               |  2 +-
 board/vscom/baltos/Makefile                         |  2 +-
 board/vscom/baltos/board.c                          |  2 +-
 board/vscom/baltos/board.h                          |  2 +-
 board/vscom/baltos/mux.c                            |  2 +-
 cmd/remoteproc.c                                    |  2 +-
 cmd/ti/Makefile                                     |  2 +-
 cmd/ufs.c                                           |  2 +-
 common/spl/Makefile                                 |  2 +-
 doc/README.davinci                                  |  2 +-
 doc/README.omap3                                    |  4 ++--
 doc/board/ti/am335x_evm.rst                         |  2 +-
 doc/board/ti/am65x_evm.rst                          |  2 +-
 doc/board/ti/j721e_evm.rst                          |  2 +-
 doc/board/ti/ks2_evm.rst                            | 10 +++++-----
 doc/develop/driver-model/remoteproc-framework.rst   |  2 +-
 doc/develop/driver-model/soc-framework.rst          |  2 +-
 doc/device-tree-bindings/clock/ti,cdce9xx.txt       |  8 ++++----
 doc/device-tree-bindings/video/tilcdc/tilcdc.txt    |  2 +-
 drivers/clk/clk-cdce9xx.c                           |  2 +-
 drivers/clk/ti/clk-k3-pll.c                         |  2 +-
 drivers/clk/ti/clk-k3.c                             |  2 +-
 drivers/clk/ti/clk-sci.c                            |  2 +-
 drivers/dma/ti/k3-psil-am64.c                       |  2 +-
 drivers/dma/ti/k3-psil-am654.c                      |  2 +-
 drivers/dma/ti/k3-psil-priv.h                       |  2 +-
 drivers/dma/ti/k3-psil.c                            |  2 +-
 drivers/dma/ti/k3-psil.h                            |  2 +-
 drivers/dma/ti/k3-udma-hwdef.h                      |  2 +-
 drivers/dma/ti/k3-udma.c                            |  2 +-
 drivers/firmware/ti_sci.c                           |  2 +-
 drivers/firmware/ti_sci.h                           |  2 +-
 drivers/firmware/ti_sci_static_data.h               |  2 +-
 drivers/gpio/pcf8575_gpio.c                         |  2 +-
 drivers/mailbox/k3-sec-proxy.c                      |  2 +-
 drivers/memory/ti-gpmc.c                            |  2 +-
 drivers/memory/ti-gpmc.h                            |  2 +-
 drivers/misc/esm_pmic.c                             |  2 +-
 drivers/misc/k3_avs.c                               |  2 +-
 drivers/misc/k3_esm.c                               |  2 +-
 drivers/mmc/am654_sdhci.c                           |  2 +-
 drivers/mtd/hbmc-am654.c                            |  2 +-
 drivers/mtd/spi/spi-nor-ids.c                       |  2 +-
 drivers/mux/mux-uclass.c                            |  2 +-
 drivers/net/phy/et1011c.c                           |  2 +-
 drivers/net/ti/Kconfig                              |  2 +-
 drivers/net/ti/Makefile                             |  2 +-
 drivers/net/ti/cpsw.c                               |  2 +-
 drivers/net/ti/cpsw_mdio.c                          |  2 +-
 drivers/net/ti/cpsw_mdio.h                          |  2 +-
 drivers/phy/Makefile                                |  2 +-
 drivers/phy/cadence/phy-cadence-sierra.c            |  2 +-
 drivers/phy/keystone-usb-phy.c                      |  2 +-
 drivers/phy/nop-phy.c                               |  2 +-
 drivers/phy/omap-usb2-phy.c                         |  2 +-
 drivers/phy/phy-uclass.c                            |  2 +-
 drivers/phy/sandbox-phy.c                           |  2 +-
 drivers/phy/ti-pipe3-phy.c                          |  2 +-
 drivers/phy/ti/phy-j721e-wiz.c                      |  2 +-
 drivers/power/domain/ti-power-domain.c              |  2 +-
 drivers/power/domain/ti-sci-power-domain.c          |  2 +-
 drivers/power/pmic/pmic_tps62362.c                  |  2 +-
 drivers/power/regulator/tps62360_regulator.c        |  2 +-
 drivers/ram/k3-am654-ddrss.c                        |  2 +-
 drivers/ram/k3-am654-ddrss.h                        |  2 +-
 drivers/ram/k3-ddrss/Makefile                       |  2 +-
 drivers/ram/k3-ddrss/k3-ddrss.c                     |  2 +-
 drivers/remoteproc/Kconfig                          |  2 +-
 drivers/remoteproc/Makefile                         |  2 +-
 drivers/remoteproc/ipu_rproc.c                      |  2 +-
 drivers/remoteproc/k3_system_controller.c           |  2 +-
 drivers/remoteproc/pru_rproc.c                      |  2 +-
 drivers/remoteproc/rproc-uclass.c                   |  2 +-
 drivers/remoteproc/sandbox_testproc.c               |  2 +-
 drivers/remoteproc/ti_k3_arm64_rproc.c              |  2 +-
 drivers/remoteproc/ti_k3_dsp_rproc.c                |  2 +-
 drivers/remoteproc/ti_power_proc.c                  |  2 +-
 drivers/remoteproc/ti_sci_proc.h                    |  2 +-
 drivers/reset/reset-dra7.c                          |  2 +-
 drivers/reset/reset-ti-sci.c                        |  2 +-
 drivers/serial/serial_omap.c                        |  2 +-
 drivers/soc/soc-uclass.c                            |  2 +-
 drivers/soc/soc_sandbox.c                           |  2 +-
 drivers/soc/soc_ti_k3.c                             |  2 +-
 drivers/soc/ti/k3-navss-ringacc.c                   |  2 +-
 drivers/spi/davinci_spi.c                           |  2 +-
 drivers/spi/omap3_spi.c                             |  2 +-
 drivers/spi/spi-mem-nodm.c                          |  2 +-
 drivers/sysreset/sysreset-ti-sci.c                  |  2 +-
 drivers/thermal/ti-bandgap.c                        |  2 +-
 drivers/ufs/Makefile                                |  2 +-
 drivers/ufs/cdns-platform.c                         |  2 +-
 drivers/ufs/ti-j721e-ufs.c                          |  2 +-
 drivers/ufs/ufs-uclass.c                            |  2 +-
 drivers/ufs/ufs.c                                   |  2 +-
 drivers/usb/cdns3/cdns3-ti.c                        |  2 +-
 drivers/usb/dwc3/core.c                             |  2 +-
 drivers/usb/dwc3/core.h                             |  2 +-
 drivers/usb/dwc3/dwc3-omap.c                        |  2 +-
 drivers/usb/dwc3/ep0.c                              |  2 +-
 drivers/usb/dwc3/gadget.c                           |  2 +-
 drivers/usb/dwc3/gadget.h                           |  2 +-
 drivers/usb/dwc3/io.h                               |  2 +-
 drivers/usb/dwc3/linux-compat.h                     |  2 +-
 drivers/usb/dwc3/ti_usb_phy.c                       |  2 +-
 drivers/usb/gadget/udc/udc-core.c                   |  2 +-
 drivers/usb/gadget/udc/udc-uclass.c                 |  2 +-
 drivers/usb/host/dwc3-of-simple.c                   |  2 +-
 drivers/usb/ulpi/omap-ulpi-viewport.c               |  2 +-
 include/configs/am335x_evm.h                        |  2 +-
 include/configs/am335x_shc.h                        |  2 +-
 include/configs/am43xx_evm.h                        |  2 +-
 include/configs/am65x_evm.h                         |  2 +-
 include/configs/baltos.h                            |  2 +-
 include/configs/da850evm.h                          |  2 +-
 include/configs/draco.h                             |  2 +-
 include/configs/etamin.h                            |  2 +-
 include/configs/legoev3.h                           |  2 +-
 include/configs/omap3_evm.h                         |  2 +-
 include/configs/omapl138_lcdk.h                     |  2 +-
 include/configs/pdu001.h                            |  2 +-
 include/configs/phycore_am335x_r2.h                 |  2 +-
 include/configs/pxm2.h                              |  2 +-
 include/configs/rastaban.h                          |  2 +-
 include/configs/rut.h                               |  2 +-
 include/configs/siemens-am33x-common.h              |  2 +-
 include/configs/thuban.h                            |  2 +-
 include/configs/ti_am335x_common.h                  |  4 ++--
 include/configs/ti_armv7_common.h                   |  2 +-
 include/configs/ti_armv7_omap.h                     |  2 +-
 include/configs/ti_omap3_common.h                   |  8 ++++----
 include/configs/ti_omap5_common.h                   |  2 +-
 include/cpsw.h                                      |  2 +-
 include/dt-bindings/pinctrl/dra.h                   |  2 +-
 include/dt-bindings/reset/ti-syscon.h               |  2 +-
 include/dwc3-omap-uboot.h                           |  2 +-
 include/dwc3-uboot.h                                |  2 +-
 include/env/ti/dfu.h                                |  2 +-
 include/env/ti/k3_dfu.h                             |  2 +-
 include/env/ti/k3_rproc.h                           |  2 +-
 include/env/ti/mmc.h                                |  2 +-
 include/env/ti/nand.h                               |  2 +-
 include/env/ti/ufs.h                                |  2 +-
 include/generic-phy.h                               |  2 +-
 include/k3-avs.h                                    |  2 +-
 include/k3-clk.h                                    |  2 +-
 include/k3-dev.h                                    |  2 +-
 include/linux/soc/ti/cppi5.h                        |  2 +-
 include/linux/soc/ti/k3-navss-ringacc.h             |  2 +-
 include/linux/soc/ti/k3-sec-proxy.h                 |  2 +-
 include/linux/soc/ti/ti-udma.h                      |  2 +-
 include/linux/soc/ti/ti_sci_protocol.h              |  2 +-
 include/linux/usb/dwc3-omap.h                       |  2 +-
 include/linux/usb/otg.h                             |  2 +-
 include/mux-internal.h                              |  2 +-
 include/mux.h                                       |  2 +-
 include/power/tps62362.h                            |  2 +-
 include/power/tps65217.h                            |  2 +-
 include/power/tps65910.h                            |  2 +-
 include/remoteproc.h                                |  2 +-
 include/soc.h                                       |  2 +-
 include/ti-usb-phy-uboot.h                          |  2 +-
 scripts/Makefile.spl                                |  2 +-
 test/dm/mux-emul.c                                  |  2 +-
 test/dm/mux-mmio.c                                  |  2 +-
 test/dm/nop.c                                       |  2 +-
 test/dm/phy.c                                       |  2 +-
 test/dm/remoteproc.c                                |  2 +-
 test/dm/soc.c                                       |  2 +-
 369 files changed, 386 insertions(+), 386 deletions(-)

diff --git a/arch/arm/cpu/armv7/mpu_v7r.c b/arch/arm/cpu/armv7/mpu_v7r.c
index 57ab640e2633..1d31c63e5fde 100644
--- a/arch/arm/cpu/armv7/mpu_v7r.c
+++ b/arch/arm/cpu/armv7/mpu_v7r.c
@@ -2,7 +2,7 @@
 /*
  * Cortex-R Memory Protection Unit specific code
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/arch/arm/dts/am335x-baltos.dts b/arch/arm/dts/am335x-baltos.dts
index b3c13c9a9d17..34b87d47a79d 100644
--- a/arch/arm/dts/am335x-baltos.dts
+++ b/arch/arm/dts/am335x-baltos.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/dts/am335x-evm-u-boot.dtsi b/arch/arm/dts/am335x-evm-u-boot.dtsi
index 82a483ae3e28..72402c82928a 100644
--- a/arch/arm/dts/am335x-evm-u-boot.dtsi
+++ b/arch/arm/dts/am335x-evm-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "am33xx-u-boot.dtsi"
diff --git a/arch/arm/dts/am335x-evmsk.dts b/arch/arm/dts/am335x-evmsk.dts
index 5d962252b7db..e0267657f900 100644
--- a/arch/arm/dts/am335x-evmsk.dts
+++ b/arch/arm/dts/am335x-evmsk.dts
@@ -5,7 +5,7 @@
 
 /*
  * AM335x Starter Kit
- * http://www.ti.com/tool/tmdssk3358
+ * https://www.ti.com/tool/tmdssk3358
  */
 
 /dts-v1/;
diff --git a/arch/arm/dts/am335x-icev2-u-boot.dtsi b/arch/arm/dts/am335x-icev2-u-boot.dtsi
index 67bfac916eee..ac1feaa9d9f6 100644
--- a/arch/arm/dts/am335x-icev2-u-boot.dtsi
+++ b/arch/arm/dts/am335x-icev2-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "am33xx-u-boot.dtsi"
diff --git a/arch/arm/dts/am335x-icev2.dts b/arch/arm/dts/am335x-icev2.dts
index a54272421cc8..bcfdbb772c11 100644
--- a/arch/arm/dts/am335x-icev2.dts
+++ b/arch/arm/dts/am335x-icev2.dts
@@ -5,7 +5,7 @@
 
 /*
  * AM335x ICE V2 board
- * http://www.ti.com/tool/tmdsice3359
+ * https://www.ti.com/tool/tmdsice3359
  */
 
 /dts-v1/;
diff --git a/arch/arm/dts/am335x-pxm2.dtsi b/arch/arm/dts/am335x-pxm2.dtsi
index a51d6aceb96f..a49560924b3d 100644
--- a/arch/arm/dts/am335x-pxm2.dtsi
+++ b/arch/arm/dts/am335x-pxm2.dtsi
@@ -3,7 +3,7 @@
  * Heiko Schocher <hs@denx.de>
  *
  * Based on:
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/dts/am335x-pxm50.dts b/arch/arm/dts/am335x-pxm50.dts
index f4e66d29d59a..69ed32c44cc1 100644
--- a/arch/arm/dts/am335x-pxm50.dts
+++ b/arch/arm/dts/am335x-pxm50.dts
@@ -2,7 +2,7 @@
  * Copyright (C) 2014 DENX Software Engineering GmbH
  * Heiko Schocher <hs@denx.de>
  *
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/dts/am335x-rut.dts b/arch/arm/dts/am335x-rut.dts
index 7760b9709a88..0dcd561d9904 100644
--- a/arch/arm/dts/am335x-rut.dts
+++ b/arch/arm/dts/am335x-rut.dts
@@ -3,7 +3,7 @@
  * Heiko Schocher <hs@denx.de>
  *
  * Based on:
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/dts/am335x-sancloud-bbe-extended-wifi.dts b/arch/arm/dts/am335x-sancloud-bbe-extended-wifi.dts
index a2676d10c24a..271d1ab356c8 100644
--- a/arch/arm/dts/am335x-sancloud-bbe-extended-wifi.dts
+++ b/arch/arm/dts/am335x-sancloud-bbe-extended-wifi.dts
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2021 Sancloud Ltd
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  */
 /dts-v1/;
 
diff --git a/arch/arm/dts/am335x-sancloud-bbe-lite-u-boot.dtsi b/arch/arm/dts/am335x-sancloud-bbe-lite-u-boot.dtsi
index fd47bc23a2e7..db0288820d95 100644
--- a/arch/arm/dts/am335x-sancloud-bbe-lite-u-boot.dtsi
+++ b/arch/arm/dts/am335x-sancloud-bbe-lite-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  * Copyright (C) 2021 SanCloud Ltd
  */
 
diff --git a/arch/arm/dts/am335x-sancloud-bbe-lite.dts b/arch/arm/dts/am335x-sancloud-bbe-lite.dts
index 8ffbc72dc57e..daa90f64a8a5 100644
--- a/arch/arm/dts/am335x-sancloud-bbe-lite.dts
+++ b/arch/arm/dts/am335x-sancloud-bbe-lite.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  * Copyright (C) 2021 SanCloud Ltd
  */
 /dts-v1/;
diff --git a/arch/arm/dts/am4372-generic-u-boot.dtsi b/arch/arm/dts/am4372-generic-u-boot.dtsi
index 1dd0a5dac1e3..40f3756eb3fe 100644
--- a/arch/arm/dts/am4372-generic-u-boot.dtsi
+++ b/arch/arm/dts/am4372-generic-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "am4372-u-boot.dtsi"
diff --git a/arch/arm/dts/am4372-generic.dts b/arch/arm/dts/am4372-generic.dts
index b8a2bb82ef54..2524e0405cd5 100644
--- a/arch/arm/dts/am4372-generic.dts
+++ b/arch/arm/dts/am4372-generic.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for Generic AM4372 EVM
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm/dts/am4372-u-boot.dtsi b/arch/arm/dts/am4372-u-boot.dtsi
index 2fac2fcdf9ba..0c498bcf085c 100644
--- a/arch/arm/dts/am4372-u-boot.dtsi
+++ b/arch/arm/dts/am4372-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /{
diff --git a/arch/arm/dts/am437x-gp-evm-u-boot.dtsi b/arch/arm/dts/am437x-gp-evm-u-boot.dtsi
index da0b1365ffeb..6393170ad22e 100644
--- a/arch/arm/dts/am437x-gp-evm-u-boot.dtsi
+++ b/arch/arm/dts/am437x-gp-evm-u-boot.dtsi
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/dts/am437x-idk-evm-u-boot.dtsi b/arch/arm/dts/am437x-idk-evm-u-boot.dtsi
index 4e6ad9445b3e..7c9f80e7ba2f 100644
--- a/arch/arm/dts/am437x-idk-evm-u-boot.dtsi
+++ b/arch/arm/dts/am437x-idk-evm-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "am4372-u-boot.dtsi"
diff --git a/arch/arm/dts/am437x-sk-evm-u-boot.dtsi b/arch/arm/dts/am437x-sk-evm-u-boot.dtsi
index 43e519c4e583..580ba3512bdd 100644
--- a/arch/arm/dts/am437x-sk-evm-u-boot.dtsi
+++ b/arch/arm/dts/am437x-sk-evm-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "am4372-u-boot.dtsi"
diff --git a/arch/arm/dts/am571x-idk-u-boot.dtsi b/arch/arm/dts/am571x-idk-u-boot.dtsi
index 65199200ed58..98a7a7eeb395 100644
--- a/arch/arm/dts/am571x-idk-u-boot.dtsi
+++ b/arch/arm/dts/am571x-idk-u-boot.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 #include "am57xx-idk-common-u-boot.dtsi"
diff --git a/arch/arm/dts/am5729-beagleboneai.dts b/arch/arm/dts/am5729-beagleboneai.dts
index f772aefb8f3b..75a29e65e10f 100644
--- a/arch/arm/dts/am5729-beagleboneai.dts
+++ b/arch/arm/dts/am5729-beagleboneai.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2014-2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2014-2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm/dts/am572x-idk-u-boot.dtsi b/arch/arm/dts/am572x-idk-u-boot.dtsi
index 65199200ed58..98a7a7eeb395 100644
--- a/arch/arm/dts/am572x-idk-u-boot.dtsi
+++ b/arch/arm/dts/am572x-idk-u-boot.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 #include "am57xx-idk-common-u-boot.dtsi"
diff --git a/arch/arm/dts/am574x-idk-u-boot.dtsi b/arch/arm/dts/am574x-idk-u-boot.dtsi
index 65199200ed58..98a7a7eeb395 100644
--- a/arch/arm/dts/am574x-idk-u-boot.dtsi
+++ b/arch/arm/dts/am574x-idk-u-boot.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 #include "am57xx-idk-common-u-boot.dtsi"
diff --git a/arch/arm/dts/am57xx-beagle-x15-revb1-u-boot.dtsi b/arch/arm/dts/am57xx-beagle-x15-revb1-u-boot.dtsi
index 49b16215e528..2af4e60cda8c 100644
--- a/arch/arm/dts/am57xx-beagle-x15-revb1-u-boot.dtsi
+++ b/arch/arm/dts/am57xx-beagle-x15-revb1-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "omap5-u-boot.dtsi"
diff --git a/arch/arm/dts/am57xx-beagle-x15-revc-u-boot.dtsi b/arch/arm/dts/am57xx-beagle-x15-revc-u-boot.dtsi
index 49b16215e528..2af4e60cda8c 100644
--- a/arch/arm/dts/am57xx-beagle-x15-revc-u-boot.dtsi
+++ b/arch/arm/dts/am57xx-beagle-x15-revc-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "omap5-u-boot.dtsi"
diff --git a/arch/arm/dts/am57xx-beagle-x15-u-boot.dtsi b/arch/arm/dts/am57xx-beagle-x15-u-boot.dtsi
index 49b16215e528..2af4e60cda8c 100644
--- a/arch/arm/dts/am57xx-beagle-x15-u-boot.dtsi
+++ b/arch/arm/dts/am57xx-beagle-x15-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "omap5-u-boot.dtsi"
diff --git a/arch/arm/dts/am57xx-cl-som-am57x-u-boot.dtsi b/arch/arm/dts/am57xx-cl-som-am57x-u-boot.dtsi
index 49b16215e528..2af4e60cda8c 100644
--- a/arch/arm/dts/am57xx-cl-som-am57x-u-boot.dtsi
+++ b/arch/arm/dts/am57xx-cl-som-am57x-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "omap5-u-boot.dtsi"
diff --git a/arch/arm/dts/am57xx-idk-common-u-boot.dtsi b/arch/arm/dts/am57xx-idk-common-u-boot.dtsi
index b07aea0048d5..31faec4afe65 100644
--- a/arch/arm/dts/am57xx-idk-common-u-boot.dtsi
+++ b/arch/arm/dts/am57xx-idk-common-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 #include "omap5-u-boot.dtsi"
 
diff --git a/arch/arm/dts/am57xx-sbc-am57x-u-boot.dtsi b/arch/arm/dts/am57xx-sbc-am57x-u-boot.dtsi
index 49b16215e528..2af4e60cda8c 100644
--- a/arch/arm/dts/am57xx-sbc-am57x-u-boot.dtsi
+++ b/arch/arm/dts/am57xx-sbc-am57x-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "omap5-u-boot.dtsi"
diff --git a/arch/arm/dts/da850-lcdk-u-boot.dtsi b/arch/arm/dts/da850-lcdk-u-boot.dtsi
index bbaebcb67a0a..9ab48bca0885 100644
--- a/arch/arm/dts/da850-lcdk-u-boot.dtsi
+++ b/arch/arm/dts/da850-lcdk-u-boot.dtsi
@@ -2,7 +2,7 @@
 /*
  * da850-lcdk U-Boot Additions
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 / {
diff --git a/arch/arm/dts/dra7-evm-u-boot.dtsi b/arch/arm/dts/dra7-evm-u-boot.dtsi
index 87b2451a8e8b..3fe1fb4552df 100644
--- a/arch/arm/dts/dra7-evm-u-boot.dtsi
+++ b/arch/arm/dts/dra7-evm-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "omap5-u-boot.dtsi"
diff --git a/arch/arm/dts/dra7-ipu-common-early-boot.dtsi b/arch/arm/dts/dra7-ipu-common-early-boot.dtsi
index 90fc4cb36d56..afa4595195b9 100644
--- a/arch/arm/dts/dra7-ipu-common-early-boot.dtsi
+++ b/arch/arm/dts/dra7-ipu-common-early-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 / {
diff --git a/arch/arm/dts/dra71-evm-u-boot.dtsi b/arch/arm/dts/dra71-evm-u-boot.dtsi
index 8e7dc719bf85..339b05f54a08 100644
--- a/arch/arm/dts/dra71-evm-u-boot.dtsi
+++ b/arch/arm/dts/dra71-evm-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "omap5-u-boot.dtsi"
diff --git a/arch/arm/dts/dra72-evm-revc-u-boot.dtsi b/arch/arm/dts/dra72-evm-revc-u-boot.dtsi
index 8e7dc719bf85..339b05f54a08 100644
--- a/arch/arm/dts/dra72-evm-revc-u-boot.dtsi
+++ b/arch/arm/dts/dra72-evm-revc-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "omap5-u-boot.dtsi"
diff --git a/arch/arm/dts/dra72-evm-u-boot.dtsi b/arch/arm/dts/dra72-evm-u-boot.dtsi
index 91a3b6b742a0..dfdd5c57ad11 100644
--- a/arch/arm/dts/dra72-evm-u-boot.dtsi
+++ b/arch/arm/dts/dra72-evm-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "omap5-u-boot.dtsi"
diff --git a/arch/arm/dts/dra76-evm-u-boot.dtsi b/arch/arm/dts/dra76-evm-u-boot.dtsi
index 1216d93bdcd6..c8da3e483898 100644
--- a/arch/arm/dts/dra76-evm-u-boot.dtsi
+++ b/arch/arm/dts/dra76-evm-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "omap5-u-boot.dtsi"
diff --git a/arch/arm/dts/k3-am654-base-board-ddr4-1600MTs.dtsi b/arch/arm/dts/k3-am654-base-board-ddr4-1600MTs.dtsi
index 5638321903a7..cfea21b3c9dd 100644
--- a/arch/arm/dts/k3-am654-base-board-ddr4-1600MTs.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-ddr4-1600MTs.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
  * This file was generated by AM65x_DRA80xM_EMIF_Tool_2.02.xlsm
- * http://www.ti.com/lit/pdf/spracj0
+ * https://www.ti.com/lit/pdf/spracj0
  * Configuration Parameters
  * Memory Type: DDR4
  * Data Rate: 1600 MT/s
diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index e4cbc47c2a70..11d83927ac52 100644
--- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2018-2021 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018-2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "k3-am654-r5-base-board-u-boot.dtsi"
diff --git a/arch/arm/dts/k3-am654-ddr.dtsi b/arch/arm/dts/k3-am654-ddr.dtsi
index 48698cdddc7e..9f0586ed1a4c 100644
--- a/arch/arm/dts/k3-am654-ddr.dtsi
+++ b/arch/arm/dts/k3-am654-ddr.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 / {
diff --git a/arch/arm/dts/k3-am654-r5-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-r5-base-board-u-boot.dtsi
index 949320c91d03..286604576e02 100644
--- a/arch/arm/dts/k3-am654-r5-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-r5-base-board-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2018-2021 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018-2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/pinctrl/k3.h>
diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 7671875a55c7..637a5cc85e09 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm/dts/k3-j7200-ddr-evm-lp4-2666.dtsi b/arch/arm/dts/k3-j7200-ddr-evm-lp4-2666.dtsi
index 9ec8dff44be8..f0683088cf6a 100644
--- a/arch/arm/dts/k3-j7200-ddr-evm-lp4-2666.dtsi
+++ b/arch/arm/dts/k3-j7200-ddr-evm-lp4-2666.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  * This file was generated by the Jacinto7_DDRSS_RegConfigTool, Revision: 0.6.0
  * This file was generated on 06/01/2021
 */
diff --git a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
index cd95907b981b..b77f8d92de39 100644
--- a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "k3-j721e-binman.dtsi"
diff --git a/arch/arm/dts/k3-j721e-ddr-evm-lp4-4266.dtsi b/arch/arm/dts/k3-j721e-ddr-evm-lp4-4266.dtsi
index 5a6f9b11b8e3..66e15811519a 100644
--- a/arch/arm/dts/k3-j721e-ddr-evm-lp4-4266.dtsi
+++ b/arch/arm/dts/k3-j721e-ddr-evm-lp4-4266.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  * This file was generated by the Jacinto7_DDRSS_RegConfigTool, Revision: 0.9.1
  * This file was generated on 07/17/2022
 */
diff --git a/arch/arm/dts/k3-j721e-ddr-sk-lp4-4266.dtsi b/arch/arm/dts/k3-j721e-ddr-sk-lp4-4266.dtsi
index 6c7328e8db0b..18f1944474ba 100644
--- a/arch/arm/dts/k3-j721e-ddr-sk-lp4-4266.dtsi
+++ b/arch/arm/dts/k3-j721e-ddr-sk-lp4-4266.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  * This file was generated by the Jacinto7_DDRSS_RegConfigTool, Revision: 0.6.1
  * This file was generated on 07/19/2021
 */
diff --git a/arch/arm/dts/k3-j721e-ddr.dtsi b/arch/arm/dts/k3-j721e-ddr.dtsi
index 3a9ea42fe545..7d2ccd9547cb 100644
--- a/arch/arm/dts/k3-j721e-ddr.dtsi
+++ b/arch/arm/dts/k3-j721e-ddr.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
 */
 
 / {
diff --git a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
index fcd9c716a505..9655ca21d02b 100644
--- a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm/dts/keystone-clocks.dtsi b/arch/arm/dts/keystone-clocks.dtsi
index 457515b0736a..33742d819717 100644
--- a/arch/arm/dts/keystone-clocks.dtsi
+++ b/arch/arm/dts/keystone-clocks.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for Keystone 2 clock tree
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 clocks {
diff --git a/arch/arm/dts/keystone-k2e-clocks.dtsi b/arch/arm/dts/keystone-k2e-clocks.dtsi
index f7592155a740..46f8ab3a11db 100644
--- a/arch/arm/dts/keystone-k2e-clocks.dtsi
+++ b/arch/arm/dts/keystone-k2e-clocks.dtsi
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Edison SoC specific device tree
  *
- * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2014-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 clocks {
diff --git a/arch/arm/dts/keystone-k2e-evm-u-boot.dtsi b/arch/arm/dts/keystone-k2e-evm-u-boot.dtsi
index 970d452f0804..953c7502260c 100644
--- a/arch/arm/dts/keystone-k2e-evm-u-boot.dtsi
+++ b/arch/arm/dts/keystone-k2e-evm-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /{
diff --git a/arch/arm/dts/keystone-k2e-evm.dts b/arch/arm/dts/keystone-k2e-evm.dts
index ed76e56369fc..bf8844426179 100644
--- a/arch/arm/dts/keystone-k2e-evm.dts
+++ b/arch/arm/dts/keystone-k2e-evm.dts
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Edison EVM device tree
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 /dts-v1/;
 
diff --git a/arch/arm/dts/keystone-k2e-netcp.dtsi b/arch/arm/dts/keystone-k2e-netcp.dtsi
index 45ebb0ac4f56..dd61503db39d 100644
--- a/arch/arm/dts/keystone-k2e-netcp.dtsi
+++ b/arch/arm/dts/keystone-k2e-netcp.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for Keystone 2 Edison Netcp driver
  *
- * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 qmss: qmss@2a40000 {
diff --git a/arch/arm/dts/keystone-k2e.dtsi b/arch/arm/dts/keystone-k2e.dtsi
index 496bb310c7d8..449cddcb8149 100644
--- a/arch/arm/dts/keystone-k2e.dtsi
+++ b/arch/arm/dts/keystone-k2e.dtsi
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Edison soc device tree
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 / {
diff --git a/arch/arm/dts/keystone-k2g-evm-u-boot.dtsi b/arch/arm/dts/keystone-k2g-evm-u-boot.dtsi
index 05653afc7e93..72b67b232ddb 100644
--- a/arch/arm/dts/keystone-k2g-evm-u-boot.dtsi
+++ b/arch/arm/dts/keystone-k2g-evm-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /{
diff --git a/arch/arm/dts/keystone-k2g-evm.dts b/arch/arm/dts/keystone-k2g-evm.dts
index 6376c62b6d0b..491fdc4b046d 100644
--- a/arch/arm/dts/keystone-k2g-evm.dts
+++ b/arch/arm/dts/keystone-k2g-evm.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for K2G EVM
  *
- * Copyright (C) 2016-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2016-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 /dts-v1/;
 
diff --git a/arch/arm/dts/keystone-k2g-generic-u-boot.dtsi b/arch/arm/dts/keystone-k2g-generic-u-boot.dtsi
index 8e4b36c2de31..3634ed7268c9 100644
--- a/arch/arm/dts/keystone-k2g-generic-u-boot.dtsi
+++ b/arch/arm/dts/keystone-k2g-generic-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /{
diff --git a/arch/arm/dts/keystone-k2g-generic.dts b/arch/arm/dts/keystone-k2g-generic.dts
index fc938a4baa89..dc6c31a31b48 100644
--- a/arch/arm/dts/keystone-k2g-generic.dts
+++ b/arch/arm/dts/keystone-k2g-generic.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for Generic 66AK2G0X EVM
  *
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm/dts/keystone-k2g-ice-u-boot.dtsi b/arch/arm/dts/keystone-k2g-ice-u-boot.dtsi
index 8e4b36c2de31..3634ed7268c9 100644
--- a/arch/arm/dts/keystone-k2g-ice-u-boot.dtsi
+++ b/arch/arm/dts/keystone-k2g-ice-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /{
diff --git a/arch/arm/dts/keystone-k2g-ice.dts b/arch/arm/dts/keystone-k2g-ice.dts
index cbdb6bfca8c8..b898ae668a94 100644
--- a/arch/arm/dts/keystone-k2g-ice.dts
+++ b/arch/arm/dts/keystone-k2g-ice.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for K2G Industrial Communication Engine EVM
  *
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 /dts-v1/;
 
diff --git a/arch/arm/dts/keystone-k2g-netcp.dtsi b/arch/arm/dts/keystone-k2g-netcp.dtsi
index 136cd20b76ea..2afb48823c1a 100644
--- a/arch/arm/dts/keystone-k2g-netcp.dtsi
+++ b/arch/arm/dts/keystone-k2g-netcp.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for K2G Netcp driver
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 qmss: qmss@4020000 {
diff --git a/arch/arm/dts/keystone-k2g.dtsi b/arch/arm/dts/keystone-k2g.dtsi
index f12af433bb10..5c3ff1272182 100644
--- a/arch/arm/dts/keystone-k2g.dtsi
+++ b/arch/arm/dts/keystone-k2g.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for K2G SOC
  *
- * Copyright (C) 2016-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2016-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/arch/arm/dts/keystone-k2hk-clocks.dtsi b/arch/arm/dts/keystone-k2hk-clocks.dtsi
index 4ba6912176ef..3ca4722087c9 100644
--- a/arch/arm/dts/keystone-k2hk-clocks.dtsi
+++ b/arch/arm/dts/keystone-k2hk-clocks.dtsi
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Kepler/Hawking SoC clock nodes
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 clocks {
diff --git a/arch/arm/dts/keystone-k2hk-evm-u-boot.dtsi b/arch/arm/dts/keystone-k2hk-evm-u-boot.dtsi
index 22df84ba93be..3e38f228a6a3 100644
--- a/arch/arm/dts/keystone-k2hk-evm-u-boot.dtsi
+++ b/arch/arm/dts/keystone-k2hk-evm-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /{
diff --git a/arch/arm/dts/keystone-k2hk-evm.dts b/arch/arm/dts/keystone-k2hk-evm.dts
index ea53f3f6b868..6222876f2778 100644
--- a/arch/arm/dts/keystone-k2hk-evm.dts
+++ b/arch/arm/dts/keystone-k2hk-evm.dts
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Kepler/Hawking EVM device tree
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 /dts-v1/;
 
diff --git a/arch/arm/dts/keystone-k2hk-netcp.dtsi b/arch/arm/dts/keystone-k2hk-netcp.dtsi
index 580af633df1a..3f8c4c263a24 100644
--- a/arch/arm/dts/keystone-k2hk-netcp.dtsi
+++ b/arch/arm/dts/keystone-k2hk-netcp.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for Keystone 2 Hawking Netcp driver
  *
- * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 qmss: qmss@2a40000 {
diff --git a/arch/arm/dts/keystone-k2hk.dtsi b/arch/arm/dts/keystone-k2hk.dtsi
index ef02f23c3208..e5ab1fbb5595 100644
--- a/arch/arm/dts/keystone-k2hk.dtsi
+++ b/arch/arm/dts/keystone-k2hk.dtsi
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Kepler/Hawking soc specific device tree
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 / {
diff --git a/arch/arm/dts/keystone-k2l-clocks.dtsi b/arch/arm/dts/keystone-k2l-clocks.dtsi
index 635528064dea..fcfc2fb6cc2d 100644
--- a/arch/arm/dts/keystone-k2l-clocks.dtsi
+++ b/arch/arm/dts/keystone-k2l-clocks.dtsi
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 lamarr SoC clock nodes
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 clocks {
diff --git a/arch/arm/dts/keystone-k2l-evm-u-boot.dtsi b/arch/arm/dts/keystone-k2l-evm-u-boot.dtsi
index 0a507d0210b8..f1aed14b0b50 100644
--- a/arch/arm/dts/keystone-k2l-evm-u-boot.dtsi
+++ b/arch/arm/dts/keystone-k2l-evm-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 &usb_phy {
diff --git a/arch/arm/dts/keystone-k2l-evm.dts b/arch/arm/dts/keystone-k2l-evm.dts
index 187f2caa6d3b..9d2b4542e815 100644
--- a/arch/arm/dts/keystone-k2l-evm.dts
+++ b/arch/arm/dts/keystone-k2l-evm.dts
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Lamarr EVM device tree
  *
- * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2014-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 /dts-v1/;
 
diff --git a/arch/arm/dts/keystone-k2l-netcp.dtsi b/arch/arm/dts/keystone-k2l-netcp.dtsi
index 54c112881913..2caa0583fc8f 100644
--- a/arch/arm/dts/keystone-k2l-netcp.dtsi
+++ b/arch/arm/dts/keystone-k2l-netcp.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for Keystone 2 Lamarr Netcp driver
  *
- * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 qmss: qmss@2a40000 {
diff --git a/arch/arm/dts/keystone-k2l.dtsi b/arch/arm/dts/keystone-k2l.dtsi
index dcc83a7ee447..c8893e284f22 100644
--- a/arch/arm/dts/keystone-k2l.dtsi
+++ b/arch/arm/dts/keystone-k2l.dtsi
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Lamarr SoC specific device tree
  *
- * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2014-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 / {
diff --git a/arch/arm/dts/keystone.dtsi b/arch/arm/dts/keystone.dtsi
index 2afcab76d220..1538ccef81ae 100644
--- a/arch/arm/dts/keystone.dtsi
+++ b/arch/arm/dts/keystone.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/arch/arm/dts/omap3-u-boot.dtsi b/arch/arm/dts/omap3-u-boot.dtsi
index 7366ff56932e..bc2793757b70 100644
--- a/arch/arm/dts/omap3-u-boot.dtsi
+++ b/arch/arm/dts/omap3-u-boot.dtsi
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/dts/omap5-u-boot.dtsi b/arch/arm/dts/omap5-u-boot.dtsi
index 720e79b3a558..d1de2e7c85f5 100644
--- a/arch/arm/dts/omap5-u-boot.dtsi
+++ b/arch/arm/dts/omap5-u-boot.dtsi
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/dts/tps6507x.dtsi b/arch/arm/dts/tps6507x.dtsi
index db4809d308f9..6749d3f3d585 100644
--- a/arch/arm/dts/tps6507x.dtsi
+++ b/arch/arm/dts/tps6507x.dtsi
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /*
  * Integrated Power Management Chip
- * http://www.ti.com/lit/ds/symlink/tps65070.pdf
+ * https://www.ti.com/lit/ds/symlink/tps65070.pdf
  */
 
 &tps {
diff --git a/arch/arm/dts/tps65217.dtsi b/arch/arm/dts/tps65217.dtsi
index 0d463de5650f..262e0bb3eaac 100644
--- a/arch/arm/dts/tps65217.dtsi
+++ b/arch/arm/dts/tps65217.dtsi
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /*
  * Integrated Power Management Chip
- * http://www.ti.com/lit/ds/symlink/tps65217.pdf
+ * https://www.ti.com/lit/ds/symlink/tps65217.pdf
  */
 
 &tps {
diff --git a/arch/arm/dts/tps65910.dtsi b/arch/arm/dts/tps65910.dtsi
index a941d1e62328..ab3a4ffd1298 100644
--- a/arch/arm/dts/tps65910.dtsi
+++ b/arch/arm/dts/tps65910.dtsi
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /*
  * Integrated Power Management Chip
- * http://www.ti.com/lit/ds/symlink/tps65910.pdf
+ * https://www.ti.com/lit/ds/symlink/tps65910.pdf
  */
 
 &tps {
diff --git a/arch/arm/dts/twl4030.dtsi b/arch/arm/dts/twl4030.dtsi
index 6cb0a01e77e3..f87cea1ac4ba 100644
--- a/arch/arm/dts/twl4030.dtsi
+++ b/arch/arm/dts/twl4030.dtsi
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/dts/twl6030.dtsi b/arch/arm/dts/twl6030.dtsi
index 9d588cfaa5cb..8da969035c41 100644
--- a/arch/arm/dts/twl6030.dtsi
+++ b/arch/arm/dts/twl6030.dtsi
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /*
  * Integrated Power Management Chip
- * http://www.ti.com/lit/ds/symlink/twl6030.pdf
+ * https://www.ti.com/lit/ds/symlink/twl6030.pdf
  */
 &twl {
 	compatible = "ti,twl6030";
diff --git a/arch/arm/dts/twl6030_omap4.dtsi b/arch/arm/dts/twl6030_omap4.dtsi
index fc498d0bde8b..5730e46b0067 100644
--- a/arch/arm/dts/twl6030_omap4.dtsi
+++ b/arch/arm/dts/twl6030_omap4.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 &twl {
diff --git a/arch/arm/include/asm/arch-am33xx/clk_synthesizer.h b/arch/arm/include/asm/arch-am33xx/clk_synthesizer.h
index 7bcafba6f0b5..8e3d55f3e763 100644
--- a/arch/arm/include/asm/arch-am33xx/clk_synthesizer.h
+++ b/arch/arm/include/asm/arch-am33xx/clk_synthesizer.h
@@ -4,7 +4,7 @@
  *
  * Clock synthesizer header
  *
- * Copyright (C) 2016, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2016, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #ifndef __CLK_SYNTHESIZER_H
diff --git a/arch/arm/include/asm/arch-am33xx/clock.h b/arch/arm/include/asm/arch-am33xx/clock.h
index 67400c2c63a3..13960db2fbd1 100644
--- a/arch/arm/include/asm/arch-am33xx/clock.h
+++ b/arch/arm/include/asm/arch-am33xx/clock.h
@@ -4,7 +4,7 @@
  *
  * clock header
  *
- * Copyright (C) 2011, Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef _CLOCKS_H_
diff --git a/arch/arm/include/asm/arch-am33xx/clocks_am33xx.h b/arch/arm/include/asm/arch-am33xx/clocks_am33xx.h
index e5ad50754e73..adb574e8f133 100644
--- a/arch/arm/include/asm/arch-am33xx/clocks_am33xx.h
+++ b/arch/arm/include/asm/arch-am33xx/clocks_am33xx.h
@@ -4,7 +4,7 @@
  *
  * AM33xx clock define
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef _CLOCKS_AM33XX_H_
diff --git a/arch/arm/include/asm/arch-am33xx/cpu.h b/arch/arm/include/asm/arch-am33xx/cpu.h
index b33e6f7fd1bd..8ec25854f3fe 100644
--- a/arch/arm/include/asm/arch-am33xx/cpu.h
+++ b/arch/arm/include/asm/arch-am33xx/cpu.h
@@ -4,7 +4,7 @@
  *
  * AM33xx specific header file
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #ifndef _AM33XX_CPU_H
diff --git a/arch/arm/include/asm/arch-am33xx/ddr_defs.h b/arch/arm/include/asm/arch-am33xx/ddr_defs.h
index 1a0310710732..6e7a62bc2275 100644
--- a/arch/arm/include/asm/arch-am33xx/ddr_defs.h
+++ b/arch/arm/include/asm/arch-am33xx/ddr_defs.h
@@ -4,7 +4,7 @@
  *
  * ddr specific header
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #ifndef _DDR_DEFS_H
diff --git a/arch/arm/include/asm/arch-am33xx/hardware.h b/arch/arm/include/asm/arch-am33xx/hardware.h
index 387f053ce68c..33ee915098fe 100644
--- a/arch/arm/include/asm/arch-am33xx/hardware.h
+++ b/arch/arm/include/asm/arch-am33xx/hardware.h
@@ -4,7 +4,7 @@
  *
  * hardware specific header
  *
- * Copyright (C) 2013, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2013, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #ifndef __AM33XX_HARDWARE_H
diff --git a/arch/arm/include/asm/arch-am33xx/hardware_am33xx.h b/arch/arm/include/asm/arch-am33xx/hardware_am33xx.h
index 878ef3e5d229..de597c2775fb 100644
--- a/arch/arm/include/asm/arch-am33xx/hardware_am33xx.h
+++ b/arch/arm/include/asm/arch-am33xx/hardware_am33xx.h
@@ -4,7 +4,7 @@
  *
  * AM33xx hardware specific header
  *
- * Copyright (C) 2013, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2013, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #ifndef __AM33XX_HARDWARE_AM33XX_H
diff --git a/arch/arm/include/asm/arch-am33xx/hardware_am43xx.h b/arch/arm/include/asm/arch-am33xx/hardware_am43xx.h
index 0b73ebdbb4da..8786d8c923ec 100644
--- a/arch/arm/include/asm/arch-am33xx/hardware_am43xx.h
+++ b/arch/arm/include/asm/arch-am33xx/hardware_am43xx.h
@@ -4,7 +4,7 @@
  *
  * AM43xx hardware specific header
  *
- * Copyright (C) 2013, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2013, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #ifndef __AM43XX_HARDWARE_AM43XX_H
diff --git a/arch/arm/include/asm/arch-am33xx/mmc_host_def.h b/arch/arm/include/asm/arch-am33xx/mmc_host_def.h
index b1b189631af2..ed60abf2e71d 100644
--- a/arch/arm/include/asm/arch-am33xx/mmc_host_def.h
+++ b/arch/arm/include/asm/arch-am33xx/mmc_host_def.h
@@ -1,7 +1,7 @@
 /*
  * mmc_host_def.h
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
diff --git a/arch/arm/include/asm/arch-am33xx/mux.h b/arch/arm/include/asm/arch-am33xx/mux.h
index ebb2d303dfed..f704afaca12b 100644
--- a/arch/arm/include/asm/arch-am33xx/mux.h
+++ b/arch/arm/include/asm/arch-am33xx/mux.h
@@ -1,7 +1,7 @@
 /*
  * mux.h
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
diff --git a/arch/arm/include/asm/arch-am33xx/mux_am33xx.h b/arch/arm/include/asm/arch-am33xx/mux_am33xx.h
index 26bd4b46ffbe..c702e4adc410 100644
--- a/arch/arm/include/asm/arch-am33xx/mux_am33xx.h
+++ b/arch/arm/include/asm/arch-am33xx/mux_am33xx.h
@@ -1,7 +1,7 @@
 /*
  * mux_am33xx.h
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
diff --git a/arch/arm/include/asm/arch-am33xx/mux_am43xx.h b/arch/arm/include/asm/arch-am33xx/mux_am43xx.h
index f74ae74ff163..24f0041c94b3 100644
--- a/arch/arm/include/asm/arch-am33xx/mux_am43xx.h
+++ b/arch/arm/include/asm/arch-am33xx/mux_am43xx.h
@@ -2,7 +2,7 @@
 /*
  * mux_am43xx.h
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef _MUX_AM43XX_H_
diff --git a/arch/arm/include/asm/arch-am33xx/omap.h b/arch/arm/include/asm/arch-am33xx/omap.h
index 53046deed565..71a84fef35e7 100644
--- a/arch/arm/include/asm/arch-am33xx/omap.h
+++ b/arch/arm/include/asm/arch-am33xx/omap.h
@@ -2,7 +2,7 @@
 /*
  * omap.h
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  *
  * Author:
  *	Chandan Nath <chandan.nath@ti.com>
diff --git a/arch/arm/include/asm/arch-am33xx/sys_proto.h b/arch/arm/include/asm/arch-am33xx/sys_proto.h
index be17aad29ee6..513cdaca8593 100644
--- a/arch/arm/include/asm/arch-am33xx/sys_proto.h
+++ b/arch/arm/include/asm/arch-am33xx/sys_proto.h
@@ -4,7 +4,7 @@
  *
  * System information header
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #ifndef _SYS_PROTO_H_
diff --git a/arch/arm/include/asm/arch-omap3/emif4.h b/arch/arm/include/asm/arch-omap3/emif4.h
index bac43b231f8f..397bb47edfbb 100644
--- a/arch/arm/include/asm/arch-omap3/emif4.h
+++ b/arch/arm/include/asm/arch-omap3/emif4.h
@@ -4,7 +4,7 @@
  *       Vaibhav Hiremath <hvaibhav@ti.com>
  *
  * Copyright (C) 2010
- * Texas Instruments Incorporated - http://www.ti.com/
+ * Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef _EMIF_H_
diff --git a/arch/arm/include/asm/arch-omap4/ehci.h b/arch/arm/include/asm/arch-omap4/ehci.h
index 30bdaad64e38..e8fe88f2afc4 100644
--- a/arch/arm/include/asm/arch-omap4/ehci.h
+++ b/arch/arm/include/asm/arch-omap4/ehci.h
@@ -4,7 +4,7 @@
  * Based on LINUX KERNEL
  * drivers/usb/host/ehci-omap.c and drivers/mfd/omap-usb-host.c
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com
  * Author: Govindraj R <govindraj.raja@ti.com>
  */
 
diff --git a/arch/arm/include/asm/arch-omap4/hardware.h b/arch/arm/include/asm/arch-omap4/hardware.h
index 48dc80924929..67e3dae7bcea 100644
--- a/arch/arm/include/asm/arch-omap4/hardware.h
+++ b/arch/arm/include/asm/arch-omap4/hardware.h
@@ -4,7 +4,7 @@
  *
  * hardware specific header
  *
- * Copyright (C) 2013, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2013, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #ifndef __OMAP_HARDWARE_H
diff --git a/arch/arm/include/asm/arch-omap5/ehci.h b/arch/arm/include/asm/arch-omap5/ehci.h
index 1790b92a2456..3c52a76d48b1 100644
--- a/arch/arm/include/asm/arch-omap5/ehci.h
+++ b/arch/arm/include/asm/arch-omap5/ehci.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com*
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com*
  * Author: Govindraj R <govindraj.raja@ti.com>
  */
 
diff --git a/arch/arm/include/asm/arch-omap5/hardware.h b/arch/arm/include/asm/arch-omap5/hardware.h
index b6d26e9f0e5a..c948c0ef114a 100644
--- a/arch/arm/include/asm/arch-omap5/hardware.h
+++ b/arch/arm/include/asm/arch-omap5/hardware.h
@@ -4,7 +4,7 @@
  *
  * hardware specific header
  *
- * Copyright (C) 2013, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2013, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #ifndef __OMAP_HARDWARE_H
diff --git a/arch/arm/include/asm/ehci-omap.h b/arch/arm/include/asm/ehci-omap.h
index 2b51b5eb9975..662b62cbb28c 100644
--- a/arch/arm/include/asm/ehci-omap.h
+++ b/arch/arm/include/asm/ehci-omap.h
@@ -4,7 +4,7 @@
  * Based on LINUX KERNEL
  * drivers/usb/host/ehci-omap.c and drivers/mfd/omap-usb-host.c
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com*
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com*
  * Author: Govindraj R <govindraj.raja@ti.com>
  */
 
diff --git a/arch/arm/include/asm/ti-common/omap_wdt.h b/arch/arm/include/asm/ti-common/omap_wdt.h
index 42d7e4c989e2..855f88922576 100644
--- a/arch/arm/include/asm/ti-common/omap_wdt.h
+++ b/arch/arm/include/asm/ti-common/omap_wdt.h
@@ -4,7 +4,7 @@
  *
  * OMAP Watchdog header file
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #ifndef __OMAP_WDT_H__
diff --git a/arch/arm/mach-davinci/config.mk b/arch/arm/mach-davinci/config.mk
index 4674cae43b1d..edbac8e8e21c 100644
--- a/arch/arm/mach-davinci/config.mk
+++ b/arch/arm/mach-davinci/config.mk
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright (C) 2012, Texas Instruments, Incorporated - http://www.ti.com/
+# Copyright (C) 2012, Texas Instruments, Incorporated - https://www.ti.com/
 ifndef CONFIG_SPL_BUILD
 INPUTS-$(CONFIG_SPL_FRAMEWORK)	+= u-boot.ais
 endif
diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index fd77b8bbba5c..c7ca0fdce562 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier:	GPL-2.0+
 #
-# Copyright (C) 2017-2018 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2017-2018 Texas Instruments Incorporated - https://www.ti.com/
 #	Lokesh Vutla <lokeshvutla@ti.com>
 
 obj-$(CONFIG_SOC_K3_J721E) += j721e/ j7200/
diff --git a/arch/arm/mach-k3/am654_init.c b/arch/arm/mach-k3/am654_init.c
index 0d3889cde2ba..9353a475a492 100644
--- a/arch/arm/mach-k3/am654_init.c
+++ b/arch/arm/mach-k3/am654_init.c
@@ -2,7 +2,7 @@
 /*
  * AM6: SoC specific initialization
  *
- * Copyright (C) 2017-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017-2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/arch/arm/mach-k3/cache.S b/arch/arm/mach-k3/cache.S
index a5717ea203ab..17cfb12f108d 100644
--- a/arch/arm/mach-k3/cache.S
+++ b/arch/arm/mach-k3/cache.S
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
  *	Andrew F. Davis <afd@ti.com>
  */
 
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index c3006ba387ec..d8974d6c388e 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -2,7 +2,7 @@
 /*
  * K3: Common Architecture initialization
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index eabb44f6204f..04f3c0b85bd1 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -2,7 +2,7 @@
 /*
  * K3: Architecture common definitions
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/arch/arm/mach-k3/include/mach/am6_hardware.h b/arch/arm/mach-k3/include/mach/am6_hardware.h
index 029041f415cf..9913964c46bd 100644
--- a/arch/arm/mach-k3/include/mach/am6_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am6_hardware.h
@@ -2,7 +2,7 @@
 /*
  * K3: AM6 SoC definitions, structures etc.
  *
- * (C) Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * (C) Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 #ifndef __ASM_ARCH_AM6_HARDWARE_H
 #define __ASM_ARCH_AM6_HARDWARE_H
diff --git a/arch/arm/mach-k3/include/mach/am6_spl.h b/arch/arm/mach-k3/include/mach/am6_spl.h
index 61e038092763..4c6950ff2b78 100644
--- a/arch/arm/mach-k3/include/mach/am6_spl.h
+++ b/arch/arm/mach-k3/include/mach/am6_spl.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 #ifndef _ASM_ARCH_AM6_SPL_H_
diff --git a/arch/arm/mach-k3/include/mach/clock.h b/arch/arm/mach-k3/include/mach/clock.h
index e3adbcd9dedc..32368ce0ede3 100644
--- a/arch/arm/mach-k3/include/mach/clock.h
+++ b/arch/arm/mach-k3/include/mach/clock.h
@@ -2,7 +2,7 @@
 /*
  * K3: Common SoC clock definitions.
  *
- * (C) Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * (C) Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 #ifndef __ASM_ARCH_CLOCK_H
 #define __ASM_ARCH_CLOCK_H
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 65742c4b7c8c..a1a9dfbde66c 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 #ifndef _ASM_ARCH_HARDWARE_H_
diff --git a/arch/arm/mach-k3/include/mach/j721e_hardware.h b/arch/arm/mach-k3/include/mach/j721e_hardware.h
index 376db389ba19..780341124a8f 100644
--- a/arch/arm/mach-k3/include/mach/j721e_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j721e_hardware.h
@@ -2,7 +2,7 @@
 /*
  * K3: J721E SoC definitions, structures etc.
  *
- * (C) Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+ * (C) Copyright (C) 2018-2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 #ifndef __ASM_ARCH_J721E_HARDWARE_H
 #define __ASM_ARCH_J721E_HARDWARE_H
diff --git a/arch/arm/mach-k3/include/mach/j721e_spl.h b/arch/arm/mach-k3/include/mach/j721e_spl.h
index e8947917a6b7..ed3d7333bd4f 100644
--- a/arch/arm/mach-k3/include/mach/j721e_spl.h
+++ b/arch/arm/mach-k3/include/mach/j721e_spl.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018-2019 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 #ifndef _ASM_ARCH_J721E_SPL_H_
diff --git a/arch/arm/mach-k3/include/mach/j721s2_hardware.h b/arch/arm/mach-k3/include/mach/j721s2_hardware.h
index 7948bcf4789b..ad4fcdd4a97f 100644
--- a/arch/arm/mach-k3/include/mach/j721s2_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j721s2_hardware.h
@@ -2,7 +2,7 @@
 /*
  * K3: J721S2 SoC definitions, structures etc.
  *
- * (C) Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
+ * (C) Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 #ifndef __ASM_ARCH_J721S2_HARDWARE_H
 #define __ASM_ARCH_J721S2_HARDWARE_H
diff --git a/arch/arm/mach-k3/include/mach/j721s2_spl.h b/arch/arm/mach-k3/include/mach/j721s2_spl.h
index 94b6c1337f73..d8fae2c8b45e 100644
--- a/arch/arm/mach-k3/include/mach/j721s2_spl.h
+++ b/arch/arm/mach-k3/include/mach/j721s2_spl.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
  *	David Huang <d-huang@ti.com>
  */
 #ifndef _ASM_ARCH_J721S2_SPL_H_
diff --git a/arch/arm/mach-k3/include/mach/spl.h b/arch/arm/mach-k3/include/mach/spl.h
index 356cd8921096..3ddc7eb6b63c 100644
--- a/arch/arm/mach-k3/include/mach/spl.h
+++ b/arch/arm/mach-k3/include/mach/spl.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 #ifndef _ASM_ARCH_SPL_H_
diff --git a/arch/arm/mach-k3/j7200/Makefile b/arch/arm/mach-k3/j7200/Makefile
index ff9abd78ea6d..0f91cf4daea4 100644
--- a/arch/arm/mach-k3/j7200/Makefile
+++ b/arch/arm/mach-k3/j7200/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier:	GPL-2.0+
 #
-# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
 obj-y += clk-data.o
 obj-y += dev-data.o
diff --git a/arch/arm/mach-k3/j721e/Makefile b/arch/arm/mach-k3/j721e/Makefile
index ff9abd78ea6d..0f91cf4daea4 100644
--- a/arch/arm/mach-k3/j721e/Makefile
+++ b/arch/arm/mach-k3/j721e/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier:	GPL-2.0+
 #
-# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
 obj-y += clk-data.o
 obj-y += dev-data.o
diff --git a/arch/arm/mach-k3/j721e_init.c b/arch/arm/mach-k3/j721e_init.c
index b1f7e25ed092..18814c39ec38 100644
--- a/arch/arm/mach-k3/j721e_init.c
+++ b/arch/arm/mach-k3/j721e_init.c
@@ -2,7 +2,7 @@
 /*
  * J721E: SoC specific initialization
  *
- * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018-2019 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/arch/arm/mach-k3/j721s2/Makefile b/arch/arm/mach-k3/j721s2/Makefile
index 7bcd4901cd9d..e794bffb3afa 100644
--- a/arch/arm/mach-k3/j721s2/Makefile
+++ b/arch/arm/mach-k3/j721s2/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier:	GPL-2.0+
 #
-# Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
 obj-y += clk-data.o
 obj-y += dev-data.o
diff --git a/arch/arm/mach-k3/j721s2_init.c b/arch/arm/mach-k3/j721s2_init.c
index a5be84b147c0..7170a808c4b7 100644
--- a/arch/arm/mach-k3/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2_init.c
@@ -2,7 +2,7 @@
 /*
  * J721E: SoC specific initialization
  *
- * Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
  *	David Huang <d-huang@ti.com>
  */
 
diff --git a/arch/arm/mach-k3/lowlevel_init.S b/arch/arm/mach-k3/lowlevel_init.S
index 70c5d1cade46..463ab0de1bdd 100644
--- a/arch/arm/mach-k3/lowlevel_init.S
+++ b/arch/arm/mach-k3/lowlevel_init.S
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/arch/arm/mach-k3/r5_mpu.c b/arch/arm/mach-k3/r5_mpu.c
index 2aec96277e6f..605f79315181 100644
--- a/arch/arm/mach-k3/r5_mpu.c
+++ b/arch/arm/mach-k3/r5_mpu.c
@@ -2,7 +2,7 @@
 /*
  * K3: R5 MPU region definitions
  *
- * Copyright (C) 2017-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017-2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/arch/arm/mach-k3/security.c b/arch/arm/mach-k3/security.c
index 89659f479eed..ebc9704a33b4 100644
--- a/arch/arm/mach-k3/security.c
+++ b/arch/arm/mach-k3/security.c
@@ -2,7 +2,7 @@
 /*
  * K3: Security functions
  *
- * Copyright (C) 2018-2022 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018-2022 Texas Instruments Incorporated - https://www.ti.com/
  *	Andrew F. Davis <afd@ti.com>
  */
 
diff --git a/arch/arm/mach-k3/sysfw-loader.c b/arch/arm/mach-k3/sysfw-loader.c
index ef245fef9c4b..73a17276e128 100644
--- a/arch/arm/mach-k3/sysfw-loader.c
+++ b/arch/arm/mach-k3/sysfw-loader.c
@@ -2,7 +2,7 @@
 /*
  * K3: System Firmware Loader
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  *	Andreas Dannenberg <dannenberg@ti.com>
  */
 
diff --git a/arch/arm/mach-k3/sysfw-loader.h b/arch/arm/mach-k3/sysfw-loader.h
index b23a9e821ed9..e48c834227dc 100644
--- a/arch/arm/mach-k3/sysfw-loader.h
+++ b/arch/arm/mach-k3/sysfw-loader.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  *	Andreas Dannenberg <dannenberg@ti.com>
  */
 
diff --git a/arch/arm/mach-keystone/mon.c b/arch/arm/mach-keystone/mon.c
index b863bab19692..e91b0d68f4d6 100644
--- a/arch/arm/mach-keystone/mon.c
+++ b/arch/arm/mach-keystone/mon.c
@@ -2,7 +2,7 @@
 /*
  * K2x: Secure commands file
  *
- * Copyright (C) 2012-2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012-2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <hang.h>
diff --git a/arch/arm/mach-omap2/am33xx/Makefile b/arch/arm/mach-omap2/am33xx/Makefile
index 2aa8013527ec..3f1af7f16338 100644
--- a/arch/arm/mach-omap2/am33xx/Makefile
+++ b/arch/arm/mach-omap2/am33xx/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+# Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
 
 obj-$(CONFIG_AM33XX)	+= clock_am33xx.o
 obj-$(CONFIG_AM43XX)	+= clock_am43xx.o
diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index 06b41297730f..09659da5867d 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -4,7 +4,7 @@
  *
  * Common board functions for AM33XX based boards
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/arch/arm/mach-omap2/am33xx/chilisom.c b/arch/arm/mach-omap2/am33xx/chilisom.c
index 459bac13e058..d4f2abe17a97 100644
--- a/arch/arm/mach-omap2/am33xx/chilisom.c
+++ b/arch/arm/mach-omap2/am33xx/chilisom.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  * Copyright (C) 2017, Grinn - http://grinn-global.com/
  */
 
diff --git a/arch/arm/mach-omap2/am33xx/clk_synthesizer.c b/arch/arm/mach-omap2/am33xx/clk_synthesizer.c
index c9b9502aef62..0969a404bf69 100644
--- a/arch/arm/mach-omap2/am33xx/clk_synthesizer.c
+++ b/arch/arm/mach-omap2/am33xx/clk_synthesizer.c
@@ -4,7 +4,7 @@
  *
  * Clock synthesizer apis
  *
- * Copyright (C) 2016, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2016, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 
diff --git a/arch/arm/mach-omap2/am33xx/clock.c b/arch/arm/mach-omap2/am33xx/clock.c
index 130ee6c6e3e8..3273632c648d 100644
--- a/arch/arm/mach-omap2/am33xx/clock.c
+++ b/arch/arm/mach-omap2/am33xx/clock.c
@@ -5,7 +5,7 @@
  * Clock initialization for AM33XX boards.
  * Derived from OMAP4 boards
  *
- * Copyright (C) 2013, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2013, Texas Instruments, Incorporated - https://www.ti.com/
  */
 #include <common.h>
 #include <hang.h>
diff --git a/arch/arm/mach-omap2/am33xx/clock_am33xx.c b/arch/arm/mach-omap2/am33xx/clock_am33xx.c
index cd3b34bf56bf..d39e7e4fed13 100644
--- a/arch/arm/mach-omap2/am33xx/clock_am33xx.c
+++ b/arch/arm/mach-omap2/am33xx/clock_am33xx.c
@@ -4,7 +4,7 @@
  *
  * clocks for AM33XX based boards
  *
- * Copyright (C) 2013, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2013, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/arch/arm/mach-omap2/am33xx/clock_am43xx.c b/arch/arm/mach-omap2/am33xx/clock_am43xx.c
index b98bb9989c0b..8039bc2fe751 100644
--- a/arch/arm/mach-omap2/am33xx/clock_am43xx.c
+++ b/arch/arm/mach-omap2/am33xx/clock_am43xx.c
@@ -5,7 +5,7 @@
  * clocks for AM43XX based boards
  * Derived from AM33XX based boards
  *
- * Copyright (C) 2013, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2013, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/arch/arm/mach-omap2/am33xx/ddr.c b/arch/arm/mach-omap2/am33xx/ddr.c
index 5f970d93f0ac..61b95c937338 100644
--- a/arch/arm/mach-omap2/am33xx/ddr.c
+++ b/arch/arm/mach-omap2/am33xx/ddr.c
@@ -2,7 +2,7 @@
 /*
  * DDR Configuration for AM33xx devices.
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/arch/arm/mach-omap2/am33xx/emif4.c b/arch/arm/mach-omap2/am33xx/emif4.c
index bf3da43ed982..b29250b8d207 100644
--- a/arch/arm/mach-omap2/am33xx/emif4.c
+++ b/arch/arm/mach-omap2/am33xx/emif4.c
@@ -4,7 +4,7 @@
  *
  * AM33XX emif4 configuration file
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/arch/arm/mach-omap2/am33xx/mux.c b/arch/arm/mach-omap2/am33xx/mux.c
index aad3ec855697..496055939798 100644
--- a/arch/arm/mach-omap2/am33xx/mux.c
+++ b/arch/arm/mach-omap2/am33xx/mux.c
@@ -1,7 +1,7 @@
 /*
  * mux.c
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
diff --git a/arch/arm/mach-omap2/am33xx/sys_info.c b/arch/arm/mach-omap2/am33xx/sys_info.c
index 338f6afcae38..390d540e85a0 100644
--- a/arch/arm/mach-omap2/am33xx/sys_info.c
+++ b/arch/arm/mach-omap2/am33xx/sys_info.c
@@ -4,7 +4,7 @@
  *
  * System information functions
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  *
  * Derived from Beagle Board and 3430 SDP code by
  *      Richard Woodruff <r-woodruff2@ti.com>
diff --git a/arch/arm/mach-omap2/boot-common.c b/arch/arm/mach-omap2/boot-common.c
index a2dd5f6df01e..a68b21aeacc0 100644
--- a/arch/arm/mach-omap2/boot-common.c
+++ b/arch/arm/mach-omap2/boot-common.c
@@ -4,7 +4,7 @@
  *
  * Common bootmode functions for omap based boards
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/arch/arm/mach-omap2/config.mk b/arch/arm/mach-omap2/config.mk
index 4f0d2598fa8b..30d8fb1b1d9f 100644
--- a/arch/arm/mach-omap2/config.mk
+++ b/arch/arm/mach-omap2/config.mk
@@ -1,5 +1,5 @@
 #
-# Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+# Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
 #
 # SPDX-License-Identifier:      GPL-2.0+
 
diff --git a/arch/arm/mach-omap2/config_secure.mk b/arch/arm/mach-omap2/config_secure.mk
index f76262bb0ce8..40db1aec1425 100644
--- a/arch/arm/mach-omap2/config_secure.mk
+++ b/arch/arm/mach-omap2/config_secure.mk
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright (C) 2016, Texas Instruments, Incorporated - http://www.ti.com/
+# Copyright (C) 2016, Texas Instruments, Incorporated - https://www.ti.com/
 quiet_cmd_mkomapsecimg = SECURE  $@
 ifneq ($(TI_SECURE_DEV_PKG),)
 ifneq ($(wildcard $(TI_SECURE_DEV_PKG)/scripts/create-boot-image.sh),)
diff --git a/arch/arm/mach-omap2/omap3/emif4.c b/arch/arm/mach-omap2/omap3/emif4.c
index 491e7c23dbc6..7e5a28192202 100644
--- a/arch/arm/mach-omap2/omap3/emif4.c
+++ b/arch/arm/mach-omap2/omap3/emif4.c
@@ -6,7 +6,7 @@
  * Based on mem.c and sdrc.c
  *
  * Copyright (C) 2010
- * Texas Instruments Incorporated - http://www.ti.com/
+ * Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/arch/arm/mach-omap2/omap3/sdrc.c b/arch/arm/mach-omap2/omap3/sdrc.c
index 07f534a60b2b..5d43e7c9cf45 100644
--- a/arch/arm/mach-omap2/omap3/sdrc.c
+++ b/arch/arm/mach-omap2/omap3/sdrc.c
@@ -7,7 +7,7 @@
  * generic init function (mem_init).
  *
  * Copyright (C) 2004-2010
- * Texas Instruments Incorporated - http://www.ti.com/
+ * Texas Instruments Incorporated - https://www.ti.com/
  *
  * Copyright (C) 2011
  * Corscience GmbH & Co. KG - Simon Schwarz <schwarz@corscience.de>
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index b7f79800de57..054782efbdbd 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -1,7 +1,7 @@
 /*
  * Voltage Controller implementation for OMAP
  *
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  *	Nishanth Menon
  *
  * This program is free software; you can redistribute it and/or modify
diff --git a/arch/arm/mach-sunxi/dram_sun8i_a23.c b/arch/arm/mach-sunxi/dram_sun8i_a23.c
index 3ed97b59a32c..056cb03efb16 100644
--- a/arch/arm/mach-sunxi/dram_sun8i_a23.c
+++ b/arch/arm/mach-sunxi/dram_sun8i_a23.c
@@ -14,7 +14,7 @@
  *
  * The register-layout of the sunxi_mctl_phy_reg-s looks a lot like the one
  * found in the TI Keystone2 documentation:
- * http://www.ti.com/lit/ug/spruhn7a/spruhn7a.pdf
+ * https://www.ti.com/lit/ug/spruhn7a/spruhn7a.pdf
  * "Table4-2 DDR3 PHY Registers"
  * This may be used as a (possible) reference for future work / cleanups.
  */
diff --git a/board/bosch/guardian/board.c b/board/bosch/guardian/board.c
index c31e2c86a2d5..ee9e6d632ed4 100644
--- a/board/bosch/guardian/board.c
+++ b/board/bosch/guardian/board.c
@@ -4,7 +4,7 @@
  *
  * Board functions for Bosch Guardian
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  * Copyright (C) 2018 Robert Bosch Power Tools GmbH
  */
 
diff --git a/board/bosch/guardian/board.h b/board/bosch/guardian/board.h
index b301caf47f5b..e1e8c0cb0ebc 100644
--- a/board/bosch/guardian/board.h
+++ b/board/bosch/guardian/board.h
@@ -4,7 +4,7 @@
  *
  * Board header for Bosch Guardian
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  * Copyright (C) 2018 Robert Bosch Power Tools GmbH
  */
 
diff --git a/board/bosch/guardian/mux.c b/board/bosch/guardian/mux.c
index 12c3eb666fb1..53850ffb8f7e 100644
--- a/board/bosch/guardian/mux.c
+++ b/board/bosch/guardian/mux.c
@@ -2,7 +2,7 @@
 /*
  * mux.c
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  * Copyright (C) 2018 Robert Bosch Power Tools GmbH
  */
 
diff --git a/board/bosch/shc/Makefile b/board/bosch/shc/Makefile
index 93f2df3773e3..bac12edc1d09 100644
--- a/board/bosch/shc/Makefile
+++ b/board/bosch/shc/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile
 #
-# Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
 
 obj-y	:= mux.o
 obj-y	+= board.o
diff --git a/board/bosch/shc/board.c b/board/bosch/shc/board.c
index e3a9c00e8098..962a485acd22 100644
--- a/board/bosch/shc/board.c
+++ b/board/bosch/shc/board.c
@@ -8,7 +8,7 @@
  * Based on:
  * Board functions for TI AM335X based boards
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/board/bosch/shc/board.h b/board/bosch/shc/board.h
index 997595bf42b5..4cc02f93c64b 100644
--- a/board/bosch/shc/board.h
+++ b/board/bosch/shc/board.h
@@ -8,7 +8,7 @@
  * Based on:
  * TI AM335x boards information header
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #ifndef _BOARD_H_
diff --git a/board/bosch/shc/mux.c b/board/bosch/shc/mux.c
index 0a97eafea6c4..f19d1866c721 100644
--- a/board/bosch/shc/mux.c
+++ b/board/bosch/shc/mux.c
@@ -6,7 +6,7 @@
  * Heiko Schocher, DENX Software Engineering, hs@denx.de.
  *
  * Based on:
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/board/davinci/da8xxevm/da850evm.c b/board/davinci/da8xxevm/da850evm.c
index 474dca72929f..05053a87a5a9 100644
--- a/board/davinci/da8xxevm/da850evm.c
+++ b/board/davinci/da8xxevm/da850evm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com/
  *
  * Based on da830evm.c. Original Copyrights follow:
  *
diff --git a/board/davinci/da8xxevm/omapl138_lcdk.c b/board/davinci/da8xxevm/omapl138_lcdk.c
index 5ffd420fff36..9738e2bd9c77 100644
--- a/board/davinci/da8xxevm/omapl138_lcdk.c
+++ b/board/davinci/da8xxevm/omapl138_lcdk.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  *
  * Based on da850evm.c. Original Copyrights follow:
  *
diff --git a/board/eets/pdu001/README b/board/eets/pdu001/README
index 50e715446b66..ab10cf99f453 100644
--- a/board/eets/pdu001/README
+++ b/board/eets/pdu001/README
@@ -14,7 +14,7 @@ Hardware
 The PDU-001 (Processor and Display Unit) is a plugin card for 19" racks. It is
 manufactured by EETS GmbH (https://www.eets.ch). The core of the board is a m2
 SOM from bytes at work (https://www.bytesatwork.ch) which in turn is based on
-AM3352 SOC from TI (http://www.ti.com).
+AM3352 SOC from TI (https://www.ti.com).
 
 Customization
 =============
diff --git a/board/eets/pdu001/board.c b/board/eets/pdu001/board.c
index de224d4d2834..3a52e4ae675f 100644
--- a/board/eets/pdu001/board.c
+++ b/board/eets/pdu001/board.c
@@ -6,7 +6,7 @@
  *
  * Copyright (C) 2018, EETS GmbH, http://www.eets.ch/
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/board/eets/pdu001/board.h b/board/eets/pdu001/board.h
index bfea96e5f02a..6ad0fea33b45 100644
--- a/board/eets/pdu001/board.h
+++ b/board/eets/pdu001/board.h
@@ -6,7 +6,7 @@
  *
  * Copyright (C) 2018 EETS GmbH - http://www.eets.ch/
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #ifndef _BOARD_H_
diff --git a/board/eets/pdu001/mux.c b/board/eets/pdu001/mux.c
index 886fef60b0af..c97927e5cfe9 100644
--- a/board/eets/pdu001/mux.c
+++ b/board/eets/pdu001/mux.c
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 2018 EETS GmbH - http://www.eets.ch/
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/board/grinn/chiliboard/board.c b/board/grinn/chiliboard/board.c
index b472ca5b94a6..64b32ca96df3 100644
--- a/board/grinn/chiliboard/board.c
+++ b/board/grinn/chiliboard/board.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  * Copyright (C) 2017, Grinn - http://grinn-global.com/
  */
 
diff --git a/board/lego/ev3/legoev3.c b/board/lego/ev3/legoev3.c
index 834926013101..43afe593c78b 100644
--- a/board/lego/ev3/legoev3.c
+++ b/board/lego/ev3/legoev3.c
@@ -4,7 +4,7 @@
  *
  * Based on da850evm.c
  *
- * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com/
  *
  * Based on da830evm.c. Original Copyrights follow:
  *
diff --git a/board/logicpd/am3517evm/Makefile b/board/logicpd/am3517evm/Makefile
index c07a98e9389e..c7da6e3fe0dc 100644
--- a/board/logicpd/am3517evm/Makefile
+++ b/board/logicpd/am3517evm/Makefile
@@ -4,6 +4,6 @@
 #
 # Based on ti/evm/Makefile
 #
-# Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com/
 
 obj-y	:= am3517evm.o
diff --git a/board/logicpd/am3517evm/am3517evm.c b/board/logicpd/am3517evm/am3517evm.c
index e787441c746a..e69a73f2af6f 100644
--- a/board/logicpd/am3517evm/am3517evm.c
+++ b/board/logicpd/am3517evm/am3517evm.c
@@ -7,7 +7,7 @@
  * Based on ti/evm/evm.c
  *
  * Copyright (C) 2010
- * Texas Instruments Incorporated - http://www.ti.com/
+ * Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/board/logicpd/am3517evm/am3517evm.h b/board/logicpd/am3517evm/am3517evm.h
index aec2b410c882..283b4535a6be 100644
--- a/board/logicpd/am3517evm/am3517evm.h
+++ b/board/logicpd/am3517evm/am3517evm.h
@@ -7,7 +7,7 @@
  * Based on ti/evm/evm.h
  *
  * Copyright (C) 2010
- * Texas Instruments Incorporated - http://www.ti.com/
+ * Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef _AM3517EVM_H_
diff --git a/board/phytec/phycore_am335x_r2/Makefile b/board/phytec/phycore_am335x_r2/Makefile
index ff6f8b42216a..16ac38fd8be9 100644
--- a/board/phytec/phycore_am335x_r2/Makefile
+++ b/board/phytec/phycore_am335x_r2/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile
 #
-# Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
 
 ifdef CONFIG_SPL_BUILD
 obj-y	+= mux.o
diff --git a/board/phytec/phycore_am335x_r2/board.c b/board/phytec/phycore_am335x_r2/board.c
index eb573d076dd7..5700effbd3f6 100644
--- a/board/phytec/phycore_am335x_r2/board.c
+++ b/board/phytec/phycore_am335x_r2/board.c
@@ -4,7 +4,7 @@
  *
  * Board functions for Phytec phyCORE-AM335x R2 (PCL060 / PCM060) based boards
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  * Copyright (C) 2013 Lars Poeschel, Lemonage Software GmbH
  * Copyright (C) 2015 Wadim Egorov, PHYTEC Messtechnik GmbH
  * Copyright (C) 2019 DENX Software Engineering GmbH
diff --git a/board/siemens/common/board.c b/board/siemens/common/board.c
index 8fa9197a6dfb..d077751cbe15 100644
--- a/board/siemens/common/board.c
+++ b/board/siemens/common/board.c
@@ -6,7 +6,7 @@
  *
  * Based on:
  * U-Boot file:/board/ti/am335x/board.c
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/board/siemens/draco/Makefile b/board/siemens/draco/Makefile
index 3e3394a86568..e94456ab1c3d 100644
--- a/board/siemens/draco/Makefile
+++ b/board/siemens/draco/Makefile
@@ -7,7 +7,7 @@
 #
 # Based on:
 # u-boot:/board/ti/am335x/Makefile
-# Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
 
 ifdef CONFIG_SPL_BUILD
 obj-y	:= mux.o
diff --git a/board/siemens/draco/board.c b/board/siemens/draco/board.c
index 8874659013fc..8b13d23aca70 100644
--- a/board/siemens/draco/board.c
+++ b/board/siemens/draco/board.c
@@ -9,7 +9,7 @@
  * Board functions for TI AM335X based boards
  * u-boot:/board/ti/am335x/board.c
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/board/siemens/draco/board.h b/board/siemens/draco/board.h
index 7c29a45c036f..f027427d1fb4 100644
--- a/board/siemens/draco/board.h
+++ b/board/siemens/draco/board.h
@@ -9,7 +9,7 @@
  * TI AM335x boards information header
  * u-boot:/board/ti/am335x/board.h
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #ifndef _BOARD_H_
diff --git a/board/siemens/draco/mux.c b/board/siemens/draco/mux.c
index 3f2d41befeb0..2632f0503361 100644
--- a/board/siemens/draco/mux.c
+++ b/board/siemens/draco/mux.c
@@ -7,7 +7,7 @@
  *
  * Based on:
  * u-boot:/board/ti/am335x/mux.c
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/board/siemens/pxm2/Makefile b/board/siemens/pxm2/Makefile
index 3e3394a86568..e94456ab1c3d 100644
--- a/board/siemens/pxm2/Makefile
+++ b/board/siemens/pxm2/Makefile
@@ -7,7 +7,7 @@
 #
 # Based on:
 # u-boot:/board/ti/am335x/Makefile
-# Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
 
 ifdef CONFIG_SPL_BUILD
 obj-y	:= mux.o
diff --git a/board/siemens/pxm2/board.c b/board/siemens/pxm2/board.c
index 47f19bcb8fd9..40aee7c8b3e9 100644
--- a/board/siemens/pxm2/board.c
+++ b/board/siemens/pxm2/board.c
@@ -9,7 +9,7 @@
  *
  * Board functions for TI AM335X based boards
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/board/siemens/pxm2/board.h b/board/siemens/pxm2/board.h
index af21fc47432c..9067e4d5aa88 100644
--- a/board/siemens/pxm2/board.h
+++ b/board/siemens/pxm2/board.h
@@ -9,7 +9,7 @@
  * TI AM335x boards information header
  * u-boot:/board/ti/am335x/board.h
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #ifndef _BOARD_H_
diff --git a/board/siemens/pxm2/mux.c b/board/siemens/pxm2/mux.c
index 2f35bb4a7307..d21ef47771d1 100644
--- a/board/siemens/pxm2/mux.c
+++ b/board/siemens/pxm2/mux.c
@@ -8,7 +8,7 @@
  * Based on:
  * u-boot:/board/ti/am335x/mux.c
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/board/siemens/pxm2/pmic.h b/board/siemens/pxm2/pmic.h
index 37660460aa81..f4ce7f16b296 100644
--- a/board/siemens/pxm2/pmic.h
+++ b/board/siemens/pxm2/pmic.h
@@ -4,7 +4,7 @@
  * (C) Heiko Schocher, DENX Software Engineering, hs@denx.de.
  *
  * Based on:
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 #ifndef PMIC_H
 #define PMIC_H
diff --git a/board/siemens/rut/Makefile b/board/siemens/rut/Makefile
index 3e3394a86568..e94456ab1c3d 100644
--- a/board/siemens/rut/Makefile
+++ b/board/siemens/rut/Makefile
@@ -7,7 +7,7 @@
 #
 # Based on:
 # u-boot:/board/ti/am335x/Makefile
-# Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
 
 ifdef CONFIG_SPL_BUILD
 obj-y	:= mux.o
diff --git a/board/siemens/rut/board.c b/board/siemens/rut/board.c
index a8b196a65c9a..bad0b71ce2dc 100644
--- a/board/siemens/rut/board.c
+++ b/board/siemens/rut/board.c
@@ -7,7 +7,7 @@
  * Based on:
  * u-boot:/board/ti/am335x/board.c
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/board/siemens/rut/board.h b/board/siemens/rut/board.h
index af21fc47432c..9067e4d5aa88 100644
--- a/board/siemens/rut/board.h
+++ b/board/siemens/rut/board.h
@@ -9,7 +9,7 @@
  * TI AM335x boards information header
  * u-boot:/board/ti/am335x/board.h
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #ifndef _BOARD_H_
diff --git a/board/siemens/rut/mux.c b/board/siemens/rut/mux.c
index d80120bbdd24..894a9bf1e3d7 100644
--- a/board/siemens/rut/mux.c
+++ b/board/siemens/rut/mux.c
@@ -8,7 +8,7 @@
  * Based on:
  * u-boot:/board/ti/am335x/mux.c
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/board/tcl/sl50/board.c b/board/tcl/sl50/board.c
index 839a692ce85d..3f7d42f3eb8d 100644
--- a/board/tcl/sl50/board.c
+++ b/board/tcl/sl50/board.c
@@ -4,7 +4,7 @@
  *
  * Board functions for TCL SL50 board
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/board/tcl/sl50/board.h b/board/tcl/sl50/board.h
index b8b9ed7e71c3..e6246772a59c 100644
--- a/board/tcl/sl50/board.h
+++ b/board/tcl/sl50/board.h
@@ -4,7 +4,7 @@
  *
  * TCL SL50 boards information header
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #ifndef _BOARD_H_
diff --git a/board/tcl/sl50/mux.c b/board/tcl/sl50/mux.c
index b0a1dad3aa74..ab9088145aba 100644
--- a/board/tcl/sl50/mux.c
+++ b/board/tcl/sl50/mux.c
@@ -2,7 +2,7 @@
 /*
  * mux.c
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/board/ti/am335x/Makefile b/board/ti/am335x/Makefile
index 3ccf66be5bb3..2b1e21a17889 100644
--- a/board/ti/am335x/Makefile
+++ b/board/ti/am335x/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile
 #
-# Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
 
 ifeq ($(CONFIG_$(SPL_)SKIP_LOWLEVEL_INIT),)
 obj-y	:= mux.o
diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
index ecb9fa02de58..34f987c2b728 100644
--- a/board/ti/am335x/board.c
+++ b/board/ti/am335x/board.c
@@ -4,7 +4,7 @@
  *
  * Board functions for TI AM335X based boards
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/board/ti/am335x/board.h b/board/ti/am335x/board.h
index c2962111c1ad..1284c160d811 100644
--- a/board/ti/am335x/board.h
+++ b/board/ti/am335x/board.h
@@ -4,7 +4,7 @@
  *
  * TI AM335x boards information header
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #ifndef _BOARD_H_
diff --git a/board/ti/am335x/mux.c b/board/ti/am335x/mux.c
index 7d31adec1421..0bad154f86ed 100644
--- a/board/ti/am335x/mux.c
+++ b/board/ti/am335x/mux.c
@@ -1,7 +1,7 @@
 /*
  * mux.c
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
diff --git a/board/ti/am43xx/Makefile b/board/ti/am43xx/Makefile
index 8dc1d89e3ac8..b618f632eff8 100644
--- a/board/ti/am43xx/Makefile
+++ b/board/ti/am43xx/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile
 #
-# Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
 
 ifeq ($(CONFIG_$(SPL_)SKIP_LOWLEVEL_INIT),)
 obj-y	:= mux.o
diff --git a/board/ti/am43xx/board.c b/board/ti/am43xx/board.c
index 58bfe7cd455f..ea0d0b92088a 100644
--- a/board/ti/am43xx/board.c
+++ b/board/ti/am43xx/board.c
@@ -4,7 +4,7 @@
  *
  * Board functions for TI AM43XX based boards
  *
- * Copyright (C) 2013, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2013, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/board/ti/am43xx/board.h b/board/ti/am43xx/board.h
index 06b737445d44..37a169aaf758 100644
--- a/board/ti/am43xx/board.h
+++ b/board/ti/am43xx/board.h
@@ -5,7 +5,7 @@
  * TI AM437x boards information header
  * Derived from AM335x board.
  *
- * Copyright (C) 2013, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2013, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #ifndef _BOARD_H_
diff --git a/board/ti/am43xx/mux.c b/board/ti/am43xx/mux.c
index f59e93a0ebba..463f1cc71784 100644
--- a/board/ti/am43xx/mux.c
+++ b/board/ti/am43xx/mux.c
@@ -2,7 +2,7 @@
 /*
  * mux.c
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/board/ti/am57xx/board.c b/board/ti/am57xx/board.c
index 9ea507a8e961..b004a89bb324 100644
--- a/board/ti/am57xx/board.c
+++ b/board/ti/am57xx/board.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
  *
  * Author: Felipe Balbi <balbi@ti.com>
  *
diff --git a/board/ti/am57xx/mux_data.h b/board/ti/am57xx/mux_data.h
index 54b7050a4599..f2f428ef9b84 100644
--- a/board/ti/am57xx/mux_data.h
+++ b/board/ti/am57xx/mux_data.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
  *
  * Author: Felipe Balbi <balbi@ti.com>
  *
diff --git a/board/ti/am65x/Kconfig b/board/ti/am65x/Kconfig
index 5fd19d652a6b..78c7040c3dad 100644
--- a/board/ti/am65x/Kconfig
+++ b/board/ti/am65x/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright (C) 2017-2018 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2017-2018 Texas Instruments Incorporated - https://www.ti.com/
 #	Lokesh Vutla <lokeshvutla@ti.com>
 
 choice
diff --git a/board/ti/am65x/Makefile b/board/ti/am65x/Makefile
index 94dddfcc4a50..079a86dae7f5 100644
--- a/board/ti/am65x/Makefile
+++ b/board/ti/am65x/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright (C) 2017-2018 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2017-2018 Texas Instruments Incorporated - https://www.ti.com/
 #	Lokesh Vutla <lokeshvutla@ti.com>
 #
 # SPDX-License-Identifier:     GPL-2.0+
diff --git a/board/ti/am65x/evm.c b/board/ti/am65x/evm.c
index 8bb13ef5b2b3..9de3ddaa2801 100644
--- a/board/ti/am65x/evm.c
+++ b/board/ti/am65x/evm.c
@@ -2,7 +2,7 @@
 /*
  * Board specific initialization for AM654 EVM
  *
- * Copyright (C) 2017-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017-2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  *
  */
diff --git a/board/ti/common/Makefile b/board/ti/common/Makefile
index 3172d87b4658..26bf12e2e6d5 100644
--- a/board/ti/common/Makefile
+++ b/board/ti/common/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.ti.com/
 
 obj-${CONFIG_TI_I2C_BOARD_DETECT} += board_detect.o
 obj-${CONFIG_CMD_EXTENSION} += cape_detect.o
diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_detect.c
index ac39b25cd426..0ec6d1aaf4c9 100644
--- a/board/ti/common/board_detect.c
+++ b/board/ti/common/board_detect.c
@@ -2,7 +2,7 @@
 /*
  * Library to support early TI EVM EEPROM handling
  *
- * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla
  *	Steve Kipisz
  */
diff --git a/board/ti/common/board_detect.h b/board/ti/common/board_detect.h
index de7cb52dfcdd..ca1aa80f2f04 100644
--- a/board/ti/common/board_detect.h
+++ b/board/ti/common/board_detect.h
@@ -2,7 +2,7 @@
 /*
  * Library to support early TI EVM EEPROM handling
  *
- * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #ifndef __BOARD_DETECT_H
diff --git a/board/ti/j721e/Kconfig b/board/ti/j721e/Kconfig
index e6cb21f77bd2..9505330ef30a 100644
--- a/board/ti/j721e/Kconfig
+++ b/board/ti/j721e/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2018-2019 Texas Instruments Incorporated - https://www.ti.com/
 #	Lokesh Vutla <lokeshvutla@ti.com>
 
 choice
diff --git a/board/ti/j721e/Makefile b/board/ti/j721e/Makefile
index 97535f5d86d1..6e910546756d 100644
--- a/board/ti/j721e/Makefile
+++ b/board/ti/j721e/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2018-2019 Texas Instruments Incorporated - https://www.ti.com/
 #	Lokesh Vutla <lokeshvutla@ti.com>
 #
 # SPDX-License-Identifier:     GPL-2.0+
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index d4f7c1d9f938..c13c6b2533ae 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -2,7 +2,7 @@
 /*
  * Board specific initialization for J721E EVM
  *
- * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018-2019 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  *
  */
diff --git a/board/ti/j721s2/evm.c b/board/ti/j721s2/evm.c
index 7795300abc80..01eb4965d92d 100644
--- a/board/ti/j721s2/evm.c
+++ b/board/ti/j721s2/evm.c
@@ -2,7 +2,7 @@
 /*
  * Board specific initialization for J721S2 EVM
  *
- * Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
  *	David Huang <d-huang@ti.com>
  *
  */
diff --git a/board/vscom/baltos/Makefile b/board/vscom/baltos/Makefile
index 3ccf66be5bb3..2b1e21a17889 100644
--- a/board/vscom/baltos/Makefile
+++ b/board/vscom/baltos/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile
 #
-# Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
 
 ifeq ($(CONFIG_$(SPL_)SKIP_LOWLEVEL_INIT),)
 obj-y	:= mux.o
diff --git a/board/vscom/baltos/board.c b/board/vscom/baltos/board.c
index 8f23cda8e4fc..bc7dc5888f2d 100644
--- a/board/vscom/baltos/board.c
+++ b/board/vscom/baltos/board.c
@@ -4,7 +4,7 @@
  *
  * Board functions for TI AM335X based boards
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/board/vscom/baltos/board.h b/board/vscom/baltos/board.h
index 630c9bba73b3..db6e19123aec 100644
--- a/board/vscom/baltos/board.h
+++ b/board/vscom/baltos/board.h
@@ -4,7 +4,7 @@
  *
  * TI AM335x boards information header
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
 #ifndef _BOARD_H_
diff --git a/board/vscom/baltos/mux.c b/board/vscom/baltos/mux.c
index e01899c83a98..7b99cf0e182f 100644
--- a/board/vscom/baltos/mux.c
+++ b/board/vscom/baltos/mux.c
@@ -1,7 +1,7 @@
 /*
  * mux.c
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
diff --git a/cmd/remoteproc.c b/cmd/remoteproc.c
index ca3b436242ab..ea8724a187da 100644
--- a/cmd/remoteproc.c
+++ b/cmd/remoteproc.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * (C) Copyright 2015
- * Texas Instruments Incorporated - http://www.ti.com/
+ * Texas Instruments Incorporated - https://www.ti.com/
  */
 #include <common.h>
 #include <command.h>
diff --git a/cmd/ti/Makefile b/cmd/ti/Makefile
index 87f85b2c2323..5f9c64f598ab 100644
--- a/cmd/ti/Makefile
+++ b/cmd/ti/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
 
 obj-$(CONFIG_CMD_DDR3) += ddr3.o
 obj-$(CONFIG_CMD_PD) += pd.o
diff --git a/cmd/ufs.c b/cmd/ufs.c
index 143e946370f8..282b4146e92c 100644
--- a/cmd/ufs.c
+++ b/cmd/ufs.c
@@ -2,7 +2,7 @@
 /**
  * ufs.c - UFS specific U-Boot commands
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  *
  */
 #include <common.h>
diff --git a/common/spl/Makefile b/common/spl/Makefile
index 4f8eb2ec0cab..4809f9c3ec13 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 # (C) Copyright 2012
-# Texas Instruments Incorporated - http://www.ti.com/
+# Texas Instruments Incorporated - https://www.ti.com/
 # Aneesh V <aneesh@ti.com>
 # Based on common/Makefile.
 #
diff --git a/doc/README.davinci b/doc/README.davinci
index f368f99a41e2..ea81279a0f33 100644
--- a/doc/README.davinci
+++ b/doc/README.davinci
@@ -70,7 +70,7 @@ http://www.logicpd.com/products/development-kits/zoom-omap-l138-evm-development-
 
 2) TI OMAP-L138 LCDK
 http://focus.ti.com/docs/prod/folders/print/omap-l138.html
-http://www.ti.com/tool/TMDXLCDK138
+https://www.ti.com/tool/TMDXLCDK138
 
 Davinci special defines
 =======================
diff --git a/doc/README.omap3 b/doc/README.omap3
index 3a1ac8101d64..d1e6be94a111 100644
--- a/doc/README.omap3
+++ b/doc/README.omap3
@@ -163,8 +163,8 @@ Links
 
 [1] OMAP3:
 
-http://www.ti.com/omap3 (high volume) and
-http://www.ti.com/omap35x (broad market)
+https://www.ti.com/omap3 (high volume) and
+https://www.ti.com/omap35x (broad market)
 
 [2] OMAP3530 BeagleBoard:
 
diff --git a/doc/board/ti/am335x_evm.rst b/doc/board/ti/am335x_evm.rst
index 2ba651eb6df9..4627da3bc078 100644
--- a/doc/board/ti/am335x_evm.rst
+++ b/doc/board/ti/am335x_evm.rst
@@ -59,7 +59,7 @@ from Texas Instruments. The tools used to generate boot images for secure
 devices are part of a secure development package (SECDEV) that can be
 downloaded from:
 
-	http://www.ti.com/mysecuresoftware (login required)
+	https://www.ti.com/mysecuresoftware (login required)
 
 The secure development package is access controlled due to NDA and export
 control restrictions. Access must be requested and granted by TI before the
diff --git a/doc/board/ti/am65x_evm.rst b/doc/board/ti/am65x_evm.rst
index 7cebb1ca62d3..bf9e4c46a410 100644
--- a/doc/board/ti/am65x_evm.rst
+++ b/doc/board/ti/am65x_evm.rst
@@ -22,7 +22,7 @@ cores, voltage domains and peripherals:
 3. MAIN domain:
         * Quad core 64-bit ARM Cortex-A53
 
-More info can be found in TRM: http://www.ti.com/lit/pdf/spruid7
+More info can be found in TRM: https://www.ti.com/lit/pdf/spruid7
 
 Platform information:
 
diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
index cadaac017811..cbb7da657ac0 100644
--- a/doc/board/ti/j721e_evm.rst
+++ b/doc/board/ti/j721e_evm.rst
@@ -27,7 +27,7 @@ specific processing cores and peripherals:
         * 2 x C66x Digital signal processor sub system
         * C71x Digital signal processor sub-system with MMA.
 
-More info can be found in TRM: http://www.ti.com/lit/pdf/spruil1
+More info can be found in TRM: https://www.ti.com/lit/pdf/spruil1
 
 Platform information:
 
diff --git a/doc/board/ti/ks2_evm.rst b/doc/board/ti/ks2_evm.rst
index 0a789037a6a8..5e3ecad6b2ed 100644
--- a/doc/board/ti/ks2_evm.rst
+++ b/doc/board/ti/ks2_evm.rst
@@ -17,17 +17,17 @@ Documentation for this board can be found at:
 The K2HK board is based on Texas Instruments Keystone2 family of SoCs: K2H, K2K.
 More details on these SoCs are available at company websites:
 
-K2K: http://www.ti.com/product/tci6638k2k
-K2H: http://www.ti.com/product/tci6638k2h
+K2K: https://www.ti.com/product/tci6638k2k
+K2H: https://www.ti.com/product/tci6638k2h
 
 The K2E SoC details are available at
- http://www.ti.com/lit/ds/symlink/66ak2e05.pdf
+ https://www.ti.com/lit/ds/symlink/66ak2e05.pdf
 
 The K2L SoC details are available at
- http://www.ti.com/lit/ds/symlink/tci6630k2l.pdf
+ https://www.ti.com/lit/ds/symlink/tci6630k2l.pdf
 
 The K2G SoC details are available at
- http://www.ti.com/lit/ds/symlink/66ak2g02.pdf
+ https://www.ti.com/lit/ds/symlink/66ak2g02.pdf
 
 Board Configuration
 -------------------
diff --git a/doc/develop/driver-model/remoteproc-framework.rst b/doc/develop/driver-model/remoteproc-framework.rst
index 566495a21c43..03a0bd0f4b41 100644
--- a/doc/develop/driver-model/remoteproc-framework.rst
+++ b/doc/develop/driver-model/remoteproc-framework.rst
@@ -1,6 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. (C) Copyright 2015
-.. Texas Instruments Incorporated - http://www.ti.com/
+.. Texas Instruments Incorporated - https://www.ti.com/
 
 Remote Processor Framework
 ==========================
diff --git a/doc/develop/driver-model/soc-framework.rst b/doc/develop/driver-model/soc-framework.rst
index 2609fda64421..357e7fc8c905 100644
--- a/doc/develop/driver-model/soc-framework.rst
+++ b/doc/develop/driver-model/soc-framework.rst
@@ -1,6 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. (C) Copyright 2020
-.. Texas Instruments Incorporated - http://www.ti.com/
+.. Texas Instruments Incorporated - https://www.ti.com/
 
 SOC ID Framework
 ================
diff --git a/doc/device-tree-bindings/clock/ti,cdce9xx.txt b/doc/device-tree-bindings/clock/ti,cdce9xx.txt
index 0d01f2d5cc36..62701d2145d4 100644
--- a/doc/device-tree-bindings/clock/ti,cdce9xx.txt
+++ b/doc/device-tree-bindings/clock/ti,cdce9xx.txt
@@ -4,10 +4,10 @@ Reference
 This binding uses the common clock binding[1].
 
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] http://www.ti.com/product/cdce913
-[3] http://www.ti.com/product/cdce925
-[4] http://www.ti.com/product/cdce937
-[5] http://www.ti.com/product/cdce949
+[2] https://www.ti.com/product/cdce913
+[3] https://www.ti.com/product/cdce925
+[4] https://www.ti.com/product/cdce937
+[5] https://www.ti.com/product/cdce949
 
 The driver provides clock sources for each output Y1 through Y5.
 
diff --git a/doc/device-tree-bindings/video/tilcdc/tilcdc.txt b/doc/device-tree-bindings/video/tilcdc/tilcdc.txt
index 7bf1bb444812..7600801055de 100644
--- a/doc/device-tree-bindings/video/tilcdc/tilcdc.txt
+++ b/doc/device-tree-bindings/video/tilcdc/tilcdc.txt
@@ -46,7 +46,7 @@ Optional nodes:
     crossed and LCD_DATA[0:4] is for Red[3:7] and LCD_DATA[11:15] is
     for Blue[3-7]. For more details see section 3.1.1 in AM335x
     Silicon Errata:
-    http://www.ti.com/general/docs/lit/getliterature.tsp?baseLiteratureNumber=sprz360
+    https://www.ti.com/general/docs/lit/getliterature.tsp?baseLiteratureNumber=sprz360
 
 Example:
 
diff --git a/drivers/clk/clk-cdce9xx.c b/drivers/clk/clk-cdce9xx.c
index f23465d7e1f9..b8700f517fc9 100644
--- a/drivers/clk/clk-cdce9xx.c
+++ b/drivers/clk/clk-cdce9xx.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments CDCE913/925/937/949 clock synthesizer driver
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  *	Tero Kristo <t-kristo@ti.com>
  *
  * Based on Linux kernel clk-cdce925.c.
diff --git a/drivers/clk/ti/clk-k3-pll.c b/drivers/clk/ti/clk-k3-pll.c
index c1158c132903..8323e6e6919c 100644
--- a/drivers/clk/ti/clk-k3-pll.c
+++ b/drivers/clk/ti/clk-k3-pll.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments K3 SoC PLL clock driver
  *
- * Copyright (C) 2020-2021 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
  *	Tero Kristo <t-kristo@ti.com>
  */
 
diff --git a/drivers/clk/ti/clk-k3.c b/drivers/clk/ti/clk-k3.c
index 10f7240f77a8..eb76195bd75d 100644
--- a/drivers/clk/ti/clk-k3.c
+++ b/drivers/clk/ti/clk-k3.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments K3 clock driver
  *
- * Copyright (C) 2020-2021 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
  *	Tero Kristo <t-kristo@ti.com>
  */
 
diff --git a/drivers/clk/ti/clk-sci.c b/drivers/clk/ti/clk-sci.c
index 8fc3254c996c..9e5760d33544 100644
--- a/drivers/clk/ti/clk-sci.c
+++ b/drivers/clk/ti/clk-sci.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments System Control Interface (TI SCI) clock driver
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Andreas Dannenberg <dannenberg@ti.com>
  *
  * Loosely based on Linux kernel sci-clk.c...
diff --git a/drivers/dma/ti/k3-psil-am64.c b/drivers/dma/ti/k3-psil-am64.c
index 15742c3723d5..6180e2a19960 100644
--- a/drivers/dma/ti/k3-psil-am64.c
+++ b/drivers/dma/ti/k3-psil-am64.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com
+ *  Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 
diff --git a/drivers/dma/ti/k3-psil-am654.c b/drivers/dma/ti/k3-psil-am654.c
index d16c07566b5d..ce86600e5562 100644
--- a/drivers/dma/ti/k3-psil-am654.c
+++ b/drivers/dma/ti/k3-psil-am654.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ *  Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 
diff --git a/drivers/dma/ti/k3-psil-priv.h b/drivers/dma/ti/k3-psil-priv.h
index 28078c6bd8d7..563bc57e2060 100644
--- a/drivers/dma/ti/k3-psil-priv.h
+++ b/drivers/dma/ti/k3-psil-priv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ *  Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #ifndef K3_PSIL_PRIV_H_
diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index f23c8ca2b74c..963321aa1e34 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ *  Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 
diff --git a/drivers/dma/ti/k3-psil.h b/drivers/dma/ti/k3-psil.h
index 1e0fe06c0a43..af60a9924e2f 100644
--- a/drivers/dma/ti/k3-psil.h
+++ b/drivers/dma/ti/k3-psil.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ *  Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #ifndef K3_PSIL_H_
diff --git a/drivers/dma/ti/k3-udma-hwdef.h b/drivers/dma/ti/k3-udma-hwdef.h
index 5d50bbcb0317..3d6b4d10fff1 100644
--- a/drivers/dma/ti/k3-udma-hwdef.h
+++ b/drivers/dma/ti/k3-udma-hwdef.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- *  Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com
+ *  Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com
  *
  *
  * This program is free software; you can redistribute it and/or modify
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 9273c70e9d94..8a62d63dfef2 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- *  Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com
+ *  Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 #define pr_fmt(fmt) "udma: " fmt
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 166bd78ca501..6e9f93e9a302 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3,7 +3,7 @@
  * Texas Instruments System Control Interface Protocol Driver
  * Based on drivers/firmware/ti_sci.c from Linux.
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 101210eb2155..bb8bc7beeadb 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -6,7 +6,7 @@
  * The system works in a message response protocol
  * See: http://processors.wiki.ti.com/index.php/TISCI for details
  *
- * Copyright (C)  2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C)  2018 Texas Instruments Incorporated - https://www.ti.com/
  * Based on drivers/firmware/ti_sci.h from Linux.
  *
  */
diff --git a/drivers/firmware/ti_sci_static_data.h b/drivers/firmware/ti_sci_static_data.h
index 1a461fab6199..567ce8911a7d 100644
--- a/drivers/firmware/ti_sci_static_data.h
+++ b/drivers/firmware/ti_sci_static_data.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause */
 /*
- * Copyright (C)  2021 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C)  2021 Texas Instruments Incorporated - https://www.ti.com/
  *
  */
 
diff --git a/drivers/gpio/pcf8575_gpio.c b/drivers/gpio/pcf8575_gpio.c
index d5930d941fc0..f38e215c4d6e 100644
--- a/drivers/gpio/pcf8575_gpio.c
+++ b/drivers/gpio/pcf8575_gpio.c
@@ -2,7 +2,7 @@
 /*
  * PCF8575 I2C GPIO EXPANDER DRIVER
  *
- * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2016 Texas Instruments Incorporated - https://www.ti.com/
  *
  * Vignesh R <vigneshr@ti.com>
  *
diff --git a/drivers/mailbox/k3-sec-proxy.c b/drivers/mailbox/k3-sec-proxy.c
index e0a18d8a97d8..05f6b1795d64 100644
--- a/drivers/mailbox/k3-sec-proxy.c
+++ b/drivers/mailbox/k3-sec-proxy.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments' K3 Secure proxy Driver
  *
- * Copyright (C) 2017-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017-2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/drivers/memory/ti-gpmc.c b/drivers/memory/ti-gpmc.c
index f511a529b1e6..775e78c9a5bc 100644
--- a/drivers/memory/ti-gpmc.c
+++ b/drivers/memory/ti-gpmc.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments GPMC Driver
  *
- * Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <asm/io.h>
diff --git a/drivers/memory/ti-gpmc.h b/drivers/memory/ti-gpmc.h
index 90f8e656c8f8..6fe098af0eca 100644
--- a/drivers/memory/ti-gpmc.h
+++ b/drivers/memory/ti-gpmc.h
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments GPMC Driver
  *
- * Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /* GPMC register offsets */
diff --git a/drivers/misc/esm_pmic.c b/drivers/misc/esm_pmic.c
index b971f32f6a13..a518f750611a 100644
--- a/drivers/misc/esm_pmic.c
+++ b/drivers/misc/esm_pmic.c
@@ -2,7 +2,7 @@
 /*
  * PMIC Error Signal Monitor driver
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  *      Tero Kristo <t-kristo@ti.com>
  *
  */
diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
index 9a088244dd1e..0d29eff1ac08 100644
--- a/drivers/misc/k3_avs.c
+++ b/drivers/misc/k3_avs.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments' K3 Clas 0 Adaptive Voltage Scaling driver
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  *      Tero Kristo <t-kristo@ti.com>
  *
  */
diff --git a/drivers/misc/k3_esm.c b/drivers/misc/k3_esm.c
index 41faeb3d8582..f6ac18bdc757 100644
--- a/drivers/misc/k3_esm.c
+++ b/drivers/misc/k3_esm.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments' K3 Error Signalling Module driver
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  *      Tero Kristo <t-kristo@ti.com>
  *
  */
diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
index fd667aeafdaa..05595bdac393 100644
--- a/drivers/mmc/am654_sdhci.c
+++ b/drivers/mmc/am654_sdhci.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *
  * Texas Instruments' K3 SD Host Controller Interface
  */
diff --git a/drivers/mtd/hbmc-am654.c b/drivers/mtd/hbmc-am654.c
index c86e504da301..8161087b50c0 100644
--- a/drivers/mtd/hbmc-am654.c
+++ b/drivers/mtd/hbmc-am654.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 //
-// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+// Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
 // Author: Vignesh Raghavendra <vigneshr@ti.com>
 
 #include <common.h>
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 77eb9f352c69..3cb132dcffc5 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2013 Jagannadha Sutradharudu Teki, Xilinx Inc.
  * Copyright (C) 2016 Jagan Teki <jagan@openedev.com>
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/drivers/mux/mux-uclass.c b/drivers/mux/mux-uclass.c
index 8870305313ac..c98576ceb81b 100644
--- a/drivers/mux/mux-uclass.c
+++ b/drivers/mux/mux-uclass.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2017 Axentia Technologies AB
  * Author: Peter Rosin <peda@axentia.se>
  *
- * Copyright (C) 2017-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017-2018 Texas Instruments Incorporated - https://www.ti.com/
  * Jean-Jacques Hiblot <jjhiblot@ti.com>
  */
 
diff --git a/drivers/net/phy/et1011c.c b/drivers/net/phy/et1011c.c
index fa4831427d50..db879bc73f2f 100644
--- a/drivers/net/phy/et1011c.c
+++ b/drivers/net/phy/et1011c.c
@@ -3,7 +3,7 @@
  * ET1011C PHY driver
  *
  * Derived from Linux kernel driver by Chaithrika U S
- * Copyright (C) 2013, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2013, Texas Instruments, Incorporated - https://www.ti.com/
  */
 #include <config.h>
 #include <phy.h>
diff --git a/drivers/net/ti/Kconfig b/drivers/net/ti/Kconfig
index 02660e4fbb44..c75f41862853 100644
--- a/drivers/net/ti/Kconfig
+++ b/drivers/net/ti/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
 
 config DRIVER_TI_CPSW
 	bool "TI Common Platform Ethernet Switch"
diff --git a/drivers/net/ti/Makefile b/drivers/net/ti/Makefile
index 8d3808bb4b66..0ce0cf2828a6 100644
--- a/drivers/net/ti/Makefile
+++ b/drivers/net/ti/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
 
 obj-$(CONFIG_DRIVER_TI_CPSW) += cpsw.o cpsw-common.o cpsw_mdio.o
 obj-$(CONFIG_DRIVER_TI_EMAC) += davinci_emac.o
diff --git a/drivers/net/ti/cpsw.c b/drivers/net/ti/cpsw.c
index 877be7fca52d..9a5e9642df11 100644
--- a/drivers/net/ti/cpsw.c
+++ b/drivers/net/ti/cpsw.c
@@ -2,7 +2,7 @@
 /*
  * CPSW Ethernet Switch Driver
  *
- * Copyright (C) 2010-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2010-2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/drivers/net/ti/cpsw_mdio.c b/drivers/net/ti/cpsw_mdio.c
index ac791faa813d..74cc956785f7 100644
--- a/drivers/net/ti/cpsw_mdio.c
+++ b/drivers/net/ti/cpsw_mdio.c
@@ -2,7 +2,7 @@
 /*
  * CPSW MDIO generic driver for TI AMxx/K2x/EMAC devices.
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/drivers/net/ti/cpsw_mdio.h b/drivers/net/ti/cpsw_mdio.h
index 9b98763656f5..ddf65a4686d3 100644
--- a/drivers/net/ti/cpsw_mdio.h
+++ b/drivers/net/ti/cpsw_mdio.h
@@ -2,7 +2,7 @@
 /*
  * CPSW MDIO generic driver API for TI AMxx/K2x/EMAC devices.
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef CPSW_MDIO_H_
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 5d4de86e71ad..2e8723186c05 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
 # Written by Jean-Jacques Hiblot  <jjhiblot@ti.com>
 
 obj-y += allwinner/
diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index fc5044fd5d35..4bb8a0ca7f34 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -7,7 +7,7 @@
  * Copyright (c) 2018 Cadence Design Systems
  * Author: Alan Douglas <adouglas@cadence.com>
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  * Jean-Jacques Hiblot <jjhiblot@ti.com>
  *
  */
diff --git a/drivers/phy/keystone-usb-phy.c b/drivers/phy/keystone-usb-phy.c
index 6799e2323707..3bb9c0814c14 100644
--- a/drivers/phy/keystone-usb-phy.c
+++ b/drivers/phy/keystone-usb-phy.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  * Written by Jean-Jacques Hiblot  <jjhiblot@ti.com>
  */
 
diff --git a/drivers/phy/nop-phy.c b/drivers/phy/nop-phy.c
index d0904f4f075b..c53e3216d0fd 100644
--- a/drivers/phy/nop-phy.c
+++ b/drivers/phy/nop-phy.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  * Written by Jean-Jacques Hiblot  <jjhiblot@ti.com>
  */
 
diff --git a/drivers/phy/omap-usb2-phy.c b/drivers/phy/omap-usb2-phy.c
index 2a9604cdcc49..d3d38062ecf7 100644
--- a/drivers/phy/omap-usb2-phy.c
+++ b/drivers/phy/omap-usb2-phy.c
@@ -2,7 +2,7 @@
 /*
  * OMAP USB2 PHY LAYER
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com
  * Written by Jean-Jacques Hiblot <jjhiblot@ti.com>
  */
 
diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
index 22f2fe914877..0dcfe258bc44 100644
--- a/drivers/phy/phy-uclass.c
+++ b/drivers/phy/phy-uclass.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  * Written by Jean-Jacques Hiblot  <jjhiblot@ti.com>
  */
 
diff --git a/drivers/phy/sandbox-phy.c b/drivers/phy/sandbox-phy.c
index 7b3d988613bd..7e123da25fb4 100644
--- a/drivers/phy/sandbox-phy.c
+++ b/drivers/phy/sandbox-phy.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  * Written by Jean-Jacques Hiblot  <jjhiblot@ti.com>
  */
 
diff --git a/drivers/phy/ti-pipe3-phy.c b/drivers/phy/ti-pipe3-phy.c
index 313735844ab8..29a35ae5ffb9 100644
--- a/drivers/phy/ti-pipe3-phy.c
+++ b/drivers/phy/ti-pipe3-phy.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  * Written by Jean-Jacques Hiblot  <jjhiblot@ti.com>
  */
 
diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 72613399073e..daf62f5deda0 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017-2018 Texas Instruments Incorporated - https://www.ti.com/
  * Jean-Jacques Hiblot <jjhiblot@ti.com>
  */
 
diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domain/ti-power-domain.c
index 9e7151307c89..b34c982f4f5f 100644
--- a/drivers/power/domain/ti-power-domain.c
+++ b/drivers/power/domain/ti-power-domain.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments power domain driver
  *
- * Copyright (C) 2020-2021 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
  *	Tero Kristo <t-kristo@ti.com>
  */
 
diff --git a/drivers/power/domain/ti-sci-power-domain.c b/drivers/power/domain/ti-sci-power-domain.c
index 0140e5e52172..8d6abe13dbc6 100644
--- a/drivers/power/domain/ti-sci-power-domain.c
+++ b/drivers/power/domain/ti-sci-power-domain.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments System Control Interface (TI SCI) power domain driver
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Andreas Dannenberg <dannenberg@ti.com>
  *
  * Loosely based on Linux kernel ti_sci_pm_domains.c...
diff --git a/drivers/power/pmic/pmic_tps62362.c b/drivers/power/pmic/pmic_tps62362.c
index 59190d6f672c..6426d1488a5c 100644
--- a/drivers/power/pmic/pmic_tps62362.c
+++ b/drivers/power/pmic/pmic_tps62362.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * (C) Copyright 2014 Texas Instruments Incorporated -  http://www.ti.com
+ * (C) Copyright 2014 Texas Instruments Incorporated -  https://www.ti.com
  * Author: Felipe Balbi <balbi@ti.com>
  */
 
diff --git a/drivers/power/regulator/tps62360_regulator.c b/drivers/power/regulator/tps62360_regulator.c
index b9f4504539e8..7014b1982d00 100644
--- a/drivers/power/regulator/tps62360_regulator.c
+++ b/drivers/power/regulator/tps62360_regulator.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  *      Tero Kristo <t-kristo@ti.com>
  */
 
diff --git a/drivers/ram/k3-am654-ddrss.c b/drivers/ram/k3-am654-ddrss.c
index 4a8a6a90bfc8..cff8ffc89295 100644
--- a/drivers/ram/k3-am654-ddrss.c
+++ b/drivers/ram/k3-am654-ddrss.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments' AM654 DDRSS driver
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/drivers/ram/k3-am654-ddrss.h b/drivers/ram/k3-am654-ddrss.h
index c87f186291e7..9d03ae107503 100644
--- a/drivers/ram/k3-am654-ddrss.h
+++ b/drivers/ram/k3-am654-ddrss.h
@@ -2,7 +2,7 @@
 /*
  * AM654: DDRSS Register definitions and structures.
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  *
  */
diff --git a/drivers/ram/k3-ddrss/Makefile b/drivers/ram/k3-ddrss/Makefile
index ba5d9a2f4d30..823d18871781 100644
--- a/drivers/ram/k3-ddrss/Makefile
+++ b/drivers/ram/k3-ddrss/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright (C) 2019-2022 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2019-2022 Texas Instruments Incorporated - https://www.ti.com/
 #
 
 obj-$(CONFIG_K3_DDRSS) += k3-ddrss.o
diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 5b6089e8526a..a5c9b82cf1da 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments' K3 DDRSS driver
  *
- * Copyright (C) 2020-2021 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <common.h>
diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 27e4a60ff5b1..781de530aff1 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 # (C) Copyright 2015
-# Texas Instruments Incorporated - http://www.ti.com/
+# Texas Instruments Incorporated - https://www.ti.com/
 #
 
 menu "Remote Processor drivers"
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index fbe9c172bc04..e09ed1aa4d4b 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 # (C) Copyright 2015
-# Texas Instruments Incorporated - http://www.ti.com/
+# Texas Instruments Incorporated - https://www.ti.com/
 #
 
 obj-$(CONFIG_$(SPL_)REMOTEPROC) += rproc-uclass.o rproc-elf-loader.o
diff --git a/drivers/remoteproc/ipu_rproc.c b/drivers/remoteproc/ipu_rproc.c
index b4a06bc955a9..996e658e8718 100644
--- a/drivers/remoteproc/ipu_rproc.c
+++ b/drivers/remoteproc/ipu_rproc.c
@@ -2,7 +2,7 @@
 /*
  * IPU remoteproc driver for various SoCs
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  *	Angela Stegmaier  <angelabaker@ti.com>
  *	Venkateswara Rao Mandela <venkat.mandela@ti.com>
  *      Keerthy <j-keerthy@ti.com>
diff --git a/drivers/remoteproc/k3_system_controller.c b/drivers/remoteproc/k3_system_controller.c
index e2affe69c678..071de40fbd6f 100644
--- a/drivers/remoteproc/k3_system_controller.c
+++ b/drivers/remoteproc/k3_system_controller.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments' K3 System Controller Driver
  *
- * Copyright (C) 2017-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017-2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 924070a76b59..6ec55e27d9dd 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -2,7 +2,7 @@
 /*
  * PRU-RTU remoteproc driver for various SoCs
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Keerthy <j-keerthy@ti.com>
  */
 
diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
index ece534c3c0e3..28b362c887a6 100644
--- a/drivers/remoteproc/rproc-uclass.c
+++ b/drivers/remoteproc/rproc-uclass.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * (C) Copyright 2015
- * Texas Instruments Incorporated - http://www.ti.com/
+ * Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #define LOG_CATEGORY UCLASS_REMOTEPROC
diff --git a/drivers/remoteproc/sandbox_testproc.c b/drivers/remoteproc/sandbox_testproc.c
index d360cf3169ff..f76f68ebeb43 100644
--- a/drivers/remoteproc/sandbox_testproc.c
+++ b/drivers/remoteproc/sandbox_testproc.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * (C) Copyright 2015
- * Texas Instruments Incorporated - http://www.ti.com/
+ * Texas Instruments Incorporated - https://www.ti.com/
  */
 #define pr_fmt(fmt) "%s: " fmt, __func__
 #include <common.h>
diff --git a/drivers/remoteproc/ti_k3_arm64_rproc.c b/drivers/remoteproc/ti_k3_arm64_rproc.c
index 99f11000dfbf..767493c1383c 100644
--- a/drivers/remoteproc/ti_k3_arm64_rproc.c
+++ b/drivers/remoteproc/ti_k3_arm64_rproc.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments' K3 ARM64 Remoteproc driver
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  *
  */
diff --git a/drivers/remoteproc/ti_k3_dsp_rproc.c b/drivers/remoteproc/ti_k3_dsp_rproc.c
index 1a2e9dd1f585..576de4bb26e4 100644
--- a/drivers/remoteproc/ti_k3_dsp_rproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_rproc.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments' K3 DSP Remoteproc driver
  *
- * Copyright (C) 2018-2020 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018-2020 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  *	Suman Anna <s-anna@ti.com>
  */
diff --git a/drivers/remoteproc/ti_power_proc.c b/drivers/remoteproc/ti_power_proc.c
index 6887a3c8541f..f55df4a91195 100644
--- a/drivers/remoteproc/ti_power_proc.c
+++ b/drivers/remoteproc/ti_power_proc.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * (C) Copyright 2015-2016
- * Texas Instruments Incorporated - http://www.ti.com/
+ * Texas Instruments Incorporated - https://www.ti.com/
  */
 #define pr_fmt(fmt) "%s: " fmt, __func__
 #include <common.h>
diff --git a/drivers/remoteproc/ti_sci_proc.h b/drivers/remoteproc/ti_sci_proc.h
index 36351da63fcc..167a7143e831 100644
--- a/drivers/remoteproc/ti_sci_proc.h
+++ b/drivers/remoteproc/ti_sci_proc.h
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments TI-SCI Processor Controller Helper Functions
  *
- * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018-2019 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  *	Suman Anna <s-anna@ti.com>
  */
diff --git a/drivers/reset/reset-dra7.c b/drivers/reset/reset-dra7.c
index a9589d448dca..05101a94f9bc 100644
--- a/drivers/reset/reset-dra7.c
+++ b/drivers/reset/reset-dra7.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments DRA7 reset driver
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  * Author: Keerthy <j-keerthy@ti.com>
  */
 
diff --git a/drivers/reset/reset-ti-sci.c b/drivers/reset/reset-ti-sci.c
index f35332767b2b..fd654a08f13a 100644
--- a/drivers/reset/reset-ti-sci.c
+++ b/drivers/reset/reset-ti-sci.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments System Control Interface (TI SCI) reset driver
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Andreas Dannenberg <dannenberg@ti.com>
  *
  * Loosely based on Linux kernel reset-ti-sci.c...
diff --git a/drivers/serial/serial_omap.c b/drivers/serial/serial_omap.c
index 26310b0b7464..49ced8f9fae4 100644
--- a/drivers/serial/serial_omap.c
+++ b/drivers/serial/serial_omap.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments' OMAP serial driver
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/drivers/soc/soc-uclass.c b/drivers/soc/soc-uclass.c
index dfad32d80dbe..8b3044fed8d2 100644
--- a/drivers/soc/soc-uclass.c
+++ b/drivers/soc/soc-uclass.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * (C) Copyright 2020 - Texas Instruments Incorporated - http://www.ti.com/
+ * (C) Copyright 2020 - Texas Instruments Incorporated - https://www.ti.com/
  *	Dave Gerlach <d-gerlach@ti.com>
  */
 
diff --git a/drivers/soc/soc_sandbox.c b/drivers/soc/soc_sandbox.c
index 5c82ad84fc21..15fdd9930cb4 100644
--- a/drivers/soc/soc_sandbox.c
+++ b/drivers/soc/soc_sandbox.c
@@ -2,7 +2,7 @@
 /*
  * Sandbox driver for the SOC uclass
  *
- * (C) Copyright 2020 - Texas Instruments Incorporated - http://www.ti.com/
+ * (C) Copyright 2020 - Texas Instruments Incorporated - https://www.ti.com/
  * Dave Gerlach <d-gerlach@ti.com>
  */
 
diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
index b720131ae5df..355a5368dd45 100644
--- a/drivers/soc/soc_ti_k3.c
+++ b/drivers/soc/soc_ti_k3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
  *	Dave Gerlach <d-gerlach@ti.com>
  */
 
diff --git a/drivers/soc/ti/k3-navss-ringacc.c b/drivers/soc/ti/k3-navss-ringacc.c
index e02889649b28..7a2fbb0db6e8 100644
--- a/drivers/soc/ti/k3-navss-ringacc.c
+++ b/drivers/soc/ti/k3-navss-ringacc.c
@@ -2,7 +2,7 @@
 /*
  * TI K3 AM65x NAVSS Ring accelerator Manager (RA) subsystem driver
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #include <common.h>
diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 9ebc4ed48f0a..25f5e9fdebd5 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2009 Texas Instruments Incorporated - https://www.ti.com/
  *
  * Driver for SPI controller on DaVinci. Based on atmel_spi.c
  * by Atmel Corporation
diff --git a/drivers/spi/omap3_spi.c b/drivers/spi/omap3_spi.c
index ff7b55f8707e..5cce6baa6213 100644
--- a/drivers/spi/omap3_spi.c
+++ b/drivers/spi/omap3_spi.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2010 Dirk Behme <dirk.behme@googlemail.com>
  *
  * Driver for McSPI controller on OMAP3. Based on davinci_spi.c
- * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2009 Texas Instruments Incorporated - https://www.ti.com/
  *
  * Copyright (C) 2007 Atmel Corporation
  *
diff --git a/drivers/spi/spi-mem-nodm.c b/drivers/spi/spi-mem-nodm.c
index 77ddb19a9f32..6ee841358b34 100644
--- a/drivers/spi/spi-mem-nodm.c
+++ b/drivers/spi/spi-mem-nodm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <log.h>
diff --git a/drivers/sysreset/sysreset-ti-sci.c b/drivers/sysreset/sysreset-ti-sci.c
index 81bfd67ad990..5fc05c46cb07 100644
--- a/drivers/sysreset/sysreset-ti-sci.c
+++ b/drivers/sysreset/sysreset-ti-sci.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments System Control Interface (TI SCI) system reset driver
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Andreas Dannenberg <dannenberg@ti.com>
  */
 
diff --git a/drivers/thermal/ti-bandgap.c b/drivers/thermal/ti-bandgap.c
index 0b533d4c420a..0ea17a909dd7 100644
--- a/drivers/thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-bandgap.c
@@ -1,7 +1,7 @@
 /*
  * TI Bandgap temperature sensor driver
  *
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index 4f3344fd4e42..56a4b0776d34 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+# Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
 #
 
 obj-$(CONFIG_UFS) += ufs.o ufs-uclass.o
diff --git a/drivers/ufs/cdns-platform.c b/drivers/ufs/cdns-platform.c
index 1e62e252e7ae..9202b53989d6 100644
--- a/drivers/ufs/cdns-platform.c
+++ b/drivers/ufs/cdns-platform.c
@@ -2,7 +2,7 @@
 /**
  * cdns-platform.c - Platform driver for Cadence UFSHCI device
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #include <clk.h>
diff --git a/drivers/ufs/ti-j721e-ufs.c b/drivers/ufs/ti-j721e-ufs.c
index d875269760c1..1860e0dca299 100644
--- a/drivers/ufs/ti-j721e-ufs.c
+++ b/drivers/ufs/ti-j721e-ufs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <asm/io.h>
diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index ceea30c4a95c..e6478a9209b0 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -2,7 +2,7 @@
 /**
  * ufs-uclass.c - Universal Flash Subsystem (UFS) Uclass driver
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #define LOG_CATEGORY UCLASS_UFS
diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 7c48d57f99d6..346f0fd916f1 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -5,7 +5,7 @@
  * Taken from Linux Kernel v5.2 (drivers/scsi/ufs/ufshcd.c) and ported
  * to u-boot.
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #include <bouncebuf.h>
diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index 8958f0166bd5..92a7941ed152 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -2,7 +2,7 @@
 /**
  * cdns_ti-ti.c - TI specific Glue layer for Cadence USB Controller
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #include <common.h>
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7ca9d09824e6..3aec8b0d9418 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2,7 +2,7 @@
 /**
  * core.c - DesignWare USB3 DRD Controller Core file
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 532746dd88df..4162a6822989 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -2,7 +2,7 @@
 /**
  * core.h - DesignWare USB3 DRD Core Header
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index ff4ebfb4447f..4fadb4a3e200 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -2,7 +2,7 @@
 /**
  * dwc3-omap.c - OMAP Specific Glue layer
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 75ac993bc645..1133cf82b1ae 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -2,7 +2,7 @@
 /**
  * ep0.c - DesignWare USB3 DRD Controller Endpoint 0 Handling
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 68cf32cd189c..406d36ceafe4 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2,7 +2,7 @@
 /**
  * gadget.c - DesignWare USB3 DRD Controller Gadget Framework Link
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 7806ce59a27f..f28a9755dcb3 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -2,7 +2,7 @@
 /**
  * gadget.h - DesignWare USB3 DRD Gadget Header
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 2407f826c161..04791d4c9be4 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -2,7 +2,7 @@
 /**
  * io.h - DesignWare USB3 DRD IO Header
  *
- * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
diff --git a/drivers/usb/dwc3/linux-compat.h b/drivers/usb/dwc3/linux-compat.h
index 3bb0bda5a6bf..563f8727cdde 100644
--- a/drivers/usb/dwc3/linux-compat.h
+++ b/drivers/usb/dwc3/linux-compat.h
@@ -2,7 +2,7 @@
 /**
  * linux-compat.h - DesignWare USB3 Linux Compatibiltiy Adapter  Header
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Kishon Vijay Abraham I <kishon@ti.com>
  *
diff --git a/drivers/usb/dwc3/ti_usb_phy.c b/drivers/usb/dwc3/ti_usb_phy.c
index f476810763d1..8ae130860f79 100644
--- a/drivers/usb/dwc3/ti_usb_phy.c
+++ b/drivers/usb/dwc3/ti_usb_phy.c
@@ -2,7 +2,7 @@
 /**
  * ti_usb_phy.c - USB3 and USB3 PHY programming for dwc3
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
  *
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  *
diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 7f73926cb3e1..eb0b35969ce1 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -2,7 +2,7 @@
 /**
  * udc-core.c - Core UDC Framework
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
  *
  * Author: Felipe Balbi <balbi@ti.com>
  *
diff --git a/drivers/usb/gadget/udc/udc-uclass.c b/drivers/usb/gadget/udc/udc-uclass.c
index 3e433129ace7..30ee1cab0668 100644
--- a/drivers/usb/gadget/udc/udc-uclass.c
+++ b/drivers/usb/gadget/udc/udc-uclass.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com
  * Written by Jean-Jacques Hiblot <jjhiblot@ti.com>
  */
 
diff --git a/drivers/usb/host/dwc3-of-simple.c b/drivers/usb/host/dwc3-of-simple.c
index 66b3e96b0077..f9df59d2e5d7 100644
--- a/drivers/usb/host/dwc3-of-simple.c
+++ b/drivers/usb/host/dwc3-of-simple.c
@@ -2,7 +2,7 @@
 /*
  * dwc3-of-simple.c - OF glue layer for simple integrations
  *
- * Copyright (c) 2015 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (c) 2015 Texas Instruments Incorporated - https://www.ti.com
  *
  * Author: Felipe Balbi <balbi@ti.com>
  *
diff --git a/drivers/usb/ulpi/omap-ulpi-viewport.c b/drivers/usb/ulpi/omap-ulpi-viewport.c
index 8d71db04a2d7..1b01cd4c559f 100644
--- a/drivers/usb/ulpi/omap-ulpi-viewport.c
+++ b/drivers/usb/ulpi/omap-ulpi-viewport.c
@@ -3,7 +3,7 @@
  * OMAP ulpi viewport support
  * Based on drivers/usb/ulpi/ulpi-viewport.c
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com
  * Author: Govindraj R <govindraj.raja@ti.com>
  */
 
diff --git a/include/configs/am335x_evm.h b/include/configs/am335x_evm.h
index 504b1f02283e..67f46562539b 100644
--- a/include/configs/am335x_evm.h
+++ b/include/configs/am335x_evm.h
@@ -1,7 +1,7 @@
 /*
  * am335x_evm.h
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
diff --git a/include/configs/am335x_shc.h b/include/configs/am335x_shc.h
index ee6f62275a8c..dedef91ba590 100644
--- a/include/configs/am335x_shc.h
+++ b/include/configs/am335x_shc.h
@@ -6,7 +6,7 @@
  * Based on:
  * am335x_evm.h
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef __CONFIG_AM335X_SHC_H
diff --git a/include/configs/am43xx_evm.h b/include/configs/am43xx_evm.h
index 7ee7b7e4f4fb..983428920fa1 100644
--- a/include/configs/am43xx_evm.h
+++ b/include/configs/am43xx_evm.h
@@ -2,7 +2,7 @@
 /*
  * am43xx_evm.h
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef __CONFIG_AM43XX_EVM_H
diff --git a/include/configs/am65x_evm.h b/include/configs/am65x_evm.h
index 9e90239a1c18..811dc0ff1a81 100644
--- a/include/configs/am65x_evm.h
+++ b/include/configs/am65x_evm.h
@@ -2,7 +2,7 @@
 /*
  * Configuration header file for K3 AM654 EVM
  *
- * Copyright (C) 2017-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017-2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/include/configs/baltos.h b/include/configs/baltos.h
index e7946389eff3..cc54b514fffb 100644
--- a/include/configs/baltos.h
+++ b/include/configs/baltos.h
@@ -1,7 +1,7 @@
 /*
  * am335x_evm.h
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
diff --git a/include/configs/da850evm.h b/include/configs/da850evm.h
index cef404218ed4..416aa96366c5 100644
--- a/include/configs/da850evm.h
+++ b/include/configs/da850evm.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com/
  *
  * Based on davinci_dvevm.h. Original Copyrights follow:
  *
diff --git a/include/configs/draco.h b/include/configs/draco.h
index 4c67174572f3..8f993cee0a34 100644
--- a/include/configs/draco.h
+++ b/include/configs/draco.h
@@ -6,7 +6,7 @@
  * Based on:
  * U-Boot file:/include/configs/am335x_evm.h
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef __CONFIG_DRACO_H
diff --git a/include/configs/etamin.h b/include/configs/etamin.h
index d07b4e95364f..97585a4fd126 100644
--- a/include/configs/etamin.h
+++ b/include/configs/etamin.h
@@ -6,7 +6,7 @@
  * Based on:
  * U-Boot file:/include/configs/am335x_evm.h
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef __CONFIG_ETAMIN_H
diff --git a/include/configs/legoev3.h b/include/configs/legoev3.h
index ff966586ba65..a50f9480dd9a 100644
--- a/include/configs/legoev3.h
+++ b/include/configs/legoev3.h
@@ -4,7 +4,7 @@
  *
  * Based on da850evm.h
  *
- * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com/
  *
  * Based on davinci_dvevm.h. Original Copyrights follow:
  *
diff --git a/include/configs/omap3_evm.h b/include/configs/omap3_evm.h
index f44967787c97..2cb2e52ad251 100644
--- a/include/configs/omap3_evm.h
+++ b/include/configs/omap3_evm.h
@@ -2,7 +2,7 @@
 /*
  * Configuration settings for the TI OMAP3 EVM board.
  *
- * Copyright (C) 2006-2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2006-2011 Texas Instruments Incorporated - https://www.ti.com/
  *
  * Author :
  *	Manikandan Pillai <mani.pillai@ti.com>
diff --git a/include/configs/omapl138_lcdk.h b/include/configs/omapl138_lcdk.h
index fc2655a17b91..5b7eb0b69469 100644
--- a/include/configs/omapl138_lcdk.h
+++ b/include/configs/omapl138_lcdk.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com/
  *
  * Based on davinci_dvevm.h. Original Copyrights follow:
  *
diff --git a/include/configs/pdu001.h b/include/configs/pdu001.h
index 80b14b002a92..24d7dcd427c2 100644
--- a/include/configs/pdu001.h
+++ b/include/configs/pdu001.h
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 2018 EETS GmbH - http://www.eets.ch/
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef __CONFIG_PDU001_H
diff --git a/include/configs/phycore_am335x_r2.h b/include/configs/phycore_am335x_r2.h
index 8668da6eba5d..060a15096575 100644
--- a/include/configs/phycore_am335x_r2.h
+++ b/include/configs/phycore_am335x_r2.h
@@ -4,7 +4,7 @@
  *
  * Phytec phyCORE-AM335x R2 (PCL060 / PCM060) boards information header
  *
- * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
+ * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  * Copyright (C) 2013 Lars Poeschel, Lemonage Software GmbH
  * Copyright (C) 2019 DENX Software Engineering GmbH
  */
diff --git a/include/configs/pxm2.h b/include/configs/pxm2.h
index b701e52076db..040178baf846 100644
--- a/include/configs/pxm2.h
+++ b/include/configs/pxm2.h
@@ -7,7 +7,7 @@
  * Based on:
  * U-Boot file:/include/configs/am335x_evm.h
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef __CONFIG_PXM2_H
diff --git a/include/configs/rastaban.h b/include/configs/rastaban.h
index 2efb4d23cdda..0991ebfd00cd 100644
--- a/include/configs/rastaban.h
+++ b/include/configs/rastaban.h
@@ -6,7 +6,7 @@
  * Based on:
  * U-Boot file:/include/configs/am335x_evm.h
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef __CONFIG_RASTABAN_H
diff --git a/include/configs/rut.h b/include/configs/rut.h
index 4002bc4b6c88..7cc2bd5a3410 100644
--- a/include/configs/rut.h
+++ b/include/configs/rut.h
@@ -7,7 +7,7 @@
  * Based on:
  * U-Boot file:/include/configs/am335x_evm.h
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef __CONFIG_RUT_H
diff --git a/include/configs/siemens-am33x-common.h b/include/configs/siemens-am33x-common.h
index 7def657bcd1d..6b1d5caafb19 100644
--- a/include/configs/siemens-am33x-common.h
+++ b/include/configs/siemens-am33x-common.h
@@ -7,7 +7,7 @@
  * Based on:
  * U-Boot file:/include/configs/am335x_evm.h
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef __CONFIG_SIEMENS_AM33X_COMMON_H
diff --git a/include/configs/thuban.h b/include/configs/thuban.h
index a5913e1e7d2c..f4c04c55ebff 100644
--- a/include/configs/thuban.h
+++ b/include/configs/thuban.h
@@ -6,7 +6,7 @@
  * Based on:
  * U-Boot file:/include/configs/am335x_evm.h
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef __CONFIG_THUBAN_H
diff --git a/include/configs/ti_am335x_common.h b/include/configs/ti_am335x_common.h
index 20f8643771d8..c827a9cace9e 100644
--- a/include/configs/ti_am335x_common.h
+++ b/include/configs/ti_am335x_common.h
@@ -2,10 +2,10 @@
 /*
  * ti_am335x_common.h
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  *
  * For more details, please see the technical documents listed at
- * http://www.ti.com/product/am3359#technicaldocuments
+ * https://www.ti.com/product/am3359#technicaldocuments
  */
 
 #ifndef __CONFIG_TI_AM335X_COMMON_H__
diff --git a/include/configs/ti_armv7_common.h b/include/configs/ti_armv7_common.h
index 4e30d0d2ddf8..3def7b1027e5 100644
--- a/include/configs/ti_armv7_common.h
+++ b/include/configs/ti_armv7_common.h
@@ -2,7 +2,7 @@
 /*
  * ti_armv7_common.h
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  *
  * The various ARMv7 SoCs from TI all share a number of IP blocks when
  * implementing a given feature.  Rather than define these in every
diff --git a/include/configs/ti_armv7_omap.h b/include/configs/ti_armv7_omap.h
index d34042af4682..0b8b1ac8f9aa 100644
--- a/include/configs/ti_armv7_omap.h
+++ b/include/configs/ti_armv7_omap.h
@@ -2,7 +2,7 @@
 /*
  * ti_armv7_omap.h
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com/
  *
  * The various ARMv7 SoCs from TI all share a number of IP blocks when
  * implementing a given feature. This is meant to isolate the features
diff --git a/include/configs/ti_omap3_common.h b/include/configs/ti_omap3_common.h
index 36a05b6896ea..45f7179f0357 100644
--- a/include/configs/ti_omap3_common.h
+++ b/include/configs/ti_omap3_common.h
@@ -2,12 +2,12 @@
 /*
  * ti_omap3_common.h
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  *
  * For more details, please see the technical documents listed at
- *   http://www.ti.com/product/omap3530
- *   http://www.ti.com/product/omap3630
- *   http://www.ti.com/product/dm3730
+ *   https://www.ti.com/product/omap3530
+ *   https://www.ti.com/product/omap3630
+ *   https://www.ti.com/product/dm3730
  */
 
 #ifndef __CONFIG_TI_OMAP3_COMMON_H__
diff --git a/include/configs/ti_omap5_common.h b/include/configs/ti_omap5_common.h
index 4e5aa74147d4..26494ae98010 100644
--- a/include/configs/ti_omap5_common.h
+++ b/include/configs/ti_omap5_common.h
@@ -10,7 +10,7 @@
  * TI OMAP5 AND DRA7XX common configuration settings
  *
  * For more details, please see the technical documents listed at
- * http://www.ti.com/product/omap5432
+ * https://www.ti.com/product/omap5432
  */
 
 #ifndef __CONFIG_TI_OMAP5_COMMON_H
diff --git a/include/cpsw.h b/include/cpsw.h
index 786f8b385b75..5e0509923b57 100644
--- a/include/cpsw.h
+++ b/include/cpsw.h
@@ -1,7 +1,7 @@
 /*
  * CPSW Ethernet Switch Driver
  *
- * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
diff --git a/include/dt-bindings/pinctrl/dra.h b/include/dt-bindings/pinctrl/dra.h
index b543eebd2f0a..765c385f7b2c 100644
--- a/include/dt-bindings/pinctrl/dra.h
+++ b/include/dt-bindings/pinctrl/dra.h
@@ -1,7 +1,7 @@
 /*
  * This header provides constants for DRA pinctrl bindings.
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  * Author: Rajendra Nayak <rnayak@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
diff --git a/include/dt-bindings/reset/ti-syscon.h b/include/dt-bindings/reset/ti-syscon.h
index 884fd91df8e9..1427ff140f11 100644
--- a/include/dt-bindings/reset/ti-syscon.h
+++ b/include/dt-bindings/reset/ti-syscon.h
@@ -1,7 +1,7 @@
 /*
  * TI Syscon Reset definitions
  *
- * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff --git a/include/dwc3-omap-uboot.h b/include/dwc3-omap-uboot.h
index 9e0e717dc985..ed92bfc5a978 100644
--- a/include/dwc3-omap-uboot.h
+++ b/include/dwc3-omap-uboot.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* include/dwc3_omap_uboot.h
  *
- * Copyright (c) 2015 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (c) 2015 Texas Instruments Incorporated - https://www.ti.com
  *
  * Designware SuperSpeed OMAP Glue uboot init
  */
diff --git a/include/dwc3-uboot.h b/include/dwc3-uboot.h
index bb0436c09737..35cfbb93b294 100644
--- a/include/dwc3-uboot.h
+++ b/include/dwc3-uboot.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* include/dwc3-uboot.h
  *
- * Copyright (c) 2015 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (c) 2015 Texas Instruments Incorporated - https://www.ti.com
  *
  * Designware SuperSpeed USB uboot init
  */
diff --git a/include/env/ti/dfu.h b/include/env/ti/dfu.h
index 3c90570107e4..10bcf33c6305 100644
--- a/include/env/ti/dfu.h
+++ b/include/env/ti/dfu.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2016 Texas Instruments Incorporated - https://www.ti.com
  *
  * Environment variable definitions for DFU on TI boards.
  */
diff --git a/include/env/ti/k3_dfu.h b/include/env/ti/k3_dfu.h
index a16a3adecaf9..098f5f5dabd6 100644
--- a/include/env/ti/k3_dfu.h
+++ b/include/env/ti/k3_dfu.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  *
  * Environment variable definitions for DFU on TI K3 SoCs.
  *
diff --git a/include/env/ti/k3_rproc.h b/include/env/ti/k3_rproc.h
index 3418cb42be58..a467d751e2d2 100644
--- a/include/env/ti/k3_rproc.h
+++ b/include/env/ti/k3_rproc.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  *
  * rproc environment variable definitions for various TI K3 SoCs.
  */
diff --git a/include/env/ti/mmc.h b/include/env/ti/mmc.h
index 769ea9d5ef70..d07189baaf4f 100644
--- a/include/env/ti/mmc.h
+++ b/include/env/ti/mmc.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com
  *
  * Environment variable definitions for MMC/SD on TI boards.
  */
diff --git a/include/env/ti/nand.h b/include/env/ti/nand.h
index 7d00afa2b10f..0e0da458b90b 100644
--- a/include/env/ti/nand.h
+++ b/include/env/ti/nand.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  *
  * Environment variable definitions for NAND on TI boards.
  */
diff --git a/include/env/ti/ufs.h b/include/env/ti/ufs.h
index 6619ec9c88ed..c192f3aee185 100644
--- a/include/env/ti/ufs.h
+++ b/include/env/ti/ufs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  *
  * Environment variable definitions for UFS on TI boards.
  */
diff --git a/include/generic-phy.h b/include/generic-phy.h
index bee4de8a0baa..eaab7491660d 100644
--- a/include/generic-phy.h
+++ b/include/generic-phy.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  * Written by Jean-Jacques Hiblot  <jjhiblot@ti.com>
  */
 
diff --git a/include/k3-avs.h b/include/k3-avs.h
index e3c3cafbb9d9..1014d5d114d0 100644
--- a/include/k3-avs.h
+++ b/include/k3-avs.h
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments' K3 Adaptive Voltage Scaling driver
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  *      Tero Kristo <t-kristo@ti.com>
  *
  */
diff --git a/include/k3-clk.h b/include/k3-clk.h
index 49ba53d20f79..1b6ab8fe6540 100644
--- a/include/k3-clk.h
+++ b/include/k3-clk.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * (C) Copyright 2020-2021 Texas Instruments Incorporated - http://www.ti.com
+ * (C) Copyright 2020-2021 Texas Instruments Incorporated - https://www.ti.com
  *      Tero Kristo <t-kristo@ti.com>
  */
 
diff --git a/include/k3-dev.h b/include/k3-dev.h
index d288ae3be738..072e10ba6321 100644
--- a/include/k3-dev.h
+++ b/include/k3-dev.h
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments K3 Device Platform Data
  *
- * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
  */
 #ifndef __K3_DEV_H__
 #define __K3_DEV_H__
diff --git a/include/linux/soc/ti/cppi5.h b/include/linux/soc/ti/cppi5.h
index 3a55c3ec46f5..c5d7ebd05d78 100644
--- a/include/linux/soc/ti/cppi5.h
+++ b/include/linux/soc/ti/cppi5.h
@@ -2,7 +2,7 @@
 /*
  * CPPI5 descriptors interface
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #ifndef __TI_CPPI5_H__
diff --git a/include/linux/soc/ti/k3-navss-ringacc.h b/include/linux/soc/ti/k3-navss-ringacc.h
index 0ad8f203da1a..30fb903d9725 100644
--- a/include/linux/soc/ti/k3-navss-ringacc.h
+++ b/include/linux/soc/ti/k3-navss-ringacc.h
@@ -2,7 +2,7 @@
 /*
  * TI K3 AM65x NAVSS Ring accelerator Manager (RA) subsystem driver
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #ifndef __SOC_TI_K3_NAVSS_RINGACC_API_H_
diff --git a/include/linux/soc/ti/k3-sec-proxy.h b/include/linux/soc/ti/k3-sec-proxy.h
index f34854ceebc7..c3a83f163d76 100644
--- a/include/linux/soc/ti/k3-sec-proxy.h
+++ b/include/linux/soc/ti/k3-sec-proxy.h
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments' K3 Secure proxy
  *
- * Copyright (C) 2017-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017-2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  *
  */
diff --git a/include/linux/soc/ti/ti-udma.h b/include/linux/soc/ti/ti-udma.h
index 04e354fb2d69..89faf69242f3 100644
--- a/include/linux/soc/ti/ti-udma.h
+++ b/include/linux/soc/ti/ti-udma.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- *  Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com
+ *  Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 7f9941894cdf..8e4c43cef311 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -3,7 +3,7 @@
  * Texas Instruments System Control Interface Protocol
  * Based on include/linux/soc/ti/ti_sci_protocol.h from Linux.
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Nishanth Menon
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
diff --git a/include/linux/usb/dwc3-omap.h b/include/linux/usb/dwc3-omap.h
index 62180e3973bd..d5737ed7e882 100644
--- a/include/linux/usb/dwc3-omap.h
+++ b/include/linux/usb/dwc3-omap.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /* include/linux/usb/dwc3-omap.h
  *
- * Copyright (c) 2014 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (c) 2014 Texas Instruments Incorporated - https://www.ti.com
  *
  * Designware SuperSpeed Glue
  */
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index 5d0dac950efe..e7e3d259cae5 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /* include/linux/usb/otg.h
  *
- * Copyright (c) 2015 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (c) 2015 Texas Instruments Incorporated - https://www.ti.com
  *
  * USB OTG (On The Go) defines
  */
diff --git a/include/mux-internal.h b/include/mux-internal.h
index 93e3a5cdd749..67fa28933c71 100644
--- a/include/mux-internal.h
+++ b/include/mux-internal.h
@@ -5,7 +5,7 @@
  * Copyright (C) 2017 Axentia Technologies AB
  * Author: Peter Rosin <peda@axentia.se>
  *
- * Copyright (C) 2017-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017-2018 Texas Instruments Incorporated - https://www.ti.com/
  * Jean-Jacques Hiblot <jjhiblot@ti.com>
  */
 
diff --git a/include/mux.h b/include/mux.h
index c92d887591e2..e5deaba66f44 100644
--- a/include/mux.h
+++ b/include/mux.h
@@ -10,7 +10,7 @@
  * Copyright (C) 2017 Axentia Technologies AB
  * Author: Peter Rosin <peda@axentia.se>
  *
- * Copyright (C) 2017-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017-2018 Texas Instruments Incorporated - https://www.ti.com/
  * Jean-Jacques Hiblot <jjhiblot@ti.com>
  */
 
diff --git a/include/power/tps62362.h b/include/power/tps62362.h
index f0fc538463cb..df06c28fed61 100644
--- a/include/power/tps62362.h
+++ b/include/power/tps62362.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * (C) Copyright 2014 Texas Instruments Incorporated - http://www.ti.com
+ * (C) Copyright 2014 Texas Instruments Incorporated - https://www.ti.com
  * Author: Felipe Balbi <balbi@ti.com>
  */
 
diff --git a/include/power/tps65217.h b/include/power/tps65217.h
index 669a94a6c874..7862b31bfb97 100644
--- a/include/power/tps65217.h
+++ b/include/power/tps65217.h
@@ -3,7 +3,7 @@
  * (C) Copyright 2011-2013
  * Texas Instruments, <www.ti.com>
  *
- * For more details, please see the TRM at http://www.ti.com/product/tps65217a
+ * For more details, please see the TRM at https://www.ti.com/product/tps65217a
  */
 
 #ifndef __POWER_TPS65217_H__
diff --git a/include/power/tps65910.h b/include/power/tps65910.h
index 21b2a21ee049..ccc759acf66b 100644
--- a/include/power/tps65910.h
+++ b/include/power/tps65910.h
@@ -3,7 +3,7 @@
  * (C) Copyright 2011-2013
  * Texas Instruments, <www.ti.com>
  *
- * For more details, please see the TRM at http://www.ti.com/product/tps65910
+ * For more details, please see the TRM at https://www.ti.com/product/tps65910
  */
 #ifndef __POWER_TPS65910_H__
 #define __POWER_TPS65910_H__
diff --git a/include/remoteproc.h b/include/remoteproc.h
index f48054de6ba9..a11dc8a9b6c9 100644
--- a/include/remoteproc.h
+++ b/include/remoteproc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * (C) Copyright 2015
- * Texas Instruments Incorporated - http://www.ti.com/
+ * Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef _RPROC_H_
diff --git a/include/soc.h b/include/soc.h
index a52a300a84a6..850db28b76a3 100644
--- a/include/soc.h
+++ b/include/soc.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * (C) Copyright 2020 - Texas Instruments Incorporated - http://www.ti.com/
+ * (C) Copyright 2020 - Texas Instruments Incorporated - https://www.ti.com/
  *	Dave Gerlach <d-gerlach@ti.com>
  */
 
diff --git a/include/ti-usb-phy-uboot.h b/include/ti-usb-phy-uboot.h
index cd2ba4047744..feeddb865296 100644
--- a/include/ti-usb-phy-uboot.h
+++ b/include/ti-usb-phy-uboot.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /* include/ti_usb_phy_uboot.h
  *
- * Copyright (c) 2014 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (c) 2014 Texas Instruments Incorporated - https://www.ti.com
  *
  * USB2 and USB3 PHY uboot init
  */
diff --git a/scripts/Makefile.spl b/scripts/Makefile.spl
index 32f4384657b1..e450ffd5d5ef 100644
--- a/scripts/Makefile.spl
+++ b/scripts/Makefile.spl
@@ -7,7 +7,7 @@
 # Daniel Schwierzeck, daniel.schwierzeck@googlemail.com.
 #
 # (C) Copyright 2011
-# Texas Instruments Incorporated - http://www.ti.com/
+# Texas Instruments Incorporated - https://www.ti.com/
 # Aneesh V <aneesh@ti.com>
 # Based on top-level Makefile.
 #
diff --git a/test/dm/mux-emul.c b/test/dm/mux-emul.c
index 58233edc9b29..c6aeeb7e1f1b 100644
--- a/test/dm/mux-emul.c
+++ b/test/dm/mux-emul.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
  * Pratyush Yadav <p.yadav@ti.com>
  */
 #include <common.h>
diff --git a/test/dm/mux-mmio.c b/test/dm/mux-mmio.c
index fd353d8b155e..27c881dabde2 100644
--- a/test/dm/mux-mmio.c
+++ b/test/dm/mux-mmio.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017-2018 Texas Instruments Incorporated - https://www.ti.com/
  * Jean-Jacques Hiblot <jjhiblot@ti.com>
  */
 
diff --git a/test/dm/nop.c b/test/dm/nop.c
index 75b9e7b6cc0b..f7d9a0f3df35 100644
--- a/test/dm/nop.c
+++ b/test/dm/nop.c
@@ -2,7 +2,7 @@
 /*
  * Test for the NOP uclass
  *
- * (C) Copyright 2019 - Texas Instruments Incorporated - http://www.ti.com/
+ * (C) Copyright 2019 - Texas Instruments Incorporated - https://www.ti.com/
  * Jean-Jacques Hiblot <jjhiblot@ti.com>
  */
 
diff --git a/test/dm/phy.c b/test/dm/phy.c
index 4f91abca3a02..0cf3689fdecb 100644
--- a/test/dm/phy.c
+++ b/test/dm/phy.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  * Written by Jean-Jacques Hiblot  <jjhiblot@ti.com>
  */
 
diff --git a/test/dm/remoteproc.c b/test/dm/remoteproc.c
index 7a8ff47fa148..f6f9e509e27a 100644
--- a/test/dm/remoteproc.c
+++ b/test/dm/remoteproc.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * (C) Copyright 2015
- * Texas Instruments Incorporated - http://www.ti.com/
+ * Texas Instruments Incorporated - https://www.ti.com/
  */
 #include <common.h>
 #include <dm.h>
diff --git a/test/dm/soc.c b/test/dm/soc.c
index 17e1b5ba0127..8f6c97fa7908 100644
--- a/test/dm/soc.c
+++ b/test/dm/soc.c
@@ -2,7 +2,7 @@
 /*
  * Test for the SOC uclass
  *
- * (C) Copyright 2020 - Texas Instruments Incorporated - http://www.ti.com/
+ * (C) Copyright 2020 - Texas Instruments Incorporated - https://www.ti.com/
  *	Dave Gerlach <d-gerlach@ti.com>
  */
 
-- 
2.40.0

