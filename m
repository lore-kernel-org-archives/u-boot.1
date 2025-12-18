Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AADBD6D226
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 14:28:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B1F083D8A;
	Thu, 18 Dec 2025 15:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ysoft.com header.i=@ysoft.com header.b="p/++4yrj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A081683E0E; Thu, 18 Dec 2025 15:27:58 +0100 (CET)
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B222A83D8A
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:27:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ysoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=petr.benes@ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=20160406-ysoft-com; t=1766068076;
 bh=8pTNN66nGhK3fscbig/NwKj58Bw9ipZ5Q+WxQX3Nprs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=p/++4yrji24TsUIKY9VkDGj34wi3S9VfNzOcyxWd1iQ2tTr7u6Gp2cBQru3U3wMja
 qOsHLHSMwXLMQyZ3KGjGGWdgeG6mcF/kUBTwW/Wdv1TuoczolNVRFCosLIr2fhA1Nr
 y379CffhgQ8JKL2QrdhL/YO4dyTCGL04TsN6sal8=
Received: from slider.ysoft.local (unknown [10.1.2.235])
 by uho.ysoft.cz (Postfix) with ESMTP id 2B524A03C4;
 Thu, 18 Dec 2025 15:27:56 +0100 (CET)
From: =?UTF-8?q?Petr=20Bene=C5=A1?= <petr.benes@ysoft.com>
To: trini@konsulko.com,
	marex@denx.de
Cc: lukma@denx.de, mkorpershoek@kernel.org, u-boot@lists.denx.de,
 =?UTF-8?q?Petr=20Bene=C5=A1?= <petr.benes@ysoft.com>
Subject: [PATCH v2 2/2] usb: ci_udc: cosmetics: EP and requests debug info
Date: Thu, 18 Dec 2025 15:27:36 +0100
Message-ID: <20251218142737.3169753-2-petr.benes@ysoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218142737.3169753-1-petr.benes@ysoft.com>
References: <20251218142737.3169753-1-petr.benes@ysoft.com>
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

Make a note in an unexpected situation, e.g. queuing a request
on a disabled endpoint, enabling an enabled endpoint...

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Petr Beneš <petr.benes@ysoft.com>
---

v2: no changes

 drivers/usb/gadget/ci_udc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index c8953d48723..046bb335ecb 100644
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
@@ -624,8 +628,10 @@ static int ci_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 			break;
 	}
 
-	if (&ci_req->req != _req)
+	if (&ci_req->req != _req) {
+		DBG("%s: ci_req not found in the queue\n", __func__);
 		return -EINVAL;
+	}
 
 	list_del_init(&ci_req->queue);
 
-- 
2.52.0

