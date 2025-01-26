Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EADC0218D
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 13:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5267C80F80;
	Sun, 26 Jan 2025 14:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="gg47Cukh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1E6180F56; Sun, 26 Jan 2025 09:31:05 +0100 (CET)
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com
 [136.143.188.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BBDD80EF4
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 09:31:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1737880255; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fw/Mizzs13VfLMw3RwhSyLvODZF3C9fQdZ6YPUM8/wusaWZUOxvTnnJo8Yw1X1liR4Nyhh8jXFAAOZZMu0goSDXsTU6xFnogmfBb9X+QvXcwg8hkHiu0h7JcWdWV+UWVzAB/WvzFSGqr8SFvjV+tgoq2wE1R80+EMvjUiEHH6QQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1737880255;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=v8O8eZqczQRrKl2+W6ldZQIcwr6hpblhUU/j/9JUISw=; 
 b=XTyMzOr9TPyCWBEjUrqAHBIm3bFLy9R0pTl/9/TKb6cDwOb6peFKEGKT3lpgieJ/UCEsjexTda0Q3TtURZaVE4WE16mrE+z/K2mke3l/IJ63qxZifQcnItqEA8quneIy67zfFZh5O6cXwE6q+Ueut/xb1ycI6zJBsRpWJ4LbB+0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737880255; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=v8O8eZqczQRrKl2+W6ldZQIcwr6hpblhUU/j/9JUISw=;
 b=gg47CukhiQsgFnaAZ+gAVaiqadgT3UESnoGLx98vXBvEkeRusnDia4dyDNpJss/q
 Yup6cfl5ETRy5UJ26npDBfDrjdMKDm1pjY7F652cRxlAM3xC+Vx3Ckc/AIvF3wkG/xA
 E5/pOdTGZbsBc0COr9ThnOzT7vDN5pcE1hRkPDQ4=
Received: by mx.zohomail.com with SMTPS id 1737880251793647.6973498776409;
 Sun, 26 Jan 2025 00:30:51 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Sun, 26 Jan 2025 00:29:59 -0800
Subject: [PATCH] usb: dwc2: Refactor register operations with clrsetbits macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250126-dwc2-clrsetbits-refactor-v1-1-68c27e1b6f84@pigmoral.tech>
X-B4-Tracking: v=1; b=H4sIAIbylWcC/yWN2wqDMBBEf0X2uVtiqlZFSv+j+BCTjQa8NUltQ
 fz3BvN4Zpg5OziyhhzUyQ6WNuPMMgdILwnIQcw9oVGBgTOes5TnqL6SoxytI98Z79CSFtIvFik
 rc9VVN8WrAsJ8DY35ndevNrKl9ycYfAxhIufEaaiTJgpSFgWKNtwyZFiVd51pVeiy48/V9NNix
 Xj1JIcHtMfxB+/H+E3AAAAA
X-Change-ID: 20250125-dwc2-clrsetbits-refactor-e485db93d296
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737880246; l=13592;
 i=junhui.liu@pigmoral.tech; s=20241030; h=from:subject:message-id;
 bh=V59zANsizlXDcym+kjTLK7lSifPPN3FVj7mnOnS+6Hg=;
 b=H1LXNIsWslGBeb5MsvFGYKj23uYG34f08GyWtOVm5lyHcMnbcyxuVd0VA/e1VioIB4YlSo5oF
 BPlTHJnaMBlAi9a35KKdSoFzmlrAPn6qHXYI6j9VFdrX59vFtIV7M49
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=ApYwI6KD3EjynMw61RqGa6c5BGbStQnKSrbNN+aQqT4=
X-ZohoMailClient: External
X-Mailman-Approved-At: Sun, 26 Jan 2025 14:09:21 +0100
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

Refactor DWC2 USB gadget driver to replace manual read-modify-write
operations with `clrsetbits_le32`, `setbits_le32`, and `clrbits_le32`
macros, which simplify the code and improve readability.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
This patch is a supplement of patch series [1].

[1] https://lore.kernel.org/u-boot/20250110-dwc2-dev-v4-0-987f4fd6f8b2@pigmoral.tech
---
 drivers/usb/gadget/dwc2_udc_otg.c          | 16 ++------
 drivers/usb/gadget/dwc2_udc_otg_phy.c      | 33 ++++++----------
 drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c | 63 +++++++-----------------------
 3 files changed, 31 insertions(+), 81 deletions(-)

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index c3fdc81e9096bb216b63ff0ac672d216bed3f23d..40393141ca95b8947712a8996727391fe8742275 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -465,7 +465,6 @@ static void reconfig_usbd(struct dwc2_udc *dev)
 {
 	/* 2. Soft-reset OTG Core and then unreset again. */
 	int i;
-	unsigned int uTemp;
 	u32 dflt_gusbcfg;
 	u32 rx_fifo_sz, tx_fifo_sz, np_tx_fifo_sz;
 	u32 max_hw_ep;
@@ -497,16 +496,12 @@ static void reconfig_usbd(struct dwc2_udc *dev)
 	writel(dflt_gusbcfg, &reg->global_regs.gusbcfg);
 
 	/* 3. Put the OTG device core in the disconnected state.*/
-	uTemp = readl(&reg->device_regs.dctl);
-	uTemp |= DCTL_SFTDISCON;
-	writel(uTemp, &reg->device_regs.dctl);
+	setbits_le32(&reg->device_regs.dctl, DCTL_SFTDISCON);
 
 	udelay(20);
 
 	/* 4. Make the OTG device core exit from the disconnected state.*/
-	uTemp = readl(&reg->device_regs.dctl);
-	uTemp = uTemp & ~DCTL_SFTDISCON;
-	writel(uTemp, &reg->device_regs.dctl);
+	clrbits_le32(&reg->device_regs.dctl, DCTL_SFTDISCON);
 
 	/* 5. Configure OTG Core to initial settings of device mode.*/
 	/* [][1: full speed(30Mhz) 0:high speed]*/
@@ -592,7 +587,6 @@ static void reconfig_usbd(struct dwc2_udc *dev)
 
 static void set_max_pktsize(struct dwc2_udc *dev, enum usb_device_speed speed)
 {
-	unsigned int ep_ctrl;
 	int i;
 
 	if (speed == USB_SPEED_HIGH) {
@@ -612,12 +606,10 @@ static void set_max_pktsize(struct dwc2_udc *dev, enum usb_device_speed speed)
 		dev->ep[i].ep.maxpacket = ep_fifo_size;
 
 	/* EP0 - Control IN (64 bytes)*/
-	ep_ctrl = readl(&reg->device_regs.in_endp[EP0_CON].diepctl);
-	writel(ep_ctrl | (0 << 0), &reg->device_regs.in_endp[EP0_CON].diepctl);
+	setbits_le32(&reg->device_regs.in_endp[EP0_CON].diepctl, (0 << 0));
 
 	/* EP0 - Control OUT (64 bytes)*/
-	ep_ctrl = readl(&reg->device_regs.out_endp[EP0_CON].doepctl);
-	writel(ep_ctrl | (0 << 0), &reg->device_regs.out_endp[EP0_CON].doepctl);
+	setbits_le32(&reg->device_regs.out_endp[EP0_CON].doepctl, (0 << 0));
 }
 
 static int dwc2_ep_enable(struct usb_ep *_ep,
diff --git a/drivers/usb/gadget/dwc2_udc_otg_phy.c b/drivers/usb/gadget/dwc2_udc_otg_phy.c
index c7eea7b34421ad9bde86d42334852d2f21a133e8..e0ac5d142b0610461408754a59bfd2aa09848407 100644
--- a/drivers/usb/gadget/dwc2_udc_otg_phy.c
+++ b/drivers/usb/gadget/dwc2_udc_otg_phy.c
@@ -48,29 +48,24 @@ void otg_phy_init(struct dwc2_udc *dev)
 	printf("USB PHY0 Enable\n");
 
 	/* Enable PHY */
-	writel(readl(usb_phy_ctrl) | USB_PHY_CTRL_EN0, usb_phy_ctrl);
+	setbits_le32(usb_phy_ctrl, USB_PHY_CTRL_EN0);
 
 	if (dev->pdata->usb_flags == PHY0_SLEEP) /* C210 Universal */
-		writel((readl(&phy->phypwr)
-			&~(PHY_0_SLEEP | OTG_DISABLE_0 | ANALOG_PWRDOWN)
-			&~FORCE_SUSPEND_0), &phy->phypwr);
+		clrbits_le32(&phy->phypwr, PHY_0_SLEEP | OTG_DISABLE_0 |
+					   ANALOG_PWRDOWN | FORCE_SUSPEND_0);
 	else /* C110 GONI */
-		writel((readl(&phy->phypwr) &~(OTG_DISABLE_0 | ANALOG_PWRDOWN)
-			&~FORCE_SUSPEND_0), &phy->phypwr);
+		clrbits_le32(&phy->phypwr, OTG_DISABLE_0 | ANALOG_PWRDOWN | FORCE_SUSPEND_0);
 
 	if (s5p_cpu_id == 0x4412)
-		writel((readl(&phy->phyclk) & ~(EXYNOS4X12_ID_PULLUP0 |
-			EXYNOS4X12_COMMON_ON_N0)) | EXYNOS4X12_CLK_SEL_24MHZ,
-		       &phy->phyclk); /* PLL 24Mhz */
+		clrsetbits_le32(&phy->phyclk, EXYNOS4X12_ID_PULLUP0 | EXYNOS4X12_COMMON_ON_N0,
+				EXYNOS4X12_CLK_SEL_24MHZ); /* PLL 24Mhz */
 	else
-		writel((readl(&phy->phyclk) & ~(ID_PULLUP0 | COMMON_ON_N0)) |
-		       CLK_SEL_24MHZ, &phy->phyclk); /* PLL 24Mhz */
+		clrsetbits_le32(&phy->phyclk, ID_PULLUP0 | COMMON_ON_N0,
+				CLK_SEL_24MHZ); /* PLL 24Mhz */
 
-	writel((readl(&phy->rstcon) &~(LINK_SW_RST | PHYLNK_SW_RST))
-	       | PHY_SW_RST0, &phy->rstcon);
+	clrsetbits_le32(&phy->rstcon, LINK_SW_RST | PHYLNK_SW_RST, PHY_SW_RST0);
 	udelay(10);
-	writel(readl(&phy->rstcon)
-	       &~(PHY_SW_RST0 | LINK_SW_RST | PHYLNK_SW_RST), &phy->rstcon);
+	clrbits_le32(&phy->rstcon, PHY_SW_RST0 | LINK_SW_RST | PHYLNK_SW_RST);
 	udelay(10);
 }
 
@@ -86,13 +81,11 @@ void otg_phy_off(struct dwc2_udc *dev)
 	writel(readl(&phy->phypwr) &~PHY_SW_RST0, &phy->rstcon);
 	udelay(20);
 
-	writel(readl(&phy->phypwr) | OTG_DISABLE_0 | ANALOG_PWRDOWN
-	       | FORCE_SUSPEND_0, &phy->phypwr);
+	setbits_le32(&phy->phypwr, OTG_DISABLE_0 | ANALOG_PWRDOWN | FORCE_SUSPEND_0);
 
-	writel(readl(usb_phy_ctrl) &~USB_PHY_CTRL_EN0, usb_phy_ctrl);
+	clrbits_le32(usb_phy_ctrl, USB_PHY_CTRL_EN0);
 
-	writel((readl(&phy->phyclk) & ~(ID_PULLUP0 | COMMON_ON_N0)),
-	      &phy->phyclk);
+	clrbits_le32(&phy->phyclk, ID_PULLUP0 | COMMON_ON_N0);
 
 	udelay(10000);
 
diff --git a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
index 2be93592c423df7a9acea473b0e84e1f948999be..fca052b4556a7d2ae4fe516e39820611d7082e2f 100644
--- a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
+++ b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
@@ -31,15 +31,11 @@ int clear_feature_flag;
 
 static inline void dwc2_udc_ep0_zlp(struct dwc2_udc *dev)
 {
-	u32 ep_ctrl;
-
 	writel(phys_to_bus((unsigned long)usb_ctrl_dma_addr),
 	       &reg->device_regs.in_endp[EP0_CON].diepdma);
 	writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, 1), &reg->device_regs.in_endp[EP0_CON].dieptsiz);
 
-	ep_ctrl = readl(&reg->device_regs.in_endp[EP0_CON].diepctl);
-	writel(ep_ctrl | DXEPCTL_EPENA | DXEPCTL_CNAK,
-	       &reg->device_regs.in_endp[EP0_CON].diepctl);
+	setbits_le32(&reg->device_regs.in_endp[EP0_CON].diepctl, DXEPCTL_EPENA | DXEPCTL_CNAK);
 
 	debug_cond(DEBUG_EP0 != 0, "%s:EP0 ZLP DIEPCTL0 = 0x%x\n",
 		__func__, readl(&reg->device_regs.in_endp[EP0_CON].diepctl));
@@ -48,8 +44,6 @@ static inline void dwc2_udc_ep0_zlp(struct dwc2_udc *dev)
 
 static void dwc2_udc_pre_setup(void)
 {
-	u32 ep_ctrl;
-
 	debug_cond(DEBUG_IN_EP,
 		   "%s : Prepare Setup packets.\n", __func__);
 
@@ -58,20 +52,16 @@ static void dwc2_udc_pre_setup(void)
 	writel(phys_to_bus((unsigned long)usb_ctrl_dma_addr),
 	       &reg->device_regs.out_endp[EP0_CON].doepdma);
 
-	ep_ctrl = readl(&reg->device_regs.out_endp[EP0_CON].doepctl);
-	writel(ep_ctrl | DXEPCTL_EPENA, &reg->device_regs.out_endp[EP0_CON].doepctl);
+	setbits_le32(&reg->device_regs.out_endp[EP0_CON].doepctl, DXEPCTL_EPENA);
 
 	debug_cond(DEBUG_EP0 != 0, "%s:EP0 ZLP DIEPCTL0 = 0x%x\n",
 		__func__, readl(&reg->device_regs.in_endp[EP0_CON].diepctl));
 	debug_cond(DEBUG_EP0 != 0, "%s:EP0 ZLP DOEPCTL0 = 0x%x\n",
 		__func__, readl(&reg->device_regs.out_endp[EP0_CON].doepctl));
-
 }
 
 static inline void dwc2_ep0_complete_out(void)
 {
-	u32 ep_ctrl;
-
 	debug_cond(DEBUG_EP0 != 0, "%s:EP0 ZLP DIEPCTL0 = 0x%x\n",
 		__func__, readl(&reg->device_regs.in_endp[EP0_CON].diepctl));
 	debug_cond(DEBUG_EP0 != 0, "%s:EP0 ZLP DOEPCTL0 = 0x%x\n",
@@ -85,15 +75,12 @@ static inline void dwc2_ep0_complete_out(void)
 	writel(phys_to_bus((unsigned long)usb_ctrl_dma_addr),
 	       &reg->device_regs.out_endp[EP0_CON].doepdma);
 
-	ep_ctrl = readl(&reg->device_regs.out_endp[EP0_CON].doepctl);
-	writel(ep_ctrl | DXEPCTL_EPENA | DXEPCTL_CNAK,
-	       &reg->device_regs.out_endp[EP0_CON].doepctl);
+	setbits_le32(&reg->device_regs.out_endp[EP0_CON].doepctl, DXEPCTL_EPENA | DXEPCTL_CNAK);
 
 	debug_cond(DEBUG_EP0 != 0, "%s:EP0 ZLP DIEPCTL0 = 0x%x\n",
 		__func__, readl(&reg->device_regs.in_endp[EP0_CON].diepctl));
 	debug_cond(DEBUG_EP0 != 0, "%s:EP0 ZLP DOEPCTL0 = 0x%x\n",
 		__func__, readl(&reg->device_regs.out_endp[EP0_CON].doepctl));
-
 }
 
 static int setdma_rx(struct dwc2_ep *ep, struct dwc2_request *req)
@@ -136,12 +123,11 @@ static int setdma_rx(struct dwc2_ep *ep, struct dwc2_request *req)
 		   readl(&reg->device_regs.out_endp[ep_num].doepctl),
 		   buf, pktcnt, length);
 	return 0;
-
 }
 
 static int setdma_tx(struct dwc2_ep *ep, struct dwc2_request *req)
 {
-	u32 *buf, ctrl = 0;
+	u32 *buf;
 	u32 length, pktcnt;
 	u32 ep_num = ep_index(ep);
 
@@ -171,16 +157,10 @@ static int setdma_tx(struct dwc2_ep *ep, struct dwc2_request *req)
 	       FIELD_PREP(DXEPTSIZ_XFERSIZE_MASK, length),
 	       &reg->device_regs.in_endp[ep_num].dieptsiz);
 
-	ctrl = readl(&reg->device_regs.in_endp[ep_num].diepctl);
-
-	/* Write the FIFO number to be used for this endpoint */
-	ctrl &= ~DXEPCTL_TXFNUM_MASK;
-	ctrl |= FIELD_PREP(DXEPCTL_TXFNUM_MASK, ep->fifo_num);
-
-	/* Clear reserved (Next EP) bits */
-	ctrl &= ~DXEPCTL_NEXTEP_MASK;
-
-	writel(DXEPCTL_EPENA | DXEPCTL_CNAK | ctrl, &reg->device_regs.in_endp[ep_num].diepctl);
+	clrsetbits_le32(&reg->device_regs.in_endp[ep_num].diepctl,
+			DXEPCTL_TXFNUM_MASK | DXEPCTL_NEXTEP_MASK,
+			FIELD_PREP(DXEPCTL_TXFNUM_MASK, ep->fifo_num) |
+			DXEPCTL_EPENA | DXEPCTL_CNAK);
 
 	debug_cond(DEBUG_IN_EP,
 		"%s:EP%d TX DMA start : DIEPDMA0 = 0x%x,"
@@ -766,9 +746,7 @@ static int dwc2_fifo_read(struct dwc2_ep *ep, void *cp, int max)
  */
 static void udc_set_address(struct dwc2_udc *dev, unsigned char address)
 {
-	u32 ctrl = readl(&reg->device_regs.dcfg);
-
-	writel(FIELD_PREP(DCFG_DEVADDR_MASK, address) | ctrl, &reg->device_regs.dcfg);
+	setbits_le32(&reg->device_regs.dcfg, FIELD_PREP(DCFG_DEVADDR_MASK, address));
 
 	dwc2_udc_ep0_zlp(dev);
 
@@ -892,7 +870,6 @@ static int dwc2_udc_get_status(struct dwc2_udc *dev,
 {
 	u8 ep_num = crq->wIndex & 0x3;
 	u16 g_status = 0;
-	u32 ep_ctrl;
 
 	debug_cond(DEBUG_SETUP != 0,
 		   "%s: *** USB_REQ_GET_STATUS\n", __func__);
@@ -940,9 +917,7 @@ static int dwc2_udc_get_status(struct dwc2_udc *dev,
 	writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, 1) | FIELD_PREP(DXEPTSIZ_XFERSIZE_MASK, 2),
 	       &reg->device_regs.in_endp[EP0_CON].dieptsiz);
 
-	ep_ctrl = readl(&reg->device_regs.in_endp[EP0_CON].diepctl);
-	writel(ep_ctrl | DXEPCTL_EPENA | DXEPCTL_CNAK,
-	       &reg->device_regs.in_endp[EP0_CON].diepctl);
+	setbits_le32(&reg->device_regs.in_endp[EP0_CON].diepctl, DXEPCTL_EPENA | DXEPCTL_CNAK);
 	dev->ep0state = WAIT_FOR_NULL_COMPLETE;
 
 	return 0;
@@ -951,21 +926,16 @@ static int dwc2_udc_get_status(struct dwc2_udc *dev,
 static void dwc2_udc_set_nak(struct dwc2_ep *ep)
 {
 	u8		ep_num;
-	u32		ep_ctrl = 0;
 
 	ep_num = ep_index(ep);
 	debug("%s: ep_num = %d, ep_type = %d\n", __func__, ep_num, ep->ep_type);
 
 	if (ep_is_in(ep)) {
-		ep_ctrl = readl(&reg->device_regs.in_endp[ep_num].diepctl);
-		ep_ctrl |= DXEPCTL_SNAK;
-		writel(ep_ctrl, &reg->device_regs.in_endp[ep_num].diepctl);
+		setbits_le32(&reg->device_regs.in_endp[ep_num].diepctl, DXEPCTL_SNAK);
 		debug("%s: set NAK, DIEPCTL%d = 0x%x\n",
 			__func__, ep_num, readl(&reg->device_regs.in_endp[ep_num].diepctl));
 	} else {
-		ep_ctrl = readl(&reg->device_regs.out_endp[ep_num].doepctl);
-		ep_ctrl |= DXEPCTL_SNAK;
-		writel(ep_ctrl, &reg->device_regs.out_endp[ep_num].doepctl);
+		setbits_le32(&reg->device_regs.out_endp[ep_num].doepctl, DXEPCTL_SNAK);
 		debug("%s: set NAK, DOEPCTL%d = 0x%x\n",
 		      __func__, ep_num, readl(&reg->device_regs.out_endp[ep_num].doepctl));
 	}
@@ -995,12 +965,8 @@ static void dwc2_udc_ep_set_stall(struct dwc2_ep *ep)
 		      __func__, ep_num, readl(&reg->device_regs.in_endp[ep_num].diepctl));
 
 	} else {
-		ep_ctrl = readl(&reg->device_regs.out_endp[ep_num].doepctl);
-
 		/* set the stall bit */
-		ep_ctrl |= DXEPCTL_STALL;
-
-		writel(ep_ctrl, &reg->device_regs.out_endp[ep_num].doepctl);
+		setbits_le32(&reg->device_regs.out_endp[ep_num].doepctl, DXEPCTL_STALL);
 		debug("%s: set stall, DOEPCTL%d = 0x%x\n",
 		      __func__, ep_num, readl(&reg->device_regs.out_endp[ep_num].doepctl));
 	}
@@ -1145,9 +1111,8 @@ static void dwc2_udc_ep_activate(struct dwc2_ep *ep)
 	}
 
 	/* Unmask EP Interrtupt */
-	writel(readl(&reg->device_regs.daintmsk) | daintmsk, &reg->device_regs.daintmsk);
+	setbits_le32(&reg->device_regs.daintmsk, daintmsk);
 	debug("%s: DAINTMSK = 0x%x\n", __func__, readl(&reg->device_regs.daintmsk));
-
 }
 
 static int dwc2_udc_clear_feature(struct usb_ep *_ep)

---
base-commit: 05051cfdf0ed6258a945ec181e36d14b7e450dbf
change-id: 20250125-dwc2-clrsetbits-refactor-e485db93d296
prerequisite-message-id: <20250110-dwc2-dev-v4-0-987f4fd6f8b2@pigmoral.tech>
prerequisite-patch-id: f05fe7f02791b8f5f6e89e3768584622c49e2ed7
prerequisite-patch-id: ba89fc49fb08beb94bc5c69c4b82e198a27c334d
prerequisite-patch-id: bc3632796d0010d5711be9597c4222c23adbf9f7
prerequisite-patch-id: b30e9c649999f42bc5c659bde5650e8aa2a33acd
prerequisite-patch-id: d6623dbacae347c4c7e339a294c60402667a359b
prerequisite-patch-id: 64e64d31939ea7f69818883fbafb8c1906b53ecb
prerequisite-patch-id: 9de6c80cd2996924b8f94a33f3e2a3dd63f1f57b
prerequisite-patch-id: e1752a8f249752de133bda41a387b3d147d60453

Best regards,
-- 
Junhui Liu <junhui.liu@pigmoral.tech>

