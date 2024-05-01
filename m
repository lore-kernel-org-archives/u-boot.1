Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F3BC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E28888BF4;
	Wed,  1 May 2024 04:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hakKPjt5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 713D188BF0; Wed,  1 May 2024 04:45:06 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D9CD88BF6
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6a06b12027cso4382546d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531502; x=1715136302; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P324uclVL421syXUXLOKzGxt6dJ904yI+6z7ONcyxEY=;
 b=hakKPjt5O/gpKcQJLEGUIVCZ0VqUqRbf2Ra3nivJR4vZRO/EEIik26S84vGVRu3sGr
 pX9PsomIkYbjP4u0fznBam/HZSWo1Ny/zeMXPYcSgUqa8X2O3c0o2poR8/FtJDREqN+Y
 fQ/csOn8kzxZd/SzLT63RCkNRP2pf5XDEHOPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531502; x=1715136302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P324uclVL421syXUXLOKzGxt6dJ904yI+6z7ONcyxEY=;
 b=MYhRoX2bn6XuXVUPL+NWe77UxhAGMS/7YJF0L2OCswOtOVagDVqf8P4qqNzLH+lmES
 pdgyOlJ/G2bf4Pe5L4eoeyorXTNd3/e9Oo3QA8u//EB2jZ20N203teJDSSLQOEYHIVM/
 YYvZoWy0zMvoF4aGVI4+l5xXTH/nv9DgLe6T3Xk5YhM7VN0+qDTRMYbeRztZcmX48Mvm
 VPifK31cFWPtOE2r2H+37HuUjueBqQK/ap2CbK/ycceC3DvZ/WhFJHVwXT2HSjMbmxoR
 ACDZNKKcc5Qyijo/KeViw+bBqHSnk/68wrto8AiCh2+Rw1pd9O9IUcXLau4pJ8FbyM6w
 b6dw==
X-Gm-Message-State: AOJu0Yy1LMpC3voLuQOFUgO7z1FXtBTumBxsNfftqQK/ul3+OdfSq1YE
 DddRtJbTXB9MSocj2dBJUdhV9JmOpe4eT2Sl4TbQY0mP4hT4bXAkkZqqm4sBsoYz2b8JSKCqL/b
 oPbjUVRyz
X-Google-Smtp-Source: AGHT+IFayEVps1vXiwHfitpMQ3PtHBIUFLo2SIAsgHLolS79/SodlKvfhKmmokdbGl8pxt8hxDD0Yw==
X-Received: by 2002:ad4:5c42:0:b0:6a0:def5:8281 with SMTP id
 a2-20020ad45c42000000b006a0def58281mr1117601qva.11.1714531501811; 
 Tue, 30 Apr 2024 19:45:01 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
	Olaf Mandel <o.mandel@menlosystems.com>
Subject: [PATCH 089/149] board: menlo: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:16 -0600
Message-Id: <20240501024316.1767971-89-trini@konsulko.com>
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
Cc: Marek Vasut <marex@denx.de>
Cc: Olaf Mandel <o.mandel@menlosystems.com>
---
 board/menlo/m53menlo/m53menlo.c | 1 -
 board/menlo/mx8menlo/mx8menlo.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/menlo/m53menlo/m53menlo.c b/board/menlo/m53menlo/m53menlo.c
index b8dffb0e4858..79351f472731 100644
--- a/board/menlo/m53menlo/m53menlo.c
+++ b/board/menlo/m53menlo/m53menlo.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2014-2017 Olaf Mandel <o.mandel@menlosystems.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <malloc.h>
diff --git a/board/menlo/mx8menlo/mx8menlo.c b/board/menlo/mx8menlo/mx8menlo.c
index 18f5fd5c5ee9..f47b45c1d560 100644
--- a/board/menlo/mx8menlo/mx8menlo.c
+++ b/board/menlo/mx8menlo/mx8menlo.c
@@ -3,7 +3,6 @@
  * Copyright 2021-2022 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx8mm_pins.h>
 #include <asm/arch/sys_proto.h>
-- 
2.34.1

