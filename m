Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA03C5DF8E
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B175F60F8B;
	Fri, 21 Aug 2026 13:18:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7EwmYDKSwXqz; Fri, 21 Aug 2026 13:18:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318153;
	bh=xaBqxyC+Jjh9e0kBNOWUOuyumSWEXIk9qbZ6rpBSa7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sOHHdOEeaO85/tbLv13WH5tX61okdalJRrrNe2SohZMQ14N5+FJo5bpuWF+vh0o5J
	 i6cmOYiYQU3p/VZJbg60UTbcd1vGSPLLVUKC9iYYoIL/Uj0Q/K3W8I5Fu93x6EQszv
	 AL7PAtaFFiWqklcFC1SOHHwtY+YEeSPHwFCqkQtBqDiUcS3t6c+6U84nx2SEOyKSjJ
	 A5rCF14aG+LLjNbs4tDLhesDf+H6/kAiKHnWrx9usxRKasrHlNB6p5//ofZjUM9PES
	 2FIpjmp+1YD1+hzY60c1RAdG4A/Y+TKScu8DhqOh0S1FFBUDdEtYKh3yO+FWp4Krh8
	 4f4wrzNYLYnAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11A5160A81;
	Fri, 21 Aug 2026 13:15:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 24C882B2
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 12F0981013
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Np06NDWCImAw for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=l4UoB/8H
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B68448100F
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:41 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c160d8760e0so7687966b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302360; x=1787907160;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xaBqxyC+Jjh9e0kBNOWUOuyumSWEXIk9qbZ6rpBSa7E=;
 b=l4UoB/8Hyk2grBgeRjmB3LDY9lfHrQFj6gu5BjsEAFEuS13JGzcqKa1LgmrxVIUvni
 ANkzrMZ3mupOIKur2dltpFSO4pnCl/eyqxCUx1owJMWz5tBX4TuljUDmo/MbSeKTq1UY
 8WF8QfN5nw3s80qgLQk3t3qYHBbyAFt000s+8Jhpndb0ekCrbvlGls6jK5mTGY1doqxE
 khfbuu6MQg5eOQrNhVVSNE2CW43gazmzzGlq52OzINr5aE+v8paSY5AQeKscjvo/Exhw
 1XDEjawT/3P6WWJrOD9mvAhZr3hfek0VLcz8XLZ08524Sf3y36uS5Pj4d6kOiiHTHiRC
 06XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302360; x=1787907160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xaBqxyC+Jjh9e0kBNOWUOuyumSWEXIk9qbZ6rpBSa7E=;
 b=OAoIJEZiolBplCsXzG8UsZSdexiRcdKJTHmI9onIclyZWRJmytJ8SwC4UA9QeavRm1
 g4yjhaGCKqZyA4AFmddSZgWEosU+HVpOFYs7z3AtLeI2LePKUn3zD7CHidlCgwQ05wO6
 mlTBYRpAaagi+++P4pw6UDdD0/7h8s6AC0hC4D4W0h1641kNE61IdrunM2pvcSTK6sHU
 Q5wsspcSmDVP1RpdNmzvK7qQlYrxGhYPS0CuyGT27du13a38rSeYh54y4nN1RaECqgan
 +NxpSKgS0xBRo5m77prTES60h7ntoefH1YMsm3eLoBmsx+j48ycJI9L10NyvTZQk43iL
 J2yQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJ7DR78eS1dVYLs5LU3gtfor3RLSpbaQsxqqyHFaiEhNVgWl6W6nK80m+6eIK63QjneEaJtZ4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lNgHygSIAaiSMxkhD+t+XwkN7m3P0tBd6ANjc/SjV/M421i/eD
 R4z07UI1LSUX467CVQsT/zi04RKnZHVWIurEiPi2AXdbhK/pDI+kNVQ/Q8s3RoLKm38=
