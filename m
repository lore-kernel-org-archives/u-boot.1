Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8047C25B7E
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 08:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AAC588445;
	Tue, 28 May 2024 10:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e+u3nmeH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77A3388418; Tue, 28 May 2024 10:35:09 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ACE588441
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-354ba5663c9so404338f8f.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 01:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716885305; x=1717490105; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kVQB5ZBz5/WJEBlYx9gP0Yo61aobCxqH47fDiuwoehA=;
 b=e+u3nmeHDMICrMG3PqXudLa7cDw7EGa0km2qVlQLg+grMicbY9qusieIklnmr4E8rf
 fop+OYGpVQh5F4gKQjF2qxNhjAC3R6FjgJtpYaI/25wm4uHDSUccNh/wKB9ycQviENVD
 F3MHPrj82MJ3OvDnXgDwgiklZtVNFtGehJsjyRQiE6w6od+WjrDJ0BzNLgo2ExwVBDzP
 e4YaOulcKQUzubSexLKTSP/F1Bbe8G2ARsTjaodac+YDAY8EeD7hSIvzAnJYHTFcLs24
 1UXPLtlPhxVvBXrAZmNKb2+0R7m4z2wwfJ6hhw0lkFxZUTeaiYI5DtwmBkPHFvj8kK2C
 thng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716885305; x=1717490105;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kVQB5ZBz5/WJEBlYx9gP0Yo61aobCxqH47fDiuwoehA=;
 b=h7qjCw4N+G5XsA1HXJ4ediz45NPgnamDO3fyzOGJyOZXwPYDYl+/4GPrNi5+zxeo/B
 VB5YwILvXJREZUYhRnuhHGEYQ89hgQS0BSzxTHnWpzIGnkgcmE0e8oIHzzktRJLAKqiA
 rxNQ02vhy0gcQ7DP/WSDaLEEFdje/SSe5cEZXPZ8VHYKsN/y8/UHqcXbU+32IId8SJ0J
 gcxAi9UgxTzSXtAQeJEyDhsZh/sB7kxY1MaVOA5ElaGjeJ95/AGdfuCqu3Y5S7h+sEad
 PimE6prQm+k2w0j0LCanr4tBddmCiQKfFU2cH78lZgpGMuUysIsRFVlrJ0bhMEXjeVdF
 z7ng==
X-Gm-Message-State: AOJu0YzGGth5l1kBNciWcRo5jwUtbU6Mx8+tUNUQonP70ToGJynbr/cn
 CVLzpdA0q/8RKt1+uxp2aeH0LaZHfrjA39U6PbkfLufWK/wvUzSknoehh36ZBnc=
X-Google-Smtp-Source: AGHT+IFqoLQNoZj4d3sAsymKc0/qvSGwtIu8Z9FI44ff+JCXdMsLltF5st1EhTkmENVNUPjCZn1ALQ==
X-Received: by 2002:adf:f506:0:b0:355:433:8f80 with SMTP id
 ffacd0b85a97d-35526c569f7mr7215241f8f.33.1716885304791; 
 Tue, 28 May 2024 01:35:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-358ffe5de1esm5234527f8f.34.2024.05.28.01.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 01:35:04 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 28 May 2024 10:35:03 +0200
Subject: [PATCH] usb: dwc3: gadget: fix crash in dwc3_gadget_giveback()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-topic-sm8x50-dwc3-gadget-crash-fix-v1-1-58434ab4b3d3@linaro.org>
X-B4-Tracking: v=1; b=H4sIADaXVWYC/x2NywqEMAwAf0Vy3kC2rSD+yuKhpGnNwQeNuIL47
 1v2OHOYucGkqhiM3Q1VTjXd1gbvVwc8x7UIamoMjlyg3g14bLsy2jJcPWH6sscSU5EDuUabMeu
 FOVKgkDOL99BCe5Wm/5PP9Dw/lr4qBHQAAAA=
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=B5v3p5TfjpucgwVaRmabxLJsVbrZ2qBAHNeqCVZ+8EQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmVZc3LMXx7uOk71tX6sXkfMFvHjcSoLucPORZoybK
 mdM270yJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZlWXNwAKCRB33NvayMhJ0W78D/
 oCk+FQ9q9uLbHzANA3J3ywHgiIWHhuvWjVjWiZYKmps6D3pduUCy41fdUaqMEe6srtqPUgZvt/uqCV
 N9ivLp3x4Kok6lnOIO93A4NkAoWkyPgqybRhknD+oc2EkIn0wNkRfLVEruY05Hb6HdsO+yVCji+ucD
 AWJV/JqC+U+2NAkVuGNcPIwPnyTfI/z2zJoN+jMSPoM+XkGIOdqU71iGulIOxkllWU7PjVSR75AxCa
 ezDvW3PqyYAdJo38wp2oTe8iniNETAbJntMW06MWN6h1MhqQvDhYGc8rrpP9hD2at2kzDpUF6B6NHQ
 KplA7OjSozQyqiz1FGiS46VvdR4YQUtCAFwAi3gMTSLIsCSR/XlXOz44WKKCZoCUKQ/7WUBEqh4Pua
 yOnMYbMJikshKeG1OAVsNSuK0yS6keav05KVFzK83Fe/0PG5tFwSjQoZyFUFLXYTJs3002pC7VW4wT
 kps3hK1CE/VL/L4aL3qW8mDC4LktOWfBPI6R9PWF5zOP7JkNVG8sHWipYsa4hh0ulOpiS8vDWUm6/T
 slc1SkLErzL//ny6Zfd8b+gIjnHklG0Y+2721b8UKK9iGrKu5WbtqV50SdoyhT3LXqjBXyJiNxXrqz
 jPkepbYXKhmzTfEtUGYQ16B7ruDak5+cR+ZOGwEDfxVaYy0at6Hbbkjnlqdw==
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

If the ep0 stalls or request are dequeued when gagdet is stopped,
the request dma may not be mapped yet and dwc3_flush_cache() may be
called with a NULL pointer.

Check req->request.dma before calling dwc3_flush_cache() and later
the usb_gadget_unmap_request() functions since it means that
usb_gadget_map_request() hasn't been called yet.

Fixes: fd15b58c1a9 ("dwc3: flush cache only if there is a buffer attached to a request")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/dwc3/gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index fab32575647..92c7c6d08b7 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -248,7 +248,7 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 
 	list_del(&req->list);
 	req->trb = NULL;
-	if (req->request.length)
+	if (req->request.dma && req->request.length)
 		dwc3_flush_cache((uintptr_t)req->request.dma, req->request.length);
 
 	if (req->request.status == -EINPROGRESS)
@@ -256,7 +256,7 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 
 	if (dwc->ep0_bounced && dep->number == 0)
 		dwc->ep0_bounced = false;
-	else
+	else if (req->request.dma)
 		usb_gadget_unmap_request(&dwc->gadget, &req->request,
 				req->direction);
 

---
base-commit: 7e52d6ccfb76e2afc2d183b357abe2a2e2f948cf
change-id: 20240528-topic-sm8x50-dwc3-gadget-crash-fix-fa0404ffce33

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

