Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A66CD6D226
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 14:28:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49D1583E13;
	Thu, 18 Dec 2025 15:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ysoft.com header.i=@ysoft.com header.b="JRuFIzF7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA7CC83D8A; Thu, 18 Dec 2025 15:27:58 +0100 (CET)
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3A1883D07
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:27:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ysoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=petr.benes@ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=20160406-ysoft-com; t=1766068076;
 bh=Y+ZqAWJEJM1N+j01wkspEH8hR9Q9QEm5GMKMcNdyhs0=;
 h=From:To:Cc:Subject:Date:From;
 b=JRuFIzF7kmfFaWcK0pk0g3sxNnC+yT2pgMiIO4YM5HisUOPGSy7GTjePacCT4FcQ7
 bF7HaEWLFHoGUNTGRPn27HLPkUvIRmpkTS3dR+5HyDdITGLW5JF6aRXpnUMdH8pYuv
 KV5Zp6AR6J/M0+bv9QPR4iCp+0T08vkfbhK1yRXk=
Received: from slider.ysoft.local (unknown [10.1.2.235])
 by uho.ysoft.cz (Postfix) with ESMTP id 09591A0343;
 Thu, 18 Dec 2025 15:27:56 +0100 (CET)
From: =?UTF-8?q?Petr=20Bene=C5=A1?= <petr.benes@ysoft.com>
To: trini@konsulko.com,
	marex@denx.de
Cc: lukma@denx.de, mkorpershoek@kernel.org, u-boot@lists.denx.de,
 =?UTF-8?q?Petr=20Bene=C5=A1?= <petr.benes@ysoft.com>
Subject: [PATCH v2 1/2] usb: ci_udc: Check ci_ep->desc before use
Date: Thu, 18 Dec 2025 15:27:35 +0100
Message-ID: <20251218142737.3169753-1-petr.benes@ysoft.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

There are two places where ci_ep->desc could be accessed despite it is
not valid at that moment. Either the endpoint has not been enabled yet
or it has been disabled meanwhile (The ethernet gadged behaves this way
at least.). That results in dereferencing a null pointer.

Moreover, the patch gets rid of possible outstanding requests if the
endpoint's state changes to disabled.

Signed-off-by: Petr Beneš <petr.benes@ysoft.com>
---

v2: return values aligned with Linux as requested by Mattijs

 drivers/usb/gadget/ci_udc.c | 47 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 4bff75da759..c8953d48723 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -308,6 +308,27 @@ static void ci_ep_free_request(struct usb_ep *ep, struct usb_request *req)
 	free(ci_req);
 }
 
+static void request_complete(struct usb_ep *ep, struct ci_req *req, int status)
+{
+	if (req->req.status == -EINPROGRESS)
+		req->req.status = status;
+
+	DBG("%s: req %p complete: status %d, actual %u\n",
+	    ep->name, req, req->req.status, req->req.actual);
+
+	req->req.complete(ep, &req->req);
+}
+
+static void request_complete_list(struct usb_ep *ep, struct list_head *list, int status)
+{
+	struct ci_req *req, *tmp_req;
+
+	list_for_each_entry_safe(req, tmp_req, list, queue) {
+		list_del_init(&req->queue);
+		request_complete(ep, req, status);
+	}
+}
+
 static void ep_enable(int num, int in, int maxpacket)
 {
 	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
@@ -335,6 +356,12 @@ static int ci_ep_enable(struct usb_ep *ep,
 	int num, in;
 	num = desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
 	in = (desc->bEndpointAddress & USB_DIR_IN) != 0;
+
+	if (ci_ep->desc) {
+		DBG("%s: endpoint num %d in %d already enabled\n", __func__, num, in);
+		return -EBUSY;
+	}
+
 	ci_ep->desc = desc;
 	ep->desc = desc;
 
@@ -385,19 +412,32 @@ static int ep_disable(int num, int in)
 static int ci_ep_disable(struct usb_ep *ep)
 {
 	struct ci_ep *ci_ep = container_of(ep, struct ci_ep, ep);
+	LIST_HEAD(req_list);
 	int num, in, err;
 
+	if (!ci_ep->desc) {
+		DBG("%s: attempt to disable a not enabled yet endpoint\n", __func__);
+		err = -EBUSY;
+		goto nodesc;
+	}
+
 	num = ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
 	in = (ci_ep->desc->bEndpointAddress & USB_DIR_IN) != 0;
 
+	list_splice_init(&ci_ep->queue, &req_list);
+	request_complete_list(ep, &req_list, -ESHUTDOWN);
+
 	err = ep_disable(num, in);
 	if (err)
 		return err;
 
 	ci_ep->desc = NULL;
+	err = 0;
+
+nodesc:
 	ep->desc = NULL;
 	ci_ep->req_primed = false;
-	return 0;
+	return err;
 }
 
 static int ci_bounce(struct ci_req *ci_req, int in)
@@ -606,6 +646,11 @@ static int ci_ep_queue(struct usb_ep *ep,
 	int in, ret;
 	int __maybe_unused num;
 
+	if (!ci_ep->desc) {
+		DBG("%s: ci_ep->desc == NULL, nothing to do!\n", __func__);
+		return -EINVAL;
+	}
+
 	num = ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
 	in = (ci_ep->desc->bEndpointAddress & USB_DIR_IN) != 0;
 
-- 
2.52.0

