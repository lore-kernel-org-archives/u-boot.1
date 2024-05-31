Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27308C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3932E887CA;
	Fri, 31 May 2024 16:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dgZFAz3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47579887BA; Fri, 31 May 2024 16:19:00 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8425887B7
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-6c5bcb8e8edso301926a12.2
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165136; x=1717769936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6CwE8ETx3ULNcFmrHKZVtIh7eAr69PsZXV1eM76lFE=;
 b=dgZFAz3Vfxn5wSkNetnTgpEFiP/6K4beYujYu/rtzTEZdtvJzMgcJce+ZaVflnzlFu
 5+CzqPEf4sPidbN8TpEqx0OTi/yH5QxEAM/kWbEtHsaRE8U8rqpRw/wQWYHOyBPSGLQ6
 6HhZl9UFhwqtc/fP0tf7MIAPGkcTUrWOaLsNHqlc1Oj/gbT7oGtmjI9bkYT2NqeFVc48
 gvBTx2W76PvyVZM/m2nOesU6+S0cedjult6MTy4D6KJtD9d+1FHii4CWfCLSyMrEK7Qj
 i7iBM30GDZ7J+Gt27ebudEDQI8euvV6Iy9v6qBhCERXVJzjlILfL+oCMbsMyxsguAuyn
 FGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165136; x=1717769936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t6CwE8ETx3ULNcFmrHKZVtIh7eAr69PsZXV1eM76lFE=;
 b=M0mm3mMwL1izx7p115J3mk/oXk3X7QsCQDqRmS1c4Zjmg50MX/tgMlNm3tbcZAz4yd
 bEBfoX0uMmzkS8rbKzzvQ7eycKp2HiD3PVCY0tCYRPxj7EFdSd5xjG1z15GbjrQUY9b+
 pQX/w21agBRNK7YlFXyy8JJCPKY19WRTKebffp//vurpRJvs3ODh3ffqkF0O25evdXaa
 3oQrVKq/8pWCXEdHIcahSE+QopjsRvv/gD28tTPGc9nBhtXMggVEwWYDrqkm4kAvh2Lw
 +D8gbDqvXdWJKllFzUooDZKishoFYmdfEkMfLAXqU+Sy1GZvEYxlsVmp8iQQ5w4nox/M
 3AyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsYBv1Ti+7rJ1628bqhL/BL7hpMmoeC9rQmQft1Qz4UwR1AtwuKuw064yqKYIsycf8nXrudugu4jsL0U5HWtnEF1kesA==
X-Gm-Message-State: AOJu0YzXnSf4eR+LJTHZ4kn2BADcPYUzWgP+8UsIi4kqS7xhJPUi8flS
 N0sSi9vNihP2XYH83eUam6KFLukJYOlRKZLChVR6lEd1hr5b+K8j
X-Google-Smtp-Source: AGHT+IHtQhNWrxx7CXzwrHNKwoYL87TnHh0yHn8lXIcIXvwHpmqSTI7NgJSwy0BFWclsVptLPF0i0w==
X-Received: by 2002:a17:90a:d513:b0:2bf:7ccb:b8c0 with SMTP id
 98e67ed59e1d1-2c1dc58eb8amr1902539a91.26.1717165136268; 
 Fri, 31 May 2024 07:18:56 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:18:56 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 01/23] rockchip: RK3328: Read the reset cause from
 clock reset unit for RK3328 SoC
Date: Fri, 31 May 2024 19:48:15 +0530
Message-ID: <20240531141837.13189-2-linux.amoon@gmail.com>
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

Read the reset cause from clock reset unit for RK3328 SoC.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/include/asm/arch-rockchip/cru.h | 2 ++
 arch/arm/mach-rockchip/cpu-info.c        | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru.h b/arch/arm/include/asm/arch-rockchip/cru.h
index 9778790f34..a1499e9652 100644
--- a/arch/arm/include/asm/arch-rockchip/cru.h
+++ b/arch/arm/include/asm/arch-rockchip/cru.h
@@ -13,6 +13,8 @@
 
 #if defined(CONFIG_ROCKCHIP_RK3288)
 # include <asm/arch-rockchip/cru_rk3288.h>
+#elif defined(CONFIG_ROCKCHIP_RK3328)
+#include <asm/arch-rockchip/cru_rk3328.h>
 #elif defined(CONFIG_ROCKCHIP_RK3399)
 # include <asm/arch-rockchip/cru_rk3399.h>
 #elif defined(CONFIG_ROCKCHIP_RK3568)
diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index a62ff53c6a..86b0c02970 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -14,7 +14,9 @@
 
 char *get_reset_cause(void)
 {
-	struct rockchip_cru *cru = rockchip_get_cru();
+#if IS_ENABLED(CONFIG_ROCKCHIP_RK3328)
+	struct rk3328_cru *cru = rockchip_get_cru();
+#endif
 	char *cause = NULL;
 
 	if (IS_ERR(cru))
-- 
2.44.0

