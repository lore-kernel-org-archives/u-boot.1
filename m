Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F91BC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 22:08:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2603383280;
	Tue, 22 Jul 2025 00:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vM5FLi1D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F954831E4; Tue, 22 Jul 2025 00:07:52 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1F7A831E4
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 00:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dd2a=2D=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1753135668;
 bh=uND3VtC/Hf+dFC2Iupy6zoNxfFC2Cwd/dj54Kxdkg24=;
 b=vM5FLi1DKL+/NWuHnche4h92DvoeOqslG8JrphpUUVeT5bK9CTjbL8t8Np5qppO0WV+F3Is05
 FYZOfpKEcgX/4igqgDc9BeZMOk3eRh1vxjfRk5rRlE8c0apxuIQNHA/Sze5J4FY97GQgcvTQZw8
 kZE9ptFHLI5y+zTQyKQbM4dgbDuHWMH7dSg2pJXb/PHS7A1jX77R+pDAxUHFrUP1hF5a7xYijBE
 OUyo2t/c+Cnejo8wpaOxnh5iPxQwH8rIli26QdUiMdEuNWeMwW8svrVda/CpSnSVB7TfjXw9kuE
 fw9EfDxz2wqXKwsrHyU4XFGDad6lALfNhzaW2fvXnyNQ==
X-Forward-Email-ID: 687eba2c285c5226412894b5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 00/10] rockchip: Fix misc USB PHY related issues
Date: Mon, 21 Jul 2025 22:07:09 +0000
Message-ID: <20250721220734.1617117-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
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

This series tries to fix a few USB PHY related issues found while
working on RK3528/RK3576 USB OTG support.

The first issue is related to Generic PHY reference counting that is not
working correctly for the usbdp or naneng-combphy drivers. Both drivers
xlate ops never initialized phy->id so it could initialize with an old
value from stack when the dwc3-generic driver was probed, causing two
struct phy to be initialized and ending up not sharing same phy->id,
resulting in reference counting for init/exit and power on/off not
working properly.

The second issue is related to the two inno-usb2 and typec drivers
improperly used UCLASS_PHY for their glue/wrapper driver. This could
cause a crash in very specific scenarios, e.g. missing to enable the
otg/host-port node and only leaving the usb2phy node enabled.

The last issue is related to supporting using only USB2 PHY for USB OTG
purpose without having the USB3 PHY initialized, in such scenario the U3
port needs to be disable, more precisely the usb3otg clock source must
change to use UTMI clk instead of the default PIPE clk.

Prior to this series it was the usb3-phy related driver that would
disable the U3 port in special circumstances, e.g. for DP only mode or
when limiting to use high-speed as maximum-speed.

With this series the U3 port instead is disabled early, the USBDP PHY
driver in both U-Boot and Linux will already enable the U3 port when
needed so no changes in behavior is really expected for boards.

Finally, this series also moves usb otg related device tree nodes for
the Generic RK3588 board from the board u-boot.dtsi to the main board
dts.

Jonas Karlman (10):
  phy: rockchip: usbdp: Fix Generic PHY reference counting
  phy: rockchip: usbdp: Simplify init ops
  phy: rockchip: naneng-combphy: Fix Generic PHY reference counting
  phy: rockchip: naneng-combphy: Simplify init ops
  phy: rockchip: naneng-combphy: Use syscon_regmap_lookup_by_phandle
  phy: rockchip: inno-usb2: Fix improper use of UCLASS_PHY
  phy: rockchip: typec: Fix improper use of UCLASS_PHY
  rockchip: rk3588: Disable USB3OTG U3 ports early
  rockchip: rk3576: Disable USB3OTG0 U3 port early
  rockchip: rk3588-generic: Move usb nodes to board dts

 arch/arm/dts/rk3588-generic-u-boot.dtsi       |  18 ---
 arch/arm/dts/rk3588-generic.dts               |  16 +++
 arch/arm/mach-rockchip/rk3576/rk3576.c        |   6 +
 arch/arm/mach-rockchip/rk3588/rk3588.c        |   8 ++
 configs/generic-rk3588_defconfig              |   1 -
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c |   2 +-
 .../rockchip/phy-rockchip-naneng-combphy.c    | 119 ++++--------------
 drivers/phy/rockchip/phy-rockchip-typec.c     |   2 +-
 drivers/phy/rockchip/phy-rockchip-usbdp.c     |  75 ++---------
 9 files changed, 71 insertions(+), 176 deletions(-)

-- 
2.50.1

