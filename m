Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2084AC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 06:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 409B381E06;
	Tue,  3 Jun 2025 08:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACE0281E72; Tue,  3 Jun 2025 08:45:42 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F84880F0E
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 08:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 5536jTjq052659
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Tue, 3 Jun 2025 14:45:29 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 14:45:29 +0800
Date: Tue, 3 Jun 2025 14:45:21 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>, <ycliang@andestech.com>
Subject: [PULL] u-boot-riscv/next
Message-ID: <aD6aAdsMpatCgcIn@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5536jTjq052659
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

The following changes since commit d45b1d4ac94710f88902adc2173d7930700e2869:

  Merge tag 'u-boot-dfu-next-20250602' of https://source.denx.de/u-boot/custodians/u-boot-dfu into next (2025-06-02 08:43:10 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git next

for you to fetch changes up to b911af6d60d3be570469b92df751874dc376336b:

  MAINTAINERS: riscv: cpu: th1520: Assign myself as maintainer (2025-06-03 14:17:46 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/26483
----------------------------------------------------------------
- board: Convert Lichee Pi 4A to use S-Mode proper U-Boot
- RISC-V: configs: Raise SPL_SYS_MALLOC_SIZE to 8 MiB
- driver: Add SD card support to the Beagle-V-Fire
- MAINTAINERS: Add Yao Zi as maintainer for th1520
----------------------------------------------------------------
Eoin Dickson (2):
      gpio: add PolarFire SoC GPIO and Core GPIO driver
      spi: coreqspi: add xfer function for PolarFire SoC

Heinrich Schuchardt (1):
      configs: raise SPL_SYS_MALLOC_SIZE to 8 MiB on RISC-V

Yao Zi (6):
      riscv: cpu: th1520: Build spl.c for SPL only
      riscv: cpu: th1520: Support cache enabling/disabling in M mode only
      riscv: dts: th1520: Prepare binman configuration for loading OpenSBI
      board: thead: licheepi4a: Run proper U-Boot in S-Mode
      doc: thead: lpi4a: Update for S-Mode proper U-Boot support
      MAINTAINERS: riscv: cpu: th1520: Assign myself as maintainer

 MAINTAINERS                             |   7 ++
 arch/riscv/cpu/th1520/Makefile          |   2 +-
 arch/riscv/cpu/th1520/cache.c           |   2 +
 arch/riscv/dts/thead-th1520-binman.dtsi |  32 +++++-
 common/spl/Kconfig                      |   2 +-
 configs/starfive_visionfive2_defconfig  |   1 -
 configs/th1520_lpi4a_defconfig          |   2 +-
 configs/xilinx_mbv32_defconfig          |   1 -
 configs/xilinx_mbv32_smode_defconfig    |   1 -
 configs/xilinx_mbv64_defconfig          |   1 -
 configs/xilinx_mbv64_smode_defconfig    |   1 -
 doc/board/thead/lpi4a.rst               | 125 ++++++--------------
 drivers/gpio/Kconfig                    |   5 +
 drivers/gpio/Makefile                   |   1 +
 drivers/gpio/mpfs_gpio.c                | 198 ++++++++++++++++++++++++++++++++
 drivers/spi/microchip_coreqspi.c        | 113 +++++++++++++++++-
 16 files changed, 391 insertions(+), 103 deletions(-)
 create mode 100644 drivers/gpio/mpfs_gpio.c

Best regards,
Leo
