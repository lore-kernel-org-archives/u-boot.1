Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C48C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:50:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4443C88CE5;
	Sat, 20 Jul 2024 14:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tofbkYKO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QgFEGAsY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0605388CC5; Sat, 20 Jul 2024 14:44:11 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E5CC88CCC
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WR5p00KLZz9sqQ;
 Sat, 20 Jul 2024 14:44:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XlV+rS6jgoeL+3uBciste3RCVoCp/t+q9GMv9qjgGVY=;
 b=tofbkYKOViLP5Xx4bXeHjL8pKc8KM0LaWrsLJkPqKNB8K1dk2tY7mccd0sspYYnFuVo05p
 Rl+JAV7GFkJMWpyqyuTCvd7Y9/0gczlxZqh844wP9pfQHBEjzW5cGvFz9CyDOe+uEb2qS0
 FIHoBhdQHUSgWTUXu2/jwiYiY0UCBe3pCminOJwmhAs8P+MQR3cTKIN3hQc6byjSURWLhV
 irEXodVb8YJdXgH8NyrCZ15p1bvHwvciOVYgIBEZlb8w+DFnJrQd2ItECPyALF7efS2gb2
 ZNGJDEfhaJZ4sFZEoNHrujwwNPjzMJhvTmkLwzXJ5o7obiO7wkFeZYUIBq+kkA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XlV+rS6jgoeL+3uBciste3RCVoCp/t+q9GMv9qjgGVY=;
 b=QgFEGAsYqk4bLtnudBv7CLS8czbgBnPXAjZQRMVE/maWP/qFb9KKq+24YMM11d7Ngbm7pV
 yHC27K/dR8BFuZ9oFXiI/grfKAMD2rnxrdc8osFtBSo0Q5OXBFIyprInGFQwUl+3+6ft4q
 /fbmi2fGNCBMw2uAkUbCBy3YUo+pF2adCxwubUq9BOlwfojtGwMWbVvXJOhvkwNhfDNBQn
 5KXKvYHoDbFnTsJ4JqQ7uNm2eaX8GgWPEMPX9CrnkJpUWHjErP1/tb6QqZl6IlyyQeG7oS
 hZiQgg17J0prHpM4tpSGSkcmp6puyOt9ujJlf29AYyEskGHy2NHMqYfC42SB6g==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 38/40] drivers: usb: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:41:03 +0200
