Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA663CD37BB
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 10:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA5968655F;
	Sat, 16 Sep 2023 12:16:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1694859398;
	bh=eIuJ5RcxZ52lCsDAmuTqSoiioItI+XhVWpD0tMF9Dgs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lb8oRmC1d6zdM2Y2E+We0kwhsqOdi6lIrunmM/50qX8DI8/DgaT/fZfQ250XixoGT
	 4MyqhHJ8DSShot4VJ+THLbofVsWUbEh8BKvME6uLoIgWcIkACvenFWWnCtI1V8a2T4
	 NypHBCyzvepVNv1bNSDCHlErDN+MbRWGnJaJvRw+2A4GIjvSPli8ETN1x7iWQmocDU
	 uVipqL0beGzrsfJGAy8shVYMT7DHs62q6hMCTBt/v/UTxWfP099nr1tM0x8IBEmITg
	 QX1gk7eOEihZ7yv+K0HvOuDWC8qf6FdKIUjpMbx1DhwpxEQFHuaSrTFIzld5+EndHE
	 GbQBqRtFZHp5w==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 07E508634D;
 Sat, 16 Sep 2023 12:16:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1694859398;
 bh=eIuJ5RcxZ52lCsDAmuTqSoiioItI+XhVWpD0tMF9Dgs=;
 h=From:To:Cc:Subject:Date:From;
 b=FEfxtKkkTtlEXP/0HmM9rbNcIXBh7FxTHLsaWA9H6FgkMyXgHvxUnzpRA6ERzmdE7
 G7WdqiQvRhSFKfyu+WVCxNu2dsHKDbk583AzkEF5cF8Y/4QHnf6epJPDygZ2EAg6+F
 XJcbkc80b5oYdLQQ+3uKNL3V3SqK7is1cvvbZkFNetMDm7kq3YdefZ2jSJ/HPI8O/L
 GEX5ReOXq8DJVCkeRnkgOlYXsnPpqYfHlaVncqzXQhEpsXcJ9nsw5PtHLsBE4Jf1qD
 W7zRJYDD3Z/m7HbT6o32FBVrfivM5VFL1nSbMRiFmOuogoPiAmx7eixk1I5Hk28/tF
 qRM5SkfLuIHKg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>
Subject: [PULL] u-boot-usb/next
Date: Sat, 16 Sep 2023 12:16:18 +0200
Message-Id: <20230916101618.5191-1-marex@denx.de>
X-Mailer: git-send-email 2.40.1
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

The following changes since commit 2fe4b54556ea6271237b35de68dc458bfceab94c:

  Merge branch '2023-09-14-remove-NEEDS_MANUAL_RELOC' into next (2023-09-14 16:23:49 -0400)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git next

for you to fetch changes up to 2caf974b5fac69a1b778e64503f2c107a8d7c3a3:

  board: usb: Replace legacy usb_gadget_handle_interrupts() (2023-09-15 23:38:02 +0200)

----------------------------------------------------------------
Marek Vasut (17):
      dm: usb: udc: Factor out plain udevice handler functions
      usb: sandbox: Add DM_USB_GADGET support
      configs: sandbox: Enable DM_USB_GADGET
      cmd: fastboot: Use plain udevice for UDC controller interaction
      cmd: rockusb: Use plain udevice for UDC controller interaction
      cmd: sdp: Reorder variable declaration
      cmd: thordown: Reorder variable declaration
      cmd: ums: Use plain udevice for UDC controller interaction
      dfu: Detach the controller on error
      dfu: Use plain udevice for UDC controller interaction
      spl: sdp: Detach the controller on error
      sdp: Use plain udevice for UDC controller interaction
      thordown: Use plain udevice for UDC controller interaction
      usb: gadget: acm: Use plain udevice for UDC controller interaction
      usb: gadget: ether: Use plain udevice for UDC controller interaction
      dm: usb: udc: Drop legacy udevice handler functions
      board: usb: Replace legacy usb_gadget_handle_interrupts()

 arch/arm/mach-rockchip/board.c      |  4 +-
 board/purism/librem5/spl.c          |  4 +-
 board/samsung/common/exynos5-dt.c   |  4 +-
 board/st/stih410-b2260/board.c      |  4 +-
 board/ti/am43xx/board.c             |  6 +--
 cmd/fastboot.c                      |  7 ++--
 cmd/rockusb.c                       |  7 ++--
 cmd/thordown.c                      | 24 ++++++------
 cmd/usb_gadget_sdp.c                | 15 +++++---
 cmd/usb_mass_storage.c              | 10 +++--
 common/dfu.c                        | 19 ++++++----
 common/spl/spl_sdp.c                | 20 ++++++----
 configs/sandbox64_defconfig         |  1 +
 configs/sandbox_defconfig           |  1 +
 configs/sandbox_flattree_defconfig  |  1 +
 configs/sandbox_noinst_defconfig    |  1 +
 configs/sandbox_spl_defconfig       |  1 +
 configs/sandbox_vpl_defconfig       |  1 +
 drivers/usb/dwc3/core.c             |  6 +--
 drivers/usb/dwc3/dwc3-omap.c        |  8 ++--
 drivers/usb/gadget/at91_udc.c       |  2 +-
 drivers/usb/gadget/atmel_usba_udc.c |  3 +-
 drivers/usb/gadget/ci_udc.c         |  4 +-
 drivers/usb/gadget/dwc2_udc_otg.c   | 12 +-----
 drivers/usb/gadget/ether.c          | 20 +++++-----
 drivers/usb/gadget/f_acm.c          | 13 ++++---
 drivers/usb/gadget/f_mass_storage.c |  8 ++--
 drivers/usb/gadget/f_sdp.c          | 10 ++---
 drivers/usb/gadget/f_thor.c         | 74 +++++++++++++++++++------------------
 drivers/usb/gadget/udc/Makefile     |  2 +-
 drivers/usb/gadget/udc/udc-uclass.c | 57 ++++++++++++++--------------
 drivers/usb/host/usb-sandbox.c      |  6 ++-
 drivers/usb/musb-new/musb_uboot.c   |  2 +-
 include/dwc3-omap-uboot.h           |  2 +-
 include/dwc3-uboot.h                |  2 +-
 include/linux/usb/gadget.h          | 32 ++++++++--------
 include/sdp.h                       |  6 +--
 include/thor.h                      |  4 +-
 include/usb_mass_storage.h          |  2 +-
 39 files changed, 214 insertions(+), 191 deletions(-)
