Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B22C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 276C6882DB;
	Tue, 18 Jun 2024 17:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i9yEqntt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C05C988335; Tue, 18 Jun 2024 17:04:14 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A58FA8824C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 17:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57c7ec8f1fcso6638426a12.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 08:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718723052; x=1719327852; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I6k/llMz5NpkEdwpC+zZzbKfmNAEMZsbwu/xAqjJ1Yc=;
 b=i9yEqnttMhXQKkekmhB2lYNr52ZmRlTsKvxYvp/gEumrn3LfhKVK3wxuBUCS1QwqiW
 c0zfc/E3vCKH3eVFVkl2oUs/drHa5zjD4EApgiIpw+VhzaJY41H6oABBb5fyhrGjwbkw
 9JNYSh9DLOcmjoqGVuhr3YECNtk9g0GBUaJarVv1MGRJjuaXy7e1kQk3ylUWJo6jLWkf
 lTst4KMqhj+JWcPRgP9sQ0p6kSNVygclVyOTrWmSu/PNsxl2R/mTcS8x+fHIkRwHSv0c
 VPH2MYGn6/TV8T5zXqQa51bq20Nk2th+ZmgNNpfAie643ulH1uGxU44S89KQGz95lvh1
 IKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718723052; x=1719327852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I6k/llMz5NpkEdwpC+zZzbKfmNAEMZsbwu/xAqjJ1Yc=;
 b=rLk0oYqjgn1j0JeG91tto8hbn1dB6TyYDmMPfq7VHTehxdOSDU7TzHTPjeV3/SAeZS
 LEEXpdAteGpYYwqEWvuinKDFodvaZP9wdqbqlPrk+PtfAemVzaLWeo3Smp9e45qKz4q8
 rD8pYBU2C1V/qcwE5IOffi/dH39orHl0xcETLu1si1SiXPR45TaAE3Mv33m9362m6uNc
 Ffc1TPprNIKx1T+G1qh5mlmBgNm77vlQCJ9+RcR9dBTSFWJlctrjRSvSsc3aMWAJAmpu
 A3+PYAmBymJB4Y+g1OAt8Jo31FFQAwhpAyCeaS6OaFNpJ/qUCBL6851+HrCxkOgFuJUr
 pjmg==
X-Gm-Message-State: AOJu0YyceSnPZHDT/epK2RW/6imhVtA4yZJgP3Yp2Eey6P+YcwfswPKc
 nv/5g66RGOLt2o7ia77FQFKHxG3DIuPGQ0vJtfpowk1K0YmTI+7WFccfnen1gbg=
X-Google-Smtp-Source: AGHT+IFxUS5pYI0O2ob0WkSGS34r4uFiPnl4VicPP8Z3nbdUCp/vYkfROhKyOAQWs3Ga7HAEJI6CSQ==
X-Received: by 2002:a05:6402:12cc:b0:57c:73a4:925d with SMTP id
 4fb4d7f45d1cf-57cbd6a864amr7573205a12.40.1718723051798; 
 Tue, 18 Jun 2024 08:04:11 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::52af])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72da6fdsm7855388a12.31.2024.06.18.08.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 08:04:11 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [RESEND PATCH] usb: dwc3: add newlines to dev_vdbg calls in ep0
Date: Tue, 18 Jun 2024 17:03:43 +0200
Message-ID: <20240618150359.3306514-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.45.0
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
Rebased on latest next, no changes
---
 drivers/usb/dwc3/ep0.c | 46 +++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 117d38a0340b..24f516a131b7 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -59,9 +59,9 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
 	int				ret;
 
 	dep = dwc->eps[epnum];
 	if (dep->flags & DWC3_EP_BUSY) {
-		dev_vdbg(dwc->dev, "%s still busy", dep->name);
+		dev_vdbg(dwc->dev, "%s still busy\n", dep->name);
 		return 0;
 	}
 
 	trb = &dwc->ep0_trb[dep->free_slot];
@@ -236,11 +236,11 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
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
@@ -695,37 +695,37 @@ static int dwc3_ep0_std_request(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
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
 
@@ -909,19 +909,19 @@ static void dwc3_ep0_xfer_complete(struct dwc3 *dwc,
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
@@ -1045,9 +1045,9 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 	dwc->setup_packet_pending = true;
 
 	switch (event->status) {
 	case DEPEVT_STATUS_CONTROL_DATA:
-		dev_vdbg(dwc->dev, "Control Data");
+		dev_vdbg(dwc->dev, "Control Data\n");
 
 		/*
 		 * We already have a DATA transfer in the controller's cache,
 		 * if we receive a XferNotReady(DATA) we will ignore it, unless
@@ -1059,9 +1059,9 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 		 */
 		if (dwc->ep0_expect_in != event->endpoint_number) {
 			struct dwc3_ep	*dep = dwc->eps[dwc->ep0_expect_in];
 
-			dev_vdbg(dwc->dev, "Wrong direction for Data phase");
+			dev_vdbg(dwc->dev, "Wrong direction for Data phase\n");
 			dwc3_ep0_end_control_data(dwc, dep);
 			dwc3_ep0_stall_and_restart(dwc);
 			return;
 		}
@@ -1071,15 +1071,15 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
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
@@ -1090,12 +1090,12 @@ void dwc3_ep0_interrupt(struct dwc3 *dwc,
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
2.45.0

