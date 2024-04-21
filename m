Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1903C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 13:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0171880A1;
	Sun, 21 Apr 2024 15:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713707555;
	bh=mPfTHeX1R+JL0b0tleAHKS7SQgrXDwjRlgb0vePSDhI=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vaUULFeburYlSMwhPFryflWY6UL23t3lYeVnmBRuZygSlaP8ti/ORs3A4943k+0uH
	 oi6xbW4so79jwjz4UcHvN+P+7cuAQTck6GYGzC52xV+NE9zwlJOsMA8lWmE1V0YSHq
	 fh0M/bhDMpS1evxkctHkqC1qoyBXcpO4zt7bOYFEx1Y/+XQ8IdCN6gPbUn/GLu5K+0
	 WWa6qhjTbjsiLB8wqf3f2tdGquR6cuTMe8jd7bmQB9e3DawnnxdZckBzOwB3o+bcrC
	 FpzN6EdIvEFI3hJ8bwX5ib64X7mkZIlH5XZ0Td7QWl1/c8HSzaODx4unAf5/qcviVi
	 FDfpnZlfAauRw==
Received: from crub (pd95f1e3b.dip0.t-ipconnect.de [217.95.30.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B5FE187EA8;
 Sun, 21 Apr 2024 15:52:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713707554;
 bh=mPfTHeX1R+JL0b0tleAHKS7SQgrXDwjRlgb0vePSDhI=;
 h=Date:From:To:Cc:Subject:From;
 b=rXf8MLvwallBSoy3Et8xSAJuWLvlDYl7tV3mo3fZVHXrIw/FP5NPAVASlB3QzlMJJ
 DxLzTaDTyvb5DCCxLjOmw2IwSGjdaxxPG/0EGvkiAUgomVs3NDAv6Br2OcoF7SR6Sm
 BN7/bh7WFj4F9HykykL3rF+1Zsb2DdTYJ/RYua+YocnwNZO6M4JaumhgNK4n8W9NGs
 usjdJpW/6N2XvQkbPrUfiRMgwqu0s6bx55LzbUFC14L508jk7GH124KCFqZPj6Lzam
 uo8dmwAmLEJzK3vwSpxjbqYRbpRVUde3VjjoJItT6r2cpqyo8QzBZ2xbUf8qQu2t9J
 i4al9mV7rvXOg==
Date: Sun, 21 Apr 2024 15:52:13 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] u-boot-video/video-20240421
Message-ID: <20240421155213.7b8625af@crub>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

Hi Tom,

please pull video driver updates for v2024.07-rc1.

CI: https://source.denx.de/u-boot/custodians/u-boot-video/-/pipelines/20466

Thanks,
Anatolij

The following changes since commit af04f37a78c7e61597fb9ed6db2c8f8d7f8b0f92:

  Merge tag 'u-boot-stm32-20240419' of https://source.denx.de/u-boot/custod=
ians/u-boot-stm (2024-04-19 14:25:04 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-video.git tags/video-2024=
0421

for you to fetch changes up to efe1ceec7ef0c2ce2344dbe066fca0d389a0b4f3:

  boot: Move framebuffer reservation to separate helper (2024-04-21 09:07:0=
2 +0200)

----------------------------------------------------------------
 - simple_panel: support timing parsing from EDID
 - dw_hdmi: fix gcc-14 compiler warnings
 - dw_hdmi: support vendor PHY for HDMI
 - rockchip: add Rockchip INNO HDMI PHY driver
 - rockchip: RK3328 HDMI and VOP support
 - evb-rk3328: enable vidconsole support
 - Tegra DC and DSI improvements and Tegra 114 support
 - add LG LG070WX3 MIPI DSI panel driver
 - add Samsung LTL106HL02 MIPI DSI panel driver
 - add Toshiba TC358768 RGB to DSI bridge support
 - add basic support for the Parade DP501 transmitter
 - Tegra 3 panel and bridge driver improvements
 - simplefb: modernise DT parsing
 - fdt_simplefb: Enumerate framebuffer info from video handoff
 - preserve framebuffer if SPL is passing video hand-off
 - fdt_support: allow reserving FB region without simplefb

----------------------------------------------------------------
Anton Bambura (1):
      video: panel: add Samsung LTL106HL02 MIPI DSI panel driver

Caleb Connolly (1):
      video: simplefb: modernise DT parsing

Devarsh Thakkar (3):
      boot: fdt_simplefb: Enumerate framebuffer info from video handoff
      video: Assume video to be active if SPL is passing video hand-off
      boot: Move framebuffer reservation to separate helper

Jagan Teki (17):
      video: rockchip: hdmi: Detect hpd after controller init
      video: dw_hdmi: Add Vendor PHY handling
      video: dw_hdmi: Extend the HPD detection
      video: dw_hdmi: Add read_hpd hook
      video: dw_hdmi: Add setup_hpd hook
      video: rockchip: vop: Simplify rkvop_enable
      video: rockchip: vop: Add win offset support
      video: rockchip: vop: Add dsp offset support
      clk: rockchip: rk3328: Add VOP clk support
      clk: rk3328: Add get hdmiphy clock
      phy: rockchip: Add Rockchip INNO HDMI PHY driver
      video: rockchip: Add rk3328 hdmi support
      video: rockchip: Add rk3328 vop support
      ARM: dts: rk3328: Enable VOP for bootph-all
      rockchip: Enable preconsole for rk3328
      configs: evb-rk3328: Enable vidconsole for rk3328
      configs: Enable HDMI Out for ROC-RK3328-CC

Jonas Schw=C3=B6bel (7):
      video: tegra20: dc: fix printing of framebuffer address
      video: tegra20: dc: enable backlight after DC is configured
      video: tegra20: dc: clean framebuffer memory block
      video: tegra20: dsi: remove pre-configuration
      video: tegra20: dsi: set correct fifo depth
      video: tegra20: dsi: use set_backlight for backlight only
      video: bridge: add basic support for the Parade DP501 transmitter

Khem Raj (1):
      video: dw_hdmi: Fix compiler warnings with gcc-14

Svyatoslav Ryhel (18):
      video: simple_panel: simplify platform data pass
      video: simple_panel: add EDID support
      video: tegra20: dc: diverge DC per-SOC
      video: tegra20: dc: fix image shift on rotated panels
      video: tegra20: consolidate DC header
      video: tegra20: dc: pass DC id to internal devices
      video: tegra20: dc: add PLLD2 parent support
      video: tegra20: dc: add powergate
      video: tegra20: dc: configure behavior if PLLD/D2 is used
      video: tegra20: dc: parameterize V- and H-sync polarities
      video: tegra20: add MIPI calibration driver
      video: tegra20: dsi: add T114 support
      video: tegra20: dsi: add reset support
      video: panel: add LG LG070WX3 MIPI DSI panel driver
      video: bridge: add Toshiba TC358768 RGB to DSI bridge support
      video: endeavoru-panel: shift the init sequence by one step earlier
      video: bridge: ssd2825: shift the init sequence by one step earlier
      video: renesas: shift the init sequence by one step earlier

 arch/arm/dts/rk3328-u-boot.dtsi                    |   4 +
 arch/arm/dts/tegra114-u-boot.dtsi                  |  13 +
 arch/arm/dts/tegra114.dtsi                         |   4 +-
 arch/arm/dts/tegra30-u-boot.dtsi                   |   4 +
 arch/arm/dts/tegra30.dtsi                          |   2 +-
 arch/arm/include/asm/arch-rockchip/cru_rk3328.h    |  34 +
 arch/arm/include/asm/arch-tegra/dc.h               |  13 +-
 arch/arm/include/asm/arch-tegra114/pwm.h           |  13 +
 arch/arm/include/asm/arch-tegra20/display.h        |  28 -
 arch/arm/include/asm/arch-tegra30/display.h        |  28 -
 arch/arm/mach-rockchip/Kconfig                     |   1 +
 boot/fdt_simplefb.c                                |  46 +-
 boot/fdt_support.c                                 |  21 +
 common/Kconfig                                     |   2 +-
 configs/roc-cc-rk3328_defconfig                    |   5 +
 drivers/clk/rockchip/clk_rk3328.c                  | 105 ++-
 drivers/phy/rockchip/Kconfig                       |   7 +
 drivers/phy/rockchip/Makefile                      |   1 +
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c      | 885 ++++++++++++++++++
 drivers/video/Kconfig                              |  17 +
 drivers/video/Makefile                             |   2 +
 drivers/video/bridge/Kconfig                       |  19 +
 drivers/video/bridge/Makefile                      |   2 +
 drivers/video/bridge/dp501.c                       | 579 ++++++++++++
 drivers/video/bridge/ssd2825.c                     |  86 +-
 drivers/video/bridge/tc358768.c                    | 985 +++++++++++++++++=
++++
 drivers/video/dw_hdmi.c                            |  37 +-
 drivers/video/endeavoru-panel.c                    | 128 +--
 drivers/video/lg-ld070wx3.c                        | 186 ++++
 drivers/video/meson/meson_dw_hdmi.c                |   6 +-
 drivers/video/renesas-r61307.c                     |  93 +-
 drivers/video/renesas-r69328.c                     |  81 +-
 drivers/video/rockchip/Makefile                    |   2 +
 drivers/video/rockchip/rk3328_hdmi.c               | 126 +++
 drivers/video/rockchip/rk3328_vop.c                |  83 ++
 drivers/video/rockchip/rk_hdmi.c                   |  11 +-
 drivers/video/rockchip/rk_hdmi.h                   |   3 +
 drivers/video/rockchip/rk_vop.c                    |  44 +-
 drivers/video/rockchip/rk_vop.h                    |   4 +
 drivers/video/samsung-ltl106hl02.c                 | 157 ++++
 drivers/video/simple_panel.c                       | 102 ++-
 drivers/video/simplefb.c                           |  32 +-
 drivers/video/sunxi/sunxi_dw_hdmi.c                |  14 +-
 drivers/video/tegra20/Makefile                     |   2 +-
 drivers/video/tegra20/tegra-dc.c                   | 222 +++--
 drivers/video/tegra20/tegra-dc.h                   |  45 +
 drivers/video/tegra20/tegra-dsi.c                  | 122 ++-
 .../dsi.h =3D> drivers/video/tegra20/tegra-dsi.h     |  24 +-
 drivers/video/tegra20/tegra-mipi.c                 | 188 ++++
 drivers/video/tegra20/tegra-pwm-backlight.c        |   3 +-
 drivers/video/video-uclass.c                       |   4 +
 include/configs/evb_rk3328.h                       |   5 +
 include/configs/rk3328_common.h                    |   1 +
 include/dw_hdmi.h                                  |  11 +-
 include/fdt_support.h                              |   2 +
 55 files changed, 4219 insertions(+), 425 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-tegra114/pwm.h
 delete mode 100644 arch/arm/include/asm/arch-tegra20/display.h
 delete mode 100644 arch/arm/include/asm/arch-tegra30/display.h
 create mode 100644 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
 create mode 100644 drivers/video/bridge/dp501.c
 create mode 100644 drivers/video/bridge/tc358768.c
 create mode 100644 drivers/video/lg-ld070wx3.c
 create mode 100644 drivers/video/rockchip/rk3328_hdmi.c
 create mode 100644 drivers/video/rockchip/rk3328_vop.c
 create mode 100644 drivers/video/samsung-ltl106hl02.c
 create mode 100644 drivers/video/tegra20/tegra-dc.h
 rename arch/arm/include/asm/arch-tegra30/dsi.h =3D> drivers/video/tegra20/=
tegra-dsi.h (90%)
 create mode 100644 drivers/video/tegra20/tegra-mipi.c
