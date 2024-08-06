Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7594C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 14:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D429788A3D;
	Tue,  6 Aug 2024 16:38:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B432E88A3D; Tue,  6 Aug 2024 16:38:48 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id F40CB881EA
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 16:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC0C9FEC;
 Tue,  6 Aug 2024 07:38:55 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A8B13F7B4;
 Tue,  6 Aug 2024 07:38:28 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Michael Walle <mwalle@kernel.org>, linux-sunxi@lists.linux.dev
Subject: Pull request: u-boot-sunxi/master for v2024.10
Date: Tue,  6 Aug 2024 15:38:23 +0100
Message-Id: <20240806143823.1438437-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
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

please pull the sunxi/master branch, containing some more changes for
2024.10.
This updates the "old style" DTs to that of Linux v6.10, matching what
OF_UPSTREAM is at now. Hopefully we won't need to do this (manually)
anymore. Since this brings in the DT for a new board (Tanix TX1), also
add the defconfig for that, which has just been waiting for that sync.
There are three more fixes: two for the SPI clock setup, which avoids
too high frequencies in some cases, and one fix to avoid a build warning
with GCC 14 for the sunxi TOC0 part of the mkimage tool.

The gitlab CI passed, and I tested the SPI flash on the OrangePi Zero 3
and also booted that into Linux.

Please pull!

Cheers,
Andre

============================================================
The following changes since commit 6becf9ba1ab82af6f4fcf9f4d0da38f9c75212d2:

  Merge tag 'u-boot-imx-master-20240802' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-08-02 14:40:59 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sunxi.git master

for you to fetch changes up to 541a1649e74787682902d820d0b79e16bad69a4f:

  spi: sunxi: fix clock divider calculation for max frequency setting (2024-08-06 11:20:10 +0100)

----------------------------------------------------------------
Andre Przywara (2):
      sunxi: dts: arm/arm64: update devicetree files from Linux-v6.10
      sunxi: h616: add Tanix TX1 support

Michael Walle (2):
      spi: sunxi: fix CDR2 calculation
      spi: sunxi: fix clock divider calculation for max frequency setting

