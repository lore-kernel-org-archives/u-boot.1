Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997B1C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 16:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DFB481FEE;
	Mon,  2 Jun 2025 18:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="RW0phDzR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91A9B81E72; Mon,  2 Jun 2025 17:45:30 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80E0F81E06
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 17:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so33659705e9.0
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1748879128; x=1749483928;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t0e+SfJHKuu9n47kWHPigsybqp6o1gVcGQ7yXtPbIN8=;
 b=RW0phDzRTlP8DJYy3T84VwQyA/YzSWa+sedMgXZsaMnSi7J6ilXDx7v0sGsJ/tCe8Q
 LVZEmCQA8IrPxPa/m/NTqn8mRs+fbe5TZO4FnbNYkyE4sjxlv/MLft8JRV71coqiw3cf
 VtFPAu/F871h7CurgqXupxwIe9jyyuKmRZr6JMcqqqarTMly1GybhYUGqpN7d9Cib7xu
 3FjufBSmLia37lpo5sjMCE1q1TijmvOSbQyzCFuCXREYGnOMZUNU0rE7BjbeNLTsYQSF
 NvZp4E0gjBHVghOVxMjQGufA7L3ZD89xPPrxcNg9L8lpK55LuIay00tzZK6Vp/qKKMqA
 FAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748879128; x=1749483928;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t0e+SfJHKuu9n47kWHPigsybqp6o1gVcGQ7yXtPbIN8=;
 b=MsLKahrlMVF/WjujCQ0iQYrzB6ckt3dXLelRgc0oHtXPfr5+8TegSCaDH/OjMOP54N
 DR40C56db761EimIHccHeLEfFvnHWuFsaIt7mS19a2XV7Zjhjt2UEZttuDji33sLzy22
 RJRPSdVySNHQP4PpYAFAb8ynN6dXu872vJMiL7kolokAMaY2MzUdFTeAVUIEf/IRXKpy
 FVzKvSwjfVMpT0l3ZVXMHWh8onP2lvou+iecl2Uk9MC+Hp42bPEPdjUejB2xolI/MqXb
 3BD6VZvakj8J4V3H3N2wrLVdQ/l1elSXpqoV3xdh7KeWCoKXauvYASzbicWccIqxdPz6
 RRfA==
X-Gm-Message-State: AOJu0YwDmuVnbUeC4l0+rxD1Q1jELju3B3baIbh4iY4zmctNAKR6nHqj
 o/8G4QV2yacST9hDE4+k6Fd4GED1UPwtA2HH3BUYZkwPDfuDYyvHwH+CVFzF2i4ARjY=
X-Gm-Gg: ASbGnctt05YJ9F49wQ9kpcHrt3XfyQEmM5AMxNfck390g2VsAtTNDluAHtKRBV8eKvG
 WODwnQGYKp0m1QKyornddKeV31FUI5/BXEMzZj6OgFOjAV0YxMoozSDayquP02qIqqv1Kd3IYh/
 NRPJ7jIihYDZa1POyfy5u3TV7Ha5hTBl0aRVUgdosJlf8g+ipr3UpGQ8zcb4V8Vu0d0gGGLBFzb
 6mGuy/pFHNjFaJmKujsdcOEAWPD6QsxBpeNL/HAq7ddr1c54ba9AcE7P2HyJcsJp/XV9LRnYip0
 aC/9tvymejQDCI581PuighgZNYD/XvveIzqFxsaMtB1WZQzziA==
X-Google-Smtp-Source: AGHT+IEQayuicv4jss2GPYMnKATvOEv19u3sXTjM6MXxG1LcYZ6DL0HNFNAQhQHm5kdMsmKrz7MDNA==
X-Received: by 2002:a05:600c:1c96:b0:43c:fc04:6d35 with SMTP id
 5b1f17b1804b1-450d64e2a8amr128556195e9.4.1748879127644; 
 Mon, 02 Jun 2025 08:45:27 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa2247sm129407665e9.10.2025.06.02.08.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 08:45:27 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Mon, 02 Jun 2025 17:45:08 +0200
Subject: [PATCH] usb: gadget: atmel: reliably generate disconnect by
 disabling controller instead of toggling PULLD_DIS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-pullup-v1-1-edcde5a050dd@hifiphile.com>
X-B4-Tracking: v=1; b=H4sIAAPHPWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMwMj3YLSnJzSAl0L42RTUxODlCTT5BQloOKCotS0zAqwQdGxtbUARuZ
 pkVgAAAA=
X-Change-ID: 20250602-pullup-83c5540db5cd
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 02 Jun 2025 18:16:49 +0200
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

Contrary to the datasheet, setting both DETACH and PULLD_DIS bits to 1
does not always drive the DP and DM lines to high-impedance. This
prevents the host from reliably detecting a USB disconnect and subsequent
reconnect.

The symptom is that the first gadget command (e.g., dhcp) succeeds, while
subsequent commands (e.g., nfs) fail.

Disabling and re-enabling the controller entirely, instead of toggling the
PULLD_DIS bit, reliably generates a disconnect event.

The Linux driver works correctly because gadget_disconnect/gadget_connect
are always followed by gadget_udc_start/gadget_udc_stop. In U-Boot
pullup() is used solely.

This behavior has been observed on the SAM9X60-Curiosity and
AT91SAM9G25-EK boards and has been reported to Microchip.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/usb/gadget/atmel_usba_udc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index f9326f0a7e7d913bcf201ba3e4aeca9a099e7be7..a38e70957402fb3ade3de611d73e29b990d00703 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -521,16 +521,11 @@ usba_udc_set_selfpowered(struct usb_gadget *gadget, int is_selfpowered)
 static int usba_udc_pullup(struct usb_gadget *gadget, int is_on)
 {
 	struct usba_udc *udc = to_usba_udc(gadget);
-	u32 ctrl;
-
-	ctrl = usba_readl(udc, CTRL);
 
 	if (is_on)
-		ctrl &= ~USBA_DETACH;
+		usba_writel(udc, CTRL, USBA_ENABLE_MASK);
 	else
-		ctrl |= USBA_DETACH;
-
-	usba_writel(udc, CTRL, ctrl);
+		usba_writel(udc, CTRL, USBA_DISABLE_MASK);
 
 	return 0;
 }

---
base-commit: 4d3b5c679bc9d5c6cbbeedcc1e4a186f1cc35541
change-id: 20250602-pullup-83c5540db5cd

Best regards,
-- 
Zixun LI <admin@hifiphile.com>

