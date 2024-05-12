Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849ECC10F1A
	for <u-boot@archiver.kernel.org>; Sun, 12 May 2024 12:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E4C38817B;
	Sun, 12 May 2024 14:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="aUR4JkFP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8CBF88087; Sun, 12 May 2024 14:17:40 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE82587F33
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 14:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bf9f=MQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1715516214;
 bh=OB4m/RFoj8iiRvtiwu00GtPC30Dvr/uboBJ9uRhWB+Y=;
 b=aUR4JkFPKjn3S1JlgTZ4f9tgdnSNXKE7CE8LSEfsxXr2U5GOV+uVkamD75hrdhXvnlTnQ6dfC
 dGPbjqJT8Ua8BQ0Xsyk5MIb0DZl69FUAFGd65B3LXrghQoIyBYnkjOyr5A3BGOmindmThvvjvJv
 LoglS6fTCIUC6jduwi051fYQO6oJdkUx4P4iuOxWCEpnkJcS7dwo6Eu0VrocGQH4aG+A/yMOQkS
 +CCgHar0kzz46XDvUVHUcMCcfuVwiwsutM6qGjyt/mjgcczOGbD3T9L4Am34VYlZnxAN44IzjG6
 0CHul3zNkFo+Da1I8Om+h7Z0fHoizaiN/qQ9GxN96S/w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, Alex Bee <knaerzche@gmail.com>, Mark
 Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 0/9] rockchip: pinctrl: Minor fixes and add support for pinmux
 status cmd
Date: Sun, 12 May 2024 12:16:13 +0000
Message-ID: <20240512121633.1632597-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6640b3281cfb9f69e9a4efd6
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

This series includes some minor fixes, cleanup and add support for using
the pinmux status cmd.

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

Patch 1-3 are minor fixes so that correct pinmux status is reported.

Patch 4 refactor to use syscon_regmap_lookup_by_phandle() helper.
Patch 6 refactor to get pinctrl device from gpio-ranges prop.

Patch 5 and 7 change to use pinctrl pin offset instead of bank num to
get current pinmux.

Patch 8 add required ops for use of the pinmux status cmd.

Patch 9 add gpio-ranges props for remaining RK SoCs, this is strictly
not needed for pinmux status cmd to function. However, the change to not
require the pin controller offset to be 32 aligned was required to add
gpio-ranges props for RK3288.

This series depends on the "rockchip: Add gpio request() ops and drop
PCIe reset-gpios workaround" [1] series.

[1] https://patchwork.ozlabs.org/cover/1934100/

Jonas Karlman (9):
  pinctrl: rockchip: rk3188: Fix support for IOMUX_GPIO_ONLY flag
  pinctrl: rockchip: rv1126: Fix support for IOMUX_L_SOURCE_PMU flag
  pinctrl: rockchip: rk3588: Fix support for rockchip_get_mux()
  pinctrl: rockchip: Use syscon_regmap_lookup_by_phandle()
  pinctrl: rockchip: Update get_gpio_mux() ops
  gpio: rockchip: Get pinctrl device from gpio-ranges prop
  gpio: rockchip: Use pinctrl pin offset to get_gpio_mux()
  pinctrl: rockchip: Add pinmux status related ops
  rockchip: gpio: Add gpio-ranges props

 arch/arm/dts/rk3036-u-boot.dtsi               |  12 ++
 arch/arm/dts/rk3066a-u-boot.dtsi              |   3 +-
 arch/arm/dts/rk3128-u-boot.dtsi               |  16 ++
 arch/arm/dts/rk322x-u-boot.dtsi               |  16 ++
 arch/arm/dts/rk3288-u-boot.dtsi               |  33 ++++
 arch/arm/dts/rk3308-u-boot.dtsi               |  20 +++
 arch/arm/dts/rk3328-u-boot.dtsi               |  13 ++
 arch/arm/dts/rk3368-u-boot.dtsi               |  16 ++
 arch/arm/dts/rk3399-u-boot.dtsi               |  20 +++
 arch/arm/dts/rv1108-u-boot.dtsi               |  16 ++
 arch/arm/dts/rv1126-u-boot.dtsi               |  14 ++
 drivers/gpio/rk_gpio.c                        |  44 +++--
 .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 151 ++++++++++++++----
 13 files changed, 322 insertions(+), 52 deletions(-)

-- 
2.43.2

