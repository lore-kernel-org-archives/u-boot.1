Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0367E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 16:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0628C80702;
	Fri, 10 Jan 2025 17:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="TAERF0EN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8383D8036B; Fri, 10 Jan 2025 14:57:42 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDA49800D0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 14:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1736517455; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KRgd6E6eCp3A0Jkm9KmNE6y95/wigCOql6Mchq8Jt4L92duHJz6WHEaqfg3xB4iTHJ7uwARfmHSg7Ks1VBquwrMo+qEGqlpLspCXv12NzpPJsf3bPqR+wpJR/bIHFaVB4dQl0b7AS2EvFU+hsRkprQBJLwcqGsSP2yMLSgVT+cc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1736517455;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=WF2q2bNBu6S7hBAxvPl2Gzie053gP0B8HlyjaX16ixw=; 
 b=kq8QphzexYDjiw5qu20bXQ2yD1Vg8dy+5409T+Tm4TtknKn0YkBQSeHnAjUC18C4zFwkyLhw9mCMv28l6H0XFPjUmJk9jPgSKNCRWrJfN+7mH+gTdDOsPF39c84B25JQnLWVQt6dW0UhlbVOQ3tfViE4Llwlh6aD/5u13aqj1M0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736517455; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=WF2q2bNBu6S7hBAxvPl2Gzie053gP0B8HlyjaX16ixw=;
 b=TAERF0ENTeI6st0hGLAIrPfYP5FOSUOd2MiOI8z5WOch7qbekXe33Xnz1SHOZonw
 w8GtZFrdVBsgkkGqzhpw1UbTd+Thp4kUGcQC/5jHXq+VJyYDJ3NZq99UNrdUFHbapjg
 4+f+rjPV4twZEkkEMACxWN2pAOlPtFQoVU9GI9Wo=
Received: by mx.zohomail.com with SMTPS id 1736517453754483.8193132308568;
 Fri, 10 Jan 2025 05:57:33 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Fri, 10 Jan 2025 21:55:27 +0800
Subject: [PATCH v4 8/8] usb: dwc2: Replace uint<x>_t types with u<x>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-dwc2-dev-v4-8-987f4fd6f8b2@pigmoral.tech>
References: <20250110-dwc2-dev-v4-0-987f4fd6f8b2@pigmoral.tech>
In-Reply-To: <20250110-dwc2-dev-v4-0-987f4fd6f8b2@pigmoral.tech>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, seashell11234455@gmail.com, pbrobinson@gmail.com, 
 junhui.liu@pigmoral.tech
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736517374; l=10630;
 i=junhui.liu@pigmoral.tech; s=20250109; h=from:subject:message-id;
 bh=lLg8Ujj6CpKn/kqhhRal6AGlR8dOD3RTP+F+KjIPUtI=;
 b=IDOsg3hjMXFYEe6fAO3Et/d2iCB5TyKbBW6jlnAcYydSb7e8u0kzgn3GESOJXBbtAzg5Z1TXX
 +vv7y3a8BzaAY+IRLZ8FndNfLOSYb8CZuwgecqhoooTaQOF5IfyG6hk
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=68KnSr7PNU3x0/qPdqkmlkr3EChzKC0ewuARfy9ZNnc=
X-ZohoMailClient: External
X-Mailman-Approved-At: Fri, 10 Jan 2025 17:13:21 +0100
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

From: Kongyang Liu <seashell11234455@gmail.com>

Updates all instances of uint8_t, uint16_t, and uint32_t to u8, u16, and
u32 respectively, ensuring consistent use of kernel-preferred types and
resolving checkpatch.pl warnings.

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Tested-by: Peter Robinson <pbrobinson@gmail.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/usb/gadget/dwc2_udc_otg.c |   4 +-
 drivers/usb/host/dwc2.c           | 100 +++++++++++++++++++-------------------
 2 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 084e9824faac03d47e23e0d52e81a9d12308e06a..c3fdc81e9096bb216b63ff0ac672d216bed3f23d 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -466,8 +466,8 @@ static void reconfig_usbd(struct dwc2_udc *dev)
 	/* 2. Soft-reset OTG Core and then unreset again. */
 	int i;
 	unsigned int uTemp;
