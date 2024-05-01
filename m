Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C20C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:08:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 359CE88CA8;
	Wed,  1 May 2024 04:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EloM4zxs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64F8888C83; Wed,  1 May 2024 04:45:52 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EB3288CA3
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-43a8246b51dso31228381cf.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531548; x=1715136348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I14eLCQebxeKUIQfqoNcQl/+pmDAAt/bind115IDjuQ=;
 b=EloM4zxsJlKee1Ejcoi1OQYqahFbaXuCBKgrUcHVaMIZoHxg0rG/ZSVP3tYefaIc/T
 7M6gB+aphwd+87Jtg1W22NmYBuc84ilz8VgOBUtBP/VMtuwIq9teOx/quK4SOa3yC4KK
 PkMnQq+UzdFxqNyNR7tImyMtIkAB2ubEQQ3HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531548; x=1715136348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I14eLCQebxeKUIQfqoNcQl/+pmDAAt/bind115IDjuQ=;
 b=Z8WF+lrYZSDj4YipNfOsl/FxT+W+sonBOFNmwWPb3O3m010nakO6K/eKnMuxObQcvI
 PH70uTiFnvFdX5zOET8AVCUp96UWu1j6I6KfaM2Q5+29ql7I5BuHAP5YGvB95RW+7exS
 ucNyft22FhMK9Ftph7vEyM0wykpBdoho1knxRugl5be4+/jKmc3fF1QWP63jS2QaJbEN
 SgmyHBTbMdIrcngut/HCtM1I4tbskrZ9hXQ6DYqq8Jc+VzpJxzUuCJO6fVEKwCpVN975
 4f7XecUuhZAV25mThGvXm8gwmJXEumO2reLGdE15JvTss+EJEpjCGUgyj4vKJqIEOrky
 jqlg==
X-Gm-Message-State: AOJu0YzZR5hFMTdhsBuKvdSX96J+mHcXZDlINDDFuVh3YKAtH8BcJneS
 Hy+Xy7UXxIDFCpcyySwc3oH45X4UbSvWgvu7D/tobkqMUAbz2kxW8tix43d9kyLAj0ycy3PysRO
 vqiSIt1Si
X-Google-Smtp-Source: AGHT+IFbPSVAlcftZU0nmNnyzxoOsAx1/gopn0RVt7TyxnExG5WZmy8IGF0g+z6ESie9sqh9dE4QVA==
X-Received: by 2002:a05:6214:ca4:b0:6a0:cd68:901e with SMTP id
 s4-20020a0562140ca400b006a0cd68901emr1567454qvs.45.1714531548002; 
 Tue, 30 Apr 2024 19:45:48 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>, Richard Hu <richard.hu@technexion.com>,
 Otavio Salvador <otavio@ossystems.com.br>, Marek Vasut <marex@denx.de>
Subject: [PATCH 131/149] board: technexion: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:58 -0600
Message-Id: <20240501024316.1767971-131-trini@konsulko.com>
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
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Richard Hu <richard.hu@technexion.com>
Cc: Otavio Salvador <otavio@ossystems.com.br>
Cc: Marek Vasut <marex@denx.de>
---
 board/technexion/pico-imx6/pico-imx6.c           | 1 -
 board/technexion/pico-imx6/spl.c                 | 1 -
 board/technexion/pico-imx6ul/pico-imx6ul.c       | 1 -
 board/technexion/pico-imx6ul/spl.c               | 1 -
 board/technexion/pico-imx7d/pico-imx7d.c         | 1 -
 board/technexion/pico-imx7d/spl.c                | 2 +-
 board/technexion/pico-imx8mq/lpddr4_timing_1gb.c | 1 -
 board/technexion/pico-imx8mq/lpddr4_timing_2gb.c | 1 -
 board/technexion/pico-imx8mq/lpddr4_timing_3gb.c | 1 -
 board/technexion/pico-imx8mq/lpddr4_timing_4gb.c | 1 -
 board/technexion/pico-imx8mq/pico-imx8mq.c       | 1 -
 board/technexion/pico-imx8mq/spl.c               | 1 -
 12 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/board/technexion/pico-imx6/pico-imx6.c b/board/technexion/pico-imx6/pico-imx6.c
index 6b9c4f4373cc..03170b148c52 100644
--- a/board/technexion/pico-imx6/pico-imx6.c
+++ b/board/technexion/pico-imx6/pico-imx6.c
@@ -6,7 +6,6 @@
  * Author: Fabio Estevam <festevam@gmail.com>
  */
 
-#include <common.h>
 #include <env.h>
 #include <init.h>
 #include <net.h>
diff --git a/board/technexion/pico-imx6/spl.c b/board/technexion/pico-imx6/spl.c
index 3b36bb8df131..50f517742647 100644
--- a/board/technexion/pico-imx6/spl.c
+++ b/board/technexion/pico-imx6/spl.c
@@ -6,7 +6,6 @@
  *	   Fabio Estevam <festevam@gmail.com>
  */
 
