Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290C4C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 17:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F5EF883FE;
	Thu, 25 Jul 2024 19:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="EpNYT79e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34E7E87876; Thu, 25 Jul 2024 17:32:37 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 049DF88360
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 17:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-369f68f63b1so634513f8f.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 08:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721921549; x=1722526349;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bv6zEou6o17TNXthUpCJ3LAcvyzqC/A52iEyMstddds=;
 b=EpNYT79euqM3nPFS99sWRBUDDnZd/4qRHmUfqvP8RTm3Gihv9IxcaGbZcbK/kdw/xW
 ugs2ZmFiIVE1t+WVGqYrsWBrTy+O3uYA5VkJVGCD9kLU6hoPrT7DkGk/XHM9kefNv0ct
 4dA07q6AN20V324HwpFQd+GdL8i4UH1KOKDrSii9LhdNRbpL1KL/+qiCALzHVHf6G2gs
 hYjuvCqgk3vK7Qqi557VR+ImM+nVU8sdkqbOJd54f0ldoF4F/+4H90VnZO4P/L0wTkaH
 npK/vYa6mZXI9BJ9vKDXO0eIYhw/uNJzMm0ESpeSlyLp4UhTmFeF96UfCP2FYnT7NAJU
 CTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721921549; x=1722526349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bv6zEou6o17TNXthUpCJ3LAcvyzqC/A52iEyMstddds=;
 b=eOtygAqrvBCbtqyurV1PVpnQbPRTURsn2r4T89GSEbvUI05nk/ud8wRrqnZ/NlwMQI
 vwzbMbuum+tTOGCfGxvJFjTvM0Z7uYOfh1BAb9JrFWG9aNfNLn46aOJuABeEJbItc6vE
 IujxCnwAXy2vpbQAXDoNlrzk/Ixklde98piSi5L4ehOJu9TBtV9nsrX4BII7gA8bVYtV
 HATeFFiJlXbIQoG5A+IQFUrSRMvvz8zz7yKwaJBJdZKIYZo+7huBLnJ3ZUl/xRBN0nVo
 VXety8+wdmMSJylOg+Yxh4RwJg/jiTGDPTG41iRn7/fczaUgC1rM4DhlQk31mKArUxI7
 KsAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT2UhhjZwslX9ZPK8B3LqhnF1PSZiZZa7tNhAQhOx+JhwJsb2MRPfOSEn1m53uxf7NYza992Arag6y/pG/7/geq7CAkA==
X-Gm-Message-State: AOJu0YzP21pfACSYWdJW1Y/BKjdcOmIBB9Ww7OsIm8tyXv5Ss4+cxyNu
 KM/TwsF3lrHlYHb9HFg1nNrq4PZEbvtZz/uyRIeQemOvD3Iche9CUZTzPAFBrDc=
X-Google-Smtp-Source: AGHT+IFTfy9/wrwqm+Y5X9pHcEqh3WdfLSkTdPMNsIN18UbaZ07WJU8dRrsQMvjpAalIt6PB5LVTGQ==
X-Received: by 2002:a05:6000:1210:b0:368:6633:c550 with SMTP id
 ffacd0b85a97d-36b36418e4amr1663576f8f.52.1721921549524; 
 Thu, 25 Jul 2024 08:32:29 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36b36861b54sm2530805f8f.95.2024.07.25.08.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 08:32:28 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH v4 6/7] usb: gadget: atmel: Add attach/detach support
Date: Thu, 25 Jul 2024 17:32:00 +0200
Message-ID: <20240725153204.358925-7-admin@hifiphile.com>
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

Add controller attach/detach support by using
usb_gadget_ops.pullup() function.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/usb/gadget/atmel_usba_udc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index ea9ad7585e..a7b96449f8 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -506,10 +506,28 @@ usba_udc_set_selfpowered(struct usb_gadget *gadget, int is_selfpowered)
 	return 0;
 }
 
+static int usba_udc_pullup(struct usb_gadget *gadget, int is_on)
+{
+	struct usba_udc *udc = to_usba_udc(gadget);
+	u32 ctrl;
+
+	ctrl = usba_readl(udc, CTRL);
+
+	if (is_on)
+		ctrl &= ~USBA_DETACH;
+	else
+		ctrl |= USBA_DETACH;
+
+	usba_writel(udc, CTRL, ctrl);
+
+	return 0;
+}
+
 static const struct usb_gadget_ops usba_udc_ops = {
 	.get_frame		= usba_udc_get_frame,
 	.wakeup			= usba_udc_wakeup,
 	.set_selfpowered	= usba_udc_set_selfpowered,
+	.pullup			= usba_udc_pullup,
 };
 
 static struct usb_endpoint_descriptor usba_ep0_desc = {
-- 
2.45.2

