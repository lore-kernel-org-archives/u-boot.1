Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3219DCFD376
	for <u-boot@archiver.kernel.org>; Sun, 30 Nov 2025 21:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43B49838FA;
	Sun, 30 Nov 2025 22:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79C0B838BB; Sun, 30 Nov 2025 22:46:08 +0100 (CET)
Received: from smtp.gentoo.org (smtp.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 066158312A
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 22:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.18.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 0FE37335D0E;
 Sun, 30 Nov 2025 21:46:00 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v2 00/10] sunxi: Add support for A733 SoC
Date: Sun, 30 Nov 2025 21:45:09 +0000
Message-Id: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOa6LGkC/22NQQ6CMBBFr0Jm7Zi2CEVX3sOwgDKUbjqkrURDe
 ncriTuX7yX//R0iBUcRbtUOgTYXHfsC6lSBWQZvCd1UGJRQjZSyQSFx0HWNkQ3G57pySNjqUbS
 iNtdOEJTlGmh2r6P66AsvLiYO7+Nkk1/767V/e5tEgfN4Md006o50c7fkE/OZg4U+5/wBLTwCl
 LcAAAA=
X-Change-ID: 20251115-01-a733-soc-support-67b0603c980e
To: u-boot@lists.denx.de
Cc: linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4038; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=Nb1fH6/Hd+2SB22o2Mcx9g8dnU0dc1B+z3coMidrlE0=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBpLLr151JdRgdR0I4S0Bas4PMPJcIDxdva+PuX+
 AlEE4R2xPeJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaSy69V8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277XNaD/9jGPxxRra++HsG9t
 /8KPpelxw0SwfYwAJrYGsKx74yNelwOW0TgW8rQyJW1xolhDr94U+ObDoogBmW2UOJcIYBSuxZC
 D5dgLSo8IWVtYEqTyVAxF0EaKKVlbGzsl7eOgoKe1IUJqk0QIkmbxh56fu5BaDXR6xa5wQoTxST
 C8q1FtHTAGqCfVaJTJFxn/uAf45Otm5YjlmBjJtTxVt6H2BGKBa6035ZlHXQ6z538kv8XOPlZ/7
 S2CvQsaChPTawZfKK16uayjUtJQwlrG5mkLoyOt2kW0mxBdci3HoniX2lsg0y/Hf2EvozX13rvq
 n4Us3Co73sivQZRmV48lexGQNXdEdQlgicd+SB1zhQCsKvIZ4A9lKNtAn2UGvDiqOEExW4OrJZW
 6PAD8frDUFrfAmdRFbZZkvzdMCHmFVYW6NqqLs5vdDLzHUEoe4x0lh3875EyktDf1+P/ta1/Zqf
 4grTci2N612TGsXz1QyiHfP11XXOLdYh8YTnRjDU+fZTFTzf+dcPBaVHMCDP7/JT72/rEF33R4p
 20yFfGCM4A+N40ZjKyn5kl3x2DIBmmfYL94exC0mWwYixeqWybc5b0T4HNMTsq4p9plXvEg1Cxc
 0JqoJeLtWrPtK/+kOx4ko77xtUwfFVZkQoTYRboZSDgStYJlNbAv0BRQnLrS3z4MOjBA==
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
U-boot via FEL download mode, also add eMMC driver support, make it
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
Changes in v2:
- reuse CONFIG_SUNXI_GEN_NCAT2
- merge clock initialization code with H6 driver
- add pmu driver for SPL stage
- rework for PIO register layout, introduce PIO_OFFSET
- squash commit for changes of Kconfig
- Link to v1: https://lore.kernel.org/r/20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org

---
Yixun Lan (10):
      sunxi: sun60i: initial support for A733 SoC
      sunxi: spl: a733: config text and stack address
      sunxi: a733: uart: setup serial console
      clock: a733: implement support for mmc/uart
      clock: reset: a733: add initial support
      gpio: a733: add initial support
      pinctrl: sunxi: a733: add initial support
      pmu: axp318w: implement pmic/regulator support
      power: pmic: sunxi: add SPL support for the AXP318W
      sunxi: mmc: enable support for A733

 arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h |  31 ++++
 arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h |  36 +++++
 arch/arm/mach-sunxi/Kconfig                       |  15 ++
 arch/arm/mach-sunxi/board.c                       |   3 +-
 arch/arm/mach-sunxi/clock_sun50i_h6.c             |  14 +-
 arch/arm/mach-sunxi/cpu_info.c                    |   2 +
 common/spl/Kconfig                                |   3 +
 drivers/clk/sunxi/Kconfig                         |  14 ++
 drivers/clk/sunxi/Makefile                        |   2 +
 drivers/clk/sunxi/clk_a733.c                      |  75 +++++++++
 drivers/clk/sunxi/clk_a733_r.c                    |  36 +++++
 drivers/clk/sunxi/clk_sunxi.c                     |  10 ++
 drivers/gpio/Kconfig                              |   7 +
 drivers/gpio/sunxi_gpio.c                         |  17 +-
 drivers/mmc/sunxi_mmc.c                           |  21 ++-
 drivers/pinctrl/sunxi/Kconfig                     |  10 ++
 drivers/pinctrl/sunxi/pinctrl-sunxi.c             |  57 ++++++-
 drivers/power/Kconfig                             |  10 ++
 drivers/power/Makefile                            |   1 +
 drivers/power/axp_spl.c                           |  20 +++
 drivers/power/pmic/axp.c                          |   1 +
 drivers/power/regulator/axp_regulator.c           |  50 ++++++
 include/axp_pmic.h                                |   1 +
 include/configs/sun60i.h                          |  11 ++
 include/dt-bindings/clock/sun60i-a733-ccu.h       | 188 ++++++++++++++++++++++
 include/dt-bindings/clock/sun60i-a733-r-ccu.h     |  34 ++++
 include/dt-bindings/reset/sun60i-a733-ccu.h       |  85 ++++++++++
 include/dt-bindings/reset/sun60i-a733-r-ccu.h     |  22 +++
 include/sunxi_gpio.h                              |  14 ++
 29 files changed, 778 insertions(+), 12 deletions(-)
---
base-commit: 23987e10905146def3ab61e55ec912c6e742efdc
change-id: 20251115-01-a733-soc-support-67b0603c980e

Best regards,
-- 
Yixun Lan <dlan@gentoo.org>

