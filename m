Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8C8D2D8F9
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 11:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB498402E;
	Tue, 27 Jan 2026 12:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hSFZahcT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3004983FD9; Tue, 27 Jan 2026 12:04:23 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F83883FF5
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 12:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42fb4eeb482so3749249f8f.0
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 03:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769511861; x=1770116661;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eBU3LQFZh6/tQE8LcoPP314gXDDKlNGeF6NpCuFbL7o=;
 b=hSFZahcTdDWMsIGIX+YxVbbiKBIoDG2iDuv0nrGm6h5+EElJI1CovjFqnWCMFQNGwW
 X/C6NIdH9mxtvY4yy0GDrDnKY8vt9hKe8d8gQo2r2k/mLyXJj8Fpt/ucZx6ajZEKhVfl
 SgGdurfRd8sHB8Muf/XtN3oeUC8VQ7hTSGDi3F2gZoLOSrY9S69jSLcfKmaXcuUMoaEv
 fqw0LaWTy5O4q0WXr8hQRm9yRbKCcqpsiisls8wwGkC3DIYWldNqnqxcWM1tGqok/Okv
 k/3eX6FsFoi4uNM1jrlrQZK2CmVCrKoM7ghm48m9nCKAXXq9imJNnTrWHvqFI7iDFcv8
 udOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769511861; x=1770116661;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eBU3LQFZh6/tQE8LcoPP314gXDDKlNGeF6NpCuFbL7o=;
 b=TIXsnBtUt+FTSXK6BA8DdDfGWIrQDR6S1GNSazGBw5NoTf2XeJSP4ikzPEJXaChxBz
 ocfaxuilFfq9rHcriAOcskemVLSEHSTgO+jk8mt17nHAhy4VGyYZ7DYVlnd/LPcKZft5
 2Rkaa2BaUdMTjqpBSd9CdiYxltGXu3BpIs0iHW7CR1JaUdpI+imjN3tw3l4pbGhEjVrF
 UssOqakKBKAoJhvCFyMZHGdOa/5VKzbub1m8BytquYzQUJpV5oY7+Qg0FvOrEaL9jqyk
 SwJiqJs94F9n6T5XUDCWai2czfB8IoOUSwXB7fKH7SsJ6URIoRIb1hzKBnVhe8Uk7di6
 adKw==
X-Gm-Message-State: AOJu0YxUK0FJnMDbtsnUsYdwMAwRAdoAGW/f2pKV0l+FVhiq3gRwbtio
 /bEjDbjb7WYnD5EnDFNPmc89jxn/x5gPuRAi2+LR/PihNbd0KLm3jh4kJ/9sIHycbpQ=
X-Gm-Gg: AZuq6aK5cmkr+hoBQ3wqyAHx+anLbxSz2Z0fSLu9vUvGzqEVlPiuBgFEskkZnXvGIvw
 PV/gFff0Ix2kGuQn11tMx96k7U+EHL0EvaDdmUKETLxmCqzpixiseTQwbH3pNGDPFzWCgI7SZew
 U76Sl+/oNxyKD8NL3mxsIm+8L+GMhxjRyOA6I/CeRZXCdCHgelvqSSE9JdoPqBduMbVWI1zAG0U
 Fo2rzG+E0L0KT29H6VVcf4cCWjfmNz5W/lOOOSyjROTPNYvW8uk7QzeoEsDP7qXhLjZ72Ca8x3Y
 acxf8Oc6Xl4HLTz5ysWy+55VjADbTEa78S83mfopcHuYWVOfWmlaALTKuGqLX14ofDJMGC1ygKz
 XuxPj4cr8lTLvX4H1GGzbIeWigxQSxxJFi49+QxlQo+d5PqY5ua47xFqigDCzZnzotcvc+GM2xk
 SaQAbKrfAH
X-Received: by 2002:a5d:5f49:0:b0:435:960c:5284 with SMTP id
 ffacd0b85a97d-435dd0b36d7mr1952527f8f.29.1769511860521; 
 Tue, 27 Jan 2026 03:04:20 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02dd4sm36977907f8f.5.2026.01.27.03.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:04:20 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 27 Jan 2026 12:03:35 +0100
Subject: [PATCH v4 1/7] dm: core: lists_bind_fdt: Remove unused variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-musb-probing-v2026-01-v4-1-ea3201e0f809@baylibre.com>
References: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
In-Reply-To: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Simon Glass <simon.glass@canonical.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086; i=msp@baylibre.com;
 h=from:subject:message-id; bh=qgP934dVDEk8Kapjd/TeeEKuzU949V3+cr/Yc+Yl9VM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyK2RO2f93htmTnnuzHl7s3z7fz7L6b1sG7euP1kLKTV
 8NT+ZSudJSyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBEssUY/pd8MLToav4j+e3g
 lVSmlMxt0i9+e95tLzq20OrBy5AE+csM/8s+RzbF837S65u9b0alYqg8t/PV18mn7vxvqMl6OOm
 cORsA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

'result' is unused in this function, remove it.

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/core/lists.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/core/lists.c b/drivers/core/lists.c
index c7be504b6fc69ec2870a6766eed35cb9eba46a97..52ba6c7bfa007b660b854de62c97ad3c1761f1a5 100644
--- a/drivers/core/lists.c
+++ b/drivers/core/lists.c
@@ -207,7 +207,6 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 	bool found = false;
 	const char *name, *compat_list, *compat;
 	int compat_length, i;
-	int result = 0;
 	int ret = 0;
 
 	if (devp)
@@ -283,9 +282,9 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 		break;
 	}
 
-	if (!found && !result && ret != -ENODEV)
+	if (!found && ret != -ENODEV)
 		log_debug("No match for node '%s'\n", name);
 
-	return result;
+	return 0;
 }
 #endif

-- 
2.51.0

