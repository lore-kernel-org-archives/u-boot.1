Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB356CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 06:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88A67882AE;
	Thu,  4 Apr 2024 08:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mgCcM7Bk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02C6C882AE; Thu,  4 Apr 2024 08:26:08 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE03988293
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 08:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 23FB9CE2F93;
 Thu,  4 Apr 2024 06:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54ADCC43390;
 Thu,  4 Apr 2024 06:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712211957;
 bh=We0gQy1bkxXG2iYKIgi1QvBSJpwjqCLJEj2Dhg2GXh0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=mgCcM7Bk0U2GOwemVFzIIo2KcYAwRK2qKaF7u3L6GYY/ZyJ8pPStj4CREBGOlvBZ9
 rmid9yfXFeKZF985PkPX9vgW30b0NvJLphQAxXnmwQvqGGA83nBGWRclkX4AdMJA1Y
 NWEUL2EMj046JfuwGakBIEugqLnXSyMmecKTh3tuwzEi4LDLCZsX/flS28udcrOi5H
 SYIH5nokecPBq2SuzYHFXfoYlFHofwZchwnIglV19kfuP8q8X13ZE4FLfd9RxcAegK
 fNaXdr89+W+XbdalWdplS8DFLk4Mo9B6XhhzQugfHmSRKlDigcTRgrisIn9aUYmTen
 NB2V0+ttB0KHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 45D51CD1299;
 Thu,  4 Apr 2024 06:25:57 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Thu, 04 Apr 2024 08:25:50 +0200
Subject: [PATCH v4 2/6] usb: xhci: Set up endpoints for the first 2 interfaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-asahi-keyboards-v4-2-2266033feaff@jannau.net>
References: <20240404-asahi-keyboards-v4-0-2266033feaff@jannau.net>
In-Reply-To: <20240404-asahi-keyboards-v4-0-2266033feaff@jannau.net>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Joe Hershberger <joe.hershberger@ni.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3588; i=j@jannau.net;
 h=from:subject:message-id;
 bh=C+QptQG0I4SLRE163S23N4sr3v3/vF84MwYBdfUC3T0=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhjQ+98/rFwR8cX6zSG2u3lJ77558NY/HJUv9D+b4HVq55
 v2Ck4osHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACayk4WR4c+l589/d03fLHj5
 yhuOT8oPlk8SSrO+eLLl6+7QozOFzfIZGe49yBN18mnKO3TH0EJ8n7uUsP7/uC1NvsmnH1zbek7
 lCS8A
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Janne Grunau <j@jannau.net>

The xhci driver currently only does the necessary initialization for
endpoints found in the first interface descriptor. Apple USB keyboards
(released 2021) use the second interface descriptor for the HID keyboard
boot protocol. To allow USB drivers to use endpoints from other
interface descriptors the xhci driver needs to ensure these endpoints
are initialized as well.
Use USB_MAX_ACTIVE_INTERFACES to control how many interface descriptors
are considered during endpoint initialisation.
For now define it to 2 as that is sufficient for supporting the Apple
keyboards.

Reviewed-by: Marek Vasut <marex@denx.de>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/usb/host/xhci.c | 31 +++++++++++++++++++------------
 include/usb.h           |  6 ++++++
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 534c4b973f..741e186ee0 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -606,24 +606,28 @@ static int xhci_set_configuration(struct usb_device *udev)
 	int slot_id = udev->slot_id;
 	struct xhci_virt_device *virt_dev = ctrl->devs[slot_id];
 	struct usb_interface *ifdesc;
+	unsigned int ifnum;
+	unsigned int max_ifnum = min((unsigned int)USB_MAX_ACTIVE_INTERFACES,
+				     (unsigned int)udev->config.no_of_if);
 
 	out_ctx = virt_dev->out_ctx;
 	in_ctx = virt_dev->in_ctx;
 
-	num_of_ep = udev->config.if_desc[0].no_of_ep;
-	ifdesc = &udev->config.if_desc[0];
-
 	ctrl_ctx = xhci_get_input_control_ctx(in_ctx);
 	/* Initialize the input context control */
 	ctrl_ctx->add_flags = cpu_to_le32(SLOT_FLAG);
 	ctrl_ctx->drop_flags = 0;
 
-	/* EP_FLAG gives values 1 & 4 for EP1OUT and EP2IN */
-	for (cur_ep = 0; cur_ep < num_of_ep; cur_ep++) {
-		ep_flag = xhci_get_ep_index(&ifdesc->ep_desc[cur_ep]);
-		ctrl_ctx->add_flags |= cpu_to_le32(1 << (ep_flag + 1));
-		if (max_ep_flag < ep_flag)
-			max_ep_flag = ep_flag;
+	for (ifnum = 0; ifnum < max_ifnum; ifnum++) {
+		ifdesc = &udev->config.if_desc[ifnum];
+		num_of_ep = ifdesc->no_of_ep;
+		/* EP_FLAG gives values 1 & 4 for EP1OUT and EP2IN */
+		for (cur_ep = 0; cur_ep < num_of_ep; cur_ep++) {
+			ep_flag = xhci_get_ep_index(&ifdesc->ep_desc[cur_ep]);
+			ctrl_ctx->add_flags |= cpu_to_le32(1 << (ep_flag + 1));
+			if (max_ep_flag < ep_flag)
+				max_ep_flag = ep_flag;
+		}
 	}
 
 	xhci_inval_cache((uintptr_t)out_ctx->bytes, out_ctx->size);
@@ -637,9 +641,12 @@ static int xhci_set_configuration(struct usb_device *udev)
 	xhci_endpoint_copy(ctrl, in_ctx, out_ctx, 0);
 
 	/* filling up ep contexts */
-	err = xhci_init_ep_contexts_if(udev, ctrl, virt_dev, ifdesc);
-	if (err < 0)
-		return err;
+	for (ifnum = 0; ifnum < max_ifnum; ifnum++) {
+		ifdesc = &udev->config.if_desc[ifnum];
+		err = xhci_init_ep_contexts_if(udev, ctrl, virt_dev, ifdesc);
+		if (err < 0)
+			return err;
+	}
 
 	return xhci_configure_endpoints(udev, false);
 }
diff --git a/include/usb.h b/include/usb.h
index 09e3f0cb30..3aafdc8bfd 100644
--- a/include/usb.h
+++ b/include/usb.h
@@ -49,6 +49,12 @@ extern bool usb_started; /* flag for the started/stopped USB status */
  */
 #define USB_TIMEOUT_MS(pipe) (usb_pipebulk(pipe) ? 5000 : 1000)
 
+/*
+ * The xhcd hcd driver prepares only a limited number interfaces / endpoints.
+ * Define this limit so that drivers do not exceed it.
+ */
+#define USB_MAX_ACTIVE_INTERFACES	2
+
 /* device request (setup) */
 struct devrequest {
 	__u8	requesttype;

-- 
2.44.0


