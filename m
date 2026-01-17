Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09778C9832F
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A447383B8F;
	Sun, 18 Jan 2026 14:47:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 287C08313B; Sun, 18 Jan 2026 00:13:39 +0100 (CET)
Received: from smtp.gentoo.org (dev.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBA7383015
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 00:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.18.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id CDA2A340F1D;
 Sat, 17 Jan 2026 23:13:33 +0000 (UTC)
Date: Sun, 18 Jan 2026 07:13:30 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de, uboot@riscstar.com,
 Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Conor Dooley <conor.dooley@microchip.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Michal Simek <michal.simek@amd.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Aniket Limaye <a-limaye@ti.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 00/17] Add board support for Spacemit K1 SoC in SPL
Message-ID: <20260117231221-GYB47382@gentoo.org>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117190231.977686-1-raymondmaoca@gmail.com>
X-Mailman-Approved-At: Sun, 18 Jan 2026 14:47:30 +0100
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

Hi Raymond,
please Cc to spacemit@lists.linux.dev for more wide audience

On 14:01 Sat 17 Jan     , Raymond Mao wrote:
> From: Raymond Mao <raymond.mao@riscstar.com>
> 
> This patch series introduces full support for the k1 SoC in SPL for
> multiple boards.
> 
> The series enables the board by:
> 1. Adding the base board definition with device tree.
this is rather huge patchset.. please order and list index
of patches for people easy to review..

some patches touch dts and driver code, please submit in separate patch

