Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5BAC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 01:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83616835B6;
	Fri, 18 Jul 2025 03:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LV86pWtU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 346BE835D0; Fri, 18 Jul 2025 03:15:39 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D08C8357D
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 03:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-41b8e41a2bdso1035954b6e.1
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752801336; x=1753406136; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gThS/jTEAxoKi9QmMAnvBZEj+E7D6C1y1JsUSu/Qx4Q=;
 b=LV86pWtUd0Bm5mCGQFrQAh7vOcOF16tlrcgucLzPugqd/Z1z2sRD0p9b+5r/RGsvsw
 LGANk4sEue+wUbP4V/Hwij6+GAMZlR/6S7sRlK0RtCdnM3Oj+NibeMXGXm6dtpib5UMy
 c/43tLKDd/gfKdfvbB3AcREpAolGVpV8kXAgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752801336; x=1753406136;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gThS/jTEAxoKi9QmMAnvBZEj+E7D6C1y1JsUSu/Qx4Q=;
 b=OIJV7yWEvbyt/kCSoZRwD0MUZv0SydRtak23MKGCGTxoD5OJAh/uPKl7mf/riKXOCu
 BIIsyX4ENv2eAonHsZYbbk+/3HkK6GJpEShpdYdS5qt+HfDpw8x9HqZIHdnOAkcXkJUL
 QNGA2Mc/3HEpGqG+tnGAOqkI3tNZCfkTgssRikdhedDIQDpjNDF4BPDjeJLtIU+R2j25
 lXrHm2WMfVJLuIpoqih6Xog/1m2BKUH4yyF89ZwX41Lvchc+YAxGb1cIFGYC5DlYTY7S
 tii1O9hOqFxszF8HSYq6BaD5kvlM/71pSlFOMeKmWu47RinlhqmVfcg7c2U5dZJjmc9q
 xK1w==
X-Gm-Message-State: AOJu0Yx/+ZZk4GCXTDJlsylTU72drzl54sSxgrWH0pyo6K38dV8pGWHG
 ehBg7NaDv5fu5J4ghOLQtstvKTwW/UoC1hqYnA4JrS/M3tEkQwVVMVq7+dKdNvxxLsJlJhR0fS1
 VGL4AzmE=
X-Gm-Gg: ASbGncsWo26GFMV0FFo/Q1SNOZ3s2stg759r0rtog/73E9qHB2+7hznPTWgUUSldf7N
 lV52mOI55Awgzrl9SfQ6Ja91rSh/acWYrtMaPAwhLQpmpL3q1fDHJw4S3IPRZYxSlrkLNF6QRaH
 MLIgLE7apfnwsEouMmUOgGhfc7m9+J/4YEbMcZaplcWluvCBYugx//yJMwx+f8Z5bdpOSUctTA4
 lzDLaTQxDqDj3mXYVo3ZVixXb8eAYyAC9lytXM3gQ70cuRYSe9n1/E9wk7ISjf4sZLBZMkVMT8u
 6L6MJyf6h0YhEOi4A6S+K5Vq5o8wGa9ceeTrBK5F9yy7Z1EWg4RYCH/PyT1haHvT4Hb7Mz6Y5wh
 Lr0lMNWVkr+tLD+VpPXGfgZmmZUoa2+jilpoRFAdbpmYafunZPk0jEnmF6e0=
X-Google-Smtp-Source: AGHT+IHOR4MOaXXptgq7BGd4F6XCFCae0JaoILElM2862EHlOUkOtVwxS3NQzUMpqc5ykSu/RymbtQ==
X-Received: by 2002:a05:6808:218b:b0:3f8:bbf3:3a18 with SMTP id
 5614622812f47-41f61a660bfmr1564444b6e.16.1752801335742; 
 Thu, 17 Jul 2025 18:15:35 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-615bcab4e9esm76624eaf.12.2025.07.17.18.15.34
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 18:15:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] drivers/net/ftgmac100.c: Fix a debug print
Date: Thu, 17 Jul 2025 19:15:34 -0600
Message-ID: <20250718011534.1333906-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

In the debug print in ftgmac100_send we want to say where the packet is
in memory and what the length is, so use %p to print that.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/net/ftgmac100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ftgmac100.c b/drivers/net/ftgmac100.c
index f5ea2e72d1bb..33d1f7da3d76 100644
--- a/drivers/net/ftgmac100.c
+++ b/drivers/net/ftgmac100.c
@@ -546,7 +546,7 @@ static int ftgmac100_send(struct udevice *dev, void *packet, int length)
 		return -EPERM;
 	}
 
-	debug("%s(%x, %x)\n", __func__, (int)packet, length);
+	debug("%s(%p, %x)\n", __func__, packet, length);
 
 	length = (length < ETH_ZLEN) ? ETH_ZLEN : length;
 
-- 
2.43.0

