Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830B3C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:05:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C443688C72;
	Wed,  1 May 2024 04:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ju0vJCke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5CB488C10; Wed,  1 May 2024 04:45:29 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2F2D88771
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-78edc3e80e6so498615585a.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531526; x=1715136326; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ji2qhvpjbo8t6PeEJ+wC3aH/pRxVt+wIw0wBnUtsg40=;
 b=ju0vJCkeuJHk6pSxXDgiXK6bNC95YDHdToi1tM7Gz3kad4hgoUtglMAmRrUgbwEctC
 ysQPzVNIT8pZ1gwXE0llItAA208hXaZQ+ePW/QJFF5DcwwyGCd8HFV4gOIG/wo8ADBxH
 wphDHXaNK/ioE3xUGg3ZbtgS9Fzxr8+juphfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531526; x=1715136326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ji2qhvpjbo8t6PeEJ+wC3aH/pRxVt+wIw0wBnUtsg40=;
 b=W6lKLNsTo3nJ/75mmVvyqDfSRKZ89TJkvv38GVmBbRzzHeCoGRY1PESTWfJ/r/BR+E
 ovmBbWkYo9njt3id0KCXtLg20NISi4cfpSaeAPGSADlno343KXZqigl6tfagpeaO68jL
 brcmjTU/IF37tlgIhkmYPXoGb+sl6aECVUM+pILBzlM4N2wEIjShv63WOxu9SENhSJMi
 /LItvNk5w/hM16IicmX/Al+dtB3VeIOVbaKJN8GECC7G8TkBjmapJMshgKvdXvbfwblM
 YTUBZycxiR/kGRVw5V0Je8lRZbc1iTPgc/0+yzAt+zR1ugABpVLx3MY+3HlkhN0OTqDq
 TzXQ==
X-Gm-Message-State: AOJu0Ywb2R/5InfgC8p079AbCfJwGEAKRvn+Z0lZx5xAh3ZZkPIyFQP3
 picQaoSodg94A54ek3+5+Yt6LkEZQfIExovDddLWwaP52NCW3dZmZx2WjNOmXpzWhn+r5F/AaI4
 QVRqNg2HR
X-Google-Smtp-Source: AGHT+IGnI/Fse+HkKZfZKyNw4ThrPzohjm5kpwvSclsFMkuRMHgTYG/LAXfs0xuPeK2HNFGyVQdt4g==
X-Received: by 2002:ad4:5b83:0:b0:6a0:e2ca:1e69 with SMTP id
 3-20020ad45b83000000b006a0e2ca1e69mr1170048qvp.29.1714531526448; 
 Tue, 30 Apr 2024 19:45:26 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ilko Iliev <iliev@ronetix.com>
Subject: [PATCH 112/149] board: ronetix: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:39 -0600
Message-Id: <20240501024316.1767971-112-trini@konsulko.com>
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
Cc: Ilko Iliev <iliev@ronetix.com>
---
 board/ronetix/imx7-cm/imx7-cm.c         | 1 -
 board/ronetix/imx7-cm/spl.c             | 1 -
 board/ronetix/imx8mq-cm/imx8mq_cm.c     | 1 -
 board/ronetix/imx8mq-cm/lpddr4_timing.c | 1 -
 board/ronetix/imx8mq-cm/spl.c           | 2 +-
 board/ronetix/pm9261/pm9261.c           | 2 +-
 board/ronetix/pm9263/pm9263.c           | 2 +-
 board/ronetix/pm9g45/pm9g45.c           | 2 +-
 8 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/board/ronetix/imx7-cm/imx7-cm.c b/board/ronetix/imx7-cm/imx7-cm.c
index c23097f04769..a1f3f3cd7972 100644
--- a/board/ronetix/imx7-cm/imx7-cm.c
+++ b/board/ronetix/imx7-cm/imx7-cm.c
@@ -15,7 +15,6 @@
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/mach-imx/mxc_i2c.h>
 #include <asm/io.h>
-#include <common.h>
 #include <i2c.h>
 #include <miiphy.h>
 #include <power/pmic.h>
diff --git a/board/ronetix/imx7-cm/spl.c b/board/ronetix/imx7-cm/spl.c
index b94cfd6ffc67..136de3cf3ef2 100644
--- a/board/ronetix/imx7-cm/spl.c
+++ b/board/ronetix/imx7-cm/spl.c
@@ -5,7 +5,6 @@
  * Author: Ilko Iliev <iliev@ronetix.at>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <asm/arch/clock.h>
diff --git a/board/ronetix/imx8mq-cm/imx8mq_cm.c b/board/ronetix/imx8mq-cm/imx8mq_cm.c
index 9805a3a7da8c..fbee2c39771e 100644
--- a/board/ronetix/imx8mq-cm/imx8mq_cm.c
+++ b/board/ronetix/imx8mq-cm/imx8mq_cm.c
@@ -3,7 +3,6 @@
  * Copyright 2018 NXP
  */
 
-#include <common.h>
 #include <miiphy.h>
 #include <asm-generic/gpio.h>
 #include <asm/arch/imx8mq_pins.h>
diff --git a/board/ronetix/imx8mq-cm/lpddr4_timing.c b/board/ronetix/imx8mq-cm/lpddr4_timing.c
index 685600ee62f5..a7ad9375ce37 100644
--- a/board/ronetix/imx8mq-cm/lpddr4_timing.c
+++ b/board/ronetix/imx8mq-cm/lpddr4_timing.c
@@ -4,7 +4,6 @@
  */
 
 #include <linux/kernel.h>
-#include <common.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/lpddr4_define.h>
 
diff --git a/board/ronetix/imx8mq-cm/spl.c b/board/ronetix/imx8mq-cm/spl.c
index 1c675bcab25a..ee0ad20ced4f 100644
--- a/board/ronetix/imx8mq-cm/spl.c
+++ b/board/ronetix/imx8mq-cm/spl.c
@@ -4,7 +4,7 @@
  *
  */
 
-#include <common.h>
+#include <config.h>
 #include <hang.h>
 #include <init.h>
 #include <asm/arch/ddr.h>
diff --git a/board/ronetix/pm9261/pm9261.c b/board/ronetix/pm9261/pm9261.c
index 07febe69dc7c..ee578749bce7 100644
--- a/board/ronetix/pm9261/pm9261.c
+++ b/board/ronetix/pm9261/pm9261.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2009 Jean-Christopher PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <vsprintf.h>
 #include <asm/global_data.h>
diff --git a/board/ronetix/pm9263/pm9263.c b/board/ronetix/pm9263/pm9263.c
index 76f62ddde912..1de1bd687016 100644
--- a/board/ronetix/pm9263/pm9263.c
+++ b/board/ronetix/pm9263/pm9263.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2009 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <linux/sizes.h>
diff --git a/board/ronetix/pm9g45/pm9g45.c b/board/ronetix/pm9g45/pm9g45.c
index aa5c80ac6417..5d5edd9f2530 100644
--- a/board/ronetix/pm9g45/pm9g45.c
+++ b/board/ronetix/pm9g45/pm9g45.c
@@ -10,7 +10,7 @@
  * Lead Tech Design <www.leadtechdesign.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <linux/sizes.h>
-- 
2.34.1

