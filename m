Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA996C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3C76887CE;
	Tue, 23 Jul 2024 15:35:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="azQ113ZP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5908D88569; Mon, 22 Jul 2024 22:24:54 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AE9D88440
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 22:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4279c10a40eso34455065e9.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721679892; x=1722284692;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ow/MkZNhaN0Q+ALo6zog03L6AOiL3bQnBaB5IKkPxMA=;
 b=azQ113ZPuAGp9vZVAAVjfeJE3lOpB5FFfOOXPG21EJRQWSl6NpisUJPB6QRTFWkEwS
 2KkQrlvXMmqbxIAnHrwZJu1pj2xWKWw0RRtrH/LZzXV5aHla/KLbrqTJPopnjFRuMiEf
 lxwOzed5nLluH02RH3ehjduf40AgeLPoC4NbIJXGPQl+S08LClysp8C53yZ+vOw3raGs
 X2G1OdTObmqxHnJy2YkTE2AC4lMK+JBexJFodKrhFZuxh/pyKzV4y/zCoHMBpZ8NkvoJ
 iVSkEMtHDblOa+eIG9lTFRedtvMMuu/JhCvryssEd2/5tECnb4nUywAd9JPreCv75v46
 1oWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721679892; x=1722284692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ow/MkZNhaN0Q+ALo6zog03L6AOiL3bQnBaB5IKkPxMA=;
 b=cTxN1DdKjCY+hTHq/tRBBL6FDmUeCfEJXGRM+okmNpnZkKItod/tLk2W4gEm7CXBaI
 hFzJShfaW9KkiE9HGkJb2H+y7CKMhWgOhCxL6EgRZK1gX44bZRbBpnLme2F7JCLRebex
 TMfecJMgIR9e0algC294Nn1GmRFbd1sDpM2IoczUpimFR92t/yfF2Hywn6KEo7ikLoAO
 8pnnrjhILHVKzpcIvBlOgJxTnm5FwipIzHOVT5vY/zXnhAVXMd7lEhhsv5vHe+I3Ho02
 qG7vBZVsZ5EgTuOJq4zBvKC3L4BtpfhkwWdXhHMmrn1Y91/M/rCKYtgMKh8QJzy1qpJr
 AVwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU56tHqvsYsEkAahQKbWYAW3X0u2lN6luGa1cyVSPt1Qhs4ufeNYkTX/hgtjJ44vFoBPOSaTPEjdQJOER2lI9QEuHZBtA==
X-Gm-Message-State: AOJu0YyYHRln++1uTAJS72QLx+ZrVX5/XTbkH4VTEBg8ow54k6CfHJCJ
 ZB0DNgppC1fk/2RqfGbjVDUazSUvh2OzYxyhuLEjUB853NUcXx7XbH5xViSdZZk=
X-Google-Smtp-Source: AGHT+IEQjcc9k/yEvANeepBaWrevidXran1qeHDEwmYiK9r/rqAA7x5KWwSrMgMJY7bOvdcfUOwS4Q==
X-Received: by 2002:a05:600c:1f90:b0:426:6158:962d with SMTP id
 5b1f17b1804b1-427dc529759mr52414105e9.23.1721679891943; 
 Mon, 22 Jul 2024 13:24:51 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69071d0sm142982855e9.26.2024.07.22.13.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 13:24:51 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
X-Google-Original-From: Zixun LI <zli@ogga.fr>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>,
	u-boot@lists.denx.de
Subject: [PATCH v2 3/4] usb: gadget: atmel: Add attach/detach support
Date: Mon, 22 Jul 2024 22:23:29 +0200
Message-ID: <20240722202426.190986-4-zli@ogga.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722202426.190986-1-zli@ogga.fr>
References: <20240722202426.190986-1-zli@ogga.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jul 2024 15:35:55 +0200
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
index 3e3c5cb403..46f7ae9a0c 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1176,6 +1176,23 @@ static int usba_udc_disable(struct usba_udc *udc)
 	return 0;
 }
 
+static int usba_udc_pullup(struct usb_gadget *g, int is_on)
+{
+	struct usba_udc *udc = controller;
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
 int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 {
 	struct usba_udc *udc = controller;
@@ -1233,6 +1250,7 @@ static const struct usb_gadget_ops usba_udc_ops = {
 	.get_frame		= usba_udc_get_frame,
 	.wakeup			= usba_udc_wakeup,
 	.set_selfpowered	= usba_udc_set_selfpowered,
+	.pullup			= usba_udc_pullup,
 };
 
 static struct usba_udc udc_controller = {
-- 
2.45.2

