Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A98C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17EA088B7E;
	Wed,  1 May 2024 04:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SPklDRae";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72BC988B75; Wed,  1 May 2024 04:44:29 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D060E88B68
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-69b50b8239fso3767536d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531465; x=1715136265; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IziJa3CwJJS0XRvlJMrdiy6k7/ZgD2JLAKhe2Bg45gw=;
 b=SPklDRaebBpGW+NCIXC+IKJvQdYI6vPIatfYR3Q7iiQ5AGcI5bbz3Its47RUc/NrnL
 HMqr81nmHTnhod1lzP4hFf8YIQHzP9HjwtAYcN+q0xjFOM1xj/X8t+PKQQcxC50aWSCv
 vqPIbxiJ6IjbPslkII1eJVNuDMbXhB+UhLIu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531465; x=1715136265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IziJa3CwJJS0XRvlJMrdiy6k7/ZgD2JLAKhe2Bg45gw=;
 b=GICQJVLzrVut4aZFBxoQxdpM891B7QqMwmSkFzaj4ZHX/ha//enUwcWm5ZnCWHGZXi
 sxABBdE31L0rshCnhPdIxKArcTA9a5X7fFD7uwvq72/6HVlHsVKiK1UV5FaI/B8ebuPy
 q6SPuDZE2KPGpjm0Wz1LpwIzUcSpLEH+fjC1/3zEsqekIxVQuhFDy6+rGfGgNIviNAzF
 lsV8lEwz5ujmAWXcIsGPgPm7sb9Y0ylhWR/WdBoETRVz32nZC5tK0r0yuw1gxBDdQh4v
 sAvNviIn+T4QT3aS/P+/hHGZ681CXFAg115uPl81UdTTHYXLRBlhnG89XU7pkNffjXbW
 NOMw==
X-Gm-Message-State: AOJu0YyadQ3NSJONkj8ztbd8TMpOsy3c/NE1nEjIGK91RdiKwxcwJfq+
 YLdx6DiuoYAbE93LIodyhVFRGWpkG3zsG4eKBvjFdiEhtQxnSTgHo9Vu4bPAfHLmmcEKmh3aj6P
 yp6wtAw==
X-Google-Smtp-Source: AGHT+IG8gEC+n9QljZquFPA+udK105tMZQa0ItH6roq9KcdcOxf9NYMlvBe9g1iPiV6NU5R6lJSAYQ==
X-Received: by 2002:a05:6214:2507:b0:699:2527:9843 with SMTP id
 gf7-20020a056214250700b0069925279843mr2894233qvb.5.1714531465674; 
 Tue, 30 Apr 2024 19:44:25 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 058/149] board: engicam: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:45 -0600
Message-Id: <20240501024316.1767971-58-trini@konsulko.com>
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Suniel Mahesh <sunil@amarulasolutions.com>
Cc: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
---
 board/engicam/common/board.c         | 1 -
 board/engicam/common/spl.c           | 1 -
 board/engicam/imx6q/imx6q.c          | 1 -
 board/engicam/imx6ul/imx6ul.c        | 1 -
 board/engicam/imx8mm/icore_mx8mm.c   | 1 -
 board/engicam/imx8mm/lpddr4_timing.c | 1 -
 board/engicam/imx8mm/spl.c           | 1 -
 board/engicam/imx8mp/icore_mx8mp.c   | 1 -
 board/engicam/imx8mp/spl.c           | 1 -
 board/engicam/stm32mp1/spl.c         | 2 +-
 board/engicam/stm32mp1/stm32mp1.c    | 1 -
 11 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/board/engicam/common/board.c b/board/engicam/common/board.c
index df9149e0d6d8..8e0477c7a6e4 100644
--- a/board/engicam/common/board.c
+++ b/board/engicam/common/board.c
@@ -5,7 +5,6 @@
  * Author: Jagan Teki <jagan@amarulasolutions.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <hang.h>
diff --git a/board/engicam/common/spl.c b/board/engicam/common/spl.c
index f1ccdc334363..8bc80ee6baa8 100644
--- a/board/engicam/common/spl.c
+++ b/board/engicam/common/spl.c
@@ -5,7 +5,6 @@
  * Author: Jagan Teki <jagan@amarulasolutions.com>
  */
 
-#include <common.h>
 #include <image.h>
 #include <init.h>
 #include <serial.h>
