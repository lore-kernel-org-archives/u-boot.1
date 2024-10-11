Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9295FD0D79C
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 14:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 365F989342;
	Fri, 11 Oct 2024 16:38:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XJ0DubPE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAA1D89338; Fri, 11 Oct 2024 16:38:32 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A16889336
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 16:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43120f65540so3735905e9.0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728657508; x=1729262308; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=is+Qmg++UbP3a7LbEEqkdEMgwsnrCh69hZqjp/yMHRk=;
 b=XJ0DubPE77LylDnaOmlUjMX2utg1vgcQNjXc8t6na4jP3uR0Zn/3a0XwmVbCGJy0no
 99BYUdlimW3FHx1PB20g4AKsPqKw5isXwBZ2gIP36Ny0cUqcvhzHE8uKdSjBUjzOBF2N
 +fyiHfOUbaYtbWsnQEH6eLmkCeJb55Z0uO0Hf5XaiqAz3NFH8yfxt+CV5aN9+CK8bMrL
 UP1eB3bqJm98LcwyyrxpiS8V1r/7ARaZm6VRFbNJMLxSy8ZGOoXjtBu+T1Junzp9mFrL
 ctjMRGBnAnGHWLS4pegd0dnQ4o88DhVWjZlaFhh82Ne9pmSgqTB9WLMWNyCdYh8zwsyy
 stuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728657508; x=1729262308;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=is+Qmg++UbP3a7LbEEqkdEMgwsnrCh69hZqjp/yMHRk=;
 b=EpqChY+1kk+FcvhRl1jcHc9OtLu5kJTa0w3c7cvdjZAXXhXED3X/aXB0pfnKCBXJqJ
 rcknUhNIGKL0I917o/0/2rX0zMoUkWJJfXD45zaKZNdh/zCc4gyupI0JC4H7AjvkkHVY
 LsDQSZvlq/LvpifuxIgu12DsOLVq/9d4DdfXXuxBhesMNkOb/YJX2K+qePdBBcEO9R79
 hG7tRVy0oB3or3ezlPSFal0K0ZNz9WocE8mUuiTr7Tg7e7VUWTSxjOGxFxodnNOcIm4Y
 XULG9jT4WsGQYGaZiVom3+H6u0YbSbUreDC1UlfI0G4018JVaXCc0ayF22AzIgLtYy7a
 tz0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI3Dqj3s8rrQWMwT2Tl6zjyXXobJxnvP4guwWsiKYh+bWaX1UOLHiVMRXgqXEdtRn6ZKvzhjs=@lists.denx.de
X-Gm-Message-State: AOJu0YyO6QMdu3tzT5lQAMMXbeFUWr6cdOo499aGT5802I1T9GTwWJwR
 e5YqpkzwueO62szrSy92YQX3xIr9zEgQJOLhW9+n9JQMAspiS5fbRK69z6uJJ4o=
X-Google-Smtp-Source: AGHT+IEw8Ebe5L2Qsgyp4g6hIl6Resb2P+DHNm6NnPiENP3/i7fdG+HLBQJpO9dBtM7XiPYWjqZXRw==
X-Received: by 2002:a05:600c:1c9e:b0:42f:8515:e479 with SMTP id
 5b1f17b1804b1-4311dea4233mr17594055e9.4.1728657508645; 
 Fri, 11 Oct 2024 07:38:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430ccf5188dsm75991815e9.24.2024.10.11.07.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 07:38:28 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 11 Oct 2024 16:38:24 +0200
Subject: [PATCH v4 1/3] usb: dwc3: allocate setup_buf with dma_alloc_coherent()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-1-5f3498d8035b@linaro.org>
References: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-0-5f3498d8035b@linaro.org>
In-Reply-To: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-0-5f3498d8035b@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Bin Meng <bmeng.cn@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3288;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=/YQoIhV2IWohezd877+6D9uRlBPbgPaoZkRO0x/uh9Q=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnCThhzea0dODk0DPZKWz/z+vp46R/433sjtxpYJW8
 +1dSg1+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwk4YQAKCRB33NvayMhJ0dBUEA
 C5/7vGv3b57Xjn40/ftwDbJH92m1UOzeiTPjPmr51wiBYlVz8oQdcN5S/ldj4RXYQ9yYsWp2HgkVdd
 BmpqhMEbWfSA3NI+/296IkGpJTeip02LLdPX8aTsYtMW7OvVfnbdjVVx9u2K8lVyVDy2ym5ZuxTtWx
 0hbHYGb6NI1a3zH3cTxosFhVjczL8Udf42QNPXvcuI0koH0e/T672uw07RR1FKC7UeTAvZslLoRgYL
 dZ7eCcHp9L+HYOXHVKi6u1hQ9dTDxa1Tl2BWWLloEwj/KlR1lGDtYyKdjZDdo5cY3U9Cz+VlQ/YaW4
 uXhyhfAp3FFbf0YWLVz8F+teSslHeuPdVzvN+S7xG6PqYX//yCkKI1LxjwaVBFlewO6v88kfIpukKy
 5Nvlq78/fnjMd6MgFBJwFyUJt3/nBXa+x++8JuiH3UEnC+pVnYGCU//GAwJ8bbxxnp7XvJFl3oDdTi
 bPoNO80WLUrnXC+TJIx10c2PGbbIvEq4QJlQIdl2LqjnTwJ441fPpMH9TU2SvASlnUIZKU6jdFyMYC
 8Jgf89Yh0M6CGoIOYRpmaOruZHapGUUrH+CSwGYTGKfThsCWZDHAqSlYjIsvgu41empyu+rbQFwGVy
 YaZXbRlHMqua7P4y1Ly5A7pcVdjTmuZDbnelG90JOyKwyf+kPS5UOD9kr/gw==
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
Reviewed-by: Marek Vasut <marex@denx.de>
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

