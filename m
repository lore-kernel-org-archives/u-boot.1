Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0410BC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41F7E88AC1;
	Wed,  1 May 2024 04:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H66wRpq4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8681688AB6; Wed,  1 May 2024 04:43:47 +0200 (CEST)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1706E88A7E
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7ef2a623958so2072346241.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531423; x=1715136223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pkhtaHK2kNzUa+xXKMeVo2xZQADRbV6r2GOff6BaKzU=;
 b=H66wRpq4HVRc9wSzBr7A1GVx5dmq2ptWit5qvEinmuSiJMWwQahEZP/mM+RvOaB+8G
 pWSz7pr6uYMx9bI8j/+PvhuaZ2XwUkBWHOLnBz0/q/3ZKPVTfUshdFzHF3I9thpdN7Ru
 tsMQ6NJbXbdcB+rLwqohN2a1+J27omT0GBZOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531423; x=1715136223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pkhtaHK2kNzUa+xXKMeVo2xZQADRbV6r2GOff6BaKzU=;
 b=sLb9fo0jfL4swFo7dN9ME27gbaigYXCtR5OsDVCvf+EZUE4yP/ru2A/4TBOCqUI6yD
 KIugpY/xjwhJzQiofOrYYwDFzMF8n6IoUoK+4mF2QmRy7RGFj1QX/v7QSnVcLoOgqgWt
 DU5mWZ/irEaYuCJVXLMQDYESQCGT9OE8TB5pFZu/We/oZlt2MOx4ouXW6sNqmcaE3SnX
 y3xn0a2j+goQISMcpG9RAicsyhDjOnCnn+aN7tP400Io4eP2D1bOfLDiT3u9lBy7JfF3
 iUXs5KF8I90aT1ux62puMi1hAnueKh3YP58PKlhKVNHnZz72HcXzD+tkjQ4hx8cJ9dbT
 QzvA==
X-Gm-Message-State: AOJu0YxIyUg4/Q//tOlQe1TIG9kzdeziYsmmEae2t4c258tOC99rVlB1
 jaYVee2ZMrnF0AC1Po6xTmBwahdJDegtY+xmE7IwE1/eQwfGbl6glqaRTngfxKXqjrHrLMPL7PA
 wRZIXNQ==
X-Google-Smtp-Source: AGHT+IF0UIIjOMAGBNDOa/+DY4sgzW6eumW4B8xWRAac8WmxMO2RM84xR0rqaHWD77+I2yvhPwlOpg==
X-Received: by 2002:a05:6102:9c1:b0:47c:2a5c:c898 with SMTP id
 g1-20020a05610209c100b0047c2a5cc898mr1678670vsi.17.1714531423544; 
 Tue, 30 Apr 2024 19:43:43 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stelian Pop <stelian@popies.net>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Sandeep Sheriker M <sandeep.sheriker@microchip.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 021/149] board: atmel: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:08 -0600
Message-Id: <20240501024316.1767971-21-trini@konsulko.com>
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
Cc: Stelian Pop <stelian@popies.net>
Cc: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Durai Manickam KR <durai.manickamkr@microchip.com>
Cc: Sandeep Sheriker M <sandeep.sheriker@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Mihai Sain <mihai.sain@microchip.com>
---
 board/atmel/at91sam9260ek/at91sam9260ek.c           | 2 +-
 board/atmel/at91sam9261ek/at91sam9261ek.c           | 2 +-
 board/atmel/at91sam9263ek/at91sam9263ek.c           | 2 +-
 board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c     | 2 +-
 board/atmel/at91sam9n12ek/at91sam9n12ek.c           | 2 +-
 board/atmel/at91sam9rlek/at91sam9rlek.c             | 2 +-
 board/atmel/at91sam9x5ek/at91sam9x5ek.c             | 2 +-
 board/atmel/common/board.c                          | 1 -
 board/atmel/common/mac-spi-nor.c                    | 1 -
 board/atmel/common/mac_eeprom.c                     | 1 -
 board/atmel/common/video_display.c                  | 1 -
 board/atmel/sam9x60_curiosity/sam9x60_curiosity.c   | 1 -
 board/atmel/sam9x60ek/sam9x60ek.c                   | 2 +-
 board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c     | 1 -
 board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c | 2 +-
 board/atmel/sama5d29_curiosity/sama5d29_curiosity.c | 1 -
 board/atmel/sama5d2_icp/sama5d2_icp.c               | 2 +-
 board/atmel/sama5d2_ptc_ek/sama5d2_ptc_ek.c         | 2 +-
 board/atmel/sama5d2_xplained/sama5d2_xplained.c     | 1 -
 board/atmel/sama5d3_xplained/sama5d3_xplained.c     | 2 +-
 board/atmel/sama5d3xek/sama5d3xek.c                 | 2 +-
 board/atmel/sama5d4_xplained/sama5d4_xplained.c     | 2 +-
 board/atmel/sama5d4ek/sama5d4ek.c                   | 2 +-
 board/atmel/sama7g54_curiosity/sama7g54_curiosity.c | 1 -
 board/atmel/sama7g5ek/sama7g5ek.c                   | 2 +-
 25 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/board/atmel/at91sam9260ek/at91sam9260ek.c b/board/atmel/at91sam9260ek/at91sam9260ek.c
