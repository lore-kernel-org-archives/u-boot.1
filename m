Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD89C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 13:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08B6E8802E;
	Tue,  5 Mar 2024 14:25:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KEOYaBwF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B426687FA5; Tue,  5 Mar 2024 14:25:08 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01DF988041
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 14:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7B69961378;
 Tue,  5 Mar 2024 13:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1BCC433F1;
 Tue,  5 Mar 2024 13:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709645103;
 bh=yzNSK4p7p/Rk6c6jRv5Gwh6bpTKm6xeB/gt7TVfgiSE=;
 h=From:Subject:Date:To:Cc:From;
 b=KEOYaBwFpstqLBtfkwN07fm/qIlhpBm6HNo8shyorBVTG9x99EJC3iWzc4cDp6qww
 /EfPL63H40Ky8JN4ZZKCkFOygR6kCs+Wp6KjMcmK4UWN24LiIqLpSBrmRYVxpI5z+s
 mVyEpfVIeiYYAm2YlBJ36PLepAFCoQMe4atCIrvC0X9ecsh9oPjoBeCAGgUbYYfdjX
 E8CAljF3Or5uILynB35w9t2kaHcmzZzfNitE6Y4bnhpss4mybcawWxJ1BIcBrCjjo2
 cEFDkSkiWK7HcwPRdjjl6voBgkRJKJIhYn9msTKdC9Zftfv5gRoapong1N0t5dCW0z
 KY31NiPovVp8w==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/5] net: mdio-uclass: probe generic Ethernet PHY driver &
 Fix Beagleplay Ethernet
Date: Tue, 05 Mar 2024 15:24:52 +0200
Message-Id: <20240305-for-2024-07-beagleplay-eth-v1-0-e1294a575cc1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACQd52UC/x3MQQ5AMBAAwK/Inm3Slqb4ijgUWzYRpBUh0r8rx
 7nMA4E8U4Ame8DTyYG3NUHmGQyzXSdCHpNBCVWKQmh0m8cPKAz2ZKeF9sXeSMeMrlJWS1mbujC
 Qgt2T4+vP2y7GFzaW+HxsAAAA
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Wadim Egorov <w.egorov@phytec.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Simon Glass <sjg@chromium.org>
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, r-gunasekaran@ti.com, 
 danishanwar@ti.com, u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3379; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=yzNSK4p7p/Rk6c6jRv5Gwh6bpTKm6xeB/gt7TVfgiSE=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl5x0r2tUJ0dyDlKpaYr9+5HOEEDhvuwOXV3aHw
 WwbGyd6P+uJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZecdKwAKCRDSWmvTvnYw
 k+6/D/0QB4V5XGg2WL8Bsg6OsHVVVmX+cdGtpXhg7JfsgCHgmuj4B8wpHcX+cAyYrprz6xwEqt4
 XtW4zZS37W2KlT3q3PTO7jl5XRtOCDFvnE5aJTCWLSYblkSQp1U+y1OP6j1OXxc6Yotna0rVBzd
 6/MbXZx3mR9MK4tZ2tEMir2TwEx76WJEqseP0/RJDryFj30VWYe/FkFiLjM1yXQr9TQVxBG3Lup
 Ur7qWS4SVd7S8eeWMLjgHGpDKTB37jHjOhn8lOf5JqL+rnU6L3VczAMnZd2Je4/pQ/DZo7kb1IA
 X0jD63IMQzxNLBcEof7KF8Z33mwZWEe/FmSrnrS3NE6VnmRQIuZ+6w9LvsnxruLogpWLVlY5a0J
 t5G2DzZ6ex08ZViu5FhzTVjVetKMw0b6XLr1pxgANQMhCKb1T8V6i1x6qfZAIwGHcW1GM8MDwbz
 pHFjHsoxs61hg1Jg+l2XebPaCFoSQwDa2OW+nlhZu4h4VJuZxvW3CqcA1PRTuu0DGKEP9K48AeD
 zoSOmQl+rwUWp5Z6VFKYl8kKJbRb5nOdUnQBbNO2LW4Qfy270E7rIHpmsbtpPnl9bsSBXkB17Cw
 qdMVBGvFjoqRSr6Ytmy73E82LBDjfsYPnIt1l8gcZmE/9mYvTRnrugOQ9WOdaqYVGpOk9c1FshO
 +PwZnMlkHq1zARg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093
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

