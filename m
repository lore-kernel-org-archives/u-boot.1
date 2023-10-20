Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BC7C001E0
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 00:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A2C4871E8;
	Fri, 20 Oct 2023 02:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F237871CE; Fri, 20 Oct 2023 02:27:28 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C99EC871E4
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 02:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1F6E2F4;
 Thu, 19 Oct 2023 17:27:59 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 921AA3F64C;
 Thu, 19 Oct 2023 17:27:17 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ludwig Kormann <ludwig.kormann@ict42.de>
Subject: [PATCH 0/3] sunxi: devicetree updates from Linux v6.6
Date: Fri, 20 Oct 2023 01:26:05 +0100
Message-Id: <20231020002608.18606-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
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

This updates the devicetree files to match the Linux kernel repository
as of v6.6-rc6.
Mostly cosmetic changes, but we gain some new board files and the T113s
board .dtsi files, which are needed for the pending U-Boot patches.

Split per architecture, with the T113s being separate due to its RISC-V
relationship.

Andre Przywara (3):
  sunxi: dts: arm64: update devicetree files from Linux-v6.6-rc6
  sunxi: dts: arm: update devicetree files from Linux-v6.6-rc6
  sunxi: dts: arm: add T113s/D1 DT files from Linux-v6.6-rc6

 arch/arm/dts/axp209.dtsi                      |   7 +
 arch/arm/dts/sun50i-a64.dtsi                  |   3 +-
 arch/arm/dts/sun50i-h6-pine-h64-model-b.dts   |   2 +-
 arch/arm/dts/sun50i-h616-orangepi-zero.dtsi   | 134 +++
 arch/arm/dts/sun50i-h616-orangepi-zero2.dts   | 121 +--
 arch/arm/dts/sun50i-h616-x96-mate.dts         |   2 +-
 arch/arm/dts/sun50i-h618-orangepi-zero3.dts   |  94 ++
 arch/arm/dts/sun5i-r8-chip.dts                |   6 +
 arch/arm/dts/sun5i.dtsi                       |  11 +-
 arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts | 137 +++
 arch/arm/dts/sun7i-a20-icnova-a20.dtsi        |  62 ++
 arch/arm/dts/sun8i-a23-a33.dtsi               |   2 +-
 arch/arm/dts/sun8i-a83t.dtsi                  |   2 +-
 .../arm/dts/sun8i-t113s-mangopi-mq-r-t113.dts |  35 +
 arch/arm/dts/sun8i-t113s.dtsi                 |  59 ++
 arch/arm/dts/sun8i-v3s.dtsi                   |   2 +-
 arch/arm/dts/sunxi-d1s-t113-mangopi-mq-r.dtsi | 126 +++
 arch/riscv/dts/sunxi-d1-t113.dtsi             |  15 +
 arch/riscv/dts/sunxi-d1s-t113.dtsi            | 927 ++++++++++++++++++
 include/dt-bindings/clock/sun20i-d1-ccu.h     | 158 +++
 include/dt-bindings/clock/sun20i-d1-r-ccu.h   |  19 +
 include/dt-bindings/clock/sun50i-h6-ccu.h     |   2 +-
 include/dt-bindings/clock/sun50i-h616-ccu.h   |   2 +-
 include/dt-bindings/clock/sun6i-rtc.h         |   2 +-
 include/dt-bindings/reset/sun20i-d1-ccu.h     |  79 ++
 include/dt-bindings/reset/sun20i-d1-r-ccu.h   |  16 +
 include/dt-bindings/reset/sun50i-h6-ccu.h     |   2 +-
 include/dt-bindings/reset/sun50i-h6-r-ccu.h   |   2 +-
 include/dt-bindings/reset/sun50i-h616-ccu.h   |   2 +-
 29 files changed, 1899 insertions(+), 132 deletions(-)
 create mode 100644 arch/arm/dts/sun50i-h616-orangepi-zero.dtsi
 create mode 100644 arch/arm/dts/sun50i-h618-orangepi-zero3.dts
 create mode 100644 arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts
 create mode 100644 arch/arm/dts/sun7i-a20-icnova-a20.dtsi
 create mode 100644 arch/arm/dts/sun8i-t113s-mangopi-mq-r-t113.dts
 create mode 100644 arch/arm/dts/sun8i-t113s.dtsi
 create mode 100644 arch/arm/dts/sunxi-d1s-t113-mangopi-mq-r.dtsi
 create mode 100644 arch/riscv/dts/sunxi-d1-t113.dtsi
 create mode 100644 arch/riscv/dts/sunxi-d1s-t113.dtsi
 create mode 100644 include/dt-bindings/clock/sun20i-d1-ccu.h
 create mode 100644 include/dt-bindings/clock/sun20i-d1-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun20i-d1-ccu.h
 create mode 100644 include/dt-bindings/reset/sun20i-d1-r-ccu.h

-- 
2.35.8

