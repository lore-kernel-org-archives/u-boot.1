Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08835C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F0828897F;
	Wed, 24 Jul 2024 17:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KKh6YKo9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E282C889AA; Wed, 24 Jul 2024 17:48:19 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A49588997
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ef2d582e31so39189951fa.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721836097; x=1722440897; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QBd6NvMy/fWSFw4JFGKRaGpPxX2t0h4CS/mrUUn4lmk=;
 b=KKh6YKo97vTIrEmTopOoG4tTpVBsUhCyx0Agzo3K9KwZm0IYex9P9zTE1tRg8j67k0
 MKruXKVPfHrbFdw05jKkEzMtoKWQtE0qLaQ8xpbyCFGgLsUAi34w88CUkiFTGEBZqIHV
 Dt0kvuDcJ5l8tEu5MhElbCvcHxgG/huHBaJdJmsqxT6hl1M7VVqNFL22kGe/JswhfwHh
 3bFhmVW/7RQ7+l/fHi11FYejk8lNBaorppTlOyyI33zEwLHBUMagDYsbmTy46d9tBxny
 m9vCo7SY6/6SMmRU5UwmfiF1hCk+lzeYDa9ls9mR0jJY7ATNR1Q9q/1LfwmKXZ6b85oz
 1AfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721836097; x=1722440897;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QBd6NvMy/fWSFw4JFGKRaGpPxX2t0h4CS/mrUUn4lmk=;
 b=QHcrJfCdjbM5MC14iZG7WnQuR9tuPhTFwhVgoPDUoSbg8N7gdEXclU0yS11pwk0Maz
 W0kQdZlQidPeboRq7YDgYku63JqIM/rDbVVxjMgM4TIvp0kRSM9xBTdYquG/Ycubf/VM
 +tQerADGpkSJnLP88291hf8xbdSt47BDGBvbbMvqH3LEYHY+syPruCNwAYgB2XOrtZkS
 +0RWpSmJrDbY/og6imBrrUeXvfcJ/a40ZmP3PXUkd+SDeg3E15yRn07BdYhVmfySA4gb
 SqdFNBG5ntwRbCCKiujAhsA8v0tzdpp7yuOLAEl3/UThtSN5eqabzivXRPKwoMAtcc+L
 HHDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW8WxNHAtVPenWtUnVty6VuLsymWIoXHSblvYo/edR2YkI+lpkF0eapYJAdxDViLJxAHmueQRmEWqk/BdKONBpBEk5Vw==
X-Gm-Message-State: AOJu0Ywnu7PzrAnD7bKTKhSmsAAOcS4Sr3MIfv0XRrM/rkt5d7L3cCgj
 QkDD0yHVZK1VmopSTr5MixT49AN7Myug1KVBOoOy3yKG+FqbAlj3Ha2QhuKdMAk=
X-Google-Smtp-Source: AGHT+IGeZq2xbOv4VC4uLkCbCjLp7c5F4opvse8TxtfstS+s5sft/3PUnTdYGwESL1m/Fg2p6bi2LQ==
X-Received: by 2002:a05:651c:155:b0:2ef:2d6e:58fe with SMTP id
 38308e7fff4ca-2f039d8f959mr1640461fa.32.1721836096453; 
 Wed, 24 Jul 2024 08:48:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f93aabdasm33633015e9.36.2024.07.24.08.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:48:16 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 24 Jul 2024 17:48:09 +0200
Subject: [PATCH v2 1/3] usb: dwc3: allocate setup_buf with dma_alloc_coherent()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-1-65836d699a71@linaro.org>
References: <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-0-65836d699a71@linaro.org>
In-Reply-To: <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-0-65836d699a71@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3246;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=has3gz/aM0afGUQH4DsnuFvgyVLWYivVIH5LE+Ha1CQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmoSI8MkKh3L4swJmpflbdl3MWyGtAOz/NRgQoa9av
 tmAmuCGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZqEiPAAKCRB33NvayMhJ0XeBEA
 DQc+Cod6NbnTf+qYDPFanw5uvYv6SDCKodcddonGDpE57Gx9wmgpCWHUtKZ26IYPDA/rtnsVlauP9N
 OuHbLErvVDTKdfEKI4uu7yfouaHMtguoQzescldKUKLjw4+Jzj2tPyo/ET8O1ySqDEErUzxCn4ngvn
 F7pkUV4QWTzq8RxO2RIbOH8RafF5rzJ4ed9/jOMCamN72yNWe5gZgKZD96DpQ19Qbn/9DFB5WO65ke
 Ce4MRY5buo6pMRB403VSEJecZCsaW0g4G1LYz+rYqPxWIAA8oET9E8/LkOmI8C88aoRzjJh+Z2XOc/
 fJK8wW++eRRntr1qkUbK3H7WAz6AuKeiVXtnn3C6OTLDa+0jQUmYQYfgVmPdmzhh4M/oHspqp8RJ5n
 fpZYPFqvaqsQ3AJB4T/bwHzk3aYSLerBI55OXPpS4aXHT1huk4ZZq4NVm/CEQJdvQbhX2ckj4icz2Z
 lIyUEyI/k1elJWX8eLD7klyo6joZ/wf5KR8V4W5pPOqhuCO9x6ZHeGG0wdX95KS3itMJppoFM4/T8w
 QJNMDKPnjvIzyumyQ+EIElM+UHIFl1VEL4pYWNHec8b/6/5MFO4JeXIVYUQ9O/GyxCQkGhhYVVtGHT
 odwNXngDh7eEqf+wECX19Zxmbixm8gHQhKk8hL5f+6yERVVgz6CMpMr9pRbA==
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

