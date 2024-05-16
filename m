Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB58C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 12:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0F678704E;
	Thu, 16 May 2024 14:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="o0CG+yRk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF68A8824A; Thu, 16 May 2024 11:02:58 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84AA088258
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 11:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=anand@edgeble.ai
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-23bd61fbd64so228608fac.0
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 02:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1715850173; x=1716454973;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9EE9IKbI7WW+fYz9MVqHAZCyMbUhpRk4cuLFOHdNjWk=;
 b=o0CG+yRku8/qEjReE7+f/9SmyMxhIYlMF+GV8yXEJkIibEcaXTv+98NurkSH3/7m8l
 SdZBhdy8uLO3w4ZYIN/WI64BSg1eLqUjYYGyQzveMBjkZza8e+2Lg8n+MQ3J94R3dhee
 8La6FESzrhw2oCFtcYRy32lrqk6q6Q5IrbgwW8lcBGH0mvTj/XgU+2qb9bDff+KOmu4r
 QjX9baFrak38nbSFovGZMp3vz/Q7f4MmHlq0kHq2ps2uZaRyslgdfugaNA0hcecJoHI0
 kavbf5kvS6Cj2M7m8qmJVg9MrEa9nE+rEP3Hl9pP8BYHUcGdH1WkSeaW/49A7o/wH8tf
 dORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715850173; x=1716454973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9EE9IKbI7WW+fYz9MVqHAZCyMbUhpRk4cuLFOHdNjWk=;
 b=NqQ5RlyTLDxeyXpYdGap8wooGe2cVORuvEXDnQbhJwdY7Kx8/igbmpxapNOBHzuWob
 4oQEoXGJPb1gCnYLPLypkXzWFoNFBvRSEHafYQzE8tvMzSoh8YMBcsAdzSeqGVBNSkUz
 /geXgVfC2UJmXIJwEq33bJTm/ysd4p1jlP2m2BTlGzRibAdIXGRUUCNdspRkyydInJMA
 +FP1y5eIOD+lH3fs79cV+aBOFnYYQZqM9TquSPku+vzttDfx5FF/BWFWBGHmvyi9hMcr
 dm0B5KchKf6RhCxpIs+i3jISd2F9DiK+5jHl8SHmtYgBJ2d0WbpXPcVZoHIETxsxdeMJ
 Cz4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE0NnhjuNesofsqmN91DQp+BEvP86TTVoDdxfS1NnaVhMdV7qUfywXc0xPt2MtxM+h3YG9awDTUGXQ27XwBkaFytkYEQ==
X-Gm-Message-State: AOJu0YzoXtyWsClyqe+xPZWQxF/BNhx/go/xeHni7cDn6iZCKHKeXDcE
 xnbWBiDRa4sQkWjnhJmLcqFMIA1KQtd1kPOKB+ta3s/L4L9RzJ43NEMcvM7w9g6ZZX6YtJtHchg
 m
X-Google-Smtp-Source: AGHT+IFEqCEUROOrFC5KWkQkosbNTPq5SqUhNJSxZxSkpzsgx3ZnzI+sXTDxLrqIp3g8oAZ/HKX8aQ==
X-Received: by 2002:a05:6870:a44c:b0:238:c6c2:2f1f with SMTP id
 586e51a60fabf-2417231344bmr21154284fac.0.1715850173170; 
 Thu, 16 May 2024 02:02:53 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6584e7897bdsm1325189a12.21.2024.05.16.02.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 02:02:52 -0700 (PDT)
From: Anand Moon <anand@edgeble.ai>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Anand Moon <anand@edgeble.ai>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de
Subject: [PATCH v1 1/9] rockchip: RK3328: Read the reset cause from clock
 reset unit for RK3328 SoC
Date: Thu, 16 May 2024 08:59:01 +0000
Message-ID: <20240516090031.2373-2-anand@edgeble.ai>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516090031.2373-1-anand@edgeble.ai>
References: <20240516090031.2373-1-anand@edgeble.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 May 2024 14:50:16 +0200
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

Read the reset cause from clock reset unit for RK3328 SoC.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
---
 arch/arm/mach-rockchip/cpu-info.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index 14c7331e1a..fce4bd7541 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -8,12 +8,17 @@
 #include <init.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru.h>
+#if IS_ENABLED(CONFIG_ROCKCHIP_RK3328)
+#include <asm/arch-rockchip/cru_rk3328.h>
+#endif
 #include <asm/arch-rockchip/hardware.h>
 #include <linux/err.h>
 
 char *get_reset_cause(void)
 {
-	struct rockchip_cru *cru = rockchip_get_cru();
+#if IS_ENABLED(CONFIG_ROCKCHIP_RK3328)
+	struct rk3328_cru *cru = rockchip_get_cru();
+#endif
 	char *cause = NULL;
 
 	if (IS_ERR(cru))
-- 
2.45.0

