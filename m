Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E2FC27C53
	for <u-boot@archiver.kernel.org>; Sun,  9 Jun 2024 21:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A469388403;
	Sun,  9 Jun 2024 23:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nushY76d";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iCEbdnCP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A35588416; Sun,  9 Jun 2024 23:35:23 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D3C883FE
 for <u-boot@lists.denx.de>; Sun,  9 Jun 2024 23:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Vy7Ws22sYz9sdZ;
 Sun,  9 Jun 2024 23:35:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717968921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=chNbM11akyTzx7T3xBK8D9J9+D/dqCxtMTyJXgEiN78=;
 b=nushY76dps/QJvkd0+EKHpB76Mv2RgnPTrXL6eQt7CHebJEVt+OYSOMmtV3doLPlcD/QuS
 kc9PqxWSL9oYSsOKXdeQ59zehNr9yuRzyk/hOH9xwm50hdfuJi+RQA4nBAT7zg5mEtnwW/
 9ISejkm1go2fA2uGlD9UKlP1TNnhNSjotGKPLa2/SSihzjA/HMVPlbevSETnBnfa6iyipk
 qygOKFMueefi93+13nz+HnebsBw/CuWEsKhAOHjlrCL4OxKGaKT2MyBgBdDuXwsTP24kaV
 Jj7KFOW4nJx3C6sGqr5SyghQZaVvUZb70QuWoo3DQv99scUIEwFXqVfbmR1buQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717968919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=chNbM11akyTzx7T3xBK8D9J9+D/dqCxtMTyJXgEiN78=;
 b=iCEbdnCPrkbGBCT9Xl3QBZGkdIiehwjPChlNB1MABTlwt2BA4O7Crp06OZKqOvsrDYjp3B
 2pg+SUA2k5C3NhY+98DJm+CfgGayfjeso6AIdb0nvqSxXf4kpuh8Ad/rpN3OZWTQmTb+97
 Ci+rF9BazaTMCw4xjDfyzILTUFZyUNiX/yoV5d+SFb1hc7caDr7WqY+3SI8r+DPJvBJnyu
 94gAaXxP2GWb4dnGKC6O9pGnh3Tmdaj50VQo6fQ/aSrTJCwCW9YoGQ+sa02eWtzH8EzJ7V
 2oGys8uMhAxPeyUGcNS/3/1vpXOhak+h5wOil/8/kvmz3wrdOCR01m4lVMA5kA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/6] usb: dwc3: gadget: Convert epautoconf workaround to
 match_ep callback
Date: Sun,  9 Jun 2024 23:32:19 +0200
Message-ID: <20240609213449.194762-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
References: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: pqxuqrk4g9kdsr3oz4giemhnub7adowd
X-MBO-RS-ID: 69762b4dc41a12c8b3a
X-Rspamd-Queue-Id: 4Vy7Ws22sYz9sdZ
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

Use the .match_ep() callback instead of workaround in core code.
Replace descriptor parsing with ch9 macros with the same effect.
Drop the SPL specific behavior, it is unclear why SPL should even
be special.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/usb/dwc3/gadget.c       | 33 +++++++++++++++++++++++
 drivers/usb/gadget/epautoconf.c | 46 +--------------------------------
 2 files changed, 34 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index fab32575647..3ef2f016a60 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1606,6 +1606,38 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 	return 0;
 }
 
+static struct usb_ep *dwc3_find_ep(struct usb_gadget *gadget, const char *name)
+{
+	struct usb_ep *ep;
+
+	list_for_each_entry(ep, &gadget->ep_list, ep_list)
+		if (!strcmp(ep->name, name))
+			return ep;
+
+	return NULL;
+}
+
+static struct
+usb_ep *dwc3_gadget_match_ep(struct usb_gadget *gadget,
+			     struct usb_endpoint_descriptor *desc,
+			     struct usb_ss_ep_comp_descriptor *comp_desc)
+{
+	/*
+	 * First try standard, common configuration: ep1in-bulk,
+	 * ep2out-bulk, ep3in-int to match other udc drivers to avoid
+	 * confusion in already deployed software (endpoint numbers
+	 * hardcoded in userspace software/drivers)
+	 */
+	if (usb_endpoint_is_bulk_in(desc))
+		return dwc3_find_ep(gadget, "ep1in");
+	if (usb_endpoint_is_bulk_out(desc))
+		return dwc3_find_ep(gadget, "ep2out");
+	if (usb_endpoint_is_int_in(desc))
+		return dwc3_find_ep(gadget, "ep3in");
+
+	return NULL;
+}
+
 static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.get_frame		= dwc3_gadget_get_frame,
 	.wakeup			= dwc3_gadget_wakeup,
@@ -1613,6 +1645,7 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.pullup			= dwc3_gadget_pullup,
 	.udc_start		= dwc3_gadget_start,
 	.udc_stop		= dwc3_gadget_stop,
+	.match_ep		= dwc3_gadget_match_ep,
 };
 
 /* -------------------------------------------------------------------------- */
diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 66599ce8efa..a4da4f72de9 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -166,18 +166,6 @@ static int ep_matches(
 	return 1;
 }
 
-static struct usb_ep *
-find_ep(struct usb_gadget *gadget, const char *name)
-{
-	struct usb_ep	*ep;
-
-	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
-		if (0 == strcmp(ep->name, name))
-			return ep;
-	}
-	return NULL;
-}
-
 /**
  * usb_ep_autoconfig - choose an endpoint matching the descriptor
  * @gadget: The device to which the endpoint must belong.
@@ -213,39 +201,7 @@ struct usb_ep *usb_ep_autoconfig(
 	struct usb_endpoint_descriptor	*desc
 )
 {
-	struct usb_ep	*ep = NULL;
-	u8		type;
-
-	type = desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK;
-
-	/* First, apply chip-specific "best usage" knowledge.
-	 * This might make a good usb_gadget_ops hook ...
-	 */
-	if (!IS_ENABLED(CONFIG_SPL_BUILD) &&
-	    IS_ENABLED(CONFIG_USB_DWC3_GADGET) &&
-	    !strcmp("dwc3-gadget", gadget->name)) {
-		const char *name = NULL;
-		/*
-		 * First try standard, common configuration: ep1in-bulk,
-		 * ep2out-bulk, ep3in-int to match other udc drivers to avoid
-		 * confusion in already deployed software (endpoint numbers
-		 * hardcoded in userspace software/drivers)
-		 */
-		if ((desc->bEndpointAddress & USB_DIR_IN) &&
-		    type == USB_ENDPOINT_XFER_BULK)
-			name = "ep1in";
-		else if ((desc->bEndpointAddress & USB_DIR_IN) == 0 &&
-			 type == USB_ENDPOINT_XFER_BULK)
-			name = "ep2out";
-		else if ((desc->bEndpointAddress & USB_DIR_IN) &&
-			 type == USB_ENDPOINT_XFER_INT)
-			name = "ep3in";
-
-		if (name)
-			ep = find_ep(gadget, name);
-		if (ep && ep_matches(gadget, ep, desc))
-			return ep;
-	}
+	struct usb_ep *ep;
 
 	if (gadget->ops->match_ep) {
 		ep = gadget->ops->match_ep(gadget, desc, NULL);
-- 
2.43.0

