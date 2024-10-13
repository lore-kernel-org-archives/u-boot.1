Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FCFCF2591
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 23:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCD8B88FD8;
	Mon, 14 Oct 2024 01:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA9C089030; Mon, 14 Oct 2024 01:46:27 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3CEF288FB3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 01:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A099DA7;
 Sun, 13 Oct 2024 16:46:53 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B36F73F58B;
 Sun, 13 Oct 2024 16:46:22 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Pull request: u-boot-sunxi/master for 2025.01
Date: Mon, 14 Oct 2024 00:45:31 +0100
Message-ID: <20241013234531.9990-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
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

please pull the first sunxi changes for this cycle:

This switches all boards with the Allwinner H616/H618/H313/H700 SoCs over to
use OF_UPSTREAM. We are doing it for this SoC family only since the DTs
between the U-Boot and the kernel repo are exactly identical, whereas other
families have one compatibility fix in U-Boot to allow booting older kernels.
Other will follow if this plays out well.

The biggest chunk otherwise is adding support for an Anbernic game console,
using the H700 SoC. For that we need to enhance the DRAM support code, and
pick two DT commits from the mainline kernel/DT rebasing repo, followed
by the defconfig patch.

On top of that two small fixes for the old Allwinner A80.

Gitlab CI passed, and I booted that briefly on some boards, including an
H616 and an H618 one (with LPDDR4).

Thanks,
Andre

===========================================================
The following changes since commit f8efc68b30e29360f7a419fe4968432179d7368b:

  Merge patch series "spi-nor: Add parallel and stacked memories support" (2024-10-09 09:02:22 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sunxi.git master

for you to fetch changes up to 2f7ab49644ed38b6e3fe5eb6cd3f7e3f683fc6a7:

  sunxi: Add support for Anbernic RG35XX-2024 (2024-10-10 00:43:51 +0100)

----------------------------------------------------------------
Andre Przywara (3):
      sunxi: H616: switch to OF_UPSTREAM
      clk: sunxi: a80: Fix reset description
      sunxi: power: axp809: Fix DCDC4 programming

Chris Morgan (4):
      sunxi: H616: DRAM: Add alternative pin mapping
      arm64: dts: allwinner: h616: Change RG35XX Series from r_rsb to r_i2c
      arm64: dts: allwinner: h616: Add r_i2c pinctrl nodes
      sunxi: Add support for Anbernic RG35XX-2024

Jernej Skrabec (4):
      sunxi: H616: dram: LPDDR4: adjust settings
      sunxi: H616: DRAM: Adjust configuration procedure
      sunxi: H616: DRAM: Adjust size scan procedure
      sunxi: H616: dram: Update mbus priorities

 arch/arm/dts/Makefile                              |   7 -
 arch/arm/dts/sun50i-h313-tanix-tx1.dts             | 183 ----
 arch/arm/dts/sun50i-h616-bigtreetech-cb1-manta.dts |  35 -
 arch/arm/dts/sun50i-h616-bigtreetech-cb1.dtsi      | 143 ----
 arch/arm/dts/sun50i-h616-bigtreetech-pi.dts        |  63 --
 arch/arm/dts/sun50i-h616-cpu-opp.dtsi              | 115 ---
 arch/arm/dts/sun50i-h616-orangepi-zero.dtsi        | 131 ---
 arch/arm/dts/sun50i-h616-orangepi-zero2.dts        | 145 ----
 arch/arm/dts/sun50i-h616-x96-mate.dts              | 207 -----
 arch/arm/dts/sun50i-h616.dtsi                      | 930 ---------------------
 arch/arm/dts/sun50i-h618-longan-module-3h.dtsi     |  80 --
 arch/arm/dts/sun50i-h618-longanpi-3h.dts           | 144 ----
 arch/arm/dts/sun50i-h618-orangepi-zero2w.dts       | 181 ----
 arch/arm/dts/sun50i-h618-orangepi-zero3.dts        | 101 ---
 arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts     | 189 -----
 arch/arm/dts/sun50i-h700-anbernic-rg35xx-2024.dts  | 327 --------
 arch/arm/dts/sun50i-h700-anbernic-rg35xx-h.dts     |  36 -
 arch/arm/dts/sun50i-h700-anbernic-rg35xx-plus.dts  |  53 --
 arch/arm/mach-sunxi/Kconfig                        |  18 +
 arch/arm/mach-sunxi/dram_sun50i_h616.c             | 137 ++-
 .../arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c |   2 +-
 board/sunxi/MAINTAINERS                            |   5 +
 configs/anbernic_rg35xx_h700_defconfig             |  27 +
 configs/orangepi_zero2_defconfig                   |   2 +-
 configs/orangepi_zero2w_defconfig                  |   2 +-
 configs/orangepi_zero3_defconfig                   |   2 +-
 configs/tanix_tx1_defconfig                        |   2 +-
 configs/transpeed-8k618-t_defconfig                |   2 +-
 configs/x96_mate_defconfig                         |   2 +-
 drivers/clk/sunxi/clk_a80.c                        |   8 +-
 drivers/power/axp809.c                             |   2 +-
 dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi  |   2 +
 .../allwinner/sun50i-h700-anbernic-rg35xx-2024.dts |   6 +-
 include/dt-bindings/clock/sun50i-h616-ccu.h        | 116 ---
 include/dt-bindings/reset/sun50i-h616-ccu.h        |  70 --
 35 files changed, 159 insertions(+), 3316 deletions(-)
 delete mode 100644 arch/arm/dts/sun50i-h313-tanix-tx1.dts
 delete mode 100644 arch/arm/dts/sun50i-h616-bigtreetech-cb1-manta.dts
 delete mode 100644 arch/arm/dts/sun50i-h616-bigtreetech-cb1.dtsi
 delete mode 100644 arch/arm/dts/sun50i-h616-bigtreetech-pi.dts
 delete mode 100644 arch/arm/dts/sun50i-h616-cpu-opp.dtsi
 delete mode 100644 arch/arm/dts/sun50i-h616-orangepi-zero.dtsi
 delete mode 100644 arch/arm/dts/sun50i-h616-orangepi-zero2.dts
 delete mode 100644 arch/arm/dts/sun50i-h616-x96-mate.dts
 delete mode 100644 arch/arm/dts/sun50i-h616.dtsi
 delete mode 100644 arch/arm/dts/sun50i-h618-longan-module-3h.dtsi
 delete mode 100644 arch/arm/dts/sun50i-h618-longanpi-3h.dts
 delete mode 100644 arch/arm/dts/sun50i-h618-orangepi-zero2w.dts
 delete mode 100644 arch/arm/dts/sun50i-h618-orangepi-zero3.dts
 delete mode 100644 arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts
 delete mode 100644 arch/arm/dts/sun50i-h700-anbernic-rg35xx-2024.dts
 delete mode 100644 arch/arm/dts/sun50i-h700-anbernic-rg35xx-h.dts
 delete mode 100644 arch/arm/dts/sun50i-h700-anbernic-rg35xx-plus.dts
 create mode 100644 configs/anbernic_rg35xx_h700_defconfig
 delete mode 100644 include/dt-bindings/clock/sun50i-h616-ccu.h
 delete mode 100644 include/dt-bindings/reset/sun50i-h616-ccu.h
