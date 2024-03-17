Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26674C54E67
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 04:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F80F87BF1;
	Sun, 17 Mar 2024 05:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="B/gpQ2D6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wwsbK9yE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2122087BEE; Sun, 17 Mar 2024 05:44:29 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C47387B30
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 05:44:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Ty54B17mnz9sQv;
 Sun, 17 Mar 2024 05:44:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710650666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Bs6PF1B/FVsNOJwJKfEk8azH9bqO/yfFrKOuljHVguQ=;
 b=B/gpQ2D6m5S7mJwXBW7DOzQu4CCVcwNVZd/rm4+ayVaLi6Ehez28HHIUdl4SlRW5rHng83
 zCadUCn4FNqM6pNgfO3r5SxapJkmC0ToLiE8fXb1QerI1ElVcJw0/4IH+1N+opx+D9mLvO
 2mNkPqjLwMYmWVkZSFJR5c+cyp+vnLNArIaNMGmaBddJwjo7KTifidCDbAUHwpE6+DEOlO
 MeYGFuRerH2YZaPAi81FiMzbIf7oD6xR9+4ffHC3zDG2Ga2kzrbVf9a3hUtwQOwX5CHOgu
 McD1YcLwjTX3JFifFBohYj25/Cscxh8DkKWZfIWxolJ8rLvYgLFfg6xZNgjyAA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710650664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Bs6PF1B/FVsNOJwJKfEk8azH9bqO/yfFrKOuljHVguQ=;
 b=wwsbK9yEeTbz+NOb3XGOWMYDHaFiKLt7WRrhVcmgsqni9wsP1e3Xf9kRdlHd1S1IH5rMIQ
 X+k36RDk1nE0UleMzfFMBR4NxYALe8zkWVeYAaSiq0RXLO/7wJ79Vq0k4l0MQscm6rGy7l
 bJkx9IhLdV7hJzgHrctSTTWJh8fVhFwqFyp7O1HD1Vn2P3MGpCS0X00YEL+iXYi8lD6Rl7
 YfHE/UYxegzPLofldYx5xAa9yqeUXoCnxh9+sh60qA+ClGgxHEeEkChKs3Ib4ucbbgc162
 PpaqHUIK4ZYI1LoYjt//k8WEdr5/VvIl1z5x7fyMX+9nqDdNMrjOKUbwXuoXvg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Angus Ainslie <angus@akkea.ca>, Caleb Connolly <caleb.connolly@linaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Stefan Bosch <stefan_b@posteo.net>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 kernel@puri.sm
Subject: [PATCH 1/2] usb: udc: dwc3: Fold board
 dm_usb_gadget_handle_interrupts() into DWC3 gadget
Date: Sun, 17 Mar 2024 05:42:52 +0100
Message-ID: <20240317044357.547037-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: minnr3rohxt8gb6hmeg6ku5owop5bpjw
X-MBO-RS-ID: d39af8218abece3d1c5
X-Rspamd-Queue-Id: 4Ty54B17mnz9sQv
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

The dm_usb_gadget_handle_interrupts() has no place in board code. Move
this into DWC3 driver. The OMAP implementation is special, add new weak
dwc3_uboot_interrupt_status() function to decide whether DWC3 interrupt
handling should be called, and override it in OMAP DWC3 code, to repair
the special OMAP interrupt handling code until OMAP gets switched over
to DM UDC proper.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Angus Ainslie <angus@akkea.ca>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Igor Prusov <ivprusov@salutedevices.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Bosch <stefan_b@posteo.net>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: kernel@puri.sm
---
 board/purism/librem5/spl.c        |  6 ------
 board/samsung/common/exynos5-dt.c |  6 ------
 board/st/stih410-b2260/board.c    |  6 ------
 board/ti/am43xx/board.c           | 11 -----------
 drivers/usb/dwc3/core.c           | 25 +++++++++++++++++++++----
 drivers/usb/dwc3/dwc3-omap.c      |  4 ++--
 include/dwc3-omap-uboot.h         |  1 -
 include/dwc3-uboot.h              |  1 +
 8 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/board/purism/librem5/spl.c b/board/purism/librem5/spl.c
