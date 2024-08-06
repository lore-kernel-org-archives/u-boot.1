Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64DBC49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 04:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29D6C88A29;
	Tue,  6 Aug 2024 06:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kqfolyka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D70EA889AA; Tue,  6 Aug 2024 06:39:45 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93F1188A10
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 06:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fd90c2fc68so3151675ad.1
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 21:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722919178; x=1723523978; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6nvekmqmRBIX+dJKxOAVGiSmae2bsgiXsItAJVwGcI=;
 b=KqfolykaVS6IHEoTMC7Mzus45RVnBolp5s0U9mX2vOHOMXh5tvUV/QGfBnGoitIqFL
 zp6S/zVkOH/GiveDH4adJmgyHobV5DzxcPrD8apDGDtGQZQyVKlBrjk4bYIJ8VrJ9H3L
 +/o4YBPhFr1nRkfGNbkHdBT5vjR+TM9Vh1WRbG4m/K6fozsFFVlngFjjmWyleFU81WTQ
 /u6zmTj5cx6ilLaxQwviZw45hmXOt2Fwma4qrttNjKwhaSZZ4Zlv2mWRnGg2v1uKUh7+
 +fQ/MRN5wCl40KEp+H+0HE+nk/z2w1Zg9aYBuGNZz5qfQdaSzkMqQeD6zkAzT+Ps/O8K
 IzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722919178; x=1723523978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/6nvekmqmRBIX+dJKxOAVGiSmae2bsgiXsItAJVwGcI=;
 b=pWyrhCXecS6dl3R21x0+Ac9HUpU9+nss9GLfM2XuQvOk9dfEVb8vAnfBBcFRGb4sVc
 ILb3gyyrA0Di/XizcdJDXNpObU9UwDoG7rDBO0XxMLejT7XGBtZfbTxbs7pVTnVOK1vR
 JYaBOGomn42SMgkmy6JSPriu+4n9LuqJWpvB5eOFRo2UvzHwxtgUQo7jU+NGPCOcJArS
 3bHGTm4Eu7BNFvsSC4lwUusdYQwlvBT/8JGXNgVzivBx+66mZHftDPsnR4HmKVwiDWbl
 doa7mytVUatqraog2xqsFoVvj7JOhaJLb2BxWNz7GajPsEtmRArbtkCC4xJx007t9Jg2
 27bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUcWdBSRh6vYHQaW+xUYGY0JRrLuh4ZjMfkFMLONgCbkOyw+srL08aabVu+PKiCsZ208NAcgaBymdoomvgUDOGr1ERGA==
X-Gm-Message-State: AOJu0Yz1cXkzVid6rS24u/4zx+teJVTjIfKNwWFpAFEvNWFz2sMMFYwv
 bJ8w9KePGQ9O1qxxpOlabcuKbKeMj1di05ZeH5VvpDRiFkdU4BbP
X-Google-Smtp-Source: AGHT+IEVSmk6mlU5mrjkSdG+G4nW2ic+bO87b7P70lCAVecY4Ih/7/wruUQCTYSPNWn7ynj4wALU/A==
X-Received: by 2002:a17:902:db11:b0:1fd:d807:b29e with SMTP id
 d9443c01a7336-1ff5730a2e8mr150894025ad.35.1722919177673; 
 Mon, 05 Aug 2024 21:39:37 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20077164e0esm5823485ad.185.2024.08.05.21.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 21:39:37 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 12/12] arm: rockchip: rk3288: Remove unused syscon drivers
 code
Date: Tue,  6 Aug 2024 04:38:49 +0000
Message-ID: <20240806043849.3607-13-linux.amoon@gmail.com>
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
 arch/arm/mach-rockchip/rk3288/syscon_rk3288.c | 156 ------------------
 1 file changed, 156 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c b/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
index 4030e919134..e2e1eb624ec 100644
--- a/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
+++ b/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
@@ -28,159 +28,3 @@ U_BOOT_DRIVER(syscon_rk3288) = {
 #endif
 	.of_match = rk3288_syscon_ids,
 };
