Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0AEE7C6FA
	for <u-boot@archiver.kernel.org>; Sat, 31 Jan 2026 23:39:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73E5583B8F;
	Sun,  1 Feb 2026 00:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="S1V/tB4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59F7483B43; Sun,  1 Feb 2026 00:39:10 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D871883B0B
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 00:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=19be=AF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1769902743;
 bh=6xIB9Jm87/MKhLg+p3wDa7k3hPF2xcLauxGppi5/fZk=;
 b=S1V/tB4/X6hnKP6MmNP0SVaKmpwgqZpLDUS1pUhSC/KGRihBJ0Xo2PsHOEQ7QIkaIySoUPgoV
 /CYGlzjl6KD/ttZa2qFAMRAku/EiwLOzGc4FnixxjzXEDtn/eoAnoRwoa5KXcZWZv+s8vsSx1Jv
 NvVGMq5aSLa2vuB6O8N1t6HGKHj35LmI5C06aDtjL9BW0ks2v0rUqNUnMrfNJPMShisiDTHto65
 FFh+M5hjrd+xy0tLTsFKVy3HawQv7F03anri1g41GZS/qw2WJoPzE3n+ufeCOi7F+IuexCBXWj3
 wE5xd6GXAjdzEKCmVgPRIWmJAmVwKu7xsKIqedrhQkQA==
X-Forward-Email-ID: 697e9291de426c19931e04db
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 00/12] rockchip: Add initial support for RK3506
Date: Sat, 31 Jan 2026 23:38:11 +0000
Message-ID: <20260131233843.3419737-1-jonas@kwiboo.se>
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

Changes in v2:
- Use common handling of USB bootsource_id 0x81
- Re-sort the spl_infos list alphanumerically
- Drop use of struct rk3506_cru and of_to_plat() ops
- Define LOG_CATEGORY and use log_debug() in clk driver
- Extract rk3506_clk_init_xpl() from clk bind() ops
- Enable SPL_ARMV7_SET_CORTEX_SMPEN
- Fix mac1 and otg1 access to ddr memory
- Collect a-b and t-b tags (where applicable)

[1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3506

Finley Xiao (2):
  dt-bindings: clock: rockchip: Add RK3506 clock and reset unit
  clk: rockchip: Add support for RK3506

Jonas Karlman (8):
  rockchip: spl: Add common handling of USB bootsource_id 0x81
  rockchip: mkimage: Re-sort the spl_infos list alphanumerically
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
 .../include/asm/arch-rockchip/cru_rk3506.h    |  181 +++
 arch/arm/mach-rockchip/Kconfig                |   44 +
 arch/arm/mach-rockchip/Makefile               |    1 +
 arch/arm/mach-rockchip/rk3506/Kconfig         |   15 +
 arch/arm/mach-rockchip/rk3506/Makefile        |    5 +
 arch/arm/mach-rockchip/rk3506/clk_rk3506.c    |   16 +
 arch/arm/mach-rockchip/rk3506/rk3506.c        |  125 ++
 arch/arm/mach-rockchip/rk3506/syscon_rk3506.c |   19 +
 arch/arm/mach-rockchip/rk3528/rk3528.c        |   15 -
 arch/arm/mach-rockchip/spl.c                  |   12 +-
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk_rk3506.c             | 1166 +++++++++++++++++
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
 drivers/reset/rst-rk3506.c                    |  222 ++++
 drivers/usb/gadget/Kconfig                    |    1 +
 .../Bindings/clock/rockchip,rk3506-cru.yaml   |   55 +
 .../dt-bindings/clock/rockchip,rk3506-cru.h   |  285 ++++
 .../dt-bindings/reset/rockchip,rk3506-cru.h   |  211 +++
 include/configs/rk3506_common.h               |   38 +
 tools/rkcommon.c                              |    5 +-
 33 files changed, 3060 insertions(+), 45 deletions(-)
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

