Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EE9C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30DDE88815;
	Fri, 31 May 2024 16:19:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G8MEIyva";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62DC988814; Fri, 31 May 2024 16:19:54 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32CEE885AF
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-6c5bcb8e8edso302882a12.2
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165191; x=1717769991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ldbTllXgPzPKgQrf0B6vC54Ii4zTJCtIgCO3/2GynNI=;
 b=G8MEIyvaOOYR78FyQ4o8IocShZCwakPu/oZXA3oOMrtIiIHFE6udodS46dWz4sJHkm
 Ik9oWtsBTGRUrJt9usLdaCPhO1LR8BpqaILhRL+GFIJKDFg/Y1oNxChC7YzH+SHIPEBV
 kmO09Izyr7KU2LQ60ap+zV+rqQnpVC1xT85jigS6b1XCxbXje0PZstm7wpetCyLjvMm1
 jLw1LKRQGjsU5Mt5PXVLBZhW+bN8Bo1a2VglTWk9OW3Kt8/cuyeu8WnSLLyGDJlurf+n
 /abxcPeSOWGilphVlvCktP0va1A3aeOTY8MgWC7Zt5y5z5tncKyBYMoj4dcS5uwdYcTy
 ucQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165191; x=1717769991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ldbTllXgPzPKgQrf0B6vC54Ii4zTJCtIgCO3/2GynNI=;
 b=K/uhy1+1TqVKf1JBlKytdSUrdFKDFNG4cLj/LruS1lwoJCrWahZNnlApWccY8YdqF2
 6XntWjSWpFX4W5XBTv7PqhQkhC+xYLm1jqW1z9P8zLiTHp0LbMVOMLov88tGzeinCMpO
 vEikhxTdCzcH3ZRayxBE7uKklyCpvEl0CwymDIBBFlrDyvOccnWF/eUKx8YCh+wh9Ny8
 7Ah0ogN835ksB1Uk6edWsWtxHL36rckgyRov+jZozvT2gsfIncqWMsEN2ucmQ8DbjHB7
 k3hCpLiHtgBEoBjuTrzaR4WxSMnrx1V2QbXYSMQ1HyJ1kd197MIPF7tCK5KVLe7dJej3
 TZBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUviHJPBCcrl3Sbo5wzZrly7/GTjqusi/TXTVR5pl8v8QeFRfaQN63gYcRqj+8PlwgunoYOknYzmmMhdreZ9KJzZQVyxA==
X-Gm-Message-State: AOJu0Yx91eGDZtQ/zfrHI6p7RseCJMnFX64tt2MkwZtE/kLosk57OR0n
 w2bbn/MZSDT6+1E6MLWThQW0l4xBCu8I+2MDO3ZoDRr1OLsLxTLN
X-Google-Smtp-Source: AGHT+IFlQgFTIdYb6Km9389YAanQ20EOxig+yvp8xfZ5mV69cmbMNawKyu9L/0eV1puj0EoE+Puwow==
X-Received: by 2002:a17:90b:374f:b0:2bd:d6d1:c54a with SMTP id
 98e67ed59e1d1-2c1dc5dd4a5mr1720236a91.40.1717165190588; 
 Fri, 31 May 2024 07:19:50 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:19:50 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 18/23] rockchip: RV1108: Read the reset cause from
 clock reset unit for RV1108 SoC
Date: Fri, 31 May 2024 19:48:32 +0530
Message-ID: <20240531141837.13189-19-linux.amoon@gmail.com>
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

Read the reset cause from clock reset unit for RV1108 SoC.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/include/asm/arch-rockchip/cru.h | 2 ++
 arch/arm/mach-rockchip/cpu-info.c        | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/arch-rockchip/cru.h b/arch/arm/include/asm/arch-rockchip/cru.h
index 9cdd960fb1..e886adf515 100644
--- a/arch/arm/include/asm/arch-rockchip/cru.h
+++ b/arch/arm/include/asm/arch-rockchip/cru.h
@@ -27,6 +27,8 @@
 #include <asm/arch-rockchip/cru_rk3308.h>
 #elif defined(CONFIG_ROCKCHIP_RK3368)
 #include <asm/arch-rockchip/cru_rk3368.h>
+#elif defined(CONFIG_ROCKCHIP_RV1108)
+#include <asm/arch-rockchip/cru_rv1108.h>
 #endif
 
 /* CRU_GLB_RST_ST */
diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index b9d2756a70..b2cfdade13 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -30,6 +30,8 @@ char *get_reset_cause(void)
 	struct rk3308_cru *cru = rockchip_get_cru();
 #elif IS_ENABLED(CONFIG_ROCKCHIP_RK3368)
 	struct rk3368_cru *cru = rockchip_get_cru();
+#elif IS_ENABLED(CONFIG_ROCKCHIP_RV1108)
+	struct rv1108_cru *cru = rockchip_get_cru();
 #endif
 	char *cause = NULL;
 
-- 
2.44.0