Currently, the GPIO Reset Device Tree properties of the
PHY node are ignored when the PHY is probed via mdio-uclass driver [1].

To resolve this, for each child of the MDIO bus node, bind and probe
the generic Ethernet PHY driver if CONFIG_DM_ETH_PHY is enabled.

This should now show the generic_phy_driver in "dm tree"
and also apply the GPIO reset before the MDIO bus driver scans the bus
for the PHYs.

 ethernet      0  [ + ]   am65_cpsw_nuss_port       |   |-- ethernet@8000000port@1
 bootdev       3  [   ]   eth_bootdev               |   |   `-- port@1.bootdev
 mdio          0  [ + ]   cpsw_mdio                 |   `-- mdio@f00
 eth_phy_ge    0  [ + ]   eth_phy_generic_drv       |       |-- ethernet-phy@0
 eth_phy_ge    1  [ + ]   eth_phy_generic_drv       |       `-- ethernet-phy@1

To test this on Beagleplay, the following series is required

[1] Switch am65-cpsw to DM MDIO
 https://lore.kernel.org/all/20240228-for-2024-07-am65-cpsw-mdio-v2-0-f74f972eafeb@kernel.org/

The last 3 patches are marked [not-for-merge]. They are to show how the
whole solution can work to fix Ethernet on Beagleplay, which has been broken
so far. Those DT patches will be sent once the device tree changes are merged
into Linux tree.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Roger Quadros (5):
      net: mdio-uclass: Bind and probe generic Ethernet PHY driver
      configs/am62x_beagleplay_a53_defconfig: enable DM_ETH_PHY
      [not-for-merge] arm: dts: k3-am62*: sync with linux-next-20240229
      [not-for-merge] k3-am625-beagleplay-u-boot: get CPSW Ethernet to work
      [not-for-merge] arm: dts: k3-am625-beagleplay: Fix Ethernet PHY reset GPIO

 arch/arm/dts/k3-am62-main.dtsi               | 126 ++++++++++++++---
 arch/arm/dts/k3-am62-mcu.dtsi                |   4 +-
 arch/arm/dts/k3-am62-phycore-som.dtsi        |   5 +-
 arch/arm/dts/k3-am62-thermal.dtsi            |   5 +-
 arch/arm/dts/k3-am62-verdin-dev.dtsi         |   4 +-
 arch/arm/dts/k3-am62-verdin-wifi.dtsi        |   1 -
 arch/arm/dts/k3-am62-verdin.dtsi             |  76 +++++++---
 arch/arm/dts/k3-am62-wakeup.dtsi             |  38 +++--
 arch/arm/dts/k3-am62.dtsi                    |   4 +-
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi |  63 +++++++++
 arch/arm/dts/k3-am625-beagleplay.dts         |  66 ++++-----
 arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts  | 104 +++++++++++++-
 arch/arm/dts/k3-am625-sk.dts                 |   4 +-
 arch/arm/dts/k3-am625.dtsi                   |   4 +-
 arch/arm/dts/k3-am62a-main.dtsi              | 201 +++++++++++++++++++++++++--
 arch/arm/dts/k3-am62a-mcu.dtsi               |   4 +-
 arch/arm/dts/k3-am62a-thermal.dtsi           |   5 +-
 arch/arm/dts/k3-am62a-wakeup.dtsi            |   4 +-
 arch/arm/dts/k3-am62a.dtsi                   |   4 +-
 arch/arm/dts/k3-am62a7-sk.dts                | 162 ++++++++++++++++++++-
 arch/arm/dts/k3-am62a7.dtsi                  |   4 +-
 arch/arm/dts/k3-am62x-sk-common.dtsi         |  24 +++-
 configs/am62x_beagleplay_a53_defconfig       |   2 +-
 net/mdio-uclass.c                            |  41 ++++++
 24 files changed, 825 insertions(+), 130 deletions(-)
---
base-commit: 84f5bb0be0ec9fbf98f8f3317b578dfc114cf44e
change-id: 20240305-for-2024-07-beagleplay-eth-f82a51197937

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>