Message-ID: <20240720124239.7553-38-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e71e24972dee25d9dd3
X-MBO-RS-META: ty5c66om9j8fzkbqxppctwq3s33d3dxz
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/usb/dwc3/dwc3-generic.c            |  1 -
 drivers/usb/dwc3/gadget.c                  |  1 -
 drivers/usb/dwc3/samsung_usb_phy.c         |  1 -
 drivers/usb/eth/asix.c                     |  1 -
 drivers/usb/eth/asix88179.c                |  1 -
 drivers/usb/gadget/config.c                |  2 --
 drivers/usb/gadget/core.c                  | 12 ------------
 drivers/usb/gadget/dwc2_udc_otg_regs.h     |  1 -
 drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c |  4 ----
 drivers/usb/gadget/ep0.c                   |  4 ----
 drivers/usb/gadget/ep0.h                   |  2 --
 drivers/usb/gadget/epautoconf.c            |  1 -
 drivers/usb/gadget/ether.c                 |  4 ----
 drivers/usb/gadget/f_mass_storage.c        | 19 -------------------
 drivers/usb/gadget/f_sdp.c                 |  1 -
 drivers/usb/gadget/ndis.h                  |  2 --
 drivers/usb/gadget/rndis.c                 |  3 ---
 drivers/usb/gadget/rndis.h                 |  1 -
 drivers/usb/gadget/storage_common.c        |  3 ---
 drivers/usb/host/ehci-mx5.c                |  1 -
 drivers/usb/host/ohci.h                    |  6 ------
 drivers/usb/host/xhci-mem.c                |  1 -
 drivers/usb/musb-new/musb_core.c           |  6 ------
 drivers/usb/musb-new/musb_core.h           |  1 -
 drivers/usb/musb-new/musb_dma.h            |  1 -
 drivers/usb/musb-new/musb_gadget.c         |  4 ----
 drivers/usb/musb-new/musb_gadget.h         |  1 -
 drivers/usb/musb-new/musb_gadget_ep0.c     |  2 --
 drivers/usb/musb-new/musb_host.c           |  6 ------
 drivers/usb/musb-new/musb_host.h           |  1 -
 drivers/usb/musb-new/musb_io.h             |  2 --
 drivers/usb/musb-new/musb_regs.h           |  1 -
 drivers/usb/musb/omap3.c                   |  1 -
 drivers/usb/phy/rockchip_usb2_phy.c        |  1 -
 34 files changed, 99 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 731ede2fead..a9ba315463c 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -131,7 +131,6 @@ static int dwc3_generic_probe(struct udevice *dev,
 	priv->base = map_physmem(plat->base, DWC3_OTG_REGS_END, MAP_NOCACHE);
 	dwc3->regs = priv->base + DWC3_GLOBALS_REGS_START;
 
-
 	rc =  dwc3_init(dwc3);
 	if (rc) {
 		unmap_physmem(priv->base, MAP_NOCACHE);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8f08fda746d..fe33e307d3e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -754,7 +754,6 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		 dep->name, req, (unsigned long long)dma,
 		 length, last ? " last" : "", chain ? " chain" : "");
 
-
 	trb = &dep->trb_pool[dep->free_slot & DWC3_TRB_MASK];
 
 	if (!req->trb) {
diff --git a/drivers/usb/dwc3/samsung_usb_phy.c b/drivers/usb/dwc3/samsung_usb_phy.c
index 0a771308163..3563070cb85 100644
--- a/drivers/usb/dwc3/samsung_usb_phy.c
+++ b/drivers/usb/dwc3/samsung_usb_phy.c
@@ -26,7 +26,6 @@ void exynos5_usb3_phy_init(struct exynos_usb3_phy *phy)
 			PHYPARAM0_REF_LOSLEVEL_MASK);
 	setbits_le32(&phy->phy_param0, PHYPARAM0_REF_LOSLEVEL);
 
-
 	writel(0x0, &phy->phy_resume);
 
 	/*
diff --git a/drivers/usb/eth/asix.c b/drivers/usb/eth/asix.c
index c5a01ec922b..40a6e9291de 100644
--- a/drivers/usb/eth/asix.c
+++ b/drivers/usb/eth/asix.c
@@ -96,7 +96,6 @@
 #define FLAG_TYPE_AX88772B	(1U << 2)
 #define FLAG_EEPROM_MAC		(1U << 3) /* initial mac address in eeprom */
 
-
 /* driver private */
 struct asix_private {
 	int flags;
diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
index a0aa5c25e42..4bd3b9d10dc 100644
--- a/drivers/usb/eth/asix88179.c
+++ b/drivers/usb/eth/asix88179.c
@@ -392,7 +392,6 @@ static int asix_init_common(struct ueth_data *dev,
 	u8 buf[2], tmp[5], link_sts;
 	u16 *tmp16, mode;
 
-
 	tmp16 = (u16 *)buf;
 
 	debug("** %s()\n", __func__);
diff --git a/drivers/usb/gadget/config.c b/drivers/usb/gadget/config.c
index 1363ef9e73d..e41b1d964ea 100644
--- a/drivers/usb/gadget/config.c
+++ b/drivers/usb/gadget/config.c
@@ -16,7 +16,6 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 
-
 /**
  * usb_descriptor_fillbuf - fill buffer with descriptors
  * @buf: Buffer to be filled
@@ -51,7 +50,6 @@ usb_descriptor_fillbuf(void *buf, unsigned buflen,
 	return dest - (u8 *)buf;
 }
 
-
 /**
  * usb_gadget_config_buf - builts a complete configuration descriptor
  * @config: Header for the descriptor, including characteristics such
diff --git a/drivers/usb/gadget/core.c b/drivers/usb/gadget/core.c
index 888f0cfea66..bcb1ad3082c 100644
--- a/drivers/usb/gadget/core.c
+++ b/drivers/usb/gadget/core.c
@@ -22,7 +22,6 @@
 
 #define MAX_INTERFACES 2
 
-
 int maxstrings = 20;
 
 /* Global variables ************************************************************************** */
@@ -65,10 +64,8 @@ __maybe_unused static char *usbd_device_status[] = {
 
 #define USBD_DEVICE_STATUS(x) (((unsigned int)x <= USBD_CLOSING) ? usbd_device_status[x] : "UNKNOWN")
 
-
 /* Descriptor support functions ************************************************************** */
 
-
 /**
  * usbd_get_string - find and return a string descriptor
  * @index: string index to return
@@ -83,10 +80,8 @@ struct usb_string_descriptor *usbd_get_string (__u8 index)
 	return usb_strings[index];
 }
 
-
 /* Access to device descriptor functions ***************************************************** */
 
-
 /* *
  * usbd_device_configuration_instance - find a configuration instance for this device
  * @device:
@@ -103,7 +98,6 @@ static struct usb_configuration_instance *usbd_device_configuration_instance (st
 	return device->configuration_instance_array + configuration;
 }
 
-
 /* *
  * usbd_device_interface_instance
  * @device:
@@ -149,7 +143,6 @@ struct usb_alternate_instance *usbd_device_alternate_instance (struct usb_device
 	return interface_instance->alternates_instance_array + alternate;
 }
 
-
 /* *
  * usbd_device_device_descriptor
  * @device: which device
@@ -182,7 +175,6 @@ struct usb_configuration_descriptor *usbd_device_configuration_descriptor (struc
 	return (configuration_instance->configuration_descriptor);
 }
 
-
 /**
  * usbd_device_interface_descriptor
  * @device: which device
@@ -231,7 +223,6 @@ struct usb_endpoint_descriptor *usbd_device_endpoint_descriptor_index (struct us
 	return *(alternate_instance->endpoints_descriptor_array + index);
 }
 
-
 /**
  * usbd_device_endpoint_transfersize
  * @device: which device
@@ -255,7 +246,6 @@ int usbd_device_endpoint_transfersize (struct usb_device_instance *device, int p
 	return *(alternate_instance->endpoint_transfersize_array + index);
 }
 
-
 /**
  * usbd_device_endpoint_descriptor
  * @device: which device
@@ -292,7 +282,6 @@ int usbd_endpoint_halted (struct usb_device_instance *device, int endpoint)
 	return (device->status == USB_STATUS_HALT);
 }
 
-
 /**
  * usbd_rcv_complete - complete a receive
  * @endpoint:
@@ -460,7 +449,6 @@ struct urb *first_urb_detached (urb_link * hd)
 	return urb;
 }
 
-
 /*
  * Append an urb_link (or a whole list of
  * urb_links) to the tail of another list
diff --git a/drivers/usb/gadget/dwc2_udc_otg_regs.h b/drivers/usb/gadget/dwc2_udc_otg_regs.h
index 9ca6f423757..01056fab1c2 100644
--- a/drivers/usb/gadget/dwc2_udc_otg_regs.h
+++ b/drivers/usb/gadget/dwc2_udc_otg_regs.h
@@ -204,7 +204,6 @@ struct dwc2_usbotg_reg {
 
 #define DIEPCTL0_NEXT_EP_BIT		(11)
 
-
 /* DWC2_UDC_OTG_DIEPMSK/DOEPMSK device IN/OUT endpoint
    common interrupt mask register */
 /* DWC2_UDC_OTG_DIEPINTn/DOEPINTn device IN/OUT endpoint interrupt register */
diff --git a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
index 16b2a03f9e4..c0408bae076 100644
--- a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
+++ b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
@@ -92,7 +92,6 @@ static inline void dwc2_ep0_complete_out(void)
 
 }
 
-
 static int setdma_rx(struct dwc2_ep *ep, struct dwc2_request *req)
 {
 	u32 *buf, ctrl;
@@ -972,7 +971,6 @@ static void dwc2_udc_set_nak(struct dwc2_ep *ep)
 	return;
 }
 
-
 static void dwc2_udc_ep_set_stall(struct dwc2_ep *ep)
 {
 	u8		ep_num;
@@ -1440,7 +1438,6 @@ static void dwc2_ep0_setup(struct dwc2_udc *dev)
 		}
 	}
 
-
 	if (likely(dev->driver)) {
 		/* device-2-host (IN) or no data setup command,
 		 * process immediately */
@@ -1462,7 +1459,6 @@ static void dwc2_ep0_setup(struct dwc2_udc *dev)
 				    " bRequest = %d\n",
 				i, usb_ctrl->bRequest);
 
-
 		} else if (dev->req_pending) {
 			dev->req_pending = 0;
 			debug_cond(DEBUG_SETUP != 0,
diff --git a/drivers/usb/gadget/ep0.c b/drivers/usb/gadget/ep0.c
index 9d08640ff23..8c7fc17c2ea 100644
--- a/drivers/usb/gadget/ep0.c
+++ b/drivers/usb/gadget/ep0.c
@@ -93,7 +93,6 @@ __maybe_unused static char *usbd_device_requests[] = {
 
 /* EP0 Configuration Set ********************************************************************* */
 
-
 /**
  * ep0_get_status - fill in URB data with appropriate status
  * @device:
@@ -376,7 +375,6 @@ static int ep0_get_descriptor (struct usb_device_instance *device,
 		return -1;
 	}
 
-
 	dbg_ep0 (1, "urb: buffer: %p buffer_length: %2d actual_length: %2d tx_packetSize: %2d",
 		 urb->buffer, urb->buffer_length, urb->actual_length,
 		 device->bus->endpoint_array[0].tx_packetSize);
@@ -421,7 +419,6 @@ int ep0_recv_setup (struct urb *urb)
 
 	dbg_ep0 (3, "urb: %p device: %p", urb, urb->device);
 
-
 	/*dbg_ep0(2, "-       -       -       -       -       -       -       -       -       -"); */
 
 	dbg_ep0 (2,
@@ -533,7 +530,6 @@ int ep0_recv_setup (struct urb *urb)
 	/* handle the requests that do not return data */
 	else {
 
-
 		/*dbg_ep0(3, "Host-to-Device"); */
 		switch (request->bRequest) {
 
diff --git a/drivers/usb/gadget/ep0.h b/drivers/usb/gadget/ep0.h
index 976825ab93e..a16d36be938 100644
--- a/drivers/usb/gadget/ep0.h
+++ b/drivers/usb/gadget/ep0.h
@@ -18,8 +18,6 @@
 #ifndef __USBDCORE_EP0_H__
 #define __USBDCORE_EP0_H__
 
-
 int ep0_recv_setup (struct urb *urb);
 
-
 #endif
diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index a4da4f72de9..495460473e9 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -24,7 +24,6 @@ static unsigned epnum;
 static unsigned in_epnum;
 #endif
 
-
 /*
  * This should work with endpoints from controller drivers sharing the
  * same endpoint naming convention.  By example:
diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
index b7b7bacb00d..7973927e8a7 100644
--- a/drivers/usb/gadget/ether.c
+++ b/drivers/usb/gadget/ether.c
@@ -35,7 +35,6 @@
 
 extern struct platform_data brd;
 
-
 unsigned packet_received, packet_sent;
 
 /*
@@ -273,7 +272,6 @@ static char dev_addr[18];
 
 static char host_addr[18];
 
-
 /*-------------------------------------------------------------------------*/
 
 /*
@@ -806,7 +804,6 @@ static const struct usb_descriptor_header *hs_rndis_function[] = {
 };
 #endif
 
-
 /* maxpacket and other transfer characteristics vary by speed. */
 static inline struct usb_endpoint_descriptor *
 ep_desc(struct usb_gadget *g, struct usb_endpoint_descriptor *hs,
@@ -2137,7 +2134,6 @@ autoconf_fail:
 #endif
 	}
 
-
 	/* network device setup */
 	dev->net = l_priv->netdev;
 
diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index 89a96dbb7a7..ffe1ae6eb73 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -387,7 +387,6 @@ struct fsg_dev {
 	struct usb_ep		*bulk_out;
 };
 
-
 static inline int __fsg_is_set(struct fsg_common *common,
 			       const char *func, unsigned line)
 {
@@ -404,13 +403,11 @@ static inline int __fsg_is_set(struct fsg_common *common,
 
 #define fsg_is_set(common) likely(__fsg_is_set(common, __func__, __LINE__))
 
-
 static inline struct fsg_dev *fsg_from_func(struct usb_function *f)
 {
 	return container_of(f, struct fsg_dev, function);
 }
 
-
 typedef void (*fsg_routine_t)(struct fsg_dev *);
 
 static int exception_in_progress(struct fsg_common *common)
@@ -1118,7 +1115,6 @@ static int do_inquiry(struct fsg_common *common, struct fsg_buffhd *bh)
 	return 36;
 }
 
-
 static int do_request_sense(struct fsg_common *common, struct fsg_buffhd *bh)
 {
 	struct fsg_lun	*curlun = &common->luns[common->lun];
@@ -1210,7 +1206,6 @@ static int do_read_header(struct fsg_common *common, struct fsg_buffhd *bh)
 	return 8;
 }
 
-
 static int do_read_toc(struct fsg_common *common, struct fsg_buffhd *bh)
 {
 	struct fsg_lun	*curlun = &common->luns[common->lun];
@@ -1319,7 +1314,6 @@ static int do_mode_sense(struct fsg_common *common, struct fsg_buffhd *bh)
 	return len;
 }
 
-
 static int do_start_stop(struct fsg_common *common)
 {
 	struct fsg_lun	*curlun = &common->luns[common->lun];
@@ -1358,7 +1352,6 @@ static int do_prevent_allow(struct fsg_common *common)
 	return 0;
 }
 
-
 static int do_read_format_capacities(struct fsg_common *common,
 			struct fsg_buffhd *bh)
 {
@@ -1376,7 +1369,6 @@ static int do_read_format_capacities(struct fsg_common *common,
 	return 12;
 }
 
-
 static int do_mode_select(struct fsg_common *common, struct fsg_buffhd *bh)
 {
 	struct fsg_lun	*curlun = &common->luns[common->lun];
@@ -1387,7 +1379,6 @@ static int do_mode_select(struct fsg_common *common, struct fsg_buffhd *bh)
 	return -EINVAL;
 }
 
-
 /*-------------------------------------------------------------------------*/
 
 static int halt_bulk_in_endpoint(struct fsg_dev *fsg)
@@ -1512,7 +1503,6 @@ static int throw_away_data(struct fsg_common *common)
 	return 0;
 }
 
-
 static int finish_reply(struct fsg_common *common)
 {
 	struct fsg_buffhd	*bh = common->next_buffhd_to_fill;
@@ -1608,7 +1598,6 @@ static int finish_reply(struct fsg_common *common)
 	return rc;
 }
 
-
 static int send_status(struct fsg_common *common)
 {
 	struct fsg_lun		*curlun = &common->luns[common->lun];
@@ -1664,7 +1653,6 @@ static int send_status(struct fsg_common *common)
 	return 0;
 }
 
-
 /*-------------------------------------------------------------------------*/
 
 /* Check whether the command is properly formed and whether its data size
@@ -1792,7 +1780,6 @@ static int check_command_size_in_blocks(struct fsg_common *common,
 			mask, needs_medium, name);
 }
 
-
 static int do_scsi_command(struct fsg_common *common)
 {
 	struct fsg_buffhd	*bh;
@@ -2127,7 +2114,6 @@ static int received_cbw(struct fsg_dev *fsg, struct fsg_buffhd *bh)
 	return 0;
 }
 
-
 static int get_next_command(struct fsg_common *common)
 {
 	struct fsg_buffhd	*bh;
@@ -2166,7 +2152,6 @@ static int get_next_command(struct fsg_common *common)
 	return rc;
 }
 
-
 /*-------------------------------------------------------------------------*/
 
 static int enable_endpoint(struct fsg_common *common, struct usb_ep *ep,
@@ -2279,10 +2264,8 @@ reset:
 	return rc;
 }
 
-
 /****************************** ALT CONFIGS ******************************/
 
-
 static int fsg_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 {
 	struct fsg_dev *fsg = fsg_from_func(f);
@@ -2603,7 +2586,6 @@ static void fsg_common_release(struct kref *ref)
 		kfree(common);
 }
 
-
 /*-------------------------------------------------------------------------*/
 
 /**
@@ -2722,7 +2704,6 @@ autoconf_fail:
 	return -ENOTSUPP;
 }
 
-
 /****************************** ADD FUNCTION ******************************/
 
 static struct usb_gadget_strings *fsg_strings_array[] = {
diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 89496917a61..514c097591b 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -588,7 +588,6 @@ static struct usb_request *alloc_ep_req(struct usb_ep *ep, unsigned length)
 	return req;
 }
 
-
 static struct usb_request *sdp_start_ep(struct usb_ep *ep, bool in)
 {
 	struct usb_request *req;
diff --git a/drivers/usb/gadget/ndis.h b/drivers/usb/gadget/ndis.h
index 753838f7941..371d37ff05a 100644
--- a/drivers/usb/gadget/ndis.h
+++ b/drivers/usb/gadget/ndis.h
@@ -21,7 +21,6 @@
 #ifndef _USBGADGET_NDIS_H
 #define _USBGADGET_NDIS_H
 
-
 #define NDIS_STATUS_MULTICAST_FULL        0xC0010009
 #define NDIS_STATUS_MULTICAST_EXISTS      0xC001000A
 #define NDIS_STATUS_MULTICAST_NOT_FOUND   0xC001000B
@@ -60,7 +59,6 @@ struct NDIS_PM_PACKET_PATTERN {
 	__le32	PatternFlags;
 };
 
-
 /* Required Object IDs (OIDs) */
 #define OID_GEN_SUPPORTED_LIST            0x00010101
 #define OID_GEN_HARDWARE_STATUS           0x00010102
diff --git a/drivers/usb/gadget/rndis.c b/drivers/usb/gadget/rndis.c
index 5e6e5a054ca..76801bff9a3 100644
--- a/drivers/usb/gadget/rndis.c
+++ b/drivers/usb/gadget/rndis.c
@@ -53,7 +53,6 @@ static const __le32 rndis_driver_version = __constant_cpu_to_le32(1);
 /* Function Prototypes */
 static rndis_resp_t *rndis_add_response(int configNr, u32 length);
 
-
 /* supported OIDs */
 static const u32 oid_supported_list[] = {
 	/* the general stuff */
@@ -138,7 +137,6 @@ static const u32 oid_supported_list[] = {
 #endif	/* RNDIS_PM */
 };
 
-
 /* NDIS Functions */
 static int gen_ndis_query_resp(int configNr, u32 OID, u8 *buf,
 				unsigned buf_len, rndis_resp_t *r)
@@ -942,7 +940,6 @@ static int rndis_keepalive_response(int configNr,
 	return 0;
 }
 
-
 /*
  * Device to Host Comunication
  */
diff --git a/drivers/usb/gadget/rndis.h b/drivers/usb/gadget/rndis.h
index 77db55a563f..84b6aeffb08 100644
--- a/drivers/usb/gadget/rndis.h
+++ b/drivers/usb/gadget/rndis.h
@@ -72,7 +72,6 @@
 #define OID_PNP_REMOVE_WAKE_UP_PATTERN		0xFD010104
 #define OID_PNP_ENABLE_WAKE_UP			0xFD010106
 
-
 typedef struct rndis_init_msg_type {
 	__le32	MessageType;
 	__le32	MessageLength;
diff --git a/drivers/usb/gadget/storage_common.c b/drivers/usb/gadget/storage_common.c
index 97dc6b6f729..7e4b542f7ce 100644
--- a/drivers/usb/gadget/storage_common.c
+++ b/drivers/usb/gadget/storage_common.c
@@ -13,7 +13,6 @@
  * Łukasz Majewski <l.majewski@samsung.com>
  */
 
-
 /*
  * This file requires the following identifiers used in USB strings to
  * be defined (each of type pointer to char):
@@ -46,10 +45,8 @@
  * characters rather then a pointer to void.
  */
 
-
 /* #include <asm/unaligned.h> */
 
-
 /*
  * Thanks to NetChip Technologies for donating this product ID.
  *
diff --git a/drivers/usb/host/ehci-mx5.c b/drivers/usb/host/ehci-mx5.c
index fb912654097..44912de7787 100644
--- a/drivers/usb/host/ehci-mx5.c
+++ b/drivers/usb/host/ehci-mx5.c
@@ -21,7 +21,6 @@
 
 #define MX5_USBOTHER_REGS_OFFSET 0x800
 
-
 #define MXC_OTG_OFFSET			0
 #define MXC_H1_OFFSET			0x200
 #define MXC_H2_OFFSET			0x400
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index 87ef19074b0..c21deb53ce2 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -71,7 +71,6 @@ struct ed {
 } __attribute__((aligned(ED_ALIGNMENT)));
 typedef struct ed ed_t;
 
-
 /* TD info field */
 #define TD_CC	    0xf0000000
 #define TD_CC_GET(td_p) ((td_p >>28) & 0x0f)
@@ -107,7 +106,6 @@ typedef struct ed ed_t;
 #define TD_BUFFERUNDERRUN  0x0D
 #define TD_NOTACCESSED	   0x0F
 
-
 #define MAXPSW 1
 
 struct td {
@@ -232,7 +230,6 @@ struct ohci_regs {
 #define OHCI_INTR_OC	(1 << 30)	/* ownership change */
 #define OHCI_INTR_MIE	(1 << 31)	/* master interrupt enable */
 
-
 /* Virtual Root HUB */
 struct virt_root_hub {
 	int devnum; /* Address of Root Hub endpoint */
@@ -268,7 +265,6 @@ struct virt_root_hub {
 /* Our Vendor Specific Request */
 #define RH_SET_EP		0x2000
 
-
 /* Hub port features */
 #define RH_PORT_CONNECTION	   0x00
 #define RH_PORT_ENABLE		   0x01
@@ -295,7 +291,6 @@ struct virt_root_hub {
 #define RH_REQ_ERR		   -1
 #define RH_NACK			   0x00
 
-
 /* OHCI ROOT HUB REGISTER MASKS */
 
 /* roothub.portstatus [i] bits */
@@ -372,7 +367,6 @@ typedef struct ohci_device {
  * a subset of what the full implementation needs. (Linus)
  */
 
-
 typedef struct ohci {
 	/* this allocates EDs for all possible endpoints */
 	struct ohci_device ohci_dev __aligned(TD_ALIGNMENT);
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 045b0fba812..df94a66aa0a 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -56,7 +56,6 @@ void xhci_inval_cache(uintptr_t addr, u32 len)
 				ALIGN(addr + len, CACHELINE_SIZE));
 }
 
-
 /**
  * frees the "segment" pointer passed
  *
diff --git a/drivers/usb/musb-new/musb_core.c b/drivers/usb/musb-new/musb_core.c
index 257e7685cfa..cb01a8a3b38 100644
--- a/drivers/usb/musb-new/musb_core.c
+++ b/drivers/usb/musb-new/musb_core.c
@@ -98,7 +98,6 @@
 
 #define TA_WAIT_BCON(m) max_t(int, (m)->a_wait_bcon, OTG_TIME_A_WAIT_BCON)
 
-
 #define DRIVER_AUTHOR "Mentor Graphics, Texas Instruments, Nokia"
 #define DRIVER_DESC "Inventra Dual-Role USB Controller Driver"
 
@@ -114,7 +113,6 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" MUSB_DRIVER_NAME);
 
-
 #ifndef __UBOOT__
 /*-------------------------------------------------------------------------*/
 
@@ -301,7 +299,6 @@ void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 
 #endif	/* normal PIO */
 
-
 /*-------------------------------------------------------------------------*/
 
 /* for high speed test mode; see USB 2.0 spec 7.1.20 */
@@ -971,7 +968,6 @@ int musb_start(struct musb *musb)
 #endif
 }
 
-
 static void musb_generic_disable(struct musb *musb)
 {
 	void __iomem	*mbase = musb->mregs;
@@ -1042,7 +1038,6 @@ static void musb_shutdown(struct platform_device *pdev)
 }
 #endif
 
-
 /*-------------------------------------------------------------------------*/
 
 /*
@@ -1344,7 +1339,6 @@ done:
 	return 0;
 }
 
-
 /*
  * ep_config_from_hw - when MUSB_C_DYNFIFO_DEF is false
  * @param musb the controller
diff --git a/drivers/usb/musb-new/musb_core.h b/drivers/usb/musb-new/musb_core.h
index adfd81b8544..0e9ec96c0e8 100644
--- a/drivers/usb/musb-new/musb_core.h
+++ b/drivers/usb/musb-new/musb_core.h
@@ -143,7 +143,6 @@ enum musb_g_ep0_state {
 #define OTG_TIME_A_AIDL_BDIS	200		/* min 200 msec */
 #define OTG_TIME_B_ASE0_BRST	100		/* min 3.125 ms */
 
-
 /*************************** REGISTER ACCESS ********************************/
 
 /* Endpoint registers (other than dynfifo setup) can be accessed either
diff --git a/drivers/usb/musb-new/musb_dma.h b/drivers/usb/musb-new/musb_dma.h
index 5f99356ca79..9cafcf4432d 100644
--- a/drivers/usb/musb-new/musb_dma.h
+++ b/drivers/usb/musb-new/musb_dma.h
@@ -141,7 +141,6 @@ struct dma_controller {
 /* called after channel_program(), may indicate a fault */
 extern void musb_dma_completion(struct musb *musb, u8 epnum, u8 transmit);
 
-
 extern struct dma_controller *__init
 dma_controller_create(struct musb *, void __iomem *);
 
diff --git a/drivers/usb/musb-new/musb_gadget.c b/drivers/usb/musb-new/musb_gadget.c
index 29e225aa0f1..08fac829ce7 100644
--- a/drivers/usb/musb-new/musb_gadget.c
+++ b/drivers/usb/musb-new/musb_gadget.c
@@ -32,7 +32,6 @@
 
 #include "musb_core.h"
 
-
 /* MUSB PERIPHERAL status 3-mar-2006:
  *
  * - EP0 seems solid.  It passes both USBCV and usbtest control cases.
@@ -274,7 +273,6 @@ static inline int max_ep_writesize(struct musb *musb, struct musb_ep *ep)
 		return ep->packet_sz;
 }
 
-
 #ifdef CONFIG_USB_INVENTRA_DMA
 
 /* Peripheral tx (IN) using Mentor DMA works as follows:
@@ -1823,7 +1821,6 @@ static void musb_gadget_release(struct device *dev)
 }
 #endif
 
-
 static void __devinit
 init_peripheral_ep(struct musb *musb, struct musb_ep *ep, u8 epnum, int is_in)
 {
@@ -2285,7 +2282,6 @@ __acquires(musb->lock)
 	else if (devctl & MUSB_DEVCTL_HR)
 		musb_writeb(mbase, MUSB_DEVCTL, MUSB_DEVCTL_SESSION);
 
-
 	/* what speed did we negotiate? */
 	power = musb_readb(mbase, MUSB_POWER);
 	musb->g.speed = (power & MUSB_POWER_HSMODE)
diff --git a/drivers/usb/musb-new/musb_gadget.h b/drivers/usb/musb-new/musb_gadget.h
index 7cb7a5cd6dc..b11e7205299 100644
--- a/drivers/usb/musb-new/musb_gadget.h
+++ b/drivers/usb/musb-new/musb_gadget.h
@@ -43,7 +43,6 @@ extern struct usb_request *
 musb_alloc_request(struct usb_ep *ep, gfp_t gfp_flags);
 extern void musb_free_request(struct usb_ep *ep, struct usb_request *req);
 
-
 /*
  * struct musb_ep - peripheral side view of endpoint rx or tx side
  */
diff --git a/drivers/usb/musb-new/musb_gadget_ep0.c b/drivers/usb/musb-new/musb_gadget_ep0.c
index 63eee31a6b3..ea65326ab62 100644
--- a/drivers/usb/musb-new/musb_gadget_ep0.c
+++ b/drivers/usb/musb-new/musb_gadget_ep0.c
@@ -501,7 +501,6 @@ static void ep0_rxstate(struct musb *musb)
 	} else
 		csr = MUSB_CSR0_P_SVDRXPKTRDY | MUSB_CSR0_P_SENDSTALL;
 
-
 	/* Completion handler may choose to stall, e.g. because the
 	 * message just received holds invalid data.
 	 */
@@ -895,7 +894,6 @@ finish:
 	return retval;
 }
 
-
 static int
 musb_g_ep0_enable(struct usb_ep *ep, const struct usb_endpoint_descriptor *desc)
 {
diff --git a/drivers/usb/musb-new/musb_host.c b/drivers/usb/musb-new/musb_host.c
index 2f2fc7c1359..7528a53d73e 100644
--- a/drivers/usb/musb-new/musb_host.c
+++ b/drivers/usb/musb-new/musb_host.c
@@ -32,7 +32,6 @@
 #include "musb_core.h"
 #include "musb_host.h"
 
-
 /* MUSB HOST status 22-mar-2006
  *
  * - There's still lots of partial code duplication for fault paths, so
@@ -67,7 +66,6 @@
  *   although ARP RX wins.  (That test was done with a full speed link.)
  */
 
-
 /*
  * NOTE on endpoint usage:
  *
@@ -82,7 +80,6 @@
  * of transfers between endpoints, or anything clever.
  */
 
-
 static void musb_ep_program(struct musb *musb, u8 epnum,
 			struct urb *urb, int is_out,
 			u8 *buf, u32 offset, u32 len);
@@ -884,7 +881,6 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 	}
 }
 
-
 /*
  * Service the default endpoint (ep0) as host.
  * Return true until it's time to start the status stage.
@@ -1085,7 +1081,6 @@ done:
 	return retval;
 }
 
-
 #ifdef CONFIG_USB_INVENTRA_DMA
 
 /* Host side TX (OUT) using Mentor DMA works as follows:
@@ -1344,7 +1339,6 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 			MUSB_TXCSR_H_WZC_BITS | MUSB_TXCSR_TXPKTRDY);
 }
 
-
 #ifdef CONFIG_USB_INVENTRA_DMA
 
 /* Host side RX (IN) using Mentor DMA works as follows:
diff --git a/drivers/usb/musb-new/musb_host.h b/drivers/usb/musb-new/musb_host.h
index 5a604bdb0cf..823e327ef0e 100644
--- a/drivers/usb/musb-new/musb_host.h
+++ b/drivers/usb/musb-new/musb_host.h
@@ -59,7 +59,6 @@ static inline struct musb_qh *first_qh(struct list_head *q)
 	return list_entry(q->next, struct musb_qh, ring);
 }
 
-
 extern void musb_root_disconnect(struct musb *musb);
 
 struct usb_hcd;
diff --git a/drivers/usb/musb-new/musb_io.h b/drivers/usb/musb-new/musb_io.h
index 19b12f36a5c..0ced19919ef 100644
--- a/drivers/usb/musb-new/musb_io.h
+++ b/drivers/usb/musb-new/musb_io.h
@@ -24,14 +24,12 @@ static inline u16 musb_readw(const void __iomem *addr, unsigned offset)
 static inline u32 musb_readl(const void __iomem *addr, unsigned offset)
 	{ return __raw_readl(addr + offset); }
 
-
 static inline void musb_writew(void __iomem *addr, unsigned offset, u16 data)
 	{ __raw_writew(data, addr + offset); }
 
 static inline void musb_writel(void __iomem *addr, unsigned offset, u32 data)
 	{ __raw_writel(data, addr + offset); }
 
-
 #if defined(CONFIG_USB_MUSB_TUSB6010) || defined (CONFIG_USB_MUSB_TUSB6010_MODULE)
 
 /*
diff --git a/drivers/usb/musb-new/musb_regs.h b/drivers/usb/musb-new/musb_regs.h
index 9fd01fafdf7..a54da45d490 100644
--- a/drivers/usb/musb-new/musb_regs.h
+++ b/drivers/usb/musb-new/musb_regs.h
@@ -188,7 +188,6 @@
 /* HUBADDR */
 #define MUSB_HUBADDR_MULTI_TT		0x80
 
-
 /* SUNXI has different reg addresses, but identical r/w functions */
 #ifndef CONFIG_ARCH_SUNXI
 
diff --git a/drivers/usb/musb/omap3.c b/drivers/usb/musb/omap3.c
index 080bd78523c..f9747d69bf6 100644
--- a/drivers/usb/musb/omap3.c
+++ b/drivers/usb/musb/omap3.c
@@ -63,7 +63,6 @@ static struct omap3_otg_regs *otg;
 
 #define OMAP3_OTG_FORCESTDBY_STANDBY			0x0001
 
-
 #ifdef DEBUG_MUSB_OMAP3
 static void musb_db_otg_regs(void)
 {
diff --git a/drivers/usb/phy/rockchip_usb2_phy.c b/drivers/usb/phy/rockchip_usb2_phy.c
index 9ec5b2d172b..ce9a7b5b819 100644
--- a/drivers/usb/phy/rockchip_usb2_phy.c
+++ b/drivers/usb/phy/rockchip_usb2_phy.c
@@ -72,7 +72,6 @@ static void property_enable(struct dwc2_plat_otg_data *pdata,
 	writel(val, pdata->regs_phy + reg->offset);
 }
 
-
 void otg_phy_init(struct dwc2_udc *dev)
 {
 	struct dwc2_plat_otg_data *pdata = dev->pdata;
-- 
2.43.0

