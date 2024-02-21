Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9096C48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 07:26:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A504688045;
	Wed, 21 Feb 2024 08:25:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SRmzZGaZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E20D8803A; Wed, 21 Feb 2024 08:25:31 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3951E87D7E
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 08:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BE12E61422;
 Wed, 21 Feb 2024 07:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69F16C433F1;
 Wed, 21 Feb 2024 07:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708500316;
 bh=SR67A0W4YoJGrmao7Gb3LDnBVA54UjmzP8uHFYkykUQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=SRmzZGaZG4CldjM37avaWg5qGewKv0m0dYRDbkgPgJJf2d8hF48kArbQUn2yBZcXI
 AAUPAbD/vm774KgSz2qSCvLYWAucF0s88ajJ0H1k+Yugzo3DpKdZ0DeKSvHM4ro4XB
 wzUR+hAzvYI0F8dLVi4m+HVJlQCluoIcAcR9CYF6h4gzGxgKyPqRuokudMaiIY+Dqz
 0YaWIIjwZ4H6L88ZIvQ/odWn4o7bABHFNZCdAo0+Dr3+MUNjNe8OcOnT0e05bAC5VB
 yrxIMqv2qSl0dzUcyK4zTWs5EMBo+ASS87c83I7yRnudWssG7PPhOHYXpFMgdB1BgN
 SLms0h1WilYCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE41C48BF6;
 Wed, 21 Feb 2024 07:25:16 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 21 Feb 2024 08:25:01 +0100
Subject: [PATCH 1/6] usb: xhci: refactor xhci_set_configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-asahi-keyboards-v1-1-814b2e741790@jannau.net>
References: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
In-Reply-To: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5762; i=j@jannau.net;
 h=from:subject:message-id; bh=1/CILs6YS604f8/kg2B/RmCvFHTAwqTpsn/kwsWX5d8=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtSrS6OELSc+Vk+smnj8MJd2tFqAlCnHqZLSKI9dSj+WB
 eWXM/3qKGVhEONikBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMJHWRob/5epzxNgvvV9fu2v7
 5DcnTKe+XLrHwq3noszXjfy6cqsYPzD8L743d3/nxOAsXjVTrYzLTw98sVNn61rFoLN/bYJnY9A
 sZgA=
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

In the next step endpoints for multiple interfaces are set up. Move most
of the per endpoint initialization to separate function to avoid another
identation level.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/usb/host/xhci.c | 119 +++++++++++++++++++++++++++++-------------------
 1 file changed, 73 insertions(+), 46 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index d13cbff9b3..534c4b973f 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -475,67 +475,34 @@ static int xhci_configure_endpoints(struct usb_device *udev, bool ctx_change)
 }
 
 /**
- * Configure the endpoint, programming the device contexts.
+ * Fill endpoint contexts for interface descriptor ifdesc.
  *
- * @param udev	pointer to the USB device structure
- * Return: returns the status of the xhci_configure_endpoints
+ * @param udev		pointer to the USB device structure
+ * @param ctrl		pointer to the xhci pravte device structure
+ * @param virt_dev	pointer to the xhci virtual device structure
+ * @param ifdesc	pointer to the USB interface config descriptor
+ * Return: returns the status of xhci_init_ep_contexts_if
  */
