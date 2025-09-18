Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A256ACAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 17:37:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 874BB8309A;
	Thu, 18 Sep 2025 19:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BMtKTGx7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 565518319C; Thu, 18 Sep 2025 19:37:14 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 858A482C84
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 19:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58IHb90C532099
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 12:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758217029;
 bh=Tbp0ehUTnuVKMYyrD0J5yICCePL8IAKtU7arHlZ6F/k=;
 h=From:To:CC:Subject:Date;
 b=BMtKTGx7pbGGmTClOJs5691E0rVde5Kp7SF5dYqCqvOMIzlJk94SRg5ucB3eJJCk2
 Mi0YSDDMR8VTNIJ73+V3tz4Ub/v10rgoomJE/sk1bACTl6TN5ZJ4/Fq/vEW0M7ptGw
 RZfeHwWy4U0klnwaAm/5oczunOQiTVLIg23qSmio=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58IHb9Uq2278753
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 12:37:09 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 18
 Sep 2025 12:37:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Sep 2025 12:37:08 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58IHb7Lx1245072;
 Thu, 18 Sep 2025 12:37:08 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <bb@ti.com>, <khasim@ti.com>, <v-singh1@ti.com>,
 <afd@ti.com>, <anshuld@ti.com>
Subject: [RFC PATCH v3 0/1] Add initial support for AM62D2-EVM
Date: Thu, 18 Sep 2025 23:07:00 +0530
Message-ID: <20250918173701.138803-1-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

The AM62D2 SoC, part of the K3 architecture, is built for high-performance
DSP tasks in automotive audio, pro audio, radar, sonar, and medical
imaging. It features up to four Cortex-A53 cores (1.4GHz), two Cortex-R5F
cores, and a C7x DSP with 2 TOPS MMA. Key interfaces include multi-channel
McASP audio, TSN-capable Gigabit Ethernet, and a range of peripherals
(UART, SPI, I2C, CAN, USB, eMMC/SD, OSPI, CSI). It supports LPDDR4/DDR4,
secure boot with hardware security, and low-power modes with
CAN/GPIO/UART wakeup.

AM62D2-EVM evaluation module (EVM) is a low-cost expandable platform
board designed for AM62D2 SoC from TI. It supports the following
interfaces:

* 4 GB LPDDR4 RAM
* x2 Gigabit Ethernet expansion connectors
* x4 3.5mm TRS Audio Jack Line In
* x4 3.5mm TRS Audio Jack Line Out
* x2 Audio expansion connectors
* x1 Type-A USB 2.0, x1 Type-C dual-role device (DRD) USB 2.0
* x1 UHS-1 capable micro SD card slot
* 32 GB eMMC Flash
* 512 Mb OSPI NOR flash
* x4 UARTs via USB 2.0-B
* XDS110 for onboard JTAG debug using USB
* Temperature sensors, user push buttons and LEDs

Also resuse Soc specific files from AM62A. A key distinction from AM62A
is that the AM62D does not include multimedia components such as the
video encoder/decoder, MJPEG encoder, Vision Processing Accelerator
(VPAC) for image signal processing, or the display subsystem.
Additionally, the AM62D has a different pin configuration compared to
the AM62A.

Technical Reference Manual - https://www.ti.com/lit/pdf/sprujd4
Schematics Link - https://www.ti.com/lit/zip/sprcal5

Branch used-next

Kernel Patch
https://lore.kernel.org/all/20250708085839.1498505-1-p-bhagat@ti.com/

Boot Logs
https://gist.github.com/paresh-bhagat12/6e169340c222427c7648b1ef3ca5067f

Change Log:
	v2->v3:
		- Squash commits.
		- Reuse yaml files from am62d.

	v1->v2:
		- Restruture the commits (verified am62a build for each)
		- Removed unsigned nodes from binman dts.

v2-https://lore.kernel.org/all/20250909053429.444854-1-p-bhagat@ti.com/
v1-https://lore.kernel.org/all/20250902060703.191688-1-p-bhagat@ti.com/

Paresh Bhagat (1):
  Add initial support for AM62D2-EVM

 arch/arm/dts/Makefile                        |    2 +
 arch/arm/dts/k3-am62d-ddr-1866mhz-32bit.dtsi | 2802 ++++++++++++++++++
 arch/arm/dts/k3-am62d-evm-binman.dtsi        |  314 ++
 arch/arm/dts/k3-am62d2-evm-u-boot.dtsi       |   13 +
 arch/arm/dts/k3-am62d2-r5-evm.dts            |   82 +
 arch/arm/mach-k3/am62ax/Kconfig              |   21 +
 board/ti/am62dx/Kconfig                      |   26 +
 board/ti/am62dx/MAINTAINERS                  |    8 +
 board/ti/am62dx/Makefile                     |    7 +
 board/ti/am62dx/am62dx.env                   |   21 +
 board/ti/am62dx/evm.c                        |   37 +
 configs/am62dx_evm_a53_defconfig             |   22 +
 configs/am62dx_evm_r5_defconfig              |   20 +
 13 files changed, 3375 insertions(+)
 create mode 100644 arch/arm/dts/k3-am62d-ddr-1866mhz-32bit.dtsi
 create mode 100644 arch/arm/dts/k3-am62d-evm-binman.dtsi
 create mode 100644 arch/arm/dts/k3-am62d2-evm-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am62d2-r5-evm.dts
 create mode 100644 board/ti/am62dx/Kconfig
 create mode 100644 board/ti/am62dx/MAINTAINERS
 create mode 100644 board/ti/am62dx/Makefile
 create mode 100644 board/ti/am62dx/am62dx.env
 create mode 100644 board/ti/am62dx/evm.c
 create mode 100644 configs/am62dx_evm_a53_defconfig
 create mode 100644 configs/am62dx_evm_r5_defconfig

-- 
2.34.1

