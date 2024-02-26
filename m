Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0675AC5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 23:08:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C9578775F;
	Tue, 27 Feb 2024 00:08:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="XubqgVxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 190C087EFE; Tue, 27 Feb 2024 00:08:42 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53CEA807EC
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 00:08:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b6e=KE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1708988908;
 bh=29yhmZwYSmyjny3fk4igVbifb+MjJ4D15gfaK3IRefE=;
 b=XubqgVxIveyuQp/bf8UvmpZYpEKKWMClhLR+WcVMEgmKiZP//+fB0LBcZ72Ur+ZYv6bI2b+PR
 xiq0bZoOjEf14mOjyPqeSOEEhDTf4RRO0uCl+QYMg8IH/wbMCYthDFZaFlkBblORFlVXlIDUu7Q
 4oT1MdRA8vxtNX+1T+kvVUOvidG+ehBpSUfmhcXUBh/zSdmYFaTFlruF8D2cIwBBsbiJzICguVV
 1yrAes/rpJTE+qHv4nMTcfZPfX3qLRWDYUkPtrTpRLtrA6eOpsnhEtfvp/kk+UAage8/kNvkUEQ
 wQHyGp7JHxFVeygo9v876IdAZo/D8UTakUrd/ei2XY2g==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 0/4] rockchip: Migrate to use DM_USB_GADGET on RK3328
Date: Mon, 26 Feb 2024 23:08:12 +0000
Message-ID: <20240226230822.2430391-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65dd19eb81fb330034973ee8
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

This series depends on the following series and patches:
- rockchip: rk3328: Update defconfigs, DTs and enable boot from SPI [1]
- rockchip: Read cpuid and generate MAC address from efuse for RK3328
  and RK3399 [2]
- usb: dwc3-generic: Fix build errors when USB_DWC3_GADGET is disabled [3]
- phy: rockchip-inno-usb2: Write to correct GRF [4]

The copy of the series and all its depends can also be found at [5].

[1] https://patchwork.ozlabs.org/cover/1900345/
[2] https://patchwork.ozlabs.org/cover/1897743/
[3] https://patchwork.ozlabs.org/patch/1903946/
[4] https://patchwork.ozlabs.org/cover/1903987/
[5] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3328-gadget-v1

Jonas Karlman (4):
  rockchip: Update the default USB Product ID Kconfig option
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
 configs/evb-rk3328_defconfig                  |  5 ++-
 configs/nanopi-r2c-plus-rk3328_defconfig      |  5 ++-
 configs/nanopi-r2c-rk3328_defconfig           |  5 ++-
 configs/nanopi-r2s-rk3328_defconfig           |  5 ++-
 configs/orangepi-r1-plus-lts-rk3328_defconfig |  5 ++-
 configs/orangepi-r1-plus-rk3328_defconfig     |  5 ++-
 configs/roc-cc-rk3328_defconfig               |  7 ----
 configs/rock-pi-e-rk3328_defconfig            |  7 ----
 configs/rock64-rk3328_defconfig               |  6 ---
 drivers/usb/gadget/Kconfig                    | 15 +++++--
 19 files changed, 99 insertions(+), 59 deletions(-)

-- 
2.43.0

