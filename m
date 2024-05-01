Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94ADFC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9C1F88A92;
	Wed,  1 May 2024 04:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OuC77tLx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4ED888A9C; Wed,  1 May 2024 04:43:33 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 536EF88A9E
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-69b44071a07so60766566d6.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531409; x=1715136209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NquNbQ2BsZPRZTvCt5zI27zqayzC+/I67tHC4X7QV2E=;
 b=OuC77tLxugkRzJ0OWB1fwu1FmOa2RvMGsO4nB/jo5R21WxcK6G/AUMckX668H5RxWP
 AwB7GjwSPZZr3UelmTJDmwzj7SpK9mJz4at3hrA94CiZos02puz5tCY70YlWIMecda5Z
 UPBOTxg6q4ZIWW9wxpTHa+JYqW6hS5M9UX13E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531409; x=1715136209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NquNbQ2BsZPRZTvCt5zI27zqayzC+/I67tHC4X7QV2E=;
 b=gKy/pJ8JeOZVhpPDqC6CGpPkFXpGaXfEAGjP9TNJvH6xKFTPHalTg2pEMWKc35CXZ6
 PZOhC0H49wwp9l8qH2aLQ1qzg0zf3rgIcMpwkGswdhYXuctcb9Bn9pwL9eMxJc4pUTib
 EwxI2+t9XnlSsiQjhNovCVFMUzxAszGIh7rGGPOvghbBszmLWzxy+dgJ3lBwZBsmExJj
 KdM1Rt5GnLrF+oUet1wB+2f3JqdAAFFGELcUNdxsF5/e1PkHReaqPEE53Zr6doFRVWVt
 XKQlLEI+KM9IuaX/8fdoXBK+yi0lKjDyYqoaZnf27gUuCZB+4tLasY1xt56ILaCeNNaL
 ddYg==
X-Gm-Message-State: AOJu0Yy/vyPOHEDr0B44rJWfahff4Xh9SLjaA2X+C0zB+/PYIPFAkSM/
 nvGmpVRJNki2T0Wq552cCK0WA/GjX7BX4YRG5oa69kSYRf7dz20PGj7smb0j3IaCfdbJS8Ry+lQ
 0K5DlRg==
X-Google-Smtp-Source: AGHT+IFuLr6BzH4dFu1B00J7tIy6EFIGUe4eAnzKZ9JhX8kbOw0EXQXxhsEW21lxmg7jykASmWPYuQ==
X-Received: by 2002:a05:6214:250f:b0:6a0:9783:ee74 with SMTP id
 gf15-20020a056214250f00b006a09783ee74mr1191184qvb.48.1714531408853; 
 Tue, 30 Apr 2024 19:43:28 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Tony Dinh <mibodhi@gmail.com>, Jason Cooper <u-boot@lakedaemon.net>,
 Siddarth Gore <gores@marvell.com>, Aaron Williams <awilliams@marvell.com>
Subject: [PATCH 010/149] board: Marvell: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:40:57 -0600
Message-Id: <20240501024316.1767971-10-trini@konsulko.com>
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
Cc: Stefan Roese <sr@denx.de>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Tony Dinh <mibodhi@gmail.com>
Cc: Jason Cooper <u-boot@lakedaemon.net>
Cc: Siddarth Gore <gores@marvell.com>
Cc: Aaron Williams <awilliams@marvell.com>
---
 arch/arm/mach-kirkwood/include/mach/mpp.h     | 2 ++
 board/Marvell/db-88f6720/db-88f6720.c         | 1 -
 board/Marvell/db-88f6820-amc/db-88f6820-amc.c | 2 +-
 board/Marvell/db-88f6820-gp/db-88f6820-gp.c   | 2 +-
 board/Marvell/db-mv784mp-gp/db-mv784mp-gp.c   | 1 -
 board/Marvell/db-xc3-24g4xg/db-xc3-24g4xg.c   | 1 -
 board/Marvell/dreamplug/dreamplug.c           | 1 -
 board/Marvell/guruplug/guruplug.c             | 1 -
 board/Marvell/mvebu_alleycat-5/board.c        | 2 +-
 board/Marvell/mvebu_armada-37xx/board.c       | 2 +-
 board/Marvell/mvebu_armada-8k/board.c         | 2 +-
 board/Marvell/octeontx2/soc-utils.c           | 1 -
 board/Marvell/openrd/openrd.c                 | 1 -
 board/Marvell/sheevaplug/sheevaplug.c         | 1 -
 14 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-kirkwood/include/mach/mpp.h b/arch/arm/mach-kirkwood/include/mach/mpp.h
index 4d1f58c0cbdf..e2757942590b 100644
--- a/arch/arm/mach-kirkwood/include/mach/mpp.h
+++ b/arch/arm/mach-kirkwood/include/mach/mpp.h
@@ -8,6 +8,8 @@
 #ifndef __KIRKWOOD_MPP_H
 #define __KIRKWOOD_MPP_H
 
+#include <linux/types.h>
+
 #define MPP(_num, _sel, _in, _out, _F6180, _F6190, _F6192, _F6281) ( \
 	/* MPP number */		((_num) & 0xff) | \
 	/* MPP select value */		(((_sel) & 0xf) << 8) | \
