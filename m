Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6DCCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 22:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CE948704E;
	Thu, 19 Oct 2023 00:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="gfsOvPNX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 005A387040; Thu, 19 Oct 2023 00:31:25 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55A7586E7E
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 00:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bda0=GB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1697668276; bh=RiG+KCMjEtpTQvZeSpHBdkHEZNu6s94CP6DzIMTcrhE=;
 b=gfsOvPNXwFuLmYpk4OI3UXFN3i6d5iS2w2aKvgcpvFpw+a96EQ9v0ArL0ksT0dEXPGZX5LYNU
 tRO8ex99qViqVVqACc4Mhm6aGJmv5AY9f92QNPrBrtG4kyx5+qURUG+l7fp/SGKfGG/b7rtuorU
 H7RXV5ckRhizY+Ic42oSv7fdP/yt9PDpqARiubL8cSfFZjQot9o5WLAwIpIP4eNotTfhDj2zgCp
 uPTVko9QXwTWRywmOFCSUrjRpGcO8b0MhhjAtX49TMfO+sXA6VWaaDv0d3JPGanErSj+7lf3aED
 id+lEU8ohNB02S8A7ix0+1MDtTKz6Ji7Gt5ybV7rk1nA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/2] rockchip: board: Remove dwc3 usb init and gadget handler
 functions
Date: Wed, 18 Oct 2023 22:30:52 +0000
Message-ID: <20231018223058.2081052-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231018223058.2081052-1-jonas@kwiboo.se>
References: <20231018223058.2081052-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65305cb453b629052bafed86
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

Remove board_usb_init() and dm_usb_gadget_handle_interrupts() functions
related to dwc3, they use e.g. a hard-coded reg address for RK3399 and
are obsolete with use of DM_USB_GADGET.

Use of DM_USB_GADGET, USB_DWC3_GENERIC and USB_DWC3_GADGET have replaced
same feature provided by the removed functions on RK3399 boards.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/board.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 57f08e0be0e9..3496839c879c 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -287,30 +287,6 @@ int board_usb_cleanup(int index, enum usb_init_type init)
 }
 #endif /* CONFIG_USB_GADGET_DWC2_OTG */
 
-#if defined(CONFIG_USB_DWC3_GADGET) && !defined(CONFIG_DM_USB_GADGET)
-#include <dwc3-uboot.h>
-
-static struct dwc3_device dwc3_device_data = {
-	.maximum_speed = USB_SPEED_HIGH,
-	.base = 0xfe800000,
-	.dr_mode = USB_DR_MODE_PERIPHERAL,
-	.index = 0,
-	.dis_u2_susphy_quirk = 1,
-	.hsphy_mode = USBPHY_INTERFACE_MODE_UTMIW,
-};
-
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
-{
-	dwc3_uboot_handle_interrupt(dev);
-	return 0;
-}
-
-int board_usb_init(int index, enum usb_init_type init)
-{
-	return dwc3_uboot_init(&dwc3_device_data);
-}
-#endif /* CONFIG_USB_DWC3_GADGET */
-
 #endif /* CONFIG_USB_GADGET */
 
 #if IS_ENABLED(CONFIG_FASTBOOT)
-- 
2.42.0

