Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4C4C4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 08:53:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFCC787981;
	Fri, 12 Jan 2024 09:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="nwT1p3+3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15C1E86D38; Fri, 12 Jan 2024 09:53:22 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7F5A8795E
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 09:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sjoerd@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1705049598;
 bh=P5OKQzKnTwK6oMwOOWAzazDTBGas+irKs4FtgdRyoOY=;
 h=From:To:Cc:Subject:Date:From;
 b=nwT1p3+3INgCnYGkmv+68WTiJF7iVKPrDtTIACVihqnwXH9+TyT26WDiF4nKI2fYD
 1hiC2Z5N86rItxz6GX0nWm/DTwE/xZAvUAlqq9hUigmaTkFR3Uoe51AE7gvgYPoLEU
 g2rQYb0F9K5/4Jd7IZlsaw1szt52PUO1q/7rpSPuX8kXJj1R/X+JwNvJ/se9/JtS3N
 ngzd+ZPw0hSDK012KtXazbjAcIXn60sVRRZqeiE0YS2STOJZRQNBW2OKyY7aCgGULo
 FnbwsOFABYxgmjKMKjy2iC+z96n3nVn0w/dwveYQ4KR+O7nmQ+gR8yo209ym8GKHx8
 UcBIdLuy8f22Q==
Received: from beast.luon.net (cola.collaboradmins.com
 [IPv6:2a01:4f8:1c1c:5717::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sjoerd)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id F172B3781FC7;
 Fri, 12 Jan 2024 08:53:17 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
 id 6FDE69ED7CC8; Fri, 12 Jan 2024 09:53:17 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
To: u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>,
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dave Gerlach <d-gerlach@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Judith Mendez <jm@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neha Malcom Francis <n-francis@ti.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Praneeth Bajjuri <praneeth@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v4 0/7] Add DFU and usb boot for TI am62x SK and beagleplay
Date: Fri, 12 Jan 2024 09:52:15 +0100
Message-ID: <20240112085317.1866449-1-sjoerd@collabora.com>
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


This series adds DFU support for TI AM62 SK board and new since this
version also for beagleplay.

Since the last revision, apart from beagleplay support the main changes
are:
* Documentation was added on how to use this functionality on both boards
* the R5 configuration is now done via a config fragment rather
  then a full configuraiton
* A new patch was added for dwc3 to work in device mode even if dr_mode is
  configured as otg. Avoiding the need for an explicit switch to
  periphal in the u-boot dts

I will also submit the dts changes to linux so that those can be dropped
again in the near future (hopefully)

Changes in v4:
- Add config dependency on SYSCON
- Move defines and constants outside out of function scope
- Don't force usb0 into peripheral mode
- Move R5 dfu config to a config fragment rather then a full defconfig
- Don't enable XHCI for the R5 SPL, unneeded

Change in v3:
- Add dfu via environment rather then config headers
- Enable usb nodes in all boot phases
- Run savedefconfig to adjust to more recent u-boot

Changes in v2:
- Switch dwc3 glue to a seperate driver rather then in dwc-generic
- Minimize config changes to just DFU configuration
- Only enable usb port 0 DFU in SPL
- Create a seperate defconfig for R5

Sjoerd Simons (7):
  usb: dwc3: Add dwc3 glue driver for am62
  usb: dwc3: Switch to device mode on gadget start
  board: ti: am62x: am62x: include env for DFU
  arm: dts: k3-am625-sk: Enable usb port in u-boot
  configs: am62x_evm_*: Enable USB and DFU support
  beagleplay: Add DFU support
  doc: board: Add document for DFU boot on am62x SoCs

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi |   8 ++
 arch/arm/dts/k3-am625-sk-u-boot.dtsi         |   8 ++
 board/beagle/beagleplay/beagleplay.env       |   1 +
 board/ti/am62x/am62x.env                     |   1 +
 configs/am62x_beagleplay_a53_defconfig       |  30 +++++
 configs/am62x_evm_a53_defconfig              |  30 +++++
 configs/am62x_r5_usbdfu.config               |  28 +++++
 doc/board/beagle/am62x_beagleplay.rst        |  12 ++
 doc/board/ti/am62x_sk.rst                    |  37 ++++++
 drivers/usb/dwc3/Kconfig                     |  14 +++
 drivers/usb/dwc3/Makefile                    |   1 +
 drivers/usb/dwc3/core.c                      |  10 +-
 drivers/usb/dwc3/core.h                      |   1 +
 drivers/usb/dwc3/dwc3-am62.c                 | 125 +++++++++++++++++++
 drivers/usb/dwc3/gadget.c                    |   6 +
 15 files changed, 307 insertions(+), 5 deletions(-)
 create mode 100644 configs/am62x_r5_usbdfu.config
 create mode 100644 drivers/usb/dwc3/dwc3-am62.c

-- 
2.43.0

