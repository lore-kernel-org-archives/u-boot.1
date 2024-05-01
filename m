Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FCFC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17BC488BD4;
	Wed,  1 May 2024 04:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KbEZzhuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9000088B7B; Wed,  1 May 2024 04:44:52 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DC5288B7B
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-69b10ead8f5so33943716d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531489; x=1715136289; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5mUHJPXPoRaJIdJCeCP12kKOFktWf3cGFMMA8TvHrgw=;
 b=KbEZzhuXI+ydJWzeoFf+pRAjxjrHpbBP+26sucFXE4Jx8lYMungETPPxXPM8eFu+8U
 2gz2zVuWKME2kyH9H4eAYGch8IkQ0+4oUW0rOWLkrp/fmit171wf99gUDRvUv69K9MtI
 LUKMt6FadGX1LrH3EWM8LR33mLg1c6wJ1Mi78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531489; x=1715136289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5mUHJPXPoRaJIdJCeCP12kKOFktWf3cGFMMA8TvHrgw=;
 b=HTUpjQXfL/K5hfeNoHPlenSAhi7ZXsvUBLnmVJna5CCFAvTQabM6r76svVPgQWSNzb
 mKFToXkMnySPcoCx8iwqUwP6VYKv2EGevK3YwSiATutYXuZCx+qZx+21LHkT3d2XJ8P/
 Y2iBMHYbB6rGUQwKsPHQfwg6KyklbPvwM4/Zf92C5F/oCZ/P3tQd26JxB63P5wWIdiVD
 ypG5CMCA24/69EV76ch0amWYvYJ5QAWndaWfHXprOn8HqzfZ0kVdTQevZosNZE73nCuM
 EsptYnXobLnltBxO9Z3plP0am9iJHJfD4g7cGXXNPTYLkXn+sQuXwBliOQ3cHv0of/hU
 29og==
X-Gm-Message-State: AOJu0YzqDVmuWeePO3VTz8V2/aYmQQ5/qrgZ0o9Z2VFoY4hl2iLq7jcm
 bn7GCZj7cHQGsqLgX2iaD/LVq09y8M/4vFrYR6dfuEbt02I1hRchZe+0VSOgiWQYupOuAsG6RIP
 tcbsRQw==
X-Google-Smtp-Source: AGHT+IFQJaQpNRbTIeZmDikHT1vaeHuZ67GPTv31VHnuHDISTJRvBA81j4RkNVeoVnz+I+C4bM4CGA==
X-Received: by 2002:a05:6214:3002:b0:6a0:aac9:c4a8 with SMTP id
 ke2-20020a056214300200b006a0aac9c4a8mr1000221qvb.28.1714531489244; 
 Tue, 30 Apr 2024 19:44:49 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 077/149] board: k+p: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:42:04 -0600
Message-Id: <20240501024316.1767971-77-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Lukasz Majewski <lukma@denx.de>
---
 board/k+p/kp_imx53/kp_id_rev.c            | 2 +-
 board/k+p/kp_imx53/kp_imx53.c             | 1 -
 board/k+p/kp_imx6q_tpc/kp_imx6q_tpc.c     | 1 -
 board/k+p/kp_imx6q_tpc/kp_imx6q_tpc_spl.c | 1 -
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/board/k+p/kp_imx53/kp_id_rev.c b/board/k+p/kp_imx53/kp_id_rev.c
index 9f93cf008ce8..cbfe94e25a28 100644
--- a/board/k+p/kp_imx53/kp_id_rev.c
+++ b/board/k+p/kp_imx53/kp_id_rev.c
@@ -9,11 +9,11 @@
  * Daniel Gericke <daniel.gericke@tqs.de>
  */
 
-#include <common.h>
 #include <env.h>
 #include <i2c.h>
 #include "kp_id_rev.h"
 #include <net.h>
+#include <vsprintf.h>
 
 static int eeprom_has_been_read;
 static struct id_eeprom eeprom;
diff --git a/board/k+p/kp_imx53/kp_imx53.c b/board/k+p/kp_imx53/kp_imx53.c
index 7c3a695cb258..efb7b49cbe08 100644
--- a/board/k+p/kp_imx53/kp_imx53.c
+++ b/board/k+p/kp_imx53/kp_imx53.c
@@ -4,7 +4,6 @@
  * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/board/k+p/kp_imx6q_tpc/kp_imx6q_tpc.c b/board/k+p/kp_imx6q_tpc/kp_imx6q_tpc.c
index e6877e4c0703..e0895194300a 100644
--- a/board/k+p/kp_imx6q_tpc/kp_imx6q_tpc.c
+++ b/board/k+p/kp_imx6q_tpc/kp_imx6q_tpc.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Lukasz Majewski <lukma@denx.de>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/crm_regs.h>
diff --git a/board/k+p/kp_imx6q_tpc/kp_imx6q_tpc_spl.c b/board/k+p/kp_imx6q_tpc/kp_imx6q_tpc_spl.c
index 54902437940b..6a5e252751d4 100644
--- a/board/k+p/kp_imx6q_tpc/kp_imx6q_tpc_spl.c
+++ b/board/k+p/kp_imx6q_tpc/kp_imx6q_tpc_spl.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Lukasz Majewski <lukma@denx.de>
  */
 
-#include <common.h>
 #include <init.h>
 #include <log.h>
 #include <asm/arch/clock.h>
-- 
2.34.1

