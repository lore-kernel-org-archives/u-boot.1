Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36D0C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 685ED88CCB;
	Thu,  2 May 2024 03:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GusbRkq5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CEEC88CCB; Thu,  2 May 2024 03:33:46 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED4E688CB7
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-437a660c94fso46505281cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613621; x=1715218421; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y62xmUD+VvtmBpGPzEiDDDx+BDsiIxQ0U5RAYnHmdj8=;
 b=GusbRkq5fDMKn6x6BQBjAXykmXZaNZalgeA2iRdzEketZsdsdzwkE3HzFeZRKFiv4H
 eITNnVXJDKI2+YUwVkOvX1BPRCJ0UGzmeG+gnLtdLpa3yfz59P22szz7tsIt649kkogO
 lSkRnlr3LnZczTO2RKJnB+24fFJLH8azCUaow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613621; x=1715218421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y62xmUD+VvtmBpGPzEiDDDx+BDsiIxQ0U5RAYnHmdj8=;
 b=JOoysuAhu33dbrhbI9zjqSJ3pPF9ftydm6wWaKch9R7REoRfQftpl80eWebc4Po/FS
 FocaCqmlYnLO86ZxIsrbNnJ4d/t1fZZq9FgrA+lShYOhOaGh79RrGWsKKdHPI7z2XEtY
 jByO6+Ogjs1j1CwRGirDNmwHTB5CqQMuWGOeDxI4CwHZLbDsZSNSh2WpNIKAQd5x9GeR
 97eYHqRaT0YmCqhFTnUeNhuyG5xXHHOhtVqhzAsN0kQT2IUL+gJ87e97A/t/Rh13vFCL
 HtQsMOcIdjTQokf9f8Vqzbk2gT3OLx1IrmZJE7ucXEkw/LErtTz/pcsn/SRGehNeZuQw
 XHOA==
X-Gm-Message-State: AOJu0YzffjY/B/N8PynlmErZX0KECDBLXVqMcJiAsb7/5gmJ4We10Vxq
 WSI0di3YGylaWpE8axkn3lQhCqPFuwp0Blke8erL+EKVxNK8fqXhkybi+w2gd065Kx5t1TR3pdk
 kX9U0aURw
X-Google-Smtp-Source: AGHT+IHBix6UvBmAvCM0pTVKAT1/rres0MnTIqbC+OlamKhE4ZaaUqAkXs4ofYNz/8lXgqJZkPqHgg==
X-Received: by 2002:a05:622a:3d1:b0:43a:e59e:5c9a with SMTP id
 k17-20020a05622a03d100b0043ae59e5c9amr675263qtx.43.1714613621269; 
 Wed, 01 May 2024 18:33:41 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH 61/81] sm: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:18 -0600
Message-Id: <20240502013138.2383421-61-trini@konsulko.com>
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
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/sm/meson-sm.c   | 1 -
 drivers/sm/sandbox-sm.c | 1 -
 drivers/sm/sm-uclass.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/sm/meson-sm.c b/drivers/sm/meson-sm.c
index 15b3b0e2672f..87eba1486db3 100644
--- a/drivers/sm/meson-sm.c
+++ b/drivers/sm/meson-sm.c
@@ -5,7 +5,6 @@
  * Author: Alexey Romanov <avromanov@salutedevices.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <regmap.h>
 #include <sm.h>
diff --git a/drivers/sm/sandbox-sm.c b/drivers/sm/sandbox-sm.c
index 109ddb2af557..a95e685494c2 100644
--- a/drivers/sm/sandbox-sm.c
+++ b/drivers/sm/sandbox-sm.c
@@ -5,7 +5,6 @@
  * Author: Alexey Romanov <avromanov@salutedevices.com>
  */
 
-#include <common.h>
 #include <sm.h>
 #include <sm-uclass.h>
 #include <sandbox-sm.h>
diff --git a/drivers/sm/sm-uclass.c b/drivers/sm/sm-uclass.c
index 6a8b70262937..abca0052e293 100644
--- a/drivers/sm/sm-uclass.c
+++ b/drivers/sm/sm-uclass.c
@@ -5,7 +5,6 @@
  * Author: Alexey Romanov <avromanov@salutedevices.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <sm-uclass.h>
-- 
2.34.1

