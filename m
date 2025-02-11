Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A465C0219E
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 05:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF11C80C77;
	Tue, 11 Feb 2025 06:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 586FA806FE; Tue, 11 Feb 2025 06:34:39 +0100 (CET)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF25E803CC
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 06:34:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 51B5Xk4f024751; Tue, 11 Feb 2025 14:33:46 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, jonas@kwiboo.se, quentin.schulz@cherry.de,
 jagan@amarulasolutions.com, dsimic@manjaro.org, pbrobinson@gmail.com,
 liujianfeng1994@gmail.com, paulk@sys-base.io, ricardo@pardini.net,
 heiko@sntech.de, macromorgan@hotmail.com, michal.simek@amd.com,
 seb-dev@mail.de, christopher.obbard@linaro.org,
 ilias.apalodimas@linaro.org, marex@denx.de, mkorpershoek@baylibre.com,
 xypron.glpk@gmx.de, jerome.forissier@linaro.org,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH 0/7] rockchip: Add boot from USB OTG port
Date: Tue, 11 Feb 2025 05:33:33 +0000
Message-ID: <20250211053340.92919-1-naoki@radxa.com>
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

This patch series adds the ability to boot from the USB OTG port to
the RK3588, RK3568, RK3566, RK3399, RK3328, and RK3308.

Use rkflashtool[1] or rkusbboot[2] to download TPL and SPL from
MASKROM mode, and dfu-util to download U-Boot from DFU mode.

This patch series depends on patches[3] that fix TPL/SPL link errors
and patches[4] that add generic RK3399 and RK3328 defconfigs.

[1] https://github.com/linux-rockchip/rkflashtool
[2] https://github.com/RadxaNaoki/rkusbboot
[3] https://patchwork.ozlabs.org/project/uboot/patch/20250211043335.92538-1-naoki@radxa.com/
[4] https://patchwork.ozlabs.org/project/uboot/cover/20250204072710.468610-1-jonas@kwiboo.se/

FUKAUMI Naoki (7):
  rockchip: Change memory location of FIT and U-Boot proper
  rockchip: Add DFU to SPL
  rockchip: Add DFU to SPL for RK3588
  rockchip: Add DFU to SPL for RK3568
  rockchip: Add DFU to SPL for RK3399
  rockchip: Add DFU to SPL for RK3328
  rockchip: Add DFU to SPL for RK3308

 arch/arm/dts/rk3308-u-boot.dtsi         |  5 +++++
 arch/arm/dts/rk3328-u-boot.dtsi         |  5 +++++
 arch/arm/dts/rk3399-u-boot.dtsi         | 10 ++++++++++
 arch/arm/dts/rk356x-u-boot.dtsi         |  5 +++++
 arch/arm/dts/rk3588s-u-boot.dtsi        |  5 +++++
 arch/arm/mach-rockchip/Kconfig          |  6 +++---
 arch/arm/mach-rockchip/rk3308/Kconfig   |  3 ---
 arch/arm/mach-rockchip/rk3308/rk3308.c  |  1 +
 arch/arm/mach-rockchip/rk3328/rk3328.c  |  1 +
 arch/arm/mach-rockchip/rk3399/rk3399.c  |  1 +
 arch/arm/mach-rockchip/rk3568/Kconfig   |  3 ---
 arch/arm/mach-rockchip/rk3568/rk3568.c  |  1 +
 arch/arm/mach-rockchip/rk3588/Kconfig   |  3 ---
 arch/arm/mach-rockchip/rk3588/rk3588.c  |  1 +
 arch/arm/mach-rockchip/rv1126/Kconfig   |  3 ---
 arch/arm/mach-rockchip/spl-boot-order.c |  4 ++++
 boot/Kconfig                            |  3 +++
 configs/generic-rk3328_defconfig        |  8 ++++++++
 configs/generic-rk3399_defconfig        |  9 +++++++++
 configs/generic-rk3568_defconfig        |  9 +++++++++
 configs/generic-rk3588_defconfig        |  9 +++++++++
 include/configs/rk3308_common.h         |  7 +++++++
 include/configs/rk3328_common.h         |  7 +++++++
 include/configs/rk3399_common.h         | 11 +++++++----
 include/configs/rk3568_common.h         |  7 +++++++
 include/configs/rk3588_common.h         |  7 +++++++
 26 files changed, 115 insertions(+), 19 deletions(-)

-- 
2.43.0

