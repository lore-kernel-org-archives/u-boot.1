Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDFDC48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 13:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F14BC87F5C;
	Mon, 19 Feb 2024 14:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XhX26c9W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FDBD87F65; Mon, 19 Feb 2024 14:17:19 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99E4587F57
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 14:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-512b13bf764so1190689e87.0
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 05:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708348631; x=1708953431; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SpLF8tu450ap4xrTD417ebbFZDwJ5+r7mhRn8H/t4QI=;
 b=XhX26c9Wzgee9Fcu9lyRNBhUUglBvEa5uPcH5GnYdIzo4uAkIcfWp6A/ZVuWYW8FOB
 iUxo+W7kpECfYjCPJa1NIENvspVPSZT2jdfku8TRk+l4orbPMhQESYE+t/f7lugAsux8
 9QU4C8Ffof9Ocv/VtK0HfSG7/3ti/ACkwvMj2u/CamqqdsPt6GttGBFP5Ifn7V5p6qZX
 yYD3jZ+o7C2c3UyeLD5kHwxkkWNhQzyQMjURhTk5GEvkoCosixcju3bbFMGg+uhYVi/+
 qvdFEZNpJmZK10zH1kv9sdmn+fvSTnJiag/WnLbfzq3r9Gb/i/eZBu0dAKGYFtwaZPCu
 tc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708348631; x=1708953431;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SpLF8tu450ap4xrTD417ebbFZDwJ5+r7mhRn8H/t4QI=;
 b=aCi4a9F3l44jZOu8HGzgBPaTetdA2UxUWAthpivEn+e73Uvkhds60q+hXltwvf6cl1
 mH9m9db3p/BXlUeuXUHbM/stmJ0KH2yL679Wrf3QBswNN2cmde7Vc3z6AhyX2MmMo0db
 ciqAsUhiO+4UvR8hpRTwpHGLJARt3ed7GJou1oXiLRSUzET+wfuidOLLbvzj8vFiJE3I
 Sn25KNtAadWCI4lbWcvSDgkqVTOY1W7P6RO5nle93+yfJGOczb74Qh3Wl1uGZSJ6JQpW
 sqKM6TsH8SNRHoSEWMOomg0K1a/EfWIJIxBlfSfa95mabbq0V5hTljBCbFSFwrKeOINd
 xjbA==
X-Gm-Message-State: AOJu0Ywx/0Dz2XQofLY50TcXZ3YNnKNEfSx0co+8aBC0Jk383dXhNJG0
 7vqpz1WtIaVifWzKPpcOqtBENhrK2fznJYjXeCIpWkPwjTeZrh7h//FR/j9regE=
X-Google-Smtp-Source: AGHT+IEwqcbN3901wKdS+xvwROT7A20jCVwYSh70QsyhSiskTXLiwR81v6xLA06wkfRjnpfRVLeH4Q==
X-Received: by 2002:ac2:5925:0:b0:512:aa8a:a91c with SMTP id
 v5-20020ac25925000000b00512aa8aa91cmr3301632lfi.45.1708348630811; 
 Mon, 19 Feb 2024 05:17:10 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-232.as13285.net.
 [92.17.96.232]) by smtp.gmail.com with ESMTPSA id
 z10-20020a1c4c0a000000b00410794ddfc6sm11230542wmf.35.2024.02.19.05.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 05:17:10 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Marek Vasut <marex@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH] usb: dwc3: add newlines to dev_vdbg calls in ep0
Date: Mon, 19 Feb 2024 13:16:29 +0000
Message-ID: <20240219131702.2025678-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.43.1
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

For some reason none of these debug prints have newlines, resulting in a
"fun" surprise when attempting to debug this driver.

The other parts of the dwc3 driver have newlines, add them here too (and
fix some minor nearby indent issues to make checkpatch happy).

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/usb/dwc3/ep0.c | 46 +++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 1133cf82b1ae..16b11ce3d9fa 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -60,9 +60,9 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
 	int				ret;
 
 	dep = dwc->eps[epnum];
 	if (dep->flags & DWC3_EP_BUSY) {
-		dev_vdbg(dwc->dev, "%s still busy", dep->name);
+		dev_vdbg(dwc->dev, "%s still busy\n", dep->name);
 		return 0;
 	}
 
 	trb = &dwc->ep0_trb[dep->free_slot];
@@ -237,11 +237,11 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 		ret = -EBUSY;
 		goto out;
 	}
 
-	dev_vdbg(dwc->dev, "queueing request %p to %s length %d state '%s'",
-			request, dep->name, request->length,
-			dwc3_ep0_state_string(dwc->ep0state));
+	dev_vdbg(dwc->dev, "queueing request %p to %s length %d state '%s\n'",
+		 request, dep->name, request->length,
+		 dwc3_ep0_state_string(dwc->ep0state));
 
 	ret = __dwc3_gadget_ep0_queue(dep, req);
 
 out:
