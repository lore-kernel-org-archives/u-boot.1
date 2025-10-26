Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32294CCD1BF
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 01:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADDDE836C8;
	Sun, 26 Oct 2025 02:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3379C83623; Sun, 26 Oct 2025 02:24:42 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C0045807C0
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 02:24:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3960C113E;
 Sat, 25 Oct 2025 18:24:31 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EE1A3F59E;
 Sat, 25 Oct 2025 18:24:37 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: linux-sunxi@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wens@kernel.org>
Subject: [PATCH 0/4] sunxi: dts: update devicetree files
Date: Sun, 26 Oct 2025 01:23:52 +0000
Message-ID: <20251026012357.16773-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
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

This series provides some DT updates for Allwinner boards. The first two
patches switch boards using two SoCs over to use OF_UPSTREAM, since the
DT copies in the kernel tree were found to be identical to those in the
U-Boot tree. This affects the T113-s3 and A80 SoCs. One board DT is not
upstream in the Linux kernel, so we keep the U-Boot copy.

The other two patches update the DT files for those SoCs that do not use
OF_UPSTREAM yet. This is probably the last time I am doing this before
switching them over to OF_UPSTREAM as well, although this will break
compatibility with older Linux kernels, before v5.13.
The changes gained by this update are not groundbreaking, but the last
update was a while ago, and some fixes have been accumulated since.

The OF_UPSTREAM part was verified by comparing the generated .dtb files
before and after, to be found the same.

Please have a look and test, if possible.

Cheers,
Andre

Andre Przywara (4):
  sunxi: switch the Allwinner T113 SoC to OF_UPSTREAM
  sunxi: switch Allwinner A80 boards to OF_UPSTREAM
  sunxi: dts: arm64: update devicetree files from Linux kernel tree
  sunxi: dts: arm: update devicetree files from Linux kernel tree

 arch/arm/dts/Makefile                         |    4 -
 arch/arm/dts/sun50i-a64-pine64-lts.dts        |    2 +-
 arch/arm/dts/sun50i-a64-pine64-plus.dts       |    2 +-
 arch/arm/dts/sun50i-a64-pine64.dts            |   14 +-
 arch/arm/dts/sun50i-a64-pinebook.dts          |    4 +-
 arch/arm/dts/sun50i-a64-pinephone.dtsi        |   21 +
 .../dts/sun50i-a64-pinetab-early-adopter.dts  |    2 +-
 arch/arm/dts/sun50i-a64-pinetab.dts           |    2 +-
 arch/arm/dts/sun50i-a64-sopine-baseboard.dts  |   21 +-
 arch/arm/dts/sun50i-a64-teres-i.dts           |    2 +
 arch/arm/dts/sun50i-a64.dtsi                  |   55 +-
 arch/arm/dts/sun50i-h5-nanopi-neo-plus2.dts   |   38 +
 arch/arm/dts/sun50i-h5-nanopi-neo2.dts        |    1 +
 arch/arm/dts/sun50i-h5-nanopi-r1s-h5.dts      |    1 +
 arch/arm/dts/sun50i-h5-orangepi-pc2.dts       |    1 +
 arch/arm/dts/sun50i-h5-orangepi-prime.dts     |    1 +
 arch/arm/dts/sun50i-h5-orangepi-zero-plus.dts |    1 +
 .../arm/dts/sun50i-h5-orangepi-zero-plus2.dts |    1 +
 arch/arm/dts/sun50i-h5.dtsi                   |    6 +-
 arch/arm/dts/sun50i-h6-beelink-gs1.dts        |   39 +-
 arch/arm/dts/sun50i-h6-orangepi-3.dts         |   17 +-
 arch/arm/dts/sun50i-h6-orangepi-lite2.dts     |    2 +-
 arch/arm/dts/sun50i-h6-orangepi.dtsi          |   23 +-
 arch/arm/dts/sun50i-h6-pine-h64-model-b.dts   |    2 +-
 arch/arm/dts/sun50i-h6-pine-h64.dts           |    3 +-
 arch/arm/dts/sun50i-h6-tanix.dtsi             |    1 +
 arch/arm/dts/sun50i-h6.dtsi                   |   41 +-
 arch/arm/dts/sun7i-a20-bananapi.dts           |   27 +
 arch/arm/dts/sun8i-a23-a33.dtsi               |   20 +
 arch/arm/dts/sun8i-a33-vstar-core1.dtsi       |   96 ++
 arch/arm/dts/sun8i-a33-vstar.dts              |  205 +++
 arch/arm/dts/sun8i-a83t.dtsi                  |    4 +-
 arch/arm/dts/sun8i-h2-plus-orangepi-zero.dts  |   14 +
 arch/arm/dts/sun8i-h3-nanopi-neo-air.dts      |    2 +-
 arch/arm/dts/sun8i-h3-orangepi-zero-plus2.dts |   14 +
 arch/arm/dts/sun8i-h3.dtsi                    |    2 +-
 .../sun8i-orangepi-zero-interface-board.dtso  |   46 +
 arch/arm/dts/sun8i-q8-common.dtsi             |    2 +-
 arch/arm/dts/sun8i-r40.dtsi                   |    4 +-
 .../arm/dts/sun8i-t113s-mangopi-mq-r-t113.dts |   35 -
 arch/arm/dts/sun8i-t113s.dtsi                 |   59 -
 arch/arm/dts/sun9i-a80-cubieboard4.dts        |  508 -------
 arch/arm/dts/sun9i-a80-optimus.dts            |  510 -------
 arch/arm/dts/sun9i-a80.dtsi                   | 1253 -----------------
 arch/arm/mach-sunxi/Kconfig                   |    2 +
 arch/riscv/dts/sunxi-d1-t113.dtsi             |   15 -
 arch/riscv/dts/sunxi-d1s-t113.dtsi            |  927 ------------
 configs/Cubieboard4_defconfig                 |    2 +-
 configs/Merrii_A80_Optimus_defconfig          |    2 +-
 configs/Sunchip_CX-A99_defconfig              |    1 +
 configs/mangopi_mq_r_defconfig                |    2 +-
 51 files changed, 676 insertions(+), 3383 deletions(-)
 create mode 100644 arch/arm/dts/sun8i-a33-vstar-core1.dtsi
 create mode 100644 arch/arm/dts/sun8i-a33-vstar.dts
 create mode 100644 arch/arm/dts/sun8i-orangepi-zero-interface-board.dtso
 delete mode 100644 arch/arm/dts/sun8i-t113s-mangopi-mq-r-t113.dts
 delete mode 100644 arch/arm/dts/sun8i-t113s.dtsi
 delete mode 100644 arch/arm/dts/sun9i-a80-cubieboard4.dts
 delete mode 100644 arch/arm/dts/sun9i-a80-optimus.dts
 delete mode 100644 arch/arm/dts/sun9i-a80.dtsi
 delete mode 100644 arch/riscv/dts/sunxi-d1-t113.dtsi
 delete mode 100644 arch/riscv/dts/sunxi-d1s-t113.dtsi

-- 
2.46.4

