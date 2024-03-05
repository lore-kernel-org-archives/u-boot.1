Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E62C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 11:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8230E87FDE;
	Tue,  5 Mar 2024 12:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EDB487FE3; Tue,  5 Mar 2024 12:15:53 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D8BC187FDA
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 12:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A60611FB;
 Tue,  5 Mar 2024 03:16:26 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C39303F762;
 Tue,  5 Mar 2024 03:15:48 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Maksim Kiselev <bigunclemax@gmail.com>, Philippe Coval <rzr@users.sf.net>,
 Ludwig Kormann <ludwig.kormann@ict42.de>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>, linux-sunxi@lists.linux.dev
Subject: Pull request: u-boot-sunxi/master for v2024.04
Date: Tue,  5 Mar 2024 11:15:41 +0000
Message-Id: <20240305111541.2369415-1-andre.przywara@arm.com>
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

please pull the sunxi/master branch, containing some fixes and smaller
changes for 2024.04.
One fix makes the reboot more robust on some older board, another one
stabilises the initial clock setup on the A10/A20.
Two patches make sure our DRAM init does not actually change the content
of the DRAM array, which allows to use DRAM for Linux' pstore
functionality.
We get SPI support for U-Boot proper for one more SoC, that patch was
lingering around for a while, and should not affect other SoCs, so I am
merging this now.
As an added bonus, we get the defconfig file for a new board, the DT was
already synced from the kernel tree.

The CI looked happy with changes, and I tested them on five different
boards with different SoCs.

Please pull!

Cheers,
Andre

==================
The following changes since commit eac52e4be4e234d563d6911737ee7ccdc0ada1f1:

  Merge patch series "ARM: renesas: Rename R-Mobile to Renesas" (2024-03-02 14:30:25 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sunxi.git master

for you to fetch changes up to f1e6a718ebab0682d80601db404e8d842767becf:

  sunxi: restore modified memory (2024-03-05 01:16:56 +0000)

----------------------------------------------------------------
Andre Przywara (1):
      sunxi: H616: Add OrangePi Zero 2W board support

Andrey Skvortsov (2):
      sunxi: reorganize mctl_mem_matches_* functions
      sunxi: restore modified memory

Ludwig Kormann (1):
      sunxi: sun4i: add missing sdelay() to clock_init_safe()

Maksim Kiselev (1):
      spi: sunxi: Add support for R329/D1/R528/T113 SPI controller

Philippe Coval (1):
      arm: sunxi: Reduce inrush current on Olimex A20-OLinuXino_MICRO configs

 arch/arm/dts/Makefile                      |  1 +
 arch/arm/include/asm/arch-sunxi/dram.h     |  1 +
 arch/arm/mach-sunxi/clock_sun4i.c          |  2 ++
 arch/arm/mach-sunxi/dram_helpers.c         | 32 ++++++++++++++++++++++------
 arch/arm/mach-sunxi/dram_sunxi_dw.c        | 13 ------------
 board/sunxi/MAINTAINERS                    |  5 +++++
 configs/A20-OLinuXino_MICRO-eMMC_defconfig |  1 +
 configs/A20-OLinuXino_MICRO_defconfig      |  1 +
 configs/orangepi_zero2w_defconfig          | 30 ++++++++++++++++++++++++++
 drivers/spi/spi-sunxi.c                    | 34 +++++++++++++++++++++++++++++-
 10 files changed, 100 insertions(+), 20 deletions(-)
 create mode 100644 configs/orangepi_zero2w_defconfig
