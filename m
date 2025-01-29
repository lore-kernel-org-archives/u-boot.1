Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F7EC02190
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 13:26:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D2AF81F00;
	Wed, 29 Jan 2025 14:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EAFE807E5; Wed, 29 Jan 2025 14:26:03 +0100 (CET)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C78081EC9
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 14:26:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 50TDPec2011059; Wed, 29 Jan 2025 22:25:40 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, jonas@kwiboo.se, dsimic@manjaro.org,
 quentin.schulz@cherry.de, pbrobinson@gmail.com,
 marek.vasut+renesas@mailbox.org, ian.roberts@timesys.com,
 nathan.morrison@timesys.com, greg.malysa@timesys.com, bb@ti.com,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH 1/3] rockchip: Fix TPL link error
Date: Wed, 29 Jan 2025 13:25:27 +0000
Message-ID: <20250129132529.807031-1-naoki@radxa.com>
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

Rockchip RK3399 targets build TPL. If CONFIG_SPL_USB_DWC3_GENERIC and
CONFIG_SPL_USB_GADGET are enabled, linking u-boot-tpl will fail.

  LD      tpl/u-boot-tpl
ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in function `dwc3_glue_bind_common':
/home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:527:(.text.dwc3_glue_bind_common+0x20): undefined reference to `usb_get_dr_mode'
/home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:527:(.text.dwc3_glue_bind_common+0x20): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_get_dr_mode'
ld.bfd: /home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:529:(.text.dwc3_glue_bind_common+0x2c): undefined reference to `usb_get_dr_mode'
/home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:529:(.text.dwc3_glue_bind_common+0x2c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_get_dr_mode'
ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in function `dwc3_glue_probe':
/home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:683:(.text.dwc3_glue_probe+0xb0): undefined reference to `usb_get_dr_mode'
/home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:683:(.text.dwc3_glue_probe+0xb0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_get_dr_mode'

Do not compile drivers/usb/ for TPL.

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
 scripts/Makefile.xpl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index abc49fbe6c9..e4ca4d395ac 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -125,8 +125,8 @@ endif
 
 libs-y += drivers/
 libs-$(CONFIG_SPL_MEMORY) += drivers/memory/
-libs-$(CONFIG_SPL_USB_GADGET) += drivers/usb/dwc3/
-libs-$(CONFIG_SPL_USB_GADGET) += drivers/usb/cdns3/
+libs-$(CONFIG_$(PHASE_)USB_GADGET) += drivers/usb/dwc3/
+libs-$(CONFIG_$(PHASE_)USB_GADGET) += drivers/usb/cdns3/
 libs-y += dts/
 libs-y += fs/
 libs-$(CONFIG_SPL_POST_MEM_SUPPORT) += post/drivers/
-- 
2.43.0