diff --git a/board/Marvell/db-88f6720/db-88f6720.c b/board/Marvell/db-88f6720/db-88f6720.c
index 26c30647fbb0..920421366f11 100644
--- a/board/Marvell/db-88f6720/db-88f6720.c
+++ b/board/Marvell/db-88f6720/db-88f6720.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <init.h>
 #include <miiphy.h>
 #include <net.h>
diff --git a/board/Marvell/db-88f6820-amc/db-88f6820-amc.c b/board/Marvell/db-88f6820-amc/db-88f6820-amc.c
index 122c63d11f99..0f92cc385bc8 100644
--- a/board/Marvell/db-88f6820-amc/db-88f6820-amc.c
+++ b/board/Marvell/db-88f6820-amc/db-88f6820-amc.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2015 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <i2c.h>
 #include <init.h>
 #include <miiphy.h>
diff --git a/board/Marvell/db-88f6820-gp/db-88f6820-gp.c b/board/Marvell/db-88f6820-gp/db-88f6820-gp.c
index 1edc1cb6515c..8f8b2720107a 100644
--- a/board/Marvell/db-88f6820-gp/db-88f6820-gp.c
+++ b/board/Marvell/db-88f6820-gp/db-88f6820-gp.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2015 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <i2c.h>
 #include <init.h>
 #include <miiphy.h>
diff --git a/board/Marvell/db-mv784mp-gp/db-mv784mp-gp.c b/board/Marvell/db-mv784mp-gp/db-mv784mp-gp.c
index 9e1fdecfca4d..6bca1f91a0a4 100644
--- a/board/Marvell/db-mv784mp-gp/db-mv784mp-gp.c
+++ b/board/Marvell/db-mv784mp-gp/db-mv784mp-gp.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2014 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <init.h>
 #include <miiphy.h>
 #include <net.h>
diff --git a/board/Marvell/db-xc3-24g4xg/db-xc3-24g4xg.c b/board/Marvell/db-xc3-24g4xg/db-xc3-24g4xg.c
index 0abdca1cd210..a7a84798a53b 100644
--- a/board/Marvell/db-xc3-24g4xg/db-xc3-24g4xg.c
+++ b/board/Marvell/db-xc3-24g4xg/db-xc3-24g4xg.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <init.h>
 #include <asm/global_data.h>
diff --git a/board/Marvell/dreamplug/dreamplug.c b/board/Marvell/dreamplug/dreamplug.c
index d15faa1cb7ff..381275061318 100644
--- a/board/Marvell/dreamplug/dreamplug.c
+++ b/board/Marvell/dreamplug/dreamplug.c
@@ -8,7 +8,6 @@
  * Written-by: Siddarth Gore <gores@marvell.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <netdev.h>
 #include <asm/arch/cpu.h>
diff --git a/board/Marvell/guruplug/guruplug.c b/board/Marvell/guruplug/guruplug.c
index ea87ded222e6..7c3cea22b936 100644
--- a/board/Marvell/guruplug/guruplug.c
+++ b/board/Marvell/guruplug/guruplug.c
@@ -5,7 +5,6 @@
  * Written-by: Siddarth Gore <gores@marvell.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <miiphy.h>
 #include <net.h>
diff --git a/board/Marvell/mvebu_alleycat-5/board.c b/board/Marvell/mvebu_alleycat-5/board.c
index 0c4f8e03b859..c1b7cc3b613c 100644
--- a/board/Marvell/mvebu_alleycat-5/board.c
+++ b/board/Marvell/mvebu_alleycat-5/board.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
+#include <config.h>
 #include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
index 1685b12b8478..df3fb6d21645 100644
--- a/board/Marvell/mvebu_armada-37xx/board.c
+++ b/board/Marvell/mvebu_armada-37xx/board.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2016 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <env.h>
diff --git a/board/Marvell/mvebu_armada-8k/board.c b/board/Marvell/mvebu_armada-8k/board.c
index a8899af6e5af..6d7042117424 100644
--- a/board/Marvell/mvebu_armada-8k/board.c
+++ b/board/Marvell/mvebu_armada-8k/board.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2016 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <i2c.h>
 #include <init.h>
diff --git a/board/Marvell/octeontx2/soc-utils.c b/board/Marvell/octeontx2/soc-utils.c
index 43a19a90717c..64eb95f3b400 100644
--- a/board/Marvell/octeontx2/soc-utils.c
+++ b/board/Marvell/octeontx2/soc-utils.c
@@ -5,7 +5,6 @@
  * https://spdx.org/licenses
  */
 
-#include <common.h>
 #include <dm.h>
 #include <malloc.h>
 #include <errno.h>
diff --git a/board/Marvell/openrd/openrd.c b/board/Marvell/openrd/openrd.c
index 581e2e084d6f..dda56a582b3e 100644
--- a/board/Marvell/openrd/openrd.c
+++ b/board/Marvell/openrd/openrd.c
@@ -10,7 +10,6 @@
  * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <miiphy.h>
 #include <net.h>
diff --git a/board/Marvell/sheevaplug/sheevaplug.c b/board/Marvell/sheevaplug/sheevaplug.c
index 26ee39ef77f9..23e761d5febf 100644
--- a/board/Marvell/sheevaplug/sheevaplug.c
+++ b/board/Marvell/sheevaplug/sheevaplug.c
@@ -6,7 +6,6 @@
  * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <netdev.h>
 #include <asm/global_data.h>
-- 
2.34.1

