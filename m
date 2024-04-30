Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081C5C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F35A788A49;
	Tue, 30 Apr 2024 15:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X+zKqHhC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85E1F88A35; Tue, 30 Apr 2024 15:36:21 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DBFB88A3E
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6a06b12027cso59949536d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484176; x=1715088976; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p3QPLsASfTlw6FqbkVwxNgnEdrFYsvoo2PUsXpgbzqM=;
 b=X+zKqHhC45pQG81+J4YhY4V27BNWn9ssHqqvafrAskdIOdryzp5EXKSYs1EFhZgdO+
 VUw2UUV2QnBMPxtVV3JCjwTUzZ0ntqnTXGv/KpxBELkV2YsUfXfa98sV2QBqGNfh5uln
 wbIZSPE2NMNU2zfztP+LF6lwrZf3fdH03LdMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484176; x=1715088976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p3QPLsASfTlw6FqbkVwxNgnEdrFYsvoo2PUsXpgbzqM=;
 b=ctgY4rhFiPt5Uq1nE+PZn0vpyS6SkeoR6XNyW7PqjZ1At7AgQpSHGrsYHobu014fkV
 lXEfx1K59/0VGNoxMemcBPBuWuPsanqbg7LyQ+eZ4YXxO23eNnZXESJUYpxUR7dz4KaR
 z7MWva0w8AMKET3KzfJrdlGdEfEzZYGY8LVKJDNTxI8nzqxVUNaOuflrXiVYzGHPKFgb
 Jmk4Vy2gl74uGfEVGlDy8DC6o5XyceyOxOMUSvCBS3AodeBjweMggMl358tIz+AHoHKO
 ovCnAPJt0W1XIkMTg0aNqwQXL8zhg1RWNtjIf92/U1gUKNIAKoyU88ZdnPIGvw62YLV6
 UaLg==
X-Gm-Message-State: AOJu0Yy6LB1ofRHyOkvShp520X3Jg/zoSpS2UREkKT+/AeGH/qwwmA8p
 TQe5VRi7hKk3F7aDcSSIzgKYdtPjFA0zg9t72/Y6aL5xoWYiPWMhH6W/FrtE4CeUin3Ck1xx5Mp
 220WU5g==
X-Google-Smtp-Source: AGHT+IHu0oaooQLt59eSNs9jMvZQgbtjptW5IRwtICqqCV82/ZKaSijFryLrNd0E6t28nl1TLrdbRw==
X-Received: by 2002:a05:6214:27e2:b0:6a0:e10e:9a0b with SMTP id
 jt2-20020a05621427e200b006a0e10e9a0bmr2312162qvb.26.1714484176083; 
 Tue, 30 Apr 2024 06:36:16 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.15
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 12/33] arm: orion5x: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:38 -0600
Message-Id: <20240430133559.1836389-12-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430133559.1836389-1-trini@konsulko.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
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

Remove <common.h> from all mach-orion5x files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-orion5x/cpu.c   | 1 -
 arch/arm/mach-orion5x/dram.c  | 1 -
 arch/arm/mach-orion5x/timer.c | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-orion5x/cpu.c b/arch/arm/mach-orion5x/cpu.c
index ffae9a01e37c..58ee67eca50f 100644
--- a/arch/arm/mach-orion5x/cpu.c
+++ b/arch/arm/mach-orion5x/cpu.c
@@ -8,7 +8,6 @@
  * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <net.h>
diff --git a/arch/arm/mach-orion5x/dram.c b/arch/arm/mach-orion5x/dram.c
index 5647f847d78f..228a3f7ad075 100644
--- a/arch/arm/mach-orion5x/dram.c
+++ b/arch/arm/mach-orion5x/dram.c
@@ -8,7 +8,6 @@
  * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
  */
 
-#include <common.h>
 #include <config.h>
 #include <init.h>
 #include <asm/arch/cpu.h>
diff --git a/arch/arm/mach-orion5x/timer.c b/arch/arm/mach-orion5x/timer.c
index b373e59e6fe3..85736f04e672 100644
--- a/arch/arm/mach-orion5x/timer.c
+++ b/arch/arm/mach-orion5x/timer.c
@@ -7,7 +7,7 @@
  * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <time.h>
 #include <asm/global_data.h>
-- 
2.34.1

