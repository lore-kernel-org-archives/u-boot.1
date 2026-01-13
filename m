Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE4FD29DC2
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 04:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6596E836D3;
	Tue, 13 Jan 2026 05:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A713E836C8; Tue, 13 Jan 2026 05:02:45 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21714836A3
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 05:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.18.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id EE160340ED3;
 Tue, 13 Jan 2026 04:02:37 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v3 0/9] sunxi: Add support for A733 SoC
Date: Tue, 13 Jan 2026 12:01:54 +0800
Message-Id: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALLDZWkC/23NTQqDMBCG4atI1p2SH03SrnqP0oVJRs3GSGJDi
 3j3RqHQgsv3g3lmIQmjx0Su1UIiZp98GEuIU0Xs0I49gnelCae8YYw1QBm0SghIwUJ6TlOIM0h
 lqKTCXjRFUi6niJ1/7er9UXrwaQ7xvT/JbFu/njz0MgMKnamtdkZpVM2tx3EO4RxiTzYw8x9E0
 GOEF4Rp41wtlOxa94es6/oB94xVQPwAAAA=
X-Change-ID: 20251115-01-a733-soc-support-67b0603c980e
To: u-boot@lists.denx.de
Cc: linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4231; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=TdIogV8bE7lBkWzsstgLniKYFYupvU86AVKO4EokWS4=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBpZcO9EEwve4Pwd35Jdkk1B2UrsoaF4XGzqGPtE
 lHFCvZ6FqGJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaWXDvRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3TIw//T8XkqIT4i9b5ULSez/cGqTbP2ss1uOeMj2bwuPnz5RPnxzdPcPFLe
 lYLdFZiaQpdLzf1HL9dBr8RPa1u4rqnYt+nlu4sbxUhpSpqqp/GQ9xYe2OFy+Bi30wdwiwdRFiV
 YnDy7NX6P4mo73ksLYppRPgJfPuO/T1ella8Rf9/tjuUMCzN7VOaMrqj1b5qp2pnCwqzJ6WQazI
 DPL0QN+oNdghPlpwQQEuXjjldY1qbxLl4XsN7B5CFguCOIIZvV4OWPrM6QSKBocRUScrK/xGUwq
 MRDDFhlrLy5mFRkd/E1WXMXVhuyYeN5NKXUP19gnlVAtV5NESblOvx9336NWYzSR23FLmpV2kui
 bCKlV0jaae/BdgpMTU04tHqificn0vUFd4zGXPhHD0+ugcrGk37CzDmimfrHr4Yko4zQlRJgjQ6
 LlUf0JjG8GflQRn//bCcCUXESPlR/eutmkGwbcMjBDDqBiDy2LlFSw/GO7A8UH+dvlyZI3DfbxO
 JwNlQTxw8Tl0Bb6q5/SndA8sFxTyeDcI6lJGG1b4KU3OQGhXAViepE0IRZeNzV/XuMl3ZgOGB7C
 TdRJP9de1wf6gtKWh7XqS7mxbbtpIZNKUVvdx8fKZz423KhEzqBcQFr5bZ0nTQ1X/7Jdh9h7Gsa
 J53rrK55DGTBdZnBp0zle+bxtIVKZc=
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
Changes in v3:
- power: fix format issue, move patch to first, fix SPL config
- gpio/pinctrl: rename config to SUNXI_A733_PINCTRL
- refactor get_mclk_offset()
- Link to v2: https://lore.kernel.org/r/20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org

Changes in v2:
- reuse CONFIG_SUNXI_GEN_NCAT2
- merge clock initialization code with H6 driver
- add pmu driver for SPL stage
- rework for PIO register layout, introduce PIO_OFFSET
- squash commit for changes of Kconfig
- Link to v1: https://lore.kernel.org/r/20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org

---
Yixun Lan (9):
      power: regulator: add AXP318W support
      power: regulator: enable AWP318W SPL support
      sunxi: a733: uart: setup serial console
      clock: a733: implement support for mmc/uart
      clock: reset: a733: add initial support
      gpio: a733: add initial support
      pinctrl: sunxi: a733: add initial support
      sunxi: mmc: enable support for A733
      sunxi: sun60i: initial support for A733 SoC

 arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h |  31 ++++
 arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h |  36 +++++
 arch/arm/mach-sunxi/Kconfig                       |  14 ++
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
 drivers/mmc/sunxi_mmc.c                           |  28 +++-
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
 29 files changed, 780 insertions(+), 16 deletions(-)
---
base-commit: 23987e10905146def3ab61e55ec912c6e742efdc
change-id: 20251115-01-a733-soc-support-67b0603c980e

Best regards,
-- 
Yixun Lan <dlan@gentoo.org>

