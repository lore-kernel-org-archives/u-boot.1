Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98A3C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 705D588C1F;
	Thu,  2 May 2024 03:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ouxAwBaS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D29B88C10; Thu,  2 May 2024 03:32:08 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 446CF88C2A
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-43ca9047bd2so2676651cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613525; x=1715218325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ik0J8pT3yhOVNee5JyCCI0V9HqlaWvvGa4WWDpeT1pc=;
 b=ouxAwBaSuruSDifT5NJ2r6e8KQpoJU/WFWagNUb7bAbRozHEeD7lwZUY0CIbWdHVbU
 jvaOw8bFKj3O3pMcg2TlhrPX5gBJOU3NnGTE2jFP0BljkR1zfGeKYKbPMdAhskz1p9n9
 12Vg3oasV/IoYOiqfuRMvynuWb5mLcK+bMD6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613525; x=1715218325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ik0J8pT3yhOVNee5JyCCI0V9HqlaWvvGa4WWDpeT1pc=;
 b=DKkYZ9SAcUkaaaD1u0R6N+7SFcTYOUDb+K/KKlv3/5CmjXYkDA0V7HLF/R12wguHir
 2p5c3VLU+NlXbtxshR3nwWVxq1PMDVibcIwmOEL3lRyk4az8ay82ddXXyCswx+6e5sae
 6gpc4/7OS0Yg99RW1WhZGQbi2y1xShNlrjZYsaepe2vJnTd3jZM5QKb0Vwf7Aj5xstIe
 tpr/UCMhernHn+1vqRTfQBrToZhJzm0uTci1lkIlkllJZJssCsq+QwgmF9k+fq2KIUx9
 m9/3MLncBnsuTWnAsqIKwMWTBx2i1eXULk9GOG8mZZB5g9rDoIwo689YNXvq0jHURcyP
 MHYg==
X-Gm-Message-State: AOJu0YzNJx0HA0Dwcg7OPlGV4OEKp/70smWYcwazToSuDz6+LJKc6aSV
 PB4ay+I9Qgw9RUkN5B2ceEk6cwT3DoV/8CngfbBNWYLDCPGXdapfPLmeqAEaZaja2r42kaXe7T9
 yTHkRJ3s0
X-Google-Smtp-Source: AGHT+IHTU4a9HEo1zYTiwgYseYHjeUtJ3BkzYvHYpH+PyhSwrIXkoOX+Kvrd2Qye4YrG665307Q6RQ==
X-Received: by 2002:a05:622a:5e8b:b0:43a:7b64:2fcc with SMTP id
 er11-20020a05622a5e8b00b0043a7b642fccmr2569320qtb.7.1714613524885; 
 Wed, 01 May 2024 18:32:04 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH 18/81] cache: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:35 -0600
Message-Id: <20240502013138.2383421-18-trini@konsulko.com>
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
Cc: Johan Jonker <jbx6244@gmail.com>
---
 drivers/cache/cache-l2x0.c          | 1 -
 drivers/cache/cache-sifive-ccache.c | 1 -
 drivers/cache/cache-uclass.c        | 1 -
 drivers/cache/cache-v5l2.c          | 1 -
 drivers/cache/sandbox_cache.c       | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/cache/cache-l2x0.c b/drivers/cache/cache-l2x0.c
index 560f4c94f1ef..c7bdd9d064a5 100644
--- a/drivers/cache/cache-l2x0.c
+++ b/drivers/cache/cache-l2x0.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2019 Intel Corporation <www.intel.com>
  */
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 
diff --git a/drivers/cache/cache-sifive-ccache.c b/drivers/cache/cache-sifive-ccache.c
index 521df40466f9..cc00b80f60b8 100644
--- a/drivers/cache/cache-sifive-ccache.c
+++ b/drivers/cache/cache-sifive-ccache.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2021 SiFive
  */
 
-#include <common.h>
 #include <cache.h>
 #include <dm.h>
 #include <asm/io.h>
diff --git a/drivers/cache/cache-uclass.c b/drivers/cache/cache-uclass.c
index 0c13dbdb75c4..300e7bc86e1a 100644
--- a/drivers/cache/cache-uclass.c
+++ b/drivers/cache/cache-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_CACHE
 
-#include <common.h>
 #include <cache.h>
 #include <dm.h>
 
diff --git a/drivers/cache/cache-v5l2.c b/drivers/cache/cache-v5l2.c
index fe3f9392b2ca..f0b8ecc88079 100644
--- a/drivers/cache/cache-v5l2.c
+++ b/drivers/cache/cache-v5l2.c
@@ -4,7 +4,6 @@
  * Rick Chen, Andes Technology Corporation <rick@andestech.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <cache.h>
 #include <dm.h>
diff --git a/drivers/cache/sandbox_cache.c b/drivers/cache/sandbox_cache.c
index 955dfc8a0f84..2e20b83ab803 100644
--- a/drivers/cache/sandbox_cache.c
+++ b/drivers/cache/sandbox_cache.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2019 Intel Corporation <www.intel.com>
  */
 
-#include <common.h>
 #include <cache.h>
 #include <dm.h>
 #include <errno.h>
-- 
2.34.1

