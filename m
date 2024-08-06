Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17B5C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 04:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 682A488A11;
	Tue,  6 Aug 2024 06:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C02OuW0u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0AD088A0C; Tue,  6 Aug 2024 06:39:37 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9E9B88A0C
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 06:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fc566ac769so3586765ad.1
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 21:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722919172; x=1723523972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l+fse6ptb2IcSQIa2dk+hg1xlZxbH9qepqlS+54M9NI=;
 b=C02OuW0ueP7E4XzMy5vNDvWwRchTxqx4FueehRcDDE7JGqLrYvD/7zsI2/FgZOjK7T
 2FAnZ8KGaEPSV36F9PJrb6YN1xnwdwvDhAIRwyjKZHvSr8MdOP18YnvLndzAM6+mf4Gw
 Jk8G5ZbNhylob9f82xcspJnp9+pcP6WX8JCRMKI72A6X74FnvhQNK0NDCC3OX9P7sEFI
 XTU7ID8HCXHLyAL9VKGYxbJvnU9xnkEMyjY13kEdyNhT1cicHR7hjfYg7IWC9O1oXAVS
 naJBlhj0nu3hfTCHXUAOXQMMv5f2sFrm6jdY1pJaVfeEhKQKBigiChvjtlc8DGTqhQFC
 sNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722919172; x=1723523972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l+fse6ptb2IcSQIa2dk+hg1xlZxbH9qepqlS+54M9NI=;
 b=AOvDi982yweLJM7S6al0fACZVCYxAD7h1vCQuCW7OGF3O9kVcmOsrsKL1b1ZVE2q+C
 5V4/AibMlIoy3ewlEz8VQinicqspDg50WHwfygahmVX1Fz7aPf4Gi7Q0Zk3gUEeuiIcy
 vBRoo9cRiAGKT/6Pv2uwUkzu1Haukl2KNqksvsfxc06MvyEblEA7m8cRQNUYNYZR07L5
 RA53kD4Q0tq+ZlPf4vmdPWhc3hU8j0jYLwRB1x6KkxvyM8Nj+uI3XBT+F/7t/Ah88jTH
 4lrkEmNDR15XN+D2QIPeKlmZxKzAQ6Cj4YMriG3EQtoIpoEVJNxkIzdIWw4bg8KcqGh9
 pHnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrVQXFiguJPrardvz6gcLkm6w3TEeibXsgDCbHBOsubWWpMV6d5sFTCJIWaOkyKXK0gSt1dADjy7jHIV9ilVUgQtJ86Q==
X-Gm-Message-State: AOJu0YytSbkY+Gld5mzjvsKzrfkUJC8VDnu9C1kNyo4vs7Qc3Vu5t6Eg
 xoUb64jUvso5XbT5EakGubCq1W262rM+pTH6+cV7lqgGfZ1Osv5Y
X-Google-Smtp-Source: AGHT+IFf8aRqL8wLG+gnL2NOz4dAx5ZDrGd5X5wCroxzvCrAcRfEapgKGzxU6xwI1p+3tlvQeHioyg==
X-Received: by 2002:a17:903:1c2:b0:1fd:63d7:5d21 with SMTP id
 d9443c01a7336-1ff574218c3mr122456175ad.47.1722919172048; 
 Mon, 05 Aug 2024 21:39:32 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20077164e0esm5823485ad.185.2024.08.05.21.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 21:39:31 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 10/12] arm: rockchip: rk3188: Remove unused syscon drivers
 code
Date: Tue,  6 Aug 2024 04:38:47 +0000
Message-ID: <20240806043849.3607-11-linux.amoon@gmail.com>
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
 arch/arm/mach-rockchip/rk3188/syscon_rk3188.c | 31 -------------------
 1 file changed, 31 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c b/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c
index bcd7870c503..94dbd6f8644 100644
--- a/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c
+++ b/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c
@@ -24,34 +24,3 @@ U_BOOT_DRIVER(syscon_rk3188) = {
 #endif
 	.of_match = rk3188_syscon_ids,
 };
-
-#if CONFIG_IS_ENABLED(OF_PLATDATA)
-static int rk3188_syscon_bind_of_plat(struct udevice *dev)
-{
-	dev->driver_data = dev->driver->of_match->data;
-	debug("syscon: %s %d\n", dev->name, (uint)dev->driver_data);
-
-	return 0;
-}
-
-U_BOOT_DRIVER(rockchip_rk3188_noc) = {
-	.name = "rockchip_rk3188_noc",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3188_syscon_ids,
-	.bind = rk3188_syscon_bind_of_plat,
-};
-
-U_BOOT_DRIVER(rockchip_rk3188_grf) = {
-	.name = "rockchip_rk3188_grf",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3188_syscon_ids + 1,
-	.bind = rk3188_syscon_bind_of_plat,
-};
-
-U_BOOT_DRIVER(rockchip_rk3188_pmu) = {
-	.name = "rockchip_rk3188_pmu",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3188_syscon_ids + 2,
-	.bind = rk3188_syscon_bind_of_plat,
-};
-#endif
-- 
2.46.0

