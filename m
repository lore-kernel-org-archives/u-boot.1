Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE02C3DA63
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A42DD88B44;
	Thu, 18 Jul 2024 19:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dvfQDtcT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78D7688AE1; Thu, 18 Jul 2024 19:36:42 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 208AB88B1C
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-427b9dcbb09so5121115e9.3
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324197; x=1721928997; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Sm+UN7oyTYWDzX0pn/w/HhdULZP3q6SfO2OPQ9jUV4=;
 b=dvfQDtcTCCAxWqTnXamiiTWveUWZ7Pg4LWXbuHmQY+BJ1jfXRQjkD98g0KBSikr/Wj
 W5qe7aveGmOiAEvaVXuZTkHDpVBCAkoNovG08CxGZziy/fxRYwkx3qeAYCl2TQeRQPre
 p3i94zLNao6K/LQkvhZr80Z6SIoI3uNWfQlxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324197; x=1721928997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Sm+UN7oyTYWDzX0pn/w/HhdULZP3q6SfO2OPQ9jUV4=;
 b=cvvZnQoC7nPUGy5oE39SF5iF9LODFJQGxucU6UPZ3GRdDdeJGLklUZGWP9KAdqH1kP
 8MjbM2qPCjLlZAjbCkjsC4I9YXkMxT7eRRUYAXQRHK0v1R29M6WIZvdclKwYpHeSpTQY
 UQcHyfFn+zejzLcfe/InRfCit11CQALuLfXCnoIdxe+byB9A2d7+ouYOxeJk3SEHKcfQ
 PFnqbTHwe8N9YoK+b2QuNDfM9z8TwG3yNFhRRB0M0dsi3/lB2UdeujHdDb32NReGkPLU
 gomtIsaTwum9iTpexP87joGIH/YjE8XcZFVUku9uA+Gxp3xBFT3xjFRGbLFJJXd5c9Nc
 SuWw==
X-Gm-Message-State: AOJu0Yz+2hUFukVGYJwNOYIIX8MWUE4cCougmHQjfh70FAnsHFNIR4L9
 fi0XM1lqXOMZ+K+HeaULJQtZuINylsfMGRHBXfQnhWP4h9QiQ+AIeMI6XtkRChfdEcuBn1EgF6M
 =
X-Google-Smtp-Source: AGHT+IEc2LLn8FqLeH0pe2lCaha595Azluz3ZKh7svVrn1GQXszOf/fh6J2f5F1iQj4OGxPAGG/pIA==
X-Received: by 2002:a05:600c:15d1:b0:426:6e8b:3dc5 with SMTP id
 5b1f17b1804b1-427c2d331f0mr38725745e9.32.1721324197255; 
 Thu, 18 Jul 2024 10:36:37 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Philip Richard Oberfichtner <pro@denx.de>
Subject: [PATCH 03/20] i2c: Remove IC2_xxx enum
Date: Thu, 18 Jul 2024 18:35:54 +0100
Message-Id: <20240718173611.4014274-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718173611.4014274-1-sjg@chromium.org>
References: <20240718173611.4014274-1-sjg@chromium.org>
MIME-Version: 1.0
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

This is only used by devkit3250 which is being removed. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/usb/host/ohci-lpc32xx.c | 4 ----
 include/i2c.h                   | 6 ------
 2 files changed, 10 deletions(-)

diff --git a/drivers/usb/host/ohci-lpc32xx.c b/drivers/usb/host/ohci-lpc32xx.c
index ed04cae7afe..bf89bf8ab49 100644
--- a/drivers/usb/host/ohci-lpc32xx.c
+++ b/drivers/usb/host/ohci-lpc32xx.c
@@ -94,10 +94,6 @@ static int isp1301_set_value(struct udevice *dev, int reg, u8 value)
 
 static void isp1301_configure(struct udevice *dev)
 {
-#if !CONFIG_IS_ENABLED(DM_I2C)
-	i2c_set_bus_num(I2C_2);
-#endif
-
 	/*
 	 * LPC32XX only supports DAT_SE0 USB mode
 	 * This sequence is important
diff --git a/include/i2c.h b/include/i2c.h
index 8d91b24b43b..1d3be3f6759 100644
--- a/include/i2c.h
+++ b/include/i2c.h
@@ -966,12 +966,6 @@ static inline void I2C_SET_BUS(unsigned int bus)
 		i2c_set_bus_num(bus);
 }
 
-/* Multi I2C definitions */
-enum {
-	I2C_0, I2C_1, I2C_2, I2C_3, I2C_4, I2C_5, I2C_6, I2C_7,
-	I2C_8, I2C_9, I2C_10,
-};
-
 /**
  * Find the I2C bus number by given a FDT I2C node.
  *
-- 
2.34.1

