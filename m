Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6108FC369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 20:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42CAC82824;
	Mon, 14 Apr 2025 22:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="s6yx63JQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65BE782102; Mon, 14 Apr 2025 22:01:56 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C441682153
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 22:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=0K0UKlN8Dz5f0zmaC0mS4ptFXBHAFbWUsTOl0W2T4ik=; b=s6yx63JQlK3SmSl5FiZzAFV8mv
 AT+A/MuR09f0a1UiwK3+0iXH1pQVXEh+iriFi/vU6rPXRW3B4OrVCmCrJacLn63305sMj8ZPGmNaJ
 io/ImF6KkxThP8A0g1LPSx/8HmxUyQEH4Sph4GegeSSdWgxn6C11LViqGo2gQRGNIHq1/Qqzyau7k
 Ws9nFgKkzHQ/x7QRn6vGYqAtbg7Hpc6yfau6VEIPwvaaTLhUFZ6O2/l+kOplE4u0qAlnNcvQqnHhB
 YDSk+ta6QIF/SgciV30s2BvOjAwYwuCIFhi4Kuctms11bM+5TsVPuY59i+tqZwOSLYACk1qza/A+7
 PueYnv1g==;
Received: from i53875b95.versanet.de ([83.135.91.149]
 helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1u4Pzr-0001rf-7j; Mon, 14 Apr 2025 22:01:35 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
Subject: [PATCH v2 00/16] Support for the RK3576
Date: Mon, 14 Apr 2025 22:00:55 +0200
Message-ID: <20250414200111.1357867-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
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

This adds support for the RK3576 SoC from Rockchip.

Currently supported (and tested) features are accessing and reading from
sdhci and sdmmc devices as well as pxe-booting via the network interface.

As can be seen by the DONOTMERGE labels, this needs to wait a bit still.

The core RK3576 devicetrees will be part of 6.13-rc1, but the Firefly
board I only submitted last week, so this would only appear in 6.14-rc1 .

If someone from Collabora could provide a board patch for the ArmSom
board they are working with, this would speed things up a bit ;-) .

Checkpatch seems mostly happy too.

changes in v2:
- rebase on top of rockchip-for-next (including the rk3528 addition)
- drop patches now coming from mainline Linux
- cherry pick the now mainline comits for roc-rk3576-pc board and otp
- nitpicks in CFG_SYS_SDRAM_BASE handling (Quentin, Jonas)
- fold in Jonas' fixes for (roc-rk3576-pc board, dwc_eth, sdhci, pinctrl,
  clk, ram, rk3576-core), they all look nice and also match the review
  comments submitted.  
- add received reviewed-bys for sdhci and mmc


It has been a while since v1, so I do hope I have caught all the
review comments.


Detlev Casanova (1):
  arm: rockchip: add RK3576-specific syscon ids

Elaine Zhang (2):
  clk: rockchip: Add rk3576 clk support
  reset: rockchip: implement rk3576 lookup table

Heiko Stuebner (10):
  rockchip: sdram: honor CFG_SYS_SDRAM_BASE when defining ram regions
  ram: rockchip: Add rk3576 ddr driver support
  rockchip: otp: Add support for RK3576
  mmc: rockchip_sdhci: Add support for RK3576
  mmc: rockchip_dw_mmc: Add support for rk3576
  net: dwc_eth_qos_rockchip: Add support for RK3576
  arm64: dts: rockchip: add rk3576 otp node
  dt-bindings: arm: rockchip: Add Firefly ROC-RK3576-PC binding
  arm64: dts: rockchip: Add devicetree for the ROC-RK3576-PC
  rockchip: rk3576: Add support for ROC-RK3576-PC board

Steven Liu (1):
  pinctrl: rockchip: support rk3576 pinctrl

