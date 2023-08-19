Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461A3EE49A5
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 14:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8FE187089;
	Sat, 19 Aug 2023 16:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692455091;
	bh=Kqdii/mwPagJpvWXMjZHByGkRmVYJVt2wNDlXrIaN6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GCZq57EEbmCtzmn+pEeCP2ED4FRsumg9u1AEEkSvxgvFO2RTXKstdKZGuFtQTC05R
	 N6oUNWGVfFXmNVGDjKj32hxUmRcptWlSkSWo9fT7BcDNKs8Z3hQI8SHdnn1Oy3uhdS
	 1HnON21VIZMH80qheDhNOe4ZWbGHA0mLOM9IpM0M00JiKvPMZDcJRk8NQx2NEkmPiE
	 wxzfvLqGDECqbHrM5qH4c4wKxI2rmI6uOjnr1rQAoOC4NRaL2VeYYHK1l3Fj0eSUxN
	 r81uLIVg89ZUtX8JITiGACFLFkVSIfpiDszC93M9dEgAkpaDxChxIKEYZqBSdb5/kS
	 auLYySh5EvbLQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E1A5587070;
 Sat, 19 Aug 2023 16:24:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692455087;
 bh=Kqdii/mwPagJpvWXMjZHByGkRmVYJVt2wNDlXrIaN6Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=d7zZYTUduxQVUzTjXkQvLqFB/vL0DtkPEPQj/vyWn+xQlCv1A9bO9CGltInKDFw5U
 Yx04ZhBX9/PCWFycPhbvEJN36tcHWlrRwEcOKxVfv1GVrFD93Po+aYTtmUsmLXbY0s
 dpnufD6Jdn82eUxvUdMlzuF7NJGnmzsXipDzX6bXfpDW3sIaHDSm81yMVZ8iAZMsjH
 mkuiDb9Bfm9QV1OG7/U9biBHBVxXpbAx3lngnzKA58M7iJ4UVme8T6OUCesIB7wgs5
 4cNulvcIT7Ee9TCXvAJn4MBQFGbteeSNcWETez/nMT4beX45cOQSQBIN29F+fSxIx5
 q3LMwyF/x/ukw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Angus Ainslie <angus@akkea.ca>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, kernel@puri.sm
Subject: [PATCH 17/17] board: usb: Replace legacy
 usb_gadget_handle_interrupts()
Date: Sat, 19 Aug 2023 16:24:07 +0200
Message-Id: <20230819142407.49632-17-marex@denx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230819142407.49632-1-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
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

The usb_gadget_handle_interrupts() is no longer used anywhere,
replace the remaining uses with dm_usb_gadget_handle_interrupts()
which takes udevice as a parameter.

Some of the UDC drivers currently ignore the index parameter altogether,
those also ignore the udevice and have to be reworked. Other like the
dwc3_uboot_handle_interrupt() had to be switched from index to udevice
look up to avoid breakage.

Signed-off-by: Marek Vasut <marex@denx.de>
---
NOTE: Next step, get rid of dwc3_uboot_init()/dwc3_uboot_exit()
---
Cc: Angus Ainslie <angus@akkea.ca>
Cc: Dmitrii Merkurev <dimorinny@google.com>
Cc: Eddie Cai <eddie.cai.linux@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: kernel@puri.sm
---
 arch/arm/mach-rockchip/board.c      |  4 ++--
 board/purism/librem5/spl.c          |  4 ++--
 board/samsung/common/exynos5-dt.c   |  4 ++--
 board/st/stih410-b2260/board.c      |  4 ++--
 board/ti/am43xx/board.c             |  6 +++---
 drivers/usb/dwc3/core.c             |  6 +++---
 drivers/usb/dwc3/dwc3-omap.c        |  8 ++++----
 drivers/usb/gadget/at91_udc.c       |  2 +-
 drivers/usb/gadget/atmel_usba_udc.c |  3 +--
 drivers/usb/gadget/ci_udc.c         |  4 ++--
 drivers/usb/gadget/dwc2_udc_otg.c   | 12 ++----------
 drivers/usb/gadget/udc/udc-uclass.c | 12 ------------
 drivers/usb/host/usb-sandbox.c      |  5 -----
 drivers/usb/musb-new/musb_uboot.c   |  2 +-
 include/dwc3-omap-uboot.h           |  2 +-
 include/dwc3-uboot.h                |  2 +-
 include/linux/usb/gadget.h          |  2 +-
 17 files changed, 28 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 8d7b39ba157..57f08e0be0e 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -299,9 +299,9 @@ static struct dwc3_device dwc3_device_data = {
 	.hsphy_mode = USBPHY_INTERFACE_MODE_UTMIW,
 };
 
-int usb_gadget_handle_interrupts(int index)
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 {
-	dwc3_uboot_handle_interrupt(0);
+	dwc3_uboot_handle_interrupt(dev);
 	return 0;
 }
 
