Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A4DCDE03E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 814E288F9B;
	Fri, 27 Sep 2024 00:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KoF2wS1J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA6A88F9B; Fri, 27 Sep 2024 00:44:06 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24D8288FF0
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-dff1ccdc17bso1669790276.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390643; x=1727995443; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ZO7COnddIrqAVGIfTe8PYYpYX9tjIea0t4HCUDQD4k=;
 b=KoF2wS1JN2kmvhp+Yte3GEZaH+kVMG9YnXGe2yDRDmwGgnwc0Vck9Ueki9FjsA5q4C
 9e1VBbpYVtcGX2vZnc6nqrA3tLnYSGWYZhq0eo6RgDXXB8HZnPv3wXMxjoiKsNg4TGYl
 u8tuv5GA92ucF+IpRkNq7DFUwRpbAB9XUipPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390643; x=1727995443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ZO7COnddIrqAVGIfTe8PYYpYX9tjIea0t4HCUDQD4k=;
 b=febvoo9O9H1crlSf68R0wAHDj5S1HwCYKtJhzF9pLd/st3MU3llJ/hOoDCfVzSinVJ
 TieWGIqMMn2HRW9E7vsdt5H+5/WeL72tTxCIwTiYJhbAqhpbUwzeqvddiw8EEHNfIwsX
 UGgFkn9fe9A07g6eiQu5LFwdEkNPnwoSNq8BFJidvQUtaEfuTqQ598gBfEoWW0nNzQBT
 U4sax+eGRw4BoDDaMDObKoSbbVXcD2ZFrC3bwo0UFRAPChJhVpOgRE9So6daCQQCs+fw
 ZT+DMeFkX2Cy/E6sYJ0XgHKy/J2N9mNE3Q9/N5/nwr7U8RUWuzyujFd4M1erq3JJHdJD
 aY4Q==
X-Gm-Message-State: AOJu0YxeNzRH+RsOsEr8K9jWorEJVRvZpJRGm+d/N+m2uZtUG30qoFip
 bxoK4nyF9YO8DKX1WibR/iN4FazkteVLY/j08//juy8cr1d9JbVeJBhk2Ahmn6hr9tPiYCibLas
 hq8zGwL4=
X-Google-Smtp-Source: AGHT+IEjbLto/79oguFGi1Kok/ZG3lB6FumDd0+1r7FrJ+8/lSokw9Wdd4ahFLsrgv/4kZ1PZoeZCw==
X-Received: by 2002:a05:6902:1b13:b0:e11:45fa:e344 with SMTP id
 3f1490d57ef6-e2604cd34edmr967331276.43.1727390642755; 
 Thu, 26 Sep 2024 15:44:02 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:44:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dragan Simic <dsimic@manjaro.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
Subject: [PATCH 27/42] rockchip: Simplify Makefile condition
Date: Fri, 27 Sep 2024 00:35:52 +0200
Message-ID: <20240926223814.1276764-28-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

If TPL is enabled, XPL must be, do drop the redundant check.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/mach-rockchip/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index 76756c3661b..70f0af4733c 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -15,7 +15,7 @@ obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
 
 obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
 
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 
 # Always include boot_mode.o, as we bypass it (i.e. turn it off)
 # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,
-- 
2.43.0

