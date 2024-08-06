Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06297C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 04:39:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01BC888A01;
	Tue,  6 Aug 2024 06:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dnnPikkL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB1EB8898E; Tue,  6 Aug 2024 06:39:18 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D5EF889BB
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 06:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70ea2f25bfaso111483b3a.1
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 21:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722919155; x=1723523955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6bpbZtMxXabJPCk+UIbCwETf4kl9EjfoyomrDTu9j7M=;
 b=dnnPikkLwZI6XdGQ2s9DMNuPC4cYi4FZ9vNeWY7O8zVgUhQBP8i0/4/LGVqLlayDM9
 g5HOjKSq0Cys6KsMYbEJCej627fG/ibvkY/MfGDg8oy95YQcOGMO94Zm4Cg+Z42u3I09
 JUFvvKSvxNZr/c/9eeeaf/JXdcOSxnv1f83d+kI0v9ApreKWEiXV3Hwko2WmLO8hGvve
 y+LoOhfG3RXwitBEwrO7cXn1vvQvAWRWomN5Q4bbJ3XHPSyg/RT0a7C39TLYF7TG411S
 mvvXoQpiYTRFDTe+eBji2xDRAjzeKviqVF5TeloWR5BTiYI+M7yfMSUd0ZfhgkYpVH5q
 o7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722919155; x=1723523955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6bpbZtMxXabJPCk+UIbCwETf4kl9EjfoyomrDTu9j7M=;
 b=LOh8COqDAzXkwGl89wEcBoNdX4FImPW2lNm90Yb4CnltLef44Jw5oi+mtcw3ZcGt9Z
 /YS/5cJZupBmXkHs+EL34Eaz8aaYewnlOVNfB8c8AYUV9b3m0t302P8yYDWbZ8UNlYLn
 p5eu1UfnZExP3IQX/E3G3TWWbgt22VWKTC/hll/G/Csbw6K8WMdAyURgFUJX21cJ+WK5
 rrTD6lFyidRCqO010t5nw31NzG8iGk4uZgCXkIgRikPZEJQ/q4H+sWpImSAsJyjxvjBv
 w+Woqr0SBSRjhhKMdsW+9vCRqp9v9o7WFfOkyr8X0+oqFTtmCteKryNJDeW9/XWeAKh1
 qZXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAdf/uGXYnVHPzxUs/dwZNJ5cbJYFO50P0hJHnGk8pG36gz3GP3M/9WiSC5sCsMQgYOAug/Uf3XAGiMjd5ZAq4PP6dQQ==
X-Gm-Message-State: AOJu0YyWlVf2HHBMSNLIoJ0gwjtjI3ROeqGbcxUjsPnzp1C0KcxS3/9w
 xHyM0s+mjOqsM9eTPHVTu0Zk0dwrFQiV36kgah6z/HOdaNmOHh03
X-Google-Smtp-Source: AGHT+IExjCqoQs/CyXq3TNwIXgbOCfTHkxQoMPK1WYp8Ig4q+W/fRDnbEZbHg+TV5v0dfpedoP3CUg==
X-Received: by 2002:a05:6a20:918c:b0:1c0:bd9c:adf with SMTP id
 adf61e73a8af0-1c699616e6cmr15112712637.50.1722919154737; 
 Mon, 05 Aug 2024 21:39:14 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20077164e0esm5823485ad.185.2024.08.05.21.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 21:39:14 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 04/12] arm: rockchip: px30: Remove unused syscon drivers
 code
Date: Tue,  6 Aug 2024 04:38:41 +0000
Message-ID: <20240806043849.3607-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240806043849.3607-1-linux.amoon@gmail.com>
References: <20240806043849.3607-1-linux.amoon@gmail.com>
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

Since commit 95397385091d ("treewide: Use OF_REAL instead of !OF_PLATDATA"),
the OF_PLATDATA code. As OF_PLATDATA is no longer enabled, the related
code is removed.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/mach-rockchip/px30/syscon_px30.c | 31 -----------------------
 1 file changed, 31 deletions(-)

diff --git a/arch/arm/mach-rockchip/px30/syscon_px30.c b/arch/arm/mach-rockchip/px30/syscon_px30.c
index 893a5234baa..cc5adc71569 100644
--- a/arch/arm/mach-rockchip/px30/syscon_px30.c
+++ b/arch/arm/mach-rockchip/px30/syscon_px30.c
@@ -23,34 +23,3 @@ U_BOOT_DRIVER(syscon_px30) = {
 #endif
 	.of_match = px30_syscon_ids,
 };
-
-#if CONFIG_IS_ENABLED(OF_PLATDATA)
-static int px30_syscon_bind_of_plat(struct udevice *dev)
-{
-	dev->driver_data = dev->driver->of_match->data;
-	debug("syscon: %s %d\n", dev->name, (uint)dev->driver_data);
-
-	return 0;
-}
-
-U_BOOT_DRIVER(rockchip_px30_pmu) = {
-	.name = "rockchip_px30_pmu",
-	.id = UCLASS_SYSCON,
-	.of_match = px30_syscon_ids,
-	.bind = px30_syscon_bind_of_plat,
-};
-
-U_BOOT_DRIVER(rockchip_px30_pmugrf) = {
-	.name = "rockchip_px30_pmugrf",
-	.id = UCLASS_SYSCON,
-	.of_match = px30_syscon_ids + 1,
-	.bind = px30_syscon_bind_of_plat,
-};
-
-U_BOOT_DRIVER(rockchip_px30_grf) = {
-	.name = "rockchip_px30_grf",
-	.id = UCLASS_SYSCON,
-	.of_match = px30_syscon_ids + 2,
-	.bind = px30_syscon_bind_of_plat,
-};
-#endif
-- 
2.46.0

