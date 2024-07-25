Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A34C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 17:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5425F88365;
	Thu, 25 Jul 2024 19:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="lM/IbLiI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD457881C1; Thu, 25 Jul 2024 17:32:31 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EB9C87E23
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 17:32:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3683178b226so644051f8f.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 08:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721921548; x=1722526348;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=acZK1tg4Ja1m+QHkZYLbmpxbLdAKqfb13cIarcwj1c0=;
 b=lM/IbLiIyYRr5+rQX1OA/U3rbmcSAbpwz6R3+VtN+MU+Y3SXkTKRdIOFzNAXfkof93
 /4xlXqstWt76o3OX4YL6m9xg4etYjEc1s5koMNNnDu3cSLvnNyysyDBSBvMduUQm8Kn8
 +Rpy8xGo3foLY5Vt08Vwwag1i1mJI7+HitbjafhZoHyesJ5AZ1F41qvIttAX/bJ7rBX4
 ERv9dt8gz0648Ywn2QeTrP6OLUxHivXhmnG9627A1KDArllYvhNxCM9dBgX5G4KlY98C
 lbyGiePVLZ5DnS2cDXNam9vGRmF0gNhjTDlZovYMDn4Dh5nBn1bnUtaaSqDyTVny+naQ
 2yJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721921548; x=1722526348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=acZK1tg4Ja1m+QHkZYLbmpxbLdAKqfb13cIarcwj1c0=;
 b=sDyC4ginevs8dSRFwqVULqSz/QBV6S+pbsyCD4eN9hEVHpE+ad+caxBgnJI+JG9tHT
 2I0T1T2CeqCalcM/eenEFBsrXlAxO58zZV2AtFjjN1aQfn3nQeYnBPN3tSsdqoODcEQt
 jCkPUJeGJH1s8uZvJvHqlIh16tVFRMt2eCeEJHrPwxStHOh88oka/eEEw7gXUM+j2mVf
 cERekqcdK7CWsmeCFPNmAskIJMhma7OAfjvoKS7p5hEmBmwYoGrG1G3XT17PzJHLmnci
 7gIQPV2wXIdq6dzS7tvMpIwM3Nt3jPbjp7bNEbkjghgSCebegqrDIt57kDPcm2DHre4d
 Xisw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl6JM7Cid9nWxdlhdXIPNlzl6xcyidYSCXyP9GcgmAM0xmJ+qsZ3b7ucIFjDaY10SiStCNwyv5NLrxSgI6qm0JAvt3zw==
X-Gm-Message-State: AOJu0YwqL9mQfEYPgwIKTu6jzrqu9sOU2gYbWHPQQgW0y7KC55TyoNKF
 y8mJW8LOU8QGXUQVbqOBy3+FioxEMVqljcQfkwM+MxCYgmYLMcpY6nzDVWfvU2U=
X-Google-Smtp-Source: AGHT+IHq5VPRLX+tT3ljNgWruv1YFrPRB4i4vRSErjk7mgakY+kZMJVFjD5itBLCxZK1rDEngAV90Q==
X-Received: by 2002:adf:e744:0:b0:368:6562:9024 with SMTP id
 ffacd0b85a97d-36b3638a0b1mr1646405f8f.18.1721921547934; 
 Thu, 25 Jul 2024 08:32:27 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36b36861b54sm2530805f8f.95.2024.07.25.08.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 08:32:27 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH v4 4/7] usb: gadget: atmel: Move usba_udc_pdata() with other
 static functions
Date: Thu, 25 Jul 2024 17:31:58 +0200
Message-ID: <20240725153204.358925-5-admin@hifiphile.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725153204.358925-1-admin@hifiphile.com>
References: <20240725153204.358925-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jul 2024 19:14:03 +0200
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

To make all static functions in the top, no functional change.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/usb/gadget/atmel_usba_udc.c | 80 ++++++++++++++---------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 2e3d8f36a2..a3d24501ba 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1179,6 +1179,46 @@ static int atmel_usba_stop(struct usba_udc *udc)
 	return 0;
 }
 
+static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
+				      struct usba_udc *udc)
+{
+	struct usba_ep *eps;
+	int i;
+
+	eps = malloc(sizeof(struct usba_ep) * pdata->num_ep);
+	if (!eps) {
+		log_err("failed to alloc eps\n");
+		return NULL;
+	}
+
+	udc->gadget.ep0 = &eps[0].ep;
+
+	INIT_LIST_HEAD(&udc->gadget.ep_list);
+	INIT_LIST_HEAD(&eps[0].ep.ep_list);
+
+	for (i = 0; i < pdata->num_ep; i++) {
+		struct usba_ep *ep = &eps[i];
+
+		ep->ep_regs = udc->regs + USBA_EPT_BASE(i);
+		ep->dma_regs = udc->regs + USBA_DMA_BASE(i);
+		ep->fifo = udc->fifo + USBA_FIFO_BASE(i);
+		ep->ep.ops = &usba_ep_ops;
+		ep->ep.name = pdata->ep[i].name;
+		ep->ep.maxpacket = pdata->ep[i].fifo_size;
+		ep->fifo_size = ep->ep.maxpacket;
+		ep->udc = udc;
+		INIT_LIST_HEAD(&ep->queue);
+		ep->nr_banks = pdata->ep[i].nr_banks;
+		ep->index = pdata->ep[i].index;
+		ep->can_dma = pdata->ep[i].can_dma;
+		ep->can_isoc = pdata->ep[i].can_isoc;
+		if (i)
+			list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
+	};
+
+	return eps;
+}
+
 static struct usba_udc controller = {
 	.regs = (unsigned *)ATMEL_BASE_UDPHS,
 	.fifo = (unsigned *)ATMEL_BASE_UDPHS_FIFO,
@@ -1244,46 +1284,6 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	return 0;
 }
 
-static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
-				      struct usba_udc *udc)
-{
-	struct usba_ep *eps;
-	int i;
-
-	eps = malloc(sizeof(struct usba_ep) * pdata->num_ep);
-	if (!eps) {
-		log_err("failed to alloc eps\n");
-		return NULL;
-	}
-
-	udc->gadget.ep0 = &eps[0].ep;
-
-	INIT_LIST_HEAD(&udc->gadget.ep_list);
-	INIT_LIST_HEAD(&eps[0].ep.ep_list);
-
-	for (i = 0; i < pdata->num_ep; i++) {
-		struct usba_ep *ep = &eps[i];
-
-		ep->ep_regs = udc->regs + USBA_EPT_BASE(i);
-		ep->dma_regs = udc->regs + USBA_DMA_BASE(i);
-		ep->fifo = udc->fifo + USBA_FIFO_BASE(i);
-		ep->ep.ops = &usba_ep_ops;
-		ep->ep.name = pdata->ep[i].name;
-		ep->ep.maxpacket = pdata->ep[i].fifo_size;
-		ep->fifo_size = ep->ep.maxpacket;
-		ep->udc = udc;
-		INIT_LIST_HEAD(&ep->queue);
-		ep->nr_banks = pdata->ep[i].nr_banks;
-		ep->index = pdata->ep[i].index;
-		ep->can_dma = pdata->ep[i].can_dma;
-		ep->can_isoc = pdata->ep[i].can_isoc;
-		if (i)
-			list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
-	};
-
-	return eps;
-}
-
 int usba_udc_probe(struct usba_platform_data *pdata)
 {
 	struct usba_udc *udc;
-- 
2.45.2

