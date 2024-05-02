Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDFDC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C68AE88C88;
	Thu,  2 May 2024 03:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hyTZO0A4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB6788C81; Thu,  2 May 2024 03:33:06 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7DC688C64
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-43b06b803c4so19622231cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613583; x=1715218383; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNF+0uOIu0RRjhStl6msntYK4KTs1KHBau3cKUwrA1o=;
 b=hyTZO0A4HHgaVNisQDFejPjuXFTcvMPnc1uZm2ecwQhw8G85808wGw/0mDYxuRDTfe
 Hq6+ZIcq/pBNAq3Wt56dXDwMk8VhlnGowhTFISCnm0aLHZUHZXaneC27KJZVVoWYv5JN
 HdCXVFMhn1I5o/2EjGVlB2JNYjJ3gazDIToLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613583; x=1715218383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNF+0uOIu0RRjhStl6msntYK4KTs1KHBau3cKUwrA1o=;
 b=xOCSNC9knSJAnQhyQv85SgcdC1K9zHZtrkXxrVgqszxdFebBWhVVacBqcUhtQvwndd
 Y56Q/b4geM8tQLtG2Mke11nMc4MJjSK2xwwFyS4dTX9pDkOTFYi9xCqqJIWINRdellkS
 qyiYYGJ0w8KlcGwOz8aBRLY4a3IjnBpc49rXRmdTI+HLbC8X/YpeMbN2T9K3pH6eh+zO
 p4JkBR+SW5r3VWYDIquZgDlzQNf2RIS2+XWGLbG0wbcuIN8gBxgAqooMBgsBleiKTnbv
 mu51spmqnuFyrE+HnV7cavG9tGFz4ahsRNOJUguRyQJyZSpvjkoaSwiyApsgi6wtq69p
 AWGw==
X-Gm-Message-State: AOJu0Yx/JAbPycqKzL6fMy4M6BgGk1R8HfC1zWod4b/mWNbLZf4xwKET
 DYMvrYbyAD/17QAlPi4w5rBuLsTDpnVXBaLFwHsg3YTBRhy1EbXeqPAIGKc6I/Wjdd7xFwM3tYQ
 mAIh4ncs+
X-Google-Smtp-Source: AGHT+IFk9N9qiz1I6nfr6oIW1AiA7W+mkJun8BNS/aMBkFcsZX52V/9Qaefo2DpmqKsG5z8jz4SlJQ==
X-Received: by 2002:a05:622a:190d:b0:43b:dd9:18a3 with SMTP id
 w13-20020a05622a190d00b0043b0dd918a3mr5124465qtc.52.1714613583592; 
 Wed, 01 May 2024 18:33:03 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH 46/81] nvme: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:03 -0600
Message-Id: <20240502013138.2383421-46-trini@konsulko.com>
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
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <kettenis@openbsd.org>
---
 drivers/nvme/nvme-uclass.c | 1 -
 drivers/nvme/nvme.c        | 1 -
 drivers/nvme/nvme_apple.c  | 1 -
 drivers/nvme/nvme_pci.c    | 1 -
 drivers/nvme/nvme_show.c   | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/nvme/nvme-uclass.c b/drivers/nvme/nvme-uclass.c
index f3af6a27b63b..44c88ad27f3e 100644
--- a/drivers/nvme/nvme-uclass.c
+++ b/drivers/nvme/nvme-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_NVME
 
-#include <common.h>
 #include <bootdev.h>
 #include <dm.h>
 #include <init.h>
diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index 59a139baa0ba..7c58ceb78f51 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2017 Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <blk.h>
 #include <bootdev.h>
 #include <cpu_func.h>
diff --git a/drivers/nvme/nvme_apple.c b/drivers/nvme/nvme_apple.c
index 819b748dc02e..7e7538553e3f 100644
--- a/drivers/nvme/nvme_apple.c
+++ b/drivers/nvme/nvme_apple.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2021 Mark Kettenis <kettenis@openbsd.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <mailbox.h>
 #include <mapmem.h>
diff --git a/drivers/nvme/nvme_pci.c b/drivers/nvme/nvme_pci.c
index 5bb43d299fca..c24f8cf1eb1f 100644
--- a/drivers/nvme/nvme_pci.c
+++ b/drivers/nvme/nvme_pci.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2017 Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <pci.h>
diff --git a/drivers/nvme/nvme_show.c b/drivers/nvme/nvme_show.c
index 72cbac82bcca..158102363e99 100644
--- a/drivers/nvme/nvme_show.c
+++ b/drivers/nvme/nvme_show.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2017 Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <memalign.h>
-- 
2.34.1

