Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2226AC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 22:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 477AD82EC6;
	Sun, 29 Jun 2025 00:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="elKIVgh8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3966882EC6; Sun, 29 Jun 2025 00:44:06 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18CE482ADA
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 00:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-40af40aef06so2369197b6e.3
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 15:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751150641; x=1751755441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ANMxp71oZQrJ8GyPCotnNktmF1zSqEuXcVRANh2Oc2o=;
 b=elKIVgh89IGhCGwYdtMUBIYdReqDXyjQ5sS0c84RZgih9rJmxyjQQJ/MEwbq14abrp
 JBTwTOhR4kf+kJgLhKf6mmPR9c4Ps9yxQTu0P52utVpCMUE2R4FB9yGD0QW25FMJmPx2
 L0u1KuhDCNqfFrMGqzOFhZMGU1mohb9DKWPk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751150641; x=1751755441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANMxp71oZQrJ8GyPCotnNktmF1zSqEuXcVRANh2Oc2o=;
 b=JeNecogZ2W43yPysJ0nZrzI6rzAWOOlOZh+kHTIXCKta8gLbkD3yvloj0nxH4t8EGL
 YNPUaJvTou2qlZQCSVrrxqE0LqyTd3il26WRJkXh24ixtnWbq/uxNUz+fEDCqMKmoqxT
 PJPY2gyEjJAj68lGH8FwgkK3I/q/vibkrQkhXgVu87cqk9ekh039plUv00ozb4VrFrpE
 xwvfxQAvfLFpHINYIgyEAoIdKewiksAnfKqh6MBqILJ6ZcyBzODLog2h3t/frK0voumD
 AT4B3E6GYuzyHVzryq1/Hos/W/arB26Wj4YU5v75xsBnhfX6DJy0n6TwFyicBFh/PGbE
 GY9Q==
X-Gm-Message-State: AOJu0YwOLdMaktzq1KA1tbMS8VXDc819yEeQXeKSqINXYiFC9fISQm4Z
 tOV9iN+aLbZXKHAIv/uA7w1crXvJra20SFKBqd+4huRRnKAC1smDb1hV2Nt20aB5Q2Yhc0D8o/7
 QgOxA0JM=
X-Gm-Gg: ASbGncufbbNtI0zjuaVIBFxO5UGKW6UH8/8/mUZx7ibn1WREVTTGKJNtALV9pgsgKsz
 avUU+UybzPiNdRW9r+vgle6yN4t9Z7rqJ3b0ekooWn2IOanKgBrHsxsd7u++pHqBRdVxo4i8F1J
 sX9VVSwckx0P+qr4k/LmG8G6SnZPtWNfS/nvjjrH7FekLGf1l5tONPtJvzEF0w63RSnyLM80tCb
 SJHGMr5eda2zSDlj780Qjks4VqVWoL1OpJewX++L9NVWJRzyg+yR5rlO2SYT3qu7s2UT3G9K3uh
 Dw0sft03l/ZPzzy4exgqOVd8WrNU5pkbI6xvWyaKBbEkwuVYFPUv2an6w/eGYfICLrLXrf7WqJd
 ZPjISbE/4/D57joEOXjyZPwJDYQ==
X-Google-Smtp-Source: AGHT+IGLIxx0GgM/jnJRG3ikaCg/g2FX0BeXtnAV0gV2vPJp7D27qorls9/VtVtLeDVHH6TUWJbb1g==
X-Received: by 2002:a05:6808:2119:b0:406:6e89:49ba with SMTP id
 5614622812f47-40b33e6e4d4mr5697604b6e.33.1751150640680; 
 Sat, 28 Jun 2025 15:44:00 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b3243e4besm1013148b6e.50.2025.06.28.15.43.59
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 15:43:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 5/5] include/vsc9953.h: Audit include list
Date: Sat, 28 Jun 2025 16:43:52 -0600
Message-ID: <20250628224352.85694-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250628224352.85694-1-trini@konsulko.com>
References: <20250628224352.85694-1-trini@konsulko.com>
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

This file does not need <config.h> nor <miiphy.h> so remove them.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/vsc9953.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/vsc9953.h b/include/vsc9953.h
index fd52c93044b4..1a1455af4f97 100644
--- a/include/vsc9953.h
+++ b/include/vsc9953.h
@@ -8,8 +8,6 @@
 #ifndef _VSC9953_H_
 #define _VSC9953_H_
 
-#include <config.h>
-#include <miiphy.h>
 #include <asm/types.h>
 #include <linux/bitops.h>
 
-- 
2.43.0