index b8e02f459031..48aec652c4a4 100644
--- a/board/atmel/at91sam9260ek/at91sam9260ek.c
+++ b/board/atmel/at91sam9260ek/at91sam9260ek.c
@@ -5,7 +5,7 @@
  * Lead Tech Design <www.leadtechdesign.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <debug_uart.h>
 #include <init.h>
 #include <net.h>
diff --git a/board/atmel/at91sam9261ek/at91sam9261ek.c b/board/atmel/at91sam9261ek/at91sam9261ek.c
index eab3a1308195..5d7a18379fae 100644
--- a/board/atmel/at91sam9261ek/at91sam9261ek.c
+++ b/board/atmel/at91sam9261ek/at91sam9261ek.c
@@ -5,7 +5,7 @@
  * Lead Tech Design <www.leadtechdesign.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <debug_uart.h>
 #include <init.h>
 #include <vsprintf.h>
diff --git a/board/atmel/at91sam9263ek/at91sam9263ek.c b/board/atmel/at91sam9263ek/at91sam9263ek.c
index 15f20b62f672..2b0b01798eae 100644
--- a/board/atmel/at91sam9263ek/at91sam9263ek.c
+++ b/board/atmel/at91sam9263ek/at91sam9263ek.c
@@ -5,7 +5,7 @@
  * Lead Tech Design <www.leadtechdesign.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <debug_uart.h>
 #include <init.h>
 #include <net.h>
diff --git a/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c b/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
index f53c1cf612d5..3bd94d0889da 100644
--- a/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
+++ b/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
@@ -5,7 +5,7 @@
  * Lead Tech Design <www.leadtechdesign.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <debug_uart.h>
 #include <init.h>
 #include <net.h>
diff --git a/board/atmel/at91sam9n12ek/at91sam9n12ek.c b/board/atmel/at91sam9n12ek/at91sam9n12ek.c
index a3e294c88fc8..afc0c0520e1f 100644
--- a/board/atmel/at91sam9n12ek/at91sam9n12ek.c
+++ b/board/atmel/at91sam9n12ek/at91sam9n12ek.c
@@ -4,7 +4,7 @@
  * Josh Wu <josh.wu@atmel.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <net.h>
 #include <vsprintf.h>
diff --git a/board/atmel/at91sam9rlek/at91sam9rlek.c b/board/atmel/at91sam9rlek/at91sam9rlek.c
index 11725f778b7d..214e917381e7 100644
--- a/board/atmel/at91sam9rlek/at91sam9rlek.c
+++ b/board/atmel/at91sam9rlek/at91sam9rlek.c
@@ -5,7 +5,7 @@
  * Lead Tech Design <www.leadtechdesign.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <debug_uart.h>
 #include <init.h>
 #include <vsprintf.h>
