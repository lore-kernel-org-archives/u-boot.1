Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C98DC3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 19:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC94882A8B;
	Fri, 16 May 2025 21:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PxpnaJWL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC5A782B00; Fri, 16 May 2025 21:36:25 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8E828059D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 21:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-54e9021d2b5so1874200e87.1
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 12:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747424183; x=1748028983; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qtSukxIHrNLrMSSUrPSLjT+c6GBwNOHJSl6kYWhKLTw=;
 b=PxpnaJWLs/Cm7CneVj7fq/oOFFKuUKHBbQ9M/4wv9gMMqjUQnbeqsxjoiZPDiOaXrb
 38ZY7Y8Uw0+2HFki9y01ybc/bJp1hjc0Ls1XG5OcNxs0gJ4y21zR8sQx1dpOTKUDIMOO
 nAK5nQQmfr2bGjOmLCeJ6Sxj4Va1/DM3hsQukGC1DVSwUmXf8uM8wcYRtL1y1KP6oa1v
 jzM/t5171iHZ2gOT7VoWkM6CmffeIqrHFb5Wx1U2rIiTnFHYkGgeKyyyVC0kiyhL5BHn
 fyBtjY888DlFoiNTTTXvIdTqw5kOMOM4rKROhPko131gAUgn9HhE3qioUghDdlcPXKkv
 h0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747424183; x=1748028983;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qtSukxIHrNLrMSSUrPSLjT+c6GBwNOHJSl6kYWhKLTw=;
 b=xMbPBee2mI5/6LQu8prk6tRmUb7SgK3j2QklHAVb4nfrbgee4lZnZqdv6tx+nsawnq
 HF4QOPga4K37G914/jg0ZKARbz8XgOAqfScVYIE47cBqXEao1S4Fzt/9BcR4zJp/UIv6
 7lHp5RESjN0evrBgqtY3S9x+3ST3R/T540AkIJ3cDDw07VHOHNHsmBD9uwHkYNJ6J7EV
 Q7EERVdrIM2glem7TrNRHEY42dGJoylOSjRUoAQUMYVQr7GZvr144qE5+Tjaa1XBJCI9
 OHszhLhceRzkJ+1LZ06GxEh7Fk0EM9a9WeBKfvMSiF5OeHi+gqD3ihwkwPXA6U0eFVfo
 LqpA==
X-Gm-Message-State: AOJu0YyHVb+zvejR9jrvF4CJT2SPm5A6YUEA2Tb+49X9OeN10m+nbgQ2
 pHcsRkqmU270HrgflA2nl41nmTiFyRQrlUdeRtaF6i/JOyPQ5MEssUVrHVaQtyOZ
X-Gm-Gg: ASbGnctaYdwNnHRzIflaUZU7LERL3ZWO1hRypVnLY2oXrrLbgnnAw5n7gce+Mz9vlfU
 MvjZDFBg0yqsOkH1+ccwY3u9W1bX+YEr7h/TogJ0+TT/dhRqIj7B80jvJ/3Kdy5wiFD0jz7SRkq
 oRiMRwLjBlcpIRLG/3QzyVNxuncKJamPsy+UuCoAo5n/iD8hV0DY+a2Z8p4G64MVC45a0PLfq77
 GxmMEEPz4rCnrmHMKfa7GwSSkzA01u1+haqywjjVxkQpKX5Hl8UL2FYOPQIZ/xJMjShoGx7Y6FU
 h6vSxk2D211pbM/ZICFhzPOnoJ58uglpZPEzScszrzZmMmSZU1/ithkRUysu8jQp2csbhPXX5ia
 XsHQMKXogPjxljRpJ0A==
X-Google-Smtp-Source: AGHT+IG4uTxyDjrIfCxVmeMef0KrYOUH3eGBNuuVVifhMQWafQrrjF9XearINBrjNr1TvBbGEujJIw==
X-Received: by 2002:a05:6512:3b8c:b0:550:ea2e:a89d with SMTP id
 2adb3069b0e04-550ea2ea9edmr1158312e87.6.1747424182415; 
 Fri, 16 May 2025 12:36:22 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-550e6f34e8dsm565854e87.81.2025.05.16.12.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 12:36:21 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] drivers: usb: host: fix prevent memory leak in interrupt
 message submission
Date: Fri, 16 May 2025 22:36:18 +0300
Message-Id: <20250516193618.153618-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Anton Moryakov <ant.v.moryakov@gmail.com>

Ensure int_queue is properly destroyed when receiving wrong buffer
by adding error handling path. Fixes memory leak that occurred
when backbuffer validation failed.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 drivers/usb/host/ehci-hcd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 7d5519c65a9..765d8b327ee 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1557,6 +1557,7 @@ static int _ehci_submit_int_msg(struct usb_device *dev, unsigned long pipe,
 		debug("got wrong buffer back (%p instead of %p)\n",
 		      backbuffer, buffer);
 		result = -EINVAL;
+		goto err;
 	}
 
 	ret = _ehci_destroy_int_queue(dev, queue);
@@ -1565,6 +1566,10 @@ static int _ehci_submit_int_msg(struct usb_device *dev, unsigned long pipe,
 
 	/* everything worked out fine */
 	return result;
+	
+err:
+    _ehci_destroy_int_queue(dev, queue);  // Освобождаем очередь перед выходом
+    return result;
 }
 
 static int _ehci_lock_async(struct ehci_ctrl *ctrl, int lock)
-- 
2.30.2