@@ -696,37 +696,37 @@ static int dwc3_ep0_std_request(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	int ret;
 
 	switch (ctrl->bRequest) {
 	case USB_REQ_GET_STATUS:
-		dev_vdbg(dwc->dev, "USB_REQ_GET_STATUS");
+		dev_vdbg(dwc->dev, "USB_REQ_GET_STATUS\n");
 		ret = dwc3_ep0_handle_status(dwc, ctrl);
 		break;
 	case USB_REQ_CLEAR_FEATURE:
-		dev_vdbg(dwc->dev, "USB_REQ_CLEAR_FEATURE");
+		dev_vdbg(dwc->dev, "USB_REQ_CLEAR_FEATURE\n");
 		ret = dwc3_ep0_handle_feature(dwc, ctrl, 0);
 		break;
 	case USB_REQ_SET_FEATURE:
-		dev_vdbg(dwc->dev, "USB_REQ_SET_FEATURE");
+		dev_vdbg(dwc->dev, "USB_REQ_SET_FEATURE\n");
 		ret = dwc3_ep0_handle_feature(dwc, ctrl, 1);
 		break;
 	case USB_REQ_SET_ADDRESS:
-		dev_vdbg(dwc->dev, "USB_REQ_SET_ADDRESS");
+		dev_vdbg(dwc->dev, "USB_REQ_SET_ADDRESS\n");
 		ret = dwc3_ep0_set_address(dwc, ctrl);
 		break;
 	case USB_REQ_SET_CONFIGURATION:
-		dev_vdbg(dwc->dev, "USB_REQ_SET_CONFIGURATION");
+		dev_vdbg(dwc->dev, "USB_REQ_SET_CONFIGURATION\n");
 		ret = dwc3_ep0_set_config(dwc, ctrl);
 		break;
 	case USB_REQ_SET_SEL:
-		dev_vdbg(dwc->dev, "USB_REQ_SET_SEL");
+		dev_vdbg(dwc->dev, "USB_REQ_SET_SEL\n");
 		ret = dwc3_ep0_set_sel(dwc, ctrl);
 		break;
 	case USB_REQ_SET_ISOCH_DELAY:
-		dev_vdbg(dwc->dev, "USB_REQ_SET_ISOCH_DELAY");
+		dev_vdbg(dwc->dev, "USB_REQ_SET_ISOCH_DELAY\n");
 		ret = dwc3_ep0_set_isoch_delay(dwc, ctrl);
 		break;
 	default:
-		dev_vdbg(dwc->dev, "Forwarding to gadget driver");
+		dev_vdbg(dwc->dev, "Forwarding to gadget driver\n");
 		ret = dwc3_ep0_delegate_req(dwc, ctrl);
 		break;
 	}
 
@@ -910,19 +910,19 @@ static void dwc3_ep0_xfer_complete(struct dwc3 *dwc,
 	dwc->setup_packet_pending = false;
 
 	switch (dwc->ep0state) {
 	case EP0_SETUP_PHASE:
-		dev_vdbg(dwc->dev, "Setup Phase");
+		dev_vdbg(dwc->dev, "Setup Phase\n");
 		dwc3_ep0_inspect_setup(dwc, event);
 		break;
 
 	case EP0_DATA_PHASE:
-		dev_vdbg(dwc->dev, "Data Phase");
+		dev_vdbg(dwc->dev, "Data Phase\n");
 		dwc3_ep0_complete_data(dwc, event);
 		break;
 
 	case EP0_STATUS_PHASE:
-		dev_vdbg(dwc->dev, "Status Phase");
+		dev_vdbg(dwc->dev, "Status Phase\n");
 		dwc3_ep0_complete_status(dwc, event);
 		break;
 	default:
 		WARN(true, "UNKNOWN ep0state %d\n", dwc->ep0state);
@@ -1046,9 +1046,9 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 	dwc->setup_packet_pending = true;
 
 	switch (event->status) {
 	case DEPEVT_STATUS_CONTROL_DATA:
-		dev_vdbg(dwc->dev, "Control Data");
+		dev_vdbg(dwc->dev, "Control Data\n");
 
 		/*
 		 * We already have a DATA transfer in the controller's cache,
 		 * if we receive a XferNotReady(DATA) we will ignore it, unless
@@ -1060,9 +1060,9 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 		 */
 		if (dwc->ep0_expect_in != event->endpoint_number) {
 			struct dwc3_ep	*dep = dwc->eps[dwc->ep0_expect_in];
 
-			dev_vdbg(dwc->dev, "Wrong direction for Data phase");
+			dev_vdbg(dwc->dev, "Wrong direction for Data phase\n");
 			dwc3_ep0_end_control_data(dwc, dep);
 			dwc3_ep0_stall_and_restart(dwc);
 			return;
 		}
@@ -1072,15 +1072,15 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 	case DEPEVT_STATUS_CONTROL_STATUS:
 		if (dwc->ep0_next_event != DWC3_EP0_NRDY_STATUS)
 			return;
 
-		dev_vdbg(dwc->dev, "Control Status");
+		dev_vdbg(dwc->dev, "Control Status\n");
 
 		dwc->ep0state = EP0_STATUS_PHASE;
 
 		if (dwc->delayed_status) {
 			WARN_ON_ONCE(event->endpoint_number != 1);
-			dev_vdbg(dwc->dev, "Delayed Status");
+			dev_vdbg(dwc->dev, "Delayed Status\n");
 			return;
 		}
 
 		dwc3_ep0_do_control_status(dwc, event);
@@ -1091,12 +1091,12 @@ void dwc3_ep0_interrupt(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event)
 {
 	u8			epnum = event->endpoint_number;
 
-	dev_dbg(dwc->dev, "%s while ep%d%s in state '%s'",
-			dwc3_ep_event_string(event->endpoint_event),
-			epnum >> 1, (epnum & 1) ? "in" : "out",
-			dwc3_ep0_state_string(dwc->ep0state));
+	dev_dbg(dwc->dev, "%s while ep%d%s in state '%s'\n",
+		dwc3_ep_event_string(event->endpoint_event),
+		epnum >> 1, (epnum & 1) ? "in" : "out",
+		dwc3_ep0_state_string(dwc->ep0state));
 
 	switch (event->endpoint_event) {
 	case DWC3_DEPEVT_XFERCOMPLETE:
 		dwc3_ep0_xfer_complete(dwc, event);
-- 
2.43.1

