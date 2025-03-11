Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84ED0C28B2F
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 20:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7B1881197;
	Tue, 11 Mar 2025 21:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53621807D7; Tue, 11 Mar 2025 21:58:04 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 83B77807D7
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 21:57:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: 7DGe+vxQSBKUJ7U+nKIhJg==
X-CSE-MsgGUID: wQeGHG84QcKqiZkCgGFCRw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 12 Mar 2025 05:57:57 +0900
Received: from rz-ub2404.betafive.net (unknown [10.24.0.12])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5CED740285F5;
 Wed, 12 Mar 2025 05:57:55 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 0/5] Add support for RZ/G2L USB interface
Date: Tue, 11 Mar 2025 20:57:42 +0000
Message-ID: <20250311205748.2492-1-paul.barker.ct@bp.renesas.com>
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

Changes v1->v2:
  - Add missing include <dm/device-internal.h> in
    reset-rzg2l-usbphy-ctrl.c.
  - Simplify reset control: we can just set the RESET_SEL_* bits in
    rzg2l_usbphy_ctrl_probe() and leave them set.
  - Use clrbits_le32() in rzg2l_usbphy_ctrl_deassert().
  - Include return value of the failing function in dev_err() prints.
  - Capitalise G in "R-Car Gen3".
  - Added Marek's Reviewed-by tags.

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
 .../power/regulator/rzg2l-usbphy-regulator.c  |  42 ++++++
 drivers/reset/Kconfig                         |  10 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-rzg2l-usbphy-ctrl.c       | 142 ++++++++++++++++++
 include/renesas/rzg2l-usbphy.h                |  17 +++
 10 files changed, 296 insertions(+), 16 deletions(-)
 create mode 100644 drivers/power/regulator/rzg2l-usbphy-regulator.c
 create mode 100644 drivers/reset/reset-rzg2l-usbphy-ctrl.c
 create mode 100644 include/renesas/rzg2l-usbphy.h

-- 
2.43.0

