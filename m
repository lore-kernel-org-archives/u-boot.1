Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05C5D232C6
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 00:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E60E0841FF;
	Fri,  9 Jan 2026 01:50:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="UpCZgxZZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 570158415E; Fri,  9 Jan 2026 01:50:20 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CCAC84144
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 01:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d19=7O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1767919816;
 bh=TE6Nk+WsNnIkLiQ4aj7adJNhXnXSM/j0yqlowCEsxpg=;
 b=UpCZgxZZz1upynQSP2V0ua82tMk7nfalXqr9ceOcx2VJNplP6b+wZTEx4wrunMjTn7FIOeYu+
 nR9jRj9fVmZJMD+ms6dJb9gJaeiaFzrtfOMGAwf5JdEL1wEn+/2fyKjeqS0hPKY1zK7HfTOfDek
 qxH8KGbXXHDNDwdkNN4VLF82LnKP6NlgNB0E5xd6/2x7K/H6qlVgyTP5u1BEhoruO8xWEMTJDB6
 KoIEs3Kqarjz6co17Qbz6atVbaz2W/g0R0TUq/qX8UO8LKzXSR3rgnQoWaV7K5mumeQmQT4Moh0
 sWeEzNbMAjlMAMSBeTlecZBTO/5BODyFFGURmutILeBQ==
X-Forward-Email-ID: 696050c5abab7b035309fa26
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.2.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 00/10] rockchip: Add initial support for RK3506
Date: Fri,  9 Jan 2026 00:49:41 +0000
Message-ID: <20260109005008.101506-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
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

This series add initial support for the Rockchip RK3506 SoC.

Clk and pinctrl drivers have been imported from vendor U-Boot with
some adjustments and fixes.

Upstream DT is currently not existing for RK3506, so this series does
not add support for any new boards, it only add initial arch support.

Please see my U-Boot rk3506 branch at [1] for a few more commits that
add DTs and defconfig for e.g. Luckfox Lyra variants and ArmSoM Forge1.

With this series, board DTs and defconfigs it should be possible to boot
into U-Boot proper (without OP-TEE) and still have support for MMC,
Ethernet, OTP, RNG, LEDs, buttons and USB gadget/host.

[1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3506

Finley Xiao (2):
  dt-bindings: clock: rockchip: Add RK3506 clock and reset unit
  clk: rockchip: Add support for RK3506

Jonas Karlman (6):
  ram: rockchip: Add basic support for RK3506
  pinctrl: rockchip: Use syscon_regmap_lookup_by_phandle()
  rockchip: otp: Add support for RK3506
  phy: rockchip-inno-usb2: Add support for RK3506
  net: dwc_eth_qos_rockchip: Add support for RK3506
  arch: arm: rockchip: Add initial support for RK3506

Xuhui Lin (1):
  rockchip: mkimage: Add support for RK3506

Ye Zhang (1):
  pinctrl: rockchip: Add support for RK3506

 arch/arm/include/asm/arch-rk3506/boot0.h      |    9 +
 arch/arm/include/asm/arch-rk3506/gpio.h       |    9 +
 arch/arm/include/asm/arch-rockchip/clock.h    |   10 +
 .../include/asm/arch-rockchip/cru_rk3506.h    |  220 +++
 arch/arm/mach-rockchip/Kconfig                |   43 +
 arch/arm/mach-rockchip/Makefile               |    1 +
 arch/arm/mach-rockchip/rk3506/Kconfig         |   15 +
 arch/arm/mach-rockchip/rk3506/Makefile        |    5 +
 arch/arm/mach-rockchip/rk3506/clk_rk3506.c    |   16 +
 arch/arm/mach-rockchip/rk3506/rk3506.c        |  130 ++
 arch/arm/mach-rockchip/rk3506/syscon_rk3506.c |   19 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk_rk3506.c             | 1212 +++++++++++++++++
 drivers/misc/rockchip-otp.c                   |    4 +
 drivers/net/dwc_eth_qos.c                     |    4 +
 drivers/net/dwc_eth_qos_rockchip.c            |   86 ++
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c |   20 +
 drivers/pinctrl/rockchip/Makefile             |    1 +
 drivers/pinctrl/rockchip/pinctrl-rk3506.c     |  462 +++++++
 .../pinctrl/rockchip/pinctrl-rockchip-core.c  |   46 +-
 drivers/pinctrl/rockchip/pinctrl-rockchip.h   |    1 +
 drivers/ram/rockchip/Makefile                 |    1 +
 drivers/ram/rockchip/sdram_rk3506.c           |   33 +
 drivers/reset/Makefile                        |    2 +-
 drivers/reset/rst-rk3506.c                    |  222 +++
 drivers/usb/gadget/Kconfig                    |    1 +
 .../Bindings/clock/rockchip,rk3506-cru.yaml   |   55 +
 .../dt-bindings/clock/rockchip,rk3506-cru.h   |  285 ++++
 .../dt-bindings/reset/rockchip,rk3506-cru.h   |  211 +++
 include/configs/rk3506_common.h               |   38 +
 tools/rkcommon.c                              |    1 +
 31 files changed, 3136 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-rk3506/boot0.h
 create mode 100644 arch/arm/include/asm/arch-rk3506/gpio.h
 create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rk3506.h
 create mode 100644 arch/arm/mach-rockchip/rk3506/Kconfig
 create mode 100644 arch/arm/mach-rockchip/rk3506/Makefile
 create mode 100644 arch/arm/mach-rockchip/rk3506/clk_rk3506.c
 create mode 100644 arch/arm/mach-rockchip/rk3506/rk3506.c
 create mode 100644 arch/arm/mach-rockchip/rk3506/syscon_rk3506.c
 create mode 100644 drivers/clk/rockchip/clk_rk3506.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3506.c
 create mode 100644 drivers/ram/rockchip/sdram_rk3506.c
 create mode 100644 drivers/reset/rst-rk3506.c
 create mode 100644 dts/upstream/Bindings/clock/rockchip,rk3506-cru.yaml
 create mode 100644 dts/upstream/include/dt-bindings/clock/rockchip,rk3506-cru.h
 create mode 100644 dts/upstream/include/dt-bindings/reset/rockchip,rk3506-cru.h
 create mode 100644 include/configs/rk3506_common.h

-- 
2.52.0

