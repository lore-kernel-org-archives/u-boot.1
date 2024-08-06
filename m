Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BECC3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 04:39:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E26A1889CD;
	Tue,  6 Aug 2024 06:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BOPNVnIu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA734889CB; Tue,  6 Aug 2024 06:39:14 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 902D9889BB
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 06:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fd6ed7688cso3662295ad.3
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 21:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722919146; x=1723523946; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ukeCMLwYRHDf2yq7KGfmMBIhPCpdtd9C7ivv0G4sgRo=;
 b=BOPNVnIuFTiXg8Yq/7gLB6S/bQ+UBxY6JD+nTwf6Xk211gtLIf0KcDI/XN8sz7Ap+e
 U/NLcIs6xTwc5kYpE1YxEWHgX0jlSrqKlPZccvPWu5wsvReX9MW37CI5iDohmrsrOFJ4
 1EhbPlVQ8nK0Z47FYKRwQayPU0rKrsRGkzFlD7pXAZHUdILobFEAom0QTgRvRUy3jEz4
 WEocQT6IEO7ihtgye0+yltohGRVlssq7UvYgelxEqrI0zNEqhkWEx5POIRhbTqstklaR
 cBYRmox6NoUX37ekXXNcQKM8vVPGezFW9QOESBbhg3YNzHJz50bkOU+p8qsnGDz/9Y2T
 /RIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722919146; x=1723523946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ukeCMLwYRHDf2yq7KGfmMBIhPCpdtd9C7ivv0G4sgRo=;
 b=gTWME+U8xEqlLeJwlVO2HN33tTobOmKlQaIrJwDEJsFAhDoo7vAfJsKgN3C5LOa5wm
 GrsD4l3GFIoWqG8L5Y2A1I3/JDpE91SUxPosqlCumrHXqIMmWVHwIgxinE14p4Dcr4HU
 1l2wkliT1HdA80YB9XgObCLYl90H3A2atMz0YmUUcmbxWlq5K1M7zr+h2Be+51ReSbIQ
 32aEKsKoCHVIc7nSqLv4+qibN68VGY5hwHpUUiqjuJdAGJfjaQcOTlP5PaH1GrUelxcr
 YKuT8uuWr9Zx1BgbH/4qepd4oUXBmzxPy5rNlctHuHaZHPrwvzriJFsXpzIxlc70hSGt
 LxXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqGNu/ZG3MDYHsf6F1YpmdqnNExdTjchWnerRPxIaCCXiDuSawHXwJYLGz8ZIL4ZwTbY1G/vwMy9HJwnXWcfojhU/WpQ==
X-Gm-Message-State: AOJu0YwyXtiTPTb0fZb24IUgIcnk6B6qbdZusFzt40NVvROmZlHwexsY
 JgSRlUyf4UxJXElkF7Ba+UIEW3VIUIjztk9TJRndC556oTtODuEdSpjOPQ==
X-Google-Smtp-Source: AGHT+IFHsKUgR8W/URqMgGBGZjct2I2IpXbLC7obKMr58V/8EbQN2bpnTbO9Rl1KvUpupJtxetqR5g==
X-Received: by 2002:a17:903:1ca:b0:1fd:a72a:f44 with SMTP id
 d9443c01a7336-1ff57261dc8mr146021385ad.17.1722919146001; 
 Mon, 05 Aug 2024 21:39:06 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20077164e0esm5823485ad.185.2024.08.05.21.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 21:39:05 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 01/12] arm: rockchip: rk3399: Remove unused syscon drivers
 code
Date: Tue,  6 Aug 2024 04:38:38 +0000
Message-ID: <20240806043849.3607-2-linux.amoon@gmail.com>
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
the OF_PLATDATA code, As OF_PLATDATA is no longer enabled, the related
code is removed.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/mach-rockchip/rk3399/syscon_rk3399.c | 45 -------------------
 1 file changed, 45 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3399/syscon_rk3399.c b/arch/arm/mach-rockchip/rk3399/syscon_rk3399.c
index b92ad54ede5..5895fa373ec 100644
--- a/arch/arm/mach-rockchip/rk3399/syscon_rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/syscon_rk3399.c
@@ -25,48 +25,3 @@ U_BOOT_DRIVER(syscon_rk3399) = {
 #endif
 	.of_match = rk3399_syscon_ids,
 };
-
-#if CONFIG_IS_ENABLED(OF_PLATDATA)
-static int rk3399_syscon_bind_of_plat(struct udevice *dev)
-{
-	dev->driver_data = dev->driver->of_match->data;
-	debug("syscon: %s %d\n", dev->name, (uint)dev->driver_data);
-
-	return 0;
-}
-
-U_BOOT_DRIVER(rockchip_rk3399_grf) = {
-	.name = "rockchip_rk3399_grf",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3399_syscon_ids,
-	.bind = rk3399_syscon_bind_of_plat,
-};
-
-U_BOOT_DRIVER(rockchip_rk3399_pmugrf) = {
-	.name = "rockchip_rk3399_pmugrf",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3399_syscon_ids + 1,
-	.bind = rk3399_syscon_bind_of_plat,
-};
-
-U_BOOT_DRIVER(rockchip_rk3399_pmusgrf) = {
-	.name = "rockchip_rk3399_pmusgrf",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3399_syscon_ids + 2,
-	.bind = rk3399_syscon_bind_of_plat,
-};
-
-U_BOOT_DRIVER(rockchip_rk3399_cic) = {
-	.name = "rockchip_rk3399_cic",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3399_syscon_ids + 3,
-	.bind = rk3399_syscon_bind_of_plat,
-};
-
-U_BOOT_DRIVER(rockchip_rk3399_pmu) = {
-	.name = "rockchip_rk3399_pmu",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3399_syscon_ids + 4,
-	.bind = rk3399_syscon_bind_of_plat,
-};
-#endif
-- 
2.46.0

