Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168A8C6FD1F
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 19:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EB978824E;
	Fri, 29 Mar 2024 20:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="xi7lOf/+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C2F988253; Fri, 29 Mar 2024 20:02:46 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C56087FC1
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 20:02:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=52ff=LE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1711738952;
 bh=pZLGsv2ZYmbZRfj6gcdSI2CHTKY9x2dpObOlw2Qbysw=;
 b=xi7lOf/+R+jtCHycStpMRmtEB2LVeY0dZeWiDT8kgFMGFvOeMZJ7JAl0mcVUTI0z9CZ+Rss1t
 lL5LQ2eU36+Y3mOZZz+QnNso7d6Zs+Nb6WIQGdQxHdezUj77+lc0FFl5XodaC929W2IQhPynqKB
 75lIVrn2EWHSOZ3u8D/Z+Pn0KasnFhJz4AqOWWEn3zhIZSfW15/rnLYZRdrRZWIcC+Mguvcs303
 fkbACcDeaZ6JBeMjRV9YasxaIiCcbT1Fy32X7sQ5oYRjydHM2F9GCqfB65KlvGB/vBaKmqpd3UC
 Ri8rKaCjLQ3dBZRNF2DptE6eOSNh2aTjTu+cXO6/5QFw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 00/19] rockchip: rk35xx: Miscellaneous fixes and updates
Date: Fri, 29 Mar 2024 19:01:41 +0000
Message-ID: <20240329190224.3613471-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66071047c77850cc7d0ca03a
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

Patch 3-5 drops unnecessary Kconfig options.

Patch 6-9 sort and imply RNG, PHY_GIGE and BOOTSTD_FULL Kconfig options.

Patch 10-12 sort and update use of bootph properties.

Patch 13-16 fixes minor issues observed with newly added boards.

Patch 17 enables options on rk3588-edgeble-neu6 boards to closer match
other RK35xx boards.

Patch 18-19 adds SPI flash and USB OTG support to the rk35xx-generic
boards.

Jonas Karlman (19):
  clk: rockchip: rk356x: Add CLK_USB3OTGx_REF support
  clk: rockchip: rk3588: Add REF_CLK_USB3OTGx support
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
  rockchip: rk3566-pinetab2: Fix reading FIT from SPI flash
  rockchip: rk3588-coolpi: Add boards to documentation
  rockchip: rk3588-toybrick: Add missing Kconfig options
  rockchip: rk3588-turing-rk1: Use dwc3-generic driver
  rockchip: rk3588-edgeble-neu6: Enable FIT checksum validation
  rockchip: rk356x-generic: Add support for SPI flash and USB OTG
  rockchip: rk3588-generic: Add support for USB OTG

 arch/arm/dts/Makefile                         |   5 +-
 .../arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi |   6 -
 arch/arm/dts/rk3566-pinetab2-u-boot.dtsi      |  24 ++--
 arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi    |   8 +-
 arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi    |   4 +-
 arch/arm/dts/rk3568-generic-u-boot.dtsi       |   7 +
 arch/arm/dts/rk3568-generic.dts               |  38 +++++-
 arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi     |   6 +-
 arch/arm/dts/rk3568-rock-3a-u-boot.dtsi       |   3 +-
 arch/arm/dts/rk356x-u-boot.dtsi               | 125 +++++++++---------
 .../arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi |   5 +-
 arch/arm/dts/rk3588-generic-u-boot.dtsi       |  22 +++
 arch/arm/dts/rk3588-generic.dts               |   4 +-
 arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi     |   9 +-
 .../dts/rk3588-orangepi-5-plus-u-boot.dtsi    |   6 +-
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi       |   5 +-
 arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi    |   6 +-
 arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi    |   5 +-
 arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi   |   8 +-
 arch/arm/dts/rk3588s-u-boot.dtsi              |  98 +++++++-------
 arch/arm/mach-rockchip/Kconfig                |  31 +++--
 configs/anbernic-rgxx3-rk3566_defconfig       |   4 -
 configs/bpi-r2-pro-rk3568_defconfig           |   1 -
 configs/evb-rk3568_defconfig                  |   3 +-
 configs/evb-rk3588_defconfig                  |   5 +-
 configs/generic-rk3568_defconfig              |  31 +++++
 configs/generic-rk3588_defconfig              |  17 +++
 configs/neu6a-io-rk3588_defconfig             |   8 +-
 configs/neu6b-io-rk3588_defconfig             |   8 +-
 configs/pinetab2-rk3566_defconfig             |   2 +-
 configs/quartzpro64-rk3588_defconfig          |   1 -
 configs/rock5b-rk3588_defconfig               |   2 -
 configs/toybrick-rk3588_defconfig             |   6 +-
 configs/turing-rk1-rk3588_defconfig           |   6 +-
 doc/board/rockchip/rockchip.rst               |   2 +
 drivers/clk/rockchip/clk_rk3568.c             |   4 +
 drivers/clk/rockchip/clk_rk3588.c             |   6 +
 37 files changed, 332 insertions(+), 199 deletions(-)

-- 
2.43.2