index 581f0929662..9aadc553302 100644
--- a/board/purism/librem5/spl.c
+++ b/board/purism/librem5/spl.c
@@ -418,12 +418,6 @@ out:
 	return rv;
 }
 
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
-{
-	dwc3_uboot_handle_interrupt(dev);
-	return 0;
-}
-
 static void dwc3_nxp_usb_phy_init(struct dwc3_device *dwc3)
 {
 	u32 RegData;
diff --git a/board/samsung/common/exynos5-dt.c b/board/samsung/common/exynos5-dt.c
index 95cf6d2acc2..b3e87c93751 100644
--- a/board/samsung/common/exynos5-dt.c
+++ b/board/samsung/common/exynos5-dt.c
@@ -122,12 +122,6 @@ static struct dwc3_device dwc3_device_data = {
 	.index = 0,
 };
 
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
-{
-	dwc3_uboot_handle_interrupt(dev);
-	return 0;
-}
-
 int board_usb_init(int index, enum usb_init_type init)
 {
 	struct exynos_usb3_phy *phy = (struct exynos_usb3_phy *)
diff --git a/board/st/stih410-b2260/board.c b/board/st/stih410-b2260/board.c
index e21cbc270e9..82817571ae3 100644
--- a/board/st/stih410-b2260/board.c
+++ b/board/st/stih410-b2260/board.c
@@ -50,12 +50,6 @@ static struct dwc3_device dwc3_device_data = {
 	.index = 0,
 };
 
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
-{
-	dwc3_uboot_handle_interrupt(dev);
-	return 0;
-}
-
 int board_usb_init(int index, enum usb_init_type init)
 {
 	int node;
diff --git a/board/ti/am43xx/board.c b/board/ti/am43xx/board.c
index ea0d0b92088..a4679a2e294 100644
--- a/board/ti/am43xx/board.c
+++ b/board/ti/am43xx/board.c
@@ -759,17 +759,6 @@ static struct ti_usb_phy_device usb_phy2_device = {
 	.usb2_phy_power = (void *)USB2_PHY2_POWER,
 	.index = 1,
 };
-
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
-{
-	u32 status;
-
-	status = dwc3_omap_uboot_interrupt_status(dev);
-	if (status)
-		dwc3_uboot_handle_interrupt(dev);
-
-	return 0;
-}
 #endif /* CONFIG_USB_DWC3 */
 
 #if defined(CONFIG_USB_DWC3) || defined(CONFIG_USB_XHCI_OMAP)
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 4b4fcd8a22e..09737be9a9c 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -983,6 +983,11 @@ void dwc3_uboot_exit(int index)
 	}
 }
 
+MODULE_ALIAS("platform:dwc3");
+MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
+
 /**
  * dwc3_uboot_handle_interrupt - handle dwc3 core interrupt
  * @dev: device of this controller
@@ -1004,10 +1009,22 @@ void dwc3_uboot_handle_interrupt(struct udevice *dev)
 	}
 }
 
-MODULE_ALIAS("platform:dwc3");
-MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
+#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
+__weak int dwc3_uboot_interrupt_status(struct udevice *dev)
+{
+	return 1;
+}
+
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+{
+	if (!dwc3_uboot_interrupt_status(dev))
+		return 0;
+
+	dwc3_uboot_handle_interrupt(dev);
+
+	return 0;
+}
+#endif
 
 #if CONFIG_IS_ENABLED(PHY) && CONFIG_IS_ENABLED(DM_USB)
 int dwc3_setup_phy(struct udevice *dev, struct phy_bulk *phys)
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 4fadb4a3e20..53c4d4826b4 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -428,7 +428,7 @@ void dwc3_omap_uboot_exit(int index)
 }
 
 /**
- * dwc3_omap_uboot_interrupt_status - check the status of interrupt
+ * dwc3_uboot_interrupt_status - check the status of interrupt
  * @dev: device of this controller
  *
  * Checks the status of interrupts and returns true if an interrupt
@@ -436,7 +436,7 @@ void dwc3_omap_uboot_exit(int index)
  *
  * Generally called from board file.
  */
-int dwc3_omap_uboot_interrupt_status(struct udevice *dev)
+int dwc3_uboot_interrupt_status(struct udevice *dev)
 {
 	struct dwc3_omap *omap = NULL;
 
diff --git a/include/dwc3-omap-uboot.h b/include/dwc3-omap-uboot.h
index ed92bfc5a97..f220705ef7b 100644
--- a/include/dwc3-omap-uboot.h
+++ b/include/dwc3-omap-uboot.h
@@ -27,5 +27,4 @@ struct dwc3_omap_device {
 
 int dwc3_omap_uboot_init(struct dwc3_omap_device *dev);
 void dwc3_omap_uboot_exit(int index);
-int dwc3_omap_uboot_interrupt_status(struct udevice *dev);
 #endif /* __DWC3_OMAP_UBOOT_H_ */
diff --git a/include/dwc3-uboot.h b/include/dwc3-uboot.h
index 35cfbb93b29..5f13f5bcf40 100644
--- a/include/dwc3-uboot.h
+++ b/include/dwc3-uboot.h
@@ -44,6 +44,7 @@ struct dwc3_device {
 
 int dwc3_uboot_init(struct dwc3_device *dev);
 void dwc3_uboot_exit(int index);
+int dwc3_uboot_interrupt_status(struct udevice *dev);
 void dwc3_uboot_handle_interrupt(struct udevice *dev);
 
 struct phy;
-- 
2.43.0

