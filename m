Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898D2C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 16:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6D3A801CF;
	Tue,  4 Mar 2025 17:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B922D807D9; Tue,  4 Mar 2025 17:37:54 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 19BCA8004F
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 17:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: 68qd/U+2Q9aGKR6a/6g2JQ==
X-CSE-MsgGUID: e8H9aikAS/y86rFA2gKGYw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 05 Mar 2025 01:37:48 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.7])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id EF0844024115;
 Wed,  5 Mar 2025 01:37:45 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH 0/5] Add support for RZ/G2L USB interface
Date: Tue,  4 Mar 2025 16:37:30 +0000
Message-ID: <20250304163736.89326-1-paul.barker.ct@bp.renesas.com>
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

These patches enable support for USB 2.0 on the Renesas RZ/G2L EVK,
supporting both the USB Type-A port and the USB OTG port. It is possible
to load and boot Linux from a USB Mass Storage device connected to
either port.

There should be no change to the operation of R-Car gen3 boards, but I
don't have any of them available to test to confirm this myself.

Paul Barker (5):
  reset: rzg2l-usbphy-ctrl: Add new driver
  regulator: rzg2l-usbphy: Add new driver
  reset: rzg2l-usbphy-ctrl: Connect up vbus regulator
  phy: rcar: Support RZ/G2L USB PHY
  renesas_rzg2l_smarc_defconfig: Enable USB support

 configs/renesas_rzg2l_smarc_defconfig         |   8 +
 drivers/phy/Kconfig                           |   4 +-
 drivers/phy/phy-rcar-gen3.c                   |  79 ++++++++--
 drivers/power/regulator/Kconfig               |   8 +
 drivers/power/regulator/Makefile              |   1 +
 .../power/regulator/rzg2l-usbphy-regulator.c  |  42 +++++
 drivers/reset/Kconfig                         |  10 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-rzg2l-usbphy-ctrl.c       | 145 ++++++++++++++++++
 include/renesas/rzg2l-usbphy.h                |  17 ++
 10 files changed, 299 insertions(+), 16 deletions(-)
 create mode 100644 drivers/power/regulator/rzg2l-usbphy-regulator.c
 create mode 100644 drivers/reset/reset-rzg2l-usbphy-ctrl.c
 create mode 100644 include/renesas/rzg2l-usbphy.h

-- 
2.43.0

