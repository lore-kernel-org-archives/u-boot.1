Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A51DC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 22:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E2F882F08;
	Sun, 29 Jun 2025 00:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dSrSvMnN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E9198277D; Sun, 29 Jun 2025 00:44:10 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA09182E40
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 00:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4067ac8f6cdso821780b6e.2
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 15:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751150639; x=1751755439; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s8VeWNuqrrqa7/ErXeu9AwzCwA4A3xyjNVOe233q55g=;
 b=dSrSvMnN2OsDYUBYG71YeR/RPlccVmOufgufP6s4G5HZF4GF22xG9sgU5vMXvMH+pc
 NnZDI23ZsLbYnpGYFcxCQ8IJIrIHBC6B77Gpw7hfN4ZIxtxdtww4/m7+X7YQ/XY5+Pn3
 vGNJoFOtEGc67SV4uSyeC25ph94ktJ7XRXmlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751150639; x=1751755439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s8VeWNuqrrqa7/ErXeu9AwzCwA4A3xyjNVOe233q55g=;
 b=SHw7tdBJud1FtNs2T7DVH8odOXGFGfonIQzhHX9wdUWso+RFMWGYvpa9YXbbpdWBuQ
 3Gl9OtKT2+lMM2j2w+GfGRj+zE7Y95WFEA+cYZiZEMvkmQHcIhS2uYOTTuHt9JqggA8D
 WuYpnJhRIKfon3jnOqqEV0iNOPINKJ+s9ZALbUD1yTIng9QJjTOVHVPr2R1XBJuvjnGt
 ve6IGJx0N/6AVkpWBXk3AZ2CAve7FlAmizIINBi13/tHomYC1WefSNuJlC81ryGKC3oU
 zQeYpYYqAymi0+jKfZE/oFHavCqe/E36+D4DyXB2eicyVN82k7slnvAFA9L6vQmr8N3c
 E9CQ==
X-Gm-Message-State: AOJu0YwMPxvU8FLsWiULr7UTZx1D24CsB517F6zdDGiBwXuqT7o7avVM
 bi6sQzTbJmNjPLbXRbPkeEWXhfNzkytiC+U7cXPJ2p7Xr0xI4ek0NoB3lFzNt/l0LUWeMuoki2T
 SLIClcfc=
X-Gm-Gg: ASbGncsr/wBDXsSh2ymFjYRSpuqu7lvguhZ2AJeISgYHMmh8UHGkXGKecTzraSyDmN5
 6LzIGUoaRfi0ACgHpx2U5wAY8H+twf1sJx3wmd9f4z7ChKaYjbsHM/tuEPX8flJ0Gi4KEleUWAV
 +WIzmmASGJ8QO5bQYDsngfTS0vX6bzLXXyMa+bVOBto6cj2ZeXY59O/N5Ak24dPXNaAAi58xsxu
 z4Xc5l8nz2YFY0JlKof4t3sgjfGzEY3OJy8SBDdupp4dNXxdYRsl+v3iWU/NmXbe0onWPIpIeq7
 vTtA+JIf3fjoGQJWvwjCtEUkQ3gU6JnIvaiFg5s6Q/u0aqEtEUDZaUJDXrSQ/yTjRO4/ZK5XhQu
 O2UiQTb0tobY6jzpx5/gR2MLDMA==
X-Google-Smtp-Source: AGHT+IFEmHFOHGoRnzbA75XBhQemEeRzWfOYKosu/5qjvU7ilkBHxfjkUEZleVINHZcWNC3rb5c+Vw==
X-Received: by 2002:a05:6808:2f11:b0:408:e5f8:9e2b with SMTP id
 5614622812f47-40b33c72ac9mr6737896b6e.10.1751150639539; 
 Sat, 28 Jun 2025 15:43:59 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b3243e4besm1013148b6e.50.2025.06.28.15.43.58
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 15:43:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 4/5] include/spl_gpio.h: Audit include list
Date: Sat, 28 Jun 2025 16:43:51 -0600
Message-ID: <20250628224352.85694-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250628224352.85694-1-trini@konsulko.com>
References: <20250628224352.85694-1-trini@konsulko.com>
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

This file does not need <asm/gpio.h> so remove it. This file does
however need <linux/types.h> so add that in. This also shows that
arch/arm/mach-rockchip/rk3399/rk3399.c and board/lg/star/star.c were
indirectly getting <asm/gpio.h> from here, so add <asm/gpio.h> to them.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-rockchip/rk3399/rk3399.c | 1 +
 board/lg/star/star.c                   | 1 +
 include/spl_gpio.h                     | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index 99597076d2ce..43d151708e47 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -16,6 +16,7 @@
 #include <asm/arch-rockchip/gpio.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/hardware.h>
+#include <asm/gpio.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
 #include <power/regulator.h>
diff --git a/board/lg/star/star.c b/board/lg/star/star.c
index dc5937541016..0b4a433a5df6 100644
--- a/board/lg/star/star.c
+++ b/board/lg/star/star.c
@@ -9,6 +9,7 @@
 #include <fdt_support.h>
 #include <log.h>
 #include <spl_gpio.h>
+#include <asm/gpio.h>
 
 static int star_fix_panel(void *fdt)
 {
diff --git a/include/spl_gpio.h b/include/spl_gpio.h
index b33261a6485a..a8aed4d77b96 100644
--- a/include/spl_gpio.h
+++ b/include/spl_gpio.h
@@ -9,7 +9,7 @@
 #ifndef __SPL_GPIO_H
 #define __SPL_GPIO_H
 
-#include <asm/gpio.h>
+#include <linux/types.h>
 
 /*
  * The functions listed here should be implemented in the SoC GPIO driver.
-- 
2.43.0

