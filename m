Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6007C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:33:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E70D288BE5;
	Thu,  2 May 2024 03:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="knycY6Z8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF6988BF7; Thu,  2 May 2024 03:31:59 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A9588BFD
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-439dfa27003so42996051cf.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613515; x=1715218315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MQ5d5c8m7+zzaH2O7R2U4zPn4t0zZT5CQZpZZhpEijs=;
 b=knycY6Z88viliCgh5ankQ6lnPLh7EEYdQnJaDS+o1tARJFQFYU+aZYPfZD0CzqJTy+
 16X/MpoVR805vHetwH1ytLU71qnmht6daLcJPM8NdgCr1b3OcLaMLc3X9DB0CZQ+rZqf
 HQOu3MuIbBLPC/AMXrJoifWczJIEviD2VRD7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613515; x=1715218315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MQ5d5c8m7+zzaH2O7R2U4zPn4t0zZT5CQZpZZhpEijs=;
 b=sI9eXapemxV2OQ7AwcCLdlIpWN0zgMT5xrMYvtc4i/baTE7RXNNJ+bFvEtyXX6GNlj
 ITh5dBBiou4VKp7p34R5VslO/jSf9RfHfQ43B05va+oSmcP9dhjLJgfano8VV+Y9cg8z
 PfZtO2SDEv7FmRcS5kuoBwl2j9wXzX9RhENSMvK8Md2UO0SFZHq8yzuHTCMjkdOxJRMj
 Ym1jq7nJf+gIJ6ULzc/Fi1pAA1DCjq2gKMvtyZOcN+rbPJTnLTIO5ZuqrwOtfe+WJyez
 qyolf2km+/FVSF0zSDotdTfXg9C+M6Vg14kEs8GTkk1U1azLNhu+wr0RaqFgFB9PBrbP
 nivg==
X-Gm-Message-State: AOJu0YzD7QdXsS6AvgK+xaMCtPbgFZ1kFiFAEU5wPCoEGMZ5LEh6Z9B9
 bFzWLf3v8JirlhY6Mqyq6M1OZ7iyLNDzzNmdfhqDmFZM85Oc5XTrmqARmONYk+irochRBZ1hsRZ
 C77gJ/eAH
X-Google-Smtp-Source: AGHT+IHmkc7om1I3HDZycDKkwSRwKyWN4wqqU9wiQy/gBhJlyI1nN8gn8GCeTY1D6QHSC8E79Vpl8g==
X-Received: by 2002:a05:622a:4cf:b0:43a:befb:dcdb with SMTP id
 q15-20020a05622a04cf00b0043abefbdcdbmr4594012qtx.5.1714613515677; 
 Wed, 01 May 2024 18:31:55 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:31:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 12/81] axi: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:29 -0600
Message-Id: <20240502013138.2383421-12-trini@konsulko.com>
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
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 drivers/axi/axi-emul-uclass.c | 1 -
 drivers/axi/axi-uclass.c      | 1 -
 drivers/axi/axi_sandbox.c     | 1 -
 drivers/axi/ihs_axi.c         | 1 -
 drivers/axi/sandbox_store.c   | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/axi/axi-emul-uclass.c b/drivers/axi/axi-emul-uclass.c
index e6f3ef072005..bea0b040738c 100644
--- a/drivers/axi/axi-emul-uclass.c
+++ b/drivers/axi/axi-emul-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_AXI_EMUL
 
-#include <common.h>
 #include <axi.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/axi/axi-uclass.c b/drivers/axi/axi-uclass.c
index 41551ae85c9c..fa2475cbaf4e 100644
--- a/drivers/axi/axi-uclass.c
+++ b/drivers/axi/axi-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_AXI
 
-#include <common.h>
 #include <dm.h>
 #include <axi.h>
 
diff --git a/drivers/axi/axi_sandbox.c b/drivers/axi/axi_sandbox.c
index b91c91f6b3b6..6f698a405f92 100644
--- a/drivers/axi/axi_sandbox.c
+++ b/drivers/axi/axi_sandbox.c
@@ -4,7 +4,6 @@
  * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
  */
 
-#include <common.h>
 #include <axi.h>
 #include <dm.h>
 #include <asm/axi.h>
diff --git a/drivers/axi/ihs_axi.c b/drivers/axi/ihs_axi.c
index a7e9761fbfc2..a37dd1e17867 100644
--- a/drivers/axi/ihs_axi.c
+++ b/drivers/axi/ihs_axi.c
@@ -7,7 +7,6 @@
  * Mario Six,  Guntermann & Drunck GmbH, mario.six@gdsys.cc
  */
 
-#include <common.h>
 #include <axi.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/axi/sandbox_store.c b/drivers/axi/sandbox_store.c
index ef349a50b798..b9413c758f7b 100644
--- a/drivers/axi/sandbox_store.c
+++ b/drivers/axi/sandbox_store.c
@@ -4,7 +4,6 @@
  * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
  */
 
-#include <common.h>
 #include <axi.h>
 #include <dm.h>
 #include <log.h>
-- 
2.34.1

