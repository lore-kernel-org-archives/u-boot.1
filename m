Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDD9CF6D2C
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 14:40:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 122DF890CE;
	Wed,  2 Oct 2024 16:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yZhOz94h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8711B890CE; Wed,  2 Oct 2024 16:39:41 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0532D890B7
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 16:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cde6b5094so61107235e9.3
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 07:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727879977; x=1728484777; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XbaWVpPZ0AENYL/jANVAHR/JFi93NTFANsG7ICTg4Ck=;
 b=yZhOz94hDVulakdphKEbPgiqPI5b0VSuxpX0g24u1KrvYxHvL+mRsPP2TgIaoVNN2X
 n3IyQ8IqcSkL5drtbeoUOskPUAQVbxFRfALdEQmWKE6xxEPClQfkFw9K6Aw5v/nyFPy0
 bReF7zLxnXeZ6HZ4+fXS38EVaCqq8djsFowS2MWjFNLv3vJsoK9qXT7g8FjXfXdo4B4z
 FevOuWP2pAPfTIdFJYFBlcTEWuffuCWfVAjZsJPDXeKl5/KtxoayMRCq3oAgcW9Gyi1j
 miPqYCw44stRF6LRBETeFv/77O4XnX38a8gUKXioKidOSs1VJpBx3eKSu9jplxMml4N4
 fVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727879977; x=1728484777;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XbaWVpPZ0AENYL/jANVAHR/JFi93NTFANsG7ICTg4Ck=;
 b=De03viTK2gcshzDyI4cQFR/hZ5iV8/oOqm8Qytzdqfy/mHmS0qfIVTlw25Y967RZYj
 SnIM5bYJUnfoS6+ixYXZxFJvIbh4JuU3RIGrt0nGDklAW+UopsWD1h1lTKbVl1lrR90b
 6pCT1Iajc+vDYOHunAdrnt8ZeZvndB0942WR1KQ4NaZ2RZ8YPUE7PacCKb8spoez4Q2b
 wcaa69VMp2+wpD7LnLJ1rB4yi4tspdYlRIukjEjbKlDuuv263cPOsN3ZPDviwxjr9X1s
 tW8mjTtUPWLBBo9/EckA4gPHcU00kdOPRXiEsypytGwqiRE3OMoG4qJXibZRnCHsFa6O
 Z7wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxhgXdtyRz+bA25jWq1pMz4EINWDWKV9XEkRnlnDjpse4GJwsKTmR/gwK3snXoR4VfHZFcfJ0=@lists.denx.de
X-Gm-Message-State: AOJu0YwWhGpir032b8oVtP0DKBJK5fougiIot6TSKOcj/lFM2Bgwdl8b
 4U9MSUPZgUBoCcLLJShB7FYTVc6QZvm4V7aansFWQE9ZOvcGfFJ0jTSogISo41s=
X-Google-Smtp-Source: AGHT+IHnUz08VDsFm9VAJmWKew0h+88kQ6PtZK2naRD0H/+1AlsmVQX6rcYWXv/sICu5bn64WAORMg==
X-Received: by 2002:a05:600c:230c:b0:42c:bdb0:c61e with SMTP id
 5b1f17b1804b1-42f7a12bb01mr19673815e9.13.1727879977397; 
 Wed, 02 Oct 2024 07:39:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e65c3sm14056083f8f.60.2024.10.02.07.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 07:39:37 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 02 Oct 2024 16:39:32 +0200
Subject: [PATCH v3 1/3] usb: dwc3: allocate setup_buf with dma_alloc_coherent()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-1-5398088ef93c@linaro.org>
References: <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-0-5398088ef93c@linaro.org>
In-Reply-To: <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-0-5398088ef93c@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Bin Meng <bmeng.cn@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3246;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=7pM47L/QmRm9ChxWkiFFuxDhel4FJ1Ku0kJr5Fv5KHY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm/VsmIEV//DLEZz7b/K39kxJw68uPbJ8t21e0Tg70
 +wkNZHKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZv1bJgAKCRB33NvayMhJ0e+wEA
 CHn2XDc0OWWLvEQ5O4CYmT8/HKJ0n/r5uVsp01piH+539J5NtxlglVBRo2+pUVDEE+AiKNFDVu2nlp
 SoV+iRomjaRUwNTzVW6jWrFVkuYYgV/Tw7Pm6zp/4SqA7K+9FT3JWOikQKr4Wlh0O9iBol/PwN1+Q2
 5DrteMwlDAhFRC/UMsAU52pgF5cIk8vFEV9Jk+C+hmfodC/IWRWn47uTnkxjLFQW6/BZmpcgOwnmds
 WsKsWXvao/k5yPWc1kBvklDJit7zt3jh938mOe5FTGwgZ1NvEGPgb/L9WmN9H0YJS3TtABie7FFDuC
 pXKYse1I5PRPO/80kWgYntEwBFW7UlpSnjYUkiuE5BK1ea45kUupLwio0MCDkIaw8EKXhxQ8sI/54o
 RzYGSivNz7Nl6HTNIANnGfHOYerjkko8fVJdtAhdu95oVMbKvlqh3CJpcXH5usNt+mmG1Rk4AssoVQ
 ba935NN1kb67b0aH60ls+qYQHIrJRWsS9atFx+/C69U0m0dl8yIeE9nyZrickzMziOEGAyk47vhCfk
 EePW5sX/LQ0LPiC3tJKXPvmmEFLexz5KosXhngb0NAhBNiTX23NE8gPl3gH/aAxdkAnZ/mhNVUlj8t
 nJ5V3HzuNRRqEgr1yAnxRdfpqOdhWp4Ur81fPQ8H3ZiCtSFEdNGYaq8MKvCg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Since setup_buf is also consumed by hardware DMA, aligns it's