Seung-Woo Kim (1):
      tools: imagetool: Remove unnecessary check from toc0_verify_cert_item()

 arch/arm/dts/Makefile                             |   1 +
 arch/arm/dts/sun50i-a64-bananapi-m64.dts          |   2 +-
 arch/arm/dts/sun50i-a64-nanopi-a64.dts            |   2 +-
 arch/arm/dts/sun50i-a64-olinuxino.dts             |   2 +-
 arch/arm/dts/sun50i-a64-orangepi-win.dts          |   2 +-
 arch/arm/dts/sun50i-a64-pinebook.dts              |   2 +-
 arch/arm/dts/sun50i-a64-pinephone.dtsi            |  16 +-
 arch/arm/dts/sun50i-a64-pinetab.dts               |   2 +-
 arch/arm/dts/sun50i-a64-teres-i.dts               |   2 +-
 arch/arm/dts/sun50i-a64.dtsi                      |  18 +-
 arch/arm/dts/sun50i-h313-tanix-tx1.dts            | 183 ++++++++++++
 arch/arm/dts/sun50i-h5-nanopi-neo-plus2.dts       |   2 +-
 arch/arm/dts/sun50i-h5-nanopi-r1s-h5.dts          |   4 +-
 arch/arm/dts/sun50i-h5-orangepi-prime.dts         |   2 +-
 arch/arm/dts/sun50i-h5-orangepi-zero-plus.dts     |   2 +-
 arch/arm/dts/sun50i-h5-orangepi-zero-plus2.dts    |   2 +-
 arch/arm/dts/sun50i-h6-beelink-gs1.dts            |   2 +-
 arch/arm/dts/sun50i-h6-orangepi-3.dts             |   2 +-
 arch/arm/dts/sun50i-h6-orangepi-lite2.dts         |   2 +-
 arch/arm/dts/sun50i-h6-orangepi.dtsi              |   2 +-
 arch/arm/dts/sun50i-h6-pine-h64-model-b.dts       |   6 +-
 arch/arm/dts/sun50i-h6-pine-h64.dts               |   2 +-
 arch/arm/dts/sun50i-h6.dtsi                       |   2 +-
 arch/arm/dts/sun50i-h616-bigtreetech-cb1.dtsi     |   5 +
 arch/arm/dts/sun50i-h616-cpu-opp.dtsi             | 115 ++++++++
 arch/arm/dts/sun50i-h616-orangepi-zero2.dts       |   5 +
 arch/arm/dts/sun50i-h616-x96-mate.dts             |   5 +
 arch/arm/dts/sun50i-h616.dtsi                     |  19 +-
 arch/arm/dts/sun50i-h618-longan-module-3h.dtsi    |   5 +
 arch/arm/dts/sun50i-h618-orangepi-zero2w.dts      |   5 +
 arch/arm/dts/sun50i-h618-orangepi-zero3.dts       |   5 +
 arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts    |   7 +-
 arch/arm/dts/sun50i-h64-remix-mini-pc.dts         |   2 +-
 arch/arm/dts/sun50i-h700-anbernic-rg35xx-2024.dts | 327 ++++++++++++++++++++++
 arch/arm/dts/sun50i-h700-anbernic-rg35xx-h.dts    |  36 +++
 arch/arm/dts/sun50i-h700-anbernic-rg35xx-plus.dts |  53 ++++
 arch/arm/dts/sun5i-a13.dtsi                       |   4 +-
 arch/arm/dts/sun5i-gr8-chip-pro.dts               |   2 +-
 arch/arm/dts/sun5i-r8-chip.dts                    |   2 +-
 arch/arm/dts/sun6i-a31-hummingbird.dts            |   4 +-
 arch/arm/dts/sun6i-a31.dtsi                       |  16 +-
 arch/arm/dts/sun6i-a31s-sinovoip-bpi-m2.dts       |   2 +-
 arch/arm/dts/sun7i-a20-bananapi-m1-plus.dts       |   2 +-
 arch/arm/dts/sun7i-a20-cubietruck.dts             |   2 +-
 arch/arm/dts/sun7i-a20-hummingbird.dts            |   4 +-
 arch/arm/dts/sun7i-a20-olimex-som-evb-emmc.dts    |   2 +-
 arch/arm/dts/sun7i-a20-olimex-som204-evb-emmc.dts |   2 +-
 arch/arm/dts/sun7i-a20-olimex-som204-evb.dts      |   4 +-
 arch/arm/dts/sun7i-a20-olinuxino-lime2.dts        |   2 +-
 arch/arm/dts/sun7i-a20-wits-pro-a20-dkt.dts       |   2 +-
 arch/arm/dts/sun7i-a20.dtsi                       |   4 +-
 arch/arm/dts/sun8i-a23-a33.dtsi                   |  14 +-
 arch/arm/dts/sun8i-a23-polaroid-mid2407pxe03.dts  |   4 +-
 arch/arm/dts/sun8i-a23-polaroid-mid2809pxe04.dts  |   4 +-
 arch/arm/dts/sun8i-a33-ga10h-v1.1.dts             |   2 +-
 arch/arm/dts/sun8i-a33-inet-d978-rev2.dts         |   2 +-
 arch/arm/dts/sun8i-a33.dtsi                       |  10 +-
 arch/arm/dts/sun8i-a83t-bananapi-m3.dts           |   2 +-
 arch/arm/dts/sun8i-a83t-cubietruck-plus.dts       |   2 +-
 arch/arm/dts/sun8i-a83t-tbs-a711.dts              |   2 +-
 arch/arm/dts/sun8i-a83t.dtsi                      |   8 +-
 arch/arm/dts/sun8i-h2-plus-bananapi-m2-zero.dts   |   2 +-
 arch/arm/dts/sun8i-h2-plus-orangepi-r1.dts        |   5 +-
 arch/arm/dts/sun8i-h2-plus-orangepi-zero.dts      |   6 +-
 arch/arm/dts/sun8i-h3-beelink-x2.dts              |   4 +-
 arch/arm/dts/sun8i-h3-nanopi-duo2.dts             |   4 +-
 arch/arm/dts/sun8i-h3-nanopi-m1-plus.dts          |   4 +-
 arch/arm/dts/sun8i-h3-nanopi-neo-air.dts          |   2 +-
 arch/arm/dts/sun8i-h3-nanopi-r1.dts               |   2 +-
 arch/arm/dts/sun8i-h3-orangepi-2.dts              |   4 +-
 arch/arm/dts/sun8i-h3-orangepi-lite.dts           |   2 +-
 arch/arm/dts/sun8i-h3-orangepi-pc-plus.dts        |   2 +-
 arch/arm/dts/sun8i-h3-orangepi-zero-plus2.dts     |   2 +-
 arch/arm/dts/sun8i-q8-common.dtsi                 |   4 +-
 arch/arm/dts/sun8i-r16-bananapi-m2m.dts           |   2 +-
 arch/arm/dts/sun8i-r16-parrot.dts                 |   2 +-
 arch/arm/dts/sun8i-r40-bananapi-m2-ultra.dts      |   2 +-
 arch/arm/dts/sun8i-r40-oka40i-c.dts               |   2 +-
 arch/arm/dts/sun8i-s3-pinecube.dts                |   2 +-
 arch/arm/dts/sun8i-v3s.dtsi                       |   4 +-
 arch/arm/dts/sun8i-v40-bananapi-m2-berry.dts      |   2 +-
 arch/arm/dts/sun9i-a80.dtsi                       |   4 +-
 arch/arm/dts/sunxi-bananapi-m2-plus.dtsi          |   2 +-
 arch/arm/dts/sunxi-h3-h5-emlid-neutis.dtsi        |   2 +-
 arch/arm/dts/sunxi-h3-h5.dtsi                     |   4 +-
 board/sunxi/MAINTAINERS                           |   6 +
 configs/tanix_tx1_defconfig                       |  25 ++
 drivers/spi/spi-sunxi.c                           |  16 +-
 tools/sunxi_toc0.c                                |   2 +-
 89 files changed, 939 insertions(+), 136 deletions(-)
 create mode 100644 arch/arm/dts/sun50i-h313-tanix-tx1.dts
 create mode 100644 arch/arm/dts/sun50i-h616-cpu-opp.dtsi
 create mode 100644 arch/arm/dts/sun50i-h700-anbernic-rg35xx-2024.dts
 create mode 100644 arch/arm/dts/sun50i-h700-anbernic-rg35xx-h.dts
 create mode 100644 arch/arm/dts/sun50i-h700-anbernic-rg35xx-plus.dts
 create mode 100644 configs/tanix_tx1_defconfig
