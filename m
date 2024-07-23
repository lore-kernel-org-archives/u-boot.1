Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3C7C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA89388867;
	Tue, 23 Jul 2024 15:36:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="A5Nd7rVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED70788747; Tue, 23 Jul 2024 15:19:05 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDBF4887FA
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 15:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-367ab76d5e1so2138157f8f.3
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 06:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721740730; x=1722345530;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=087EMM/M2N812PYZPjuCaXgHe3mKHrAvwPzuqbBN0Mw=;
 b=A5Nd7rVhnzcssrwIKGczRRpM0A1PZkCifh2FoGfFYxdknM5zbVCyDtOwdQrO9kalWy
 n6Z8+pFt6USlpFzrhGPNY1ISRKHzItwAIzY5STnpWnfkPdtODRF/uvldJk7fqVKm7EaS
 9/4ViT6DqhzFYlA994PD9fWjn4/1QpGlfYYtWI9BtkMU+IUH0EXaqJ8yp50S5Y9MuHsQ
 dT7S7mRT4MXfUmkqwBjQrkqW4sulpqlgEobX4dV4ru8kD8YVUeSkdhKkI9QzY8DhUpdg
 GVU9ckoibWZqXru1x+XLmpObkThnm5C38EXnAbGjCWRn82sr/vgCX/fs7flQ8cqUvcYH
 5WFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721740730; x=1722345530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=087EMM/M2N812PYZPjuCaXgHe3mKHrAvwPzuqbBN0Mw=;
 b=JfCo9x3BXnZfnigdqD8eaqH9CTTJMosIm0f0/WiFE1DRRQx3ZbKYGsNpAYyhQBck5I
 R0CkC/aasyxXT+EbRI902DS+Vza7lHOvFudraT6LhdxI73TGhcp/7mPXBG/d2A5ARR8X
 kBlO6NeTT5A19QzFzOdAQhuoC/Zdn66oBMeQ1dtp2NhMsfjrg1IH+yKroz1xMuV0RIeO
 FFPsJhPDxwX3iY63FMTGakX7kgqZu6UMzx6vs9Vmjyojx8AcX+oQHCGhUl0jia1g4XZy
 co5qPv0pnvuiiMP3y5U/wZlaE8tApFXK0+hb7kH2yXVBqrhLV8NGIIvfNY6qprX0GJtQ
 SnYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWicfTWb4buqQjI3K/+UhBVlaGdq5N2gd7GPubFG2l4HwOvyz6n6RDAdr8a8BEPIw9jOjREBF4NNpxnqeADjxwJnkWo8g==
X-Gm-Message-State: AOJu0Yy23F2o4UuiLf/VZr1Gt91ZltALBHeGzXZSWXvWJY7rEpHZKsBc
 IsIiu01qjlKRskiahpKMe2xAuQzuaftEV+cfrTZIie5GhbNgawMYtR3pxcIgw2IdhIBbMBMDSDy
 jEeLV6w==
X-Google-Smtp-Source: AGHT+IEpeaYsqodHLkQ0INVrP5Y/FHPwnU6ft4kXY3DqbMm6wwQeX1AWKpnN63ZLL9fD8jrklUuGng==
X-Received: by 2002:adf:e58f:0:b0:368:3ef6:f049 with SMTP id
 ffacd0b85a97d-369bbbb3178mr6182084f8f.2.1721740730365; 
 Tue, 23 Jul 2024 06:18:50 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427db2a4e3bsm140312545e9.44.2024.07.23.06.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 06:18:50 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
X-Google-Original-From: Zixun LI <zli@ogga.fr>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>,
	u-boot@lists.denx.de
Subject: [PATCH v3 6/7] usb: gadget: atmel: Add attach/detach support
Date: Tue, 23 Jul 2024 15:18:13 +0200
Message-ID: <20240723131817.262596-7-zli@ogga.fr>
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

Add controller attach/detach support by using
usb_gadget_ops.pullup() method.

Signed-off-by: Zixun LI <zli@ogga.fr>
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

