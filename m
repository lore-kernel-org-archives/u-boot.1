Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF594C3DA63
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F78A88B68;
	Thu, 18 Jul 2024 19:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cHVC6mFB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E6F688B59; Thu, 18 Jul 2024 19:36:58 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0B1C88B20
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-427cede1e86so5107555e9.0
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324208; x=1721929008; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPUIO2JDD3ZktKauX7bMu/44GB3SHOoU1u34absaRVc=;
 b=cHVC6mFB+SxgInGtqlAAC92e7R4YjxhwUwRQz6dT3j1eVUQ3YbxjMR689wJys3dART
 RAdmvYmOD6f1imBt9Leoa9Aw/juIPf82o7djmUsCYaAE4qkNvOeYcyQvld9hIBku/VNj
 yjQlgZjFyERM7GW97wIA3lRtuy+SU6Z2+JywQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324208; x=1721929008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XPUIO2JDD3ZktKauX7bMu/44GB3SHOoU1u34absaRVc=;
 b=lTeemK4OXDJdkm4hgghKQomaYUg8RlSgojFeQakdKjuEEihigz4KjvUA3vpkwYESht
 2gmxo8mIWnK3kYm8g1SCeABsOisaHvzzx2tjzznvajRZSlXXS9wjDmT5z3NCTYMfc/5X
 i99o/xqGbQoDG6RGnmco4UJgkDBBDMFYXq38Tizmet+RLu2ZnwCRJ7iSkTzaw+s2VDdI
 MDGl+VaPcvBnbdAuiiJPExy0b0NSUSYO1rDE+Xo2MVh6+BuGNbveonFMRQwl2F7haMaO
 3k/+HL5jwTQyJ6gBcx2lzIqapr6cFrIA+MMLi2JEKkTSIfCfad4l4Vp8OhBpVe4U5Nrf
 hOsg==
X-Gm-Message-State: AOJu0Yz9foG7yPNw/wPVNz+xqsX/LM3FcyyYtJ3I6BI+a8SsQWdAk0as
 xqXCqNL7UCqWgZuIjgBYVa3zGUsGetZfLMNSPCDf6+sAIpu42fJ39adrclGqxbJSEp60K/0laSM
 =
X-Google-Smtp-Source: AGHT+IFIyjpek9O6zl1n4lIZk/vS4JzOQs+l4YRz9KVS/wMft2iwmnfujuCuS6ISMOUgFdN3VRDLYw==
X-Received: by 2002:a05:600c:1d24:b0:426:5ee5:3129 with SMTP id
 5b1f17b1804b1-427c2ca5692mr46034295e9.2.1721324208091; 
 Thu, 18 Jul 2024 10:36:48 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, Philip Richard Oberfichtner <pro@denx.de>
Subject: [PATCH 16/20] i2c: Remove I2C_GET_BUS()
Date: Thu, 18 Jul 2024 18:36:07 +0100
Message-Id: <20240718173611.4014274-17-sjg@chromium.org>
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

This is very old, predating even the legacy I2C support, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

