Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556E8C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0807188C79;
	Thu,  2 May 2024 03:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XzohG9m2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E5F088C10; Thu,  2 May 2024 03:32:42 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A480988C6C
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-43b06b803c4so19620661cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613558; x=1715218358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fj797Wdf7qoMrhHsiENSsexWU+mvSFFmuc2taP/UH0E=;
 b=XzohG9m2rrC/psw2jYYfyDH0GL66YX+GYzYAMIGrxGKwg3bC+KoQTDO02Oexawweu0
 6M/URuHkX9XDy626/9Ij5pTrp2JRHpZPfL/j9r+GeonOt9PRXu+MpI88HY4rzPnkhRFs
 98OB2VjZ9ANGyYmSG5guhiyqJigEDL4Nmt898=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613558; x=1715218358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fj797Wdf7qoMrhHsiENSsexWU+mvSFFmuc2taP/UH0E=;
 b=cCfmVuDDbmktl9u9xWepf8Xi85k7DXwIiWt0tFLGRpA78cMtmP2WDuGBTfL719HDcm
 deYvIByKdeeBlxsc66oRnAqoZqCYpDyi3tK5+8zxYlMrK2bWZRRlN6ip1cvn4t1g9Qqk
 Ttc+5qSWtkpApyQhDOvvZJqtTHtFqQ/7FJW6HbEkcefLMnM37nEgeDAy5dv5M9vkzOIG
 uss4ZnbOlcZ9tVx+0HHqZ0hH6CIj+7emKd202iEBsWTfmoTc00GHyNk7thE6K8Ay7aKx
 wj1rIww5utOkeaDZB9bbWte/Q6bQngl0Qf6dBgza7vLR3noTAkglW7veeMq6/WuzOvm+
 ThHg==
X-Gm-Message-State: AOJu0YxKKVPC07zO7NHBBfFOh4OQNYgoNhm1jrdhM0asrS2xCHHWSAE8
 D+1R5bR9ps1VY0wfQ1WId45KlaPJKTdQ+0qL/DCpj8FvNacNe1D2fesr2btlpBQnA4QjXxHjN1q
 yLnPTeif/
X-Google-Smtp-Source: AGHT+IE/oAYI+BDbYUIFM1rF2ifdo6qlrLH6G9zbxIhfkDDk/8Rm68J4KmLifWpRb5QVcL4VpdUjLA==
X-Received: by 2002:a05:622a:4cf:b0:439:f51a:2c1 with SMTP id
 q15-20020a05622a04cf00b00439f51a02c1mr4799496qtx.1.1714613558356; 
 Wed, 01 May 2024 18:32:38 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Mark Kettenis <kettenis@openbsd.org>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 37/81] iommu: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:54 -0600
Message-Id: <20240502013138.2383421-37-trini@konsulko.com>
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
Cc: Mark Kettenis <kettenis@openbsd.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/iommu/apple_dart.c    | 1 -
 drivers/iommu/iommu-uclass.c  | 1 -
 drivers/iommu/sandbox_iommu.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
index 6ecd84303bc2..9327dea1e3bb 100644
--- a/drivers/iommu/apple_dart.c
+++ b/drivers/iommu/apple_dart.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2021 Mark Kettenis <kettenis@openbsd.org>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <iommu.h>
diff --git a/drivers/iommu/iommu-uclass.c b/drivers/iommu/iommu-uclass.c
index dff3239cccb1..bb31cd519d25 100644
--- a/drivers/iommu/iommu-uclass.c
+++ b/drivers/iommu/iommu-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_IOMMU
 
-#include <common.h>
 #include <dm.h>
 #include <iommu.h>
 #include <malloc.h>
diff --git a/drivers/iommu/sandbox_iommu.c b/drivers/iommu/sandbox_iommu.c
index 6ceb7fd5ec37..e37976f86f02 100644
--- a/drivers/iommu/sandbox_iommu.c
+++ b/drivers/iommu/sandbox_iommu.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2021 Mark Kettenis <kettenis@openbsd.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <iommu.h>
 #include <lmb.h>
-- 
2.34.1

