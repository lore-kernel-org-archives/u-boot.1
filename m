Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB0CC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B2588CB9;
	Thu,  2 May 2024 03:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wfyu7KiY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 662ED88CA8; Thu,  2 May 2024 03:33:39 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E08B88C64
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-43ab2b2f11bso12484931cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613616; x=1715218416; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FUpJVS/nTfFVwLk2eMVu5wDUSB1t5Q6T1XaDLdHf5c0=;
 b=Wfyu7KiYFnZqsRHf7fL3UW9oVwTuJzl0M6VSh0Yo1lwdmZ6ArYrHu3yY7MLS/XCO4K
 xVu9xI68l6IGBygIpuDHvqHChY2Tt8YY/1baqfdQWJaNpq/PYeRRWPq0kT8Xf5BCMcji
 d4MM/H2W0Wb8BxZqrMwVxoTtUoPF8pPx+Sbjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613616; x=1715218416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FUpJVS/nTfFVwLk2eMVu5wDUSB1t5Q6T1XaDLdHf5c0=;
 b=DHFl7cTscLmQFPo+7CCVUaiOG5jZMBbwa2Lb50b5mUre4Mg7jgh1DuJevzer2jUw15
 buDAtCny8xGmL7oTjAI/OsFqnDYMfQCGBqPSUdSx1A6w5MU32DW+YJEcEjXQBlWG90jz
 FeTnOBYYA73czQCzZICeNb0t26kZGQ+a6inOlJsG7+WuLhZ1jN42mta4KwvvyvNpZUqM
 t4vMGE3b61ddM5pRt3qoQOaNPr8pGixtMMUPCCkr0a/oahdBV7IWL289Ykwp2dFgZztS
 tnCFCdimihQbz7eXr61p2rzgZBtFOhKUpye23IkG1m1IgXoM+QfCgdudWUMPxz5LMQqs
 +g5g==
X-Gm-Message-State: AOJu0YyS8KBbdxtqDV2U0WvsRM5Zn2w10x8osKouXABS07YsXksGRPtO
 +gsgAEb5bd/r2Ql27aBjniKLSJ5zrru0likPrYlJnRnvrkOfcN/QsfLHW5VfKMy5rqNeZ5vFyC8
 yX9FoxKnB
X-Google-Smtp-Source: AGHT+IHY8yEWw5Zs05YzmgOUju8F9JyUH6qVQio8oe32/nT8ChwWOVFw5qCtMmzF9dcpclvQ5FU31Q==
X-Received: by 2002:ac8:5dc9:0:b0:43a:daca:f300 with SMTP id
 e9-20020ac85dc9000000b0043adacaf300mr4575495qtx.24.1714613615862; 
 Wed, 01 May 2024 18:33:35 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 Kever Yang <kever.yang@rock-chips.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 59/81] scsi: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:16 -0600
Message-Id: <20240502013138.2383421-59-trini@konsulko.com>
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
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 drivers/scsi/sandbox_scsi.c | 1 -
 drivers/scsi/scsi-uclass.c  | 1 -
 drivers/scsi/scsi.c         | 1 -
 drivers/scsi/scsi_bootdev.c | 1 -
 drivers/scsi/scsi_emul.c    | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/scsi/sandbox_scsi.c b/drivers/scsi/sandbox_scsi.c
index a7ac33cb1c4b..544a0247083d 100644
--- a/drivers/scsi/sandbox_scsi.c
+++ b/drivers/scsi/sandbox_scsi.c
@@ -9,7 +9,6 @@
 
 #define LOG_CATEGORY UCLASS_SCSI
 
-#include <common.h>
 #include <dm.h>
 #include <os.h>
 #include <malloc.h>
diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
index a7c1eaf0cf50..1ee8236c05c8 100644
--- a/drivers/scsi/scsi-uclass.c
+++ b/drivers/scsi/scsi-uclass.c
@@ -10,7 +10,6 @@
 
 #define LOG_CATEGORY UCLASS_SCSI
 
-#include <common.h>
 #include <dm.h>
 #include <scsi.h>
 
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 79ee400d12f0..73cb83548eb8 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY	UCLASS_SCSI
 
-#include <common.h>
 #include <blk.h>
 #include <bootdev.h>
 #include <bootstage.h>
diff --git a/drivers/scsi/scsi_bootdev.c b/drivers/scsi/scsi_bootdev.c
index 218221fa3062..28e4612f337c 100644
--- a/drivers/scsi/scsi_bootdev.c
+++ b/drivers/scsi/scsi_bootdev.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <bootdev.h>
 #include <dm.h>
 #include <init.h>
diff --git a/drivers/scsi/scsi_emul.c b/drivers/scsi/scsi_emul.c
index 6b8468f79947..d1bb926b713a 100644
--- a/drivers/scsi/scsi_emul.c
+++ b/drivers/scsi/scsi_emul.c
@@ -11,7 +11,6 @@
 
 #define LOG_CATEGORY UCLASS_SCSI
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <scsi.h>
-- 
2.34.1

