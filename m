Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E376C54E49
	for <u-boot@archiver.kernel.org>; Sun, 10 Mar 2024 19:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C12D7877FB;
	Sun, 10 Mar 2024 20:25:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="JWvBfJ7Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBC6E877FB; Sun, 10 Mar 2024 20:25:57 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C557A86D73
 for <u-boot@lists.denx.de>; Sun, 10 Mar 2024 20:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=14bd=KR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1710098742;
 bh=Aw/ZVmAyZFV52onJBUim3nNsVnldagyvtkSKPsw3qoY=;
 b=JWvBfJ7YmjPrBx4teRaEXq4JDIcSFpKjP+EX/20mFZv2VIe6a2NJ/s6vrncSPBGHT00DvJ+1g
 IuiEFI24XwEJu8PVEadv4pqwNxAHrlLEFe3cWK5iU7aIwymhs7oYDCLWDd+NZAyxebx4ec4Mkfa
 kl9iDMieLmmrwJQNuFQD8GpA+cAbbWW2+lDB4xfQkrWbZTU87MHnf4BUNcB5jdZvEZYZNN9pCCA
 UxF1xRT1OAhD1WfuFvMldoQE5MqiOM70C5icEG9pv017gAG4FHQfFOw3TiWcVkMORxTO6UYFMah
 bejO2HkLhOCD8ic1XWlYfXE2enix+hX55wRj6Y/7Szug==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/4] rockchip: Migrate to use DM_USB_GADGET on RK3328
Date: Sun, 10 Mar 2024 18:50:56 +0000
Message-ID: <20240310185106.665553-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65ee01205e98868d918e8ebe
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

USB gadget is not working fully as expected on RK3328, it uses a
board_usb_init() function to initialize the DWC2 OTG port, as a result
the USB2PHY driver never gets invoked. An issue is that the USB_DWC2
driver is enabled and also gets loaded for the OTG port. A side effect
of that is that the board will freeze if USB gadget is started after USB
host have been stopped, the USB2PHY driver puts the OTG port in suspend
mode on exit.

To improve the situation this series changes to only enable one of
USB_DWC2 (host) or DWC2_OTG (peripheral) depending on most likely usage
of the port. It also migrates to use DM_USB_GADGET instead of
board_usb_init().

First patch fixes and add Product ID for supported Rockchip SoCs.

Second patch prepare board.c for use of DM_USB_GADGET with DWC2_OTG.

Third patch add a g_dnl_bind_fixup() to configure a different Product ID
when UMS is used.

Final patch updates u-boot.dtsi and defconfigs to only use USB_DWC2 for
host or migrate to use DM_USB_GADGET with DWC2_OTG for peripheral. UMS
and ROCKUSB is enabled for all boards with otg port in peripheral mode.

Hopefully current incompatibility between having USB_DWC2, DWC2_OTG and
USB_DWC3_GADGET enabled together is something that could be improved on
in a future series.

Following have been tested on a Rock64, ROC-RK3328-CC, Rock Pi E and
Orange Pi R1 Plus LTS:
- USB host on all host ports: usb start && usb tree && usb stop
- UMS on otg port: ums 0 mmc 1
- RockUSB on otg port: rockusb 0 mmc 1

Changes in v2:
- Drop use of DWC3_GENERIC and revert to use XHCI_DWC3 for USB 3.0 host
  for devices using another port with otg/peripheral dr_mode to work
  around build errors when mixing DWC3_GENERIC and DWC2_OTG.
- Above change means this series can drop a rejected depends that tried
  to fix above build error.
- Collect r-b tags

This series depends on the following series:
- rockchip: rk3328: Update defconfigs, DTs and enable boot from SPI [1]
- rockchip: Read cpuid and generate MAC address from efuse for RK3328
  and RK3399 [2]
- phy: rockchip-inno-usb2: Write to correct GRF [3]

The copy of the series and all its depends can also be found at [4].

[1] https://patchwork.ozlabs.org/cover/1900345/
[2] https://patchwork.ozlabs.org/cover/1897743/
[3] https://patchwork.ozlabs.org/cover/1903987/
[4] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3328-gadget-v2

Jonas Karlman (4):
  rockchip: Update the default USB Product ID value
  rockchip: board: Prepare for use of DM_USB_GADGET with DWC2_OTG
  rockchip: board: Use a common USB Product ID for UMS
  rockchip: Migrate to use DM_USB_GADGET on RK3328

 arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi    |  4 ++
 .../rk3328-orangepi-r1-plus-lts-u-boot.dtsi   |  4 ++
 .../dts/rk3328-orangepi-r1-plus-u-boot.dtsi   |  4 ++
 arch/arm/dts/rk3328-roc-cc-u-boot.dtsi        |  4 ++
 arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi     |  9 ++++
 arch/arm/dts/rk3328-rock64-u-boot.dtsi        |  4 ++
 arch/arm/dts/rk3328-u-boot.dtsi               |  4 --
 arch/arm/dts/rk3328.dtsi                      | 41 ++++++++-----------
 arch/arm/mach-rockchip/board.c                | 19 ++++++++-
 configs/evb-rk3328_defconfig                  |  7 +++-
 configs/nanopi-r2c-plus-rk3328_defconfig      |  7 +++-
 configs/nanopi-r2c-rk3328_defconfig           |  7 +++-
 configs/nanopi-r2s-rk3328_defconfig           |  7 +++-
 configs/orangepi-r1-plus-lts-rk3328_defconfig |  7 +++-
 configs/orangepi-r1-plus-rk3328_defconfig     |  7 +++-
 configs/roc-cc-rk3328_defconfig               |  7 ----
 configs/rock-pi-e-rk3328_defconfig            |  7 ----
 configs/rock64-rk3328_defconfig               |  6 ---
 drivers/usb/gadget/Kconfig                    | 15 +++++--
 19 files changed, 105 insertions(+), 65 deletions(-)

-- 
2.43.2

