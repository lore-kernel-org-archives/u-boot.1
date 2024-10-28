Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63428D3E2A3
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 19:00:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4E848913A;
	Mon, 28 Oct 2024 20:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="uckh8JAX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E91C4890D0; Mon, 28 Oct 2024 20:00:44 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 097E88911A
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 20:00:43 +0100 (CET)
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
 bh=PYD0HU4sKBzgAUSXf5UCqTsKGCY6WBzYqrzaTFUfaZQ=; b=uckh8JAXH/R3Rdb3ICWh9/YPg3
 N2qguwyWk5zYvkIBXSsDi4kUT16zWbIQ8T39VeZ4giLVt9bjzuvUcoyL7NHkSvXTELp/TXCq5nipw
 j7Zkyxg8LsDuzG5hR0v71+2R7nPS1+q/wSETZQ/bIvbZMq+w/+48UfYbAG8xIvWpzX5iFuCqciDQJ
 FJ87bfoYon15b/X8Cd9qURR1zVIbhzf+pmrHrCZLGGwM/Fdx7QJWqzcFJqTj2wQoNS0MX0f2Yf30v
 K7Ww80Yhxccl43ZmtMqTL8AOWp4xr7s2O5DJ4ATwFrwvya+XgtattwTTGeel4qCg7g3rg0z2LAnNC
 hEu6hNDA==;
Received: from [185.156.123.69] (helo=phil.sntech)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1t5Uyn-0000Gm-Ix; Mon, 28 Oct 2024 20:00:41 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org
Cc: heiko@sntech.de,
	ukleinek@debian.org
Subject: [PATCH v3 00/18] Support for rk3568 based QNAP TS433 NAS
Date: Mon, 28 Oct 2024 20:00:16 +0100
Message-ID: <20241028190034.143122-1-heiko@sntech.de>
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

changes in v3:
- list qnap/index in doc/boards/index
- add CONFIG_SYS_HAS_NONCACHED_MEMORY to defconfig to fix cache error
changes in v2:
- use actual cherry-picked upstream dts commits, now that they are
  merged

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
 configs/qnap-ts433-rk3568_defconfig           |  87 +++
 doc/board/index.rst                           |   1 +
 doc/board/qnap/index.rst                      |   9 +
 doc/board/qnap/ts433.rst                      |  91 +++
 doc/board/rockchip/rockchip.rst               |   1 +
 .../src/arm64/rockchip/rk3568-qnap-ts433.dts  | 571 +++++++++++++++++-
 include/configs/qnap_ts433.h                  |  10 +
 11 files changed, 804 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/dts/rk3568-qnap-ts433-u-boot.dtsi
 create mode 100644 board/qnap/ts433/Kconfig
 create mode 100644 board/qnap/ts433/MAINTAINERS
 create mode 100644 configs/qnap-ts433-rk3568_defconfig
 create mode 100644 doc/board/qnap/index.rst
 create mode 100644 doc/board/qnap/ts433.rst
 create mode 100644 include/configs/qnap_ts433.h

-- 
2.45.2

