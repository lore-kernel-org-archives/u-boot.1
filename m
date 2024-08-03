Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C623C3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 13:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AF0488C96;
	Sat,  3 Aug 2024 15:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DAA488C93; Sat,  3 Aug 2024 15:55:49 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD95988BFF
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 15:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=phil.lan)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1saFEZ-000691-2X; Sat, 03 Aug 2024 15:55:47 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de
Cc: heiko@sntech.de,
	ukleinek@debian.org
Subject: [PATCH 00/15] Support for rk3568 based QNAP TS433 NAS
Date: Sat,  3 Aug 2024 15:55:27 +0200
Message-Id: <20240803135542.3124517-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
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

The whole series is pretty similar so adding support for the other
variants will be pretty easy, once device-specific devicetrees land.


The DONOTMERGE labeled devicetree patches I need to re-do once they land
in the actual devicetree-rebasing repository, as I just merged them for
the 6.12 Linux-kernel some days ago.

But having this publicaly available might give interested people the
chance to try it out already :-)

This currently goes on top of today's u-boot master.


Heiko Stuebner (15):
  DONOTMERGE: arm64: dts: rockchip: add PCIe supply regulator to
    Qnap-TS433
  DONOTMERGE: arm64: dts: rockchip: enable second PCIe controller on the
    Qnap-TS433
  DONOTMERGE: arm64: dts: rockchip: enable uart0 on Qnap-TS433
  DONOTMERGE: arm64: dts: rockchip: enable usb ports on Qnap-TS433
  DONOTMERGE: arm64: dts: rockchip: add stdout path on Qnap-TS433
  DONOTMERGE: arm64: dts: rockchip: enable sata1+2 on Qnap-TS433
  DONOTMERGE: arm64: dts: rockchip: add board-aliases for Qnap-TS433
  DONOTMERGE: arm64: dts: rockchip: add hdd leds to Qnap-TS433
  DONOTMERGE: arm64: dts: rockchip: enable the tsadc on the Qnap-TS433
  DONOTMERGE: arm64: dts: rockchip: add gpio-keys to Qnap-TS433
  DONOTMERGE: arm64: dts: rockchip: define cpu-supply on the Qnap-TS433
  DONOTMERGE: arm64: dts: rockchip: add missing pmic information on
    Qnap-TS433
  DONOTMERGE: arm64: dts: rockchip: enable gpu on Qnap-TS433
  DONOTMERGE: arm64: dts: rockchip: add 2 pmu_io_domain supplies for
    Qnap-TS433
  board: rockchip: add support for Qnap TS433 devices

 arch/arm/dts/rk3568-qnap-ts433-u-boot.dtsi    |   6 +
 arch/arm/mach-rockchip/rk3568/Kconfig         |  14 +
 board/qnap/ts433/Kconfig                      |  12 +
 board/qnap/ts433/MAINTAINERS                  |   8 +
 configs/qnap-ts433-rk3568_defconfig           |  86 +++
 doc/board/qnap/index.rst                      |   9 +
 doc/board/qnap/ts433.rst                      |  91 +++
 doc/board/rockchip/rockchip.rst               |   1 +
 .../src/arm64/rockchip/rk3568-qnap-ts433.dts  | 546 +++++++++++++++++-
 include/configs/qnap_ts433.h                  |  10 +
 10 files changed, 780 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/dts/rk3568-qnap-ts433-u-boot.dtsi
 create mode 100644 board/qnap/ts433/Kconfig
 create mode 100644 board/qnap/ts433/MAINTAINERS
 create mode 100644 configs/qnap-ts433-rk3568_defconfig
 create mode 100644 doc/board/qnap/index.rst
 create mode 100644 doc/board/qnap/ts433.rst
 create mode 100644 include/configs/qnap_ts433.h

-- 
2.39.2

