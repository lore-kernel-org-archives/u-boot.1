Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E541C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:43:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48BA382A1C;
	Fri, 16 May 2025 01:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EdfkaVma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E19982AFD; Fri, 16 May 2025 01:42:16 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FCD582AFC
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72b7a53ceb6so1099484a34.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352532; x=1747957332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RrIL40OwQR98JxNxvQCXzrX8YNb4kqhuC7RPo9B3cGU=;
 b=EdfkaVma11TjJEU63D4wKWA7pFsAaY+j1504zo+Jp7R5pGgWFdTLokjcZNmKQTBeaF
 wgS/9XyENTIx98qmd3acYFASNgTHx1WrTjQ/QddiD0oJmdHGibT/FcRe4BTQWsL/LCFe
 AFkmHe3xYUG8r/h6QdKoBwcwFtqD0+pA2zv0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352532; x=1747957332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RrIL40OwQR98JxNxvQCXzrX8YNb4kqhuC7RPo9B3cGU=;
 b=C3MDopmNbtMa1EnPQSWM1R/LNfT4vrsjPBQ81EHKRl9PpB6L7JcwUtXZh3DHjPH9es
 QEJCM9VEQ/cyriul64OYt7zyG6k2ua9vrO3RF5RUnWk0DmXTWSJTms69kJ73epj/U7XH
 dM2LfJe6QHK/pymh7qET4fhJWFQbOgizRLpWkMv7CCAGbH4Gc8YQoJDPu2j62Ha/dSP/
 nWzVb1H6tX2OQdU3J+uBgLMeF7UPrHSM1TBN1Bzpevbef26bUOjt3Uyb9apusMqTIDiM
 OKRx/HlUirnJSSMOw00yWPY50dK5FKTSnirQOa7e3VfVyGi/AgCm1C4PneVkscjNkePK
 zKVA==
X-Gm-Message-State: AOJu0YxybKrg4jo+nPtqwcDW+vIQ3iNi1HpjgBl5gepol1S7IHiodwaa
 RvIcBrOeAiwBr1eFL0Uor2xTXDGG+grHkKW868xP+agKCjWgvHpgtl8Su8fPq6fbnKppFcKMMgB
 Zq7vuug4=
X-Gm-Gg: ASbGncvVaGVihSmHKdwSFRF+i1wMML/csozt2Rwd0RECySOI0uNug9KohlVZRjJMS0+
 9M58Q5Ct1h2FHGJrYUvEOq8KrMDznJhEhLz6Hpiw0UJxvCvNimV7kMD8Nol0r++rJ334MYwB0w2
 +eniGqWT3VbWQJ6CCGtJJhIfGt+RRQpFz/xFf92LDCby7X+zT7c8HCpP2o7kTHpIZrxKjprFtXo
 NqhqNVZiNJmPumi29CfCVdTU0eT33BQfsgjeWo2aNEcsbJ4QDXkoF3rDstQL4chac76t4P2VES1
 vp2MeQRhAyeJBdjwQhjvG8YPzZILhAblnP1JAldWrzr9j27Shlv8uJaXj7HxdkFBvzrZtPtiKJ7
 2EBvkxYejaPfWjnM=
X-Google-Smtp-Source: AGHT+IG5dG3ZaU+6oKb44lzxQQrsKLr2Fr9qRSCPjQORw8IfLmfH0iriqDPKn9iDeSSXu88rCRpC6A==
X-Received: by 2002:a05:6830:6513:b0:72b:8f4e:8c67 with SMTP id
 46e09a7af769-734f6e64232mr882570a34.13.1747352531837; 
 Thu, 15 May 2025 16:42:11 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 11/22] tegra: Include env.h to permit reading the
 environment
Date: Thu, 15 May 2025 17:31:40 -0600
Message-ID: <20250515234154.1859366-12-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515234154.1859366-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

This file reads from the environment but does not include the correct
header. Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
- None
---
 arch/arm/mach-tegra/dt-setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/dt-setup.c b/arch/arm/mach-tegra/dt-setup.c
index f4ae602d5239..96044ac78ce4 100644
--- a/arch/arm/mach-tegra/dt-setup.c
+++ b/arch/arm/mach-tegra/dt-setup.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2010-2016, NVIDIA CORPORATION.
  */
 
+#include <env.h>
 #include <fdtdec.h>
 #include <stdlib.h>
 #include <asm/arch-tegra/cboot.h>
-- 
2.43.0

