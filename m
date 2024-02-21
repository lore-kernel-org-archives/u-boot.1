Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C58C48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 07:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13BC587FB0;
	Wed, 21 Feb 2024 08:26:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="De39rTZi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3072587FE7; Wed, 21 Feb 2024 08:25:46 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B76B788022
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 08:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 41173CE1C69;
 Wed, 21 Feb 2024 07:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A064C43390;
 Wed, 21 Feb 2024 07:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708500316;
 bh=Ry+xFiW7Ja/sbnD/CiKpiEN9ElRw0jmqW7igWzHC8aQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=De39rTZinFoWH7LnP6UjRbkSz5aR5PeOvMPSA0B3txuQnBUuthnFuXnvDPBl0bPMU
 FJ2q8SScVrhZWAsYqo9Vu6sCTnXMW4nJ2EBDY30ncmFbM2ZCV1+Oc5Rh2SAgBgn6dl
 vz5W7aQ3fnez26F/IAFPgDa4QJCyM5GazCdDbgqz6Rl3rbigrttEst8f+A0N+zgT6h
 YIODEB9Yg4MLekoVKQXTgF/ANZ/3rkDJuBkV+cfWaDP3KyT6EYf0BTkiJEUIHSJ0YQ
 hX/lYdBUhgriieCP/7b1+EpWOY3SA2Js70i6bsemkYQQWCC5OA6YuzHyiSuegardvk
 /+XcEJMUa3Gsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 5C26BC54788;
 Wed, 21 Feb 2024 07:25:16 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 21 Feb 2024 08:25:02 +0100
Subject: [PATCH 2/6] usb: xhci: Set up endpoints for the first 2 interfaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-asahi-keyboards-v1-2-814b2e741790@jannau.net>
References: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
In-Reply-To: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3079; i=j@jannau.net;
 h=from:subject:message-id; bh=Hj57V9gw7i+OPqRqLUJzvo8kdj4VAIBRQ+iShMSucUY=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtSrS6OqXdxVdsSVHGJmPSOuWnI25ZSr/VYO03U/zNS4N
 t7Z4buoo5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwETefWVkWMHdZBdRGByvqjK9
 40Ka3nve7L8te3wyeA4xyyv/V4gpZ/jDz1P3ndFiznydi1yqvNc0SyQfB0b2Tv3VaNnTyl33t5I
 VAA==
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

Apple USB keyboards carry the HID keyboard boot protocol on the second
interface. Using the second interface in the USB keyboard driver does
not work since the xhci has not allocated a transfer ring.
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
2.43.2