diff --git a/board/purism/librem5/spl.c b/board/purism/librem5/spl.c
index 90f1fcf415f..581f0929662 100644
--- a/board/purism/librem5/spl.c
+++ b/board/purism/librem5/spl.c
@@ -418,9 +418,9 @@ out:
 	return rv;
 }
 
-int usb_gadget_handle_interrupts(int index)
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 {
-	dwc3_uboot_handle_interrupt(0);
+	dwc3_uboot_handle_interrupt(dev);
 	return 0;
 }
 
diff --git a/board/samsung/common/exynos5-dt.c b/board/samsung/common/exynos5-dt.c
index cde77d79a0f..726b7f0667a 100644
--- a/board/samsung/common/exynos5-dt.c
+++ b/board/samsung/common/exynos5-dt.c
@@ -126,9 +126,9 @@ static struct dwc3_device dwc3_device_data = {
 	.index = 0,
 };
 
-int usb_gadget_handle_interrupts(int index)
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 {
-	dwc3_uboot_handle_interrupt(0);
+	dwc3_uboot_handle_interrupt(dev);
 	return 0;
 }
 
diff --git a/board/st/stih410-b2260/board.c b/board/st/stih410-b2260/board.c
index cd3a7dc51a2..e21cbc270e9 100644
--- a/board/st/stih410-b2260/board.c
+++ b/board/st/stih410-b2260/board.c
@@ -50,9 +50,9 @@ static struct dwc3_device dwc3_device_data = {
 	.index = 0,
 };
 
-int usb_gadget_handle_interrupts(int index)
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 {
-	dwc3_uboot_handle_interrupt(index);
+	dwc3_uboot_handle_interrupt(dev);
 	return 0;
 }
 
diff --git a/board/ti/am43xx/board.c b/board/ti/am43xx/board.c
index 87e552a4701..58bfe7cd455 100644
--- a/board/ti/am43xx/board.c
+++ b/board/ti/am43xx/board.c
@@ -760,13 +760,13 @@ static struct ti_usb_phy_device usb_phy2_device = {
 	.index = 1,
 };
 
-int usb_gadget_handle_interrupts(int index)
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 {
 	u32 status;
 
-	status = dwc3_omap_uboot_interrupt_status(index);
+	status = dwc3_omap_uboot_interrupt_status(dev);
 	if (status)
-		dwc3_uboot_handle_interrupt(index);
+		dwc3_uboot_handle_interrupt(dev);
 
 	return 0;
 }
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 49f6a1900b0..7ca9d09824e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -986,18 +986,18 @@ void dwc3_uboot_exit(int index)
 
 /**
  * dwc3_uboot_handle_interrupt - handle dwc3 core interrupt
- * @index: index of this controller
+ * @dev: device of this controller
  *
  * Invokes dwc3 gadget interrupts.
  *
  * Generally called from board file.
  */
