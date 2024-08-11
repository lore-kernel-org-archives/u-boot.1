Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0788FC52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FEA188953;
	Sun, 11 Aug 2024 16:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lR1g6yqz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 123398890D; Sun, 11 Aug 2024 16:51:19 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EAB788914
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-81fda7d7a48so150085739f.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387875; x=1723992675; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7rJUmHsF3HGHfVY6mHopT57uT1C/9ja8ecpYA7PG7XE=;
 b=lR1g6yqz8fmbgogaG9meJyslTdq2b5Tqx882vZmgc0QRUM5x/zACJN6h6FF+npjNn0
 zDMqEIMdvrxK9p1Pkf3oNPIUhGZiKxpV3QcFeOMN90VJVReDXfL4TI8U2pICRt93a/y4
 5qhQpNcbUYJKsoY6966a7u6ximDzofS81KQRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387875; x=1723992675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7rJUmHsF3HGHfVY6mHopT57uT1C/9ja8ecpYA7PG7XE=;
 b=phBNWiGKIUeAlylYqKtQf+kzet8evhsTP9qoF27N6HfYr2tBbecdZkEJnUSDBdKaAJ
 D5S7oocTNbZvzz97fwY/agilP6dyHBxI/PBOxXjiil7CAOAXrZNUB0oJLwgB9Eps5+7B
 IKu786CbH/nVLL5nAOJyxqbI7XEtnwJSbJfJxnLrBPm4D+oIBiAzp6Ak4fNrKGwswtrA
 vBItJSg2EAklRuKNJ/7JD5kT1fJjusiA8IpNagziKCn3eQTKlfER5ns7j7FHwb8d0Tzf
 JY47YZNuj9hH+shQzqMr7XcBEKssaVgJiYUXATi0YbjIiHi+90oIx6qXdc6kLHtqyO9A
 ic7g==
X-Gm-Message-State: AOJu0YxNj9N/3lH/bbwsWDTJJ4IebbDlf1AOFgf/uwml01aCVXJxSB90
 kDG6YyffsHs6tWhEjecP4Q2oRHFFJBPalt6/dEBTSK9h/sOSl+0JS6HGDCVKUm0yjKNtabrYmNU
 =
X-Google-Smtp-Source: AGHT+IHLZc2xUhtF1s3H6lLyfld1t0d0hwFLh/dn6Jn9v10QxvCMpD3MiWcfvXx5HPK/bXFOZsOscA==
X-Received: by 2002:a05:6602:1641:b0:822:3d11:106b with SMTP id
 ca18e2360f4ac-8225ee656c3mr1001217339f.1.1723387875213; 
 Sun, 11 Aug 2024 07:51:15 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca769fbe17sm1076047173.101.2024.08.11.07.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:51:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 02/18] i2c: Remove IC2_xxx enum
Date: Sun, 11 Aug 2024 08:50:31 -0600
Message-Id: <20240811145047.4189460-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145047.4189460-1-sjg@chromium.org>
References: <20240811145047.4189460-1-sjg@chromium.org>
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

(no changes since v1)

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