allocation like other hardware buffers by introduce setup_buf_addr
populated by dma_alloc_coherent(), and use it to pass the physical
address of the buffer to the hardware.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/dwc3/core.h   | 2 ++
 drivers/usb/dwc3/ep0.c    | 4 ++--
 drivers/usb/dwc3/gadget.c | 8 ++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 7374ce950da..b572ea340c8 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -670,6 +670,7 @@ struct dwc3_scratchpad_array {
  * @ep0_trb: dma address of ep0_trb
  * @ep0_usb_req: dummy req used while handling STD USB requests
  * @ep0_bounce_addr: dma address of ep0_bounce
+ * @setup_buf_addr: dma address of setup_buf
  * @scratch_addr: dma address of scratchbuf
  * @lock: for synchronizing
  * @dev: pointer to our struct device
@@ -757,6 +758,7 @@ struct dwc3 {
 	dma_addr_t		ep0_trb_addr;
 	dma_addr_t		ep0_bounce_addr;
 	dma_addr_t		scratch_addr;
+	dma_addr_t		setup_buf_addr;
 	struct dwc3_request	ep0_usb_req;
 
 	/* device lock */
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 24f516a131b..8ba5fcd5312 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -380,7 +380,7 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 	dep = dwc->eps[0];
 	dwc->ep0_usb_req.dep = dep;
 	dwc->ep0_usb_req.request.length = sizeof(*response_pkt);
-	dwc->ep0_usb_req.request.buf = dwc->setup_buf;
+	dwc->ep0_usb_req.request.buf = (void *)dwc->setup_buf_addr;
 	dwc->ep0_usb_req.request.complete = dwc3_ep0_status_cmpl;
 
 	return __dwc3_gadget_ep0_queue(dep, &dwc->ep0_usb_req);
@@ -662,7 +662,7 @@ static int dwc3_ep0_set_sel(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	dep = dwc->eps[0];
 	dwc->ep0_usb_req.dep = dep;
 	dwc->ep0_usb_req.request.length = dep->endpoint.maxpacket;
-	dwc->ep0_usb_req.request.buf = dwc->setup_buf;
+	dwc->ep0_usb_req.request.buf = (void *)dwc->setup_buf_addr;
 	dwc->ep0_usb_req.request.complete = dwc3_ep0_set_sel_cmpl;
 
 	return __dwc3_gadget_ep0_queue(dep, &dwc->ep0_usb_req);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index fe33e307d3e..19c3a5f5e58 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2653,8 +2653,8 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err1;
 	}
 
-	dwc->setup_buf = memalign(CONFIG_SYS_CACHELINE_SIZE,
-				  DWC3_EP0_BOUNCE_SIZE);
+	dwc->setup_buf = dma_alloc_coherent(DWC3_EP0_BOUNCE_SIZE,
+					(unsigned long *)&dwc->setup_buf_addr);
 	if (!dwc->setup_buf) {
 		ret = -ENOMEM;
 		goto err2;
@@ -2701,7 +2701,7 @@ err4:
 	dma_free_coherent(dwc->ep0_bounce);
 
 err3:
-	kfree(dwc->setup_buf);
+	dma_free_coherent(dwc->setup_buf);
 
 err2:
 	dma_free_coherent(dwc->ep0_trb);
@@ -2723,7 +2723,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 	dma_free_coherent(dwc->ep0_bounce);
 
-	kfree(dwc->setup_buf);
+	dma_free_coherent(dwc->setup_buf);
 
 	dma_free_coherent(dwc->ep0_trb);
 

-- 
2.34.1

