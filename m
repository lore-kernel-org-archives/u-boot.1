Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEE8C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 21:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2871788B8E;
	Fri,  2 Aug 2024 23:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64B0788C01; Fri,  2 Aug 2024 23:00:47 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78BF488B80
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 23:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
Received: from i53875a76.versanet.de ([83.135.90.118] helo=phil.lan)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1sZzOD-0006IU-Tt; Fri, 02 Aug 2024 23:00:41 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, dsimic@manjaro.org, u-boot@lists.denx.de, jonas@kwiboo.se
Subject: [PATCH v2 0/4] U-Boot support for the Rock 5 ITX
Date: Fri,  2 Aug 2024 23:00:24 +0200
Message-Id: <20240802210028.2919639-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
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

Support for the Rock 5 ITX is now part of 6.11-rc1, so add
support for it in u-boot as well.

The naming follows Dragan's suggestion in the mainline submission:
    "the name of this board deviates from the standard Radxa naming scheme,
     which is something like "ROCK <number><letter>" thus, "rock-5a" is
     fine, but it should be "rock-5-itx", simply because there's a space
     between "5" and "ITX" in "ROCK 5 ITX"

Not sure if the u-boot side wants less dashes, but we'll see :-)

U-Boot master + this series can detect all mass storage devices
(emmc, sd, nvme) and also both PCIe connected network controllers


changes in v2:
- apply Jonas' review comments:
  - keep vcc3v3_mkey always on
  - Jonas as reviewer
  - entry in the list of Rockchip boards
  - config mass-storage support
  - config led support
  - config pmic+spi support
- add Kever's review-tag to patches 1-3

Alexey Charkov (1):
  arm64: dts: rockchip: add thermal zones information on RK3588

Dragan Simic (1):
  arm64: dts: rockchip: Prepare RK3588 SoC dtsi files for per-variant
    OPPs

Heiko Stuebner (2):
  arm64: dts: rockchip: add ROCK 5 ITX board
  board: rockchip: Add Radxa ROCK 5 ITX

 arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi    |   22 +
 arch/arm/mach-rockchip/rk3588/Kconfig         |   29 +
 board/radxa/rock-5-itx-rk3588/Kconfig         |   12 +
 board/radxa/rock-5-itx-rk3588/MAINTAINERS     |    8 +
 configs/rock-5-itx-rk3588_defconfig           |  111 +
 doc/board/rockchip/rockchip.rst               |    1 +
 ...-pinctrl.dtsi => rk3588-base-pinctrl.dtsi} |    0
 .../{rk3588s.dtsi => rk3588-base.dtsi}        |  155 +-
 ...pinctrl.dtsi => rk3588-extra-pinctrl.dtsi} |    0
 .../{rk3588.dtsi => rk3588-extra.dtsi}        |    4 +-
 .../src/arm64/rockchip/rk3588-rock-5-itx.dts  | 1177 ++++++++
 dts/upstream/src/arm64/rockchip/rk3588.dtsi   |  420 +--
 dts/upstream/src/arm64/rockchip/rk3588j.dtsi  |    2 +-
 dts/upstream/src/arm64/rockchip/rk3588s.dtsi  | 2677 +----------------
 include/configs/rock-5-itx-rk3588.h           |   15 +
 15 files changed, 1546 insertions(+), 3087 deletions(-)
 create mode 100644 arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi
 create mode 100644 board/radxa/rock-5-itx-rk3588/Kconfig
 create mode 100644 board/radxa/rock-5-itx-rk3588/MAINTAINERS
 create mode 100644 configs/rock-5-itx-rk3588_defconfig
 rename dts/upstream/src/arm64/rockchip/{rk3588s-pinctrl.dtsi => rk3588-base-pinctrl.dtsi} (100%)
 copy dts/upstream/src/arm64/rockchip/{rk3588s.dtsi => rk3588-base.dtsi} (95%)
 rename dts/upstream/src/arm64/rockchip/{rk3588-pinctrl.dtsi => rk3588-extra-pinctrl.dtsi} (100%)
 copy dts/upstream/src/arm64/rockchip/{rk3588.dtsi => rk3588-extra.dtsi} (99%)
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-rock-5-itx.dts
 rewrite dts/upstream/src/arm64/rockchip/rk3588.dtsi (99%)
 rewrite dts/upstream/src/arm64/rockchip/rk3588s.dtsi (99%)
 create mode 100644 include/configs/rock-5-itx-rk3588.h

-- 
2.39.2

