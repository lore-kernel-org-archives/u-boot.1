Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7956EC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:36:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF95A88C7A;
	Thu,  2 May 2024 03:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XPtPvEYD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB3CF88BE0; Thu,  2 May 2024 03:32:36 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A972388BDF
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-de5b1e6beceso6966269276.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613553; x=1715218353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWd5qwfYo7kQLDko5t+EdpUdTgElX3YwnCclZvBRFL0=;
 b=XPtPvEYD6JGOhtJLlX4PNrsWL37oc2iZ6cZ+QEnsg01/5MSNgXQBSqVt4MuGHHbRVV
 VMoFtYc48KLMVXROm8g7V68oXf4PqX7sIJ7ihOuMf59c0NI1/EHhdg+kNkgeeycR3CjA
 YfPT98X/wgwSk0Po6JEyJkgUV1g8viwHRGnBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613553; x=1715218353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AWd5qwfYo7kQLDko5t+EdpUdTgElX3YwnCclZvBRFL0=;
 b=bgc3vJ2BZyGizb1TZOx8EMMsYUy7z5yc3IlcPvQoka7PJJWlFPMCRxWdDGxM91j0HO
 vtyb/vwyp82VXNXHRxr/tYKfcXBFi6KMJXChfPqQwOYgbcjKRKLuPfAwONZUq+nSnvyK
 Ou2K9QzUfjdsqgF3tyIYMaO95ejOz6nrQrdX+JMHFvw6Dv0HC3BnJahvXrahncMZvMpL
 hHdMbnw7yTnly5vvjMhJAsYElySBq88ER+rFI0pHWaqhtnERhhirWATFlpQd/sTaFogC
 KgYM6EoOvi4c26NP3xn/5udiSEl2l9Wkmgan2GzD/wXuvyXoJF8MvTQt2xyCtDIO/Rmg
 wUTQ==
X-Gm-Message-State: AOJu0Yz/NVsWlZeGHITgWuj+TAkcRLPHVS+lWpmtIK7zGR1EC2T2h9zl
 rvaV8rou0p6F2WC6TUrS6Qo6RGzOw748i37u0FP6IJ10iOYpSx+hcHv44iDZdLfzDPyklT/eSYf
 UGrEWHlJ0
X-Google-Smtp-Source: AGHT+IEj6EMVYtPVckWn+S7fjG+KzdzOsTB/RYr510RakA7vQxBZLHKxLffr2XNRGQ9AErQqmK0qeQ==
X-Received: by 2002:a25:b111:0:b0:de6:b58:fe72 with SMTP id
 g17-20020a25b111000000b00de60b58fe72mr607052ybj.58.1714613553359; 
 Wed, 01 May 2024 18:32:33 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 34/81] hwspinlock: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:51 -0600
Message-Id: <20240502013138.2383421-34-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/hwspinlock/hwspinlock-uclass.c  | 1 -
 drivers/hwspinlock/sandbox_hwspinlock.c | 1 -
 drivers/hwspinlock/stm32_hwspinlock.c   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/hwspinlock/hwspinlock-uclass.c b/drivers/hwspinlock/hwspinlock-uclass.c
index e9a4d7f9fbbd..ea93efc97df7 100644
--- a/drivers/hwspinlock/hwspinlock-uclass.c
+++ b/drivers/hwspinlock/hwspinlock-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_HWSPINLOCK
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <hwspinlock.h>
diff --git a/drivers/hwspinlock/sandbox_hwspinlock.c b/drivers/hwspinlock/sandbox_hwspinlock.c
index be920f5f99df..fcda55517e1e 100644
--- a/drivers/hwspinlock/sandbox_hwspinlock.c
+++ b/drivers/hwspinlock/sandbox_hwspinlock.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018, STMicroelectronics - All Rights Reserved
  */
 
-#include <common.h>
 #include <dm.h>
 #include <hwspinlock.h>
 #include <asm/state.h>
diff --git a/drivers/hwspinlock/stm32_hwspinlock.c b/drivers/hwspinlock/stm32_hwspinlock.c
index 346b138e98f0..5273b9bfed89 100644
--- a/drivers/hwspinlock/stm32_hwspinlock.c
+++ b/drivers/hwspinlock/stm32_hwspinlock.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_HWSPINLOCK
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <hwspinlock.h>
-- 
2.34.1