diff --git a/board/engicam/imx6q/imx6q.c b/board/engicam/imx6q/imx6q.c
index e6c888fcfde1..d799fe6526af 100644
--- a/board/engicam/imx6q/imx6q.c
+++ b/board/engicam/imx6q/imx6q.c
@@ -5,7 +5,6 @@
  * Author: Jagan Teki <jagan@amarulasolutions.com>
  */
 
-#include <common.h>
 
 #include <asm/io.h>
 #include <asm/gpio.h>
diff --git a/board/engicam/imx6ul/imx6ul.c b/board/engicam/imx6ul/imx6ul.c
index 412d6c302e88..24d654445dbd 100644
--- a/board/engicam/imx6ul/imx6ul.c
+++ b/board/engicam/imx6ul/imx6ul.c
@@ -5,7 +5,6 @@
  * Author: Jagan Teki <jagan@amarulasolutions.com>
  */
 
-#include <common.h>
 #include <mmc.h>
 
 #include <asm/io.h>
diff --git a/board/engicam/imx8mm/icore_mx8mm.c b/board/engicam/imx8mm/icore_mx8mm.c
index 320388faae3e..236337546aee 100644
--- a/board/engicam/imx8mm/icore_mx8mm.c
+++ b/board/engicam/imx8mm/icore_mx8mm.c
@@ -5,7 +5,6 @@
  * Author: Jagan Teki <jagan@amarulasolutions.com>
  */
 
-#include <common.h>
 #include <miiphy.h>
 #include <netdev.h>
 
diff --git a/board/engicam/imx8mm/lpddr4_timing.c b/board/engicam/imx8mm/lpddr4_timing.c
index 821212740bcc..fcd45c158f22 100644
--- a/board/engicam/imx8mm/lpddr4_timing.c
+++ b/board/engicam/imx8mm/lpddr4_timing.c
@@ -6,7 +6,6 @@
  * Align with uboot-imx_v2018.03_4.14.78_1.0.0_ga
  */
 
-#include <common.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/lpddr4_define.h>
 
diff --git a/board/engicam/imx8mm/spl.c b/board/engicam/imx8mm/spl.c
index af9044a3c2b0..d51ae241e85c 100644
--- a/board/engicam/imx8mm/spl.c
+++ b/board/engicam/imx8mm/spl.c
@@ -5,7 +5,6 @@
  * Author: Jagan Teki <jagan@amarulasolutions.com>
  */
 
-#include <common.h>
 #include <hang.h>
 #include <init.h>
 #include <log.h>
diff --git a/board/engicam/imx8mp/icore_mx8mp.c b/board/engicam/imx8mp/icore_mx8mp.c
index 5f820cc8dd70..e2ed70caa43a 100644
--- a/board/engicam/imx8mp/icore_mx8mp.c
+++ b/board/engicam/imx8mp/icore_mx8mp.c
@@ -8,7 +8,6 @@
  * Jagan Teki <jagan@amarulasolutions.com>
  */
 
-#include <common.h>
 #include <env.h>
 #include <errno.h>
 #include <init.h>
diff --git a/board/engicam/imx8mp/spl.c b/board/engicam/imx8mp/spl.c
index 36b83aace392..cd31aa6041d1 100644
--- a/board/engicam/imx8mp/spl.c
+++ b/board/engicam/imx8mp/spl.c
@@ -8,7 +8,6 @@
  * Jagan Teki <jagan@amarulasolutions.com>
  */
 
-#include <common.h>
 #include <hang.h>
 #include <init.h>
 #include <log.h>
diff --git a/board/engicam/stm32mp1/spl.c b/board/engicam/stm32mp1/spl.c
index 2b7779cc01dd..bb2bd446aa8c 100644
--- a/board/engicam/stm32mp1/spl.c
+++ b/board/engicam/stm32mp1/spl.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2020 Amarula Solutions(India)
  */
 
-#include <common.h>
+#include <linux/types.h>
 
 /* board early initialisation in board_f: need to use global variable */
 static u32 opp_voltage_mv __section(".data");
diff --git a/board/engicam/stm32mp1/stm32mp1.c b/board/engicam/stm32mp1/stm32mp1.c
index 5223e9bae8d7..bc2af66d8e96 100644
--- a/board/engicam/stm32mp1/stm32mp1.c
+++ b/board/engicam/stm32mp1/stm32mp1.c
@@ -6,7 +6,6 @@
  * Author: Jagan Teki <jagan@amarulasolutions.com>
  */
 
-#include <common.h>
 #include <env.h>
 #include <env_internal.h>
 #include <syscon.h>
-- 
2.34.1

