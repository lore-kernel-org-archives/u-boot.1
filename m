Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C726C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:14:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BA058853E;
	Mon, 10 Jun 2024 15:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2D1288537; Mon, 10 Jun 2024 15:14:00 +0200 (CEST)
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8fae])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87D4286EB5
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VyXLs4tMwzJy5;
 Mon, 10 Jun 2024 15:13:57 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VyXLq6m6GzDg6; Mon, 10 Jun 2024 15:13:55 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH next v3 0/8] rockchip: add support for Theobroma Systems
 SOM-RK3588-Q7 Tiger module
Date: Mon, 10 Jun 2024 15:13:30 +0200
Message-Id: <20240610-tiger-v3-0-2b4731f95757@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPr7ZmYC/3XMSw6CMBAG4KuYWVszfSDVlfcwLgoM0AXUtE0DI
 dzdpmrixuX/yLdBIG8pwPWwgadkg3VzDvJ4gHY080DMdjmDQKFQcc2iHcizjleSS9TtxSDk79N
 Tb5fi3GGmJcIjt6MN0fm14ImX7e0I8XESZ8i05ucGa+xqpW9xJNd4NxkW1hBpCqfWTUVL4leQX
 0EwzpSRvUGDvKnon7Dv+wuDyzG/7gAAAA==
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko@sntech.de>, Jing Luo <jing@jing.rocks>, 
 Quentin Schulz <foss+uboot@0leil.net>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14-dev-a6ee3
X-Infomaniak-Routing: alpha
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

This has a dependency on https://lore.kernel.org/u-boot/20240528170406.353616-1-liujianfeng1994@gmail.com/

Changes in v3:
- rebased on top of next,
- changed patch series dependency from DRAM ATAGS (merged) to RK3588
  upstream DTS cherry-picks from 6.10-rc1 (USB nodes),
- cherry-picked kernel DTS commits for Tiger between v6.9 and v6.10-rc2,
  note that the "arm64: dts: rockchip: correct gpio_pwrctrl1 typos on rk3588(s) boards"
  commit triggered some git auto-merging while cherry-picking,
- support for Q7 USB P1 (micro-USB OTG) has been dropped, it requires
  extcon USB GPIO driver that isn't supported in U-Boot (yet?),
- Link to v2: https://lore.kernel.org/r/20240423-tiger-v2-1-4a3fa0a01b5e@theobroma-systems.com

Changes in v2:
- removed uart controller muxing patch as not necessary until we get
  open-source DRAM init,
- disabled DEBUG_UART_BOARD_INIT as it's only used for muxing the UART
  controller and it's not necessary since DDR bin does this for us
  already,
- added missing uart2 mux bootph in U-Boot dtsi (though not required
  yet),
- switched to USB_DWC3_GENERIC from USB_XHCI_DWC3 as requested by Jonas,
- Link to v1: https://lore.kernel.org/r/20240422-tiger-v1-0-8816b070d748@theobroma-systems.com

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Heiko Stuebner (6):
      arm64: dts: rockchip: enable gpu on rk3588-tiger
      arm64: dts: rockchip: move uart2 pinmux to dtsi on rk3588-tiger
      arm64: dts: rockchip: fix pcie-refclk frequency on rk3588 tiger
      arm64: dts: rockchip: fix comment for upper usb3 port
      arm64: dts: rockchip: add usb-id extcon on rk3588 tiger
      arm64: dts: rockchip: add dual-role usb3 hosts to rk3588 Tiger-Haikou

Jing Luo (1):
      arm64: dts: rockchip: correct gpio_pwrctrl1 typos on rk3588(s) boards

Quentin Schulz (1):
      rockchip: add support for Theobroma Systems SOM-RK3588-Q7 Tiger module

 arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi       |  37 +++++++
 arch/arm/mach-rockchip/rk3588/Kconfig              |  31 ++++++
 board/theobroma-systems/tiger_rk3588/Kconfig       |  16 +++
 board/theobroma-systems/tiger_rk3588/MAINTAINERS   |  13 +++
 board/theobroma-systems/tiger_rk3588/Makefile      |  10 ++
 .../theobroma-systems/tiger_rk3588/tiger_rk3588.c  |  53 ++++++++++
 configs/tiger-rk3588_defconfig                     | 113 +++++++++++++++++++++
 doc/board/rockchip/rockchip.rst                    |   1 +
 doc/board/theobroma-systems/index.rst              |   1 +
 doc/board/theobroma-systems/tiger_rk3588.rst       | 102 +++++++++++++++++++
 .../src/arm64/rockchip/rk3588-coolpi-cm5.dtsi      |   2 +-
 .../rockchip/rk3588-edgeble-neu6a-common.dtsi      |   2 +-
 dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts  |   2 +-
 .../src/arm64/rockchip/rk3588-tiger-haikou.dts     |  65 +++++++++++-
 dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi  |  29 +++++-
 .../src/arm64/rockchip/rk3588-turing-rk1.dtsi      |   2 +-
 .../src/arm64/rockchip/rk3588s-coolpi-4b.dts       |   2 +-
 .../src/arm64/rockchip/rk3588s-indiedroid-nova.dts |   2 +-
 .../src/arm64/rockchip/rk3588s-orangepi-5.dts      |   2 +-
 .../src/arm64/rockchip/rk3588s-rock-5a.dts         |   2 +-
 include/configs/tiger_rk3588.h                     |  15 +++
 21 files changed, 488 insertions(+), 14 deletions(-)
---
base-commit: b9bc39042dbc5d9e3bc84c0d63a54a4f6f5819d4
change-id: 20240418-tiger-d1531308c9a0

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