> 2. Bringing up essential clock sources and tree.
> 3. Initializing I2C buses for peripheral communication.
> 4. Integrating the PMIC driver for power management.
> 5. Adding regulator drivers for voltage domain control.
> 
> Junhui Liu (1):
>   clk: spacemit: Add support for K1 SoC
> 
> Raymond Mao (16):
>   spacemit: k1: support multi-board infrastructure
>   spacemit: k1: enable SPL with debug UART
>   configs: k1: enable early timer support
>   reset: k1: add SPL support and enable TWSI8 reset
>   dt-bindings: clock: import k1-syscon from upstream
>   dts: k1: import dts file from upstream folder
>   dts: k1: enable clocks in SPL
>   board: k1: initialize clock and serial devices in SPL
>   configs: k1: add default option for clock driver in SPL
>   i2c: k1: add I2C driver support
>   dt-bindings: pinctrl: add k1 support
>   spacemit: k1: add TLV EEPROM support in SPL
>   spacemit: k1: Add DDR firmware support to SPL
>   power: pmic: add support for Spacemit P1 PMIC
>   power: regulator: add support for Spacemit P1 SoC
>   board: k1: enable pmic in spl
> 
>  arch/riscv/Kconfig                            |   10 +-
>  arch/riscv/cpu/k1/Kconfig                     |    6 +
>  arch/riscv/dts/Makefile                       |    1 +
>  arch/riscv/dts/k1-spl.dts                     |  239 +++
>  arch/riscv/dts/k1.dtsi                        |  667 +++++-
>  board/spacemit/bananapi-f3/Kconfig            |   25 -
>  board/spacemit/bananapi-f3/Makefile           |    5 -
>  board/spacemit/k1/Kconfig                     |   38 +
>  .../spacemit/{bananapi-f3 => k1}/MAINTAINERS  |    4 +-
>  board/spacemit/k1/Makefile                    |   26 +
>  board/spacemit/{bananapi-f3 => k1}/board.c    |    0
>  board/spacemit/k1/spl.c                       |  252 +++
>  board/spacemit/k1/tlv_codes.h                 |   22 +
>  configs/bananapi-f3_defconfig                 |   24 -
>  configs/k1_defconfig                          |   77 +
>  drivers/clk/Kconfig                           |    5 +-
>  drivers/clk/Makefile                          |    1 +
>  drivers/clk/spacemit/Kconfig                  |   31 +
>  drivers/clk/spacemit/Makefile                 |    7 +
>  drivers/clk/spacemit/clk-k1.c                 | 1793 +++++++++++++++++
>  drivers/clk/spacemit/clk_common.h             |   79 +
>  drivers/clk/spacemit/clk_ddn.c                |   93 +
>  drivers/clk/spacemit/clk_ddn.h                |   53 +
>  drivers/clk/spacemit/clk_mix.c                |  403 ++++
>  drivers/clk/spacemit/clk_mix.h                |  224 ++
>  drivers/clk/spacemit/clk_pll.c                |  157 ++
>  drivers/clk/spacemit/clk_pll.h                |   81 +
>  drivers/i2c/Kconfig                           |    7 +
>  drivers/i2c/Makefile                          |    1 +
>  drivers/i2c/k1_i2c.c                          |  521 +++++
>  drivers/i2c/k1_i2c.h                          |   69 +
>  drivers/power/pmic/Kconfig                    |   17 +
>  drivers/power/pmic/Makefile                   |    1 +
>  drivers/power/pmic/pmic_spacemit_p1.c         |   94 +
>  drivers/power/regulator/Kconfig               |   15 +
>  drivers/power/regulator/Makefile              |    1 +
>  .../power/regulator/spacemit_p1_regulator.c   |  460 +++++
>  drivers/reset/Kconfig                         |    7 +
>  drivers/reset/Makefile                        |    2 +-
>  drivers/reset/reset-spacemit-k1.c             |    4 -
>  include/configs/{bananapi-f3.h => k1.h}       |    9 +
>  .../dt-bindings/clock/spacemit,k1-syscon.h    |  253 +++
>  include/dt-bindings/pinctrl/k1-pinctrl.h      |   59 +
>  include/power/spacemit_p1.h                   |  163 ++
>  include/soc/spacemit/k1-syscon.h              |  149 ++
>  lib/vendor/spacemit/ddr_fw.bin                |  Bin 0 -> 19416 bytes
>  46 files changed, 5985 insertions(+), 170 deletions(-)
>  create mode 100644 arch/riscv/dts/k1-spl.dts
>  delete mode 100644 board/spacemit/bananapi-f3/Kconfig
>  delete mode 100644 board/spacemit/bananapi-f3/Makefile
>  create mode 100644 board/spacemit/k1/Kconfig
>  rename board/spacemit/{bananapi-f3 => k1}/MAINTAINERS (61%)
>  create mode 100644 board/spacemit/k1/Makefile
>  rename board/spacemit/{bananapi-f3 => k1}/board.c (100%)
>  create mode 100644 board/spacemit/k1/spl.c
>  create mode 100644 board/spacemit/k1/tlv_codes.h
>  delete mode 100644 configs/bananapi-f3_defconfig
>  create mode 100644 configs/k1_defconfig
>  create mode 100644 drivers/clk/spacemit/Kconfig
>  create mode 100644 drivers/clk/spacemit/Makefile
>  create mode 100644 drivers/clk/spacemit/clk-k1.c
>  create mode 100644 drivers/clk/spacemit/clk_common.h
>  create mode 100644 drivers/clk/spacemit/clk_ddn.c
>  create mode 100644 drivers/clk/spacemit/clk_ddn.h
>  create mode 100644 drivers/clk/spacemit/clk_mix.c
>  create mode 100644 drivers/clk/spacemit/clk_mix.h
>  create mode 100644 drivers/clk/spacemit/clk_pll.c
>  create mode 100644 drivers/clk/spacemit/clk_pll.h
>  create mode 100644 drivers/i2c/k1_i2c.c
>  create mode 100644 drivers/i2c/k1_i2c.h
>  create mode 100644 drivers/power/pmic/pmic_spacemit_p1.c
>  create mode 100644 drivers/power/regulator/spacemit_p1_regulator.c
>  rename include/configs/{bananapi-f3.h => k1.h} (52%)
>  create mode 100644 include/dt-bindings/clock/spacemit,k1-syscon.h
>  create mode 100644 include/dt-bindings/pinctrl/k1-pinctrl.h
>  create mode 100644 include/power/spacemit_p1.h
>  create mode 100644 include/soc/spacemit/k1-syscon.h
>  create mode 100644 lib/vendor/spacemit/ddr_fw.bin
> 
> -- 
> 2.25.1
> 

-- 
Yixun Lan (dlan)
