Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C10C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 08:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE2C1830EE;
	Fri, 18 Apr 2025 10:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d8K9eSz3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51E3B830E9; Fri, 18 Apr 2025 10:20:09 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F72982D57
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 10:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-54298ec925bso1885702e87.3
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744964406; x=1745569206; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Czt+zQIFu0OndIKPKNuAERvg6GA3BCi/MXZIboOxF0E=;
 b=d8K9eSz3YMgBafH7QuFtv8Y8meCEVi2i+QEqfgN0OCY7w2ImPEYz4+DOcw/9wAjcd5
 9ZLk4KlXBo4eXdjic9uwqJXt+yKQmOu7tCWtrsEM2+wwQU9A74gCkF3ZGOCND+UeJ9Zm
 QJq52Qz+CvYq2De018OOZriP9ebxUb+qqquiV2oK2gHKXKk7ExDqE0RweJuS0YDPS2FB
 bjFyaqvYLwUMUr6V+TtsLgsHDgGT6F8/e6V4DfpJ8tNftiEJWsdhkMnE6S+Vlqw28kP/
 J/WavJoe0yIVg75IZ5ue/rAWLOxVZPEdn0AtlBUAhcNzvxGZXsBexF9WBvxnC6IBsWE5
 fYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744964406; x=1745569206;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Czt+zQIFu0OndIKPKNuAERvg6GA3BCi/MXZIboOxF0E=;
 b=rcdnYSLu0CZKVlVB8iHetiCgbTxG0hK5OZS5Kv5L0FbcCpBfgwRur+WNg9UpmZZ7G1
 YmXzDeNAy45BOsfjTk2riq64b9OVaMtn0gUo7ZXO6nbkm7NuHWtx7/9tE0GPOK6LxZn4
 WxGyCUH8wrzYImo5PrOhSuSx7//z56w4t8J2H9hcz/tCNgdBi2P0/VYUmwLw7K1S+SiB
 AU2RrdfjVWC7orMTzNQXbsYrLSaVHXXCJWHNYeO057khA3VDY5Fhyz4ukBLJmtM+oUdr
 QekXsFq4vhce8S/rwcbux4kAM2UHf4DKDgPWDIo6JJ2Yznc+PF9gPK8GadA/be4Msq1a
 x+VQ==
X-Gm-Message-State: AOJu0YyM2qdii/kNo10flwiyFRAVWU2li7vSh4Yxw+VYKO7jEBT9lDK7
 MA7Yb4PYucTT9itqwltaPXMEvjMNQhnhtouxU97PF1gFyukkOJE1wbh8ew==
X-Gm-Gg: ASbGncuVrZTIA1frj74k3eJdUKv0hF0g7sGz9FcsjMOrUKD3+04Nebc3nE9o6+h/5PR
 AmWS98/K9SLpP1Bnd8gQtYmfBGs9kGe4ipXg0iliVKMY0iyJeuFvBCZKfn4AX6ToOqlq/fzRwtS
 SbBImHwzcrFJifqeZp20jjVToDBtb2Y6fjoOTsUSWUM6Y41qPIdjMZGAbITg5aYJqj56s3fulzw
 snpYAq7hvlmr5HBPjJQL/TxuGQrtqQsFU1tfLX3UPzUgSOEKu4J0GR86FwYjbv/t/SPLyvlnr8V
 +kdPaRK2GHN56r13QqNDasjywWMy0ADUEMf3K83IU8R090kV2f1jjszFTzg5aoXveYZ6n5PMQVE
 AUy0zx9OQ
X-Google-Smtp-Source: AGHT+IH/hEZ85ruUfwspZv7WNqWBgsHiByflz7KgYbClepo07Dz70XEXBSfVPjJVv7KmU85CqssoHw==
X-Received: by 2002:a05:6512:1394:b0:549:66d8:a1d2 with SMTP id
 2adb3069b0e04-54d6e62b1e9mr365962e87.19.1744964406041; 
 Fri, 18 Apr 2025 01:20:06 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54d6e5cfd4fsm128795e87.114.2025.04.18.01.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 01:20:04 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] scripts: Fix potential null-deref
Date: Fri, 18 Apr 2025 11:19:55 +0300
Message-Id: <20250418081958.12818-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Maks Mishin <maks.mishinFZ@gmail.com>

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 scripts/kconfig/menu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 5c5c1374..a0d0d2af 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -812,8 +812,10 @@ static void get_symbol_str(struct gstr *r, struct symbol *sym,
 			}
 		}
 	}
-	for_all_prompts(sym, prop)
-		get_prompt_str(r, prop, head);
+	if (sym) {
+		for_all_prompts(sym, prop)
+			get_prompt_str(r, prop, head);
+	}
 
 	prop = get_symbol_prop(sym);
 	if (prop) {
-- 
2.34.1
