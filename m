Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1ABDCF2579
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 19:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C12D589046;
	Sun, 13 Oct 2024 21:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="GMV0W/Gg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E262A88F44; Sun, 13 Oct 2024 21:24:39 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4996488FC8
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 21:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+GabfnXkvc9N+Y41eUVbwWEFpo7Sy2a4SX+yjAOLONY=; b=GMV0W/Gg50iSGi2liLvVyd2evL
 rJF4rkgJaB38QbgrD3zg68BlplDmRknEpFUkZjMWhpMtNgNzFEBJzSK7Z2jt1mSLp5wMYeDgTW5Yx
 ZQ+j3ByKHJ4FBUM0MY92AEZFDkXgLSDrQ5WeVgXnhsIbwXInBLhqWIsADyMHX+uT79WRzwSDpIyeB
 PK4JAaqc8woEQprmwF3ooxeqFogpEu1JROxjjvCTH0h0cycpZnxiIjb5nr4Rl8wZRLAVFOgTZ8RSE
 raG5bxKqTlCEzs/Bs23izbwKG4Bw9IE1DqzyQnY69q+K6IbKQmQf/m2tVxJoBdiht/BkSq837ZoEy
 EaeHLwkA==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1t04CY-000129-QW; Sun, 13 Oct 2024 21:24:26 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org
Cc: heiko@sntech.de,
	ukleinek@debian.org
Subject: [PATCH v2 00/18] Support for rk3568 based QNAP TS433 NAS
Date: Sun, 13 Oct 2024 21:24:06 +0200
Message-ID: <20241013192424.84280-1-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Currently QNAP builds a series of RK3568- (and RK3588-) based NAS systems.
This series provides support for the 4-bay variant called TS433.

The whole series of devices is pretty similar so adding support for the
other variants will be pretty easy, once device-specific devicetrees land.

The cherry-picked dts patches landed in the 6.12-rc1 merge window in
the Linux kernel.

This currently goes on top of today's u-boot master.


Heiko Stuebner (17):
  arm64: dts: rockchip: add PCIe supply regulator to Qnap-TS433
  arm64: dts: rockchip: enable second PCIe controller on the Qnap-TS433
  arm64: dts: rockchip: enable uart0 on Qnap-TS433
  arm64: dts: rockchip: enable usb ports on Qnap-TS433
  arm64: dts: rockchip: add stdout path on Qnap-TS433
  arm64: dts: rockchip: enable sata1+2 on Qnap-TS433
  arm64: dts: rockchip: add board-aliases for Qnap-TS433
  arm64: dts: rockchip: add hdd leds to Qnap-TS433
  arm64: dts: rockchip: enable the tsadc on the Qnap-TS433
  arm64: dts: rockchip: add gpio-keys to Qnap-TS433
  arm64: dts: rockchip: define cpu-supply on the Qnap-TS433
  arm64: dts: rockchip: add missing pmic information on Qnap-TS433
  arm64: dts: rockchip: enable gpu on Qnap-TS433
  arm64: dts: rockchip: add 2 pmu_io_domain supplies for Qnap-TS433
  arm64: dts: rockchip: actually enable pmu-io-domains on qnap-ts433
  arm64: dts: rockchip: add product-data eeproms to QNAP TS433
  board: rockchip: add support for Qnap TS433 devices

Uwe Kleine-König (1):
  arm64: dts: rockchip: Simplify network PHY connection on qnap-ts433

 arch/arm/dts/rk3568-qnap-ts433-u-boot.dtsi    |   6 +
 arch/arm/mach-rockchip/rk3568/Kconfig         |  14 +
 board/qnap/ts433/Kconfig                      |  12 +
 board/qnap/ts433/MAINTAINERS                  |   8 +
 configs/qnap-ts433-rk3568_defconfig           |  86 +++
 doc/board/qnap/index.rst                      |   9 +
 doc/board/qnap/ts433.rst                      |  91 +++
 doc/board/rockchip/rockchip.rst               |   1 +
 .../src/arm64/rockchip/rk3568-qnap-ts433.dts  | 571 +++++++++++++++++-
 include/configs/qnap_ts433.h                  |  10 +
 10 files changed, 802 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/dts/rk3568-qnap-ts433-u-boot.dtsi
 create mode 100644 board/qnap/ts433/Kconfig
 create mode 100644 board/qnap/ts433/MAINTAINERS
 create mode 100644 configs/qnap-ts433-rk3568_defconfig
 create mode 100644 doc/board/qnap/index.rst
 create mode 100644 doc/board/qnap/ts433.rst
 create mode 100644 include/configs/qnap_ts433.h

-- 
2.45.2

