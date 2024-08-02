Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90348C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 02:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94FE588706;
	Fri,  2 Aug 2024 04:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 574A088709; Fri,  2 Aug 2024 04:50:12 +0200 (CEST)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0DFF88701
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 04:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 4722numu003853; Fri, 2 Aug 2024 11:49:56 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 gajjar04akash@gmail.com, jonas@kwiboo.se, FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH] arm: dts: rockchip: disable "usb_host0_ohci" to make boot
 faster for Radxa ROCK 3A
Date: Fri,  2 Aug 2024 11:49:49 +0900
Message-ID: <20240802024949.122688-1-naoki@radxa.com>
X-Mailer: git-send-email 2.43.0
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

on-board USB 2.0 hub, FE1.1s, has Transaction Translator which can
handle USB 1.x devices via "usb_host0_ehci". so we can omit
"usb_host0_ohci" and make boot faster (a little).

=> usb start
starting USB...
Bus usb@fd000000: Register 2000140 NbrPorts 2
Starting the controller
USB XHCI 1.10
Bus usb@fd800000: USB EHCI 1.00
Bus usb@fd880000: USB EHCI 1.00
Bus usb@fd8c0000: USB OHCI 1.0
scanning bus usb@fd000000 for devices... 1 USB Device(s) found
scanning bus usb@fd800000 for devices... 2 USB Device(s) found
scanning bus usb@fd880000 for devices... 1 USB Device(s) found
scanning bus usb@fd8c0000 for devices... 3 USB Device(s) found
       scanning usb for storage devices... 1 Storage Device(s) found
=> usb tree
USB device tree:
  1  Hub (5 Gb/s, 0mA)
     U-Boot XHCI Host Controller

  1  Hub (480 Mb/s, 0mA)
  |  u-boot EHCI Host Controller
  |
  +-2  Hub (480 Mb/s, 100mA)
        USB 2.0 Hub

  1  Hub (480 Mb/s, 0mA)
     u-boot EHCI Host Controller

  1  Hub (12 Mb/s, 0mA)
  |   U-Boot Root Hub
  |
  +-2  Hub (12 Mb/s, 100mA)
    |  ALCOR Generic USB Hub
    |
    +-3  Mass Storage (12 Mb/s, 300mA)
         JetFlash Mass Storage Device 02K1RNH5MJFV4TX6

=> usb reset
resetting USB...
Host not halted after 16000 microseconds.
Bus usb@fd000000: Register 2000140 NbrPorts 2
Starting the controller
USB XHCI 1.10
Bus usb@fd800000: USB EHCI 1.00
Bus usb@fd880000: USB EHCI 1.00
Bus usb@fd8c0000: USB OHCI 1.0
scanning bus usb@fd000000 for devices... 1 USB Device(s) found
scanning bus usb@fd800000 for devices... 4 USB Device(s) found
scanning bus usb@fd880000 for devices... 1 USB Device(s) found
scanning bus usb@fd8c0000 for devices... 1 USB Device(s) found
       scanning usb for storage devices... 1 Storage Device(s) found
=> usb tree
USB device tree:
  1  Hub (5 Gb/s, 0mA)
     U-Boot XHCI Host Controller

  1  Hub (480 Mb/s, 0mA)
  |  u-boot EHCI Host Controller
  |
  +-2  Hub (480 Mb/s, 100mA)
    |   USB 2.0 Hub
    |
    +-3  Hub (12 Mb/s, 100mA)
      |  ALCOR Generic USB Hub
      |
      +-4  Mass Storage (12 Mb/s, 300mA)
           JetFlash Mass Storage Device 02K1RNH5MJFV4TX6

  1  Hub (480 Mb/s, 0mA)
     u-boot EHCI Host Controller

  1  Hub (12 Mb/s, 0mA)
      U-Boot Root Hub

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
 arch/arm/dts/rk3568-rock-3a-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
index 9d18f5d0b36..9078b9a67a2 100644
--- a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
+++ b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
@@ -40,3 +40,7 @@
 		spi-tx-bus-width = <1>;
 	};
 };
+
+&usb_host0_ohci {
+	status = "disabled";
+};
-- 
2.43.0

