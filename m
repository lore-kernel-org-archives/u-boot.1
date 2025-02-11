Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A2FC0219E
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 04:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92E3880824;
	Tue, 11 Feb 2025 05:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E3B2805E7; Tue, 11 Feb 2025 05:34:15 +0100 (CET)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40829803CC
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 05:34:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 51B4Xf16024593; Tue, 11 Feb 2025 13:33:41 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 marex@denx.de, quentin.schulz@cherry.de, dsimic@manjaro.org,
 jonas@kwiboo.se, benwolsieffer@gmail.com, a-dutta@ti.com,
 mkorpershoek@baylibre.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, jan.kiszka@siemens.com, s-vadapalli@ti.com,
 bb@ti.com, ian.roberts@timesys.com, sumit.garg@linaro.org,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH v2 1/2] rockchip: Fix TPL link error
Date: Tue, 11 Feb 2025 04:33:34 +0000
Message-ID: <20250211043335.92538-1-naoki@radxa.com>
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
Changes in v2:
- Move drivers/usb/{dwc,cdns}3 from scripts/Makefeile.xpl to drivers/Makefile
- Suppress unused warnings
---
 drivers/Makefile                | 2 ++
 drivers/usb/dwc3/dwc3-generic.c | 2 ++
 scripts/Makefile.xpl            | 2 --
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 0e1f58c515b..3ec05b942de 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -62,6 +62,8 @@ obj-$(CONFIG_ARCH_IMX9) += ddr/imx/imx9/
 obj-$(CONFIG_DRAM_SUN20I_D1) += ram/
 obj-$(CONFIG_SPL_DM_RESET) += reset/
 obj-$(CONFIG_SPL_MUSB_NEW) += usb/musb-new/
+obj-$(CONFIG_SPL_USB_GADGET) += usb/dwc3/
+obj-$(CONFIG_SPL_USB_GADGET) += usb/cdns3/
 obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/
 obj-$(CONFIG_SPL_USB_GADGET) += usb/common/
 obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/udc/
diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 55e62b35c61..8c2545bc2ec 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -50,6 +50,7 @@ struct dwc3_generic_host_priv {
 	struct udevice *vbus_supply;
 };
 
+#if !CONFIG_IS_ENABLED(SPL_BUILD) || CONFIG_IS_ENABLED(SPL_USB_DWC3_GENERIC)
 static int dwc3_generic_probe(struct udevice *dev,
 			      struct dwc3_generic_priv *priv,
 			      enum usb_dr_mode mode)
@@ -192,6 +193,7 @@ static int dwc3_generic_of_to_plat(struct udevice *dev)
 
 	return 0;
 }
+#endif
 
 #if CONFIG_IS_ENABLED(DM_USB_GADGET)
 static int dwc3_generic_peripheral_probe(struct udevice *dev)
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index abc49fbe6c9..a819af8a9b7 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -125,8 +125,6 @@ endif
 
 libs-y += drivers/
 libs-$(CONFIG_SPL_MEMORY) += drivers/memory/
-libs-$(CONFIG_SPL_USB_GADGET) += drivers/usb/dwc3/
-libs-$(CONFIG_SPL_USB_GADGET) += drivers/usb/cdns3/
 libs-y += dts/
 libs-y += fs/
 libs-$(CONFIG_SPL_POST_MEM_SUPPORT) += post/drivers/
-- 
2.43.0

