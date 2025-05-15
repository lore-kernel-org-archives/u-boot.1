Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8C9C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B2BB82AE9;
	Fri, 16 May 2025 01:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ov9ijzOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89CE782AB2; Fri, 16 May 2025 01:42:21 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8660D8059D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72c7332128eso1084299a34.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352538; x=1747957338; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6NIoyqTsTtShz0AEtAGFyo5No0w3JO3pr2HWiFoFDA=;
 b=ov9ijzOPnUAPaZTMLE9fUeljo+RcOT9mah1F26Lbsc0a455S+kYKQks/zH8w8lqSjv
 aN7/0KcnZOv/SzfZr09LU9rmHDPK1NzYwAUDVYriFfMXrO1ARUSjvh9HAveVSw+yDckc
 u3uI0BH3+XA5PuPS9+LVLW9s1SNbmR7V9qVGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352538; x=1747957338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6NIoyqTsTtShz0AEtAGFyo5No0w3JO3pr2HWiFoFDA=;
 b=JpzP6zoSEDJfPJmaAYPaBA/d32Xew90yX7LJ/Q03+xtxXcoANbNrGqI5UFdrtfyriB
 k0d/o6o+feoLlLaRTgFjDN9gT/j66OTzG1O6ObKuFDHRE27xy+Hy3Cbp+DOhR9/wC1qA
 vwmOoHzqlDS+SIUdhPwuXRQXBtS8jJl5jATVESnNsodOPL8nQ8hg5Kgkuq+kR0g3Sbzx
 W5lRz4Z6NrMo5iqd+YbaUT9/3ADtdI+p+OlXo+0lZsyjB3bwjHT9r95EM/WCEEDfZwAp
 ExNgVKwGnkkmxm/ws4CfEX8Jy2wcHXa/FNIDPJy4OPlA6z2sM/U5oFwVz201N7HTh2Vg
 HlZA==
X-Gm-Message-State: AOJu0YwTOjcF8n7/SzLJZwoWZ8RpNBQSMikUCN3shS88oa8ZQsQDV7CB
 o+BPpQI4HqH7K+raIxRkHfVDXs9e9hcWqTApgxG6O+gY7PGJJdIyc0w4kqpqmDExmsCzv0zteKk
 M0BaCW9A=
X-Gm-Gg: ASbGncuOyrUH78jtB8QF0PsYiSEqfsDJhaIgkq95fP/eY89oIHFoEV9hIi5+HLGaOir
 pZI/euJyUcQrcfyQ+EAWrZZ1owF1iR4/lA88OwNEcO+HcqCH8sNEl3jjJjDEAoquiden3Hb1wT7
 Di850s7i+vAJAwhaLTSu/ZYsILr5jGz0WmY9pdRudfZHv9ceN69gZc3ZZ+FeqLGnaBIh5N5P5W0
 ZXTHYAOdt090tc12cAm7EngIhPgr1AoDJ2VzNlXdl154szrxiNmjvmcXMNxQ/pBSBSwXXzyg3Xt
 VEZsaZp3W5OVAuvTN+hDQgpUKNYIhG48C4uYju4N9csSSBMmLHN1/bVW+oYU9q40GOPuuWHg4qf
 1p56CJP6fqrTpIWY=
X-Google-Smtp-Source: AGHT+IGniNHcJWY63vdWaRDv/mrUynfVeU8FR7LoQabjTJIgTIWeo6e7I8lRL4g/cRxJ45RiTp1sQw==
X-Received: by 2002:a05:6830:3902:b0:72b:9180:cc75 with SMTP id
 46e09a7af769-734f6ae22bdmr895409a34.7.1747352538310; 
 Thu, 15 May 2025 16:42:18 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 17/22] technexion: Include env.h to permit reading the
 environment
Date: Thu, 15 May 2025 17:31:46 -0600
Message-ID: <20250515234154.1859366-18-trini@konsulko.com>
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
 board/technexion/pico-imx7d/pico-imx7d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/technexion/pico-imx7d/pico-imx7d.c b/board/technexion/pico-imx7d/pico-imx7d.c
index d0f739c624a1..cf6b7fcbd958 100644
--- a/board/technexion/pico-imx7d/pico-imx7d.c
+++ b/board/technexion/pico-imx7d/pico-imx7d.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017 NXP Semiconductors
  */
 
+#include <env.h>
 #include <init.h>
 #include <net.h>
 #include <asm/arch/clock.h>
-- 
2.43.0