Xuhui Lin (2):
  rockchip: mkimage: Add rk3576 support
  arm: rockchip: Add RK3576 arch core support

 arch/arm/dts/rk3576-roc-pc-u-boot.dtsi        |   11 +
 arch/arm/dts/rk3576-u-boot.dtsi               |  131 +
 arch/arm/include/asm/arch-rk3576/boot0.h      |   11 +
 arch/arm/include/asm/arch-rk3576/gpio.h       |   11 +
 arch/arm/include/asm/arch-rockchip/clock.h    |   12 +
 .../include/asm/arch-rockchip/cru_rk3576.h    |  491 ++++
 arch/arm/mach-rockchip/Kconfig                |   51 +
 arch/arm/mach-rockchip/Makefile               |    1 +
 arch/arm/mach-rockchip/rk3576/Kconfig         |   23 +
 arch/arm/mach-rockchip/rk3576/Makefile        |    9 +
 arch/arm/mach-rockchip/rk3576/clk_rk3576.c    |   18 +
 arch/arm/mach-rockchip/rk3576/rk3576.c        |  155 +
 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c |   22 +
 arch/arm/mach-rockchip/sdram.c                |   13 +-
 board/firefly/roc-pc-rk3576/Kconfig           |   12 +
 board/firefly/roc-pc-rk3576/MAINTAINERS       |    7 +
 configs/roc-pc-rk3576_defconfig               |   45 +
 doc/board/rockchip/rockchip.rst               |   12 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk_rk3576.c             | 2513 +++++++++++++++++
 drivers/misc/rockchip-otp.c                   |   11 +
 drivers/mmc/rockchip_dw_mmc.c                 |    1 +
 drivers/mmc/rockchip_sdhci.c                  |   15 +
 drivers/net/dwc_eth_qos.c                     |    4 +
 drivers/net/dwc_eth_qos_rockchip.c            |  154 +-
 drivers/pinctrl/rockchip/Makefile             |    1 +
 drivers/pinctrl/rockchip/pinctrl-rk3576.c     |  279 ++
 drivers/pinctrl/rockchip/pinctrl-rockchip.h   |    3 +
 drivers/ram/rockchip/Makefile                 |    1 +
 drivers/ram/rockchip/sdram_rk3576.c           |   35 +
 drivers/reset/Makefile                        |    2 +-
 drivers/reset/rst-rk3576.c                    |  647 +++++
 dts/upstream/Bindings/arm/rockchip.yaml       |    5 +
 .../src/arm64/rockchip/rk3576-roc-pc.dts      |  736 +++++
 dts/upstream/src/arm64/rockchip/rk3576.dtsi   |   39 +
 include/configs/rk3576_common.h               |   45 +
 include/configs/roc-pc-rk3576.h               |   15 +
 tools/rkcommon.c                              |    1 +
 38 files changed, 5535 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/dts/rk3576-roc-pc-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3576-u-boot.dtsi
 create mode 100644 arch/arm/include/asm/arch-rk3576/boot0.h
 create mode 100644 arch/arm/include/asm/arch-rk3576/gpio.h
 create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rk3576.h
 create mode 100644 arch/arm/mach-rockchip/rk3576/Kconfig
 create mode 100644 arch/arm/mach-rockchip/rk3576/Makefile
 create mode 100644 arch/arm/mach-rockchip/rk3576/clk_rk3576.c
 create mode 100644 arch/arm/mach-rockchip/rk3576/rk3576.c
 create mode 100644 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
 create mode 100644 board/firefly/roc-pc-rk3576/Kconfig
 create mode 100644 board/firefly/roc-pc-rk3576/MAINTAINERS
 create mode 100644 configs/roc-pc-rk3576_defconfig
 create mode 100644 drivers/clk/rockchip/clk_rk3576.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3576.c
 create mode 100644 drivers/ram/rockchip/sdram_rk3576.c
 create mode 100644 drivers/reset/rst-rk3576.c
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3576-roc-pc.dts
 create mode 100644 include/configs/rk3576_common.h
 create mode 100644 include/configs/roc-pc-rk3576.h

-- 
2.47.2

