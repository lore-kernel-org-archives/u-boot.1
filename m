Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12ABCC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED0C288C82;
	Thu,  2 May 2024 03:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tAm8DdRV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A690F88C81; Thu,  2 May 2024 03:32:45 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F06988C10
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4347cbdb952so34877441cf.3
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613562; x=1715218362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akGxRe8Wp/IJSstJvunyKAbf0Ra++7brB1yE0JQYQWk=;
 b=tAm8DdRVkaEcWLUKNhLpo1tM0X8nT1ue0g+P9OnCUDUJ8M8ofbLuGjAo2yDND4NIPV
 sEzjijsUT/SIH1/4zVKcrrGA5LOYHaOGG9qWLH+9Xg3OuSmC6VSuzE/F3W+cpkox7j8P
 6eaCAimkRT9OZYJ6CgjJxxS1tN2B8naih37Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613562; x=1715218362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=akGxRe8Wp/IJSstJvunyKAbf0Ra++7brB1yE0JQYQWk=;
 b=ORexucDvfSjknR+9fNj8JNeLk16Ql1k5cQunSiM9N2J9mr0hy2XEaqTn3/BhAllEAO
 0uR9r81y5/brutlh9/wtar3fEuIjO2cjLuHnTZChEB71lNy9BK8rg/466ndK6mz8xWmA
 WNq1De9GgWUqf7qCiy6nZxEYsJ1foQnYuiIXIXJ7HbWLSobV6RIxOCJZK4avrqZxL4p4
 4XIzW7tfFAsYwvtNjQcVifNamr00VRUmsJP5sQCjLtfjwFNaUiGS1RmcFO16M9xty9QY
 OAIbNmdQNQXM2lspQr7jMhc9bz/Hhp6Ld4r63MMLkDSgxJCD1hDm7Gj0nzPUVnAKKKWo
 dOcg==
X-Gm-Message-State: AOJu0Yyvm8YvffNfUFmoLMe3GVagqMvVJXLhtFzr4hR8EERCSPYPd4EH
 FRcB2o6/JAa31eKa7N/beLZ8PLPVz1z8zMv1CnKccZkD3uFn7TeGj1bCMLqSJb/WiMs0w0LKSg8
 uCqqbhKaU
X-Google-Smtp-Source: AGHT+IHTY55CykpVV1YUZ/4YUbXJge+51mPZukuLQ8xgjCJuyk18HSJ5eQM/2lvEFEHB903ifYY3Zg==
X-Received: by 2002:a05:622a:349:b0:43a:bd5b:2c9a with SMTP id
 r9-20020a05622a034900b0043abd5b2c9amr5110166qtw.57.1714613562049; 
 Wed, 01 May 2024 18:32:42 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 39/81] mailbox: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:56 -0600
Message-Id: <20240502013138.2383421-39-trini@konsulko.com>
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
Cc: Thierry Reding <treding@nvidia.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/mailbox/apple-mbox.c        | 1 -
 drivers/mailbox/k3-sec-proxy.c      | 1 -
 drivers/mailbox/mailbox-uclass.c    | 1 -
 drivers/mailbox/sandbox-mbox-test.c | 1 -
 drivers/mailbox/sandbox-mbox.c      | 1 -
 drivers/mailbox/stm32-ipcc.c        | 1 -
 drivers/mailbox/tegra-hsp.c         | 1 -
 drivers/mailbox/zynqmp-ipi.c        | 1 -
 8 files changed, 8 deletions(-)

diff --git a/drivers/mailbox/apple-mbox.c b/drivers/mailbox/apple-mbox.c
index 30c8e2f03fa8..2ee49734f406 100644
--- a/drivers/mailbox/apple-mbox.c
+++ b/drivers/mailbox/apple-mbox.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2021 Mark Kettenis <kettenis@openbsd.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <mailbox-uclass.h>
 #include <asm/io.h>
diff --git a/drivers/mailbox/k3-sec-proxy.c b/drivers/mailbox/k3-sec-proxy.c
index 05f6b1795d64..5eafe46fd4d0 100644
--- a/drivers/mailbox/k3-sec-proxy.c
+++ b/drivers/mailbox/k3-sec-proxy.c
@@ -6,7 +6,6 @@
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <asm/global_data.h>
diff --git a/drivers/mailbox/mailbox-uclass.c b/drivers/mailbox/mailbox-uclass.c
index 85ba8c5fd99d..4bf4987ce0a1 100644
--- a/drivers/mailbox/mailbox-uclass.c
+++ b/drivers/mailbox/mailbox-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_MAILBOX
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <mailbox.h>
diff --git a/drivers/mailbox/sandbox-mbox-test.c b/drivers/mailbox/sandbox-mbox-test.c
index ffd4674d1ef7..a2cfde2f62d6 100644
--- a/drivers/mailbox/sandbox-mbox-test.c
+++ b/drivers/mailbox/sandbox-mbox-test.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016, NVIDIA CORPORATION.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <mailbox.h>
 #include <malloc.h>
diff --git a/drivers/mailbox/sandbox-mbox.c b/drivers/mailbox/sandbox-mbox.c
index 87d38de0cb61..87e06e492fe7 100644
--- a/drivers/mailbox/sandbox-mbox.c
+++ b/drivers/mailbox/sandbox-mbox.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016, NVIDIA CORPORATION.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <mailbox-uclass.h>
diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index 046e1a8aca6e..dda108735fce 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_MAILBOX
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index 08c51c40f141..bfd4d7cdf2e4 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016, NVIDIA CORPORATION.
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <asm/io.h>
diff --git a/drivers/mailbox/zynqmp-ipi.c b/drivers/mailbox/zynqmp-ipi.c
index eb86847bbe23..4df69734ed95 100644
--- a/drivers/mailbox/zynqmp-ipi.c
+++ b/drivers/mailbox/zynqmp-ipi.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2018-2019 Xilinx, Inc.
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/system.h>
-- 
2.34.1

