Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03637C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:40:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4577788CE2;
	Thu,  2 May 2024 03:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XfTgjtz3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58A9488CC5; Thu,  2 May 2024 03:33:55 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F23688CD8
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-43a8246b51dso38297451cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613631; x=1715218431; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCkr6vR++u/plngZSMPCSl4IhmlG5pBg5sUr0KfhqQo=;
 b=XfTgjtz3sravKHYKEDKLxjRVGsS5yl0A5ULgblH6e1Bvma9RARUiJddELiOBb8DwHU
 B81aR/BP7GXhUj605sMiesEaE4w1pDEN+a68HRHpNeYuCg16RKB2MdoJFDmvblbWar9Q
 B5W/ZLq+gGqCBWYiAbIqQORJnkjjbWSaEMtW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613631; x=1715218431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SCkr6vR++u/plngZSMPCSl4IhmlG5pBg5sUr0KfhqQo=;
 b=tMMez2sFPYhghGQruMKc34KTn/0Qs2lRmnh5KsjAuz9LWUiAsFsN2dnln2ORacCihp
 fjZ0ba8fnY1m4cs5BHzvfcVZGflWd1gOvGHWb3Hl/x8BpfnqfR6KWK/x1dVVXTJ3sppF
 ftggVCtD4c9I5QuWH4uBaDTqx9Qrddec6qCez3OoQhJ+WrQlJs2dsTRMQELUOxhS9ciJ
 /+K0k05IL3mYXgu2qAf9zmy9KPcq/SxnrVqoRnwE7rrv1hOV0g5ubQ/R4HXFEdI7Y4mb
 4163by1OG2y0OA04bVoBa++AG53SbCKUbKwpXtXL9GLzy0pqd3efIYpNSe3rNu/e4GCK
 mjhQ==
X-Gm-Message-State: AOJu0YxXocNfrzykNvoreFm2Zjxrt5Du0qPn3sJV+ApxR/TwUzD8cS38
 NP32ik+c8qGhd0Iv6hVIDlS4YrMlwPmOhE325ci7qdZDL+neeKVAp90ftRTiMuCyDJyVBq45fLd
 u1KjANA/u
X-Google-Smtp-Source: AGHT+IEQAEKmI71q85TcX6DQ2L+8epVksujFxTQozVIazFmB5XtOS4Pc6J7nRNLDnLwtDXaMm+Fd/A==
X-Received: by 2002:a05:622a:13cf:b0:43a:fd38:5390 with SMTP id
 p15-20020a05622a13cf00b0043afd385390mr658440qtk.64.1714613630806; 
 Wed, 01 May 2024 18:33:50 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 66/81] spmi: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:23 -0600
Message-Id: <20240502013138.2383421-66-trini@konsulko.com>
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
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
---
 drivers/spmi/spmi-msm.c     | 1 -
 drivers/spmi/spmi-sandbox.c | 1 -
 drivers/spmi/spmi-uclass.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index 244de69b3590..b0d6226041e5 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -7,7 +7,6 @@
  * Loosely based on Little Kernel driver
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/drivers/spmi/spmi-sandbox.c b/drivers/spmi/spmi-sandbox.c
index f6772946bca3..992b08dd6120 100644
--- a/drivers/spmi/spmi-sandbox.c
+++ b/drivers/spmi/spmi-sandbox.c
@@ -7,7 +7,6 @@
  * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <spmi/spmi.h>
diff --git a/drivers/spmi/spmi-uclass.c b/drivers/spmi/spmi-uclass.c
index 9d9f46a37d83..34fe8f6644c3 100644
--- a/drivers/spmi/spmi-uclass.c
+++ b/drivers/spmi/spmi-uclass.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY UCLASS_SPMI
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <spmi/spmi.h>
-- 
2.34.1