-	uint32_t dflt_gusbcfg;
-	uint32_t rx_fifo_sz, tx_fifo_sz, np_tx_fifo_sz;
+	u32 dflt_gusbcfg;
+	u32 rx_fifo_sz, tx_fifo_sz, np_tx_fifo_sz;
 	u32 max_hw_ep;
 	int pdata_hw_ep;
 
diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
index b27429235798ce223bb8a11999e3d520c26ef377..16f21fa9083a71da1c8dd62d174712962d0227b1 100644
--- a/drivers/usb/host/dwc2.c
+++ b/drivers/usb/host/dwc2.c
@@ -39,16 +39,16 @@
 
 struct dwc2_priv {
 #if CONFIG_IS_ENABLED(DM_USB)
-	uint8_t aligned_buffer[DWC2_DATA_BUF_SIZE] __aligned(ARCH_DMA_MINALIGN);
-	uint8_t status_buffer[DWC2_STATUS_BUF_SIZE] __aligned(ARCH_DMA_MINALIGN);
+	u8 aligned_buffer[DWC2_DATA_BUF_SIZE] __aligned(ARCH_DMA_MINALIGN);
+	u8 status_buffer[DWC2_STATUS_BUF_SIZE] __aligned(ARCH_DMA_MINALIGN);
 #ifdef CONFIG_DM_REGULATOR
 	struct udevice *vbus_supply;
 #endif
 	struct phy phy;
 	struct clk_bulk clks;
 #else
-	uint8_t *aligned_buffer;
-	uint8_t *status_buffer;
+	u8 *aligned_buffer;
+	u8 *status_buffer;
 #endif
 	u8 in_data_toggle[MAX_DEVICE][MAX_ENDPOINT];
 	u8 out_data_toggle[MAX_DEVICE][MAX_ENDPOINT];
@@ -67,10 +67,10 @@ struct dwc2_priv {
 
 #if !CONFIG_IS_ENABLED(DM_USB)
 /* We need cacheline-aligned buffers for DMA transfers and dcache support */
-DEFINE_ALIGN_BUFFER(uint8_t, aligned_buffer_addr, DWC2_DATA_BUF_SIZE,
-		ARCH_DMA_MINALIGN);
-DEFINE_ALIGN_BUFFER(uint8_t, status_buffer_addr, DWC2_STATUS_BUF_SIZE,
-		ARCH_DMA_MINALIGN);
+DEFINE_ALIGN_BUFFER(u8, aligned_buffer_addr, DWC2_DATA_BUF_SIZE,
+		    ARCH_DMA_MINALIGN);
+DEFINE_ALIGN_BUFFER(u8, status_buffer_addr, DWC2_STATUS_BUF_SIZE,
+		    ARCH_DMA_MINALIGN);
 
 static struct dwc2_priv local;
 #endif
@@ -85,7 +85,7 @@ static struct dwc2_priv local;
  */
 static void init_fslspclksel(struct dwc2_core_regs *regs)
 {
-	uint32_t phyclk;
+	u32 phyclk;
 
 #if (DWC2_PHY_TYPE == DWC2_PHY_TYPE_FS)
 	phyclk = HCFG_FSLSPCLKSEL_48_MHZ;	/* Full speed PHY */
@@ -95,9 +95,9 @@ static void init_fslspclksel(struct dwc2_core_regs *regs)
 #endif
 
 #ifdef DWC2_ULPI_FS_LS
-	uint32_t hwcfg2 = readl(&regs->global_regs.ghwcfg2);
-	uint32_t hval = FIELD_GET(GHWCFG2_HS_PHY_TYPE_MASK, ghwcfg2);
-	uint32_t fval = FIELD_GET(GHWCFG2_FS_PHY_TYPE_MASK, ghwcfg2);
+	u32 hwcfg2 = readl(&regs->global_regs.ghwcfg2);
+	u32 hval = FIELD_GET(GHWCFG2_HS_PHY_TYPE_MASK, ghwcfg2);
+	u32 fval = FIELD_GET(GHWCFG2_FS_PHY_TYPE_MASK, ghwcfg2);
 
 	if (hval == GHWCFG2_FS_PHY_TYPE_SHARED_UTMI && fval == GHWCFG2_HS_PHY_TYPE_UTMI)
 		phyclk = HCFG_FSLSPCLKSEL_48_MHZ;	/* Full speed PHY */
@@ -172,9 +172,9 @@ static int dwc_vbus_supply_exit(struct udevice *dev)
 static void dwc_otg_core_host_init(struct udevice *dev,
 				   struct dwc2_core_regs *regs)
 {
-	uint32_t nptxfifosize = 0;
-	uint32_t ptxfifosize = 0;
-	uint32_t hprt0 = 0;
+	u32 nptxfifosize = 0;
+	u32 ptxfifosize = 0;
+	u32 hprt0 = 0;
 	int i, ret, num_channels;
 
 	/* Restart the Phy Clock */
@@ -253,9 +253,9 @@ static void dwc_otg_core_init(struct udevice *dev)
 {
 	struct dwc2_priv *priv = dev_get_priv(dev);
 	struct dwc2_core_regs *regs = priv->regs;
-	uint32_t ahbcfg = 0;
-	uint32_t usbcfg = 0;
-	uint8_t brst_sz = DWC2_DMA_BURST_SIZE;
+	u32 ahbcfg = 0;
+	u32 usbcfg = 0;
+	u8 brst_sz = DWC2_DMA_BURST_SIZE;
 
 	/* Common Initialization */
 	usbcfg = readl(&regs->global_regs.gusbcfg);
@@ -347,9 +347,9 @@ static void dwc_otg_core_init(struct udevice *dev)
 	usbcfg = readl(&regs->global_regs.gusbcfg);
 	usbcfg &= ~(GUSBCFG_ULPI_FS_LS | GUSBCFG_ULPI_CLK_SUSP_M);
 #ifdef DWC2_ULPI_FS_LS
-	uint32_t hwcfg2 = readl(&regs->global_regs.ghwcfg2);
-	uint32_t hval = FIELD_GET(GHWCFG2_HS_PHY_TYPE_MASK, ghwcfg2);
-	uint32_t fval = FIELD_GET(GHWCFG2_FS_PHY_TYPE_MASK, ghwcfg2);
+	u32 hwcfg2 = readl(&regs->global_regs.ghwcfg2);
+	u32 hval = FIELD_GET(GHWCFG2_HS_PHY_TYPE_MASK, ghwcfg2);
+	u32 fval = FIELD_GET(GHWCFG2_FS_PHY_TYPE_MASK, ghwcfg2);
 
 	if (hval == GHWCFG2_FS_PHY_TYPE_SHARED_UTMI && fval == GHWCFG2_HS_PHY_TYPE_UTMI) {
 		usbcfg |= GUSBCFG_ULPI_FS_LS;
@@ -402,9 +402,9 @@ static void dwc_otg_core_init(struct udevice *dev)
  * @param regs Programming view of DWC_otg controller
  * @param hc Information needed to initialize the host channel
  */
-static void dwc_otg_hc_init(struct dwc2_core_regs *regs, uint8_t hc_num,
-		struct usb_device *dev, uint8_t dev_addr, uint8_t ep_num,
-		uint8_t ep_is_in, uint8_t ep_type, uint16_t max_packet)
+static void dwc_otg_hc_init(struct dwc2_core_regs *regs, u8 hc_num,
+			    struct usb_device *dev, u8 dev_addr, u8 ep_num,
+			    u8 ep_is_in, u8 ep_type, u16 max_packet)
 {
 	struct dwc2_hc_regs *hc_regs = &regs->host_regs.hc[hc_num];
 	u32 hcchar = FIELD_PREP(HCCHAR_DEVADDR_MASK, dev_addr) |
@@ -427,9 +427,9 @@ static void dwc_otg_hc_init(struct dwc2_core_regs *regs, uint8_t hc_num,
 }
 
 static void dwc_otg_hc_init_split(struct dwc2_hc_regs *hc_regs,
-				  uint8_t hub_devnum, uint8_t hub_port)
+				  u8 hub_devnum, u8 hub_port)
 {
-	uint32_t hcsplt = 0;
+	u32 hcsplt = 0;
 
 	hcsplt = HCSPLT_SPLTENA;
 	hcsplt |= FIELD_PREP(HCSPLT_HUBADDR_MASK, hub_devnum);
@@ -447,24 +447,24 @@ static int dwc_otg_submit_rh_msg_in_status(struct dwc2_core_regs *regs,
 					   struct usb_device *dev, void *buffer,
 					   int txlen, struct devrequest *cmd)
 {
-	uint32_t hprt0 = 0;
-	uint32_t port_status = 0;
-	uint32_t port_change = 0;
+	u32 hprt0 = 0;
+	u32 port_status = 0;
+	u32 port_change = 0;
 	int len = 0;
 	int stat = 0;
 
 	switch (cmd->requesttype & ~USB_DIR_IN) {
 	case 0:
-		*(uint16_t *)buffer = cpu_to_le16(1);
+		*(u16 *)buffer = cpu_to_le16(1);
 		len = 2;
 		break;
 	case USB_RECIP_INTERFACE:
 	case USB_RECIP_ENDPOINT:
-		*(uint16_t *)buffer = cpu_to_le16(0);
+		*(u16 *)buffer = cpu_to_le16(0);
 		len = 2;
 		break;
 	case USB_TYPE_CLASS:
-		*(uint32_t *)buffer = cpu_to_le32(0);
+		*(u32 *)buffer = cpu_to_le32(0);
 		len = 4;
 		break;
 	case USB_RECIP_OTHER | USB_TYPE_CLASS:
@@ -498,7 +498,7 @@ static int dwc_otg_submit_rh_msg_in_status(struct dwc2_core_regs *regs,
 		if (hprt0 & HPRT0_OVRCURRCHG)
 			port_change |= USB_PORT_STAT_C_OVERCURRENT;
 
-		*(uint32_t *)buffer = cpu_to_le32(port_status |
+		*(u32 *)buffer = cpu_to_le32(port_status |
 					(port_change << 16));
 		len = 4;
 		break;
@@ -519,11 +519,11 @@ static int dwc_otg_submit_rh_msg_in_descriptor(struct usb_device *dev,
 					       struct devrequest *cmd)
 {
 	unsigned char data[32];
-	uint32_t dsc;
+	u32 dsc;
 	int len = 0;
 	int stat = 0;
-	uint16_t wValue = cpu_to_le16(cmd->value);
-	uint16_t wLength = cpu_to_le16(cmd->length);
+	u16 wValue = cpu_to_le16(cmd->value);
+	u16 wLength = cpu_to_le16(cmd->length);
 
 	switch (cmd->requesttype & ~USB_DIR_IN) {
 	case 0:
@@ -606,7 +606,7 @@ static int dwc_otg_submit_rh_msg_in_configuration(struct usb_device *dev,
 
 	switch (cmd->requesttype & ~USB_DIR_IN) {
 	case 0:
-		*(uint8_t *)buffer = 0x01;
+		*(u8 *)buffer = 0x01;
 		len = 1;
 		break;
 	default:
@@ -650,8 +650,8 @@ static int dwc_otg_submit_rh_msg_out(struct dwc2_priv *priv,
 	struct dwc2_core_regs *regs = priv->regs;
 	int len = 0;
 	int stat = 0;
-	uint16_t bmrtype_breq = cmd->requesttype | (cmd->request << 8);
-	uint16_t wValue = cpu_to_le16(cmd->value);
+	u16 bmrtype_breq = cmd->requesttype | (cmd->request << 8);
+	u16 wValue = cpu_to_le16(cmd->value);
 
 	switch (bmrtype_breq & ~USB_DIR_IN) {
 	case (USB_REQ_CLEAR_FEATURE << 8) | USB_RECIP_ENDPOINT:
@@ -724,10 +724,10 @@ static int dwc_otg_submit_rh_msg(struct dwc2_priv *priv, struct usb_device *dev,
 	return stat;
 }
 
-int wait_for_chhltd(struct dwc2_hc_regs *hc_regs, uint32_t *sub, u8 *toggle)
+int wait_for_chhltd(struct dwc2_hc_regs *hc_regs, u32 *sub, u8 *toggle)
 {
 	int ret;
-	uint32_t hcint, hctsiz;
+	u32 hcint, hctsiz;
 
 	ret = wait_for_bit_le32(&hc_regs->hcint, HCINTMSK_CHHLTD, true,
 				2000, false);
@@ -764,7 +764,7 @@ static int transfer_chunk(struct dwc2_hc_regs *hc_regs, void *aligned_buffer,
 			  int xfer_len, int *actual_len, int odd_frame)
 {
 	int ret = 0;
-	uint32_t sub;
+	u32 sub;
 
 	debug("%s: chunk: pid %d xfer_len %u pkts %u\n", __func__,
 	      *pid, xfer_len, num_packets);
@@ -834,10 +834,10 @@ int chunk_msg(struct dwc2_priv *priv, struct usb_device *dev,
 	int ret = 0;
 	int do_split = 0;
 	int complete_split = 0;
-	uint32_t xfer_len;
-	uint32_t num_packets;
+	u32 xfer_len;
+	u32 num_packets;
 	int stop_transfer = 0;
-	uint32_t max_xfer_len;
+	u32 max_xfer_len;
 	int ssplit_frame_num = 0;
 
 	debug("%s: msg: pipe %lx pid %d in %d len %d\n", __func__, pipe, *pid,
@@ -859,9 +859,9 @@ int chunk_msg(struct dwc2_priv *priv, struct usb_device *dev,
 
 	/* Check if the target is a FS/LS device behind a HS hub */
 	if (dev->speed != USB_SPEED_HIGH) {
-		uint8_t hub_addr;
-		uint8_t hub_port;
-		uint32_t hprt0 = readl(&regs->host_regs.hprt0);
+		u8 hub_addr;
+		u8 hub_port;
+		u32 hprt0 = readl(&regs->host_regs.hprt0);
 
 		if (FIELD_GET(HPRT0_SPD_MASK, hprt0) == HPRT0_SPD_HIGH_SPEED) {
 			usb_find_usb2_hub_address_port(dev, &hub_addr,
@@ -876,7 +876,7 @@ int chunk_msg(struct dwc2_priv *priv, struct usb_device *dev,
 
 	do {
 		int actual_len = 0;
-		uint32_t hcint;
+		u32 hcint;
 		int odd_frame = 0;
 		xfer_len = len - done;
 
@@ -1083,7 +1083,7 @@ static int dwc2_reset(struct udevice *dev)
 static int dwc2_init_common(struct udevice *dev, struct dwc2_priv *priv)
 {
 	struct dwc2_core_regs *regs = priv->regs;
-	uint32_t snpsid;
+	u32 snpsid;
 	int i, j;
 	int ret;
 

-- 
2.47.1

