Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA381C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB49088853;
	Tue, 23 Jul 2024 15:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="VnJNZFYI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C8C887C0; Tue, 23 Jul 2024 15:19:02 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A324E88813
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 15:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4266ea6a412so39671815e9.1
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 06:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721740729; x=1722345529;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BffhSfFFH7m2hR+x2MtsNlaofRjQXyE052NEDAF5rMg=;
 b=VnJNZFYIsIFVdGjLVxkZNEPxtpJiKoRCHow0g2G+pyuf48ZYn0lkn6b9jYke1F9vFO
 zn1sbTLZpvglRiW5hcyNu+6UjhBMMcxWX5fqgE6VbuKMHISqbgk/iZzpNKolY/USblgy
 3OdLmTtzKHJ5+gADh1QqDN78O13HiTiv6FfYLxC5MZca1IW8+irARSXEj6l0bfERsiXT
 Kv1QWBwisYkxREih0R6fa/FB3ouURhxc042X3YBKvPPZkkUbktCM+9gN1V1YH4UsgO5o
 ck24T+LC8A0DHkjUu2Bq6BwagmY219ipS4y5cnfe+4z1lZFA1c+LkKQRLxFFrNXq+7SK
 VC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721740729; x=1722345529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BffhSfFFH7m2hR+x2MtsNlaofRjQXyE052NEDAF5rMg=;
 b=m+uiCbKUZSiTR72KFsyrnkwI/8k1g2ZL9qvAPrVE4sJZUu9Fnuhd0YSon11SDt2Bzm
 p9GY0DKMcgJn3lwL5WN7AsRu2dBloxU0DWbcvVW49iUfrZD+AYXdGI2hIeRk4b5nRopO
 7hPCHcYyIP9reN2kc7euRLxJlR1pfEUtpkjPwmn0B+EuIAKc+j1glVlbSxZxEV74EN5x
 QYfbZkDHNq+2ZQsD3fE/ShHLJpCvuwD6bB3WWPfAgysPb7p9C6CUAbnJa8YGnIiG4ILK
 SUruojBqjM9B1GFNOQxbpO6OoB6z2vsYX9UWSFg+yOu/tAKiGbTGD5Zctnw+9gllK4Pr
 /Mog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAsD/M06mOkr3SYc32fVR+V8Ay2Yl/CDoTcSu1+3icvztbUEpceADjtALNPwkijqYx6NBANxHhIBqVqVQJM6jTGVRG6w==
X-Gm-Message-State: AOJu0Yx1cV5ONewpOlnU1iJID4WEPctLLr98cUracA12PNSKS2rFDmUy
 8cFMbraxZdmvuHZmJWa86jJR+VdwkRLrBfTedy8mhG1WK+p/dGBM665xbBz/65M=
X-Google-Smtp-Source: AGHT+IFk1pF0wFVOxUZXYQRPAZz5vLhn0EEtFc9+dxG0y9dR4RecJ450mLbOhTkIWaJr1BWLqlQCxw==
X-Received: by 2002:a05:600c:3148:b0:426:6416:aa7a with SMTP id
 5b1f17b1804b1-427dc59faeemr72385825e9.34.1721740729127; 
 Tue, 23 Jul 2024 06:18:49 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427db2a4e3bsm140312545e9.44.2024.07.23.06.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 06:18:48 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
X-Google-Original-From: Zixun LI <zli@ogga.fr>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>,
	u-boot@lists.denx.de
Subject: [PATCH v3 4/7] usb: gadget: atmel: Move usba_udc_pdata() with other
 static functions
Date: Tue, 23 Jul 2024 15:18:11 +0200
Message-ID: <20240723131817.262596-5-zli@ogga.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723131817.262596-1-zli@ogga.fr>
References: <20240723131817.262596-1-zli@ogga.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jul 2024 15:35:56 +0200
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

Signed-off-by: Zixun LI <zli@ogga.fr>
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

