Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AD4D0E6D2
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 12:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25B898403D;
	Tue, 25 Nov 2025 13:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ysoft.com header.i=@ysoft.com header.b="KqxZMG7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38DB983F88; Tue, 25 Nov 2025 09:58:58 +0100 (CET)
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 723DC83F89
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 09:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ysoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michal.vokac@ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=20160406-ysoft-com; t=1764061134;
 bh=nh1G4vmLOj1+rp478eAQAPxVysiDyG4wgGWuroHwNXY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KqxZMG7oQeX1L+McvMiSVnNf9G7WejrpnIsfycKMd8i0t7VNt8l0HvwWY4h/tLZkk
 Y6qtxq+ab5QZv37o78KppQVTIHFthWc3roZRz51pirLGDWml62Tmtn40G2tYLfLg3U
 uuoZ9PKi0jdmtoQr0MLvS+C/hmRhu8hmjdQLL+u0=
Received: from vokac-nb.ysoft.local (unknown [10.1.8.111])
 by uho.ysoft.cz (Postfix) with ESMTP id C7818A05D4;
 Tue, 25 Nov 2025 09:58:54 +0100 (CET)
From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: Marek Vasut <marex@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 =?UTF-8?q?Petr=20Bene=C5=A1?= <petr.benes@ysoft.com>,
 =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 2/2] usb: ci_udc: cosmetics: EP and requests debug info
Date: Tue, 25 Nov 2025 09:58:46 +0100
Message-ID: <20251125085846.507591-2-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125085846.507591-1-michal.vokac@ysoft.com>
References: <20251125085846.507591-1-michal.vokac@ysoft.com>
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

Make a note in an unexpected situation, e.g. queuing a request
on a disabled endpoint, enabling an enabled endpoint...

Signed-off-by: Petr Beneš <petr.benes@ysoft.com>
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 drivers/usb/gadget/ci_udc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index b3bbbb6ad32c..ea8939060efd 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -273,8 +273,10 @@ ci_ep_alloc_request(struct usb_ep *ep, unsigned int gfp_flags)
 	if (ci_ep->desc)
 		num = ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
 
-	if (num == 0 && controller.ep0_req)
+	if (num == 0 && controller.ep0_req) {
+		DBG("%s: already got controller.ep0_req = %p\n", __func__, controller.ep0_req);
 		return &controller.ep0_req->req;
+	}
 
 	ci_req = calloc(1, sizeof(*ci_req));
 	if (!ci_req)
@@ -296,6 +298,8 @@ static void ci_ep_free_request(struct usb_ep *ep, struct usb_request *req)
 
 	if (ci_ep->desc)
 		num = ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
+	else
+		DBG("%s: no endpoint %p descriptor\n", __func__, ci_ep);
 
 	if (num == 0) {
 		if (!controller.ep0_req)
@@ -622,8 +626,10 @@ static int ci_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 			break;
 	}
 
-	if (&ci_req->req != _req)
+	if (&ci_req->req != _req) {
+		DBG("%s: ci_req not found in the queue\n", __func__);
 		return -EINVAL;
+	}
 
 	list_del_init(&ci_req->queue);
 
-- 
2.43.0

