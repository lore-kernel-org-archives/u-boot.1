Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633C8C48260
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 00:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12E5587E46;
	Sat, 17 Feb 2024 01:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fXEQFSfV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D63098718A; Sat, 17 Feb 2024 01:23:45 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60C368272A
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 01:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4c2a=J2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1708129393;
 bh=PS/ddlL/+EiLvWborLlxa5oXnyhP53lS+9xPhvDL2PA=;
 b=fXEQFSfVt6Br6/SMXFmBrwlJP+SSYsb32nyklzj5iK9Yzp12iDWqcGNeYsG3xqu1S2KZJIf/n
 L8A/CHGYKKkSHxD3ZenTR4BbuhuRuSkQHsT8HlIDFyw5nf4lSSBG0bsxblXUn9eOJFmxmrlWFUg
 sJNgnrFyYaLJKw5Ynj7SNeAv8Ue2jmSt3NIDkK1QOWRlw7eUfjx9bMECmKdZd9fi+NsW+72sRaP
 RvDiicVAum56XawmfyNB7ygT+BZM6bzRsuI9+oyvhfW0X62dI0zDqJl9bSCb7/krOLbv68ibB31
 0cj6Qfoovf9MGpAMistD9Hi8mlPUFgNvipeUl+bPn4dQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Tianling Shen <cnsztl@gmail.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 00/15] rockchip: rk3328: Update defconfigs,
 DTs and enable boot from SPI
Date: Sat, 17 Feb 2024 00:22:26 +0000
Message-ID: <20240217002304.2141064-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65cffc6fbb96cee8b5411e7a
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

This series contains miscellaneous updates to defconfigs, syncs latest
device trees from linux, fixes an issue loading FIT from SD-card when
running SPL from eMMC and enables building a bootable SPI image on
RK3328 boards.

I am also adding myself as a reviewer for the three RK3328 boards I own.

Patch 1-7 updates boards to enable similar Kconfig options and use a
common order for from where to try and load FIT.

Patch 8 fix loading FIT from SD-card when booting from eMMC by using
pinctrl for emmc and sdmmc in SPL.

Patch 9-10 makes rockchip gpio and rng driver compatible with linux.

Patch 11 sync latest rk3328 device tree files from linux v6.8-rc1.

Patch 12 reverts an old commit that added duplicated code.

Patch 13-15 enables building u-boot-rockchip-spi.bin for boards with
SPI flash.

Changes in v2:
- Remove unused SPL drivers, I2C and PMIC
- Add helpful CMD_GPIO and CMD_REGULATOR to boards
- Add missing UART2 pinctrl nodes to soc u-boot.dtsi
- Mark the pinctrl node to be included in U-Boot proper pre-reloc phase
- Add SD-card IO-voltage related nodes to nanopi-r2 u-boot.dtsi
- Fix an ethernet issue on orangepi-r1-plus-lts
- Include SPI flash pinctrl nodes in SPL
- Collect r-b tags

This series depends on the "rockchip: Update stack and bss addresses on
RK3328 and RK3399" series at [1] being applied _after_ this series.
Some boards may go over the simple malloc limit without that series also
applied.

See [2] for a branch with the dependent series applied.

[1] https://patchwork.ozlabs.org/cover/1887729/
[2] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3328-update-v2

Jonas Karlman (15):
  rockchip: rk3328: Update default u-boot,spl-boot-order prop
  rockchip: rk3328-evb: Update defconfig
  rockchip: rk3328-rock64: Update defconfig
  rockchip: rk3328-roc-cc: Update defconfig
  rockchip: rk3328-rock-pi-e: Update defconfig
  rockchip: rk3328-nanopi-r2: Update defconfig
  rockchip: rk3328-orangepi-r1-plus: Update defconfig
  rockchip: rk3328: Fix loading FIT from SD-card when booting from eMMC
  gpio: rockchip: Use gpio alias id as gpio bank id
  rng: rockchip: Use same compatible as linux
  rockchip: rk3328: Sync device tree from linux v6.8-rc1
  Revert "rockchip: Allow booting from SPI"
  rockchip: rk3328: Add support to build bootable SPI image
  rockchip: rk3328-rock64: Enable boot from SPI NOR flash
  rockchip: rk3328-orangepi-r1-plus: Enable boot from SPI NOR flash

 arch/arm/dts/rk3328-evb-u-boot.dtsi           |   4 +
 arch/arm/dts/rk3328-evb.dts                   |   1 +
 .../dts/rk3328-nanopi-r2c-plus-u-boot.dtsi    |   6 -
 arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi    |  24 +---
 arch/arm/dts/rk3328-nanopi-r2s.dts            |   3 +-
 .../rk3328-orangepi-r1-plus-lts-u-boot.dtsi   |  32 ++----
 arch/arm/dts/rk3328-orangepi-r1-plus-lts.dts  |   4 +-
 .../dts/rk3328-orangepi-r1-plus-u-boot.dtsi   |  32 ++----
 arch/arm/dts/rk3328-orangepi-r1-plus.dts      |   1 +
 arch/arm/dts/rk3328-roc-cc-u-boot.dtsi        |  22 +---
 arch/arm/dts/rk3328-roc-cc.dts                |   3 +-
 arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi     |  17 ---
 arch/arm/dts/rk3328-rock-pi-e.dts             |  55 +++++++++
 arch/arm/dts/rk3328-rock64-u-boot.dtsi        |  28 ++---
 arch/arm/dts/rk3328-rock64.dts                |   1 +
 arch/arm/dts/rk3328-u-boot.dtsi               | 108 +++++++++++++++---
 arch/arm/dts/rk3328.dtsi                      |  64 ++++++++---
 arch/arm/dts/rk3399-u-boot.dtsi               |   2 +-
 arch/arm/mach-rockchip/rk3328/rk3328.c        |   1 +
 arch/arm/mach-rockchip/spl-boot-order.c       |   3 -
 board/rockchip/evb_rk3328/MAINTAINERS         |  11 ++
 board/rockchip/evb_rk3328/README              |  70 ------------
 configs/evb-rk3328_defconfig                  |  22 +++-
 configs/nanopi-r2c-plus-rk3328_defconfig      |  20 +++-
 configs/nanopi-r2c-rk3328_defconfig           |  20 +++-
 configs/nanopi-r2s-rk3328_defconfig           |  20 +++-
 configs/orangepi-r1-plus-lts-rk3328_defconfig |  29 ++++-
 configs/orangepi-r1-plus-rk3328_defconfig     |  29 ++++-
 configs/roc-cc-rk3328_defconfig               |  15 ++-
 configs/rock-pi-e-rk3328_defconfig            |  17 +--
 configs/rock64-rk3328_defconfig               |  23 +++-
 doc/board/rockchip/rockchip.rst               |   9 +-
 drivers/gpio/rk_gpio.c                        |   7 +-
 drivers/rng/rockchip_rng.c                    |  10 +-
 34 files changed, 432 insertions(+), 281 deletions(-)
 delete mode 100644 board/rockchip/evb_rk3328/README

-- 
2.43.0

