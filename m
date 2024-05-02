Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54501C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:35:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5544688C31;
	Thu,  2 May 2024 03:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PuAj6yAz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 788C688C49; Thu,  2 May 2024 03:32:21 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F162088C35
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-437610adf96so50128671cf.3
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613537; x=1715218337; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bdye7WJJKa7m7RMVwSItwz7Ajzy5AjY15+G66NXrb1c=;
 b=PuAj6yAzu/awPCke/i4yFewoIPKgXjP5Hb02o0M2BKo5JFvouztXmHTeG4R1gKXkX5
 gsidoWCTy1npGUcB+63mtGss43mGyOyFo4aDuNevDwY8ChR4CcA9PVx6Bvlz3sSYAMz5
 U2ZvEBObZzjrbS//D8IHUEG8pcUKUf4zVv5KM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613537; x=1715218337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bdye7WJJKa7m7RMVwSItwz7Ajzy5AjY15+G66NXrb1c=;
 b=mW34jAS8m/1lIyB+MxG8REFCfQsfUi7Z470avWwoO7mEVm+j/pO6fLIf3295ENAy9e
 m0VuVtrzt/EWN7pB5c13zASwxrsMdo/azQS3shin6/BdvKD8z+r9yqpZ0J+kpBKk/i+q
 TTQyFM2gJUNzF8zog/hMmlnHLWNDE4aLU0UWyOs4nVJxkxZBAzN35DwPtj1NlDLTuPgC
 3QhXr/cyTd7H2eXYsjdhccGu4G4Uj5pNQwt4hfVyjOC9Q91mNXdrvtuu6QeamlS6ZOMV
 0/Cg+5tHeTcKq3BPV4hxRt8SAjkawUk/lK4SDHjakVv/xD92sT+7PK/X8PJXSs3QXPUF
 mXAQ==
X-Gm-Message-State: AOJu0Yz7ofL8dWqXpHWwz3spw+gYyiyuWt/u1OvV5iWiq1IUgu2Sdem7
 HIWRgXtqX83h5cCNNyBRWDLGy7RIRhxFBhHEVYZnz+DX9dHHQFj76PFR5B3DNceUMUoeFNgP2UZ
 hbA8sIt0K
X-Google-Smtp-Source: AGHT+IEud5gtHqWorhTxTsNCO4JZ51G/paMf27l9migqyo+EQmS6daMlb9f6xns3NCKLB+XoGVUuLw==
X-Received: by 2002:a05:622a:1345:b0:43a:7bb9:c3dd with SMTP id
 w5-20020a05622a134500b0043a7bb9c3ddmr647490qtk.16.1714613537453; 
 Wed, 01 May 2024 18:32:17 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.16
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 24/81] demo: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:41 -0600
Message-Id: <20240502013138.2383421-24-trini@konsulko.com>
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
---
 drivers/demo/demo-pdata.c  | 1 -
 drivers/demo/demo-shape.c  | 1 -
 drivers/demo/demo-simple.c | 1 -
 drivers/demo/demo-uclass.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/demo/demo-pdata.c b/drivers/demo/demo-pdata.c
index 818f77503a31..73711991626b 100644
--- a/drivers/demo/demo-pdata.c
+++ b/drivers/demo/demo-pdata.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2013 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm-demo.h>
 
diff --git a/drivers/demo/demo-shape.c b/drivers/demo/demo-shape.c
index b6b29bcb31b3..3ccd5bced95e 100644
--- a/drivers/demo/demo-shape.c
+++ b/drivers/demo/demo-shape.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2013 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/drivers/demo/demo-simple.c b/drivers/demo/demo-simple.c
index 28b271f7791c..944d58972224 100644
--- a/drivers/demo/demo-simple.c
+++ b/drivers/demo/demo-simple.c
@@ -6,7 +6,6 @@
  * Pavel Herrmann <morpheus.ibis@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm-demo.h>
 #include <mapmem.h>
diff --git a/drivers/demo/demo-uclass.c b/drivers/demo/demo-uclass.c
index 09f9a47d4de6..d7b1305dc65d 100644
--- a/drivers/demo/demo-uclass.c
+++ b/drivers/demo/demo-uclass.c
@@ -6,7 +6,6 @@
  * Pavel Herrmann <morpheus.ibis@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm-demo.h>
 #include <errno.h>
-- 
2.34.1