-static int xhci_set_configuration(struct usb_device *udev)
+static int xhci_init_ep_contexts_if(struct usb_device *udev,
+				    struct xhci_ctrl *ctrl,
+				    struct xhci_virt_device *virt_dev,
+				    struct usb_interface *ifdesc
+	)
 {
-	struct xhci_container_ctx *in_ctx;
-	struct xhci_container_ctx *out_ctx;
-	struct xhci_input_control_ctx *ctrl_ctx;
-	struct xhci_slot_ctx *slot_ctx;
 	struct xhci_ep_ctx *ep_ctx[MAX_EP_CTX_NUM];
 	int cur_ep;
-	int max_ep_flag = 0;
 	int ep_index;
 	unsigned int dir;
 	unsigned int ep_type;
-	struct xhci_ctrl *ctrl = xhci_get_ctrl(udev);
-	int num_of_ep;
-	int ep_flag = 0;
 	u64 trb_64 = 0;
-	int slot_id = udev->slot_id;
-	struct xhci_virt_device *virt_dev = ctrl->devs[slot_id];
-	struct usb_interface *ifdesc;
 	u32 max_esit_payload;
 	unsigned int interval;
 	unsigned int mult;
 	unsigned int max_burst;
 	unsigned int avg_trb_len;
 	unsigned int err_count = 0;
+	int num_of_ep = ifdesc->no_of_ep;
 
-	out_ctx = virt_dev->out_ctx;
-	in_ctx = virt_dev->in_ctx;
-
-	num_of_ep = udev->config.if_desc[0].no_of_ep;
-	ifdesc = &udev->config.if_desc[0];
-
-	ctrl_ctx = xhci_get_input_control_ctx(in_ctx);
-	/* Initialize the input context control */
-	ctrl_ctx->add_flags = cpu_to_le32(SLOT_FLAG);
-	ctrl_ctx->drop_flags = 0;
-
-	/* EP_FLAG gives values 1 & 4 for EP1OUT and EP2IN */
-	for (cur_ep = 0; cur_ep < num_of_ep; cur_ep++) {
-		ep_flag = xhci_get_ep_index(&ifdesc->ep_desc[cur_ep]);
-		ctrl_ctx->add_flags |= cpu_to_le32(1 << (ep_flag + 1));
-		if (max_ep_flag < ep_flag)
-			max_ep_flag = ep_flag;
-	}
-
-	xhci_inval_cache((uintptr_t)out_ctx->bytes, out_ctx->size);
-
-	/* slot context */
-	xhci_slot_copy(ctrl, in_ctx, out_ctx);
-	slot_ctx = xhci_get_slot_ctx(ctrl, in_ctx);
-	slot_ctx->dev_info &= ~(cpu_to_le32(LAST_CTX_MASK));
-	slot_ctx->dev_info |= cpu_to_le32(LAST_CTX(max_ep_flag + 1) | 0);
-
-	xhci_endpoint_copy(ctrl, in_ctx, out_ctx, 0);
-
-	/* filling up ep contexts */
 	for (cur_ep = 0; cur_ep < num_of_ep; cur_ep++) {
 		struct usb_endpoint_descriptor *endpt_desc = NULL;
 		struct usb_ss_ep_comp_descriptor *ss_ep_comp_desc = NULL;
@@ -561,7 +528,8 @@ static int xhci_set_configuration(struct usb_device *udev)
 		avg_trb_len = max_esit_payload;
 
 		ep_index = xhci_get_ep_index(endpt_desc);
-		ep_ctx[ep_index] = xhci_get_ep_ctx(ctrl, in_ctx, ep_index);
+		ep_ctx[ep_index] = xhci_get_ep_ctx(ctrl, virt_dev->in_ctx,
+						   ep_index);
 
 		/* Allocate the ep rings */
 		virt_dev->eps[ep_index].ring = xhci_ring_alloc(ctrl, 1, true);
@@ -614,6 +582,65 @@ static int xhci_set_configuration(struct usb_device *udev)
 		}
 	}
 
+	return 0;
+}
+
+/**
+ * Configure the endpoint, programming the device contexts.
+ *
+ * @param udev	pointer to the USB device structure
+ * Return: returns the status of the xhci_configure_endpoints
+ */
+static int xhci_set_configuration(struct usb_device *udev)
+{
+	struct xhci_container_ctx *out_ctx;
+	struct xhci_container_ctx *in_ctx;
+	struct xhci_input_control_ctx *ctrl_ctx;
+	struct xhci_slot_ctx *slot_ctx;
+	int err;
+	int cur_ep;
+	int max_ep_flag = 0;
+	struct xhci_ctrl *ctrl = xhci_get_ctrl(udev);
+	int num_of_ep;
+	int ep_flag = 0;
+	int slot_id = udev->slot_id;
+	struct xhci_virt_device *virt_dev = ctrl->devs[slot_id];
+	struct usb_interface *ifdesc;
+
+	out_ctx = virt_dev->out_ctx;
+	in_ctx = virt_dev->in_ctx;
+
+	num_of_ep = udev->config.if_desc[0].no_of_ep;
+	ifdesc = &udev->config.if_desc[0];
+
+	ctrl_ctx = xhci_get_input_control_ctx(in_ctx);
+	/* Initialize the input context control */
+	ctrl_ctx->add_flags = cpu_to_le32(SLOT_FLAG);
+	ctrl_ctx->drop_flags = 0;
+
+	/* EP_FLAG gives values 1 & 4 for EP1OUT and EP2IN */
+	for (cur_ep = 0; cur_ep < num_of_ep; cur_ep++) {
+		ep_flag = xhci_get_ep_index(&ifdesc->ep_desc[cur_ep]);
+		ctrl_ctx->add_flags |= cpu_to_le32(1 << (ep_flag + 1));
+		if (max_ep_flag < ep_flag)
+			max_ep_flag = ep_flag;
+	}
+
+	xhci_inval_cache((uintptr_t)out_ctx->bytes, out_ctx->size);
+
+	/* slot context */
+	xhci_slot_copy(ctrl, in_ctx, out_ctx);
+	slot_ctx = xhci_get_slot_ctx(ctrl, in_ctx);
+	slot_ctx->dev_info &= ~(cpu_to_le32(LAST_CTX_MASK));
+	slot_ctx->dev_info |= cpu_to_le32(LAST_CTX(max_ep_flag + 1) | 0);
+
+	xhci_endpoint_copy(ctrl, in_ctx, out_ctx, 0);
+
+	/* filling up ep contexts */
+	err = xhci_init_ep_contexts_if(udev, ctrl, virt_dev, ifdesc);
+	if (err < 0)
+		return err;
+
 	return xhci_configure_endpoints(udev, false);
 }
 

-- 
2.43.2