-
-#if CONFIG_IS_ENABLED(OF_PLATDATA)
-#if IS_ENABLED(CONFIG_FDT_64BIT)
-struct rockchip_rk3288_noc_plat {
-	struct dtd_rockchip_rk3288_noc dtplat;
-};
-
-struct rockchip_rk3288_grf_plat {
-	struct dtd_rockchip_rk3288_grf dtplat;
-};
-
-struct rockchip_rk3288_sgrf_plat {
-	struct dtd_rockchip_rk3288_sgrf dtplat;
-};
-
-struct rockchip_rk3288_pmu_plat {
-	struct dtd_rockchip_rk3288_pmu dtplat;
-};
-
-static int rk3288_noc_bind_of_plat(struct udevice *dev)
-{
-	struct rockchip_rk3288_noc_plat *plat = dev_get_plat(dev);
-	struct syscon_uc_info *priv = dev_get_uclass_priv(dev);
-	int size = dev->uclass->uc_drv->per_device_auto;
-
-	if (size && !priv) {
-		priv = calloc(1, size);
-		if (!priv)
-			return -ENOMEM;
-		dev_set_uclass_priv(dev, priv);
-	}
-
-	dev->driver_data = dev->driver->of_match->data;
-	debug("syscon: %s %d\n", dev->name, (uint)dev->driver_data);
-
-	return regmap_init_mem_plat(dev, plat->dtplat.reg, sizeof(plat->dtplat.reg[0]),
-				    ARRAY_SIZE(plat->dtplat.reg) / 2, &priv->regmap);
-}
-
-static int rk3288_grf_bind_of_plat(struct udevice *dev)
-{
-	struct rockchip_rk3288_grf_plat *plat = dev_get_plat(dev);
-	struct syscon_uc_info *priv = dev_get_uclass_priv(dev);
-	int size = dev->uclass->uc_drv->per_device_auto;
-
-	if (size && !priv) {
-		priv = calloc(1, size);
-		if (!priv)
-			return -ENOMEM;
-		dev_set_uclass_priv(dev, priv);
-	}
-
-	dev->driver_data = dev->driver->of_match->data;
-	debug("syscon: %s %d\n", dev->name, (uint)dev->driver_data);
-
-	return regmap_init_mem_plat(dev, plat->dtplat.reg, sizeof(plat->dtplat.reg[0]),
-				    ARRAY_SIZE(plat->dtplat.reg) / 2, &priv->regmap);
-}
-
-static int rk3288_sgrf_bind_of_plat(struct udevice *dev)
-{
-	struct rockchip_rk3288_sgrf_plat *plat = dev_get_plat(dev);
-	struct syscon_uc_info *priv = dev_get_uclass_priv(dev);
-	int size = dev->uclass->uc_drv->per_device_auto;
-
-	if (size && !priv) {
-		priv = calloc(1, size);
-		if (!priv)
-			return -ENOMEM;
-		dev_set_uclass_priv(dev, priv);
-	}
-
-	dev->driver_data = dev->driver->of_match->data;
-	debug("syscon: %s %d\n", dev->name, (uint)dev->driver_data);
-
-	return regmap_init_mem_plat(dev, plat->dtplat.reg, sizeof(plat->dtplat.reg[0]),
-				    ARRAY_SIZE(plat->dtplat.reg) / 2, &priv->regmap);
-}
-
-static int rk3288_pmu_bind_of_plat(struct udevice *dev)
-{
-	struct rockchip_rk3288_pmu_plat *plat = dev_get_plat(dev);
-	struct syscon_uc_info *priv = dev_get_uclass_priv(dev);
-	int size = dev->uclass->uc_drv->per_device_auto;
-
-	if (size && !priv) {
-		priv = calloc(1, size);
-		if (!priv)
-			return -ENOMEM;
-		dev_set_uclass_priv(dev, priv);
-	}
-
-	dev->driver_data = dev->driver->of_match->data;
-	debug("syscon: %s %d\n", dev->name, (uint)dev->driver_data);
-
-	return regmap_init_mem_plat(dev, plat->dtplat.reg, sizeof(plat->dtplat.reg[0]),
-				    ARRAY_SIZE(plat->dtplat.reg) / 2, &priv->regmap);
-}
-#else
-static int rk3288_syscon_bind_of_plat(struct udevice *dev)
-{
-	dev->driver_data = dev->driver->of_match->data;
-	debug("syscon: %s %d\n", dev->name, (uint)dev->driver_data);
-
-	return 0;
-}
-#endif
-
-U_BOOT_DRIVER(rockchip_rk3288_noc) = {
-	.name = "rockchip_rk3288_noc",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3288_syscon_ids,
-#if IS_ENABLED(CONFIG_FDT_64BIT)
-	.bind = rk3288_noc_bind_of_plat,
-	.plat_auto = sizeof(struct rockchip_rk3288_noc_plat),
-#else
-	.bind = rk3288_syscon_bind_of_plat,
-#endif
-};
-
-U_BOOT_DRIVER(rockchip_rk3288_grf) = {
-	.name = "rockchip_rk3288_grf",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3288_syscon_ids + 1,
-#if IS_ENABLED(CONFIG_FDT_64BIT)
-	.bind = rk3288_grf_bind_of_plat,
-	.plat_auto = sizeof(struct rockchip_rk3288_grf_plat),
-#else
-	.bind = rk3288_syscon_bind_of_plat,
-#endif
-};
-
-U_BOOT_DRIVER(rockchip_rk3288_sgrf) = {
-	.name = "rockchip_rk3288_sgrf",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3288_syscon_ids + 2,
-#if IS_ENABLED(CONFIG_FDT_64BIT)
-	.bind = rk3288_sgrf_bind_of_plat,
-	.plat_auto = sizeof(struct rockchip_rk3288_sgrf_plat),
-#else
-	.bind = rk3288_syscon_bind_of_plat,
-#endif
-};
-
-U_BOOT_DRIVER(rockchip_rk3288_pmu) = {
-	.name = "rockchip_rk3288_pmu",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3288_syscon_ids + 3,
-#if IS_ENABLED(CONFIG_FDT_64BIT)
-	.bind = rk3288_pmu_bind_of_plat,
-	.plat_auto = sizeof(struct rockchip_rk3288_pmu_plat),
-#else
-	.bind = rk3288_syscon_bind_of_plat,
-#endif
-};
-#endif
-- 
2.46.0

