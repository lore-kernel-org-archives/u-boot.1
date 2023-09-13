Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AD6EE020A
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 19:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FF1E86BAE;
	Wed, 13 Sep 2023 21:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="ehR10KSR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 705228667A; Wed, 13 Sep 2023 17:01:59 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D6108693D
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 17:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5029ace4a28so1269201e87.1
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 08:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1694617313; x=1695222113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C/lKdOvpiLz+eh4q9dVSxndmjoCPIl8wWYpIWxK8UB0=;
 b=ehR10KSRNvh6SkiTbyBdUomD4HF+BKPFsuxedU/Lp7z7WXVzcppkHrEiR/0TpCXKMI
 9tZgjOX2HzBjK/6sb5cU1QSjbfo06RlHfvarbpUlyl/6QphiXXWz3zoE6316rT8X8bPK
 MkmlAWcgFwlPD5qAajKq8+QCwf8zCqPnUMNcZG87TSuJAWCHW6dJj7TLJahHsqW8EAE7
 WcIShvnIDgvjIXPg9f2tnsC/LR7Hl/D0It0HAGrueLXvxAxczG58b9zUxnnh8Q0UEgqG
 11CFmKCUJ3UAQWOjnMOBw0FOuaQEti0r3tCI0BzzckN7QDphaQRLgwUs6GxM8C4nhmqw
 O8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694617313; x=1695222113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C/lKdOvpiLz+eh4q9dVSxndmjoCPIl8wWYpIWxK8UB0=;
 b=rNjyIuqFFE6GN9E8HPUwHK9FmnAVq+UgZvLYvyw5Yvy/oIvGWRfCPkp3CumDuocBDI
 +90GzvCP62q9jenVVwdTCRuY3oEyaE2qlk+AHNwi+y2FHDTI/USqJWffsRFo8kEgBv4p
 Bg3tY8hLt9ccWyHZLCX7QmQ7709PspvEIFEAMACzf7Wg3rUOdeMqOFHDS9g2wZeJWXDw
 ViMwSOyCTJqxtwGfiMXzDTz8WNv7uHCZIhWkQL+TYzFwZfi/52pw12jWZBuDttsSoc6k
 g4UyUrLT6oYsC8SuTAiIvsI99m9g/VU3175s9uRXror2Ifc2Jie472+gd/bLZ0uYoxEC
 CS/g==
X-Gm-Message-State: AOJu0YzYfa96yaBkBrqybrrQHHJoqPFJp3yHWaWmKYHxKXrm8uXn7QoZ
 J0ERG/n97eRzVeBuHrwMeWAi+g==
X-Google-Smtp-Source: AGHT+IGsLd0bhkjjZqh0SbC/s85bvV0OIpdvmwZbH9rW3Pme4nssLDZSEcUs/leF8liGikmn1Rj6/A==
X-Received: by 2002:a05:6512:159e:b0:500:af82:7ddc with SMTP id
 bp30-20020a056512159e00b00500af827ddcmr2374690lfb.28.1694617313458; 
 Wed, 13 Sep 2023 08:01:53 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 f19-20020a05651232d300b00502a96484absm1817341lfg.99.2023.09.13.08.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 08:01:52 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Lukasz Majewski <lukma@denx.de>,
	Marek Vasut <marex@denx.de>
Cc: Jakub Klama <jakub@conclusive.pl>,
 Wojciech Kloska <wojciech@conclusive.pl>, u-boot@lists.denx.de,
 Artur Rojek <artur@conclusive.pl>
Subject: [PATCH] USB: gadget: atmel: fix transfer of queued requests
Date: Wed, 13 Sep 2023 17:00:58 +0200
Message-ID: <20230913150058.38972-1-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 Sep 2023 21:37:45 +0200
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

In the existing implementation, multiple requests queued up on an
endpoint are subject to getting evicted without transmission.

For both control and bulk endpoints, their respective logic found in
usba_control_irq()/usba_ep_irq() guarantees that TX FIFO is empty before
data is sent out, and that request_complete() gets called once the
transaction has been finished. At this point however, if any additional
requests are found on the endpoint queue, they will be processed by
submit_next_request(), which makes no checks against the above
conditions, trashing data on a busy FIFO and neglecting completion
handlers.

Fix the above issues by removing the calls to submit_next_request(),
and thus forcing the pending requests to be processed on the next pass
of the respective endpoint logic. While at it, remove a DBG message, as
that branch becomes part of regular flow.

This restores mass storage mode operation on Microchip ATSAMA5D27 SoC.

Signed-off-by: Artur Rojek <artur@conclusive.pl>
---
 drivers/usb/gadget/atmel_usba_udc.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 7d51821497b4..e6b458d940d8 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -57,13 +57,9 @@ static void submit_request(struct usba_ep *ep, struct usba_request *req)
 	req->submitted = 1;
 
 	next_fifo_transaction(ep, req);
-	if (req->last_transaction) {
-		usba_ep_writel(ep, CTL_DIS, USBA_TX_PK_RDY);
-		usba_ep_writel(ep, CTL_ENB, USBA_TX_COMPLETE);
-	} else {
+	if (ep_is_control(ep))
 		usba_ep_writel(ep, CTL_DIS, USBA_TX_COMPLETE);
-		usba_ep_writel(ep, CTL_ENB, USBA_TX_PK_RDY);
-	}
+	usba_ep_writel(ep, CTL_ENB, USBA_TX_PK_RDY);
 }
 
 static void submit_next_request(struct usba_ep *ep)
@@ -889,7 +885,6 @@ restart:
 			if (req) {
 				list_del_init(&req->queue);
 				request_complete(ep, req, 0);
-				submit_next_request(ep);
 			}
 			usba_ep_writel(ep, CTL_DIS, USBA_TX_COMPLETE);
 			ep->state = WAIT_FOR_SETUP;
@@ -1036,7 +1031,6 @@ static void usba_ep_irq(struct usba_udc *udc, struct usba_ep *ep)
 		DBG(DBG_BUS, "%s: TX PK ready\n", ep->ep.name);
 
 		if (list_empty(&ep->queue)) {
-			DBG(DBG_INT, "ep_irq: queue empty\n");
 			usba_ep_writel(ep, CTL_DIS, USBA_TX_PK_RDY);
 			return;
 		}
@@ -1050,7 +1044,6 @@ static void usba_ep_irq(struct usba_udc *udc, struct usba_ep *ep)
 
 		if (req->last_transaction) {
 			list_del_init(&req->queue);
-			submit_next_request(ep);
 			request_complete(ep, req, 0);
 		}
 
-- 
2.42.0

