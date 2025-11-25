Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51547D0E6D1
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 12:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D960284011;
	Tue, 25 Nov 2025 13:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ysoft.com header.i=@ysoft.com header.b="BoRmdMv0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7381D83FA5; Tue, 25 Nov 2025 09:58:57 +0100 (CET)
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7127783F88
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 09:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ysoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michal.vokac@ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=20160406-ysoft-com; t=1764061134;
 bh=h5KeBNM/BEt32P9rAxI7OxvtKcke6+g4xcchlapbsBk=;
 h=From:To:Cc:Subject:Date:From;
 b=BoRmdMv0hb+IuFnptrjhTW1ky6DfB/dlNRZnxuCiqL6sfShpFNYRRdkzxXPZgu1nZ
 TIQ2MOaTFYoFscPBUnqn3oe/rIjCu5qk0GWP4NFLGyyeffY7EVHIQcY2oMJLg6v1qY
 EfVdQCA8W8HbFOaq0EJntNk/UVtFjGxgRZBOq3Xs=
Received: from vokac-nb.ysoft.local (unknown [10.1.8.111])
 by uho.ysoft.cz (Postfix) with ESMTP id A15B4A01C0;
 Tue, 25 Nov 2025 09:58:54 +0100 (CET)
From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: Marek Vasut <marex@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 =?UTF-8?q?Petr=20Bene=C5=A1?= <petr.benes@ysoft.com>,
 =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 1/2] usb: ci_udc: Check ci_ep->desc before use
Date: Tue, 25 Nov 2025 09:58:45 +0100
Message-ID: <20251125085846.507591-1-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Nov 2025 13:41:17 +0100
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

From: Petr Beneš <petr.benes@ysoft.com>

There are two places where ci_ep->desc could be accessed despite it is
not valid at that moment. Either the endpoint has not been enabled yet
or it has been disabled meanwhile (The ethernet gadged behaves this way
at least.). That results in dereferencing a null pointer.

Moreover, the patch gets rid of possible outstanding requests if the
endpoint's state changes to disabled.

Signed-off-by: Petr Beneš <petr.benes@ysoft.com>
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 drivers/usb/gadget/ci_udc.c | 43 +++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 4bff75da759d..b3bbbb6ad32c 100644
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
+		return 0;
+	}
+
 	ci_ep->desc = desc;
 	ep->desc = desc;
 
@@ -385,16 +412,27 @@ static int ep_disable(int num, int in)
 static int ci_ep_disable(struct usb_ep *ep)
 {
 	struct ci_ep *ci_ep = container_of(ep, struct ci_ep, ep);
+	LIST_HEAD(req_list);
 	int num, in, err;
 
+	if (!ci_ep->desc) {
+		DBG("%s: attempt to disable a not enabled yet endpoint\n", __func__);
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
+
+nodesc:
 	ep->desc = NULL;
 	ci_ep->req_primed = false;
 	return 0;
@@ -606,6 +644,11 @@ static int ci_ep_queue(struct usb_ep *ep,
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
2.43.0

