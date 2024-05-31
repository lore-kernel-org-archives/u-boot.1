Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92D3C25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 971A2887A1;
	Fri, 31 May 2024 16:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KVyp6WB6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B03D8880A; Fri, 31 May 2024 16:19:41 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5989D885AF
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-6c4f3e0e407so401663a12.1
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165178; x=1717769978; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FaKQVmkDSCVqRZvcEaxMDg8nqM0A2j4kEogBmvEaEmQ=;
 b=KVyp6WB6lhmllWvE3qt43uWpdTAKxv2btQBboLXd29lzwurzrKAf6Dqn+diEKjYsnl
 Mkt6TLuCvzk65LRP4X8YWlPo9lkBBJ2QbFdH0nci9Hqn5w6xC/VWqGjGl2vSpKIpfE+h
 We1n3jtrqqTw0EY0ZNRwK9SkPXuW8bZB6Iv1HJHX8h0mnJT60sVi2Dhn1V3Vl/MOzadC
 qWdWUK7CmyYE0RTUv35lNoaOL6AZVtaRAHBOPI4DYYdFw2LLV5O0PTmFrDxXNsuI3OK6
 DDEFJunr0tw/twhJcWnFyZ4j0+AWm71Q87tVn6Ne5B1MTZwNNusvmNGK659V5OE2uVR9
 pHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165178; x=1717769978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FaKQVmkDSCVqRZvcEaxMDg8nqM0A2j4kEogBmvEaEmQ=;
 b=KDPYu3hAOA7RsNZvrbuoO2bKUsv7vOxQFG6FEs6T/QMBcU3I3F4Fb3qwg7p2KVBzHp
 1TQrrP5NR6sHyxZWOxSvJtM99vA4cNGt+9rVrs7Pkn73zuCsVVmlN09EJzC49ZwTsW37
 Tp5QxIP+wUyzR8H7eEIHD2gz7EdCbkIa/b/dCtZXKZbckrCcnM5n0stCxcXg4VXLEDJ0
 x8/WD3OxwhHWqID8qStAkT7V2dP8N+OQJTYDhwXcfSW2k+ya2gy/PP2ThHtYNvA0/UlR
 Qw7IBS0iWParmhPWhOx1QVI920gvQ6IumTACfJR9yjOixbBupUGw7uvflvfu0e0b7a0i
 RmdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd1RXb2n43HTdtC9Och1sBw2S38tJvtjpqAR61tQTQXhpswdGs0Qiv884wBTyhp2oEv3taNNyOQIzbzN3O8M+gwOzXLg==
X-Gm-Message-State: AOJu0YyCash9FBMATOi1Nuc5vwxix6HXWMvHs6ooOKSYKZ8ZfX4GZRAE
 CrAQW1TTbiNKsMu7vSt/U/QS2qF5PxVeyV/Hgirn/e6WtiRS/E8z
X-Google-Smtp-Source: AGHT+IHMc4Lt10MmUWEQfIIkDwkooHIOhpwVQF658XzDleOp5s5rImPLgpQ7dc+Si3FCvzzT3bsSnQ==
X-Received: by 2002:a17:90b:144:b0:2bd:83b6:a571 with SMTP id
 98e67ed59e1d1-2c1dc58fb4cmr1767762a91.24.1717165177887; 
 Fri, 31 May 2024 07:19:37 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:19:37 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 14/23] rockchip: RK3308: Read the reset cause from
 clock reset unit for RK3308 SoC
Date: Fri, 31 May 2024 19:48:28 +0530
Message-ID: <20240531141837.13189-15-linux.amoon@gmail.com>
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

Read the reset cause from clock reset unit for RK3308 SoC.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/include/asm/arch-rockchip/cru.h | 2 ++
 arch/arm/mach-rockchip/cpu-info.c        | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/arch-rockchip/cru.h b/arch/arm/include/asm/arch-rockchip/cru.h
index 7a69a839e6..6fe73ad0cc 100644
--- a/arch/arm/include/asm/arch-rockchip/cru.h
+++ b/arch/arm/include/asm/arch-rockchip/cru.h
@@ -23,6 +23,8 @@
 #include <asm/arch-rockchip/cru_rk3588.h>
 #elif defined(CONFIG_ROCKCHIP_PX30)
 #include <asm/arch-rockchip/cru_px30.h>
+#elif defined(CONFIG_ROCKCHIP_RK3308)
+#include <asm/arch-rockchip/cru_rk3308.h>
 #endif
 
 /* CRU_GLB_RST_ST */
diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index 383aa3d2ee..dbc126c862 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -26,6 +26,8 @@ char *get_reset_cause(void)
 	struct px30_cru *cru = rockchip_get_cru();
 #elif IS_ENABLED(CONFIG_ROCKCHIP_RK3288)
 	struct rockchip_cru *cru = rockchip_get_cru();
+#elif IS_ENABLED(CONFIG_ROCKCHIP_RK3308)
+	struct rk3308_cru *cru = rockchip_get_cru();
 #endif
 	char *cause = NULL;
 
-- 
2.44.0

