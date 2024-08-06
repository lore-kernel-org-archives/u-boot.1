Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E81CC49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 04:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F076D889E3;
	Tue,  6 Aug 2024 06:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nF1/+4FM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AE96889E3; Tue,  6 Aug 2024 06:39:24 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 499E58898E
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 06:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fd69e44596so3231345ad.1
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 21:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722919161; x=1723523961; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uNjA3778HVdhdsxGGLYQUqQqlF+4Xu/JGaednZBiZU4=;
 b=nF1/+4FM5qTakR1FBrkN4JzUvtQMWjG+Pv1ra62Jn4UpC7FBSFq6cfVDxuG/7R4uCr
 Ea3GCMPrLY+YF56tsHziHfjYGsbEKk3QQDtA7Vb6MgXR4vS8kX0iNiXWx3lbxk1VpXYg
 9ant9fsAHff9jW5k2t8GRMsKEFZ8lEsSec7ih65yP072PKu/MwDZvSLDCc3thG7J4QfF
 a2IvdcBJOGTkbxEJwyjPJEsFyPO2QhLNtOdrmdVGDhAdkGRN9GHbAWnlTd6BGBVccuPZ
 NcuPRFX3yuwzeVhMghR0b+ld/52eNs2rQxXu2dAOviBfIsPVOVuMu4JTm3udsKLyDONh
 8mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722919161; x=1723523961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uNjA3778HVdhdsxGGLYQUqQqlF+4Xu/JGaednZBiZU4=;
 b=WFqvIUP/IiHABNFiT72YtHDJQ2lnNb3I/rVvFjHmQoS1ZzzQrK/UoPJb/8KN+0k9L+
 jDUJLoSzEoC1K+mFXfc7dnxAkWlkkDlNBZchlTj8+jWW8wXAOk30VYuqvhXCl1CGP+fg
 k8KXzB+BWo8pr4QyKj2alFhpkUZfBbmQEiUYLtZT6/1BIUe72Lj7phoz7PuHojsGnK+E
 DEktu2ZovFIfbGDoT1uHq8y6mNAxk3LL7MVxnsuOP9LjovrA1QhtscAFVP7pADFp595H
 YI2XB284vArEICxSaBp/TMdeWkJKr2RAPwaKLKS7fYWeKuj7YRrrSHrYJnBg8w4iRe/D
 K8BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUII5c9BIGitmrJr+gggkCumjAYtJp+R8YH4gT5Ym2wj2VWrcfU0Xmnr2OSWcKOmGYtnWfana5rw2lcIwamdDU5AukU0Q==
X-Gm-Message-State: AOJu0YyJO5zYJ8wuTw1zpqi+tDk/q0XsJjR5jZngW5UsBWIm+kngWF+t
 oxGL5T4k6NJw3QjH5lRDUcVFb+VHEhquZpR6cxFO6I/QxjcYdje4
X-Google-Smtp-Source: AGHT+IG6ymMIEDyQtWvWfeNG/3nABXUxGObejMWu4fqBT7LsLHhXAvs8Rb1jy7T/QHxhDbxlFY4XrA==
X-Received: by 2002:a17:902:f54c:b0:1fc:4680:820d with SMTP id
 d9443c01a7336-1ff57b819c1mr189253545ad.9.1722919160624; 
 Mon, 05 Aug 2024 21:39:20 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20077164e0esm5823485ad.185.2024.08.05.21.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 21:39:20 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 06/12] arm: rockchip: rk3066: Remove unused syscon drivers
 code
Date: Tue,  6 Aug 2024 04:38:43 +0000
Message-ID: <20240806043849.3607-7-linux.amoon@gmail.com>
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
 arch/arm/mach-rockchip/rk3066/syscon_rk3066.c | 31 -------------------
 1 file changed, 31 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c b/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
index 4e13aeca03e..18f006610d0 100644
--- a/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
+++ b/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
@@ -24,34 +24,3 @@ U_BOOT_DRIVER(syscon_rk3066) = {
 #endif
 	.of_match = rk3066_syscon_ids,
 };
-
-#if CONFIG_IS_ENABLED(OF_PLATDATA)
-static int rk3066_syscon_bind_of_plat(struct udevice *dev)
-{
-	dev->driver_data = dev->driver->of_match->data;
-	debug("syscon: %s %d\n", dev->name, (uint)dev->driver_data);
-
-	return 0;
-}
-
-U_BOOT_DRIVER(rockchip_rk3066_noc) = {
-	.name = "rockchip_rk3066_noc",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3066_syscon_ids,
-	.bind = rk3066_syscon_bind_of_plat,
-};
-
-U_BOOT_DRIVER(rockchip_rk3066_grf) = {
-	.name = "rockchip_rk3066_grf",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3066_syscon_ids + 1,
-	.bind = rk3066_syscon_bind_of_plat,
-};
-
-U_BOOT_DRIVER(rockchip_rk3066_pmu) = {
-	.name = "rockchip_rk3066_pmu",
-	.id = UCLASS_SYSCON,
-	.of_match = rk3066_syscon_ids + 2,
-	.bind = rk3066_syscon_bind_of_plat,
-};
-#endif
-- 
2.46.0

