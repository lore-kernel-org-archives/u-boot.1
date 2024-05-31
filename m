Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D25DC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 126A1887B2;
	Fri, 31 May 2024 16:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hNXcT8/3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60175887C2; Fri, 31 May 2024 16:19:06 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3755688607
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-6c3129527d1so871093a12.3
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165143; x=1717769943; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HfrkDN+KjH8ivTMSoKzHbYFzssxxJn10xRYZB4lHotA=;
 b=hNXcT8/3ktfpRn+a73tXXxa2vnX/4ua5xrVMB9wNOPiyUifBvucSM49XcLBkZMeFbD
 EWo4EYdXoVOby7nctkiWgQlRKptUMDErpn8LaFHIbKMkdbiI/haOHIoYCsuNeyT3Odpv
 vSAL/FEEdpM6fH6KGTB748X0xUSLipv26tIPxnXqr1g6h/5HX5EzWYaCYTXrCKSFeVsk
 EeglM9RQEthQRax+6oSAfwZvmcHVd+I5kXFz2LCW4Cd/1VN5ZLvSJTgZYg6AZHbPgTMU
 XfOKNSlsJz4urF1WlKRyx2g+wDLT7FH07D+GMFXAG9Q71pIvutRsPF084PD7cwVZa7Cz
 mG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165143; x=1717769943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HfrkDN+KjH8ivTMSoKzHbYFzssxxJn10xRYZB4lHotA=;
 b=eGviJ/awRCVZa3+oTVfLlpocZXzI42L9EaRGB3e9f4OUaBIJnWs9UrgTHQe7mvmGSA
 Jw5RuHDA72MHXrwoYonfGlo2qqfP2VOotJJkozT0gIT1irnZOrnFIsm0otdlphvb2Iyz
 DbJkpxIQ2Utb6CwnLNULJe09Kl+dsTadfpAh6SBW6dMw7saoeTigESfafthlD4BZguOI
 NzPzvz6vCeEDlT9A+p7B5GBikEs9ztZA0X6Jo3uxyo63I1QF4XeWjIP5lsJbyZ0adG/R
 xgKV3AXdpe8oIc4KKluD3oGt7n3ZumpPrpNiKr5+T5z09kjlmD00VYdh54coy0V3teJQ
 tpuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEUXkLj9RbvrwMKbh75mt1RM3d0ttcMCYR9NsFScPTPWPlbhRQz/E0iWyEGN40Tl8G5HWVZQl17R2mrgPyIKiKhfGjTg==
X-Gm-Message-State: AOJu0YzFgWKuqV6BIGY1kKhEqluHmSy3KFi0RHmzs73gs+sDeASllRUT
 pwVIJRdvezarf2fwHkGFkGs2pdDnBmSJue8O8cxN0Ny2ox8/SL/j
X-Google-Smtp-Source: AGHT+IHqb0OoF9FbB88qit6/XdgBY89lHohzcuoocXWNT2Ku6liZgcgjjAiN9QYUMrhmr4qGUMH+0g==
X-Received: by 2002:a17:90a:db09:b0:2ac:513b:b316 with SMTP id
 98e67ed59e1d1-2c1dc566945mr2019695a91.10.1717165142668; 
 Fri, 31 May 2024 07:19:02 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:19:02 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 03/23] rockchip: RK3399: Read the reset cause from
 clock reset unit for RK3399 SoC
Date: Fri, 31 May 2024 19:48:17 +0530
Message-ID: <20240531141837.13189-4-linux.amoon@gmail.com>
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

Read the reset cause from clock reset unit for RK3399 SoC.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/mach-rockchip/cpu-info.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index 86b0c02970..e7cbcf5090 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -16,6 +16,8 @@ char *get_reset_cause(void)
 {
 #if IS_ENABLED(CONFIG_ROCKCHIP_RK3328)
 	struct rk3328_cru *cru = rockchip_get_cru();
+#elif IS_ENABLED(CONFIG_ROCKCHIP_RK3399)
+	struct rockchip_cru *cru = rockchip_get_cru();
 #endif
 	char *cause = NULL;
 
-- 
2.44.0

