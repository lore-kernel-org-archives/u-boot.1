Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B493C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 18:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB500879E2;
	Mon,  8 Apr 2024 20:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="gz1b1VIt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEAD8879E2; Mon,  8 Apr 2024 20:14:48 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 416BB878ED
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 20:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d79=LO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1712600075;
 bh=1x3MubbyIEP7UxSJP6pKrE6gE9WUJtSOJ7b3bdZ10xg=;
 b=gz1b1VItU5gCpRe7fVX2p+t9rwhNB0TbgTtMiRSpfHJlyApcdSwsrT2FDT+FTHOt/kJ9OzrkW
 4AMT94Pt12EFcx2lBVANBx3TlRnPxWN9XZV73g7cXSywGnjGY7/DI2vv920Le/toIxWYgcOp5dq
 GoagEaE+NUgWwKQR1CaT5T0rN0lNa3/XSBaGQ9FTxItw/xmOZkto34UF4Y4PXzzpMcy8j3it8HT
 90FYWRF/p5Io4jGRQxt8Ro8eTTF/EL4xhPbpYFYY8kNowh4LNek+gohzP0W9h0ksEIIWDRMhh4D
 Tect2mAAt1e5w1WyIlOlSXGrOq+PFsQ1wyLSUidUDCvQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 00/14] rockchip: rk3308: Sync DT with linux v6.8 and update
 defconfigs
Date: Mon,  8 Apr 2024 18:13:57 +0000
Message-ID: <20240408181429.3676856-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6614340a45fff4c2aa5b49e4
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

It should be possible to move RK3308 boards to use OF_UPSTREAM in a
future series after this has been applied.

I have runtime tested this series on a Radxa ROCK Pi S v1.3 having a
RK3308B SoC. Following was tested and now working after this: SD-card,
eMMC (SD NAND), Ethernet, USB host and USB gadget (RockUSB and UMS).

Changes in v2:
- Add clocks and resets props to otp node
- Add bootph-some-ram to emmc and sdmmc pinctrl nodes
- Sort bootph-all prop after compatible and reg props
- Fix rk3308-evb debug uart
- New patch to move cru and grf include files to arch-rockchip

Finley Xiao (1):
  clk: rockchip: rk3308: Add support for SCLK_RTC32K clock

Jonas Karlman (13):
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
  rockchip: rk3308: Move cru and grf include files to arch-rockchip

 arch/arm/dts/rk3308-evb-u-boot.dtsi           |   11 +-
 arch/arm/dts/rk3308-evb.dts                   |  104 +-
 arch/arm/dts/rk3308-roc-cc-u-boot.dtsi        |   30 +-
 arch/arm/dts/rk3308-roc-cc.dts                |   83 +-
 arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi     |   45 +-
 arch/arm/dts/rk3308-rock-pi-s.dts             |  100 +-
 arch/arm/dts/rk3308-u-boot.dtsi               |  120 +-
 arch/arm/dts/rk3308.dtsi                      | 1205 +++++++++--------
 .../cru_rk3308.h                              |   14 +
 .../grf_rk3308.h                              |    0
 arch/arm/mach-rockchip/Kconfig                |   19 +-
 arch/arm/mach-rockchip/rk3308/Kconfig         |    3 -
 arch/arm/mach-rockchip/rk3308/clk_rk3308.c    |    2 +-
 arch/arm/mach-rockchip/rk3308/rk3308.c        |    2 +-
 board/firefly/firefly-rk3308/MAINTAINERS      |    1 +
 board/firefly/firefly-rk3308/roc_cc_rk3308.c  |    2 +-
 board/rockchip/evb_rk3308/MAINTAINERS         |    5 +-
 configs/evb-rk3308_defconfig                  |   40 +-
 configs/roc-cc-rk3308_defconfig               |   40 +-
 configs/rock-pi-s-rk3308_defconfig            |   35 +-
 drivers/clk/rockchip/clk_rk3308.c             |  101 +-
 drivers/net/gmac_rockchip.c                   |    4 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c |   20 +
 drivers/ram/rockchip/sdram_rk3308.c           |    2 +-
 24 files changed, 1177 insertions(+), 811 deletions(-)
 rename arch/arm/include/asm/{arch-rk3308 => arch-rockchip}/cru_rk3308.h (95%)
 rename arch/arm/include/asm/{arch-rk3308 => arch-rockchip}/grf_rk3308.h (100%)

-- 
2.43.2

