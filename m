Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A19C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDB6188816;
	Fri, 31 May 2024 16:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O3fUM7+J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 601C58882D; Fri, 31 May 2024 16:20:02 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 390F5887B2
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c034b016e6so1670509a91.2
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165199; x=1717769999; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tm0Pjms+WhXyTpR4NjXyPZl+pYDDuJEe+u2pX6ifCDo=;
 b=O3fUM7+JSWUj2Ley9uz4SSoXxHfFmKMersYeMsN1h3bq7K29Ax5xpwtEnlNJ8h0G4r
 t6+DUYRAnZi7OOqHFq2sv256i86Ow+dKtcpWJGZDlDUuZXXIVjVpphwEMtyG+tciGB2i
 TbX/bi5LBx0kngSAtBGlhxkvgzW8VFH5gtzUXc48lDEAv+vJCslLjWjqFCR18oX1ddj7
 ZduHY7UIzXGcYjKLrE8DZCaBcufVcM5I4UJBeepuPUHwzbVvYCa1O5zZq6GgmEsrf0ZQ
 7V1KR11Qj6lqaCiyGT1LY3rSSMm+FqbmfQkGvIsapVADXudtVmH9oCiOymOc9BH2Xls9
 H7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165199; x=1717769999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tm0Pjms+WhXyTpR4NjXyPZl+pYDDuJEe+u2pX6ifCDo=;
 b=G8Sst5qN33b1Gej956qv1wx0TQrtn7wwLQXvByMDRCggFiFubuuZMADEskJ1CBUzGc
 8qbB/83MfNwCKrRPb20Cf8IwX+3Cu2lFDOeoahMj+UVeEngAlQCQ+eO7pguyxlNZzn5N
 oVHuv6DvaG9qdK+SSoAriMU66lDsXcGPHhILcFj4TEVwQJtR7TSo0+ly1p478bV+iHXh
 vJPs4jLjWUrLWHb7vZSqsgA5Uqy6qeYFM0IMfySMn56OJMfxAsO/JbuexOWVSjyPW2uP
 V92eVH2byeqQsj9PymsZv9dYpzpRTGnXHesQ8K+RNscm1dHxCQMZEiA5z7w+4EpapC+d
 qxyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx7KBVFJVAsrPt6OC5171C+01ra4c3DzqOHhPzVcQ8WEo15Np3PEOgEUwiXu+bC6twMDwjTv0aSF11xVAc2/GN2rcjJQ==
X-Gm-Message-State: AOJu0YwFeG+JGuMbl71zfQwyRQLwDfKWXD2usMU7jZd6ku8IPicoE7V1
 8iXWYYB9AgHO26P56GCsCkR2WJ3GNcGuXRh4W8sqy3seEt+A002s
X-Google-Smtp-Source: AGHT+IF1MKHerfcw0bJ15oolm+ceJXLQTab4uwLvFrdckAvZ2jzY7frOGqbPEobo2Knq144vydU3hg==
X-Received: by 2002:a17:90a:a013:b0:2bd:76f6:8d30 with SMTP id
 98e67ed59e1d1-2c1dc5bbe50mr1921241a91.32.1717165198627; 
 Fri, 31 May 2024 07:19:58 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:19:57 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 20/23] rockchip: RV1126: Read the reset cause from
 clock reset unit for RV1126 SoC
Date: Fri, 31 May 2024 19:48:34 +0530
Message-ID: <20240531141837.13189-21-linux.amoon@gmail.com>
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

Read the reset cause from clock reset unit for RV1126 SoC.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/include/asm/arch-rockchip/cru.h | 2 ++
 arch/arm/mach-rockchip/cpu-info.c        | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/arch-rockchip/cru.h b/arch/arm/include/asm/arch-rockchip/cru.h
index e886adf515..e1a8d8adad 100644
--- a/arch/arm/include/asm/arch-rockchip/cru.h
+++ b/arch/arm/include/asm/arch-rockchip/cru.h
@@ -29,6 +29,8 @@
 #include <asm/arch-rockchip/cru_rk3368.h>
 #elif defined(CONFIG_ROCKCHIP_RV1108)
 #include <asm/arch-rockchip/cru_rv1108.h>
+#elif defined(CONFIG_ROCKCHIP_RV1126)
+#include <asm/arch-rockchip/cru_rv1126.h>
 #endif
 
 /* CRU_GLB_RST_ST */
diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index b2cfdade13..cb4ac39884 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -32,6 +32,8 @@ char *get_reset_cause(void)
 	struct rk3368_cru *cru = rockchip_get_cru();
 #elif IS_ENABLED(CONFIG_ROCKCHIP_RV1108)
 	struct rv1108_cru *cru = rockchip_get_cru();
+#elif IS_ENABLED(CONFIG_ROCKCHIP_RV1126)
+	struct rv1126_cru *cru = rockchip_get_cru();
 #endif
 	char *cause = NULL;
 
-- 
2.44.0

