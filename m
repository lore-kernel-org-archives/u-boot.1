Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C489C25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 139E7887EA;
	Fri, 31 May 2024 16:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EO0/vphL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85B6A887EA; Fri, 31 May 2024 16:19:22 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57596885AF
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-681bc7f50d0so1745300a12.0
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165159; x=1717769959; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=huJRp8nIdFu1zVc/N0yHO2D8ULUSfRiWbO/1WyhRfQ4=;
 b=EO0/vphLRnWsMf05nL46ZzZCaWSdQN1DK7UXVkcM7xy3d3Kg6In3WfRlDzdHeHsiCf
 QjW0yEq+tmphH5qaxx6Ymp+wLmOIQaOrGG8Ysk5VsvVGBSP3sk9rmeYXGNOad/C3bj4p
 URWbcR3d/869ltt6hR93Yo4gOPUoba1tu63Cry/Qjz5xA6sXFoaci6W+hDmqD8leGJZV
 m+W+SzP2THeLpdIlRWTBeshwjStNlujGckc073upIP2iGe7clRws7TrXYtB3C+GAxDoX
 Hlz0XnaLam/5Zn2noCbBFF3TvozLWiJaqnv34ksdubTKxqSBjCW79KvigZBbKE9XMfr7
 G4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165159; x=1717769959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=huJRp8nIdFu1zVc/N0yHO2D8ULUSfRiWbO/1WyhRfQ4=;
 b=kSTakkTH6XcD0G2BBxEhkxxyrV5/pMpzCukVE0rImC8LIXzWS7qRnDNPKks+trQslI
 edXzWJYJj1NPhwa2rJYXPYpphw1ubBrHZcd5KUhbkL5qO1krGbfwYctoJ90DfjblH/r4
 sw4knUkJIe883SxkGMUdbYzkYeEGgPe8xZLcmCLLVf6OL49yqFvUQMWp/gVLYK3zSEQo
 tNfb5cxexydxJokr+EY9FOySXpMmKsUR2BkNk4lxpZKYmnp5p+c6+H3/7jIAlSbvnkUy
 hTdUqD04Y5CVOOTMcvhJ0ZSUNcFNYBHbIIrsUvJMfKf3NtoGcOTRMSKCS2xL4+kOKbVg
 1Tlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9XXf2uvfCfPUAXHfJiIRN080M92E5t4r7smTNT3cL44c4FjI7Y9e4jMv9exX5EMEsdbbk4aG4I5g9AOVCH3wm2qvBqQ==
X-Gm-Message-State: AOJu0YzSjsvhMrMYaKcg5rqW5wqdFIKOfGVCzDiNnS+giJOThZUPTf2D
 DQvYNbRorxUbqEnE1MXdQWgug7IUfZaSX84dLfchcMrMweW5rZcc
X-Google-Smtp-Source: AGHT+IHKjvV0redvb4wlQU3fSNI6VtLGBuSpUnuaSZj1H33srqiwn+LX5rikfy7AqnlM/kKquqnZTA==
X-Received: by 2002:a17:90a:3482:b0:2c0:19bd:543a with SMTP id
 98e67ed59e1d1-2c1c43ee447mr3152795a91.9.1717165158747; 
 Fri, 31 May 2024 07:19:18 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:19:18 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 08/23] rockchip: RK3588: Read the reset cause from
 clock reset unit for RK3588 SoC
Date: Fri, 31 May 2024 19:48:22 +0530
Message-ID: <20240531141837.13189-9-linux.amoon@gmail.com>
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

Read the reset cause from clock reset unit for RK3588 SoC.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/include/asm/arch-rockchip/cru.h | 2 ++
 arch/arm/mach-rockchip/cpu-info.c        | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/arch-rockchip/cru.h b/arch/arm/include/asm/arch-rockchip/cru.h
index a1499e9652..19bd2b405b 100644
--- a/arch/arm/include/asm/arch-rockchip/cru.h
+++ b/arch/arm/include/asm/arch-rockchip/cru.h
@@ -19,6 +19,8 @@
 # include <asm/arch-rockchip/cru_rk3399.h>
 #elif defined(CONFIG_ROCKCHIP_RK3568)
 #include <asm/arch-rockchip/cru_rk3568.h>
+#elif defined(CONFIG_ROCKCHIP_RK3588)
+#include <asm/arch-rockchip/cru_rk3588.h>
 #endif
 
 /* CRU_GLB_RST_ST */
diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index e12f84a1d2..113a03acdf 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -20,6 +20,8 @@ char *get_reset_cause(void)
 	struct rockchip_cru *cru = rockchip_get_cru();
 #elif IS_ENABLED(CONFIG_ROCKCHIP_RK3568)
 	struct rk3568_cru *cru = rockchip_get_cru();
+#elif IS_ENABLED(CONFIG_ROCKCHIP_RK3588)
+	struct rk3588_cru *cru = rockchip_get_cru();
 #endif
 	char *cause = NULL;
 
-- 
2.44.0

