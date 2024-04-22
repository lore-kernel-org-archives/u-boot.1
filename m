Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAB1C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 06:30:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCE15882F3;
	Mon, 22 Apr 2024 08:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="tcvSssVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3811A882F3; Mon, 22 Apr 2024 08:30:01 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C158882E0
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1713767383;
 bh=Q28pktOK6FX6+7a84qldWQkCi/mrWJw+fiR4spzCr6w=;
 b=tcvSssVaD6wWrBTndMktgwz3YCjzvcp39VFy66Z4GW/qUAHwu6Ogv2ttr+PtMVzi2A+vsKHtE
 IO3pWmWTlQbC4V9/7VQGxoHNFiICyQLX8zNy4iE4vDHmam4eWu2TFUt0XtzG6Hh7STg3uJ6XEu8
 7PwV4VdMwzHzK/xtUOViQ3YQq3K939gQEv2LF6ID2kn9HKqhDKRkz4BEFz7/XuifDtxIUH6KlJX
 zra1k589sfqGgTK6du0nbddt2qnenDdr6RJ1/sWWKyQkbwyQpnvgDWc0tBLLu9BkOwtLvb2BkYt
 F7CxjWZ85i5Gdtqcoe8aZu6aHq+4h85b2WDKsbZhxNMQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 00/28] rockchip: rk35xx: Miscellaneous fixes and updates
Date: Mon, 22 Apr 2024 06:28:37 +0000
Message-ID: <20240422062936.681359-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 662603d734ba165ad447425a
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

This series include miscellaneous fixes and updates for RK356x and
RK3588 boards.

Patch 1-2 adds support for reference clocks used by USB driver.

Patch 3 fix SPI flash clk for spi-max-frequency used in new board DTs.

Patch 4-6 drops unnecessary Kconfig options.

Patch 7-10 sort and imply RNG, PHY_GIGE and BOOTSTD_FULL Kconfig options.

Patch 11-13 sort and update use of bootph properties.

Patch 14-15 enable use of pinctrl and aliases in SPL.

Patch 16-21 fixes minor issues observed with newly added boards.

Patch 22 enables options on rk3588-edgeble-neu6 boards to closer match
other RK35xx boards.

Patch 23-28 adds SPI flash and USB OTG support to the rk35xx-generic
boards.

Changes in v3:
- Split patches
- Add patch to fix SPI flash clk rate on new board DTs.
- Drop patch to use of HS200 mode on a few RK3588 boards, mmc maintainer
  accepted the patch that will imply hs200 support when hs400 support is
  declared
- Collect a-b and r-b tags

Changes in v2:
- Add patch to fix use of HS200 mode on a few RK3588 boards
- Follow kernel sort order for DT props
- Fix Makefile entry from .dts to .dtb
- Split rk35xx-generic related patches
- Collect r-b tags

Jonas Karlman (28):
  clk: rockchip: rk356x: Add CLK_USB3OTGx_REF support
  clk: rockchip: rk3588: Add REF_CLK_USB3OTGx support
  clk: rockchip: rk356x: Fix set rate of SCLK_SFC clock
  rockchip: rk35xx: Drop USB_GADGET_PRODUCT_NUM Kconfig option
  rockchip: rk3588: Drop REGULATOR_PWM Kconfig option
  rockchip: rk3566-anbernic-rgxx3: Remove SPL_ROCKCHIP_BACK_TO_BROM
    option
  rockchip: rk35xx: Sort imply statements alphabetically
  rockchip: rk35xx: Enable random generator
  rockchip: rk35xx: Imply support for GbE PHY
  rockchip: rk356x: Imply enhanced features for standard boot
  rockchip: rk35xx: Sort soc u-boot.dtsi alphabetically
  rockchip: rk356x: Update bootph props
  rockchip: rk3588: Update bootph props
  rockchip: rk3568-evb: Use pinctrl in SPL
  rockchip: rk3588-evb: Use pinctrl and aliases in SPL
  rockchip: rk3566-pinetab2: Fix reading FIT from SPI flash
  rockchip: rk3588-coolpi: Add boards to documentation
  rockchip: rk3588-coolpi: Fix .dtb-file entries in Makefile
  rockchip: rk3588-toybrick: Use pinctrl and aliases in SPL
  rockchip: rk3588-toybrick: Add .dtb-file entry in Makefile
  rockchip: rk3588-turing-rk1: Use dwc3-generic driver
  rockchip: rk3588-edgeble-neu6: Enable FIT checksum validation
  rockchip: rk356x-generic: Fix eMMC and SD-card pinctrl
  rockchip: rk356x-generic: Add support for SPI flash
  rockchip: rk356x-generic: Add support for USB OTG
  rockchip: rk3588-generic: Use M0 iomux for UART2
  rockchip: rk3588-generic: Add support for USB OTG
  rockchip: rk35xx-generic: Disable unused features

 arch/arm/dts/Makefile                         |   5 +-
 .../arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi |   6 -
 arch/arm/dts/rk3566-pinetab2-u-boot.dtsi      |  25 ++-
 arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi    |   8 +-
 arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi    |   4 +-
 arch/arm/dts/rk3568-generic-u-boot.dtsi       |   7 +
 arch/arm/dts/rk3568-generic.dts               |  37 ++++-
 arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi     |   7 +-
 arch/arm/dts/rk3568-rock-3a-u-boot.dtsi       |   5 +-
 arch/arm/dts/rk356x-u-boot.dtsi               | 150 ++++++++++--------
 .../arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi |   8 +-
 arch/arm/dts/rk3588-generic-u-boot.dtsi       |  22 +++
 arch/arm/dts/rk3588-generic.dts               |   3 +-
 arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi     |  12 +-
 .../dts/rk3588-orangepi-5-plus-u-boot.dtsi    |   7 +-
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi       |   8 +-
 arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi    |   6 +-
 arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi    |   8 +-
 arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi   |   9 +-
 arch/arm/dts/rk3588s-u-boot.dtsi              | 126 ++++++++-------
 arch/arm/mach-rockchip/Kconfig                |  31 ++--
 configs/anbernic-rgxx3-rk3566_defconfig       |   4 -
 configs/bpi-r2-pro-rk3568_defconfig           |   1 -
 configs/evb-rk3568_defconfig                  |   3 +-
 configs/evb-rk3588_defconfig                  |   5 +-
 configs/generic-rk3568_defconfig              |  30 ++++
 configs/generic-rk3588_defconfig              |  16 ++
 configs/neu6a-io-rk3588_defconfig             |   8 +-
 configs/neu6b-io-rk3588_defconfig             |   8 +-
 configs/pinetab2-rk3566_defconfig             |   2 +-
 configs/quartzpro64-rk3588_defconfig          |   1 -
 configs/rock5b-rk3588_defconfig               |   2 -
 configs/toybrick-rk3588_defconfig             |   5 +-
 configs/turing-rk1-rk3588_defconfig           |   3 -
 doc/board/rockchip/rockchip.rst               |   2 +
 drivers/clk/rockchip/clk_rk3568.c             |  36 ++---
 drivers/clk/rockchip/clk_rk3588.c             |   6 +
 37 files changed, 390 insertions(+), 236 deletions(-)

-- 
2.43.2

