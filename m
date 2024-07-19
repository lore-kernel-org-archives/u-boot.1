Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43A8C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 13:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEFED88BC2;
	Fri, 19 Jul 2024 15:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HS7dpAu+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D93E088B8D; Fri, 19 Jul 2024 15:57:00 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48CA688BC1
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 15:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4279c924ca7so12850585e9.2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721397416; x=1722002216; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iC92PipK9xi9Jfw1OJglpEcx4IgdHfslzbOxexcXORc=;
 b=HS7dpAu+HbZVVkBSGaL5MuDpab9UV+ghUf6CXQR/JFEO7x/6dLeYaRdeoAuJFlO4D4
 jKVt8E7/424mExPyPvUyd72PcgoJua7vKZdxyjPYzzz24ptJ0ctl7qYAHHC9SMYbGl+f
 JDkdystVjNENAvyYLHG+6ndTt0q2OXE3AozvZRac9jNxdPxzPMc/AxsEkJkNS6md1ZGv
 zAEQeMDYdUkgiAaAVlzULnVxowRWD+ooDTJzMNFUvrM1yzcFsOGGuKGYZ27pEcwd7oyN
 FoZycNLmGQMvEAMop3CFU+q9Yz9aN05DezCHZVIJsQq3y2j+0ucO1sETDX+L8nHyWsAU
 KybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721397416; x=1722002216;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iC92PipK9xi9Jfw1OJglpEcx4IgdHfslzbOxexcXORc=;
 b=RAW9sJFQqRkNidEjdG1WXdMPgTukRpcsdrZ5T6Syne0taKPpee2kJ+ZVUg68WwWdmo
 xqUZqJWziHHGwUkFGm1kB/Zn59If0JHHWXL9h1JCNn5TePmwVzj22yCgVqN6BpdwuhfA
 uAADzFEOoCQ4l/dd788X+h4btzGS00R/uhPPdQ+puwWn53altUzPev3HycHmbndQICWn
 BxfyCAcxQMnlIO1YLST8qz+kbPAs1h4BhvKxTq0uabMT1MfHxj7v0tSTqTwJCKNEgkWj
 oEWJzrcoIwpGgr4mwcgCgYSqSvaJ/q8aukUj8tdJh1xUZAV1WUAcFqnB2QlRu8xkBhb1
 fY/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZor3n+aQHfjsaJAmD+Ntix8AgggiFSs07o+nz7IVzJ6tNmzxs1v1c9sFDxB4A4TG++gi0sahy33dQfyBYvE9CjhOifQ==
X-Gm-Message-State: AOJu0YxKff5rz9r63jUzbzcZiEqX9GRshKa7OSgXVZrbIfcOu+PyiAbH
 IoSoibxdA/eL8sog8eSlQRam6Imx7NZYrEYyjwLD3VRAoLhAguk/mQCP794d5NA=
X-Google-Smtp-Source: AGHT+IFe1x5fnHYjTFFo71YM9y19ghja4alofICkmaWzEbKrylm0p2EjfZFgJ5hZowdRyCN6Xoxi/w==
X-Received: by 2002:a05:6000:14e:b0:368:74e0:2068 with SMTP id
 ffacd0b85a97d-36874e02316mr1655270f8f.33.1721397415452; 
 Fri, 19 Jul 2024 06:56:55 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868bc21sm1694083f8f.39.2024.07.19.06.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 06:56:55 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 19 Jul 2024 15:56:50 +0200
Subject: [PATCH 1/3] usb: dwc3: allocate setup_buf with
 dma_alloc_coherent()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-1-58a5f026ea8e@linaro.org>