diff --git a/board/atmel/at91sam9x5ek/at91sam9x5ek.c b/board/atmel/at91sam9x5ek/at91sam9x5ek.c
index ab666b6be34f..e5688c6cf132 100644
--- a/board/atmel/at91sam9x5ek/at91sam9x5ek.c
+++ b/board/atmel/at91sam9x5ek/at91sam9x5ek.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2012 Atmel Corporation
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/board/atmel/common/board.c b/board/atmel/common/board.c
index c93c0e52e30d..55afd43d4f32 100644
--- a/board/atmel/common/board.c
+++ b/board/atmel/common/board.c
@@ -4,7 +4,6 @@
  *		      Wenyou Yang <wenyou.yang@microchip.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <w1.h>
diff --git a/board/atmel/common/mac-spi-nor.c b/board/atmel/common/mac-spi-nor.c
index ced27b65e63b..628f79581295 100644
--- a/board/atmel/common/mac-spi-nor.c
+++ b/board/atmel/common/mac-spi-nor.c
@@ -5,7 +5,6 @@
  * Author: Tudor Ambarus <tudor.ambarus@microchip.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <net.h>
diff --git a/board/atmel/common/mac_eeprom.c b/board/atmel/common/mac_eeprom.c
index e3ab78fb895b..97edb7a549d4 100644
--- a/board/atmel/common/mac_eeprom.c
+++ b/board/atmel/common/mac_eeprom.c
@@ -4,7 +4,6 @@
  *		      Wenyou Yang <wenyou.yang@microchip.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <i2c_eeprom.h>
diff --git a/board/atmel/common/video_display.c b/board/atmel/common/video_display.c
index a5049f4aad41..771888205814 100644
--- a/board/atmel/common/video_display.c
+++ b/board/atmel/common/video_display.c
@@ -4,7 +4,6 @@
  *		      Wenyou Yang <wenyou.yang@microchip.com>
  */
 
-#include <common.h>
 #include <atmel_lcd.h>
 #include <dm.h>
 #include <init.h>
diff --git a/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c b/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
index f53d359404ef..e75043ec00f9 100644
--- a/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
+++ b/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
@@ -5,7 +5,6 @@
  * Author: Durai Manickam KR <durai.manickamkr@microchip.com>
  */
 
-#include <common.h>
 #include <debug_uart.h>
 #include <fdtdec.h>
 #include <init.h>
diff --git a/board/atmel/sam9x60ek/sam9x60ek.c b/board/atmel/sam9x60ek/sam9x60ek.c
index 3fbfca4acc96..2e5073f02b3e 100644
--- a/board/atmel/sam9x60ek/sam9x60ek.c
+++ b/board/atmel/sam9x60ek/sam9x60ek.c
@@ -5,7 +5,7 @@
  * Author: Sandeep Sheriker M <sandeep.sheriker@microchip.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c b/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
index 329eac7223ad..36995a927cf1 100644
--- a/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
+++ b/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
@@ -4,7 +4,6 @@
  *		      Wenyou.Yang <wenyou.yang@microchip.com>
  */
 
-#include <common.h>
 #include <debug_uart.h>
 #include <fdtdec.h>
 #include <init.h>
diff --git a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
index 6e41017af17c..c775d593e58c 100644
--- a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
+++ b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
@@ -5,7 +5,7 @@
  * Author: Nicolas Ferre <nicolas.ferre@microcihp.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <debug_uart.h>
 #include <init.h>
 #include <asm/global_data.h>
diff --git a/board/atmel/sama5d29_curiosity/sama5d29_curiosity.c b/board/atmel/sama5d29_curiosity/sama5d29_curiosity.c
index d0679317fb2d..8759ff6f01ac 100644
--- a/board/atmel/sama5d29_curiosity/sama5d29_curiosity.c
+++ b/board/atmel/sama5d29_curiosity/sama5d29_curiosity.c
@@ -6,7 +6,6 @@
  *
  */
 
-#include <common.h>
 #include <debug_uart.h>
 #include <init.h>
 #include <asm/global_data.h>
diff --git a/board/atmel/sama5d2_icp/sama5d2_icp.c b/board/atmel/sama5d2_icp/sama5d2_icp.c
index fabe492715ab..986da01639f9 100644
--- a/board/atmel/sama5d2_icp/sama5d2_icp.c
+++ b/board/atmel/sama5d2_icp/sama5d2_icp.c
@@ -4,7 +4,7 @@
  *		      Eugen Hristev <eugen.hristev@microchip.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <debug_uart.h>
 #include <init.h>
 #include <asm/global_data.h>
