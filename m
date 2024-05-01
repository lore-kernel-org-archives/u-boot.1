Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEC8C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:07:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E8A888CA0;
	Wed,  1 May 2024 04:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DfGgrGUx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 214D688CA2; Wed,  1 May 2024 04:45:46 +0200 (CEST)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D66D188C10
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4dacb2ad01dso1653476e0c.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531542; x=1715136342; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uRPttOoK3+l11UmeEqKQrZmy5GaxRhxonVEbRxRzYEU=;
 b=DfGgrGUxqvO9o5TpK4zNUAJM9apo17GUWoq4tSA5KAV/25V1etaENAd1kHUgLFYlUP
 qJbpf6FAPQ3PjhdJl0fx9dOYNrBtq9s/wHtK26lsADmyPeMS33CeKaebiDMWPGXFBleR
 fE+WXBllKpwmkEu4l5TgCKhriGBICfdGc4yLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531542; x=1715136342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uRPttOoK3+l11UmeEqKQrZmy5GaxRhxonVEbRxRzYEU=;
 b=S235vEyHv13QAJXpsdfCe0cIcYB7e24nIwnJBK9qxqlPU3hzwtVQDGw9uZmKha3tL4
 PLb4bDSiC6JDC3XL9gDYDEh18CFzROiM/rKP2Qj7H7aOb6Td7tsU/wDhgvTwYzNplwVM
 2ZSGx8CilMUK6Bj4/VuhYP8KQ70YVsi7oHzjxN6aDnka0hYbA8ZfOjGZIE5Sah1cGXof
 Zl5XULeljIw8gra8OVIDsaxO1Z/CPBjxGYiiLOBd9tDtIBKzZm0x21gFDNXgQqES2+Gs
 +QgdDjnv3N6wtW/Xb3WwZZ+cIMDMOVtCPQXvVSw7oJbUprc76/DsgJHKH3IVif2uzpta
 PWmw==
X-Gm-Message-State: AOJu0YyI4aS/i21KUPCFz8dJ/M8mKunEGc98C5D/hMu1k3o+6vlYiggc
 +vZXPL7l2+G1m7fnzJzypuInWaTzTN+epy4IkOGAHys+9exa9xCaf0uVMetLE0CqMnTvqDUFdtF
 7JXEmVxLO
X-Google-Smtp-Source: AGHT+IGQe9LaWNMfJLhGZf7YXvAMifbJ2/NWEQSogNSH6+vmsyh9Z0pJaQiAajlKLic5AhndiGUQvg==
X-Received: by 2002:a05:6102:50a2:b0:47c:cbf:d124 with SMTP id
 bl34-20020a05610250a200b0047c0cbfd124mr2200188vsb.28.1714531542512; 
 Tue, 30 Apr 2024 19:45:42 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Kamil Lulko <kamil.lulko@gmail.com>, Vikas Manocha <vikas.manocha@st.com>,
 Dillon Min <dillon.minfei@gmail.com>
Subject: [PATCH 126/149] board: st: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:42:53 -0600
Message-Id: <20240501024316.1767971-126-trini@konsulko.com>
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
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Kamil Lulko <kamil.lulko@gmail.com>
Cc: Vikas Manocha <vikas.manocha@st.com>
Cc: Dillon Min <dillon.minfei@gmail.com>
---
 board/st/common/cmd_stboard.c                        | 1 -
 board/st/common/stm32mp_dfu.c                        | 1 -
 board/st/common/stm32mp_dfu_virt.c                   | 1 -
 board/st/common/stpmic1.c                            | 1 -
 board/st/common/stusb160x.c                          | 1 -
 board/st/stih410-b2260/board.c                       | 1 -
 board/st/stm32f429-discovery/led.c                   | 1 -
 board/st/stm32f429-discovery/stm32f429-discovery.c   | 1 -
 board/st/stm32f429-evaluation/stm32f429-evaluation.c | 1 -
 board/st/stm32f469-discovery/stm32f469-discovery.c   | 1 -
 board/st/stm32f746-disco/stm32f746-disco.c           | 2 +-
 board/st/stm32h743-disco/stm32h743-disco.c           | 1 -
 board/st/stm32h743-eval/stm32h743-eval.c             | 1 -
 board/st/stm32h750-art-pi/stm32h750-art-pi.c         | 1 -
 board/st/stm32mp1/spl.c                              | 1 -
 board/st/stm32mp1/stm32mp1.c                         | 1 -
 16 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/board/st/common/cmd_stboard.c b/board/st/common/cmd_stboard.c
index c8c0bad5da16..50da063051b8 100644
--- a/board/st/common/cmd_stboard.c
+++ b/board/st/common/cmd_stboard.c
@@ -30,7 +30,6 @@
  */
 
 #ifndef CONFIG_SPL_BUILD
-#include <common.h>
 #include <command.h>
 #include <console.h>
 #include <misc.h>
diff --git a/board/st/common/stm32mp_dfu.c b/board/st/common/stm32mp_dfu.c
index 77edb86e78c1..1db8e45480e1 100644
--- a/board/st/common/stm32mp_dfu.c
+++ b/board/st/common/stm32mp_dfu.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020, STMicroelectronics - All Rights Reserved
  */
 
-#include <common.h>
 #include <blk.h>
 #include <dm.h>
 #include <dfu.h>
diff --git a/board/st/common/stm32mp_dfu_virt.c b/board/st/common/stm32mp_dfu_virt.c
index f0f99605796a..4049d72bf9d5 100644
--- a/board/st/common/stm32mp_dfu_virt.c
+++ b/board/st/common/stm32mp_dfu_virt.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2023, STMicroelectronics - All Rights Reserved
  */
 
