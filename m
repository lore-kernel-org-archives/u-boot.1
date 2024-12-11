Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CEDE7717F
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 03:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A9B080212;
	Wed, 11 Dec 2024 04:39:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 482C680223; Wed, 11 Dec 2024 04:39:53 +0100 (CET)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC63B801FE
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 04:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 4BB3deG0005663; Wed, 11 Dec 2024 12:39:40 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 sumit.garg@linaro.org, jonas@kwiboo.se, FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH v3 0/5] rockchip: Add support for Radxa ROCK 5C
Date: Wed, 11 Dec 2024 03:39:29 +0000
Message-ID: <20241211033934.23044-1-naoki@radxa.com>
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

Radxa ROCK 5C is a Rockchip RK3588S2 based single board computer.

Cristian Ciocaltea (1):
  arm64: dts: rockchip: Add HDMI0 node to rk3588

FUKAUMI Naoki (3):
  arm64: dts: rockchip: enable PCIe on M.2 E key for Radxa ROCK 5A
  arm64: dts: rockchip: add Radxa ROCK 5C
  rockchip: Add support for Radxa ROCK 5C

Sam Edwards (1):
  arm64: dts: rockchip: Split up RK3588's PCIe pinctrls

 arch/arm/dts/rk3588s-rock-5-u-boot.dtsi       |  16 +
 arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi      |   6 +
 arch/arm/mach-rockchip/rk3588/Kconfig         |   7 +
 board/radxa/rock-5-rk3588s/Kconfig            |  12 +
 board/radxa/rock-5-rk3588s/MAINTAINERS        |   8 +
 board/radxa/rock-5-rk3588s/Makefile           |   3 +
 board/radxa/rock-5-rk3588s/rock-5-rk3588s.c   |  77 ++
 configs/rock-5-rk3588s_defconfig              |  94 ++
 doc/board/rockchip/rockchip.rst               |   1 +
 .../arm64/rockchip/rk3588-base-pinctrl.dtsi   | 271 +++++-
 .../src/arm64/rockchip/rk3588-base.dtsi       |  41 +
 .../src/arm64/rockchip/rk3588s-rock-5a.dts    |  34 +
 .../src/arm64/rockchip/rk3588s-rock-5c.dts    | 920 ++++++++++++++++++
 include/configs/rock-5-rk3588s.h              |  15 +
 14 files changed, 1457 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
 create mode 100644 board/radxa/rock-5-rk3588s/Kconfig
 create mode 100644 board/radxa/rock-5-rk3588s/MAINTAINERS
 create mode 100644 board/radxa/rock-5-rk3588s/Makefile
 create mode 100644 board/radxa/rock-5-rk3588s/rock-5-rk3588s.c
 create mode 100644 configs/rock-5-rk3588s_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588s-rock-5c.dts
 create mode 100644 include/configs/rock-5-rk3588s.h

-- 
2.43.0

