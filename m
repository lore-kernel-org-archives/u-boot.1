Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53918C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8980B88BF5;
	Wed,  1 May 2024 04:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ad7vx5Wx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4068888BE9; Wed,  1 May 2024 04:45:04 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B38D88BEF
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6a071595d22so33894966d6.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531501; x=1715136301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ucNbnfVwtDWtAQEkoFRuBPmbcmErgY9THMySbiDjZI=;
 b=Ad7vx5WxfqJ8fj8dFUeaEBzI0RF6SLM7n5U7epWUhCDoZpw8f+VAEdP0UNnSsXlgkr
 VeFcM19cVrk6ATjSHJoC/7bZfUDrYyyNey7NcnH8vZM+wz7ss80pbIWsBNM/WyxJH4+s
 ilDUjBBpWCol4bPA918mBFcFcSqpuFoR8wwLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531501; x=1715136301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ucNbnfVwtDWtAQEkoFRuBPmbcmErgY9THMySbiDjZI=;
 b=msu9hwjm6THB9EHDI5YTM5KJDbSn1paAFJQv4PuXTMuIwRfDYLT/8qRMvhBrJaa13G
 LDWXQsTALRxNUsq1B0TXu8wb+i/LZgpMof3HZUCf7/0Nu1IIiOnVSbwwA8lthpp5s5fv
 aTWqTc9ZrbO75O8luV5WUDY2+U7v0UJ4PKLIAou+dDEKKcEevMRYG+2RLVEMw0hBP+pD
 L5LRTVjf2A6hDpHqJe0NBi+3NLEy2NBpllsxmsCSONs7m2CJ5JHPOGgVAM4E26gGnu8X
 QdPQBqNw4jA4WK0C5T2LfOrJrwG2GUT/IQbDPL3pBtujXr0/1dDMjbfJmS7uukIIHCfG
 xbgA==
X-Gm-Message-State: AOJu0YyD3Lp491n9nwqS0rhDt6Sovw6PsPJR7NUQLo/3BKkfiOmzv9gO
 NtH1rgm6wuKJZUioeessEAbCO3ADVL3ImFjyvHYJy5Prf+sASKdIXXP0RKjxDnVyJvD8ZkwvpLh
 NNcnSkNMz
X-Google-Smtp-Source: AGHT+IGvA0PqJGiuz830gW3cy1bJx7i4hTRnvaqyYqnantbIXIRmDN/e782rb1PF+A0DKtxq2GNIOg==
X-Received: by 2002:a05:6214:3002:b0:6a0:aac9:c4a8 with SMTP id
 ke2-20020a056214300200b006a0aac9c4a8mr1000467qvb.28.1714531500879; 
 Tue, 30 Apr 2024 19:45:00 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Sam Shih <sam.shih@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Fabien Parent <fparent@baylibre.com>,
 Mingming lee <mingming.lee@mediatek.com>
Subject: [PATCH 088/149] board: mediatek: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:15 -0600
Message-Id: <20240501024316.1767971-88-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Sam Shih <sam.shih@mediatek.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Fabien Parent <fparent@baylibre.com>
Cc: Mingming lee <mingming.lee@mediatek.com>
---
 board/mediatek/mt7622/mt7622_rfb.c     | 1 -
 board/mediatek/mt7623/mt7623_rfb.c     | 2 +-
 board/mediatek/mt7629/mt7629_rfb.c     | 2 +-
 board/mediatek/mt8183/mt8183_pumpkin.c | 1 -
 board/mediatek/mt8512/mt8512.c         | 1 -
 board/mediatek/mt8516/mt8516_pumpkin.c | 1 -
 board/mediatek/mt8518/mt8518_ap1.c     | 2 +-
 7 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/board/mediatek/mt7622/mt7622_rfb.c b/board/mediatek/mt7622/mt7622_rfb.c
index 2cc73bc35dca..e7f492a13bc3 100644
--- a/board/mediatek/mt7622/mt7622_rfb.c
+++ b/board/mediatek/mt7622/mt7622_rfb.c
@@ -4,7 +4,6 @@
  * Author: Sam Shih <sam.shih@mediatek.com>
  */
 
-#include <common.h>
 #include <config.h>
 #include <env.h>
 #include <init.h>
diff --git a/board/mediatek/mt7623/mt7623_rfb.c b/board/mediatek/mt7623/mt7623_rfb.c
index ec10f77c51e4..c78eaa072439 100644
--- a/board/mediatek/mt7623/mt7623_rfb.c
+++ b/board/mediatek/mt7623/mt7623_rfb.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2018 MediaTek Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <mmc.h>
 #include <asm/global_data.h>
 
diff --git a/board/mediatek/mt7629/mt7629_rfb.c b/board/mediatek/mt7629/mt7629_rfb.c
index 55f7696c5107..02719181624c 100644
--- a/board/mediatek/mt7629/mt7629_rfb.c
+++ b/board/mediatek/mt7629/mt7629_rfb.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2018 MediaTek Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/mediatek/mt8183/mt8183_pumpkin.c b/board/mediatek/mt8183/mt8183_pumpkin.c
index db613ebdc4f4..1b8736966f61 100644
--- a/board/mediatek/mt8183/mt8183_pumpkin.c
+++ b/board/mediatek/mt8183/mt8183_pumpkin.c
@@ -4,7 +4,6 @@
  * Author: Fabien Parent <fparent@baylibre.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <net.h>
 
diff --git a/board/mediatek/mt8512/mt8512.c b/board/mediatek/mt8512/mt8512.c
index ac3adb801222..d2f557ffee5f 100644
--- a/board/mediatek/mt8512/mt8512.c
+++ b/board/mediatek/mt8512/mt8512.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2019 MediaTek Inc.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <wdt.h>
diff --git a/board/mediatek/mt8516/mt8516_pumpkin.c b/board/mediatek/mt8516/mt8516_pumpkin.c
index 42f3863b92c3..930bfec34836 100644
--- a/board/mediatek/mt8516/mt8516_pumpkin.c
+++ b/board/mediatek/mt8516/mt8516_pumpkin.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2019 BayLibre SAS
  */
 
-#include <common.h>
 #include <dm.h>
 #include <net.h>
 
diff --git a/board/mediatek/mt8518/mt8518_ap1.c b/board/mediatek/mt8518/mt8518_ap1.c
index e03da63b1d92..745cfda2ddf0 100644
--- a/board/mediatek/mt8518/mt8518_ap1.c
+++ b/board/mediatek/mt8518/mt8518_ap1.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2019 MediaTek Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <init.h>
 #include <log.h>
-- 
2.34.1