-#include <common.h>
 #include <image.h>
 #include <init.h>
 #include <asm/arch/clock.h>
diff --git a/board/technexion/pico-imx6ul/pico-imx6ul.c b/board/technexion/pico-imx6ul/pico-imx6ul.c
index 682c88dee78d..10dcf8077e20 100644
--- a/board/technexion/pico-imx6ul/pico-imx6ul.c
+++ b/board/technexion/pico-imx6ul/pico-imx6ul.c
@@ -17,7 +17,6 @@
 #include <asm/gpio.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/io.h>
-#include <common.h>
 #include <miiphy.h>
 #include <linux/delay.h>
 #include <linux/sizes.h>
diff --git a/board/technexion/pico-imx6ul/spl.c b/board/technexion/pico-imx6ul/spl.c
index ff56fd88d68e..67484e62dad6 100644
--- a/board/technexion/pico-imx6ul/spl.c
+++ b/board/technexion/pico-imx6ul/spl.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <cpu_func.h>
 #include <hang.h>
 #include <init.h>
diff --git a/board/technexion/pico-imx7d/pico-imx7d.c b/board/technexion/pico-imx7d/pico-imx7d.c
index b12941ccf82d..d0f739c624a1 100644
--- a/board/technexion/pico-imx7d/pico-imx7d.c
+++ b/board/technexion/pico-imx7d/pico-imx7d.c
@@ -15,7 +15,6 @@
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/io.h>
-#include <common.h>
 #include <miiphy.h>
 #include <power/pmic.h>
 #include <power/pfuze3000_pmic.h>
diff --git a/board/technexion/pico-imx7d/spl.c b/board/technexion/pico-imx7d/spl.c
index 0192eafbaa14..8f219f76c603 100644
--- a/board/technexion/pico-imx7d/spl.c
+++ b/board/technexion/pico-imx7d/spl.c
@@ -5,7 +5,7 @@
  * Author: Richard Hu <richard.hu@technexion.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <asm/arch/clock.h>
diff --git a/board/technexion/pico-imx8mq/lpddr4_timing_1gb.c b/board/technexion/pico-imx8mq/lpddr4_timing_1gb.c
index 97b9ee27527a..cd8ba59f6454 100644
--- a/board/technexion/pico-imx8mq/lpddr4_timing_1gb.c
+++ b/board/technexion/pico-imx8mq/lpddr4_timing_1gb.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/kernel.h>
-#include <common.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/lpddr4_define.h>
 
diff --git a/board/technexion/pico-imx8mq/lpddr4_timing_2gb.c b/board/technexion/pico-imx8mq/lpddr4_timing_2gb.c
index 1572a50a05f8..3f66238a5044 100644
--- a/board/technexion/pico-imx8mq/lpddr4_timing_2gb.c
+++ b/board/technexion/pico-imx8mq/lpddr4_timing_2gb.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/kernel.h>
-#include <common.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/lpddr4_define.h>
 
diff --git a/board/technexion/pico-imx8mq/lpddr4_timing_3gb.c b/board/technexion/pico-imx8mq/lpddr4_timing_3gb.c
index 3fc60a3eeb98..2f037abc97dd 100644
--- a/board/technexion/pico-imx8mq/lpddr4_timing_3gb.c
+++ b/board/technexion/pico-imx8mq/lpddr4_timing_3gb.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/kernel.h>
-#include <common.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/lpddr4_define.h>
 
diff --git a/board/technexion/pico-imx8mq/lpddr4_timing_4gb.c b/board/technexion/pico-imx8mq/lpddr4_timing_4gb.c
index 93b342351628..336ac4c2f548 100644
--- a/board/technexion/pico-imx8mq/lpddr4_timing_4gb.c
+++ b/board/technexion/pico-imx8mq/lpddr4_timing_4gb.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/kernel.h>
-#include <common.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/lpddr4_define.h>
 
diff --git a/board/technexion/pico-imx8mq/pico-imx8mq.c b/board/technexion/pico-imx8mq/pico-imx8mq.c
index 2be3206f78a3..1659db112fa1 100644
--- a/board/technexion/pico-imx8mq/pico-imx8mq.c
+++ b/board/technexion/pico-imx8mq/pico-imx8mq.c
@@ -3,7 +3,6 @@
  * Copyright 2018 NXP
  */
 
-#include <common.h>
 #include <env.h>
 #include <init.h>
 #include <malloc.h>
diff --git a/board/technexion/pico-imx8mq/spl.c b/board/technexion/pico-imx8mq/spl.c
index 1a9c7996cb2a..c9d68b402aeb 100644
--- a/board/technexion/pico-imx8mq/spl.c
+++ b/board/technexion/pico-imx8mq/spl.c
@@ -3,7 +3,6 @@
  * Copyright 2018 NXP
  */
 
-#include <common.h>
 #include <hang.h>
 #include <init.h>
 #include <log.h>
-- 
2.34.1

