Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242F1C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 04:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFD71889EE;
	Tue,  6 Aug 2024 06:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qq4/a56E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9351C889F8; Tue,  6 Aug 2024 06:39:31 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F5E889BA
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 06:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fc65329979so1539385ad.0
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 21:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722919166; x=1723523966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRhIXqG5F1SwKhAB30UT9E7h2/Jmx7h+5p6IQ6v5rqw=;
 b=Qq4/a56EJ9N3T2KP+quy708U0eenN+xKBaVDpXEycQMRfdh45+/D+5u448Ju21YfyV
 AOK/Ofrs4ZmK8RrNGuYGiaW3AAjfG5A6P+bEBrykBTYsGuD5Qn/0yq0iqLmuwy2vbGkd
 H8ZlGWYrtYE9jWbzhLnMULlLEjbe6vLdAj4w0FP+COpXXAKl5Cyrp20zPiATIo40RvWU
 rKyNVg4+wf0Y39QcBGepqL8lutjsp0/6f160C3jEWaRu4NQdWru2bBfq6+oghHBCPAvi
 kF3isxIXMou7XKa0JR/5ubKBWEdz9JezsfG0ouRYy1FeOz5q3u3AnAv77er0Snp9L/9F
 p48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722919166; x=1723523966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CRhIXqG5F1SwKhAB30UT9E7h2/Jmx7h+5p6IQ6v5rqw=;
 b=q4dOx9cKcTtnqLKzuXkscqpyx7/e+Dp4QOEjMFKIfB5vWtZo3aLEI9svfZjpg7+zym
 DCojdwoin++BfNUqVpIS4d34khoWlYD1qmhF0+LbDJXJZw4t05T3XTiv8dwh6ECFE4Ly
 RGYRkvG1iRrU+xvfbFs5KE+9Szhm+bbM2Y1XAzOKYRw0j5LJzjWmUwZAL0PtxPoPn9tv
 72REciv11nBktjEeEiM1SAOIsnN2tyd+09+S4k/y1fPxBdx2qjBE71tyk9d/rpEyyiFf
 IeuuI9uv4IdjzHEBkreYWdDm3SLCX3wqdS9gct68d7fkTTZ7QXJ31NKVWkTUKKue68FV
 CKGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRYaFHB2io5mUSQ7pgGaZXIQvXpFn/QzrrVT/VpK/tKY4xkGxUl937hHSXnJrzvsywiB0IA5jB4XgPjh0Hu3pmxqVDXw==
X-Gm-Message-State: AOJu0Yw8Ek30Vh60XTYTANnBK2BNPodIa/WwvrgzgGsYDcKUEp/Mf8vP
 tj8bt5WfdayycQ6mwM9do2hiFhEja+JlQN3mF3w61Uu8Z6BM/H/Z
X-Google-Smtp-Source: AGHT+IGzc+OIG+mZCfMRQ+Yz+kVlt2D2wFHk8R+Gtux9YWWa4S16YpLj/+GMxWle0/zryCWDj8C3Iw==
X-Received: by 2002:a17:902:e544:b0:1ff:4d2a:fe43 with SMTP id
 d9443c01a7336-1ff574a17demr205888995ad.61.1722919166316; 
 Mon, 05 Aug 2024 21:39:26 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20077164e0esm5823485ad.185.2024.08.05.21.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 21:39:26 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 08/12] arm: rockchip: rk3368: Remove unused syscon drivers
 code
Date: Tue,  6 Aug 2024 04:38:45 +0000
Message-ID: <20240806043849.3607-9-linux.amoon@gmail.com>
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
 arch/arm/mach-rockchip/rk3368/syscon_rk3368.c | 38 -------------------
 1 file changed, 38 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3368/syscon_rk3368.c b/arch/arm/mach-rockchip/rk3368/syscon_rk3368.c
index 89caa6c310c..0381a22453f 100644
--- a/arch/arm/mach-rockchip/rk3368/syscon_rk3368.c
+++ b/arch/arm/mach-rockchip/rk3368/syscon_rk3368.c
@@ -30,41 +30,3 @@ U_BOOT_DRIVER(syscon_rk3368) = {
 #endif
 	.of_match = rk3368_syscon_ids,
 };
-
-#if CONFIG_IS_ENABLED(OF_PLATDATA)
-static int rk3368_syscon_bind_of_plat(struct udevice *dev)
-{
-	dev->driver_data = dev->driver->of_match->data;
-	debug("syscon: %s %d\n", dev->name, (uint)dev->driver_data);
-
-	return 0;
-}
-
-U_BOOT_DRIVER(rockchip_rk3368_grf) = {
-	.name = "rockchip_rk3368_grf",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3368_syscon_ids,
-	.bind = rk3368_syscon_bind_of_plat,
-};
-
-U_BOOT_DRIVER(rockchip_rk3368_pmugrf) = {
-	.name = "rockchip_rk3368_pmugrf",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3368_syscon_ids + 1,
-	.bind = rk3368_syscon_bind_of_plat,
-};
-
-U_BOOT_DRIVER(rockchip_rk3368_msch) = {
-	.name = "rockchip_rk3368_msch",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3368_syscon_ids + 2,
-	.bind = rk3368_syscon_bind_of_plat,
-};
-
-U_BOOT_DRIVER(rockchip_rk3368_sgrf) = {
-	.name = "rockchip_rk3368_sgrf",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3368_syscon_ids + 3,
-	.bind = rk3368_syscon_bind_of_plat,
-};
-#endif
-- 
2.46.0

