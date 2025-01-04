Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1105E77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 01:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1559E8036D;
	Sat,  4 Jan 2025 02:58:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B692B803DF; Sat,  4 Jan 2025 02:58:08 +0100 (CET)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C785801A0
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 02:58:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 5041vMj7008722; Sat, 4 Jan 2025 10:57:22 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, sumit.garg@linaro.org, jonas@kwiboo.se,
 eugen.hristev@linaro.org, quentin.schulz@cherry.de,
 michal.simek@amd.com, seb-dev@mail.de, liujianfeng1994@gmail.com,
 heiko@sntech.de, zhangzj@rock-chips.com, macromorgan@hotmail.com,
 dsimic@manjaro.org, pbrobinson@gmail.com, cfsworks@gmail.com,
 sebastian.reichel@collabora.com, alchark@gmail.com,
 didi.debian@cknow.org, cassel@kernel.org,
 boris.brezillon@collabora.com, cristian.ciocaltea@collabora.com,
 jing@jing.rocks, FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH v5 0/4] rockchip: Add support for Radxa ROCK 5C
Date: Sat,  4 Jan 2025 01:57:00 +0000
Message-ID: <20250104015704.1238-1-naoki@radxa.com>
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

Changes in v5:
- Rebase on top of latest next branch
- Drop PATCH 1/5

Cristian Ciocaltea (1):
  arm64: dts: rockchip: Add HDMI0 node to rk3588

FUKAUMI Naoki (2):
  arm64: dts: rockchip: add Radxa ROCK 5C
  rockchip: Add support for Radxa ROCK 5C

Sam Edwards (1):
  arm64: dts: rockchip: Split up RK3588's PCIe pinctrls

 arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi      |  11 +
 arch/arm/mach-rockchip/rk3588/Kconfig         |  21 +
 board/radxa/rock-5c-rk3588s/Kconfig           |  12 +
 board/radxa/rock-5c-rk3588s/MAINTAINERS       |   7 +
 configs/rock-5c-rk3588s_defconfig             |  84 ++
 doc/board/rockchip/rockchip.rst               |   1 +
 .../arm64/rockchip/rk3588-base-pinctrl.dtsi   | 271 +++++-
 .../src/arm64/rockchip/rk3588-base.dtsi       |  41 +
 .../src/arm64/rockchip/rk3588s-rock-5a.dts    |   6 +-
 .../src/arm64/rockchip/rk3588s-rock-5c.dts    | 920 ++++++++++++++++++
 include/configs/rock-5c-rk3588s.h             |  15 +
 11 files changed, 1340 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
 create mode 100644 board/radxa/rock-5c-rk3588s/Kconfig
 create mode 100644 board/radxa/rock-5c-rk3588s/MAINTAINERS
 create mode 100644 configs/rock-5c-rk3588s_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588s-rock-5c.dts
 create mode 100644 include/configs/rock-5c-rk3588s.h

-- 
2.43.0