-void dwc3_uboot_handle_interrupt(int index)
+void dwc3_uboot_handle_interrupt(struct udevice *dev)
 {
 	struct dwc3 *dwc = NULL;
 
 	list_for_each_entry(dwc, &dwc3_list, list) {
-		if (dwc->index != index)
+		if (dwc->dev != dev)
 			continue;
 
 		dwc3_gadget_uboot_handle_interrupt(dwc);
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 9596bf144c3..ff4ebfb4447 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -119,7 +119,7 @@
 #define USBOTGSS_UTMI_OTG_STATUS_VBUSVALID	(1 << 1)
 
 struct dwc3_omap {
-	struct device		*dev;
+	struct udevice		*dev;
 
 	void __iomem		*base;
 
@@ -429,19 +429,19 @@ void dwc3_omap_uboot_exit(int index)
 
 /**
  * dwc3_omap_uboot_interrupt_status - check the status of interrupt
- * @index: index of this controller
+ * @dev: device of this controller
  *
  * Checks the status of interrupts and returns true if an interrupt
  * is detected or false otherwise.
  *
  * Generally called from board file.
  */
-int dwc3_omap_uboot_interrupt_status(int index)
+int dwc3_omap_uboot_interrupt_status(struct udevice *dev)
 {
 	struct dwc3_omap *omap = NULL;
 
 	list_for_each_entry(omap, &dwc3_omap_list, list)
-		if (omap->index == index)
+		if (omap->dev == dev)
 			return dwc3_omap_interrupt(-1, omap);
 
 	return 0;
diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index baa4c431fed..61d2aa5b929 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1429,7 +1429,7 @@ static const struct at91_udc_caps at91sam9261_udc_caps = {
 };
 #endif
 
-int usb_gadget_handle_interrupts(int index)
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 {
 	struct at91_udc *udc = controller;
 
diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index f4dcd205a4f..90b248a0777 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1198,14 +1198,13 @@ static struct usba_udc controller = {
 	},
 };
 
-int usb_gadget_handle_interrupts(int index)
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 {
 	struct usba_udc *udc = &controller;
 
 	return usba_udc_irq(udc);
 }
 
-
 int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 {
 	struct usba_udc *udc = &controller;
diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 5bb26d7ab4a..44d2da0b4fb 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -869,10 +869,10 @@ void udc_irq(void)
 	}
 }
 
-int usb_gadget_handle_interrupts(int index)
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 {
-	u32 value;
 	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
+	u32 value;
 
 	value = readl(&udc->usbsts);
 	if (value)
diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 0a3bc0886e6..ff5173eda68 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -941,15 +941,12 @@ int dwc2_udc_handle_interrupt(void)
 	return 0;
 }
 
-#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
-
-int usb_gadget_handle_interrupts(int index)
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 {
 	return dwc2_udc_handle_interrupt();
 }
 
-#else /* CONFIG_IS_ENABLED(DM_USB_GADGET) */
-
+#if CONFIG_IS_ENABLED(DM_USB_GADGET)
 struct dwc2_priv_data {
 	struct clk_bulk		clks;
 	struct reset_ctl_bulk	resets;
@@ -957,11 +954,6 @@ struct dwc2_priv_data {
 	struct udevice *usb33d_supply;
 };
 
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
-{
-	return dwc2_udc_handle_interrupt();
-}
-
 static int dwc2_phy_setup(struct udevice *dev, struct phy_bulk *phys)
 {
 	int ret;
diff --git a/drivers/usb/gadget/udc/udc-uclass.c b/drivers/usb/gadget/udc/udc-uclass.c
index 7f54a3b00cb..9dfae08313b 100644
--- a/drivers/usb/gadget/udc/udc-uclass.c
+++ b/drivers/usb/gadget/udc/udc-uclass.c
@@ -41,18 +41,6 @@ int udc_device_put(struct udevice *udev)
 	return -ENOSYS;
 #endif
 }
-
-int usb_gadget_handle_interrupts(int index)
-{
-	struct udevice *udc;
-	int ret;
-
-	ret = udc_device_get_by_index(index, &udc);
-	if (ret)
-		return ret;
-
-	return dm_usb_gadget_handle_interrupts(udc);
-}
 #else
 /* Backwards hardware compatibility -- switch to DM_USB_GADGET */
 static int legacy_index;
diff --git a/drivers/usb/host/usb-sandbox.c b/drivers/usb/host/usb-sandbox.c
index 582f72d00c1..3d4f8d653b5 100644
--- a/drivers/usb/host/usb-sandbox.c
+++ b/drivers/usb/host/usb-sandbox.c
@@ -130,11 +130,6 @@ int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 	return 0;
 }
 #else
-int usb_gadget_handle_interrupts(int index)
-{
-	return 0;
-}
-
 int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 {
 	struct sandbox_udc *dev = this_controller;
diff --git a/drivers/usb/musb-new/musb_uboot.c b/drivers/usb/musb-new/musb_uboot.c
index 67dc11669d2..0dcc428efeb 100644
--- a/drivers/usb/musb-new/musb_uboot.c
+++ b/drivers/usb/musb-new/musb_uboot.c
@@ -376,7 +376,7 @@ struct dm_usb_ops musb_usb_ops = {
 #if defined(CONFIG_USB_MUSB_GADGET) && !CONFIG_IS_ENABLED(DM_USB_GADGET)
 static struct musb *gadget;
 
-int usb_gadget_handle_interrupts(int index)
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 {
 	schedule();
 	if (!gadget || !gadget->isr)
diff --git a/include/dwc3-omap-uboot.h b/include/dwc3-omap-uboot.h
index 7c982e3798b..9e0e717dc98 100644
--- a/include/dwc3-omap-uboot.h
+++ b/include/dwc3-omap-uboot.h
@@ -27,5 +27,5 @@ struct dwc3_omap_device {
 
 int dwc3_omap_uboot_init(struct dwc3_omap_device *dev);
 void dwc3_omap_uboot_exit(int index);
-int dwc3_omap_uboot_interrupt_status(int index);
+int dwc3_omap_uboot_interrupt_status(struct udevice *dev);
 #endif /* __DWC3_OMAP_UBOOT_H_ */
diff --git a/include/dwc3-uboot.h b/include/dwc3-uboot.h
index e08530ec4e5..bb0436c0973 100644
--- a/include/dwc3-uboot.h
+++ b/include/dwc3-uboot.h
@@ -44,7 +44,7 @@ struct dwc3_device {
 
 int dwc3_uboot_init(struct dwc3_device *dev);
 void dwc3_uboot_exit(int index);
-void dwc3_uboot_handle_interrupt(int index);
+void dwc3_uboot_handle_interrupt(struct udevice *dev);
 
 struct phy;
 #if CONFIG_IS_ENABLED(PHY) && CONFIG_IS_ENABLED(DM_USB)
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 54875d2716e..40228e320b3 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -1004,7 +1004,7 @@ extern struct usb_ep *usb_ep_autoconfig(struct usb_gadget *,
 
 extern void usb_ep_autoconfig_reset(struct usb_gadget *);
 
-extern int usb_gadget_handle_interrupts(int index);
+extern int dm_usb_gadget_handle_interrupts(struct udevice *);
 
 /**
  * udc_device_get_by_index() - Get UDC udevice by index
-- 
2.40.1

