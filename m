Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4D2C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 22:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE0DE88C41;
	Sat,  3 Aug 2024 00:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LP+efxVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0FEF88C37; Sat,  3 Aug 2024 00:57:21 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6D6588BFF
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 00:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5651=PC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1722639432;
 bh=jxwfDpPnVeviVdowihujm+nLywaXnIMuK3cy90NfaIs=;
 b=LP+efxVeOCWTk3UtSrccKlsNEzyfwd8G4nDoL9VIAS2CMsHHC2qhw9mB/IOiZgSNcX3+PRMBs
 XC9jB+P87/LPkyRkjXCLWK20jD80m8kGswj6NJKZS52ylLLXS92u+R7J8Fz4jcitlVC+8xTvmhy
 3D5pDeKXvXkwU0J2GdO7ELfSc3eA9dzHqkulM8IvepJsnRalr0SPVtJ7QMdTNxA4WTBJlwLDPY2
 MNpoAj3rTAvNQGwQgVHpr5f1oGkI2YTHWaCmUmdQ6uaem+RZbUug+F3Ah33wmZOTc0BX/uw7uMM
 qc4II3aSQjgY8jNlYvEUTjL51Sh4g2/Rw8vQPoR1R/hw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 00/10] rockchip: pinctrl: Add support for pinmux status cmd
Date: Fri,  2 Aug 2024 22:56:42 +0000
Message-ID: <20240802225705.2640999-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66ad644516ac7a56c917ae67
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

This series includes some cleanup, add support for using the pinmux
status cmd and add support for the gpio request ops.

Following is an example on a Radxa ROCK 5A (RK3588S):

  => pinmux dev pinctrl
  dev: pinctrl
  => pinmux status
  GPIO0_A0  : gpio
  GPIO0_A1  : func-2
  GPIO0_A2  : gpio
  GPIO0_A3  : gpio
  GPIO0_A4  : func-1
  GPIO0_A5  : func-2
  GPIO0_A6  : gpio
  GPIO0_A7  : gpio
  GPIO0_B0  : gpio
  GPIO0_B1  : gpio
  GPIO0_B2  : gpio
  GPIO0_B3  : gpio
  GPIO0_B4  : gpio
  GPIO0_B5  : func-10
  GPIO0_B6  : func-10
  GPIO0_B7  : gpio
  [...]

and on a ASUS TinkerBoard R2.0 (RK3288W):

  => pinmux dev pinctrl
  dev: pinctrl
  => pinmux status
  [...]
  GPIO2_C6  : gpio
  GPIO2_C7  : gpio
  GPIO2_D0  : unrouted
  GPIO2_D1  : unrouted
  GPIO2_D2  : unrouted
  GPIO2_D3  : unrouted
  GPIO2_D4  : unrouted
  GPIO2_D5  : unrouted
  GPIO2_D6  : unrouted
  GPIO2_D7  : unrouted
  GPIO3_A0  : func-2
  GPIO3_A1  : func-2
  [...]

Patch 1 refactor to use syscon_regmap_lookup_by_phandle() helper.
Patch 6 refactor to get pinctrl device from gpio-ranges prop.

Patch 2, 3 and 7 change to use pinctrl pin offset instead of bank num to
get current pinmux.
Patch 4 add required ops for use of the pinmux status cmd.

Patch 5 and 8 add gpio_request_enable() and request() ops.

Patch 9 add gpio-ranges props for remaining RK SoCs, this is strictly
not needed for pinmux status cmd to function. However, the change to not
require the pin controller offset to be 32 aligned was required to add
gpio-ranges props for RK3288.

Patch 10 add gpio aliases for RK SoCs that is missing alias for gpio
controllers.

Changes in v2:
- Drop fixes patches already applied
- Split adding pin_to_bank() helper into own patch
- Add gpio_request_enable() and request() ops patch from the "rockchip:
  Add gpio request() ops" series
- Add missing gpio aliases
- Collect r-b tags

Jonas Karlman (10):
  pinctrl: rockchip: Use syscon_regmap_lookup_by_phandle()
  pinctrl: rockchip: Add a pin_to_bank() helper
  pinctrl: rockchip: Update get_gpio_mux() ops
  pinctrl: rockchip: Add pinmux status related ops
  pinctrl: rockchip: Add gpio_request_enable() ops
  gpio: rockchip: Get pinctrl device from gpio-ranges prop
  gpio: rockchip: Use pinctrl pin offset to get_gpio_mux()
  gpio: rockchip: Add request() ops
  rockchip: gpio: Add gpio-ranges props
  rockchip: gpio: Add missing gpio aliases

 arch/arm/dts/px30-u-boot.dtsi                 |   4 +
 arch/arm/dts/rk3036-u-boot.dtsi               |  12 ++
 arch/arm/dts/rk3066a-u-boot.dtsi              |  10 +-
 arch/arm/dts/rk3128-u-boot.dtsi               |  16 ++
 arch/arm/dts/rk322x-u-boot.dtsi               |  16 ++
 arch/arm/dts/rk3288-u-boot.dtsi               |  42 ++++--
 arch/arm/dts/rk3308-u-boot.dtsi               |  20 +++
 arch/arm/dts/rk3328-u-boot.dtsi               |  13 ++
 arch/arm/dts/rk3368-u-boot.dtsi               |  16 ++
 arch/arm/dts/rk3399-u-boot.dtsi               |  20 +++
 arch/arm/dts/rk3xxx-u-boot.dtsi               |   7 +
 arch/arm/dts/rv1108-u-boot.dtsi               |  25 +++
 arch/arm/dts/rv1126-u-boot.dtsi               |  22 +++
 drivers/gpio/rk_gpio.c                        |  54 +++++--
 .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 142 ++++++++++++++----
 15 files changed, 364 insertions(+), 55 deletions(-)

-- 
2.45.2

