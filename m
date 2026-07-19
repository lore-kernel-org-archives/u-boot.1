Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EBFC4450A
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 01:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95B3880517;
	Sun, 19 Jul 2026 03:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3395C841F2; Sun, 19 Jul 2026 03:58:58 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F3F280398
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 03:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wlGnm-000000001oH-2Lv7; Sun, 19 Jul 2026 01:58:46 +0000
Date: Sun, 19 Jul 2026 02:58:43 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tianling Shen <cnsztl@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Majewski <lukma@denx.de>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dang Huynh <dang.huynh@mainlining.org>,
 Daniel Golle <daniel@makrotopia.org>, Peng Fan <peng.fan@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 u-boot@lists.denx.de
Subject: [PATCH 0/9] video: rockchip: VOP2 and HDMI output for RK3568
Message-ID: <cover.1784424101.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

U-Boot has no video output support for the RK3568/RK3566 family: the
VOP2 display controller found in these SoCs (and newer Rockchip parts)
is unsupported, so boards cannot show a boot menu, the UEFI console or
any other firmware user interface on a locally attached display, while
the vendor firmware and the Linux kernel have long been able to drive
it.

This series brings up HDMI output on RK3568 in U-Boot proper so that a
plain monitor plus USB keyboard is enough to interact with the
firmware, using the NanoPi R5C as the reference board.

The VOP2 driver and the RK3568 HDMI glue were written by Dang Huynh,
modelled on the existing VOP support and the Linux driver. On top of
that, bring-up on real hardware showed that U-Boot must not rely on the
state left behind by earlier boot stages: the probe path is fixed to
map the right register base, and the HDMI controller clocks, the PHY
reference clock and the PHY analog supplies are now enabled explicitly
by the driver instead of assuming the BootROM, TPL or a previous
firmware left them on. The final patch enables video output on the
NanoPi R5C.

Dang Huynh (4):
  video: rockchip: Add VOP2 support
  arm: dts: rockchip: rk356x: Prerelocate VOP in U-Boot proper
  video: rockchip: Add HDMI support for RK3568
  clk: rockchip: rk3568: Use assigned VPLL clock when possible

Daniel Golle (5):
  video: rockchip: vop2: fix NULL register base in rk3568 probe
  video: rockchip: rk3568: ungate the HDMI controller clocks
  video: rockchip: rk3568: bring up the HDMI PHY reference clock
  video: rockchip: rk3568: power the HDMI PHY analog supplies
  configs: nanopi-r5c: enable HDMI video output

 arch/arm/dts/rk356x-u-boot.dtsi               |   4 +
 .../include/asm/arch-rockchip/vop_rk3568.h    | 280 ++++++++++
 configs/nanopi-r5c-rk3568_defconfig           |   4 +
 drivers/clk/rockchip/clk_rk3568.c             |  18 +-
 drivers/video/rockchip/Makefile               |   4 +-
 drivers/video/rockchip/rk3568_hdmi.c          | 125 +++++
 drivers/video/rockchip/rk3568_vop.c           | 270 +++++++++
 drivers/video/rockchip/rk_vop2.c              | 520 ++++++++++++++++++
 drivers/video/rockchip/rk_vop2.h              |  76 +++
 9 files changed, 1299 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-rockchip/vop_rk3568.h
 create mode 100644 drivers/video/rockchip/rk3568_hdmi.c
 create mode 100644 drivers/video/rockchip/rk3568_vop.c
 create mode 100644 drivers/video/rockchip/rk_vop2.c
 create mode 100644 drivers/video/rockchip/rk_vop2.h


base-commit: ece349ade2973e220f524ce59e59711cc919263f
-- 
2.55.0
