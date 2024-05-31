Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AED6C25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:22:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6951E8881C;
	Fri, 31 May 2024 16:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IkyMDgub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2040885AF; Fri, 31 May 2024 16:19:48 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA277885AF
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2c1e7708cfdso408041a91.2
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165184; x=1717769984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUREERFwT0ls5EHqqOzhZahlrhWa0aQVWUmaWt/iQzo=;
 b=IkyMDgubB3F9CYfOJbYU6AqtXg/WnpHKZwwUqHNRvll6FsijW+P7HJ7JwhWZ3dflzX
 QGxsNOwKHo7sFQyEzuKkdS9FOmzxoHen+wtYm/1QUcKYX0YZ3IsOpRQOtu7DG365teF3
 /DcjOE4BM0UdGoU0dYC5qeE0br4hQ491g/YCsb0VFdP2J8kMWCY0TNGr6Zut5WAMa7Jb
 ac758TdJUAYihubBEvfsunFiPqqYGn16kN4AsK840CbrdO9Ddsgsw/ZDd9S435pqeUHm
 i1fq4lhauqzfzOiR1UXOWzEM/k+0msHnykhv+e08j+NB5/LJoYWh3dp9JN4k55d4D4cD
 dsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165184; x=1717769984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUREERFwT0ls5EHqqOzhZahlrhWa0aQVWUmaWt/iQzo=;
 b=DrfdwDwByO84oyuRWRufP6GHo+KCSvVMl2RPf5E4imhy2ffQpLS7RSj3NGpaJA+sEb
 oDmfyzB2WyxFtRY8vPtDAQy11Xg9iWcJ4+i8iijz9PSLZ8DI2kvfelrL9TFfREmuT5Fo
 dUqwXB87AHF+fOitJ7vwYpMmnQatlNfu4E6iy/CvelKiXZ3jt6gZF1hBDbDIfnE+JZPX
 6I0gVANgxLKI8zRiQ39fEMKbmNSf02j3zCnREuQPCaaGVzpD/CJQFsc9eRhVP/3yKqzt
 x1W3JaQ4YiUnN32PCMfT7ANudpISEj5BHJVs0jn9OiNAUqM/LGdzK8ijgmx/rAx+3Q9y
 ySDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx/m6J/7lJUDUViWHf0F8+B6Jyw2vaxgDM5xiWoF+OM2K9be6ggAAHhizIkc6vCcUq2C3iVrurN4GpbEYOwasDgd/4JA==
X-Gm-Message-State: AOJu0YwRFi1R6GsFcTQ3JK9oDTvQ10DZuGHRLwEfq4nsV0DUUrj1Zy4i
 1MiUbPfW2OUmK//GmwmbZnz9DpDPjCw9wSNAujMXBHswTy4Yif7f
X-Google-Smtp-Source: AGHT+IGw8r/J/O/pawu4xoaCb9IZI8+owHJRfnHkymAAij5Qr7hGC+iFQDsZIoa2XIUV67Xo6S08Kg==
X-Received: by 2002:a17:90a:bf07:b0:2bd:e639:686c with SMTP id
 98e67ed59e1d1-2c1dc58fa20mr2089494a91.23.1717165184205; 
 Fri, 31 May 2024 07:19:44 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:19:43 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 16/23] rockchip: RK3368: Read the reset cause from
 clock reset unit for RK3368 SoC
Date: Fri, 31 May 2024 19:48:30 +0530
Message-ID: <20240531141837.13189-17-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531141837.13189-1-linux.amoon@gmail.com>
References: <20240531141837.13189-1-linux.amoon@gmail.com>
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

From: Anand Moon <anand@edgeble.ai>

Read the reset cause from clock reset unit for RK3368 SoC.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/include/asm/arch-rockchip/cru.h | 2 ++
 arch/arm/mach-rockchip/cpu-info.c        | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/arch-rockchip/cru.h b/arch/arm/include/asm/arch-rockchip/cru.h
index 6fe73ad0cc..9cdd960fb1 100644
--- a/arch/arm/include/asm/arch-rockchip/cru.h
+++ b/arch/arm/include/asm/arch-rockchip/cru.h
@@ -25,6 +25,8 @@
 #include <asm/arch-rockchip/cru_px30.h>
 #elif defined(CONFIG_ROCKCHIP_RK3308)
 #include <asm/arch-rockchip/cru_rk3308.h>
+#elif defined(CONFIG_ROCKCHIP_RK3368)
+#include <asm/arch-rockchip/cru_rk3368.h>
 #endif
 
 /* CRU_GLB_RST_ST */
diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index dbc126c862..b9d2756a70 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -28,6 +28,8 @@ char *get_reset_cause(void)
 	struct rockchip_cru *cru = rockchip_get_cru();
 #elif IS_ENABLED(CONFIG_ROCKCHIP_RK3308)
 	struct rk3308_cru *cru = rockchip_get_cru();
+#elif IS_ENABLED(CONFIG_ROCKCHIP_RK3368)
+	struct rk3368_cru *cru = rockchip_get_cru();
 #endif
 	char *cause = NULL;
 
-- 
2.44.0