X-Gm-Gg: AR+sD10fVAs7f/+eCqNG8VdBmg9mGteP6FGg+IO1dUWFGO3FG3t70g8lGw3hvrLxZkv
 3Nuu1oET/5/CgCZ757JJnQknIAIQj8X/RcdK9rfnMyg8RGl+DiOJ4EUT7s3rJ5kTkEd9YpCSMzI
 I/svKmWcpQzxZi+dcjP/FyJB+K4yVbLzQq4GAsZNaDjJIfmilE88mKrJFlK0EtfJSVxi/LVERgx
 qiS3Xt8QxrZUAtvz3is8Ricqxn+wJSfkKfZ670Voc5ivH5siiedUvymmBvgSLqCcUtm4eKVhUgK
 yAlTBypn90S8h+kGGND1usNHfkuQtsEYRPyYhPNiajkzU9bumr89dsIwTJg+nSDTGXRNocQtWo4
 oq1a8AuN744zpUdFu5Hat1FmCK7rX4b1XI7aWXAiHw641wDzZmgY26j8QhO7u9YXxeUg6ERYeX0
 Otmtxu0l91SWFFybZTdRaQj0cpGIAI6MdsgZENATwmQI8gNujugC5y5pipvc4frynwzlDjX+9P2
 FH7iH1GsmQ4TUmzxz2lqqi8
X-Received: by 2002:a17:907:d0c:b0:c20:38e2:b355 with SMTP id
 a640c23a62f3a-c246a6c97c1mr232540466b.4.1787302359548; 
 Fri, 21 Aug 2026 01:52:39 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24589e1ac0sm348878766b.11.2026.08.21.01.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:39 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 Eddie Cai <eddie.cai.linux@gmail.com>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 77/87] usb: gadget: fix up the function drivers after the
 resync
