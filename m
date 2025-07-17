Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F024AC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 07:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E578833C6;
	Thu, 17 Jul 2025 09:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD561833C7; Thu, 17 Jul 2025 09:03:11 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D07F833B3
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 09:03:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 56H72xEQ015452
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 17 Jul 2025 15:02:59 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Jul
 2025 15:02:59 +0800
Date: Thu, 17 Jul 2025 15:02:56 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <rick@andestech.com>, <ycliang@andestech.com>, <u-boot@lists.denx.de>
Subject: [PULL] u-boot-riscv/master
Message-ID: <aHigIDCHNSqEt2e3@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 56H72xEQ015452
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

The following changes since commit 3b4604a40b9fd61b87e9d059fc56f04d36f1a380:

  board: vexpress_ca9x4: Enable D-cache and MMU (2025-07-16 10:56:28 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to 18c6e8cd69f60b987292fb2ac00431de6e357c9b:

  configs: th1520_lpi4a: Enable network support (2025-07-17 14:37:40 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/27087
----------------------------------------------------------------
- Board: mpfs_icicle: Fix board_fit_config_name_match and disable DEBUG_UART
- Board: Add SD card support to the Beagle-V-Fire
- Board: Add support for TH1520-integrated GMACs
----------------------------------------------------------------
Conor Dooley (2):
      board: mpfs_icicle: fix board_fit_config_name_match()
      configs: microchip_mpfs_icicle: disable DEBUG_UART

Eoin Dickson (2):
      gpio: add PolarFire SoC GPIO and Core GPIO driver
      spi: coreqspi: add xfer function for PolarFire SoC

Yao Zi (5):
      clk: thead: th1520-ap: Correctly handle flags for dividers
      riscv: cpu: th1520: Limit upper RAM boundary to 4 GiB
      drivers: net: Add T-Head DWMAC glue layer
      riscv: dts: th1520: Describe GMACs and enable them on Lichee Pi 4A
      configs: th1520_lpi4a: Enable network support

 MAINTAINERS                                 |   1 +
 arch/riscv/cpu/th1520/dram.c                |  16 ++
 arch/riscv/dts/th1520-lichee-module-4a.dtsi | 119 ++++++++++++
 arch/riscv/dts/th1520.dtsi                  |  42 ++++
 board/microchip/mpfs_icicle/mpfs_icicle.c   |  11 +-
 configs/microchip_mpfs_icicle_defconfig     |   1 +
 configs/th1520_lpi4a_defconfig              |   7 +-
 drivers/clk/thead/clk-th1520-ap.c           |   4 +-
 drivers/gpio/Kconfig                        |   5 +
 drivers/gpio/Makefile                       |   1 +
 drivers/gpio/mpfs_gpio.c                    | 198 +++++++++++++++++++
 drivers/net/Kconfig                         |   8 +
 drivers/net/Makefile                        |   1 +
 drivers/net/dwmac_thead.c                   | 288 ++++++++++++++++++++++++++++
 drivers/spi/microchip_coreqspi.c            | 113 ++++++++++-
 15 files changed, 810 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpio/mpfs_gpio.c
 create mode 100644 drivers/net/dwmac_thead.c

 Best regards,
 Leo