-#include <common.h>
 #include <dfu.h>
 #include <dm.h>
 #include <misc.h>
diff --git a/board/st/common/stpmic1.c b/board/st/common/stpmic1.c
index 969ad484864d..45c2bb5bceac 100644
--- a/board/st/common/stpmic1.c
+++ b/board/st/common/stpmic1.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY LOGC_BOARD
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <asm/io.h>
diff --git a/board/st/common/stusb160x.c b/board/st/common/stusb160x.c
index f0385e5e3830..e1ad8b00717a 100644
--- a/board/st/common/stusb160x.c
+++ b/board/st/common/stusb160x.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_I2C_GENERIC
 
-#include <common.h>
 #include <dm.h>
 #include <i2c.h>
 
diff --git a/board/st/stih410-b2260/board.c b/board/st/stih410-b2260/board.c
index 82817571ae3d..a912712c9dd9 100644
--- a/board/st/stih410-b2260/board.c
+++ b/board/st/stih410-b2260/board.c
@@ -4,7 +4,6 @@
  * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <asm/cache.h>
diff --git a/board/st/stm32f429-discovery/led.c b/board/st/stm32f429-discovery/led.c
index 8dda6a97bd1c..4b8038341b9e 100644
--- a/board/st/stm32f429-discovery/led.c
+++ b/board/st/stm32f429-discovery/led.c
@@ -4,7 +4,6 @@
  * Kamil Lulko, <kamil.lulko@gmail.com>
  */
 
-#include <common.h>
 #include <status_led.h>
 #include <asm-generic/gpio.h>
 
diff --git a/board/st/stm32f429-discovery/stm32f429-discovery.c b/board/st/stm32f429-discovery/stm32f429-discovery.c
index 55e464cc7cf1..22d751b44d3d 100644
--- a/board/st/stm32f429-discovery/stm32f429-discovery.c
+++ b/board/st/stm32f429-discovery/stm32f429-discovery.c
@@ -10,7 +10,6 @@
  * Kamil Lulko, <kamil.lulko@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <init.h>
diff --git a/board/st/stm32f429-evaluation/stm32f429-evaluation.c b/board/st/stm32f429-evaluation/stm32f429-evaluation.c
index 25472f041fef..db59ebb838e7 100644
--- a/board/st/stm32f429-evaluation/stm32f429-evaluation.c
+++ b/board/st/stm32f429-evaluation/stm32f429-evaluation.c
@@ -4,7 +4,6 @@
  * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <init.h>
diff --git a/board/st/stm32f469-discovery/stm32f469-discovery.c b/board/st/stm32f469-discovery/stm32f469-discovery.c
index 9ed6c1e67680..134d207d95d8 100644
--- a/board/st/stm32f469-discovery/stm32f469-discovery.c
+++ b/board/st/stm32f469-discovery/stm32f469-discovery.c
@@ -4,7 +4,6 @@
  * Author(s): Patrice CHOTARD, <patrice.chotard@foss.st.com> for STMicroelectronics.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <init.h>
diff --git a/board/st/stm32f746-disco/stm32f746-disco.c b/board/st/stm32f746-disco/stm32f746-disco.c
index 0f9666008430..6d86e4fe7aab 100644
--- a/board/st/stm32f746-disco/stm32f746-disco.c
+++ b/board/st/stm32f746-disco/stm32f746-disco.c
@@ -4,7 +4,7 @@
  * Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <init.h>
 #include <log.h>
diff --git a/board/st/stm32h743-disco/stm32h743-disco.c b/board/st/stm32h743-disco/stm32h743-disco.c
index 4ca5e847212e..35ef9ff9e288 100644
--- a/board/st/stm32h743-disco/stm32h743-disco.c
+++ b/board/st/stm32h743-disco/stm32h743-disco.c
@@ -4,7 +4,6 @@
  * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <log.h>
diff --git a/board/st/stm32h743-eval/stm32h743-eval.c b/board/st/stm32h743-eval/stm32h743-eval.c
index 4ca5e847212e..35ef9ff9e288 100644
--- a/board/st/stm32h743-eval/stm32h743-eval.c
+++ b/board/st/stm32h743-eval/stm32h743-eval.c
@@ -4,7 +4,6 @@
  * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <log.h>
diff --git a/board/st/stm32h750-art-pi/stm32h750-art-pi.c b/board/st/stm32h750-art-pi/stm32h750-art-pi.c
index 0d39ce849a62..75aa4d139fb4 100644
--- a/board/st/stm32h750-art-pi/stm32h750-art-pi.c
+++ b/board/st/stm32h750-art-pi/stm32h750-art-pi.c
@@ -4,7 +4,6 @@
  * Author(s): Dillon Min <dillon.minfei@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <log.h>
diff --git a/board/st/stm32mp1/spl.c b/board/st/stm32mp1/spl.c
index 8b4a529f759a..d63dffd97e87 100644
--- a/board/st/stm32mp1/spl.c
+++ b/board/st/stm32mp1/spl.c
@@ -4,7 +4,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <power/pmic.h>
 #include <power/stpmic1.h>
 #include <asm/arch/sys_proto.h>
diff --git a/board/st/stm32mp1/stm32mp1.c b/board/st/stm32mp1/stm32mp1.c
index db15d78237ea..97532a8156ff 100644
--- a/board/st/stm32mp1/stm32mp1.c
+++ b/board/st/stm32mp1/stm32mp1.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY LOGC_BOARD
 
-#include <common.h>
 #include <adc.h>
 #include <bootm.h>
 #include <button.h>
-- 
2.34.1