References: <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-0-58a5f026ea8e@linaro.org>
In-Reply-To: <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-0-58a5f026ea8e@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3047;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=oDzc1qoX0+WC9wBPLHsCPc0eCSw/oz1cIvgRcvtG0gc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmmnCkYL2ILTqu1DArHuc4X17tYShyqIreRATqLa5T
 1bhjxJ6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZppwpAAKCRB33NvayMhJ0QY5D/
 4uSpl6vnmUg19tsmsUVxUSBI2SzHrNWnqb6obfq7OPr9FafM3G7vWNEGlZlU1Ol2+2Ssh6FzzWY+JV
 6P7MsAOfbIUx4H54yZIFd8ffJuCBeQ3uLQzNqBadhVwnTEuj92kFMTh8wp01+SopHBXwM4fQJD0qH6
 TTOXjIJasNs5LRnYhr+FYJ6wGlMO7Q4NnvvEozMUQoFQeRViPJ+n2DSeZTeP1egsehPfpOYGL8wDnM
 N5XA6eqgym/HgK/mzgNGGOvsoIGHNY+d11P+LrloB7VvBkJVVcYrZUsYV1/U3F5CSMu9R61/ELGKP7
 7DXv5LI4B3agPgTaNMvr5HAmRtOasW6F9wD0td2ieA0P1Pc3g62kzA2CNXe1er8BBJQp3Fm3tBmoXN
 Tf/hBvX2Zb4gdilhbya0Jw/WPZTQBkecXN9vDLlRL6W+8Ur8MxLwDWUB174Rkea0IwSWWSgcYO4QRb
 KjNtUps1BzugX7qHKxwBaidSVi+6RR5wHchvmlH3x0qtJdhejqMso4RHr2dSZshHFuR5hNTs9jUhZL
 T8EaDsSKXEMe2qXupGczri/D8MWsksxjJpRfH/ldLEr/LDFF6GT1nrkPkGcxAaIdXq7ckR/V5hlKXA
 R6OXQwnnnUcGbKxtkfbEfS35lf7Y6wbMgJh/kUs3b4nASOb4jaHkDWFQBM8w==
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

Also allocate the setup_buf with dma_alloc_coherent() since it's
also consumed by the hardware DMA.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/dwc3/core.h   | 2 ++
 drivers/usb/dwc3/ep0.c    | 4 ++--
 drivers/usb/dwc3/gadget.c | 8 ++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 7374ce950da..ce35460c405 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -670,6 +670,7 @@ struct dwc3_scratchpad_array {
  * @ep0_trb: dma address of ep0_trb
  * @ep0_usb_req: dummy req used while handling STD USB requests
  * @ep0_bounce_addr: dma address of ep0_bounce
+ * @setup_buf_addr: dma address if setup_buf
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
index 16b11ce3d9f..0c7e0123368 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -381,7 +381,7 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 	dep = dwc->eps[0];
 	dwc->ep0_usb_req.dep = dep;
 	dwc->ep0_usb_req.request.length = sizeof(*response_pkt);
-	dwc->ep0_usb_req.request.buf = dwc->setup_buf;
+	dwc->ep0_usb_req.request.buf = (void *)dwc->setup_buf_addr;
 	dwc->ep0_usb_req.request.complete = dwc3_ep0_status_cmpl;
 
 	return __dwc3_gadget_ep0_queue(dep, &dwc->ep0_usb_req);
@@ -663,7 +663,7 @@ static int dwc3_ep0_set_sel(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	dep = dwc->eps[0];
 	dwc->ep0_usb_req.dep = dep;
 	dwc->ep0_usb_req.request.length = dep->endpoint.maxpacket;
-	dwc->ep0_usb_req.request.buf = dwc->setup_buf;
+	dwc->ep0_usb_req.request.buf = (void *)dwc->setup_buf_addr;
 	dwc->ep0_usb_req.request.complete = dwc3_ep0_set_sel_cmpl;
 
 	return __dwc3_gadget_ep0_queue(dep, &dwc->ep0_usb_req);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 7d6bcc2627f..d41b590afb8 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2622,8 +2622,8 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err1;
 	}
 
-	dwc->setup_buf = memalign(CONFIG_SYS_CACHELINE_SIZE,
-				  DWC3_EP0_BOUNCE_SIZE);
+	dwc->setup_buf = dma_alloc_coherent(DWC3_EP0_BOUNCE_SIZE,
+					(unsigned long *)&dwc->setup_buf_addr);
 	if (!dwc->setup_buf) {
 		ret = -ENOMEM;
 		goto err2;
@@ -2670,7 +2670,7 @@ err4:
 	dma_free_coherent(dwc->ep0_bounce);
 
 err3:
-	kfree(dwc->setup_buf);
+	dma_free_coherent(dwc->setup_buf);
 
 err2:
 	dma_free_coherent(dwc->ep0_trb);
@@ -2692,7 +2692,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 	dma_free_coherent(dwc->ep0_bounce);
 
-	kfree(dwc->setup_buf);
+	dma_free_coherent(dwc->setup_buf);
 
 	dma_free_coherent(dwc->ep0_trb);
 

-- 
2.34.1

