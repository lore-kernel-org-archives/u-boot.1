Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2AFC3ABD8
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 22:50:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04F0382B33;
	Thu, 15 May 2025 00:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gOJL0y9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB63782B18; Thu, 15 May 2025 00:50:15 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BB5F82AF6
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 00:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6060200710bso216336eaf.3
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 15:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747263011; x=1747867811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VqfjVpTWj+y8dRlV1ep6T0xbfT8wTkp8X4W1/kUpuj4=;
 b=gOJL0y9kNN8rJfPRkvJx2EM/kbTtCfbCNry2Nke1GWoUgp2aJobMkVuhv1xyLtK8GD
 LfOPPsn69JtHEg6j8sduzaEcdOpYVZd7tHH1jy3ia8k6sHM8oSPCB51/X47ioa+oL+V2
 hIJIa5giiFXFDRZQUU/CWAz108DH2nziXiVPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747263011; x=1747867811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VqfjVpTWj+y8dRlV1ep6T0xbfT8wTkp8X4W1/kUpuj4=;
 b=SKnLAdR6E3KDBsZU3yivDZ3k5ax2dQzjkl/jGbeBpNWHxAZA+a4B651a6ZK5Tt5d1i
 cevjILLab4WPhWa25lRUefisqsus557TxuUb4EMN/Yf+dUQWwJ1X8DqAHgeOoeubbJJh
 Z2zSZbtiVHVDjx3wi/fyUwuRf2yMJfwY203cax2Tq+T8ajy4M6CT+4zgz9ShZ9qoElrJ
 EwIo3pCFtPWs9NLNOlQ/6GlESVl/A/QV7Dh/Srh6CXWSNt/K7l8QTuBevTQYn110U3pJ
 dgxY6fqn+BNyVm3zS+Nnd/tsg6WGn2ofp9oSDxZlPO9MTJ4kD/n5NvJyX8cbtDVbs5MJ
 OKsg==
X-Gm-Message-State: AOJu0YzLe2W0YK61oazdmOQXSpF6FhfwmrX5MzT+3q5TTYHa5E36RG+n
 chklkDGQTt7GqQPUK29q/GpA5rDKbnHd2Q/gITqJIWp+Rw97yb/fTAi0wRNRyL44hYCgJQUZ7Bh
 K
X-Gm-Gg: ASbGncvjJNx/EDLSd/Tms2xzmIt7Kk2BVo+HQPDa/+ZgJGY/ry0rfuLXEEJq+d6IUIj
 Hnaaqjxwk1cDne+CCoDlh43wnfhfZRrgR7Vly7aQFtWIU7ugyhxPwuP1n058Dr1fvbz/9iGv29Q
 /lGvf/0VnlCLksV4/0ZaCRQMlIu3WtK4ljqmU8F4NKQVlZNXhpDUINtd4pKQTPGQgPYgSvQwGxH
 3Ucze3GJpSTAGN10nPvHC9cU0Xg9SGa3I32R1YLk5RrelVg0dEz/AHkP9oAcwZp+ydFGZNufw3I
 AN6LKykq8sf+WKwMeYiUu8wGtJBvBPzFw0eW9i5PZF59BEqh6uruH+oxbwvsvCBp6I9WM7YR5c8
 1XOwkOGk+GJ/xJkU=
X-Google-Smtp-Source: AGHT+IEnKoLgM9oQPoLCL6IN1h9Qa3m8hWott77fRaI480jdhTkta2/u2ld+/PXMesLOuJ2S0d39pQ==
X-Received: by 2002:a05:6820:4cca:b0:607:ae77:59ee with SMTP id
 006d021491bc7-609df159902mr2512372eaf.2.1747263011243; 
 Wed, 14 May 2025 15:50:11 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6083fe52271sm2636530eaf.21.2025.05.14.15.50.10
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 15:50:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/5] gpio: pca953x: Add missing <asm/byteorder.h>
Date: Wed, 14 May 2025 16:46:02 -0600
Message-ID: <20250514225002.15361-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250514225002.15361-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
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

This driver takes a long implicit include path to get this header which
it directly uses. Add it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/gpio/pca953x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
index 2fb14590c0fe..f0a79b92b024 100644
--- a/drivers/gpio/pca953x.c
+++ b/drivers/gpio/pca953x.c
@@ -13,6 +13,7 @@
 #include <i2c.h>
 #include <pca953x.h>
 #include <vsprintf.h>
+#include <asm/byteorder.h>
 
 /* Default to an address that hopefully won't corrupt other i2c devices */
 #ifndef CFG_SYS_I2C_PCA953X_ADDR
-- 
2.43.0

