Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45ABC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D774E887DB;
	Fri, 31 May 2024 16:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iZoNiQhy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95702885AF; Fri, 31 May 2024 16:19:29 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A12BC88805
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2bf59b781d6so1686637a91.0
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165165; x=1717769965; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z1GYDYqh5JucYdvRRf2qwFOfj0nD54qmJyskxUleqDs=;
 b=iZoNiQhyR4C4N1zh/a+0pTZzXCAediTTWOqd/6iw8GqjSPV+3VJA2AderH6kkYxBhS
 3atsf6GTkjUorHq8l5sQfQTX8t7qHlqNoKJRarEaqx2WhMtug9Y8mXrjRtFMOjoe316S
 ynyq1vqG8jFlOBZCy6zDAurciq0S9JcCCbi3W69At7bYbHtBFd5PEvcJAdG6HlhlDdcn
 EO4o5K1m9yhtHXLiBw40qY7Sbb1ooN51Blr38M39lOX2PXzUVdFnNHZRbk2jO5loDdPX
 01KtucC5U7UJOWtrePkjNOWMOgj7GHeQysOj/G43HuEgDDmAvOk7nfgkkRf1xQjkfcSV
 TOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165165; x=1717769965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z1GYDYqh5JucYdvRRf2qwFOfj0nD54qmJyskxUleqDs=;
 b=ceMU2fXD+qt5m0loOw+KKGzFdANOJvOWrGXESsRRSzuecCwwSmk+B6dowNsOCxmT7L
 hsBoP0HHqahCwb7skobilsFKe4yzFnpB13sigjHG4TQGGoFwlzCYBU6zGa4chm/+o9w4
 5osYOTt6saCnTbkkmyQ1MEQzXg+Scz6RkSFGUeswkbcWUa4X4ZgUJGD+aTPgdEkOL3Su
 eozIvDwlrxB1LnulETujcpj9fYvCITUwUH13zHcRqVS+FT80YcwqwsA1HkpX3JkFHUHx
 aZ5YSGMgQ1PjgVE/WUxfy0BExMr3T+09itXLvVQbW3F/PDuqZCa1qPZAE2qC8j+bjPwc
 E+xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOE/k5iLRX3di7znv2BzQf2KJwW+PYSWLxH7JJyevG5KyjI8XSNaIf9//HcybNmHxtByANcj0SCVsTyd8eAL+ybIkWKg==
X-Gm-Message-State: AOJu0Yxvx1cYyD/aSHAkMuePlhP5zMoPRTwT8ZwXnXwMcTFWEEUU3jVh
 9Q1N9hF9bz7Lkco2Qrin/e2oEPjyNLdXWtCFxOhrRCggPyzi1BfV
X-Google-Smtp-Source: AGHT+IEHW1lqYg/No8AiWIfT/pyNVCGG1Dxd1vccXCe3dXsin2aAs2ioaKMcJ/tVP3qob0eMCbYpUw==
X-Received: by 2002:a17:90a:f689:b0:2c1:b6d5:9280 with SMTP id
 98e67ed59e1d1-2c1dc5897a7mr1822018a91.28.1717165165123; 
 Fri, 31 May 2024 07:19:25 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:19:24 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 10/23] rockchip: PX30: Read the reset cause from clock
 reset unit for PX30 SoC
Date: Fri, 31 May 2024 19:48:24 +0530
Message-ID: <20240531141837.13189-11-linux.amoon@gmail.com>
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

Read the reset cause from clock reset unit for PX30 SoC.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/include/asm/arch-rockchip/cru.h | 2 ++
 arch/arm/mach-rockchip/cpu-info.c        | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/arch-rockchip/cru.h b/arch/arm/include/asm/arch-rockchip/cru.h
index 19bd2b405b..7a69a839e6 100644
--- a/arch/arm/include/asm/arch-rockchip/cru.h
+++ b/arch/arm/include/asm/arch-rockchip/cru.h
@@ -21,6 +21,8 @@
 #include <asm/arch-rockchip/cru_rk3568.h>
 #elif defined(CONFIG_ROCKCHIP_RK3588)
 #include <asm/arch-rockchip/cru_rk3588.h>
+#elif defined(CONFIG_ROCKCHIP_PX30)
+#include <asm/arch-rockchip/cru_px30.h>
 #endif
 
 /* CRU_GLB_RST_ST */
diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index 113a03acdf..9be28754fd 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -22,6 +22,8 @@ char *get_reset_cause(void)
 	struct rk3568_cru *cru = rockchip_get_cru();
 #elif IS_ENABLED(CONFIG_ROCKCHIP_RK3588)
 	struct rk3588_cru *cru = rockchip_get_cru();
+#elif IS_ENABLED(CONFIG_ROCKCHIP_PX30)
+	struct px30_cru *cru = rockchip_get_cru();
 #endif
 	char *cause = NULL;
 
-- 
2.44.0

