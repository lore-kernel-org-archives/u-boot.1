Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C40EC54FB3
	for <u-boot@archiver.kernel.org>; Sun,  1 Jun 2025 17:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71D9E829E4;
	Sun,  1 Jun 2025 19:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BDE7829F5; Sun,  1 Jun 2025 17:40:25 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE58F82103
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 17:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=contact@paulk.fr
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id F1DAE1F0003D
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 15:40:21 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 5468FAC32E7; Sun,  1 Jun 2025 15:40:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id C708EAC329F;
 Sun,  1 Jun 2025 15:39:58 +0000 (UTC)
From: Paul Kocialkowski <contact@paulk.fr>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Icenowy Zheng <icenowy@aosc.xyz>,
 linux-sunxi@lists.linux.dev, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 0/6] Various V3/S3/V3s fixes and improvements
Date: Sun,  1 Jun 2025 17:39:37 +0200
Message-ID: <20250601153943.2690123-1-contact@paulk.fr>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Jun 2025 19:14:22 +0200
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

Paul Kocialkowski (6):
  sunxi: Kconfig: Fix default order for V3s DRAM clock
  sunxi: Add support for the Lichee Pi Zero with Dock
  sunxi: Split V3/S3 support from V3s
  sunxi: pinecube: Enable EMAC and network support
  power: axp: Fixup default voltages for V3/S3
  net: sun8i-emac: Add support for active-low leds with internal PHY

 arch/arm/dts/Makefile                       |  8 +++---
 arch/arm/include/asm/arch-sunxi/cpu_sun4i.h |  1 +
 arch/arm/mach-sunxi/Kconfig                 | 29 ++++++++++++++++-----
 arch/arm/mach-sunxi/board.c                 |  3 ++-
 arch/arm/mach-sunxi/cpu_info.c              |  2 ++
 arch/arm/mach-sunxi/dram_sunxi_dw.c         |  4 +--
 arch/arm/mach-sunxi/spl_spi_sunxi.c         |  1 +
 board/sunxi/board.c                         |  2 +-
 configs/LicheePi_Zero_Dock_defconfig        |  7 +++++
 configs/LicheePi_Zero_defconfig             |  1 -
 configs/pinecube_defconfig                  |  9 ++-----
 drivers/clk/sunxi/Kconfig                   |  2 +-
 drivers/net/sun8i_emac.c                    | 14 ++++++++--
 drivers/phy/allwinner/Kconfig               |  2 +-
 drivers/pinctrl/sunxi/Kconfig               |  2 +-
 drivers/power/Kconfig                       | 12 ++++++---
 16 files changed, 68 insertions(+), 31 deletions(-)
 create mode 100644 configs/LicheePi_Zero_Dock_defconfig

-- 
2.49.0

