Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C749CC3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D87598894F;
	Sun, 11 Aug 2024 16:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EQ1YrvHc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5002D888FD; Sun, 11 Aug 2024 16:51:30 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4E00885F4
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-81f9339e534so122482139f.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387884; x=1723992684; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLlhsHNmwBQAwHbutlEELNT5MpVWkquq/cP/4pFj4TQ=;
 b=EQ1YrvHcG57p4zvmeq0BXA/eM8l75q3xoQa2wJBEJlLk7gd05OiMaerLVHeE99JZXN
 NAd0Tk6HTvBxtrqcOfrLiRXoV1QPxUVAPqttJTUIVEWWIyLR7QniuJFNqD4ekJxyCH19
 3rAv78qRDIH/O8Y7AZA4fNvlVdvkqwQIOEmb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387884; x=1723992684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YLlhsHNmwBQAwHbutlEELNT5MpVWkquq/cP/4pFj4TQ=;
 b=VDoWJ5Yqc/mSPdRTqiV4hb4WQkS0hH7Onh42t20EF2ybkPMdGrikA2AzSUWf1YgnJW
 QxB+gilwqV1a5TN1Un9DcFDS3PsXKsnttWUNVf4cogheTwQelI2fD4nGNoUkWaiPIKt4
 bMxtpavs9H+vXUgFYyZ80aUPJkDEH1CJ6103Qcz/BDkOdJXTtKw38egrRv3KDJslgEJa
 qT+MZYlqc2bcXr7KH5nz6iS6lA0CzZtjMbKc+Z/NrDMLGc8CsbZSnbxy71xU8aJR62pU
 mgs6PxqXvhkkczkYMGun6VvOjXCLoGsdyuhPc4COlIWXu/CyoZt+T/rm09oAgN+1IZDt
 TbMg==
X-Gm-Message-State: AOJu0YzXTxJG/EY5XzPvo8bog8IKtUhRbj40eATYhDDuEHiLPyVbjvLK
 siiH1Aaois9ww9ERU6ijqYgsVezrC2n1b/DRsCrqD3+sAwQvKquxVMnBv+lQby3lj6c+J00jg9A
 =
X-Google-Smtp-Source: AGHT+IEKA0wTHn/jGGu15BKWQtJTl4drp22C1FEAkreLGbO5X3p+MYDQWCtphZoquWHJszBFfiiGPA==
X-Received: by 2002:a05:6602:6285:b0:81f:a447:632d with SMTP id
 ca18e2360f4ac-8225ee8990cmr819977139f.9.1723387884646; 
 Sun, 11 Aug 2024 07:51:24 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca769fbe17sm1076047173.101.2024.08.11.07.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:51:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 14/18] i2c: Remove I2C_GET_BUS()
Date: Sun, 11 Aug 2024 08:50:43 -0600
Message-Id: <20240811145047.4189460-15-sjg@chromium.org>
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

This is very old, predating even the legacy I2C support, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/i2c.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/i2c.h b/include/i2c.h
index 1d1430b74a6..b6727bb2a73 100644
--- a/include/i2c.h
+++ b/include/i2c.h
@@ -947,13 +947,6 @@ unsigned int i2c_get_bus_speed(void);
 # define I2C_MULTI_BUS				0
 #endif
 
-/* NOTE: These two functions MUST be always_inline to avoid code growth! */
-static inline unsigned int I2C_GET_BUS(void) __attribute__((always_inline));
-static inline unsigned int I2C_GET_BUS(void)
-{
-	return I2C_MULTI_BUS ? i2c_get_bus_num() : 0;
-}
-
 /**
  * Find the I2C bus number by given a FDT I2C node.
  *
-- 
2.34.1

