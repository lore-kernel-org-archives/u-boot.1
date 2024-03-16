Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647E2C54E68
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 22:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4972088073;
	Sat, 16 Mar 2024 23:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="rogL0j+O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64C3A87B30; Sat, 16 Mar 2024 23:57:20 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BEF488018
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 23:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b2e=KX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1710629821;
 bh=8dCAu15ruYzxOXXo0casJX96GR0z3JjAaJ8VQNlIv84=;
 b=rogL0j+OB+bl/yGkVOVE0JamuzuRDnbGi6efeye90mDeJBuupmyYotIUD9hHYQ/7YxnrbixmK
 LzkfNryrHUzmqmhywvQ/kVGT9LUC4SFZbRHfb7WMcQ5FGnvHo/PFs+QyPBL1O9i3HZuequIcQWv
 HnYQ+pnTl1ceHpra3EcC/NxdCr97cNW14KrGvhSNG3JU8Rl4NL+Y2hNkGPo6Y9K5ID5tseuJ5xA
 hj3RHXhxPprG++YkuDtgN0UAuYRFIiHgW59Nr79vphIyxPfaESWArJnHXnTh+lcbcVgG+au12Im
 D5uRgxYJtR5LGgTnEVtgddCPVevTNeo9FV0wtbt5rnUQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 00/13] rockchip: rk3308: Sync DT with linux v6.8 and update
 defconfigs
Date: Sat, 16 Mar 2024 22:56:26 +0000
Message-ID: <20240316225655.3244348-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f623bd0957eaab7babfc7b
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

This series adds support for new clocks used in linux v6.8 device trees,
enables use of FIT signature check for checksum validation and fixes
loading FIT from SD-card when loading FIT from eMMC fails.

After this series it should be possible to move RK3308 boards to use
OF_UPSTREAM in a future patch once dts/upstream move to a v6.8+ tag.

I have runtime tested this series on a Radxa ROCK Pi S v1.3 having a
RK3308B soc. Following was tested and now working after this: SD-card,
eMMC (SD NAND), Ethernet, USB host and USB gadget (RockUSB and UMS).

Finley Xiao (1):
  clk: rockchip: rk3308: Add support for SCLK_RTC32K clock

Jonas Karlman (12):
  board: rockchip: rk3308: Add device tree files and myself to
    MAINTAINERS
  rockchip: rk3308: Sort imply statements alphabetically
  rockchip: rk3308: Enable ARMv8 crypto and FIT checksum validation
  rockchip: rk3308: Generate ethaddr based on cpu id
  rockchip: rk3308: Enable random generator
  rockchip: rk3308: Fix loading FIT from SD-card when booting from eMMC
  clk: rockchip: rk3308: Add dummy support for USB480M clock
  phy: rockchip-inno-usb2: Add support for RK3308
  rockchip: rk3308: Sync device tree from linux v6.8
  rockchip: rk3308-evb: Update defconfig
  rockchip: rk3308-roc-cc: Update defconfig
  rockchip: rk3308-rock-pi-s: Update defconfig

 arch/arm/dts/rk3308-evb-u-boot.dtsi           |   11 +-
 arch/arm/dts/rk3308-evb.dts                   |  104 +-
 arch/arm/dts/rk3308-roc-cc-u-boot.dtsi        |   30 +-
 arch/arm/dts/rk3308-roc-cc.dts                |   83 +-
 arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi     |   44 +-
 arch/arm/dts/rk3308-rock-pi-s.dts             |  100 +-
 arch/arm/dts/rk3308-u-boot.dtsi               |  104 +-
 arch/arm/dts/rk3308.dtsi                      | 1205 +++++++++--------
 arch/arm/include/asm/arch-rk3308/cru_rk3308.h |   14 +
 arch/arm/mach-rockchip/Kconfig                |   19 +-
 arch/arm/mach-rockchip/rk3308/Kconfig         |    3 -
 board/firefly/firefly-rk3308/MAINTAINERS      |    1 +
 board/rockchip/evb_rk3308/MAINTAINERS         |    5 +-
 configs/evb-rk3308_defconfig                  |   37 +-
 configs/roc-cc-rk3308_defconfig               |   40 +-
 configs/rock-pi-s-rk3308_defconfig            |   36 +-
 drivers/clk/rockchip/clk_rk3308.c             |   99 ++
 drivers/net/gmac_rockchip.c                   |    2 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c |   20 +
 19 files changed, 1152 insertions(+), 805 deletions(-)

-- 
2.43.2

