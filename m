Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F73C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 04:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D0B9889D4;
	Tue,  6 Aug 2024 06:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KJZOgZRQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A54A3889E9; Tue,  6 Aug 2024 06:39:18 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A43D8898E
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 06:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fc491f9b55so1350625ad.3
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 21:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722919152; x=1723523952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3O+s90oacWXLqmpoD2b4HNlYQ4e1wcmFosoQ7sR3oVs=;
 b=KJZOgZRQ7MhaFdVH+K9pZKeoCEhwntWNXqFPhpaQfOrbi3p95+bhTuAr1Nge/s9WZ+
 qHmPekGifG1p/SIa7BNoR63Ob0rudSaEFmHPLhjTgD83MW26RcAsCo9n5a/tmmcabsxq
 G6Gcl2jfmJExSuu3zkURhaG20X0tICfWsvNm9eDOiMBXteHarQbZtB4FyWqpfFItgTyB
 D2tFkvLvK3Il87zIxpBlR1oNl+LQ9YquRWDSAnqUzer1I1ONgKWWoHPmrQBceo2ZfTvm
 H6wiSw2jOiz/FOG+OTXJCH5R1bA35ufrsxjNjQjsp9r8vl8ud6e1gP4m59SL6Sapzuhc
 6H/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722919152; x=1723523952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3O+s90oacWXLqmpoD2b4HNlYQ4e1wcmFosoQ7sR3oVs=;
 b=U1rSnRtNaskwwkU74rTzoDMHXp4/5eF96nejlFLdqjtHkKBZdJOmIFt9RhcCj9DBUQ
 hbnT1xR4UQ90+dwURkpFUNqn+IHjNLEn28wUeKue4l2GScfvRLaKRMWSwlixbunz3aBP
 NOuP/Sel1xpzu6dfYNS8+dbTLvoqYc9tUq7VWdMFLyr7PuMS6NZJ7xmxPdY8bj7JAh57
 iIJRBqWxHBO3wNU64/yg7cX7RiVvw73tGXlZ/TGOj3a2A4v4i6P2tGxHvr3taMfC13eH
 7iX3n+fMRl7k/DUAyMLNplYn4/3mJID64G+x0RSe2c518BwelCGZN8nudFssRrYEXjBq
 dnHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ/UVOCCQlJYkt3ZhGFc4T0uRwEwZGYhEImfoZM50UGn0GLff4YwtEjm1kYS4HtZROm2hKtXUzvAhqGaM7xuv0jf0ArQ==
X-Gm-Message-State: AOJu0Yy6MeV4ihp7TW41SGcjc3pMsgF1foIMx4b9in28kkwMDpOdgzGD
 i8fOF7okb8vkcFicv3ZWzlRjgATK0ntGUjC6n0NBhicxT2c2GCNI
X-Google-Smtp-Source: AGHT+IESdaXyK89/3cxfi9XaozXUyAFZLXBE4YeRiKW0lf1IHoO55BwFSazd+NpT82XL+1P4J6Fl1Q==
X-Received: by 2002:a17:903:1108:b0:1fb:7c7f:6458 with SMTP id
 d9443c01a7336-1ff572ba310mr142723945ad.32.1722919151831; 
 Mon, 05 Aug 2024 21:39:11 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20077164e0esm5823485ad.185.2024.08.05.21.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 21:39:11 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 03/12] arm: rockchip: rv1126: Remove unused syscon drivers
 code
Date: Tue,  6 Aug 2024 04:38:40 +0000
Message-ID: <20240806043849.3607-4-linux.amoon@gmail.com>
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
 arch/arm/mach-rockchip/rv1126/syscon_rv1126.c | 24 -------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/arm/mach-rockchip/rv1126/syscon_rv1126.c b/arch/arm/mach-rockchip/rv1126/syscon_rv1126.c
index d66d84c836d..4c0690f1ba2 100644
--- a/arch/arm/mach-rockchip/rv1126/syscon_rv1126.c
+++ b/arch/arm/mach-rockchip/rv1126/syscon_rv1126.c
@@ -23,27 +23,3 @@ U_BOOT_DRIVER(syscon_rv1126) = {
 #endif
 	.of_match = rv1126_syscon_ids,
 };
-
-#if CONFIG_IS_ENABLED(OF_PLATDATA)
-static int rv1126_syscon_bind_of_plat(struct udevice *dev)
-{
-	dev->driver_data = dev->driver->of_match->data;
-	debug("syscon: %s %d\n", dev->name, (uint)dev->driver_data);
-
-	return 0;
-}
-
-U_BOOT_DRIVER(rockchip_rv1126_pmu) = {
-	.name = "rockchip_rv1126_pmu",
-	.id = UCLASS_SYSCON,
-	.of_match = rv1126_syscon_ids,
-	.bind = rv1126_syscon_bind_of_plat,
-};
-
-U_BOOT_DRIVER(rockchip_rv1126_pmugrf) = {
-	.name = "rockchip_rv1126_pmugrf",
-	.id = UCLASS_SYSCON,
-	.of_match = rv1126_syscon_ids + 1,
-	.bind = rv1126_syscon_bind_of_plat,
-};
-#endif
-- 
2.46.0

