Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0412E77188
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 14:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCE908060C;
	Mon, 30 Dec 2024 15:35:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hI8qQF/d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA4D7805EB; Mon, 30 Dec 2024 04:30:53 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CB0A804CE
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 04:30:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+liujh2818.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7212AA4093D;
 Mon, 30 Dec 2024 03:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7F54C4CED1;
 Mon, 30 Dec 2024 03:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1735529449;
 bh=CCYatxKTxRYELBIp9U83giTybP8U3Jv6Trfrr3zmKHY=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=hI8qQF/d2k2meQ6mfu6g9PRtmlwgAkK+KrXhWge32chMRsJhvjJLXHvOteJj7btIw
 phGsgRi7Zd4ex7Y34tIadQPbwxhlM2yfVANpa5cuVT1VDSil+z/zGaBDbHv8p/lt/h
 mW9QUAlN4MLW+A2RC2d1/1ghUM9wyHpEoqQ+nk6avaYZxmxEuyBv5mp9b/LX0o8BdK
 YQra8NEBpYS2yx0FcdbAoKhqpUEUpQqTz6Grd5/eMdjnc1P76iNmHU2fsdwc/xCIJo
 uiJd9/2/5sxbG1jUwpqRUlQv728qjqHmC0KVMO6ZGQWse7WS5sLuctV16gz2EkV0wC
 9zTqqMApN+RZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 91233E77188;
 Mon, 30 Dec 2024 03:30:49 +0000 (UTC)
From: Junhui Liu via B4 Relay <devnull+liujh2818.outlook.com@kernel.org>
Subject: [PATCH v2 0/8] usb: dwc2: Refactor and update USB DWC2 driver
Date: Mon, 30 Dec 2024 11:30:15 +0800
Message-Id: <20241230-dwc2-dev-v2-0-12cd9b8a2358@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMcTcmcC/x3Myw6CMBCF4Vchs7aEM7QRXfkehkVTRpiEi2kNa
 gjvbmX5n5x8GyWJKomuxUZRVk26zDn4VFAY/NyL0S43ccUWjMZ078Cmk9VcnAsM3wBoKN+fUR7
 6Oah7m3vQ9Fri95BX/NcDqRwzLNdAiXPtYGCS+DTIOAJcW+vcrZ+8jmVYJmr3ff8BwBhExKQAA
 AA=
X-Change-ID: 20241218-dwc2-dev-955c21a81118
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>, 
 Junhui Liu <liujh2818@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735529447; l=2593;
 i=liujh2818@outlook.com; s=20241030; h=from:subject:message-id;
 bh=CCYatxKTxRYELBIp9U83giTybP8U3Jv6Trfrr3zmKHY=;
 b=mUT1hHIZFohvjc5ywRf5CN56tysibFrFzU2yw4ChpKZDx1+A/exnDSw6/V6MsqnqOEmaxiBGF
 ddVSVk0iLwgD3fdi+34Z9rWxcX+6WNHUi0x6ataFsGLWFv/P8xubh4c
X-Developer-Key: i=liujh2818@outlook.com; a=ed25519;
 pk=ApYwI6KD3EjynMw61RqGa6c5BGbStQnKSrbNN+aQqT4=
X-Endpoint-Received: by B4 Relay for liujh2818@outlook.com/20241030 with
 auth_id=259
X-Original-From: Junhui Liu <liujh2818@outlook.com>
X-Mailman-Approved-At: Mon, 30 Dec 2024 15:35:32 +0100
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
Reply-To: liujh2818@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This series improves the USB DWC2 driver by extracting register
definitions into a common file for better readability and updating the
reset method to reflect changes in version 4.20a, including the new
GRSTCTL_CSFTRST_DONE bit for reset completion indication.

This series has been tested on two platforms:
- MK808 with RK3066 SoC and dwc2 v2.91a, tested with USB flash drive and
  connected the board to the PC through the rockusb command. Test log [1].
- K230-CanMV with K230 SoC [2] and dwc2 v4.30a, tested with the onboard
  rtl8152 USB to net chip and an external rtl8152 adapter connected to 
  the onboard USB-C interface via USB hub. Test log [3].

[1] https://gist.github.com/Judehahh/878ace2607d201dc49211f2c655f0fe0#file-mk808-md
[2] https://developer.canaan-creative.com/k230/en/dev/CanMV_K230_Tutorial.html
[3] https://gist.github.com/Judehahh/878ace2607d201dc49211f2c655f0fe0#file-k230-canmv-md

---
Changes in v2:
- Reorganized structures, renamed macros, and moved code for better
  clarity and maintainability.
- Added a fix for the incorrect ULPI_UTMI_SEL bit setting.
- Added a fix for incorrectly calculating HBstLen for external DMA mode.
- Extend the changes that replace uint32 with u32 to also include u8 and
  u16.
- Link to v1: https://lore.kernel.org/r/20240522142311.17351-1-seashell11234455@gmail.com

---
Junhui Liu (8):
      usb: dwc2: Extract register definitions to common header file
      usb: dwc2: Fix incorrect ULPI_UTMI_SEL bit setting
      USB: dwc2: Fix HBstLen setting for external DMA mode
      usb: dwc2: Clean up with bitfield macros
      usb: dwc2: Align macros with Linux kernel definitions
      usb: dwc2: Extract macro definitions to common header
      usb: dwc2: Unify flush and reset logic with v4.20a support
      usb: dwc2: Replace uint<x>_t types with u<x>

 drivers/usb/common/Makefile                |   2 +
 drivers/usb/common/dwc2_core.c             | 103 ++++
 drivers/usb/common/dwc2_core.h             | 560 +++++++++++++++++++++
 drivers/usb/gadget/dwc2_udc_otg.c          | 125 ++---
 drivers/usb/gadget/dwc2_udc_otg_regs.h     | 289 ++---------
 drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c | 306 ++++++------
 drivers/usb/host/dwc2.c                    | 494 ++++++++-----------
 drivers/usb/host/dwc2.h                    | 750 +----------------------------
 8 files changed, 1123 insertions(+), 1506 deletions(-)
---
base-commit: cb7410257ac930a6fb05f1c63b291b7d399f19f2
change-id: 20241218-dwc2-dev-955c21a81118

Best regards,
-- 
Junhui Liu <liujh2818@outlook.com>