diff --git a/board/atmel/sama5d2_ptc_ek/sama5d2_ptc_ek.c b/board/atmel/sama5d2_ptc_ek/sama5d2_ptc_ek.c
index 854715ea2269..438829df82d5 100644
--- a/board/atmel/sama5d2_ptc_ek/sama5d2_ptc_ek.c
+++ b/board/atmel/sama5d2_ptc_ek/sama5d2_ptc_ek.c
@@ -4,7 +4,7 @@
  *		      Wenyou Yang <wenyou.yang@microchip.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <debug_uart.h>
 #include <dm.h>
 #include <i2c.h>
diff --git a/board/atmel/sama5d2_xplained/sama5d2_xplained.c b/board/atmel/sama5d2_xplained/sama5d2_xplained.c
index aa522075691c..c8a8eb49826b 100644
--- a/board/atmel/sama5d2_xplained/sama5d2_xplained.c
+++ b/board/atmel/sama5d2_xplained/sama5d2_xplained.c
@@ -4,7 +4,6 @@
  *		      Wenyou.Yang <wenyou.yang@atmel.com>
  */
 
-#include <common.h>
 #include <debug_uart.h>
 #include <init.h>
 #include <asm/global_data.h>
diff --git a/board/atmel/sama5d3_xplained/sama5d3_xplained.c b/board/atmel/sama5d3_xplained/sama5d3_xplained.c
index ce73a801e501..54cc3c4d9003 100644
--- a/board/atmel/sama5d3_xplained/sama5d3_xplained.c
+++ b/board/atmel/sama5d3_xplained/sama5d3_xplained.c
@@ -4,7 +4,7 @@
  *		      Bo Shen <voice.shen@atmel.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/board/atmel/sama5d3xek/sama5d3xek.c b/board/atmel/sama5d3xek/sama5d3xek.c
index 660a6b9d5835..f2e1242fcb0f 100644
--- a/board/atmel/sama5d3xek/sama5d3xek.c
+++ b/board/atmel/sama5d3xek/sama5d3xek.c
@@ -4,7 +4,7 @@
  * Bo Shen <voice.shen@atmel.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/board/atmel/sama5d4_xplained/sama5d4_xplained.c b/board/atmel/sama5d4_xplained/sama5d4_xplained.c
index 780aba15ab1d..09ca16ca88ce 100644
--- a/board/atmel/sama5d4_xplained/sama5d4_xplained.c
+++ b/board/atmel/sama5d4_xplained/sama5d4_xplained.c
@@ -4,7 +4,7 @@
  *		      Bo Shen <voice.shen@atmel.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/board/atmel/sama5d4ek/sama5d4ek.c b/board/atmel/sama5d4ek/sama5d4ek.c
index 2226906a3b3d..1f8b85f0614e 100644
--- a/board/atmel/sama5d4ek/sama5d4ek.c
+++ b/board/atmel/sama5d4ek/sama5d4ek.c
@@ -4,7 +4,7 @@
  *		      Bo Shen <voice.shen@atmel.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/board/atmel/sama7g54_curiosity/sama7g54_curiosity.c b/board/atmel/sama7g54_curiosity/sama7g54_curiosity.c
index 33cd0903d253..b05c9754c964 100644
--- a/board/atmel/sama7g54_curiosity/sama7g54_curiosity.c
+++ b/board/atmel/sama7g54_curiosity/sama7g54_curiosity.c
@@ -6,7 +6,6 @@
  *
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/board/atmel/sama7g5ek/sama7g5ek.c b/board/atmel/sama7g5ek/sama7g5ek.c
index 295fd079dcf7..c07115a21195 100644
--- a/board/atmel/sama7g5ek/sama7g5ek.c
+++ b/board/atmel/sama7g5ek/sama7g5ek.c
@@ -4,7 +4,7 @@
  *		      Eugen Hristev <eugen.hristev@microchip.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <debug_uart.h>
 #include <init.h>
 #include <asm/global_data.h>
-- 
2.34.1