Date: Fri, 21 Aug 2026 10:47:53 +0200
Message-ID: <20260821084829.2070426-78-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:41 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Adapt the gadget function drivers (acm, fastboot, mass_storage, rockusb,
sdp, thor, ether and composite) to the new gadget API.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/composite.c      |  2 +-
 drivers/usb/gadget/ether.c          | 21 ++++++++++++++-------
 drivers/usb/gadget/f_acm.c          | 20 +++++++++++---------
 drivers/usb/gadget/f_fastboot.c     | 10 +++++-----
 drivers/usb/gadget/f_mass_storage.c |  5 ++++-
 drivers/usb/gadget/f_rockusb.c      | 11 ++++++-----
 drivers/usb/gadget/f_sdp.c          | 12 ++++++++----
 drivers/usb/gadget/f_thor.c         | 19 +++++++++----------
 8 files changed, 58 insertions(+), 42 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 04b85419931e..060788419553 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -833,7 +833,7 @@ static int bos_desc(struct usb_composite_dev *cdev)
 
 		/* Get Controller configuration */
 		if (cdev->gadget->ops->get_config_params) {
-			cdev->gadget->ops->get_config_params(
+			cdev->gadget->ops->get_config_params(cdev->gadget,
 				&dcd_config_params);
 		} else {
 			dcd_config_params.bU1devExitLat =
diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
index 7973927e8a7f..13a20441419d 100644
--- a/drivers/usb/gadget/ether.c
+++ b/drivers/usb/gadget/ether.c
@@ -925,8 +925,9 @@ set_ether_config(struct eth_dev *dev, gfp_t gfp_flags)
 		dev->status = ep_desc(gadget, &hs_status_desc,
 						&fs_status_desc);
 		dev->status_ep->driver_data = dev;
+		dev->status_ep->desc = dev->status;
 
-		result = usb_ep_enable(dev->status_ep, dev->status);
+		result = usb_ep_enable(dev->status_ep);
 		if (result != 0) {
 			debug("enable %s --> %d\n",
 				dev->status_ep->name, result);
@@ -951,14 +952,16 @@ set_ether_config(struct eth_dev *dev, gfp_t gfp_flags)
 	 * from REMOTE_NDIS_HALT_MSG, reset from REMOTE_NDIS_RESET_MSG.
 	 */
 	if (!cdc_active(dev)) {
-		result = usb_ep_enable(dev->in_ep, dev->in);
+		dev->in_ep->desc = dev->in;
+		result = usb_ep_enable(dev->in_ep);
 		if (result != 0) {
 			debug("enable %s --> %d\n",
 				dev->in_ep->name, result);
 			goto done;
 		}
 
-		result = usb_ep_enable(dev->out_ep, dev->out);
+		dev->out_ep->desc = dev->out;
+		result = usb_ep_enable(dev->out_ep);
 		if (result != 0) {
 			debug("enable %s --> %d\n",
 				dev->out_ep->name, result);
@@ -1156,7 +1159,8 @@ static void issue_start_status(struct eth_dev *dev)
 	 * FIXME iff req->context != null just dequeue it
 	 */
 	usb_ep_disable(dev->status_ep);
-	usb_ep_enable(dev->status_ep, dev->status);
+	dev->status_ep->desc = dev->status;
+	usb_ep_enable(dev->status_ep);
 
 	/*
 	 * 3.8.1 says to issue first NETWORK_CONNECTION, then
@@ -1314,7 +1318,8 @@ eth_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 				break;
 			if (dev->status) {
 				usb_ep_disable(dev->status_ep);
-				usb_ep_enable(dev->status_ep, dev->status);
+				dev->status_ep->desc = dev->status;
+				usb_ep_enable(dev->status_ep);
 			}
 
 			value = 0;
@@ -1333,8 +1338,10 @@ eth_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			if (wValue == 1) {
 				if (!cdc_active(dev))
 					break;
-				usb_ep_enable(dev->in_ep, dev->in);
-				usb_ep_enable(dev->out_ep, dev->out);
+				dev->in_ep->desc = dev->in;
+				usb_ep_enable(dev->in_ep);
+				dev->out_ep->desc = dev->out;
+				usb_ep_enable(dev->out_ep);
 				dev->cdc_filter = DEFAULT_FILTER;
 				if (dev->status)
 					issue_start_status(dev);
diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index b6c11d97a62d..5f5400bab7ec 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -325,20 +325,20 @@ static struct usb_request *acm_start_ep(struct usb_ep *ep, void *complete_cb,
 
 static int acm_start_data(struct f_acm *f_acm, struct usb_gadget *gadget)
 {
-	const struct usb_endpoint_descriptor *d;
 	int ret;
 
 	/* EP IN */
-	d = ep_desc(gadget, &acm_hs_in_desc, &acm_fs_in_desc);
-	ret = usb_ep_enable(f_acm->ep_in, d);
+	f_acm->ep_in->desc = ep_desc(gadget, &acm_hs_in_desc, &acm_fs_in_desc);
+	ret = usb_ep_enable(f_acm->ep_in);
 	if (ret)
 		return ret;
 
 	f_acm->req_in = acm_start_ep(f_acm->ep_in, acm_tx_complete, f_acm);
 
 	/* EP OUT */
-	d = ep_desc(gadget, &acm_hs_out_desc, &acm_fs_out_desc);
-	ret = usb_ep_enable(f_acm->ep_out, d);
+	f_acm->ep_out->desc = ep_desc(gadget, &acm_hs_out_desc,
+				      &acm_fs_out_desc);
+	ret = usb_ep_enable(f_acm->ep_out);
 	if (ret)
 		return ret;
 
@@ -354,12 +354,11 @@ static int acm_start_data(struct f_acm *f_acm, struct usb_gadget *gadget)
 
 static int acm_start_ctrl(struct f_acm *f_acm, struct usb_gadget *gadget)
 {
-	const struct usb_endpoint_descriptor *d;
-
 	usb_ep_disable(f_acm->ep_notify);
 
-	d = ep_desc(gadget, &acm_hs_notify_desc, &acm_fs_notify_desc);
-	usb_ep_enable(f_acm->ep_notify, d);
+	f_acm->ep_notify->desc = ep_desc(gadget, &acm_hs_notify_desc,
+					 &acm_fs_notify_desc);
+	usb_ep_enable(f_acm->ep_notify);
 
 	acm_start_ep(f_acm->ep_notify, acm_notify_complete, f_acm);
 
@@ -454,6 +453,9 @@ static void acm_disable(struct usb_function *f)
 	usb_ep_disable(f_acm->ep_out);
 	usb_ep_disable(f_acm->ep_in);
 	usb_ep_disable(f_acm->ep_notify);
+	f_acm->ep_out->desc = NULL;
+	f_acm->ep_in->desc = NULL;
+	f_acm->ep_notify->desc = NULL;
 
 	if (f_acm->req_out) {
 		free(f_acm->req_out->buf);
diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 8df0e3f331d1..e1eed5fa4cb4 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -320,13 +320,13 @@ static int fastboot_set_alt(struct usb_function *f,
 	struct usb_composite_dev *cdev = f->config->cdev;
 	struct usb_gadget *gadget = cdev->gadget;
 	struct f_fastboot *f_fb = func_to_fastboot(f);
-	const struct usb_endpoint_descriptor *d;
 
 	debug("%s: func: %s intf: %d alt: %d\n",
 	      __func__, f->name, interface, alt);
 
-	d = fb_ep_desc(gadget, &fs_ep_out, &hs_ep_out, &ss_ep_out);
-	ret = usb_ep_enable(f_fb->out_ep, d);
+	f_fb->out_ep->desc = fb_ep_desc(gadget, &fs_ep_out, &hs_ep_out,
+					&ss_ep_out);
+	ret = usb_ep_enable(f_fb->out_ep);
 	if (ret) {
 		puts("failed to enable out ep\n");
 		return ret;
@@ -340,8 +340,8 @@ static int fastboot_set_alt(struct usb_function *f,
 	}
 	f_fb->out_req->complete = rx_handler_command;
 
-	d = fb_ep_desc(gadget, &fs_ep_in, &hs_ep_in, &ss_ep_in);
-	ret = usb_ep_enable(f_fb->in_ep, d);
+	f_fb->in_ep->desc = fb_ep_desc(gadget, &fs_ep_in, &hs_ep_in, &ss_ep_in);
+	ret = usb_ep_enable(f_fb->in_ep);
 	if (ret) {
 		puts("failed to enable in ep\n");
 		goto err;
diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index 7eb667c130d2..22a1352b6d2b 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -2159,7 +2159,8 @@ static int enable_endpoint(struct fsg_common *common, struct usb_ep *ep,
 	int	rc;
 
 	ep->driver_data = common;
-	rc = usb_ep_enable(ep, d);
+	ep->desc = d;
+	rc = usb_ep_enable(ep);
 	if (rc)
 		ERROR(common, "can't enable %s, result %d\n", ep->name, rc);
 	return rc;
@@ -2206,10 +2207,12 @@ reset:
 		/* Disable the endpoints */
 		if (fsg->bulk_in_enabled) {
 			usb_ep_disable(fsg->bulk_in);
+			fsg->bulk_in->desc = NULL;
 			fsg->bulk_in_enabled = 0;
 		}
 		if (fsg->bulk_out_enabled) {
 			usb_ep_disable(fsg->bulk_out);
+			fsg->bulk_out->desc = NULL;
 			fsg->bulk_out_enabled = 0;
 		}
 
diff --git a/drivers/usb/gadget/f_rockusb.c b/drivers/usb/gadget/f_rockusb.c
index d679cdae97c8..37957b202f8c 100644
--- a/drivers/usb/gadget/f_rockusb.c
+++ b/drivers/usb/gadget/f_rockusb.c
@@ -202,6 +202,8 @@ static void rockusb_disable(struct usb_function *f)
 
 	usb_ep_disable(f_rkusb->out_ep);
 	usb_ep_disable(f_rkusb->in_ep);
+	f_rkusb->out_ep->desc = NULL;
+	f_rkusb->in_ep->desc = NULL;
 
 	if (f_rkusb->out_req) {
 		free(f_rkusb->out_req->buf);
@@ -246,13 +248,12 @@ static int rockusb_set_alt(struct usb_function *f, unsigned int interface,
 	struct usb_composite_dev *cdev = f->config->cdev;
 	struct usb_gadget *gadget = cdev->gadget;
 	struct f_rockusb *f_rkusb = func_to_rockusb(f);
-	const struct usb_endpoint_descriptor *d;
 
 	debug("%s: func: %s intf: %d alt: %d\n",
 	      __func__, f->name, interface, alt);
 
-	d = rkusb_ep_desc(gadget, &fs_ep_out, &hs_ep_out);
-	ret = usb_ep_enable(f_rkusb->out_ep, d);
+	f_rkusb->out_ep->desc = rkusb_ep_desc(gadget, &fs_ep_out, &hs_ep_out);
+	ret = usb_ep_enable(f_rkusb->out_ep);
 	if (ret) {
 		printf("failed to enable out ep\n");
 		return ret;
@@ -266,8 +267,8 @@ static int rockusb_set_alt(struct usb_function *f, unsigned int interface,
 	}
 	f_rkusb->out_req->complete = rx_handler_command;
 
-	d = rkusb_ep_desc(gadget, &fs_ep_in, &hs_ep_in);
-	ret = usb_ep_enable(f_rkusb->in_ep, d);
+	f_rkusb->in_ep->desc = rkusb_ep_desc(gadget, &fs_ep_in, &hs_ep_in);
+	ret = usb_ep_enable(f_rkusb->in_ep);
 	if (ret) {
 		printf("failed to enable in ep\n");
 		goto err;
diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index cd2c282247ac..0bb386053258 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -625,12 +625,14 @@ static int sdp_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 	debug("%s: intf: %d alt: %d\n", __func__, intf, alt);
 
 	if (gadget_is_dualspeed(gadget) && gadget->speed == USB_SPEED_HIGH) {
-		result = usb_ep_enable(sdp->in_ep, &in_hs_desc);
-		result |= usb_ep_enable(sdp->out_ep, &out_hs_desc);
+		sdp->in_ep->desc = &in_hs_desc;
+		sdp->out_ep->desc = &out_hs_desc;
 	} else {
-		result = usb_ep_enable(sdp->in_ep, &in_desc);
-		result |= usb_ep_enable(sdp->out_ep, &out_desc);
+		sdp->in_ep->desc = &in_hs_desc;
+		sdp->out_ep->desc = &out_hs_desc;
 	}
+	result = usb_ep_enable(sdp->in_ep);
+	result |= usb_ep_enable(sdp->out_ep);
 	if (result)
 		return result;
 
@@ -662,6 +664,8 @@ static void sdp_disable(struct usb_function *f)
 
 	usb_ep_disable(sdp->in_ep);
 	usb_ep_disable(sdp->out_ep);
+	sdp->in_ep->desc = NULL;
+	sdp->out_ep->desc = NULL;
 
 	if (sdp->in_req) {
 		free(sdp->in_req->buf);
diff --git a/drivers/usb/gadget/f_thor.c b/drivers/usb/gadget/f_thor.c
index 540b9f882378..210537d51e92 100644
--- a/drivers/usb/gadget/f_thor.c
+++ b/drivers/usb/gadget/f_thor.c
@@ -909,16 +909,15 @@ static int thor_eps_setup(struct usb_function *f)
 	struct usb_composite_dev *cdev = f->config->cdev;
 	struct usb_gadget *gadget = cdev->gadget;
 	struct thor_dev *dev = thor_func->dev;
-	struct usb_endpoint_descriptor *d;
 	struct usb_request *req;
 	struct usb_ep *ep;
 	int result;
 
 	ep = dev->in_ep;
-	d = ep_desc(gadget, &hs_in_desc, &fs_in_desc);
-	debug("(d)bEndpointAddress: 0x%x\n", d->bEndpointAddress);
+	ep->desc = ep_desc(gadget, &hs_in_desc, &fs_in_desc);
+	debug("(d)bEndpointAddress: 0x%x\n", ep->desc->bEndpointAddress);
 
-	result = usb_ep_enable(ep, d);
+	result = usb_ep_enable(ep);
 	if (result)
 		goto err;
 
@@ -933,10 +932,10 @@ static int thor_eps_setup(struct usb_function *f)
 	req->complete = thor_rx_tx_complete;
 	dev->in_req = req;
 	ep = dev->out_ep;
-	d = ep_desc(gadget, &hs_out_desc, &fs_out_desc);
-	debug("(d)bEndpointAddress: 0x%x\n", d->bEndpointAddress);
+	ep->desc = ep_desc(gadget, &hs_out_desc, &fs_out_desc);
+	debug("(d)bEndpointAddress: 0x%x\n", ep->desc->bEndpointAddress);
 
-	result = usb_ep_enable(ep, d);
+	result = usb_ep_enable(ep);
 	if (result)
 		goto err_free_in_req;
 
@@ -951,10 +950,10 @@ static int thor_eps_setup(struct usb_function *f)
 	dev->out_req = req;
 	/* ACM control EP */
 	ep = dev->int_ep;
-	d = ep_desc(gadget, &hs_int_desc, &fs_int_desc);
-	debug("(d)bEndpointAddress: 0x%x\n", d->bEndpointAddress);
+	ep->desc = ep_desc(gadget, &hs_int_desc, &fs_int_desc);
+	debug("(d)bEndpointAddress: 0x%x\n", ep->desc->bEndpointAddress);
 
-	result = usb_ep_enable(ep, d);
+	result = usb_ep_enable(ep);
 	if (result)
 		goto err;
 
-- 
2.53.0

