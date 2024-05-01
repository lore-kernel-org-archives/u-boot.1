Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B93C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ABCB88AB8;
	Wed,  1 May 2024 04:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L7usEc36";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B99EF88AB3; Wed,  1 May 2024 04:43:36 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A056388A7E
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-69b782287f9so30780666d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531413; x=1715136213; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eGJQkNFPnK3OufH8AmgzPNVFtv/f2fW/8kvcY22cfnc=;
 b=L7usEc36BGENF76RBMWBr44DCR50XQ6joMiqj6CbTgp731uSIXsnc7lNOb4DRW7Haz
 /yp6Vb35gSMlf70SzJ2C1vVC5KzzqjJS1z647XXXsRXbW+5OIjVmcD5ioi29Ss0ZokGl
 pmz9GVqgvr0r2yPo3KGSguxq9i8/Alh08g5pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531413; x=1715136213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eGJQkNFPnK3OufH8AmgzPNVFtv/f2fW/8kvcY22cfnc=;
 b=FbGwRW2cmd574vV45cFUiRivuF/IZNevSvnlbi57VqOHiV0M/c0ZZEryFebKi9nkQD
 crKx34j9l/iQkR4Caqtei0IK1k+S3G+/lMHQ067k1EvpLQ2NWRV9+C6JY+bR60CQdrsz
 vuprgGXhbNZFCqIHrE5ZsAC928mDQWhO8MEqcidkirAVJe8fu3UlHcb5Jsw2MNk95jVB
 09aIWHt9VE5sZDkn2l5dnVrDdUsPdX7Acy9yWXxQivf3JxRcT7jZJf3Oh7eoQqB2OM8Y
 37uiT+1ZGjNLcJrJFx5uM7imx4UMMSmv0nN+CUekJ+991fkkbqnbyuSJi5sDvFSg4zgl
 Y7DA==
X-Gm-Message-State: AOJu0YxzCvzMn0RhRDl12ua/nwW8hqwP6YH3YaL/YAG9MmJAWFjGK9qW
 Za0DTMGHzHjRRuAIpQMcdpOX4BoJlyFgCytxlP2FKQAZLpuZIRYbxLANzpl8GKWKwKAbdCG6zqw
 nG3CFcw==
X-Google-Smtp-Source: AGHT+IFwFILr57gMnme94sEtK9fkLq9LcHdjOMjAlMvG8ZLtR3iAV0JnhZALe84nCpOnZ5rbeUGh1g==
X-Received: by 2002:ad4:4ea2:0:b0:69b:7acd:2b94 with SMTP id
 ed2-20020ad44ea2000000b0069b7acd2b94mr1483061qvb.0.1714531413349; 
 Tue, 30 Apr 2024 19:43:33 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 014/149] board: alliedtelesis: Remove <common.h> and add
 needed includes
Date: Tue, 30 Apr 2024 20:41:01 -0600
Message-Id: <20240501024316.1767971-14-trini@konsulko.com>
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
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 board/alliedtelesis/SBx81LIFKW/sbx81lifkw.c     | 1 -
 board/alliedtelesis/SBx81LIFXCAT/sbx81lifxcat.c | 1 -
 board/alliedtelesis/common/gpio_hog.c           | 1 -
 board/alliedtelesis/x240/x240.c                 | 2 +-
 board/alliedtelesis/x530/x530.c                 | 2 +-
 5 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/board/alliedtelesis/SBx81LIFKW/sbx81lifkw.c b/board/alliedtelesis/SBx81LIFKW/sbx81lifkw.c
index e0a7f3fa89f0..5e6d6c6234fb 100644
--- a/board/alliedtelesis/SBx81LIFKW/sbx81lifkw.c
+++ b/board/alliedtelesis/SBx81LIFKW/sbx81lifkw.c
@@ -4,7 +4,6 @@
  * Allied Telesis <www.alliedtelesis.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <net.h>
 #include <asm/global_data.h>
diff --git a/board/alliedtelesis/SBx81LIFXCAT/sbx81lifxcat.c b/board/alliedtelesis/SBx81LIFXCAT/sbx81lifxcat.c
index 52b8eba92fc1..f30821c17963 100644
--- a/board/alliedtelesis/SBx81LIFXCAT/sbx81lifxcat.c
+++ b/board/alliedtelesis/SBx81LIFXCAT/sbx81lifxcat.c
@@ -4,7 +4,6 @@
  * Allied Telesis <www.alliedtelesis.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <miiphy.h>
 #include <net.h>
diff --git a/board/alliedtelesis/common/gpio_hog.c b/board/alliedtelesis/common/gpio_hog.c
index 4aecf7e2cef7..7da70fb4f7d6 100644
--- a/board/alliedtelesis/common/gpio_hog.c
+++ b/board/alliedtelesis/common/gpio_hog.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Allied Telesis Labs
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
diff --git a/board/alliedtelesis/x240/x240.c b/board/alliedtelesis/x240/x240.c
index 0c4f8e03b859..c1b7cc3b613c 100644
--- a/board/alliedtelesis/x240/x240.c
+++ b/board/alliedtelesis/x240/x240.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
+#include <config.h>
 #include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/alliedtelesis/x530/x530.c b/board/alliedtelesis/x530/x530.c
index 80ad62c2c665..65e6d48db0a6 100644
--- a/board/alliedtelesis/x530/x530.c
+++ b/board/alliedtelesis/x530/x530.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2017 Allied Telesis Labs
  */
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <dm.h>
 #include <env.h>
-- 
2.34.1

