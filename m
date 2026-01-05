Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6CDC79FBD
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 19:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF39583E8E;
	Mon,  5 Jan 2026 20:47:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="pRvjfRbj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6502C83E7F; Mon,  5 Jan 2026 20:47:37 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69AED8398C
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 20:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
 bh=ConQWEsq5+VSPcHtnLQEi48S9AXr7GXmW7ZgzWP0VgI=; b=pRvjfRbjJxLw8rydhfxb2C49G8
 YPjZLdVJPlu0H+cn6iAOWH5jLbx2yY7ya9n02ka7PJo2ibgPFDHy9KTAVQJGsS+uwm7/X/OE4YFnq
 hsgiH6FGUvsDI7NpQ+e3TP8pI/oOfCc9kL69St+itcHZHhBb8ibZMXO2xBWRiBw468Fb3J1gn3mse
 shWryNvQIIcIZqon4q6xJtQgvgfuRT+hEe8ZPLAxtQ2h+jqewWDd/iyFkFiMwT6JnPTssCbxzWFHg
 1jK503H+1+njdDDecE74NU4EOAWt4tD/DvbB/kZ0EyAwiPOcrR/9ElQ2o5G9PaMMFK8IuhpgGNfxo
 h4BCAOGg==;
Received: from i53875bd9.versanet.de ([83.135.91.217] helo=phil..)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1vcqY7-001AcR-DO; Mon, 05 Jan 2026 20:47:32 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de,
	trini@konsulko.com,
	u-boot@lists.denx.de
Subject: [PATCH 00/12] board: qnap-ts433: Cleanups + add support for TS233
Date: Mon,  5 Jan 2026 20:47:11 +0100
Message-ID: <20260105194723.2928608-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
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

This series does a number of cleanups for the existing TS433 NAS,
and also introduces support for a second device.

Right now the code can detect the variant from the I2C eeprom(s) and
set the fdtfile accordingly. Later on (once I figured out what is needed)
this should also select an optional overlay, because later model-variants
do have additional per-disk presence detection and also regulator-handling
that is not present on the earlier versions.

Heiko Stuebner (12):
  rockchip: board: qnap-ts433: Fix TPL binary in build-example
  rockchip: board: qnap-ts433: drop DW_MMC config options
  rockchip: board: qnap-ts433: Fix dir naming to allow build-system to
    find it
  rockchip: board: qnap-ts433: Update documentation to recent tool
    versions
  rockchip: board: qnap-ts433: Add instructions for how to use upstream
    TF-A
  rockchip: board: qnap-ts433: Support multiple models of the TSx33
    family
  arm64: dts: rockchip: move cpu_thermal node to the correct position
  arm64: dts: rockchip: describe mcu eeprom cells on rk3568-ts433
  arm64: dts: rockchip: move common qnap tsx33 parts to dtsi
  arm64: dts: rockchip: add QNAP TS233 devicetree
  rockchip: board: qnap-ts433: Rename the board code to not be TS433
    specific
  rockchip: board: qnap-tsx33: add support for Qnap TS233 devices

 arch/arm/dts/rk3568-qnap-ts233-u-boot.dtsi    |   6 +
 arch/arm/mach-rockchip/rk3568/Kconfig         |  17 +-
 board/qnap/ts433/MAINTAINERS                  |   8 -
 board/qnap/{ts433 => tsx33_rk356x}/Kconfig    |   6 +-
 board/qnap/tsx33_rk356x/MAINTAINERS           |  10 +
 board/qnap/tsx33_rk356x/Makefile              |   7 +
 board/qnap/tsx33_rk356x/board.c               | 261 ++++++++
 configs/qnap-ts233-rk3568_defconfig           |  85 +++
 configs/qnap-ts433-rk3568_defconfig           |   6 +-
 doc/board/qnap/ts233.rst                      |  37 ++
 doc/board/qnap/ts433.rst                      |  34 +-
 .../src/arm64/rockchip/rk3568-qnap-ts233.dts  | 131 ++++
 .../src/arm64/rockchip/rk3568-qnap-ts433.dts  | 604 ++---------------
 .../src/arm64/rockchip/rk3568-qnap-tsx33.dtsi | 608 ++++++++++++++++++
 .../configs/{qnap_ts433.h => tsx33_rk356x.h}  |   0
 15 files changed, 1227 insertions(+), 593 deletions(-)
 create mode 100644 arch/arm/dts/rk3568-qnap-ts233-u-boot.dtsi
 delete mode 100644 board/qnap/ts433/MAINTAINERS
 rename board/qnap/{ts433 => tsx33_rk356x}/Kconfig (52%)
 create mode 100644 board/qnap/tsx33_rk356x/MAINTAINERS
 create mode 100644 board/qnap/tsx33_rk356x/Makefile
 create mode 100644 board/qnap/tsx33_rk356x/board.c
 create mode 100644 configs/qnap-ts233-rk3568_defconfig
 create mode 100644 doc/board/qnap/ts233.rst
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3568-qnap-ts233.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3568-qnap-tsx33.dtsi
 rename include/configs/{qnap_ts433.h => tsx33_rk356x.h} (100%)

-- 
2.47.2

