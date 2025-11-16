Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C75CCD4F3E
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 14:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBD3F839AC;
	Sun, 16 Nov 2025 15:44:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36FC0839B1; Sun, 16 Nov 2025 15:44:54 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEC01839A8
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 15:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.48.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 699D23415C9;
 Sun, 16 Nov 2025 14:44:44 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Subject: [PATCH 00/11] sunxi: Add support for A733 SoC
Date: Sun, 16 Nov 2025 14:43:51 +0000
Message-Id: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACfjGWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQ0NTXQND3URzY2Pd4vxk3eLSgoL8ohJdM/MkAzMD42RLC4NUJaDOgqL
 UtMwKsKnRsbW1APypurplAAAA
X-Change-ID: 20251115-01-a733-soc-support-67b0603c980e
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4028; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=xxVzzucA7wP1MqaHAIVyZF6ulkl6ci0luT5lT4aA0Xs=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBpGeM1z5IuUBagGXY5enmDge/aTyq6xzJ7YPoGN
 7ewsfsfIk2JApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaRnjNV8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277UTSD/9fgmJNFavycMJv2T
 csqt09kR7RxvPPiY4XK1L92TNwRP1ikE/emhf8rWB3GamkufNrUzm0azVZPMWXJMqzT3NyF+Qm9
 d3FgtA9DCy0qF5wHNLWXlYFOh1F00OHFw/dfyzEJkwaRAyGqOOdcqHPzbp6BcqRiIESZsLb0PU7
 MqxQv5iJf5WNLEuyNigYdd0W2/VqQaKzWi29BE2TCUD+Ij8PCRNdViy2AlC2a1ZdjRmfefVxkTA
 4CwmSJ98UUkgtQBWdWpyKYcQa/qNt+xZsu8sTWwjq2nbzYtB5kKFNu6QlNnyQmgH5178j0EJXU6
 nrIw+3A6mV+hHDwvuiYzEi1WCxEgItNeGdxfkU2EyMAySZ/3tfWqGPJKK4ygfJJzJ/qZmnD1j6Y
 Rux+jteuVD8e+g+ANSGGiLRjdmXnCdIpfpl8dVDpgKwUbfBNmbLFrO8TGiiMglKv1lpcPeELbbx
 eTOrsyMWunz97KgWWVJ3z/pjCT46XeBJ5YjIJew7d0zKG3O4tQusjS9WMEXG5Ye9zTH+fYFmxbm
 rw0Tt8Hk2Fi95A3rRDU9TAZUQVNuIAX1KIO5q87e/5z0oZogdN46hEjewCj2ynSEgwutJV33Jm4
 LnzGG/Gwq8RIUQVbqUD/I+MhO8gaxzHSuS2KstSj34KJgyRpLWwrIrefnvhXFVg2CwcQ==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Allwinner A733 SoC[1] is an octa-core Cortex-A76/A55 processor, below
list the brief features. 

- Dual-core Cortex-A76, Hexa-core Cortex-A55, RISC-V E902 core
- UP to 16GB RAM, 192K+512K SRAM
- Imagination BXM-4-64 MC1 GPU
- Optional 3 TOPS NPU
- UFS3.0 storage
- eMMC, SD, SDIO
- Octal SPI
- HDMI, RGB, LVDS, eDP, MIPI display interface
- MIPI CSI, up 4 lanes
- Audio 5x I2S
- GMAC Ethernet
- USB3.1, 2.0 support
- PCIe 3.0 DM

Add support for Allwinner A733 SoC, target to support booting mainline
U-boot via FEL download mode, also add eMMC driver support, mmake it
able to load images from the eMMC/SD storage device.

I've not pushed DT part patches, but put a more complete working branch
at my development branch[2] for reference or testing if people
interested. Please note, we reply on vendor boot0 firmware for the DDR
initialization, then use sunxi-fel to down and execute U-Boot, see doc[3].

Link: https://linux-sunxi.org/A733 [1]
Link: https://github.com/dlan17/u-boot/tree/allwinner/A733/next [2]
Link: https://github.com/dlan17/a733/blob/main/boot-fel.md [3]
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
Yixun Lan (11):
      sunxi: sun60i: initial support for A733 SoC
      sunxi: a733: config TF-A load address
      sunxi: spl: a733: config text and stack address
      sunxi: a733: uart: setup serial console
      clock: a733: implement support for mmc/uart
      clock: reset: a733: add initial support
      gpio: a733: add initial support
      pinctrl: sunxi: a733: add initial support
      sunxi: i2c: add support for A733
      pmu: axp318w: implement pmic/regulator support
      sunxi: mmc: enable support for A733

 arch/arm/include/asm/arch-sunxi/clock.h            |   2 +
 .../arm/include/asm/arch-sunxi/clock_sun60i_a733.h | 179 ++++++++++++++++++++
 arch/arm/include/asm/arch-sunxi/cpu.h              |   2 +
 arch/arm/include/asm/arch-sunxi/cpu_sunxi_a733.h   |  41 +++++
 arch/arm/include/asm/arch-sunxi/serial.h           |   2 +-
 arch/arm/mach-sunxi/Kconfig                        |  14 ++
 arch/arm/mach-sunxi/Makefile                       |   1 +
 arch/arm/mach-sunxi/board.c                        |   3 +-
 arch/arm/mach-sunxi/clock_sun60i_a733.c            |  80 +++++++++
 arch/arm/mach-sunxi/cpu_info.c                     |   2 +
 common/spl/Kconfig                                 |   3 +
 drivers/clk/sunxi/Kconfig                          |  14 ++
 drivers/clk/sunxi/Makefile                         |   2 +
 drivers/clk/sunxi/clk_a733.c                       |  75 ++++++++
 drivers/clk/sunxi/clk_a733_r.c                     |  36 ++++
 drivers/clk/sunxi/clk_sunxi.c                      |  10 ++
 drivers/gpio/Kconfig                               |   7 +
 drivers/gpio/sunxi_gpio.c                          |  12 +-
 drivers/i2c/mvtwsi.c                               |   2 +-
 drivers/mmc/sunxi_mmc.c                            |  32 +++-
 drivers/mmc/sunxi_mmc.h                            |   3 +-
 drivers/pinctrl/sunxi/Kconfig                      |  10 ++
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |  57 +++++++
 drivers/power/Kconfig                              |  10 ++
 drivers/power/pmic/axp.c                           |   1 +
 drivers/power/regulator/axp_regulator.c            |  50 ++++++
 include/axp_pmic.h                                 |   1 +
 include/configs/sun60i.h                           |  11 ++
 include/dt-bindings/clock/sun60i-a733-ccu.h        | 188 +++++++++++++++++++++
 include/dt-bindings/clock/sun60i-a733-r-ccu.h      |  34 ++++
 include/dt-bindings/reset/sun60i-a733-ccu.h        |  85 ++++++++++
 include/dt-bindings/reset/sun60i-a733-r-ccu.h      |  22 +++
 include/sunxi_gpio.h                               |  11 +-
 33 files changed, 989 insertions(+), 13 deletions(-)
---
base-commit: 23987e10905146def3ab61e55ec912c6e742efdc
change-id: 20251115-01-a733-soc-support-67b0603c980e

Best regards,
-- 
Yixun Lan <dlan@gentoo.org>

